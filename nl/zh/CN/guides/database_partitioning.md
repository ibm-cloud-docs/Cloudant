---

copyright:
  years: 2019
lastupdated: "2019-06-12"

keywords: database shards, non-partitioned databases, partition key, global query, partition query, create partition database, create partition query index

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

<!-- Acrolinx: 2018-08-17 -->

# 数据库分区
{: #database-partitioning}

{{site.data.keyword.cloudantfull}} 支持两种类型的数据库：

- 分区
- 未分区

_分区_数据库提供重要的性能和成本优势，但是需要您指定数据的逻辑分区。以下文本中将对此进行更详细的描述。

或者，也可以创建_未分区_数据库。此类数据库更容易使用，不需要定义分区方案，但是仅可以创建全局辅助索引。

{{site.data.keyword.cloudant_short_notm}} 强烈建议您使用分区数据库，以实现最佳长期数据库性能，其中数据模型允许对文档进行逻辑分区。

在创建数据库时设置数据库分区类型。创建数据库时，使用 `partitioned` 查询字符串参数来设置是否对数据库分区。`partitioned` 的缺省值是 `false`，保持向后兼容性。

现有数据库的分区类型无法更改。

## 数据库分片
{: #database-shards}

阅读此文档之前，您必须了解 {{site.data.keyword.cloudant_short_notm}} 中的[分片概念](/docs/services/Cloudant?topic=cloudant-how-is-data-stored-in-ibm-cloudant-#how-is-data-stored-in-ibm-cloudant-)。

## 未分区数据库
{: #non-partitioned-databases}

未分区数据库是较旧的 {{site.data.keyword.cloudant_short_notm}} 数据库类型，如果您先前使用过 CouchDB 或 {{site.data.keyword.cloudant_short_notm}}，将对此很熟悉。

在未分区数据库中，文档根据其文档标识的变换，以任意方式分发到分片中。这样文档标识和最终所处的分片之间没有真正的关系。文档标识非常相似的文档不大可能放在相同的分片上。

未分区数据库仅提供全局查询，后文将对此进行更详细的描述。

## 分区数据库
{: #partitioned-databases-database-partitioning}

分区数据库是更新的 {{site.data.keyword.cloudant_short_notm}} 数据库类型。在分区数据库中，文档通过使用_分区键_形成了逻辑分区，分区键是分区数据库中文档的文档标识的一部分。所有文档分配给一个分区，通常会为许多文档指定相同的分区键。分区的主 JSON 数据与其索引最终并存，意味着数据库能够更高效地查询分区中的数据。

分区数据库同时提供分区查询和全局查询。分区查询利用数据库集群中的数据布局，以提供更高、更可缩放的查询性能。此外，分区查询通常比全局查询更便宜。

由于分区数据库同时提供全局查询和分区查询的优势，{{site.data.keyword.cloudant_short_notm}} 建议新应用程序利用分区数据库。

## 什么是好的分区键？
{: #what-makes-a-good-partition-key-}

如果您正在考虑使用 {{site.data.keyword.cloudant_short_notm}} 的新*分区数据库*功能，那么分区键的选择非常重要。分区键必须具备以下特点：

- 许多值 - 大量小分区优于几个个大分区。
- 无热点 - 避免将系统设计为使一个分区处理很高比例的工作负载。如果在分区之间均匀分配工作量，那么数据库将更顺利运行。
- 重复 - 如果每个分区键都是唯一的，那么每个分区有一个文档。要充分利用分区数据库，每个分区必须有多个文档，即逻辑上归属在一起的文档。

让我们看一些用例，并了解好与不好的分区键是什么样的。

|用例      |描述|分区键 | 有效性|
|----------------------------|-----------------------------|---------------|------------------------------------------------------------------------------------------------------------------|
|电子商务系统 - 订单|每个订单一个文档| order_id      | 一般 - 每个分区一个文档这一点不错，但是并不提供分区查询的优点。|
|电子商务系统 - 订单|每个订单一个文档| user_id       | 好 - 用户的所有订单将保存在一起。                                                             |
|电子商务系统 - 订单|每个订单一个文档| status        | 不好 - 通过少数几个状态值（临时、已付款、已退款、已取消）对订单分组，将创建数量过少而大小过大的分区。|
| 博客平台          |每个博客帖子一个文档| author_id     | 好 - 前提是作者数量很多。易于查询每个作者的帖子。                                     |
| IOT - 传感器读数      |每个读数一个文档 | device_id     | 好 - 前提是有许多设备。确保一个设备产生的读数不会远远多于其他设备。|
| IOT - 传感器读数      |每个读数一个文档 | date          |不好 - 当前读数将导致当期日期的分区上出现“热点”。                                  |

在一些用例中，分区键没有合适的选项。
在这些情况下，未分区数据库可能是最佳选择，例如，用于存储电子邮件地址、密码散列和上次登录日期的用户数据库。这些字段均不适合用作分区键，因此必须改为使用正常的未分区数据库。

## 查询
{: #querying}

本部分描述 {{site.data.keyword.cloudant_short_notm}} 的哪个查询类型可用于全局和分区查询，以及底层查询机制的简短概述，以允许您为应用程序需要进行的每个查询选择最佳查询机制。

### 全局查询
{: #global-querying}

您可以对以下索引类型进行全局查询：

- {{site.data.keyword.cloudant_short_notm}} Query
- 视图
- 搜索
- 地理区域

进行全局查询时，数据库必须对数据库中的所有数据执行分散-集中操作。这意味着对许多单个数据库服务器发出请求。API 协调节点从所有这些服务器接收响应，然后合并这些响应以形成对客户机的单一响应。这可能涉及缓冲数据和延迟对客户机的响应，例如在数据需要排序时。

### 分区查询
{: #partition-querying}

您可以对以下索引类型进行分区查询：

- {{site.data.keyword.cloudant_short_notm}} Query
- 视图
- 搜索

进行分区查询时，数据库只能够查询单一分区中的数据。由于一个分区的数据只驻留在一个分片（带有三个副本）中，API 协调节点能够直接向托管该数据的服务器发出请求，而不需要合并来自许多服务器的响应。该节点也不必缓冲响应，因为没有合并步骤需要执行。因此，数据会更快到达客户机。

此外，数据库的大小增加时，分片的数量也需要增加。这样也会直接增加在使用全局查询时，API 协调节点需要对托管数据的服务器进行的查询数量。但是，使用分区查询时，分片的数量不影响 API 协调节点需要联系的服务器的数量。此数量保持较小时，增加数据大小不影响查询等待时间，这与全局查询不同。

## 例如：分区 IoT 读数数据
{: #example-partitioning-iot-reading-data}

此讨论非常抽象，我们通过示例具体说明。我们以物联网域为例，使用 {{site.data.keyword.cloudant_short_notm}} 作为设备读数的历史数据库。假定设备提供有关道路或桥梁等基础设施项的传感器读数。

我们假定：

- 数百个或数千个设备会报告读数。
- 每个设备具有唯一标识。
- 每个基础设施项具有唯一标识。
- 设备不会在基础设施项之间移动。
- 每个设备每 10 秒向 {{site.data.keyword.cloudant_short_notm}} 写入一次读数。这很可能是通过消息传递总线传输到 {{site.data.keyword.cloudant_short_notm}}。

在未分区数据库中，您可能允许 {{site.data.keyword.cloudant_short_notm}} 生成文档标识。另一个替代方法是按设备标识和记录时间戳记命名文档。

使用第二个方法时，我们将最终获得类似于以下内容的文档标识：

```
device-123456:20181211T11:13:24.123456Z
```

该时间戳记也可以是纪元时间戳记。

此方法将允许使用分区索引高效地查询每个设备的数据，但是可能需要使用全局索引对多个设备创建视图（例如，给定基础设施项上的所有设备）。

为了便于阐述，我们将此场景变得更复杂些，假定应用程序主要需要读取给定基础设施项而不是个别设备的所有传感器数据。

在此应用程序中，我们希望按基础设施项查询是最高效的，因此按基础设施项对数据进行分区比按标识要有意义得多。这样，可以将给定基础设施项的所有设备作为组进行高效查询。

对于按设备进行的罕见查询，有两种方法：

1. 构建按设备设置键的全局索引，并对此进行查询。如果对单个设备的查询很罕见并且不会重复，这样做更有效。
2. 构建将设备映射到基础设施的全局索引，然后向基础设施分区发出分区查询。由于可以高速缓存映射，在使用对给定设备的重复查询时，这样做有意义；假定我们的应用程序就是这种情况。

让我们了解一下其运作情况。我们将查看四个查询：

1. 一个基础设施项所有时间的读数。
1. 一个基础设施项今天的读数。
1. 一个特定设备所有时间的读数。
1. 一个特定设备今天的读数。

### 创建数据库
{: #creating-the-database}

我们使用名为 `readings` 的数据库，以及名为 `acme` 的帐户。要将其创建为分区数据库，请将 `true` 作为 `partitioned` 参数传递给数据库创建请求：

```
curl -XPUT 'https://acme.cloudant.com/readings?partitioned=true'
```

### 文档结构
{: #document-struture}

首先，让我们定义一个简单的文档格式来使用：

```json
{
    "deviceID": "device-123456",
    "infrastructureID": "bridge-9876",
    "ts": "20181211T11:13:24.123456Z",
    "reading": {
        "temperature": {"value": 12, "unit": "c"}
    }
}
```

对于此文档，使用基于一个基础设施项的分区方案，文档标识可能包含基础设施标识作为分区键，并包含设备和时间戳记作为文档键：

```
bridge-9876:device-123456-20181211T11:13:24.123456Z
```

### 创建索引
{: #creating-indexes}

对于先前描述的查询，我们将需要两个索引：

1. 将设备标识映射到基础设施标识的全局索引。
2. 将设备标识映射到读数的分区索引。

#### 创建全局视图索引
{: #creating-a-global-view-index}

视图索引是执行设备标识到基础设施标识的简单映射的最高效方式。要定义视图索引，请在 `options.partitioned` 设置为 `false` 的情况下上传设计文档，因为此索引是全局的。在真正的 `map` 函数中，您将需要围绕字段存在性做出更多防御措施，这将类似于如下所示的内容：

```json
{
    "_id": "_design/infrastructure-mapping",
    "options": {"partitioned": false},
    "views": {
        "by-device": {
            "map": "function(doc) { emit(doc.deviceID, doc.infrastructureID) }"
        }
    }
}
```

假定先前的文档是 `./view.json`，这将使用以下命令上传到数据库：

```
curl -XPOST https://acme.cloudant.com/readings -d @view.json
```

#### 创建分区的 {{site.data.keyword.cloudant_short_notm}} Query 索引
{: #creating-a-paritioned-ibm-cloudant-query-index}

要返回分区中给定设备的读数，我们可以使用 {{site.data.keyword.cloudant_short_notm}} Query 索引。对于此索引，我们向带有其 `partitioned` 字段设置为 `true` 的索引定义的 `_index` 执行 `POST` 操作。 

对于 Query 索引定义，`partitioned` 字段不嵌套在 `options` 对象中。
{: note}

对于我们的查询，我们需要两个分区索引：

1. 按时间戳记
2. 按设备标识和时间戳记

按时间戳记的定义如下所示：

```json
{
   "index": {
      "fields": [
         "ts"
      ]
   },
   "name": "timestamped-readings",
   "type": "json",
   "partitioned:" true
}
```

假定先前的文档是 `./query-index1.json`，请使用以下命令将索引上传到数据库：

```
curl -XPOST https://acme.cloudant.com/readings/_index -d @query-index1.json
```

按设备标识和时间戳记的定义如下所示：

```json
{
   "index": {
      "fields": [
         "deviceID",
         "ts"
      ]
   },
   "name": "deviceID-readings",
   "type": "json",
   "partitioned:" true
}
```

假定先前的文档是 `./query-index2.json`，请使用以下命令将索引上传到数据库：

```
curl -XPOST https://acme.cloudant.com/readings/_index -d @query-index2.json
```

### 进行查询
{: #making-queries}

我们总共要进行四个查询：

1. 一个基础设施项所有时间的读数。
1. 一个基础设施项今天的读数。
1. 一个特定设备所有时间的读数。
1. 一个特定设备今天的读数。

#### 查找一个基础设施项的所有读数
{: #finding-all-readings-for-a-piece-of-infrastructure}

由于我们的分区是基于基础设施的，我们可以对分区使用 `_all_docs`。例如，查询 `bridge-1234` 基础设施项的所有读数：

```
curl -XGET \
    'https://acme.cloudant.com/readings/_partition/bridge-1234/_all_docs?include_docs=true'
```

#### 查找一个基础设施项的最近读数
{: #finding-recent-readings-for-a piece-of-infrastructure}

此查询需要使用分区的 `timestamped-readings` 索引。我们可以向分区发出查询以获取今天的读数：

_query.json，假定今天是 2018 年 12 月 13 日：_

```json
{
    "selector": {
      "ts": { "$gte": "20181213"}
    }
}
```

向 {{site.data.keyword.cloudant_short_notm}} 发出请求时，分区嵌入在 HTTP 路径中：

```
curl -XPOST \
    'https://acme.cloudant.com/readings/_partition/bridge-1234/_find' \
    -d @query.json
```

#### 查找设备的基础设施标识
{: #finding-the-infrastructure-id-for-a-device}

我们要执行的两个查询包括：

1. 一个特定设备所有时间的读数。
2. 一个特定设备今天的读数。

对于这两个查询，我们需要使用全局 `by-device` 索引来查找设备的分区。然后，我们可以在单个分区中查询读数。虽然我们可能使用了全局索引来查询单个设备的读数，但从设备到基础设施标识的映射是高度可缓存的，它从不改变！因此，此方法允许我们大部分情况下对大多数请求使用更便宜、更高效的分区查询。

如果对设备到基础设施的映射进行高速缓存对于给定应用程序效果不佳，那么使用全局索引来直接查询设备读数可能更高效。

为了查找设备的相关分区，我们查询 `by-device` 视图，将设备标识作为键发送：

```
curl -XGET \
  'https://acme.cloudant.com/readings/_design/infrastructure-mapping/_view/by-device?keys=["device-123456"]&limit=1'
```

这将返回：

```json
{"total_rows":5,"offset":0,"rows":[
{
    "id":"bridge-9876:device-123456-20181211T11:13:24.123456Z",
    "key":"device-123456",
    "value":"bridge-9876"
}
]}
```

在所包含的行的 `value` 字段中，我们获得分区键 `bridge-9876`。

#### 查询设备的所有结果
{: #querying-for-all-results-for-a-device}

要获取设备的结果，我们在 `bridge-9876` 分区中发出设备的分区查询。将使用标准 {{site.data.keyword.cloudant_short_notm}} Query 选择器，就像发出了全局查询一样。

_query.json：_

```json
{
   "selector": {
      "deviceID": {
         "$eq": "device-123456"
      }
   }
}
```

向 {{site.data.keyword.cloudant_short_notm}} 发出请求时，分区嵌入在 HTTP 路径中：

```
curl -XPOST \
    'https://acme.cloudant.com/readings/_partition/bridge-1234/_find' \
    -d @query.json
```

#### 查询设备的最近结果
{: #querying-for-recent-results-for-a-device}

要获取设备的结果，我们在 `bridge-9876` 分区中发出设备的分区查询。选择器只是略复杂一点，但仍与等效的全局查询相同。

_query.json，假定今天是 2018 年 12 月 13 日：_

```json
{
   "selector": {
      "deviceID": {
         "$eq": "device-123456"
      },
      "ts": {
         "$gte": "20181213"
      }
   }
}
```

向 {{site.data.keyword.cloudant_short_notm}} 发出请求时，分区嵌入在 HTTP 路径中：

```
curl -XPOST \
    'https://acme.cloudant.com/readings/_partition/bridge-1234/_find' \
    -d @query.json
```
