---

copyright:
  years: 2015, 2019
lastupdated: "2019-04-02"

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

# 在 {{site.data.keyword.cloud_notm}} 上建立及運用 {{site.data.keyword.cloudant_short_notm}} 專用硬體方案實例
{: #creating-and-leveraging-an-ibm-cloudant-dedicated-hardware-plan-instance-on-ibm-cloud}

本指導教學顯示如何建立使用 {{site.data.keyword.cloud}} 儀表板的「{{site.data.keyword.cloudantfull}} 專用硬體方案」實例，並顯示後續如何使用「{{site.data.keyword.cloud_notm}} 型錄」或 {{site.data.keyword.cloud_notm}} CLI，佈建一個以上的「標準方案」實例以在其上執行。
{: shortdesc}

建立「{{site.data.keyword.cloudant_short_notm}} 專用硬體方案」實例會導致在專用硬體上佈建 {{site.data.keyword.cloudant_short_notm}} 環境，以供您單獨使用。會在 {{site.data.keyword.cloud_notm}} 儀表板中建立服務實例，但您無法直接存取「專用硬體方案」實例，而且它沒有任何「服務認證」。在建立「{{site.data.keyword.cloudant_short_notm}} 專用硬體方案」實例之後，您可以透過在其上佈建一個以上「標準方案」實例來使用它。

## 建立 {{site.data.keyword.cloudant_short_notm}} 專用硬體方案實例
{: #creating-an-ibm-cloudant-dedicated-hardware-plan-instance}

1.  登入 {{site.data.keyword.cloud_notm}} 帳戶。<br/>
    {{site.data.keyword.cloud_notm}} 儀表板位於：[`https://cloud.ibm.com/ ` ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://cloud.ibm.com/){: new_window}。利用使用者名稱及密碼進行鑑別之後，您會看到 {{site.data.keyword.cloud_notm}} 儀表板。按一下`建立資源`按鈕：<br/>
    ![{{site.data.keyword.cloud_notm}} 儀表板](images/img0001.png)

2.  從左側功能表中按一下`資料庫`，然後從資料庫服務的清單中按一下 `Cloudant`。<br/>
     ![{{site.data.keyword.cloud_notm}} {{site.data.keyword.cloudant_short_notm}} 服務選項](images/img0003.png)<br/>

3.  從頁面底端的定價方案清單中，選取`專用硬體`方案。<br/>
    ![定價方案](/docs/services/Cloudant/tutorials/images/pricing_plan.png)
    
4.  在頁面頂端，填寫下列參數：<br/>
    -   輸入服務名稱。<br/>
    -   指定您要在其中部署的地區/位置。<br/>
    -   選取資源群組。</br>
    -   新增標籤。 
    -   選取進行部署的位置。<br/>
    -   選取`是`或`否`，以回答是否需要 HIPAA。<br/> 
    
    HIPAA 僅適用於美國位置。{{site.data.keyword.IBM}} 可以佈建「專用硬體方案」環境來實作 HIPAA 控制項。只有在確認與 {{site.data.keyword.IBM_notm}} 建立的「事業夥伴合約 (BAA)」後，才會佈建環境。如需詳細資料，請參閱[啟用 HIPAA 支援的設定](https://cloud.ibm.com/docs/account/eu_hipaa_supported.html#enabling-the-hipaa-supported-setting)及「服務說明」條款。佈建叢集來管理 HIPAA 資料所花費的時間可能會超出 5 天的預估期間。
    {: note}

    ![配置專用硬體](/docs/services/Cloudant/tutorials/images/select_deployment_location.png)
        
5.  按一下`建立`按鈕，以啟動佈建處理程序。<br/>

    計費是每日按比例分配，因此請先確定您要佈建並支付環境費用，然後再按一下**建立**按鈕。
    {: note}

    ![佈建專用硬體](/docs/services/Cloudant/tutorials/images/create_button_provision.png)

    在佈建期間，{{site.data.keyword.cloud_notm}} 儀表板中的實例旁邊會出現一個紡車。會傳送要求，以在裸機伺服器上佈建「專用硬體方案」實例。佈建時間為非同步，而且可能需要多達 5 天。
    {: note}   

    ![佈建專用硬體替代版本](/docs/services/Cloudant/tutorials/images/create_button_provision2.png)
    
## 在專用硬體環境上佈建標準方案實例
{: #provisioning-a-standard-plan-instance-on-a-dedicated-hardware-environment}

1.  登入 {{site.data.keyword.cloud_notm}} 帳戶。<br/>
    {{site.data.keyword.cloud_notm}} 儀表板位於：[https://cloud.ibm.com/ ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://cloud.ibm.com/){: new_window}。利用使用者名稱及密碼進行鑑別之後，您會看到 {{site.data.keyword.cloud_notm}} 儀表板。按一下`建立資源`按鈕：<br/>
    ![{{site.data.keyword.cloud_notm}} 儀表板](images/img0001.png)

2.  從左側功能表中按一下`資料庫`，然後從資料庫服務的清單中按一下 `Cloudant`。<br/>
     ![{{site.data.keyword.cloud_notm}} {{site.data.keyword.cloudant_short_notm}} 服務選項](images/img0003.png)<br/>
    即會出現建立服務的頁面。<br/>  

3.  從定價方案中，按一下`標準`。<br/>
    ![標準定價方案](/docs/services/Cloudant/tutorials/images/standard_pricing_plan.png)
    
    您無法在「專用硬體」環境上佈建「精簡方案」實例。
    {: tip}
    
4.  填寫下列參數：<br/>
    -   輸入服務名稱。<br/>
    -   指定您要在其中部署的地區/位置。<br/>
    -   選取資源群組。</br>
    -   新增標籤。 
    -   選取鑑別方法。</br>
    -   選取環境。</br>
    ![配置標準實例](/docs/services/Cloudant/tutorials/images/select_environment.png)
    
5.  按一下`建立`按鈕。<br/>
    幾秒之後，就會在您選取的環境上佈建實例。<br/>
    ![佈建標準實例](/docs/services/Cloudant/tutorials/images/create_button_provision_standard.png)
    
6.  比照對多方承租戶 {{site.data.keyword.cloudant_short_notm}} 實例的作法，取得「服務認證」，並存取「{{site.data.keyword.cloudant_short_notm}} 儀表板」。 
    
    如需相關資訊，請參閱[如何尋找服務認證](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud#locating-your-service-credentials){: new_window}。 
    
## 使用 {{site.data.keyword.cloud_notm}} CLI 在專用硬體環境上佈建標準方案實例
{: #provisioning-a-standard-plan-instance-on-a-dedicated-hardware-environment-with-the-ibm-cloud-cli}

若要使用 {{site.data.keyword.cloud_notm}} CLI，您必須登入。如需如何登入並設定目標資源群組的相關資訊，請參閱[登入 {{site.data.keyword.cloud_notm}} 帳戶](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud-by-using-the-ibm-cloud-cli#logging-in-to-your-ibm-cloud-account){: new_window}。 

若要在「{{site.data.keyword.cloudant_short_notm}} 專用硬體方案」環境上建立「{{site.data.keyword.cloudant_short_notm}} 標準方案」實例，基本指令格式如下：


欄位            | 說明
------|------------
`NAME`| 您指派給實例的任意名稱。
`SERVICE_NAME` | `cloudantnosqldb`
`PLAN_NAME` |標準方案
`LOCATION` |您要在其中部署的位置（例如，us-south、us-east 或 eu-gb）。

請參閱下列範例指令： 

```sh
ibmcloud resource service-instance-create NAME SERVICE_NAME SERVICE_PLAN_NAME LOCATION [-p, --parameters @JSON_FILE | JSON_STRING ]
```
{: codeblock}

「專用硬體」環境上部署的 {{site.data.keyword.cloudant_short_notm}} 實例，接受另外兩個參數：

參數 | 說明
----------|------------
`environment_crn` | 此參數必須設為「{{site.data.keyword.cloudant_short_notm}} 專用硬體方案」實例的 CRN。您可以在「{{site.data.keyword.cloud_notm}} 儀表板」之「{{site.data.keyword.cloudant_short_notm}} 專用硬體方案」實例的「管理」標籤中查看範例 CLI 指令，以確定 CRN 為何。或者，您可以使用 `ibmcloud resource service-instance SERVICE_INSTANCE_NAME` 指令以確定 CRN 為何。
`legacyCredentials` |選用性的參數，其預設為 true 並指出實例同時使用 Legacy 及 IAM 認證還是僅使用 IAM 認證。如需選擇鑑別方法的詳細資料，請參閱 [IAM 手冊 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-){: new_window}。

請參閱下列範例指令： 

```sh
ibmcloud resource service-instance-create cloudant_on_ded_hardware_cli cloudantnosqldb standard us-south -p '{"environment_crn":"crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b43434444bb7e2abb0841ca25d28ee4c:301a3118-7678-4d99-b1b7-4d45cf5f7b29::","legacyCredentials":false}'
```
{: codeblock}

## 為您的 {{site.data.keyword.cloudant_short_notm}} 服務建立認證
{: #creating-the-credentials-for-your-ibm-cloudant-service}

需要存取 {{site.data.keyword.cloudant_short_notm}} 服務的應用程式，必須具有必要的認證。

服務認證很重要。如果有任何人或任何應用程式可以存取認證，他們/它們實際上可以對服務實例執行想要的一切作業。例如，他們/它們可能會建立偽造資料，或刪除很重要的資訊。請小心地保護這些認證。
{: important}

如需服務認證中所含欄位的相關資訊，請參閱 [IAM 手冊 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-){: new_window}。

在 {{site.data.keyword.cloud_notm}} 內建立服務實例的認證的基本指令格式如下：

```sh
ibmcloud resource service-key-create NAME ROLE_NAME --instance-name SERVICE_INSTANCE_NAME [--enable-internal-service-endpoint true]
```
{: pre}

下表說明這些欄位：

欄位            | 說明
------|------------
`NAME` | 您提供服務認證的任意名稱。
`ROLE_NAME` |此欄位目前僅容許 Manager 角色。
`SERVICE_INSTANCE_NAME` | 您提供給 {{site.data.keyword.cloudant_short_notm}} 實例的名稱。
`enable-internal-service-endpoint` | 此選用欄位會將內部端點移入「服務認證」中的 url 欄位，以透過 {{site.data.keyword.cloud_notm}} 內部網路連接至服務。請省略此欄位，以將可公開存取的外部端點移入 url。只適用於已在支援內部端點之「專用硬體」環境上部署的「標準方案」實例。如果此環境不支援內部端點，則指令將產生 400 錯誤。

如果您想要為 {{site.data.keyword.cloudant_short_notm}} 服務的 `cs20170517a` 實例建立認證（認證的名稱是 `creds_for_cs20170517a`），則可以使用與下列範例類似的指令來建立這些認證：

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

如果您想要為 {{site.data.keyword.cloudant_short_notm}} 服務的 `cs20170517a` 實例建立認證（認證的名稱是 `creds_for_cs20170517a`），而且想要將內部端點移入 url，則可以使用與下列範例類似的指令來建立這些認證：

```sh
ibmcloud resource service-key-create creds_for_cs20170517a Manager --instance-name cs20170517a --enable-internal-service-endpoint true
```
{: codeblock}

收到建立服務實例認證的要求之後，{{site.data.keyword.cloud_notm}} 會回應與下列範例類似的訊息：

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

## 列出 {{site.data.keyword.cloudant_short_notm}} 服務的服務認證
{: #listing-the-service-credentials-for-your-ibm-cloudant-service}

在 {{site.data.keyword.cloud_notm}} 內擷取服務實例認證的基本指令格式如下：

```sh
ibmcloud resource service-key KEY_NAME
```
{: codeblock}

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
