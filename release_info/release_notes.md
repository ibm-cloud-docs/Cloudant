---

copyright:
  years: 2015, 2021
lastupdated: "2021-08-11"

keywords: new features, partition query, dedicated hardware plan, replication scheduler, 8202, 8201, 8194, 8192, 8182, 8169, 8162, 8158, 8152, 8142, 8126, 8111, 8106, 8103, 8076, 8070, 8062, 8058, 8052, 8048, 8038, 7681, 7544, 7426, 7410, 7304, 7302, 7276, tls 1.3 supported, 8048, 8038, 7205, 7138, 7137, 7084, 7051, 7014, 6979, 6919, 6909, 6900, 6895, 6875, 6870, 6761, 6656, 6620, 6600, 6588, query, 6365, 6276, 6233, 6069, 5834, 5728, 5638, 5421, initial deployment announcement, feature comparison, 2.75, 2.69, 2.67, 2.77, 2.78. 2.79, 2.80, 2.88, 2.91, 2.92, 2.93, operator, classic, transaction engine, 1.4.2, 1.4.1, 1.4.0, 1.3.0, 1.2.1, 1.2.0, 1.1.0, couchdb

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

<!-- Acrolinx: 2021-04-09 -->

# Release notes
{: #release-notes}

Release notes provide information about changes to {{site.data.keyword.cloudant_short_notm}} Transaction Engine, Classic, and Operator for Apache CouchDB.
{: shortdesc}

## Transaction Engine
{: #transaction-engine-release-notes}

Changes and updates to {{site.data.keyword.cloudant_short_notm}} Transaction Engine that are grouped by build number.

### New features
{: #new-features-txe}

See [new features](https://www.ibm.com/cloud/blog/announcements/ibm-cloudant-on-transaction-engine) for {{site.data.keyword.cloudant_short_notm}} on Transaction Engine.

### Build 2.94 (July 2021)
{: #build-2.94-july-2021}

- Upgrade to Erlang/OTP 23.3.4.4

### Build 2.93 (July 2021)
{: #build-2.93-july-2021}

#### Bug fixes
{: #bug-fixes-2.93}

- Fix regression related to validation of deprecated parameters: `q` and `n`.
- Disable placement parameter.
- Update testing dependencies.

### Build 2.92 (May 2021)
{: #build-2.92-may-2021}

#### Bug fixes
{: #bug-fixes-2.92}

- Improve validation of design documents.
- Fix inline attachments to design documents.
- Improve error messages for the following endpoints:
  - `/{db}/_all_docs/queries`
  - `/{db}/_design/update/_update/`
  - `/_db_updates`

### Build 2.91 (April 2021)
{: #build-2.91-april-2021}

#### Bug fixes
{: #bug-fixes-2.91}

 - Fix bug that can corrupt view indices. If the view index returns inconsistent data even after database updates stop, re-create the index by deleting and re-adding the design documents with a slight modification to the view code. This step ensures that the index is rebuilt.
 - Improve indexing performance when concurrent database updates exist.
 - `multipart/related` document `PUT` requests can now accept chunked data transfer format.
 - The `_session` endpoint accepts compressed (`gzipped`) requests.
 - Replicator treats a client `408` error code as retryable.

### Build 2.88 (November 2020)
{: #build-2.88-november-2020}

#### Bug fixes
{: #bug-fixes-2.88}

- Add replicator support.
- Add built-in view reduce functionality.

### Build 2.80 (September 2020)
{: #build-2.80-september-2020}

#### Bug fixes
{: #bug-fixes-2.80}

- Internal bug fixes.

### Build 2.79 (September 2020)
{: #build-2.79-september-2020}

#### Bug fixes
{: #bug-fixes-2.79}

- Remove empty entries from `_active_tasks`.
- Fix the order of results for page_size-based pagination for views.
- Remove completed Couch jobs from `_active_tasks`.
- Improve performance of view builds when there are no emits from JavaScript function.

### Build 2.77 (August 2020)
{: #build-2.77-august-2020}

#### Bug fixes
{: #bug-fixes-2.77}

- Fixed dashboard access for {{site.data.keyword.cloudant_short_notm}} Transaction Engine instances.

### Build 2.75 (August 2020)
{: #build-2.75-august-2020}

#### Bug fixes
{: #bug-fixes-2.75}

- Disable non-IAM authentication and authorization methods.
  - Block write to `/_security` endpoint.
  - Block creation of `/_users` databases.
- Fix intermittent error when you re-create database instances.
- Add `local_seq` options to views.
- Add support for `_active_tasks`.

### Build 2.69 (June 2020)
{: #build-2.69-june-2020}

#### Bug fixes
{: #bug-fixes-2.69}

- Query parameters for `_all_docs` and view requests are not ignored anymore.
- Limit maximum number of documents in a `_bulk_get` request to 10,000.
- Reword view and query pagination limit error messages that are returned with the HTTP 400 responses.

### Build 2.67 (June 2020)
{: #build-2.67-june-2020}

#### Bug fixes
{: #bug-fixes-2.67}

- [Initial deployment announcement](https://www.ibm.com/cloud/blog/announcements/ibm-cloudant-on-transaction-engine){: new_window}{: external}.
- [Feature comparison](/docs/Cloudant?topic=Cloudant-feature-comparison) between {{site.data.keyword.cloudant_short_notm}} on Transaction Engine and {{site.data.keyword.cloudant_short_notm}} Classic.


## Classic
{: #classic-release-notes}

Changes and updates to {{site.data.keyword.cloudant_short_notm}} Classic that are grouped by new features and build number.

### Highlighted features
{: #highlighted-features-rn}

#### Partition Query (February 2019)
{: #partition-query-february-2019}

The new Partition Query feature provides a new way to structure
data in {{site.data.keyword.cloudant_short_notm}}, which offers both cost savings and performance gains for your
applications.

For more information, see the following link:

- Read the [guide to partition query](/docs/Cloudant?topic=Cloudant-database-partitioning).

#### Dedicated Hardware (June 2017)
{: #dedicated-hardware}

A new Dedicated Hardware plan is available.

For more information, see the following links:

- Read about the [Dedicated Hardware plan](/docs/Cloudant?topic=Cloudant-ibm-cloud-public#dedicated-hardware-plan){: new_window}{: external}.

#### Replication scheduler
{: #replication-scheduler}

The new replication scheduler has several improvements and enhancements. Learn more about the replication scheduler.

### Build 8202 (August 2021)
{: #build-8202-08-2021}

#### New features
{: #new-features-820s2}

- Support IAM Trusted Profiles.

### Build 8201 (August 2021)
{: #build-8201-08-2021}

#### Bug fixes
{: #bug-fixes-8201}

- Internal bug fixes.

### Build 8194 (June 2021)
{: #build-8194-06-2021}

#### Bug fixes
{: #bug-fixes-8194}

- Bug fixes, including account API key task filtering.
- Support replication [basic auth credentials in auth object](https://github.com/apache/couchdb/pull/3586).
- No longer display basic auth credentials (for example, `username:*****`) in the output of these endpoints:
  - `_scheduler/jobs`
  - `_scheduler/docs`
  - `_active_tasks`

### Build 8192 (April 2021)
{: #build-8192-04-2021}

#### New features
{: #new-features-8192}

- Added Fair share replicator. For more information, see [Fair Share Replication Scheduler Implementation](https://github.com/apache/couchdb/commit/ab38c2dd3f429ce8f347fa4f04e2815b810a8a19){: new_window}{: external}.

#### Bug fixes
{: #bug-fixes-8192}

- Internal bug fixes.

### Build 8182 (March 2021)
{: #build-8182-03-2021}

#### Bug fixes
{: #bug-fixes-8182}

- Internal bug fixes.
- Apply caching to account-local `_users` dbs.
- Treat 408 as a retryable error condition for replicator.
- Allow compressed (`gzipped`) requests to `/_session` endpoint.
- Show process status in `/_active_tasks` endpoint.
- Validate JSON payload on `POST` to `/{DB}/_changes` endpoint.

### Build 8169 (December 2020)
{: #build-8169-12-2020}

#### New features
{: #new-features-8169}

- Introduce the Mango query operator, `$keyMapMatch`, that offers the ability to make queries on the keys of a map.

#### Bug fixes
{: #bug-fixes-8169}

- Internal bug fixes.
- Report the database that was used for authentication for a `GET /_session` request, provided it is configured.

### Build 8162 (September 2020)
{: #build-8162-09-2020}

#### Bug fixes
{: #bug-fixes-8162}

- Internal bug fixes.
- `Drilldown` parameters for text index searches can now be specified as a list of lists, which gives you the ability to avoid having to define it redundantly in a single query. (Some languages don't have this facility.)
- The `couch_index` server doesn't crash and log errors in the following cases: If a design document is deleted while that index is building, or when a design document is added immediately after database creation.
- {{site.data.keyword.cloudant_short_notm}} now checks for and reports invalid parameters on database creation.

### Build 8158 (July 2020)
{: #build-8158-07-2020}

#### Bug fixes
{: #bug-fixes-8158}

- Internal bug fixes.

### Build 8153 (May 2020)
{: #build-8153-05-2020}

#### Bug fixes
{: #bug-fixes-8153}

- Internal bug fixes.

### Build 8152 (April 2020)
{: #build-8152-04-2020}

#### Bug fixes
{: #bug-fixes-8152}

- Internal bug fixes.

### Build 8142 (March 2020)
{: #build-8142-03-2020}

#### New features
{: #new-features-8142}

- New endpoints were added, so you can post multiple queries: `POST /{db}/_all_docs/queries` and `POST /{db}/_design_docs/queries`.
- The ability to submit multiple queries against a view by using the `POST` to `/{db}/_design/{ddoc}/_view/{view}` with the `?queries` option was replaced by the new `queries` endpoint. The same is true of the `_all_docs` and `_design_docs`endpoints. Specify a `keys` object when you `POST` to these endpoints. 

#### Bug fixes
{: #bug-fixes-8142}

- The `disk_size` and `data_size` fields were retired from the database information object that is returned by `GET /{db}`. 
- The `/{db}/_changes` feed immediately returns headers now, even when no changes are available. This process prevents client blocking.
- Negative and non-integer heartbeat values now return a `400 Bad Request` response status code.
- Allow specifying separate proxies for both the source and target in a replication by using `source_proxy` and `target_proxy` keys.  
- The `POST` view functionality now supports identical parameters and behavior as specified in the `/{db}/_design/{ddoc}/_view/{view}`, `/{db}/_all_docs`, and `/{db}/_design_docs` endpoints. You can supply query string parameters as keys in a JSON object in the body of the `POST` request.
- Replication `"info"` errors are now JSON objects. Previously, they were strings. 
- A compatibility change was made to support replication with future databases that contain per-document access control fields.
- Add a warning to the `_find` endpoint if multiple document scans were required to generate a result.
- Fix a bug in the `_find` endpoint whereby an error would be returned if a document matched by a text index was deleted while the query was being processed.  

### Build 8126 (January 2020)
{: #build-8126-January-2020}

#### Bug fixes
{: #bug-fixes-8126}

- Internal bug fixes.
- Improvements to replication error reporting - instead of a function_clause, human-readable markers are returned, for example, `bulk_docs_failed`. Stack traces are no longer included.
- Replication job statistics, such as `docs_read`, `docs_written`, and `doc_write_failures` are preserved when replication jobs restart.
- Replication jobs to a target endpoint by using IAM Writer permissions no longer crash and continuously restart when they write design documents. Instead, the `doc_write_failures` statistic is incremented for each failed design document write. This behavior is consistent with replicating by using the legacy API-key-based authentication.

### Build 8111 (November 2019)
{: #build-8111-november-2019}

#### Bug fixes
{: #bug-fixes-8111}

- Internal bug fixes. 
- The `_scheduler/docs` endpoint now includes more detailed replication statistics to match `_active_tasks` output. It also includes details on replications that started with `_replicate`.
- Fix an instance where the replicator failed a replication but the error was recoverable.
- Fix a bug introduced in recent builds where sending an empty payload to `_bulk_docs` would result in a 400 response status code rather than accepting the no-op operation.

### Build 8106 (October 2019)
{: #build-8106-october-2019}

#### Bug fixes
{: #bug-fixes-8106}

- Internal bug fixes.

### Build 8103 (October 2019)
{: #build-8103-october-2019}

#### Bug fixes
{: #bug-fixes-8103}

- New `X-Cloudant-Action` HTTP response header that returns the {{site.data.keyword.cloud}}    IAM actions that are associated with a request.
- Previously, search requests would return a `400` status code both on a bad
    request and on internal server errors. Now, internal server errors correctly
    return a `500` response status code.

### Build 8076 (June 2019)
{: #build-8076-june-2019}

#### Bug fixes
{: #bug-fixes-8076}

- Internal bug fixes.
- Stability improvements.

### Build 8070 (May 2019)
{: #build-8070-may-2019}

#### Bug fixes
{: #bug-fixes-8070}

- Internal bug fixes.

### Build 8062 (May 2019)
{: #build-8062-may-2019}

#### Bug fixes
{: #bug-fixes-8062}

- Internal bug fixes.

### Build 8058 (April 2019)
{: #build-8058-april-2019}

#### Bug fixes
{: #bug-fixes-8058}

- Fixed bug in `ibrowse` HTTP client that leaves dead process IDs in the connection pool, and in some cases, caused persistent IAM-based replication failures.

### Build 8052 (April 2019)
{: #build-8052-april-2019}

#### Bug fixes
{: #bug-fixes-8052}

- Accessing the database information endpoint (`/db/`) for a partitioned database
    now includes information about the contained partitioned indexes. The new field, `partitioned_indexes`, contains the following
    information:

    - The current number of partitioned indexes in the database (`count`).
    - A breakdown of those indexes by type (`indexes`).
    - The maximum partitioned indexes allowed for this database (`limit`).

### Build 8048 (March 2019)
{: #build-8048-march-2019}

#### Bug fixes
{: #bug-fixes-8048}

- No user visible changes; bug fixes.

### Build 8038 (March 2019)
{: #build-8038-march-2019}

#### Bug fixes
{: #bug-fixes-8038}

- Allow `POST` when you search [partition queries](/docs/Cloudant?topic=Cloudant-database-partitioning#database-partitioning).

### Build 7681 (February 2019)
{: #build-7681-february-2019}

#### Bug fixes
{: #bug-fixes-7681}

- Partition query bug fixes.

### Build 7668 (January 2019)
{: #build-7668-january-2019}

#### New features
{: #new-features-7668}

- This build introduces a new feature, [Partition Query](/docs/Cloudant?topic=Cloudant-database-partitioning#database-partitioning).

#### Bug fixes
{: #bug-fixes-7668}

- Allow `limit` when you use `POST` for search.
- Previously, view requests that use a `limit` parameter greater than 268435456 would have the limit that is silently reduced to 268435456. Now, requests with the `limit` parameter greater than 268435456 are rejected with a `400 Bad Request` error.

### Build 7631 (January 2019)
{: #build-7631-january 2019}

#### Bug fixes
{: #bug-fixes-7631}

-   Internal changes and bug fixes.

### Build 7544 (December 2018)
{: #build-7544-december-2018}

#### Bug fixes
{: #bug-fixes-7544}

- Fixed a problem where the replicator would sometimes reset statistics during
    replications. The reset would affect values in the [replication status
    information](/docs/Cloudant?topic=Cloudant-advanced-replication#advanced-replication).
     See [PR](https://github.com/apache/couchdb/pull/1722){: new_window}{: external}.
- Fixed an issue with {{site.data.keyword.cloudant_short_notm}} Query. After you delete a document, if you issue
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

### Build 7426 (15 November 2018)
{: #build-7426-november-15-2018}

#### Bug fixes
{: #bug-fixes-7426}

- Include [CRN](/docs/account?topic=account-crn) in audit logs.
- Replicator stability improvements.
- Improve validation of `q` parameter on database creation. See [COUCHDB-1582](https://issues.apache.org/jira/browse/COUCHDB-1582){: new_window}{: external}.
- Fix error in `_bulk_get` endpoint for the `_users` database. See [COUCHDB-1650](https://issues.apache.org/jira/browse/COUCHDB-1650){: new_window}{: external}.
- Fix JavaScript URL rewrites hanging on `POST` or `PUT` requests. See [COUCHDB-1612](https://issues.apache.org/jira/browse/COUCHDB-1612){: new_window}{: external}.
- Fix invalid `reduce` functions in {{site.data.keyword.cloudant_short_notm}} Query indexes that prevent indexing. See [COUCHDB-1666](https://issues.apache.org/jira/browse/COUCHDB-1666){: new_window}{: external}.
- Internal bug fixes to data compression, search, and core database components.

### Build 7410 (4 November 18)
{: #build-7410-november-04-2018}

#### Bug fixes
{: #bug-fixes-7410}

- Internal changes and bug fixes.

### Build 7304 (11 October 2018)
{: #build-7304-october-11-2018}

#### Bug fixes
{: #bug-fixes-7304}

- This build is identical to build 7302 except that it's built on Erlang 17.5 instead of Erlang 20.

### Build 7302 (25 September 2018)
{: #build-7302-september-25-2018}

#### Bug fixes
{: #bug-fixes-7302}

- Improve Mango Query so that mixed clusters return correct results during upgrades.
- Add a downgrade function to support future cluster purge releases.
- Improve search blocklist.

### Build 7276 (18 September 2018)
{: #build-7276-september-18-2018}

#### Bug fixes
{: #bug-fixes-7276}

- Add a filter for databases that are being opened asynchronously to prevent exceptions when `couch_server` terminates.
- Fix `couch_server` concurrency error.
- Add a configuration option to disable off-heap messages.

### TLS 1.3 Supported (13 September 2018)
{: #tls-1-3-supported-september-13-2018}

From today, {{site.data.keyword.cloudant_short_notm}} supports TLS 1.3 connections to {{site.data.keyword.cloudant_short_notm}}.

{{site.data.keyword.cloudant_short_notm}} recommends that you use TLS 1.2 or 1.3 for all access to {{site.data.keyword.cloudant_short_notm}}.
***(In June 2019, {{site.data.keyword.cloudant_short_notm}} is retiring the use of older
versions (TLS 1.0 and 1.1) at which point only TLS 1.2+ is supported.)***

Find more information on the [Security page](/docs/Cloudant?topic=Cloudant-security#security).

### Build 7205 (07 September 2018)
{: #build-7205-september-07-2018}

#### Bug fixes
{: #bug-fixes-7205}

- Refactor Mango Query selectors to reduce the amount of traffic sent between nodes in the cluster.
- Expose document update errors on concurrent document updates to client.
- Fix `render_error` errors where the `req` object that is passed to the JavaScript list function is set to `noproc` atom.

### Build 7138 (17 August 2018)
{: #build-7138-august-17-2018}

#### Bug fixes
{: #bug-fixes-7138}

- Upgrade to Erlang OTP 20.

### Build 7137 (15 August 2018)
{: #build-7137-august-15-2018}

#### Bug fixes
{: #bug-fixes-7137}

- Improve validation of configuration parameters supplied by administrator.
- While compaction is running, delete compaction files when database is deleted.
- Improve sandboxing features.
- Optimize authentication check.
- Change semantics of status codes for delete database.
- Support `conflicts: true` for queries to the `/{db}/_find` endpoint.
- Preserve `update_seq` field across view compaction.


### Build 7084 (12 July 2018)
{: #build-7084-july-12-2018}

#### Bug fixes
{: #bug-fixes-7084}

- Refactor code for `_stats` reducer.
- Fix active size calculations for views.
- Rewrite the `couch_key_tree` algorithm to reduce its computational complexity and avoid calling stemming when unnecessary.
- Change the allocation strategy for the message queue for each important process, so it's not stored on the heap of that process.
- Improvements to internal audit facility.
- Any constant fields that are in the selector, and are part of the index, for example, `{A: {$eq: 10}}`, are inserted into the sort list if they aren't already included. This method increases the chance that the best index is selected for the query, for example, index = `[A, B]`, sort = `[B]`, and selector = `{A: 1}`. The sort then becomes `[A, B]`.

Only the fields that are in front of the current sort fields in the list are added.
{: tip}


### Build 7051 (29 June 2018)
{: #build-7051-june-29-2018}

#### Bug fixes
{: #bug-fixes-7051}

- Add forward compatibility clause for `_stats` disk format change.
- Add compatibility clause for attachment receiver to facilitate Erlang upgrade.
- Improvements to internal audit facility.
- Reduce the possibility that a race condition occurs between the time you delete a database that triggers a geo index to close and when a compaction destroys a geo index. 

### Build 7014 (12 June 2018)
{: #build-7014-june-12-2018}

#### Bug fixes
{: #bug-fixes-7014}

- Remove the requirement to cover `_id` or `_rev` in the query selector in order to use a JSON index that explicitly contains them.

### Build 6979 (29 May 2018)
{: #build-6979-may-29-2018}

#### Bug fixes
{: #bug-fixes-6979}

- Improvements to internal audit facility.

### Build 6919 (14 May 2018)
{: #build-6919-may-14-2018}

#### New features
{: #new-features-6919}

- Introduce new action, `DELETE`, on the `/_iam_session` endpoint, which invalidates the IAM session cookie.

#### Bug fixes
{: #bug-fixes-6919}

- Remove outdated dependencies.


### Build 6909 (26 April 2018)
{: #build-6909-april-26-2018}

#### Bug fixes
{: #bug-fixes-6909}

- Improve compatibility with IAM.
- Fix `badarg` error in the module that parses `http` multipart requests.

### Build 6900 (25 April 2018)
{: #build-6900-april-25-2018}

#### New features
{: #new-features-6900}

- Support replication with IAM.

#### Bug fixes
{: #bug-fixes-6900}

- Improve validation of password schemes.
- In `_scheduler/docs`, set the value of the state field to `crashing` when the last event in the history was a crash.
- Disallow `_design/$DDOC/_rewrite` and `_design/$DDOC/_update` endpoints with IAM.

### Build 6895 (17 April 2018)
{: #build-6895-april-17-2018}

#### Bug fixes
{: #bug-fixes-6895}

- Fix a regression that is introduced with pluggable storage engine.

### Build 6875 (4 April 2018)
{: #build-6875-april-4-2018}

#### New features
{: #new-features-6875}

- New internal audit facility is added to the platform.

#### Bug fixes
{: #bug-fixes-6875}

- Improve error messages for {{site.data.keyword.cloudant_short_notm}} Query.


### Build 6870 (30 March 2018)
{: #build-6870-march-30-2018}

#### Bug fixes
{: #bug-fixes-6870}

- Fix how the `kill` command works when you terminate an operating system process.
- Fix `_changes` endpoint shard substitution.
- Fix compaction resumption for terminated compactions.

### Build 6761 (13 March 2018)
{: #build-6761-march-13-2018}

#### New features
{: #new-features-6761}

- Introduce new `_dbs_info` endpoint to get information from a list of databases. See
[Get a list of all databases in the instance](/apidocs/cloudant#getalldbs){: new_window}{: external}.
- Add a pluggable storage engine.

#### Bug fixes
{: #bug-fixes-6761}

- Ensure deterministic revisions for attachments. See [COUCHDB-3255](https://issues.apache.org/jira/browse/COUCHDB-3255){: new_window}{: external}.
- Prevent `chttpd` multipart zombie processes.
- Avoid unconditional retries in replicator's HTTP client.
- Update MochiWeb to version 2.17.
- Prepare for session support in replicator.

### Build 6656 (15 February 2018)
{: #build-6656-february-15-2018}

#### Bug fixes
{: #bug-fixes-6656}

- Update `_design_docs` to respect the query parameters that are used by `_all_docs`. See [Get design documents](/apidocs/cloudant#postalldocs){: new_window}{: external}.
- When you send a `COPY` request to `/$DATABASE/docid` endpoint, {{site.data.keyword.cloudant_short_notm}} now decodes the Destination header and creates a new ID without escaped values.
- Remove headers from replication document on read.
- If the `keys` parameter is specified and the `update_seq` parameter is set to true, the `update_seq` and `offset` parameters return `null` in the response.
- Change semantics of status codes for create database.

### Build 6620 (10 January 2018)
{: #build-6620-january-10-2018}

#### Bug fixes
{: #bug-fixes-6620}

- Query falls back to `selector` on an empty `partial_filter_selector` field.

### Build 6600 (28 December 2017)
{: #build-6600-december-28-2017}

#### Bug fixes
{: #bug-fixes-6600}

- Query fields that are referenced within `$or` operations are considered when {{site.data.keyword.cloudant_short_notm}} query determines the usable
indexes for a particular selector.

### Build 6588 (7 December 2017)
{: #build-6588-december-7-2017}

#### New features
{: #new-features-6588}

- A new parameter, `create_target_params`, was added for you to customize the target database
that is created on a new replication. You can now customize the cluster's default values for the number of shards and
replicas to create.

#### Bug fixes
{: #bug-fixes-6588}

- A request to `/_scheduler` without specifying subsections `docs` or `jobs` now returns a `Not found` error.
- A new error is returned when a `new_edits` value is invalid in the `/db/_bulk_docs` URL. The error is `400: Bad request`.
- For security reasons, by default, the use of `eval()` and `Function()` constructors is disabled in
JavaScript.
- Added the header `Prefer: return=minimal` to return only essential headers. This header reduces the size of the request, which gives a performance improvement to non-browser clients.

### Query (`_find` endpoint)
{: #query-code-_find-code-endpoint}

#### New features
{: #new-features-query-endpoint}

- {{site.data.keyword.cloudant_short_notm}} Query now uses a new method to select an index. Learn more about [{{site.data.keyword.cloudant_short_notm}} Query index selection](http://www-01.ibm.com/support/docview.wss?uid=swg22011923){: new_window}{: external}.
- The logic for determining whether a specific index is valid for a query that changed, addressing a bug that might lead to incorrect results.
- Queries that use text indexes no longer fail when `$exists`: `false` is used.
- Partial indexes are now supported for both JSON and text indexes. For more information, see [Creating a partial index](/apidocs/cloudant#postindex){: new_window}{: external} to learn about the `partial_filter_selector` parameter.
- Execution statistics about a query can now be generated. These statistics are enabled by using the `execution_stats=true` parameter. For more information, see [querying an index by using selector syntax](/apidocs/cloudant#postfind){: new_window}{: external} to learn more about `execution_stats=true` parameter.
- [Pagination](/docs/Cloudant?topic=Cloudant-pagination-and-bookmarks) is supported by using the bookmark field. Bookmarks are enabled for all index types.
- `_find` now falls back to any valid index if the value specified in the `use_index`
field is invalid for the current query. When `find` falls back, the `warning` field is populated in the query response.

### Build 6365 (17 August 2017)
{: #build-6365-august-17-2017}

#### New features
{: #new-features-6365}

- Add the `X-Frame-Options` header settings to prevent click jacking. Learn more about [X-Frame-Options setting](/docs/Cloudant?topic=Cloudant-deprecations#x-frame-options-setting).
- Add the replication scheduler. Learn more about [replication scheduler](/docs/Cloudant?topic=Cloudant-advanced-replication#the-replication-scheduler).

#### Bug fixes
{: #bug-fixes-6365}

- `POST` requests to the `_revs_diff` endpoint require either the `_reader` or `_replicator` role.


### Build 6276 (4 July 2017)
{: #build-6276-july-4-2017}

#### Bug fixes
{: #bug-fixes-6276}

- An error message changed that occurs when you try to put a document attachment with a non-existent revision.
Now, the error is a 409 error with the following information: 
	
```json
{"error":"not_found","reason":"missing_rev"}
```
{: codeblock}

### Build 6233 (26 June 2017)
{: #build-6233-june-26-2017}

#### Bug fixes
{: #bug-fixes-6233}

- Fixes an {{site.data.keyword.cloudant_short_notm}} Query issue where indexes that excluded potentially matching documents were selected by the query planner.

### Build 6069 (11 May 2017)
{: #build-6069-may-11-2017}

#### New features
{: #new-features-6069}

- Added support for the `$allmatch` operator.

#### Bug fixes
{: #bug-fixes-6069}

- Previously, a replication job that failed for some reason, which resulted in an update to the replication document,
  was followed by a fresh attempt to start a new replication.
  Under some circumstances,
  this behavior might continue indefinitely: many duplicates of the same error message.
  A fix was introduced so that the replication document is not updated unless the reason for the error changes.
- If the design document that is intended to specify a geospatial index is invalid,
  an attempt to retrieve information about the index by using
  the [`_geo_info` endpoint](/docs/Cloudant?topic=Cloudant-cloudant-nosql-db-geospatial#cloudant-nosql-db-geospatial)
  results in an [HTTP `404`](/apidocs/cloudant#list-of-http-codes){: new_window}{: external} response.

### Build 5834 (13 February 2017)
{: #build-5834-february-13-2017}

#### Bug fixes
{: #bug-fixes-5834}

- The maximum length of a document `id` is now 7168 characters (7k).

### Build 5728 (25 November 2016)
{: #build-5278-november-25-2016}

#### Bug fixes
{: #bug-fixes-5728}

- {{site.data.keyword.cloudant_short_notm}} is more tolerant of malformed user documents that are stored within the `_users` database.
  User documents must be structured and populated to comply with
  [Apache Software Foundation CouchDB requirements](https://docs.couchdb.org/en/stable/intro/security.html?highlight=security#users-documents){: new_window}{: external}.

### Build 5638 (11 October 2016)
{: #build-5638-october-11-2016}

#### New features
{: #new-features-}

-   Introduces new `stable` and `update` query parameters for views.

#### Bug fixes
{: #bug-fixes-5638}

-   Replicator no longer retries forever if it cannot write checkpoints to the source database.

### Build 5421 (14 June 2016)
{: #build-5421-june-14-2016}

#### Bug fixes
{: #bug-fixes-5421}

-	Changes feeds support view-based filters.
-	Changes feeds support the `_doc_ids` filter.
-	`POST` requests are supported for `_changes`.
-	Both `_all_docs` and `_changes` support the `attachments=true` parameter.
-	Support for the CouchDB 1.6 `_users` database features, including server-side hashing of passwords when documents are created in the `_users` database.
-	`/_bulk_get` endpoint to reduce the number of requests that are used in replication to mobile clients.
-	Design document metadata contains an `update pending` field.
-	{{site.data.keyword.cloudant_short_notm}} Query no longer returns an error if no valid index exists.

## Operator for Apache CouchDB
{: #operator-apache-couchdb-rn}

Changes and updates to {{site.data.keyword.cloudant_short_notm}} Operator for Apache CouchDB that are grouped by build number.

### v1.4.2 (30 November 2020)
{: #v1.4.2}

#### Bug fixes
{: #bug-fixes-142}

 - Fixes memory leak in the `mgmt` container.

### v1.4.1 (9 November 2020)
{: #v1.4.1}

#### Bug fixes
{: #bug-fixes-141}

 - Fixes permissions issue with `pre_stop` scripts.
 
### v1.4.0 (30 October 2020)
{: #v1.4.0}

This bug fix release addresses an issue that occurs during upgrades to operator versions *1.2* and *1.3*, whereby pods can get into an unrecoverable state. An upgrade to version *1.4* forces the images to upgrade to the supported version, which resolves this problem.

#### Bug fixes
{: #bug-fixes-140}

 - Fixes syntax error in `pre_stop` script.
 - Fixes resource leak in health check.
 - Fixes symlink creation error when init container is restarted.

### v1.3.0 (23 October 2020)
{: #v1.3.0}

#### New features
{: #new-features-v1.3.0}

 - Updates CouchDB to [3.1.1](https://docs.couchdb.org/en/latest/whatsnew/3.1.html#version-3-1-1).
 - Improves logging output for `runit`.

#### Bug fixes
{: #bug-fixes-130}

 - CouchDB no longer stops when the search container restarts.
 - Fixes missing `findmnt` error in the `mgmt` container.

### v1.2.1 (15 September 2020)
{: #v1.2.1}

#### Bug fixes
{: #bug-fixes-121}

 - Configuration files are incorrectly created with read-only file permissions.

### v1.2.0 (14 September 2020)
{: #v1.2.0}

#### New features
{: #new-features-v1.2.0}

Adds a number of configuration options to the search container, enabled by using v1.5.0 of the management container.

The following new, optional fields are added to the CouchDBCluster CRD:

 - `spec.environment.clouseau.logLevel`
 - `spec.environment.clouseau.maxIndexesOpen`
 - `spec.environment.clouseau.closeIfIdle`
 - `spec.environment.clouseau.idleCheckIntervalSecs`

#### Bug fixes
{: #bug-fixes-120}

This bug fix release also fixes a performance regression in the search container that is caused by debug-level logs being enabled by default.

- CouchDB Search must not log at `DEBUG` level by default.

### v1.1.0 (17 August 2020)
{: #v1.1.0}

#### New features
{: #new-features-v1.1.0}

Adds more configuration for resource management, including the ability to set resource constraints on the CouchDB containers.

The following new, optional fields are added to the CouchDBCluster CRD:

 - `spec.securityContext`
 - `spec.resources`

#### Enhancements
{: #enhancements-v1.1.0}

 - Erlang scheduler count is based on the database container CPU requests, rounded up to the nearest integer.
 - Adds a liveness check so that search containers restart if they lose connectivity to the CouchDB node. This situation can happen if the CouchDB container is restarted by the OOMkiller.
 - JVM now uses cgroup aware memory settings.
 - Support CouchDBClusters deployed to the same namespace.
 - Changes to the CouchDBCluster CRD now propagate to CouchDB nodes without a manual pod restart.
 - Adds option to set resource constraints for CouchDB containers.
 - Adds option to set securityContext for the CouchDBCluster pods.

#### Bug fixes
{: #bug-fixes-110}

 - Resource limits and requests propagate correctly to the search container.


