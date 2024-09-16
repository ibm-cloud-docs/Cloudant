---

copyright:
  years: 2017, 2023, 2024
lastupdated: "2024-09-16"

keywords: identify, api endpoints, log in, select ibm cloudant plan, create ibm cloudant service, create credentials, list service credentials, use ibm cloudant service instance, delete service credentials, delete service instance

subcollection: Cloudant

content-type: tutorial
services: Cloudant
account-plan: lite
completion-time: 20m

---

{{site.data.keyword.attribute-definition-list}}

# Creating an instance with CLI
{: #creating-an-ibm-cloudant-instance-on-ibm-cloud-by-using-the-ibm-cloud-cli}
{: toc-content-type="tutorial"}
{: toc-services="Cloudant"}
{: toc-completion-time="20m"}

This tutorial shows you how to create an {{site.data.keyword.cloudantfull}} service instance on {{site.data.keyword.cloud}}
by using the {{site.data.keyword.cloud_notm}} CLI.
{: shortdesc}

## Objectives
{: #objectives-service-create-cli}

1. Use your {{site.data.keyword.cloud_notm}} account to create your {{site.data.keyword.cloudant_short_notm}} service instance and credentials.
2. Retrieve and use your {{site.data.keyword.cloudant_short_notm}} service instance.

## Before you begin
{: #before-you-begin-service-create-cli}

Install the {{site.data.keyword.cloud_notm}} CLI developer tools by following the [Getting started with the {{site.data.keyword.cloud_notm}} CLI](/docs/cli?topic=cli-getting-started){: external} tutorial.

## Logging in to your {{site.data.keyword.cloud_notm}} account
{: #logging-in-to-your-ibm-cloud-account}
{: step}

The following example describes how to log in. If you use a federated user ID, it's important that you switch to a one-time passcode (`ibmcloud login --sso`), or use an API key (`ibmcloud --apikey key or @key_file`) to authenticate. For more information about how to log in by using the CLI, see [General CLI (ibmcloud) commands](/docs/cli?topic=cli-ibmcloud_cli#ibmcloud_login){: external} under `ibmcloud login`.

1.  Start the login process for your {{site.data.keyword.cloud_notm}} account by using the following command.

    ```sh
    ibmcloud login
    ```
    {: codeblock}

    {{site.data.keyword.cloud_notm}} responds by reminding you of the current API endpoint, and asks for the email address of your account.

    ```sh
    API endpoint: https://cloud.ibm.com
    Region: au-syd
    
    Email>
    
    Password>
    ```
    {: pre}

2.  Enter the email address of your account, and then enter your password.

    ```sh
    API endpoint: https://cloud.ibm.com
    
    Email> J.Doe@email.com
    
    Password>
    ```
    {: pre}
    
    {{site.data.keyword.cloud_notm}} validates your details and summarizes the information about your login session.
    
    ```sh
    API endpoint: https://cloud.ibm.com
    
    Email> J.Doe@email.com
    
    Password>
    Authenticating...
    OK
    
    Targeted account J DOE's Account (707...a32)
    
    Targeted org J.Doe@email.com
    
    Targeted space dev
    
    API endpoint:   https://cloud.ibm.com (API version: 2.54.0)
    Region:         au-syd
    User:           j.doe@email.com
    Account:        J DOE's Account (707...a32)
    Org:            J.Doe@email.com
    Space:          dev
    ```
    {: pre}

3.  You're now logged in to your {{site.data.keyword.cloud_notm}} account.

## Creating the {{site.data.keyword.cloudant_short_notm}} service
{: #creating-service-create-cli}
{: step}

{{site.data.keyword.cloudant_short_notm}} uses resource groups for provisioning new instances.

In this example, you create a service instance within {{site.data.keyword.cloud_notm}} by running the following command.

```sh
ibmcloud resource service-instance-create NAME SERVICE_NAME SERVICE_PLAN_NAME LOCATION [-p, --parameters @JSON_FILE | JSON_STRING ]
```
{: pre}

The fields in the command are described in the table that follows.

| Field | Description |
|-------|------------|
| `NAME` | Arbitrary name that you give to the instance. |
| `SERVICE_NAME` | `cloudantnosqldb` |
| `SERVICE_PLAN_NAME` |  Lite plan (`lite`) or Standard plan (`standard`)|
| `LOCATION` | The location where you want to deploy includes the following cities: Sydney `au-syd`, Chennai `in-che`, Osaka `jp-osa`, Tokyo `jp-tok`, Seoul `kr-seo`, Frankfurt `eu-de`, London `eu-gb`, Dallas `us-south`, Washington DC `us-east`. |
| `legacyCredentials` | Defaults to `true`. This field dictates whether the instance uses both legacy and IAM credentials or IAM credentials only. |
{: caption="Table 1. Basic command format fields" caption-side="top"}

`SERVICE_PLAN_NAME` is the type of pricing plan you select when you create an instance. For more information, see [Plans](/docs/Cloudant?topic=Cloudant-ibm-cloud-public#plans-and-provisioning) in the documentation for details on using the {{site.data.keyword.cloudant_short_notm}} Lite or Standard plan.
{: tip}

For more information about choosing an authentication method, see the [IAM guide](/docs/Cloudant?topic=Cloudant-managing-access-for-cloudant). The {{site.data.keyword.cloudant_short_notm}} team recommends that you use IAM access controls over {{site.data.keyword.cloudant_short_notm}} legacy authentication whenever possible.
{: important}

Now, we create a service instance that is called, `cs20170517a`.

1. Set your target resource group and region by using the following format.
    To run this command, you need to know the region and resource groups, which you find in the following steps.

    For more information, see [General CLI (ibmcloud) commands](/docs/cli?topic=cli-ibmcloud_cli#ibmcloud_target){: external} under `ibmcloud target`.

    ```sh
    ibmcloud target [-r REGION_NAME] [-g RESOURCE_GROUP]
    ```
    {: codeblock}

2. To see a list of regions, run the following command.

    ```sh
    ibmcloud regions
    ```
    {: codeblock}

3. To see a list of resource groups, run the following command.

    ```sh
    ibmcloud resource groups
    ```
    {: codeblock}

4. Create an instance of an {{site.data.keyword.cloudant_short_notm}} service by using the `Lite` plan.    
    The instance name is `cs20170517a` in the US-South location and uses IAM credentials only.

    ```sh
    ibmcloud resource service-instance-create cs20170517a cloudantnosqldb lite us-south -p '{"legacyCredentials": false}'
    ```
    {: codeblock}

5. After you create the service instance, see the following example message.

    ```sh
    Creating service instance cs20170517a in resource group default of account John Does's Account as j.doe@email.com...
    OK
    Service instance cs20170517a was created.
    Name          Location   State        Tags
    cs20170517a   au-syd   active   service_instance
    ```
    {: pre}

Next, you create service credentials for your {{site.data.keyword.cloudant_short_notm}} service instance.

## Creating credentials for your {{site.data.keyword.cloudant_short_notm}} service
{: #creating-credentials-service-create-cli}
{: step}

Applications that require access to your {{site.data.keyword.cloudant_short_notm}} service
must have the necessary credentials.

Service credentials are valuable. If anyone or any application has access to the credentials, they can effectively do whatever they want with the service instance. For example, they might create spurious data, or delete valuable information. Protect these credentials carefully.
{: important}

For more information about the fields included in the service credentials, see the [IAM guide](/docs/Cloudant?topic=Cloudant-managing-access-for-cloudant).

In the next example, you create credentials for a service instance within {{site.data.keyword.cloud_notm}} by running the following command.

```sh
ibmcloud resource service-key-create NAME ROLE_NAME --instance-name SERVICE_INSTANCE_NAME
```
{: pre}

The fields in the command are described in the table that follows.

| Field | Description |
|-------|-------------|
| `NAME` | Arbitrary name that you give the service credentials. |
| `ROLE_NAME` | This field currently allows the Manager role only. |
| `SERVICE_INSTANCE_NAME` | The name that you give to your {{site.data.keyword.cloudant_short_notm}} instance. |
{: caption="Table 2. Create credential fields" caption-side="top"}

Now, you create credentials for the  `cs20170517a` instance you created in the previous step.

1. Create credentials for the `cs20170517a` instance of an {{site.data.keyword.cloudant_short_notm}} service (where the name for the credentials is `creds_for_cs20170517a`) by running the following command.

    ```sh
    ibmcloud resource service-key-create creds_for_cs20170517a Manager --instance-name cs20170517a
    ```
    {: codeblock}

2. After you receive the request to create credentials for the service instance, review the response from {{site.data.keyword.cloud_notm}} that contains a message similar to the one in the following example.

    ```sh
    Creating service key in resource group default of account John Does's Account as john.doe@email.com...
    OK
    Service key crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42223455bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3:resource-key:621ffde2-ea10-4318-b297-d6d849cec48a was created.

    Name:          creds_for_cs20170517a
    ID:            crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42223455bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3:resource-key:621ffde2-ea10-4318-b297-d6d849cec48a
    Created At:    Tue Sep 18 19:58:38 UTC 2018
    State:         active
    Credentials:
                   iam_apikey_name:          auto-generated-apikey-621ffde2-ea10-4318-b297-d6d849cec48a
                   iam_role_crn:             crn:v1:bluemix:public:iam::::serviceRole:Manager
                   url:                      https://apikey-v2-58B528DF5397465BB6673E1B79482A8C:5811381f6daff7255b288695c3544be63f550e975bcde46799473e69c7d48d61@f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix.cloudant.com
                   username:                 apikey-v2-58B528DF5397465BB6673E1B79482A8C
                   port:                     443
                   apikey:                   XXXXX-XXXXXX_XXXXXXXXXXXXX-XXXXXXXXXXX
                   host:                     f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix.cloudant.com
                   iam_apikey_description:   Auto generated apikey during resource-k  ey operation for Instance - crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42116849bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3::
                   iam_serviceid_crn:        crn:v1:bluemix:public:iam-identity::a/b42116849bb7e2abb0841ca25d28ee4c::serviceid:ServiceId-53f9e2a2-cdfb-4f90-b072-bfffafb68b3e
                   password:                 581138...7d48d61
    ```
    {: pre}

Next, you learn how to retrieve your service credentials. You need your service credentials to log in to your {{site.data.keyword.cloudant_short_notm}} instance.

## Retrieving the service credentials for your {{site.data.keyword.cloudant_short_notm}} service
{: #retrieving-the-service-credentials-service-create-cli}
{: step}

1. Retrieve credentials for the `cs20170517a` instance of an {{site.data.keyword.cloudant_short_notm}} service. The name for the credentials is `creds_for_cs20170517a`.

    ```sh
    ibmcloud resource service-key creds_for_cs20170517b
    ```
    {: codeblock}

2. After you receive the request to retrieve the credentials for the service instance, review the response from {{site.data.keyword.cloud_notm}} that contains a message similar to the one in the following (abbreviated) example.

    ```sh
    Retrieving service key in resource group default of account John Does's Account as john.doe@email.com...
    OK
    Service key crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42223455bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3:resource-key:621ffde2-ea10-4318-b297-d6d849cec48a was created.

    Name:          creds_for_cs20170517a
    ID:            crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42223455bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3:resource-key:621ffde2-ea10-4318-b297-d6d849cec48a
    Created At:    Tue Sep 18 19:58:38 UTC 2018
    State:         active
    Credentials:
                 iam_apikey_name:          auto-generated-apikey-621ffde2-ea10-4318-b297-d6d849cec48a
                 iam_role_crn:             crn:v1:bluemix:public:iam::::serviceRole:Manager
                 url:                      https://apikey-v2-58B528DF5397465BB6673E1B79482A8C:5811381f6daff7255b288695c3544be63f550e975bcde46799473e69c7d48d61@f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix.cloudant.com
                 username:                 apikey-v2-58B528DF5397465BB6673E1B79482A8C
                 port:                     443
                 apikey:                   XXXXX-XXXXXX_XXXXXXXXXXXXX-XXXXXXXXXXX
                 host:                     f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix.cloudant.com
                 iam_apikey_description:   Auto generated apikey during resource-key operation for Instance - crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42116849bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3::
                 iam_serviceid_crn:        crn:v1:bluemix:public:iam-identity::a/b42116849bb7e2abb0841ca25d28ee4c::serviceid:ServiceId-53f9e2a2-cdfb-4f90-b072-bfffafb68b3e
                 password:                 581138...7d48d61
    ```
    {: pre}

Now, the tutorial is complete. Optionally, you can delete the service credentials or service instance as shown in the steps in the next two sections.

For more information, see the [Creating and populating a simple {{site.data.keyword.cloudant_short_notm}} database on {{site.data.keyword.cloud_notm}}](/docs/Cloudant?topic=Cloudant-creating-and-populating-a-simple-ibm-cloudant-database-on-ibm-cloud) tutorial. This tutorial shows you how to use an {{site.data.keyword.cloudant_short_notm}} service instance from a Python application by using legacy credentials. Remember to substitute the credentials you created.

## (Optional) Deleting service credentials
{: #deleting-service-create-cli}
{: step}

Delete the credentials called `creds_for_cs20170517a` by running a command like this one.

```sh
ibmcloud resource service-key-delete creds_for_cs20170517a
```
{: pre}

## (Optional) Deleting a service instance
{: #deleting-service-create-cli-instance}
{: step}

Delete the `cs20170517a` instance of an {{site.data.keyword.cloudant_short_notm}} service by running a command like this one.

```sh
ibmcloud resource service-instance-delete cs20170517a
```
{: pre}
