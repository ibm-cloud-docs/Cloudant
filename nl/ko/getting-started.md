---

copyright:
  years: 2015, 2019
lastupdated: "2019-04-02"

keywords: connect to service instance, create a database, populate database with data, retrieve data through queries, retrieve data with api endpoint, delete database, close connection, complete python code listing, couchdb as a service, couchdb hosted, couchdb, databases for couchdb

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

<!-- Acrolinx: 2018-05-31 -->

# 시작하기 튜토리얼
{: #getting-started}

이 {{site.data.keyword.cloudantfull}} 시작하기 튜토리얼에서는
Python을 사용하여 {{site.data.keyword.cloudant_short_notm}} 데이터베이스를 작성하고
이 데이터베이스를 간단한 데이터 콜렉션으로 채웁니다.
{: shortdesc}

이 튜토리얼 외에도 {{site.data.keyword.cloudant_short_notm}}에 대해 더 많이 배울 수 있는 실무 튜토리얼을 참조하십시오. 또는 특정 언어에 중점을 둔 튜토리얼 중 하나를 시도해 보십시오.

- [Liberty for Java 및 {{site.data.keyword.cloudant_short_notm}} ![외부 링크 아이콘](images/launch-glyph.svg "외부 링크 아이콘")](https://cloud.ibm.com/docs/runtimes/liberty/getting-started.html#getting-started-tutorial){: new_window}
- [Node.js 및 {{site.data.keyword.cloudant_short_notm}} ![외부 링크 아이콘](images/launch-glyph.svg "외부 링크 아이콘")](https://cloud.ibm.com/docs/runtimes/nodejs/getting-started.html#getting-started-tutorial){: new_window}
- [Swift 및 {{site.data.keyword.cloudant_short_notm}} ![외부 링크 아이콘](images/launch-glyph.svg "외부 링크 아이콘")](https://cloud.ibm.com/docs/runtimes/swift/getting-started.html#getting-started-tutorial){: new_window}

언어별 튜토리얼에 대한 자세한 정보는 [첫 번째 앱을 배치하여 시작하기 ![외부 링크 아이콘](images/launch-glyph.svg "외부 링크 아이콘")](https://cloud.ibm.com/docs/){: new_window}를 참조하십시오. 

## 시작하기 전에
{: #prereqs}

[{{site.data.keyword.cloud}} 계정 ![외부 링크 아이콘](images/launch-glyph.svg "외부 링크 아이콘")](https:///cloud.ibm.com/registration/){: new_window},
{{site.data.keyword.cloudant_short_notm}} 서비스의 인스턴스와 다음 Python 요구사항이 필요합니다.

*	시스템에
	[Python 프로그래밍 언어 ![외부 링크 아이콘](images/launch-glyph.svg "외부 링크 아이콘")](https://www.python.org/){: new_window}의 최신 버전을 설치하십시오.
	
	이를 확인하려면 프롬프트에서 다음 명령을 실행하십시오.
	```sh
	python --version
	```
	{: pre}
	
	다음과 같은 결과가 표시됩니다.

	```
	Python 2.7.12
	```
	{: screen}

*	Python 라이브러리를 설치하여
	Python 애플리케이션이 {{site.data.keyword.cloud_notm}}의
	{{site.data.keyword.cloudant_short_notm}}와 함께 작동할 수 있도록 하십시오.
	
	클라이언트 라이브러리를 설치했는지 확인하려면
 프롬프트에서 다음 명령을 실행하십시오.
	```sh
	pip freeze
	```
	{: pre}
	
	시스템에 설치된 모든 Python 모듈의 목록이 표시됩니다. 목록을 확인하여 다음과 유사한 {{site.data.keyword.cloudant_short_notm}} 항목을 찾으십시오.

	```
	cloudant==<version>
	```
	{: screen}
	
	`cloudant` 모듈이 설치되지 않은 경우에는 다음과 유사한 명령을 사용하여 이를 설치하십시오.
	
	```
	pip install cloudant
	```
	{: pre}
  
  Python 라이브러리에 대한 자세한 정보는 [지원되는 플랫폼](/docs/services/Cloudant/libraries/supported.html#python) 문서를 참조하십시오. 

## 1단계: {{site.data.keyword.cloud_notm}}의 {{site.data.keyword.cloudant_short_notm}} 서비스 인스턴스에 연결
{: #step-1-connect-to-your-cloudant-nosql-db-service-instance-on-ibm-cloud}

1.	{{site.data.keyword.cloudant_short_notm}} 클라이언트 라이브러리 컴포넌트의
	`import`문을 실행하여 Python 애플리케이션이
	{{site.data.keyword.cloudant_short_notm}} 서비스 인스턴스에 연결할 수 있도록 하십시오.
	```python
	from cloudant.client import Cloudant
	from cloudant.error import CloudantException
	from cloudant.result import Result, ResultByKey
	```
	{: codeblock}

2.  {{site.data.keyword.cloudant_short_notm}} 서비스 인증 정보를 작성하십시오.
  <br>{{site.data.keyword.cloud_notm}} 대시보드에서 **메뉴** 아이콘 > **리소스 목록**으로 이동하고 {{site.data.keyword.cloudant_short_notm}} 서비스 인스턴스를 여십시오.
  <br>왼쪽 탐색에서 `Service credentials`를 클릭하십시오.
  <br>a. `New credential` 단추를 클릭하십시오.
  <br>![새 서비스 인증 정보 작성](/docs/services/Cloudant/tutorials/images/img0050.png)
  <br>b. 다음 스크린샷에 표시되어 있는 바와 같이 새 인증 정보 추가 창에서 새 인증 정보의 이름을 입력하십시오.
  <br>c. (선택사항) 인라인 구성 매개변수를 추가하십시오.
  <br>d. `Add` 단추를 클릭하십시오. 
  <br>![새 서비스 인증 정보 추가](/docs/services/Cloudant/tutorials/images/img0051.png)
  <br>사용자의 인증 정보가 서비스 인증 정보 테이블에 추가됩니다.
  <br>e. 조치에서 `View credentials`를 클릭하십시오. 
  <br>![모든 서비스 인증 정보 보기](/docs/services/Cloudant/tutorials/images/img0052.png)
  <br>서비스 인증 정보의 세부사항이 표시됩니다.
   <br>![ {{site.data.keyword.cloudant_short_notm}} 서비스 인증 정보](/docs/services/Cloudant/tutorials/images/img0009.png)
   
3.	{{site.data.keyword.cloudant_short_notm}} 서비스 인스턴스에 대한 연결을 설정하십시오. 이를 수행하는 메커니즘은 {{site.data.keyword.cloud_notm}} IAM 또는 {{site.data.keyword.cloudant_short_notm}} 레거시 인증을 사용 중인지 여부에 따라 다릅니다. 인증 유형에 대한 세부사항은 [{{site.data.keyword.cloud_notm}} Identity and Access Management(IAM) 안내서 ![외부 링크 아이콘](images/launch-glyph.svg "외부 링크 아이콘")](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-)를 참조하십시오.

	{{site.data.keyword.cloudant_short_notm}} 레거시 인증 정보를 사용 중인 경우 이전 단계에서 서비스 인증 정보를 바꾸십시오.
```python
	client = Cloudant("<username>", "<password>", url="<url>")
	client.connect()
	```
	{: codeblock}
	
	IAM 인증을 사용 중인 경우 이전 단계에서 서비스 인증 정보를 바꾸십시오.
```python
	client = Cloudant.iam("<username>", "<apikey>")
	client.connect()
	```
	{: codeblock}


## 2단계: 데이터베이스 작성
{: #step-2-create-a-database}

1. Python 애플리케이션에서 변수를 정의하십시오.
  ```python
  databaseName = "<your-database-name>"
  ```
  {: codeblock}

    ... 여기서 `<your-database-name>`은 데이터베이스에 지정할 이름입니다. 

  데이터베이스 이름은 문자로 시작해야 하며 소문자(a - z), 숫자(0 - 9), 그리고 문자 `_`, `$`, `(`, `)`, `+`, `-`, `/`만 포함해야 합니다.
  {: warning}

2. 데이터베이스를 작성하십시오.
  ```python
  myDatabase = client.create_database(databaseName)
  ```
  {: codeblock}

3. 데이터베이스가 작성되었는지 확인하십시오.
  ```python
  if myDatabase.exists():
      print "'{0}' successfully created.\n".format(databaseName)
  ```
  {: codeblock}

## 3단계: 소량의 데이터 콜렉션을 문서로서 데이터베이스 내에 저장
{: #step-3-store-a-small-collection-of-data-as-documents-within-the-database}

1. 데이터 콜렉션을 정의하십시오.
  ```python
  sampleData = [
      [1, "one", "boiling", 100],
      [2, "two", "hot", 40],
      [3, "three", "warm", 20],
      [4, "four", "cold", 10],
      [5, "five", "freezing", 0]
    ]
  ```
  {: codeblock}

2. Python 코드를 사용하여 데이터를 '단계적으로' JSON 문서로 변환하십시오.
  각 문서는 데이터베이스에 저장됩니다.

  ```python
  # Create documents by using the sample data.
  # Go through each row in the array
  for document in sampleData:
    # Retrieve the fields in each row.
    number = document[0]
    name = document[1]
    description = document[2]
    temperature = document[3]
    #
    # Create a JSON document that represents
    # all the data in the row.
    jsonDocument = {
        "numberField": number,
        "nameField": name,
        "descriptionField": description,
        "temperatureField": temperature
    }
    #
    # Create a document by using the database API.
    newDocument = myDatabase.create_document(jsonDocument)
    #
    # Check that the document exists in the database.
    if newDocument.exists():
        print "Document '{0}' successfully created.".format(number)
  ```
  {: codeblock}

  각 문서가 성공적으로 작성되었는지 확인하도록 알리십시오.
  {: tip}

## 4단계: 조회를 통한 데이터 검색
{: #step-4-retrieving-data-through-queries}

소량의 데이터 컬렉션이 문서로서 데이터베이스 내에 저장되었습니다.
사용자는 데이터베이스로부터 최소 또는 전체 데이터 검색을 수행할 수 있습니다.
최소 검색은 문서 _관련_ 기본 데이터를 획득합니다.
전체 검색은 문서 _내_의 데이터 또한 포함합니다.

* 최소 검색을 실행하려면 다음 작업을 수행하십시오.
  1. 먼저 데이터베이스 내에 있는 모든 문서의 목록을 요청하십시오.
    ```python
    result_collection = Result(myDatabase.all_docs)
    ```      
    {: codeblock}

    이 목록은 배열로 리턴됩니다.

  2. 배열에 있는 요소의 컨텐츠를 표시하십시오.
    ```python
    print "Retrieved minimal document:\n{0}\n".format(result_collection[0])
    ```
    {: codeblock}

    결과는 다음 예와 유사합니다.
    
    ```
    [{u'value': {u'rev': u'1-106e76a2612ea13468b2f243ea75c9b1'}, u'id': u'14be111aac74534cf8d390eaa57db888', u'key': u'14be111aac74534cf8d390eaa57db888'}]
    ```
    {: screen}
    
    `u` 접두부는 Python이 유니코드 문자열을 표시하고 있음을 나타내는 표시입니다. 
    {: tip}

    표시를 약간 정리하면 리턴된 최소 문서 세부사항이 다음 예와 같음을 볼 수 있습니다.
    
    ```json
    [
        {
            "value": {
                "rev": "1-106e76a2612ea13468b2f243ea75c9b1"
            },
            "id": "14be111aac74534cf8d390eaa57db888",
            "key": "14be111aac74534cf8d390eaa57db888"
        }
    ]
    ```
    {: codeblock}

    {{site.data.keyword.cloudant_short_notm}}와 같은 NoSQL 데이터베이스에는 데이터베이스에 처음 저장되는 첫 번째 문서가 결과 목록에서 리턴되는 첫 번째 문서라는 개념이 적용되지 않는 경우가 있습니다.
    {: note}

* 전체 검색을 실행하려면
  데이터베이스 내에 있는 모든 문서의 목록을 요청하고
  `include_docs` 옵션을 제공하여
  문서 컨텐츠 또한 리턴되어야 함을 지정하십시오.
  ```python
  result_collection = Result(myDatabase.all_docs, include_docs=True)
  print "Retrieved full document:\n{0}\n".format(result_collection[0])
  ```
  {: codeblock}
  
  결과는 다음 예와 유사합니다.
  ```
  [{u'value': {u'rev': u'1-7130413a8c7c5f1de5528fe4d373045c'}, u'id': u'0cfc7d902f613d5fdb7b7818e262353b', u'key': u'0cfc7d902f613d5fdb7b7818e262353b', u'doc': {u'temperatureField': 40, u'descriptionField': u'hot', u'numberField': 2, u'nameField': u'two', u'_id': u'0cfc7d902f613d5fdb7b7818e262353b', u'_rev': u'1-7130413a8c7c5f1de5528fe4d373045c'}}]
  ```
  {: screen}
  
  표시를 약간 정리하면 리턴된 전체 문서 세부사항이 다음 예와 같음을 볼 수 있습니다.
  
  ```json
  [
    {
      "value": {
        "rev": "1-7130413a8c7c5f1de5528fe4d373045c
      },
      "id": "0cfc7d902f613d5fdb7b7818e262353b",
      "key": "0cfc7d902f613d5fdb7b7818e262353b",
      "doc": {
        "temperatureField": 40,
        "descriptionField": "hot",
        "numberField": 2,
        "nameField": "two",
        "_id": "0cfc7d902f613d5fdb7b7818e262353b",
        "_rev": "1-7130413a8c7c5f1de5528fe4d373045c"
      }
    }
  ]
  ```
  {: codeblock}

## 5단계: {{site.data.keyword.cloudant_short_notm}} API 엔드포인트를 통한 데이터 검색
{: #step-5-retrieving-data-through-the-cloudant-nosql-db-api-endpoint}

{{site.data.keyword.cloudant_short_notm}} [`/_all_docs` 엔드포인트](/docs/services/Cloudant?topic=cloudant-databases#get-documents)를 호출하여 모든 문서와 해당 컨텐츠의 목록을 요청할 수도 있습니다.

1. 접속할 엔드포인트, 그리고 호출과 함께 제공할 매개변수를 식별하십시오.
  ```python
  end_point = '{0}/{1}'.format("client.server_url", databaseName + "/_all_docs")
  params = {'include_docs': 'true'}
  ```
  {: codeblock}
  ... 여기서 `client.server_url`은 1단계에서 찾은 서비스 인증 정보의 URL 값입니다.

2. 서비스 인스턴스에 요청을 전송한 후 결과를 표시하십시오.
  ```python
  response = client.r_session.get(end_point, params=params)
  print "{0}\n".format(response.json())
  ```
  {: codeblock}

  결과는 다음 _축약된_ 예와 유사합니다.
  
  ```
  {u'rows': [{u'value': {u'rev': u'1-6d8cb5905316bf3dbe4075f30daa9f59'}, u'id': u'0532feb6fd6180d79b842d871316c444', u'key': u'0532feb6fd6180d79b842d871316c444', u'doc': {u'temperatureField': 20, u'descriptionField': u'warm', u'numberField': 3, u'nameField': u'three', u'_id': u'0532feb6fd6180d79b842d871316c444', u'_rev': u'1-6d8cb5905316bf3dbe4075f30daa9f59'}}, ... , {u'value': {u'rev': u'1-3f61736fa96473d358365ce1665e3d97'}, u'id': u'db396f77bbe12a567b09177b4accbdbc', u'key': u'db396f77bbe12a567b09177b4accbdbc', u'doc': {u'temperatureField': 0, u'descriptionField': u'freezing', u'numberField': 5, u'nameField': u'five', u'_id': u'db396f77bbe12a567b09177b4accbdbc', u'_rev': u'1-3f61736fa96473d358365ce1665e3d97'}}], u'total_rows': 5, u'offset': 0}
  ```
  {: screen}
  
  표시를 약간 정리하면 리턴된 _축약_ 세부사항이 다음 예와 같음을 볼 수 있습니다.
  
  ```json
  {
      "rows": [
          {
              "value": {
                "rev": "1-6d8cb5905316bf3dbe4075f30daa9f59"
              },
              "id": "0532feb6fd6180d79b842d871316c444",
              "key": "0532feb6fd6180d79b842d871316c444",
              "doc": {
                  "temperatureField": 20,
                  "descriptionField": "warm",
                  "numberField": 3,
                  "nameField": "three",
                  "_id": "0532feb6fd6180d79b842d871316c444",
                  "_rev": "1-6d8cb5905316bf3dbe4075f30daa9f59"
              }
          },
          ...
          {
              "value":
              {
                "rev": "1-6d8cb5905316bf3dbe4075f30daa9f59"
              },
              "id": "db396f77bbe12a567b09177b4accbdbc",
              "key": "db396f77bbe12a567b09177b4accbdbc",
              "doc": {
                  "temperatureField": 0,
                  "descriptionField": "freezing",
                  "numberField": 5,
                  "nameField": "five",
                  "_id": "db396f77bbe12a567b09177b4accbdbc",
                  "_rev": "1-6d8cb5905316bf3dbe4075f30daa9f59"
              }
          }
      ],
      "total_rows": 5,
      "offset": 0
  }
  ```
  {: codeblock}

## (선택사항) 6단계: {{site.data.keyword.cloudant_short_notm}} 대시보드의 데이터베이스 정보 참조
{: #optional-step-6-ibm-cloudant-dashboard}

다음 단계를 수행하여 {{site.data.keyword.cloudant_short_notm}} 대시보드에서 데이터베이스와 문서를 확인하십시오. 

1.  IBM Cloud 계정에 로그인하십시오.
    IBM Cloud 대시보드가 https://cloud.ibm.com/에 있습니다. 사용자 이름 및 비밀번호를 사용하여 인증하면 IBM Cloud 대시보드가 표시됩니다.
2.  리소스 요약 분할창에서 **서비스**를 클릭하여 {{site.data.keyword.cloudant_short_notm}} 서비스 인스턴스를 확인하십시오. 
3.  세부사항을 보려는 서비스 인스턴스를 클릭하십시오.
4.  **Launch Cloudant Dashboard**를 클릭하십시오.
    대시보드가 열리면 서비스와 연관된 데이터베이스를 볼 수 있습니다.


## 7단계: 데이터베이스 삭제
{: #step-7-delete-the-database}

데이터베이스 작업을 완료한 후에는 이를 삭제할 수 있습니다.

```python
try :
    client.delete_database(databaseName)
except CloudantException:
    print "There was a problem deleting '{0}'.\n".format(databaseName)
else:
    print "'{0}' successfully deleted.\n".format(databaseName)
```
{: codeblock}

발생할 수 있는 문제를 해결하는 방법을 보여주기 위해
몇 가지 기본적인 오류 처리 방법이 포함되었습니다.

## 8단계: 서비스 인스턴스에 대한 연결 닫기
{: #step-8-close-the-connection-to-the-service-instance}

마지막 단계는 서비스 인스턴스로부터 Python 클라이언트 애플리케이션의 연결을 끊는 것입니다.

```python
client.disconnect()
```
{: codeblock}

## 다음 단계
{: #next-steps}

모든 {{site.data.keyword.cloudant_short_notm}} 오퍼링에 대한 자세한 정보는
기본 [{{site.data.keyword.cloudant_short_notm}} ![외부 링크 아이콘](images/launch-glyph.svg "외부 링크 아이콘")](http://www.ibm.com/analytics/us/en/technology/cloud-data-services/cloudant/){: new_window} 사이트를 참조하십시오.

자세한 정보는 [{{site.data.keyword.cloudant_short_notm}} 문서](/docs/services/Cloudant?topic=cloudant-overview#overview)에서 튜토리얼, {{site.data.keyword.cloudant_short_notm}} 개념, 태스크 및 기술을 참조하십시오.

## 부록: 전체 Python 코드 목록
{: #appendix-complete-python-code-listing}

전체 Python 코드 목록은 다음과 같습니다. 
여기서 `<username>`,
`<password>`, `<url>`
및 `<apikey>` 값을 사용자의 서비스 인증 정보로 대체해야 한다는 점을 기억하십시오.
마찬가지로,
`<yourDatabaseName>` 값을 사용자의 데이터베이스 이름으로 대체하십시오.

```python
from cloudant.client import Cloudant
from cloudant.error import CloudantException
from cloudant.result import Result, ResultByKey

# {{site.data.keyword.cloudant_short_notm}} Legacy authentication
client = Cloudant("<username>", "<password>", url="<url>")
client.connect()

# IAM Authentication (uncomment if needed, and comment out {{site.data.keyword.cloudant_short_notm}} Legacy authentication section above)
client = Cloudant.iam("<username","<apikey>")
client.connect()

databaseName = "<yourDatabaseName>"

myDatabase = client.create_database(databaseName)

if myDatabase.exists():
    print "'{0}' successfully created.\n".format(databaseName)

sampleData = [
    [1, "one", "boiling", 100],
    [2, "two", "hot", 40],
    [3, "three", "warm", 20],
    [4, "four", "cold", 10],
    [5, "five", "freezing", 0]
]

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
    newDocument = myDatabase.create_document(jsonDocument)

    # Check that the document exists in the database.
    if newDocument.exists():
        print "Document '{0}' successfully created.".format(number)

result_collection = Result(myDatabase.all_docs)

print "Retrieved minimal document:\n{0}\n".format(result_collection[0])

result_collection = Result(myDatabase.all_docs, include_docs=True)
print "Retrieved full document:\n{0}\n".format(result_collection[0])

end_point = '{0}/{1}'.format("<url>", databaseName + "/_all_docs")
params = {'include_docs': 'true'}
response = client.r_session.get(end_point, params=params)
print "{0}\n".format(response.json())


try :
    client.delete_database(databaseName)
except CloudantException:
    print "There was a problem deleting '{0}'.\n".format(databaseName)
else:
    print "'{0}' successfully deleted.\n".format(databaseName)

client.disconnect()

```
{: codeblock}
