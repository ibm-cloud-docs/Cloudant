---

copyright:
  years: 2015, 2019
lastupdated: "2019-04-23"

keywords: create database, database topology, send multiple queries to a database, working with databases

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

<!-- Acrolinx: 2019 -->

# Databases
{: #databases}

{{site.data.keyword.cloudantfull}} databases contain JSON objects.
These JSON objects are called [documents](/docs/services/Cloudant?topic=cloudant-documents#documents).
All documents must be contained in a database.
{: shortdesc}

The [Grouping related documents together in {{site.data.keyword.cloudant_short_notm}}](/docs/services/Cloudant?topic=cloudant-grouping-related-documents-together-in-ibm-cloudant#grouping-related-documents-together-in-ibm-cloudant) guide provides an example of how documents for an e-commerce application might be used within an {{site.data.keyword.cloudant_short_notm}} database.

## Partitioned databases
{: #partitioned-databases-database}

{{site.data.keyword.cloudant_short_notm}} supports two types of databases:

-	Partitioned
-	Non-partitioned

A *partitioned* database offers significant query performance and cost advantages but requires you to specify a logical partitioning of your data. The partitioning is specified as part of each document's ID. A partitioned database allows performing both global and partition queries. Partition queries target queries at a single, given document partition, meaning they need to process less data to return results. Therefore, partition queries offer significant performance advantages, and will also often provide cost advantages over global queries. Global queries target the entire database leading to extra complexity, slower performance and increased cost -- but offer results drawing from all data.

Alternatively, a *non-partitioned* database might be created. This type of database can be easier to work with as no partitioning scheme needs to be defined, but only global secondary indexes can be created.

{{site.data.keyword.cloudant_short_notm}} strongly recommends that you use a partitioned database for best long-term database performance where the data model allows for logical partitioning of documents.

The partitioning type of a database is set at database creation time. When creating a database, use the `partitioned` query string parameter to set whether the database is partitioned. The default for `partitioned` is `false`, maintaining backwards compatibility.

The partitioning type cannot be changed for an existing database.

To create a database, submit a PUT request with the following format:

Method: PUT /$DATABASE?partitioned=$BOOLEAN
Request body: None
Response: Success or failure of operation.
Roles permitted: _admin


## Create
{: #create-database}

To create a database,
submit a `PUT` request with the following format:

-   **Method**: `PUT /$DATABASE?partitioned=$BOOLEAN`
-   **Request body**: None
-   **Response**: Success or failure of operation.
-   **Roles permitted**: `_admin`

### Query arguments
{: #query-arguments-database}

Argument         | Description | Optional | Type | Default | Supported values
-----------------|-------------|----------|------|---------|-----------------
`partitioned`      | Whether database is partitioned. | yes | Boolean | `false` | `true`, `false`

### Database naming

The database name must start with a lowercase letter,
and contain only the following characters:

-	Lowercase characters (a-z)
-	Digits (0-9)
-	Any of the characters _, $, (, ), +, -, and /

### Examples

_Using HTTP to create a partitioned database:_

```http
PUT /$DATABASE?partitioned=true HTTP/1.1
HOST: $ACCOUNT.cloudant.com
```
{: codeblock}

_Using HTTP to create a non-partitioned database:_

```http
PUT /$DATABASE?partitioned=false HTTP/1.1
HOST: $ACCOUNT.cloudant.com
```
{: codeblock}

_Using the command line to create a partitioned database:_

```sh
curl -X PUT 'https://$ACCOUNT.cloudant.com/$DATABASE?partitioned=true'
```
{: codeblock}

_Using the command line to create a non-partitioned database:_

```sh
curl -X PUT 'https://$ACCOUNT.cloudant.com/$DATABASE?partitioned=false'
```
{: codeblock}

If creation succeeds, you get a [201 or 202 response](/docs/services/Cloudant?topic=cloudant-http#http-status-codes).
An error response uses
the HTTP status code to indicate what went wrong.

Code | Description
-----|------------
201  | Database created successfully.
202  | The database was successfully created on some nodes, but the number of nodes is less than the write quorum.
400  | Invalid database name.
412  | Database already exists.

_Example response that is received after a database is created successfully:_

```http
HTTP/1.1 201 Created

{
    "ok": true
}
```
{: codeblock}

### Database topology
{: #database-topology}

It is possible to modify the configuration of a sharding topology for a
database on dedicated database clusters.
This modification can be done when the database is created.
However,
poor choices for configuration parameters can adversely affect database performance.

For more information about modifying database configuration
in a dedicated database environment,
contact {{site.data.keyword.cloudant_short_notm}} support.

It is not possible to modify the configuration that is used for databases
on multi-tenant clusters.
{: note}

## Getting database details 
{: #getting-database-details}

Sending a `GET` request to `https://$ACCOUNT.cloudant.com/$DATABASE`
returns details about the database,
such as how many documents it contains.

_Example of using HTTP to get database details:_

```http
GET /$DATABASE HTTP/1.1
```
{: codeblock}

_Example of using the command line to get database details:_

```sh
curl https://$ACCOUNT.cloudant.com/$DATABASE \
```
{: codeblock}

<!--

_Example of using JavaScript to get database details:_

```javascript
var nano = require('nano');
var account = nano("https://"+$ACCOUNT+":"+$PASSWORD+"@"+$ACCOUNT+".cloudant.com");

account.db.get($DATABASE, function (err, body, headers) {
	if (!err) {
		console.log(body);
	}
});
```
{: codeblock}

-->

The elements of the returned structure are shown in the following table:

Field                 | Description
----------------------|------------
`compact_running`     | Set to true if the database compaction routine is operating on this database.
`db_name`             | The name of the database.
`disk_format_version` | The version of the physical format that is used for the data when it is stored on disk.
`disk_size`           | Size in bytes of the data as stored on the disk. Views indexes are not included in the calculation.
`doc_count`           | A count of the documents in the specified database.
`doc_del_count`       | Number of deleted documents.
`instance_start_time` | Always 0.
`other`               | JSON object that contains a `data_size` field.
`purge_seq`           | The number of purge operations on the database.
`sizes`               | A JSON object, containing `file`, `external`, and `active` sizes. `active` is the size in bytes of data that are stored internally (excluding old revisions). `external` is the size in bytes of decompressed user data. This value is the billable data size. The `other/data_size` field is an alias for the `external` field. `file` is the size in bytes of data that are stored on the disk. Indexes are not included in the calculation. The `disk_size` field is an alias for the `file` field. This size includes data that are waiting for compaction.
`update_seq`          | An opaque string that describes the state of the database. Do not rely on this string for counting the number of updates.
`partitioned_indexes` | A JSON object that only appears if the database is partitioned. `count` is the number of partitioned indexes. `indexes` list the type of partitioned indexes, and `limit` shows the maximum number of allowed partitioned indexes.


_Example (abbreviated) response that contains database details:_

```json
{
	"update_seq": "982...uUQ",
	"db_name": "db",
	"sizes": {
		"file": 46114703224,
		"external": 193164408719,
		"active": 34961621142
	},
	"purge_seq": 0,
	"other": {
		"data_size": 193164408719
	},
	"doc_del_count": 5564,
	"doc_count": 9818541,
	"disk_size": 46114703224,
	"disk_format_version": 6,
	"compact_running": true,
	"instance_start_time": "0",
	"partitioned_indexes": {
		"count": 7,
		"indexes": {
			"search": 1,
			"view": 6
		},
		"limit": 10
	}
}
```
{: codeblock}

## Get a list of all databases in the account
{: #get-a-list-of-all-databases-in-the-account}

To list all the databases in an account,
send a `GET` request to `https://$ACCOUNT.cloudant.com/_all_dbs`.

_Example of using HTTP to list all databases:_

```http
GET /_all_dbs HTTP/1.1
```
{: codeblock}

_Example of using the command line to list all databases:_

```sh
curl https://$ACCOUNT.cloudant.com/_all_dbs \
```
{: codeblock}

<!--

_Example of using JavaScript to list all databases:_

```javascript
var nano = require('nano');
var account = nano("https://"+$ACCOUNT+":"+$PASSWORD+"@"+$ACCOUNT+".cloudant.com");

account.db.list(function (err, body, headers) {
  if (!err) {
    console.log(body);
  }
});
```
{: codeblock}

-->

The response is a JSON array with all the database names.

_Example response:_

```json
[
	"_users",
	"contacts",
	"docs",
	"invoices",
	"locations"
]
```
{: codeblock}

## Get documents
{: #get-documents}

To list all the documents in a database,
send a `GET` request to `https://$ACCOUNT.cloudant.com/$DATABASE/_all_docs`.

The `_all_docs` endpoint accepts the following query arguments:

Argument            | Description                                                                                     | Optional | Type            | Default
--------------------|-------------------------------------------------------------------------------------------------|----------|-----------------|--------
`conflicts`         | Can be set only if `include_docs` is `true`. Adds information about conflicts to each document. | yes      | boolean         | false
`deleted_conflicts` | Returns information about deleted conflicted revisions.                                         | yes      | boolean         | false
`descending`        | Return the documents in descending key order.                                                   | yes      | boolean         | false
`endkey`            | Stop returning records when the specified key is reached.                                       | yes      | string          |
`endkey_docid` | Stop returning records when the specified document ID is reached. If `endkey` is not set, this argument is ignored. | yes | string |
`include_docs`      | Include the full content of the documents in the return.                                        | yes      | boolean         | false
`inclusive_end`     | Include rows whose key equals the '`endkey`' value.                                             | yes      | boolean         | true
`key`               | Return only documents with IDs that match the specified key.                                    | yes      | string          |
`keys`              | Return only documents with IDs that match one of the specified keys.                            | yes      | list of strings |
`limit`             | Limit the number of returned documents to the specified number.                                 | yes      | numeric         |
`meta`              | Short-hand combination of all three arguments: `conflicts`, `deleted_conflicts`, and `revs_info`. Using `meta=true` is the same as using `conflicts=true&deleted_conflicts=true&revs_info=true`. | yes | boolean | false
`r`                 | Specify the [read quorum](/docs/services/Cloudant?topic=cloudant-documents#quorum-writing-and-reading-data) value.               | yes      | numeric         | 2
`revs_info`         | Includes detailed information for all known document revisions.                                 | yes      | boolean         | false
`skip`              | Skip this number of records before returning the results.                                       | yes      | numeric         | 0
`startkey`          | Return records, starting with the specified key.                                                | yes      | string          |
`startkey_docid` | Return records, starting with the specified document ID. If `startkey` is not set, this argument is ignored.  | yes | string |


Using `include_docs=true` might have [performance implications](/docs/services/Cloudant?topic=cloudant-using-views#multi-document-fetching).
{: important}

When you use the `keys` argument, it might be easier to send a `POST` request rather than a `GET` request if you require many strings to list the keys you want.
{: note}

_Example of using HTTP to list all documents in a database:_

```http
GET /_all_docs HTTP/1.1
```
{: codeblock}

_Example of using the command line to list all documents in a database,_

```sh
curl https://$ACCOUNT.cloudant.com/$DATABASE/_all_docs
```
{: codeblock}

<!--

_Example of using JavaScript to list all documents in a database:_

```javascript
var nano = require('nano');
var account = nano("https://"+$ACCOUNT+":"+$PASSWORD+"@"+$ACCOUNT+".cloudant.com");
var db = account.use($DATABASE);

db.list(function (err, body, headers) {
  if (!err) {
    console.log(body);
  }
});
```
{: codeblock}

-->

_Example of using HTTP to list all documents in a database that match at least one of the specified keys:_

```http
GET /_all_docs?keys=["somekey","someotherkey"] HTTP/1.1
```
{: codeblock}

_Example of using the command line to list all documents in a database that match at least one of the specified keys:_

```sh
curl https://$ACCOUNT.cloudant.com/$DATABASE/_all_docs?keys=["somekey","someotherkey"]
```
{: codeblock}

The response is a JSON object that contains all documents in the database that match the parameters.
The following table describes the meaning of the individual fields:

Field        | Description                                                                         | Type
-------------|-------------------------------------------------------------------------------------|-----
`offset`     | Offset where the document list started.                                             | numeric, null (The type can be `null` when `keys` are specified.)
`rows`       | Array of document objects.                                                          | array
`total_rows` | Number of documents in the database or view that match the parameters of the query. | numeric
`update_seq` | Current update sequence for the database.                                           | string

_Example response after a request for all documents in a database:_

```json
{
	"total_rows": 3,
	"offset": 0,
	"rows": [
		{
			"id": "5a049246-179f-42ad-87ac-8f080426c17c",
			"key": "5a049246-179f-42ad-87ac-8f080426c17c",
			"value": {
				"rev": "2-9d5401898196997853b5ac4163857a29"
			}
		},
		{
			"id": "96f898f0-f6ff-4a9b-aac4-503992f31b01",
			"key": "96f898f0-f6ff-4a9b-aac4-503992f31b01",
			"value": {
				"rev": "2-ff7b85665c4c297838963c80ecf481a3"
			}
		},
		{
			"id": "d1f61e66-7708-4da6-aa05-7cbc33b44b7e",
			"key": "d1f61e66-7708-4da6-aa05-7cbc33b44b7e",
			"value": {
				"rev": "2-cbdef49ef3ddc127eff86350844a6108"
			}
		}
	]
}
```
{: codeblock}

## Send multiple queries to a database
{: #send-multiple-queries-to-a-database}

This section describes how to send multiple queries to a database using `_all_docs` and `_view` endpoints. 

### Send multiple queries to a database by using `_all_docs`
{: #send-multiple-queries-to-a-database-by-using-_all_docs}

To send multiple queries to a specific database, send a `POST` request to 
`https://$ACCOUNT.cloudant.com/$DATABASE/_all_docs/queries`.

_Example of using HTTP to send multiple queries to a database:_

```http
POST /_all_docs/queries HTTP/1.1
```
{: codeblock}

_Example of using the command line to send multiple queries to a database,_

```sh
curl https://$ACCOUNT.cloudant.com/$DATABASE/_all_docs/queries
```
{: codeblock}

`POST`ing to the `_all_docs/queries` endpoint runs multiple specified built-in view queries of all documents 
in this database. This endpoint enables you to request multiple queries in a single request, instead 
of multiple `POST /$DATABASE/_all_docs` requests. 

The request JSON object must have a `queries` field. It represents an array of query 
objects with fields for the parameters of each individual view query to be run. 
The field names and their meaning are the same as the query parameters of a regular 
`_all_docs` request. 

The results are returned by using the following response JSON object:

Response JSON object    | Description | Type
------------------------|-------------|-----
`results` | An array of result objects - one for each query. Each result object contains the same fields as the response to a regular `_all_docs` request. | array


_Example request with multiple queries:_

```json
{POST /db/_all_docs/queries HTTP/1.1
Content-Type: application/json
Accept: application/json
Host: localhost:5984

{
    "queries": [
        {
            "keys": [
                "meatballs",
                "spaghetti"
            ]
        },
        {
            "limit": 3,
            "skip": 2
        }
    ]
}
```
{: codeblock}

_Example response for multiple queries:_
```json
HTTP/1.1 200 OK
Cache-Control: must-revalidate
Content-Type: application/json
Date: Wed, 20 Dec 2017 11:17:07 GMT
ETag: "1H8RGBCK3ABY6ACDM7ZSC30QK"
Server: CouchDB (Erlang/OTP)
Transfer-Encoding: chunked

{
    "results" : [
        {
            "rows": [
                {
                    "id": "SpaghettiWithMeatballs",
                    "key": "meatballs",
                    "value": 1
                },
                {
                    "id": "SpaghettiWithMeatballs",
                    "key": "spaghetti",
                    "value": 1
                },
                {
                    "id": "SpaghettiWithMeatballs",
                    "key": "tomato sauce",
                    "value": 1
                }
            ],
            "total_rows": 3
        },
        {
            "offset" : 2,
            "rows" : [
                {
                    "id" : "Adukiandorangecasserole-microwave",
                    "key" : "Aduki and orange casserole - microwave",
                    "value" : [
                        null,
                        "Aduki and orange casserole - microwave"
                    ]
                },
                {
                    "id" : "Aioli-garlicmayonnaise",
                    "key" : "Aioli - garlic mayonnaise",
                    "value" : [
                        null,
                        "Aioli - garlic mayonnaise"
                    ]
                },
                {
                    "id" : "Alabamapeanutchicken",
                    "key" : "Alabama peanut chicken",
                    "value" : [
                        null,
                        "Alabama peanut chicken"
                    ]
                }
            ],
            "total_rows" : 2667
        }
    ]
}
```
{: codeblock}

Multiple queries are also supported in `/$DATABASE/_local_docs/queries` and `/$DATABASE/_design_docs/queries`, which is similar to `/$DATABASE/_all_docs/queries`. 
{: note}

### Send multiple view queries to a database by using `_view`
{: #send-multiple-view-queries-to-a-database-by-using-_view}

To send multiple view queries to a specific database, send a `POST` request to 
`https://$ACCOUNT.cloudant.com/$DATABASE/_design/$DDOC/_view/$VIEW/queries`.

_Example of using HTTP to send multiple queries to a database:_

```http
POST /_view/$VIEW/queries HTTP/1.1
```
{: codeblock}

_Example of using the command line to send multiple view queries to a database,_

```sh
curl https://$ACCOUNT.cloudant.com/$DATABASE/_view/$VIEW/queries
```
{: codeblock}

Multiple queries are supported with the `_view` endpoint, 
`/$DATABASE/_design/$DDOC/_view/$VIEW/queries`.

The request JSON object must have a `queries` field. It represents an array of query 
objects with fields for the parameters of each individual view query to be executed. 
The field names and their meaning are the same as the query parameters of a regular 
`_view` request. 


## Get changes
{: #get-changes}

Sending a `GET` request to `https://$ACCOUNT.cloudant.com/$DATABASE/_changes`
returns a list of changes that were made to documents in the database,
including insertions,
updates,
and deletions.

When a `_changes` request is received,
one replica for each shard of the database is asked to provide a list of changes.
These responses are combined and returned to the original requesting client.

`_changes` accepts several optional query arguments:

Argument       | Description | Supported Values | Default 
---------------|-------------|------------------|---------
`conflicts`    | Can be set only if `include_docs` is `true`. Adds information about conflicts to each document. | boolean | false 
`descending`   | Return the changes in sequential order. | boolean | false | 
`doc_ids`      | To be used only when `filter` is set to `_doc_ids`. Filters the feed so that only changes to the specified documents are sent. **Note**: The `doc_ids` parameter works only with versions of {{site.data.keyword.cloudant_short_notm}} that are compatible with CouchDB 2.0. See [API: GET / documentation](/docs/services/Cloudant?topic=cloudant-advanced-api#-get-) for more information. | A JSON array of document IDs | |
`feed`         | Type of feed required. For details, see the [`feed` information](#the-feed-argument). | `"continuous"`, `"longpoll"`, `"normal"` | `"normal"`
`filter`       | Name of [filter function](/docs/services/Cloudant?topic=cloudant-design-documents#filter-functions) to use to get updates. The filter is defined in a [design document](/docs/services/Cloudant?topic=cloudant-design-documents#design-documents). | string | no filter
`heartbeat`    | If there were no changes during `feed=longpoll` or `feed=continuous`, an empty line is sent after this time in milliseconds. | any positive number | no heartbeat | 
`include_docs` | Include the document as part of the result. | boolean | false |
`limit`        | Maximum number of rows to return. | any non-negative number | none |  
`seq_interval` | Specifies how frequently the `seq` value is included in the response. Set a higher value to increase the throughput of `_changes` and decrease the response size. **Note**: In non-continuous `_changes` mode, the `last_seq` value is always populated. | any positive number | 1 | 
`since`        | Start the results from changes _after_ the specified sequence identifier. For details, see the [`since` information](#the-since-argument). | sequence identifier or `now` | 0 | 
`style`        | Specifies how many revisions are returned in the changes array. The `main_only` style returns only the current "winning" revision. The `all_docs` style returns all leaf revisions, including conflicts and deleted former conflicts. | `main_only`, `all_docs` | `main_only` | 
`timeout`      | Stop the response after waiting this number of milliseconds for data. If the `heartbeat` setting is also supplied, it takes precedence over the `timeout` setting. | any positive number | |

Using `include_docs=true` might have [performance implications](/docs/services/Cloudant?topic=cloudant-using-views#multi-document-fetching).
{: important}

_Example of using HTTP to get a list of changes made to documents in a database:_

```http
GET /$DATABASE/_changes HTTP/1.1
```
{: codeblock}

_Example of using the command line to get a list of changes made to documents in a database_

```sh
curl https://$ACCOUNT.cloudant.com/$DATABASE/_changes \
```
{: codeblock}

<!--

_Example of using JavaScript to get a list of changes made to documents in a database:_

```javascript
var nano = require('nano');
var account = nano("https://"+$ACCOUNT+":"+$PASSWORD+"@"+$ACCOUNT+".cloudant.com");

account.db.changes($DATABASE, function (err, body, headers) {
	if (!err) {
		console.log(body);
	}
});
```
{: codeblock}

-->

### Changes in a distributed database
{: #changes-in-a-distributed-database}

{{site.data.keyword.cloudant_short_notm}} databases are distributed.
They have shard and fault-tolerant characteristics.
These characteristics mean that the responses that are provided by the `_changes` request might be different
from the behavior you expect.

In particular,
if you ask for a list of changes `_since` a  sequence identifier,
you get the requested information in response.
_But_ you might also get changes that were made before the change indicated by the sequence identifier.
The reason these extra changes are included,
along with the implications for applications,
is explained in the
[replication guide](/docs/services/Cloudant?topic=cloudant-replication-guide#how-does-replication-affect-the-list-of-changes-).

<!-- Reset markdown parser -->

Any application that uses the `_changes` request *must* be able to process correctly a list of changes that might: 1. Have a different order for the changes that are listed in the response, when compared with an earlier request for the same information. 2. Include changes that are considered to be before the change specified by the sequence identifier.
{: tip}

### The `feed` argument
{: #the-feed-argument}

The `feed` argument changes how {{site.data.keyword.cloudant_short_notm}} sends the response.
By default,
`_changes` reports all changes,
then the connection closes.
This behavior is the same as using the `feed=normal` argument.

If you set `feed=longpoll`,
requests sent to the server remain open until changes are reported.
This option helps when monitoring changes continuously.

If you set `feed=continuous`,
new changes are reported without closing the connection.
This option means that the database connection stays open until explicitly closed,
and that all changes are returned to the client as soon as possible after they occur.

Each line in the continuous response is either empty or a JSON object that represents a single change.
The option ensures that:
 
-   The format of the report entries reflects the continuous nature of the changes.
-   Validity of the JSON output is maintained.

_Example (abbreviated) responses from a continuous changes feed:_

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

### The `filter` argument
{: #the-filter-argument}

The `filter` argument designates a pre-defined
[filter function](/docs/services/Cloudant?topic=cloudant-design-documents#filter-functions) to apply to the changes feed.
Additionally,
several built-in filters available:

*   `_design`: The `_design` filter accepts only changes to design documents.
*   `_doc_ids`: This filter accepts only changes for documents whose ID is specified in the `doc_ids` parameter.
    
   The `_docs_ids` parameter works only with versions of {{site.data.keyword.cloudant_short_notm}} that are compatible with CouchDB 2.0.
   {: note}

*   `_selector`: Accepts only changes for documents that match a specified selector,
    which is defined by using the same [selector syntax](/docs/services/Cloudant?topic=cloudant-design-documents#filter-functions) that is used
    for [`_find`](/docs/services/Cloudant?topic=cloudant-query#finding-documents-by-using-an-index).

   The `_selector` parameter works only with versions of {{site.data.keyword.cloudant_short_notm}} that are compatible with CouchDB 2.0.
   {: note}
	
*   `_view`: Enables use of an existing [map function](/docs/services/Cloudant?topic=cloudant-views-mapreduce#a-simple-view) as the filter.

### The `since` argument
{: #the-since-argument}

Use the `since` argument to get a list of changes that occurred _after_ a specified sequence identifier.
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

You might also see some results that appear to be from _before_ the `since` parameter.
The reason is that you might be getting results from a different replica of a shard (a shard replica).

Therefore,
shard replicas automatically and continuously replicate to each other
and eventually have the same data.
However,
at any point in time,
a shard replica might differ from another shard replica
because the replication between them is not yet complete.

When you request a list of changes,
normally the same replicas are used to respond.
But if the node that holds the shard replica is not available,
the system substitutes a corresponding shard replica that is held on another node.
To help ensure that you see all the applicable changes,
the most recent checkpoint between the replicas is used.
Using the checkpoint is effectively 'rolling back' the list of changes
to the most recent point in time when the shard replicas were confirmed to agree with each other.
This 'rolling back' means you might see changes listed that took place 'before' the `since` sequence identifier you supplied.

Your application must be able to deal with a change that is reported
more than one time if you make a `_changes` request several times.

More information about the behavior of the `_changes` response is
provided in the
[replication guide](/docs/services/Cloudant?topic=cloudant-replication-guide#how-does-replication-affect-the-list-of-changes-).

### Responses from the `_changes` request
{: #responses-from-the-_changes-request}

The response from a `_changes` request is a JSON object that contains
a list of the changes that were made to documents within the database.
The following table describes the meaning of the individual fields:

Field      | Description | Type
-----------|-------------|------
`changes`  | An array that lists the changes that were made to the specific document. | Array
`deleted`  | Boolean indicating whether the corresponding document was deleted. If present, it always has the value `true`. | Boolean
`id`       | Document identifier. | String
`last_seq` | Identifier of the last of the sequence identifiers. Currently, this identifier is the same as the sequence identifier of the last item in the `results`. | String
`results`  | Array of changes that were made to the database. | Array
`seq`      | Update sequence identifier. | String

_Example (abbreviated) response to a `_changes` request:_

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

### Important notes about `_changes`
{: #important-notes-about-_changes}

-	The results that are returned by `_changes` are partially ordered.
	In other words,
	the order might not be preserved for multiple calls.
	You might decide to get a current list by using `_changes` and including the [`last_seq` value](#get-changes).
	The resulting list provides the starting point for subsequent `_changes` lists that use the `since` query argument.
-	Although shard copies of the same range contain the same data,
	their `_changes` history is often unique.
	This difference is a result of how writes were applied to the shard. For example,
	they might be applied in a different order.
	To be sure that all changes are reported for your specified sequence,
	it might be necessary to go further back into the shard's history to find a suitable starting point.
	The changes are then reported from that starting point.
	This 'rolling back' might give the appearance of duplicate updates,
	or updates that are apparently before the specified `since` value.
-	`_changes` reported by a shard are always presented in order.
	But the ordering between all the contributing shards might appear to be different.
	For more information,
	see [A Changes Feed Example ![External link icon](../images/launch-glyph.svg "External link icon")](https://gist.github.com/smithsz/30fb97662c549061e581){: new_window}.
-	Sequence values are unique for a shard,
	but might vary between shards.
	This variation means that if you have sequence values from different shards,
	you cannot assume that the same sequence value refers to the same document within the different shards.

### Using `POST` to get changes
{: #using-post-to-get-changes}

Instead of `GET`,
you can also use `POST` to query the changes feed.
The only difference if you are using `POST` _and_ you are using either of the `docs_ids` or `selector` filters,
is that it is possible to include the `"doc_ids" : [...]` or `"selector": {...}` parts in the request body.
All other parameters are expected to be in the query string,
the same as using `GET`.

_Example of using HTTP to `POST` to the `_changes` endpoint:_

```http
POST /$DATABASE/_changes?filter=_selector HTTP/1.1
Host: $ACCOUNT.cloudant.com
Content-Type: application/json
```
{: codeblock}

_Example of using the command line to `POST` to the `_changes` endpoint:_

```sh
curl -X POST "https://$ACCOUNT.cloudant.com/$DATABASE/_changes?filter=_selector" -d @request.json
```
{: codeblock}

_Example of a JSON object `POST`ed to the `_changes` endpoint:_

```json
{
	"selector": {"z" : {"$gte" : 1}}
}
```
{: codeblock}

## Deleting a database
{: #deleting-a-database}

To delete a database and its contents,
send a `DELETE` request to `https://$ACCOUNT.cloudant.com/$DATABASE`.

No additional check is made to ensure that you really intended to delete the database ("Are you sure?").
{: note}

_Example of using HTTP to delete an {{site.data.keyword.cloudant_short_notm}} database:_

```http
DELETE /$DATABASE HTTP/1.1
Host: $ACCOUNT.cloudant.com
```
{: codeblock}

_Example of using the command line to delete an {{site.data.keyword.cloudant_short_notm}} database:_

```sh
curl https://$ACCOUNT.cloudant.com/$DATABASE \
	-X DELETE \
```
{: codeblock}

<!--

_Example of using JavaScript to delete an {{site.data.keyword.cloudant_short_notm}} database:_

```javascript
var nano = require('nano');
var account = nano("https://"+$ACCOUNT+":"+$PASSWORD+"@"+$ACCOUNT+".cloudant.com");

account.db.destroy($DATABASE, function (err, body, headers) {
	if (!err) {
		console.log(body);
	}
});
```
{: codeblock}

-->

If deletion succeeds, you get a [200 or 202 response](/docs/services/Cloudant?topic=cloudant-http#http-status-codes){: new_window}.
An error response uses the HTTP status code to indicate what went wrong.

Code | Description
-----|------------
200  | Database deleted successfully.
202  | Database was successfully deleted on some nodes, but the number of nodes is less than the write quorum.
404  | Database doesn't exist on all of the nodes.

_Example response that is received after a database is deleted successfully:_

```json
{
	"ok": true
}
```
{: codeblock}

## Backing up your data
{: #backing-up-your-data}

You must protect your data by taking good quality backups.
For more information, see an [overview](/docs/services/Cloudant?topic=cloudant-ibm-cloudant-backup-and-recovery#ibm-cloudant-backup-and-recovery) of backing up your data, and see even more details in the [Backup guide](/docs/services/Cloudant?topic=cloudant-replication-incrementals#replication-incrementals).

<!--
Removed for 96973.
## Using a different domain


Virtual hosts (vhosts) are a way to make {{site.data.keyword.cloudant_short_notm}} serve data from a different domain
than the one normally associated with your {{site.data.keyword.cloudant_short_notm}} account.

-->

## Creating database applications
{: #creating-database-applications}

In addition to data stored in documents within the database,
you might also have client-side application code in documents within the database.
The application code is typically written by using JavaScript.
Two-tier combinations of data and client code,
which is stored within a database,
are called [CouchApps](/docs/services/Cloudant?topic=cloudant-couchapps#couchapps).

For more information about CouchApps,
and to help you decide whether they are a good match for your application,
see [CouchApps](/docs/services/Cloudant?topic=cloudant-couchapps#couchapps).
