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

<!-- Acrolinx: 2018-07-02 -->

# {{site.data.keyword.cloud_notm}} Identity and Access Management (IAM)

{{site.data.keyword.cloud}} Identity and Access Management 提供一種統一的方法來管理使用者身分、服務及存取控制。
{:shortdesc}

## 簡介

本文件說明 {{site.data.keyword.cloudantfull}} 與 {{site.data.keyword.cloud_notm}} Identity and Access Management 的整合。它會討論 {{site.data.keyword.cloudant_short_notm}} Legacy 存取控制與 {{site.data.keyword.cloud_notm}} IAM 存取控制之間的差異。接著，它會查看各個的優缺點，協助您決定使用哪一個。然後，我們會討論如何在 {{site.data.keyword.cloudant_short_notm}} 的用戶端程式庫內以及透過 HTTP 呼叫來使用 IAM。最後，我們以參照小節作為結尾，其中說明 {{site.data.keyword.cloudant_short_notm}} 內所有可用的 IAM 動作及角色。

請參閱 [IAM ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://console.bluemix.net/docs/iam/index.html#iamoverview){:new_window} 概觀，包括如何：

- 管理使用者及服務 ID。
- 管理可用的認證。
- 使用容許及撤銷對 {{site.data.keyword.cloudant_short_notm}} 服務實例之存取權的 IAM 存取原則。

## {{site.data.keyword.cloudant_short_notm}} Legacy 與 IAM 存取控制之間的差異

下節提供 {{site.data.keyword.cloudant_short_notm}} Legacy 與 {{site.data.keyword.cloud_notm}} IAM 存取控制機制之間差異的簡要概觀。

### {{site.data.keyword.cloud_notm}} Identity and Access Management

- 跨 {{site.data.keyword.cloud_notm}} 的集中管理存取管理。
- 容許使用者或服務使用同一組認證（例如，相同的使用者名稱/密碼或 IAM API 金鑰）來存取許多不同的資源。
- 您可以將帳戶管理功能（例如，建立新的資料庫）的存取權授與給 IAM API 金鑰。

### {{site.data.keyword.cloudant_short_notm}} Legacy

- 對 {{site.data.keyword.cloudant_short_notm}} 而言是唯一的。
- 每個服務實例的存取權都需要它自己的一組認證。
- 搭配使用 HTTP 基本鑑別與未連結至個別使用者或服務的認證。
- {{site.data.keyword.cloudant_short_notm}} API 金鑰只能獲授與資料庫層次的許可權。

### API 金鑰注意事項

在本文件中，只要提及 API 金鑰，指的就是 IAM API 金鑰。
{{site.data.keyword.cloudant_short_notm}} Legacy 也有 API 金鑰的概念，而所有關於 {{site.data.keyword.cloudant_short_notm}} Legacy 認證或使用者名稱/密碼組合的討論也包含 {{site.data.keyword.cloudant_short_notm}} API 金鑰在內。

## 使用 {{site.data.keyword.cloudant_short_notm}} 啟用 IAM

從 2018 年 7 月下旬開始，只有新的 {{site.data.keyword.cloudant_short_notm}} 服務實例才能與 {{site.data.keyword.cloud_notm}} IAM 搭配使用。

所有新的 {{site.data.keyword.cloudant_short_notm}} 服務實例都已啟用，在佈建時可使用 IAM。您也可以選擇啟用舊式鑑別機制。當您從 {{site.data.keyword.cloud_notm}} 型錄佈建新的 {{site.data.keyword.cloudant_short_notm}} 實例時，請從可用的鑑別方法進行選擇：

1. **同時使用 Legacy 認證及 IAM**：此模式表示 IAM 及 Legacy 認證都可以用來存取帳戶。具體而言，IAM 及 Legacy 認證組都會提供給連結至帳戶及所產生服務認證的所有應用程式。
2. **僅使用 IAM**：此模式表示僅透過服務連結及認證產生來提供 IAM 認證。

### {{site.data.keyword.cloudant_short_notm}} API 金鑰及_僅使用 IAM_

您可以使用 {{site.data.keyword.cloudant_short_notm}} API 金鑰與 IAM，但**不建議如此使用**。提出此建議的原因是 {{site.data.keyword.cloudant_short_notm}} API 金鑰及許可權無法透過 IAM 原則介面顯示或管理，因此使得無法進行全面的存取管理。

選擇_僅使用 IAM_ 或_同時使用 Legacy 認證及 IAM_ 會影響：

1. 舊式 {{site.data.keyword.cloudant_short_notm}} 帳戶層次認證是否可用來管理資料庫及其他帳戶層次動作。
2. 在產生服務認證期間提供的認證樣式。

具體而言，仍然可以使用 {{site.data.keyword.cloudant_short_notm}} API 金鑰來管理資料庫存取。必須使用 HTTP API 來產生及配置這些認證。

### 使用指令行佈建

當您從指令行佈建新的 {{site.data.keyword.cloudant_short_notm}} 實例時，請提供 `ic` 工具的選項，方法是使用 `-p` 參數來啟用或停用帳戶的舊式認證。選項會以 JSON 格式傳遞，稱為 `legacyCredentials`。

若要將實例佈建為_僅使用 IAM_（建議），請執行下列指令：

```
ic resource service-instance-create  "Instance Name" \
    cloudantnosqldb Standard us-south \
    -p {"legacyCredentials": false}
```

若要將實例佈建為_同時使用 Legacy 認證及 IAM_，請執行下列指令：

```
ic resource service-instance-create  "Instance Name" \
    cloudantnosqldb Standard us-south \
    -p {"legacyCredentials": true}
```

### 每個選項的服務認證 JSON 範例

選擇_僅使用 IAM_ 或_同時使用 Legacy 認證及 IAM_ 存取控制會影響在連結及產生服務認證時，如何將認證提供給應用程式。在主要 {{site.data.keyword.cloud_notm}} IAM 介面內產生認證時，該介面中會顯示產生的 API 金鑰。

您也可以從服務實例的「服務認證」區段產生認證。透過此方式產生服務認證，會使用存取服務實例所需的所有詳細資料，來建立可貼入應用程式的服務認證 JSON Blob。

本節顯示服務認證 JSON 的樣子及每個值的意義。

當您選取_僅使用 IAM_ 時，產生的服務認證只會包含 IAM 值，並且與下列範例類似：

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

前一個 JSON 範例中的每個值應該解譯如下：

- `apikey`：IAM API 金鑰。
- `iam_apikey_description`：IAM API 金鑰的說明。
- `iam_apikey_name`：IAM API 金鑰的 ID。
- `iam_role_crn`：IAM API 金鑰具有的 IAM 角色。
- `iam_serviceid_crn`：服務 ID 的 CRN。
- `url`：{{site.data.keyword.cloudant_short_notm}} 服務 URL。
- `username`：URL 中 {{site.data.keyword.cloudant_short_notm}} 實例使用者的服務名稱。

當您選取_同時使用 Legacy 認證及 IAM_ 時，產生的服務認證會同時包含 IAM 及 Legacy 認證，並且與下列範例類似：

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
{:codeblock}

前一個 JSON 範例中的每個值應該解譯如下：

- `apikey`：IAM API 金鑰。
- `host`：{{site.data.keyword.cloudant_short_notm}} 服務主機名稱。
- `iam_apikey_description`：IAM API 金鑰的說明。
- `iam_apikey_name`：IAM API 金鑰的 ID。
- `iam_role_crn`：IAM API 金鑰具有的 IAM 角色。
- `iam_serviceid_crn`：服務 ID 的 CRN。
- `password`：{{site.data.keyword.cloudant_short_notm}} Legacy 認證密碼。
- `port`：{{site.data.keyword.cloudant_short_notm}} 服務埠。
- `url`：{{site.data.keyword.cloudant_short_notm}} 服務 URL（包含內嵌的 {{site.data.keyword.cloudant_short_notm}} Legacy 認證）。
- `username`：{{site.data.keyword.cloudant_short_notm}} Legacy 認證使用者名稱。

## 我應該使用_僅使用 IAM_ 還是_同時使用 Legacy 認證及 IAM_？

如果可能的話，建議選擇_僅使用 IAM_。使用 {{site.data.keyword.cloud_notm}} IAM 的主要優點包括：

- 使用 {{site.data.keyword.cloud_notm}} 的標準工具來管理對 {{site.data.keyword.cloudant_short_notm}} 的存取權，而不是使用 {{site.data.keyword.cloud_notm}} 與 {{site.data.keyword.cloudant_short_notm}} 特定認證管理的組合。
- 當您使用 {{site.data.keyword.cloud_notm}} IAM 時，可以輕鬆地撤銷及輪替認證。

每種方法的優缺點進一步說明如下。

### 兩種存取控制機制的優缺點

整體而言，{{site.data.keyword.cloud_notm}} IAM 是建議的鑑別模型。不過，此方法有其缺點，主要是，如果您具有現有的應用程式，或無法使用 {{site.data.keyword.cloudant_short_notm}} 支援之用戶端程式庫的情況。


<div id="advantages-disadvantages"></div>

<table>

<tr>
<th id="mode">模式</th>
<th id="advantages">優點</th>
<th id="disadvantages">缺點</th>
</tr>

<tr>
<td headers="mode">IAM</td>
<td headers="advantages" valign="top"><ul><li>使用一個介面，來管理許多服務的存取權。整體地撤銷使用者存取權。<li>透過服務 ID 的帳戶層次 API 金鑰。
<li>容易輪替的認證。</li>
<li>Activity Tracker 日誌會擷取個人及服務。</li>
<li>IAM 會與其他身分系統（例如企業 LDAP 儲存庫）聯合。</li></ul>
</td>
<td headers="disadvantages"><ul><li>如果您未使用 {{site.data.keyword.cloudant_short_notm}} 支援的程式庫，則可能需要變更應用程式，才能使用 IAM 的 API 金鑰及存取記號。
<li>（目前）沒有資料庫層次許可權。</li>
<li>（目前）沒有精細許可權（例如，讀者）。</li>
<li>部分端點無法使用，請參閱[無法使用的端點](#unavailable-endpoints)。</li>
<li>沒有辦法可將資料庫指定為「公用」，亦即，不需要授權使用者即可存取。</li></ul>
</td>
</tr>

<tr>
<td headers="mode">Legacy</td>
<td headers="advantages">
<ul><li>不需要變更現有應用程式或用戶端程式庫相依關係。</li>
<li>資料庫層次許可權。</li>
<li>精細的角色（讀者、撰寫者）。</li>
</ul>
</td>
<td headers="disadvantages">
<ul><li>沒有帳戶層次 API 金鑰；必須使用 `root` 認證才能管理資料庫。<li>分別管理 {{site.data.keyword.cloudant_short_notm}} 認證，因此無法在集中化介面內取得所有存取權的完整概觀。</li>
<li>難以實作認證輪替。</li>
</ul>
</td>
</tr>
</table>

## 使用 IAM 認證向實例提出要求

本節討論如何使用 IAM 鑑別和存取控制，來搭配使用 {{site.data.keyword.cloudant_short_notm}} 與服務實例。它會使用先前提及之服務認證 JSON 範例的詳細資料。

{{site.data.keyword.cloud_notm}} IAM 要求先將 IAM API 金鑰換成限時存取記號，再提出資源或服務的要求。然後，存取記號會內含在服務的 `Authorization` HTTP 標頭中。存取記號到期時，用戶端必須處理從 IAM 記號服務取得新的存取記號。如需相關資訊，請參閱[使用 API 金鑰取得 {{site.data.keyword.cloud_notm}} IAM 記號 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://console.bluemix.net/docs/iam/apikey_iamtoken.html#iamtoken_from_apikey) 文件，以取得更多詳細資料。

{{site.data.keyword.cloudant_short_notm}} 的正式用戶端程式庫會處理為您從 API 金鑰取得記號。如果您使用 HTTP 用戶端直接存取 {{site.data.keyword.cloudant_short_notm}}，而不是使用 {{site.data.keyword.cloudant_short_notm}} 用戶端程式庫，則必須搭配使用 IAM API 金鑰與 IAM 記號服務來處理交換及重新整理限時存取記號。記號到期之後，{{site.data.keyword.cloudant_short_notm}} 會傳回 HTTP `401` 狀態碼。

### 必要的用戶端程式庫版本

針對已啟用 IAM 的 {{site.data.keyword.cloudant_short_notm}} 服務實例，請最少搭配使用下列用戶端程式庫版本：

| 程式庫 | 建議 |
| --- | --- |
| [java-cloudant](https://github.com/cloudant/java-cloudant) | 2.13.0+ |
| [nodejs-cloudant](https://github.com/cloudant/nodejs-cloudant) | 2.3.0+ |
| [python-cloudant](https://github.com/cloudant/python-cloudant) | 2.9.0+ |
| [couchbackup](https://github.com/cloudant/couchbackup/) | 2.3.1+ |
| [CDTDatastore](https://github.com/cloudant/cdtdatastore/) | 2.0.3+ |
| [sync-android](https://github.com/cloudant/sync-android/) | 2.2.0+ |

下列程式碼 Snippet 需要這些版本。

### Java

需要 [java-cloudant](https://github.com/cloudant/java-cloudant) 2.13.0+。

使用 `iamApiKey()` 方法，以使用 IAM API 金鑰建立資料庫用戶端：

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

需要 [nodejs-cloudant](https://github.com/cloudant/nodejs-cloudant) 2.3.0+。

使用 `iamauth` 外掛程式，以使用 IAM API 金鑰建立資料庫用戶端：

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

需要 [python-cloudant](https://github.com/cloudant/python-cloudant) 2.9.0+。

使用 `Cloudant.iam(account_name, api_key, **kwargs)` 方法，以使用 IAM API 金鑰建立資料庫用戶端：

```python
from cloudant.client import Cloudant

client = Cloudant.iam(
    "76838001-b883-444d-90d0-46f89e942a15-bluemix",
    "MxVp86XHkU82Wc97tdvDF8qM8B0Xdit2RqR1mGfVXPWz",
    connect=True
)
print client.all_dbs()
```

### 使用 HTTP 用戶端存取

{{site.data.keyword.cloud_notm}} IAM 要求先將 IAM API 金鑰換成限時存取記號，再提出資源或服務的要求。然後，存取記號會內含在服務的 `Authorization` HTTP 標頭中。存取記號到期時，用戶端必須處理從 IAM 記號服務取得新的存取記號。

如前所述，使用 {{site.data.keyword.cloud_notm}} IAM 時，需要您先將 {{site.data.keyword.IBM_notm}} API 金鑰換成限時存取記號，然後使用該記號針對 {{site.data.keyword.cloudant_short_notm}} API 進行鑑別。

在 Python 中，範例看起來可能像這樣：

```python
import time

import requests

API_KEY = "MxVp86XHkU82Wc97tdvDF8qM8B0Xdit2RqR1mGfVXPWz"
ACCOUNT = "76838001-b883-444d-90d0-46f89e942a15-bluemix"

def get_access_token(api_key):
    """Retrieve an access token from the IAM token service."""
    token_response = requests.post(
        "https://iam.bluemix.net/oidc/token",
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

## 參考資料

本節包含完整的 {{site.data.keyword.cloudant_short_notm}} IAM 動作清單，以及每個 IAM 系統角色所容許的動作。

### {{site.data.keyword.cloudant_short_notm}} 動作

動作 | 說明
-------|------------
`cloudant.db.any` | 存取任何資料庫端點（其路徑開頭不是 `/_api` 的資料庫端點）。
`cloudantnosqldb.sapi.dbsecurity` | 存取 `/_api/v2/db/<path:db>/_security`。
`cloudantnosqldb.sapi.usercors` | 存取 `/_api/v2/user/config/cors/`。
`cloudantnosqldb.sapi.apikeys` | 存取 `/_api/v2/api_keys`。
`cloudantnosqldb.sapi.userinfo` | 存取 `/_api/v2/user`。

#### 無法使用的端點

下列端點無法用於使用 IAM 授權的要求：

- HTTP 重新編寫處理程式：`/db/_design/design-doc/_rewrite/path`。<br>
雖然設計文件可以包含重新編寫處理程式，但是使用者無法呼叫它們。
- 更新處理程式：`POST /{db}/_design/{ddoc}/_update/{func}`。<br>
雖然設計文件可以包含更新功能，但是使用者無法呼叫它們。

### 將 {{site.data.keyword.cloudant_short_notm}} 動作對映至 IAM 角色

只有「管理員」角色使用者及服務才能存取 {{site.data.keyword.cloudant_short_notm}} 資料。

角色 | 容許的動作
-----|----------------
管理員 | 所有記載的動作。
讀者 | 無。
撰寫者 | 無。

## 疑難排解

如果您在向 {{site.data.keyword.cloudant_short_notm}} 服務實例提出要求時，使用 IAM 進行鑑別發生問題，請檢查下列項目。

### 確定帳戶已啟用 IAM

您必須發出支援問題單，確認服務實例已啟用 IAM。
