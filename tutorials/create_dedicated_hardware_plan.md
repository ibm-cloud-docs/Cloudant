---

copyright:
  years: 2015, 2019
lastupdated: "2019-04-30"

keywords: create dedicated hardware plan instance, provision standard plan instance, cli, create credentials, list service credentials

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

<!-- Acrolinx: 2017-05-10 -->

# Creating and leveraging an {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware plan instance on {{site.data.keyword.cloud_notm}}
{: #creating-and-leveraging-an-ibm-cloudant-dedicated-hardware-plan-instance-on-ibm-cloud}

This tutorial shows you how to create an {{site.data.keyword.cloudantfull}} Dedicated Hardware plan instance 
that uses the {{site.data.keyword.cloud}} dashboard, and shows you how to subsequently provision one or 
more Standard plan instances to run on it by using either the {{site.data.keyword.cloud_notm}} Catalog or the {{site.data.keyword.cloud_notm}} CLI. 
{: shortdesc}

Creating an {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware plan instance results in the provisioning 
of an {{site.data.keyword.cloudant_short_notm}} environment on dedicated hardware for your sole use. A service 
instance is created in the {{site.data.keyword.cloud_notm}} dashboard, but you cannot 
access the Dedicated Hardware plan instance directly and will not have 
any Service Credentials for it. You can use an {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware 
plan instance after it is created by provisioning one or more Standard plan 
instances on it.

## Creating an {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware plan instance
{: #creating-an-ibm-cloudant-dedicated-hardware-plan-instance}

1.  Log in to your {{site.data.keyword.cloud_notm}} account.<br/>
    The {{site.data.keyword.cloud_notm}} dashboard can be found at:
    [`https://cloud.ibm.com/` ![External link icon](../images/launch-glyph.svg "External link icon")](https://cloud.ibm.com/){: new_window}.
    After authenticating with your user name and password,
    you are presented with the {{site.data.keyword.cloud_notm}} dashboard. Click the `Create resource` button:<br/>
    ![{{site.data.keyword.cloud_notm}} dashboard](images/img0001.png)

2.  Click `Databases` from the left menu and `Cloudant` from the list of database services.<br/>
     ![{{site.data.keyword.cloud_notm}} {{site.data.keyword.cloudant_short_notm}} service selection](images/img0003.png)<br/>

3.  Select the `Dedicated Hardware` plan from the list of pricing plans at the bottom of the page:<br/>
    ![Pricing plans](images/pricing_plan.png)
    
4.  Fill out the following parameters at the top of the page: <br/>
    -   Enter a service name.<br/>
    -   Specify the region/location where you want to deploy. The region/location will be one of the six major {{site.data.keyword.cloud_notm}} regions where you want the instance deployed. The actual physical location of the instance is dictated by the location parameter described below.<br/>
    -   Select a resource group.</br>
    -   Add a tag. 
    -   Select a location for deployment. This location is the physical location of the instance, which can be in any {{site.data.keyword.cloud_notm}} location, including major regions and locations outside the major regions. For more information see [{{site.data.keyword.IBM}} global data centers ![External link icon](../images/launch-glyph.svg "External link icon")](https://www.ibm.com/cloud/data-centers/){:new_window}.<br/>
    -   Select `yes` or `no` to answer whether HIPAA is required.<br/> 
    
    HIPAA is only valid for U.S. locations. {{site.data.keyword.IBM}} can provision a Dedicated Hardware plan environment to implement HIPAA controls. An environment is only provisioned upon confirmation of a Business Associate Agreement (BAA) that is established with {{site.data.keyword.IBM_notm}}. See [Enabling the HIPAA Supported setting](https://cloud.ibm.com/docs/account/eu_hipaa_supported.html#enabling-the-hipaa-supported-setting) and the Service Description terms for more details. Provisioning a cluster to manage HIPAA data can take longer than the estimated 5-day period.
    {: note}

    ![Configure dedicated hardware](images/select_deployment_location.png)
        
5.  Click the `Create` button to start the provisioning process. <br/>

    Billing is prorated daily so make sure that you want to provision and pay for an environment before clicking the **Create** button.
    {: note}

    ![Provision dedicated hardware](images/create_button_provision.png)

    During provisioning, a spinning wheel appears next to the instance in your {{site.data.keyword.cloud_notm}} dashboard. A request is sent to provision a Dedicated Hardware plan instance on bare metal servers. Provisioning time is asynchronous and can take up to 5 days. 
    {: note}   

    ![Provision dedicated hardware alternate version](images/create_button_provision2.png)
    
## Provisioning a Standard plan instance on a Dedicated Hardware environment
{: #provisioning-a-standard-plan-instance-on-a-dedicated-hardware-environment}

1.  Log in to your {{site.data.keyword.cloud_notm}} account.<br/>
    The {{site.data.keyword.cloud_notm}} dashboard can be found at:
    [https://cloud.ibm.com/ ![External link icon](../images/launch-glyph.svg "External link icon")](https://cloud.ibm.com/){: new_window}.
    After authenticating with your user name and password,
    you are presented with the {{site.data.keyword.cloud_notm}} dashboard. Click the `Create resource` button:<br/>
    ![{{site.data.keyword.cloud_notm}} dashboard](images/img0001.png)

2.  Click `Databases` from the left menu and `Cloudant` from the list of database services.<br/>
     ![{{site.data.keyword.cloud_notm}} {{site.data.keyword.cloudant_short_notm}} service selection](images/img0003.png)<br/>
    The page for creating a service appears.<br/>  

3.  Click `Standard` from the pricing plans. <br/>
    ![Standard pricing plan](images/standard_pricing_plan.png)
    
    You cannot provision a Lite plan instance on a Dedicated Hardware environment.
    {: tip}
    
4.  Fill out the following parameters: <br/>
    -   Enter a service name.<br/>
    -   Specify the region/location where you want to deploy. <br/>
    -   Select a resource group. </br>
    -   Add a tag. 
    -   Select an authentication method.</br>
    -   Select an environment, which is where the Standard plan instance will be deployed. Any Dedicated Hardware environment instances deployed in the account will show up in the drop-down if they are available.</br>
    ![Configure standard instance](images/select_environment.png)
    
5.  Click the `Create` button.<br/>
    After a few seconds, the instance is provisioned on the environment you selected.<br/>
    ![Provision standard instance](images/create_button_provision_standard.png)
    
6.  Obtain your Service Credentials and access the {{site.data.keyword.cloudant_short_notm}} Dashboard as you do for a multi-tenant {{site.data.keyword.cloudant_short_notm}} instance. 
    
    For more information, see [how to locate your service credentials](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud#locating-your-service-credentials){: new_window}. 
    
## Provisioning a Standard plan instance on a Dedicated Hardware environment with the {{site.data.keyword.cloud_notm}} CLI
{: #provisioning-a-standard-plan-instance-on-a-dedicated-hardware-environment-with-the-ibm-cloud-cli}

To use the {{site.data.keyword.cloud_notm}} CLI, you must be logged in. For more information about how to log in and set a target resource group, see [Logging in to your {{site.data.keyword.cloud_notm}} account](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud-by-using-the-ibm-cloud-cli#logging-in-to-your-ibm-cloud-account){: new_window}. 

To create an {{site.data.keyword.cloudant_short_notm}} Standard plan instance on your {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware plan environment, the basic command format is as follows:


Field | Description
------|------------
`NAME`| An arbitrary name you assign the instance.
`SERVICE_NAME` | `cloudantnosqldb`
`PLAN_NAME` | Standard plan
`LOCATION` |  The location where you want to deploy, for example, us-south, us-east, or eu-gb. 

See the following example command: 

```sh
ibmcloud resource service-instance-create NAME SERVICE_NAME SERVICE_PLAN_NAME LOCATION [-p, --parameters @JSON_FILE | JSON_STRING ]
```
{: codeblock}

{{site.data.keyword.cloudant_short_notm}} instances that are deployed on Dedicated Hardware environments take two more parameters:

Parameter | Description
----------|------------
`environment_crn` | This parameter must be set to the CRN of the {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware plan instance. You can determine what the CRN is by looking at the example CLI command in the Manage tab of the {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware plan instance in the {{site.data.keyword.cloud_notm}} Dashboard. Or you can determine what the CRN is by using the `ibmcloud resource service-instance SERVICE_INSTANCE_NAME` command. 
`legacyCredentials` | An optional parameter that defaults to true and dictates whether the instance uses both legacy and IAM credentials or IAM credentials only. See the [IAM guide](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-) for more details on choosing an authentication method.

See the following example command: 

```sh
ibmcloud resource service-instance-create cloudant_on_ded_hardware_cli cloudantnosqldb standard us-south -p '{"environment_crn":"crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b43434444bb7e2abb0841ca25d28ee4c:301a3118-7678-4d99-b1b7-4d45cf5f7b29::","legacyCredentials":false}'
```
{: codeblock}

## Creating the credentials for your {{site.data.keyword.cloudant_short_notm}} service
{: #creating-the-credentials-for-your-ibm-cloudant-service}

Applications that require access to your {{site.data.keyword.cloudant_short_notm}} service
must have the necessary credentials.

Service credentials are valuable. If anyone or any application has access to the credentials, they can effectively do whatever they want with the service instance. For example, they might create spurious data, or delete valuable information. Protect these credentials carefully.
{: important}

For more information about the fields included in the service credentials, see the [IAM guide](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-).

The basic command format to create credentials for a service instance
within {{site.data.keyword.cloud_notm}} is as follows:

```sh
ibmcloud resource service-key-create NAME ROLE_NAME --instance-name SERVICE_INSTANCE_NAME [-p '{"service-endpoints":"internal"}]
```
{: pre}

The fields are described in the following table:

Field | Description
------|------------
`NAME` | Arbitrary name that you give the service credentials. 
`ROLE_NAME` | This field currently allows the Manager role only.
`SERVICE_INSTANCE_NAME` | The name you give to your {{site.data.keyword.cloudant_short_notm}} instance.
`service-endpoints` | An optional parameter to populate the url field in the Service Credentials with an internal endpoint to connect to the service over the {{site.data.keyword.cloud_notm}} internal network. Omit this parameter to populate the url with an external endpoint that is publicly accessible. Only applies to Standard plan instances deployed on Dedicated Hardware environments that support internal endpoints. Command will result in a 400 error if the environment doesn't support internal endpoints. 

If you want to create credentials for the `cs20170517a` instance of
an {{site.data.keyword.cloudant_short_notm}} service (where the name for the credentials is `creds_for_cs20170517a`), you create these credentials by using a command similar to the following example:

```sh
ibmcloud resource service-key-create creds_for_cs20170517a Manager --instance-name cs20170517a
```
{: codeblock}

After receiving the request to create credentials for the service instance, {{site.data.keyword.cloud_notm}} responds with a message similar to the following example:

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

If you want to create credentials for the `cs20170517a` instance of
an {{site.data.keyword.cloudant_short_notm}} service (where the name for the credentials is `creds_for_cs20170517a`) and you want to populate the url with the internal endpoint, you create these credentials by using a command similar to the following example:

```sh
ibmcloud resource service-key-create creds_for_cs20170517a Manager --instance-name cs20170517a -p '{"service-endpoints":"internal"}'
```
{: codeblock}

After receiving the request to create credentials for the service instance, {{site.data.keyword.cloud_notm}} responds with a message similar to the following example:

```sh
Creating service key in resource group default of account John Does's Account as john.doe@email.com...
OK
Service key crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42223455bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3:resource-key:621ffde2-ea10-4318-b297-d6d849cec48a was created.
                  
Name:          creds_for_cs20170517a   
ID:            crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42223455bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3:resource-key:621ffde2-ea10-4318-b297-d6d849cec48a   
Created At:    Tue Jan 02 19:58:38 UTC 2019   
State:         active   
Credentials:                                   
               iam_apikey_name:          auto-generated-apikey-621ffde2-ea10-4318-b297-d6d849cec48a      
               iam_role_crn:             crn:v1:bluemix:public:iam::::serviceRole:Manager      
               url:                      https://2624fed5-e53e-41de-a85b-3c7d7636886f-bluemix.private.cloudantnosqldb.appdomain.cloud      
               username:                 f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix          
               apikey:                   XXXXX-XXXXXX_XXXXXXXXXXXXX-XXXXXXXXXXX      
               host:                     2624fed5-e53e-41de-a85b-3c7d7636886f-bluemix.private.cloudantnosqldb.appdomain.cloud      
               iam_apikey_description:   Auto generated apikey during resource-key operation for Instance - crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42116849bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3::      
               iam_serviceid_crn:        crn:v1:bluemix:public:iam-identity::a/b42116849bb7e2abb0841ca25d28ee4c::serviceid:ServiceId-53f9e2a2-cdfb-4f90-b072-bfffafb68b3e       
```
{: pre}

## Listing the service credentials for your {{site.data.keyword.cloudant_short_notm}} service
{: #listing-the-service-credentials-for-your-ibm-cloudant-service}

The basic command format to retrieve the credentials for a service instance
within {{site.data.keyword.cloud_notm}} is as follows:

```sh
ibmcloud resource service-key KEY_NAME
```
{: codeblock}

In this example, we want to retrieve credentials for the `cs20170517a` instance of
an {{site.data.keyword.cloudant_short_notm}} service
(where the name for the credentials is `creds_for_cs20170517a`), you retrieve the credentials by using a command similar to the following example:

```sh
ibmcloud resource service-key creds_for_cs20170517b
```
{: codeblock}

After receiving the request to retrieve the credentials for the service instance,
{{site.data.keyword.cloud_notm}} responds with a message similar to the following (abbreviated) example:

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
