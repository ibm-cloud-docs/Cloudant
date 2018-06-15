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

# 在 {{site.data.keyword.Bluemix_notm}} 上建立 {{site.data.keyword.cloudant_short_notm}} 實例

本指導教學示範如何使用 {{site.data.keyword.Bluemix}} 儀表板來建立 {{site.data.keyword.cloudantfull}} 服務實例，並示範哪裏可以找到讓應用程式使用資料庫的必要資訊。
{:shortdesc}

若要存取 {{site.data.keyword.cloudant_short_notm}} 服務實例，您需要一組[服務認證](#the-service-credentials)。認證會在您建立服務實例的過程中產生。

您也可以存取 {{site.data.keyword.cloudant_short_notm}} 帳戶，隨時找到這些認證。

## 建立服務實例

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
    ![{{site.data.keyword.Bluemix_notm}} {{site.data.keyword.cloudant_short_notm}} 服務選項](images/img0004.png)

5.  在服務配置視窗中，輸入服務名稱。在此範例中，服務名稱是 `Cloudant Service 2017`：<br/>
    ![{{site.data.keyword.cloudant_short_notm}} 服務名稱及認證](images/img0005.png)

6.  依預設，會使用「精簡」定價方案來建立服務，此方案是免費的，但提供的容量有限。我們另外[提供](../offerings/bluemix.html)了容量較大的其他定價方案。<br/>
    若要建立服務，請按一下`建立`按鈕：<br/>
    ![建立 {{site.data.keyword.cloudant_short_notm}} 服務名稱及認證](images/img0006.png)

7.  即會出現服務頁面，以確認您的新 {{site.data.keyword.cloudant_short_notm}} 服務可用。若要存取您的應用程式連接至服務所需的連線資訊，請按一下`服務認證`標籤：<br/>
    ![存取 {{site.data.keyword.cloudant_short_notm}} 服務認證](images/img0007.png)

8.  即會出現「服務認證」視窗。若要查看存取服務所需的認證，請按一下`檢視認證`下拉清單：<br/>
    ![檢視 {{site.data.keyword.cloudant_short_notm}} 服務認證](images/img0008.png)

9.  即會出現「服務認證」詳細資料：<br/>
    ![{{site.data.keyword.cloudant_short_notm}} 服務認證](images/img0009.png)

>   **附註**：這些範例中的服務認證
    是在 {{site.data.keyword.cloudant_short_notm}} 上建立示範 {{site.data.keyword.cloudant_short_notm}} 服務時定義的。
    我們在這裡重新產生認證，是要示範它們在儀表板中的顯示方式。不過，已移除示範 {{site.data.keyword.cloudant_short_notm}} 服務，因此這些認證不再有效；您_必須_ 提供及使用自己的服務認證。

## 服務認證

>   **附註**：服務認證很重要。
如果有任何人或任何應用程式可以存取認證，實際上就可以利用服務實例執行想要的一切作業，例如，他們/它們可能會建立偽造資料，或刪除寶貴的資訊。請小心地保護這些認證。



服務認證包含五個欄位：

欄位       | 用途
-----------|--------
`host`     | 應用程式用來尋找服務實例的主機名稱。
`username` | 應用程式存取服務實例所需的使用者名稱。
`password` | 應用程式存取服務實例所需的密碼。
`port`     | 用來存取主機上服務實例的 HTTP 埠號。一般是 443，可強制執行 HTTPS 存取。
`url`      | 將其他認證資訊聚集成單一 URL 的字串，適合供應用程式使用。

若要建立可存取服務實例的應用程式，您需要這些認證。

## 找到服務認證

您隨時可以找到與您帳戶相關聯之服務的認證。

1.  首先，登入 {{site.data.keyword.cloudant_short_notm}}。您可以在 [http://bluemix.net ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](http://bluemix.net){:new_window} 找到 {{site.data.keyword.Bluemix}} 儀表板。利用使用者名稱及密碼進行鑑別之後，您會看到 {{site.data.keyword.Bluemix_notm}} 儀表板：<br/>
    ![{{site.data.keyword.Bluemix_notm}} 儀表板](images/img0001.png)

2.  向下捲動「儀表板」，直到到達列出所有服務的區段為止：<br/>
    ![{{site.data.keyword.Bluemix_notm}}' 服務清單](images/img0010.png)

3.  在此範例中，我們要尋找先前在指導教學中建立的 {{site.data.keyword.cloudant_short_notm}} 服務實例（稱為 `Cloudant Service 2017`）的服務認證。按一下對應的列：<br/>
    ![選取 {{site.data.keyword.cloudant_short_notm}} 服務](images/img0011.png)

3.  即會出現「服務認證」視窗。若要查看存取服務所需的認證，請按一下`檢視認證`下拉清單：<br/>
    ![檢視 {{site.data.keyword.cloudant_short_notm}} 服務認證](images/img0008.png)

4.  即會出現「服務認證」詳細資料：<br/>
    ![{{site.data.keyword.cloudant_short_notm}} 服務認證](images/img0009.png)

>   **附註**：這些範例中的服務認證
    是在 {{site.data.keyword.cloudant_short_notm}} 上建立示範 {{site.data.keyword.cloudant_short_notm}} 服務時定義的。
    我們在這裡重新產生認證，是要示範它們在儀表板中的顯示方式。不過，已移除示範 {{site.data.keyword.cloudant_short_notm}} 服務，因此這些認證不再有效；您_必須_ 提供及使用自己的服務認證。
