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

# {{site.data.keyword.cloudant_short_notm}} 데이터베이스에 액세스하기 위한 간단한 {{site.data.keyword.cloud_notm}} 애플리케이션 작성: 코드
{: #creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-code}

이 튜토리얼 섹션에서는 {{site.data.keyword.cloud}} 애플리케이션의 코드를 설명합니다.
{: shortdesc}

## 애플리케이션 작성
{: #creating-your-application}

이제 다음 컴포넌트가 확보되어 애플리케이션 작성을 시작할 준비가 완료되었습니다.

-   [Python 프로그래밍 언어](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-prerequisites#python-create-bmxapp-prereq)
-   [{{site.data.keyword.cloudant_short_notm}} 데이터베이스 인스턴스](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-prerequisites#an-ibm-cloudant-database-application).
-   [{{site.data.keyword.cloud_notm}} 애플리케이션 환경](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#creating-an-ibm-cloud-application-environment).
-   {{site.data.keyword.cloudant_short_notm}} 데이터베이스 인스턴스와 {{site.data.keyword.cloud_notm}} 애플리케이션 환경 간 [연결](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#connecting-ibm-cloud-applications-and-services)
-   Cloud Foundry 기반 {{site.data.keyword.cloud_notm}} 애플리케이션 관리를 위한 [툴킷](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#the-cloud-foundry-and-ibm-cloud-command-toolkits)
-   초기 구성 및 코드 템플리트 파일을 포함하는 ['스타터' 애플리케이션 팩](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#the-starter-application)

이 튜토리얼의 Python 코드를 작성하는 데 있어서 _효율성_은 고려되지 않았습니다.     이 코드의 의도는 참조하여 자신의 애플리케이션에 적용할 수 있는, 간단하고 이해하기 쉬운 작동 코드를 보여주는 것입니다. 오류 상태에 대해 모든 가능한 검사를 수행하려는 시도 또한 이루어지지 않았습니다. 일부 검사 예는 몇 가지 기법을 보여주기 위해 포함되었습니다. 자신의 애플리케이션의 경우에는 모든 경고 또는 오류 상태를 검사하고 처리하십시오.
{: tip}


### 필수 파일
{: #essential-files}

애플리케이션은 세 개의 구성 파일과 하나의 소스 파일을 필요로 하며,
이들은 모두 [`스타터` 애플리케이션 팩](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#the-starter-application)에 있습니다.
 
-   [`Procfile`](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#the-procfile-file)
-   [`manifest.yml`](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#the-manifest.yml-file)
-   [`requirements.txt`](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#the-requirements.txt-file)
-   이 튜토리얼 섹션에 설명된 애플리케이션 소스 파일

구성 파일을 다음과 같이 수정하십시오.

1.  다음 텍스트를 포함하도록 '`Procfile`' 파일을 편집하십시오.
    ```
    web: python server.py
    ```
    {: codeblock}

2.  다음 텍스트를 포함하도록 '`manifest.yml`' 파일을 편집하십시오.
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

'`domain`', '`name`', '`host`' 및 '`services`' 값을 수정했는지 확인하십시오. 이들은 [{{site.data.keyword.cloud_notm}} 애플리케이션 환경](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#creating-an-ibm-cloud-application-environment) 및 [{{site.data.keyword.cloudant_short_notm}} 데이터베이스 인스턴스](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-prerequisites#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-prerequisites)를 작성할 때 입력한 값입니다.
{: note}

3.  다음 텍스트를 포함하도록 '`requirements.txt`' 파일을 편집하십시오.
    ```
    cloudant==2.3.1
    ```
    {: codeblock}

### 애플리케이션 코드
{: #the-application-code}

다음 단계는 애플리케이션 코드에 대해 작업하는 것입니다.
각 섹션이 설명되어 있으며 해당 코드가 표시되어 있습니다.
애플리케이션 코드의 [전체 목록](#complete-python-program)은 이 튜토리얼 섹션의 끝에 있습니다.

#### 시작하기
{: #getting-started-create_bmxapp_createapp}

Python 애플리케이션은 기능하기 위해 몇 가지 기본 컴포넌트를 필요로 합니다.
이들은 다음과 같이 가져옵니다.

```python
# Make Python modules available.
import os
import json

# It is helpful to have access to tools
# for formatting date and time values.
from time import gmtime, strftime
```
{: codeblock}

애플리케이션은 단순한 웹 서버로서 작동하며 하나의 페이지({{site.data.keyword.cloudant_short_notm}} 데이터베이스 인스턴스 연결 및 데이터베이스 작성의 결과를 포함하는 로그)만을 표시합니다.

애플리케이션은 웹 페이지를 서비스하기 위한 컴포넌트를 필요로 합니다.

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

이 코드 세그먼트는 ['스타터' 애플리케이션 팩](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#the-starter-application)의 일부로서 제공됩니다.
{: note}

애플리케이션은 {{site.data.keyword.cloudant_short_notm}} 데이터베이스 인스턴스에 연결하므로 {{site.data.keyword.cloudant_short_notm}} 라이브러리 컴포넌트를 가져와야 합니다.

```python
# Enable the required Python libraries for working with {{site.data.keyword.cloudant_short_notm}}.
from cloudant.client import Cloudant
from cloudant.error import CloudantException
from cloudant.result import Result, ResultByKey
```
{: codeblock}

애플리케이션은 {{site.data.keyword.cloudant_short_notm}} 데이터베이스 인스턴스 내에 데이터베이스를 작성합니다.
이 데이터베이스에 사용할 이름이 필요합니다.

```python
# This is the name of the database we intend to create.
databaseName = "databasedemo"
```
{: codeblock}

애플리케이션은 {{site.data.keyword.cloudant_short_notm}} 데이터베이스 인스턴스에 연결하고 데이터베이스를 작성하면서 진행상태를 기록합니다.
이 레코드의 형태는 로그 파일이며, 이는 Python 웹 서버에서 액세스할 수 있는 폴더에 저장됩니다.

폴더(이 애플리케이션에서는 '`static`'이라고 함)를 작성하고 여기에 파일을 저장할 준비를 하십시오.

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

그 다음에는 간단한 HTML 파일을 작성하십시오.
이 파일에는 애플리케이션이 데이터베이스를 작성함에 따라 각 활동의 로그가 포함됩니다.

```python
# Begin creating a very simple web page.
filename = "index.html"
target = open(filename, 'w')
target.truncate()
target.write("<html><head><title>{{site.data.keyword.cloudant_short_notm}} Python Demo</title></head><body><p>Log of Cloudant Python steps...</p><pre>")
```
{: codeblock}

이 로그의 첫 번째 부분은 현재 날짜 및 시간의 레코드입니다.
이 레코드는 데이터베이스가 정말 새로 작성되었는지 확인하는 데 도움을 줍니다.

```python
# Put a clear indication of the current date and time at the top of the page.
target.write("====\n")
target.write(strftime("%Y-%m-%d %H:%M:%S", gmtime()))
target.write("\n====\n\n")
```
{: codeblock}

#### {{site.data.keyword.cloudant_short_notm}} 데이터베이스 인스턴스에 대한 작업
{: #working-with-the-ibm-cloudant-database-instance}

Python 애플리케이션은 {{site.data.keyword.cloud_notm}} 환경 내에서 실행됩니다.
이 환경은 애플리케이션이 연결된 서비스에 액세스하는 데 필요한 모든 정보를 제공합니다.
이 정보는 '`VCAP_SERVICES`'라고 하는 환경 변수 내에 제공됩니다.
이 변수는 애플리케이션에 의해 액세스될 수 있으며, 연결 세부사항을 판별하는 데 사용됩니다.

첫 번째 태스크는 애플리케이션이 {{site.data.keyword.cloud_notm}} 애플리케이션 환경 내에서 실행 중인지 확인하는 것입니다.
'`VCAP_SERVICES`' 환경 변수의 유무를 테스트하여 이를 확인하십시오.

```python
# Check that we are running in an {{site.data.keyword.cloud_notm}} application environment.
if 'VCAP_SERVICES' in os.environ:
```
{: codeblock}

다음 코드 섹션은 환경 변수를 찾은 경우에만 실행됩니다.     Python에서는 테스트의 본체임을 표시하기 위해 이 코드를 들여썼습니다. 이 튜토리얼에서는 공간을 절약하기 위해 코드 세그먼트에서 들여쓰기가 생략되었습니다. 그러나 [전체 목록](#complete-python-program)에는 들여쓰기가 올바르게 표시되어 있습니다.
{: note}

변수를 찾은 경우에는 진행하여 정보를 사용하십시오.
변수 내에 저장된 JSON 데이터를 로드하고 이벤트를 새 '로그 파일'에 기록하여 작업을 시작하십시오.

```python
# Yes we are, so get the service information.
vcap_servicesData = json.loads(os.environ['VCAP_SERVICES'])
# Log the fact that we successfully found some service information.
target.write("Got vcap_servicesData\n")
```
{: codeblock}

그 다음에는 연결된 {{site.data.keyword.cloudant_short_notm}} 데이터베이스 인스턴스에 대한 정보를 찾으십시오.
또 다시 이 이벤트를 '로그 파일'에 기록하십시오.

```python
# Look for the {{site.data.keyword.cloudant_short_notm}} service instance.
cloudantNoSQLDBData = vcap_servicesData['cloudantNoSQLDB']
# Log the fact that we successfully found some {{site.data.keyword.cloudant_short_notm}} service information.
target.write("Got cloudantNoSQLDBData\n")
```
{: codeblock}

애플리케이션 환경에는 여러 {{site.data.keyword.cloud_notm}} 서비스가 연결될 수 있습니다.
각 서비스의 인증 정보는 배열 요소로 나열됩니다.
이 튜토리얼에서는 하나의 [서비스 연결만 작성되었습니다](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#connecting-ibm-cloud-applications-and-services).
따라서 애플리케이션은 첫 번째 요소(요소 '0')에 액세스합니다.
각 서비스 요소는 서비스에 액세스하는 데 필요한 필수 필드 이름으로 인덱스화된 목록으로 표현된,
해당 서비스의 인증 정보를 포함합니다.
필드 이름에 대한 자세한 정보는 간단한 데이터베이스 작성 태스크를 설명하는
[튜토리얼](/docs/services/Cloudant?topic=cloudant-creating-and-populating-a-simple-ibm-cloudant-database-on-ibm-cloud#prerequisites)에 제공되어 있습니다.

```python
# Get a list containing the {{site.data.keyword.cloudant_short_notm}} connection information.
credentials = cloudantNoSQLDBData[0]
# Get the essential values for our application to talk to the service.
credentialsData = credentials['credentials']
# Log the fact that we successfully found the {{site.data.keyword.cloudant_short_notm}} values.
target.write("Got credentialsData\n\n")
```
{: codeblock}

그 다음에는 목록을 검사하고 필수 값을 검색하십시오.

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

이제 애플리케이션이 {{site.data.keyword.cloudant_short_notm}} 데이터베이스 인스턴스 내에 데이터베이스를 작성하는 데 필요한 모든 세부사항을 확보했습니다.
이 태스크는 간단한 데이터베이스 작성 작업을 설명하는 [튜토리얼](/docs/services/Cloudant?topic=cloudant-creating-and-populating-a-simple-ibm-cloudant-database-on-ibm-cloud#creating-a-database-within-the-service-instance)에 자세히 설명되어 있습니다.

애플리케이션은 다음 태스크를 수행해야 합니다.

1.  데이터베이스 인스턴스에 대한 연결을 설정합니다.
2.  [이전](#getting-started-create_bmxapp_createapp)에 제공된 이름으로 데이터베이스를 작성합니다.
3.  현재 날짜 및 시간을 포함하는 JSON 문서를 작성합니다.
4.  데이터베이스에 이 JSON 문서를 저장합니다.
5.  이 문서가 안전하게 저장되었는지 확인합니다.
6.  데이터베이스 인스턴스에 대한 연결을 닫습니다.

이러한 태스크의 코드는 다음과 같습니다.

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

#### 로그 파일 닫기
{: #closing-the-log-file}

다음 단계는 애플리케이션 내의 단순 Python 웹 서버를 사용하여 서비스할 준비를 끝내기 위해 로그 파일을 완료하는 것입니다.

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

#### 로그 파일 서비스
{: #serving-the-log-file}

마지막 태스크는 Python 애플리케이션 내에서 웹 서버를 시작하는 것입니다.
이 서버의 유일한 목적은 요청 시에 로그 파일을 리턴하는 것입니다.
이 로그 파일은 Python 애플리케이션이 다음 태스크를 완료했음을 확인합니다.

1.  {{site.data.keyword.cloud_notm}} 애플리케이션 환경 내에서 성공적으로 실행되었습니다.
2.  서비스 연결의 세부사항을 판별했습니다.
3.  {{site.data.keyword.cloudant_short_notm}} 데이터베이스 인스턴스에 연결했습니다.
4.  데이터베이스를 작성했습니다.
5.  데이터베이스 내에 문서를 작성했습니다.
6.  요청된 경우 이벤트의 로그로 응답했습니다.

Python 웹 서버를 시작하기 위한 코드는 ['스타터' 애플리케이션 팩](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#the-starter-application)의 일부로서 포함되어 있습니다.

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

이 튜토리얼의 다음 단계는 테스트 목적을 위해 [애플리케이션을 업로드](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-uploading-the-application#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-uploading-the-application)하는 것입니다.

## 전체 Python 프로그램
{: #complete-python-program}

다음 코드는 {{site.data.keyword.cloud_notm}}의 {{site.data.keyword.cloudant_short_notm}} 서비스 인스턴스에 액세스하는 전체 Python 프로그램입니다.

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
