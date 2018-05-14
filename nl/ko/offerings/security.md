---

copyright:
  years: 2017
lastupdated: "2017-07-13"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-04-28 -->

# 보안

## Cloudant DBaaS 데이터 보호 및 보안

대규모 웹 및 모바일 앱의 애플리케이션 데이터를 보호하는 작업은 복잡할 수 있습니다(특히 분산 및 NoSQL 데이터베이스의 경우). 

{{site.data.keyword.cloudantfull}}는 사용자가 데이터베이스를 유지보수하기 위해 수행해야 하는 작업을 줄여줄 뿐만 아니라, 데이터의 안전을 보장함으로써 이러한 데이터베이스가 중지되는 일 없이 작동하고 확장될 수 있도록 합니다. 

## 최상위 수준의 실제 플랫폼

{{site.data.keyword.cloudant_short_notm}} DBaaS는 {{site.data.keyword.BluSoftlayer_full}} 및 Amazon과 같은 1급 클라우드 인프라 제공자에서 실제 호스팅됩니다.
따라서, 사용자의 데이터는 이러한 제공자가 사용하는 다음 네트워크 및 물리적 보안 수단(단, 이에 한하지 않음)으로 보호됩니다. 

- 인증: SSAE16, SOC 2 Type 1, ISAE 3402, ISO 27001, CSA 및 기타 표준 준수
- 액세스 및 ID 관리
- 데이터 센터에 대한 일반적인 물리적 보안 및 네트워크 운영 센터 모니터링
- 서버 보안 강화
- {{site.data.keyword.cloudant_short_notm}}에서는 사용자의 SLA 및 비용 요구사항이 변경됨에 따라 제공자를 선택하거나 전환할 수 있는 유연성을 제공합니다. 

> **참고:** 인증에 대한 세부사항은 [규제 준수 정보](compliance.html)에 있습니다. 

## 액세스 제어 보안

사용자가 데이터에 대한 액세스를 제어할 수 있도록, {{site.data.keyword.cloudant_short_notm}}에는 다양한 보안 기능이 내장되어 있습니다. 

- 인증: {{site.data.keyword.cloudant_short_notm}}는 HTTP API를 사용하여 액세스됩니다.
  API 엔드포인트가 요구하는 경우, 사용자는 {{site.data.keyword.cloudant_short_notm}}가 수신하는
  모든 HTTPS 또는 HTTP 요청에 대해 인증됩니다. 
- 권한 부여: 특정 데이터베이스에 대한 읽기, 쓰기, 관리자 권한을 부여합니다. 
- "인플라이트" 암호화: {{site.data.keyword.cloudant_short_notm}}에 대한 모든 액세스는 HTTPS를 사용하여 암호화됩니다. 
- 저장 시 암호화: {{site.data.keyword.cloudant_short_notm}}의 디스크에 저장된 데이터는 암호화할 수 있습니다. 
  > **참고**: {{site.data.keyword.Bluemix_notm}} {{site.data.keyword.cloudant_short_notm}} 인스턴스에 저장된 데이터는 항상 암호화됩니다. 
- API 액세스: {{site.data.keyword.cloudant_short_notm}}는 보안 HTTP(HTTPS)를 통해 API를 사용하여 프로그래밍 방식으로 액세스됩니다.
  API 키는 {{site.data.keyword.cloudant_short_notm}} 대시보드를 사용하여 생성할 수 있습니다. 
- IP 화이트리스트 지정: 데디케이티드 환경의 {{site.data.keyword.cloudant_short_notm}} 고객은 IP 주소의 화이트리스트를 지정하여 지정된 서버 및 사용자만으로 액세스를 제한할 수 있습니다. 
- CORS: {{site.data.keyword.cloudant_short_notm}} 대시보드를 사용하여 특정 도메인에 대한 CORS 지원을 사용으로 설정하십시오. 

## 데이터 손실 또는 손상에 대한 보호

{{site.data.keyword.cloudant_short_notm}}에는 데이터 품질 및 가용성을 유지하는 데 도움을 주는 몇 가지 기능이 있습니다. 

- 중복되며 장애 내성이 있는 데이터 스토리지: 기본적으로, {{site.data.keyword.cloudant_short_notm}}는
  모든 문서의 세 사본을 클러스터에 있는 서로 다른 세 노드에 저장합니다. 사본을 저장하면 장애가 발생하더라도
  해당 데이터의 장애 복구 사본에 대해 작업을 계속할 수 있습니다. 
- 데이터 복제 및 내보내기: 사용자는 서로 다른 데이터 센터에 있는 클러스터 간에, 또는 사내 구축형
  Cloudant Local 클러스터에, 또는 Apache CouchDB에 지속적으로 데이터베이스를 복제할 수 있습니다.
  또 다른 옵션은 추가적인 중복성을 위해 데이터를 {{site.data.keyword.cloudant_short_notm}}에서
  다른 위치 또는 소스(예: 사용자 자신의 데이터 센터)에 JSON 형식으로 내보내는 것입니다. 
