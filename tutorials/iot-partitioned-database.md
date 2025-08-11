---

copyright:
  years: 2017, 2025
lastupdated: "2025-08-11"

keywords: database shards, non-partitioned databases, partition key, global query, partition query, create partition database, create partition query index  partition search, tutorials, cardinality, partitioned

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# Creating an IoT historian using partitioned databases
{: #creating-an-iot-historian-using-partitioned-databases}

Partitioned databases can be difficult to understand in the abstract. In this
document you will learn about a concrete use-case to learn how to apply concepts
needed to model data for partitioned databases.

We take the Internet of Things domain and look at using
{{site.data.keyword.cloudant_short_notm}} as a historian for device readings.
Say that the devices provide sensor readings on pieces of infrastructure like
roads or bridges.

Review the following assumptions:

- Hundreds or thousands of devices that report readings.
- Each device has a unique ID.
- Each piece of infrastructure has a unique ID.
- Devices aren't moved between pieces of infrastructure.
- Each device writes a reading to {{site.data.keyword.cloudant_short_notm}} every 10 seconds. Likely this reading is delivered by using a message bus to {{site.data.keyword.cloudant_short_notm}}.

For this use-case, we will use the device ID for the partition key, and the
reading timestamp for the remainder of the document ID:

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

## Creating the database
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

## Document structure
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

### Creating a global view index
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

Assuming the previous document in `./view.json`, this document is uploaded to the database by using the following command:

```sh
curl -X PUT "$SERVICE_URL/readings/_design/infrastructure-mapping" -H 'Content-Type: application/json' --data @view.json
```
{: codeblock}

For more language examples that show creating a global view, see the [Storing the view definition](/docs/Cloudant?topic=Cloudant-creating-views-mapreduce#storing-the-view-definition) guide, or [the Create or modify a design document section in API Docs](/apidocs/cloudant#putdesigndocument).

### Creating a partitioned {{site.data.keyword.cloudant_short_notm}} Query index
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

#### Uploading partitioned index by timestamp
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

#### Uploading partitioned index by device ID and timestamp
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

## Making queries
{: #making-queries}

Overall, you want to make four queries:

1. Readings for all time for a piece of infrastructure.
1. Readings for today for a piece of infrastructure.
1. Readings for all time for a specific device.
1. Readings for today for a specific device.

### Finding all readings for a piece of infrastructure
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

### Finding recent readings for a piece of infrastructure
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

### Finding the infrastructure ID for a device
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

### Querying for all results for a device
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

### Querying for recent results for a device
{: #querying-for-recent-results-for-a-device}

To get the results for a device, you issue a partition query for the device
within the `bridge-9876` partition. The selector is only slightly more
complicated, but still the same as an equivalent global query.

#### Query for recent results assuming today is 13 December 2018
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
