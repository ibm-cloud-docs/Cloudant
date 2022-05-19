---

copyright:
  years: 2015, 2022
lastupdated: "2022-05-12"

keywords: create document, update document, read document, bulk operations, tombstone documents

subcollection: Cloudant

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

# Updating a document
{: #update-docs}

To update a document,
send a `PUT` request with the updated JSON content and the latest `_rev` value
to `https://$ACCOUNT.cloudant.com/$DATABASE/$DOCUMENT_ID`.
You can also use this `PUT` method to create a document,
in which case you don't need to supply the most recent `_rev` value.

Recall that for a partitioned database the `$DOCUMENT_ID` is formed from a partition key part and a document key part.

If you fail to provide the most recent `_rev` when you attempt to update an existing document, {{site.data.keyword.cloudant_short_notm}} responds with a [409 error](/apidocs/cloudant#list-of-http-codes){: external}. This error prevents you from overwriting data that were changed by other processes. If the write [quorum](#quorum-writing-and-reading-data) can't be met, a [`202` response](/apidocs/cloudant#list-of-http-codes){: external} is returned.
{: note}

Any document update can lead to a conflict, especially when you replicate updated documents. For more information about avoiding and resolving conflicts, see the [Document versioning and MVCC guide](/docs/Cloudant?topic=Cloudant-document-versioning-and-mvcc#document-versioning-and-mvcc).
{: note}

You can customize this topic for the programming language that you want to use by selecting the language in the code examples.
{: tip}

See an example of updating a document by using HTTP:

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
