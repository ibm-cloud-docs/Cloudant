---

copyright:
  years: 2020, 2022
lastupdated: "2022-11-08"

keywords: service credentials, locate service credentials

subcollection: Cloudant

content-type: tutorial
services: Cloudant
account-plan: lite
completion-time: 5m

---

{{site.data.keyword.attribute-definition-list}}

# Locating your service credentials
{: #locating-your-service-credentials}
{: toc-content-type="tutorial"}
{: toc-services="Cloudant"}
{: toc-completion-time="5m"}

You can find the credentials for any service that is associated with your account.
{: shortdesc}

## Objectives
{: #objectives-locate-credentials}

- Locate your service credentials in {{site.data.keyword.cloud_notm}}.
- Understand your service credentials.

## Prerequisites
{: #prereq-locate-credentials}

- Create a service instance in the {{site.data.keyword.cloud_notm}} dashboard by following the [Getting started with {{site.data.keyword.cloudant_short_notm}}](/docs/Cloudant?topic=Cloudant-getting-started-with-cloudant) tutorial.

## How to find your service credentials
{: #finding-your-service-credentials}
{: step}

1. Go to [{{site.data.keyword.cloud_notm}}](https://cloud.ibm.com/) and log in.

2. Find the service instance called `Cloudant-o7` and open it. </br>
   This instance is the one you created as a [prerequisite](#prereqs-locate-credentials). 

    ![This Resource list is a list of all the instances in your service. Cloudant-07 is the instance we use in this tutorial.](images/img0011.png){: caption="Figure 1. Selecting the {{site.data.keyword.cloudant_short_notm}} service" caption-side="bottom"}

3. Click **Service credentials**.

4. Click the chevron next to the service credentials to see the credentials that are required to access the service. 

    ![Viewing the service credentials.](images/img0052.png){: caption="Figure 2. Viewing the {{site.data.keyword.cloudant_short_notm}} service credentials" caption-side="bottom"}

    Now, you can see the service credentials:

    ![The service credentials in this image are surrounded by a red box. The credentials include apikey, host, iam_apikey_description, iam_apikey_name, iam_role_crn, iam_serviceid_crn, url, and username.](images/img0009.png){: caption="Figure 3. The {{site.data.keyword.cloudant_short_notm}} service credentials" caption-side="bottom"}

    The service credentials in these examples were defined when a demonstration {{site.data.keyword.cloudant_short_notm}} service was created on {{site.data.keyword.cloudant_short_notm}}. The credentials are reproduced here to show how they would appear in the dashboard. However, the demonstration {{site.data.keyword.cloudant_short_notm}} service was removed, so these credentials are no longer valid. You *must* supply and use your own service credentials.
    {: note}

## Understanding your service credentials
{: #the-service-credentials}
{: step}

Service credentials are valuable. If anyone or any application has access to the credentials, they can effectively do whatever they want with the service instance. For example, they might create spurious data, or delete valuable information. Protect these credentials carefully.

{{site.data.keyword.cloudant_short_notm}} has two authentication methods available at provisioning time, either `Use only IAM` or `Use both legacy credentials and IAM`. You can see the details about your legacy credentials only if the `Use both legacy credentials and IAM` authentication method is chosen. The credentials display on the Service credentials tab for your instance. For more information, see the [IAM guide](/docs/Cloudant?topic=Cloudant-managing-access-for-cloudant)
 and [legacy authentication](/docs/Cloudant?topic=Cloudant-managing-access-for-cloudant) document for details about using either style of authentication.

The service credentials include the following fields, as well as designating the fields that are only shown if you select the `Use both legacy credentials and IAM` option:

| Field | Purpose | Legacy-auth enabled |
|------|---------|--------------------|
| `username` | The username that is required for applications to access the service instance. | |
| `password` | The legacy credentials password that is required for applications to access the service instance. | X |
| `host` | The host name that is used by applications to locate the service instance. | X |
| `port` | The HTTPS port number for accessing the service instance on the host. It's 443 as only HTTPS access is allowed by {{site.data.keyword.cloudant_short_notm}}. | X |
| `url`	| The HTTPS URL to access the {{site.data.keyword.cloudant_short_notm}} instance. | X     (If the `Use both legacy credentials and IAM` option is chosen, it also includes the embedded legacy username and password.) |
| `apikey` | The IAM API key. | |
| `iam_apikey_description` | Description of the IAM API key. | |
| `iam_apikey_name` | ID of the IAM API key. | |
| `iam_role_crn` | The IAM role that the IAM API key has. | |
| `iam_serviceid_crn`	| The CRN of the service ID. | X |
{: caption="Table 1. Service credential fields" caption-side="top"}

To create an application that can access your service instance, you need these credentials.
