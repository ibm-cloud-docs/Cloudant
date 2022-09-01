---

copyright:
  years: 2022
lastupdated: "2022-08-29"

keywords: legacy credentials, revoke credential, instance url style credential, authentication, security, credential rotation

subcollection: Cloudant

content-type: tutorial
services: Cloudant
account-plan: lite
completion-time: 10m

---

{{site.data.keyword.attribute-definition-list}}

# Revoking credential that is tied to your instance URL
{: #revoke-instance-url-style-credential}
{: toc-content-type="tutorial"}
{: toc-services="Cloudant"}
{: toc-completion-time="10m"}

When you create a new service credential by using the {{site.data.keyword.cloud_notm}} Dashboard or the
{{site.data.keyword.cloud_notm}} CLI, it always produces a new username and password combination as your
{{site.data.keyword.cloudantfull}} legacy credentials. As expected, deleting the service credential effectively revokes access for any
applications that use those credentials.
{: shortdesc}

Service credentials were not always handled like this though. Before 15 January 2021, creating a new service credential would always
produce the same {{site.data.keyword.cloudant_short_notm}} legacy credential username and password combination.
Deleting the service credential did not revoke its access either. This practice was required to 
prevent breaking legacy applications that expected this behavior.

This tutorial is only applicable to {{site.data.keyword.cloudant_short_notm}} instances provisioned before 15 January 2021 with
{{site.data.keyword.cloudant_short_notm}} legacy credentials enabled. Instances provisioned after this date already use
the new format of legacy credentials.
{: important}

You can inspect the username of your {{site.data.keyword.cloudant_short_notm}} legacy credentials to verify which
type you are currently using. The old style credential uses the format `<RANDOM_ID>-bluemix` for username, which matches your {{site.data.keyword.cloudant_short_notm}} instance URL. The new style credentials
use `apikey-v2-<RANDOM_ID>`.


## Objectives
{: #objectives-revoke}

- Update your applications to use the new style credentials in place of the instance URL style credentials.
- Revoke access to the old style {{site.data.keyword.cloudant_short_notm}} legacy credential. 

## Generating new {{site.data.keyword.cloudant_short_notm}} legacy credentials
{: #generate-new-service-credentials-url}
{: step}

1. Use the {{site.data.keyword.cloud_notm}} Dashboard or the {{site.data.keyword.cloud_notm}} CLI to [generate new service credentials](/docs/Cloudant?topic=Cloudant-getting-started-with-cloudant#creating-service-credentials) for your {{site.data.keyword.cloudant_short_notm}} instance. See [Creating service credentials](#creating-service-credentials) for further instructions.

## Updating applications
{: #update-rotate-application-credentials}
{: step}

1. Update all applications that have access to the {{site.data.keyword.cloudant_short_notm}} instance to use the new username and password combination.

## Revoking access to the instance URL style credential
{: #revoke-credentials-url}
{: step}

This operation cannot be undone. Make sure all your applications are no longer using the old style credential before you start this procedure.
{: important}

1. Go to [{{site.data.keyword.cloud_notm}}](https://cloud.ibm.com/resources).

2. Find your {{site.data.keyword.cloudant_short_notm}} instance on the list of resources and open it.

   ![Select your instance from the list of instances in your resource list.](images/img0011.png){: caption="Figure 1. Select your instance" caption-side="bottom"}

3. Click the *Revoke* button under the *Cloudant credentials status* section. If you do not see the information in the next screen capture, the credential was already revoked or it never existed.

   ![Revoke instance URL style credential.](images/revoke-creds-status.png){: caption="Figure 2. Revoke instance URL style credential" caption-side="bottom"}

4. Click OK to confirm your action on the dialog window to proceed.

5. When the operation completes successfully, the status changes to `Revoked`.

After the credential is revoked by using this process, the 
*Cloudant credentials status* section no longer appears on the page.
{: note}
