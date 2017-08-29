---

copyright:
  years: 2017
lastupdated: "2017-07-12"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-07-12 -->

# Differences between major Cloudant releases

Summary of the changes in behavior between the most recent version of 
Cloudant and CouchDB 1.6-based codebase. Information is added as newer Cloudant 
versions are released.
{:shortdesc}

## New features

- The new replication scheduler has several improvements and enhancements. Learn more about the [replication scheduler](../api/advanced_replication.html#the-replication-scheduler).

## Bug fixes

## Incompatibilites

- Active tasks
    - Indexer entries in the _active_tasks response no longer report the user field.
    - Search indexer entries in the _active_tasks response no longer report the user field.
- Views
    - Unicode normalization of key values is consistent between reduced and non-reduced view results. If raw collation is specified in a design document, result order might change as the result of this fix.

## Deprecations

     The `dbcopy` feature is deprecated

