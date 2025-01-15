---

copyright:
  years: 2024
lastupdated: "2024-11-20"

keywords: cloudant, http api, query, index, MapReduce, search, JSON, scalability, scale, sync, replication, SDK, http

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# What is {{site.data.keyword.cloudant_short_notm}}?
{: #what-is-cloudant}

{{site.data.keyword.cloudant_short_notm}} is a Database-as-a-Service (DBaaS) with an HTTP API that runs in the {{site.data.keyword.cloud_notm}} to store JSON data securely, flexibly and with high availability for always-on applications.

{{site.data.keyword.cloudant_short_notm}} is a close relative of the open-source database [Apache CouchDB](https://couchdb.apache.org/) and is run as a service so that customers don't have to worry about managing servers, networking, load balancing, database upgrades, database tuning or license fees - it is simply consumed over an encrypted HTTP API and charged by usage and data volume.

An {{site.data.keyword.cloudant_short_notm}} instance lives in an {{site.data.keyword.cloud_notm}} region and stores JSON documents in collections called databases. Each JSON document in a database is stored in triplicate (across multiple availability zones where supported) to allow {{site.data.keyword.cloudant_short_notm}} to remain available even during availability zone outages.

Finally, data can be bi-directionally replicated across regions, to
 allow applications to survive regional failures with minimal downtime.

## Querying and Indexing
{: #querying-and-indexing}

{{site.data.keyword.cloudant_short_notm}} has a number of querying options:

- Retrieving individual documents efficiently using the document's primary `_id` field.
- [MapReduce Views](https://cloud.ibm.com/docs/Cloudant?topic=Cloudant-creating-views-mapreduce) for data selection and aggregation by customer-defined secondary keys, built from values inside the document bodies.
- [Apache Lucene-based search indexes](https://cloud.ibm.com/docs/Cloudant?topic=Cloudant-cloudant-search) for free text matching or queries on one or more nominated indexed fields.
- [{{site.data.keyword.cloudant_short_notm}} Query](https://cloud.ibm.com/docs/Cloudant?topic=Cloudant-creating-an-ibm-cloudant-query), a MongoDB-like declarative query language that sits atop MapReduce views, search indexes and the primary index to provide a higher-level API.

## Benefits
{: #benefits}

### Flexibility
{: #flexibility}

Unlike a [relational database](https://www.ibm.com/topics/relational-databases), the schema of a {{site.data.keyword.cloudant_short_notm}} document does not need to be declared to the database - indeed, many document types can co-exist in the same database. This flexibility allows developers to turn their application's objects into JSON and store them in the database with ease, and change their mind about the design later without costly database schema migrations.

### Scalability
{: #scalability}

{{site.data.keyword.cloudant_short_notm}} is designed to scale from very small and zero-cost (on our Lite plan) to very large with linear billing costs proportional to the volume of data stored and the rate of read, write and query API calls made per second. An {{site.data.keyword.cloudant_short_notm}} instance can have hundreds of databases, with the potential for a database to store billions of documents. In total, an {{site.data.keyword.cloudant_short_notm}} instance can store tens of terabytes of data.

Paid plans can be scaled up and down in the web UI or through our API to meet expected demand or to scale back during quiet times.

### Cross-region sync
{: #cross-region-sync}

{{site.data.keyword.cloudant_short_notm}}'s [replication](https://cloud.ibm.com/docs/Cloudant?topic=Cloudant-replication-guide) allows two or more {{site.data.keyword.cloudant_short_notm}} databases' changes to be written bi-directionally, whether in the same instance or to a different instance, perhaps in another location. This allows [cross-region topologies](https://blog.cloudant.com/2017/11/07/Cloudant-replication-topologies.html) to be deployed for even higher availability, to provide a geographically separate backup or to have a writable copy of an application's data nearer to its users - like a CDN for databases.

### Always-on Availability
{: #always-on-availability}

The {{site.data.keyword.cloudant_short_notm}} service is managed 24/7 by IBM Engineers across the globe. Hardware refreshes, disk drive replacements, operating system upgrades and {{site.data.keyword.cloudant_short_notm}} code releases are all handled with zero downtime.

### HTTP API, Dashboard, and SDKs
{: #http-api-dashboard-and-sdks}

{{site.data.keyword.cloudant_short_notm}} has an [HTTP API](https://cloud.ibm.com/apidocs/cloudant#introduction) and each instance has a [web UI](https://cloud.ibm.com/docs/Cloudant?topic=Cloudant-navigate-the-dashboard) to provide easy management of an {{site.data.keyword.cloudant_short_notm}} instance, its databases, indexes and documents.

{{site.data.keyword.cloudant_short_notm}} provides SDKs to help your application to interact with databases programmatically in [Node.js](https://github.com/IBM/cloudant-node-sdk), [Java](https://github.com/IBM/cloudant-java-sdk), [Python](https://github.com/IBM/cloudant-python-sdk) and [Go](https://github.com/IBM/cloudant-go-sdk).

{{site.data.keyword.cloudant_short_notm}}'s SDKs transparently interact with IBM's Identity and Access Management (IAM) service to provide access control to the {{site.data.keyword.cloudant_short_notm}} instance at a database level.
