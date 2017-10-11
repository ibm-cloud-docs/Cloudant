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

# Differences between major Cloudant releases

Summary of the changes in behavior between the most recent version of 
Cloudant and CouchDB 1.6-based codebase. Information is added as newer Cloudant 
versions are released.
{:shortdesc}

## New features

- The new replication scheduler has several improvements and enhancements. Learn more about the [replication scheduler](../api/advanced_replication.html#the-replication-scheduler).

## Incompatibilites

### Active tasks

-   Indexer entries in the `_active_tasks` response no longer report the `user` field.
-   Search indexer entries in the `_active_tasks` response no longer report the `user` field.

### Views

-   Unicode normalization of key values is consistent between reduced and non-reduced view results. If raw collation is specified in a design document, result order might change as the result of this fix.
-   When you query a view or `_all_docs` database, it is an error to specify the `keys` parameter and any of the `key`, `startkey`, and `endkey` parameters.
-   It is an error to pass `startkey` and `endkey` parameters to a view if it is impossible for any row to match. For example, when the `startkey` parameter is higher than the `endkey` parameter for `descending=false`, or when the `startkey` parameter is lower than the `endkey` parameter for `descending=true`, Cloudant returns the `400 Bad Request` error.
-   When `dbcopy` is configured in a view document, it is automatically transformed to the `options` field in a design document. 

### Design documents

-   Stricter validation of design documents. This validation is not expected to cause problems with existing design documents, but malformed design documents fail to save.
-   Views that are written in an unsupported language all respond with an `error` of `unknown_query_language`. Previously, the response was a `reason` of `unknown_query_language`.
-   When a null reducer is used to put a database design document, the system responds with the error reason of `'(null)'`, previously it returned `((new String("null")))`.
-   If `updates` is specified in a design document, it must not have a null value.

### Authentication

-   The `_session` metadata `authentication_handlers` no longer contains `["delegated", "local"]`.

### User documents

-   Validate the structure of user documents created in the `_users` database. After the DBNext upgrade, the user documents must comply with ASF CouchdDB requirements. Previously, Cloudant did not validate the user documents' structure. 

### Replication 

-   Replicator documents preserve the last error message in the `_replication_state_reason` JSON field. The field remains even after replication restarts and is in the `triggered` state. This change helps the replicator code detect and avoid writing the same error to the document repeatedly.
-   An error during replication does not update the replication document unless the reason for the error changes. Previously, when an error occurred during replication, an infinite loop started that generated sizable shards.  

### Result set

-   The `_db_updates` endpoint returns a result set containing a key that is named  `db_name`. Previously, it returned a result set with a key named `dbname`.
-   Set the maximum length of the document ID. Previously, it was not possibly to define a maximum document ID length.






