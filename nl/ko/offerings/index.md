---

copyright:
  years: 2015, 2017
lastupdated: "2017-08-25"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-03-16 -->

# Cloudant 오퍼링

## DBaaS(Database as a Service)

Cloudant는 호스팅되며 전체 관리되는 DBaaS(Database-as-a-Service)입니다. 이는 글로벌 스케일링되고, 중지 없이 실행되며 [JSON](../basics/index.html#json),
[전체 텍스트](../api/cloudant_query.html#creating-an-index) 및 [지리공간](../api/cloudant-geo.html)과 같은 다양한 데이터 유형을 처리할 수 있도록
처음부터 철저하게 계획되어 빌드됩니다. Cloudant는 동시 읽기 및 쓰기를 처리할 수 있도록 최적화된 운영 데이터 저장소이며 고가용성 및 데이터 내구성을 제공합니다. 

이는 [JSON](../basics/index.html#json) 데이터에 대해 작업하는 데 필요한 [HTTP API](../basics/index.html#http-api)와 24시간 이용 가능한 운영 지원 및 유지보수 기능을 제공합니다.
Cloudant는 [Apache CouchDB ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](http://couchdb.apache.org/){:new_window}를 기반으로 하며
다양한 멀티 테넌트, 데디케이티드 및 설치 서비스로서 제공됩니다. 

>   **참고**: 이 문서의 모든 통화 값은 미국 달러($)입니다. 

Cloudant DBaaS 오퍼링은 [https://cloudant.com/ ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://cloudant.com/){:new_window}을 통해 사용 가능합니다.
이는 [공유 플랜](#shared-plan) 또는 [엔터프라이즈(데디케이티드) 플랜](#enterprise-plan)으로 제공됩니다. 

Cloudant는 [IBM Bluemix 서비스](bluemix.html)로 사용할 수도 있습니다. 

>	**참고:** Cloudant [공유 플랜](#shared-plan) 및 [엔터프라이즈(데디케이티드) 플랜](#enterprise-plan) 오퍼링은 [IBM Bluemix 서비스](bluemix.html)에서 사용할 수 없습니다. 

### 공유 플랜

Cloudant 공유 플랜을 사용하면 공유 또는 '멀티 테넌트' 클러스터를 통해 제공되는 모든 Cloudant DBaaS 기능에 액세스할 수 있습니다. 

가격은 월별 사용량에 따라 계량됩니다. 월별 사용량이 $50.00 미만인 경우에는 비용이 청구되지 않습니다(2016년 8월 기준). 

자세한 정보는 [가격 책정 세부사항 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://cloudant.com/product/pricing/){:new_window}을 참조하십시오. 

### 엔터프라이즈 플랜

Cloudant DBaaS 엔터프라이즈 플랜을 사용하면 데디케이티드 싱글 테넌트 클러스터를 통해 제공되는 모든 Cloudant DBaaS 기능에 액세스할 수 있습니다. 

이 플랜은 다양한 호스팅 위치에 있는 데디케이티드 DBaaS 클러스터 또는 하드웨어를 사용하여 데이터베이스 성능 및 작동 시간을 보장합니다. 

자세한 정보는 [가격 책정 세부사항 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://cloudant.com/product/pricing/){:new_window}을 참조하십시오. 

## Cloudant Local

[IBM Cloudant Data Layer Local Edition(Cloudant Local) ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://www.ibm.com/support/knowledgecenter/SSTPQH_1.0.0/com.ibm.cloudant.local.doc/SSTPQH_1.0.0_welcome.html){:new_window}은
Cloudant DBaaS(Database-as-a-Service) 오퍼링의 로컬 설치 버전입니다. 

Cloudant Local은 전체 Cloudant 싱글 테넌트 오퍼링과 동일한 기본 기능을 제공하지만 사용자의 데이터 센터에서 호스팅됩니다. 

Cloudant Local의 자세한 개요는 [여기 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](http://www-01.ibm.com/support/knowledgecenter/SSTPQH_1.0.0/com.ibm.cloudant.local.install.doc/topics/clinstall_cloudant_local_overview.html?lang=en-us){:new_window}에 있습니다.
[IBM Knowledge Center ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](http://www-01.ibm.com/support/knowledgecenter/SSTPQH_1.0.0/com.ibm.cloudant.local.doc/SSTPQH_1.0.0_welcome.html?lang=en){:new_window}는
다음 항목을 포함한, Cloudant Local의 여러 요소에 대한 정보를 제공합니다. 

-   [설치 및 구성 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](http://www.ibm.com/support/knowledgecenter/SSTPQH_1.0.0/com.ibm.cloudant.local.install.doc/topics/clinstall_extract_install_cloudant_local.html?lang=en){:new_window}
-   [유지보수 태스크 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](http://www-01.ibm.com/support/knowledgecenter/SSTPQH_1.0.0/com.ibm.cloudant.local.install.doc/topics/clinstall_maintenance_tasks_overview.html?lang=en){:new_window}
-   [복제 매개변수 조정 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](http://www-01.ibm.com/support/knowledgecenter/SSTPQH_1.0.0/com.ibm.cloudant.local.install.doc/topics/clinstall_tuning_parameters_replication_cases.html?lang=en){:new_window}

## [보안](security.html)

금융 서비스, 정부, 전자상거래, 통신, 의료 및 보안을 중시하는 기타 업계의 고객은 데이터 액세스 제어, 암호화 및 데이터 백업 기능을 통해 {{site.data.keyword.cloudantfull}}의 혜택을 누릴 수 있습니다. 

## [규제 준수](compliance.html)

{{site.data.keyword.cloudant_short_notm}}에서는 신뢰할 수 있으며 안전한 클라우드 데이터베이스 시스템을 제공합니다.
이 서비스는 ISO 27001:2013을 포함한 최고의 업계 표준을 기반으로 빌드되었습니다. 

{{site.data.keyword.cloudant_short_notm}} 데이터 개인정보 보호 및 통제에 대한 세부사항은 [여기](dataprivacygovernance.html)에 있습니다. 
