---

copyright:
  years: 2015, 2019
lastupdated: "2019-03-18"

keywords: hardware capacity, location, tenancy, security, encryption, compliance, high availability, disaster recovery, backup

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

# {{site.data.keyword.cloud_notm}} Dedicated
{: #ibm-cloud-dedicated}

{{site.data.keyword.cloudantfull}} for {{site.data.keyword.cloud}} Dedicated 是适用于 {{site.data.keyword.cloud_notm}} Dedicated 环境的一个可选购附加组件。该可选购附加组件适用于 {{site.data.keyword.cloud_notm}} Dedicated 中的 {{site.data.keyword.cloudant_short_notm}} Dedicated，其定价基于分配给环境的硬件容量，您可以联系 {{site.data.keyword.IBM}} 销售代表来进行购买。  
{: shortdesc}

{{site.data.keyword.cloud_notm}} Dedicated 客户还可选择通过联合目录在 {{site.data.keyword.cloud_notm}} Public 中使用 {{site.data.keyword.cloudant_short_notm}}，包括轻量套餐实例和标准套餐实例。请注意，{{site.data.keyword.cloud_notm}} Dedicated 用户不能从 {{site.data.keyword.cloud_notm}} Public 目录购买专用硬件套餐，如果需要使用专用硬件，应该利用 {{site.data.keyword.cloud_notm}} Dedicated 上的 {{site.data.keyword.cloudant_short_notm}} Dedicated。   

以下屏幕快照显示了 {{site.data.keyword.cloud_notm}}“目录”示例，其中突出显示了 {{site.data.keyword.cloudant_short_notm}}（左）和 {{site.data.keyword.cloudant_short_notm}} Dedicated 环境（右）的 {{site.data.keyword.cloud_notm}} Public 联合版本。  

![{{site.data.keyword.cloudant_short_notm}}“目录”](../images/bluemix_catalog.png)

## 硬件容量 
{: #hardware-capacity}

{{site.data.keyword.cloud_notm}} Dedicated 中的 {{site.data.keyword.cloudant_short_notm}} 通过“{{site.data.keyword.cloud_notm}} Dedicated {{site.data.keyword.cloudant_short_notm}} 1.6 TB 容量”部件进行购买，其中包含一个由三个数据库节点和两个负载均衡器组成的集群 {{site.data.keyword.cloudant_short_notm}} 环境。每个数据库节点在 SSD 上包含 1.6 TB，由于所有数据会一式三份进行存储，这等于集群中唯一磁盘空间 1.6 TB。可以通过购买其他“{{site.data.keyword.cloud_notm}} Dedicated {{site.data.keyword.cloudant_short_notm}} 1.6 TB 容量”部件（可用于以三个数据库节点的倍数来扩展 {{site.data.keyword.cloudant_short_notm}} 集群），实现对环境的扩展。客户还可选择使用多个单独 {{site.data.keyword.cloudant_short_notm}} 环境，而不是扩展单个环境。

## 专用环境中的位置和租赁
{: #locations-and-tenancy-in-a-dedicated-environment}

{{site.data.keyword.cloud_notm}} Dedicated 环境中的 {{site.data.keyword.cloudant_short_notm}} Dedicated 环境采用指定为仅供 {{site.data.keyword.cloud_notm}} Dedicated 客户使用的硬件。客户可以在给定环境上供应 {{site.data.keyword.cloudant_short_notm}} 的一个或多个实例，{{site.data.keyword.cloudant_short_notm}} 的每个实例共享组成 {{site.data.keyword.cloudant_short_notm}} 环境的底层硬件资源。 

## 安全性、加密和合规性 
{: #security-encryption-and-compliance}

所有套餐都在使用[静态 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://en.wikipedia.org/wiki/Data_at_rest) 磁盘加密的服务器上提供。访问通过公用网络连接进行，并且使用 HTTPS 进行了加密。有关更多详细信息，请参阅[安全性 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](/docs/services/Cloudant?topic=cloudant-security#security){: new_window}。IP 白名单在向 {{site.data.keyword.cloudant_short_notm}} 支持请求时提供，并且将应用于整个 {{site.data.keyword.cloudant_short_notm}} 环境，而不是实例级别。  

此套餐还提供了[合规性认证 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](/docs/services/Cloudant?topic=cloudant-compliance#compliance){: new_window}。 

[HIPAA ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://en.wikipedia.org/wiki/Health_Insurance_Portability_and_Accountability_Act){: new_window} 合规性在请求时提供，因此请在采购过程中向 {{site.data.keyword.IBM_notm}} 销售代表请求此合规性。 

## 高可用性、灾难恢复和备份 
{: #high-availability-disaster-recovery-and-backup}

为了在数据中心内提供高可用性 (HA) 和灾难恢复 (DR)，所有数据将一式三份存储在集群中的三个单独的物理服务器上。在可用的情况下，您可以在多个位置供应帐户，然后使用持续数据复制跨数据中心提供 HA/DR。{{site.data.keyword.cloudant_short_notm}} 数据不会自动备份，但提供了支持的工具来处理备份。查看[灾难恢复和备份 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](/docs/services/Cloudant?topic=cloudant-disaster-recovery-and-backup#disaster-recovery-and-backup){: new_window} 指南，以探究所有 HA、DR 和备份注意事项来满足应用程序需求。
