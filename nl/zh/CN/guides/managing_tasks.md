---

copyright:
  years: 2015, 2018
lastupdated: "2017-11-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

# 管理任务

对大量数据创建新索引或复制大型数据库可能需要较长的一段时间。
{:shortdesc}

那么，如何确定任务是在进行中，还是已经完成呢？[`_active_tasks` 端点](../api/active_tasks.html)可提供有关所有进行中任务的信息。但是，如果您启动了大量任务，那么其中一些任务可能安排为稍后运行，并且要到启动后才会出现在 `_active_tasks` 下。

本指南说明了如何使用 `_active_tasks` 端点来监视长时间运行的任务。`curl` 命令用于访问该端点。`jq` 命令行 JSON 处理器用于处理 JSON 响应。

由于这是以任务为中心的教程，因此仅涵盖完成此任务所必需的内容。有关可用选项的完整指南，请参阅 [API 参考](../api/index.html)。

## curl 和 jq 基础知识

要获取所有活动任务并将输出设置为令人满意的格式，请使用 `curl` 调用您的帐户，并将输出传送到 `jq`。

`jq` 支持按文档的字段值过滤文档列表。这让您能更轻松地获取所有复制文档，或者仅获取一个特定视图索引任务的详细信息。[API 参考](../api/index.html)包含有关这些选项的更多信息。

_获取活动任务列表并设置其格式的示例：_

```sh
curl 'https://username:password@username.cloudant.com/_active_tasks' | jq '.'
```
{:codeblock}

## 监视视图构建和搜索索引

在更新设计文档时，将重建视图索引。对任一视图的更新都会导致重建文档中的所有视图。

仅当更改了搜索索引的对应索引函数时，才会重建搜索索引。对于正在构建的每个搜索索引以及每个更改了其视图的设计文档，将针对集群中每个分片的每个副本创建一个新任务。

例如，如果有 24 个分片，每个分片有三个副本，并且更新了两个搜索索引，那么将运行 24 x 3 x 2 = 144 个任务。

要查找所有视图索引任务，请将 `curl` 输出传送到 `jq`，然后使其按文档类型字段过滤数组中的文档。对应的命令用于搜索索引任务。

在每种情况下，搜索索引任务列表的结果都是 JSON 对象列表：每个找到的活动任务对应一个 JSON 对象。

_通过过滤 `indexer` 类型来查找所有视图索引任务的示例：_

```sh
curl -s 'https://username:password@username.cloudant.com/_active_tasks' | jq '.[] | select(.type=="indexer")'
```
{:codeblock}

_通过过滤 `search_indexer` 类型来查找所有搜索索引任务的示例：_

```sh
curl -s 'https://username:password@username.cloudant.com/_active_tasks' | jq '.[] | select(.type=="search_indexer")'
```
{:codeblock}

_搜索视图索引任务后的示例结果：_

```json
{
    "total_changes": 6435,
    "started_on": 1371118332,
    "user": "username",
    "updated_on": 1371118334,
    "type": "indexer",
    "node": "dbcore@db6.meritage.cloudant.net",
    "pid": "<0.16366.6103>",
    "changes_done": 364,
    "database": "shards/40000000-7fffffff/username/database",
    "design_document": "_design/ngrams"
}
```
{:codeblock}

## 估计完成任务所需时间

要估计需要多长时间才能完成索引任务，请监视 `changes_done` 的数目，并将此值与 `total_changes` 进行比较。例如，如果 `changes_done` 每秒增加 250 个，并且 `total_changes` 为 1,000,000，那么完成任务预计需要 1,000,000 / 250 = 4,000 秒，即大约 66 分钟。

>   **注**：对完成索引任务所需时间的估计不可能 100% 准确。
实际完成任务所需时间取决于多个因素，包括：



-   处理每个文档所需的时间。例如，视图可能会先检查文档的类型，然后仅针对一种类型发出新的索引条目。
-   文档的大小。
-   集群上的当前工作负载。

>   您应该承认这些因素综合在一起可能会让您的估算出现较大的偏差。

_使用 `jq` 抽取 `changes_done` 字段的示例：_

```sh
curl ... | jq '.[] | select(.type=="search_indexer") | .changes_done'
```
{:codeblock}

## 监视复制

要查找所有复制任务，请将 `curl` 输出传送到 `jq`，然后按文档类型字段过滤数组中的文档。

要更轻松地从活动任务列表中选择有关复制过程的信息，请通过在 `_replicator` 数据库中创建文档来启动复制过程，并将其 `_id` 字段设置为已知值。

_通过过滤 `replication` 类型来查找所有复制任务的示例：_

```sh
curl -s 'https://username:password@username.cloudant.com/_active_tasks' | jq '.[] | select(.type=="replication")'
```
{:codeblock}

_通过过滤已知文档标识来查找特定复制任务的示例：_

```sh
curl ... | jq '.[] | select(.doc_id=="ID")'
```
{:codeblock}

_通过过滤已知 `replication_id` 来查找特定复制任务的示例：_

```sh
curl ... | jq '.[] | select(.replication_id=="ID")'
```
{:codeblock}

_搜索复制任务后的示例结果：_

```json
{
    "started_on": 1371094220,
    "source_seq": "62960-sakdjflksdfjsdlkafjalskdfjlsakfjlasdkjksald",
    "source": "",
    "revisions_checked": 12,
    "continuous": true,
    "doc_id": null,
    "doc_write_failures": 0,
    "docs_read": 12,
    "target": "",
    "type": "replication",
    "updated_on": 1371118477,
    "user": "username",
    "checkpointed_source_seq": "61764-dskfjalsfjsalkfjssadjfhasdfkjhsdkfhsdkf",
    "changes_pending": 1196,
    "pid": "<0.9955.4120>",
    "node": "dbcore@db7.meritage.cloudant.net",
    "docs_written": 12,
    "missing_revisions_found": 12,
    "replication_id": "asfksdlfkjsadkfjsdalkfjas+continuous+create_target"
}
```
{:codeblock}

## 故障诊断

### 任务是否卡住？

对于一次性非持续复制（复制期间不会大量更新源数据库），`changes_pending` 值会表明还有多少个文档有待处理。这意味着 `changes_pending` 值很适合指示复制有可能在何时完成。

对于持续复制，您会更关注处理的文档数随时间推移如何发生变化，以及 `changes_pending` 值是否增大。如果在一段时间内，`changes_pending` 增大，但 `revisons_checked` 保持不变，说明复制可能已停止。如果 `changes_pending` 增大，并且 `revisions_checked` 也增大，这可能指示复制的进度落后于添加到数据库或在数据库中更新的数据量。

### 任务卡住该怎么办？

要解决已停止的复制，可能必须[取消复制过程](../api/replication.html#cancelling-a-replication)，然后重新启动。

如果这样做没有用，说明导致复制停止的原因可能是访问源或目标数据库的用户没有写许可权。

>   **注**：复制会利用[检查点](replication_guide.html#checkpoints)。
这意味着如果重新启动复制，那么不必重新复制已经复制和未更改的内容。



如果您通过在 `_replicator` 数据库中创建文档而创建了复制过程，那么还可以在该数据库中检查复制的状态。
