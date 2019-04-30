---

copyright:
  years: 2017, 2019
lastupdated: "2019-03-19"

keywords: identify, api endpoints, log in, select ibm cloudant plan, create ibm cloudant service, create credentials, list service credentials, use ibm cloudant service instance, delete service credentials, delete service instance

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

<!-- Acrolinx: 2018-08-20 -->

# {{site.data.keyword.cloud_notm}} CLI를 사용하여 {{site.data.keyword.cloud_notm}}에 {{site.data.keyword.cloudant_short_notm}} 인스턴스 작성
{: #creating-an-ibm-cloudant-instance-on-ibm-cloud-by-using-the-ibm-cloud-cli}

이 튜토리얼에서는 {{site.data.keyword.cloud_notm}} CLI를 사용하여 {{site.data.keyword.cloud}}에
{{site.data.keyword.cloudantfull}} 서비스 인스턴스를 작성하는 방법을 보여줍니다.
{: shortdesc}

## 이 튜토리얼을 시작하기 전에 
{: #before-you-start-this-tutorial}

이 튜토리얼을 수행하려면 먼저 {{site.data.keyword.cloud_notm}} CLI 개발자 도구를 설치해야 합니다. 도구 설치에 대한 자세한 정보는 [Getting started with the {{site.data.keyword.cloud_notm}} CLI ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://cloud.ibm.com/docs/cli?topic=cloud-cli-ibmcloud-cli#overview){: new_window} 튜토리얼을 참조하십시오.

## {{site.data.keyword.cloud_notm}} API 엔드포인트 식별
{: #identifying-the-ibm-cloud-api-endpoint}

{{site.data.keyword.cloud_notm}} 명령의 대상 API 엔드포인트를 지정하십시오.

```sh
ibmcloud api https://api.ng.bluemix.net
```
{: codeblock}

결과는 사용자가 올바르게 엔드포인트를 식별했음을 확인합니다.

```sh
Setting api endpoint to https://api.ng.bluemix.net...
OK

API endpoint: https://api.ng.bluemix.net (API version: 2.54.0)
Not logged in. Use 'ibmcloud login' to log in.
```
{: pre}

## {{site.data.keyword.cloud_notm}} 계정에 로그인
{: #logging-in-to-your-ibm-cloud-account}

다음 예는 로그인 프로세스를 나타냅니다. 연합 사용자 ID를 사용하고 있는 경우에는 일회성 패스코드(`ibmcloud login --sso`)로 전환하거나 API 키(`ibmcloud --apikey key or @key_file`)를 사용하여 인증하는 것이 중요합니다. CLI를 사용한 로그인 방법에 대한 자세한 정보는 [General CLI (ibmcloud) commands ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://cloud.ibm.com/docs/cli/reference/ibmcloud?topic=cloud-cli-ibmcloud_cli#ibmcloud_login){: new_window}의 `ibmcloud login`을 참조하십시오. 

1.  다음 명령을 사용하여
  {{site.data.keyword.cloud_notm}} 계정의 로그인 프로세스를 시작하십시오.
  
  ```sh
  ibmcloud login
  ```
  {: codeblock}
  
  {{site.data.keyword.cloud_notm}}는 사용자에게 응답하면서
현재 API 엔드포인트를 알려준 후, 계정의 이메일 주소를 묻습니다.
  
  ```sh
  API endpoint: https://api.ng.bluemix.net
  
  Email>
  ```
  {: pre}

2.  계정의 이메일 주소를 입력한 후 비밀번호를 입력하십시오.

  ```sh
  API endpoint: https://api.ng.bluemix.net
  
  Email> J.Doe@email.com
  
  Password>
  ```
  {: pre}
  
  {{site.data.keyword.cloud_notm}}가 세부사항을 유효성 검증한 후 로그인 세션에 대한 정보를 요약합니다.

  ```sh
  API endpoint: https://api.ng.bluemix.net
  
  Email> J.Doe@email.com
  
  Password> 
  Authenticating...
  OK
  
  Targeted account J DOE's Account (707...a32)
  
  Targeted org J.Doe@email.com
  
  Targeted space dev
  
  API endpoint:   https://api.ng.bluemix.net (API version: 2.54.0)
  Region:         us-south
  User:           j.doe@email.com
  Account:        J DOE's Account (707...a32)
  Org:            J.Doe@email.com
  Space:          dev
  ```
  {: pre}

3.  {{site.data.keyword.cloud_notm}} 계정에 로그인했습니다.

## 서비스에 대한 {{site.data.keyword.cloudant_short_notm}} 플랜 선택
{: #choosing-the-ibm-cloudant-plan-for-your-service}

{{site.data.keyword.cloudant_short_notm}} Lite 또는 표준 플랜의 사용에 대한 세부사항은 문서의 [Plans ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](/docs/services/Cloudant?topic=cloudant-ibm-cloud-public#plans){: new_window} 섹션을 참조하십시오.
{: pre}

## {{site.data.keyword.cloudant_short_notm}} 서비스 작성
{: #creating-the-ibm-cloudant-service}

{{site.data.keyword.cloudant_short_notm}}는 새 인스턴스를 프로비저닝하는 데 Cloud Foundry 조직 및 영역을 사용하지 않고 리소스 그룹을 사용합니다. 이전에 프로비저닝된 {{site.data.keyword.cloudant_short_notm}} 인스턴스는 여전히 Cloud Foundry 조직 및 영역에 배치될 수 있습니다. 자세한 정보는 [How does IBM Cloudant work with IBM Cloud Resource Groups? ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](/docs/services/Cloudant?topic=cloudant-how-does-ibm-cloudant-work-with-ibm-cloud-resource-groups-#how-does-ibm-cloudant-work-with-ibm-cloud-resource-groups-){: new_window} 안내서를 참조하십시오.

먼저 [General CLI (ibmcloud) commands ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://cloud.ibm.com/docs/cli/reference/ibmcloud?topic=cloud-cli-ibmcloud_cli#ibmcloud_target){: new_window}의 `ibmcloud target`에 표시되어 있는 바와 같이 다음 명령을 사용하여 대상 리소스 그룹 및 지역을 설정하십시오.

```sh
ibmcloud target [-r REGION_NAME] [-g RESOURCE_GROUP]
```

지역 목록을 보려면 다음 명령을 실행하십시오.

```sh
ibmcloud regions
```

리소스 그룹 목록을 보려면 다음 명령을 실행하십시오. 

```sh
ibmcloud resource groups
```

두 번째로, {{site.data.keyword.cloud_notm}} 내에서 서비스 인스턴스를 작성하기 위한 기본 명령 형식은 다음과 같습니다.

```sh
ibmcloud resource service-instance-create NAME SERVICE_NAME|SERVICE_ID SERVICE_PLAN_NAME|SERVICE_PLAN_ID LOCATION [-p, --parameters @JSON_FILE | JSON_STRING ]
```
{: pre}

각 필드는 다음 표에 설명되어 있습니다. 


필드 |설명
------|------------
`NAME` | 사용자가 인스턴스에 지정하는 임의의 이름입니다. 
`SERVICE_NAME` | `cloudantnosqldb`
`PLAN_NAME` | Lite 플랜 또는 표준 플랜입니다.
`LOCATION` | 배치할 위치(아시아/태평양 북부, 독일, 글로벌, 시드니, 영국, 미국 동부 또는 미국 남부)입니다. 
`legacyCredentials` | 기본값은 true입니다. 이 필드는 인스턴스가 레거시 및 IAM 인증 정보를 둘 다 사용하는지, 또는 IAM 인증 정보만 사용하는지 결정합니다. 

인증 방법 선택에 대한 자세한 정보는 [IAM 안내서](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-){: new_window}를 참조하십시오. {{site.data.keyword.cloudant_short_notm}} 팀에서는 가능한 한 {{site.data.keyword.cloudant_short_notm}} 레거시 인증에 대한 IAM 액세스 제어를 사용할 것을 권장합니다.
{: important}

이 예에서는 `Lite` 플랜을 사용하여 {{site.data.keyword.cloudant_short_notm}} 서비스의 인스턴스를 작성할 것입니다(여기서 인스턴스 이름은 미국 남부 위치의 `cs20170517a`이며 IAM 인증 정보만 사용함). 이 인스턴스는 다음 예와 유사한 명령을 사용하여 작성합니다.

```sh
ibmcloud resource service-instance-create cs20170517a cloudantnosqldb lite us-south -p '{"legacyCredentials": false}'
```
{: codeblock}

서비스 인스턴스를 작성하고 나면 {{site.data.keyword.cloud_notm}}가
다음 예와 유사한 메시지로 응답합니다.

```sh
Creating service instance cs20170517a in resource group default of account John Does's Account as j.doe@email.com...
OK
Service instance cs20170517a was created.
Name          Location   State    Type               Tags   
cs20170517a   us-south   active   service_instance  
```
{: pre}

## {{site.data.keyword.cloudant_short_notm}} 서비스의 인증 정보 작성
{: #creating-credentials-for-your-ibm-cloudant-service}

{{site.data.keyword.cloudant_short_notm}} 서비스에 액세스해야 하는 애플리케이션에는 필요한 인증 정보가 있어야 합니다.

서비스 인증 정보는 중요한 정보입니다. 인증 정보에 대한 액세스 권한이 있는 모든 사용자 또는 애플리케이션은 서비스 인스턴스에 대해 사실상 어떤 작업이든 수행할 수 있습니다. 예를 들면, 가짜 데이터를 작성하거나 중요 정보를 삭제할 수 있습니다. 이러한 인증 정보는 주의하여 보호하십시오.
{: important}

서비스 인증 정보에 포함된 필드에 대한 자세한 정보는 [IAM 안내서](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-){: new_window}를 참조하십시오.

{{site.data.keyword.cloud_notm}} 내의 서비스 인스턴스에 대한 인증 정보를 작성하는 기본 명령 형식은 다음과 같습니다.

```sh
ibmcloud resource service-key-create NAME ROLE_NAME --instance-name SERVICE_INSTANCE_NAME
```
{: pre}

각 필드는 다음 표에 설명되어 있습니다.

필드 |설명
------|------------
`NAME` | 사용자가 서비스 인증 정보에 지정하는 임의의 이름입니다. 
`ROLE_NAME` | 이 필드는 현재 관리자 역할만 허용합니다 .
`SERVICE_INSTANCE_NAME` | 사용자가 {{site.data.keyword.cloudant_short_notm}} 인스턴스에 지정하는 이름입니다. 

{{site.data.keyword.cloudant_short_notm}} 서비스의 `cs20170517a` 인스턴스에 대한
인증 정보(여기서 인증 정보의 이름은 `creds_for_cs20170517a`)를 작성하려는 경우에는 다음 예와 유사한 명령을 사용하여 이러한 인증 정보를 작성할 수 있습니다.

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

## {{site.data.keyword.cloudant_short_notm}} 서비스에 대한 서비스 인증 정보 검색
{: #retrieving-the-service-credentials-for-your-ibm-cloudant-service}

{{site.data.keyword.cloud_notm}} 내의 서비스 인스턴스에 대한 인증 정보를 검색하는 기본 명령 형식은 다음과 같습니다.

```sh
ibmcloud resource service-key KEY_NAME
```
{: pre}

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

## {{site.data.keyword.cloudant_short_notm}} 서비스 인스턴스 사용
{: #using-your-ibm-cloudant-service-instance}

이제까지 다음 태스크를 완료했습니다.

1.  {{site.data.keyword.cloud_notm}} 내에
  {{site.data.keyword.cloudant_short_notm}} 서비스 인스턴스를 작성했습니다.
2.  {{site.data.keyword.cloudant_short_notm}} 서비스 인스턴스에 대한 인증 정보를 작성했습니다.
3.  애플리케이션에서 사용할 수 있도록 이 서비스 인스턴스를 검색했습니다.

자세한 정보는 레거시 인증 정보를 사용하여 Python 애플리케이션에서 {{site.data.keyword.cloudant_short_notm}} 서비스 인스턴스를 사용하는 방법을 보여주는 [{{site.data.keyword.cloud_notm}}에서 간단한 {{site.data.keyword.cloudant_short_notm}} 데이터베이스 작성 및 채우기](/docs/services/Cloudant?topic=cloudant-creating-and-populating-a-simple-ibm-cloudant-database-on-ibm-cloud#context){: new_window} 튜토리얼을 참조하십시오. 이 튜토리얼에서 작성한 인증 정보를 대체해야 한다는 점을 기억하십시오.

## (선택사항) 사후 정리 작업
{: #-optional-tidying-up-afterward}

다음의 간단한 명령 목록은 개발 환경을 정리하는 데 유용합니다.

### 서비스 인증 정보 삭제
{: #deleting-service-credentials}

서비스 인증 정보 세트를 삭제하려면
다음과 유사한 명령을 사용하십시오.

```sh
ibmcloud resource service-key-delete KEY_NAME
```
{: pre}

예를 들어,
`creds_for_cs20170517a`라는 인증 정보를 삭제하려면 다음과 같은 명령을 사용하십시오.

```sh
ibmcloud resource service-key-delete creds_for_cs20170517a
```
{: pre}

### 서비스 인스턴스 삭제
{: #deleting-a-service-instance}

서비스 인스턴스를 삭제하려면
다음과 유사한 명령을 사용하십시오.

```sh
ibmcloud resource service-instance-delete SERVICE_INSTANCE_NAME
```
{: pre}

예를 들어, For example,
{{site.data.keyword.cloudant_short_notm}} 서비스의
`cs20170517a` 인스턴스를 삭제하려면
다음과 같은 명령을 사용하십시오.

```sh
ibmcloud resource service-instance-delete cs20170517a
```
{: pre}

