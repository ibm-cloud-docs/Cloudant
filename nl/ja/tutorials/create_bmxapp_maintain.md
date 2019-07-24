---

copyright:
  years: 2017, 2019
lastupdated: "2019-06-12"

keywords: maintenance tasks, find application status, start application, stop application, upload application, diagnose problems, resolve problems, application log

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

<!-- Acrolinx: 2017-01-11 -->

# {{site.data.keyword.cloudant_short_notm}} データベースにアクセスする単純な {{site.data.keyword.cloud_notm}} アプリケーションの作成: 保守とトラブルシューティング
{: #creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-maintaining-and-troubleshooting}

このチュートリアルでは、{{site.data.keyword.cloud_notm}} サービス・インスタンスでホストされた
{{site.data.keyword.cloud}} アプリケーションを保守する方法を示します。
{: shortdesc}

## 基本的なアプリケーション保守タスクの実行
{: #performing-basic-application-maintenance-tasks}

チュートリアルのこのセクションでは、
{{site.data.keyword.cloud_notm}} で Python アプリケーションを最新表示、開始、停止する方法を説明します。

### アプリケーションの状況の判別
{: #finding-the-status-of-your-application}

{{site.data.keyword.cloud_notm}} サービス・インスタンス内のアプリケーションの状況は、ダッシュボードに表示されます。

以下の例で、`「Cloudant CF アプリ」`アプリケーションは実行中ではなく、
`「停止」` 状態です。

![「停止」状態のアプリケーションのダッシュボードを示した画面キャプチャー](images/img0037.png)

### アプリケーションの開始
{: #starting-your-application}

チュートリアルのデモ・データベースを先に削除せずにチュートリアルのアプリケーションを開始しようとすると、アプリケーションは正しく動作できません。 アプリケーションは、開始を試行し、データベースが存在するために失敗し、
    停止し、再び開始を試行することを繰り返します。 この問題を解決するには、
    [アプリケーションを停止し](#stopping-your-application)、
    チュートリアルのデモ・データベースを削除してください。 それにより、アプリケーションは正常に開始できるようになります。
{: note}
    
停止されたアプリケーションを開始するには、メニューの`「開始」`オプションをクリックします。<br/>
![「開始」オプションを示す画面キャプチャー](images/img0039.png)

### アプリケーションの停止
{: #stopping-your-application}

実行中のアプリケーションを停止するには、メニューで`「停止」`オプションをクリックします。<br/>
![「停止」オプションを示す画面キャプチャー](images/img0041.png)

### アプリケーションの新たなバージョンのアップロード
{: #uploading-a-fresh-version-of-your-application}

アプリケーションの新たなバージョンをアップロードするには、
[アップロード・プロセス](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-uploading-the-application#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-uploading-the-application)に従ってください。
アプリケーションの新バージョンによって、旧バージョンが上書きされます。

アップロードを開始したときにアプリケーションの旧バージョンが既に実行中の場合、{{site.data.keyword.cloud_notm}} はまず、アプリケーションを自動的に停止します。
{: tip}

## 問題の診断と解決
{: #diagnosing-and-resolving-problems}

チュートリアルのこのセクションでは、初めて
{{site.data.keyword.cloud_notm}}
アプリケーションを開発してデプロイする際に発生する問題の、
識別、診断、解決に役立つトラブルシューティングの基本的なヒントを示します。

{{site.data.keyword.cloud_notm}} アプリケーションまたは Cloud Foundry アプリケーション作成時のベスト・プラクティスに関するアドバイスを [Considerations for Designing and Running an App in the Cloud ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://docs.cloudfoundry.org/devguide/deploy-apps/prepare-to-deploy.html){: new_window} で入手できます。

特に、
[ローカル・ファイル・システムに書き込まないようにする ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://docs.cloudfoundry.org/devguide/deploy-apps/prepare-to-deploy.html#filesystem){: new_window}
のは賢明なアドバイスです。

このチュートリアルでは、単純にするために、ローカル・ファイル・システムにコンテンツを書き込んでいます。 ただし、マテリアルの量は小規模です。 永続化は予期されず、「ミッション・クリティカル」ではありません。
{: tip}

### アプリケーション・ログの使用
{: #using-the-application-log}

{{site.data.keyword.cloud_notm}} アプリケーションでの問題を診断して解決するために最も役立つリソースは、ログ・ファイルです。

{{site.data.keyword.cloud_notm}} アプリケーションのログ・ファイルは、以下のように`「ログ」`タブをクリックしてロギング情報ページを開くと見つかります。<br/>
![「ログ」情報ページにアクセスするリンクの画面キャプチャー](images/img0042.png)

多くのログ・ファイルと同様に、
{{site.data.keyword.cloud_notm}} アプリケーションのログには、発生したイベントの内容と時間に関する詳細が含まれています。

また、ログでは、記録されたイベントに関与したコンポーネントも特定されています。
以下の表に、主要なコンポーネントを示します。

コンポーネント・ラベル | コンポーネント
----------------|----------
`API`           | Cloud Foundry システム。
`APP`           | アプリケーション。
`CELL`          | {{site.data.keyword.cloud_notm}} 内のアプリケーションを保持するコンテナー。
`RTR`           | ネットワーキング・コンポーネントは、アプリケーションに、またはアプリケーションからメッセージを伝送します。

例えば、以下の画面キャプチャーには、多くの一般的なイベントが含まれています。<br/>
![事象を示すログ情報の画面キャプチャー](images/img0043.png)

以下の時刻のイベントに注目してください。

-   1:56:56 PM に、アプリケーションが正常に開始しました。
-   1:58:43 PM に、ネットワークが `GET /` の単純な HTTP 要求を受け取りました。
-   すぐ後に、アプリケーションがその HTTP 要求を受け取り、応答しました。
-   2:13:46 PM に、アプリケーションを停止する要求を受け取りました。
-   2:13:48 PM に、アプリケーションが停止の処理を完了しました。

このチュートリアルで説明されているアプリケーションは、意図的に最小限のものです。
具体例として、
ターゲット・データベースが存在するかどうかの判定や、存在した場合の再作成の回避は試行しません。
その結果、事前にデータベースを削除せずにチュートリアルのアプリケーションを複数回実行しようとすると、
アプリケーションは失敗と再始動を繰り返します。

以下の画面キャプチャーは、この結果を示しています。<br/>
![ログ内のエラー情報の画面キャプチャー](images/img0044.png)

2:31:23 PM に、アプリケーションが以下のように問題を検出しました。<br/>
`"Database {0} already exists".format(dbname)`

その他のメッセージは、問題が発生した Python アプリケーションから予期されるものです。

実際に、ログで、問題が発生したコンポーネントが示され、可能な限りの詳細が提供されています。
この後、通常のアプリケーション・トラブルシューティング手順を適用して、問題を解決してください。

## チュートリアルの終わり
{: #end-of-tutorial}

これでチュートリアルは完了です。
