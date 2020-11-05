---

copyright:
  years: 2020
lastupdated: "2020-11-06"

keywords: service credentials, locate service credentials

subcollection: Cloudant

content-type: tutorial
services: Cloudant
account-plan: lite 
completion-time: 5m

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:codeblock: .codeblock}
{:pre: .pre}
{:screen: .screen}
{:tip: .tip}
{:note: .note}
{:important: .important}
{:deprecated: .deprecated}
{:external: target="_blank" .external}
{:step: data-tutorial-type='step'}

<!-- Acrolinx: 2020-03-11 -->

# Locating your service credentials
{: #locating-your-service-credentials}
{: toc-content-type="tutorial"}
{: toc-services="Cloudant"}
{: toc-completion-time="5m"}

You can find the credentials for any service that is associated with your account.
{: shortdesc}

## Objectives
{: #objectives-get-started}

- Locate your service credentials in {{site.data.keyword.cloud_notm}}
- Understand your service credentials

## Finding your service credentials
{: #finding-your-service-credentials}
{: step}

1.  Go to the {{site.data.keyword.cloud_notm}} dashboard by clicking {{site.data.keyword.cloud_notm}} in the menu bar.

    ![{{site.data.keyword.cloud_notm}} dashboard](images/img0001.png){: caption="Figure 9. {{site.data.keyword.cloud_notm}} dashboard" caption-side="bottom"}

2.  Now,
    we want to find the service credentials for the {{site.data.keyword.cloudant_short_notm}}
    service instance that we created in step 2,
    called `Cloudant-o7`. In the Resource summary box, click **Services** and then the corresponding row:

    ![Selecting the {{site.data.keyword.cloudant_short_notm}} service](images/img0011.png){: caption="Figure 10. Selecting the {{site.data.keyword.cloudant_short_notm}} service" caption-side="bottom"}

3.  To see the credentials that are required to access the service,
    click the chevron:

    ![Viewing the service credentials.](images/img0052.png){: caption="Figure 11. Viewing the {{site.data.keyword.cloudant_short_notm}} service credentials" caption-side="bottom"}

    The details for the service credentials appear:

    ![The {{site.data.keyword.cloudant_short_notm}} service credentials.](images/img0009.png){: caption="Figure 12. The {{site.data.keyword.cloudant_short_notm}} service credentials" caption-side="bottom"}

    The service credentials in these examples were defined when a demonstration {{site.data.keyword.cloudant_short_notm}} service was created on {{site.data.keyword.cloudant_short_notm}}. The credentials are reproduced here to show how they would appear in the dashboard. However, the demonstration {{site.data.keyword.cloudant_short_notm}} service was removed, so these credentials are no longer valid; you *must* supply and use your own service credentials.
    {: note}

## Understanding your service credentials
{: #the-service-credentials}
{: step}

Service credentials are valuable. If anyone or any application has access to the credentials, they can effectively do whatever they want with the service instance. For example, they might create spurious data, or delete valuable information. Protect these credentials carefully.
    
{{site.data.keyword.cloudant_short_notm}} has two authentication methods available at provisioning time, either `Use only IAM` or `Use both legacy credentials and IAM`. You can see the details about your legacy credentials only if the `Use both legacy credentials and IAM` authentication method is chosen. The credentials display on the Service credentials tab for your instance. For more information, see the [IAM guide](/docs/Cloudant?topic=Cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-)
 and [legacy authentication](/docs/Cloudant?topic=Cloudant-authentication#authentication) document for details about using either style of authentication.

The service credentials include the following fields, as well as designating the fields that only display if you select the `Use both legacy credentials and IAM` option:

Field | Purpose | Legacy-auth enabled
------|---------|--------------------
`username` | The service name of the service instance user in the URL. This field also serves as the admin user name. | 
`password` | The legacy credentials password that is required for applications to access the service instance. | X
`host` | The host name that is used by applications to locate the service instance. | X
`port` | The HTTPS port number for accessing the service instance on the host. It's 443 as only HTTPS access is allowed by {{site.data.keyword.cloudant_short_notm}}. | X
`url`	| The HTTPS URL to access the {{site.data.keyword.cloudant_short_notm}} instance. | X (If the `Use both legacy credentials and IAM` option is chosen, it also includes the embedded legacy user name and password.) 
`apikey` | The IAM API key. | 
`iam_apikey_description` | Description of the IAM API key. | 
`iam_apikey_name` | ID of the IAM API key. | 
`iam_role_crn` | The IAM role that the IAM API key has. | 
`iam_serviceid_crn`	| The CRN of the service ID. | X
{: caption="Table 1. Service credential fields" caption-side="top"}

To create an application that can access your service instance, you need these credentials.