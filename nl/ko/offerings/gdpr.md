---

copyright:
  years: 2018
lastupdated: "2018-06-07"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2018-04-28 -->

# 일반정보보호규정(GDPR)

GDPR은 전 세계 어디서나 개인정보의 '처리' 및 호스팅에 엄격한 규칙을 적용하면서,
EU 전반에서 비슷한 데이터 보호 법 체계를 마련하고 사용자에게 개인정보의 제어권을 돌려주는 것을 목표로 합니다. 
규정은 또한 EU 외부 및 내부에서 개인정보의 자유로운 이동과 관련한 규칙을 도입합니다. 

[일반정보보호규정(GDPR) ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://www.eugdpr.org/){:new_window}에
따라 {{site.data.keyword.cloudantfull}} 고객은
새로 제정되는 개인정보 보호 표준 및 법률에 대한
{{site.data.keyword.cloudant_short_notm}} 팀의
이해와 규제 준수 및
고유한 내부 데이터 통제 요구사항이 있는 모든 규모의 사업체를 지원하기 위해 포괄적인 솔루션을 제공할 수 있는
{{site.data.keyword.IBM}}의 폭넓은 역량에 의존할 수 있습니다.

## {{site.data.keyword.cloudant_short_notm}}에 감사 액세스하는 방법

[감사 로깅](../offerings/audit.html#audit-logging){:new_window}에서 감사에 대한 정보를 찾을 수 있습니다. 

## 지원되는 개인정보의 분류

다음 개인정보 카테고리는 GDPR에 대해 {{site.data.keyword.cloudant_short_notm}}에 의해 지원됩니다.

다음 예와 같은 **개인정보**
 * ID/결혼 여부
 * 사생활
 * 직장 생활
 * 경제 및 재정 정보
 * 위치 데이터
 * 연결성/디바이스 데이터

다음으로 제한되는 **민감한 개인정보**
  * 건강 관련 데이터, 서비스 설명에서 다룰 추가 조건

건강 관리 데이터를 저장 중인 경우, 다음 태스크를 *반드시* 완료해야 합니다.
 - 데이터를 쓰기 전에 {{site.data.keyword.cloudant_short_notm}}에 알리십시오.
 - HIPAA-준수 데디케이티드 클러스터를 요청하십시오.

지원되는 개인정보 분류에 대한 자세한 정보는
[{{site.data.keyword.cloudant_short_notm}} 2. 개인정보 아래의 상세한 시스템 요구사항 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://www.ibm.com/software/reports/compatibility/clarity-reports/report/html/softwareReqsForProduct?deliverableId=2EBB5860B34311E7A9EB066095601ABB){:new_window}을 참조하십시오.

## 나에 대한 데이터

{{site.data.keyword.cloudant_short_notm}}는 사용자에 대한 일부 데이터를 기록하며 작성된
개인 정보(PI) 데이터에 대한 데이터 제어기가 됩니다. 기록하는 데이터는 사용자가 보유한 계정의 유형에 따라 다릅니다.

{{site.data.keyword.cloudant_short_notm}} 데디케이티드 클러스터/{{site.data.keyword.cloudant_short_notm}}
엔터프라이즈 클러스터가 있는 경우, 사용자에 대한 데이터를 기록하고 GDPR의 컨텍스트 내에서 사용자의 데이터에 대한 데이터
제어기가 됩니다.
{{site.data.keyword.cloudant_short_notm}} 데디케이티드 클러스터/{{site.data.keyword.cloudant_short_notm}}
엔터프라이즈 클러스터가 있는 경우, 다음이 보유됩니다.


 * 이름
 * 이메일

보유된 데이터는 {{site.data.keyword.cloudant_short_notm}} 대시보드를 통해 보거나 업데이트될 수 있습니다.

{{site.data.keyword.cloud_notm}}(데디케이티드 인스턴스 포함)에 의해 프로비저닝된 계정이
있는 경우, {{site.data.keyword.cloudant_short_notm}}가 앞에서 언급한 개인정보를
수집하지 _않습니다_. 이 데이터는 {{site.data.keyword.cloud_notm}}에 의해 보유됩니다.

{{site.data.keyword.cloudant_short_notm}}는 서비스를 실행하고
사용자 경험을 최적화하는 과정에서 제한된 클라이언트 PI를 처리합니다. 필요한 경우,
클라이언트에 연락하기 위해 이메일을 사용합니다. {{site.data.keyword.cloudant_short_notm}} 대시보드를
사용하여 클라이언트와의 상호작용을 모니터링하는 것은 PI를 처리하는 또 다른 방법입니다.

### 처리 제한

대시보드 상호작용 데이터가 세그먼트에 전송됩니다. {{site.data.keyword.cloudant_short_notm}}에
[{{site.data.keyword.cloudant_short_notm}} 지원 요청](mailto:support@cloudant.com)을 통해
해당 방법으로 클라이언트 PI를 처리하는 것을 제한하도록 요청할 수 있습니다. 해당 요청을
수신하면 {{site.data.keyword.cloudant_short_notm}}가 세그먼트에 전송된 대로 클라이언트와 연관된 정보를
삭제하고 추가 데이터가 전송되는 것을 방지합니다. 이메일을 통해 데디케이티드 클라이언트와
연락할 수 있는 방법은 유지되어야 하며 클라이언트가
직접 또는 {{site.data.keyword.cloud_notm}} 계정 세부사항을 통해 연락처 세부사항의 클라이언트 구성을 통해
데이터를 최신 상태로 유지할 수 있도록 인터페이스가 제공되어야 합니다.

## {{site.data.keyword.cloudant_short_notm}} 데이터베이스가 암호화됩니까?

모든 클러스터에는 LUKS(Linux Unified Key Setup)를 사용하는 암호화된 파일 시스템(저장 시 암호화)가 있습니다. 데이터베이스 내의 데이터는
당사의 운영 및 지원 팀에게 표시됩니다(아래 참조).

민감한 데이터의 경우, 사용자가 결정하는 사항은 {{site.data.keyword.cloudant_short_notm}}에
표시되지 않는 상태여야 하므로 암호화하거나 전송 전에 데이터를 보호하거나 익명을 사용하십시오. `_id` 문서는
항상 볼 수 있으며 액세스 로그에 작성되므로 이에 대해 PI를 사용하는 것을 피하십시오.

## 데이터 위치

{{site.data.keyword.cloudant_short_notm}}가 개인정보를 처리하는 위치는
DPA(Data Sheet Addendum)에 의해 사용 가능하게 되며 최신 상태로 유지됩니다.

데이터 위치에 대한 자세한 정보는
[{{site.data.keyword.cloudantfull}} 7. {{site.data.keyword.IBM_notm}} 호스팅 및 처리 위치 아래의 상세한 시스템 요구사항 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://www.ibm.com/software/reports/compatibility/clarity-reports/report/html/softwareReqsForProduct?deliverableId=2EBB5860B34311E7A9EB066095601ABB){:new_window}을 참조하십시오.

## 서비스 보안

### 안전하게 {{site.data.keyword.cloudant_short_notm}} 사용

{{site.data.keyword.cloudant_short_notm}} 사용자로서 다음을 수행해야 합니다.

 * 예상치 못한 액세스를 방지하기 위해 기본 CORS 구성을 사용하십시오.
 * API 키를 자유롭게 사용하십시오. 예를 들어, 컴포넌트에 감사 로그와 연관된 '최소 권한의 액세스'가 있을 수 있습니다. 이로 인해 누가 어떤 데이터에 액세스했는지 파악할 수 있습니다.
 * 민감한 데이터를 당사에 전송하기 전에 암호화하거나 보호하거나 익명을 사용하십시오.

### 물리적 및 환경적 보안 측도

데이터 센터의 물리적 보안은 인프라 제공업체(SoftLayer, AWS, 21Vianet)가 담당합니다. 물리적 보안을 위해
외부적으로 감사되는 인증을 보유합니다. 데이터 센터 내의 물리적 보안 제어의 추가 세부사항은 제공하지 않습니다.

당사 인력에 의해 사용되는 사무실 위치의 물리적 보안은
{{site.data.keyword.IBM_notm}} Corporate가 담당합니다.
요청 시 고객에게 인증 세부사항 및 인증 보고서(ISO 및 SOC2)가 제공될 수 있습니다.

### 기술 및 구성 측도

기술 및 구성 측도(TOM)는 {{site.data.keyword.cloudant_short_notm}}에서 개인정보의 보안을 보장하기 위해 채택하고
있습니다. 당사는 채택 중인 제어에 필요한 외부적으로 감사되는 인증서를 보유하고 있습니다.
요청 시 고객에게 인증 세부사항 및 인증 보고서(ISO 및 SOC2)가 제공될 수 있습니다.

### 데이터에 대한 서비스 액세스

{{site.data.keyword.cloudant_short_notm}} 운영 및 지원 담당자는
클라이언트 데이터에 대한 액세스 권한을 보유하며 루틴 운영 동안 액세스할 수 있습니다. 이러한 액세스는
서비스 운영 및 지원을 위해 필요한 경우에만 수행됩니다.
또한 액세스는 *꼭 필요한 때 꼭 필요한 것만 알려주는* 방식으로 제한되며 기록되고 모니터되며 감사됩니다.

## 데이터의 삭제

### 문서 삭제

문서가 삭제될 때 데이터베이스가 '묘비'를 작성합니다. 묘비에 포함될 내용은 사용자가 삭제하는 방법에 따라 다릅니다.

 - `DELETE` 호출을 작성하는 경우, 묘비에 `_id`, `_rev` 및 `_deleted` 필드가 포함됩니다.
 - `_deleted: true` 필드를 사용하여 문서를 업데이트하거나 `PUT` 또는 `POST`를 수행하는 경우, 묘비에
문서 본문에 설정한 사항이 포함됩니다. 이 방법은 묘비에 문서를 삭제한 이유를 기록하는 경우와 같이
일부 상황에서 유용합니다. 

묘비 삭제에 대한 자세한 정보는 [간단한 '묘비' 문서 삭제](../api/document.html#-tombstone-documents){:new_window}를 참조하십시오.

### 언제 문서를 삭제할까요?

압축은 '리프' 개정판만 새 파일에 작성함으로써 데이터베이스에서
이전 버전(삭제 또는 기타 경우)을 자동으로 정기적으로 제거합니다. 이 때, `_id` 및
`_rev`의 히스토리를 보존하여 복제는 가능하나 이전 문서 본문은 제외됩니다.

> **참고**: {{site.data.keyword.cloudant_short_notm}}는 CouchDB 압축 API를 공개하지 않습니다.

데이터베이스가 특정 시간에 압축되도록 보장하지 않습니다. 클러스터는
각각 많은 데이터베이스를 포함하는 10000+ 개의 계정을 호스팅할 수 있습니다. 압축은 전체 클러스터에 걸려
백그라운드 프로세스로 수행되며 데이터베이스는 항상 압축되고 있습니다. 단, 방금 삭제하거나 변경한
데이터는 보장되지 않습니다.

{{site.data.keyword.cloudant_short_notm}}는
[{{site.data.keyword.IBM_notm}} Data Privacy Office(DPO) ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](http://w3-03.ibm.com/ibm/privacy/index.html){:new_window}를 통해
*잊혀질 권리* 요청을 허용합니다.
*잊혀질 권리* 요청이 {{site.data.keyword.IBM_notm}} DPO에서 작성되면
당사가 요청을 확인하고 명시적으로 데이터베이스 압축을 트리거하여 해당 압축이 발생했는지 확인합니다.
프로세스 맨 마지막의 문서의 유일한 버전이
묘비(`_id`, `_rev`, `_deleted` 및 사용자의 애플리케이션이 해당 사항을 포함하는 필드)입니다.

### 묘비 제거

{{site.data.keyword.cloudant_short_notm}}는 필요한 경우 문서에 대한 모든 참조 및 데이터를 완전히
제거할 수 있습니다. 이 태스크는 영구 제거라 불리는 운영자가 관리하는 프로세스입니다. 문서 영구 제거를 요청하기 전에
일단 프로세스가 완료되면 {{site.data.keyword.cloudant_short_notm}}에 의해 영구 제거된 문서를
*복구할 수 없음*을 이해해야 합니다.

> **참고**: CouchDB 영구 제거 API는 {{site.data.keyword.cloudant_short_notm}}에 의해 지원되지 않습니다.

GDPR의 컨텍스트에서 PI가 문서 ID 내에서 사용되는 경우에만 프로비저닝이 필요합니다. 여러 가지 이유로
`_id`가 PI를 저장하는 것은 권장하지 않으나 몇 가지 어느 정도 유효한 유스 케이스가 있습니다. 가능하면 데이터가
{{site.data.keyword.cloudant_short_notm}}에 명확하게 보이지 않도록 데이터를 암호화하거나 익명을 사용하십시오.

*잊혀질 권리* 요청을 통해 문서를 제거해야 하는 경우:

1. [{{site.data.keyword.IBM_notm}} DPO ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](http://w3-03.ibm.com/ibm/privacy/index.html){:new_window}를 사용하여 요청을 정리하여 이유와 함께 특정 문서 `_id` 값의 영구 제거를 요청하십시오.
1. {{site.data.keyword.IBM_notm}} DPO에 의해 정규 요청을 수신하면
{{site.data.keyword.cloudant_short_notm}} 운영 담당자가 요청을 확인하고 `id`에 PI가
포함되어 있는지 확인합니다. `_id`에 PI가 없는 데이터는 영구 제거하기 않습니다. 
1. {{site.data.keyword.cloudant_short_notm}}가 영구 제거 조치를 트리거하여 요청된 데이터를 영구적으로 제거합니다.

이 프로세스는 응급 삭제 요청(예: *잊혀질 권리*)에 대해서만 사용되며
장기적으로 의존하지 마십시오. 애플리케이션이 의도적으로 문서 ID에 PI를 사용하는 경우,
해당 PI를 익명으로 사용하도록 변경되거나 문서 ID에 PI를 사용하지 않도록 변경되어야 합니다. 이를
피하기 위해
{{site.data.keyword.cloudant_short_notm}} 운영 팀에 의한 정기적인 영구 제거에 의존할 수 없습니다.
따라서 {{site.data.keyword.cloudant_short_notm}}는 다음과 같은 영구 제거 요청을 거부합니다.

1. *매 30일*과 같은 정기적인 영구 제거 요청
1. 100개의 문서를 초과하는 경우에 대한 요청

영구 제거를 사용하는 경우에도 `_id` 필드 내의 PI가
{{site.data.keyword.cloudant_short_notm}} 로그와 같은 원치 않는 위치로 새어 나갈 수 있으므로 이런 경우를 피해야 합니다. 해당 로그는
비즈니스 상의 이유로 보존되며 문서 `_id` 값을 포함하는 로그 행이 삭제되지 않습니다. 

### 데이터베이스를 삭제하는 방법은 어떻습니까?

최대 48시간 동안 데이터베이스를 삭제하여 휴지통에 버리고 그 후에 데이터베이스가 파일 시스템에서 삭제됩니다. {{site.data.keyword.cloudant_short_notm}} 팀은
데이터베이스를 백업하지 *않습니다*. 이 태스크는 *고객의 책임*입니다. 데이터베이스의 모든 사본이 시스템에서
삭제되는지 확인해야 합니다. 자세한 정보는 [{{site.data.keyword.cloudant_short_notm}} 백업 및 복구](../guides/backup-cookbook.html#cloudant-nosql-db-backup-and-recovery){:new_window}를 참조하십시오. 

추가적인 도움을 받으려면 [{{site.data.keyword.cloudant_short_notm}} 지원 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](mailto:support@cloudant.com)에 문의하십시오.

