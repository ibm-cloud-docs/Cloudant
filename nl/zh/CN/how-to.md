---

copyright:
  years: 2015, 2019
lastupdated: "2019-06-12"

keywords: tutorials, recovery and backup, guides, links to documentation

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

<!-- Acrolinx: 2018-11-08 -->

# 关于
{: #about}

教程、恢复与备份指示信息以及指南提供在 {{site.data.keyword.cloudantfull}} 中使用的基本和高级任务的相关信息。  

## 教程
{: #tutorials}

教程|描述
---------|-------------
[入门教程](/docs/services/Cloudant?topic=cloudant-getting-started#getting-started){: new_window} | 本教程描述如何使用 Python 创建 {{site.data.keyword.cloudant_short_notm}} 数据库，并使用简单的数据集合来填充该数据库。
[创建 {{site.data.keyword.cloudant_short_notm}} 实例](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud#creating-an-ibm-cloudant-instance-on-ibm-cloud){: new_window} | 本教程描述如何创建 {{site.data.keyword.cloudant_short_notm}} 服务实例，以及使用 {{site.data.keyword.cloud_notm}} 仪表板在哪里可以找到服务凭证。
[使用 {{site.data.keyword.cloud_notm}} CLI](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud-by-using-the-ibm-cloud-cli#creating-an-ibm-cloudant-instance-on-ibm-cloud-by-using-the-ibm-cloud-cli){: new_window} 创建 {{site.data.keyword.cloudant_short_notm}} 实例 | 本教程描述如何使用 {{site.data.keyword.cloud_notm}} CLI 在 {{site.data.keyword.cloud_notm}} 上创建 {{site.data.keyword.cloudant_short_notm}} 服务实例。
[创建和利用 {{site.data.keyword.cloudant_short_notm}} 专用硬件套餐实例](/docs/services/Cloudant?topic=cloudant-creating-and-leveraging-an-ibm-cloudant-dedicated-hardware-plan-instance-on-ibm-cloud#creating-and-leveraging-an-ibm-cloudant-dedicated-hardware-plan-instance-on-ibm-cloud){: new_window} | 本教程描述如何创建 {{site.data.keyword.cloudant_short_notm}} 专用硬件套餐实例，以及后续如何使用 {{site.data.keyword.cloud_notm}} 目录或 {{site.data.keyword.cloud_notm}} CLI 供应一个或多个标准套餐实例以在该实例上运行。
[创建和填充简单的 {{site.data.keyword.cloudant_short_notm}} 数据库](/docs/services/Cloudant?topic=cloudant-creating-and-populating-a-simple-ibm-cloudant-database-on-ibm-cloud#creating-and-populating-a-simple-ibm-cloudant-database-on-ibm-cloud){: new_window} | 本教程描述如何使用 Python 编程语言在您的 {{site.data.keyword.cloud_notm}} 服务实例上创建
{{site.data.keyword.cloudant_short_notm}} 数据库，并使用简单的数据集合填充该数据库。
[创建 {{site.data.keyword.cloudant_short_notm}} 查询](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-query#creating-an-ibm-cloudant-query){: new_window}|本教程描述如何创建数据库，使用文档填充数据库，创建索引以及使用索引来查询数据库。
[创建备份](/docs/services/Cloudant?topic=cloudant-creating-a-backup#creating-a-backup){: new_window} | 本教程描述如何使用 CouchBackup 命令行实用程序备份和复原 CouchDB 或者
{{site.data.keyword.cloudant_short_notm}} 实例。
[创建简单 {{site.data.keyword.cloud_notm}} 应用程序](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database){: new_window} | 本教程描述如何创建 {{site.data.keyword.cloud_notm}} 应用程序，以使用 Python 编程语言访问 {{site.data.keyword.cloud_notm}} 服务实例中托管的
{{site.data.keyword.cloudantfull}} 数据库。
[创建简单 {{site.data.keyword.cloud_notm}} 应用程序，以访问 {{site.data.keyword.cloudant_short_notm}} 数据库：先决条件](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-prerequisites#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-prerequisites){: new_window} |本教程描述了创建 {{site.data.keyword.cloud_notm}} 应用程序的先决条件。
[创建简单 {{site.data.keyword.cloud_notm}} 应用程序以访问 {{site.data.keyword.cloudant_short_notm}} 数据库：应用程序环境](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment){: new_window} |本教程描述如何设置在创建
{{site.data.keyword.cloud_notm}} 应用程序时必须拥有的应用程序环境。
[创建简单 {{site.data.keyword.cloud_notm}} 应用程序以访问 {{site.data.keyword.cloudant_short_notm}} 数据库：代码](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-code#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-code){: new_window} |本教程描述了 {{site.data.keyword.cloud_notm}} 应用程序的代码。
[创建简单 {{site.data.keyword.cloud_notm}} 应用程序以访问 {{site.data.keyword.cloudant_short_notm}} 数据库：上传应用程序](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-uploading-the-application#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-uploading-the-application){: new_window} |本教程描述了如何上传 {{site.data.keyword.cloud_notm}} 应用程序。
[创建简单 {{site.data.keyword.cloud_notm}} 应用程序以访问 {{site.data.keyword.cloudant_short_notm}} 数据库：维护和故障诊断](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-maintaining-and-troubleshooting#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-maintaining-and-troubleshooting){: new_window} |本教程描述了如何维护在 {{site.data.keyword.cloud_notm}} 服务实例中托管的 {{site.data.keyword.cloud_notm}} 应用程序。



## 恢复和备份
{: #recovery-and-backup}

指南|描述
------|------------
[灾难恢复和备份](/docs/services/Cloudant?topic=cloudant-disaster-recovery-and-backup#disaster-recovery-and-backup){: new_window} | {{site.data.keyword.cloudant_short_notm}} 提供的自动功能和支持的工具的概述。
[配置 {{site.data.keyword.cloudant_short_notm}} 用于跨区域灾难恢复](/docs/services/Cloudant?topic=cloudant-configuring-ibm-cloudant-for-cross-region-disaster-recovery#configuring-ibm-cloudant-for-cross-region-disaster-recovery){: new_window} |本指南介绍了启用灾难恢复的一种方法，即使用
{{site.data.keyword.cloudant_short_notm}} 进行 {{site.data.keyword.cloud_notm}} 复制，以跨区域创建冗余。
[{{site.data.keyword.cloudant_short_notm}} 备份和恢复](/docs/services/Cloudant?topic=cloudant-ibm-cloudant-backup-and-recovery#ibm-cloudant-backup-and-recovery){: new_window} |本指南描述如何使用备份和恢复工具 CouchBackup。


## 指南
{: #guides}

指南|描述
------|------------
[授权的 curl：acurl](/docs/services/Cloudant?topic=cloudant-authorized-curl-acurl-#authorized-curl-acurl-){: new_window} |本指南用于设置 `acurl`，以便您不再需要输入用户名和密码。
[CAP 定理](/docs/services/Cloudant?topic=cloudant-cap-theorem#cap-theorem){: new_window} |本指南描述“最终一致性”模型。
[冲突](/docs/services/Cloudant?topic=cloudant-conflicts#conflicts){: new_window} | 本指南描述如何查找和解决冲突。
[CouchApp](/docs/services/Cloudant?topic=cloudant-couchapps#couchapps){: new_window} | 本指南描述哪些内容构成 CouchApp。
[数据库分区](/docs/services/Cloudant?topic=cloudant-database-partitioning#database-partitioning) | 本指南描述分区数据库及其使用方法。
[设计文档管理](/docs/services/Cloudant?topic=cloudant-design-document-management#design-document-management){: new_window} |本指南描述什么是设计文档以及如何在 {{site.data.keyword.cloudant_short_notm}} 中使用设计文档。
[文档版本控制和 MVCC](/docs/services/Cloudant?topic=cloudant-document-versioning-and-mvcc#document-versioning-and-mvcc){: new_window} |本指南描述多版本并行控制 (MVCC) 及其如何用于 {{site.data.keyword.cloudant_short_notm}} 数据库，以确保数据库集群中的所有节点仅包含最新版本的文档。
[对数据建模以进行缩放的五项建议](/docs/services/Cloudant?topic=cloudant-five-tips-for-modeling-your-data-to-scale#five-tips-for-modeling-your-data-to-scale){: new_window} |本指南更细致地讨论了如何对应用程序数据建模，以使应用程序能够大规模高效运作。

[在 {{site.data.keyword.cloudant_short_notm}} 中将相关文档分组在一起](/docs/services/Cloudant?topic=cloudant-grouping-related-documents-together-in-ibm-cloudant#grouping-related-documents-together-in-ibm-cloudant){: new_window} |本指南概述了构建电子商务系统所涉及的一些因素，该系统通过使用适用于其他许多领域的概念来利用 {{site.data.keyword.cloudant_short_notm}} 的优势。
[{{site.data.keyword.cloudant_short_notm}} 如何使用 {{site.data.keyword.cloud_notm}} 资源组？](/docs/services/Cloudant?topic=cloudant-how-does-ibm-cloudant-work-with-ibm-cloud-resource-groups-#how-does-ibm-cloudant-work-with-ibm-cloud-resource-groups-){: new_window} |本指南涵盖 {{site.data.keyword.cloudant_short_notm}} 支持收到的有关此转换的常见问题。
[如何在 {{site.data.keyword.cloudant_short_notm}} 中存储数据？](/docs/services/Cloudant?topic=cloudant-how-is-data-stored-in-ibm-cloudant-#how-is-data-stored-in-ibm-cloudant-){: new_window} |本指南描述 {{site.data.keyword.cloudant_short_notm}} 中的分片及其运作方式。
[IBM Cloud Identity and Access Management (IAM)](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-){: new_window} |本指南描述了 {{site.data.keyword.cloudant_short_notm}} 与 {{site.data.keyword.cloud_notm}} Identity and Access Management 的集成。
[JSON](/docs/services/Cloudant?topic=cloudant-json#json){: new_window} |本指南描述了 {{site.data.keyword.cloudant_short_notm}} 如何使用 JavaScript 对象表示法 (JSON) 来对数据和响应的内容和结构设置格式。
[管理任务](/docs/services/Cloudant?topic=cloudant-managing-tasks#managing-tasks){: new_window} |本指南描述如何管理任务是否在进行中，或者任务是否完成。
[迁移到 {{site.data.keyword.cloudant_short_notm}}](/docs/services/Cloudant?topic=cloudant-migrating-to-ibm-cloudant-on-ibm-cloud#migrating-to-ibm-cloudant-on-ibm-cloud){: new_window} |本指南描述如何迁移到 {{site.data.keyword.cloud_notm}} 上的 {{site.data.keyword.cloudant_short_notm}} 轻量套餐或标准套餐实例。
[复制指南](/docs/services/Cloudant?topic=cloudant-replication-guide#replication-guide){: new_window} |本指南介绍了 {{site.data.keyword.cloudant_short_notm}} 的复制功能，讨论了常见的用例，并说明了如何使应用程序能够成功复制。
[复制递增](/docs/services/Cloudant?topic=cloudant-replication-incrementals#replication-incrementals){: new_window} |本指南描述了如何创建和复原增量备份。

 

