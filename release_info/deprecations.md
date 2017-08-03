---

copyright:
  years: 2017
lastupdated: "2017-07-12"

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

-   An incompatibility exists between CouchDB version 1.6 and Cloudant version 2.0.0. In CouchDB version 1.6, if you 
    add a query parameter ("reduce=false") to the request body, the parameter in the request body is ignored while the 
    parameter in the request URL is respected. In Cloudant version 2.0.0, the query parameter ("reduce=false") in the 
    request body is not ignored. 

## Revised error message

- The error message that occurs when you attempt to put a document attachment with a non-existent revision has changed to a 409 error with the following information:

	```
	{"error":"not_found","reason":"missing_rev"}
	```

## X-Frame-Options

The `X-Frame-Options` setting is a response header that controls whether an HTTP response can be embedded in a `<frame>`, `<iframe>`, or `<object>`. This security feature helps prevent clickjacking.

You can configure this option based on your CORS settings. If CORS is enabled, `X-Frame-Options` are automatically enabled and send the response header, `X-Frame-Options: DENY`, by default. If a request HOST header matches the URL listed in the origins section of CORS, an `X-Frame-Options: ALLOW-FROM URL` response header is returned.
 
This change might impact customers who are accessing the database directly from the browser. If you see the error message, "X-Frame-Options: DENY", 
and it is breaking your service, you must enable CORS, [Setting the CORS configuration](../api/cors.html#setting-the-cors-configuration). After you enable CORS, add the value of the HOST header that you send in the request 
to the list of allowed `origins`.

## Active tasks

-   Indexer entries in the `_active_tasks` response no longer report the `user` field.
-   Search indexer entries in the `_active_tasks` response no longer report the `user` field.

## Views

-   Unicode normalization of key values is consistent between reduced and non-reduced view results. If raw collation is specified in a design document, result order might change as the result of this fix.
-   When you query a view or `_all_docs` database, it is an error to specify the `keys` parameter and any of the `key`, `startkey`, and `endkey` parameters.
-   It is an error to pass `startkey` and `endkey` parameters to a view if it is impossible for any row to match. For example, when the `startkey` parameter is higher than the `endkey` parameter for `descending=false`, or when the `startkey` parameter is lower than the `endkey` parameter for `descending=true`, Cloudant returns the `400 Bad Request` error.
-   When `dbcopy` is configured in a view document, it is automatically transformed to the `options` field in a design document. 

## Design documents

-   Stricter validation of design documents. This validation is not expected to cause problems with existing design documents, but malformed design documents fail to save.
-   Views that are written in an unsupported language all respond with an `error` of `unknown_query_language`. Previously, the response was a `reason` of `unknown_query_language`.
-   When a null reducer is used to put a database design document, the system responds with the error reason of `'(null)'`, previously it returned `((new String("null")))`.
-   If `updates` is specified in a design document, it must not have a null value.

## Authentication

-   The `_session` metadata `authentication_handlers` no longer contains `["delegated", "local"]`.

## User documents

-   Validate the structure of user documents created in the `_users` database. After the DBNext upgrade, the user documents must comply with ASF CouchdDB requirements. Previously, Cloudant did not validate the user documents' structure. 

## Replication 

-   Replicator documents preserve the last error message in the `_replication_state_reason` JSON field. The field remains even after replication restarts and is in the `triggered` state. This change helps the replicator code detect and avoid writing the same error to the document repeatedly.
-   An error during replication does not update the replication document unless the reason for the error changes. Previously, when an error occurred during replication, an infinite loop started that generated sizable shards.  

## Result set

-   The `_db_updates` endpoint returns a result set containing a key that is named  `db_name`. Previously, it returned a result set with a key named `dbname`.
-   Set the maximum length of the document ID. Previously, it was not possibly to define a maximum document ID length.

## `dbcopy`

- The `dbcopy` feature can cause problems under some circumstances.
  Information about the feature has been removed from the documentation.
  Use of `dbcopy` is strongly discouraged.
