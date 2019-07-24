---

copyright:
  years: 2015, 2019
lastupdated: "2019-06-12"

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

# 入門指導教學
{: #getting-started}

在此 {{site.data.keyword.cloudantfull}} 入門指導教學中，我們使用 Python 來建立 {{site.data.keyword.cloudant_short_notm}} 資料庫，並在該資料庫中移入一個簡單的資料集合。
{: shortdesc}

除了本指導教學之外，也請參閱上機指導教學，協助您進一步瞭解 {{site.data.keyword.cloudant_short_notm}}。或者，嘗試其中一個著重在特定語言的指導教學：

- [Liberty for Java 及 {{site.data.keyword.cloudant_short_notm}} ![外部鏈結圖示](images/launch-glyph.svg "外部鏈結圖示")](https://cloud.ibm.com/docs/runtimes/liberty/getting-started.html#getting-started-tutorial){: new_window}
- [Node.js 及 {{site.data.keyword.cloudant_short_notm}} ![外部鏈結圖示](images/launch-glyph.svg "外部鏈結圖示")](https://cloud.ibm.com/docs/runtimes/nodejs/getting-started.html#getting-started-tutorial){: new_window}
- [Swift 及 {{site.data.keyword.cloudant_short_notm}} ![外部鏈結圖示](images/launch-glyph.svg "外部鏈結圖示")](https://cloud.ibm.com/docs/runtimes/swift/getting-started.html#getting-started-tutorial){: new_window}

如需其他語言特定指導教學，請參閱[從部署第一個應用程式開始 ![外部鏈結圖示](images/launch-glyph.svg "外部鏈結圖示")](https://cloud.ibm.com/docs){: new_window}。 

## 開始之前
{: #prereqs}

您需要 [{{site.data.keyword.cloud}} 帳戶 ![外部鏈結圖示](images/launch-glyph.svg "外部鏈結圖示")](https://cloud.ibm.com/registration/){: new_window}、{{site.data.keyword.cloudant_short_notm}} 服務的實例，以及下列 Python 需求：

*	在您的系統上安裝最新版的	[Python 程式設計語言 ![外部鏈結圖示](images/launch-glyph.svg "外部鏈結圖示")](https://www.python.org/){: new_window}。
	
	若要檢查，請在提示執行下列指令：
	```sh
	python --version
	```
	{: pre}
	
	您會看到與以下內容類似的結果：

	```
	Python 2.7.12
	```
	{: screen}

*	安裝 Python 程式庫，讓您的 Python 應用程式可在 {{site.data.keyword.cloud_notm}} 上使用	{{site.data.keyword.cloudant_short_notm}}。
	
	若要檢查您是否已安裝用戶端程式庫，請在提示中執行下列指令：
	```sh
	pip freeze
	```
	{: pre}
	
	您將會看到一份列出系統上所有已安裝 Python 模組的清單。請檢查清單，找出與下列內容類似的 {{site.data.keyword.cloudant_short_notm}} 項目：

	```
	cloudant==<version>
	```
	{: screen}
	
	如果未安裝 `cloudant` 模組，請使用與下列內容類似的指令進行安裝：
	
	```
	pip install cloudant
	```
	{: pre}
  
  如需 Python 程式庫的相關資訊，請參閱[支援的平台](/docs/services/Cloudant/libraries/supported.html#python)文件。 

## 步驟 1：連接至 {{site.data.keyword.cloud_notm}} 上的 {{site.data.keyword.cloudant_short_notm}} 服務實例
{: #step-1-connect-to-your-cloudant-nosql-db-service-instance-on-ibm-cloud}

1.	執行「{{site.data.keyword.cloudant_short_notm}}	用戶端程式庫」元件的 `import` 陳述式，讓您的 Python 應用程式可以連接至 {{site.data.keyword.cloudant_short_notm}} 服務實例。
	```python
	from cloudant.client import Cloudant
	from cloudant.error import CloudantException
	from cloudant.result import Result, ResultByKey
	```
	{: codeblock}

2.  建立 {{site.data.keyword.cloudant_short_notm}} 服務認證：
  <br>在 {{site.data.keyword.cloud_notm}} 儀表板中，移至**功能表**圖示 > **資源清單**，然後開啟 {{site.data.keyword.cloudant_short_notm}} 服務實例。
  <br>在功能表中，按一下`服務認證`。
  <br>a. 按一下`新建認證`按鈕。
  <br>![建立新的服務認證](tutorials/images/img0050.png)
  <br>b. 在「新增認證」視窗中，輸入新認證的名稱（如下列擷取畫面所示）。
  <br>c.（選用）新增線型配置參數。
  <br>d. 按一下`新增`按鈕。
  <br>![新增服務認證](tutorials/images/img0051.png)
  <br>您的認證會新增至「服務認證」表格。
  <br>e. 按一下「動作」下的`檢視認證`。
  <br>![檢視所有服務認證](tutorials/images/img0052.png)
  <br>即會出現服務認證的詳細資料：
   <br>![{{site.data.keyword.cloudant_short_notm}} 服務認證](tutorials/images/img0009.png)
   
3.	建立與 {{site.data.keyword.cloudant_short_notm}} 服務實例的連線。作法機制視您是使用 {{site.data.keyword.cloud_notm}} IAM 還是 {{site.data.keyword.cloudant_short_notm}}舊式鑑別而定。如需任一鑑別類型的相關資訊，請參閱 [{{site.data.keyword.cloud_notm}} Identity and Access Management (IAM) 手冊](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-)。

	如果您是使用 {{site.data.keyword.cloudant_short_notm}}舊式鑑別，請取代來自前一個步驟的服務認證：
	```python
	client = Cloudant("<username>", "<password>", url="<url>")
	client.connect()
	```
	{: codeblock}
	
	如果您是使用 IAM 鑑別，請取代來自前一個步驟的服務認證：
	```python
	client = Cloudant.iam("<username>", "<apikey>")
	client.connect()
	```
	{: codeblock}


## 步驟 2：建立資料庫
{: #step-2-create-a-database}

1. 在 Python 應用程式中定義一個變數：
  ```python
  databaseName = "<your-database-name>"
  ```
  {: codeblock}

  ...其中，`<your-database-name>` 是您希望為資料庫提供的名稱。 

  資料庫名稱必須以字母開始，而且只能包括小寫字元 (a-z)、數字 (0-9)，以及下列任何字元：`_`、`$`、`(`、`)`、`+`、`-` 及 `/`。
  {: warning}

2. 建立資料庫：
  ```python
  myDatabase = client.create_database(databaseName)
  ```
  {: codeblock}

3. 確認已順利建立資料庫：
  ```python
  if myDatabase.exists():
      print "'{0}' successfully created.\n".format(databaseName)
  ```
  {: codeblock}

## 步驟 3：將一小組資料儲存為資料庫內的文件
{: #step-3-store-a-small-collection-of-data-as-documents-within-the-database}

1. 定義一組資料：
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

2. 使用 Python 程式碼來「逐步」處理資料，並將它轉換為 JSON 文件。每一份文件都會儲存在資料庫中：

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

  請注意，我們確認已順利建立每一份文件。
  {: tip}

## 步驟 4：透過查詢擷取資料
{: #step-4-retrieving-data-through-queries}

已將小型資料集合當成文件儲存在資料庫內。
您可以從資料庫中執行該資料的最小或完整擷取。最小擷取會取得_關於_ 文件的基本資料。完整擷取則也會包括文件_內_ 的資料。

* 若要執行最小擷取，請執行下列動作：
  1. 首先，要求一份包含資料庫內所有文件的清單。
    ```python
    result_collection = Result(myDatabase.all_docs)
    ```      
    {: codeblock}

    此清單會以陣列方式傳回。

  2. 顯示陣列中元素的內容。
    ```python
    print "Retrieved minimal document:\n{0}\n".format(result_collection[0])
    ```
    {: codeblock}

    結果與下列範例類似：
    
    ```
    [{u'value': {u'rev': u'1-106e76a2612ea13468b2f243ea75c9b1'}, u'id': u'14be111aac74534cf8d390eaa57db888', u'key': u'14be111aac74534cf8d390eaa57db888'}]
    ```
    {: screen}
    
    `u` 字首指出 Python 顯示的是 Unicode 字串。
    {: tip}

    如果我們稍微整理外觀，就可以看到所獲得的最小文件詳細資料如下列範例所示：
    
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

    資料庫中儲存的第一份文件一定會是結果清單中傳回的第一份文件，這個概念並不一定適用於 {{site.data.keyword.cloudant_short_notm}} 這類 NoSQL 資料庫。
    {: note}

* 若要執行完整擷取，請要求一份包含資料庫內所有文件的清單，並提供 `include_docs` 選項，以指定必須同時傳回文件內容。
  ```python
  result_collection = Result(myDatabase.all_docs, include_docs=True)
  print "Retrieved full document:\n{0}\n".format(result_collection[0])
  ```
  {: codeblock}
  
  結果與下列範例類似：
  ```
  [{u'value': {u'rev': u'1-7130413a8c7c5f1de5528fe4d373045c'}, u'id': u'0cfc7d902f613d5fdb7b7818e262353b', u'key': u'0cfc7d902f613d5fdb7b7818e262353b', u'doc': {u'temperatureField': 40, u'descriptionField': u'hot', u'numberField': 2, u'nameField': u'two', u'_id': u'0cfc7d902f613d5fdb7b7818e262353b', u'_rev': u'1-7130413a8c7c5f1de5528fe4d373045c'}}]
  ```
  {: screen}
  
  如果我們稍微整理外觀，就可以看到所獲得的完整文件詳細資料如下列範例所示：
  
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

## 步驟 5：透過 {{site.data.keyword.cloudant_short_notm}} API 端點擷取資料
{: #step-5-retrieving-data-through-the-cloudant-nosql-db-api-endpoint}

您也可以呼叫 {{site.data.keyword.cloudant_short_notm}} [`/_all_docs` 端點](/docs/services/Cloudant?topic=cloudant-databases#get-documents)，要求一份包含所有文件及其內容的清單。

1. 識別要聯絡的端點，以及隨著呼叫一起提供的所有參數：
  ```python
  end_point = '{0}/{1}'.format("client.server_url", databaseName + "/_all_docs")
  params = {'include_docs': 'true'}
  ```
  {: codeblock}
... 其中 `client.server_url` 是來自您在步驟 1 找到的服務認證的 URL 值。

2. 將要求傳送至服務實例，並顯示結果：
  ```python
  response = client.r_session.get(end_point, params=params)
  print "{0}\n".format(response.json())
  ```
  {: codeblock}

  結果類似下列_縮短的_ 範例：
  
  ```
  {u'rows': [{u'value': {u'rev': u'1-6d8cb5905316bf3dbe4075f30daa9f59'}, u'id': u'0532feb6fd6180d79b842d871316c444', u'key': u'0532feb6fd6180d79b842d871316c444', u'doc': {u'temperatureField': 20, u'descriptionField': u'warm', u'numberField': 3, u'nameField': u'three', u'_id': u'0532feb6fd6180d79b842d871316c444', u'_rev': u'1-6d8cb5905316bf3dbe4075f30daa9f59'}}, ... , {u'value': {u'rev': u'1-3f61736fa96473d358365ce1665e3d97'}, u'id': u'db396f77bbe12a567b09177b4accbdbc', u'key': u'db396f77bbe12a567b09177b4accbdbc', u'doc': {u'temperatureField': 0, u'descriptionField': u'freezing', u'numberField': 5, u'nameField': u'five', u'_id': u'db396f77bbe12a567b09177b4accbdbc', u'_rev': u'1-3f61736fa96473d358365ce1665e3d97'}}], u'total_rows': 5, u'offset': 0}
  ```
  {: screen}
  
  我們可以稍微整理外觀，就可以看到所獲得的_縮短_ 詳細資料如下列範例所示：
  
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

## （選用）第 6 步：在「{{site.data.keyword.cloudant_short_notm}} 儀表板」上查看資料庫資訊
{: #optional-step-6-ibm-cloudant-dashboard}

遵循下列步驟在「{{site.data.keyword.cloudant_short_notm}} 儀表板」上查看資料庫和文件。 

1.  登入 IBM Cloud 帳戶。
    IBM Cloud 儀表板位於 `https://cloud.ibm.com/`。利用使用者名稱及密碼進行鑑別之後，您會看到 IBM Cloud 儀表板。
2.  按一下「資源摘要」窗格中的**服務**，來查看您的 {{site.data.keyword.cloudant_short_notm}} 服務實例。 
3.  按一下您要查看其詳細資料的服務實例。
4.  按一下**啟動 Cloudant 儀表板**。
    儀表板開啟時，您可以看到與服務相關聯的儀表板。


## 步驟 7：刪除資料庫
{: #step-7-delete-the-database}

不再使用資料庫時，可以將它刪除。

```python
try:
    client.delete_database(databaseName)
except CloudantException:
    print "There was a problem deleting '{0}'.\n".format(databaseName)
else:
    print "'{0}' successfully deleted.\n".format(databaseName)
```
{: codeblock}

我們已包含部分基本錯誤處理，用來顯示如何疑難排解及處理潛在問題。

## 步驟 8：關閉與服務實例的連線
{: #step-8-close-the-connection-to-the-service-instance}

最後一個步驟是中斷 Python 用戶端應用程式與服務實例的連線：

```python
client.disconnect()
```
{: codeblock}

## 後續步驟
{: #next-steps}

如需所有 {{site.data.keyword.cloudant_short_notm}} 供應項目的相關資訊，請參閱主要 [{{site.data.keyword.cloudant_short_notm}} ![外部鏈結圖示](images/launch-glyph.svg "外部鏈結圖示")](https://www.ibm.com/cloud/cloudant){: new_window} 網站。

如需相關資訊，請參閱 [{{site.data.keyword.cloudant_short_notm}} 文件](/docs/services/Cloudant?topic=cloudant-overview#overview)中的指導教學、{{site.data.keyword.cloudant_short_notm}} 概念、作業及技術。

## 附錄：完整的 Python 程式碼清單
{: #appendix-complete-python-code-listing}

完整的 Python 程式碼清單如下。記得將 `<username>`、`<password>`、`<url>` 及 `<apikey>` 值取代為您的服務認證。
同樣地，將 `<yourDatabaseName>` 值取代為您的資料庫名稱。

```python
from cloudant.client import Cloudant
from cloudant.error import CloudantException
from cloudant.result import Result, ResultByKey

# {{site.data.keyword.cloudant_short_notm}}舊式authentication
client = Cloudant("<username>", "<password>", url="<url>")
client.connect()

# IAM Authentication (uncomment if needed, and comment out previous {{site.data.keyword.cloudant_short_notm}}舊式authentication section)
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


try:
    client.delete_database(databaseName)
except CloudantException:
    print "There was a problem deleting '{0}'.\n".format(databaseName)
else:
    print "'{0}' successfully deleted.\n".format(databaseName)

client.disconnect()

```
{: codeblock}
