---

copyright:
  years: 2015, 2017
lastupdated: "2017-01-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

# 태스크 관리

많은 데이터에 대한 새 인덱스를 작성하거나 대규모 데이터베이스를 복제하는 작업에는 많은 시간이 소요될 수 있습니다.
{:shortdesc}

태스크가 진행되고 있는지, 또는 완료되었는지 판별하는 방법은 무엇일까요?
[`_active_tasks` 엔드포인트](../api/active_tasks.html)는 모든 진행 중인 태스크에 대한 정보를 제공합니다.
그러나, 여러 태스크를 시작하는 경우에는 일부가 나중에 실행되도록 스케줄되어 시작되기 전까지 `_active_tasks`에
표시되지 않을 수 있습니다. 

이 안내서에서는 `_active_tasks` 엔드포인트를 사용하여 장기 실행되는 태스크를 모니터하는 방법을 설명합니다.
`curl` 명령은 엔드포인트에 액세스하는 데 사용됩니다. `jq` 명령행 JSON 프로세서는 JSON 응답을 처리하는 데 사용됩니다. 

이는 태스크 중심 튜토리얼이므로 이 태스크를 수행하는 데 필수적인 내용만을 다루고 있습니다.
사용 가능한 옵션에 대한 전체 안내는 [API 참조](../api/index.html)를 참조하십시오. 

## curl 및 jq 기본 사항

모든 활성 태스크를 가져와 출력을 보기 좋게 형식화하려면
`curl`을 사용하여 계정을 호출하고 출력을 `jq`에 전달하십시오. 

`jq`는 필드 값에 따라 문서의 목록을 필터링하는 것을 허용합니다.
이는 모든 복제 문서를 가져오거나, 하나의 특정 보기 인덱싱 태스크의 세부사항을 가져오기 쉽게 해 줍니다.
이 옵션에 대한 자세한 정보는 [API 참조](../api/index.html)에 있습니다. 

_활성 태스크의 목록 획득 및 형식화의 예:_

```sh
curl 'https://username:password@username.cloudant.com/_active_tasks' | jq '.'
```
{:codeblock}

## 보기 빌드 및 검색 인덱스 모니터링

보기 인덱스는 디자인 문서가 업데이트되면 다시 빌드됩니다.
보기 중 하나가 업데이트되면 문서에 있는 모든 보기가 다시 빌드됩니다. 

검색 인덱스는 해당 인덱스 함수가 변경되는 경우에만 다시 빌드됩니다.
빌드되는 각 검색 인덱스와 변경된 보기가 있는 각 디자인 문서에 대해,
클러스터에 있는 각 샤드의 각 복제본에 대한 새 태스크가 작성됩니다. 

예를 들어, 각각 세 개의 복제본이 있는 24개의 샤드가 있으며
두 개의 검색 인덱스를 업데이트하는 경우, 24 x 3 x 2 = 144개의 태스크가 실행됩니다. 

모든 보기 인덱싱 태스크를 찾으려면 `curl` 출력을 `jq`에 전달하고,
여기에서 유형 필드에 따라 문서를 배열에 필터링하도록 하십시오. 해당 명령은 검색 인덱싱 태스크에 대해 작동합니다. 

각 경우에서 인덱싱 태스크의 목록 검색 결과는 JSON 오브젝트의 목록으로, 찾은 활성 태스크 하나당 하나의 오브젝트가 출력됩니다. 

_`indexer` 유형으로 필터링하여 모든 인덱싱 태스크를 검색하는 예:_

```sh
curl -s 'https://username:password@username.cloudant.com/_active_tasks' | jq '.[] | select(.type=="indexer")'
```
{:codeblock}

_`search_indexer` 유형으로 필터링하여 모든 검색 인덱싱 태스크를 검색하는 예:_

```sh
curl -s 'https://username:password@username.cloudant.com/_active_tasks' | jq '.[] | select(.type=="search_indexer")'
```
{:codeblock}

_보기 인덱싱 태스크 검색의 결과 예:_

```json
{
    "total_changes": 6435,
    "started_on": 1371118332,
    "user": "username",
    "updated_on": 1371118334,
    "type": "indexer",
    "node": "dbcore@db6.meritage.cloudant.net",
    "pid": "<0.16366.6103>",
    "changes_done": 364,
    "database": "shards/40000000-7fffffff/username/database",
    "design_document": "_design/ngrams"
}
```
{:codeblock}

## 태스크 완료 시간 예상

인덱싱 태스크가 완료되는 데 필요한 시간을 예상하려면 `changes_done`의 수를 모니터링하고 이 값을 `total_changes`와 비교하십시오.
예를 들어, `changes_done`이 초당 250씩 늘어나고 `total_changes`가 1,000,000인 경우 해당 태스크는 완료되는 데
1,000,000 / 250 = 4,000초 또는 66분이 소요될 것으로 예상됩니다. 

>   **참고**: 인덱싱 태스크 완료 시간 예상이 100% 정확할 수는 없습니다. 
    완료하는 데 소요되는 실제 시간은 다음과 같은 몇 가지 요소에 따라 달라집니다.

-   각 문서를 처리하는 데 소요되는 시간. 예를 들어, 보기는 먼저
    문서의 유형을 확인한 후 한 유형의 새 인덱스 항목만 생성할 수 있습니다.  
-   문서의 크기
-   클러스터의 현재 워크로드

>   이러한 요소가 결합되어 예상 시간에 상당한 오차가 발생할 것임을 예상해야 합니다. 

_`jq`를 사용하여 `changes_done` 필드를 추출하는 예:_

```sh
curl ... | jq '.[] | select(.type=="search_indexer") | .changes_done'
```
{:codeblock}

## 복제 모니터링

모든 복제 태스크를 찾으려면 `curl` 출력을 `jq`에 전달하고, 유형 필드에 따라 문서를 배열에 필터링하십시오. 

활성 태스크의 목록에서 복제 프로세스에 대한 정보를 더 선택하기 쉽게 하려면 `_replicator` 데이터베이스에 문서를 작성하여 복제 프로세스를 시작한 후 해당 `_id` 필드를 알려진 값으로 설정하십시오. 

_`replication` 유형으로 필터링하여 모든 복제 태스크를 검색하는 예:_

```sh
curl -s 'https://username:password@username.cloudant.com/_active_tasks' | jq '.[] | select(.type=="replication")'
```
{:codeblock}

_알려진 문서 ID로 필터링하여 특정 복제 태스크를 검색하는 예:_

```sh
curl ... | jq '.[] | select(.doc_id=="ID")'
```
{:codeblock}

_알려진 `replication_id`로 필터링하여 특정 복제 태스크를 검색하는 예:_

```sh
curl ... | jq '.[] | select(.replication_id=="ID")'
```
{:codeblock}

_복제 태스크 검색의 결과 예:_

```json
{
    "started_on": 1371094220,
    "source_seq": "62960-sakdjflksdfjsdlkafjalskdfjlsakfjlasdkjksald",
    "source": "",
    "revisions_checked": 12,
    "continuous": true,
    "doc_id": null,
    "doc_write_failures": 0,
    "docs_read": 12,
    "target": "",
    "type": "replication",
    "updated_on": 1371118477,
    "user": "username",
    "checkpointed_source_seq": "61764-dskfjalsfjsalkfjssadjfhasdfkjhsdkfhsdkf",
    "changes_pending": 1196,
    "pid": "<0.9955.4120>",
    "node": "dbcore@db7.meritage.cloudant.net",
    "docs_written": 12,
    "missing_revisions_found": 12,
    "replication_id": "asfksdlfkjsadkfjsdalkfjas+continuous+create_target"
}
```
{:codeblock}

## 문제점 해결

### 태스크의 정지 여부

소스 데이터베이스가 복제 중에 크게 업데이트되지 않는 일회성 비연속 복제에서, `changes_pending` 값은 처리할 남은 문서의 수를 알려줍니다.
이는 `changes_pending` 값이 복제 완료 시점에 대한 좋은 지표임을 의미합니다. 

연속 복제의 경우에는 시간 경과에 따른 처리 문서 수와 `changes_pending` 값의 증가 여부에 더 관심을 가져야 합니다.
`changes_pending`이 증가하지만 `revisions_checked`가 변경되지 않는 상태로 유지되면 복제 작업이 정지되었을 가능성이 높습니다.
`changes_pending`이 증가하며 `revisions_checked`도 증가하는 경우에는 복제 속도가 데이터베이스에서 데이터가 추가되거나 업데이트되는
속도를 따라가지 못하고 있음을 나타낼 가능성이 높습니다. 

### 정지 태스크의 해결 방법

정지된 복제를 해결하려면 [복제 프로세스를 취소](../api/replication.html#cancelling-a-replication)하고 다시 시작해야 합니다. 

이렇게 해도 해결되지 않는 경우에는 소스 또는 대상 데이터베이스에 액세스 중인 사용자에게 쓰기 권한이 없어 복제가 정지되었을 가능성이 높습니다. 

>   **참고**: 복제는 [체크포인트](replication_guide.html#checkpoints)를 이용합니다. 
    이는 이미 복제되어 변경되지 않은 컨텐츠는 복제가 다시 시작되는 경우 다시 복제될 필요가 없음을 의미합니다.

`_replicator` 데이터베이스에 문서를 작성하여 복제 프로세스를 작성한 경우에는 여기에서 복제의 상태를 확인할 수도 있습니다. 
