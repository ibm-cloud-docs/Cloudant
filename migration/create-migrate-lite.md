---

copyright:
  years: 2015, 2023
lastupdated: "2023-04-06"

keywords: lite plan, standard plan, pricing plans

subcollection: Cloudant

content-type: tutorial
services: Cloudant
account-plan: lite
completion-time: 15m

---

{{site.data.keyword.attribute-definition-list}}

# Migrating from a Lite plan to a Standard plan
{: #migrating-from-a-lite-plan-to-a-standard-plan}
{: toc-content-type="tutorial"}
{: toc-services="Cloudant"}
{: toc-completion-time="15m"}

Migrating from the free Lite plan to the Standard plan by completing the following tasks.
{: shortdesc}

## Authenticate with {{site.data.keyword.cloud_notm}} Dashboard
{: #authenticate-with-ibm-cloud-dashboard}
{: step}

1.  Go to the [{{site.data.keyword.cloud}} Dashboard](https://cloud.ibm.com/).
2. Authenticate with your username and password. 
   The {{site.data.keyword.cloud_notm}} Dashboard opens to the Resource list.

## Select your {{site.data.keyword.cloudant_short_notm}} instance
{: #select-your-cloudant-instance}
{: step}

1.  Under Services, open the {{site.data.keyword.cloudant_short_notm}} instance that you want to migrate.
1.  Select **Plan**.
1.  From the list of pricing plans, select **Standard**.
   ![Standard plan is a serverless scaling of throughput and storage. Includes 20 GB of free data storage, more storage metered. Users can adjust provisioned throughput capacity in blocks of 100 reads/sec, 50 writes/sec, 5 global queries/sec. Max JSON document size of 1 MB. $1.00 USD/GB of data storage. $0.25 USD/Read capacity. $0.50 USD/Write capacity. $5.00 USD/Global Query capacity. ](../images/migrate3.png){: caption="Figure 1. Standard plan" caption-side="bottom"}

## Upgrade to the Standard plan
{: #upgrade-to-standard-plan}
{: step}

1.  Click **Upgrade**.
   All your existing data is kept.
1.  Adjust your capacity by using the Throughput Capacity slider to increase or decrease capacity as needed.


Now, you're ready to go.
