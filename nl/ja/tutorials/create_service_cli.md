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

<!-- Acrolinx: 2018-08-20 -->

# {{site.data.keyword.cloud_notm}} CLI を使用した {{site.data.keyword.cloud_notm}} 上の {{site.data.keyword.cloudant_short_notm}} インスタンスの作成

このチュートリアルでは、{{site.data.keyword.cloud_notm}} CLI を使用して {{site.data.keyword.cloud}} 上に {{site.data.keyword.cloudantfull}} サービス・インスタンスを作成する方法を示します。
{:shortdesc}

## 前提条件 

このチュートリアルに従うには、まず {{site.data.keyword.cloud_notm}} CLI Developer Tools をインストールする必要があります。これらのツールのインストールについて詳しくは、『[{{site.data.keyword.cloud_notm}} CLI の概説 ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://console.bluemix.net/docs/cli/index.html#overview){:new_window}』チュートリアルを参照してください。

## {{site.data.keyword.cloud_notm}} API エンドポイントの識別

{{site.data.keyword.cloud_notm}} コマンドにターゲットの API エンドポイントを指定します。

```sh
ibmcloud api https://api.ng.bluemix.net
```
{:codeblock}

エンドポイントを正しく識別したことが結果で確認されます。

```sh
Setting api endpoint to https://api.ng.bluemix.net...
OK

API endpoint:   https://api.ng.bluemix.net (API version: 2.54.0)
Not logged in. Use 'ibmcloud login' to log in.
```
{:pre}

## {{site.data.keyword.cloud_notm}} アカウントへのログイン

以下の例では、ログイン・プロセスについて説明しています。フェデレーテッド・ユーザー ID を使用している場合は、ワンタイム・パスコード (`ibmcloud login --sso`) に切り替えるか、API キー (`ibmcloud --apikey key or @key_file`) を使用して認証することが重要です。CLI を使用したログイン方法について詳しくは、 『[汎用 CLI (ibmcloud) コマンド ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://console.bluemix.net/docs/cli/reference/ibmcloud/bx_cli.html#ibmcloud_login){:new_window}』の『`ibmcloud login`』を参照してください。 

1.  以下のコマンドを使用して、{{site.data.keyword.cloud_notm}} アカウントのログイン・プロセスを開始します。
  
  ```sh
  ibmcloud login
  ```
  {:codeblock}
  
  {{site.data.keyword.cloud_notm}} は、現行 API エンドポイントを示して応答し、アカウントの E メール・アドレスを要求します。
  
  ```sh
  API endpoint: https://api.ng.bluemix.net
  
  Email>
  ```
  {:pre}

2.  以下のように、アカウントの E メール・アドレスを入力し、次にパスワードを入力します。

  ```sh
  API endpoint: https://api.ng.bluemix.net
  
  Email> J.Doe@email.com
  
  Password>
  ```
  {:pre}
  
  {{site.data.keyword.cloud_notm}} は、以下のように詳細を検証し、ログイン・セッションに関する情報を要約します。

  ```sh
  API endpoint: https://api.ng.bluemix.net
  
  Email> J.Doe@email.com
  
  Password>
  Authenticating...
  OK
  
  Targeted account J DOE's Account (707...a32)
  
  Targeted org J.Doe@email.com
  
  Targeted space dev
  
  API endpoint:   https://api.ng.bluemix.net (API version: 2.54.0)
  Region:         us-south
  User:           j.doe@email.com
  Account:        J DOE's Account (707...a32)
  Org:            J.Doe@email.com
  Space:          dev
  ```
  {:pre}

3.  これで、{{site.data.keyword.cloud_notm}} アカウントにログインしました。

## サービスの {{site.data.keyword.cloudant_short_notm}} プランの選択

{{site.data.keyword.cloudant_short_notm}} ライト・プランまたは標準プランの使用の詳細については、文書の『[プラン ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://console.bluemix.net/docs/services/Cloudant/offerings/bluemix.html#plans){:new_window}』セクションを参照してください。
{:pre}

## {{site.data.keyword.cloudant_short_notm}} サービスの作成

{{site.data.keyword.cloudant_short_notm}} は、新規インスタンスをプロビジョニングするために、Cloud Foundry の組織およびスペースではなく、リソース・グループを使用します。過去にプロビジョンされている {{site.data.keyword.cloudant_short_notm}} インスタンスは、引き続き Cloud Foundry の組織およびスペースにデプロイできます。詳しくは、『[How does IBM Cloudant work with IBM Cloud Resource Groups? ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://console.bluemix.net/docs/services/Cloudant/guides/resource-groups.html#how-does-ibm-cloudant-work-with-ibm-cloud-resource-groups-){:new_window}』ガイドを参照してください。

最初に、『[汎用 CLI (ibmcloud) コマンド ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://console.bluemix.net/docs/cli/reference/ibmcloud/bx_cli.html#ibmcloud_target){:new_window}』の『`ibmcloud target`』に示されているように、以下のフォーマットを使用してターゲットのリソース・グループと地域を設定します。

```sh
ibmcloud target [-r REGION_NAME] [-g RESOURCE_GROUP]
```

地域のリストを表示するには、以下のコマンドを実行します。

```sh
ibmcloud regions
```

リソース・グループのリストを表示するには、以下のコマンドを実行します。 

```sh
ibmcloud resource groups
```

次に、サービス・インスタンスを作成するには、{{site.data.keyword.cloud_notm}} 内の基本コマンド・フォーマットは以下のようになります。

```sh
ibmcloud resource service-instance-create NAME SERVICE_NAME|SERVICE_ID SERVICE_PLAN_NAME|SERVICE_PLAN_ID LOCATION [-p, --parameters @JSON_FILE | JSON_STRING ]
```
{:pre}

下表はフィールドの説明です。 


フィールド | 説明
------|------------
`NAME` | インスタンスに指定する任意の名前。
`SERVICE_NAME` | `cloudantnosqldb`
`PLAN_NAME` | ライト・プランまたは標準プラン。
`LOCATION` | デプロイする場所: AP 北部、ドイツ、グローバル、シドニー、英国、米国東部、または米国南部。
`legacyCredentials` | デフォルトは true です。このフィールドは、インスタンスがレガシーと IAM の両方の資格情報を使用するか、または IAM 資格情報のみを使用するかを示します。

認証方式の選択について詳しくは、「[IAM ガイド](../guides/iam.html#ibm-cloud-identity-and-access-management-iam-){:new_window}」を参照してください。

この例では、`ライト`・プラン (ここで、インスタンス名は `cs20170517a`、場所は「米国南部」で、「IAM 資格情報のみ使用」) を使用して {{site.data.keyword.cloudant_short_notm}} サービスのインスタンスを作成します。このインスタンスは、以下の例のようなコマンドを使用して作成します。

```sh
ibmcloud resource service-instance-create cs20170517a cloudantnosqldb lite us-south -p '{"legacyCredentials": false}'
```
{:codeblock}

サービス・インスタンスを作成すると、{{site.data.keyword.cloud_notm}} は、以下の例のようなメッセージで応答します。

```sh
Creating service instance cs20170517a in resource group default of account John Does's Account as j.doe@email.com...
OK
Service instance cs20170517a was created.
Name          Location   State    Type               Tags   
cs20170517a   us-south   active   service_instance  
```
{:pre}

## {{site.data.keyword.cloudant_short_notm}} サービスの資格情報の作成

{{site.data.keyword.cloudant_short_notm}} サービスへのアクセスを要求するアプリケーションには、必要な資格情報が必要です。

サービス資格情報は大切です。 資格情報にアクセスできるユーザーまたはアプリケーションは、サービス・インスタンスに対して事実上何でも実行できます。例えば、偽造データを作成したり、重要な情報を削除したりする可能性があります。これらの資格情報は、大切に保護してください。
{: tip}

サービス資格情報に含まれるフィールドの詳細については、「[IAM ガイド](../guides/iam.html#ibm-cloud-identity-and-access-management-iam-){:new_window}」を参照してください。

{{site.data.keyword.cloud_notm}} 内のサービス・インスタンスの資格情報を作成する基本コマンド・フォーマットは、以下のとおりです。

```sh
ibmcloud resource service-key-create NAME ROLE_NAME --instance-name SERVICE_INSTANCE_NAME
```
{:pre}

下表はフィールドの説明です。

フィールド | 説明
------|------------
`NAME` | サービス資格情報に指定する任意の名前。
`ROLE_NAME` | このフィールドで現在許可されるのはマネージャー役割のみです。
`SERVICE_INSTANCE_NAME` | {{site.data.keyword.cloudant_short_notm}} インスタンスに指定する名前。

{{site.data.keyword.cloudant_short_notm}} サービスの `cs20170517a` インスタンスの資格情報 (ここで、資格情報の名前は `creds_for_cs20170517a`) を作成する場合、以下の例のようなコマンドを使用してそれらの資格情報を作成します。

```sh
ibmcloud resource service-key-create creds_for_cs20170517a Manager --instance-name cs20170517a
```
{:codeblock}
サービス・インスタンスの資格情報を作成する要求を受け取ると、
{{site.data.keyword.cloud_notm}} は、以下の例のようなメッセージで応答します。

```sh
Creating service key in resource group default of account John Does's Account as john.doe@email.com...
OK
Service key crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42223455bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3:resource-key:621ffde2-ea10-4318-b297-d6d849cec48a was created.
                  
Name:          creds_for_cs20170517a   
ID:            crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42223455bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3:resource-key:621ffde2-ea10-4318-b297-d6d849cec48a   
Created At:    Tue Sep 18 19:58:38 UTC 2018   
State:         active   
Credentials:                                   
               iam_apikey_name:          auto-generated-apikey-621ffde2-ea10-4318-b297-d6d849cec48a      
               iam_role_crn:             crn:v1:bluemix:public:iam::::serviceRole:Manager      
               url:                      https://f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix:5811381f6daff7255b288695c3544be63f550e975bcde46799473e69c7d48d61@f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix.cloudant.com      
               username:                 f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix      
               port:                     443      
               apikey:                   XXXXX-XXXXXX_XXXXXXXXXXXXX-XXXXXXXXXXX      
               host:                     f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix.cloudant.com      
               iam_apikey_description:   Auto generated apikey during resource-key operation for Instance - crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42116849bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3::      
               iam_serviceid_crn:        crn:v1:bluemix:public:iam-identity::a/b42116849bb7e2abb0841ca25d28ee4c::serviceid:ServiceId-53f9e2a2-cdfb-4f90-b072-bfffafb68b3e      
               password:                 581138...7d48d61 
```
{:pre}

## {{site.data.keyword.cloudant_short_notm}} サービスのサービス資格情報のリスト

{{site.data.keyword.cloud_notm}} 内のサービス・インスタンスの資格情報を取得する基本コマンド・フォーマットは、以下のとおりです。

```sh
ibmcloud resource service-key KEY_NAME
```
{:pre}

この例では、{{site.data.keyword.cloudant_short_notm}} サービスの `cs20170517a` インスタンスの資格情報 (ここで、資格情報の名前は `creds_for_cs20170517a`) を取得します。資格情報は、以下の例のようなコマンドを使用して取得します。

```sh
ibmcloud resource service-key creds_for_cs20170517b
```
{:codeblock}

サービス・インスタンスの資格情報を取得する要求を受け取ると、
{{site.data.keyword.cloud_notm}} は、以下の (省略された) 例のようなメッセージで応答します。

```sh
Retrieving service key in resource group default of account John Does's Account as john.doe@email.com...
OK
Service key crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42223455bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3:resource-key:621ffde2-ea10-4318-b297-d6d849cec48a was created.
                  
Name:          creds_for_cs20170517a   
ID:            crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42223455bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3:resource-key:621ffde2-ea10-4318-b297-d6d849cec48a   
Created At:    Tue Sep 18 19:58:38 UTC 2018   
State:         active   
Credentials:                                   
               iam_apikey_name:          auto-generated-apikey-621ffde2-ea10-4318-b297-d6d849cec48a      
               iam_role_crn:             crn:v1:bluemix:public:iam::::serviceRole:Manager      
               url:                      https://f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix:5811381f6daff7255b288695c3544be63f550e975bcde46799473e69c7d48d61@f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix.cloudant.com      
               username:                 f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix      
               port:                     443      
               apikey:                   XXXXX-XXXXXX_XXXXXXXXXXXXX-XXXXXXXXXXX      
               host:                     f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix.cloudant.com      
               iam_apikey_description:   Auto generated apikey during resource-key operation for Instance - crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42116849bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3::      
               iam_serviceid_crn:        crn:v1:bluemix:public:iam-identity::a/b42116849bb7e2abb0841ca25d28ee4c::serviceid:ServiceId-53f9e2a2-cdfb-4f90-b072-bfffafb68b3e      
               password:                 581138...7d48d61 
```
{:pre}

## {{site.data.keyword.cloudant_short_notm}} サービス・インスタンスの使用

これで、以下のタスクが終了しました。

1.  {{site.data.keyword.cloudant_short_notm}} 内に {{site.data.keyword.cloud_notm}} サービス・インスタンスを作成しました
2.  {{site.data.keyword.cloudant_short_notm}} サービス・インスタンスの資格情報を作成しました。
3.  サービス・インスタンスの資格情報を取得しました。これらは、アプリケーションで使用できます。

詳しくは、レガシー資格情報を使用した Python アプリケーションからの {{site.data.keyword.cloudant_short_notm}} サービス・インスタンスの使用方法を示す、『[{{site.data.keyword.cloud_notm}} での単純 {{site.data.keyword.cloudant_short_notm}} データベースの作成とデータ取り込み](../tutorials/create_database.html#context){:new_window}』チュートリアルを参照してください。必ず、このチュートリアルで作成した資格情報を使用してください。

## (オプション) 事後のタイディアップ (整理)

開発環境のタイディアップ (整理) では、以下のいくつかのコマンドを利用できます。

### サービス資格情報の削除

一連のサービス資格情報を削除するには、以下のようなコマンドを使用します。

```sh
ibmcloud resource service-key-delete KEY_NAME
```
{:pre}

例えば、`creds_for_cs20170517a` という資格情報を削除するには、以下のようなコマンドを使用します。

```sh
ibmcloud resource service-key-delete creds_for_cs20170517a
```
{:pre}

### サービス・インスタンスの削除

サービス・インスタンスを削除するには、以下のようなコマンドを使用します。

```sh
ibmcloud resource service-instance-delete SERVICE_INSTANCE_NAME
```
{:pre}

例えば、{{site.data.keyword.cloudant_short_notm}} サービスの `cs20170517a` インスタンスを削除するには、以下のようなコマンドを使用します。

```sh
ibmcloud resource service-instance-delete cs20170517a
```
{:pre}

