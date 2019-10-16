---

copyright:
  years: 2019
lastupdated: "2019-10-17"

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
{:external: target="_blank" .external}

<!-- Acrolinx: 2019-01-11 -->

# Limits
{: #limits}

Limits that pertain to the usage of {{site.data.keyword.cloudant_short_notm}} databases are shown in the following tables:

## Databases
{: #databases-overview}

|Description|Limit|
|--|--|
|Database size|Unlimited|
|Partition size|10 GB|


## Indexes
{: #indexes-overview}

|Description|Limit|
|--|--|
|Number of global indexes|Unlimited|
|Number of partition indexes|10|

## Request payload
{: #request-payload-overview}

|Description|Limit|
|--|--|
|Total request size|10 MB|
|Document size|1 MB|
|Attachment size|10 MB|

## Request timeouts
{: #request-timeouts}

|Description|Limit|
|--|--|
|Default|60 seconds|
|`_partition/*` |5 seconds|


## Query
{: #query-results}

|Description|Limit|
|--|--|
|Default|Unlimited|
|`_partition/*` default|2000|
|`_search`|200|
|`_find` by using `text` index|200|
