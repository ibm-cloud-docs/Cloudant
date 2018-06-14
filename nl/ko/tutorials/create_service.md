---

copyright:
  years: 2017, 2018
lastupdated: "2017-11-07"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

# {{site.data.keyword.Bluemix_notm}}에서 {{site.data.keyword.cloudant_short_notm}} 인스턴스 작성

이 튜토리얼에서는 {{site.data.keyword.Bluemix}} 대시보드를 사용하여 {{site.data.keyword.cloudantfull}} 서비스 인스턴스를 작성하는 방법,
그리고 애플리케이션이 데이터베이스와 함께 작동하도록 설정하는 데 필요한 필수 정보를 찾을 수 있는 위치를 보여줍니다.
{:shortdesc}

{{site.data.keyword.cloudant_short_notm}} 서비스 인스턴스에 액세스하려면 [서비스 신임 정보](#the-service-credentials) 세트가 있어야 합니다.
이 신임 정보는 서비스 인스턴스 작성 시 프로세스의 일부로서 생성됩니다.

{{site.data.keyword.cloudant_short_notm}} 계정에 액세스하여 언제든지 이러한 신임 정보를 찾아볼 수 있습니다.

## 서비스 인스턴스 작성

1.  {{site.data.keyword.Bluemix_notm}} 계정에 로그인하십시오.<br/>
{{site.data.keyword.Bluemix_notm}} 대시보드는
    [http://bluemix.net ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](http://bluemix.net){:new_window}에 있습니다.
    사용자 이름 및 비밀번호를 사용하여 인증하면 {{site.data.keyword.Bluemix_notm}} 대시보드가 표시됩니다.<br/>
    ![{{site.data.keyword.Bluemix_notm}} 대시보드](images/img0001.png)

2.  `Catalog` 링크를 클릭하십시오.<br/>
    ![{{site.data.keyword.Bluemix_notm}} 카탈로그 링크](images/img0002.png)<br/>
    {{site.data.keyword.Bluemix_notm}}에서 사용 가능한 서비스의 목록이 표시됩니다.

3.  `Services` 표제 아래의 `Data & Analytics` 항목을 클릭하십시오.<br/>
    ![{{site.data.keyword.Bluemix_notm}} Data & Analytics 서비스](images/img0003.png)<br/>
    {{site.data.keyword.Bluemix_notm}}에서 사용 가능한 Data & Analytics 서비스의 목록이 표시됩니다.

4.  {{site.data.keyword.cloudant_short_notm}} 서비스를 클릭하십시오.<br>
    ![{{site.data.keyword.Bluemix_notm}} {{site.data.keyword.cloudant_short_notm}} 서비스 선택사항](images/img0004.png)

5.  서비스 구성 창에서 서비스 이름을 입력하십시오.
    이 예에서 서비스 이름은 `Cloudant Service 2017`입니다.<br/>
    ![{{site.data.keyword.cloudant_short_notm}} 서비스 이름 및 신임 정보](images/img0005.png)

6.  기본적으로, 서비스는 무료이지만 용량이 제한된 '라이트' 가격 책정 플랜을 사용하여 작성됩니다.
    용량이 더 큰 기타 가격 책정 플랜은 [여기](../offerings/bluemix.html)에 있습니다.<br/>
    서비스를 작성하려면 `Create` 단추를 클릭하십시오.<br/>
    ![{{site.data.keyword.cloudant_short_notm}} 서비스 이름 및 신임 정보 작성](images/img0006.png)

7.  사용자의 새 {{site.data.keyword.cloudant_short_notm}} 서비스가 사용 가능한 것을 보여주는 서비스 페이지가 표시됩니다.
    사용자의 애플리케이션이 서비스에 연결하는 데 필요한 연결 정보에 액세스하려면 `Service Credentials` 탭을 클릭하십시오.<br/>
    ![{{site.data.keyword.cloudant_short_notm}} 서비스 신임 정보 액세스](images/img0007.png)

8.  서비스 신임 정보 창이 표시됩니다.
    서비스에 액세스하는 데 필요한 신임 정보를 보려면
    `View Credentials` 드롭 다운을 클릭하십시오.<br/>
    ![{{site.data.keyword.cloudant_short_notm}} 서비스 신임 정보 보기](images/img0008.png)

9.  서비스 신임 정보 세부사항이 표시됩니다.<br/>
    ![{{site.data.keyword.cloudant_short_notm}} 서비스 신임 정보](images/img0009.png)

>   **참고**: 이러한 예의 서비스 신임 정보는
    데모 {{site.data.keyword.cloudant_short_notm}} 서비스가 {{site.data.keyword.cloudant_short_notm}}에 작성될 때 정의되었습니다.
    이 신임 정보는 대시보드에 어떻게 표시되는지 사용자에게 보여주기 위해 여기서 다시 생성되었습니다.
    그러나 해당 데모 {{site.data.keyword.cloudant_short_notm}} 서비스는 제거되었으며,
    따라서 이들 신임 정보는 더 이상 유효하지 않습니다. 사용자는
    _반드시_ 자신의 서비스 신임 정보를 제공하여 사용해야 합니다.



## 서비스 신임 정보

>   **참고**: 서비스 신임 정보는 중요한 정보입니다.
    신임 정보에 대한 액세스 권한이 있는 모든 사용자 또는 애플리케이션은
    가짜 데이터를 작성하거나 중요 정보를 삭제하는 등, 서비스 인스턴스에 대해
    사실상 모든 작업을 수행할 수 있습니다.
    이러한 신임 정보는 주의하여 보호하십시오.

서비스 신임 정보는 다섯 개의 필드로 구성됩니다.

필드      | 용도
-----------|--------
`host`     | 애플리케이션이 서비스 인스턴스를 찾는 데 사용하는 호스트 이름입니다.
`username` | 애플리케이션이 서비스 인스턴스에 액세스하는 데 필요한 사용자 이름입니다.
`password` | 애플리케이션이 서비스 인스턴스에 액세스하는 데 필요한 비밀번호입니다.
`port`     | 호스트의 서비스 인스턴스에 액세스하는 데 필요한 HTTP 포트 번호입니다. 보통 HTTPS 액세스를 강제하려는 경우에는 443이 사용됩니다.
`url`      | 애플리케이션에서 사용하기에 적합하도록 기타 신임 정보를 하나의 URL로 통합하는 문자열입니다.

사용자의 서비스 인스턴스에 액세스할 수 있는 애플리케이션을 작성하려면 이러한 신임 정보가 필요합니다.

## 사용자의 서비스 신임 정보 찾기

사용자는 언제든지 계정과 연관된 서비스의 신임 정보를 찾아볼 수 있습니다.

1.  먼저 {{site.data.keyword.cloudant_short_notm}}에 로그인하십시오. {{site.data.keyword.Bluemix}} 대시보드는
    [http://bluemix.net ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](http://bluemix.net){:new_window}에 있습니다.
    사용자 이름 및 비밀번호를 사용하여 인증하면 {{site.data.keyword.Bluemix_notm}} 대시보드가 표시됩니다.<br/>
    ![{{site.data.keyword.Bluemix_notm}} 대시보드](images/img0001.png)

2.  모든 서비스가 나열된 섹션에 도달할 때까지 대시보드를 아래로 스크롤하십시오.<br/>
    ![{{site.data.keyword.Bluemix_notm}}' 서비스 목록](images/img0010.png)

3.  이 예에서는 이름이 `Cloudant Service 2017`인, 튜토리얼의 앞부분에서 작성한
    {{site.data.keyword.cloudant_short_notm}} 서비스 인스턴스의 서비스 신임 정보를 찾습니다.
    해당 행을 클릭하십시오.<br/>
    ![{{site.data.keyword.cloudant_short_notm}} 서비스 선택](images/img0011.png)

3.  서비스 신임 정보 창이 표시됩니다.
    서비스에 액세스하는 데 필요한 신임 정보를 보려면
    `View Credentials` 드롭 다운을 클릭하십시오.<br/>
    ![{{site.data.keyword.cloudant_short_notm}} 서비스 신임 정보 보기](images/img0008.png)

4.  서비스 신임 정보 세부사항이 표시됩니다.<br/>
    ![{{site.data.keyword.cloudant_short_notm}} 서비스 신임 정보](images/img0009.png)

>   **참고**: 이러한 예의 서비스 신임 정보는
    데모 {{site.data.keyword.cloudant_short_notm}} 서비스가 {{site.data.keyword.cloudant_short_notm}}에 작성될 때 정의되었습니다.
    이 신임 정보는 대시보드에 어떻게 표시되는지 사용자에게 보여주기 위해 여기서 다시 생성되었습니다.
    그러나 해당 데모 {{site.data.keyword.cloudant_short_notm}} 서비스는 제거되었으며,
    따라서 이들 신임 정보는 더 이상 유효하지 않습니다. 사용자는
    _반드시_ 자신의 서비스 신임 정보를 제공하여 사용해야 합니다.
