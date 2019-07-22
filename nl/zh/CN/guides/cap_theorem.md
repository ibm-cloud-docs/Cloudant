---

copyright:
  years: 2015, 2019
lastupdated: "2019-06-12"

keywords: tradeoffs in partition tolerance, change approach to data, availability, consistency, theory

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

<!-- Acrolinx: 2017-01-24 -->

# CAP 定理
{: #cap-theorem}

{{site.data.keyword.cloudantfull}} 使用的是[“最终一致性”![外部链接图标](../images/launch-glyph.svg "外部链接图标")](http://en.wikipedia.org/wiki/Eventual_consistency){: new_window} 模型。
{: shortdesc}

要了解此模型如何工作以及为什么此模型是使用 {{site.data.keyword.cloudant_short_notm}} 时必不可少的一部分，请考虑一致性的含义。

在数据库中可靠地处理并报告事务需要[“ACID”![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://en.wikipedia.org/wiki/ACID){: new_window} 这四个属性，一致性是其中之一。

此外，一致性还是
<a href="http://en.wikipedia.org/wiki/CAP_Theorem" target="_blank">“CAP”<img src="../images/launch-glyph.svg" alt="外部链接图标" title="外部链接图标"></a> 定理中的三个属性之一。这三个属性是指 **C**（一致性）、**A**（可用性）和 **P**（分区容错性）。此定理指出，分布式计算机系统（如 {{site.data.keyword.cloudant_short_notm}}）无法_同时_保证这三个属性：

-   一致性 - 所有节点在同一时间看到相同的数据。
-   可用性 - 保证每个请求都收到有关成功还是失败的响应。
-   分区容错性 - 即便系统的任一部分丢失或发生故障，系统也能继续运行。

无法同时保证所有这三个属性意味着 {{site.data.keyword.cloudant_short_notm}} 无法保证“一致性”属性。在最终一致性模型（如 {{site.data.keyword.cloudant_short_notm}}）中，对系统一个部分的更新_最终_会被系统的其他部分看到。随着更新的传播，系统应该会“汇合”，最终达到完全一致性。

最终一致性对性能十分有益。对于强一致性模型，系统必须等待所有更新成功传播完成后，才能完成写入或更新请求。对于最终一致性模型，写入或更新请求几乎可以立即返回，而在整个系统上的传播工作在后台继续执行。

出于理论性和实用性的原因，一个数据库只能表现出这三个属性中的两个。一致性和可用性优先的数据库很简单：单个节点存储数据的单个副本。但是，这种模型很难缩放，因为要提高性能，必须升级节点，而不是使用额外的节点。此外，即便不严重的系统故障也可能导致单节点系统关闭，而任何消息的丢失都意味着重大数据丢失。要具备耐受力，系统必须变得更加复杂。

## 分区容错性的权衡
{: #tradeoffs-in-partition-tolerance}

一致性和分区容错性优先的数据库通常采用
<a href="http://en.wikipedia.org/wiki/Master/slave_(technology)" target="_blank">主/从 <img src="../images/launch-glyph.svg" alt="外部链接图标" title="外部链接图标"></a> 设置，在这种设置中，系统有许多节点，其中一个节点被选作主节点。只有主节点可以核准数据写操作，而所有辅助节点从主节点复制数据来处理读操作。如果主节点失去与网络的连接，或无法与系统的许多节点通信，那么剩余节点会选出新的主节点。这种选择过程因系统而异，并且可能是导致[严重问题 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](http://aphyr.com/posts/284-call-me-maybe-mongodb){: new_window} 的根源。



{{site.data.keyword.cloudant_short_notm}} 通过采用主/主设置来优先考虑可用性和分区容错性，以便每个节点都可以接受对分配到该节点的部分数据的读写操作。多个节点包含每个数据部分的副本。每个节点都会复制其他节点的数据。如果某个节点变得不可访问，那么在网络修复期间，其他节点可以接替该节点的工作。这样，无论任意节点发生故障，系统也能及时返回数据，并保持[最终一致性 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](http://en.wikipedia.org/wiki/Eventual_consistency){: new_window}。在取消绝对一致性优先的权衡中，所有节点都需要一定时间才能看到相同的数据。因此，在新数据通过系统传播期间，某些响应可能包含旧数据。

## 改变方法
{: #changing-the-approach}

维护一个一致的数据视图不仅合乎逻辑，而且很容易理解，因为关系数据库会为您完成此工作。期望的情况是，与数据库系统交互的基于 Web 的服务以这种方式运行。但是，这种期望并不意味着这些服务会照此行事。一致性并不是理所当然的，需要一些工作来改变方法。

事实上，对于许多企业云服务而言，一致性不一定是基本要素。对于使用率极高的大型系统，系统中某个部分可能会发生故障的概率也很高。围绕可用性和最终一致性优先需求而设计的数据库更适合使应用程序保持联机状态。应用程序数据的一致性可以在该事实之后解决。正如麻省理工学院的 Seth Gilbert 和 Nancy Lynchs 所得出的[结论 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](http://www.glassbeam.com/sites/all/themes/glassbeam/images/blog/10.1.1.67.6951.pdf){: new_window}那样：“当今现实世界中的大多数系统别无选择，只得接受‘在大多数时间返回大部分数据’的做法。”

## 企业中的应用程序可用性与一致性
{: #application-availability-versus-consistency-in-the-enterprise}

综观各种常用的基于 Web 的服务，从中可以看出人们已经认定具备了高可用性，并且乐意牺牲这一可用性来换取最终一致性数据，而且往往并没有意识到自己在这样做。

许多应用程序会在可用性方面误导用户。以 ATM 为例：不一致的银行数据是导致仍可以在不知情的情况下透支提款的原因。如果网络中的每个节点都必须先暂停并记录帐户余额数字，然后操作才能继续，那么在整个银行系统中显示一致的帐户余额视图是不切实际的。因此，最好是使系统保持高可用性。

银行业早在 20 世纪 80 年代就已明白这一点，但许多 IT 组织现在都还在担心牺牲一致性来实现可用性。想想看，一旦您的销售团队无法访问自己的 CRM 应用程序，会给支持人员打多少电话！现在，再想想他们是否会注意到一个数据库更新花费了几秒钟在整个应用程序中传播。

可用性优先于一致性，超乎您的想像。更多的例子有：在线购物车系统、HTTP 高速缓存和 DNS。组织必须考虑停机时间的成本，例如用户不满、生产率损失和错失商机。

## 从理论到实施
{: #from-theory-to-implementation}

解决高可用性对于云应用程序至关重要。否则，在执行缩放时，全球数据库一致性将始终是一个主要瓶颈。高可用性应用程序需要保持与其数据的持续联系，即便这些数据不是最新的。这就是最终一致性的概念，没什么好害怕的。在规模很大的情况下，有时候提供不完全准确的答案胜过完全没有答案。

数据库系统以不同方式掩盖了可用性相较于一致性的复杂性，但它们始终存在。{{site.data.keyword.cloudant_short_notm}} 数据库即服务以及 CouchDB 和其他 NoSQL 数据库所采用的观点是，最好要求开发者在设计过程中尽早解决这些复杂性。首先处理这一困难的工作，可以减少意外情况，因为应用程序从一开始就已做好缩放准备。
