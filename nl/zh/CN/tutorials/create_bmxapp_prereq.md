---

copyright:
  years: 2017, 2018
lastupdated: "2018-10-24"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:tip: .tip}

<!-- Acrolinx: 2017-05-10 -->

# 创建简单 {{site.data.keyword.cloud_notm}} 应用程序以访问 {{site.data.keyword.cloudant_short_notm}} 数据库：先决条件

本部分教程描述了创建 {{site.data.keyword.cloud}} 应用程序的先决条件。
{:shortdesc}

## 先决条件

在开始学习本教程之前，请确保以下资源或信息已准备就绪。

### Python

如果在系统上安装了 [Python 编程语言 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://www.python.org/){:new_window}，除了最简单的开发工作以外，其他所有开发工作都会轻松得多。

要检查 Python，请在提示符处运行以下命令：

```sh
python --version
```
{:pre}

预期的结果类似于以下输出：

```
Python 2.7.12
```
{:codeblock}

<div id="csi"></div>

### {{site.data.keyword.cloud_notm}} 上的 {{site.data.keyword.cloudant_short_notm}} 服务实例

[此处](create_service.html)提供了用于创建名为“`Cloudant Service 2017`”的 {{site.data.keyword.cloudantfull}} 服务实例的单独教程。

此教程假定您已创建名为“`Cloudant Service 2017`”的服务实例。

### {{site.data.keyword.cloudant_short_notm}} 数据库应用程序

[此处](create_database.html)提供了用于创建独立 Python 应用程序以与 {{site.data.keyword.cloudant_short_notm}} 服务实例配合使用的单独教程。该教程介绍了许多概念，对于了解如何创建和填充 {{site.data.keyword.cloudant_short_notm}} 数据库很有用。

本教程假定您熟悉这些概念。

## 下一步

本教程中的下一步是[创建应用程序环境](create_bmxapp_appenv.html)。
