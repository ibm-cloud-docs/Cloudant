---

copyright:
  years: 2015, 2022
lastupdated: "2022-10-31"

keywords: revisions, distributed databases, conflicts, resolve conflicts, find conflicting revisions, merge changes, upload new revisions, delete old revisions

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# Document versioning and MVCC
{: #document-versioning-and-mvcc}

[Multi-version concurrency control (MVCC)](https://en.wikipedia.org/wiki/Multiversion_concurrency_control){: external}
is how {{site.data.keyword.cloudantfull}} databases ensures that all of the nodes in a database's cluster contain
only the [newest version](/docs/Cloudant?topic=Cloudant-documents) of a document.
{: shortdesc}

Since {{site.data.keyword.cloudant_short_notm}} databases are [eventually consistent](/docs/Cloudant?topic=Cloudant-cap-theorem),
it is necessary to prevent inconsistencies from arising between nodes
as a result of synchronizing between outdated documents.

Multi-Version Concurrency Control (MVCC) enables concurrent read and write access to an {{site.data.keyword.cloudant_short_notm}} database.
MVCC is a form of [optimistic concurrency](http://en.wikipedia.org/wiki/Optimistic_concurrency_control){: external}.
It makes both read and write operations on {{site.data.keyword.cloudant_short_notm}} databases faster because
the database locks on either read or write operations isn't necessary.
MVCC also enables synchronization between {{site.data.keyword.cloudant_short_notm}} database nodes.

## Revisions
{: #revisions}

Every document in an {{site.data.keyword.cloudant_short_notm}} database has a `_rev` field that indicates its revision number.

A revision number is added to your documents by the server when you insert or modify them.
The number is included in the server response when you make changes or read a document.
The `_rev` value is constructed by using a combination of a simple counter and a hash of the document.

The two main uses of the revision number are to help:

1.  Determine what documents must be replicated between servers.
2.  Confirm that a client is trying to modify the latest version of a document.

You must specify the previous `_rev` when you [update a document](/docs/Cloudant?topic=Cloudant-documents#update)
or else your request fails and returns a [409 error](/apidocs/cloudant#list-of-http-codes){: external}.

`_rev` must not be used to build a version control system because it is an internal value that is used by the server. Therefore, older revisions of a document are transient, and removed regularly.
{: note}

However, you can query a particular revision by using its `_rev`, but
older revisions are regularly deleted by a process called
[compaction](http://en.wikipedia.org/wiki/Data_compaction){: external}. You can query a particular document revision
by using its `_rev` in order to obtain a history of revisions to your document. However, a consequence of compaction is that
you cannot rely on a successful response. If you need a version history of your documents,
a solution is to [create a new document](/docs/Cloudant?topic=Cloudant-documents#create-document) for each revision.

## Distributed databases and conflicts
{: #distributed-databases-and-conflicts}

Distributed databases work without a constant connection to the main database on {{site.data.keyword.cloudant_short_notm}},
which is itself distributed,
so updates based on the same previous version can still be in conflict.

To find conflicts,
add the query parameter [`conflicts=true`](/docs/Cloudant?topic=Cloudant-databases#get-changes) when you retrieve a document.
The response contains a `_conflicts` array with all conflicting revisions.

To find conflicts for multiple documents in a database,
write a view.

The following map function is an example that emits all conflicting revisions for every document that has a conflict.

See the following example of a map function to find documents with a conflict:

```javascript
function (doc) {
    if (doc._conflicts) {
        emit(null, [doc._rev].concat(doc._conflicts));
    }
}
```
{: codeblock}

You might regularly query this view and resolve conflicts as needed,
or query the view after each replication.

## Steps to resolve conflicts
{: #steps-to-resolve-conflicts}

After you find a conflict,
you can resolve it in four steps: get, merge, upload, and delete, as shown later.

Let's consider an example of how to resolve a conflict.
Suppose that you have a database of products for an online shop.
The first version of a document might look like the following example:

```json
{
    "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "1-7438df87b632b312c53a08361a7c3299",
    "name": "Samsung Galaxy S4",
    "description": "",
    "price": 650
}
```
{: codeblock}

As the document doesn't have a description yet,
someone might add one.

See the second version of the document, which is created by adding a description:

```json
{
    "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "2-61ae00e029d4f5edd2981841243ded13",
    "name": "Samsung Galaxy S4",
    "description": "Latest smartphone from Samsung",
    "price": 650
}
```
{: codeblock}

At the same time, someone else - working with a replicated database - reduces the price.

See a different revision, conflicting with the previous one because of different `price` value:

```json
{
    "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "2-f796915a291b37254f6df8f6f3389121",
    "name": "Samsung Galaxy S4",
    "description": "",
    "price": 600
}
```
{: codeblock}

The two databases are then replicated.
The difference in document versions results in a conflict.

### Get conflicting revisions
{: #get-conflicting-revisions-mvcc}

You identify documents with conflicts by using the `conflicts=true` option.

See the following example of finding documents with conflicts:

```https
https://$ACCOUNT.cloudant.com/products/$_ID?conflicts=true
```
{: codeblock}

See the following example response that shows conflicting revisions that affect documents:

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
{: codeblock}

The version with the changed price was chosen arbitrarily as the latest version of the document. The conflict with another version is noted by providing the ID of that other version in the `_conflicts` array.
In most cases, this array has only one element,
but many conflicting revisions might exist.

### Merge the changes
{: #merge-the-changes-mvcc}

To compare the revisions to see what changed,
your application gets all of the versions from the database.

See the following example commands to retrieve all versions of a document from the database:

```https
https://$ACCOUNT.cloudant.com/products/$_ID
https://$ACCOUNT.cloudant.com/products/$_ID?rev=2-61ae00e029d4f5edd2981841243ded13
https://$ACCOUNT.cloudant.com/products/$_ID?rev=1-7438df87b632b312c53a08361a7c3299
```
{: codeblock}

Since the conflicting changes are for different fields of the document,
it is easy to merge them.

For more complex conflicts,
other resolution strategies might be required:

-   Time based - use the first or last edit.
-   User intervention - report conflicts to users and let them decide on the best resolution.
-   Sophisticated algorithms - for example, 3-way merges of text fields.

For a practical example of how to implement a merge of changes,
see this project with [sample code](https://github.com/glynnbird/deconflict){: external}.

### Upload the new revision
{: #upload-the-new-revision-mvcc}

The next step is to create a document that resolves the conflicts,
and update the database with it.

See the following example document that merges changes from the two conflicting revisions:

```json
{
    "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "3-daaecd7213301a1ad5493186d6916755",
    "name": "Samsung Galaxy S4",
    "description": "Latest smartphone from Samsung",
    "price": 600
}
```
{: codeblock}

### Delete old revisions
{: #delete-old-revisions-mvcc}

Finally,
you delete the old revisions by sending a `DELETE` request to the URLs with the revision you want to delete.

See the following example request to delete an old document revision by using HTTP:

```http
DELETE https://$ACCOUNT.cloudant.com/products/$_ID?rev=2-61ae00e029d4f5edd2981841243ded13
```
{: codeblock}

See the following example request to delete an old document revision:

```sh
curl -H "Authorization: Bearer $API_BEARER_TOKEN" -X DELETE "$SERVICE_URL/events/0007241142412418284?rev=2-9a0d1cd9f40472509e9aac6461837367"
```
{: codeblock}
{: curl}

```java
import com.ibm.cloud.cloudant.v1.Cloudant;
import com.ibm.cloud.cloudant.v1.model.DeleteDocumentOptions;
import com.ibm.cloud.cloudant.v1.model.DocumentResult;

Cloudant service = Cloudant.newInstance();

DeleteDocumentOptions documentOptions =
    new DeleteDocumentOptions.Builder()
        .db("events")
        .docId("0007241142412418284")
        .rev("2-9a0d1cd9f40472509e9aac6461837367")
        .build();

DocumentResult response =
    service.deleteDocument(documentOptions).execute()
        .getResult();

System.out.println(response);
```
{: codeblock}
{: java}

```javascript
const { CloudantV1 } = require('@ibm-cloud/cloudant');
const service = CloudantV1.newInstance({});

service.deleteDocument({
  db: 'events',
  docId: '0007241142412418284',
  rev: '2-9a0d1cd9f40472509e9aac6461837367'
}).then(response => {
  console.log(response.result);
});
```
{: codeblock}
{: javascript}

```python
from ibmcloudant.cloudant_v1 import CloudantV1

service = CloudantV1.new_instance()

response = service.delete_document(
  db='events',
  doc_id='0007241142412418284',
  rev='2-9a0d1cd9f40472509e9aac6461837367'
).get_result()

print(response)
```
{: codeblock}
{: python}

```go
deleteDocumentOptions := service.NewDeleteDocumentOptions(
  "events",
  "0007241142412418284",
)
deleteDocumentOptions.SetRev("2-9a0d1cd9f40472509e9aac6461837367")

documentResult, response, err := service.DeleteDocument(deleteDocumentOptions)
if err != nil {
  panic(err)
}

b, _ := json.MarshalIndent(documentResult, "", "  ")
fmt.Println(string(b))
```
{: codeblock}
{: go}

The previous Go example requires the following import block:
{: go}

```go
import (
   "encoding/json"
   "fmt"
   "github.com/IBM/cloudant-go-sdk/cloudantv1"
)
```
{: codeblock}
{: go}

All Go examples require the `service` object to be initialized. For more information, see the API documentation's [Authentication section](https://cloud.ibm.com/apidocs/cloudant?code=go#authentication-with-external-configuration) for examples. 
{: go}

Now,
conflicts affecting the document are resolved.
You can verify the status by running `GET` to the document again with the `conflicts` parameter set to `true`.
