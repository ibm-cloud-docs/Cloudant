---

copyright:
  years: 2015, 2017
lastupdated: "2017-06-09"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-02-23 -->

# IBM Bluemix

{{site.data.keyword.cloudant}}는 [{{site.data.keyword.Bluemix}} 서비스 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://console.ng.bluemix.net/catalog/services/cloudant-nosql-db/){:new_window}로서 사용할 수도 있습니다.
{:shortdesc}

{{site.data.keyword.Bluemix_short}}는 애플리케이션 빌드, 실행 및 관리를 위한 개방형 표준 클라우드 플랫폼입니다.
[홈 페이지 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://console.ng.bluemix.net/){:new_window}에서
{{site.data.keyword.Bluemix_notm}}에 대해 자세히 알아보고 이를 사용해 보십시오. 

## Bluemix 퍼블릭

{{site.data.keyword.cloudantfull}}는 무료 [Lite 플랜](#lite-plan), 또는 유료 [표준 플랜](#standard-plan) 내의 여러 구성으로 사용할 수 있습니다.
[데디케이티드 플랜](#dedicated-plan) 또한 사용 가능합니다. 이 플랜은 표준 플랜과 동일한 구성 가능성을 제공하지만 데디케이티드 하드웨어에서 제공됩니다.
데디케이티드 하드웨어는 다른 계정과 공유되지 않으며, 이는 사용자가 이를 독점 사용함을 의미합니다. 데디케이티드 플랜 인스턴스가 [미국](#locations) 내에서 프로비저닝된 경우에는 선택적으로
[HIPAA ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://en.wikipedia.org/wiki/Health_Insurance_Portability_and_Accountability_Act){:new_window} 준수 구성을 선택할 수 있습니다. 

다음 표에는 각 플랜의 성능 수치가 요약되어 있습니다. 

>   **참고**: 표에 포함된 세부사항은 2016년 9월의 정보입니다. 
    현재의 값은 [{{site.data.keyword.cloudant_short_notm}} 지원 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](mailto:support@cloudant.com){:new_window}에 문의하십시오.

>   **참고**: 이 문서의 모든 통화 값은 미국 달러($)입니다. 

<table border='1'>

<tr>
<th>플랜</th><th>Lite</th><th colspan='4'>표준 <i>및</i> 데디케이티드</th>
</tr>
<tr>
<td>기본 가격(시간당)</td>
<td>$0.00</td>
<td colspan='4'><a href="http://cloudant.com/bluemix" target="_blank">가격 책정 세부사항 <img src="../images/launch-glyph.svg" alt="외부 링크 아이콘" title="외부 링크 아이콘"></a>을 참조하십시오. </td>
</tr>
<tr>
<td>프로비저닝되는 처리량 용량(초당 검색 수)</td>
<td>20</td>
<td>100</td>
<td>1,000</td>
<td>5,000</td>
<td>20,000</td>
</tr>
<tr>
<td>프로비저닝되는 처리량 용량(초당 쓰기 수)</td>
<td>10</td>
<td>50</td>
<td>500</td>
<td>2,500</td>
<td>10,000</td>
</tr>
<tr>
<td>프로비저닝되는 처리량 용량(초당 조회 수)</td>
<td>5</td>
<td>5</td>
<td>50</td>
<td>250</td>
<td>1,000</td>
</tr>
<tr>
<td>최대 개별 문서 크기</td>
<td>1MB</td>
<td colspan='4'>1MB</td>
</tr>
<tr>
<td>포함된 디스크 공간</td>
<td>1GB</td>
<td colspan='4'>20GB</td>
</tr>
<tr>
<td>디스크 초과 사용량(GB/시간당)</td>
<td>사용할 수 없음</td>
<td colspan='4'><a href="http://cloudant.com/bluemix" target="_blank">가격 책정 세부사항 <img src="../images/launch-glyph.svg" alt="외부 링크 아이콘" title="외부 링크 아이콘"></a>을 참조하십시오. </td>
</tr>

</table>

사용자는 [{{site.data.keyword.cloudant_short_notm}} 서비스 인스턴스를 프로비저닝](#provisioning-a-cloudant-instance-on-bluemix)할 때 사용할 플랜을 선택할 수 있습니다.
기본적으로, [Lite 플랜](#lite-plan)이 선택됩니다. 

![Cloudant 서비스 인스턴스 플랜 선택](../images/fb87416a.png)

### Lite 플랜

Lite 플랜은 무료이지만 데이터 스토리지가 1GB로 제한됩니다. 검색, 쓰기 및 조회에 대해 프로비저닝되는 처리량 용량에도 제한이 적용됩니다.  

스토리지 사용량은 매일 확인됩니다. 스토리지 한계를 초과하면 계정에 대한 HTTP 요청이 402 상태 코드와 함께 오류 메시지 "Account has exceeded its data usage quota. An upgrade to a paid plan is required."를 수신합니다.
Cloudant 대시보드에도 이를 알리는 배너가 표시됩니다. 사용자는 여전히 데이터를 읽고 삭제할 수 있습니다. 그러나 새 데이터를 쓰려면 유료 계정으로 업그레이드하거나, 계정이 다시 활성화되도록 데이터를 삭제하고 다음 확인이
실행될 때까지 기다려야 합니다.  

1GB보다 많은 데이터를 저장하려 하거나 처리량 용량을 늘리려면 [표준 플랜](#standard-plan)으로 변경하십시오. 

### 표준 플랜

표준 플랜에는 20GB의 데이터 스토리지가 포함되어 있습니다. 20GB를 초과하여 저장하면 GB/시간당 정의된 비용이 청구됩니다.
현재 비용에 대한 정보는 [가격 책정 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](http://cloudant.com/bluemix){:new_window}을 참조하십시오.
표준 플랜에서는 검색, 쓰기 및 조회에 대해 프로비저닝되는 처리량 용량을 변경할 수도 있습니다. 

### 데디케이티드 플랜

[{{site.data.keyword.Bluemix_notm}} 데디케이티드 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](http://www.ibm.com/cloud-computing/bluemix/dedicated/){:new_window} 구성의
일부로서 {{site.data.keyword.cloudant_short_notm}}를 싱글 테넌트 데디케이티드 하드웨어에서 사용할 수 있습니다. 

<div id="servicetier"></div>

## 서비스 계층

사용자는 자신의 계정에 사용 가능한 플랜 내의 처리량 용량에 대한 세부사항을 볼 수 있습니다.
{{site.data.keyword.cloudant_short_notm}} 계정 대시보드의 계정 탭을 통해 사용할 프로비저닝 레벨을 선택할 수 있습니다. 

![계정 대시보드](../images/cloudant_capacity.png)

다른 처리량 용량으로 이동하려면 원하는 프로비저닝을 선택한 후 `Change Capacity` 옵션 단추를 클릭하십시오.
사용자는 변경을 확인해달라는 요청과, 프로비저닝 변경이 완료되려면 최대 24시간이 소요될 수 있다는 알림을 받습니다. 

![계정 대시보드](../images/cloudant_capacity_change.png)

<div id="throughput"></div>

### 프로비저닝되는 처리량 용량

프로비저닝되는 처리량은 세 가지 이벤트 중 하나로 식별되고 측정됩니다. 

1.	문서의 `_id`를 기반으로 하는, 특정 문서의 읽기인 검색
2.	개별 문서의 작성, 수정 또는 삭제이거나, 인덱스 빌드로 인한 업데이트인 쓰기
3.	다음 유형을 포함하는, {{site.data.keyword.cloudant_short_notm}} 조회 엔드포인트 중 하나에 대한 요청인 조회
	-	1차 인덱스([`_all_docs`](../api/database.html#get-documents))
	-	MapReduce 보기([`_view`](../api/creating_views.html#using-views))
	-	검색 인덱스([`_search`](../api/search.html#queries))
	-	지리공간 인덱스([`_geo`](../api/cloudant-geo.html#querying-a-cloudant-geo-index))
	-	Cloudant Query([`_find`](../api/cloudant_query.html#finding-documents-using-an-index))
	-	변경사항([`_changes`](../api/database.html#get-changes))

처리량 수치는 각 유형 이벤트의 초당 개수이며, 여기서 초는 _슬라이딩_ 윈도우입니다.
계정이 플랜에 대해 프로비저닝되는 처리량 이벤트 수를 초과하면 슬라이딩 윈도우 내 이벤트 수가
프로비저닝되는 이벤트 수를 초과하지 않을 때까지 요청이 거부됩니다. 1초의 슬라이딩 윈도우를
연속된 1,000밀리초라고 생각하면 이해하는 데 도움이 됩니다. 

예를 들어, 초당 200회 검색을 프로비저닝하는 표준 플랜을 사용하고 있는 경우
계정은 연속된 1,000밀리초(1초) 동안 최대 200회의 검색 요청을 수행할 수 있습니다.
1,000밀리초의 슬라이딩 기간 중에 이뤄진 후속 검색 요청은 해당 기간 내의 검색 요청 수가
다시 200 미만으로 떨어질 때까지 거부됩니다. 

이벤트 수를 초과하여 요청이 거부되면 애플리케이션이 [`429` Too Many Requests](../api/http.html#429) 응답을 수신합니다. 

지원되는 클라이언트 라이브러리([Java](../libraries/supported.html#java), [Node.js](../libraries/supported.html#node-js) 및
[Python](../libraries/supported.html#python) 언어용)의 최신 버전은 `429` 응답을 처리하는 데 도움을 줍니다. 예를 들면,
Java 라이브러리는 [`TooManyRequestsException` ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](http://static.javadoc.io/com.cloudant/cloudant-client/2.5.1/com/cloudant/client/org/lightcouch/TooManyRequestsException.html){:new_window}
예외 처리(throw)를 수행합니다. 

기본적으로, 지원되는 클라이언트 라이브러리는 `429` 응답이 수신되는 경우 자동으로 요청을 재시도하지 않습니다. 

애플리케이션이 `429` 응답을 올바르게 처리하도록 하는 것이 더 바람직합니다. 이는 재시도 횟수가 제한되어 있기 때문입니다.
빈번하게 요청 수가 한계를 초과하는 경우에는 다른 플랜 구성으로 변경하는 것이 좋습니다. 

>   **참고**: 기존 애플리케이션을 포팅하는 경우에는
    여기에서 `429` 응답을 처리하지 못할 수 있습니다.
    마이그레이션 확인 작업의 일부로서, 애플리케이션이
    `429` 응답을 올바르게 처리하는지 확인하십시오.

요컨대, 사용자는 애플리케이션이 [`429`](../api/http.html#429) 응답을 올바르게 처리할 수 있는지 확인해야 합니다. 

### 최대 개별 문서 크기

데이터는 {{site.data.keyword.cloudant_short_notm}} 내에 [JSON 문서](../api/document.html)로 저장됩니다.
{{site.data.keyword.Bluemix_notm}}의 {{site.data.keyword.cloudant_short_notm}} 서비스에 저장된 문서의 경우
개별 문서의 최대 크기는 1MB입니다. 이 한계를 초과하면 [`413` 오류](../api/http.html#413)가 발생합니다. 

### 포함된 디스크 공간

이 값은 플랜에 포함된 스토리지 용량입니다. 이는 데이터 및 인덱스 저장에 사용됩니다. 

### 디스크 초과 사용량

모든 표준 및 Lite 플랜 서비스 인스턴스의 디스크 공간 사용량은 모니터됩니다.
계정이 플랜 구성에서 제공하는 것보다 더 많은 스토리지를 사용하면 이는 '오버플로우'로 간주됩니다.
오버플로우가 발생하면 플랜 할당량을 초과하여 사용된 각 GB에 대해 표시된 가격이 청구됩니다. 

플랜에 제공된 것보다 더 많은 디스크 공간을 사용하여 지불해야 하는 추가 금액을 '초과 사용량'이라고 합니다.
초과 사용량은 시간별로 계산됩니다. Lite 플랜에서는 사용 가능한 디스크 공간을 오버플로우할 수 없습니다. 

예를 들어, 표준 플랜 인스턴스의 디스크 사용량이 반일(12시간) 동안 107GB로 늘어났다고 가정해 보십시오.
이 변경은 12시간 동안 인스턴스에서 20GB의 플랜 할당량을 초과하여 87GB의 오버플로우가 발생했음을 의미합니다.
따라서 이 추가 공간에 대해, 87GB x 12시간 = 1044GB/시간에 대한 초과 사용량이 청구됩니다. 

초과 사용량은 비용 청구 기간 내의 특정 시간 동안 플랜 할당량을 초과한 최대 GB를 사용하여 계산됩니다. 

### 초과 사용량 예

사용자가 9GB 스토리지를 사용하는 표준 플랜 서비스 인스턴스를 1개월(30일)의 1일에 시작했다고 가정해 보십시오.
그리고, 3일의 02시부터 15분 간 스토리지가 21.5GB로 증가했습니다. 인스턴스의 스토리지는 02시의 다음 10분 간 다시 9.5GB로 떨어졌다가,
그 후 02시의 다음 25분 간 108GB로 증가했습니다. 마지막으로, 인스턴스는 이 시간과 1개월의 나머지 기간 동안 28GB로 떨어져 이를 유지했습니다. 

이 패턴은 플랜 할당량을 초과한 최대 GB가 3일의 02시 중에 발생한 88GB임을 의미합니다.
3일의 03시부터 1개월의 나머지 기간 동안은 인스턴스가 플랜 할당량을 8GB 초과했습니다. 

따라서 3일의 02시에 대해서는 88GB x 1시간 = 88GB/시간에 대한 초과 사용량이 청구됩니다. 

3일의 03시부터 3일의 끝까지에 대해서는 8GB x 21시간 = 168GB/시간에 대한 초과 사용량이 청구됩니다. 

4일의 00시부터 1개월(30일)의 끝까지 8GB x 24시간 x 27일 = 5184GB/시간에 대한 초과 사용량이 청구됩니다. 

한 달 동안의 총 초과 사용량 청구는 88 + 168 + 5184 = 5440GB/시간입니다. 

## 위치

기본적으로, 데디케이티드를 제외한 모든 플랜은 멀티 테넌트 클러스터를 기반으로 합니다.
플랜 선택의 일부로서, 사용자는 다음 {{site.data.keyword.Bluemix_notm}} 퍼블릭 지역 중 하나를 선택할 수 있습니다. 

-   미국 남부
-   영국
-   시드니
-   독일

## 보안, 암호화 및 규제 준수

모든 플랜은 [저장 시 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://en.wikipedia.org/wiki/Data_at_rest){:new_window} 디스크 암호화를 사용하는
서버에서 제공됩니다. 네트워크 연결을 통한 액세스는 HTTPS를 사용하여 암호화됩니다. 세부사항은 [DBaaS 보안 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://cloudant.com/product/cloudant-features/dbaas-security/){:new_window}을 참조하십시오. 

플랜은 [보안 규제 준수 인증 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://cloudant.com/product/cloudant-features/cloudant-compliance/){:new_window} 또한 제공합니다.
[HIPAA ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://en.wikipedia.org/wiki/Health_Insurance_Portability_and_Accountability_Act){:new_window}
준수는 [데디케이티드 환경](#dedicated-plan)을 필요로 하므로 [프로비저닝 프로세스](#provisioning-a-cloudant-instance-on-bluemix) 중에 이 환경을 요청하십시오. 

## 고가용성, 재해 복구 및 백업

데이터 센터 내에서 고가용성(HA) 및 재해 복구(DR) 기능을 제공하기 위해, 모든 데이터는 클러스터 내 세 개의 개별 실제 서버에 삼중으로 저장됩니다.
사용자는 여러 데이터 센터에 계정을 프로비저닝한 후 지속적 데이터 복제를 사용하여 데이터 센터 간에 HA/DR 기능을 제공할 수 있습니다. 

{{site.data.keyword.cloudant_short_notm}} 데이터는 자동으로 백업되지 않습니다. 사용자는 [증분 백업 기능](../guides/backup-guide.html) 사용을 요청하거나,
[여기 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://developer.ibm.com/clouddataservices/2016/03/22/simple-couchdb-and-cloudant-backup/){:new_window}에
설명된 몇 가지 사용 가능한 기술 중 하나를 사용하여 고유한 솔루션을 구현할 수 있습니다.   

## 사용량 모니터링

사용량에 대한 정보는 {{site.data.keyword.cloudant_short_notm}} 대시보드 내 활동 탭의 사용량 분할창에 있습니다. 

![대시보드의 사용량 모니터링](../images/cloudant_usage.png)

여기서는 현재 [처리량](#throughput)과 [저장된 데이터](#disk-space-included)의 양에 대한 세부사항을 보여줍니다. 

모니터링은 플랜의 프로비저닝 용량에 변경이 필요한 경우를 인식하는 데 도움을 줍니다. 예를 들어, 빈번하게 최대 데이터베이스 검색 횟수에 도달하는 경우에는
대시보드의 계정 탭에 있는 [서비스 분할창](#servicetier)을 통해 프로비저닝 용량을 수정할 수 있습니다. 

## 하드웨어 스펙

데디케이티드를 제외한 모든 플랜은 멀티 테넌트 클러스터에서 구현됩니다. 고가용성 및 데이터 복구 기능을 제공하기 위해 모든 데이터는 세 개의 개별 실제 노드에 삼중으로 저장됩니다. 

## 지원

표준 및 데디케이티드 플랜 서비스 인스턴스에 대한 지원은 선택사항입니다. 이는 "{{site.data.keyword.Bluemix_notm}} 표준 지원"을 구매하면 제공됩니다.
Lite 플랜은 이 지원을 사용할 수 없습니다. 

{{site.data.keyword.Bluemix_notm}} 표준 지원에 대한 가격 책정 계산기는 [여기 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://console.ng.bluemix.net/?direct=classic/#/pricing/cloudOEPaneId=pricing&paneId=pricingSheet){:new_window}에 있습니다.
지원 서비스 레벨 계약(SLA)의 세부사항에 대한 정보는 [여기 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](http://www-03.ibm.com/software/sla/sladb.nsf/pdf/6606-08/$file/i126-6606-08_05-2016_en_US.pdf){:new_window}에 있습니다. 

## Bluemix에서 Cloudant 인스턴스 프로비저닝

{{site.data.keyword.Bluemix_notm}}에서는 두 가지 방법으로 {{site.data.keyword.cloudant_short_notm}} 인스턴스를 프로비저닝할 수 있습니다. 

-	대시보드를 사용합니다. 이 프로세스를 설명하는 튜토리얼은 [여기](../tutorials/create_service.html)에 있습니다. 
-	Cloud Foundry 명령 도구를 사용합니다. 이 프로세스를 설명하는 튜토리얼은 [여기](../tutorials/create_service_cli.html)에 있습니다. 
