---

copyright:
  years: 2020, 2021
lastupdated: "2021-08-19"

keywords: isolation for IBM Cloudant, service endpoints for IBM Cloudant, private network for IBM Cloudant, network isolation in IBM Cloudant, non-public routes for IBM Cloudant, private connection for IBM Cloudant, private connectivity for IBM Cloudant

subcollection: Cloudant

---

{:external: target="_blank" .external}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:note: .note}
{:important: .important}

<!--Name your file `service-endpoints.md` with the title Using service endpoints to privately connect to _servicename_. When nav titles are available you can use Using service endpoints as your title for the left nav entry while retaining the longer title as your H1 in the topic to ensure helpful search results.
IMPORTANT: 
* If your service supports only service endpoints, include it in the **How to** nav group in the **Enhancing security** topic group in your `toc` file. 
* If your service supports both service endpoints and VPE for VPC, then refer to the guidance about placement in a nested topic group within the Enhancing security topic group: https://test.cloud.ibm.com/docs/writing?topic=writing-security-content-guidance-->

# Using service endpoints to privately connect to {{site.data.keyword.cloudant_short_notm}}
{: #service-endpoints}

<!--The short description should be a single, concise paragraph that contains one or two sentences and no more than 50 words. Summarize your offering's support for non-public service endpoints. You can use the following example for a service supporting the use of IBM Cloud service endpoints for network isolation:-->

To ensure that you have enhanced control and security over your data when you use {{site.data.keyword.cloudantfull}}, you have the option of using private routes to {{site.data.keyword.cloud}} service endpoints. Private routes are not accessible or reachable over the internet. By using the {{site.data.keyword.cloud_notm}} private service endpoints feature, you can protect your data from threats from the public network and logically extend your private network.
{: shortdesc}

{{site.data.keyword.cloudant_short_notm}} sends customer logs to LogDNA by using a private service endpoint.

<!--
_Required: Document any customer data that goes over public routes even with the IBM Cloud service endpoints feature enabled using a connection over private routes. For example, if your service sends customer data to a data-service using a public route or sends customer logs using public routes to LogDNA that should be documented._
-->


## Before you begin
{: #prereq-service-endpoint}

You must first enable virtual routing and forwarding in your account, and then you can enable the use of {{site.data.keyword.cloud_notm}} private service endpoints. For more information about setting up your account to support the private connectivity option, see [Enabling VRF and service endpoints](/docs/account?topic=account-vrf-service-endpoint).

Only {{site.data.keyword.cloudant_short_notm}} users with the dedicated hardware plan can have a cloud service endpoint (CSE). All new dedicated hardware clusters have a CSE. If you are an existing user, and you do not have a CSE, contact the [{{site.data.keyword.cloud_notm}} Support Center](https://cloud.ibm.com/unifiedsupport/supportcenter). 

Multi-tenant users cannot use CSE. 
{: tip}

<!--
_Document that users can connect to your service over a private network by using IBM Cloud private service endpoints. Point to the [core documentation](/docs/resources?topic=resources-private-network-endpoints) about how to enable the capability in their account, and then cover any details that are specific to your service about using it, for example:_
-->



## Setting up service endpoints for {{site.data.keyword.cloudant_short_notm}}
{: #endpoint-setup}

Cloud service endpoints are ready to use when an instance is deployed. Therefore, there is no set up. 

You can ensure you are connected to a private service endpoint by running a curl command from the command line. In production, from the account where CSE is enabled, run this command:

```sh
curl https://$ACCOUNT-bluemix.private.cloudantnosqldb.appdomain.cloud
```
{: codeblock}

If it succeeds, you are ready to go. Otherwise, you might want to check a few things: 

-  Are your CSEs correctly enabled?
-  Can you reach the CSE endpoints from where you're running the command?
-  Do other CSE endpoints in the same account work correctly?
-  Are your firewall rules blocking access?

If none of these tasks fix the problem, you can talk to our [{{site.data.keyword.cloud_notm}} Support Center](https://cloud.ibm.com/unifiedsupport/supportcenter) team.

<!--
_Review the following example: https://cloud.ibm.com/docs/compare-comply?topic=watson-public-private-endpoints. Depending on how your service supports and requires users to set up this capability, document the steps to ensure a user can successfully connect over the private service endpoint._

_High level steps typically covered are: Add a private network endpoint, view your endpoint URL, and modify your apps to use the new endpoint._
-->

## Disabling public service endpoints for {{site.data.keyword.cloudant_short_notm}}
{: #endpoint-disable}

If you use the dedicated hardware plan, you can deny access from the public network. To accomplish this task, make a request to update the firewall rules for your clusters to the [{{site.data.keyword.cloud_notm}} Support Center](https://cloud.ibm.com/unifiedsupport/supportcenter). 

This option is not available to multi-tenant users.
{: tip} 


<!--
_Review the following example: https://cloud.ibm.com/docs/containers?topic=containers-cs_network_cluster#set-up-public-se. Depending on how and if your service supports users to disable public endpoints, document the steps for disabling a public endpoint to ensure a user can connect over only the private endpoint, if this is an option._
-->



