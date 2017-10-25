---

copyright:
  years: 2015, 2017
lastupdated: "2017-10-25"

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

Creating a Cloudant Dedicated Hardware plan instance will result in the provisioning 
of a Cloudant environment on dedicated hardware for your sole use. A service 
instance will be created in the IBM Cloud dashboard, but note that you will 
not access the Dedicated Hardware plan instance directly and will not have 
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

4.  Click the {{site.data.keyword.cloudant_short_notm}} service:<br>
    ![{{site.data.keyword.Bluemix_notm}} {{site.data.keyword.cloudant_short_notm}} service selection](images/img0004.png)

5.  Scroll down to the pricing plans and select **Dedicated Hardware**.

    ![Pricing plans](../tutorials/images/pricing_plan.png)

6. Scroll up to the parameters section.
    Enter a Service name, specify the region and space to deploy, select a location for deployment, and answer yes or no to whether 
    HIPAA is required. Note that HIPAA is only valid for U.S. locations. 
    > **Note**: The region and space where you deploy will be the 
    same region and space where you will be able to provision Standard plan instances. 

    ![Configure dedicated hardware](../tutorials/images/select_deployment_location.png)

7.  Scroll down and click the **Create** button to begin provisioning. 
    > **Note**: Billing is prorated daily so make sure that you want to provision and 
    pay for an environment before clicking the **Create** button.

    ![Provision dedicated hardware](../tutorials/images/create_button_provision.png)

    A request is sent to provision a Dedicated Hardware plan instance on bare 
    metal servers. Provisioning time is asynchronous and can take up to 5 days. 
    During provisioning, a spinning wheel appears next to the instance in 
    your IBM Cloud dashboard. 

## Provisioning a Standard plan instance on a Dedicated Hardware environment

1.  From within the Cloudant catalog tile, select Standard from the Pricing Plans. 
    > **Note**: You cannot provision a Lite plan instance on a Dedicated Hardware environment.

    ![Standard pricing plan](../tutorials/images/standard_pricing_plan.png)
    
2.  Scroll to the top and enter a Service name, Credential name, and so on as you normally 
    do for a Standard plan instance. Use the **Select Environment** drop-down to choose 
    whether to provision on the default regional multi-tenant environment or the Dedicated 
    Hardware environment you have provisioned. 

    ![Configure standard instance](../tutorials/images/select_environment.png)
    
3.  Scroll down and click **Create**. After a few seconds, the instance is provisioned 
    on the environment you selected.

    ![Provision standard instance](../tutorials/images/create_button_provision_standard.png)
    
4.  Obtain the Service Credentials and access the Cloudant Dashboard as you do for a 
    multi-tenant Cloudant instance.