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

# 在 Bluemix 上创建并填充简单 Cloudant 数据库

本教程说明了如何使用 [Python 编程语言 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://www.python.org/){:new_window} 在 {{site.data.keyword.Bluemix_notm}} 服务实例中创建 {{site.data.keyword.cloudantfull}} 数据库，并使用简单数据集合来填充数据库。
{:shortdesc}

## 先决条件

在开始学习本教程之前，请确保以下资源或信息已准备就绪。

### Python

必须在系统上安装最新版本的 [Python 编程语言 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://www.python.org/){:new_window}。

要检查版本，请在提示符处运行以下命令：

```sh
python --version
```
{:pre}

您应该会获得类似于以下内容的结果：

```
Python 2.7.12
```
{:codeblock}

### Cloudant 的 Python 客户机库

有一个[官方支持的库](../libraries/supported.html#python)，能使 Python 应用程序与 {{site.data.keyword.Bluemix_notm}} 上的 {{site.data.keyword.cloudant_short_notm}} 配合使用。

您应该使用[此处](../libraries/supported.html#python)提供的指示信息安装此库。

要检查是否已成功安装该客户机库，请在提示符处运行以下命令：

```sh
pip freeze
```
{:pre}

您应该会获得系统上安装的所有 Python 模块的列表。检查该列表，查找类似于以下内容的 {{site.data.keyword.cloudant_short_notm}} 条目：

```
cloudant==2.3.1
```
{:codeblock}

### Bluemix 上的 Cloudant 服务实例

[本教程](create_service.html)中描述了创建适用服务实例的过程。

确保有以下服务凭证可用于服务实例：

字段       | 用途
-----------|--------
`host`     | 应用程序用于查找服务实例的主机名。
`username` | 应用程序访问服务实例所需的用户名。
`password` | 应用程序访问服务实例所需的密码。
`port`     | 用于访问主机上服务实例的 HTTP 端口号。通常为 443，可强制执行 HTTPS 访问。
`url`      | 将其他凭证信息聚集到单个 URL 中（使其适合应用程序使用）的字符串。

[此处](create_service.html#locating-your-service-credentials)提供了有关查找服务实例的服务凭证的信息。

## 上下文

本教程构建了一系列 Python 语言指示信息，适用于以下任务：

1.  [连接到 {{site.data.keyword.Bluemix_notm}} 上的 {{site.data.keyword.cloudant_short_notm}} 服务实例](#connecting-to-a-cloudant-service-instance-on-bluemix)。
2.  [在服务实例中创建数据库](#creating-a-database-within-the-service-instance)。
3.  [将一个小型数据集合存储为数据库中的文档](#storing-a-small-collection-of-data-as-documents-within-the-database)。
4.  [检索文档的完整列表](#retrieving-a-complete-list-of-the-documents)。
5.  [删除数据库](#deleting-the-database)。
6.  [关闭与服务实例的连接](#closing-the-connection-to-the-service-instance)。

在本教程的任务描述中提供了特定于每个任务的 Python 代码。

本教程末尾（[此处](#complete-listing)）提供了用于执行所有任务的完整 Python 程序。

我们没有尝试为本教程创建_高效_ Python 代码；本教程的目的是为了说明简单易懂的有效代码，方便您从中学习并应用于自己的应用程序。

此外，我们也未尝试解决所有可能的检查或错误条件。教程中显示了一些示例检查，用于说明各种方法，但您应该应用标准最佳实践来检查和处理自己的应用程序遇到的所有警告或错误条件。 

## 连接到 Bluemix 上的 Cloudant 服务实例

Python 应用程序需要 Cloudant 客户机库组件才能连接到服务实例。这些组件通过标准 `import` 语句确定：

```python
from cloudant.client import Cloudant
from cloudant.error import CloudantException
from cloudant.result import Result, ResultByKey
```
{:codeblock}

应用程序必须具有服务的[服务凭证](create_service.html#locating-your-service-credentials)：

```python
serviceUsername = "353466e8-47eb-45ce-b125-4a4e1b5a4f7e-bluemix"
servicePassword = "49c0c343d225623956157d94b25d574586f26d1211e8e589646b4713d5de4801"
serviceURL = "https://353466e8-47eb-45ce-b125-4a4e1b5a4f7e-bluemix.cloudant.com"
```
{:codeblock}

>   **注**：此处说明的服务凭证
是在 Bluemix 上创建演示 Cloudant 服务时定义的。在此重现这些凭证，是为了说明如何在 Python 应用程序中使用这些凭证。但是，现在已除去了演示 Cloudant 服务，因此这些凭证不再有效；您_必须_提供并使用自己的服务凭证。

只要在应用程序中启了 Python 客户机库并确定了服务凭证，就可以建立与服务实例的连接：

```python
client = Cloudant(serviceUsername, servicePassword, url=serviceURL)
client.connect()
```
{:codeblock}

此时，Python 应用程序已有权访问 Bluemix 上的服务实例。

## 在服务实例中创建数据库

下一步是在服务实例中创建名为 `databasedemo` 的数据库。

我们通过在 Python 应用程序中定义变量来执行此操作：

```python
databaseName = "databasedemo"
```
{:codeblock}

然后，创建数据库：

```python
myDatabaseDemo = client.create_database(databaseName)
```
{:codeblock}

有必要检查是否已成功创建数据库：

```python
if myDatabaseDemo.exists():
    print "'{0}' successfully created.\n".format(databaseName)
```
{:codeblock}

## 将一个小型数据集合存储为数据库中的文档

现在，我们希望在数据库中存储一个简单的小型数据集合。

首先确定一些数据：

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

接下来，一些常用 Python 代码会“逐步”处理数据，并将其转换为 JSON 文档。每个文档都存储在数据库中：

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

请注意，我们会检查每个文档是否已成功创建。


## 检索数据

此时，一个小型数据集合已存储为数据库中的文档。现在，我们可以执行一系列查询，说明在数据库中检索数据的不同方法。

### 文档最少检索

要执行最少检索，首先请求数据库中所有文档的列表。此列表会作为数组返回。然后，可以显示数组中元素的内容。

在样本代码中，我们请求在数据库中检索到的第一个文档：

```python
result_collection = Result(myDatabaseDemo.all_docs)
print "Retrieved minimal document:\n{0}\n".format(result_collection[0])
```
{:codeblock}

结果类似于以下示例：

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

>   **注**：NoSQL 数据库（如 Cloudant）的性质
代表了简单的概念，也就是数据库中存储的第一个文档始终是结果列表中返回的第一个文档，但在此情况下不一定适用。

### 文档完整检索

为了执行完整检索，我们将请求数据库中所有文档的列表，此外将指定还必须返回文档内容。我们使用 `include_docs` 选项来执行此操作。与先前一样，结果也将作为数组返回。然后，可以显示数组中元素的详细信息，这次包含的是文档的完整内容。 

与先前一样，我们请求在数据库中检索到的第一个文档：

```python
result_collection = Result(myDatabaseDemo.all_docs, include_docs=True)
print "Retrieved minimal document:\n{0}\n".format(result_collection[0])
```
{:codeblock}

结果类似于以下示例：

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

## 直接调用 Cloudant API 端点

我们还可以在 Python 应用程序中直接使用 Cloudant API 端点。

在此示例代码中，我们将再次请求包含所有文档（包括其内容）的列表。但是，这次是通过调用 Cloudant [`/_all_docs` 端点](../api/database.html#get-documents)来执行此操作。

首先，确定要联系的端点，以及要随调用一起提供的任何参数：

```python
end_point = '{0}/{1}'.format(serviceURL, databaseName + "/_all_docs")
params = {'include_docs': 'true'}
```
{:codeblock}

接下来，向服务实例发送请求，然后显示的结果如下：

```python
response = client.r_session.get(end_point, params=params)
print "{0}\n".format(response.json())
```
{:codeblock}

结果类似于以下 _abbreviated_ 示例：

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

## 删除数据库

完成对数据库的操作后，可以将其删除。

这是一个简单的步骤，如以下样本 Python 代码中所示：

```python
try :
    client.delete_database(databaseName)
except CloudantException:
    print "There was a problem deleting '{0}'.\n".format(databaseName)
else:
    print "'{0}' successfully deleted.\n".format(databaseName)
```
{:codeblock}

我们已经包含了一些基本的错误处理，以说明可如何捕获并解决问题。

## 关闭与服务实例的连接

最后一步是断开 Python 客户机应用程序与服务实例的连接：

```python
client.disconnect()
```
{:codeblock}

## 完整清单

以下代码是完整的 Python 程序，可用于访问 {{site.data.keyword.Bluemix_notm}} 上的 {{site.data.keyword.cloudant_short_notm}} 服务实例，执行一系列典型任务：

1.  连接到服务实例。
2.  在服务实例中创建数据库。
3.  将一个小型数据集合存储为数据库中的文档。
4.  检索文档的完整列表。
5.  删除数据库。
6.  关闭与服务实例的连接。

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
