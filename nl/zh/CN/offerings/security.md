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

# 安全性

## Cloudant DBaaS 数据保护和安全性

保护大型 Web 和移动应用程序的应用程序数据可能是很复杂的工作，尤其是使用了分布式数据库和 NoSQL 数据库的情况。

{{site.data.keyword.cloudantfull}} 不仅能减少维护数据库的工作，使数据库保持正常运行和不间断增长，同时还确保您的数据始终安全并受到保护。

## 顶层物理平台

{{site.data.keyword.cloudant_short_notm}} DBaaS 在第 1 层云基础架构提供者（如 {{site.data.keyword.BluSoftlayer_full}} 和 Amazon）上以物理方式托管。因此，数据受到这些提供者采用的网络和物理安全措施的保护，包括（但不限于）：

- 认证：符合 SSAE16、SOC2 类型 1、ISAE 3402、ISO 27001、CSA 和其他标准。
- 访问权和身份管理。
- 数据中心和网络操作中心监视的常规物理安全性。
- 服务器加固。
- 通过 {{site.data.keyword.cloudant_short_notm}}，您能在 SLA 和成本需求变化时，灵活地选择或切换使用不同的提供者。

> **注：**有关认证的更多详细信息在[合规信息](compliance.html)中提供。

## 安全访问控制

{{site.data.keyword.cloudant_short_notm}} 中内置了许多安全功能，可供您控制对数据的访问：

- 认证：{{site.data.keyword.cloudant_short_notm}} 使用 HTTP API 进行访问。如果 API 端点需要认证，那么针对 {{site.data.keyword.cloudant_short_notm}} 收到的每个 HTTPS 或 HTTP 请求，将对用户进行认证。
- 授权：授予对特定数据库的读取、写入和管理许可权。
- 动态加密：使用 HTTPS 对 {{site.data.keyword.cloudant_short_notm}} 的所有访问加密。
- 静态加密：可以对 {{site.data.keyword.cloudant_short_notm}} 中存储在磁盘上的数据加密。
  > **注**：存储在 {{site.data.keyword.Bluemix_notm}} {{site.data.keyword.cloudant_short_notm}} 实例中的数据始终会加密。
- API 访问：{{site.data.keyword.cloudant_short_notm}} 使用基于安全 HTTP (HTTPS) 的 API 以编程方式访问。API 密钥可以使用 {{site.data.keyword.cloudant_short_notm}}“仪表板”生成。
- IP 白名单：专用环境中的 {{site.data.keyword.cloudant_short_notm}} 客户可以将 IP 地址列入白名单，以仅限指定服务器和用户访问。
- CORS：使用 {{site.data.keyword.cloudant_short_notm}}“仪表板”针对特定域启用 CORS 支持。

## 防止数据丢失或损坏

{{site.data.keyword.cloudant_short_notm}} 有若干功能可帮助您保持数据质量和可用性：

- 冗余和持久数据存储：缺省情况下，{{site.data.keyword.cloudant_short_notm}} 在将每个文档保存到磁盘时，会将三个副本保存到集群中的三个不同节点上。保存这些副本可确保无论是否发生故障，数据的有效故障转移副本始终可用。
- 数据复制和导出：可以在不同数据中心的集群之间持续复制数据库，或将数据库复制到本地 Cloudant Local 集群或 Apache CouchDB。另一个选项是将数据从 {{site.data.keyword.cloudant_short_notm}}（以 JSON 格式）导出到其他位置或源（例如，您自己的数据中心），以实现额外数据冗余。
