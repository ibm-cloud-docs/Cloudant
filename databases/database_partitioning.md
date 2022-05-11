---

copyright:
  years: 2019, 2022
lastupdated: "2022-04-22"

keywords: database shards, non-partitioned databases, partition key, global query, partition query, create partition database, create partition query index, partition search, tutorials, cardinality, partitioned

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
{{site.data.keyword.attribute-definition-list}}

# Database partitioning
{: #database-partitioning}

{{site.data.keyword.cloudantfull}} supports two types of databases:

- Partitioned
- Non-partitioned

A *partitioned* database offers significant performance and cost advantages but
requires you to specify a logical partitioning of your data. This process is described
more in the following text.
{: shortdesc}

Alternatively, you can create a *non-partitioned* database. This type of
database might be easier to work with as no partitioning scheme needs to be defined, but only global secondary indexes can be created.

{{site.data.keyword.cloudant_short_notm}} strongly recommends that you use a partitioned database for best long-term
database performance where the data model allows for logical partitioning
of documents.

You can decide whether to partition at database creation time. When
you create a database, use the `partitioned` query string parameter to set whether
the database is partitioned. The default for `partitioned` is `false`,
maintaining compatibility with an earlier version.

The partitioning type can't be changed for an existing database.

## Database shards
{: #database-shards}

Before you read this document, you must understand the
[sharding concept](/docs/Cloudant?topic=Cloudant-how-is-data-stored-in-ibm-cloudant-#how-is-data-stored-in-ibm-cloudant-) within {{site.data.keyword.cloudant_short_notm}}.

## Non-partitioned databases
{: #non-partitioned-databases}

A non-partitioned database is the older type of {{site.data.keyword.cloudant_short_notm}} database, and the one
that is familiar if you used CouchDB or {{site.data.keyword.cloudant_short_notm}} previously.

Within a non-partitioned database, documents are distributed to shards in an
arbitrary manner based on a transformation of their document ID. Therefore, no real relation exists between a document's ID and the shard it ends up on. Documents
with similar document IDs are unlikely to be placed onto the same shard.

A non-partitioned database offers only global querying, described in more
detail later.

## Partitioned databases
{: #partitioned-databases-database-partitioning}

A partitioned database is the newest type of {{site.data.keyword.cloudant_short_notm}} database. Within a partitioned database, documents are formed into logical partitions by use
of a *partition key*. The partition key is part of the document ID for documents within
a partitioned database. All documents are assigned to a partition, and many
documents are typically given the same partition key. A partition's primary
JSON data and its indexes end up colocated, meaning that the database can 
query data within a partition more efficiently.

A partitioned database offers both partitioned and global querying. Partitioned
querying takes advantage of the data layout within the database cluster to
deliver improved and more scalable query performance. Partition
queries are also often cheaper than global queries.

As partitioned databases offer the advantages of both global and partition
querying, {{site.data.keyword.cloudant_short_notm}} recommends that new applications take advantage of them.

## What makes a good partition key?
{: #what-makes-a-good-partition-key}

If you're thinking of using {{site.data.keyword.cloudant_short_notm}}'s new *partitioned database* feature, then
the choice of a partition key is important. A partition key must have:

- Many values - lots of small partitions are better than a few large ones. A million partitions are perfectly fine, but keep each partition under 10 GB in total size. 
- No hot spots - avoid designing a system that makes one partition handle a high proportion of the workload. If the work is evenly distributed around the partitions, the database performs more smoothly.
- Repeating - If each partition key is unique, one document per partition exists. To get the best out of partitioned databases, multiple documents per partition must exist - documents that logically belong together.

Let's look at some use cases and some good and bad choices for a partition key.

| Use Case                   | Description                 | Partition Key | Effectiveness                                                                                                  |
|----------------------------|-----------------------------|---------------|------------------------------------------------------------------------------------------------------------------|
| E-commerce system - orders | One document per order     | `order_id`      | Neutral - one document per partition is fine, but it doesn't provide the benefits of Partition Queries.          |
| E-commerce system - orders | One document per order     | `user_id`       | Good - all of a user's orders are kept together.                                                             |
| E-commerce system - orders | One document per order      | `status`        | Bad - grouping orders by a handful of status values (provisional, paid, refunded, cancelled) create too few over-large partitions.  |
| Blogging platform          | One document per blog post | `author_id`    | Good - if many authors participate. Easy to query each author's posts.                                     |
| IOT - sensor readings      | One document per reading    | `device_id`     | Good - if many devices exist, make sure that one device isn't producing many more readings than the others. |
| IOT - sensor readings      | One document per reading    | `date`          | Bad - current readings cause a "hot spot" on the current date's partition.                                  |
{: caption="Table 1. Good and bad choices for a partition key" caption-side="top"}

Some use cases exist where no viable choice for a partition key exists.
In these situations, it's likely a non-partitioned database is the best
choice. For example, a database of users that stores email addresses, password hashes, and last-login dates. None of these fields make for a suitable partition key, so a
normal non-partitioned database must be used instead.

## Querying
{: #querying}

{{site.data.keyword.cloudant_short_notm}}'s query types are available for global and partition queries. See also a brief overview of the
underlying querying mechanism that you use to select the query mechanism that
is best for each query your application needs to make.

### Global querying
{: #global-querying}

You can make global queries to the following index types:

- {{site.data.keyword.cloudant_short_notm}} Query
- Views
- Search
- Geo

When you make a global query, the database must perform a scatter-gather operation
across all data in the database. This action means making requests of many individual
database servers. The API coordination node receives the responses from all
these servers and combines them to form a single response to the client. This response
might involve buffering data and delaying the response to the client if, for
example, data requires sorting.

### Partition querying
{: #partition-querying}

You can make partition queries to the following index types:

- {{site.data.keyword.cloudant_short_notm}} Query
- Views
- Search

When you make a partition query, the database can query just the data
within a single partition. A partition's data resides in just one shard (with
three replicas). The API coordination node can make a request directly
to servers that host that data rather than needing to combine responses from
many servers. The API coordination node is also free from buffering the response since it has no combination step to carry out. As a result, the data arrives at the client more
quickly.

As the size of a database increases, the number of shards
must also increase. The increase in shards directly increases the number of queries that the
API coordination node needs to make to servers that host data when you use global
queries. However, when you use partition queries, the number of shards has no
effect on the number of servers the API coordination node needs to contact. As
this number stays small, increasing data size has no effect on query latency,
unlike global queries.

## Partitioned databases tutorials
{: #partitioned-databases-tutorials}

You can see two examples of using partitioned databases:

1. Read about [partitioned databases and Node.js](https://blog.cloudant.com/2019/05/24/Partitioned-Databases-with-Cloudant-Libraries.html){: external} in this blog article that includes how to create a partitioned database, search, views, and a global index. 
2. Read the following example about using views and the `_all_docs` endpoint.

## Example - Partitioning IoT reading data
{: #example-partitioning-iot-reading-data}

This discussion is abstract; let's make it concrete with an example. We
take the Internet of Things domain and look at using {{site.data.keyword.cloudant_short_notm}} as a historian for
device readings. Say that the devices provide sensor readings on pieces of
infrastructure like roads or bridges.

Review the following assumptions:

- Hundreds or thousands of devices that report readings.
- Each device has a unique ID.
- Each piece of infrastructure has a unique ID.
- Devices aren't moved between pieces of infrastructure.
- Each device writes a reading to {{site.data.keyword.cloudant_short_notm}} every 10 seconds. Likely this reading is delivered by using a message bus to {{site.data.keyword.cloudant_short_notm}}.

In a non-partitioned database, you might allow {{site.data.keyword.cloudant_short_notm}} to generate document
IDs. Another alternative is to name documents by device ID and record timestamp.

Using the second approach, we'd end up with document IDs like the following example:

```sh
device-123456:20181211T11:13:24.123456Z
```
{: codeblock}

The timestamp could also be an epoch timestamp.

This approach allows the data for each device to be queried efficiently
by using partitioned indexes. However, global indexes might need to be used to create
views over multiple devices, for example, all devices on a specific piece of
infrastructure.

For illustrative purposes, let's make the scenario a bit more complicated. Assume that the application mostly needs to read all sensor data for a specific 
piece of infrastructure rather than for individual devices.

In this application, you query by infrastructure item to be most
efficient, so partitioning the data by piece of infrastructure makes a lot more
sense than by ID. This practice would allow all the devices for a specific piece of
infrastructure to be efficiently queried as a group.

For the rare queries by device, you use two approaches:

1. Build a global index that is keyed by device and query it. This approach is more effective
    if queries to individual devices are rare and not repeated.
2. Build a global index-mapping device to infrastructure, then issue partition
    queries to the infrastructure partition. This approach makes sense if repeated
    queries to specific devices are used as the mapping can be cached. This approach is used for this application.

Let's look at how this approach works out. Let's look at four queries:

1. Readings for all time for a piece of infrastructure.
1. Readings for today for a piece of infrastructure.
1. Readings for all time for a specific device.
1. Readings for today for a specific device.

### Creating the database
{: #creating-the-database}

To create a partitioned database, pass `true` as the `partitioned` argument to the database creation request:

All tutorials in this section will use `readings` as the example database.

```sh
curl -X PUT "$SERVICE_URL/readings?partitioned=true"
```
{: codeblock}
{: curl}

```java
import com.ibm.cloud.cloudant.v1.Cloudant;
import com.ibm.cloud.cloudant.v1.model.Ok;
import com.ibm.cloud.cloudant.v1.model.PutDatabaseOptions;

Cloudant service = Cloudant.newInstance();

PutDatabaseOptions databaseOptions = new PutDatabaseOptions.Builder()
.db("readings")
.partitioned(true)
.build();

Ok response =
service.putDatabase(databaseOptions).execute()
.getResult();

System.out.println(response);
```
{: codeblock}
{: java}

```javascript
const { CloudantV1 } = require('@ibm-cloud/cloudant');

const service = CloudantV1.newInstance({});

service.putDatabase({
  db: 'readings',
  partitioned: true
}).then(response => {
  console.log(response.result);
});
```
{: codeblock}
{: node}

```python
from ibmcloudant.cloudant_v1 import CloudantV1

service = CloudantV1.new_instance()

response = service.put_database(db='readings', partitioned=True).get_result()

print(response)
```
{: codeblock}
{: python}

```go
putDatabaseOptions := service.NewPutDatabaseOptions(
"readings",
)
putDatabaseOptions.SetPartitioned(true)

ok, response, err := service.PutDatabase(putDatabaseOptions)
if err != nil {
panic(err)
}

b, _ := json.MarshalIndent(ok, "", "  ")
fmt.Println(string(b))
```
{: codeblock}
{: go}

The previous Go example requires the following import block:
{: go}

```go
import (
   "encoding/json"
   "fmt"
   "github.com/IBM/cloudant-go-sdk/cloudantv1"
)
```
{: codeblock}
{: go}

All Go examples require the `service` object to be initialized. For more information, see the API documentation's [Authentication section](/apidocs/cloudant?code=go#authentication-with-external-configuration) for examples.
{: go}

### Document structure
{: #document-struture}

First, let's define a simple document format to work with:

```json
{
  "deviceID": "device-123456",
  "infrastructureID": "bridge-9876",
  "ts": "20181211T11:13:24.123456Z",
  "reading": {
    "temperature": {
      "value": 12,
      "unit": "c"
    }
  }
}
```
{: codeblock}

This document uses the partitioning scheme based on a piece of infrastructure. The document ID might include the infrastructure ID as the partition key, and include both device and timestamp as the document key:

```sh
bridge-9876:device-123456-20181211T11:13:24.123456Z
```
{: codeblock}

### Creating indexes
{: #creating-indexes}

For the queries described previously, you need two indexes:

1. A global index-mapping device ID to infrastructure ID
2. A partitioned index-mapping device ID to reading

#### Creating a global view index
{: #creating-a-global-view-index}

A view index is the most efficient way to do the simple device ID to
infrastructure ID mapping. To define it, upload a design document with
`options.partitioned` set to `false` as this index is global. While in a
real `map` function you'd want to be more defensive around field existence,
this document would look something like this:

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

Assuming the previous document in `./view.json`, this document is uploaded to the database by using:

```sh
curl -X PUT "$SERVICE_URL/readings/_design/infrastructure-mapping" -H 'Content-Type: application/json' --data @view.json
```
{: codeblock}

For more language examples that show creating a global view, see the [Storing the view definition](/docs/Cloudant?topic=Cloudant-creating-views-mapreduce#storing-the-view-definition) guide, or [the Create or modify a design document section in API Docs](/apidocs/cloudant#putdesigndocument).

#### Creating a partitioned {{site.data.keyword.cloudant_short_notm}} Query index
{: #creating-a-paritioned-ibm-cloudant-query-index}

To return the readings for a specific device from a partition, you can use an
{{site.data.keyword.cloudant_short_notm}} Query index. For this document, use `POST` to `_index` with an index definition
that includes the `partitioned` field set to `true`. 

For Query index definitions, the `partitioned` field isn't nested inside an `options`
object.
{: note}

For these queries, you need two partitioned indexes:

1. By timestamp
2. By device ID and timestamp

##### Uploading partitioned index by timestamp
{: #uploading-partitioned-index-by-timestamp}

Upload the index by timestamp to the database by using this command:

```sh
curl -X POST "$SERVICE_URL/readings/_index" -H 'Content-Type: application/json' --data '{
   "index": {
      "fields": [
         {"ts": "asc"}
      ]
   },
   "name": "timestamped-readings",
   "type": "json",
   "partitioned": true
}'
```
{: codeblock}
{: curl}

```java
import com.ibm.cloud.cloudant.v1.Cloudant;
import com.ibm.cloud.cloudant.v1.model.IndexDefinition;
import com.ibm.cloud.cloudant.v1.model.IndexField;
import com.ibm.cloud.cloudant.v1.model.IndexResult;
import com.ibm.cloud.cloudant.v1.model.PostIndexOptions;

Cloudant service = Cloudant.newInstance();

IndexField indexField = new IndexField.Builder()
    .add("ts", "asc")
    .build();

IndexDefinition index = new IndexDefinition.Builder()
    .addFields(indexField)
    .build();

PostIndexOptions indexOptions = new PostIndexOptions.Builder()
    .db("readings")
    .index(index)
    .name("timestamped-readings")
    .type("json")
    .partitioned(true)
    .build();

IndexResult response =
    service.postIndex(indexOptions).execute()
        .getResult();

System.out.println(response);
```
{: codeblock}
{: java}

```javascript
const { CloudantV1 } = require('@ibm-cloud/cloudant');

const service = CloudantV1.newInstance({});

const indexField = {
  ts: 'asc'
}

const index = {
  fields: [indexField]
}

service.postIndex({
  db: 'readings',
  name: 'timestamped-readings',
  index: index,
  type: 'json',
  partitioned: true
}).then(response => {
  console.log(response.result);
});
```
{: codeblock}
{: node}

```python
from ibmcloudant.cloudant_v1 import CloudantV1, IndexDefinition, IndexField

service = CloudantV1.new_instance()

index_field = IndexField(ts='asc')

index = IndexDefinition(
    fields=[index_field]
)

response = service.post_index(
    db='readings',
    name='timestamped-readings',
    index=index,
    type='json',
    partitioned=True
).get_result()

print(response)
```
{: codeblock}
{: python}

```go
var indexField cloudantv1.IndexField
indexField.SetProperty("ts", core.StringPtr("asc"))

postIndexOptions := service.NewPostIndexOptions(
  "readings",
  &cloudantv1.IndexDefinition{
    Fields: []cloudantv1.IndexField{
      indexField,
    },
  },
)
postIndexOptions.SetName("timestamped-readings")
postIndexOptions.SetType("json")
postIndexOptions.SetPartitioned(true)

indexResult, response, err := service.PostIndex(postIndexOptions)
if err != nil {
  panic(err)
}

b, _ := json.MarshalIndent(indexResult, "", "  ")
fmt.Println(string(b))
```
{: codeblock}
{: go}

The previous Go example requires the following import block:
{: go}

```go
import (
   "encoding/json"
   "fmt"
   "github.com/IBM/cloudant-go-sdk/cloudantv1"
   "github.com/IBM/go-sdk-core/v5/core"
)
```
{: codeblock}
{: go}

All Go examples require the `service` object to be initialized. For more information, see the API documentation's [Authentication section](/apidocs/cloudant?code=go#authentication-with-external-configuration) for examples.
{: go}

##### Uploading partitioned index by device ID and timestamp
{: #uploading-partitioned-index-by-device-id-and-timestamp}

Upload the index by device ID and timestamp to the database by using this command:

```sh
curl -X POST "$SERVICE_URL/readings/_index" -H 'Content-Type: application/json' --data '{
   "index": {
      "fields": [
         {"deviceID": "asc"},
         {"ts": "asc"}
      ]
   },
   "name": "deviceID-readings",
   "type": "json",
   "partitioned": true
}'
```
{: codeblock}
{: curl}

```java
import com.ibm.cloud.cloudant.v1.Cloudant;
import com.ibm.cloud.cloudant.v1.model.IndexDefinition;
import com.ibm.cloud.cloudant.v1.model.IndexField;
import com.ibm.cloud.cloudant.v1.model.IndexResult;
import com.ibm.cloud.cloudant.v1.model.PostIndexOptions;

import java.util.Arrays;

Cloudant service = Cloudant.newInstance();

IndexField indexField1 = new IndexField.Builder()
    .add("deviceID", "asc")
    .build();

IndexField indexField2 = new IndexField.Builder()
    .add("ts", "asc")
    .build();

IndexDefinition index = new IndexDefinition.Builder()
    .fields(Arrays.asList(indexField1, indexField2))
    .build();

PostIndexOptions indexOptions = new PostIndexOptions.Builder()
    .db("readings")
    .index(index)
    .name("deviceID-readings")
    .type("json")
    .partitioned(true)
    .build();

IndexResult response =
    service.postIndex(indexOptions).execute()
        .getResult();

System.out.println(response);
```
{: codeblock}
{: java}

```javascript
const { CloudantV1 } = require('@ibm-cloud/cloudant');

const service = CloudantV1.newInstance({});

const indexField1 = {
  deviceID: 'asc'
}

const indexField2 = {
  ts: 'asc'
}

const index = {
  fields: [indexField1, indexField2]
}

service.postIndex({
  db: 'readings',
  name: 'deviceID-readings',
  index: index,
  type: 'json',
  partitioned: true
}).then(response => {
  console.log(response.result);
});
```
{: codeblock}
{: node}

```python
from ibmcloudant.cloudant_v1 import CloudantV1, IndexDefinition, IndexField

service = CloudantV1.new_instance()

index_field1 = IndexField(deviceID='asc')
index_field2 = IndexField(ts='asc')

index = IndexDefinition(
    fields=[index_field1, index_field2]
)

response = service.post_index(
    db='readings',
    name='deviceID-readings',
    index=index,
    type='json',
    partitioned=True
).get_result()

print(response)
```
{: codeblock}
{: python}

```go
var indexField1 cloudantv1.IndexField
var indexField2 cloudantv1.IndexField
indexField1.SetProperty("deviceID", core.StringPtr("asc"))
indexField2.SetProperty("ts", core.StringPtr("asc"))

postIndexOptions := service.NewPostIndexOptions(
  "readings",
  &cloudantv1.IndexDefinition{
    Fields: []cloudantv1.IndexField{
      indexField1,
      indexField2,
    },
  },
)
postIndexOptions.SetName("deviceID-readings")
postIndexOptions.SetType("json")
postIndexOptions.SetPartitioned(true)

indexResult, response, err := service.PostIndex(postIndexOptions)
if err != nil {
  panic(err)
}

b, _ := json.MarshalIndent(indexResult, "", "  ")
fmt.Println(string(b))
```
{: codeblock}
{: go}

The previous Go example requires the following import block:
{: go}

```go
import (
   "encoding/json"
   "fmt"
   "github.com/IBM/cloudant-go-sdk/cloudantv1"
   "github.com/IBM/go-sdk-core/v5/core"
)
```
{: codeblock}
{: go}

All Go examples require the `service` object to be initialized. For more information, see the API documentation's [Authentication section](/apidocs/cloudant?code=go#authentication-with-external-configuration) for examples.
{: go}

### Making queries
{: #making-queries}

Overall, you want to make four queries:

1. Readings for all time for a piece of infrastructure.
1. Readings for today for a piece of infrastructure.
1. Readings for all time for a specific device.
1. Readings for today for a specific device.

#### Finding all readings for a piece of infrastructure
{: #finding-all-readings-for-a-piece-of-infrastructure}

These partitions are infrastructure-based, so you can use `_all_docs` for a
partition. For example, query all readings for the `bridge-9876`
infrastructure piece by using the following command.

```sh
curl -X POST "$SERVICE_URL/readings/_partition/bridge-9876/_all_docs" -H 'Content-Type: 
application/json' --data '{"include_docs": true}'
```
{: codeblock}
{: curl}

```java
import com.ibm.cloud.cloudant.v1.Cloudant;
import com.ibm.cloud.cloudant.v1.model.AllDocsResult;
import com.ibm.cloud.cloudant.v1.model.PostPartitionAllDocsOptions;
Cloudant service = Cloudant.newInstance();

PostPartitionAllDocsOptions allDocsOptions =
    new PostPartitionAllDocsOptions.Builder()
        .db("readings")
        .partitionKey("bridge-9876")
        .includeDocs(true)
        .build();

AllDocsResult response =
    service.postPartitionAllDocs(allDocsOptions).execute()
        .getResult();

System.out.println(response);
```
{: codeblock}
{: java}

```javascript
import { CloudantV1 } from '@ibm-cloud/cloudant';

const service = CloudantV1.newInstance({});

service.postPartitionAllDocs({
  db: 'readings',
  partitionKey: 'bridge-9876',
  includeDocs: true
}).then(response => {
  console.log(response.result);
});
```
{: codeblock}
{: node}

```python
from ibmcloudant.cloudant_v1 import CloudantV1

service = CloudantV1.new_instance()

response = service.post_partition_all_docs(
  db='readings',
  partition_key='bridge-9876',
  include_docs=True
).get_result()

print(response)
```
{: codeblock}
{: python}

```go
postPartitionAllDocsOptions := service.NewPostPartitionAllDocsOptions(
  "readings",
  "bridge-9876",
)
postPartitionAllDocsOptions.SetIncludeDocs(true)

allDocsResult, response, err := service.PostPartitionAllDocs(postPartitionAllDocsOptions)
if err != nil {
  panic(err)
}

b, _ := json.MarshalIndent(allDocsResult, "", "  ")
fmt.Println(string(b))
```
{: codeblock}
{: go}

The previous Go example requires the following import block:
{: go}

```go
import (
   "encoding/json"
   "fmt"
   "github.com/IBM/cloudant-go-sdk/cloudantv1"
)
```
{: codeblock}
{: go}

All Go examples require the `service` object to be initialized. For more information, see the API documentation's [Authentication section](/apidocs/cloudant?code=go#authentication-with-external-configuration) for examples.
{: go}

#### Finding recent readings for a piece of infrastructure
{: #finding-recent-readings-for-a-piece-of-infrastructure}

This query needs to use [the partitioned `timestamped-readings` index](#creating-a-paritioned-ibm-cloudant-query-index). You can
issue a query to the partition to get the readings for today, assuming today is 13 December 2018.

The partition is embedded in the HTTP path when you issue the request to {{site.data.keyword.cloudant_short_notm}}:

```sh
curl -X POST "$SERVICE_URL/readings/_partition/bridge-9876/_find" -H 'Content-Type: 
application/json' --data '{
    "selector": {
        "ts": { "$gte": "20181213"}
    }
}'
```
{: codeblock}
{: curl}

```java
import com.ibm.cloud.cloudant.v1.Cloudant;
import com.ibm.cloud.cloudant.v1.model.FindResult;
import com.ibm.cloud.cloudant.v1.model.PostPartitionFindOptions;
import com.ibm.cloud.cloudant.v1.model.Selector;

import java.util.HashMap;
import java.util.Map;

Cloudant service = Cloudant.newInstance();

Map greaterThanOrEqualWithTs = new HashMap<>();
greaterThanOrEqualWithTs.put("$gte", "20181213");

Selector selector = new Selector();
selector.put("ts", greaterThanOrEqualWithTs);

PostPartitionFindOptions findOptions =
    new PostPartitionFindOptions.Builder()
        .db("readings")
        .partitionKey("bridge-9876")
        .selector(selector)
        .build();

FindResult response =
    service.postPartitionFind(findOptions).execute()
        .getResult();

System.out.println(response);
```
{: codeblock}
{: java}

```javascript
import { CloudantV1 } from '@ibm-cloud/cloudant';

const service = CloudantV1.newInstance({});

const selector: CloudantV1.Selector = {
  ts: {'$gte': '20181213'}
}
service.postPartitionFind({
  db: 'readings',
  partitionKey: 'bridge-9876',
  selector: selector
}).then(response => {
  console.log(response.result);
});
```
{: codeblock}
{: node}

```python
from ibmcloudant.cloudant_v1 import CloudantV1

service = CloudantV1.new_instance()

response = service.post_partition_find(
  db='readings',
  partition_key='bridge-9876',
  selector={'ts': {'$gte': '20181213'}}
).get_result()

print(response)
```
{: codeblock}
{: python}

```go
selector := map[string]interface{}{
  "ts": map[string]string{
    "$gte": "20181213",
  },
}

postPartitionFindOptions := service.NewPostPartitionFindOptions(
  "readings",
  "bridge-9876",
  selector,
)

findResult, response, err := service.PostPartitionFind(postPartitionFindOptions)
if err != nil {
  panic(err)
}

b, _ := json.MarshalIndent(findResult, "", "  ")
fmt.Println(string(b))
```
{: codeblock}
{: go}

The previous Go example requires the following import block:
{: go}

```go
import (
   "encoding/json"
   "fmt"
   "github.com/IBM/cloudant-go-sdk/cloudantv1"
)
```
{: codeblock}
{: go}

All Go examples require the `service` object to be initialized. For more information, see the API documentation's [Authentication section](/apidocs/cloudant?code=go#authentication-with-external-configuration) for examples.
{: go}

#### Finding the infrastructure ID for a device
{: #finding-the-infrastructure-id-for-a-device}

The two queries we've yet to perform are shown in the following list:

1. Readings for all time for a specific device.
2. Readings for today for a specific device.

For these two queries, you need to find the partition for the devices by using the
global `by-device` index. Then, you can query the individual partition for
readings. While you might use a global index to query for the readings for
individual devices, the mapping from device to infrastructure ID is highly
cache-able. It never changes! With this approach, you can mostly use
the cheaper and more efficient partitioned query for most requests.

Using a global index to query directly for device readings might be more efficient
if caching the device to infrastructure mapping doesn't work well for a specific
application.

To find the relevant partition for a device, you query the `by-device` view,
sending the device ID as the key:

```sh
curl -X POST "$SERVICE_URL/readings/_design/infrastructure-mapping/_view/by-device' -H 'Content-Type: application/json' --data '{
"keys": ["device-123456"], "limit": 1 
}'
```
{: codeblock}

For more language examples that show querying a global view, see the [Query a MapReduce view in API Docs](/apidocs/cloudant#postview).

The previous command returns the following response:

```json
{
  "total_rows": 5,
  "offset": 0,
  "rows": [
    {
      "id": "bridge-9876:device-123456-20181211T11:13:24.123456Z",
      "key": "device-123456",
      "value": "bridge-9876"
    }
  ]
}
```
{: codeblock}

The partition key is in the `value` field of the included row:
`bridge-9876`.

#### Querying for all results for a device
{: #querying-for-all-results-for-a-device}

To get the results for a device, you issue a partition query for the device
within the `bridge-9876` partition. A standard {{site.data.keyword.cloudant_short_notm}} Query selector is
used, as if one were issuing a global query.

The partition is embedded in the HTTP path when you issue the request to {{site.data.keyword.cloudant_short_notm}}:

```sh
curl -X POST "$SERVICE_URL/readings/_partition/bridge-9876/_find" -H 'Content-Type: 
application/json' --data '{
   "selector": {
      "deviceID": {
         "$eq": "device-123456"
      }
   }
}'
```
{: codeblock}
{: curl}

```java
import com.ibm.cloud.cloudant.v1.Cloudant;
import com.ibm.cloud.cloudant.v1.model.FindResult;
import com.ibm.cloud.cloudant.v1.model.PostPartitionFindOptions;
import com.ibm.cloud.cloudant.v1.model.Selector;

import java.util.HashMap;
import java.util.Map;

Cloudant service = Cloudant.newInstance();

Map equalWithDeviceID = new HashMap<>();
equalWithDeviceID.put("$eq", "device-123456");

Selector selector = new Selector();
selector.put("deviceID", equalWithDeviceID);

PostPartitionFindOptions findOptions =
    new PostPartitionFindOptions.Builder()
        .db("readings")
        .partitionKey("bridge-9876")
        .selector(selector)
        .build();

FindResult response =
    service.postPartitionFind(findOptions).execute()
        .getResult();

System.out.println(response);
```
{: codeblock}
{: java}

```javascript
import { CloudantV1 } from '@ibm-cloud/cloudant';

const service = CloudantV1.newInstance({});

const selector: CloudantV1.Selector = {
  deviceID: {'$eq': 'device-123456'}
}
service.postPartitionFind({
  db: 'readings',
  partitionKey: 'bridge-9876',
  selector: selector
}).then(response => {
  console.log(response.result);
});
```
{: codeblock}
{: node}

```python
from ibmcloudant.cloudant_v1 import CloudantV1

service = CloudantV1.new_instance()

response = service.post_partition_find(
  db='readings',
  partition_key='bridge-9876',
  selector={'deviceID': {'$eq': 'device-123456'}}
).get_result()

print(response)
```
{: codeblock}
{: python}

```go
selector := map[string]interface{}{
"deviceID": map[string]string{
"$eq": "device-123456",
},
}

postPartitionFindOptions := service.NewPostPartitionFindOptions(
"readings",
"bridge-9876",
selector,
)

findResult, response, err := service.PostPartitionFind(postPartitionFindOptions)
if err != nil {
panic(err)
}

b, _ := json.MarshalIndent(findResult, "", "  ")
fmt.Println(string(b))
```
{: codeblock}
{: go}

The previous Go example requires the following import block:
{: go}

```go
import (
   "encoding/json"
   "fmt"
   "github.com/IBM/cloudant-go-sdk/cloudantv1"
)
```
{: codeblock}
{: go}

All Go examples require the `service` object to be initialized. For more information, see the API documentation's [Authentication section](/apidocs/cloudant?code=go#authentication-with-external-configuration) for examples.
{: go}

#### Querying for recent results for a device
{: #querying-for-recent-results-for-a-device}

To get the results for a device, you issue a partition query for the device
within the `bridge-9876` partition. The selector is only slightly more
complicated, but still the same as an equivalent global query.

##### Query for recent results assuming today is 13 December 2018
{: #query-for-recent-results-assume-date-is-dec-13}

The partition is embedded in the HTTP path when issuing the request to {{site.data.keyword.cloudant_short_notm}}:

```sh
curl -X POST "$SERVICE_URL/readings/_partition/bridge-9876/_find" -H 'Content-Type: application/json' --data '{
   "selector": {
      "deviceID": {
         "$eq": "device-123456"
      },
      "ts": {
         "$gte": "20181213"
      }
   }
}'
```
{: codeblock}
{: curl}

```java
import com.ibm.cloud.cloudant.v1.Cloudant;
import com.ibm.cloud.cloudant.v1.model.FindResult;
import com.ibm.cloud.cloudant.v1.model.PostPartitionFindOptions;
import com.ibm.cloud.cloudant.v1.model.Selector;

import java.util.HashMap;
import java.util.Map;

Cloudant service = Cloudant.newInstance();

Map equalWithDeviceID = new HashMap<>();
equalWithDeviceID.put("$eq", "device-123456");

Map greaterThanOrEqualWithTs = new HashMap<>();
greaterThanOrEqualWithTs.put("$gte", "20181213");

Selector selector = new Selector();
selector.put("deviceID", equalWithDeviceID);
selector.put("ts", greaterThanOrEqualWithTs);

PostPartitionFindOptions findOptions =
    new PostPartitionFindOptions.Builder()
        .db("readings")
        .partitionKey("bridge-9876")
        .selector(selector)
        .build();

FindResult response =
    service.postPartitionFind(findOptions).execute()
        .getResult();

System.out.println(response);
```
{: codeblock}
{: java}

```javascript
import { CloudantV1 } from '@ibm-cloud/cloudant';

const service = CloudantV1.newInstance({});

const selector: CloudantV1.Selector = {
  deviceID: {'$eq': 'device-123456'},
  ts: {'$gte': '20181213'}
}
service.postPartitionFind({
  db: 'readings',
  partitionKey: 'bridge-9876',
  selector: selector
}).then(response => {
  console.log(response.result);
});
```
{: codeblock}
{: node}

```python
from ibmcloudant.cloudant_v1 import CloudantV1

service = CloudantV1.new_instance()

response = service.post_partition_find(
  db='readings',
  partition_key='bridge-9876',
  selector={
      'deviceID': {'$eq': 'device-123456'},
      'ts': {'$gte': '20181213'}
  }
).get_result()

print(response)
```
{: codeblock}
{: python}

```go
selector := map[string]interface{}{
"deviceID": map[string]string{
"$eq": "device-123456",
},
"ts": map[string]string{
"$gte": "20181213",
},
}

postPartitionFindOptions := service.NewPostPartitionFindOptions(
"readings",
"bridge-9876",
selector,
)

findResult, response, err := service.PostPartitionFind(postPartitionFindOptions)
if err != nil {
panic(err)
}

b, _ := json.MarshalIndent(findResult, "", "  ")
fmt.Println(string(b))
```
{: codeblock}
{: go}

The previous Go example requires the following import block:
{: go}

```go
import (
   "encoding/json"
   "fmt"
   "github.com/IBM/cloudant-go-sdk/cloudantv1"
)
```
{: codeblock}
{: go}

All Go examples require the `service` object to be initialized. For more information, see the API documentation's [Authentication section](/apidocs/cloudant?code=go#authentication-with-external-configuration) for examples.
{: go}
