---

copyright:
  years: 2017
lastupdated: "2017-01-11"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-01-11 -->

# Cloudant データベースにアクセスする単純な Bluemix アプリケーションの作成: アプリケーションのアップロード

チュートリアルのこのセクションでは、{{site.data.keyword.Bluemix}} アプリケーションのアップロード方法について説明します。
{:shortdesc}

<div id="uploading"></div>

## Bluemix への接続

最初のタスクは、{{site.data.keyword.Bluemix_notm}} への接続です。

接続には、[{{site.data.keyword.Bluemix_notm}} ツールキット](create_bmxapp_appenv.html#toolkits)を利用できます。

Cloud Foundry は、アプリケーションのアップロード時など、API 呼び出しに使用する URL を認識している必要があります。
{{site.data.keyword.Bluemix_notm}} ツールキットは、「`cf api`」コマンドを使用して API エンドポイントを管理します。
「`cf api`」コマンドの詳細については、
[こちら ![「外部リンク」アイコン](../images/launch-glyph.svg "「外部リンク」アイコン")](https://console.ng.bluemix.net/docs/cli/reference/cfcommands/index.html#cf_api){:new_window} を参照してください。

次のコマンドで、使用する URL を Cloud Foundry に指示します。

```sh
bluemix api https://api.ng.bluemix.net
```
{:pre}

以下の出力のような結果が期待されます。

```
Invoking 'cf api https://api.ng.bluemix.net'...

Setting api endpoint to https://api.ng.bluemix.net...
OK

API endpoint:   https://api.ng.bluemix.net
API version:    2.54.0
Not logged in. Use 'bluemix login' to log in.
```
{:codeblock}

これで、Cloud Foundry は、アプリケーションを管理するためにどこに API 呼び出しを送信するかを認識しました。

次のステップでは、{{site.data.keyword.Bluemix_notm}} アプリケーション環境にログインします。
以下のアカウント詳細を指定する必要があります。

-   ユーザー名。「`-u`」パラメーターで指定します。
-   組織名。「`-o`」パラメーターで指定します。
-   スペース。「`-s`」パラメーターで指定します。

>   **注**: アカウント詳細は、Web ブラウザーでのログイン時に、次の例のように
     {{site.data.keyword.Bluemix_notm}} ダッシュボードで入手できます。<br/>
    ![{{site.data.keyword.Bluemix_notm}} アカウント詳細の表示](images/img0035.png)

次の例のようなコマンドを使用して、
{{site.data.keyword.Bluemix_notm}} アプリケーション環境にログインします。
アカウント・パスワードの入力を求められることに注意してください。

```sh
bluemix login -u Adrian.Warman@uk.ibm.com -o Adrian.Warman@uk.ibm.com -s dev
```
{:pre}

以下の出力のような結果が期待されます。

```
Invoking 'cf login -u Adrian.Warman@uk.ibm.com -o Adrian.Warman@uk.ibm.com -s dev'...

  API endpoint: https://api.ng.bluemix.net
  
  Password>
    Authenticating...
    OK

    Targeted org Adrian.Warman@uk.ibm.com

Targeted space dev
                
API endpoint:   https://api.ng.bluemix.net (API version: 2.54.0)   
User:           adrian.warman@uk.ibm.com
Org:            Adrian.Warman@uk.ibm.com
Space:          dev
```
{:codeblock}

## アプリケーションのアップロード

これで、Cloudant Foundry ツールキットが、{{site.data.keyword.Bluemix_notm}} 環境への接続方法を認識しました。

次のステップでは、アプリケーションのアップロードそのものを行います。
{{site.data.keyword.Bluemix_notm}} アプリケーションの詳細は、
[マニフェスト・ファイル](create_bmxapp_appenv.html#manifest)で示されます。

チュートリアルのアプリケーションのマニフェスト・ファイルは、
[該当の説明](create_bmxapp_createapp.html#essential-files)に従って更新されています。

次の例のようなコマンドを使用して、
{{site.data.keyword.Bluemix_notm}} アプリケーションをアップロードするためにログインします。


```sh
cf push "Cloudant Python"
```
{:pre}

一連の結果メッセージが表示されます。

```
Using manifest file /..../BMXDemo/manifest.yml

Updating app Cloudant Python in org Adrian.Warman@uk.ibm.com / space dev as Adrian.Warman@uk.ibm.com...
OK
```
{:codeblock}

Cloud Foundry ツールキットがマニフェスト・ファイルを検出し、
[前に](#uploading)指定した接続と ID の詳細を使用してアプリケーション・アップロードの準備をしています。

```
Using route Cloudant-Python.mybluemix.net
Uploading Cloudant Python...
Uploading app files from: /..../BMXDemo
Uploading 1.5K, 3 files
Done uploading
OK
Binding service Cloudant Service 2017 to app Cloudant Python in org Adrian.Warman@uk.ibm.com / space dev as Adrian.Warman@uk.ibm.com...
OK
```
{:codeblock}

アプリケーションが正常にアップロードされ、
{{site.data.keyword.cloudant_short_notm}} データベース・インスタンスと接続されました。

```
Starting app Cloudant Python in org Adrian.Warman@uk.ibm.com / space dev as Adrian.Warman@uk.ibm.com...
-----> Downloaded app package (4.0K)
-----> Downloaded app buildpack cache (29M)
-------> Buildpack version 1.5.5
     $ pip install -r requirements.txt
DEPRECATION: --allow-all-external has been deprecated and will be removed in the future. Due to changes in the repository protocol, it no longer has any effect.
       Collecting cloudant==2.3.1 (from -r requirements.txt (line 1))
         Downloading cloudant-2.3.1-py2-none-any.whl (63kB)
       Collecting requests<3.0.0,>=2.7.0 (from cloudant==2.3.1->-r requirements.txt (line 1))
         Downloading requests-2.12.4-py2.py3-none-any.whl (576kB)
       Installing collected packages: requests, cloudant
       Successfully installed cloudant-2.3.1 requests-2.12.4
You are using pip version 8.1.1, however version 9.0.1 is available.
You should consider upgrading via the 'pip install --upgrade pip' command.
You are using pip version 8.1.1, however version 9.0.1 is available.
You should consider upgrading via the 'pip install --upgrade pip' command.
-----> Uploading droplet (30M)

0 of 1 instances running, 1 starting
1 of 1 instances running

App started


OK

App Cloudant Python was started using this command `python server.py`
```
{:codeblock}

アプリケーションが自動的に開始します。
開始の一環として、
[requirements.txt ファイル](create_bmxapp_appenv.html#requirements)の内容を評価することで、
すべての要件が満たされているか確認が行われます。
アプリケーションには、アプリケーション作成時に[指定](create_bmxapp_createapp.html#essential-files)された
{{site.data.keyword.cloudant_short_notm}} ライブラリーへのアクセスが必要です。

アプリケーションをアップロードして開始すると、
{{site.data.keyword.Bluemix_notm}} に関してアプリケーションが正しく実行されていることを確認するために、単純なシステム・チェックがいくつか実行されます。

```
Showing health and status for app Cloudant Python in org Adrian.Warman@uk.ibm.com / space dev as Adrian.Warman@uk.ibm.com...
OK

requested state: started
instances: 1/1
usage: 128M x 1 instances
urls: Cloudant-Python.mybluemix.net
last uploaded: Thu Dec 22 15:58:18 UTC 2016
stack: cflinuxfs2
buildpack: python 1.5.5

     state     since                    cpu    memory          disk           details
#0   running   2016-12-22 03:59:21 PM   0.0%   49.9M of 128M   110.6M of 1G
```
{:codeblock}

## サンプル・アプリケーションのテスト

{{site.data.keyword.Bluemix_notm}} アプリケーション環境が最初に作成されたときに、
ダッシュボードでアプリケーションの`「経路」`列にリンクが組み込まれます。<br/>
![アプリケーションのダッシュボードのスクリーン・ショット](images/img0017.png)

このリンクをクリックすると、ブラウザー・ウィンドウが開き、
該当ポートで listen しているアプリケーションからデータを要求します。
アプリケーションは、アプリケーション開始中に生成されたログ・ファイルの内容を戻して応答します。<br/>
![チュートリアル・アプリケーションの実行開始時に生成されたログ・ファイル](images/img0030.png)

このログ・ファイルの内容に注目してください。
開始時刻と終了時刻が明確に表示されています。
その間に、
{{site.data.keyword.cloudant_short_notm}} の接続情報が取得された際の各詳細がログに記録されています。
接続の実際の値は重要ではありません。
チュートリアル・アプリケーションがそうした値を検出、取得、使用でき、
{{site.data.keyword.cloudant_short_notm}} データベースに新しい文書を作成したことが、ログに示されています。

### データベース詳細の確認

まず、{{site.data.keyword.cloudant_short_notm}} ダッシュボードを開きます。
{{site.data.keyword.cloudant_short_notm}} サービス・ページの`「管理」`タブで`「起動 (Launch)」`アイコンをクリックします。
<br/>
![{{site.data.keyword.cloudant_short_notm}} サービス・ページの「起動 (Launch)」アイコン](images/img0036.png)

> **注**: {{site.data.keyword.cloudant_short_notm}} サービス・ページを探すには、
  [「{{site.data.keyword.cloudant_short_notm}} インスタンスの作成」のチュートリアル](create_service.html#locating-your-service-credentials)で詳細を参照してください。

ダッシュボードが開き、
アプリケーションで「`databasedemo`」データベースが作成されたことが分かります。<br/>
![新しいデータベースを表示した {{site.data.keyword.cloudant_short_notm}} ダッシュボード](images/img0031.png)

データベースには、アプリケーションで作成された単一の文書が含まれます。
文書の存在を確認するために、
ダッシュボード内でデータベース名をクリックします。
データベースのオプションのリストが表示されます。
`「すべての文書 (All documents)」`タブを選択すると、単一文書の詳細が表示されます。<br/>
![新しいデータベース内の単一文書](images/img0032.png)

文書の内容を確認するために、
鉛筆のイメージで示された`「編集」`アイコンをクリックします。<br/>
![文書の詳細](images/img0033.png)

文書の内容が表示され、
チュートリアル・アプリケーションで作成された各フィールドがあります。<br/>
![文書内のフィールド](images/img0034.png)<br/>
特に、
`rightNow` フィールドに、文書の作成日時が含まれています。
この値は、[アプリケーション・ログ・ファイル](#testing-the-sample-application)内に記録された時刻に対応します。

## 次のステップ

チュートリアルの次のステップでは、アプリケーションの開始、停止、デバッグなど、[アプリケーションの操作と保守を行います](create_bmxapp_maintain.html)。
