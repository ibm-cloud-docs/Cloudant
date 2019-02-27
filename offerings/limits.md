---

copyright:
  years: 2019
lastupdated: "2019-02-25"

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

# Limits
{: #limits}

{{site.data.keyword.cloudant_short_notm}} databases are subject to the following limits that pertain to its usage:

## Databases
{: #databases-overview}

|Description|Limit|
|--|--|
|database size|unlimited|
|partition size|10 GB|


## Indexes
{: #indexes-overview}

|Description|Limit|
|--|--|
|# global indexes|unlimited|
|# partition indexes|10|

## Request payload
{: #request-payload-overview}

|Description|Limit|
|--|--|
|total request size|10 MB|
|document size|1 MB|
|attachment size|1 MB|

## Request timeouts
{: #request-timeouts}

|Description|Limit|
|--|--|
|default|60 seconds|
|`_partition/*` |5 seconds|


## Query
{: #query-results}

|Description|Limit|
|--|--|
|default|unlimited|
|`_partition/*` default|2000|
|`_search`|200|
|`_find` using `text` index|200|
