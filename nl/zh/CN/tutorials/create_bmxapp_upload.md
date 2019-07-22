---

copyright:
  years: 2017, 2019
lastupdated: "2019-06-12"

keywords: connect to ibm cloud, upload application, test sample application, confirm database details

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

# 创建简单 {{site.data.keyword.cloud_notm}} 应用程序以访问 {{site.data.keyword.cloudant_short_notm}} 数据库：上传应用程序
{: #creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-uploading-the-application}

本部分教程描述了如何上传 {{site.data.keyword.cloud}} 应用程序。
{: shortdesc}

## 连接到 {{site.data.keyword.cloud_notm}}
{: #connecting-to-ibm-cloud}

第一个任务是连接到 {{site.data.keyword.cloud_notm}}。

{{site.data.keyword.cloud_notm}} CLI 需要知道要用于发出 API 调用的 URL。例如，上传应用程序时，{{site.data.keyword.cloud_notm}} 工具箱使用 `ibmcloud api` 命令来管理 API 端点。有关 `ibmcloud api` 命令的更多信息，请参阅 [ {{site.data.keyword.cloud_notm}} CLI 入门 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://cloud.ibm.com/docs/cli?topic=cloud-cli-ibmcloud-cli){: new_window}。

使用以下命令通知 Cloud Foundry 要使用的 URL：

```sh
ibmcloud api https://api.ng.bluemix.net
```
{: pre}

预期的结果类似于以下输出：

```
Invoking 'cf api https://api.ng.bluemix.net'...

Setting api endpoint to https://api.ng.bluemix.net...
OK

API endpoint:   https://api.ng.bluemix.net
API version:    2.54.0
Not logged in. Use 'ibmcloud login' to log in.
```
{: codeblock}

现在，Cloud Foundry 知道在何处发送用于管理应用程序的 API 调用。

下一步是登录到 {{site.data.keyword.cloud_notm}} 应用程序环境。必须提供以下帐户详细信息：

-   您的用户名，指定为“`-u`”参数。
-   您的组织名称，指定为“`-o`”参数。
-   您的空间，指定为“`-s`”参数。

  通过 Web 浏览器登录时，帐户详细信息会在 {{site.data.keyword.cloud_notm}}“仪表板”上提供，如以下示例所示：
  {: tip}

  ![查找 {{site.data.keyword.cloud_notm}} 帐户详细信息](images/img0035.png)

使用类似于以下示例的命令登录到 {{site.data.keyword.cloud_notm}} 应用程序环境。请注意，系统会要求您输入帐户密码。

```sh
ibmcloud login -u Adrian.Warman@uk.ibm.com -o Adrian.Warman@uk.ibm.com -s dev
```
{: pre}

预期的结果类似于以下输出：

```
Invoking 'cf login -u Adrian.Warman@uk.ibm.com -o Adrian.Warman@uk.ibm.com -s dev'...

API endpoint: https://api.ng.bluemix.net

Password> 
Authenticating...
OK

Targeted org Adrian.Warman@uk.ibm.com

Targeted space dev
                
API endpoint:   https://api.ng.bluemix.net (API version: 2.54.0)
User:           adrian.warman@uk.ibm.com
Org:            Adrian.Warman@uk.ibm.com
Space:          dev
```
{: codeblock}

## 上传应用程序
{: #uploading-the-application}

现在，{{site.data.keyword.cloudant_short_notm}} Foundry 工具箱知道如何连接到 {{site.data.keyword.cloud_notm}} 环境。

下一步是上传应用程序本身。在[清单文件](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#the-manifest.yml-file)中提供了 {{site.data.keyword.cloud_notm}} 应用程序的详细信息。

使用类似于以下示例的命令登录，以上传 {{site.data.keyword.cloud_notm}} 应用程序。

```sh
cf push "Cloudant Python"
```
{: pre}

这将显示一系列结果消息。

```
Using manifest file /..../BMXDemo/manifest.yml

Updating app {{site.data.keyword.cloudant_short_notm}} Python in org Adrian.Warman@uk.ibm.com / space dev as Adrian.Warman@uk.ibm.com...
OK
```
{: codeblock}

Cloud Foundry 工具箱已找到清单文件，正在准备使用您[先前](#uploading-the-application)提供的连接和标识详细信息来上传应用程序。

```
Using route Cloudant-Python.mybluemix.net
Uploading Cloudant Python...
Uploading app files from: /..../BMXDemo
Uploading 1.5K, 3 files
Done uploading               
OK
Binding service {{site.data.keyword.cloudant_short_notm}} Service 2017 to app {{site.data.keyword.cloudant_short_notm}} Python in org Adrian.Warman@uk.ibm.com / space dev as Adrian.Warman@uk.ibm.com...
OK
```
{: codeblock}

应用程序已成功上传，并与 {{site.data.keyword.cloudant_short_notm}} 数据库实例建立了连接。

```
Starting app {{site.data.keyword.cloudant_short_notm}} Python in org Adrian.Warman@uk.ibm.com / space dev as Adrian.Warman@uk.ibm.com...
-----> Downloaded app package (4.0K)
-----> Downloaded app buildpack cache (29M)
-------> Buildpack version 1.5.5
     $ pip install -r requirements.txt
DEPRECATION: --allow-all-external has been deprecated and will be removed in the future. Due to changes in the repository protocol, it no longer has any effect.
       Collecting cloudant==2.3.1 (from -r requirements.txt (line 1))
         Downloading cloudant-2.3.1-py2-none-any.whl (63kB)
       Collecting requests<3.0.0,>=2.7.0 (from cloudant==2.3.1->-r requirements.txt (line 1))
         Downloading requests-2.12.4-py2.py3-none-any.whl (576kB)
       Installing collected packages: requests, cloudant
       Successfully installed cloudant-2.3.1 requests-2.12.4
You are using pip version 8.1.1, however version 9.0.1 is available.
You should consider upgrading via the 'pip install --upgrade pip' command.
You are using pip version 8.1.1, however version 9.0.1 is available.
You should consider upgrading via the 'pip install --upgrade pip' command.
-----> Uploading droplet (30M)

0 of 1 instances running, 1 starting
1 of 1 instances running

App started


OK

App {{site.data.keyword.cloudant_short_notm}} Python was started using this command `python server.py`
```
{: codeblock}

应用程序会自动启动。在启动过程中，会通过评估 [requirements.txt 文件](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#the-requirements.txt-file)的内容来进行检查，以确保满足所有需求。

上传并启动应用程序后，会运行一些简单的系统检查，以确认对于 {{site.data.keyword.cloud_notm}} 而言应用程序是否运行正常。

```
Showing health and status for app {{site.data.keyword.cloudant_short_notm}} Python in org Adrian.Warman@uk.ibm.com / space dev as Adrian.Warman@uk.ibm.com...
OK

requested state: started
instances: 1/1
usage: 128M x 1 instances
urls: Cloudant-Python.mybluemix.net
last uploaded: Thu Dec 22 15:58:18 UTC 2016
stack: cflinuxfs2
buildpack: python 1.5.5

     state     since                    cpu    memory          disk           details
#0   running   2016-12-22 03:59:21 PM   0.0%   49.9M of 128M   110.6M of 1G
```
{: codeblock}

## 测试样本应用程序
{: #testing-the-sample-application}

现在，测试应用程序并验证它是否正常运行。 

1.  从 {{site.data.keyword.cloud_notm}} 仪表板，转至**菜单**图标 > **资源列表**，并打开应用程序。在“Cloud Foundry 应用程序”下，单击 `Cloudant CF 应用程序`以打开详细信息页面。<br/>  
![显示应用程序的仪表板的屏幕快照](images/img0017.png)

2.  在 `Cloudant CF 应用程序`详细信息页面上，单击`路径`，然后单击 `Cloudant-CF-app.mybluemix.net` 链接。<br/>
![Cloudant CF 应用程序详细信息页面](images/img0030.png)

3. 这将打开一个新的浏览器窗口，网址为：`https://cloudant-cf-app.mybluemix.net/`。通过验证是否显示消息“Hello World! 感谢创建 Python 入门模板应用程序。”，可确定应用程序是否正在运行：<br/>
![Hello World! 验证 Cloudant CF 应用程序是否运行正常](images/img0054.png)


### 确认数据库详细信息
{: #confirming-the-database-details}

从 {{site.data.keyword.cloud_notm}} 仪表板，转至**菜单**图标 > **资源列表**，并打开服务实例。转至`管理`选项卡，然后单击`启动 Cloudant 仪表板`。<br/>
![在 {{site.data.keyword.cloudant_short_notm}} 服务页面上启动 Cloudant“仪表板”](images/img0036.png)

要找到 {{site.data.keyword.cloudant_short_notm}} 服务页面，请参阅[“创建 {{site.data.keyword.cloudant_short_notm}} 实例”教程](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud#locating-your-service-credentials)中的详细信息。
{: note}

打开仪表板后，可以看到应用程序已创建“`databasedemo`”数据库：<br/>
![显示新数据库的 {{site.data.keyword.cloudant_short_notm}}“仪表板”](images/img0031.png)

该数据库包含由应用程序创建的单个文档。要验证该文档是否存在，请单击仪表板中该数据库的名称。这将显示该数据库的选项列表。选择`所有文档`选项卡时，将显示单个文档的详细信息：<br/>
![新数据库中的单个文档](images/img0032.png)

要查看文档内容，请单击显示为画笔图像的`编辑`图标：<br/>
![文档的详细信息](images/img0033.png)

显示文档内容时，可以看到教程应用程序创建的每个字段。<br/>
![文档中的字段](images/img0034.png)<br/>
请特别注意包含文档创建日期和时间的 `rightNow` 字段。此值对应于在[应用程序日志文件](#testing-the-sample-application)中记录的相应时间。

本教程中的下一步是[操作和维护应用程序](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-maintaining-and-troubleshooting#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-maintaining-and-troubleshooting)，例如启动、停止和调试应用程序。
