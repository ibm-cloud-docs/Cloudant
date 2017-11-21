---

copyright:
  years: 2017
lastupdated: "2017-11-09"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-07-12 -->

# Deprecations

Summary of the changes in behavior for {{site.data.keyword.cloudantfull}} releases. 
{:shortdesc}

## Appropriate 400 response lists reason for failure when no index can fulfill a sort for a `_find` query

- If you rely on 500 replies in your application, this fix might cause a failure. Update your 
application to rely on 400 responses to fix the problem.

## Return reduce overflow errors to the client on `_view` calls. Do not spend RAM building the view when 
there is a bad reduce function. The error returned to the client looks similar to the following error: 

```{
    row": {
        "key": null,
        "id": "error",
        "value": "reduce_overflow_error",
        "reason": Reason
    }
}```
Customers who do not handle errors as part of the row in the response body might have a problem. To fix the problem,
change the application to handle errors from view requests.

## Incompatibility between CouchDB version 1.6 and {{site.data.keyword.cloudant_short_notm}} version 2.0.0

-   An incompatibility exists between the most recent version of {{site.data.keyword.cloudant_short_notm}} and CouchDB 1.6-based codebase. In the older version of {{site.data.keyword.cloudant_short_notm}}, if you add a query parameter ("reduce=false") to the request body, the parameter 
    in the request body is ignored while the parameter in the request URL is respected. In recent versions of 
    {{site.data.keyword.cloudant_short_notm}}, the query parameter ("reduce=false") in the request body is not ignored.

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