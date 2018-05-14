---

copyright:
  years: 2017
lastupdated: "2017-01-10"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-01-10 -->

# Cloudant 데이터베이스에 액세스하기 위한 간단한 Bluemix 애플리케이션 작성

이 튜토리얼에서는 {{site.data.keyword.Bluemix_notm}} 서비스 인스턴스에서 호스팅되는 {{site.data.keyword.cloudantfull}} 데이터베이스에 액세스하기 위해
[Python 프로그래밍 언어 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://www.python.org/){:new_window}를
사용하는 {{site.data.keyword.Bluemix}} 애플리케이션을 작성하는 방법을 보여줍니다.
{:shortdesc}

## 내용

{{site.data.keyword.Bluemix_notm}}의 주요 이점은 {{site.data.keyword.Bluemix_notm}} 자체 내에서 애플리케이션을 작성하고 배치할 수 있다는 점입니다.
애플리케이션을 실행할 서버를 찾고 유지보수할 필요가 없습니다. 

{{site.data.keyword.Bluemix_notm}} 내의 {{site.data.keyword.cloudant_short_notm}} 데이터베이스 인스턴스를 이미 사용하고 있는 경우에는 여기에 애플리케이션을 배치하는 것이 좋습니다. 

{{site.data.keyword.Bluemix_notm}} 애플리케이션은 일반적으로 [Cloud Foundry ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://en.wikipedia.org/wiki/Cloud_Foundry){:new_window} 기술을 사용하여 작성됩니다.
Cloud Foundry는 클라우드 환경 내에서 배치되어 실행될 수 있는 애플리케이션을 작성하는 프로세스를 단순화시키는 PaaS(Platform as a Service) 기능을 제공합니다. 

[별도의 튜토리얼](create_database.html)에서는 {{site.data.keyword.Bluemix_notm}} 내의 {{site.data.keyword.cloudant_short_notm}} 데이터베이스 인스턴스를 사용하는
독립형 Python 애플리케이션을 작성하는 방법을 보여주었습니다. 이 튜토리얼에서는 {{site.data.keyword.Bluemix_notm}} 내에서 호스팅되는 작은 Python 애플리케이션을 설정하고 작성합니다.
이 애플리케이션은 {{site.data.keyword.cloudant_short_notm}} 데이터베이스 인스턴스에 연결하여 간단한 문서를 하나 작성합니다. 

각 태스크에 해당하는 Python 코드가 이 튜토리얼의 일부로서 제공되었습니다.
개념을 보여줄 수 있는 전체 Python 프로그램은 튜토리얼의 [이 부분](create_bmxapp_createapp.html#complete-listing)에 제공되어 있습니다. 

이 튜토리얼의 Python 코드를 작성하는 데 있어서 _효율성_은 고려되지 않았습니다. 이 코드의 의도는 참조하여 자신의 애플리케이션에 적용할 수 있는, 간단하고 이해하기 쉬운 작동 코드를 보여주는 것입니다. 

오류 상태에 대해 모든 가능한 검사를 수행하려는 시도 또한 이루어지지 않았습니다.
몇 가지 기법을 보여주기 위해 일부 검사 예가 포함되었으나, 사용자는 일반적인 우수 사례를 적용하여
자신의 애플리케이션에서 발생한 모든 경고 및 오류 상태를 확인하고 처리해야 합니다. 

## 태스크 개요

{{site.data.keyword.Bluemix_notm}}에서 {{site.data.keyword.cloudant_short_notm}} 데이터베이스 인스턴스에 액세스할 수 있는, 작동하는 Python 애플리케이션을 작성하려면 다음 태스크를 수행해야 합니다. 

-   [{{site.data.keyword.Bluemix_notm}}에 Python 애플리케이션 환경을 작성합니다. ](create_bmxapp_appenv.html#creating)
-   [Python 애플리케이션 환경이 {{site.data.keyword.cloudant_short_notm}} 데이터베이스 인스턴스에 '연결'되도록 합니다. ](create_bmxapp_appenv.html#connecting)
-   [(일회성 태스크) Cloud Foundry 및 Bluemix 명령행 툴킷을 다운로드하여 설치합니다. ](create_bmxapp_appenv.html#toolkits)
-   ['스타터' 애플리케이션을 다운로드합니다. ](create_bmxapp_appenv.html#starter)
-   [스타터 애플리케이션을 사용자 정의하여 {{site.data.keyword.cloudant_short_notm}} 데이터베이스 인스턴스에 액세스하기 위한 고유 애플리케이션을 작성합니다. ](create_bmxapp_createapp.html#theApp)
-   [애플리케이션을 업로드하고 작동하는지 테스트합니다. ](create_bmxapp_upload.html#uploading)
-   [기본 애플리케이션 유지보수 태스크를 수행합니다. ](create_bmxapp_maintain.html#maintenance)
-   [문제점을 진단하고 해결합니다(문제점 해결). ](create_bmxapp_maintain.html#troubleshooting)

## 튜토리얼 구조

이 튜토리얼은 다섯 개의 섹션으로 구성되어 있습니다. 

1.  [전제조건](create_bmxapp_prereq.html)
2.  [애플리케이션 환경](create_bmxapp_appenv.html)
3.  [애플리케이션 작성](create_bmxapp_createapp.html)
4.  [애플리케이션 업로드 및 실행](create_bmxapp_upload.html)
5.  [애플리케이션 유지보수 및 문제점 해결](create_bmxapp_maintain.html)

## 다음 단계

이 튜토리얼을 시작하려면 먼저 [전제조건 확인](create_bmxapp_prereq.html)부터 시작하십시오. 
