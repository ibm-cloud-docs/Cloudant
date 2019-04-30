---

copyright:
  years: 2015, 2019
lastupdated: "2019-03-15"

keywords: incremental backups, create an incremental backup, restore a database, how to back up example, how to restore example

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

<!-- Acrolinx: 2017-05-10 -->

# 복제 증분
{: #replication-incrementals}

이 안내서에는 {{site.data.keyword.cloudantfull}} 백업에 대한, 오래되거나 '더 이상 사용되지 않는' 안내가 포함되어 있습니다. 백업에 대한 현재 안내는 [재해 복구 및 백업](/docs/services/Cloudant?topic=cloudant-disaster-recovery-and-backup#disaster-recovery-and-backup) 안내서를 참조하십시오.
{: deprecated}

데이터베이스 백업은 데이터를 잠재적 손실 또는 손상으로부터 보호합니다.
{: shortdesc}

{{site.data.keyword.cloudant_short_notm}} 복제 기능을 사용하여 데이터베이스 백업을 작성하고 이를
{{site.data.keyword.cloudant_short_notm}} 클러스터에 저장할 수 있습니다.
그 후에는 이러한 백업에서 프로덕션 클러스터로 데이터, 전체 데이터베이스 또는 특정 JSON 문서를 복원할 수 있습니다.

데이터베이스 백업에서는 {{site.data.keyword.cloudant_short_notm}} 복제를 사용하여 데이터베이스 컨텐츠를 체크포인트에 저장합니다.
특정 체크포인트로 '롤백'하는 것이 가능합니다.
체크포인트는 정확한 시간에 특정한 것은 아닙니다.
이는 백업 기간 중에 특정 변경사항이 발생한 후의 데이터베이스에 대한 레코드입니다.
이 방식을 통해, 백업은 선택된 시간의 데이터베이스 상태를 유지할 수 있습니다.

## 증분 백업
{: #incremental-backups}

엔터프라이즈 고객의 경우에는 일별 증분 백업 기능을 [사용할 수 있습니다](/docs/services/Cloudant?topic=cloudant-disaster-recovery-and-backup#disaster-recovery-and-backup).

엔터프라이즈 고객이 아니거나 고유한 백업을 작성하려는 경우에는 {{site.data.keyword.cloudant_short_notm}} 복제 기능을 사용하여 데이터베이스 백업을 작성할 수 있습니다.

단순한 접근법은 전체 데이터베이스를 날짜 지정된 백업 데이터베이스에 복제하는 것입니다.
이 방법은 백업 방법으로 사용 가능하며 수행하기 쉽습니다.
그러나 여러 시점의 백업을 필요로 하는 경우(예: 일곱 개의 일별 백업과 네 개의 주별 백업)에는
데이터베이스의 전체 사본을 각 새 백업 데이터베이스에 저장해야 합니다.
특히 데이터베이스가 큰 경우에는 막대한 디스크 사용량을 필요로 할 수 있습니다.

대체 방법으로서, 증분 백업은 마지막 백업 후 변경된 문서만 저장하므로 이러한 문제에 대한 좋은 해결책입니다.

프로세스는 단순합니다.
처음에는 전체 데이터베이스의 백업을 수행합니다.
첫 번째 백업 후에는 일별 '증분' 백업을 실행하여
마지막 백업 후 데이터베이스에서 _변경된 것만_ 백업합니다.
이 복제가 일별 백업이 됩니다.

정기적인 간격으로 트리거되도록 백업을 구성할 수 있습니다.
    그러나 각 간격은 24시간 이상이어야 합니다. 즉, 일별 백업은 실행할 수 있지만 시간별 백업은 실행할 수 없습니다.
{: note}

## 증분 백업 작성
{: #creating-an-incremental-backup}

증분 백업은 각 백업 간의 차이점(또는 '델타')만 저장합니다.
24시간마다 소스 데이터베이스가 대상 데이터베이스에 복제됩니다.

복제는 시퀀스 값을 사용하여 24시간 기간 중에 변경된 문서를 식별합니다.
백업 오퍼레이션은 복제를 사용하여 체크포인트를 가져오고 저장함으로써 작동합니다.
체크포인트는 내부 이름을 가진 다른 문서입니다.
백업 오퍼레이션은 날짜와 백업 태스크 이름의 조합을 사용하여 이름을 작성합니다.
이 이름은 복구 또는 롤업 프로세스 중에 체크포인트를 쉽게 식별할 수 있게 해 줍니다.

증분 백업을 작성하려면 다음 단계를 수행하십시오.

1.  마지막 복제에 대한 체크포인트 문서의 ID를 찾으십시오.
    이는 `_replicator` 데이터베이스에 있는 복제 문서의 `_replication_id` 필드에 저장되어 있습니다.
2.  `/$DATABASE/_local/$REPLICATION_ID`에 있는 체크포인트 문서를 여십시오.
    여기서 `$REPLICATION_ID`는 이전 단계에서 찾은 ID이며 `$DATABASE`는 소스 또는 대상 데이터베이스의 이름입니다.
    이 문서는 보통 두 데이터베이스에 모두 있지만 하나에만 있는 경우도 있습니다.
3.  체크포인트 문서에 있는 히스토리 배열에서 첫 번째 요소의 `recorded_seq` 필드를 검색하십시오.
4.  복제 문서에 있는 [`since_seq` 필드](/docs/services/Cloudant?topic=cloudant-replication-api#the-since_seq-field)를
    이전 단계에서 찾은 `recorded_seq` 필드 값으로
    설정하여 새 증분 백업 데이터베이스로 복제하십시오.

본질적으로, `since_seq` 옵션을 사용하면 일반 체크포인트 작성 기능이 무시됩니다. `since_seq`는 반드시 주의하여 사용하십시오. 
{: note}

## 데이터베이스 복원
{: #restoring-a-database}

증분 백업에서 데이터베이스를 복원하려는 경우에는 최신 증분부터 시작하여 각 증분 백업을 새 데이터베이스로 복제합니다.

가장 이전 백업부터 시작하여 순서대로 후속 백업을 적용할 수도 있습니다.
그러나, 업데이트된 문서는 대상 데이터베이스에 한 번만 기록되므로
먼저 최신 증분 백업으로부터 백업을 복제하는 것이 더 빠릅니다.
복제 작업은 새 데이터베이스에 이미 있는 사본보다 이전 상태인 문서를 건너뜁니다.


## 예
{: #an-example}

이 예는 다음 작업을 수행하는 방법을 보여줍니다.

1.  증분 백업을 사용할 수 있도록 데이터베이스를 설정합니다.
2.  전체 백업을 실행합니다.
3.  증분 백업을 설정하고 실행합니다.
4.  백업을 복원합니다.

### 여기서 사용되는 상수
{: #constants-that-are-used-here}

```sh
# save base URL and the content type in shell variables
$ url='https://$ACCOUNT:$PASSWORD@$ACCOUNT.cloudant.com'
$ ct='Content-Type: application-json'
```
{: codeblock}

하나의 데이터베이스를 백업해야 한다고 가정하십시오.
사용자는 월요일에 전체 백업을 작성하고 화요일에 증분 백업을 작성하려 합니다.

`curl` 및 [`jq` ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](http://stedolan.github.io/jq/){: new_window} 명령을
사용하여 이러한 오퍼레이션을 실행할 수 있습니다.
실제로는 모든 HTTP 클라이언트를 사용할 수 있습니다.

### 1단계: 세 개의 데이터베이스가 있는지 확인
{: #step-1-check-that-you-have-three-databases}

이 예에서는 세 개의 데이터베이스가 필요합니다.

-   백업할 데이터를 저장하고 있는 원래 데이터베이스
-   월요일(`backup-monday`) 및 화요일(`backup-tuesday`)을 위한 두 개의 증분 데이터베이스

_이 예에서 사용할 세 개의 데이터베이스가 있는지 확인하는 방법을 보여주는, HTTP를 사용한 예:_

```http
PUT /original HTTP/1.1
PUT /backup-monday HTTP/1.1
PUT /backup-tuesday HTTP/1.1
```
{: codeblock}

_이 예에서 사용할 세 개의 데이터베이스가 있는지 확인하는 방법을 보여주는, 명령행을 사용한 예:_

```sh
$ curl -X PUT "${url}/original"
$ curl -X PUT "${url}/backup-monday"
$ curl -X PUT "${url}/backup-tuesday"
```
{: codeblock}

### 2단계: `_replicator` 데이터베이스 작성
{: #step-2-create-the-_replicator-database}

`_replicator` 데이터베이스가 존재하지 않는 경우에는 이를 작성하십시오.

*HTTP를 사용하여 `_replicator` 데이터베이스 작성:*

```http
PUT /_replicator HTTP/1.1
```
{: codeblock}

*명령행을 사용하여 `_replicator` 데이터베이스에서 작성:*

```sh
curl -X PUT "${url}/_replicator"
```
{: pre}

### 3단계: 전체(원래) 데이터베이스 백업
{: #step-3-back-up-the-entire-original-database}

월요일에, 사용자는 모든 데이터를 처음으로 백업하려 합니다.
`original`에서 `backup-monday`로 모든 데이터를 복제하여 이 백업을 작성하십시오.

_HTTP를 사용하여 월요일에 전체 백업 실행:_

```http
PUT /_replicator/full-backup-monday HTTP/1.1
Content-Type: application/json
```
{: codeblock}

_명령행을 사용하여 월요일에 전체 백업 실행:_

```sh
$ curl -X PUT "${url}/_replicator/full-backup-monday" -H "$ct" -d @backup-monday.json
# where backup-monday.json describes the backup.
```
{: codeblock}

_전체 백업을 나타내는 JSON 문서:_
 
```json
{
    "_id": "full-backup-monday",
    "source": "${url}/original",
    "target": "${url}/backup-monday"
}
```
{: codeblock}

### 4단계: 증분 백업 준비 1단계 - 체크포인트 ID 가져오기
{: #step-4-prepare-incremental-backup-part-1-get-checkpoint-id}

화요일에, 사용자는 다른 전체 백업이 아니라 증분 백업을 수행하려 합니다.

증분 백업을 시작하려면 두 가지 값이 필요합니다.

-   체크포인트 ID
-   [`recorded_seq` 값](#step-5-prepare-incremental-backup-part-2-get-recorded_seq-value)

이러한 값은 마지막 백업이 종료된 위치를 식별하며 다음 증분 백업을 시작할 위치를 판별합니다.
이러한 값을 가져온 후에는 증분 백업을 실행할 수 있습니다.

사용자는 체크포인트 ID 값을 찾는 것으로 작업을 시작합니다.
이 값은 `_replicator` 데이터베이스 내 복제 문서의 `_replication_id` 필드에 저장되어 있습니다.

*HTTP를 사용하여, `recorded_seq` 값을 찾는 데 도움을 주는 체크포인트 ID 가져오기:*

```http
GET /_replicator/full-backup-monday HTTP/1.1
# Search for the value of _replication_id
```
{: codeblock}

*명령행을 사용하여, `recorded_seq` 값을 찾는 데 도움을 주는 체크포인트 ID 가져오기:*

```sh
replication_id=$(curl "${url}/_replicator/full-backup-monday" | jq -r '._replication_id')
```
{: pre}

### 5단계: 증분 백업 준비 2단계 - `recorded_seq` 값 가져오기
{: #step-5-prepare-incremental-backup-part-2-get-recorded_seq-value}

체크포인트 ID를 가져온 후에는 이를 사용하여 `recorded_seq` 값을 가져오십시오.
이 값은 원래 데이터베이스 내 `/_local/${replication_id}` 문서에 있는 히스토리 배열의 첫 번째 요소에서 찾을 수 있습니다.

이제 `recorded_seq` 값을 확보했습니다.
이 값은 원래 데이터베이스에서 복제된 마지막 문서를 식별합니다.

*HTTP를 사용하여 원래 데이터베이스에서 `recorded_seq` 가져오기:*

```http
GET /original/_local/${replication_id} HTTP/1.1
# Search for the first value of recorded_seq in the history array
```
{: codeblock}

*명령행을 사용하여 원래 데이터베이스에서 `recorded_seq` 가져오기:*

```sh
recorded_seq=$(curl "${url}/original/_local/${replication_id}" | jq -r '.history[0].recorded_seq')
```
{: pre}

### 6단계: 증분 백업 실행
{: #step-6-run-an-incremental-backup}

체크포인트 ID 및 `recorded_seq`를 확보하고 나면 화요일의 증분 백업을 시작할 수 있습니다.
이 백업은 마지막 복제 _이후_ 수행된 모든 문서 변경사항을 복제합니다.

복제가 완료되면 완료된 증분 백업을 얻게 됩니다.
이 백업은 원래 데이터베이스의 모든 문서로 구성되어 있으며
`backup-monday` _및_ `backup-tuesday` 데이터베이스의 컨텐츠를 모두 검색하여 복원할 수 있습니다.

_HTTP를 사용하여 화요일의 증분 백업 실행:_

```http
PUT /_replicator/incr-backup-tuesday HTTP/1.1
Content-Type: application/json
```
{: codeblock}

_명령행을 사용하여 화요일의 증분 백업 실행:_

```sh
curl -X PUT "${url}/_replicator/incr-backup-tuesday" -H "${ct}" -d @backup-tuesday.json
```
{: pre}

_화요일의 증분 백업을 나타내는 JSON 문서:_
 
```json
{
    "_id": "incr-backup-tuesday",
    "source": "${url}/original",
    "target": "${url}/backup-tuesday",
    "since_seq": "${recorded_seq}"
}
```
{: codeblock}

### 7단계: 월요일 백업 복원
{: #step-7-restore-the-monday-backup}

백업으로부터 복원하려는 경우에는 새 데이터베이스로 초기 전체 백업을 복제한 후 증분 백업을 복제하십시오.

예를 들어, 월요일의 상태를 복원하려는 경우에는 `backup-monday` 데이터베이스로부터 복제합니다.

_HTTP를 사용하여 `backup-monday` 데이터베이스로부터 복원:_

```sh
PUT /_replicator/restore-monday HTTP/1.1
Content-Type: application/json
```
{: codeblock}

_명령행을 사용하여 `backup-monday` 데이터베이스로부터 복원:_

```sh
curl -X PUT "${url}/_replicator/restore-monday" -H "$ct" -d @restore-monday.json
```
{: pre}

_복원을 나타내는 JSON 문서:_
 
```json
{
    "_id": "restore-monday",
    "source": "${url}/backup-monday",
    "target": "${url}/restore",
    "create_target": true  
}
```
{: codeblock}

### 8단계: 화요일 백업 복원
{: #step-8-restore-the-tuesday-backup}

화요일의 데이터베이스를 복원하려는 경우에는 먼저 `backup-tuesday`로부터 복제한 후 `backup-monday`로부터 복제하십시오.

순서는 입력 오류가 아닙니다. 화요일로부터 복원한 _다음_ 월요일로부터 복원하는 것이 진짜 의도_입니다_.
{: tip}

시간 순서대로 복원할 수도 있지만, 역순을 사용하는 경우에는 화요일에 업데이트된 문서를 대상 데이터에 한 번만 기록하면 됩니다.
월요일에 저장된 이전 문서 버전은 무시됩니다.

_HTTP를 사용해 최신 변경사항을 먼저 가져와 화요일의 백업 복원:_

```http
PUT /_replicator/restore-tuesday HTTP/1.1
Content-Type: application/json
```
{: codeblock}

_명령행을 사용해 최신 변경사항을 먼저 가져와 화요일의 백업 복원:_

```sh
curl -X PUT "${url}/_replicator/restore-tuesday" -H "$ct" -d @restore-tuesday.json
```
{: pre}

_화요일 백업의 복원을 요청하는 JSON 문서:_
 
```json
{
    "_id": "restore-tuesday",
    "source": "${url}/backup-tuesday",
    "target": "${url}/restore",
    "create_target": true  
}
```
{: codeblock}

_HTTP를 사용해 월요일의 백업을 마지막으로 복원하여 복구 완료:_

```http
PUT /_replicator/restore-monday HTTP/1.1
Content-Type: application/json
```
{: codeblock}

_명령행을 사용해 월요일의 백업을 마지막으로 복원하여 복구 완료:_

```http
curl -X PUT "${url}/_replicator/restore-monday" -H "$ct" -d @restore-monday.json
```
{: pre}

_월요일 백업의 복원을 요청하는 JSON 문서:_
 
```json
{
    "_id": "restore-monday",
    "source": "${url}/backup-monday",
    "target": "${url}/restore"
}
```
{: codeblock}

## 권장사항
{: #suggestions}

위 정보는 기본 백업 프로세스를 간력하게 설명하고 있으나,
각 애플리케이션에는 백업에 대한 고유 요구사항 및 전략이 있습니다.
다음 제안사항은 작업에 참고하면 유용합니다.

### 백업 스케줄링
{: #scheduling-backups}

복제 작업은 클러스터의 로드를 크게 증가시킬 수 있습니다.
여러 데이터베이스를 백업하는 경우에는 복제 작업을 여러 시간대로 분산하거나, 클러스터 사용량이 적은 시간에 할당하는 것이 좋습니다.

#### 백업의 IO 우선순위 변경
{: #changing-the-io-priority-of-a-backup}

복제 문서 내 `x-cloudant-io-priority` 필드의 값을 조정하여 백업 작업의 우선순위를 변경할 수 있습니다.

1.  소스 및 대상 필드에서 `headers` 오브젝트를 변경하십시오.
2.  headers 오브젝트에서 `x-cloudant-io-priority` 필드 값을 `"low"`로 변경하십시오.

_IO 우선순위를 설정하는 JSON 문서의 예:_

```json
{
    "source": {
        "url": "https://user:pass@example.com/db",
        "headers": {
            "x-cloudant-io-priority": "low"
        }
    },
    "target": {
        "url": "https://user:pass@example.net/db",
        "headers": {
            "x-cloudant-io-priority": "low"
        }
    }
}
```
{: codeblock}

### 디자인 문서 백업
{: #backing-up-design-documents}

백업에 디자인 문서를 포함시키면 인덱스가 백업 대상에 작성됩니다.
이러한 방식은 백업 프로세스 속도를 늦추며 불필요한 디스크 공간을 사용합니다.
백업 시스템에서 인덱스를 필요로 하지 않는 경우에는 복제에 필터 기능을 사용하여 디자인 문서를 필터링하십시오.
이 필터 기능을 사용하여 원치 않는 다른 문서를 제외시킬 수도 있습니다.

### 여러 데이터베이스 백업
{: #backing-up-multiple-databases}

애플리케이션에서 사용자당 하나의 데이터베이스를 사용하거나,
각 사용자가 여러 데이터베이스를 작성할 수 있도록 허용하는 경우에는
각 새 데이터베이스에 대해 백업 작업을 작성해야 합니다.
복제 작업이 동일한 시간에 시작되지 않도록 하십시오.

## 도움말
{: #need-help-}

복제 및 백업 작업은 복잡할 수 있습니다.
궁금한 점이 있는 경우에는 [복제 안내서](/docs/services/Cloudant?topic=cloudant-replication-guide#replication-guide)를 참조하거나
[{{site.data.keyword.cloudant_short_notm}} 지원 팀 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](mailto:support@cloudant.com){: new_window}에 문의하십시오.
