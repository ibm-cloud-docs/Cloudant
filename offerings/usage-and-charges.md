---

copyright:
  years: 2015, 2025
lastupdated: "2025-09-03"

keywords: standard plan, lite plan, request class, provisioned throughput capacity, consumption, capacity, monitor usage, data usage, size limits 

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# Usage and charges
{: #usage-and-charges}

{{site.data.keyword.cloudantfull}} uses data stored and provisioned throughput capacity based on request classes to measure and bill for usage. Read this page to learn how these are measured and how to estimate your usage.
{: shortdesc}

First, this page describes how data storage is measured in the
{{site.data.keyword.cloudant_short_notm}} Lite and Standard plans. Next,
it explains what provisioned throughput capacity is and how it is used by
your applications. By understanding these concepts, you can better estimate
{{site.data.keyword.cloudant_short_notm}} usage and charging for your needs.

## Estimating costs
{: #estimating-costs }

The estimated monthly cost for a particular level of provisioned throughput and storage capacity can be determined by using the Cost Estimator on the [{{site.data.keyword.cloud}} Catalog page](https://cloud.ibm.com/catalog/services/cloudant) for {{site.data.keyword.cloudant_short_notm}}.

You can use the {{site.data.keyword.cloud_notm}} Cost Estimator to see estimated costs in other currencies by clicking **Add to estimate** from the {{site.data.keyword.cloudant_short_notm}} catalog tile. Specify storage, capacity, and select the country whose currency you want to see. 

Click **Calculate cost** and **Save**. Now, click **Review estimate**. Expand the estimate to see more details. If you save multiple estimates, you can then click **Review estimate** and compare them.

You can launch the {{site.data.keyword.cloud_notm}} Dashboard. Click **Resource list** > **Services** > **your instance** > **Manage** > **Capacity** to view and change the provisioned throughput capacity, and see the hourly and approximate monthly costs.

## Calculating data usage for Lite and Standard plans
{: #data-usage}

The data storage that is measured for billable purposes for a {{site.data.keyword.cloudant_short_notm}} instance includes JSON data, secondary indexes, and attachments. While Cloudant stores replicates data for high availability, you are only charged as if there is a single copy of your data.

| **Data storage** | **Lite Plan**                                         | **Standard Plan**                                      |
|----------------------------------|-------------------------------------------------------|--------------------------------------------------------|
| **Included in plan**                | 1 GB                                                  | 20 GB |
| **Extra storage**                | Unavailable                                                  | Charged per GB                   |
| **Write limit on overuse** | Yes (after 1 GB)                            | No                                         |
{: caption="Summary of data storage on {{site.data.keyword.cloudantfull}}" caption-side="top"}

### Lite plan behavior on reaching the data storage limit
{: #lite-plan-behavior-on-reaching-the-data-storage-limit}

Data usage is capped at 1GB on the Lite plan. When your {{site.data.keyword.cloudantfull}} Lite plan instance exceeds the 1GB storage limit:

- **Operations to create and update documents are blocked**.
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

The current number of read, write and global query operations per provisioned throughput capacity unit is described in [Scaling provisioned throughput capacity](/docs/Cloudant?topic=Cloudant-usage-and-charges#scaling-provisioned-throughput-capacity)

### Request classes
{: #request-classes}

The different request classes are as follows:

| **Request Class** | **Description** | **Examples / Notes** |
|-------------------|------------------|------------------------|
| **Reads** | Operations that retrieve data from the database. | <ul><li>Reading a document by `_id`</li><li>Reading multiple documents by `_id` ([`_bulk_get`][bulkget]{: external})</li><li>Partition-scoped queries using:<ul><li>Primary Index ([`_all_docs`][palldocs]{: external})</li><li>View ([`_view`][pmrview]{: external})</li><li>Search ([`_search`][psearchindex]{: external})</li><li>Cloudant Query ([`_find`][pqueryfind]{: external})</li></ul></li></ul> |
| **Writes** | Operations that create, update, or delete documents. | <ul><li>Creating a document</li><li>Updating a document</li><li>Deleting a document</li><li>Updating multiple documents ([`_bulk_docs`][bulkdocs]{: external})</li></ul> |
| **Global Queries** | Queries that access global indexes (not partition-specific). | <ul><li>Global queries using:<ul><li>Primary Index ([`_all_docs`][galldocs]{: external})</li><li>View ([`_view`][gmrview]{: external})</li><li>Search ([`_search`][gsearchindex]{: external})</li><li>Cloudant Query ([`_find`][gqueryfind]{: external})</li></ul></li></ul> |

[galldocs]: /apidocs/cloudant#postalldocs
[gmrview]: /apidocs/cloudant#postview
[gsearchindex]: /apidocs/cloudant#postsearch
[gqueryfind]: /apidocs/cloudant#postfind
[palldocs]: /apidocs/cloudant#postpartitionalldocs
[pmrview]: /apidocs/cloudant#postpartitionview
[psearchindex]: /apidocs/cloudant#postpartitionsearch
[pqueryfind]: /apidocs/cloudant#postpartitionfind-partitioned-databases
[bulkdocs]: /apidocs/cloudant#postbulkdocs
[bulkget]: /apidocs/cloudant#postbulkget

The number of read and write operations that are used by partition-scoped query
requests, bulk document reads and bulk document writes varies depending on the
number of documents processed.

For any HTTP request to {{site.data.keyword.cloudant_short_notm}}, you can check the `X-Cloudant-Request-Class`
[response header](/apidocs/cloudant#response-headers) to see the class
of the request.
{: tip}

## Provisioned throughput capacity and 429 HTTP responses
{: #provisioned-throughput-capacity-and-429-http-responses}

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
{: #429-support-in-client-libraries}

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

This section describes the following partition-scoped endpoints:

- Primary Index ([`_all_docs`][palldocs]{: external})
- View ([`_view`][pmrview]{: external})
- Search ([`_search`][psearchindex]{: external})

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

This section describes the following partition-scoped endpoints:

- Cloudant Query ([`_find`][pqueryfind]{: external})

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

You can use the default parameters and replicate a database with a large backlog of documents. In that case, a single replication job uses up to 2500 - 3000 reads per second on the source database and a few writes per second on the target database.

You can reduce the approximate read and write consumption of a replication job by adjusting the [performance-related options](/docs/Cloudant?topic=Cloudant-advanced-replication#performance-related-options) that are associated with [tuning replication speed](/docs/Cloudant?topic=Cloudant-replication-guide#tuning-replication-speed). The following table provides recommended options for users who want to reduce the read capacity used on the source database:

| `http_connections` | `worker_processes` | Approximate maximum reads per second on source database |
|------------------|------------------|-------------------------------------|
| 2 | 1 | 200 |
| 6 | 2 | 1000 |
| 12 | 3 | 2000 |
| 20 | 4 | 3000 (This value is the default.) |
{: caption="Alter read and write consumption of replication" caption-side="top"}


## Scaling provisioned throughput capacity 
{: #scaling-provisioned-throughput-capacity}

If you're building an application with {{site.data.keyword.cloudant_short_notm}}
and aren't sure how much capacity you'll need, start with the lowest provisioned
throughput. You can scale up as your application grows. Pricing is pro-rated
hourly and there is no downtime during scaling, meaning that it is safe to
adjust your provisioned throughput capacity as often as needed.

Provisioned throughput capacity is adjusted in _units_ of:

- **Reads**: 100/sec  
- **Writes**: 50/sec  
- **Global queries**: 5/sec  

Reads, writes, and global queries scale together, not independently. Choose your capacity based on your highest requirement. For example, if your application requires 1,000 reads, 5 writes and 1 global query per second, you need to select the number of blocks providing 1,000 reads per second.

Capacity can be scaled using the {{site.data.keyword.cloud_notm}} Dashboard or API to 100 blocks of capacity. This capacity equals 10,000 reads per second, 5,000 writes per second, and 500 global queries per second. If you require more capacity, see the `Need additional capacity?` tab on the Capacity page.
{: note}

### Scaling using the {{site.data.keyword.cloud_notm}} dashboard 
{: #scaling-provisioned-throughput-dashboard}

You can change the capacity by following these instructions. 

1.  Log in to the {{site.data.keyword.cloud_notm}} Dashboard.
1.  Go to the Service Details page for the instance. 
1.  Click **Manage** > **Capacity** to view the current and target capacity.  

    ![Capacity window shows current and target capacity.](../images/capacity-1.png){: caption="Capacity" caption-side="bottom"}

1.  To change the target capacity, slide the capacity slider to the setting you want. 
1.  Click **Update to Standard Plan**. 
1.  Select the pricing plan that you want, and click **Save**. 
1.  Select the type of account that you're looking for by clicking **Go**.

    The checkmark turns yellow and says `Updating Capacity` until the target capacity is reached. Capacity changes are asynchronous. The time that is required to synchronize those changes depends on the size of the change in capacity that was requested and the data that is stored in the instance.

### Scaling using the API
{: #scaling-provisioned-throughput-api}

To use the API to view the current provisioned throughput capacity that is allocated or change the target-provisioned throughput capacity for an {{site.data.keyword.cloudant_short_notm}} instance, see the [Capacity API](/docs/Cloudant?topic=Cloudant-capacity) documentation.

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

## Viewing historical usage and charges 
{: #viewing-historical-usage-and-charges}

Current and historical usage bills can be seen in the {{site.data.keyword.cloud_notm}} Dashboard, under **Manage** > **Billing and usage** > **Usage**. This view shows the totals for usage that are accrued during a particular month at the service, plan, or instance level.  The Estimated Total reflects the bill so far for the month or for past complete months. It shows only the hourly costs that are accrued up to that point for the current month. 
