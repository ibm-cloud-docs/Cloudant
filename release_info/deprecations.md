---

copyright:
  years: 2017
lastupdated: "2017-09-22"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-07-12 -->

# Deprecations

Summary of the changes in behavior for Cloudant releases. 
{:shortdesc}

## Incompatibility between CouchDB version 1.6 and Cloudant version 2.0.0

-   An incompatibility exists between the most recent version of Cloudant and CouchDB 1.6-based codebase. In the older version of Cloudant, if you add a query parameter ("reduce=false") to the request body, the parameter 
    in the request body is ignored while the parameter in the request URL is respected. In recent versions of 
    Cloudant, the query parameter ("reduce=false") in the request body is not ignored.

## Revised error message

- The error message that occurs when you attempt to put a document attachment with a non-existent revision has changed to a 409 error with the following information:

	```
	{"error":"not_found","reason":"missing_rev"}
	```

## X-Frame-Options setting

The `X-Frame-Options` setting is a response header that controls whether an HTTP response can be embedded in a `<frame>`, `<iframe>`, or `<object>`. This security feature helps prevent clickjacking.

You can configure this option based on your CORS settings. If CORS is enabled, `X-Frame-Options` are automatically enabled and send the response header, `X-Frame-Options: DENY`, by default. If a request HOST header matches the URL listed in the origins section of CORS, an `X-Frame-Options: ALLOW-FROM URL` response header is returned.
 
This change might impact customers who are accessing the database directly from the browser. If you see the error message, "X-Frame-Options: DENY", 
and it is breaking your service, you must enable CORS, [Setting the CORS configuration](../api/cors.html#setting-the-cors-configuration). After you enable CORS, add the value of the HOST header that you send in the request 
to the list of allowed `origins`.

## - `dbcopy`

- The `dbcopy` feature can cause problems under some circumstances.
  Information about the feature has been removed from the documentation.
  Use of `dbcopy` is strongly discouraged.