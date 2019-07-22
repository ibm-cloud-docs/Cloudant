---

copyright:
  years: 2015, 2019
lastupdated: "2019-06-12"

keywords: immutable data, pre-calculate results, de-normalise data, avoid conflicts, conflict resolution

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

# 对数据建模以进行缩放的五项建议
{: #five-tips-for-modeling-your-data-to-scale}

本文更细致地讨论了如何对应用程序数据建模，以使应用程序能够大规模高效运作。
{: shortdesc}

*（本指南基于 Mike Rhodes 的博客文章：[My Top 5 Tips for Modeling Data to Scale ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://cloudant.com/blog/my-top-5-tips-for-modeling-your-data-to-scale/)，最初发布于 2013 年 12 月 17 日。）*

{{site.data.keyword.cloudantfull}} 上的数据建模方式将显著影响应用程序能够如何缩放。我们的底层数据模型与关系模型有很大差异，忽略这种差异可能是导致日后发生性能问题的原因。

一如既往地，成功建模需要在易用性与您希望实现的性能特征之间达到平衡。

闲话少说，下面我们切入正题。

## 考虑不可变数据
{: #consider-immutable-data}

如果要以每秒一次或更高的速率更改文档的同一状态，请考虑使文档不可变。这将大大降低创建冲突文档的机会。

反过来说，如果要以低于每 10 秒一次的速率更新给定的文档，那么原地更新数据模型（即更新现有文档）将大大简化应用程序代码。

通常，基于不可变数据的数据模型需要使用视图来汇总构成当前状态的文档。由于视图是预先计算的，因此应该不会对应用程序性能产生负面影响。

## 考虑不可变数据的优点 
{: #why-this-helps-you-consider-immutable-data}

我们的 `https://$ACCOUNT.cloudant.com/` 界面基于分布式数据库。在集群内，文档存储在若干分片中，这些分片共同构成了数据库。随后，这些分片在集群中的各个节点之间分布。通过这一机制，我们可以支持大小高达很多太字节的数据库。

缺省情况下，不仅会将数据库分割成分片，而且所有分片都有三个副本，即分片副本，每个副本位于数据库集群的不同节点上。这样一来，如果某个节点发生故障，数据库仍能继续处理请求。因此，保存文档需要写入三个节点。这意味着，如果对同一文档并行进行两个更新，那么有可能一部分节点接受了第一个更新，而另一部分节点接受了第二个更新。集群发现此差异时，将按照常规复制通过创建冲突来处理并行更新的相同方式组合这些文档。

冲突文档会损害性能；请参阅以下文本以了解有关为何会发生这种情况的更多详细信息。高度并行的原地更新模式还会增加写操作被拒绝的可能性，因为 `_rev` 参数不是所需的参数，这将强制应用程序重试，从而延迟处理。

我们发现，对于速率高于每秒一次的更新，发生这种冲突文档场景的可能性明显更高，但为了安全起见，对于速率高于每 10 秒一次的更新，建议使用不可变文档。

## 使用视图来预先计算结果，而不将视图作为搜索索引
{: #use-views-to-pre-calculate-results-rather-than-as-search-indexes}

尝试使数据库为您执行工作，而不是将视图用作受到吹捧的搜索索引（例如，“获取所有`个人`文档”）。例如，通过 `_sum` 内置的 reduce，使用带有组合键的视图来按年、月、日、半天和小时预先计算一万人的合并工作小时数，而不是检索这一万人的所有个人文档来进行计算。您将减省应用程序中的工作，并允许数据库专注于处理许多小型请求，而不是从磁盘读取巨量数据来处理单个大型请求。

## 使用视图来预先计算结果的优点
{: #why-this-helps-you-use-views-to-pre-calculate-results}

这其实是显而易见的。首先，请注意，map 和 reduce 都是预先计算的。这意味着，请求 reduce 函数的结果是一个成本低廉的操作，尤其是相较于从磁盘存储器流式传送几百个甚至几千个文档所需的大量 IO 而言。

在较低级别上，当节点收到视图请求时，会向保存有视图数据库的分片副本的节点发出请求，以从每个分片中的文档获取该视图请求的结果。处理视图请求的节点在收到应答（首先接收每个分片副本的应答）后，会将这些结果组合起来，然后将最终结果流式传送到客户端。随着涉及的文档越来越多，每个副本从磁盘和在整个网络上流式传送结果所需的时间也越来越长。此外，处理请求的节点在组合来自每个数据库分片的结果时，工作量也开始激增。

总的来说，目标是使视图请求在每个分片中需要的数据量尽可能少，从而尽可能缩短传输并组合数据以构成最终结果所需的时间。使用视图的强大功能来预先计算汇总数据是实现此目标的一种方式。这将明显缩短应用程序等待请求完成所用时间。

## 对数据去规范化
{: #de-normalise-your-data}

在关系数据库中，对数据规范化通常是存储数据的最高效方式。在可以使用 JOIN 轻松组合多个表中的数据的情况下，这样做非常适合。在 {{site.data.keyword.cloudant_short_notm}} 中，您更有可能需要对每个数据块发出 HTTP GET 请求，所以减少构建已建模实体全貌所需的请求数，能让您更快地向用户显示信息。

通过使用视图，您可以获得对数据规范化的许多优点，同时保留去规范化版本以提高效率。

例如，在关系模式中，您通常会在单独的表中表示标记，并使用连接表将标记与其关联的文档连接在一起，从而允许快速查找带有给定标记的所有文档。

在 {{site.data.keyword.cloudant_short_notm}} 中，您会将标记存储在每个文档内的列表中。然后，您会使用视图通过[在视图的 map 函数中将每个标记作为键发出](/docs/services/Cloudant?topic=cloudant-views-mapreduce#views-mapreduce)来获取带有给定标记的文档。接着，查询给定键的视图将提供带有该标记的所有文档。

## 对数据去规范化的优点
{: #why-this-helps-you-de-normalize-your-data}

最关键的是应用程序发出的 HTTP 请求数。打开 HTTP 连接（尤其是 HTTPS）会产生开销，虽然复用连接会有所帮助，但总体而言，减少请求数将加快应用程序处理数据的速率。

对文档去规范化和预先计算的视图还会带来额外的好处，即通常可以提前生成应用程序所需的值，而不是在查询时动态构建值。

## 使用更细颗粒度文档来避免冲突
{: #avoid-conflicts-by-using-finer-grained-documents}

下一个建议与对数据去规范化的建议有些矛盾：使用细颗粒度文档来减少并行修改会产生冲突的机会。这有点像对数据规范化。减少 HTTP 请求数和避免冲突之间须达到平衡。

以包含手术列表的医疗记录为例：

```json
{
    "_id": "Joe McIllness",
    "operations": [
        { "surgery": "heart bypass" },
        { "surgery": "lumbar puncture" }
    ]
}
```
{: codeblock}

如果 Joe 很不幸，同时有大量手术要做，那么对一个文档进行大量并行更新有可能会创建冲突文档，如前所述。最好的办法是将这些手术分列到不同的文档，这些文档都引用 Joe 的个人文档，并使用视图将内容连接在一起。为了表示每个手术，您将上传类似以下两个示例的文档：

```json
{
    "type": "operation",
    "patient": "Joe McIllness",
    "surgery": "heart bypass"
}
```
{: codeblock}

```json
{
    "type": "operation",
    "patient": "Joe McIllness",
    "surgery": "lumbar puncture"
}
```
{: codeblock}

通过将 `"patient"` 字段作为视图中的键发出，就可以查询给定患者的所有手术。同样，视图用于帮助根据不同文档拼出给定实体的全貌，这有助于使 HTTP 请求数保持在较低水平，尽管我们已分割单个已建模实体的数据。

## 避免冲突的优点
{: #why-this-helps-you-avoid-conflicts}

避免冲突文档有助于加快对 {{site.data.keyword.cloudant_short_notm}} 数据库执行的许多操作。这是因为有一个过程会运算出每次读取文档时使用的当前获胜修订版：检索单个文档、使用 `include_docs=true` 进行调用、视图构建，等等。

获胜修订版是文档总体树中的特定修订版。回想一下，{{site.data.keyword.cloudant_short_notm}} 上的文档实际上是修订版树。对文档发出请求时，任意但确定性算法将选择此树的其中一个未删除的叶。处理分支因子较高的更大型树所需时间比没有分支或分支极少的文档树更长：需要遍历每个分支，以查看它是否有可能成为获胜修订版。然后，潜在的胜利者需要相互进行比较，以做出最终选择。

{{site.data.keyword.cloudant_short_notm}} 显然能够很好地处理少量分支（毕竟，复制得以开展的前提条件是文档可以分支以避免废弃数据），但如果分支级别多得难以想象，尤其是在冲突未解决的情况下，遍历文档树会变得非常耗时，而且会占用大量内存。

## 构建冲突解决方法
{: #build-in-conflict-resolution}

在像 {{site.data.keyword.cloudant_short_notm}} 这样的最终一致性系统中，冲突最终会发生。如前所述，这是实现可伸缩性和数据弹性要付出的代价。

将数据的结构设计为无需操作员协助即可快速解决冲突，有助于使数据库保持顺利运行。无需用户参与而自动解决冲突的能力也将大大改善用户体验，并有望减轻您的组织的支持工作负担。

执行此操作的特定方式与应用程序密切相关，但下面提供了几点建议：

-   尽可能避免在文档字段中使用不变量。这能使简单合并操作（从每个冲突文档修订版中获取更改的字段）适用的可能性更高。这样一来，应用程序代码会更简单、更稳健。
-   允许文档彼此独立。如果需要检索其他文档来得出正确解决方法，将增加冲突解决的等待时间。还有可能您会遇到其他文档的版本与要解决的文档不一致的情况，从而难以正确解决。此外，万一其他文档也是有冲突的呢？

## 构建冲突解决方法的优点 
{: #why-this-helps-you-build-in-conflict-resolution}

如前所述，严重冲突的文档对数据库会造成严重损害。从一开始就构建冲突解决能力，非常有助于避免产生严重冲突的文档。

## 摘要
{: #summary}

上述建议说明了数据建模会影响应用程序性能的一些情况。{{site.data.keyword.cloudant_short_notm}} 的数据存储有一些特定的特性，既要小心提防也要加以利用，这样才能确保数据库性能随着应用程序的增长而缩放。我们理解，转换过程可能令人困惑，所以我们随时愿意提供建议。

有关进一步的阅读材料，请参阅有关 [Foundbite 的数据模型 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://cloudant.com/blog/foundbites-data-model-relational-db-vs-nosql-on-cloudant/){: new_window} 的此讨论或 [Twilio 上来自我们朋友的此示例 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://www.twilio.com/blog/2013/01/building-a-real-time-sms-voting-app-part-3-scaling-node-js-and-couchdb.html){: new_window}。

