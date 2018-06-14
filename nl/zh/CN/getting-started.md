---

copyright:
  years: 2015, 2018
lastupdated: "2017-11-02"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:tip: .tip}

# 入门教程
{: #getting-started-with-cloudant}

在本 {{site.data.keyword.cloudantfull}} 入门教程中，我们将使用 Python 来创建一个 {{site.data.keyword.cloudant}} 数据库，并使用简单的数据集合来填充该数据库。
{:shortdesc}

<div id="prerequisites"></div>

## 准备工作
{: #prereqs}

您将需要 [Bluemix 帐户 ![外部链接图标](images/launch-glyph.svg "外部链接图标")](https://console.ng.bluemix.net/registration/){:new_window} 以及 {{site.data.keyword.cloudant}} 服务的实例，并满足以下 Python 需求：

*	在系统上安装最新版本的 [Python 编程语言 ![外部链接图标](images/launch-glyph.svg "外部链接图标")](https://www.python.org/){:new_window}。
	
	要检查版本，请在提示符处运行以下命令：
	```sh
	python --version
	```
	{:pre}
	
	您应该会获得类似于以下内容的结果：

	```
	Python 2.7.12
	```
	{:screen}

*	安装 [Python 库](libraries/supported.html#python)，以支持 Python 应用程序在 {{site.data.keyword.Bluemix_notm}} 上使用 {{site.data.keyword.cloudant_short_notm}}。
	
	要检查是否已成功安装客户机库，请在提示符处运行以下命令：
	```sh
	pip freeze
	```
	{:pre}
	
	您应该会获得系统上安装的所有 Python 模块的列表。检查该列表，查找类似于以下内容的 {{site.data.keyword.cloudant_short_notm}} 条目：

	```
	cloudant==2.3.1
	```
	{:screen}
	
	如果未安装 `cloudant` 模块，请使用类似于以下内容的命令进行安装：
	
	```
	pip install cloudant==2.3.1
	```
	{:pre}

## 第 1 步：连接到 {{site.data.keyword.Bluemix_notm}} 上的 {{site.data.keyword.cloudant_short_notm}} 服务实例

1.	运行 {{site.data.keyword.cloudant_short_notm}} 客户机库组件的以下“`import`”语句，以支持 Python 应用程序连接到 {{site.data.keyword.cloudant_short_notm}} 服务实例。
	```python
	from cloudant.client import Cloudant
	from cloudant.error import CloudantException
	from cloudant.result import Result, ResultByKey
	```
	{: codeblock}

2. 识别 {{site.data.keyword.cloudant_short_notm}} 服务凭证：
  1. 在 {{site.data.keyword.Bluemix_notm}} 控制台中，打开服务实例的仪表板。
  2. 在左侧导航中，单击**`服务凭证`**。
  3. 单击**`操作`**下的**`查看凭证`**。

3.	通过运行以下命令，建立与服务实例的连接。替换为先前步骤中获得的服务凭证：
	```python
	client = Cloudant("<username>", "<password>", url="<url>")
	client.connect()
	```
	{: codeblock}


## 第 2 步：创建数据库

1. 在 Python 应用程序中定义变量：
  ```python
  databaseName = "<yourDatabaseName>"
  ```
  {: codeblock}
  ... 其中，`<yourDatabaseName>` 是您希望为数据库提供的名称。
 

  > **注：**数据库名称必须以字母开头，并且只能包含小写字符 (a-z)、数字 (0-9) 以及以下任意字符：`_`、`$`、`(`、`)`、`+`、`-` 和 `/`。

2. 创建数据库：
  ```python
  myDatabase = client.create_database(databaseName)
  ```
  {: codeblock}

3. 确认数据库是否已成功创建：
  ```python
  if myDatabase.exists():
      print "'{0}' successfully created.\n".format(databaseName)
  ```
  {: codeblock}

## 第 3 步：将很小的数据集合存储为数据库中的文档

1. 定义数据的集合：
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

2. 使用 Python 代码“逐步”完成数据，并将其转换为 JSON 文档。每个文档都存储在数据库中：

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

请注意，我们会检查每个文档是否已成功创建。
{: tip}

## 第 4 步：通过查询检索数据

此时，一个小型数据集合已存储为数据库中的文档。您可以在数据库中对这些数据执行最少检索或完整检索。最少检索可获取_有关_文档的基本数据。完整检索还会包含文档_内_的数据。

* 要执行最少检索，请执行以下操作：
  1. 首先，请求数据库中所有文档的列表。
    ```python
    result_collection = Result(myDatabase.all_docs)
    ```      
    {: codeblock}

    此列表会作为数组返回。

  2. 显示数组中元素的内容。
    ```python
    print "Retrieved minimal document:\n{0}\n".format(result_collection[0])
    ```
    {: codeblock}

    结果类似于以下示例：
    
    ```
    [{u'value': {u'rev': u'1-106e76a2612ea13468b2f243ea75c9b1'}, u'id': u'14be111aac74534cf8d390eaa57db888', u'key': u'14be111aac74534cf8d390eaa57db888'}]
    ```
    {:screen}
    
    > **注：**`u'` 前缀仅指示 Python 显示的是 Unicode 字符串。 
    
    如果我们对显示内容做进一步整理，可以看到返回的最少文档详细信息与以下内容相同：
    
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

  > **注：**NoSQL 数据库（例如 {{site.data.keyword.cloudant_short_notm}}）的性质意味着一些简单的概念（例如，数据库中存储的第一个文档始终是结果列表中返回的第一个文档）不一定适用。

* 要执行完整检索，请请求数据库中所有文档的列表，并通过提供 `include_docs` 选项来指定还必须返回文档内容。
  ```python
  result_collection = Result(myDatabase.all_docs, include_docs=True)
  print "Retrieved full document:\n{0}\n".format(result_collection[0])
  ```
  {: codeblock}
  
  结果类似于以下示例：
  ```
  [{u'value': {u'rev': u'1-7130413a8c7c5f1de5528fe4d373045c'}, u'id': u'0cfc7d902f613d5fdb7b7818e262353b', u'key': u'0cfc7d902f613d5fdb7b7818e262353b', u'doc': {u'temperatureField': 40, u'descriptionField': u'hot', u'numberField': 2, u'nameField': u'two', u'_id': u'0cfc7d902f613d5fdb7b7818e262353b', u'_rev': u'1-7130413a8c7c5f1de5528fe4d373045c'}}]
  ```
  {: screen}
  
  如果我们对显示内容做进一步整理，可以看到返回的完整文档详细信息与以下内容相同：
  
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

## 第 5 步：通过 {{site.data.keyword.cloudant_short_notm}} API 端点检索数据

您还可以通过调用 {{site.data.keyword.cloudant_short_notm}} [`/_all_docs` 端点](api/database.html#get-documents)来请求所有文档及其内容的列表。

1. 确定要联系的端点，以及要随调用一起提供的任何参数：
  ```python
  end_point = '{0}/{1}'.format("<url>", databaseName + "/_all_docs")
  params = {'include_docs': 'true'}
  ```
  {: codeblock}
  ... 其中，`<url>` 是在第 1 步中找到的服务凭证中的 URL 值。


2. 向服务实例发送请求，然后显示的结果如下：
  ```python
  response = client.r_session.get(end_point, params=params)
  print "{0}\n".format(response.json())
  ```
  {: codeblock}

  结果类似于以下 _abbreviated_ 示例：
  
  ```
  {u'rows': [{u'value': {u'rev': u'1-6d8cb5905316bf3dbe4075f30daa9f59'}, u'id': u'0532feb6fd6180d79b842d871316c444', u'key': u'0532feb6fd6180d79b842d871316c444', u'doc': {u'temperatureField': 20, u'descriptionField': u'warm', u'numberField': 3, u'nameField': u'three', u'_id': u'0532feb6fd6180d79b842d871316c444', u'_rev': u'1-6d8cb5905316bf3dbe4075f30daa9f59'}}, ... , {u'value': {u'rev': u'1-3f61736fa96473d358365ce1665e3d97'}, u'id': u'db396f77bbe12a567b09177b4accbdbc', u'key': u'db396f77bbe12a567b09177b4accbdbc', u'doc': {u'temperatureField': 0, u'descriptionField': u'freezing', u'numberField': 5, u'nameField': u'five', u'_id': u'db396f77bbe12a567b09177b4accbdbc', u'_rev': u'1-3f61736fa96473d358365ce1665e3d97'}}], u'total_rows': 5, u'offset': 0}
  ```
  {:screen}
  
  我们可以对显示内容做进一步整理，可以看到返回的 _abbreviated_ 详细信息与以下内容相同：
  
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

## 第 6 步：删除数据库

完成对数据库的操作后，可以将其删除。

```python
try :
    client.delete_database(databaseName)
except CloudantException:
    print "There was a problem deleting '{0}'.\n".format(databaseName)
else:
    print "'{0}' successfully deleted.\n".format(databaseName)
```
{: codeblock}

我们已经包含了一些基本的错误处理，以说明可如何捕获并解决问题。

## 第 7 步：关闭与服务实例的连接

最后一步是断开 Python 客户机应用程序与服务实例的连接：

```python
client.disconnect()
```
{: codeblock}

## 后续步骤

有关所有 {{site.data.keyword.cloudant_short_notm}} 产品的更多信息，请参阅 [{{site.data.keyword.cloudant_short_notm}}![外部链接图标](images/launch-glyph.svg "外部链接图标")](http://www.ibm.com/analytics/us/en/technology/cloud-data-services/cloudant/){:new_window} 主站点。

有关 {{site.data.keyword.cloudant_short_notm}} 概念、任务和方法的更多详细信息和教程，请参阅 [{{site.data.keyword.cloudant_short_notm}} 文档](cloudant.html)。

## 附录：完整的 Python 代码清单

完整的 Python 代码清单如下所示。请务必将 `<username>`,
`<password>` 和 `<url>` 值替换为您的服务凭证。同样，将 `<yourDatabaseName>` 值替换为您的数据库的名称。

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
