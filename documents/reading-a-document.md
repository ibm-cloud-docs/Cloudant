---

copyright:
  years: 2015, 2022
lastupdated: "2022-06-22"

keywords: read document, query parameters, read many documents

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# Reading a document
{: #read-a-document}

The steps shown here demonstrate how to read a document: 

1. Send a `GET` request to retrieve a document.

2. Run the following command: `https://$ACCOUNT.cloudant.com/$DATABASE/$DOCUMENT_ID`.

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

## Query parameters
{: #query-parameters-document}

You can add some query parameters to the URL,
for example `/mydatabase/doc?attachments=true&conflicts=true`.

All parameters are optional.

Name                | Type | Description | Default
--------------------|------|-------------|--------
`attachments`       | Boolean | Includes attachments bodies in response. | False
`att_encoding_info` | Boolean | Includes encoding information in attachment stubs if the particular attachment is compressed. | False
`atts_since`        | Array of revision strings | Includes attachments only since specified revisions. Doesn't include attachments for specified revisions. | []
`conflicts`         | Boolean | Includes information about conflicts in documents. | False
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
{: #read-many-documents}

To fetch more than one document at a time,
[query the database](/apidocs/cloudant#postalldocs){: external}
by using the `include_docs` option.
