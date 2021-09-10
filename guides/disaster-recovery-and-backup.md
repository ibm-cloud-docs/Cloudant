---

copyright:
  years: 2017, 2021
lastupdated: "2021-09-02"

keywords: types and levels of protection, data redundancy, cross-region redundancy, database backup and recovery

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
<!-- Acrolinx: 2021-04-16 -->

# Disaster recovery and backup for {{site.data.keyword.cloudant_short_notm}}
{: #disaster-recovery-and-backup}

Your data is important and valuable.
You want to protect your data
to help ensure it's secure,
available,
and maintains integrity.
{{site.data.keyword.cloudantfull}} provides several ways to protect your data and help keep your applications operational.
{: shortdesc}

Some of these protection features are automatic.
For other forms of protection,
{{site.data.keyword.cloudant_short_notm}} provides you with supported tools that
help you to create your own high availability and disaster recovery capabilities.

The {{site.data.keyword.cloud}} Service has Business Continuity plans in place to provide for the recovery of the Cloud Service within hours if a disaster occurs. 
You are responsible for your data backup, and associated recovery of your content.
{: important}

This document provides an overview of the automatic capabilities and supported tools that are offered by {{site.data.keyword.cloudant_short_notm}}.

## Types and levels of protection
{: #types-and-levels-of-protection}

The type of protection you might want depends on the problem you're trying to solve.

For example,
you might want to have a high level of data availability so that you can still access your data,
even if a limited amount of hardware within the system failed.
This requirement is necessary for "High Availability" (HA).
It means that you provide the best possible continuous data availability after a hardware failure.
Different HA techniques tolerate different levels of failure before operations are affected.

You might want to have quick and easy ways of backing up and restoring data.
For example,
after a severe or extensive hardware failure,
you want the ability to make all the data available on an alternative system
as quickly as possible.
This requirement is necessary for "Disaster Recovery" (DR).
A disaster generally means that a database is no longer available in one or more locations.
For example,
a power outage might cause all systems in a database cluster to fail. Or a large-scale network failure might mean systems in a cluster can't be contacted,
even though they continue to work correctly.

Addressing your HA or DR requirements often begins by simplifying the problem into more generic requirements.
When you identify your requirements,
you can apply the tools and features that help solve the generic needs.
Together, the tools and features can address your HA or DR requirements.

Different tools and features provide different levels of protection. The different features might be more or less suitable for your specific HA or DR requirement.
{: tip}

{{site.data.keyword.cloudant_short_notm}} provides a number of tools and features that address general requirements:

1.	Data redundancy within a single region, also known as [In-region automatic data redundancy](#in-region-automatic-data-redundancy).
2.	Cross-region data redundancy and failover, also known as [Cross-region redundancy for disaster recovery](#cross-region-redundancy-for-disaster-recovery).
3.	Point-in-time backup for point-in-time restores that use "traditional" [database backup and recovery](#database-backup-and-recovery).

## In-region automatic data redundancy
{: #in-region-automatic-data-redundancy}

Within a single {{site.data.keyword.cloudant_short_notm}} account,
data is stored in triplicate by using internal and automatic processes.
You don't need to do anything to enable this internal data replication.

In-region data redundancy enables high availability protection.
Specifically,
in-region data redundancy provides protection for your data against hardware failure within the region.
When a hardware unit within the region fails,
only the copy of your data that is stored on that unit is no longer available.
Your applications stay usable because {{site.data.keyword.cloudant_short_notm}} automatically routes requests to the copies of your data
that is still available on other hardware units within the region.
Meanwhile,
automatic monitoring of systems detects the hardware unit failure,
prompting action and subsequent restoration of full redundancy.

{{site.data.keyword.cloudant_short_notm}} accounts are located within a single region, which means the data that you store within your account is stored across separate servers,
each of which is hosted within that single region. 

In-region automatic data redundancy is limited to the following functions:

1.	Providing protection within a single region only.
2.	Maintaining current data.

To provide protection across more than the single region associated with your account,
use [Cross-region redundancy for disaster recovery](#cross-region-redundancy-for-disaster-recovery).
To provide protection for the "history" of your data,
use data snapshots that are created by [database backup and recovery](#database-backup-and-recovery) tools. For example, you can enable auditing of changes that are made to data by applications.

In-region data redundancy enables a High Availability capability
that provides tolerance for failures that affect single systems within the region.

## Cross-region redundancy for disaster recovery
{: #cross-region-redundancy-for-disaster-recovery}

The {{site.data.keyword.cloudant_short_notm}} replication feature helps you build a flexible disaster recovery capability into your applications.
The main way to enable disaster recovery is to use {{site.data.keyword.cloudant_short_notm}} replication to create redundancy across regions.
The result is that your application can tolerate the situation where one or more regions isn't available.

The basic steps in creating cross-region redundancy are included in the following list:

1.  Create {{site.data.keyword.cloudant_short_notm}} accounts in two or more regions.
2.  Create databases in each region as needed.
3.  For databases that must be stored with cross-region redundancy, set up bidirectional continuous replications between the corresponding databases in each account.
4.  Design and implement your applications so that data requests are routed depending on whether your environment is an Active-Passive or Active-Active configuration.
  For more information about setting up cross-region redundancy, see  [Configuring {{site.data.keyword.cloudant_short_notm}} for cross-region disaster recovery](/docs/Cloudant?topic=Cloudant-configuring-ibm-cloudant-for-cross-region-disaster-recovery#configuring-ibm-cloudant-for-cross-region-disaster-recovery).

When you design your applications to work with data across multiple regions,
consider the following points:

* Applications can send requests to the database hosted nearest to their physical location.
  This use of proximity can reduce network latency and improve response times.
  This configuration is referred to as an "Active-Active" method.
  An actve-active method is characterized by the concurrent use of multiple copies of data.
  Applications that work within an active-active configuration must have
  a [strategy for handling conflicts](/docs/Cloudant?topic=Cloudant-document-versioning-and-mvcc#distributed-databases-and-conflicts) to avoid problems with multiple copies of data.
* Applications can request data from a single region by default.
  If the region isn't available,
  the application can switch to requesting data from another region.
  This configuration is referred to as an "Active-Passive" method. An active-passive method is characterized by the active use of only one set of data at a time.
* An application might use a hybrid configuration,
  where a single account is used for all data write requests,
  and other locations as used exclusively for read-only requests.
  This configuration is considered Active-Active for reads.
* In a disaster scenario,
  your application must reroute data requests to access the accounts
  that are hosted in the regions that are still online.
  This requirement means that your application must detect the loss of a region,
  and then reroute data requests.

In summary,
cross-region redundancy is similar to a high availability capability,
but applies to failures that affect an entire region.
Configuring your applications to work correctly with cross-redundancy configurations provides real disaster recovery capability. Therefore, the applications can continue working if the data in one region isn't available for an amount of time.
{{site.data.keyword.cloudant_short_notm}} replication helps ensure data synchronization between regions. Your applications must "fail over" to copies of your data that is stored in other regions.

## Database backup and recovery
{: #database-backup-and-recovery}

[In-region automatic data redundancy](#in-region-automatic-data-redundancy) provides applications with high availability access to data.
[Cross-region redundancy for disaster recovery](#cross-region-redundancy-for-disaster-recovery) provides applications with a means of recovering from a disaster.
However,
both of these capabilities focus on maintaining access only to the *current* copy of your data.

People and applications can make mistakes and change data in unintended ways.
The applications themselves can implement some protection,
but sometimes undesirable changes get through.
It's useful to be able to restore data from a previous point in time.
Database backups support this requirement.

In addition to protecting your data with high availability and disaster recovery features,
consider dumping your database data to a separate location at periodic,
regular intervals.
Ensure you check and test the backups for confidence that they're complete and correct.

{{site.data.keyword.cloudant_short_notm}} supports tools that help you dump the JSON content in databases to a file,
and later restore databases from those files.

Specifically,
{{site.data.keyword.cloudant_short_notm}} supports tools that help you perform the following tasks:

*	Backup complete databases to a file that is
	suitable for further processing and off-site storage.
*	Restore complete databases from a previous state that is contained in your backup file.

The tools that are supported by {{site.data.keyword.cloudant_short_notm}} have the following limitations: 
{: tip}

*	`_security` settings aren't backed up by the tools.
*	Attachments aren't backed up by the tools.
*	Backups aren't precisely accurate "point-in-time" snapshots.
	The reason is that the documents in the database are retrieved in batches,
	but other applications might be updating documents at the same time.
	Therefore,
	the data in the database can change between the times when the first and last batches are read.
*	Index definitions held design documents are backed up,
	but when data is restored the indexes must be rebuilt.
	This rebuilding might take a considerable amount of time,
	depending on how much data is restored.

## Next steps with your data protection strategies
{: #next-steps-with-your-data-protection-strategies}

You can develop applications that build on basic {{site.data.keyword.cloudant_short_notm}} functions and supported tools
to enable more complex data protection strategies.
Example scenarios are shown in the following list:

*	Restoring single documents from previous states.
*	Storing multiple previous document states to allow for restores from older backups.
*	Migrating older data to cheaper storage, for more cost-effective retention.

The backup tools consist of an open source node.js command-line application and library.
It's available on [NPM](https://www.npmjs.com/package/@cloudant/couchbackup){: new_window}{: external}.

For ideas and examples that show how to integrate the tools into your data protection strategy,
see the [{{site.data.keyword.cloudant_short_notm}} backup and recovery guide](/docs/Cloudant?topic=Cloudant-ibm-cloudant-backup-and-recovery#ibm-cloudant-backup-and-recovery).
