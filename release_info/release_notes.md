---

copyright:
  years: 2017, 2018
lastupdated: "2018-02-16"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-07-13 -->

# Release Notes

Changes and updates to {{site.data.keyword.cloudantfull}} grouped by build number.
{:shortdesc}

## Dedicated hardware

A new [Dedicated service instance](../offerings/bluemix.html#dedicated-plan) is available.

## Build 6656 (February 15, 2018)

- Update `_design_docs` to respect the query parameters used by `_all_docs`. See [Get design documents](../api/database.html#get-design-documents).
- When sending a `COPY` request to `/$DATABASE/docid` endpoint, {{site.data.keyword.cloudant_short_notm}} now decodes the Destination header and creates a new ID without escaped values.
- Remove headers from replication document on read.
- If the `keys` parameter is specified and the `update_seq` parameter is set to true, the `update_seq` and `offset` parameters return `null` in the response. 
- Change semantics of status codes for create database.

## Build 6600 (December 28, 2017)

- Query: fields referenced within `$or` operations are considered when determining the usable 
indexes for a given selector.

## Build 6588 (December 7, 2017)

- A new parameter, `create_target_params`, was added that allows you to customize the target database
that is created on a new replication. You can now customize the cluster's default values for the number of shards and
replicas to create.
- A request to `/_scheduler` without specifying subsections `docs` or `jobs` now returns a `Not found` error.
- A new error is returned when a `new_edits` value is invalid in the `/db/_bulk_docs` URL. The error is `400: Bad request.`
- For security reasons, by default, the use of `eval()` and `Function()` constructors is disabled in 
JavaScript.
- Added the header `Prefer: return=minimal` to return only essential headers. This reduces the size of the request which gives a performance improvement to non-browser clients.

### Query (<code>_find</code> endpoint):

- The logic for determining whether a given index is valid for a query has changed, addressing a bug that could lead to incorrect results. 
- Queries using text indexes no longer crash when `$exists`: `false` is used.
- Partial indexes are now supported for both JSON and text indexes. See  [Creating a partial index](../api/cloudant_query.html#creating-a-partial-index) for more information.
- Execution statistics about a query can now be generated. These are enabled using the `execution_stats=true` parameter. See [finding documents by using an index](../api/cloudant_query.html#finding-documents-by-using-an-index) for more information.
- [Pagination](../api/cloudant_query.html#pagination) is supported using the bookmark field. Bookmarks are enabled for all index types.
- `_find` now falls back to any valid index if the value specified in the `use_index`
field is invalid for the current query. When this occurs, the `warning` field is populated in the query response.

## Build 6365 (August 17, 2017)

- `POST` requests to the `_revs_diff` endpoint require either the `_reader` or `_replicator` role.
- Add the `X-Frame-Options` header settings to prevent clickjacking. Learn more about [X-Frame-Options setting](/docs/services/Cloudant/release_info/deprecations.html#x-frame-options-setting).
- Add the replication scheduler. Learn more about [replication scheduler](/docs/services/Cloudant/api/advanced_replication.html#the-replication-scheduler).   

## Build 6276 (July 4, 2017)

- An error message that occurs when you attempt to put a document attachment with a non-existent revision has changed
to a 409 error with the following information: `{`error`:`not_found`,`reason`:`missing_rev`}`.

## Build 6233 (June 26, 2017)

- Fixes a {{site.data.keyword.cloudant_short_notm}} Query issue where indexes excluding potentially matching documents were selected by the query planner.

## Build 6069 (May 11, 2017)

- Previously, a replication job which crashed for some reason resulted in an update to the replication document,
  followed by a fresh attempt to start a new replication.
  Under some circumstances,
  this behavior could continue indefinitely: many duplicates of the same error message.
  A fix was introduced so that the replication document is not updated unless the reason for the error has changed.
- If the design document that is intended to specify a geospatial index is invalid,
  an attempt to retrieve information about the index by using
  the [`_geo_info` endpoint](../api/cloudant-geo.html#obtaining-information-about-a-cloudant-geo-index)
  results in an [HTTP `404`](../api/http.html#404) response.
- Added support for the `$allmatch` operator.

## Build 5834 (February 13, 2017)

- The maximum length of a document `id` is now 7168 characters (7k).

## Build 5728 (November 25, 2016)

- {{site.data.keyword.cloudant_short_notm}} is more tolerant of malformed user documents stored within the `_users` database.
  User documents should be structured and populated to comply with
  [Apache Software Foundation CouchDB requirements ![External link icon](../images/launch-glyph.svg "External link icon")](http://docs.couchdb.org/en/2.0.0/intro/security.html#users-documents){:new_window}.

## Build 5638 (October 11, 2016)

-   Introduces new `stable` and `update` query parameters for views.
-   Replicator no longer retries forever if it cannot write checkpoints to the source database.

## Build 5421 (June 14, 2016)

-	Changes feeds support view-based filters.
-	Changes feeds support the `_doc_ids` filter.
-	`POST` requests are supported for `_changes`.
-	Both `_all_docs` and `_changes` support the `attachments=true` parameter.
-	Support for the CouchDB 1.6 `_users` database features, including server-side hashing of passwords when documents are created in the `_users` database.
-	`/_bulk_get` endpoint to reduce the number of requests that are used in replication to mobile clients.
-	Design document metadata contains an `update pending` field.
-	{{site.data.keyword.cloudant_short_notm}} Query no longer returns an error if no valid index exists.d
