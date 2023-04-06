---

copyright:
  years: 2015, 2023
lastupdated: "2023-04-04"

keywords: performance options, attachments, filtered replication, replication scheduler, cancel replication, replication database maintenance, /_scheduler/docs endpoint, $doc_id endpoint, /_scheduler/jobs endpoint, $job_id endpoint

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# Advanced replication
{: #advanced-replication}

You can learn about advanced replication concepts and tasks, such as the ones in the following list and more:

- Maintaining your replication database
- Scheduling and monitoring replications
- Authenticating during replication
{: shortdesc}

You might also find it helpful to review details of the underlying
[replication protocol](https://docs.couchdb.org/en/stable/replication/protocol.html){: external},
and review the [API reference](/apidocs/cloudant#introduction){: external} documentation.

## Replication database maintenance
{: #replication-database-maintenance}

A replication database must be monitored like any other database.
Without regular database maintenance,
you might accumulate invalid documents that were caused by interruptions to the replication process.
Having many invalid documents can result in an excess load on your cluster
when the replicator process is restarted by {{site.data.keyword.cloudantfull}} operations.

To maintain a replication database, remove old documents. 
You can remove old documents by determining their age
and [deleting them](/docs/Cloudant?topic=Cloudant-documents#delete-a-document) if they're no longer needed.

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

1.  `initializing` - The replication was added to the scheduler, but isn't yet initialized or scheduled to run. The status occurs when a new or updated replication document is stored within the [`_replicator` database](/docs/Cloudant?topic=Cloudant-replication-api#the-replicator-database). 
2.  `error` - The replication can't be turned into a job. This error might be caused in several different ways. For example, the replication must be [filtered](/docs/Cloudant?topic=Cloudant-design-documents#filter-functions), but it wasn't possible to fetch the filter code from the source database.
3.  `pending` - The replication job is scheduled to run, but isn't yet running.
4.  `running` - The replication job is running.
5.  `crashing` - A temporary error occurred that affects the replication job. The job is automatically retried later.
6.  `completed` - The replication job completed. This state doesn't apply to [continuous replications](/docs/Cloudant?topic=Cloudant-replication-api#continuous-replication).
7.  `failed`- The replication job failed. The failure is permanent. This state means that no further attempt is made to replicate by using this replication task. The failure might be caused in several different ways, for example, if the source or target URLs aren't valid.

The transition between these states is illustrated in the following diagram:

![The transition between states is `Pending`, `Running`, `Crashing`, and `Completed`.](../images/fb85704.svg "Replication Scheduler states"){: caption="Figure 1. Replication Scheduler states" caption-side="bottom"}

The scheduler introduces two new endpoints:

- [`/_scheduler/docs`](/apidocs/cloudant#getschedulerdocs){: external}
- [`/_scheduler/jobs`](/apidocs/cloudant#getschedulerjobs){: external}

You can manage and determine replication status more quickly and easily by using these endpoints.

See the typical process for using the replication scheduler to manage and monitor replications:

1.  Create a [replication document](/apidocs/cloudant#putreplicationdocument){: external} that describes the needed replication, and store the document in the [replicator database](/docs/Cloudant?topic=Cloudant-replication-api#the-replicator-database).
2.  Monitor the status of the replication by using the `/_scheduler/docs` endpoint.

## Authentication during replication
{: #authentication-during-replication}

In any production application, security of the source and target databases is essential.
In order for replication to continue, authentication is necessary to access the databases.
Checkpoints for replication are [enabled by default](/apidocs/cloudant#postreplicate){: external},
which means that replicating the source database requires write access.

To enable authentication during replication,
include a username and password in the database URL.
The replication process uses the supplied values for HTTP Basic Authentication.

See the following example of specifying username and password values for accessing source and target databases during replication:

```json
{
	"source": "https://$USERNAME:$PASSWORD@example.com/db", 
	"target": "https://$USERNAME:$PASSWORD@$ACCOUNT.cloudant.com/db"
}
```
{: codeblock}

## Filtered replication
{: #filtered-replication-adv-repl}

Sometimes you don't want to transfer all documents from source to target.
To choose which documents to transfer,
include one or more filter functions in a design document on the source.
You can then tell the replicator to use these filter functions.

Filtering documents during replication is similar to the process of
[filtering the `_changes` feed](/docs/Cloudant?topic=Cloudant-design-documents#filter-functions).
{: tip}

A filter function takes two arguments:

-	The document to be replicated.
-	The replication request.

A filter function returns a `true` or `false` value.
If the result is true,
the document is replicated.

To set up filtering, use the `selector` field whenever possible. When you use the `selector` field, you can specify a filter without having to replicate the entire database. This method makes filtering faster and causes less load on {{site.data.keyword.cloudant_short_notm}}. For more information, see the [`selector` field](/apidocs/cloudant#postfind){: external} documentation. 

See the following example of a filter function:

```javascript
function(doc, req) {
	return !!(doc.type && doc.type == "foo");
}
```
{: codeblock}

Filters are stored under the topmost `filters` key of the design document.

See the following example of storing a filter function in a design document:

```json
{
	"_id": "_design/myddoc",
	"filters": {
		"myfilter": "function goes here"
	}
}
```
{: codeblock}

A filtered replication is started by using a JSON statement that identifies the following items:

-	The source database.
-	The target database.
-	The name of the filter that is stored under the `filters` key of the design document.

See example JSON for starting a filtered replication:

```json
{
	"source": "https://$USERNAME:$PASSWORD@example.org/example-database",
	"target": "https://$USERNAME:$PASSWORD@$ACCOUNT.cloudant.com/example-database",
	"filter": "myddoc/myfilter"
}
```
{: codeblock}

Arguments can be supplied to the filter function by
including key: value pairs in the `query_params` field of the invocation.

See example JSON for starting a filtered replication with supplied parameters:

```json
{
	"source": "https://$USERNAME:$PASSWORD@example.org/example-database",
	"target": "https://$USERNAME:$PASSWORD@$ACCOUNT.cloudant.com/example-database",
	"filter": "myddoc/myfilter",
	"query_params": {
		"key": "value"
	}
}
```
{: codeblock}

The `selector` option provides performance benefits when compared with using the `filter` option. Use the `selector` option whenever possible. For more information, see the [`selector`](/apidocs/cloudant#postfind){: external} documentation.

### Eliminating conflicts that use replication
{: #eliminate-conflicts-using-replication}

Use the `winning_revs_only: true` option to replicate *winning* document
revisions only. These revisions are the revisions that would be returned by the `GET
$ACCOUNT/$DATABASE/$DOCID` API endpoint by default, or appear in the
`_changes` feed with the default parameters.

```json
{
	"source": "https://$USERNAME:$PASSWORD@example.org/example-database",
	"target": "https://$USERNAME:$PASSWORD@$ACCOUNT.cloudant.com/example-database",
	"winning_revs_only": true
}
```
{: codeblock}

Replication with this mode discards conflicting revisions, so it might be one
way to remove conflicts through replication.

Replication IDs and checkpoint IDs, generated by `winning_revs_only: true`
replications are different than those replications generated by default, so it is possible to first replicate the winning revisions, then later, to
*backfill* the rest of the revisions with a regular replication job.

The `winning_revs_only: true` option can be combined with filters or other
options like `continuous: true` or `create_target: true`.


## Named document replication
{: #named-document-replication}

Sometimes you don't want to replicate documents.
For simple replications,
you don't need to write a filter function.
Instead,
to replicate specific documents,
add the list of keys as an array in the `doc_ids` field.

See the following example replication of specific documents:

```json
{
	"source": "https://$USERNAME:$PASSWORD@example.org/example-database",
	"target": "https://$USERNAME:$PASSWORD@127.0.0.1:5984/example-database",
	"doc_ids": ["foo", "bar", "baz"]
}
```
{: codeblock}

## Replicating through a proxy
{: #replicating-through-a-proxy}

If you want replication to pass through an HTTP proxy,
provide the proxy details in the `proxy` field of the replication data.

See the following example that shows replication through a proxy:

```json
{
	"source": "https://$USERNAME:$PASSWORD@$ACCOUNT.cloudant.com/example-database",
	"target": "https://$USERNAME:$PASSWORD@example.org/example-database",
	"proxy": "https://my-proxy.com:8888"
}
```
{: codeblock}

## The `user_ctx` property and delegations
{: #the-user_ctx-property-and-delegations}

Replication documents can have a custom `user_ctx` property.
This property defines the user context under which a replication runs.

An older way of triggering replications,
by making a `POST` to the `/_replicate/` endpoint,
didn't need the `user_ctx` property.
The reason is that at the moment of triggering the replication,
all the necessary information about the authenticated user is available.

By contrast,
the replicator database is a regular database.
The information about the authenticated user is only present
at the moment that the replication document is written to the database.
In other words,
the replicator database implementation is similar to a `_changes` feed consumption application, 
with `?include_docs=true` set.

For replication, this implementation difference means that for nonadmin users,
a `user_ctx` property that includes the user's name and a subset of their roles
must be defined in the replication document.
This requirement is addressed by a validation function present in the default design document of the replicator database.
The function validates each document update.
This validation function also ensures that a nonadmin user can't set a username property in the `user_ctx` property
that doesn't correspond to the correct username.
The same principle also applies for roles.

See the following example delegated replication document:

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

The empty list of roles means that design documents aren't written to local targets during replication.
If you want to write design documents to local targets,
then a user context with the `_admin` role must be set explicitly.

Also,
for admins,
the `user_ctx` property can be used to trigger a replication for another user.
This user context is passed to local target database document validation functions.

The `user_ctx` property applies to local endpoints only.
{: note}

In summary,
for admins, the `user_ctx` property is optional. While for regular (nonadmin) users, it's mandatory.
When the roles property of `user_ctx` is missing,
it defaults to the empty list `[ ]`.

## Performance-related options
{: #performance-related-options}

Several performance-related options can be set for a replication,
by including them in the replication document.

`use_bulk_get`
:   Set to `true` to improve replication job performance. A replication fetches documents in batches from the source. The increased replication rate can consume the source and target account capacity quicker, and result in concurrent nonreplication requests on those accounts to experience more
429 HTTP errors.

`connection_timeout` 
:   The maximum period of inactivity for a connection in milliseconds. If a connection is idle for this period, its current request is retried. Default value is 30000 milliseconds (30 seconds).

`http_connections` 
:   The maximum number of HTTP connections per replication. For push replications, the effective number of HTTP connections that are used is `min(worker_processes + 1, http_connections)`. For pull replications, the effective number of connections that are used corresponds to this parameter's value. Default value is 20.

`retries_per_request` 
:   The maximum number of retries per request.
Before a retry, the replicator waits for a short period before it repeats the request. This period doubles between each consecutive retry, and never goes beyond 5 minutes. The minimum value before the first retry is 0.25 seconds. The default value is 10 retries.

`socket_options` 
:   A list of options to pass to the connection sockets. The available options can be found in the
[documentation for the Erlang function `setopts` of the `inet` module](https://www.erlang.org/doc/man/inet.html#setopts-2){: external}. Default value is `[{keepalive, true},{nodelay, false}]`.

`worker_batch_size` 
:   Worker processes run batches of replication tasks, where the batch size is defined by this parameter. The size corresponds to the number of `_changes` feed rows. Larger values for the batch size might result in better performance. Smaller values mean that checkpointing is done more frequently. Default value is 500.

`worker_processes` 
:   The number of processes the replicator uses in each replication task to transfer documents from the source to the target database. Higher values might produce better throughput because of greater parallelism in network and disk IO activities, but this improvement comes at the cost of requiring more memory and potentially CPU time. Default value is 4.

See the following example that includes performance options in a replication document:

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
see [Performance considerations](/docs/Cloudant?topic=Cloudant-attachments#performance-considerations).

### Avoiding the `/_replicate` endpoint
{: #avoiding-the-replicate-endpoint}

Use the [`_replicator` scheduler](#the-replication-scheduler) instead of the `/_replicate` endpoint.
{: important}

If a problem occurs during replication, such as a stall, timeout, or application crash,
a replication that is defined within the `_replicator` database is automatically restarted by the system. However, if you define a replication by sending a request to the `/_replicate` endpoint, it can't be restarted by the system if a problem occurs because the replication request doesn't persist. Replications that are defined in the `_replicator` database are easier to monitor.
