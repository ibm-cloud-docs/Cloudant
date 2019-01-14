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

<!-- Acrolinx: 2017-05-10 -->

# {{site.data.keyword.cloud_notm}} Dedicated

{{site.data.keyword.cloudantfull}} for ({{site.data.keyword.cloud}} Dedicated) は、
オプションで購入する {{site.data.keyword.cloud_notm}} Dedicated 環境のアドオンです。 {{site.data.keyword.cloud_notm}} Dedicated の {{site.data.keyword.cloudant_short_notm}} Dedicated 用のオプションのアドオンは、
環境に割り振られたハードウェア容量に基づいて価格設定されており、
{{site.data.keyword.IBM}} 営業担当員に問い合わせることで購入できます。  

{{site.data.keyword.cloud_notm}} Dedicated のお客様は、ライト・プラン・インスタンスと標準プラン・インスタンスを含め、
シンジケートされたカタログを介して {{site.data.keyword.cloud_notm}} Public で {{site.data.keyword.cloudant_short_notm}} を使用することを選択することもできます。 {{site.data.keyword.cloud_notm}} Dedicated ユーザーは、
{{site.data.keyword.cloud_notm}} Public カタログから専用ハードウェア・プランを購入する資格を持っておらず、
専用ハードウェアが必要な場合は {{site.data.keyword.cloud_notm}} Dedicated で {{site.data.keyword.cloudant_short_notm}} Dedicated を
活用する必要があることに注意してください。   

以下のスクリーン・ショットは、{{site.data.keyword.cloud_notm}} Public のシンジケートされたバージョンの {{site.data.keyword.cloudant_short_notm}} (左) と {{site.data.keyword.cloudant_short_notm}} Dedicated 環境 (右) が
強調表示された {{site.data.keyword.cloud_notm}} カタログの例を示しています。  

![{{site.data.keyword.cloudant_short_notm}} カタログ](../images/bluemix_catalog.png)

## ハードウェア容量 

{{site.data.keyword.cloud_notm}} Dedicated 内の {{site.data.keyword.cloudant_short_notm}} は、「{{site.data.keyword.cloud_notm}} Dedicated
{{site.data.keyword.cloudant_short_notm}} 1.6 TB の容量」部分から購入します。
これには、3 つのデータベース・ノードと 2 つのロード・バランサーからなるクラスター化された {{site.data.keyword.cloudant_short_notm}} 環境が含まれています。 各データベース・ノードは SSD の 1.6 TB を含んでいます。すべてのデータが三重に保管されるため、これはクラスター全体の固有ディスク・スペースの 1.6 TB に相当します。 環境を拡張するには、追加の「{{site.data.keyword.cloud_notm}} Dedicated
{{site.data.keyword.cloudant_short_notm}} 1.6TB 容量」部分を購入します。これは、3 つのデータベース・ノードの倍数で {{site.data.keyword.cloudant_short_notm}} クラスターを拡張するために使用できます。 お客様は、単一の環境を拡張するのではなく、複数の別個の {{site.data.keyword.cloudant_short_notm}} 環境を使用するように選択することもできます。

## ロケーションとテナンシー 

{{site.data.keyword.cloud_notm}} Dedicated 環境内の {{site.data.keyword.cloudant_short_notm}} Dedicated 環境は、
{{site.data.keyword.cloud_notm}} Dedicated のお客様専用として指定されたハードウェア上にあります。 お客様は、特定の環境で {{site.data.keyword.cloudant_short_notm}} の 1 つ以上のインスタンスをプロビジョンでき、{{site.data.keyword.cloudant_short_notm}} の各インスタンスが、{{site.data.keyword.cloudant_short_notm}} 環境を構成する基礎となるハードウェア・リソースを共有します。 

## セキュリティー、暗号化、およびコンプライアンス 

すべてのプランは、[保存されたデータ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://en.wikipedia.org/wiki/Data_at_rest) のディスク暗号化を使用してサーバー上に提供されます。 アクセスはパブリックネットワーク接続経由で行われ、HTTPS を使用して暗号化されます。 詳しくは、[Security ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](../offerings/security.html#security){:new_window} を参照してください。 
IP ホワイトリスト登録は、{{site.data.keyword.cloudant_short_notm}} サポートへの要求で使用可能になり、インスタンス・レベルではなく {{site.data.keyword.cloudant_short_notm}} 環境全体に適用されます。  

これらのプランは、[コンプライアンス認証 ![ 外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://console.bluemix.net/docs/services/Cloudant/offerings/compliance.html#cloudant-security-compliance){:new_window} も提供しています。 

[HIPAA ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://en.wikipedia.org/wiki/Health_Insurance_Portability_and_Accountability_Act){:new_window} コンプライアンスは要求に応じて使用可能であるため、{{site.data.keyword.IBM_notm}} 営業担当員との購入プロセス中にこれを要求してください。 

## 高可用性、災害復旧、およびバックアップ 

データ・センター内で高可用性 (HA) および災害復旧 (DR) を提供するため、すべてのデータは、クラスター内の 3 つの別々の物理サーバーに三重に保管されます。 使用可能な場合、複数のロケーション内でアカウントをプロビジョンし、次に継続的データ複製を使用して、複数のデータ・センターにわたって HA/DR を備えることができます。 {{site.data.keyword.cloudant_short_notm}} データは自動的にバックアップされませんが、バックアップを処理するためにサポートされるツールが用意されています。 アプリケーション要件を満たすための、HA、DR、およびバックアップのすべての考慮事項を調べるには、[「災害復旧およびバックアップ」![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://console.bluemix.net/docs/services/Cloudant/guides/disaster-recovery-and-backup.html#disaster-recovery-and-backup){:new_window} のガイドを参照してください。
