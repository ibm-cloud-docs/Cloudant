---

copyright:
  years: 2015, 2017
lastupdated: "2017-01-04"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

# 第三方客户端库

>   **注**：Cloudant 不会维护或支持第三方客户端库。

## 第三方移动库

使用 Cloudant 数据库：

-   带 Cloudant 适配器的 [IBM Worklight Powered Native Objective-C iOS 应用程序 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](http://www.tricedesigns.com/2014/11/17/ibm-worklight-powered-native-objective-c-ios-apps/){:new_window}。

## C# / .NET

[MyCouch ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/danielwertheim/mycouch){:new_window} 是 .Net 的异步 CouchDB 和 Cloudant 客户端。

要安装该库，请打开软件包管理器控制台，然后调用：

```
install-package mycouch.cloudant
```
{:codeblock}

### 库和框架

-   [MyCouch ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/danielwertheim/mycouch){:new_window}。
-   [LoveSeat ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/soitgoes/LoveSeat){:new_window}。
-   [Divan ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/foretagsplatsen/Divan){:new_window}。
-   [Relax ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/arobson/Relax){:new_window}。
-   [Hammock ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](http://code.google.com/p/relax-net/){:new_window}。
-   [EasyCouchDB ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/hhariri/EasyCouchDB){:new_window}。
-   [Kanapes IDE ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](http://kanapeside.com/){:new_window} 中的 `WDK.API.CouchDB`。

### 示例和教程

-   [CRUD ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/cloudant/haengematte/tree/master/c%23){:new_window}。

## PHP

[Sag ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/sbisbee/sag){:new_window} 是 PHP 的 CouchDB 和 Cloudant 客户端。
[Sag.js ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/sbisbee/sag-js){:new_window} 是 Sag 的 JavaScript 对应项。

要进行安装，请从 [https://github.com/sbisbee/sag ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/sbisbee/sag){:new_window} 下载 `sag`，然后将该库包含在应用程序中：

```
require_once('./src/Sag.php');
```
{:codeblock}

### 库和框架

-   [sag ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/sbisbee/sag){:new_window}。
-   [Doctrine CouchDB 客户端 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/doctrine/couchdb-client){:new_window}。
-   [PHP-on-Couch ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/dready92/PHP-on-Couch){:new_window}。

### 示例和教程

-   [CRUD ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/cloudant/haengematte/tree/master/php){:new_window}。

## JavaScript

[PouchDB ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](http://pouchdb.com/){:new_window} 是可与 Cloudant 同步的 JavaScript 数据库，这意味着只需使用 PouchDB 即可使应用程序处于脱机准备就绪状态。有关更多信息，请参阅我们关于 PouchDB 的[博客帖子 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://cloudant.com/blog/pouchdb){:new_window}。

要获取 PouchDB 以及设置详细信息，请参阅 [PouchDB ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](http://pouchdb.com/){:new_window}。

>   **注**：PouchDB 也可用于 Node.js：`npm install pouchdb`。

>   **注**：PouchDB 也可与 Bower 一起安装：`bower install pouchdb`。

### 库和框架

-   [Backbone.cloudant ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/cloudant-labs/backbone.cloudant){:new_window}。有关更多信息，请参阅[博客帖子 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://cloudant.com/blog/backbone-and-cloudant/){:new_window}。
-   [sag.js ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/sbisbee/sag-js){:new_window}。
-   [PouchDB ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](http://pouchdb.com/){:new_window} - 用于浏览器的 JavaScript 数据库，带有脱机同步。

### 示例和教程

-   [CRUD ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/cloudant/haengematte/tree/master/javascript-jquery){:new_window} - 使用 jQuery。
-   [CSVtoCloudant ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/michellephung/CSVtoCloudant){:new_window} - 用于将 `.csv` 文件导入到 Cloudant 的 UI。也可在[此处 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://michellephung.github.io/CSVtoCloudant/){:new_window} 访问该应用程序。
-   [csv2couchdb ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/Mango-information-systems/csv2couchdb){:new_window} - Mango 系统中的 UI，用于将 `csv` 文件导入到 CouchDB/Cloudant。
-   [songlog ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/millayr/songblog){:new_window} - 使用 JQuery 的示例应用程序。
-   [PouchDB 入门指南 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](http://pouchdb.com/getting-started.html){:new_window} - 从浏览器同步到 Cloudant 或 CouchDB 的示例 Todo 应用程序。
-   [locationtracker ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/rajrsingh/locationtracker){:new_window} - 使用 PouchDB、CouchApp 和 Cloudant 记录并映射位置的示例应用程序。

## Ruby

[CouchRest ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/couchrest/couchrest){:new_window} 是 CouchDB 和 Cloudant 客户端，其扩展可利用 [CouchRest 模型 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/couchrest/couchrest_model){:new_window} 与 Rails 搭配使用。

要安装 CouchRest，请运行以下命令：

```sh
gem install couchrest
```
{:codeblock}

### 库和框架

[Ruby 工具箱 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://www.ruby-toolbox.com/categories/couchdb_clients){:new_window} 上列出了多种 CouchDB 客户端。

### 示例和教程

-   [CRUD ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/cloudant/haengematte/tree/master/ruby){:new_window}。

<div id="couchdb"></div>

## Meteor

[cloudant:couchdb ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://atmospherejs.com/cloudant/couchdb){:new_window} 是针对 `couchdb-meteor` 软件包的 Cloudant 库。由于 Apache CouchDB 不随附 Meteor 或 couchdb 软件包，所以在安装 Meteor 之前，必须先提供 Meteor 的 URL 以连接到正在运行的 CouchDB 或 Cloudant 服务器实例。将此软件包添加到 Meteor 应用程序：

```sh
meteor add cloudant:couchdb
```
{:codeblock}

couchdb-meteor 软件包中提供：

-   通过使用 CouchDB `_changes` 订阅源，从数据库进行的实时查询实现和实时更新。
-   分布式数据协议 (DDP) RPC 端点，可从本地连接的客户端更新数据。
-   以 DDP 格式对更新进行的序列化和编组。

>   **注**：Cloudant Query 所使用的、最初由 Cloudant 开发的 JSON 查询语法已重新提供给 Apache CouchDB V2.0。为 Apache CouchDB V2.0 预构建的二进制尚不可用。在预构建二进制可用之前，您可以先搭配使用此模块和 Cloudant DBaaS 或 Cloudant Local。要配置 Apache CouchDB 或 Cloudant 服务器连接信息，请将其 URL 作为 `COUCHDB_URL` 环境变量传递给 Meteor 服务器进程：

```sh
$ export COUCHDB_URL=https://username:password@username.cloudant.com
```
{:codeblock}

有关 meteor-couchdb API 的更多信息，请参阅 [API 参考](../api/index.html)。 

## Apache Spark

[spark-cloudant ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/cloudant-labs/spark-cloudant){:new_window} 是 Apache Spark 的 Cloudant 库。

spark-cloudant 库已装入到 [IBM Bluemix Apache Spark-as-a-Service ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://console.ng.bluemix.net/catalog/services/apache-spark/){:new_window} 产品中。它可以与任何独立的 Spark 集群配合使用。

有关更多详细信息，请参阅[项目信息 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/cloudant-labs/spark-cloudant){:new_window} 和 [Spark 软件包 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://spark-packages.org/package/cloudant-labs/spark-cloudant){:new_window}。
