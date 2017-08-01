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

This document summarizes the changes in behavior between the most recent version of 
Cloudant and CouchDB 1.6 based codebase. This document is updated as newer Cloudant 
versions are released.
{:shortdesc}

## New features

### Replication ID generation algorithm

The current algorithm sets replication checkpoints to _local documents 
identified by replication IDs. If replication IDs change, replication tasks cannot find their previous 
checkpoints and rewind their change feeds back to 0. For a large database, 
this might mean reprocessing millions of documents. The current replication ID generation algorithm hashes the full 
URL of the source, target, and headers, including authorization URLs and a few other things.
    
The new algorithm uses the following rules: 
    
1.  Excludes source and target URI schema from the replication ID calculation. If the host and other parts stay the 
same, changing the schema has no effect on the replication ID.
2.  Ignores inline (specified in the URL) basic authentication passwords. 
3.  Ignores basic authentication password even if it is provided in the basic authorization headers.
4.  Insensitive to switching between providing basic authentication credentials inline or in a 
    header section. However, it includes the user name that is used as the basic authorization in the calculation. It is 
    possible that `http://user1:pass1@a.host.com` is a different database than `http://user2:pass2@@a.host.com`.

## Enhancements


## Bug fixes


## Deprecations



