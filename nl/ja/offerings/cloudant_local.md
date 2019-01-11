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

# {{site.data.keyword.cloudant_local_notm}}

[{{site.data.keyword.cloudantfull}} Data Layer Local Edition ({{site.data.keyword.cloudant_local_notm}}) ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://www.ibm.com/support/knowledgecenter/SSTPQH_1.1.0/com.ibm.cloudant.local.doc/SSTPQH_1.1.0_welcome.html){:new_window} は、ローカル・インストール・バージョンの {{site.data.keyword.cloudant_short_notm}} Database-as-a-Service (DBaaS) オファリングです。

{{site.data.keyword.cloudant_local_notm}} では、{{site.data.keyword.cloudant_short_notm}} シングル・テナントのフル・オファリングと同じ基本機能が提供されますが、
お客様独自のデータ・センターでホスティングされます。

{{site.data.keyword.cloudant_local_notm}} の [概要詳細 ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://www.ibm.com/support/knowledgecenter/en/SSTPQH_1.1.0/com.ibm.cloudant.local.install.doc/topics/clinstall_cloudant_local_overview.html){:new_window} を
参照してください。
[IBM Knowledge Center ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://www.ibm.com/support/knowledgecenter/en/SSTPQH_1.1.0/com.ibm.cloudant.local.doc/SSTPQH_1.1.0_welcome.html){:new_window}
に、以下を含む、
{{site.data.keyword.cloudant_local_notm}} のさまざまな側面に関する情報があります。

-   [インストールと構成 ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://www.ibm.com/support/knowledgecenter/en/SSTPQH_1.1.0/com.ibm.cloudant.local.install.doc/topics/clinstall_installing.html){:new_window}
-   [保守タスク ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://www.ibm.com/support/knowledgecenter/en/SSTPQH_1.1.0/com.ibm.cloudant.local.install.doc/topics/clinstall_maintenance_tasks_overview.html){:new_window}
-   [複製パラメーターのチューニング ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://www.ibm.com/support/knowledgecenter/en/SSTPQH_1.1.0/com.ibm.cloudant.local.install.doc/topics/clinstall_tuning_parameters_replication_cases.html){:new_window}

## サポート

{{site.data.keyword.cloudant_short_notm}} サポートは、{{site.data.keyword.cloudant_local_notm}} のインストール、セットアップ、および適切な使用法に関する支援を提供できます。パフォーマンスの問題または不整合が発生した場合、サポートはトラブルシューティングを支援できます。障害が発生した場合、サポートは問題の診断は支援できますが、クライアントのシステムにアクセスできないため、問題の解決についてはクライアント・チームの責任となります。

問題についての適切な支援を提供するには、適切なログが必要です。できるだけ迅速にトラブルシューティングを開始するためには、サポートに問題を通知するときに、Weatherreport ユーティリティーの出力のほか、関連するログ、要求、および状況コードを含める必要があります。詳しくは、[Weatherreport utility ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://www.ibm.com/support/knowledgecenter/SSTPQH_1.1.0/com.ibm.cloudant.local.install.doc/topics/clinstall_checking_health_cluster_with_weatherreport.html){:new_window} を参照してください。

一般的な問題および障害の支援は、根本的な問題がサポートの範囲内である場合に提供できます。以下のテキストで、使用可能なサポートについて説明します。 

{{site.data.keyword.cloudant_short_notm}} サポートは、以下の問題をカバーしています。
- 適切なインストール
- セットアップ
- エラーまたは予期しない結果やパフォーマンスを返す API に関連したこと

{{site.data.keyword.cloudant_short_notm}} サポートは、以下の問題をカバーしません。
- 所有するクライアント・サイドのツールまたはワークフロー
- ネットワークの問題 
- オンディスク暗号化 
- カスタム・ツールまたは機能

例えば、根本原因がクライアント所有のサーバーで発生しているハードウェア問題の場合、サポートは支援できません。ただし、障害が {{site.data.keyword.cloudant_short_notm}} ソフトウェア自体によるものである場合、例えば、文書の競合のために要求のスローダウンが発生した場合、サポートはクライアントが問題を解決するのを支援できます。

以下の要求の追加支援については、カスタマー・サクセスまたはアカウント・マネージャーにお問い合わせください。
- パフォーマンス・チューニング
- 設計の最適化
- キャパシティー・プランニング

サポート・ポリシーについてご質問がある場合は、[{{site.data.keyword.cloudant_short_notm}} サポート・チーム ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](mailto:support@cloudant.com){:new_window} までご連絡ください。

### サポート・チケットのオープン方法
{{site.data.keyword.cloudant_local_notm}} の問題についてヘルプを得るには、{{site.data.keyword.cloudant_short_notm}} サポートでサポート・チケットをオープンし、以下の情報を含めてください。

1. [{{site.data.keyword.cloudant_short_notm}} サポート要求](mailto:support@cloudant.com)をオープンするための E メールを作成します。
2. E メールの件名行に、問題に関する単一の文を入力します。
3. E メールには、問題の診断に役立つ以下の詳細が含まれている必要があります。
    - 名前
    - 連絡先 E メール・アドレス
    - 組織の名前
    - 使用している {{site.data.keyword.cloudant_local_notm}} のバージョン
    - {{site.data.keyword.cloudant_local_notm}} の実行に使用している Linux ディストリビューションおよびバージョン
    - 問題の重大度レベル
    - 問題の詳細な説明 (発生した条件や最近の変更に関する情報など)
    - 可能であれば、問題の診断、再現、および調査に役立つ可能性のあるログや出力を添付
4. サポートが E メールを受信すると、サポート・チームのメンバーがお客様に連絡します。

