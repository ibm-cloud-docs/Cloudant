---

copyright:
  years: 2015, 2022
lastupdated: "2022-08-25"

keywords: Cloudant, release notes, partition query, dedicated hardware plan, operator, classic, transaction engine, couchdb

subcollection: Cloudant

content-type: release-note

---

{{site.data.keyword.attribute-definition-list}}

# Release notes for {{site.data.keyword.cloudant_short_notm}} for Transaction Engine
{: #release-notes-txe}

The {{site.data.keyword.cloudant_short_notm}} on Transaction Engine service ends on 1 February 2023. You can no longer create new instances of {{site.data.keyword.cloudant_short_notm}} on Transaction Engine. On 1 February 2023, all instances of {{site.data.keyword.cloudant_short_notm}} on Transaction Engine will be permanently disabled and deprovisioned. Users of existing instances need to migrate from the service before the end of the service date. You can find guidance on migrating from {{site.data.keyword.cloudant_short_notm}} on Transaction Engine to {{site.data.keyword.cloudant_short_notm}} Standard here: [Migrating from TXE](https://blog.cloudant.com/2022/01/14/Migrating-from-Cloudant-TXE-to-Standard).
{: important}

Use these release notes to learn about the latest updates to {{site.data.keyword.cloudant_short_notm}} that are grouped by date and build number.

## October 2021
{: #cloudant-txe-oct21}

### 15 October 2021
{: #cloudant-txe-oct1521}

The following changes were made in build 2.96:

IAM Trusted Profiles
:   Support IAM Trusted Profiles.

Replicator "auth" object
:   Support basic auth credentials in replicator "auth" object.

Filtering changes feed
:   Use couch_eval for changes feed filtering.

Validate doc update
:   Use couch_eval to validate doc update.

Response code
:   Fix response code for deleting attachment with a bad revision.

Response code
:   Fix response code for getting nonexistent attachment.

Revision
:   Use correct winning revision when `latest=true`.

Case sensitivity
: Remove case sensitivity for basic auth.

`aegis_server`
:   Improve stability of `aegis_server` under load.

Document creation
:   Improve reliability of document creation.

Replicator authentication
:   Fix bug in Replicator authentication for passwords that contain `@`.

## July 2021
{: #cloudant-txe-jul21}

### 15 July 2021
{: #cloudant-txe-jul1521}
{: release-note}

The following changes were made in build 2.94:

Upgrade version
:   Upgrade your environment to Erlang/OTP 23.3.4.4.

### 1 July 2021 
{: #cloudant-txe-jul0121}
{: release-note}

The following changes were made in build 2.93:

Validate deprecated parameters
:   Fix regression that is related to validation of deprecated parameters: `q` and `n`.

Placement parameter
:   Disable placement parameter.

Testing dependencies
:   Update testing dependencies.

## May 2021
{: #cloudant-txe-may21}

### 15 May 2021 
{: #cloudant-txe-may1521}
{: release-note}

The following changes were made in build 2.92;

Design document validation
:   Improve validation of design documents.

Inline attachments
:   Fix inline attachments to design documents.

Error messages
:   Improve error messages for the following endpoints:

- `/{db}/_all_docs/queries`    
- `/{db}/_design/update/_update/`    
- `/_db_updates`    

## April 2021
{: #cloudant-txe-april21}

### 15 April 2021
{: #cloudant-txe-apr1521}
{: release-note}

The following changes were made in build 2.91:

Improvements
:   Fix bug that can corrupt view indices. If the view index returns inconsistent data even after database updates stop, recreate the index by deleting and readding the design documents with a slight modification to the view code. This step ensures that the index is rebuilt.

Indexing performance
:   Improve indexing performance when concurrent database updates exist.

`multipart/related` document 
:   `multipart/related` document `PUT` requests can now accept chunked data transfer format.

`_session` endpoint
:   The `_session` endpoint accepts compressed (`gzipped`) requests.

Replicator error
:   Replicator treats a client `408` error code as retryable.

## November 2020
{: #cloudant-txe-nov20}

### 15 November 2020
{: #cloudant-txe-nov1520}
{: release-note}

The following changes were made in build 2.88:

Replicator support
:   Add replicator support.

Built-in view
:   Add built-in view reduce functionality.

## September 2020
{: #cloudant-txe-sept20}

### 15 September 2020
{: #cloudant-txe-sep1520}
{: release-note}

The following changes were made in build 2.80:

Improvements
:   Internal bug fixes.

### 1 September 2020
{: #cloudant-txe-sep0120}
{: release-note}

The following changes were made in build 2.79:

Empty entries
:   Remove empty entries from `_active_tasks`.

Order of results
:   Fix the order of results for page_size-based pagination for views.

`_active_tasks`
:   Remove completed Couch jobs from `_active_tasks`.

Performance improvement
:   Improve performance of view builds when there are no emits from JavaScript function.

## August 2020
{: #cloudant-txe-aug20}

### 15 August 2020
{: #cloudant-txe-aug1520}
{: release-note}

The following changes were made in build 2.77:

Dashboard access
:   Fixed dashboard access for {{site.data.keyword.cloudant_short_notm}} Transaction Engine instances.

### 1 August 2020
{: #cloudant-txe-aug0120}
{: release-note}

The following changes were made in build 2.75:

Authentication and authorization methods
:   Disable non-IAM authentication and authorization methods.    

- Block write to `/_security` endpoint.    
- Block creation of `/_users` databases.    

Re-create database instance
:   Fix intermittent error when you re-create database instances.

`local_seq` options
:   Add `local_seq` options to views.

`_active_tasks`
:   Add support for `_active_tasks`.

## June 2020
{: #cloudant-txe-jun20}

### 15 June 2020
{: #cloudant-txe-jun1520}
{: release-note}

The following changes were made in build 2.69:

Query parameters
:   Query parameters for `_all_docs` and view requests are not ignored anymore.

`_bulk_get` request 
:   Limit maximum number of documents in a `_bulk_get` request to 10,000.

Error messages
:   Reword view and query pagination limit error messages that are returned with the HTTP 400 responses.

### 1 June 2020
{: #cloudant-txe-jun0120}
{: release-note}

The following changes were made in build 2.67:

New! Introducing {{site.data.keyword.cloudant_short_notm}} on Transaction Engine!
:   See [new features](https://www.ibm.com/cloud/blog/announcements/ibm-cloudant-on-transaction-engine) for {{site.data.keyword.cloudant_short_notm}} on Transaction Engine. 
- [Initial deployment announcement](https://www.ibm.com/cloud/blog/announcements/ibm-cloudant-on-transaction-engine){: external}.    
- [Feature comparison](/docs/Cloudant?topic=Cloudant-feature-comparison) between {{site.data.keyword.cloudant_short_notm}} on Transaction Engine and {{site.data.keyword.cloudant_short_notm}} Classic.


