---

copyright:
  years: 2015, 2022
lastupdated: "2022-03-17"

keywords: http headers, response headers, request headers, http status codes

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

# How HTTP works with {{site.data.keyword.cloudant_short_notm}}
{: #how-http-works-with-cloudant}

Learn details about the HTTP headers you need to know when you use {{site.data.keyword.cloudantfull}}.
{: shortdesc}

## HTTP headers
{: #http-headers}

Because {{site.data.keyword.cloudant_short_notm}} uses HTTP for all external communication,
you need to ensure that the correct HTTP request headers are supplied and processed on retrieval.
This course of action ensures that you get the correct format and encoding.
Different environments and clients are more or less strict on the effect of these HTTP headers,
especially when they are not present.
To reduce the likelihood of problems or unexpected behavior,
you must be as specific as possible.

### Request headers
{: #request-headers}

The supported HTTP request headers are shown in the following list:

*	`Accept`
*	`Content-Type`
*	`Content-Encoding`
*	`If-None-Match`

#### Accept
{: #accept}

The `Accept` header specifies the list of potential data types that are returned by the server that would be
accepted and understood by the client.
The format is a list of one or more MIME types,
which are separated by colons.

For the most requests,
the accepted list must include JSON data (`application/json`).

For attachments,
you can either specify the MIME type explicitly,
or use `*/*` to specify that all file types are supported.

If the `Accept` header is not supplied,
then the server assumes the `*/*` MIME type,
which means that the client accepts all formats.

See the following example of sending a request without an explicit `Accept` header, or when you specify `*/*`:

```http
GET /recipes HTTP/1.1
Host: username.cloudant.com
Accept: */*
```
{: codeblock}

See the following example of a returned header when the client is assumed to accept all formats:

The returned content type is `text/plain` even though the information that is returned by the request is in JSON format.
{: note}

```http
Server: CouchDB/1.0.2 (Erlang OTP/R14B)
Date: Thu, 13 Jan 2011 13:39:34 GMT
Content-Type: text/plain;charset=utf-8
Content-Length: #7
Cache-Control: must-revalidate
```
{: codeblock}

The use of `Accept` in queries to {{site.data.keyword.cloudant_short_notm}} is not required,
but is highly recommended as it helps to ensure that the data returned can be processed by the client.

If you specify a data type that uses the `Accept` header,
{{site.data.keyword.cloudant_short_notm}} honors the specified type in the `Content-type` header field of responses.
For example,
if you explicitly request `application/json` in the `Accept` of a request,
the returned HTTP headers use this value in the returned `Content-type` field.

See the following example request that explicitly specifies the `Accept` header:

```http
GET /recipes HTTP/1.1
Host: username.cloudant.com
Accept: application/json
```
{: codeblock}

See the following example of the headers returned in response, including the `application/json` content type:

```http
Server: CouchDB/1.0.2 (Erlang OTP/R14B)
Date: Thu, 13 Jan 2011 13:40:11 GMT
Content-Type: application/json
Content-Length: #7
Cache-Control: must-revalidate
```
{: codeblock}

#### Content-Type for request headers
{: #content-type-for-request-headers}

The `Content-Type` header specifies the content type of the information that is supplied within the request.
The specification uses MIME type specifications.
For most requests,
the content type is JSON (`application/json`).

For some settings, the MIME type is plain text.

In particular,
when you upload attachments the type must be the corresponding
MIME type for the attachment or binary (`application/octet-stream`).

The use of the `Content-Type` on a request is highly recommended.

#### Content-Encoding
{: #content-encoding}

The `Content-Encoding` header specifies the encoding of the request body.
The supported value is `gzip`.
If the header is used,
the request body must be encoded with the corresponding format.

See the following example of creating a compressed (`gzipped`) request body:

```sh
# create gzipped document
echo '{"foo":"bar"}' | gzip > doc.gzip
```
{: codeblock}

See the following example of sending a gzip-encoded request body to create a document by using HTTP:

```http
PUT /db/doc HTTP/1.1
HOST: example.cloudant.com
Content-Encoding: gzip
```
{: codeblock}

See the following example of sending a gzip-encoded request body to create a document by using the command line:

```sh
curl "https://example.cloudant.com/db/doc" \
	-X PUT \
	-T doc.gzip \
	-H "Content-Encoding: gzip"
```
{: codeblock}

By default, the SDKs compress the request body.
{: tip}

#### If-None-Match
{: #if-none-match}

The `If-None-Match` header is optional.
You might send it to determine whether a document was modified since it was last read or updated.
The value of the `If-None-Match` header must match the last [`Etag`](#etag) value received.
If the value matches the current revision of the document,
the server sends a [`304 Not Modified`](/apidocs/cloudant#list-of-http-codes){: external} status code,
and the response itself has no body.

If the document was modified,
you get a normal [`200` response](/apidocs/cloudant#list-of-http-codes){: external},
provided the document still exists and no other errors occurred.

### Response headers
{: #response-headers}

Response headers are returned by the server when you send back content.
They include a number of different fields. Many of the fields are standard HTTP response headers and have no significance regarding how {{site.data.keyword.cloudant_short_notm}} operates.
The supported HTTP response headers that are important to {{site.data.keyword.cloudant_short_notm}} are as shown in the following list.

*	`Cache-Control`
*	`Content-Length`
*	`Content-Type`
*	`Etag`

#### Cache-Control
{: #cache-control}

The `Cache-Control` HTTP response header provides a suggestion for the client cache mechanisms
on how to treat the returned information.
{{site.data.keyword.cloudant_short_notm}} typically returns the `must-revalidate` value,
which indicates that the information must be revalidated if possible.
Revalidation ensures that the dynamic nature of the content is correctly updated.

#### Content-Length
{: #content-length}

The `Content-Length` header reports the length in bytes of the returned content.

#### Content-Type for response headers
{: #content-type-for-response-headers}

The `Content-Type` header specifies the MIME type of the returned data.
For most request,
the returned MIME type is `text/plain`.
All text is encoded in Unicode (UTF-8),
which is explicitly stated in the returned `Content-Type` as `text/plain;charset=utf-8`.

#### `Etag`
{: #etag}

The `Etag` header is used to show the revision for a document.
For documents,
the value is identical to the revision of the document.
The value can be used with an `If-None-Match` request header
to get a [`304 Not Modified`](/apidocs/cloudant#list-of-http-codes){: external} response if the revision is still current.

ETags cannot currently be used with views,
since the ETags returned from those requests are random numbers that change on every request.

