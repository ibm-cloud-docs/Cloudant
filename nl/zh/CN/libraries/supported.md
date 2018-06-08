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

# 支持的客户端库

## 移动设备

{{site.data.keyword.cloudantfull}} Sync 库用于在移动设备上存储和查询本地 JSON 数据以及对其建立索引。该库也用于在多个设备之间同步数据。同步是由应用程序控制的。该库还提供帮助程序方法，可用于在本地设备和远程数据库中发现并解决冲突。

可用版本有两个：

-   [{{site.data.keyword.cloudant_short_notm}} Sync - Android / JavaSE ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/cloudant/sync-android){:new_window}。
-   [{{site.data.keyword.cloudant_short_notm}}Cloudant Sync - iOS (CDTDatastore) ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/cloudant/CDTDatastore){:new_window}。

提供了 {{site.data.keyword.cloudant_short_notm}} Sync 的[概述 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://cloudant.com/product/cloudant-features/sync/){:new_window}。此外，还提供了 {{site.data.keyword.cloudant_short_notm}} Sync [资源 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://cloudant.com/cloudant-sync-resources/){:new_window} 的详细信息。

## Java

[java-cloudant ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/cloudant/java-cloudant){:new_window} 是 Java 的官方 {{site.data.keyword.cloudantfull}} 库。

有关通过将该库添加为 Maven 或 Gradle 构建依赖项来进行安装的信息在[此处 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/cloudant/java-cloudant#installation-and-usage){:new_window} 提供，此外还提供了关于如何使用该库的详细信息和示例。

### 库和框架

#### 受支持的

-   [java-cloudant ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/cloudant/java-cloudant){:new_window}。

#### 不受支持的

-   [ektorp ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](http://ektorp.org/){:new_window}。
-   [jcouchdb ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](http://code.google.com/p/jcouchdb/){:new_window}。
-   [jrelax ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/isterin/jrelax){:new_window}。
-   [LightCouch ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](http://www.lightcouch.org/){:new_window}。
-   [Java {{site.data.keyword.cloudant_short_notm}} Web Starter ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://ace.ng.bluemix.net/#/store/cloudOEPaneId=store&appTemplateGuid=CloudantJavaBPTemplate&fromCatalog=true){:new_window} - Bluemix 的样板。

### 示例和教程

-   对 HTTP 和 JSON 库执行[创建、读取、更新和删除 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/cloudant/haengematte/tree/master/java){:new_window}。
-   对 ektorp 库执行[创建、读取、更新和删除 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/cloudant/haengematte/tree/master/java/CrudWithEktorp){:new_window}。
-   [在 IBM Bluemix 上使用 Java 和 {{site.data.keyword.cloudant_short_notm}} 构建应用程序 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://cloudant.com/blog/building-apps-using-java-with-cloudant-on-ibm-bluemix/){:new_window}。
-   [使用 Liberty、{{site.data.keyword.cloudant_short_notm}} 和 Single Sign On 构建游戏应用程序 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](http://www.ibm.com/developerworks/cloud/library/cl-multiservicegame-app/index.html?ca=drs-){:new_window} Bluemix 示例。
-   [在 IBM Bluemix 上使用 Watson 和 {{site.data.keyword.cloudant_short_notm}} 构建 Java EE 应用程序 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://developer.ibm.com/bluemix/2014/10/17/building-java-ee-app-ibm-bluemix-using-watson-cloudant/){:new_window} Bluemix 示例以及 [YouTube 视频 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://www.youtube.com/watch?feature=youtu.be&v=9AFMY6m0LIU&app=desktop){:new_window}。


## Node.js

[nodejs-cloudant ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/cloudant/nodejs-cloudant){:new_window} 是 Node.js 的官方 {{site.data.keyword.cloudant_short_notm}} 库。可以使用 npm 进行安装：

```sh
npm install cloudant
```
{:codeblock}

### 库和框架

#### 受支持的

-   [nodejs-cloudant ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/cloudant/nodejs-cloudant){:new_window} ([npm ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://www.npmjs.org/package/cloudant){:new_window})。

#### 不受支持的

-   [sag-js ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/sbisbee/sag-js){:new_window}，也可在浏览器中使用。有关更多详细信息，请参阅 [saggingcouch ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/sbisbee/saggingcouch.com){:new_window}。
-   [nano ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/dscape/nano){:new_window} 是一种极简实现。
-   [restler ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/danwrong/restler){:new_window} 提供了最佳性能，但实际上只有基本功能。
-   [cradle ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/flatiron/cradle){:new_window} 是一种高级别客户端。如果您觉得使用方便至关重要，即使降低性能也无所谓，那么也可以使用此客户端。
-   [cane_passport ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/ddemichele/cane_passport){:new_window} - 具有引导程序的 {{site.data.keyword.cloudant_short_notm}} Angular Node Express。
-   [express-cloudant ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/cloudant-labs/express-cloudant){:new_window} - Node.js Express 框架的模板，也使用 PouchDB 和 Grunt。
-   [Node.js {{site.data.keyword.cloudant_short_notm}} DB Web Starter ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://ace.ng.bluemix.net/#/store/cloudOEPaneId=store&appTemplateGuid=nodejscloudantbp&fromCatalog=true){:new_window} - Bluemix 的样板。
-   [Mobile Cloud ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://ace.ng.bluemix.net/#/store/cloudOEPaneId=store&appTemplateGuid=mobileBackendStarter&fromCatalog=true){:new_window} - Bluemix 的样板（Node.js、Security、Push 和 Mobile Data/{{site.data.keyword.cloudant_short_notm}}）。

### 示例和教程

-   [创建、读取、更新和删除 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/cloudant/haengematte/tree/master/nodejs){:new_window}。
-   [Cloudant-Uploader ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/garbados/Cloudant-Uploader){:new_window} - 用于将 `.csv` 文件上传到 {{site.data.keyword.cloudant_short_notm}} 的实用程序。
-   [couchimport ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/glynnbird/couchimport){:new_window} - 用于将 `.csv` 或 `.tsv` 文件导入到 CouchDB 或 {{site.data.keyword.cloudant_short_notm}} 的实用程序。
-   [{{site.data.keyword.Bluemix}} 和 Node.js 入门 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](http://thoughtsoncloud.com/2014/07/getting-started-ibm-bluemix-node-js/){:new_window}。
-   [{{site.data.keyword.Bluemix_notm}}、{{site.data.keyword.cloudant_short_notm}} 和 Node.js 的混合云 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://gigadom.wordpress.com/2014/08/15/a-cloud-medley-with-ibm-bluemix-cloudant-db-and-node-js/){:new_window}。
-   [使用 {{site.data.keyword.cloudant_short_notm}} on {{site.data.keyword.Bluemix_notm}} 构建简单字游戏应用程序 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](http://www.ibm.com/developerworks/cloud/library/cl-guesstheword-app/index.html?ca=drs-){:new_window} - 使用 Node.js。
-   [构建实时 SMS 投票应用程序 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://www.twilio.com/blog/2012/09/building-a-real-time-sms-voting-app-part-1-node-js-couchdb.html){:new_window} - 使用 Node.js、Twilio 和 {{site.data.keyword.cloudant_short_notm}} 的六部分序列。
-   [构建多层 Windows Azure Web 应用程序 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](http://msopentech.com/blog/2013/12/19/tutorial-building-multi-tier-windows-azure-web-application-use-cloudants-couchdb-service-node-js-cors-grunt-2/){:new_window} - 使用 {{site.data.keyword.cloudant_short_notm}}、Node.js、CORS 和 Grunt。
-   [自己动手：使用 {{site.data.keyword.Bluemix_notm}}、{{site.data.keyword.cloudant_short_notm}} 和 Raspberry Pi 构建远程监控应用程序。![外部链接图标](../images/launch-glyph.svg "外部链接图标")](http://www.ibm.com/developerworks/library/ba-remoteservpi-app/index.html){:new_window}。

## Python

通过 Python 使用 {{site.data.keyword.cloudant_short_notm}} 时受支持的库在[此处 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/cloudant/python-cloudant){:new_window} 提供。

>   **注：**访问 {{site.data.keyword.cloudant_short_notm}} 的 Python 应用程序具有组件依赖项。这些依赖项必须在 `requirements.txt` 文件中指定。有关更多信息，请参阅[此处 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://pip.readthedocs.io/en/1.1/requirements.html){:new_window}。

在[此处 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://pypi.python.org/pypi/cloudant/){:new_window} 下载当前库发行版。要了解有关 Python 语言的更多信息，请访问：[python.org ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://www.python.org/about/){:new_window}。 

## Swift

有一个受支持的库可用于 {{site.data.keyword.cloudant_short_notm}}。该库名为 Swift{{site.data.keyword.cloudant_short_notm}}，并使用 `cocoapods` 进行安装。

podfile 条目为：

```sh
pod 'SwiftCloudant'
```
{:codeblock}

有关 SwiftCloudant 的更多信息（包括安装详细信息，还有如何使用该库在 {{site.data.keyword.cloudant_short_notm}} 上存储和查询远程 JSON 数据以及对其建立索引）在[此处 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/cloudant/swift-cloudant){:new_window} 提供。

该库是较早的发行版。因此，它当前尚不具备完全的 {{site.data.keyword.cloudant_short_notm}} API 覆盖范围。 

>   **注**：iOS 上不支持 SwiftCloudant，因此无法通过 Objective-C 对其进行调用。
