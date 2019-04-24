---

copyright:
  years: 2017, 2019
lastupdated: "2019-04-24"

keywords: legacy access controls, api keys, enable iam, provisioning, how to choose between iam and legacy credentials, making requests, required client libraries, actions, endpoints, map actions to iam roles

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

# {{site.data.keyword.cloud_notm}} Identity and Access Management (IAM)
{: #ibm-cloud-identity-and-access-management-iam-}

{{site.data.keyword.cloud}} Identity and Access Management provides a unified
approach to managing user identities, services, and access control.
{: shortdesc}

## Introduction
{: #introduction}

This document describes {{site.data.keyword.cloudantfull}}'s integration with {{site.data.keyword.cloud_notm}} Identity and
Access Management. It discusses the differences between {{site.data.keyword.cloudant_short_notm}}'s Legacy
access controls and {{site.data.keyword.cloud_notm}} IAM's access controls. Next, it looks at the advantages and disadvantages of each
to help you decide which to use. Then, we discuss how to use IAM within
{{site.data.keyword.cloudant_short_notm}}'s client libraries and via HTTP calls. Finally, we end with a reference
section that describes all of the IAM actions and roles available within {{site.data.keyword.cloudant_short_notm}}.

See an overview of [IAM ![External link icon](../images/launch-glyph.svg "External link icon")](https://cloud.ibm.com/docs/iam/index.html#iamoverview){: new_window}, including how to:

- Manage user and service IDs.
- Manage available credentials.
- Use IAM access policies that allow and revoke access to {{site.data.keyword.cloudant_short_notm}} service instances.

## Differences between {{site.data.keyword.cloudant_short_notm}} Legacy and IAM access controls
{: #differences-between-ibm-cloudant-legacy-and-iam-access-controls}

The following section provides a brief overview of the differences between {{site.data.keyword.cloudant_short_notm}}
Legacy and {{site.data.keyword.cloud_notm}} IAM's access control mechanisms.

### {{site.data.keyword.cloud_notm}} Identity and Access Management
{: #ibm-cloud-identity-and-access-management}

- Centrally managed access management across {{site.data.keyword.cloud_notm}}.
- Allow a user or service to access many different resources by using the same set
  of credentials (for example, same username/password or IAM API key).
- IAM API keys can be granted access to account management functions, like
  creating new databases.

### {{site.data.keyword.cloudant_short_notm}} Legacy
{: #ibm-cloudant-legacy}

- Unique to {{site.data.keyword.cloudant_short_notm}}.
- Access to each service instance requires its own set of credentials.
- Uses HTTP basic authentication with credentials that are not bound to an individual
  user or service.
- {{site.data.keyword.cloudant_short_notm}} API keys can only be granted permissions at a database level.

### API key notes
{: #api-key-notes}

In this document, wherever API keys are mentioned it refers to IAM API keys.
{{site.data.keyword.cloudant_short_notm}} Legacy also has a concept of API keys, and any discussion about {{site.data.keyword.cloudant_short_notm}} Legacy 
credentials or username/password combinations also includes {{site.data.keyword.cloudant_short_notm}} API keys. 

## Enabling IAM with {{site.data.keyword.cloudant_short_notm}}
{: #enabling-iam-with-ibm-cloudant}

Only new {{site.data.keyword.cloudant_short_notm}} service instances can be used with {{site.data.keyword.cloud_notm}} IAM starting in late July 2018.

All new {{site.data.keyword.cloudant_short_notm}} service instances are enabled to use IAM when provisioned. Optionally, you can also enable the legacy authentication mechanism.  When you provision a new {{site.data.keyword.cloudant_short_notm}} instance from the {{site.data.keyword.cloud_notm}} catalog, choose from the available authentication methods:

1. **Use both legacy credentials and IAM**: This mode means that both IAM and Legacy credentials can be used to access the account. In particular, both IAM and Legacy sets of credentials are provided to all applications bound to the account and service credentials generated.
2. **Use only IAM**: This mode means that only IAM credentials are provided via Service binding and
    credential generation.

### {{site.data.keyword.cloudant_short_notm}} API keys and _Use only IAM_
{: #ibm-cloudant-api-keys-and-_use-only-iam_}

Use of {{site.data.keyword.cloudant_short_notm}} API keys alongside IAM is possible but **not recommended**. This recommendation is made because
{{site.data.keyword.cloudant_short_notm}} API keys and permissions are not visible or manageable via the IAM policy interface, rendering
holistic access management impossible.

The choice between _Use only IAM_ or _Use both legacy credentials and IAM_ affects:

1. Whether legacy {{site.data.keyword.cloudant_short_notm}} account-level credentials are available to manage databases and other
    account-level actions.
2. The style of credentials that are delivered during service credential generation.

In particular, {{site.data.keyword.cloudant_short_notm}} API keys can still be used to manage database access. These credentials must be
generated and configured by using the HTTP API.

### Provisioning by using the command line
{: #provisioning-by-using-the-command-line}

When you provision a new {{site.data.keyword.cloudant_short_notm}} instance from the command line, provide an option to the `ic` tool
by using the `-p` parameter to enable or disable legacy credentials for an account. The option is
passed in JSON format and is called `legacyCredentials`.

To provision an instance as _Use only IAM_ (recommended), run the following command:

```sh
ic resource service-instance-create  "Instance Name" \
    cloudantnosqldb Standard us-south \
    -p {"legacyCredentials": false}
```

To provision an instance as _Use both legacy credentials and IAM_, run the following command:

```sh
ic resource service-instance-create  "Instance Name" \
    cloudantnosqldb Standard us-south \
    -p {"legacyCredentials": true}
```

### Service credential JSON examples for each option
{: #service-credential-json-examples-for-each-option}

The choice between _Use only IAM_ and _Use both legacy credentials and IAM_ access control
affects how credentials are delivered to your application when binding and generating
service credentials. When generating credentials within the primary {{site.data.keyword.cloud_notm}}
IAM interface, API keys are shown in that interface when generated.

You can also generate credentials from the Service Credentials section of a
service instance. Generating service credentials this way creates a service credentials JSON blob that can be pasted into applications with all the details that are needed to access the service instance.

This section shows what the service credential JSON looks like and what
each value means.

When you select _Use only IAM_, service credentials that are generated contain only IAM
values, and look like the following example:

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

Each value in the previous JSON example should be interpreted as follows:

- `apikey`: IAM API key.
- `iam_apikey_description`: Description of IAM API key.
- `iam_apikey_name`: ID of IAM API key.
- `iam_role_crn`: The IAM role that the IAM API key has.
- `iam_serviceid_crn`: The CRN of service ID.
- `url`: {{site.data.keyword.cloudant_short_notm}} service URL.
- `username`: The internal {{site.data.keyword.cloudant_short_notm}} account name.

When you select _Use both legacy credentials and IAM_, the service credentials that are generated contain both IAM and Legacy credentials, and look like the following example:

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

Each value in the previous JSON example should be interpreted as follows:

- `apikey`: IAM API key.
- `host`: {{site.data.keyword.cloudant_short_notm}} service host name.
- `iam_apikey_description`: Description of IAM API key.
- `iam_apikey_name`: ID of IAM API key.
- `iam_role_crn`: The IAM role that the IAM API key has.
- `iam_serviceid_crn`: The CRN of service ID.
- `password`: The {{site.data.keyword.cloudant_short_notm}} Legacy credential password.
- `port`: {{site.data.keyword.cloudant_short_notm}} service port.
- `url`: {{site.data.keyword.cloudant_short_notm}} service URL, including embedded {{site.data.keyword.cloudant_short_notm}} Legacy credentials.
- `username`: The {{site.data.keyword.cloudant_short_notm}} Legacy credential user name.

## Should I use _Use only IAM_ or _Use both legacy credentials and IAM_?
{: #should-i-use-_use-only-iam_-or-_use-both-legacy-credentials-and-iam_-}

If possible, _Use only IAM_ is preferred. The major advantages for using
{{site.data.keyword.cloud_notm}} IAM include:

- Management of access to {{site.data.keyword.cloudant_short_notm}} with {{site.data.keyword.cloud_notm}}'s standard tooling rather than
  a combination of {{site.data.keyword.cloud_notm}} and {{site.data.keyword.cloudant_short_notm}}-specific credential management.
- Credentials can be easily revoked and rotated when you use {{site.data.keyword.cloud_notm}} IAM.

Further description of the advantages and disadvantages of each approach follows.

### Advantages and Disadvantages of the two access control mechanisms
{: #advantages-and-disadvantages-of-the-two-access-control-mechanisms}

Overall, {{site.data.keyword.cloud_notm}} IAM is the recommended authentication model. However, there
are disadvantages to the approach, primarily, if you have an existing application
or are unable to use an {{site.data.keyword.cloudant_short_notm}}-supported client library.

<table>

<tr>
<th id="mode">Mode</th>
<th id="advantages">Advantages</th>
<th id="disadvantages">Disadvantages</th>
</tr>

<tr>
<td headers="mode">IAM</td>
<td headers="advantages" valign="top"><ul><li>Manage access for many services by using one interface. Revoke access to a user globally.</li>
<li>Account-level API keys via service IDs.</li>
<li>Easy-to-rotate credentials.</li>
<li>Activity Tracker logs capture individual humans and services.</li>
<li>IAM federates with other identity systems, like enterprise LDAP repositories.</li></ul>
</td>
<td headers="disadvantages"><ul><li>If you are not using {{site.data.keyword.cloudant_short_notm}}'s supported libraries, application changes are likely to be required to use IAM's API keys and access tokens.</li>
<li>No database-level permissions (yet).</li>
<li>No fine-grained permissions (for example, reader) (yet).</li>
<li>Some endpoints are unavailable, see [Unavailable Endpoints](#unavailable-endpoints).</li>
<li>No way to specify a database as "public", that is, not requiring an authorised user to access.</li></ul>
</td>
</tr>

<tr>
<td headers="mode">Legacy</td>
<td headers="advantages">
<ul><li>No need to change existing applications or client library dependencies.</li>
<li>Database-level permissions.</li>
<li>Fine-grained roles (reader, writer).</li>
</ul>
</td>
<td headers="disadvantages">
<ul><li>No account-level API keys; must use `root` credentials to manage databases.</li>
<li>Separate management of {{site.data.keyword.cloudant_short_notm}} credentials, so unable to get full overview of all access within centralised interface.</li>
<li>Hard to implement credential rotation.</li>
</ul>
</td>
</tr>
</table>

## Making requests to instances by using IAM credentials
{: #making-requests-to-instances-by-using-iam-credentials}

This section discusses how to use {{site.data.keyword.cloudant_short_notm}} with
service instances by using IAM authentication and access control. It uses the
details from the Service Credentials JSON example previously mentioned.

{{site.data.keyword.cloud_notm}} IAM requires that an IAM API key is exchanged for a time-limited access token before you make a request to a resource or service. The access token is then included in the `Authorization` HTTP header to the service. When the access token expires, the consuming application must handle getting a new one from the IAM token service. For more information, see [Getting an {{site.data.keyword.cloud_notm}} IAM token by using an API key ![External link icon](../images/launch-glyph.svg "External link icon")](https://cloud.ibm.com/docs/iam/apikey_iamtoken.html#iamtoken_from_apikey) documentation for more details.

{{site.data.keyword.cloudant_short_notm}}'s official client libraries handle obtaining a token from an API key for you. If you access {{site.data.keyword.cloudant_short_notm}} directly by using an HTTP client rather than an {{site.data.keyword.cloudant_short_notm}} client library, you must handle exchanging and refreshing a time-limited access token by using an IAM API key with the IAM token service. After a token expires, {{site.data.keyword.cloudant_short_notm}} returns an HTTP `401` status code.

### Required client library versions
{: #required-client-library-versions}

Use at minimum the following client library versions with IAM-enabled {{site.data.keyword.cloudant_short_notm}}
service instances:

| Library | Recommended |
| --- | --- |
| [java-cloudant ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant/java-cloudant){: new_window} | 2.13.0+ |
| [nodejs-cloudant ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant/nodejs-cloudant){: new_window} | 2.3.0+ |
| [python-cloudant ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant/python-cloudant){: new_window} | 2.9.0+ |
| [couchbackup ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant/couchbackup/){: new_window} | 2.3.1+ |
| [CDTDatastore ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant/cdtdatastore/){: new_window} | 2.0.3+ |
| [sync-android ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant/sync-android/){: new_window} | 2.2.0+ |

The following code snippets require these versions.

### Java
{: #java-iam}

Requires [java-cloudant ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant/java-cloudant){: new_window}, 2.13.0+.

Use the `iamApiKey()` method to create a database client with an IAM API key:

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

### Node.js
{: #node.js}

Requires [nodejs-cloudant ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant/nodejs-cloudant){: new_window}, 2.3.0+.

Use the `iamauth` plug-in to create a database client with an IAM API key:

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

### Python
{: #python}

Requires [python-cloudant ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant/python-cloudant){: new_window}, 2.9.0+.

Use the `Cloudant.iam(account_name, api_key, **kwargs)` method to create a
database client with an IAM API key:

```python
from cloudant.client import Cloudant

client = Cloudant.iam(
    "76838001-b883-444d-90d0-46f89e942a15-bluemix",
    "MxVp86XHkU82Wc97tdvDF8qM8B0Xdit2RqR1mGfVXPWz",
    connect=True
)
print client.all_dbs()
```

### Access by using HTTP client
{: #access-by-using-http-client}

{{site.data.keyword.cloud_notm}} IAM requires that an IAM API key is exchanged for a time-limited
access token before you make a request to a resource or service. The access token
is then included in the `Authorization` HTTP header to the service. When the
access token expires, the client must handle getting a new one from the IAM
token service.

As stated previously, using {{site.data.keyword.cloud_notm}} IAM requires that you first exchange an {{site.data.keyword.IBM_notm}} API key for a time-limited access token, and then use the token to authenticate against the {{site.data.keyword.cloudant_short_notm}} API.

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

## Reference
{: #reference}

This section contains a complete list of {{site.data.keyword.cloudant_short_notm}}'s IAM actions and what actions
are allowed for each IAM system role.

### {{site.data.keyword.cloudant_short_notm}} actions
{: #ibm-cloudant-actions}

Action | Description
-------|------------
`cloudant.db.any` | Access any database endpoint (those whose path does not start `/_api`).
`cloudantnosqldb.sapi.dbsecurity` | Access `/_api/v2/db/<path:db>/_security`.
`cloudantnosqldb.sapi.usercors` | Access `/_api/v2/user/config/cors/`.
`cloudantnosqldb.sapi.apikeys` | Access `/_api/v2/api_keys`.
`cloudantnosqldb.sapi.userinfo` | Access `/_api/v2/user`.

#### Unavailable Endpoints
{: #unavailable-endpoints}

The following endpoints are unavailable to requests authorized with IAM:

- HTTP rewrite handers: `/db/_design/design-doc/_rewrite/path`. <br>
While design documents can contain rewrite handlers, users cannot call them.
- Update handers: `POST /{db}/_design/{ddoc}/_update/{func}`. <br>
While design documents can contain update functions, users cannot call them.

### Mapping of {{site.data.keyword.cloudant_short_notm}} actions to IAM roles
{: #mapping-of-ibm-cloudant-actions-to-iam-roles}

Only Manager role users and services can access {{site.data.keyword.cloudant_short_notm}} data.

Role | Allowed actions
-----|----------------
Manager | All documented actions.
Reader | None.
Writer | None.

## Troubleshooting
{: #troubleshooting}
If you are having trouble using IAM to authenticate when making requests to your {{site.data.keyword.cloudant_short_notm}} service instance, verify your account as shown in the next section.

### Ensure your account is IAM enabled
{: #ensure-your-account-is-iam-enabled}

You must open a support ticket to confirm that a service instance is IAM enabled.
