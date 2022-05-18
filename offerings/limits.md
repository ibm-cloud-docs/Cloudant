---

copyright:
  years: 2019, 2022
lastupdated: "2022-05-17"

keywords: databases, indexes, request payload, request timeouts, query, query results

subcollection: Cloudant

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

# Limits
{: #limits}

Limits that pertain to the usage of {{site.data.keyword.cloudantfull}} databases are shown in the following tables.
{: shortdesc}

## Databases
{: #databases-overview}

|Description|Limit|
|--|--|
|Database size|Consult the {{site.data.keyword.cloudant_short_notm}} team if your database is likely to exceed 5 TB in size.|
|Partition size|10 GB|
{: caption="Table 1. Limits for databases" caption-side="top"}

## Indexes
{: #indexes-overview}

|Description|Limit|
|--|--|
|Number of global indexes|Unlimited|
|Number of partition indexes|10|
{: caption="Table 2. Limits for indexes" caption-side="top"}

## Request payload
{: #request-payload-overview}

|Description|Limit|
|--|--|
|Total request size|10 MB|
|Document size|1 MB|
|Attachment size|10 MB|
{: caption="Table 3. Limits for request payload" caption-side="top"}

## Request timeouts
{: #request-timeouts}

|Description|Limit|
|--|--|
|Default|60 seconds|
|`_partition/*` |5 seconds|
{: caption="Table 4. Limits for request timeouts" caption-side="top"}

## Query
{: #query-results}

|Description|Limit|
|--|--|
|Default|Unlimited|
|`_partition/*` default|2000|
|`_search`|200|
|`_find` by using `text` index|200|
{: caption="Table 5. Limits for query results" caption-side="top"}
