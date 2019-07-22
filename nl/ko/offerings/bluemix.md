---

copyright:
  years: 2015, 2019
lastupdated: "2019-06-12"

keywords: standard plan, lite plan, dedicated hardware plan, event type, provisioned throughput capacity, consumption, capacity, monitor usage, data usage, size limits, locations, tenancy, authentication methods, high availability, disaster recovery, backup, support

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

# 플랜 및 프로비저닝
{: #ibm-cloud-public}

{{site.data.keyword.cloudantfull}} 퍼블릭은 {{site.data.keyword.cloudant_short_notm}}의 최다 기능 오퍼링으로 업데이트와 신규 기능을 제일 먼저 수신합니다. 가격은
프로비저닝된 할당 처리량 용량과 사용되는 데이터 스토리지를 기준으로 책정되며
필수 로드에 맞게 이루어집니다. 
{: shortdesc}

무료 [Lite 플랜](#lite-plan)에는 개발 및 평가 용도로 고정 처리량 용량 및 데이터가 포함됩니다. 유료 [표준 플랜](#standard-plan)은
사용자의 애플리케이션 요구사항이 변경됨에 따라 스케일링되는 구성 가능한 프로비저닝된 처리량 용량 및 데이터 스토리지 가격을 제공합니다.  데디케이티드 하드웨어 환경에서 하나 이상의 표준 플랜 인스턴스를 실행할 수 있는 추가 월별 비용의 옵션인 [데디케이티드 하드웨어 플랜](#dedicated-hardware-plan)도 이용할 수 있습니다. 데디케이티드 하드웨어 환경은 사용자 단독 사용을 위한 것이며
데디케이티드 하드웨어 플랜 인스턴스가 미국 내에서 프로비저닝된 경우에는
[HIPAA ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://en.wikipedia.org/wiki/Health_Insurance_Portability_and_Accountability_Act){: new_window} - 규제 준수 구성을 선택할 수 있습니다.

## 플랜
{: #plans}

[{{site.data.keyword.cloudant_short_notm}} 서비스 인스턴스를 프로비저닝](#provisioning-a-cloudant-nosql-db-instance-on-ibm-cloud)할 때는
사용할 플랜을 선택할 수 있습니다.
기본적으로, [Lite 플랜](#lite-plan)이 선택됩니다.

![{{site.data.keyword.cloudant_short_notm}} 서비스 인스턴스 플랜 선택](../images/lite_pricing_plan.png)

### Lite 플랜
{: #lite-plan}

Lite 플랜은 무료이며 개발 및 평가 목적을 위해 디자인되었습니다. Lite 플랜 인스턴스는 {{site.data.keyword.cloudant_short_notm}}의 전체 기능을 포함하지만, 프로비저닝된 처리량 용량 및 데이터 스토리지의 양은 고정되어 있습니다. 프로비저닝된 처리량 용량은 20회 읽기/초, 10회 쓰기/초 및 5회 글로벌 조회/초로 고정되며 데이터 스토리지는 1GB로 제한됩니다. 

스토리지 사용량은 매일 확인됩니다. 1GB 스토리지 한계를 초과하면 {{site.data.keyword.cloudant_short_notm}} 인스턴스에 대한
HTTP 요청이 402 상태 코드와 함께 오류 메시지 "Account has exceeded its data usage quota. An upgrade to a paid plan is required."를 수신합니다.
{{site.data.keyword.cloudant_short_notm}} 대시보드에도 배너가 표시됩니다. 사용자는 여전히 데이터를 읽고 삭제할 수 있습니다. 그러나 새 데이터를 기록하는 데는 두 가지 선택사항이 있습니다. 첫 번째로, 사용자는 쓰기 한계를 즉시 제거하는 유료 [표준 플랜](#standard-plan)으로 업그레이드할 수 있습니다. 또는 전체 스토리지가 1GB 한계를 초과하지 않도록 데이터를 삭제한 후 다음 날의 일별 스토리지 확인까지 기다려 인스턴스가 다시 쓰기를 허용하도록 할 수 있습니다. 

1GB보다 많은 데이터를 저장하려 하거나 프로비저닝된 처리량 용량을 스케일링할 수 있도록 하려면 [표준 플랜](#standard-plan)으로 변경하십시오.

{{site.data.keyword.cloudant_short_notm}} Lite 플랜은 {{site.data.keyword.cloud_notm}} 계정당 하나로 제한됩니다. 이미 하나의 Lite 플랜 인스턴스가 있는 경우에는 새 Lite 플랜 인스턴스를 작성하려 하거나 표준 플랜 인스턴스를 Lite 플랜으로 변경하려 하면 "You can only have one instance of a Lite plan per service. To create a new instance, either delete your existing Lite plan instance or select a paid plan."이라는 메시지가 리턴됩니다. 
{: note}

### 표준 플랜
{: #standard-plan}

{{site.data.keyword.cloudant_short_notm}} 표준 플랜은 모든 유료 {{site.data.keyword.cloud}} 계정에서 종량과금제 또는 구독 형식으로 사용 가능하며 사용자 애플리케이션의 필요에 맞춰 스케일링할 수 있습니다. 표준 플랜의 가격은 두 가지 요소, 즉 할당된 프로비저닝된 처리량 용량과 인스턴스에 저장된 데이터의 양을 기반으로 책정됩니다. 

가격은 100회 읽기/초, 50회 쓰기/초 및 5회 글로벌 조회/초의 프로비저닝된 처리량 용량을 시작으로 시간당 비례 계산되며, 시작 비용은 $0.105/시간(USD)입니다. {{site.data.keyword.cloudant_short_notm}} 대시보드에서 100회 읽기/초, 50회 쓰기/초, 5회 글로벌 조회/초 단위로 프로비저닝된 처리량 용량을 늘리거나 줄일 수 있습니다. 비용은 할당된 프로비저닝된 처리량 용량에 대해 계산되며 측정된 요청의 양에 따라 계산되지는 않습니다. 표준 플랜에는 20GB의 데이터 스토리지가 포함되어 있습니다. 20GB를 초과하여 저장하면 GB/시간당 정의된 비용이 청구됩니다. 

다양한 용량 및 통화의 가격, 그리고 비용 예상 예에 대한 [가격](/docs/services/Cloudant?topic=cloudant-pricing#pricing){: new_window} 정보는 {{site.data.keyword.cloud_notm}} 가격 계산기를 참조하십시오.

### 데디케이티드 하드웨어 플랜
{: #dedicated-hardware-plan}

{{site.data.keyword.cloudant_short_notm}} 데디케이티드 하드웨어 플랜 인스턴스는 {{site.data.keyword.cloudant_short_notm}} 표준 플랜 인스턴스만을 사용하기 위해 프로비저닝되는 베어메탈 {{site.data.keyword.cloudant_short_notm}} 환경입니다. {{site.data.keyword.cloudant_short_notm}} 데디케이티드 하드웨어 플랜 환경은 모든 [{{site.data.keyword.IBM}} 글로벌 데이터 센터 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://www.ibm.com/cloud/data-centers/){:new_window}에서 프로비저닝될 수 있습니다. 이 플랜은 HIPAA 규제 준수에 필요하며 프로비저닝할 때 선택해야 합니다. {{site.data.keyword.cloudant_short_notm}} 데디케이티드 하드웨어 플랜 환경의 사용자는 {{site.data.keyword.IBM_notm}} Key Protect를 사용하여 IP 화이트리스트와 BYOK(Bring-Your-Own-Key) 고객 관리 암호화 키를 사용할 수 있습니다. 또한 2019년 1월 1일 이후 EU 관리 환경 외부에 프로비저닝된 데디케이티드 하드웨어 환경에는 이 환경에 배치된 모든 표준 플랜 인스턴스에 대한 내부 엔드포인트가 포함됩니다. 내부 엔드포인트를 사용하면 고객이 내부 {{site.data.keyword.cloud}} 네트워크를 통해 {{site.data.keyword.cloudant_short_notm}} 인스턴스에 연결하여 업스트림 애플리케이션 트래픽이 공용 네트워크를 통하지 않으며 대역폭 비용을 발생시키지 않도록 할 수 있습니다. {{site.data.keyword.cloud}} 계정에 대해 서비스 엔드포인트를 사용으로 설정하는 데 대한 자세한 정보는 [서비스 엔드포인트 문서 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://cloud.ibm.com/docs/services/service-endpoint/getting-started.html#about){:new_window}를 참조하십시오. 

사용자는 하나 이상의 표준 플랜 인스턴스를 프로비저닝할 수 있으며, 데디케이티드 하드웨어 환경은 표준 플랜 인스턴스가 사용하는 용량 및 데이터를 기반으로 필요에 따라 확장되거나 축소됩니다. {{site.data.keyword.cloudant_short_notm}} 데디케이티드 하드웨어 플랜 인스턴스의 가격은 배치된 표준 플랜 인스턴스의 이용 가격에 더해진 고정 가격입니다. 비용 청구는 일별로 비례 계산되며, 환경에 대해서는 최소 1개월의 기간이 비용 청구됩니다. {{site.data.keyword.cloudant_short_notm}} 데디케이티드 하드웨어 플랜의 프로비저닝은 비동기로 이뤄지며 5 - 7영업일이 소요될 수 있습니다. {{site.data.keyword.cloudant_short_notm}} 데디케이티드 하드웨어 플랜 인스턴스를 작성하고 여기에 표준 플랜 인스턴스를 프로비저닝하려는 경우에는 [{{site.data.keyword.cloud_notm}}에서 {{site.data.keyword.cloudant_short_notm}} 데디케이티드 하드웨어 플랜 인스턴스 작성 및 활동](/docs/services/Cloudant?topic=cloudant-creating-and-leveraging-an-ibm-cloudant-dedicated-hardware-plan-instance-on-ibm-cloud#creating-and-leveraging-an-ibm-cloudant-dedicated-hardware-plan-instance-on-ibm-cloud) 튜토리얼을 따르십시오.  

{{site.data.keyword.cloud_notm}} 데디케이티드 고객은 데디케이티드 하드웨어 플랜을 사용할 수 없습니다. 데디케이티드 하드웨어 플랜은 {{site.data.keyword.cloud_notm}} 퍼블릭 고객만 사용할 수 있습니다.
{: important}

## 이벤트 유형
{: #event-types}

프로비저닝되는 처리량은 세 가지 유형의 이벤트 중 하나로 식별되고 측정됩니다.

1.	_읽기_(이전에 검색이라고 함).
    다음과 같습니다.
    1. 특정 문서의 읽기.
    문서의 `_id`를 기반으로 합니다.
    2. _파티션된_ 조회.
        요청 경로의 `_partition` 네임스페이스 내
        {{site.data.keyword.cloudant_short_notm}} 조회 엔드포인트에 대한 요청이며,
        다음 유형을 포함합니다.
        -	1차 인덱스([`_all_docs`](/docs/services/Cloudant?topic=cloudant-databases#get-documents))
        -	MapReduce 보기([`_view`](/docs/services/Cloudant?topic=cloudant-using-views#using-views))
        -	검색 인덱스([`_search`](/docs/services/Cloudant?topic=cloudant-search#queries))
        -	{{site.data.keyword.cloudant_short_notm}} 조회([`_find`](/docs/services/Cloudant?topic=cloudant-query#finding-documents-by-using-an-index))
    
        파티션된 조회 요청에서 이용되는 읽기 조작의 수는
        리턴된 결과에 따라 다릅니다.
2.	_쓰기_.
    개별 문서의 작성,
    수정 또는
    삭제입니다.
3.	글로벌 인덱스에 대한 _글로벌 조회_(이전에 조회라고 함).
        `_partition` 네임스페이스 내에 **없는**
        {{site.data.keyword.cloudant_short_notm}} 조회 엔드포인트에 대한 요청이며,
        다음 유형을 포함합니다.
	-	1차 인덱스([`_all_docs`](/docs/services/Cloudant?topic=cloudant-databases#get-documents))
	-	MapReduce 보기([`_view`](/docs/services/Cloudant?topic=cloudant-using-views#using-views))
	-	검색 인덱스([`_search`](/docs/services/Cloudant?topic=cloudant-search#queries))
	-	지리공간 인덱스([`_geo`](/docs/services/Cloudant?topic=cloudant-cloudant-nosql-db-geospatial#querying-a-cloudant-nosql-db-geo-index))
	-	{{site.data.keyword.cloudant_short_notm}} 조회([`_find`](/docs/services/Cloudant?topic=cloudant-query#finding-documents-by-using-an-index))


## 프로비저닝되는 처리량 용량
{: #provisioned-throughput-capacity}

프로비저닝되는 처리량은 다음 조작 유형의 이벤트로 식별되고
측정됩니다. _읽기_, _쓰기_, _글로벌 조회_.

처리량 수치는 각 유형 이벤트의 초당 개수이며, 여기서 초는 _슬라이딩_ 윈도우입니다.
계정이 플랜에 대해 프로비저닝되는 처리량 이벤트 수를 초과하면 슬라이딩 윈도우 내 이벤트 수가
프로비저닝되는 이벤트 수를 초과하지 않을 때까지 요청이 거부됩니다.
1초의 슬라이딩 윈도우를
연속된 1,000밀리초라고 생각하면 이해하는 데 도움이 됩니다.

예를 들어, 표준 플랜은 초당 200회 읽기를 프로비저닝합니다. 계정은 연속된 1,000밀리초(1초) 동안 최대 200회의 읽기 이벤트를 이용할 수 있습니다. 1,000밀리초의 슬라이딩 기간 중에
이루어진 후속 읽기 요청은 해당 기간 내의 읽기 이벤트 수가 다시 200 미만으로 떨어질 때까지 거부됩니다.

이벤트 수를 초과하여 요청이 거부되면 애플리케이션이 [`429` 너무 많은 요청](/docs/services/Cloudant?topic=cloudant-http#http-status-codes) 응답을 수신합니다.

지원되는 클라이언트 라이브러리([Java](/docs/services/Cloudant?topic=cloudant-supported-client-libraries#java-supported), [Node.js](/docs/services/Cloudant?topic=cloudant-supported-client-libraries#node-js-supported) 및
[Python](/docs/services/Cloudant?topic=cloudant-supported-client-libraries#python-supported) 언어용)의 최신 버전은 `429` 응답을 처리하는 데 도움을 줍니다. 예를 들면,
Java 라이브러리는 [`TooManyRequestsException` ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](http://static.javadoc.io/com.cloudant/cloudant-client/2.5.1/com/cloudant/client/org/lightcouch/TooManyRequestsException.html){: new_window} 응답을
생성합니다.

기본적으로, 지원되는 클라이언트 라이브러리는 `429` 응답이 수신되는 경우 자동으로 요청을 재시도하지 않습니다.

애플리케이션이 `429` 응답을 올바르게 처리하도록 하는 것이 더 바람직합니다.
이는 재시도 횟수가 제한되어 있기 때문입니다.
빈번하게 요청 수가 한계를 초과하는 경우에는 다른 플랜 구성으로 변경하는 것이 좋습니다.

기존 애플리케이션을 포팅하는 경우에는 `429` 응답을 처리하지 못할 수 있습니다. 마이그레이션 확인 작업의 일부로서, 애플리케이션이 `429` 응답을 올바르게 처리하는지 확인하십시오.
{: note}

요컨대, 사용자는 애플리케이션이 [`429`](/docs/services/Cloudant?topic=cloudant-http#http-status-codes) 응답을 올바르게 처리할 수 있는지 확인해야 합니다.

### 파티션된 조회로 읽기 조작 이용
{: #consumption-of-lookup-operations-by-partitioned-queries}

파티션된 조회 요청은 리턴된 결과에 따라 가변 수의 읽기 조작을
이용합니다. 이용은 두 개의 축을 기반으로 합니다.

1. 조회와 관련된 인덱스에서 읽은 행 수.
1. 조회 실행 중에 데이터베이스에서 읽은 문서의
    수.
    
#### `_all_docs`, 보기 및 검색 조회

인덱스에서 읽은 100개 행의 각 블록에서 한 개의 읽기 조작을 이용합니다. 또한
조회 실행 중에 데이터베이스에서 읽은 각 문서는 한 개의 읽기 단위를
이용합니다.

인덱스에서 읽은 행 수는 리턴된 결과 수와
동일합니다. `include_docs=true`가 조회 요청 중에 조회 문자열 매개변수로
사용되는 경우 문서는 데이터베이스에서만 읽을 수 있습니다.

비용 예는 다음 표에 표시되어 있습니다. 

| 결과 수 | 문서 포함 | 총 읽기 이용 | 읽은 행 이용 | 읽은 문서 이용 |
|--------------|----------------|-------------|---------------------| --- |
| 199      |아니오     | **2** |2 | 0 |
| 199      |예     | **201** |2 | 199 |
| 301      |아니오     | **4** |4 | 0 |
| 301      |예     | **305** |4 | 301 |

파티션된 `_all_docs`, 보기 및 검색 조회에 대한 읽기 이용을 줄이려면
`include_docs=true` 사용을 줄여야 합니다.

#### {{site.data.keyword.cloudant_short_notm}} 조회

{{site.data.keyword.cloudant_short_notm}} 조회 결과에서, 인덱스로 충족될 수 없는
선택기의 파트를 기준으로 필터링이 이루어지기 _전에_ 인덱스 행 읽기를 위한
이용된 읽기 조작의 수는 기본 인덱스에서 읽은 행과 관련이 있습니다.
즉, 행 읽기 값, 그리고 이용된 읽기 단위가 수신된 최종 결과 수보다
높을 수 있습니다.

또한 {{site.data.keyword.cloudant_short_notm}} 조회는 기본 인덱스에 의해 리턴되는 모든 행에 대해
문서를 읽어야 하므로 조회로 전달된 선택기에 필요한 추가 필터링을
실행할 수 있습니다.

| 결과 수 | 인덱스에 의해 리턴되는 행 수 | 총 읽기 이용 | 읽은 행 이용 | 읽은 문서 이용 |
|--------------|----------------|-------------|---------------------| --- |
|5      | 199     | **201** |2 | 199 |
| 199      | 199     | **201** |2 | 199 |
|5      | 301     | **305** |4 | 301 |
| 301      | 301     | **305** |4 | 301 |

파티션된 {{site.data.keyword.cloudant_short_notm}} 조회의 조회에 대한 읽기 이용을 줄이려면
적절한 인덱스를 사용해야 합니다.

### 용량 보기 및 변경
{: #viewing-and-changing-capacity}

사용자는 자신의 계정에 사용 가능한 플랜 내의 처리량 용량에 대한 세부사항을 볼 수 있습니다.
{{site.data.keyword.cloudant_short_notm}} 계정 대시보드의 계정 탭을 통해
사용할 프로비저닝 레벨을 선택할 수 있습니다.

![계정 대시보드](../images/cloudant_capacity.png)

다른 처리량 용량으로 이동하려면 원하는 프로비저닝을 선택한 후 `업데이트`를 클릭하십시오. 사용자는 변경을 확인해달라는 요청과, 프로비저닝 변경이 완료되려면 최대 24시간이 소요될 수 있다는 알림을 받습니다.

![계정 대시보드](../images/cloudant_capacity_change.png)

용량 증가의 크기는 변경당 10개 단위(1000회 읽기/초, 500회 쓰기/초, 50회 글로벌 조회/초)로 제한됩니다. 감소의 경우에는 단위 수에 제한이 없습니다. 모든 용량 변경은 증가 또는 감소 모두 시간당 한 번으로 제한됩니다. {{site.data.keyword.cloudant_short_notm}} 대시보드에서 사용할 수 있는 것보다 더 많은 용량이 필요한 경우에는 [{{site.data.keyword.cloudant_short_notm}} 지원 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](mailto:support@cloudant.com){: new_window}에 문의하십시오.
{: note}

### 사용량 모니터링 
{: #monitoring-usage}

사용량에 대한 정보는 {{site.data.keyword.cloudant_short_notm}} 대시보드 내 모니터링 탭의 현재 오퍼레이션 분할창에 있습니다.  

![대시보드에서 사용량 모니터링](../images/cloudant_usage.png)

여기서는 현재 [처리량](#provisioned-throughput-capacity)과 [저장된 데이터](#disk-space-included)의 양에 대한 세부사항을 보여줍니다.

모니터링은 플랜의 프로비저닝 용량에 변경이 필요한 경우를 인식하는 데 도움을 줍니다.
예를 들어,
빈번하게 최대 데이터베이스 읽기 수에 도달하는 경우
대시보드의 계정 탭에 있는 [용량 분할창](#viewing-and-changing-capacity)을 통해 프로비저닝을 수정할 수 있습니다.

## 데이터 사용량
{: #data-usage}

### 포함된 디스크 공간
{: #disk-space-included}

이 값은 플랜에 포함된 스토리지 용량입니다.
이는 데이터 및 인덱스 저장에 사용됩니다.

### 디스크 초과 사용량
{: #disk-overage}

모든 표준 및 Lite 플랜은 JSON 데이터, 첨부 파일 및 인덱스에 사용되는 디스크 공간을 포함합니다. 모든 표준 및 Lite 플랜의 사용된 디스크 공간은 모니터됩니다. 플랜이 할당하는 것보다
더 많은 데이터를 사용하는 경우에는 다음 표에 설명되어 있는 조건이 적용될 것으로 예상할 수 있습니다.

<table>

<tr>
<th id="disk-overage-plan">플랜</th><th id="description">설명</th>
</tr>
<tr>
<th headers="standard-plan">표준</td>
<td headers="description"><p>
<ul><li>계정이 플랜 구성에서 할당된 것보다 더 많은 양의 스토리지를 사용하는 경우 이는 '오버플로우'로 간주됩니다. 오버플로우가 발생하면 플랜 할당량을 초과하여 사용된 각 GB에 대해 표시된 가격이 청구됩니다.</li>
<li>플랜에 제공된 것보다 더 많은 디스크 공간을 사용하여 지불해야 하는 추가 금액을 '초과 사용량'이라고 합니다. 초과 사용량은 시간별로 계산됩니다.</li></ul></p></td>
</tr>
<tr>
<th headers="lite-plan">Lite</td>
<td headers="description"><p>
<ul><li>Lite 플랜에서는 디스크 사용량이 제한됩니다. 한계에 도달하면 새 데이터를 기록할 수 없습니다. 새 데이터를 기록하려면 표준 플랜으로 업그레이드하거나, 계정이 다시 활성화되도록 데이터를 삭제하고 다음 확인이 실행될 때까지 기다려야 합니다.</p>
</li></ul></td>
</tr>
</table>

예를 들어, 표준 플랜 인스턴스의 디스크 사용량이 반일(12시간) 동안 107GB로 늘어났다고 가정해 보십시오. 이 변경은 12시간 동안 인스턴스에서 20GB의 플랜 할당량을 초과하여 87GB의 오버플로우가 발생했음을 의미합니다.
따라서 이 추가 공간에 대해, 87GB x 12시간 = 1044GB/시간에 대한 초과 사용량이 청구됩니다.

초과 사용량은 비용 청구 기간 내의 특정 시간 동안 플랜 할당량을 초과한 최대 GB를 사용하여 계산됩니다.

### 디스크 초과 사용량 예
{: #disk-overage-example}

사용자가 9GB 스토리지를 사용하는 표준 플랜 서비스 인스턴스를 1개월(30일)의 1일에 시작했다고 가정해 보십시오.
그리고, 3일 2시부터 15분 간 스토리지가 21.5GB로 증가했습니다.
인스턴스의 스토리지는 2시에 다음 10분 간 다시 9.5GB로 떨어졌다가,
그 후 2시에 다음 25분 간 108GB로 증가했습니다.
마지막으로, 인스턴스는 이 시간을 마치고 1개월의 나머지 기간 동안 28GB로 떨어지며 마감했습니다.

이 패턴은 플랜 할당량을 초과한 최대 GB가 3일 2시에 발생한 88GB임을 의미합니다.
3일 3시부터 1개월의 나머지 기간 동안은 인스턴스가 플랜 할당량을 8GB 초과했습니다.

따라서 3일 2시에 대해서는 청구서에 88GB x 1시간 = 88GB/시간에 대한 초과 사용량이 포함됩니다.

3일 3시부터 3일의 끝까지에 대해서는 청구서에 8GB x 21시간 = 168GB/시간에 대한 초과 사용량이 포함됩니다.

4일 자정부터 1개월(30일)의 끝까지에 대해서는 청구서에 8GB x 24시간 x 27일 = 5184GB/시간에 대한 초과 사용량이 포함됩니다.

한 달 동안의 총 초과 사용량 청구는 88 + 168 + 5184 = 5440GB/시간입니다.

## 요청 및 문서 크기 한계
{: #request-and-document-size-limits}

{{site.data.keyword.cloudant_short_notm}} JSON 문서 및 요청에는
다음과 같은 최대 크기 한계가 있습니다. 

한계 | 최대 크기
------|-------------
개별 문서 크기 |1MB
단일 첨부 문서 크기 | 10MB
요청 본문 크기 | 11MB

이러한 한계를 초과하면 [413 응답](/docs/services/Cloudant?topic=cloudant-http#http-status-codes)이 발생합니다.

2진 첨부 파일 또는 대형 JSON BLOB를 Object Storage에 저장하고 {{site.data.keyword.cloudant_short_notm}} JSON 문서에
위치에 대한 링크를 저장하는 것이 좋습니다.   

복제할 때 해당 한계보다 큰 문서 또는 첨부 파일은 대상 데이터베이스로 복제되지 않습니다. 복제 오류를 발견하는 방법에 대한 자세한 정보는
[복제 오류](/docs/services/Cloudant?topic=cloudant-replication-api#replication-errors)를 참조하십시오. 

## 위치 및 테넌시
{: #locations-and-tenancy}

기본적으로 모든 Lite 및 표준 플랜은 멀티 테넌트 환경에 배치됩니다. 플랜 선택의 일부로서, 사용자는 다음 {{site.data.keyword.cloud_notm}} 퍼블릭 지역 중 하나를 선택할 수 있습니다.

-   워싱턴 DC
-   Dallas
-   런던
-   시드니
-   프랑크푸르트&Dagger;
-   도쿄

데디케이티드 하드웨어 플랜 인스턴스는 대부분 [{{site.data.keyword.IBM_notm}} 데이터 센터 위치 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://www.ibm.com/cloud/data-centers/)에 배치될 수 있습니다. 
사용 가능한 위치의 최신 목록은 {{site.data.keyword.cloud_notm}} 카탈로그의 드롭 다운 메뉴를 참조하십시오.

&Dagger;{{site.data.keyword.cloud_notm}} 퍼블릭 프랑크푸르트
지역에서 배치된 모든 {{site.data.keyword.cloudant_short_notm}} 인스턴스는
EU 관리 환경에 배치됩니다. EU 관리 환경 외부에서
생성된 모든 {{site.data.keyword.cloudant_short_notm}} 계정 또는 API 키는 EU 관리
{{site.data.keyword.cloudant_short_notm}} 인스턴스에 대한 액세스 권한을 부여 받을 수 없습니다.

## 인증 방법
{: #authentication-methods}

 {{site.data.keyword.cloudant_short_notm}}는 HTTPS API를 사용하여 액세스됩니다. API 엔드포인트가 요구하는 경우, 사용자는 {{site.data.keyword.cloudant_short_notm}}가 수신하는 모든 HTTPS 요청에 대해 인증됩니다. 프로비저닝 중에 사용 가능한 인증 방법에는 `Use both legacy credentials and IAM` 또는 `Use only IAM`이 있습니다. 자세한 정보는 [IAM 안내서](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-) 또는 레거시 [인증 API 문서](/docs/services/Cloudant?topic=cloudant-authentication#authentication)를 참조하십시오 .

{{site.data.keyword.cloudant_short_notm}} 인스턴스를 프로비저닝하고 나면 {{site.data.keyword.cloud_notm}} 대시보드의 서비스 인증 정보 탭에서 새 인증 정보를 생성할 때 연결 URL 및 IAM 권한 부여 세부사항을 볼 수 있습니다. 프로비저닝 중에 이 옵션을 선택한 경우에는 {{site.data.keyword.cloudant_short_notm}} 레거시 사용자 이름 및 비밀번호 또한 포함됩니다.

{{site.data.keyword.cloudant_short_notm}} 팀에서는 가능한 한 인증에 대한 IAM 액세스 제어를 사용할 것을 권장합니다. {{site.data.keyword.cloudant_short_notm}} 레거시 인증을 사용하는 경우 프로그래밍 방식의 액세스 및 복제 작업에 대한 계정 레벨 인증 정보가 아닌 [API 키](/docs/services/Cloudant?topic=cloudant-authorization#api-keys){: new_window}를 사용하는 것이 좋습니다. 
{: important}

## 데이터 센터의 고가용성, 재해 복구 및 백업
{: #high-availability-disaster-recovery-and-backup-in-a-data-center}

데이터 센터 내에서 고가용성(HA) 및 재해 복구(DR) 기능을 제공하기 위해, 모든 데이터는 클러스터 내 세 개의 개별 실제 서버에 삼중으로 저장됩니다. 사용자는 여러 데이터 센터에 계정을 프로비저닝한 후 지속적 데이터 복제를 사용하여 데이터 센터 간에 HA/DR 기능을 제공할 수 있습니다. {{site.data.keyword.cloudant_short_notm}} 데이터는 자동으로 백업되지 않지만, 백업을 처리할 수 있도록 지원되는 도구가 제공됩니다. [재해 복구 및 백업 안내서](/docs/services/Cloudant?topic=cloudant-authorization#api-keys)를
검토하여 사용자 애플리케이션의 요구사항을 만족시키기 위한 모든 HA, DR 및 백업
고려사항을 확인하십시오.  

## {{site.data.keyword.cloud_notm}} 지원
{: #ibm-cloud-support}

표준 및 데디케이티드 플랜 서비스 인스턴스에 대한 지원은 선택사항입니다.
이는 *{{site.data.keyword.cloud_notm}} 표준 지원*을 구매하면 제공됩니다. Lite 플랜은 이 지원을 사용할 수 없습니다.

지원 플랜에 대한 자세한 정보는 [{{site.data.keyword.cloud_notm}} 표준 지원 플랜 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://www.ibm.com/cloud/support#944376){: new_window}을 참조하십시오. 지원에 대한 자세한 정보는 [{{site.data.keyword.IBM_notm}} support guide ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://www.ibm.com/support/home/pages/support-guide/){: new_window}를 참조하십시오.

{{site.data.keyword.cloudant_short_notm}}에 대해 사용되는 지원 시스템은 의료 보험 정보, 건강 관련 데이터, PHI(Protected Health Information) 또는 추가 규제 요구사항의 대상이 되는 데이터를 포함하는 컨텐츠에 대한 보호 기능을 제공하지 않습니다. 따라서 고객은 이러한 데이터를 입력하거나 제공하지 않아야 합니다.
{: note}

## {{site.data.keyword.cloud_notm}}에서의 {{site.data.keyword.cloudant_short_notm}} 인스턴스 프로비저닝
{: #provisioning-a-cloudant-nosql-db-instance-on-ibm-cloud}

{{site.data.keyword.cloud_notm}}에서는 {{site.data.keyword.cloudant_short_notm}} Lite 또는 표준 플랜 인스턴스를 두 가지 방법으로 프로비저닝할 수 있습니다. 

- 대시보드를 사용합니다. 자세한 정보는 해당 프로세스를 설명하는 [{{site.data.keyword.cloud_notm}}에 {{site.data.keyword.cloudant_short_notm}} 인스턴스 작성 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud#creating-an-ibm-cloudant-instance-on-ibm-cloud){: new_window} 튜토리얼을 참조하십시오. 
- Cloud Foundry 명령 도구를 사용합니다. 자세한 정보는 해당 프로세스를 설명하는 [{{site.data.keyword.cloud_notm}} CLI를 사용하여 {{site.data.keyword.cloud_notm}}에 {{site.data.keyword.cloudant_short_notm}} 인스턴스 작성 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud-by-using-the-ibm-cloud-cli#creating-an-ibm-cloudant-instance-on-ibm-cloud-by-using-the-ibm-cloud-cli){: new_window} 튜토리얼을 참조하십시오. 
 
{{site.data.keyword.cloudant_short_notm}} 데디케이티드 하드웨어 플랜 인스턴스를 작성하고 활용하려면 해당 프로세스를 설명하는 [{{site.data.keyword.cloud_notm}}에서 {{site.data.keyword.cloudant_short_notm}} 데디케이티드 하드웨어 플랜 인스턴스 작성 및 활용 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](/docs/services/Cloudant?topic=cloudant-creating-and-leveraging-an-ibm-cloudant-dedicated-hardware-plan-instance-on-ibm-cloud#creating-and-leveraging-an-ibm-cloudant-dedicated-hardware-plan-instance-on-ibm-cloud){: new_window} 튜토리얼을 참조하십시오. 






