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

# 连接
{: #connecting}

{{site.data.keyword.cloudantfull}} 通过 HTTP API 进行访问。本文档描述您用于连接 {{site.data.keyword.cloudant_short_notm}} 的不同部分：
- 端点
- 服务凭证
- 认证
- 访问 {{site.data.keyword.cloudant_short_notm}} 仪表板
- 以编程方式通过 [curl ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://curl.haxx.se/){: new_window} 或客户机库访问 {{site.data.keyword.cloudant_short_notm}}
{: shortdesc}

## 端点
{: #endpoints}

通过 HTTP API 端点访问 {{site.data.keyword.cloudant_short_notm}}。实例的端点同时显示在为实例生成的服务凭证的 URL 字段中，以及 {{site.data.keyword.cloudant_short_notm}} 仪表板的**帐户** > **设置**选项卡中。

所有 {{site.data.keyword.cloudant_short_notm}} HTTP 端点必须通过 TLS 访问，所以前面必须加 `https://`。

面向公众的外部端点为：

`https://USERNAME.cloudant.com`

2019 年 1 月 1 日之后供应的所有实例包括 appdomain.cloud 域端点。面向公众的外部端点为：

`https://USERNAME.cloudantnosqldb.appdomain.cloud`

在 EU 管理的环境外部，内部端点将添加到 2019 年 1 月 1 日之后供应的专用硬件环境上部署的所有实例中。{{site.data.keyword.cloud_notm}} 内部网络端点为：

`https://USERNAME.private.cloudantnosqldb.appdomain.cloud`

其中，USERNAME 是 URL 中服务实例用户的服务名称。使用 {{site.data.keyword.cloudant_short_notm}} 旧认证时，此字段还用作管理用户名。USERNAME 示例为 de810d0e-763f-46a6-ae88-50823dc85581-bluemix，生成的外部端点示例将为 de810d0e-763f-46a6-ae88-50823dc85581-bluemix.cloudantnosqldb.appdomain.cloud。 

有关如何通过 IP 白名单来阻止公用网络连接的更多信息，请参阅[安全访问控制](https://cloud.ibm.com/docs/services/Cloudant?topic=cloudant-security#secure-access-control)。
{: note}

## 服务凭证
{: #service-credentials}

要通过 {{site.data.keyword.cloud_notm}}
仪表板生成 {{site.data.keyword.cloudant_short_notm}} 的服务凭证，请参阅[在 {{site.data.keyword.cloud_notm}} 上创建 {{site.data.keyword.cloudant_short_notm}} 实例](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud#creating-an-ibm-cloudant-instance-on-ibm-cloud)教程。要从 {{site.data.keyword.cloud_notm}} CLI 生成服务凭证，请参阅 [创建 {{site.data.keyword.cloudant_short_notm}}
服务的凭证](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud-by-using-the-ibm-cloud-cli#creating-an-ibm-cloudant-instance-on-ibm-cloud-by-using-the-ibm-cloud-cli)。 

下面是 {{site.data.keyword.cloudant_short_notm}} 实例的服务凭证示例：

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

服务凭证包含以下字段：

字段       |用途
------|--------
`username` |URL 中服务实例用户的服务名称。此字段还用作管理用户名。
`password` |应用程序访问服务实例所需的旧凭证密码。仅当选择了`使用旧凭证和 IAM` 选项时，此字段才会显示。
`host`     |应用程序用于查找服务实例的主机名。仅当选择了`使用旧凭证和 IAM` 选项时，此字段才会显示。
`port`     |用于访问主机上服务实例的 HTTPS 端口号。此端口为 443，因为 {{site.data.keyword.cloudant_short_notm}} 只允许 HTTPS 访问。仅当选择了`使用旧凭证和 IAM` 选项时，此字段才会显示。
`url`|用于访问 {{site.data.keyword.cloudant_short_notm}} 实例的 HTTPS URL。如果选择了`使用旧凭证和 IAM` 选项，那么还会包含嵌入的旧用户名和密码。
`apikey`|IAM API 密钥。
`iam_apikey_description`|IAM API 密钥的描述。
`iam_apikey_name`|IAM API 密钥的标识。
`iam_role_crn`|IAM API 密钥具有的 IAM 角色。
`iam_serviceid_crn`|服务标识的 CRN。

## 认证
{: #authentication-overview}

{{site.data.keyword.cloudant_short_notm}} 在供应时提供了两种认证方法：`仅使用 IAM` 或`使用旧凭证和 IAM`。仅当选择了`使用旧凭证和 IAM` 认证方法时，才能查看有关旧凭证的详细信息。凭证会显示在实例的“服务凭证”选项卡上。有关更多信息，请参阅 [IAM 指南](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-)和[旧认证](/docs/services/Cloudant?topic=cloudant-authentication#authentication)文档，以获取有关使用任一种认证方式的详细信息。
 
{{site.data.keyword.cloudant_short_notm}} 团队建议您尽可能使用 IAM 访问控制进行认证。使用 {{site.data.keyword.cloudant_short_notm}} 旧认证时，建议您对编程方式的访问和复制作业使用 [API 密钥](/docs/services/Cloudant?topic=cloudant-authorization#api-keys){: new_window}，而不是帐户级别的凭证。
{: important}

## {{site.data.keyword.cloudant_short_notm}} 仪表板
{: #ibm-cloudant-dashboard}

您可以转到 {{site.data.keyword.cloud_notm}} 仪表板实例详细信息页面的“管理”选项卡，以打开实例的 {{site.data.keyword.cloudant_short_notm}} 仪表板。您可以使用`启动`或`启动 Cloudant 仪表板`按钮以在新的浏览器选项卡中打开仪表板。{{site.data.keyword.cloudant_short_notm}} 仪表板允许您执行以下任务：

- 监视实例的当前使用情况
- 在 {{site.data.keyword.cloudant_short_notm}} 数据库、文档和索引上执行 CRUD（创建、读取、更新、删除）
- 设置和查看复制作业
- 查看活动任务
- 查看和更新供应的吞吐量容量、声明、CORS 以及设置之类的帐户信息

## 以编程方式访问
{: #programmatic-access}

### 命令行 (curl)
{: #command-line-curl-}

您可以利用 curl 命令行实用程序访问 {{site.data.keyword.cloudant_short_notm}} HTTPS API。 

如果使用 {{site.data.keyword.cloudant_short_notm}} 旧认证，请参阅 [API 参考概述](/docs/services/Cloudant?topic=cloudant-api-reference-overview#api-reference-overview)以获取有关使用 curl 提供访问 {{site.data.keyword.cloudant_short_notm}} API 的用户名和密码的详细信息，如 API 参考示例中所示。

如果使用 {{site.data.keyword.cloud_notm}} IAM 认证，您必须先使用 API 密钥获取 {{site.data.keyword.cloud_notm}} IAM 令牌。然后，将 IAM 令牌传递到 {{site.data.keyword.cloudant_short_notm}} 实例以进行认证。有关更多信息，请参阅[使用服务 API ![外部链接图标](../images/launch-glyph.svg "外部链接图标") 传递
{{site.data.keyword.cloud_notm}} IAM 令牌以进行认证](https://cloud.ibm.com/docs/services/iam?topic=iam-iamapikeysforservices#token_auth){: new_window} 
教程。 

您无法直接使用 IAM API 密钥对 {{site.data.keyword.cloudant_short_notm}} 进行认证。
{: note}

### 客户机库
{: #client-libraries-overview}

{{site.data.keyword.cloudant_short_notm}} 具有 Java、Node.js、Python、Swift 以及 Mobile 的官方客户机库。有关更多信息，请参阅[客户机库文档](/docs/services/Cloudant?topic=cloudant-client-libraries#client-libraries)以访问库，并参阅从每个库连接 {{site.data.keyword.cloudant_short_notm}} 实例的示例。 
