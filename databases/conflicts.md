---

copyright:
  years: 2015, 2022
lastupdated: "2022-11-11"

keywords: find conflicts, resolve conflicts, merge changes, upload new revision, delete revision

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# Conflicts
{: #conflicts}

In distributed databases, copies of data might be stored in more than one location. The natural network and system characteristics of the network might mean that changes made to a
document stored in one location can't instantly update or replicate to other parts of the database.
{: shortdesc}

In other words,
independent updates can be made to different copies of documents. The effect of these updates might be to introduce disagreement or "conflicts" as to what is the correct, definitive content for the document.

{{site.data.keyword.cloudantfull}} tries to help you avoid conflicts by warning you of potential problems.
It warns you by returning a [`409` response](/apidocs/cloudant#list-of-http-codes){: external} to a problematic update request.
However,
a `409` response might not be received if the database update is requested on a
system that isn't currently connected to the network.
For example,
the database might be on a mobile device that is temporarily disconnected from
the Internet, which makes it impossible to check whether other potentially conflicting
updates were made.

If you request a document that is in a conflict situation,
{{site.data.keyword.cloudant_short_notm}} returns the document as expected.
However, an internal algorithm considers a number of factors before it determines which document version to return. You must not assume that the returned document is the most recent version.

For example, if you don't check for conflicts,
or fail to address them,
your {{site.data.keyword.cloudant_short_notm}} database can exhibit the following behaviors:

-   Increasing inconsistencies in document content because more conflicting documents occur.
-   Increasing database size because all conflicting documents must be kept until the conflict is resolved.
-   Decreasing performance because {{site.data.keyword.cloudant_short_notm}} must work harder in response to each request as it tries to identify the "best possible" version of a conflicted document.

The following suggested practices might help you decide when to check for, and resolve, conflicts:

| Application characteristic | Frequency of document update | Check for conflicts at retrieval? | Check for conflicts at update? |
|---------|---------|---------|----------|
| Always connected to the network, for example, a server. | Often | Y | - |
| Always connected to the network. | Occasionally | - | Y |
| Often but not always connected to the network, for example, a laptop. | Often | - | Y |
| Often but not always connected to the network. | Occasionally | - | Y | 
| Occasionally connected to the network, for example, a tablet. | Often | - | Y |
{: caption="Table 1. Suggested practices" caption-side="top"}

## Finding conflicts
{: #finding-conflicts}

To find any conflicts that might be affecting a document,
add the query parameter `conflicts=true` when you retrieve a document.
When returned,
the resulting document includes a `_conflicts` array,
which includes a list of all the conflicting revisions.

See the following example map function to find document conflicts:

```sh
function (doc) {
  if (doc._conflicts) {
    emit(null, [doc._rev].concat(doc._conflicts));
  }
}
```

To find conflicts for multiple documents in a database,
write a [view](/docs/Cloudant?topic=Cloudant-creating-views-mapreduce).
Using a map function such as the example provided,
you can find all the revisions for every document with a conflict.

When you have such a view,
you can use it to find and resolve conflicts as needed.
Alternatively,
you might query the view after each replication to identify and resolve conflicts immediately.

## How to resolve conflicts
{: #how-to-resolve-conflicts}

After you find a conflict, you can resolve it by following the four steps that are described next. 

- Get 
- Merge
- Upload
- Delete 

See the following example document of the first version:

```json
{
  "_id": "74b2be56045bed0c8c9d24b939000dbe",
  "_rev": "1-7438df87b632b312c53a08361a7c3299",
  "name": "Samsung Galaxy S4",
  "description": "",
  "price": 650
}
```

Let's consider a scenario for this example.
Suppose you have a database of products for an online shop.
The first version of a document might look like the example provided.

See the following second version (first revision) of the document that adds a description:

```json
{
  "_id": "74b2be56045bed0c8c9d24b939000dbe",
  "_rev": "2-61ae00e029d4f5edd2981841243ded13",
  "name": "Samsung Galaxy S4",
  "description": "Latest smartphone from Samsung",
  "price": 650
}
```

The document doesn't have a description yet,
so someone might add one.

See the following *alternative* second version that introduces a price reduction data change to the first version of the document:

```json
{
  "_id": "74b2be56045bed0c8c9d24b939000dbe",
  "_rev": "2-f796915a291b37254f6df8f6f3389121",
  "name": "Samsung Galaxy S4",
  "description": "",
  "price": 600
}
```

At the same time, someone else, working with a replicated database, reduces the price.
This change is made to the first version of the document.
Therefore,
the price reduction change doesn't "know" about the description change.

Later,
when the two databases are replicated,
it might not be clear which of the two alternative versions of the document is correct.
This example is a conflict scenario.

### Get conflicting revisions
{: #get-conflicting-revisions}

To find any conflicting revisions for a document,
retrieve that document as normal,
but include the `conflicts=true` parameter,
similar to the following example:

`https://ACCOUNT.cloudant.com/products/$_ID?conflicts=true`


See the following example response to document retrieval that shows conflicting revisions:

```json
{
  "_id":"74b2be56045bed0c8c9d24b939000dbe",
  "_rev":"2-f796915a291b37254f6df8f6f3389121",
  "name":"Samsung Galaxy S4",
  "description":"",
  "price":600,
  "_conflicts":["2-61ae00e029d4f5edd2981841243ded13"]
}
```

If the document has any conflicts,
you would get a response similar to the example provided,
which is based on the changed description or changed price problem.

The version with the changed price was chosen *arbitrarily* as the latest version of the document.
Do not assume that the most recently updated version of the document is the latest version for conflict resolution purposes.

In this example,
consider a conflict between the retrieved document, which has the `_rev` value `2-f796915a291b37254f6df8f6f3389121`,
and another document, which has the `_rev` value `2-61ae00e029d4f5edd2981841243ded13`.
The conflicting document details are noted in the `_conflicts` array.

Often,
you might find that the array has only one element,
but it's possible for there to be many conflicting revisions. Each revision is listed in the array.

### Merge the changes
{: #merge-the-changes-conflicts}

Your application must identify all the potential changes,
and reconcile them,
effectively merging the correct and valid updates to produce a single,
non-conflicting version of the document.

To compare the revisions and identify what changed,
your application must retrieve all the versions from the database.
You begin by retrieving a document and details of any conflicting versions.
To start the retrieval, use a command similar to the following one,
which also requests the `_conflicts` array:

`https://$ACCOUNT.cloudant.com/products/$_ID?conflicts=true`

This retrieval gives you a current version of the document that you store,
*and* a list of all the other conflicting documents that must also be retrieved,
for example `...rev=2-61ae00e029d4f5edd2981841243ded13` and `...rev=1-7438df87b632b312c53a08361a7c3299`.
Each of these other conflicting versions is also retrieved and stored,
for example:

   `https://$ACCOUNT.cloudant.com/products/$_ID?rev=2-61ae00e029d4f5edd2981841243ded13`
   `https://$ACCOUNT.cloudant.com/products/$_ID?rev=1-7438df87b632b312c53a08361a7c3299`

Once you have all of the conflicting revisions of a document available,
you can resolve the conflicts.

In an earlier scenario,
the differences between the versions of the document were for different fields within the document,
making it easier to merge them.

More complicated conflicts are likely to require correspondingly more analysis.
To help,
you might choose from various conflict resolution strategies,
such as:

-	Time based - uses a simple test of the first or most recent edit.
-	User assessment - the conflicts are reported to users, who then decide on the best resolution.
-	Sophisticated merging algorithms - often used with [version control systems](https://en.wikipedia.org/wiki/Merge_%28version_control%29). An example is the [3-way merge](https://en.wikipedia.org/wiki/Merge_%28version_control%29#Three-way_merge).

For a practical example of how to implement these changes, see [this project with sample code](https://github.com/glynnbird/deconflict).

### Upload the new revision
{: #upload-the-new-revision}

See the following final revisions after you resolve and merge changes from the previous conflicting revisions:

```json
{
  "_id": "74b2be56045bed0c8c9d24b939000dbe",
  "_rev": "3-daaecd7213301a1ad5493186d6916755",
  "name": "Samsung Galaxy S4",
  "description": "Latest smartphone from Samsung",
  "price": 600
}
```

After you assess and resolve the conflicts,
you create a document that includes the current and definitive data.
This fresh document is uploaded into the database.

### Delete old revisions
{: #delete-old-revisions-conflicts}

See the following example requests to delete the old revisions:

```https
DELETE https://$ACCOUNT.cloudant.com/products/$_ID?rev=2-61ae00e029d4f5edd2981841243ded13

DELETE https://$ACCOUNT.cloudant.com/products/$_ID?rev=2-f796915a291b37254f6df8f6f3389121
```

In the final step, you delete the old revisions.
You delete the old revisions by sending a `DELETE` request,
specifying the revisions to delete.

When the older versions of a document are deleted,
the conflicts that are associated with that document are marked as resolved.
You can verify that no conflicts remain by requesting the document again. 
Set the `conflicts` parameter to true, and use
[find conflicts](#finding-conflicts) as before.
