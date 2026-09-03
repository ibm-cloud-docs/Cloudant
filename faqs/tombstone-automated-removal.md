---

copyright:
  years: 2026
lastupdated: "2026-09-03"

keywords: tombstone, delete

subcollection: Cloudant

content-type: faq

---

{{site.data.keyword.attribute-definition-list}}

# Automatic cleanup of deleted documents (tombstones)
{: #faq-enabling-automatic-removal-of-document-tombstones}

Cloudant now removes retained internal metadata about deleted documents (called tombstones) after 90 days to improve the performance of index building, replication, and changes feed followers.
{: shortdesc}

## What is Cloudant changing?
{: #what-is-cloudant-changing}

Deleted documents in Cloudant leave behind metadata known as a "tombstone", to mark the place where document previously existed. The tombstone information is used during replication to replicate details of deleted documents. Other than this, the information serves no purpose.

Previous versions of Cloudant retained tombstone data forever.

Retaining this metadata indefinitely could cause performance impacts when the numbers of tombstones greatly outnumber the live documents in a single database. The purpose of this change is to remove this problem.

Cloudant now guarantees that deleted document metadata remains for a minimum of **90 days**, after which time it is completely removed from Cloudant. The timing of removal isn't exact — it may take place a few days after the 90 day cutoff.

**Most likely impact**: replications and `_changes` consumers offline beyond 90 days will permanently miss some deletes. See [Potential impacts on your applications](#potential-customer-impacts) for guidance on mitigating this impact.
{: faq}

## What is the roll-out schedule?
{: #roll-out-schedule}

Cloudant will begin automatic cleanup in the second half of 2026.

After the feature is enabled, all metadata for documents that were fully deleted more than 90 days ago will start to be removed. To avoid excessive resource use, removal speed is throttled, so it will be some weeks before the initial cleanup is complete and a steady state is reached.
{: faq}

## What documents will be affected by the change?
{: #what-documents-are-affected}

Only metadata about *fully deleted* documents will be removed.

A high-level definition of *fully deleted* is: if a `GET` request for the document returns `404`, it is *fully deleted*.

For most users, this simple rule suffices. For advanced cases involving conflicts, here's how it works under the hood.

Documents can have multiple internal branches due to replication conflicts. During [conflict resolution](/docs/Cloudant?topic=Cloudant-conflicts#how-to-resolve-conflicts), each deleted branch is marked with *tombstones*, leaving a single *live* branch.

Knowing this, here's the precise definition for advanced users: a document is *fully deleted* only when there are no remaining live branches.
{: faq}

## When does the 90-day retention period start?
{: #when-does-retention-period-start}

It is measured from the HTTP `DELETE` operation that removes the last live branch of a document. In the absence of conflicts, documents have a single branch.

For documents with multiple branches or conflicts, the retention period starts from the write that removes the last live branch, making the document fully deleted. Conflict resolution that leaves at least one live branch does **not** start the retention period; only when all branches are deleted does the timer begin.
{: faq}

## How long after 90 days will removal actually occur?
{: #how-long-after-90-days}

Typically, they are removed between one and seven days after the 90 day cutoff.
{: faq}

## Can customers opt out?
{: #can-customers-opt-out}

Customers cannot opt out of this automatic cleanup.
{: faq}

## How does this affect audit and compliance needs?
{: #audit-and-compliance}

Customers relying on tombstones as a way to record deletion of data should instead use Cloudant's [audit log capabilities](/docs/Cloudant?topic=Cloudant-at_events) to record this information. This requires Audit logs to be configured to emit **Data events**, which is not the default configuration.
{: faq}

## What are tombstones?
{: #what-are-tombstones}

Tombstones are small pieces of metadata that are used to mark branches in Cloudant's internal document tree as deleted. They are a special document revision that exists at the end of the branch that contains no data. They take up less than 100 bytes of storage space.

The cleanup process involves completely removing these tombstone document revisions and all other metadata Cloudant stores about the document.

Although discouraged, the Cloudant API does allow a user to store data in deleted documents. This data will also be removed by the cleanup process. There is more detail below on how to mitigate this problem if you are affected.
{: faq}

## Why is Cloudant starting to automatically remove tombstones?
{: #why-remove-tombstones}

Cloudant databases with a high level of document turnover can suffer from performance impacts when the number of deletions becomes sufficiently high.

Tombstones are transparent to most customers. They replicate deletions between databases without requiring any customer action.

The only times customers need to know about tombstones is when tombstones are causing issues with a database. This occurs when there is a buildup of tombstones, sometimes over many years.

Although this affects only a small number of customers, previously the only remedy was to create a new database and use filtered replication to copy only live documents.
{: faq}

## When do tombstones become a problem for databases?
{: #when-do-tombstones-become-a-problem}

Tombstones are very small documents, so you need a lot of them to cause problems. They start to become a problem when your database contains several tens or hundreds of millions of tombstones.
{: faq}

## Potential impacts on your applications
{: #potential-customer-impacts}

There are three scenarios which may be impacted by this change:

1. Replications that are often offline for extended periods.
1. Applications following `_changes` that are often offline for extended periods.
1. Applications which use specific APIs to store information in deleted documents (a very unusual pattern).

### How does this affect replications?
{: #impact-on-replications}

Because the metadata records the deletion event, after it is removed the deletion event is no longer stored in the database.

For replications, this means that if a replication is resumed after the metadata has been removed, that replication will never learn of the delete, and so it will not be replicated.

If it is essential to see all deletes, which it almost always is, replications must be run more often than every 90 days. This ensures that they process all changes and record a new checkpoint document to resume from that is newer than 90 days old.
{: faq}

### How does this affect applications using `_changes` for change data capture?
{: #impact-on-changes-followers}

Similarly to replications, if a changes follower is resumed after retained deletion metadata has been removed (that is, after 90 days + removal window) then the change data capture application will never see that delete.

If it is essential to see all deletes, applications using `_changes` must ensure that they read and process changes, and store their updated `_changes` sequence value, more often than every 90 days.

Applications may want to consider alerts for extended outages if it is possible they will cross the retention threshold.
{: faq}

### How does this affect customers that store data in tombstones?
{: #impact-on-data-in-tombstones}

No known customers use Cloudant in the way detailed below, but this scenario is listed here for completeness.

The safe way to delete Cloudant documents is by using the HTTP `DELETE` verb. However, using specific API calls, it is possible for customers to store data in tombstone document revisions. Although these documents are not retrievable using common APIs, they can be retrieved if their ID and revision ID are known. This usage is strongly discouraged.

Fully deleted documents that have had user data added to tombstone records will still be cleaned up by this process and the data will be lost.
{: important}

If you use this approach and wish to retain the data currently in tombstone revisions, you will need to:

1. Update your data model to use a *soft-delete* approach. This is done in two main ways:
    - A user-field (that is, `deleted` rather than the reserved `_deleted`) in the document indicates the document is deleted. Typically, these soft-delete documents have all normal data fields removed, and instead record customer deletion metadata, such as delete timestamp and reason.
    - Alternatively, use a separate database for "deleted" documents. Again, remove normal data fields and instead just include your own deletion metadata like deletion timestamp.
1. Run a migration process to retrieve all deleted documents, extract your data from the tombstone record and create a new, soft-deleted document to store the data.
1. Update all indexes to exclude soft-deleted documents.
    - Views and Search indexes can use guards in JavaScript indexing functions.
    - Cloudant Query indexes can use partial indexes.
{: faq}

## Advanced concerns
{: #advanced-concerns}

### If a document is deleted and later re-created with the same ID, what happens?
{: #deleted-and-recreated-document}

Creating a new version of a deleted document is internally represented as an update to the old document. So, in this case, the 90 day timer is reset; the tombstone metadata for the "old" version of the document are kept.
{: faq}

### Will the tombstone removal process affect database performance?
{: #impact-on-database-performance}

Cloudant has carried out extensive testing to validate that database performance is not affected by cleanup processing. Cleanup is a continuous process that does not result in spikes of activity.
{: faq}

### Will tombstone removal affect data storage bills?
{: #impact-on-storage-bills}

Customers may see small reductions in storage bills. The data used by deletion metadata is only a few bytes, so unless a database contains many millions of deleted documents, the reclaimed space will be very small.
{: faq}

### How can customers monitor tombstone removal?
{: #monitoring-tombstone-removal}

The `doc_del_count` field returned when [retrieving information about a database](/docs/apis/cloudant/cloudant-gen1#getdatabaseinformation){: external} will decrease as the cleanup process removes the deleted document metadata.
{: faq}

### Does this affect indexes (views, search, Cloudant query)?
{: #impact-on-indexes}

The behaviour of indexes will not change.

Fully deleted documents do not appear in indexes, and the removal process ensures all indexes are up to date before cleaning up deletion metadata for each document.

New indexes will build faster after removal of tombstones because the indexer is fed from the database's changes feed, which will contain fewer changes after the tombstones are removed.
{: faq}

### Are design documents and other system documents treated the same?
{: #design-and-system-documents}

Certain data resides in special documents in Cloudant:

- `_design` documents are subject to the removal process if fully deleted.
- `_local` documents are not subject to the removal process.

The following can appear document-like, but are in fact not documents so are not affected by the removal process:

- `_security` objects/properties.
{: faq}

### Will APIs expose cleanup status or removal timing?
{: #apis-for-cleanup-status}

Cloudant currently does not plan APIs for customers to view this information.
{: faq}
