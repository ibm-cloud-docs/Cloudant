---

copyright:
  years: 2024, 2025
lastupdated: "2025-09-22"

keywords: cloudant, http api, query, index, MapReduce, search, JSON, scalability, scale, sync, replication, SDK, http

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# What is {{site.data.keyword.cloudant_short_notm}}?
{: #what-is-cloudant}

{{site.data.keyword.cloudant_short_notm}} is a document database available as a Database-as-a-Service (DBaaS) with an HTTP API that runs in the {{site.data.keyword.cloud_notm}} to store JSON documents securely, flexibly and with high availability for always-on applications.
{: shortdesc}

{{site.data.keyword.cloudant_short_notm}} is built on the open-source database [Apache CouchDB](https://couchdb.apache.org/). It has a compatible API and replication protocol, and is run as a service so that customers don't have to worry about managing servers, networking, load balancing, database upgrades, database tuning - it is simply consumed over an encrypted HTTP API and charged by transactional usage and data storage.

Each {{site.data.keyword.cloudant_short_notm}} instance stores data in a single {{site.data.keyword.cloud_notm}} region. The stored JSON documents are automatically split into shards for horizontal scalability. Database shards are stored in triplicate across multiple availability zones allowing {{site.data.keyword.cloudant_short_notm}} to remain available even during availability zone outages.

{{site.data.keyword.cloudant_short_notm}} supports bi-directional replication across regions, to
 allow applications to also survive regional failures with minimal downtime.

## Benefits of choosing {{site.data.keyword.cloudant_short_notm}}
{: #benefits}

### Flexibility
{: #flexibility}

Unlike a [relational database](https://www.ibm.com/topics/relational-databases), {{site.data.keyword.cloudant_short_notm}} supports flexible, schema-free JSON document storage. This allows applications to store objects as JSON in the database with ease, and later change the data model without costly database schema changes or migrations.

### Scalability
{: #scalability}

{{site.data.keyword.cloudant_short_notm}} is designed to scale. Customers can start from a small, zero-cost Lite plan. They can scale to very large instances on multi-tenant or dedicated plans, which can store terabytes of data. {{site.data.keyword.cloudant_short_notm}} has linear billing, proportional to the volume of data stored and requested read, write and query throughput per second. An {{site.data.keyword.cloudant_short_notm}} instance can have multiple databases, and each database can store billions of documents.

Paid plans can be scaled up in the {{site.data.keyword.cloudant_short_notm}} web UI or API to meet expected demand, or to scale down during quiet times.

### Cross-region sync
{: #cross-region-sync}

{{site.data.keyword.cloudant_short_notm}}'s [replication](/docs/Cloudant?topic=Cloudant-replication-guide) allows two or more {{site.data.keyword.cloudant_short_notm}} databases' changes to be written bi-directionally, whether in the same instance or to a different instance, perhaps in another region or in another account. Data can be synchronised globally, and applications can write to their nearest copy of the data.

This allows {{site.data.keyword.cloudant_short_notm}} for [cross-region topologies](https://blog.cloudant.com/2017/11/07/Cloudant-replication-topologies.html). These allow your data to remain available during region failures, provide a geographically separate backup or to have a writable copy of an application's data nearer to its users - like a CDN for databases.

### Always-on Availability
{: #always-on-availability}

The {{site.data.keyword.cloudant_short_notm}} service is managed 24/7 by IBM. Hardware refreshes, disk drive replacements, operating system upgrades and {{site.data.keyword.cloudant_short_notm}} code enhancements and releases are handled with zero downtime.

### HTTP API, Dashboard, and SDKs
{: #http-api-dashboard-and-sdks}

{{site.data.keyword.cloudant_short_notm}} has an [HTTP API](/apidocs/cloudant#introduction) which makes it easy to integrate with web applications and microservices, enabling access from virtually any programming language or environment. {{site.data.keyword.cloudant_short_notm}} has a [web UI](/docs/Cloudant?topic=Cloudant-navigate-the-dashboard) to provide easy management of an instance, its databases, indexes, documents, replications and more.

{{site.data.keyword.cloudant_short_notm}} provides SDKs to help your application to interact with databases programmatically in [Node.js](https://github.com/IBM/cloudant-node-sdk), [Java](https://github.com/IBM/cloudant-java-sdk), [Python](https://github.com/IBM/cloudant-python-sdk) and [Go](https://github.com/IBM/cloudant-go-sdk).

{{site.data.keyword.cloudant_short_notm}}'s SDKs transparently interact with IBM's Identity and Access Management (IAM) service to provide access control to the {{site.data.keyword.cloudant_short_notm}} instance at a database level.

## Search, Query and Index
{: #querying-and-indexing}

{{site.data.keyword.cloudant_short_notm}} has several querying options:

- Retrieving individual documents efficiently using the document's primary `_id` field.
- [Views](/docs/Cloudant?topic=Cloudant-creating-views-mapreduce) for data querying and aggregation using customer-defined keys, built from values inside the document bodies.
- [Apache Lucene-based search indexes](/docs/Cloudant?topic=Cloudant-cloudant-search) for language-aware free text matching, or queries on one or more indexed fields.
- [{{site.data.keyword.cloudant_short_notm}} Query](/docs/Cloudant?topic=Cloudant-creating-an-ibm-cloudant-query), a MongoDB-like declarative query language that sits atop views, search indexes and the primary index to provide a higher-level API.
