---

copyright:
  years: 2017
lastupdated: "2017-12-15"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-07-12 -->

# Release Notes

Changes and updates to {{site.data.keyword.cloudantfull}} grouped by build number.
{:shortdesc}

## Dedicated hardware

A new [Dedicated service instance](../offerings/bluemix.html#dedicated-plan) is available.

## Build 6588 (December 7, 2017)

<ul>
<li>For security reasons, the use of eval() and Function() constructers is disabled in JavaScript by default.</li>

<li>A new parameter, <code>create_target_params</code>, was added that allows you to customize the target database 
that is created on a new replication. You can now customize the cluster's default values for the number of shards and
replicas to create. These values are specified as a JSON object and passed to the <code>/_replicator</code> endpoint.</li>

<li>The <code>_all_docs</code> scan now populates the warning field in the response to tell
the user that <code>use_index</code> was ignored. The warning message states, <code>`<_design/example>`
was not used because it does not contain a valid index for this query.</code> In this case,
<code><_design/example></code> is an actual index name.</li>

<li>With this fix, the appropriate 400 response and the reason for the failure are returned when
no index can fulfill a sort for a <code>_find</code> query.</li>

<li>If <code>use_index</code> specifies an index that is not valid for the query provided, Cloudant will fall back 
to the best valid index or a full database scan if no index is available. In both cases, the response 
will include a <code>warning</code> field to highlight that an invalid <code>use_index</code> value was specified.

<p>In the case that even a full database scan cannot be used to fulfill a query (for example, the query 
relies on sorting that must be determined by an index), Cloudant will return with a status code of 400 
and an error, <code>No index exists for this sort, try indexing by the sort fields.</code> </p></li>

<li>A new reduce overflow error is returned on a <code>_view</code> call to limit the amount of memory used to 
build a view that is the result of a bad reduce function.
</li>

<li>A new error is returned when calls to /<code><db></code>/<code>_temp_view</code> fail. The error is 
<code>410: GONE: Temporary views are not supported in CouchDB.</code></li>

<li>A request to <code>/_scheduler</code> without specifying subsections "docs" or "jobs" now returns a <code>Not found</code> error.</li>

<li>A new error is returned when a <code>new_edits</code> value is invalid in the <code>/db/_bulk_docs</code> URL. The error is <code>400: Bad request.</code></li></ul>


## Build 6366 (August 4, 2017) 

- Password changes no longer cause your replications to rewind.

## Build 6365 (August 17, 2017)

- `POST` requests to the `_revs_diff` endpoint require either the `_reader` or `_replicator` role.
- Add the `X-Frame-Options` header settings to prevent clickjacking. Learn more about [X-Frame-Options setting](/docs/services/Cloudant/release_info/deprecations.html#x-frame-options-setting).
- Add the replication scheduler. Learn more about [replication scheduler](/docs/services/Cloudant/api/advanced_replication.html#the-replication-scheduler).   

## Build 6276 (July 4, 2017)

- An error message that occurs when you attempt to put a document attachment with a non-existent revision has changed
to a 409 error with the following information: `{"error":"not_found","reason":"missing_rev"}`.

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

-   Introduces new "stable" and "update" query parameters for views.
-   Replicator no longer retries forever if it cannot write checkpoints to the source database.

## Build 5421 (June 14, 2016)

-	Changes feeds support view-based filters.
-	Changes feeds support the `_doc_ids` filter.
-	`POST` requests are supported for `_changes`.
-	Both `_all_docs` and `_changes` support the `attachments=true` parameter.
-	Support for the CouchDB 1.6 `_users` database features, including server-side hashing of passwords when documents are created in the `_users` database.
-	`/_bulk_get` endpoint to reduce the number of requests that are used in replication to mobile clients.
-	Design document metadata contains an `update pending` field.
-	{{site.data.keyword.cloudant_short_notm}} Query no longer returns an error if no valid index exists.
