---

copyright:
  years: 2015, 2019
lastupdated: "2019-03-18"

keywords: curl and jq basics, monitor view builds and search indexes, estimate time to complete task, monitor replication, troubleshooting

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

<!-- Acrolinx: 2018-08-14 -->

# 迁移到 {{site.data.keyword.cloud_notm}} 上的 {{site.data.keyword.cloudant_short_notm}}
{: #migrating-to-ibm-cloudant-on-ibm-cloud}

[{{site.data.keyword.cloudantfull}}](https://www.ibm.com/cloud/cloudant) 的“数据库即服务”产品是在多租户集群上运行的 JSON 文档库。该服务提供了具有可预测成本、可伸缩性和服务级别协议 (SLA) 的地理位置供您选择。

本文档描述了如何从下列其中一个套餐迁移到 {{site.data.keyword.cloud_notm}} 上的 {{site.data.keyword.cloudant_short_notm}} 轻量套餐或标准套餐实例：

套餐|描述
-----|------------
{{site.data.keyword.cloudant_short_notm}} 企业套餐|专用单租户集群
{{site.data.keyword.cloudant_short_notm}} 共享套餐|旧的现收现付多租户 {{site.data.keyword.cloudant_short_notm}} 服务。`cloudant.com` 共享套餐已于 2018 年 3 月引退。{{site.data.keyword.cloudant_short_notm}} 共享套餐于 2016 年 10 月起就已不推荐用于新注册，并将于 2018 年第四季度引退。
{{site.data.keyword.cloudant_localfull}} |{{site.data.keyword.cloudant_short_notm}} 的自托管打包安装。
Apache CouchDB|{{site.data.keyword.cloudant_short_notm}} 基于的自托管开放式源代码数据库。

## {{site.data.keyword.cloudant_short_notm}} 轻量套餐和标准套餐有什么优点？
{: #what-are-the-benefits-of-the-ibm-cloudant-lite-and-standard-plans-}

标准套餐允许您针对数据库服务*保留吞吐量容量*，即，指定应用程序的数据库将需要多少吞吐量来处理需求。标准套餐还会针对您使用的存储量收费。容量通过以下度量值进行度量：

度量值|描述
-------|------------
每秒读取次数|执行简单文档访存的速率，例如通过文档的 `_id` 检索文档，或者使用分区键查询分区数据库。
每秒写入次数|数据写入数据库的速率。用于处理文档创建、更新或删除的 API 调用视为“写入”。
每秒全局查询次数|使用全局索引查询数据库的速率，通常通过访问 `_find` 端点或通过使用辅助 MapReduce、搜索或地理空间索引来执行查询。
存储空间|JSON 数据、附件和辅助索引占用的磁盘空间量。

例如，轻量套餐免费提供 20 次读取/秒、10 次写入/秒、5 次全局查询/秒以及 1 GB 存储空间。如果您“首次尝试”使用产品以及处于产品开发过程中，那么此套餐是理想的选择。应用程序进入 QA 或生产环境时，请切换到标准套餐以缩放实例。标准套餐的最小容量提供 100 次读取/秒、50 次写入/秒、5 次全局查询/秒以及 20 GB 存储空间（额外存储空间按 GB 收费），每月约 76.65 美元。 

通过使用 {{site.data.keyword.cloudant_short_notm}}“仪表板”中的滑块，可以在需要时随时为 {{site.data.keyword.cloudant_short_notm}} 服务保留更小或更大的容量：

![滑块](../images/migrate2.gif)

可以更改的吞吐量容量限制为每次更改最多 10 个单位（请注意滑块上的“更改限制”点），并且每小时最多更改一次。减少吞吐量容量的量级不受限制，但时间上仍限制为每小时最多更改一次。
{: tip}

系统将根据在任何给定的每小时窗口中选择的最高容量对您计费。数据库吞吐量可以扩展以处理季节性需求，然后在静默期再次缩减。您的每月帐单总是可预测的；升级会自动执行；并且您的 SLA 为 [99.95%](http://www-03.ibm.com/software/sla/sladb.nsf/sla/bm?OpenDocument)。

如果在给定一秒内超过读取次数、写入次数和全局查询次数的配额，那么 {{site.data.keyword.cloudant_short_notm}} API 会使用 `HTTP 429 太多请求`响应进行响应。应用程序可能会稍后重试该请求 - 我们的官方库提供了一个选项，可用于在指数退避的情况下重试此类请求。 

## 我的 {{site.data.keyword.cloudant_short_notm}} 套餐是哪种类型？
{: #which-type-of-ibm-cloudant-plan-do-i-have-}

如果您使用的是 {{site.data.keyword.cloudant_short_notm}}，请转至 {{site.data.keyword.cloud_notm}} 仪表板，单击**菜单**图标 > **资源清单**以查看所有服务实例。 

![云仪表板](../images/ibmclouddashboard.png)

您还可以向下钻取到特定实例，并查看“套餐”选项卡以获取更多信息。不推荐的共享套餐上的 {{site.data.keyword.cloudant_short_notm}} 实例没有突出显示的套餐。{{site.data.keyword.cloudant_short_notm}} 标准套餐上的实例类似于以下示例： 

![标准套餐仪表板](../images/ibmcloud_instance_standard_plan.png)

您还可以打开 {{site.data.keyword.cloudant_short_notm}}“仪表板”，然后单击**帐户**选项卡。轻量套餐类似于以下示例：

![轻量套餐](../images/migrate1.png)

如果您使用的是旧 `cloudant.com` 帐户，那么可以登录到 {{site.data.keyword.cloudant_short_notm}}“仪表板”，然后转至“帐户”选项卡。旧 `cloudant.com` 共享套餐具有“使用情况”选项卡，其中包含当前月份的图形和计费估计值，如以下示例所示：

![共享套餐](../images/cloudantcom_sharedplan_usage.png)

对于专用集群上的 `cloudant.com` 企业套餐用户，其“帐户”选项卡上没有“使用情况”选项卡。“帐户”选项卡类似于以下示例：

![企业套餐](../images/cloudantcom_enterpriseplan_account.png)

如果“帐户”选项卡已指示您使用的是“标准”套餐，那么无需再进一步阅读任何内容。这说明您已经位于 SLA 支持的付费 {{site.data.keyword.cloudant_short_notm}} 服务上。无需进一步操作。

## 从 {{site.data.keyword.cloudant_short_notm}} 轻量套餐迁移到 {{site.data.keyword.cloudant_short_notm}} 标准套餐
{: #migrating-from-ibm-cloudant-lite-to-ibm-cloudant-standard}

通过执行以下步骤，从免费轻量套餐迁移到标准套餐： 

1.  转至 {{site.data.keyword.cloud_notm}}“仪表板”。
2.  转至**菜单**资源 > **资源列表**以查看所有服务实例。 
3.  选择要迁移的 {{site.data.keyword.cloudant_short_notm}} 实例。 
4.  选择左侧导航中的**套餐**选项卡。 
5.  从价格套餐列表中，选中**标准**复选框。
![轻量](../images/migrate3.png)
6.  单击页面底部的**升级**。您的所有现有数据都会保留。

使用“吞吐量容量”滑块来调整容量，以根据需要增加或减少容量。
{: tip} 
 
现在，准备工作已就绪！

## 将其他一切内容迁移到 {{site.data.keyword.cloudant_short_notm}} 轻量套餐或标准套餐
{: #migrating-everything-else-to-ibm-cloudant-lite-or-standard-plan}

从共享套餐或企业套餐迁移到 {{site.data.keyword.cloudant_short_notm}} 轻量套餐或标准套餐的操作，包含以下步骤中所述的任务。 

不能直接从共享套餐实例切换到轻量套餐或标准套餐实例。迁移需要您创建新的轻量套餐或标准套餐实例，然后从共享套餐实例复制数据。
{: tip}

### 第 1 步：注册 {{site.data.keyword.cloud_notm}}
{: #step-1-sign-up-for-ibm-cloud}

如果尚未注册，请[注册 {{site.data.keyword.cloud_notm}} 帐户](https://www.ibm.com/cloud/)。 

### 第 2 步：创建 {{site.data.keyword.cloudant_short_notm}} 实例
{: #step-2-create-an-ibm-cloudant-instance}

登录到 {{site.data.keyword.cloud_notm}} 帐户后，请添加 {{site.data.keyword.cloudant_short_notm}} 服务。单击仪表板上的`创建资源`按钮，然后单击`数据库`和 `Cloudant`。有关更多信息，请参阅[如何在 {{site.data.keyword.cloud_notm}} 上创建 {{site.data.keyword.cloudant_short_notm}} 实例](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud#creating-an-ibm-cloudant-instance-on-ibm-cloud)。 

![添加 {{site.data.keyword.cloudant_short_notm}} 实例](/docs/services/Cloudant/tutorials/images/img0003.png)

### 第 3 步：了解应用程序是否已准备好用于 {{site.data.keyword.cloudant_short_notm}}
{: #step-3-find-out-whether-your-application-is-ready-for-ibm-cloudant}

如果要从 {{site.data.keyword.cloudant_short_notm}} 企业服务或 {{site.data.keyword.cloudant_short_notm}} 共享套餐移动，那么必须重新访问应用程序的 {{site.data.keyword.cloudant_short_notm}} 使用情况，以确保它已准备好处理标准套餐的容量限制。有关更多信息，请参阅[ {{site.data.keyword.cloudant_short_notm}} API 的工作方式](/docs/services/Cloudant?topic=cloudant-ibm-cloud-public#provisioned-throughput-capacity)。最重要的是，必须确保在超出所供应的吞吐量容量时，应用程序可以处理 HTTP 响应：`429：请求太多`。 

对于偶然发生的超过套餐容量的流量峰值，重试获得 `429` 响应的请求是可接受的。如果应用程序流量经常生成 `429` 响应，那么您很可能需要升级到更大的套餐。

此外，值得注意的是，{{site.data.keyword.cloudant_short_notm}} 上的最大单个文档大小为 1 MB，如果超出此限制，您将收到 `413：请求实体太大`消息。有关更多信息，请参阅[请求和文档大小限制](/docs/services/Cloudant?topic=cloudant-ibm-cloud-public#request-and-document-size-limits)。 

### 第 4 步：将旧服务中的数据迁移到新服务 
{: #step-4-migrate-data-from-the-old-service-to-the-new-service}

设置从现有服务到 {{site.data.keyword.cloudant_short_notm}} 帐户的连续复制。有关更多信息，请参阅[复制指南](/docs/services/Cloudant?topic=cloudant-replication-api#replication-api)和 [API 文档](/docs/services/Cloudant?topic=cloudant-ibm-cloudant-basics#ibm-cloudant-basics)中关于如何设置和监视复制任务的内容。

或者，检查 [`couchreplicate`](https://www.npmjs.com/package/couchreplicate) 工具，该工具是一个命令行实用程序，可帮助您协调从一个 {{site.data.keyword.cloudant_short_notm}} 帐户到另一个帐户的数据传输。该工具会在源帐户和目标帐户之间设置多个复制作业，从而确保只有这么多的复制作业在同一时间执行。如果需要迁移数百个数据库，那么 `couchreplicate` 可以帮助协调复制作业。

![`couchreplicate`](https://raw.githubusercontent.com/glynnbird/couchreplicate/HEAD/img/couchreplicate.gif)

验证是否所有数据都已复制到新服务并且构建了索引。

### 第 5 步：测试
{: #step-5-testing}

在应用程序上执行负载和功能测试，以确保在迁移到生产环境之前不存在任何问题。

### 第 6 步：准备好移至新实例了吗？
{: #step-6-ready-to-move-to-the-new-instance-}

准备好移至新实例时，请更新应用程序以使用 {{site.data.keyword.cloudant_short_notm}} 实例的新帐户 URL 和凭证。有关更多信息，请参阅[供应教程](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud#creating-an-ibm-cloudant-instance-on-ibm-cloud)中关于如何获取 {{site.data.keyword.cloudant_short_notm}} 实例的服务凭证的内容。

### 第 7 步：关闭旧服务
{: #step-7-turn-off-the-old-service}

 应用程序完全迁移到 {{site.data.keyword.cloudant_short_notm}} 轻量套餐或标准套餐实例后，可以通过 {{site.data.keyword.cloud_notm}} 控制台删除旧的 {{site.data.keyword.cloudant_short_notm}} 共享套餐实例，以确保不会再因该服务向您收费。

## 常见问题
{: #faq-frequently-asked-questions}

{{site.data.keyword.cloudant_short_notm}} 组织会发布常见问题 (FAQ)，以帮助 {{site.data.keyword.IBM_notm}} 客户迁移到 {{site.data.keyword.cloud_notm}} 上的 {{site.data.keyword.cloudant_short_notm}} 轻量套餐或标准套餐实例。

## 可以在执行任何操作之前备份数据吗？
{: #can-i-back-up-my-data-before-doing-anything-}

{{site.data.keyword.cloudant_short_notm}} 建议使用 [couchbackup](/docs/services/Cloudant?topic=cloudant-ibm-cloudant-backup-and-recovery#ibm-cloudant-backup-and-recovery) 实用程序将数据导出到磁盘。[{{site.data.keyword.cloud_notm}} Object Storage](https://www.ibm.com/cloud/object-storage) 是一种低价的可缩放解决方案，可用于存储导出的文件。 

## 我能保留自己的 `username.cloudant.com` 域，并将其重定向到 {{site.data.keyword.cloudant_short_notm}} 上的新服务吗？
{: #can-i-keep-my-username-cloudant-com-domain-and-redirect-it-to-the-new-service-on-ibm-cloudant-}

不能，无法保留您的域。您必须计划更新应用程序，以使用为 {{site.data.keyword.cloudant_short_notm}} 实例生成的新帐户 URL 和凭证。

## 如果我有问题，该与谁联系？
{: #who-do-i-contact-if-i-have-questions-}

如果您对迁移有任何疑问，请联系 [{{site.data.keyword.cloudant_short_notm}} 支持人员](mailto:support@cloudant.com)或在 {{site.data.keyword.cloudant_short_notm}}“仪表板”中开具凭单。{{site.data.keyword.cloudant_short_notm}} 支持人员将非常乐意为您提供更多详细信息。
