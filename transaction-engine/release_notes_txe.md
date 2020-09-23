---

copyright:
  years: 2020
lastupdated: "2020-09-22"

keywords: new features, initial deployment announcement, feature comparison, 2.75, 2.69, 2.67, 2.77, 2.78. 2.79, 2.80

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

<!-- Acrolinx: 2020 -->

# Release notes
{: #release-notes-txe}

Changes and updates to {{site.data.keyword.cloudantfull}} Transaction Engine that are grouped by build number.
{: shortdesc}

## New features
{: #new-features-txe}

See [new features](https://www.ibm.com/cloud/blog/announcements/ibm-cloudant-on-transaction-engine) for {{site.data.keyword.cloudant_short_notm}} on Transaction Engine.

## Build 2.80 (September 2020)
{: #build-2.80-september-2020}

- Bug fixes.

## Build 2.79 (September 2020)
{: #build-2.79-september-2020}

- Remove empty entries from `_active_tasks`.
- Fix the order of results for page_size-based pagination for views.
- Remove completed Couch jobs from `_active_tasks`.
- Improve performance of view builds when there are no emits from JavaScript function.

## Build 2.77 (August 2020)
{: #build-2.77-august-2020}

- Fixed dashboard access for {{site.data.keyword.cloudant_short_notm}} Transaction Engine instances.

## Build 2.75 (August 2020)
{: #build-2.75-august-2020}

- Disable non-IAM authentication and authorization methods.
  - Block write to `/_security` endpoint.
  - Block creation of `/_users` databases.
- Fix intermittent error when recreating database instances.
- Add `local_seq` options to views.
- Add support for `_active_tasks`.

## Build 2.69 (June 2020)
{: #build-2.69-june-2020}

- Query parameters for `_all_docs` and view requests are not ignored anymore.
- Limit maximum number of documents in a `_bulk_get` request to 10000.
- Reword view and query pagination limit error messages that are returned with the HTTP 400 responses.

## Build 2.67 (June 2020)
{: #build-2.67-june-2020}

- [Initial deployment announcement](https://www.ibm.com/cloud/blog/announcements/ibm-cloudant-on-transaction-engine){: new_window}{: external}.
- [Feature comparison](/docs/Cloudant?topic=Cloudant-feature-comparison) between {{site.data.keyword.cloudant_short_notm}} on Transaction Engine and {{site.data.keyword.cloudant_short_notm}} Classic.

