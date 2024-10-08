---

copyright:
  years: 2022, 2023
lastupdated: "2023-03-30"

keywords: ibm cloudant plan, standard plan, lite plan, legacy enterprise plan

subcollection: Cloudant

content-type: tutorial
services: Cloudant
account-plan: lite
completion-time: 20m

---

{{site.data.keyword.attribute-definition-list}}

# Finding your {{site.data.keyword.cloudant_short_notm}} plan
{: #find-your-ibm-cloudant-plan}
{: toc-content-type="tutorial"}
{: toc-services="Cloudant"}
{: toc-completion-time="20m"}

You can subscribe to different {{site.data.keyword.cloudant_short_notm}} plans, including the Lite, Standard, or Enterprise plans.
{: shortdesc}

## Finding your plan
{: #finding-your-plan}
{: step}

The following steps show where you can see the type of plan that you selected.

1.  Go to the [{{site.data.keyword.cloud_notm}} Dashboard](https://cloud.ibm.com/).
2. Authenticate with your username and password.  
   The {{site.data.keyword.cloud_notm}} Dashboard opens to the Resource list.
3. Click an instance to find more information.
4. Click **Plan**.
   A checkmark indicates the plan that you use as shown in the following screen capture.
   For more information, see the [Migration FAQ](/docs/Cloudant?topic=Cloudant-faq-migration).

   ![Standard dashboard includes a serverless scaling of throughput and storage. Includes 20 GB of free data storage, extra storage metered. Users can adjust provisioned throughput capacity in blocks of 100 reads/sec, 50 writes/sec, 5 global queries/sec. Max JSON document size of 1 MB. $1.00 USD/GB of data storage. $0.25 USD/Read capacity. $0.50 USD/Write capacity. $5.00 USD/Global Query capacity. ](../images/ibmcloud_instance_standard_plan.png){: caption="Standard dashboard" caption-side="bottom"}

   If the Plan tab indicates that you're on the Standard plan, you don't need to read any further. You're already on a paid SLA-backed {{site.data.keyword.cloudant_short_notm}} service. No further action is required.
   {: note}

## Finding your legacy Enterprise plan
{: #finding-your-legacy-enterprise-plan}
{: step}

You can find your Enterprise plan in the {{site.data.keyword.cloudant_short_notm}} Dashboard by following these steps.

1. Open the {{site.data.keyword.cloudant_short_notm}} Dashboard.
   For more information, see the [Getting started](/docs/Cloudant?topic=Cloudant-navigate-the-dashboard) tutorial.
2. If you're using a legacy Enterprise `cloudant.com` account, click **Account**.
3. Review your `cloudant.com` Enterprise account on a dedicated cluster.
   The view doesn't include a Usage tab and looks like the following example:
   ![Review the information about the Enterprise plan in the {{site.data.keyword.cloudant_short_notm}} Dashboard under Account. ](../images/cloudantcom_enterpriseplan_account.png){: caption="Enterprise plan" caption-side="bottom"}
