---

copyright:
  years: 2015, 2023
lastupdated: "2023-03-07"

keywords: pricing examples, data usage, ibm cloud usage dashboard, data usage pricing

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# Pricing
{: #pricing}

{{site.data.keyword.cloudantfull}} is priced based on the provisioned throughput capacity that you allocate for your instance, and the amount of data storage consumed. With {{site.data.keyword.cloudant_short_notm}}, you can scale your provisioned throughput capacity up and down, and pay a pro-rated hourly rate. The provisioned throughput capacity is a reserved number of reads per second, writes per second, and global queries per second allocated to an instance. The throughput capacity setting is the maximum usage level for a given second. You can't exceed the reserved capacity for either reads, writes, or global queries. If you do, an HTTP 429 status code occurs that indicates the application is trying to exceed its provisioned throughput capacity allowance. {{site.data.keyword.cloudant_short_notm}} usage is billed hourly.
{: shortdesc}

The estimated monthly cost for a particular level of provisioned throughput and storage capacity can be determined by using the Cost Estimator on the [{{site.data.keyword.cloud}} Catalog page](https://cloud.ibm.com/catalog/services/cloudant) for {{site.data.keyword.cloudant_short_notm}}.

You can use the {{site.data.keyword.cloud_notm}} pricing calculator to see estimated costs in other currencies by clicking **Add to estimate** from the {{site.data.keyword.cloudant_short_notm}} catalog tile. Specify storage, capacity, and select the country whose currency you want to see. 

Click **Calculate cost** and **Save**. Now, click **Review estimate**. Expand the estimate to see more details. If you save multiple estimates, you can then click **Review estimate** and compare them.

You can launch the {{site.data.keyword.cloud_notm}} Dashboard. Click **Resource list** > **Services** > **your instance** > **Manage** > **Capacity** to view and change the provisioned throughput capacity, and see the hourly and approximate monthly costs.

## Changing Provisioned Throughput Capacity 
{: #pricing-examples}

Let's assume you're building a mobile app with {{site.data.keyword.cloudant_short_notm}} and don't yet know the capacity that you might need. In this case, the {{site.data.keyword.cloudant_short_notm}} team recommends that you start with the lowest provisioned throughput capacity and increase it as needed by your application's usage over time. {{site.data.keyword.cloudant_short_notm}} bills pro-rated hourly and changing the provisioned throughput capacity doesn't incur downtime. 

The minimum provisioned throughput capacity for the Standard plan is 100 reads per second, 50 writes per second, and 5 global queries per second. 
When you need to scale up (or down), you can scale in increments of these blocks of capacity. Assuming the instance has less than the 20 GB of storage that is included in the Standard plan, no storage costs are incurred. Go to the provisioned throughput capacity setting from the {{site.data.keyword.cloudant_short_notm}} Dashboard > **Account** > **Capacity** tab, which is shown in the following screen capture:

![The Account window contains the Capacity, Announcements, CORS, and Settings tabs.](../images/cloudant-dashboard.png){: caption="{{site.data.keyword.cloudant_short_notm}} Dashboard Capacity tab" caption-side="bottom"}

The capacity slider shows the hourly cost of the provisioned throughput capacity. The monthly amount is an estimate based on an average of 730 hours per month. The cost in any month can be slightly different depending on the number of hours in the month.

Reads, writes, and global queries can't be scaled independently. Use the slider to select the number of blocks of provisioned throughput capacity based on the maximum limit of either reads per second, writes per second, or global queries per second as required for your application. For example, if your application requires 1,000 reads per second, use the slider to select the capacity that offers 1,000 reads per second, 500 writes per second, and 50 global queries per second. Select this capacity even if you don't need the corresponding number of writes or global queries. 

## Data usage pricing
{: #data-usage-pricing}

What about pricing for data overage? How does that work?

| Plan | Storage included | Overage limit |
|-----|------------------|--------------|
| Lite | 1 GB |  Your account is blocked from writing new data until you delete enough data to be under the 1-GB limit, or upgrade to a higher plan. |
| Standard | 20 GB | Extra storage costs charged per GB per hour, for each GB over the included 20 GB. |
{: caption="Pricing for data overage" caption-side="top"}

## {{site.data.keyword.cloud_notm}} Usage Dashboard 
{: #usage-dashboard}

How does data populate the {{site.data.keyword.cloud_notm}} Usage Dashboard?

Current and historical usage bills can be seen in the {{site.data.keyword.cloud_notm}} Dashboard, under **Manage** > **Billing and usage** > **Usage**. This view shows the totals for usage that are accrued during a particular month at the service, plan, or instance level.  The Estimated Total reflects the bill so far for the month or for past complete months. It shows only the hourly costs that are accrued up to that point for the current month. 
