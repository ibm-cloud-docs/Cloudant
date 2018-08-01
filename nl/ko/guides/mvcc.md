---

copyright:
  years: 2015, 2018
lastupdated: "2018-06-07"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

# 문서 버전화 및 MVCC

[다중 버전 동시성 제어(MVCC) ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://en.wikipedia.org/wiki/Multiversion_concurrency_control){:new_window}는
데이터베이스의 클러스터에 있는 모든 노드가 특정 문서의 [최신 버전](../api/document.html)만 포함하도록 하기 위해 {{site.data.keyword.cloudantfull}}데이터베이스가 사용하는 방법입니다.
{:shortdesc}

{{site.data.keyword.cloudant_short_notm}} 데이터베이스는 [결과적으로 일관](cap_theorem.html)되므로, 이전 문서 간 동기화로 인해 노드 간에 불일치가 발생하는 것을 방지해야 합니다.

다중 버전 동시성 제어(MVCC)는 {{site.data.keyword.cloudant_short_notm}} 데이터베이스에 대한 동시 읽기 및 쓰기 액세스를 가능하게 합니다.
MVCC는 [낙관적 동시성 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](http://en.wikipedia.org/wiki/Optimistic_concurrency_control){:new_window}의 한 형태입니다.
데이터베이스가 읽기 또는 쓰기 오퍼레이션을 잠글 필요가 없으므로 이는 {{site.data.keyword.cloudant_short_notm}} 데이터베이스의 읽기 및 쓰기 오퍼레이션을 더 빠르게 만들어 줍니다.
MVCC는 또한 {{site.data.keyword.cloudant_short_notm}} 데이터베이스 노드 간 동기화를 가능하게 합니다.

## 개정판

{{site.data.keyword.cloudant_short_notm}} 데이터베이스에 있는 모든 문서에는 해당 개정 번호를 표시하는 `_rev` 필드가 있습니다.

개정 번호는 문서를 삽입하거나 수정할 때 서버에 의해 문서에 추가됩니다.
문서를 변경하거나 읽을 때는 서버 응답에 이 번호가 포함됩니다.
`_rev` 값은 단순 카운터와 문서 해시의 조합을 사용하여 생성됩니다.

개정 번호의 두 가지 주 용도는 다음 항목에 도움을 주는 것입니다.

1.  서버 간에 어느 문서를 복제해야 하는지 판별합니다.
2.  클라이언트가 문서의 최신 버전을 수정하려 하는지 확인합니다.

[문서를 업데이트](../api/document.html#update)할 때는 이전 `_rev`를 지정해야 하며, 이렇게 하지 않으면 요청이 실패하고 [409 오류](../api/http.html#409)가 리턴됩니다.

>   **참고**: `_rev`를 사용하여 버전 제어 시스템을 빌드하지 마십시오.
    이는 이 번호가 서버에 의해 사용되는 내부 값이기 때문입니다.
    또한 문서의 이전 개정판은 임시 항목으로, 정기적으로 제거됩니다.

`_rev`를 사용하여 특정 개정판을 조회할 수 있으나, 이전 개정판은 [컴팩션 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](http://en.wikipedia.org/wiki/Data_compaction){:new_window}이라 하는
프로세스에 의해 정기적으로 삭제됩니다.
컴팩션의 영향으로 사용자는 문서의 개정 히스토리를 획득하기 위해 문서의 `_rev`를 사용하여 특정 문서 개정판을 조회할 때 성공적인 응답을 기대할 수 없습니다.
문서의 버전 히스토리가 필요한 경우에는 각 개정판에 대해 [새 문서를 작성](../api/document.html#documentCreate)하여 이를 획득할 수 있습니다.

## 분산 데이터베이스 및 충돌

분산 데이터베이스는 자신 또한 분산되어 있는 {{site.data.keyword.cloudant_short_notm}}의 주 데이터베이스에 대한 상시 연결 없이 작동하므로, 동일한 이전 버전을 기반으로 한 업데이트가 여전히 충돌할 수 있습니다.

충돌을 찾으려면 문서를 검색할 때 조회 매개변수 [`conflicts=true`](../api/database.html#get-changes)를 추가하십시오.
응답에 모든 충돌 개정판이 있는 `_conflicts` 배열이 포함됩니다.

데이터베이스 내 여러 문서의 충돌을 찾으려면 보기를 작성하십시오.

다음 map 함수는 충돌이 있는 모든 문서의 모든 충돌하는 개정판을 출력하는 예제입니다.

_충돌이 있는 문서를 찾는 map 함수의 예:_

```javascript
function (doc) {
    if (doc._conflicts) {
        emit(null, [doc._rev].concat(doc._conflicts));
    }
}
```
{:codeblock}

사용자는 이 보기를 주기적으로 조회하여 필요에 따라 충돌을 해결하거나 각 복제 후에 이 보기를 조회할 수 있습니다.

## 충돌을 해결하는 방법

충돌을 찾은 후에는 이를 네 단계로 해결할 수 있습니다.

1.  충돌하는 개정판을 [가져옵니다](#get-conflicting-revisions).
2.  개정판을 애플리케이션에 [병합](#merge-the-changes)하거나 사용자에게 무엇을 수행할지 묻습니다.
3.  새 개정판을 [업로드](#upload-the-new-revision)합니다.
4.  이전 개정판을 [삭제](#delete-old-revisions)합니다.

이 작업의 수행 방법에 대한 예를 들어 보겠습니다.
온라인 상점의 제품에 대한 데이터베이스가 있다고 가정해 보십시오.
이 문서의 첫 번째 버전은 다음 예와 같습니다.

```json
{
    "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "1-7438df87b632b312c53a08361a7c3299",
    "name": "Samsung Galaxy S4",
    "description": "",
    "price": 650
}
```
{:codeblock}

이 문서에 설명이 아직 없으므로, 누군가가 설명을 추가할 수 있습니다.

_설명을 추가하여 작성된 문서의 두 번째 버전:_

```json
{
    "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "2-61ae00e029d4f5edd2981841243ded13",
    "name": "Samsung Galaxy S4",
    "description": "Latest smartphone from Samsung",
    "price": 650
}
```
{:codeblock}

동시에, 복제된 데이터베이스에 대해 작업하던 누군가 가격을 낮춥니다.

_`price` 값이 다르므로 이전 개정판과 충돌하는 다른 개정판:_

```json
{
    "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "2-f796915a291b37254f6df8f6f3389121",
    "name": "Samsung Galaxy S4",
    "description": "",
    "price": 600
}
```
{:codeblock}

그 후 두 데이터베이스가 복제되었습니다.
문서 버전의 차이로 인해 충돌이 발생합니다.

### 충돌하는 개정판 가져오기

`conflicts=true` 옵션을 사용하여 충돌이 있는 문서를 식별합니다.

_충돌이 있는 문서 찾기의 예:_

```http
http://$ACCOUNT.cloudant.com/products/$_ID?conflicts=true
```
{:codeblock}

_문서에 영향을 주는 충돌하는 개정판을 보여주는 응답 예:_

```json
{
    "_id":"74b2be56045bed0c8c9d24b939000dbe",
    "_rev":"2-f796915a291b37254f6df8f6f3389121",
    "name":"Samsung Galaxy S4",
    "description":"",
    "price":600,
    "_conflicts":["2-61ae00e029d4f5edd2981841243ded13"]
}
```
{:codeblock}

가격이 변경된 버전이 임의로 문서의 최신 버전으로 선택되었으며 `_conflicts` 배열에 충돌이 있는 다른 버전의 ID가 제공되어 이 버전과의 충돌이 표기됩니다.
대부분의 경우 이 배열에는 하나의 요소만 있지만, 여러 충돌하는 개정판이 있는 경우도 있습니다.

### 변경사항 병합

변경 내용 확인을 위해 개정판을 비교하기 위해서, 애플리케이션은 데이터베이스에서 모든 버전을 가져옵니다.

_데이터베이스에서 문서의 모든 버전을 검색하는 명령의 예:_

```http
http://$ACCOUNT.cloudant.com/products/$_ID
http://$ACCOUNT.cloudant.com/products/$_ID?rev=2-61ae00e029d4f5edd2981841243ded13
http://$ACCOUNT.cloudant.com/products/$_ID?rev=1-7438df87b632b312c53a08361a7c3299
```
{:codeblock}

충돌하는 변경사항이 문서의 서로 다른 필드이므로, 이는 병합하기 쉽습니다.

복잡한 충돌의 경우에는 다른 해결 전략이 필요할 수 있습니다.

*   기반 시간: 첫 번째 또는 마지막 편집본을 사용합니다.
*   사용자 개입: 사용자에게 충돌을 보고하고 사용자가 최적의 해결 방법을 결정하도록 합니다.
*   정교한 알고리즘: 테스트 필드의 3방향 병합 등.

변경사항 병합을 구현하는 방빕에 대한 실제 예는 [샘플 코드가 포함된 프로젝트 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://github.com/glynnbird/deconflict){:new_window}를 참조하십시오.

### 새 개정판 업로드

다음 단계는 충돌을 해결하는 문서를 작성하고 이를 사용하여 데이터베이스를 업데이트하는 것입니다.

_두 충돌하는 개정판의 변경사항을 병합하는 문서의 예:_

```json
{
    "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "3-daaecd7213301a1ad5493186d6916755",
    "name": "Samsung Galaxy S4",
    "description": "Latest smartphone from Samsung",
    "price": 600
}
```
{:codeblock}

### 이전 개정판 삭제

마지막으로, 삭제할 개정판을 포함하는 `DELETE` 요청을 URL에 전송하여 이전 개정판을 삭제합니다.

_이전 문서 개정판을 삭제하는 요청의 HTTP를 사용한 예:_

```http
DELETE https://$ACCOUNT.cloudant.com/products/$_ID?rev=2-61ae00e029d4f5edd2981841243ded13
```
{:codeblock}

_이전 문서 개정판을 삭제하는 요청의 명령행을 사용한 예:_

```sh
curl "https://$ACCOUNT.cloudant.com/products/$_ID?rev=2-f796915a291b37254f6df8f6f3389121" -X DELETE
```
{:codeblock}

이 시점에서, 문서에 영향을 주는 충돌은 해결됩니다.
`conflicts` 매개변수를 `true`로 설정하여 문서에 대해 다시 `GET` 오퍼레이션을 수행함으로써 이를 확인할 수 있습니다.
