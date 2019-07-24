---

copyright:
  years: 2015, 2019
lastupdated: "2019-06-12"

keywords: find conflicts, resolve conflicts, merge changes, upload new revision, delete revision

subcollection: cloudant

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:tip: .tip}
{:note: .note}
{:important: .important}
{:deprecated: .deprecated}

<!-- Acrolinx: 2018-05-07 -->

# 충돌
{: #conflicts}

둘 이상의 위치에 데이터 사본이 저장되어 있는 분산 데이터베이스의 경우 기본적인 네트워크 및 시스템 특성상 한 위치에 저장된 문서를 변경하면 데이터베이스의 다른 사본을 즉각 업데이트하거나 복제하지 못할 수 있습니다.

즉, 문서의 여러 사본에 독립적인 업데이트를 수행하면 문서의 정확한 최종 컨텐츠에 '충돌'이나 불일치가 생길 수 있습니다.

{{site.data.keyword.cloudantfull}}는 잠재적 문제점을 사용자에게 경고하여 충돌을 방지하도록 도와줍니다.
문제가 있는 업데이트 요청에 대한 [`409` 응답](/docs/services/Cloudant?topic=cloudant-http#http-status-codes)을 리턴하여 경고합니다.
그러나 `409` 응답은 네트워크에 현재 연결되어 있지 않은 시스템에서 데이터베이스 업데이트가 요청된 경우에는 수신되지 않을 수도 있습니다.
예를 들어 인터넷에 연결이 일시적으로 끊긴 모바일 디바이스에 데이터베이스가 있다면 그 시점에서 기타 잠재적으로 충돌할 수 있는 업데이트가 수행되었는지를 확인하는 것은 불가능합니다.

충돌 상황에서 문서를 요청해도 예상대로 {{site.data.keyword.cloudant_short_notm}}가 문서를 리턴합니다.
그러나 리턴되는 버전은 여러 인수를 고려한 내부 알고리즘에 의해 결정됩니다. 따라서 리턴된 문서가 가장 최근 문서가 아닐 수도 있음을 가정해야 합니다.

충돌을 확인하지 않거나 충돌 문제를 해결하지 않으면 {{site.data.keyword.cloudant_short_notm}} 데이터베이스에 여러 문제가 나타나기 시작합니다.

* 문서의 충돌이 점점 더 많아지므로 문서 컨텐츠의 불일치도 증가합니다.
* 충돌이 해결될 때까지 모든 충돌 문서가 유지되므로 데이터베이스 크기가 증가합니다.
* 충돌된 문서의 '가장 가능한' 버전을 식별하기 위해 {{site.data.keyword.cloudant_short_notm}}가 각각의 모든 요청에 응답하여 작업을 더 많이 하게 되므로 성능이 저하됩니다.

다음 제안된 조치는 충돌을 확인하고 해결해야 하는 경우를 판별하도록 도와줄 수 있습니다.

<table>
<tr>
<th>애플리케이션 특성</th>
<th>문서 업데이트 빈도</th>
<th>검색 시 충돌 확인 여부</th>
<th>업데이트 시 충돌 확인 여부</th>
</tr>
<tr>
<td>항상 네트워크에 연결(예: 서버)</td>
<td>자주</td>
<td>Y</td>
<td>-</td>
</tr>
<tr>
<td>항상 네트워크에 연결</td>
<td>가끔</td>
<td>-</td>
<td>Y</td>
</tr>
<tr>
<td>자주 네트워크에 연결되지만 항상은 아님(예: 랩탑)</td>
<td>자주</td>
<td>-</td>
<td>Y</td>
</tr>
<tr>
<td>자주 네트워크에 연결되지만 항상은 아님</td>
<td>가끔</td>
<td>-</td>
<td>Y</td>
</tr>
<tr>
<td>가끔 네트워크에 연결(예: 태블릿)</td>
<td>자주</td>
<td>-</td>
<td>Y</td>
</tr>
</table>

## 충돌 찾기
{: #finding-conflicts}

문서에 영향을 줄 수 있는 충돌을 찾으려면 문서를 검색할 때 조회 매개변수 `conflicts=true`를 추가하십시오.
리턴된 결과 문서는 `_conflicts` 배열을 포함하며 이 배열에는 충돌하는 모든 개정판의 목록이 있습니다.

> 문서 충돌을 찾기 위한 맵핑 기능 예:

```
function (doc) {
  if (doc._conflicts) {
    emit(null, [doc._rev].concat(doc._conflicts));
    }
}
```

데이터베이스 내 여러 문서의 충돌을 찾으려면 [보기](/docs/services/Cloudant?topic=cloudant-views-mapreduce#views-mapreduce)를 작성하십시오.
제공된 예와 같이 맵핑 기능을 사용하여 충돌이 있는 모든 문서에 대한 모든 개정판을 찾을 수 있습니다.

이러한 보기가 있으면 필요에 따라 이를 사용하여 충돌을 찾고 해결할 수 있습니다.
또는 충돌을 식별하고 즉시 해결하기 위해 각 복제 후에 보기를 조회할 수 있습니다.

## 충돌을 해결하는 방법
{: #how-to-resolve-conflicts}

충돌을 찾은 후에는 다음 네 단계로 해결할 수 있습니다.

1.	충돌하는 개정판을 [가져옵니다](#get-conflicting-revisions).
2.	개정판을 애플리케이션에 [병합](#merge-the-changes)하거나 사용자에게 무엇을 수행할지 묻습니다.
3.	새 개정판을 [업로드](#upload-the-new-revision)합니다.
4.	이전 개정판을 [삭제](#delete-old-revisions)합니다.

> 예제 문서 - 첫 번째 버전

```json
{
  "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "1-7438df87b632b312c53a08361a7c3299",
    "name": "Samsung Galaxy S4",
    "description": "",
    "price": 650
}
```

이 작업의 수행 방법에 대한 예를 들어 보겠습니다.
온라인 상점의 제품에 대한 데이터베이스가 있다고 가정해 보십시오.
문서의 첫 번째 버전은 다음 예와 같습니다.

> 문서의 두 번째 버전(첫 번째 개정판)은 설명을 추가한 것입니다.

```json
{
  "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "2-61ae00e029d4f5edd2981841243ded13",
    "name": "Samsung Galaxy S4",
    "description": "Latest smartphone from Samsung",
    "price": 650
}
```

문서에 설명이 아직 없으므로, 누군가가 설명을 추가할 수 있습니다.

> _대체_ 두 번째 버전은 문서의 첫 번째 버전에 가격 인하 데이터 변경을 도입합니다.

```json
{
  "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "2-f796915a291b37254f6df8f6f3389121",
    "name": "Samsung Galaxy S4",
    "description": "",
    "price": 600
}
```

동시에, 복제된 데이터베이스에 대해 작업하던 누군가 가격을 낮춥니다.
이 변경은 문서의 첫 번째 버전에 수행됩니다.
따라서 가격 인하 변경에는 설명 변경이 '적용되지 않습니다'

나중에 두 데이터베이스가 복제되면 문서의 두 대체 버전 중 어느 것이 올바른 것인지 분명하지 않게 됩니다.
이것이 충돌 시나리오입니다.

## 충돌하는 개정판 가져오기
{: #get-conflicting-revisions}

문서의 충돌 개정판을 찾으려면 평상시대로 문서를 검색하되 다음 예제와 유사하게 `conflicts=true` 매개변수를 포함시키십시오.

`http://ACCOUNT.cloudant.com/products/$_ID?conflicts=true`


> 충돌 개정판을 보여주는 문서 검색에 대한 응답 예

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

문서에 충돌이 있으면 변경된 설명이나 변경된 가격 문제점을 기반으로 하는 제공된 예와 유사한 응답을 얻게 됩니다.

변경된 가격이 있는 버전이 문서의 최신 버전으로 _임의로_ 선택되었습니다.
문서의 가장 최근 업데이트된 버전이 충돌 해결을 위해 최신 버전으로 간주되었다고 가정하지 않아야 합니다.

이 예제에서 검색된 문서(`_rev` 값 `2-f796915a291b37254f6df8f6f3389121`)와 다른 문서(`_rev` 값 `2-61ae00e029d4f5edd2981841243ded13`) 사이에 충돌이 존재한다고 간주합니다.
충돌 문서 세부사항은 `_conflicts` 배열에 있습니다.

종종 배열에 하나의 요소만 있는 경우가 있지만 여기에 다수의 충돌 개정판이 있을 수 있으며 이러한 충돌 개정판 각각이 배열에 나열됩니다.

## 변경사항 병합
{: #merge-the-changes}

사용자의 애플리케이션은 모든 잠재적 변경사항을 식별하고 올바르고 유효한 업데이트를 효율적으로 병합하여 조정함으로써 충돌 없는 단일 문서 버전을 생성해야 합니다.

개정판을 비교하고 변경된 내용을 식별하려면 애플리케이션이 데이터베이스에서 모든 버전을 검색해야 합니다.
앞서 설명했듯이 우리는 문서 및 충돌 버전의 세부사항을 검색하는 것으로 시작합니다.
다음과 유사한 명령을 사용하여 수행하며 이 명령은 `_conflicts` 배열도 요청합니다.

`http://$ACCOUNT.cloudant.com/products/$_ID?conflicts=true
`

이 검색을 통해 저장한 문서의 현재 버전 _및_ 역시 검색되어야 하는 기타 모든 충돌 문서의 목록(예: `...rev=2-61ae00e029d4f5edd2981841243ded13` 및 `...rev=1-7438df87b632b312c53a08361a7c3299`)을 얻을 수 있습니다.
이러한 기타 충돌 버전 역시 각각 검색 및 저장됩니다. 예를 들어 다음과 같습니다.

  `http://$ACCOUNT.cloudant.com/products/$_ID?rev=2-61ae00e029d4f5edd2981841243ded13`
  `http://$ACCOUNT.cloudant.com/products/$_ID?rev=1-7438df87b632b312c53a08361a7c3299`

문서의 사용 가능한 모든 충돌 개정판을 가져왔으면 이제 충돌 해결을 진행할 수 있습니다.

앞의 시나리오에서 문서 버전 간의 차이점은 문서 내 상이한 필드에 관한 것이었으므로 병합이 더 쉽습니다.

좀더 복잡한 충돌에는 그에 따라 추가 분석이 요구될 수 있습니다
다음과 같이 여러 충돌 해결 전략 중에서 선택하여 도움을 얻을 수 있습니다.

*	시간 기반: 최초 또는 가장 최근 편집의 간단한 테스트를 사용합니다.
*	사용자 평가: 충돌이 사용자에게 보고되고 해당 사용자가 최적의 해결책을 결정합니다.
*	복잡한 병합 알고리즘: [버전 제어 시스템](https://en.wikipedia.org/wiki/Merge_%28version_control%29)에서 자주 사용됩니다. 예제는 [3방향 병합](https://en.wikipedia.org/wiki/Merge_%28version_control%29#Three-way_merge)입니다.

이러한 변경사항을 구현하는 방법에 대한 실제 예는 [샘플 코드가 포함된 프로젝트](https://github.com/glynnbird/deconflict)를 참조하십시오.

## 새 개정판 업로드
{: #upload-the-new-revision}

> 이전 충돌 개정판에서 변경사항을 병합하여 충돌을 해결한 최종 개정판입니다.

```json
{
  "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "3-daaecd7213301a1ad5493186d6916755",
    "name": "Samsung Galaxy S4",
    "description": "Latest smartphone from Samsung",
    "price": 600
}
```

충돌을 평가하고 해결한 후 현재 최종 데이터를 포함하는 문서를 작성합니다.
이 신규 문서가 데이터베이스에 업로드됩니다.

## 이전 개정판 삭제
{: #delete-old-revisions}

> 이전 개정판 삭제 요청 예

```http
DELETE http://$ACCOUNT.cloudant.com/products/$_ID?rev=2-61ae00e029d4f5edd2981841243ded13

DELETE http://$ACCOUNT.cloudant.com/products/$_ID?rev=2-f796915a291b37254f6df8f6f3389121
```

마지막 단계는 이전 개정판을 삭제하는 것입니다.
`DELETE` 요청에 삭제할 개정판을 지정하고 전송하여 이를 수행합니다.

문서의 이전 버전이 삭제되면 해당 문서와 연관된 충돌이 해결된 것으로 표시됩니다.
문서를 다시 요청하여 충돌이 남아 있지 않음을 확인할 수 있으며,
`conflicts` 매개변수가 true로 설정된 경우에는 이전처럼
[충돌 찾기](#finding-conflicts)를 사용하십시오.
