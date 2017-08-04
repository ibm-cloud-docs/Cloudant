## Conflicts

In a distributed databases,
where copies of data might be stored in more than one location,
natural network and system characteristics might mean that changes made to a
document stored in one location cannot instantly update or replicate to other parts of the database.

In other words,
if independent updates are made to different copies of documents,
the effect might be to introduce disagreement or 'conflicts' as to what is the correct,
definitive content for the document.

Cloudant tries to help you avoid conflicts by warning you of potential problems.
It does this by returning a [`409` response](http.html#409) to a problematic update request.
However,
a `409` response might not be received if the database update is requested on a
system that is not currently connected to the network.
For example,
the database might be on a mobile device that is temporarily disconnected from
the Internet,
making it impossible at that moment to check if other potentially conflicting
updates have been made.

If you request a document that is in a conflict situation,
Cloudant returns the document as expected.
However,
the version returned is determined by an internal algorithm that considers a
number of factors;
you should not assume that the returned document is always the most recent version,
for example.

If you do not check for conflicts,
or fail to address them,
your Cloudant database begins to exhibit several behaviors:

* Increasing inconsistencies in document content, because there are more and more conflicting documents.
* Increasing database size, because all conflicting documents must be retained until the conflict is resolved.
* Decreasing performance, because Cloudant must work harder in response to each and every request as it tries to identify the 'best possible' version of a conflicted document.

The following suggested practices might help you decide when to check for,
and resolve,
conflicts:

<table>
<tr>
<th>Application characteristic</th>
<th>Frequency of document update</th>
<th>Check for conflicts at retrieval?</th>
<th>Check for conflicts at update?</th>
</tr>
<tr>
<td>Always connected to the network, for example a server.</td>
<td>Often</td>
<td>Y</td>
<td>-</td>
</tr>
<tr>
<td>Always connected to the network.</td>
<td>Occasionally</td>
<td>-</td>
<td>Y</td>
</tr>
<tr>
<td>Often but not always connected to the network, for example a laptop.</td>
<td>Often</td>
<td>-</td>
<td>Y</td>
</tr>
<tr>
<td>Often but not always connected to the network.</td>
<td>Occasionally</td>
<td>-</td>
<td>Y</td>
</tr>
<tr>
<td>Occasionally connected to the network, for example a tablet.</td>
<td>Often</td>
<td>-</td>
<td>Y</td>
</tr>
</table>

### Finding conflicts

To find any conflicts that might be affecting a document,
add the query parameter `conflicts=true` when retrieving a document.
When returned,
the resulting document contains a `_conflicts` array,
which includes a list of all the conflicting revisions.

<div></div>

> Example map function to find document conflicts:

```
function (doc) {
  if (doc._conflicts) {
    emit(null, [doc._rev].concat(doc._conflicts));
  }
}
```

To find conflicts for multiple documents in a database,
write a [view](creating_views.html).
Using a map function such as the example provided,
you can find all the revisions for every document with a conflict.

When you have such a view,
you can use it to find and resolve conflicts as needed.
Alternatively,
you might query the view after each replication to identify and resolve conflicts immediately.

### How to resolve conflicts

Once you've found a conflict, you can resolve it by following 4 steps:

1.	[Get](conflicts.html#get-conflicting-revisions) the conflicting revisions.
2.	[Merge](conflicts.html#merge-the-changes) them in your application or ask the user what they want to do.
3.	[Upload](conflicts.html#upload-the-new-revision) the new revision.
4.	[Delete](conflicts.html#delete-old-revisions) the old revisions.

<div></div>

> Example document - the first version.

```json
{
  "_id": "74b2be56045bed0c8c9d24b939000dbe",
  "_rev": "1-7438df87b632b312c53a08361a7c3299",
  "name": "Samsung Galaxy S4",
  "description": "",
  "price": 650
}
```

Let's consider an example of how this can be done.
Suppose you have a database of products for an online shop.
The first version of a document might look like the example provided.

<div></div>

> Second version (first revision) of the document, adding a description.

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

<div></div>

> _Alternative_ second version, introducing a price reduction data change to the first version of the document.

```json
{
  "_id": "74b2be56045bed0c8c9d24b939000dbe",
  "_rev": "2-f796915a291b37254f6df8f6f3389121",
  "name": "Samsung Galaxy S4",
  "description": "",
  "price": 600
}
```

At the same time, someone else - working with a replicated database - reduces the price.
This change is made to the first version of the document.
Therefore,
the price reduction change does not 'know' about the description change.

Later,
when the two databases are replicated,
it might not be clear which of the two alternative versions of the document is correct.
This is a conflict scenario.

### Get conflicting revisions

To find any conflicting revisions for a document,
retrieve that document as normal,
but include the `conflicts=true` parameter,
similar to the following example:

`http://$USERNAME.cloudant.com/products/$_ID?conflicts=true`

<div></div>

> Example response to document retrieval, showing conflicting revisions

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

The version with the changed price has been chosen _arbitrarily_ as the latest version of the document.
You should not assume that the most recently updated version of the document is considered to be the latest version for conflict resolution purposes.

In this example,
a conflict is considered to exist between the retrieved document which has the `_rev` value `2-f796915a291b37254f6df8f6f3389121`,
and another document which has the `_rev` value `2-61ae00e029d4f5edd2981841243ded13`.
The conflicting document details are noted in the `_conflicts` array.

Often,
you might find that the array has only one element,
but it is possible for there to be many conflicting revisions,
each of which is listed in the array.

### Merge the changes

Your application must identify all the potential changes,
and reconcile them,
effectively merging the correct and valid updates to produce a single,
non-conflicting version of the document.

To compare the revisions and identify what has been changed,
your application must retrieve all of the versions from the database.
As described previously,
we begin by retrieving a document and details of any conflicting versions.
We do this using a command similar to the following,
which also requests the `_conflicts` array:

`http://$USERNAME.cloudant.com/products/$_ID?conflicts=true`

This retrieval gives us a current version of the document which we store,
_and_ a list of all the other conflicting documents that must also be retrieved,
for example `...rev=2-61ae00e029d4f5edd2981841243ded13` and `...rev=1-7438df87b632b312c53a08361a7c3299`.
Each of these other conflicting versions is also retrieved and stored,
for example:

  `http://$USERNAME.cloudant.com/products/$_ID?rev=2-61ae00e029d4f5edd2981841243ded13`
  `http://$USERNAME.cloudant.com/products/$_ID?rev=1-7438df87b632b312c53a08361a7c3299`

Once you have all of the conflicting revisions of a document available,
you can proceed to resolve the conflicts.

In our earlier scenario,
the differences between the versions of the document were for different fields within the document,
making it easier to merge them.

More complicated conflicts are likely to require correspondingly more analysis.
To help,
you might choose from a variety of different conflict resolution strategies,
such as:

*	Time based: using a simple test of the first or most recent edit.
*	User assessment: the conflicts are reported to users, who then decide on the best resolution.
*	Sophisticated merging algorithms: these are often used in [version control systems](https://en.wikipedia.org/wiki/Merge_%28version_control%29). An example is the [3-way merge](https://en.wikipedia.org/wiki/Merge_%28version_control%29#Three-way_merge).

For a practical example of how to implement these changes, see [this project with sample code](https://github.com/glynnbird/deconflict).

### Upload the new revision

> Final revision, after resolving and merging changes from the previous conflicting revisions.

```json
{
  "_id": "74b2be56045bed0c8c9d24b939000dbe",
  "_rev": "3-daaecd7213301a1ad5493186d6916755",
  "name": "Samsung Galaxy S4",
  "description": "Latest smartphone from Samsung",
  "price": 600
}
```

After assessing and resolving the conflicts,
you create a document containing the current and definitive data.
This fresh document is uploaded into the database.

### Delete old revisions

> Example requests to delete the old revisions.

```http
DELETE http://$USERNAME.cloudant.com/products/$_ID?rev=2-61ae00e029d4f5edd2981841243ded13

DELETE http://$USERNAME.cloudant.com/products/$_ID?rev=2-f796915a291b37254f6df8f6f3389121
```

The final step is where you delete the old revisions.
You do this by sending a `DELETE` request,
specifying the revisions to delete.

When the older versions of a document are deleted,
the conflicts associated with that document are marked as resolved.
You can verify that no conflicts remain by requesting the document again,
with the `conflicts` parameter set to true,
[as before](conflicts.html#finding-conflicts).
