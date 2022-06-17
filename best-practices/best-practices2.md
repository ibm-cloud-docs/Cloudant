---

copyright:
  years: 2022
lastupdated: "2022-06-17"

keywords: cloudant search, cloudant query, conflicts, delete documents, updates, replication, bulk api, eventual consistency


subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# Indexing and querying
{: #indexing-and-querying}

You might be new to {{site.data.keyword.cloudantfull}}, but you're not new to database systems. In that case, the following information discusses the suggested practices from someone who sees the product from all angles:
- The customers who use it.
- The engineers who run it.
- The folks who support and sell it.
{: shortdesc}

For more information, see [Data modeling](https://test.cloud.ibm.com/docs/Cloudant?topic=Cloudant-data-modeling) or [{{site.data.keyword.cloudant_short_notm}} in practice](/docs/Cloudant?topic=Cloudant-cloudant-in-practice).

The content in this document was originally written by Stefan Kruger as a [*Best and worst practice*](https://blog.cloudant.com/2019/11/21/Best-and-Worst-Practices.html) blog post on 21 November 2019.

## Understand the tradeoffs in emitting data or not into a view
{: #tradeoffs-emit-data-or-not-in-view}

As the document that is referenced by a view is always available by using `include_docs=true`, it is possible to do something like the following example to allow lookups on `indexed_field`:

```sh
emit(doc.indexed_field, null);
```
{: codeblock}

This example has advantages and disadvantages.

1. The index is compact. This index size is good, since index size contributes to storage costs.
2. The index is robust. Since the index does not store the document, you can access any field without thinking ahead of what to store in the index.
3. The disadvantage is that getting the document back is more costly than the alternative of emitting data into the index itself. First, the database has to look up the requested key in the index and then read the associated document. Also, if you’re reading the whole document, but need only a single field, you’re making the database read and transmit data that you don’t need.

This example also means that a potential race condition exists here. The document might change, or be deleted, between the index and document read (although unlikely in practice).

Emitting data into the index (a so-called “projection” in relational algebra terms) means that you can fine-tune the exact subset of the document that you need. In other words, you don’t need to emit the whole document. Emit a value that represents only the data you need in the app that is a cut-down object with minimal details, for example:

```sh
emit(doc.indexed_field, {name: doc.name, dob: doc.dob});
```
{: codeblock}

If you change your mind on what fields you want to emit, the index needs rebuilding.

{{site.data.keyword.cloudant_short_notm}} Query’s JSON indexes use views this way under the hood. {{site.data.keyword.cloudant_short_notm}} Query can be a convenient replacement for some types of view queries, but not all. Do take the time to understand when to use one or the other.

- {{site.data.keyword.cloudant_short_notm}} Query [docs](/docs/Cloudant?topic=Cloudant-query)
- {{site.data.keyword.cloudant_short_notm}} guide to using [views](/docs/Cloudant?topic=Cloudant-using-views#using-views)
- Performance implications of using [include_docs](/docs/Cloudant?topic=Cloudant-using-views#multi-document-fetching)

## Never rely on the default behavior of {{site.data.keyword.cloudant_short_notm}} Query’s no-indexing
{: #never-rely-on-cloudant-queries-no-indexing}

It’s tempting to rely on {{site.data.keyword.cloudant_short_notm}} Query's ability to query without creating explicit indexes. This practice is costly in terms of performance, as every lookup is a full scan of the database rather than an indexed lookup. If your data is small, this full-scan lookup doesn’t matter, but as the data set grows, performance becomes a problem for you, and for the cluster as a whole. It is likely that we will limit this facility soon. The {{site.data.keyword.cloudant_short_notm}} dashboard provides a method for creating indexes in an easy way.

Creating indexes and crafting {{site.data.keyword.cloudant_short_notm}} Queries that take advantage of them requires some flair. To identify which index is being used by a particular query, send a POST to the `_explain` endpoint for the database, with the query as data.

For more information, see [{{site.data.keyword.cloudant_short_notm}} Query docs](/docs/Cloudant?topic=Cloudant-query).

## In {{site.data.keyword.cloudant_short_notm}} Search (or {{site.data.keyword.cloudant_short_notm}} Query indexes of type text), limit the number of fields
{: #limit-number-fields-cq}

{{site.data.keyword.cloudant_short_notm}} Search and {{site.data.keyword.cloudant_short_notm}} Query indexes of type `text` (both of which are Apache Lucene under the hood) provide you with a way to index any number of fields into the index. Some examples exist where this type of indexing is abused either deliberately, or mostly by mistake. Plan your indexing to comprise only the fields required by your actual queries. Indexes take up space and can be costly to rebuild if the number of indexed fields are large.


We also have the issue of which fields that you store in an {{site.data.keyword.cloudant_short_notm}} Search. Stored fields are retrieved in the query without doing `include_docs=true` so the tradeoff is similar to the [Understand the tradeoffs in emitting data or not into a view](/docs/Cloudant?topic=Cloudant-indexing-and-querying#tradeoffs-emit-data-or-not-in-view) section.
For more information, see {{site.data.keyword.cloudant_short_notm}} Search [docs](/docs/Cloudant?topic=Cloudant-cloudant-search).

## Design document management requires some flair
{: #manage-design-document}

As your data set grows, and your number of views goes up, sooner or later you want to ponder how you organize your views across design documents. A single design document can be used to form a so-called `view group`: a set of views that belong together by some metric that makes sense for your use case. If your views are static, that makes your view query URLs semantically similar for related queries. It’s also more performant at index time because the index loads the document once and generates multiple indexes from it.

Design documents themselves are read and written by using the same read/write endpoints as any other document. With these endpoints, you can create, inspect, modify, and delete design documents from within your application. However, even small changes to design documents can have significant effects on your database. When you update a design document, *all* views in it become unavailable until indexing is complete. This lag can be problematic in production. To avoid it, you have to do a crazy design document-swapping dance (see [`couchmigrate`](https://github.com/glynnbird/couchmigrate){: external}).

In most cases, this process is probably not what you want to have to deal with. As you start out, it is most likely more convenient to have a one-view-per-design document policy.

Also, in case it isn’t obvious, views are code. Views must be subject to the same processes you use in terms of source code version management for the rest of your application code. How to achieve this standard might not be immediately obvious. You could increase the version number for the JavaScript snippets. Then, you could cut and paste the code into the {{site.data.keyword.cloudant_short_notm}} dashboard to deploy whenever a change occurs. Yes, we all resort to this practice from time to time.

Better ways to do this exist, and we have one reason to use some of the tools that surround the [`couchapp`](https://docs.couchdb.org/en/stable/ddocs/){: external} concept. A `couchapp` is a self-contained CouchDB web application that nowadays doesn’t see much use. Several `couchapp` tools exist that are there to make the deployment of a `couchapp`, including its views, crucially, easier.

Using a `couchapp` tool means that you can automate deployment of views as needed, even when not using the `couchapp` concept itself.

- See, for example, [`couchapp`](https://github.com/couchapp/couchapp){: external} and [`situp`](https://github.com/drsm79/situp){: external}.
- {{site.data.keyword.cloudant_short_notm}} guide to [design document management](/docs/Cloudant?topic=Cloudant-design-document-management#design-document-management).

## Partitioned queries are faster and cheaper
{: #partitioned-queries-fast-and-cheap}

Yes, partitioned queries are faster and cheaper. Opting to create a *partitioned database* (as opposed to an unpartitioned database) means that {{site.data.keyword.cloudant_short_notm}} uses a *partition key* to decide on which shard each of your documents resides. Documents with the same *partition key* are on the same database shard. Requests for `_all_docs`, MapReduce views, {{site.data.keyword.cloudant_short_notm}} Query `_find` queries, and {{site.data.keyword.cloudant_short_notm}} Search operations can be directed to a single partition instead of having to interrogate all shards in a “scatter and gather” pattern, which is the case for *global queries*.

These *partitioned queries* exercise only one shard of the database. This practice makes them faster to execute than global queries. For billing purposes, they are classified as “read” requests instead of the more expensive “query” requests, which provides you with more usable capacity from the same {{site.data.keyword.cloudant_short_notm}} plan.

Not all data designs lend themselves to a partitioned design, but if your data can be molded into a `<partition key>:<document key>` pattern, then your application can benefit in terms of performance and cost.

- [Partitioned Databases documentation](/docs/Cloudant?topic=Cloudant-database-partitioning)
- [Partitioned Databases - Introduction blog](https://blog.cloudant.com/2019/03/05/Partition-Databases-Introduction.html){: external}

## Treat the primary index as a free search index
{: #treat-primary-index-as-free-search-index}

A default {{site.data.keyword.cloudant_short_notm}} document `_id` is a 32-character string, encoding 128 bits of random data. The `_id` attribute is used to construct the database’s primary index, which is used by {{site.data.keyword.cloudant_short_notm}} to retrieve documents by `_id` or ranges of keys when the user supplies a `startkey/endkey` pair. We can leverage this fact to pack our data into the `_id` field and use it as a “free” index that can query for ranges of values.

See some examples here:

- Use time-sortable document IDs so that your documents are sorted into rough date and time order. This sorting makes it easy to retrieve recent additions to the database. For more information, see [Time-sortable -IDs](https://blog.cloudant.com/2018/08/24/Time-sortable-document-ids.html){: external}.
- Pack searchable data into your `_id` field, for example,  `<customerid>~<date>~<orderid>` can be used to retrieve data by `customer`, `customer/date`, or `customer/date/orderid`.
- In a partitioned database, the judicious choice of *partition key* allows an entire database to be winnowed down to a handful of documents for a known partition key. Make sure that your partitioning schema solves your most common use case.
- In a partitioned database, the two parts of the key have to contain your user-supplied data (no auto-generated `_ids` exist) so it’s best to use it optimally. For example, in an IoT application, `<sensorid>:<time-sortable-id>` allows data to be sorted by sensor and time without a secondary index. Implement this schema with *time-boxed databases* for best results.








