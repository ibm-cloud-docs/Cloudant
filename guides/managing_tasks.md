---

copyright:
  years: 2015, 2019
lastupdated: "2019-12-24"

keywords: curl and jq basics, monitor view builds and search indexes, estimate time to complete task, monitor replication, troubleshooting

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

<!-- Acrolinx: 2019-12-24 -->

# Managing tasks
{: #managing-tasks}

Creating new indexes over lots of data or replicating a large database can take quite a while.
{: shortdesc}

So how can you determine whether your tasks are progressing,
or if they've completed?
The [`_active_tasks` endpoint](/docs/services/Cloudant?topic=cloudant-active-tasks#active-tasks) provides information about all ongoing tasks.
However,
if you start numerous tasks,
some of them might be scheduled to run later and don't show up under `_active_tasks`
until they start.

In this guide, you learn how to use the `_active_tasks` endpoint to monitor long-running tasks.
The `curl` command is used to access the endpoint.
The `jq` command-line JSON processor is used to process the JSON response.

This task-focused tutorial covers only what is essential to accomplish this task.
For more information, see the [API reference](/docs/services/Cloudant?topic=cloudant-api-reference-overview#api-reference-overview) for a complete guide to the available options.

## `curl` and `jq` basics
{: #curl-and-jq-basics}

To get all active tasks and format the output nicely,
call your account by using `curl`,
and pipe the output to `jq`.

With `jq`, you filter a list of documents by their field values.
This filter makes it easier to get all replication documents,
or the details of just one particular view indexing task.
The API reference has more information about the options.

### Example of obtaining and formatting a list of active tasks

```sh
curl "https://$USERNAME:$PASSWORD@$USERNAME.cloudant.com/_active_tasks" | jq '.'
```
{: codeblock}

## Monitoring view builds and search indexes
{: #monitoring-view-builds-and-search-indexes}

View indexes are rebuilt when a design document is updated.
An update to any one of the views causes all the views in the document to be rebuilt.

Search indexes are rebuilt only when their corresponding index function is changed.
For each search index that is built and for each design document with views that are changed,
a new task is created for each replica and each shard in a cluster.

For example,
if there are 24 shards,
with three replicas each,
and you update two search indexes,
then 24 x 3 x 2 = 144 tasks run.

To find all the view indexing tasks,
pipe the `curl` output to `jq`,
and let it filter the documents in the array by their type field.
A corresponding command works for search indexing tasks.

In each case,
the results of searching for a list of indexing tasks is a list of JSON objects:
one for each of the active tasks found.

### Example of finding all view indexing tasks by filtering for the `indexer` type

```sh
curl -s "https://$USERNAME:$PASSWORD@$USERNAME.cloudant.com/_active_tasks" | jq '.[] | select(.type=="indexer")'
```
{: codeblock}

### Example of finding all search indexing tasks by filtering for the `search_indexer` type

```sh
curl -s "https://$USERNAME:$PASSWORD@$USERNAME.cloudant.com/_active_tasks" | jq '.[] | select(.type=="search_indexer")'
```
{: codeblock}

### Example results after you search for view indexing tasks

```json
{
    "total_changes": 6435,
    "started_on": 1371118332,
    "user": "username",
    "updated_on": 1371118334,
    "type": "indexer",
    "node": "dbcore@db6.meritage.cloudant.net",
    "pid": "<0.16366.6103>",
    "changes_done": 364,
    "database": "shards/40000000-7fffffff/username/database",
    "design_document": "_design/ngrams"
}
```
{: codeblock}

## Estimating the time to complete a task
{: #estimating-the-time-to-complete-a-task}

To estimate the time needed until the indexing task is complete,
monitor the number of `changes_done` and compare this value to `total_changes`.
For example,
if `changes_done` advances by 250 per second,
and `total_changes` is 1,000,000,
the task is expected to take 1,000,000 / 250 = 4,000 seconds,
or about 66 minutes,to complete.

Estimates of the time to complete an indexing task can't be 100% right. The actual time to complete the task depends on the following factors:

-   The time that it takes to process each document.
    For instance,
    a view might check the type of document first,
    and emit new index entries for only one type.
-   The size of the documents.
-   The current workload on the cluster.

You must assume that these factors might combine to produce considerable inaccuracy in your estimate.

*Example of extracting the `changes_done` field by using `jq`:*

```sh
curl ... | jq '.[] | select(.type=="search_indexer") | .changes_done'
```
{: codeblock}

## Monitoring replication
{: #monitoring-replication}

To find all replication tasks,
pipe the `curl` output to `jq`,
and filter the documents in the array by their type field.

To make it easier to select the information about a replication process from the list of active tasks,
start the replication process by creating a document in the `_replicator` database,
and set its `_id` field to a known value.

### Example of finding all replication tasks, by filtering for the `replication` type

```sh
curl -s "https://$USERNAME:$PASSWORD@$USERNAME.cloudant.com/_active_tasks" | jq '.[] | select(.type=="replication")'
```
{: codeblock}

### Example of finding a specific replication task, by filtering for a known document identity

```sh
curl ... | jq '.[] | select(.doc_id=="ID")'
```
{: codeblock}

### Example of finding a specific replication task, by filtering for a known `replication_id`

```sh
curl ... | jq '.[] | select(.replication_id=="ID")'
```
{: codeblock}

### Example result after you search for a replication task

```json
{
    "started_on": 1371094220,
    "source_seq": "62960-sakdjflksdfjsdlkafjalskdfjlsakfjlasdkjksald",
    "source": "",
    "revisions_checked": 12,
    "continuous": true,
    "doc_id": null,
    "doc_write_failures": 0,
    "docs_read": 12,
    "target": "",
    "type": "replication",
    "updated_on": 1371118477,
    "user": "username",
    "checkpointed_source_seq": "61764-dskfjalsfjsalkfjssadjfhasdfkjhsdkfhsdkf",
    "changes_pending": 1196,
    "pid": "<0.9955.4120>",
    "node": "dbcore@db7.meritage.cloudant.net",
    "docs_written": 12,
    "missing_revisions_found": 12,
    "replication_id": "asfksdlfkjsadkfjsdalkfjas+continuous+create_target"
}
```
{: codeblock}

## Troubleshooting stuck tasks
{: #troubleshooting-stuck-tasks}

### Is a task stuck?
{: #is-a-task-stuck-}

For a one-off,
non-continuous replication,
where the source database isn't updated significantly during the replication,
the `changes_pending` value shows how many documents remain to be processed.
Therefore, the `changes_pending` value is good indicator of when the replication is likely to be finished.

For a continuous replication,
you're more interested in how the number of documents processed changes over time,
and whether the `changes_pending` value increases.
If `changes_pending` increases,
but `revisions_checked` stays constant for a while,
the replication is probably stalled.
If `changes_pending` increases,
and `revisions_checked` also increases,
these increases might indicate that the replication can't keep up with the volume of data added to,
or updated in,
the database.

### What to do about a stuck task?
{: #what-to-do-about-a-stuck-task-}

To resolve a stalled replication,
you might have to [cancel the replication process](/docs/services/Cloudant?topic=cloudant-replication-api#canceling-a-replication) and start it again.

If that doesn't help,
the replication might be stalled because the user who is accessing the source or target databases
doesn't have write permissions.

Replication uses [checkpoints](/docs/services/Cloudant?topic=cloudant-replication-guide#checkpoints), which means that content that is already replicated and unchanged doesn't have to be replicated again if the replication is restarted.
{: note}

If you created the replication process by creating a document in the `_replicator` database,
you can also check the status of the replication there.
