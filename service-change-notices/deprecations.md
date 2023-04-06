---

copyright:
  years: 2023
lastupdated: "2023-04-06"

keywords: security, compliance, standardize resource configuration

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# Service Changes and Deprecations for {{site.data.keyword.cloudant_short_notm}}
{: #deprecations-for-ibm-cloudant}

You can see the deprecations for {{site.data.keyword.cloudantfull}} here.

## {{site.data.keyword.cloudant_short_notm}} Geospatial notice
{: #cloudant-nosql-db-geospatial-dep}

Support for the {{site.data.keyword.cloudant_short_notm}} Geospatial capability ends on 31 January 2023. In many cases, existing applications fail if changes are not made to address the removal of this functionality before the end of support.
{: deprecated}

### What is {{site.data.keyword.cloudant_short_notm}} Geospatial?
{: #what-is-cloudant-geospatial-dep}

Data is stored as GeoJSON in the {{site.data.keyword.cloudant_short_notm}} database to describe point, line, polygon, multi-point, multi-line, and multi-polygon objects. Each object, as well as the geographic information, can have optional properties: Metadata about the object, which is returned in the search results.

Again, an index is defined as a JavaScript function, and then, queries can be used to ask questions of your collection of geographic features. For example, find me the nearest object to this point; find objects within this polygon; find objects along this path; or find objects that intersect with this object.

To summarize, {{site.data.keyword.cloudant_short_notm}} Geo is something unique to the {{site.data.keyword.cloudant_short_notm}} service and is used to perform advanced geospatial queries against your databases of GeoJSON objects. It cannot be combined with other index types. It is only of use to Geographic Information Systems or use-cases that have a purely geographic purpose.

### What is changing?
{: #what-is-changing-dep}

As of 1 February 2023, the following conditions apply:
- Users cannot query `/$DATABASE/_design/$DDOCS/_geo` endpoints. Requests to those endpoints return a `404 Not Found` response.
- Users can define indexes by using the `st_indexes` keyword in design documents, but those indexes are ignored by the service. This practice ensures that existing design documents can be updated, and replications that contain geospatial indexes do not fail. Existing Geo indexes are deleted, and customers are no longer billed for the space they consume.
- {{site.data.keyword.cloud}} support no longer answers questions or assists with issues that are related to the Geospatial feature of the {{site.data.keyword.cloudant_short_notm}} service.
{: important}

### Alternatives to geospatial
{: #alternatives-to-geospatial-dep}

Many simple geospatial queries can be done without using the Geospatial capability that was removed from the {{site.data.keyword.cloudant_short_notm}} service. These alternatives are described in this [{{site.data.keyword.cloudant_short_notm}} blog post](https://blog.cloudant.com/2022/06/28/Simple-Geospatial-Queries.html){: external}.

## Transaction Engine notice
{: #transaction-engine-notice-dep}

The {{site.data.keyword.cloudant_short_notm}} on Transaction Engine service ends on 1 February 2023. You can no longer create new instances of {{site.data.keyword.cloudant_short_notm}} on Transaction Engine. On 1 February 2023, all instances of {{site.data.keyword.cloudant_short_notm}} on Transaction Engine will be permanently disabled and deprovisioned. Users of existing instances need to migrate from the service before the end of service date. You can find guidance on migrating from {{site.data.keyword.cloudant_short_notm}} on Transaction Engine to {{site.data.keyword.cloudant_short_notm}} Standard here: [Migrating from TXE](https://blog.cloudant.com/2022/01/14/Migrating-from-Cloudant-TXE-to-Standard){: external}.
{: deprecated}

### What is Transaction Engine?
{: #what-is-txe-dep}

{{site.data.keyword.cloudant_short_notm}} has an architecture option, which is underpinned by a Transaction Engine. This architecture aims to provide the best of both nonrelational and relational data stores combining scale, fault tolerance, consistency, security, and speed at optimal cost. The Transaction Engine architecture is compared to the "Classic" architecture for clarity in the documentation. Instances that are provisioned with the `Standard on Transaction Engine` plan are deployed by using this architecture, while instances on the `Lite` and `Standard` plan are deployed on the "Classic" architecture.

## {{site.data.keyword.cloudant_short_notm}} dbcopy feature removal
{: #dbcopy-feature-removal-dep}

As of 1 July 2023, {{site.data.keyword.cloudant_short_notm}}'s dbcopy feature (also known as "Chained MapReduce" or "view chaining") will cease to function. The dbcopy feature was [removed from our documentation in 2016](https://cloud.ibm.com/docs/Cloudant?topic=Cloudant-classic-release-notes#cloudant-feb16) and [since November 2022, new users cannot configure dbcopy](https://cloud.ibm.com/docs/Cloudant?topic=Cloudant-classic-release-notes#cloudant-nov22). *Starting 1 July 2023, the dbcopy feature will be removed from the {{site.data.keyword.cloudant_short_notm}} service entirely.*
{: shortdesc}

### What is dbcopy?
{: #what-is-dbcopy-dep}

{{site.data.keyword.cloudant_short_notm}} allows materialized MapReduce views to be created on a database - a secondary index structure that contains user-defined keys and values. MapReduce views exist and are queried in the same path as the primary database.

With the "dbcopy" feature configured, the MapReduce data is instead written to a second database. The second database then contains the key/value pairs that would usually be found in the materialized view of a normal MapReduce view. The dbcopy feature was used to allow view data to be "chained" (for example, the creation of views of views) or to provide a primitive *join* functionality between documents.

### What happens after the feature is removed?
{: #what-happens-after-removal-dep}

The primary database continues to function as normal, but any MapReduce indexes with dbcopy configured no longer write data to the secondary database. The secondary database still exists, but it cannot be updated when the primary data changes.

### How do I know whether my MapReduce views use dbcopy?
{: #how-do-i-know-if-mapreduce-uses-dbcopy-dep}

MapReduce index definitions are stored in a database's [design documents](https://cloud.ibm.com/docs/Cloudant?topic=Cloudant-design-documents). These MapReduce index definitions contain JavaScript that programmatically decides what data from the document makes it into the view, as shown in the following example:

```js
{
  "_id": "_design/myview",
  "views": {
    "view": {
      "map": "function(doc) { emit(doc.date, doc.price) }",
      "dbcopy": "another_database"
    }
  }
}
```
{: codeblock}

If a view definition contains an attribute that is called `dbcopy`, as is the case with the previous example design document, then the dbcopy feature **is in use and is affected by the feature's removal**.

### Alternatives to dbcopy
{: #alternatives-to-dbcopy-dep}

No alternative to the dbcopy feature exists. Simply removing the "dbcopy" attribute from a design document instructs {{site.data.keyword.cloudant_short_notm}} to build a normal MapReduce view. This view contains the same data that was being copied to the secondary database, for example:

```js
{
  "_id": "_design/myview",
  "views": {
    "view": {
      "map": "function(doc) { emit(doc.date, doc.price) }"
    }
  }
}
```
{: codeblock}

The dbcopy key was removed, so this view becomes a normal MapReduce view that you can [query by using the {{site.data.keyword.cloudant_short_notm}} API](https://cloud.ibm.com/docs/Cloudant?topic=Cloudant-using-views#querying-a-view).
{: note}

If you are concerned about the removal of the dbcopy feature, you can open a support ticket and ask to consult with our Client Architecture team.

## {{site.data.keyword.cloudant_short_notm}} replications no longer support HTTP
{: #replications-no-longer-support-http}

As of 1 July 2023, the replicator for {{site.data.keyword.cloudant_short_notm}} no longer supports the HTTP protocol – it supports only the HTTPS protocol to ensure that customer data is always encrypted in flight.

### What is replication?
{: #what-is-replication}

{{site.data.keyword.cloudant_short_notm}} replications allow you to copy one database's changes to another {{site.data.keyword.cloudant_short_notm}} database. This database is in the same {{site.data.keyword.cloudant_short_notm}} instance or in another {{site.data.keyword.cloudant_short_notm}} instance on the other side of the world. {{site.data.keyword.cloudant_short_notm}} also replicates to and from Apache CouchDB and PouchDB databases on the public internet.

### What happens after HTTP support is removed?
{: #after-http-support-is-removed}

Following this change, a replication that is configured with the `http://` protocol fails permanently. The replication job is not retried. Any replications using the `https://` protocol are unaffected.

### How do I know whether my replications use HTTP?
{: #how-do-i-check-my-http-use}

Replication job definitions are stored in documents in an {{site.data.keyword.cloudant_short_notm}} account's `_replicator` database, for example:

```js
{
  "_id": "myreplicationjob",
  "source": "https://mycloudantservice.cloudant.com/products",
  "target": "http://myselfhostedcouchdb.mydomain.com/products"
}
```
{: codeblock}

If either the `source` or `target` URLs contain an `http://` prefix, then **the replication job is affected** and action must be taken to ensure the replication runs.

### How do I avoid being affected?
{: #how-can-i-avoid-being-affected}

If a self-hosted CouchDB service supports HTTPS, then change the replication definition to contain an `https://` prefix, as shown in the following example:

```js
{
  "_id": "myreplicationjob",
  "source": "https://mycloudantservice.cloudant.com/products",
  "target": "https://myselfhostedcouchdb.mydomain.com/products"
}
```
{: codeblock}

{{site.data.keyword.cloudant_short_notm}} restarts the replication from where the old replication job stopped.

If a self-hosted CouchDB service does _not_ support HTTPS, CouchDB can mediate replication jobs instead of {{site.data.keyword.cloudant_short_notm}}. For example, stop the replication job that runs on the {{site.data.keyword.cloudant_short_notm}} side and set up a replication job on a self-hosted Apache CouchDB service to "pull" the data from {{site.data.keyword.cloudant_short_notm}}.

{{site.data.keyword.cloudant_short_notm}} supports only `https://` traffic, so if {{site.data.keyword.cloudant_short_notm}} is to be the `source` or `target` in a self-hosted replication definition, it must be configured with an `https://` prefix.

## {{site.data.keyword.cloudant_short_notm}} Correction to Provisioned Throughput accounting for partioned `_find` API notice
{: #find-api-change}

An accounting error exists in {{site.data.keyword.cloudant_short_notm}} that results in undercounting of the operations that are associated with this API against the [provisioned throughput](https://cloud.ibm.com/docs/Cloudant?topic=Cloudant-ibm-cloud-public#provisioned-throughput-capacity) capacity of an {{site.data.keyword.cloudant_short_notm}} instance. You can find the correct accounting in the {{site.data.keyword.cloudant_short_notm}} API documentation under [Query a list of all documents in a database partition](/apidocs/cloudant#getpartitionalldocs-partitioned-databases). Until now, this accounting operation was not implemented correctly.

Effective 1 July 2023, this accounting error is corrected. Customers performing `_find` queries that filter through large numbers of documents might need to increase the provisioned throughput capacity for their {{site.data.keyword.cloudant_short_notm}} instances. Otherwise, immediately after this correction deploys on 1 July 2023, {{site.data.keyword.cloudant_short_notm}} returns 429 errors for read operations.
{: important}
