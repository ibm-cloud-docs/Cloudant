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

{{site.data.keyword.cloudant_short_notm}} 資料庫受制於下列與其用量相關的限制：

## 資料庫
{: #databases-overview}

| 說明|限制  |
|--|--|
|資料庫大小|無限制|
|分割區大小|10 GB|


## 索引
{: #indexes-overview}

| 說明|限制  |
|--|--|
|# 廣域索引|無限制|
|# 分割區索引|10|

## 要求有效負載
{: #request-payload-overview}

| 說明|限制  |
|--|--|
|要求大小總計| 10 MB|
|文件大小|1 MB|
|附件大小| 10 MB|

## 要求逾時值
{: #request-timeouts}

| 說明|限制  |
|--|--|
|預設值|60 秒|
|`_partition/*` |5 秒|


## 查詢
{: #query-results}

| 說明|限制  |
|--|--|
|預設值|無限制|
|`_partition/*` 預設值|2000|
|`_search`|200|
|`_find`，使用 `text` 索引|200|
