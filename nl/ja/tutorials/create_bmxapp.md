---

copyright:
  years: 2017, 2019
lastupdated: "2019-06-12"

keywords: create applications, deploy applications, create simple application

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

# {{site.data.keyword.cloud_notm}} データベースにアクセスする単純な {{site.data.keyword.cloudant_short_notm}} アプリケーションの作成
{: #creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database}

このチュートリアルでは、
[Python プログラミング言語 ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://www.python.org/){: new_window}
を使用して、{{site.data.keyword.cloud_notm}} サービス・インスタンスでホストされた {{site.data.keyword.cloudantfull}} データベースにアクセスする
{{site.data.keyword.cloud}} アプリケーションを作成する方法を示します。
{: shortdesc}

## {{site.data.keyword.cloud_notm}} の利点
{: #advantages-of-ibm-cloud}

{{site.data.keyword.cloud}} の大きな利点の 1 つとして、
{{site.data.keyword.cloud_notm}} 自体の中でアプリケーションを作成してデプロイすることが可能です。
アプリケーションを実行するためのサーバーを探して保守する必要はありません。

{{site.data.keyword.cloudant_short_notm}} 内で {{site.data.keyword.cloud_notm}} データベース・インスタンスを既に使用している場合は、
そこにアプリケーションを置くのも妥当です。

{{site.data.keyword.cloud_notm}} アプリケーションは、通常
[Cloud Foundry ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://en.wikipedia.org/wiki/Cloud_Foundry){: new_window} テクノロジーを使用して作成されます。
Cloud Foundry では Platform-as-a-Service (PaaS) 機能を提供しており、これにより、クラウド環境内でデプロイして実行可能なアプリケーションを作成するプロセスが単純化されます。

{{site.data.keyword.cloudant_short_notm}} 内の {{site.data.keyword.cloud_notm}}
データベース・インスタンスを使用するスタンドアロン Python アプリケーションの作成方法は、
[別のチュートリアル](/docs/services/Cloudant?topic=cloudant-creating-and-populating-a-simple-ibm-cloudant-database-on-ibm-cloud#creating-and-populating-a-simple-ibm-cloudant-database-on-ibm-cloud)に示されています。
このチュートリアルでは、{{site.data.keyword.cloud_notm}} 内でホストされる小さな
Python アプリケーションをセットアップして作成します。
このアプリケーションでは、{{site.data.keyword.cloudant_short_notm}} データベース・インスタンスに接続し、
1 つの単純な文書を作成します。

各タスクに対応した Python コードが、このチュートリアルの中で提供されます。
コンセプトをデモンストレーションするのに十分な、完全な Python プログラムは、[{{site.data.keyword.cloudant_short_notm}} データベースにアクセスする単純な {{site.data.keyword.cloud_notm}} アプリケーションの作成](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-code#complete-python-program)チュートリアルで提供されています。

このチュートリアルでは、_効率的な_ Python コードの作成は意図していません。
仕組みを理解してアプリケーション作成時に参考にするための、単純で分かりやすい実際のコードを示すことを目的としています。

また、考えられるすべてのチェックおよびエラー条件には対応していません。
一部の手法を示すためにサンプルのチェックがいくつか組み込まれていますが、
アプリケーションで発生する警告やエラー条件すべてをチェックして処理する通常のベスト・プラクティスを適用してください。

## タスクの概要
{: #task-overview}

{{site.data.keyword.cloud_notm}} データベース・インスタンスにアクセスできる実際の Python アプリケーションを
{{site.data.keyword.cloudant_short_notm}} で作成するには、以下のタスクを実行する必要があります。

-   [{{site.data.keyword.cloud_notm}} で Python アプリケーション環境を作成します。](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#creating-an-ibm-cloud-application-environment)
-   [Python アプリケーション環境に、{{site.data.keyword.cloudant_short_notm}} データベース・インスタンスへの「接続」があることを確認します。](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#connecting-ibm-cloud-applications-and-services)
-   [(一回限りのタスク) Cloud Foundry と {{site.data.keyword.cloud_notm}} のコマンド・ライン・ツールキットをダウンロードしてインストールします。](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#the-cloud-foundry-and-ibm-cloud-command-toolkits)
-   [スターター・アプリケーションをダウンロードします。](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#the-starter-application)
-   [スターター・アプリケーションをカスタマイズして、{{site.data.keyword.cloudant_short_notm}} データベース・インスタンスにアクセスする独自のアプリケーションを作成します。](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-code#the-application-code)
-   [アプリケーションをアップロードして、動作するかテストします。](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-uploading-the-application#uploading-the-application)
-   [基本的なアプリケーション保守タスクを実行します。](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-maintaining-and-troubleshooting#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-maintaining-and-troubleshooting)
-   [問題を診断して解決します (トラブルシューティング)。](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-maintaining-and-troubleshooting#diagnosing-and-resolving-problems)

## チュートリアルの構造
{: #tutorial-structure}

このチュートリアルは、次の 5 つのセクションから構成されます。

1.  [前提条件](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-prerequisites#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-prerequisites)
2.  [アプリケーション環境](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment)
3.  [アプリケーションの作成](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-code#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-code)
4.  [アプリケーションのアップロードと実行](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-uploading-the-application#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-uploading-the-application)
5.  [アプリケーションの保守とトラブルシューティング](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-maintaining-and-troubleshooting#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-maintaining-and-troubleshooting)

チュートリアルを開始するには、
まず、[前提条件を確認します](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-prerequisites#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-prerequisites)。
