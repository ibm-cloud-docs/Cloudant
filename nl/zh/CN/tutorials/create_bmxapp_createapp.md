---

copyright:
  years: 2017, 2019
lastupdated: "2019-04-02"

keywords: create application, complete python program, log files, work with ibm cloudant database instance

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

# 创建简单 {{site.data.keyword.cloud_notm}} 应用程序以访问 {{site.data.keyword.cloudant_short_notm}} 数据库：代码
{: #creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-code}

本部分教程描述了 {{site.data.keyword.cloud}} 应用程序的代码。
{: shortdesc}

## 创建应用程序
{: #creating-your-application}

现在，以下组件已准备就绪，可以随时开始创建应用程序：

-   [Python 编程语言](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-prerequisites#python-create-bmxapp-prereq)。
-   [{{site.data.keyword.cloudant_short_notm}} 数据库实例](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-prerequisites#an-ibm-cloudant-database-application)。
-   [{{site.data.keyword.cloud_notm}} 应用程序环境](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#creating-an-ibm-cloud-application-environment)。
-   {{site.data.keyword.cloudant_short_notm}} 数据库实例与 {{site.data.keyword.cloud_notm}} 应用程序环境之间的[连接](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#connecting-ibm-cloud-applications-and-services)。
-   用于管理基于 Cloud Foundry 的 {{site.data.keyword.cloud_notm}} 应用程序的[工具箱](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#the-cloud-foundry-and-ibm-cloud-command-toolkits)。
-   [“入门模板”应用程序包](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#the-starter-application)，其中包含初始配置和代码模板文件。

没有尝试为本教程创建_高效_的 Python 代码。本教程的目的是为了说明简单易懂的有效代码，方便您从中学习并应用于自己的应用程序。此外，我们也未尝试解决所有可能的检查或错误条件。教程中包含一些示例检查，用于说明某些方法。请检查并处理您应用程序中的所有警告或错误条件。

{: tip}


### 基本文件
{: #essential-files}

应用程序需要三个配置文件和一个源文件，[`入门模板`应用程序包](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#the-starter-application)中提供了所有这些文件：
 
-   [`Procfile`](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#the-procfile-file)
-   [`manifest.yml`](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#the-manifest.yml-file)
-   [`requirements.txt`](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#the-requirements.txt-file)
-   应用程序源文件，在本部分教程中对其进行了描述。

按如下所示，修改配置文件：

1.  编辑“`Procfile`”文件，使其包含以下文本：
    ```
    web: python server.py
    ```
    {: codeblock}

2.  编辑“`manifest.yml`”文件，使其包含以下文本：
    ```
    applications:
    - path: .
      memory: 128M
      instances: 1
      domain: <your domain>
      name: <your application name>
      host: <your application host>
      disk_quota: 1024M
      services:
      - <your database instance>
    ```
    {: codeblock}

确保修改“`domain`”、“`name`”、“`host`”和“`services`”值。这些是您在创建 [{{site.data.keyword.cloud_notm}} 应用程序环境](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#creating-an-ibm-cloud-application-environment)和 [{{site.data.keyword.cloudant_short_notm}} 数据库实例](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-prerequisites#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-prerequisites)时输入的值。
{: note}

3.  编辑“`requirements.txt`”文件，使其包含以下文本：
    ```
    cloudant==2.3.1
    ```
    {: codeblock}

### 应用程序代码
{: #the-application-code}

下一步是使用应用程序代码。下面描述了每个部分，并提供了相应代码。应用程序代码的[完整列表](#complete-python-program)位于本部分教程末尾。

#### 入门
{: #getting-started-create_bmxapp_createapp}

Python 应用程序需要一些基本组件才能运行。按如下所示，导入这些组件：

```python
# Make Python modules available.
import os
import json

# It is helpful to have access to tools
# for formatting date and time values.
from time import gmtime, strftime
```
{: codeblock}

应用程序作为简单的 Web 服务器运行，并仅显示一个页面：即包含连接到 {{site.data.keyword.cloudant_short_notm}} 数据库实例和创建数据库的结果的日志。

应用程序需要用于提供 Web 页面的组件：

```python
# Simplify access to basic Python web server tools.
try:
    from SimpleHTTPServer import SimpleHTTPRequestHandler as Handler
    from SocketServer import TCPServer as Server
except ImportError:
    from http.server import SimpleHTTPRequestHandler as Handler
    from http.server import HTTPServer as Server
```
{: codeblock}

此代码段作为[“入门模板”应用程序包](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#the-starter-application)的一部分提供。
{: note}

因为应用程序连接到 {{site.data.keyword.cloudant_short_notm}} 数据库实例，所以必须导入 {{site.data.keyword.cloudant_short_notm}} Library 组件：

```python
# Enable the required Python libraries for working with {{site.data.keyword.cloudant_short_notm}}.
from cloudant.client import Cloudant
from cloudant.error import CloudantException
from cloudant.result import Result, ResultByKey
```
{: codeblock}

应用程序在 {{site.data.keyword.cloudant_short_notm}} 数据库实例中创建数据库。数据库名称是必需的：

```python
# This is the name of the database we intend to create.
databaseName = "databasedemo"
```
{: codeblock}

应用程序在连接到 {{site.data.keyword.cloudant_short_notm}} 数据库实例并创建数据库时记录进度。记录采用日志文件的形式，该文件会存储在可由 Python Web 服务器访问的文件夹中。

创建文件夹（在应用程序中名为“`static`”），并准备好在其中存储文件：

```python
# Change current directory to avoid exposure of control files
try:
    os.mkdir('static')
except OSError:
    # The directory already exists,
    # no need to create it.
    pass
os.chdir('static')
```
{: codeblock}

接下来，创建一个简单的 HTML 文件。该文件将包含应用程序创建数据库时每个活动的日志：

```python
# Begin creating a very simple web page.
filename = "index.html"
target = open(filename, 'w')
target.truncate()
target.write("<html><head><title>{{site.data.keyword.cloudant_short_notm}} Python Demo</title></head><body><p>Log of Cloudant Python steps...</p><pre>")
```
{: codeblock}

日志的第一部分是当前日期和时间的记录。此记录可帮助确认数据库是否真是新创建的：

```python
# Put a clear indication of the current date and time at the top of the page.
target.write("====\n")
target.write(strftime("%Y-%m-%d %H:%M:%S", gmtime()))
target.write("\n====\n\n")
```
{: codeblock}

#### 使用 {{site.data.keyword.cloudant_short_notm}} 数据库实例
{: #working-with-the-ibm-cloudant-database-instance}

Python 应用程序在 {{site.data.keyword.cloud_notm}} 应用程序环境中运行。该环境提供了应用程序用于访问已连接服务的所有必要信息。这些信息在名为“`VCAP_SERVICES`”的环境变量中提供。此变量可由应用程序访问，并用于确定连接详细信息。

第一个任务是确保应用程序在 {{site.data.keyword.cloud_notm}} 应用程序环境中运行。通过测试来检查是否存在“`VCAP_SERVICES`”环境变量：

```python
# Check that we are running in an {{site.data.keyword.cloud_notm}} application environment.
if 'VCAP_SERVICES' in os.environ:
```
{: codeblock}

仅当找到该环境变量时，才会运行代码的后续部分。在 Python 中，此代码会缩进，以指示其是测试的主体。在本教程中，省略了代码段中的缩进以节省空间。但是，[完整列表](#complete-python-program)正确显示了缩进。
{: note}

假定找到了该变量，将继续使用其中的信息。首先装入变量中存储的 JSON 数据，然后在新的“日志文件”中记录事件：

```python
# Yes we are, so get the service information.
vcap_servicesData = json.loads(os.environ['VCAP_SERVICES'])
# Log the fact that we successfully found some service information.
target.write("Got vcap_servicesData\n")
```
{: codeblock}

接下来，查找有关已连接 {{site.data.keyword.cloudant_short_notm}} 数据库实例的信息。同样，将该事件记录在“日志文件”中：

```python
# Look for the {{site.data.keyword.cloudant_short_notm}} service instance.
cloudantNoSQLDBData = vcap_servicesData['cloudantNoSQLDB']
# Log the fact that we successfully found some {{site.data.keyword.cloudant_short_notm}} service information.
target.write("Got cloudantNoSQLDBData\n")
```
{: codeblock}

多个 {{site.data.keyword.cloud_notm}} 服务可能连接到应用程序环境。每个服务的凭证都将作为数组元素列出。在本教程中，仅创建了一个[服务连接](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#connecting-ibm-cloud-applications-and-services)。因此，应用程序会访问第一个元素（元素“零”）。每个服务元素都包含该服务的凭证，并表示为按访问该服务所需的必需字段名称建立索引的列表。在介绍简单数据库创建任务的[教程](/docs/services/Cloudant?topic=cloudant-creating-and-populating-a-simple-ibm-cloudant-database-on-ibm-cloud#prerequisites)中，提供了有关字段名称的更多信息。

```python
# Get a list containing the {{site.data.keyword.cloudant_short_notm}} connection information.
credentials = cloudantNoSQLDBData[0]
# Get the essential values for our application to talk to the service.
credentialsData = credentials['credentials']
# Log the fact that we successfully found the {{site.data.keyword.cloudant_short_notm}} values.
target.write("Got credentialsData\n\n")
```
{: codeblock}

接下来，检查列表并检索基本值：

```python
# Get the username ...
serviceUsername = credentialsData['username']
target.write("Got username: ")
target.write(serviceUsername)
target.write("\n")
# ... the password ...
servicePassword = credentialsData['password']
target.write("Got password: ")
target.write(servicePassword)
target.write("\n")
# ... and the URL of the service within {{site.data.keyword.cloud_notm}}.
serviceURL = credentialsData['url']
target.write("Got URL: ")
target.write(serviceURL)
target.write("\n")
```
{: codeblock}

现在，该应用程序拥有了在 {{site.data.keyword.cloudant_short_notm}} 数据库实例中创建数据库所需的全部详细信息。在介绍简单数据库创建的[教程](/docs/services/Cloudant?topic=cloudant-creating-and-populating-a-simple-ibm-cloudant-database-on-ibm-cloud#creating-a-database-within-the-service-instance)中，更详细地说明了此任务。

应用程序还必须执行以下任务：

1.  建立与数据库实例的连接。
2.  使用[先前](#getting-started-create_bmxapp_createapp)提供的名称来创建数据库。
3.  创建包含当前日期和时间的 JSON 文档。
4.  将 JSON 文档存储在数据库中。
5.  确认文档已安全存储。
6.  关闭与数据库实例的连接。

这些任务的代码如下所示：

```python
# We now have all the details we need to work with the {{site.data.keyword.cloudant_short_notm}} service instance.
# Connect to the service instance.
client = Cloudant(serviceUsername, servicePassword, url=serviceURL)
client.connect()
# Create a database within the instance.
myDatabaseDemo = client.create_database(databaseName)
if myDatabaseDemo.exists():
    target.write("'{0}' successfully created.\n".format(databaseName))
    # Create a very simple JSON document with the current date and time.
    jsonDocument = {
        "rightNow": strftime("%Y-%m-%d %H:%M:%S", gmtime())
    }
    # Store the JSON document in the database.
    newDocument = myDatabaseDemo.create_document(jsonDocument)
    if newDocument.exists():
        target.write("Document successfully created.\n")
# All done - disconnect from the service instance.
client.disconnect()
```
{: codeblock}

#### 关闭日志文件
{: #closing-the-log-file}

下一步是完成日志文件，准备好在应用程序中使用简单 Python Web 服务器提供此文件：

```python
# Put another clear indication of the current date and time at the bottom of the page.
target.write("\n====\n")
target.write(strftime("%Y-%m-%d %H:%M:%S", gmtime()))
target.write("\n====\n")
# Finish creating the web page.
target.write("</pre></body></html>")
target.close()
```
{: codeblock}

#### 提供日志文件
{: #serving-the-log-file}

最后一个任务是在 Python 应用程序中启动 Web 服务器。该服务器的唯一用途是在请求时返回日志文件。此日志文件可确认 Python 应用程序是否已成功完成以下任务：

1.  已在 {{site.data.keyword.cloud_notm}} 应用程序环境中成功运行。
2.  已确定服务连接的详细信息。
3.  已连接到 {{site.data.keyword.cloudant_short_notm}} 数据库实例。
4.  已创建数据库。
5.  已在数据库中创建文档。
6.  已在请求时使用事件日志回复。

[“入门模板”应用程序包](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#the-starter-application)中包含了用于启动 Python Web 服务器的代码：

```python
# Start up the simple Python web server application,
# so that it can 'serve' our newly created web page.
PORT = int(os.getenv('PORT', 8000))
httpd = Server(("", PORT), Handler)
try:
  print("Start serving at port %i" % PORT)
  httpd.serve_forever()
except KeyboardInterrupt:
  pass
httpd.server_close()
```
{: codeblock}

本教程中的下一步是[上传应用程序](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-uploading-the-application#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-uploading-the-application)以进行测试。

## 完整的 Python 程序
{: #complete-python-program}

以下代码是用于访问 {{site.data.keyword.cloud_notm}} 上 {{site.data.keyword.cloudant_short_notm}} 服务实例的完整 Python 程序：

```python
# Make Python modules available.
import os
import json

# It is helpful to have access to tools
# for formatting date and time values.
from time import gmtime, strftime

# Simplify access to basic Python web server tools.
try:
    from SimpleHTTPServer import SimpleHTTPRequestHandler as Handler
    from SocketServer import TCPServer as Server
except ImportError:
    from http.server import SimpleHTTPRequestHandler as Handler
    from http.server import HTTPServer as Server

# Enable the required Python libraries for working with {{site.data.keyword.cloudant_short_notm}}.
from cloudant.client import Cloudant
from cloudant.error import CloudantException
from cloudant.result import Result, ResultByKey

# This is the name of the database we intend to create.
databaseName = "databasedemo"

# Change current directory to avoid exposure of control files
try:
    os.mkdir('static')
except OSError:
    # The directory already exists,
    # no need to create it.
    pass
os.chdir('static')

# Begin creating a very simple web page.
filename = "index.html"
target = open(filename, 'w')
target.truncate()
target.write("<html><head><title>Cloudant Python Demo</title></head><body><p>Log of {{site.data.keyword.cloudant_short_notm}} Python steps...</p><pre>")

# Put a clear indication of the current date and time at the top of the page.
target.write("====\n")
target.write(strftime("%Y-%m-%d %H:%M:%S", gmtime()))
target.write("\n====\n\n")

# Start working with the {{site.data.keyword.cloudant_short_notm}} service instance.

# Check that we are running in an {{site.data.keyword.cloud_notm}} application environment.
if 'VCAP_SERVICES' in os.environ:
    # Yes we are, so get the service information.
    vcap_servicesData = json.loads(os.environ['VCAP_SERVICES'])
    # Log the fact that we successfully found some service information.
    target.write("Got vcap_servicesData\n")
    # Look for the {{site.data.keyword.cloudant_short_notm}} service instance.
    cloudantNoSQLDBData = vcap_servicesData['cloudantNoSQLDB']
    # Log the fact that we successfully found some {{site.data.keyword.cloudant_short_notm}} service information.
    target.write("Got cloudantNoSQLDBData\n")
    # Get a list containing the {{site.data.keyword.cloudant_short_notm}} connection information.
    credentials = cloudantNoSQLDBData[0]
    # Get the essential values for our application to talk to the service.
    credentialsData = credentials['credentials']
    # Log the fact that we successfully found the {{site.data.keyword.cloudant_short_notm}} values.
    target.write("Got credentialsData\n\n")
    # Get the username ...
    serviceUsername = credentialsData['username']
    target.write("Got username: ")
    target.write(serviceUsername)
    target.write("\n")
    # ... the password ...
    servicePassword = credentialsData['password']
    target.write("Got password: ")
    target.write(servicePassword)
    target.write("\n")
    # ... and the URL of the service within {{site.data.keyword.cloud_notm}}.
    serviceURL = credentialsData['url']
    target.write("Got URL: ")
    target.write(serviceURL)
    target.write("\n")

    # We now have all the details we need to work with the {{site.data.keyword.cloudant_short_notm}} service instance.
    # Connect to the service instance.
    client = Cloudant(serviceUsername, servicePassword, url=serviceURL)
    client.connect()
    # Create a database within the instance.
    myDatabaseDemo = client.create_database(databaseName)
    if myDatabaseDemo.exists():
        target.write("'{0}' successfully created.\n".format(databaseName))
        # Create a very simple JSON document with the current date and time.
        jsonDocument = {
            "rightNow": strftime("%Y-%m-%d %H:%M:%S", gmtime())
        }
        # Store the JSON document in the database.
        newDocument = myDatabaseDemo.create_document(jsonDocument)
        if newDocument.exists():
            target.write("Document successfully created.\n")
    # All done - disconnect from the service instance.
    client.disconnect()

# Put another clear indication of the current date and time at the bottom of the page.
target.write("\n====\n")
target.write(strftime("%Y-%m-%d %H:%M:%S", gmtime()))
target.write("\n====\n")
# Finish creating the web page.
target.write("</pre></body></html>")
target.close()

# Start up the simple Python web server application,
# so that it can 'serve' our newly created web page.
PORT = int(os.getenv('PORT', 8000))
httpd = Server(("", PORT), Handler)
try:
  print("Start serving at port %i" % PORT)
  httpd.serve_forever()
except KeyboardInterrupt:
  pass
httpd.server_close()
```
{: codeblock}
