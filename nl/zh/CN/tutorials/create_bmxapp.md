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

<!-- Acrolinx: 2017-01-10 -->

# 创建简单 {{site.data.keyword.Bluemix_notm}} 应用程序以访问 {{site.data.keyword.cloudant_short_notm}} 数据库

本教程说明了如何创建 {{site.data.keyword.Bluemix}} 应用程序，以使用 [Python 编程语言![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://www.python.org/){:new_window} 来访问{{site.data.keyword.Bluemix_notm}} 服务实例中托管的 {{site.data.keyword.cloudantfull}} 数据库。
{:shortdesc}

## 上下文

{{site.data.keyword.Bluemix_notm}} 的一个重大优势是可以在 {{site.data.keyword.Bluemix_notm}} 自身中创建和部署应用程序。您不必去寻找并维护服务器来运行应用程序。

如果您已经在 {{site.data.keyword.Bluemix_notm}} 中使用 {{site.data.keyword.cloudant_short_notm}} 数据库实例，那么也可以在其中使用应用程序。

{{site.data.keyword.Bluemix_notm}} 应用程序通常是使用 [Cloud Foundry ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://en.wikipedia.org/wiki/Cloud_Foundry){:new_window} 技术创建的。Cloud Foundry 提供了平台即服务 (PaaS) 功能，用于简化可在云环境中部署和运行的应用程序的创建过程。

[单独的教程](create_database.html)说明了如何创建独立 Python 应用程序以在 {{site.data.keyword.Bluemix_notm}} 中使用 {{site.data.keyword.cloudant_short_notm}} 数据库实例。在本教程中，您将设置并创建在 {{site.data.keyword.Bluemix_notm}} 中托管的小型 Python 应用程序。应用程序将连接到 {{site.data.keyword.cloudant_short_notm}} 数据库实例，并创建单个简单文档。

本教程中提供了特定于每个任务的 Python 代码。教程[此处](create_bmxapp_createapp.html#complete-listing)提供了完整的 Python 程序，充分演示了这些概念。

我们没有尝试为本教程创建_高效_ Python 代码；本教程的目的是为了说明简单易懂的有效代码，方便您从中学习并应用于自己的应用程序。

此外，我们也未尝试解决所有可能的检查或错误条件。教程中包含一些示例检查，用于说明某些方法，但您应该应用标准最佳实践来检查和处理自己的应用程序遇到的所有警告或错误条件。

## 任务概述

要在 {{site.data.keyword.Bluemix_notm}} 上创建可以访问 {{site.data.keyword.cloudant_short_notm}} 数据库实例的适用 Python 应用程序，需要执行以下任务：

-   [在 {{site.data.keyword.Bluemix_notm}} 上创建 Python 应用程序环境](create_bmxapp_appenv.html#creating)。
-   [确保 Python 应用程序环境具有与 {{site.data.keyword.cloudant_short_notm}} 数据库实例的“连接”](create_bmxapp_appenv.html#connecting)。
-   [（一次性任务）下载并安装 Cloud Foundry 和 {{site.data.keyword.Bluemix_notm}} 命令行工具箱](create_bmxapp_appenv.html#toolkits)。
-   [下载“入门模板”应用程序](create_bmxapp_appenv.html#starter)。
-   [定制入门模板应用程序，以创建自己的应用程序来访问 {{site.data.keyword.cloudant_short_notm}} 数据库实例](create_bmxapp_createapp.html#theApp)。
-   [上传应用程序并测试其是否正常运行](create_bmxapp_upload.html#uploading)。
-   [执行基本应用程序维护任务](create_bmxapp_maintain.html#maintenance)。
-   [诊断并解决问题（故障诊断）](create_bmxapp_maintain.html#troubleshooting)。

## 教程结构

本教程由五个部分组成：

1.  [先决条件](create_bmxapp_prereq.html)
2.  [应用程序环境](create_bmxapp_appenv.html)
3.  [创建应用程序](create_bmxapp_createapp.html)
4.  [上传和运行应用程序](create_bmxapp_upload.html)
5.  [应用程序维护和故障诊断](create_bmxapp_maintain.html)

## 下一步

要开始使用本教程，请首先[检查先决条件](create_bmxapp_prereq.html)。
