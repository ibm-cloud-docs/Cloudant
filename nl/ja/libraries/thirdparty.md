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

# サード・パーティーのクライアント・ライブラリー

>   **注**: サード・パーティーのクライアント・ライブラリーは、{{site.data.keyword.cloudantfull}} によって保守およびサポートされていません。

## サード・パーティーのモバイル・ライブラリー

{{site.data.keyword.cloudant_short_notm}} データベースの操作

-   [IBM Worklight Powered Native Objective-C iOS アプリ ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](http://www.tricedesigns.com/2014/11/17/ibm-worklight-powered-native-objective-c-ios-apps/){:new_window} ({{site.data.keyword.cloudant_short_notm}} アダプター付き)。

## C# / .NET

[MyCouch![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://github.com/danielwertheim/mycouch){:new_window} は、.Net 用の非同期 CouchDB および {{site.data.keyword.cloudant_short_notm}} クライアントです。

ライブラリーをインストールするには、Package Manager コンソールを開き、以下を起動します。

```
install-package mycouch.cloudant
```
{:codeblock}

### C# / .NET のライブラリーおよびフレームワーク

-   [MyCouch ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://github.com/danielwertheim/mycouch){:new_window}。
-   [LoveSeat ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://github.com/soitgoes/LoveSeat){:new_window}。
-   [Divan ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://github.com/foretagsplatsen/Divan){:new_window}。
-   [Relax ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://github.com/arobson/Relax){:new_window}。
-   [Hammock ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](http://code.google.com/p/relax-net/){:new_window}。
-   [EasyCouchDB ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://github.com/hhariri/EasyCouchDB){:new_window}。
-   [Kanapes IDE ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](http://kanapeside.com/){:new_window} の `WDK.API.CouchDB`。

### C# / .NET の例およびチュートリアル

-   [CRUD ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://github.com/cloudant/haengematte/tree/master/c%23){:new_window}。

## PHP

[Sag ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://github.com/sbisbee/sag){:new_window} は、PHP の CouchDB および {{site.data.keyword.cloudant_short_notm}} のクライアントです。
[Sag.js ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://github.com/sbisbee/sag-js){:new_window} は、Sag の JavaScript ライブラリーです。

インストールするには、`sag` を [https://github.com/sbisbee/sag ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://github.com/sbisbee/sag){:new_window} からダウンロードし、以下のようにライブラリーをアプリケーションに組み込みます。

```
require_once('./src/Sag.php');
```
{:codeblock}

### PHP のライブラリーおよびフレームワーク

-   [sag ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://github.com/sbisbee/sag){:new_window}。
-   [Doctrine CouchDB Client ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://github.com/doctrine/couchdb-client){:new_window}。
-   [PHP-on-Couch ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://github.com/dready92/PHP-on-Couch){:new_window}。

### PHP の例およびチュートリアル

-   [CRUD ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://github.com/cloudant/haengematte/tree/master/php){:new_window}。

## JavaScript

[PouchDB ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](http://pouchdb.com/){:new_window} は、{{site.data.keyword.cloudant_short_notm}} と同期できる JavaScript データベースです。つまり、PouchDB を使用するだけで、アプリをオフライン対応にすることができます。
詳細情報については、PouchDB に関する[ブログ投稿 ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://cloudant.com/blog/pouchdb){:new_window} を参照してください。

PouchDB の取得、およびセットアップの詳細については、[PouchDB ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](http://pouchdb.com/){:new_window} を参照してください。

>   **注**: PouchDB は、Node.js 用も入手できます。`npm install pouchdb`。

>   **注**: PouchDB は、Bower でもインストールできます。`bower install pouchdb`。

### JavaScript のライブラリーおよびフレームワーク

-   [Backbone.cloudant ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://github.com/cloudant-labs/backbone.cloudant){:new_window}。
    詳しくは、[ブログ投稿![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://cloudant.com/blog/backbone-and-cloudant/){:new_window} を参照してください。
-   [sag.js ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://github.com/sbisbee/sag-js){:new_window}。
-   [PouchDB ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](http://pouchdb.com/){:new_window} - ブラウザー用 JavaScript データベース (オフライン同期付き)。

### JavaScript の例およびチュートリアル

-   [CRUD![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://github.com/cloudant/haengematte/tree/master/javascript-jquery){:new_window} (jQuery を使用)。
-   [CSVtoCloudant ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://github.com/michellephung/CSVtoCloudant){:new_window} - `.csv` ファイルを {{site.data.keyword.cloudant_short_notm}} にインポートするための UI。
    このアプリには、[ここ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://michellephung.github.io/CSVtoCloudant/){:new_window} からもアクセスできます。
-   [csv2couchdb ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://github.com/Mango-information-systems/csv2couchdb){:new_window} - `csv` ファイルを CouchDB/{{site.data.keyword.cloudant_short_notm}} にインポートするための Mango Systems からの UI。
-   [songblog ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://github.com/millayr/songblog){:new_window} - JQuery を使用するサンプル・アプリ。
-   [PouchDB Getting Started Guide![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](http://pouchdb.com/getting-started.html){:new_window} - ブラウザーから {{site.data.keyword.cloudant_short_notm}} または CouchDB に同期する、サンプル Todo アプリケーション。
-   [locationtracker![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://github.com/rajrsingh/locationtracker){:new_window} - PouchDB、CouchApp、および {{site.data.keyword.cloudant_short_notm}} を使用してロケーションを記録およびマップするサンプル・アプリ。

## Ruby

[CouchRest ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://github.com/couchrest/couchrest){:new_window} は、[CouchRest Model ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://github.com/couchrest/couchrest_model){:new_window} を使用して Rails を操作するための拡張機能を備えた CouchDB および {{site.data.keyword.cloudant_short_notm}} のクライアントです。

CouchRest をインストールするには、次のコマンドを実行します。

```sh
gem install couchrest
```
{:codeblock}

### Ruby のライブラリーおよびフレームワーク

[Ruby Toolbox ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://www.ruby-toolbox.com/categories/couchdb_clients){:new_window} には多くの CouchDB クライアントがリストされています。

### Ruby の例およびチュートリアル

-   [CRUD ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://github.com/cloudant/haengematte/tree/master/ruby){:new_window}。

<div id="couchdb"></div>

## Meteor

[cloudant:couchdb ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://atmospherejs.com/cloudant/couchdb){:new_window} は、`couchdb-meteor` パッケージの {{site.data.keyword.cloudant_short_notm}} ライブラリーです。
Apache CouchDB には、Meteor または couchdb パッケージは付属していないため、Meteor をインストールする前に、Meteor の URL を指定して、稼働中の CouchDB または {{site.data.keyword.cloudant_short_notm}} のサーバー・インスタンスに接続する必要があります。
Meteor アプリケーションに以下のパッケージを追加します。

```sh
meteor add cloudant:couchdb
```
{:codeblock}

couchdb-meteor パッケージは、以下の機能を提供します。

-   Livequery の実装と、CouchDB `_changes` フィードを取り込むことによるデータベースからのリアルタイム更新。
-   ローカルに接続されたクライアントからデータを更新する Distributed Data Protocol (DDP) RPC エンドポイント。
-   DDP フォーマットに合わせた更新の直列化および非直列化。

>   **注**: {{site.data.keyword.cloudant_short_notm}} Query で使用される (および {{site.data.keyword.cloudant_short_notm}} によって最初に開発された) JSON 照会構文は、バージョン 2.0 で Apache CouchDB に提供されました。
    Apache CouchDB バージョン 2.0 用の事前ビルドされたバイナリーは、また使用できません。
    事前ビルドされたバイナリーが使用可能になるまでは、このモジュールを {{site.data.keyword.cloudant_short_notm}} DBaaS または Cloudant Local で使用できます。

Apache CouchDB または {{site.data.keyword.cloudant_short_notm}} のサーバー接続情報を構成するには、以下のように、その URL を `COUCHDB_URL` 環境変数として Meteor サーバー・プロセスに渡します。

```sh
$ export COUCHDB_URL=https://username:password@username.cloudant.com
```
{:codeblock}

meteor-couchdb API について詳しくは、[API リファレンス](../api/index.html) を参照してください。 

## Apache Spark

[Apache Spark 用の Apache Bahir 拡張機能 ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](http://bahir.apache.org/#home){:new_window} には、Apache Spark 用の {{site.data.keyword.cloudant_short_notm}} ライブラリーである `spark-sql-cloudant` コネクターが含まれています。

spark-sql-cloudant コネクターは、[{{site.data.keyword.cloud_notm}}Apache Spark-as-a-Service ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://console.ng.bluemix.net/catalog/services/apache-spark/){:new_window} オファリングに既にロードされています。
どのスタンドアロン Spark クラスターでも使用可能です。

詳しくは、[プロジェクト情報 ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://github.com/apache/bahir/tree/master/sql-cloudant){:new_window} および [Apache Bahir spark-sql-cloudant の資料 ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](http://bahir.apache.org/docs/spark/current/spark-sql-cloudant/){:new_window} を参照してください。
