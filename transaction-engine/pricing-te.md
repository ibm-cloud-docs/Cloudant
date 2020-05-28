---

copyright:
  years: 2015, 2020
lastupdated: "2020-05-27"

keywords: pricing examples, data usage, ibm cloud usage dashboard

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

<!-- Acrolinx: 2020-03-18 -->

# Pricing
{: #pricing-te}

{{site.data.keyword.cloudantfull}} Standard on Transaction Engine plan is pro-rated hourly and priced based on two things:

1. The provisioned throughput capacity that you allocate for your instance.
2. The amount of data storage consumed.

## Provisioned Throughput Capacity

You can scale your provisioned throughput capacity up and down in granular blocks of 50 reads/sec and 50 writes/sec, and pay pro-rated hourly based on the peak capacity for the hour. The provisioned throughput capacity is based on read and write capacity, or in another words, the ability to do a certain amount of reads per second or writes per second. There is no separate global query capacity in the Standard on Transaction Engine plan as global queries are counted as reads. For each hour that an instance is provisioned, a certain amount of read capacity units and write capacity units will be submitted for usage.  So at the minimum capacity setting in a given hour, 50 Read Capacity Unit Hours and 50 Write Capacity Unit Hours will be submitted. Further accumulation of Capacity Unit Hours quantities will occur for each hour and quantity of capacity set. See the catalog for pricing for read and write Capacity.   

Read and write capacity can't be scaled independently. Use the slider to select the number of blocks of provisioned throughput capacity based on the maximum limit of either reads/sec or writes/sec required for your application. For example, if your application requires 1,000 reads per second, use the slider to select the capacity that offers 1,000 reads/sec and 1,000 writes/sec, even if you don't need the corresponding number of writes.

You can't exceed the reserved capacity for either reads or writes. If you do, an HTTP 429 status code occurs that indicates the application is trying to exceed its provisioned throughput capacity allowance.

Go to the {{site.data.keyword.cloud_notm}} Dashboard and select the instance, then select **Manage** > **Capacity** tab to view and change the provisioned throughput capacity, and see the hourly and approximate monthly costs for each setting. See an example slider in the following image:

![Capacity slider](../images/Manage_Capacity_Slider_TE.png){: caption="Figure 1. Capacity slider" caption-side="bottom"}


## Data Storage
{: #data-storage-te}

Data is metered and usage submitted hourly and based on the Gigabyte Hours metric. For each hour, only the storage used above the free allotment of 25GB will be submitted for usage. For example, if for a given hour there are 30GB of storage in the instance, then 5 Gigabyte Hours of storage usage will be submitted. Storage is inclusive of both the raw JSON document size as well as the size of the indexes in each database in the instance. See the catalog for pricing for storage.

## Pricing examples 
{: #pricing-examples-te}

Let's assume you're building a mobile app with {{site.data.keyword.cloudant_short_notm}} and don't yet know the capacity 
that you might need. In this case, we recommend that you start with the lowest provisioned throughput 
capacity and increase it as needed by your application's usage over time. {{site.data.keyword.cloudant_short_notm}} bills 
pro-rated hourly and changing the provisioned throughput capacity doesn't incur downtime. 

For the mobile app example, you start with the minimum provisioned throughput capacity for 
the Standard on Transaction Engine plan that is 50 reads/sec and 50 writes/sec. As shown in the catalog, a read capacity unit costs $0.00012/hour and a write capacity unit costs $0.00048/hour. A block of 50 reads/sec and 50 writes/sec of capacity costs 50 reads/sec * $0.00012/hour + 50 writes/sec * $0.00048/hour = $0.030/hour. When you need to scale up (or down), you 
can scale in increments of these blocks of capacity. Assuming the instance has less than 
the 25 GB of storage that is included in the Standard on Transaction Engine plan, no storage costs are incurred. 

See the following example equation: 

- $0.030 per hour \* 1 block (of 50 reads/sec and 50 writes/sec provisioned throughput capacity) \* 730 hours (approximate hours in a month)
- Total = $21.90

How do you estimate the total cost for provisioned throughput capacity per month of 1,000 reads/sec and 1,000 writes/sec?

- $0.030 per hour \* 20 blocks (of 50 reads/sec and 50 writes/sec provisioned throughput capacity) \* 730 hours (approximate hours in a month)
- Alternatively, the slider shows you the provisioned throughput capacity of 1000 reads/sec and 1000 writes/sec costs $0.600/hour \* 730 hours
- Total = $438.00

## Data usage pricing
{: #data-usage-pricing-te}

What about pricing for data overage? How does that work?

Plan | Storage Included | Overage Limit
-----|------------------|--------------
Standard on Transaction Engine | 25 GB | Additional storage costs $0.000342 per GB per hour, which is approximately $0.25/GB per month.

## {{site.data.keyword.cloud_notm}} Usage Dashboard 
{: #usage-dashboard-te}

How does data display in the {{site.data.keyword.cloud_notm}} Usage Dashboard?

Current and historical usage bills can be seen in the {{site.data.keyword.cloud_notm}} Dashboard, under **Manage** -> **Billing and usage** -> **Usage**. This view shows the totals for usage that are accrued during a particular month at the service, plan, or instance level. The Estimated Total reflects the bill so far for the month or for past complete months. It shows only the hourly costs that are accrued up to that point for the current month. By the end of the month, you see your total provisioned throughput capacity for the month reflected in the `Read Capacity Unit Hours` and `Write Capacity Unit Hours`. The `Gigabyte Hours` field shows only the storage that was billed for any hour the instance exceeded the free allotment of 25 GB.  

In the following example, a quantity of 0 Gigabyte Hours reflects that the instance never exceeded 25 GB for the month. Additionally, you will see the total accumulation of read capacity unit hours and write capacity unit hours submitted at that point in the month.  As an example, an instance with 100 read/sec and 100 writes/sec for a month with 730 hours would have 730,000 read capacity unit hours and 730,000 write capacity unit hours submitted by the end of the month.

![Usage example](../images/usage_te_example.png){: caption="Figure 2. Usage example" caption-side="bottom"}






