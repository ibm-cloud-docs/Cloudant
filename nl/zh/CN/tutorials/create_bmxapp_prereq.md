---

copyright:
  years: 2017, 2019
lastupdated: "2019-06-12"

keywords: python, create service instance, create stand-alone python application

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

# 创建简单 {{site.data.keyword.cloud_notm}} 应用程序以访问 {{site.data.keyword.cloudant_short_notm}} 数据库：先决条件
{: #creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-prerequisites}

本部分教程描述了创建 {{site.data.keyword.cloud}} 应用程序的先决条件。
{: shortdesc}

## 先决条件
{: #prerequisites-create_bmxapp_prereq}

在开始学习本教程之前，请确保以下资源或信息已准备就绪。

### Python
{: #python-create-bmxapp-prereq}

如果在系统上安装了 [Python 编程语言 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://www.python.org/){: new_window}，除了最简单的开发工作以外，其他所有开发工作都会轻松得多。

要检查 Python，请在提示符处运行以下命令：

```sh
python --version
```
{: pre}

预期的结果类似于以下输出：

```
Python 2.7.12
```
{: codeblock}

### {{site.data.keyword.cloud_notm}} 上的 {{site.data.keyword.cloudant_short_notm}} 服务实例
{: #an-ibm-cloudant-service-instance-on-ibm-cloud}

有关[在 {{site.data.keyword.cloud_notm}} 上创建 {{site.data.keyword.cloudantfull}} 服务实例](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud#creating-an-ibm-cloudant-instance-on-ibm-cloud)的单独教程将创建名为“`Cloudant-o7`”的服务实例。 

此教程假定您已创建名为“`Cloudant-o7`”的服务实例。

### {{site.data.keyword.cloudant_short_notm}} 数据库应用程序
{: #an-ibm-cloudant-database-application}

另外还提供了有关[创建独立 Python 应用程序以使用 {{site.data.keyword.cloudant_short_notm}} 服务实例](/docs/services/Cloudant?topic=cloudant-creating-and-populating-a-simple-ibm-cloudant-database-on-ibm-cloud#creating-and-populating-a-simple-ibm-cloudant-database-on-ibm-cloud)的单独教程。该教程介绍了许多概念，对于了解如何创建和填充 {{site.data.keyword.cloudant_short_notm}} 数据库很有用。

本教程假定您熟悉这些概念。

本教程中的下一步是[创建应用程序环境](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment)。
