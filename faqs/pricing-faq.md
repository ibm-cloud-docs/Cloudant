---

copyright:
  years: 2020
lastupdated: "2020-04-13"

keywords: capacity settings, capacity limit, exceed limit, usage data

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
{:support: data-reuse='support'}
{:faq: data-hd-content-type='faq'}

<!-- Acrolinx: 2020-02-13 -->

# Pricing FAQ
{: #faq-pricing}
{: faq}
{: support}

{{site.data.keyword.cloudantfull}} pricing is based on the provisioned throughput capacity that you set for your instance, and the amount of data storage you use. With {{site.data.keyword.cloudant_short_notm}}, you can increase or decrease your provisioned throughput capacity as needed, and pay pro-rated hourly. The provisioned throughput capacity is a reserved number of reads per second, writes per second, and global queries per second allocated to an instance. The throughput capacity setting is the maximum usage level for a given second.
{: shortdesc} 

For more information, see [{{site.data.keyword.cloudant_short_notm}} Pricing](/docs/services/Cloudant?topic=Cloudant-pricing).

## Can I change my capacity setting? 
{: #change-capacity}
{: faq}

You can change your provisioned throughput capacity and see your current capacity settings in the {{site.data.keyword.cloudant_short_notm}} Dashboard. Launch **{{site.data.keyword.cloudant_short_notm}} Dashboard** > **Account** > **Capacity** tab to view and change your provisioned throughput capacity and see the hourly and approximate monthly costs. You can also use the {{site.data.keyword.cloud}} pricing calculator to see estimates in other currencies.

## How do I know I exceeded the capacity limit that I set? 
{: #exceed-capacity}
{: faq}

The Lite plan includes 1 GB of storage. If you exceed the limit, {{site.data.keyword.cloudant_short_notm}} blocks your account from writing new data until you delete enough data to be under the 1-GB limit, or upgrade to a higher plan. 

The first 20 GB of storage comes free with the Standard plan. You can store as much data as you want. Any storage over the 20 GB limit costs $0.0014 per GB per hour, which is approximately $1/GB per month.

## Where can I see my usage data?
{: #see-usage-data}
{: faq}

You can see your current and historical usage bills in the {{site.data.keyword.cloud_notm}} Dashboard. Go to **Manage** > **Billing and usage** > **Usage**. Here you can see the total charges and usage for the month by service, plan, or instance. Only the hourly costs that are accrued for the current month and time are available. At the end of the month, you can see the average provisioned throughput capacity for each field: `LOOKUPS_PER_MONTH`, `WRITES_PER_MONTH`, and `QUERIES_PER_MONTH`.

