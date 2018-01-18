---

copyright:
  years: 2017
lastupdated: "2017-07-12"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-07-12 -->

# 中断和行为更改

本文档概述了 Cloudant 发行版的行为更改。
{:shortdesc}

## CouchDB V1.6 与 Cloudant V2.0.0 之间的不兼容问题

-   最新版本的 Cloudant 和基于 CouchDB 1.6 的代码库之间存在不兼容问题。在  
较低版本的 Cloudant 中，如果向请求主体添加了查询参数 ("reduce=false")，那么当遵循请求 URL 中的该参数时，将忽略请求主体中的该参数。但在新版本的 Cloudant 中，不会忽略请求主体中的查询参数 ("reduce=false")。

## 修改了错误消息

- 尝试将不存在的修改内容放入文档附件时会发生的错误消息已更改为 409 错误，并包含以下信息：

	```
	{"error":"not_found","reason":"missing_rev"}
	```

## X-Frame-Options

`X-Frame-Options` 设置是一个响应头，用于控制是否可以将 HTTP 响应嵌入到 `<frame>`、`<iframe>` 或 `<object>` 中。此安全功能有助于防止点击劫持。

可以基于 CORS 设置来配置此选项。如果启用了 CORS，那么缺省情况下 `X-Frame-Options` 会自动启用并发送响应头 `X-Frame-Options: DENY`。如果请求 HOST 头与 CORS 的 origins 部分中列出的 URL 相匹配，那么将返回 `X-Frame-Options: ALLOW-FROM URL` 响应头。
 
此更改可能会影响直接通过浏览器访问数据库的客户。如果看到错误消息“X-Frame-Options: DENY”，并且在中断服务，那么必须启用 CORS；请参阅[设置 CORS 配置](../api/cors.html#setting-the-cors-configuration)。启用 CORS 后，将请求中发送的 HOST 头的值添加到允许的 `origins` 列表。

## 活动任务

-   `_active_tasks` 响应中的索引器条目不再报告 `user` 字段。
-   `_active_tasks` 响应中的搜索索引器条目不再报告 `user` 字段。

## 视图

-   对于缩减与不缩减的视图结果，键值的 Unicode 规范化保持一致。如果在设计文档中指定了原始整理，那么此修订可能会更改结果顺序。
-   查询视图或 `_all_docs` 数据库时，指定 `keys` 参数以及 `key`、`startkey` 和 `endkey` 参数中的任一参数都会发生错误。
-   如果 `startkey` 和 `endkey` 参数无法与任何行相匹配，那么将这两个参数传递给视图时会发生错误。例如，`startkey` 参数高于 `descending=false` 的 `endkey` 参数，或者 `startkey` 参数低于 `descending=true` 的 `endkey` 参数时，Cloudant 都会返回 `400 Bad Request` 错误。
-   在视图文档中配置 `dbcopy` 时，此参数会自动转换为设计文档中的 `options` 字段。 

## 设计文档

-   对设计文档的验证更严格。此验证应该不会导致现有设计文档出现问题，但格式不正确的设计文档无法保存。
-   以不支持的语言编写的视图全都会使用值为 `unknown_query_language` 的 `error` 进行响应。先前，响应是值为 `unknown_query_language` 的 `reason`。
-   使用空的 reducer 来放置数据库设计文档时，系统将使用错误原因`“(null)”`进行响应，而先前是返回 `((new String("null")))`。
-   如果在设计文档中指定了 `updates`，那么此项不能为空值。

## 认证

-   `_session` 元数据 `authentication_handlers` 不再包含 `["delegated","local"]`。

## 用户文档

-   验证在 `_users` 数据库中创建的用户文档的结构。在 DBNext 升级之后，用户文档必须符合 ASF CouchdDB 的需求。先前，Cloudant 不会验证用户文档的结构。 

## 复制 

-   复制器文档会在 `_replication_state_reason` JSON 字段中保留最后一条错误消息。即便在复制重新启动之后，该字段仍会保留，并处于 `triggered` 状态。此更改有助于复制器代码检测并避免将同一错误重复写入文档。
-   在复制期间发生错误时，不会更新复制文档，除非错误原因发生变化。先前，在复制期间发生错误时，会启动无限循环，这会生成大量分片。  

## 结果集

-   `_db_updates` 端点返回的结果集包含名为 `db_name` 的键。先前，返回的结果集包含名为 `dbname` 的键。
-   设置文档标识的最大长度。先前，无法定义文档标识最大长度。

## `dbcopy`

- 在某些情况下，`dbcopy` 功能可能会导致问题。有关该功能的信息已从文档中除去。强烈建议不要使用 `dbcopy`。
