---

copyright:
  years: 2015, 2019
lastupdated: "2019-03-18"

keywords: hardware capacity, location, tenancy, security, encryption, compliance, high availability, disaster recovery, backup

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

# {{site.data.keyword.cloud_notm}} 데디케이티드
{: #ibm-cloud-dedicated}

{{site.data.keyword.cloud}} 데디케이티드용 {{site.data.keyword.cloudantfull}}는 {{site.data.keyword.cloud_notm}}
데디케이티드 환경의 추가 기능으로 선택적 구매가 가능합니다. {{site.data.keyword.cloud_notm}} 데디케이티드의
{{site.data.keyword.cloudant_short_notm}} 데디케이티드용 추가 기능 옵션은 환경에 할당된 하드웨어
용량을 기반으로 가격이 책정되며 사용자의 {{site.data.keyword.IBM}} 영업 담당자에게 문의하여 구매할 수 있습니다.  
{: shortdesc}

{{site.data.keyword.cloud_notm}} 데디케이티드 고객은 Lite 및 표준 플랜 인스턴스를 비롯하여 신디케이트된
카탈로그를 통해 {{site.data.keyword.cloud_notm}} 퍼블릭 환경에서 {{site.data.keyword.cloudant_short_notm}}를 사용하도록
선택할 수도 있습니다. {{site.data.keyword.cloud_notm}} 데디케이티드 사용자는
{{site.data.keyword.cloud_notm}} 퍼블릭 카탈로그에서 데디케이티드 하드웨어 플랜을 구매할 수 없으며
데디케이티드 하드웨어가 필요한 경우 {{site.data.keyword.cloud_notm}} 데디케이티드의
{{site.data.keyword.cloudant_short_notm}} 데디케이티드를 활용해야 함을 참고하십시오.   

아래 스크린샷은 {{site.data.keyword.cloudant_short_notm}}의 {{site.data.keyword.cloud_notm}} 퍼블릭 신디케이티드 버전(왼쪽)과
{{site.data.keyword.cloudant_short_notm}} 데디케이티드 환경(오른쪽)을 강조표시한
{{site.data.keyword.cloud_notm}} 카탈로그의 예를 보여줍니다.  

![{{site.data.keyword.cloudant_short_notm}} 카탈로그](../images/bluemix_catalog.png)

## 하드웨어 용량 
{: #hardware-capacity}

{{site.data.keyword.cloud_notm}} 데디케이티드의 {{site.data.keyword.cloudant_short_notm}}는
'{{site.data.keyword.cloud_notm}} 데디케이티드 {{site.data.keyword.cloudant_short_notm}} 1.6TB 용량' 파트를
통해 구매할 수 있으며 여기에는 3개의 데이터베이스 노드와 2개의 로드 밸런서로 구성된
클러스터형 {{site.data.keyword.cloudant_short_notm}} 환경이 포함됩니다. 
각 데이터베이스 노드는 SSD에서 1.6TB를 포함하며 모든 데이터가 삼중으로 저장되므로 클러스터에서 고유 디스크 공간 1.6TB와 동일합니다. 추가 '{{site.data.keyword.cloud_notm}} 데디케이티드 {{site.data.keyword.cloudant_short_notm}} 1.6TB 용량' 파트를 구매하여 환경을 확장할 수 있으며 이는 세 개 데이터베이스 노드의 배수로 {{site.data.keyword.cloudant_short_notm}} 클러스터를 확장할 때 사용할 수 있습니다. 고객은 또한 단일 환경을 확장하는 대신 개별 {{site.data.keyword.cloudant_short_notm}} 환경을 여러 개 보유할 수도 있습니다.

## 전용 환경의 위치 및 테넌시
{: #locations-and-tenancy-in-a-dedicated-environment}

{{site.data.keyword.cloud_notm}} 데디케이티드 환경의
{{site.data.keyword.cloudant_short_notm}} 데디케이티드 환경은 {{site.data.keyword.cloud_notm}} 데디케이티드 고객의 단독 사용을 위해서 설계된 하드웨어에서 운영됩니다. 제공된 환경에서 하나 이상의 {{site.data.keyword.cloudant_short_notm}} 인스턴스를 프로비저닝할 수 있으며 {{site.data.keyword.cloudant_short_notm}}의 각 인스턴스는 {{site.data.keyword.cloudant_short_notm}} 환경을 구성하는 기반 하드웨어 리소스를 공유합니다. 

## 보안, 암호화 및 규제 준수 
{: #security-encryption-and-compliance}

모든 플랜에서 서버에 [저장 시 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://en.wikipedia.org/wiki/Data_at_rest) 디스크 암호화를 제공합니다. 공용 네트워크 연결을 통해 액세스하고 HTTPS를 사용하여 암호화됩니다. 세부사항은 [보안 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](/docs/services/Cloudant?topic=cloudant-security#security){: new_window}을 참조하십시오. 
IP 화이트리스트 지정은 {{site.data.keyword.cloudant_short_notm}} 지원에 요청 시 사용 가능하며 인스턴스 레벨이 아닌 전체 {{site.data.keyword.cloudant_short_notm}} 환경에 적용됩니다.  

플랜은 [규제 준수 인증 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](/docs/services/Cloudant?topic=cloudant-compliance#compliance){: new_window}도 제공합니다. 

[HIPAA ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://en.wikipedia.org/wiki/Health_Insurance_Portability_and_Accountability_Act){: new_window} 규제 준수는 요청 시 사용 가능하므로 구매 프로세스 동안 {{site.data.keyword.IBM_notm}} 영업 담당자에게 요청하십시오. 

## 고가용성, 재해 복구 및 백업 
{: #high-availability-disaster-recovery-and-backup}

데이터 센터 내에서 고가용성(HA) 및 재해 복구(DR) 기능을 제공하기 위해, 모든 데이터는 클러스터 내 세 개의 개별 실제 서버에 삼중으로 저장됩니다. 사용 가능해지면 여러 위치에 계정을 프로비저닝한 후 지속적 데이터 복제를 사용하여 데이터 센터 전반에 걸쳐 HA/DR 기능을 제공할 수 있습니다. {{site.data.keyword.cloudant_short_notm}} 데이터는 자동으로 백업되지 않지만 지원 도구가 백업을 처리하도록 제공됩니다. [재배 복구 및 백업 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](/docs/services/Cloudant?topic=cloudant-disaster-recovery-and-backup#disaster-recovery-and-backup){: new_window} 안내서를 검토하여 사용자의 애플리케이션 요구사항에 부합하기 위한 모든 HA, DA 및 백업 고려사항을 확인하십시오.
