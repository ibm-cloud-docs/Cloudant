---

copyright:
  years: 2019, 2020
lastupdated: "2020-12-23"

keywords: compare

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

<!-- Acrolinx: 2020-12-23 -->

# Overview
{: #apache-couchdb-overview}

[Apache CouchDB](http://couchdb.apache.org/){: new_window}{: external} is a powerful and scalable Apache-licensed open source database with an intuitive HTTP API that scales from a developer's laptop to production database clusters. Furthermore, the Apache CouchDB replication protocol allows data to be synchronized between clusters spread across the globe, to devices in your customers' pockets, and to {{site.data.keyword.cloudantfull}} managed service instances. It is proven for production and is available at no charge to download and use for any purpose.
{: shortdesc}

{{site.data.keyword.IBM}} recommends the use of Apache CouchDB for any self-managed installations to pair alongside {{site.data.keyword.cloudant_short_notm}}. Using {{site.data.keyword.cloudant_short_notm}} and Apache CouchDB together provides teams with the following functions:

- From inception, {{site.data.keyword.cloudant_short_notm}} was built with Apache CouchDB and maintains API compatibility for core features. The common replication protocol between these technologies enables hybrid multicloud architectures.
- Combine {{site.data.keyword.cloudant_short_notm}} and Apache CouchDB as an open data layer for your applications to build once and run anywhere. 
- Developers can use both the Apache CouchDB and {{site.data.keyword.cloudant_short_notm}} database ecosystem to store data wherever they need it. For example, you could use {{site.data.keyword.cloudant_short_notm}} in the {{site.data.keyword.cloud_notm}} and synchronize data with Apache CouchDB running at an edge location like an oil rig or tablet device. Alternatively, you could use {{site.data.keyword.cloudant_short_notm}} for a large-scale production environment while you use Apache CouchDB for local development and testing. 

![IBM Cloudant and Apache CouchDB Hybrid Cloud architecture](../images/cloudant_and_couchdb.png){: caption="Figure 1. IBM Cloudant and Apache CouchDB Hybrid Cloud architecture" caption-side="bottom"}
