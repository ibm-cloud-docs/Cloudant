---

copyright:
  years: 2015, 2019
lastupdated: "2019-03-26"

keywords: standard plan, lite plan, dedicated hardware plan, event type, provisioned throughput capacity, consumption, capacity, monitor usage, data usage, size limits, locations, tenancy, authentication methods, high availability, disaster recovery, backup, support

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

# 套餐和供应
{: #ibm-cloud-public}

{{site.data.keyword.cloudantfull}} Public 是 {{site.data.keyword.cloudant_short_notm}} 的功能最丰富的产品，最先接收更新和新功能。定价基于已分配的供应吞吐量容量和已使用的数据存储量，使得此产品适用于任何所需负载。
{: shortdesc}

免费[轻量套餐](#lite-plan)包含固定数量的吞吐量容量和数据，可用于开发和评估用途。付费[标准套餐](#standard-plan)包含可配置的供应吞吐量容量和数据存储定价，可根据应用程序的需求变化来进行缩放。还提供了一个可选[专用硬件套餐](#dedicated-hardware-plan)，需要每月额外付费，以在专用硬件环境上运行一个或多个标准套餐实例。专用硬件环境仅供您独自使用，如果在美国某个位置供应了专用硬件套餐实例，那么可以选择符合 [HIPAA ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://en.wikipedia.org/wiki/Health_Insurance_Portability_and_Accountability_Act){: new_window} 的配置。

## 套餐
{: #plans}

您可以选择[供应 {{site.data.keyword.cloudant_short_notm}} 服务实例](#provisioning-a-cloudant-nosql-db-instance-on-ibm-cloud)时要使用的套餐。缺省情况下，选择了[轻量套餐](#lite-plan)。

![{{site.data.keyword.cloudant_short_notm}} 服务实例套餐选择](../images/lite_pricing_plan.png)

### 轻量套餐
{: #lite-plan}

轻量套餐是免费的，旨在用于开发和评估目的。轻量套餐包含 {{site.data.keyword.cloudant_short_notm}} 的完整功能，但轻量套餐实例供应的吞吐量容量和数据存储量固定不变。供应的吞吐量容量固定为 20 次读取/秒、10 次写入/秒以及 5 次全局查询/秒，数据存储量的上限为 1 GB。 

每天都会检查存储使用情况。如果超过了 1 GB 的存储限制，那么对 {{site.data.keyword.cloudant_short_notm}} 实例的请求将收到 402 状态码，错误消息为“帐户超过了其数据使用量配额。需要升级到付费套餐。”另外，还会在 {{site.data.keyword.cloudant_short_notm}}“仪表板”上显示相应的条幅。您仍可以读取和删除数据。但是，要写入新数据，您有两个选择。第一个选择是，您可以升级到付费[标准套餐](#standard-plan)，此套餐会立即除去写操作限制。另一个选择是，您可以删除数据，使总存储量低于 1 GB 限制，然后等待下一次运行日常存储量检查，以便实例再次允许写操作。 

如果要存储的数据多于 1 GB，或者希望有能力缩放供应的吞吐量容量，请移至[标准套餐](#standard-plan)。

对于每个 {{site.data.keyword.cloud_notm}} 帐户，您只能有一个 {{site.data.keyword.cloudant_short_notm}} 轻量套餐实例。如果您已经有一个轻量套餐实例，那么创建新的轻量套餐实例或将标准套餐实例更改为轻量套餐的任何尝试都会返回消息：“每个服务只能有一个轻量套餐实例。要创建新实例，请删除现有轻量套餐实例，或选择付费套餐。”
{: note}

### 标准套餐
{: #standard-plan}

{{site.data.keyword.cloudant_short_notm}} 标准套餐可供所有付费 {{site.data.keyword.cloud}} 帐户（即，现收现付或预订帐户）使用，并可根据应用程序的需要进行缩放。标准套餐的定价基于以下两个因素：分配的供应吞吐量容量和实例中存储的数据量。 

定价依据比例按小时收费，供应的起始吞吐量容量为 100 次读取/秒、50 次写入/秒和 5 次全局查询/秒，起始成本为 0.105 美元/小时。您可以在 {{site.data.keyword.cloudant_short_notm}} 仪表板中以 100 次读取/秒、50 次写入/秒和 5 次全局查询/秒为增量，增大或减小供应的吞吐量容量。根据分配的供应吞吐量容量（而不是根据计量的请求量）计算成本。标准套餐包含 20 GB 的数据存储。如果存储的数据超过 20 GB，那么超出部分将按定义的每 GB/小时成本收费。 

请参阅 {{site.data.keyword.cloud_notm}} 定价计算器以获取不同容量和货币的定价，并参阅[定价](/docs/services/Cloudant?topic=cloudant-pricing#pricing){: new_window}信息以获取成本估算示例。

### 专用硬件套餐
{: #dedicated-hardware-plan}

{{site.data.keyword.cloudant_short_notm}} 专用硬件套餐实例是一种裸机 {{site.data.keyword.cloudant_short_notm}} 环境，为了使 {{site.data.keyword.cloudant_short_notm}} 标准套餐实例可供您专用而供应。{{site.data.keyword.cloudant_short_notm}} 专用硬件套餐环境可以在任何 [{{site.data.keyword.IBM}} 数据中心 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://www.ibm.com/cloud-computing/bluemix/data-centers) 供应。要符合 HIPAA，需要使用此套餐，在供应时必须加以选择。{{site.data.keyword.cloudant_short_notm}} 专用硬件套餐环境的用户可以利用 IP 白名单以及 {{site.data.keyword.IBM_notm}} Key Protect 的自带密钥 (BYOK) 客户管理的加密密钥。此外，2019 年 1 月 1 日之后供应的专用硬件环境为其上部署的所有标准套餐实例添加了内部端点。使用内部端点将允许客户通过内部 {{site.data.keyword.cloud}} 网络连接到 {{site.data.keyword.cloudant_short_notm}} 实例，以避免上游应用程序流量通过公用网络传输并产生带宽费用。有关更多信息，请参阅[服务端点文档](https://cloud.ibm.com/docs/services/service-endpoint/getting-started.html#about){:new_window}，以获取为您的 {{site.data.keyword.cloud}} 帐户启用服务端点的更多详细信息。

您可以供应一个或多个标准套餐实例，专用硬件环境将根据标准套餐实例使用的容量和数据按需进行扩展或收缩。{{site.data.keyword.cloudant_short_notm}} 专用硬件套餐实例具有固定价格，是对其上部署的任何标准套餐实例使用量定价的补充。计费依据比例按天收取，该环境的起步价为 1 个月的费用。供应 {{site.data.keyword.cloudant_short_notm}} 专用硬件套餐是异步执行的，需要 5 到 7 个工作日。要创建 {{site.data.keyword.cloudant_short_notm}} 专用硬件套餐实例并在其上供应标准套餐实例，请遵循[在 {{site.data.keyword.cloud_notm}} 上创建和利用 {{site.data.keyword.cloudant_short_notm}} 专用硬件套餐实例 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](/docs/services/Cloudant?topic=cloudant-creating-and-leveraging-an-ibm-cloudant-dedicated-hardware-plan-instance-on-ibm-cloud#creating-and-leveraging-an-ibm-cloudant-dedicated-hardware-plan-instance-on-ibm-cloud){: new_window} 教程。 

专用硬件套餐不适用于 {{site.data.keyword.cloud_notm}} Dedicated 客户。专用硬件套餐仅适用于 {{site.data.keyword.cloud_notm}} Public 客户。
{: important}

## 事件类型
{: #event-types}

吞吐量供应会通过以下某个类型的事件进行确定和度量：

1.	_读取_（先前称为查找），包括：
    1. 读取特定文档，基于文档的 `_id`。
    2. _分区_查询，对请求路径中 `_partition` 名称空间中的 {{site.data.keyword.cloudant_short_notm}} 查询端点发出请求，包括以下类型：
        
        -	主索引 ([`_all_docs`](/docs/services/Cloudant?topic=cloudant-databases#get-documents))
        -	MapReduce 视图 ([`_view`](/docs/services/Cloudant?topic=cloudant-using-views#using-views))
        -	搜索索引 ([`_search`](/docs/services/Cloudant?topic=cloudant-search#queries))
        -	{{site.data.keyword.cloudant_short_notm}} Query ([`_find`](/docs/services/Cloudant?topic=cloudant-query#finding-documents-using-an-index))
    
        分区查询请求使用的读操作数根据返回的结果而有所不同。
2.	_写入_，即单个文档的创建、修改或删除。
3.	全局索引的_全局查询_（先前称为查询），是对**不在** `_partition` 名称空间内的 {{site.data.keyword.cloudant_short_notm}} 查询端点发出的请求，包括以下类型：
	-	主索引 ([`_all_docs`](/docs/services/Cloudant?topic=cloudant-databases#get-documents))
	-	MapReduce 视图 ([`_view`](/docs/services/Cloudant?topic=cloudant-using-views#using-views))
	-	搜索索引 ([`_search`](/docs/services/Cloudant?topic=cloudant-search#queries))
	-	地理空间索引 ([`_geo`](/docs/services/Cloudant?topic=cloudant-cloudant-nosql-db-geospatial#querying-a-cloudant-geo-index))
	-	{{site.data.keyword.cloudant_short_notm}} Query ([`_find`](/docs/services/Cloudant?topic=cloudant-query#finding-documents-using-an-index))


## 供应的吞吐量容量
{: #provisioned-throughput-capacity}

吞吐量供应会作为以下操作类型的事件进行识别和度量：_读取_、_写入_、_全局查询_。

吞吐量度量是对每秒每种类型事件数的简单计数，其中秒是_滑动_时段。如果帐户超过为套餐供应的吞吐量事件数，那么请求会被拒绝，直至滑动时段中的事件数不再超过所供应的数目。将 1 秒的滑动时段视为 1,000 毫秒的任意连续时间段可能会很有用。

例如，标准套餐每秒供应 200 次读取。您的帐户在 1,000 毫秒（1 秒）的连续时间段内，最多可消耗 200 个读取事件。在 1,000 毫秒的滑动时间段内发出的后续读取请求都将被拒绝，直到该时间段内的读取事件数重新降至 200 以下为止。

由于超出事件数而拒绝请求时，应用程序将收到 [`429` 请求太多](/docs/services/Cloudant?topic=cloudant-http#http-status-codes)响应。

受支持客户机库（对于 [Java](/docs/services/Cloudant?topic=cloudant-supported-client-libraries#java)、[Node.js](/docs/services/Cloudant?topic=cloudant-supported-client-libraries#node-js) 和 [Python](/docs/services/Cloudant?topic=cloudant-supported-client-libraries#python-supportedn) 语言）的最新版本可帮助您处理 `429` 响应。例如，Java 库会生成 [`TooManyRequestsException` ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](http://static.javadoc.io/com.cloudant/cloudant-client/2.5.1/com/cloudant/client/org/lightcouch/TooManyRequestsException.html){: new_window} 响应。

缺省情况下，收到 `429` 响应时，支持的客户机库不会自动尝试重试请求。

最好确保应用程序能正确处理 `429` 响应。因为重试次数有限制；经常超过请求数限制往往意味着需要移至其他套餐配置。

如果正在迁移现有的应用程序，该应用程序可能无法处理 `429` 响应。在迁移验证过程中，请检查应用程序是否能正确处理 `429` 响应。

{: note}

总之，必须确保应用程序能够正确处理 [`429`](/docs/services/Cloudant?topic=cloudant-http#http-status-codes) 响应。

### 分区查询的读操作使用量
{: #consumption-of-lookup-operations-by-partitioned-queries}

分区查询请求使用的读操作数是可变的，具体取决于返回的结果。使用量基于两个轴：

1. 从查询中涉及的索引读取的行数。
1. 在查询执行期间，从数据库读取的文档数（如果有）。
    
#### `_all_docs`、视图和搜索查询

从索引读取每个 100 行的块使用 1 次读操作。此外，执行查询期间从数据库读取的每个文档使用 1 个读取单位。

从索引读取的行数与返回的结果数相同。在查询请求期间，当 `include_docs=true` 作为查询字符串参数传递时仅从数据库读取文档。

下表中显示了成本示例。

|结果数|是否包含文档|总读取使用量|读取的行使用量|读取的文档使用量|
|--------------|----------------|-------------|---------------------| --- |
| 199      |否| **2** | 2 | 0 |
| 199      |是| **201** | 2 | 199 |
| 301      |否| **4** | 4 | 0 |
| 301      |是| **305** | 4 | 301 |

要减少分区 `_all_docs`、视图和搜索查询的读取使用量，减少对 `include_docs=true` 的使用是关键。

#### {{site.data.keyword.cloudant_short_notm}} Query

对于 {{site.data.keyword.cloudant_short_notm}} Query 请求，读取的索引行所使用的读操作数与过滤_之前_从底层索引读取的行数相关，并基于选择器中无法由索引满足的部分。
这意味着读取的行数值以及（连带地）消耗的读取单位数可以高于您收到的最终结果数。

此外，{{site.data.keyword.cloudant_short_notm}} 查询必须读取底层索引返回的每个行的文档，从而能够执行传递给查询的选择器所需的进一步过滤。

|结果数|索引返回的行数|总读取使用量|读取的行使用量|读取的文档使用量|
|--------------|----------------|-------------|---------------------| --- |
|5| 199     | **201** | 2 | 199 |
| 199      | 199     | **201** | 2 | 199 |
|5| 301     | **305** | 4 | 301 |
| 301      | 301     | **305** | 4 | 301 |

要降低分区 {{site.data.keyword.cloudant_short_notm}} Query 查询的读取使用量，使用合适的索引是关键。

### 查看和更改容量
{: #viewing-and-changing-capacity}

您可以查看套餐中可用于您帐户的吞吐量容量的详细信息。可以通过 {{site.data.keyword.cloudant_short_notm}} 帐户仪表板的“帐户”选项卡来选择要使用的供应级别。

![帐户仪表板](../images/cloudant_capacity.png)

要移至其他吞吐量容量，请选择所需的供应，然后单击`更新`。系统会要求您确认更改，并提醒您供应更改可能需要长达 24 小时才能完成。

![帐户仪表板](../images/cloudant_capacity_change.png)

容量增加的大小限制为每次更改对应 10 个单位（1000 次读取/秒、500 次写入/秒和 50 次全局查询/秒）。减少容量时不受单位数的限制。对容量的任何更改（增加或减少）限制为每小时一次。如果需要的容量大于 {{site.data.keyword.cloudant_short_notm}}“仪表板”上提供的容量，请联系 [{{site.data.keyword.cloudant_short_notm}} 支持人员 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](mailto:support@cloudant.com){: new_window}。
{: note}

### 监视使用情况 
{: #monitoring-usage}

有关使用情况的信息在 {{site.data.keyword.cloudant_short_notm}}“仪表板”内“监视”选项卡的“当前操作”窗格中提供。 

![在仪表板上监视使用情况](../images/cloudant_usage.png)

其中提供了详细信息，说明您的当前[吞吐量](#provisioned-throughput-capacity)以及[已存储数据](#disk-space-included)的数量。

监视可帮助您认识到可能最好对套餐中的供应进行更改。例如，如果经常接近最大数据库读取数，那么可以通过“仪表板”的“帐户”选项卡上的[“容量”窗格](#viewing-and-changing-capacity)来修改供应。

## 数据使用量
{: #data-usage}

### 包含的磁盘空间
{: #disk-space-included}

此值是套餐中包含的存储容量，用于数据和索引存储。

### 磁盘超额费
{: #disk-overage}

所有标准套餐和轻量套餐都包含用于 JSON 数据、附件和索引的磁盘空间。系统会监视所有标准套餐和轻量套餐使用的磁盘空间。当使用的数据多于套餐分配量时，说明可能存在下表中描述的条件：

<table>

<tr>
<th id="disk-overage-plan">套餐</th><th id="description">描述</th>
</tr>
<tr>
<th headers="standard-plan">标准</td>
<td headers="description"><p>
<ul><li>如果帐户使用的存储量超过套餐配置中分配的存储量，那么会将其视为“溢出”。溢出会导致对超过套餐分配量所使用的每个额外 GB，按指示价格向该帐户计费。</li>
<li>因使用的磁盘空间超过套餐中所提供量而必须支付的额外金额称为“超额费”。超额费按小时计算。</li></ul></p></td>
</tr>
<tr>
<th headers="lite-plan">轻量</td>
<td headers="description"><p>
<ul><li>轻量套餐的磁盘使用量有上限。达到上限后，即无法再写入新数据。要写入新数据，必须升级到标准套餐，或者删除数据，然后等待下一次运行检查以重新激活帐户。</p>
</li></ul></td>
</tr>
</table>

例如，假定标准套餐的磁盘使用量增加到半天（12 小时）107 GB。此变化意味着在 12 小时内，相对于 20 GB 套餐分配量，该实例的溢出量为 87 GB。因此，对于该额外空间，超额费的计费公式是：87 GB x 12 小时 = 1044 GB 小时。

超额费是使用计费周期的特定小时内超过套餐分配量的最大 GB 数计算得来的。

### 磁盘超额费计算示例
{: #disk-overage-example}

假定您使用的是标准套餐服务，这个月有 30 天，您在这个月一开始使用了 9 GB 存储量。接下来，从第 3 天 02:00 这个小时的前 15 分钟内，存储量增加到 21.5 GB。实例在 02:00 这个小时接下来 10 分钟内使用的存储量降回 9.5 GB，然后在同一小时接下来 25 分钟内又增加到 108 GB。最后，在这个小时的末尾甚至这个月的其余时间，实例的存储量都降至 28 GB。

此模式表示在第 3 天的 02:00 这个小时，超过套餐分配量的最大 GB 数是 88 GB。对于第 3 天的 03:00 这个小时以及这个月的其余时间，实例使用的存储量比套餐分配量多 8 GB。

因此，对于第 3 天的 02:00 这个小时，帐单包含的超额费计算公式为：88 GB x 1 小时 = 88 GB 小时。

对于从第 3 天 03:00 到当天结束的时间段，帐单包含的超额费计算公式为：8 GB x 21 小时 = 168 GB 小时。

对于从第 4 天 00:00 到月末（以 30 天为一个月）的时间段，帐单包含的超额费计算公式为：8 GB x 24 小时 x 27 天 = 5184 GB 小时。

该月的超额费帐单总额等于 88 + 168 + 5184 = 5440 GB 小时。

## 请求和文档大小限制
{: #request-and-document-size-limits}

{{site.data.keyword.cloudant_short_notm}} JSON 文档和请求具有以下最大大小限制： 

限制|最大大小
------|-------------
单个文档大小|1 MB
单个附件大小|10 MB
请求主体大小|11 MB

超过上述任何限制都会生成 [413 响应](/docs/services/Cloudant?topic=cloudant-http#http-status-codes)。

建议在 Object Storage 中存储二进制附件或大型 JSON BLOB，并在 {{site.data.keyword.cloudant_short_notm}} JSON 文档中保存相应位置的链接。   

在复制时，大于这些限制的文档或附件不会复制到目标数据库。[此处](/docs/services/Cloudant?topic=cloudant-replication-api#replication-errors)提供了有关如何检测复制错误的更多信息。

## 位置和租户
{: #locations-and-tenancy}

缺省情况下，在多租户环境上部署所有轻量和标准套餐。在套餐选择过程中，可以从以下 {{site.data.keyword.cloud_notm}} Public 区域中进行选择：

-   华盛顿特区
-   达拉斯
-   伦敦
-   悉尼
-   法兰克福&Dagger;
-   东京

可以在大多数 [{{site.data.keyword.IBM_notm}} 数据中心位置 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://www.ibm.com/cloud-computing/bluemix/data-centers) 中部署专用硬件套餐实例。
请参阅 {{site.data.keyword.cloud_notm}}“目录”中的下拉菜单以获取可用位置的最新列表。

&Dagger;所有从 {{site.data.keyword.cloud_notm}} Public 法兰克福区域部署的 {{site.data.keyword.cloudant_short_notm}} 实例都会部署在欧盟管理的环境中。在欧盟管理的环境外部生成的任何 {{site.data.keyword.cloudant_short_notm}} 帐户或 API 密钥，都无法获得对欧盟管理的 {{site.data.keyword.cloudant_short_notm}} 实例的访问权。

## 认证方法
{: #authentication-methods}

{{site.data.keyword.cloudant_short_notm}} 使用 HTTPS API 进行访问。如果 API 端点需要认证，那么会针对 {{site.data.keyword.cloudant_short_notm}} 收到的每个 HTTPS 请求，对用户进行认证。在供应期间，可用的认证方法包括“使用旧凭证和 IAM”或“仅使用 IAM”。有关更多信息，请参阅 [IAM 指南](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-l){: new_window}或旧[认证 API 文档](/docs/services/Cloudant?topic=cloudant-authentication#authentication){: new_window}。

供应 {{site.data.keyword.cloudant_short_notm}} 实例之后，在 {{site.data.keyword.cloud_notm}}“仪表板”的“服务凭证”选项卡中生成新凭证时，可以找到连接 URL 和 IAM 授权详细信息。如果在供应期间选择了此选项，那么还将包含 {{site.data.keyword.cloudant_short_notm}} 的旧用户名和密码。

{{site.data.keyword.cloudant_short_notm}} 团队建议您尽可能使用 IAM 访问控制进行认证。使用 {{site.data.keyword.cloudant_short_notm}} 旧认证时，建议您对编程方式的访问和复制作业使用 [API 密钥](/docs/services/Cloudant?topic=cloudant-authorization#api-keys){: new_window}，而不是帐户级别的凭证。
{: important}

## 数据中心的高可用性、灾难恢复和备份
{: #high-availability-disaster-recovery-and-backup-in-a-data-center}

为了在数据中心内提供高可用性 (HA) 和灾难恢复 (DR)，所有数据将一式三份存储在集群中的三个单独的物理服务器上。您可以在多个数据中心内供应帐户，然后使用持续数据复制跨数据中心提供 HA/DR。{{site.data.keyword.cloudant_short_notm}} 数据不会自动备份，但提供了支持的工具来处理备份。查看[灾难恢复和备份指南 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](/docs/services/Cloudant?topic=cloudant-authorization#api-keys)，以探究所有 HA、DR 和备份注意事项来满足应用程序需求。 

## {{site.data.keyword.cloud_notm}} 支持
{: #ibm-cloud-support}

对标准套餐和专用套餐服务实例的支持是可选的，这可通过购买 *{{site.data.keyword.cloud_notm}} 标准支持*来提供。对于轻量套餐不提供支持。

有关支持套餐的更多信息，请参阅 [{{site.data.keyword.cloud_notm}} 标准支持套餐 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://www.ibm.com/cloud/support#944376){: new_window}。有关支持的更多信息，请参阅 [{{site.data.keyword.IBM_notm}} 支持指南 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://www.ibm.com/support/home/pages/support-guide/){: new_window}。

用于 {{site.data.keyword.cloudant_short_notm}} 的支持系统不提供相关功能来保护包含以下各项的内容：医疗保健信息、运行状况数据、受保护的运行状况信息或受其他法规需求约束的数据。因此，客户不得输入或提供此类数据。
{: note}

## 在 {{site.data.keyword.cloud_notm}} 上供应 {{site.data.keyword.cloudant_short_notm}} 实例
{: #provisioning-a-cloudant-nosql-db-instance-on-ibm-cloud}

可以通过以下两种方式在 {{site.data.keyword.cloud_notm}} 上供应 {{site.data.keyword.cloudant_short_notm}} 轻量或标准套餐实例：

- 使用仪表板。[此处 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud#creating-an-ibm-cloudant-instance-on-ibm-cloud){: new_window} 提供了描述此过程的教程。
- 使用 Cloud Foundry 命令工具。[此处 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud-by-using-the-ibm-cloud-cli#creating-an-ibm-cloudant-instance-on-ibm-cloud-by-using-the-ibm-cloud-cli){: new_window} 提供了描述此过程的教程。
 
要创建和利用 {{site.data.keyword.cloudant_short_notm}} 专用硬件套餐实例，请遵循[此处 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](/docs/services/Cloudant?topic=cloudant-creating-and-leveraging-an-ibm-cloudant-dedicated-hardware-plan-instance-on-ibm-cloud#creating-and-leveraging-an-ibm-cloudant-dedicated-hardware-plan-instance-on-ibm-cloud){: new_window} 描述此过程的教程。




