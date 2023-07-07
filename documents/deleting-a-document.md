---

copyright:
  years: 2015, 2022
lastupdated: "2022-12-22"

keywords: create document, update document, read document, bulk operations, tombstone documents

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# Deleting a document
{: #delete-a-doc}

The steps shown here demonstrate how to delete a document.

1. Send a `DELETE` request with the document's most recent `_rev` in the query string.
2. Run the following command: `https://$ACCOUNT.cloudant.com/$DATABASE/$DOCUMENT_ID`. 
   The response contains the ID and the new revision of the document, or an error message if the delete failed.

If you fail to provide the most recent `_rev`, {{site.data.keyword.cloudant_short_notm}} responds with a [409 error](/apidocs/cloudant#list-of-http-codes){: external}. This error prevents you overwriting data that were changed by other clients. If the write [quorum](#quorum-writing-and-reading-data) can't be met, a [`202` response](/apidocs/cloudant#list-of-http-codes){: external} is returned.
{: note}

{{site.data.keyword.cloudant_short_notm}} doesn't completely delete the specified document. Instead, it leaves a [tombstone](#tombstone-documents) with basic information about the document. The tombstone is required so that the delete action can be replicated to other copies of the database. Since the tombstones stay in the database indefinitely,
creating new documents and deleting them increases the disk space usage of a database. They might also increase the query time for the primary index, which is used to look up documents by their ID.

The following steps show you how to delete a request by using HTTP.

1. Send a `DELETE` request with the document's most recent `_rev` in the query string by using HTTP.

2. Run the following command: `DELETE /$DATABASE/$DOCUMENT_ID?rev=$REV HTTP/1.1`.

The following code examples show you how to delete a document by using the command line. 

```sh
# make sure $JSON contains the correct `_rev` value!

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

All Go examples require the `service` object to be initialized. For more information, see the API documentation's [Authentication section](/apidocs/cloudant?code=go#authentication-with-external-configuration) for examples. 
{: go}

See an example response after a successful deletion request.

```json
{
  "id": "exampleid",
  "ok": true,
  "rev": "2-056f5f44046ecafc08a2bc2b9c229e20"
}
```
{: codeblock}

After a document has been deleted, you might find that it is still there but has a different [revision](https://cloud.ibm.com/docs/Cloudant?topic=Cloudant-document-versioning-and-mvcc#revisions).
That happens when you delete a document that has live [conflicts](https://cloud.ibm.com/docs/Cloudant?topic=Cloudant-conflicts).

When a document has live conflicts, that means it has more than one live revision. 
When a document has more than one live revision one of the live revisions is the winning revision.
When the winning revision of a document with live conflicts is deleted, another of the live revisions becomes the winning revision.
When the new winning revision is deleted, if there are any more live revisions of the document one of the remaining live revisions becomes the new winning revision. And so on until all the live revisions of the document have been deleted.
