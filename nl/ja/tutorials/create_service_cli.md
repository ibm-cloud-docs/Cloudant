---

copyright:
  years: 2017
lastupdated: "2017-05-22"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

# Cloud Foundry ツールを使用した Bluemix 上の Cloudant インスタンスの作成

このチュートリアルでは、Cloud Foundry ツールを使用して {{site.data.keyword.Bluemix_notm}} で
{{site.data.keyword.cloudantfull}} サービス・インスタンスを作成する方法を示します。
{:shortdesc}

## 前提条件

このチュートリアルを使用するには、
まず、{{site.data.keyword.Bluemix_notm}} Cloud Foundry ツールのインストールが必要です。
ツールのインストールに関する詳細は、
[別のチュートリアル](create_bmxapp_appenv.html#the-cloud-foundry-and-bluemix-command-toolkits)にあります。

> **注**: Cloud Foundry _および_
  {{site.data.keyword.Bluemix_notm}} の両方のツールキットを必ずインストールしてください。

## Bluemix API エンドポイントの識別

Cloud Foundry コマンドにターゲットの API エンドポイントを指定します。

```sh
bx api https://api.ng.bluemix.net
```
{:codeblock}

エンドポイントを正しく識別したことが結果で確認されます。

```sh
Setting api endpoint to https://api.ng.bluemix.net...
OK

API endpoint:   https://api.ng.bluemix.net (API version: 2.54.0)   
Not logged in. Use 'bx login' to log in.
```
{:pre}

## Bluemix アカウントへのログイン

1.  以下のコマンドを使用して、{{site.data.keyword.Bluemix_notm}} アカウントのログイン・プロセスを開始します。
  
  ```sh
  bx login
  ```
  {:codeblock}
  
  {{site.data.keyword.Bluemix_notm}} は、現行 API エンドポイントを示して応答します。
  その後、アカウントの E メール・アドレスが求められます。
  
  ```sh
  API endpoint: https://api.ng.bluemix.net
  
  Email>
  ```
  {:pre}

2.  アカウントの E メール・アドレスを入力します。
  その後、{{site.data.keyword.Bluemix_notm}} によって、アカウントのパスワードが求められます。
  ```sh
  API endpoint: https://api.ng.bluemix.net
  
  Email> J.Doe@email.com
  
  Password>
  ```
  {:pre}
  
  {{site.data.keyword.Bluemix_notm}} によって詳細が検証され、
  ログイン・セッションに関する情報が要約されます。
  ```sh
  API endpoint: https://api.ng.bluemix.net
  
  Email> J.Doe@email.com
  
  Password>
  Authenticating...
  OK

  Targeted account J DOE's Account (707...a32)

  Targeted org J.Doe@email.com

  Targeted space dev

  API endpoint:   https://api.ng.bluemix.net (API version: 2.54.0)
  Region:         us-south
  User:           j.doe@email.com
  Account:        J DOE's Account (707...a32)
  Org:            J.Doe@email.com
  Space:          dev
  ```
  {:pre}

3.  これで、{{site.data.keyword.Bluemix_notm}} アカウントにログインしました。

## サービスの Cloudant プランの選択

利用可能なすべてのサービス・オファリングのリストを入手します。
{{site.data.keyword.cloudant_short_notm}} サービスのみに一致するようにリストをフィルタリングします。

```sh
bx service offerings | grep -i Cloudant
```
{:codeblock}

結果として、選択可能な具体的なプランを含め、アカウントから利用可能な {{site.data.keyword.cloudant_short_notm}} サービスがリストされます。

```sh
cloudantNoSQLDB   Lite, Standard*
```
{:pre}

**オプション**: プランの詳細を表示するには、以下のコマンドを使用します。

```sh
bx cf marketplace -s cloudantNoSQLDB
```
{:codeblock}

結果として、次のセクションのサンプル応答 (2017 年 5 月現在の詳細) のような、利用可能なプランの要約が示されます。

```
Lite
The Lite plan provides access to the full functionality of Cloudant for development and evaluation.
The plan has a set amount of provisioned throughput capacity as shown
and includes a max of 1GB of encrypted data storage.   free
```
{:pre}

## Cloudant サービスの作成

{{site.data.keyword.Bluemix_notm}} 内にサービス・インスタンスを作成する基本コマンド・フォーマットは、以下のとおりです。

```sh
bx service create <service> <plan> <instance name>
```
{:pre}

`Lite` プランを使用して
{{site.data.keyword.cloudant_short_notm}} サービスのインスタンスを作成したいと想定します。
ここで、インスタンス名は `cs20170517a` です。

これを行うには、次の例のようなコマンドを使用します。

```sh
bx service create cloudantNoSQLDB Lite cs20170517a
```
{:codeblock}

サービス・インスタンスを作成すると、以下の例のようなメッセージで応答します。

```sh
Invoking 'cf create-service cloudantNoSQLDB Lite cs20170517a'...

Creating service instance cs20170517a in org J.Doe@email.com / space dev as J.Doe@email.com...
OK

```
{:pre}

## Cloudant サービスの資格情報の作成

{{site.data.keyword.cloudant_short_notm}} サービスへのアクセスを要求するアプリケーションには、必要な資格情報が必要です。

>   **注**: サービス資格情報は大切です。
    資格情報にアクセスできるユーザーやアプリケーションは、
    そのサービス・インスタンスで、偽造データの作成や重要情報の削除など、事実上何でも実行できることになります。
    これらの資格情報は、大切に保護してください。

サービス資格情報は、以下の 5 つのフィールドから構成されます。

フィールド| 目的
-----------|--------
`host`     | アプリケーションがサービス・インスタンスを検索するために使用するホスト名。
`username` | アプリケーションがサービス・インスタンスにアクセスするために必要なユーザー名。
`password` | アプリケーションがサービス・インスタンスにアクセスするために必要なパスワード。
`port`     | ホスト上のサービス・インスタンスにアクセスするための HTTP ポート番号。通常、443 で HTTPS アクセスを強制します。
`url`      | その他の資格情報を単一の URL に集約したストリング。アプリケーションによる使用に適しています。

{{site.data.keyword.Bluemix_notm}} 内のサービス・インスタンスの資格情報を作成する基本コマンド・フォーマットは、以下のとおりです。

```sh
bx cf create-service-key <instance name> <credentials name>
```
{:pre}

{{site.data.keyword.cloudant_short_notm}} サービスの `cs20170517a`
インスタンスの資格情報を作成したいと想定します。
ここで、資格情報の名前は `creds20170517a` です。

これを行うには、次の例のようなコマンドを使用します。

```sh
bx cf create-service-key cs20170517a creds20170517a
```
{:codeblock}

サービス・インスタンスの資格情報を作成する要求を受け取ると、
{{site.data.keyword.Bluemix_notm}} は、以下の例のようなメッセージで応答します。

```sh
Invoking 'cf create-service-key cs20170517a creds20170517a'...

Creating service key creds20170517a for service instance cs20170517a as J.Doe@email.com...
OK
```
{:pre}

## Cloudant サービスのサービス資格情報のリスト

{{site.data.keyword.Bluemix_notm}} 内のサービス・インスタンスの資格情報を取得する基本コマンド・フォーマットは、以下のとおりです。

```sh
bx cf service-key <instance name> <credentials name>
```
{:pre}

{{site.data.keyword.cloudant_short_notm}} サービスの `cs20170517a`
インスタンスの資格情報を取得したいと想定します。
ここで、資格情報の名前は `creds20170517a` です。

これを行うには、次の例のようなコマンドを使用します。

```sh
bx cf service-key cs20170517a creds20170517a
```
{:codeblock}

サービス・インスタンスの資格情報を取得する要求を受け取ると、
{{site.data.keyword.Bluemix_notm}} は、以下の (省略された) 例のようなメッセージで応答します。

```sh
Invoking 'cf service-key cs20170517a creds20170517a'...

Getting key creds20170517a for service instance cs20170517a as J.Doe@email.com...

{
 "host": "946...46f-bluemix.cloudant.com",
 "password": "4eb...eb5",
 "port": 443,
 "url": "https://946...46f-bluemix:4eb...eb5@946...46f-bluemix.cloudant.com",
 "username": "946...46f-bluemix"
}
```
{:pre}

## Cloudant サービス・インスタンスの使用

この時点で、以下が完了しています。

1.  {{site.data.keyword.Bluemix_notm}} 内に {{site.data.keyword.cloudant_short_notm}} サービス・インスタンスを作成しました
2.  {{site.data.keyword.cloudant_short_notm}} サービス・インスタンスの資格情報を作成しました。
3.  サービス・インスタンスの資格情報を取得しました。これらは、アプリケーションで使用できます。

{{site.data.keyword.cloudant_short_notm}} サービス・インスタンスの使用方法を示したチュートリアルについては、
[ここ](create_database.html#context)を参照してください。
必ず、このチュートリアルで作成した資格情報を使用してください。

## (オプション) 事後のタイディアップ (整理)

開発環境のタイディアップ (整理) では、以下のいくつかのコマンドを利用できます。

### サービス資格情報の削除

一連のサービス資格情報を削除するには、次のようなコマンドを使用します。

```sh
bx cf delete-service-key <instance name> <credentials name>
```
{:pre}

例えば、{{site.data.keyword.cloudant_short_notm}} サービスの `cs20170517a`
インスタンスから資格情報 `creds20170517a` を削除するには、以下のようなコマンドを使用します。

```sh
bx cf delete-service-key cs20170517a creds20170517a
```
{:pre}

### サービス・インスタンスの削除

サービス・インスタンスを削除するには、以下のようなコマンドを使用します。

```sh
bx service delete <instance name>
```
{:pre}

例えば、{{site.data.keyword.cloudant_short_notm}} サービスの `cs20170517a`
インスタンスを削除するには、以下のようなコマンドを使用します。

```sh
bx service delete cs20170517a
```
{:pre}

