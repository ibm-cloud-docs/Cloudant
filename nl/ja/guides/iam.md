---

copyright:
  years: 2017, 2019
lastupdated: "2019-03-06"

keywords: legacy access controls, api keys, enable iam, provisioning, how to choose between iam and legacy credentials, making requests, required client libraries, actions, endpoints, map actions to iam roles

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

# {{site.data.keyword.cloud_notm}} Identity and Access Management (IAM)
{: #ibm-cloud-identity-and-access-management-iam-}

{{site.data.keyword.cloud}} Identity and Access Management を使用すると、統一された方法で
ユーザー ID、サービス、およびアクセス制御を管理できます。
{: shortdesc}

## 概要
{: #introduction}

この資料では、{{site.data.keyword.cloud_notm}} Identity and Access Management と
{{site.data.keyword.cloudantfull}} の統合について説明します。 最初に、{{site.data.keyword.cloudant_short_notm}} の従来のアクセス制御と
{{site.data.keyword.cloud_notm}} IAM のアクセス制御の違いについて説明します。 次に、どちらを使用するか決定できるようにするために、
それぞれの長所と短所について説明します。 その後、{{site.data.keyword.cloudant_short_notm}} のクライアント・ライブラリー内で IAM を使用する方法、
および HTTP 呼び出しを通じて IAM を使用する方法について説明します。 最後に、{{site.data.keyword.cloudant_short_notm}} 内で使用できる
すべての IAM アクションおよび役割について説明するリファレンス・セクションを示します。

以下の方法については、[IAM ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://cloud.ibm.com/docs/iam/index.html#iamoverview){: new_window} の概要を参照してください。

- ユーザーおよびサービス ID を管理する。
- 使用可能な資格情報を管理する。
- {{site.data.keyword.cloudant_short_notm}} サービス・インスタンスへのアクセスを許可および取り消す IAM アクセス・ポリシーを使用する。

## {{site.data.keyword.cloudant_short_notm}} の従来のアクセス制御と IAM のアクセス制御の違い
{: #differences-between-ibm-cloudant-legacy-and-iam-access-controls}

次のセクションでは、{{site.data.keyword.cloudant_short_notm}} の従来のアクセス制御メカニズムと
{{site.data.keyword.cloud_notm}} IAM のアクセス制御メカニズムの違いについて簡単に説明します。

### {{site.data.keyword.cloud_notm}} Identity and Access Management
{: #ibm-cloud-identity-and-access-management}

- {{site.data.keyword.cloud_notm}} 全体で集中管理されたアクセス管理。
- 同じ一連の資格情報 (例えば、同じユーザー名/パスワードまたは IAM API キー) を使用して、
ユーザーまたはサービスが多種多様なリソースにアクセスするのを許可します。
- 新規データベースの作成など、アカウント管理機能へのアクセスのために、IAM API キーを付与できます。

### 従来の {{site.data.keyword.cloudant_short_notm}}
{: #ibm-cloudant-legacy}

- {{site.data.keyword.cloudant_short_notm}} に固有。
- 各サービス・インスタンスにアクセスする場合、独自の一連の資格情報が必要です。
- 個別のユーザーまたはサービスにバインドされない資格情報による
HTTP 基本認証を使用します。
- データベース・レベルのアクセス権として、{{site.data.keyword.cloudant_short_notm}} API キーのみ付与できます。

### API キーに関する注意事項
{: #api-key-notes}

この資料では、API キーという記述は、すべて IAM API キーを示します。
従来の {{site.data.keyword.cloudant_short_notm}} にも API キーという概念があり、従来の {{site.data.keyword.cloudant_short_notm}} の資格情報またはユーザー名/パスワードの組み合わせの記述にも、すべて {{site.data.keyword.cloudant_short_notm}} API キーが含まれます。 

## {{site.data.keyword.cloudant_short_notm}} を備えた IAM の有効化
{: #enabling-iam-with-ibm-cloudant}

2018 年 7 月下旬から、{{site.data.keyword.cloud_notm}} IAM では、新しい {{site.data.keyword.cloudant_short_notm}} サービス・インスタンスしか使用できなくなりました。

新しい {{site.data.keyword.cloudant_short_notm}} サービス・インスタンスはすべて、プロビジョン時に IAM を使用できるように有効化されます。 オプションで、従来の認証メカニズムも有効にできます。  {{site.data.keyword.cloud_notm}} カタログから新しい {{site.data.keyword.cloudant_short_notm}} インスタンスをプロビジョンする場合、次の使用可能な認証方式のいずれかを選択します。

1. **従来の資格情報と IAM の両方を使用**: このモードは、アカウントにアクセスするために IAM と従来の資格情報の両方を使用できることを意味します。 特に、IAM と従来の一連の資格情報の両方が、生成されたアカウントおよびサービス資格情報にバインドされているすべてのアプリケーションに提供されます。
2. **IAM のみ使用**: このモードは、サービス・バインディングおよび資格情報の生成を通じて
IAM 資格情報のみ提供されることを意味します。

### {{site.data.keyword.cloudant_short_notm}} API キーおよび_IAM のみ使用する_
{: #ibm-cloudant-api-keys-and-_use-only-iam_}

IAM とともに {{site.data.keyword.cloudant_short_notm}} API キーを使用できますが、**推奨されていません**。 {{site.data.keyword.cloudant_short_notm}} API キーおよびアクセス権は、
IAM ポリシー・インターフェースを通じて表示または管理できず、したがって、全体的なアクセス管理も不可能であるため、
このように非推奨となっています。

_IAM のみ使用_ を選択した場合と_従来の資格情報と IAM の両方を使用_ を選択した場合の違い:

1. データベースとその他のアカウント・レベルのアクションを管理するために、従来の {{site.data.keyword.cloudant_short_notm}} のアカウント・レベルの資格情報を使用できるかどうか。
2. サービス資格情報の生成時に送信される資格情報のスタイル。

特に、データベース・アクセスを管理するために、{{site.data.keyword.cloudant_short_notm}} API キーを使用できます。 HTTP API を使用して、これらの資格情報を生成し、
構成する必要があります。

### コマンド行を使用したプロビジョン
{: #provisioning-by-using-the-command-line}

コマンド行から新しい {{site.data.keyword.cloudant_short_notm}} インスタンスをプロビジョンする場合、アカウントの従来の資格情報を有効または無効にする `-p` パラメーターを使用することで、
`ic` ツールに対してオプションを指定します。 このオプションは、
JSON 形式で渡され、`legacyCredentials` という名前です。

_IAM のみ使用_ (推奨) モードでインスタンスをプロビジョンするには、次のコマンドを実行します。

```sh
ic resource service-instance-create  "Instance Name" \
    cloudantnosqldb Standard us-south \
    -p {"legacyCredentials": false}
```

_従来の資格情報と IAM の両方を使用_ モードでインスタンスをプロビジョンするには、次のコマンドを実行します。

```sh
ic resource service-instance-create  "Instance Name" \
    cloudantnosqldb Standard us-south \
    -p {"legacyCredentials": true}
```

### 各オプションのサービス資格情報 JSON の例
{: #service-credential-json-examples-for-each-option}

_IAM のみ使用_ のアクセス制御を選択した場合と_従来の資格情報と IAM の両方を
使用_ のアクセス制御を選択した場合では、サービス資格情報をバインドおよび生成するときの
アプリケーションへの資格情報の送信方法が異なります。 1 次 {{site.data.keyword.cloud_notm}} IAM インターフェース内で資格情報を生成する場合、
生成時にそのインターフェース内に API キーが表示されます。

サービス・インスタンスの「サービス資格情報」セクションから資格情報を
生成することもできます。 この方法でサービス資格情報を生成すると、サービス資格情報の JSON Blob が作成されます。この JSON Blob は、サービス・インスタンスにアクセスするために必要なすべての詳細とともにアプリケーションに貼り付けることができます。

このセクションでは、サービス資格情報の JSON の内容と各値の意味について
説明します。

_IAM のみ使用_ を選択した場合、生成されるサービス資格情報には IAM 値のみ含まれ、
サービス資格情報は次の例のようになります。

```json
{
  "apikey": "MxVp86XHkU82Wc97tdvDF8qM8B0Xdit2RqR1mGfVXPWz",
  "iam_apikey_description": "Auto generated apikey during resource-key [...]",
  "iam_apikey_name": "auto-generated-apikey-050d21b5-5f[...]",
  "iam_role_crn": "crn:v1:bluemix:public:iam::::serviceRole:Manager",
  "iam_serviceid_crn": "crn:v1:staging:public:iam-identity::[...]",
  "url": "https://76838001-b883-444d-90d0-46f89e942a15-bluemix.cloudant.com",
  "username": "76838001-b883-444d-90d0-46f89e942a15-bluemix"
}
```

前の JSON の例の各値は、次のように解釈する必要があります。

- `apikey`: IAM API キー。
- `iam_apikey_description`: IAM API キーの説明。
- `iam_apikey_name`: IAM API キーの ID。
- `iam_role_crn`: IAM API キーが所有する IAM 役割。
- `iam_serviceid_crn`: サービス ID の CRN。
- `url`: {{site.data.keyword.cloudant_short_notm}} サービスの URL。
- `username`: 内部の {{site.data.keyword.cloudant_short_notm}} アカウント名。

_従来の資格情報と IAM の両方を使用_ を選択した場合、生成されるサービス資格情報には IAM と従来の資格情報の両方が含まれ、サービス資格情報は次の例のようになります。

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

前の JSON の例の各値は、次のように解釈する必要があります。

- `apikey`: IAM API キー。
- `host`: {{site.data.keyword.cloudant_short_notm}} サービスのホスト名。
- `iam_apikey_description`: IAM API キーの説明。
- `iam_apikey_name`: IAM API キーの ID。
- `iam_role_crn`: IAM API キーが所有する IAM 役割。
- `iam_serviceid_crn`: サービス ID の CRN。
- `password`: {{site.data.keyword.cloudant_short_notm}} の従来の資格情報のパスワード。
- `port`: {{site.data.keyword.cloudant_short_notm}} サービスのポート。
- `url`: {{site.data.keyword.cloudant_short_notm}} サービスの URL。{{site.data.keyword.cloudant_short_notm}} の従来の資格情報が組み込まれています。
- `username`: {{site.data.keyword.cloudant_short_notm}} の従来の資格情報のユーザー名。

## _IAM のみ使用_ と_従来の資格情報と IAM の両方を使用_ のどちらを使用したらよいですか?
{: #should-i-use-_use-only-iam_-or-_use-both-legacy-credentials-and-iam_-}

可能な場合は、_IAM のみ使用_ を優先してください。 {{site.data.keyword.cloud_notm}} IAM を使用することの主な利点を以下に示します。

- {{site.data.keyword.cloudant_short_notm}} へのアクセスを、{{site.data.keyword.cloud_notm}}と {{site.data.keyword.cloudant_short_notm}} 固有の資格情報を組み合わせて管理するのではなく、
{{site.data.keyword.cloud_notm}} の標準ツールを使用して管理します。
- {{site.data.keyword.cloud_notm}} IAM を使用した場合、資格情報を簡単に取り消すことやローテーションすることができます。

各方法の長所と短所について以下で詳しく説明します。

### 2 つのアクセス制御メカニズムの長所と短所
{: #advantages-and-disadvantages-of-the-two-access-control-mechanisms}

一般的に、認証モデルとして {{site.data.keyword.cloud_notm}} IAM が推奨されています。 ただし、
既存のアプリケーションがある場合、または {{site.data.keyword.cloudant_short_notm}} がサポートしている
クライアント・ライブラリーを使用できない場合、この方法には不利な点があります。

<table>

<tr>
<th id="mode">モード</th>
<th id="advantages">長所</th>
<th id="disadvantages">短所</th>
</tr>

<tr>
<td headers="mode">IAM</td>
<td headers="advantages" valign="top"><ul><li>1 つのインターフェースを使用して多くのサービスへのアクセスを管理できます。 ユーザーのアクセス権をグローバルに取り消すことができます。</li>
<li>サービス ID を介したアカウント・レベルの API キー。</li>
<li>資格情報を簡単にローテーションできます。</li>
<li>アクティビティー・トラッカー・ログにより、個人および個々のサービスがキャプチャーされます。</li>
<li>エンタープライズ LDAP リポジトリーなど、他の ID システムと IAM を統合できます。</li></ul>
</td>
<td headers="disadvantages"><ul><li>{{site.data.keyword.cloudant_short_notm}} のサポートされているライブラリーを使用しない場合、IAM の API キーおよびアクセス・トークンを使用するために、アプリケーションの変更が必要になる場合があります。</li>
<li>データベース・レベルのアクセス権がありません (現時点)。</li>
<li>詳細なアクセス権 (例えば、リーダー) がありません (現時点)。</li>
<li>一部のエンドポイントが使用できません。[使用不可のエンドポイント](#unavailable-endpoints)を参照してください。</li>
<li>「公開」として (つまり、アクセスするユーザーへの許可が不要) データベースを指定する方法がありません。</li></ul>
</td>
</tr>

<tr>
<td headers="mode">従来型</td>
<td headers="advantages">
<ul><li>既存のアプリケーションまたはクライアント・ライブラリーの依存関係を変更する必要がありません。</li>
<li>データベース・レベルのアクセス権。</li>
<li>詳細な役割 (リーダー、ライター)。</li>
</ul>
</td>
<td headers="disadvantages">
<ul><li>アカウント・レベルの API キーがありません。データベースを管理するために、`root` 資格情報を使用する必要があります。</li>
<li>{{site.data.keyword.cloudant_short_notm}} の資格情報を個別に管理します。このため、集中インターフェース内ですべてのアクセスを全体的に確認できません。</li>
<li>資格情報のローテーションを実施するのが困難です。</li>
</ul>
</td>
</tr>
</table>

## IAM 資格情報を使用したインスタンスへの要求の実行
{: #making-requests-to-instances-by-using-iam-credentials}

このセクションでは、IAM 認証およびアクセス制御を使用して、サービス・インスタンスで
{{site.data.keyword.cloudant_short_notm}} を使用する方法について説明します。 前述の
サービス資格情報の JSON の例から詳細を使用します。

{{site.data.keyword.cloud_notm}} IAM では、リソースまたはサービスに対して要求を実行する前に、IAM API キーを時間制限アクセス・トークンに交換する必要があります。 その後、アクセス・トークンは、サービスに対する `Authorization` HTTP ヘッダーに組み込まれます。 アクセス・トークンが期限切れになった場合、取り込んでいるアプリケーションは、IAM トークン・サービスからの新しいアクセス・トークンの取得を処理する必要があります。詳しくは、[API キーを使用した {{site.data.keyword.cloud_notm}} IAM トークンの取得![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://cloud.ibm.com/docs/iam/apikey_iamtoken.html#iamtoken_from_apikey)に関する資料を参照してください。

{{site.data.keyword.cloudant_short_notm}} の公式クライアント・ライブラリーは、API キーからのトークンの取得を処理します。 {{site.data.keyword.cloudant_short_notm}} クライアント・ライブラリーではなく HTTP クライアントを使用して {{site.data.keyword.cloudant_short_notm}} に直接アクセスする場合、IAM API キーと IAM トークン・サービスを使用して、時間制限アクセス・トークンの交換とリフレッシュを処理する必要があります。 トークンが期限切れになると、{{site.data.keyword.cloudant_short_notm}} は HTTP `401` 状況コードを返します。

### 必要なクライアント・ライブラリーのバージョン
{: #required-client-library-versions}

IAM 対応の {{site.data.keyword.cloudant_short_notm}} サービス・インスタンスでは、
最低でも次のクライアント・ライブラリー・バージョンを使用してください。

| ライブラリー | 推奨 |
| --- | --- |
| [java-cloudant](https://github.com/cloudant/java-cloudant) | 2.13.0+ |
| [nodejs-cloudant](https://github.com/cloudant/nodejs-cloudant) | 2.3.0+ |
| [python-cloudant](https://github.com/cloudant/python-cloudant) | 2.9.0+ |
| [couchbackup](https://github.com/cloudant/couchbackup/) | 2.3.1+ |
| [CDTDatastore](https://github.com/cloudant/cdtdatastore/) | 2.0.3+ |
| [sync-android](https://github.com/cloudant/sync-android/) | 2.2.0+ |

以下のコード・スニペットでは、これらのバージョンが必要です。

### Java
{: #java}

[java-cloudant](https://github.com/cloudant/java-cloudant), 2.13.0+ が必要です。

`iamApiKey()` メソッドを使用して、IAM API キーを持つデータベース・クライアントを作成します。

```java
package com.mycompany.app;

import com.cloudant.client.api.ClientBuilder;
import com.cloudant.client.api.CloudantClient;


public class App
{
    public static void main( String[] args )
    {
        CloudantClient client = ClientBuilder
                .account("76838001-b883-444d-90d0-46f89e942a15-bluemix")
                .iamApiKey("MxVp86XHkU82Wc97tdvDF8qM8B0Xdit2RqR1mGfVXPWz")
                .build();

        for (String db : client.getAllDbs()) {
            System.out.println(db);
        }
    }
}
```

### Node.js
{: #node.js}

[nodejs-cloudant](https://github.com/cloudant/nodejs-cloudant), 2.3.0+ が必要です。

`iamauth` プラグインを使用して、IAM API キーを持つデータベース・クライアントを作成します。

```js
var Cloudant = require('@cloudant/cloudant');

var cloudant = new Cloudant({
  account: '76838001-b883-444d-90d0-46f89e942a15-bluemix',
  plugins: {
    iamauth: {
      iamApiKey: 'MxVp86XHkU82Wc97tdvDF8qM8B0Xdit2RqR1mGfVXPWz'
    }
  }
});
cloudant.db.list(function(err, body) {
  body.forEach(function(db) {
    console.log(db);
  });
});
```

### Python
{: #python}

[python-cloudant](https://github.com/cloudant/python-cloudant), 2.9.0+ が必要です。

`Cloudant.iam(account_name, api_key, **kwargs)` メソッドを使用して、
IAM API キーを持つデータベース・クライアントを作成します。

```python
from cloudant.client import Cloudant

client = Cloudant.iam(
    "76838001-b883-444d-90d0-46f89e942a15-bluemix",
    "MxVp86XHkU82Wc97tdvDF8qM8B0Xdit2RqR1mGfVXPWz",
    connect=True
)
print client.all_dbs()
```

### HTTP クライアントを使用したアクセス
{: #access-by-using-http-client}

{{site.data.keyword.cloud_notm}} IAM では、リソースまたはサービスに対して要求を実行する前に、IAM API キーを時間制限アクセス・トークンに交換する必要があります。 その後、アクセス・トークンは、サービスに対する `Authorization` HTTP ヘッダーに組み込まれます。 アクセス・トークンが期限切れになった場合、クライアントは、IAM トークン・サービスからの新しいアクセス・トークンの取得を処理する必要があります。

前述したように、{{site.data.keyword.cloud_notm}} IAM を使用する場合、最初に {{site.data.keyword.IBM_notm}} API キーを時間制限アクセス・トークンに交換し、次にそのトークンを使用して {{site.data.keyword.cloudant_short_notm}} API に対して認証を行う必要があります。

Python では、例は以下のようになります。

```python
import time

import requests

API_KEY = "MxVp86XHkU82Wc97tdvDF8qM8B0Xdit2RqR1mGfVXPWz"
ACCOUNT = "76838001-b883-444d-90d0-46f89e942a15-bluemix"

def get_access_token(api_key):
    """Retrieve an access token from the IAM token service."""
    token_response = requests.post(
        "https://iam.cloud.ibm.com/identity/token",
        data={
            "grant_type": "urn:ibm:params:oauth:grant-type:apikey",
            "response_type": "cloud_iam",
            "apikey": api_key
        },
        headers={
            "Accept": "application/json"
        }
    )
    if token_response.status_code == 200:
        print "Got access token from IAM"
        return token_response.json()['access_token']
    else:
        print token_response.status_code, token_response.json()
        return None

def main(api_key, account):
    access_token = None
    while True:
        if not access_token:
            access_token = get_access_token(api_key)

        if access_token:
            response = requests.get(
                "https://{0}.cloudant.com/_all_dbs".format(account),
                headers={
                    "Accept": "application/json",
                    "Authorization": "Bearer {0}".format(access_token)
                }
            )
            print "Got Cloudant response, status code", response.status_code
            if response.status_code == 401:
                print "Token has expired."
                access_token = None

        time.sleep(1)

if __name__ == "__main__":
    main(API_KEY, ACCOUNT)
```

## リファレンス
{: #reference}

このセクションには、{{site.data.keyword.cloudant_short_notm}} の IAM アクションの全リストと、各 IAM システム役割に許可されているアクションが記載されています。

### {{site.data.keyword.cloudant_short_notm}} のアクション
{: #ibm-cloudant-actions}

アクション | 説明
-------|------------
`cloudant.db.any` | データベース・エンドポイント (パスが `/_api` で始まらないエンドポイント) にアクセスします。
`cloudantnosqldb.sapi.dbsecurity` | `/_api/v2/db/<path:db>/_security` にアクセスします。
`cloudantnosqldb.sapi.usercors` | `/_api/v2/user/config/cors/` にアクセスします。
`cloudantnosqldb.sapi.apikeys` | `/_api/v2/api_keys` にアクセスします。
`cloudantnosqldb.sapi.userinfo` | `/_api/v2/user` にアクセスします。

#### 使用不可のエンドポイント
{: #unavailable-endpoints}

次のエンドポイントは、IAM で許可される要求には使用できません。

- HTTP 再書き込みハンドラー: `/db/_design/design-doc/_rewrite/path`。 <br>
設計文書に再書き込みハンドラーを含めることはできますが、ユーザーがそれらのハンドラーを呼び出すことはできません。
- 更新ハンドラー: `POST /{db}/_design/{ddoc}/_update/{func}`。 <br>
設計文書に更新関数を含めることはできますが、ユーザーがそれらを呼び出すことはできません。

### {{site.data.keyword.cloudant_short_notm}} アクションと IAM 役割のマッピング
{: #mapping-of-ibm-cloudant-actions-to-iam-roles}

管理者役割のユーザーとサービスのみ {{site.data.keyword.cloudant_short_notm}} データにアクセスできます。

役割 | 許可されるアクション
-----|----------------
管理者 | 記載されているすべてのアクション。
リーダー | なし。
ライター | なし。

## トラブルシューティング
{: #troubleshooting}
{{site.data.keyword.cloudant_short_notm}} サービス・インスタンスに対して要求を行うときの IAM を使用した認証で問題がある場合は、次のセクションに示されるアカウントを確認してください。

### アカウントが IAM 対応であるか確認する
{: #ensure-your-account-is-iam-enabled}

サービス・インスタンスが IAM 対応であるか確認するためには、サポート・チケットをオープンする必要があります。
