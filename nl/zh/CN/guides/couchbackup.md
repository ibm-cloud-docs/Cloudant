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

<!-- Acrolinx: 2017-05-02 -->

# 使用 CouchBackup 备份数据

{{site.data.keyword.cloudant}} 的分布式特性提供了一种固有的数据备份形式。
CouchBackup 是一种命令行工具，让您以更强大、更灵活的方式来备份数据。
{:shortdesc}

## 概述

{{site.data.keyword.cloudant_short_notm}} 的分布式优点是通过集群实现的。在集群中，数据库内的数据存储为多个副本。这些副本分布在至少三个独立的物理服务器上。通过对数据存储使用集群，{{site.data.keyword.cloudant_short_notm}} 具备了固有的高可用性 (HA) 和灾难恢复 (DR) 特征。使用集群有助于 {{site.data.keyword.cloudant_short_notm}} 容许集群中的节点丢失，而不会丢失数据。

但是，即便具有这些 HA 和 DR 特性，在其他一些用例中，您还可能希望增强数据备份。

<div id="activepassive"></div>

### 数据中心中断和灾难恢复

集群之间的[持续复制](../api/replication.html#continuous-replication) 是针对 {{site.data.keyword.cloudant_short_notm}} 集群不完全可用问题的良好解决方案。持续复制是“主动/被动”模型。此模型的“主动”部分是持续复制。模型的“被动”部分确认副本在正常情况下不用于响应来自应用程序的请求，而是主要用作原始数据库的克隆。如有必要，可以访问克隆中的数据。或者，可以使用[复制](../api/replication.html)在其他某个位置复原克隆中的数据。

>	**注：**通过从克隆进行复制来复原大型数据库可能需要很长时间。

### 高可用性、自动故障转移和地理负载均衡

[“主动/被动”](#activepassive)方法的一种替代方法是配置两个数据中心来使用“主动/主动”模型。

在此模型中，对集群 A 中的数据库进行的任何更改都会复制到集群 B 中的数据库。同样，对集群 B 中的数据库进行的任何更改也都会复制到集群 A 中的数据库。

>	**注：**可以使用 {{site.data.keyword.cloudant_short_notm}}“仪表板”来设置此模型。这无需 {{site.data.keyword.cloudant_short_notm}} 支持人员进行操作。



实施此模型后，可以将数据库应用程序设计为在满足某些可用性条件时“故障转移”到其中一个集群。您可以在应用程序设计过程中定义可用性条件。

还可以在应用程序设计中包含地理“负载均衡”。例如，在一个地理区域中使用的客户端应用程序访问存储在“邻近”地理区域的集群内的数据时，通常该应用程序的性能应该会更好。将客户端应用程序设计为确定“最近的”集群并连接到该集群进行数据库查询，将有助于提高应用程序的性能。

[此处 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](http://www.ibm.com/developerworks/cloud/library/cl-multi-region-bluemix-apps-with-cloudant-and-dyn-trs/index.html){:new_window} 提供了说明如何设置多区域应用程序环境的教程。

### 意外或恶意数据修改

{{site.data.keyword.cloudant_short_notm}} 未提供用于创建数据库快照的机制。如果需要这种功能（例如，为了方便在文档级别回滚到上一个已知状态），那么可以通过以下两种方式之一来达到相同的效果：

1.	使用复制。通过复制数据库来执行此操作。确保记录最终的序列标识。根据确定的安排，将数据库复制到新数据库。从最后一个记录的序列标识开始复制。通过保留复制的序列标识，可以达到累积机制的效果。结果将类似于通过“每日”快照创建常规“每周”快照。此方法的限制是它还会复制已删除的（即“墓碑”）文档修订版以及未解决的冲突。

2.	将数据库内容转储到文件。有各种工具可用于将数据库内容转储到文件。生成的转储文件可以存储在较便宜的面向块的设备或服务上。这种方法的限制是它通常仅转储当前文档修订版，这意味着不会包含未解决的冲突。

创建数据库转储是支持各种备份解决方案的有效方式。因此，其余部分的讨论将侧重于此方法。

<!--
https://developer.ibm.com/clouddataservices/2016/03/22/simple-couchdb-and-cloudant-backup/

A useful approach is to have couchbackup's snapshots placed on the Bluemix Object Storage service, as described here:

https://developer.ibm.com/recipes/tutorials/object-storage-cloudant-backup/
-->
