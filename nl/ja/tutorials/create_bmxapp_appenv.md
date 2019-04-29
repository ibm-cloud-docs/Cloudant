---

copyright:
  years: 2017, 2019
lastupdated: "2019-04-02"

keywords: ibm cloud application environment, ibm cloud applications and services, connect, the cloud foundry command toolkits, ibm cloud command toolkits, install the cloud foundry toolkit, install ibm cloud toolkit, the starter application

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

<!-- Acrolinx: 2017-05-10 -->

# {{site.data.keyword.cloudant_short_notm}} データベースにアクセスする単純な {{site.data.keyword.cloud_notm}} アプリケーションの作成: アプリケーション環境
{: #creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment}

チュートリアルのこのセクションでは、
{{site.data.keyword.cloud}} アプリケーションの作成に必要なアプリケーション環境をセットアップする方法について説明します。
{: shortdesc}

## {{site.data.keyword.cloud_notm}} アプリケーション環境の作成
{: #creating-an-ibm-cloud-application-environment}

1.  {{site.data.keyword.cloud_notm}} アカウントにログインします。<br/>
    {{site.data.keyword.cloud_notm}} ダッシュボードは、
    [https://cloud.ibm.com/ ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://cloud.ibm.com/){: new_window} にあります。
    ユーザー名とパスワードで認証すると、
    {{site.data.keyword.cloud_notm}} ダッシュボードが表示されます。 メニューから`「カタログ」`をクリックします。<br/>
    ![{{site.data.keyword.cloud_notm}} ダッシュボード](images/img0001.png)

2.  以下のように「`コンピュート`」カテゴリーをクリックします。<br/>
    ![{{site.data.keyword.cloud_notm}} Cloud Foundry アプリ](images/img0012.png)<br/>
    {{site.data.keyword.cloud_notm}} で使用可能なさまざまなサービスおよびアプリのリストが表示されます。

3.  「`Cloud Foundry`」セクションにスクロールダウンし、以下の「`Python`」項目をクリックします。<br/>
    ![{{site.data.keyword.cloud_notm}} Python アプリ](images/img0013.png)<br/>
    `Cloud Foundry アプリの作成` フォームが表示されます。

4.  `Cloud Foundry アプリの作成` フォームを使用して、 Python Cloud Foundry アプリケーションの環境を指定して作成します。 アプリケーションの名前を入力します。例えば、`Cloudant CF app` など。 ホスト名は自動で生成されますが、カスタマイズすることも可能です。</br>
    ![{{site.data.keyword.cloud_notm}} Python Cloud Foundry アプリ名](images/img0014.png)
    
    ホスト名は、{{site.data.keyword.cloud_notm}} ドメイン内で固有でなければなりません。 この例では、ドメイン名が `mybluemix.net` で、完全なホスト名は `Cloudant-CF-app.mybluemix.net` になります。
    {: tip}

5.  `作成` をクリックして、アプリケーション環境を作成します。</br>
    ![{{site.data.keyword.cloud_notm}} Python Cloud Foundry アプリの作成](images/img0015.png)

6.  しばらく間をおいて、
    新しいアプリケーション環境の`開始`ウィンドウが表示されます。
    環境内にテスト・アプリケーションが自動的に作成されます。
    緑色のアイコンと「`実行中`」状況で示されるように、アプリケーションが自動的に開始されます。
    このアプリケーションは、新しいアプリケーション環境が作動可能で使用できることを示すのに十分な「ハートビート」プログラムです。
    「`Cloud Foundry アプリ`」リンクをクリックして、{{site.data.keyword.cloud_notm}} ダッシュボードに戻ります。<br/>
    ![新しい {{site.data.keyword.cloud_notm}} Python Cloud Foundry アプリが初めて実行されています](images/img0016.png)

7.  新しく作成されたアプリケーション環境が、リソース・リストに含まれています。<br/>
    ![基本的な {{site.data.keyword.cloud_notm}} Python Cloud Foundry アプリがダッシュボードに表示されています](images/img0017.png)

{{site.data.keyword.cloud_notm}} Python アプリケーション環境を使用する準備ができました。

{{site.data.keyword.cloudant_short_notm}} データベース・インスタンスで作業するには、
アプリケーション環境とデータベース・インスタンス間の「接続」を作成します。

## {{site.data.keyword.cloud_notm}} アプリケーションとサービスの接続
{: #connecting-ibm-cloud-applications-and-services}

チュートリアルのこのセクションでは、アプリケーションの構成および管理エリアを使用して、
{{site.data.keyword.cloud_notm}} アプリケーション環境とサービスを接続する方法を説明します。

1.  {{site.data.keyword.cloud_notm}} ダッシュボードでは、**「メニュー」**アイコン > **「リソース・リスト」**に進み、サービス・インスタンスを開きます。<br/>
    ![{{site.data.keyword.cloud_notm}} ダッシュボードでのアプリケーションの選択](images/img0017.png)</br>
    アプリケーションの構成および管理の概要エリアが表示されます。

2.  アプリケーション環境を別のサービスに接続するには、
    `接続`タブをクリックします。<br/>
    ![{{site.data.keyword.cloud_notm}} アプリケーションの接続構成の選択](images/img0019.png)<br/>
    アプリケーションと、アカウント内で使用可能な他のサービスとの接続を構成するエリアが表示されます。

3.  このチュートリアルでは、既存の {{site.data.keyword.cloudant_short_notm}}
    データベース・インスタンスが[前提条件](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-prerequisites#prerequisites)です。
    `接続の作成`をクリックして、そのサービス・インスタンスとアプリケーション間の接続を確立します。<br/>
    ![既存データベース・インスタンスへの接続](images/img0020.png)<br/>
    アカウントの既存サービス・インスタンスのリストが表示されます。

4.  使用する {{site.data.keyword.cloudant_short_notm}} データベース・インスタンスをクリックします。
    このチュートリアルでは、以下のように `Cloudant-service` インスタンスを使用します。<br/>
    ![チュートリアルのサンプルのデータベース・インスタンスを選択](images/img0021.png)

5.  本当にデータベース・インスタンスをアプリケーションに接続するか、確認を求められます。
    `接続`をクリックして、接続することを確定します。<br>
    ![データベース・インスタンスへの接続の確認](images/img0022.png)

6.  続行する前に、サービス ID とアクセス役割をカスタマイズするように求められます。 「`接続`」をクリックして続行します。
    ![アプリケーションの再ステージングの確認](images/img0022b.png)

6.  アプリケーションのサービス接続を変更すると、構成全体に影響します。 変更にはアプリケーションの「再ステージ」が必要で、これには実行中アプリケーションの停止が必要です。 「再ステージ」に進む準備ができているかを確認するウィンドウが表示されます。
    `再ステージ`をクリックして続行します。<br/>
    ![アプリケーションの再ステージの確認](images/img0023.png)

7.  サービス接続ページが再表示されます。
    新しく接続されたデータベース・インスタンスが含まれています。<br/>
    ![新しく接続されたデータベース・インスタンス](images/img0024.png)

アプリケーション環境とデータベース・インスタンスが接続されました。
次のステップでは、{{site.data.keyword.cloud_notm}} アプリケーションの処理に必要なツールがインストールされていることを確認します。

## Cloud Foundry および {{site.data.keyword.cloud_notm}} のコマンド・ツールキット
{: #the-cloud-foundry-and-ibm-cloud-command-toolkits}

チュートリアルのこのセクションでは、
{{site.data.keyword.cloud_notm}} 環境、アプリケーション、サービスを処理するためにインストールされていなければならないツールキットについて説明します。

[Cloud Foundry ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://en.wikipedia.org/wiki/Cloud_Foundry){: new_window}
ツールキットは、Cloud Foundry 互換環境にデプロイされたアプリケーションを処理するためのツール・コレクションです。
デプロイされたアプリケーションの更新や実行中アプリケーションの開始および停止などのタスクに、
これらのツールを使用します。

{{site.data.keyword.cloud_notm}} ツールキットでは、
{{site.data.keyword.cloud_notm}} 環境内でホストされて実行中のアプリケーションの処理に必要な、追加の機能が提供されます。

Cloud Foundry _および_{{site.data.keyword.cloud_notm}} の両方のツールキットを必ずインストールしてください。
{: tip}

ツールキットのダウンロードとインストールは、一回限りのタスクです。
ツールキットがシステムに既にインストールされて動作していれば、
それらが更新されない限り、再度ダウンロードする必要はありません。

ツールキットに関する一般情報については、[こちら ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](/docs/services/Cloudant?topic=cloudant-getting-started-with-cloudant#getting-started){: new_window} を参照してください。

### Cloud Foundry ツールキットのインストール
{: #installing-the-cloud-foundry-toolkit}

一部のオペレーティング・システム・ディストリビューションでは、Cloud Foundry ツールキットの何らかのバージョンが既に使用可能になっています。
サポートされるバージョンが 6.11 以上であれば、
{{site.data.keyword.cloud_notm}} と互換であり、使用することができます。
以下のコマンドを実行して、インストールされているバージョンを確認できます。

あるいは、Cloud Foundry ツールキットをシステムにダウンロードしてインストールするには、以下の手順を使用します。 

1.  「`開始`」をクリックして、Cloud Foundry ツールキットのダウンロードに関する情報を表示します。

2.  「`CLI`」をクリックします。 このリンクをクリックすると、{{site.data.keyword.cloud_notm}} Developer Tools (CLI and Dev Tools) の資料が表示されます。

3.  「`Cloud Foundry CLI プラグイン`」をクリックし、次に「`{{site.data.keyword.cloud_notm}} 管理 CLI`」をクリックします。 

4.  ページの指示に従って、ご使用システム用の最新バージョンのインストーラーをダウンロードして実行します。

5.  有効な Cloud Foundry ツールキットがあるかを確認するには、
    プロンプトで以下のコマンドを実行します。

    ```sh
    cf --version
    ```
    {: pre}
    
    以下の出力のような結果が期待されます。
    
    ```
    cf version 6.20.0+25b1961-2016-06-29
    ```
    {:codeblock}
    
    {{site.data.keyword.cloud_notm}} との互換性のために、Cloud Foundry ツールキットは、バージョン 6.11 以降でなければなりません。
    {: tip}

### {{site.data.keyword.cloud_notm}} ツールキットのインストール
{: #installing-the-ibm-cloud-toolkit}

{{site.data.keyword.cloud_notm}} ツールキットをシステムにダウンロードしてインストールするには、以下の手順を使用します。

1.  「`開始`」をクリックして、{{site.data.keyword.cloud_notm}} 管理 CLI ツールキットのダウンロードに関する情報を表示します。

2.  「`CLI`」をクリックして、「[{{site.data.keyword.cloud_notm}} Developer Tools の概説![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://cloud.ibm.com/docs/cli?topic=cloud-cli-ibmcloud-cli#getting-started){: new_window}」資料を開きます。

3.  ページの指示に従って、ご使用のシステムに適切なインストーラーをダウンロードして実行します。

    インストーラーは、Cloud Foundry ツールキットの適切なバージョンがインストールされているか、確認します。
    状況がすべて適切であれば、{{site.data.keyword.cloud_notm}} ツールキットがシステムにインストールされます。

4.  有効な {{site.data.keyword.cloud_notm}} ツールキットがあるかを確認するには、
    プロンプトで以下のコマンドを実行します。
    
    ```sh
    bluemix --version
    ```
    {: pre}
    
    以下の出力のような結果が期待されます。
    
    ```
    bluemix version 0.4.5+03c29de-2016-12-08T07:01:01+00:00
    ```
    {: codeblock}
    
{{site.data.keyword.cloud_notm}} アプリケーションを処理するためのツールが使用可能になりました。
次のステップでは、{{site.data.keyword.cloud_notm}} アプリケーションの作成に利用できる「スターター」のマテリアルを入手します。

コマンド・ライン・インターフェースをインストールしたら、ダッシュボードの「`開始`」タブに戻り、コマンド・ライン・インターフェースを使用して Cloud Foundry アプリケーションおよびサービス・インスタンスをダウンロード、変更、および再デプロイします。 
{: note}

## `starter` アプリケーション
{: #the-starter-application}

チュートリアルのこのセクションでは、{{site.data.keyword.cloud_notm}}
スターター・アプリケーションと、それをカスタマイズして
{{site.data.keyword.cloudant_short_notm}} データベース・インスタンスにアクセスする方法について説明します。

{{site.data.keyword.cloud_notm}} スターター・アプリケーションは、
動作する {{site.data.keyword.cloud_notm}} アプリケーションの作成に必要な、ソース・ファイルと構成ファイルの最小限の集合です。
基本的なシステムと構成が正しく動作していることを示すだけの
[「Hello World」アプリケーション ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://en.wikipedia.org/wiki/%22Hello,_World!%22_program){: new_window}
と似ている点があります。

{{site.data.keyword.cloud_notm}} スターター・アプリケーションは、サンプル・ファイルのアーカイブで、
{{site.data.keyword.cloud_notm}} アプリケーションを開発する際には、これらを修正または拡張する必要があります。

特に、以下の 3 つのファイルが重要です。

-   [`Procfile`](#the-procfile-file)
-   [`manifest.yml`](#the-manifest.yml-file)
-   [`requirements.txt`](#the-requirements.txt-file)

### `Procfile` ファイル
{: #the-procfile-file}

`Procfile` には、アプリケーションの実行に {{site.data.keyword.cloud_notm}} が必要とする詳細情報が含まれます。

もっと具体的に言うと、
`Procfile` は、アプリケーション・プロセス・タイプとアプリケーション実行コマンドを定義する Cloud Foundry 成果物です。
`Procfile` に関する詳細については、
[こちら ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://docs.cloudfoundry.org/buildpacks/prod-server.html#procfile){: new_window}を参照してください。

{{site.data.keyword.cloud_notm}} Python スターター・アプリケーションの `Procfile` は、以下のサンプルのようなものです。

```
web: python server.py
```
{: codeblock}

このサンプルでは、アプリケーションが Python Web アプリケーションであることと、
それが次のコマンドを実行して開始されることを示しています。

```sh
python server.py
```
{: codeblock}

スターターの Python ソース・ファイル `server.py` は、スターター・アプリケーションのアーカイブに含まれています。
アプリケーションに合わせて、`server.py` ファイルを変更します。
あるいは、全く新しい Python ソース・ファイルを作成し、
アプリケーションの開始時にそのファイルが使用されるように、
`Procfile` を更新します。

### `manifest.yml` ファイル
{: #the-manifest.yml-file}

`manifest.yml` ファイルは、アプリケーションと、その実行に必要な環境についてすべて記述したものです。

{{site.data.keyword.cloud_notm}} Python スターター・アプリケーションのファイルは、以下のサンプルのようなものです。

```
applications:
- path: .
  memory: 128M
  instances: 1
  domain: mybluemix.net
  name: Cloudant Python
  host: Cloudant-Python
  disk_quota: 1024M
  services:
  - Cloudant Service 2017
```
{: codeblock}

ここで、3 つの点に注目してください。

-   `domain`、
    `name`、
    `host` の値は、
    {{site.data.keyword.cloud_notm}} アプリケーションの[作成](#creating-an-ibm-cloud-application-environment)時に入力された値に対応します。
-   `name` の値は、管理されているアプリケーションを識別するために Cloud Foundry ツールキットが使用します。
-   `services` の値は、`Cloudant Service 2017` の
    {{site.data.keyword.cloudant_short_notm}} データベース・インスタンスがアプリケーション環境に接続されることを確定します。

通常、`manifest.yml` ファイルの変更は不要ですが、
アプリケーションの動作にその存在が必要な理由を理解すると役立ちます。

### `requirements.txt` ファイル
{: #the-requirements.txt-file}

`requirements.txt` ファイルは、アプリケーションの動作に必要な追加のコンポーネントを指定します。

スターター・アプリケーションで、`requirements.txt` ファイルは空です。

ただし、このチュートリアルの Python アプリケーションは、
{{site.data.keyword.cloudant_short_notm}} データベース・インスタンスにアクセスします。
そのため、
アプリケーションは、
[Python アプリケーションの {{site.data.keyword.cloudant_short_notm}} クライアント・ライブラリー](/docs/services/Cloudant?topic=cloudant-supported-client-libraries#python-supported)を使用することが可能でなければなりません。

Python クライアント・ライブラリーを有効にするには、
`requirements.txt` ファイルを変更して以下のテキストを組み込みます。
```
cloudant==2.3.1
```
{: codeblock}

チュートリアルの次のステップでは、[アプリケーションを作成します](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment)。
