---

copyright:
  years: 2015, 2021
lastupdated: "2021-04-14"

keywords: database-as-a-service,json document store, lite plan, standard plan, enterprise plan

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
{:video: .video}

<!-- Acrolinx: 2021-04-14 -->

# Migration overview
{: #migrating-to-ibm-cloudant-on-ibm-cloud}

The [{{site.data.keyword.cloudantfull}}](https://www.ibm.com/cloud/cloudant){: new_window}{: external} database-as-a-service offering is a JSON document store that runs on multi-tenant clusters. The service is available with a choice of geographical locations with predictable costs, scalability, and a service-level agreement (SLA).
{: shortdesc}

You can migrate to an {{site.data.keyword.cloudant_short_notm}} Lite or Standard plan instance on {{site.data.keyword.cloud_notm}} from one of the following plans:

Plan | Description
-----|------------
{{site.data.keyword.cloudant_short_notm}} Enterprise | Dedicated, single-tenant clusters
{{site.data.keyword.cloudant_localfull}} | The self-hosted, packaged installation of {{site.data.keyword.cloudant_short_notm}}.
Apache CouchDB | The self-hosted, open source database on which {{site.data.keyword.cloudant_short_notm}} is based.
{: caption="Table 1. {{site.data.keyword.cloudant_short_notm}} migration paths" caption-side="top"}

## Benefits of the {{site.data.keyword.cloudant_short_notm}} Lite and Standard plans
{: #what-are-the-benefits-of-the-ibm-cloudant-lite-and-standard-plans-}

With the Standard plan, you can *reserve throughput capacity* for your database service, that is, to specify how much throughput your application's database is going to need to handle demand. The Standard plan also charges for the amount of storage you use. Capacity is measured with the following metrics:

Metric | Description
-------|------------
Reads per second | The rate at which simple document fetches are performed, for example, retrieving a document by its `_id`, or querying against a partitioned database that uses a partition key.
Writes per second | The rate at which data is written to the database. API calls dealing with document creation, update, or deletion count as "writes".
Global Queries per second | The rate at which the database is queried by using global indices, typically by accessing the `_find` endpoint or by using secondary MapReduce, search, or geospatial indices.
Storage | The amount of disk space occupied by your JSON data, attachments, and secondary indices.
{: caption="Table 2. Capacity metrics" caption-side="top"}

As an example, the Lite plan offers 20 reads per second, 10 writes per second, 5 global queries per second, and 1 GB of storage for free. This plan is ideal when you're evaluating the product and during product development. When your application goes into QA or production, switch to the Standard plan to scale the instance. The Standard plan's smallest capacity has 100 reads per second, 50 writes per second, 5 global queries per second, and 20 GB of storage for ~USD$76.65 per month. You can buy extra storage, which is charged by the GB.

By using the slider in the {{site.data.keyword.cloudant_short_notm}} Dashboard, you can reserve a smaller or larger capacity for your {{site.data.keyword.cloudant_short_notm}} service whenever you need it:

![Slider](../images/slider.png){: caption="Figure 1. Slider" caption-side="bottom"}

The amount that you can change the throughput capacity is limited to a maximum of 10 units per change with a maximum of one change per hour. Notice the "change limit" point on the slider. Changes downward are unlimited in size, but still subject to the time limit.
{: tip}

You're billed on the highest capacity that is selected in any given hourly window. Your database throughput can scale up to deal with seasonal demands and scale down again for the quiet times. Your monthly bill is always predictable; upgrades are automatic; and your SLA is [99.99%](http://www-03.ibm.com/software/sla/sladb.nsf/sla/bm?OpenDocument){: new_window}{: external}.

If you exceed your quota of reads, writes, and global queries in a given second, the {{site.data.keyword.cloudant_short_notm}} API responds with a `429: too many requests` HTTP response. Your application might retry the request later. You can use our official libraries to retry such requests with an exponential back off. 





