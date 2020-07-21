---

copyright:
  years: 2020
lastupdated: "2020-07-22"

keywords: 

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

<!-- Acrolinx: 2019-12-24 -->

# Feature comparison
{: #feature-comparison}

The following tables show the differences between {{site.data.keyword.cloudantfull}} "Classic" architecture and {{site.data.keyword.cloudant_short_notm}} on the new Transaction Engine architecture.

The comparison tables serve as a point-in-time comparison to aid in choosing between the two plans at provisioning time. Customers should choose the plan to meet the needs of their application. Certain additional new features will only delivered on {{site.data.keyword.cloudant_short_notm}} on Transaction Engine. For this reason, we recommend that you choose the {{site.data.keyword.cloudant_short_notm}} on Transaction Engine plan whenever possible.  
{: note}

The comparison tables break down the features into the following categories:

- Pricing
- Features and functions
- Limits
- HA, DR, and Backup
- Security
- Compliance

## Pricing
{: #pricing-feature-compare}

All prices are shown in USD. A capacity is the ability to perform one operation per second, for example, a `read capacity` is the ability to perform one read per second. 

| Feature | {{site.data.keyword.cloudant_short_notm}}<br>"Classic" | {{site.data.keyword.cloudant_short_notm}}<br>on Transaction Engine|
|---------|----------|--------------------------|
| Provisioned Throughput Capacity | Fixed ratio of:<br>100 reads/sec<br>50 writes/sec<br>5 global queries/sec | Fixed ratio of:<br>50 reads/sec<br>50 writes/sec |
| Read Capacity | $0.00034/hour<br>$0.25/month | $0.00012/hour<br>$0.0876/month |
| Write Capacity | $0.00068/hour<br>$0.50/month | $0.00048/hour<br>$0.3504/month |
| Global Query Capacity | $0.0068/hour<br>$5.00/month | Not applicable |
| Storage | $1/GB-month<br>20 GB included | $0.25/GB/month<br>25 GB included |
| Dedicated Hardware | $5000/month add-on | Not applicable |
| Bandwidth | Included | Included |
| Proration | Hourly<br>(Dedicated Hardware is daily.) | Hourly |
| Standard Plan Minimum Cost | ~$75/month | ~$22/month | 

## Features and functions
{: #features-and-functions}

| Feature | {{site.data.keyword.cloudant_short_notm}}<br>"Classic" | {{site.data.keyword.cloudant_short_notm}}<br>on Transaction Engine |
|---------|----------|--------------------------|
| Tenancy | Multi-tenant or Dedicated | Multi-tenant | 
| Conflicts | Quorum-based eventually consistent | No write conflicts in region | 
| Consistency | Eventually consistent | Doc Writes & Cloudant Query indexes are strongly consistent |
| Sharding | Choose at database creation time | Auto shard-splitting | 
| Authentication | Legacy & IAM | IAM-only |
| Replication | Yes | Yes, as source or target.<br>Mediator needs to be on a "Classic" instance. |
| Attachments | Yes | No |
| Global Queries | Yes | Yes |
| Partition Queries | Yes | No |
| Cloudant Query<br>(JSON type) | Yes | Yes |
| Cloudant Query<br>(text type) | Yes | No |
| MapReduce | Yes | Map-side JS functions<br>No reduces |
| Search | Yes | No |
| Geospatial | Yes | No |
| Logging with LogDNA | Yes | Yes |
| Activity Tracker with LogDNA | Yes | Yes |
| Monitoring with Sysdig | Yes | Yes |

## Limits
{: #limits-feature-compare}

| Feature | {{site.data.keyword.cloudant_short_notm}}<br>"Classic" | {{site.data.keyword.cloudant_short_notm}}<br>on Transaction Engine |
|---------|----------|--------------------------|
| Max Database Size | ~5TB | 100TB+ |
| Max Database Name Length | 238 bytes | 256 bytes | 
| Max Document Size | 1 MB | 1 MB | 
| Max Document ID Length | 7168 bytes | 512 bytes |
| Max Indexed Key Length | Not applicable | 8000 bytes |
| Max Indexed Value Length | Not applicable | 64000 bytes |
| Attachment Size | 10 MB | Not applicable |
| Request Size | 11 MB | 64 MB |
| Request Timeout | 60 s | 5 s |
| Max Docs in Bulk Doc Request | Not applicable | 2000 docs |
| Max Docs in Bulk Get Request | Not applicable | 2000 docs |
| Max Value for Skip Parameter | Not applicable | 2000 |
| Max Number of Keys to All Docs | Not applicable | 2000 |
| Max Queries in Queries Request | Not applicable | 2000 | 
| Results - MapReduce | Unlimited | 2000 |
| Results - Cloudant Query (json type) | Unlimited | 2000 | 

## HA, DR, and Backup
{: #hadr-feature-compare}

| Feature | {{site.data.keyword.cloudant_short_notm}}<br>"Classic"<br> | {{site.data.keyword.cloudant_short_notm}}<br>on Transaction Engine |
|---------|----------|-------------------------------|
| In-region HA/DR | Data automatically stored in triplicate<br>Leverage multi-zone in regions where available | Data automatically stored in triplicate<br>Leverage multi-zone in regions where available |
| Cross-region HA/DR | User-managed replications to another instance | User-managed replications to another instance |
| Database recovery API | No | Yes<br>within 48 hours |
| Backups (self-managed) | Self-managed with couchbackup | Self-managed with couchbackup |
| Instance Reclamation | {{site.data.keyword.cloud_notm}} 7 day reclamation<br>(instance-level deletions) | IBM Cloud 7 day reclamation<br>(instance-level deletions) |

## Security
{: #security-feature-compare}

| Feature | {{site.data.keyword.cloudant_short_notm}}<br>"Classic"<br>(Multi-tenant) | {{site.data.keyword.cloudant_short_notm}}<br>"Classic"<br>(Dedicated Hardware) | {{site.data.keyword.cloudant_short_notm}} on Transaction Engine |
|---------|----------|--------------------------|-------------------------------|
| Locations/Data Sovereignty | Dallas<br>Washington DC<br>London<br>Frankfurt<br>Sydney<br>Tokyo<br>Chennai<br>Seoul | Dallas<br>Washington DC<br>London<br>Frankfurt<br>Sydney<br>Tokyo<br>Chennai<br>Seoul<br>Amsterdam<br>Hong Kong<br>Melbourne<br>Milan<br>Montreal<br>Oslo<br>Paris<br>Queretaro<br>San Jose<br>Sao Paulo<br>Singapore<br>Toronto | Dallas |
| Authentication | Legacy & IAM | Legacy & IAM | IAM-only |
| IP allowlisting | No | Yes | No |
| Service Endpoints | Public | Public and private | Public |
| At-Rest Encryption<br>(Key per data volume) | Yes | Yes | Yes |
| Native In-Database Encryption<br>(Key (DEK) per database) | No | No | Yes |
| Data Value Encryption | No | No | Yes |
| BYOK with Key Protect | No | Yes | No |
| Bare Metal Isolation | No | Yes | No |

## Compliance
{: #compliance-feature-compare}

| Feature | {{site.data.keyword.cloudant_short_notm}}<br>"Classic"<br>(Multi-tenant) | {{site.data.keyword.cloudant_short_notm}}<br>"Classic"<br>(Dedicated Hardware) | {{site.data.keyword.cloudant_short_notm}}<br>on Transaction Engine |
|---------|----------|--------------------------|-------------------------------|
| EU Supported | Yes<br>Upon request | Yes<br>Upon request | No |
| GDPR | Yes | Yes | Yes |
| HIPAA | No | Yes | No |
| ISO27001 | Yes | Yes | No |
| PCI | Yes | Yes | No |
| SOC2 Type 2 | Yes | Yes | No |

