---

copyright:
  years: 2015, 2025
lastupdated: "2025-09-25"

keywords: Cloudant, release notes, query, partition query, dedicated hardware plan, replication scheduler, views, runtime environment, IAM auth, Legacy auth, document updates, compaction, all databases, attachments, bulk get, bulk docs, indexes, view collation, changes feed, dbcopy, session, Javascript, local docs, all docs, security, active tasks

subcollection: Cloudant

content-type: release-note

---

{{site.data.keyword.attribute-definition-list}}

# Release notes for {{site.data.keyword.cloudant_short_notm}} Classic
{: #classic-release-notes}

Use these release notes to learn about the most recent updates to {{site.data.keyword.cloudantfull}} that are grouped by date and build number.
{: shortdesc}

## Ongoing changes
{: #Ongoing-changes}

### QuickJS

To support ES2023 JavaScript features and speed up index building,
{{site.data.keyword.cloudant_short_notm}} is replacing the
[SpiderMonkey][sm-qjs] JavaScript engine with [QuickJS][qjs-qjs].

[sm-qjs]: https://spidermonkey.dev/
[qjs-qjs]: https://bellard.org/quickjs/

Read [Migration to QuickJS from SpiderMonkey](/docs/Cloudant?topic=Cloudant-faq-migration-to-quickjs-from-spidermonkey) for full details on this change.

This could break some applications, and might require JavaScript updates in your design documents to align with QuickJS. Read the migration guide to understand whether this affects your instances.
{: note}

## Upcoming changes
{: #Upcoming-changes}

### Legacy authentication

To enhance security, Cloudant will enable temporary lockout of accounts in the coming months. After multiple login attempts using incorrect credentials, further login attempts will be denied for a period of time. To unlock your account, please wait for some time or change the password and then wait at least 5 minutes to ensure that the change propagates throughout the system.

The temporary lockout described here applies to legacy (non-IAM) credentials only.
{: note}

## September 2025
{: #cloudant-sep25}

### 18 September 2025
{: #Cloudant-sep1825}
{: release-note}

The following changes were made in build 8665:

Query
:   Improve the robustness of text-based queries. Read more about [Cloudant Query](/docs/Cloudant?topic=Cloudant-query)

Runtime environment
:   Upgrade the runtime environment to the latest Erlang/OTP 26 patch release.

## July 2025
{: #cloudant-jul25}

### 17 July 2025
{: #Cloudant-jul1725}
{: release-note}

The following changes were made in build 8650:

Cloudant Query
:   Fix query parameter parsing mechanism to improve stability during cluster upgrades.

Replicator
:   Improve replicator application shutdown behavior.

## June 2025
{: #cloudant-jun25}

### 24 June 2025
{: #Cloudant-jun2425}
{: release-note}

The following changes were made in build 8620:

Cluster setup
:   Enhance cluster robustness during node restarts and cluster partitions.

Optimization
:   Improve efficiency of starting database servers.

QuickJS
:   Fix QuickJS bigint heap overflow.
:   More robust out of memory handling.

Replicator
:   Reduce the chance of crashing replication jobs with the `ibrowse_stream_cleanup` errors.

## May 2025
{: #cloudant-may25}

### 20 May 2025
{: #Cloudant-may2025}
{: release-note}

The following changes were made in build 8612:

Query
:   A response to the `/_all_docs` or `/_design/<ddoc>/_view/<viewname>` endpoints would previously be silently limited to 268,435,456 rows. This limit has been removed to avoid truncating results, though the endpoints are still subject to the HTTP request timeouts defined by the service.

Runtime environment
:   Upgrade the runtime environment to the latest Erlang/OTP 26 patch release.

## April 2025
{: #cloudant-apr25}

### 24 April 2025
{: #Cloudant-apr2425}
{: release-note}

The following changes were made in build 8595:

New built-in reducers for views
:   `_first`/`_last` reducers return the first / last row associated with composite keys in the grouped views. For example, a view with keys of the form `[device, timestamp]` that specifies the `_first` reducer will return the most recent `timestamp` for each `device` when `group_level=1` is used at query time.
:   `_top_N`/`_bottom_N` reducers return the top / bottom `N` rows associated with each key, where `N` is in the range [1, 100] (inclusive).
:    For more information, see [Views (MapReduce)](/docs/Cloudant?topic=Cloudant-creating-views-mapreduce) and [Grouping](/docs/Cloudant?topic=Cloudant-grouping-related-documents-together-in-ibm-cloudant).

Runtime environment
:   Upgrade to the latest Erlang/OTP 26 release.

### 1 April 2025
{: #Cloudant-apr0125}
{: release-note}

The following changes were made in build 8588:

Optimization
:   Replication no longer re-replicates attachment bodies when the associated document is updated.

QuickJS
:   BigInt support.
:  `Date.parse` now returns `NaN` when dates are expressed as > 9 continuous digits.
:   Accept `/[\-]/u` as a valid regular expression.

## March 2025
{: #cloudant-mar25}

### 13 March 2025
{: #Cloudant-mar1325}
{: release-note}

The following changes were made in build 8585:

Attachments
:   Fix attachment size calculation.

Runtime environment
:   Upgrade to the latest Erlang/OTP 26 release.

Views
:   Restore the ability to return error objects from maps for the latest JavaScript engine `QuickJS`.

Welcome message
:   Improve robustness of the `search` feature status in the welcome message.

## February 2025
{: #cloudant-feb25}

### 26 February 2025
{: #Cloudant-feb2625}
{: release-note}

Instance limits
:   Add new `/_api/v2/user/capacity/databases` endpoint that returns the number of databases permitted for a Cloudant instance.
:   Add new `/_api/v2/user/current/databases` endpoint that returns the current database count of a Cloudant instance.

### 12 February 2025
{: #Cloudant-feb1225}
{: release-note}

The following changes were made in build 8577:

TLS support
:   Improve TLS security by verifying certificates for internal services.

## January 2025
{: #cloudant-jan25}

### 14 January 2025
{: #Cloudant-jan1425}
{: release-note}

Provisioning
:   Allow creation of Dedicated Hardware plan instances in the Chennai region.

### 8 January 2025
{: #Cloudant-jan0825}
{: release-note}

The following changes were made in build 8543:

Runtime environment
:   Upgrade to the latest Erlang/OTP 26 release.

## November 2024
{: #cloudant-nov24}

### 22 November 2024
{: #Cloudant-nov2224}
{: release-note}

The following changes were made in build 8542:

`X-Couch-Request-ID` HTTP header
:   Allow users to specify the request ID using `X-Couch-Request-ID` header, which is useful for tracking down requests that fail to start in a timely manner when using a load balancer in front.

Cloudant Query
:   Introduced `allow_fallback` (boolean) query parameter that determines whether `_find` can fall back to a full database scan if the query does not specify an index, or if the specified index is invalid for the query. If `allow_fallback=false`, a `400 Bad Request` is returned. The default value is `true`.

:   Prevent inserting illegal design documents via `_index` POST request.

Replication
:   Improve the robustness of replication.

Runtime environment
:   Downgrade to the latest Erlang/OTP 25 release.

Welcome message
:   JavaScript engine `quickjs` will show up in the list of welcome features if enabled as the default JavaScript engine.

## October 2024
{: #cloudant-oct24}

### 23 October 2024
{: #Cloudant-oct2324}
{: release-note}

The following changes were made in build 8537:

Runtime environment
:   Upgrade to the latest Erlang/OTP 26 release.

### 16 October 2024
{: #Cloudant-oct1624}
{: release-note}

The following changes were made in build 8536:

`_changes` endpoint
:   If the request includes `limit` parameter, `continuous` / `eventsource` feed emission will stop after emitting the specified number of rows.

Replicator
:   Prevent the replicator from creating conflicts in replication documents.

Runtime environment
:   Upgrade to the latest Erlang/OTP 25 release.

## September 2024
{: #cloudant-sep24}

### 19 September 2024
{: #Cloudant-sep1924}
{: release-note}

The following changes were made in build 8534:

Legacy authentication
:   Prepare for migration to a more secure password hashing scheme.

Runtime environment
:   Downgrade runtime environment to Erlang/OTP 25.

### 5 September 2024
{: #Cloudant-sep0524}
{: release-note}

The following changes were made in build 8524:

Runtime environment
:   Upgrade to the latest Erlang/OTP 26 release.

## August 2024
{: #cloudant-aug24}

### 7 August 2024
{: #Cloudant-aug0724}
{: release-note}

The following changes were made in build 8521:

`_scheduler` endpoint
:   Return a `400 Bad Request` response for `_scheduler/docs/{path}` in case of an invalid path, instead of `500 function_clause`.

`_search_analyze` endpoint
:   Authentication is now required to access the `_search_analyze` endpoint.

`COPY` request
:   Prevent creation of new documents if `Destination` header begins with `_` using the COPY method.

Replication
:   Improve robustness of replication during rebalancing.

Runtime environment
:   Upgrade to the latest Erlang/OTP 25 release.

Welcome message
:   The CouchDB version in the welcome message was updated from "*major*`.`*minor*`.`*patch*" to "*major*`.`*minor*`.`*patch*`+cloudant`", eg: `3.3.3+cloudant`. Cloudant applies its own customizations, extensions, and security fixes atop upstream CouchDB, therefore the CouchDB version number could be considered only a reference for compatibility. To make this distinction clear, the `+cloudant` suffix was introduced.

## June 2024
{: #cloudant-jun24}

### 10 June 2024
{: #Cloudant-jun1024}
{: release-note}

The following changes were made in build 8513:

IAM authentication
:   JSON web tokens (JWT) added the `exp` claim to ensure that user tokens are considered invalid once they expire.

Replicator
:   Fix replicator session plugin to consider only `Set-Cookie` headers with `AuthSession` set and ignore others.

### 5 June 2024
{: #Cloudant-jun0524}
{: release-note}

The following changes were made in build 8511:

IAM authentication
:   Refresh access tokens when credentials change. Previously, an access token was allowed to expire before obtaining a new one with the new credentials.

Runtime environment
:   Upgrade to the latest Erlang/OTP 25 release.

:   Add QuickJS as a Javascript engine option.

## April 2024
{: #cloudant-apr24}

### 26 April 2024
{: #Cloudant-apr2624}
{: release-note}

The following changes were made in build 8510:

IAM authentication
:   Add support for database resources in IAM access policies.

Cloudant Query
:   Fix a race condition that resulted in some query response execution stats incorrectly reporting zero for `total_keys_examined`. See https://github.com/apache/couchdb/issues/4560 for more details.

Replicator
:   Fix case clause error in replicator response. For more information, see [Advanced replication](/docs/Cloudant?topic=Cloudant-advanced-replication). 

Runtime environment
:   Upgrade to the latest [Erlang/OTP 25.3.2.11](https://github.com/erlang/otp/releases/tag/OTP-25.3.2.11) release.

## March 2024
{: #cloudant-mar24}

### 25 March 2024
{: #Cloudant-mar2524}
{: release-note}

The following changes were made in build 8495:

Optimization
:   Added compatibility for OTP 25 and improved performance.

### 20 March 2024
{: #Cloudant-mar2024}

Several updates were made to [Service Changes & Deprecations](https://cloud.ibm.com/docs/Cloudant?topic=Cloudant-deprecations-for-ibm-cloudant) - removing TXE notification; adding previously announced deprecation of `_show`, `_list`, `_update`, `_rewrite` functions; removing `_find` API accounting notice.

### 8 March 2024
{: #Cloudant-mar0824}
{: release-note}

List of {{site.data.keyword.cloudant_short_notm}} instances hosted on a dedicated environment
:   The {{site.data.keyword.cloud_notm}} Console GUI for {{site.data.keyword.cloudant_short_notm}} instances on dedicated hardware plan now shows the list of instances hosted on the dedicated environment.

### 6 March 2024
{: #Cloudant-mar0624}
{: release-note}

The following changes were made in build 8490:

Runtime environment
:   Upgrade runtime environment back to Erlang/OTP 25 after addressing the related production issues.

## February 2024
{: #cloudant-feb24}

### 12 February 2024
{: #Cloudant-feb1224}
{: release-note}

The following changes were made in build 8472:

Indexes
:   In rare cases, background index updates for specific indexes would fail until a database node was restarted. After a node restart, the node would immediately start updating these indexes. If this generated a lot of indexing activity, customer requests involving this node would see degraded performance during that activity. This release fixes the issue with background indexing failures. For more information, see [Cloudant Query](https://cloud.ibm.com/docs/Cloudant?topic=Cloudant-query).

Replication
:   Improve performance when updating replication documents.

:   Fix replication delays caused by conflicting jobs during internal data optimization. For more information, see [Replication](https://cloud.ibm.com/docs/Cloudant?topic=Cloudant-replication-guide).

Runtime environment
:   Downgrade runtime environment to Erlang/OTP 24.

## January 2024
{: #cloudant-jan24}

### 10 January 2024
{: #Cloudant-jan1024}
{: release-note}

The following changes were made in build 8469:

Runtime environment
:   Upgrade to Erlang/OTP-25.3.2.8.

## December 2023
{: #cloudant-dec23}

### 04 December 2023
{: #Cloudant-dec0423}
{: release-note}

The following changes were made in build 8462:

`_active_tasks`
:   Optimize `_active_tasks` to better handle heavy workloads.

Indexing
:   Improve robustness of index compaction.

Cloudant Query
:   Introduce `$beginsWith` operator.

Runtime environment
:   Downgrade runtime environment to Erlang/OTP 24.

Security
:   Allow stronger on-disk password hashes without impacting database request performance.

## November 2023
{: #cloudant-nov23}

### 17 November 2023
{: #Cloudant-nov1723}
{: release-note}

{{site.data.keyword.cloudant_short_notm}} Dashboard
:   Update the Cloudant Query explain page with a user-friendly view of the JSON output. The parsed view better explains how indexes are chosen to help the user create more efficient queries. 

## October 2023
{: #cloudant-oct23}

### 24 October 2023
{: #Cloudant-oct2423}
{: release-note}

The following changes were made in build 8452:

Runtime environment
:   Upgrade to the latest Erlang/OTP 25 release.

### 18 October 2023
{: #Cloudant-oct1823}
{: release-note}

The following changes were made in build 8451:

Security
:   Scrub sensitive headers from JSON requests.

### 13 October 2023
{: #Cloudant-oct1323}
{: release-note}

The following changes were made in build 8448:

`_db_updates` endpoint
:   Remove `_db_updates` endpoint support.

Cloudant Query
:   Correct `_explain` API to always return an array for `fields`. Return `[]` instead of `"all_fields"` if the `fields` parameter was unset.

:   Prevent occasional duplication of paginated `text` results.

Legacy authentication
:   Send compatible AuthSession cookie when possible.

Replicator
:   Fix `badrecord` error when cancelling transient replication job.

:   Replace `kaboom` with `open_doc_revs_failed` error.

:   Use HTTP rules for hostname verification.

## September 2023
{: #cloudant-sep23}

### 14 September 2023
{: #Cloudant-sep1423}
{: release-note}

The following changes were made in build 8442:

`_changes` feed
:   Improve emitted changes feed sequence after a split.

:   Return the correct number of pending changes when `descending=true`.

Design documents
:   `_design_docs/queries` / `_local_docs/queries` with parameter `keys` will return only design / local documents respectively.

Legacy authentication
:   Send a session cookie after successful basic authentication to migrate users to a strong password hashing scheme without impacting performance for each request.

Cloudant query
:   Remove duplicate elements from `indexable_fields` results.

:   Correct the `_explain` endpoint `r` response field content from a byte array to an integer to match the declared API type.

:   Rename the `_explain` endpoint response `covered` field name to `covering` to match correctly the Apache CouchDB name.

Replicator
:   Fix undefined range in `mem3_rep` purge replication logic.

:   Crash replication jobs on unexpected 4XX errors.

:   Add `CouchDB-Replicator/...` user agent to replicator `/_session` requests.

Search
:   Correct the representation of empty faceted results from `0` to `{}` to match the declared API type.

    See [PR](https://github.com/apache/couchdb/pull/4704){: external}.

Shard splitting
:   Allow resumption of failed jobs, and make `timeout` configurable.

Optimization
:   Stop the client process and clean up if the client disconnects.


## August 2023
{: #cloudant-aug23}

### 30 August 2023
{: #Cloudant-aug3023}
{: release-note}

The following changes were made in build 8435:

`_all_dbs` endpoint
:   Restrict `_all_dbs` to accept only binary `start_key`/`end_key` parameters.

`_replicate` endpoint
:   Authentication is required to access the `_replicate` endpoint.

Cloudant Query
:   Improve error messages in case of invalid field errors.

Replicator
:    Remove replicator endpoint proxy support.

## July 2023
{: #cloudant-jul23}

### 21 July 2023
{: #Cloudant-jul2123}
{: release-note}

The following changes were made in build 8430:

Attachments
:   Fix multipart parser "attachment longer than expected" error.

:   Remove Content-MD5 header support.

:   Replace MD5 with xxHash in ETag generation.

Cloudant Query
:   Return correct `keys_examined` value in `execution_stats` field.

:   Improve error messages of the `_index` endpoint.

Optimization
:   Speed up internal replicator.

:   Optimize low-level file name calculations.

:   Use a faster sets implementation available since OTP 24.

Replicator
:   Handle replicator instance start time during upgrades better.

Resharding
:   Fix purge infos replicating to the wrong shards during shard splitting.

## June 2023
{: #cloudant-jun23}

### 05 June 2023
{: #Cloudant-jun0523}
{: release-note}

The following changes were made in build 8413:

`_all_docs` endpoint
:   Do not return documents for non-string `key` parameter.

Filter view functions
:   Optimize by not unnecessarily re-compiling filter view functions.

Geospatial
:   Remove geospatial functionality.

Javascript
:   Treat javascript internal errors (such as Out of Memory) as fatal.

`_local_docs` endpoint
:   Hide internal checkpoint documents by default in the `_local_docs` response.

Cloudant Query
:   Return correct documents for queries with `$regex` and text indexes.

:   Optimize queries using keys-only covering indexes.

:   Add new covered Boolean field to `_explain` endpoint to indicate whether query is covered by an index.

:   Return 405 instead of 500 for invalid path under `_index` endpoint.

Partitioned database queries
:   Fix permissions required for partitioned `_find` and `_explain` endpoints.

Runtime environment
:   Upgrade to the latest Erlang/OTP 24 release.

View query
:   Treat single element `keys` parameter same as `key`.

## April 2023
{: #cloudant-apr23}

### 03 April 2023
{: #Cloudant-apr0323}
{: release-note}

{{site.data.keyword.cloudant_short_notm}} Dashboard
:   Update Dashboard to use Carbon 11's color theme.

The following changes were made in build 8382:

Indexing
:   Prevent `couch_index_server` from crashing under load.

Runtime environment
:   Upgrade the runtime environment to latest Erlang/OTP 24 point release.

## March 2023
{: #cloudant-mar23}

### 14 March 2023
{: #Cloudant-mar1423}
{: release-note}

The following changes were made in build 8373:

`_changes` endpoint
:   Enforce document ids `_changes` filter optimization limit.

Compaction
:   Active database size now decreases when users delete documents.

Indexing
:   Enforce partition index count limits for (noninternally) replicated documents.

:   Optimize process pool management (fixes CVE-2023-26268).

Query
:   Optimize by pushing down field selectors to shards.

Replication
:   Replace auto-inserted VDU with BDU.

:   Constrain protocol types and socket options.

:   Upload design docs individually when you replicate with `bulk_get`.

Runtime environment
:   Upgrade the runtime environment to Erlang/OTP 24 point release patched with `alias-cleanup-fix`.

Views
:   Disable `stable` and `stale` parameters in POST requests to partitioned views.

## January 2023
{: #cloudant-jan23}

### 11 January 2023
{: #Cloudant-jan1123}
{: release-note}

The following changes were made in build 8349:

IAM trusted profiles
:   Fix bug in IAM trusted profiles.

Runtime environment
:   Upgrade runtime environment to Erlang/OTP 24.

## November 2022
{: #cloudant-nov22}

### 17 November 2022
{: #Cloudant-nov1722}
{: release-note}

The following changes were made in build 8341:

`_bulk_get` endpoint
:   Optimize `_bulk_get` endpoint.

`_changes` endpoint
:   Fix `eventsource` formatted feed.

:   Remove support for the long-deprecated change sequence format.

`dbcopy`
:   Prevent further use of `dbcopy` feature for all but current users.

Compaction
:   Fix smoosh `get_priority/2` case clause.

Replication
:   Use the `_bulk_get` endpoint for replication if available.

:   Return a string for the default start sequence from `_scheduler/{jobs,docs}` endpoints.

`_session` endpoint
:   Return error when POSTing to `/_session` with content type other than `application/x-www-form-urlencoded` or `application/json`.

Runtime environment
:   Upgrade runtime environment to Erlang/OTP 23 patch release.

## September 2022
{: #cloudant-sep22}

### 21 September 2022
{: #Cloudant-sep2122}
{: release-note}

The following changes were made in build 8336:

Runtime environment
:   Upgrade runtime environment to Erlang/OTP 23 patch release.

View collation
:   Upgrade view collator to libicu 67.1.

## August 2022
{: #cloudant-aug22}

### 5 August 2022
{: #Cloudant-aug0522}
{: release-note}

The following changes were made in build 8335:

Bulk docs
:   Improve performance for `_bulk_docs` endpoint.

Compaction
:   Fix bugs in automatic compaction.

:   Fix race between database deletion and compaction.

Document updates
:   Improve reliability of document updates during heavy load.

:   Return a 400 response for `new_edits=false` document update without revisions.

Replicator
:   Introduce numerous performance improvements.

## June 2022
{: #cloudant-jun22}

### 10 June 2022
{: #Cloudant-jun1022}
{: release-note}

The following changes were made in build 8310:

All databases
:   Fix `skip` and `limit` parameters for `_all_dbs` and `_dbs_info` endpoints.

Attachments
:   Wait until attachments are uploaded before response to client.

Bulk docs
:   Return 500 errors if timeouts occur when documents are bulk loaded.

Compaction
:   Retain compactor state across node reboots.

IAM authentication
:   Retry `authz` endpoint on failure.

Indexes
:   Prevent creation of indexes with empty `name` or `ddoc` fields.

:   Improve index building during shard splitting.

Replicator
:   Improve replicator stability during timeouts.

## May 2022
{: #cloudant-may22}

### 25 May 2022
{: #Cloudant-may2522}
{: release-note}

Virtual Private Endpoints (VPE)
:   VPE can now be created for {{site.data.keyword.cloudant_short_notm}} instances on dedicated hardware.

### 13 May 2022
{: #Cloudant-may1322}
{: release-note}

The following changes were made in build 8299:

Runtime environment
:   Upgrade runtime environment to Erlang/OTP 23 with fix for memory leak.

Replicator
:   Fix `function_clause` error for replicated changes with a target VDU.

## April 2022
{: #cloudant-apr22}

### 14 April 2022
{: #Cloudant-apr1422}
{: release-note}

The following changes were made in build 8287:

Runtime environment
:   Downgrade runtime environment to Erlang/OTP 20.

## March 2022
{: #cloudant-mar22}

### 24 March 2022
{: #Cloudant-mar2422}
{: release-note}

The following changes were made in build 8278:

IAM authentication
:   Improve compatibility during upgrades.

Document updates and compaction
:   Improve efficiency of updating and compacting conflicted documents.

### 11 March 2022
{: #Cloudant-mar1122}
{: release-note}

The following changes were made in build 8269:

Runtime environment
:   Upgrade runtime environment to Erlang/OTP 23.

### 04 March 2022
{: #Cloudant-mar0422}
{: release-note}

The following changes were made in build 8266:

Bulk docs
:   Return 400 Bad Request error for `_bulk_docs` with `new_edits:false` and without `_rev`. Previously returned 500 error.

:   Fix bug where Validate Document Update function interacts with `new_edits:false` setting.

Indexing
:   Improve scalability by sharding the index server.

Replicator
:   Set `instance_start_time` to the creation time of the database to restore the ability for the replicator to detect a database recreation event during a replication.

Search
:   Expose index signature in the `_search_info` endpoint response.

Security
:   Always send all the cookie attributes whenever we send a cookie. Only the value of AuthSession varies.

Views
:   Track ICU collator version that is used to build the view and expose this information in existing endpoints.

:   Exposes list of collator versions in `_design/*/_info` endpoint response.

:   The opaque collator version in `_node/*/_versions` endpoint response.

## January 2022
{: #cloudant-jan22}

### 28 January 2022
{: #Cloudant-jan2822}
{: release-note}

Switch `Legacy Credentials and IAM` to `IAM only`
:   It is now possible to switch authentication methods from `Legacy Credentials and IAM` to `IAM only` by using the {{site.data.keyword.cloud_notm}} console.

## December 2021
{: #cloudant-dec21}

### 03 December 2021
{: #Cloudant-dec0321}
{: release-note}

{{site.data.keyword.cloud_notm}} Monitoring integration
:   Metrics are now available in the Frankfurt region.

## November 2021
{: #cloudant-nov21}

### 01 November 2021
{: #Cloudant-nov0121}
{: release-note}

The following changes were made in build 8243:

Audit messages
:   Order customer supplied fields last in audit messages.

Changes feed
:   Reduce changes feed rewinds when nodes are down or shards are moved.

View collation
:   Fix reduce view collation results for Unicode equivalent keys.

## October 2021
{: #cloudant-oct21}

### 01 October 2021
{: #Cloudant-oct0121}
{: release-note}

The following changes were made in build 8238:

Changes feed
:   Use shards moved from other nodes to help prevent changes feed rewind.

Error message
:   Reduce frequency of `No DB shards could be opened` error message.

Shards with purge sequences
:   Fix splitting shards with large purge sequences.

View results
:   Fix view results with `limit=0` and `sorted=false`.

Sort view results
:   Properly sort view results with `descending=true` when a key list is provided.

Row aggregation
:   Stabilize view merge row aggregation.

## September 2021
{: #cloudant-sep21}

### 1 September 2021
{: #Cloudant-sep0121}
{: release-note}

The following changes were made in build 8220.

Changes feed rewinds
:   Avoid changes feed rewinds after shard moves.

Response code
:   Fix response code for attachment deletion with wrong revision.

Indexes
:   Ensure that indexes are correctly closed.

## August 2021
{: #cloudant-aug21}

### 1 August 2021
{: #Cloudant-aug0121}
{: release-note}

The following changes were made in build 8202:

IAM trusted profiles
:   Support IAM trusted profiles.

### 15 August 2021
{: #Cloudant-aug1521}
{: release-note}

The following changes were made in build 8201:

Improvements
:   Internal bug fixes.

## June 2021
{: #cloudant-jun21}

### 1 June 2021
{: #Cloudant-jun0121}
{: release-note}

The following changes were made in build 8194:

API task filtering
:   Bug fixes, including account API key task filtering.

Replication support
:   Support replication [basic auth credentials in auth object](https://github.com/apache/couchdb/pull/3586).

Basic auth credentials
:   No longer display basic auth credentials (for example, `username:*****`) in the output of these endpoints:

    - `_scheduler/jobs`
    - `_scheduler/docs`
    - `_active_tasks`

## April 2021
{: #cloudant-apr21}

### 1 April 2021
{: #Cloudant-apr0121}
{: release-note}

The following changes were made in build 8192:

New! Fair share replicator
:   Added Fair share replicator. For more information, see [Fair Share Replication Scheduler Implementation](https://github.com/apache/couchdb/commit/ab38c2dd3f429ce8f347fa4f04e2815b810a8a19){: external}.

Improvements
:   Internal bug fixes.

## March 2021
{: #cloudant-mar21}

### 15 March 2021
{: #Cloudant-mar1521}
{: release-note}

The following changes were made in build 8182:

Improvements
:   Internal bug fixes.

Caching
:   Apply caching to account-local `_users` databases.

Error condition
:   Treat 408 as a retryable error condition for replicator.

Compressed requests
:   Allow compressed (`gzipped`) requests to `/_session` endpoint.

`/_active_tasks` endpoint
:   Show process status in `/_active_tasks` endpoint.

`/{DB}/_changes` endpoint
:   Validate JSON payload on `POST` to `/{DB}/_changes` endpoint.

## December 2020
{: #cloudant-dec20}

### 1 December 2020
{: #Cloudant-dec0120}
{: release-note}

The following changes were made in build 8169:

New! Cloudant query operator
:   Introduce the query operator, `$keyMapMatch` that offers the ability to make queries on the keys of a map.

Improvements
:   Internal bug fixes.

Database reporting
:   Report the database that was used for authentication for a `GET /_session` request, provided it is configured.

## September 2020
{: #cloudant-sep20}

### 1 September 2020
{: #Cloudant-sep0120}
{: release-note}

The following changes were made in build 8162:

Improvements
:   Internal bug fixes.

`Drilldown` parameters
:   `Drilldown` parameters for text index searches can now be specified as a list of lists, which gives you the ability to avoid having to define it redundantly in a single query. Some languages don't have this facility.

`couch_index` server
:   The `couch_index` server doesn't crash and log errors in the following cases: If a design document is deleted while that index is building, or when a design document is added immediately after database creation.

Invalid parameters
:   {{site.data.keyword.cloudant_short_notm}} now checks for and reports invalid parameters on database creation.

## July 2020
{: #cloudant-jul20}

### 1 July 2020
{: #Cloudant-jul0120}
{: release-note}

The following changes were made in build 8158:

Improvements
:   Internal bug fixes.

## May 2020
{: #cloudant-may20}

### 15 May 2020
{: #Cloudant-may1520}
{: release-note}

The following changes were made in build 8153:

Improvements
:   Internal bug fixes.

## April 2020
{: #cloudant-apr20}

### 1 April 2020
{: #Cloudant-apr0120}
{: release-note}

The following changes were made in build 8152:

Improvements
:   Internal bug fixes.

## March 2020
{: #cloudant-mar20}

### 15 March 2020
{: #Cloudant-mar1520}
{: release-note}

The following changes were made in build 8142:

New! Endpoints
:   New endpoints were added, so you can post multiple queries: `POST /{db}/_all_docs/queries` and `POST /{db}/_design_docs/queries`.

Multiple queries
:   The ability to submit multiple queries against a view by using the `POST` to `/{db}/_design/{ddoc}/_view/{view}` with the `?queries` option was replaced by the new `queries` endpoint. The same is true of the `_all_docs` and `_design_docs` endpoints. Specify a `keys` object when you `POST` to these endpoints.

`disk_size` and `data_size` fields
:   The `disk_size` and `data_size` fields were retired from the database information object that is returned by `GET /{db}`.

`/{db}/_changes` feed
:   The `/{db}/_changes` feed immediately returns headers now, even when no changes are available. This process prevents client's from becoming blocked.

Negative and noninteger heartbeat values
:   Negative and noninteger heartbeat values now return a `400 Bad Request` response status code.

Separate proxies
:   Allow specifying separate proxies for both the source and target in a replication by using `source_proxy` and `target_proxy` keys.

`POST` view function
:   The `POST` view function now supports identical parameters and behavior as specified in the `/{db}/_design/{ddoc}/_view/{view}`, `/{db}/_all_docs`, and `/{db}/_design_docs` endpoints. You can supply query string parameters as keys in a JSON object in the body of the `POST` request.

Replication errors
:   Replication `"info"` errors are now JSON objects. Previously, they were strings.

Replication support
:   A compatibility change was made to support replication with future databases that contain per-document access control fields.

Warning message
:   Add a warning to the `_find` endpoint if multiple document scans were required to generate a result.

`_find` endpoint error
:   Fix a bug in the `_find` endpoint whereby an error would be returned if a document matched by a text index was deleted while the query was being processed.

## January 2020
{: #cloudant-jan20}

### 15 January 2020
{: #Cloudant-jan1520}
{: release-note}

The following changes were made in build 8126:

Improvements
:   Internal bug fixes.

Replication error reports
:   Improvements to replication error reporting - instead of a function_clause, human-readable markers are returned, for example, `bulk_docs_failed`. Stack traces are no longer included.

Replication job statistics
:   Replication job statistics, such as `docs_read`, `docs_written`, and `doc_write_failures` are preserved when replication jobs restart.

Replication jobs
:   Replication jobs to a target endpoint by using IAM Writer permissions no longer crash and continuously restart when they write design documents. Instead, the `doc_write_failures` statistic is incremented for each failed design document write. This behavior is consistent with replicating by using the legacy API-key-based authentication.

## November 2019
{: #cloudant-nov19}

### 1 November 2019
{: #Cloudant-nov0119}
{: release-note}

The following changes were made in build 8111:

Improvements
:   Internal bug fixes.

Replication statistics
:   The `_scheduler/docs` endpoint now includes more detailed replication statistics to match `_active_tasks` output. It also includes details on replications that started with `_replicate`.

Replication error
:   Fix an instance where the replicator failed a replication but the error was recoverable.

Empty payload
:   Fix a bug introduced in recent builds where sending an empty payload to `_bulk_docs` would result in a 400 response status code rather than accepting the no-op operation.

## October 2019
{: #cloudant-oct19}

### 21 October 2019
{: #Cloudant-oct2119}
{: release-note}

Multiple restrictions employed for performance gains
:   {{site.data.keyword.IBM_notm}} released exciting new capabilities for {{site.data.keyword.cloudant_short_notm}} that are available now. {{site.data.keyword.cloudant_short_notm}} documented the deprecation of some functionality, and also, new restrictions for other processes. A communication was  released that details the exact timeline when these restrictions go into effect. If you use any of the following functions or are concerned about how to make the necessary application changes, reach out to support by email. The following functions are affected by this deprecation:

   - Remove the `offset` field from the response body of an `all_docs` request. The {{site.data.keyword.cloudant_short_notm}} team recommends that you use paging with `start_key` / `end_key` and `limit`.

   - The `_sorted` field has no functional effect because all responses are sorted automatically.
   - Duration of operations has a 5-second limit. Transactions lasting more than 5 seconds fail.
   - Limitations on keys (10 KB) and values (100 KB) that are emitted from a map function are shown in the following list:
      - The sum of all keys that are emitted for a document cannot exceed 100 KB.
      - Emitted keys cannot exceed 10 KB.
      - Values cannot exceed 100 KB.
      - In rare cases, the number of key-value pairs that are emitted for a map function can affect database performance or violate {{site.data.keyword.cloudant_short_notm}} rules. For example, the number of key-value pairs might lead to a transaction either exceeding 10 MB, which isn’t allowed, or exceeding 5 MB, which impacts the performance of the database. In this situation, {{site.data.keyword.cloudant_short_notm}} returns an error.
   - The `stable = true` option is no longer supported, and the `stale = "ok"` option is converted to `update = false`.

### 15 October 2019
{: #Cloudant-oct1519}
{: release-note}

The following changes were made in build 8106:

Improvements
:   Internal bug fixes.

### 1 October 2019
{: #Cloudant-oct0119}
{: release-note}

The following changes were made in build 8103:

`X-Cloudant-Action` HTTP response header
:   New `X-Cloudant-Action` HTTP response header that returns the {{site.data.keyword.cloud}}    IAM actions that are associated with a request.

Search requests
:   Previously, search requests would return a `400` status code both on a bad request and on internal server errors. Now, internal server errors correctly return a `500` response status code.

## September 2019
{: #cloudant-sep19}

### 18 September 2019
{: #Cloudant-sep1819}
{: release-note}

Replaced deprecated database information fields
:   Calls to `GET /{db}` were replaced by the following fields:

    | Old Field | New Field |
    |-----------|-----------|
    | `data_size` | `sizes.active` |
    | `disk_size` | `sizes.file` |
    | `other.data_size` | `sizes.external` |
    {: caption="Database information fields" caption-side="top"}

    Calls to `GET /{db}/_design/{ddoc}/_info` were replaced by the following fields:

    | Old Field | New Field|
    |-----------|----------|
    | `data_size` | `sizes.external` |
    | `disk_size` | `sizes.file` |
    {: caption="Design doc information fields" caption-side="top"}

## June 2019
{: #cloudant-jun19}

### 1 June 2019
{: #Cloudant-jun0119}
{: release-note}

The following changes were made in build 8076:

Improvements
:   Internal bug fixes.

Stability
:   Stability improvements.

## May 2019
{: #cloudant-may19}

### 15 May 2019
{: #Cloudant-may1519}
{: release-note}

The following changes were made in build 8070:

Improvements
:   Internal bug fixes.

### 1 May 2019
{: #Cloudant-may0119}
{: release-note}

The following changes were made in build 8062:

Improvements
:   Internal bug fixes.

## April 2019
{: #cloudant-apr19}

### 15 April 2019
{: #Cloudant-apr1519}
{: release-note}

The following changes were made in build 8058:

`ibrowse` HTTP client
:   Fixed bug in `ibrowse` HTTP client that leaves dead process IDs in the connection pool, and in some cases, caused persistent IAM-based replication failures.

### 1 April 2019
{: #Cloudant-apr0119}
{: release-note}

The following changes were made in build 8052:

`partitioned_indexes` field
:   Accessing the database information endpoint (`/db/`) for a partitioned database
    now includes information about the contained partitioned indexes. The new field, `partitioned_indexes`, contains the following
    information:

   - The current number of partitioned indexes in the database (`count`).
   - A breakdown of those indexes by type (`indexes`).
   - The maximum partitioned indexes allowed for this database (`limit`).

## March 2019
{: #cloudant-mar19}

### 15 March 2019
{: #Cloudant-mar1519}
{: release-note}

The following changes were made in build 8048:

Improvements
:   Internal bug fixes.

### 1 March 2019
{: #Cloudant-mar0119}
{: release-note}

The following changes were made in build 8038:

Partition queries
:   Allow `POST` when you search [partition queries](/docs/Cloudant?topic=Cloudant-database-partitioning#database-partitioning).

## February 2019
{: #cloudant-feb19}

### 15 February 2019
{: #Cloudant-feb1519}
{: release-note}

The `stale` option
:   The `stale` option is deprecated and is replaced by `stable` and `update`, which
allow controlling the two orthogonal behaviors that are caused by `stale` separately.

   | `stable` value   | Equivalent by using `stable` and `update` |
   |---------|-----------------------------------------------|
   | `false`  | `stable=false`, `update=true` |
   | `ok`  | `stable=true`, `update=false` |
   | `update_after`  | `stable=true`, `update=lazy` |
   {: caption="Stale option replacement" caption-side="top"}

### 1 February 2019
{: #Cloudant-feb0119}
{: release-note}

The following changes were made in build 7681:

Partition query
:   Partition query bug fixes.

## January 2019
{: #cloudant-jan19}

### 15 January 2019
{: #Cloudant-jan1519}
{: release-note}

The following changes were made in build 7668:

New! Partition query
:   This build introduces a new feature, [partition query](/docs/Cloudant?topic=Cloudant-database-partitioning#database-partitioning).

`limit`
:   Allow `limit` when you use `POST` for search.

View requests
:   Previously, view requests that use a `limit` parameter greater than 268435456 would have the limit that is silently reduced to 268435456. Now, requests with the `limit` parameter greater than 268435456 are rejected with a `400 Bad Request` error.

### 1 January 2019
{: #Cloudant-jan0119}
{: release-note}

The following changes were made in build 7631:

Improvements
:   Internal changes and bug fixes.

## December 2018
{: #cloudant-dec18}

### 1 December 2018
{: #Cloudant-dec0118}
{: release-note}

The following changes were made in build 7544:

Replicator statistics
:   Fixed a problem where the replicator would sometimes reset statistics during
    replications. The reset would affect values in the [replication status
    information](/docs/Cloudant?topic=Cloudant-advanced-replication#advanced-replication).
     See [PR](https://github.com/apache/couchdb/pull/1722){: external}.

{{site.data.keyword.cloudant_short_notm}} Query and `_find` request
:   Fixed an issue with {{site.data.keyword.cloudant_short_notm}} Query. After you delete a document, if you issue
    a `_find` request to a text index with `update=false`, it might return a
    `500` response.
    See [PR](https://github.com/apache/couchdb/pull/1709){: external}.

`_bulk_get`
:   You can now use `multipart/mixed` and `multipart/related` when you use
    `_bulk_get`. See [PR](https://github.com/apache/couchdb/pull/1195){: external}.

`_design_docs` handler
:   Fix a bug with total row count in the `_design_docs` handler.
     See [PR](https://github.com/apache/couchdb/pull/1744){: external}.

Replication filters
:   Optimizations to the `_doc_id` and `_design_docs` replication filters.
     See [issue](https://github.com/apache/couchdb/issues/1737){: external}.

Index jobs
:   Fix a regression where long-running index jobs can fail.

## November 2018
{: #cloudant-nov18}

### 4 November 18
{: #Cloudant-nov0418}
{: release-note}

The following changes were made in build 7410:

Improvements
:   Internal changes and bug fixes.

### 1 November 2018
{: #Cloudant-nov0118}
{: release-note}

The following changes were made in build 7426:

Improvements
:   Internal bug fixes to data compression, search, and core database components.

Audit logs
:   Include [CRN](/docs/account?topic=account-crn) in audit logs.

Replicator
:   Replicator stability improvements.

`q` parameter
:   Improve validation of `q` parameter on database creation. See [COUCHDB-1582](https://issues.apache.org/jira/browse/COUCHDB-1582){: external}.

`_bulk_get` endpoint
:   Fix error in `_bulk_get` endpoint for the `_users` database. See [COUCHDB-1650](https://issues.apache.org/jira/browse/COUCHDB-1650){: external}.

JavaScript URL rewrites
:   Fix JavaScript URL rewrites hanging on `POST` or `PUT` requests. See [COUCHDB-1612](https://issues.apache.org/jira/browse/COUCHDB-1612){: external}.

{{site.data.keyword.cloudant_short_notm}} Query and invalid `reduce` functions
:   Fix invalid `reduce` functions in {{site.data.keyword.cloudant_short_notm}} Query indexes that prevent indexing. See [COUCHDB-1666](https://issues.apache.org/jira/browse/COUCHDB-1666){: external}.

## October 2018
{: #cloudant-oct18}

### 11 October 2018
{: #Cloudant-oct1118}
{: release-note}

The following changes were made in build 7304:

Improvements
:   This build is identical to build 7302 except that the build is on Erlang 17.5 instead of Erlang 20.

## September 2018
{: #cloudant-sep18}

### 25 September 2018
{: #Cloudant-sep2518}
{: release-note}

The following changes were made in build 7302:

Cloudant Query
:   Improve Cloudant Query so that mixed clusters return correct results during upgrades.

Downgrade function
:   Add a downgrade function to support future cluster purge releases.

Search blocklist
:   Improve search blocklist.

### 18 September 2018
{: #Cloudant-sep1818}
{: release-note}

The following changes were made in build 7276:

Improvements
:   Add a filter for databases that are being opened asynchronously to prevent exceptions when `couch_server` terminates.

Concurrency error
:   Fix `couch_server` concurrency error.

Configuration option
:   Add a configuration option to disable off-heap messages.

### 13 September 2018
{: #Cloudant-sep1318}
{: release-note}

TLS 1.3 connection support
:   From today, {{site.data.keyword.cloudant_short_notm}} supports TLS 1.3 connections to {{site.data.keyword.cloudant_short_notm}}.

:   {{site.data.keyword.cloudant_short_notm}} recommends that you use TLS 1.2 or 1.3 for all access to {{site.data.keyword.cloudant_short_notm}}. 
***(In June 2019, {{site.data.keyword.cloudant_short_notm}} retired the use of older
versions (TLS 1.0 and 1.1) at which point only TLS 1.2+ is supported.)*** Find more information on the [Security page](/docs/Cloudant?topic=Cloudant-security#security).

### 7 September 2018
{: #Cloudant-sep0718}
{: release-note}

The following changes were made in build 7205:

Refactor Cloudant Query selectors
:   Improve efficiency of Cloudant Query by adding support for predicate push-down to database shards.

Document update errors
:   Expose document update errors on concurrent document updates to client.

`render_error` errors
:   Fix `render_error` errors where the `req` object that is passed to the JavaScript list function is set to `noproc` Atom.

## August 2018
{: #cloudant-aug18}

### 1 August 2018
{: #Cloudant-aug0118}
{: release-note}

The following changes were made in build 7138:

Erlang
:   Upgrade to Erlang OTP 20.

### 15 August 2018
{: #Cloudant-aug1518}
{: release-note}

The following changes were made in build 7137:

Validation of configuration parameters
:   Improve validation of configuration parameters supplied by administrator.

Compaction
:   While compaction is running, delete compaction files when database is deleted.

Sandboxing feature
:   Improve sandboxing features.

Authentication check
:   Optimize authentication check.

Semantics
:   Change semantics of status codes for delete database.

`conflicts: true` support
:   Support `conflicts: true` for queries to the `/{db}/_find` endpoint.

`update_seq` field
:   Preserve `update_seq` field across view compaction.

## July 2018
{: #cloudant-jul18}

### 12 July 2018
{: #Cloudant-jul1218}
{: release-note}

The following changes were made in build 7084:

`stats` reducer
:   Refactor code for `_stats` reducer.

Views
:   Fix active size calculations for views.

`couch_key_tree` algorithm
:   Rewrite the `couch_key_tree` algorithm to reduce its computational complexity and avoid calling stemming when unnecessary.

Allocation strategy
:   Change the allocation strategy for the message queue for each important process, so it's not stored on the heap of that process.

Internal audit facility
:   Improvements to internal audit facility.

Constant fields
:   Any constant fields that are in the selector, and are part of the index. For example, `{A: {$eq: 10}}` is inserted into the sort list if they aren't already included. This method increases the chance that the best index is selected for the query, for example, index = `[A, B]`, sort = `[B]`, and selector = `{A: 1}`. The sort then becomes `[A, B]`.

Only the fields that are in front of the current sort fields in the list are added.
{: tip}

## June 2018
{: #cloudant-jun18}

### 29 June 2018
{: #Cloudant-jun2918}
{: release-note}

The following changes were made in build 7051:

Forward compatibility clause
:   Add forward compatibility clause for `_stats` disk format change.

Compatibility clause
:   Add compatibility clause for attachment receiver to facilitate Erlang upgrade.

Audit facility
:   Improvements to internal audit facility.

### 12 June 2018
{: #Cloudant-jun1218}
{: release-note}

The following changes were made in build 7014:

Query selector
:   Remove the requirement to cover `_id` or `_rev` in the query selector in order to use a JSON index that explicitly contains them.

## May 2018
{: #cloudant-may18}

### 29 May 2018
{: #Cloudant-may2918}
{: release-note}

The following changes were made in build 6979:

Audit facility
:   Improve internal audit facility.

### 14 May 2018
{: #Cloudant-may1418}
{: release-note}

The following changes were made in build 6919:

New! Action, `DELETE`
:   Introduce new action, `DELETE`, on the `/_iam_session` endpoint, which invalidates the IAM session cookie.

Improvements
:   Remove outdated dependencies.

## April 2018
{: #cloudant-apr18}

### 26 April 2018
{: #Cloudant-apr2618}
{: release-note}

The following changes were made in build 6909:

Improvements
:   Improve compatibility with IAM.

`http` multipart requests
:   Fix `badarg` error in the module that parses `http` multipart requests.

### 25 April 2018
{: #Cloudant-apr2518}
{: release-note}

The following changes were made in build 6900:

New! Support replication
:   Support replication with IAM.

Validation
:   Improve validation of password schemes.

State field
:   In `_scheduler/docs`, set the value of the state field to `crashing` when the last event in the history was a crash.

`_design/$DDOC/_rewrite` and `_design/$DDOC/_update`
:   Disallow `_design/$DDOC/_rewrite` and `_design/$DDOC/_update` endpoints with IAM.

### 17 April 2018
{: #Cloudant-apr1718}
{: release-note}

The following changes were made in build 6895:

Pluggable storage engine
:   Fix a regression that is introduced with pluggable storage engine.

### 6 April 2018
{: #Cloudant-apr0619}
{: release-note}

Replaced `queries` parameter
:   The `queries` parameter for performing multiple view queries in a single request is no longer accepted as a URL parameter for `GET /{db}/_design/{ddoc}/_view/{view}` or a request body parameter for `POST /{db}/_design/{ddoc}/_view/{view}`. The parameter was replaced with the endpoint `POST /{db}/_design/{ddoc}/_view/{view}/queries` and is supplied as a `queries` request body parameter. You can also make multiple queries with the following new endpoints:

   - `POST /{db}/_all_docs/queries`
   - `POST /{db}/_design_docs/queries`

Sending several queries to a view
:   Sending multiple queries to a view that uses a `POST` request to `/$DATABASE/_design/$DDOC/_view/$VIEWNAME` is deprecated with [multi-querying a MapReduce view](/apidocs/cloudant#postviewqueries){: external}. For more information, see the previous deprecation note about replacing the `queries` parameter.

### 4 April 2018
{: #Cloudant-apr0418}
{: release-note}

The following changes were made in build 6875:

New! Audit facility
:   Internal audit facility is added to the platform.

{{site.data.keyword.cloudant_short_notm}} Query error messages
:   Improve error messages for {{site.data.keyword.cloudant_short_notm}} Query.

## March 2018
{: #cloudant-mar18}

### 30 March 2018
{: #Cloudant-mar3018}
{: release-note}

The following changes were made in build 6870:

`kill` command
:   Fix how the `kill` command works when you terminate an operating system process.

`_changes` endpoint
:   Fix `_changes` endpoint shard substitution.

Compaction resumption
:   Fix compaction resumption for terminated compactions.

### 13 March 2018
{: #Cloudant-mar1318}
{: release-note}

The following changes were made in build 6761:

New! `_dbs_info` endpoint
:   Introduce new `_dbs_info` endpoint to get information from a list of databases. See
[Get a list of all databases in the instance](/apidocs/cloudant#getalldbs){: external}.

New! Pluggable storage engine
:   Add a pluggable storage engine.

Improvement
:   Update MochiWeb to version 2.17.

Attachments
:   Ensure deterministic revisions for attachments. See [COUCHDB-3255](https://issues.apache.org/jira/browse/COUCHDB-3255){: external}.

`chttpd` multipart
:   Prevent `chttpd` multipart zombie processes.

Unconditional retries
:   Avoid unconditional retries in replicator's HTTP client.

Session support
:   Prepare for session support in replicator.

## February 2018
{: #cloudant-feb18}

### 15 February 2018
{: #Cloudant-feb1518}
{: release-note}

The following changes were made in build 6656:

Query parameters
:   Update `_design_docs` to respect the query parameters that are used by `_all_docs`. See [Get design documents](/apidocs/cloudant#postalldocs){: external}.

`COPY` request
:   When you send a `COPY` request to `/$DATABASE/docid` endpoint, {{site.data.keyword.cloudant_short_notm}} now decodes the Destination header and creates a new ID without escaped values.

Replication document
:   Remove headers from replication document on read.

`update_seq` and `offset` parameters
:   If the `keys` parameter is specified and the `update_seq` parameter is set to true, the `update_seq` and `offset` parameters return `null` in the response.

Semantics
:   Change semantics of status codes for create database.

### 7 February 2018
{: #Cloudant-feb0718}
{: release-note}

{{site.data.keyword.dashdbshort_notm}} feature is deprecated
:   To find alternatives to {{site.data.keyword.cloudant_short_notm}}'s {{site.data.keyword.dashdblong}} feature, see the
[data-flow-examples repository](https://github.com/cloudant-labs/data-flow-examples){: external} for tutorials on
extracting {{site.data.keyword.cloudant_short_notm}} documents and writing the data to a
{{site.data.keyword.dashdbshort_notm}} table.

## January 2018
{: #cloudant-jan18}

### 10 January 2018
{: #Cloudant-jan1018}
{: release-note}

The following changes were made in build 6620:

{{site.data.keyword.cloudant_short_notm}} Query and empty `partial_filter_selector` field
:   {{site.data.keyword.cloudant_short_notm}} Query falls back to `selector` on an empty `partial_filter_selector` field.

## December 2017
{: #cloudant-dec17}

### 28 December 2017
{: #Cloudant-dec2817}
{: release-note}

The following changes were made in build 6600:

{{site.data.keyword.cloudant_short_notm}} Query and `$or` operations
:   {{site.data.keyword.cloudant_short_notm}} Query fields that are referenced within `$or` operations are considered when {{site.data.keyword.cloudant_short_notm}} Query determines the usable
indexes for a particular selector.

### 7 December 2017
{: #Cloudant-dec0717}
{: release-note}

The following changes were made in build 6588:

New!`create_target_params` parameter
:   A new parameter, `create_target_params`, was added for you to customize the target database
that is created on a new replication. You can now customize the cluster's default values for the number of shards and
replicas to create.

`/_scheduler`
:   A request to `/_scheduler` without specifying subsections `docs` or `jobs` now returns a `Not found` error.

`new_edits` value
:   A new error is returned when a `new_edits` value is invalid in the `/db/_bulk_docs` URL. The error is `400: Bad request`.

`eval()` and `Function()` constructors
:   For security reasons, by default, the use of `eval()` and `Function()` constructors is disabled in
JavaScript.

`Prefer: return=minimal` header
:   Added the header `Prefer: return=minimal` to return only essential headers. This header reduces the size of the request, which gives a performance improvement to nonbrowser clients.

Disabled JavaScript constructors
:   If a user calls the disabled JavaScript constructors, `eval()` or `Function()`, an error message similar to this one is returned, *Call to `eval()` was blocked by CSP.* You can fix the problem by replacing `eval()` calls with the calls from the [expr-eval library](https://github.com/silentmatt/expr-eval){: external}.

### 4 December 2017
{: #Cloudant-dec0417}
{: release-note}

Removed support for virtual hosts
:   {{site.data.keyword.cloudant_short_notm}} disabled the virtual host functionality on 4 December 2017. Support for insecure HTTP connections was replaced by HTTPS only. After you turn off HTTP support, the virtual hosts feature is no longer available since use of virtual hosts precludes secure HTTPS connections. Previous users of the virtual host feature need to make alternative arrangements to present a chosen hostname to your clients from your application and use HTTPS connections only.

## November 2017
{: #cloudant-nov17}

### 7 November 2017
{: #Cloudant-nov0717}
{: release-note}

Incompatibility between CouchDB version 1.6 and {{site.data.keyword.cloudant_short_notm}} version 2.0.0
:   An incompatibility exists between the most recent version of {{site.data.keyword.cloudant_short_notm}} and CouchDB 1.6-based codebase. In the older version of {{site.data.keyword.cloudant_short_notm}}, if you add a query parameter ("reduce=false") to the request body, the parameter in the request body is ignored. However, the parameter in the request URL is respected. In recent versions of {{site.data.keyword.cloudant_short_notm}}, the query parameter ("reduce=false") in the request body isn't ignored.

## October 2017
{: #cloudant-oct17}

### 17 October 2017
{: #Cloudant-oct1717}
{: release-note}

Query (`_find` endpoint) improved
:   {{site.data.keyword.cloudant_short_notm}} Query now uses a new method to select an index. Learn more about [{{site.data.keyword.cloudant_short_notm}} Query index selection](https://www.ibm.com/support/pages/improving-cloudant-query-index-selection){: external}.

Index validation
:   The logic for determining whether a specific index is valid for a query that changed, addressing a bug that might lead to incorrect results.

Text indexes
:   Queries that use text indexes no longer fail when `$exists`: `false` is used.

Partial indexes
:   Partial indexes are now supported for both JSON and text indexes. For more information, see [Creating a partial index](/apidocs/cloudant#postindex){: external} to learn about the `partial_filter_selector` parameter.

Execution statistics
:   Execution statistics about a query can now be generated. These statistics are enabled by using the `execution_stats=true` parameter. For more information, see [querying an index by using selector syntax](/apidocs/cloudant#postfind){: external} to learn more about `execution_stats=true` parameter.

Pagination
:   [Pagination](/docs/Cloudant?topic=Cloudant-pagination-and-bookmarks) is supported by using the bookmark field. Bookmarks are enabled for all index types.

`use_index` field invalid
:   `_find` now falls back to any valid index if the value specified in the `use_index` field is invalid for the current query. When `find` falls back, the `warning` field is populated in the query response.

### 9 October 2017
{: #Cloudant-oct0917}
{: release-note}

Error handling
:   If you rely on 500 replies for your application, you might have issues. To fix the problem, update your application to rely on 400 responses.
:   If you don't take care of reduce overflow errors as part of a row in the response body, issues occur. To fix this problem, change the application to handle the errors from view requests.

## August 2017
{: #cloudant-aug17}

### 17 August 2017
{: #Cloudant-aug1717}
{: release-note}

The following changes were made in build 6365:

New! X-Frame-Options
:   Add the `X-Frame-Options` header settings. The `X-Frame-Options` setting is a response header that controls whether an HTTP response can be embedded in a `<frame>`, `<iframe>`, or `<object>`. This security feature helps prevent click jacking.

   You can configure this option based on your CORS settings. If CORS is enabled, `X-Frame-Options` are automatically enabled and send the response header, `X-Frame-Options: DENY`, by default. If a request HOST header matches the URL listed in the origins section of CORS, an `X-Frame-Options: ALLOW-FROM URL` response header is returned.

   This change might impact customers who are accessing the database directly from the browser. If you see the error message, "X-Frame-Options: DENY", and it's breaking your service, you must enable CORS by [modifying the CORS configuration](/apidocs/cloudant#putcorsconfiguration){: external}. After you enable CORS, add the value of the HOST header that you send in the request to the list of allowed `origins`.

New! Replication scheduler
:   Add the replication scheduler. Learn more about [replication scheduler](/docs/Cloudant?topic=Cloudant-advanced-replication#the-replication-scheduler).

`_revs-diff` endpoint
:   `POST` requests to the `_revs_diff` endpoint require either the `_reader` or `_replicator` role.

## July 2017
{: #cloudant-jul17}

### 24 July 2017
{: #Cloudant-jul2417}
{: release-note}

Retire Shared plan
:   {{site.data.keyword.cloudant_short_notm}} Shared Plan accounts can no longer be created from the [{{site.data.keyword.cloudant_short_notm}} product page](https://www.ibm.com/cloud/cloudant){: external}.

### 4 July 2017
{: #Cloudant-jul0417}
{: release-note}

The following changes were made in build 6276:

Error message
:   An error message changed that occurs when you try to put a document attachment with a nonexistent revision. Now, the error is a 409 error with the following information:

    ```json
    {"error":"not_found","reason":"missing_rev"}
    ```
    {: codeblock}

## June 2017
{: #cloudant-jun17}

### 26 June 2017
{: #Cloudant-jun2617}
{: release-note}

The following changes were made in build 6233:

{{site.data.keyword.cloudant_short_notm}} Query and indexes
:   Fixes an {{site.data.keyword.cloudant_short_notm}} Query issue where indexes that excluded potentially matching documents were selected by the query planner.

### 14 June 2017
{: #Cloudant-jun1417}
{: release-note}

Revised error message
:   The error message that occurs when you try to put a document attachment with a nonexistent revision. This error is changed to a 409 error with the following information:

    ```sh
    {"error":"not_found","reason":"missing_rev"}
    ```
    {: codeblock}

## May 2017
{: #cloudant-may17}

### 11 May 2017
{: #Cloudant-may1117}
{: release-note}

The following changes were made in build 6069:

New! `$allmatch` operator support
:   Added support for the `$allmatch` operator.

Replication
:   Previously, a replication job that failed for some reason, which resulted in an update to the replication document, was followed by a fresh attempt to start a new replication. Under some circumstances, this behavior might continue indefinitely: many duplicates of the same error message. A fix was introduced so that the replication document is not updated unless the reason for the error changes.

## February 2017
{: #cloudant-feb17}

### 13 February 2017
{: #Cloudant-feb1317}
{: release-note}

The following changes were made in build 5834:

Document `id` length
:   The maximum length of a document `id` is now 7168 characters (7k).

## November 2016
{: #cloudant-nov16}

### 25 November 2016
{: #Cloudant-nov2516}
{: release-note}

The following changes were made in build 5728:

Malformed user documents
:   {{site.data.keyword.cloudant_short_notm}} is more tolerant of malformed user documents that are stored within the `_users` database.

Structure for user documents
:   User documents must be structured and populated to comply with [Apache CouchDB requirements](https://docs.couchdb.org/en/stable/intro/security.html?highlight=security#users-documents){: external}.

## October 2016
{: #cloudant-oct16}

### 11 October 2016
{: #Cloudant-oct1116}
{: release-note}

The following changes were made in build 5638:

New! Parameters
:   Introduces new `stable` and `update` query parameters for views.

Replicator retries
:   Replicator no longer retries forever if it cannot write checkpoints to the source database.

## June 2016
{: #cloudant-jun16}

### 14 June 2016
{: #Cloudant-jun1416}
{: release-note}

The following changes were made in build 5421:

View-based filters
:   Changes feeds support view-based filters.

`_docs_ids` filter
:   Changes feeds support the `_doc_ids` filter.

`POST` requests
:   `POST` requests are supported for `_changes`.

`attachments=true` parameter support
:   Both `_all_docs` and `_changes` support the `attachments=true` parameter.

CouchDB 1.6 `_users` database support
:   Support for the CouchDB 1.6 `_users` database features, including server-side hashing of passwords when documents are created in the `_users` database.

`/_bulk_get` endpoint
:   `/_bulk_get` endpoint to reduce the number of requests that are used in replication to mobile clients.

Design document metadata
:   Design document metadata contains an `update pending` field.

Eliminate error
:   {{site.data.keyword.cloudant_short_notm}} Query no longer returns an error if no valid index exists.

## February 2016
{: #cloudant-feb16}

### 4 February 2016
{: #Cloudant-feb0416}
{: release-note}

`dbcopy`
:   The `dbcopy` feature can cause problems under some circumstances. Information about the feature was removed from the documentation. Use of `dbcopy` is discouraged.

## November 2014
{: #cloudant-nov14}

### 6 November 2014
{: #Cloudant-nov0614}
{: release-note}

`generate_api_key` endpoint is deprecated
:   An earlier method of generating API keys by issuing the `POST` command to the `https://cloudant.com/api/generate_api_key` endpoint is deprecated.

## July 2014
{: #cloudant-jul14}

### 1 July 2014
{: #Cloudant-jul0114}
{: release-note}

New! Introducing {{site.data.keyword.cloudant_short_notm}} Classic
:   {{site.data.keyword.cloudantfull}} is a document-oriented database as a service (DBaaS). It stores data as documents in JSON format. It is built with scalability, high availability, and durability in mind.
