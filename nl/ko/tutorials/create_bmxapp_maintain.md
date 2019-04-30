---

copyright:
  years: 2017, 2019
lastupdated: "2019-03-19"

keywords: maintenance tasks, find application status, start application, stop application, upload application, diagnose problems, resolve problems, application log

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

<!-- Acrolinx: 2017-01-11 -->

# {{site.data.keyword.cloudant_short_notm}} 데이터베이스에 액세스하기 위한 간단한 {{site.data.keyword.cloud_notm}} 애플리케이션 작성: 유지보수 및 문제점 해결
{: #creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-maintaining-and-troubleshooting}

이 튜토리얼에서는 {{site.data.keyword.cloud_notm}} 서비스 인스턴스에서 호스팅되는 {{site.data.keyword.cloud}} 애플리케이션을 유지보수하는 방법을 보여줍니다.
{: shortdesc}

## 기본 애플리케이션 유지보수 태스크 수행
{: #performing-basic-application-maintenance-tasks}

이 튜토리얼 섹션에서는 {{site.data.keyword.cloud_notm}}에서 Python 애플리케이션을 새로 고치고, 시작하고, 중지하는 방법을 설명합니다.

### 애플리케이션의 상태 찾기
{: #finding-the-status-of-your-application}

{{site.data.keyword.cloud_notm}} 서비스 인스턴스에 있는 애플리케이션의 상태는 대시보드에 표시됩니다.

다음 예에서 `Cloudant CF app` 애플리케이션은 실행 중이 아니며
`Stopped` 상태입니다.

!['Stopped' 상태인 애플리케이션의 대시보드를 보여주는 화면 캡처](images/img0037.png)

### 애플리케이션 시작
{: #starting-your-application}

튜토리얼 데모 데이터베이스를 먼저 삭제하지 않고 튜토리얼 애플리케이션을 시작하려 하면 애플리케이션이 올바르게 작동하지 않습니다. 이 애플리케이션은 시작하려 시도하고, 데이터베이스가 있어 실패하고, 중지된 후 다시 시작하려 시도하는 순환 상태에 빠지게 됩니다. 이 문제점을 해결하려면 [애플리케이션을 중지](#stopping-your-application)한 후 튜토리얼 데모 데이터베이스를 삭제하십시오. 이렇게 하면 애플리케이션이 시작됩니다.
{: note}
    
중지된 애플리케이션을 시작하려면 메뉴에서 `Start` 옵션을 클릭하십시오.<br/>
!['Start' 옵션을 표시하는 화면 캡처](images/img0039.png)

### 애플리케이션 중지
{: #stopping-your-application}

실행 중인 애플리케이션을 중지하려면 메뉴에서 `Stop` 옵션을 클릭하십시오.<br/>
!['Stop' 옵션을 표시하는 화면 캡처](images/img0041.png)

### 애플리케이션의 새 버전 업로드
{: #uploading-a-fresh-version-of-your-application}

애플리케이션의 새 버전을 업로드하려는 경우에는 [업로드 프로세스](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-uploading-the-application#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-uploading-the-application)를 따르기만 하면 됩니다.
애플리케이션의 새 버전이 이전 버전을 겹쳐씁니다.

업로드를 시작할 때 애플리케이션의 이전 버전이 이미 실행 중인 경우 {{site.data.keyword.cloud_notm}}는 먼저 애플리케이션을 자동으로 중지합니다.
{: tip}

## 문제점 진단 및 해결
{: #diagnosing-and-resolving-problems}

이 튜토리얼 섹션에서는 첫 {{site.data.keyword.cloud_notm}} 애플리케이션을 개발하고 배치할 때 발생할 수 있는 여러 문제점을 식별하고, 진단하고, 해결하는 데 도움을 주는 몇 가지 기본적인 문제점 해결 팁을 제공합니다.

{{site.data.keyword.cloud_notm}} 또는 Cloud Foundry 애플리케이션 작성의 우수 사례에 대한 유용한 조언은
[여기 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://docs.cloudfoundry.org/devguide/deploy-apps/prepare-to-deploy.html){: new_window}에서 얻을 수 있습니다.

특히 [로컬 파일 시스템에 대한 쓰기 발생 방지 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://docs.cloudfoundry.org/devguide/deploy-apps/prepare-to-deploy.html#filesystem){: new_window}에
대한 조언이 유용합니다.

내용을 단순하게 하기 위해, 이 튜토리얼에서는 로컬 파일 시스템에 컨텐츠를 기록합니다. 그러나 그 자료의 양은 적습니다. 이 컨텐츠는 지속적인 것이 아니며 '미션 필수적'이지 않습니다.
{: tip}

### 애플리케이션 로그 사용
{: #using-the-application-log}

{{site.data.keyword.cloud_notm}} 애플리케이션의 문제점을 진단하고 해결하는 데 있어서 가장 유용한 리소스는 로그 파일입니다.

{{site.data.keyword.cloud_notm}} 애플리케이션에 대한 로그 파일은 `Logs` 탭을 클릭해 로깅 정보 페이지를 열어 찾을 수 있습니다.<br/>
!['Logs' 정보 페이지에 액세스하는 링크를 보여주는 화면 캡처](images/img0042.png)

대부분의 로그 파일과 마찬가지로, {{site.data.keyword.cloud_notm}} 애플리케이션 로그에는 발생한 이벤트와 발생 시점에 대한 세부사항이 포함되어 있습니다.

이 로그 파일은 기록된 이벤트에 관련된 컴포넌트를 식별합니다.
다음 표에는 주요 컴포넌트가 식별되어 있습니다.

컴포넌트 레이블 |컴포넌트
----------------|----------
`API`           |Cloud Foundry 시스템입니다.
`APP`           |사용자의 애플리케이션입니다.
`CELL`          |{{site.data.keyword.cloud_notm}} 내에서 사용자의 애플리케이션을 저장하고 있는 컨테이너입니다 .
`RTR`           |애플리케이션과 외부 간에 메시지를 전달하는 네트워킹 컴포넌트입니다.

예를 들어, 다음 화면 캡처에는 몇 가지 일반적인 이벤트가 포함되어 있습니다.<br/>
![표시 로그 정보를 보여주는 화면 캡처](images/img0043.png)

다음 시간에 발생한 이벤트를 살펴보십시오.

-   오후 1:56:56에 애플리케이션이 시작되었습니다.
-   오후 1:58:43에 네트워크가 단순 HTTP 요청(`GET /`)을 수신했습니다.
-   잠시 후 HTTP 요청을 수신한 애플리케이션이 이에 응답했습니다.
-   오후 2:13:46에 애플리케이션을 중지하라는 요청을 수신했습니다.
-   오후 2:13:48에 애플리케이션이 정지 프로세스를 완료했습니다.

이 튜토리얼에 제시된 애플리케이션은 의도적으로 최소한의 작업을 수행하도록 작성되었습니다.
구체적인 예를 들면, 대상 데이터베이스가 있는지 판별하고 있는 경우 이를 다시 작성하지 않도록 하려는
시도가 이뤄지지 않았습니다.
이로 인해, 데이터베이스를 먼저 제거하지 않고 이 튜토리얼 애플리케이션을
두 번 이상 실행하려 시도하면 애플리케이션이 반복적으로 실패하고 다시 시작됩니다.

이는 다음 화면 캡처에서 확인할 수 있습니다.<br/>
![로그 내의 오류 정보를 보여주는 화면 캡처](images/img0044.png)

오후 2:31:23에, 애플리케이션에서 다음 문제점을 발견합니다.<br/>
`"Database {0} already exists".format(dbname)`

나머지 메시지는 문제점이 발생한 Python 애플리케이션의 일반적인 메시지입니다.

요컨대, 로그는 문제점이 발생한 컴포넌트를 보여주고 가능한 한 많은 세부사항을 제공합니다.
사용자는 그 후 일반적인 문제점 해결 프로시저를 적용하여 문제점을 해결해야 합니다.

## 튜토리얼의 끝
{: #end-of-tutorial}

튜토리얼을 마쳤습니다.
