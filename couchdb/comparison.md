---

copyright:
  years: 2019, 2020
lastupdated: "2020-03-19"

keywords: compare couchdb and cloudant

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

<!-- Acrolinx: 2020-03-19 -->

# Comparing Apache CouchDB and {{site.data.keyword.cloudant_short_notm}}
{: #couchdb-and-cloudant}

The foundation of the {{site.data.keyword.cloudant_short_notm}} managed database service is the Apache CouchDB database. {{site.data.keyword.IBM_notm}} is active in the Apache CouchDB committee, employs members of the PMC, and commits most of its feature, functions, and enhancements back to the open source project.  Over the last few years, {{site.data.keyword.IBM_notm}} made significant effort to align the core feature set of {{site.data.keyword.cloudant_short_notm}} and CouchDB. We contributed key features like {{site.data.keyword.cloudant_short_notm}} Query/Mango query language, full-text search, and partition queries to CouchDB. 
{: shortdesc}

Apache CouchDB and {{site.data.keyword.cloudant_short_notm}} are nearly fully API compatible, which means they can serve as drop-in replacements for each other in your application. They speak the same replication protocol so that you can seamlessly synchronize data between {{site.data.keyword.cloudant_short_notm}} and CouchDB instances. However, some differences between the fully managed cloud service {{site.data.keyword.cloudant_short_notm}} and self-managed open source Apache CouchDB still exist, which are discussed here. 

For more information, see the [API comparison guide](/docs/Cloudant?topic=cloudant-comparison-of-ibm-cloudant-and-couchdb-api-endpoints) for a detailed breakdown of the API endpoints available in Apache CouchDB 1.x, Apache CouchDB 2.x, and {{site.data.keyword.cloudant_short_notm}}.   

The following table shows the feature and function differences that you must be cognizant of when you use the Apache CouchDB and {{site.data.keyword.cloudant_short_notm}} data layer ecosystem. 

| Feature | CouchDB 1.6 | CouchDB 2.3.1 | CouchDB 3.0 | {{site.data.keyword.cloudant_short_notm}} on {{site.data.keyword.cloud_notm}} |
|--------------|----------------|-------------|---------------------| --- |
| Clustering    | No     | Yes | Yes | Yes |
| Fauxton Dashboard UI    | No     | Yes | Yes | Yes |
| MapReduce view    | Yes     | Yes | Yes | Yes |
| Mango/{{site.data.keyword.cloudant_short_notm}} Query    | No     | Yes | Yes | Yes |
| Full-text search    | No     | No | Yes, requires separate installer or container. | Yes |
| Geospatial    | No     | No | No | Yes |
| Partition queries    | No     | No | Yes | Yes |
| Shard splitting    | No     | No | Yes | Available as tool for {{site.data.keyword.IBM_notm}} Ops. |
| Selector on changes feed    | No     | Yes | Yes | Yes |
| Rate limits    | No    | No | No | User-defined [provisioned throughput capacity](/docs/Cloudant?topic=cloudant-ibm-cloud-public#provisioned-throughput-capacity) settings |
| Request size    | 4 GB (default)     | 4 GB (default) | 4 GB (default) | 11 MB |
| Attachment size    | 4 GB (default)     | 4 GB (default) | 4 GB (default) | 10 MB |
| Security auth    | [CouchDB Auth](https://docs.couchdb.org/en/stable/intro/security.html#){: new_window}{: external}     | [CouchDB Auth](https://docs.couchdb.org/en/stable/intro/security.html#){: new_window}{: external} | [CouchDB Auth](https://docs.couchdb.org/en/stable/intro/security.html#){: new_window}{: external} | [{{site.data.keyword.cloudant_short_notm}} legacy auth with API Keys](/docs/Cloudant?topic=cloudant-authorization), [{{site.data.keyword.cloud_notm}} IAM](/docs/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-), or [CouchDB Auth](https://docs.couchdb.org/en/stable/intro/security.html#){: new_window}{: external} |
| LDAP    | No     | No | No | No |
