---

copyright:
  years: 2017, 2019
lastupdated: "2019-08-27"

keywords: query, response content-type, attachments, disabled javascript constructors, active tasks, views, design documents, authentication, user documents, replication, result set

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

# Differences between major {{site.data.keyword.cloudant_short_notm}} releases
{: #differences-between-major-cloudant-nosql-db-releases}

Summary of the changes in behavior between the most recent version of 
{{site.data.keyword.cloudantfull}} and CouchDB 1.6-based codebase. Information is added as newer {{site.data.keyword.cloudant_short_notm}} 
versions are released.
{: shortdesc}
 
## Incompatibilities
{: #incompatibilities}

### Query and index selection
{: #query-and-index-selection}

- {{site.data.keyword.cloudant_short_notm}} Query uses a new method to select an index. Learn more about [{{site.data.keyword.cloudant_short_notm}} Query index selection](http://www-01.ibm.com/support/docview.wss?uid=swg22011923){: new_window}{: external}.
 
### Response Content-Type
{: #response-content-type-changes}

- The default response content-type changed from `text/plain` to `application/json`. 
Previously, in the CouchDB 1.6-based release, the content-type of JSON database 
responses was `text/plain` unless the client explicitly stated `Accept: application/json`. 
In newer releases, and for all future releases, the 
response content-type is `application/json`. 

### Default response format
{: #default-response-format}

<ul><li>Change in default response format for retrieving documents that use `attachments=true` query string parameter. 
<p>A call to retrieve a document and its attachment (<code>GET /db/doc?attachments=true</code>) can return data in either a JSON or <code>multipart/related</code> format. An explicit <code>Accept</code> is used to switch between the two.</p>

<p>Previously, a call to retrieve a document and all its attachments would return the <code>application/json</code> format if no <code>Accept</code> header was provided. Now, the default is to provide a <code>multipart/related</code> body. This change was made because the <code>multipart/related</code> format is more efficient to generate.</p>

<p>If your application is expecting an <code>application/json</code> response, the <code>Accept: application/json</code> header now needs to be explicitly set.</p>
</li></ul>

### Disabled JavaScript constructors
{: #disabled-javascript-constructors}

- For security reasons, by default, the use of `eval()` and `Function()` constructors is disabled in 
JavaScript.

### Active tasks
{: #active-tasks-changes}

-   Indexer entries in the `_active_tasks` response no longer report the `user` field.
-   Search indexer entries in the `_active_tasks` response no longer report the `user` field.

### Views
{: #views-changes}

-   Unicode normalization of key values is consistent between reduced and non-reduced view results. If raw collation is specified in a design document, result order might change as the result of this fix.
-   When you query a view or `_all_docs` database, it is an error to specify the `keys` parameter and any of the `key`, `startkey`, and `endkey` parameters.
-   It is an error to pass `startkey` and `endkey` parameters to a view if it is impossible for any row to match. For example, when the `startkey` parameter is greater than the `endkey` parameter for `descending=false`, or when the `startkey` parameter is less than the `endkey` parameter for `descending=true`, {{site.data.keyword.cloudant_short_notm}} returns the `400 Bad Request` error.
-   When `dbcopy` is configured in a view document, it is automatically transformed to the `options` field in a design document. 

### Design documents
{: #design-documents-changes}

-   Stricter validation of design documents. This validation is not expected to cause problems with existing design documents, but malformed design documents fail to save.
-   Views that are written in an unsupported language all respond with an `error` of `unknown_query_language`. Previously, the response was a `reason` of `unknown_query_language`.
-   When a null reducer is used to put a database design document, the system responds with the error reason of `'(null)'`, previously it returned `((new String("null")))`.
-   If `updates` are specified in a design document, it must not have a null value.

### Authentication
{: #authentication-changes}

-   The `_session` metadata `authentication_handlers` no longer contains `["delegated", "local"]`.

### User documents
{: #user-documents-changes}

-   Validate the structure of user documents that are created in the `_users` database. After the DBNext upgrade, the user documents must comply with ASF CouchdDB requirements. Previously, {{site.data.keyword.cloudant_short_notm}} did not validate the user documents' structure. 

### Replication 
{: #replication-changes}

-   Replicator documents preserve the last error message in the `_replication_state_reason` JSON field. The field remains even after replication restarts and is in the `triggered` state. This change helps the replicator code detect and avoid writing the same error to the document repeatedly.
-   An error during replication does not update the replication document unless the reason for the error changes. Previously, when an error occurred during replication, an infinite loop started that generated sizable shards.  

### Result set
{: #result-set-changes}

-   The `_db_updates` endpoint returns a result set containing a key that is named  `db_name`. Previously, it returned a result set with a key named `dbname`.
-   Set the maximum length of the document ID. Previously, it was not possibly to define a maximum document ID length.





