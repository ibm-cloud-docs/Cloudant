---

copyright:
  years: 2019
lastupdated: "2019-06-12"

keywords: database shards, non-partitioned databases, partition key, global query, partition query, create partition database, create partition query index

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

<!-- Acrolinx: 2018-08-17 -->

# 데이터베이스 파티셔닝
{: #database-partitioning}

{{site.data.keyword.cloudantfull}}는 두 가지 유형의 데이터베이스를 지원합니다.

- 파티션됨
- 파티션되지 않음

_파티션된_ 데이터베이스는 성능이 향상되고 비용이 적게 들지만
사용자가 데이터의 논리 파티션을 지정해야 합니다. 이는 다음 텍스트에
자세히 설명되어 있습니다. 

또는 _파티션되지 않은_ 데이터베이스를 작성할 수 있습니다. 이 유형의 데이터베이스는
파티셔닝 스킴을 정의하지 않고도 쉽게 작업 가능하지만 글로벌 2차 인덱스만 작성할 수 있습니다.

{{site.data.keyword.cloudant_short_notm}}에서는 데이터 모델이 문서의 논리 파티셔닝을
허용하는 최상의 장기 데이터베이스 성능을 위해 파티션된 데이터베이스를
사용하는 것이 좋습니다.

데이터베이스의 파티셔닝 유형은 데이터베이스 작성 시에 설정됩니다.  데이터베이스를
작성할 때 `partitioned` 조회 문자열 매개변수를 사용하여 데이터베이스가 파티션되는지 여부를
설정하십시오. 기본값 `partitioned`는 `false`이고,
역호환성을 유지합니다.

기존 데이터베이스의 파티셔닝 유형을 변경할 수 없습니다.

## 데이터베이스 샤드
{: #database-shards}

이 문서를 읽기 전에 {{site.data.keyword.cloudant_short_notm}} 내
[샤딩 개념](/docs/services/Cloudant?topic=cloudant-how-is-data-stored-in-ibm-cloudant-#how-is-data-stored-in-ibm-cloudant-)을 이해해야 합니다.

## 파티션되지 않은 데이터베이스
{: #non-partitioned-databases}

파티션되지 않은 데이터베이스는 이전 유형의 {{site.data.keyword.cloudant_short_notm}} 데이터베이스와 이전에 CouchDB 또는 {{site.data.keyword.cloudant_short_notm}}를 사용했다면 익숙할 데이터베이스입니다.

파티션되지 않은 데이터베이스 내에서 문서는 문서 ID의 변환에 따라
임의의 방식으로 샤드에 분배됩니다. 따라서 문서의 ID와 문서가 배치되는
샤드 간에 실제 관계는 없습니다. 유사한 문서 ID를 가진 문서가 동일한
샤드에 배치될 가능성은 별로 없습니다.

파티션되지 않은 데이터베이스는 글로벌 조회만 제공하며, 이는 뒤에
더 자세히 설명되어 있습니다. 

## 파티션된 데이터베이스
{: #partitioned-databases-database-partitioning}

파티션된 데이터베이스는 최신 유형의 {{site.data.keyword.cloudant_short_notm}} 데이터베이스입니다. 파티션된
데이터베이스 내에서 문서는 파티션된 데이터베이스 내 문서의
문서 ID의 일부인 _파티션 키_를 사용하여 논리 파티션으로
구성됩니다. 모든 문서는 파티션에 지정되며 많은 문서에 일반적으로
동일한 파티션 키가 지정됩니다. 파티션의 기본 JSON 데이터 및 해당
인덱스가 함께 위치하게 되며, 이는 데이터베이스가 파티션 내에서
효율적으로 데이터를 조회할 수 있음을 의미합니다.

파티션된 데이터베이스는 파티션된 조회와 글로벌 조회 둘 다 제공합니다. 파티션된
조회는 데이터베이스 클러스터 내에서 데이터 레이아웃을 이용하여 향상되고 확장성이
높아진 조회 성능을 제공합니다. 또한 파티션 조회는 종종 글로벌 조회보다
저렴합니다.

파티션된 데이터베이스가 글로벌 조회와 파티션 조회의 이점을 모두
제공하므로 {{site.data.keyword.cloudant_short_notm}}는 새 애플리케이션이 이러한 이점을 이용하도록 권장합니다.

## 좋은 파티션 키를 만드는 요소
{: #what-makes-a-good-partition-key-}

{{site.data.keyword.cloudant_short_notm}}의 새 *파티션된 데이터베이스* 기능 사용을 고려하고 있는 경우
파티션 키 선택이 매우 중요합니다. 파티션 키는 다음을 포함해야 합니다.

- 많은 값 - 많은 수의 작은 파티션이 적은 수의 큰 파티션보다 좋습니다.
- 핫스팟 없음 - 하나의 파티션이 워크로드의 많은 부분을 처리하도록 하는
  시스템 설계를 피합니다. 작업이 파티션에 균등하게 분배되면 데이터베이스가
  더 원활하게 수행됩니다.
- 반복 - 각 파티션 키가 고유하면 파티션당 하나의 문서가
  있습니다. 파티션된 데이터베이스를 최대한 활용하려면 파티션당
  여러 개의 문서(논리적으로 한 세트인 문서)가 있어야 합니다.

몇 가지 유스 케이스와 파티션 키에 대한 좋은 선택과 잘못된 선택을 살펴봅니다.

| 유스 케이스                   |설명                 | 파티션 키 | 효과                                                                                                  |
|----------------------------|-----------------------------|---------------|------------------------------------------------------------------------------------------------------------------|
| 전자 상거래 시스템 - 주문 | 주문당 하나의 문서     | order_id      | 보통 - 파티션당 하나의 문서는 괜찮지만 파티션 조회의 이점을 제공하지는 않습니다.          |
| 전자 상거래 시스템 - 주문 | 주문당 하나의 문서     | user_id       | 좋음- 사용자의 모든 주문이 함께 보관됩니다.                                                             |
| 전자 상거래 시스템 - 주문 | 주문당 하나의 문서      | status        | 잘못됨 - 소수의 상태 값(임시, 지불됨, 환불됨, 취소됨)으로 주문을 그룹화하면 지나치게 큰 파티션이 너무 적게 작성됩니다.  |
| 블로깅 플랫폼          | 블로그 포스트당 하나의 문서 | author_id     | 좋음 - 작성자가 많은 경우에 해당합니다. 각 작성자의 포스트를 쉽게 조회할 수 있습니다.                                     |
| IOT - 센서 표시값      | 표시값당 하나의 문서    | device_id     | 좋음 - 디바이스가 많은 경우에 해당합니다. 하나의 디바이스가 다른 디바이스보다 많은 표시값을 생성하지 않는지 확인하십시오. |
| IOT - 센서 표시값      | 표시값당 하나의 문서    | date          | 잘못됨 - 현재 표시값으로 인해 현재 날짜의 파티션에 "핫스팟"이 발생합니다.                                  |

파티션 키에 실행 가능한 선택사항이 없는 경우가 있습니다.
이러한 상황에서는 파티션되지 않은 데이터베이스가 최상의 선택입니다. 예를 들어, 이메일 주소,
비밀번호 해시 및 마지막 로그인 날짜를 저장하는 사용자 데이터베이스입니다. 이러한 필드 중에 적합한
파티션 키를 사용하는 필드가 없으므로, 파티션되지 않은 일반 데이터베이스를 대신 사용해야 합니다.

## 조회
{: #querying}

이 절에서는 애플리케이션이 작성해야 하는 각 조회에
가장 적합한 조회 메커니즘을 선택할 수 있게 하는 기본 조회
메커니즘에 대한 간단한 개요와 함께 글로벌 및 파티션 조회에
사용 가능한 {{site.data.keyword.cloudant_short_notm}}의 조회 유형을 설명합니다.

### 글로벌 조회
{: #global-querying}

다음 인덱스 유형에 대한 글로벌 조회를 작성할 수 있습니다.

- {{site.data.keyword.cloudant_short_notm}} 조회
- 보기
- 검색
- 위치

글로벌 조회를 작성할 때 데이터베이스는 데이터베이스의 모든 데이터에서
분산-수집 조작을 수행해야 합니다. 즉, 많은 개별 데이터베이스 서버의 요청을
작성합니다. API 조정 노드는 이러한 모든 서버의 응답을 수신하고 이를 결합하여
클라이언트에 대한 단일 응답을 구성합니다. 이를 위해서 데이터를 버퍼링하고
클라이언트에 대한 응답을 지연시킬 수 있습니다(예: 데이터에 정렬이
필요한 경우).

### 파티션 조회
{: #partition-querying}

다음 인덱스 유형에 대한 파티션 조회를 작성할 수 있습니다.

- {{site.data.keyword.cloudant_short_notm}} 조회
- 보기
- 검색

파티션 조회를 작성할 때 데이터베이스는 단일 파티션 내에서 데이터를
조회할 수 있습니다. 파티션의 데이터가 하나의 샤드(세 개의 복제본 포함)에
있을 때 API 조정 노드는 많은 서버의 응답을 결합하는 대신 데이터를 호스팅하는
서비스에 직접 요청할 수 있습니다. 또한 수행할 조합 단계가 없으므로 응답에
버퍼링이 발생하지 않습니다. 따라서 데이터가 신속하게 클라이언트에
도달합니다.

또한 데이터베이스의 크기가 증가함에 따라 샤드의 수도 증가해야
합니다. 이는 API 조정 노드가 글로벌 조회를 사용할 때 데이터를
호스팅하는 서버에 대해 작성해야 하는 조회 수를 직접적으로
증가시킵니다. 그러나 파티션 조회를 사용하는 경우 샤드 수는
API 조정 노드가 접속해야 하는 서버의 수에 영향을 주지 않습니다. 이 수가
작으므로 데이터 크기를 늘리면 글로벌 조회와 달리 조회 대기 시간에 영향을
주지 않습니다.

## 예제: IoT 표시값 데이터 파티셔닝
{: #example-partitioning-iot-reading-data}

이 논의는 매우 추상적이므로 예를 들어 구체적으로 설명합니다. Internet of Things
도메인을 사용하여 {{site.data.keyword.cloudant_short_notm}}를 디바이스 표시값의 히스토리언으로서
사용하는 일을 살펴봅니다. 디바이스가 도로나 교량과 같은 인프라의 일부에 대한
센서 표시값을 제공한다고 가정하십시오.

다음과 같이 가정합니다.

- 수백 또는 수천 개의 디바이스가 표시값을 보고합니다.
- 각 디바이스에 고유 ID가 있습니다.
- 인프라의 각 부분에 고유 ID가 있습니다.
- 인프라의 부분들 간에 디바이스가 이동하지 않습니다.
- 각 디바이스가 10초마다 {{site.data.keyword.cloudant_short_notm}}에 대한 표시값을 기록합니다. 이는
    메시지 버스를 통해 {{site.data.keyword.cloudant_short_notm}}로 전달될 가능성이 높습니다.

파티션되지 않은 데이터베이스에서 {{site.data.keyword.cloudant_short_notm}}가 문서 ID를 생성하게 할 수
있습니다. 다른 대안은 디바이스 ID와 레코드 시간소인으로 문서의 이름을 지정하는 것입니다.

두 번째 방식을 사용하면 다음과 같은 문서 ID를 받게 됩니다.

```
device-123456:20181211T11:13:24.123456Z
```

또한 시간소인은 epoch 시간소인일 수 있습니다.

이 방식은 각 디바이스의 데이터를 파티션된 인덱스를 사용하여
효율적으로 조회할 수 있지만, 여러 디바이스(예를 들어, 지정된 인프라의
일부에 대한 모든 디바이스)에 대한 보기를 작성하려면 글로벌 인덱스를
사용해야 합니다.

예시를 위해, 대부분의 애플리케이션이 개별 디바이스가 아닌 지정된
인프라의 일부에 대한 센서 데이터를 모두 읽어야 한다고 가정하여
보다 복잡한 시나리오를 작성합니다.

이 애플리케이션에서 인프라 팀에 의한 조회가 보다 효율적으로 이루어지길 원하므로,
데이터를 인프라의 일부를 기준으로 파티션하는 것이 ID를 기준으로 파티션하는
경우보다 훨씬 더 많은 의미를 갖게 됩니다. 이렇게 하면 지정된 인프라의 일부에 대한
모든 디바이스를 하나의 그룹으로 효율적으로 조회할 수 있습니다.

드물게 이루어지는 디바이스별 조회의 경우 다음과 같은 두 가지 방법이 있습니다.

1. 디바이스별로 키가 부여된 글로벌 인덱스를 빌드하고 이를 조회합니다. 이는 개별
    디바이스에 대한 조회가 드물고 반복되지 않는 경우에 더 효과적입니다.
2. 디바이스를 인프라에 맵핑하는 글로벌 인덱스를 빌드한 다음 인프라 파티션에
    대한 파티션 조회를 발행합니다. 이는 맵핑을 캐시할 수 있으므로 지정된
    디바이스에 대한 반복되는 조회가 사용되는 경우에 타당합니다. 애플리케이션의
    경우에 해당하는 것으로 가정합니다.

작동 방식을 살펴봅니다. 다음과 같은 네 가지 조회가 있습니다.

1. 인프라의 일부에 대한 영구 표시값.
1. 인프라의 일부에 대한 오늘의 표시값.
1. 특정 디바이스에 대한 영구 표시값.
1. 특정 디바이스에 대한 오늘의 표시값.

### 데이터베이스 작성
{: #creating-the-database}

데이터베이스 `readings` 및 계정 `acme`를
사용합니다. 이를 파티션된 데이터베이스로 작성하려면 `true`를
`partitioned` 인수로서 데이터베이스 작성 요청에 전달하십시오.

```
curl -XPUT 'https://acme.cloudant.com/readings?partitioned=true'
```

### 문서 구조
{: #document-struture}

먼저 다음과 같이 작업할 단순 문서 형식을 정의합니다.

```json
{
    "deviceID": "device-123456",
    "infrastructureID": "bridge-9876",
    "ts": "20181211T11:13:24.123456Z",
    "reading": {
        "temperature": {"value": 12, "unit": "c"}
    }
}
```

이 문서의 경우, 인프라의 일부를 기반으로 파티셔닝 스킴을 사용하면
문서 ID가 인프라 ID를 파티션 키로 포함하고 디바이스 및 시간소인을
문서 키로 포함할 수 있습니다.

```
bridge-9876:device-123456-20181211T11:13:24.123456Z
```

### 인덱스 작성
{: #creating-indexes}

이전에 설명된 조회의 경우에는 두 개의 인덱스가 필요합니다. 

1. 디바이스 ID를 인프라 ID에 맵핑하는 글로벌 인덱스.
2. 디바이스 ID를 표시값에 맵핑하는 파티션된 인덱스.

#### 글로벌 보기 인덱스 작성
{: #creating-a-global-view-index}

보기 인덱스는 디바이스 ID를 인프라 ID로 맵핑하는 가장
효율적인 방식입니다. 이를 정의하려면 이 인덱스가 글로벌이므로 `options.partitioned`가
`false`로 설정된 디자인 문서를 업로드하십시오. 실제
`map` 함수에서 필드 존재에 대해 더 방어적이 되려고
하면 다음과 같이 표시됩니다.

```json
{
    "_id": "_design/infrastructure-mapping",
    "options": {"partitioned": false},
    "views": {
        "by-device": {
            "map": "function(doc) { emit(doc.deviceID, doc.infrastructureID) }"
        }
    }
}
```

이전 문서가 `./view.json`인 경우 이는 다음 명령을 사용하여
데이터베이스에 업로드됩니다. 

```
curl -XPOST https://acme.cloudant.com/readings -d @view.json
```

#### 파티션된 {{site.data.keyword.cloudant_short_notm}} 조회 인덱스 작성
{: #creating-a-paritioned-ibm-cloudant-query-index}

파티션에서 지정된 디바이스에 대한 표시값을 리턴하기 위해 {{site.data.keyword.cloudant_short_notm}}
조회 인덱스를 사용할 수 있습니다. 이를 위해 `true`로 설정된
`partitioned` 필드가 포함된 인덱스 정의를 사용하여
`_index`로 `POST`합니다. 

조회 인덱스 정의의 경우 `partitioned` 필드가 `options` 오브젝트 내에서
중첩되지 않습니다.
{: note}

조회의 경우 두 개의 파티션된 인덱스가 필요합니다.

1. 시간소인 기준
2. 디바이스 ID 및 시간소인 기준

시간소인 기준의 정의는 다음과 같습니다.

```json
{
   "index": {
      "fields": [
         "ts"
      ]
   },
   "name": "timestamped-readings",
   "type": "json",
   "partitioned:" true
}
```

이전 문서가 `./query-index1.json`인 경우에는 다음 명령을 사용하여
인덱스를 데이터베이스에 업로드하십시오. 

```
curl -XPOST https://acme.cloudant.com/readings/_index -d @query-index1.json
```

디바이스 ID 및 시간소인 기준의 정의는 다음과 같습니다.

```json
{
   "index": {
      "fields": [
         "deviceID",
         "ts"
      ]
   },
   "name": "deviceID-readings",
   "type": "json",
   "partitioned:" true
}
```

이전 문서가 `./query-index2.json`인 경우에는 다음 명령을 사용하여
인덱스를 데이터베이스에 업로드하십시오. 

```
curl -XPOST https://acme.cloudant.com/readings/_index -d @query-index2.json
```

### 조회 작성
{: #making-queries}

전체적으로 네 가지 조회를 작성할 수 있습니다.

1. 인프라의 일부에 대한 영구 표시값.
1. 인프라의 일부에 대한 오늘의 표시값.
1. 특정 디바이스에 대한 영구 표시값.
1. 특정 디바이스에 대한 오늘의 표시값.

#### 인프라의 일부에 대한 모든 표시값 찾기
{: #finding-all-readings-for-a-piece-of-infrastructure}

파티션이 인프라 기반인 경우 파티션에 `_all_docs`를
사용할 수 있습니다. 예를 들어, 다음과 같이 `bridge-1234`
인프라 일부에 대한 모든 표시값을 조회합니다.

```
curl -XGET \
    'https://acme.cloudant.com/readings/_partition/bridge-1234/_all_docs?include_docs=true'
```

#### 인프라의 한 부분에 대한 최신 표시값 찾기
{: #finding-recent-readings-for-a piece-of-infrastructure}

이 조회는 파티션된 `timestamped-readings` 인덱스를 사용해야 합니다. 파티션에 대한
조회를 발행하여 오늘의 표시값을 가져올 수 있습니다.

_query.json이며, 오늘이 2018년 12월 13일이라고 가정:_

```json
{
    "selector": {
        "ts": { "$gte": "20181213"}
    }
}
```

파티션은 {{site.data.keyword.cloudant_short_notm}}에 대한 요청을 발행할 때 HTTP 경로에 임베드됩니다.

```
curl -XPOST \
    'https://acme.cloudant.com/readings/_partition/bridge-1234/_find' \
    -d @query.json
```

#### 디바이스에 대한 인프라 ID 찾기
{: #finding-the-infrastructure-id-for-a-device}

아직 수행하지 않은 두 개의 조회는 다음과 같습니다.

1. 특정 디바이스에 대한 영구 표시값.
2. 특정 디바이스에 대한 오늘의 표시값.

이러한 두 조회의 경우 글로벌 `by-device` 인덱스를 사용하여 디바이스의
파티션을 찾아야 합니다. 그런 다음 표시값을 위한 개별 파티션을 조회할 수
있습니다. 글로벌 인덱스를 사용하여 개별 디바이스에 대한 표시값을
조회했을 수 있지만 디바이스에서 인프라 ID로의 맵핑은 캐시 가능성이
높으므로(변경되지 않음) 이 방식을 통해 대부분의 요청에서 더
저렴하고 더 효율적인 파티션된 조회를 많이 사용할 수 있습니다.

인프라 맵핑에 대한 디바이스 캐싱이 지정된 애플리케이션에서 제대로 작동하지
않는 경우 글로벌 인덱스를 사용하여 디바이스 표시값을 직접 조회하는 것이 더 효과적일 수
있습니다.

디바이스의 관련 파티션을 찾기 위해 디바이스 ID를 키로 보내
`by-device` 보기를 조회합니다.

```
curl -XGET \
  'https://acme.cloudant.com/readings/_design/infrastructure-mapping/_view/by-device?keys=["device-123456"]&limit=1'
```

다음이 리턴됩니다.

```json
{"total_rows":5,"offset":0,"rows":[
{
    "id":"bridge-9876:device-123456-20181211T11:13:24.123456Z",
    "key":"device-123456",
    "value":"bridge-9876"
}
]}
```

포함된 행의 `value` 필드에 파티션 키가 포함됩니다.
`bridge-9876`.

#### 디바이스에 대한 모든 결과 조회
{: #querying-for-all-results-for-a-device}

디바이스의 결과를 얻으려면 `bridge-9876` 파티션 내에서
디바이스의 파티션 조회를 발행합니다. 표준 {{site.data.keyword.cloudant_short_notm}} 조회 선택기는
글로벌 조회를 발행하는 것처럼 사용됩니다.

_query.json:_

```json
{
   "selector": {
      "deviceID": {
         "$eq": "device-123456"
      }
   }
}
```

파티션은 {{site.data.keyword.cloudant_short_notm}}에 대한 요청을 발행할 때 HTTP 경로에 임베드됩니다.

```
curl -XPOST \
    'https://acme.cloudant.com/readings/_partition/bridge-1234/_find' \
    -d @query.json
```

#### 디바이스에 대한 최신 결과 조회
{: #querying-for-recent-results-for-a-device}

디바이스의 결과를 얻으려면 `bridge-9876` 파티션 내에서
디바이스의 파티션 조회를 발행합니다. 선택기는 약간 더 복잡하지만,
여전히 해당 글로벌 조회와 같습니다.

_query.json이며, 오늘이 2018년 12월 13일이라고 가정:_

```json
{
   "selector": {
      "deviceID": {
         "$eq": "device-123456"
      },
      "ts": {
         "$gte": "20181213"
      }
   }
}
```

파티션은 {{site.data.keyword.cloudant_short_notm}}에 대한 요청을 발행할 때 HTTP 경로에 임베드됩니다.

```
curl -XPOST \
    'https://acme.cloudant.com/readings/_partition/bridge-1234/_find' \
    -d @query.json
```
