---

copyright:
  years: 2017
lastupdated: "2017-07-13"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-04-28 -->

# セキュリティー

## Cloudant DBaaS データの保護とセキュリティー

大規模な Web アプリやモバイル・アプリのアプリケーション・データの保護は、特に分散データベースおよび NoSQL データベースの場合、複雑である可能性があります。

{{site.data.keyword.cloudantfull}} は、データベースの継続的な稼働およびノンストップの拡大のためにデータベース保守作業を削減するとともに、
データの安全と保護を確保します。

## 最上位層の物理プラットフォーム

{{site.data.keyword.cloudant_short_notm}} DBaaS は、{{site.data.keyword.BluSoftlayer_full}} や Amazon などの
Tier-1 クラウド・インフラストラクチャー・プロバイダーで物理的にホスティングされます。
そのため、そうしたプロバイダーによって使用される、以下を含むネットワーク・セキュリティーおよび物理的セキュリティーの手段 (これに限られません) でデータが保護されます。


- 証明書: SSAE16、SOC2 Type 1、ISAE 3402、ISO 27001、CSA、その他の規格の準拠。
- アクセスおよび ID 管理。
- データ・センターおよびネットワーク運用センターのモニタリングによる一般の物理的セキュリティー。
- サーバー強化。
- {{site.data.keyword.cloudant_short_notm}} では、SLA やコスト要件の変化に伴って、
異なるプロバイダーの間で柔軟に選択や切り替えができます。

> **注:** 証明書に関する詳細は、[準拠情報](compliance.html)にあります。

## セキュアなアクセス制御

{{site.data.keyword.cloudant_short_notm}} には、データへのアクセスを制御するために多くのセキュリティー機能が組み込まれています。

- 認証: {{site.data.keyword.cloudant_short_notm}} には、HTTP API を使用してアクセスします。
  API エンドポイントによって要求されれば、
  {{site.data.keyword.cloudant_short_notm}} が受け取るすべての HTTPS または HTTP 要求
  についてユーザーが認証されます。
- 許可: 特定データベースに対する読み取り、
  書き込み、
  管理の許可を付与します。
- 「伝送中」の暗号化: {{site.data.keyword.cloudant_short_notm}} への
  アクセスはすべて、HTTPS を使用して暗号化されます。
- 保存状態での暗号化: {{site.data.keyword.cloudant_short_notm}} 内の
  ディスクに保管されるデータは、暗号化することができます。
  > **注**: {{site.data.keyword.Bluemix_notm}} {{site.data.keyword.cloudant_short_notm}} インスタンスに保管されるデータは、常に暗号化されます。
- API アクセス: セキュア HTTP (HTTPS) 上で API を使用することによって、
  {{site.data.keyword.cloudant_short_notm}} はプログラムでアクセスされます。
  API キーは、{{site.data.keyword.cloudant_short_notm}} ダッシュボードを使用して
 生成できます。
- IP ホワイトリスト登録: 専用環境の {{site.data.keyword.cloudant_short_notm}} のお客様は、
  IP アドレスのホワイトリスト登録により、指定されたサーバーとユーザーにのみ、アクセスを制限することができます。
- CORS: {{site.data.keyword.cloudant_short_notm}} ダッシュボードを使用して、
  特定ドメインの CORS サポートを有効にします。

## データ損失または破壊に対する保護

{{site.data.keyword.cloudant_short_notm}} には、データの品質と可用性を維持するために、以下のように多くの機能があります。

- 冗長の永続的データ・ストレージ: デフォルトで、
  {{site.data.keyword.cloudant_short_notm}} は、全文書をクラスター内の 3 つの異なるノードにコピーしてディスクに保存します。
  これらのコピーを保存することで、障害が発生しても、データの有効なフェイルオーバー・コピーが常に使用可能になります。
- データ複製とエクスポート: 異なるデータ・センターのクラスター間で、あるいは
  オンプレミスの Cloudant Local クラスター、
  または Apache CouchDB に、
  データベースを継続的に複製することができます。
  もう 1 つのオプションとして、データの冗長性を向上させるために、
  {{site.data.keyword.cloudant_short_notm}} (JSON 形式)
  からその他のロケーションまたはソース (お客様独自のデータ・センターなど)
  にデータをエクスポートすることができます。
