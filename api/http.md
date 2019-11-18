---

copyright:
  years: 2015, 2019
lastupdated: "2019-11-18"

keywords: http headers, response headers, http status codes

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
{:external: target="_blank" .external}

<!-- Acrolinx: 2019 -->

# HTTP
{: #http}

Learn details about the [HTTP headers](#http-headers)
and [HTTP status codes](#http-status-codes) you need to know when you use {{site.data.keyword.cloudantfull}}.
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

The supported HTTP request headers include:

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
the accepted list should include JSON data (`application/json`).

For attachments,
you can either specify the MIME type explicitly,
or use `*/*` to specify that all file types are supported.

If the `Accept` header is not supplied,
then the server assumes the`*/*` MIME type,
which means that the client accepts all formats.

See the following example of sending a request without an explicit `Accept` header, or when when you specify `*/*`:

```http
GET /recipes HTTP/1.1
Host: username.cloudant.com
Accept: */*
```
{: codeblock}

See the following example of a returned header when the client is assumed to accept all formats:

The returned content type is `text/plain` even though the information that is returned by the request is in JSON format.
{: note}

```
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

```
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
For the most requests,
the content type is JSON (`application/json`).

For some settings, the MIME type is plain text.

In particular,
when you upload attachments the type must be the corresponding
MIME type for the attachment or binary (`application/octet-stream`).

The use of the `Content-Type` on a request is highly recommended.

#### Content-Encoding
{: #content-encoding}

The `Content-Encoding` header specifies the encoding of the request body.
Supported values are `gzip` and `deflate`.
If the header is used,
the request body must be encoded with the corresponding format.

See the following example of creating a gzipped request body:

```sh
# create gzipped document
echo '{"foo":"bar"}' | gzip >doc.gzip
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

#### If-None-Match
{: #if-none-match}

The `If-None-Match` header is optional.
You might send it to determine whether a document was modified since it was last read or updated.
The value of the `If-None-Match` header must match the last [`Etag`](#etag) value received.
If the value matches the current revision of the document,
the server sends a [`304 Not Modified`](#http-status-codes) status code,
and the response itself has no body.

If the document was modified,
you get a normal [`200` response](#http-status-codes),
provided the document still exists and no other errors occurred.

### Response headers
{: #response-headers}

Response headers are returned by the server when you send back content.
They include a number of different fields. Many of the fields are standard HTTP response headers and have no significance with regard to how {{site.data.keyword.cloudant_short_notm}} operates.
The list of response headers important to {{site.data.keyword.cloudant_short_notm}} is as follows.

The supported HTTP response headers include:

*	`Cache-Control`
*	`Content-Length`
*	`Content-Type`
*	`Etag`

The {{site.data.keyword.cloudant_short_notm}} design document API and the functions when it returns HTML (for example as part of a show or list)
enable you to include custom HTTP headers through the `headers` field of the return object.

#### Cache-Control
{: #cache-control}

The `Cache-Control` HTTP response header provides a suggestion for client caching mechanisms
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

#### Etag
{: #etag}

The `Etag` header is used to show the revision for a document,
or the response from a show function.
For documents,
the value is identical to the revision of the document.
The value can be used with an `If-None-Match` request header
to get a [`304 Not Modified`](#http-status-codes) response if the revision is still current.

ETags cannot currently be used with views or lists,
since the ETags returned from those requests are random numbers that change on every request.

## HTTP status codes
{: #http-status-codes}

The interface to {{site.data.keyword.cloudant_short_notm}} works through HTTP. Therefore, error codes and statuses are reported by using a combination of the HTTP status code number, and corresponding data in the body of the response data.

A list of the error codes that are returned by {{site.data.keyword.cloudant_short_notm}} and generic descriptions of the related errors are as follows.
The meaning of different status codes for specific request types is provided in the corresponding API call reference.

Code                                    | Meaning
----------------------------------------|--------
`200 - OK`                              | Request completed successfully.
`201 - Created`                         | Resource that is created or updated successfully. The resource could be a database or a document, for example.
`202 - Accepted`                        | Request was accepted, but the [quorum](/docs/services/Cloudant?topic=cloudant-documents#quorum-writing-and-reading-data) for the operation was not met.
`304 - Not Modified`                    | The content that is requested was not modified. This error is used with the [ETag](#etag) system to identify the version of information returned.
`400 - Bad Request`                     | Bad request structure. The error can indicate an error with the request URL, path, or headers. Differences in the supplied MD5 hash and content also trigger this error, as this error might indicate message corruption.
`401 - Unauthorized`                    | The item requested was not available with the supplied authorization, or authorization was not supplied.
`402 - Payment required`                | Either the data quota on the Lite plan was exceeded, or the account is in arrears. You can delete data or upgrade to the Standard plan, or bring the account up-to-date.
`403 - Forbidden`                       | The requested item or operation is forbidden.
`404 - Not Found`                       | The requested resource could not be found. The content includes further information as a JSON object, if available. The structure contains two keys, `error` and `reason`, similar to the following example: `{ "error":"not_found", "reason":"no_db_file" }`
`405 - Resource Not Allowed`            | A request was made by using an invalid HTTP request type for the URL requested. For example, you requested a `PUT` when a `POST` is required. Errors of this type can also be triggered by invalid URL strings.
`406 - Not Acceptable`                  | The requested content type is not supported by the server.
`409 - Conflict`                        | Request resulted in an update conflict.
`412 - Precondition Failed`             | The request headers from the client and the capabilities of the server do not match.
`413 - Request Entity Too Large`        | The maximum request body size for an API request sent to {{site.data.keyword.cloudant_short_notm}} on {{site.data.keyword.cloud}} is 1 MB.
`415 - Bad Content Type`                | The content types supported, and the content type of the information that was requested or submitted, indicate that the content type is not supported.
`416 - Requested Range Not Satisfiable` | The range that is specified in the request header cannot be satisfied by the server.
`417 - Expectation Failed`              | When you send documents in bulk, the bulk-load operation fails.
`429 - Too Many Requests`               | The user sent too many requests in a specific amount of time. More information is available in the corresponding [RFC 6585](https://tools.ietf.org/html/rfc6585#page-3){: new_window}{: external}.
`500 - Internal Server Error`           | The request was invalid, either because the supplied JSON was invalid, or invalid information was supplied as part of the request. Alternatively, a replication was canceled while in progress.
`503 - Service Unavailable`             | The request could not be processed. Seeing this response follow an {{site.data.keyword.cloudant_short_notm}} request might indicate a misspelled {{site.data.keyword.cloudant_short_notm}} account name.

