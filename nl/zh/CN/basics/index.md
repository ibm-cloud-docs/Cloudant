---

copyright:
  years: 2015, 2017
lastupdated: "2017-01-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

# Cloudant 基础知识

如果这是您第一次使用 Cloudant，请先快速阅读本部分，然后再进一步滚动到其他部分。
{:shortdesc}

[客户机库](../libraries/index.html#-client-libraries)、[API 参考](../api/index.html#-api-reference)和[指南](../guides/index.html#-guides)中的各部分均假定您已了解一些有关 Cloudant 的基础知识。

## 连接到 Cloudant

要访问 {{site.data.keyword.cloudant_short_notm}}，您必须具有 [{{site.data.keyword.cloudant}} 帐户](../api/account.html)或 [{{site.data.keyword.Bluemix}} 帐户](../offerings/bluemix.html)。

## HTTP API

所有对 Cloudant 的请求都会通过 Web 执行。这意味着任何可以与 Web 通信的系统都可以与 Cloudant 通信。Cloudant 的所有特定于语言的库实际上都只是包装程序，提供了一些便利和语言细节来帮助您使用简单 API。许多用户选择通过原始 HTTP 库来使用 Cloudant。

在 [API 参考的 HTTP 主题](../api/http.html)中提供了有关 Cloudant 如何使用 HTTP 的具体详细信息。

Cloudant 支持以下 HTTP 请求方法：

-   `GET`

    请求指定的项。与标准 HTTP 请求一样，URL 的格式定义了返回的内容。使用 Cloudant 时，这可以包括静态项、数据库文档以及配置和统计信息。在大多数情况下，信息以 JSON 文档的形式返回。

-   `HEAD`

    `HEAD` 方法用于获取 `GET` 请求的 HTTP 头，不包含响应的主体。

-   `POST`

    上传数据。在 Cloudant 的 API 中，`POST` 方法用于设置值、上传文档、设置文档值以及启动一些管理命令。

-   `PUT`

    用于“存储”特定资源。在 Cloudant 的 API 中，`PUT` 用于创建新对象，包括数据库、文档、视图和设计文档。

-   `DELETE`

    删除指定的资源，包括文档、视图和设计文档。

-   `COPY`

    一种可用于复制文档和对象的特殊方法。

如果客户机（如某些 Web 浏览器）不支持使用这些 HTTP 方法，那么可以改为使用 `POST`，并将 `X-HTTP-Method-Override` 请求头设置为实际 HTTP 方法。

### “不允许的方法”错误

如果将不支持的 HTTP 请求类型与不支持指定类型的 URL 配合使用，那么会返回 [405](../api/http.html#405) 错误，其中会列出支持的 HTTP 方法，如以下示例所示。

_用于响应不支持的请求的错误消息示例：_

```json
{
    "error":"method_not_allowed",
    "reason":"Only GET,HEAD allowed"
}
```
{:codeblock}

## JSON

Cloudant 使用 JSON（JavaScript 对象表示法）编码来存储文档，因此编码成 JSON 的任何内容都可以存储为文档。包含媒体（例如，图像、视频和音频）的文件称为 BLOB（二进制大对象），可以存储为与文档关联的附件。

有关 JSON 的更多信息，请参阅 [JSON 指南](../guides/json.html)。

<div id="distributed"></div>

## 分布式系统

通过 Cloudant 的 API，您可以与多台协作的计算机（称为集群）进行交互。集群中的计算机必须位于同一数据中心，但可以位于该数据中心的不同“pod”内。使用不同的 pod 有助于增强 Cloudant 的高可用性特征。

集群的优点在于，当需要更多计算容量时，只需添加更多计算机即可。这通常比向上扩展或增强现有单台计算机更具成本效益，容错性也更强。

有关 Cloudant 和分布式系统概念的更多信息，请参阅 [CAP 定理](../guides/cap_theorem.html)指南。

## 复制

[复制](../api/replication.html)是 Cloudant、[CouchDB ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](http://couchdb.apache.org/){:new_window}、[PouchDB ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](http://pouchdb.com/){:new_window} 和其他分布式数据库遵循的过程。复制可同步两个数据库的状态，使其内容完全相同。

您可以持续复制。这意味着每次源数据库发生更改时，目标数据库都会更新。持续复制可用于备份数据、跨多个数据库聚集数据，或用于共享数据。

但是，持续复制也意味着持续测试源数据库是否有任何更改。此测试需要持续的内部调用，可能会影响性能或数据库的使用成本。

>   **注**：持续复制可能会导致大量内部调用。
这可能会影响 Cloudant 系统多租户用户的成本。缺省情况下，持续复制已禁用。
