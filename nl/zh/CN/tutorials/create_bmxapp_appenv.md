---

copyright:
  years: 2017, 2019
lastupdated: "2019-04-02"

keywords: ibm cloud application environment, ibm cloud applications and services, connect, the cloud foundry command toolkits, ibm cloud command toolkits, install the cloud foundry toolkit, install ibm cloud toolkit, the starter application

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

# 创建简单 {{site.data.keyword.cloud_notm}} 应用程序以访问 {{site.data.keyword.cloudant_short_notm}} 数据库：应用程序环境
{: #creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment}

本部分教程描述了如何设置创建 {{site.data.keyword.cloud}} 应用程序所必须拥有的应用程序环境。
{: shortdesc}

## 创建 {{site.data.keyword.cloud_notm}} 应用程序环境
{: #creating-an-ibm-cloud-application-environment}

1.  登录到 {{site.data.keyword.cloud_notm}} 帐户。<br/>
    在以下地址可以找到 {{site.data.keyword.cloud_notm}} 仪表板：[https://cloud.ibm.com/ ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://cloud.ibm.com/){: new_window}。使用用户名和密码进行认证后，将显示 {{site.data.keyword.cloud_notm}} 仪表板。单击菜单中的`目录`：<br/>
    ![{{site.data.keyword.cloud_notm}}“仪表板”](images/img0001.png)

2.  单击`计算`类别：<br/>
    ![{{site.data.keyword.cloud_notm}} Cloud Foundry 应用程序](images/img0012.png)<br/>
    这将显示 {{site.data.keyword.cloud_notm}} 上可用的各种服务和应用程序的列表。

3.  向下滚动到 `Cloud Foundry` 部分，然后单击 `Python` 条目：<br/>
    ![{{site.data.keyword.cloud_notm}} Python 应用程序](images/img0013.png)<br/>
    这将显示`创建 Cloud Foundry 应用程序`表单。

4.  使用`创建 Cloud Foundry 应用程序`表单来指定并创建 Python Cloud Foundry 应用程序的环境。输入应用程序的名称，例如 `Cloudant CF`。系统会自动生成主机名，但您也可以对其进行定制：</br>
    ![{{site.data.keyword.cloud_notm}} Python Cloud Foundry 应用程序名称](images/img0014.png)
    
    主机名在 {{site.data.keyword.cloud_notm}} 域中必须唯一。在此示例中，域为 `mybluemix.net`，因此完整主机名为 `Cloudant-CF-app.mybluemix.net`。
    {: tip}

5.  单击`创建`以创建应用程序环境：</br>
    ![创建 {{site.data.keyword.cloud_notm}} Python Cloud Foundry 应用程序](images/img0015.png)

6.  在短暂停顿后，将显示新应用程序环境的`入门`窗口。测试应用程序会在环境中自动创建。应用程序会自动启动，由绿色图标和`正在运行`状态指示。此应用程序是“脉动信号”程序，足以说明新的应用程序环境已准备就绪，可随时使用。单击 `Cloud Foundry 应用程序`链接以返回到 {{site.data.keyword.cloud_notm}}“仪表板”。<br/>
    ![首次运行的新 {{site.data.keyword.cloud_notm}} Python Cloud Foundry 应用程序](images/img0016.png)

7.  现在，您的资源列表包含新创建的应用程序环境：<br/>
    ![仪表板中显示的基本 {{site.data.keyword.cloud_notm}} Python Cloud Foundry 应用程序](images/img0017.png)

现在，您拥有随时可供使用的 {{site.data.keyword.cloud_notm}} Python 应用程序环境。

要使用 {{site.data.keyword.cloudant_short_notm}} 数据库实例，请在应用程序环境与数据库实例之间创建一个“连接”。

## 连接 {{site.data.keyword.cloud_notm}} 应用程序和服务
{: #connecting-ibm-cloud-applications-and-services}

本部分教程说明了如何使用应用程序的配置和管理区域来连接 {{site.data.keyword.cloud_notm}} 应用程序环境和服务。

1.  在 {{site.data.keyword.cloud_notm}} 仪表板中，转至**菜单**图标 > **资源列表**，并打开服务实例。<br/>
    ![在 {{site.data.keyword.cloud_notm}} 仪表板上选择应用程序](images/img0017.png)</br>
这将显示应用程序的配置和管理概述区域。

2.  要将应用程序环境连接到其他服务，请单击`连接`选择卡：<br/>
    ![为 {{site.data.keyword.cloud_notm}} 应用程序选择连接配置](images/img0019.png)<br/>
这将显示一个区域，用于配置应用程序与您的帐户中可用的其他任何服务之间的连接。

3.  本教程的一个[先决条件](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-prerequisites#prerequisites)是存在现有的 {{site.data.keyword.cloudant_short_notm}} 数据库实例。单击`创建连接`以在该服务实例与应用程序之间建立连接：<br/>
    ![连接到现有数据库实例](images/img0020.png)<br/>
这将显示您帐户中现有服务实例的列表。

4.  单击要使用的 {{site.data.keyword.cloudant_short_notm}} 服务实例。本教程使用的是 `Cloudant-service` 实例：<br/>
    ![选择教程示例数据库实例](images/img0021.png)

5.  系统将要求您确认是否确实要将该数据库实例连接到应用程序。单击`连接`以确认连接：<br>
    ![确认连接到数据库实例](images/img0022.png)

6.  继续之前，系统会要求您定制服务标识和访问角色。单击`连接`以继续。
    ![确认重新编译打包应用程序](images/img0022b.png)

6.  修改应用程序的服务连接会影响其总体配置。修改需要对应用程序“重新编译打包”，此操作还会强制停止运行的应用程序。这将显示一个窗口，供您确认是否已准备好继续执行“重新编译打包”。单击`重新编译打包`以继续：<br/>
    ![确认对应用程序重新编译打包](images/img0023.png)

7.  这将再次显示“服务连接”页面。现在，此页面包含新连接的数据库实例：<br/>
    ![新连接的数据库实例](images/img0024.png)

现在，应用程序环境和数据库实例已连接。下一步是确保安装了使用 {{site.data.keyword.cloud_notm}} 应用程序所必需的工具。

## Cloud Foundry 和 {{site.data.keyword.cloud_notm}} 命令工具箱
{: #the-cloud-foundry-and-ibm-cloud-command-toolkits}

本部分教程描述了必须在使用 {{site.data.keyword.cloud_notm}} 环境、应用程序和服务前安装的工具箱。

[Cloud Foundry ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://en.wikipedia.org/wiki/Cloud_Foundry){: new_window} 工具箱是工具集合，用于操作在 Cloud Foundry 兼容环境中部署的应用程序。使用这些工具可执行各种任务，例如更新部署的应用程序，或启动和停止运行的应用程序。

{{site.data.keyword.cloud_notm}} 工具箱提供了额外的功能，这些功能对于使用在 {{site.data.keyword.cloud_notm}} 环境中托管和运行的应用程序是必需的。

请确保您安装 Cloud Foundry _和_ {{site.data.keyword.cloud_notm}} 工具箱。
{: tip}

下载并安装工具箱是一次性任务。如果工具箱已安装并在系统上正常运行，那么除非工具箱有更新，否则无需再次下载。

有关工具箱的常规信息，请参阅[此处 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](/docs/services/Cloudant?topic=cloudant-getting-started-with-cloudant#getting-started){: new_window}。

### 安装 Cloud Foundry 工具箱
{: #installing-the-cloud-foundry-toolkit}

某些操作系统分发版已经提供了某个版本的 Cloud Foundry 工具箱。如果支持的版本为 6.11 或更高版本，那么工具箱可与 {{site.data.keyword.cloud_notm}} 兼容并正常使用。您可以通过运行以下命令来检查所安装的版本。

或者，使用以下步骤下载并在系统上安装 Cloud Foundry 工具箱： 

1.  单击`入门`以查看有关下载 Cloud Foundry 工具箱的信息。

2.  单击 `CLI`。该链接将使您转至 {{site.data.keyword.cloud_notm}} Developer Tools（CLI 和 Dev Tools）文档。

3.  单击 `Cloud Foundry CLI 插件`，然后单击 `{{site.data.keyword.cloud_notm}} Admin CLI`。 

4.  按照页面上的指示信息下载并运行适合您系统的最新版本安装程序。

5.  要检查是否具有适用的 Cloud Foundry 工具箱，请在提示符处运行以下命令：

    ```sh
    cf --version
    ```
    {: pre}
    
    预期的结果类似于以下输出：
    
    ```
    cf version 6.20.0+25b1961-2016-06-29
    ```
    {:codeblock}
    
    Cloud Foundry 工具箱版本必须为 6.11 或更高版本，才能与 {{site.data.keyword.cloud_notm}} 兼容。
    {: tip}

### 安装 {{site.data.keyword.cloud_notm}} 工具箱
{: #installing-the-ibm-cloud-toolkit}

使用以下步骤下载并在系统上安装 {{site.data.keyword.cloud_notm}} 工具箱。

1.  单击`入门`以查看有关下载 {{site.data.keyword.cloud_notm}} Admin CLI 工具箱的信息。

2.  单击 `CLI` 以打开 [{{site.data.keyword.cloud_notm}} 开发人员工具入门 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://cloud.ibm.com/docs/cli?topic=cloud-cli-ibmcloud-cli#getting-started){: new_window} 文档。

3.  按照页面上的指示信息下载并运行适合您系统的安装程序。

    安装程序将检查以确保安装的是适用版本的 Cloud Foundry 工具箱。如果一切正确，{{site.data.keyword.cloud_notm}} 工具箱将在系统上安装。

4.  要检查是否具有适用的 {{site.data.keyword.cloud_notm}} 工具箱，请在提示符处运行以下命令：
    
    ```sh
    bluemix --version
    ```
    {: pre}
    
    预期的结果类似于以下输出：
    
    ```
    bluemix version 0.4.5+03c29de-2016-12-08T07:01:01+00:00
    ```
    {: codeblock}
    
现在，用于操作 {{site.data.keyword.cloud_notm}} 应用程序的工具已可用。下一步是获取“入门模板”材料，这些材料可帮助您创建 {{site.data.keyword.cloud_notm}} 应用程序。

安装命令行界面后，请返回到仪表板中的`入门`选项卡，以通过命令行界面下载、修改和重新部署 Cloud Foundry 应用程序和服务实例。
{: note}

## `入门模板`应用程序
{: #the-starter-application}

本部分教程描述了 {{site.data.keyword.cloud_notm}} 入门模板应用程序，并说明了如何对其进行定制以访问 {{site.data.keyword.cloudant_short_notm}} 数据库实例。

{{site.data.keyword.cloud_notm}} 入门模板应用程序是创建可正常运行的 {{site.data.keyword.cloud_notm}} 应用程序所必需的源文件和配置文件的最小集合。在某些方面，它类似于[“Hello World”应用程序 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://en.wikipedia.org/wiki/%22Hello,_World!%22_program){: new_window}；但只足以说明基本系统和配置是否运行正常。

{{site.data.keyword.cloud_notm}} 入门模板应用程序是示例文件的归档，您在开发自己的 {{site.data.keyword.cloud_notm}} 应用程序时必须对这些文件进行修改或扩展。

尤其是下面三个文件必不可少：

-   [`Procfile`](#the-procfile-file)
-   [`manifest.yml`](#the-manifest.yml-file)
-   [`requirements.txt`](#the-requirements.txt-file)

### `Procfile` 文件
{: #the-procfile-file}

`Procfile` 包含 {{site.data.keyword.cloud_notm}} 运行应用程序所需的详细信息。

更具体地说，`Procfile` 是一种 Cloud Foundry 工件，用于定义应用程序进程类型以及运行应用程序的命令。[此处 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://docs.cloudfoundry.org/buildpacks/prod-server.html#procfile){: new_window} 提供了有关 `Procfile` 的更多信息。

{{site.data.keyword.cloud_notm}} Python 入门模板应用程序的 `Procfile` 类似于以下示例：

```
web: python server.py
```
{: codeblock}

此示例指示应用程序是一个 Python Web 应用程序，可通过运行以下命令启动：

```sh
python server.py
```
{: codeblock}

入门模板应用程序归档中包含入门模板 `server.py` Python 源文件。`server.py` 文件针对您的应用程序进行了修改。或者，创建一个全新的 Python 源文件。然后，更新 `Procfile`，以便在应用程序启动时使用新文件。

### `manifest.yml` 文件
{: #the-manifest.yml-file}

`manifest.yml` 文件是应用程序及其运行所需的环境的完整描述。

{{site.data.keyword.cloud_notm}} Python 入门模板应用程序的该文件类似于以下示例：

```
applications:
- path: .
  memory: 128M
  instances: 1
  domain: mybluemix.net
  name: Cloudant Python
  host: Cloudant-Python
  disk_quota: 1024M
  services:
  - Cloudant Service 2017
```
{: codeblock}

以下三点值得注意：

-   `domain`、`name` 和 `host` 值对应于您在[创建](#creating-an-ibm-cloud-application-environment) {{site.data.keyword.cloud_notm}} 应用程序时输入的值。
-   `name` 值由 Cloud Foundry 工具箱用于确定要管理的应用程序。
-   `services` 值确认 {{site.data.keyword.cloudant_short_notm}} 数据库实例 `Cloudant Service 2017` 是否已连接到应用程序环境。

通常无需修改 `manifest.yml` 文件，但是应当了解为什么必须存在此文件，应用程序才能正常运行。

### `requirements.txt` 文件
{: #the-requirements.txt-file}

`requirements.txt` 文件指定应用程序正常运行所需的其他任何组件。

在入门模板应用程序中，`requirements.txt` 文件为空。

但是，在本教程中，Python 应用程序会访问 {{site.data.keyword.cloudant_short_notm}} 数据库实例。因此，应用程序必须能够使用 [{{site.data.keyword.cloudant_short_notm}} Python 应用程序的客户机库](/docs/services/Cloudant?topic=cloudant-supported-client-libraries#python-supported)。

要启用 Python 客户机库，请修改 `requirements.txt` 文件以包含以下文本：​​​ 
```
cloudant==2.3.1
```
{: codeblock}

本教程中的下一步是[创建应用程序](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment)。
