---

copyright:
  years: 2015, 2018
lastupdated: "2018-10-24"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:tip: .tip}

<!-- Acrolinx: 2017-05-10 -->

# サポート対象のクライアント・ライブラリー

## モバイル

{{site.data.keyword.cloudantfull}} Sync ライブラリーは、モバイル・デバイス上のローカル JSON データの保管、索引付け、および照会に使用されます。
複数のデバイス間でデータを同期するためにも使用されます。
同期はアプリケーションによって制御されます。
このライブラリーは、ローカル・デバイスとリモート・データベースの両方で、競合を検出して解決するためのヘルパー・メソッドも提供します。

次の 2 つのバージョンが使用可能です。

-   [{{site.data.keyword.cloudant_short_notm}} Sync - Android / JavaSE ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://github.com/cloudant/sync-android){:new_window}。
-   [{{site.data.keyword.cloudant_short_notm}} Sync - iOS (CDTDatastore) ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://github.com/cloudant/CDTDatastore){:new_window}。

{{site.data.keyword.cloudant_short_notm}} Sync の[概要![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://cloudant.com/product/cloudant-features/sync/){:new_window} が使用可能です。
{{site.data.keyword.cloudant_short_notm}} Sync の [リソース ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://cloudant.com/cloudant-sync-resources/){:new_window} の詳細も使用可能です。

## Java

[java-cloudant ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://github.com/cloudant/java-cloudant){:new_window} は、Java 用の正式な {{site.data.keyword.cloudantfull}} ライブラリーです。

Maven または Gradle のビルドに依存関係として追加してライブラリーをインストールする方法についての情報は、ライブラリーの使用方法の詳細および例と共に、[ここ ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://github.com/cloudant/java-cloudant#installation-and-usage){:new_window} から入手できます。

### Java のライブラリーおよびフレームワーク

#### Java のサポートされるライブラリー

-   [java-cloudant ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://github.com/cloudant/java-cloudant){:new_window}。

#### Java のサポートされないライブラリー

-   [ektorp ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://helun.github.io/Ektorp/reference_documentation.html){:new_window}。
-   [jcouchdb ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](http://code.google.com/p/jcouchdb/){:new_window}。
-   [jrelax ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://github.com/isterin/jrelax){:new_window}。
-   [LightCouch ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](http://www.lightcouch.org/){:new_window}。
-   {{site.data.keyword.cloud}} の [Java Cloudant Web Starter ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://ace.ng.bluemix.net/#/store/cloudOEPaneId=store&appTemplateGuid=CloudantJavaBPTemplate&fromCatalog=true){:new_window} ボイラープレート。

### Java の例およびチュートリアル

-   [Create, read,update, and delete ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://github.com/cloudant/haengematte/tree/master/java){:new_window} - HTTP および JSON のライブラリーを使用。
-   [Create, read, update, and delete ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://github.com/cloudant/haengematte/tree/master/java/CrudWithEktorp){:new_window} - ektorp ライブラリーを使用。
-   [Building apps by using Java with {{site.data.keyword.cloudant_short_notm}} on {{site.data.keyword.cloud}} ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://cloudant.com/blog/building-apps-using-java-with-cloudant-on-ibm-bluemix/){:new_window}。
-   [Build a game app with Liberty, {{site.data.keyword.cloudant_short_notm}}, and Single Sign On ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](http://www.ibm.com/developerworks/cloud/library/cl-multiservicegame-app/index.html?ca=drs-){:new_window} - {{site.data.keyword.cloud_notm}} の例。
-   [Building a Java EE app on {{site.data.keyword.cloud_notm}} by using Watson and {{site.data.keyword.cloudant_short_notm}} ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://developer.ibm.com/bluemix/2014/10/17/building-java-ee-app-ibm-bluemix-using-watson-cloudant/){:new_window} - {{site.data.keyword.cloud_notm}} の例および [YouTube ビデオ ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://www.youtube.com/watch?feature=youtu.be&v=9AFMY6m0LIU&app=desktop){:new_window}。


## Node.js

[nodejs-cloudant ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://github.com/cloudant/nodejs-cloudant){:new_window} は、Node.js 用の公式の {{site.data.keyword.cloudant_short_notm}} ライブラリーです。
npm を使用してインストールできます。

```sh
npm install cloudant
```
{:codeblock}

### node.js のライブラリーおよびフレームワーク

#### node.js のサポートされるライブラリー

-   [nodejs-cloudant ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://github.com/cloudant/nodejs-cloudant){:new_window} ([npm ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://www.npmjs.com/package/@cloudant/cloudant){:new_window})。

#### node.js のサポートされないライブラリーおよびフレームワーク

-   [sag-js ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://github.com/sbisbee/sag-js){:new_window}。これは、ブラウザーでも機能します。
    詳しくは、[saggingcouch ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://github.com/sbisbee/saggingcouch.com){:new_window} を参照してください。
-   [nano ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://github.com/dscape/nano){:new_window} は、最小主義的実装です。
-   [restler ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://github.com/danwrong/restler){:new_window}は、最良のパフォーマンスを提供しますが、実際にはベアボーンです。
-   [cradle ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://github.com/flatiron/cradle){:new_window}は、ハイレベルのクライアントです。パフォーマンスの低下を犠牲にしても使いやすさが絶対に必要な場合にも利用できます。
-   [cane_passport ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://github.com/ddemichele/cane_passport){:new_window} - {{site.data.keyword.cloudant_short_notm}} Angular Node Express および Bootstrap。
-   [express-cloudant ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://github.com/cloudant-labs/express-cloudant){:new_window} - PouchDB および Grunt も使用する Node.js Express フレームワークのテンプレート。
-   [Node.js {{site.data.keyword.cloudant_short_notm}}DB Web Starter ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://ace.ng.bluemix.net/#/store/cloudOEPaneId=store&appTemplateGuid=nodejscloudantbp&fromCatalog=true){:new_window} - {{site.data.keyword.cloud_notm}} のボイラープレート。
-   [Mobile Cloud ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://ace.ng.bluemix.net/#/store/cloudOEPaneId=store&appTemplateGuid=mobileBackendStarter&fromCatalog=true){:new_window} - {{site.data.keyword.cloud_notm}} (Node.js、Security、Push、および Mobile Data/{{site.data.keyword.cloudant_short_notm}}) のボイラープレート。

### node.js の例およびチュートリアル

-   [Create, read, update, and delete ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://github.com/cloudant/haengematte/tree/master/nodejs){:new_window}。
-   [Cloudant-Uploader ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://github.com/garbados/Cloudant-Uploader){:new_window} - `.csv` ファイルを {{site.data.keyword.cloudant_short_notm}} にアップロードするためのユーティリティー。
-   [couchimport ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://github.com/glynnbird/couchimport){:new_window} - `.csv` ファイルまたは `.tsv` ファイルを CouchDB または {{site.data.keyword.cloudant_short_notm}} にインポートするためのユーティリティー。
-   [Getting started with {{site.data.keyword.cloud_notm}} and Node.js ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](http://thoughtsoncloud.com/2014/07/getting-started-ibm-bluemix-node-js/){:new_window}。
-   [A Cloud medley with {{site.data.keyword.cloud_notm}}, {{site.data.keyword.cloudant_short_notm}}, and Node.js ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://gigadom.wordpress.com/2014/08/15/a-cloud-medley-with-ibm-bluemix-cloudant-db-and-node-js/){:new_window}。
-   [Build a simple word game app by using {{site.data.keyword.cloudant_short_notm}} on {{site.data.keyword.cloud_notm}} ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](http://www.ibm.com/developerworks/cloud/library/cl-guesstheword-app/index.html?ca=drs-){:new_window} - Node.js を使用。
-   [Building a Real-time SMS Voting App ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://www.twilio.com/blog/2012/09/building-a-real-time-sms-voting-app-part-1-node-js-couchdb.html){:new_window} - Node.js、Twilio、および {{site.data.keyword.cloudant_short_notm}} を使用する、6 部で構成されるシリーズ。
-   [Building a multitier Windows Azure Web application ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://www.ampower.me/article/CouchDB/Tutorial-Building-a-Multi-Tier-Windows-Azure-Web-application-use-Cloudants-Couchdb-as-a-Service-node-94-409665?eqs=Z2NWNlltTmlUWStWcHdEWENWc3UxdmowREpiMjlGUVpKajJOZGJpSlVkemlPS2oxa0YxZE5BPT0=){:new_window} - {{site.data.keyword.cloudant_short_notm}}、Node.js、CORS、および Grunt を使用。
-   [Do it yourself: Build a remote surveillance application by using {{site.data.keyword.cloud_notm}}, {{site.data.keyword.cloudant_short_notm}}, and Raspberry Pi. ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](http://www.ibm.com/developerworks/library/ba-remoteservpi-app/index.html){:new_window}。

## Python

Python を使用して {{site.data.keyword.cloudant_short_notm}} の作業を行うためのサポート対象ライブラリーは[ここ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://github.com/cloudant/python-cloudant){:new_window} から入手できます。

>   **注:** {{site.data.keyword.cloudant_short_notm}} にアクセスする Python アプリケーションは、コンポーネント依存関係を持っています。 これらの依存関係は、`requirements.txt` ファイルに指定する必要があります。 詳しくは、[ここ ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://pip.readthedocs.io/en/1.1/requirements.html){:new_window} を参照してください。

現行ライブラリー・リリースは、[ここ ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://pypi.python.org/pypi/cloudant/){:new_window} からダウンロードします。
Python 言語に関する詳細情報は、[python.org![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://www.python.org/about/){:new_window} を参照してください。 

## Swift

{{site.data.keyword.cloudant_short_notm}} での作業を行うためのサポート対象のライブラリーが使用可能です。
このライブラリーは SwiftCloudant と呼ばれ、`cocoapods` を使用してインストールされます。

podfile の入力は以下のとおりです。

```sh
pod 'SwiftCloudant'
```
{:codeblock}

SwiftCloudant の詳細情報 (ライブラリーのインストール方法の詳細、およびこのライブラリーを使用して {{site.data.keyword.cloudant_short_notm}} でリモート JSON データの保管、索引付け、および照会を行う方法など) は、[ここ ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://github.com/cloudant/swift-cloudant){:new_window} から入手できます。

このライブラリーは、早期リリース・バージョンです。
そのため、現在のところ {{site.data.keyword.cloudant_short_notm}} API の全範囲の機能は実装されていません。 

>   **注**: SwiftCloudant は iOS ではサポートされておらず、また、Objective-C から呼び出すことはできません。
