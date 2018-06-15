---

copyright:
  years: 2017, 2018
lastupdated: "2017-11-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-05-04 -->

# {{site.data.keyword.cloudant_short_notm}} 中的新增功能

通过更改和更新使 {{site.data.keyword.cloudantfull}} 保持最新。
{:shortdesc}

## 专用硬件

提供了新的[专用服务实例](bluemix.html#dedicated-plan)。

## 构建 6233

- 引入了新的复制调度程序。调度程序除了具备性能优势和更多端点之外，还可更改复制状态的监视和报告方式。尤其是，不再支持记录复制文档中的状态更新。有关此重要更改的更多信息，请参阅有关[复制调度程序](../api/advanced_replication.html#the_replication_scheduler)的详细信息。如果您有任何问题或疑问，请使用 {{site.data.keyword.cloudant_short_notm}}“仪表板”开具凭单，以联系 {{site.data.keyword.cloudant_short_notm}} 支持。

## 构建 6069

- 先前，由于某种原因而崩溃的复制作业导致更新复制文档，然后重试启动新的复制。在某些情况下，此行为可能无限继续：同一错误消息多次重复出现。为此引入了修订，使得复制文档在错误原因发生变化之前，不会进行更新。
- 如果用于指定地理空间索引的设计文档无效，尝试使用 [`_geo_info` 端点](../api/cloudant-geo.html#obtaining-information-about-a-cloudant-geo-index)检索有关该索引的信息会导致 [HTTP `404`](http.html#404) 响应。
- 添加了对 [`$allmatch`](../api/cloudant_query.html#the-allmatch-operator) 运算符的支持。

## 构建 5834

- 现在，文档 `id` 的最大长度为 7168 个字符 (7k)。

## 构建 5728

- {{site.data.keyword.cloudant_short_notm}} 对 `_users` 数据库中存储的格式不正确的用户文档容忍度更高。用户文档应该根据 [Apache Software Foundation CouchDB 需求 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](http://docs.couchdb.org/en/2.0.0/intro/security.html#users-documents){:new_window} 来设计结构和填充。

## 构建 5638

-   为视图引入了新的“稳定”和“更新”查询参数。
-   如果复制器无法将检查点写入源数据库，那么复制器将永远不再重试。

## 构建 5421

-	更改订阅源支持基于视图的过滤器。
-	更改订阅源支持 `_doc_ids` 过滤器。
-	`_changes` 支持 `POST` 请求。
-	`_all_docs` 和 `_changes` 都支持 `attachments=true` 参数。
-	支持 CouchDB 1.6 `_users` 数据库功能，包括在 `_users` 数据库中创建文档时对密码进行服务器端散列处理。
-	`/_bulk_get` 端点可减少在复制到移动客户端时使用的请求数。
-	设计文档元数据包含 `update pending` 字段。
-	如果不存在有效的索引，那么 {{site.data.keyword.cloudant_short_notm}} 查询不再返回错误。

### 中断/行为更改

活动任务

-   `_active_tasks` 响应中的索引器条目不再报告 `user` 字段。
-   `_active_tasks` 响应中的搜索索引器条目不再报告 `user` 字段。

视图

-   对于缩减与不缩减的视图结果，键值的 Unicode 规范化保持一致。如果在设计文档中指定了原始整理，那么此修订可能会更改结果顺序。
-   查询视图或 `_all_docs` 数据库时，指定 `keys` 参数以及 `key`、`startkey` 和 `endkey` 参数中的任一参数都会发生错误。
-   如果 `startkey` 和 `endkey` 参数无法与任何行相匹配，那么将这两个参数传递给视图时会发生错误。例如，`startkey` 参数高于 `descending=false` 的 `endkey` 参数，或者 `startkey` 参数低于 `descending=true` 的 `endkey` 参数时，{{site.data.keyword.cloudant_short_notm}} 都会返回 `400 Bad Request` 错误。
-   在视图文档中配置 `dbcopy` 时，此参数会自动转换为设计文档中的 `options` 字段。 

设计文档

-   对设计文档的验证更严格。此验证应该不会导致现有设计文档出现问题，但格式不正确的设计文档无法保存。
-   以不支持的语言编写的视图全都会使用值为 `unknown_query_language` 的 `error` 进行响应。先前，响应是值为 `unknown_query_language` 的 `reason`。
-   使用空的 reducer 来放置数据库设计文档时，系统将使用错误原因`“(null)”`进行响应，而先前是返回 `((new String("null")))`。
-   如果在设计文档中指定了 `updates`，那么此项不能为空值。

认证

-   `_session` 元数据 `authentication_handlers` 不再包含 `["delegated","local"]`。

用户文档

-   验证在 `_users` 数据库中创建的用户文档的结构。在 DBNext 升级之后，用户文档必须符合 ASF CouchdDB 的需求。先前，{{site.data.keyword.cloudant_short_notm}} 不会验证用户文档的结构。 

复制 

-   复制器文档会在 `_replication_state_reason` JSON 字段中保留最后一条错误消息。即便在复制重新启动之后，该字段仍会保留，并处于 `triggered` 状态。此更改有助于复制器代码检测并避免将同一错误重复写入文档。
-   在复制期间发生错误时，不会更新复制文档，除非错误原因发生变化。先前，在复制期间发生错误时，会启动无限循环，这会生成大量分片。  

结果集

-   `_db_updates` 端点返回的结果集包含名为 `db_name` 的键。先前，返回的结果集包含名为 `dbname` 的键。
-   设置文档标识的最大长度。先前，无法定义文档标识最大长度。

`dbcopy`

- 在某些情况下，`dbcopy` 功能可能会导致问题。有关该功能的信息已从文档中除去。强烈建议不要使用 `dbcopy`。
