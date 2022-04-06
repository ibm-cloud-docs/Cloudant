---

copyright:
  years: 2017, 2022
lastupdated: "2022-04-06"

keywords: dbaas data protection, tier 1 physical platforms, secure access control, data loss, corruption, byok, encryption, protection 

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

# Security
{: #security}

Protecting application data for large-scale web and mobile apps can be complex,
especially with distributed and NoSQL databases.

Just as it reduces the effort of maintaining your databases
to keep them running and growing nonstop,
{{site.data.keyword.cloudantfull}} also ensures your data stays secure and protected.
{: shortdesc}

## Tier one physical platforms
{: #top-tier-physical-platforms}

The {{site.data.keyword.cloudant_short_notm}} DBaaS is
physically hosted on Tier-1 cloud infrastructure providers such as
{{site.data.keyword.cloud}} and Amazon.
Therefore,
your data is protected by the network and physical security measures that are employed by those providers,
including (but not limited to):

- Certifications - Compliance with SSAE16, SOC2 Type 1, ISAE 3402, ISO 27001, CSA, and other standards.
- Access and identity management.
- General physical security of data centers and network operations center monitoring.
- Server hardening.
- {{site.data.keyword.cloudant_short_notm}} gives you the flexibility to choose or switch among the different providers as your SLA and cost requirements change.

More details about the certifications are available in the [Compliance information](/docs/Cloudant?topic=Cloudant-compliance#compliance).
{: tip}

## Secure access control
{: #secure-access-control}

{{site.data.keyword.cloudant_short_notm}} has a multitude of built-in security features for you to control access to data:

Feature | Description
--------|------------
Authentication | {{site.data.keyword.cloudant_short_notm}} is accessed by using an HTTPS API. Where the API endpoint requires it, the user is authenticated for every HTTPS request {{site.data.keyword.cloudant_short_notm}} receives. {{site.data.keyword.cloudant_short_notm}} supports both legacy and IAM access controls. For more information, see the [IAM guide](/docs/Cloudant?topic=Cloudant-managing-access-for-cloudant) or the legacy [Authentication API document](/docs/Cloudant?topic=Cloudant-work-with-your-account#authentication).
Authorization | {{site.data.keyword.cloudant_short_notm}} supports both legacy and IAM access controls. The {{site.data.keyword.cloudant_short_notm}} team recommends that you use IAM access controls for authentication whenever possible. If you're using {{site.data.keyword.cloudant_short_notm}} legacy authentication, {{site.data.keyword.cloudant_short_notm}} team recommends that you use [API keys](/apidocs/cloudant#introduction){: external} rather than account-level credentials for programmatic access and replication jobs. For more information, see the [IAM guide](/docs/Cloudant?topic=Cloudant-managing-access-for-cloudant) or the legacy [Authentication document](/docs/Cloudant?topic=Cloudant-work-with-your-account#authentication) and the legacy [Authorization document](/docs/Cloudant?topic=Cloudant-work-with-your-account#authorization).
At-rest encryption | All data that is stored in an {{site.data.keyword.cloudant_short_notm}} instance is encrypted at rest by using LUKS1 with 256-bit Advanced Encryption Standard (AES-256). By default, {{site.data.keyword.cloudant_short_notm}} manages the encryption keys for all environments.  If you require bring-your-own-key (BYOK) encryption for encryption-at-rest, BYOK is enabled by using your encryption key that is stored in an {{site.data.keyword.cloud_notm}} Key Protect instance. {{site.data.keyword.cloudant_short_notm}} supports the BYOK feature for new {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware plan instances that are deployed in all regions. For more information, see the [Creating an {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware plan instance](/docs/Cloudant?topic=Cloudant-creating-and-leveraging-an-ibm-cloudant-dedicated-hardware-plan-instance-on-ibm-cloud) tutorial for details on how to choose BYOK at provisioning time. 
In-flight encryption | All access to {{site.data.keyword.cloudant_short_notm}} is encrypted by using HTTPS.
Client-side encryption | Customers can use client-side encryption to ensure that the data protection is controlled by the data owner and the data is never visible to the service provider.
TLS | {{site.data.keyword.cloudant_short_notm}} requires the use of TLS 1.2+. {{site.data.keyword.cloudant_short_notm}} strongly recommends that you do not pin certificates in your application. Certificates renew on a regular basis, at least annually, and intermediate and root certificates could change when they do. {{site.data.keyword.cloudant_short_notm}} does not send out notifications prior to certificate renewals. We recommend that you keep your certificate trust store up-to-date with the latest root certificates. {{site.data.keyword.cloudant_short_notm}} acquires its certificates from DigiCert. You can find their root certificates on [this page](https://www.digicert.com/kb/digicert-root-certificates.htm){: external}. {{site.data.keyword.cloudant_short_notm}} sends a notification if we move to a different Certificate Authority.
Public Endpoints | All {{site.data.keyword.cloudant_short_notm}} instances are provided with external endpoints that are publicly accessible. 
Private Endpoints | All instances that you deploy on Dedicated Hardware plan environments also have private (internal) endpoints. Using private endpoints allows customers to connect to an {{site.data.keyword.cloudant_short_notm}} instance through the internal {{site.data.keyword.cloud}} network to avoid upstream application traffic from going over the public network and incurring bandwidth charges. For more information, see [Service Endpoint documentation](/docs/account?topic=account-service-endpoints-overview){: external}, and also, see documentation about [enabling Service Endpoints](/docs/Cloudant?topic=Cloudant-service-endpoints) for your {{site.data.keyword.cloud}} account. If you want to allow only a subset of IP addresses to be able to access your application, refer to IP allowlisting in the next row.
IP allowlisting | {{site.data.keyword.cloudant_short_notm}} customers who have an {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware plan environment can allowlist IP addresses to restrict access to only specified servers and users. IP allowlisting isn't available for any {{site.data.keyword.cloud_notm}} Public Lite or Standard plans that are deployed on multi-tenant environments. Open a support ticket to request an IP allowlist for a specific set of IP addresses or IP ranges. The public and private network allowlists can be managed independently, and the public allowlist can be set to block all traffic so that all traffic is over the private endpoints. IP allowlists apply to both the {{site.data.keyword.cloudant_short_notm}} API and Dashboard, so be mindful to include any administrator IP addresses that need to access the {{site.data.keyword.cloudant_short_notm}} Dashboard directly. 
CORS | Enable CORS support for specific domains by using the {{site.data.keyword.cloudant_short_notm}} Dashboard or API. For more information, see the [CORS API documentation](/apidocs/cloudant#getcorsinformation){: external}.
{: caption="Table 1. {{site.data.keyword.cloudant_short_notm}} security features" caption-side="top"}

## Protection against data loss or corruption
{: #protection-against-data-loss-or-corruption}

{{site.data.keyword.cloudant_short_notm}} has a number of features
to help you maintain data quality and availability:

Feature | Description
--------|------------
Redundant and durable data storage | By default, {{site.data.keyword.cloudant_short_notm}} saves to disk three copies of every document to three different nodes in a cluster. Saving the copies ensures that a working failover copy of your data is always available, regardless of failures.
Data replication and export | You can replicate your databases continuously between clusters in different data centers or Apache CouchDB. Another option is to export data from {{site.data.keyword.cloudant_short_notm}} (in JSON format) to other locations or sources (such as your own data center) for added data redundancy.
{: caption="Table 2. {{site.data.keyword.cloudant_short_notm}} data quality and availability features" caption-side="top"}
