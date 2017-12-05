---

copyright:
  years: 2015, 2017
lastupdated: "2017-06-09"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-02-23 -->

# IBM Bluemix

{{site.data.keyword.cloudant}} 还作为 [{{site.data.keyword.Bluemix}} 服务 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://console.ng.bluemix.net/catalog/services/cloudant-nosql-db/){:new_window} 提供。
{:shortdesc}

{{site.data.keyword.Bluemix_short}} 是一种开放式标准的云平台，用于构建、运行和管理应用程序。在[主页 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://console.ng.bluemix.net/){:new_window} 上可了解有关 {{site.data.keyword.Bluemix_notm}} 的更多信息并开始使用。

## Bluemix Public

{{site.data.keyword.cloudantfull}} 作为免费 [Lite 套餐](#lite-plan)提供，也作为付费[标准套餐](#standard-plan)中的若干配置提供。此外，还提供了[专用套餐](#dedicated-plan)。此套餐提供了与标准套餐相同的可配置性，但它是在专用硬件上提供的。专用硬件不与其他任何帐户共享，这意味着它仅供您使用。如果在某个[美国位置](#locations)中供应专用套餐实例，那么可以选择符合 [HIPAA ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://en.wikipedia.org/wiki/Health_Insurance_Portability_and_Accountability_Act){:new_window} 的配置。

下表概述了每种套餐的性能度量。

>   **注**：表中的详细信息指示截至 2016 年 9 月的信息。
要获得最新值，请联系 [{{site.data.keyword.cloudant_short_notm}} 支持 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](mailto:support@cloudant.com){:new_window}。
>   **注**：本文档中的所有货币值都以美元 ($) 为单位。

<table border='1'>

<tr>
<th>套餐</th><th>Lite</th><th colspan='4'>标准<i>和</i>专用</th>
</tr>
<tr>
<td>基础价格（每小时）</td>
<td>0.00 美元</td>
<td colspan='4'>请参阅<a href="http://cloudant.com/bluemix" target="_blank">定价详细信息 <img src="../images/launch-glyph.svg" alt="外部链接图标" title="外部链接图标"></a>。</td>
</tr>
<tr>
<td>供应的吞吐量容量（每秒查找数）</td>
<td>20</td>
<td>100</td>
<td>1,000</td>
<td>5,000</td>
<td>20,000</td>
</tr>
<tr>
<td>供应的吞吐量容量（每秒写入数）</td>
<td>10</td>
<td>50</td>
<td>500</td>
<td>2,500</td>
<td>10,000</td>
</tr>
<tr>
<td>供应的吞吐量容量（每秒查询数）</td>
<td>5</td>
<td>5</td>
<td>50</td>
<td>250</td>
<td>1,000</td>
</tr>
<tr>
<td>最大单个文档大小</td>
<td>1 MB</td>
<td colspan='4'>1 MB</td>
</tr>
<tr>
<td>包含的磁盘空间</td>
<td>1 GB</td>
<td colspan='4'>20 GB</td>
</tr>
<tr>
<td>磁盘超额费（每 GB/小时）</td>
<td>不可用</td>
<td colspan='4'>请参阅<a href="http://cloudant.com/bluemix" target="_blank">定价详细信息 <img src="../images/launch-glyph.svg" alt="外部链接图标" title="外部链接图标"></a>。</td>
</tr>

</table>

您可以选择[供应 {{site.data.keyword.cloudant_short_notm}} 服务实例](#provisioning-a-cloudant-instance-on-bluemix)时要使用的套餐。缺省情况下，选择了 [Lite 套餐](#lite-plan)。

![Cloudant 服务实例套餐选择](../images/fb87416a.png)

### Lite 套餐

Lite 套餐是免费的，但最大数据存储限制为 1 GB。此外，针对查找、写入和查询操作供应的吞吐量容量也有限制。 

每天都会检查存储使用情况。如果超过了存储限制，那么对帐户的 HTTP 请求将收到 402 状态码，错误消息为“帐户超过了其数据使用量配额。需要升级到付费套餐。”另外，还会在 Cloudant 仪表板上显示相应的通知条幅。您仍可以读取和删除数据。但是，要写入新数据，必须升级到付费帐户，或者删除数据，然后等待下一次运行检查以重新激活帐户。 

如果要存储的数据多于 1 GB，或者希望拥有更大的吞吐量容量，请移至[标准套餐](#standard-plan)。

### 标准套餐

标准套餐包含 20 GB 的数据存储。如果存储的数据超过 20 GB，那么超出部分将按定义的每 GB/小时成本收费。有关最新的成本，请参阅[定价 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](http://cloudant.com/bluemix){:new_window} 信息。在标准套餐上，还可以更改针对查找、写入和查询操作供应的吞吐量容量。

### 专用套餐

{{site.data.keyword.cloudant_short_notm}} 在单租户专用硬件上作为 [{{site.data.keyword.Bluemix_notm}} Dedicated ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](http://www.ibm.com/cloud-computing/bluemix/dedicated/){:new_window} 配置的一部分提供。

<div id="servicetier"></div>

## 服务层

您可以查看套餐中可用于您帐户的吞吐量容量的详细信息。可以通过 {{site.data.keyword.cloudant_short_notm}} 帐户仪表板的“帐户”选项卡来选择要使用的供应级别。

![帐户仪表板](../images/cloudant_capacity.png)

要移至其他吞吐量容量，请选择所需的供应，然后单击`更改容量`选项按钮。系统会要求您确认更改，并提醒您供应更改可能需要长达 24 小时才能完成。

![帐户仪表板](../images/cloudant_capacity_change.png)

<div id="throughput"></div>

### 供应的吞吐量容量

吞吐量供应会作为以下三种事件之一加以确定和度量：

1.	查找，即读取特定文档，基于文档的 `_id`。
2.	写入，即创建、修改或删除单个文档，或由于索引构建而进行的任何更新。
3.	查询，即对其中一个 {{site.data.keyword.cloudant_short_notm}} 查询端点发出的请求，包括以下类型：
	-	主索引 ([`_all_docs`](../api/database.html#get-documents))
	-	MapReduce 视图 ([`_view`](../api/creating_views.html#using-views))
	-	搜索索引 ([`_search`](../api/search.html#queries))
	-	地理空间索引 ([`_geo`](../api/cloudant-geo.html#querying-a-cloudant-geo-index))
	-	Cloudant 查询 [`_find`](../api/cloudant_query.html#finding-documents-using-an-index))
	-	更改 ([`_changes`](../api/database.html#get-changes))

吞吐量度量是对每秒每种类型事件数的简单计数，其中秒是_滑动_时段。如果帐户超过为套餐供应的吞吐量事件数，那么请求会被拒绝，直至滑动时段中的事件数不再超过所供应的数目。将 1 秒的滑动时段视为 1,000 毫秒的任意连续时间段可能会很有用。

例如，如果您使用的是标准套餐，每秒供应 200 个查询，那么您的帐户在 1,000 毫秒连续时间段（1 秒）内，最多可以发出 200 个查找请求。在 1,000 毫秒的滑动时间段内发出的后续查找请求都将被拒绝，直到该时间段内的查找请求数重新降至 200 以下为止。

由于超出事件数而拒绝请求时，应用程序将收到 [`429` 请求太多](../api/http.html#429)响应。

受支持客户端库（对于 [Java](../libraries/supported.html#java)、[Node.js](../libraries/supported.html#node-js) 和 [Python](../libraries/supported.html#python) 语言）的最新版本可帮助您处理 `429` 响应。例如，Java 库会抛出 [`TooManyRequestsException` ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](http://static.javadoc.io/com.cloudant/cloudant-client/2.5.1/com/cloudant/client/org/lightcouch/TooManyRequestsException.html){:new_window}。

缺省情况下，收到 `429` 响应时，支持的客户端库不会自动尝试重试请求。

最好确保应用程序能正确处理 `429` 响应。因为重试次数有限制；经常超过请求数限制往往意味着需要移至其他套餐配置。

>   **注**：如果要移植现有应用程序，
那么该应用程序可能无法处理 `429` 响应。在迁移验证过程中，请检查应用程序是否能正确处理 `429` 响应。

总之，必须确保应用程序能够正确处理 [`429`](../api/http.html#429) 响应。

### 最大单个文档大小

数据以 [JSON 文档](../api/document.html)形式存储在 {{site.data.keyword.cloudant_short_notm}} 中。对于 {{site.data.keyword.Bluemix_notm}} 上 {{site.data.keyword.cloudant_short_notm}} 服务中的文档，单个文档的最大大小为 1 MB。超过此限制将导致 [`413` 错误](../api/http.html#413)。

### 包含的磁盘空间

此值是套餐中包含的存储容量，用于数据和索引存储。

### 磁盘超额费

将监视所有标准和 Lite 套餐服务实例的已用磁盘空间。如果帐户使用的存储量超过套餐配置中提供的存储量，那么会将其视为“溢出”。溢出会导致对超过套餐分配量所使用的每个额外 GB，按指示价格向该帐户计费。

因使用超过套餐中所提供量的磁盘空间而必须支付的额外金额称为“超额费”。超额费按小时计算。在 Lite 套餐中，无法溢出可用磁盘空间。

例如，假定标准套餐实例的磁盘使用量增加到半天（12 小时）107 GB。此变化意味着在 12 小时内，相对于 20 GB 套餐分配量，该实例的溢出量为 87 GB。因此，对于该额外空间，超额费的计费公式是：87 GB x 12 小时 = 1044 GB 小时。

超额费是使用计费周期的特定小时内超过套餐分配量的最大 GB 数减计算得来的。

### 超额费计算示例

假定您使用的是标准套餐服务，这个月有 30 天，您在这个月一开始使用了 9 GB 存储量。接下来，从第 3 天 02:00 这个小时的前 15 分钟内，存储量增加到 21.5 GB。实例在 02:00 这个小时接下来 10 分钟内使用的存储量降回 9.5 GB，然后在同一小时接下来 25 分钟内又增加到 108 GB。最后，在这个小时的末尾甚至这个月的其余时间，实例的存储量都降至 28 GB。

此模式表示在第 3 天的 02:00 这个小时，超过套餐分配量的最大 GB 数是 88 GB。对于第 3 天的 03:00 这个小时以及这个月的其余时间，实例使用的存储量比套餐分配量多 8 GB。

因此，对于第 3 天的 02:00 这个小时，超额费的计费公式是：88 GB x 1 小时 = 88 GB 小时。

对于从第 3 天 03:00 到当天结束的时间段，超额费的计费公式是：8 GB x 21 小时 = 168 GB 小时。

对于从第 4 天 00:00 到月末（以 30 天为一个月）的时间段，超额费的计费公式是：8 GB x 24 小时 x 27 天 = 5184 GB 小时。

该月的超额帐单总额等于 88 + 168 + 5184 = 5440 GB 小时。

## 位置

缺省情况下，除专用套餐外的所有套餐均基于多租户集群。在套餐选择过程中，可以从以下 {{site.data.keyword.Bluemix_notm}} Public 区域中进行选择：

-   美国南部
-   英国
-   悉尼
-   徳国

## 安全性、加密和合规性

所有套餐都在使用[静态 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://en.wikipedia.org/wiki/Data_at_rest){:new_window} 磁盘加密的服务器上提供。访问会通过使用 HTTPS 的网络连接进行加密。有关更多详细信息，请参阅 [DBaaS 安全性 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://cloudant.com/product/cloudant-features/dbaas-security/){:new_window}。

套餐还提供了[安全合规性认证 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://cloudant.com/product/cloudant-features/cloudant-compliance/){:new_window}。[HIPAA ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://en.wikipedia.org/wiki/Health_Insurance_Portability_and_Accountability_Act){:new_window} 合规性需要[专用环境](#dedicated-plan)，因此请在[供应过程](#provisioning-a-cloudant-instance-on-bluemix)中请求此环境。

## 高可用性、灾难恢复和备份

为了在数据中心内提供高可用性 (HA) 和灾难恢复 (DR)，所有数据将一式三份存储在集群中的三个单独的物理服务器上。您可以在多个数据中心内供应帐户，然后使用持续数据复制跨数据中心提供 HA/DR。

{{site.data.keyword.cloudant_short_notm}} 数据不会自动备份。您可以请求启用[增量备份功能](../guides/backup-guide.html)，或者使用[此处 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://developer.ibm.com/clouddataservices/2016/03/22/simple-couchdb-and-cloudant-backup/){:new_window} 描述的若干种可能方法之一来实现自己的解决方案。  

## 监视使用情况

有关使用情况的信息在 {{site.data.keyword.cloudant_short_notm}}“仪表板”上“活动”选项卡的“使用情况”窗格中提供。

![在仪表板上监视使用情况](../images/cloudant_usage.png).

其中提供了详细信息，说明您的当前[吞吐量](#throughput)以及[已存储数据](#disk-space-included)的数量。

监视可帮助您认识到可能最好对套餐中的供应进行更改。例如，如果经常接近最大数据库查找数，那么可以通过“仪表板”的“帐户”选项卡上的[“服务”窗格](#servicetier)来修改供应。

## 硬件规范

除专用套餐外的所有套餐均在多租户集群上实现。所有数据会一式三份存储在三个单独的物理节点上，以实现高可用性和数据恢复。

## 支持

对标准套餐和专用套餐服务实例的支持是可选的，通过购买“{{site.data.keyword.Bluemix_notm}} 标准支持”来提供。对于 Lite 套餐，支持不可用。

[此处 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://console.ng.bluemix.net/?direct=classic/#/pricing/cloudOEPaneId=pricing&paneId=pricingSheet){:new_window} 提供了 {{site.data.keyword.Bluemix_notm}} 标准支持的定价计算器。[此处 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](http://www-03.ibm.com/software/sla/sladb.nsf/pdf/6606-08/$file/i126-6606-08_05-2016_en_US.pdf){:new_window} 提供了有关支持服务级别协议 (SLA) 的详细信息。

## 在 Bluemix 上供应 Cloudant 实例

您可以通过以下两种方式在 {{site.data.keyword.Bluemix_notm}} 上供应 {{site.data.keyword.cloudant_short_notm}} 实例：

-	使用“仪表板”。[此处](../tutorials/create_service.html)提供了描述该过程的教程。
-	使用 Cloud Foundry 命令工具。[此处](../tutorials/create_service_cli.html)提供了描述该过程的教程。
