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


# 在 {{site.data.keyword.cloud_notm}} 上建立及運用 {{site.data.keyword.cloudant_short_notm}} 專用硬體方案實例

本指導教學顯示如何建立使用 {{site.data.keyword.cloud}} 儀表板的「{{site.data.keyword.cloudantfull}} 專用硬體方案」實例，並顯示後續如何使用「{{site.data.keyword.cloud_notm}} 型錄」或 {{site.data.keyword.cloud_notm}} CLI，佈建一個以上的「標準方案」實例以在其上執行。 

建立「{{site.data.keyword.cloudant_short_notm}} 專用硬體方案」實例會導致在專用硬體上佈建 {{site.data.keyword.cloudant_short_notm}} 環境，以供您單獨使用。會在 {{site.data.keyword.cloud_notm}} 儀表板中建立服務實例，但您無法直接存取「專用硬體方案」實例，而且它沒有任何「服務認證」。在建立「{{site.data.keyword.cloudant_short_notm}} 專用硬體方案」實例之後，您可以透過在其上佈建一個以上「標準方案」實例來使用它。

## 建立 {{site.data.keyword.cloudant_short_notm}} 專用硬體方案實例

1.  登入 {{site.data.keyword.cloud_notm}} 帳戶。<br/>
{{site.data.keyword.cloud_notm}} 儀表板位於 [http://bluemix.net ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](http://bluemix.net){:new_window}。利用使用者名稱及密碼進行鑑別之後，您會看到 {{site.data.keyword.cloud_notm}} 儀表板：<br/>
    ![{{site.data.keyword.cloud_notm}} 儀表板](images/img0001.png)

2.  按一下`建立資源`按鈕：<br/>
    ![{{site.data.keyword.cloud_notm}} 建立資源按鈕](images/img0002.png)<br/>
    
3.  查看可用的 {{site.data.keyword.cloud_notm}} 型錄及服務。按一下`資料庫`種類。
    ![{{site.data.keyword.cloud_notm}} 型錄](images/img0000.png)

4.  按一下 {{site.data.keyword.cloudant_short_notm}} 服務：<br/>
    ![{{site.data.keyword.cloud_notm}} {{site.data.keyword.cloudant_short_notm}} 服務選項](images/img0003.png)<br/>
    即會出現建立服務的頁面。

5.  從頁面底端的定價方案清單中，選取`專用硬體`方案。<br/>
    ![定價方案](../tutorials/images/pricing_plan.png)
    
6.  在頁面頂端，填寫下列參數：<br/>
    -   輸入服務名稱。<br/>
    -   指定您要在其中部署的地區/位置。<br/>
    -   選取資源群組。</br>
    -   選取進行部署的位置。<br/>
    -   選取`是`或`否`，以回答是否需要 HIPAA。<br/>
   
    HIPAA 僅適用於美國位置。{{site.data.keyword.IBM}} 可以佈建「專用」或「裸機」叢集來實作 HIPAA 控制項。只有在確認與 {{site.data.keyword.IBM_notm}} 建立的「商業關聯合約 (BAA)」後，才會佈建叢集。本合約載明於「服務說明」條款。佈建叢集來管理 HIPAA 資料所花費的時間可能會超出 5 天的預估期間。
    {: tip}
    
    您會在相同的地區及空間中部署及佈建「標準方案」實例。
    {: tip}

    ![配置專用硬體](../tutorials/images/select_deployment_location.png)
        
7.  按一下`建立`按鈕，以啟動佈建處理程序。<br/>

    計費是每日按比例分配，因此請先確定您要佈建並支付環境費用，然後再按一下**建立**按鈕。
    {: tip}

    ![佈建專用硬體](../tutorials/images/create_button_provision.png)

    在佈建期間，{{site.data.keyword.cloud_notm}} 儀表板中的實例旁邊會出現一個紡車。會傳送要求，以在裸機伺服器上佈建「專用硬體方案」實例。佈建時間為非同步，而且可能需要多達 5 天。
    {: tip}   

    ![佈建專用硬體替代版本](../tutorials/images/create_button_provision2.png)
    
## 在專用硬體環境上佈建標準方案實例

1.  登入 {{site.data.keyword.cloud_notm}} 帳戶。<br/>
{{site.data.keyword.cloud_notm}} 儀表板位於 [http://bluemix.net ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](http://bluemix.net){:new_window}。利用使用者名稱及密碼進行鑑別之後，您會看到 {{site.data.keyword.cloud_notm}} 儀表板：<br/>
    ![{{site.data.keyword.cloud_notm}} 儀表板](images/img0001.png)

2.  按一下`建立資源`按鈕：<br/>
    ![{{site.data.keyword.cloud_notm}} 建立資源](images/img0002.png)<br/>
即會出現 {{site.data.keyword.cloud_notm}} 上可用的服務清單。

3.  按一下`資料庫`種類，然後選取 `Cloudant` 服務：<br/>
    ![{{site.data.keyword.cloud_notm}} {{site.data.keyword.cloudant_short_notm}} 服務選項](images/img0003.png)</br>
    即會出現建立服務的頁面。<br/>  

4.  從定價方案中，按一下`標準`。<br/>
    ![標準定價方案](../tutorials/images/standard_pricing_plan.png)
    
    您無法在「專用硬體」環境上佈建「精簡方案」實例。
    {: tip}
    
5.  填寫下列參數：<br/>
    -   輸入服務名稱。<br/>
    -   指定您要在其中部署的地區/位置。<br/>
    -   選取資源群組。</br>
    -   選取鑑別方法。</br>
    -   選取環境。</br>
    ![配置標準實例](../tutorials/images/select_environment.png)
    
6.  按一下`建立`按鈕。<br/>
    幾秒之後，就會在您選取的環境上佈建實例。<br/>
    ![佈建標準實例](../tutorials/images/create_button_provision_standard.png)
    
7.  比照對多方承租戶 {{site.data.keyword.cloudant_short_notm}} 實例的作法，取得「服務認證」，並存取「{{site.data.keyword.cloudant_short_notm}} 儀表板」。 
    
    如需相關資訊，請參閱[如何尋找服務認證](../tutorials/create_service.html#locating-your-service-credentials){:new_window}。 
    
## 使用 {{site.data.keyword.cloud_notm}} CLI 在專用硬體環境上佈建標準方案實例

若要使用 {{site.data.keyword.cloud_notm}} CLI，您必須登入。如需如何登入並設定目標資源群組的相關資訊，請參閱[登入 {{site.data.keyword.cloud_notm}} 帳戶](create_service_cli.html#logging-in-to-your-ibm-cloud-account){:new_window}。 

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

「專用硬體」環境上部署的 {{site.data.keyword.cloudant_short_notm}} 實例，接受另外兩個參數：

參數 | 說明
----------|------------
`environment_crn` | 此參數必須設為「{{site.data.keyword.cloudant_short_notm}} 專用硬體方案」實例的 CRN。您可以在「{{site.data.keyword.cloud_notm}} 儀表板」之「{{site.data.keyword.cloudant_short_notm}} 專用硬體方案」實例的「管理」標籤中查看範例 CLI 指令，以確定 CRN 為何。或者，您可以使用 `ibmcloud resource service-instance SERVICE_INSTANCE_NAME` 指令以確定 CRN 為何。
`legacyCredentials` |選用性的參數，其預設為 true 並指出實例同時使用 Legacy 及 IAM 認證還是僅使用 IAM 認證。如需選擇鑑別方法的詳細資料，請參閱 [IAM 手冊 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](../guides/iam.html#ibm-cloud-identity-and-access-management-iam-){:new_window}。

請參閱下列範例指令： 

```sh
ibmcloud resource service-instance-create cloudant_on_ded_hardware_cli cloudantnosqldb standard us-south -p '{"environment_crn":"crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b43434444bb7e2abb0841ca25d28ee4c:301a3118-7678-4d99-b1b7-4d45cf5f7b29::","legacyCredentials":false}'
```
     
