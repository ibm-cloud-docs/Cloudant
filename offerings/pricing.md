---

copyright:
  years: 2015, 2019
lastupdated: "2019-01-11"

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

<!-- Acrolinx: 2019-01-11 -->

# Pricing
{: #pricing}

{{site.data.keyword.cloudantfull}} is priced based on the provisioned throughput capacity you allocate for your instance, and the amount of data storage consumed. {{site.data.keyword.cloudant_short_notm}} allows you to scale your provisioned throughput capacity up and down, and pay pro-rated hourly. The provisioned throughput capacity is a reserved number of lookups per second, writes per second, and queries per second allocated to an instance. The throughput capacity setting is the maximum usage level for a given second. If you attempt to exceed the reserved capacity for either lookups, writes, or queries, you get an HTTP 429 status code that indicates the application is trying to exceed its provisioned throughput capacity allowance.

The following table shows example hourly pricing for a variety of provisioned throughput capacity settings. You can toggle the capacity in granular blocks of 100 lookups/sec, 50 writes/sec, and 5 queries/sec on an hourly basis. An approximate monthly cost is also shown for each setting assuming an average of 730 hours in a month. The prices shown are in USD. You can use the {{site.data.keyword.cloud_notm}} pricing calculator to see estimated costs in other currencies by clicking on the `Add to estimate` button from the {{site.data.keyword.cloudant_short_notm}} catalog tile.

![pricing spreadsheet](../images/pricing_spreadsheet.png)

You can launch the {{site.data.keyword.cloudant_short_notm}} **Dashboard** > **Account** > **Capacity** tab to view and change the provisioned throughput capacity and see the hourly and approximate monthly costs: 

![slider](../images/migrate2.gif)

## Pricing Examples 
{: #pricing-examples}

Let's assume you are building a mobile app with {{site.data.keyword.cloudant_short_notm}} and do not yet know the capacity 
that you might need. In this case, we recommend that you start with the lowest provisioned throughput 
capacity and increase it as needed by your application's usage over time. {{site.data.keyword.cloudant_short_notm}} bills 
pro-rated hourly and changing the provisioned throughput capacity does not incur downtime. 

For the mobile app example, you start with the minimum provisioned throughput capacity for 
the Standard plan that is 100 lookups/sec, 50 writes/sec, and 5 queries/sec. The cost for 
this capacity is $0.105 per hour. The 100 lookups/sec, 50 writes/sec, and 5 queries/sec are 
a block of provisioned throughput capacity. When you need to scale up (or down), you 
can scale in increments of these blocks of capacity. Assuming the instance has less than 
the 20 GB of storage that is included in the Standard plan, no storage costs are incurred. On the 
{{site.data.keyword.cloudant_short_notm}} Dashboard's > Account > Capacity tab, the 
provisioned throughput capacity setting looks like this screen capture:

![{{site.data.keyword.cloudant_short_notm}} Dashboard Capacity tab](../images/cloudant-dashboard.png)

The capacity slider shows the hourly cost of the provisioned throughput capacity of 100 lookups/sec, 50 writes/sec, and 5 queries/sec in USD of $0.105/hour. The slider shows a rough cost per month of $76.65. The monthly amount is an estimate based on an average of 730 hours per month. The cost in any month can be slightly different depending on the number of hours in the month.

Example equation: 

- $0.105 per hour "*" 1 block (of 100 lookups/sec, 50 writes/sec, and 5 queries/sec provisioned throughput capacity) "*" 730 hours (approximate hours in a month)
- Total = $76.65

Lookups, writes, and queries cannot be scaled independently. Use the slider to select the number of blocks of provisioned throughput capacity based on the maximum limit of either lookups/sec, writes/sec, or queries/sec required for your application. For example, if your application requires 1,000 lookups per second, use the slider to select the capacity that offers 1,000 lookups/sec, 500 writes/sec, and 50 queries/sec, even if you do not need the corresponding number of writes or queries.

![{{site.data.keyword.cloudant_short_notm}} Dashboard Capacity tab with more capacity selected](../images/cloudant-gran-tuning.png)

How do you estimate the total cost for provisioned throughput capacity per month of 1,000 lookups, 500 writes, and 50 queries? 

- $0.105 per hour "*" 10 blocks (of 100 lookups/sec, 50 writes/sec, and 5 queries/sec provisioned throughput capacity) "*" 730 hours (approximate hours in a month)
- Alternatively the slider shows you the provisioned throughput capacity of 1000 lookups/sec, 500 writes/sec, and 50 queries/sec costs $1.050/hour "*" 730 hours
- Total = $766.50

## Data Usage 
{: #data-usage}

What about pricing for data overage, how does that work?

Plan | Storage included | Overage limit
-----|------------------|--------------
Lite | 1 GB |  Your account is blocked from writing new data until you delete enough data to be under the 1-GB limit, or upgrade to a higher plan.
Standard | 20 GB | Additional storage costs $0.0014 per GB per hour, which is approximately $1/GB per month.

## {{site.data.keyword.cloud_notm}} Usage Dashboard 
{: #usage-dashboard}

How does data display in the {{site.data.keyword.cloud_notm}} Usage Dashboard?

This view shows the totals for usage that are accrued during this month.  The Estimated Total reflects the bill so far for the month. It will only show the hourly costs accrued up to that point. By the end of the month, you see your average provisioned throughput capacity for the month reflected in the `LOOKUPS_PER_MONTH`, `WRITES_PER_MONTH` and `QUERIES_PER_MONTH` fields. The `STORAGE_MANAGED_PER_MONTH` field shows only the storage charged and doesn't include the 20 GB that are included in the Standard plan. In the following example, a quantity of 20+ GB reflects that there was an average of 40 GB of data in the instance for the month. When you use less than 20 GB of storage, the display shows 0 GB since you did not go over the limit.   

![{{site.data.keyword.cloudant_short_notm}} Dashboard usage metrics view with higher STORAGE MANAGED PER MONTH](../images/usage-dashboard1.png)


