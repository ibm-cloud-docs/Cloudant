---

copyright:
  years: 2020
lastupdated: "2020-06-12"

keywords: recommendations

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

<!-- Acrolinx: 2020-03-13 -->

# Overview
{: #overview-te}

{{site.data.keyword.cloudantfull}} has a new `Standard on Transaction Engine` plan. Instances provisioned with this plan are deployed on the new architecture underpinned by a Transaction Engine. The new architecture aims to provide the best of both non-relational and relational data stores combining scale, fault tolerance, consistency, security, and speed at optimal cost. The Transaction Engine architecture is compared to the "Classic" architecture for clarity in the documentation.  

The key features that {{site.data.keyword.cloudant_short_notm}} on the new Transaction Engine architecture provides are the following: 

- In-region consistency - An application can safely read its own writes and can operate conflict-free with in-region writes.
- Synchronous secondary index building: {{site.data.keyword.cloudant_short_notm}} Query indexes are updated in the same database transaction as write operations.
- Data durability - The new architecture maintains all data being stored in triplicate, data stored across a region's availability zones where available.
- Provisioned throughput capacity: Provision the capacity, based only on the read and write capacities (i.e. reads and writes per second) that your application needs. Scale up and down using the API as required. Global queries now scale with the read capacity.
- Scalability - Global queries and data volumes scale linearly. Database sharding is automatic.
- Cost - Store 4X the amount of data and perform upwards of 20X the amount of global queries at the same cost as in Classic.
- In-database encryption - Data values are encrypted both in primary data and indexed data within the database, with a unique encryption key per database.
- Database recovery - API's are provided to allow database-level recovery for accidental deletions within a time window.

Now, we further elaborate on the benefits of using {{site.data.keyword.cloudant_short_notm}} on the new Transaction Engine architecture.

## In-region consistency

In {{site.data.keyword.cloudant_short_notm}} on the Classic architecture, the database is eventually consistent. The application cannot safely read its own documents writes and may inadvertently create conflicts when a document is updated frequently in a short time window. 

{{site.data.keyword.cloudant_short_notm}} on the Transaction Engine architecture provides in-region consistency with the following guarantees:
- If an application writes a document revision to {{site.data.keyword.cloudant_short_notm}}, it is guaranteed that the revision is available to subsequent read requests.
- If a new document is created by two simultaneous writes, attempting to create the same document id, one succeeds and the other fails.
- Similarly, if two simultaneous processes attempt to modify a document in different ways, one succeeds and the other fails.
- The changes feed is strictly ordered ("linearized") making it much easier for changes feed listeners to consume the changes feed without having to deal with duplicates of the same change.

## Synchronous index building

{{site.data.keyword.cloudant_short_notm}} on the Transaction Engine architecture updates {{site.data.keyword.cloudant_short_notm}} Query indexes in the same database transaction as document updates. When a document is added, updated, or deleted via the API, any secondary {{site.data.keyword.cloudant_short_notm}} Query indexes associated with that database are updated at the same time as the document, keeping the database and its indexes in lock-step. 

When a new {{site.data.keyword.cloudant_short_notm}} Query index is first defined, the existing documents in the database are indexed in the background and any newly arriving changes are indexed transactionally. When the background indexing task is complete, the index is ready to use and from that point on is fully in lock-step with the document store.

MapReduce indexes are still built in the background, in the same way as {{site.data.keyword.cloudant_short_notm}} on the Classic architecture.
{ :note}

## Data Durability

{{site.data.keyword.cloudant_short_notm}} on the Transaction Engine architecture has an entirely redesigned persistence layer, built on open source foundations. The new database underpinnings offer:
- Cross-zone data durability able to survive availability zone failure. Multiple availability zones need to be available in region, otherwise this is cross-server within the same data center.
- Hyper-scale database sizes without having to worry about shard sizes.
- Database recovery API's that recover quickly from inadvertent deletion of databases.

## Scalability and cost

The new pricing model allows a number of _read_ and _write_ units per second to be provisioned. The number of reads and writes consumed by each API call is listed in the [pricing](/docs/services/Cloudant?topic=cloudant-pricing-te) guide, but it rewards bulk API operations that fetch or modify several documents over their piecemeal equivalents. This pricing model makes it much cheaper to run query-based workloads, especially if efficient secondary indexes are used to complement each query. Storage costs one-fourth less in the new Transaction Engine architecture than in Classic. Re-sharding is automatic and doesn't require user input at database creation time.

## Security
{: #security-overview-te}

{{site.data.keyword.cloudant_short_notm}} on the Transaction Engine architecture continues to encrypt all data at rest and over the HTTPS API. In addition, encryption of all data values of both primary and indexed data occurs within the database prior to storing on disk. This encryption ensures finer-grained control over who can access the contents.

## Feature Parity between {{site.data.keyword.cloudant_short_notm}} on the Transaction Engine vs "Classic" architecture

Not all {{site.data.keyword.cloudant_short_notm}} features currently available in the Cloudant "classic" architecture will be available in the new `Standard on Transaction Engine` plan. Customers should evaluate their requirements and choose the appropriate plan for their use case. Additional upcoming features will land solely on the Transaction Engine architecture related to scalability, security, and compliance so it is recommended to use this plan whenever feasible. 
