---

copyright:
  years: 2020
lastupdated: "2020-12-07"

keywords: legacy access controls, api keys, enable iam, provisioning, how to choose between iam and legacy credentials, making requests, required client libraries, actions, endpoints, map actions to iam roles

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
{:external: target="_blank" .external}

<!-- Acrolinx: 2020-10-06 -->

# Managing access
{: #managing-access-for-cloudant}

{{site.data.keyword.cloud}} Identity and Access Management provides a unified
approach to managing user identities, services, and access control.
{: shortdesc}

## Introduction
{: #introduction-iam-ai}

This document describes the integration of {{site.data.keyword.cloudantfull}} with {{site.data.keyword.cloud_notm}} Identity and
Access Management. It discusses the differences between {{site.data.keyword.cloudant_short_notm}}'s Legacy
access controls and {{site.data.keyword.cloud_notm}} IAM's access controls. Next, it looks at the advantages and disadvantages of each
to help you decide which to use. Then, we discuss how to use IAM within
{{site.data.keyword.cloudant_short_notm}}'s client libraries and by using HTTP calls. Finally, we end with a reference
section that describes all of the IAM actions and roles available within {{site.data.keyword.cloudant_short_notm}}.

For more information, see an overview of [IAM](https://cloud.ibm.com/docs/iam/index.html#iamoverview){: new_window}{: external} that includes the following topics:

- Manage user and service IDs.
- Manage available credentials.
- Use IAM access policies that allow and revoke access to {{site.data.keyword.cloudant_short_notm}} service instances.

## Differences between {{site.data.keyword.cloudant_short_notm}} Legacy and IAM access controls
{: #differences-between-ibm-cloudant-legacy-and-iam-access-controls-ai}

The following section provides a brief overview of the differences between {{site.data.keyword.cloudant_short_notm}}
Legacy and {{site.data.keyword.cloud_notm}} IAM's access control mechanisms.

### {{site.data.keyword.cloud_notm}} Identity and Access Management
{: #ibm-cloud-identity-and-access-management-ai}

- Centrally managed access management across {{site.data.keyword.cloud_notm}}.
- Allow a user or service to access many different resources by using the same set
  of credentials (for example, same username and password or IAM API key).
- IAM API keys can be granted access to account management functions, like
  creating new databases.

### {{site.data.keyword.cloudant_short_notm}} Legacy
{: #ibm-cloudant-legacy-ai}

- Unique to {{site.data.keyword.cloudant_short_notm}}.
- Access to each service instance requires its own set of credentials.
- Uses HTTP basic authentication with credentials that are not bound to an individual
  user or service.
- {{site.data.keyword.cloudant_short_notm}} API keys can be granted permissions only at a database level.

### API key notes
{: #api-key-notes-ai}

In this document, wherever API keys are mentioned it refers to IAM API keys.
{{site.data.keyword.cloudant_short_notm}} Legacy also has a concept of API keys, and any discussion about {{site.data.keyword.cloudant_short_notm}} Legacy
credentials or username and password combinations also includes {{site.data.keyword.cloudant_short_notm}} API keys.

## Enabling IAM with {{site.data.keyword.cloudant_short_notm}}
{: #enabling-iam-with-ibm-cloudant-ai}

All {{site.data.keyword.cloudant_short_notm}} service instances provisioned July 2018 or later are provisioned in Resource Groups and are enabled with {{site.data.keyword.cloud_notm}} IAM. Optionally, you can choose to also enable the {{site.data.keyword.cloudant_short_notm}} Legacy authentication mechanism.  When you provision a new {{site.data.keyword.cloudant_short_notm}} instance from the {{site.data.keyword.cloud_notm}} catalog, choose from the following available authentication methods.

1. **Use both legacy credentials and IAM**: This mode means that both IAM and legacy credentials can be used to access the account. In particular, both IAM and legacy sets of credentials are provided to all applications bound to the account and service credentials generated.
2. **Use only IAM**: This mode means that only IAM credentials are provided by using Service binding and
    credential generation.

When you use IAM roles other than `Manager`, such as `Reader`, `Writer`, `Monitor`, or `Checkpointer`, you **must** use *Use only IAM* to avoid supplying users with legacy credentials that include greater access permissions. 
{: important}

{{site.data.keyword.cloudant_short_notm}} service instances that are provisioned previously in a Cloud Foundry org and space can be migrated to a Resource Group. After you migrate to a Resource Group, the instance is enabled with {{site.data.keyword.cloud_notm}} IAM. For more information, see the [How does {{site.data.keyword.cloudant_short_notm}} work with {{site.data.keyword.cloud_notm}} Resource Groups?](/docs/Cloudant?topic=Cloudant-how-does-ibm-cloudant-work-with-ibm-cloud-resource-groups-) guide about how to migrate.

### {{site.data.keyword.cloudant_short_notm}} API keys and _Use only IAM_
{: #ibm-cloudant-api-keys-and-_use-only-iam_ai}

Use of {{site.data.keyword.cloudant_short_notm}} API keys alongside IAM is possible but **not recommended**. This recommendation is made because
{{site.data.keyword.cloudant_short_notm}} API keys and permissions are not visible or manageable by using the IAM policy interface, rendering
holistic access management impossible.

The choice between *Use only IAM* or *Use both legacy credentials and IAM* affects the following factors:

1. Whether legacy {{site.data.keyword.cloudant_short_notm}} account-level credentials are available to manage databases and other
    account-level actions.
2. The style of credentials that are delivered during service credential generation.

In particular, {{site.data.keyword.cloudant_short_notm}} API keys can still be used to manage database access. These credentials must be
generated and configured by using the HTTP API.

### Provisioning by using the command line
{: #provisioning-by-using-the-command-line-ai}

When you provision a new {{site.data.keyword.cloudant_short_notm}} instance from the command line, provide an option to the `ibmcloud` tool
by using the `-p` parameter to enable or disable legacy credentials for an account. The option is
passed in JSON format and is called `legacyCredentials`.

To provision an instance as *Use only IAM* (recommended), run the following command:

```sh
ibmcloud resource service-instance-create  "Instance Name" \
    cloudantnosqldb Standard us-south \
    -p {"legacyCredentials": false}
```
{: codeblock}

When you use IAM roles other than `Manager`, such as `Reader`, `Writer`, `Monitor`, or `Checkpointer`, you **must** use *Use only IAM* to avoid supplying users with legacy credentials that include greater access permissions.
{: important}

To provision an instance as *Use both legacy credentials and IAM*, run the following command:

```sh
ibmcloud resource service-instance-create  "Instance Name" \
    cloudantnosqldb Standard us-south \
    -p {"legacyCredentials": true}
```
{: codeblock}

### Service credential JSON examples for each option
{: #service-credential-json-examples-for-each-option-ai}

The choice between *Use only IAM* and *Use both Legacy credentials and IAM* access control
affects how credentials are delivered to your application when you bind and generate
service credentials. When you generate credentials within the primary {{site.data.keyword.cloud_notm}}
IAM interface, API keys are shown in that interface when generated.

You can also generate credentials from the Service Credentials section of a
service instance. Generating service credentials this way creates a service credentials JSON blob that can be pasted into applications with all the details that are needed to access the service instance.

Next, you can see what the service credential JSON looks like and what
each value means.

When you select *Use only IAM*, the service credentials that are generated contain only IAM
values, and look like the following example.

```json
{
  "apikey": "MxVp86XHkU82Wc97tdvDF8qM8B0Xdit2RqR1mGfVXPWz",
  "iam_apikey_description": "Auto generated apikey during resource-key [...]",
  "iam_apikey_name": "auto-generated-apikey-050d21b5-5f[...]",
  "iam_role_crn": "crn:v1:bluemix:public:iam::::serviceRole:Manager",
  "iam_serviceid_crn": "crn:v1:staging:public:iam-identity::[...]",
  "url": "https://76838001-b883-444d-90d0-46f89e942a15-bluemix.cloudant.com",
  "username": "76838001-b883-444d-90d0-46f89e942a15-bluemix"
}
```
{: codeblock}

Each value in the previous JSON example must be interpreted by using the following definitions:

- `apikey` - IAM API key.
- `iam_apikey_description` - Description of IAM API key.
- `iam_apikey_name` - ID of IAM API key.
- `iam_role_crn` - The IAM role that the IAM API key has.
- `iam_serviceid_crn` - The CRN of service ID.
- `url` - {{site.data.keyword.cloudant_short_notm}} service URL.
- `username` - The internal {{site.data.keyword.cloudant_short_notm}} account name.

When you select *Use both Legacy credentials and IAM*, the service credentials that are generated contain both IAM and legacy credentials, and look like the values in the following example.

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

Each value in the previous JSON example must be interpreted by using the following definitions:

- `apikey` - IAM API key.
- `host` - {{site.data.keyword.cloudant_short_notm}} service hostname.
- `iam_apikey_description` - Description of IAM API key.
- `iam_apikey_name` - ID of IAM API key.
- `iam_role_crn` - The IAM role that the IAM API key has.
- `iam_serviceid_crn` - The CRN of service ID.
- `password` - The {{site.data.keyword.cloudant_short_notm}} Legacy credential password.
- `port` - {{site.data.keyword.cloudant_short_notm}} service port.
- `url` - {{site.data.keyword.cloudant_short_notm}} service URL, including embedded {{site.data.keyword.cloudant_short_notm}} Legacy credentials.
- `username` - The {{site.data.keyword.cloudant_short_notm}} Legacy credential username.

Note the included `username` and `password` are always equivalent to IAM's
Manager credentials. Therefore, the use of *Use both Legacy credentials and IAM* is
insecure when used with `Reader`, `Writer`, `Monitor`, or `Checkpointer` IAM roles.

## Must I use *Use only IAM* or *Use both Legacy credentials and IAM*?
{: #must-i-use-_use-only-iam_-or-_use-both-legacy-credentials-and-iam_-ai}

If possible, *Use only IAM* is preferred. The major advantages for using
{{site.data.keyword.cloud_notm}} IAM are shown in the following list:

- Management of access to {{site.data.keyword.cloudant_short_notm}} with {{site.data.keyword.cloud_notm}}'s standard tools rather than a combination of {{site.data.keyword.cloud_notm}} and {{site.data.keyword.cloudant_short_notm}}-specific credential management.
- Credentials can be easily revoked and rotated when you use {{site.data.keyword.cloud_notm}} IAM.

Further description of the advantages and disadvantages of each approach follows.

When you use IAM roles other than `Manager`, such as `Reader`, `Writer`, `Monitor`, or `Checkpointer`, you **must** use *Use only IAM* to avoid supplying users with legacy credentials that include greater access permissions.
{: important}

### Advantages and disadvantages of the two access control mechanisms
{: #advantages-and-disadvantages-of-the-two-access-control-mechanisms-ai}

Overall, {{site.data.keyword.cloud_notm}} IAM is the recommended authentication model. However, the primary disadvantages to the approach are if you have an existing application
or are unable to use an {{site.data.keyword.cloudant_short_notm}}-supported client library.

#### Advantages of IAM mode
{: #advantages-iam-mode-ai}

- Manage access for many services by using one interface.
- Revoke access to a user globally.
- Account-level API keys that use service IDs.
- Easy-to-rotate credentials.
- Activity Tracker logs capture individual humans and services.
- IAM federates with other identity systems, like enterprise LDAP repositories.
- Fine-grained permissions (for example, `Reader`, `Writer`, `Monitor`, or `Checkpointer`).

#### Disadvantages of IAM mode
{: #disadvantages-iam-mode-ai}

- If you are not using the supported libraries from {{site.data.keyword.cloudant_short_notm}}, application changes are likely to be required to use IAM's API keys and access tokens.
- No database-level permissions (yet).
- Some endpoints are not available. For more information, see [unavailable endpoints](#unavailable-endpoints).
- No way to specify a database as "public", that is, not requiring an authorized user to access.

#### Advantages of Legacy mode
{: #advantages-legacy-mode-ai}

- No need to change existing applications or client library dependencies.
- Database-level permissions.

#### Disadvantages of Legacy mode
{: #disadvantages-legacy-mode-ai}

- No account-level API keys; must use `root` credentials to manage databases.
- Separate management of {{site.data.keyword.cloudant_short_notm}} credentials, so unable to get full overview of all access within centralized interface.
- Hard to implement credential rotation.

## Create a replication job by using IAM credentials only
{: #create-replication-job-using-iam-cred-only-ai}

Follow these instructions to generate IAM API keys, generate the bearer token, create the `_replicator` database, and create the replication job.

### Generating IAM API keys for Source and Target and one for {{site.data.keyword.cloudant_short_notm}} API access
{: #generate-iam-api-keys-cloudant-api-access-ai}

We create the first two API keys so that the two instances can talk to each other during the replication process. The third API key is for the user to access the {{site.data.keyword.cloudant_short_notm}} API, create the `_replicator` database, and then add the replication document to it.

Follow these steps to generate IAM API keys and API access for {{site.data.keyword.cloudant_short_notm}}. You must write down
the credentials that are requested in the following steps to continue with the example.

Ensure that you select the specified instance, either the Source or Target.
{: note}

1. Log in to `cloud.ibm.com`.
2. From the Resource list, select **Services** and your Source instance.

   a. Click **Service credentials** and click **New credential**.

   b. Name the new credential `replicator-source`, and select the Manager role.

	 c. Click **Add**, and make note of its `apikey`, which is under View Credentials in the Actions column.

3. Repeat steps 2 through 2.c. for the Target instance.

   a. Create a credential called `replicator-target` with the Manager role.

   b. Make note of its IAM API key, which is under View Credentials in the Actions column.

4. Select the Source instance, and click **Service credentials** and **New credential**.

   a. Name the new credential `apiaccess`, and select the Manager role. 

   b. Make note of the actual IAM API key under View Credentials in the Actions column.

5. Make note of Source and Target instance URLs.

Depending on your workflow, instead of creating a service-level credential (step 4), you can use a personal IAM API key, as detailed in [Creating an API key](/docs/account?topic=account-userapikey#create_user_key){: new_window}{: external}.

You can also complete these steps on the command line by using the [{{site.data.keyword.cloud_notm}} CLI tool chain](https://cloud.ibm.com/docs/cli?topic=cli-getting-started){: new_window}{: external}.

### Generating a bearer token to authenticate against the {{site.data.keyword.cloudant_short_notm}} API
{: #generate-bearer-token-authenticate-cloudant-api-ai}

Use the `apiaccess` key from step 4.b.:

```sh
curl -k -X POST \
  --header "Content-Type: application/x-www-form-urlencoded" \
  --header "Accept: application/json" \
  --data-urlencode "grant_type=urn:ibm:params:oauth:grant-type:apikey" \
  --data-urlencode "apikey=aSCsx4...2lN97h_2Ts" \
  "https://iam.cloud.ibm.com/identity/token"
```
{: codeblock}

The `apiaccess` key returns the following information (abbreviated):

```sh
{
   "access_token": "eyJraWQiOiIyMDE5MD...tIwkCO9A",
   "refresh_token": "ReVbNrHo3UA38...mq67g",
   "token_type": "Bearer",
   "expires_in": 3600,
   "expiration": 1566313064,
   "scope": "ibm openid"
}
```
{: codeblock}

Create an environment variable to save some typing by using the value under the `access_token` key in the response data:

```sh
export TOK="Bearer eyJraWQiOiIyMDE5MD...tIwkCO9A"
```
{: codeblock}

### Creating the `_replicator` database on the Source side
{: #create-_replicator-database-source-side-ai}

URL is the Source instance URL that you previously wrote down in step 4.b.

```sh
curl -k -X PUT \
     -H"Content-type: application/json" \
     -H'Authorization: '"$TOK"'' \
     'https://d43caf1b-e2c8-4d3e-9b85-1d04839fa68f-bluemix.cloudant.com/_replicator'
```
{: codeblock}

See the results in the following example:

```
{"ok": "true"}
```
{: codeblock}

### Creating the replication job
{: #create-the-replication-job-ai}

Create a file called `data.json` that contains the following information. The two keys are the Source and Target API keys that are created in the beginning, and the Source and Target instance URLs, with database names added.

```sh
{
  "source": {
    "url": "https://d43caf1b-e2c8-4d3e-9b85-1d04839fa68f-bluemix.cloudant.com/source",
    "auth": {
      "iam": {
        "api_key": "xju1...TxuS"
      }
    }
  },
  "target": {
    "url": "https://dbc68dd8-f69f-4083-97dd-bf0a3e1a467a-bluemix.cloudant.com/target",
    "auth": {
      "iam": {
        "api_key": "UElc7...QIaL01Bjn"
      }
    }
  },
  "create_target": true,
  "continuous": true
}
```
{: codeblock}

Now, write a replication document called `source_dest` to the `_replicator` database on the Source instance.

```sh
curl -k -X PUT \
     -H"Content-type: application/json" \
     -H'Authorization: '"$TOK"'' \
     'https://d43caf1b-e2c8-4d3e-9b85-1d04839fa68f-bluemix.cloudant.com/_replicator/source_dest' -d@data.json
```
{: codeblock}

See the results in the following example:

```
{"ok":true,"id":"source_dest","rev":"1-89b01e42968acd5944ed657b87c49f0c"}
```
{: codeblock}

## Removing {{site.data.keyword.cloudant_short_notm}} Legacy credentials from an instance
{: #removing-legacy-credentials-ai}

{{site.data.keyword.cloud_notm}} IAM is the recommended authentication model. For security purposes, you can request to remove the {{site.data.keyword.cloudant_short_notm}} Legacy credentials so that only IAM authentication can be used for the instance. The correct process to remove legacy credentials is shown in the following steps:

1. Ensure that the {{site.data.keyword.cloudant_short_notm}} instance has IAM authentication that is enabled. If the instance is deployed in a Cloud Foundry org and space, migrate it to a Resource Group by using the [How does {{site.data.keyword.cloudant_short_notm}} work with {{site.data.keyword.cloud_notm}} Resource Groups?](/docs/Cloudant?topic=Cloudant-how-does-ibm-cloudant-work-with-ibm-cloud-resource-groups-) guide.

2. Update your application to use IAM authentication instead of {{site.data.keyword.cloudant_short_notm}} legacy authentication.

3. Generate [new service credentials](/docs/Cloudant?topic=Cloudant-getting-started-with-cloudant#step-2-creating-service-credential) as needed.

4. Open a new {{site.data.keyword.cloud_notm}} support case that requests the removal of {{site.data.keyword.cloudant_short_notm}} legacy credentials for your instance. Include the username of the instance as shown in the service credentials. For more information, see [Locating your service credentials](/docs/Cloudant?topic=Cloudant-locating-your-service-credentials).

5. After support replies that the legacy credentials were removed, any service credentials that were created before removal contain legacy username and password details that no longer work. It is recommended to remove any of these service credential entries.

## Making requests to instances by using IAM credentials
{: #making-requests-to-instances-by-using-iam-credentials-ai}

Now, we discuss how to use {{site.data.keyword.cloudant_short_notm}} with
service instances through IAM authentication. It uses the
details from the [Service credential JSON examples for each option](#service-credential-json-examples-for-each-option-ai).

{{site.data.keyword.cloud_notm}} IAM requires that an IAM API key is exchanged for a time-limited access token before you make a request to a resource or service. The access token is then included in the `Authorization` HTTP header to the service. When the access token expires, the consuming application must handle getting a new one from the IAM token service. For more information, see [Getting an {{site.data.keyword.cloud_notm}} IAM token by using an API key](https://cloud.ibm.com/docs/iam/apikey_iamtoken.html#iamtoken_from_apikey){: new_window}{: external} documentation for more details.

{{site.data.keyword.cloudant_short_notm}}'s official client libraries handle obtaining a token from an API key for you. If you access {{site.data.keyword.cloudant_short_notm}} directly by using an HTTP client rather than an {{site.data.keyword.cloudant_short_notm}} client library, you must handle exchanging and refreshing a time-limited access token by using an IAM API key with the IAM token service. After a token expires, {{site.data.keyword.cloudant_short_notm}} returns an HTTP `401` status code.

### Required client library versions
{: #required-client-library-versions-ai}

IAM connectivity is available in the latest release of all supported client libraries. For more information, see [Client libraries](/docs/Cloudant?topic=Cloudant-client-libraries).

The code snippets in the next few sections require supported client libraries. 

#### Java
{: #java-ai}

The following links provide the latest supported version of our legacy and beta libraries:

- [`java-cloudant`](https://github.com/cloudant/java-cloudant/releases/latest){: new_window}{: external}
- [`cloudant-java-sdk`](https://github.com/IBM/cloudant-java-sdk/releases/latest){: new_window}{: external}![BETA tag](../images/beta_icon.png) 

Use the `iamApiKey()` method to create a database client with an IAM API key. The following example uses `java-cloudant`. For an example that uses {{site.data.keyword.cloudant_short_notm}} SDK for Java (beta), see the [API reference documentation](https://cloud.ibm.com/apidocs/cloudant?code=java#authentication).

```java
package com.mycompany.app;

import com.cloudant.client.api.ClientBuilder;
import com.cloudant.client.api.CloudantClient;


public class App
{
    public static void main( String[] args )
    {
        CloudantClient client = ClientBuilder
                .account("76838001-b883-444d-90d0-46f89e942a15-bluemix")
                .iamApiKey("MxVp86XHkU82Wc97tdvDF8qM8B0Xdit2RqR1mGfVXPWz")
                .build();

        for (String db : client.getAllDbs()) {
            System.out.println(db);
        }
    }
}
```
{: codeblock}

#### Node.js
{: #node.js-ai}

The following links provide the latest supported version of our legacy and beta libraries:

- [`nodejs-cloudant`](https://github.com/cloudant/nodejs-cloudant/releases/latest){: new_window}{: external}
- [`cloudant-node-sdk`](https://github.com/IBM/cloudant-node-sdk/releases/latest){: new_window}{: external}![BETA tag](../images/beta_icon.png) 

Use the `iamauth` plug-in to create a database client with an IAM API key. The following example uses `nodejs-cloudant`. For an example that uses {{site.data.keyword.cloudant_short_notm}} SDK for Node (beta), see the [API reference documentation](https://cloud.ibm.com/apidocs/cloudant?code=node#authentication).

```js
var Cloudant = require('@cloudant/cloudant');

var cloudant = new Cloudant({
  account: '76838001-b883-444d-90d0-46f89e942a15-bluemix',
  plugins: {
    iamauth: {
      iamApiKey: 'MxVp86XHkU82Wc97tdvDF8qM8B0Xdit2RqR1mGfVXPWz'
    }
  }
});
cloudant.db.list(function(err, body) {
  body.forEach(function(db) {
    console.log(db);
  });
});
```
{: codeblock}

#### Python
{: #python-ai}

The following links provide the latest supported version of our legacy and beta libraries:

- [`python-cloudant`](https://github.com/cloudant/python-cloudant/releases/latest){: new_window}{: external}
- [`cloudant-python-sdk`](https://github.com/IBM/cloudant-python-sdk/releases/latest){: new_window}{: external} 

Use the `Cloudant.iam(account_name, api_key, **kwargs)` method to create a
database client with an IAM API key. The following example uses `python-cloudant`. For an example that uses {{site.data.keyword.cloudant_short_notm}} SDK for Python (beta), see the [API reference documentation](https://cloud.ibm.com/apidocs/cloudant?code=python#authentication).

```python
from cloudant.client import Cloudant

client = Cloudant.iam(
    "76838001-b883-444d-90d0-46f89e942a15-bluemix",
    "MxVp86XHkU82Wc97tdvDF8qM8B0Xdit2RqR1mGfVXPWz",
    connect=True
)
print client.all_dbs()
```
{: codeblock}

### Access by using HTTP client
{: #access-by-using-http-client-ai}

{{site.data.keyword.cloud_notm}} IAM requires that an IAM API key is exchanged for a time-limited
access token before you make a request to a resource or service. The access token
is then included in the `Authorization` HTTP header to the service. When the
access token expires, the client must handle getting a new one from the IAM
token service.

As stated previously, if you use {{site.data.keyword.cloud_notm}} IAM, it requires that you first exchange an {{site.data.keyword.IBM_notm}} API key for a time-limited access token. After that, you use the token to authenticate against the {{site.data.keyword.cloudant_short_notm}} API.

In Python, an example might look like:

```python
import time

import requests

API_KEY = "MxVp86XHkU82Wc97tdvDF8qM8B0Xdit2RqR1mGfVXPWz"
ACCOUNT = "76838001-b883-444d-90d0-46f89e942a15-bluemix"

def get_access_token(api_key):
    """Retrieve an access token from the IAM token service."""
    token_response = requests.post(
        "https://iam.cloud.ibm.com/identity/token",
        data={
            "grant_type": "urn:ibm:params:oauth:grant-type:apikey",
            "response_type": "cloud_iam",
            "apikey": api_key
        },
        headers={
            "Accept": "application/json"
        }
    )
    if token_response.status_code == 200:
        print "Got access token from IAM"
        return token_response.json()['access_token']
    else:
        print token_response.status_code, token_response.json()
        return None

def main(api_key, account):
    access_token = None
    while True:
        if not access_token:
            access_token = get_access_token(api_key)

        if access_token:
            response = requests.get(
                "https://{0}.cloudant.com/_all_dbs".format(account),
                headers={
                    "Accept": "application/json",
                    "Authorization": "Bearer {0}".format(access_token)
                }
            )
            print "Got Cloudant response, status code", response.status_code
            if response.status_code == 401:
                print "Token has expired."
                access_token = None

        time.sleep(1)

if __name__ == "__main__":
    main(API_KEY, ACCOUNT)
```
{: codeblock}

## Reference
{: #reference-ai}

The following tables include a complete list of {{site.data.keyword.cloudant_short_notm}}'s IAM roles and actions, and a mapping of what actions are allowed for each IAM system role.

### {{site.data.keyword.cloudant_short_notm}} roles
{: #ibm-cloudant-roles-ai}

The following table lists the available IAM service roles for {{site.data.keyword.cloudant_short_notm}} and a brief description of each.

| Role | Description |
|--------|----------|
| `Manager` | Includes the ability to access all endpoints and perform all administrative functions on an instance, such as creating databases, changing capacity, reading and writing data and indexes, and accessing the Dashboard. |
| `Writer` | Includes the ability to read and write to all databases and documents, but not able to create indexes. |
| `Reader` | Includes the ability to read all databases and documents, but not able to write new documents or create indexes. |
| `Monitor` | Includes the ability to read monitoring endpoints, such as  `_active_tasks`  and replication  `_scheduler ` endpoints. |
| `Checkpointer` | Includes the ability to write replication checkpointer `_local` documents. Required on source databases during replication. |
{: caption="Table 2. IAM service roles for {{site.data.keyword.cloudant_short_notm}}" caption-side="top"}

Manager is inclusive of all actions of Reader and Writer, and Writer is inclusive of all actions of Reader.

### {{site.data.keyword.cloudant_short_notm}} actions
{: #ibm-cloudant-actions-ai}

The following table describes the available IAM actions and roles. For fine-grained authorization, you can use the roles of `Manager`, `Reader`, `Writer`, `Monitor`, or `Checkpointer`.

When you use IAM roles other than `Manager`, such as `Reader`, `Writer`, `Monitor`, or `Checkpointer`, you **must** use *Use only IAM* to avoid supplying users with legacy credentials that include greater access permissions. 
{: important}

| Method | Endpoint | Action name |
|--------|----------|-------------|
| `GET/PUT` | `/_api/v2/db/<path:db>/_security` | `cloudantnosqldb.sapi.db-security` |
| `GET` | `/_api/v2/user/capacity/throughput` | `cloudantnosqldb.capacity-throughput.read` |
| `PUT` | `/_api/v2/user/capacity/throughput` | `cloudantnosqldb.capacity-throughput.write` |
| `GET` | `/_api/v2/user/current/throughput` | `cloudantnosqldb.current-throughput.read` |
| `GET` | `/_api/v2/user/activity_tracker/events` | `cloudantnosqldb.activity-tracker-event-types.read` |
| `POST` | `/_api/v2/user/activity_tracker/events` | `cloudantnosqldb.activity-tracker-event-types.write`|
| `POST` | `/_api/v2/api_keys` | `cloudantnosqldb.sapi.apikeys` |
| `GET/POST` | `/_api/v2/user/config/cors/` | `cloudantnosqldb.sapi.usercors` |
| `GET/PUT` | `/_api/v2/user/plan` | `cloudantnosqldb.sapi.userplan` |
| `GET` | `/_api/v2/user/ccm_diagnostics` | `cloudantnosqldb.sapi.userccmdiagnostics` |
| `GET` | `/_api/v2/user/last_activity` | `cloudantnosqldb.sapi.lastactivity` |
| `GET` | `/_api/v2/support/tickets/$CASEID/files/$ATTACHMENTID` | `cloudantnosqldb.sapi.supportattachments` |
| `GET/POST`| `/_api/v2/support/tickets` | `cloudantnosqldb.sapi.supporttickets` |
| `GET/PUT/DELETE`|  `/_api/v2/support/tickets/$CASEID` |`cloudantnosqldb.sapi.supporttickets` |
| `GET`| `/_api/v2/user` |`cloudantnosqldb.sapi.userinfo` |
| `GET` | `/_api/v2/usage/data_volume` and `/_api/v2/usage/$YEAR/$MONTH` | `cloudantnosqldb.sapi.usage-data-volume` |
| `GET/HEAD` | / | `cloudantnosqldb.account-meta-info.read` |
| `GET/HEAD` | `/_active_tasks` | `cloudantnosqldb.account-active-tasks.read` |
| `GET/HEAD` | `/_replicator` | `cloudantnosqldb.replicator-database-info.read ` |
| `GET/HEAD` | `/_replicator/$DOCUMENT` | `cloudantnosqldb.replication.read` |
| `GET/HEAD` | `/_scheduler/jobs` | `cloudantnosqldb.replication-scheduler.read` |
| `GET/HEAD` | `/_scheduler/docs` | `cloudantnosqldb.replication-scheduler.read` |
| `POST` | `/_replicate` | `cloudantnosqldb.replication.write` |
| `PUT/DELETE` | `/_replicator` | `cloudantnosqldb.replicator-database.create` |
| `PUT/DELETE` | `/_replicator/$DOCUMENT` | `cloudantnosqldb.replication.write` |
| `GET/HEAD` | `/_up` | `cloudantnosqldb.account-up.read` |
| `PUT` | `/$DATABASE/` | `cloudantnosqldb.database.create` |
| `DELETE` | `/$DATABASE` | `cloudantnosqldb.database.delete` |
| `POST` | `/$DATABASE/_design_docs/queries` | `cloudantnosqldb.any-document.read` |
| `GET/HEAD` | `/$DATABASE/_design/$DOCUMENT_ID/_geo_info` | `cloudantnosqldb.any-document.read` |
| `GET/HEAD` | `/$DATABASE/_design/$DOCUMENT_ID/_info/$FURTHER_PATH_PARTS` | `cloudantnosqldb.any-document.read` |
| `GET` | `/$DATABASE/_design/$DOCUMENT_ID/_search_disk_size/$FURTHER_PATH_PARTS` | `cloudantnosqldb.any-document.read` |
| `GET` | `/$DATABASE/_design/$DOCUMENT_ID/_search_info/$FURTHER_PATH_PARTS` | `cloudantnosqldb.any-document.read` |
| `GET/HEAD` | `/$DATABASE/_index/$FURTHER_PATH_PARTS` | `cloudantnosqldb.any-document.read` |
| `GET` | `/$DATABASE/_design_docs`  | `cloudantnosqldb.any-document.read` |
| `GET` | `/$DATABASE/_design/$DOCUMENT_ID` | `cloudantnosqldb.any-document.read` |
| `GET/HEAD` | `/$DATABASE/_design/$DOCUMENT_ID/$ATTACHMENT` | `cloudantnosqldb.any-document.read` |
| `PUT` | `/$DATABASE/_design/$DOCUMENT_ID` | `cloudantnosqldb.design-document.write` |
| `COPY` | `/$DATABASE/_design/$DOCUMENT_ID` | `cloudantnosqldb.design-document.write` |
| `DELETE` | `/$DATABASE/_design/$DOCUMENT_ID` | `cloudantnosqldb.design-document.write` |
| `PUT` | `/$DATABASE/_design/$DOCUMENT_ID/$ATTACHMENT` | `cloudantnosqldb.design-document.write` |
| `DELETE` | `/$DATABASE/_design/$DOCUMENT_ID/$ATTACHMENT` | `cloudantnosqldb.design-document.write` |
| `POST/DELETE` | `/$DATABASE/_index/$FURTHER_PATH_PARTS` | `cloudantnosqldb.design-document.write` |
| `GET/HEAD` | `/$DATABASE/_security` | `cloudantnosqldb.database-security.read` |
| `PUT` | `/$DATABASE/_security` | `cloudantnosqldb.database-security.write` |
| `GET/HEAD` | `/$DATABASE/_shards` | `cloudantnosqldb.database-shards.read` |
| `COPY`<br>(Depends on write document type.) | `/$DATABASE/$DOCUMENT_ID` | `cloudantnosqldb.any-document.read` + `cloudantnosqldb.design-document.write` and/or`cloudantnosqldb.local-document.write` and/or`cloudantnosqldb.data-document.write` |
| `GET` | `/_membership` | `cloudantnosqldb.cluster-membership.read` |
| `POST` | `/$DATABASE/_ensure_full_commit` | `cloudantnosqldb.database-ensure-full-commit.execute` |
| `PUT` | `/_users` | `cloudantnosqldb.users-database.create`  |
| `GET/HEAD` | `/_users` | `cloudantnosqldb.users-database-info.read`  |
| `DELETE` | `/_users` | `cloudantnosqldb.users-database.delete`  |
| `GET/HEAD` | `/_users/$DOCUMENT` | `cloudantnosqldb.users.read` |
| `GET/POST` | `/_users/_all_docs` | `cloudantnosqldb.users.read` |
| `GET/POST` | `/_users/_changes` | `cloudantnosqldb.users.read` |
| `POST` | `/_users/_missing_revs` | `cloudantnosqldb.users.read` |
| `POST` | `/_users/_revs_diff` | `cloudantnosqldb.users.read` |
| `POST` | `/_users/_bulk_get` | `cloudantnosqldb.users.read` |
| `PUT/DELETE` | `/_users/$DOCUMENT` | `cloudantnosqldb.users.write` |
| `POST` | `/_users/_bulk_docs` | `cloudantnosqldb.users.write` |
| `POST` | `/_users/` | `cloudantnosqldb.users.write` |
| `GET/HEAD` | `/_uuids` | `cloudantnosqldb.cluster-uuids.execute` |
| `POST` | `/$DATABASE/` | `cloudantnosqldb.data-document.write` or`cloudantnosqldb.design-document.write` or`cloudantnosqldb.local-document.write` |
| `POST` | `/$DATABASE/_bulk_docs` | `cloudantnosqldb.data-document.write` and/or`cloudantnosqldb.design-document.write` and/or`cloudantnosqldb.local-document.write` |
| `PUT` | `/$DATABASE/$DOCUMENT_ID` | `cloudantnosqldb.data-document.write` |
| `DELETE` | `/$DATABASE/$DOCUMENT_ID` | `cloudantnosqldb.data-document.write` |
| `PUT` | `/$DATABASE/$DOCUMENT_ID/$ATTACHMENT` | `cloudantnosqldb.data-document.write` |
| `DELETE` | `/$DATABASE/$DOCUMENT_ID/$ATTACHMENT` | `cloudantnosqldb.data-document.write` |
| `PUT/DELETE` | `/$DATABASE/_local/$DOCUMENT_ID` | `cloudantnosqldb.local-document.write` |
| `COPY`<br>(Depends on write document type.) | `/$DATABASE/_local/$DOCUMENT_ID` | `cloudantnosqldb.any-document.read` + `cloudantnosqldb.design-document.write` and/or`cloudantnosqldb.local-document.write` and/or`cloudantnosqldb.data-document.write` |
| `GET/HEAD` | `/_iam_session` | `cloudantnosqldb.iam-session.read` |
| `POST` | `/_iam_session` | `cloudantnosqldb.iam-session.write` |
| `DELETE` | `/_iam_session` | `cloudantnosqldb.iam-session.delete` |
| `GET/HEAD` | `/_session` | `cloudantnosqldb.session.read` |
| `POST` | `/_session` | `cloudantnosqldb.session.write` |
| `DELETE` | `/_session` | `cloudantnosqldb.session.delete` |
| `GET/HEAD` | `/_all_dbs` | `cloudantnosqldb.account-all-dbs.read` |
| `GET` | `/_db_updates` | `cloudantnosqldb.account-db-updates.read` |
| `POST` | `/_dbs_info` | `cloudantnosqldb.account-dbs-info.read` |
| `GET` | `/$DATABASE/` | `cloudantnosqldb.database-info.read` |
| `GET/POST` | `/$DATABASE/_all_docs` | `cloudantnosqldb.any-document.read` |
| `GET/POST` | `/$DATABASE/_changes` | `cloudantnosqldb.any-document.read` |
| `GET/HEAD` | `/$DATABASE/$DOCUMENT_ID` | `cloudantnosqldb.any-document.read` |
| `GET/HEAD` | `/$DATABASE/$DOCUMENT_ID/$ATTACHMENT` | `cloudantnosqldb.any-document.read` |
| `POST` | `/$DATABASE/_bulk_get` | `cloudantnosqldb.any-document.read` |
| `GET/POST` | `/_search_analyze` | `cloudantnosqldb.account-search-analyze.execute` |
| `POST` | `/$DATABASE/_all_docs/queries` | `cloudantnosqldb.any-document.read` |
| `GET/HEAD` | `/$DATABASE/_design/$DOCUMENT_ID/_geo/$FURTHER_PATH_PARTS` | `cloudantnosqldb.any-document.read` |
| `GET/POST` | `/$DATABASE/_design/$DOCUMENT_ID/_list/$FURTHER_PATH_PARTS` | `cloudantnosqldb.any-document.read` |
| `GET/POST` | `/$DATABASE/_design/$DOCUMENT_ID/_search/$FURTHER_PATH_PARTS` | `cloudantnosqldb.any-document.read` |
| `GET/POST` | `/$DATABASE/_design/$DOCUMENT_ID/_show/$FURTHER_PATH_PARTS` | `cloudantnosqldb.any-document.read` |
| `POST` | `/$DATABASE/_design/$DOCUMENT_ID/_view/$VIEW/queries` | `cloudantnosqldb.any-document.read` |
| `GET/POST` | `/$DATABASE/_design/$DOCUMENT_ID/_view/$FURTHER_PATH_PARTS` | `cloudantnosqldb.any-document.read` |
| `POST` | `/$DATABASE/_explain/$FURTHER_PATH_PARTS` | `cloudantnosqldb.any-document.read` |
| `POST` | `/$DATABASE/_find/$FURTHER_PATH_PARTS` | `cloudantnosqldb.any-document.read` |
| `GET` | `/$DATABASE/_local/$DOCUMENT_ID` | `cloudantnosqldb.any-document.read ` |
| `POST` | `/$DATABASE/_missing_revs` | `cloudantnosqldb.any-document.read` |
| `POST` | `/$DATABASE/_revs_diff` | `cloudantnosqldb.any-document.read` |
{: class="simple-tab-table"}
{: caption="Table 3. Manager role actions and mapping" caption-side="top"}
{: #manager-role}
{: tab-title="Manager"}
{: tab-group="Roles-simple"}

| Method | Endpoint | Action name |
|--------|----------|-------------|
| `GET` | `/_api/v2/user/activity_tracker/events` | `cloudantnosqldb.activity-tracker-event-types.read` |
| `GET/HEAD` | `/_uuids` | `cloudantnosqldb.cluster-uuids.execute` |
| `POST` | `/$DATABASE/` | `cloudantnosqldb.data-document.write` or `cloudantnosqldb.design-document.write` or `cloudantnosqldb.local-document.write` |
| `POST` | `/$DATABASE/_bulk_docs` | `cloudantnosqldb.data-document.write` and/or `cloudantnosqldb.design-document.write` and/or `cloudantnosqldb.local-document.write` |
| `PUT` | `/$DATABASE/$DOCUMENT_ID` | `cloudantnosqldb.data-document.write` |
| `DELETE` | `/$DATABASE/$DOCUMENT_ID` | `cloudantnosqldb.data-document.write` |
| `PUT` | `/$DATABASE/$DOCUMENT_ID/$ATTACHMENT` | `cloudantnosqldb.data-document.write` |
| `DELETE` | `/$DATABASE/$DOCUMENT_ID/$ATTACHMENT` | `cloudantnosqldb.data-document.write` |
| `PUT/DELETE` | `/$DATABASE/_local/$DOCUMENT_ID` | `cloudantnosqldb.local-document.write` |
| `GET/HEAD` | `/_iam_session` | `cloudantnosqldb.iam-session.read` |
| `POST` | `/_iam_session` | `cloudantnosqldb.iam-session.write` |
| `DELETE` | `/_iam_session` | `cloudantnosqldb.iam-session.delete` |
| `GET/HEAD` | `/_session` | `cloudantnosqldb.session.read` |
| `POST` | `/_session` | `cloudantnosqldb.session.write` |
| `DELETE` | `/_session` | `cloudantnosqldb.session.delete` |
| `GET/HEAD` | `/_all_dbs` | `cloudantnosqldb.account-all-dbs.read` |
| `GET` | `/_db_updates` | `cloudantnosqldb.account-db-updates.read` |
| `POST` | `/_dbs_info` | `cloudantnosqldb.account-dbs-info.read` |
| `GET` | `/$DATABASE/` | `cloudantnosqldb.database-info.read` |
| `GET/POST` | `/$DATABASE/_all_docs` | `cloudantnosqldb.any-document.read` |
| `GET/POST` | `/$DATABASE/_changes` | `cloudantnosqldb.any-document.read` |
| `GET/HEAD` | `/$DATABASE/$DOCUMENT_ID` | `cloudantnosqldb.any-document.read` |
| `GET/HEAD` | `/$DATABASE/$DOCUMENT_ID/$ATTACHMENT` | `cloudantnosqldb.any-document.read` |
| `POST` | `/$DATABASE/_bulk_get` | `cloudantnosqldb.any-document.read` |
| `GET/POST` | `/_search_analyze` | `cloudantnosqldb.account-search-analyze.execute` |
| `POST` | `/$DATABASE/_all_docs/queries` | `cloudantnosqldb.any-document.read` |
| `GET/HEAD` | `/$DATABASE/_design/$DOCUMENT_ID/_geo/$FURTHER_PATH_PARTS` | `cloudantnosqldb.any-document.read` |
| `GET/POST` | `/$DATABASE/_design/$DOCUMENT_ID/_list/$FURTHER_PATH_PARTS` | `cloudantnosqldb.any-document.read` |
| `GET/POST` | `/$DATABASE/_design/$DOCUMENT_ID/_search/$FURTHER_PATH_PARTS` | `cloudantnosqldb.any-document.read` |
| `GET/POST` | `/$DATABASE/_design/$DOCUMENT_ID/_show/$FURTHER_PATH_PARTS` | `cloudantnosqldb.any-document.read` |
| `POST` | `/$DATABASE/_design/$DOCUMENT_ID/_view/$VIEW/queries` | `cloudantnosqldb.any-document.read` |
| `GET/POST` | `/$DATABASE/_design/$DOCUMENT_ID/_view/$FURTHER_PATH_PARTS` | `cloudantnosqldb.any-document.read` |
| `POST` | `/$DATABASE/_explain/$FURTHER_PATH_PARTS` | `cloudantnosqldb.any-document.read` |
| `POST` | `/$DATABASE/_find/$FURTHER_PATH_PARTS` | `cloudantnosqldb.any-document.read` |
| `GET` | `/$DATABASE/_local/$DOCUMENT_ID` | `cloudantnosqldb.any-document.read ` |
| `POST` | `/$DATABASE/_missing_revs` | `cloudantnosqldb.any-document.read` |
| `POST` | `/$DATABASE/_revs_diff` | `cloudantnosqldb.any-document.read` |
| `GET/HEAD` | / | `cloudantnosqldb.account-meta-info.read` |
{: caption="Table 3. Writer role actions and mapping" caption-side="top"}
{: #writer-role}
{: tab-title="Writer"}
{: tab-group="Roles-simple"}
{: class="simple-tab-table"}

| Method | Endpoint | Action name |
|--------|----------|-------------|
| `GET` | `/_api/v2/user/activity_tracker/events` | `cloudantnosqldb.activity-tracker-event-types.read` |
| `GET/HEAD` | `/_iam_session` | `cloudantnosqldb.iam-session.read` |
| `POST` | `/_iam_session` | `cloudantnosqldb.iam-session.write` |
| `DELETE` | `/_iam_session` | `cloudantnosqldb.iam-session.delete` |
| `GET/HEAD` | `/_session` | `cloudantnosqldb.session.read` |
| `POST` | `/_session` | `cloudantnosqldb.session.write` |
| `DELETE` | `/_session` | `cloudantnosqldb.session.delete` |
| `GET/HEAD` | `/_all_dbs` | `cloudantnosqldb.account-all-dbs.read` |
| `GET` | `/_db_updates` | `cloudantnosqldb.account-db-updates.read` |
| `POST` | `/_dbs_info` | `cloudantnosqldb.account-dbs-info.read` |
| `GET` | `/$DATABASE/` | `cloudantnosqldb.database-info.read` |
| `GET/POST` | `/$DATABASE/_all_docs` | `cloudantnosqldb.any-document.read` |
| `GET/POST` | `/$DATABASE/_changes` | `cloudantnosqldb.any-document.read` |
| `GET/HEAD` | `/$DATABASE/$DOCUMENT_ID` | `cloudantnosqldb.any-document.read` |
| `GET/HEAD` | `/$DATABASE/$DOCUMENT_ID/$ATTACHMENT` | `cloudantnosqldb.any-document.read` |
| `POST` | `/$DATABASE/_bulk_get` | `cloudantnosqldb.any-document.read` |
| `GET/POST` | `/_search_analyze` | `cloudantnosqldb.account-search-analyze.execute` |
| `POST` | `/$DATABASE/_all_docs/queries` | `cloudantnosqldb.any-document.read` |
| `GET/HEAD` | `/$DATABASE/_design/$DOCUMENT_ID/_geo/$FURTHER_PATH_PARTS` | `cloudantnosqldb.any-document.read` |
| `GET/POST` | `/$DATABASE/_design/$DOCUMENT_ID/_list/$FURTHER_PATH_PARTS` | `cloudantnosqldb.any-document.read` |
| `GET/POST` | `/$DATABASE/_design/$DOCUMENT_ID/_search/$FURTHER_PATH_PARTS` | `cloudantnosqldb.any-document.read` |
| `GET/POST` | `/$DATABASE/_design/$DOCUMENT_ID/_show/$FURTHER_PATH_PARTS` | `cloudantnosqldb.any-document.read` |
| `POST` | `/$DATABASE/_design/$DOCUMENT_ID/_view/$VIEW/queries` | `cloudantnosqldb.any-document.read` |
| `GET/POST` | `/$DATABASE/_design/$DOCUMENT_ID/_view/$FURTHER_PATH_PARTS` | `cloudantnosqldb.any-document.read` |
| `POST` | `/$DATABASE/_explain/$FURTHER_PATH_PARTS` | `cloudantnosqldb.any-document.read` |
| `POST` | `/$DATABASE/_find/$FURTHER_PATH_PARTS` | `cloudantnosqldb.any-document.read` |
| `GET` | `/$DATABASE/_local/$DOCUMENT_ID` | `cloudantnosqldb.any-document.read ` |
| `POST` | `/$DATABASE/_missing_revs` | `cloudantnosqldb.any-document.read` |
| `POST` | `/$DATABASE/_revs_diff` | `cloudantnosqldb.any-document.read` |
| `GET/HEAD` | / | `cloudantnosqldb.account-meta-info.read` |
{: caption="Table 3. Reader role actions and mapping" caption-side="top"}
{: #reader-role}
{: tab-title="Reader"}
{: tab-group="Roles-simple"}
{: class="simple-tab-table"}

| Method | Endpoint | Action name |
|--------|----------|-------------|
|`GET` | `/_api/v2/usage/data_volume` and `/_api/v2/usage/$YEAR/$MONTH` | `cloudantnosqldb.sapi.usage-data-volume` |
| `GET` | `/_api/v2/user/capacity/throughput` | `cloudantnosqldb.capacity-throughput.read` |
| `GET` | `/_api/v2/user/current/throughput` | `cloudantnosqldb.current-throughput.read` |
| `GET/HEAD` | / | `cloudantnosqldb.account-meta-info.read` |
| `GET/HEAD` | `/_active_tasks` | `cloudantnosqldb.account-active-tasks.read` |
| `GET/HEAD` | `/_scheduler/jobs` | `cloudantnosqldb.replication-scheduler.read` |
| `GET/HEAD` | `/_scheduler/docs` | `cloudantnosqldb.replication-scheduler.read` |
| `GET/HEAD` | `/_up` | `cloudantnosqldb.account-up.read` |
| `GET/HEAD` | `/$DATABASE/_shards` | `cloudantnosqldb.database-shards.read` |
| `PUT/DELETE` | `/$DATABASE/_local/$DOCUMENT_ID` | `cloudantnosqldb.local-document.write` |
| `POST` | `/_dbs_info` | `cloudantnosqldb.account-dbs-info.read` |
| `GET` | `/$DATABASE/` | `cloudantnosqldb.database-info.read` |
{: caption="Table 3. Monitor role actions and mapping" caption-side="top"}
{: #monitor-role}
{: tab-title="Monitor"}
{: tab-group="Roles-simple"}
{: class="simple-tab-table"}

| Method | Endpoint | Action name |
|--------|----------|-------------|
| `PUT/DELETE` | `/$DATABASE/_local/$DOCUMENT_ID` | `cloudantnosqldb.local-document.write` |
{: caption="Table 3. Checkpointer role actions and mapping" caption-side="top"}
{: #checkpointer-role}
{: tab-title="Checkpointer"}
{: tab-group="Roles-simple"}
{: class="simple-tab-table"}

#### Unavailable endpoints
{: #unavailable-endpoints-ai}

The following endpoints are not available to requests authorized with IAM:

- HTTP rewrite handlers - `/db/_design/design-doc/_rewrite/path`. 

While design documents can contain rewrite handlers, users cannot call them. 

- Update handlers - `POST /db/_design/ddoc/_update/func`. 

While design documents can contain update functions, users cannot call them. 

## Troubleshooting
{: #troubleshooting-ai}

If you can't use IAM to authenticate when you make requests to your {{site.data.keyword.cloudant_short_notm}} service instance, verify your account as shown in the next section.

### Ensure that your account is IAM enabled
{: #ensure-your-account-is-iam-enabled-ai}

On the Overview portion of the {{site.data.keyword.cloudant_short_notm}} dashboard, "authentication method" is listed under deployment details. Your available authentication methods are listed there.
