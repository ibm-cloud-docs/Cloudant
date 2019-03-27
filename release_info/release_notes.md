---

copyright:
  years: 2015, 2019
lastupdated: "2019-03-27"

keywords: new features, partition query, dedicated hardware plan, replication scheduler, 8038, 7681, 7544, 7426, 7410, 7304, 7302, 7276, tls 1.3 supported, 8048, 8038, 7205, 7138, 7137, 7084, 7051, 7014, 6979, 6919, 6909, 6900, 6895, 6875, 6870, 6761, 6656, 6620, 6600, 6588, query, 6365, 6276, 6233, 6069, 5834, 5728, 5638, 5421

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

<!-- Acrolinx: 2018-11-20 -->

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

- Read the [guide to partition query](/docs/services/Cloudant?topic=cloudant-ibm-cloud-public#ibm-cloud-public).

### Dedicated Hardware (June 2017)
{: #dedicated-hardware}

A new Dedicated Hardware plan is available.

For more information, see the following links:

- See our [post on the {{site.data.keyword.cloud}} Blog](https://www.ibm.com/blogs/bluemix/2017/06/cloudant-available-dedicated-environments-improved-sla-bluemix-public/){: new_window} introducing the new plan.
- Read about the [Dedicated Hardware plan](/docs/services/Cloudant?topic=cloudant-ibm-cloud-public#dedicated-hardware-plan){: new_window}.

### Replication scheduler
{: #replication-scheduler}

The new replication scheduler has several improvements and enhancements. Learn more about the replication scheduler.

## Build 8048 (March 2019)
{: #build-8048-march-2019}
- No user visible changes; bug fixes.

## Build 8038 (March 2019)
{: #build-8038-march-2019}
- Allow using `POST` when making search [partition queries](/docs/services/Cloudant?topic=cloudant-database-partitioning#database-partitioning).

## Build 7681 (February 2019)
{: #build-7681-february-2019}

- Partition query bug fixes.

## Build 7668 (January 2019)
{: #build-7668-january-2019}

- This build introduces a new feature, [Partition Query](/docs/services/Cloudant?topic=cloudant-database-partitioning#database-partitioning).
- Allow `limit` when using `POST` for search.

## Build 7631 (January 2019)
{: #build-7631-january 2019}

-   Internal changes and bug fixes.

## Build 7544 (December 2018)
{: #build-7544-december-2018}

- Fixed a problem where the replicator would sometimes reset statistics during
    replications. This would affect values in the [replication status
    information](/docs/services/Cloudant?topic=cloudant-advanced-replication#advanced-replication).
     See [PR ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/apache/couchdb/pull/1722){: new_window}.
- Fixed an issue with Cloudant Query where, after deleting a document, issuing
    a `_find` request to a text index with `update=false` could return a
    `500` response.
    See [PR ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/apache/couchdb/pull/1709){: new_window}.
- You can now use `multipart/mixed` and `multipart/related` when using 
    `_bulk_get`. See [PR ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/apache/couchdb/pull/1195){: new_window}.
- Fix a bug with total row count in the `_design_docs` handler.
     See [PR ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/apache/couchdb/pull/1744){: new_window}.
- Optimisations to the `_doc_id` and `_design_docs` replication filters.
     See [issue ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/apache/couchdb/issues/1737){: new_window}.
- Fix a regression where long-running index jobs can fail.

## Build 7426 (November 15, 2018)
{: #build-7426-november-15-2018}

- Include [CRN](/docs/overview/crn.html) in audit logs.
- Replicator stability improvements.
- Improve validation of `q` parameter on database creation. See [COUCHDB-1582 ![External link icon](../images/launch-glyph.svg "External link icon")](https://issues.apache.org/jira/browse/COUCHDB-1582){: new_window}.
- Fix error in `_bulk_get` endpoint for the `_users` database. See [COUCHDB-1650 ![External link icon](../images/launch-glyph.svg "External link icon")](https://issues.apache.org/jira/browse/COUCHDB-1650){: new_window}.
- Fix JavaScript URL rewrites hanging on `POST` or `PUT` requests. See [COUCHDB-1612 ![External link icon](../images/launch-glyph.svg "External link icon")](https://issues.apache.org/jira/browse/COUCHDB-1612){: new_window}.
- Fix invalid `reduce` functions in {{site.data.keyword.cloudant_short_notm}} Query indexes that prevent indexing. See [COUCHDB-1666 ![External link icon](../images/launch-glyph.svg "External link icon")](https://issues.apache.org/jira/browse/COUCHDB-1666){: new_window}.
- Internal bug fixes to data compression, search, and core database components.

## Build 7410 (November 04, 2018)
{: #build-7410-november-04-2018}

- Internal changes and bug fixes.

## Build 7304 (October 11, 2018)
{: #build-7304-october-11-2018}

- This build is identical to build 7302 except that it is built on Erlang 17.5 instead of Erlang 20.

## Build 7302 (September 25, 2018)
{: #build-7302-september-25-2018}

- Improve Mango Query so that mixed clusters return correct results during upgrades.
- Add a downgrade function to support future cluster purge releases.
- Improve search black list.

## Build 7276 (September 18, 2018)
{: #build-7276-september-18-2018}

- Add a filter for databases that are being opened asynchronously to prevent exceptions when `couch_server` terminates.
- Fix `couch_server` concurrency error.
- Add a configuration option to disable off-heap messages.

## TLS 1.3 Supported (September 13, 2018)
{: #tls-1-3-supported-september-13-2018}

From today we support TLS 1.3 connections to {{site.data.keyword.cloudant_short_notm}}.

We recommend that you use TLS 1.2 or 1.3 for all access to {{site.data.keyword.cloudant_short_notm}}.
(***In June 2019, {{site.data.keyword.cloudant_short_notm}} is retiring the use of older
versions (TLS 1.0 and 1.1) at which point only TLS 1.2+ will be supported.***)

Find more information on our [Security page](/docs/services/Cloudant?topic=cloudant-security#security).

## Build 7205 (September 07, 2018)
{: #build-7205-september-07-2018}

- Refactor Mango Query selectors to reduce the amount of traffic sent between nodes in the cluster.
- Expose document update errors on concurrent document updates to client.
- Fix `render_error` errors where the `req` object that is passed to the JavaScript list function is set to `noproc` atom.

## Build 7138 (August 17, 2018)
{: #build-7138-august-17-2018}

- Upgrade to Erlang/OTP 20.

## Build 7137 (August 15, 2018)
{: #build-7137-august-15-2018}

- Improve validation of configuration parameters supplied by administrator.
- While compaction is running, delete compaction files when database is deleted.
- Improve sandboxing features.
- Optimize authentication check.
- Change semantics of status codes for delete database.
- Support `conflicts: true` for queries to the `/{db}/_find` endpoint.
- Preserve `update_seq` field across view compaction.


## Build 7084 (July 12, 2018)
{: #build-7084-july-12-2018}

- Refactor code for `_stats` reducer.
- Fix active size calculations for views.
- Rewrite the `couch_key_tree` algorithm to reduce its computational complexity and avoid calling stemming when unnecessary.
- Change allocation strategy for message queue for each important process so it is not stored on the heap of that process.
- Improvements to internal audit facility.
- Any constant fields that are in the selector, and are part of the index, for example, {A: {$eq: 10}}, are inserted into the sort list if they are not already included. This method increases the chance that the best index is selected for the query, for example, index = [A, B], sort = [B], and selector = {A: 1}. The sort then becomes [A, B].

<p class="tip">Only the fields that are in front of the current sort fields in the list are added.</p>


## Build 7051 (June 29, 2018)
{: #build-7051-june-29-2018}

- Add forward compatibility clause for `_stats` disk format change.
- Add compatibility clause for attachment receiver to facilitate Erlang upgrade.
- Improvements to internal audit facility.
- Reduce the possibility that a race condition will occur between the time when closing a geo index is triggered by deleting a database and when a geo index is destroyed during compaction.

## Build 7014 (June 12, 2018)
{: #build-7014-june-12-2018}

- Remove the requirement to cover `_id` or `_rev` in the query selector in order to use a JSON index that explicitly contains them.

## Build 6979 (May 29, 2018)
{: #build-6979-may-29-2018}

- Improvements to internal audit facility.

## Build 6919 (May 14, 2018)
{: #build-6919-may-14-2018}

- Remove outdated dependencies.
- Introduce new action, `DELETE`, on the `/_iam_session` endpoint, which invalidates the IAM session cookie.

## Build 6909 (April 26, 2018)
{: #build-6909-april-26-2018}

- Improve compatibility with IAM.
- Fix `badarg` error in the module that parses `http` multipart requests.

## Build 6900 (April 25, 2018)
{: #build-6900-april-25-2018}

- Improve validation of password schemes.
- In `_scheduler/docs`, set the value of the state field to `crashing` when the last event in the history was a crash.
- Support replication with IAM.
- Disallow `_design/$DDOC/_rewrite` and `_design/$DDOC/_update` endpoints with IAM.

## Build 6895 (April 17, 2018)
{: #build-6895-april-17-2018}

- Fix a regression that is introduced with pluggable storage engine.

## Build 6875 (April 4, 2018)
{: #build-6875-april-4-2018}

- Improve error messages for {{site.data.keyword.cloudant_short_notm}} Query.
- New internal audit facility is added to the platform.

## Build 6870 (March 30, 2018)
{: #build-6870-march-30-2018}

- Fix how the `kill` command works when you terminate an operating system process.
- Fix `_changes` endpoint shard substitution.
- Fix compaction resumption for terminated compactions.

## Build 6761 (March 13, 2018)
{: #build-6761-march-13-2018}

- Ensure deterministic revisions for attachments. See [COUCHDB-3255 ![External link icon](../images/launch-glyph.svg "External link icon")](https://issues.apache.org/jira/browse/COUCHDB-3255){: new_window}.
- Add a pluggable storage engine.
- Prevent `chttpd` multipart zombie processes.
- Avoid unconditional retries in replicator's HTTP client.
- Update MochiWeb to version 2.17.
- Introduce new `_dbs_info` endpoint to get information from a list of databases. See
[Get a list of all databases in the account](/docs/services/Cloudant?topic=cloudant-databases#get-a-list-of-all-databases-in-the-account).
- Prepare for session support in replicator.

## Build 6656 (February 15, 2018)
{: #build-6656-february-15-2018}

- Update `_design_docs` to respect the query parameters that are used by `_all_docs`. See [Get design documents](/docs/services/Cloudant?topic=cloudant-databases#get-documents).
- When you send a `COPY` request to `/$DATABASE/docid` endpoint, {{site.data.keyword.cloudant_short_notm}} now decodes the Destination header and creates a new ID without escaped values.
- Remove headers from replication document on read.
- If the `keys` parameter is specified and the `update_seq` parameter is set to true, the `update_seq` and `offset` parameters return `null` in the response.
- Change semantics of status codes for create database.

## Build 6620 (January 10, 2018)
{: #build-6620-january-10-2018}

- Query: fallback to `selector` on an empty `partial_filter_selector` field.

## Build 6600 (December 28, 2017)
{: #build-6600-december-28-2017}

- Query: fields that are referenced within `$or` operations are considered when {{site.data.keyword.cloudant_short_notm}} query determines the usable
indexes for a particular selector.

## Build 6588 (December 7, 2017)
{: #build-6588-december-7-2017}

- A new parameter, `create_target_params`, was added for you to customize the target database
that is created on a new replication. You can now customize the cluster's default values for the number of shards and
replicas to create.
- A request to `/_scheduler` without specifying subsections `docs` or `jobs` now returns a `Not found` error.
- A new error is returned when a `new_edits` value is invalid in the `/db/_bulk_docs` URL. The error is `400: Bad request.`
- For security reasons, by default, the use of `eval()` and `Function()` constructors is disabled in
JavaScript.
- Added the header `Prefer: return=minimal` to return only essential headers. This header reduces the size of the request, which gives a performance improvement to non-browser clients.

### Query (<code>_find</code> endpoint):
{: #query-code-_find-code-endpoint}

- {{site.data.keyword.cloudant_short_notm}} Query now uses a new method to select an index. Learn more about [{{site.data.keyword.cloudant_short_notm}} Query index selection ![External link icon](../images/launch-glyph.svg "External link icon")](http://www-01.ibm.com/support/docview.wss?uid=swg22011923){: new_window}.
- The logic for determining whether a specific index is valid for a query changed, addressing a bug that might lead to incorrect results.
- Queries that use text indexes no longer fail when `$exists`: `false` is used.
- Partial indexes are now supported for both JSON and text indexes. For more information, see  [Creating a partial index](/docs/services/Cloudant?topic=cloudant-query#creating-a-partial-index) for more information.
- Execution statistics about a query can now be generated. These statistics are enabled by using the `execution_stats=true` parameter. For more information, see [finding documents by using an index](/docs/services/Cloudant?topic=cloudant-query#finding-documents-by-using-an-index) for more information.
- [Pagination](/docs/services/Cloudant?topic=cloudant-query#pagination) is supported by using the bookmark field. Bookmarks are enabled for all index types.
- `_find` now falls back to any valid index if the value specified in the `use_index`
field is invalid for the current query. When this occurs, the `warning` field is populated in the query response.

## Build 6365 (August 17, 2017)
{: #build-6365-august-17-2017}

- `POST` requests to the `_revs_diff` endpoint require either the `_reader` or `_replicator` role.
- Add the `X-Frame-Options` header settings to prevent click jacking. Learn more about [X-Frame-Options setting](/docs/services/Cloudant?topic=cloudant-deprecations#x-frame-options-setting).
- Add the replication scheduler. Learn more about [replication scheduler](/docs/services/Cloudant?topic=cloudant-advanced-replication#the-replication-scheduler).

## Build 6276 (July 4, 2017)
{: #build-6276-july-4-2017}

- An error message changed that occurs when you attempt to put a document attachment with a non-existent revision.
Now, the error is a 409 error with the following information: `{`error`:`not_found`,`reason`:`missing_rev`}`.

## Build 6233 (June 26, 2017)
{: #build-6233-june-26-2017}

- Fixes an {{site.data.keyword.cloudant_short_notm}} Query issue where indexes that excluded potentially matching documents were selected by the query planner.

## Build 6069 (May 11, 2017)
{: #build-6069-may-11-2017}

- Previously, a replication job that failed for some reason, which resulted in an update to the replication document,
  was followed by a fresh attempt to start a new replication.
  Under some circumstances,
  this behavior might continue indefinitely: many duplicates of the same error message.
  A fix was introduced so that the replication document is not updated unless the reason for the error changes.
- If the design document that is intended to specify a geospatial index is invalid,
  an attempt to retrieve information about the index by using
  the [`_geo_info` endpoint](/docs/services/Cloudant?topic=cloudant-cloudant-nosql-db-geospatial#cloudant-nosql-db-geospatial)
  results in an [HTTP `404`](/docs/services/Cloudant?topic=cloudant-http#http-status-codes) response.
- Added support for the `$allmatch` operator.

## Build 5834 (February 13, 2017)
{: #build-5834-february-13-2017}

- The maximum length of a document `id` is now 7168 characters (7k).

## Build 5728 (November 25, 2016)
{: #build-5278-november-25-2016}

- {{site.data.keyword.cloudant_short_notm}} is more tolerant of malformed user documents that are stored within the `_users` database.
  User documents must be structured and populated to comply with
  [Apache Software Foundation CouchDB requirements ![External link icon](../images/launch-glyph.svg "External link icon")](http://docs.couchdb.org/en/2.0.0/intro/security.html#users-documents){: new_window}.

## Build 5638 (October 11, 2016)
{: #build-5638-october-11-2016}

-   Introduces new `stable` and `update` query parameters for views.
-   Replicator no longer retries forever if it cannot write checkpoints to the source database.

## Build 5421 (June 14, 2016)
{: #build-5421-june-14-2016}

-	Changes feeds support view-based filters.
-	Changes feeds support the `_doc_ids` filter.
-	`POST` requests are supported for `_changes`.
-	Both `_all_docs` and `_changes` support the `attachments=true` parameter.
-	Support for the CouchDB 1.6 `_users` database features, including server-side hashing of passwords when documents are created in the `_users` database.
-	`/_bulk_get` endpoint to reduce the number of requests that are used in replication to mobile clients.
-	Design document metadata contains an `update pending` field.
-	{{site.data.keyword.cloudant_short_notm}} Query no longer returns an error if no valid index exists.
