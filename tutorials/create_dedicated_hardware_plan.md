---

copyright:
  years: 2015, 2018
lastupdated: "2018-09-07"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:tip: .tip}

<!-- Acrolinx: 2017-02-23 -->

# Creating and leveraging an {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware plan instance on {{site.data.keyword.cloud_notm}}

This tutorial shows you how to create an {{site.data.keyword.cloudantfull}} Dedicated Hardware plan instance 
using the {{site.data.keyword.cloud}} dashboard, and shows you how to subsequently provision one or 
more Standard plan instances to run on it. 

Creating an {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware plan instance results in the provisioning 
of an {{site.data.keyword.cloudant_short_notm}} environment on dedicated hardware for your sole use. A service 
instance is created in the {{site.data.keyword.cloud_notm}} dashboard, but you cannot 
access the Dedicated Hardware plan instance directly and will not have 
any Service Credentials for it. You can use an {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware 
plan instance after it is created by provisioning one or more Standard plan 
instances on it.

## Creating an {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware plan instance

1.  Log in to your {{site.data.keyword.cloud_notm}} account.<br/>
    The {{site.data.keyword.cloud_notm}} dashboard can be found at:
    [http://bluemix.net ![External link icon](../images/launch-glyph.svg "External link icon")](http://bluemix.net){:new_window}.
    After authenticating with your user name and password,
    you are presented with the {{site.data.keyword.cloud_notm}} dashboard:<br/>
    ![{{site.data.keyword.cloud_notm}} dashboard](images/img0001.png)

2.  Click the `Create resource` button:<br/>
    ![{{site.data.keyword.cloud_notm}} create resource button](images/img0002.png)<br/>
    
3.  See the {{site.data.keyword.cloud_notm}} catalog and services that are     available. Click the `Databases` category.
    ![{{site.data.keyword.cloud_notm}} catalog](images/img0000.png)

4.  Click the {{site.data.keyword.cloudant_short_notm}} service:<br/>
    ![{{site.data.keyword.cloud_notm}} {{site.data.keyword.cloudant_short_notm}} service selection](images/img0003.png)<br/>
    The page for creating a service appears.

5.  Select the `Dedicated Hardware` plan from the list of pricing plans at the bottom of the page:<br/>
    ![Pricing plans](../tutorials/images/pricing_plan.png)
    
6.  Fill out the following parameters at the top of the page: <br/>
    -   Enter a service name.<br/>
    -   Specify the region/location where you want to deploy.<br/>
    -   Select a resource group.</br>
    -   Select a location for deployment.<br/>
    -   Select `yes` or `no` to answer whether HIPAA is required.<br/>
   
    HIPAA is only valid for U.S. locations. {{site.data.keyword.IBM}} can provision a Dedicated or Bare Metal cluster to implement HIPAA controls. A cluster is only provisioned upon confirmation of a Business Associate Agreement (BAA) that is established with {{site.data.keyword.IBM_notm}}. This agreement is described in the Service Description terms. Provisioning a cluster to manage HIPAA data can take longer than the estimated 5-day period.
    {: tip}
    
    You deploy and provision Standard plan instances in the same region and space.
    {: tip}

    ![Configure dedicated hardware](../tutorials/images/select_deployment_location.png)
        
7.  Click the `Create` button to start the provisioning process. <br/>

    Billing is prorated daily so make sure that you want to provision and pay for an environment before clicking the **Create** button.
    {: tip}

    ![Provision dedicated hardware](../tutorials/images/create_button_provision.png)

    During provisioning, a spinning wheel appears next to the instance in your {{site.data.keyword.cloud_notm}} dashboard. A request is sent to provision a Dedicated Hardware plan instance on bare metal servers. Provisioning time is asynchronous and can take up to 5 days. 
    {: tip}   

    ![Provision dedicated hardware alternate version](../tutorials/images/create_button_provision2.png)
    
## Provisioning a Standard plan instance on a Dedicated Hardware environment

1.  Log in to your {{site.data.keyword.cloud_notm}} account.<br/>
    The {{site.data.keyword.cloud_notm}} dashboard can be found at:
    [http://bluemix.net ![External link icon](../images/launch-glyph.svg "External link icon")](http://bluemix.net){:new_window}.
    After authenticating with your user name and password,
    you are presented with the {{site.data.keyword.cloud_notm}} dashboard:<br/>
    ![{{site.data.keyword.cloud_notm}} dashboard](images/img0001.png)

2.  Click the `Create resource` button:<br/>
    ![{{site.data.keyword.cloud_notm}} create resource](images/img0002.png)<br/>
    A list of the services available on {{site.data.keyword.cloud_notm}} appears.

3.  Click the `Databases` category and select the `Cloudant` service:<br/>
    ![{{site.data.keyword.cloud_notm}} {{site.data.keyword.cloudant_short_notm}} service selection](images/img0003.png)</br>
    The page for creating a service appears.<br/>  

4.  Click `Standard` from the pricing plans. <br/>
    ![Standard pricing plan](../tutorials/images/standard_pricing_plan.png)
    
    You cannot provision a Lite plan instance on a Dedicated Hardware environment.
    {: tip}
    
5.  Fill out the following parameters: <br/>
    -   Enter a service name.<br/>
    -   Specify the region/location where you want to deploy. <br/>
    -   Select a resource group. </br>
    -   Select an authentication method.</br>
    -   Select an environment.</br>
    ![Configure standard instance](../tutorials/images/select_environment.png)
    
6.  Click the `Create` button.<br/>
    After a few seconds, the instance is provisioned on the environment you selected.<br/>
    ![Provision standard instance](../tutorials/images/create_button_provision_standard.png)
    
7.  Obtain your Service Credentials and access the {{site.data.keyword.cloudant_short_notm}} Dashboard as you do for a multi-tenant {{site.data.keyword.cloudant_short_notm}} instance. 
    
    For more information, see [how to locate your service credentials ![External link icon](../images/launch-glyph.svg "External link icon")](https://console.bluemix.net/docs/services/Cloudant/tutorials/create_service.html#locating-your-service-credentials){:new_window}. 
     