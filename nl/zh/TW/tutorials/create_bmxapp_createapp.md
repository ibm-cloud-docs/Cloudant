---

copyright:
  years: 2017, 2018
lastupdated: "2018-03-07"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-01-11 -->

# 建立簡單的 {{site.data.keyword.cloud_notm}} 應用程式以存取 {{site.data.keyword.cloudant_short_notm}} 資料庫：程式碼

指導教學的這一節說明 {{site.data.keyword.Bluemix}} 應用程式的程式碼。
{:shortdesc}

<div id="theApp"></div>

## 建立應用程式

下列元件現在已就緒，可以開始建立應用程式：

-   [Python 程式設計語言](create_bmxapp_prereq.html#python)。
-   [{{site.data.keyword.cloudant_short_notm}} 資料庫實例](create_bmxapp_prereq.html#csi)。
-   [{{site.data.keyword.Bluemix_notm}} 應用程式環境](create_bmxapp_appenv.html#creating)。
-   {{site.data.keyword.cloudant_short_notm}} 資料庫實例與 {{site.data.keyword.Bluemix_notm}} 應用程式環境之間的[連線](create_bmxapp_appenv.html#connecting)。
-   用於管理以 Cloud Foundry 為基礎之 {{site.data.keyword.Bluemix_notm}} 應用程式的[工具箱](create_bmxapp_appenv.html#toolkits)。
-   [「入門範本」應用程式套件](create_bmxapp_appenv.html#starter)，其中包含起始配置及程式碼範本檔案。

>   **附註**：本指導教學不會嘗試建立_有效率_ 的 Python 程式碼。
本指導教學是為了示範簡單易懂的可運作程式碼，方便您從中學習並應用於自己的應用程式。此外，也不會嘗試處理所有可能的檢查或錯誤狀況。指導教學中包含了一些範例檢查，來說明一些技巧。在您的應用程式中，檢查並處理所有警告或錯誤狀況。



### 基本檔案

您的應用程式需要三個配置檔及一個原始檔，這些檔案都可以在[「入門範本」應用程式套件](create_bmxapp_appenv.html#starter)中取得：
 
-   ['`Procfile`'](create_bmxapp_appenv.html#procfile)
-   ['`manifest.yml`'](create_bmxapp_appenv.html#manifest)
-   ['`requirements.txt`'](create_bmxapp_appenv.html#requirements)
-   指導教學這一節所說明的應用程式原始檔。

請如下修改配置檔：

1.  編輯 '`Procfile`' 檔案，使其包含下列文字：
    ```
    web: python server.py
    ```
    {:codeblock}

2.  編輯 '`manifest.yml`' 檔案，使其包含下列文字：
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
    {:codeblock}
    >   **附註**：請確定修改 '`domain`'、'`name`'、'`host`' 及 '`services`' 值。它們是您在建立 [{{site.data.keyword.Bluemix_notm}} 應用程式環境](create_bmxapp_appenv.html#creating)及 [{{site.data.keyword.cloudant_short_notm}} 資料庫實例](create_bmxapp_prereq.html#csi)時所輸入的值。



3.  編輯 '`requirements.txt`' 檔案，使其包含下列文字：
    ```
    cloudant==2.3.1
    ```
    {:codeblock}

### 應用程式碼

下一步是使用應用程式碼。將說明每一個區段，並呈現程式碼。應用程式碼的[完整清單](#complete-listing)位在指導教學這一節的結尾。

#### 開始使用

Python 應用程式需要一些基本元件才能運作。將如下所示匯入它們：

```python
# Make Python modules available.
import os
import json

# It is helpful to have access to tools
# for formatting date and time values.
from time import gmtime, strftime
```
{:codeblock}

應用程式是以簡單的 Web 伺服器形式運作，並且只會顯示一個頁面：包含連接至 {{site.data.keyword.cloudant_short_notm}} 資料庫實例以及建立資料庫之結果的日誌。

應用程式需要負責處理網頁的元件：

```python
# Simplify access to basic Python web server tools.
try:
    from SimpleHTTPServer import SimpleHTTPRequestHandler as Handler
    from SocketServer import TCPServer as Server
except ImportError:
    from http.server import SimpleHTTPRequestHandler as Handler
    from http.server import HTTPServer as Server
```
{:codeblock}

>   **附註**：此程式碼區段是提供為[「入門範本」應用程式套件](create_bmxapp_appenv.html#starter)的一部分。

應用程式會連接至 {{site.data.keyword.cloudant_short_notm}} 資料庫實例，因此必須匯入「{{site.data.keyword.cloudant_short_notm}} 程式庫」元件：

```python
# Enable the required Python libraries for working with {{site.data.keyword.cloudant_short_notm}}.
from cloudant.client import Cloudant
from cloudant.error import CloudantException
from cloudant.result import Result, ResultByKey
```
{:codeblock}

應用程式會在 {{site.data.keyword.cloudant_short_notm}} 資料庫實例內建立資料庫。需要有資料庫的名稱：

```python
# This is the name of the database we intend to create.
databaseName = "databasedemo"
```
{:codeblock}

應用程式會在連接至 {{site.data.keyword.cloudant_short_notm}} 資料庫實例並建立資料庫時記錄進度。記錄採用的格式是日誌檔，其儲存在 Python Web 伺服器可存取的資料夾中。

建立資料夾（在應用程式中稱為 '`static`'），並準備好在其中儲存檔案：

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
{:codeblock}

接下來，建立簡單的 HTML 檔案。此檔案將會包含應用程式建立資料庫時的每一個活動的日誌：

```python
# Begin creating a very simple web page.
filename = "index.html"
target = open(filename, 'w')
target.truncate()
target.write("<html><head><title>{{site.data.keyword.cloudant_short_notm}} Python Demo</title></head><body><p>Log of Cloudant Python steps...</p><pre>")
```
{:codeblock}

日誌的第一個部分是現行日期和時間的記錄。此記錄可協助確認確實正在建立全新的資料庫：

```python
# Put a clear indication of the current date and time at the top of the page.
target.write("====\n")
target.write(strftime("%Y-%m-%d %H:%M:%S", gmtime()))
target.write("\n====\n\n")
```
{:codeblock}

#### 使用 {{site.data.keyword.cloudant_short_notm}} 資料庫實例

Python 應用程式是在 {{site.data.keyword.Bluemix_notm}} 應用程式環境內執行。此環境提供應用程式存取已連接服務的所有必要資訊。稱為 '`VCAP_SERVICES`' 的環境變數內會提供這項資訊。此變數可以供應用程式進行存取，並用來判斷連線詳細資料。

第一項作業是確保應用程式是在 {{site.data.keyword.Bluemix_notm}} 應用程式環境內執行。藉由測試是否有 '`VCAP_SERVICES`' 環境變數來進行確認：

```python
# Check that we are running in a {{site.data.keyword.cloud_notm}} application environment.
if 'VCAP_SERVICES' in os.environ:
```
{:codeblock}

>   **附註**：只有在找到此環境變數時，才會執行接下來的程式碼區段。
    在 Python 中，會將此程式碼縮排，以指出它是測試主體。在本指導教學中，程式碼區段會省略縮排以節省空間。不過，[完整清單](#complete-listing)會正確地顯示縮排。



假設找到該變數，請繼續使用這項資訊。首先請載入該變數中所儲存的 JSON 資料並將事件記錄在新的「日誌檔」中：

```python
# Yes we are, so get the service information.
vcap_servicesData = json.loads(os.environ['VCAP_SERVICES'])
# Log the fact that we successfully found some service information.
target.write("Got vcap_servicesData\n")
```
{:codeblock}

接下來，尋找已連接 {{site.data.keyword.cloudant_short_notm}} 資料庫實例的相關資訊。同樣地，將事件記錄在「日誌檔」中：

```python
# Look for the {{site.data.keyword.cloudant_short_notm}} service instance.
cloudantNoSQLDBData = vcap_servicesData['cloudantNoSQLDB']
# Log the fact that we successfully found some {{site.data.keyword.cloudant_short_notm}} service information.
target.write("Got cloudantNoSQLDBData\n")
```
{:codeblock}

數個 {{site.data.keyword.Bluemix_notm}} 服務可能已連接至應用程式環境。每一個服務的認證都會列為陣列元素。在本指導教學中，只[建立一個服務連線](create_bmxapp_appenv.html#connecting)。因此，應用程式會存取第一個元素（元素 '0'）。每一個服務元素都會包含該服務的認證，其以透過存取服務所需的基本欄位名稱進行編製索引的清單表示。在說明簡單資料庫建立作業的[指導教學](create_database.html#a-cloudant-service-instance-on-bluemix)中，會提供欄位名稱的相關資訊。

```python
# Get a list containing the {{site.data.keyword.cloudant_short_notm}} connection information.
credentials = cloudantNoSQLDBData[0]
# Get the essential values for our application to talk to the service.
credentialsData = credentials['credentials']
# Log the fact that we successfully found the {{site.data.keyword.cloudant_short_notm}} values.
target.write("Got credentialsData\n\n")
```
{:codeblock}

接下來，請檢查清單，並擷取基本值：

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
# ... and the URL of the service within Bluemix.
serviceURL = credentialsData['url']
target.write("Got URL: ")
target.write(serviceURL)
target.write("\n")
```
{:codeblock}

應用程式現在會有在 {{site.data.keyword.cloudant_short_notm}} 資料庫實例內建立資料庫所需的所有詳細資料。在說明簡單資料庫建立的[指導教學](create_database.html#a-cloudant-service-instance-on-bluemix)中，會詳述此作業。

應用程式必須執行這些作業：

1.  建立與資料庫實例的連線。
2.  使用[稍早](#getting-started)提供的名稱來建立資料庫。
3.  建立包含現行日期和時間的 JSON 文件。
4.  將 JSON 文件儲存在資料庫中。
5.  確認已安全地儲存文件。
6.  關閉與資料庫實例的連線。

這些作業的程式碼如下所示：

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
{:codeblock}

#### 關閉日誌檔

下一步是完成日誌檔，並準備好在應用程式內使用簡單的 Python Web 伺服器來負責處理它：

```python
# Put another clear indication of the current date and time at the bottom of the page.
target.write("\n====\n")
target.write(strftime("%Y-%m-%d %H:%M:%S", gmtime()))
target.write("\n====\n")
# Finish creating the web page.
target.write("</pre></body></html>")
target.close()
```
{:codeblock}

#### 處理日誌檔

最終作業是在 Python 應用程式內啟動 Web 伺服器。伺服器的唯一用途是在要求時傳回日誌檔。此日誌檔可確認 Python 應用程式已順利完成下列作業：

1.  已在 {{site.data.keyword.Bluemix_notm}} 應用程式環境內順利執行。
2.  已判斷服務連線的詳細資料。
3.  已連接至 {{site.data.keyword.cloudant_short_notm}} 資料庫實例。
4.  已建立資料庫。
5.  已在資料庫內建立文件。
6.  已在要求時回覆事件日誌。

用於啟動 Python Web 伺服器的程式碼會包括為[「入門範本」應用程式套件](create_bmxapp_appenv.html#starter)的一部分：

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
{:codeblock}

## 下一步

指導教學中的下一步是[上傳應用程式](create_bmxapp_upload.html)來進行測試。

## 完整清單

下列程式碼用來存取 {{site.data.keyword.Bluemix_notm}} 上 {{site.data.keyword.cloudant_short_notm}} 服務實例的完整 Python 程式：

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

# Check that we are running in a Bluemix application environment.
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
    # ... and the URL of the service within Bluemix.
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
{:codeblock}
