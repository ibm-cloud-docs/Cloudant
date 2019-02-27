---

copyright:
  years: 2019
lastupdated: "2019-02-25"

keywords: endpoints, service credentials, authentication, ibm cloudant dashboard, curl, client libraries

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

<!-- Acrolinx: 2018-07-02 -->

# Connecting

{{site.data.keyword.cloudantfull}} is accessed through an HTTP API. This document describes the different parts you use to connect to {{site.data.keyword.cloudant_short_notm}}:
- Endpoints
- Service credentials
- Authentication
- Accessing the {{site.data.keyword.cloudant_short_notm}} Dashboard
- Programmatically accessing {{site.data.keyword.cloudant_short_notm}} via [curl ![External link icon](../images/launch-glyph.svg "External link icon")](https://curl.haxx.se/){: new_window} or client libraries 
{: shortdesc}

## Endpoints

{{site.data.keyword.cloudant_short_notm}} is accessed through HTTP API endpoints. The endpoints for an instance are 
shown in both the URL field of the Service Credentials generated for the instance, and in the **Account** > **Settings** tab of the 
{{site.data.keyword.cloudant_short_notm}} Dashboard.

All {{site.data.keyword.cloudant_short_notm}} HTTP endpoints must be accessed over TLS, therefore prefaced by `https://`.

The publicly-facing external endpoint is:

`https://USERNAME.cloudant.com`

All instances provisioned after January 1, 2019 include an appdomain.cloud domain endpoint. The publicly-facing 
external endpoint is:

`https://USERNAME.cloudantnosqldb.appdomain.cloud`

Internal endpoints are added to all instances deployed on Dedicated Hardware environments provisioned after January 1, 2019
outside of the EU-managed environment. The {{site.data.keyword.cloud_notm}} internal network endpoint is:

`https://USERNAME.private.cloudantnosqldb.appdomain.cloud`

Where the USERNAME is the service name of the service instance user in the URL. This field also serves as the admin user name
when using {{site.data.keyword.cloudant_short_notm}} legacy authentication. An example USERNAME is 
de810d0e-763f-46a6-ae88-50823dc85581-bluemix, and resulting example external endpoint would be 
de810d0e-763f-46a6-ae88-50823dc85581-bluemix.cloudantnosqldb.appdomain.cloud. 

## Service credentials

To generate service credentials for {{site.data.keyword.cloudant_short_notm}} via the {{site.data.keyword.cloud_notm}}
Dashboard, see the [Creating an {{site.data.keyword.cloudant_short_notm}} instance on {{site.data.keyword.cloud_notm}}](/docs/services/Cloudant/tutorials/create_service.html) tutorial. To generate service credentials from 
the {{site.data.keyword.cloud_notm}} CLI, see [Creating credentials for your {{site.data.keyword.cloudant_short_notm}}
service](/docs/services/Cloudant/tutorials/create_service_cli.html#creating-credentials-for-your-ibm-cloudant-service). 

Here are example service credentials for an {{site.data.keyword.cloudant_short_notm}} instance:

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
`username` | The service name of the service instance user in the URL. This field also serves as the admin user name. 
`password` | The legacy credentials password that is required for applications to access the service instance. This field only displays if the `Use both legacy credentials and IAM` option is chosen. 
`host` | The host name that is used by applications to locate the service instance. This field only displays if the `Use both legacy credentials and IAM` option is chosen. 
`port` | The HTTPS port number for accessing the service instance on the host. It is 443 as only HTTPS access is allowed by {{site.data.keyword.cloudant_short_notm}}. This field only displays if the `Use both legacy credentials and IAM` option is chosen. 
`url`	| The HTTPS URL to access the {{site.data.keyword.cloudant_short_notm}} instance. If the `Use both legacy credentials and IAM` option is chosen, it also includes the embedded legacy user name and password. 
`apikey` | The IAM API key. 
`iam_apikey_description` | Description of the IAM API key. 
`iam_apikey_name` | ID of the IAM API key.
`iam_role_crn` | The IAM role that the IAM API key has.
`iam_serviceid_crn`	| The CRN of the service ID.

## Authentication
{: #authentication-overview}

{{site.data.keyword.cloudant_short_notm}} has two authentication methods available at provisioning time, either 
`Use only IAM` or `Use both legacy credentials and IAM`. You can see the details about your legacy credentials in the 
service credentials only if the `Use both legacy credentials and IAM` authentication method is chosen. The credentials display on the Service 
credentials tab for your instance. For more information, see the 
[IAM guide](/docs/services/Cloudant/guides/iam.html#ibm-cloud-identity-and-access-management-iam-)
 and [legacy authentication](/docs/services/Cloudant/api/authentication.html#authentication) document for details about using 
 either style of authentication.
 
The {{site.data.keyword.cloudant_short_notm}} team recommends that you use IAM access controls for authentication whenever possible. If you are using {{site.data.keyword.cloudant_short_notm}} legacy authentication, it is recommended that you use [API keys](/docs/services/Cloudant/api/authorization.html#api-keys){: new_window} rather than account-level credentials for programmatic access and replication jobs. 
{: important}

## {{site.data.keyword.cloudant_short_notm}} Dashboard

You can open the {{site.data.keyword.cloudant_short_notm}} Dashboard for your instance by going to the Manage tab of 
the {{site.data.keyword.cloud_notm}} Dashboard instance details page. You can use either the `Launch` or `Launch Cloudant Dashboard`
button to open the Dashboard in a new browser tab. The {{site.data.keyword.cloudant_short_notm}} Dashboard allows you to do the following tasks:

- Monitor your current consumption of the instance
- Perform CRUD (create, read, update, delete) on {{site.data.keyword.cloudant_short_notm}} databases, documents, and indexes
- Set up and view replication jobs
- View active tasks
- View and update account information like provisioned throughput capacity, announcements, CORS, and settings

## Programmatic Access

### Command Line (curl)

You can leverage the curl command line utility to access the {{site.data.keyword.cloudant_short_notm}} HTTPS API. 

If you use {{site.data.keyword.cloudant_short_notm}} legacy authentication, see the 
[API reference overview](/docs/services/Cloudant/api/index.html#api-reference-overview) for details on supplying a user name and 
password to access the {{site.data.keyword.cloudant_short_notm}} API with curl as shown in the API reference examples.

If you use {{site.data.keyword.cloud_notm}} IAM authentication, you must first get an {{site.data.keyword.cloud_notm}} IAM token by using an API key. Then, you pass the IAM token to the {{site.data.keyword.cloudant_short_notm}} instance to authenticate. See [Passing an 
{{site.data.keyword.cloud_notm}} IAM token to authenticate with a service's API](/docs/services/iam/iam_apikeys_services.html#passing-an-ibm-cloud-iam-token-to-authenticate-with-a-service-s-api) 
tutorial. 

You cannot use an IAM API key directly to authenticate against {{site.data.keyword.cloudant_short_notm}}.
{: note}

### Client Libraries
{: #client-libraries-overview}

{{site.data.keyword.cloudant_short_notm}} has official client libraries for Java, Node.js, Python, Swift, and Mobile. For more information, see the [client libraries documentation](/docs/services/Cloudant/libraries/index.html#client-libraries) to access the libraries, and see examples for connecting to an {{site.data.keyword.cloudant_short_notm}}
instance from each. 
