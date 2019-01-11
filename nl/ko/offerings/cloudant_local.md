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

# {{site.data.keyword.cloudant_local_notm}}

[{{site.data.keyword.cloudantfull}} Data Layer Local Edition({{site.data.keyword.cloudant_local_notm}}) ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://www.ibm.com/support/knowledgecenter/SSTPQH_1.1.0/com.ibm.cloudant.local.doc/SSTPQH_1.1.0_welcome.html){:new_window}은 {{site.data.keyword.cloudant_short_notm}} DBaaS(Database-as-a-Service) 오퍼링의 로컬 설치 버전입니다.

{{site.data.keyword.cloudant_local_notm}}에서는
전체 {{site.data.keyword.cloudant_short_notm}} 싱글 테넌트 오퍼링과 동일한 기본 기능을
제공하지만 사용자의 데이터 센터에서 호스팅됩니다.

{{site.data.keyword.cloudant_local_notm}}의
자세한 개요는 [여기 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://www.ibm.com/support/knowledgecenter/en/SSTPQH_1.1.0/com.ibm.cloudant.local.install.doc/topics/clinstall_cloudant_local_overview.html){:new_window}에
있습니다.
[IBM Knowledge Center ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://www.ibm.com/support/knowledgecenter/en/SSTPQH_1.1.0/com.ibm.cloudant.local.doc/SSTPQH_1.1.0_welcome.html){:new_window}는
다음 항목을 포함한, {{site.data.keyword.cloudant_local_notm}}의 여러 요소에 대한 정보를 제공합니다.

-   [설치 및 구성 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://www.ibm.com/support/knowledgecenter/en/SSTPQH_1.1.0/com.ibm.cloudant.local.install.doc/topics/clinstall_installing.html){:new_window}
-   [유지보수 태스크 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://www.ibm.com/support/knowledgecenter/en/SSTPQH_1.1.0/com.ibm.cloudant.local.install.doc/topics/clinstall_maintenance_tasks_overview.html){:new_window}
-   [복제 매개변수 조정 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://www.ibm.com/support/knowledgecenter/en/SSTPQH_1.1.0/com.ibm.cloudant.local.install.doc/topics/clinstall_tuning_parameters_replication_cases.html){:new_window}

## 지원

{{site.data.keyword.cloudant_short_notm}} 지원은 {{site.data.keyword.cloudant_local_notm}}의 설치, 설정 및 적절한 사용에 대한 지원을 제공합니다. 성능 문제 또는 불일치가 발생하는 경우에는 지원이 문제점을 해결하는 데 도움을 줄 수 있습니다. 가동 중단의 경우 지원은 문제를 진단하는 데 도움을 줄 수 있으나, 클라이언트 시스템에 대한 액세스 권한은 지원에 없으므로 문제를 해결할 책임은 고객의 팀에 있습니다. 

적절한 로그는 문제에 대한 올바른 지원을 제공하는 데 필요합니다. 문제점 해결을 가능한 한 빠르게 시작하려면 문제에 대해 지원에 알릴 때 Weatherreport 유틸리티의 출력을 비롯하여 관련 로그, 요청 및 상태 코드를 포함시켜야 합니다. 자세한 정보는 [Weatherreport 유틸리티 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://www.ibm.com/support/knowledgecenter/SSTPQH_1.1.0/com.ibm.cloudant.local.install.doc/topics/clinstall_checking_health_cluster_with_weatherreport.html){:new_window}를 참조하십시오. 

일반적인 문제 및 가동 중단에 대한 지원은 근본적인 문제가 지원 범위에 속하는 경우에만 제공될 수 있습니다. 다음 텍스트는 가능한 지원에 대해 설명합니다.  

{{site.data.keyword.cloudant_short_notm}} 지원에는 다음 문제가 포함됩니다. 
- 적절한 설치
- 설정
- API 리턴 오류, 예기치 않은 결과 또는 성능과 관련된 모든 항목

{{site.data.keyword.cloudant_short_notm}} 지원에는 다음 문제가 포함되지 않습니다. 
- 고객 측에서 소유한 도구 또는 워크플로우
- 네트워크 문제 
- 디스크 상 암호화 
- 사용자 정의 도구 또는 기능

예를 들어, 근본 원인이 고객 소유의 서버에서 발생한 하드웨어 문제인 경우 지원은 도움을 줄 수 없습니다. 그러나 가동 중단의 원인이 문서 충돌로 인한 요청 속도 저하와 같이 {{site.data.keyword.cloudant_short_notm}} 소프트웨어 자체인 경우에는 고객이 문제를 해결하는 데 지원이 도움을 줄 수 있습니다. 

다음 요청에 대한 추가 지원에 대해서는 고객 담당자 또는 계정 관리자에게 문의하십시오. 
- 성능 튜닝
- 디자인 최적화
- 용량 계획

지원 정책에 대해 질문이 있는 경우에는 [{{site.data.keyword.cloudant_short_notm}} 지원 팀 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](mailto:support@cloudant.com){:new_window}에 문의하십시오. 

### 지원 티켓을 여는 방법
{{site.data.keyword.cloudant_local_notm}} 문제 해결에 관한 도움을 받으려면
{{site.data.keyword.cloudant_short_notm}} 지원이 포함된 지원 티켓을 열고 다음 정보를 포함시키십시오.

1. 이메일을 작성하여 [{{site.data.keyword.cloudant_short_notm}} 지원 요청](mailto:support@cloudant.com)을 여십시오.
2. 이메일 제목 행에 문제점에 대한 하나의 문장을 입력하십시오.
3. 이메일에는 문제점 진단에 필요한 다음 세부사항이 포함되어야 합니다.
    - 이름
    - 담당자 이메일 주소
    - 조직 이름
    - 사용 중인 {{site.data.keyword.cloudant_local_notm}}의 버전
    - {{site.data.keyword.cloudant_local_notm}} 실행을 위해 사용 중인 Linux 배포판 및 버전
    - 문제점의 심각도 레벨
    - 문제점이 발생하는 조건 및 모든 최신 변경사항에 대한 정보를 포함하여 문제점에 대한 상세한 설명
    - 사용 가능한 경우, 문제점 진단, 재생 및 조사에 도움이 될 수 있는 로그 또는 출력을 첨부하십시오.
4. 지원 팀이 이메일을 수신하면 지원 팀 구성원이 연락을 드릴 것입니다.

