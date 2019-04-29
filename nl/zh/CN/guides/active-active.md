---

copyright:
  years: 2017, 2019
lastupdated: "2019-03-15"

keywords: create database, create api key for replication, grant access permission, set up replications, test replication, configure application, active-active configuration, active-passive configuration, fail over, recovering from fail over

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

# 配置 {{site.data.keyword.cloudant_short_notm}} 用于跨区域灾难恢复
{: #configuring-ibm-cloudant-for-cross-region-disaster-recovery}

[{{site.data.keyword.cloudant_short_notm}} 灾难恢复指南](/docs/services/Cloudant?topic=cloudant-disaster-recovery-and-backup#disaster-recovery-and-backup)说明了启用灾难恢复的一种方法是使用 {{site.data.keyword.cloudantfull}} 复制来跨区域创建冗余。

可以使用跨数据中心的“主动/主动”或“主动/被动”拓扑来配置 {{site.data.keyword.cloudant_short_notm}} 中的复制。

下图显示了典型配置，其中使用了两个 {{site.data.keyword.cloudant_short_notm}} 帐户，每个区域中一个帐户：

![主动/主动体系结构示例](../images/active-active.png)

记住以下内容会很有用：

* 在每个数据中心，{{site.data.keyword.cloudant_short_notm}} 已经将数据一式三份分别存储在三个服务器中，从而提供了高可用性。
* 复制在数据库级别（而不是帐户级别）执行，并且必须进行显式配置。
* {{site.data.keyword.cloudant_short_notm}} 未提供有关复制等待时间的任何服务级别协议 (SLA) 或确定性条款。
* {{site.data.keyword.cloudant_short_notm}} 不会监视个别复制。您最好自行实施用于检测失败的复制并重新启动这些复制的策略。

## 主动/主动部署之前的准备工作
{: #before-you-begin-an-active-active-deployment}

对于主动/主动部署，必须落实用于管理冲突的策略。因此，在考虑此体系结构之前，请确保了解[复制](/docs/services/Cloudant?topic=cloudant-replication-api#replication-api)和[冲突](/docs/services/Cloudant?topic=cloudant-document-versioning-and-mvcc#document-versioning-and-mvcc)的工作方式。
{: note}

如果需要有关如何对数据建模以有效处理冲突的帮助，请联系 [{{site.data.keyword.cloudant_short_notm}} 支持 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](mailto:support@cloudant.com){: new_window}。

## 概述
{: #overview-active-active}

在以下资料中，将创建双向复制。此配置允许两个数据库以主动/主动拓扑运行。

该配置假定您有两个帐户位于不同的区域中：

* `myaccount-dc1.cloudant.com`
* `myaccount-dc2.cloudant.com`

拥有这两个帐户后，基本步骤如下所示：

1. 在帐户中[创建](#step-1-create-your-databases)一对同级数据库。
2. [设置](#step-2-create-an-api-key-for-your-replications) API 密钥以用于这两个数据库之间的复制。
3. 授予相应许可权。
4. 设置复制。
5. 测试复制是否按预期工作。
6. 配置应用程序和基础架构，以主动/主动或主动/被动方式使用数据库。

## 第 1 步：创建数据库
{: #step-1-create-your-databases}

[创建数据库](/docs/services/Cloudant?topic=cloudant-databases#create-database)，即要在各帐户之间复制的数据库。

在此示例中，将创建名为 `mydb` 的数据库。

在此示例中，用于数据库的名称并不重要，但使用相同的名称会更清楚。

```sh
curl https://myaccount-dc1.cloudant.com/mydb -XPUT -u myaccount-dc1
curl https://myaccount-dc2.cloudant.com/mydb -XPUT -u myaccount-dc2
```
{: codeblock}

## 第 2 步：创建用于复制的 API 密钥
{: #step-2-create-an-api-key-for-your-replications}

最好将 [API 密钥](/docs/services/Cloudant?topic=cloudant-authorization#api-keys)用于持续复制。这样做的优点在于，如果主帐户详细信息更改（例如，在密码重置后），复制可以继续保持不变。

API 密钥与单个帐户无关。此特征意味着可以创建单个 API 密钥，然后向其授予对这两个帐户的合适数据库许可权。

例如，以下命令请求帐户 `myaccount-dc1` 的 API 密钥：

```sh
$ curl -XPOST https://myaccount-dc1.cloudant.com/_api/v2/api_keys -u myaccount-dc1
```
{: codeblock}

成功的响应类似于以下缩略的示例：

```json
{
  "password": "YPN...Tfi",
  "ok": true,
  "key": "ble...igl"
}
```
{: codeblock}

请仔细记下密码。以后无法再找回此密码。
{: important}

## 第 3 步：授予访问许可权
{: #step-3-grant-access-permission}

[授予 API 密钥许可权](/docs/services/Cloudant?topic=cloudant-authorization#modifying-permissions)以对两个数据库执行读写操作。

如果还要复制索引，请分配管理许可权。

使用 {{site.data.keyword.cloudant_short_notm}}“仪表板”，或者查看[授权](/docs/services/Cloudant?topic=cloudant-authorization#authorization)信息，以了解有关如何通过编程方式授予许可权的详细信息。

## 第 4 步：设置复制
{: #step-4-set-up-replications}

{{site.data.keyword.cloudant_short_notm}} 中的复制始终是单向的：从一个数据库到另一个数据库。因此，要在两个数据库之间进行双向复制，需要两次复制，每个方向复制一次。

复制会在每个帐户中创建，并使用[早先](#step-2-create-an-api-key-for-your-replications)创建的 API 密钥。

首先，创建从 `myaccount-dc1.cloudant.com/mydb` 数据库到 `myaccount-dc2.cloudant.com/mydb` 数据库的复制。

```sh
curl -XPOST 'https://myaccount-dc1.cloudant.com/_replicator'
	-u myaccount-dc1
	-H 'Content-type: application/json'
	-d '{ "_id": "mydb-myaccount-dc1-to-myaccount-dc2",
	"source": "https://ble...igl:YPN...Tfi@myaccount-dc1.cloudant.com/mydb",
	"target": "https://ble...igl:YPN...Tfi@myaccount-dc2.cloudant.com/mydb",
	"continuous": true
}'
```
{: codeblock}

接下来，创建从 `myaccount-dc2.cloudant.com/mydb` 数据库到 `myaccount-dc1.cloudant.com/mydb` 数据库的复制。

```sh
curl -XPOST 'https://myaccount-dc2.cloudant.com/_replicator'
	-u myaccount-dc2
	-H 'Content-type: application/json'
	-d '{ "_id": "mydb-myaccount-dc2-to-myaccount-dc1",
	"source": "https://ble...igl:YPN...Tfi@myaccount-dc2.cloudant.com/mydb",
	"target": "https://ble...igl:YPN...Tfi@myaccount-dc1.cloudant.com/mydb",
	"continuous": true
}'
```
{: codeblock}

如果此步骤因 `_replicator` 数据库不存在而失败，请创建该数据库。
{: note}

## 第 5 步：测试复制
{: #step-5-test-your-replication}

通过在任一数据库中创建、修改和删除文档来测试复制过程。

在一个数据库中进行每个更改之后，请检查是否能同时看到另一个数据库中反映出该更改。

## 第 6 步：配置应用程序
{: #step-6-configure-your-application}

此时，这两个数据库已设置为彼此保持同步。

接下来，要决定是以[主动/主动](#active-active)还是[主动/被动](#active-passive)方式使用这些数据库。

### 主动/主动
{: #active-active}

在主动/主动配置中，不同的应用程序实例可以写入不同的数据库。

例如，应用程序“A”可写入 `myaccount-dc1.cloudant.com/mydb` 数据库，应用程序“B”可写入 `myaccount-dc2.cloudant.com/mydb` 数据库。

此配置有多项优点：

- 负载可以分布在多个帐户上。
- 应用程序可以配置为访问等待时间较短的帐户（而不是始终访问在地理位置上最近的帐户）。

应用程序可以设置为与“最靠近的”{{site.data.keyword.cloudant_short_notm}} 帐户进行通信。对于在 DC1 中托管的应用程序，适合将其 {{site.data.keyword.cloudant_short_notm}} URL 设置为 `"https://myaccount-dc1.cloudant.com/mydb"`。同样，对于在 DC2 中托管的应用程序，您会将其 {{site.data.keyword.cloudant_short_notm}} URL 设置为 `"https://myaccount-dc2.cloudant.com/mydb"`。

### 主动/被动
{: #active-passive}

在主动/被动配置中，应用程序的所有实例都会配置为使用主数据库。但是，如果确有必要，应用程序可以故障转移到其他备份数据库。故障转移可在应用程序逻辑本身中实现，也可以使用负载均衡器或其他一些方法来实现。

确定是否需要故障转移的简单测试是将主数据库端点用作“脉动信号”。例如，发送到主数据库端点的简单 `GET` 请求通常会返回[有关数据库的详细信息](/docs/services/Cloudant?topic=cloudant-databases#getting-database-details)。如果未接收到响应，那么可能指示有必要进行故障转移。

### 其他配置
{: #other-configurations}

您可以考虑对配置采用其他混合方法。

例如，在“写主读副”配置中，所有写操作都针对一个数据库，但读操作负载会在副本之间分布。

## 第 7 步：后续步骤
{: #step-7-next-steps}

* 考虑监视数据库之间的[复制](/docs/services/Cloudant?topic=cloudant-advanced-replication#advanced-replication)。使用数据来确定配置是否可以进一步优化。
*	考虑如何部署和更新设计文档和索引。您可能会发现自动执行这些任务会更高效。

## 在 {{site.data.keyword.cloudant_short_notm}} 区域之间进行故障转移
{: #failing-over-between-ibm-cloudant-regions}

通常，用于管理区域或数据中心之间故障转移的过程会在应用程序堆栈内的较高层进行处理，例如通过配置应用程序服务器故障转移更改或通过均衡负载进行处理。

{{site.data.keyword.cloudant_short_notm}} 未提供工具用于显式管理区域之间的任何故障转移或重新路由请求。造成此约束的部分原因是技术，部分原因在于可能发生这类情况的条件往往是特定于应用程序的。例如，您可能希望根据定制性能指标来强制故障转移。

但是，如果确定不需要故障转移管理能力，那么可以选择的一些选项包括：

* 将自己的 [HTTP 代理放在 {{site.data.keyword.cloudant_short_notm}} ![外部链接图标](../images/launch-glyph.svg "外部链接图标") 前端](https://github.com/greenmangaming/cloudant-nginx){: new_window}。将应用程序配置为与代理（而不是 {{site.data.keyword.cloudant_short_notm}} 实例）通信。此配置意味着更改应用程序所使用 {{site.data.keyword.cloudant_short_notm}} 实例的任务可以通过修改代理配置（而不是修改应用程序设置）来处理。许多代理都能够根据用户定义的运行状况检查来均衡负载。
* 使用全局负载均衡器（例如，[{{site.data.keyword.cloud}} Internet Services ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](/docs/infrastructure/cis/glb.html#global-load-balancer-glb-concepts){: new_window} 或 [Dyn Traffic Director ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](http://dyn.com/traffic-director/){: new_window}）路由到 {{site.data.keyword.cloudant_short_notm}}。此选项需要 `CNAME` 定义，以根据运行状况检查或等待时间规则来路由到不同的 {{site.data.keyword.cloudant_short_notm}} 帐户。


## 从故障转移恢复
{: #recovering-from-fail-over}

如果无法访问单个 {{site.data.keyword.cloudant_short_notm}} 实例，请避免在该实例重新变为可访问后，立即将流量重定向回该实例。原因是密集型任务（例如，同步来自任何同级的数据库状态，以及确保索引是最新的）需要一些时间才能完成。

使用一种机制来监视这些任务会很有帮助，有助于确定数据库何时处于合适的状态，能够处理生产流量。

作为指南，适用的典型检查列表包括：

* [复制](#replications)
* [索引](#indexes)

如果是根据运行状况测试来实施请求重新路由或故障转移，那么您可能希望合并对应的检查，以避免过早重新路由回仍在恢复的服务实例。
{: note}

### 复制
{: #replications}

* 是否有任何复制处于错误状态？
* 是否有任何复制需要重新启动？
* 有多少暂挂更改仍在等待复制到数据库中？

提供了有关[监视复制状态](/docs/services/Cloudant?topic=cloudant-advanced-replication#replication-status)的更多信息。

如果持续更改数据库，复制状态不可能是 0。您必须决定哪个状态阈值是可接受的，或哪个表示错误状态。
{: note}

### 索引
{: #indexes}

* 索引是否足够新？使用[活动任务](/docs/services/Cloudant?topic=cloudant-active-tasks#active-tasks)端点可验证此项。
* 通过向索引发送查询，并确定查询是否在可接受的时间内返回，以测试“索引就绪”程度。
