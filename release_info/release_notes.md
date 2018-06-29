---

copyright:
  years: 2017, 2018
lastupdated: "2018-06-29"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2018-05-31 -->

# Release Notes
{: #release-notes}

Changes and updates to {{site.data.keyword.cloudantfull}} that are grouped by build number.
{:shortdesc}

## Dedicated hardware
{: #dedicated-hardware}

A new [Dedicated service instance](../offerings/bluemix.html#dedicated-plan) is available.

## Build 7051 (June 29, 2018)

- Add forward compatibility clause for `_stats` disk format change.
- Add compatibility clause for attachment receiver to facilitate Erlang upgrade.
- Improvements to internal audit facility.

## Build 7014 (June 12, 2018)

- Remove the requirement to cover `_id` or `_rev` in the query selector in order to use a JSON index that explicitly contains them.

## Build 6979 (May 29, 2018)

- Improvements to internal audit facility.

## Build 6919 (May 14, 2018)
{: build-6919-may-14-2018}

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

- Ensure deterministic revisions for attachments. See [COUCHDB-3255 ![External link icon](../images/launch-glyph.svg "External link icon")](https://issues.apache.org/jira/browse/COUCHDB-3255){:new_window}.
- Add a pluggable storage engine.
- Prevent `chttpd` multipart zombie processes.
- Avoid unconditional retries in replicator's HTTP client.
- Update MochiWeb to version 2.17.
- Introduce new `_dbs_info` endpoint to get information from a list of databases. See 
[Get database information for multiple databases](../api/database.html#get-database-information-for-multiple-databases).
- Prepare for session support in replicator.

## Build 6656 (February 15, 2018)
{: #build-6656-february-15-2018}

- Update `_design_docs` to respect the query parameters that are used by `_all_docs`. See [Get design documents](../api/database.html#get-design-documents).
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

- {{site.data.keyword.cloudant_short_notm}} Query now uses a new method to select an index. Learn more about [{{site.data.keyword.cloudant_short_notm}} Query index selection ![External link icon](../images/launch-glyph.svg "External link icon")](http://www-01.ibm.com/support/docview.wss?uid=swg22011923){:new_window}.
- The logic for determining whether a specific index is valid for a query changed, addressing a bug that might lead to incorrect results. 
- Queries that use text indexes no longer fail when `$exists`: `false` is used.
- Partial indexes are now supported for both JSON and text indexes. For more information, see  [Creating a partial index](../api/cloudant_query.html#creating-a-partial-index) for more information.
- Execution statistics about a query can now be generated. These statistics are enabled by using the `execution_stats=true` parameter. For more information, see [finding documents by using an index](../api/cloudant_query.html#finding-documents-by-using-an-index) for more information.
- [Pagination](../api/cloudant_query.html#pagination) is supported by using the bookmark field. Bookmarks are enabled for all index types.
- `_find` now falls back to any valid index if the value specified in the `use_index`
field is invalid for the current query. When this occurs, the `warning` field is populated in the query response.

## Build 6365 (August 17, 2017)
{: #build-6365-august-17-2017}

- `POST` requests to the `_revs_diff` endpoint require either the `_reader` or `_replicator` role.
- Add the `X-Frame-Options` header settings to prevent click jacking. Learn more about [X-Frame-Options setting](/docs/services/Cloudant/release_info/deprecations.html#x-frame-options-setting).
- Add the replication scheduler. Learn more about [replication scheduler](/docs/services/Cloudant/api/advanced_replication.html#the-replication-scheduler).  

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
  the [`_geo_info` endpoint](../api/cloudant-geo.html#obtaining-information-about-a-cloudant-geo-index)
  results in an [HTTP `404`](../api/http.html#404) response.
- Added support for the `$allmatch` operator.

## Build 5834 (February 13, 2017)
{: #build-5834-february-13-2017}

- The maximum length of a document `id` is now 7168 characters (7k).

## Build 5728 (November 25, 2016)
{: #build-5278-november-25-2016}

- {{site.data.keyword.cloudant_short_notm}} is more tolerant of malformed user documents that are stored within the `_users` database.
  User documents must be structured and populated to comply with
  [Apache Software Foundation CouchDB requirements ![External link icon](../images/launch-glyph.svg "External link icon")](http://docs.couchdb.org/en/2.0.0/intro/security.html#users-documents){:new_window}.

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
