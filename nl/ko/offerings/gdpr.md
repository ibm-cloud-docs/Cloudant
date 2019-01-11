---

copyright:
  years: 2018
lastupdated: "2018-10-24"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:tip: .tip}

<!-- Acrolinx: 2017-05-10 -->

# 일반 개인정보 보호법률(General Data Protection Regulation, "GDPR")

GDPR의 목적은 EU 전체에 적용되는 일관된 개인정보 보호 법 체계를 만들어, 시민들에게 자신의 개인정보에 대한 통제권을 돌려주는 동시에
전 세계에서 이러한 정보를 호스팅하고 처리하는 대상에게 엄격한 규칙을 적용하는 것입니다. 이 규정은 또한 EU 내/외부로부터의
자유로운 개인정보 이동과 관련된 규칙을 도입합니다. 

[일반 개인정보 보호법률(GDPR) ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://www.eugdpr.org/){:new_window}에
따라 {{site.data.keyword.cloudantfull}} 고객은
새로운 개인정보 보호 표준 및 법률에 대한
{{site.data.keyword.cloudant_short_notm}} 팀의
이해와 규제 준수, 그리고
고유한 내부 데이터 통제 요구사항을 필요로 하는 모든 규모의 사업체를 지원할 포괄적인 솔루션을 제공할 수 있는
{{site.data.keyword.IBM}}의 폭넓은 역량에 의존할 수 있습니다.

## {{site.data.keyword.cloudant_short_notm}}에 대한 액세스를 감사하는 방법

[감사 로깅](../offerings/audit.html#audit-logging){:new_window}에서 감사에 대한 정보를 찾을 수 있습니다. 

## 지원되는 개인정보의 분류

{{site.data.keyword.cloudant_short_notm}}에서는 GDPR 준수를 위해 다음 개인정보 범주를 지원합니다.

다음과 같은 **개인정보**:
 * 신원/결혼 여부
 * 사생활
 * 직업
 * 위치 데이터
 * 연결성/디바이스 데이터

다음으로 제한되는 **민감한 개인정보**:
  * 건강 관련 데이터. 적용되는 추가 조건은 [{{site.data.keyword.cloudant_short_notm}} Dedicated Cluster Service Description ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://www-03.ibm.com/software/sla/sladb.nsf/pdf/6756-04/$file/i126-6756-04_05-2018_en_US.pdf){:new_window} 및 [{{site.data.keyword.cloud}} Additional Service Description ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://www-03.ibm.com/software/sla/sladb.nsf/pdf/6627-04/$file/i126-6627-04_04-2018_en_US.pdf){:new_window}에 명시됩니다.

의료 보험 데이터를 저장하는 경우에는 다음 태스크를 *반드시* 완료해야 합니다.
 - 데이터를 기록하기 전에 {{site.data.keyword.cloudant_short_notm}}에 알리십시오.
 - HIPAA 준수 데디케이티드 클러스터를 요청하십시오.

지원되는 개인정보 분류에 대한 자세한 정보는
[2. Personal Data 아래의 DSA(Data Sheet Addendum) ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://www.ibm.com/software/reports/compatibility/clarity-reports/report/html/softwareReqsForProduct?deliverableId=2EBB5860B34311E7A9EB066095601ABB){:new_window}를 참조하십시오.

## 나에 대한 정보

{{site.data.keyword.cloudant_short_notm}}는 사용자에 대한 일부 데이터를 기록하며 작성된
개인정보(Personal Information, "PI") 데이터에 대한 데이터 관리자(Data Controller)가 됩니다. {{site.data.keyword.cloudant_short_notm}}에서 기록하는 데이터는 사용자가 보유한 계정의 유형에 따라 달라집니다.

{{site.data.keyword.cloudant_short_notm}} 데디케이티드 클러스터/{{site.data.keyword.cloudant_short_notm}}
엔터프라이즈 클러스터가 있는 경우, 귀하에 대한 데이터를 기록하고 GDPR의 컨텍스트 내에서 귀하의 데이터에 대한 데이터
관리자가 됩니다. 
{{site.data.keyword.cloudant_short_notm}} 데디케이티드 클러스터/{{site.data.keyword.cloudant_short_notm}}
엔터프라이즈 클러스터가 있는 경우, 다음과 같은 귀하의 정보가 보유됩니다.

 * 이름
 * 이메일

{{site.data.keyword.cloudant_short_notm}}에 저장된 데이터는 {{site.data.keyword.cloudant_short_notm}} 대시보드를 통해 보거나 업데이트할 수 있습니다.

{{site.data.keyword.cloud_notm}}(데디케이티드 인스턴스 포함)에 의해 프로비저닝된 계정이
있는 경우, {{site.data.keyword.cloudant_short_notm}}가 앞에서 언급한 개인정보를
수집하지 _않습니다_. 이 데이터는 {{site.data.keyword.cloud_notm}}에 의해 보유됩니다.

{{site.data.keyword.cloudant_short_notm}}는 서비스를 실행하고
사용자 경험을 최적화하는 과정에서 제한된 클라이언트 PI를 처리합니다. {{site.data.keyword.cloudant_short_notm}}는 필요한 경우 고객에게 연락하는 데 이메일을 사용합니다. 고객과
{{site.data.keyword.cloudant_short_notm}} 대시보드의 상호작용을 모니터링하는 것은 {{site.data.keyword.cloudant_short_notm}}가 PI를 처리하는 또 다른 방법입니다.

### 처리 제한

{{site.data.keyword.cloudant_short_notm}}는 대시보드 상호작용 데이터를 세그먼트에 전송합니다. {{site.data.keyword.cloudant_short_notm}}에
[{{site.data.keyword.cloudant_short_notm}} 지원 요청](mailto:support@cloudant.com)을 통해
해당 방법으로 클라이언트 PI를 처리하는 것을 제한하도록 요청할 수 있습니다. 해당 요청을
수신하면 {{site.data.keyword.cloudant_short_notm}}가 세그먼트에 전송된 대로 클라이언트와 연관된 정보를
삭제하고 추가 데이터가 전송되는 것을 방지합니다. {{site.data.keyword.cloudant_short_notm}}는 이메일을 통해
데디케이티드 고객과 연락할 수 있는 기능을 유지해야 하며 고객이 직접,
또는 {{site.data.keyword.cloud_notm}} 계정 세부사항을 통해 연락처 세부사항을 구성하여
이 정보를 최신 상태로 유지할 수 있는 인터페이스를 제공합니다.

## {{site.data.keyword.cloudant_short_notm}} 데이터베이스가 암호화됩니까?

모든 클러스터에는 LUKS(Linux Unified Key Setup)를 사용하는 암호화된 파일 시스템(저장 시 암호화)이 있습니다. 데이터베이스 내의 데이터는
당사의 운영 및 지원 팀에게 표시됩니다(아래 참조).

귀하의 민감한 데이터라고 판단하는 경우, 이러한 민감한 데이터는 {{site.data.keyword.cloudant_short_notm}}에
표시되지 않아야 하므로, 이러한 정보를 암호화하거나, 전송 전에 이러한 정보를 보호하거나 익명을 사용하십시오. `https://$ACCOUNT.cloudant.com/$DATABASE/$DOCUMENT_ID`와
같이 URL의 문서 `_id`는 항상 표시되며 액세스 로그에 기록되므로
PI를 URL에 사용하지 않아야 합니다.

## 데이터 위치

{{site.data.keyword.cloudant_short_notm}}가 개인정보를 처리하는 위치는
DSA에 의해 사용 가능하게 되며 최신 상태로 유지됩니다.

데이터 위치에 대한 자세한 정보는
[7. {{site.data.keyword.IBM_notm}} Hosting and Processing Locations 아래의 DSA ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://www.ibm.com/software/reports/compatibility/clarity-reports/report/html/softwareReqsForProduct?deliverableId=2EBB5860B34311E7A9EB066095601ABB){:new_window}를 참조하십시오.

## 서비스 보안

### 보안을 유지하여 {{site.data.keyword.cloudant_short_notm}} 사용

{{site.data.keyword.cloudant_short_notm}} 사용자로서 다음을 수행해야 합니다.

 * 예상치 못한 액세스를 방지하기 위해 기본 CORS 구성을 사용하십시오.
 * API 키를 사용하십시오. 예를 들어, 컴포넌트에 감사 로그와 연관된 '최소 권한의 액세스'가 있을 수 있습니다. 이를 사용하면 누가 어떤 데이터에 액세스했는지 파악할 수 있습니다.
 * {{site.data.keyword.cloudant_short_notm}}에 표시되지 않아야 한다고 판단되는 민감한 데이터를 암호화하거나 다른 방법으로 보호(익명화)하십시오.

### 물리적 및 환경적 보안 방안(Physical And Environmental Security Measures)

데이터 센터의 물리적 보안은 인프라 제공업체(SoftLayer, AWS, 21Vianet)가 담당합니다. 물리적 보안을 위해
외부적으로 감사되는 인증을 보유합니다. {{site.data.keyword.cloudant_short_notm}}는
데이터 센터에서 사용하는 물리적 보안 제어에 대한 추가 세부사항을 제공하지
않습니다.

당사 인력에 의해 사용되는 사무실 위치의 물리적 보안은
{{site.data.keyword.IBM_notm}} Corporate가 담당합니다. 
요청 시 고객에게 인증 세부사항 및 인증 보고서(ISO 및 SOC2)가 제공될 수 있습니다.

### 기술 및 구성 방안(Technical and Organisational Measures)

{{site.data.keyword.cloudant_short_notm}}에서는 개인정보의 보안을 보장하기 위해 기술 및 구성 방안을 채택하고
있습니다. {{site.data.keyword.cloudant_short_notm}}는 {{site.data.keyword.cloudant_short_notm}}에서 사용하는 제어에 대해 외부 감사된 인증서를 보유하고 있습니다. 
요청 시 고객에게 인증 세부사항 및 인증 보고서(ISO 및 SOC2)가 제공될 수 있습니다.

### 데이터에 대한 서비스 액세스

{{site.data.keyword.cloudant_short_notm}} 운영 및 지원 담당자는
클라이언트 데이터에 대한 액세스 권한을 보유하며, 일상적인 운영 동안 액세스할 수 있습니다. 이러한 액세스는
서비스 운영 및 지원을 위해 필요한 경우에만 수행됩니다. 
또한 액세스는 *꼭 필요한 때 꼭 필요한 것만 알려주는* 방식으로 제한되며, 기록되고 모니터되며 감사됩니다.

## 데이터의 삭제

### 문서 삭제

문서가 삭제될 때 데이터베이스가 '묘비(tombstone)'를 작성합니다. 묘비에 포함될 내용은 사용자가 삭제하는 방법에 따라 다릅니다.

 - `DELETE` 호출을 사용하는 경우, 묘비에 `_id`, `_rev` 및 `_deleted` 필드가 포함됩니다.
 - `_deleted: true` 필드를 사용하여 문서를 업데이트하거나 `PUT` 또는 `POST`를 수행하는 경우, 묘비에
문서 본문에 설정한 사항이 포함됩니다. 이 방법은 묘비에 문서를 삭제한 이유를 기록하는 경우 등과 같이
일부 상황에서 유용합니다.

묘비 삭제에 대한 자세한 정보는 [간단한 '묘비' 문서 삭제](../api/document.html#-tombstone-documents){:new_window}를 참조하십시오.

### 삭제된 문서가 제거되는 시기

압축이 자동으로 실행되고 '리프' 개정판만 새 파일에 작성함으로써 데이터베이스에서
이전 버전(삭제 또는 기타 경우)을 자동으로 정기적으로 제거합니다. {{site.data.keyword.cloudant_short_notm}}는 복제를 위해
`_id` 및 `_rev`의 히스토리를 보존하지만, 이전 문서 본문은 보존하지 않습니다.

> **참고**: {{site.data.keyword.cloudant_short_notm}}는 CouchDB 압축 API를 공개하지 않습니다.

{{site.data.keyword.cloudant_short_notm}}는 데이터베이스가 특정한 시기에 압축되는 것을 보장하지
않습니다. 
압축은 스토리지 계층 전체에서
백그라운드 프로세스로 수행되며, 데이터베이스는 항상 압축되고 있는 상태입니다. 이것이 귀하가 방금 삭제하거나 변경한 데이터라는
보장은 없습니다.

{{site.data.keyword.cloudant_short_notm}}는
[{{site.data.keyword.IBM_notm}} Data Privacy Office(DPO) ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](http://w3-03.ibm.com/ibm/privacy/index.html){:new_window}를 통해
*잊혀질 권리* 요청을 허용합니다. 
*잊혀질 권리* 요청이 {{site.data.keyword.IBM_notm}} DPO에서 작성되면,
{{site.data.keyword.cloudant_short_notm}}는 요청을 확인하고 명시적으로 데이터베이스 압축을 트리거하여 해당 압축이 발생했는지 확인합니다.
프로세스 맨 마지막의 문서의 유일한 버전이
묘비(`_id`, `_rev`, `_deleted` 및 사용자의 애플리케이션이 해당 사항을 포함하는 필드)입니다.

### 묘비 제거

{{site.data.keyword.cloudant_short_notm}}는 필요한 경우 문서에 대한 모든 참조 및 데이터를 완전히
제거할 수 있습니다. 이 태스크는 영구 제거(purging)라 불리는 운영자가 관리하는 프로세스입니다. 문서 영구 제거를 요청하기 전에,
프로세스가 완료되고 나면 {{site.data.keyword.cloudant_short_notm}}에 의해 영구 제거된 문서를
*복구할 수 없음*을 이해해야 합니다.

> **참고**: CouchDB 영구 제거 API는 {{site.data.keyword.cloudant_short_notm}}에 의해 지원되지 않습니다.

GDPR의 맥락에서는 PI가 문서 ID 내에서 사용되는 경우에만 영구 제거가 필요합니다. 여러 가지 이유로
`_id`가 PI를 저장하는 것은 권장하지 않으나 몇 가지 어느 정도 유효한 이용 사례가 있습니다. 가능하면
{{site.data.keyword.cloudant_short_notm}}에서 데이터가 보이지 않도록 데이터를 암호화하거나 익명을 사용하십시오.

*잊혀질 권리* 요청을 통해 문서를 제거해야 하는 경우:

1. 이유와 함께 특정 문서 `_id` 값의 영구 제거를 요청하려면 [{{site.data.keyword.IBM_notm}} DPO ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](http://w3-03.ibm.com/ibm/privacy/index.html){:new_window}를 사용하여 요청을 제출하십시오.
1. {{site.data.keyword.IBM_notm}} DPO에서 정식 요청을 수신하면
{{site.data.keyword.cloudant_short_notm}} 운영 담당자가 요청을 확인하고 `id`에 PI가
포함되어 있는지 확인합니다. {{site.data.keyword.cloudant_short_notm}}는 `_id`에 PI가 없는 데이터를 영구 제거하지 않습니다. 
1. {{site.data.keyword.cloudant_short_notm}}가 영구 제거 조치를 트리거하여 요청된 데이터를 영구적으로 제거합니다.

이 프로세스는 긴급 삭제 요청(예: *잊혀질 권리*)에 대해서만 사용되므로
지속적으로 사용하지 마십시오. 애플리케이션이 의도적으로 문서 ID에 PI를 사용하는 경우,
해당 PI를 익명으로 사용하도록 변경하거나 문서 ID에 PI를 사용하지 않도록 변경해야 합니다. 이러한
조치를 피하기 위해 {{site.data.keyword.cloudant_short_notm}} 운영 팀에 정기적인 영구 제거를 요청해서는 안됩니다. 
따라서 {{site.data.keyword.cloudant_short_notm}}는 다음과 같은 영구 제거 요청을 거부합니다.

1. *30일마다*와 같은 정기적인 영구 제거 요청
1. 100개의 문서를 초과하는 경우에 대한 요청

영구 제거를 사용하는 경우에도 `_id` 필드 내의 PI가
{{site.data.keyword.cloudant_short_notm}} 로그와 같은 원치 않는 위치로 새어 나갈 수 있으므로 이런 경우를 피해야 합니다. 
{{site.data.keyword.cloudant_short_notm}}는 이러한 로그를 비즈니스적인 이유로 보존하며,
문서 `_id` 값을 포함하는 로그 행을 삭제하지 않습니다.

### 데이터베이스를 삭제하는 경우

데이터베이스를 삭제하면 최대 48시간 동안 이를 휴지통에 보관하며, 이후 파일 시스템에서 제거됩니다. {{site.data.keyword.cloudant_short_notm}} 팀은
데이터베이스를 백업하지 *않습니다*. 이 태스크는 *고객의 책임*입니다. 데이터베이스의 모든 사본이 시스템에서
삭제되는지 확인해야 합니다. 자세한 정보는 [{{site.data.keyword.cloudant_short_notm}} 백업 및 복구](../guides/backup-cookbook.html#cloudant-nosql-db-backup-and-recovery){:new_window}를 참조하십시오. 

추가적인 도움을 받으려면 [{{site.data.keyword.cloudant_short_notm}} 지원 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](mailto:support@cloudant.com)에 문의하십시오.

