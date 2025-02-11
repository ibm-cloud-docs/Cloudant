---

copyright:
  years: 2015, 2022
lastupdated: "2022-06-23"


keywords: replication operation, _replicator database, replication document format, create, cancel, monitor, single replication, continuous replication, replication errors

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# {{site.data.keyword.cloudant_short_notm}} Replication
{: #replication-api}

{{site.data.keyword.cloudantfull}} replication is the process that synchronizes the state of two databases.
{: shortdesc}

Any change that occurred in the source database is reproduced in the target database.
You can create replications between any number of databases, either continuously or as a "one off" task.

Depending on your application requirements,
you use replication to share and aggregate state and content.

Replication takes place in one direction only.
To keep two databases synchronized with each other,
you must replicate in both directions.
Complete this process by replicating from `database1` to `database2`,
and separately from `database2` to `database1`.

First, when replication finishes, all active documents in the source database also exist in the destination or "target" database. Second, documents that are deleted from the source database are also removed from the destination database (if they exist there). 

## Replication operation
{: #replication-operation}

Replication has two forms: push or pull replication:

- *Push replication* - where the source is a local database, and the destination is a remote database.
- *Pull replication* - where the source is a remote database instance, and the destination is the local database.

Pull replication is helpful if your source database has a permanent IP address,
and your destination database is local and has a dynamically assigned IP address,
for example, obtained through DHCP.
Pull replication is appropriate if you are replicating to a mobile or other device from a central server.

In all cases,
the requested databases in the source and target specification must exist.
If they do not,
an error is returned within the JSON object.

See the following example request to replicate between a database on the source server `example.com`, and a target database on {{site.data.keyword.cloudant_short_notm}}.

```http
POST /_replicate
Content-Type: application/json
Accept: application/json

{
  "source" : "https://$USERNAME1:$PASSWORD1@example.com/db",
  "target" : "https://$USERNAME2:$PASSWORD2@$ACCOUNT2.cloudant.com/db",
}
```
{: codeblock}

See the following example error response if one of the requested databases for a replication does not exist.

```json
{
  "error" : "db_not_found",
  "reason" : "could not open https://example.com/db/"
}
```
{: codeblock}

## Continuous replication
{: #continuous-replication}

By default,
the synchronization of a database during replication happens one time when the replicate request is made.
To ensure that replication from the source database to the target database takes place continually,
set the `continuous` field of the JSON object within the request to `true`.

With continuous replication,
changes in the source database are replicated to the target database forever 
until you specifically cancel the replication.

Changes are replicated between the two databases
while a network connection is available between the two instances.

When in operation,
the replication process does not stop when it finishes processing all current updates.
Instead,
the replication process continues to wait for further updates to the source database,
and applies them to the target.

Continuous replication forces checks to be made continuously on the source database. These checks result in an increasing number of database accesses, even if the source database content did not change. Database accesses are counted as part of the work that is done within a multi-tenant database configuration.
{: note}

## The `_replicator` database
{: #the-replicator-database}

The `_replicator` database is a special database within your account,
where you can `PUT` or `POST` replication documents to specify the replications you want.

Before you start a replication, you must create the `_replicator` database. 
To create a database, send a `PUT` request to:

```http
https://$ACCOUNT.cloudant.com/_replicator
```
For more information, see [Databases](/docs/Cloudant?topic=Cloudant-databases).

To cancel a replication,
you `DELETE` the replication document.
The fields that are supplied in the replication document are
described in the [Create or modify a replication operation](/apidocs/cloudant#postreplicate){: external} description under Request information.

All design documents and `_local` documents that are added to the `/_replicator` database are ignored.
{: note}

## Important notes
{: #important-notes}

- Replications can severely impact the performance of an {{site.data.keyword.cloudant_short_notm}} instance. Performance testing helps you understand the impact on your environment under an increasing number of concurrent replications.
- [Continuous replication](#continuous-replication) can result in many internal calls. Requiring many calls might affect the costs for multi-tenant users of {{site.data.keyword.cloudant_short_notm}} systems. By default, continuous replication is not enabled.
- The target database must exist. It is not automatically created if it does not exist. Add `"create_target":true` to the JSON document that describes the replication if the target database does not exist before replication. For more information, see [Creating a target database during replication](#creating-a-target-database-during-replication).
- Replicator databases must be maintained and looked after, just like any other valuable data store. For more information, see [replication database maintenance](/docs/Cloudant?topic=Cloudant-advanced-replication#replication-database-maintenance).
  
For security purposes, the {{site.data.keyword.cloudant_short_notm}} team recommends that you use IAM API keys or {{site.data.keyword.cloudant_short_notm}} legacy authentication [API keys](/docs/Cloudant?topic=Cloudant-work-with-your-account#api-keys) rather than account-level credentials for replication jobs. For more information, see the [IAM guide](/docs/Cloudant?topic=Cloudant-managing-access-for-cloudant) or the legacy [Authentication API document](/docs/Cloudant?topic=Cloudant-work-with-your-account#authentication) and the legacy [Authorization API document](/docs/Cloudant?topic=Cloudant-work-with-your-account#authorization).
{: important}
