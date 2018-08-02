---

copyright:
  years: 2015, 2018
lastupdated: "2018-06-07"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:tip: .tip}

# 入門指導教學
{: #getting-started-with-cloudant}

在此 {{site.data.keyword.cloudantfull}} 入門指導教學中，我們將使用 Python 來建立 {{site.data.keyword.cloudant}} 資料庫，並在該資料庫中移入一組簡單的資料。
{:shortdesc}

<div id="prerequisites"></div>

## 開始之前
{: #prereqs}

您需要 [Bluemix 帳戶 ![外部鏈結圖示](images/launch-glyph.svg "外部鏈結圖示")](https://console.ng.bluemix.net/registration/){:new_window}、{{site.data.keyword.cloudant}} 服務的實例，以及下列 Python 需求：

*	請在您的系統上安裝最新版的 [Python 程式設計語言 ![外部鏈結圖示](images/launch-glyph.svg "外部鏈結圖示")](https://www.python.org/){:new_window}。
	
	若要檢查此情況，請在提示中執行下列指令：
	```sh
	python --version
	```
	{:pre}
	
	您應該會收到與下列內容類似的結果：

	```
	Python 2.7.12
	```
	{:screen}

*	安裝 [Python 程式庫](libraries/supported.html#python)，讓您的 Python 應用程式可在 {{site.data.keyword.Bluemix_notm}} 上使用 {{site.data.keyword.cloudant_short_notm}}。
	
	若要確認您已順利安裝用戶端程式庫，請在提示中執行下列指令：
	```sh
	pip freeze
	```
	{:pre}
	
	您應該會獲得一份清單，其中列出所有已安裝在系統上的 Python 模組。請檢查清單，找出與下列內容類似的 {{site.data.keyword.cloudant_short_notm}} 項目：

	```
	cloudant==2.3.1
	```
	{:screen}
	
	如果未安裝 `cloudant` 模組，請使用與下列內容類似的指令進行安裝：
	
	```
	pip install cloudant==2.3.1
	```
	{:pre}

## 步驟 1：連接至 {{site.data.keyword.Bluemix_notm}} 上的 {{site.data.keyword.cloudant_short_notm}} 服務實例

1.	執行「{{site.data.keyword.cloudant_short_notm}} 用戶端程式庫」元件的下列 '`import`' 陳述式，讓您的 Python 應用程式可以連接至 {{site.data.keyword.cloudant_short_notm}} 服務實例。
	```python
	from cloudant.client import Cloudant
	from cloudant.error import CloudantException
	from cloudant.result import Result, ResultByKey
	```
	{: codeblock}

2. 識別 {{site.data.keyword.cloudant_short_notm}} 服務認證：
  1. 在 {{site.data.keyword.Bluemix_notm}} 主控台中，開啟服務實例的儀表板。
  2. 在左導覽中，按一下**`服務認證`**。
  3. 按一下**`動作`**下的**`檢視認證`**。

3.	執行下列指令來建立服務實例的連線。取代來自前一個步驟的服務認證：
	```python
	client = Cloudant("<username>", "<password>", url="<url>")
	client.connect()
	```
	{: codeblock}


## 步驟 2：建立資料庫

1. 在 Python 應用程式中定義一個變數：
  ```python
  databaseName = "<yourDatabaseName>"
  ```
  {: codeblock}
  ... 其中 `<yourDatabaseName>` 是您想要提供給資料庫的名稱。 

  > **附註：**資料庫名稱必須以字母開始，而且只能包括小寫字元 (a-z)、數字 (0-9)，以及下列任何字元：`_`、`$`、`(`、`)`、`+`、`-` 及 `/`。

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
  ```
  {: codeblock}

請注意，我們會確認已順利建立每一份文件。
{: tip}

## 步驟 4：透過查詢擷取資料

此時，已將一小組資料儲存為資料庫內的文件。您可以從資料庫中執行該資料的最小或完整擷取。最小擷取會取得_關於_ 文件的基本資料。完整擷取則也會包括文件_內_ 的資料。

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
    {:screen}
    
    > **附註：**`u'` 字首僅是表示 Python 顯示的是 Unicode 字串。 
    
    如果我們稍微整理外觀，可以看到獲得的最小文件明細如下所示：
    
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
    {:screen}

  > **附註：**NoSQL 資料庫（例如 {{site.data.keyword.cloudant_short_notm}}）的本質意味著簡單記號（例如儲存在資料庫的第一份文件一律會是結果清單中傳回的第一個結果）不一定適用。

* 若要執行完整擷取，請要求一份包含資料庫內所有文件的清單，並提供 `include_docs` 選項，指定必須同時傳回文件內容。
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
  
  如果我們稍微整理外觀，可以看到獲得的完整文件明細如下所示：
  
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
  {:screen}

## 步驟 5：透過 {{site.data.keyword.cloudant_short_notm}} API 端點擷取資料

您也可以呼叫 Cloudant [`/_all_docs` 端點](api/database.html#get-documents)，要求一份包含所有文件及其內容的清單。

1. 識別要聯絡的端點，以及隨著呼叫一起提供的所有參數：
  ```python
  end_point = '{0}/{1}'.format("<url>", databaseName + "/_all_docs")
  params = {'include_docs': 'true'}
  ```
  {: codeblock}
  ... 其中 `<url>` 是來自您在「步驟 1」找到的服務認證的 URL 值。



2. 將要求傳送至服務實例，然後顯示結果：
  ```python
  response = client.r_session.get(end_point, params=params)
  print "{0}\n".format(response.json())
  ```
  {: codeblock}

  結果與下列_縮寫_ 範例類似：
  
  ```
  {u'rows': [{u'value': {u'rev': u'1-6d8cb5905316bf3dbe4075f30daa9f59'}, u'id': u'0532feb6fd6180d79b842d871316c444', u'key': u'0532feb6fd6180d79b842d871316c444', u'doc': {u'temperatureField': 20, u'descriptionField': u'warm', u'numberField': 3, u'nameField': u'three', u'_id': u'0532feb6fd6180d79b842d871316c444', u'_rev': u'1-6d8cb5905316bf3dbe4075f30daa9f59'}}, ... , {u'value': {u'rev': u'1-3f61736fa96473d358365ce1665e3d97'}, u'id': u'db396f77bbe12a567b09177b4accbdbc', u'key': u'db396f77bbe12a567b09177b4accbdbc', u'doc': {u'temperatureField': 0, u'descriptionField': u'freezing', u'numberField': 5, u'nameField': u'five', u'_id': u'db396f77bbe12a567b09177b4accbdbc', u'_rev': u'1-3f61736fa96473d358365ce1665e3d97'}}], u'total_rows': 5, u'offset': 0}
  ```
  {:screen}
  
  我們可以稍微整理外觀，就可以看到獲得的_縮寫_ 詳細資料如下所示：
  
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
  {:screen}

## 步驟 6：刪除資料庫

不再使用資料庫時，可以將它刪除。

```python
try :
    client.delete_database(databaseName)
except CloudantException:
    print "There was a problem deleting '{0}'.\n".format(databaseName)
else:
    print "'{0}' successfully deleted.\n".format(databaseName)
```
{: codeblock}

我們已包含一些基本錯誤處理，來說明如何捕捉及解決問題。

## 步驟 7：關閉服務實例的連線

最終步驟是中斷 Python 用戶端應用程式與服務實例的連線：

```python
client.disconnect()
```
{: codeblock}

## 後續步驟

如需所有 {{site.data.keyword.cloudant_short_notm}} 供應項目的相關資訊，請參閱主要 [{{site.data.keyword.cloudant_short_notm}} ![外部鏈結圖示](images/launch-glyph.svg "外部鏈結圖示")](http://www.ibm.com/analytics/us/en/technology/cloud-data-services/cloudant/){:new_window} 網站。


如需有關 {{site.data.keyword.cloudant_short_notm}} 概念、作業及技術的其他詳細資料和指導教學，請參閱 [{{site.data.keyword.cloudant_short_notm}} 文件](cloudant.html)。

## 附錄：完整的 Python 程式碼清單

完整的 Python 程式碼清單如下。請記得將 `<username>`、`<password>` 及 `<url>` 值取代為您的服務認證。同樣地，將 `<yourDatabaseName>` 值取代為您的資料庫名稱。

```python
from cloudant.client import Cloudant
from cloudant.error import CloudantException
from cloudant.result import Result, ResultByKey

client = Cloudant("<username>", "<password>", url="<url>")
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
