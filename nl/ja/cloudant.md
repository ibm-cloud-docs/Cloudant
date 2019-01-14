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

<!-- Acrolinx: 2018-06-13 -->

# 概要

{{site.data.keyword.cloudantfull}} のオンライン資料の目的は、素早く処理を行えるよう支援することです。{{site.data.keyword.cloudant_short_notm}} について詳しくは、[{{site.data.keyword.cloudant_short_notm}}の製品ページ![外部リンク・アイコン](images/launch-glyph.svg "外部リンク・アイコン")](http://www.ibm.com/analytics/us/en/technology/cloud-data-services/cloudant/){:new_window}を参照してください。
{:shortdesc}

[{{site.data.keyword.cloudant_short_notm}} ![外部リンク・アイコン](images/launch-glyph.svg "外部リンク・アイコン")](https://www.youtube.com/watch?v=xfO3m1I3SKg&feature=youtu.be){:new_window} は、文書指向の DataBase as a Service (DBaaS) です。
JSON フォーマットの文書としてデータを保管します。
これは、スケーラビリティー、
高可用性、
および耐久性を念頭に構築されています。
これには、MapReduce、{{site.data.keyword.cloudantfull}} Query、
全文索引付け、
および地理情報索引付けなどのさまざまな索引付けオプションが
付属しています。
複製機能により、データベース・クラスター、デスクトップ PC、モバイル・デバイス間で簡単にデータを同期できます。
{:shortdesc}

その他の {{site.data.keyword.cloudant_short_notm}} オファリングについて詳しくは、
メインの [{{site.data.keyword.cloudant_short_notm}} ![外部リンク・アイコン](images/launch-glyph.svg "外部リンク・アイコン")](http://www.ibm.com/analytics/us/en/technology/cloud-data-services/cloudant/){:new_window} サイトを参照してください。
ここで示したオンライン資料は、
{{site.data.keyword.cloudant_short_notm}} の概念、タスク、
および技法について詳しく説明しています。

{{site.data.keyword.cloudant_short_notm}} サービスは、[{{site.data.keyword.cloud}} ダッシュボード ![外部リンク・アイコン](images/launch-glyph.svg "外部リンク・アイコン")](https://console.ng.bluemix.net/catalog/services/cloudant-nosql-db/){:new_window} から開始できます。

タスクについて詳細に説明した[チュートリアル](tutorials/create_service.html#creating-a-service-instance)とともに、{{site.data.keyword.cloudant_short_notm}} を稼働するための「クイック・スタート」が[利用可能です](index.html)。
データベース・インスタンスでの認証やデータの照会などの詳細に関する追加情報については、[API リファレンス](api/index.html)を参照してください。

<div id="contents"></div>

## 資料の内容

*	[入門チュートリアル](getting-started.html#getting-started-with-cloudant): {{site.data.keyword.cloudantfull}} データベースを作成し、Python を使用して単純なデータ・コレクションをそのデータベースに取り込む方法について説明します。
*	[{{site.data.keyword.cloud_notm}} Public](offerings/bluemix.html#ibm-cloud-public): 機能、オプション、料金など、{{site.data.keyword.cloud_notm}} Public オファリングの説明。 
*	[料金](offerings/pricing.html#pricing): {{site.data.keyword.cloudant_short_notm}} 料金モデルで使用可能なオプションおよび柔軟性について説明した記事。 
*	[セキュリティーおよびコンプライアンス](offerings/security.html#security): セキュリティー、コンプライアンス、データ・プライバシーおよびガバナンス、監査ロギング、一般データ保護規則 (GDPR) に関する {{site.data.keyword.cloudant_short_notm}} の立ち位置について説明した記事コレクション。
*	[リリース情報](https://console.bluemix.net/docs/services/Cloudant/release_info/release_notes.html#release-notes): リリース・ノート、メジャー・リリース間での変更内容、非推奨などのリリース関連情報。 
*	[その他のオファリング](offerings/bluemix_dedicated.html#ibm-cloud-dedicated): {{site.data.keyword.cloud_notm}} Public に加え、{{site.data.keyword.cloudant_short_notm}} はさまざまなオファリングとして使用可能であり、そのすべてがここで説明されています。
* [チュートリアル](tutorials/create_service.html#creating-a-service-instance): {{site.data.keyword.cloud_notm}} で {{site.data.keyword.cloudant_short_notm}} を使用して主要なタスクを実行する方法を
示した詳細な記事コレクション。
*	[ガイド](guides/acurl.html#authorized-curl-acurl-): このガイドでは、
ユース・ケースや複雑なアクティビティーと問題に関する詳細を
示します。
	このガイドでは、{{site.data.keyword.cloudant_short_notm}} データベースの仕組みの背後にある重要な概念についても説明しています。
*	[{{site.data.keyword.cloudant_short_notm}} の基本](basics/index.html): {{site.data.keyword.cloudant_short_notm}} も NoSQL データベース一般も使用したことがない場合、基本に関するこの簡単な概要説明をざっと目を通してから、
 詳細にお進みください。
	ここでは、{{site.data.keyword.cloudant_short_notm}} について知っておく必要がある最重要事項が説明されています。
	資料の残りの部分では、この基本が分かっていることが前提となっています。
*	[{{site.data.keyword.cloudant_short_notm}} API リファレンス](api/index.html): API リファレンスは、{{site.data.keyword.cloudant_short_notm}} 機能の包括的で有効なカタログです。
	{{site.data.keyword.cloudant_short_notm}} で実行できることに関する詳細があります。
*	サンプル・アプリケーション: サンプル・アプリケーションには、Offline First ショッピング・リスト、Open Fridge、Core ML および Watson Visual Recognition を使用した iOS ゲーム、および Watson Studio を使用したモバイル・ヘルス・アプリケーションがあります。 
*	[クライアント・ライブラリー](libraries/index.html): クライアント・ライブラリーは、
{{site.data.keyword.cloudant_short_notm}} データベースを処理する準備ができた、
独自のアプリケーションを開発できるようにするツールキットです。


## コントリビューション

{{site.data.keyword.cloudant_short_notm}} は、クラス最高レベルのオープン・ソース・テクノロジーに基づいて構築されており、
IBM は、利用しているテクノロジーにコミットしています。
IBM は、資料についてもオープンです。
ユーザーに活用してもらえなければ意味がありません。
[GitHub ![外部リンク・アイコン](images/launch-glyph.svg "外部リンク・アイコン")](https://github.com/cloudant-labs/slate){:new_window} 上の {{site.data.keyword.cloudant_short_notm}} Labs からコントリビューションを行ったり、
提案を共有したりすることができます。
