---

copyright:
  years: 2015, 2022
lastupdated: "2022-06-22"

keywords: create document, update document, read document, bulk operations, tombstone documents

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# "Tombstone" documents
{: #tombstone-docs}

Tombstone documents are small documents that are kept in place within a database when the original document is deleted.
Their purpose is to allow the deletion to be replicated.

When the replication completes,
the tombstones are no longer required.
Automatic compaction helps ensure that only the minimal amount of data is kept and transferred during replication.
Nevertheless,
tombstone documents aren't automatically removed ("d").

Over time,
as documents are created and deleted,
the number of tombstone documents increases.
Each tombstone is small,
but gradually they add to database disk space usage,
and to the query time for the primary index.
To reduce these effects,
you might want to remove the tombstones.

## Simple removal of "tombstone" documents
{: #simple-removal-of-tombstone-documents}

To remove tombstones manually,
do the following steps:

1.	Create a database to hold the required documents.

   The new database is intended to hold all documents except the tombstone documents.
1.	Set up a [filtered replication](/docs/Cloudant?topic=Cloudant-advanced-replication#filtered-replication-adv-repl) to replicate documents from the original database to the new database.

   Configure the filter so that documents with the "`_deleted`" attribute aren't replicated.
1.	When replication is complete, switch your application logic to use the new database.

1.	Verify that your applications work correctly with the new database.

   When you're satisfied that everything is working correctly, you might want to delete the old database.

In general, try to design and implement your applications to do the minimum necessary amount of deletion.
{: tip}

See an example filter to exclude deleted documents during a replication:

```json
{
	"_id": "_design/filters",
	"filters": {
		"deleted_filter": "function(doc, req) { return !doc._deleted; };"
	}
}
```
{: codeblock}

## Advanced removal of tombstone documents
{: #advanced-removal-of-tombstone-documents}

The [simple removal technique](#simple-removal-of-tombstone-documents) works well,
if documents aren't being updated in the source database while the replication takes place.

If updates are made during replication,
it's possible that a complete document is replicated to the target database as normal,
and is also deleted from the source database,
leaving a tombstone.
The problem is that the tombstone is not replicated across to the target database 
because the tombstone is excluded by the filter.
Therefore,
the document that was deleted from the source database is not deleted from the target database,
causing an inconsistency.

A solution is to do more advanced removal of tombstones by using
a [`validate_doc_update` function](http://docs.couchdb.org/en/1.6.1/couchapp/ddocs.html#validate-document-update-functions){: external}.

A `validate_doc_update` function is stored in a design document.
The function is run every time that a document is updated in the database.
The function can be used to prevent invalid or unauthorized document updates.

The function works by using the following parameters:

-   The new version of the document.
-   The current version of the document in the database.
-   A user context, which provides details about the user that supplied the updated document.

The function inspects the request to determine whether the update is allowed to proceed. If the update is acceptable, the function returns. If the update is not acceptable, a suitable error object is returned.
In particular, if the user is not authorized to make the update,
an `unauthorized` error object is returned, along with an explanatory error message. Similarly, the requested update might not be allowed for some reason, such as when some mandatory fields are absent from the new document. In that case, a `forbidden` error object is returned,
again with an explanatory error message.

For tombstone removal,
a suitable `validate_doc_update` function would work as follows:

1.   If the update is to apply a change to an existing document (`oldDoc`) within the target database, the function allows the change by returning.

   The reason is that the update affected a document that was copied to the target database during the replication, but then changed in the source database during the replication. 
   It's possible that the change was a `DELETE`, resulting in a tombstone record in the target database.
   The tombstone record is removed by a subsequent replication process at some point in the future.
2.   The target database does not have a copy of the current document, and the document to be updated has the `_deleted` property (indicating that it's a tombstone). Therefore, the updated document must be a tombstone and was encountered before, so the update to the target database must be rejected.

See an example JavaScript `validate_doc_update` function to reject deleted documents not already present in the target database:

```javascript
function(newDoc, oldDoc, userCtx) {
	// any update to an existing doc is OK
	if(oldDoc) {
		return;
	}

	// reject tombstones for docs we don’t know about
	if(newDoc["_deleted"]) {
		throw({forbidden : "Deleted document rejected"});
	}

	return; // Not strictly necessary, but clearer.
}
```
{: codeblock}

To use a `validate_doc_update` function to remove tombstone documents:

1.   Stop replication from the source to the target database.
1.   If appropriate, delete the target database, then create a new target database.
1.   Add a suitable `validate_doc_update` function, similar to the example provided.
1.   Add it to a design document in the target database.
1.   Restart replication between the source and the (new) target database.
1.   When replication is complete, switch your application logic to use the new database.
1.   Verify that your applications work correctly with the new database.

   When you're satisfied that everything is working correctly, you might want to delete the old database.

Here is another variation for using the `validate_doc_update` function to remove tombstone documents if possible.

1.   Add some metadata to the tombstone documents, for example, to record the deletion date.
1.   Use the function to inspect the metadata and allow deletion documents through if they must be applied to the target database.

This check helps ensure correct replication of the deletion.

## Performance implications of tombstone removal
{: #performance-implications-of-tombstone-removal}

Tombstones are used for more consistent deletion of documents from databases.
This purpose is especially important for mobile devices:
without tombstone documents,
a deletion might not replicate correctly to a mobile device,
with the result that documents might never be deleted from the device.

If you re-create a database, for example, a new target for a replication. Any clients that use the target database as a server must work through all the changes again because the database sequence numbers are likely to be different.

If you're using a `validate_doc_update` function, avoid replicating that function to clients. This rule is to prevent the possibility of unwanted side effects that result from having the function present on the client.
{: tip}

[{{site.data.keyword.cloudant_short_notm}} sync](/docs/Cloudant?topic=Cloudant-client-libraries#mobile-supported) libraries don't replicate design documents, so replication of `validate_doc_update` functions is not normally a problem for {{site.data.keyword.cloudant_short_notm}}.
However, other clients might replicate the design documents or `validate_doc_update` functions, potentially resulting in unwanted side effects.
{: note}

