---

copyright:
  years: 2015, 2022
lastupdated: "2022-03-23"

keywords: create document, update document, read document, bulk operations, tombstone documents

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# Bulk operations
{: #bulk-operations}

Use the bulk document API to create and update multiple documents at the same time within a single request.
The basic operation is similar to creating or updating a single document,
except that you batch the document structure and information.

When you create new documents, the document ID is optional.
For updating existing documents,
you must provide the document ID,
revision information,
and new document values.

A special case of bulk operations is the [`_bulk_get`](#the-bulk_get-endpoint) endpoint.
{: tip}

## Bulk request structure
{: #bulk-request-structure}

For both inserts and updates, the basic structure of the JSON document in the request contains the following fields:

Field  | Description             | Type             | Optional
-------|-------------------------|------------------|---------
`docs` | List of document objects | Array of objects | No
{: caption="Table 2. Basic bulk request structure" caption-side="top"}

It is best not to use the `new_edits` field. By default, if conflicts exist, document updates fail and return an error to the client. However, this option applies document revisions without checking for conflicts, so it is easy to accidentally end up with many conflicts.
{: note}

Each `docs` array object has the following structure:

Field      | Description                           | Type    | Optional 
-----------|---------------------------------------|---------|---------
`_id`      | Document ID                           | String  | Optional only for new documents. Otherwise, it's mandatory.
`_rev`     | Document revision                     | String  | Mandatory for updates and deletes, not used for new documents.
`_deleted` | Determines whether the document must be deleted. | Boolean | (Optional) The default value is `false`.
{: caption="Table 3. Structure of the docs array object" caption-side="top"}

Recall that for a partitioned database the `_id` field is formed from
a partition key part and a document key part.

See an example of using HTTP to create, update, or delete multiple documents:

```http
POST /$DATABASE/_bulk_docs HTTP/1.1
Content-Type: application/json
```
{: codeblock}

See an example of using the command line to create, update, or delete multiple documents:

```sh
curl -H "Authorization: Bearer $API_BEARER_TOKEN" -X POST "$SERVICE_URL/events/_bulk_docs" -H "Content-Type: application/json" --data '{ "docs": [ { "_id": "0007241142412418284", "type": "event", "userid": "abc123", "eventType": "addedToBasket", "productId": "1000042", "date": "2019-01-28T10:44:22.000Z" }, { "_id": "0008001142412418285", "type": "event", "userid": "def456", "eventType": "addedToBasket", "productId": "1000043", "date": "2019-01-28T12:30:00.000Z" } ], "new_edits": true }'
```
{: codeblock}
{: curl}

```java
import com.ibm.cloud.cloudant.v1.Cloudant;
import com.ibm.cloud.cloudant.v1.model.BulkDocs;
import com.ibm.cloud.cloudant.v1.model.Document;
import com.ibm.cloud.cloudant.v1.model.DocumentResult;
import com.ibm.cloud.cloudant.v1.model.PostBulkDocsOptions;

import java.util.Arrays;
import java.util.List;

Cloudant service = Cloudant.newInstance();

Document eventDoc1 = new Document();
eventDoc1.setId("0007241142412418284");
eventDoc1.put("type", "event");
eventDoc1.put("userid", "abc123");
eventDoc1.put("eventType", "addedToBasket");
eventDoc1.put("productId", "1000042");
eventDoc1.put("date", "2019-01-28T10:44:22.000Z");

Document eventDoc2 = new Document();
eventDoc2.setId("0007241142412418285");
eventDoc2.put("type", "event");
eventDoc2.put("userid", "abc234");
eventDoc2.put("eventType", "addedToBasket");
eventDoc2.put("productId", "1000050");
eventDoc2.put("date", "2019-01-28T10:44:22.000Z");

BulkDocs bulkDocs = new BulkDocs.Builder()
    .docs(Arrays.asList(eventDoc1, eventDoc2))
    .build();

PostBulkDocsOptions bulkDocsOptions = new PostBulkDocsOptions.Builder()
    .db("events")
    .bulkDocs(bulkDocs)
    .build();

List<DocumentResult> response =
    service.postBulkDocs(bulkDocsOptions).execute()
        .getResult();

System.out.println(response);
```
{: codeblock}
{: java}

```javascript
const { CloudantV1 } = require('@ibm-cloud/cloudant');

const service = CloudantV1.newInstance({});

const eventDoc1 = {
   _id: '0007241142412418284',
   type: 'event',
   userid: 'abc123',
   eventType:'addedToBasket',
   productId: '1000042',
   date: '2019-01-28T10:44:22.000Z'
}

const eventDoc2 = {
   _id: '0007241142412418285',
   type: 'event',
   userid: 'abc234',
   eventType: 'addedToBasket',
   productId: '1000050',
   date: '2019-01-25T20:00:00.000Z'
}

const bulkDocs = {  docs: [eventDoc1, eventDoc2] }

service.postBulkDocs({
   db: 'events',
   bulkDocs: bulkDocs
}).then(response => {
   console.log(response.result);
});
```
{: codeblock}
{: javascript}

```python
from ibmcloudant.cloudant_v1 import Document, CloudantV1, BulkDocs

service = CloudantV1.new_instance()

event_doc_1 = Document(
   id="0007241142412418284",
   type="event",
   userid="abc123",
   eventType="addedToBasket",
   productId="1000042",
   date="2019-01-28T10:44:22.000Z"
)
event_doc_2 = Document(
   id="0007241142412418285",
   type="event",
   userid="abc234",
   eventType="addedToBasket",
   productId="1000050",
   date="2019-01-25T20:00:00.000Z"
)

bulk_docs = BulkDocs(docs=[event_doc_1, event_doc_2])

response = service.post_bulk_docs(
   db='events',
   bulk_docs=bulk_docs
).get_result()

print(response)
```
{: codeblock}
{: python}

```go
eventDoc1 := cloudantv1.Document{
   ID: core.StringPtr("0007241142412418284"),
}
eventDoc1.SetProperty("type", "event")
eventDoc1.SetProperty("userid", "abc123")
eventDoc1.SetProperty("eventType", "addedToBasket")
eventDoc1.SetProperty("productId", "1000042")
eventDoc1.SetProperty("date", "2019-01-28T10:44:22.000Z")

eventDoc2 := cloudantv1.Document{
   ID: core.StringPtr("0007241142412418285"),
}
eventDoc2.SetProperty("type", "event")
eventDoc2.SetProperty("userid", "abc234")
eventDoc2.SetProperty("eventType", "addedToBasket")
eventDoc2.SetProperty("productId", "1000050")
eventDoc2.SetProperty("date", "2019-01-25T20:00:00.000Z")

postBulkDocsOptions := service.NewPostBulkDocsOptions(
   "events",
)
bulkDocs, err := service.NewBulkDocs(
   []cloudantv1.Document{
    eventDoc1,
    eventDoc2,
   },
)
if err != nil {
   panic(err)
}

postBulkDocsOptions.SetBulkDocs(bulkDocs)

documentResult, response, err := service.PostBulkDocs(postBulkDocsOptions)
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
   "github.com/IBM/go-sdk-core/v5/core"
)
```
{: codeblock}
{: go}

All Go examples require the `service` object to be initialized. For more information, see the API documentation's [Authentication section](https://cloud.ibm.com/apidocs/cloudant?code=go#authentication-with-external-configuration) for examples. 
{: go}

See an example JSON describing the update, creation, and deletion of three documents in one bulk request:

```json
[
  {
    "id": "0007241142412418284",
    "ok": true,
    "rev": "1-5005d65514fe9e90f8eccf174af5dd64"
  },
  {
    "id": "0008001142412418285",
    "ok": true,
    "rev": "1-2d7810b054babeda4812b3924428d6d6"
  }
]
```
{: codeblock}

## Bulk request responses
{: #bulk-request-responses}

The HTTP status code that is received in response indicates whether the request was fully or partially successful.
In the response body itself,
you get an array with detailed information for each document in the request.

Code | Description
-|-
`201` | The request did succeed, but this success doesn't imply all documents were updated. Inspect the response body to determine the status of each requested change, and [address any problems](#bulk-document-validation-and-conflict-errors).
`202` | For at least one document, the write [quorum](#quorum-writing-and-reading-data) wasn't met.
{: caption="Table 4. HTTP status codes" caption-side="top"}

See an example response from a bulk request:

```json
[
    {
    "ok":true,
    "id":"96f898f0-f6ff-4a9b-aac4-503992f31b01",
    "rev":"1-54dd23d6a630d0d75c2c5d4ef894454e"
    },
    {
    "ok":true,
    "id":"5a049246-179f-42ad-87ac-8f080426c17c",
    "rev":"1-0cde94a828df5cdc0943a10f3f36e7e5"
    },
    {
    "ok":true,
    "id":"d1f61e66-7708-4da6-aa05-7cbc33b44b7e",
    "rev":"1-a2b6e5dac4e0447e7049c8c540b309d6"
    }
]
```
{: codeblock}

## Inserting documents in bulk
{: #inserting-documents-in-bulk}

To insert documents in bulk into a database,
you need to supply a JSON structure with the array of documents that you want to add to the database.
You can either include a document ID for each document,
or allow the document ID to be automatically generated.

See an example JSON for a bulk insert of three documents:

```json
{
	"docs": [
		 {
		  "name": "Nicholas",
		  "age": 45,
		  "gender": "male",
		  "_id": "96f898f0-f6ff-4a9b-aac4-503992f31b01",
		  "_attachments": {

		 	}
	  },
	  {
		  "name": "Taylor",
		  "age": 50,
		  "gender": "male",
		  "_id": "5a049246-179f-42ad-87ac-8f080426c17c",
		  "_attachments": {

		  }
	  },
	  {
		  "name": "Owen",
		  "age": 51,
		  "gender": "male",
		  "_id": "d1f61e66-7708-4da6-aa05-7cbc33b44b7e",
		  "_attachments": {

		  }
	  }
	]
}
```
{: codeblock}

The return code from a successful bulk insertion is [`201`](/apidocs/cloudant#list-of-http-codes){: external}.
The content of the returned structure indicates success
or other information messages on a per-document basis.

See an example response header after successful bulk insert of three documents:

```http
201 Created
Cache-Control: must-revalidate
Content-Length: 269
Content-Type: application/json
Date: Mon, 04 Mar 2013 14:06:20 GMT
server: CouchDB/1.0.2 (Erlang OTP/R14B)
x-couch-request-id: e8ff64d5
```
{: codeblock}

The returned JSON contains a list of the documents that were created,
including their revision and ID values.

The content and structure of the returned JSON depends on the transaction semantics that are used for the bulk update.
For more information,
see [Bulk documents transaction semantics](#bulk-documents-transaction-semantics).

Conflicts and validation errors that occur when you update documents in bulk must be handled separately.
For more information,
see [Bulk document validation and conflict errors](#bulk-document-validation-and-conflict-errors).

See an example response content after successful bulk insert of two documents:

```json
[
    {
    "ok": true,
    "id": "id1",
    "rev": "2-402c81fee7ae6e723ff08bb166703a50"
    },
    {
    "id": "id2",
    "error": "conflict",
    "reason": "Document update conflict."
    }
]
```
{: codeblock}

## Updating documents in bulk
{: #updating-documents-in-bulk}

The bulk document update procedure is similar to the insertion procedure,
except that you must specify the document ID and current revision for every document in the bulk update JSON string.

See an example of using HTTP to do a bulk update:

```http
POST /$DATABASE/_bulk_docs HTTP/1.1
Accept: application/json
```
{: codeblock}

See an example of using the command line to do a bulk update:

```sh
curl -H "Authorization: Bearer $API_BEARER_TOKEN" -X POST "$SERVICE_URL/events/_bulk_docs" -H "Content-Type: application/json" --data '{ "docs": [ { "_id": "0007241142412418284", "type": "event", "userid": "abc123", "eventType": "addedToBasket", "productId": "1000042", "date": "2019-01-28T10:44:22.000Z" }, { "_id": "0008001142412418285", "type": "event", "userid": "def456", "eventType": "addedToBasket", "productId": "1000043", "date": "2019-01-28T12:30:00.000Z" } ], "new_edits": true }'
```
{: codeblock}
{: curl}

```java
import com.ibm.cloud.cloudant.v1.Cloudant;
import com.ibm.cloud.cloudant.v1.model.BulkDocs;
import com.ibm.cloud.cloudant.v1.model.Document;
import com.ibm.cloud.cloudant.v1.model.DocumentResult;
import com.ibm.cloud.cloudant.v1.model.PostBulkDocsOptions;

import java.util.Arrays;
import java.util.List;

Cloudant service = Cloudant.newInstance();

Document eventDoc1 = new Document();
eventDoc1.setId("0007241142412418284");
eventDoc1.put("type", "event");
eventDoc1.put("userid", "abc123");
eventDoc1.put("eventType", "addedToBasket");
eventDoc1.put("productId", "1000042");
eventDoc1.put("date", "2019-01-28T10:44:22.000Z");

Document eventDoc2 = new Document();
eventDoc2.setId("0007241142412418285");
eventDoc2.put("type", "event");
eventDoc2.put("userid", "abc234");
eventDoc2.put("eventType", "addedToBasket");
eventDoc2.put("productId", "1000050");
eventDoc2.put("date", "2019-01-28T10:44:22.000Z");

BulkDocs bulkDocs = new BulkDocs.Builder()
    .docs(Arrays.asList(eventDoc1, eventDoc2))
    .build();

PostBulkDocsOptions bulkDocsOptions = new PostBulkDocsOptions.Builder()
    .db("events")
    .bulkDocs(bulkDocs)
    .build();

List<DocumentResult> response =
    service.postBulkDocs(bulkDocsOptions).execute()
        .getResult();

System.out.println(response);
```
{: codeblock}
{: java}

```python
from ibmcloudant.cloudant_v1 import Document, CloudantV1, BulkDocs

service = CloudantV1.new_instance()

event_doc_1 = Document(
   id="0007241142412418284",
   type="event",
   userid="abc123",
   eventType="addedToBasket",
   productId="1000042",
   date="2019-01-28T10:44:22.000Z"
)
event_doc_2 = Document(
   id="0007241142412418285",
   type="event",
   userid="abc234",
   eventType="addedToBasket",
   productId="1000050",
   date="2019-01-25T20:00:00.000Z"
)

bulk_docs = BulkDocs(docs=[event_doc_1, event_doc_2])

response = service.post_bulk_docs(
   db='events',
   bulk_docs=bulk_docs
).get_result()

print(response)
```
{: codeblock}
{: python}

```go
eventDoc1 := cloudantv1.Document{
   ID: core.StringPtr("0007241142412418284"),
}
eventDoc1.SetProperty("type", "event")
eventDoc1.SetProperty("userid", "abc123")
eventDoc1.SetProperty("eventType", "addedToBasket")
eventDoc1.SetProperty("productId", "1000042")
eventDoc1.SetProperty("date", "2019-01-28T10:44:22.000Z")

eventDoc2 := cloudantv1.Document{
   ID: core.StringPtr("0007241142412418285"),
}
eventDoc2.SetProperty("type", "event")
eventDoc2.SetProperty("userid", "abc234")
eventDoc2.SetProperty("eventType", "addedToBasket")
eventDoc2.SetProperty("productId", "1000050")
eventDoc2.SetProperty("date", "2019-01-25T20:00:00.000Z")

postBulkDocsOptions := service.NewPostBulkDocsOptions(
   "events",
)
bulkDocs, err := service.NewBulkDocs(
   []cloudantv1.Document{
     eventDoc1,
     eventDoc2,
    },
)
if err != nil {
   panic(err)
}

postBulkDocsOptions.SetBulkDocs(bulkDocs)

documentResult, response, err := service.PostBulkDocs(postBulkDocsOptions)
if err != nil {
   panic(err)
}

b, _ := json.MarshalIndent(documentResult, "", "  ")
fmt.Println(string(b))
```
{: codeblock}
{: go}

```javascript
const { CloudantV1 } = require('@ibm-cloud/cloudant');

const service = CloudantV1.newInstance({});

const eventDoc1 = {
   _id: '0007241142412418284',
   type: 'event',
   userid: 'abc123',
   eventType:'addedToBasket',
   productId: '1000042',
   date: '2019-01-28T10:44:22.000Z'
}

const eventDoc2 = {
   _id: '0007241142412418285',
   type: 'event',
   userid: 'abc234',
   eventType: 'addedToBasket',
   productId: '1000050',
   date: '2019-01-25T20:00:00.000Z'
}

const bulkDocs = { docs: [eventDoc1, eventDoc2] };

service.postBulkDocs({
   db: 'events',
   bulkDocs: bulkDocs
}).then(response => {
   console.log(response.result);
});
```
{: codeblock}
{: javascript}

The previous Go example requires the following import block:
{: go}

```go
import (
   "encoding/json"
   "fmt"
   "github.com/IBM/cloudant-go-sdk/cloudantv1"
   "github.com/IBM/go-sdk-core/v5/core"
)
```
{: codeblock}
{: go}

All Go examples require the `service` object to be initialized. For more information, see the API documentation's [Authentication section](https://cloud.ibm.com/apidocs/cloudant?code=go#authentication-with-external-configuration) for examples. 
{: go}

See an example JSON structure to request bulk update of documents:

```json
{
	"docs": [
	  {
		  "name": "Nicholas",
		  "age": 45,
		  "gender": "female",
		  "_id": "96f898f0-f6ff-4a9b-aac4-503992f31b01",
		  "_attachments": {

		  },
		  "_rev": "1-54dd23d6a630d0d75c2c5d4ef894454e"
	  },
	  {
		  "name": "Taylor",
		  "age": 50,
		  "gender": "female",
		  "_id": "5a049246-179f-42ad-87ac-8f080426c17c",
		  "_attachments": {

		  },
		  "_rev": "1-0cde94a828df5cdc0943a10f3f36e7e5"
	  },
	  {
		  "name": "Owen",
		  "age": 51,
		  "gender": "female",
		  "_id": "d1f61e66-7708-4da6-aa05-7cbc33b44b7e",
		  "_attachments": {

		  },
		  "_rev": "1-a2b6e5dac4e0447e7049c8c540b309d6"
	  }
	]
}
```
{: codeblock}

The return JSON structure summarizes the updated documents,
with the new revision and ID information.

See an example JSON structure that is returned after bulk update:

```json                              
[
    {
        "ok":true,
        "id":"96f898f0-f6ff-4a9b-aac4-503992f31b01",
        "rev":"2-ff7b85665c4c297838963c80ecf481a3"  
    },
    {
        "ok":true,
        "id":"5a049246-179f-42ad-87ac-8f080426c17c",
        "rev":"2-9d5401898196997853b5ac4163857a29"
    },
    {
        "ok":true,
        "id":"d1f61e66-7708-4da6-aa05-7cbc33b44b7e",
        "rev":"2-cbdef49ef3ddc127eff86350844a6108"
    }
]
```
{: codeblock}

## Deleting documents in bulk
{: #deleting-documents-in-bulk}

To delete a document from the database, you must provide the ID and the revision of a specific document with the `"_deleted": true` field. 

See an example JSON structure to request bulk delete of two documents:

The return JSON structure summarizes the deleted documents,
with the new revision and ID information.

```json
{
	"docs": [
	  {
		  "_id": "person34567",
		  "_deleted": true,
		  "_rev": "2-54dd23d6a630d0d75c2c5d4ef894454e"
	  },
	  {
		  "_id": "person568",
		  "_deleted": true,
		  "_rev": "3-8a245604ee5e829d7fbd1b456aed01ac"
	  }
    ]
}
```
{: codeblock}

See an example JSON structure that is returned after bulk delete:

```json
[
    {
        "ok": true,
        "id": "person34567",
        "rev": "3-674ccbb6ec6fe6d7ba0fb30a5eecf664"
    },
    {
        "ok": true,
        "id": "person568",
        "rev": "4-c6067e21e97557f54d29282461843037"
    }
]
```
{: codeblock}

## Bulk documents transaction semantics
{: #bulk-documents-transaction-semantics}

If your request receives a [`202` response](/apidocs/cloudant#list-of-http-codes){: external},
the only certainty is that some of the document tasks were processed completely.
The response body contains the list of documents that were successfully inserted or updated during the process.

A successful document update is indicated by the presence of a new `_rev` parameter for the document,
indicating that a new document revision was successfully created.

If a document update failed,
then you get an `error` of type `conflict` for that document.
In this case,
no new revision was created.
You must submit the document update again,
with the same revision tag,
to retry the document update.

See an example bulk update response with errors:

```json
[
	{
	  "id" : "FishStew",
	  "error" : "conflict",
	  "reason" : "Document update conflict."
	},
	{
	  "id" : "LambStew",
	  "error" : "conflict",
	  "reason" : "Document update conflict."
	},
	{
	  "id" : "7f7638c86173eb440b8890839ff35433",
	  "error" : "conflict",
	  "reason" : "Document update conflict."
	}
]
```
{: codeblock}

## Bulk document validation and conflict errors
{: #bulk-document-validation-and-conflict-errors}

The JSON returned by the `_bulk_docs` operation consists of an array of JSON structures,
one for each document in the original submission.
The returned JSON structure must be examined
to ensure that all of the documents that were submitted in the original request were successfully added to the database.

The structure of the returned information is shown in the following tables:

Field  | Description             | Type
-------|-------------------------|-----
`docs` | List of document objects | Array of objects
{: caption="Table 5. Structure of JSON returned" caption-side="top"}

Each `docs` array object has the following structure:

Field    | Description                        | Type
---------|------------------------------------|-----
`id`     | Document ID                        | String
`error`  | Error type.                        | String
`reason` | Error string with extended reason. | String
{: caption="Table 6. Structure for the docs array object" caption-side="top"}

When a document (or document revision) is not correctly committed to the database because of an error,
you must check the `error` field to determine error type and course of action.
The error is one of [`conflict`](#conflict) or [`forbidden`](#forbidden).

### `conflict`
{: #conflict}

The document as submitted is in conflict.
If you used the default bulk transaction mode,
then the new revision wasn't created.
You must resubmit the document to the database.

Conflict resolution that uses the bulk docs interface is identical to the resolution procedures outlined in the [Conflicts](/docs/Cloudant?topic=Cloudant-conflicts
) documentation. 

### `forbidden`
{: #forbidden-doc}

Entries with this error type indicate that the validation routine that was applied
to the document during submission returned an error.

See an example JavaScript to produce `forbidden` error as part of a validation function:

```javascript
throw({forbidden: 'invalid recipe ingredient'});
```
{: codeblock}

See an example error message from a validation function:

```json
{
	"id" : "7f7638c86173eb440b8890839ff35433",
	"error" : "forbidden",
	"reason" : "invalid recipe ingredient"
}
```
{: codeblock}

## The `_bulk_get` endpoint
{: #the-bulk_get-endpoint}

You might need to access all the available information about multiple documents.
The `_bulk_get` endpoint is similar to the [`_all_docs`](/apidocs/cloudant#postalldocs){: external} endpoint,
but returns information about the requested documents only.

Like the `_bulk_docs` endpoint,
a JSON document that is supplied in the request includes an array that identifies all the documents of interest.

See an example of using HTTP to run the bulk `GET`request of document information:

```http
POST /$DATABASE/_bulk_get HTTP/1.1
Accept: application/json
```
{: codeblock}

See an example of using the command line to run the bulk `GET`request:

```sh
curl -H "Authorization: Bearer $API_BEARER_TOKEN" -X POST "$SERVICE_URL/orders/_bulk_get" -H "Content-Type: application/json" --data '{
  "docs": [
    {
      "id": "order00067",
      "rev": "3-917fa2381192822767f010b95b45325b"
    },
    {
      "id": "order00067"
      "rev": "4-a5be949eeb7296747cc271766e9a498b"
    }
   ],
}'
```
{: codeblock}
{: curl}

```java
import com.ibm.cloud.cloudant.v1.Cloudant;
import com.ibm.cloud.cloudant.v1.model.BulkGetQueryDocument;
import com.ibm.cloud.cloudant.v1.model.BulkGetResult;
import com.ibm.cloud.cloudant.v1.model.PostBulkGetOptions;

import java.util.ArrayList;
import java.util.List;

Cloudant service = Cloudant.newInstance();

String docId = "order00067";
List<BulkGetQueryDocument> bulkGetDocs = new ArrayList<>();

bulkGetDocs.add(
    new BulkGetQueryDocument.Builder()
        .id(docId)
        .rev("3-917fa2381192822767f010b95b45325b")
        .build());
bulkGetDocs.add(
    new BulkGetQueryDocument.Builder()
        .id(docId)
        .rev("4-a5be949eeb7296747cc271766e9a498b")
        .build());

PostBulkGetOptions bulkGetOptions = new PostBulkGetOptions.Builder()
    .db("orders")
    .docs(bulkGetDocs)
    .build();

BulkGetResult response =
    service.postBulkGet(bulkGetOptions).execute()
        .getResult();

System.out.println(response);
```
{: codeblock}
{: java}

```python
from ibmcloudant.cloudant_v1 import BulkGetQueryDocument, CloudantV1

service = CloudantV1.new_instance()

doc_id = 'order00067'
bulk_get_doc_1 = BulkGetQueryDocument(
    id=doc_id,
    rev='3-917fa2381192822767f010b95b45325b')
bulk_get_doc_2 = BulkGetQueryDocument(
    id=doc_id,
    rev='4-a5be949eeb7296747cc271766e9a498b')

response = service.post_bulk_get(
    db='orders',
    docs=[bulk_get_doc_1, bulk_get_doc_2],
).get_result()

print(response)
```
{: codeblock}
{: python}

```go
docID := "order00067"

bulkGetDocs := []cloudantv1.BulkGetQueryDocument{
   {
    ID: &docID,
    Rev: core.StringPtr("3-917fa2381192822767f010b95b45325b"),
   },
   {
    ID: &docID,
    Rev: core.StringPtr("4-a5be949eeb7296747cc271766e9a498b"),
   },
}

postBulkGetOptions := service.NewPostBulkGetOptions(
   "orders",
   bulkGetDocs,
)
bulkGetResult, response, err := service.PostBulkGet(postBulkGetOptions)
if err != nil {
   panic(err)
}

b, _ := json.MarshalIndent(bulkGetResult, "", "  ")
fmt.Println(string(b))
```
{: codeblock}
{: go}

```javascript
const service = CloudantV1.newInstance({});

const docId = 'order00067';

const bulkGetDoc1 = {
   id: docId,
   rev: '3-917fa2381192822767f010b95b45325b'
};
const bulkGetDoc2 = {
   id: docId,
   rev: '4-a5be949eeb7296747cc271766e9a498b'
};

const bulkGetDocs = [bulkGetDoc1, bulkGetDoc2];

const postBulkGetParams = {
   db: 'orders',
   docs: bulkGetDocs,
};

service.postBulkGet(postBulkGetParams)
   .then(response => {
    console.log(response.result);
   });
```
{: codeblock}
{: javascript}

The previous Go example requires the following import block:
{: go}

```go
import (
   "encoding/json"
   "fmt"
   "github.com/IBM/cloudant-go-sdk/cloudantv1"
   "github.com/IBM/go-sdk-core/v5/core"
)
```
{: codeblock}
{: go}

All Go examples require the `service` object to be initialized. For more information, see the API documentation's [Authentication section](https://cloud.ibm.com/apidocs/cloudant?code=go#authentication-with-external-configuration) for examples. 
{: go}

See an example of a JSON object that uses `POST` to the `_bulk_get` endpoint:

```json
{
	"docs": [
	  {
	  	"id": "doc1"
	  },
	  {
	  	"id": "doc3"
	  }
	]
}
```
{: codeblock}

See an example JSON structure that is returned after bulk get:

```json
{                                                         
	"results": [                                                         
	  {                                                         
	  	"id": "doc01",
	  	"docs": [
	  		{
	  			"ok": {
	  				"_id": "doc01",
	  				"_rev": "1-f3751e2db1d92e13b0baa6bdeb874c8c",
	  				"simplekey": "somedata"
	  			}
	  		}
    	]
	  },
	  {
	  	"id": "doc03",
	  	"docs": [
	  		{
	  			"ok": {
	  				"_id": "doc03",
	  				"_rev": "2-d4fc04ef748edf305a8c0ed347f269c4",
	  				"simplekey": "somemoredata"
	  			}
	  		}
	  	]
	  }
	]
}
```
{: codeblock}
