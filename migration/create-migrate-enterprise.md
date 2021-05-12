---

copyright:
  years: 2015, 2021
lastupdated: "2021-05-11"

keywords: lite plan, pricing plans, standard plan, enterprise plan

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
{:video: .video}

<!-- Acrolinx: 2021-04-14 -->

# Migrating an Enterprise plan to a Lite or Standard plan
{: #migrating-an-enterprise-plan-to-a-lite-or-standard-plan}

Migration from the Enterprise plans to {{site.data.keyword.cloudant_short_notm}} Lite or Standard plans includes these tasks, which are described in the following steps. 
{: shortdesc}

## Step 1. Sign up for {{site.data.keyword.cloud_notm}}
{: #step-1-sign-up-for-ibm-cloud}

1.  Go to the [{{site.data.keyword.cloud_notm}} dashboard](https://cloud.ibm.com/).
2. Authenticate with your user name and password. <br>The {{site.data.keyword.cloud_notm}} dashboard opens to the Resource list.

## Step 2. Create an {{site.data.keyword.cloudant_short_notm}} instance
{: #step-2-create-an-ibm-cloudant-instance}

1. Click `Create resource `.
2. Click `Databases` > `Cloudant`. <br>
   ![{{site.data.keyword.cloudant_short_notm}} dashboard](../tutorials/images/img0003.png){: caption="Figure 1. {{site.data.keyword.cloudant_short_notm}} dashboard" caption-side="bottom"}

  For more information, see the [Getting started](/docs/Cloudant?topic=Cloudant-getting-started-with-cloudant) tutorial.  

## Step 3. Find out whether your application is ready for {{site.data.keyword.cloudant_short_notm}}
{: #step-3-find-out-whether-your-application-is-ready-for-ibm-cloudant}

1. Revisit your application’s usage of {{site.data.keyword.cloudant_short_notm}} to make sure it is ready to handle the capacity limits of the Standard plan. <br>
  For more information, see [how the {{site.data.keyword.cloudant_short_notm}} API works](/docs/Cloudant?topic=Cloudant-ibm-cloud-public#provisioned-throughput-capacity). 
2. Verify that your application can handle a `429: too many requests` HTTP response. 
  
The following table provides more information about these HTTP responses:

HTTP response | Issue
--------------|--------
`429: too many requests` | Retrying requests that get a `429` response is acceptable for occasional traffic spikes that exceed your plan's capacity. If your application traffic is routinely generating `429` responses, you probably need to upgrade to a larger plan.
`413: request entity too large` | The maximum individual document size is 1 MB on {{site.data.keyword.cloudant_short_notm}}. You receive a `413` message if the limit is exceeded. For more information, see [request and document size limits](/docs/Cloudant?topic=Cloudant-ibm-cloud-public#request-and-document-size-limits). 
{: caption="Table 1. HTTP responses" caption-side="top"}

## Step 4. Migrate data from the old service to the new service 
{: #step-4-migrate-data-from-the-old-service-to-the-new-service}

1. Set up continuous replications from your existing service to your {{site.data.keyword.cloudant_short_notm}} account. <br><br>For more information, see the [Replication guide](/docs/Cloudant?topic=Cloudant-replication-api) and [Using {{site.data.keyword.cloudant_short_notm}}](/docs/Cloudant?topic=Cloudant-ibm-cloudant-basics) about how to set up and monitor replication tasks.
2. Alternatively, use the [`couchreplicate`](https://www.npmjs.com/package/couchreplicate){: new_window}{: external} tool to coordinate the transfer of data from one {{site.data.keyword.cloudant_short_notm}} account to another. 

The `couchreplicate` tool sets up multiple replication jobs between the source and target accounts, ensuring that only so many replication jobs proceed at one time. If you need to migrate hundreds of databases, then `couchreplicate` can help coordinate the replication jobs.
{: tip}

  ![`couchreplication` tool](../images/couchreplicate.mp4){: video controls loop}{: caption="Figure 2. Couchreplicate tool" caption-side="bottom"}

3. Verify that all your data replicates to the new service and that indexes are built.

## Step 5. Test your application
{: #step-5-testing}

1. Conduct load and functional testing on your application.
2. Ensure that no issues exist before you migrate to production.

## Step 6. Move to the new instance
{: #step-6-move-to-the-new-instance}

1. Update your application to use the new account URL and credentials for the {{site.data.keyword.cloudant_short_notm}} instance. 
2. (Optional) Go to the [Getting started tutorial](/docs/Cloudant?topic=Cloudant-getting-started-with-cloudant) to obtain the service credentials for your {{site.data.keyword.cloudant_short_notm}} instance.

## Step 7. Turn off the old service
{: #step-7-turn-off-the-old-service}

1. Verify that your application is fully migrated to the Lite or Standard instance.
2. Delete the old Enterprise plan instance from your {{site.data.keyword.cloud_notm}} console to ensure that you're no longer charged for the service.