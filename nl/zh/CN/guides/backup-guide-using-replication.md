---

copyright:
  years: 2015, 2017
lastupdated: "2018-06-07"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-04-20 -->

<div id="back-up-your-data-using-replication"></div>

# 复制递增

>	**注**：本指南包含有关 {{site.data.keyword.cloudantfull}} 备份的较旧或“不推荐使用”的指导信息。有关最新的备份指导信息，请参阅[灾难恢复和备份](disaster-recovery-and-backup.html)指南。

数据库备份可保护数据，以防潜在的丢失或损坏。
{:shortdesc}

可以使用 {{site.data.keyword.cloudant_short_notm}} 复制工具来创建数据库备份，并将其存储在 {{site.data.keyword.cloudant_short_notm}} 集群上。然后，可以通过备份将数据、完整数据库或特定 JSON 文档复原到生产集群。

通过使用 {{site.data.keyword.cloudant_short_notm}} 复制，数据库备份会将数据库内容存储到检查点。可以“回滚”到特定的检查点。检查点并不特定于精确的时间。相反，检查点是在备份期间发生特定更改后的原样数据库记录。通过这种方式，备份可以保留所选时间的数据库状态。

## 增量备份

如果您是企业客户，那么每日增量备份功能[可用](disaster-recovery-and-backup.html)。

如果您不是企业客户，或者希望创建自己的备份，那么可以使用 {{site.data.keyword.cloudant_short_notm}} 复制工具来创建数据库备份。

一种简单的方法是将整个数据库复制到指定日期的备份数据库。此方法很有效且易于操作。但是，如果需要多个时间点的备份（例如，7 个每日备份和 4 个每周备份），那么必须在每个新的备份数据库中存储数据库的完整副本。完整副本可能需要使用大量磁盘，尤其是数据库很大的情况下。

作为替代方法，增量备份是一个不错的解决方案，用于仅存储自上次备份以来更改过的文档。

此过程很简单。最初，您将创建整个数据库的备份。在首次备份后，您将运行每日“增量”备份，以_仅_备份自上次备份以来数据库中的更改内容。此复制将成为每日备份。

>   **注**：您可以将备份配置为定期触发。
但是，每个时间间隔必须为 24 小时或更长时间。换言之，您可以运行每日备份，但不能运行每小时备份。



## 创建增量备份

增量备份仅保存备份之间的差异或“变化量”。源数据库每 24 小时复制到目标数据库一次。

复制使用序列值来确定在 24 小时时间段内更改的文档。备份操作使用复制来获取和存储检查点。检查点是具有内部名称的另一个文档。备份操作通过日期和备份任务名称的组合来创建名称。在恢复或累积过程中，此名称更易于确定检查点。

要创建增量备份，请执行以下步骤：

1.  查找上次复制的检查点文档的标识。此标识存储在 `_replicator` 数据库中复制文档的 `_replication_id` 字段中。
2.  打开 `/$DATABASE/_local/$REPLICATION_ID` 处的检查点文档，其中 `$REPLICATION_ID` 是在上一步中找到的标识，`$DATABASE` 是源或目标数据库的名称。该文档通常同时存在于两个数据库上，但也可能仅存在于一个数据库上。
3.  在检查点文档中找到的 history 数组中，搜索第一个元素的 `recded_seq` 字段。
4.  复制到新的增量备份数据库，将复制文档中的 [`since_seq` 字段](../api/replication.html#the-since_seq-field)设置为上一步中找到的 `recded_seq` 字段的值。

>   **注**：根据定义，使用 `since_seq` 选项会绕过常规检查点工具。因此，请谨慎使用 `since_seq`。 

## 复原数据库

要通过增量备份来复原数据库，请将每个增量备份复制到一个新的数据库，从最新的增量开始。

也可以从最早的备份开始，然后按顺序应用后续备份。但是，从最新的增量备份开始复制，速度会更快，因为更新的文档只向目标数据库写入一次。将跳过早于新数据库中已存在的副本的任何文档。


## 示例

此示例显示如何执行以下操作：

1.  设置数据库以使用增量备份。
2.  运行完全备份。
3.  设置并运行增量备份。
4.  复原备份。

<div id="constants-used-in-this-guide"></div>

### 此处使用的常量

```sh
# save base URL and the content type in shell variables
$ url='https://$ACCOUNT:$PASSWORD@$ACCOUNT.cloudant.com'
$ ct='Content-Type: application-json'
```
{:codeblock}

假定您需要备份一个数据库。您希望在周一创建完全备份，在周二创建增量备份。

可以使用 `curl` 和 [`jq `![外部链接图标](../images/launch-glyph.svg "外部链接图标")](http://stedolan.github.io/jq/){:new_window} 命令来运行这些操作。实际上，您可以使用任何 HTTP 客户端。

<div id="step-1-check-you-have-three-databases"></div>

### 第 1 步：检查您是否有三个数据库

对于此示例，您需要以下三个数据库：

-   original 数据库，用于保存要备份的数据。
-   两个增量数据库，分别用于周一备份 (`backup-monday`) 和周二备份 (`backup-tuday`)。

_显示如何使用 HTTP 来检查您是否拥有此示例中要使用的三个数据库的示例：_

```http
PUT /original HTTP/1.1
PUT /backup-monday HTTP/1.1
PUT /backup-tuesday HTTP/1.1
```
{:codeblock}

_显示如何使用命令行来检查您是否拥有要在此示例中使用的三个数据库的示例：_

```sh
$ curl -X PUT "${url}/original"
$ curl -X PUT "${url}/backup-monday"
$ curl -X PUT "${url}/backup-tuesday"
```
{:codeblock}

### 第 2 步：创建 `_replicator` 数据库

如果 `_replicator` 数据库不存在，请进行创建。

_使用 HTTP 创建 `_replicator` 数据库：_

```http
PUT /_replicator HTTP/1.1
```
{:codeblock}

_使用命令行创建 `_replicator` 数据库：_

```sh
curl -X PUT "${url}/_replicator"
```
{:pre}

### 第 3 步：备份整个 (original) 数据库

您希望在周一首次备份所有数据。通过将所有内容从 `original` 复制到 `backup-monday` 来创建此备份。

_使用 HTTP 在周一运行完全备份：_

```http
PUT /_replicator/full-backup-monday HTTP/1.1
Content-Type: application/json
```
{:codeblock}

_使用命令行在周一运行完全备份：_

```sh
$ curl -X PUT "${url}/_replicator/full-backup-monday" -H "$ct" -d @backup-monday.json
# where backup-monday.json describes the backup.
```
{:codeblock}

_用于描述完全备份的 JSON 文档：_
 
```json
{
    "_id": "full-backup-monday",
    "source": "${url}/original",
    "target": "${url}/backup-monday"
}
```
{:codeblock}

<div id="step-4-get-checkpoint-id"></div>

### 第 4 步：准备增量备份 - 第 1 部分 - 获取检查点标识

您希望在周二执行增量备份，而不是执行另一个完全备份。

要启动增量备份，需要两个值：

-   检查点标识。
-   [`recorded_seq` 值](#step-5-prepare-incremental-backup-part-2-get-recorded_seq-value)。

这两个值用于确定上次备份的结束位置，并确定下一次增量备份的开始位置。获取这两个值后，即可运行增量备份。

首先查找检查点标识值。此值存储在 `_replicator` 数据库中复制文档的 `_replication_id` 字段中。

_使用 HTTP 获取检查点标识，以帮助查找 `recded_seq` 值：_

```http
GET /_replicator/full-backup-monday HTTP/1.1
# Search for the value of _replication_id
```
{:codeblock}

_使用命令行获取检查点标识，以帮助查找 `recded_seq` 值：_

```sh
replication_id=$(curl "${url}/_replicator/full-backup-monday" | jq -r '._replication_id')
```
{:pre}

<div id="step-5-get-recorded_seq-value"></div>

### 第 5 步：准备增量备份 - 第 2 部分 - 获取 `recorded_seq` 值

获取检查点标识后，使用该标识来获取 `recded_seq` 值。此值位于 original 数据库的 `/_local/${replication_id}` 文档中 history 数组的第一个元素中。

现在，您已有 `recded_seq` 值。此值用于确定从 original 数据库复制的最后一个文档。

_使用 HTTP 从 original 数据库获取 `recded_seq`：_

```http
GET /original/_local/${replication_id} HTTP/1.1
# Search for the first value of recorded_seq in the history array
```
{:codeblock}

_使用命令行从 original 数据库获取 `recded_seq`：_

```sh
recorded_seq=$(curl "${url}/original/_local/${replication_id}" | jq -r '.history[0].recorded_seq')
```
{:pre}

### 第 6 步：运行增量备份

现在，您已有检查点标识和 `record_seq`，可以启动周二的增量备份。此备份会复制_自_上次复制以来所做的所有文档更改。

复制完成后，即拥有一个完成的增量备份。此备份由 original 数据库中的所有文档组成，并且可以通过检索 `backup-monday` _和_ `backup-uday` 数据库的内容来进行复原。

_使用 HTTP 运行周二的增量备份：_

```http
PUT /_replicator/incr-backup-tuesday HTTP/1.1
Content-Type: application/json
```
{:codeblock}

_使用命令行运行周二的增量备份：_

```sh
curl -X PUT "${url}/_replicator/incr-backup-tuesday" -H "${ct}" -d @backup-tuesday.json
```
{:pre}

_用于描述周二增量备份的 JSON 文档：_
 
```json
{
    "_id": "incr-backup-tuesday",
    "source": "${url}/original",
    "target": "${url}/backup-tuesday",
    "since_seq": "${recorded_seq}"
}
```
{:codeblock}

### 第 7 步：复原周一备份

要通过备份进行复原，请将初始完全备份和所有增量备份复制到新数据库。

例如，要复原周一的状态，您将从 `backup-monday` 数据库进行复制。

_使用 HTTP 从 `backup-monday` 数据库复原：_

```sh
PUT /_replicator/restore-monday HTTP/1.1
Content-Type: application/json
```
{:codeblock}

_使用命令行从 `backup-monday` 数据库复原：_

```sh
curl -X PUT "${url}/_replicator/restore-monday" -H "$ct" -d @restore-monday.json
```
{:pre}

_用于描述复原的 JSON 文档：_
 
```json
{
    "_id": "restore-monday",
    "source": "${url}/backup-monday",
    "target": "${url}/restore",
    "create_target": true  
}
```
{:codeblock}

### 第 8 步：复原周二备份

要复原周二的数据库，请先从 `backup-tuesday` 进行复制，然后再从 `backup-monday` 进行复制。

>   **注**：上面列出的顺序不是拼写错误；
这样做的目的确实是_先_从周二复原，_再_从周一复原。



您可以按时间顺序进行复原，但使用逆序时，周二更新的文档只需要写入目标数据库一次。将忽略文档在周一数据库中存储的较早版本。

_使用 HTTP 复原周二的备份并先获取最新的更改：_

```http
PUT /_replicator/restore-tuesday HTTP/1.1
Content-Type: application/json
```
{:codeblock}

_使用命令行复原周二的备份并先获取最新的更改：_

```sh
curl -X PUT "${url}/_replicator/restore-tuesday" -H "$ct" -d @restore-tuesday.json
```
{:pre}

_用于请求复原周二备份的 JSON 文档：_
 
```json
{
    "_id": "restore-tuesday",
    "source": "${url}/backup-tuesday",
    "target": "${url}/restore",
    "create_target": true  
}
```
{:codeblock}

_通过使用 HTTP 最后复原周一的备份来完成恢复：_

```http
PUT /_replicator/restore-monday HTTP/1.1
Content-Type: application/json
```
{:codeblock}

_通过使用命令行最后复原周一的备份来完成恢复：_

```http
curl -X PUT "${url}/_replicator/restore-monday" -H "$ct" -d @restore-monday.json
```
{:pre}

_用于请求复原周一备份的 JSON 文档：_
 
```json
{
    "_id": "restore-monday",
    "source": "${url}/backup-monday",
    "target": "${url}/restore"
}
```
{:codeblock}

## 建议

虽然先前的信息概述了基本的备份过程，但每个应用程序都需要自己的备份需求和策略。以下建议可能会有所帮助。

### 安排备份

复制作业会显著增大集群上的负载。如果要备份多个数据库，最好是使复制作业在不同时间内错开执行，或者将复制作业安排在集群不太忙碌的时间执行。

#### 更改备份的 IO 优先级

可以通过调整复制文档中 `x-cloudant-io-priority` 字段的值来更改备份作业的优先级。

1.  在 source 字段和 target 字段中，更改 `headers` 对象。
2.  在 headers 对象中，将 `x-cloudant-io-priority` 字段值更改为 `"low"`。

_用于设置 IO 优先级的 JSON 文档的示例：_

```json
{
    "source": {
        "url": "https://user:pass@example.com/db",
        "headers": {
            "x-cloudant-io-priority": "low"
        }
    },
    "target": {
        "url": "https://user:pass@example.net/db",
        "headers": {
            "x-cloudant-io-priority": "low"
        }
    }
}
```
{:codeblock}

<div id="design-documents"></div>

### 备份设计文档

如果在备份中包含了设计文档，那么会在备份目标上创建索引。此做法会让备份过程变慢，并占用不必要的磁盘空间量。如果在备份系统上不需要索引，请对复制使用过滤功能，以过滤掉设计文档。您还可以使用此过滤功能来排除其他不需要的文档。

### 备份多个数据库

如果应用程序对每个用户使用一个数据库，或允许每个用户创建多个数据库，那么需要为每个新数据库创建一个备份作业。请确保复制作业不会同时开始。

## 需要帮助？

复制和备份可能很棘手。如果遇到困难，请查看[复制指南](replication_guide.html)，或联系 [{{site.data.keyword.cloudant_short_notm}} 支持团队 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](mailto:support@cloudant.com){:new_window}。
