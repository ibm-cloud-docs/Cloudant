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

<!-- Acrolinx: 2017-01-11 -->

# 建立簡單的 {{site.data.keyword.Bluemix_notm}} 應用程式以存取 {{site.data.keyword.cloudant_short_notm}} 資料庫：維護及疑難排解

本指導教學示範如何維護在 {{site.data.keyword.Bluemix_notm}} 服務實例中管理的 {{site.data.keyword.Bluemix}} 應用程式。
{:shortdesc}

<div id="maintenance"></div>

## 執行基本應用程式維護作業

指導教學的這一節說明如何在 {{site.data.keyword.Bluemix_notm}} 上重新整理、啟動及停止 Python 應用程式。

### 尋找應用程式的狀態

儀表板上會顯示 {{site.data.keyword.Bluemix_notm}} 服務實例內應用程式的狀態。

在下列範例中，`Cloudant Python` 應用程式未執行，而且狀態為`已停止`：<br/>
![顯示處於「已停止」狀態之應用程式的儀表板的畫面擷取](images/img0037.png)

### 啟動應用程式

>   **附註**：如果您嘗試啟動指導教學應用程式，
    而未先刪除指導教學示範資料庫，應用程式就無法正確地運作。應用程式會進入嘗試啟動、因資料庫存在而失敗、停止，然後嘗試重新啟動的循環。若要解決問題，請[停止應用程式](#stopping-your-application)，然後刪除指導教學示範資料庫。接著就可以順利啟動應用程式。



若要啟動已停止的應用程式，請先按一下儀表板上的應用程式功能表圖示：<br/>
![畫面擷取顯示具有應用程式管理圖示的儀表板](images/img0038.png)

接下來，按一下功能表中的`啟動應用程式`選項：<br/>
![顯示「啟動應用程式」選項的畫面擷取](images/img0039.png)

### 停止應用程式

若要停止執行中應用程式，請先按一下儀表板上的應用程式功能表圖示：<br/>
![畫面擷取顯示具有應用程式管理圖示的儀表板](images/img0040.png)

接下來，按一下功能表中的`停止應用程式`選項：<br/>
![顯示「停止應用程式」選項的畫面擷取](images/img0041.png)

<div id="troubleshooting"></div>

### 上傳全新版本的應用程式

若要上傳全新版本的應用程式，只需要遵循[上傳處理程序](create_bmxapp_upload.html)。新版本會改寫應用程式的舊版本。

>   **附註**：如果您開始上傳時，應用程式的舊版本已在執行，
    則 {{site.data.keyword.Bluemix_notm}} 會自動先停止應用程式。



## 診斷及解決問題

指導教學的這一節提供一些基本疑難排解提示，來協助您識別、診斷及解決一些開發及部署第一個 {{site.data.keyword.Bluemix_notm}} 應用程式時可能遇到的問題。

[這裡 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://docs.cloudfoundry.org/devguide/deploy-apps/prepare-to-deploy.html){:new_window} 提供了建立 {{site.data.keyword.Bluemix_notm}} 或 Cloud Foundry 應用程式的最佳作法的良好建議。

尤其是關於[避免寫入至本端檔案系統 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://docs.cloudfoundry.org/devguide/deploy-apps/prepare-to-deploy.html#filesystem){:new_window} 的建議很謹慎。

>   **附註**：為求簡化，
本指導教學確實會將內容寫入至本端檔案系統。不過，資料量很小。預期不會持續保存，而且不是「關鍵任務」資料。



### 使用應用程式日誌

診斷及解決 {{site.data.keyword.Bluemix_notm}} 應用程式問題時，最有用的資源是日誌檔。

您可以在`日誌`資訊頁面上找到 {{site.data.keyword.Bluemix_notm}} 應用程式的日誌檔：<br/>
![顯示「日誌」資訊頁面存取鏈結的畫面擷取](images/img0042.png)

與大部分日誌檔相同，{{site.data.keyword.Bluemix_notm}} 應用程式日誌會包含所發生事件及其發生時間的詳細資料。

此日誌也會識別已記錄事件中所涉及的元件。下表識別重要元件：

元件標籤        | 元件
----------------|----------
`API`           | Cloud Foundry 系統。
`APP`           | 您的應用程式。
`CELL`          | 在 {{site.data.keyword.Bluemix_notm}} 內存放應用程式的容器。
`RTR`           | 在應用程式中傳送或擷取訊息的網路元件。

例如，下列畫面擷取包括數個一般事件：<br/>
![顯示指示性日誌資訊的畫面擷取](images/img0043.png)

請注意下列時間的事件：

-   在下午 1:56:56，已順利啟動應用程式。
-   在下午 1:58:43，網路收到 `GET /` 的簡單 HTTP 要求。
-   一段時間之後，應用程式收到 HTTP 要求，並進行回覆。
-   在下午 2:13:46，收到停止應用程式的要求。
-   在下午 2:13:48，應用程式已完成中止處理程序。

本指導教學中所說明的應用程式刻意減到最少。具體而言，我們不會嘗試判斷目標資料庫是否存在，而且，如果它確實存在，也不會嘗試避免嘗試重新建立它。後果便是，如果您嘗試多次執行指導教學應用程式，而未事先移除資料庫，則應用程式會反覆地失敗並重新啟動。

您可以在下列畫面擷取中看到這項影響：<br/>
![顯示日誌內錯誤資訊的畫面擷取](images/img0044.png)

在下午 2:31:23，應用程式偵測到問題：<br/>
`"Database {0} already exists".format(dbname)`

其餘訊息就是您預期來自任何發生問題之 Python 應用程式的訊息。

實際上，日誌會顯示發生問題的元件，並盡可能提供最多的詳細資料。您必須接著應用正常的應用程式疑難排解程序來解決問題。

## 指導教學結束

指導教學已完成。
