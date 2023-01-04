---

copyright:
  years: 2015, 2022
lastupdated: "2022-12-23"

keywords: create, update, read, delete an attachment, inline, performance considerations, BLOB, attachments

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# How to use attachments
{: #how-to-use-attachments}

Another way to store data is to use attachments.
Attachments are Binary Large OBject ([BLOB](https://en.wikipedia.org/wiki/Binary_large_object){: external})
files that are included within documents.
{: shortdesc}

It's a good idea to keep attachments small in size and number because attachments can impact performance.
{: important}

The BLOB is stored in the `_attachments` component of the document.
The BLOB holds data that includes the following information:

- The attachment name
- The type of the attachment
- The actual content

Examples of BLOBs would be images and multimedia.

If you include the attachment as an [inline](/docs/Cloudant?topic=Cloudant-how-to-use-attachments#inline) component of the overall JSON, the attachment content is represented by using BASE64 form.
{: note}

The content type corresponds to a [MIME type](https://en.wikipedia.org/wiki/Internet_media_type#List_of_common_media_types){: external}.
For example,
if you want to attach a `.jpg` image file to a document,
you specify the attachment MIME type as `image/jpeg`.

Attachments aren't permitted on documents in [`_replicator`](/apidocs/cloudant#postreplicate){: external} or [`_users`](/apidocs/cloudant#putsecurity){: external} databases.
{: important}

## Create or update
{: #create-update}

To create a new attachment at the same time as creating a new document, include the attachment as an [inline](/docs/Cloudant?topic=Cloudant-how-to-use-attachments#inline) component of the JSON content.

To create a new attachment on an existing document,
or to update an attachment on a document,
make a PUT request with the document's most recent `_rev` to `https://$ACCOUNT.cloudant.com/$DATABASE/$DOCUMENT_ID/$ATTACHMENT`.
The attachment's [content type](https://en.wikipedia.org/wiki/Internet_media_type#List_of_common_media_types){: external}
must be specified by using the `Content-Type` header.
The `$ATTACHMENT` value is the name by which the attachment is associated with the document.

You can create more than one attachment for a document by ensuring that the `$ATTACHMENT` value for each attachment is unique within the document.
{: tip}

See the following example for creating or updating an attachment by using HTTP:

```HTTP
PUT /$DATABASE/$DOCUMENT_ID/$ATTACHMENT?rev=$REV HTTP/1.1
Content-Type: $$ATTACHMENT_MIME_TYPE
```
{: codeblock}

See the following example for creating or updating an attachment:

```sh
curl -H "Authorization: Bearer $API_BEARER_TOKEN" -X PUT "$SERVICE_URL/products/small-appliances:100001/product_details.txt" -H "Content-Type: text/plain" --data 'This appliance includes...'
```
{: codeblock}
{: curl}

```java
import com.ibm.cloud.cloudant.v1.Cloudant;
import com.ibm.cloud.cloudant.v1.model.DocumentResult;
import com.ibm.cloud.cloudant.v1.model.PutAttachmentOptions;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;

Cloudant service = Cloudant.newInstance();

String detailedDescription = "This appliance includes...";

InputStream detailedDescriptionStream =
    new ByteArrayInputStream(detailedDescription
        .getBytes(StandardCharsets.UTF_8));

PutAttachmentOptions attachmentOptions =
    new PutAttachmentOptions.Builder()
        .db("products")
        .docId("small-appliances:100001")
        .attachmentName("product_details.txt")
        .attachment(detailedDescriptionStream)
        .contentType("text/plain")
        .build();

DocumentResult response =
    service.putAttachment(attachmentOptions).execute()
        .getResult();

System.out.println(response);
```
{: codeblock}
{: java}

```javascript
const { CloudantV1 } = require('@ibm-cloud/cloudant');

const service = CloudantV1.newInstance({});

const stream = new Readable();
stream.push('This appliance includes...');
stream.push(null);

service.putAttachment({
  db: 'products',
  docId: 'small-appliances:100001',
  attachmentName: 'product_details.txt',
  attachment: stream,
  contentType: 'text/plain'
}).then(response => {
  console.log(response.result);
});
```
{: codeblock}
{: javascript}

```python
from ibmcloudant.cloudant_v1 import CloudantV1

service = CloudantV1.new_instance()

detailed_description = "This appliance includes..."
response = service.put_attachment(
  db='products',
  doc_id='small-appliances:100001',
  attachment_name='product_details.txt',
  attachment=detailed_description,
  content_type='text/plain'
).get_result()

print(response)
```
{: codeblock}
{: python}

```go
putAttachmentOptions := service.NewPutAttachmentOptions(
  "products",
  "small-appliances:100001",
  "product_details.txt",
  ioutil.NopCloser(
    bytes.NewReader([]byte("This appliance includes...")),
  ),
  "text/plain",
)

documentResult, response, err := service.PutAttachment(putAttachmentOptions)
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
   "io/ioutil"
   "github.com/IBM/cloudant-go-sdk/cloudantv1"
)
```
{: codeblock}
{: go}

All Go examples require the `service` object to be initialized. For more information, see the API documentation [Authentication section](https://cloud.ibm.com/apidocs/cloudant?code=go#authentication-with-external-configuration) for examples. 
{: go}

The response includes the document ID and the new document revision.

Attachments don't have their own revisions. Instead, when you update or create an attachment, the revision of the document it's attached to changes. 
{: tip}

See the following example response with the document ID and new revision:

```json
{
	"id" : "FishStew",
	"ok" : true,
	"rev" : "9-247bb19a41bfd9bfdaf5ee6e2e05be74"
}
```
{: codeblock}

## Read
{: #read-attachments}

To retrieve an attachment,
make a `GET` request to `https://$ACCOUNT.cloudant.com/$DATABASE/$DOCUMENT_ID/$ATTACHMENT`.
The body of the response is the raw content of the attachment.

See the following example of reading an attachment by using HTTP:

```http
GET /$DATABASE/$DOCUMENT_ID/$ATTACHMENT HTTP/1.1
```
{: codeblock}

See the following example of reading an attachment:

```sh
curl -H "Authorization: Bearer $API_BEARER_TOKEN" -X GET "$SERVICE_URL/products/small-appliances:100001/product_details.txt"
```
{: codeblock}
{: curl}

```java
import com.ibm.cloud.cloudant.v1.Cloudant;
import com.ibm.cloud.cloudant.v1.model.GetAttachmentOptions;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.stream.Collectors;

Cloudant service = Cloudant.newInstance();

GetAttachmentOptions attachmentOptions =
    new GetAttachmentOptions.Builder()
        .db("products")
        .docId("small-appliances:100001")
        .attachmentName("product_details.txt")
        .build();

InputStream streamResult =
    service.getAttachment(attachmentOptions).execute()
        .getResult();

String response =
    new BufferedReader(new InputStreamReader(streamResult))
        .lines().collect(Collectors.joining("\n"));

System.out.println(response);
```
{: codeblock}
{: java}

```javascript
const { CloudantV1 } = require('@ibm-cloud/cloudant');

const service = CloudantV1.newInstance({});

service.getAttachment({
  db: 'products',
  docId: 'small-appliances:100001',
  attachmentName: 'product_details.txt'
}).then(response => {
  let attachment = response.result as Readable;
  attachment.pipe(process.stdout);
});
```
{: codeblock}
{: javascript}

```python
from ibmcloudant.cloudant_v1 import CloudantV1

service = CloudantV1.new_instance()

response_attachment = service.get_attachment(
  db='products',
  doc_id='small-appliances:100001',
  attachment_name='product_details.txt'
).get_result().content

print(response_attachment)
```
{: codeblock}
{: python}

```go
getAttachmentOptions := service.NewGetAttachmentOptions(
  "products",
  "small-appliances:100001",
  "product_details.txt",
)

result, response, err := service.GetAttachment(getAttachmentOptions)
if err != nil {
  panic(err)
}

data, _ := ioutil.ReadAll(result)
fmt.Println("\n", string(data))
```
{: codeblock}
{: go}

The previous Go example requires the following import block:
{: go}

```go
import (
   "fmt"
   "io/ioutil"
   "github.com/IBM/cloudant-go-sdk/cloudantv1"
)
```
{: codeblock}
{: go}

All Go examples require the `service` object to be initialized. For more information, see the API documentation's [Authentication section](https://cloud.ibm.com/apidocs/cloudant?code=go#authentication-with-external-configuration) for examples. 
{: go}

## Delete an attachment
{: #delete-an-attachment}

To delete an attachment,
make a `DELETE` request with the document's most recent `_rev`
to `https://$ACCOUNT.cloudant.com/$DATABASE/$DOCUMENT_ID/$ATTACHMENT`.
If you don't supply the most recent `_rev`,
the response is a [409 error](/apidocs/cloudant#list-of-http-codes){: external}.

See the following example of deleting an attachment by using HTTP:

```http
DELETE /$DATABASE/$DOCUMENT_ID/$ATTACHMENT?rev=$REV HTTP/1.1
```
{: codeblock}

See the following example of deleting an attachment:

```sh
curl -H "Authorization: Bearer $API_BEARER_TOKEN" -X DELETE "$SERVICE_URL/products/small-appliances:100001/product_details.txt?rev=4-1a0d1cd6f40472509e9aac646183736a"
```
{: codeblock}
{: curl}

```java
import com.ibm.cloud.cloudant.v1.Cloudant;
import com.ibm.cloud.cloudant.v1.model.DeleteAttachmentOptions;
import com.ibm.cloud.cloudant.v1.model.DocumentResult;

Cloudant service = Cloudant.newInstance();

DeleteAttachmentOptions attachmentOptions =
    new DeleteAttachmentOptions.Builder()
        .db("products")
        .docId("small-appliances:100001")
        .attachmentName("product_details.txt")
        .rev("4-1a0d1cd6f40472509e9aac646183736a")
        .build();

DocumentResult response =
    service.deleteAttachment(attachmentOptions).execute()
        .getResult();

System.out.println(response);
```
{: codeblock}
{: java}

```javascript
const { CloudantV1 } = require('@ibm-cloud/cloudant');

const service = CloudantV1.newInstance({});

service.deleteAttachment({
  db: 'products',
  docId: 'small-appliances:100001',
  attachmentName: 'product_details.txt',
  rev: '4-1a0d1cd6f40472509e9aac646183736a'
}).then(response => {
  console.log(response.result);
});
```
{: codeblock}
{: javascript}

```python
from ibmcloudant.cloudant_v1 import CloudantV1

service = CloudantV1.new_instance()

response = service.delete_attachment(
  db='products',
  doc_id='small-appliances:100001',
  attachment_name='product_details.txt',
  rev='4-1a0d1cd6f40472509e9aac646183736a'
).get_result()

print(response)
```
{: codeblock}
{: python}

```go
deleteAttachmentOptions := service.NewDeleteAttachmentOptions(
  "products",
  "small-appliances:100001",
  "product_details.txt",
)
deleteAttachmentOptions.SetRev("4-1a0d1cd6f40472509e9aac646183736a")

documentResult, response, err := service.DeleteAttachment(deleteAttachmentOptions)
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

If the deletion is successful,
the response includes `"ok": true`,
and the ID and new revision of the document.

See the following example response after a successful delete of an attachment:

```json
{
	"ok": true,
	"id": "DocID",
	"rev": "3-aedfb06537c1d77a087eb295571f7fc9"
}
```
{: codeblock}

## Inline
{: #inline}

Inline attachments are attachments that are included as part of the JSON content.
The content must be provided by using [BASE64](https://en.wikipedia.org/wiki/Base64){: external} representation,
as shown in the example.

A full list of media types is available in the [media types](https://en.wikipedia.org/wiki/Internet_media_type#List_of_common_media_types){: external} article.

See the following example JSON document that includes an inline attachment of a jpeg image:

```json
{
	"_id":"document_with_attachment",
	"_attachments":
	{
		"name_of_attachment": {
			"content_type":"image/jpeg",
			"data": "iVBORw0KGgoAA... ...AASUVORK5CYII="
		}
	}
}
```
{: codeblock}

## Performance considerations
{: #performance-considerations}

While document attachments are useful,
they do have implications for application performance.
In particular,
having too many attachments can have an adverse performance impact during replication.

For example,
if your application requires storage for multiple images as attachments or includes large images,
you must use an alternative [BLOB](https://en.wikipedia.org/wiki/Binary_large_object){: external}
storage mechanism to store the images.
You might then use {{site.data.keyword.cloudant_short_notm}} to keep
the image metadata,
such as URLs to the BLOB store.

You might find it helpful to do performance testing for your specific application
to determine which approach works best for your circumstances.
