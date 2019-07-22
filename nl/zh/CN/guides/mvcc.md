---

copyright:
  years: 2015, 2019
lastupdated: "2019-06-12"

keywords: revisions, distributed databases, conflicts, resolve conflicts, find conflicting revisions, merge changes, upload new revisions, delete old revisions

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

# 文档版本控制和 MVCC
{: #document-versioning-and-mvcc}

[多版本并行控制 (MVCC) ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://en.wikipedia.org/wiki/Multiversion_concurrency_control){: new_window} 是 {{site.data.keyword.cloudantfull}} 数据库确保数据库集群中的所有节点仅包含文档[最新版本](/docs/services/Cloudant?topic=cloudant-documents#documents)的方法。
{: shortdesc}

由于 {{site.data.keyword.cloudant_short_notm}} 数据库具有[最终一致性](/docs/services/Cloudant?topic=cloudant-cap-theorem#cap-theorem)，因此有必要执行此操作，以防止因过期文档之间同步而导致节点之间出现不一致的情况。

多版本并行控制 (MVCC) 支持对 {{site.data.keyword.cloudant_short_notm}} 数据库进行并发读写访问。MVCC 是一种[乐观并发 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](http://en.wikipedia.org/wiki/Optimistic_concurrency_control){: new_window} 形式。通过 MVCC，对 {{site.data.keyword.cloudant_short_notm}} 数据库的读写操作更快，因为无需锁定数据库来进行读或写操作。MVCC 还支持在 {{site.data.keyword.cloudant_short_notm}} 数据库节点之间同步。

## 修订版
{: #revisions}

{{site.data.keyword.cloudant_short_notm}} 数据库中的每个文档都有一个 `_rev` 字段，用于指示其修订版号。

在插入或修改文档时，服务器会将修订版号添加到文档中。更改或读取文档时，服务器响应中会包含此编号。`_rev` 值是使用简单计数器与文档散列的组合构造的。

修订版号的两个主要用途是帮助：

1.  确定必须在服务器之间复制哪些文档。
2.  确认客户端是否在尝试修改文档的最新版本。

[更新文档](/docs/services/Cloudant?topic=cloudant-documents#update)时，必须指定先前的 `_rev`，否则请求会失败并返回 [409 错误](/docs/services/Cloudant?topic=cloudant-http#http-status-codes)。

不应使用 `_rev` 来构建版本控制系统。原因是 _rev 是服务器使用的内部值。此外，文档的旧修订版是瞬态的，因此会定期除去。

{: note}

可以使用相应的 `_rev` 来查询特定修订版，但是较旧的修订版会被称为[压缩 ![外链接图标](../images/launch-glyph.svg "外部链接图标")](http://en.wikipedia.org/wiki/Data_compaction){: new_window} 的进程定期删除。压缩的一个结果是，使用相应的 `_rev` 来查询特定文档修订版以获取文档修订版的历史记录时，响应不一定会成功。如果需要文档的版本历史记录，解决方案是对每个修订版[创建新文档](/docs/services/Cloudant?topic=cloudant-documents#create-document)。

## 分布式数据库和冲突
{: #distributed-databases-and-conflicts}

分布式数据库在不与 {{site.data.keyword.cloudant_short_notm}} 上的主数据库（本身是分布式的）建立持续连接的情况下运行，因此基于同一个先前版本的更新仍可能存在冲突。

要查找冲突，请在检索文档时添加查询参数 [`conflicts=true`](/docs/services/Cloudant?topic=cloudant-databases#get-changes)。响应会包含带有所有冲突修订版的 `_mlicts` 数组。

要在数据库中查找多个文档的冲突，请编写视图。

以下 map 函数示例发出存在冲突的每个文档的所有冲突修订版。

_用于查找有冲突的文档的 map 函数示例：_

```javascript
function (doc) {
    if (doc._conflicts) {
        emit(null, [doc._rev].concat(doc._conflicts));
    }
}
```
{: codeblock}

可以定期查询此视图并根据需要解决冲突，或在每次复制后查询此视图。

## 解决冲突的步骤 
{: #steps-to-resolve-conflicts}

一旦找到了冲突，就可以通过 4 个步骤解决该冲突。

1.  [获取](#get-conflicting-revisions)冲突修订版。
2.  在应用程序中将其[合并](#merge-the-changes)，或者询问用户希望执行什么操作。
3.  [上传](#upload-the-new-revision)新修订版。
4.  [删除](#delete-old-revisions)旧修订版。

下面来看如何解决冲突的示例。假设您拥有一家在线商店的产品数据库。文档的第一个版本可能类似于以下示例：

```json
{
    "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "1-7438df87b632b312c53a08361a7c3299",
    "name": "Samsung Galaxy S4",
    "description": "",
    "price": 650
}
```
{: codeblock}

由于文档尚未包含描述，因此可能有人会添加描述：

_文档的第二个版本，通过添加描述来创建：_

```json
{
    "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "2-61ae00e029d4f5edd2981841243ded13",
    "name": "Samsung Galaxy S4",
    "description": "Latest smartphone from Samsung",
    "price": 650
}
```
{: codeblock}

同时，使用已复制数据库的其他某个人降低了价格：

_另一个修订版，由于 `price` 值不同而与先前修订版冲突：_

```json
{
    "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "2-f796915a291b37254f6df8f6f3389121",
    "name": "Samsung Galaxy S4",
    "description": "",
    "price": 600
}
```
{: codeblock}

然后将复制这两个数据库。文档版本的差异会导致冲突。

### 获取冲突修订版
{: #get-conflicting-revisions}

使用 `conflicts=true` 选项可确定有冲突的文档。

_查找有冲突的文档的示例：_

```http
http://$ACCOUNT.cloudant.com/products/$_ID?conflicts=true
```
{: codeblock}

_显示影响文档的冲突修订版的示例响应：_

```json
{
    "_id":"74b2be56045bed0c8c9d24b939000dbe",
    "_rev":"2-f796915a291b37254f6df8f6f3389121",
    "name":"Samsung Galaxy S4",
    "description":"",
    "price":600,
    "_conflicts":["2-61ae00e029d4f5edd2981841243ded13"]
}
```
{: codeblock}

具有已更改价格的版本被随意选为文档的最新版本，而与其他版本的冲突通过在 `_conflicts` 数组中提供这一其他版本的标识予以注明。在大多数情况下，此数组仅有一个元素，但可能存在许多冲突修订版。

### 合并更改
{: #merge-the-changes}

为了比较修订版以查看已更改的内容，应用程序会从数据库中获取所有版本。

_从数据库中检索文档所有版本的示例命令：_

```http
http://$ACCOUNT.cloudant.com/products/$_ID
http://$ACCOUNT.cloudant.com/products/$_ID?rev=2-61ae00e029d4f5edd2981841243ded13
http://$ACCOUNT.cloudant.com/products/$_ID?rev=1-7438df87b632b312c53a08361a7c3299
```
{: codeblock}

由于文档的不同字段存在有冲突的更改，因此很容易将它们合并在一起。

对于更复杂的冲突，可能需要其他解决策略：

*   基于时间：使用第一次或最后一次编辑。
*   用户干预：向用户报告冲突，并由用户决定最佳解决方法。
*   复杂算法：例如，对文本字段进行三路合并。

有关如何实现更改合并的实用示例，请参阅此项目及[样本代码 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://github.com/glynnbird/deconflict){: new_window}。

### 上传新修订版
{: #upload-the-new-revision}

下一步是创建解决了冲突的文档，并使用该文档来更新数据库。

_合并两个冲突修订版中更改的示例文档：_

```json
{
    "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "3-daaecd7213301a1ad5493186d6916755",
    "name": "Samsung Galaxy S4",
    "description": "Latest smartphone from Samsung",
    "price": 600
}
```
{: codeblock}

### 删除旧修订版
{: #delete-old-revisions}

最后，通过向带有我们要删除的修订版的 URL 发送 `DELETE` 请求来删除旧修订版。

_用于通过 HTTP 删除旧文档修订版的示例请求：_

```http
DELETE https://$ACCOUNT.cloudant.com/products/$_ID?rev=2-61ae00e029d4f5edd2981841243ded13
```
{: codeblock}

_用于通过命令行删除旧文档修订版的示例请求：_

```sh
curl "https://$ACCOUNT.cloudant.com/products/$_ID?rev=2-f796915a291b37254f6df8f6f3389121" -X DELETE
```
{: codeblock}

此时，影响文档的冲突得到解决。您可以通过将 `conflicts` 参数设置为 `true`，重新对文档执行 `GET` 操作来验证这一点。
