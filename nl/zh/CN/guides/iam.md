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

{{site.data.keyword.cloud}} Identity and Access Management 提供了统一的方法来管理用户身份、服务和访问控制。
{: shortdesc}

## 简介
{: #introduction}

本文档描述了 {{site.data.keyword.cloudantfull}} 与 {{site.data.keyword.cloud_notm}} Identity and Access Management 的集成。文档中讨论了 {{site.data.keyword.cloudant_short_notm}} 的旧访问控制和 {{site.data.keyword.cloud_notm}} IAM 访问控制之间的差异。随后，探讨了两种访问控制的优缺点，以帮助您决定要使用哪种访问控制。接着，讨论了如何在 {{site.data.keyword.cloudant_short_notm}} 的客户机库内以及通过 HTTP 调用来使用 IAM。最后以参考部分结尾，此部分描述了 {{site.data.keyword.cloudant_short_notm}} 中提供的所有 IAM 操作和角色。

请参阅 [IAM ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://cloud.ibm.com/docs/iam/index.html#iamoverview){: new_window} 概述，其中包含以下操作的指南：

- 管理用户和服务标识。
- 管理可用的凭证。
- 使用 IAM 访问策略来允许和撤销对 {{site.data.keyword.cloudant_short_notm}} 服务实例的访问权。

## {{site.data.keyword.cloudant_short_notm}} 旧访问控制与 IAM 访问控制之间的差异
{: #differences-between-ibm-cloudant-legacy-and-iam-access-controls}

以下部分简要概述了 {{site.data.keyword.cloudant_short_notm}} 旧访问控制机制与 {{site.data.keyword.cloud_notm}} IAM 访问控制机制之间的差异。

### {{site.data.keyword.cloud_notm}} Identity and Access Management
{: #ibm-cloud-identity-and-access-management}

- 跨 {{site.data.keyword.cloud_notm}} 集中管理访问管理。
- 允许用户或服务使用同一组凭证（例如，相同的用户名/密码或 IAM API 密钥）来访问许多不同的资源。
- 可以授予 IAM API 密钥对帐户管理功能（例如，创建新数据库）的访问权。

### {{site.data.keyword.cloudant_short_notm}} 旧访问控制
{: #ibm-cloudant-legacy}

- 对 {{site.data.keyword.cloudant_short_notm}} 唯一。
- 对每个服务实例的访问都需要该服务自己的一组凭证。
- 将 HTTP 基本认证与未绑定到单个用户或服务的凭证配合使用。
- 只能在数据库级别向 {{site.data.keyword.cloudant_short_notm}} API 密钥授予许可权。

### API 密钥说明
{: #api-key-notes}

在本文档中，凡是提到 API 密钥的地方，都是指 IAM API 密钥。{{site.data.keyword.cloudant_short_notm}} 旧访问控制也有 API 密钥的概念，并且关于 {{site.data.keyword.cloudant_short_notm}} 旧访问控制的凭证或用户名/密码组合的任何讨论也包含 {{site.data.keyword.cloudant_short_notm}} API 密钥。 

## 启用 {{site.data.keyword.cloudant_short_notm}} 的 IAM
{: #enabling-iam-with-ibm-cloudant}

从 2018 年 7 月底开始，只有新的 {{site.data.keyword.cloudant_short_notm}} 服务实例可以与 {{site.data.keyword.cloud_notm}} IAM 配合使用。

供应时，所有新的 {{site.data.keyword.cloudant_short_notm}} 服务实例都将启用 IAM。（可选）您还可以启用旧认证机制。通过 {{site.data.keyword.cloud_notm}}“目录”供应新的 {{site.data.keyword.cloudant_short_notm}} 实例时，请从可用的认证方法中进行选择：

1. **同时使用旧凭证和 IAM**：此方式意味着可以同时使用 IAM 和旧凭证来访问帐户。尤其是，对于绑定到帐户的所有应用程序和生成的服务凭证，会同时提供 IAM 和旧凭证集。
2. **仅使用 IAM**：此方式意味着仅通过服务绑定和凭证生成来提供 IAM 凭证。

### {{site.data.keyword.cloudant_short_notm}} API 密钥和_仅使用 IAM_
{: #ibm-cloudant-api-keys-and-_use-only-iam_}

可以将 {{site.data.keyword.cloudant_short_notm}} API 密钥与 IAM 一起使用，但**建议不要这样做**。做出此建议是因为 {{site.data.keyword.cloudant_short_notm}} API 密钥和许可权不可见，或者不可通过 IAM 策略接口进行管理，因此无法实现整体访问管理。

是选择_仅使用 IAM_ 还是选择_同时使用旧凭证和 IAM_，会影响以下方面：

1. 旧 {{site.data.keyword.cloudant_short_notm}} 帐户级凭证是否可用于管理数据库和其他帐户级别的操作。
2. 在服务凭证生成期间传递的凭证的样式。

尤其是，{{site.data.keyword.cloudant_short_notm}} API 密钥仍可用于管理数据库访问。必须使用 HTTP API 来生成和配置这些凭证。

### 使用命令行进行供应
{: #provisioning-by-using-the-command-line}

通过命令行供应新的 {{site.data.keyword.cloudant_short_notm}} 实例时，请使用 `-p` 参数为 `ic` 工具提供一个选项，用于启用或禁用帐户的旧凭证。该选项以 JSON 格式传递，名为 `legacyCredentials`。

要以_仅使用 IAM_（建议）方式供应实例，请运行以下命令：

```sh
ic resource service-instance-create  "Instance Name" \
    cloudantnosqldb Standard us-south \
    -p {"legacyCredentials": false}
```

要以_同时使用旧凭证和 IAM_ 方式供应实例，请运行以下命令：

```sh
ic resource service-instance-create  "Instance Name" \
    cloudantnosqldb Standard us-south \
    -p {"legacyCredentials": true}
```

### 每个选项的服务凭证 JSON 示例
{: #service-credential-json-examples-for-each-option}

是选择_仅使用 IAM_ 还是选择_同时使用旧凭证和 IAM_ 访问控制，会影响绑定和生成服务凭证时如何将凭证传递到应用程序。在主 {{site.data.keyword.cloud_notm}} IAM 界面中生成凭证时，生成的 API 密钥会显示在该界面中。

您还可以通过服务实例的“服务凭证”部分生成凭证。通过此方法生成服务凭证将创建服务凭证 JSON BLOB，此 BLOB 可以连同访问服务所需的所有详细信息一起粘贴到应用程序中。

此部分说明了服务凭证 JSON 的内容以及每个值的含义。

选择_仅使用 IAM_ 时，生成的服务凭证仅包含 IAM 值，类似于以下示例：

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

上面 JSON 示例中的每个值应按如下所示进行解释：

- `apikey`：IAM API 密钥。
- `iam_apikey_description`：IAM API 密钥的描述。
- `iam_apikey_name`：IAM API 密钥的标识。
- `iam_role_crn`：IAM API 密钥具有的 IAM 角色。
- `iam_serviceid_crn`：服务标识的 CRN。
- `url`：{{site.data.keyword.cloudant_short_notm}} 服务 URL。
- `username`：内部 {{site.data.keyword.cloudant_short_notm}} 帐户名称。

选择_同时使用旧凭证和 IAM_ 时，生成的服务凭证同时包含 IAM 和旧凭证，类似于以下示例：

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

上面 JSON 示例中的每个值应按如下所示进行解释：

- `apikey`：IAM API 密钥。
- `host`：{{site.data.keyword.cloudant_short_notm}} 服务主机名。
- `iam_apikey_description`：IAM API 密钥的描述。
- `iam_apikey_name`：IAM API 密钥的标识。
- `iam_role_crn`：IAM API 密钥具有的 IAM 角色。
- `iam_serviceid_crn`：服务标识的 CRN。
- `password`：{{site.data.keyword.cloudant_short_notm}} 旧凭证密码。
- `port`：{{site.data.keyword.cloudant_short_notm}} 服务端口。
- `url`：{{site.data.keyword.cloudant_short_notm}} 服务 URL，包含嵌入的 {{site.data.keyword.cloudant_short_notm}} 旧凭证。
- `username`：{{site.data.keyword.cloudant_short_notm}} 旧凭证用户名。

## 应该使用_仅使用 IAM_ 还是_同时使用旧凭证和 IAM_？
{: #should-i-use-_use-only-iam_-or-_use-both-legacy-credentials-and-iam_-}

如果可能，请首选_仅使用 IAM_。使用 {{site.data.keyword.cloud_notm}} IAM 的主要优点包括：

- 使用 {{site.data.keyword.cloud_notm}} 的标准工具（而不是特定于 {{site.data.keyword.cloud_notm}} 和 {{site.data.keyword.cloudant_short_notm}} 的凭证管理的组合）管理对 {{site.data.keyword.cloudant_short_notm}} 的访问。
- 使用 {{site.data.keyword.cloud_notm}} IAM 时，可以轻松撤销和轮换凭证。

下面进一步描述了每种方法的优缺点。

### 两种访问控制机制的优缺点
{: #advantages-and-disadvantages-of-the-two-access-control-mechanisms}

总体而言，{{site.data.keyword.cloud_notm}} IAM 是建议的认证模型。但是，该方法也存在一些缺点，主要是在您有现有应用程序或无法使用 {{site.data.keyword.cloudant_short_notm}} 支持的客户机库的情况下。

<table>

<tr>
<th id="mode">方式</th>
<th id="advantages">优点</th>
<th id="disadvantages">缺点</th>
</tr>

<tr>
<td headers="mode">IAM</td>
<td headers="advantages" valign="top"><ul><li>使用一个接口管理多个服务的访问权。全局撤销用户访问权。</li>
<li>通过服务标识使用帐户级别的 API 密钥。</li>
<li>易于轮换的凭证。</li>
<li>Activity Tracker 日志会捕获个人和服务。</li>
<li>IAM 可与其他身份系统（例如，企业 LDAP 存储库）联合。</li></ul>
</td>
<td headers="disadvantages"><ul><li>如果使用的不是 {{site.data.keyword.cloudant_short_notm}} 支持的库，那么可能需要更改应用程序才能使用 IAM 的 API 密钥和访问令牌。</li>
<li>无数据库级别许可权（尚未提供）。</li>
<li>无细颗粒度许可权（例如，读取者）（尚未提供）。</li>
<li>某些端点不可用，请参阅[不可用端点](#unavailable-endpoints)。</li>
<li>无法将数据库指定为“public”，即，不要求授权用户进行访问。</li></ul>
</td>
</tr>

<tr>
<td headers="mode">旧机制</td>
<td headers="advantages">
<ul><li>无需更改现有应用程序或客户机库依赖性。</li>
<li>数据库级别许可权。</li>
<li>细颗粒度角色（读取者、写入者）。</li>
</ul>
</td>
<td headers="disadvantages">
<ul><li>没有帐户级别 API 密钥；必须使用 `root` 凭证来管理数据库。</li>
<li>单独管理 {{site.data.keyword.cloudant_short_notm}} 凭证，因此无法在集中界面中获取所有访问权的完整概览。</li>
<li>难以实现凭证轮换。</li>
</ul>
</td>
</tr>
</table>

## 使用 IAM 凭证对实例发出请求
{: #making-requests-to-instances-by-using-iam-credentials}

此部分讨论了如何通过 IAM 认证和访问控制将 {{site.data.keyword.cloudant_short_notm}} 与服务实例配合使用。这将使用先前提到的服务凭证 JSON 示例中的详细信息。

在对资源或服务发出请求之前，{{site.data.keyword.cloud_notm}} IAM 需要用 IAM API 密钥交换有时间限制的访问令牌。然后，该访问令牌会包含在服务的 `Authorization` HTTP 头中。访问令牌到期后，使用应用程序必须负责从 IAM 令牌服务获取新的令牌。有关更多信息，请参阅[使用 API 密钥获取 {{site.data.keyword.cloud_notm}} IAM 令牌 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://cloud.ibm.com/docs/iam/apikey_iamtoken.html#iamtoken_from_apikey) 文档以获取更多详细信息。

{{site.data.keyword.cloudant_short_notm}} 的官方客户机库负责为您从 API 密钥中获取令牌。如果是使用 HTTP 客户机而不是 {{site.data.keyword.cloudant_short_notm}} 客户机库来直接访问 {{site.data.keyword.cloudant_short_notm}}，那么您必须负责通过将 IAM API 密钥用于 IAM 令牌服务，以交换和刷新有时间限制的访问令牌。令牌到期后，{{site.data.keyword.cloudant_short_notm}} 将返回 HTTP `401` 状态码。

### 必需的客户机库版本
{: #required-client-library-versions}

至少将以下客户机库版本与启用 IAM 的 {{site.data.keyword.cloudant_short_notm}} 服务实例配合使用：

|库|建议|
| --- | --- |
|[java-cloudant](https://github.com/cloudant/java-cloudant)|2.13.0+|
|[nodejs-cloudant](https://github.com/cloudant/nodejs-cloudant)|2.3.0+|
|[python-cloudant](https://github.com/cloudant/python-cloudant)|2.9.0+|
|[couchbackup](https://github.com/cloudant/couchbackup/)|2.3.1+|
|[CDTDatastore](https://github.com/cloudant/cdtdatastore/)|2.0.3+|
|[sync-android](https://github.com/cloudant/sync-android/)|2.2.0+|

以下代码片段需要这些版本。

### Java
{: #java}

需要 [java-cloudant](https://github.com/cloudant/java-cloudant) 2.13.0+。

使用 `iamApiKey()` 方法来创建使用 IAM API 密钥的数据库客户机：

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

需要 [nodejs-cloudant](https://github.com/cloudant/nodejs-cloudant) 2.3.0+。

使用 `iamauth()` 插件来创建使用 IAM API 密钥的数据库客户机：

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

需要 [python-cloudant](https://github.com/cloudant/python-cloudant) 2.9.0+。

使用 `Cloudant.iam(account_name, api_key, **kwargs)` 方法来创建使用 IAM API 密钥的数据库客户机：

```python
from cloudant.client import Cloudant

client = Cloudant.iam(
    "76838001-b883-444d-90d0-46f89e942a15-bluemix",
    "MxVp86XHkU82Wc97tdvDF8qM8B0Xdit2RqR1mGfVXPWz",
    connect=True
)
print client.all_dbs()
```

### 使用 HTTP 客户机进行访问
{: #access-by-using-http-client}

在对资源或服务发出请求之前，{{site.data.keyword.cloud_notm}} IAM 需要用 IAM API 密钥交换有时间限制的访问令牌。然后，该访问令牌会包含在服务的 `Authorization` HTTP 头中。访问令牌到期后，客户机必须负责从 IAM 令牌服务获取新的令牌。

如前所述，使用 {{site.data.keyword.cloud_notm}} IAM 需要您首先用 {{site.data.keyword.IBM_notm}} API 密钥交换有时间限制的访问令牌，然后使用该令牌向 {{site.data.keyword.cloudant_short_notm}} API 进行认证。

在 Python 中，示例可能类似于以下内容：

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

## 参考
{: #reference}

此部分包含 {{site.data.keyword.cloudant_short_notm}} IAM 操作的完整列表以及允许每个 IAM 系统角色执行的操作。

### {{site.data.keyword.cloudant_short_notm}} 操作
{: #ibm-cloudant-actions}

操作|描述
-------|------------
`cloudant.db.any`|访问任何数据库端点（路径不以 `/_api` 开头的数据库端点）。
`cloudantnosqldb.sapi.dbsecurity`|访问 `/_api/v2/db/<path:db>/_security`。
`cloudantnosqldb.sapi.usercors`|访问 `/_api/v2/user/config/cors/`。
`cloudantnosqldb.sapi.apikeys`|访问 `/_api/v2/api_keys`。
`cloudantnosqldb.sapi.userinfo`|访问 `/_api/v2/user`。

#### 不可用端点
{: #unavailable-endpoints}

以下端点不可用于通过 IAM 授权的请求：

- HTTP 重写处理程序：`/db/_design/design-doc/_rewrite/path`。<br>
虽然设计文档可以包含重写处理程序，但用户无法对其进行调用。
- 更新处理程序：`POST /{db}/_design/{ddoc}/_update/{func}`。<br>
虽然设计文档可以包含更新函数，但用户无法对其进行调用。

### {{site.data.keyword.cloudant_short_notm}} 操作到 IAM 角色的映射
{: #mapping-of-ibm-cloudant-actions-to-iam-roles}

只有“管理者”角色的用户和服务才能访问 {{site.data.keyword.cloudant_short_notm}} 数据。

角色|允许执行的操作
-----|----------------
管理者|所有记录的操作。
读取者|无。
写入者|无。

## 故障诊断
{: #troubleshooting}
如果向 {{site.data.keyword.cloudant_short_notm}} 服务实例发出请求时使用 IAM 进行认证遇到问题，请验证您的帐户，如下一部分所示。

### 确保您的帐户启用了 IAM
{: #ensure-your-account-is-iam-enabled}

您必须开具支持凭单以确认服务实例启用了 IAM。
