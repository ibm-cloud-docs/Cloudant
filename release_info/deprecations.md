---

copyright:
  years: 2017, 2018
lastupdated: "2018-05-31"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2018-05-31 -->

# Deprecations
{: #deprecations}

Summary of the changes in behavior for {{site.data.keyword.cloudantfull}} releases. 
{:shortdesc}

## {{site.data.keyword.dashdbshort_notm}} feature is deprecated (February 7, 2018)
{: #cloudant-nosql-db-feature-is-deprecated-february-7-2018}


## Disabled JavaScript constructors (December 7, 2017)
{: #disabled-javascript-constructors-december-7-2017}

- If a user calls the disabled JavaScript constructors, `eval()` or `Function()`, an error message
similar to this is returned, "Call to `eval()` was blocked by CSP." You can fix the problem 
by replacing `eval()` calls with the calls from the 
[expr-eval library](https://github.com/silentmatt/expr-eval).
For more information, you can also read this 
[post](https://silentmatt.com/javascript-expression-evaluator/).

## Error handling

- If you rely on 500 replies for your application, you might have issues. To fix the problem, 
update your application to rely on 400 responses. 

- If you do not handle reduce overflow errors as part of a row in the response body, 
you will have issues. To fix this problem, change the application to handle the errors 
from view requests.  

## Incompatibility between CouchDB version 1.6 and {{site.data.keyword.cloudant_short_notm}} version 2.0.0

- An incompatibility exists between the most recent version of {{site.data.keyword.cloudant_short_notm}} and CouchDB 1.6-based codebase. In the older version of {{site.data.keyword.cloudant_short_notm}}, if you add a query parameter ("reduce=false") to the request body, the parameter 
in the request body is ignored while the parameter in the request URL is respected. In recent versions of 
{{site.data.keyword.cloudant_short_notm}}, the query parameter ("reduce=false") in the request body is not ignored.

## Revised error message

- The error message that occurs when you attempt to put a document attachment with a non-existent revision has changed to a 409 error with the following information:

	```
	{"error":"not_found","reason":"missing_rev"}
	```

## X-Frame-Options setting (August 17, 2017)
{: #x-frame-options-setting}

The `X-Frame-Options` setting is a response header that controls whether an HTTP response can be embedded in a `<frame>`, `<iframe>`, or `<object>`. This security feature helps prevent clickjacking.

You can configure this option based on your CORS settings. If CORS is enabled, `X-Frame-Options` are automatically enabled and send the response header, `X-Frame-Options: DENY`, by default. If a request HOST header matches the URL listed in the origins section of CORS, an `X-Frame-Options: ALLOW-FROM URL` response header is returned.
 
This change might impact customers who are accessing the database directly from the browser. If you see the error message, "X-Frame-Options: DENY", 
and it is breaking your service, you must enable CORS, [Setting the CORS configuration](../api/cors.html#setting-the-cors-configuration). After you enable CORS, add the value of the HOST header that you send in the request 
to the list of allowed `origins`.

## `dbcopy` (February 4, 2016)

- The `dbcopy` feature can cause problems under some circumstances.
  Information about the feature has been removed from the documentation.
  Use of `dbcopy` is strongly discouraged.