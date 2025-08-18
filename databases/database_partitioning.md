---

copyright:
  years: 2017, 2025
lastupdated: "2025-08-18"

keywords: database shards, non-partitioned databases, partition key, global query, partition query, create partition database, create partition query index, partition search, tutorials, cardinality, partitioned

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# Database partitioning
{: #database-partitioning}

As stated on the [How data is stored
page](/docs/Cloudant?topic=Cloudant-how-is-data-stored-in-ibm-cloudant-),
partitioned databases allow your application to co-locate documents on the same
shard using the document partition key. This page helps you work out if your
data model is suited for use with partitioned databases.
{: shortdesc}

{{site.data.keyword.cloudantfull}} supports two types of databases:

- **Non-partitioned**: the default type. Documents are assigned to shards automatically by the database to balance workload.
- **Partitioned**: document IDs contain an application-specified partition key which affects how data is allocated to shards.

{{site.data.keyword.cloudant_short_notm}} recommends that you use a partitioned
database only where the data model allows for logical partitioning of documents
into many (500+) partitions. See [Determining partitioned database suitability](#determining-partitioned-database-suitability) for help understanding whether your application can use partitioned databases.
{: note}

From an application perspective, the key difference between a non-partitioned database and a partitioned database is how you can query your data:

- A non-partitioned database allows only global secondary indexes to be created and queried.
- A partitioned database allows both global and partitioned secondary indexes to be created and queried.

This document contains more detail about the use-cases for each index type.

## Limits for partitioned databases
{: #limits-for-partitioned-databases}

Partitioned databases have limits on the number of indexes and the total size of
all documents with the same partition key.

Partition-scoped queries have a shorter service-enforced timeout than global
queries and a smaller limit on the total documents that can be retrieved in one
HTTP request.

Refer to [{{site.data.keyword.cloudant_short_notm}} Limits](/docs/Cloudant?topic=Cloudant-limits) for details on these restrictions.

## Reasons to use a partitioned database
{: #reasons-to-use-a-partitioned-database}

Partitioned databases are ideal when your application benefits from grouping related documents and needs predictable, scalable query performance.

A partitioned database offers both partition-scoped and global querying.
Partition-scoped querying takes advantage of the co-location of documents with
a given partition key, enabling more efficient and scalable query performance.
For workloads that can be expressed in terms of a partition key, this can
significantly reduce query latency and decrease costs.

Partitioning is especially valuable when your application needs predictable
performance at scale. Partition-scoped queries that make effective use of
indexes remain fast even as the dataset grows, and can scale efficiently
across up to 64 shards. This makes partitioned databases well-suited for
high-throughput, low-latency workloads.

Typically, when the data set requires many database shards, applications use
partition-scoped queries for latency-sensitive operations, while global queries
are reserved for less time-critical tasks such as batch processing.

## Reasons partitioned databases might not be suitable
{: #reasons-partitioned-databases-might-be-a-bad-fit}

Partitioned databases require careful data modeling and may require duplicating
indexes. For many use-cases, this extra effort doesn't pay off.

While partitioned databases offer performance benefits when used appropriately,
they introduce constraints that may not align with every workload. You must
define a meaningful partition key for your applications that groups related
documents and supports efficient querying. If each document has a unique key, or
if there are too few partition keys, partitioned databases are likely to perform
worse than non-partitioned databases.

Partition-scoped queries require you to create partitioned indexes. This may
require maintaining both global and partitioned indexes, depending on the access
patterns of your application.

## Determining partitioned database suitability
{: #determining-partitioned-database-suitability}

Now you understand the advantages and disadvantages of partitioned databases,
the next step is understanding whether a your data model will work well with a
partitioned database.

Evaluate your data model and application needs against these criteria for
determining partitioned database suitability:

1. **A high cardinality of partition keys is essential**: the number of distinct partition keys should be _far greater_ than the number of shards.
1. **Query load must be evenly distributed**: if most queries target a single partition key, it can create hot-spots and degrade performance.
1. **Partition keys should group related documents**: if each key maps to only one document, partitioning offers little benefit.

### Good and bad partition key examples
{: #good-and-bad-partition-key-examples}

To ground this, let's look at some use-cases and some good and bad choices for a
partition key.

| Use Case                   | Partition Key | Good or Bad | Reason |
|---|---|---|---|
| E-commerce system - orders |  `customer_id`       | Good | High cardinality and queries are spread across many customers.                                                             |
| E-commerce system - orders |  `order_id`       | Bad | One document per partition; no grouping or reuse.                                                             |
| E-commerce system - orders |  `status`        | Bad | Low cardinality of status values (provisional, paid, refunded, canceled) creates too few partitions.  |
| E-commerce system - orders |  `country_code`        | Bad | Low cardinality; a few countries dominate traffic.   |
| IoT - sensor readings      |  `device_id`     | Good | Many devices generate data, distributing load evenly. |
| IoT - sensor readings      |  `reading_id`     | Bad | Unique per document; partitions contain only one item. |
| IoT - sensor readings      |  `date`          | Bad | Most queries target recent dates, causing hot-spots.                                  |
| IoT - sensor readings | `region`                     | Bad      | Few regions may dominate traffic, leading to imbalance.                |
{: caption="Good and bad choices for a partition key" caption-side="top"}

Some use-cases exist where no viable choice for a partition key exists. In
these situations, a non-partitioned database is the best choice. For example, a
database of users that stores email addresses, password hashes, and last-login
dates. None of these fields make for a suitable partition key, so a 
non-partitioned database must be used instead.

## Creating partitioned databases and indexes
{: #creating-partitioned-databases-and-indexes}

You must decide whether to partition at database creation time. When you create
a database, use the `partitioned` query string parameter to set whether the
database is partitioned. The default for `partitioned` is `false`.

Similarly, an index is either _global_ or _partitioned_; you set this when
creating an index using the `partitioned` field in your design document. All
indexes in the design document inherit the `partitioned` field of the design
document. When querying a partitioned index, you use _partition-scoped queries_
that include the partition key to query in your request.

The partitioning type of an index or database can't be changed after it is created.

Partition-scoped queries can only be made to partitioned indexes. Similarly,
global queries can only be made to global indexes.
{: note}

### Querying
{: #querying}

{{site.data.keyword.cloudant_short_notm}} supports both global and
partition-scoped querying. To use both types effectively, separate indexes must
be created for each query scope.

Global queries perform well in databases with low shard counts (16 or fewer),
but they become less suitable for latency-sensitive operations as the number of
shards increases. In contrast, partition-scoped queries scale efficiently with
larger shard counts and are the preferred option for applications that require
predictable, low-latency performance for large data sets.

To benefit from partition-scoped querying, the majority of application queries
must target specific partition keys. This allows the database to take advantage
of document co-location and deliver consistent performance at scale.

See [How sharding affects database performance](/docs/Cloudant?topic=Cloudant-how-is-data-stored-in-ibm-cloudant-#how-does-sharding-affect-performance-) for details of how global and partition-scoped queries affect performance of your database operations.

### Global querying
{: #global-querying}

You can make global queries using:

- [Views](/apidocs/cloudant#postview)
- [{{site.data.keyword.cloudant_short_notm}} Query](/apidocs/cloudant#postfind)
- [Search](/apidocs/cloudant#postsearch)

Creating a global index is the default, but you can explicitly create a global index using `"options.partitioned": false` in your design document:

```json
{
  "options": {
    "partitioned": false
  },
  "views": {
    "by-device": {
      "map": "function(doc) { emit(doc.deviceID, doc.infrastructureID) }"
    }
  }
}
```
{: codeblock}

### Partition-scoped querying
{: #partition-querying}

You can make partition-scoped queries using:

- [Views](/apidocs/cloudant#postpartitionview)
- [{{site.data.keyword.cloudant_short_notm}} Query](/apidocs/cloudant#postpartitionfind-partitioned-databases)
- [Search](/apidocs/cloudant#postpartitionsearch)

To create a partitioned index that support partition-scoped queries, specify `"options.partitioned": true` in your design document:

```json
{
  "options": {
    "partitioned": true
  },
  "views": {
    "by-device": {
      "map": "function(doc) { emit(doc.deviceID, doc.infrastructureID) }"
    }
  }
}
```
{: codeblock}

## Partitioned databases tutorials
{: #partitioned-databases-tutorials}

Partitioned databases can be difficult to understand in the abstract. You can see the concepts in action in these two examples:

1. Read [Creating an IoT historian using partitioned databases](/docs/Cloudant?topic=Cloudant-creating-an-iot-historian-using-partitioned-databases) for a deep dive into partitioned databases with examples in several programming languages.
1. Read about [partitioned databases and Node.js](https://blog.cloudant.com/2019/05/24/Partitioned-Databases-with-Cloudant-Libraries.html){: external} in this blog article that includes how to create a partitioned database, search, views, and a global index. 
