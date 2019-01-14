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

# {{site.data.keyword.cloud_notm}}에서의 간단한 {{site.data.keyword.cloudant_short_notm}} 데이터베이스 작성 및 채우기

이 튜토리얼은 [Python 프로그래밍 언어 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://www.python.org/){:new_window}를 사용하여
{{site.data.keyword.cloud_notm}} 서비스 인스턴스에 {{site.data.keyword.cloudantfull}} 데이터베이스를 작성하고 이 데이터베이스를 간단한 데이터 콜렉션으로 채우는 방법을 보여줍니다.
{:shortdesc}

## 전제조건

이 튜토리얼을 시작하기 전에 다음 리소스 또는 정보가 준비되어 있는지 확인하십시오.

### Python

시스템에 [Python 프로그래밍 언어 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://www.python.org/){:new_window}의 현재 버전이 설치되어 있어야 합니다.

이를 확인하려면 프롬프트에서 다음 명령을 실행하십시오.

```sh
python --version
```
{:pre}

다음과 유사한 결과를 얻게 됩니다.

```
Python 2.7.12
```
{:codeblock}

### {{site.data.keyword.cloudant_short_notm}}용 Python 클라이언트 라이브러리

Python 애플리케이션이 {{site.data.keyword.cloud_notm}}의 {{site.data.keyword.cloudant_short_notm}}와 함께 작동할 수 있게 해 주는
[공식 지원 라이브러리](../libraries/supported.html#python)가 있습니다.

[여기](../libraries/supported.html#python)에 제공된 지시사항을 사용하여 이를 설치해야 합니다.

클라이언트 라이브러리를 설치했는지 확인하려면 프롬프트에서 다음 명령을 실행하십시오.

```sh
pip freeze
```
{:pre}

시스템에 설치된 모든 Python 모듈의 목록이 표시됩니다.
목록을 확인하여 다음과 유사한 {{site.data.keyword.cloudant_short_notm}} 항목을 찾으십시오.

```
cloudant==2.3.1
```
{:codeblock}

### {{site.data.keyword.cloud_notm}}의 {{site.data.keyword.cloudant_short_notm}} 서비스 인스턴스

적절한 서비스 인스턴스를 작성하는 프로세스는 [이 튜토리얼](create_service.html)에 설명되어 있습니다.

서비스 인스턴스에 대해 다음 서비스 인증 정보가 사용 가능한지 확인하십시오.

필드      |용도
-----------|--------
`host`     |애플리케이션이 서비스 인스턴스를 찾는 데 사용하는 호스트 이름입니다.
`username` |애플리케이션이 서비스 인스턴스에 액세스하는 데 필요한 사용자 이름입니다.
`password` |애플리케이션이 서비스 인스턴스에 액세스하는 데 필요한 비밀번호입니다.
`port`     |호스트의 서비스 인스턴스에 액세스하는 데 필요한 HTTP 포트 번호입니다. 보통 HTTPS 액세스를 강제하려는 경우에는 443이 사용됩니다.
`url`      |애플리케이션에서 사용하기에 적합하도록 기타 인증 정보를 하나의 URL로 통합하는 문자열입니다.

서비스 인스턴스의 서비스 인증 정보를 찾는 데 대한 정보는 [여기](create_service.html#locating-your-service-credentials)에 있습니다.

## 내용

이 튜토리얼에서는 다음 태스크에 적합한 일련의 Python 언어 명령을 빌드합니다.

1.  [{{site.data.keyword.cloud}}의 {{site.data.keyword.cloudant_short_notm}} 서비스 인스턴스에 연결합니다](#connecting-to-a-cloudant-no-sql-db-service-instance-on-ibm-cloud).
2.  [서비스 인스턴스 내에 데이터베이스를 작성합니다](#creating-a-database-within-the-service-instance).
3.  [소량의 데이터 콜렉션을 문서로서 데이터베이스 내에 저장합니다](#storing-a-small-collection-of-data-as-documents-within-the-database).
4.  [문서의 전체 목록을 검색합니다](#retrieving-a-complete-list-of-the-documents).
5.  [데이터베이스를 삭제합니다](#deleting-the-database).
6.  [서비스 인스턴스에 대한 연결을 닫습니다](#closing-the-connection-to-the-service-instance).

각 태스크를 위한 특정 Python 코드는 이 튜토리얼에서 해당 태스크 설명의 일부로 제공되어 있습니다.

모든 태스크를 수행하기 위한 전체 Python 프로그램은 튜토리얼의 끝([여기](#complete-listing))에 제공되어 있습니다.

이 튜토리얼의 Python 코드를 작성하는 데 있어서 _효율성_은 고려되지 않았습니다. 이 코드의 의도는 참조하여 자신의 애플리케이션에 적용할 수 있는, 간단하고 이해하기 쉬운 작동 코드를 보여주는 것입니다.

오류 상태에 대해 모든 가능한 검사를 수행하려는 시도 또한 이루어지지 않았습니다.
이 튜토리얼에서는 기법을 보여주기 위해 일부 검사 예를 보여주고 있으나, 사용자는 일반적인 우수 사례를 적용하여
자신의 애플리케이션에서 발생한 모든 경고 및 오류 상태를 확인하고 처리해야 합니다. 

## {{site.data.keyword.cloudant_short_notm}}{{site.data.keyword.cloud_notm}}의 서비스 인스턴스에 연결

Python 애플리케이션이 서비스 인스턴스에 연결하려면 {{site.data.keyword.cloudant_short_notm}} 클라이언트 라이브러리 컴포넌트가 필요합니다.
이들 컴포넌트는 보통 `import`문으로 식별됩니다.

```python
from cloudant.client import Cloudant
from cloudant.error import CloudantException
from cloudant.result import Result, ResultByKey
```
{:codeblock}

애플리케이션에는 서비스의 [서비스 인증 정보](create_service.html#locating-your-service-credentials)가 있어야 합니다.

```python
serviceUsername = "353466e8-47eb-45ce-b125-4a4e1b5a4f7e-bluemix"
servicePassword = "49c0c343d225623956157d94b25d574586f26d1211e8e589646b4713d5de4801"
serviceURL = "https://353466e8-47eb-45ce-b125-4a4e1b5a4f7e-bluemix.cloudant.com"
```
{:codeblock}

여기에 나와 있는 서비스 인증 정보
데모 {{site.data.keyword.cloudant_short_notm}} 서비스가 {{site.data.keyword.cloud_notm}}에 작성될 때 정의되었습니다.
    이 인증 정보는 Python 애플리케이션에서 어떻게 사용되는지 사용자에게 보여주기 위해 여기서 다시 생성되었습니다.
    그러나 해당 데모 {{site.data.keyword.cloudant_short_notm}} 서비스는 현재 제거되었으며,
    따라서 이들 인증 정보는 작동하지 않습니다. 사용자는 _반드시_ 자신의
    서비스 인증 정보를 제공하여 사용해야 합니다.
{: tip}

애플리케이션 내에서 Python 클라이언트 라이브러리를 사용으로 설정하고 서비스 인증 정보를 식별한 후에는 서비스 인스턴스에 대한 연결을 설정할 수 있습니다.

```python
client = Cloudant(serviceUsername, servicePassword, url=serviceURL)
client.connect()
```
{:codeblock}

이 시점에서, 사용자의 Python 애플리케이션은 {{site.data.keyword.cloud_notm}}의 서비스 인스턴스에 대한 액세스 권한을 갖고 있습니다.

## 서비스 인스턴스 내에 데이터베이스 작성

다음 단계는 서비스 인스턴스 내에 `databasedemo`라는 데이터베이스를 작성하는 것입니다.

이는 Python 애플리케이션에 변수를 정의하여 수행합니다.

```python
databaseName = "databasedemo"
```
{:codeblock}

그 후 데이터베이스를 작성합니다.

```python
myDatabaseDemo = client.create_database(databaseName)
```
{:codeblock}

다음과 같이 데이터베이스가 작성되었는지 확인하는 것이 좋습니다.

```python
if myDatabaseDemo.exists():
    print "'{0}' successfully created.\n".format(databaseName)
```
{:codeblock}

## 소량의 데이터 콜렉션을 문서로서 데이터베이스 내에 저장

이제 소량의 간단한 데이터 콜렉션을 데이터베이스에 저장합니다.

먼저 몇 가지 데이터를 식별하는 것으로 시작합니다.

```python
sampleData = [
    [1, "one", "boiling", 100],
    [2, "two", "hot", 40],
    [3, "three", "warm", 20],
    [4, "four", "cold", 10],
    [5, "five", "freezing", 0]
]
```
{:codeblock}

그 다음에는 일반 Python 코드가 데이터를 '단계적으로' JSON 문서로 변환합니다.
각 문서는 데이터베이스에 저장됩니다.

```python
# Create documents using the sample data.
# Go through each row in the array
for document in sampleData:
    # Retrieve the fields in each row.
    number = document[0]
    name = document[1]
    description = document[2]
    temperature = document[3]

    # Create a JSON document that represents
    # all the data in the row.
    jsonDocument = {
        "numberField": number,
        "nameField": name,
        "descriptionField": description,
        "temperatureField": temperature
    }

    # Create a document using the Database API.
    newDocument = myDatabaseDemo.create_document(jsonDocument)

    # Check that the document exists in the database.
    if newDocument.exists():
        print "Document '{0}' successfully created.".format(number)
```
{:codeblock}

코드 예를 보면 각 문서가 작성되었는지 확인하는 것을 볼 수 있습니다.

## 데이터 검색

이 시점에는 소량의 데이터 콜렉션이 문서로서 데이터베이스 내에 저장되어 있습니다.
이제 데이터베이스로부터 데이터를 검색하는 다양한 방법을 보여주는 일련의 조회를 수행할 수 있습니다.

### 문서의 최소 검색

최소 검색을 수행하기 위해서는 먼저 데이터베이스 내 모든 문서의 목록을 요청합니다.
이 목록은 배열로 리턴됩니다.
그 후에는 배열에 있는 요소의 컨텐츠를 표시할 수 있습니다.

간단한 다음 코드에서는 데이터베이스에서 검색되는 첫 번째 문서를 요청합니다.

```python
result_collection = Result(myDatabaseDemo.all_docs)
print "Retrieved minimal document:\n{0}\n".format(result_collection[0])
```
{:codeblock}

결과는 다음 예와 유사합니다.

```json
[
    {
        "value": {
            "rev": "1-b2c48b89f48f1dc172d4db3f17ff6b9a"
        },
        "id": "14746fe384c7e2f06f7295403df89187",
        "key": "14746fe384c7e2f06f7295403df89187"
    }
]
```
{:codeblock}

{{site.data.keyword.cloudant_short_notm}}와 같은
    NoSQL 데이터베이스의 특성은
    데이터베이스에 저장된 첫 번째 문서가
    항상 결과 목록에서 처음으로 리턴된다는 단순한 생각이
    언제나 옳은 것은 아님을 의미합니다.
{: tip}

### 문서의 전체 검색

전체 검색을 수행하기 위해서는 데이터베이스 내 모든 문서의 목록을 요청하고, 추가로 문서 컨텐츠 또한 리턴되어야 함을 지정합니다.
이는 `include_docs` 옵션을 사용하여 수행합니다.
이전과 마찬가지로 결과는 배열로 리턴됩니다.
그 후에는 문서의 전체 컨텐츠를 포함,
배열에 있는 요소의 세부사항을 표시할 수 있습니다. 

이전과 마찬가지로, 데이터베이스에서 검색되는 첫 번째 문서를 요청합니다.

```python
result_collection = Result(myDatabaseDemo.all_docs, include_docs=True)
print "Retrieved minimal document:\n{0}\n".format(result_collection[0])
```
{:codeblock}

결과는 다음 예와 유사합니다.

```json
[
    {
        "value": {
          "rev": "1-b2c48b89f48f1dc172d4db3f17ff6b9a"
        },
        "id": "14746fe384c7e2f06f7295403df89187",
        "key": "14746fe384c7e2f06f7295403df89187",
        "doc": {
            "temperatureField": 10,
            "descriptionField": "cold",
            "numberField": 4,
            "nameField": "four",
            "_id": "14746fe384c7e2f06f7295403df89187",
            "_rev": "1-b2c48b89f48f1dc172d4db3f17ff6b9a"
        }
    }
]
```
{:codeblock}

## 직접 {{site.data.keyword.cloudant_short_notm}} API 엔드포인트 호출

Python 애플리케이션 내에서 {{site.data.keyword.cloudant_short_notm}} API 엔드포인트에 대해 직접 작업을 수행할 수도 있습니다.

이 코드 예에서는 다시 한 번 컨텐츠를 포함하는 모든 문서의 목록을 요청합니다.
그러나 이번에는 {{site.data.keyword.cloudant_short_notm}} [`/_all_docs` 엔드포인트](../api/database.html#get-documents)를 호출하여 이를 수행합니다.

먼저 접속할 엔드포인트, 그리고 호출과 함께 제공할 매개변수를 식별합니다.

```python
end_point = '{0}/{1}'.format(serviceURL, databaseName + "/_all_docs")
params = {'include_docs': 'true'}
```
{:codeblock}

그 다음에는 서비스 인스턴스에 요청을 전송한 후 결과를 표시합니다.

```python
response = client.r_session.get(end_point, params=params)
print "{0}\n".format(response.json())
```
{:codeblock}

결과는 다음 _축약된_ 예와 유사합니다.

```json
{
    "rows": [
        {
            "value": {
              "rev": "1-b2c48b89f48f1dc172d4db3f17ff6b9a"
            },
            "id": "14746fe384c7e2f06f7295403df89187",
            "key": "14746fe384c7e2f06f7295403df89187",
            "doc": {
                "temperatureField": 10,
                "descriptionField": "cold",
                "numberField": 4,
                "nameField": "four",
                "_id": "14746fe384c7e2f06f7295403df89187",
                "_rev": "1-b2c48b89f48f1dc172d4db3f17ff6b9a"
            }
        },
        ...
        {
            "value":
            {
              "rev": "1-7130413a8c7c5f1de5528fe4d373045c"
            },
            "id": "49baa66cc66b4dda86ffb2852ae78eb8",
            "key": "49baa66cc66b4dda86ffb2852ae78eb8",
            "doc": {
                "temperatureField": 40,
                "descriptionField": "hot",
                "numberField": 2,
                "nameField": "two",
                "_id": "49baa66cc66b4dda86ffb2852ae78eb8",
                "_rev": "1-7130413a8c7c5f1de5528fe4d373045c"
            }
        }
    ],
    "total_rows": 5,
    "offset": 0
}
```
{:codeblock}

## 데이터베이스 삭제

데이터베이스 작업을 완료한 후에는 이를 삭제할 수 있습니다.

이는 다음 샘플 Python 코드에 표시되어 있는 바와 같이 간단한 단계입니다.

```python
try :
    client.delete_database(databaseName)
except CloudantException:
    print "There was a problem deleting '{0}'.\n".format(databaseName)
else:
    print "'{0}' successfully deleted.\n".format(databaseName)
```
{:codeblock}

여기에는 문제점을 발견하고 해결하는 방법을 보여주는 몇 가지 기본 오류 처리 방법이 포함되어 있습니다.

## 서비스 인스턴스에 대한 연결 닫기

마지막 단계는 서비스 인스턴스로부터 Python 클라이언트 애플리케이션의 연결을 끊는 것입니다.

```python
client.disconnect()
```
{:codeblock}

## 전체 목록

다음 코드는 {{site.data.keyword.cloud_notm}}의
{{site.data.keyword.cloudant_short_notm}} 서비스 인스턴스에 액세스하여 다음과 같은 일련의 일반 태스크를 수행하는 전체 Python 프로그램입니다.

1.  서비스 인스턴스에 연결합니다.
2.  서비스 인스턴스 내에 데이터베이스를 작성합니다.
3.  소량의 데이터 콜렉션을 문서로서 데이터베이스 내에 저장합니다.
4.  문서의 전체 목록을 검색합니다.
5.  데이터베이스를 삭제합니다.
6.  서비스 인스턴스에 대한 연결을 닫습니다.

```python
# 1.  Connecting to the service instance.

# Enable the required Python libraries.

from cloudant.client import Cloudant
from cloudant.error import CloudantException
from cloudant.result import Result, ResultByKey

# Useful variables
serviceUsername = "353466e8-47eb-45ce-b125-4a4e1b5a4f7e-bluemix"
servicePassword = "49c0c343d225623956157d94b25d574586f26d1211e8e589646b4713d5de4801"
serviceURL = "https://353466e8-47eb-45ce-b125-4a4e1b5a4f7e-bluemix.cloudant.com"

# This is the name of the database we are working with.
databaseName = "databasedemo"

# This is a simple collection of data,
# to store within the database.
sampleData = [
    [1, "one", "boiling", 100],
    [2, "two", "hot", 40],
    [3, "three", "warm", 20],
    [4, "four", "cold", 10],
    [5, "five", "freezing", 0]
]

# Start the demo.
print "===\n"

# Use the {{site.data.keyword.cloudant_short_notm}} library to create an {{site.data.keyword.cloudant_short_notm}} client.
client = Cloudant(serviceUsername, servicePassword, url=serviceURL)

# Connect to the server
client.connect()

# 2.  Creating a database within the service instance.

# Create an instance of the database.
myDatabaseDemo = client.create_database(databaseName)

# Check that the database now exists.
if myDatabaseDemo.exists():
    print "'{0}' successfully created.\n".format(databaseName)

# Space out the results.
print "----\n"

# 3.  Storing a small collection of data as documents within the database.

# Create documents using the sample data.
# Go through each row in the array
for document in sampleData:
    # Retrieve the fields in each row.
    number = document[0]
    name = document[1]
    description = document[2]
    temperature = document[3]

    # Create a JSON document that represents
    # all the data in the row.
    jsonDocument = {
        "numberField": number,
        "nameField": name,
        "descriptionField": description,
        "temperatureField": temperature
    }

    # Create a document using the Database API.
    newDocument = myDatabaseDemo.create_document(jsonDocument)

    # Check that the document exists in the database.
    if newDocument.exists():
        print "Document '{0}' successfully created.".format(number)

# Space out the results.
print "----\n"

# 4.  Retrieving a complete list of the documents.

# Simple and minimal retrieval of the first
# document in the database.
result_collection = Result(myDatabaseDemo.all_docs)
print "Retrieved minimal document:\n{0}\n".format(result_collection[0])

# Simple and full retrieval of the first
# document in the database.
result_collection = Result(myDatabaseDemo.all_docs, include_docs=True)
print "Retrieved full document:\n{0}\n".format(result_collection[0])

# Space out the results.
print "----\n"

# Use an {{site.data.keyword.cloudant_short_notm}} API endpoint to retrieve
# all the documents in the database,
# including their content.

# Define the end point and parameters
end_point = '{0}/{1}'.format(serviceURL, databaseName + "/_all_docs")
params = {'include_docs': 'true'}

# Issue the request
response = client.r_session.get(end_point, params=params)

# Display the response content
print "{0}\n".format(response.json())

# Space out the results.
print "----\n"

# All done.
# Time to tidy up.

# 5.  Deleting the database.

# Delete the test database.
try :
    client.delete_database(databaseName)
except CloudantException:
    print "There was a problem deleting '{0}'.\n".format(databaseName)
else:
    print "'{0}' successfully deleted.\n".format(databaseName)

# 6.  Closing the connection to the service instance.

# Disconnect from the server
client.disconnect()

# Finish the demo.
print "===\n"

# Say good-bye.
exit()
```
{:codeblock}
