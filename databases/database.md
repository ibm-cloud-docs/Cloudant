---

copyright:
  years: 2015, 2022
lastupdated: "2022-06-03"

keywords: create database, database topology, multiple queries, work with databases, partition database, delete database, back up data, create database applications

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# Database overview
{: #databases}

{{site.data.keyword.cloudantfull}} databases contain JSON objects.
These JSON objects are called [documents](/docs/Cloudant?topic=Cloudant-documents#documents).
{: shortdesc}

All documents must be contained in a database. For more information, see [partitioned databases](#partitioned-databases-database).

The [Grouping related documents together in {{site.data.keyword.cloudant_short_notm}}](/docs/Cloudant?topic=Cloudant-grouping-related-documents-together-in-ibm-cloudant#grouping-related-documents-together-in-ibm-cloudant) guide provides an example of how documents for an e-commerce application might be used within an {{site.data.keyword.cloudant_short_notm}} database.

## Partitioned databases
{: #partitioned-databases-database}

{{site.data.keyword.cloudant_short_notm}} supports two types of databases:

-   Partitioned
-   Non-partitioned

A partitioned database offers significant query performance and cost advantages but requires you to specify a logical partitioning of your data. The partitioning is specified as part of each document's ID. A partitioned database allows performing both global and partition queries. Partition queries target queries at a single, given document partition, meaning they need to process less data to return results. Therefore, partition queries offer significant performance advantages, and also often provide cost advantages over global queries. Global queries target the entire database, which leads to extra complexity, slower performance, and increased cost, but offers results that draw from all data.

Alternatively, a non-partitioned database might be created. This type of database can be easier to work with as no partitioning scheme needs to be defined, but only global secondary indexes can be created.

{{site.data.keyword.cloudant_short_notm}} strongly recommends that you use a partitioned database for best long-term database performance where the data model allows for logical partitioning of documents.

The partitioning type of a database is set at database creation time. When you create a database, use the `partitioned` query string parameter to set whether the database is partitioned. The default for `partitioned` is `false`, maintaining compatibility with an earlier version.

The partitioning type can't be changed for an existing database.

For more information, see [Database partitioning](/docs/Cloudant?topic=Cloudant-database-partitioning).
