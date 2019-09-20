---

copyright:
  years: 2015, 2019
lastupdated: "2019-09-09"

keywords: incremental backups, create an incremental backup, restore a database, how to back up example, how to restore example

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

<!-- Acrolinx: 2019-09-09 -->

# Replication incrementals
{: #replication-incrementals}

The content in the Replication incrementals guide contains older or "deprecated" guidance on {{site.data.keyword.cloudantfull}} backup. For current backup guidance, see the [Disaster Recovery and Backup](/docs/services/Cloudant?topic=cloudant-disaster-recovery-and-backup#disaster-recovery-and-backup) guide.
{: deprecated}

Database backups protect your data against potential loss or corruption.
{: shortdesc}

You can use the {{site.data.keyword.cloudant_short_notm}} replication facility to create a database backup,
and store it on an {{site.data.keyword.cloudant_short_notm}} cluster.
You can then restore data,
entire databases,
or specific JSON documents,
from these backups to your production cluster.

Using {{site.data.keyword.cloudant_short_notm}} replication,
a database backup stores your database content to a checkpoint.
It's possible to 'roll back' to a specific checkpoint.
The checkpoint isn't specific to a precise time.
Instead,
it's a record of the database as it was after specific changes occurred during the backup period.
In this way,
a backup can preserve the state of your database at a selected time.

## Incremental backups
{: #incremental-backups}

If you're an Enterprise customer,
a daily incremental backup capability is available. For more information, see [Disaster recovery and backup](/docs/services/Cloudant?topic=cloudant-disaster-recovery-and-backup#disaster-recovery-and-backup).

If you're not an Enterprise customer,
or you prefer to create your own backups,
you can use the {{site.data.keyword.cloudant_short_notm}} replication facility to create a database backup.

A simple approach is to replicate the entire database to a dated backup database.
This method works and is easy to do.
But if you need backups for multiple points in time,
such as seven daily backups and four weekly ones,
you must store a complete copy of the database in each new backup database.
A complete copy might require significant disk usage,
especially if your database is large.

As an alternative,
incremental backups are a good solution for storing
only the documents that changed since the last backup.

The process is simple.
Initially,
you create a backup of the entire database.
After the first backup,
you run daily 'incremental' backups,
backing up *only* what changed in the database since the last backup.
This replication becomes a daily backup.

You can configure a backup to trigger at regular intervals.
However, each interval must be 24 hours or more. In other words, you can run daily backups but not hourly backups.
{: note}

## Creating an incremental backup
{: #creating-an-incremental-backup}

Incremental backups save only the differences or 'deltas' between backups.
Every 24 hours,
the source database is replicated to a target database.

Replication uses sequence values to identify the documents that were changed during the 24-hour period.
The backup operation works by using replication to get and store a checkpoint.
A checkpoint is another document with an internal name.
The backup operation creates the name from a combination of the date and the backup task name.
This name makes it easier to identify checkpoints during the recovery or roll up process.

To create an incremental backup,
do the following steps:

1.  Find the ID of the checkpoint document for the last replication.
    It's stored in the `_replication_id` field of the replication document,
    found in the `_replicator` database.
2.  Open the checkpoint document at `/$DATABASE/_local/$REPLICATION_ID`,
    where `$REPLICATION_ID` is the ID you found in the previous step,
    and `$DATABASE` is the name of the source or the target database.
    The document usually exists on both databases,
    but might exist only on one.
3.  Search for the `recorded_seq` field of the first element
    in the history array that is found in the checkpoint document.
4.  Replicate to the new incremental backup database,
    setting the [`since_seq` field](/docs/services/Cloudant?topic=cloudant-replication-api#the-since_seq-field)
    in the replication document to the value of the `recorded_seq` field found in the previous step.

By definition, if you use the `since_seq` option, it bypasses the normal checkpointing facility. Use `since_seq` with caution. 
{: note}

## Restoring a database
{: #restoring-a-database}

To restore a database from incremental backups,
you replicate each incremental backup to a new database,
starting with the most recent increment.

You might start with the oldest backup,
then apply the subsequent  backups in order.
However,
replicating from the most recent incremental backup first is faster
because updated documents are written only to the target database one time.
Any documents older than a copy already present in the new database are skipped.


## An example
{: #an-example}

This example shows how to run and restore a backup:

1.  Set up databases to use incremental backup.
2.  Run a full backup.
3.  Set up and run an incremental backup.
4.  Restore a backup.

### Constants that are used here
{: #constants-that-are-used-here}

```sh
# save base URL and the content type in shell variables
$ url="https://$ACCOUNT:$PASSWORD@$ACCOUNT.cloudant.com"
$ ct="Content-Type: application-json"
```
{: codeblock}

Assume that you need to back up one database.
You want to create a full backup on Monday,
and an incremental backup on Tuesday.

You can use the `curl` and [`jq`](http://stedolan.github.io/jq/){: new_window}{: external}
commands to run these operations.
In practice,
you might use any HTTP client.

### Step 1. Check that you have three databases
{: #step-1-check-that-you-have-three-databases}

For this example,
you require three databases:

-   The original database,
    holding the data that you want to back up.
-   Two incremental databases,
    for Monday (`backup-monday`) and Tuesday (`backup-tuesday`).

#### Example showing how to check that you have three databases to use in this example, by using HTTP

```http
PUT /original HTTP/1.1
PUT /backup-monday HTTP/1.1
PUT /backup-tuesday HTTP/1.1
```
{: codeblock}

#### Example showing how to check that you have three databases to use in this example,
by using the command line

```sh
$ curl -X PUT "${url}/original"
$ curl -X PUT "${url}/backup-monday"
$ curl -X PUT "${url}/backup-tuesday"
```
{: codeblock}

### Step 2. Create the `_replicator` database
{: #step-2-create-the-_replicator-database}

If it doesn't exist, create the `_replicator` database.

#### Creating the `_replicator` database by using HTTP

```http
PUT /_replicator HTTP/1.1
```
{: codeblock}

#### Creating the `_replicator` database by using the command line

```sh
curl -X PUT "${url}/_replicator"
```
{: pre}

### Step 3. Back up the entire (original) database
{: #step-3-back-up-the-entire-original-database}

On Monday,
you want to back up all your data for the first time.
Create this backup by replicating everything from `original` to `backup-monday`.

#### Running a full backup on Monday by using HTTP

```http
PUT /_replicator/full-backup-monday HTTP/1.1
Content-Type: application/json
```
{: codeblock}

#### Running a full backup on Monday by using the command line

```sh
$ curl -X PUT "${url}/_replicator/full-backup-monday" -H "$ct" -d @backup-monday.json
# where backup-monday.json describes the backup.
```
{: codeblock}

#### JSON document that describes the full backup
 
```json
{
    "_id": "full-backup-monday",
    "source": "${url}/original",
    "target": "${url}/backup-monday"
}
```
{: codeblock}

### Step 4. Prepare incremental backup part 1 - Get checkpoint ID
{: #step-4-prepare-incremental-backup-part-1-get-checkpoint-id}

On Tuesday,
you want to do an incremental backup,
rather than another full backup.

To start the incremental backup,
you need two values:

-   The checkpoint ID.
-   [The `recorded_seq` value](#step-5-prepare-incremental-backup-part-2-get-recorded_seq-value).

These values identify where the last backup ended,
and determine where to start the next incremental backup.
After you get these values, you can run the incremental backup.

You start by finding the checkpoint ID value.
This value is stored in the `_replication_id` field of the replication document,
within the `_replicator` database.

#### Getting the checkpoint ID to help find the `recorded_seq` value, by using HTTP

```http
GET /_replicator/full-backup-monday HTTP/1.1
# Search for the value of _replication_id
```
{: codeblock}

#### Getting the checkpoint ID to help find the `recorded_seq` value, by using the command line

```sh
replication_id=$(curl "${url}/_replicator/full-backup-monday" | jq -r '._replication_id')
```
{: pre}

### Step 5. Prepare incremental backup part 2 - Get `recorded_seq` value
{: #step-5-prepare-incremental-backup-part-2-get-recorded_seq-value}

After you get the checkpoint ID,
use it to get the `recorded_seq` value.
This value is found in the first element of the history array in the `/_local/${replication_id}` document,
within the original database.

You now have the `recorded_seq` value.
This value identifies the last document that was replicated from the original database.

#### Getting the `recorded_seq` from original database by using HTTP

```http
GET /original/_local/${replication_id} HTTP/1.1
# Search for the first value of recorded_seq in the history array
```
{: codeblock}

#### Getting the `recorded_seq` from original database by using the command line

```sh
recorded_seq=$(curl "${url}/original/_local/${replication_id}" | jq -r '.history[0].recorded_seq')
```
{: pre}

### Step 6. Run an incremental backup
{: #step-6-run-an-incremental-backup}

Now that you have the checkpoint ID and `recorded_seq`,
you can start Tuesday's incremental backup.
This backup replicates all the document changes made *since* the last replication.

When the replication finishes,
you have a completed incremental backup.
The backup consists of all the documents in the original database,
and can be restored by retrieving the content of both the `backup-monday` *and* `backup-tuesday` databases.

#### Running Tuesday's incremental backup by using HTTP

```http
PUT /_replicator/incr-backup-tuesday HTTP/1.1
Content-Type: application/json
```
{: codeblock}

#### Running Tuesday's incremental backup by using the command line

```sh
curl -X PUT "${url}/_replicator/incr-backup-tuesday" -H "${ct}" -d @backup-tuesday.json
```
{: pre}

#### JSON document that describes Tuesday's incremental backup
 
```json
{
    "_id": "incr-backup-tuesday",
    "source": "${url}/original",
    "target": "${url}/backup-tuesday",
    "since_seq": "${recorded_seq}"
}
```
{: codeblock}

### Step 7. Restore the Monday backup
{: #step-7-restore-the-monday-backup}

To restore from a backup,
you replicate the initial full backup,
and any incremental backups,
to a new database.

For example,
to restore Monday's state,
you would replicate from the `backup-monday` database.

#### Restoring from the `backup-monday` database by using HTTP

```sh
PUT /_replicator/restore-monday HTTP/1.1
Content-Type: application/json
```
{: codeblock}

#### Restoring from the `backup-monday` database by using the command line

```sh
curl -X PUT "${url}/_replicator/restore-monday" -H "$ct" -d @restore-monday.json
```
{: pre}

#### JSON document that describes the restore
 
```json
{
    "_id": "restore-monday",
    "source": "${url}/backup-monday",
    "target": "${url}/restore",
    "create_target": true  
}
```
{: codeblock}

### Step 8. Restore the Tuesday backup
{: #step-8-restore-the-tuesday-backup}

To restore Tuesday's database,
you first replicate from `backup-tuesday` and then from `backup-monday`.

The order isn't a typographical error; the intention really *is* to restore from Tuesday and *then* Monday.
{: tip}

You might restore in chronological sequence,
but by using the reverse order,
documents that were updated on Tuesday need to be written to the target database one time only.
Older versions of the document that are stored in the Monday database are ignored.

#### Restoring Tuesday's backup, getting the most recent changes first, by using HTTP

```http
PUT /_replicator/restore-tuesday HTTP/1.1
Content-Type: application/json
```
{: codeblock}

#### Restoring Tuesday's backup, getting the most recent changes first, by using the command line

```sh
curl -X PUT "${url}/_replicator/restore-tuesday" -H "$ct" -d @restore-tuesday.json
```
{: pre}

#### JSON document that requests restoration of the Tuesday backup
 
```json
{
    "_id": "restore-tuesday",
    "source": "${url}/backup-tuesday",
    "target": "${url}/restore",
    "create_target": true  
}
```
{: codeblock}

#### Complete the recovery by restoring Monday's backup last by using HTTP

```http
PUT /_replicator/restore-monday HTTP/1.1
Content-Type: application/json
```
{: codeblock}

#### Complete the recovery by restoring Monday's backup last by using the command line

```http
curl -X PUT "${url}/_replicator/restore-monday" -H "$ct" -d @restore-monday.json
```
{: pre}

#### JSON document that requests restoration of the Monday backup
 
```json
{
    "_id": "restore-monday",
    "source": "${url}/backup-monday",
    "target": "${url}/restore"
}
```
{: codeblock}

## Suggestions
{: #suggestions}

While the previous information outlines the basic backup process,
each application needs its own requirements and strategies for backups.
The following suggestions might be helpful.

### Scheduling backups
{: #scheduling-backups}

Replication jobs can significantly increase the load on a cluster.
If you're backing up several databases,
it's best to stagger the replication jobs for different times,
or to a time when the cluster is less busy.

#### Changing the IO priority of a backup
{: #changing-the-io-priority-of-a-backup}

You can change the priority of backup jobs
by adjusting the value of the `x-cloudant-io-priority` field within the replication document.

1.  In the source and target fields, change the `headers` object.
2.  In the headers object,
    change the `x-cloudant-io-priority` field value to `"low"`.

##### Example of JSON document that sets the IO priority

```json
{
    "source": {
        "url": "https://user:pass@example.com/db",
        "headers": {
            "x-cloudant-io-priority": "low"
        }
    },
    "target": {
        "url": "https://user:pass@example.net/db",
        "headers": {
            "x-cloudant-io-priority": "low"
        }
    }
}
```
{: codeblock}

### Backing up design documents
{: #backing-up-design-documents}

If you include design documents in your backup,
indexes are created on the backup destination.
This practice slows down the backup process and uses unnecessary amounts of disk space.
If you don't require indexes on your backup system,
use a filter function with your replications to filter out design documents.
You might also use this filter function to exclude other documents that aren't wanted.

### Backing up multiple databases
{: #backing-up-multiple-databases}

If your application uses one database per user,
or allows each user to create several databases,
you need to create a backup job for each new database.
Make sure that your replication jobs do not begin at the same time.

## Need help?
{: #need-help-}

Replication and backups can be tricky.
If you get stuck,
check out the [replication guide](/docs/services/Cloudant?topic=cloudant-replication-guide#replication-guide),
or contact the
[{{site.data.keyword.cloudant_short_notm}} support team](mailto:support@cloudant.com){: new_window}{: external}.
