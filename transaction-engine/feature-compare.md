---

copyright:
  years: 2020, 2022
lastupdated: "2022-03-17"

keywords: feature compare, pricing, features, functions, HA, DR, backup, compliance, security, limits, architecture

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# Feature comparison
{: #feature-comparison}

The {{site.data.keyword.cloudant_short_notm}} on Transaction Engine service ends on 1 February 2023. You can no longer create new instances of {{site.data.keyword.cloudant_short_notm}} on Transaction Engine. On 1 February 2023, all instances of {{site.data.keyword.cloudant_short_notm}} on Transaction Engine will be permanently disabled and deprovisioned. Users of existing instances need to migrate from the service before the end of service date. You can find guidance on migrating from {{site.data.keyword.cloudant_short_notm}} on Transaction Engine to {{site.data.keyword.cloudant_short_notm}} Standard here: [Migrating from TXE](https://blog.cloudant.com/2022/01/14/Migrating-from-Cloudant-TXE-to-Standard ){: external}.
{: important}

The following tables show the differences between {{site.data.keyword.cloudantfull}} *Classic* architecture and {{site.data.keyword.cloudant_short_notm}} on the new Transaction Engine architecture.
{: shortdesc}

The comparison tables serve as a point-in-time comparison to aid in choosing between the two plans at provisioning time. Customers must choose the plan to meet the needs of their application. Certain new features were delivered only on {{site.data.keyword.cloudant_short_notm}} on Transaction Engine. For this reason, if possible, choose the {{site.data.keyword.cloudant_short_notm}} on Transaction Engine plan whenever possible.  
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

| Feature | {{site.data.keyword.cloudant_short_notm}}    "Classic" | {{site.data.keyword.cloudant_short_notm}} on Transaction Engine|
|---------|----------|--------------------------|
| `Provisioned Throughput Capacity` | Fixed ratio of    100 reads/sec    50 writes/sec    5 global queries/sec | Fixed ratio of    50 reads/sec    50 writes/sec |
| `Read Capacity` | $0.00034 per hour    $0.25 per month | $0.00012 per hour    $0.0876 per month |
| `Write Capacity` | $0.00068 per hour    $0.50 per month | $0.00048 per hour    $0.3504 per month |
| `Global Query Capacity` | $0.0068 per hour    $5.00 per month | Not applicable |
| `Storage` | $1 per GB per month    20 GB included | $0.25 per GB per month    25 GB included |
| `Dedicated Hardware` | $5000 per month add-on | Not applicable |
| `Bandwidth` | Included | Included |
| `Proration` | Hourly    (Dedicated Hardware is daily.) | Hourly |
| `Standard Plan Minimum Cost` | ~$75 per month | ~$22 per month | 
{: caption="Table 1. Pricing" caption-side="top"}

## Features and functions
{: #features-and-functions}

| Feature | {{site.data.keyword.cloudant_short_notm}}    "Classic" | {{site.data.keyword.cloudant_short_notm}} on Transaction Engine |
|---------|----------|--------------------------|
| `Tenancy` | Multi-tenant or Dedicated | Multi-tenant | 
| `Conflicts` | Quorum-based eventually consistent | No write conflicts in region. | 
| `Consistency` | Eventually consistent | Doc Writes & Cloudant Query indexes are consistent. |
| `Sharding` | Choose at database creation time. | Auto shard-splitting | 
| `Authentication` | Legacy and IAM | IAM-only |
| `Replication` | Yes | Yes |
| `Attachments` | Yes | No |
| `Global Queries` | Yes | Yes |
| `Partition Queries` | Yes | No |
| `Cloudant Query`    (JSON type) | Yes | Yes |
| `Cloudant Query`    (Text type) | Yes | No |
| `MapReduce` | Yes | Map-side JS functions and built-in reduce functions.    No custom JS reduces.    No common JS modules.  |
| `Search` | Yes | No |
| `Geospatial` | Yes | No |
| `Logging with {{site.data.keyword.loganalysisfull_notm}}` | Yes | Yes |
| `Activity Tracker with {{site.data.keyword.loganalysisfull_notm}}` | Yes | Yes |
| `Monitoring with {{site.data.keyword.mon_full_notm}}` | Yes | Yes |
| `Binding Cloud Foundry applications` | Yes | No  \n**Note**: If you attempt to bind a Cloud Foundry application from the {{site.data.keyword.cloud_notm}} dashboard to {{site.data.keyword.cloudant_short_notm}} on Transaction Engine, a `BXNUI0033E` error occurs. |
{: caption="Table 2. Features and functions" caption-side="top"}


## Limits
{: #limits-feature-compare}

| Feature | {{site.data.keyword.cloudant_short_notm}}    "Classic" | {{site.data.keyword.cloudant_short_notm}} on Transaction Engine |
|---------|----------|--------------------------|
| `Max Database Size` | ~5 TB | 100 TB+ |
| `Max Database Name Length` | 238 bytes | 256 bytes | 
| `Max Document Size` | 1 MB | 1 MB | 
| `Max Document ID Length` | 7168 bytes | 512 bytes |
| `Max Indexed Key Length` | Not applicable | 8,000 bytes |
| `Max Indexed Value Length` | Not applicable | 64,000 bytes |
| `Attachment Size` | 10 MB | Not applicable |
| `Request Size` | 11 MB | 64 MB |
| `Request Timeout` | 60 s | 5 s |
| `Max Docs in Bulk Doc Request` | Not applicable | 2,000 documents |
| `Max Docs in Bulk Get Request` | Not applicable | 2,000 documents |
| `Max Value for Skip Parameter` | Not applicable | 2,000 |
| `Max Number of Keys to All Docs` | Not applicable | 2,000 |
| `Max Queries in Queries Request` | Not applicable | 2,000 | 
| `Results - MapReduce` | Unlimited | 2,000 |
| `Results - Cloudant Query`    (JSON type) | Unlimited | 2,000 | 
{: caption="Table 3. Limits" caption-side="top"}

## HA, DR, and backup
{: #hadr-feature-compare}

| Feature | {{site.data.keyword.cloudant_short_notm}}    "Classic"     | {{site.data.keyword.cloudant_short_notm}} on Transaction Engine |
|---------|----------|-------------------------------|
| `In-region HA/DR` | Data automatically stored in triplicate.    Leverage multi-zone in regions where available. | Data automatically stored in triplicate.    Leverage multi-zone in regions where available. |
| `Cross-region HA/DR` | User-managed replications to another instance. | User-managed replications to another instance. |
| `Database recovery API` | No | Yes    (within 48 hours) |
| `Backups`    (Self-managed) | Self-managed with Couch backup. | Self-managed with Couch backup. |
| `Instance Reclamation` | {{site.data.keyword.cloud_notm}} 7-day reclamation    (instance-level deletions) | IBM Cloud 7-day reclamation    (instance-level deletions) |
{: caption="Table 4. HA, DR, and backup" caption-side="top"}

## Security
{: #security-feature-compare}

| Feature | {{site.data.keyword.cloudant_short_notm}}    "Classic"    (Multi-tenant) | {{site.data.keyword.cloudant_short_notm}}    "Classic"    (Dedicated Hardware) | {{site.data.keyword.cloudant_short_notm}} on Transaction Engine |
|---------|----------|--------------------------|-------------------------------|
| `Locations/Data Sovereignty` | Dallas    Washington DC    London    Frankfurt    Sydney    Tokyo    Chennai    Seoul | Dallas    Washington DC    London    Frankfurt    Sydney    Tokyo    Chennai    Seoul    Amsterdam    Hong Kong    Milan    Montreal    Oslo    Paris    Queretaro    San Jose    Sao Paulo    Singapore    Toronto | Dallas |
| `Authentication` | Legacy and IAM | Legacy and IAM | IAM-only |
| `IP allowlisting` | No | Yes | No |
| `Service Endpoints` | Public | Public and private | Public |
| `At-Rest Encryption`    (Key per data volume) | Yes | Yes | Yes |
| `Native In-Database Encryption`    (Key (DEK) per database) | No | No | Yes |
| `Data Value Encryption` | No | No | Yes |
| `BYOK with Key Protect` | No | Yes | No |
| `Bare Metal Isolation` | No | Yes | No |
{: caption="Table 5. Security" caption-side="top"}

## Compliance
{: #compliance-feature-compare}

| Feature | {{site.data.keyword.cloudant_short_notm}}    "Classic"    (Multi-tenant) | {{site.data.keyword.cloudant_short_notm}}    "Classic"    (Dedicated Hardware) | {{site.data.keyword.cloudant_short_notm}} on Transaction Engine |
|---------|----------|--------------------------|-------------------------------|
| `EU Supported` | Yes    Upon request | Yes    Upon request | No |
| `GDPR` | Yes | Yes | Yes |
| `HIPAA` | No | Yes | No |
| `ISO27001` | Yes | Yes | Yes |
| `PCI` | Yes | Yes | Yes |
| `SOC2 Type 2` | Yes | Yes | No |
{: caption="Table 6. Compliance" caption-side="top"}
