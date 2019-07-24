---

copyright:
  years: 2015, 2019
lastupdated: "2019-06-12"

keywords: find conflicts, resolve conflicts, merge changes, upload new revision, delete revision

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

# 冲突
{: #conflicts}

在分布式数据库中，数据副本可能存储在多个位置，自然网络和系统特征可能意味着对一个位置中存储的文档进行的更改无法立即更新或复制到数据库的其他部分。

换句话说，如果对文档的不同副本独立进行了更新，那么对于文档内容如何才算正确、明确，可能会产生分歧或“冲突”。

{{site.data.keyword.cloudantfull}} 尝试通过向您提醒潜在问题来帮助避免冲突。
它将向有问题的更新请求返回 [`409` 响应](/docs/services/Cloudant?topic=cloudant-http#http-status-codes)，以向您发出警告。
但是，如果在当前未连接到网络的系统上请求数据库更新，那么可能不会收到 `409` 响应。
例如，数据库所在的移动设备可能暂时断开了与因特网的连接，导致在此时间段内无法检查是否执行了其他可能冲突的更新。

如果请求的文档发生冲突，{{site.data.keyword.cloudant_short_notm}} 会按预期返回此文档。
但是，返回的版本由考虑多种因素的内部算法确定；例如，您不应该假定返回的文档始终是最新的版本。

如果不检查冲突或者无法解决冲突，{{site.data.keyword.cloudant_short_notm}} 数据库会开始表现出以下几种行为：

* 由于冲突文档越来越多，文档内容的不一致情况也不断增多。
* 由于在解决冲突之前必须保留所有冲突文档，增大了数据库大小。
* 由于 {{site.data.keyword.cloudant_short_notm}} 必须尝试识别冲突文档的“最有可能的”版本，因此需要执行更多工作来响应每一个请求，从而降低了性能。

以下建议的实践可能有助于您决定何时检查和解决冲突：

<table>
<tr>
<th>应用程序特征</th>
<th>更新文档的频率</th>
<th>检索时是否检查冲突？</th>
<th>更新时是否检查冲突？</th>
</tr>
<tr>
<td>始终连接到网络（例如，服务器）。</td>
<td>经常</td>
<td>是</td>
<td>-</td>
</tr>
<tr>
<td>始终连接到网络。</td>
<td>有时</td>
<td>-</td>
<td>是</td>
</tr>
<tr>
<td>经常但不始终连接到网络（例如，笔记本电脑）。</td>
<td>经常</td>
<td>-</td>
<td>是</td>
</tr>
<tr>
<td>经常但不始终连接到网络。</td>
<td>有时</td>
<td>-</td>
<td>是</td>
</tr>
<tr>
<td>有时连接到网络（例如，平板电脑）。</td>
<td>经常</td>
<td>-</td>
<td>是</td>
</tr>
</table>

## 查找冲突
{: #finding-conflicts}

要查找可能影响文档的任何冲突，请在检索文档时添加查询参数 `conflicts=true`。返回时，生成的文档包含 `_conflicts` 数组，其中包含所有冲突版本的列表。

> 用于查找文档冲突的示例 map 函数：

```
function (doc) {
    if (doc._conflicts) {
        emit(null, [doc._rev].concat(doc._conflicts));
    }
}
```

要在数据库中查找多个文档的冲突，请编写[视图](/docs/services/Cloudant?topic=cloudant-views-mapreduce#views-mapreduce)。使用 map 函数（例如，提供的示例），可以查找存在冲突的每个文档的所有修订版。

如果您有此类视图，可以将其用于根据需要查找和解决冲突。
或者，可以在每次复制后查询视图来立即识别和解决冲突。

## 如何解决冲突
{: #how-to-resolve-conflicts}

一旦找到了冲突，就可以通过以下 4 个步骤解决该冲突：

1.	[获取](#get-conflicting-revisions)冲突修订版。
2.	在应用程序中将其[合并](#merge-the-changes)，或者询问用户希望执行什么操作。
3.	[上传](#upload-the-new-revision)新修订版。
4.	[删除](#delete-old-revisions)旧修订版。

> 示例文档 - 第一个版本。

```json
{
  "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "1-7438df87b632b312c53a08361a7c3299",
    "name": "Samsung Galaxy S4",
    "description": "",
    "price": 650
}
```

下面来看如何解决冲突的示例。假设您拥有一家在线商店的产品数据库。文档的第一个版本可能类似于提供的示例。

> 文档的第二个版本（第一个修订版），添加描述。

```json
{
  "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "2-61ae00e029d4f5edd2981841243ded13",
    "name": "Samsung Galaxy S4",
    "description": "Latest smartphone from Samsung",
    "price": 650
}
```

由于文档尚未包含描述，因此可能有人会添加描述。

> _备用_的第二个版本，引入了对文档第一个版本进行的降价数据更改。

```json
{
  "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "2-f796915a291b37254f6df8f6f3389121",
    "name": "Samsung Galaxy S4",
    "description": "",
    "price": 600
}
```

同时，使用已复制数据库的其他某个人也降低了价格。这是对文档第一个版本进行的更改。因此，降价更改并不“知道”描述更改。

之后，复制两个数据库时，可能不清楚文档的两个备用版本中哪个是对的。
这是冲突场景。

## 获取冲突修订版
{: #get-conflicting-revisions}

要查找文档的任何冲突修订版，请正常检索该文档，但包含 `conflicts=true` 参数，与以下示例类似：

`http://ACCOUNT.cloudant.com/products/$_ID?conflicts=true`


> 显示冲突修订版的示例文档检索响应

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

如果文档存在任何冲突，根据更改的描述或更改的价格问题，您会收到与提供的示例类似的响应。

具有已更改价格的版本被_随意_选为文档的最新版本。不应该假定文档的最新更新版本就是用于解决冲突的最新版本。

在此示例中，具有 `_rev` 值 `2-f796915a291b37254f6df8f6f3389121` 的检索文档和具有 `_rev` 值 `2-61ae00e029d4f5edd2981841243ded13` 的另一个文档之间被视为存在冲突。
在 `_conflicts` 数组中记录了冲突文档详细信息。

通常，您可能会发现该数组仅有一个元素，但是也可能有很多冲突修订版，每个修订版都在该数组中列出。

## 合并更改
{: #merge-the-changes}

您的应用程序必须识别和协调所有可能的更改，从而有效合并正确、有效的更新，以生成文档的单个非冲突版本。

为了比较修订版并识别已更改的内容，应用程序必须从数据库中检索所有版本。如先前所描述，首先检索一个文档以及任何冲突版本的详细信息。
为此，我们将使用类似于以下内容的命令，该命令也会请求 `_conflicts` 数组：

`http://$ACCOUNT.cloudant.com/products/$_ID?conflicts=true`

此检索为我们提供了存储的当前文档版本_以及_还必须检索的其他所有冲突文档的列表，例如，`...rev=2-61ae00e029d4f5edd2981841243ded13` 和 `...rev=1-7438df87b632b312c53a08361a7c3299`。
还会检索并存储所有这些冲突版本，例如：

  `http://$ACCOUNT.cloudant.com/products/$_ID?rev=2-61ae00e029d4f5edd2981841243ded13`
  `http://$ACCOUNT.cloudant.com/products/$_ID?rev=1-7438df87b632b312c53a08361a7c3299`

拥有文档的所有冲突修订版后，可继续解决冲突。

在先前场景中，文档版本之间的差异是针对文档中的不同字段，从而更易于合并。

更复杂的冲突可能需要相应进行更多分析。
为帮助分析，可以从多种不同冲突解决策略中进行选择，例如：

*	基于时间：使用第一项编辑或最新编辑的简单测试。
*	用户评估：向用户报告冲突，然后用户决定最佳解决方法。
*	复杂合并算法：通常用于[版本控制系统](https://en.wikipedia.org/wiki/Merge_%28version_control%29)中。示例为[三向合并](https://en.wikipedia.org/wiki/Merge_%28version_control%29#Three-way_merge)。

有关如何实现这些更改的实用示例，请参阅[此项目及样本代码](https://github.com/glynnbird/deconflict)。

## 上传新修订版
{: #upload-the-new-revision}

> 解决并合并来自先前冲突修订版的更改后的最终修订版。

```json
{
  "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "3-daaecd7213301a1ad5493186d6916755",
    "name": "Samsung Galaxy S4",
    "description": "Latest smartphone from Samsung",
    "price": 600
}
```

评估和解决冲突后，创建了包含明确的最新数据的文档。
这一全新文档将上传到数据库。

## 删除旧修订版
{: #delete-old-revisions}

> 用于删除旧修订版的示例请求。

```http
DELETE http://$ACCOUNT.cloudant.com/products/$_ID?rev=2-61ae00e029d4f5edd2981841243ded13

DELETE http://$ACCOUNT.cloudant.com/products/$_ID?rev=2-f796915a291b37254f6df8f6f3389121
```

最后一步是删除旧修订版。
为此，您将发送 `DELETE` 请求并指定要删除的修订版。

删除文档的较旧版本时，会将与该文档关联的冲突标记为已解决。
可以通过将 `conflicts` 参数设置为 true 来再次请求该文档，像以前一样使用[查找冲突](#finding-conflicts)，从而验证是否不再有任何冲突。
