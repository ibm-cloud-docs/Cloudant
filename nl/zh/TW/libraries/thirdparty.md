---

copyright:
  years: 2015, 2019
lastupdated: "2019-06-12"

keywords: client, mobile, c#, .net, libraries, frameworks, examples, tutorials, php, javascript, ruby, meteor, apache spark, 

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

# 協力廠商用戶端程式庫
{: #third-party-client-libraries}

{{site.data.keyword.cloudantfull}} 不會維護或支援協力廠商用戶端程式庫。
{: shortdesc}

## C# / .NET
{: #c-net}

[MyCouch ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://github.com/danielwertheim/mycouch){: new_window} 是適用於 .Net 的非同步 CouchDB 及 {{site.data.keyword.cloudant_short_notm}} 用戶端。

若要安裝程式庫，請開啟「套件管理程式」主控台，並呼叫：

```
install-package mycouch.cloudant
```
{: codeblock}

### C#/.NET 的程式庫及架構
{: #libraries-and-frameworks-for-c-net}

-   [MyCouch ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://github.com/danielwertheim/mycouch){: new_window}。
-   [LoveSeat ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://github.com/soitgoes/LoveSeat){: new_window}。
-   [Divan ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://github.com/foretagsplatsen/Divan){: new_window}。
-   [Relax ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://github.com/arobson/Relax){: new_window}。
-   [Hammock ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](http://code.google.com/p/relax-net/){: new_window}。
-   [EasyCouchDB ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://github.com/hhariri/EasyCouchDB){: new_window}。
-   `WDK.API.CouchDB`，來自 [Kanapes IDE ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](http://kanapeside.com/){: new_window}。

### C#/.NET 的範例及指導教學
{: #examples-and-tutorials-for-c-net}

-   [CRUD ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://github.com/cloudant/haengematte/tree/master/c%23){: new_window}。

## Java
{: #java-thirdparty}

### 不支援的 Java 程式庫
{: #unsupported-for-libraries-for-java-thirdparty}

-   [ektorp ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://helun.github.io/Ektorp/reference_documentation.html){: new_window}。
-   [jcouchdb ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](http://code.google.com/p/jcouchdb/){: new_window}。
-   [jrelax ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://github.com/isterin/jrelax){: new_window}。
-   [LightCouch ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](http://www.lightcouch.org/){: new_window}。

## JavaScript
{: #javascript}

### JavaScript 的程式庫及架構
{: #libraries-and-frameworks-for-javascript}

-   [Backbone.cloudant ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://github.com/cloudant-labs/backbone.cloudant){: new_window}。
-   [sag.js ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://github.com/sbisbee/sag-js){: new_window}。

### JavaScript 的範例及指導教學
{: #examples-and-tutorials-for-javascript}

-   使用 jQuery 的 [CRUD ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://github.com/cloudant/haengematte/tree/master/javascript-jquery){: new_window}。
-   [CSVtoCloudant ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://github.com/michellephung/CSVtoCloudant){: new_window} - 用於將 `.csv` 檔案匯入至 {{site.data.keyword.cloudant_short_notm}} 的使用者介面。
    也可以在[這裡 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://michellephung.github.io/CSVtoCloudant/){: new_window} 存取應用程式。
-   [csv2couchdb ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://github.com/Mango-information-systems/csv2couchdb){: new_window} - 來自 Mango Systems 的使用者介面，用來將 `.csv` 檔案匯入至 CouchDB/{{site.data.keyword.cloudant_short_notm}}。
-   [songblog ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://github.com/millayr/songblog){: new_window} - 使用 JQuery 的範例應用程式。
    
## PouchDB (JavaScript)
{: #pouchdb}

[PouchDB ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](http://pouchdb.com/){: new_window} 是可與 {{site.data.keyword.cloudant_short_notm}} 同步的 JavaScript 資料庫，這表示您只要使用 PouchDB 就可以離線使用應用程式。
如需相關資訊，請參閱 PouchDB 上的[我們的部落格文章 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://cloudant.com/blog/pouchdb){: new_window}。

若要取得 PouchDB，以及設定詳細資料，請參閱 [PouchDB ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](http://pouchdb.com/){: new_window}。

PouchDB 也適用於 Node.js：`npm install pouchdb`。
{: note}

也可以使用 Bower 來安裝 PouchDB：`bower install pouchdb`。
{: note}

### PouchDB 的程式庫及架構
{: #libraries-and-frameworks-for-pouchdb}

-   [PouchDB ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](http://pouchdb.com/){: new_window} - 瀏覽器的 JavaScript 資料庫，具有離線同步化。

### PouchDB 的範例及指導教學
{: #examples-and-tutorials-for-pouchdb}

-   [PouchDB 入門手冊 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](http://pouchdb.com/getting-started.html){: new_window} - 從瀏覽器同步到 {{site.data.keyword.cloudant_short_notm}} 或 CouchDB 的範例「待辦事項」應用程式。
-   [locationtracker ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://github.com/rajrsingh/locationtracker){: new_window} - 使用 PouchDB、CouchApp 及 {{site.data.keyword.cloudant_short_notm}} 來記錄及對映位置的範例應用程式。

## Node.js
{: #node-js-thirdparty}

### 不支援的 Node.js 程式庫及架構
{: #unsupported-libraries-and-frameworks-for-node-js-thirdparty}

-   [sag-js ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://github.com/sbisbee/sag-js){: new_window}（也會在瀏覽器中運作）。如需詳細資料，請參閱 [saggingcouch ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://github.com/sbisbee/saggingcouch.com){: new_window}。
-   [nano ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://github.com/dscape/nano){: new_window} 是最小清單實作。
-   [restler ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://github.com/danwrong/restler){: new_window} 提供最佳效能，但實際上是準系統。
-   [cradle ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://github.com/flatiron/cradle){: new_window} 是如果您絕對需要易於使用，而不惜付出效能降低的成本時，也可以使用的高階用戶端。
-   [cane_passport ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://github.com/ddemichele/cane_passport){: new_window} - 具有「引導」的 {{site.data.keyword.cloudant_short_notm}} Angular Node Express。
-   [express-cloudant ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://github.com/cloudant-labs/express-cloudant){: new_window} - Node.js Express 架構的範本，也會使用 PouchDB 及 Grunt。

## PHP
{: #php}

[Sag ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://github.com/sbisbee/sag){: new_window} 是 PHP 的 CouchDB 及 {{site.data.keyword.cloudant_short_notm}} 用戶端。
[Sag.js ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://github.com/sbisbee/sag-js){: new_window} 是 Sag 的 JavaScript 對應項目。

若要安裝，請從 [https://github.com/sbisbee/sag ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://github.com/sbisbee/sag){: new_window} 下載 `sag`，然後在您的應用程式中包括程式庫。

```
require_once('./src/Sag.php');
```
{: codeblock}

### PHP 的程式庫及架構
{: #libraries-and-frameworks-for-php}

-   [sag ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://github.com/sbisbee/sag){: new_window}。
-   [Doctrine CouchDB Client ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://github.com/doctrine/couchdb-client){: new_window}。
-   [PHP-on-Couch ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://github.com/dready92/PHP-on-Couch){: new_window}。

### PHP 的範例及指導教學
{: #examples-and-tutorials-for-php}

-   [CRUD ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://github.com/cloudant/haengematte/tree/master/php){: new_window}。

## Python
{: #python}

### 不支援的 Python 程式庫及架構
{: #unsupported-libraries-and-frameworks-for-python}

-   [Requests ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](http://docs.python-requests.org/en/master/){: new_window}。

## Ruby
{: #ruby}

[CouchRest ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://github.com/couchrest/couchrest){: new_window} 是 CouchDB 及 {{site.data.keyword.cloudant_short_notm}} 用戶端，具有可使用 [CouchRest 模型 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://github.com/couchrest/couchrest_model){: new_window} 來處理 Rails 的延伸。

若要安裝 CouchRest，請執行下列指令：

```sh
gem install couchrest
```
{: codeblock}

### Ruby 的程式庫及架構
{: #libraries-and-frameworks-for-ruby}

[Ruby Toolbox ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://www.ruby-toolbox.com/categories/couchdb_clients){: new_window} 上列出許多 CouchDB 用戶端。

### Ruby 的範例及指導教學
{: #examples-and-tutorials-for-ruby}

-   [CRUD ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://github.com/cloudant/haengematte/tree/master/ruby){: new_window}。

## Meteor
{: #meteor}

[cloudant:couchdb ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://atmospherejs.com/cloudant/couchdb){: new_window} 是 `couchdb-meteor` 套件的 {{site.data.keyword.cloudant_short_notm}} 程式庫。
因為 Apache CouchDB 未隨附 Meteor 或 CouchDB 套件，所以您必須先提供要連接至執行中 CouchDB 或 {{site.data.keyword.cloudant_short_notm}} 伺服器實例的 Meteor URL，然後再安裝 Meteor。
請將此套件新增至 Meteor 應用程式：

```sh
meteor add cloudant:couchdb
```
{: codeblock}

couchdb-meteor 套件提供：

-   使用 CouchDB `_changes` 資訊來源的資料庫的 Livequery 實作及即時更新。
-   「分散式資料通訊協定 (DDP)」RPC 端點，其更新本端連接的用戶端的資料。
-   序列化及解除序列化對 DDP 格式的更新。

由「{{site.data.keyword.cloudant_short_notm}} 查詢」使用且一開始由 {{site.data.keyword.cloudant_short_notm}} 開發的 JSON 查詢語法，會被提供回 Apache CouchDB 作為 2.0 版。Apache CouchDB 2.0 版的預先建置的二進位檔還是無法使用。您可以搭配使用此模組與 {{site.data.keyword.cloudant_short_notm}} DBaaS 或 Cloudant Local，直到預先建置的二進位檔可供使用。
{: note}

若要配置 Apache CouchDB 或 {{site.data.keyword.cloudant_short_notm}} 伺服器連線資訊，請將其 URL 當作 `COUCHDB_URL` 環境變數傳遞給 Meteor 伺服器處理程序：

```sh
$ export COUCHDB_URL=https://username:password@username.cloudant.com
```
{: codeblock}

如需 meteor-couchdb API 的相關資訊，請參閱 [API 參考資料](/docs/services/Cloudant?topic=cloudant-api-reference-overview#api-reference-overview)。 
