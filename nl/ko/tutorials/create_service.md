---

copyright:
  years: 2017, 2019
lastupdated: "2019-06-12"

keywords: create service instance, service credentials, locate service credentials

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

<!-- Acrolinx: 2018-09-19 -->

# {{site.data.keyword.cloud_notm}}에서의 {{site.data.keyword.cloudant_short_notm}} 인스턴스 작성
{: #creating-an-ibm-cloudant-instance-on-ibm-cloud}

이 튜토리얼에서는 {{site.data.keyword.cloud}} 대시보드를 사용하여
{{site.data.keyword.cloudantfull}} 서비스 인스턴스를 작성하는 방법,
그리고 애플리케이션이 데이터베이스와 함께 작동하도록 설정하는 데 필요한
필수 정보를 찾을 수 있는 위치를 보여줍니다.
{: shortdesc} 

## 서비스 인스턴스 작성
{: #creating-a-service-instance}

1.  {{site.data.keyword.cloud_notm}} 계정에 로그인하십시오. <br/>
        {{site.data.keyword.cloud_notm}} 대시보드는
    [https://cloud.ibm.com/ ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://cloud.ibm.com/){: new_window}에 있습니다.
    사용자 이름 및 비밀번호를 사용하여 인증하면
    {{site.data.keyword.cloud_notm}} 대시보드가 표시됩니다. `Create resource` 단추를 클릭하십시오. <br/>
    ![{{site.data.keyword.cloud_notm}} 대시보드](images/img0001.png)

2.  메뉴에서 `Databases`를 클릭하고 데이터베이스 서비스의 목록에서 `Cloudant`를 클릭하십시오. <br/>
    ![{{site.data.keyword.cloud_notm}} 데이터베이스 서비스](images/img0003.png)<br/>

3.  서비스 구성 창에서 서비스 이름을 입력하십시오. 서비스 이름, 지역/위치, 리소스 그룹 및 인증 방법이 올바른지 확인하십시오. 원하는 경우 태그를 추가하십시오. 사용 가능한 인증 방법에는 `Use only IAM` 또는 `Use both legacy credentials and IAM`이 있습니다. 자세한 정보는 [인증 방법](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-){: new_window}을 참조하십시오. 
    이 예에서 서비스 이름은 `Cloudant-o7`입니다. <br/>
    ![{{site.data.keyword.cloudant_short_notm}} 서비스 이름 및 인증 정보](images/img0005.png)
    
{{site.data.keyword.cloudant_short_notm}} 팀에서는 가능한 한 {{site.data.keyword.cloudant_short_notm}} 레거시 인증에 대한 IAM 액세스 제어를 사용할 것을 권장합니다.
{: important}

4.  기본적으로 서비스는 무료이지만 고정된 양의 프로비저닝된 처리량 용량 및 데이터 스토리지를 제공하는 'Lite' 가격 플랜을 사용하여 작성됩니다. 유료 {{site.data.keyword.cloud_notm}} 계정이 있는 경우에는 필요에 따라 프로비저닝되는 처리량 용량을 조정하고 데이터 사용량을 스케일링할 수 있도록 유료 '표준' 플랜을 선택할 수도 있습니다. 가격 플랜에 대한 자세한 정보는 [플랜](/docs/services/Cloudant?topic=cloudant-ibm-cloud-public#plans){: new_window}을 참조하십시오. 서비스를 작성하려면 `Create` 단추를 클릭하십시오. <br/>
    ![{{site.data.keyword.cloudant_short_notm}} 서비스 이름 및 인증 정보 작성](images/img0006.png)

5.  사용자의 새 {{site.data.keyword.cloudant_short_notm}} 서비스가 사용 가능한 것을 보여주는 서비스 페이지가 표시됩니다.
    애플리케이션이 서비스에 연결하는 데 필요한 연결 정보를 작성하려면
    `Service Credentials` 탭을 클릭하십시오. <br/>
    ![{{site.data.keyword.cloudant_short_notm}} 서비스 인증 정보 작성](images/img0007.png)

6.  새 {{site.data.keyword.cloudant_short_notm}} 서비스 인증 정보를 작성하십시오.
  <br>a. `New credential` 단추를 클릭하십시오.
  <br>![새 서비스 인증 정보 작성](images/img0050.png)
  <br>b. 새 인증 정보 추가 창에서 새 인증 정보의 이름을 입력하십시오. 이미지를 참조하십시오.
  <br>c. 관리자 역할을 수락하십시오.
  <br>d. (선택사항) 새 서비스 ID를 작성하거나, 이 ID가 자동으로 생성되도록 하십시오. 
  <br>d. (선택사항) 인라인 구성 매개변수를 추가하십시오. 이 매개변수는 현재 {{site.data.keyword.cloudant_short_notm}} 서비스 인증 정보에 의해 사용되지 않으므로 이를 무시하십시오. 
  <br>e. `Add` 단추를 클릭하십시오. </br>
  <br>![새 서비스 인증 정보 추가](images/img0051.png)
  <br>새 인증 정보가 테이블 뒤에 표시됩니다. </br>
  <br>f. 조치에서 `View credentials`를 클릭하십시오.
  <br>![모든 서비스 인증 정보 보기](images/img0052.png)

7.  서비스 인증 정보의 세부사항이 표시됩니다. <br/>
    ![{{site.data.keyword.cloudant_short_notm}} 서비스 인증 정보](images/img0009.png)

이러한 예의 서비스 인증 정보는 {{site.data.keyword.cloudant_short_notm}}에 데모 {{site.data.keyword.cloudant_short_notm}} 서비스가 작성될 때 정의된 것입니다. 이 인증 정보는 대시보드에 어떻게 표시되는지 사용자에게 보여주기 위해 여기서 다시 생성되었습니다. 그러나 해당 데모 {{site.data.keyword.cloudant_short_notm}} 서비스는 제거되었으며, 따라서 이들 인증 정보는 더 이상 유효하지 않습니다. 사용자는 _반드시_ 자신의 서비스 인증 정보를 제공하여 사용해야 합니다.
{: note}

## 서비스 인증 정보
{: #the-service-credentials}

서비스 인증 정보는 중요한 정보입니다. 인증 정보에 대한 액세스 권한이 있는 모든 사용자 또는 애플리케이션은 서비스 인스턴스에 대해 사실상 어떤 작업이든 수행할 수 있습니다. 예를 들면, 가짜 데이터를 작성하거나 중요 정보를 삭제할 수 있습니다. 이러한 인증 정보는 주의하여 보호하십시오.
    
{{site.data.keyword.cloudant_short_notm}}에는 프로비저닝 시에 사용할 수 있는 두 가지 인증 방법(`Use only IAM` 또는 `Use both legacy credentials and IAM`)이 있습니다. `Use both legacy credentials and IAM` 인증 방법이 선택된 경우에만 레거시 인증 정보에 대한 세부사항을 볼 수 있습니다. 인증 정보는 인스턴스의 서비스 인증 정보 탭에 표시됩니다. 두 인증 스타일을 사용하는 데 대한 자세한 정보는 [IAM 안내서](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-) 및 [레거시 인증](/docs/services/Cloudant?topic=cloudant-authentication#authentication) 문서를 참조하십시오.

서비스 인증 정보는 다음 필드를 포함합니다.

필드 |용도
------|--------
`username` | URL 내 서비스 인스턴스 사용자의 서비스 이름입니다. 이 필드는 관리자 이름의 역할도 수행합니다. 
`password` | 애플리케이션이 서비스 인스턴스에 액세스하는 데 필요한 레거시 인증 정보 비밀번호입니다. 이 필드는 `Use both legacy credentials and IAM` 옵션이 선택된 경우에만 표시됩니다. 
`host` |애플리케이션이 서비스 인스턴스를 찾는 데 사용하는 호스트 이름입니다. 이 필드는 `Use both legacy credentials and IAM` 옵션이 선택된 경우에만 표시됩니다. 
`port` | 호스트의 서비스 인스턴스에 액세스하는 데 필요한 HTTPS 포트 번호입니다. 이는 443으로, {{site.data.keyword.cloudant_short_notm}}에서 허용하는 유일한 HTTPS 액세스입니다. 이 필드는 `Use both legacy credentials and IAM` 옵션이 선택된 경우에만 표시됩니다. 
`url`	| {{site.data.keyword.cloudant_short_notm}} 인스턴스에 액세스하는 데 필요한 HTTPS URL입니다. `Use both legacy credentials and IAM` 옵션이 선택된 경우 이는 임베드된 레거시 사용자 이름 및 비밀번호 또한 포함합니다. 
`apikey` | IAM API 키입니다. 
`iam_apikey_description` | IAM API 키에 대한 설명입니다. 
`iam_apikey_name` | IAM API 키의 ID입니다.
`iam_role_crn` | IAM API 키가 가진 IAM 역할입니다.
`iam_serviceid_crn`	| 서비스 ID의 CRN입니다.

사용자의 서비스 인스턴스에 액세스할 수 있는 애플리케이션을 작성하려면 이러한 인증 정보가 필요합니다.

## 사용자의 서비스 인증 정보 찾기
{: #locating-your-service-credentials}

사용자는 언제든지 계정과 연관된 서비스의 인증 정보를 찾아볼 수 있습니다.

1.  먼저 {{site.data.keyword.cloud_notm}}에 로그인하십시오.
        {{site.data.keyword.cloud_notm}} 대시보드는
    [https://cloud.ibm.com/ ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://cloud.ibm.com/){: new_window}에 있습니다.
    사용자 이름 및 비밀번호를 사용하여 인증하면
    {{site.data.keyword.cloud_notm}} 대시보드가 표시됩니다. <br/>
    ![{{site.data.keyword.cloud_notm}} 대시보드](images/img0001.png)

2.  이 예에서는
    이름이 `Cloudant-o7`인, 이 튜토리얼의 앞부분에서 작성한
    {{site.data.keyword.cloudant_short_notm}} 서비스 인스턴스의
    서비스 인증 정보를 찾습니다. **메뉴** 아이콘 > **리소스 목록**을 클릭하고 해당 행을 클릭하십시오. <br/>
    ![{{site.data.keyword.cloudant_short_notm}} 서비스 선택](images/img0011.png)

3.  서비스에 액세스하는 데 필요한 인증 정보를 보려면
    `View Credentials`를 클릭하십시오. <br/>
    ![{{site.data.keyword.cloudant_short_notm}} 서비스 인증 정보 보기](images/img0052.png)

4.  서비스 인증 정보의 세부사항이 표시됩니다. <br/>
    ![{{site.data.keyword.cloudant_short_notm}} 서비스 인증 정보](images/img0009.png)

이러한 예의 서비스 인증 정보는 {{site.data.keyword.cloudant_short_notm}}에 데모 {{site.data.keyword.cloudant_short_notm}} 서비스가 작성될 때 정의된 것입니다. 이 인증 정보는 대시보드에 어떻게 표시되는지 사용자에게 보여주기 위해 여기서 다시 생성되었습니다. 그러나 해당 데모 {{site.data.keyword.cloudant_short_notm}} 서비스는 제거되었으며, 따라서 이들 인증 정보는 더 이상 유효하지 않습니다. 사용자는 _반드시_ 자신의 서비스 인증 정보를 제공하여 사용해야 합니다.
{: note}

