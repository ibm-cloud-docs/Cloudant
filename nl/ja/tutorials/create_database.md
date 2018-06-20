---

copyright:
  years: 2017, 2018
lastupdated: "2017-11-07"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

# {{site.data.keyword.Bluemix_notm}} での単純 {{site.data.keyword.cloudant_short_notm}} データベースの作成とデータ取り込み

このチュートリアルでは、[Python プログラミング言語 ![「外部リンク」アイコン](../images/launch-glyph.svg "「外部リンク」アイコン")](https://www.python.org/){:new_window}
を使用して、{{site.data.keyword.Bluemix}} サービス・インスタンスに {{site.data.keyword.cloudantfull}} データベースを作成し、
データベースに単純なデータ・コレクションを取り込む方法を示しています。
{:shortdesc}

## 前提条件

チュートリアルを始める前に、以下のリソースまたは情報を準備してください。

### Python

[Python プログラミング言語 ![「外部リンク」アイコン](../images/launch-glyph.svg "「外部リンク」アイコン")](https://www.python.org/){:new_window}
の現行インストール済み環境がシステムにインストールされていなければなりません。

これを確認するには、プロンプトで以下のコマンドを実行します。

```sh
python --version
```
{:pre}

以下のような結果が表示されます。

```
Python 2.7.12
```
{:codeblock}

### {{site.data.keyword.cloudant_short_notm}} の Python クライアント・ライブラリー

Python アプリケーションが {{site.data.keyword.Bluemix_notm}} 上の {{site.data.keyword.cloudant_short_notm}}
と動作するための[公式サポート・ライブラリー](../libraries/supported.html#python)があります。

[ここ](../libraries/supported.html#python)に示された手順を使用して、これをインストールしてください。

クライアント・ライブラリーが正常にインストールされたことを確認するには、プロンプトで以下のコマンドを実行します。

```sh
pip freeze
```
{:pre}

システムにインストールされているすべての Python モジュールのリストが表示されます。
リストを調べ、以下のような {{site.data.keyword.cloudant_short_notm}} 項目を探します。

```
cloudant==2.3.1
```
{:codeblock}

### Bluemix 上の {{site.data.keyword.cloudant_short_notm}} サービス・インスタンス

適切なサービス・インスタンスを作成するためのプロセスについては、[別のチュートリアル](create_service.html)に説明があります。

サービス・インスタンスに関して以下のサービス資格情報を使用可能な状態にしてください。

フィールド      | 目的
-----------|--------
`host`     | アプリケーションがサービス・インスタンスを検索するために使用するホスト名。
`username` | アプリケーションがサービス・インスタンスにアクセスするために必要なユーザー名。
`password` | アプリケーションがサービス・インスタンスにアクセスするために必要なパスワード。
`port`     | ホスト上のサービス・インスタンスにアクセスするための HTTP ポート番号。 通常、443 で HTTPS アクセスを強制します。
`url`      | その他の資格情報を単一の URL に集約したストリング。アプリケーションによる使用に適しています。

サービス・インスタンスのサービス資格情報の検索に関する情報は、
[ここ](create_service.html#locating-your-service-credentials)にあります。

## コンテキスト

このチュートリアルでは、以下のタスクに適した一連の Python 言語命令を構築します。

1.  [{{site.data.keyword.Bluemix_notm}} 上の {{site.data.keyword.cloudant_short_notm}} サービス・インスタンスへの接続](#connecting-to-a-cloudant-service-instance-on-bluemix)。
2.  [サービス・インスタンス内のデータベースの作成](#creating-a-database-within-the-service-instance)。
3.  [小さなデータ・コレクションをデータベース内の文書として保管](#storing-a-small-collection-of-data-as-documents-within-the-database)。
4.  [文書の全リストを取得](#retrieving-a-complete-list-of-the-documents)。
5.  [データベースの削除](#deleting-the-database)。
6.  [サービス・インスタンスへの接続のクローズ](#closing-the-connection-to-the-service-instance)。

各タスクに対応した Python コードが、このチュートリアルのタスク説明の中で提供されます。

すべてのタスクを実行する完全な Python プログラムは、[このチュートリアルの最後](#complete-listing)に提供されています。

このチュートリアルでは、_効率的な_ Python コードの作成は意図していません。
仕組みを理解してアプリケーション作成時に参考にするための、単純で分かりやすい実際のコードを示すことを目的としています。

また、考えられるすべてのチェックおよびエラー条件には対応していません。
手法を示すためにサンプルのチェックがいくつか以下に示されていますが、
アプリケーションで発生する警告やエラー条件すべてをチェックして処理する通常のベスト・プラクティスを適用してください。 

## {{site.data.keyword.Bluemix_notm}} 上の {{site.data.keyword.cloudant_short_notm}} サービス・インスタンスへの接続

{{site.data.keyword.cloudant_short_notm}} クライアント・ライブラリー・コンポーネントがサービス・インスタンスに接続可能であることが、Python アプリケーションによって要求されます。
これらのコンポーネントは、以下のように通常の `import` ステートメントとして指定されます。

```python
from cloudant.client import Cloudant
from cloudant.error import CloudantException
from cloudant.result import Result, ResultByKey
```
{:codeblock}

アプリケーションには、以下のようなサービスの[サービス資格情報](create_service.html#locating-your-service-credentials)が必要です。

```python
serviceUsername = "353466e8-47eb-45ce-b125-4a4e1b5a4f7e-bluemix"
servicePassword = "49c0c343d225623956157d94b25d574586f26d1211e8e589646b4713d5de4801"
serviceURL = "https://353466e8-47eb-45ce-b125-4a4e1b5a4f7e-bluemix.cloudant.com"
```
{:codeblock}

>   **注**: ここで例に示したサービス資格情報は、
    デモの {{site.data.keyword.cloudant_short_notm}} サービスが Bluemix で作成されたときに定義されたものです。
    これらの資格情報は、Python アプリケーション内でどう使用されるかを示すためにここで再現されています。
    しかし、
    デモの {{site.data.keyword.cloudant_short_notm}} サービスはもう削除されているため、
    これらの資格情報は有効ではありません。
    _必ず_、ご自分のサービス資格情報を提供して使用してください。

アプリケーション内で Python クライアント・ライブラリーを有効にして、サービス資格情報を識別したら、
サービス・インスタンスへの接続を確立できます。

```python
client = Cloudant(serviceUsername, servicePassword, url=serviceURL)
client.connect()
```
{:codeblock}

この時点で、
Python アプリケーションは、Bluemix 上のサービス・インスタンスにアクセスできます。

## サービス・インスタンス内でのデータベースの作成

次のステップでは、サービス・インスタンス内でデータベース
`databasedemo` を作成します。

これを行うために、Python アプリケーションで変数を定義します。

```python
databaseName = "databasedemo"
```
{:codeblock}

その後、データベースを作成します。

```python
myDatabaseDemo = client.create_database(databaseName)
```
{:codeblock}

データベースが正常に作成されたことを確認することは、有益です。

```python
if myDatabaseDemo.exists():
    print "'{0}' successfully created.\n".format(databaseName)
```
{:codeblock}

## 小さなデータ・コレクションをデータベース内の文書として保管

ここで、小さくて単純なデータ・コレクションをデータベースに保管します。

まず、データを特定します。

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

次に、通常の Python コードで 1 つずつデータを処理し、
JSON 文書に変換します。
各文書は、以下のようにデータベースに保管されます。

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

各文書が正常に作成されたかを確認している点に注意してください。

## データの取得

この時点で、小規模なデータ・コレクションがデータベース内に文書として保管されています。
ここで、一連の照会を実行して、データベースからの異なるデータ取得方法を示します。

### 文書の最小限の取得

最小限の取得を実行するには、
まず、データベース内のすべての文書のリストを要求します。
このリストは、配列として返されます。
その後、配列内の要素の内容を表示できます。

サンプル・コードでは、データベースから取得される最初の文書を要求します。

```python
result_collection = Result(myDatabaseDemo.all_docs)
print "Retrieved minimal document:\n{0}\n".format(result_collection[0])
```
{:codeblock}

結果は、以下の例のようになります。

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

>   **注**: {{site.data.keyword.cloudant_short_notm}} などの NoSQL データベースの
    性質上、データベースに保管された最初の文書が結果リストで常に最初に戻されるという単純な概念は、必ずしも当てはまりません。

### 文書の全取得

全取得を実行するには、
データベース内のすべての文書のリストを要求し、
さらに、文書の内容も必ず戻すよう指定します。
これを行うには、`include_docs` オプションを使用します。
前と同様、結果は配列で戻されます。
その後、今回は文書の全内容を含めて、配列内の要素の詳細を表示できます。 

前と同様、データベースから取得される最初の文書を要求します。

```python
result_collection = Result(myDatabaseDemo.all_docs, include_docs=True)
print "Retrieved minimal document:\n{0}\n".format(result_collection[0])
```
{:codeblock}

結果は、以下の例のようになります。

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

## {{site.data.keyword.cloudant_short_notm}} API エンドポイントの直接呼び出し

Python アプリケーション内から {{site.data.keyword.cloudant_short_notm}} API エンドポイントを直接操作することも可能です。

このサンプル・コードでも、
内容も含めてすべての文書のリストを要求します。
ただし今回は、
{{site.data.keyword.cloudant_short_notm}} の [`/_all_docs` エンドポイント](../api/database.html#get-documents)を呼び出して、これを行います。

まず、コンタクトするエンドポイントと、呼び出しと一緒に提供するパラメーターを指定します。

```python
end_point = '{0}/{1}'.format(serviceURL, databaseName + "/_all_docs")
params = {'include_docs': 'true'}
```
{:codeblock}

次に、サービス・インスタンスに要求を送信し、結果を表示します。

```python
response = client.r_session.get(end_point, params=params)
print "{0}\n".format(response.json())
```
{:codeblock}

結果は、以下の例 (_一部省略_) のようになります。

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
            "value": {
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

## データベースの削除

データベースが不要になったら、削除できます。

これは、以下のサンプル Python コードに示したように単純なステップです。

```python
try :
    client.delete_database(databaseName)
except CloudantException:
    print "There was a problem deleting '{0}'.\n".format(databaseName)
else:
    print "'{0}' successfully deleted.\n".format(databaseName)
```
{:codeblock}

問題を検出して対処する方法を示すために、基本的なエラー処理が組み込まれています。

## サービス・インスタンスへの接続のクローズ

最終ステップとして、以下のように、Python クライアント・アプリケーションをサービス・インスタンスから切断します。

```python
client.disconnect()
```
{:codeblock}

## 全プログラムの表示

以下のコードは、{{site.data.keyword.Bluemix_notm}} 上の
{{site.data.keyword.cloudant_short_notm}} サービス・インスタンスにアクセスして、一般的な一連のタスクを実行するための完全な Python プログラムです。

1.  サービス・インスタンスへの接続。
2.  サービス・インスタンス内でのデータベースの作成。
3.  小さなデータ・コレクションをデータベース内の文書として保管。
4.  文書の全リストを取得。
5.  データベースの削除。
6.  サービス・インスタンスへの接続のクローズ。

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

# Use the {{site.data.keyword.cloudant_short_notm}} library to create a {{site.data.keyword.cloudant_short_notm}} client.
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

# Use a {{site.data.keyword.cloudant_short_notm}} API endpoint to retrieve
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
