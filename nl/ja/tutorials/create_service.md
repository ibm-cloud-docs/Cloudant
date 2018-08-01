---

copyright:
  years: 2017, 2018
lastupdated: "2018-06-07"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

# {{site.data.keyword.Bluemix_notm}} での {{site.data.keyword.cloudant_short_notm}} インスタンスの作成

このチュートリアルでは、{{site.data.keyword.Bluemix}} ダッシュボードを使用して {{site.data.keyword.cloudantfull}}
サービス・インスタンスを作成する方法を示します。
また、アプリケーションでデータベースを操作するための重要情報がある場所も示します。
{:shortdesc}

{{site.data.keyword.cloudant_short_notm}} サービス・インスタンスにアクセスするには、
一連の[サービス資格情報](#the-service-credentials)が必要です。
資格情報は、サービス・インスタンスの作成時にプロセスの一環として生成されます。

これらの資格情報は、{{site.data.keyword.cloudant_short_notm}} アカウントにアクセスすることでいつでも参照することができます。

## サービス・インスタンスの作成

1.  {{site.data.keyword.Bluemix_notm}} アカウントにログインします。<br/>
    {{site.data.keyword.Bluemix_notm}} ダッシュボードは、
    [http://bluemix.net ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](http://bluemix.net){:new_window} にあります。
    ユーザー名とパスワードで認証すると、
    {{site.data.keyword.Bluemix_notm}} ダッシュボードが表示されます。<br/>
    ![{{site.data.keyword.Bluemix_notm}} ダッシュボード](images/img0001.png)

2.  `｢カタログ｣`リンクをクリックします。<br/>
    ![{{site.data.keyword.Bluemix_notm}} カタログ・リンク](images/img0002.png)<br/>
    {{site.data.keyword.Bluemix_notm}} で使用可能なサービスのリストが表示されます。

3.  `「サービス」`の見出しの下で`「データ & 分析」`項目をクリックします。<br/>
    ![{{site.data.keyword.Bluemix_notm}} の「データ & 分析」サービス](images/img0003.png)<br/>
    {{site.data.keyword.Bluemix_notm}} で使用可能な「データ & 分析」サービスのリストが表示されます。

4.  {{site.data.keyword.cloudant_short_notm}} サービスをクリックします。<br>
    ![{{site.data.keyword.Bluemix_notm}} {{site.data.keyword.cloudant_short_notm}} サービスの選択](images/img0004.png)

5.  サービス構成ウィンドウで、サービス名を入力します。
    この例で、サービス名は `Cloudant Service 2017` です。<br/>
    ![{{site.data.keyword.cloudant_short_notm}} のサービス名と資格情報](images/img0005.png)

6.  デフォルトで、「ライト」の料金プランでサービスは作成されます。
    このプランは無料ですが、容量が限定されます。
    [その他の容量が大きい料金プラン](../offerings/bluemix.html)もあります。<br/>
    サービスを作成するには、`「作成」`ボタンをクリックします。<br/>
    ![{{site.data.keyword.cloudant_short_notm}} のサービス名と資格情報の作成](images/img0006.png)

7.  新しい {{site.data.keyword.cloudant_short_notm}} サービスが利用可能であることを確認するサービス・ページが表示されます。
    アプリケーションがサービスに接続するために必要な接続情報にアクセスするには、
    `「サービス資格情報」`タブをクリックします。<br/>
    ![{{site.data.keyword.cloudant_short_notm}} サービス資格情報へのアクセス](images/img0007.png)

8.  「サービス資格情報」ウィンドウが表示されます。
    サービスへのアクセスに必要な資格情報を表示するには、
    `「資格情報の表示」`ドロップダウンをクリックします。<br/>
    ![{{site.data.keyword.cloudant_short_notm}} サービス資格情報の表示](images/img0008.png)

9.  サービス資格情報の詳細が表示されます。<br/>
    ![{{site.data.keyword.cloudant_short_notm}} のサービス資格情報](images/img0009.png)

>   **注**: これらの例のサービス資格情報は、
    デモの {{site.data.keyword.cloudant_short_notm}} サービスが {{site.data.keyword.cloudant_short_notm}} で作成されたときに定義されたものです。
    これらの資格情報は、ダッシュボードでどう表示されるかを示すためにここで再現されています。
    しかし、
    デモの {{site.data.keyword.cloudant_short_notm}} サービスは削除されたため、
    これらの資格情報はもう有効ではありません。
    _必ず_、ご自分のサービス資格情報を提供して使用してください。

## サービス資格情報

>   **注**: サービス資格情報は大切です。
    資格情報にアクセスできるユーザーやアプリケーションは、
    そのサービス・インスタンスで、偽造データの作成や重要情報の削除など、事実上何でも実行できることになります。
    これらの資格情報は、大切に保護してください。

サービス資格情報は、以下の 5 つのフィールドから構成されます。

フィールド      | 目的
-----------|--------
`host`     | アプリケーションがサービス・インスタンスを検索するために使用するホスト名。
`username` | アプリケーションがサービス・インスタンスにアクセスするために必要なユーザー名。
`password` | アプリケーションがサービス・インスタンスにアクセスするために必要なパスワード。
`port`     | ホスト上のサービス・インスタンスにアクセスするための HTTP ポート番号。通常、443 で HTTPS アクセスを強制します。
`url`      | その他の資格情報を単一の URL に集約したストリング。アプリケーションによる使用に適しています。

サービス・インスタンスにアクセスできるアプリケーションを作成するには、これらの資格情報が必要です。

## サービス資格情報の検索

アカウントに関連付けられたサービスの資格情報は、いつでも参照することができます。

1.  まず、{{site.data.keyword.cloudant_short_notm}} にログインします。
    {{site.data.keyword.Bluemix}} ダッシュボードは、
    [http://bluemix.net ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](http://bluemix.net){:new_window} にあります。
    ユーザー名とパスワードで認証すると、
    {{site.data.keyword.Bluemix_notm}} ダッシュボードが表示されます。<br/>
    ![{{site.data.keyword.Bluemix_notm}} ダッシュボード](images/img0001.png)

2.  ダッシュボードで、すべてのサービスをリストしたセクションが表示されるまでスクロールダウンします。<br/>
    ![{{site.data.keyword.Bluemix_notm}} のサービス・リスト](images/img0010.png)

3.  この例では、チュートリアルで前に作成された {{site.data.keyword.cloudant_short_notm}} サービス・インスタンス
    `Cloudant Service 2017` のサービス資格情報を探します。
    該当の行をクリックします。<br/>
    ![{{site.data.keyword.cloudant_short_notm}} サービスの選択](images/img0011.png)

3.  「サービス資格情報」ウィンドウが表示されます。
    サービスへのアクセスに必要な資格情報を表示するには、
    `「資格情報の表示」`ドロップダウンをクリックします。<br/>
    ![{{site.data.keyword.cloudant_short_notm}} サービス資格情報の表示](images/img0008.png)

4.  サービス資格情報の詳細が表示されます。<br/>
    ![{{site.data.keyword.cloudant_short_notm}} のサービス資格情報](images/img0009.png)

>   **注**: これらの例のサービス資格情報は、
    デモの {{site.data.keyword.cloudant_short_notm}} サービスが {{site.data.keyword.cloudant_short_notm}} で作成されたときに定義されたものです。
    これらの資格情報は、ダッシュボードでどう表示されるかを示すためにここで再現されています。
    しかし、
    デモの {{site.data.keyword.cloudant_short_notm}} サービスは削除されたため、
    これらの資格情報はもう有効ではありません。
    _必ず_、ご自分のサービス資格情報を提供して使用してください。
