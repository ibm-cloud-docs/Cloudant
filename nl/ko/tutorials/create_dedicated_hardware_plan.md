---

copyright:
  years: 2015, 2019
lastupdated: "2019-06-12"

keywords: create dedicated hardware plan instance, provision standard plan instance, cli, create credentials, list service credentials

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

# {{site.data.keyword.cloud_notm}}에서의 {{site.data.keyword.cloudant_short_notm}} 데디케이티드 하드웨어 플랜 인스턴스 작성 및 활용
{: #creating-and-leveraging-an-ibm-cloudant-dedicated-hardware-plan-instance-on-ibm-cloud}

이 튜토리얼에서는 {{site.data.keyword.cloud}} 대시보드를 사용하는 {{site.data.keyword.cloudantfull}} 데디케이티드 하드웨어 플랜 인스턴스를 작성하는 방법과,
그 후 {{site.data.keyword.cloud_notm}} 카탈로그 또는 {{site.data.keyword.cloud_notm}} CLI를 사용하여 해당 인스턴스에서 실행되는
하나 이상의 표준 플랜 인스턴스를 프로비저닝하는 방법을 보여줍니다. 
{: shortdesc}

{{site.data.keyword.cloudant_short_notm}} 데디케이티드 하드웨어 플랜 인스턴스를 작성하면 사용자의
단독 사용을 위한 데디케이티드 하드웨어에서 {{site.data.keyword.cloudant_short_notm}} 환경의 프로비저닝이 야기됩니다. 서비스 인스턴스는
{{site.data.keyword.cloud_notm}} 대시보드에서 작성되지만 사용자는 데디케이티드 하드웨어 플랜
인스턴스에 직접 액세스할 수 없으며 이에 대한 서비스 인증 정보를 보유하지 않습니다. 하나 이상의
표준 플랜 인스턴스를 프로비저닝하여 작성된 {{site.data.keyword.cloudant_short_notm}} 데디케이티드
하드웨어 플랜 인스턴스를 사용할 수 있습니다.

## {{site.data.keyword.cloudant_short_notm}} 데디케이티드 하드웨어 플랜 인스턴스 작성
{: #creating-an-ibm-cloudant-dedicated-hardware-plan-instance}

1.  {{site.data.keyword.cloud_notm}} 계정에 로그인하십시오. <br/>
        {{site.data.keyword.cloud_notm}} 대시보드는
    [`https://cloud.ibm.com/ ` ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://cloud.ibm.com/){: new_window}에 있습니다.
    사용자 이름 및 비밀번호를 사용하여 인증하면
    {{site.data.keyword.cloud_notm}} 대시보드가 표시됩니다. `Create resource` 단추를 클릭하십시오. <br/>
    ![{{site.data.keyword.cloud_notm}} 대시보드](images/img0001.png)

2.  메뉴에서 `Databases`를 클릭하고 데이터베이스 서비스의 목록에서 `Cloudant`를 클릭하십시오. <br/>
     ![{{site.data.keyword.cloud_notm}} {{site.data.keyword.cloudant_short_notm}} 서비스 선택](images/img0003.png)<br/>

3.  가격 플랜의 목록에서 `Dedicated Hardware` 플랜을 선택하십시오. <br/>
    ![가격 플랜](images/pricing_plan.png)
    
4.  다음 매개변수를 채우십시오. <br/>
    -   서비스 이름을 입력하십시오. <br/>
    -   배치할 지역/위치를 지정하십시오. 지역/위치는 인스턴스를 배치할 여섯 개 주요 {{site.data.keyword.cloud_notm}} 지역 중 하나입니다. 인스턴스의 실제 물리적 위치는 다음 목록에 설명되어 있는 위치 매개변수에 따라 결정됩니다. <br/>
    -   리소스 그룹을 선택하십시오. </br>
    -   태그를 추가하십시오. 
    -   배치할 위치를 선택하십시오. 이 위치는 인스턴스의 실제 위치로, 주요 지역과 주요 지역 외 위치를 비롯한 어느 {{site.data.keyword.cloud_notm}} 위치든 될 수 있습니다. 자세한 정보는 [{{site.data.keyword.IBM}} 글로벌 데이터 센터 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://www.ibm.com/cloud/data-centers/){:new_window}를 참조하십시오. <br/>
    -   HIPAA 필요 여부 응답에 대해 `yes` 또는 `no`를 선택하십시오. <br/> 
    
    HIPAA는 미국 지역에 대해서만 유효합니다. {{site.data.keyword.IBM}}은 HIPAA 제어를 구현하기 위해 데디케이티드 하드웨어 플랜 환경을 프로비저닝할 수 있습니다. 환경은 {{site.data.keyword.IBM_notm}}과 체결된 BAA(Business Associate Addendum)가 확인된 후에만 프로비저닝됩니다. 세부사항은 [HIPAA 지원 설정 사용](https://cloud.ibm.com/docs/account/eu_hipaa_supported.html#enabling-the-hipaa-supported-setting) 및 서비스 설명 용어를 참조하십시오. HIPAA 데이터 관리를 위한 클러스터의 프로비저닝에는 예상된 5일 기간보다 더 오랜 시간이 소요될 수 있습니다.
    {: note}

    ![데디케이티드 하드웨어 구성](images/select_deployment_location.png)
        
5.  `Create` 단추를 클릭하여 프로비저닝 프로세스를 시작하십시오. <br/>

    청구는 일할계산되므로 **Create** 단추를 클릭하기 전에 인스턴스를 환경에 프로비저닝하고 비용을 지불할 것인지 확인하십시오.
    {: note}

    ![데디케이티드 하드웨어 프로비저닝](images/create_button_provision.png)

    프로비저닝 중에는 {{site.data.keyword.cloud_notm}} 대시보드의 인스턴스 옆에 회전하는 바퀴가 표시됩니다. 베어메탈 서버에 데디케이티드 하드웨어 플랜 인스턴스를 프로비저닝하도록 요청이 전송됩니다. 프로비저닝 시간은 비동기이며 최대 5일이 걸릴 수 있습니다. 
    {: note}   

    ![데디케이티드 하드웨어 대체 버전 프로비저닝](images/create_button_provision2.png)
    
## 데디케이티드 하드웨어 환경에 표준 플랜 인스턴스 프로비저닝
{: #provisioning-a-standard-plan-instance-on-a-dedicated-hardware-environment}

1.  {{site.data.keyword.cloud_notm}} 계정에 로그인하십시오. <br/>
        {{site.data.keyword.cloud_notm}} 대시보드는
    [https://cloud.ibm.com/ ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://cloud.ibm.com/){: new_window}에 있습니다.
    사용자 이름 및 비밀번호를 사용하여 인증하면
    {{site.data.keyword.cloud_notm}} 대시보드가 표시됩니다. `Create resource` 단추를 클릭하십시오. <br/>
    ![{{site.data.keyword.cloud_notm}} 대시보드](images/img0001.png)

2.  메뉴에서 `Databases`를 클릭하고 데이터베이스 서비스의 목록에서 `Cloudant`를 클릭하십시오. <br/>
     ![{{site.data.keyword.cloud_notm}} {{site.data.keyword.cloudant_short_notm}} 서비스 선택](images/img0003.png)<br/>
    서비스 작성 페이지가 표시됩니다. <br/>  

3.  가격 플랜에서 `Standard`를 클릭하십시오. <br/>
    ![표준 가격 플랜](images/standard_pricing_plan.png)
    
    데디케이티드 하드웨어 환경에는 Lite 플랜 인스턴스를 프로비저닝할 수 없습니다.
    {: tip}
    
4.  다음 매개변수를 채우십시오. <br/>
    -   서비스 이름을 입력하십시오. <br/>
    -   배치할 지역/위치를 지정하십시오. <br/>
    -   리소스 그룹을 선택하십시오. </br>
    -   태그를 추가하십시오. 
    -   인증 방법을 선택하십시오. </br>
    -   표준 플랜 인스턴스가 배치될 환경을 선택하십시오. 계정에 배치된 데디케이티드 하드웨어 환경 인스턴스가 사용 가능한 경우에는 이러한 인스턴스가 드롭 다운에 표시됩니다. </br>
    ![표준 인스턴스 구성](images/select_environment.png)
    
5.  `Create` 단추를 클릭하십시오. <br/>
    몇 초 후에 선택한 환경에 인스턴스가 프로비저닝됩니다. .<br/>
    ![표준 인스턴스 프로비저닝](images/create_button_provision_standard.png)
    
6.  멀티 테넌트 {{site.data.keyword.cloudant_short_notm}} 인스턴스에서와 같이 서비스 인증 정보를 얻고 {{site.data.keyword.cloudant_short_notm}} 대시보드에 액세스하십시오. 
    
    자세한 정보는 [서비스 인증 정보를 찾는 방법](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud#locating-your-service-credentials){: new_window}을 참조하십시오. 
    
## {{site.data.keyword.cloud_notm}} CLI를 사용하여 데디케이티드 하드웨어 환경에 표준 플랜 인스턴스 프로비저닝
{: #provisioning-a-standard-plan-instance-on-a-dedicated-hardware-environment-with-the-ibm-cloud-cli}

{{site.data.keyword.cloud_notm}} CLI를 사용하려면 로그인해야 합니다. 대상 리소스 그룹에 로그인하여 설정하는 방법에 대한 자세한 정보는 [{{site.data.keyword.cloud_notm}} 계정에 로그인](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud-by-using-the-ibm-cloud-cli#logging-in-to-your-ibm-cloud-account){: new_window}을 참조하십시오. 

{{site.data.keyword.cloudant_short_notm}} 데디케이티드 하드웨어 플랜 환경에 {{site.data.keyword.cloudant_short_notm}} 표준 플랜 인스턴스를 작성하려는 경우 기본 명령 형식은 다음과 같습니다.


필드 |설명
------|------------
`NAME`| 사용자가 인스턴스에 지정하는 임의의 이름입니다.
`SERVICE_NAME` | `cloudantnosqldb`
`PLAN_NAME` |표준 플랜
`LOCATION` | 배치할 위치(예: us-south, us-east 또는 eu-gb)입니다. 

다음 명령 예를 참조하십시오. 

```sh
ibmcloud resource service-instance-create NAME SERVICE_NAME SERVICE_PLAN_NAME LOCATION [-p, --parameters @JSON_FILE | JSON_STRING ]
```
{: codeblock}

데디케이티드 하드웨어 환경에 배치되는 {{site.data.keyword.cloudant_short_notm}} 인스턴스에는 두 개의 추가 매개변수가 있습니다.

매개변수 |설명
----------|------------
`environment_crn` | 이 매개변수는 {{site.data.keyword.cloudant_short_notm}} 데디케이티드 하드웨어 플랜 인스턴스의 CRN으로 설정해야 합니다. {{site.data.keyword.cloud_notm}} 대시보드에서 {{site.data.keyword.cloudant_short_notm}} 데디케이티드 하드웨어 플랜 인스턴스의 관리 탭에 있는 CLI 명령 예를 보고 CRN을 판별할 수 있습니다. 또는 `ibmcloud resource service-instance SERVICE_INSTANCE_NAME` 명령을 사용하여 CRN을 판별할 수도 있습니다. 
`legacyCredentials` | 인스턴스가 레거시 및 IAM 인증 정보를 둘 다 사용하는지 또는 IAM 인증 정보만 사용하는지 결정하는, 기본값이 true인 선택적 매개변수입니다. 인증 방법 선택에 대한 세부사항은 [IAM 안내서](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-)를 참조하십시오. 

다음 명령 예를 참조하십시오. 

```sh
ibmcloud resource service-instance-create cloudant_on_ded_hardware_cli cloudantnosqldb standard us-south -p '{"environment_crn":"crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b43434444bb7e2abb0841ca25d28ee4c:301a3118-7678-4d99-b1b7-4d45cf5f7b29::","legacyCredentials":false}'
```
{: codeblock}

## {{site.data.keyword.cloudant_short_notm}} 서비스의 인증 정보 작성
{: #creating-the-credentials-for-your-ibm-cloudant-service}

{{site.data.keyword.cloudant_short_notm}} 서비스에 액세스해야 하는 애플리케이션에는 필요한 인증 정보가 있어야 합니다.

서비스 인증 정보는 중요한 정보입니다. 인증 정보에 대한 액세스 권한이 있는 모든 사용자 또는 애플리케이션은 서비스 인스턴스에 대해 사실상 어떤 작업이든 수행할 수 있습니다. 예를 들면, 가짜 데이터를 작성하거나 중요 정보를 삭제할 수 있습니다. 이러한 인증 정보는 주의하여 보호하십시오.
{: important}

서비스 인증 정보에 포함된 필드에 대한 자세한 정보는 [IAM 안내서](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-)를 참조하십시오.

{{site.data.keyword.cloud_notm}} 내의 서비스 인스턴스에 대한 인증 정보를 작성하는 기본 명령 형식은 다음과 같습니다.

```sh
ibmcloud resource service-key-create NAME ROLE_NAME --instance-name SERVICE_INSTANCE_NAME [-p '{"service-endpoints":"internal"}]
```
{: pre}

각 필드는 다음 표에 설명되어 있습니다.

필드 |설명
------|------------
`NAME` | 사용자가 서비스 인증 정보에 지정하는 임의의 이름입니다. 
`ROLE_NAME` | 이 필드는 현재 관리자 역할만 허용합니다 .
`SERVICE_INSTANCE_NAME` | 사용자가 {{site.data.keyword.cloudant_short_notm}} 인스턴스에 지정하는 이름입니다.
`service-endpoints` | 내부 엔드포인트로 서비스 인증 정보의 URL 필드를 채워 {{site.data.keyword.cloud_notm}} 내부 네트워크를 통해 서비스에 연결하기 위한 선택적 매개변수입니다. 공개적으로 액세스할 수 있는 외부 엔드포인트로 URL을 채우려면 이 매개변수를 생략하십시오. 내부 엔드포인트를 지원하는 데디케이티드 하드웨어 환경에 배치된 표준 플랜 인스턴스에만 적용됩니다. 환경이 내부 엔드포인트를 지원하지 않는 경우 명령으로 인해 400 오류가 발생합니다. 

{{site.data.keyword.cloudant_short_notm}} 서비스의 `cs20170517a` 인스턴스에 대한 인증 정보(여기서
인증 정보의 이름은 `creds_for_cs20170517a`임)를 작성하려는 경우 다음 예와 유사한 명령을 사용하여 인증 정보를 작성합니다.

```sh
ibmcloud resource service-key-create creds_for_cs20170517a Manager --instance-name cs20170517a
```
{: codeblock}

서비스 인스턴스에 대한 인증 정보 작성 요청을 수신하고 나면 {{site.data.keyword.cloud_notm}}는 다음 예와 유사한 메시지로 응답합니다.

```sh
Creating service key in resource group default of account John Does's Account as john.doe@email.com...
OK
Service key crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42223455bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3:resource-key:621ffde2-ea10-4318-b297-d6d849cec48a was created.
                  
Name:          creds_for_cs20170517a   
ID:            crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42223455bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3:resource-key:621ffde2-ea10-4318-b297-d6d849cec48a   
Created At:    Tue Sep 18 19:58:38 UTC 2018   
State:         active   
Credentials:                                   
               iam_apikey_name:          auto-generated-apikey-621ffde2-ea10-4318-b297-d6d849cec48a      
               iam_role_crn:             crn:v1:bluemix:public:iam::::serviceRole:Manager      
               url:                      https://f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix:5811381f6daff7255b288695c3544be63f550e975bcde46799473e69c7d48d61@f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix.cloudant.com      
               username:                 f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix      
               port:                     443      
               apikey:                   XXXXX-XXXXXX_XXXXXXXXXXXXX-XXXXXXXXXXX      
               host:                     f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix.cloudant.com      
               iam_apikey_description:   Auto generated apikey during resource-key operation for Instance - crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42116849bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3::      
               iam_serviceid_crn:        crn:v1:bluemix:public:iam-identity::a/b42116849bb7e2abb0841ca25d28ee4c::serviceid:ServiceId-53f9e2a2-cdfb-4f90-b072-bfffafb68b3e      
               password:                 581138...7d48d61 
```
{: pre}

{{site.data.keyword.cloudant_short_notm}} 서비스의 `cs20170517a` 인스턴스에 대한 인증 정보(여기서
인증 정보의 이름은 `creds_for_cs20170517a`임)를 작성하고 내부 엔드포인트로 URL을 채우려는 경우 다음 예와 유사한 명령을 사용하여 이러한 인증 정보를 작성합니다.

```sh
ibmcloud resource service-key-create creds_for_cs20170517a Manager --instance-name cs20170517a -p '{"service-endpoints":"internal"}'
```
{: codeblock}

서비스 인스턴스에 대한 인증 정보 작성 요청을 수신하고 나면 {{site.data.keyword.cloud_notm}}는 다음 예와 유사한 메시지로 응답합니다.

```sh
Creating service key in resource group default of account John Does's Account as john.doe@email.com...
OK
Service key crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42223455bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3:resource-key:621ffde2-ea10-4318-b297-d6d849cec48a was created.
                  
Name:          creds_for_cs20170517a   
ID:            crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42223455bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3:resource-key:621ffde2-ea10-4318-b297-d6d849cec48a   
Created At:    Tue Jan 02 19:58:38 UTC 2019   
State:         active   
Credentials:                                   
               iam_apikey_name:          auto-generated-apikey-621ffde2-ea10-4318-b297-d6d849cec48a      
               iam_role_crn:             crn:v1:bluemix:public:iam::::serviceRole:Manager      
               url:                      https://2624fed5-e53e-41de-a85b-3c7d7636886f-bluemix.private.cloudantnosqldb.appdomain.cloud      
               username:                 f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix          
               apikey:                   XXXXX-XXXXXX_XXXXXXXXXXXXX-XXXXXXXXXXX      
               host:                     2624fed5-e53e-41de-a85b-3c7d7636886f-bluemix.private.cloudantnosqldb.appdomain.cloud      
               iam_apikey_description:   Auto generated apikey during resource-key operation for Instance - crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42116849bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3::      
               iam_serviceid_crn:        crn:v1:bluemix:public:iam-identity::a/b42116849bb7e2abb0841ca25d28ee4c::serviceid:ServiceId-53f9e2a2-cdfb-4f90-b072-bfffafb68b3e       
```
{: pre}

## {{site.data.keyword.cloudant_short_notm}} 서비스에 대한 인증 정보 나열
{: #listing-the-service-credentials-for-your-ibm-cloudant-service}

{{site.data.keyword.cloud_notm}} 내의 서비스 인스턴스에 대한 인증 정보를 검색하는 기본 명령 형식은 다음과 같습니다.

```sh
ibmcloud resource service-key KEY_NAME
```
{: codeblock}

이 예에서는 {{site.data.keyword.cloudant_short_notm}} 서비스의 `cs20170517a` 인스턴스에 대한
인증 정보(여기서 인증 정보의 이름은 `creds_for_cs20170517a`)를 검색할 것이며,
사용자는 다음 예와 유사한 명령을 사용하여 해당 인증 정보를 검색할 수 있습니다.

```sh
ibmcloud resource service-key creds_for_cs20170517b
```
{: codeblock}

서비스 인스턴스에 대한 인증 정보 검색 요청을 수신하고 나면 {{site.data.keyword.cloud_notm}}는 다음 예(축약됨)와 유사한 메시지로 응답합니다.

```sh
Retrieving service key in resource group default of account John Does's Account as john.doe@email.com...
OK
Service key crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42223455bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3:resource-key:621ffde2-ea10-4318-b297-d6d849cec48a was created.
                  
Name:          creds_for_cs20170517a   
ID:            crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42223455bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3:resource-key:621ffde2-ea10-4318-b297-d6d849cec48a   
Created At:    Tue Sep 18 19:58:38 UTC 2018   
State:         active   
Credentials:                                   
               iam_apikey_name:          auto-generated-apikey-621ffde2-ea10-4318-b297-d6d849cec48a      
               iam_role_crn:             crn:v1:bluemix:public:iam::::serviceRole:Manager      
               url:                      https://f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix:5811381f6daff7255b288695c3544be63f550e975bcde46799473e69c7d48d61@f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix.cloudant.com      
               username:                 f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix      
               port:                     443      
               apikey:                   XXXXX-XXXXXX_XXXXXXXXXXXXX-XXXXXXXXXXX      
               host:                     f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix.cloudant.com      
               iam_apikey_description:   Auto generated apikey during resource-key operation for Instance - crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42116849bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3::      
               iam_serviceid_crn:        crn:v1:bluemix:public:iam-identity::a/b42116849bb7e2abb0841ca25d28ee4c::serviceid:ServiceId-53f9e2a2-cdfb-4f90-b072-bfffafb68b3e      
               password:                 581138...7d48d61 
```
{: pre}
