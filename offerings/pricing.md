---

copyright:
  years: 2015, 2018
lastupdated: "2018-04-24"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-02-23 -->

# Pricing

{{site.data.keyword.cloudantfull}} allows you to scale up and down your provisioned 
throughput capacity, which is a reserved number of lookups, writes, and queries each 
second allocated to an instance. The throughput capacity level is the maximum usage 
level and any attempt to exceed the reserved capacity will be met by a HTTP 429 status 
code that indicates that the application is trying to exceed its provisioned throughput 
capacity allowance.


## Pricing Examples 

Let's assume you are building a mobile app with {{site.data.keyword.cloudant_short_notm}} and do not yet know the 
capacity you need. In this case, we recommend starting with the lowest provisioned 
throughput capacity and increasing it as required by your application's usage over time. 
{{site.data.keyword.cloudant_short_notm}} bills pro-rated hourly and changing the provisioned throughput capacity does not 
incur downtime.  

For the mobile app example, you start with the minimum provisioned throughput capacity for the 
Standard plan which is 100 lookups/sec, 50 writes/sec, and 5 queries/sec. The cost for this 
capacity is $0.105 per hour. The 100 lookups/sec, 50 writes/sec, and 5 queries/sec are a block 
of provisioned throughput capacity, and when you need to scale up (or down), you can scale in 
increments of these blocks of capacity. Assuming the instance has less than the 20GB of storage 
included in the Standard plan, there are no storage costs. On the 
{{site.data.keyword.cloudant_short_notm}} Dashboard's > Account > Capacity tab, 
the provisioned throughput capacity setting looks like this:

Select your capacity screenshot

The capacity slider shows the hourly cost of the provisioned throughput capacity of 
100 lookups/sec, 50 writes/sec, and 5 queries/sec in USD of $0.105/hour and gives a rough 
cost per month of $76.65. The monthly amount is an estimate based on an average of 730 
hours per month. The cost in any given month will be slightly different depending 
on the number of hours in the month.

Lookups, writes and queries cannot be scaled independently. Use the slider to select the 
number of blocks of provisioned throughput capacity based on the upper limit of either 
lookups/sec, writes/sec, or queries/sec required for your application. For example, if your 
application requires 1,000 lookups per second, use the slider to select the capacity that 
offers 1,000 lookups/sec, 500 writes/sec, and 50 queries/sec, even if you do not need the 
corresponding number of writes or queries.

Select your capacity 1,000 screenshot

How do you estimate the total cost for provisioned throughput capacity per month of 
100 lookups, 50 writes, and 5 queries? Here are the details:

* $0.105 per hour * 1 block of 100 lookups/sec, 50 writes/sec, and 5 queries/sec 
provisioned throughput capacity * 730 hours (approximate hours in a month)
* Total = $76.65

What about 1,000 lookups, 500 writes, and 50 queries? Here are the details:

* $0.105 per hour * 10 blocks of 100 lookups/sec, 50 writes/sec, and 5 queries/sec 
provisioned throughput capacity * 730 hours (approximate hours in a month)
* Alternatively the slider will show you that the provisioned throughput capacity 
of 1000 lookups/sec, 500 writes/sec, and 50 queries/sec costs $1.050/hour * 730 hours
* Total = $766.50


## Data Usage START HERE

How does pricing work with data overages? See the details below: 

- For the Lite plan, 1 GB of storage is included. This is a cap, so if you go 
over that amount, your account is blocked from writing new data until 
you delete the data to under the 1 GB limit, or upgrade to a higher plan.
- For the Standard plan, 20 GB of storage is included. If you go over that 
amount, additional storage costs are $0.0014 per GB per hour, which is 
approximately $1/GB per month. 

On the {{site.data.keyword.cloud}} Usage Dashboard, the usage of storage displays above the 
20 GB limit that is included in the Standard plan, priced per GB/hour. When you are under 
20 GB of storage, the display shows 0 GB since you have not gone over the 
limit. 

What data displays in the {{site.data.keyword.cloud_notm}} Usage Dashboard

In the usage dashboard, you see the number of lookups, queries, and writes used, as 
well as the cost, for example:

IBM Cloud Usage dashboard screenshot

This view displays the usage accrued for the month, and only shows 
the cost for the month to date. The Estimated Total reflects the bill 
up to this date for this month. At the end of the month, you can see 
the average capacity for the month, which is your total monthly bill. 
The STORAGE_MANAGED_PER_MONTH field only shows the amount above the 20 GBs 
that are included. In the example above, there 
are approximately 40 GB of total data used in the account. 

