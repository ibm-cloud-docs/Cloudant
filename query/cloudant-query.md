---

copyright:
  years: 2015, 2025
lastupdated: "2025-11-24"

keywords: create index, query, json index type, text index type, query parameters, partial index, implicit operators, explicit operators, combination operators, condition operators, selector expressions, sort, filter,  pagination, partitioned field, index field, default_field field, fields array, index_array_lengths field, list indexes, delete index, selector syntax

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# Working with {{site.data.keyword.cloudant_short_notm}} Query
{: #query}

## Overview
{: #query-overview}

{{site.data.keyword.cloudant_short_notm}} Query is a flexible query language that allows fetching documents from a database that match a "selector" -- a JSON object that defines the search criteria.
{: shortdesc}

## How {{site.data.keyword.cloudant_short_notm}} Query works
{: #query-how-it-works}

To use {{site.data.keyword.cloudant_short_notm}} Query, you send JSON-formatted queries to the `_find` HTTP endpoint of a database. The JSON contains a _selector_ which defines the query itself, alongside metadata such as the sort order to use when returning documents. The selector syntax is loosely based on MongoDB's query language, offering a rich set of query operators that can be combined to make complex queries. 

Start learning about queries by reading [Selector syntax](/docs/Cloudant?topic=Cloudant-selector-syntax).

To ensure queries return results quickly, {{site.data.keyword.cloudant_short_notm}} Queries should be backed by a suitable secondary index. There are two types of indexes available:

1. JSON indexes (`type=json`, the default) - a set of nominated document fields combined together to form the index keyspace. A query's selector and sort parameters must match an index's keys for it to be used when processing the query.
2. Text indexes (`type=text`) - a set of nominated document fields indexed separately. One or more of the indexed fields can be combined in selector expressions to extract small slices of data (up to 200 documents per query).

{{site.data.keyword.cloudant_short_notm}} queries can act on the entire database, or for partitioned databases, on a single partition.

Learn about creating indexes by reading:

- [Working with JSON indexes](/docs/Cloudant?topic=Cloudant-json-indexes).
- [Working with text indexes](/docs/Cloudant?topic=Cloudant-text-indexes).
- [Partial indexes](/docs/Cloudant?topic=Cloudant-partial-indexes).

## When to use {{site.data.keyword.cloudant_short_notm}} Query
{: #query-when-to-use}

{{site.data.keyword.cloudant_short_notm}} Query is ideal for:

- Operational queries where a query's selector/sort match a pre-defined `type=json` index.
- Ad-hoc queries on one or more fields backed by a `type=text` index, for small result sets.
- Creating partial indexes, where a subset of the documents are used to form the index and the selector/sort further filters the indexed data.

## When *not* to use {{site.data.keyword.cloudant_short_notm}} Query
{: #query-when-not-to-use}

Avoid Query for:

- Data aggregation. Use Views instead.
- Free-text or wildcard searching. Use Cloudant Search instead.

## Pagination
{: #query-pagination}

Use [bookmark pagination](/apidocs/cloudant#bookmark-pagination) for selector syntax queries.
For specific details and examples see the API documentation topic [Paging on selector syntax queries](/apidocs/cloudant#paging-on-selector-syntax-queries).
