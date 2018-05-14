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

<!-- Acrolinx: 2017-02-23 -->

# {{site.data.keyword.Bluemix_notm}} Dedicated

{{site.data.keyword.cloudantfull}} for (Bluemix Dedicated) 是适用于 Bluemix Dedicated 环境的一个可选购的附加组件。{{site.data.keyword.cloudant_short_notm}} Dedicated in Bluemix Dedicated 的可选附加附件的定价基于分配给环境的硬件容量，可以通过联系 {{site.data.keyword.IBM}} 销售代表购买。  

Bluemix Dedicated 客户还可选择通过联合目录在 Bluemix Public 中使用 {{site.data.keyword.cloudant_short_notm}}，包括轻量和标准套餐实例。请注意，
Bluemix Dedicated 用户无法从 Bluemix Public 目录购买 Dedicated Hardware 套餐，在需要专用硬件时应该利用 {{site.data.keyword.cloudant_short_notm}} Dedicated on Bluemix Dedicated。   

以下屏幕快照显示示例 {{site.data.keyword.Bluemix_notm}}“目录”，其中突出显示了 {{site.data.keyword.cloudant_short_notm}}（左）和 {{site.data.keyword.cloudant_short_notm}} Dedicated 环境（右）的 {{site.data.keyword.Bluemix_notm}} Public 联合版本。  

![{{site.data.keyword.cloudant_short_notm}}“目录”](../images/bluemix_catalog.png)

## 硬件容量 

{{site.data.keyword.Bluemix_notm}} Dedicated 中的 {{site.data.keyword.cloudant_short_notm}} 通过 {{site.data.keyword.Bluemix_notm}} Dedicated {{site.data.keyword.cloudant_short_notm}} 1.6 TB 容量部件来购买，其中包含具有三个数据库节点和两个负载均衡器的集群 {{site.data.keyword.cloudant_short_notm}} 环境。
每个数据库节点在 SSD 上包含 1.6 TB，由于所有数据会一式三份进行存储，这等于集群中唯一磁盘空间 1.6 TB。可以通过购买其他 {{site.data.keyword.Bluemix_notm}} Dedicated {{site.data.keyword.cloudant_short_notm}} 1.6 TB 容量部件（可用于以三个数据库节点的倍数来扩展 {{site.data.keyword.cloudant_short_notm}} 集群），从而实现对环境的扩展。客户还可选择具有多个单独 {{site.data.keyword.cloudant_short_notm}} 环境，而不是扩展单个环境。

## 位置和租户 

{{site.data.keyword.Bluemix_notm}} Dedicated 环境中的 {{site.data.keyword.cloudant_short_notm}} Dedicated 环境采用指定为仅供 {{site.data.keyword.Bluemix_notm}} Dedicated 客户使用的硬件。客户可以在给定环境上供应 {{site.data.keyword.cloudant_short_notm}} 的一个或多个实例，{{site.data.keyword.cloudant_short_notm}} 的每个实例共享组成 {{site.data.keyword.cloudant_short_notm}} 环境的底层硬件资源。 

## 安全性、加密和合规性 

所有套餐都在使用[静态 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://en.wikipedia.org/wiki/Data_at_rest) 磁盘加密的服务器上提供。访问通过公共网络连接进行，并且使用 HTTPS 进行了加密。有关更多详细信息，请参阅[安全性 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://console.bluemix.net/docs/services/Cloudant/offerings/security.html#security){:new_window}。IP 白名单在向 {{site.data.keyword.cloudant_short_notm}} 支持请求时提供，并且将应用于整个 {{site.data.keyword.cloudant_short_notm}} 环境，而不是实例级别。 

此套餐还提供了[合规性认证 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://console.bluemix.net/docs/services/Cloudant/offerings/compliance.html#cloudant-security-compliance){:new_window}。[HIPAA ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://en.wikipedia.org/wiki/Health_Insurance_Portability_and_Accountability_Act){:new_window} 合规性在请求时提供，因此请在采购过程中向 {{site.data.keyword.IBM_notm}} 销售代表请求此合规性。 

## 高可用性、灾难恢复和备份 

为了在数据中心内提供高可用性 (HA) 和灾难恢复 (DR)，所有数据将一式三份存储在集群中的三个单独的物理服务器上。在可用的情况下，您可以在多个位置供应帐户，然后使用持续数据复制跨数据中心提供 HA/DR。{{site.data.keyword.cloudant_short_notm}} 数据不会自动备份，但提供了支持的工具来处理备份。查看[灾难恢复和备份 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://console.bluemix.net/docs/services/Cloudant/guides/disaster-recovery-and-backup.html#disaster-recovery-and-backup){:new_window} 指南，以探究所有 HA、DR 和备份注意事项来满足应用程序需求。
