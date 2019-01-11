---

copyright:
  years: 2017, 2018
lastupdated: "2018-10-24"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:tip: .tip}

<!-- Acrolinx: 2017-05-10 -->

# 교차 지역 재해 복구를 위한 {{site.data.keyword.cloudant_short_notm}} 구성

[{{site.data.keyword.cloudant_short_notm}} 재해 복구 안내서](disaster-recovery-and-backup.html)는
재해 복구를 가능하게 하는 방법 중 하나가 {{site.data.keyword.cloudantfull}} 복제를 사용하여 여러 지역에 중복성을 구축하는 것임을 설명합니다.

데이터 센터 간에 '활성-활성' 또는 '활성-수동' 토폴로지를 사용하여 {{site.data.keyword.cloudant_short_notm}}에 복제를 구성할 수 있습니다.

다음 다이어그램은 두 개의 {{site.data.keyword.cloudant_short_notm}} 계정(각 지역당 하나)을 사용하는 일반적인 구성을 보여줍니다.

![활성-활성 아키텍처의 예](../images/active-active.png)

다음 항목을 기억해 두는 것이 좋습니다.

* 각 데이터 센터 내에서, {{site.data.keyword.cloudant_short_notm}}는 이미 세 서버에 삼중으로 데이터를 저장하여 고가용성을 제공하고 있습니다.
* 복제는 계정 레벨이 아니라 데이터베이스 레벨에서 이뤄지며 반드시 명시적으로 구성해야 합니다.
* {{site.data.keyword.cloudant_short_notm}}는 복제 대기 시간에 대해 서비스 레벨 계약(SLA) 또는 보장을 제공하지 않습니다.
* {{site.data.keyword.cloudant_short_notm}}는 개별 복제를 모니터하지 않습니다.
  사용자는 스스로 실패한 복제를 발견하고 이를 다시 시작하는 데 필요한 전략을 세워야 합니다.

## 시작하기 전에

> **참고**: 활성-활성 배치의 경우에는 충돌을 관리하는 전략이 있어야 합니다.
  따라서 이 아키텍처를 고려하기 전에는 [복제](../api/replication.html)와
  [충돌](mvcc.html#distributed-databases-and-conflicts)이 어떻게 작동하는지 이해하고 있어야 합니다.

충돌을 효과적으로 처리하기 위해 데이터를 모델링하는 방법에 대해 도움이 필요한 경우에는
[{{site.data.keyword.cloudant_short_notm}} 지원 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](mailto:support@cloudant.com){:new_window}에 문의하십시오.

## 개요

다음 자료에서는 양방향 복제가 작성됩니다.
이 구성을 통해 두 데이터베이스가 활성-활성 토폴로지로 작동할 수 있습니다.

이 구성은 사용자가 서로 다른 두 지역에 각각 하나의 계정을 갖고 있다고 가정합니다.

* `myaccount-dc1.cloudant.com`
* `myaccount-dc2.cloudant.com`

이러한 계정이 있는 경우, 기본 단계는 다음과 같습니다.

1. 계정 내에 하나의 피어 데이터베이스 쌍을 [작성](#step-1-create-your-databases)합니다.
2. 이러한 데이터베이스 간의 복제에 사용할 API 키를 [설정](#step-2-create-an-api-key-for-your-replications)합니다.
3. 적절한 권한을 부여합니다.
4. 복제를 설정합니다.
5. 복제가 예상대로 작동하는지 테스트합니다.
6. 데이터베이스의 활성-활성 또는 활성-수동 사용을 위해 애플리케이션 및 인프라를 구성합니다.

## 1단계: 데이터베이스 작성

각 계정 사이에 복제할 [데이터베이스를 작성하십시오](../api/database.html#create).

이 예에서는 `mydb`라는 데이터베이스가 작성됩니다.

이 예에서 데이터베이스에 사용되는 이름은 중요하지 않지만, 같은 이름을 사용하면 내용을 충실히 따르고 있는지 명확하게 알 수 있습니다.

```sh
curl https://myaccount-dc1.cloudant.com/mydb -XPUT -u myaccount-dc1
curl https://myaccount-dc2.cloudant.com/mydb -XPUT -u myaccount-dc2
```
{:codeblock}

## 2단계: 복제를 위한 API 키 작성

연속 복제에는 [API 키](../api/authorization.html#api-keys)를 사용하는 것이 좋습니다.
API 키의 장점은 비밀번호가 재설정되는 등과 같이 기본 계정 세부사항이 변경되더라도 복제를 변경하지 않고 계속할 수 있다는 점입니다.

API 키는 하나의 계정에 종속되지 않습니다.
이 특성은 하나의 API 키를 작성한 후, 두 계정에 대해
적절한 데이터베이스 권한을 부여할 수 있음을 의미합니다.

예를 들어, 다음 명령은 계정 `myaccount-dc1`의 API 키를 요청합니다.

```sh
$ curl -XPOST https://myaccount-dc1.cloudant.com/_api/v2/api_keys -u myaccount-dc1
```
{:codeblock}

성공적인 응답은 다음 축약된 예와 유사합니다.

```json
{
  "password": "YPN...Tfi",
  "ok": true,
  "key": "ble...igl"
}
```
{:codeblock}

> **참고**: 비밀번호를 주의하여 기록하십시오.
  이 비밀번호는 나중에 검색할 수 없습니다.

### 3단계: 액세스 권한 부여

두 데이터베이스에서 모두 읽고 쓸 수 있도록 [API 키에 권한을 부여하십시오](../api/authorization.html#modifying-permissions).

인덱스를 복제하려는 경우에는 관리자 권한을 지정하십시오.

{{site.data.keyword.cloudant_short_notm}} 대시보드를 사용하거나, 프로그래밍 방식으로 권한을 부여하는 방법의 세부사항에 대해 [권한 부여](../api/authorization.html) 정보를 참조하십시오.

### 4단계: 복제 설정

{{site.data.keyword.cloudant_short_notm}}에서의 복제는 항상 단방향(한 데이터베이스에서 다른 데이터베이스로)입니다.
따라서 두 데이터베이스 간에 복제를 수행하려면 각 방향에 대해 하나씩, 두 개의 복제가 필요합니다.

[이전](#step-2-create-an-api-key-for-your-replications)에 작성된 API 키를 사용하는 복제는 각 계정에서 작성됩니다.

먼저, 데이터베이스 `myaccount-dc1.cloudant.com/mydb`에서 데이터베이스 `myaccount-dc2.cloudant.com/mydb`로의 복제를 작성하십시오.

```sh
curl -XPOST 'https://myaccount-dc1.cloudant.com/_replicator'
	-u myaccount-dc1
	-H 'Content-type: application/json'
	-d '{ "_id": "mydb-myaccount-dc1-to-myaccount-dc2",
	"source": "https://ble...igl:YPN...Tfi@myaccount-dc1.cloudant.com/mydb",
	"target": "https://ble...igl:YPN...Tfi@myaccount-dc2.cloudant.com/mydb",
	"continuous": true
}'
```
{:codeblock}

그 다음에는 데이터베이스 `myaccount-dc2.cloudant.com/mydb`에서 데이터베이스 `myaccount-dc1.cloudant.com/mydb`로의 복제를 작성하십시오.

```sh
curl -XPOST 'https://myaccount-dc2.cloudant.com/_replicator'
	-u myaccount-dc2
	-H 'Content-type: application/json'
	-d '{ "_id": "mydb-myaccount-dc2-to-myaccount-dc1",
	"source": "https://ble...igl:YPN...Tfi@myaccount-dc2.cloudant.com/mydb",
	"target": "https://ble...igl:YPN...Tfi@myaccount-dc1.cloudant.com/mydb",
	"continuous": true
}'
```
{:codeblock}

> **참고:** `_replicator` 데이터베이스가 없어 이 단계가 실패하는 경우에는 이를 작성하십시오.

### 5단계: 복제 테스트

두 데이터베이스에서 문서를 작성하고, 수정하고 삭제하여 복제 프로세스를 테스트하십시오.

한 데이터베이스의 각 변경 후에, 해당 변경이 다른 데이터베이스에 반영되는지 확인하십시오.

### 6단계: 애플리케이션 구성

이 시점에서, 두 데이터베이스는 설정되어 서로 동기화된 상태를 유지합니다.

다음 의사결정은 데이터베이스를 [활성-활성](#active-active) 방식으로 사용할지, 또는 [활성-수동](#active-passive) 방식으로 사용할지 결정하는 것입니다.

#### 활성-활성

활성-활성 구성에서는 서로 다른 애플리케이션 인스턴스가 서로 다른 데이터베이스에 데이터를 기록할 수 있습니다.

예를 들어, 애플리케이션 'A'가 데이터베이스 `myaccount-dc1.cloudant.com/mydb`에 데이터를 기록하는 중에
애플리케이션 'B'가 데이터베이스 `myaccount-dc2.cloudant.com/mydb`에 데이터를 기록할 수 있습니다.

이 구성은 몇 가지 이점을 제공합니다.

- 여러 계정으로 로드를 분산할 수 있습니다.
- 대기 시간이 짧은 계정(항상 지리적으로 가장 가까운 것은 아님)에 액세스하도록 애플리케이션을 구성할 수 있습니다.

'가장 가까운' {{site.data.keyword.cloudant_short_notm}} 계정과 통신하도록 애플리케이션을 설정할 수 있습니다.
DC1에서 호스팅되는 애플리케이션의 경우에는 이들의 {{site.data.keyword.cloudant_short_notm}} URL을
`"https://myaccount-dc1.cloudant.com/mydb"`로 설정하는 것이 적절합니다.
마찬가지로, DC2에서 호스팅되는 애플리케이션의 경우에는 {{site.data.keyword.cloudant_short_notm}} URL을 `"https://myaccount-dc2.cloudant.com/mydb"`로 설정합니다.

#### 활성-수동

활성-수동 구성에서는 애플리케이션의 모든 인스턴스가 기본 데이터베이스를 사용하도록 구성됩니다.
그러나 상황에 따라 애플리케이션은 다른 백업 데이터베이스로 장애 복구할 수 있습니다.
이 장애 복구는 애플리케이션 로직 자체에 구현되거나, 로드 밸런서 또는 기타 수단을 사용하여 구현될 수 있습니다.

장애 복구의 필요 여부에 대한 간단한 테스트는 기본 데이터베이스 엔드포인트를 '하트비트'로 사용하는 것입니다.
예를 들면, 기본 데이터베이스 엔드포인트에 전송된 단순 `GET` 요청은 일반적으로
[데이터베이스의 세부사항](../api/database.html#getting-database-details)을 리턴합니다.
응답이 수신되지 않는 경우 이는 장애 복구가 필요함을 나타낼 수 있습니다.

#### 기타 구성

구성에 대해 다른 하이브리드 접근법을 고려할 수도 있습니다.

예를 들어, '쓰기-기본, 읽기-복제본' 구성에서는 모든 쓰기가 하나의 데이터베이스에 전송되지만 읽기 로드는 복제본 간에 분산됩니다.

### 7단계: 다음 단계

* 데이터베이스 간 [복제](../api/advanced_replication.html)를 모니터하는 것을 고려하십시오.
  모니터링 데이터를 사용하여 구성을 추가로 최적화할 수 있는지 판별하십시오.
*	디자인 문서 및 인덱스가 배치되어 업데이트되는 방식을 고려하십시오.
  이러한 태스크를 자동화하는 것이 더 효율적일 수 있습니다.

## {{site.data.keyword.cloudant_short_notm}} 지역 간 장애 복구

일반적으로 지역 또는 데이터 센터 간 장애 복구 관리의 프로세스는 애플리케이션 서버 장애 복구 변경사항 구성 또는 로드 밸런싱 등과 같이 애플리케이션 스택의 상부에서 처리됩니다.

{{site.data.keyword.cloudant_short_notm}}에서는 사용자가 명시적으로 지역 간 장애 복구 또는 다시 라우팅 요청을 관리할 수 있도록 하는 기능을 제공하지 않습니다.
이 제한조건은 부분적으로는 기술적인 이유로 인해 발생하며, 다른 이유는 이러한 상황이 발생하는 조건이 애플리케이션에 따라 다르기 때문입니다.
예를 들면, 사용자 정의 성능 메트릭에 대한 응답으로 장애 복구를 강제하려 할 수 있습니다.

그러나 장애 복구를 관리하는 기능이 필요한 경우에는 다음과 같은 몇 가지 옵션을 사용할 수 있습니다.

* [{{site.data.keyword.cloudant_short_notm}} 앞에 고유의 HTTP 프록시 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://github.com/greenmangaming/cloudant-nginx){:new_window}를 삽입합니다.
  {{site.data.keyword.cloudant_short_notm}} 인스턴스가 아니라 프록시와 통신하도록 애플리케이션을 구성하십시오.
  이 구성은 애플리케이션이 사용하는 {{site.data.keyword.cloudant_short_notm}} 인스턴스의 변경 태스크를
  애플리케이션 설정 수정 대신 프록시 구성 수정을 통해 처리할 수 있음을 의미합니다.
  많은 프록시에는 사용자 정의 상태 검사에 따라 로드 밸런싱을 수행하는 기능이 있습니다.
* [Traffic Director ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](http://dyn.com/traffic-director/){:new_window}와 같은 글로벌 로드 밸런서를 사용하여 {{site.data.keyword.cloudant_short_notm}}로 라우팅합니다.
  이 옵션은 상태 검사 또는 대기 시간 규칙에 따라 다른 {{site.data.keyword.cloudant_short_notm}} 계정으로 라우팅하는 `CNAME` 정의를 필요로 합니다.

## 장애 복구

하나의 {{site.data.keyword.cloudant_short_notm}} 인스턴스가 도달 불가능한 경우에는
이 인스턴스가 다시 도달 가능 상태가 된 직후 여기에 트래픽을 경로 재지정하지 않도록 하십시오.
이는 피어로부터 데이터베이스 상태를 동기화하고 인덱스를 최신 상태로 유지하는 등의 중요 태스크를
수행하는 데 어느 정도 시간이 필요하기 때문입니다.

데이터베이스가 프로덕션 트래픽을 처리하기에 적합한 상태인지 파악하는 데 도움을 줄 수 있도록 이러한 태스크를 모니터하는 메커니즘을 갖추는 것이 좋습니다.

참고 사항으로서, 일반적으로 적용되는 검사의 목록은 다음과 같습니다.

* [복제](#replications)
* [인덱스](#indexes)

> **참고:** 상태 검사에 따른 요청 다시 라우팅 또는 장애 복구를 구현하는 경우에는 아직 복구 중인 서비스 인스턴스로 다시 라우팅하지 않도록 하는 해당 검사를 포함시키는 것이 좋습니다.

### 복제

* 오류 상태인 복제가 있습니까?
* 다시 시작이 필요한 복제가 있습니까?
* 몇 개의 보류 변경사항이 데이터베이스에서 복제를 기다리고 있습니까?

복제 상태 모니터링에 대한 자세한 정보는 [여기](../api/advanced_replication.html#replication-status)에 있습니다.

> **참고:** 데이터베이스가 지속적으로 변경되고 있는 경우에는 복제 상태가 0이 아닐 가능성이 높습니다.
  어떤 상태 임계값이 허용 가능한지, 또는 오류 상태를 나타내는지는 사용자가 결정해야 합니다.

### 인덱스

* 인덱스가 충분히 최신 상태입니까?
  [활성 태스크](../api/active_tasks.html) 엔드포인트를 사용하여 이를 검사하십시오.
* 인덱스에 조회를 전송하고, 허용 가능한 시간 내에 리턴되는지 판별하여 '인덱스 준비 상태'의 레벨을 테스트하십시오.
