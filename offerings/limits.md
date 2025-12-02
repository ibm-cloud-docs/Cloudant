---

copyright:
  years: 2019, 2022
lastupdated: "2022-06-23"

keywords: databases, indexes, request payload, request timeouts, query, query results

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# Limits
{: #limits}

Limits that pertain to the usage of {{site.data.keyword.cloudantfull}} databases are shown in the following tables.
{: shortdesc}

## Databases
{: #databases-overview}

|Description|Limit|
|--|--|
|Database count|200 (default) on Standard Plan. You can contact {{site.data.keyword.cloudant_short_notm}} support if you need more databases.<br/> 20 (fixed) on Lite plan|
|Database size|Consult the {{site.data.keyword.cloudant_short_notm}} team if your database is likely to exceed 5 TB in size|
|Partition size|10 GB|
{: caption="Limits for databases" caption-side="top"}

## Indexes
{: #indexes-overview}

|Description|Limit|
|--|--|
|Number of global indexes|Unlimited|
|Number of partition indexes|10|
{: caption="Limits for indexes" caption-side="top"}

## Request payload
{: #request-payload-overview}

|Description|Limit|
|--|--|
|Total request body size|64MB|
|Single JSON document size|1 MB|
|Single attachment size|10 MB|
{: caption="Limits for request payload" caption-side="top"}

If you exceed these limits, a [413 response](/apidocs/cloudant#list-of-http-codes){: external} alerts you.

When you replicate, documents or attachments that exceed these
limits don't replicate to the target database. For more information
about how to detect replication errors, see [Replication
errors](/apidocs/cloudant#getreplicationdocument){: external}.

## Request timeouts
{: #request-timeouts}

|Description|Limit|
|--|--|
|Default|60 seconds|
|`_partition/*` |5 seconds|
{: caption="Limits for request timeouts" caption-side="top"}

## Query
{: #query-results}

|Description|Limit|
|--|--|
|Default|Unlimited|
|`_partition/*`|2000|
|`_search`|200|
|`_find` when using `text` index|200|
{: caption="Limits for query results" caption-side="top"}
