---

copyright:
  years: 2015, 2018
lastupdated: "2018-10-24"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:tip: .tip}

<!-- Acrolinx: 2017-05-10 -->

# {{site.data.keyword.cloudant_short_notm}}는 {{site.data.keyword.cloud_notm}} 리소스 그룹과 어떤 방식으로 작동합니까?

2018년 7월 16일부터 새 {{site.data.keyword.cloudantfull}} 리소스 인스턴스는 Cloud Foundry 영역이 아니라
리소스 그룹에 프로비저닝되었습니다. 이 문서에서는 이 변경사항에 대해 {{site.data.keyword.cloudant_short_notm}} 지원이
받은 질문을 다룹니다. 

## 기존 인스턴스를 리소스 그룹으로 마이그레이션하는 방법은 무엇입니까?

Cloud Foundry 영역에서 {{site.data.keyword.cloudant_short_notm}} 인스턴스로 마이그레이션하려는 경우에는 [Migrating Cloud Foundry service instances and apps to a resource group](https://console.bluemix.net/docs/resources/instance_migration.html#migrate){:new_window}을 참조하십시오. 

다음 플랜의 {{site.data.keyword.cloudant_short_notm}} 인스턴스를 마이그레이션할 수 있습니다. 

- Lite
- 표준
- 데디케이티드 하드웨어

## 인스턴스를 리소스 그룹으로 마이그레이션할 때는 어느 정도의 작동 중단 시간이 발생합니까?

마이그레이션 프로세스 중에는 작동 중단 시간이 발생하지 않습니다. 

## 어떤 인스턴스에는 조직 및 영역이 있고 다른 인스턴스에는 없는 이유는 무엇입니까?

2018년 7월 16일부터 새 인스턴스는 Cloud Foundry 영역이 아니라 리소스 그룹에
프로비저닝되었습니다. 이 날짜 이전에 프로비저닝된 리소스 인스턴스에는 연관된
Cloud Foundry 조직 및 영역이 있습니다. 이 날짜 이유 프로비저닝된 인스턴스는
이러한 항목 대신 리소스 그룹과 연관되었습니다. 

## 데디케이티드 하드웨어 인스턴스에서 새 표준 플랜 인스턴스를 작성할 수 없는 이유는 무엇입니까?

새 표준 플랜 인스턴스는 리소스 그룹에 프로비저닝됩니다. 이러한 인스턴스를
데디케이티드 하드웨어 인스턴스에 프로비저닝하려는 경우에는 해당 데디케이티드 하드웨어
인스턴스를 먼저 리소스 그룹으로 마이그레이션해야 합니다. 

이를 수행하는 방법에 대한 자세한 정보는 [Migrating Cloud Foundry service instances and apps to a resource group](https://console.bluemix.net/docs/resources/instance_migration.html#migrate){:new_window}을 참조하십시오. 

데디케이티드 하드웨어 인스턴스가 리소스 그룹으로 마이그레이션된 후에는
표준 플랜을 프로비저닝할 때 이 인스턴스가 위치 드롭 다운 메뉴에 표시됩니다. 

## 데디케이티드 하드웨어 인스턴스와 여기에서 호스팅되고 있는 표준 플랜 인스턴스는 어떻게 마이그레이션합니까?

이론적으로, 인스턴스는 임의의 순서대로 리소스 그룹으로 마이그레이션할 수 있습니다. 실제로는,
데디케이티드 하드웨어 인스턴스와 여기에서 호스팅되고 있는 표준 플랜 인스턴스를
다음 순서대로 마이그레이션하는 것을 권장합니다. 

1. 데디케이티드 하드웨어 인스턴스를 리소스 그룹으로 마이그레이션하십시오. 이는 데디케이티드 하드웨어 인스턴스에서 새 표준 플랜 인스턴스를 작성할 수 있게 해 줍니다. 
2. 표준 인스턴스를 마이그레이션하십시오. 

데디케이티드 하드웨어 인스턴스에서 호스팅되고 있지 않은 Lite 플랜 및 표준 플랜 인스턴스는
언제든지 마이그레이션할 수 있습니다.
{: tip}
