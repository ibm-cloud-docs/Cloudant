---

copyright:
  years: 2020, 2022
lastupdated: "2022-08-22"

keywords: read, write, global query, throughput, operation type, event, reject request, retry, provision, capacity, provision throughput capacity calculated, exceed the provisioned throughput capacity limit

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# Provisioned throughput capacity model FAQ
{: #faq-provisioned-throughput-capacity-model}
{: faq}
{: support}

{{site.data.keyword.cloudantfull}} calculates your provisioned throughput capacity based on these operation types: *Read*, *Write*, and *Global Query*. 
{: shortdesc}

## How is provisioned throughput capacity calculated? 
{: #provisioned-throughput-capacity-calculated}
{: faq}

{{site.data.keyword.cloudant_short_notm}} calculates provisioned throughput capacity by totaling the usage for each request class per second, where 1 second is a sliding window. When an account exceeds the total number of a request class allotted by its plan, {{site.data.keyword.cloudant_short_notm}} rejects subsequent requests of that request class. No new requests are accepted until the usage of that request class inside the sliding window falls under the allowed limit. The sliding 1-second window is any consecutive period of 1,000 milliseconds.

For example, the Standard plan instance limits you to 200 reads per second. When you exceed 200 read requests, {{site.data.keyword.cloudant_short_notm}} rejects future read requests made during the sliding 1,000-millisecond window. Read requests resume when the number of read requests for that time period is less than 200.

Note that request class units do not necessarily have a one-to-one mapping with HTTP requests. A single HTTP request may consume multiple units of a request class or classes if for example it reads multiple documents or both reads and writes.

## What happens when I exceed the provisioned throughput capacity limit? 
{: #provisioned-throughput-capacity-exceed-limit}
{: faq}

When you exceed the number of allowed events, {{site.data.keyword.cloudant_short_notm}} generates a [*`429` Too Many Requests*](/apidocs/cloudant#list-of-http-codes){: external}
response. You must make sure ahead of time that your applications can handle `429` responses. 

If you use the most recent versions of the [client libraries](/docs/Cloudant?topic=Cloudant-client-libraries) that {{site.data.keyword.cloudant_short_notm}} supports, you can set up your applications to handle `429` responses. This step is important because most client libraries don't automatically attempt to retry a request when a `429` response occurs. You need to verify that your application handles `429` responses correctly because {{site.data.keyword.cloudant_short_notm}} limits the number of retries. Regularly exceeding the number of requests indicates that you need to move to a different plan. 
