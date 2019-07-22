---

copyright:
  years: 2015, 2019
lastupdated: "2019-06-12"

keywords: connect to ibm cloudant, http api, json, distributed systems, replication

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

# {{site.data.keyword.cloudant_short_notm}} 기본 사항
{: #ibm-cloudant-basics}

Cloudant를 처음 사용해 보는 경우에는 더 진행하기 전에 이 절의 내용을 살펴보십시오.
{: shortdesc}

다음 주제에 대한 정보를 이해하기 위해 {{site.data.keyword.cloudantfull}}에 대한 기본적인 사항을 알고 있다고 가정합니다. 

- [클라이언트 라이브러리](/docs/services/Cloudant?topic=cloudant-client-libraries#client-libraries)
- [API 참조](/docs/services/Cloudant?topic=cloudant-api-reference-overview#api-reference-overview)
- [안내서](/docs/services/Cloudant?topic=cloudant-authorized-curl-acurl-#authorized-curl-acurl-)

## {{site.data.keyword.cloudant_short_notm}}에 연결
{: #connecting-to-ibm-cloudant}

{{site.data.keyword.cloudant_short_notm}}에 액세스하려면 [{{site.data.keyword.cloudant_short_notm}} 계정](/docs/services/Cloudant?topic=cloudant-ibm-cloudant.com#enterprise-plan)
또는 [{{site.data.keyword.cloud}} 계정](https://cloud.ibm.com/login)이 있어야 합니다.

## HTTP API
{: #http-api}

{{site.data.keyword.cloudant_short_notm}}에 대한 모든 요청은 웹을 통해 전달됩니다.
웹에 요청을 전달할 수 있는 모든 시스템은 {{site.data.keyword.cloudant_short_notm}}에 요청을 전달할 수 있음을 의미합니다.
모든 {{site.data.keyword.cloudant_short_notm}}용 특정 언어 라이브러리는 단지 사용자가 단순한 API에 대해 작업할 수 있도록
도움을 주기 위해 몇 가지 편의성과 언어적 편리성을 제공하는 랩퍼에 불과합니다.
{{site.data.keyword.cloudant_short_notm}} 작업용 도구로 원시 HTTP 라이브러리를 선택하는 사용자도 많습니다.

{{site.data.keyword.cloudant_short_notm}}가 HTTP를 사용하는 방법에 대한 자세한 정보는 API 참조의 [HTTP](/docs/services/Cloudant?topic=cloudant-http#http)를 참조하십시오.

{{site.data.keyword.cloudant_short_notm}}는 다음 HTTP 요청 메소드를 지원합니다.

-   `GET`

    지정된 항목을 요청합니다.
    보통 HTTP 요청과 마찬가지로,
    URL의 형식이 리턴되는 항목을 정의합니다.
    {{site.data.keyword.cloudant_short_notm}}의 경우 여기에는 정적 항목,
    데이터베이스 문서,
    구성 및 통계 정보가 포함될 수 있습니다.
    대부분의 경우 정보는 JSON 문서 양식으로 리턴됩니다.

-   `HEAD`

    `HEAD` 메소드는 응답의 본문 없이 `GET` 요청의 HTTP 헤더를 가져오는 데 사용됩니다.

-   `POST`

    데이터를 업로드합니다.
    {{site.data.keyword.cloudant_short_notm}}의 API에서
    `POST` 메소드는 값을 설정하고,
    문서를 업로드하고,
    문서 값을 설정하고,
    몇 가지 관리 명령을 시작하는 데 사용됩니다.

-   `PUT`

    특정 리소스를 '저장'하는 데 사용됩니다.
    {{site.data.keyword.cloudant_short_notm}}의 API에서
    `PUT`은 데이터베이스,
    문서,
    보기,
    디자인 문서를 포함한
    새 오브젝트를 작성하는 데 사용됩니다.

-   `DELETE`

    문서, 보기 및
    디자인 문서를 포함한
    지정된 리소스를
    삭제합니다.

-   `COPY`

    문서 및 오브젝트를 복사하는 데 사용할 수 있는 특수 메소드입니다.

클라이언트(특정 웹 브라우저 등)가 이러한 HTTP 메소드 사용을 지원하지 않는 경우, 실제 HTTP 메소드에
`X-HTTP-Method-Override` 요청 헤더를 설정하여 `POST` 메소드를 대신 사용할 수 있습니다.

### 허용되지 않은 메소드 오류
{: #method-not-allowed-error}

지정된 유형을 지원하지 않는 URL에 지원되지 않는 HTTP 요청 유형을 사용하면
다음 예에 표시된 바와 같이 [405](/docs/services/Cloudant?topic=cloudant-http#http-status-codes) 오류가 리턴되며
지원되는 HTTP 메소드가 나열됩니다.

_지원되지 않는 요청에 대한 응답 오류 메시지 예:_

```json
{
    "error":"method_not_allowed",
    "reason":"Only GET,HEAD allowed"
}
```
{: codeblock}

## JSON
{: #json-overview}

{{site.data.keyword.cloudant_short_notm}}는 JSON(JavaScript Object Notation) 인코딩을 사용하여 문서를 저장하므로,
JSON으로 인코딩된 모든 항목은 문서로 저장할 수 있습니다.
이미지, 동영상, 오디오와 같은 미디어를 포함하는 파일은 BLOB(Binary Large OBject)이라 하며
문서에 연관된 첨부 파일로 저장될 수 있습니다.

JSON에 대한 자세한 정보는 [JSON 안내서](/docs/services/Cloudant?topic=cloudant-json#json)에서 찾을 수 있습니다.

## 분산 시스템
{: #distributed-systems}

{{site.data.keyword.cloudant_short_notm}}의 API를 통해 클러스터라고 불리는 여러 시스템의 협업과
상호작용할 수 있습니다.
클러스터에 속한 시스템들은 동일한 데이터 센터에 있어야 하지만
데이터 센터 내의 '팟(Pod)'은 서로 다를 수 있습니다.
서로 다른 팟(Pod)을 사용하면 {{site.data.keyword.cloudant_short_notm}}의 고가용성 특성이 향상됩니다.

클러스터링의 장점은 추가 컴퓨팅 능력이 필요한 경우
시스템만 추가하면 된다는 점입니다.
이는 일반적으로 기존의 한 시스템을 확장하거나 업그레이드하는 것보다 비용 효율적이며 결함에 대한 내성이 더 높습니다.

{{site.data.keyword.cloudant_short_notm}}와 분산 시스템 개념에 대한 자세한 정보는
[CAP 정리](/docs/services/Cloudant?topic=cloudant-cap-theorem#cap-theorem) 안내서를 참조하십시오.

## 복제
{: #replication-basics}

[복제](/docs/services/Cloudant?topic=cloudant-replication-api#replication-api)는 {{site.data.keyword.cloudant_short_notm}},
[CouchDB ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](http://couchdb.apache.org/){: new_window},
[PouchDB ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](http://pouchdb.com/){: new_window}
및 기타 분산 데이터베이스에서 수행하는 프로시저입니다.
복제는 컨텐츠가 동일해지도록 두 데이터베이스의 상태를 동기화합니다.

복제는 지속적으로 수행할 수 있습니다.
이는 소스 데이터베이스가 변경될 때마다 대상 데이터베이스가 업데이트됨을 의미합니다.
연속 복제는 데이터 백업,
여러 데이터베이스의 데이터 집계
또는 데이터 공유에 사용할 수 있습니다.

그러나
연속 복제는 모든 소스 데이터베이스 변경사항에 대해 테스트가 수행됨을 의미합니다.
이 테스트는 지속적인 내부 호출을 필요로 하며,
이는 성능 또는 데이터베이스 사용 비용에 영향을 줄 수 있습니다.

연속 복제로 인해 많은 내부 호출이 발생할 수 있습니다. 이러한 호출은 {{site.data.keyword.cloudant_short_notm}} 시스템의 멀티 테넌트 사용자의 비용에 영향을 줄 수 있습니다. 연속 복제는 기본적으로 사용 안함으로 설정되어 있습니다.
{: note}

