---

copyright:
  years: 2020, 2023
lastupdated: "2023-03-01"

keywords: Transaction Engine, recommendations, database recovery, in-database encryption, in-region strong consistency, synchronous secondary index building, provisioned throughput capacity, scalability, cost

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# Transaction Engine notice
{: #transaction-engine-notice}

The {{site.data.keyword.cloudantfull}} on Transaction Engine service ends on 1 February 2023. You can no longer create new instances of {{site.data.keyword.cloudant_short_notm}} on Transaction Engine. On 1 February 2023, all instances of {{site.data.keyword.cloudant_short_notm}} on Transaction Engine will be permanently disabled and deprovisioned. Users of existing instances need to migrate from the service before the end of service date. You can find guidance on migrating from {{site.data.keyword.cloudant_short_notm}} on Transaction Engine to {{site.data.keyword.cloudant_short_notm}} Standard here: [Migrating from TXE](https://blog.cloudant.com/2022/01/14/Migrating-from-Cloudant-TXE-to-Standard){: external}.
{: deprecated}

## What is Transaction Engine?
{: #what-is-txe}

{{site.data.keyword.cloudant_short_notm}} has an architecture option, which is underpinned by a Transaction Engine. This architecture aims to provide the best of both non-relational and relational data stores combining scale, fault tolerance, consistency, security, and speed at optimal cost. The Transaction Engine architecture is compared to the "Classic" architecture for clarity in the documentation. Instances that are provisioned with the `Standard on Transaction Engine` plan are deployed by using this architecture, while instances on the `Lite` and `Standard` plan are deployed on the "Classic" architecture.
