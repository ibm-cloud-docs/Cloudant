---

copyright:
  years: 2015, 2019
lastupdated: "2019-04-22"

keywords: performance options, attachments, filtered replication, replication scheduler, cancel replication 

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

<!-- Acrolinx: 2018-12-10 -->

# Advanced replication
{: #advanced-replication}

You can learn about advanced replication concepts and tasks, including maintaining your replication database, scheduling and monitoring replications, authenticating during replication, and more.
{: shortdesc}

You might also find it helpful to review details of the underlying
[replication protocol ![External link icon](../images/launch-glyph.svg "External link icon")](http://docs.couchdb.org/en/stable/replication/protocol.html){: new_window},
and review the [Advanced Methods](/docs/services/Cloudant?topic=cloudant-advanced-api#advanced-api) material.

## Replication database maintenance
{: #replication-database-maintenance}

A replication database must be looked after like any other database.
Without regular database maintenance,
you might accumulate invalid documents that were caused by interruptions to the replication process.
Having many invalid documents can result in an excess load on your cluster
when the replicator process is restarted by {{site.data.keyword.cloudantfull}} operations.

The main action that you can do to maintain a replication database is to remove old documents.
This action can be done by determining the age of documents,
and [deleting them](/docs/services/Cloudant?topic=cloudant-documents#delete-a-document) if they are no longer needed.

## The replication scheduler
{: #the-replication-scheduler}

The new {{site.data.keyword.cloudant_short_notm}} Replication Scheduler provides a number of improvements and enhancements when compared
with the previous {{site.data.keyword.cloudant_short_notm}} replication mechanism.

In particular,
network usage during replication is more efficient. The scheduler accounts for the current load for individual database nodes within a cluster
when it determines the allocation of replication tasks.

Finally,
the state of a replication is now more detailed,
and consists of seven distinct states:

1.  `initializing`:
  The replication was added to the scheduler,
  but is not yet initialized or scheduled to run.
  The status occurs when a new or updated replication document is stored within
  the [`_replicator` database](/docs/services/Cloudant?topic=cloudant-replication-api#the-_replicator-database). 
2.  `error`:
  The replication cannot be turned into a job.
  This error might be caused in several different ways.
  For example,
  the replication must be [filtered](/docs/services/Cloudant?topic=cloudant-design-documents#filter-functions),
  but it was not possible to fetch the filter code from the source database.
3.  `pending`:
  The replication job is scheduled to run,
  but is not yet running.
4.  `running`:
  The replication job is running.
5.  `crashing`:
  A temporary error occurred that affects the replication job.
  The job is automatically retried later.
6.  `completed`:
  The replication job completed.
  This state does not apply to [continuous replications](/docs/services/Cloudant?topic=cloudant-replication-api#continuous-replication).
7.  `failed`:
  The replication job failed.
  The failure is permanent.
  This state means that no further attempt is made to replicate by using this replication task.
  The failure might be caused in several different ways,
  for example if the source or target URLs are not valid.
  
The transition between these states is illustrated in the following diagram:

![Replication Scheduler states](../images/fb85704.png "Replication Scheduler states")

The scheduler introduces two new endpoints:

- [`/_scheduler/docs`](#the-_scheduler-docs-endpoint)
- [`/_scheduler/jobs`](#the-_scheduler-jobs-endpoint)

You can manage and determine replication status more quickly and easily by using these endpoints.

The typical process for using the replication scheduler to manage and monitor replications is as follows:

1.  Create a [replication document](/docs/services/Cloudant?topic=cloudant-replication-api#replication-document-format) that describes the needed replication,
    and store the document in the [replicator database](/docs/services/Cloudant?topic=cloudant-replication-api#the-_replicator-database).
2.  Monitor the status of the replication by using the `/_scheduler/docs` endpoint.

### The `/_scheduler/docs` endpoint
{: #the-_scheduler-docs-endpoint}

The `/_scheduler/docs` endpoint provides a monitoring capability.
Use it to determine the status of a replication that is described by a replication document.
The status of a replication can be one of seven possible states,
as described in [the replication scheduler](#the-replication-scheduler) section.

#### Query parameters for the `/_scheduler/docs` endpoint
{: #query-parameters-for-the-_scheduler-docs-endpoint}

You can add query parameters to the URL and narrow your search results, for example, `'_scheduler/docs/_replicator?limit=1&skip=1'`. 

All parameters are optional. 

You can use the following parameters to narrow your search results:

Name      | Type                    | Description                                                               | Default
----------|-------------------------|---------------------------------------------------------------------------|-------------------
`states`  | comma-delimited strings | Includes only replication documents in the specified states.               | Return all states
`limit`   | integer                 | Number of documents that are included in the search results. Maximum limit is 200. | Return all
`skip`    | integer                 | Number of results to skip before the search results are returned.                | 0

#### The `/_scheduler/docs/_replicator/$doc_id` endpoint
{: #the-_scheduler-docs-_replicator-doc_id-endpoint}

The endpoint uses document IDs as the primary identifier.
This characteristic means that if you know the document ID,
you can directly query that one particular document by using a `/_scheduler/docs/_replicator/$doc_id` query. 

The ID must be URL encoded. 
{: tip}

### The `/_scheduler/jobs` endpoint
{: #the-_scheduler-jobs-endpoint}

The `/_scheduler/jobs` endpoint provides more details about active replication tasks that are run during replication.

For example,
the `/_scheduler/jobs` endpoint describes when the replication last started, stopped, or crashed.

However,
the endpoint does not include results for replications that are in the `completed` or `failed` state. Replications in these states are not included because such replications are considered complete, and therefore are no longer active jobs.

#### Query parameters for the `/_scheduler/jobs` endpoint
{: #query-parameters-for-the-_scheduler-jobs-endpoint}

You can add query parameters to the URL and narrow your search results, for example, `'_scheduler/jobs/_replicator?limit=1&skip=1'`. 

All parameters are optional. 

You can use the following parameters to narrow your search results:

Name     | Type    | Description                                                          | Default
---------|---------|----------------------------------------------------------------------|-------------
`limit`  | integer | Number of jobs that are included in the search results. Maximum limit is 200. | 25
`skip`   | integer | Number of results to skip before search results are returned.           | 0

#### The `/_scheduler/jobs/_replicator/$job_id` endpoint
{: #the-_scheduler-jobs-_replicator-job_id-endpoint}

The `/_scheduler/jobs/_replicator/$job_id` endpoint shows the state of a single replication task based on its replication ID. 

The ID must be URL encoded.
{: tip}

## Replication Status
{: #replication-status}

You can determine replication status by checking
the [replication scheduler](/docs/services/Cloudant?topic=cloudant-advanced-replication#the-replication-scheduler).

The previous technique of checking replication status by inspecting the [replication document](#status-checking-by-using-the-replication-document) is still available.
{: note}

### Status checking by using the replication scheduler
{: #status-checking-by-using-the-replication-scheduler}

You can use the replication scheduler to determine the status of replication. 

To determine the status of replication by using the replication scheduler,
send a `GET` request to the `/_scheduler/docs` endpoint.  

_Example of using HTTP to get the replication status from the replication scheduler:_

```http
GET /_scheduler/docs HTTP/1.1
HOST: $ACCOUNT.cloudant.com
```
{: codeblock}

_Example of using the command line to get the replication status from the replication scheduler:_

```sh
curl https://$ACCOUNT.cloudant.com/_scheduler/docs
```
{: codeblock}

_Example response (abbreviated) from the replication scheduler:_

```json
{
  "docs": [
    {
      "database": "$account/_replicator",
      "doc_id": "myrep",
      "error_count": 0,
      "id": "88b..get",
      "info": null,
      "last_updated": "2016-11-10T06-51-19Z",
      "node": "node1@127.0.0.1",
      "proxy": null,
      "start_time": "2016-11-10T06-50-35Z",
      "state": "running",
      "source": "$source_db/",
      "target": "$target_db/"
    }
  ],
  "offset": 0,
  "total_rows": 1
}
```
{: codeblock}

The response that is received from the replication scheduler shows the history and status of all replications.

_Example of using the command line to find jobs with the `limit` and `skip` parameters:_

```sh
curl `https://$ACCOUNT.cloudant.com/_scheduler/docs/_replicator?limit=1&skip=1`
```
{: codeblock}

_Example response from using the `limit` and `skip` parameters:_

```json
{
  "total_rows": 2,
  "offset": 1,
  "docs": [
    {
      "database": "$account/_replicator",
      "doc_id": "myrep2",
      "id": "5a4..ous",
      "node": "node1@127.0.0.1.cloudant.net",
      "source": "$source_db/",
      "target": "$target_db/",
      "state": "running",
      "info": null,
      "error_count": 0,
      "last_updated": "2017-10-05T14:46:28Z",
      "start_time": "2017-10-05T14:46:28Z",
      "proxy": null
    }
  ]
}
```
{: codeblock}

_Example of using the command line to find jobs with the `states` parameter:_

```sh
curl https://$ACCOUNT.cloudant.com/_scheduler/docs/_replicator?states=crashing
```
{: codeblock}

_Example response from using the `states` parameter:_

```json
{
  "total_rows": 2,
  "offset": 0,
  "docs": [
    {
      "database": "$account/_replicator",
      "doc_id": "myrep",
      "id": "88b..get",
      "node": "node1@127.0.0.1",
      "source": "$source_db/",
      "target": "$target_db/",
      "state": "crashing",
      "info": "unauthorized: unauthorized to access or create database $source_db/",
      "error_count": 4,
      "last_updated": "2017-10-05T14:50:01Z",
      "start_time": "2017-10-05T14:43:53Z",
      "proxy": null
    }
  ]
}
```
{: codeblock}

_Example of using the command line to find jobs with the `_doc_id` parameter:_

```sh
curl https://$ACCOUNT.cloudant.com/_scheduler/docs/_replicator/myrep
```
{: codeblock}

_Example response from using `doc_id` parameter:_

```json
{
  "database": "$account/_replicator",
  "doc_id": "myrep",
  "id": "88b..get",
  "node": "node1@127.0.0.1",
  "source": "$source_db/",
  "target": "$target_db/",
  "state": "crashing",
  "info": "unauthorized: unauthorized to access or create database $source_db/",
  "error_count": 3,
  "last_updated": "2017-10-05T14:47:01Z",
  "start_time": "2017-10-05T14:43:53Z",
  "proxy": null
}
```
{: codeblock}

_Example of using the command line to find jobs with the `_job_id` parameter:_

```sh
curl 'https://$ACCOUNT.cloudant.com/_scheduler/jobs/68245f5954fa122e7768a4bfbfbd0d15+2bcontinuous'
```
{: codeblock}

_Example response from using the `_job_id` parameter:_

```json
{
  "database": "_replicator",
  "id": "68245f5954fa122e7768a4bfbfbd0d15+continuous",
  "pid": "<0.12885.49>",
  "source": "$source_db/",
  "target": "$target_db/",
  "user": null,
  "doc_id": "myrep3",
  "history": [
    {
      "timestamp": "2017-10-10T15:00:39Z",
      "type": "started"
    },
    {
      "timestamp": "2017-10-10T15:00:39Z",
      "type": "added"
    }
  ],
  "node": "node1@127.0.0.1",
  "start_time": "2017-10-10T15:00:39Z"
}
```
{: codeblock}

The response that is received from the replication scheduler shows the history and status of all replications.

### Status checking by using the replication document
{: #status-checking-by-using-the-replication-document}

When replication is managed by storing a document in the `_replicator` database,
the contents of the document are updated as the replication status changes.

The preferred method of checking replication status is to use the [replication scheduler](#the-replication-scheduler).
{: tip}

In particular, after replication starts,
three new fields are added automatically to the replication document.
The fields all have the prefix: `_replication_`

Field | Detail
------|-------
`_replication_id` | This is the internal ID assigned to the replication. It is the same ID that appears in the output from `_active_tasks`.
`_replication_state` | The current state of the replication.
`_replication_state_time` | An [RFC 3339 ![External link icon](../images/launch-glyph.svg "External link icon")](https://www.ietf.org/rfc/rfc3339.txt){: new_window} compliant time stamp that reports when the current replication state defined in `_replication_state` was set.

The possible values for the `_replication_state` are:

-	`completed`: The replication completed successfully.
-	`error`: An error occurred during replication.
-	`triggered`: The replication started. It is now in progress.

_Example replication document before it is `PUT` into `_replicator`:_

```json
{
	"_id": "my_rep",
	"source":  "https://$USERNAME:$PASSWORD@myserver.com:5984/fromthis",
	"target":  "https://$USERNAME:$PASSWORD@$ACCOUNT.cloudant.com/tothat",
	"create_target":  true
}
```
{: codeblock}

_Example of automatic update to replication document, which is updated after replication starts:_

```json
{
	"_id": "my_rep",
	"source": "https://$USERNAME:$PASSWORD@$ACCOUNT.com:5984/fromthis",
	"target": "https://$USERNAME:$PASSWORD@$ACCOUNT.cloudant.com/tothat",
	"create_target": true
	"_replication_id": "c0ebe9256695ff083347cbf95f93e280",
	"_replication_state": "triggered",
	"_replication_state_time": "2011-06-07T16:54:35+01:00"
}
```
{: codeblock}

When the replication finishes,
it updates the `_replication_state` field with the value `completed`,
and the `_replication_state_time` field with the time that the completion status was recorded.

_Example of automatic update to replication document, which is updated after replication starts:_

```json
{
	"_id": "my_rep",
	"source": "https://$USERNAME:$PASSWORD@$ACCOUNT.com:5984/fromthis",
	"target": "https://$USERNAME:$PASSWORD@$ACCOUNT.cloudant.com/tothat",
	"create_target": true
	"_replication_id": "c0ebe9256695ff083347cbf95f93e280",
	"_replication_state": "completed",
	"_replication_state_time": "2011-06-07T16:56:21+01:00"
}
```
{: codeblock}

A continuous replication can never have a `completed` state.

## Authentication during replication
{: #authentication-during-replication}

In any production application, security of the source and target databases is essential.
In order for replication to proceed, authentication is necessary to access the databases.
In addition, checkpoints for replication are [enabled by default](/docs/services/Cloudant?topic=cloudant-replication-api#replication-document-format),
which means that replicating the source database requires write access.

To enable authentication during replication,
include a user name and password in the database URL.
The replication process uses the supplied values for HTTP Basic Authentication.

_Example of specifying user name and password values for accessing source and target databases during replication:_

```json
{
	"source": "https://$USERNAME:$PASSWORD@example.com/db", 
	"target": "https://$USERNAME:$PASSWORD@$ACCOUNT.cloudant.com/db"
}
```
{: codeblock}

## Filtered Replication
{: #filtered-replication}

Sometimes you do not want to transfer all documents from source to target.
To choose which documents to transfer,
include one or more filter functions in a design document on the source.
You can then tell the replicator to use these filter functions.

Filtering documents during replication is similar to the process of
[filtering the `_changes` feed](/docs/services/Cloudant?topic=cloudant-design-documents#filter-functions).
{: tip}

A filter function takes two arguments:

-	The document to be replicated.
-	The replication request.

A filter function returns a `true` or `false` value.
If the result is true,
the document is replicated.

_A simple example of a filter function:_

```javascript
function(doc, req) {
	return !!(doc.type && doc.type == "foo");
}
```
{: codeblock}

Filters are stored under the topmost `filters` key of the design document.

_A simple example of storing a filter function in a design document:_

```json
{
	"_id": "_design/myddoc",
	"filters": {
		"myfilter": "function goes here"
	}
}
```
{: codeblock}

A filtered replication is started by using a JSON statement that identifies:

-	The source database.
-	The target database.
-	The name of the filter that is stored under the `filters` key of the design document.

_Example JSON for starting a filtered replication:_

```json
{
	"source": "http://$USERNAME:$PASSWORD@example.org/example-database",
	"target": "http://$USERNAME:$PASSWORD@$ACCOUNT.cloudant.com/example-database",
	"filter": "myddoc/myfilter"
}
```
{: codeblock}

Arguments can be supplied to the filter function by
including key:value pairs in the `query_params` field of the invocation.

_Example JSON for starting a filtered replication with supplied parameters:_

```json
{
	"source": "http://$USERNAME:$PASSWORD@example.org/example-database",
	"target": "http://$USERNAME:$PASSWORD@$ACCOUNT.cloudant.com/example-database",
	"filter": "myddoc/myfilter",
	"query_params": {
		"key": "value"
	}
}
```
{: codeblock}

The `selector` option provides performance benefits when compared with using the `filter` option. Use the `selector` option whenever possible. For more information, see the [`selector`](/docs/services/Cloudant?topic=cloudant-replication-api#the-selector-field){: new_window} documentation.
{: note}

## Named Document Replication
{: #named-document-replication}

Sometimes you do not want to replicate documents.
For simple replications,
you do not need to write a filter function.
Instead,
to replicate specific documents,
add the list of keys as an array in the `doc_ids` field.

_Example replication of specific documents:_

```json
{
	"source": "http://$USERNAME:$PASSWORD@example.org/example-database",
	"target": "http://$USERNAME:$PASSWORD@127.0.0.1:5984/example-database",
	"doc_ids": ["foo", "bar", "baz"]
}
```
{: codeblock}

## Replicating through a proxy
{: #replicating-through-a-proxy}

If you want replication to pass through an HTTP proxy,
provide the proxy details in the `proxy` field of the replication data.

_Example showing replication through a proxy:_

```json
{
	"source": "http://$USERNAME:$PASSWORD@$ACCOUNT.cloudant.com/example-database",
	"target": "http://$USERNAME:$PASSWORD@example.org/example-database",
	"proxy": "http://my-proxy.com:8888"
}
```
{: codeblock}

## The `user_ctx` property and delegations
{: #the-user_ctx-property-and-delegations}

Replication documents can have a custom `user_ctx` property.
This property defines the user context under which a replication runs.

An older way of triggering replications,
by making a `POST` to the `/_replicate/` endpoint,
did not need the `user_ctx` property.
The reason is that at the moment of triggering the replication,
all the necessary information about the authenticated user is available.

By contrast,
the replicator database is a regular database.
Therefore, the information about the authenticated user is only present
at the moment the replication document is written to the database.
In other words,
the replicator database implementation is similar to a `_changes` feed consumption application, 
with `?include_docs=true` set.

For replication, this implementation difference means that for non-admin users,
a `user_ctx` property that contains the user's name and a subset of their roles
must be defined in the replication document.
This requirement is addressed by a validation function present in the default design document of the replicator database.
The function validates each document update.
This validation function also ensures that a non-admin user cannot set a user name property in the `user_ctx` property
that does not correspond to the correct user name.
The same principle also applies for roles.

_Example delegated replication document:_

```json
{
	"_id": "my_rep",
	"source":  "https://$ACCOUNT:$PASSWORD@$SERVER.com:5984/foo",
	"target":  "https://$ACCOUNT:$PASSWORD@$ACCOUNT.cloudant.com/bar",
	"continuous":  true,
	"user_ctx": {
		"name": "joe",
		"roles": ["erlanger", "researcher"]
	}
}
```
{: codeblock}

For admins,
the `user_ctx` property is optional.
If the property is missing,
the value defaults to a user context with the name `null` and an empty list of roles.

The empty list of roles means that design documents are not written to local targets during replication.
If you want to write design documents to local targets,
then a user context with the `_admin` role must be set explicitly.

Also,
for admins,
the `user_ctx` property can be used to trigger a replication on behalf of another user.
This user context is passed to local target database document validation functions.

The `user_ctx` property applies to local endpoints only.
{: note}

In summary,
for admins the `user_ctx` property is optional,
while for regular (non-admin) users it is mandatory.
When the roles property of `user_ctx` is missing,
it defaults to the empty list `[ ]`.

## Performance-related options
{: #performance-related-options}

Several performance-related options can be set for a replication,
by including them in the replication document.

-   `connection_timeout` - The maximum period of inactivity for a connection in milliseconds.
	If a connection is idle for this period,
	its current request is retried.
	Default value is 30000 milliseconds (30 seconds).
-   `http_connections` - The maximum number of HTTP connections per replication.
	For push replications,
	the effective number of HTTP connections that are used is `min(worker_processes + 1, http_connections)`.
	For pull replications,
	the effective number of connections that are used corresponds to this parameter's value.
	Default value is 20.
-   `retries_per_request` - The maximum number of retries per request.
	Before a retry,
	the replicator waits for a short period before it repeats the request.
	This period doubles between each consecutive retry attempt,
	and never goes beyond 5 minutes.
	The minimum value before the first retry attempt is 0.25 seconds.
	The default value is 10 attempts.
-   `socket_options` - A list of options to pass to the connection sockets.
	The available options can be found in the
	[documentation for the Erlang function setopts/2 of the `inet` module ![External link icon](../images/launch-glyph.svg "External link icon")](http://www.erlang.org/doc/man/inet.html#setopts-2){: new_window}. 
	Default value is `[{keepalive, true},{nodelay, false}]`.
-   `worker_batch_size` - Worker processes run batches of replication tasks,
	where the batch size is defined by this parameter.
	The size corresponds to the number of `_changes` feed rows.
	Larger values for the batch size might result in better performance.
	Smaller values mean that checkpointing is done more frequently.
	Default value is 500.
-	`worker_processes` - The number of processes the replicator uses in each replication task to transfer
	documents from the source to the target database.
	Higher values might produce better throughput because of greater parallelism in network and disk IO activities,
	but this improvement comes at the cost of requiring more memory and potentially CPU time.
	Default value is 4.

_Example of including performance options in a replication document:_

```json
{
	"source": "https://$ACCOUNT1:$PASSWORD1@example.com/example-database",
	"target": "https://$ACCOUNT2:$PASSWORD2@example.org/example-database",
	"connection_timeout": 60000,
	"retries_per_request": 20,
	"http_connections": 30
}
```
{: codeblock}

## The effect of large attachments 
{: #the-effect-of-large-attachments}

Having large numbers of attachments on documents might cause an adverse effect on replication performance.

For more information about the effect of attachments on replication performance,
see [Performance considerations](/docs/services/Cloudant?topic=cloudant-attachments#performance-considerations).

## The `/_replicate` endpoint
{: #the-_replicate-endpoint}

It is preferable to use the [replicator scheduler](#the-replication-scheduler) to manage replication.
For more information about using the replicator scheduler to manage replication, see  [Avoiding the `/_replicate` endpoint](#avoiding-the-_replicate-endpoint).
{: note}

You can use this endpoint to request,
configure,
or stop,
a replication operation.

You do these actions by sending a `POST` request directly to the `/_replicate` endpoint.
The `POST` contains a JSON document that describes the wanted replication.

-	**Method**: `POST`
-	**Path**: `/_replicate`
-	**Request**: Replication specification
-	**Roles**: `_admin`

The specification of the replication request is controlled through the JSON content of the request.
The JSON document must contain fields that define the source,
target,
and other options.

Except for the `cancel` field,
the fields in the JSON document that is supplied to the `_replicate` endpoint are identical to those fields in
a replication document that is stored in the [`_replicator` database](/docs/services/Cloudant?topic=cloudant-replication-api#the-_replicator-database).
The JSON document uses the [replication document format](/docs/services/Cloudant?topic=cloudant-replication-api#replication-document-format).

The fields of the JSON request are as follows:

Field           | Purpose                                                     | Optional
----------------|-------------------------------------------------------------|---------
`cancel`        | Cancels the replication.                                    | Yes
`continuous`    | Configure the replication to be continuous.                 | Yes
`create_target` | Creates the target database.                                | Yes
`doc_ids`       | Array of document IDs to be synchronized.                   | Yes
`proxy`         | Address of a proxy server through which replication occurs. | Yes
`source`        | Source database URL, including user name and password.      | No
`target`        | Target database URL, including user name and password.      | No

_Example instructions for using HTTP to start a replication through the `_replicate` endpoint:_

```http
POST /_replicate HTTP/1.1
Content-Type: application/json
```
{: codeblock}

_Example instructions for using the command line to start a replication through the `_replicate` endpoint:_

```sh 
curl -H 'Content-Type: application/json' -X POST "https://$ACCOUNT.cloudant.com/_replicate" -d @replication-doc.json
# with the file replication-doc.json containing the required replication information.
```
{: codeblock}

_Example JSON document that describes the required replication:_

```json
{
	"source": "http://$ACCOUNT:$PASSWORD@username.cloudant.com/example-database",
	"target": "http://$ACCOUNT2:$PASSWORD2@example.org/example-target-database"
}
```
{: codeblock}

### Return Codes
{: #return-codes-adv-replication}

Code  | Description
------|------------
`200` | Replication request successfully completed.
`202` | Continuous replication request has been accepted.
`404` | Either the source or target database was not found.
`500` | JSON specification was invalid.

### Canceling replication by using the `/_replicate` endpoint
{: #canceling-replication-by-using-the-_replicate-endpoint}

A replication that is triggered by `POST`ing to `/_replicate` can be canceled
by `POST`ing the exact same JSON object but with the additional `cancel` property set to `true`.

If a replication is canceled,
the request that initiated the replication fails with [error 500 (shutdown)](/docs/services/Cloudant?topic=cloudant-http#http-status-codes).
{: note}

The replication ID can be obtained from the original replication request if it is a continuous replication.
Alternatively,
the replication ID can be obtained from [`/_active_tasks`](/docs/services/Cloudant?topic=cloudant-active-tasks#active-tasks).

_Example of using HTTP to cancel a replication:_

```http
POST /_replicate HTTP/1.1
Content-Type: application/json
```
{: codeblock}

_Example of using the command line to cancel a replication:_

```sh
curl -H 'Content-Type: application/json' -X POST 'https://$ACCOUNT.cloudant.com/_replicate HTTP/1.1' -d @replication-doc.json
# the file replication-doc.json must be supplied.
```
{: codeblock}

_Example JSON document that describes the replication to be canceled:_

```json
{
	"source": "https://$USERNAME:$PASSWORD@$ACCOUNT.cloudant.com/example-database",
	"target": "https://$USERNAME2:$PASSWORD2@example.org/example-database",
	"cancel": true
}
```
{: codeblock}

### Avoiding the `/_replicate` endpoint
{: #avoiding-the-_replicate-endpoint}

Use the [`_replicator` scheduler](#the-replication-scheduler) instead of the `/_replicate` endpoint.
{: important}

If a problem occurs during replication, such as a stall, timeout, or application crash,
a replication that is defined within the `_replicator` database is automatically restarted by the system. Whereas, if you define a replication by sending a request to the `/_replicate` endpoint, it cannot be restarted by the system if a problem occurs because the replication request does not persist. In addition, replications that are defined in the `_replicator` database are easier to [monitor](#replication-status).
