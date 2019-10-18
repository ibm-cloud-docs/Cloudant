---

copyright:
  years: 2015, 2019
lastupdated: "2019-10-17"

keywords: advanced endpoints, cluster information, revision history, GET /, _db_updates, $DATABASE/_shards, $DATABASE/_missing_revs, $DATABASE/_revs_diff, _membership, _uuids

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
{:external: target="_blank" .external}

<!-- Acrolinx: 2019-09-06 -->

# Advanced
{: #advanced-api}

These endpoints provide information about the state of the cluster,
details about revision history,
and other miscellaneous tasks.
{: shortdesc}

## `GET /`
{: #-get-}

Name | Description
-----|-------------
Method | `GET`
Path | `/`
Response | Welcome message and version

Accessing the root endpoint `/` returns meta information about the cluster.
The response is a JSON object that includes a welcome message and the version of the server.
The `version` field contains the CouchDB version the server is compatible with.
The `vendor.version` field contains the build number of {{site.data.keyword.cloudantfull}}'s CouchDB implementation.

For {{site.data.keyword.cloudant_short_notm}} versions before 2.0.0, you might see a `cloudant_build` field in the response, rather than a `vendor.version` field. In each case, the field contains the build number of {{site.data.keyword.cloudant_short_notm}}'s CouchDB implementation.
{: note}

See the following example request to get server meta information by using HTTP:

```HTTP
GET / HTTP/1.1
HOST: $ACCOUNT.cloudant.com
```
{: codeblock}

See the following example request to get server meta information by using the command line:

```sh
curl "https://$ACCOUNT.cloudant.com/"
```
{: codeblock}

<!--

See the following example request to get server meta information by using Javascript:

```javascript
var nano = require('nano');
var account = nano('https://$ACCOUNT:$PASSWORD@$ACCOUNT.cloudant.com');
account.request({
	path: '/'
}, function (err, body) {
	if (!err) {
		console.log(body);
	}
});
```
{: codeblock}

-->

See the following example JSON response for {{site.data.keyword.cloudant_short_notm}} version 2.0.0:

```json
{
	"couchdb": "Welcome",
	"version": "2.0.0",
	"vendor": {
		"name": "IBM Cloudant",
		"version": "5638",
		"variant": "paas"
	},
	"features": [
		"geo"
	]
}
```
{: codeblock}

See the following example JSON response for an older {{site.data.keyword.cloudant_short_notm}} version 1.0.2:

```json
{
	"couchdb": "Welcome",
	"version": "1.0.2",
	"cloudant_build": "2660"
}
```
{: codeblock}

## `GET /_db_updates`
{: #-get-_db_updates-}

This endpoint is only available to customers with dedicated system accounts.
{: note}

The `/_db_updates` endpoint returns a list of changes to databases,
similar to a global [changes feed](/docs/services/Cloudant?topic=cloudant-databases#get-changes).
Changes can be either updates to an existing database,
creation of a new database,
or deletion of a database.
Like the changes feed,
the `/_db_updates` endpoint isn't guaranteed to return changes in the correct order,
and might include changes more than once.
Polling modes for this endpoint work like the polling modes for the changes feed.


Argument | Description | Optional | Type | Default | Supported Values
---------|-------------|----------|------|---------|-----------------
descending | Determines that results are returned in descending order, in other words the most recent event appears first. By default, the oldest event is returned first. | yes | boolean | false | 
feed | Type of feed | yes | string | normal | `continuous`: Continuous (non-polling) mode, `longpoll`: Long polling mode, `normal`: default polling mode
heartbeat | Time in milliseconds after which an empty line is sent during longpoll or continuous if no changes occurred | yes | numeric | 60000 | 
limit | Maximum number of results to return | yes | numeric | none |  
since | Start the results from changes immediately after the specified sequence number. If since is 0 (the default), the request returns all changes since the feature was activated. | yes | string | 0 | 
timeout | Number of milliseconds to wait for data in a `longpoll` or `continuous` feed before the response is terminated. If both `heartbeat` and `timeout` are suppled, `heartbeat` supersedes `timeout`. | yes | numeric |  | 

See the following example request to get a list of changes to the database by using HTTP:

```HTTP
GET /_db_updates HTTP/1.1
```
{: codeblock}

See the following example request to get a list of changes to the database by using the command line:

```sh
curl "https://$ACCOUNT.cloudant.com/_db_updates" \
	-u $ACCOUNT
```
{: codeblock}

<!--

See the following example request to get a list of changes to the database by using Javascript:

```javascript
var nano = require('nano');
var account = nano('https://$ACCOUNT:$PASSWORD@$ACCOUNT.cloudant.com');
account.request({
	path: '_db_updates'
}, function (err, body) {
	if (!err) {
		console.log(body);
	}
});
```
{: codeblock}

-->

See the following example response with database information:

```json
{
	"results": [{
		"dbname": "$DATABASE_NAME",
		"type": "created",
		"account": "$ACCOUNT",
		"seq": "673-g1AAAAJAeJyN0Et..."
	}],
	"last_seq": "673-g1AAAAJAeJyN0Et..."
}
```
{: codeblock}

## `GET /$DATABASE/_shards`
{: #-get-database-_shards-}

The `/$DATABASE/_shards` endpoint returns information about the shards in the cluster,
specifically what nodes contain what hash ranges.

The `shards` field in the response contains an object with keys that are the hash value range for each shard.
Each value is the array of nodes that contain a copy of that shard.

See the following example request by using HTTP:

```HTTP
GET /$DATABASE/_shards HTTP/1.1
```
{: codeblock}

See the following example request by using the command line:

```sh
curl "https://$ACCOUNT.cloudant.com/$DATABASE/_shards" \
	-u $ACCOUNT
```
{: codeblock}

<!--

See the following example request by using Javascript:

```javascript
var nano = require('nano');
var account = nano('https://$ACCOUNT:$PASSWORD@$ACCOUNT.cloudant.com');
account.request({
	database: $DATABASE,
	path: '_shards'
}, function (err, body) {
	if (!err) {
		console.log(body);
	}
});
```
{: codeblock}

-->

See the following example response about the shards:

```json
{
	"shards": {
		"00000000-3fffffff": [
			"dbcore@db1.mead.cloudant.net",
			"dbcore@db2.mead.cloudant.net",
			"dbcore@db3.mead.cloudant.net"
		],
		"40000000-7fffffff": [
			"dbcore@db1.mead.cloudant.net",
			"dbcore@db2.mead.cloudant.net",
			"dbcore@db3.mead.cloudant.net"
		],
		"80000000-bfffffff": [
			"dbcore@db1.mead.cloudant.net",
			"dbcore@db2.mead.cloudant.net",
			"dbcore@db3.mead.cloudant.net"
		],
		"c0000000-ffffffff": [
			"dbcore@db1.mead.cloudant.net",
			"dbcore@db2.mead.cloudant.net",
			"dbcore@db3.mead.cloudant.net"
		]
	}
}
```
{: codeblock}

## `GET /$DATABASE/_missing_revs`
{: #-get-database_missing_revs-}

When supplied with a list of document revisions, 
the `/$DATABASE/_missing_revs` endpoint returns a list of the document revisions that don't exist in the database.

The list of document revisions is supplied in a JSON document,
similar to the following example:

```json
{
	"$DOCUMENT_ID": [
		"$REV_1",
		"$REV_2"
	]
}
```
{: codeblock}

See the following example request by using HTTP:

```HTTP
GET /$DATABASE/_missing_revs HTTP/1.1
Content-Type: application/json
```
{: codeblock}

See the following example request by using the command line:

```sh
curl "https://$ACCOUNT.cloudant.com/$DATABASE/_missing_revs" \
	 -X POST \
	 -u $ACCOUNT \
	 -H "Content-Type: application/json" \
	 -d @request-body.json
```
{: codeblock}

<!--

See the following example request by using Javascript:

```javascript
var nano = require('nano');
var account = nano('https://$ACCOUNT:$PASSWORD@$ACCOUNT.cloudant.com');
account.request({
	database: $DATABASE,
	path: '_missing_revs',
	method: 'POST',
	body: '$JSON'
},
function (err, body) {
	if (!err) {
		console.log(body);
	}
});
```
{: codeblock}

-->

See the following example response with document revisions:

```json
{
	"missed_revs":{
		"$DOCUMENT_ID": [
			"$REV_1"
		]
	}
}
```
{: codeblock}

## `POST /$DATABASE/_revs_diff`
{: #-post-database-_revs_diff-}

When supplied with a set of document revision IDs, 
the `/$DATABASE/_revs_diff` endpoint returns a subset of those document revision IDs that don't correspond to revisions stored in the database.

The list of document revision IDs is supplied in a JSON document,
similar to the following example:

```json
{
	"190f721ca3411be7aa9477db5f948bbb": [
		"3-bb72a7682290f94a985f7afac8b27137",
		"4-10265e5a26d807a3cfa459cf1a82ef2e",
		"5-067a00dff5e02add41819138abb3284d"
	]
}
```
{: codeblock}

See the following example request for document revision IDs by using HTTP:

```HTTP
POST /$DATABASE/_revs_diff HTTP/1.1
Content-Type: application/json
```
{: codeblock}

See the following example request for document revision IDs from the command line:

```sh
curl "https://$ACCOUNT.cloudant.com/$DATABASE/_revs_diff" \
	-X POST \
	-u $ACCOUNT \
	-d "$JSON"
```
{: codeblock}

<!--

See the following example request by using Javascript:

```javascript
var nano = require('nano');
var account = nano('https://$ACCOUNT:$PASSWORD@$ACCOUNT.cloudant.com');
account.request({
	database: $DATABASE,
	path: '_revs_diff',
	method: 'POST',
	body: '$JSON'
}, function (err, body) {
	if (!err) {
		console.log(body);
	}
});
```
{: codeblock}

-->

See the following example response with document revision IDs:

```json
{
	"190f721ca3411be7aa9477db5f948bbb": {
		"missing": [
			"3-bb72a7682290f94a985f7afac8b27137",
			"5-067a00dff5e02add41819138abb3284d"
		],
		"possible_ancestors": [
			"4-10265e5a26d807a3cfa459cf1a82ef2e"
		]
	}
}
```
{: codeblock}

### Response structure
{: #response-structure-_revs_diff}

Field name      | Description
----------------|------------------------------------------------------------------
`cluster_nodes` | Array of node names (strings) of the active nodes in the cluster.
`all_nodes`     | Array of nodes names (strings) of all nodes in the cluster.

See the following example response with node names in the cluster:

```json
{
	"cluster_nodes": [
		"dbcore@db1.testy004.cloudant.net",
		"dbcore@db2.testy004.cloudant.net",
		"dbcore@db3.testy004.cloudant.net"
	],
	"all_nodes": [
		"dbcore@db1.testy004.cloudant.net",
		"dbcore@db2.testy004.cloudant.net",
		"dbcore@db3.testy004.cloudant.net"
	]
}
```
{: codeblock}

## `GET /_membership`
{: #-get-_membership-}

This endpoint returns the names of nodes in the cluster.
Currently, active clusters are indicated in the `cluster_nodes` field.
The `all_nodes` field lists all the nodes,
regardless of whether they're active or not.

-   **Method**: `GET`
-   **Path**: `/_membership`
-   **Response**: JSON document that lists cluster nodes and all nodes
-   **Roles permitted**: _admin

See the following example request to list nodes in the cluster by using HTTP:

```http
GET /_membership HTTP/1.1
```
{: codeblock}

See the following example request to list nodes in the cluster by using the command line:

```sh
curl "https://$ACCOUNT.cloudant.com/_membership" \
	-u $ACCOUNT
```
{: codeblock}

<!--

See the following example request to list nodes in the cluster using Javascript:

```javascript
var nano = require('nano');
var account = nano('https://$ACCOUNT:$PASSWORD@$ACCOUNT.cloudant.com');
account.request({
	path: '_membership'
}, function (err, body) {
	if (!err) {
		console.log(body);
	}
});
```
{: codeblock}

-->

### Response structure
{: #response-structure-_membership}

Field name      | Description
----------------|------------------------------------------------------------------
`cluster_nodes` | Array of node names (strings) of the active nodes in the cluster.
`all_nodes`     | Array of nodes names (strings) of all nodes in the cluster.

See the following example response to list node names in the cluster:

```json
{
	"cluster_nodes": [
		"dbcore@db1.testy004.cloudant.net",
		"dbcore@db2.testy004.cloudant.net",
		"dbcore@db3.testy004.cloudant.net"
	],
	"all_nodes": [
		"dbcore@db1.testy004.cloudant.net",
		"dbcore@db2.testy004.cloudant.net",
		"dbcore@db3.testy004.cloudant.net"
	]
}
```
{: codeblock}

## `GET /_uuids`
{: #-get-_uuids-}

This endpoint is a general utility requests one or more Universally Unique Identifiers (UUIDs).
The response is a JSON object that provides a list of UUIDs.

-   **Method**: `GET`
-   **Path**: `/_uuids`
-   **Response**: JSON document that contains a list of UUIDs

Argument | Description               | Optional | Type
---------|---------------------------|----------|------------------------------------------------------------------
`count`  | Number of UUIDs to return | yes      | Positive integer, greater than 0 and less than or equal to 1,000.

See the following example request for a single UUID by using HTTP:

```HTTP
GET /_uuids HTTP/1.1
```
{: codeblock}

See the following example request for a single UUID by using the command line:

```sh
curl "https://$ACCOUNT.cloudant.com/_uuids" \
	-u $ACCOUNT
```
{: codeblock}

<!--

See the following example request for a single UUID by using Javascript:

```javascript
var nano = require('nano');
var account = nano('https://$ACCOUNT:$PASSWORD@$ACCOUNT.cloudant.com');
account.request({
	path: '_uuids'
}, function (err, body) {
	if (!err) {
		console.log(body);
	}
});
```
{: codeblock}

-->

See the following example response to a request for a single UUID:

```json
{
	"uuids" : [
		"7e4b5a14b22ec1cf8e58b9cdd0000da3"
	]
}
```
{: codeblock}

See the following example request for five UUIDs by using HTTP:

```HTTP
GET /_uuids?count=5 HTTP/1.1
```
{: codeblock}

See the following example request for five UUIDs by using the command line:

```sh
curl "https://$ACCOUNT.cloudant.com/_uuids?count=5" \
	-u $ACCOUNT
```
{: codeblock}

<!--

See the following example request for five UUIDs by using Javascript:

```javascript
var nano = require('nano');
var account = nano('https://$ACCOUNT:$PASSWORD@$ACCOUNT.cloudant.com');
account.request({
	path: '_uuids?count=5'
}, function (err, body) {
	if (!err) {
		console.log(body);
	}
});
```
{: codeblock}

-->

See the following example response to a request for five UUIDs:

```json
{
	"uuids" : [
		"c9df0cdf4442f993fc5570225b405a80",
		"c9df0cdf4442f993fc5570225b405bd2",
		"c9df0cdf4442f993fc5570225b405e42",
		"c9df0cdf4442f993fc5570225b4061a0",
		"c9df0cdf4442f993fc5570225b406a20"
	]
}
```
{: codeblock}
