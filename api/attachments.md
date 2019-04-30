---

copyright:
  years: 2015, 2019
lastupdated: "2019-04-23"

keywords: create, update, read, delete, inline, performance considerations

subcollection: cloudant

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

<!-- Acrolinx: 2018-05-31 -->

# Attachments
{: #attachments}

Another way to store data is to use attachments.
Attachments are Binary Large Object ([BLOB ![External link icon](../images/launch-glyph.svg "External link icon")](http://en.wikipedia.org/wiki/Binary_large_object){: new_window})
files that are contained within documents.
{: shortdesc}

The BLOB is stored in the `_attachments` component of the document.
The BLOB holds data that includes:

-	The attachment name.
-	The type of the attachment.
-	The actual content.

Examples of BLOBs would be images and multimedia.

If you include the attachment as an [inline](/docs/services/Cloudant?topic=cloudant-attachments#inline) component of the overall JSON, the attachment content is represented by using BASE64 form.
{: note}

The content type corresponds to a [MIME type ![External link icon](../images/launch-glyph.svg "External link icon")](http://en.wikipedia.org/wiki/Internet_media_type#List_of_common_media_types){: new_window}.
For example,
if you want to attach a `.jpg` image file to a document,
you specify the attachment MIME type as `image/jpeg`.

It is a good idea to keep attachments small in size and number because attachments can impact performance.
{: important}

## Create / update
{: #create-update}

To create a new attachment at the same time as creating a new document, include the attachment as an [inline](/docs/services/Cloudant?topic=cloudant-attachments#inline) component of the JSON content.

To create a new attachment on an existing document,
or to update an attachment on a document,
make a PUT request with the document's most recent `_rev` to `https://$ACCOUNT.cloudant.com/$DATABASE/$DOCUMENT_ID/$ATTACHMENT`.
The attachment's [content type ![External link icon](../images/launch-glyph.svg "External link icon")](http://en.wikipedia.org/wiki/Internet_media_type#List_of_common_media_types){: new_window}
must be specified by using the `Content-Type` header.
The `$ATTACHMENT` value is the name by which the attachment is associated with the document.

You can create more than one attachment for a document by ensuring that the `$ATTACHMENT` value for each attachment is unique within the document.
{: tip}

_Example instruction for creating or updating an attachment, by using HTTP:_

```HTTP
PUT /$DATABASE/$DOCUMENT_ID/$ATTACHMENT?rev=$REV HTTP/1.1
Content-Type: $$ATTACHMENT_MIME_TYPE
```
{: codeblock}

_Example instruction for creating or updating an attachment, by using the command line:_

```sh
curl https://$ACCOUNT.cloudant.com/$DATABASE/$DOCUMENT_ID/$ATTACHMENT?rev=$REV \
	 -X PUT \
	 -H "Content-Type: $ATTACHMENT_MIME_TYPE" \
	 --data-binary @$ATTACHMENT_FILEPATH
```
{: codeblock}

<!--

_Example instruction for creating or updating an attachment, using Javascript:_

```javascript
var nano = require('nano');
var fs = require('fs');
var account = nano("https://$ACCOUNT:$PASSWORD@$ACCOUNT.cloudant.com");
var db = account.use($DATABASE);
fs.readFile($FILEPATH, function (err, data) {
	if (!err) {
		db.attachment.insert($DOCUMENT_ID, $ATTACHMENT, data, $ATTACHMENT_MIME_TYPE, {
			rev: $REV
		},
		function (err, body) {
			if (!err)
				console.log(body);
		}
	}
});
```
{: codeblock}

-->

The response contains the document ID and the new document revision.

Attachments do not have their own revisions. Instead, when you update or create an attachment, it changes the revision of the document it is attached to. 
{: tip}

_Example response:_

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

_Example of reading an attachment, by using HTTP:_

```http
GET /$DATABASE/$DOCUMENT_ID/$ATTACHMENT HTTP/1.1
```
{: codeblock}

_Example of reading an attachment, by using the command line:_

```sh
curl https://$ACCOUNT.cloudant.com/$DATABASE/$DOCUMENT_ID/$ATTACHMENT \
	 -u $ACCOUNT blob_content.dat
# store the response content into a file for further processing.
```
{: codeblock}

<!--

_Example of reading an attachment, using Javascript:_

```javascript
var nano = require('nano');
var account = nano("https://$ACCOUNT:$PASSWORD@$ACCOUNT.cloudant.com");
var db = account.use($DATABASE);
db.attachment.get($DOCUMENT_ID, $FILENAME, function (err, body) {
	if (!err) {
		console.log(body);
	}
});
```
{: codeblock}

-->

## Delete an attachment
{: #delete-an-attachment)

To delete an attachment,
make a `DELETE` request with the document's most recent `_rev`
to `https://$ACCOUNT.cloudant.com/$DATABASE/$DOCUMENT_ID/$ATTACHMENT`.
If you do not supply the most recent `_rev`,
the response is a [409 error](/docs/services/Cloudant?topic=cloudant-http#http-status-codes).

_Example of deleting an attachment, by using HTTP:_

```http
DELETE /$DATABASE/$DOCUMENT_ID/$ATTACHMENT?rev=$REV HTTP/1.1
```
{: codeblock}

_Example of deleting an attachment, by using the command line:_

```sh
curl https://$ACCOUNT.cloudant.com/$DATABASE/$DOCUMENT_ID/$ATTACHMENT?rev=$REV \
	-u $ACCOUNT \
	-X DELETE
```
{: codeblock}

<!--

_Example of deleting an attachment, using Javascript:_

```javascript
var nano = require('nano');
var account = nano("https://$ACCOUNT:$PASSWORD@$ACCOUNT.cloudant.com");
var db = account.use($DATABASE);
db.attachment.destroy($DOCUMENT_ID, $FILENAME, $REV, function (err, body) {
	if (!err) {
		console.log(body);
	}
});
```
{: codeblock}

-->

If the deletion is successful,
the response contains `"ok": true`,
and the ID and new revision of the document.

_Example response after a successful delete of an attachment:_

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
The content must be provided by using [BASE64 ![External link icon](../images/launch-glyph.svg "External link icon")](https://en.wikipedia.org/wiki/Base64){: new_window} representation,
as shown in the example.

A full list of media types is available in this article about [media types ![External link icon](../images/launch-glyph.svg "External link icon")](http://en.wikipedia.org/wiki/Internet_media_type#List_of_common_media_types){: new_window}.

_Example JSON document that includes an inline attachment of a jpeg image:_

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
if your application requires lots of images to be stored as attachments,
or has large images,
a better approach would be to use an alternative [BLOB ![External link icon](../images/launch-glyph.svg "External link icon")](https://en.wikipedia.org/wiki/Binary_large_object){: new_window}
storage mechanism for the images.
You might then use {{site.data.keyword.cloudant_short_notm}} to keep
the image metadata,
such as URLs to the BLOB store.

You might find it helpful to do performance testing for your specific application
to determine which approach works best for your circumstances.