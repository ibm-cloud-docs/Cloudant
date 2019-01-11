---

copyright:
  years: 2018
lastupdated: "2018-10-24"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:tip: .tip}

<!-- Acrolinx: 2017-05-10 -->

# 一般データ保護規則 (GDPR)

GDPR は、EU 全体で統一されたデータ保護法の枠組みを作ろうと努めており、
世界中で個人データをホストして「処理する」ユーザーに厳密な規則を課しながら、
市民が各自の個人データを制御できるようにすることを目的としています。 この規則により、
EU 内外での個人データの自由な移動に関連する規則も導入されます。 

[一般データ保護規則 ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://www.eugdpr.org/){:new_window} では、{{site.data.keyword.cloudantfull}} のお客様は、
新たなデータ・プライバシー規格および法律に対する {{site.data.keyword.cloudant_short_notm}} チームの理解とコンプライアンス、および独自の内部データ・ガバナンス要件を持つさまざまな規模のビジネスを支援する包括的なソリューション・スイートを提供できる {{site.data.keyword.IBM}} の能力をご活用いただけます。

## {{site.data.keyword.cloudant_short_notm}} へのアクセスを監査する方法

監査に関する情報は、『[監査ロギング](../offerings/audit.html#audit-logging){:new_window}』にあります。 

## 個人データのサポートされる分類

GDPR 用に、
以下のカテゴリーの個人データが {{site.data.keyword.cloudant_short_notm}} でサポートされます。

**個人データ**。例:
 * ID/民法上の身分
 * 個人生活
 * 職業生活
 * ロケーション・データ
 * 接続/デバイス・データ

**機密個人データ**。以下に限定されます。
  * 医療データ。[{{site.data.keyword.cloudant_short_notm}} Dedicated クラスター・サービス記述 ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://www-03.ibm.com/software/sla/sladb.nsf/pdf/6756-04/$file/i126-6756-04_05-2018_en_US.pdf){:new_window} および [{{site.data.keyword.cloud}} 追加サービス記述 ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://www-03.ibm.com/software/sla/sladb.nsf/pdf/6627-04/$file/i126-6627-04_04-2018_en_US.pdf){:new_window} でカバーされるには、追加の条件が適用されます。

医療データを保管する場合は、以下のタスクを実行*する必要があります*。
 - データを書き込む前に {{site.data.keyword.cloudant_short_notm}} に通知する。
 - HIPAA 準拠の専用クラスターを要求する。

個人データのサポートされる分類について詳しくは、[Data Sheet Addendum (DSA) の『2. Personal Data』![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://www.ibm.com/software/reports/compatibility/clarity-reports/report/html/softwareReqsForProduct?deliverableId=2EBB5860B34311E7A9EB066095601ABB){:new_window} を参照してください。

## 自分に関するデータ

{{site.data.keyword.cloudant_short_notm}} は、そのユーザーに関する一部のデータを記録し、
当該個人情報 (PI) データのデータ管理者です。 {{site.data.keyword.cloudant_short_notm}} が記録するデータは、所有しているアカウントのタイプによって異なります。

{{site.data.keyword.cloudant_short_notm}} Dedicated クラスター/{{site.data.keyword.cloudant_short_notm}}
Enterprise クラスターがある場合、IBM はお客様に関するデータを記録し、
GDPR のコンテキストにおけるお客様のデータのデータ管理者と見なされます。 
{{site.data.keyword.cloudant_short_notm}} Dedicated クラスター/{{site.data.keyword.cloudant_short_notm}}
Enterprise クラスターがある場合、IBM はお客様に関する以下の情報を保持しています。

 * 名前
 * E メール

{{site.data.keyword.cloudant_short_notm}} が保持しているデータは、{{site.data.keyword.cloudant_short_notm}} ダッシュボードで表示および更新できます。

{{site.data.keyword.cloud_notm}} (専用インスタンスも含む) によってプロビジョンされているアカウントがある場合、
{{site.data.keyword.cloudant_short_notm}} は、前述の個人データを収集_しません_ 。 このデータは、{{site.data.keyword.cloud_notm}} で保持されます。

{{site.data.keyword.cloudant_short_notm}} は、サービスを実行し、そのユーザー・エクスペリエンスを最適化する際に、
限定されたお客様の PI を処理します。 {{site.data.keyword.cloudant_short_notm}} は、必要に応じて、お客様に連絡するために E メールを使用します。 お客様の {{site.data.keyword.cloudant_short_notm}} ダッシュボードとの対話をモニターすることも、
{{site.data.keyword.cloudant_short_notm}} が PI を処理するもう 1 つの方法です。

### 処理の制限

{{site.data.keyword.cloudant_short_notm}} は、ダッシュボード対話データをセグメントに送信します。 [{{site.data.keyword.cloudant_short_notm}} サポート要求](mailto:support@cloudant.com)により、
この方法でのお客様の PI の処理を制限するように {{site.data.keyword.cloudant_short_notm}} に要求することが可能です。 そのような要求を受け取ると、
{{site.data.keyword.cloudant_short_notm}} は、セグメントに送信されるお客様に関連する情報を削除し、
以降にデータが送信されないようにします。 {{site.data.keyword.cloudant_short_notm}} は、Dedicated のお客様に E メールで引き続き連絡できる必要があり、また、直接、あるいは {{site.data.keyword.cloud_notm}} アカウント詳細での連絡先詳細のお客様の構成を介して、お客様がこの情報を最新状態に保てるようにするインターフェースを提供する必要があります。

## {{site.data.keyword.cloudant_short_notm}} データベースの暗号化状態

すべてのクラスターで、Linux Unified Key Setup (LUKS) を使用した暗号化ファイル・システム (保存時の暗号化) があります。 データベース内のデータは、
IBM の運用およびサポート・チームから可視です (以下を参照)。

{{site.data.keyword.cloudant_short_notm}} から可視でないようにする必要があるとお客様が判断した機密データについては、
お客様が IBM にデータを送信する前に暗号化するか、保護 (仮名化) する必要があります。 URL は常に可視で、アクセス・ログに書き込まれるため、URL で文書 `_id` として PI を使用するのは避ける必要があります。例、`https://$ACCOUNT.cloudant.com/$DATABASE/$DOCUMENT_ID`。

## データの場所

{{site.data.keyword.cloudant_short_notm}} が個人データを処理する場所は、DSA で公開され、
最新状態に保たれます。

データの場所について詳しくは、[DSA の『7. {{site.data.keyword.IBM_notm}} Hosting and Processing Locations』 ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://www.ibm.com/software/reports/compatibility/clarity-reports/report/html/softwareReqsForProduct?deliverableId=2EBB5860B34311E7A9EB066095601ABB){:new_window}を参照してください。

## サービス・セキュリティー

### {{site.data.keyword.cloudant_short_notm}} の安全な使用

{{site.data.keyword.cloudant_short_notm}} のユーザーとして、以下のようにする必要があります。

 * 予期しないアクセスを防止するために、デフォルトの CORS 構成を使用します。
 * コンポーネントが監査ログと組み合わせて「最小の特権アクセス」を持てるように、 API キーを十分に使用します。 このプラクティスにより、誰がどのデータにアクセスしたのかを把握できます。
 * {{site.data.keyword.cloudant_short_notm}} から非可視のままになる必要があると判断した機密データは暗号化または保護 (仮名化) する必要があります。

### 物理および環境のセキュリティー対策

データ・センターの物理的セキュリティーは、インフラストラクチャー・プロバイダー (SoftLayer、AWS、
および 21Vianet) によって処理されます。 そのすべてが、物理的セキュリティーについて、外部監査された認定を保有しています。 {{site.data.keyword.cloudant_short_notm}} は、データ・センターで
配備されている物理的セキュリティー管理のこれ以上の詳細は、
提供しません。

IBM のスタッフが使用しているオフィス・ロケーションの物理的セキュリティーは、{{site.data.keyword.IBM_notm}} Corporate によって処理されます。 
認定の詳細および証明レポート (つまり、ISO や SOC2) は、
お客様の要求を受けて提供可能です。

### 技術的および組織的対策

技術的および組織的対策 (TOM) は、{{site.data.keyword.cloudant_short_notm}} で個人データのセキュリティーを
確保するために利用されています。 {{site.data.keyword.cloudant_short_notm}} は、{{site.data.keyword.cloudant_short_notm}} が利用する管理に対して外部監査された認定を保有しています。認定の詳細および証明レポート (つまり、ISO や SOC2) は、
お客様の要求を受けて提供可能です。

### データへのサービス・アクセス

{{site.data.keyword.cloudant_short_notm}} 運用およびサポート・スタッフは、
お客様のデータにアクセスすることができ、
日常的な操作中にアクセスすることがあります。 このアクセスは、サービスを運用およびサポートするために、必要に応じてのみ実行されます。 
また、アクセスは、*必要最小限*ベースに制限され、ログに記録、モニター、および監査されます。

## データの削除

### 文書の削除

文書が削除されると、データベースは「トゥームストーン」を作成します。 トゥームストーンに含まれる内容は、
削除方法によって異なります。

 - `DELETE` 呼び出しを行った場合、トゥームストーンには、`_id`、`_rev`、および `_deleted` の各フィールドが含まれます。
 - `_deleted: true` フィールドでの文書の更新および `PUT` または `POST` によって削除した場合、トゥームストーンには、文書本体で設定した内容が含まれます。 このプラクティスは、例えば、
文書が削除された理由をトゥームストーンで記録する場合などの一部の状況で役立つことがあります。

トゥームストーンの削除について詳しくは、『[「トゥームストーン」文書の単純な除去 (Simple removal of 'tombstone' documents)](../api/document.html#-tombstone-documents){:new_window}』を参照してください。

### 削除された文書が除去されるタイミング

圧縮が自動的に実行され、「リーフ」の改訂のみを新規ファイルに書き出すことで、
古い改訂が定期的にデータベースから除去 (削除など) されます。 {{site.data.keyword.cloudant_short_notm}} は、複製が可能になるように、`_id` および `_rev` の履歴は保持されますが、
古い文書本体は保持されません。

> **注**: {{site.data.keyword.cloudant_short_notm}} では、CouchDB 圧縮 API は公開されません。

{{site.data.keyword.cloudant_short_notm}} は、データベースが特定の時間内に圧縮されることは保証されません。 
圧縮はストレージ層全体でバックグラウンド・プロセスとして行われ、
データベースは常に圧縮されます。単にそれが削除/変更したデータであるという保証がないだけです。

{{site.data.keyword.cloudant_short_notm}} は、[{{site.data.keyword.IBM_notm}} Data Privacy Office (DPO) ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](http://w3-03.ibm.com/ibm/privacy/index.html){:new_window} を介して、*忘れられる権利* の要求を受け入れます。 
*忘れられる権利* の要求が {{site.data.keyword.IBM_notm}} DPO から行われると、{{site.data.keyword.cloudant_short_notm}} は要求を検査し、データベース圧縮を明示的にトリガーし、圧縮が行われたことを検査します。
このプロセスの最後には、文書の唯一のバージョンは、トゥームストーン (`_id`、`_rev`、`_deleted`、およびアプリケーションでそこに含まれているすべてのフィールド) になります。

### トゥームストーンの除去

{{site.data.keyword.cloudant_short_notm}} では、必要に応じて、文書のすべての参照およびデータを
完全に除去できます。 このタスクは、パージと呼ばれる
オペレーター管理プロセスです。 文書のパージを要求する前に、
プロセスが完了すると、
パージされた文書は {{site.data.keyword.cloudant_short_notm}} で*復旧できない* ということを
理解しておくことが重要です。

> **注**: CouchDB パージ API は {{site.data.keyword.cloudant_short_notm}} ではサポートされません。

GDPR のコンテキストでは、パージが必要になるのは、文書 ID で PI が使用されている場合のみです。 多くの理由のため、
`_id` に PI を格納するのは不適切ですが、
半ば有効なユース・ケースもわずかに存在します (例えば、固有の E メール)。 可能であれば、データを暗号化または仮名化して、
{{site.data.keyword.cloudant_short_notm}} から内部が見えないようにしてください。

*忘れられる権利* の要求によって文書の除去が必要な場合、以下のようになります。

1. [{{site.data.keyword.IBM_notm}} DPO ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](http://w3-03.ibm.com/ibm/privacy/index.html){:new_window} で要求を申し立て、理由とともに、特定の文書 `_id` 値のパージを要求します。
1. {{site.data.keyword.IBM_notm}} DPO からの正式な要求を受け取ると、{{site.data.keyword.cloudant_short_notm}} 運用チームは、
要求を検査して、`id` に PI が含まれていることを確認します。 {{site.data.keyword.cloudant_short_notm}} は、`_id` に PI が含まれていないデータはパージしません。 
1. {{site.data.keyword.cloudant_short_notm}} が、要求されたデータを永久的に除去するパージ・アクションをトリガーします。

このプロセスは、緊急削除要求 (例えば、*忘れられる権利*) の場合にのみ使用するものであり、
長期的に利用してはなりません。 アプリケーションで文書 ID 内に PI を意図的に使用している場合、
その PI を仮名化するか、文書 ID で PI を使用しないように
変更する必要があります。 これを回避するために、{{site.data.keyword.cloudant_short_notm}} 運用チームによる定期的なパージに依存することはできません。 
そのため、{{site.data.keyword.cloudant_short_notm}} では、以下のパージ要求は拒否します。

1. 定期的なパージの要求である (例えば、*30 日ごと*)。
1. 100 を超える文書に対する要求である。

パージを使用した場合でも、`_id` フィールド内の PI は、{{site.data.keyword.cloudant_short_notm}} ログなど、
望ましくない場所に漏えいするので、避けてください。 
{{site.data.keyword.cloudant_short_notm}} は、該当するログを保持する業務上の理由があるため、
文書 `_id` 値が含まれているログの行を除去することはありません。

### データベースの削除

データベースを削除すると、そのデータベースはごみ箱に最大 48 時間保管された後、
ファイル・システムから除去されます。 {{site.data.keyword.cloudant_short_notm}} チームは、データベースのバックアップを作成*しません*。そのタスクは、
*お客様の責任* です。 データベースのすべてのコピーがシステムから
除去されるようにする必要があります。 詳しくは、『[{{site.data.keyword.cloudant_short_notm}} バックアップおよびリカバリー](../guides/backup-cookbook.html#cloudant-nosql-db-backup-and-recovery){:new_window}』を参照してください。 

追加の支援が必要な場合は、
[{{site.data.keyword.cloudant_short_notm}} サポート ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](mailto:support@cloudant.com) にお問い合わせください。

