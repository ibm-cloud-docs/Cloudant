---

copyright:
  years: 2015, 2019
lastupdated: "2019-04-02"

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

# 第三方客户机库
{: #third-party-client-libraries}

{{site.data.keyword.cloudantfull}} 不会维护或支持第三方客户机库。
{: shortdesc}

## C# / .NET
{: #c-net}

[MyCouch ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/danielwertheim/mycouch){: new_window} 是 .Net 的异步 CouchDB 和 {{site.data.keyword.cloudant_short_notm}} 客户端。

要安装该库，请打开软件包管理器控制台，然后调用：

```
install-package mycouch.cloudant
```
{: codeblock}

### C# / .NET 的库和框架
{: #libraries-and-frameworks-for-c-net}

-   [MyCouch ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/danielwertheim/mycouch){: new_window}。
-   [LoveSeat ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/soitgoes/LoveSeat){: new_window}。
-   [Divan ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/foretagsplatsen/Divan){: new_window}。
-   [Relax ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/arobson/Relax){: new_window}。
-   [Hammock ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](http://code.google.com/p/relax-net/){: new_window}。
-   [EasyCouchDB ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/hhariri/EasyCouchDB){: new_window}。
-   [Kanapes IDE ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](http://kanapeside.com/){: new_window} 中的 `WDK.API.CouchDB`。

### C# / .NET 的示例和教程
{: #examples-and-tutorials-for-c-net}

-   [CRUD ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/cloudant/haengematte/tree/master/c%23){: new_window}。

## Java
{: #java}

### 不支持的 Java 库
{: #unsupported-for-libraries-for-java}

-   [ektorp ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://helun.github.io/Ektorp/reference_documentation.html){: new_window}。
-   [jcouchdb ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](http://code.google.com/p/jcouchdb/){: new_window}。
-   [jrelax ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/isterin/jrelax){: new_window}。
-   [LightCouch ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](http://www.lightcouch.org/){: new_window}。

## JavaScript
{: #javascript}

### JavaScript 的库和框架
{: #libraries-and-frameworks-for-javascript}

-   [Backbone.cloudant ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/cloudant-labs/backbone.cloudant){: new_window}。有关更多信息，请参阅[博客帖子 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://cloudant.com/blog/backbone-and-cloudant/){: new_window}。
-   [sag.js ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/sbisbee/sag-js){: new_window}。

### JavaScript 的示例和教程
{: #examples-and-tutorials-for-javascript}

-   [CRUD ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/cloudant/haengematte/tree/master/javascript-jquery){: new_window} - 使用 jQuery。
-   [CSVtoCloudant ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/michellephung/CSVtoCloudant){: new_window} - 用于将 `.csv` 文件导入到 {{site.data.keyword.cloudant_short_notm}} 的 UI。也可在[此处 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://michellephung.github.io/CSVtoCloudant/){: new_window} 访问该应用程序。
-   [csv2couchdb ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/Mango-information-systems/csv2couchdb){: new_window} - Mango 系统中的 UI，用于将 `csv` 文件导入到 CouchDB/{{site.data.keyword.cloudant_short_notm}}。
-   [songlog ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/millayr/songblog){: new_window} - 使用 JQuery 的示例应用程序。
    
## PouchDB (JavaScript)
{: #pouchdb}

[PouchDB ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](http://pouchdb.com/){: new_window} 是可与 {{site.data.keyword.cloudant_short_notm}} 同步的 JavaScript 数据库，这意味着只需使用 PouchDB 即可使应用程序处于脱机准备就绪状态。有关更多信息，请参阅关于 PouchDB 的[博客帖子 ![外部链接图标 ](../images/launch-glyph.svg "外部链接图标")](https://cloudant.com/blog/pouchdb){: new_window}。

要获取 PouchDB 以及设置详细信息，请参阅 [PouchDB ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](http://pouchdb.com/){: new_window}。

PouchDB 也可用于 Node.js：`npm install pouchdb`。
{: note}

PouchDB 也可与 Bower 一起安装：`bower install pouchdb`。
{: note}

### PouchDB 的库和框架
{: #libraries-and-frameworks-for-pouchdb}

-   [PouchDB ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](http://pouchdb.com/){: new_window} - 用于浏览器的 JavaScript 数据库，带有脱机同步。

### PouchDB 的示例和教程
{: #examples-and-tutorials-for-pouchdb}

-   [PouchDB 入门指南 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](http://pouchdb.com/getting-started.html){: new_window} - 从浏览器同步到 {{site.data.keyword.cloudant_short_notm}} 或 CouchDB 的示例 Todo 应用程序。
-   [locationtracker ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/rajrsingh/locationtracker){: new_window} - 使用 PouchDB、CouchApp 和 {{site.data.keyword.cloudant_short_notm}} 记录并映射位置的示例应用程序。

## Node.js
{: #node-js}

### 不支持的 Node.js 库和框架
{: #unsupported-libraries-and-frameworks-for-node-js-thirdparty}

-   [sag-js ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/sbisbee/sag-js){: new_window}，也可在浏览器中使用。有关更多详细信息，请参阅 [saggingcouch ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/sbisbee/saggingcouch.com){: new_window}。
-   [nano ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/dscape/nano){: new_window} 是一种极简实现。
-   [restler ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/danwrong/restler){: new_window} 提供了最佳性能，但实际上只有基本功能。
-   [cradle ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/flatiron/cradle){: new_window} 是一种高级别客户端。如果您觉得使用方便至关重要，即使降低性能也无所谓，那么也可以使用此客户端。
-   [cane_passport ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/ddemichele/cane_passport){: new_window} - 具有引导程序的 {{site.data.keyword.cloudant_short_notm}} Angular Node Express。
-   [express-cloudant ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/cloudant-labs/express-cloudant){: new_window} - Node.js Express 框架的模板，也使用 PouchDB 和 Grunt。

## PHP
{: #php}

[Sag ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/sbisbee/sag){: new_window} 是 PHP 的 CouchDB 和 {{site.data.keyword.cloudant_short_notm}} 客户端。
[Sag.js ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/sbisbee/sag-js){: new_window} 是 Sag 的 JavaScript 对应项。

要进行安装，请从 [https://github.com/sbisbee/sag ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/sbisbee/sag){: new_window} 下载 `sag`，然后将该库包含在应用程序中：

```
require_once('./src/Sag.php');
```
{: codeblock}

### PHP 的库和框架
{: #libraries-and-frameworks-for-php}

-   [sag ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/sbisbee/sag){: new_window}。
-   [Doctrine CouchDB 客户端 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/doctrine/couchdb-client){: new_window}。
-   [PHP-on-Couch ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/dready92/PHP-on-Couch){: new_window}。

### PHP 的示例和教程
{: #examples-and-tutorials-for-php}

-   [CRUD ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/cloudant/haengematte/tree/master/php){: new_window}。

## Python
{: #python}

### 不支持的 Python 库和框架
{: #unsupported-libraries-and-frameworks-for-python}

-   [Requests ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](http://docs.python-requests.org/en/master/){: new_window}。

## Ruby
{: #ruby}

[CouchRest ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/couchrest/couchrest){: new_window} 是 CouchDB 和 {{site.data.keyword.cloudant_short_notm}} 客户端，其扩展可利用 [CouchRest 模型 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/couchrest/couchrest_model){: new_window} 与 Rails 搭配使用。

要安装 CouchRest，请运行以下命令：

```sh
gem install couchrest
```
{: codeblock}

### Ruby 的库和框架
{: #libraries-and-frameworks-for-ruby}

[Ruby 工具箱 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://www.ruby-toolbox.com/categories/couchdb_clients){: new_window} 上列出了多种 CouchDB 客户端。

### Ruby 的示例和教程
{: #examples-and-tutorials-for-ruby}

-   [CRUD ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/cloudant/haengematte/tree/master/ruby){: new_window}。

## Meteor
{: #meteor}

[cloudant:couchdb ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://atmospherejs.com/cloudant/couchdb){: new_window} 是针对 `couchdb-meteor` 软件包的 {{site.data.keyword.cloudant_short_notm}} 库。由于 Apache CouchDB 不包含在 Meteor 或 CouchDB 软件包中，因此在安装 Meteor 之前，必须先提供 Meteor 的 URL 以连接到正在运行的 CouchDB 或 {{site.data.keyword.cloudant_short_notm}} 服务器实例。将此软件包添加到 Meteor 应用程序：

```sh
meteor add cloudant:couchdb
```
{: codeblock}

couchdb-meteor 软件包中提供：

-   通过使用 CouchDB `_changes` 订阅源，从数据库进行的实时查询实现和实时更新。
-   分布式数据协议 (DDP) RPC 端点，可从本地连接的客户端更新数据。
-   以 DDP 格式对更新进行的序列化和编组。

{{site.data.keyword.cloudant_short_notm}} Query 所使用的、最初由 {{site.data.keyword.cloudant_short_notm}} 开发的 JSON 查询语法已重新提供给 Apache CouchDB V2.0。为 Apache CouchDB V2.0 预构建的二进制文件尚不可用。在预构建二进制文件可用之前，您可以先搭配使用此模块和 {{site.data.keyword.cloudant_short_notm}} DBaaS 或 Cloudant Local。
{: note}

要配置 Apache CouchDB 或 {{site.data.keyword.cloudant_short_notm}} 服务器连接信息，请将其 URL 作为 `COUCHDB_URL` 环境变量传递给 Meteor 服务器进程：

```sh
$ export COUCHDB_URL=https://username:password@username.cloudant.com
```
{: codeblock}

有关 meteor-couchdb API 的更多信息，请参阅 [API 参考](/docs/services/Cloudant/api/index.html#api-reference-overview)。 
