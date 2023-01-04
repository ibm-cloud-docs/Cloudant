---

copyright:
  years: 2015, 2023
lastupdated: "2023-01-03"

keywords: example, connect to service instance, create service instance, service credentials, instance

subcollection: Cloudant

content-type: tutorial
services: Cloudant
account-plan: lite 
completion-time: 20m

---

{{site.data.keyword.attribute-definition-list}}

# Getting started with {{site.data.keyword.cloudant_short_notm}}
{: #getting-started-with-cloudant}
{: toc-content-type="tutorial"}
{: toc-services="Cloudant"}
{: toc-completion-time="20m"}

The {{site.data.keyword.cloudantfull}} *Getting started* tutorial demonstrates how to use the {{site.data.keyword.cloud}} Dashboard to create an {{site.data.keyword.cloudant_short_notm}} service instance. You also see essential information to enable your application to work with the database. 
{: shortdesc} 

## Objectives
{: #objectives-get-started}

- Create a service instance. 
- Create an {{site.data.keyword.cloudant_short_notm}} service credential.

## Creating a service instance
{: #creating-an-ibm-cloudant-instance-on-ibm-cloud}
{: step}

1.  Log in to your {{site.data.keyword.cloud_notm}} account, and click `Create resource`.  

    ![{{site.data.keyword.cloud_notm}} Dashboard, which includes Build tile, Monitor your resources tile, Create and deploy an application tile, API Connect tile, Integrate Watson with anything tile, and Watson starter kits tile. ](/tutorials/images/img0001.png){: caption="Figure 1. {{site.data.keyword.cloud_notm}} Dashboard" caption-side="bottom"}

    The {{site.data.keyword.cloud_notm}} Dashboard can be found at:
    [https://cloud.ibm.com/](https://cloud.ibm.com/){: external}.
    After you authenticate with your username and password,
    you're presented with the {{site.data.keyword.cloud_notm}} Dashboard. 
    {: note}
    
2.  Type `Cloudant` in the Search bar and click to open it.

3.  Select an offering and an environment.  

4.  Type an instance name. </br>

    ![Create the {{site.data.keyword.cloudant_short_notm}} service name and credentials.](tutorials/images/img0005b.png){: caption="Figure 2. {{site.data.keyword.cloudant_short_notm}} service name and credentials" caption-side="bottom"}

    (In this example, the instance name is `Cloudant-o7`.) Verify that the resource group and authentication methods are correct. Add a tag if you like. The authentication methods that are available include `IAM` or `IAM and legacy credentials`. For more information, see [authentication methods](/docs/Cloudant?topic=Cloudant-managing-access-for-cloudant).

    The {{site.data.keyword.cloudant_short_notm}} team recommends that you use IAM access controls over {{site.data.keyword.cloudant_short_notm}} legacy authentication whenever possible.
    {: important}
 
5.  Select your plan. </br>

6.  To create the service, click `Create`:

    After you click `Create`, the system displays a message to say that the instance is being provisioned, which returns you to the Resource list. From the Resource list, you see that the status for your instance is, `Provision in progress`. 

7.  When the status changes to `Active`, click the instance, and proceed to the next section, [Creating service credentials](#creating-service-credentials).   

## Creating service credentials
{: #creating-service-credentials}
{: step}

1.  To locate your service credentials, go to [Locating your service credentials](/docs/Cloudant?topic=Cloudant-locating-your-service-credentials).
2.  See more information on [understanding your service credentials](/docs/Cloudant?topic=Cloudant-locating-your-service-credentials#the-service-credentials).


