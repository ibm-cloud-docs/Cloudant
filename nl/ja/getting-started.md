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

# 入門チュートリアル
{: #getting-started}

この {{site.data.keyword.cloudantfull}} 入門チュートリアルでは、Python を使用して、{{site.data.keyword.cloudant_short_notm}} データベースを作成し、そのデータベースにシンプルなデータ・コレクションを取り込みます。
{: shortdesc}

このチュートリアルに加えて、{{site.data.keyword.cloudant_short_notm}} について詳しく知りたい場合に役立つ実践チュートリアルを参照してください。 または、特定の言語に焦点を当てたチュートリアルの 1 つを試してみてください。

- [Liberty for Java および {{site.data.keyword.cloudant_short_notm}} ![外部リンク・アイコン](images/launch-glyph.svg "外部リンク・アイコン")](https://cloud.ibm.com/docs/runtimes/liberty/getting-started.html#getting-started-tutorial){: new_window}
- [Node.js および {{site.data.keyword.cloudant_short_notm}} ![外部リンク・アイコン](images/launch-glyph.svg "外部リンク・アイコン")](https://cloud.ibm.com/docs/runtimes/nodejs/getting-started.html#getting-started-tutorial){: new_window}
- [Swift および {{site.data.keyword.cloudant_short_notm}} ![外部リンク・アイコン](images/launch-glyph.svg "外部リンク・アイコン")](https://cloud.ibm.com/docs/runtimes/swift/getting-started.html#getting-started-tutorial){: new_window}

その他の言語固有のチュートリアルについては、『[Get started by deploying your first app ![外部リンク・アイコン](images/launch-glyph.svg "外部リンク・アイコン")](https://cloud.ibm.com/docs){: new_window}』を参照してください。 

## 始める前に
{: #prereqs}

[{{site.data.keyword.cloud}} アカウント ![外部リンク・アイコン](images/launch-glyph.svg "外部リンク・アイコン")](https://cloud.ibm.com/registration/){: new_window} および {{site.data.keyword.cloudant_short_notm}} サービスのインスタンスが必要であり、また以下の Python 要件が満たされている必要があります。

*	最新バージョンの
	[Python プログラミング言語 ![外部リンク・アイコン](images/launch-glyph.svg "外部リンク・アイコン")](https://www.python.org/){: new_window} をシステムにインストールします。
	
	確認するには、プロンプトで以下のコマンドを実行します。
	```sh
	python --version
	```
	{: pre}
	
	次のような結果が表示されます。

	```
	Python 2.7.12
	```
	{: screen}

*	Python ライブラリーをインストールして、
Python アプリケーションで {{site.data.keyword.cloudant_short_notm}} 上の
{{site.data.keyword.cloud_notm}} を処理できるようにします。
	
	クライアント・ライブラリーが既にインストールされていることを確認するには、プロンプトで以下のコマンドを実行します。
	```sh
	pip freeze
	```
	{: pre}
	
	システムにインストールされているすべての Python モジュールのリストが表示されます。 リストを調べ、以下のような {{site.data.keyword.cloudant_short_notm}} 項目を探します。

	```
	cloudant==<version>
	```
	{: screen}
	
	`cloudant` モジュールがインストールされていない場合は、以下のようなコマンドを使用してインストールします。
	
	```
	pip install cloudant
	```
	{: pre}
  
  Python ライブラリーについて詳しくは、『[サポートされているプラットフォーム](/docs/services/Cloudant/libraries/supported.html#python)』文書を参照してください。 

## ステップ 1: {{site.data.keyword.cloudant_short_notm}} 上の {{site.data.keyword.cloud_notm}} サービス・インスタンスに接続する
{: #step-1-connect-to-your-cloudant-nosql-db-service-instance-on-ibm-cloud}

1.	{{site.data.keyword.cloudant_short_notm}} クライアント・ライブラリー・コンポーネントの `import` ステートメントを実行して、Python アプリケーションが {{site.data.keyword.cloudant_short_notm}} サービス・インスタンスに接続できるようにします。
	```python
	from cloudant.client import Cloudant
	from cloudant.error import CloudantException
	from cloudant.result import Result, ResultByKey
	```
	{: codeblock}

2.  次の手順を実行して、{{site.data.keyword.cloudant_short_notm}} サービス資格情報を作成します。
  <br>{{site.data.keyword.cloud_notm}} ダッシュボードで、**「メニュー」**アイコン > **「リソース・リスト」**と移動して、{{site.data.keyword.cloudant_short_notm}} サービス・インスタンスを開きます。
  <br>メニューで、`「サービス資格情報」`をクリックします。
  <br>a. `「新規資格情報」`ボタンをクリックします。
  <br>![新規サービス資格情報の作成](tutorials/images/img0050.png)
  <br>b. 次のスクリーン・ショットに示されているように、「新規資格情報の追加」ウィンドウで新規資格情報の名前を入力します。
  <br>c. (オプション) インライン構成パラメーターを追加します。
  <br>d. `「追加」`ボタンをクリックします。 
  <br>![新規サービス資格情報の追加](tutorials/images/img0051.png)
  <br>資格情報が「サービス資格情報」テーブルに追加されます。
  <br>e.「アクション」で`「資格情報の表示」`をクリックします。 
  <br>![すべてのサービス資格情報の表示](tutorials/images/img0052.png)
  <br>以下のようにサービス資格情報の詳細が表示されます。
   <br>![{{site.data.keyword.cloudant_short_notm}} サービス資格情報](tutorials/images/img0009.png)
   
3.	{{site.data.keyword.cloudant_short_notm}} サービス・インスタンスへの接続を確立します。 これを実行する手段は、{{site.data.keyword.cloud_notm}} IAM を使用しているか、または {{site.data.keyword.cloudant_short_notm}} のレガシー認証を使用しているかによって異なります。 これらの認証タイプについて詳しくは、[{{site.data.keyword.cloud_notm}} Identity and Access Management (IAM) ガイド](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-)を参照してください。

	{{site.data.keyword.cloudant_short_notm}} のレガシー認証を使用している場合は、以下のようにして、前のステップからのサービス資格情報を置き換えてください。
	```python
	client = Cloudant("<username>", "<password>", url="<url>")
	client.connect()
	```
	{: codeblock}
	
	IAM 認証を使用している場合は、以下のようにして、前のステップからのサービス資格情報を置き換えてください。
	```python
	client = Cloudant.iam("<username>", "<apikey>")
	client.connect()
	```
	{: codeblock}


## ステップ 2: データベースを作成する
{: #step-2-create-a-database}

1. 以下のように、Python アプリケーションで変数を定義します。
  ```python
  databaseName = "<your-database-name>"
  ```
  {: codeblock}

  ここで `<your-database-name>` は、データベースに付ける名前です。 

  データベース名は、文字で始まる必要があり、小文字 (a から z)、数字 (0 から 9)、記号 `_`、`$`、`(`、 `)`、`+`、`-`、および `/` のみを含むことができます。
  {: warning}

2. 以下のように、データベースを作成します。
  ```python
  myDatabase = client.create_database(databaseName)
  ```
  {: codeblock}

3. 以下のように、データベースが正常に作成されたことを確認します。
  ```python
  if myDatabase.exists():
      print "'{0}' successfully created.\n".format(databaseName)
  ```
  {: codeblock}

## ステップ 3: データベース内に文書として小規模なデータ・コレクションを保管する
{: #step-3-store-a-small-collection-of-data-as-documents-within-the-database}

1. 以下のように、データ・コレクションを定義します。
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

2. Python コードを使用して、データを順に処理し、JSON 文書に変換します。
  各文書は、以下のようにデータベースに保管されます。

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

  各文書が正常に作成されたかを確認することに注意してください。
  {: tip}

## ステップ 4: 照会を介してデータを取得する
{: #step-4-retrieving-data-through-queries}

小規模なデータ・コレクションがデータベース内に文書として保管されました。
データベースからのそのデータの最小限の取得または完全な取得を実行します。
最小限の取得では、文書_に関する_ 基本データを取得します。
完全な取得では、文書_内の_ データも含まれます。

* 最小限に取得を実行するには、以下のようにします。
  1. まず、データベース内のすべての文書のリストを要求します。
    ```python
    result_collection = Result(myDatabase.all_docs)
    ```      
    {: codeblock}

    このリストは、配列として返されます。

  2. 配列内の要素の内容を表示します。
    ```python
    print "Retrieved minimal document:\n{0}\n".format(result_collection[0])
    ```
    {: codeblock}

    結果は、以下の例のようになります。
    
    ```
    [{u'value': {u'rev': u'1-106e76a2612ea13468b2f243ea75c9b1'}, u'id': u'14be111aac74534cf8d390eaa57db888', u'key': u'14be111aac74534cf8d390eaa57db888'}]
    ```
    {: screen}
    
    `u` 接頭部は、Python が Unicode ストリングを表示していることを示す標識です。 
    {: tip}

    外観を少々整えると、返された最小限の文書明細が以下の例に相当することが分かります。
    
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

    {{site.data.keyword.cloudant_short_notm}} などの NoSQL データベースでは、データベースに保管されている最初の文書が、結果のリストでは最初に返されない場合もあるため注意が必要です。
    {: note}

* 完全な取得を実行するには、データベース内のすべての文書のリストを要求し、`include_docs` オプションを指定することで、文書の内容も返す必要があることを指定します。
  ```python
  result_collection = Result(myDatabase.all_docs, include_docs=True)
  print "Retrieved full document:\n{0}\n".format(result_collection[0])
  ```
  {: codeblock}
  
  結果は、以下の例のようになります。
  ```
  [{u'value': {u'rev': u'1-7130413a8c7c5f1de5528fe4d373045c'}, u'id': u'0cfc7d902f613d5fdb7b7818e262353b', u'key': u'0cfc7d902f613d5fdb7b7818e262353b', u'doc': {u'temperatureField': 40, u'descriptionField': u'hot', u'numberField': 2, u'nameField': u'two', u'_id': u'0cfc7d902f613d5fdb7b7818e262353b', u'_rev': u'1-7130413a8c7c5f1de5528fe4d373045c'}}]
  ```
  {: screen}
  
  外観を少々整えると、返された完全な文書明細が以下の例に相当することが分かります。
  
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

## ステップ 5: {{site.data.keyword.cloudant_short_notm}} API エンドポイントを介してデータを取得する
{: #step-5-retrieving-data-through-the-cloudant-nosql-db-api-endpoint}

{{site.data.keyword.cloudant_short_notm}} [`/_all_docs` エンドポイント](/docs/services/Cloudant?topic=cloudant-databases#get-documents)を呼び出すことで、すべての文書のリストとその内容を要求することもできます。

1. 以下のように、接続するエンドポイント、および呼び出しで渡すパラメーターを指定します。
  ```python
  end_point = '{0}/{1}'.format("client.server_url", databaseName + "/_all_docs")
  params = {'include_docs': 'true'}
  ```
  {: codeblock}
  ... ここで、`client.server_url` は、ステップ 1 で確認したサービス資格情報からの URL 値です。

2. 以下のように、要求をサービス・インスタンスに送信し、結果を表示します。
  ```python
  response = client.r_session.get(end_point, params=params)
  print "{0}\n".format(response.json())
  ```
  {: codeblock}

  結果は、以下の例 (_一部省略_) のようになります。
  
  ```
  {u'rows': [{u'value': {u'rev': u'1-6d8cb5905316bf3dbe4075f30daa9f59'}, u'id': u'0532feb6fd6180d79b842d871316c444', u'key': u'0532feb6fd6180d79b842d871316c444', u'doc': {u'temperatureField': 20, u'descriptionField': u'warm', u'numberField': 3, u'nameField': u'three', u'_id': u'0532feb6fd6180d79b842d871316c444', u'_rev': u'1-6d8cb5905316bf3dbe4075f30daa9f59'}}, ... , {u'value': {u'rev': u'1-3f61736fa96473d358365ce1665e3d97'}, u'id': u'db396f77bbe12a567b09177b4accbdbc', u'key': u'db396f77bbe12a567b09177b4accbdbc', u'doc': {u'temperatureField': 0, u'descriptionField': u'freezing', u'numberField': 5, u'nameField': u'five', u'_id': u'db396f77bbe12a567b09177b4accbdbc', u'_rev': u'1-3f61736fa96473d358365ce1665e3d97'}}], u'total_rows': 5, u'offset': 0}
  ```
  {: screen}
  
  外観を少々整えると、返された明細 (_一部省略_) が、以下の例のようなものであることが分かります。
  
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
              "value": {
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

## (オプション) ステップ 6: {{site.data.keyword.cloudant_short_notm}} ダッシュボードでデータベース情報を確認する
{: #optional-step-6-ibm-cloudant-dashboard}

以下のステップを実行して、{{site.data.keyword.cloudant_short_notm}} ダッシュボードにデータベースと文書を表示します。 

1.  IBM Cloud アカウントにログインします。
    IBM Cloud ダッシュボードは、https://cloud.ibm.com/ にあります。 ユーザー名とパスワードで認証すると、IBM Cloud ダッシュボードが表示されます。
2.  「リソースの要約」ペインで**「サービス」**をクリックして、{{site.data.keyword.cloudant_short_notm}} サービス・インスタンスを表示します。 
3.  詳細を表示するサービス・インスタンスをクリックします。
4.  **「Cloudant ダッシュボードの起動」**をクリックします。 
    ダッシュボードが開いたら、サービスに関連付けられたデータベースを確認できます。


## ステップ 7: データベースを削除する
{: #step-7-delete-the-database}

データベースの処理が終わったら、データベースを削除できます。

```python
try :
    client.delete_database(databaseName)
except CloudantException:
    print "There was a problem deleting '{0}'.\n".format(databaseName)
else:
    print "'{0}' successfully deleted.\n".format(databaseName)
```
{: codeblock}

潜在的な問題のトラブルシューティング方法および対処方法を示すために、
基本的なエラー処理を組み込みました。

## ステップ 8: サービス・インスタンスへの接続を閉じる
{: #step-8-close-the-connection-to-the-service-instance}

最終ステップとして、以下のように、Python クライアント・アプリケーションをサービス・インスタンスから切断します。

```python
client.disconnect()
```
{: codeblock}

## 次のステップ
{: #next-steps}

すべての {{site.data.keyword.cloudant_short_notm}} オファリングについて詳しくは、
メインの [{{site.data.keyword.cloudant_short_notm}} ![外部リンク・アイコン](images/launch-glyph.svg "外部リンク・アイコン")](https://www.ibm.com/cloud/cloudant){: new_window} サイトを参照してください。

詳しくは、[{{site.data.keyword.cloudant_short_notm}} 資料](/docs/services/Cloudant?topic=cloudant-overview#overview)内のチュートリアル、{{site.data.keyword.cloudant_short_notm}} の概念、タスク、および技法を参照してください。

## 付録: 完全な Python コード・リスト
{: #appendix-complete-python-code-listing}

完全な Python コード・リストは、以下のとおりです。 
必ず、`<username>`、`<password>`、`<url>`、および `<apikey>` の値をご使用のサービス資格情報に置き換えてください。
同様に、`<yourDatabaseName>` の値をご使用のデータベースの名前に置き換えてください。

```python
from cloudant.client import Cloudant
from cloudant.error import CloudantException
from cloudant.result import Result, ResultByKey

# {{site.data.keyword.cloudant_short_notm}} Legacy authentication
client = Cloudant("<username>", "<password>", url="<url>")
client.connect()

# IAM Authentication (uncomment if needed, and comment out previous {{site.data.keyword.cloudant_short_notm}} Legacy authentication section)
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
