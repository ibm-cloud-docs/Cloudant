---

copyright:
  years: 2019, 2023
lastupdated: "2023-02-01"

keywords: feature comparison, function comparison

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# Comparing Apache CouchDB and {{site.data.keyword.cloudant_short_notm}}
{: #couchdb-and-cloudant}

The differences between the fully managed cloud service {{site.data.keyword.cloudantfull}} and self-managed open source Apache CouchDB still exist and are discussed here.
{: shortdesc}

The foundation of the {{site.data.keyword.cloudant_short_notm}} managed database service is the Apache CouchDB database. {{site.data.keyword.IBM_notm}} is active in the Apache CouchDB committee, employs members of the PMC, and commits most of its feature, functions, and enhancements back to the open source project. Over the last few years, {{site.data.keyword.IBM_notm}} made significant effort to align the core feature set of {{site.data.keyword.cloudant_short_notm}} and CouchDB. The {{site.data.keyword.cloudant_short_notm}} team contributed key features like {{site.data.keyword.cloudant_short_notm}} Query and Mango query language, full-text search, and partition queries to CouchDB. 

Apache CouchDB and {{site.data.keyword.cloudant_short_notm}} are nearly fully API compatible, which means they can serve as drop-in replacements for each other in your application. They speak the same replication protocol so that you can seamlessly synchronize data between {{site.data.keyword.cloudant_short_notm}} and CouchDB instances.    

For more information, see the [API comparison guide](/docs/Cloudant?topic=Cloudant-comparison-of-ibm-cloudant-and-couchdb-api-endpoints) for a detailed breakdown of the API endpoints.

The following table shows the feature and function differences that you must be cognizant of when you use the Apache CouchDB and {{site.data.keyword.cloudant_short_notm}} data layer ecosystem. 

| Feature | CouchDB 1.6 | CouchDB 2.3.1 | CouchDB 3.x | {{site.data.keyword.cloudant_short_notm}} |
|--------------|----------------|-------------|---------------------| --- |
| Clustering    | No     | Yes | Yes | Yes |
| Fauxton Dashboard UI    | No     | Yes | Yes | Yes |
| MapReduce view    | Yes     | Yes | Yes | Yes |
| Mango and {{site.data.keyword.cloudant_short_notm}} Query    | No     | Yes | Yes | Yes |
| Full-text search    | No     | No | Yes, requires separate installer or container. | Yes |
| Partition queries    | No     | No | Yes | Yes |
| Shard splitting    | No     | No | Yes | Available as tool for {{site.data.keyword.IBM_notm}} Ops. |
| Selector on `changes feed`    | No     | Yes | Yes | Yes |
| Rate limits    | No    | No | No | User-defined [provisioned throughput capacity](/docs/Cloudant?topic=Cloudant-ibm-cloud-public#provisioned-throughput-capacity) settings | 
| Request size    | 4 GB (default)     | 4 GB (default) | 4 GB (default) | 11 MB |
| Attachment size    | 4 GB (default)     | 4 GB (default) | 4 GB (default) | 10 MB |
| Security auth    | [CouchDB Auth](https://docs.couchdb.org/en/stable/intro/security.html#){: external}     | [CouchDB Auth](https://docs.couchdb.org/en/stable/intro/security.html#){: external} | [CouchDB Auth](https://docs.couchdb.org/en/stable/intro/security.html#){: external} | [{{site.data.keyword.cloudant_short_notm}} legacy auth with API Keys](/docs/Cloudant?topic=Cloudant-work-with-your-account#authorization), [{{site.data.keyword.cloud_notm}} IAM](/docs/Cloudant?topic=Cloudant-managing-access-for-cloudant), or [CouchDB Auth](https://docs.couchdb.org/en/stable/intro/security.html#){: external} |
| LDAP    | No     | No | No | No |
{: caption="Table 1. Feature and function differences between {{site.data.keyword.cloudant_short_notm}} and Apache CouchDB" caption-side="top"}

The CouchDB `_show`, `_list`, `_update`, and `_rewrite` functions were deprecated in Apache CouchDB 3.0. For more information, see [deprecated feature warnings](https://docs.couchdb.org/en/stable/whatsnew/3.0.html#deprecated-feature-warnings).

As a result, these functions are no longer supported for {{site.data.keyword.cloudant_short_notm}}. They do not appear in {{site.data.keyword.cloudant_short_notm}} documentation, and while the APIs currently remain in service, their use is not recommended. The {{site.data.keyword.cloudant_short_notm}} Support team no longer supports them. 

Information on alternatives to these functions can be found in the {{site.data.keyword.cloudant_short_notm}} blog at [deprecated functions](https://blog.cloudant.com/2022/08/16/Show-list-rewrite-udpate-functions-deprecated.html).
