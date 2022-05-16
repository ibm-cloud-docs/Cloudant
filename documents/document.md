---

copyright:
  years: 2015, 2022
lastupdated: "2022-05-16"

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
{{site.data.keyword.attribute-definition-list}}

# How documents work 
{: #documents}

Documents are
[JSON objects](http://en.wikipedia.org/wiki/JSON#Data_types.2C_syntax_and_example){: external}.
Documents are containers for your data,
and are the basis of the {{site.data.keyword.cloudantfull}} database.
{: shortdesc}

If you're using an [{{site.data.keyword.cloudant_short_notm}} service on {{site.data.keyword.cloud}}](/docs/Cloudant?topic=Cloudant-ibm-cloud-public#ibm-cloud-public), documents are limited to a maximum size of 1 MB. Exceeding this limit causes a [`413` error](/apidocs/cloudant#list-of-http-codes){: external}.
{: tip}

{{site.data.keyword.cloudant_short_notm}} uses an [eventually consistent](/docs/Cloudant?topic=Cloudant-cap-theorem#cap-theorem) model for data.
If you use the eventually consistent model, it's possible, under some conditions, to retrieve older document content. For example, older content is retrieved when your application writes or updates a document that is followed immediately by a read of the same document.

In other words,
your application would see the document content as it was before the write or update occurred.
For more information about this model,
see the topic on [Consistency](/docs/Cloudant?topic=Cloudant-cap-theorem#cap-theorem).

## Document fields
{: #document-fields}

All documents must have two fields:

- A unique `_id` field. The `_id` field is detailed in the next section.
- A `_rev` field. The `_rev` field is a revision identifier, and is [essential to the {{site.data.keyword.cloudant_short_notm}} replication protocol](/docs/Cloudant?topic=Cloudant-document-versioning-and-mvcc#document-versioning-and-mvcc).

In addition to these two mandatory fields, documents can generally contain any
other content that can be described by using JSON, subject to some caveats
detailed in the following sections.

### Document IDs
{: #document-ids}

The format of a document ID differs depending on whether a database is
partitioned or not. When a database is partitioned, the partition key for
each document is defined as part of the document ID as detailed in the next section.

#### IDs in partitioned databases
{: #ids-in-partitioned-databases}

When you use a partitioned database, the document ID specifies both the partition key and the document key. These keys are specified by splitting the document ID
into two parts that are separated by a colon:

```json
$PARTITION_KEY:$DOCUMENT_KEY
```

The `$PARTITION_KEY` might be the same between documents. The `$DOCUMENT_KEY`
must be unique within each partition. That is, overall the entire document
ID must be unique within a database. A document key might contain further
colon characters.

#### IDs in non-partitioned databases
{: #ids-in-non-partitioned-databases}

For non-partitioned databases, the `_id` field is either created by you, or
generated automatically as a [UUID](http://en.wikipedia.org/wiki/Universally_unique_identifier){: external}
by {{site.data.keyword.cloudant_short_notm}}.

If you choose to specify the document `_id` field, it must be limited to no more than 7168 characters (7k).
{: tip}

As with partitioned databases, the document ID must be unique within a database.

### Field name restrictions
{: #field-name-restrictions}

Field names that begin with the underscore character (`_`) are reserved in {{site.data.keyword.cloudant_short_notm}}.
This rule means that you can't normally have your own field names that begin with an underscore.
For example,
the field `example` would be accepted,
but the field `_example` would result in a `doc_validation` error message.

See an example of a JSON document that attempts to create a field with an underscore prefix:

```json
{
	"_top_level_field_name": "some data"
}
```
{: codeblock}

See an error message that is returned when you attempt to create a field with an underscore prefix:

```json
{
	"error": "doc_validation",
	"reason": "Bad special document member: _top_level_field_name"
}
```
{: codeblock}

However,
if the field name is for an object that is nested within the document,
you can use an underscore prefix for the field name.

See an example of a JSON document that attempts to create a field with an underscore prefix, nested within an object:

```json
{
	"another_top_level_field_name": "some data",
	"another_field": {
		"_lower_level_field_name": "some more data"
	}
}
```
{: codeblock}

See an example success message (abbreviated) returned when a nested field with an underscore prefix is created:

```json
{
	"ok": true,
	"id": "2",
	"rev": "1-9ce...8d4"
}
```
{: codeblock}

## Create
{: #create-document}

To create a document,
send a `PUT` request with the document's JSON content to `$SERVICE_URL/$DATABASE/$DOC_ID`.

### Creating a document by using HTTP
{: #creating-document-using-http}

```http
PUT /$DATABASE/$DOC_ID HTTP/1.1
Content-Type: application/json
```
{: codeblock}

### Examples of creating a document
{: #creating-document-using-command-line}

Example of creating a {{site.data.keyword.cloudant_short_notm}}s document for this JSON in a non-partitioned database:

```json
{
 
   "type": "event",
   "userid": "abc123",
   "eventType": "addedToBasket",
   "productId": "1000042",
   "date": "2019-01-28T10:44:22.000Z"
 
}
```
{: codeblock}

You can customize this section for the programming language that you want to use by selecting the language in the code examples.
{: tip}

See an example of using the command line to create a document:

```sh
curl -H "Authorization: Bearer $API_BEARER_TOKEN" -X PUT "$SERVICE_URL/events/0007241142412418284" -H "Content-Type: application/json" --data '{ "type": "event", "userid": "abc123", "eventType": "addedToBasket", "productId": "1000042", "date": "2019-01-28T10:44:22.000Z }'
```
{: codeblock}
{: curl}

```java
import com.ibm.cloud.cloudant.v1.Cloudant;
import com.ibm.cloud.cloudant.v1.model.Document;
import com.ibm.cloud.cloudant.v1.model.DocumentResult;
import com.ibm.cloud.cloudant.v1.model.PutDocumentOptions;

Cloudant service = Cloudant.newInstance();

Document eventDoc = new Document();
eventDoc.put("type", "event");
eventDoc.put("userid", "abc123");
eventDoc.put("eventType", "addedToBasket");
eventDoc.put("productId", "1000042");
eventDoc.put("date", "2019-01-28T10:44:22.000Z");

PutDocumentOptions documentOptions =
    new PutDocumentOptions.Builder()
        .db("events")
        .docId("0007241142412418284")
        .document(eventDoc)
        .build();

DocumentResult response =
    service.putDocument(documentOptions).execute()
        .getResult();

System.out.println(response);

```
{: codeblock}
{: java}

```javascript
const { CloudantV1 } = require('@ibm-cloud/cloudant');

const service = CloudantV1.newInstance({});

const eventDoc = {
  type: 'event',
  userid: 'abc123',
  eventType: 'addedToBasket',
  productId: '1000042',
  date: '2019-01-28T10:44:22.000Z'
};

service.putDocument({
  db: 'events',
  docId: '0007241142412418284',
  document: eventDoc
}).then(response => {
  console.log(response.result);
});
```
{: codeblock}
{: javascript}

```python
from ibmcloudant.cloudant_v1 import Document, CloudantV1

service = CloudantV1.new_instance()

event_doc = Document(
  type='event',
  userid='abc123',
  eventType='addedToBasket',
  productId='1000042',
  date='2019-01-28T10:44:22.000Z'
)
response = service.put_document(
  db='events',
  doc_id='0007241142412418284',
  document=event_doc
).get_result()

print(response)
```
{: codeblock}
{: python}

```go
eventDoc := cloudantv1.Document{}
eventDoc.SetProperty("type", "event")
eventDoc.SetProperty("userid", "abc123")
eventDoc.SetProperty("eventType", "addedToBasket")
eventDoc.SetProperty("productId", "1000042")
eventDoc.SetProperty("date", "2019-01-28T10:44:22.000Z")

putDocumentOptions := service.NewPutDocumentOptions(
  "events",
  "0007241142412418284",
)
putDocumentOptions.SetDocument(&eventDoc)

documentResult, response, err := service.PutDocument(putDocumentOptions)
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

The response is a JSON document that contains the ID of the created document,
the revision string,
and `"ok": true`.

If you didn't provide an `_id` field,
{{site.data.keyword.cloudant_short_notm}} generates one automatically as a
[UUID](http://en.wikipedia.org/wiki/Universally_unique_identifier){: external}.

A failure to create the document results in a
response that contains a description of the error.

See an example response after successfully creating a document:

```json
{
  "id": "exampleid",
  "ok": true,
  "rev": "2-056f5f44046ecafc08a2bc2b9c229e20"
}
```
{: codeblock}

If the write [quorum](#quorum-writing-and-reading-data) can't be met during an attempt to create a document, a [`202` response](/apidocs/cloudant#list-of-http-codes){: external} is returned.
{: tip}

## Read
{: #read-document}

To retrieve a document,
send a GET request to `https://$ACCOUNT.cloudant.com/$DATABASE/$DOCUMENT_ID`.

Recall that for a partitioned database the `$DOCUMENT_ID` is formed of a partition key part and a document key part.

If you don't know the `_id` for a particular document,
you can [query the database](/apidocs/cloudant#postalldocsqueries){: external} for all documents.

Due to the distributed, eventually consistent nature of {{site.data.keyword.cloudant_short_notm}}, reads might return stale data. In particular,
data written recently, even by the same client, might not be returned from a read request immediately following the write request. To work around this behavior,
a client can cache the state of data locally. Caching also helps to keep request counts down, increase application performance, and decrease load on the database cluster. This behavior also applies to other read requests such as to MapReduce and search indexes.
{: note}

See an example of retrieving a document by using HTTP:

```http
GET /$DATABASE/$DOCUMENT_ID HTTP/1.1
```
{: codeblock}

You can customize this section for the programming language that you want to use by selecting the language in the code examples.
{: tip}

See an example of retrieving a document:

```sh
curl -H "Authorization: Bearer $API_BEARER_TOKEN" -X GET "$SERVICE_URL/products/small-appliances:1000042"
```
{: codeblock}
{: curl}

```java
import com.ibm.cloud.cloudant.v1.Cloudant;
import com.ibm.cloud.cloudant.v1.model.Document;
import com.ibm.cloud.cloudant.v1.model.GetDocumentOptions;

Cloudant service = Cloudant.newInstance();

GetDocumentOptions documentOptions =
    new GetDocumentOptions.Builder()
        .db("products")
        .docId("small-appliances:1000042")
        .build();

Document response =
    service.getDocument(documentOptions).execute()
        .getResult();

System.out.println(response);
```
{: codeblock}
{: java}

```javascript
const { CloudantV1 } = require('@ibm-cloud/cloudant');

const service = CloudantV1.newInstance({});

service.getDocument({
  db: 'products',
  docId: 'small-appliances:1000042'
}).then(response => {
  console.log(response.result);
});
```
{: codeblock}
{: javascript}

```python
from ibmcloudant.cloudant_v1 import CloudantV1

service = CloudantV1.new_instance()

response = service.get_document(
  db='products',
  doc_id='small-appliances:1000042'
).get_result()

print(response)
```
{: codeblock}
{: python}

```go
getDocumentOptions := service.NewGetDocumentOptions(
  "products",
  "small-appliances:1000042",
)

document, response, err := service.GetDocument(getDocumentOptions)
if err != nil {
  panic(err)
}

b, _ := json.MarshalIndent(document, "", "  ")
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

The response contains the document that you requested,
or a description of the error if the document can't be retrieved.

See an example response of retrieving a document:

```json
{
  "_id": "exampleid",
  "brand": "Foo",
  "colours": [
    "red",
    "green",
    "black",
    "blue"
  ],
  "description": "Slim Colourful Design Electronic Cooking Appliance for ...",
  "image": "assets/img/0gmsnghhew.jpg",
  "keywords": [
    "Foo",
    "Scales",
    "Weight",
    "Digital",
    "Kitchen"
  ],
  "name": "Digital Kitchen Scales",
  "price": 14.99,
  "productid": "1000042",
  "taxonomy": [
    "Home",
    "Kitchen",
    "Small Appliances"
  ],
  "type": "product"
}
```
{: codeblock}

### Query parameters
{: #query-parameters-document}

You can add some query parameters to the URL,
for example `/mydatabase/doc?attachments=true&conflicts=true`.

All parameters are optional.

Name                | Type | Description | Default
--------------------|------|-------------|--------
`attachments`       | Boolean | Includes attachments bodies in response. | False
`att_encoding_info` | Boolean | Includes encoding information in attachment stubs if the particular attachment is compressed. | False
`atts_since`        | Array of revision strings | Includes attachments only since specified revisions. Doesn't include attachments for specified revisions. | []
`conflicts`         | Boolean | Includes information about conflicts in document. | False
`deleted_conflicts` | Boolean | Includes information about deleted conflicted revisions. | False
`latest`            | Boolean | Forces retrieval of the most recent "leaf" revision, no matter what revision was requested. | False
`local_seq`         | Boolean | Includes last update sequence number for the document. | False
`meta`              | Boolean | Same as specifying the `conflicts`, `deleted_conflicts`, and `open_revs` query parameters. | False
`open_revs`         | Array or `all` | Retrieves documents of specified leaf revisions. Additionally, it accepts the value `all` to return all leaf revisions. | []
`rev`               | String | Retrieves document of specified revision. | -
`revs`              | Boolean | Includes list of all known document revisions. | False
`revs_info`         | Boolean | Includes detailed information for all known document revisions. | False
{: caption="Table 1. Query parameters" caption-side="top"}

## Read many
{: #read-many}

To fetch more than one document at a time,
[query the database](/apidocs/cloudant#postalldocs){: external}
by using the `include_docs` option.

## Update
{: #update}

To update a document, send a `POST` request with the updated JSON content, the `_id` of the document, and the latest `_rev` value to `$SERVICE_URL/$DATABASE`. You can also use the `PUT` method against `$SERVICE_URL/$DATABASE/$DOCUMENT_ID` with the latest revision provided as `rev` in the request query or as `_rev` in the JSON body content to update a document.

Recall that for a partitioned database the `$DOCUMENT_ID` is formed from a partition key part and a document key part.

If you fail to provide the most recent `_rev` when you attempt to update an existing document, {{site.data.keyword.cloudant_short_notm}} responds with a [409 error](/apidocs/cloudant#list-of-http-codes){: external}. This error prevents you overwriting data that were changed by other processes. If the write [quorum](#quorum-writing-and-reading-data) can't be met, a [`202` response](/apidocs/cloudant#list-of-http-codes){: external} is returned.
{: note}

Any document update can lead to a conflict, especially when you replicate updated documents. For more information about avoiding and resolving conflicts, see the [Document versioning and MVCC guide](/docs/Cloudant?topic=Cloudant-document-versioning-and-mvcc#document-versioning-and-mvcc).
{: note}

You can customize this topic for the programming language that you want to use by selecting the language in the code examples.
{: tip}

See example of updating a document by using HTTP:

```http
POST /$DATABASE HTTP/1.1
```
{: codeblock} 

See examples of updating a document:

```sh
curl -H "Authorization: Bearer $API_BEARER_TOKEN" -X POST "$SERVICE_URL/products" -H "Content-Type: application/json" --data '{ "_id": "small-appliances:1000042", "_rev": "1-967a00dff5e02add41819138abb3284d", "type": "product", "productid": "1000042", "brand": "Salter", "name": "Digital Kitchen Scales", "description": "Slim Colourful Design Electronic Cooking Appliance for Home / Kitchen, Weigh up to 5kg + Aquatronic for Liquids ml + fl. oz. 15Yr Guarantee - Green", "price: 14.99, "image": "assets/img/0gmsnghhew.jpg" }'
```
{: codeblock}
{: curl}

```java
import com.ibm.cloud.cloudant.v1.Cloudant;
import com.ibm.cloud.cloudant.v1.model.Document;
import com.ibm.cloud.cloudant.v1.model.DocumentResult;
import com.ibm.cloud.cloudant.v1.model.PostDocumentOptions;


Cloudant service = Cloudant.newInstance();

Document productsDocument = new Document();
productsDocument.setId("small-appliances:1000042");
productsDocument.setRev("1-967a00dff5e02add41819138abb3284d");
productsDocument.put("type", "product");
productsDocument.put("productid", "1000042");
productsDocument.put("brand", "Salter");
productsDocument.put("name", "Digital Kitchen Scales");
productsDocument.put("description", "Slim Colourful Design Electronic"
    + "Cooking Appliance for Home/Kitchen, Weigh up to 5kg + Aquatronic"
    + "for Liquids ml + fl. oz. 15Yr Guarantee - Green");
productsDocument.put("price", 14.99);
productsDocument.put("image", "assets/img/0gmsnghhew.jpg");

PostDocumentOptions documentOptions =
    new PostDocumentOptions.Builder()
        .db("products")
        .document(productsDocument)
        .build();

DocumentResult response =
    service.postDocument(documentOptions).execute()
        .getResult();

System.out.println(response);
```
{: codeblock}
{: java}

```javascript
const { CloudantV1 } = require('@ibm-cloud/cloudant');

const service = CloudantV1.newInstance({});

const productsDoc = {
  _id: 'small-appliances:1000042',
  _rev: '1-967a00dff5e02add41819138abb3284d'
  type: 'product',
  productid: '1000042',
  brand: 'Salter',
  name: 'Digital Kitchen Scales',
  description: 'Slim Colourful Design Electronic Cooking Appliance for Home / Kitchen, Weigh up to 5kg + Aquatronic for Liquids ml + fl. oz. 15Yr Guarantee - Green',
  price: 14.99,
  image: 'assets/img/0gmsnghhew.jpg'
};

service.postDocument({
  db: 'products',
  document: productsDoc
}).then(response => {
  console.log(response.result);
});
```
{: codeblock}
{: javascript}

```python
from ibmcloudant.cloudant_v1 import Document, CloudantV1

service = CloudantV1.new_instance()

products_doc = Document(
  id="small-appliances:1000042",
  rev="1-967a00dff5e02add41819138abb3284d"
  type="product",
  productid="1000042",
  brand="Salter",
  name="Digital Kitchen Scales",
  description="Slim Colourful Design Electronic Cooking Appliance for Home / Kitchen, Weigh up to 5kg + Aquatronic for Liquids ml + fl. oz. 15Yr Guarantee - Green",
  price=14.99,
  image="assets/img/0gmsnghhew.jpg")

response = service.post_document(db='products', document=products_doc).get_result()

print(response)
```
{: codeblock}
{: python}

```go
productsDoc := cloudantv1.Document{
  ID: core.StringPtr("small-appliances:1000042"),
}
productsDoc.Rev = "1-967a00dff5e02add41819138abb3284d"
productsDoc.SetProperty("type", "product")
productsDoc.SetProperty("productid", "1000042")
productsDoc.SetProperty("brand", "Salter")
productsDoc.SetProperty("name", "Digital Kitchen Scales")
productsDoc.SetProperty("description", "Slim Colourful Design Electronic Cooking Appliance for Home / Kitchen, Weigh up to 5kg + Aquatronic for Liquids ml + fl. oz. 15Yr Guarantee - Green")
productsDoc.SetProperty("price", 14.99)
productsDoc.SetProperty("image", "assets/img/0gmsnghhew.jpg")

postDocumentOptions := service.NewPostDocumentOptions(
  "products",
)
postDocumentOptions.SetDocument(&productsDoc)

documentResult, response, err := service.PostDocument(postDocumentOptions)
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

See an example of JSON data that contains an updated document:

```json
{
   "id": "exampleid",
   "ok": true,
   "rev": "2-056f5f44046ecafc08a2bc2b9c229e20"
}
```
{: codeblock}

Recall that for a partitioned database the `$DOCUMENT_ID` is formed from a partition key part and a document key part.

The response contains the ID and the new revision of the document,
or an error message if the update failed.

See an example response after a successful update:

```json
{
  "id": "exampleid",
  "ok": true,
  "rev": "2-056f5f44046ecafc08a2bc2b9c229e20"
}
```
{: codeblock}

## Delete a document
{: #delete-a-document}

To delete a document,
send a `DELETE` request with the document's most recent `_rev` in the query string,
to `https://$ACCOUNT.cloudant.com/$DATABASE/$DOCUMENT_ID`.

The response contains the ID and the new revision of the document,
or an error message if the delete failed.

If you fail to provide the most recent `_rev`, {{site.data.keyword.cloudant_short_notm}} responds with a [409 error](/apidocs/cloudant#list-of-http-codes){: external}. This error prevents you overwriting data that were changed by other clients. If the write [quorum](#quorum-writing-and-reading-data) can't be met, a [`202` response](/apidocs/cloudant#list-of-http-codes){: external} is returned.
{: note}

{{site.data.keyword.cloudant_short_notm}} doesn't completely delete the specified document. Instead, it leaves a [tombstone](#tombstone-documents) with basic information about the document. The tombstone is required so that the delete action can be replicated to other copies of the database. Since the tombstones stay in the database indefinitely,
creating new documents and deleting them increases the disk space usage of a database. They might also increase the query time for the primary index, which is used to look up documents by their ID.
{: note}

See an example of using HTTP to delete a document:

```http
DELETE /$DATABASE/$DOCUMENT_ID?rev=$REV HTTP/1.1
```
{: codeblock}

See an example of using the command line to delete a document:

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

All Go examples require the `service` object to be initialized. For more information, see the API documentation's [Authentication section](https://cloud.ibm.com/apidocs/cloudant?code=go#authentication-with-external-configuration) for examples. 
{: go}

See an example response after a successful deletion request:

```json
{
  "id": "exampleid",
  "ok": true,
  "rev": "2-056f5f44046ecafc08a2bc2b9c229e20"
}
```
{: codeblock}

## "Tombstone" documents
{: #tombstone-documents}

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

### Simple removal of "tombstone" documents
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

### Advanced removal of tombstone documents
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
-   A user context,
-   which provides details about the user that supplied the updated document.

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

### Performance implications of tombstone removal
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

## Bulk operations
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

### Bulk request structure
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

### Bulk request responses
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

### Inserting documents in bulk
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

### Updating documents in bulk
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

### Deleting documents in bulk
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

### Bulk documents transaction semantics
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

### Bulk document validation and conflict errors
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

#### `conflict`
{: #conflict}

The document as submitted is in conflict.
If you used the default bulk transaction mode,
then the new revision wasn't created.
You must resubmit the document to the database.

Conflict resolution that uses the bulk docs interface is identical to the resolution procedures outlined in the [Conflicts](/docs/Cloudant?topic=Cloudant-conflicts
) documentation. 

#### `forbidden`
{: #forbidden}

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

### The `_bulk_get` endpoint
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

## Quorum - writing and reading data
{: #quorum-writing-and-reading-data}

In a distributed system,
it's possible that a request might take some time to complete.
A "quorum" mechanism is used to help determine when a request,
such as a write or read,
completes successfully.

For more information about quorum settings and their implications on dedicated {{site.data.keyword.cloudant_short_notm}} systems,
contact {{site.data.keyword.cloudant_short_notm}} support.

## Time to live
{: #ttl-time-to-live}

[Time to live](https://en.wikipedia.org/wiki/Time_to_live){: external} (TTL) is a property of data,
where after a relative amount of time,
or at an absolute time,
the data is considered expired.
The data itself might be deleted or moved to an alternative (archive) location.

{{site.data.keyword.cloudant_short_notm}} does not support Time to Live functions.

The reason is that {{site.data.keyword.cloudant_short_notm}} documents are only "soft" deleted,
not deleted.
The soft deletion involves replacing the original document with a [smaller record](#tombstone-documents).
This small record or "tombstone" is required for replication purposes. It helps ensure that the correct revision to use can be identified during replication.

If the TTL capability was available in {{site.data.keyword.cloudant_short_notm}},
the resulting potential increase in short-lived documents and soft deletion records
would mean that the database size might grow in an unbounded fashion.

