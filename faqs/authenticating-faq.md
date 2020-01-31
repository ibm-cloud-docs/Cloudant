---

copyright:
  years: 2020
lastupdated: "2020-01-30"

keywords: legacy, iam access controls, use only iam mode, service credentials

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
{:external: target="_blank" .external}
{:faq: data-hd-content-type='faq'}

<!-- Acrolinx: 2019 -->

# Authenticating with {{site.data.keyword.cloudant_short_notm}} FAQ
{: #faq-authenticating-cloudant}

{{site.data.keyword.cloud}} Identity and Access Management (IAM) combines managing user identities, services, and access control into one approach. {{site.data.keyword.cloudantfull}} integrates with {{site.data.keyword.cloud_notm}} Identity and Access Management. 
{: shortdesc}

## What is the difference between {{site.data.keyword.cloudant_short_notm}} Legacy and IAM access controls?
{: #diff-legacy-iam}
{: faq}

{{site.data.keyword.cloud_notm}} IAM

- Centrally-managed access management across {{site.data.keyword.cloud_notm}}.
- Allows a user or service to access many different resources by using the same set of credentials (for example, same username/password or IAM API key).
- IAM API keys can be granted access to account management functions, like creating new databases.

{{site.data.keyword.cloudant_short_notm}} Legacy

- Unique to {{site.data.keyword.cloudant_short_notm}}.
- Access to each service instance requires its own set of credentials.
- Uses HTTP basic authentication with credentials that are not bound to an individual user or service.
- {{site.data.keyword.cloudant_short_notm}} API keys can only be granted permissions at the database level.

## Why must I use the *Use only IAM* mode?
{: #use-legacy-or-iam}
{: faq}

We recommend that you use the *Use only IAM* mode. This mode means that only IAM credentials are provided via service binding and credential generation. The advantages for using {{site.data.keyword.cloud_notm}} IAM include the management of access to {{site.data.keyword.cloudant_short_notm}} with {{site.data.keyword.cloud_notm}}'s standard tooling, and credentials that can be easily revoked and rotated when you use {{site.data.keyword.cloud_notm}} IAM.

For more information about the advantages and disadvantages between these modes, see [Advantages and disadvantages of the two access control mechanisms](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#advantages-and-disadvantages-of-the-two-access-control-mechanisms).

## How can I provision an instance by using the command line?
{: #provision-iam-command-line}
{: faq}

When you provision a new {{site.data.keyword.cloudant_short_notm}} instance from the command line, you must include the `ibmcloud` tool by using the `-p` parameter. This parameter enables or disables legacy credentials for an account by passing the option in JSON format. The option is called `legacyCredentials`.

To provision an instance as *Use only IAM*, run the following command:

```sh
ibmcloud resource service-instance-create  "Instance Name" \
    cloudantnosqldb Standard us-south \
    -p {"legacyCredentials": false}
```
{: codeblock}

If you don't use *Use only IAM* mode when you use the Reader and Writer IAM roles, you might allow users to be granted Legacy credentials with more access permissions than you intended.
{: note}

## How can I generate service credentials? 
{: #find-service-credentials-iam}
{: faq}

You can generate service credentials in the primary {{site.data.keyword.cloud_notm}} IAM interface. When you select *Use only IAM*, service credentials contain only IAM values. The service credential JSON looks like the following example:

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

- `apikey`: IAM API key.
- `host`: The DNS that resolves domain names with their corresponding IP addresses.
- `iam_apikey_description`: Description of IAM API key.
- `iam_apikey_name`: ID of IAM API key.
- `iam_role_crn`: The IAM role that the IAM API key has.
- `iam_serviceid_crn`: The CRN of service ID.
- `url`: {{site.data.keyword.cloudant_short_notm}} service URL.
- `username`: The internal {{site.data.keyword.cloudant_short_notm}} account name.

For more information, see the [IAM guide](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#should-i-use-_use-only-iam_-or-_use-both-legacy-credentials-and-iam_-).