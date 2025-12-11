---

copyright:
  years: 2024, 2025
lastupdated: "2025-12-11"

keywords: cloudant, http api, query, index, MapReduce, search, JSON, scalability, scale, sync, replication, SDK, http

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# What is {{site.data.keyword.cloudant_short_notm}}?
{: #what-is-cloudant}

{{site.data.keyword.cloudant_short_notm}} is a document database available as a Database-as-a-Service (DBaaS) that runs in the {{site.data.keyword.cloud_notm}}. It stores JSON documents securely, flexibly and with high availability for always-on applications.
{: shortdesc}

{{site.data.keyword.cloudant_short_notm}} is built on the open-source database [Apache CouchDB](https://couchdb.apache.org/). It has a compatible API and replication protocol, and is run as a service. Customers don't have to worry about managing servers, networking, load balancing, database upgrades, database tuning - it is simply consumed over a HTTPS API and charged by transactional usage and data storage.

## Benefits of choosing {{site.data.keyword.cloudant_short_notm}}
{: #benefits}

### Application resilience
{: #application-resilience}

{{site.data.keyword.cloudant_short_notm}} is designed for the needs of applications requiring the highest levels of resilience:

- Data remains readable and writable during zone outages with no customer action needed.
- Customers can set up multi-region, active-active databases using {{site.data.keyword.cloudant_short_notm}} replication. Reads and writes can be sent to any region at any time, so customers can switch to available regions seamlessly.
- All database upgrades, security patching and hardware maintenance is carried out by IBM with zero downtime. There are no maintenance windows.

### Serverless
{: #serverless}

Customers of {{site.data.keyword.cloudant_short_notm}} have no servers to manage, disk to scale and no software to maintain. Instead, they manage their performance and costs using pay-as-you-go pricing based on transactional usage and data storage. They access data through an always-on HTTPS API.

{{site.data.keyword.cloudant_short_notm}} is designed to scale. Customers can start from a small, zero-cost Lite plan. They can scale to very large instances on multi-tenant or dedicated plans, which can store terabytes of data. {{site.data.keyword.cloudant_short_notm}} has linear billing, proportional to the volume of data stored and requested read, write and query throughput per second. An {{site.data.keyword.cloudant_short_notm}} instance can have multiple databases, and each database can store billions of documents.

Paid plans can be scaled up in the {{site.data.keyword.cloudant_short_notm}} web UI or API to meet expected demand, or to scale down during quiet times.

### Cross-region sync
{: #cross-region-sync}

By using cross-region database syncing, {{site.data.keyword.cloudant_short_notm}} customers can ensure their applications remain online during complete regional outages. Data can be synchronised between many regions, increasing resilience further.

{{site.data.keyword.cloudant_short_notm}}'s [replication](/docs/Cloudant?topic=Cloudant-replication-guide) allows two or more {{site.data.keyword.cloudant_short_notm}} databases' changes to be written bi-directionally, whether in the same instance or to a different instance, perhaps in another region or in another account. Data can be synchronised globally, and applications can write to their nearest copy of the data.

Cross-region replication can be used for disaster recovery, retaining a geographically separated data backup or to have a writable copy of data near to your users for low-latency reads and writes. Read more about {{site.data.keyword.cloudant_short_notm}} [cross-region topologies](https://blog.cloudant.com/2017/11/07/Cloudant-replication-topologies.html).

### Flexibility
{: #flexibility}

Unlike a [relational database](https://www.ibm.com/topics/relational-databases), {{site.data.keyword.cloudant_short_notm}} supports flexible, schema-free JSON document storage. Applications to store objects as JSON in the database, and can later change the data model without costly database schema changes or migrations.

{{site.data.keyword.cloudant_short_notm}} has several querying options:

- Retrieving individual documents efficiently using the document's primary `_id` field.
- [Views](/docs/Cloudant?topic=Cloudant-creating-views-mapreduce) for data querying and aggregation using customer-defined keys, built from values inside the document bodies.
- [Apache Lucene-based search indexes](/docs/Cloudant?topic=Cloudant-cloudant-search) for language-aware free text matching, or queries on one or more indexed fields.
- [{{site.data.keyword.cloudant_short_notm}} Query](/docs/Cloudant?topic=Cloudant-creating-an-ibm-cloudant-query), a MongoDB-like declarative query language that sits atop views, search indexes and the primary index to provide a higher-level API.

### HTTPS API, Dashboard, and SDKs
{: #http-api-dashboard-and-sdks}

The {{site.data.keyword.cloudant_short_notm}} [HTTPS API](/apidocs/cloudant#introduction) makes it easy to integrate with web applications and microservices, enabling access from virtually any programming language or environment. {{site.data.keyword.cloudant_short_notm}} has a [web UI](/docs/Cloudant?topic=Cloudant-navigate-the-dashboard) to provide easy management of an instance, its databases, indexes, documents, replications and more.

{{site.data.keyword.cloudant_short_notm}} provides SDKs to help your application to interact with databases in [Node.js](https://github.com/IBM/cloudant-node-sdk), [Java](https://github.com/IBM/cloudant-java-sdk), [Python](https://github.com/IBM/cloudant-python-sdk) and [Go](https://github.com/IBM/cloudant-go-sdk).

{{site.data.keyword.cloudant_short_notm}}'s SDKs transparently interact with IBM's Identity and Access Management (IAM) service to provide access control to the {{site.data.keyword.cloudant_short_notm}} instance at a database level.
