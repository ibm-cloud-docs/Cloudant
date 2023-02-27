---

copyright:
  years: 2023
lastupdated: "2023-02-24"

keywords: dbcopy, deprecation notice

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}


# {{site.data.keyword.cloudant_short_notm}} dbcopy feature removal
{: #dbcopy-feature-removal}

As of 1 July 2023, {{site.data.keyword.cloudantfull}}'s dbcopy feature (also known as "Chained MapReduce" or "view chaining") will cease to function. The dbcopy feature was [removed from our documentation in 2016](https://cloud.ibm.com/docs/Cloudant?topic=Cloudant-classic-release-notes#cloudant-feb16) and [new users have been unable to configure dbcopy since November 2022](https://cloud.ibm.com/docs/Cloudant?topic=Cloudant-classic-release-notes#cloudant-nov22). *Starting 1 July 2023, it will be removed from the {{site.data.keyword.cloudant_short_notm}} service entirely.*
{: shortdesc}

## What is dbcopy?
{: #what-is-dbcopy}

{{site.data.keyword.cloudant_short_notm}} allows materialized MapReduce views to be created on a database - a secondary index structure containing user-defined keys and values. MapReduce views exist and are queried in the same path as the primary database.

With the "dbcopy" feature configured, the MapReduce data is instead written to a second database. The second database then contains the key/value pairs that would normally be found in the materialized view of a "normal" MapReduce view. The dbcopy feature was used to allow view data to be "chained" (for example, the creation of views of views) or to provide a primitive *join* functionality between documents.

## What happens after the feature is removed?
{: #what-happens-after-removal}

The primary database continues to function as normal, but any MapReduce indexes with dbcopy configured no longer write data to the secondary database. The secondary database still exists, but it cannot be updated when the primary data changes.

## How do I know if my MapReduce views use dbcopy?
{: #how-do-i-know-if-mapreduce-uses-dbcopy}

MapReduce index definitions are stored in a database's [design documents](https://cloud.ibm.com/docs/Cloudant?topic=Cloudant-design-documents) and contain JavaScript that programmatically decides what data from the document makes it into the view, as shown in the following example:

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

If a view definition contains an attribute called `dbcopy`, as is the case with the above design document, then the dbcopy feature **is in use and is affected by the feature's removal**.

## Alternatives to dbcopy
{: #alternatives-to-dbcopy}

There is no direct alternative to the dbcopy feature, although simply removing the "dbcopy", attribute from a design document instructs {{site.data.keyword.cloudant_short_notm}} to build a normal MapReduce view. This view contains the same data that was being copied to the secondary database, for example:

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

The dbcopy key has been removed, so this becomes a normal MapReduce view that can be [queried using the {{site.data.keyword.cloudant_short_notm}} API](https://cloud.ibm.com/docs/Cloudant?topic=Cloudant-using-views#querying-a-view).
{: note}

If you are concerned about the removal of the dbcopy feature, you can open a support ticket and ask to consult with our Client Architecture team.
