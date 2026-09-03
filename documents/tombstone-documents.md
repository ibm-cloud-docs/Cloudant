---

copyright:
  years: 2015, 2026
lastupdated: "2026-09-03"

keywords: create document, update document, read document, bulk operations, tombstone documents

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# "Tombstone" documents
{: #tombstone-docs}

Tombstone documents are small documents that are kept in place within a database when the original document is deleted.
Their purpose is to allow the deletion to be replicated.
{: shortdesc}

The tombstone is kept for 90 days from the moment of deletion, after which the tombstone document is _completely removed_. This allows enough time for replicating parties to be notified of the document's removal, while keeping a cap on the number of deleted documents in the database.

The process of harvesting tombstones older than 90 days is automatic and runs in the background. The only visible sign will be that `doc_del_count` will be decremented for each tombstone removed.

As tombstones are automatically removed, users do not need to take any action to remove tombstones. In applications that routinely delete documents, the `doc_del_count` will settle to a number which represents the number of documents deleted in the last 90 days.

For more information, see [Automatic cleanup of deleted documents (tombstones)](/docs/Cloudant?topic=Cloudant-faq-enabling-automatic-removal-of-document-tombstones).
