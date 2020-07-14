---

copyright:
  years: 2020
lastupdated: "2020-07-13"

keywords: query, secondary index, primary index, organizing documents, organizing databases

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

<!-- Acrolinx: 2020-03-13 -->

# Best practices
{: #best-practices}

Follow our recommendations to improve your experience with {{site.data.keyword.cloudantfull}} Transaction Engine.

## Using the right tool for the job
{: #using-the-right-tool-for-the-job}

{{site.data.keyword.cloudant_short_notm}} Transaction Engine is a scalable, durable, highly available, operational JSON document store with an HTTP API. It's suitable for the following purposes:

- Powering your always-on web application.
- Being the server-side data store for mobile applications.
- Storing time-series data in time-boxed databases before you archive to object storage and delete the original.
- Storing application objects as JSON while delivering queries from secondary indexes.
- Replicating data sets across geographies for disaster recovery, extra capacity, or moving data nearer to your users.

{{site.data.keyword.cloudant_short_notm}} Transaction Engine doesn't include the following features: 

- Low latency, in-memory data store. For more information, see [{{site.data.keyword.cloud}} Databases for Redis](https://www.ibm.com/uk-en/cloud/databases-for-redis).
- Limitless object store for data archiving. For more information, see [{{site.data.keyword.cloud_notm}} Object Storage](https://www.ibm.com/uk-en/cloud/object-storage).
- Relational database with SQL querying, stored procedures, and constraints and triggers. For more information, see [{{site.data.keyword.cloud_notm}} Databases for PostgreSQL](https://www.ibm.com/cloud/databases-for-postgresql).
- Data warehouse for ad hoc querying. For more information, see [{{site.data.keyword.dashdblong}}](https://www.ibm.com/products/db2-warehouse).
- A queue. For more information, see [{{site.data.keyword.IBM_notm}} MQ](https://www.ibm.com/uk-en/products/mq).

For more information, see the [Best and worst practice](https://blog.cloudant.com/2019/11/21/Best-and-Worst-Practices.html) blog.

## Organizing documents and databases
{: #organizing-documents-and-databases}

{{site.data.keyword.cloudant_short_notm}} Transaction Engine data is organized in a hierarchy of databases and documents. A document is a JSON object with a unique identifier: its `_id`. A database is a collection of documents, with a primary index that allows documents to be retrieved by `_id` and optional secondary indexes that allow documents to be queried by other attributes in the object.

When developers start a project, they sometimes struggle with the following questions:

- How much data can I put into a single object?
- Must I store different document types in the same collection or one database per document type?

We recommend that a document include all the data about an object that is modeled by your application, for example, a user, an order, or a product. This practice ensures you fetch the entire object from the database in one API call. {{site.data.keyword.cloudant_short_notm}} Transaction Engine doesn't have the concept of *joins* like a relational database, so data isn't *normalized*. However, data can repeat across objects. For example, an *order* document can include a subset of the *product* documents that were purchased.

It's common to store several object types in the same database: a convention is that a `type` attribute is used to denote the object type. This option is a good one if you need to perform queries that return several object types or if a database needs to be replicated to another location altogether. Otherwise, separate databases, for example, `users`, `orders`, `products`, might be better so that secondary indexes are specific to each object type.

If you're storing arrays of objects within a document, consider whether the array items must really be their own document. For example, a *product* and each *product review* must be stored in separate documents, but a *user* and each of that user's *orders* must have their own document.

If you have an ever-growing data set, then you probably don't want to store data in a single, ever-growing database. Data is best stored in *time-boxed databases* that allow older data to be archived and deleted cleanly. Deleting an {{site.data.keyword.cloudant_short_notm}} document leaves a *tombstone* document behind, so don't rely on deleting documents to recover disk space. Instead, you must rely on deleting whole databases.

JSON doesn't offer a native way to store dates or timestamps. Choose your [date format](https://blog.cloudant.com/2018/05/24/Date-formats.html) carefully if you intend to query it later.

The maximum document size is 1 MB, but documents must be much smaller than that size, typically a few KB.

For more information, see the following blog posts:

- [Optimal {{site.data.keyword.cloudant_short_notm}} Indexing](https://blog.cloudant.com/2019/05/10/Optimal-Cloudant-Indexing.html)
- [Time-series Data Storage](https://blog.cloudant.com/2019/04/08/Time-series-data-storage.html)
- [Partitioned databases - data design](https://blog.cloudant.com/2019/03/05/Partition-Databases-Data-Design.html)
- [Date formats](https://blog.cloudant.com/2018/05/24/Date-formats.html)

## Making the most of the primary index
{: #making-the-most-of-primary-index}

{{site.data.keyword.cloudant_short_notm}} Transaction Engine has a primary index on the document's `_id` attribute. This index allows documents to be retrieved by `_id` (`GET /db/id`) or a range of `_ids` (`GET /db/_all_docs?startkey="a"&endkey="z"`). By storing data in the primary key and ensuring that each `_id` is unique, the primary index can be used to fetch documents and ranges of documents without secondary indexing. See the following list of ideas:

- If you have something unique in your object that would be useful to query against, use it as your `_id` field, for example, `bob.smith@gmail.com`, `isbn9780241265543`, or `oakland,ca`.
- If there is a hierarchy in your objects, model that in your `_id`: `usa:ca:oakland` or `books:fiction:9780241265543`. The hierarchy goes from largest to smallest, so you can use the primary index to find "all the cities in `usa`" or "all the cities in `usa:ca`", without secondary indexing.
- If you're storing time-series data, encoding time at the start of your `_id` sorts the primary index by time, for example, `001j40Ox1b2c1B2ubbtm4CsuLB4L35wQ`.
- Partitioned databases keep documents that share the same partition key together. A partition key must have many values and must not include hot spots to avoid directing a large proportion of your application's traffic to a few partitions.

For more information, see the following blog posts:

- [Time-sortable _ids](https://blog.cloudant.com/2018/08/24/Time-sortable-document-ids.html)
- [Introduction to partitioned databases](https://blog.cloudant.com/2019/03/05/Partition-Databases-Introduction.html)

## Querying and secondary indexes
{: #querying-secondary-indexes}

{{site.data.keyword.cloudant_short_notm}} Transaction Engine allows queries to run against a single database that returns an array of matching documents and a bookmark, which allows access to the next block of search results. Achieving better query performance depends on having your queries backed by suitable secondary indexes. An index allows the database to answer a query without having to trawl through every document in the database, yielding much faster performance.

See the following tips:

- It's sometimes difficult to measure the performance of your queries until your data set is large enough to expose slow operations. Generate enough realistic data so that you can test your indexing and query performance before you get to production.
- {{site.data.keyword.cloudant_short_notm}} might return data to you without an index, but you must never rely on this data for production workloads. If your result set includes the warning, "No matching index found. Create an index to optimize query time," then you need to revisit your indexing strategy. Use the [explain](/docs/Cloudant?topic=Cloudant-query#explain-plans) feature to see which index is being selected for each query.
- With several object types in the same database, many use cases can be serviced by a few indexes on fixed attributes. For more information, see [Optimal {{site.data.keyword.cloudant_short_notm}} Indexing](https://blog.cloudant.com/2019/05/10/Optimal-Cloudant-Indexing.html).
- Give your indexes meaningful names, and specify the index name at query-time, so that it's obvious which index corresponds to which of your application's queries.

For more information, see the following blog posts:

- [Generating sample data](https://blog.cloudant.com/2018/09/14/Generating-sample-JSON-data.html)
- [Optimal {{site.data.keyword.cloudant_short_notm}} Indexing](https://blog.cloudant.com/2019/05/10/Optimal-Cloudant-Indexing.html)