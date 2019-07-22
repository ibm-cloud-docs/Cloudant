---

copyright:
  years: 2019
lastupdated: "2019-06-12"

keywords: endpoints, service credentials, authentication, ibm cloudant dashboard, curl, client libraries, IP whitelisting

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

<!-- Acrolinx: 2018-07-02 -->

# 接続
{: #connecting}

{{site.data.keyword.cloudantfull}} には、HTTP API を介してアクセスします。 ここでは、{{site.data.keyword.cloudant_short_notm}} への接続に使用するさまざまな部分を説明します。
- エンドポイント
- サービス資格情報
- 認証
- {{site.data.keyword.cloudant_short_notm}} ダッシュボードへのアクセス
- [curl ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://curl.haxx.se/){: new_window} またはクライアント・ライブラリーを介した {{site.data.keyword.cloudant_short_notm}} へのプログラマチック・アクセス 
{: shortdesc}

## エンドポイント
{: #endpoints}

{{site.data.keyword.cloudant_short_notm}} には HTTP API エンドポイントを介してアクセスします。 インスタンスのエンドポイントは、
そのインスタンス用に生成された「サービス資格情報」の URL フィールドと、{{site.data.keyword.cloudant_short_notm}} ダッシュボードの**「アカウント」** > **「設定」**タブの両方に表示されます。

すべての {{site.data.keyword.cloudant_short_notm}} HTTP エンドポイントには TLS 経由でアクセスする必要があるため、 `https://` が先頭に必要です。

パブリック・ネットワークに接している外部エンドポイントは次のとおりです。

`https://USERNAME.cloudant.com`

2019 年 1 月 1 日以降にプロビジョンされるすべてのインスタンスには、appdomain.cloud ドメイン・エンドポイントが含まれています。 パブリック・ネットワークに接している外部エンドポイントは次のとおりです。

`https://USERNAME.cloudantnosqldb.appdomain.cloud`

EU 管理環境の外部で 2019 年 1 月 1 日以降にプロビジョンされる専用ハードウェア環境上にデプロイされるインスタンスには、必ず内部エンドポイントが追加されます。 {{site.data.keyword.cloud_notm}} 内部ネットワーク・エンドポイントは次のとおりです。

`https://USERNAME.private.cloudantnosqldb.appdomain.cloud`

ここで USERNAME は URL でのサービス・インスタンス・ユーザーのサービス名です。 {{site.data.keyword.cloudant_short_notm}} のレガシー認証を使用している場合、このフィールドは管理ユーザー名としても機能します。 USERNAME の例が、
de810d0e-763f-46a6-ae88-50823dc85581-bluemix であったとすると、結果として得られる外部エンドポイント例は、
de810d0e-763f-46a6-ae88-50823dc85581-bluemix.cloudantnosqldb.appdomain.cloud になります。 

IP ホワイトリスティングを介してパブリック・ネットワーク接続をブロックする方法について詳しくは、[セキュアなアクセス制御](https://cloud.ibm.com/docs/services/Cloudant?topic=cloudant-security#secure-access-control)を参照してください。
{: note}

## サービス資格情報
{: #service-credentials}

{{site.data.keyword.cloud_notm}} ダッシュボードを使用して {{site.data.keyword.cloudant_short_notm}} のサービス資格情報を生成する場合、
「[{{site.data.keyword.cloud_notm}} での {{site.data.keyword.cloudant_short_notm}} インスタンスの作成](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud#creating-an-ibm-cloudant-instance-on-ibm-cloud)」のチュートリアルを参照してください。 {{site.data.keyword.cloud_notm}} CLI からサービス資格情報を生成する場合、[{{site.data.keyword.cloudant_short_notm}} サービスの資格情報の作成](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud-by-using-the-ibm-cloud-cli#creating-an-ibm-cloudant-instance-on-ibm-cloud-by-using-the-ibm-cloud-cli)を参照してください。 

{{site.data.keyword.cloudant_short_notm}} インスタンスのサービス資格情報の例を以下に示します。

```json
{
  "apikey": "MxVp86XHkU82Wc97tdvDF8qM8B0Xdit2RqR1mGfVXPWz",
  "host": "76838001-b883-444d-90d0-46f89e942a15-bluemix.cloudant.com",
  "iam_apikey_description": "Auto generated apikey during resource-key [...]",
  "iam_apikey_name": "auto-generated-apikey-050d21b5-5f[...]",
  "iam_role_crn": "crn:v1:bluemix:public:iam::::serviceRole:Manager",
  "iam_serviceid_crn": "crn:v1:staging:public:iam-identity::[...]",
  "password": "8fb6a16b48903e87b769e7f4968521e85c2394ed8f0e69b2769e56dcb27d2e76",
  "port": 443,
  "url": "https://<username>:<password>@76838001-b883-444d-90d0-46f89e942a15-bluemix.cloudant.com",
  "username": "76838001-b883-444d-90d0-46f89e942a15-bluemix"
}
```
{: codeblock}

サービス資格情報には以下のフィールドがあります。

フィールド | 目的
------|--------
`username` | URL でのサービス・インスタンス・ユーザーのサービス名。 このフィールドは、管理ユーザー名としても機能します。 
`password` | アプリケーションがサービス・インスタンスにアクセスするために必要なレガシー資格情報のパスワード。 このフィールドは、「`Use both legacy credentials and IAM`」オプションが選択されている場合にのみ表示されます。 
`host` | アプリケーションがサービス・インスタンスを検索するために使用するホスト名。 このフィールドは、「`Use both legacy credentials and IAM`」オプションが選択されている場合にのみ表示されます。 
`port` | ホスト上のサービス・インスタンスにアクセスするための HTTPS ポート番号。 {{site.data.keyword.cloudant_short_notm}} では HTTPS アクセスのみが許可されるため、これは 443 になります。 このフィールドは、「`Use both legacy credentials and IAM`」オプションが選択されている場合にのみ表示されます。 
`url`	| {{site.data.keyword.cloudant_short_notm}} インスタンスにアクセスするための HTTPS URL。 「`Use both legacy credentials and IAM`」オプションが選択されている場合は、組み込まれたレガシー・ユーザー名とパスワードも含まれます。 
`apikey` | IAM API キー。 
`iam_apikey_description` | IAM API キーの説明。 
`iam_apikey_name` | IAM API キーの ID。
`iam_role_crn` | IAM API キーの IAM 役割。
`iam_serviceid_crn`	| サービス ID の CRN。

## 認証
{: #authentication-overview}

{{site.data.keyword.cloudant_short_notm}} では、プロビジョニング時に「`Use only IAM`」または「`Use both legacy credentials and IAM`」の 2 つの認証方式が使用可能です。 「サービス資格情報」でレガシー資格情報についての詳細を表示できるのは、「`Use both legacy credentials and IAM`」認証方式を選択した場合のみになります。 資格情報は、インスタンスの「サービス資格情報」タブに表示されます。 これらの認証スタイルの使用について詳しくは、『[IAM ガイド](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-)』および 『[レガシー認証](/docs/services/Cloudant?topic=cloudant-authentication#authentication)』文書を参照してください。
 
{{site.data.keyword.cloudant_short_notm}} チームでは、可能な場合は認証に IAM アクセス制御を使用することをお勧めしています。 {{site.data.keyword.cloudant_short_notm}} のレガシー認証を使用している場合、 プログラマチック・アクセスと複製ジョブを行う際にはアカウント・レベルの資格情報ではなく [API キー](/docs/services/Cloudant?topic=cloudant-authorization#api-keys){: new_window}を使用することをお勧めします。 
{: important}

## {{site.data.keyword.cloudant_short_notm}}をモニターする
{: #ibm-cloudant-dashboard}

{{site.data.keyword.cloud_notm}} ダッシュボードのインスタンスの詳細ページの「管理」タブにアクセスすると、ご使用のインスタンスの {{site.data.keyword.cloudant_short_notm}} ダッシュボードを開くことができます。 `「起動」`または`「Cloudant ダッシュボードの起動」`
のいずれかのボタンを使用して、新規ブラウザー・タブでダッシュボードを開くことができます。 {{site.data.keyword.cloudant_short_notm}} ダッシュボードでは、以下のタスクを実行できます。

- インスタンスの現在の使用量のモニター
- {{site.data.keyword.cloudant_short_notm}} のデータベース、文書、および索引で CRUD (作成 (create)、読み取り (read)、更新 (update)、削除 (delete)) を実行
- 複製ジョブのセットアップと表示
- アクティブ・タスクの表示
- プロビジョン済みスループット能力、発表、CORS、および設定などのアカウント情報の表示と更新

## プログラマチック・アクセス
{: #programmatic-access}

### コマンド・ライン (curl)
{: #command-line-curl-}

curl コマンド・ライン・ユーティリティーを利用して、{{site.data.keyword.cloudant_short_notm}} HTTPS API にアクセスできます。 

{{site.data.keyword.cloudant_short_notm}} のレガシー認証を使用している場合は、
[API リファレンスの概要 (API reference overview)](/docs/services/Cloudant?topic=cloudant-api-reference-overview#api-reference-overview) を参照して、API リファレンス例に示すように、curl を使用して {{site.data.keyword.cloudant_short_notm}} API へアクセスするためのユーザー名とパスワードの指定についての詳細を確認してください。

{{site.data.keyword.cloud_notm}} IAM 認証を使用する場合は、まず API キーを使用して {{site.data.keyword.cloud_notm}} IAM トークンを取得する必要があります。 次に、IAM トークンを認証用に {{site.data.keyword.cloudant_short_notm}} インスタンスに渡します。 詳しくは、「サービスの API での認証のための {{site.data.keyword.cloud_notm}} IAM トークンの引き渡し」(https://cloud.ibm.com/docs/services/iam?topic=iam-iamapikeysforservices#token_auth) ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン") {: new_window} チュートリアルを参照してください。 

{{site.data.keyword.cloudant_short_notm}} に対する認証を行う際に直接 IAM API キーを使用することはできません。
{: note}

### クライアント・ライブラリー
{: #client-libraries-overview}

{{site.data.keyword.cloudant_short_notm}} には、Java、Node.js、Python、Swift、および Mobile 用の正式なクライアント・ライブラリーがあります。 ライブラリーへのアクセスついて詳しくは、[クライアント・ライブラリー資料](/docs/services/Cloudant?topic=cloudant-client-libraries#client-libraries)を参照してください。また、それぞれから {{site.data.keyword.cloudant_short_notm}}
インスタンスに接続する場合の例をご覧ください。 
