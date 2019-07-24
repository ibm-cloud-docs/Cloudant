---

copyright:
  years: 2015, 2019
lastupdated: "2019-06-12"

keywords: generate uuid, record payments, add additional documents, advantages

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

# 在 {{site.data.keyword.cloudant_short_notm}} 中将相关文档分组在一起
{: grouping-related-documents-together-in-ibm-cloudant}

传统上，电子商务系统是使用关系数据库构建的。这些数据库通常使用连接在一起的多个表，以记录销售、客户详细信息、采购的产品以及交货跟踪信息。关系数据库能提供高度一致性，这意味着应用程序开发者可以利用数据库的优势来构建应用程序，包括使用集合之间的连接、通过枚举来记录对象的状态以及通过数据库交易来保证原子操作。

相对于一致性，{{site.data.keyword.cloudantfull}} 更偏重于可用性。Cloudant 是一个高可用性、高容错性、具有最终一致性的分布式数据库。优势是客户的购物服务会始终可用且有足够的扩展能力，能处理同一时间多个用户采购的情况。这意味着应用程序可以利用 {{site.data.keyword.cloudant_short_notm}} 的优点，而不用像对关系数据库那样进行处理。

本主题中的讨论内容概述了构建电子商务系统所涉及的一些因素，该系统将利用 {{site.data.keyword.cloudant_short_notm}} 的优势，并运用适用于其他许多领域的概念，例如：

-   使用多个文档来表示采购的状态，而不是频繁更新单个文档。
-   按顺序存储相关对象的副本，而不是连接到其他集合。
-   创建视图以按 `order_id` 整理文档，从而反映出采购的当前状态。

例如，可以创建一个 `purchase` 文档，其中包含订购的商品、客户信息、成本和交货信息等详细信息。

*描述采购的示例文档：*

```json
{
    "_id": "023f7a21dbe8a4177a2816e4ad1ea27e",
    "type": "purchase",
    "order_id": "320afa89017426b994162ab004ce3383",
    "basket": [
        {
            "product_id": "A56",
            "title": "Adele - 25",
            "category": "Audio CD",
            "price": 8.33,
            "tax": 0.2,
            "quantity": 2
        },
        {
            "product_id": "B32",
            "title": "The Lady In The Van - Alan Bennett",
            "category": "Paperback book",
            "price": 3.49,
            "tax": 0,
            "quantity": 2
        }
    ],
    "account_id": "985522332",
    "delivery": {
        "option": "Next Day",
        "price": 2.99,
        "address": {
            "street": "17 Front Street",
            "town": "Middlemarch",
            "postcode": "W1A 1AA"
        }
    },
    "pretax" : 20.15,
    "tax" : 3.32,
    "total": 26.46
}
```
{: codeblock}

此文档提供了足够的采购记录数据，可在 Web 页面或电子邮件上呈现订单摘要，而无需访存其他记录。请注意有关订单的关键详细信息，特别是：

-   basket 包含对存储在其他位置的产品数据库的引用标识 (`product_id`)。
-   basket 复制此记录中的一些产品数据，这些数据足以记录在销售点采购的商品的状态。
-   该文档不包含用于标记订单状态的字段。日后将添加其他文档来记录付款和交货。
-   数据库在将文档插入到数据库中时，会自动生成文档 `_id`。
-   每个采购记录都提供有唯一标识 (`order_id`)，以便日后引用该订单。 
 
客户下订单时（通常在客户进入 Web 站点上的“结帐”阶段时），会创建类似于先前示例的采购单记录。 

## 生成自己的唯一标识 (UUID)
{: #generating-your-own-unique-identifiers-uuids-}

在关系数据库中，通常使用顺序的“自动递增”编号，但在分布式数据库中，数据分布在服务器集群中，因此会使用更长的 UUID 来确保文档通过自己的唯一标识进行存储。

要创建唯一标识（例如，`order_id`）以供在应用程序中使用，请在 {{site.data.keyword.cloudant_short_notm}} API 上调用 [`GET _uuids` 端点](/docs/services/Cloudant?topic=cloudant-advanced-api#-get-_uuids-)。数据库将为您生成一个标识。通过添加 `count` 参数，可以使用同一个端点来生成多个标识，例如 `/_uuids?count=10`。

## 记录付款
{: #recording-payments}

客户成功为其商品付款后，会将更多记录添加到数据库以记录订单。

*付款记录的示例：*

```json
{
    "_id": "bf70c30ea5d8c3cd088fef98ad678e9e",
    "type": "payment",
    "account_id": "985522332",
    "order_id": "320afa89017426b994162ab004ce3383",
    "value": 6.46,
    "method": "credit card",
    "payment_reference": "AB9977G244FF2F667"
}
...
{
    "_id": "12c0ea6cd3d2c6e3b1d34442aea6a2d9",
    "type": "payment",
    "account_id": "985522332",
    "order_id": "320afa89017426b994162ab004ce3383",
    "value": 20.00,
    "method": "voucher",
    "payment_reference": "Q88775662377224"
}
```
{: codeblock}

在上面的示例中，客户是通过提供信用卡和兑换预付券付款的。这两笔付款加总后等于订单金额。每笔付款都作为单独的文档写入 {{site.data.keyword.cloudant_short_notm}}。

您可以通过创建您所知有关 `order_id` 的所有信息的视图来查看订单的状态。此视图将支持包含以下信息的分类帐： 

-   采购总计作为正数。
-   针对帐户的付款作为负数。

可使用 map 函数来确定必需值。

*用于查找采购总计和付款值的示例 map 函数：* 

```javascript
function (doc) {
    if (doc.type === 'purchase') {
        emit(doc.order_id, doc.total);
    } else {
        if (doc.type === 'payment') {
            emit(doc.order_id, -doc.value);
        }
    }
}
```
{: codeblock}

使用内置 [`_sum` reducer](/docs/services/Cloudant?topic=cloudant-views-mapreduce#built-in-reduce-functions) 可将输出生成为付款事件的分类帐。

*使用内置 `_sum` reducer 的示例（使用 `?reduce=false` 进行查询）：*

```json
{
    "total_rows":3,"offset":0,"rows":[
        {
            "id":"320afa89017426b994162ab004ce3383",
            "key":"985522332",
            "value":26.46
        },
        {
            "id":"320afa89017426b994162ab004ce3383",
            "key":"985522332",
            "value":-20
        },
        {
            "id":"320afa89017426b994162ab004ce3383",
            "key":"985522332",
            "value":-6.46
        }
    ]
}
```
{: codeblock}

或者，可以生成按 `order_id` 分组的总计。

*按 `order_id` 分组的总计示例，其中 `?group_level=1`：*

```json
{
    "rows":[
        {
            "key":"320afa89017426b994162ab004ce3383",
            "value":0
        }
    ]
}
```
{: codeblock}

由于上面示例中的视图返回的订单值为 0，因此结果指示该订单已完全支付。原因是采购单总计正值与付款金额负值相互抵消。将事件记录为单独的文档（即，订单一个文档，每个付款一个文档）是 {{site.data.keyword.cloudant_short_notm}} 中的一种良好做法，因为这样一来，多个进程同时修改同一文档时就不会产生冲突。

## 添加其他文档
{: #adding-additional-documents}

可以向数据库添加其他单独的文档，以便在供应和分派订单时记录以下状态更改：

-   分派通知。
-   交货回执。
-   退款记录。

数据到达时，{{site.data.keyword.cloudant_short_notm}} 会将其分别写入各个文档。因此，不必修改核心采购文档。

## 在 {{site.data.keyword.cloudant_short_notm}} 中存储采购单的优势
{: #advantages-of-storing-purchase-orders-in-ibm-cloudant}

通过使用 {{site.data.keyword.cloudant_short_notm}} 来存储采购单信息，将允许订购系统高度可用、可缩放，从而支持您处理大量数据和高并行访问率。通过对仅写入一次的单独文档中的数据进行建模，可以确保文档永远不会发生冲突，例如在单独的进程对同一文档进行并行访问期间。

此外，文档可以包含其他集合中存在的数据的副本，以表示（而不是依赖于）使用外键连接数据。例如，记录采购时购物篮的状态。如此一来，只需调用一次按照 `order_id` 对相关文档进行分组的 {{site.data.keyword.cloudant_short_notm}} 视图，即可访存订单的状态。
