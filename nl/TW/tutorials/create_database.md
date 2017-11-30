---

copyright:
  years: 2017
lastupdated: "2017-01-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

# 在 Bluemix 上建立簡單的 Cloudant 資料庫並將資料移入其中

本指導教學顯示如何使用 [Python 程式設計語言 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://www.python.org/){:new_window} 在 {{site.data.keyword.Bluemix_notm}} 服務實例上建立 {{site.data.keyword.cloudantfull}} 資料庫，以及將簡單資料集合移入資料庫。
{:shortdesc}

## 必要條件

請確定您已備妥下列資源或資訊，再透過指導教學開始運作。

### Python

您必須已在系統上安裝現行 [Python 程式設計語言 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://www.python.org/){:new_window} 安裝。

若要檢查這項作業，請在提示中執行下列指令：

```sh
python --version
```
{:pre}

您應該會收到與下列類似的結果：

```
Python 2.7.12
```
{:codeblock}

### Cloudant 的 Python 用戶端程式庫

有[正式支援的程式庫](../libraries/supported.html#python)，可讓 Python 應用程式在 {{site.data.keyword.Bluemix_notm}} 上使用 {{site.data.keyword.cloudant_short_notm}}。

您應該使用[這裡](../libraries/supported.html#python)所提供的指示來安裝此項目。

若要確認您已順利安裝用戶端程式庫，請在提示中執行下列指令：

```sh
pip freeze
```
{:pre}

您應該取得系統上安裝的所有 Python 模組清單。請檢查清單，並尋找與下面類似的 {{site.data.keyword.cloudant_short_notm}} 項目：

```
cloudant==2.3.1
```
{:codeblock}

### Bluemix 上的 Cloudant 服務實例

[本指導教學](create_service.html)說明建立適合的服務實例的處理程序。

請確定您有服務實例可用的下列「服務認證」：

欄位       | 用途
-----------|--------
`host`     | 應用程式用來尋找服務實例的主機名稱。
`username` | 應用程式存取服務實例所需的使用者名稱。
`password` | 應用程式存取服務實例所需的密碼。
`port`     | 用來存取主機上服務實例的 HTTP 埠號。一般是 443，可強制執行 HTTPS 存取。
`url`      | 將其他認證資訊聚集至單一 URL 的字串，適合供應用程式使用。

[這裡](create_service.html#locating-your-service-credentials)提供尋找服務實例的服務認證的相關資訊。

## 環境定義

本指導教學建置一系列的 Python 語言指令，適用於下列作業：

1.  [連接至 {{site.data.keyword.Bluemix_notm}} 上的 {{site.data.keyword.cloudant_short_notm}} 服務實例](#connecting-to-a-cloudant-service-instance-on-bluemix)。
2.  [在服務實例內建立資料庫](#creating-a-database-within-the-service-instance)。
3.  [將小型資料集合當成文件儲存在資料庫內](#storing-a-small-collection-of-data-as-documents-within-the-database)。
4.  [擷取完整的文件清單](#retrieving-a-complete-list-of-the-documents)。
5.  [刪除資料庫](#deleting-the-database)。
6.  [關閉與服務實例的連線](#closing-the-connection-to-the-service-instance)。

在本指導教學中，每一個作業特有的 Python 程式碼都會提供為作業說明的一部分。

指導教學結尾（[這裡](#complete-listing)）會提供執行所有作業的完整 Python 程式。

本指導教學不會嘗試建立_有效_的 Python 程式碼；旨在顯示您可從中學習並套用至您自己的應用程式之簡單易懂的可運作程式碼。

此外，不會嘗試處理所有可能的檢查或錯誤狀況。這裡顯示一些範例檢查來說明技術，但您應該套用一般最佳作法來檢查及處理您自己的應用程式所發生的所有警告或錯誤狀況。 

## 在 Bluemix 上連接至 Cloudant 服務實例

Python 應用程式需要「Cloudant 用戶端程式庫」元件能夠連接至服務實例。這些元件識別為一般 `import` 陳述式：

```python
from cloudant.client import Cloudant
from cloudant.error import CloudantException
from cloudant.result import Result, ResultByKey
```
{:codeblock}

應用程式必須有服務的[服務認證](create_service.html#locating-your-service-credentials)：

```python
serviceUsername = "353466e8-47eb-45ce-b125-4a4e1b5a4f7e-bluemix"
servicePassword = "49c0c343d225623956157d94b25d574586f26d1211e8e589646b4713d5de4801"
serviceURL = "https://353466e8-47eb-45ce-b125-4a4e1b5a4f7e-bluemix.cloudant.com"
```
{:codeblock}

>   **附註**：這裡說明的服務認證是在 Bluemix 上建立示範 Cloudant 服務時定義。這裡會重新產生認證，以顯示如何將它們用於 Python 應用程式中。不過，現在已移除示範 Cloudant 服務，因此這些認證將不會運作；您_必須_ 提供及使用您自己的服務認證。

您在應用程式內啟用 Python 用戶端程式庫並識別服務認證之後，就可以建立與服務實例的連線：

```python
client = Cloudant(serviceUsername, servicePassword, url=serviceURL)
client.connect()
```
{:codeblock}

此時，您的 Python 應用程式可以存取 Bluemix 上的服務實例。

## 在服務實例內建立資料庫

下一步是在服務實例（稱為 `databasedemo`）內建立資料庫。

作法是在 Python 應用程式中定義變數：

```python
databaseName = "databasedemo"
```
{:codeblock}

我們接著會建立資料庫：

```python
myDatabaseDemo = client.create_database(databaseName)
```
{:codeblock}

最好確認已順利建立資料庫：

```python
if myDatabaseDemo.exists():
    print "'{0}' successfully created.\n".format(databaseName)
```
{:codeblock}

## 將小型資料集合當成文件儲存在資料庫內

我們現在要在資料庫中儲存小型的簡單資料集合。

我們從識別一些資料開始：

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

接下來，某個一般 Python 程式碼會「逐步」執行資料，並將它轉換為 JSON 文件。每一份文件都會儲存在資料庫中：

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

請注意，我們確認已順利建立每一份文件。

## 擷取資料

此時，已將小型資料集合當成文件儲存在資料庫內。我們現在可以執行一系列的查詢，並說明從資料庫擷取資料的不同方式。

### 文件的最小擷取

為了執行最小擷取，我們會先要求資料庫內的所有文件清單。此清單會以陣列傳回。我們接著可以顯示陣列中元素的內容。

在範例程式碼中，我們要求從資料庫中擷取的第一份文件：

```python
result_collection = Result(myDatabaseDemo.all_docs)
print "Retrieved minimal document:\n{0}\n".format(result_collection[0])
```
{:codeblock}

結果類似下列範例：

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

>   **附註**：NoSQL 資料庫（例如 Cloudant）的本質表示針對資料庫中所儲存且一律為結果清單中所傳回之第一個項目的第一份文件，其簡單記號不一定適用。

### 文件的完整擷取

為了執行完整擷取，我們會要求資料庫內的所有文件清單，並額外指定也必須傳回文件內容。作法是使用 `include_docs` 選項。結果依然會以陣列傳回。我們接著可以顯示陣列中元素的詳細資料，而這次會包括資料庫的完整內容。 

我們依然要求從資料庫中擷取的第一份文件：

```python
result_collection = Result(myDatabaseDemo.all_docs, include_docs=True)
print "Retrieved minimal document:\n{0}\n".format(result_collection[0])
```
{:codeblock}

結果類似下列範例：

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

## 直接呼叫 Cloudant API 端點

我們也可以直接從 Python 應用程式使用 Cloudant API 端點。

在此範例程式碼中，我們再次要求所有文件的清單（包括其內容）。不過，目前的作法是呼叫 Cloudant [`/_all_docs` 端點](../api/database.html#get-documents)。

首先，我們會識別要聯絡的端點，以及與呼叫一起提供的任何參數：

```python
end_point = '{0}/{1}'.format(serviceURL, databaseName + "/_all_docs")
params = {'include_docs': 'true'}
```
{:codeblock}

接下來，我們將要求傳送至服務實例，然後顯示結果：

```python
response = client.r_session.get(end_point, params=params)
print "{0}\n".format(response.json())
```
{:codeblock}

結果類似下列_簡短_ 範例：

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

## 刪除資料庫

當我們完成資料庫的使用時，即可將它刪除。

這是下列範例 Python 程式碼中所顯示的簡單步驟：

```python
try :
    client.delete_database(databaseName)
except CloudantException:
    print "There was a problem deleting '{0}'.\n".format(databaseName)
else:
    print "'{0}' successfully deleted.\n".format(databaseName)
```
{:codeblock}

我們已包括一些基本錯誤處理來說明如何捕捉及解決問題。

## 關閉與服務實例的連線

最後一個步驟是中斷 Python 用戶端應用程式與服務實例的連線：

```python
client.disconnect()
```
{:codeblock}

## 完整清單

下列程式碼是存取 {{site.data.keyword.Bluemix_notm}} 上 {{site.data.keyword.cloudant_short_notm}} 服務實例的完整 Python 程式，並執行一系列的一般作業：

1.  連接至服務實例。
2.  在服務實例內建立資料庫。
3.  將小型資料集合當成文件儲存在資料庫內。
4.  擷取完整文件清單。
5.  刪除資料庫。
6.  關閉與服務實例的連線。

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

# Use the Cloudant library to create a Cloudant client.
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

# Use a Cloudant API endpoint to retrieve
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
