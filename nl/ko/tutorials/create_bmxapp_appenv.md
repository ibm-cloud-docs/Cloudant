---

copyright:
  years: 2017, 2019
lastupdated: "2019-06-12"

keywords: ibm cloud application environment, ibm cloud applications and services, connect, the cloud foundry command toolkits, ibm cloud command toolkits, install the cloud foundry toolkit, install ibm cloud toolkit, the starter application

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

# {{site.data.keyword.cloudant_short_notm}} 데이터베이스에 액세스하기 위한 간단한 {{site.data.keyword.cloud_notm}} 애플리케이션 작성: 애플리케이션 환경
{: #creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment}

이 튜토리얼 섹션에서는 {{site.data.keyword.cloud}} 애플리케이션을 작성하기 위해 갖춰야 하는 애플리케이션 환경을 설정하는 방법을 설명합니다.
{: shortdesc}

## {{site.data.keyword.cloud_notm}} 애플리케이션 환경 작성
{: #creating-an-ibm-cloud-application-environment}

1.  {{site.data.keyword.cloud_notm}} 계정에 로그인하십시오. <br/>
        {{site.data.keyword.cloud_notm}} 대시보드는
    [https://cloud.ibm.com/ ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://cloud.ibm.com/){: new_window}에 있습니다.
    사용자 이름 및 비밀번호를 사용하여 인증하면 {{site.data.keyword.cloud_notm}}
    대시보드가 표시됩니다. 메뉴에서 `Catalog`를 클릭하십시오. <br/>
    ![{{site.data.keyword.cloud_notm}} 대시보드](images/img0001.png)

2.  `Compute` 카테고리를 클릭하십시오. <br/>
    ![{{site.data.keyword.cloud_notm}} Cloud Foundry 앱](images/img0012.png)<br/>
        {{site.data.keyword.cloud_notm}}에서 사용 가능한 다양한 서비스 및 앱의 목록이 표시됩니다.

3.  `Cloud Foundry` 섹션으로 스크롤하여 `Python` 항목을 클릭하십시오. <br/>
    ![{{site.data.keyword.cloud_notm}} Python 앱](images/img0013.png)<br/>
        `Create a Cloud Foundry App` 양식이 표시됩니다.

4.  `Create a Cloud Foundry App` 양식을 사용하여 Python Cloud Foundry 애플리케이션을 위한 환경을 지정하고 작성하십시오. 애플리케이션의 이름을 입력하십시오(예: `Cloudant CF app`). 호스트 이름은 자동으로 생성되지만 이를 사용자 정의할 수도 있습니다. </br>
    ![{{site.data.keyword.cloud_notm}} Python Cloud Foundry 앱 이름](images/img0014.png)
    
    호스트 이름은 {{site.data.keyword.cloud_notm}} 도메인 내에서 고유해야 합니다. 이 예에서 도메인은 `mybluemix.net`이므로 전체 호스트 이름은 `Cloudant-CF-app.mybluemix.net`입니다.
    {: tip}

5.  `Create`를 클릭하여 애플리케이션 환경을 작성하십시오. </br>
    ![{{site.data.keyword.cloud_notm}} Python Cloud Foundry 앱 작성](images/img0015.png)

6.  잠시 후 새 애플리케이션 환경에 대한
    `Getting Started` 창이 표시됩니다.
    환경 내에 테스트 애플리케이션이 자동으로 작성됩니다.
    애플리케이션은 자동으로 시작되며, 이는
    초록색 아이콘과 `Running` 상태로 표시됩니다.
    이 애플리케이션은 일종의 '하트비트' 프로그램으로서, 새 애플리케이션 환경이
    사용할 준비가 되었음을 보여주기에 충분합니다.
    {{site.data.keyword.cloud_notm}} 대시보드로 돌아가려면 `Cloud Foundry apps` 링크를 클릭하십시오. <br/>
    ![처음으로 실행되는 새 {{site.data.keyword.cloud_notm}} Python Cloud Foundry 앱](images/img0016.png)

7.  이제 리소스 목록이 새로 작성된 애플리케이션 환경을 포함합니다. <br/>
    ![대시보드에 표시된 기본 {{site.data.keyword.cloud_notm}} Python Cloud Foundry 앱](images/img0017.png)

이제 사용할 준비가 된 {{site.data.keyword.cloud_notm}} Python 애플리케이션 환경을 확보했습니다.

{{site.data.keyword.cloudant_short_notm}} 데이터베이스 인스턴스 관련 작업을 수행하려면
애플리케이션 환경과 데이터베이스 인스턴스 간에 '연결'을 작성하십시오.

## {{site.data.keyword.cloud_notm}} 애플리케이션 및 서비스 연결
{: #connecting-ibm-cloud-applications-and-services}

이 튜토리얼 섹션에서는 애플리케이션의 구성 및 관리 영역을 사용하여 {{site.data.keyword.cloud_notm}} 애플리케이션 환경 및 서비스를 연결하는 방법을 설명합니다.

1.  {{site.data.keyword.cloud_notm}} 대시보드에서 **메뉴** 아이콘 > **리소스 목록**으로 이동하여 자신의 서비스 인스턴스를 여십시오. <br/>
    ![{{site.data.keyword.cloud_notm}} 대시보드에서 자신의 애플리케이션 선택](images/img0017.png)</br>
    애플리케이션의 구성 및 관리 개요 영역이 표시됩니다.

2.  애플리케이션 환경을 다른 서비스에 연결하려면
    `Connections` 탭을 클릭하십시오. <br/>
    ![{{site.data.keyword.cloud_notm}} 애플리케이션의 연결 구성 선택](images/img0019.png)<br/>
        애플리케이션과 계정 내에서 사용 가능한 기타 서비스 간의 연결을 구성하는 영역이 표시됩니다.

3.  이 튜토리얼의 [전제조건](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-prerequisites#prerequisites-create_bmxapp_prereq)은 기존 {{site.data.keyword.cloudant_short_notm}} 데이터베이스 인스턴스가 있어야 한다는 것입니다.
    `Create connection`을 클릭하여 서비스 인스턴스와 애플리케이션 간에 연결을 설정하십시오. <br/>
    ![기존 데이터베이스 인스턴스에 연결](images/img0020.png)<br/>
        계정에 있는 기존 서비스 인스턴스의 목록이 표시됩니다.

4.  사용할 {{site.data.keyword.cloudant_short_notm}} 서비스 인스턴스를 클릭하십시오.
    이 튜토리얼은 `Cloudant-service` 인스턴스를 사용합니다. <br/>
    ![튜토리얼의 데이터베이스 인스턴스 예 선택](images/img0021.png)

5.  해당 데이터베이스 인스턴스를 애플리케이션에 연결할지 확인하라는 요청을 받습니다.
    `Connect`를 클릭하여 연결을 확인하십시오.<br>
    ![데이터베이스 인스턴스에 대한 연결 확인](images/img0022.png)

6.  진행하기 전에 서비스 ID 및 액세스 역할을 사용자 정의할 것인지 묻는 메시지가 표시됩니다. 계속하려면 `Connect`를 클릭하십시오.
    ![애플리케이션의 재스테이징 확인](images/img0022b.png)

6.  애플리케이션의 서비스 연결 수정은 전체 구성에 영향을 줍니다. 이 수정은 애플리케이션의 '재스테이징'을 필요로 하며, 이 또한 실행 중인 애플리케이션이 중지되도록 합니다. '재스테이징'을 진행할 준비가 되었는지 확인하는 창이 표시됩니다.
    계속하려면 `Restage`를 클릭하십시오. <br/>
    ![애플리케이션의 다시 스테이징 확인](images/img0023.png)

7.  서비스 연결 페이지가 다시 표시됩니다.
    여기에는 이제 새로 연결된 데이터베이스 인스턴스가 포함되어 있습니다. <br/>
    ![새로 연결된 데이터베이스 인스턴스](images/img0024.png)

이제 애플리케이션 환경과 데이터베이스 인스턴스가 연결되었습니다.
다음 단계는 {{site.data.keyword.cloud_notm}} 애플리케이션에 대해
작업하는 데 필요한 도구가 설치되어 있는지 확인하는 것입니다.

## Cloud Foundry 및 {{site.data.keyword.cloud_notm}} 명령 툴킷
{: #the-cloud-foundry-and-ibm-cloud-command-toolkits}

이 튜토리얼 섹션에서는 {{site.data.keyword.cloud_notm}} 환경, 애플리케이션 및 서비스에 대해 작업하기 위해 설치해야 하는 툴킷을 설명합니다.

[Cloud Foundry ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://en.wikipedia.org/wiki/Cloud_Foundry){: new_window}
툴킷은 Cloud Foundry 호환 환경에 배치된 애플리케이션에 대해 작업하는 데 필요한 도구의 집합입니다.
배치된 애플리케이션 업데이트, 또는 애플리케이션 시작 및 실행 중인 애플리케이션 중지와 같은 태스크에 이러한 도구를 사용하십시오.

{{site.data.keyword.cloud_notm}} 툴킷은 {{site.data.keyword.cloud_notm}} 환경에서 호스팅되어 실행되는 애플리케이션에 대해 작업하는 데 필요한 추가 기능을 제공합니다.

Cloud Foundry 및 {{site.data.keyword.cloud_notm}} 툴킷을 _둘 다_ 설치했는지 확인하십시오.
{: tip}

툴킷의 다운로드 및 설치는 일회성 태스크입니다.
툴킷이 이미 설치되어 시스템에서 작동하고 있는 경우에는 이들이 업데이트된 경우를 제외하면 다시 다운로드할 필요가 없습니다.

툴킷에 대한 자세한 정보는 [시작하기 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](/docs/services/Cloudant?topic=cloudant-getting-started#getting-started){: new_window} 튜토리얼을 참조하십시오. 

### Cloud Foundry 툴킷 설치
{: #installing-the-cloud-foundry-toolkit}

일부 운영 체제 배포판에는 사용 가능한 Cloud Foundry 툴킷 버전이 이미 포함되어 있습니다.
지원되는 버전이 6.11 이상인 경우에는 {{site.data.keyword.cloud_notm}}와 호환되며 이를 사용할 수 있습니다.
다음 명령을 실행하여 설치된 버전을 확인할 수 있습니다.

또는, 다음 단계를 사용하여 시스템에 Cloud Foundry 툴킷을 다운로드하고 설치하십시오. 

1.  Cloud Foundry 툴킷 다운로드에 대한 정보를 보려면 `Getting started`를 클릭하십시오.

2.  `CLI`를 클릭하십시오. 이 링크를 사용하면 {{site.data.keyword.cloud_notm}} Developer Tools(CLI 및 Dev Tools) 문서로 이동됩니다.

3.  `Cloud Foundry CLI plug-ins`를 클릭한 후 `{{site.data.keyword.cloud_notm}} admin CLI`를 클릭하십시오. 

4.  페이지의 지시사항에 따라 사용자의 시스템을 위한 최신 버전의 설치 프로그램을 다운로드하여 실행하십시오.

5.  작동하는 Cloud Foundry 툴킷이 있는지 확인하려면 프롬프트에서 다음 명령을 실행하십시오.

    ```sh
    cf --version
    ```
    {: pre}
    
    다음 출력과 유사한 결과가 표시됩니다.
    
    ```
    cf version 6.20.0+25b1961-2016-06-29
    ```
    {:codeblock}
    
    {{site.data.keyword.cloud_notm}}와의 호환성을 위해서는 Cloud Foundry 툴킷 버전이 6.11 이상이어야 합니다.
    {: tip}

### {{site.data.keyword.cloud_notm}} 툴킷 설치
{: #installing-the-ibm-cloud-toolkit}

시스템에 {{site.data.keyword.cloud_notm}} 툴킷을 다운로드하고 설치하려면 다음 단계를 사용하십시오.

1.  {{site.data.keyword.cloud_notm}} admin CLI 툴킷 다운로드에 대한 정보를 보려면 `Getting started`를 클릭하십시오.

2.  `CLI`를 클릭하여 [Getting started with the {{site.data.keyword.cloud_notm}} CLI ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://cloud.ibm.com/docs/cli?topic=cloud-cli-ibmcloud-cli#getting-started){: new_window} 문서를 여십시오.

3.  페이지의 지시사항에 따라 사용자의 시스템에 대해 적절한 설치 프로그램을 다운로드하여 실행하십시오.

    설치 프로그램은 Cloud Foundry 툴킷의 적절한 버전이 설치되어 있는지 확인합니다.
    모든 것이 올바른 경우 {{site.data.keyword.cloud_notm}} 툴킷이 시스템에 설치됩니다.

4.  작동하는 {{site.data.keyword.cloud_notm}} 툴킷이 있는지 확인하려면 프롬프트에서 다음 명령을 실행하십시오.
    
    ```sh
    ibmcloud --version
    ```
    {: pre}
    
    다음 출력과 유사한 결과가 표시됩니다.
    
    ```
    ibmcloud version 0.4.5+03c29de-2016-12-08T07:01:01+00:00
    ```
    {: codeblock}
    
이제 {{site.data.keyword.cloud_notm}} 애플리케이션에 대해 작업하는 데 필요한 도구가 사용 가능합니다.
다음 단계는 {{site.data.keyword.cloud_notm}} 애플리케이션을 작성하는 데 도움을 주는 '스타터' 자료를 획득하는 것입니다.

명령행 인터페이스를 설치한 후에는 대시보드의 `Getting started` 탭으로 돌아가, 명령행 인터페이스를 사용하여 Cloud Foundry 애플리케이션 및 서비스 인스턴스를 다운로드하고, 수정하고, 다시 배치하십시오. 
{: note}

## `스타터` 애플리케이션
{: #the-starter-application}

이 튜토리얼 섹션에서는 {{site.data.keyword.cloud_notm}} 스타터 애플리케이션, 그리고
{{site.data.keyword.cloudant_short_notm}} 데이터베이스 인스턴스에 액세스하기 위해 이를 사용자 정의하는 방법을 설명합니다.

{{site.data.keyword.cloud_notm}} 스타터 애플리케이션은 작동하는 {{site.data.keyword.cloud_notm}} 애플리케이션을 작성하는 데 필요한 최소한의 소스 및 구성 파일 집합입니다.
몇 가지 면에서 이는 기본 시스템 및 구성이 올바르게 작동하고 있는지 보여주기만 하는 것은 충분히 가능한 ['Hello World' 애플리케이션 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://en.wikipedia.org/wiki/%22Hello,_World!%22_program){: new_window}과 유사합니다.

{{site.data.keyword.cloud_notm}} 스타터 애플리케이션은 {{site.data.keyword.cloud_notm}} 애플리케이션을 개발해 가면서 수정하거나 확장해야 하는 예제 파일의 아카이브입니다.

이 중 세 파일은 특히 필수적입니다.

-   [`Procfile`](#the-procfile-file)
-   [`manifest.yml`](#the-manifest.yml-file)
-   [`requirements.txt`](#the-requirements.txt-file)

### `Procfile` 파일
{: #the-procfile-file}

`Procfile`에는 {{site.data.keyword.cloud_notm}}가
사용자의 애플리케이션을 실행하는 데 필요한 세부사항이 포함되어 있습니다.

더 구체적으로 말하면,
`Procfile`은 애플리케이션 프로세스 유형과
애플리케이션 실행 명령을 정의하는
Cloud Foundry 아티팩트입니다.
`Procfile`에 대한 자세한 정보는 Cloud Foundry Documentation에 있는 [About Procfiles ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://docs.cloudfoundry.org/buildpacks/prod-server.html#procfile){: new_window}를 참조하십시오. 

{{site.data.keyword.cloud_notm}} Python 스타터 애플리케이션의 `Procfile`은
다음 예와 유사합니다.

```
web: python server.py
```
{: codeblock}

이 예는 애플리케이션이 Python 웹 애플리케이션이며 다음 명령을 실행하여 시작됨을 표시합니다.

```sh
python server.py
```
{: codeblock}

스타터 애플리케이션 아카이브에는 스타터 `server.py` Python 소스 파일이 포함되어 있습니다.
`server.py` 파일은 사용자의 애플리케이션에 맞춰 수정됩니다.
또는, 완전히 새로운 Python 소스 파일을 작성하십시오.
그 후에는
애플리케이션이 시작될 때 새 파일이 사용되도록 `Procfile`을 업데이트하십시오.

### `manifest.yml` 파일
{: #the-manifest.yml-file}

`manifest.yml` 파일은 애플리케이션과
이를 실행하는 데 필요한 환경에 대한 전체 설명입니다.

{{site.data.keyword.cloud_notm}} Python 스타터 애플리케이션의 파일은 다음 예와 유사합니다.

```
applications:
- path: .
  memory: 128M
  instances: 1
  domain: mybluemix.net
  name: Cloudant Python
  host: Cloudant-Python
  disk_quota: 1024M
  services:
  - Cloudant Service 2017
```
{: codeblock}

다음 세 가지 항목을 주목해야 합니다.

-   `domain`,
    `name` 및
    `host` 값은 {{site.data.keyword.cloud_notm}} 애플리케이션
    [작성](#creating-an-ibm-cloud-application-environment) 시에 입력된 값에 해당합니다.
-   `name` 값은 사용자가 관리 중인 애플리케이션을 식별하기 위해 Cloud Foundry 툴킷이 사용합니다.
-   `services` 값은 `Cloudant-o7` 데이터베이스 인스턴스가
    {{site.data.keyword.cloudant_short_notm}} 애플리케이션 환경에 연결되었음을 확인합니다. 

`manifest.yml` 파일은 보통 수정할 필요가 없으나,
애플리케이션이 작동하는 데 이 파일이 있어야 하는 이유는 이해하는 것이 좋습니다.

### `requirements.txt` 파일
{: #the-requirements.txt-file}

`requirements.txt` 파일은 애플리케이션이 작동하는 데 필요한 추가 컴포넌트를 지정합니다.

이 스타터 애플리케이션에서는
`requirements.txt` 파일이 비어 있습니다.

그러나 이 튜토리얼에서 Python 애플리케이션은 {{site.data.keyword.cloudant_short_notm}} 데이터베이스 인스턴스에 액세스합니다.
따라서 애플리케이션은 [Python 애플리케이션용
{{site.data.keyword.cloudant_short_notm}} 클라이언트 라이브러리](/docs/services/Cloudant?topic=cloudant-supported-client-libraries#python-supported)를 사용할 수 있어야 합니다.

Python 클라이언트 라이브러리를 사용하려면
​​​ 텍스트를 포함하도록 `requirements.txt` 파일을 수정하십시오.
```
cloudant==2.3.1
```
{: codeblock}

튜토리얼의 다음 단계는 [애플리케이션 작성](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-code#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-code)입니다.
