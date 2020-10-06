---

copyright:
  years: 2020
lastupdated: "2020-10-08"

keywords: pricing, features, functions, HA, DR, backup, compliance, security, limits

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

<!-- Acrolinx: 2020-10-08 -->

# Feature comparison
{: #feature-comparison}

The following tables show the differences between {{site.data.keyword.cloudantfull}} "Classic" architecture and {{site.data.keyword.cloudant_short_notm}} on the new Transaction Engine architecture.

The comparison tables serve as a point-in-time comparison to aid in choosing between the two plans at provisioning time. Customers must choose the plan to meet the needs of their application. Certain new features will be delivered only on {{site.data.keyword.cloudant_short_notm}} on Transaction Engine. For this reason, we recommend you choose the {{site.data.keyword.cloudant_short_notm}} on Transaction Engine plan whenever possible.  
{: note}

The comparison tables break down the features into the following categories:

- Pricing
- Features and functions
- Limits
- HA, DR, and backup
- Security
- Compliance

## Pricing
{: #pricing-feature-compare}

All prices are shown in USD. A capacity is the ability to perform one operation per second, for example, a `read capacity` is the ability to perform one read per second. 

| Feature | {{site.data.keyword.cloudant_short_notm}}<br>"Classic" | {{site.data.keyword.cloudant_short_notm}} on Transaction Engine|
|---------|----------|--------------------------|
| `Provisioned Throughput Capacity` | Fixed ratio of<br>100 reads/sec<br>50 writes/sec<br>5 global queries/sec | Fixed ratio of<br>50 reads/sec<br>50 writes/sec |
| `Read Capacity` | $0.00034 per hour<br>$0.25 per month | $0.00012 per hour<br>$0.0876 per month |
| `Write Capacity` | $0.00068 per hour<br>$0.50 per month | $0.00048 per hour<br>$0.3504 per month |
| `Global Query Capacity` | $0.0068 per hour<br>$5.00 per month | Not applicable |
| `Storage` | $1 per GB per month<br>20 GB included | $0.25 per GB per month<br>25 GB included |
| `Dedicated Hardware` | $5000 per month add-on | Not applicable |
| `Bandwidth` | Included | Included |
| `Proration` | Hourly<br>(Dedicated Hardware is daily.) | Hourly |
| `Standard Plan Minimum Cost` | ~$75 per month | ~$22 per month | 
{: caption="Table 1. Pricing" caption-side="top"}

## Features and functions
{: #features-and-functions}

| Feature | {{site.data.keyword.cloudant_short_notm}}<br>"Classic" | {{site.data.keyword.cloudant_short_notm}} on Transaction Engine |
|---------|----------|--------------------------|
| `Tenancy` | Multi-tenant or Dedicated | Multi-tenant | 
| `Conflicts` | Quorum-based eventually consistent | No write conflicts in region. | 
| `Consistency` | Eventually consistent | Doc Writes & Cloudant Query indexes are consistent. |
| `Sharding` | Choose at database creation time. | Auto shard-splitting | 
| `Authentication` | Legacy and IAM | IAM-only |
| `Replication` | Yes | Yes, as source or target.<br>Mediator needs to be on a "Classic" instance. |
| `Attachments` | Yes | No |
| `Global Queries` | Yes | Yes |
| `Partition Queries` | Yes | No |
| `Cloudant Query`<br>(JSON type) | Yes | Yes |
| `Cloudant Query`<br>(Text type) | Yes | No |
| `MapReduce` | Yes | Map-side JS functions<br>No reduces |
| `Search` | Yes | No |
| `Geospatial` | Yes | No |
| `Logging with LogDNA` | Yes | Yes |
| `Activity Tracker with LogDNA` | Yes | Yes |
| `Monitoring with Sysdig` | Yes | Yes |
{: caption="Table 2. Features and functions" caption-side="top"}

## Limits
{: #limits-feature-compare}

| Feature | {{site.data.keyword.cloudant_short_notm}}<br>"Classic" | {{site.data.keyword.cloudant_short_notm}} on Transaction Engine |
|---------|----------|--------------------------|
| `Max Database Size` | ~5 TB | 100 TB+ |
| `Max Database Name Length` | 238 bytes | 256 bytes | 
| `Max Document Size` | 1 MB | 1 MB | 
| `Max Document ID Length` | 7168 bytes | 512 bytes |
| `Max Indexed Key Length` | Not applicable | 8000 bytes |
| `Max Indexed Value Length` | Not applicable | 64000 bytes |
| `Attachment Size` | 10 MB | Not applicable |
| `Request Size` | 11 MB | 64 MB |
| `Request Timeout` | 60 s | 5 s |
| `Max Docs in Bulk Doc Request` | Not applicable | 2000 documents |
| `Max Docs in Bulk Get Request` | Not applicable | 2000 documents |
| `Max Value for Skip Parameter` | Not applicable | 2000 |
| `Max Number of Keys to All Docs` | Not applicable | 2000 |
| `Max Queries in Queries Request` | Not applicable | 2000 | 
| `Results - MapReduce` | Unlimited | 2000 |
| `Results - Cloudant Query`<br>(JSON type) | Unlimited | 2000 | 
{: caption="Table 3. Limits" caption-side="top"}

## HA, DR, and backup
{: #hadr-feature-compare}

| Feature | {{site.data.keyword.cloudant_short_notm}}<br>"Classic"<br> | {{site.data.keyword.cloudant_short_notm}} on Transaction Engine |
|---------|----------|-------------------------------|
| `In-region HA/DR` | Data automatically stored in triplicate<br>Leverage multi-zone in regions where available | Data automatically stored in triplicate<br>Leverage multi-zone in regions where available |
| `Cross-region HA/DR` | User-managed replications to another instance | User-managed replications to another instance |
| `Database recovery API` | No | Yes<br>(within 48 hours) |
| `Backups`<br>(Self-managed) | Self-managed with couchbackup | Self-managed with couchbackup |
| `Instance Reclamation` | {{site.data.keyword.cloud_notm}} 7-day reclamation<br>(instance-level deletions) | IBM Cloud 7-day reclamation<br>(instance-level deletions) |
{: caption="Table 4. HA, DR, and backup" caption-side="top"}

## Security
{: #security-feature-compare}

| Feature | {{site.data.keyword.cloudant_short_notm}}<br>"Classic"<br>(Multi-tenant) | {{site.data.keyword.cloudant_short_notm}}<br>"Classic"<br>(Dedicated Hardware) | {{site.data.keyword.cloudant_short_notm}} on Transaction Engine |
|---------|----------|--------------------------|-------------------------------|
| `Locations/Data Sovereignty` | Dallas<br>Washington DC<br>London<br>Frankfurt<br>Sydney<br>Tokyo<br>Chennai<br>Seoul | Dallas<br>Washington DC<br>London<br>Frankfurt<br>Sydney<br>Tokyo<br>Chennai<br>Seoul<br>Amsterdam<br>Hong Kong<br>Milan<br>Montreal<br>Oslo<br>Paris<br>Queretaro<br>San Jose<br>Sao Paulo<br>Singapore<br>Toronto | Dallas |
| `Authentication` | Legacy and IAM | Legacy and IAM | IAM-only |
| `IP allow listing` | No | Yes | No |
| `Service Endpoints` | Public | Public and private | Public |
| `At-Rest Encryption`<br>(Key per data volume) | Yes | Yes | Yes |
| `Native In-Database Encryption`<br>(Key (DEK) per database) | No | No | Yes |
| `Data Value Encryption` | No | No | Yes |
| `BYOK with Key Protect` | No | Yes | No |
| `Bare Metal Isolation` | No | Yes | No |
{: caption="Table 5. Security" caption-side="top"}

## Compliance
{: #compliance-feature-compare}

| Feature | {{site.data.keyword.cloudant_short_notm}}<br>"Classic"<br>(Multi-tenant) | {{site.data.keyword.cloudant_short_notm}}<br>"Classic"<br>(Dedicated Hardware) | {{site.data.keyword.cloudant_short_notm}} on Transaction Engine |
|---------|----------|--------------------------|-------------------------------|
| `EU Supported` | Yes<br>Upon request | Yes<br>Upon request | No |
| `GDPR` | Yes | Yes | Yes |
| `HIPAA` | No | Yes | No |
| `ISO27001` | Yes | Yes | No |
| `PCI` | Yes | Yes | No |
| `SOC2 Type 2` | Yes | Yes | No |
{: caption="Table 6. Compliance" caption-side="top"}
