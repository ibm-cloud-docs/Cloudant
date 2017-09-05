---

copyright:
  years: 2017
lastupdated: "2017-09-05"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-07-11 -->


# What's new in Cloudant

See what is new and interesting in Cloudant. 
{:shortdesc}

[Build 6069 (May 11, 2017)](/docs/services/Cloudant/release_info/release_notes.html#build-6069-may-11-2017)
Release of scheduling replicator.

[Build 6365 (August 17, 2017)](/docs/services/Cloudant/release_info/release_notes.html#build-6365-august-17-2017)
Add the X-Frame-Options header settings to prevent clickjacking. Learn more about [X-Frame-Options](../release_info/deprecations.html#x-frame-options-setting).

## Deprecations

- Active tasks
    - Indexer entries in the _active_tasks response no longer report the user field.
    - Search indexer entries in the _active_tasks response no longer report the user field.
- Views
    Unicode normalization of key values is consistent between reduced and non-reduced view results. If raw collation is specified in a design document, result order might change as the result of this fix.
    
