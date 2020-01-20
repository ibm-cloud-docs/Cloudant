---

copyright:
  years: 2017, 2020
lastupdated: "2020-01-20"

keywords: identify, api endpoints, log in, select ibm cloudant plan, create ibm cloudant service, create credentials, list service credentials, use ibm cloudant service instance, delete service credentials, delete service instance

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
{:external: target="_blank" .external}

<!-- Acrolinx: 2018-08-20 -->

# Creating an {{site.data.keyword.cloudant_short_notm}} instance on {{site.data.keyword.cloud_notm}} by using the {{site.data.keyword.cloud_notm}} CLI
{: #creating-an-ibm-cloudant-instance-on-ibm-cloud-by-using-the-ibm-cloud-cli}

This tutorial shows you how to create an {{site.data.keyword.cloudantfull}} service instance on {{site.data.keyword.cloud}}
by using the {{site.data.keyword.cloud_notm}} CLI.
{: shortdesc}

## Before you start this tutorial 
{: #before-you-start-this-tutorial}

To follow this tutorial, you must first install the {{site.data.keyword.cloud_notm}} CLI developer tools. For more information about installing the tools, see the [Getting started with the {{site.data.keyword.cloud_notm}} CLI](https://cloud.ibm.com/docs/cli?topic=cloud-cli-ibmcloud-cli#overview){: new_window}{: external} tutorial.

## Log in to your {{site.data.keyword.cloud_notm}} account
{: #logging-in-to-your-ibm-cloud-account}

The following example describes how to log in. If you use a federated user ID, it's important that you switch to a one-time passcode (`ibmcloud login --sso`), or use an API key (`ibmcloud --apikey key or @key_file`) to authenticate. For more information about how to log in by using the CLI, see [General CLI (ibmcloud) commands](https://cloud.ibm.com/docs/cli/reference/ibmcloud?topic=cloud-cli-ibmcloud_cli#ibmcloud_login){: new_window}{: external} under `ibmcloud login`. 

1.  Start the login process for
  your {{site.data.keyword.cloud_notm}} account by using the following command:
  
  ```sh
  ibmcloud login
  ```
  {: codeblock}
  
  {{site.data.keyword.cloud_notm}} responds by reminding you of the current
  API endpoint, and asks for the email address of your account:
  
  ```sh
  API endpoint: https://cloud.ibm.com
  Region: au-syd
  
  Email>

  Password>
  ```
  {: pre}

2.  Enter the email address of your account, and then enter your password:

  ```sh
  API endpoint: https://cloud.ibm.com
  
  Email> J.Doe@email.com
  
  Password>
  ```
  {: pre}
  
  {{site.data.keyword.cloud_notm}} validates your details and summarizes the information about your login session:

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

## Choosing the {{site.data.keyword.cloudant_short_notm}} plan for your service
{: #choosing-the-ibm-cloudant-plan-for-your-service}

See the [Plans](/docs/Cloudant?topic=cloudant-ibm-cloud-public#plans) section of the documentation for details on using the {{site.data.keyword.cloudant_short_notm}} Lite or Standard plan.
{: pre}

## Creating the {{site.data.keyword.cloudant_short_notm}} service
{: #creating-the-ibm-cloudant-service}

{{site.data.keyword.cloudant_short_notm}} uses resource groups for provisioning new instances rather than Cloud Foundry orgs and spaces. {{site.data.keyword.cloudant_short_notm}} instances that were provisioned in the past can still be deployed in Cloud Foundry orgs and spaces. For more information, see the [How does {{site.data.keyword.cloudant_short_notm}} work with {{site.data.keyword.cloud_notm}} Resource Groups?](/docs/Cloudant?topic=cloudant-how-does-ibm-cloudant-work-with-ibm-cloud-resource-groups-#how-does-ibm-cloudant-work-with-ibm-cloud-resource-groups-){: new_window}{: external} guide.

First, set your target resource group and region as shown in [General CLI (ibmcloud) commands](https://cloud.ibm.com/docs/cli/reference/ibmcloud?topic=cloud-cli-ibmcloud_cli#ibmcloud_target){: new_window}{: external} under `ibmcloud target` by using the following format:

```sh
ibmcloud target [-r REGION_NAME] [-g RESOURCE_GROUP]
```

For a list of regions, run this command:

```sh
ibmcloud regions
```

For a list of resource groups, run this command: 

```sh
ibmcloud resource groups
```

Second, the basic command format within {{site.data.keyword.cloud_notm}} that creates a service instance is shown in the following example:

```sh
ibmcloud resource service-instance-create NAME SERVICE_NAME|SERVICE_ID SERVICE_PLAN_NAME|SERVICE_PLAN_ID LOCATION [-p, --parameters @JSON_FILE | JSON_STRING ]
```
{: pre}

The fields are described in the following table: 


Field | Description
------|------------
`NAME` | Arbitrary name that you give to the instance. 
`SERVICE_NAME` | `cloudantnosqldb`
`PLAN_NAME` | Lite plan or Standard plan.
`LOCATION` | The location where you want to deploy includes: AP North, Germany, Global, Sydney, United Kingdom, US East, or US South. 
`legacyCredentials` | Defaults to true. This field dictates whether the instance uses both legacy and IAM credentials or IAM credentials only. 

For more information about choosing an authentication method, see the [IAM guide](/docs/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-){: new_window}. The {{site.data.keyword.cloudant_short_notm}} team recommends that you use IAM access controls over {{site.data.keyword.cloudant_short_notm}} legacy authentication whenever possible.
{: important}

In this example, we want to create an instance of an {{site.data.keyword.cloudant_short_notm}} service by using the `Lite` plan. The instance name is `cs20170517a` in the US-South location and uses IAM credentials only. You create this instance by using a command similar to the following example:

```sh
ibmcloud resource service-instance-create cs20170517a cloudantnosqldb lite us-south -p '{"legacyCredentials": false}'
```
{: codeblock}

After you create the service instance, {{site.data.keyword.cloud_notm}}
responds with a message similar to the one in the following example:

```sh
Creating service instance cs20170517a in resource group default of account John Does's Account as j.doe@email.com...
OK
Service instance cs20170517a was created.
Name          Location   State    Type               Tags   
cs20170517a   au-syd   active   service_instance  
```
{: pre}

## Creating credentials for your {{site.data.keyword.cloudant_short_notm}} service
{: #creating-credentials-for-your-ibm-cloudant-service}

Applications that require access to your {{site.data.keyword.cloudant_short_notm}} service
must have the necessary credentials.

Service credentials are valuable. If anyone or any application has access to the credentials, they can effectively do whatever they want with the service instance. For example, they might create spurious data, or delete valuable information. Protect these credentials carefully.
{: important}

For more information about the fields included in the service credentials, see the [IAM guide](/docs/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-){: new_window}.

The basic command format to create credentials for a service instance
within {{site.data.keyword.cloud_notm}} is shown in the following example:

```sh
ibmcloud resource service-key-create NAME ROLE_NAME --instance-name SERVICE_INSTANCE_NAME
```
{: pre}

The fields are described in the following table:

Field | Description
------|------------
`NAME` | Arbitrary name that you give the service credentials. 
`ROLE_NAME` | This field currently allows the Manager role only.
`SERVICE_INSTANCE_NAME` | The name that you give to your {{site.data.keyword.cloudant_short_notm}} instance. 

If you want to create credentials for the `cs20170517a` instance of
an {{site.data.keyword.cloudant_short_notm}} service (where the name for the credentials is `creds_for_cs20170517a`), you create these credentials by using a command similar to the one in the following example:

```sh
ibmcloud resource service-key-create creds_for_cs20170517a Manager --instance-name cs20170517a
```
{: codeblock}

After you receive the request to create credentials for the service instance, {{site.data.keyword.cloud_notm}} responds with a message similar to the one in the following example:

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
               url:                      https://f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix:5811381f6daff7255b288695c3544be63f550e975bcde46799473e69c7d48d61@f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix.cloudant.com      
               username:                 f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix      
               port:                     443      
               apikey:                   XXXXX-XXXXXX_XXXXXXXXXXXXX-XXXXXXXXXXX      
               host:                     f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix.cloudant.com      
               iam_apikey_description:   Auto generated apikey during resource-key operation for Instance - crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42116849bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3::      
               iam_serviceid_crn:        crn:v1:bluemix:public:iam-identity::a/b42116849bb7e2abb0841ca25d28ee4c::serviceid:ServiceId-53f9e2a2-cdfb-4f90-b072-bfffafb68b3e      
               password:                 581138...7d48d61 
```
{: pre}

## Retrieving the service credentials for your {{site.data.keyword.cloudant_short_notm}} service
{: #retrieving-the-service-credentials-for-your-ibm-cloudant-service}

The basic command format to retrieve the credentials for a service instance
within {{site.data.keyword.cloud_notm}} is as follows:

```sh
ibmcloud resource service-key KEY_NAME
```
{: pre}

In this example, we want to retrieve credentials for the `cs20170517a` instance of
an {{site.data.keyword.cloudant_short_notm}} service. The name for the credentials is `creds_for_cs20170517a`. You retrieve the credentials by using a command similar to the one in the following example:

```sh
ibmcloud resource service-key creds_for_cs20170517b
```
{: codeblock}

After you receive the request to retrieve the credentials for the service instance,
{{site.data.keyword.cloud_notm}} responds with a message similar to the one in the following (abbreviated) example:

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
               url:                      https://f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix:5811381f6daff7255b288695c3544be63f550e975bcde46799473e69c7d48d61@f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix.cloudant.com      
               username:                 f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix      
               port:                     443      
               apikey:                   XXXXX-XXXXXX_XXXXXXXXXXXXX-XXXXXXXXXXX      
               host:                     f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix.cloudant.com      
               iam_apikey_description:   Auto generated apikey during resource-key operation for Instance - crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42116849bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3::      
               iam_serviceid_crn:        crn:v1:bluemix:public:iam-identity::a/b42116849bb7e2abb0841ca25d28ee4c::serviceid:ServiceId-53f9e2a2-cdfb-4f90-b072-bfffafb68b3e      
               password:                 581138...7d48d61 
```
{: pre}

## Using your {{site.data.keyword.cloudant_short_notm}} service instance
{: #using-your-ibm-cloudant-service-instance}

Now, you're finished with the following tasks:

1.  Created an {{site.data.keyword.cloudant_short_notm}} service
  instance within {{site.data.keyword.cloud_notm}}.
2.  Created credentials for the {{site.data.keyword.cloudant_short_notm}} service instance.
3.  Retrieved the service instance credentials so that they can be used by your application.

For more information, see the [Creating and populating a simple {{site.data.keyword.cloudant_short_notm}} database on {{site.data.keyword.cloud_notm}}](/docs/Cloudant?topic=cloudant-creating-and-populating-a-simple-ibm-cloudant-database-on-ibm-cloud#context){: new_window} tutorial. This tutorial shows you how to use an {{site.data.keyword.cloudant_short_notm}} service instance from a Python application by using legacy credentials. Remember to substitute the credentials you created in this tutorial.

## (Optional) Tidying up afterward
{: #-optional-tidying-up-afterward}

The following short list of commands might be helpful in tidying up your development environment.

### Deleting service credentials
{: #deleting-service-credentials}

To delete a set of service credentials,
use a command like this one:

```sh
ibmcloud resource service-key-delete KEY_NAME
```
{: pre}

For example,
to delete the credentials called `creds_for_cs20170517a`, use a command like this one:

```sh
ibmcloud resource service-key-delete creds_for_cs20170517a
```
{: pre}

### Deleting a service instance
{: #deleting-a-service-instance}

To delete a service instance,
use a command like this one:

```sh
ibmcloud resource service-instance-delete SERVICE_INSTANCE_NAME
```
{: pre}

For example,
to delete the `cs20170517a` instance of
an {{site.data.keyword.cloudant_short_notm}} service,
use a command like this one:

```sh
ibmcloud resource service-instance-delete cs20170517a
```
{: pre}

