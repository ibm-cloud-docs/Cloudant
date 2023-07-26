---

copyright:
  years: 2020, 2022
lastupdated: "2022-06-23"

keywords: isolation for IBM Cloudant, service endpoints for IBM Cloudant, private network for IBM Cloudant, network isolation in IBM Cloudant, non-public routes for IBM Cloudant, private connection for IBM Cloudant, private connectivity for IBM Cloudant

subcollection: Cloudant

---

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

service.setServiceUrl("https://$ACCOUNT-bluemix.private.cloudantnosqldb.appdomain.cloud");
...
```
{: codeblock}
{: java}

```javascript
const { CloudantV1 } = require('@ibm-cloud/cloudant');

const service = CloudantV1.newInstance({});

service.setServiceUrl('https://$ACCOUNT-bluemix.private.cloudantnosqldb.appdomain.cloud');
```
{: codeblock}
{: node}

```python
from ibmcloudant.cloudant_v1 import CloudantV1

service = CloudantV1.new_instance()

service.set_service_url('https://$ACCOUNT-bluemix.private.cloudantnosqldb.appdomain.cloud')
```
{: codeblock}
{: python}

```go
import (
  "github.com/IBM/cloudant-go-sdk/cloudantv1"
)

service, _ := cloudantv1.NewCloudantV1UsingExternalConfig(
  &cloudantv1.CloudantV1Options{},
)
service.SetServiceURL("https://$ACCOUNT-bluemix.private.cloudantnosqldb.appdomain.cloud")

if err != nil {
  panic(err)
}
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

The public service endpoint cannot be disabled however, if you use the dedicated hardware plan, you can deny access from the public network to user traffic. To accomplish this task, make a request to update the firewall rules for your clusters to the [{{site.data.keyword.cloud_notm}} Support Center](https://cloud.ibm.com/unifiedsupport/supportcenter). 

This option is not available to multi-tenant users.
{: tip} 
