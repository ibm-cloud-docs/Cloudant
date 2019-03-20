---

copyright:
  years: 2017, 2019
lastupdated: "2019-03-18"

keywords: db2 warehouse on cloud, disabled javascript constructors, virtual hosts, 500 responses, error handling, couchdb versions, error message changed, x-frame-options setting 

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

<!-- Acrolinx: 2017-05-10 -->

# Deprecations
{: #deprecations}

Summary of the changes in behavior for {{site.data.keyword.cloudantfull}} releases. 
{: shortdesc}

## {{site.data.keyword.dashdbshort_notm}} feature is deprecated (February 7, 2018)
{: #cloudant-nosql-db-feature-is-deprecated-february-7-2018}

To find alternatives to {{site.data.keyword.cloudant_short_notm}}'s {{site.data.keyword.dashdblong}} feature, see the 
[data-flow-examples repository ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant-labs/data-flow-examples){: new_window} 
for tutorials on 
extracting {{site.data.keyword.cloudant_short_notm}} documents and writing the data to a 
{{site.data.keyword.dashdbshort_notm}} table.

### Extracting {{site.data.keyword.dashdbshort_notm}} login information for stopped Warehouse Jobs
{: #extracting-db2-warehouse-on-cloud-login-information-for-stopped-warehouse-jobs}

Before you can sign in to the {{site.data.keyword.dashdbshort_notm}} console, you need the URL and credentials. This information is located in the warehouser document. 

To retrieve information from the warehouser document, you must run the following curl command:

```curl
curl -u $USERNAME https://$ACCOUNT.cloudant.com/_warehouser/$DOCUMENT_ID
```

For most {{site.data.keyword.cloud}} users, the $USERNAME and $ACCOUNT values are the same. 

Before you run the command, replace `$DOCUMENT_ID` with `example@source-db`. In this case, `example` is the warehouser document's name, and `source-db` is the source database's name that is used for replicating {{site.data.keyword.cloudant_short_notm}} to Db2:

```curl
curl -u $USERNAME https://$ACCOUNT.cloudant.com/_warehouser/example@source-db
```

_Example response when you search for information in the warehouser document:_

```http
{
  "_id": "example@source-db",
  "dashboard_url": "https://dashdb-entry-yp-lon02-01.services.eu-gb.bluemix.net/login",
  "dynamite_token": "XXXXXXXX",
  "target": "jdbc:db2://dashdb-entry-yp-lon02-01.services.eu-gb.bluemix.net:50000/BLUDB",
  "dynamite_user": "dash12345",
  ...
}
```

The information returned in the previous example is described in the following list:

<table border='1'>

<tr>
<th id="field">Field</th><th id="description" colspan='4'>Description</th>
</tr>
<tr>
<td headers="field"><p><code>_id</code></p></td>
<td headers="description">ID of the _warehouser document</td>
</tr>
<tr>
<td headers="field"><p><code>dashboard_url</code></p></td>
<td headers="description"><p>URL of the {{site.data.keyword.dashdbshort_notm}} console</p></td>
</tr>
<tr>
<td headers="field"><p><code>dynamite_token</code></p></td>
<td headers="description"><p>Db2 password</p></td>
</tr>
<tr>
<td headers="field"><p><code>target</code></p></td>
<td headers="description"><p>Db2 JDBC connection URL, only used if the value for <code>dashboard_url</code> is null</p></td>
</tr>
<tr>
<td headers="field"><p><code>dynamite_user</code></p></td>
<td headers="description"><p>Db2 user name</p></td>
</tr>
</tr>
</table>

To sign in to the {{site.data.keyword.dashdbshort_notm}} console, you need to remember the values for each of the following fields that are taken from the previous response example: `dynamite_user`, `dynamite_token`, and `dashboard_url`.
       
1 - From a browser, go to the {{site.data.keyword.dashdbshort_notm}} console by using the value in the `dashboard_url` field.  

To sign in to the {{site.data.keyword.dashdbshort_notm}} console, use the value from the `dashboard_url` field. If the value for the `dashboard_url` field is `null`, you can use the host value from the `target` field to create the URL for signing in to the console. For example, the host value for the `target` field from the previous example output is `dashdb-entry-yp-lon02-01.services.eu-gb.bluemix.net`. If you add the protocol `https` and the postfix `login`, you can sign in with the following URL: `https://dashdb-entry-yp-lon02-01.services.eu-gb.bluemix.net/login`.
{: note}

2 - To sign in, use the value of the `dynamite_user` field as your user name and the `dynamite_token` field as your password.

## Disabled JavaScript constructors (December 7, 2017)
{: #disabled-javascript-constructors-december-7-2017}

- If a user calls the disabled JavaScript constructors, `eval()` or `Function()`, an error message
similar to this is returned, "Call to `eval()` was blocked by CSP." You can fix the problem 
by replacing `eval()` calls with the calls from the 
[expr-eval library](https://github.com/silentmatt/expr-eval).
For more information, you can also read this 
[post](https://silentmatt.com/javascript-expression-evaluator/).

## Removed support for virtual hosts (vhosts) (December 4, 2017)
{: #disabled-vhosts-december-4-2017}

- On December 4th, 2017, {{site.data.keyword.cloudant_short_notm}} disabled the virtual host functionality. Support for insecure HTTP connections was removed in favor of HTTPS only. As a result of turning off HTTP support, the virtual hosts feature is no longer available since use of virtual hosts precludes secure HTTPS connections. Previous users of the virtual host feature need to make alternative arrangements to present a chosen host name to your clients from your application and use HTTPS connections only.

## Error handling
{: #error-handling}

- If you rely on 500 replies for your application, you might have issues. To fix the problem, 
update your application to rely on 400 responses. 

- If you do not handle reduce overflow errors as part of a row in the response body, 
you will have issues. To fix this problem, change the application to handle the errors 
from view requests.  

## Incompatibility between CouchDB version 1.6 and {{site.data.keyword.cloudant_short_notm}} version 2.0.0
{: #incompatibility-between-couchdb-version-1-6-and-ibm-cloudant-version-2-0-0}

- An incompatibility exists between the most recent version of {{site.data.keyword.cloudant_short_notm}} and CouchDB 1.6-based codebase. In the older version of {{site.data.keyword.cloudant_short_notm}}, if you add a query parameter ("reduce=false") to the request body, the parameter 
in the request body is ignored while the parameter in the request URL is respected. In recent versions of 
{{site.data.keyword.cloudant_short_notm}}, the query parameter ("reduce=false") in the request body is not ignored.

## Revised error message
{: #revised-error-message}

- The error message that occurs when you attempt to put a document attachment with a non-existent revision has changed to a 409 error with the following information:

	```
	{"error":"not_found","reason":"missing_rev"}
	```

## X-Frame-Options setting (August 17, 2017)
{: #x-frame-options-setting}

The `X-Frame-Options` setting is a response header that controls whether an HTTP response can be embedded in a `<frame>`, `<iframe>`, or `<object>`. This security feature helps prevent clickjacking.

You can configure this option based on your CORS settings. If CORS is enabled, `X-Frame-Options` are automatically enabled and send the response header, `X-Frame-Options: DENY`, by default. If a request HOST header matches the URL listed in the origins section of CORS, an `X-Frame-Options: ALLOW-FROM URL` response header is returned.
 
This change might impact customers who are accessing the database directly from the browser. If you see the error message, "X-Frame-Options: DENY", 
and it is breaking your service, you must enable CORS, [Setting the CORS configuration](/docs/services/Cloudant?topic=cloudant-cors#setting-the-cors-configuration). After you enable CORS, add the value of the HOST header that you send in the request 
to the list of allowed `origins`.

## `dbcopy` (February 4, 2016)
{: #-dbcopy-february-4-2016-}

- The `dbcopy` feature can cause problems under some circumstances.
  Information about the feature has been removed from the documentation.
  Use of `dbcopy` is strongly discouraged.
