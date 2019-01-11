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

# セキュリティー
{: #security}

## {{site.data.keyword.cloudant_short_notm}} DBaaS データの保護とセキュリティー
{: #ibm-cloudant-dbaas-data-protection-and-security}

大規模な Web アプリやモバイル・アプリのアプリケーション・データの保護は、特に分散データベースおよび NoSQL データベースの場合、複雑である可能性があります。

{{site.data.keyword.cloudantfull}} は、データベースの継続的な稼働およびノンストップの拡大のためにデータベース保守作業を削減するとともに、データの安全と保護を確保します。
{:shortdesc}

## 最上位層の物理プラットフォーム
{: #top-tier-physical-platforms}

{{site.data.keyword.cloudant_short_notm}} DBaaS は、{{site.data.keyword.cloud}} や Amazon などの
Tier-1 クラウド・インフラストラクチャー・プロバイダーで物理的にホスティングされます。
そのため、そうしたプロバイダーによって使用される、以下を含むネットワーク・セキュリティーおよび物理的セキュリティーの手段 (これに限られません) でデータが保護されます。

- 証明書: SSAE16、SOC2 Type 1、ISAE 3402、ISO 27001、CSA、その他の規格の準拠。
- アクセスおよび ID 管理。
- データ・センターおよびネットワーク運用センターのモニタリングによる一般の物理的セキュリティー。
- サーバー強化。
- {{site.data.keyword.cloudant_short_notm}} では、SLA やコスト要件の変化に伴って、
異なるプロバイダーの間で柔軟に選択や切り替えができます。

証明書に関する詳細は、[準拠情報](compliance.html)にあります。
{:tip}

## セキュアなアクセス制御
{: #secure-access-control}

{{site.data.keyword.cloudant_short_notm}} には、データへのアクセスを制御するための多数のセキュリティー機能が組み込まれています。

機能 | 説明
--------|------------
認証 | {{site.data.keyword.cloudant_short_notm}} には、HTTPS API を使用してアクセスします。 API エンドポイントによって要求されれば、
  {{site.data.keyword.cloudant_short_notm}} が受け取るすべての HTTPS 要求
  についてユーザーが認証されます。 {{site.data.keyword.cloudant_short_notm}} は、レガシーと IAM の両方のアクセス制御をサポートしています。詳しくは、『[IAM ガイド](../guides/iam.html){:new_window}』またはレガシー『[認証 API 文書](../api/authentication.html){:new_window}』を参照してください。
 許可 |{{site.data.keyword.cloudant_short_notm}} は、レガシーと IAM の両方のアクセス制御をサポートしています。詳しくは、『[IAM ガイド](../guides/iam.html){:new_window}』およびレガシー『[許可 API 文書](../api/authorization.html){:new_window}』を参照してください。
「伝送時」の暗号化 | {{site.data.keyword.cloudant_short_notm}} へのすべてのアクセスは HTTPS を使用して暗号化されます。
保存時の暗号化 | {{site.data.keyword.cloudant_short_notm}} インスタンスに保管されているすべてのデータは、保存時に暗号化されます。保存時の暗号化で BYOK (Bring-Your-Own-Key) が必要な場合、この暗号化は、{{site.data.keyword.cloud_notm}} 鍵の保護を使用して有効化されます。{{site.data.keyword.cloudant_short_notm}} では、
すべての地域でデプロイされる新しい {{site.data.keyword.cloudant_short_notm}} 専用ハードウェア・プラン・インスタンスでこの機能をサポートします。 まず、{{site.data.keyword.cloud_notm}} カタログを使用して、専用ハードウェア・プラン・インスタンスを作成します。 次に、
サポート・チケットを送信します。 新規専用ハードウェア・インスタンスの保存時の暗号化用の暗号鍵の取得をサポート・チームが調整します。
この暗号鍵は、鍵の保護インスタンスによって管理されます。
IP ホワイトリスティング | 専用の {{site.data.keyword.cloudant_short_notm}} 環境がある {{site.data.keyword.cloudant_short_notm}} のお客様は、IP アドレスのホワイトリスト登録により、指定したサーバーおよびユーザーのみにアクセスを制限することができます。IP ホワイトリスティングは、マルチテナント環境にデプロイされている {{site.data.keyword.cloud_notm}} Public のライト・プラン/標準プランでは使用できません。指定した IP セットまたは IP 範囲の IP ホワイトリストを要求するには、サポート・チケットをオープンしてください。IP ホワイトリストは、{{site.data.keyword.cloudant_short_notm}} API およびダッシュボードの両方に適用されるため、{{site.data.keyword.cloudant_short_notm}} ダッシュボードに直接アクセスする必要がある管理者 IP を含めるときは注意してください。
CORS | {{site.data.keyword.cloudant_short_notm}} ダッシュボードを使用して、
  特定ドメインの CORS サポートを有効にします。

<!--
> **Note**: Your data is visible to the {{site.data.keyword.cloudant_short_notm}} 
> worldwide team. If you don’t 
> want our team to see your data, encrypt it before sending it to 
> {{site.data.keyword.IBM_notm}}, and avoid leaking 
> data into your document `_id` and any attachment file names. In addition, 
> when you send personal data, you must use HTTPS to ensure that it is sent securely. 
> HTTP is no longer supported.  

> **Warning**: You are responsible for verifying that 
> {{site.data.keyword.cloudant_short_notm}} can be used to store 
> your data. You must also make sure that your data does not violate applicable 
> data protection laws or any regulations that require security measures 
> beyond those specified in the {{site.data.keyword.cloudant_short_notm}} 
> system requirements and {{site.data.keyword.cloud_notm}} Services terms. You must 
> verify that the security requirements are appropriate for any personal data 
> that is processed. If you are unsure, or intend to store data that is 
> beyond the scope of the {{site.data.keyword.cloudant_short_notm}} terms and conditions, 
> you must get approval from {{site.data.keyword.IBM_notm}} to ensure that it is 
> appropriate for {{site.data.keyword.cloudant_short_notm}} to store your data.
-->

## データ損失または破壊に対する保護
{: #protection-against-data-loss-or-corruption}

{{site.data.keyword.cloudant_short_notm}} には、データの品質と可用性を維持するために、以下のように多くの機能があります。

機能 | 説明
--------|------------
冗長の永続的データ・ストレージ | デフォルトで、 {{site.data.keyword.cloudant_short_notm}} は、全文書をクラスター内の 3 つの異なるノードにコピーしてディスクに保存します。 これらのコピーを保存することで、障害が発生しても、データの有効なフェイルオーバー・コピーが常に使用可能になります。
データ複製とエクスポート | 異なるデータ・センターのクラスター間で、あるいはオンプレミスの {{site.data.keyword.cloudant_short_notm}} Local クラスター、または Apache CouchDB に、データベースを継続的に複製することができます。 もう 1 つのオプションとして、データの冗長性を向上させるために、
  {{site.data.keyword.cloudant_short_notm}} (JSON 形式)
  からその他のロケーションまたはソース (お客様独自のデータ・センターなど)
  にデータをエクスポートすることができます。
