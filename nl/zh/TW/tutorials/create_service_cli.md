---

copyright:
  years: 2017, 2019
lastupdated: "2019-06-12"

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

# 使用 {{site.data.keyword.cloud_notm}} CLI 在 {{site.data.keyword.cloud_notm}} 上建立 {{site.data.keyword.cloudant_short_notm}} 實例
{: #creating-an-ibm-cloudant-instance-on-ibm-cloud-by-using-the-ibm-cloud-cli}

本指導教學顯示如何使用 {{site.data.keyword.cloud_notm}} CLI 在 {{site.data.keyword.cloud}} 上建立 {{site.data.keyword.cloudantfull}} 服務實例。
{: shortdesc}

## 開始本指導教學之前 
{: #before-you-start-this-tutorial}

若要遵循本指導教學，您必須先安裝 {{site.data.keyword.cloud_notm}} CLI 開發人員工具。如需安裝工具的相關資訊，請參閱[開始使用 {{site.data.keyword.cloud_notm}} CLI ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://cloud.ibm.com/docs/cli?topic=cloud-cli-ibmcloud-cli#overview){: new_window} 指導教學。

## 識別 {{site.data.keyword.cloud_notm}} API 端點
{: #identifying-the-ibm-cloud-api-endpoint}

指定 {{site.data.keyword.cloud_notm}} 指令的目標 API 端點：

```sh
ibmcloud api https://api.ng.bluemix.net
```
{: codeblock}

結果確認您已正確地識別端點：

```sh
Setting api endpoint to https://api.ng.bluemix.net...
OK

API endpoint: https://api.ng.bluemix.net (API version: 2.54.0)
Not logged in. Use 'ibmcloud login' to log in.
```
{: pre}

## 登入 {{site.data.keyword.cloud_notm}} 帳戶
{: #logging-in-to-your-ibm-cloud-account}

下列範例說明登入處理程序。如果您使用聯合使用者 ID，請務必切換至一次性密碼 (`ibmcloud login --sso`)，或使用 API 金鑰（`ibmcloud --apikey key 或 @key_file`）進行鑑別。如需如何使用 CLI 登入的相關資訊，請參閱[一般 CLI (ibmcloud) 指令 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://cloud.ibm.com/docs/cli/reference/ibmcloud?topic=cloud-cli-ibmcloud_cli#ibmcloud_login){: new_window} 下的 `ibmcloud login`。 

1.  使用下列指令，以開始 {{site.data.keyword.cloud_notm}} 帳戶的登入處理程序：
  
  ```sh
  ibmcloud login
  ```
  {: codeblock}
  
  {{site.data.keyword.cloud_notm}} 的回應方式是提醒您現行的 API 端點，然後要求輸入您帳戶的電子郵件位址：
  
  ```sh
  API endpoint: https://api.ng.bluemix.net
  
  Email>
  ```
  {: pre}

2.  輸入您帳戶的電子郵件位址，然後輸入密碼：

  ```sh
  API endpoint: https://api.ng.bluemix.net
  
  Email> J.Doe@email.com
  
  Password>
  ```
  {: pre}
  
  {{site.data.keyword.cloud_notm}} 會驗證您的詳細資料，並彙總您的登入階段作業相關資訊：

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

3.  您現在已登入 {{site.data.keyword.cloud_notm}} 帳戶。

## 選擇服務的 {{site.data.keyword.cloudant_short_notm}} 方案
{: #choosing-the-ibm-cloudant-plan-for-your-service}

如需使用 {{site.data.keyword.cloudant_short_notm}} 精簡方案或標準方案的詳細資料，請參閱本文件的[方案](/docs/services/Cloudant?topic=cloudant-ibm-cloud-public#plans)區段。
{: pre}

## 建立 {{site.data.keyword.cloudant_short_notm}} 服務
{: #creating-the-ibm-cloudant-service}

{{site.data.keyword.cloudant_short_notm}} 使用資源群組（而不是 Cloud Foundry 組織和空間）來佈建新實例。過去佈建的 {{site.data.keyword.cloudant_short_notm}} 實例仍然可以部署在 Cloud Foundry 組織及空間。如需相關資訊，請參閱 [{{site.data.keyword.cloudant_short_notm}} 如何使用 {{site.data.keyword.cloud_notm}} 資源群組？![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](/docs/services/Cloudant?topic=cloudant-how-does-ibm-cloudant-work-with-ibm-cloud-resource-groups-#how-does-ibm-cloudant-work-with-ibm-cloud-resource-groups-){: new_window} 手冊。

首先，如[一般 CLI (ibmcloud) 指令 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://cloud.ibm.com/docs/cli/reference/ibmcloud?topic=cloud-cli-ibmcloud_cli#ibmcloud_target){: new_window} 中 `ibmcloud target` 下的內容所示，使用下列格式設定目標資源群組和地區：

```sh
ibmcloud target [-r REGION_NAME] [-g RESOURCE_GROUP]
```

如需地區清單，請執行下列指令：

```sh
ibmcloud regions
```

如需資源群組清單，請執行下列指令： 

```sh
ibmcloud resource groups
```

其次，若要建立服務實例，{{site.data.keyword.cloud_notm}} 內的基本指令格式如下：

```sh
ibmcloud resource service-instance-create NAME SERVICE_NAME|SERVICE_ID SERVICE_PLAN_NAME|SERVICE_PLAN_ID LOCATION [-p, --parameters @JSON_FILE | JSON_STRING ]
```
{: pre}

下表說明這些欄位： 


欄位       | 說明
------|------------
`NAME` | 您提供給實例的任意名稱。
`SERVICE_NAME` | `cloudantnosqldb`
`PLAN_NAME` |「精簡方案」或「標準方案」。
`LOCATION` |您要在其中部署的位置：「亞太地區北部」、「德國」、「全球」、「雪梨」、「英國」、「美國東部」或「美國南部」。
`legacyCredentials` | 預設為 true。此欄位指出實例同時使用舊式及 IAM 認證還是僅使用 IAM 認證。

如需選擇鑑別方法的相關資訊，請參閱 [IAM 手冊](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-){: new_window}。{{site.data.keyword.cloudant_short_notm}} 團隊建議您儘可能對 {{site.data.keyword.cloudant_short_notm}} 舊式鑑別使用 IAM 存取控制。
{: important}

在此範例中，我們要使用 `Lite` 方案來建立 {{site.data.keyword.cloudant_short_notm}} 服務實例（其中，美國南部位置中的實例名稱是 `cs20170517a`，而且僅使用 IAM 認證），您可以使用與下列範例類似的指令來建立此實例：

```sh
ibmcloud resource service-instance-create cs20170517a cloudantnosqldb lite us-south -p '{"legacyCredentials": false}'
```
{: codeblock}

建立服務實例之後，{{site.data.keyword.cloud_notm}} 會回應與下列範例類似的訊息：

```sh
Creating service instance cs20170517a in resource group default of account John Does's Account as j.doe@email.com...
OK
Service instance cs20170517a was created.
Name          Location   State    Type               Tags   
cs20170517a   us-south   active   service_instance  
```
{: pre}

## 建立 {{site.data.keyword.cloudant_short_notm}} 服務的認證
{: #creating-credentials-for-your-ibm-cloudant-service}

需要存取 {{site.data.keyword.cloudant_short_notm}} 服務的應用程式，必須具有必要的認證。

服務認證很重要。如果有任何人或任何應用程式可以存取認證，他們/它們實際上可以對服務實例執行想要的一切作業。例如，他們/它們可能會建立偽造資料，或刪除很重要的資訊。請小心地保護這些認證。

{: important}

如需服務認證中所含欄位的相關資訊，請參閱 [IAM 手冊](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-){: new_window}。

在 {{site.data.keyword.cloud_notm}} 內建立服務實例的認證的基本指令格式如下：

```sh
ibmcloud resource service-key-create NAME ROLE_NAME --instance-name SERVICE_INSTANCE_NAME
```
{: pre}

下表說明這些欄位：

欄位       | 說明
------|------------
`NAME` | 您提供服務認證的任意名稱。
`ROLE_NAME` |此欄位目前僅容許 Manager 角色。
`SERVICE_INSTANCE_NAME` | 您提供給 {{site.data.keyword.cloudant_short_notm}} 實例的名稱。

如果您要建立 {{site.data.keyword.cloudant_short_notm}} 服務之 `cs20170517a` 實例的認證（認證的名稱是 `creds_for_cs20170517a`），則可以使用與下列範例類似的指令來建立這些認證：

```sh
ibmcloud resource service-key-create creds_for_cs20170517a Manager --instance-name cs20170517a
```
{: codeblock}

收到建立服務實例認證的要求之後，{{site.data.keyword.cloud_notm}} 會回應與下列範例類似的訊息：

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

## 擷取 {{site.data.keyword.cloudant_short_notm}} 服務的服務認證
{: #retrieving-the-service-credentials-for-your-ibm-cloudant-service}

在 {{site.data.keyword.cloud_notm}} 內擷取服務實例認證的基本指令格式如下：

```sh
ibmcloud resource service-key KEY_NAME
```
{: pre}

在此範例中，我們要擷取 {{site.data.keyword.cloudant_short_notm}} 服務之 `cs20170517a` 實例的認證（認證的名稱是 `creds_for_cs20170517a`），您可以使用與下列範例類似的指令來擷取認證：

```sh
ibmcloud resource service-key creds_for_cs20170517b
```
{: codeblock}

收到擷取服務實例認證的要求之後，{{site.data.keyword.cloud_notm}} 會回應與下列（縮短的）範例類似的訊息：

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

## 使用 {{site.data.keyword.cloudant_short_notm}} 服務實例
{: #using-your-ibm-cloudant-service-instance}

現在，您已完成下列作業：

1.  已在 {{site.data.keyword.cloud_notm}} 內建立 {{site.data.keyword.cloudant_short_notm}} 服務實例。
2.  已建立 {{site.data.keyword.cloudant_short_notm}} 服務實例的認證。
3.  已擷取服務實例認證，因此應用程式可以使用它們。

如需相關資訊，請參閱[在 {{site.data.keyword.cloud_notm}} 上建立簡單的 {{site.data.keyword.cloudant_short_notm}} 資料庫並將資料移入其中](/docs/services/Cloudant?topic=cloudant-creating-and-populating-a-simple-ibm-cloudant-database-on-ibm-cloud#context){: new_window}指導教學，而此指導教學顯示如何使用舊式認證從 Python 應用程式使用 {{site.data.keyword.cloudant_short_notm}} 服務實例。請記得替換您已在本指導教學中建立的認證。

## （選用）後續整理
{: #-optional-tidying-up-afterward}

下列簡短指令清單可能對您整理開發環境很實用。

### 刪除服務認證
{: #deleting-service-credentials}

若要刪除一組服務認證，請使用與下列類似的指令：

```sh
ibmcloud resource service-key-delete KEY_NAME
```
{: pre}

例如，若要刪除稱為 `creds_for_cs20170517a` 的認證，請使用與下列類似的指令：

```sh
ibmcloud resource service-key-delete creds_for_cs20170517a
```
{: pre}

### 刪除服務實例
{: #deleting-a-service-instance}

若要刪除服務實例，請使用與下列類似的指令：

```sh
ibmcloud resource service-instance-delete SERVICE_INSTANCE_NAME
```
{: pre}

例如，若要刪除 {{site.data.keyword.cloudant_short_notm}} 服務的 `cs20170517a` 實例，請使用與下列類似的指令：

```sh
ibmcloud resource service-instance-delete cs20170517a
```
{: pre}

