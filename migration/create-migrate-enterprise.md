---

copyright:
  years: 2015, 2023
lastupdated: "2023-04-06"

keywords: lite plan, pricing plans, standard plan, enterprise plan, sign up, test application, move to new instance

subcollection: Cloudant

content-type: tutorial
services: Cloudant
account-plan: lite
completion-time: 30m

---

{{site.data.keyword.attribute-definition-list}}

# Migrating an Enterprise plan to a Lite or Standard plan
{: #migrating-an-enterprise-plan-to-a-lite-or-standard-plan}
{: toc-content-type="tutorial"}
{: toc-services="Cloudant"}
{: toc-completion-time="30m"}

Migration from the Enterprise plans to {{site.data.keyword.cloudant_short_notm}} Lite or Standard plans includes these tasks, which are described in the following steps.
{: shortdesc}

## Sign up for {{site.data.keyword.cloud_notm}}
{: #step-1-sign-up-for-ibm-cloud}
{: step}

1.  Go to the [{{site.data.keyword.cloud_notm}} Dashboard](https://cloud.ibm.com/).
2. Authenticate with your username and password.  
   The {{site.data.keyword.cloud_notm}} Dashboard opens to the Resource list.

## Create an {{site.data.keyword.cloudant_short_notm}} instance
{: #step-2-create-an-ibm-cloudant-instance}
{: step}

1. Click `Create resource`.
2. Click `Databases` > `Cloudant`.  
   ![Select **Databases** > **Cloudant dashboard** as your instance.](../tutorials/images/img0003.png){: caption="{{site.data.keyword.cloudant_short_notm}} Dashboard" caption-side="bottom"}

   For more information, see the [Getting started](/docs/Cloudant?topic=Cloudant-getting-started-with-cloudant) tutorial.  

## Find out whether your application is ready for {{site.data.keyword.cloudant_short_notm}}
{: #step-3-find-out-whether-your-application-is-ready-for-ibm-cloudant}
{: step}

1. Revisit your application’s usage of {{site.data.keyword.cloudant_short_notm}} to make sure it is ready to handle the capacity limits of the Standard plan.
   For more information, see [how the {{site.data.keyword.cloudant_short_notm}} API works](/docs/Cloudant?topic=Cloudant-ibm-cloud-public#provisioned-throughput-capacity).
2. Verify that your application can handle a `429: too many requests` HTTP response.

The following table provides more information about these HTTP responses:

| HTTP response | Issue |
|--------------|--------|
| `429: too many requests` | Retrying requests that get a `429` response is acceptable for occasional traffic spikes that exceed your plan's capacity. If your application traffic is routinely generating `429` responses, you probably need to upgrade to a larger plan. |
| `413: request entity too large` | The maximum individual document size is 1 MB on {{site.data.keyword.cloudant_short_notm}}. You receive a `413` message if the limit is exceeded. For more information, see [request and document size limits](/docs/Cloudant?topic=Cloudant-ibm-cloud-public#request-and-document-size-limits). |
{: caption="HTTP responses" caption-side="top"}

## Migrate data from the old service to the new service 
{: #step-4-migrate-data-from-the-old-service-to-the-new-service}
{: step}

1. Set up continuous replications from your existing service to your {{site.data.keyword.cloudant_short_notm}} account.

   For more information, see the [Replication guide](/docs/Cloudant?topic=Cloudant-replication-api) and [Using {{site.data.keyword.cloudant_short_notm}}](/docs/Cloudant?topic=Cloudant-ibm-cloudant-basics) about how to set up and monitor replication tasks.

2. Alternatively, use the [`couchreplicate`](https://www.npmjs.com/package/couchreplicate){: external} tool to coordinate the transfer of data from one {{site.data.keyword.cloudant_short_notm}} account to another.

   The `couchreplicate` tool sets up multiple replication jobs between the source and target accounts, ensuring that only so many replication jobs proceed at one time. If you need to migrate hundreds of databases, then `couchreplicate` can help coordinate the replication jobs.
   {: tip}

   ![Couchreplicate tool](../images/couchreplicate.mp4){: video controls loop}

3. Verify that all your data replicates to the new service and that indexes are built.

## Test your application
{: #step-5-testing}
{: step}

1. Conduct load and functional testing on your application.
2. Ensure that no issues exist before you migrate to production.

## Move to the new instance
{: #step-6-move-to-the-new-instance}
{: step}

1. Update your application to use the new account URL and credentials for the {{site.data.keyword.cloudant_short_notm}} instance.
2. (Optional) Go to the [Getting started tutorial](/docs/Cloudant?topic=Cloudant-getting-started-with-cloudant#creating-service-credentials) to obtain the service credentials for your {{site.data.keyword.cloudant_short_notm}} instance.

## Turn off the old service
{: #step-7-turn-off-the-old-service}
{: step}

1. Verify that your application is fully migrated to the Lite or Standard instance.
2. Delete the old Enterprise plan instance from your {{site.data.keyword.cloud_notm}} console to ensure that you're no longer charged for the service.
