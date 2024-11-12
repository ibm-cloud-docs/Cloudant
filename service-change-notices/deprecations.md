---

copyright:
  years: 2024
lastupdated: "2024-03-20"

keywords: security, compliance, standardize resource configuration

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# Service Changes and Deprecations for {{site.data.keyword.cloudant_short_notm}}
{: #deprecations-for-ibm-cloudant}

You can see the deprecations for {{site.data.keyword.cloudantfull}} here.

## {{site.data.keyword.cloudant_short_notm}} Upgrading JavaScript engine
{: #cloudant-nosql-db-jsengine-dep}

### Details
{: #cloudant-nosql-db-jsengine-dep-details}

The JavaScript engine used in design documents is being upgraded to support
newer language features and optimize index build speeds. However, as a result,
some JavaScript language features are deprecated, and others will change their
behavior:

 * `RegExp.$1...$9` regular expressions feature is deprecated. The `$1`...`$9`
   properties will return `undefined`. For example:

Previous result:
```js
> v="abc"
"abc"

> v.match(/(b)/)
["b", "b"]

> RegExp.$1
"b"
```

New reuslt:
```js
> v="abc"
"abc"

> RegExp.$1
undefined
```

 * `Date.prototype.toString()` result doesn't include the timezone name, just the offset. For example:

Previous result:
```js
>  (new Date()).toString();
"Thu Sep 05 2024 17:04:03 GMT-0400 (EDT)"
```

New result:
```js
> (new Date()).toString();
"Thu Sep 05 2024 17:03:23 GMT-0400"
```

 * `for each (var x in ...)` experssions are deprecated

 * E4X (ECMAScript for XML) is deprecated

Previous result:
 ```js
> var xml = <root><x></x></root>

> xml.(x)
<root>
  <x/>
</root>
```

New result:
```js
> var xml = <root><x></x></root>
typein:1:11 SyntaxError: expected expression, got '<':
```

 * `Date.prototype.toLocaleFormat()` function is depcrecated.

Previous result:
```js
> d = new Date("Dec 1, 2015 3:22:46 PM")
(new Date(1449001366000))

> d.toLocaleFormat("%Y-%m-%d")
"2015-12-01"
```

New result:
```js
> d = new Date("Dec 1, 2015 3:22:46 PM")
(new Date(1449001366000))

> d.toLocaleFormat("%Y-%m-%d")
typein:2:3 TypeError: d.toLocaleFormat is not a function
```

 * `Date.prototype.toLocaleString()` used to ignore locale strings, the new version will return the correct format:

Previous result:
```js
> (new Date("2019-01-15T19:32:52.915Z")).toLocaleString('en-US')
"Tue Jan 15 14:32:52 2019"
```

New result:
```js
> (new Date("2019-01-15T19:32:52.915Z")).toLocaleString('en-US')
"01/15/2019, 02:32:52 PM"
```

 * Invalid expressions following `function(){...}` expressions used to be
   ignored, but in the future will throw a syntax error. For example, a design
   view function like the following will start returning `compilation_error`
   with a `400 HTTP` result.

 * Object key order changed:

Previous result:
```js
> r={}; ["Xyz", "abc", 1].forEach(function(v) {r[v]=v;}); Object.keys(r)
["Xyz", "abc", "1"]
```

New result:
```js
> r={}; ["Xyz", "abc", 1].forEach(function(v) {r[v]=v;}); Object.keys(r)
["1", "Xyz", "abc"]
```

 * `String.prototype.match(undefined)` used to return `null`, and now will return `[""]`:

Previous result:
```js
> "abc".match(undefined)
null
```

New result
```js
> "abc".match(undefined)
[""]
```

For more details see the [Cloudant blog](https://blog.cloudant.com/2024/10/29/QuickJS-for-Faster-Index-Builds.html){: external}).

## {{site.data.keyword.cloudant_short_notm}} Deprecation of `_show`, `_list`, `_update`, `_rewrite` functions
{: #cloudant-nosql-db-show-list-update-rewrite-function-dep}

### Details
{: #cloudant-nosql-db-db-show-list-update-rewrite-function-dep-details}

Notice that the following Cloudant features are deprecated:

* show functions - used to modify the format of the response when requesting a single document from the database.
* list functions - similar to show functions, but applied to the output of MapReduce views.
* rewrite functions - used to embody routing logic in CouchApps.
* update functions - used to carry out business logic within the database e.g. adding a timestamp to all document writes.

These four features are already deprecated in Apache CouchDB and scheduled to be removed from the code in Apache CouchDB 4.0. None of these features are modelled in our Cloudant SDKs.

Although these features are deprecated, they will not be removed from the service yet. { :important}

We may completely remove the features in the future, but will leave them operable for the time being to give customers time to modify their applications. As deprecated features, they will not appear in our documentation, their use is not recommended and they will not be supported by our Support team.

Alternatives to these functions can be found on the Cloudant blog [here](https://blog.cloudant.com/2022/08/16/Show-list-rewrite-udpate-functions-deprecated.html){: external}.

## {{site.data.keyword.cloudant_short_notm}} Remove replicator endpoint proxy support
{: #cloudant-nosql-db-replicator-proxy-dep}

### Details
{: #cloudant-nosql-db-replicator-proxy-dep-details}

Replicator endpoint proxy support is removed. Replication jobs with `proxy`, `source_proxy` or `target_proxy` fields set will fail with an error.

## {{site.data.keyword.cloudant_short_notm}} Deprecation of Cloudant instances that are created as Cloud Foundry service instances
{: #cloudant-nosql-db-cdt-cf-instance-dep}

### Details
{: #cloudant-nosql-db-cdt-cf-instance-dep-details}

Due to the end of the Cloud Foundry service, {{site.data.keyword.cloudant_short_notm}} instances that are created as Cloud Foundry service instances are being deprecated and must be migrated to an {{site.data.keyword.cloud_notm}} [resource group](/docs/account?topic=account-rgs&interface=ui){: external}.

Migration to a resource group provides the added capability to use [{{site.data.keyword.cloud_notm}} IAM](/docs/account?topic=account-iamoverview){: external} to control access. When migrating the Cloudant instance, you can choose which of your {{site.data.keyword.cloud_notm}} resource groups to migrate it to. For example, you might have one resource group for production and a different one for Dev/Test.

Standard Plan instances that are not migrated before 1 September 2023 will be migrated by IBM.
{: important}

Should IBM be required to migrate a Cloudant instance to a resource group, it will be migrated to the default resource group for the {{site.data.keyword.cloud_notm}} account. The assignment of the Cloudant instance to the default resource group cannot be changed later.

**Deadline for Lite plan instances has been extended from 1 August 2023 to 18 September 2023: Lite plan instances that are not migrated before 18 September 2023 will be disabled for 30 days and deleted on 18 October 2023.**

### How do I know if my instances use Cloud Foundry?
{: #cloudant-nosql-db-cdt-cf-instance-dep-identifying-instances}

- Display the list of Cloudant instances in the {{site.data.keyword.cloud_notm}} GUI
- The presence of the migrate icon after the instance name identifies instances that need to be migrated

### How do I migrate the instance to an {{site.data.keyword.cloud_notm}} resource group?
{: #cloudant-nosql-db-cdt-cf-instance-dep-how-to-migrate}

- To complete the migration, follow these [{{site.data.keyword.cloudant_short_notm}} instructions](/docs/account?topic=account-migrate#migrate_instances){: external}.

1. Open the **More actions** menu.
1. Select **Migrate to a resource group** to get started.
1. Select a resource group.
1. Click **Migrate** and the instance is migrated for you.
1. Since you can migrate only one instance at a time, you can continue migrating eligible instances after you migrate the first one.

**The data in the Cloudant instance is not involved in this migration.**
**There is no Cloudant service downtime as a result of this migration.**

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

## {{site.data.keyword.cloudant_short_notm}} dbcopy feature removal
{: #dbcopy-feature-removal-dep}

As of 1 October 2023, {{site.data.keyword.cloudant_short_notm}}'s dbcopy feature (also known as "Chained MapReduce" or "view chaining") will cease to function. The dbcopy feature was [removed from our documentation in 2016](https://cloud.ibm.com/docs/Cloudant?topic=Cloudant-classic-release-notes#cloudant-feb16) and [since November 2022, new users cannot configure dbcopy](https://cloud.ibm.com/docs/Cloudant?topic=Cloudant-classic-release-notes#cloudant-nov22). *Starting 1 October 2023, the dbcopy feature will be removed from the {{site.data.keyword.cloudant_short_notm}} service entirely.*
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

## {{site.data.keyword.cloudant_short_notm}} Replications no longer support HTTP
{: #replications-no-longer-support-http}

As of 1 October 2023, the replicator for {{site.data.keyword.cloudant_short_notm}} no longer supports the HTTP protocol – it supports only the HTTPS protocol to ensure that customer data is always encrypted in flight.

These changes only affect replications leaving {{site.data.keyword.cloudant_short_notm}}. Customers who only replicate between Cloudant instances have no action to take.
{: important}

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

If a self-hosted CouchDB service does _not* support HTTPS, CouchDB can mediate replication jobs instead of {{site.data.keyword.cloudant_short_notm}}. For example, stop the replication job that runs on the {{site.data.keyword.cloudant_short_notm}} side and set up a replication job on a self-hosted Apache CouchDB service to "pull" the data from {{site.data.keyword.cloudant_short_notm}}.

{{site.data.keyword.cloudant_short_notm}} supports only `https://` traffic, so if {{site.data.keyword.cloudant_short_notm}} is to be the `source` or `target` in a self-hosted replication definition, it must be configured with an `https://` prefix.
