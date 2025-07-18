---

copyright:
  years: 2015, 2023
lastupdated: "2023-04-21"

keywords: standard plan, lite plan, dedicated hardware plan, request class, provisioned throughput capacity, consumption, capacity, monitor usage, data usage, size limits, locations, tenancy, authentication methods, high availability, disaster recovery, backup, support

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# Plans and provisioning
{: #ibm-cloud-public}

{{site.data.keyword.cloudantfull}} Standard is {{site.data.keyword.cloudant_short_notm}}'s most
feature-rich offering, receiving updates and new features first. Pricing is based on
provisioned throughput capacity that is allocated and data storage that is used, making it suitable for any
required load.
{: shortdesc}

The free [Lite plan](#lite-plan) includes a fixed amount of
throughput capacity and data for development and evaluation purposes. The paid [Standard plan](#standard-plan) offers configurable provisioned throughput
capacity and data storage pricing that scales as your application requirements
change.  An optional [Dedicated Hardware plan](#dedicated-hardware-plan) is also available for an
extra monthly fee to run one or more of your Standard plan instances
on a dedicated hardware environment. The dedicated hardware environment
is for your sole use. If a Dedicated Hardware plan instance is provisioned
within a US location, you can optionally select a [HIPAA](https://en.wikipedia.org/wiki/Health_Insurance_Portability_and_Accountability_Act){: external}
-compliant configuration.

## Plans
{: #plans-and-provisioning}

You can select which plan to use when you
[provision your {{site.data.keyword.cloudant_short_notm}} service instance](#provisioning-a-cloudant-nosql-db-instance-on-ibm-cloud). The available plans include Lite and Standard. When you select a plan, Capacity displays, and the Cost estimator shows the monthly charge for the selected plan. By default, the [Lite plan](#lite-plan) is selected. 

### Lite plan
{: #lite-plan}

The Lite plan is free, and is designed for development and evaluation purposes. All of {{site.data.keyword.cloudant_short_notm}}'s functions are included, but Lite plan instances have a fixed amount of provisioned throughput capacity and data storage. The provisioned throughput capacity is fixed at 20 reads per second, 10 writes per second, and 5 global queries per second, and data storage is capped at 1 GB.

Storage usage is checked daily. If you exceed your 1-GB storage limit, requests to the {{site.data.keyword.cloudant_short_notm}} instance receive a
402 status code with the following error message, *Account exceeded its data usage quota. An upgrade to a paid plan is required.* A banner also appears on the {{site.data.keyword.cloudant_short_notm}} Dashboard. You can still read and delete data. However, to write new data, you have two options. First, you can upgrade to a paid [Standard plan](#standard-plan), which removes the write limitation immediately. Alternatively, you can delete data so that your total storage falls under the 1-GB limit and wait until the next daily storage check runs for your instance to allow writes again.

If you want to store more than one GB of data, or be able to scale provisioned throughput capacity, move to the [Standard plan](#standard-plan).

You're limited to one {{site.data.keyword.cloudant_short_notm}} Lite plan instance per {{site.data.keyword.cloud_notm}} account. If you already have one Lite plan instance, you can't create a second Lite plan instance, or change a Standard plan instance to a Lite plan. If you try, you see the following message. *You can have only one instance of a Lite plan per service. To create a new instance, either delete your existing Lite plan instance or select a paid plan.*

### Standard plan
{: #standard-plan}

The {{site.data.keyword.cloudant_short_notm}} Standard plan is available to all paid {{site.data.keyword.cloud}} accounts, either as pay-as-you-go or subscription, and scales to meet the needs of your application. The Standard plan is priced based on two factors: the provisioned throughput capacity that is allocated, and the amount of data that is stored in the instance.

Pricing is pro-rated hourly with a starting provisioned throughput capacity of 100 reads per second, 50 writes per second, and 5 global queries per second. This rate is equal to a starting cost of USD $0.105 per hour. You can toggle the provisioned throughput capacity up or down by using the user interface or API. Toggle in increments of 100 reads per second, 50 writes per second, and 5 global queries per second. Costs are calculated for the provisioned throughput capacity that is allocated and not on the metered volume of requests. The Standard plan includes 20 GB of data storage. If you store more than 20 GB, you're charged a defined cost per GB per hour.

Refer to the {{site.data.keyword.cloud_notm}} Pricing Calculator in the dashboard for pricing at different capacities and currencies, and the [pricing](/docs/Cloudant?topic=Cloudant-pricing#pricing){: external} information for examples to estimate costs.

### Dedicated Hardware plan
{: #dedicated-hardware-plan}

An {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware plan instance is a bare metal {{site.data.keyword.cloudant_short_notm}} environment that is provisioned for the sole use of your {{site.data.keyword.cloudant_short_notm}} Standard plan instances. The {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware plan offers the following options:
- An {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware plan environment that can be provisioned in any [{{site.data.keyword.IBM}} global data center](https://www.ibm.com/cloud/data-centers/){: external}.
- This plan is necessary for HIPAA compliance and must be selected at provisioning time.
- Users can choose to bring-your-own-key (BYOK) with customer-managed encryption keys with {{site.data.keyword.IBM_notm}} Key Protect for all environments provisioned 1 January 2020 or later. {{site.data.keyword.cloudant_short_notm}} runs on encrypted disks, but to BYOK, the Dedicated Hardware plan is required. BYOK encryption details must be chosen at provisioning time, and the feature isn't available for already-provisioned Dedicated Hardware plan environments.
- All Standard plan instances that are deployed on Dedicated Hardware plan environments include both private (internal) endpoints and public endpoints in locations that support Cloud Service Endpoints (CSE). Using private endpoints allows customers to connect to an {{site.data.keyword.cloudant_short_notm}} instance through the internal {{site.data.keyword.cloud}} network to avoid upstream application traffic from going over the public network and incurring bandwidth charges. For more information, see [Cloud Service Endpoint documentation](/docs/account?topic=account-service-endpoints-overview){: external} for details about enabling Cloud Service Endpoints for your {{site.data.keyword.cloud}} account.
- Users of an {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware plan environment can employ IP allowlisting by contacting support. IP allowlisting configuration applies to all instances that are running on the environment. The public and private network allowlists can be managed independently, and the public allowlist can be set to block all traffic so that all traffic goes over the private endpoints.

You can provision one or more Standard plan instances on a single Dedicated Hardware environment. The Dedicated Hardware environment expands or contracts as needed based on the throughput capacity and data that is used by the Standard plan instances. An {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware plan instance has a fixed price that is an addition to the consumption pricing of any Standard plan instances deployed on it. Billing is prorated daily, with a 1-month minimum duration charged for the environment. Provisioning of an {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware plan is asynchronous and can take 5-7 business days. To create an {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware plan instance and provision a Standard plan instance on it, follow the [Creating and leveraging an {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware plan instance on {{site.data.keyword.cloud_notm}}](/docs/Cloudant?topic=Cloudant-creating-and-leveraging-an-ibm-cloudant-dedicated-hardware-plan-instance-on-ibm-cloud#creating-and-leveraging-an-ibm-cloudant-dedicated-hardware-plan-instance-on-ibm-cloud) tutorial.

The Dedicated Hardware plan isn't available to {{site.data.keyword.cloud_notm}} Dedicated customers. The Dedicated Hardware plan is only available to {{site.data.keyword.cloud_notm}} customers.
{: important}

## Request classes
{: #request-classes}

Throughput provision is identified and measured as one of the following types of request classes:

1.  *Reads*
    (formerly called lookups) which are described in this list.

    1. A read of a specific document, based on the `_id` of the document.

    2. A *partitioned* query,
        which is a request that is made to an {{site.data.keyword.cloudant_short_notm}}
        query endpoint within the `_partition` namespace in the request path,
        including the following types:
        -	Primary Index ([`_all_docs`](/apidocs/cloudant#postalldocs){: external})
        -	MapReduce View ([`_view`](/docs/Cloudant?topic=Cloudant-using-views#using-views))
        -	Search Index ([`_search`](/docs/Cloudant?topic=Cloudant-cloudant-search#queries))
        -	{{site.data.keyword.cloudant_short_notm}} Query ([`_find`](/apidocs/cloudant#postfind){: external})

        The number of read operations that are used by a partitioned query request varies depending on the results returned.
        {: tip}

2.  *Writes*,
    which are creation,
    modification,
    or deletion of individual documents.

3.  *Global Queries* to global indexes (formerly called queries),
        which are requests that are made to an {{site.data.keyword.cloudant_short_notm}}
        query endpoint **not** within the `_partition` namespace,
    including the following types:
	-	Primary Index ([`_all_docs`](/apidocs/cloudant#postalldocs){: external})
	-	MapReduce View ([`_view`](/docs/Cloudant?topic=Cloudant-using-views#using-views))
	-	Search Index ([`_search`](/docs/Cloudant?topic=Cloudant-cloudant-search#queries))
	-	{{site.data.keyword.cloudant_short_notm}} Query ([`_find`](/apidocs/cloudant#postfind){: external})

## Provisioned throughput capacity
{: #provisioned-throughput-capacity}

Throughput provision is identified and measured as a request class of the following
operation types: *Read*, *Write*, and *Global Query*.

The measurement of throughput is a simple count of the number of units of each request class,
per second,
where the second is a *sliding* window.

If your account exceeds the number of throughput units that are allotted for a request class, {{site.data.keyword.cloudant_short_notm}} rejects requests. The requests are rejected until the number of units of the request class within the sliding window no longer exceeds the number that is provisioned. It might help to think of the sliding 1-second window as being any consecutive period of 1,000 milliseconds.

For example, the Standard plan is provisioned for 200 reads per second. Your account might use a maximum of 200 reads during a consecutive period of 1,000 milliseconds (1 second). Subsequent reads that are made during the sliding 1,000-millisecond period
are rejected until the number of reads in that period drops to less than 200 again.

When a request is rejected because the number of a request class is exceeded,
applications receive a [`429` Too Many Requests](/apidocs/cloudant#list-of-http-codes){: external}
response.

Recent versions of the [supported client libraries](/docs/Cloudant?topic=Cloudant-client-libraries) help you handle a `429` response. For example,
the Java&trade; library generates a
[`TooManyRequestsException`](https://static.javadoc.io/com.cloudant/cloudant-client/2.5.1/com/cloudant/client/org/lightcouch/TooManyRequestsException.html){: external} response.

By default,
the supported client libraries don't automatically retry
a request when a `429` response is received.

It's better to ensure that your application handles `429` responses correctly.
The reason is that the number of retries is limited;
regularly transgressing the number of requests is a strong indicator
for moving to a different plan configuration.

If you're porting an existing application, it might not be able to handle a `429` response. As part of your migration verification, check that your application handles `429` responses correctly.
{: note}

In summary,
you must ensure that your application can handle a [`429`](/apidocs/cloudant#list-of-http-codes){: external} response correctly.

### Consumption of read operations by partitioned queries
{: #consumption-of-lookup-operations-by-partitioned-queries}

Partitioned query requests use a variable number of read operations
that depend on the results returned. Consumption is based on two axes:

1. The number of rows that are read from the index that is involved in the query.
2. The number of documents read from the database, if any, during the execution of the query.

There is a minimum cost of 1 read for all partition queries.
{: note}

#### View queries, search queries, and `_all_docs`
{: #view-queries-search-queries-all-docs}

Each block of 100 rows that are read from the index uses one read operation. In
addition, each document that is read from the database during execution of a query
uses one read unit.

The number of rows that are read from the index is the same as the number of results
returned. Documents are only read from the database when `include_docs=true` is
passed as a query string parameter during the query request.

You can see example costs in the following table:

| Number of results | Include documents | Total Read consumption | Consumption for rows read | Consumption for documents read |
|--------------|----------------|-------------|---------------------| --- |
| 199      | No     | **2** | 2 | 0 |
| 199      | Yes     | **201** | 2 | 199 |
| 301      | No     | **4** | 4 | 0 |
| 301      | Yes     | **305** | 4 | 301 |
{: caption="Example costs" caption-side="top"}

Reducing use of `include_docs=true` is key for reducing read consumption for
partitioned `_all_docs`, view, and search queries.

#### {{site.data.keyword.cloudant_short_notm}} Query
{: #cloudant-query-ibm-cloudant}

For {{site.data.keyword.cloudant_short_notm}} Query requests, the number of read operations used for index
rows read relates to the rows read from the underlying index. The rows are read before filtering
occurs based on parts of the selector that can't be satisfied by the index.
Therefore, these results mean that the rows read value, and consumed read units, can be
higher than the number of eventual results you receive.

In addition, {{site.data.keyword.cloudant_short_notm}} Query must read the document for every row that is returned by the
underlying index. This way, it can run further filtering that is required by the
selector and passed to the query.

| Number of results | Number of rows returned by index | Total Read consumption | Consumption for rows read | Consumption for documents read |
|--------------|----------------|-------------|---------------------|---|
| 5      | 199     | **201** | 2 | 199 |
| 199      | 199     | **201** | 2 | 199 |
| 5      | 301     | **305** | 4 | 301 |
| 301      | 301     | **305** | 4 | 301 |
{: caption="Read consumption" caption-side="top"}

Using appropriate indexes is key for reducing read consumption for partitioned
{{site.data.keyword.cloudant_short_notm}} Query queries.

### Consumption of read and write operations by replication
{: #consumption-of-read-and-write-operations-by-replication}

[Replication](/docs/Cloudant?topic=Cloudant-replication-guide) between two databases uses read capacity on the source database and write capacity on the target database. The replicator is aware of the rate limits in {{site.data.keyword.cloudant_short_notm}} and employs staggered retry logic when encountering `429` responses associated with reaching the provisioned throughput capacity limits set for the instance.

You can use the default parameters and replicate a database with a large backlog of documents. In that case, a single replication job uses close to 2500 - 3000 reads per second on the source database and a few writes per second on the target database. Users can reduce the approximate read throughput that is used by a replication job by adjusting the [performance-related options](/docs/Cloudant?topic=Cloudant-advanced-replication#performance-related-options) that are associated with [tuning replication speed](/docs/Cloudant?topic=Cloudant-replication-guide#tuning-replication-speed). The following table provides recommended options for users who want to reduce the read capacity used on the source database:

| `http_connections` | `worker_processes` | Approximate reads per second on source database |
|------------------|------------------|-------------------------------------|
| 2 | 1 | 200 |
| 6 | 2 | 1000 |
| 12 | 3 | 2000 |
| 20 | 4 | 3000 (This value is the default.) |
{: caption="Reduce read capacity" caption-side="top"}

### Viewing and changing capacity
{: #viewing-and-changing-capacity}

Managing the provisioned throughput capacity allocated to an instance can be done by using either the UI or API. Changes to the provisioned throughput capacity are only allowed by using the paid {{site.data.keyword.cloudant_short_notm}} Standard plan. Users of the free Lite plan have a fixed amount of provisioned throughput capacity but can use the Capacity UI to estimate costs for a capacity setting on the Standard plan.

#### UI - Resource Group
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

#### API
{: #api-ibm-cloud}

To use the API to view the current provisioned throughput capacity that is allocated or change the target-provisioned throughput capacity for an {{site.data.keyword.cloudant_short_notm}} instance, see the [Capacity API](/docs/Cloudant?topic=Cloudant-capacity) documentation.

The API syntax for changing the capacity is also shown in the **Increase capacity through API** tab on the Capacity page for instances that are deployed in a Resource Group.


### Monitoring usage
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

## Data usage
{: #data-usage}

The data storage that is measured for billable purposes for an {{site.data.keyword.cloudant_short_notm}} instance is inclusive of both JSON data, indexes, and attachments.

### Data storage included
{: #data-storage-included}

This value is the storage capacity that is included in the plan. The Lite plan has a hard limit of 1 GB allowed. The paid Standard plan includes 20 GB for free and any additional data that is stored is metered for billing.

### Data overage
{: #data-overage}

All Lite and Standard plans are monitored for disk space used. When you use more data than the
plan allocates, you can expect the conditions that are described in the following sections to apply:

#### Lite plan
{: #lite-plan-ibm-cloudant}

- Disk usage is capped on the Lite plan at 1 GB.
- After you reach the cap, you receive a warning on the {{site.data.keyword.cloudant_short_notm}} Dashboard and can't write new data. If you try to write new data, a `402: payment required` response occurs.
- To write new data, you must either upgrade to the Standard plan or delete data, and wait until the next check runs for your account to be reactivated.

#### Standard plan
{: #standard-plan-bluemix}

- If the account uses more than the 20 GB of storage that is included in the Standard plan, the excess is considered "disk overage". Overage causes the account to be billed at the indicated price for each extra GB used beyond the plan allocation.
- The cost for the amount of disk overage is calculated on an hourly basis.

For example, assume your Standard plan increases disk usage to 107 GB for half a day (12 hours). This change means that your instance caused overflow of 87 GB more than the 20 GB plan allocation, for 12 hours.
As the result, you're billed an overage charge based on 87 GB x 12 hours = 1044 GB hours for that extra space.

Overage is calculated by using the maximum number of GB more than the plan allocation during a particular hour within the billing cycle.

### Disk overage example
{: #disk-overage-example}

Assume that you start a month of 30 days with a Standard plan service instance that uses 9 GB of storage.
Next,
your storage increases to 21.5 GB for 15 minutes during the hour beginning at 02:00 of day 3.
The instance drops back to 9.5 GB for the next 10 minutes of hour 02:00,
then increases to 108 GB for the next 25 minutes of hour 02:00.
Finally,
your instance finishes the hour and indeed the rest of the month by dropping down to 28 GB.

This pattern means the maximum number of GB more than the plan allocation was 88 GB during hour 2 of day 3.
From hour 03:00 of day 3,
and for the rest of the month,
your instance was 8 GB more than the plan allocation.

Therefore,
from hour 02:00 of day 3,
your bill includes an overage based on 88 GB x 1 hour = 88 GB hours.

From hour 03:00 of day 3 to the end of day 3,
your bill includes an overage based on 8 GB x 21 hours = 168 GB hours.

From hour 00:00 of day 4 until the end of the month (of 30 days), your bill includes an overage. The overage is based on 8 GB x 24 hours x 27 days = 5184 GB hours.

The total overage bill for the month is based on a total of 88 + 168 + 5184 = 5440 GB hours.

## Locations and tenancy
{: #locations-and-tenancy}

By default, all Lite and Standard plans are deployed on multi-tenant
environments. As part of your plan selection, you can choose from the
following {{site.data.keyword.cloud_notm}} locations.

-   Chennai (SZR)
-   Dallas
-   Frankfurt&Dagger;
-   London
-   Osaka
-   Sydney
-   Seoul (SZR)
-   Tokyo
-   Washington DC

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

## Authentication methods
{: #authentication-methods}

{{site.data.keyword.cloudant_short_notm}} is accessed by using an HTTPS API. Where the API endpoint requires it, the user is authenticated for every HTTPS request {{site.data.keyword.cloudant_short_notm}} receives. During provisioning, the available authentication methods include `Use both legacy credentials and IAM` or `Use only IAM`. For more information, see the [IAM guide](/docs/Cloudant?topic=Cloudant-managing-access-for-cloudant) or the legacy [Authentication API document](/docs/Cloudant?topic=Cloudant-work-with-your-account#authentication).

After you provision an {{site.data.keyword.cloudant_short_notm}} instance, the connection URL and IAM authorization details can be found when you generate new credentials in the Service Credentials tab of the {{site.data.keyword.cloud_notm}} Dashboard. For more information, see [Locating your service credentials](/docs/Cloudant?topic=Cloudant-locating-your-service-credentials). If you chose this option during provisioning, the {{site.data.keyword.cloudant_short_notm}} legacy username and password is also included.

The {{site.data.keyword.cloudant_short_notm}} team recommends you use IAM access controls for authentication whenever possible. If you're using {{site.data.keyword.cloudant_short_notm}} legacy authentication, the {{site.data.keyword.cloudant_short_notm}} team recommends that you use [API keys](/apidocs/cloudant#introduction){: external} rather than account-level credentials for programmatic access and replication jobs. 
{: important}

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

The support systems that are used for {{site.data.keyword.cloudant_short_notm}} don't offer features for the protection of personal data or sensitive personal data. This content includes Healthcare Information, health data, Protected Health Information, or data that is subject to more regulatory requirements. As such, the Client must not enter or provide such data.
{: note}

## Provisioning an {{site.data.keyword.cloudant_short_notm}} instance on {{site.data.keyword.cloud_notm}}
{: #provisioning-a-cloudant-nosql-db-instance-on-ibm-cloud}

You can provision an {{site.data.keyword.cloudant_short_notm}} Lite or Standard plan instance on {{site.data.keyword.cloud_notm}} in two ways by:

- Using the dashboard. For more information, see the [Creating an {{site.data.keyword.cloudant_short_notm}} instance on {{site.data.keyword.cloud_notm}}](/docs/Cloudant?topic=Cloudant-getting-started-with-cloudant){: external} tutorial that describes the process.
- Creating an {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware plan instance. For more information, see the [Creating and leveraging an {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware plan instance on {{site.data.keyword.cloud_notm}}](/docs/Cloudant?topic=Cloudant-creating-and-leveraging-an-ibm-cloudant-dedicated-hardware-plan-instance-on-ibm-cloud#creating-and-leveraging-an-ibm-cloudant-dedicated-hardware-plan-instance-on-ibm-cloud){: external} tutorial that describes the process.
