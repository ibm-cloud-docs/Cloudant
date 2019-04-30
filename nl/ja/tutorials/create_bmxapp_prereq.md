---

copyright:
  years: 2017, 2019
lastupdated: "2019-03-19"

keywords: python, create service instance, create stand-alone python application

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

# {{site.data.keyword.cloud_notm}} データベースにアクセスする単純な {{site.data.keyword.cloudant_short_notm}} アプリケーションの作成: 前提条件
{: #creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-prerequisites}

チュートリアルのこのセクションでは、{{site.data.keyword.cloud}} アプリケーションを作成するための前提条件について説明します。
{: shortdesc}

## 前提条件
{: #prerequisites}

チュートリアルを始める前に、以下のリソースまたは情報を準備してください。

### Python
{: #python-create-bmxapp-prereq}

ごく単純な開発作業を除き、
[Python プログラミング言語 ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://www.python.org/){: new_window}
の現行インストール済み環境がシステムにあると、大幅に簡単です。

確認するには、プロンプトで以下のコマンドを実行します。

```sh
python --version
```
{: pre}

以下の出力のような結果が期待されます。

```
Python 2.7.12
```
{: codeblock}

### {{site.data.keyword.cloud_notm}} 上の {{site.data.keyword.cloudant_short_notm}} サービス・インスタンス
{: #an-ibm-cloudant-service-instance-on-ibm-cloud}

{{site.data.keyword.cloudantfull}} サービス・インスタンス
「`Cloudant-o7`」の作成については、[別のチュートリアル](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud#creating-an-ibm-cloudant-instance-on-ibm-cloud)を参照してください。

このチュートリアルでは、サービス・インスタンス
「`Cloudant-o7`」を既に作成済みであることを想定しています。

### {{site.data.keyword.cloudant_short_notm}} データベース・アプリケーション
{: #an-ibm-cloudant-database-application}

{{site.data.keyword.cloudant_short_notm}} サービス・インスタンスを処理するスタンドアロン Python アプリケーションの作成については、
[別のチュートリアル](/docs/services/Cloudant?topic=cloudant-creating-and-populating-a-simple-ibm-cloudant-database-on-ibm-cloud#creating-and-populating-a-simple-ibm-cloudant-database-on-ibm-cloud)を参照してください。
{{site.data.keyword.cloudant_short_notm}} データベースを作成してデータを取り込む方法の理解に役立つ、多くの概念がそこで紹介されています。

このチュートリアルでは、そうした概念を熟知していることを前提としています。

チュートリアルの次のステップでは、[アプリケーション環境を作成します](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment)。
