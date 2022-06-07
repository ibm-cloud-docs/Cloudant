---

copyright:
  years: 2015, 2022
lastupdated: "2022-06-06"

keywords: create database, database topology, multiple queries, work with databases, partition database, delete database, back up data, create database applications

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# Getting changes to documents in the database
{: #get-changes}

Sending a `GET` request to `https://$ACCOUNT.cloudant.com/$DATABASE/_changes`
returns a list of changes that were made to documents in the database,
including insertions,
updates,
and deletions.

When a `_changes` request is received,
one replica for each shard of the database is asked to provide a list of changes.
These responses are combined and returned to the original requesting client.

The `_changes` endpoint accepts several optional query arguments:

Argument       | Description | Supported values | Default 
----------------|-------------|------------------|---------
`conflicts`    | Can be set only if `include_docs` is `true`. Adds information about conflicts to each document. | Boolean | False 
`descending`   | Return the changes in sequential order. | Boolean | False 
`doc_ids`      | To be used only when `filter` is set to `_doc_ids`. Filters the feed so that only changes to the specified documents are sent. **Note**: The `doc_ids` parameter works only with versions of {{site.data.keyword.cloudant_short_notm}} that are compatible with CouchDB 2.0. For more information, see [`GET /`](/apidocs/cloudant#getserverinformation){: external} documentation. | A JSON array of document IDs | 
`feed`         | Type of feed required. For more information, see the [`feed` information](#the-feed-argument). | `"continuous"`, `"longpoll"`, `"normal"` | `"normal"`
`filter`       | Name of [filter function](/docs/Cloudant?topic=Cloudant-design-documents#filter-functions) to use to get updates. The filter is defined in a [design document](/docs/Cloudant?topic=Cloudant-design-documents#design-documents). | `string` | No filter.
`heartbeat`    | If no changes occurred during `feed=longpoll` or `feed=continuous`, an empty line is sent after this time in milliseconds. | Any positive number | No heartbeat 
`include_docs` | Include the document as part of the result. | Boolean | False 
`limit`        | Maximum number of rows to return. | Any non-negative number | None   
`seq_interval` | Specifies how frequently the `seq` value is included in the response. Set a higher value to increase the throughput of `_changes` and decrease the response size. **Note**: In non-continuous `_changes` mode, the `last_seq` value is always populated. | Any positive number | 1 
`since`        | Start the results from changes after the specified sequence identifier. For more information, see the [`since` information](#the-since-argument). | Sequence identifier or `now` | 0 
`style`        | Specifies how many revisions are returned in the changes array. The `main_only` style returns only the current "winning" revision. The `all_docs` style returns all leaf revisions, including conflicts and deleted former conflicts. | `main_only`, `all_docs` | `main_only` 
`timeout`      | Wait this number of milliseconds for data, then stop the response. If the `heartbeat` setting is also supplied, it takes precedence over the `timeout` setting. | Any positive number | 
{: caption="Table 14. Query arguments for _changes endpoint" caption-side="top"}

Using `include_docs=true` might have [performance implications](/docs/Cloudant?topic=Cloudant-using-views#multi-document-fetching).
{: important}

See the following example that uses HTTP to get a list of changes made to documents in a database:

```http
GET /$DATABASE/_changes HTTP/1.1
```
{: codeblock}

See the following example to get a list of changes made to documents in a database:

```sh
curl -H "Authorization: Bearer $API_BEARER_TOKEN" -X GET "$SERVICE_URL/orders/_changes?limit=1"
```
{: codeblock}
{: curl}

## Changes in a distributed database
{: #changes-in-a-distributed-database}

{{site.data.keyword.cloudant_short_notm}} databases are distributed.
They have shard and fault-tolerant characteristics.
These characteristics mean that the responses that are provided by the `_changes` request might be different
from the behavior you expect.

In particular,
if you ask for a list of changes `_since` a  sequence identifier,
you get the requested information in response.
But you might also get changes that were made before the change indicated by the sequence identifier.
The reason these extra changes are included,
along with the implications for applications,
is explained in the
[Replication guide](/docs/Cloudant?topic=Cloudant-replication-guide#how-does-replication-affect-the-list-of-changes-).

Any application that uses the `_changes` request must be able to process a list of changes correctly as shown in the following list:
-   A different order for the changes that are listed in the response, when compared with an earlier request for the same information.
-   Changes that occur before the change specified by the sequence identifier.


## The `feed` argument
{: #the-feed-argument}

The `feed` argument changes how {{site.data.keyword.cloudant_short_notm}} sends the response.
By default,
`_changes` reports all changes,
then the connection closes.
This behavior is the same as using the `feed=normal` argument.

If you set `feed=longpoll`,
requests sent to the server stay open until changes are reported.
This option helps when monitoring changes continuously.

If you set `feed=continuous`,
new changes are reported without closing the connection.
This option means that the database connection stays open until explicitly closed,
and that all changes are returned to the client as soon as possible after they occur.

Each line in the continuous response is either empty or a JSON object that represents a single change.
The option ensures that the following guidelines are met:
 
-   The format of the report entries reflects the continuous nature of the changes.
-   Validity of the JSON output is maintained.

See the following example (abbreviated) responses from a continuous changes feed:

```json
{
	"seq": "1-g1A...qyw",
	"id": "2documentation22d01513-c30f-417b-8c27-56b3c0de12ac",
	"changes": [
		{
			"rev": "1-967a00dff5e02add41819138abb3284d"
		}
	]
},
{
	"seq": "2-g1A...ssQ",
	"id": "1documentation22d01513-c30f-417b-8c27-56b3c0de12ac",
	"changes": [
		{
			"rev": "1-967a00dff5e02add41819138abb3284d"
		}
	]
},
{
	"seq": "3-g1A...qyy",
	"id": "1documentation22d01513-c30f-417b-8c27-56b3c0de12ac",
	"changes": [
		{
			"rev": "2-eec205a9d413992850a6e32678485900"
		}
	],
	"deleted": true
},
{
	"seq": "4-g1A...qyz",
	"id": "2documentation22d01513-c30f-417b-8c27-56b3c0de12ac",
	"changes": [
		{
			"rev": "2-eec205a9d413992850a6e32678485900"
		}
	],
	"deleted": true
}
```
{: codeblock}

## The `filter` argument
{: #the-filter-argument}

The `filter` argument designates a pre-defined
[filter function](/docs/Cloudant?topic=Cloudant-design-documents#predefined-filter-functions) to apply to the changes feed.
Additionally,
several built-in filters are available:

-   `_design` - The `_design` filter accepts only changes to design documents.
-   `_doc_ids` - This filter accepts only changes for documents whose ID is specified in the `doc_ids` parameter.

-   `_selector` - Returns changes for documents that match the `selector` request body parameter. The [selector syntax](/apidocs/cloudant#postfind){: external} is the same as the syntax that is used for [`_find`](/apidocs/cloudant#postexplain){: external}. If you want to use a selector filter, you must use the `POST` changes feed (as you can't supply a document body with a GET request). Use the `_selector` method of filtering instead of the `_view` filtering method because it's faster and easier to use.

	For more information, see the [API documentation](https://cloud.ibm.com/apidocs/cloudant#getchanges-changes-request).

-   `_view` - Enables use of an existing [map function](/docs/Cloudant?topic=Cloudant-creating-views-mapreduce#a-simple-view) as the filter.

## The `since` argument
{: #the-since-argument}

Use the `since` argument to get a list of changes that occurred after a specified sequence identifier.
If the `since` identifier is 0 (the default),
or omitted,
the request returns all changes.
If the `since` identifier is `now`,
the request asks for changes that are made after the current time.

The distributed nature of {{site.data.keyword.cloudant_short_notm}} can affect the results that you get in a response.
For example,
if you request a list of changes twice,
by using the same `since` sequence identifier both times,
the order of changes in the resulting list might not be the same.

You might also see some results that appear to be from before the `since` parameter.
The reason is that you might be getting results from a different replica of a shard (a shard replica).

Shard replicas automatically and continuously replicate to each other
and eventually have the same data.
However,
at any point in time,
a shard replica might differ from another shard replica
because the replication between them isn't yet complete.

When you request a list of changes,
normally the same replicas are used to respond.
But if the node that holds the shard replica isn't available,
the system substitutes a corresponding shard replica that is held on another node.
To help ensure that you see all the applicable changes,
the most recent checkpoint between the replicas is used.
Using the checkpoint is effectively "rolling back" the list of changes
to the most recent point in time when the shard replicas were confirmed to agree with each other.
This "rolling back" means you might see changes listed that took place "before" the `since` sequence identifier you supplied.

Your application must be able to handle a change that is reported
more than one time if you make a `_changes` request several times.

For more information about the behavior of the `_changes` response, see the
[replication guide](/docs/Cloudant?topic=Cloudant-replication-guide#how-does-replication-affect-the-list-of-changes-).

## Responses from the `_changes` request
{: #responses-from-the-changes-request}

The response from a `_changes` request is a JSON object that contains
a list of the changes that were made to documents within the database.
The following table describes the meaning of the individual fields:

Field      | Description | Type  
------------|-------------|-------
`changes`  | An array that lists the changes that were made to the specific document. | Array
`deleted`  | Boolean indicating whether the corresponding document was deleted. If present, it always has the value `true`. | Boolean
`id`       | Document identifier. | String
`last_seq` | Identifier of the last of the sequence identifiers. Currently, this identifier is the same as the sequence identifier of the last item in the `results`. | String
`results`  | Array of changes that were made to the database. | Array
`seq`      | Update sequence identifier. | String
{: caption="Table 15. JSON object response fields for _changes" caption-side="top"}

See the following example (abbreviated) response to a `_changes` request:

```json
{
	"results": [
		{
			"seq": "1-g1A...sIg",
			"id": "foo",
			"changes": [
				{
					"rev": "1-967...84d"
				}
			]
		}
	],
	"last_seq": "1-g1A...sIg",
	"pending": 0
}
```
{: codeblock}

## Important notes about `_changes`
{: #important-notes-about-changes}

-   The results that are returned by `_changes` are partially ordered.
   In other words, the order might not be preserved for multiple calls.
   You might decide to get a current list by using `_changes` and including the [`last_seq` value](#get-changes).
   The resulting list provides the starting point for subsequent `_changes` lists that use the `since` query argument.
-   Although shard copies of the same range contain the same data, their `_changes` history is often unique.
   This difference is a result of how writes were applied to the shard. For example, they might be applied in a different order.
   To be sure that all changes are reported for your specified sequence, it might be necessary to go further back into the shard's history to find a suitable starting point.
   The changes are then reported from that starting point.
   This "rolling back" might give the appearance of duplicate updates, or updates that are apparently before the specified `since` value.
-   `_changes` reported by a shard are always presented in order.
   But the ordering between all the contributing shards might appear to be different.
   For more information, see [A Changes Feed Example](https://gist.github.com/smithsz/30fb97662c549061e581){: external}.
-	Sequence values are unique for a shard, but might vary between shards.
   This variation means that, if you have sequence values from different shards, you can't assume that the same sequence value refers to the same document within the different shards.

## Using `POST` to get changes
{: #using-post-to-get-changes}

Instead of `GET`,
you can also use `POST` to query the changes feed.
The only difference, if you're using `POST` and you're using either of the `docs_ids` or `selector` filters,
is that it's possible to include the `"doc_ids" : [...]` or `"selector": {...}` parts in the request body.
All other parameters are expected to be in the query string,
the same as using `GET`.

See the following example that uses HTTP to `POST` to the `_changes` endpoint:

```http
POST /$DATABASE/_changes?filter=_selector HTTP/1.1
Host: $ACCOUNT.cloudant.com
Content-Type: application/json
```
{: codeblock}

See the following example to `POST` to the `_changes` endpoint:

```sh
curl -H "Authorization: Bearer $API_BEARER_TOKEN" -X POST "$SERVICE_URL/orders/_changes" -H "Content-Type: application/json"'
```
{: codeblock}
{: curl}

```java
import com.ibm.cloud.cloudant.v1.Cloudant;
import com.ibm.cloud.cloudant.v1.model.ChangesResult;
import com.ibm.cloud.cloudant.v1.model.PostChangesOptions;

Cloudant service = Cloudant.newInstance();

PostChangesOptions changesOptions = new PostChangesOptions.Builder()
    .db("orders")
    .build();

ChangesResult response =
    service.postChanges(changesOptions).execute()
        .getResult();

System.out.println(response);
```
{: codeblock}
{: java}

```javascript
import { CloudantV1 } from '@ibm-cloud/cloudant';

const service = CloudantV1.newInstance({});

service.postChanges({
  db: 'orders'
}).then(response => {
  console.log(response.result);
});
```
{: codeblock}
{: javascript}

```python
from ibmcloudant.cloudant_v1 import CloudantV1

service = CloudantV1.new_instance()
response = service.post_changes(
  db='orders'
).get_result()

print(response)
```
{: codeblock}
{: python}

```go
postChangesOptions := service.NewPostChangesOptions(
  "orders",
)

changesResult, response, err := service.PostChanges(postChangesOptions)
if err != nil {
  panic(err)
}

b, _ := json.MarshalIndent(changesResult, "", "  ")
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

All Go examples require the `service` object to be initialized. For more information, see the API documentation's [Authentication section](https://cloud.ibm.com/apidocs/cloudant?code=go#authentication-with-external-configuration) for examples. 
{: go}

When you `POST` to the `_changes` endpoint, you see an example similar to the following JSON object:

```json
{"results":[
{"seq":"1-g1AAAA...","id":"0007741142412418284","changes":[{"rev":"1-9d0c2676941ec3a3b3cc2f08fe9a51e0"}]},
{"seq":"2-g1AAAA...","id":"_design/applianceId","changes":[{"rev":"1-b1f67a8b672c1324680d6d7dc1e1fd3c"}]},
...
],
"last_seq":"18-g1AAAA...","pending":0}
```
{: codeblock}
