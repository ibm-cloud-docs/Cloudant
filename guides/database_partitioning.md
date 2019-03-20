---

copyright:
  years: 2019
lastupdated: "2019-03-15"

keywords: database shards, non-partitioned databases, partition key, global query, partition query, create partition database, create partition query index

subcollection: cloudant

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

<!-- Acrolinx: 2018-08-17 -->

# Database partitioning
{: #database-partitioning}

The {{site.data.keyword.cloudant_short_notm}} partitioned database feature is currently in beta mode. Partition databases should not be used for production application usage. This feature is being rolled out across all {{site.data.keyword.cloudant_short_notm}} environments and will be generally available in the coming weeks.
{: important}

{{site.data.keyword.cloudantfull}} supports two types of databases:

- Partitioned
- Non-partitioned

A _partitioned_ database offers significant performance and cost advantages but
requires you to specify a logical partitioning of your data. This is described
more below.

Alternatively, a _non-partitioned_ database can be created. This type of
database can be easier to work with as no partitioning scheme needs to be
defined, but only global secondary indexes can be created.

{{site.data.keyword.cloudant_short_notm}} strongly recommends that you use a partitioned database for best long-term
database performance where the data model allows for logical partitioning
of documents.

The partitioning type of a database is set at database creation time.  When
creating a database, use the `partitioned` query string parameter to set whether
the database is partitioned. The default for `partitioned` is `false`,
maintaining backwards compatibility.

The partitioning type cannot be changed for an existing database.

## Database shards
{: #database-shards}

Before reading this document, you must understand the
[sharding concept](/docs/services/Cloudant?topic=cloudant-how-is-data-stored-in-ibm-cloudant-#how-is-data-stored-in-ibm-cloudant-) within {{site.data.keyword.cloudant_short_notm}}.

## Non-partitioned databases
{: #non-partitioned-databases}

A non-partitioned database is the older type of {{site.data.keyword.cloudant_short_notm}} database, and the one
that will be familiar if you have used CouchDB or {{site.data.keyword.cloudant_short_notm}} previously.

Within a non-partitioned database, documents are distributed to shards in an
arbitrary manner based on a transformation of their document ID. Thus, there is
no real relation between a document's ID and the shard it ends up on. Documents
with very similar document IDs are unlikely to be placed onto the same shard.

A non-partitioned database offers only global querying, described in more
detail below.

## Partitioned databases
{: #partitioned-databases}

A partitioned database is the newer type of {{site.data.keyword.cloudant_short_notm}} database. Within a
partitioned database, documents are formed into logical partitions by use
of a _partition key_, which is part of document IDs for documents within
partitioned databases. All documents are assigned to a partition, and many
documents are typically given the same partition key. A partition's primary
JSON data and its indexes end up co-located, meaning that the database is
able to query data within a partition more efficiently.

A partitioned database offers both partitioned and global querying. Partitioned
querying takes advantage of the data layout within the database cluster to
deliver improved and more scalable query performance. In addition, partition
queries are often cheaper than global queries.

As partitioned databases offer the advantages of both global and partition
querying, {{site.data.keyword.cloudant_short_notm}} recommends new applications take advantage of them.

## What makes a good partition key?
{: #what-makes-a-good-partition-key-}

If you're thinking of using {{site.data.keyword.cloudant_short_notm}}'s new *partitioned database* feature, then
the choice of a partition key is very important. A partition key must have:

- Many values - lots of small partitions are better than a few large ones.
- No hot spots - avoid designing a system that makes one partition handle a high
  proportion of the workload. If the work is evenly distributed around the
  partitions, the database will perform more smoothly.
- Repeating - If each partition key is unique, there will be one document per
  partition. To get the best out of partitioned databases, there must be
  multiple documents per partition - documents that logically belong together.

Let's look at some use cases and some good and bad choices for a partition key.

| Use case                   | Description                 | Partition Key | Effectiveness                                                                                                  |
|----------------------------|-----------------------------|---------------|------------------------------------------------------------------------------------------------------------------|
| E-commerce system - orders | One document per order     | order_id      | Neutral - one document per partition is fine, but it does not provide the benefits of Partition Queries.          |
| E-commerce system - orders | One document per order     | user_id       | Good - all of a user's orders will be kept together.                                                             |
| E-commerce system - orders | One document per order      | status        | Bad - grouping orders by a handful of status values (provisional, paid, refunded, cancelled) will create too few over-large partitions.  |
| Blogging platform          | One document per blog post | author_id     | Good - as long as there are many authors. Easy to query each author's posts.                                     |
| IOT - sensor readings      | One document per reading    | device_id     | Good - if there are many devices. Make sure that one device is not producing many more readings than the others. |
| IOT - sensor readings      | One document per reading    | date          | Bad - current readings will cause a "hot spot" on the current date's partition.                                  |

There are some use cases where there isn't a viable choice for a partition key.
In these situations, it's likely that a non-partitioned database is the best
choice, for example, a database of users storing email addresses, password hashes, and last-login dates. None of these fields make for a suitable partition key, so a
normal non-partitioned database must be used instead.

## Querying
{: #querying}

This section describes which of {{site.data.keyword.cloudant_short_notm}}'s query types are available
for global and partition queries, along with a brief overview of the
underlying querying mechanism to allow you to select which query mechanism
is best for each query your application needs to make.

### Global querying
{: #global-querying}

You can make global queries to the following index types:

- {{site.data.keyword.cloudant_short_notm}} Query
- Views
- Search
- Geo

When making a global query, the database must perform a scatter-gather operation
across all data in the database. This means making requests of many individual
database servers. The API coordination node receives the responses from all
these servers and combines them to form a single response to the client. This
might involve buffering data and delaying the response to the client if, for
example, data requires sorting.

### Partition querying
{: #partition-querying}

You can make partition queries to the following index types:

- {{site.data.keyword.cloudant_short_notm}} Query
- Views
- Search

When making a partition query, the database is able to query just the data
within a single partition. As a partition's data resides in just one shard (with
three replicas), the API coordination node is able to make a request directly
to servers hosting that data rather than needing to combine responses from
many servers. It is also freed from buffering the response, as there is no
combination step to carry out. Therefore, the data arrives at the client more
quickly.

In addition, as the size of a database increases, so does the number of shards
need to increase. This directly increases the number of queries that the
API coordination node needs to make to servers hosting data when using global
queries. When using partition queries, however, the number of shards has no
effect on the number of servers the API coordination node needs to contact. As
this number remains small, increasing data size has no effect on query latency,
unlike global queries.

## Example: partitioning IoT reading data
{: #example-partitioning-iot-reading-data}

This discussion is quite abstract; let's make it concrete with an example. We'll
take the Internet of Things domain and look at using {{site.data.keyword.cloudant_short_notm}} as a historian for
device readings. Say the devices are providing sensor readings on pieces of
infrastructure like roads or bridges.

We'll assume:

- Hundreds or thousands of devices reporting readings.
- Each device has a unique ID.
- Each piece of infrastructure has a unique ID.
- Devices are not moved between pieces of infrastructure.
- Each device writes a reading to {{site.data.keyword.cloudant_short_notm}} every 10 seconds. Likely this is
    delivered via a message bus to {{site.data.keyword.cloudant_short_notm}}.

In a non-partitioned database, you might allow {{site.data.keyword.cloudant_short_notm}} to generate document
IDs. Another alternative is to name documents by device ID and record timestamp.

Using the second approach, we'd end up with document IDs like the following:

```
device-123456:20181211T11:13:24.123456Z
```

The timestamp could also be an epoch timestamp.

This approach would allow for the data for each device to be queried efficiently
using partitioned indexes, but global indexes might need to be used to create
views over multiple devices (say all devices on a given piece of
infrastructure).

For illustrative purposes, let's make the scenario a bit more complicated by
assuming that the application mostly needs to read all sensor data for a given
piece of infrastructure rather than for individual devices.

In this application, we want querying by infrastructure item to be most
efficient, so partitioning the data by piece of infrastructure makes a lot more
sense than by ID. This would allow all the devices for a given piece of
infrastructure to be efficiently queried as a group.

For the rare queries by device, there are two approaches:

1. Build a global index keyed by device and query this. This is more effective
    if queries to individual devices are rare and not repeated.
2. Build a global index mapping device to infrastructure, then issue partition
    queries to the infrastructure partition. This makes sense if repeated
    queries to given devices are used as the mapping can be cached; we'll assume
    this is the case for our application.

Let's take a look at how this works out. We'll look at four queries:

1. Readings for all time for a piece of infrastructure.
1. Readings for today for a piece of infrastructure.
1. Readings for all time for a specific device.
1. Readings for today for a specific device.

### Creating the database
{: #creating-the-database}

We'll use a database called `readings` and an account called
`acme`. To create this as a partitioned database, pass `true` as the
`partitioned` argument to the database creation request:

```
curl -XPUT 'https://acme.cloudant.com/readings?partitioned=true'
```

### Document structure
{: #document-struture}

First, let's define a simple document format to work with:

```json
{
    "deviceID": "device-123456",
    "infrastructureID": "bridge-9876",
    "ts": "20181211T11:13:24.123456Z",
    "reading": {
        "temperature": {"value": 12, "unit": "c"}
    }
}
```

For this document, using the partitioning scheme based on piece of
infrastructure, the document ID might include the infrastructure ID as
the partition key, and include both device and timestamp as the document key:

```
bridge-9876:device-123456-20181211T11:13:24.123456Z
```

### Creating indexes
{: #creating-indexes}

For the above queries, we'll need two indexes:

1. A global index mapping device ID to infrastructure ID.
2. A partitioned index mapping device IDs to readings.

#### Creating a global view index
{: #creating-a-global-view-index}

A view index is the most efficient way to do the simple device ID to
infrastructure ID mapping. To define it, upload a design document with
`options.partitioned` set to `false` as this index is global. While in a
real `map` function you'd want to be more defensive around field existence,
this would look something like this:

```json
{
    "_id": "_design/infrastructure-mapping",
    "options": {"partitioned": false},
    "views": {
        "by-device": {
            "map": "function(doc) { emit(doc.deviceID, doc.infrastructureID) }"
        }
    }
}
```

Assuming the above document in `./view.json`, this is uploaded to the database
using:

```
curl -XPOST https://acme.cloudant.com/readings -d @view.json
```

#### Creating a partitioned {{site.data.keyword.cloudant_short_notm}} Query index
{: #creating-a-paritioned-ibm-cloudant-query-index}

To return the readings for a given device from a partition, we can use an
{{site.data.keyword.cloudant_short_notm}} Query index. For this, we `POST` to `_index` with an index definition
that includes the `partitioned` field set to `true`. Note that for Query index
definitions that the `partitioned` field is not nested inside an `options`
object.

For our queries, we need two partitioned indexes:

1. By timestamp
2. By device ID and timestamp

The definition of the by timestamp is as follows:

```json
{
   "index": {
      "fields": [
         "ts"
      ]
   },
   "name": "timestamped-readings",
   "type": "json",
   "partitioned:" true
}
```

Assuming the above document is `./query-index1.json`, upload the index to the
database using this command:

```
curl -XPOST https://acme.cloudant.com/readings/_index -d @query-index1.json
```

The definition of the by device ID and timestamp is as follows:

```json
{
   "index": {
      "fields": [
         "deviceID",
         "ts"
      ]
   },
   "name": "deviceID-readings",
   "type": "json",
   "partitioned:" true
}
```

Assuming the above document is `./query-index2.json`, upload the index to the
database using this command:

```
curl -XPOST https://acme.cloudant.com/readings/_index -d @query-index2.json
```

### Making queries
{: #making-queries}

Overall, we want to make four queries:

1. Readings for all time for a piece of infrastructure.
1. Readings for today for a piece of infrastructure.
1. Readings for all time for a specific device.
1. Readings for today for a specific device.

#### Finding all readings for a piece of infrastructure
{: #finding-all-readings-for-a-piece-of-infrastructure}

As our partitions are infrastructure-based, we can use `_all_docs` for a
partition. For example, querying for all readings for the `bridge-1234`
infrastructure piece:

```
curl -XGET \
    'https://acme.cloudant.com/readings/_partition/bridge-1234/_all_docs?include_docs=true'
```

#### Finding recent readings for a piece of infrastructure
{: #finding-recent-readings-for-a piece-of-infrastructure}

This query needs to use the partitioned `timestamped-readings` index. We can
issue a query to the partition to get the readings for today:

_query.json, assuming today is 13th Dec 2018:_

```json
{
    "selector": {
        "ts": { "$gte": "20181213"}
    }
}
```

The partition is embedded in the HTTP path when issuing the request to {{site.data.keyword.cloudant_short_notm}}:

```
curl -XPOST \
    'https://acme.cloudant.com/readings/_partition/bridge-1234/_find' \
    -d @query.json
```

#### Finding the infrastructure ID for a device
{: #finding-the-infrastructure-id-for-a-device}

The two queries we've yet to perform are:

1. Readings for all time for a specific device.
2. Readings for today for a specific device.

For these two queries, we need to find the partition for the devices using the
global `by-device` index. Then we can query the individual partition for
readings. While we might have used a global index to query for the readings for
individual devices, the mapping from device to infrastructure ID is highly
cache-able -- it never changes! -- so this approach allows us to mostly use
the cheaper and more efficient partitioned query for most requests.

Using a global index to query directly for device readings may be more efficient
if caching the device to infrastructure mapping doesn't work well for a given
application.

To find the relevant partition for a device, we query the `by-device` view,
sending the device ID as the key:

```
curl -XGET \
  'https://acme.cloudant.com/readings/_design/infrastructure-mapping/_view/by-device?keys=["device-123456"]&limit=1'
```

This returns:

```json
{"total_rows":5,"offset":0,"rows":[
{
    "id":"bridge-9876:device-123456-20181211T11:13:24.123456Z",
    "key":"device-123456",
    "value":"bridge-9876"
}
]}
```

We have our partition key in the `value` field of the included row:
`bridge-9876`.

#### Querying for all results for a device
{: #querying-for-all-results-for-a-device}

To get the results for a device, we issue a partition query for the device
within the `bridge-9876` partition. A standard {{site.data.keyword.cloudant_short_notm}} Query selector is
used, as if one were issuing a global query.

_query.json:_

```json
{
   "selector": {
      "deviceID": {
         "$eq": "device-123456"
      }
   }
}
```

The partition is embedded in the HTTP path when issuing the request to {{site.data.keyword.cloudant_short_notm}}:

```
curl -XPOST \
    'https://acme.cloudant.com/readings/_partition/bridge-1234/_find' \
    -d @query.json
```

#### Querying for recent results for a device
{: #querying-for-recent-results-for-a-device}

To get the results for a device, we issue a partition query for the device
within the `bridge-9876` partition. The selector is only slightly more
complicated, but still the same as an equivalent global query.

_query.json, assuming today is 13th Dec 2018:_

```json
{
   "selector": {
      "deviceID": {
         "$eq": "device-123456"
      },
      "ts": {
         "$gte": "20181213"
      }
   }
}
```

The partition is embedded in the HTTP path when issuing the request to {{site.data.keyword.cloudant_short_notm}}:

```
curl -XPOST \
    'https://acme.cloudant.com/readings/_partition/bridge-1234/_find' \
    -d @query.json
```
