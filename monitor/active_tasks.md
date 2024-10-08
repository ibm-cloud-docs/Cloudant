---

copyright:
  years: 2015, 2022
lastupdated: "2022-08-04"

keywords: active tasks, compaction tasks, replication tasks, indexing tasks, specific response fields, retrieve active tasks 

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# Active tasks
{: #active-tasks}

The `/_active_tasks` endpoint provides a list of the tasks that are running on the server, which is helpful for [monitoring](/docs/Cloudant?topic=Cloudant-monitoring-an-ibm-cloudant-cluster#monitoring-an-ibm-cloudant-cluster) the performance of your system. 
{: shortdesc}

You can retrieve a list of active tasks, including compaction, replication, and indexing tasks. For more examples on using the `/_active_tasks` endpoint,
see the [Managing tasks](/docs/Cloudant?topic=Cloudant-managing-tasks#managing-tasks) guide.

## Retrieving a list of active tasks
{: #retrieving-a-list-of-active-tasks}

Method
:   `GET`    

Path
:   `/_active_tasks`    

Response
:   List of running tasks, including the task type, name, status, and process ID.    

Roles permitted 
:   `_admin`    

You can get a list of active tasks by using the `/_active_tasks` URL.
The result is a JSON array of the currently running tasks,
with each task described with a single object.

See the example request to retrieve a list of active tasks by using HTTP commands:

```HTTP
GET /_active_tasks HTTP/1.1
```
{: codeblock}

See the example request to retrieve a list of active tasks by using the command line:

```sh
curl "https://$ACCOUNT.cloudant.com/_active_tasks" \
	-u $ACCOUNT
```
{: codeblock}

The returned structure includes the following fields for each task:

| Name | Description |
|-----|------------| 
| `database` | The database and shard on which the operation occurs. |
| `pid` | Erlang Process ID |
| `started_on` | Time when the task was started. The value is an integer that includes the UNIX&trade; time UTC. |
| `total_changes` | Total number of documents to be processed by the task. The exact meaning depends on the type of the task. |
| `type` | Operation Type |
| `updated_on` | Time that the task status was updated. The field updates every few seconds. Returns the most recent update. |
{: caption="Fields in the returned structure" caption-side="top"}

In the `type` field,
the possible values include:

-   `database_compaction`
-   `view_compaction`
-   `replication`
-   `indexer`
-   `search_indexer`

The meaning of other fields in the JSON response depends on the type of the task.

See the example JSON response array that includes details of currently running tasks:

```json
[
	{
		"user": null,
		"updated_on": 1363274088,
		"type": "replication",
		"target": "https://repl:*****@tsm.cloudant.com/user-3dglstqg8aq0uunzimv4uiimy/",
		"docs_read": 0,
		"doc_write_failures": 0,
		"doc_id": "tsm-admin__to__user-3dglstqg8aq0uunzimv4uiimy",
		"continuous": true,
		"checkpointed_source_seq": "403-g1AAAADfeJzLYWBgYMlgTmGQS0lKzi9KdUhJMjTRyyrNSS3QS87JL01JzCvRy0styQGqY0pkSLL___9_VmIymg5TXDqSHIBkUj1YUxyaJkNcmvJYgCRDA5AC6tuflZhGrPsgGg9ANAJtzMkCAPFSStc",
		"changes_pending": 134,
		"pid": "<0.1781.4101>",
		"node": "dbcore@db11.julep.cloudant.net",
		"docs_written": 0,
		"missing_revisions_found": 0,
		"replication_id": "d0cdbfee50a80fd43e83a9f62ea650ad+continuous",
		"revisions_checked": 0,
		"source": "https://repl:*****@tsm.cloudant.com/tsm-admin/",
		"source_seq": "537-g1AAAADfeJzLYWBgYMlgTmGQS0lKzi9KdUhJMjTUyyrNSS3QS87JL01JzCvRy0styQGqY0pkSLL___9_VmI9mg4jXDqSHIBkUj1WTTityWMBkgwNQAqob39WYhextkE0HoBoBNo4MQsAFuVLVQ",
		"started_on": 1363274083
	},
	{
		"user": "acceptly",
		"updated_on": 1363273779,
		"type": "indexer",
		"node": "dbcore@db11.julep.cloudant.net",
		"pid": "<0.20723.4070>",
		"changes_done": 189,
		"database": "shards/00000000-3fffffff/acceptly/acceptly_my_chances_logs_live.1321035717",
		"design_document": "_design/MyChancesLogCohortReport",
		"started_on": 1363273094,
		"total_changes": 26389
	},
	{
		"user": "username",
		"updated_on": 1371118433,
		"type": "search_indexer",
		"total_changes": 5466,
		"node": "dbcore@db7.meritage.cloudant.net",
		"pid": "<0.29569.7037>",
		"changes_done": 4611,
		"database": "shards/40000000-7fffffff/username/database_name",
		"design_document": "_design/lucene",
		"index": "search1",
		"started_on": 1371118426
	},
	{
		"view": 1,
		"user": "acceptly",
		"updated_on": 1363273504,
		"type": "view_compaction",
		"total_changes": 26095,
		"node": "dbcore@db11.julep.cloudant.net",
		"pid": "<0.21218.4070>",
		"changes_done": 20000,
		"database": "shards/80000000-bfffffff/acceptly/acceptly_my_chances_logs_live.1321035717",
		"design_document": "_design/MyChancesLogCohortReport",
		"phase": "view",
		"started_on": 1363273094
	},
	{
		"updated_on": 1363274040,
		"node": "dbcore@db11.julep.cloudant.net",
		"pid": "<0.29256.4053>",
		"changes_done": 272195,
		"database": "shards/00000000-3fffffff/heroku/app3245179/id_f21a08b7005e_logs.1346083461",
		"started_on": 1363272496,
		"total_changes": 272195,
		"type": "database_compaction"
	}
]
```
{: codeblock}

### Specific response fields for compaction tasks
{: #specific-response-fields-for-compaction-tasks}

| Name | Description |
|-----|------------|
| `changes_done` | Number of documents compacted. |
| `phase` | Reports the stage of compaction. |
| `total_changes` | Number of documents in the database. |
{: caption="Response fields for compaction tasks" caption-side="top"}

In the `phase` field, the value indicates the stage that was reached by compaction:

`ids`
:  Document compaction is in progress.

`views`
:  View compaction is in progress.

### Specific response fields for replication tasks
{: #specific-response-fields-for-replication-tasks}

| Name | Description |
|-----|------------|
| `changes_pending` | Number of documents that need to be changed in the target database, expressed as an integer. |
| `continuous` | Boolean value that indicates whether the replication is continuous. |
| `docs_read` | Number of documents that are read from the source database, expressed as an integer. |
| `replication_id` | Unique identifier string of the replication that can be used to cancel the task. |
| `revisions_checked` | Number of document revisions that were checked to verify whether they're already in the target database. |
| `source` | An obfuscated URL string that indicates the database from which the task is replicating. |
| `target` | An obfuscated URL string that indicates the database to which the task is replicating. |
| `user` | User who started the replication, expressed as a string, or `null` if the replication was not initiated by a user. |
{: caption="Response fields for replication tasks" caption-side="top"}

### Specific response fields for indexing tasks
{: #specific-response-fields-for-indexing-tasks}

| Name | Description |
|-----|------------|
|`changes_done` | Number of document revisions that are processed by this task. A document can have one or more revisions. |
| `design_document` | The design document that includes the view or index function or functions. |
| `total_changes`| The number of unindexed changes to process. This count includes deleted documents, although these documents are automatically skipped by the indexer. |
{: caption="Response fields for indexing tasks" caption-side="top"}
