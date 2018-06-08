---

copyright:
  years: 2015, 2018
lastupdated: "2017-11-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-03-06 -->

# 支援的用戶端程式庫

## Mobile

{{site.data.keyword.cloudantfull}} Sync 程式庫是用來儲存、索引以及查詢行動裝置上的本端 JSON 資料。
它也用來同步化多部裝置之間的資料。同步化是透過應用程式所控制。程式庫也提供 helper 方法，來尋找及解決本端裝置及遠端資料庫中的衝突。

您可以使用兩個版本：

-   [{{site.data.keyword.cloudant_short_notm}} Sync - Android/JavaSE ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://github.com/cloudant/sync-android){:new_window}。
-   [{{site.data.keyword.cloudant_short_notm}} Sync - iOS (CDTDatastore) ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://github.com/cloudant/CDTDatastore){:new_window}。

提供了 {{site.data.keyword.cloudant_short_notm}} Sync 的[概觀 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://cloudant.com/product/cloudant-features/sync/){:new_window}。同時也提供 {{site.data.keyword.cloudant_short_notm}} Sync [資源 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://cloudant.com/cloudant-sync-resources/){:new_window} 的詳細資料。

## Java

[java-cloudant ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://github.com/cloudant/java-cloudant){:new_window} 是 Java 的正式 {{site.data.keyword.cloudantfull}} 程式庫。

[這裡 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://github.com/cloudant/java-cloudant#installation-and-usage){:new_window} 提供將程式庫當作相依關係新增至 Maven 或 Gradle 建置來安裝程式庫的相關資訊，以及如何使用程式庫的詳細資料及範例。

### 程式庫及架構

#### 支援

-   [java-cloudant ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://github.com/cloudant/java-cloudant){:new_window}。

#### 不支援

-   [ektorp ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](http://ektorp.org/){:new_window}。
-   [jcouchdb ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](http://code.google.com/p/jcouchdb/){:new_window}。
-   [jrelax ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://github.com/isterin/jrelax){:new_window}。
-   [LightCouch ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](http://www.lightcouch.org/){:new_window}。
-   [Java {{site.data.keyword.cloudant_short_notm}} Web Starter ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://ace.ng.bluemix.net/#/store/cloudOEPaneId=store&appTemplateGuid=CloudantJavaBPTemplate&fromCatalog=true){:new_window} 樣板（適用於 Bluemix）。

### 範例及指導教學

-   [使用 HTTP 及 JSON 程式庫建立、讀取、更新及刪除 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://github.com/cloudant/haengematte/tree/master/java){:new_window}。
-   [使用 ektorp 程式庫建立、讀取、更新及刪除 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://github.com/cloudant/haengematte/tree/master/java/CrudWithEktorp){:new_window}。
-   [在 IBM Bluemix ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示") 上，搭配使用 Java 與 {{site.data.keyword.cloudant_short_notm}} 來建置應用程式](https://cloudant.com/blog/building-apps-using-java-with-cloudant-on-ibm-bluemix/){:new_window}。
-   [使用 Liberty、{{site.data.keyword.cloudant_short_notm}} 及 Single Sign On ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示") Bluemix 範例來建置遊戲應用程式](http://www.ibm.com/developerworks/cloud/library/cl-multiservicegame-app/index.html?ca=drs-){:new_window}。
-   [使用 Watson 及 {{site.data.keyword.cloudant_short_notm}} ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://developer.ibm.com/bluemix/2014/10/17/building-java-ee-app-ibm-bluemix-using-watson-cloudant/){:new_window} Bluemix 範例，以及 [YouTube 視訊 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://www.youtube.com/watch?feature=youtu.be&v=9AFMY6m0LIU&app=desktop){:new_window}，在 IBM Bluemix 上建置 Java EE 應用程式。


## Node.js

[nodejs-cloudant ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://github.com/cloudant/nodejs-cloudant){:new_window} 是 Node.js 的正式 {{site.data.keyword.cloudant_short_notm}} 程式庫。您可以使用 npm 進行安裝：

```sh
npm install cloudant
```
{:codeblock}

### 程式庫及架構

#### 支援

-   [nodejs-cloudant ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://github.com/cloudant/nodejs-cloudant){:new_window}（[npm ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://www.npmjs.org/package/cloudant){:new_window}）。

#### 不支援

-   [sag-js ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://github.com/sbisbee/sag-js){:new_window}（也會在瀏覽器中運作）。如需詳細資料，請參閱 [saggingcouch ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://github.com/sbisbee/saggingcouch.com){:new_window}。
-   [nano ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://github.com/dscape/nano){:new_window} 是最小清單實作。
-   [restler ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://github.com/danwrong/restler){:new_window} 提供最佳效能，但實際上是準系統。
-   [cradle ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://github.com/flatiron/cradle){:new_window} 是如果您絕對需要易於使用，而不惜付出效能降低的成本時，也可以使用的高階用戶端。
-   [cane_passport ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://github.com/ddemichele/cane_passport){:new_window} - 具有「引導」的 {{site.data.keyword.cloudant_short_notm}} Angular Node Express。
-   [express-cloudant ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://github.com/cloudant-labs/express-cloudant){:new_window} - Node.js Express 架構的範本，也會使用 PouchDB 及 Grunt。
-   [Node.js {{site.data.keyword.cloudant_short_notm}} DB Web Starter ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://ace.ng.bluemix.net/#/store/cloudOEPaneId=store&appTemplateGuid=nodejscloudantbp&fromCatalog=true){:new_window} - Bluemix 的樣板。
-   [Mobile Cloud ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://ace.ng.bluemix.net/#/store/cloudOEPaneId=store&appTemplateGuid=mobileBackendStarter&fromCatalog=true){:new_window} - Bluemix 的樣板（Node.js、Security、Push 及 Mobile Data/{{site.data.keyword.cloudant_short_notm}}）。

### 範例及指導教學

-   [建立、讀取、更新及刪除 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://github.com/cloudant/haengematte/tree/master/nodejs){:new_window}。
-   [Cloudant-Uploader ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://github.com/garbados/Cloudant-Uploader){:new_window} - 將 `.csv` 檔案上傳至 {{site.data.keyword.cloudant_short_notm}} 的公用程式。
-   [couchimport ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://github.com/glynnbird/couchimport){:new_window} - 將 `.csv` 或 `.tsv` 檔案匯入至 CouchDB 或 {{site.data.keyword.cloudant_short_notm}} 的公用程式。
-   [Getting started with {{site.data.keyword.Bluemix}} and Node.js ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](http://thoughtsoncloud.com/2014/07/getting-started-ibm-bluemix-node-js/){:new_window}。
-   [A Cloud medley with {{site.data.keyword.Bluemix_notm}}, {{site.data.keyword.cloudant_short_notm}} and Node.js ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://gigadom.wordpress.com/2014/08/15/a-cloud-medley-with-ibm-bluemix-cloudant-db-and-node-js/){:new_window}。
-   [Build a simple word game app by using {{site.data.keyword.cloudant_short_notm}} on {{site.data.keyword.Bluemix_notm}} ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](http://www.ibm.com/developerworks/cloud/library/cl-guesstheword-app/index.html?ca=drs-){:new_window} - 使用 Node.js。
-   [Building a Real-time SMS Voting App ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://www.twilio.com/blog/2012/09/building-a-real-time-sms-voting-app-part-1-node-js-couchdb.html){:new_window} - 使用 Node.js、Twilio 及 {{site.data.keyword.cloudant_short_notm}} 的六部分系列。
-   [Building a multitier Windows Azure Web application ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](http://msopentech.com/blog/2013/12/19/tutorial-building-multi-tier-windows-azure-web-application-use-cloudants-couchdb-service-node-js-cors-grunt-2/){:new_window} - 使用 {{site.data.keyword.cloudant_short_notm}}、Node.js、CORS 及 Grunt。
-   [Do it yourself: Build a remote surveillance application by using {{site.data.keyword.Bluemix_notm}}, {{site.data.keyword.cloudant_short_notm}}, and Raspberry Pi. ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](http://www.ibm.com/developerworks/library/ba-remoteservpi-app/index.html){:new_window}。

## Python

[這裡 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://github.com/cloudant/python-cloudant){:new_window} 提供使用 Python 來使用 {{site.data.keyword.cloudant_short_notm}} 的受支援程式庫。

>   **附註：**存取 {{site.data.keyword.cloudant_short_notm}} 的 Python 應用程式具有元件相依關係。必須在 `requirements.txt` 檔案中指定這些相依關係。如需相關資訊，請參閱[這裡 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://pip.readthedocs.io/en/1.1/requirements.html){:new_window}。

在[這裡 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://pypi.python.org/pypi/cloudant/){:new_window} 下載現行程式庫版次。在 [python.org ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://www.python.org/about/){:new_window} 進一步瞭解 Python 語言的相關資訊。 

## Swift

已提供支援的程式庫來使用 {{site.data.keyword.cloudant_short_notm}}。程式庫稱為 Swift{{site.data.keyword.cloudant_short_notm}}，而且是使用 `cocoapods` 進行安裝。

podfile 項目為：

```sh
pod 'SwiftCloudant'
```
{:codeblock}

[這裡 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://github.com/cloudant/swift-cloudant){:new_window} 提供 ObjectiveCloudant 的相關資訊（包括安裝詳細資料，以及如何使用程式庫來儲存、索引及查詢 {{site.data.keyword.cloudant_short_notm}} 上的遠端 JSON 資料）。

程式庫是早期發行的版本。因此，它目前未完整涵蓋 {{site.data.keyword.cloudant_short_notm}} API。 

>   **附註**：iOS 上不支援 SwiftCloudant，而且您無法從 Objective-C 呼叫它。
