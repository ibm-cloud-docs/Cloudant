---

copyright:
  years: 2015, 2022
lastupdated: "2022-11-30"

keywords: create document, examples of create document, create document with http

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# Creating a document
{: #create-document}

The steps that are shown here demonstrate how to create a document.

1. Send a `POST` request with the document's JSON content to create a document.

2. Run the following command: `https://$ACCOUNT.cloudant.com/$DATABASE`.

## Creating a document by using HTTP
{: #creating-document-using-http}

The following steps show you how to create a document by using HTTP.

1. Send a `PUT` request with the document's JSON content by using HTTP to create a document.

2. Run the following command:

```http
PUT /$DATABASE/$DOC_ID HTTP/1.1
Content-Type: application/json
```
{: codeblock}

## Examples of how to create a document
{: #creating-document-using-command-line}

See an example of creating an {{site.data.keyword.cloudant_short_notm}} document for this JSON in a nonpartitioned database:

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

You can customize creating a document for the programming language that you want to use by selecting the language in the code examples.
{: tip}

See an example of creating a document:

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
[UUID](https://en.wikipedia.org/wiki/Universally_unique_identifier){: external}.

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
