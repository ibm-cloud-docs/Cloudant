---

copyright:
  years: 2017
lastupdated: "2017-01-10"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-01-10 -->

# Cloudant データベースにアクセスする単純な Bluemix アプリケーションの作成

このチュートリアルでは、
[Python プログラミング言語 ![「外部リンク」アイコン](../images/launch-glyph.svg "「外部リンク」アイコン")](https://www.python.org/){:new_window}
を使用して、{{site.data.keyword.Bluemix_notm}} サービス・インスタンスでホストされた {{site.data.keyword.cloudantfull}} データベースにアクセスする
{{site.data.keyword.Bluemix}} アプリケーションを作成する方法を示します。
{:shortdesc}

## コンテキスト

{{site.data.keyword.Bluemix_notm}} の大きな利点の 1 つとして、
{{site.data.keyword.Bluemix_notm}} 自体の中でアプリケーションを作成してデプロイすることが可能です。
アプリケーションを実行するためのサーバーを探して保守する必要はありません。

{{site.data.keyword.Bluemix_notm}} 内で {{site.data.keyword.cloudant_short_notm}} データベース・インスタンスを既に使用している場合は、
そこにアプリケーションを置くのも妥当です。

{{site.data.keyword.Bluemix_notm}} アプリケーションは通常、
[Cloud Foundry ![「外部リンク」アイコン](../images/launch-glyph.svg "「外部リンク」アイコン")](https://en.wikipedia.org/wiki/Cloud_Foundry){:new_window} テクノロジーを使用して作成されます。
Cloud Foundry では Platform-as-a-Service (PaaS) 機能を提供しており、これにより、クラウド環境内でデプロイして実行可能なアプリケーションを作成するプロセスが単純化されます。

{{site.data.keyword.Bluemix_notm}} 内の {{site.data.keyword.cloudant_short_notm}}
データベース・インスタンスを使用するスタンドアロン Python アプリケーションの作成方法は、
[別のチュートリアル](create_database.html)に示されています。
このチュートリアルでは、{{site.data.keyword.Bluemix_notm}} 内でホストされる小さな
Python アプリケーションをセットアップして作成します。
このアプリケーションでは、{{site.data.keyword.cloudant_short_notm}} データベース・インスタンスに接続し、
1 つの単純な文書を作成します。

各タスクに対応した Python コードが、このチュートリアルの中で提供されます。
コンセプトをデモンストレーションするための完全な Python プログラムは、
[別のチュートリアル](create_bmxapp_createapp.html#complete-listing)で提供されています。

このチュートリアルでは、_効率的な_ Python コードの作成は意図していません。
仕組みを理解してアプリケーション作成時に参考にするための、単純で分かりやすい実際のコードを示すことを目的としています。

また、考えられるすべてのチェックおよびエラー条件には対応していません。
一部の手法を示すためにサンプルのチェックがいくつか組み込まれていますが、
アプリケーションで発生する警告やエラー条件すべてをチェックして処理する通常のベスト・プラクティスを適用してください。

## タスクの概要

{{site.data.keyword.cloudant_short_notm}} データベース・インスタンスにアクセスできる実際の Python アプリケーションを
{{site.data.keyword.Bluemix_notm}} で作成するには、以下のタスクを実行する必要があります。

-   [{{site.data.keyword.Bluemix_notm}} で Python アプリケーション環境を作成します。](create_bmxapp_appenv.html#creating)
-   [Python アプリケーション環境に、{{site.data.keyword.cloudant_short_notm}} データベース・インスタンスへの「接続」があることを確認します。](create_bmxapp_appenv.html#connecting)
-   [(一回限りのタスク) Cloud Foundry と Bluemix のコマンド・ライン・ツールキットをダウンロードしてインストールします。](create_bmxapp_appenv.html#toolkits)
-   [スターター・アプリケーションをダウンロードします。](create_bmxapp_appenv.html#starter)
-   [スターター・アプリケーションをカスタマイズして、{{site.data.keyword.cloudant_short_notm}} データベース・インスタンスにアクセスする独自のアプリケーションを作成します。](create_bmxapp_createapp.html#theApp)
-   [アプリケーションをアップロードして、動作するかテストします。](create_bmxapp_upload.html#uploading)
-   [基本的なアプリケーション保守タスクを実行します。](create_bmxapp_maintain.html#maintenance)
-   [問題を診断して解決します (トラブルシューティング)。](create_bmxapp_maintain.html#troubleshooting)

## チュートリアルの構造

このチュートリアルは、次の 5 つのセクションから構成されます。

1.  [前提条件](create_bmxapp_prereq.html)
2.  [アプリケーション環境](create_bmxapp_appenv.html)
3.  [アプリケーションの作成](create_bmxapp_createapp.html)
4.  [アプリケーションのアップロードと実行](create_bmxapp_upload.html)
5.  [アプリケーションの保守とトラブルシューティング](create_bmxapp_maintain.html)

## 次のステップ

チュートリアルを開始するには、
まず、[前提条件を確認します](create_bmxapp_prereq.html)。
