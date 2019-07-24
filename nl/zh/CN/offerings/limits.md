---

copyright:
  years: 2019
lastupdated: "2019-06-12"

keywords: databases, indexes, request payload, request timeouts, query

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

<!-- Acrolinx: 2019-01-11 -->

# 限制
{: #limits}

{{site.data.keyword.cloudant_short_notm}} 数据库的使用受以下限制约束：

## 数据库
{: #databases-overview}

|描述|限制|
|--|--|
|数据库大小|无限制|
|分区大小|10 GB|


## 索引
{: #indexes-overview}

|描述|限制|
|--|--|
|# 全局索引数|无限制|
|# 分区索引数|10|

## 请求有效内容
{: #request-payload-overview}

|描述|限制|
|--|--|
|请求总大小|10 MB|
|文档大小|1 MB|
|附件大小|10 MB|

## 请求超时
{: #request-timeouts}

|描述|限制|
|--|--|
|缺省值|60 秒|
|`_partition/*` | 5 秒|


## 查询
{: #query-results}

|描述|限制|
|--|--|
|缺省值|无限制|
|`_partition/*` 缺省值|2000|
|`_search`|200|
|`_find` 使用`文本`索引|200|
