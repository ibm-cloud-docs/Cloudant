---

copyright:
  years: 2022
lastupdated: "2022-11-23"

keywords: cloudant query, how to use, create an index, sort search results, sort reverse order, efficient query, partitioned databases

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# Using {{site.data.keyword.cloudant_short_notm}} Query FAQ
{: #faq-using-cloudant-query}

[{{site.data.keyword.cloudantfull}} Query](https://cloud.ibm.com/docs/Cloudant?topic=Cloudant-query) is an API for querying slices of data based on the values of a database's document attributes. It is a flexible API that must be used carefully to ensure that database performance can be maintained as the data size grows over time.

## How do I use {{site.data.keyword.cloudant_short_notm}} Query?
{: #how-do-i-use-cloudant-query}

{{site.data.keyword.cloudant_short_notm}} Query is accessed through the [`POST /{db}/_find`](https://cloud.ibm.com/apidocs/cloudant#postfind) API endpoint where the JSON specification of the query is passed in the HTTP POST body. For example, this query finds up to 10 documents where the `firstname` is "Charles" and the `surname` is "Dickens":

```js
{
  "selector": {
    "firstname": "Charles",
    "surname": "Dickens"
  },
  "limit": 10
}
```

For more information, see [Selector Syntax](https://cloud.ibm.com/docs/Cloudant?topic=Cloudant-query#selector-syntax).

## How do I create an index to support an {{site.data.keyword.cloudant_short_notm}} Query?
{: #how-do-i-create-an-index-to-support}

Without a suitable secondary index, {{site.data.keyword.cloudant_short_notm}} Query scans each document in the database in turn until it has enough matches to satisfy the query. The larger the data set and the more documents it has to scan to find matching documents, the slower the response time. For faster performance, an {{site.data.keyword.cloudant_short_notm}} Query `_find` must be backed by a suitable secondary index. A secondary index is a pre-calculated data structure that allows {{site.data.keyword.cloudant_short_notm}} to quickly jump to the slice of data it needs without scanning irrelevant documents. For the `surname` fields, we call the [`POST /{db}/_index`](https://cloud.ibm.com/apidocs/cloudant#postindex) endpoint to pass the JSON index definition as the HTTP POST body:

```js
{
  "index": {
    "fields": ["firstname", "surname"]
  },
  "ddoc": "jsonindexes",
  "name": "byName",
  "type": "json"
}
```

For more information, see [Creating an Index](https://cloud.ibm.com/docs/Cloudant?topic=Cloudant-query#creating-an-index).

## Can I sort my search results with {{site.data.keyword.cloudant_short_notm}} Query?
{: #can-i-sort-my-search-results-with-cq}

Yes! The `_find` JSON syntax allows for a `sort` parameter to be provided listing the attribute or attributes to sort by. In this case, we are sorting by `date`:

```js
{
  "selector": {
    "firstname": "Charles",
    "surname": "Dickens"
  },
  "sort": ["date"],
  "limit": 10
}
```

A suitable index must be present that contains the `selector` fields and the `sort` fields. Otherwise, {{site.data.keyword.cloudant_short_notm}} refuses to execute the query. A suitable index definition for the previous query is shown next.
{: note}

```js
{
   "index": {
      "fields": [
         "firstname",
         "surname",
         "date"
      ]
   },
   "ddoc": "jsonindexes",
   "name": "byNameAndDate",
   "type": "json"
}
```

## Can I sort in reverse order?
{: #can-i-sort-in-reverse-order}

Yes! {{site.data.keyword.cloudant_short_notm}} Query supports sorting the result set in ascending or descending order, but not a combination of the two. For example, a query that sorts some fields in ascending order, and a query where descending is not allowed.

This query returns documents that match `firstname` and `surname` and sorts by `surname`/`firstname`/`date` descending:

```js
{
  "selector": {
    "firstname": "Charles",
    "surname": "Dickens"
  },
  "sort": [
    { "firstname": "desc" },
    { "surname": "desc" },
    { "date": "desc" }
  ],
  "limit": 10
}
```


A suitable index must be present that contains the `selector` fields and the `sort` fields. Otherwise, {{site.data.keyword.cloudant_short_notm}} refuses to execute the query. A suitable index definition for the previous query is shown next.
{: note}

```js
{
   "index": {
      "fields": [
         "firstname",
         "surname",
         "date"
      ]
   },
   "ddoc": "jsonindexes",
   "name": "byNameAndDate",
   "type": "json"
}
```

The previous index is suitable for both ascending and descending sort order.

## How can I tell if an index is backing a query?
{: #how-can-i-tell-if-an-index-is-backing-a-query}

The [`POST /{db}/_explain`](https://cloud.ibm.com/apidocs/cloudant?code=java#postexplain) API endpoint when passed a JSON object that is usually sent to the [`POST /{db}/_find`](https://cloud.ibm.com/apidocs/cloudant#postfind) endpoint, explains how such a query is handled and which indexes, if any, might be used.

If the `index` object in the response indicates that "all_docs" is being used, a full database scan is required to service the query. We recommend that you use the `_explain` mechanism to check each {{site.data.keyword.cloudant_short_notm}} query to ensure it is using an index before deploying to production.

For example, a `type=json` index on `firstname`, `surname` and `date` is suitable for finding documents for:

- A known `firstname`, `lastname`, and `date`.
- A known `firstname`, `lastname`, and a range of `date` values (that use `$lt`, `$lte`, `$gt`, `$gte` operators).
- A known `firstname` and `lastname` sorted by `date`.

It can also be used to assist queries on `firstname`, `surname`, `date`, and other attributes. In other words, it might only be able to answer part of the query but it can help reduce the number of documents that are scanned to find the answer.

## How can I ensure that my query is efficent?
{: #how-can-i-ensure-that-my-query-is-efficient}

Ideally, an {{site.data.keyword.cloudant_short_notm}} Query execution would need to scan only one document for each document returned. If a query has to scan a million documents for each one returned, it is clearly not optimal, and is in need of a secondary index to help.

When executing a query, passing `execution_stats: true` as an extra parameter forces {{site.data.keyword.cloudant_short_notm}} to enumerate the number of documents it scanned in performing the query, for example:

```js
{
  "selector": {
    "firstname": "Charles",
    "surname": "Dickens"
  },
  "sort": ["date"],
  "limit": 10,
  "execution_stats": true
}
```

The returned data now includes an extra JSON object:

```js
{
  ...
  "execution_stats": {
    "total_keys_examined": 0,
    "total_docs_examined": 1000000,
    "total_quorum_docs_examined": 0,
    "results_returned": 2,
    "execution_time_ms": 4400.699
  }
}
```

The ratio between `total_docs_examined` and `results_returned` is key here: a high value indicates that too many documents are being scanned per document that is returned. 

For more information, see [Blog post on Optimizing {{site.data.keyword.cloudant_short_notm}} Queries](https://blog.cloudant.com/2020/04/24/Optimising-Cloudant-Queries.html).

## Which {{site.data.keyword.cloudant_short_notm}} Query operators defeat the use of an index?
{: #which-cq-operators-defeat-index}

Any of the [combination operators](https://cloud.ibm.com/docs/Cloudant?topic=Cloudant-query#operators) other than `$and` can make a query do a full database scan without the help of a secondary index. For example, if an `$or` operator is used, then no secondary index can be used to assist the query. If in doubt, use the [`POST /{db}/_explain`](https://cloud.ibm.com/apidocs/cloudant?code=java#postexplain) endpoint to check that an index is used, and the `execution_stats: true` parameter to measure the efficiency of each query.

For a `type=json` index to be used to support a query, it must match the fields that are used in the selector and sort parameters. Comparison operators might be used on the last element to perform _range queries_.

For more information, see [Explain plans](https://cloud.ibm.com/docs/Cloudant?topic=Cloudant-query#explain-plans).

## Can I use {{site.data.keyword.cloudant_short_notm}} Query with a Lucene index?
{: #can-i-use-cq-with-a-lucene-index}

Yes! {{site.data.keyword.cloudant_short_notm}} Query supports two types of indexes:

- `"type": "json"` - a fixed-order index powered by {{site.data.keyword.cloudant_short_notm}}'s MapReduce API. Good for fixed, boilerplate queries that match every term in the index.
- `"type": "text"` - a Lucene index powered by {{site.data.keyword.cloudant_short_notm}}'s Search API. Good for general-purpose queries across one, some, or all indexed fields.

A `type=text` index is created with an index definition like this:

```js
{
   "index": {
      "fields": [
         { "name": "firstname", "type": "string"},
         { "name": "surname", "type": "string"},
         { "name": "date", "type": "string"}
      ]
   },
   "ddoc": "textindexes",
   "name": "byNameAndDate",
   "type": "text"
}
```

Notice that the `fields` array requires each attribute to be named and typed (unlike `type=json` indexes).

The resultant index can be used by queries that contain one or more of the indexed fields:

```js
{
  "selector": {
    "surname": "Dickens"
  },
  "sort": ["date"],
  "limit": 10,
  "execution_stats": true
}
```

The Lucene-backed indexes allow some extra flexibility over `type=json` indexes. You can use one, some, or all of your indexed fields in any order, and the index supports the query. With `type=json` indexes, the query must match all of the indexed fields to be useful.

For more information, see [Creating a `type=text` index](https://cloud.ibm.com/docs/Cloudant?topic=Cloudant-query#creating-a-type-text-index).

## Can I create an {{site.data.keyword.cloudant_short_notm}} Query index for a subset of a database?
{: #can-i-create-cq-index-subset-of-db}

Yes! If your use case requires that queries are performed within the confines of a subset of the database (for example,  _completed_ orders, or _confirmed_ users, or _in-stock_ products), then a _partial index_ is best. A partial index allows an {{site.data.keyword.cloudant_short_notm}} Query selector to be used at index-build time to winnow the data set that makes it into the index, keeping the index small and performant. Then, at query-time, a standard {{site.data.keyword.cloudant_short_notm}} Query selector is used to further filter the partial index to get your result set.

A _partial_ index is created by passing a `partial_filter_selector` to the `POST /{db}/_index` method. In this example, only hardback books that have a status of "published" or "reprint" make it to the index. See the following example:

```js
{
  "index": {
    "partial_filter_selector": {
      "$or": [
        { "status": "published" },
        { "status": "reprint" }
      ],
      "hardback": true
    },
    "fields": ["firstname","surname","date"]
  },
  "ddoc" : "partialindexes",
  "name": "byNameAndDate"
  "type" : "json"
}
```

At query time, the `use_index` field must be supplied to tell {{site.data.keyword.cloudant_short_notm}} that you want it to use the specified index:

```js
{
  "selector": {
      "$or": [
        { "status": "published" },
        { "status": "reprint" }
      ],
      "hardback": true,
      "firstname": "Charles",
      "surname": "Dickens"
  },
  "sort": ["date"],
  "limit": 10,
  "execution_stats": true,
  "use_index": "partialindexes/byNameAndDate"
}
```

The `partial_filter_selector` fields are repeated in the query-time selector.
{: note}

For more information, see [Creating a partial index](https://cloud.ibm.com/docs/Cloudant?topic=Cloudant-query#creating-a-partial-index).

## Can I use {{site.data.keyword.cloudant_short_notm}} Query on partitioned databases?
{: #can-i-use-cq-partitioned-dbs}

Yes! By default, an {{site.data.keyword.cloudant_short_notm}} Query index is _global_ (for example, not partitioned) but on a _partitioned database_, a _partitioned index_ can be created by adding `partitioned: true` when the index is created:
e
To create a partitioned index on `firstname` and `surname`, the `POST /<dbname>/_index` is used:

```js
{
  "index": {
    "fields": ["firstname", "surname"]
  },
  "ddoc": "jsonindexes",
  "name": "byName",
  "type": "json",
  "partitioned": true
}
```

Partitioned indexes can be used when you run only a partitioned query, for example, by using the [`GET /<dbname>/_partition/<partition key>/_find`](https://cloud.ibm.com/apidocs/cloudant?code=java#postpartitionfind-partitioned-databases) API endpoint.

For more information, see [Creating a partitioned index](https://cloud.ibm.com/docs/Cloudant?topic=Cloudant-query#selector-syntax).

## Can I use regular expressions in my queries?
{: #can-i-use-regular-expressions-queries}

Yes! {{site.data.keyword.cloudant_short_notm}} Query has a [$regex operator](https://cloud.ibm.com/docs/Cloudant?topic=Cloudant-query#the-regex-operator) that allows regular expression terms within a query. 

Proceed with caution: if a query contains _only_ a `$regex` operator, then a secondary index cannot help you - the query results in a document-by-document scan of the database.
{: attention}

A `$regex` operator can be tagged onto the end of an already performant query. For example, if we already have a `type=json` index on `firstname` and `surname`, we can use the following example:


```js
{
  "selector": {
    "firstname": "Charles",
    "surname": "Dickens",
    "title": {
      "$regex": "^Oliv"
    }
  },
  "limit": 10
}
```

{{site.data.keyword.cloudant_short_notm}} uses the index to find documents by `firstname` and `surname` and winnows the result set that uses the regular expression on the `title` field.
