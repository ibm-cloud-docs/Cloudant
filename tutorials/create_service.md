---

copyright:
  years: 2017, 2019
lastupdated: "2019-07-23"

keywords: create service instance, service credentials, locate service credentials

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

<!-- Acrolinx: 2018-09-19 -->

# Creating an {{site.data.keyword.cloudant_short_notm}} instance on {{site.data.keyword.cloud_notm}}
{: #creating-an-ibm-cloudant-instance-on-ibm-cloud}

This tutorial shows you how to create an {{site.data.keyword.cloudantfull}}
service instance using the {{site.data.keyword.cloud}} dashboard,
and shows you where to find the essential information to enable your applications
to work with the database.
{: shortdesc} 

## Creating a service instance
{: #creating-a-service-instance}

1.  Log in to your {{site.data.keyword.cloud_notm}} account.<br/>
    The {{site.data.keyword.cloud_notm}} dashboard can be found at:
    [https://cloud.ibm.com/ ![External link icon](../images/launch-glyph.svg "External link icon")](https://cloud.ibm.com/){: new_window}.
    After authenticating with your user name and password,
    you are presented with the {{site.data.keyword.cloud_notm}} dashboard. Click the `Create resource` button. <br/>
    ![{{site.data.keyword.cloud_notm}} dashboard](images/img0001.png)

2.  Click `Databases` from the menu and `Cloudant` from the list of database       services:<br/>
    ![{{site.data.keyword.cloud_notm}} Databases services](images/img0003.png)<br/>

3.  In the service configuration window, enter a service name. Verify that the     service name, region/location, resource group, and authentication methods      are correct. Add a tag if you like. The authentication methods that are        available include `Use only IAM` or `Use both legacy credentials and IAM`.     For more information, see [authentication methods](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-){: new_window}. 
    In this example, the service name is `Cloudant-o7`:<br/>
    ![{{site.data.keyword.cloudant_short_notm}} service name and credentials](images/img0005.png)
    
    The {{site.data.keyword.cloudant_short_notm}} team recommends that you use IAM access controls over {{site.data.keyword.cloudant_short_notm}} legacy authentication whenever possible.
    {: important}

4.  By default, the service is created by using the 'Lite' pricing plan, which     is free but comes with a fixed amount of provisioned throughput capacity       and data storage. If you have a paid {{site.data.keyword.cloud_notm}}          account, you can also choose the paid 'Standard' plan so you can toggle        the provisioned throughput capacity and scale data usage as needed. For        more information about pricing plans, see [Plans](/docs/services/Cloudant?topic=cloudant-ibm-cloud-public#plans){: new_window}. To create the service, click the `Create` button: <br/>
    ![Create the {{site.data.keyword.cloudant_short_notm}} service name and credentials](images/img0006.png)

5.  A service page appears,
    confirming that your new {{site.data.keyword.cloudant_short_notm}} service is available.
    To create the connection information that your application needs to connect to the service,
    click the `Service Credentials` tab:<br/>
    ![Creating the {{site.data.keyword.cloudant_short_notm}} service credentials](images/img0007.png)

6.  Create a new {{site.data.keyword.cloudant_short_notm}} service credential:
  <br>a. Click the `New credential` button.
  <br>![Create new service credentials](images/img0050.png)
  <br>b. Enter a name for the new credential in the Add new credential window. See image.
  <br>c. Accept the Manager role.
  <br>d. (Optional) Create a new service ID or have one automatically generated for you. 
  <br>d. (Optional) Add inline configuration parameters. Note that this parameter is currently not used by {{site.data.keyword.cloudant_short_notm}} service credentials so ignore it. 
  <br>e. Click the `Add` button. </br>
  <br>![Add a new service credential](images/img0051.png)
  <br>Your new credential appears after the table.</br>
  <br>f. Click `View credentials` under Actions.
  <br>![View all service credentials](images/img0052.png)

7.  The details for the service credentials appear:<br/>
    ![The {{site.data.keyword.cloudant_short_notm}} service credentials](images/img0009.png)

The service credentials in these examples were defined when a demonstration {{site.data.keyword.cloudant_short_notm}} service was created on {{site.data.keyword.cloudant_short_notm}}. The credentials are reproduced here to show how they would appear in the dashboard. However, the demonstration {{site.data.keyword.cloudant_short_notm}} service was removed, so these credentials are no longer valid; you *must* supply and use your own service credentials.
{: note}

## The service credentials
{: #the-service-credentials}

Service credentials are valuable. If anyone or any application has access to the credentials, they can effectively do whatever they want with the service instance. For example, they might create spurious data, or delete valuable information. Protect these credentials carefully.
    
{{site.data.keyword.cloudant_short_notm}} has two authentication methods available at provisioning time, either `Use only IAM` or `Use both legacy credentials and IAM`. You can see the details about your legacy credentials only if the `Use both legacy credentials and IAM` authentication method is chosen. The credentials display on the Service credentials tab for your instance. For more information, see the [IAM guide](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-)
 and [legacy authentication](/docs/services/Cloudant?topic=cloudant-authentication#authentication) document for details about using either style of authentication.

The service credentials include the following fields:

Field | Purpose
------|--------
`username` | The service name of the service instance user in the URL. This field also serves as the admin user name. 
`password` | The legacy credentials password that is required for applications to access the service instance. This field only displays if the `Use both legacy credentials and IAM` option is chosen. 
`host` | The host name that is used by applications to locate the service instance. This field only displays if the `Use both legacy credentials and IAM` option is chosen. 
`port` | The HTTPS port number for accessing the service instance on the host. It is 443 as only HTTPS access is allowed by {{site.data.keyword.cloudant_short_notm}}. This field only displays if the `Use both legacy credentials and IAM` option is chosen. 
`url`	| The HTTPS URL to access the {{site.data.keyword.cloudant_short_notm}} instance. If the `Use both legacy credentials and IAM` option is chosen, it also includes the embedded legacy user name and password. 
`apikey` | The IAM API key. 
`iam_apikey_description` | Description of the IAM API key. 
`iam_apikey_name` | ID of the IAM API key.
`iam_role_crn` | The IAM role that the IAM API key has.
`iam_serviceid_crn`	| The CRN of the service ID.

To create an application that can access your service instance, you need these credentials.

## Locating your service credentials
{: #locating-your-service-credentials}

At any time, you can find the credentials for a service that is associated with your account.

1.  Begin by logging in to {{site.data.keyword.cloud_notm}}.
    The {{site.data.keyword.cloud_notm}} dashboard can be found at:
    [https://cloud.ibm.com/ ![External link icon](../images/launch-glyph.svg "External link icon")](https://cloud.ibm.com/){: new_window}.
    After authenticating with your user name and password,
    you are presented with the {{site.data.keyword.cloud_notm}} dashboard:<br/>
    ![{{site.data.keyword.cloud_notm}} dashboard](images/img0001.png)

2.  In this example,
    we want to find the service credentials for the {{site.data.keyword.cloudant_short_notm}}
    service instance that was created earlier in this tutorial,
    called `Cloudant-o7`. Click the **Menu** icon > **Resource List**, and the corresponding row:<br/>
    ![Selecting the {{site.data.keyword.cloudant_short_notm}} service](images/img0011.png)

3.  To see the credentials that are required to access the service,
    click `View Credentials`:<br/>
    ![Viewing the {{site.data.keyword.cloudant_short_notm}} service credentials](images/img0052.png)

4.  The details for the service credentials appear:<br/>
    ![The {{site.data.keyword.cloudant_short_notm}} service credentials](images/img0009.png)

The service credentials in these examples were defined when a demonstration {{site.data.keyword.cloudant_short_notm}} service was created on {{site.data.keyword.cloudant_short_notm}}. The credentials are reproduced here to show how they would appear in the dashboard. However, the demonstration {{site.data.keyword.cloudant_short_notm}} service was removed, so these credentials are no longer valid; you *must* supply and use your own service credentials.
{: note}

