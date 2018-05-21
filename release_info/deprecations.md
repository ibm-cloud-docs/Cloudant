---

copyright:
  years: 2017, 2018
lastupdated: "2018-05-21"

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

## {{site.data.keyword.dashdbshort_notm}} feature is deprecated (February 7, 2018)

- You can find alternatives to {{site.data.keyword.dashdblong}} [here](../guides/warehousing.html#deprecating-cloudant-nosql-db-s-db2-warehouse-on-cloud-feature-february-7-2018-). 
- You can find a DB2 instance in the Warehouse documents by using the `_warehouser` endpoint. See the following example, and the fields you can use to find documents:

`GET {$DATABASE}/{$DOCUMENT_ID} = _warehouser/WAREHOUSE_NAME@SOURCE_NAME`

```http
{
  "_id": "dashdb-uk@largedb100g",
  "_rev": "20803-62c183daeb579cb407ff5ef4bc6a96e1",
  "sdp_cluster_threshold": 0.2,
  "replication_status": {
    "largedb100g": {
      "docsSkipped": 0,
      "id": "largedb100g",
      "time": "2018-04-30T18:15:41Z",
      "docsProcessed": 52700744,
      "status": "error",
      "docsSuccess": 21700000,
      "sub_status": "initial",
      "lastSeq": "21600004-g1AAAAG3eJzLYWBgYMlgTmFQSElKzi9KdUhJMtYrSS0uqTQwMtVLzskvTUnMK9HLSy3JAapkSmRIsv___39WBnMSg8_cg7lAMfY0s-Q00xQjIoxAtccIjz1JDkAyqR5mVbynB9gqs9RUC6MkcyJMQbXKEI9VeSxAkqEBSAFt2w-2LlDyCMRnaWZAn6UQYRLxIQix7gDEOmhATjMHW2duYWaUmpZChElZADwVjNs",
      "docsFailed": 21600000,
      "docsWarned": 0
    }
  },
  "default_region": null,
  "create_target": true,
  "write_mode": "update",
  "sample_size": null,
  "dashboard_url": "https://dashdb-entry-yp-lon02-01.services.eu-gb.bluemix.net/login",
  "source_database_name": "largedb100g",
  "dashdb_instance_name": null,
  "jdbcurl": null,
  "dynamite_token": "XXXXXXXX",
  "discovery_status": {
    "largedb100g": {
      "time": "2018-04-30T13:16:50Z",
      "status": "discovering",
      "JSONSchema": "_local/dashdb-uk@largedb100g[0]"
    }
  },
  "external_db2_instance": true,
  "warehouser_error_message": "DB2 SQL Error: SQLCODE=-289, SQLSTATE=57011, SQLERRMC=dash12555space1, DRIVER=4.18.60;DB2 SQL Error: SQLCODE=-289, SQLSTATE=57011, SQLERRMC=dash12555space1, DRIVER=4.18.60;",
  "source": [
    "https://testy-dynamite-003.cloudant.com/largedb100g"
  ],
  "dashdb_instance_id": null,
  "target": "jdbc:db2://dashdb-entry-yp-lon02-01.services.eu-gb.bluemix.net:50000/BLUDB",
  "warehouser_state": "error",
  "warehouser_state_time": "2018-04-30T18:15:41Z",
  "warehouser_error_code": 40012,
  "overwrite_target": true,
  "dynamite_user": "dash12555",
  "warehouser_id": "dashdb-uk",
  "sdp_function": "all_union"
}
```

Field | Description
--------------------
`dashboard_url` | Log in URL to the account you want to search. 
`target` | Db2 Warehouse on Cloud database you want to search. 
`dynamite_user` | 
`dynamite_token` |
`dashdb_instance_name` |
`source` |



## Disabled JavaScript constructors (December 7, 2017)

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