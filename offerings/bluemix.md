---

copyright:
  years: 2015, 2025
lastupdated: "2025-08-13"

keywords: standard plan, lite plan, dedicated hardware plan, request class, provisioned throughput capacity, consumption, capacity, monitor usage, data usage, size limits, locations, tenancy, authentication methods, high availability, disaster recovery, backup, support

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# Plans and provisioning
{: #ibm-cloud-public}

{{site.data.keyword.cloudantfull}} offers a range of plans to suit your
application needs. Evaluate {{site.data.keyword.cloudant_short_notm}} using the
free tier, then transition to our scalable, high-throughput production plans.
{: shortdesc}

## Plans
{: #plans-and-provisioning}

The available plans for {{site.data.keyword.cloudantfull}} are:

- **Lite Plan** – Free. Ideal for evaluation. Limited capacity and storage.
- **Standard Plan** – Scalable and suitable for production. Billed based on provisioned capacity and storage.
- **Dedicated Hardware Plan** – Private bare-metal environments with predicable performance to host your Standard plan instances. The plan features enhanced workload isolation, BYOK encryption, private networking, network allowlisting, and optional support for a [HIPAA](https://www.ibm.com/cloud/compliance/hipaa){: external}-compliant configuration.

You can select which plan to use when you
[provision your {{site.data.keyword.cloudant_short_notm}} service instance](#provisioning-a-cloudant-nosql-db-instance-on-ibm-cloud). When you select a plan, its capacity displays and the Cost Estimator shows the monthly charge for the selected plan. 

Refer to the {{site.data.keyword.cloud_notm}} Cost Estimator in the dashboard for charges at different capacities and currencies, and the [pricing](/docs/Cloudant?topic=Cloudant-pricing#pricing){: external} information for examples to estimate costs.

### Plan comparison: Lite vs. Standard

| Feature                          | **Lite Plan**                                         | **Standard Plan**                                      |
|----------------------------------|-------------------------------------------------------|--------------------------------------------------------|
| **Cost**                         | Free                                                  | Pay-as-you-go or subscription                          |
| **Use-case**                     | Evaluation and testing                      | Development and production workloads                                   |
| **Throughput capacity**          | Fixed: 20 reads/sec, 10 writes/sec, 5 global queries/sec     | Starts at 100 reads/sec, 50 writes/sec, 5 global queries/sec; scalable in [provisioned throughput capacity units](#provisioned-throughput-capacity-units)       |
| **Throughput scaling**                  | Not scalable                                          | Throughput scalable via UI or API                           |
| **Included storage**                | 1 GB                                                  | 20GB |
| **Extra storage**                | Unavailable                                                  | Charged per extra GB                   |
| **Instance limit**              | 1 Lite instance per IBM Cloud account                | Unlimited                                               |
| **Included features**            | All {{site.data.keyword.cloudant_short_notm}} features                                 | All {{site.data.keyword.cloudant_short_notm}} features                                  |
| **Billing frequency**            | Free                                                   | Hourly, prorated                                       |
| **Upgrade path**                 | Transparent upgrade to Standard plan to increase capacity/storage | Can scale up/down anytime                              |
{: caption="Summary of {{site.data.keyword.cloudantfull}} Lite and Standard plans" caption-side="top"}

### Dedicated Hardware plan
{: #dedicated-hardware-plan}

Use the Dedicated Hardware plan for your most critical workloads, to enhance security and performance consistency.

A {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware plan instance allows you to run your Standard plan instances on a private, isolated database cluster, ensuring no resource sharing with other customers.

The Dedicated Hardware plan provides your {{site.data.keyword.cloudant_short_notm}} instances with the following benefits:

- An {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware plan instance that can be provisioned in any [{{site.data.keyword.cloud_notm}} region](https://cloud.ibm.com/docs/overview?topic=overview-locations){: external}.
- Improved consistency of performance as resources are not shared with other customers.
- Standard instances on this plan can be used for workloads requiring HIPAA. Be sure to select the HIPAA option during provisioning of the Dedicated Hardware plan.
- The plan supports bring-your-own-key (BYOK). While all Cloudant instances use encryption for data at rest, the Dedicated Hardware plan enables you to bring your own keys using {{site.data.keyword.IBM_notm}} Key Protect. BYOK keys must be chosen during provisioning, and cannot be changed after provisioning is completed.
- Private networking is included. This allows for applications to avoid internet data transit and egress bandwidth charges. Private networking requires that your {{site.data.keyword.cloud}} is enabled for [Cloud Service Endpoints](/docs/account?topic=account-service-endpoints-overview){: external}.
- IP allowlisting is configurable. Once a Dedicated Hardware plan instance is provisioned, users can contact {{site.data.keyword.cloudant_short_notm}} support to enable this feature. It is possible to use this feature to restrict access to the private network only.

A Dedicated Hardware plan instance can take up to 7 business days to provision. Once it is provisioned, you can select the Dedicated Hardware plan to host Standard plan instances. For more detailed instructions, see the [Using a Dedicated Hardware plan instance](/docs/Cloudant?topic=Cloudant-creating-and-leveraging-an-ibm-cloudant-dedicated-hardware-plan-instance-on-ibm-cloud) tutorial.

## Provisioning a {{site.data.keyword.cloudant_short_notm}} instance
{: #provisioning-a-cloudant-nosql-db-instance-on-ibm-cloud}

Refer to [Getting started](/docs/Cloudant?topic=Cloudant-getting-started-with-cloudant) for provisioning instructions.

## Calculating data usage for Lite and Standard plans
{: #data-usage}

The data storage that is measured for billable purposes for a {{site.data.keyword.cloudant_short_notm}} instance includes JSON data, secondary indexes, and attachments. While Cloudant stores replicates data for high availability, you are only charged as if there is a single copy of your data.

| **Data storage** | **Lite Plan**                                         | **Standard Plan**                                      |
|----------------------------------|-------------------------------------------------------|--------------------------------------------------------|
| **Included in plan**                | 1 GB                                                  | 20 GB included                   |
| **Extra storage**                | Unavailable                                                  | Charged per extra GB                   |
| **Write limit on overuse** | Yes (after 1 GB)                            | No                                         |
{: caption="Summary of data storage on {{site.data.keyword.cloudantfull}}" caption-side="top"}

### Lite plan behavior on reaching the data storage limit
{: #lite-plan-behavior-on-reaching-the-data-storage-limit}

Data usage is capped at 1GB on the Lite plan. When your {{site.data.keyword.cloudantfull}} Lite plan instance exceeds the 1GB storage limit:

- **Write operations are blocked**.
  - Attempts to write new data return a `402` error: *"Account exceeded its data usage quota. An upgrade to a paid plan is required."*
- Read and delete operations remain available, allowing you to access and reduce stored data.
- A dashboard banner alerts you to the overage.
- To restore write access, you can:
  - Upgrade to a Standard plan for immediate write access.
  - Delete data to reduce usage below 1 GB. Access will be restored within 24 hours.

### Charges for data in the Standard plan
{: #standard-plan-bluemix}

The Standard plan does not have limits on the amount of data stored. You are charged for storing data as follows:

- Data storage under 20GB is not charged for.
- Data storage over 20GB is charged for by the GB.
- The cost for the amount of data stored over 20GB is calculated on an hourly basis.

For example, if your Standard plan instance stores 107GB of data for an hour, you will be charged for storing 87GB of data during that hour (107GB minus 20GB). At the end of the billing period, every hour's data costs are totaled and you are billed for them. Data usage is measured once per hour.

## Provisioned throughput capacity units for Lite and Standard plans
{: #provisioned-throughput-capacity-units}

{{site.data.keyword.cloudant_short_notm}} throughput capacity is allocated to your instance using provisioned throughput capacity _units_. Each unit allows
your application to perform a number of database operations each second.

Database operations are split into several _request classes_: reads, writes and global queries. Each provisioned throughput capacity unit contains separate allowances for reads, writes and global queries. To make more requests to your instance, you increase the number of allocated units.

The number of requests of a given class is counted using a sliding window over the period of a second.

### Request classes
{: #request-classes}

The different request classes are as follows:

| **Request Class** | **Description** | **Examples / Notes** |
|-------------------|------------------|------------------------|
| **Reads** | Operations that retrieve data from the database. | <ul><li>Reading a document by `_id`</li><li>Reading multiple documents by `_id` ([`_bulk_get`][bulkget]{: external})</li><li>Partitioned queries using:<ul><li>Primary Index ([`_all_docs`][alldocs]{: external})</li><li>View ([`_view`][mrview])</li><li>Search ([`_search`][searchindex])</li><li>Cloudant Query ([`_find`][queryfind]{: external})</li></ul></li></ul> |
| **Writes** | Operations that create, update, or delete documents. | <ul><li>Creating a document</li><li>Updating a document</li><li>Deleting a document</li><li>Updating multiple documents ([`_bulk_docs`][bulkdocs]{: external})</li></ul> |
| **Global Queries** | Queries that access global indexes (not partition-specific). | <ul><li>Global queries using:<ul><li>Primary Index ([`_all_docs`][alldocs]{: external})</li><li>View ([`_view`][mrview])</li><li>Search ([`_search`][searchindex])</li><li>Cloudant Query ([`_find`][queryfind]{: external})</li></ul></li></ul> |

[alldocs]: /apidocs/cloudant#postalldocs
[mrview]: /docs/Cloudant?topic=Cloudant-using-views#using-views
[searchindex]: /docs/Cloudant?topic=Cloudant-cloudant-search#queries
[queryfind]: /apidocs/cloudant#postfind
[bulkdocs]: /apidocs/cloudant#postbulkdocs
[bulkget]: /apidocs/cloudant#postbulkget

The number of read and write operations that are used by partition-scoped query
requests, bulk document reads and bulk document writes varies depending on the
number of documents processed.

For any HTTP request to {{site.data.keyword.cloudant_short_notm}}, you can check the `X-Cloudant-Request-Class`
[response header](/apidocs/cloudant?code=go#response-headers) to see the class
of the request.
{: tip}

## Provisioned throughput capacity and 429 HTTP responses

When your application exceeds the number of requests allowed by the amount of provisioned throughput units allocated to your instance, {{site.data.keyword.cloudant_short_notm}} rejects requests.

Request usage is measured per request class over a sliding 1 second window. Each
request class is measured separately. For example, if you exceed your global
query allowance, writes and reads can still continue. Once your application
reduces the number of requests it is making, new requests will be allowed within
a few seconds.

When a request is rejected, your application receives a HTTP [`429` Too Many Requests](/apidocs/cloudant#list-of-http-codes){: external} response with a description of the error.

If your application regularly receives `429` responses, consider increasing the number of provisioned throughput capacity units allocated to your instance.

{{site.data.keyword.cloudant_short_notm}} provides metrics for your instance's number of `429` responses in [IBM Cloud Monitoring](/docs/Cloudant?topic=Cloudant-monitor-ibm-cloud-pm). {{site.data.keyword.cloudant_short_notm}} recommend setting up alerts to ensure you are notified when your application receives sustained `429` responses.
{: tip}

### 429 support in client libraries

{{site.data.keyword.cloudant_short_notm}}'s [supported client libraries](/docs/Cloudant?topic=Cloudant-client-libraries) help you handle a `429` response. See each library's documentation for their behavior when receiving `429` responses.

By default, the supported client libraries don't automatically retry
a request when a `429` response is received.

If you're porting an existing application, it might not be able to handle a `429` response. As part of your migration verification, check that your application handles `429` responses correctly.

## Consumption of read operations by partition-scoped queries
{: #consumption-of-lookup-operations-by-partitioned-queries}

Partition-scoped queries consume provisioned throughput capacity differently to
global queries. Read this section to understand how.

While global queries consume a single operation using the _global query_ request class, partition-scoped requests use a variable number of _read_ operations. The number of read requests consumed depends on the results that are returned.

Two things consume read operations:

1. The number of rows that are read from the index that is involved in the query.
2. The number of documents read from the database, if any, during the execution of the query.

There is a minimum cost of 1 read for all partition queries.
{: note}

### View queries, search queries, and `_all_docs`
{: #view-queries-search-queries-all-docs}

Read consumption is easier to calculate for these types of queries. This is
because you control whether documents are read from the database by using the
`include_docs` query parameter. Requests that do not include documents in their
responses consume fewer reads.

- Reading up to 100 rows from the index consumes 1 read operation.
- If using `include_docs=true`, reading 1 document from the database consumes 1 read operation.

For these types of queries, the number rows read from the index is the same as the number of results returned.

You can see example costs in the following table:

| Number of results | Include documents | Total Read consumption | Consumption for rows read | Consumption for documents read |
|--------------|----------------|-------------|---------------------| --- |
| 25   | No     | **1** | 1 | 0 |
| 25   | Yes    | **26** | 1 | 25 |
| 1500 | No     | **15** | 15 | 0 |
| 1500 | Yes    | **1515** | 15 | 1500 |
{: caption="Example costs" caption-side="top"}

Reducing use of `include_docs=true` is key for reducing read consumption for
partitioned `_all_docs`, view, and search queries.

### {{site.data.keyword.cloudant_short_notm}} Query
{: #cloudant-query-ibm-cloudant}

To calculate the read consumption for {{site.data.keyword.cloudant_short_notm}}
Query, first we must understand that each
{{site.data.keyword.cloudant_short_notm}} Query request is processed in two
stages:

1. Select a suitable index to use for the request based on the fields in the selector. Read the index to obtain a set of documents that _may_ match the selector.
2. Read each of this set of documents and perform a second match against the selector. Discard the documents that do not match the selector. Return the remainder to the client.

The cost is calculated as follows:

- Reading up to 100 rows from the index in step 1 costs 1 read operation.
- _Regardless of whether it is returned in the result set_, each document read during step 2 consumes 1 read operation.

| Number of results | Number of rows returned by index | Total Read consumption | Consumption for rows read | Consumption for documents read |
|--------------|----------------|-------------|---------------------|---|
| 5      | 250 | **253** | 3 | 250 |
| 250 | 250 | **253** | 3 | 250 |
{: caption="Read consumption" caption-side="top"}

For cost-efficient use of partition-scoped {{site.data.keyword.cloudant_short_notm}} Query, you must take care to create indexes that reduce the number of documents read for a query. The [`_explain` endpoint for partition-scoped queries](/apidocs/cloudant#postpartitionexplain-partitioned-databases) provides detailed execution plans to help you with this task.
{: tip}

## Consumption of read and write operations by replication
{: #consumption-of-read-and-write-operations-by-replication}

[Replication](/docs/Cloudant?topic=Cloudant-replication-guide) between two databases uses read capacity on the source database and write capacity on the target database. The replicator is aware of the rate limits in {{site.data.keyword.cloudant_short_notm}} and employs staggered retry logic when encountering `429` responses associated with reaching the provisioned throughput capacity limits set for the instance.

You can use the default parameters and replicate a database with a large backlog of documents. In that case, a single replication job uses close to 2500 - 3000 reads per second on the source database and a few writes per second on the target database.

Users can reduce the approximate read and write consumption of a replication job by adjusting the [performance-related options](/docs/Cloudant?topic=Cloudant-advanced-replication#performance-related-options) that are associated with [tuning replication speed](/docs/Cloudant?topic=Cloudant-replication-guide#tuning-replication-speed). The following table provides recommended options for users who want to reduce the read capacity used on the source database:

| `http_connections` | `worker_processes` | Approximate reads per second on source database |
|------------------|------------------|-------------------------------------|
| 2 | 1 | 200 |
| 6 | 2 | 1000 |
| 12 | 3 | 2000 |
| 20 | 4 | 3000 (This value is the default.) |
{: caption="Reduce read and write consumption of replication" caption-side="top"}

## Viewing and changing capacity
{: #viewing-and-changing-capacity}

Managing the provisioned throughput capacity allocated to an instance can be done by using either the UI or API. Changes to the provisioned throughput capacity are only allowed by using the {{site.data.keyword.cloudant_short_notm}} Standard plan. Users of the free Lite plan have a fixed amount of provisioned throughput capacity but can use the Capacity UI to estimate costs for a capacity setting on the Standard plan.

### UI - Resource Group
{: #ui-resource-group}

If the {{site.data.keyword.cloudant_short_notm}} instance is deployed in a **Resource Group**, you can change the capacity by following these instructions. 

1.  Log in to the {{site.data.keyword.cloud_notm}} Dashboard.
1.  Go to the Service Details page for the instance. 
1.  Click **Manage** > **Capacity** to view the current and target capacity.  

    ![Capacity window shows current and target capacity.](../images/capacity-1.png){: caption="Capacity" caption-side="bottom"}

1.  To change the target capacity, slide the capacity slider to the setting you want. 
1.  Click **Update to Standard Plan**. 
1.  Select the pricing plan that you want, and click **Save**. 
1.  Select the type of account that you're looking for by clicking **Go**.

    The checkmark turns yellow and says `Updating Capacity` until the target capacity is reached. Capacity changes are asynchronous. The time that is required to synchronize those changes depends on the size of the changes in capacity that were requested and the data that is stored in the instance. When the target capacity is reached, the following message appears, *Success. Your capacity will be updated shortly.*

Capacity increases made by using the {{site.data.keyword.cloud_notm}} Dashboard can be made up to 100 blocks of capacity. One hundred blocks of capacity equal 10,000 reads per second, 5,000 writes per second, and 500 global queries per second. If you require more capacity, see the `Need additional capacity?` tab on the Capacity page.
{: note}

### API
{: #api-ibm-cloud}

To use the API to view the current provisioned throughput capacity that is allocated or change the target-provisioned throughput capacity for an {{site.data.keyword.cloudant_short_notm}} instance, see the [Capacity API](/docs/Cloudant?topic=Cloudant-capacity) documentation.

The API syntax for changing the capacity is also shown in the **Increase capacity through API** tab on the Capacity page for instances that are deployed in a Resource Group.


## Monitoring usage
{: #monitoring-usage}

Information about your usage of provisioned throughput capacity is available in the {{site.data.keyword.cloudant_short_notm}} Dashboard Monitoring tab. The **Current Operations** tab shows recent consumption of [provisioned throughput capacity](#provisioned-throughput-capacity) by showing the number of requests that are broken down by reads, writes, and global queries. The dotted line represents the peak capacity that is allowed according to the provisioned throughput capacity set for the instance.   

*Current Operations* tab
- Shows recent consumption of [provisioned throughput capacity](#provisioned-throughput-capacity). 

- Shows the number of requests that are broken down by reads, writes, and global queries. 

- The peak capacity that is allowed according to the provisioned throughput capacity set for the instance is shown by a dotted line in the following screen capture.   

![Current Operations shows consumption of provisioned throughput capacity, number of requests that are broken down by reads, writes, and global queries. Peak capacity that is allowed according to the provisioned throughput capacity set for the instance.](../images/monitoring-current_operations.png){: caption="Monitoring - Current Operations" caption-side="bottom"}

*Denied Requests* tab
- Shows the number of requests that were denied in a given second.

- Shows the response, *429: too many requests.*

- Requests are denied because they exceed the provisioned throughput capacity that is allocated to the instance. The graphs are broken down by reads, writes, and global queries.

![Monitoring - Denied Requests shows the number of requests that were denied in a given second. Shows 429: too many requests. Requests are denied because they exceed the provisioned throughput capacity that is allocated to the instance.](../images/monitoring-denied_requests.png){: caption="Monitoring - Denied Requests" caption-side="bottom"}

Monitoring helps you recognize that a change to the provisioning in your plan might be advisable.
For example, if you frequently approach the maximum number of database reads, then you can modify the capacity for the instance through the [Capacity](#viewing-and-changing-capacity) UI.

## Locations and tenancy
{: #locations-and-tenancy}

By default, Lite and Standard plans are deployed on multi-tenant
environments. As part of your plan selection, you can choose from the
following {{site.data.keyword.cloud_notm}} locations:

- Chennai (SZR)
- Dallas
- Frankfurt&Dagger;
- London
- Osaka
- Sydney
- Seoul (SZR)
- Tokyo
- Washington DC

Single-Zone Region (SZR) means that only one availability zone is available in that location. All other locations are Multi-Zone Regions (MZR) and leverage three separate availability zones for instances that are deployed in those locations. For more information, see the [High availability (HA), disaster recovery (DR), and backup](/docs/Cloudant?topic=Cloudant-disaster-recovery-and-backup){: external} documentation.

Dedicated Hardware plan instances can be deployed in most
[{{site.data.keyword.IBM_notm}} data center locations](https://www.ibm.com/cloud/data-centers/){: external}.
See the drop-down menu in the {{site.data.keyword.cloud_notm}} catalog for an up-to-date list of available locations.

&Dagger;All {{site.data.keyword.cloudant_short_notm}} instances that are deployed from the
{{site.data.keyword.cloud_notm}} Frankfurt region
are deployed into EU-managed environments. Any {{site.data.keyword.cloudant_short_notm}}
account or API key that is generated
outside an EU-managed environment can't be granted access to an EU-managed
{{site.data.keyword.cloudant_short_notm}} instance. For more information, see [Enabling the EU Supported setting](/docs/account?topic=account-eu-hipaa-supported#bill_eusupported) for your {{site.data.keyword.cloud_notm}} account. 

## High availability, disaster recovery, and backup in a data center
{: #high-availability-disaster-recovery-and-backup-in-a-data-center}

To provide high availability (HA) and disaster recovery (DR) within a data center, all data is
stored in triplicate across three separate physical servers in a cluster. You can provision
accounts in multiple data centers, then use continuous data replication to provide HA/DR across
data centers. {{site.data.keyword.cloudant_short_notm}} data isn't automatically backed up, but supported tools are provided to handle backups. Review the
[Disaster recovery and backup guide](/docs/Cloudant?topic=Cloudant-disaster-recovery-and-backup)
to explore all HA, DR, and backup considerations to meet your application requirements.

## {{site.data.keyword.cloud_notm}} Support
{: #ibm-cloud-support}

Support for Standard and Dedicated plan service instances is optional.
Support is provided when you purchase *{{site.data.keyword.cloud_notm}} Standard Support*. Support isn't available for the Lite plan.

For more information, see the [{{site.data.keyword.cloud_notm}} Standard Support plans](https://www.ibm.com/cloud/support#944376){: external} and the [{{site.data.keyword.IBM_notm}} support guide](https://www.ibm.com/support/pages/node/733923){: external}.

The support systems that are used for {{site.data.keyword.cloudant_short_notm}} don't offer features for the protection of personal data or sensitive personal data. This content includes Healthcare Information, health data, Protected Health Information, or data that is subject to more regulatory requirements. As such, the Client must not enter or provide such data when interacting with {{site.data.keyword.cloudant_short_notm}} support.
{: note}
