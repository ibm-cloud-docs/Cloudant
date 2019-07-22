---

copyright:
  years: 2015, 2019
lastupdated: "2019-06-12"

keywords: principal, action, resource, timestamp, access audit logs

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

# 감사 로깅
{: #audit-logging}

감사 로깅은 {{site.data.keyword.cloudant_short_notm}}에 저장된 데이터에 액세스한
{{site.data.keyword.cloudantfull}} 프린시펄을 기록합니다. {{site.data.keyword.cloudant_short_notm}}에
대한 모든 HTTP API 액세스의 경우, 감사 로깅 기능이
각 HTTP 요청에 관한 다음 정보를 기록합니다.

정보 |설명
------------|------------
`프린시펄` | 계정 인증 정보, API 키 또는 IBM Cloud IAM 인증 정보.
`조치` | 수행되는 조치(예: 문서 읽기).
`리소스` | 액세스되는 계정, 데이터베이스 및 문서 또는 수행되는 조회에 대한 세부사항.
`시간소인` | 시간 레코드 및 이벤트 데이터. 
{: shortdesc}

{{site.data.keyword.cloudant_short_notm}} 감사 로그를 사용하여 다음을 파악할 수 있습니다.

- 계정 내에서 액세스된 대상 및 데이터베이스 및 문서가 액세스된 시기 및 액세스한 주체
- 조회를 실행한 대상, 시기 및 주체
- 특정 프린시펄 또는 사용자가 액세스, 업데이트 또는 삭제한 대상 및 시기
- 복제 문서가 작성되거나 삭제된 대상 및 시기


## 계정에 대한 감사 로그에 액세스하는 방법
{: #how-to-access-audit-logs-for-your-account}

계정의 감사 로그에 대한 액세스를 요청하려면 {{site.data.keyword.cloudant_short_notm}} 지원에 문의하십시오. 지원은 사용자가 원하는 감사 로그의 사본을 제공합니다.

지원 팀에 문의할 때 다음 사항을 포함해야 합니다.

- 요청과 관련된 {{site.data.keyword.cloudant_short_notm}} 계정
- 감사 로그에 대한 시간 범위(지원 요청당 한 달을 초과할 수 없음)
- 해당되는 임의의 특정 데이터베이스, 문서 또는 프린시펄
