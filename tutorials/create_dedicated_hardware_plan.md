---

copyright:
  years: 2017, 2020
lastupdated: "2020-05-06"

keywords: create dedicated hardware plan instance, provision standard plan instance, cli, create credentials, list service credentials

subcollection: Cloudant

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

<!-- Acrolinx: 2020-04-13 -->

# Creating and leveraging an {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware plan instance on {{site.data.keyword.cloud_notm}}
{: #creating-and-leveraging-an-ibm-cloudant-dedicated-hardware-plan-instance-on-ibm-cloud}

This tutorial shows you how to create an {{site.data.keyword.cloudantfull}} Dedicated Hardware plan instance that uses the {{site.data.keyword.cloud}} dashboard. After that exercise, we show you how to provision one or more Standard plan instances onto that Dedicated Hardware plan instance by using either the {{site.data.keyword.cloud_notm}} catalog or the {{site.data.keyword.cloud_notm}} CLI. 
{: shortdesc}

When you create an {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware plan instance, an {{site.data.keyword.cloudant_short_notm}} environment on dedicated hardware is created for your sole use. A service 
instance for the Dedicated Hardware plan environment is also created in the {{site.data.keyword.cloud_notm}} dashboard. You can't access the Dedicated Hardware plan instance directly, nor have any Service Credentials for it. Instead, you use your {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware 
plan instance by creating one or more Standard plan instances on it, and managing the Standard plan instances directly.

## Creating an {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware plan instance
{: #creating-an-ibm-cloudant-dedicated-hardware-plan-instance}

1.  Log in to your {{site.data.keyword.cloud_notm}} account.

    The {{site.data.keyword.cloud_notm}} dashboard can be found by using the following website:
    [`https://cloud.ibm.com/`](https://cloud.ibm.com/){: new_window}{: external}.
    After you authenticate with your username name and password,
    you're presented with the {{site.data.keyword.cloud_notm}} dashboard. Click the `Create resource` button:
    
    ![{{site.data.keyword.cloud_notm}} dashboard](images/img0001.png){: caption="Figure 1. {{site.data.keyword.cloudant_short_notm}} dashboard" caption-side="bottom"}

2.  Click `Databases` from the menu and `Cloudant` from the list of database services.

     ![{{site.data.keyword.cloud_notm}} {{site.data.keyword.cloudant_short_notm}} service selection](images/img0003.png){: caption="Figure 2. {{site.data.keyword.cloud_notm}} {{site.data.keyword.cloudant_short_notm}} service selection" caption-side="bottom"}
 
3.  Select the `Dedicated Hardware` plan from the list of pricing plans:

    ![Pricing plans](images/pricing_plan.png){: caption="Figure 3. Pricing plans" caption-side="bottom"}
    
4.  Complete the following parameters: 

    -   Select the region where you want to deploy from the drop-down menu (at the beginning of the page). For Dedicated hardware provisioned instances, you can select from the major {{site.data.keyword.cloud_notm}} regions in the {{site.data.keyword.cloud_notm}} dashboard. However, the actual physical location of the Dedicated Hardware instance is dictated by the location parameter in a later step.
    
    -   Enter a service name.
    
    -   Select a resource group.
    
    -   (Optional) Add a tag.
    
    -   Select a key management service instance. All {{site.data.keyword.cloudant_short_notm}} environments are encrypted. If you would like to use bring-your-own-key (BYOK) encryption with Key Protect, select the Key Protect instance that holds the encryption key from the drop-down menu. Otherwise, choose the Automatic disk encryption key (default) option, which means the environment is encrypted with an {{site.data.keyword.cloudant_short_notm}}-managed key. In order to BYOK with Key Protect, you must ensure that {{site.data.keyword.cloudant_short_notm}} is authorized to access the selected key management service instance. You can manage service-to-service authorizations at any time by visiting **Manage** > **Security** > **Identity and Access** and choosing **Authorizations**.
    
    -   Select a disk encryption key. Choose the disk encryption key from the drop-down menu that resides in the Key Protect instance that is chosen in the key management service instance parameter. If you use the default {{site.data.keyword.cloudant_short_notm}}-managed key option, then this parameter is set to Automatic disk encryption key (default).  

    -   Select a location for deployment. This location is the physical location of the instance, which can be in any {{site.data.keyword.cloud_notm}} location, including major regions and locations outside the major regions. For more information, see [{{site.data.keyword.IBM}} global data centers](https://www.ibm.com/cloud/data-centers/){:new_window}{: external}.
    
    -   Select `yes` or `no` to answer whether HIPAA is required.

    HIPAA is only valid for US locations. {{site.data.keyword.IBM}} can provision a Dedicated Hardware plan environment to implement HIPAA controls. An environment is only created upon confirmation of a Business Associate Agreement (BAA) that is established with {{site.data.keyword.IBM_notm}}. For more information, see [Enabling the HIPAA Supported setting](https://cloud.ibm.com/docs/account/eu_hipaa_supported.html#enabling-the-hipaa-supported-setting) and the Service Description terms for more details. Provisioning a cluster to manage HIPAA data can take longer than the estimated 5-day period.
    {: note}

    ![Resource configuration page](images/select_deployment_location.png){: caption="Figure 4. Resource configuration page" caption-side="bottom"}
        
5.  Click the `Create` button to start the provisioning process. 

    Billing is calculated and prorated every day. Make sure that you want to provision and pay for an environment before you click the **Create** button.
    {: note}

    ![Provision dedicated hardware](images/create_button_provision.png){: caption="Figure 5. Provision dedicated hardware" caption-side="bottom"}

    During provisioning, a spinning wheel appears next to the instance in your {{site.data.keyword.cloud_notm}} dashboard. A request is sent to provision a Dedicated Hardware plan instance on bare metal servers. Provisioning time is asynchronous and can take up to 5 days. 
    {: note}   
    
## Provisioning a Standard plan instance on a Dedicated Hardware environment
{: #provisioning-a-standard-plan-instance-on-a-dedicated-hardware-environment}

1.  Log in to your {{site.data.keyword.cloud_notm}} account.

    The {{site.data.keyword.cloud_notm}} dashboard can be found at:
    [https://cloud.ibm.com/](https://cloud.ibm.com/){: new_window}{: external}.
    After you authenticate with your username and password,
    you're presented with the {{site.data.keyword.cloud_notm}} dashboard. Click the `Create resource` button shown in the following image.
    
    ![{{site.data.keyword.cloud_notm}} dashboard](images/img0001.png){: caption="Figure 6. {{site.data.keyword.cloud_notm}} dashboard" caption-side="bottom"}

2.  Click `Databases` from the menu and `Cloudant` from the list of database services.

     ![{{site.data.keyword.cloud_notm}} {{site.data.keyword.cloudant_short_notm}} service selection](images/img0003.png){: caption="Figure 7. {{site.data.keyword.cloud_notm}} {{site.data.keyword.cloudant_short_notm}} service selection" caption-side="bottom"}
    
    The page for creating a service appears.  

3.  Click `Standard` from the pricing plans. 

    ![Standard pricing plan](images/standard_pricing_plan.png){: caption="Figure 8. Standard pricing plan" caption-side="bottom"}
    
    You can't provision a Lite plan instance on a Dedicated Hardware environment.
    {: tip}
    
4.  Complete the following parameters: 

    -   Specify the region where you want to deploy (at the beginning of the page). 
    
    -   Enter a service name.
    
    -   Select a resource group. 
    
    -   Add a tag. 

    -   Select an authentication method.
    
    -   Select an environment, which is where the Standard plan instance deploys. By default, the Standard plan instance deploys on a multi-tenant environment in the location defined by the region parameter. Any Dedicated Hardware environment instances that are deployed in the {{site.data.keyword.cloud_notm}} account that the provisioning user has permissions to view display in the drop-down. If you select  a Dedicated Hardware plan instance from the drop-down menu, a Standard plan instance deploys on that Dedicated Hardware plan instance in the location where it resides.
    
    ![Resource configuration page](images/select_environment.png){: caption="Figure 9. Resource configuration page" caption-side="bottom"}
    
5.  Click the `Create` button.

    After a few seconds, the instance is provisioned on the environment you selected.
    
    ![Provision standard instance](images/create_button_provision_standard.png){: caption="Figure 10. Provision standard instance" caption-side="bottom"}
    
6.  Take note of your Service Credentials and access the {{site.data.keyword.cloudant_short_notm}} dashboard 
    as you do for a multi-tenant {{site.data.keyword.cloudant_short_notm}} instance. 
    
    For more information, see [how to locate your service credentials](/docs/Cloudant?topic=Cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud#locating-your-service-credentials){: new_window}. 
    
## Provisioning a Dedicated Hardware plan instance with the {{site.data.keyword.cloud_notm}} CLI
{: #provisioning-a-dedicated-hardware-plan-instance-with-the-ibm-cloud-cli}

To use the {{site.data.keyword.cloud_notm}} CLI, you must be logged in. For more information, see [log in to your {{site.data.keyword.cloud_notm}} account](/docs/Cloudant?topic=Cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud-by-using-the-ibm-cloud-cli#logging-in-to-your-ibm-cloud-account){: new_window} to learn about how to log in and set a target resource group. 

To create an {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware plan instance, use the following basic command format:

Field | Description
------|------------
`NAME`| An arbitrary name that you assign the instance.
`SERVICE_NAME` | `cloudantnosqldb`
`PLAN_NAME` | `dedicated-hardware`
`REGION` |  The major region where you want to deploy, for example, us-south, us-east, or eu-gb. 
{: caption="Table 1. Basic command format" caption-side="top"}

See the following example command: 

```sh
ibmcloud resource service-instance-create $NAME $SERVICE_NAME $PLAN_NAME $REGION [-p, --parameters @JSON_FILE | JSON_STRING ]
```
{: codeblock}

{{site.data.keyword.cloudant_short_notm}} Dedicated Hardware plan instances take four more parameters:

Parameter | Description
----------|------------
`location` | The actual physical location of the Dedicated Hardware plan instance, which might differ from the REGION. The location can be in any {{site.data.keyword.cloud_notm}} location, including major regions and locations outside the major regions. For more information, see [{{site.data.keyword.IBM}} global data centers](https://www.ibm.com/cloud/data-centers/){:new_window}{: external}. 
`hipaa` | Either `true` or `false`. 
`kms_instance_crn` | An optional parameter that must be set to the CRN of the Key Protect instance housing the encryption key for BYOK. All {{site.data.keyword.cloudant_short_notm}} environments are encrypted. If you would like to BYOK with Key Protect, supply the CRN of the Key Protect instance that holds the encryption key. Otherwise, don't supply this parameter in the CLI, which means the environment is encrypted with an {{site.data.keyword.cloudant_short_notm}}-managed key. In order to BYOK with Key Protect, ensure that {{site.data.keyword.cloudant_short_notm}} is authorized to access the selected key management service instance. You can manage service-to-service authorizations at any time by visiting **Manage** > **Security** > **Identity and Access** and choosing **Authorizations**.
`kms_key_crn` | This parameter is required if you use the `kms_instance_crn` parameter. Otherwise, it must not be supplied in the CLI command. The `kms_key_crn` parameter is set to the CRN of the encryption key stored in the Key Protect instance defined by the `kms_instance_crn` parameter. 
{: caption="Table 2. Additional parameters" caption-side="top"}

See the following example command: 

```sh
ibmcloud resource service-instance-create cloudant-dedicated-with-byok cloudantnosqldb dedicated-hardware us-south -p '{"location":"dallas", "hipaa":"false", "kms_instance_crn": "crn:v1:bluemix:public:kms:us-south:a/abcdefg7df5907a4ae72ad28d9f493d6:888a5a41-543c-4ca7-af83-74da3bb8f711::", "kms_key_crn": "crn:v1:bluemix:public:kms:us-south:a/abcdefg7df5907a4ae72ad28d9f493d6:888a5a41-543c-4ca7-af83-74da3bb8f711:key:0123c653-f904-4fe7-9fdb-5097e1ed85db"}'
```
{: codeblock}

## Provisioning a Standard plan instance on a Dedicated Hardware environment with the {{site.data.keyword.cloud_notm}} CLI
{: #provisioning-a-standard-plan-instance-on-a-dedicated-hardware-environment-with-the-ibm-cloud-cli}

To use the {{site.data.keyword.cloud_notm}} CLI, you must be logged in. For more information about how to log in and set a target resource group, see [log in to your {{site.data.keyword.cloud_notm}} account](/docs/Cloudant?topic=Cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud-by-using-the-ibm-cloud-cli#logging-in-to-your-ibm-cloud-account){: new_window}. 

To create an {{site.data.keyword.cloudant_short_notm}} Standard plan instance on your {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware plan environment, use the following basic command format.


Field | Description
------|------------
`NAME`| An arbitrary name that you assign the instance.
`SERVICE_NAME` | `cloudantnosqldb`
`PLAN_NAME` | `standard`
`REGION` |  The region where you want to deploy, for example, us-south, us-east, or eu-gb. 
{: caption="Table 3. Basic command format" caption-side="top"}

See the following example command: 

```sh
ibmcloud resource service-instance-create $NAME $SERVICE_NAME $PLAN_NAME $REGION [-p, --parameters @JSON_FILE | JSON_STRING ]
```
{: codeblock}

{{site.data.keyword.cloudant_short_notm}} instances that are deployed on Dedicated Hardware environments take two more parameters.

Parameter | Description
----------|------------
`environment_crn` | This parameter must be set to the CRN of the {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware plan instance. You can determine what the CRN is by looking at the example CLI command in the Manage tab of the {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware plan instance in the {{site.data.keyword.cloud_notm}} dashboard. Or you can determine what the CRN is by using the `ibmcloud resource service-instance SERVICE_INSTANCE_NAME` command. 
`legacyCredentials` | An optional parameter that defaults to true and dictates whether the instance uses both legacy and IAM credentials or IAM credentials only. See the [IAM guide](/docs/Cloudant?topic=Cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-) for more details on choosing an authentication method.
{: caption="Table 4. Additional parameters" caption-side="top"}

See the following example command: 

```sh
ibmcloud resource service-instance-create cloudant_on_ded_hardware_cli cloudantnosqldb standard us-south -p '{"environment_crn":"crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b43434444bb7e2abb0841ca25d28ee4c:301a3118-7678-4d99-b1b7-4d45cf5f7b29::","legacyCredentials":false}'
```
{: codeblock}

## Creating the credentials for your {{site.data.keyword.cloudant_short_notm}} service
{: #creating-the-credentials-for-your-ibm-cloudant-service}

Applications that require access to your {{site.data.keyword.cloudant_short_notm}} service
must have the necessary credentials.

Service credentials are valuable. If anyone or any application gains access to the credentials, they can effectively do whatever they want with the service instance. For example, they might create spurious data, or delete valuable information. Protect these credentials carefully.
{: important}

For more information about the fields included in the service credentials, see the [IAM guide](/docs/Cloudant?topic=Cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-).

You can use the basic command format to create credentials for a service instance within {{site.data.keyword.cloud_notm}}:

```sh
ibmcloud resource service-key-create NAME ROLE_NAME --instance-name SERVICE_INSTANCE_NAME [-p '{"service-endpoints":"internal"}]
```
{: pre}

The fields are described in the following table.

Field | Description
------|------------
`NAME` | Arbitrary name that you give the service credentials. 
`ROLE_NAME` | This field currently allows the Manager role only.
`SERVICE_INSTANCE_NAME` | The name that you give to your {{site.data.keyword.cloudant_short_notm}} instance.
`service-endpoints` | An optional parameter to populate the URL field in the Service Credentials with an internal endpoint to connect to the service over the {{site.data.keyword.cloud_notm}} internal network. Omit this parameter to populate the URL with an external endpoint that is publicly accessible. Applies only to Standard plan instances deployed on Dedicated Hardware environments that support internal endpoints. If the environment doesn't support internal endpoints, the result is a 400 error. 
{: caption="Table 5. Basic command format" caption-side="top"}

If you want to create credentials for the `cs20170517a` instance of
an {{site.data.keyword.cloudant_short_notm}} service (where the name for the credentials is `creds_for_cs20170517a`), you can create these credentials by using a command similar to the following example.

```sh
ibmcloud resource service-key-create creds_for_cs20170517a Manager --instance-name cs20170517a
```
{: codeblock}

After you receive the request to create credentials for the service instance, {{site.data.keyword.cloud_notm}} responds with a message similar to the following example.

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
an {{site.data.keyword.cloudant_short_notm}} service (where the name for the credentials is `creds_for_cs20170517a`) and you want to populate the URL with the internal endpoint, you create these credentials by using a command similar to the following example.

```sh
ibmcloud resource service-key-create creds_for_cs20170517a Manager --instance-name cs20170517a -p '{"service-endpoints":"internal"}'
```
{: codeblock}

After you receive the request to create credentials for the service instance, {{site.data.keyword.cloud_notm}} responds with a message similar to the following example.

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
within {{site.data.keyword.cloud_notm}} is shown in the following example.

```sh
ibmcloud resource service-key KEY_NAME
```
{: codeblock}

In this example, we want to retrieve credentials for the `cs20170517a` instance of
an {{site.data.keyword.cloudant_short_notm}} service
(where the name for the credentials is `creds_for_cs20170517a`). You can retrieve the credentials by using a command similar to the following example.

```sh
ibmcloud resource service-key creds_for_cs20170517b
```
{: codeblock}

After you receive the request to retrieve the credentials for the service instance,
{{site.data.keyword.cloud_notm}} responds with a message similar to the following (abbreviated) example.

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
