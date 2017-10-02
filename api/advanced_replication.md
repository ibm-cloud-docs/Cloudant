---

copyright:
  years: 2015, 2017
lastupdated: "2017-07-13"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-05-31 -->

# Advanced replication

This section contains details about more advanced replication concepts and tasks.
{:shortdesc}

You might also find it helpful to review details of the underlying
[replication protocol ![External link icon](../images/launch-glyph.svg "External link icon")](http://dataprotocols.org/couchdb-replication/){:new_window},
and review the [Advanced Methods](advanced.html) material.

## Replication database maintenance

A replication database must be looked after like any other database.
Without regular database maintenance,
you might accumulate invalid documents that were caused by interruptions to the replication process.
Having many invalid documents can result in an excess load on your cluster
when the replicator process is restarted by Cloudant operations.

The main action that you can do to maintain a replication database is to remove old documents.
This can be done by determining the age of documents,
and [deleting them](document.html#delete) if they are no longer needed.

## The replication scheduler

The new Cloudant Replication Scheduler provides a number of improvements and enhancements when compared
with the previous Cloudant replication mechanism.

In particular,
network usage during replication is more efficient,
and the scheduler takes into account the current load for individual database nodes within a cluster
when determining the allocation of replication tasks.

Finally,
the state of a replication is now more detailed,
and consists of seven distinct states:

1.  `initializing`:
  The replication was added to the scheduler,
  but is not yet initialized or scheduled to run.
  The status occurs when a new or updated replication document is stored within
  the [`_replicator` database](replication.html#the-_replicator-database). 
2.  `error`:
  The replication cannot be turned into a job.
  This error might be caused in several different ways.
  For example,
  the replication must be [filtered](design_documents.html#filter-functions),
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
  This state does not apply to [continuous replications](replication.html#continuous-replication).
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

These endpoints enable you to manage and determine replication status more quickly and easily.

The typical process for using the replication scheduler to manage and monitor replications is as follows:

1.  Create a [replication document](replication.html#replication-document-format) that describes the needed replication,
    and store the document in the [replicator database](replication.html#the-_replicator-database).
2.  Monitor the status of the replication using the `/_scheduler/docs` endpoint.

### The `/_scheduler/docs` endpoint

The `/_scheduler/docs` endpoint provides a monitoring capability.
Use it to determine the status of a replication described by a replication document.
The status of a replication can be one of seven possible states,
as described [previously](#the-replication-scheduler).

The endpoint uses document IDs as the primary identifier.
This characteristic means that if you know the document ID,
you can directly query that one particular document by using a `/_scheduler/docs/_replicator/<DocID>` query.

### The `/_scheduler/jobs` endpoint

The `/_scheduler/jobs` endpoint provides more details about the specific tasks performed during replication.
The endpoint also provides more detailed information for the current replication.

For example,
the `/_scheduler/jobs` endpoint describes when the replication last started, stopped, or crashed.

However,
the endpoint does not include results for replications that are in the `completed` or `failed` state;
the reason is that such replications are considered to have finished,
and therefore are no longer a current job.

## Replication Status

You can determine replication status by checking
the [replication scheduler](#status-checking-by-using-the-replication-scheduler).

> **Note:** The previous technique of checking replication status by inspecting
the [replication document](#status-checking-by-using-the-replication-document) is still available.

### Filter replication status

You can filter the information that is returned with the replication status for `_scheduler/jobs` 
and `_scheduler/docs` endpoints by using additional parameters to filter the results. 

*For the `_scheduler/jobs` endpoint:*

Parameter | Detail
----------|-------
`<job_id>`| The `_scheduler/jobs/<job_id>` field shows the state of a single replication task based on its replication ID. Note that the ID must be URL encoded.
`limit`=`<LIMIT>` | * Default limit is 25. 
                | * Regular users cannot exceed that limit. 
                | * Operators with administrator privileges do not have a maximum limit. For example, an administrator user can use `limit`=999999999.
`skip`=`<OFFSET>` |                 
 
*For the `_scheduler/docs` endpoint:*

Parameter | Detail
----------|-------
`limit`=`<LIMIT>`            | The maximum limit is 268435456. This limit is the same as the maximum views limit. 
`skip`=`<OFFSET>` |
`states`=`<state1>,<state2>` | Specify the states to filter the `_scheduler/docs` endpoint tasks. For example, 
if you specify `_scheduler/docs/?states=running,pending`, it returns all the replication tasks that are either 
running or pending.

<div id="status-checking-using-the-replication-scheduler"></div>

### Status checking by using the replication scheduler

The replication scheduler enables you to determine the status of replication. 

To determine the current status of replication using the replication scheduler,
send a `GET` request to the `/_scheduler/docs` endpoint. See the example below. 

   

_Example of using HTTP to get the replication status from the replication scheduler:_

```http
GET /$DATABASE/_scheduler/docs HTTP/1.1
HOST: $ACCOUNT.cloudant.com
```
{:codeblock}

_Example of using the command line to get the replication status from the replication scheduler:_

```sh
curl https://$ACCOUNT.cloudant.com/$DATABASE/_scheduler/docs
```
{:codeblock}

_Example response (abbreviated) from the replication scheduler:_

```json
{
  "docs": [
    {
      "database": "_replicator",
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
{:codeblock}

The response received from the replication scheduler shows the history and current status of all replications.

<div id="status-checking-using-the-replication-document"></div>

### Status checking by using the replication document

When replication is managed by storing a document in the `_replicator` database,
the contents of the document are updated as the replication status changes.

> **Note:** The preferred method of checking replication status is to use the [replication scheduler](#the-replication-scheduler).

In particular, after replication starts,
three new fields are added automatically to the replication document.
The fields all have the prefix: `_replication_`

Field | Detail
------|-------
`_replication_id` | This is the internal ID assigned to the replication. It is the same ID that appears in the output from `_active_tasks`.
`_replication_state` | The current state of the replication.
`_replication_state_time` | An [RFC 3339 ![External link icon](../images/launch-glyph.svg "External link icon")](https://www.ietf.org/rfc/rfc3339.txt){:new_window} compliant time stamp that reports when the current replication state defined in `_replication_state` was set.

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
{:codeblock}

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
{:codeblock}

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
{:codeblock}

A continuous replication can never have a `completed` state.

<div id="authentication"></div>

## Authentication during replication

In any production application, security of the source and target databases is essential.
In order for replication to proceed, authentication is necessary to access the databases.
In addition, checkpoints for replication are [enabled by default](replication.html#checkpoints),
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
{:codeblock}

## Filtered Replication

Sometimes you do not want to transfer all documents from source to target.
To choose which documents to transfer,
include one or more filter functions in a design document on the source.
You can then tell the replicator to use these filter functions.

> **Note**: Filtering documents during replication is similar to the process of
[filtering the `_changes` feed](design_documents.html#filter-functions).

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
{:codeblock}

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
{:codeblock}

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
{:codeblock}

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
{:codeblock}

## Named Document Replication

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
{:codeblock}

## Replicating through a proxy

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
{:codeblock}

## The `user_ctx` property and delegations

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

This implementation difference for replication means that for non admin users,
a `user_ctx` property that contains the user's name and a subset of their roles
must be defined in the replication document.
This requirement is addressed by a validation function present in the default design document of the replicator database.
The function validates each document update.
This validation function also ensures that a non admin user cannot set a user name property in the `user_ctx` property
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
{:codeblock}

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

>   **Note**: The `user_ctx` property applies for local endpoints only.

In summary,
for admins the `user_ctx` property is optional,
while for regular (non admin) users it is mandatory.
When the roles property of `user_ctx` is missing,
it defaults to the empty list `[ ]`.

## Performance-related options

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
	[documentation for the Erlang function setopts/2 of the `inet` module ![External link icon](../images/launch-glyph.svg "External link icon")](http://www.erlang.org/doc/man/inet.html#setopts-2){:new_window}. 
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
{:codeblock}

## Attachments

Having large numbers of attachments on documents might cause an adverse effect on replication performance.

For more information about the effect of attachments on replication performance,
see [here](attachments.html#performance-considerations).

## The `/_replicate` endpoint

>	**Note**: It is preferable to use the [Replicator scheduler](#the-replication-scheduler) to manage replication.
	Details of why are provided [here](#avoiding-the-_replicate-endpoint).

You can use this endpoint to request,
configure,
or stop,
a replication operation.

You do this by sending a `POST` request directly to the `/_replicate` endpoint.
The `POST` contains a JSON document that describes the wanted replication.

-	**Method**: `POST`
-	**Path**: `/_replicate`
-	**Request**: Replication specification
-	**Roles**: `_admin`

The specification of the replication request is controlled through the JSON content of the request.
The JSON document must contain fields that define the source,
target,
and other options.

With the exception of the `cancel` field,
the fields in the JSON document supplied to the `_replicate` endpoint are identical to those in
a replication document stored in the [`_replicator` database](replication.html#replicator-database).
The JSON document uses the [replication document format](replication.html#replication-document-format).

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
{:codeblock}

_Example instructions for using the command line to start a replication through the `_replicate` endpoint:_

```sh 
curl -H 'Content-Type: application/json' -X POST "https://$ACCOUNT.cloudant.com/_replicate" -d @replication-doc.json
# with the file replication-doc.json containing the required replication information.
```
{:codeblock}

_Example JSON document that describes the required replication:_

```json
{
	"source": "http://$ACCOUNT:$PASSWORD@username.cloudant.com/example-database",
	"target": "http://$ACCOUNT2:$PASSWORD2@example.org/example-target-database"
}
```
{:codeblock}

### Return Codes

Code  | Description
------|------------
`200` | Replication request successfully completed.
`202` | Continuous replication request has been accepted.
`404` | Either the source or target database was not found.
`500` | JSON specification was invalid.

### Canceling replication using the `/_replicate` endpoint

A replication that is triggered by `POST`ing to `/_replicate` can be canceled
by `POST`ing the exact same JSON object but with the additional `cancel` property set to `true`.

>	**Note**: If a replication is canceled,
the request that initiated the replication fails with [error 500 (shutdown)](http.html#500).

The replication ID can be obtained from the original replication request if it is a continuous replication.
Alternatively,
the replication ID can be obtained from [`/_active_tasks`](active_tasks.html).

_Example of using HTTP to cancel a replication:_

```http
POST /_replicate HTTP/1.1
Content-Type: application/json
```
{:codeblock}

_Example of using the command line to cancel a replication:_

```sh
curl -H 'Content-Type: application/json' -X POST 'https://$ACCOUNT.cloudant.com/_replicate HTTP/1.1' -d @replication-doc.json
# the file replication-doc.json must be supplied.
```
{:codeblock}

_Example JSON document that describes the replication to be canceled:_

```json
{
	"source": "https://$USERNAME:$PASSWORD@$ACCOUNT.cloudant.com/example-database",
	"target": "https://$USERNAME2:$PASSWORD2@example.org/example-database",
	"cancel": true
}
```
{:codeblock}

### Avoiding the `/_replicate` endpoint

>   **Note**: Use the [`_replicator` scheduler](#the-replication-scheduler) in preference to the `/_replicate` endpoint.

A significant reason is that if there was a problem during replication,
such as a stall,
timeout,
or application crash,
then a replication that is defined within the `_replicator` database is automatically restarted by the system.

If you defined a replication by sending a request to the `/_replicate` endpoint,
it cannot be restarted by the system if a problem occurs because the replication request does not persist.

In addition,
replications that are defined in the `_replicator` database are easier to [monitor](advanced_replication.html#replication-status).
