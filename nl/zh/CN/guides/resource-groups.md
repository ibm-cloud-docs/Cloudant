---

copyright:
  years: 2015, 2019
lastupdated: "2019-06-12"

keywords: migrate to a resource group, downtime, migrate existing instance, organization and space, standard plan, dedicated hardware instance, how to migrate

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

# {{site.data.keyword.cloudant_short_notm}} 如何使用 {{site.data.keyword.cloud_notm}} 资源组？
{: #how-does-ibm-cloudant-work-with-ibm-cloud-resource-groups-}

自 2018 年 7 月 16 日起，新的 {{site.data.keyword.cloudantfull}} 资源实例已供应到资源组中，而不是供应到 Cloud Foundry 空间中。本文档涵盖 {{site.data.keyword.cloudant_short_notm}} 支持收到的有关此转换的常见问题。

## 如何将现有实例迁移到资源组？
{: #how-do-i-migrate-an-existing-instance-to-a-resource-group-}

要将 {{site.data.keyword.cloudant_short_notm}} 实例从 Cloud Foundry 空间迁移到资源组，请参阅[将 Cloud Foundry 服务实例和应用程序迁移到资源组 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://cloud.ibm.com/docs/resources/instance_migration.html#migrate){: new_window}。

您可以迁移以下套餐上的 {{site.data.keyword.cloudant_short_notm}} 实例：

- 轻量
- 标准
- 专用硬件

## 将实例迁移到资源组时会停机多长时间？
{: #how-much-downtime-occurs-when-you-migrate-an-instance-to-a-resource-group-}

迁移过程中没有停机时间。

## 为什么一些实例有组织和空间，而另一些实例没有组织和空间？
{: #why-do-some-instances-have-an-organization-and-space-and-others-do-not-}

自 2018 年 7 月 16 日起，新实例已供应到资源组，而不是供应到 Cloud Foundry 空间中。在此日期之前供应的资源实例具有关联的 Cloud Foundry 组织和空间。在此日期之后供应的实例将改为与资源组相关联。

## 为什么无法在专用硬件实例上创建新的标准套餐实例？
{: #why-can-t-i-create-new-standard-plan-instances-on-my-dedicated-hardware-instances-}

新的标准套餐实例会供应到资源组中。为了将这些实例供应到专用硬件实例上，必须先将专用硬件实例迁移到资源组中。

有关如何执行此操作的更多信息，请参阅[将 Cloud Foundry 服务实例和应用程序迁移到资源组 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://cloud.ibm.com/docs/resources/instance_migration.html#migrate){: new_window}。

专用硬件实例迁移到资源组后，当供应标准套餐时，该实例会显示在“位置”下拉菜单中。

## 应该如何迁移我的专用硬件实例以及在其上托管的标准套餐实例？
{: #how-should-i-migrate-my-dedicated-hardware-instances-and-the-standard-plan-instances-hosted-on-them-}

理论上，实例可以按任意顺序迁移到资源组。在实践中，对于专用硬件实例以及在其上托管的标准套餐实例，建议您采用以下顺序：

1. 将专用硬件实例迁移到资源组。这允许在专用硬件上创建新的标准套餐实例。
2. 迁移标准实例。

对于非专用硬件上托管的轻量套餐实例和标准套餐实例，可以随时进行迁移。
{: tip}
