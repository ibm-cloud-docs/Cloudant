---

copyright:
  years: 2017, 2019
lastupdated: "2019-03-18"

keywords: dbaas data protection, top-tier physical platforms, secure access control, data loss, corruption

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

# 보안
{: #security}


## {{site.data.keyword.cloudant_short_notm}} DBaaS 데이터 보호 및 보안
{: #ibm-cloudant-dbaas-data-protection-and-security}

대규모 웹 및 모바일 앱의 애플리케이션 데이터를 보호하는 작업은 복잡할 수 있습니다(특히 분산 및 NoSQL 데이터베이스의 경우).

{{site.data.keyword.cloudantfull}}는 데이터베이스가
계속해서 작동하며 확장될 수 있도록 사용자가 이를 유지보수하는 작업을
줄여주는 동시에 데이터의 안전을 보장합니다.
{: shortdesc}

## 최상위 수준의 실제 플랫폼
{: #top-tier-physical-platforms}

{{site.data.keyword.cloudant_short_notm}} DBaaS는 {{site.data.keyword.cloud}} 및 Amazon과 같은 1급 클라우드 인프라 제공자에서 실제로 호스팅됩니다.
따라서, 사용자의 데이터는 이러한 제공자가 사용하는 다음 네트워크 및 물리적 보안 수단(단, 이에 한하지 않음)으로 보호됩니다.

- 인증: SSAE16, SOC 2 Type 1, ISAE 3402, ISO 27001, CSA 및 기타 표준 준수
- 액세스 및 ID 관리
- 데이터 센터에 대한 일반적인 물리적 보안 및 네트워크 운영 센터 모니터링
- 서버 보안 강화
- {{site.data.keyword.cloudant_short_notm}}에서는 사용자의 SLA 및 비용 요구사항이 변경됨에 따라 제공자를 선택하거나 전환할 수 있는 유연성을 제공합니다.

인증에 대한 세부사항은 [규제 준수 정보](/docs/services/Cloudant?topic=cloudant-compliance#compliance)에 있습니다.
{: tip}

## 액세스 제어 보안
{: #secure-access-control}

{{site.data.keyword.cloudant_short_notm}}에는 사용자가 데이터에 대한 액세스를 제어할 수 있도록
다양한 보안 기능이 내장되어 있습니다.

기능 |설명
--------|------------
인증 | {{site.data.keyword.cloudant_short_notm}}는 HTTPS API를 사용하여 액세스됩니다. API 엔드포인트가 요구하는 경우, 사용자는 {{site.data.keyword.cloudant_short_notm}}가 수신하는 모든 HTTPS 요청에 대해 인증됩니다.  {{site.data.keyword.cloudant_short_notm}}는 레거시 액세스 제어와 IAM 액세스 제어를 둘 다 지원합니다. 자세한 정보는 [IAM 안내서](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-){: new_window} 또는 레거시 [인증 API 문서](/docs/services/Cloudant?topic=cloudant-authentication#authentication){: new_window}를 참조하십시오 .
허가 | {{site.data.keyword.cloudant_short_notm}}는 레거시 액세스 제어와 IAM 액세스 제어를 둘 다 지원합니다. {{site.data.keyword.cloudant_short_notm}} 팀에서는 가능한 한 인증에 대한 IAM 액세스 제어를 사용할 것을 권장합니다. {{site.data.keyword.cloudant_short_notm}} 레거시 인증을 사용하는 경우 프로그래밍 방식의 액세스 및 복제 작업에 대한 계정 레벨 인증 정보가 아닌 [API 키](/docs/services/Cloudant?topic=cloudant-authorization#api-keys){: new_window}를 사용하는 것이 좋습니다. 자세한 정보는 [IAM 안내서](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-){: new_window} 또는 레거시 [인증 API 문서](/docs/services/Cloudant?topic=cloudant-authentication#authentication){: new_window} 및 레거시 [권한 부여 API 문서](/docs/services/Cloudant?topic=cloudant-authorization#authorization){: new_window}를 참조하십시오.
저장 시 암호화 | {{site.data.keyword.cloudant_short_notm}} 인스턴스에 저장되는 모든 데이터는 저장 시 암호화됩니다. 저장 시 암호화(encryption-at-rest)에 대해 BYOK(Bring-Your-Own-Key)를 요구하는 경우, 이는 {{site.data.keyword.cloud_notm}} Key Protect를 사용하여 사용으로 설정됩니다. {{site.data.keyword.cloudant_short_notm}}는 모든 지역에 배치된 새 {{site.data.keyword.cloudant_short_notm}} 데디케이티드 하드웨어 플랜 인스턴스에 대해 이 기능을 지원합니다. 먼저 {{site.data.keyword.cloud_notm}} 카탈로그를 사용하여 데디케이티드 하드웨어 플랜의 인스턴스를 작성하십시오. 그 후 지원 티켓을 제출하십시오. 당사 지원 팀이 사용자의 Key Protect 인스턴스에 의해 관리되는 새 데디케이티드 하드웨어 인스턴스의 저장 시 암호화(encryption-at-rest) 암호화 키 가져오기를 조율합니다.
"전송 시" 암호화 | {{site.data.keyword.cloudant_short_notm}}에 대한 모든 액세스는 HTTPS를 사용하여 암호화됩니다.
TLS | {{site.data.keyword.cloudant_short_notm}}에 대한 모든 액세스에 TLS 1.2 또는 1.3을 사용하는 것이 좋습니다. (***2019년 6월에는, 이 때부터 TLS 1.2 이상만 지원되므로 {{site.data.keyword.cloudant_short_notm}} 지원에서 이전 버전(TLS 1.0 및 1.1) 사용이 중지됩니다.***) {{site.data.keyword.cloudant_short_notm}}가 HTTPS 연결에 사용하는 인증서는 모든 브라우저, 운영 체제 및 JDK(Java Development Kit)와 같은 다른 소프트웨어 시스템에서 이미 신뢰하는 범용 신뢰 인증 기관에서 서명됩니다. 범용 신뢰 인증 기관에서 서명된 유효한(만료되지 않은) TLS 인증서를 항상 공개합니다. 하지만 고객과 변경을 조정할 수 없으며 DigiCert가 남아 있지 않을 수도 있습니다. {{site.data.keyword.cloudant_short_notm}} 서비스에 대한 지속적 액세스를 보장하기 위해 고객이 현재 인증서를 고정하지 않을 것을 권장합니다. 이 인증서는 손상 발생 시 만기와 프롬프트 순환에 따르게 됩니다. 대신 고객이 운영 체제와 브라우저에 대한 기본 인증서 번들을 사용할 것을 권장하며, 이렇게 하면 인증서 변경을 통해 보안 서비스가 지속됩니다.
엔드포인트 | 모든 {{site.data.keyword.cloudant_short_notm}} 인스턴스에는 공개적으로 액세스할 수 있는 외부 엔드포인트가 제공됩니다. 또한 2019년 1월 1일 이후에 프로비저닝된 데디케이티드 하드웨어 환경에는 이 환경에 배치된 모든 표준 플랜 인스턴스의 내부 엔드포인트가 추가됩니다. 내부 엔드포인트를 사용하면 고객이 내부 {{site.data.keyword.cloud}} 네트워크를 통해 {{site.data.keyword.cloudant_short_notm}} 인스턴스에 연결하여 업스트림 애플리케이션 트래픽이 공용 네트워크를 통하지 않으며 대역폭 비용을 발생시키지 않도록 할 수 있습니다. {{site.data.keyword.cloud}} 계정의 서비스 엔드포인트 사용에 대한 세부사항은 [서비스 엔드포인트 문서](https://cloud.ibm.com/docs/services/service-endpoint/getting-started.html#about){:new_window}를 참조하십시오.
IP 화이트리스트 지정 | 데디케이티드 {{site.data.keyword.cloudant_short_notm}} 환경을 보유한 {{site.data.keyword.cloudant_short_notm}} 고객은 지정된 서버 및 사용자만으로 액세스를 제한하기 위해 IP 주소를 화이트리스트로 지정할 수 있습니다. 멀티 테넌트 환경에 배치된 {{site.data.keyword.cloud_notm}} 퍼블릭 Lite/표준 플랜에 대해서는 IP 화이트리스트 지정을 사용할 수 없습니다. 지정된 IP 또는 IP 범위 세트에 대해 IP 화이트리스트 지정을 요청하려면 지원 티켓을 여십시오. IP 화이트리스트는 {{site.data.keyword.cloudant_short_notm}} API와 대시보드 둘 다에 적용되므로, {{site.data.keyword.cloudant_short_notm}} 대시보드에 직접 액세스해야 하는 관리자 IP를 포함시키는 것을 잊지 마십시오. 
CORS | {{site.data.keyword.cloudant_short_notm}} 대시보드 또는 API를 사용하여 특정 도메인에 대한 CORS 지원을 사용으로 설정히십시오. 자세한 정보는 [CORS API 문서](/docs/services/Cloudant?topic=cloudant-cors#cors){:new_window}를 참조하십시오.

<!--
> **Note**: Your data is visible to the {{site.data.keyword.cloudant_short_notm}} 
> worldwide team. If you don’t 
> want our team to see your data, encrypt it before sending it to 
> {{site.data.keyword.IBM_notm}}, and avoid leaking 
> data into your document `_id` and any attachment file names. In addition, 
> when you send personal data, you must use HTTPS to ensure that it is sent securely. 
> HTTP is no longer supported.  

> **Warning**: You are responsible for verifying that 
> {{site.data.keyword.cloudant_short_notm}} can be used to store 
> your data. You must also make sure that your data does not violate applicable 
> data protection laws or any regulations that require security measures 
> beyond those specified in the {{site.data.keyword.cloudant_short_notm}} 
> system requirements and {{site.data.keyword.cloud_notm}} Services terms. You must 
> verify that the security requirements are appropriate for any personal data 
> that is processed. If you are unsure, or intend to store data that is 
> beyond the scope of the {{site.data.keyword.cloudant_short_notm}} terms and conditions, 
> you must get approval from {{site.data.keyword.IBM_notm}} to ensure that it is 
> appropriate for {{site.data.keyword.cloudant_short_notm}} to store your data.
-->

## 데이터 손실 또는 손상에 대한 보호
{: #protection-against-data-loss-or-corruption}

{{site.data.keyword.cloudant_short_notm}}에는 데이터 품질 및 가용성을 유지하는 데 도움을 주는 몇 가지 기능이 있습니다.

기능 |설명
--------|------------
내구성 높은 중복 데이터 스토리지 | 기본적으로 {{site.data.keyword.cloudant_short_notm}}는 모든 문서의 사본 세 개를 클러스터에 있는 세 개의 서로 다른 노드에 저장합니다. 사본을 저장하면 장애가 발생하더라도 해당 데이터의 장애 복구 사본에 대해 작업을 계속할 수 있습니다.
데이터 복제 및 내보내기 | 사용자는 다른 데이터 센터에 있는 클러스터 간에, 또는 온프레미스 {{site.data.keyword.cloudant_short_notm}} Local 클러스터나 Apache CouchDB로 지속적으로 데이터베이스를 복제할 수 있습니다. 또 다른 옵션은 추가적인 중복성을 위해 데이터를 {{site.data.keyword.cloudant_short_notm}}에서 다른 위치 또는 소스(예: 사용자 자신의 데이터 센터)에 JSON 형식으로 내보내는 것입니다.
