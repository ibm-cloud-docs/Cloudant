---

copyright:
  years: 2015, 2018
lastupdated: "2017-11-07"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-02-23 -->

# 在 {{site.data.keyword.Bluemix_notm}} 上建立及運用 {{site.data.keyword.cloudant_short_notm}} 專用硬體方案實例

本指導教學示範如何使用 {{site.data.keyword.Bluemix}} 儀表板來建立「{{site.data.keyword.cloudantfull}} 專用硬體方案」實例，並示範後續如何佈建一個以上的「標準方案」實例以在其上執行。 

建立「{{site.data.keyword.cloudant_short_notm}} 專用硬體方案」實例會導致在專用硬體上佈建 {{site.data.keyword.cloudant_short_notm}} 環境，以供您單獨使用。會在 {{site.data.keyword.Bluemix_notm}} 儀表板中建立服務實例，但請注意，您無法直接存取「專用硬體方案」實例，而且它沒有任何「服務認證」。在建立 {{site.data.keyword.cloudant_short_notm}}「專用硬體方案」實例之後，您可以透過在其中佈建一個以上「標準方案」實例來使用它。

## 建立 {{site.data.keyword.cloudant_short_notm}} 專用硬體方案實例

1.  登入 {{site.data.keyword.Bluemix_notm}} 帳戶。<br/>
    您可以在 [http://bluemix.net ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](http://bluemix.net){:new_window} 找到 {{site.data.keyword.Bluemix_notm}} 儀表板。利用使用者名稱及密碼進行鑑別之後，您會看到 {{site.data.keyword.Bluemix_notm}} 儀表板：<br/>
    ![{{site.data.keyword.Bluemix_notm}} 儀表板](images/img0001.png)

2.  按一下`型錄`鏈結：<br/>
    ![{{site.data.keyword.Bluemix_notm}} 型錄鏈結](images/img0002.png)<br/>
    即會出現 {{site.data.keyword.Bluemix_notm}} 上可用的服務清單。

3.  按一下`服務`標題下方的`資料及分析`項目：<br/>
    ![{{site.data.keyword.Bluemix_notm}} 資料及分析服務](images/img0003.png)<br/>
    即會出現 {{site.data.keyword.Bluemix_notm}} 上可用的「資料及分析」服務清單。

4.  按一下 {{site.data.keyword.cloudant_short_notm}} 服務：<br/>
    ![{{site.data.keyword.Bluemix_notm}} {{site.data.keyword.cloudant_short_notm}} 服務選項](images/img0004.png)<br/>
    即會出現建立服務的頁面。 

5.  從頁面底端的定價方案清單中，選取`專用硬體`方案：<br/>
    ![定價方案](../tutorials/images/pricing_plan.png)
    
6.  在頁面頂端，填寫下列參數：<br/>
    -   輸入「服務名稱」。<br/>
    -   指定要部署的地區及空間。<br/>
    -   選取進行部署的位置。<br/>
    -   對是否需要 HIPAA 的問題，回答「是」或「否」。請注意，HIPAA 僅適用於美國的位置。<br/> 
     
    **附註**：您會在相同的地區及空間中部署及佈建「標準方案」實例。    
    ![配置專用硬體](../tutorials/images/select_deployment_location.png)<br/>
    請開始佈建處理程序。 
    
7.  按一下頁面底端的`建立`按鈕，以開始佈建。<br/>
    **附註**：計費是每日按比例分配，因此請確定您想要佈建並支付環境費用，然後才按一下**建立**按鈕。<br/>
    ![佈建專用硬體](../tutorials/images/create_button_provision.png)<br/>
    **附註**：在佈建期間，{{site.data.keyword.Bluemix_notm}} 儀表板中的實例旁邊會出現一個紡車。會傳送要求，以在裸機伺服器上佈建「專用硬體方案」實例。佈建時間是非同步的，而且最多需要 5 天。
    ![佈建專用硬體替代版本](../tutorials/images/create_button_provision2.png)<br/>
    
## 在專用硬體環境上佈建標準方案實例

1.  登入 {{site.data.keyword.Bluemix_notm}} 帳戶。<br/>
    您可以在 [http://bluemix.net ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](http://bluemix.net){:new_window} 找到 {{site.data.keyword.Bluemix_notm}} 儀表板。利用使用者名稱及密碼進行鑑別之後，您會看到 {{site.data.keyword.Bluemix_notm}} 儀表板：<br/>
    ![{{site.data.keyword.Bluemix_notm}} 儀表板](images/img0001.png)

2.  按一下`型錄`鏈結：<br/>
    ![{{site.data.keyword.Bluemix_notm}} 型錄鏈結](images/img0002.png)<br/>
    即會出現 {{site.data.keyword.Bluemix_notm}} 上可用的服務清單。

3.  按一下`服務`標題下方的`資料及分析`項目：<br/>
    ![{{site.data.keyword.Bluemix_notm}} 資料及分析服務](images/img0003.png)<br/>
    即會出現 {{site.data.keyword.Bluemix_notm}} 上可用的「資料及分析」服務清單。

4.  按一下 {{site.data.keyword.cloudant_short_notm}} 服務：<br>
    ![{{site.data.keyword.Bluemix_notm}} {{site.data.keyword.cloudant_short_notm}} 服務選項](images/img0004.png)<br/>
    即會出現建立服務的頁面。  

5.  從頁面底端的定價方案中，按一下`標準`。<br/>
    **附註**：您無法在「專用硬體」環境上佈建「精簡方案」實例。<br/>
    ![標準定價方案](../tutorials/images/standard_pricing_plan.png)
    
6.  比照對「標準方案」實例的作法，輸入「服務名稱」、「認證名稱」等等，在頁面頂端填寫參數。使用`選取環境`下拉清單，決定是要佈建於預設地區多方承租戶環境，還是佈建在您已佈建的「專用硬體」環境。<br/>
    ![配置標準實例](../tutorials/images/select_environment.png)
    
7.  按一下頁面底端的`建立`按鈕。<br/>
    幾秒之後，就會在您選取的環境上佈建實例。<br/>
    ![佈建標準實例](../tutorials/images/create_button_provision_standard.png)
    
8.  比照對多方承租戶 {{site.data.keyword.cloudant_short_notm}} 實例的作法，取得「服務認證」，並存取「{{site.data.keyword.cloudant_short_notm}} 儀表板」。如需如何尋找「服務認證」的相關資訊，請參閱[這裡 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://console.bluemix.net/docs/services/Cloudant/tutorials/create_service.html#locating-your-service-credentials){:new_window}。 
     
