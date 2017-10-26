---

copyright:
  years: 2015, 2017
lastupdated: "2017-10-26"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-02-23 -->

# Creating and leveraging a Cloudant Dedicated Hardware plan instance on Bluemix

This tutorial shows you how to create a Cloudant Dedicated Hardware plan instance 
using the IBM Cloud dashboard, and shows you how to subsequently provision one or 
more Standard plan instances to run on it. 

Creating a Cloudant Dedicated Hardware plan instance results in the provisioning 
of a Cloudant environment on dedicated hardware for your sole use. A service 
instance is created in the IBM Cloud dashboard, but note that you cannot 
access the Dedicated Hardware plan instance directly and will not have 
any Service Credentials for it. You can use a Cloudant Dedicated Hardware 
plan instance after it is created by provisioning one or more Standard plan 
instances on it.

## Creating a Cloudant Dedicated Hardware plan instance

1.  Log in to your {{site.data.keyword.Bluemix_notm}} account.<br/>
    The {{site.data.keyword.Bluemix_notm}} dashboard can be found at:
    [http://bluemix.net ![External link icon](../images/launch-glyph.svg "External link icon")](http://bluemix.net){:new_window}.
    After authenticating with your user name and password,
    you are presented with the {{site.data.keyword.Bluemix_notm}} dashboard:<br/>
    ![{{site.data.keyword.Bluemix_notm}} dashboard](images/img0001.png)

2.  Click the `Catalog` link:<br/>
    ![{{site.data.keyword.Bluemix_notm}} catalog link](images/img0002.png)<br/>
    A list of the services available on {{site.data.keyword.Bluemix_notm}} appears.

3.  Click the `Data & Analytics` entry under the `Services` heading:<br/>
    ![{{site.data.keyword.Bluemix_notm}} Data & Analytics services](images/img0003.png)<br/>
    A list of the Data & Analytics services
    available on {{site.data.keyword.Bluemix_notm}} appears.

4.  Click the {{site.data.keyword.cloudant_short_notm}} service:<br/>
    ![{{site.data.keyword.Bluemix_notm}} {{site.data.keyword.cloudant_short_notm}} service selection](images/img0004.png)<br/>
    The page for creating a service appears. 

5.  At the bottom of the page, select the `Dedicated Hardware` hardware plan from the list of pricing plans:<br/>
    ![Pricing plans](../tutorials/images/pricing_plan.png)<br/>
    You select the pricing plan, create your service, and provision it on the same page. 

6.  At the top of the page, fill out the parameters section as follows: <br/>
    a.   Enter a Service name.<br/>
    b.   Specify the region and space to deploy.<br/>
    c.   Select a location for deployment.<br/>
    d.   Answer yes or no to the question about whether HIPAA is required. Note that HIPAA is only valid for U.S. locations.<br/>    
    **Note**: You deploy and provision Standard plan instances in the same region and space. <br/>   
    ![Configure dedicated hardware](../tutorials/images/select_deployment_location.png)<br/>
    Start the provisioning process. 
    
7.  At the bottom of the page, click the `Create` button to begin provisioning. <br/>
    **Note**: Billing is prorated daily so make sure that you want to provision and 
    pay for an environment before clicking the **Create** button.<br/>
    ![Provision dedicated hardware](../tutorials/images/create_button_provision.png)

    A request is sent to provision a Dedicated Hardware plan instance on bare 
    metal servers. Provisioning time is asynchronous and can take up to 5 days. 
    During provisioning, a spinning wheel appears next to the instance in 
    your IBM Cloud dashboard. 

## Provisioning a Standard plan instance on a Dedicated Hardware environment

1.  Log in to your {{site.data.keyword.Bluemix_notm}} account.<br/>
    The {{site.data.keyword.Bluemix_notm}} dashboard can be found at:
    [http://bluemix.net ![External link icon](../images/launch-glyph.svg "External link icon")](http://bluemix.net){:new_window}.
    After authenticating with your user name and password,
    you are presented with the {{site.data.keyword.Bluemix_notm}} dashboard:<br/>
    ![{{site.data.keyword.Bluemix_notm}} dashboard](images/img0001.png)

2.  Click the `Catalog` link:<br/>
    ![{{site.data.keyword.Bluemix_notm}} catalog link](images/img0002.png)<br/>
    A list of the services available on {{site.data.keyword.Bluemix_notm}} appears.

3.  Click the `Data & Analytics` entry under the `Services` heading:<br/>
    ![{{site.data.keyword.Bluemix_notm}} Data & Analytics services](images/img0003.png)<br/>
    A list of the Data & Analytics services
    available on {{site.data.keyword.Bluemix_notm}} appears.

4.  Click the {{site.data.keyword.cloudant_short_notm}} service:<br>
    ![{{site.data.keyword.Bluemix_notm}} {{site.data.keyword.cloudant_short_notm}} service selection](images/img0004.png)<br/>
    The page for creating a service appears.  

5.  At the bottom of the page, select `Standard` from the pricing plans. <br/>
    **Note**: You cannot provision a Lite plan instance on a Dedicated Hardware environment.<br/>
    ![Standard pricing plan](../tutorials/images/standard_pricing_plan.png)<br/>
    You select the pricing plan, create your service, and provision it on the same page.
    
6.  At the top of the page, fill out the parameters section by entering a Service name, Credential name, and so on 
    as you would for a Standard plan instance. Decide whether to provision on the default regional multi-tenant 
    environment or the Dedicated Hardware environment you have provisioned by using the `Select Environment` drop-down.<br/>
    ![Configure standard instance](../tutorials/images/select_environment.png)
    
7.  At the bottom of the page, click the `Create` button.<br/>
    After a few seconds, the instance is provisioned on the environment you selected.<br/>
    ![Provision standard instance](../tutorials/images/create_button_provision_standard.png)
    
8.  Obtain your Service Credentials and access the Cloudant Dashboard as you do for a multi-tenant Cloudant instance. 
    See more information about how to locate your Service Credentials [here ![External link icon](../images/launch-glyph.svg "External link icon")](https://console.bluemix.net/docs/services/Cloudant/tutorials/create_service.html#locating-your-service-credentials){:new_window}. 
     