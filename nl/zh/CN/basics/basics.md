---

copyright:
  years: 2015, 2019
lastupdated: "2019-03-18"

keywords: connect to ibm cloudant, http api, json, distributed systems, replication

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

<!-- Acrolinx: 2018-05-07 -->

# {{site.data.keyword.cloudant_short_notm}} 基础知识
{: #ibm-cloudant-basics}

如果这是您第一次使用 Cloudant，请先快速阅读本部分，然后再进一步滚动到其他部分。
{: shortdesc}

在了解以下主题相关信息之前，我们假定您了解 {{site.data.keyword.cloudantfull}} 的一些基本知识： 

- [客户机库](/docs/services/Cloudant?topic=cloudant-client-libraries#client-libraries)
- [API 参考](/docs/services/Cloudant?topic=cloudant-api-reference-overview#api-reference-overview)
- [指南](/docs/services/Cloudant?topic=cloudant-authorized-curl-acurl-#authorized-curl-acurl-)

## 连接到 {{site.data.keyword.cloudant_short_notm}}
{: #connecting-to-ibm-cloudant}

要访问 {{site.data.keyword.cloudant_short_notm}}，您必须具有 [{{site.data.keyword.cloudant_short_notm}} 帐户](/docs/services/Cloudant?topic=cloudant-account#account)或 [{{site.data.keyword.cloud}} 帐户](/Cloudant?topic=cloudant-ibm-cloud-public#ibm-cloud-public)。

## HTTP API
{: #http-api}

所有对 {{site.data.keyword.cloudant_short_notm}} 的请求都会通过 Web 执行。这意味着任何可以与 Web 通信的系统都可以与 {{site.data.keyword.cloudant_short_notm}} 通信。{{site.data.keyword.cloudant_short_notm}} 的所有特定于语言的库实际上都只是包装程序，提供了一些便利和语言细节来帮助您使用简单 API。许多用户选择通过原始 HTTP 库来使用 {{site.data.keyword.cloudant_short_notm}}。

有关 {{site.data.keyword.cloudant_short_notm}} 如何使用 HTTP 的更多信息，请参阅 API 参考中的 [HTTP](/docs/services/Cloudant?topic=cloudant-http#http)。

{{site.data.keyword.cloudant_short_notm}} 支持以下 HTTP 请求方法：

-   `GET`

    请求指定的项。与标准 HTTP 请求一样，URL 的格式定义了返回的内容。使用 {{site.data.keyword.cloudant_short_notm}} 时，这可以包括静态项、数据库文档以及配置和统计信息。在大多数情况下，信息以 JSON 文档的形式返回。

-   `HEAD`

    `HEAD` 方法用于获取 `GET` 请求的 HTTP 头，不包含响应的主体。

-   `POST`

    上传数据。在 {{site.data.keyword.cloudant_short_notm}} 的 API 中，`POST` 方法用于设置值、上传文档、设置文档值以及启动一些管理命令。

-   `PUT`

    用于“存储”特定资源。在 {{site.data.keyword.cloudant_short_notm}} 的 API 中，`PUT` 用于创建新对象，包括数据库、文档、视图和设计文档。

-   `DELETE`

    删除指定的资源，包括文档、视图和设计文档。

-   `COPY`

    一种可用于复制文档和对象的特殊方法。

如果客户机（如某些 Web 浏览器）不支持使用这些 HTTP 方法，那么可以改为使用 `POST`，并将 `X-HTTP-Method-Override` 请求头设置为实际 HTTP 方法。

### “不允许的方法”错误
{: #method-not-allowed-error}

如果将不支持的 HTTP 请求类型与不支持指定类型的 URL 配合使用，那么会返回 [405](/docs/services/Cloudant?topic=cloudant-http#http-status-codes) 错误，其中会列出支持的 HTTP 方法，如以下示例所示。

_用于响应不支持的请求的错误消息示例：_

```json
{
    "error":"method_not_allowed",
    "reason":"Only GET,HEAD allowed"
}
```
{: codeblock}

## JSON
{: #json-overview}

{{site.data.keyword.cloudant_short_notm}} 使用 JSON（JavaScript 对象表示法）编码来存储文档，因此编码成 JSON 的任何内容都可以存储为文档。包含媒体（例如，图像、视频和音频）的文件称为 BLOB（二进制大对象），可以存储为与文档关联的附件。

有关 JSON 的更多信息，请参阅 [JSON 指南](/docs/services/Cloudant?topic=cloudant-json#json)。

## 分布式系统
{: #distributed-systems}

通过 {{site.data.keyword.cloudant_short_notm}} 的 API，您可以与多台协作的计算机（称为集群）进行交互。集群中的计算机必须位于同一数据中心，但可以位于该数据中心的不同“pod”内。使用不同的 pod 有助于增强 {{site.data.keyword.cloudant_short_notm}} 的高可用性特征。

集群的优点在于，当需要更多计算容量时，只需添加更多计算机即可。这通常比扩展或增强现有单台计算机更具成本效益，容错性也更强。

有关 {{site.data.keyword.cloudant_short_notm}} 和分布式系统概念的更多信息，请参阅 [CAP 定理](/docs/services/Cloudant?topic=cloudant-cap-theorem#cap-theorem)指南。

## 复制
{: #replication-basics}

[复制](/docs/services/Cloudant?topic=cloudant-replication-api#replication-api)是 {{site.data.keyword.cloudant_short_notm}}、[CouchDB ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](http://couchdb.apache.org/){: new_window}、[PouchDB ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](http://pouchdb.com/){: new_window} 和其他分布式数据库遵循的过程。复制可同步两个数据库的状态，使其内容完全相同。

您可以持续复制。这意味着每次源数据库发生更改时，目标数据库都会更新。持续复制可用于备份数据、跨多个数据库聚集数据，或用于共享数据。

但是，持续复制也意味着持续测试源数据库是否有任何更改。此测试需要持续的内部调用，可能会影响性能或数据库的使用成本。

持续复制可导致许多内部调用。这些调用可能影响 {{site.data.keyword.cloudant_short_notm}} 系统的多租户用户的成本。缺省情况下，持续复制已禁用。
{: note}

