---

copyright:
  years: 2017
lastupdated: "2017-12-27"

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

## Cloudant's {{site.data.keyword.dashdbshort_notm}} functionality

{{site.data.keyword.cloudant}}'s {{site.data.keyword.dashdblong}} feature is deprecated and will be withdrawn on the following timeline:

Deprecation date | What is being deprecated
-----------------|--------------------------
January 16, 2018 | Users not using the {{site.data.keyword.dashdblong}} functionality cannot start using it.
March 31, 2018   | New {{site.data.keyword.dashdbshort_notm}} jobs cannot be created by clients who started using the {{site.data.keyword.dashdbshort_notm}} capability before the 16th of January.
May 5, 2018      | Existing {{site.data.keyword.dashdbshort_notm}} jobs will be stopped. Final status can still be viewed on the dashboard.
May 31, 2018     | User interface to {{site.data.keyword.dashdbshort_notm}} feature removed. Status of {{site.data.keyword.dashdbshort_notm}} jobs becomes unavailable.
 
Data that has been transferred to {{site.data.keyword.dashdbshort_notm}} by April 30, 2018 will remain in {{site.data.keyword.dashdbshort_notm}} and {{site.data.keyword.cloudant_short_notm}} data will also be unaffected.

### Alternatives to the {{site.data.keyword.dashdbshort_notm}} feature

Use Apache Spark&trade; in Data Science Experience:

1. [Scala tutorial for saving 'animaldb' database to {{site.data.keyword.dashdbshort_notm}} ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant-labs/sql-cloudant-notebooks/blob/master/save-to-db2-warehouse/animaldb-scala-load-to-dashdb.md){:new_window}

2. [Python tutorial for saving 'animaldb' database to {{site.data.keyword.dashdbshort_notm}} ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant-labs/sql-cloudant-notebooks/blob/master/save-to-db2-warehouse/animaldb-python-load-to-dashdb.md){:new_window}

3. [Python tutorial for saving filtered 'crimes' Spark DataFrame to {{site.data.keyword.dashdbshort_notm}} ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant-labs/sql-cloudant-notebooks/blob/master/save-to-db2-warehouse/crimes-load-to-dashdb-python.md){:new_window}<br>

   [Notebook for above 'crimes' to {{site.data.keyword.dashdbshort_notm}} example ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant-labs/sql-cloudant-notebooks/blob/master/save-to-db2-warehouse/crimes-python-load-to-dashdb.ipynb){:new_window}

4. [Scala tutorial for loading docs and saving filtered 'sales' Spark DataFrame to {{site.data.keyword.Db2_on_Cloud_short}} ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant-labs/sql-cloudant-notebooks/blob/master/save-to-db2-warehouse/sales-continuous-load-cloudant-to-db2.md){:new_window}<br>
   
   [Notebook for above 'sales' example ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant-labs/sql-cloudant-notebooks/blob/master/save-to-db2-warehouse/sales-continuous-load-cloudant-to-db2.ipynb){:new_window}

> **Note**: For the Spark/Bahir sql-cloudant connector solution, customers are responsible for creating and 
modifying the {{site.data.keyword.Db2_on_Cloud_long}} schema. Although customers lose the automated 
functionality of SDP, they now have the power to alter the data coming in to Spark (i.e., filter columns) 
and design the {{site.data.keyword.Db2_on_Cloud_short}} schema.

## Disabled JavaScript constructors

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