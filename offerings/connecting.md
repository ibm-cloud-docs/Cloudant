---

copyright:
  years: 2019, 2020
lastupdated: "2020-10-21"

keywords: endpoints, service credentials, authentication, ibm cloudant dashboard, curl, client libraries, IP allowlisting

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

<!-- Acrolinx: 2020-04-10 -->

# Connecting
{: #connecting}

{{site.data.keyword.cloudantfull}} is accessed through an HTTP API. This document describes the different parts that you use to connect to {{site.data.keyword.cloudant_short_notm}}:
- Endpoints
- Service credentials
- Authentication
- Accessing the {{site.data.keyword.cloudant_short_notm}} Dashboard
- Programmatically accessing {{site.data.keyword.cloudant_short_notm}} via [curl](https://curl.haxx.se/){: new_window}{: external} or client libraries 
{: shortdesc}

## Endpoints
{: #endpoints}

{{site.data.keyword.cloudant_short_notm}} is accessed through HTTP API endpoints. The endpoints for an instance are 
shown in both the URL field of the Service Credentials that are generated for the instance, and in the **Account** > **Settings** tab of the 
{{site.data.keyword.cloudant_short_notm}} Dashboard.

All {{site.data.keyword.cloudant_short_notm}} HTTP endpoints must be accessed over TLS and prefaced by `https://`.

The publicly facing external endpoint is shown in the following example:

`https://$USERNAME.cloudant.com`

All instances created after 1 January 2019 include an `appdomain.cloud` domain endpoint. The publicly facing 
external endpoint is shown in the following example:

`https://$USERNAME.cloudantnosqldb.appdomain.cloud`

Private (internal) endpoints are added to all instances deployed on Dedicated Hardware plan environments. The {{site.data.keyword.cloud_notm}} private (internal) network endpoint is shown in the following example:

`https://$USERNAME.private.cloudantnosqldb.appdomain.cloud`

In the previous example, USERNAME is the service name of the service instance user in the URL. This field also serves as the admin username
when you use {{site.data.keyword.cloudant_short_notm}} legacy authentication. An example USERNAME is 
de810d0e-763f-46a6-ae88-50823dc85581-bluemix, and resulting example external endpoint would be 
de810d0e-763f-46a6-ae88-50823dc85581-bluemix.cloudantnosqldb.appdomain.cloud. 

For more information about how to block public network connectivity via IP allowlisting, see [Secure access control](https://cloud.ibm.com/docs/Cloudant?topic=Cloudant-security#secure-access-control).
{: note}

## Service credentials
{: #service-credentials-con}

To generate service credentials for {{site.data.keyword.cloudant_short_notm}} via the {{site.data.keyword.cloud_notm}}
Dashboard, see the [Creating an {{site.data.keyword.cloudant_short_notm}} instance on {{site.data.keyword.cloud_notm}}](/docs/Cloudant?topic=Cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud#creating-an-ibm-cloudant-instance-on-ibm-cloud) tutorial. To generate service credentials from 
the {{site.data.keyword.cloud_notm}} CLI, see [Creating credentials for your {{site.data.keyword.cloudant_short_notm}}
service](/docs/Cloudant?topic=Cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud-by-using-the-ibm-cloud-cli#creating-an-ibm-cloudant-instance-on-ibm-cloud-by-using-the-ibm-cloud-cli). 

The following example shows service credentials for an {{site.data.keyword.cloudant_short_notm}} instance:

```json
{
  "apikey": "MxVp86XHkU82Wc97tdvDF8qM8B0Xdit2RqR1mGfVXPWz",
  "host": "76838001-b883-444d-90d0-46f89e942a15-bluemix.cloudant.com",
  "iam_apikey_description": "Auto generated apikey during resource-key [...]",
  "iam_apikey_name": "auto-generated-apikey-050d21b5-5f[...]",
  "iam_role_crn": "crn:v1:bluemix:public:iam::::serviceRole:Manager",
  "iam_serviceid_crn": "crn:v1:staging:public:iam-identity::[...]",
  "password": "8fb6a16b48903e87b769e7f4968521e85c2394ed8f0e69b2769e56dcb27d2e76",
  "port": 443,
  "url": "https://<username>:<password>@76838001-b883-444d-90d0-46f89e942a15-bluemix.cloudant.com",
  "username": "76838001-b883-444d-90d0-46f89e942a15-bluemix"
}
```
{: codeblock}

The service credentials include the following fields:

Field | Purpose
------|--------
`username` | The service name of the service instance user in the URL. This field also serves as the admin username. 
`password` | The legacy credentials password that is required for applications to access the service instance. This field displays only if the `Use both legacy credentials and IAM` option is chosen. 
`host` | The host name that is used by applications to locate the service instance. This field displays only if the `Use both legacy credentials and IAM` option is chosen. 
`port` | The HTTPS port number for accessing the service instance on the host. It's 443 as only HTTPS access is allowed by {{site.data.keyword.cloudant_short_notm}}. This field displays only if the `Use both legacy credentials and IAM` option is chosen. 
`url`	| The HTTPS URL to access the {{site.data.keyword.cloudant_short_notm}} instance. If the `Use both legacy credentials and IAM` option is chosen, it also includes the embedded legacy username and password. 
`apikey` | The IAM API key. 
`iam_apikey_description` | Description of the IAM API key. 
`iam_apikey_name` | ID of the IAM API key.
`iam_role_crn` | The IAM role that the IAM API key has.
`iam_serviceid_crn`	| The CRN of the service ID.
{: caption="Table 1. Service credential fields" caption-side="top"}

## Authentication
{: #authentication-overview}

{{site.data.keyword.cloudant_short_notm}} has two authentication methods available at provisioning time, either 
`Use only IAM` or `Use both legacy credentials and IAM`. You can see the details about your legacy credentials in the 
service credentials only if the `Use both legacy credentials and IAM` authentication method is chosen. The credentials display on the Service 
credentials tab for your instance. For more information, see the 
[IAM guide](/docs/Cloudant?topic=Cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-)
 and [legacy authentication](/docs/Cloudant?topic=Cloudant-authentication#authentication) document for details about using 
 either style of authentication.
 
The {{site.data.keyword.cloudant_short_notm}} team recommends you use IAM access controls for authentication whenever possible. If you're using {{site.data.keyword.cloudant_short_notm}} legacy authentication, you must use [API keys](/docs/Cloudant?topic=Cloudant-authorization#api-keys){: new_window} rather than account-level credentials for programmatic access and replication jobs. 
{: important}

## {{site.data.keyword.cloudant_short_notm}} Dashboard
{: #ibm-cloudant-dashboard}

You can open the {{site.data.keyword.cloudant_short_notm}} Dashboard for your instance by going to the Manage tab of 
the {{site.data.keyword.cloud_notm}} Dashboard instance details page. You can use either the `Launch` or `Launch Cloudant Dashboard`
button to open the dashboard in a new browser tab. You can do the following tasks by using the {{site.data.keyword.cloudant_short_notm}} Dashboard:

- Monitor your current consumption of the instance.
- Perform CRUD (create, read, update, delete) on {{site.data.keyword.cloudant_short_notm}} databases, documents, and indexes.
- Set up and view replication jobs.
- View active tasks.
- View and update account information like provisioned throughput capacity, announcements, CORS, and settings.

## Programmatic access
{: #programmatic-access}

### Command line (curl)
{: #command-line-curl-}

You can leverage the curl command-line utility to access the {{site.data.keyword.cloudant_short_notm}} HTTPS API. 

For more information about {{site.data.keyword.cloudant_short_notm}} legacy authentication, see the [API reference overview](/docs/Cloudant?topic=Cloudant-api-reference-overview#api-reference-overview). In the API reference examples, you find details on supplying a username and 
password to access the {{site.data.keyword.cloudant_short_notm}} API with curl.

If you use {{site.data.keyword.cloud_notm}} IAM authentication, you must first get an {{site.data.keyword.cloud_notm}} IAM token by using an API key. You pass the IAM token to the {{site.data.keyword.cloudant_short_notm}} instance to authenticate. For more information, see [Passing an {{site.data.keyword.cloud_notm}} IAM token to authenticate with a service's API](/docs/account?topic=account-iamapikeysforservices#token_auth){: new_window}{: external} 
tutorial. 

You can't use an IAM API key directly to authenticate against {{site.data.keyword.cloudant_short_notm}}.
{: note}

### Client libraries
{: #client-libraries-overview}

{{site.data.keyword.cloudant_short_notm}} has official client libraries for Java&trade;, Node.js, Python, Swift, and Mobile. For more information, see the [client libraries documentation](/docs/Cloudant?topic=Cloudant-client-libraries#client-libraries) to access the libraries, and see examples for connecting to an {{site.data.keyword.cloudant_short_notm}}
instance from each. 
