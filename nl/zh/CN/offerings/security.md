---

copyright:
  years: 2017, 2019
lastupdated: "2019-03-18"

keywords: dbaas data protection, top-tier physical platforms, secure access control, data loss, corruption

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

<!-- Acrolinx: 2017-05-10 -->

# 安全性
{: #security}


## {{site.data.keyword.cloudant_short_notm}} DBaaS 数据保护和安全性
{: #ibm-cloudant-dbaas-data-protection-and-security}

保护大型 Web 和移动应用程序的应用程序数据可能是很复杂的工作，尤其是使用了分布式数据库和 NoSQL 数据库的情况。

{{site.data.keyword.cloudantfull}} 不仅能减少维护数据库的工作，使数据库保持正常运行和不间断增长，同时还确保您的数据始终安全并受到保护。
{: shortdesc}

## 顶层物理平台
{: #top-tier-physical-platforms}

{{site.data.keyword.cloudant_short_notm}} DBaaS 在第 1 层云基础架构提供者（如 {{site.data.keyword.cloud}} 和 Amazon）上以物理方式托管。因此，数据受到这些提供者采用的网络和物理安全措施的保护，包括（但不限于）：

- 认证：符合 SSAE16、SOC2 类型 1、ISAE 3402、ISO 27001、CSA 和其他标准。
- 访问权和身份管理。
- 数据中心和网络操作中心监视的常规物理安全性。
- 服务器加固。
- 通过 {{site.data.keyword.cloudant_short_notm}}，您能在 SLA 和成本需求变化时，灵活地选择或切换使用不同的提供者。

有关认证的更多详细信息在[合规信息](/docs/services/Cloudant?topic=cloudant-compliance#compliance)中提供。
{: tip}

## 安全访问控制
{: #secure-access-control}

{{site.data.keyword.cloudant_short_notm}} 中内置了许多安全功能，可供您控制对数据的访问：

功能|描述
--------|------------
认证|{{site.data.keyword.cloudant_short_notm}} 使用 HTTPS API 进行访问。如果 API 端点需要认证，那么会针对 {{site.data.keyword.cloudant_short_notm}} 收到的每个 HTTPS 请求，对用户进行认证。{{site.data.keyword.cloudant_short_notm}} 支持旧凭证和 IAM 访问控制。有关更多信息，请参阅 [IAM 指南](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-){: new_window}或旧[认证 API 文档](/docs/services/Cloudant?topic=cloudant-authentication#authentication){: new_window}。
授权|{{site.data.keyword.cloudant_short_notm}} 支持旧凭证和 IAM 访问控制。{{site.data.keyword.cloudant_short_notm}} 团队建议您尽可能使用 IAM 访问控制进行认证。使用 {{site.data.keyword.cloudant_short_notm}} 旧认证时，建议您对编程方式的访问和复制作业使用 [API 密钥](/docs/services/Cloudant?topic=cloudant-authorization#api-keys){: new_window}，而不是帐户级别的凭证。有关更多信息，请参阅 [IAM 指南](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-){: new_window}或者旧[认证 API 文档](/docs/services/Cloudant?topic=cloudant-authentication#authentication){: new_window}以及旧[授权 API 文档](/docs/services/Cloudant?topic=cloudant-authorization#authorization){: new_window}。

静态加密|对 {{site.data.keyword.cloudant_short_notm}} 实例中存储的所有数据进行静态加密。如果需要使用自带密钥 (BYOK) 进行静态加密，可以通过 {{site.data.keyword.cloud_notm}} Key Protect 启用此功能。{{site.data.keyword.cloudant_short_notm}} 支持此功能用于在所有区域中部署的新 {{site.data.keyword.cloudant_short_notm}} 专用硬件套餐实例。首先，使用{{site.data.keyword.cloud_notm}}“目录”创建一个专用硬件套餐实例。然后，提交支持凭单。我们的支持团队随后会协调获取您的新专用硬件实例的静态加密密钥，这些密钥由 Key Protect 实例进行管理。
“动态”加密|使用 HTTPS 加密对 {{site.data.keyword.cloudant_short_notm}} 的所有访问。
TLS | 我们建议您对 {{site.data.keyword.cloudant_short_notm}} 的所有访问使用 TLS 1.2 或 1.3。（***在 2019 年 6 月，{{site.data.keyword.cloudant_short_notm}} 支持不再使用旧版本（TLS 1.0 和 1.1），仅支持 TLS 1.2 及更高版本。***）{{site.data.keyword.cloudant_short_notm}} 用于 HTTPS 连接的证书由普遍可信认证中心（受到所有浏览器、操作系统以及 Java Development Kit (JDK) 之类的其他软件系统的预先信任）进行签名。我们承诺始终发布由普遍可信认证中心进行签名的有效（非过期）TLS 证书。但是，我们无法与客户协调变更，并且我们不承诺一直保留 DigiCert。为了确保连续访问 {{site.data.keyword.cloudant_short_notm}} 服务，强烈建议客户不要锁定当前证书，因为它会到期，并且一旦被泄露，将迅速轮换。我们建议客户改为使用其操作系统和浏览器的缺省证书捆绑软件，这将确保任何证书变更时服务能够安全地连续使用。
端点|所有 {{site.data.keyword.cloudant_short_notm}} 实例随附了可公共访问的外部端点。2019 年 1 月 1 日之后供应的专用硬件环境还为其上部署的所有标准套餐实例添加了内部端点。使用内部端点将允许客户通过内部 {{site.data.keyword.cloud}} 网络连接到 {{site.data.keyword.cloudant_short_notm}} 实例，以避免上游应用程序流量通过公用网络传输并产生带宽费用。请参阅
[服务端点文档](https://cloud.ibm.com/docs/services/service-endpoint/getting-started.html#about){:new_window}，以获取为您的 {{site.data.keyword.cloud}} 帐户启用服务端点的更多详细信息。
IP 白名单|具有专用 {{site.data.keyword.cloudant_short_notm}} 环境的 {{site.data.keyword.cloudant_short_notm}} 客户可以将 IP 地址列入白名单，以仅限指定服务器和用户访问。IP 白名单对于部署在多租户环境中的任何 {{site.data.keyword.cloud_notm}} Public 轻量/标准套餐都不可用。请开具支持凭单，以请求一组指定 IP 或 IP 范围的 IP 白名单。请注意，IP 白名单同时适用于 {{site.data.keyword.cloudant_short_notm}} API 和“仪表板”，因此请注意包含需要直接访问 {{site.data.keyword.cloudant_short_notm}}“仪表板”的任何管理员 IP。
CORS|使用 {{site.data.keyword.cloudant_short_notm}} 仪表板或 API 对特定域启用 CORS 支持。有关更多信息，请参阅 [CORS API 文档](/docs/services/Cloudant?topic=cloudant-cors#cors){:new_window}。

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

## 防止数据丢失或损坏
{: #protection-against-data-loss-or-corruption}

{{site.data.keyword.cloudant_short_notm}} 有若干功能可帮助您保持数据质量和可用性：

功能|描述
--------|------------
冗余和持久的数据存储|缺省情况下，{{site.data.keyword.cloudant_short_notm}} 在将每个文档保存到磁盘时，会将三个副本保存到集群中的三个不同节点上。保存这些副本可确保无论是否发生故障，数据的有效故障转移副本始终可用。
数据复制和导出|可以在不同数据中心的集群之间持续复制数据库，或将数据库复制到内部部署 {{site.data.keyword.cloudant_short_notm}} Local 集群或 Apache CouchDB。另一个选项是将数据从 {{site.data.keyword.cloudant_short_notm}}（以 JSON 格式）导出到其他位置或源（例如，您自己的数据中心），以实现额外数据冗余。
