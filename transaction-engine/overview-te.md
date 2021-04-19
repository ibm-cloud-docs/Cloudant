---

copyright:
  years: 2020, 2021
lastupdated: "2021-04-19"

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

<!-- Acrolinx: 2021-04-19 -->

# Overview
{: #overview-te}

{{site.data.keyword.cloudantfull}} has a new architecture option, which is underpinned by a Transaction Engine. The new architecture aims to provide the best of both non-relational and relational data stores combining scale, fault tolerance, consistency, security, and speed at optimal cost. The Transaction Engine architecture is compared to the "Classic" architecture for clarity in the documentation. Instances that are provisioned with the new `Standard on Transaction Engine` plan are deployed by using the new architecture, while instances on the `Lite` and `Standard` plan are deployed on the "Classic" architecture.

The key features that {{site.data.keyword.cloudant_short_notm}} on the new Transaction Engine architecture provides are shown in the following list: 

- In-region strong consistency - An application can safely read its own writes and can operate conflict-free with in-region writes. {{site.data.keyword.cloudant_short_notm}} "Classic" is eventually consistent, and an application might see old values of data for a small period after updates. With {{site.data.keyword.cloudant_short_notm}} on Transaction Engine that is guaranteed not to happen. Once {{site.data.keyword.cloudant_short_notm}} acknowledges a write, within a region, no reader ever sees the old value when they read a document.
- Synchronous secondary index building - {{site.data.keyword.cloudant_short_notm}} Query indexes are updated in the same database transaction as write operations. Therefore, as for documents, a reader of {{site.data.keyword.cloudant_short_notm}} Query indexes never sees an old value.
- Data durability - The new architecture maintains all data that is stored in triplicate, data that is stored across a region's availability zones where available.
- Provisioned throughput capacity - Provision the capacity and base it only on the read and write capacities (for example, reads and writes per second), that your application needs. Scale up and down using the API as required. Global queries now scale with the read capacity.
- Scalability - Global queries and data volumes scale linearly. Database sharding is automatic.
- Cost - Store 4X the amount of data and perform upwards of 20X the number of global queries at the same cost as Classic.
- In-database encryption - {{site.data.keyword.cloudant_short_notm}} on Transaction Engine adds more native in-database encryption as well as storage volume encryption. Data values are encrypted both in primary data and indexed data within the database, with a unique encryption key per database. 
- Database recovery - APIs are provided to allow database-level recovery for accidental deletions within a time window.

The following discussion elaborates on the benefits of using {{site.data.keyword.cloudant_short_notm}} on the new Transaction Engine architecture.

## In-region consistency

In {{site.data.keyword.cloudant_short_notm}} on the Classic architecture, the database is eventually consistent. The application can't safely read its own documents writes and might inadvertently create conflicts when a document is updated frequently in a short time window. 

{{site.data.keyword.cloudant_short_notm}} on the Transaction Engine architecture provides in-region consistency with the following guarantees:
- If an application writes a document revision to {{site.data.keyword.cloudant_short_notm}}, it is guaranteed that the revision is available to later read requests.
- If a new document is created by two simultaneous writes, attempting to create the same document ID, one succeeds and the other fails.
- Similarly, if two simultaneous processes attempt to modify a document in different ways, one succeeds and the other fails.
- The changes feed is strictly ordered ("linearized") making it much easier for changes feed listeners to consume the changes feed without having to deal with duplicates of the same change.

## Synchronous index building

{{site.data.keyword.cloudant_short_notm}} on the Transaction Engine architecture updates {{site.data.keyword.cloudant_short_notm}} Query indexes in the same database transaction as document updates. When you add, update, or delete a document by using the API, any secondary {{site.data.keyword.cloudant_short_notm}} Query indexes that are associated with that database are updated at the same time as the document. This process keeps the database and its indexes in lockstep. 

When a new {{site.data.keyword.cloudant_short_notm}} Query index is first defined, the existing documents in the database are indexed in the background and any newly arriving changes are indexed transactionally. When the background indexing task is complete, the index is ready to use and from that point on is fully in lock-step with the document store.

MapReduce indexes are still built in the background, in the same way as {{site.data.keyword.cloudant_short_notm}} on the Classic architecture.
{: note}

## Data Durability

{{site.data.keyword.cloudant_short_notm}} on the Transaction Engine architecture has an entirely redesigned persistence layer, which is built on open source foundations. The new database underpinnings offer the following functionality:
- Cross-zone data durability able to survive availability zone failure. Multiple availability zones need to be available in region, otherwise cross-server within the same data center can occur.
- Hyper-scale database sizes without having to worry about shard sizes.
- Database recovery APIs that recover quickly from inadvertent deletion of databases.

## Scalability and cost

The new pricing model allows a number of _read_ and _write_ units per second to be provisioned. The number of reads and writes consumed by each API call is listed in the [pricing](/docs/Cloudant?topic=Cloudant-pricing-te) guide. It rewards bulk API operations that fetch or modify several documents over their piecemeal equivalents. This pricing model makes it much cheaper to run query-based workloads, especially if efficient secondary indexes are used to complement each query. Storage costs one-fourth less in the new Transaction Engine architecture than in Classic. Resharding is automatic and doesn't require user input at database creation time.

## Security
{: #security-overview-te}

{{site.data.keyword.cloudant_short_notm}} on the Transaction Engine architecture continues to encrypt all data at rest and over the HTTPS API. Also, encryption of all data values of both primary and indexed data occurs within the database before it stores on disk. 

## Plans
{: #plans-overview-te}

Instances that are provisioned with the new `Standard on Transaction Engine` plan are deployed by using the new architecture, while instances on the `Lite` and `Standard` plans are deployed on the "Classic" architecture. Therefore, users can't change plans between architectures. Plan changes from `Standard on Transaction Engine` to `Lite` or `Standard` aren't allowed. (Users receive a `BXNUI0112E: The plan could not be updated` message upon attempting a plan change.) Users who want to migrate between architectures must spin up a new instance and replicate the data between them. 

## Feature Parity between {{site.data.keyword.cloudant_short_notm}} on the Transaction Engine vs "Classic" architecture

Not all {{site.data.keyword.cloudant_short_notm}} features currently available in the Cloudant "classic" architecture are available in the new `Standard on Transaction Engine` plan. Customers must evaluate their requirements and choose the appropriate plan for their use case. Multiple upcoming features rely solely on the Transaction Engine architecture that is related to scalability, security, and compliance. It is recommended that you use this plan whenever feasible. 
