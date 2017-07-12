---

copyright:
  years: 2017
lastupdated: "2017-07-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-07-12 -->

# Release Notes

This document describes the changes and updates to Cloudant by build number. 
{:shortdesc}

## Dedicated hardware

A new [Dedicated service instance](bluemix.html#dedicated-plan) is available.

## Build 6069

- Previously, a replication job which crashed for some reason resulted in an update to the replication document,
  followed by a fresh attempt to start a new replication.
  Under some circumstances,
  this behavior could continue indefinitely: many duplicates of the same error message.
  A fix was introduced so that the replication document is not updated unless the reason for the error has changed.
- If the design document that is intended to specify a geospatial index is invalid,
  an attempt to retrieve information about the index by using
  the [`_geo_info` endpoint](../api/cloudant-geo.html#obtaining-information-about-a-cloudant-geo-index)
  results in an [HTTP `404`](http.html#404) response.

## Build 5834

- The maximum length of a document `id` is now 7168 characters (7k).

## Build 5728

- Cloudant is more tolerant of malformed user documents stored within the `_users` database.
  User documents should be structured and populated to comply with
  [Apache Software Foundation CouchDB requirements ![External link icon](../images/launch-glyph.svg "External link icon")](http://docs.couchdb.org/en/2.0.0/intro/security.html#users-documents){:new_window}.

## Build 5638

-   Introduces new "stable" and "update" query parameters for views.
-   Replicator no longer retries forever if it cannot write checkpoints to the source database.

## Build 5421

-	Changes feeds support view-based filters.
-	Changes feeds support the `_doc_ids` filter.
-	`POST` requests are supported for `_changes`.
-	Both `_all_docs` and `_changes` support the `attachments=true` parameter.
-	Support for the CouchDB 1.6 `_users` database features, including server-side hashing of passwords when documents are created in the `_users` database.
-	`/_bulk_get` endpoint to reduce the number of requests that are used in replication to mobile clients.
-	Design document metadata contains an `update pending` field.
-	Cloudant Query no longer returns an error if no valid index exists.


