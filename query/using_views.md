---

copyright:
  years: 2015, 2022
lastupdated: "2022-12-15"

keywords: query a view, indexes, view freshness, combine parameters, sort returned rows, specify start and end keys, use keys to query view, multi-document fetching, send several queries to a view

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# Using Views
{: #using-views}

Use views to search for content within a database that matches specific criteria.
The criteria are specified within the view definition.
{: shortdesc}

Criteria can also be supplied as arguments when you use the view.

In this documentation, when a feature, or an aspect of a feature, applies only to Transaction Engine, you see this tag, ![TXE tag](../images/txe_icon.svg).
{: important}

## Querying a view
{: #querying-a-view}

To query a view,
submit a `GET` request with the following format:

Method
:  Issue a partition query by using the following command, `GET $SERVICE_URL/$DATABASE/_partition/$PARTITION_KEY/_design/$DDOC/_view/$VIEW_NAME`. Or issue a global query by using the following command, `GET $SERVICE_URL/$DATABASE/_design/$DDOC/_view/$VIEW_NAME`.

Request
:  None

Response
:  JSON of the documents that are returned by the view.

Roles permitted
:  `_reader`

The request runs either:

-   The specified `$VIEW_NAME` from the specified `$DDOC` design document
    within the `$DATABASE` database, which is constrained to results within the specified
    `$PARTITION_KEY` data
    partition.
-   The specified `$VIEW_NAME` from the specified `$DDOC` design document
    within the `$DATABASE` database.

The examples in this document vary between partition and global queries for
illustrative purposes. Unless otherwise noted, modifying the path to
embed or remove the partition name works for any view query type.

### Query and JSON Body Arguments
{: #query-arguments-using_views}

Global queries can use all query and JSON body arguments. Partition queries can use only the
subset that is indicated in the table.

| Argument         | Description | Optional | Type | Default | Supported values | Partition query |
|--------|------|------|----|-----|------|-------|
| `bookmark` ![TXE tag](../images/txe_icon.svg) | A bookmark to navigate to a specific page. | Yes | String | | | |
| `conflicts`      | Specify whether to include a list of conflicted revisions in the `_conflicts` property of the returned document. Ignored if `include_docs` isn't set to `true`. | Yes | Boolean | False | | Yes |
| `descending`     | Return the documents in `descending by key` order. | Yes | Boolean | False | | Yes |
| `end_key`         | Stop returning records when the specified key is reached. | Yes | String or JSON array | | | Yes |
| `end_key_docid`   | Stop returning records when the specified document ID is reached. | Yes | String | | | Yes |
| `group`          | Specify whether to group reduced results by key. Valid only if a reduce function is defined in the view. If the view emits keys in JSON array format, then it is possible to reduce groups further based on the number of array elements with the `group_level` parameter. | Yes | Boolean | False | | Yes |
| `group_level`    | Specify a group level to be used. Only applicable if the view uses keys that are JSON arrays. Implies group is `true`. Group level groups the reduced results by the specified number of array elements. If unset, results are grouped by the entire array key, returning a reduced value for each complete key. | Yes | Numeric | | | Yes |
| `include_docs`   | Include the full content of the documents in the response. | Yes | Boolean | False | | Yes |
| `inclusive_end`  | Include rows with the specified `end_key`. | Yes | Boolean | True | | Yes |
| `key` | Return only documents that match the specified key. Keys are JSON values, and must be URL encoded. | Yes | JSON array | | | Yes |
| `keys` | Specify to return only documents that match any of the specified keys. String representation of a JSON array of keys that match the key type that is emitted by the view function. | Yes | String or JSON array | | | Yes |
| `limit` | Limit the number of returned documents to the specified count. For Transaction Engine, the `limit` parameter restricts the total number of returned documents. | Yes | Numeric | | | Yes |
| `page_size` ![TXE tag](../images/txe_icon.svg) | Specify the number of returned documents in the result.  | Yes | Numeric | | | |
| `reduce`         | Use the `reduce` function. | Yes | Boolean | True | | Yes |
| `skip`           | Skip this number of rows from the start. | Yes | Numeric | 0 | | Yes |
| `stable`         | Specify whether to use the same replica of the index on each request. The default value `false` contacts all replicas and returns the result from the first, fastest responder. Setting it to `true`, when used with `update=false`, might improve consistency at the expense of increased latency and decreased throughput if the selected replica is not the fastest of the available replicas.   \n  \n **Note**: In general, setting this parameter to `true` is discouraged and not recommended when you use `update=true`. | Yes | Boolean | False | | No |
| `stale`          | **Note**: `stale` is deprecated. Use `stable` and `update` instead.   \n  \n Specify whether to use the results from a stale view without triggering a rebuild of all views within the encompassing design doc. \n - `ok` is equivalent to `stable=true&update=false`. \n - `update_after` is equivalent to `stable=true&update=lazy`. | Yes | String | False | | No |
| `start_key` | Return records, starting with the specified key. | Yes | String or JSON array |  |  | Yes |
| `start_key_docid` | Return records, starting with the specified document ID. | Yes | String | | | Yes |
| `update`        | Specify whether or not the view in question must be updated before you respond to the user.   \n - `true` - Return results after the view is updated.   \n - `false` - Return results without updating the view.   \n - `lazy` - Return the view results without waiting for an update, but update them immediately after the request. | Yes | String | True | | Yes |
{: caption="Table 1. Subset of query and JSON body arguments available for partitioned queries" caption-side="top"}

Using `include_docs=true` might have [performance implications](#multi-document-fetching).
{: important}

See the example of using HTTP to retrieve a list of the first 10 documents that include the full content of the documents from a partition of a database, applying a user-created view.

```http
GET $SERVICE_URL/$DATABASE/_partition/$PARTITION_KEY/_design/$DDOC/_view/$VIEW_NAME?include_docs=true&limit=10 HTTP/1.1
```
{: codeblock}

See the example of using HTTP to retrieve a list of the first 10 documents from a database,
applying a user-created view.

```http
GET $SERVICE_URL/$DATABASE/_design/$DDOC/_view/$VIEW_NAME?limit=10 HTTP/1.1
```
{: codeblock}

See the example to retrieve a list of the first 10 documents that include the full content of them from the `small-appliances` partition of a database, applying the user-created `byApplianceProdId` view.

Client libraries use `POST` method instead of `GET` because they have the same behavior.
{: tip}
{: java}
{: node}
{: python}
{: go}

```sh
curl -X GET "$SERVICE_URL/products/_partition/small-appliances/_design/appliances/_view/byApplianceProdId?include_docs=true&limit=10"
```
{: codeblock}
{: curl}

```java
import com.ibm.cloud.cloudant.v1.Cloudant;
import com.ibm.cloud.cloudant.v1.model.PostPartitionViewOptions;
import com.ibm.cloud.cloudant.v1.model.ViewResult;

Cloudant service = Cloudant.newInstance();

PostPartitionViewOptions viewOptions =
    new PostPartitionViewOptions.Builder()
        .db("products")
        .ddoc("appliances")
        .includeDocs(true)
        .limit(10)
        .partitionKey("small-appliances")
        .view("byApplianceProdId")
        .build();

ViewResult response =
    service.postPartitionView(viewOptions).execute()
        .getResult();

System.out.println(response);
```
{: codeblock}
{: java}

```javascript
const { CloudantV1 } = require('@ibm-cloud/cloudant');

const service = CloudantV1.newInstance({});

service.postPartitionView({
  db: 'products',
  ddoc: 'appliances',
  includeDocs: true,
  limit: 10,
  partitionKey: 'small-appliances',
  view: 'byApplianceProdId'
}).then(response => {
  console.log(response.result);
});
```
{: codeblock}
{: node}

```python
from ibmcloudant.cloudant_v1 import CloudantV1

service = CloudantV1.new_instance()

response = service.post_partition_view(
  db='products',
  ddoc='appliances',
  include_docs=True,
  limit=10,
  partition_key='small-appliances',
  view='byApplianceProdId'
).get_result()

print(response)
```
{: codeblock}
{: python}

```go
postPartitionViewOptions := service.NewPostPartitionViewOptions(
  "products",
  "small-appliances",
  "appliances",
  "byApplianceProdId",
)
postPartitionViewOptions.SetIncludeDocs(true)
postPartitionViewOptions.SetLimit(10)

viewResult, response, err := service.PostPartitionView(postPartitionViewOptions)
if err != nil {
  panic(err)
}

b, _ := json.MarshalIndent(viewResult, "", "  ")
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

See the example to retrieve a list of the first 10 documents from a database, applying the user-created `getVerifiedEmails` view.

Client libraries use `POST` method instead of `GET` because they have the same behavior.
{: tip}
{: java}
{: node}
{: python}
{: go}

```sh
curl -X GET "$SERVICE_URL/users/_design/allusers/_view/getVerifiedEmails?limit=10"
```
{: codeblock}
{: curl}

```java
import com.ibm.cloud.cloudant.v1.Cloudant;
import com.ibm.cloud.cloudant.v1.model.PostViewOptions;
import com.ibm.cloud.cloudant.v1.model.ViewResult;

Cloudant service = Cloudant.newInstance();

PostViewOptions viewOptions = new PostViewOptions.Builder()
    .db("users")
    .ddoc("allusers")
    .view("getVerifiedEmails")
    .limit(10)
    .build();

ViewResult response =
    service.postView(viewOptions).execute()
        .getResult();

System.out.println(response);
```
{: codeblock}
{: java}

```javascript
const { CloudantV1 } = require('@ibm-cloud/cloudant');

const service = CloudantV1.newInstance({});

service.postView({
  db: 'users',
  ddoc: 'allusers',
  view: 'getVerifiedEmails',
  limit: 10
}).then(response => {
  console.log(response.result);
});
```
{: codeblock}
{: node}

```python
from ibmcloudant.cloudant_v1 import CloudantV1

service = CloudantV1.new_instance()

response = service.post_view(
  db='users',
  ddoc='allusers',
  view='getVerifiedEmails',
  limit=10
).get_result()

print(response)
```
{: codeblock}
{: python}

```go
postViewOptions := service.NewPostViewOptions(
  "users",
  "allusers",
  "getVerifiedEmails",
)

postViewOptions.SetLimit(10)

viewResult, response, err := service.PostView(postViewOptions)
if err != nil {
  panic(err)
}

b, _ := json.MarshalIndent(viewResult, "", "  ")
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

See the following example response to the request:

```json
{
  "offset": 0,
  "rows": [
    {
      "id": "abc125",
      "key": "amelie.smith@aol.com",
      "value": [
        "Amelie Smith",
        true,
        "2020-04-24T10:42:59.000Z"
      ]
    },
    {
      "id": "abc123",
      "key": "bob.smith@aol.com",
      "value": [
        "Bob Smith",
        true,
        "2019-01-24T10:42:59.000Z"
      ]
    }
  ],
  "total_rows": 2
}
```
{: codeblock}

## Indexes
{: #indexes}

When a view is defined in a design document,
a corresponding index is also created,
based on the information defined within the view.
Use indexes to find documents by criteria other than their `_id` field.
For example,
you might select by a field,
or combination of fields,
or by a value that is computed by using the contents of the document.
The index is populated as soon as the design document is created.
On large databases,
this process might take a while.

If one of the following events occurs, the index content is updated incrementally and automatically:

-   A new document is added to the database.
-   An existing document is deleted from the database.
-   An existing document in the database is updated.

View indexes are rebuilt entirely when the view definition changes,
or when another view definition in the same design document changes.
The rebuild ensures that changes to the view definitions are reflected in the view indexes.
To ensure that the rebuild happens,
a 'fingerprint' of the view definition is created whenever the design document is updated.
If the fingerprint changes,
then the view indexes are rebuilt.

View index rebuilds occur when you change any one view from all the views that are defined in the design document. For example, if you have a design document with three views, and you update the design document, all three view indexes within the design document are rebuilt. If you want to change a design document for a larger database, have a look at the [Design document management guide](/docs/Cloudant?topic=Cloudant-design-document-management#managing-changes-to-a-design-document).
{: tip}

If the database was updated recently,
the results might be delayed when the view is accessed.
The delay is affected by the number of changes to the database,
and whether the view index isn't current because the database content was modified.

It isn't possible to eliminate these delays.
For newly created databases,
you might reduce the delays by creating the view definition in the design document in your database
before you insert or update documents.
Creating the view definition in the design document
causes incremental updates to the index when the documents are inserted.

If speed of response is more important than having up-to-date data,
an alternative is to allow users to access an old version of the view index. To allow access to an old version of the view index, use the `update` query string parameter when you make a view query.

If you want to save old index versions without incurring indexing processor usage, you can stop all indexes from building by setting `"autoupdate": {"indexes": false}`. Or you can stop views from auto-updating by adding one of the following options to a design document. You can stop all index types from indexing if you set `"autoupdate": false`. See the following examples.
{: tip}

```json
{
  "_id": "_design/lookup",
  "autoupdate": false,
  "views": {
    "view": {
      "map": "function(doc)..."
    }
  }
}
```
```json
{
  "_id": "_design/lookup",
  "autoupdate": {"views": false},
  "views": {
    "view": {
      "map": "function(doc)..."
    }
  }
}
```

## View freshness
{: #view-freshness}

By default, all index results reflect the current state of the
database. {{site.data.keyword.cloudant_short_notm}} builds its indexes
automatically and asynchronously in the background. This practice
usually means that the index is fully up to date when you query it. If
not, by default, {{site.data.keyword.cloudant_short_notm}} applies the
remaining updates at query time.

{{site.data.keyword.cloudant_short_notm}} provides a few parameters,
described next to alter this behavior. We recommend against using
them as the side-effects typically outweigh their benefit.

### Parameters
{: #parameters}

The `update` option indicates whether you're prepared to accept view
results without waiting for the view to be updated. The default value
is `true`, meaning that the view is updated before results are
returned. The `lazy` value means that the results are returned before
the view is updated, but that the view must then be updated anyway.

While {{site.data.keyword.cloudant_short_notm}} strives to
keep indexes updated in the background, no guarantee exists about how
out-of-date the view is when queried with `update=false` or
`update=lazy`.
{: important}

The `stable` option indicates whether you would prefer to get results
from a single, consistent set of shards. The `false` value means that
all available shard replicas are queried and
{{site.data.keyword.cloudant_short_notm}} uses the fastest
response. By contrast, setting
`stable=true` forces the database to use just one replica of the
index.

Using `stable=true` can cause high latency as it consults
only one of the copies of the index, even if the other copies would
respond faster.
{: important}


### Combining parameters
{: #combining-parameters}

If you specify `stable=false` and `update=false`, you see greater
inconsistency between results, even for the same query and without
making database changes. We recommend against this combination unless
you are sure that your system can tolerate this behavior.

## Sorting returned rows
{: #sorting-returned-rows}

The data that is returned by a view query is in the form of an array.
Each element within the array is sorted by using standard
[UTF-8](https://en.wikipedia.org/wiki/UTF-8){: external} sorting.
The sort is applied to the key defined in the view function.

The basic order of the output is shown in the following table:

| Value | Order |
|-------|------|
|`null` | First|
|`false` | |
| `true`  | |
| Numbers | |
| Text (lowercase) | |
| Text (uppercase) | |
| Arrays (according to the values of each element, by using the order given in this table) | |
| Objects (according to the values of keys, in key order by using the order given in this table) | Last |
{: caption="Table 2. Order of returned rows" caption-side="top"}

You can reverse the order of the returned view information by setting the `descending` query value `true`.

When you issue a view request that specifies the `keys` parameter, the results are returned in the same order as the supplied `keys` array.
{: tip}

See the example of using HTTP to request the records in reversed sort order:

```http
GET $SERVICE_URL/$DATABASE/_design/$DDOC/_view/$VIEW_NAME?descending=true HTTP/1.1
Accept: application/json
```
{: codeblock}

See the example of requesting the records in reverse sort order.

Client libraries use `POST` method instead of `GET` because they have a similar behavior.
{: tip}
{: java}
{: node}
{: python}
{: go}

```sh
curl -X GET "$SERVICE_URL/users/_design/allusers/_view/getVerifiedEmails?descending=true"
```
{: codeblock}
{: curl}

```java
import com.ibm.cloud.cloudant.v1.Cloudant;
import com.ibm.cloud.cloudant.v1.model.PostViewOptions;
import com.ibm.cloud.cloudant.v1.model.ViewResult;

Cloudant service = Cloudant.newInstance();

PostViewOptions viewOptions = new PostViewOptions.Builder()
    .db("users")
    .ddoc("allusers")
    .view("getVerifiedEmails")
    .descending(true)
    .build();

ViewResult response =
    service.postView(viewOptions).execute()
        .getResult();

System.out.println(response);
```
{: codeblock}
{: java}

```javascript
const { CloudantV1 } = require('@ibm-cloud/cloudant');

const service = CloudantV1.newInstance({});

service.postView({
  db: 'users',
  ddoc: 'allusers',
  view: 'getVerifiedEmails',
  descending: true
}).then(response => {
  console.log(response.result);
});
```
{: codeblock}
{: node}

```python
from ibmcloudant.cloudant_v1 import CloudantV1

service = CloudantV1.new_instance()

response = service.post_view(
  db='users',
  ddoc='allusers',
  view='getVerifiedEmails',
  descending=True
).get_result()

print(response)
```
{: codeblock}
{: python}

```go
postViewOptions := service.NewPostViewOptions(
  "users",
  "allusers",
  "getVerifiedEmails",
)

postViewOptions.SetDescending(true)

viewResult, response, err := service.PostView(postViewOptions)
if err != nil {
  panic(err)
}

b, _ := json.MarshalIndent(viewResult, "", "  ")
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

See the example response of requesting the records in reverse sort order:

```json
{
  "total_rows": 2,
  "offset": 0,
  "rows": [
    {
      "id": "abc123",
      "key": "bob.smith@aol.com",
      "value": [
        "Bob Smith",
        true,
        "2019-01-24T10:42:59.000Z"
      ]
    },
    {
      "id": "abc125",
      "key": "amelie.smith@aol.com",
      "value": [
        "Amelie Smith",
        true,
        "2020-04-24T10:42:59.000Z"
      ]
    }
  ]
}
```
{: codeblock}

## Specifying start and end keys
{: #specifying-start-and-end-keys}

The `start_key` and `end_key` query arguments can be used to specify the range of values
that are returned when querying the view.

The sort direction is always applied first.
Next, filtering is applied by using the `start_key` and `end_key` query arguments.
It is possible that no rows match your keyrange if sort and filter plans don't make sense when combined.

See the example of using HTTP to make a global query that includes `start_key` and `end_key`
query arguments:

```http
GET $SERVICE_URL/$DATABASE/_design/$DDOC/_view/$VIEW_NAME?start_key="alpha"&end_key="beta" HTTP/1.1
```
{: codeblock}

See the example of a global query that includes `start_key` and `end_key` query arguments.

Client libraries use `POST` method instead of `GET` because they have the same behavior.
{: tip}
{: java}
{: node}
{: python}
{: go}

```sh
curl -X GET "$SERVICE_URL/users/_design/allusers/_view/getVerifiedEmails?start_key=\"alpha\"&end_key=\"beta\""
```
{: codeblock}
{: curl}

```java
import com.ibm.cloud.cloudant.v1.Cloudant;
import com.ibm.cloud.cloudant.v1.model.PostViewOptions;
import com.ibm.cloud.cloudant.v1.model.ViewResult;

Cloudant service = Cloudant.newInstance();

PostViewOptions viewOptions = new PostViewOptions.Builder()
    .db("users")
    .ddoc("allusers")
    .view("getVerifiedEmails")
    .startKey("alpha")
    .endKey("beta")
    .build();

ViewResult response =
    service.postView(viewOptions).execute()
        .getResult();

System.out.println(response);
```
{: codeblock}
{: java}

```javascript
const { CloudantV1 } = require('@ibm-cloud/cloudant');

const service = CloudantV1.newInstance({});

service.postView({
  db: 'users',
  ddoc: 'allusers',
  view: 'getVerifiedEmails',
  startKey: 'alpha',
  endKey: 'beta'
}).then(response => {
  console.log(response.result);
});
```
{: codeblock}
{: node}

```python
from ibmcloudant.cloudant_v1 import CloudantV1

service = CloudantV1.new_instance()

response = service.post_view(
  db='users',
  ddoc='allusers',
  view='getVerifiedEmails',
  start_key='alpha',
  end_key='beta'  
).get_result()

print(response)
```
{: codeblock}
{: python}

```go
postViewOptions := service.NewPostViewOptions(
  "users",
  "allusers",
  "getVerifiedEmails",
)

postViewOptions.StartKey = "alpha"
postViewOptions.EndKey = "beta"

viewResult, response, err := service.PostView(postViewOptions)
if err != nil {
  panic(err)
}

b, _ := json.MarshalIndent(viewResult, "", "  ")
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

For example, if you have a database that returns one result when you use a `start_key` of `alpha`
and an `end_key` of `beta`, you would get a `400` (Bad request) error with a reversed order.
The reason is that the entries in the view are reversed before the key filter is applied.

See the example that uses HTTP to illustrate why reversing the order of `start_key` and `end_key`
might return a query parse error:

```http
GET $SERVICE_URL/$DATABASE/_design/$DDOC/_view/$VIEW_NAME?descending=true&start_key="alpha"&end_key="beta" HTTP/1.1
```
{: codeblock}

See the example illustrating why reversing the order of `start_key` and `end_key` might cause a `400` error.

Client libraries use `POST` method instead of `GET` because they have the same behavior.
{: tip}
{: java}
{: node}
{: python}
{: go}

```sh
curl -X GET "$SERVICE_URL/users/_design/allusers/_view/getVerifiedEmails?descending=true&start_key=\"alpha\"&end_key=\"beta\""
```
{: codeblock}
{: curl}

```java
import com.ibm.cloud.cloudant.v1.Cloudant;
import com.ibm.cloud.cloudant.v1.model.PostViewOptions;
import com.ibm.cloud.cloudant.v1.model.ViewResult;

Cloudant service = Cloudant.newInstance();

PostViewOptions viewOptions = new PostViewOptions.Builder()
    .db("users")
    .ddoc("allusers")
    .view("getVerifiedEmails")
    .descending(true)
    .startKey("alpha")
    .endKey("beta")
    .build();

ViewResult response =
    service.postView(viewOptions).execute()
        .getResult();

System.out.println(response);
```
{: codeblock}
{: java}

```javascript
const { CloudantV1 } = require('@ibm-cloud/cloudant');

const service = CloudantV1.newInstance({});

service.postView({
  db: 'users',
  ddoc: 'allusers',
  view: 'getVerifiedEmails',
  descending: true,
  startKey: 'alpha',
  endKey: 'beta'
}).then(response => {
  console.log(response.result);
});
```
{: codeblock}
{: node}

```python
from ibmcloudant.cloudant_v1 import CloudantV1

service = CloudantV1.new_instance()

response = service.post_view(
  db='users',
  ddoc='allusers',
  view='getVerifiedEmails',
  descending=True,  
  start_key='alpha',
  end_key='beta'  
).get_result()

print(response)
```
{: codeblock}
{: python}

```go
postViewOptions := service.NewPostViewOptions(
  "users",
  "allusers",
  "getVerifiedEmails",
)

postViewOptions.SetDescending(true)
postViewOptions.StartKey = "alpha"
postViewOptions.EndKey = "beta"

viewResult, response, err := service.PostView(postViewOptions)
if err != nil {
  panic(err)
}

b, _ := json.MarshalIndent(viewResult, "", "  ")
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


The `end_key` of `beta` is seen before the `start_key` of `alpha`, resulting in a query parse error.

The solution is to reverse not just the sort order,
but also the `start_key` and `end_key` parameter values.

The following example shows correct filtering and reversing the order of output,
by using the `descending` query argument,
and reversing the `start_key` and `end_key` query arguments.

See the example that uses HTTP to apply correct filtering and sorting to a global query:

```http
GET $SERVICE_URL/$DATABASE/_design/$DDOC/_view/$VIEW_NAME?descending=true&start_key="beta"&end_key="alpha" HTTP/1.1
```
{: codeblock}

See the example to apply correct filtering and sorting to a global query.

Client libraries use `POST` method instead of `GET` because they have the same behavior.
{: tip}
{: java}
{: node}
{: python}
{: go}

```sh
curl -X GET "$SERVER_URL/users/_design/allusers/_view/getVerifiedEmails?descending=true&start_key=\"beta\"&end_key=\"alpha\""
```
{: codeblock}
{: curl}

```java
import com.ibm.cloud.cloudant.v1.Cloudant;
import com.ibm.cloud.cloudant.v1.model.PostViewOptions;
import com.ibm.cloud.cloudant.v1.model.ViewResult;

Cloudant service = Cloudant.newInstance();

PostViewOptions viewOptions = new PostViewOptions.Builder()
    .db("users")
    .ddoc("allusers")
    .view("getVerifiedEmails")
    .descending(true)
    .startKey("beta")
    .endKey("alpha")
    .build();

ViewResult response =
    service.postView(viewOptions).execute()
        .getResult();

System.out.println(response);
```
{: codeblock}
{: java}

```javascript
const { CloudantV1 } = require('@ibm-cloud/cloudant');

const service = CloudantV1.newInstance({});

service.postView({
  db: 'users',
  ddoc: 'allusers',
  view: 'getVerifiedEmails',
  descending: true,
  startKey: 'beta',
  endKey: 'alpha'
}).then(response => {
  console.log(response.result);
});
```
{: codeblock}
{: node}

```python
from ibmcloudant.cloudant_v1 import CloudantV1

service = CloudantV1.new_instance()

response = service.post_view(
  db='users',
  ddoc='allusers',
  view='getVerifiedEmails',
  descending=True,  
  start_key='beta',
  end_key='alpha'  
).get_result()

print(response)
```
{: codeblock}
{: python}

```go
postViewOptions := service.NewPostViewOptions(
  "users",
  "allusers",
  "getVerifiedEmails",
)

postViewOptions.SetDescending(true)
postViewOptions.StartKey = "beta"
postViewOptions.EndKey = "alpha"

viewResult, response, err := service.PostView(postViewOptions)
if err != nil {
  panic(err)
}

b, _ := json.MarshalIndent(viewResult, "", "  ")
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

## Querying a view by using a list of keys
{: #querying-a-view-by-using-a-list-of-keys}

You can also run a query by providing a list of keys to use.

Requesting information from a database in this way uses
the specified `$VIEW_NAME` from the specified `$DDOC` design document.
Like the `keys` parameter for the [`GET`](#querying-a-view) method,
you can use the `POST` method to specify the keys to use to retrieve the view results.
In all other aspects,
the `POST` method is the same as the [`GET`](#querying-a-view) API request.
In particular,
you can use any of its query parameters in either the query string or the JSON body.

See the example HTTP request that returns all users, where the key for the view matches either `amelie.smith@aol.com` or `bob.smith@aol.com`:

```http
POST $SERVICE_URL/$DATABASE/_design/$DDOC/_view/$VIEW_NAME HTTP/1.1
Content-Type: application/json

{
  "keys": [
    "amelie.smith@aol.com",
    "bob.smith@aol.com"
  ]
}
```
{: codeblock}

See the example of a global query that returns all users (where the key for the view matches is
either `amelie.smith@aol.com` or `bob.smith@aol.com`):

```sh
curl -X POST "$SERVICE_URL/users/_design/allusers/_view/getVerifiedEmails" -H "Content-Type: application/json" --data '{
  "keys": [
    "amelie.smith@aol.com",
    "bob.smith@aol.com"
  ]
}'
```
{: codeblock}
{: curl}

```java
import com.ibm.cloud.cloudant.v1.Cloudant;
import com.ibm.cloud.cloudant.v1.model.PostViewOptions;
import com.ibm.cloud.cloudant.v1.model.ViewResult;

import java.util.Arrays;

Cloudant service = Cloudant.newInstance();

PostViewOptions viewOptions = new PostViewOptions.Builder()
    .db("users")
    .ddoc("allusers")
    .view("getVerifiedEmails")
    .keys(Arrays.asList("amelie.smith@aol.com", "bob.smith@aol.com"))
    .build();

ViewResult response =
    service.postView(viewOptions).execute()
        .getResult();

System.out.println(response);
```
{: codeblock}
{: java}

```javascript
const { CloudantV1 } = require('@ibm-cloud/cloudant');

const service = CloudantV1.newInstance({});

service.postView({
  db: 'users',
  ddoc: 'allusers',
  view: 'getVerifiedEmails',
  keys: ['amelie.smith@aol.com', 'bob.smith@aol.com']
}).then(response => {
  console.log(response.result);
});
```
{: codeblock}
{: node}

```python
from ibmcloudant.cloudant_v1 import CloudantV1

service = CloudantV1.new_instance()

response = service.post_view(
  db='users',
  ddoc='allusers',
  view='getVerifiedEmails',
  keys=['amelie.smith@aol.com', 'bob.smith@aol.com']
).get_result()

print(response)
```
{: codeblock}
{: python}

```go
postViewOptions := service.NewPostViewOptions(
  "users",
  "allusers",
  "getVerifiedEmails",
)

keys := []interface{}{"amelie.smith@aol.com", "bob.smith@aol.com"}
postViewOptions.SetKeys(keys)

viewResult, response, err := service.PostView(postViewOptions)
if err != nil {
  panic(err)
}

b, _ := json.MarshalIndent(viewResult, "", "  ")
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

The response contains the standard view information,
but only documents where the keys match.

See the example response after you run a query by using a list of keys:

```json
{
  "total_rows": 2,
  "offset": 0,
  "rows": [
    {
      "id": "abc125",
      "key": "amelie.smith@aol.com",
      "value": [
        "Amelie Smith",
        true,
        "2020-04-24T10:42:59.000Z"
      ]
    },
    {
      "id": "abc123",
      "key": "bob.smith@aol.com",
      "value": [
        "Bob Smith",
        true,
        "2019-01-24T10:42:59.000Z"
      ]
    }
  ]
}
```
{: codeblock}

## Multi-document fetching
{: #multi-document-fetching}

The following section covers a `POST` request to many documents from a database.

For a client application, this technique is more efficient than using multiple [`GET`](#querying-a-view) API requests.

However, `include_docs=true` might require extra processing time when compared to accessing the view on its own.

The reason is that by using `include_docs=true` in a view query, all of the result documents must be retrieved to construct the response for the client application. In effect, a whole series of document `GET` requests are run, each of which competes for resources with other application requests.

One way to mitigate this effect is by retrieving results directly from the view index file. Omit `include_docs=true` to retrieve results directly from the view index file. Instead, in the map function in a design document, emit the fields that are required as the value for the view index.

For example, in your map function, you might use the following design specification:

```javascript
function(user) {
  if(user.email_verified === true) {
    emit(user.email, {name: user.name, email_verified: user.email_verified, joined: user.joined});
  }
}
```

See the example request that uses HTTP to obtain the full content of documents that match the listed keys within a partition:

```http
POST $SERVICE_URL/$DATABASE/_partition/$PARTITION_KEY/_design/$DDOC/_view/$VIEW_NAME HTTP/1.1
Content-Type: application/json

{
  "include_docs": true,
  "keys" : [
    "1000043",
    "1000044"
  ]
}
```
{: codeblock}

See the example request to obtain the full content of documents that match the listed keys within the `products` partition:

```sh
curl -X POST "$SERVICE_URL/products/_partition/small-appliances/_design/appliances/_view
/byApplianceProdId" -H "Content-Type: application/json" --data '{
  "include_docs": true,
  "keys" : [
    "1000043",
    "1000044"
  ]
}'
```
{: codeblock}
{: curl}

```java
import com.ibm.cloud.cloudant.v1.Cloudant;
import com.ibm.cloud.cloudant.v1.model.PostPartitionViewOptions;
import com.ibm.cloud.cloudant.v1.model.ViewResult;

import java.util.Arrays;

Cloudant service = Cloudant.newInstance();

PostPartitionViewOptions viewOptions =
    new PostPartitionViewOptions.Builder()
        .db("products")
        .ddoc("appliances")
        .keys(Arrays.asList("1000043", "1000044"))
        .includeDocs(true)
        .partitionKey("small-appliances")
        .view("byApplianceProdId")
        .build();

ViewResult response =
    service.postPartitionView(viewOptions).execute()
        .getResult();

System.out.println(response);
```
{: codeblock}
{: java}

```javascript
const { CloudantV1 } = require('@ibm-cloud/cloudant');

const service = CloudantV1.newInstance({});

service.postPartitionView({
  db: 'products',
  ddoc: 'appliances',
  keys: ['1000043', '1000044'],
  includeDocs: true,
  partitionKey: 'small-appliances',
  view: 'byApplianceProdId'
}).then(response => {
  console.log(response.result);
});
```
{: codeblock}
{: node}

```python
from ibmcloudant.cloudant_v1 import CloudantV1

service = CloudantV1.new_instance()

response = service.post_partition_view(
  db='products',
  ddoc='appliances',
  keys=['1000043', '1000044'],
  include_docs=True,  
  partition_key='small-appliances',
  view='byApplianceProdId'
).get_result()

print(response)
```
{: codeblock}
{: python}

```go
postPartitionViewOptions := service.NewPostPartitionViewOptions(
  "products",
  "small-appliances",
  "appliances",
  "byApplianceProdId",
)

keys := []interface{}{"1000043", "1000044"}
postPartitionViewOptions.SetKeys(keys)
postPartitionViewOptions.SetIncludeDocs(true)

viewResult, response, err := service.PostPartitionView(postPartitionViewOptions)
if err != nil {
  panic(err)
}

b, _ := json.MarshalIndent(viewResult, "", "  ")
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

See the example (abbreviated) response, returning the full document for each appliance that matches a provided key:

```json
{
  "total_rows": 4,
  "offset": 1,
  "rows": [
    {
      "id": "small-appliances:1000043",
      "key": "1000043",
      "value": [
        "Bar",
        "Pro",
        "A professional, high powered innovative tool with a sleek design and outstanding performance"
      ],
      "doc": {
        "_id": "small-appliances:1000043",
        "_rev": "2-b595c929aabc3ab13415cd0cc03e665d",
        "type": "product",
        "taxonomy": [
          "Home",
          "Kitchen",
          "Small Appliances"
        ],
        "keywords": [
          "Bar",
          "Blender",
          "Kitchen"
        ],
        "productId": "1000043",
        "brand": "Bar",
        "name": "Pro",
        "description": "A professional, high powered innovative tool with a sleek design and outstanding performance",
        "colours": [
          "black"
        ],
        "price": 99.99,
        "image": "assets/img/barpro.jpg"
      }
    },
    {
      "id": "small-appliances:1000044",
      "key": "1000044",
      "value": [
        "Baz",
        "Omelet Maker",
        "Easily make delicious and fluffy omelets without flipping - Innovative design - Cooking and cleaning is easy"
      ],
      "doc": {
        "_id": "small-appliances:1000044",
        "_rev": "2-d54d022a9407ab9f06b1889cb2ab8a6e",
        "type": "product",
        "taxonomy": [
          "Home",
          "Kitchen",
          "Small Appliances"
        ],
        "keywords": [
          "Baz",
          "Maker",
          "Kitchen"
        ],
        "productId": "1000044",
        "brand": "Baz",
        "name": "Omelet Maker",
        "description": "Easily make delicious and fluffy omelets without flipping - Innovative design - Cooking and cleaning is easy",
        "colours": [
          "black"
        ],
        "price": 29.99,
        "image": "assets/img/bazomeletmaker.jpg"
      }
    }
  ]
}
```
{: codeblock}
