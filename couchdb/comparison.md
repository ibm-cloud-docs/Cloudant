---

copyright:
  years: 2019, 2021
lastupdated: "2021-10-29"

keywords: feature comparison, function comparison

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

<!-- Acrolinx: 2021-04-13 -->

# Comparing Apache CouchDB and {{site.data.keyword.cloudant_short_notm}}
{: #couchdb-and-cloudant}

The differences between the fully managed cloud service {{site.data.keyword.cloudantfull}} and self-managed open source Apache CouchDB still exist and are discussed here.
{: shortdesc}

The foundation of the {{site.data.keyword.cloudant_short_notm}} managed database service is the Apache CouchDB database. {{site.data.keyword.IBM_notm}} is active in the Apache CouchDB committee, employs members of the PMC, and commits most of its feature, functions, and enhancements back to the open source project. Over the last few years, {{site.data.keyword.IBM_notm}} made significant effort to align the core feature set of {{site.data.keyword.cloudant_short_notm}} and CouchDB. The {{site.data.keyword.cloudant_short_notm}} team contributed key features like {{site.data.keyword.cloudant_short_notm}} Query and Mango query language, full-text search, and partition queries to CouchDB. 

Apache CouchDB and {{site.data.keyword.cloudant_short_notm}} are nearly fully API compatible, which means they can serve as drop-in replacements for each other in your application. They speak the same replication protocol so that you can seamlessly synchronize data between {{site.data.keyword.cloudant_short_notm}} and CouchDB instances.    

For more information, see the [API comparison guide](/docs/Cloudant?topic=Cloudant-comparison-of-ibm-cloudant-and-couchdb-api-endpoints) for a detailed breakdown of the API endpoints.

The following table shows the feature and function differences that you must be cognizant of when you use the Apache CouchDB and {{site.data.keyword.cloudant_short_notm}} data layer ecosystem. 

| Feature | CouchDB 1.6 | CouchDB 2.3.1 | CouchDB 3.x | {{site.data.keyword.cloudant_short_notm}} | {{site.data.keyword.cloudant_short_notm}} on Transaction Engine |
|--------------|----------------|-------------|---------------------| --- | --- |
| Clustering    | No     | Yes | Yes | Yes | Yes |
| Fauxton Dashboard UI    | No     | Yes | Yes | Yes | Yes |
| MapReduce view    | Yes     | Yes | Yes | Yes | Yes |
| Mango and {{site.data.keyword.cloudant_short_notm}} Query    | No     | Yes | Yes | Yes | Yes |
| Full-text search    | No     | No | Yes, requires separate installer or container. | Yes | No |
| Geospatial    | No     | No | No | Yes | No |
| Partition queries    | No     | No | Yes | Yes | No |
| Shard splitting    | No     | No | Yes | Available as tool for {{site.data.keyword.IBM_notm}} Ops. | Yes |
| Selector on `changes feed`    | No     | Yes | Yes | Yes | Yes |
| Rate limits    | No    | No | No | User-defined [provisioned throughput capacity](/docs/Cloudant?topic=Cloudant-ibm-cloud-public#provisioned-throughput-capacity) settings | User-defined settings |
| Request size    | 4 GB (default)     | 4 GB (default) | 4 GB (default) | 11 MB | 64 MB |
| Attachment size    | 4 GB (default)     | 4 GB (default) | 4 GB (default) | 10 MB | Not applicable |
| Security auth    | [CouchDB Auth](https://docs.couchdb.org/en/stable/intro/security.html#){: external}     | [CouchDB Auth](https://docs.couchdb.org/en/stable/intro/security.html#){: external} | [CouchDB Auth](https://docs.couchdb.org/en/stable/intro/security.html#){: external} | [{{site.data.keyword.cloudant_short_notm}} legacy auth with API Keys](/docs/Cloudant?topic=Cloudant-work-with-your-account#authorization), [{{site.data.keyword.cloud_notm}} IAM](/docs/Cloudant?topic=Cloudant-managing-access-for-cloudant), or [CouchDB Auth](https://docs.couchdb.org/en/stable/intro/security.html#){: external} |  [{{site.data.keyword.cloud_notm}} IAM](/docs/Cloudant?topic=Cloudant-managing-access-for-cloudant) |
| LDAP    | No     | No | No | No | No |
{: caption="Table 1. Feature and function differences between {{site.data.keyword.cloudant_short_notm}} and Apache CouchDB" caption-side="top"}
