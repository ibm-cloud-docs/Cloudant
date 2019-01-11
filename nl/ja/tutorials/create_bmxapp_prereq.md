---

copyright:
  years: 2017, 2018
lastupdated: "2018-10-24"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:tip: .tip}

<!-- Acrolinx: 2017-05-10 -->

# {{site.data.keyword.cloud_notm}} データベースにアクセスする単純な {{site.data.keyword.cloudant_short_notm}} アプリケーションの作成: 前提条件

チュートリアルのこのセクションでは、{{site.data.keyword.cloud}} アプリケーションを作成するための前提条件について説明します。
{:shortdesc}

## 前提条件

チュートリアルを始める前に、以下のリソースまたは情報を準備してください。

### Python

ごく単純な開発作業を除き、
[Python プログラミング言語 ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://www.python.org/){:new_window}
の現行インストール済み環境がシステムにあると、大幅に簡単です。

確認するには、プロンプトで以下のコマンドを実行します。

```sh
python --version
```
{:pre}

以下の出力のような結果が期待されます。

```
Python 2.7.12
```
{:codeblock}

<div id="csi"></div>

### {{site.data.keyword.cloud_notm}} 上の {{site.data.keyword.cloudant_short_notm}} サービス・インスタンス

{{site.data.keyword.cloudantfull}} サービス・インスタンス
「`Cloudant Service 2017`」の作成については、[別のチュートリアル](create_service.html)を参照してください。

このチュートリアルでは、サービス・インスタンス
「`Cloudant Service 2017`」を既に作成済みであることを想定しています。

### {{site.data.keyword.cloudant_short_notm}} データベース・アプリケーション

{{site.data.keyword.cloudant_short_notm}} サービス・インスタンスを処理するスタンドアロン Python アプリケーションの作成については、
[別のチュートリアル](create_database.html)を参照してください。
{{site.data.keyword.cloudant_short_notm}} データベースを作成してデータを取り込む方法の理解に役立つ、多くの概念がそこで紹介されています。

このチュートリアルでは、そうした概念を熟知していることを前提としています。

## 次のステップ

チュートリアルの次のステップでは、[アプリケーション環境を作成します](create_bmxapp_appenv.html)。
