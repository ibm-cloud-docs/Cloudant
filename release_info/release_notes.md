---

copyright:
  years: 2015, 2021
lastupdated: "2021-02-18"

keywords: new features, partition query, dedicated hardware plan, replication scheduler, 8169, 8162, 8158, 8152, 8142, 8126, 8111, 8106, 8103, 8076, 8070, 8062, 8058, 8052, 8048, 8038, 7681, 7544, 7426, 7410, 7304, 7302, 7276, tls 1.3 supported, 8048, 8038, 7205, 7138, 7137, 7084, 7051, 7014, 6979, 6919, 6909, 6900, 6895, 6875, 6870, 6761, 6656, 6620, 6600, 6588, query, 6365, 6276, 6233, 6069, 5834, 5728, 5638, 5421

subcollection: Cloudant

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

<!-- Acrolinx: 2020-12-18 -->

# Release notes
{: #release-notes}

Changes and updates to {{site.data.keyword.cloudantfull}} that are grouped by build number.
{: shortdesc}

## New features
{: #new-features}

### Partition Query (February 2019)
{: #partition-query-february-2019}

The new Partition Query feature provides a new way to structure
data in {{site.data.keyword.cloudant_short_notm}}, which offers both cost savings and performance gains for your
applications.

For more information, see the following link:

- Read the [guide to partition query](/docs/Cloudant?topic=Cloudant-database-partitioning).

### Dedicated Hardware (June 2017)
{: #dedicated-hardware}

A new Dedicated Hardware plan is available.

For more information, see the following links:

- Read about the [Dedicated Hardware plan](/docs/Cloudant?topic=Cloudant-ibm-cloud-public#dedicated-hardware-plan){: new_window}{: external}.

### Replication scheduler
{: #replication-scheduler}

The new replication scheduler has several improvements and enhancements. Learn more about the replication scheduler.

## Build 8169 (December 2020)
{: #build-8169-12-2020}

- Bug fixes.
- Report the database that was used for authentication for a `GET /_session` request, provided it is configured.
- Introduce the Mango query operator, `$keyMapMatch`, that allows you to make queries on the keys of a map.

## Build 8162 (September 2020)
{: #build-8162-09-2020}

- Bug fixes.
- `Drilldown` parameters for text index searches can now be specified as a list of lists, which allows you to avoid having to define this redundantly in a single query. (Some languages don't have this facility.)
- The `couch_index` server doesn't crash and log errors in the following cases: If a design document is deleted while that index is building, or when a design document is added immediately after database creation.
- {{site.data.keyword.cloudant_short_notm}} now checks for and reports invalid parameters on database creation.

## Build 8158 (July 2020)
{: #build-8158-07-2020}

- Bug fixes.

## Build 8153 (May 2020)
{: #build-8153-05-2020}

- Bug fixes.

## Build 8152 (April 2020)
{: #build-8152-04-2020}

- Bug fixes.

## Build 8142 (March 2020)
{: #build-8142-03-2020}

- New endpoints were added so you can post multiple queries: `POST /{db}/_all_docs/queries` and `POST /{db}/_design_docs/queries`.
- The `disk_size` and `data_size` fields were retired from the database info object returned by `GET /{db}`. 
- The ability to submit multiple queries against a view by using the `POST` to `/{db}/_design/{ddoc}/_view/{view}` with the `?queries` option was replaced by the new `queries` endpoint. The same is true of the `_all_docs` and `_design_docs`endpoints. Specify a `keys` object when `POST`ing to these endpoints. 
- The `/{db}/_changes` feed immediately returns headers now, even when no changes are available. This process prevents client blocking.
- Negative and non-integer heartbeat values now return a `400 Bad Request` response status code.
- Allow specifying separate proxies for both the source and target in a replication via `source_proxy` and `target_proxy` keys.  
- The `POST` view functionality now supports identical parameters and behavior as specified in the `/{db}/_design/{ddoc}/_view/{view}`, `/{db}/_all_docs`, and `/{db}/_design_docs` endpoints. You can supply query string parameters as keys in a JSON object in the body of the `POST` request.
- Replication `"info"` errors are now JSON objects. Previously, they were strings. 
- A compatibility change was made to support replication with future databases that contain per-document access control fields.
- Add a warning to the `_find` endpoint if multiple document scans were required to generate a result.
- Fix a bug in the `_find` endpoint whereby an error would be returned if a document matched by a text index was deleted while the query was being processed.  


## Build 8126 (January 2020)
{: #build-8126-January-2020}

- Bug fixes.
- Improvements to replication error reporting - instead of a function_clause, human-readable markers are returned, for example, `bulk_docs_failed`. Stack traces are no longer included.
- Replication job statistics, such as `docs_read`, `docs_written`, and `doc_write_failures` are preserved when replication jobs restart.
- Replication jobs to a target endpoint by using IAM Writer permissions no longer crash and continuously restart when they write design documents. Instead, the `doc_write_failures` statistic is incremented for each failed design document write. This behavior is consistent with replicating by using the legacy API-key-based authentication.

## Build 8111 (November 2019)
{: #build-8111-november-2019}

- Bug fixes.
- The `_scheduler/docs` endpoint now includes more detailed replication statistics to match `_active_tasks` output. It also includes details on replications that started with `_replicate`.
- Fix an instance where the replicator failed a replication but the error was recoverable.
- Fix a bug introduced in recent builds where sending an empty payload to `_bulk_docs` would result in a 400 response status code rather than accepting the no-op operation.

## Build 8106 (October 2019)
{: #build-8106-october-2019}

- Bug fixes.

## Build 8103 (October 2019)
{: #build-8103-october-2019}

- New `X-Cloudant-Action` HTTP response header that returns the {{site.data.keyword.cloud}}    IAM actions that are associated with a request.
- Previously, search requests would return a `400` status code both on a bad
    request and on internal server errors. Now, internal server errors correctly
    return a `500` response status code.

## Build 8076 (June 2019)
{: #build-8076-june-2019}

- Bug fixes.
- Stability improvements.

## Build 8070 (May 2019)
{: #build-8070-may-2019}

- Bug fixes.

## Build 8062 (May 2019)
{: #build-8062-may-2019}

- Bug fixes.

## Build 8058 (April 2019)
{: #build-8058-april-2019}

- Fixed bug in `ibrowse` HTTP client that leaves dead process IDs in the connection pool, and in some cases, caused persistent IAM-based replication failures.

## Build 8052 (April 2019)
{: #build-8052-april-2019}

- Accessing the database information endpoint (`/db/`) for a partitioned database
    now includes information about the contained partitioned indexes. The new field, `partitioned_indexes`, contains the following
    information:

    - The current number of partitioned indexes in the database (`count`).
    - A breakdown of those indexes by type (`indexes`).
    - The maximum partitioned indexes allowed for this database (`limit`).

## Build 8048 (March 2019)
{: #build-8048-march-2019}
- No user visible changes; bug fixes.

## Build 8038 (March 2019)
{: #build-8038-march-2019}
- Allow `POST` when you search [partition queries](/docs/Cloudant?topic=Cloudant-database-partitioning#database-partitioning).

## Build 7681 (February 2019)
{: #build-7681-february-2019}

- Partition query bug fixes.

## Build 7668 (January 2019)
{: #build-7668-january-2019}

- This build introduces a new feature, [Partition Query](/docs/Cloudant?topic=Cloudant-database-partitioning#database-partitioning).
- Allow `limit` when you use `POST` for search.
- Previously, view requests that use a `limit` parameter greater than 268435456 would have the limit silently reduced to 268435456. Now, requests with the `limit` parameter greater than 268435456 are rejected with a `400 Bad Request` error.

## Build 7631 (January 2019)
{: #build-7631-january 2019}

-   Internal changes and bug fixes.

## Build 7544 (December 2018)
{: #build-7544-december-2018}

- Fixed a problem where the replicator would sometimes reset statistics during
    replications. The reset would affect values in the [replication status
    information](/docs/Cloudant?topic=Cloudant-advanced-replication#advanced-replication).
     See [PR](https://github.com/apache/couchdb/pull/1722){: new_window}{: external}.
- Fixed an issue with {{site.data.keyword.cloudant_short_notm}} Query. After deleting a document, if you issue
    a `_find` request to a text index with `update=false`, it might return a
    `500` response.
    See [PR](https://github.com/apache/couchdb/pull/1709){: new_window}{: external}.
- You can now use `multipart/mixed` and `multipart/related` when you use
    `_bulk_get`. See [PR](https://github.com/apache/couchdb/pull/1195){: new_window}{: external}.
- Fix a bug with total row count in the `_design_docs` handler.
     See [PR](https://github.com/apache/couchdb/pull/1744){: new_window}{: external}.
- Optimizations to the `_doc_id` and `_design_docs` replication filters.
     See [issue](https://github.com/apache/couchdb/issues/1737){: new_window}{: external}.
- Fix a regression where long-running index jobs can fail.

## Build 7426 (15 November 2018)
{: #build-7426-november-15-2018}

- Include [CRN](/docs/account?topic=account-crn) in audit logs.
- Replicator stability improvements.
- Improve validation of `q` parameter on database creation. See [COUCHDB-1582](https://issues.apache.org/jira/browse/COUCHDB-1582){: new_window}{: external}.
- Fix error in `_bulk_get` endpoint for the `_users` database. See [COUCHDB-1650](https://issues.apache.org/jira/browse/COUCHDB-1650){: new_window}{: external}.
- Fix JavaScript URL rewrites hanging on `POST` or `PUT` requests. See [COUCHDB-1612](https://issues.apache.org/jira/browse/COUCHDB-1612){: new_window}{: external}.
- Fix invalid `reduce` functions in {{site.data.keyword.cloudant_short_notm}} Query indexes that prevent indexing. See [COUCHDB-1666](https://issues.apache.org/jira/browse/COUCHDB-1666){: new_window}{: external}.
- Internal bug fixes to data compression, search, and core database components.

## Build 7410 (4 November 18)
{: #build-7410-november-04-2018}

- Internal changes and bug fixes.

## Build 7304 (11 October 2018)
{: #build-7304-october-11-2018}

- This build is identical to build 7302 except that it's built on Erlang 17.5 instead of Erlang 20.

## Build 7302 (25 September 2018)
{: #build-7302-september-25-2018}

- Improve Mango Query so that mixed clusters return correct results during upgrades.
- Add a downgrade function to support future cluster purge releases.
- Improve search blocklist.

## Build 7276 (18 September 2018)
{: #build-7276-september-18-2018}

- Add a filter for databases that are being opened asynchronously to prevent exceptions when `couch_server` terminates.
- Fix `couch_server` concurrency error.
- Add a configuration option to disable off-heap messages.

## TLS 1.3 Supported (13 September 2018)
{: #tls-1-3-supported-september-13-2018}

From today, we support TLS 1.3 connections to {{site.data.keyword.cloudant_short_notm}}.

We recommend you use TLS 1.2 or 1.3 for all access to {{site.data.keyword.cloudant_short_notm}}.
***(In June 2019, {{site.data.keyword.cloudant_short_notm}} is retiring the use of older
versions (TLS 1.0 and 1.1) at which point only TLS 1.2+ will be supported.)***

Find more information on our [Security page](/docs/Cloudant?topic=Cloudant-security#security).

## Build 7205 (07 September 2018)
{: #build-7205-september-07-2018}

- Refactor Mango Query selectors to reduce the amount of traffic sent between nodes in the cluster.
- Expose document update errors on concurrent document updates to client.
- Fix `render_error` errors where the `req` object that is passed to the JavaScript list function is set to `noproc` atom.

## Build 7138 (17 August 2018)
{: #build-7138-august-17-2018}

- Upgrade to Erlang/OTP 20.

## Build 7137 (15 August 2018)
{: #build-7137-august-15-2018}

- Improve validation of configuration parameters supplied by administrator.
- While compaction is running, delete compaction files when database is deleted.
- Improve sandboxing features.
- Optimize authentication check.
- Change semantics of status codes for delete database.
- Support `conflicts: true` for queries to the `/{db}/_find` endpoint.
- Preserve `update_seq` field across view compaction.


## Build 7084 (12 July 2018)
{: #build-7084-july-12-2018}

- Refactor code for `_stats` reducer.
- Fix active size calculations for views.
- Rewrite the `couch_key_tree` algorithm to reduce its computational complexity and avoid calling stemming when unnecessary.
- Change allocation strategy for message queue for each important process, so it's not stored on the heap of that process.
- Improvements to internal audit facility.
- Any constant fields that are in the selector, and are part of the index, for example, {A: {$eq: 10}}, are inserted into the sort list if they aren't already included. This method increases the chance that the best index is selected for the query, for example, index = [A, B], sort = [B], and selector = {A: 1}. The sort then becomes [A, B].

Only the fields that are in front of the current sort fields in the list are added.
{: tip}


## Build 7051 (29 June 2018)
{: #build-7051-june-29-2018}

- Add forward compatibility clause for `_stats` disk format change.
- Add compatibility clause for attachment receiver to facilitate Erlang upgrade.
- Improvements to internal audit facility.
- Reduce the possibility that a race condition occurs between the time when deleting a database triggers a geo index to close and when compaction destroys a geo index.

## Build 7014 (12 June 2018)
{: #build-7014-june-12-2018}

- Remove the requirement to cover `_id` or `_rev` in the query selector in order to use a JSON index that explicitly contains them.

## Build 6979 (29 May 2018)
{: #build-6979-may-29-2018}

- Improvements to internal audit facility.

## Build 6919 (14 May 2018)
{: #build-6919-may-14-2018}

- Remove outdated dependencies.
- Introduce new action, `DELETE`, on the `/_iam_session` endpoint, which invalidates the IAM session cookie.

## Build 6909 (26 April 2018)
{: #build-6909-april-26-2018}

- Improve compatibility with IAM.
- Fix `badarg` error in the module that parses `http` multipart requests.

## Build 6900 (25 April 2018)
{: #build-6900-april-25-2018}

- Improve validation of password schemes.
- In `_scheduler/docs`, set the value of the state field to `crashing` when the last event in the history was a crash.
- Support replication with IAM.
- Disallow `_design/$DDOC/_rewrite` and `_design/$DDOC/_update` endpoints with IAM.

## Build 6895 (17 April 2018)
{: #build-6895-april-17-2018}

- Fix a regression that is introduced with pluggable storage engine.

## Build 6875 (4 April 2018)
{: #build-6875-april-4-2018}

- Improve error messages for {{site.data.keyword.cloudant_short_notm}} Query.
- New internal audit facility is added to the platform.

## Build 6870 (30 March 2018)
{: #build-6870-march-30-2018}

- Fix how the `kill` command works when you terminate an operating system process.
- Fix `_changes` endpoint shard substitution.
- Fix compaction resumption for terminated compactions.

## Build 6761 (13 March 2018)
{: #build-6761-march-13-2018}

- Ensure deterministic revisions for attachments. See [COUCHDB-3255](https://issues.apache.org/jira/browse/COUCHDB-3255){: new_window}{: external}.
- Add a pluggable storage engine.
- Prevent `chttpd` multipart zombie processes.
- Avoid unconditional retries in replicator's HTTP client.
- Update MochiWeb to version 2.17.
- Introduce new `_dbs_info` endpoint to get information from a list of databases. See
[Get a list of all databases in the account](/docs/Cloudant?topic=Cloudant-databases#get-a-list-of-all-databases-in-the-account).
- Prepare for session support in replicator.

## Build 6656 (15 February 2018)
{: #build-6656-february-15-2018}

- Update `_design_docs` to respect the query parameters that are used by `_all_docs`. See [Get design documents](/docs/Cloudant?topic=Cloudant-databases#get-documents).
- When you send a `COPY` request to `/$DATABASE/docid` endpoint, {{site.data.keyword.cloudant_short_notm}} now decodes the Destination header and creates a new ID without escaped values.
- Remove headers from replication document on read.
- If the `keys` parameter is specified and the `update_seq` parameter is set to true, the `update_seq` and `offset` parameters return `null` in the response.
- Change semantics of status codes for create database.

## Build 6620 (10 January 2018)
{: #build-6620-january-10-2018}

- Query falls back to `selector` on an empty `partial_filter_selector` field.

## Build 6600 (28 December 2017)
{: #build-6600-december-28-2017}

- Query fields that are referenced within `$or` operations are considered when {{site.data.keyword.cloudant_short_notm}} query determines the usable
indexes for a particular selector.

## Build 6588 (7 December 2017)
{: #build-6588-december-7-2017}

- A new parameter, `create_target_params`, was added for you to customize the target database
that is created on a new replication. You can now customize the cluster's default values for the number of shards and
replicas to create.
- A request to `/_scheduler` without specifying subsections `docs` or `jobs` now returns a `Not found` error.
- A new error is returned when a `new_edits` value is invalid in the `/db/_bulk_docs` URL. The error is `400: Bad request`.
- For security reasons, by default, the use of `eval()` and `Function()` constructors is disabled in
JavaScript.
- Added the header `Prefer: return=minimal` to return only essential headers. This header reduces the size of the request, which gives a performance improvement to non-browser clients.

### Query (`_find` endpoint)
{: #query-code-_find-code-endpoint}

- {{site.data.keyword.cloudant_short_notm}} Query now uses a new method to select an index. Learn more about [{{site.data.keyword.cloudant_short_notm}} Query index selection](http://www-01.ibm.com/support/docview.wss?uid=swg22011923){: new_window}{: external}.
- The logic for determining whether a specific index is valid for a query that changed, addressing a bug that might lead to incorrect results.
- Queries that use text indexes no longer fail when `$exists`: `false` is used.
- Partial indexes are now supported for both JSON and text indexes. For more information, see  [Creating a partial index](/docs/Cloudant?topic=Cloudant-query#creating-a-partial-index) for more information.
- Execution statistics about a query can now be generated. These statistics are enabled by using the `execution_stats=true` parameter. For more information, see [finding documents by using an index](/docs/Cloudant?topic=Cloudant-query#finding-documents-by-using-an-index) for more information.
- [Pagination](/docs/Cloudant?topic=Cloudant-query#pagination_query) is supported by using the bookmark field. Bookmarks are enabled for all index types.
- `_find` now falls back to any valid index if the value specified in the `use_index`
field is invalid for the current query. When `find` falls back, the `warning` field is populated in the query response.

## Build 6365 (17 August 2017)
{: #build-6365-august-17-2017}

- `POST` requests to the `_revs_diff` endpoint require either the `_reader` or `_replicator` role.
- Add the `X-Frame-Options` header settings to prevent click jacking. Learn more about [X-Frame-Options setting](/docs/Cloudant?topic=Cloudant-deprecations#x-frame-options-setting).
- Add the replication scheduler. Learn more about [replication scheduler](/docs/Cloudant?topic=Cloudant-advanced-replication#the-replication-scheduler).

## Build 6276 (4 July 2017)
{: #build-6276-july-4-2017}

- An error message changed that occurs when you try to put a document attachment with a non-existent revision.
Now, the error is a 409 error with the following information: `{`error`:`not_found`,`reason`:`missing_rev`}`.

## Build 6233 (26 June 2017)
{: #build-6233-june-26-2017}

- Fixes an {{site.data.keyword.cloudant_short_notm}} Query issue where indexes that excluded potentially matching documents were selected by the query planner.

## Build 6069 (11 May 2017)
{: #build-6069-may-11-2017}

- Previously, a replication job that failed for some reason, which resulted in an update to the replication document,
  was followed by a fresh attempt to start a new replication.
  Under some circumstances,
  this behavior might continue indefinitely: many duplicates of the same error message.
  A fix was introduced so that the replication document is not updated unless the reason for the error changes.
- If the design document that is intended to specify a geospatial index is invalid,
  an attempt to retrieve information about the index by using
  the [`_geo_info` endpoint](/docs/Cloudant?topic=Cloudant-cloudant-nosql-db-geospatial#cloudant-nosql-db-geospatial)
  results in an [HTTP `404`](https://cloud.ibm.com/apidocs/cloudant#list-of-http-codes) response.
- Added support for the `$allmatch` operator.

## Build 5834 (13 February 2017)
{: #build-5834-february-13-2017}

- The maximum length of a document `id` is now 7168 characters (7k).

## Build 5728 (25 November 2016)
{: #build-5278-november-25-2016}

- {{site.data.keyword.cloudant_short_notm}} is more tolerant of malformed user documents that are stored within the `_users` database.
  User documents must be structured and populated to comply with
  [Apache Software Foundation CouchDB requirements](https://docs.couchdb.org/en/stable/intro/security.html?highlight=security#users-documents){: new_window}{: external}.

## Build 5638 (11 October 2016)
{: #build-5638-october-11-2016}

-   Introduces new `stable` and `update` query parameters for views.
-   Replicator no longer retries forever if it cannot write checkpoints to the source database.

## Build 5421 (14 June 2016)
{: #build-5421-june-14-2016}

-	Changes feeds support view-based filters.
-	Changes feeds support the `_doc_ids` filter.
-	`POST` requests are supported for `_changes`.
-	Both `_all_docs` and `_changes` support the `attachments=true` parameter.
-	Support for the CouchDB 1.6 `_users` database features, including server-side hashing of passwords when documents are created in the `_users` database.
-	`/_bulk_get` endpoint to reduce the number of requests that are used in replication to mobile clients.
-	Design document metadata contains an `update pending` field.
-	{{site.data.keyword.cloudant_short_notm}} Query no longer returns an error if no valid index exists.
