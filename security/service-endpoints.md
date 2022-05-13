---

copyright:
  years: 2020, 2021
lastupdated: "2021-11-11"

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
{{site.data.keyword.attribute-definition-list}}

# Using service endpoints to privately connect to {{site.data.keyword.cloudant_short_notm}}
{: #service-endpoints}

To ensure that you enhance control and security over your data when you use {{site.data.keyword.cloudantfull}}, you have the option of using private routes to {{site.data.keyword.cloud}} service endpoints. Private routes are not accessible or reachable over the internet. By using the {{site.data.keyword.cloud_notm}} Private service endpoints feature, you can protect your data from threats from the public network and logically extend your private network.
{: shortdesc}

{{site.data.keyword.cloudant_short_notm}} sends customer logs to LogDNA by using a private service endpoint.

## Before you begin
{: #prereq-service-endpoint}

You must first enable virtual routing and forwarding in your account, and then you can enable the use of {{site.data.keyword.cloud_notm}} Private service endpoints. For more information about setting up your account to support the private connectivity option, see [Enabling VRF and service endpoints](/docs/account?topic=account-vrf-service-endpoint).

Only {{site.data.keyword.cloudant_short_notm}} users with the dedicated hardware plan can have a cloud service endpoint (CSE). All new dedicated hardware clusters have a CSE. If you are an existing user, and you do not have a CSE, contact the [{{site.data.keyword.cloud_notm}} Support Center](https://cloud.ibm.com/unifiedsupport/supportcenter). 

Multi-tenant users cannot use CSE. 
{: tip}

## Setting up service endpoints for {{site.data.keyword.cloudant_short_notm}}
{: #endpoint-setup}

Cloud service endpoints are ready to use when an instance is deployed. Therefore, there is no set up. 

You can verify connectivity to your private service endpoint by getting the Cloudant server information from the URL of the private endpoint.

```sh
curl https://$ACCOUNT-bluemix.private.cloudantnosqldb.appdomain.cloud
```
{: codeblock}
{: curl}

```java
import com.ibm.cloud.cloudant.v1.Cloudant;
import com.ibm.cloud.cloudant.v1.model.ServerInformation;

Cloudant service = Cloudant.newInstance();

ServerInformation response =
    service.getServerInformation().execute().getResult();

System.out.println(response);
```
{: codeblock}
{: java}

```javascript
import { CloudantV1 } from '@ibm-cloud/cloudant'

const service = CloudantV1.newInstance({});

service.getServerInformation().then(response => {
    console.log(response.result);
});
```
{: codeblock}
{: javascript}

```python
from ibmcloudant.cloudant_v1 import CloudantV1

service = CloudantV1.new_instance()

response = service.get_server_information().get_result()

print(response)
```
{: codeblock}
{: python}

```go
getServerInformationOptions := service.NewGetServerInformationOptions(),

serverInformation, response, err := service.GetServerInformation(getServerInformationOptions),
if err != nil {
  panic(err)
}

b, _ := json.MarshalIndent(serverInformation, "", "  ")
fmt.Println(string(b))
```
{: codeblock}
{: go}

If it succeeds, you are ready to go. Otherwise, you might want to check a few things: 

-  Are your CSEs correctly enabled?
-  Can you reach the CSE endpoints from where you're running the command?
-  Do other CSE endpoints in the same account work correctly?
-  Do your firewall rules block access?

If none of these tasks fix the problem, you can talk to our [{{site.data.keyword.cloud_notm}} Support Center](https://cloud.ibm.com/unifiedsupport/supportcenter) team.

## Disabling public service endpoints for {{site.data.keyword.cloudant_short_notm}}
{: #endpoint-disable}

If you use the dedicated hardware plan, you can deny access from the public network. To accomplish this task, make a request to update the firewall rules for your clusters to the [{{site.data.keyword.cloud_notm}} Support Center](https://cloud.ibm.com/unifiedsupport/supportcenter). 

This option is not available to multi-tenant users.
{: tip} 





