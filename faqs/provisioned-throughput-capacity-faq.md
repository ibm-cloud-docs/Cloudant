---

copyright:
  years: 2020
lastupdated: "2020-01-30"

keywords: read, write, global query, throughput, operation type, event, reject request, retry, provision, capacity

subcollection: cloudant

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
{:faq: data-hd-content-type='faq'}

<!-- Acrolinx: 2019 -->

# Provisioned throughput capacity model FAQ
{: #faq-provisioned-throughput-capacity-model}

{{site.data.keyword.cloudantfull}} calculates your provisioned throughput capacity based on these operation types: *Read*, *Write*, and *Global Query*. 

## How is provisioned throughput capacity calculated? 
{: #provisioned-throughput-capacity-calculated}
{: faq}

{{site.data.keyword.cloudant_short_notm}} calculates provisioned throughput capacity by totaling the number of events for each operation type per second, where one second is a sliding window. When an account exceeds the total number of events allotted by its plan, {{site.data.keyword.cloudant_short_notm}} rejects all subsequent requests until the number of events inside the sliding window falls under the allowed limit. The sliding 1-second window is any consecutive period of 1,000 milliseconds.

For example, if you have a Standard plan instance, which limits you to 200 reads per second, when you reach 200 read events per second, {{site.data.keyword.cloudant_short_notm}} rejects any future read requests made during the sliding 1,000-millisecond window. Read events resume when the number of read events for that time period is less than 200. 

## What happens when I exceed the provisioned throughput capacity limit? 
{: #provisioned-throughput-capacity-exceed-limit}
{: faq}

When you exceed the number of allowed events, {{site.data.keyword.cloudant_short_notm}} generates a [*`429` Too Many Requests*](/docs/services/Cloudant?topic=cloudant-http#http-status-codes)
response. You must make sure ahead of time that your applications can handle `429` responses. 

If you use the most recent versions of the [client libraries](/docs/services/Cloudant?topic=cloudant-supported-client-libraries) that {{site.data.keyword.cloudant_short_notm}} supports, you can set up your applications to handle `429` responses. This step is important because most client libraries don't automatically attempt to retry a request when a `429` response occurs. You need to verify that your application handles `429` responses correctly because {{site.data.keyword.cloudant_short_notm}} limits the number of retries. Regularly exceeding the number of requests indicates that you need to move to a different plan. 

