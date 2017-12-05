---

copyright:
  years: 2015, 2017
lastupdated: "2017-08-25"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-03-16 -->

# Cloudant のオファリング

## Database as a Service

Cloudant は、ホスティングされる完全管理の Database as a Service (DBaaS) です。
これは、グローバルにスケーリングを実行し、ノンストップで稼働し、[JSON](../basics/index.html#json)、[フルテキスト](../api/cloudant_query.html#creating-an-index)、および[地理情報](../api/cloudant-geo.html)などの幅広い種類のデータ・タイプを処理するように、基礎から構築されています。Cloudant は、読み取りおよび書き込みの並行処理のために最適化された運用データ・ストアで、
高可用性とデータの耐久性を実現します。

[JSON](../basics/index.html#json) データ処理用の [HTTP API](../basics/index.html#http-api)、
24 時間の運用サポートおよび保守を提供します。
Cloudant は、[Apache CouchDB ![「外部リンク」アイコン](../images/launch-glyph.svg "「外部リンク」アイコン")](http://couchdb.apache.org/){:new_window}
をベースとしており、マルチテナント、専用、インストール済みの各種サービスとして提供されます。


>   **注**: 本文書内の通貨の値はすべて米国ドル ($) です。

Cloudant DBaaS オファリングは、[https://cloudant.com/ ![「外部リンク」アイコン](../images/launch-glyph.svg "「外部リンク」アイコン")](https://cloudant.com/){:new_window} から利用可能です。
[Shared プラン](#shared-plan)または [Enterprise (Dedicated) プラン](#enterprise-plan)として提供されます。

Cloudant は、[IBM Bluemix サービス](bluemix.html)としても利用可能です。

>	**注:** Cloudant の[Shared プラン](#shared-plan)と[Enterprise (Dedicated) プラン](#enterprise-plan)のオファリングは、[IBM Bluemix サービス](bluemix.html)では利用できません。

### Shared プラン

Cloudant Shared プランでは、
共有、つまり「マルチテナント」のクラスターを通して提供されるすべての Cloudant DBaaS 機能にアクセスできます。

料金は、月々の使用量に基づいて課金されます。
月々の使用量が $50.00 未満の場合、料金は無料です (2016 年 8 月現在)。

詳しくは、
[価格設定の詳細 ![「外部リンク」アイコン](../images/launch-glyph.svg "「外部リンク」アイコン")](https://cloudant.com/product/pricing/){:new_window} を参照してください。

### Enterprise プラン

Cloudant DBaaS Enterprise プランでは、専用のシングル・テナント・クラスターを通して提供されるすべての Cloudant DBaaS 機能にアクセスできます。

このプランでは、さまざまなホスティング・ロケーションの専用の DBaaS クラスターまたはハードウェアを使用することで、データベースのパフォーマンスとアップタイムが保証されます。

詳しくは、
[価格設定の詳細 ![「外部リンク」アイコン](../images/launch-glyph.svg "「外部リンク」アイコン")](https://cloudant.com/product/pricing/){:new_window} を参照してください。

## Cloudant Local

[IBM Cloudant Data Layer Local Edition (Cloudant Local) ![「外部リンク」アイコン](../images/launch-glyph.svg "「外部リンク」アイコン")](https://www.ibm.com/support/knowledgecenter/SSTPQH_1.0.0/com.ibm.cloudant.local.doc/SSTPQH_1.0.0_welcome.html){:new_window}
は、ローカル・インストール・バージョンの Cloudant Database-as-a-Service (DBaaS) オファリングです。

Cloudant Local では、Cloudant シングル・テナントのフル・オファリングと同じ基本機能が提供されますが、お客様独自のデータ・センターでホスティングされます。


[Cloudant Local の概要詳細 ![「外部リンク」アイコン](../images/launch-glyph.svg "「外部リンク」アイコン")](http://www-01.ibm.com/support/knowledgecenter/SSTPQH_1.0.0/com.ibm.cloudant.local.install.doc/topics/clinstall_cloudant_local_overview.html?lang=en-us){:new_window} を参照してください。

[IBM Knowledge Center ![「外部リンク」アイコン](../images/launch-glyph.svg "「外部リンク」アイコン")](http://www-01.ibm.com/support/knowledgecenter/SSTPQH_1.0.0/com.ibm.cloudant.local.doc/SSTPQH_1.0.0_welcome.html?lang=en){:new_window}
に、以下を含む、Cloudant Local のさまざまな側面に関する情報があります。


-   [インストールと構成 ![「外部リンク」アイコン](../images/launch-glyph.svg "「外部リンク」アイコン")](http://www.ibm.com/support/knowledgecenter/SSTPQH_1.0.0/com.ibm.cloudant.local.install.doc/topics/clinstall_extract_install_cloudant_local.html?lang=en){:new_window}
-   [保守タスク ![「外部リンク」アイコン](../images/launch-glyph.svg "「外部リンク」アイコン")](http://www-01.ibm.com/support/knowledgecenter/SSTPQH_1.0.0/com.ibm.cloudant.local.install.doc/topics/clinstall_maintenance_tasks_overview.html?lang=en){:new_window}
-   [複製パラメーターのチューニング ![「外部リンク」アイコン](../images/launch-glyph.svg "「外部リンク」アイコン")](http://www-01.ibm.com/support/knowledgecenter/SSTPQH_1.0.0/com.ibm.cloudant.local.install.doc/topics/clinstall_tuning_parameters_replication_cases.html?lang=en){:new_window}

## [セキュリティー](security.html)

データ・アクセス制御、暗号化、およびデータ・バックアップの機能により、金融サービス、政府、e-コマース、通信、医療、その他のセキュリティー重視の業界では、{{site.data.keyword.cloudantfull}} を利用すると非常に効果的です。

## [コンプライアンス](compliance.html)

{{site.data.keyword.cloudant_short_notm}} は、信頼できるセキュアなクラウド・データベース・システムを提供します。
このサービスは、ISO 27001:2013 などの業界最高の規格を基盤としています。

[{{site.data.keyword.cloudant_short_notm}} データ・プライバシーとガバナンス](dataprivacygovernance.html)の詳細を参照してください。
