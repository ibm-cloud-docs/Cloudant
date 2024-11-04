---
copyright:
  years: 2020, 2023
lastupdated: "2023-11-03"

keywords: use dedicated hardware plan, create dedicated hardware plan instance, provision standard plan instance, cli, create credentials, list service credentials

subcollection: Cloudant

content-type: tutorial
services: Cloudant
account-plan: dedicated
completion-time: 20m

---

{{site.data.keyword.attribute-definition-list}}

# Using a Dedicated Hardware plan instance
{: #creating-and-leveraging-an-ibm-cloudant-dedicated-hardware-plan-instance-on-ibm-cloud}
{: toc-content-type="tutorial"}
{: toc-services="Cloudant"}
{: toc-completion-time="20m"}

This tutorial shows you how to create an {{site.data.keyword.cloudantfull}} Dedicated Hardware plan instance that uses the {{site.data.keyword.cloud}} Dashboard. 
{: shortdesc}

After that exercise, you learn how to provision one or more Standard plan instances to run on the {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware plan instance by using either the {{site.data.keyword.cloud_notm}} catalog or the {{site.data.keyword.cloud_notm}} CLI. 

When you create an {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware plan instance, an {{site.data.keyword.cloudant_short_notm}} environment on dedicated hardware is created for your sole use. A service 
instance for the Dedicated Hardware plan environment is also created in the {{site.data.keyword.cloud_notm}} Dashboard. You can't access the Dedicated Hardware plan instance directly, or have 
any Service Credentials for it. Instead, you use your {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware 
plan instance by creating one or more Standard plan instances on it, and managing the Standard plan instances directly.

## Objectives
{: #objectives-dhp}

1. Create a Dedicated Hardware plan instance.
2. Provision a Standard plan instance on a Dedicated Hardware environment.
3. Provision a Dedicated Hardware plan instance with the {{site.data.keyword.cloud_notm}} CLI.
4. Provision a Standard plan instance on a Dedicated Hardware environment with the {{site.data.keyword.cloud_notm}} CLI.
5. Create the credentials for your {{site.data.keyword.cloudant_short_notm}} service.
6. List the service credentials for your {{site.data.keyword.cloudant_short_notm}} service.

## Creating an {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware plan instance
{: #creating-an-ibm-cloudant-dedicated-hardware-plan-instance}
{: step}

1.  Log in to your {{site.data.keyword.cloud_notm}} account.

    The {{site.data.keyword.cloud_notm}} Dashboard can be found by using the following website:
    [https://cloud.ibm.com/](https://cloud.ibm.com/){: external}.
    After you authenticate with your username and password,
    the {{site.data.keyword.cloud_notm}} Dashboard opens. 

2.  Click **Create resource**. 

3.  Type `Cloudant` in the Search bar and open it. 

4. Select the Cloudant offering.

5.  Select an environment.

    For Dedicated Hardware provisioned instances, you can select from the major {{site.data.keyword.cloud_notm}} regions in the {{site.data.keyword.cloud_notm}} Dashboard. However, the actual physical location of the Dedicated Hardware instance is dictated by the location parameter in a later step.
    {: note}

    1. Click **Dedicated**.

    2. Click **Create Host**. 

       ![Create a host by clicking the Create host button.](images/img0005d.png){: caption="Host selection" caption-side="bottom"}

    3. Select from the {{site.data.keyword.cloud_notm}} regions.

6.  Configure the Host.

    1. Select a location for deployment.

       This location is the physical location of the instance, which can be in any {{site.data.keyword.cloud_notm}} location, including locations outside the major regions. For more information, see [{{site.data.keyword.IBM}} global data centers](https://www.ibm.com/cloud/data-centers/){: external}.

    2. Select `Yes` or `No` to answer whether HIPAA is required.

       A HIPAA compliant environment can be provisioned in either a multi-tenant or Dedicated environment. But it is only created upon confirmation of a Business Associate Agreement (BAA) that is established with {{site.data.keyword.IBM_notm}}. For more information, see [Enabling the HIPAA Supported setting](/docs/account/eu_hipaa_supported.html#enabling-the-hipaa-supported-setting) and the Service Description terms for more details. Provisioning a cluster to manage HIPAA data can take longer than the estimated 5-day period.
       {: note}

    3. Select a key management service instance.

       All {{site.data.keyword.cloudant_short_notm}} environments are encrypted. If you would like to use bring-your-own-key (BYOK) encryption with Key Protect, select the Key Protect instance that holds the encryption key from the drop-down menu. Otherwise, choose the Automatic disk encryption key (default) option, which means the environment is encrypted with an {{site.data.keyword.cloudant_short_notm}}-managed key. In order to BYOK with Key Protect, you must ensure that {{site.data.keyword.cloudant_short_notm}} is authorized to access the selected key management service instance. You can manage service-to-service authorizations at any time. Visit **Manage** > **Access (IAM)** and choose **Authorizations**.

       When you configure service-to-service authorizations, remember the authorization works at the account level, not the resource group level.
       {: important}

    4. Select a disk encryption key.

       Choose the disk encryption key from the drop-down menu that resides in the Key Protect instance that is chosen in the key management service instance parameter. If you use the default {{site.data.keyword.cloudant_short_notm}}-managed key option, then this parameter is set to Automatic disk encryption key (default). 

    ![Configure the host by specifying the location for deployment, HIPAA  compliance, Key Management Service instance, and disk encryption key.](images/img0005f.png){: caption="Host configuration" caption-side="bottom"}

7.  Click **Create** to start the provisioning process.

    Billing is calculated and prorated every day. Make sure that you want to provision and pay for an environment before you click **Create**. 
    {: note}

    ![Do not click Create unless you want to provision and pay for an environment.](images/create_button_provision.png){: caption="Provision dedicated hardware" caption-side="bottom"}

## Provisioning a Standard plan instance on a Dedicated Hardware environment
{: #provisioning-a-standard-plan-instance-on-a-dedicated-hardware-environment}
{: step}

After your instance is created, you must create a Standard plan on it by selecting the Dedicated tab when you create the Standard instance.

1.  Log in to your {{site.data.keyword.cloud_notm}} account.

    The {{site.data.keyword.cloud_notm}} Dashboard can be found at:
    [https://cloud.ibm.com/](https://cloud.ibm.com/){: external}.
    After you authenticate with your username and password,
    you're presented with the {{site.data.keyword.cloud_notm}} Dashboard. Click **Create resource**.

2.  Type `Cloudant` in the Search bar and click to search.

3.  Select an offering.

    You can't provision a Lite plan instance on a Dedicated Hardware environment.
    {: tip}

4.  Select an environment.

    For Dedicated Hardware provisioned instances, you can select from the major {{site.data.keyword.cloud_notm}} regions in the {{site.data.keyword.cloud_notm}} Dashboard. However, the actual physical location of the Dedicated Hardware instance is dictated by the location parameter in a later step.
    {: note}

    1. Click **Dedicated**.

    2. Click **Select existing host**.

    3. Select the dedicated environment that you created from the drop-down menu.    
       The screen capture shows the example environment, `Dedicated Hardware Environment (staging)`. 

    ![From the Select an environment window. Select the Dedicated Hardware Environment. ](images/img0005h.png){: caption="Dedicated environment" caption-side="bottom"}

    4. Select the appropriate {{site.data.keyword.cloud_notm}} region. 

    ![From the Select an environment window, create an {{site.data.keyword.cloud_notm}} region.](images/img0005d2.png){: caption="{{site.data.keyword.cloud_notm}} region" caption-side="bottom"}

5.  Configure the {{site.data.keyword.cloudant_short_notm}} instance.

    1. Enter an instance name or accept the pre-filled name.

    2. Select a resource group.

    3. (Optional) Add a tag.

    4. Select an authentication method.    
       The Standard plan is the only plan you can use with the Dedicated Hardware environment. 

    ![Configure your {{site.data.keyword.cloudant_short_notm}} instance.](images/img0005e.png){: caption="{{site.data.keyword.cloudant_short_notm}} instance" caption-side="bottom"}

6.  Click **Create**.    
    After a few seconds, the instance is provisioned on the environment you selected. 

    ![Provision a standard plan by using the create button.](images/create_button_provision_standard.png){: caption="Standard instance" caption-side="bottom"}

7.  Take note of your Service Credentials and access the {{site.data.keyword.cloudant_short_notm}} Dashboard as you do for a multi-tenant {{site.data.keyword.cloudant_short_notm}} instance.

    For more information, see [how to locate your service credentials](/docs/Cloudant?topic=Cloudant-locating-your-service-credentials){: external}.

## Provisioning a Dedicated Hardware plan instance with the {{site.data.keyword.cloud_notm}} CLI
{: #provisioning-a-dedicated-hardware-plan-instance-with-the-ibm-cloud-cli}
{: step}

1. Log in to {{site.data.keyword.cloud_notm}} to use {{site.data.keyword.cloud_notm}} CLI.     
    For more information, see [log in to your {{site.data.keyword.cloud_notm}} account](/docs/Cloudant?topic=Cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud-by-using-the-ibm-cloud-cli#logging-in-to-your-ibm-cloud-account){: external} to learn about how to log in and set a target resource group.

2. Use the following basic command format to create an {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware plan instance by using {{site.data.keyword.cloud_notm}} CLI.

    ```sh
    ibmcloud resource service-instance-create $NAME $SERVICE_NAME $PLAN_NAME $REGION [-p, --parameters @JSON_FILE | JSON_STRING ]
    ```
    {: codeblock}

| Field | Description |
|------|------------|
| `NAME`| An arbitrary name that you assign the instance. |
| `SERVICE_NAME` | `cloudantnosqldb` |
| `PLAN_NAME` | `dedicated-hardware` |
| `REGION` |  The major region where you want to deploy, for example, us-south, us-east, or eu-gb. |
{: caption="Basic command format" caption-side="top"}

{{site.data.keyword.cloudant_short_notm}} Dedicated Hardware plan instances take four more parameters.

| Parameter | Description |
|----------|------------|
| `location` | The actual physical location of the Dedicated Hardware plan instance, which might differ from the REGION. The location can be in any {{site.data.keyword.cloud_notm}} location, including major regions and locations outside the major regions. For more information, see [{{site.data.keyword.IBM}} global data centers](https://www.ibm.com/cloud/data-centers/){: external}. |
| `hipaa` | Either `true` or `false`. |
| `kms_instance_crn` | An optional parameter that must be set to the CRN of the Key Protect instance housing the encryption key for BYOK. All {{site.data.keyword.cloudant_short_notm}} environments are encrypted. If you would like to BYOK with Key Protect, supply the CRN of the Key Protect instance that holds the encryption key. Otherwise, don't supply this parameter in the CLI, which means the environment is encrypted with an {{site.data.keyword.cloudant_short_notm}}-managed key. In order to BYOK with Key Protect, ensure that {{site.data.keyword.cloudant_short_notm}} is authorized to access the selected key management service instance. You can manage service-to-service authorizations at any time by visiting **Manage** > **Security** > **Identity and Access** and choosing **Authorizations**. |
| `kms_key_crn` | This parameter is required if you use the `kms_instance_crn` parameter. Otherwise, it must not be supplied in the CLI command. The `kms_key_crn` parameter is set to the CRN of the encryption key that is stored in the Key Protect instance that is defined by the `kms_instance_crn` parameter. |
{: caption="Parameters" caption-side="top"}

The following example command includes the extra parameters.

```sh
ibmcloud resource service-instance-create cloudant-dedicated-with-byok cloudantnosqldb dedicated-hardware us-south -p '{"location":"dallas", "hipaa":"false", "kms_instance_crn": "crn:v1:bluemix:public:kms:us-south:a/abcdefg7df5907a4ae72ad28d9f493d6:888a5a41-543c-4ca7-af83-74da3bb8f711::", "kms_key_crn": "crn:v1:bluemix:public:kms:us-south:a/abcdefg7df5907a4ae72ad28d9f493d6:888a5a41-543c-4ca7-af83-74da3bb8f711:key:0123c653-f904-4fe7-9fdb-5097e1ed85db"}'
```
{: codeblock}

## Provisioning a Standard plan instance on a Dedicated Hardware environment with the {{site.data.keyword.cloud_notm}} CLI
{: #provisioning-a-standard-plan-instance-on-a-dedicated-hardware-environment-with-the-ibm-cloud-cli}
{: step} 

1.  Log in to use the {{site.data.keyword.cloud_notm}} CLI.     For more information about how to log in and set a target resource group, see [log in to your {{site.data.keyword.cloud_notm}} account](/docs/Cloudant?topic=Cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud-by-using-the-ibm-cloud-cli#logging-in-to-your-ibm-cloud-account){: external}.

2.  Create an {{site.data.keyword.cloudant_short_notm}} Standard plan instance on your {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware plan environment by using the following basic command format.

    ```sh
    ibmcloud resource service-instance-create $NAME $SERVICE_NAME $PLAN_NAME $REGION [-p, --parameters @JSON_FILE | JSON_STRING ]
    ```
    {: codeblock}

| Field | Description |
|------|------------|
| `NAME`| An arbitrary name that you assign the instance. |
| `SERVICE_NAME` | `cloudantnosqldb` |
| `PLAN_NAME` | `standard` |
| `REGION` |  The region where you want to deploy, for example, us-south, us-east, or eu-gb. |
{: caption="Basic command format" caption-side="top"}

{{site.data.keyword.cloudant_short_notm}} instances that are deployed on Dedicated Hardware environments take two more parameters.

| Parameter | Description |
|----------|------------|
| `environment_crn` | This parameter must be set to the CRN of the {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware plan instance. You can determine what the CRN is by looking at the example CLI command in the Manage tab of the {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware plan instance in the {{site.data.keyword.cloud_notm}} Dashboard. Or you can determine what the CRN is by using the `ibmcloud resource service-instance SERVICE_INSTANCE_NAME` command. |
| `legacyCredentials` | An optional parameter that defaults to true and dictates whether the instance uses both legacy and IAM credentials or IAM credentials only. See the [IAM guide](/docs/Cloudant?topic=Cloudant-managing-access-for-cloudant) for more details on choosing an authentication method. |
{: caption="Parameters" caption-side="top"}

The following example command includes the extra parameters.

```sh
ibmcloud resource service-instance-create cloudant_on_ded_hardware_cli cloudantnosqldb standard us-south -p '{"environment_crn":"crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b43434444bb7e2abb0841ca25d28ee4c:301a3118-7678-4d99-b1b7-4d45cf5f7b29::","legacyCredentials":false}'
```
{: codeblock}

## Creating the credentials for your {{site.data.keyword.cloudant_short_notm}} service
{: #creating-the-credentials-for-your-ibm-cloudant-service}
{: step}

Applications that require access to your {{site.data.keyword.cloudant_short_notm}} service
must have the necessary credentials.

Service credentials are valuable. If anyone or any application gains access to the credentials, they can effectively do whatever they want with the service instance. For example, they might create spurious data, or delete valuable information. Protect these credentials carefully. For more information about the fields included in the service credentials, see the [IAM guide](/docs/Cloudant?topic=Cloudant-managing-access-for-cloudant).
{: important}

The fields for the basic command format that is used in this exercise are described in the following table.

| Field | Description |
|------|------------|
| `NAME` | Arbitrary name that you give the service credentials. |
| `ROLE_NAME` | This field currently allows the Manager role only. |
| `SERVICE_INSTANCE_NAME` | The name that you give to your {{site.data.keyword.cloudant_short_notm}} instance. |
| `service-endpoints` | An optional parameter to populate the URL field in the Service Credentials with an internal endpoint to connect to the service over the {{site.data.keyword.cloud_notm}} internal network. Omit this parameter to populate the URL with an external endpoint that is publicly accessible. Applies only to Standard plan instances deployed on Dedicated Hardware environments that support internal endpoints. If the environment doesn't support internal endpoints, the result is a 400 error. |
{: caption="Basic command format" caption-side="top"}


The basic command format to retrieve the credentials for a service instance within IBM Cloud is shown in the following example.

```sh
ibmcloud resource service-key-create NAME ROLE_NAME --instance-name SERVICE_INSTANCE_NAME [-p '{"service-endpoints":"internal"}]
```
{: pre}

The fields for the basic command format are described in the previous table.
{: note}

1. Create credentials for the `cs20170517a` instance of an {{site.data.keyword.cloudant_short_notm}} service, and name the credentials `creds_for_cs20170517a`. 

    ```sh
    ibmcloud resource service-key-create creds_for_cs20170517a Manager --instance-name cs20170517a
    ```
    {: codeblock}

2. After you receive the request to create credentials for the service instance, review the {{site.data.keyword.cloud_notm}} response that includes a message similar to the following (abbreviated) example with your credentials.

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
                   iam_role_crn:   crn:v1:bluemix:public:iam::::serviceRole:Manager
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

3.  Populate the URL with the internal endpoint, and create the credentials by using a command similar to the following example.

    ```sh
    ibmcloud resource service-key-create creds_for_cs20170517a Manager --instance-name cs20170517a -p '{"service-endpoints":"internal"}'
    ```
    {: codeblock}

4.  Review the request response in a message similar to the following example. 

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
                    iam_serviceid_crn:        crn:v1:bluemix:public:iam-identity::a/b42116849bb7e2abb0841ca25d28ee4c::serviceid:ServiceId-53f9e2a2-cdfb-4fo0                  90-b072-bfffafb68b3e
    ```
    {: pre}
    
## Listing the service credentials for your {{site.data.keyword.cloudant_short_notm}} service
{: #listing-the-service-credentials-for-your-ibm-cloudant-service}
{: step}

The basic command format to retrieve the credentials for a service instance
within {{site.data.keyword.cloud_notm}} is shown in the following example.

```sh
ibmcloud resource service-key KEY_NAME
```
{: codeblock}


1. Retrieve your credentials `cs20170517a` (where the name for the credentials is `creds_for_cs20170517a`) by using a command similar to the following example.

    ```sh
    ibmcloud resource service-key creds_for_cs20170517b
    ```
    {: codeblock}

2. Review the {{site.data.keyword.cloud_notm}} response that includes your credentials and a message similar to the following (abbreviated) example.

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
