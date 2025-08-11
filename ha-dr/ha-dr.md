---

copyright:
  years: 2025
lastupdated: "2025-08-11"

keywords: HA for Cloudant, DR for Cloudant, Cloudant recovery time objective, Cloudant recovery point objective

subcollection: content-kit

---

{{site.data.keyword.attribute-definition-list}}



# Understanding high availability and disaster recovery for {{site.data.keyword.cloudant_short_notm}}
{: #service-name-ha-dr}



[High availability](#x2284708){: term} (HA) is the ability for a service to remain operational and accessible in the presence of unexpected failures. [Disaster recovery](#x2113280){: term} is the process of recovering the service instance to a working state.
{: shortdesc}

{{site.data.keyword.cloudantfull}} is a highly available global service designed for availability during a zonal outage. {{site.data.keyword.cloudant_short_notm}} is designed to meet the [Service Level Objectives (SLO)](/docs/resiliency?topic=resiliency-slo) with the Standard plan.

For more information about the available region and data center locations, see [Service and infrastructure availability by location](/docs/overview?topic=overview-services_region).

## High availability architecture
{: #ha-architecture}

![Architecture](../images/Cloudant_HA.svg){: caption="Cloudant architecture" caption-side="bottom"}

{{site.data.keyword.cloudant_short_notm}} provides replication, failover, and high-availability features to protect your databases and data from infrastructure maintenance, upgrades, and some failures. Deployments contain a cluster with three nodes spread across three availability zones in a region. All data is distributed in multiple shards, which are replicated three times in different nodes, so that a shard replica is stored in triplicate across these three separate nodes. The data is kept up to date using *eventual consistency* replication. A distributed consensus mechanism is used to maintain cluster state and handle failovers. If a node is unavailable, the request is routed to a different node, which has shard replicas, ensuring service and data availability. The old node rejoins the set when available. If a zone failure results in a member failing, the new replica will be created in a surviving zone.

### High availability features
{: #ha-features}

{{site.data.keyword.cloudant_short_notm}} supports the following high availability features:



| Feature | Description | Consideration |
| -------------- | -------------- | -------------- |
| Automatic failover | Standard on all clusters and resilient against a zone or single member failure. |  |
| Node count | Out of the box, 3 node deployment. A three-member cluster will automatically recover from a single instance or zone failure (with data loss up to the lag threshold), ensuring service availability. |  |
| Shard replication | Shards are replicated thrice ensuring data availability. Each replica shard is placed on a different node.  |  |
| Cross-region high availabilty | {{site.data.keyword.cloudant_short_notm}} enables cross-region data redundancy and failover. | Optional. Customers can configure cross-region high availability. |
{: caption="HA features for {{site.data.keyword.cloudant_short_notm}}" caption-side="bottom"}



## Disaster recovery architecture
{: #disaster-recovery-intro}

![Architecture](../images/Cloudant_DR.svg){: caption="Cloudant recovery architecture" caption-side="bottom"}

Although data is stored redundantly within an {{site.data.keyword.cloudant_short_notm}} cluster, it's important to consider extra backup measures. {{site.data.keyword.cloudant_short_notm}} provides a supported tool for snapshot backup and restore. The tool is called *CouchBackup*, and is open source. For more information, see [Introducing CouchBackup](/docs/Cloudant?topic=Cloudant-ibm-cloudant-backup-and-recovery#introducing-couchbackup).

You can also create replication to another {{site.data.keyword.cloudant_short_notm}} instance with bidirectional continuous replication, either active-passive or active-active configuration. For more information, see [replication setup](/docs/Cloudant?topic=Cloudant-configuring-ibm-cloudant-for-cross-region-disaster-recovery).

### Disaster recovery features
{: #dr-features}

{{site.data.keyword.cloudant_short_notm}} supports the following disaster recovery features:



| Feature | Description | Consideration |
| -------------- | -------------- | -------------- |
| Backup restore | Restore a database from previously created backup; see {{site.data.keyword.cloudant_short_notm}} [backup and recovery](/docs/Cloudant?topic=Cloudant-ibm-cloudant-backup-and-recovery). | Open soure tool. Customer configured. |
| Cross-region failover | {{site.data.keyword.cloudant_short_notm}} [replication](https://cloud.ibm.com/docs/Cloudant?topic=Cloudant-configuring-ibm-cloudant-for-cross-region-disaster-recovery) feature helps you build a flexible disaster recovery capability. |  Customer configured.  |
| Live synchronization | {{site.data.keyword.cloudant_short_notm}} bidirectional active-active replication feature helps you build a flexible disaster recovery capability. |  Customer configured. |
{: caption="DR features for {{site.data.keyword.cloudant_short_notm}}" caption-side="bottom"}



### Planning for DR
{: #features-for-disaster-recovery}

The DR steps must be practiced regularly. As you build your plan, consider the following failure scenarios and resolutions.



| Failure | Resolution |
| -------------- | -------------- |
| Hardware failure (single point) | {{site.data.keyword.cloudant_short_notm}} provides a database that is resilient from single point of hardware failure within a zone. No customer configuration required. |
| Zone failure | Automatic failover. The database members are distributed between zones. Configured three members provide additional resiliency to multiple zone failures. <br> Shard replica. The database is distributed in multiple shards with triplicate replication on the members. |
| Data corruption | Backup restore. Use the restored database in production or for source data to correct the corruption in the restored database. |
| Regional failure | Backup restore. Use the restored database in production. <br> Cross-region replication. |
{: caption="DR scenarios for {{site.data.keyword.cloudant_short_notm}}" caption-side="bottom"}

## Your responsibilities for HA and DR
{: #feature-responsibilities}



It is your responsibility to continuously test your plan for HA and DR.

Interruptions in network connectivity and short periods of unavailability of a service might occur. It is your responsibility to make sure that application source code includes [client availability retry logic](/docs/resiliency?topic=resiliency-high-availability-design#client-retry-logic-for-ha) to maintain high availability of the application.
{: note}



For more information about responsibility ownership between you and {{site.data.keyword.cloud_notm}} for {{site.data.keyword.cloudant_short_notm}}, see [Understanding your responsibilities when you use {{site.data.keyword.cloudant_short_notm}}](/docs/Cloudant?topic=Cloudant-cloudant-responsibilities).













## Stay informed: IBM notifications
{: #ibm-notifications}

Updates affecting customer workloads are communicated through IBM Cloud notification. Changes that impact customer workloads are detailed in {{site.data.keyword.cloud_notm}} notifications. For more information about planned maintenance, announcements, and release notes that impact this service, see [Monitoring notifications and status](/docs/account?topic=account-viewing-cloud-status).

## How {{site.data.keyword.IBM_notm}} maintains services
{: #ibm-service-maintenance}

Stay updated with [Service changes and deprecations](https://cloud.ibm.com/docs/Cloudant?topic=Cloudant-deprecations-for-ibm-cloudant) and [Release notes](https://cloud.ibm.com/docs/Cloudant?topic=Cloudant-classic-release-notes) of {{site.data.keyword.cloudant_short_notm}}.
