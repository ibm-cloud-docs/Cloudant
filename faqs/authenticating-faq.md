---

copyright:
  years: 2020, 2023
lastupdated: "2023-04-11"

keywords: legacy, iam access controls, use only iam mode, generate service credentials, iam mode

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# Authenticating with {{site.data.keyword.cloudant_short_notm}} FAQ
{: #faq-authenticating-cloudant}
{: faq}
{: support}

{{site.data.keyword.cloud}} Identity and Access Management (IAM) combines managing user identities, services, and access control into one approach. {{site.data.keyword.cloudantfull}} integrates with {{site.data.keyword.cloud_notm}} Identity and Access Management.
{: shortdesc}

## What is the difference between {{site.data.keyword.cloudant_short_notm}} legacy and IAM access controls?
{: #diff-legacy-iam}
{: faq}

### {{site.data.keyword.cloud_notm}} IAM
{: #ibm-cloud-iam}

- Centrally managed access management across {{site.data.keyword.cloud_notm}}.
- Allows a user or service to access many different resources by using the same set of credentials (for example, same username and password or IAM API key).
- IAM API keys can be granted access to account management functions, like creating new databases.

### {{site.data.keyword.cloudant_short_notm}} legacy
{: #ibm-cloudant-legacy}

- Unique to {{site.data.keyword.cloudant_short_notm}}.
- Access to each service instance requires its own set of credentials.
- Uses HTTP basic authentication with credentials that aren't bound to an individual user or service.


## Why is the *Use only IAM* mode preferred?
{: #use-legacy-or-iam}
{: faq}

The *Use only IAM* mode means that only IAM credentials are provided through service binding and credential generation. You gain the following advantages when you use {{site.data.keyword.cloud_notm}} IAM:

- Managing access to {{site.data.keyword.cloudant_short_notm}} with the standard tooling of {{site.data.keyword.cloud_notm}}.
- Using credentials that you can easily revoke and rotate when you use {{site.data.keyword.cloud_notm}} IAM.

For more information about the advantages and disadvantages between these modes, see [Advantages and disadvantages of the two access control mechanisms](/docs/Cloudant?topic=Cloudant-managing-access-for-cloudant#advantages-and-disadvantages-of-the-two-access-control-mechanisms-ai).

## How can I create an instance by using the command line?
{: #create-iam-command-line}
{: faq}

When you create a new {{site.data.keyword.cloudant_short_notm}} instance from the command line, you must include the `ibmcloud` tool by using the `-p` parameter. This parameter enables or disables legacy credentials for an account by passing the option in JSON format. The option is called `legacyCredentials`.

To create an instance as *Use only IAM*, run the following command:

```sh
ibmcloud resource service-instance-create  "Instance Name" \
    cloudantnosqldb Standard us-south \
    -p '{"legacyCredentials": false}'
```
{: codeblock}

If you don't use *Use only IAM* mode when you use the IAM Reader and Writer roles, you might grant users legacy credentials with more access permissions than you intended.
{: note}

## How can I generate service credentials?
{: #find-service-credentials-iam}
{: faq}

You can generate service credentials in the primary {{site.data.keyword.cloud_notm}} IAM interface. When you select *Use only IAM*, service credentials include only IAM values. The service credential JSON looks like the following example:

```json
{
  "apikey": "MxVp86XHkU82Wc97tdvDF8qM8B0Xdit2RqR1mGfVXPWz",
  "host": "2922d728-27c0-4c7f-aa80-1e59fbeb04d0-bluemix.cloudant.com",
  "iam_apikey_description": "Auto generated apikey during resource-key [...]",
  "iam_apikey_name": "auto-generated-apikey-050d21b5-5f[...]",
  "iam_role_crn": "crn:v1:bluemix:public:iam::::serviceRole:Manager",
  "iam_serviceid_crn": "crn:v1:staging:public:iam-identity::[...]",
  "url": "https://76838001-b883-444d-90d0-46f89e942a15-bluemix.cloudant.com",
  "username": "76838001-b883-444d-90d0-46f89e942a15-bluemix"
}
```
{: codeblock}

The values for the previous example are described in the following list:

`apikey`
:   IAM API key.

`host`
:   The DNS that resolves domain names with their corresponding IP addresses.

`iam_apikey_description`
:   Description of IAM API key.

`iam_apikey_name`
:   ID of IAM API key.

`iam_role_crn`
:   The IAM role that the IAM API key has.

`iam_serviceid_crn`
:   The CRN of service ID.

`url`
:   {{site.data.keyword.cloudant_short_notm}} service URL.

`username`
:   The internal {{site.data.keyword.cloudant_short_notm}} account name.

For more information, see [{{site.data.keyword.cloud_notm}} API keys and Use only IAM](/docs/Cloudant?topic=Cloudant-managing-access-for-cloudant#ibm-cloudant-api-keys-and-use-only-iam_ai).


## How do I rotate my credentials?
{: #rotate-credentials}

In most cases, rotating credentials is a straight-forward process:

1. Generate a replacement service credential. For more information, see [How can I generate service credentials?](#find-service-credentials-iam)
1. Replace the current credential with the newly generated credential.
1. Delete the no-longer-used service credential.

However, when you rotate the credentials for a replication, if you are using legacy credentials in the replication document,
the replication starts from the beginning. To ensure that changes arrive in a timely manner, we advise you to create a
new replication once it catches up with deleting the previous replication and the associated service credential.
The process is described in the following steps:

1. Generate a replacement service credential. For more information, see [How can I generate service credentials?](#find-service-credentials-iam)

1. Create a replication with the same settings but new credentials.

1. Monitor the new replication by using [Active Tasks](/docs/Cloudant?topic=Cloudant-active-tasks), or you can use [`_scheduler/jobs`](https://cloud.ibm.com/apidocs/cloudant#getschedulerjobs).

1. Once the `changes_pending` field for the new replication is a suitably low value for your requirements, the replication that uses the previous credentials can be deleted.

1. Delete the no-longer-used service credential.

Replications that use IAM API keys can be updated to use a new API key directly, without delaying the changes that are replicating.
{: important}

