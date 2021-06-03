---

copyright:
  years: 2017, 2021
lastupdated: "2021-06-14"

keywords: dbaas data protection, top-tier physical platforms, secure access control, data loss, corruption, byok, encryption

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

<!-- Acrolinx: 2021-04-09 -->

# Securing your data
{: #securing-your-data-in-cloudant}

## {{site.data.keyword.cloudant_short_notm}} DBaaS data protection and security
{: #ibm-cloudant-dbaas-data-protection-and-security-sd}

Protecting application data for large-scale web and mobile apps can be complex,
especially with distributed and NoSQL databases.

Just as it reduces the effort of maintaining your databases
to keep them running and growing non-stop,
{{site.data.keyword.cloudantfull}} also ensures that your data stays secure and protected.
{: shortdesc}

## Tier one physical platforms
{: #top-tier-physical-platforms-sd}

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
- {{site.data.keyword.cloudant_short_notm}} gives you the flexibility to
  choose or switch among the different providers
  as your SLA and cost requirements change.

More details about the certifications are available in the [Compliance information](/docs/Cloudant?topic=Cloudant-compliance#compliance).
{: tip}

## Secure access control
{: #secure-access-control-sd}

{{site.data.keyword.cloudant_short_notm}} has a multitude of built-in security features,
for you to control access to data:

Feature | Description
--------|------------
Authentication | {{site.data.keyword.cloudant_short_notm}} is accessed by using an HTTPS API. Where the API endpoint requires it, the user is authenticated for every HTTPS request {{site.data.keyword.cloudant_short_notm}} receives. {{site.data.keyword.cloudant_short_notm}} supports both legacy and IAM access controls. For more information, see the [IAM guide](/docs/Cloudant?topic=Cloudant-managing-access-for-cloudant){: new_window} or the legacy [Authentication document](/docs/Cloudant?topic=Cloudant-work-with-your-account#authentication){: new_window}.
Authorization | {{site.data.keyword.cloudant_short_notm}} supports both legacy and IAM access controls. The {{site.data.keyword.cloudant_short_notm}} team recommends that you use IAM access controls for authentication whenever possible. If you're using {{site.data.keyword.cloudant_short_notm}} legacy authentication, it is recommended that you use [API keys](/docs/Cloudant?topic=Cloudant-api-keys){: new_window} rather than account-level credentials for programmatic access and replication jobs. For more information, see the [IAM guide](/docs/Cloudant?topic=Cloudant-managing-access-for-cloudant){: new_window} or the legacy [Authentication document](/docs/Cloudant?topic=Cloudant-work-with-your-account#authentication){: new_window} and the legacy [Authorization document](/docs/Cloudant?topic=Cloudant-work-with-your-account#authorization){: new_window}.
At-rest encryption | All data that is stored in an {{site.data.keyword.cloudant_short_notm}} instance is encrypted at rest by using LUKS1 with 256-bit Advanced Encryption Standard (AES-256). By default, {{site.data.keyword.cloudant_short_notm}} manages the encryption keys for all environments.  If you require bring-your-own-key (BYOK) encryption for encryption-at-rest, you enable it by using your encryption key that is stored in an {{site.data.keyword.cloud_notm}} Key Protect instance. {{site.data.keyword.cloudant_short_notm}} supports the BYOK feature for new {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware plan instances that are deployed in all regions. For more information, see the [Creating an {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware plan instance](/docs/Cloudant?topic=Cloudant-creating-and-leveraging-an-ibm-cloudant-dedicated-hardware-plan-instance-on-ibm-cloud) tutorial for details on how to choose BYOK at provisioning time. 
In-flight encryption | All access to {{site.data.keyword.cloudant_short_notm}} is encrypted by using HTTPS.
Client-side encryption | Customers can use client-side encryption to ensure that the data protection is controlled by the data owner and the data is never visible to the service provider. For more information, see the [Client-Side Transformation blog](https://blog.cloudant.com/2018/10/10/Client-Side-Transformation.html){: new_window}{: external} for examples of doing client-side transformation of data by using the client libraries for Java&trade;, Python, and Node.js. 
TLS | {{site.data.keyword.cloudant_short_notm}} requires the use of TLS 1.2+. The certificate {{site.data.keyword.cloudant_short_notm}} uses for HTTPS connections is signed by a universally trusted certificate authority. This certificate is pre-trusted by all browsers, operating systems, and other software systems like the Java&trade; Development Kit (JDK). {{site.data.keyword.cloudant_short_notm}} commits to always publishing a valid (non-expired) TLS certificate that is signed by a universally trusted certificate authority. However, {{site.data.keyword.cloudant_short_notm}} can't coordinate changes with customers, nor commit to staying with DigiCert. To ensure continuous access to the {{site.data.keyword.cloudant_short_notm}} service, customers are discouraged from pinning the current certificate. If the service is compromised, the certificate can expire or be rotated quickly. Instead, {{site.data.keyword.cloudant_short_notm}} recommends that customers use the default certificate bundles for their operating systems and browsers that ensure continued secure service through any certificate changes.
Endpoints | All {{site.data.keyword.cloudant_short_notm}} instances are provided with external endpoints that are publicly accessible. Dedicated Hardware environments created after 1 January 2019 outside of the EU-managed cloud also add internal endpoints for all Standard plan instances deployed on them. Using internal endpoints allows customers to connect to an {{site.data.keyword.cloudant_short_notm}} instance through the internal {{site.data.keyword.cloud}} network to avoid upstream application traffic from going over the public network and incurring bandwidth charges. For more information, see [Service Endpoint documentation](/docs/account?topic=account-service-endpoints-overview){:new_window}{: external} for more details on enabling Service Endpoints for your {{site.data.keyword.cloud}} account.
IP allowlisting | {{site.data.keyword.cloudant_short_notm}} customers who have a dedicated {{site.data.keyword.cloudant_short_notm}} environment can allowlist IP addresses to restrict access to only specified servers and users. IP allowlisting isn't available for any {{site.data.keyword.cloud_notm}} Public Lite or Standard plans that are deployed on multi-tenant environments. Open a support ticket to request IP allowlists for a specified set of IP or IP ranges. IP allowlists apply to both the {{site.data.keyword.cloudant_short_notm}} API and Dashboard, so be mindful to include any administrator IP that needs to access the {{site.data.keyword.cloudant_short_notm}} Dashboard directly. 
CORS | Enable CORS support for specific domains by using the {{site.data.keyword.cloudant_short_notm}} Dashboard or API. For more information, see the [CORS documentation](/docs/Cloudant?topic=Cloudant-cors#cors){:new_window}.
{: caption="Table 1. {{site.data.keyword.cloudant_short_notm}} security features" caption-side="top"}
<!--
> **Note**: Your data is visible to the {{site.data.keyword.cloudant_short_notm}} 
> worldwide team. If you don’t 
> want our team to see your data, encrypt it before sending it to 
> {{site.data.keyword.IBM_notm}}, and avoid leaking 
> data into your document `_id` and any attachment file names. In addition, 
> when you send personal data, you must use HTTPS to ensure that it's sent securely. 
> HTTP is no longer supported.  

> **Warning**: You're responsible for verifying that 
> {{site.data.keyword.cloudant_short_notm}} can be used to store 
> your data. You must also make sure that your data does not violate applicable 
> data protection laws or any regulations that require security measures 
> beyond those specified in the {{site.data.keyword.cloudant_short_notm}} 
> system requirements and {{site.data.keyword.cloud_notm}} Services terms. You must 
> verify that the security requirements are appropriate for any personal data 
> that is processed. If you're unsure, or intend to store data that is 
> beyond the scope of the {{site.data.keyword.cloudant_short_notm}} terms and conditions, 
> you must get approval from {{site.data.keyword.IBM_notm}} to ensure that it's 
> appropriate for {{site.data.keyword.cloudant_short_notm}} to store your data.
-->

## Protection against data loss or corruption
{: #protection-against-data-loss-or-corruption-sd}

{{site.data.keyword.cloudant_short_notm}} has a number of features
to help you maintain data quality and availability:

Feature | Description
--------|------------
Redundant and durable data storage | By default, {{site.data.keyword.cloudant_short_notm}} saves to disk three copies of every document to three different nodes in a cluster. Saving the copies ensures that a working failover copy of your data is always available, regardless of failures.
Data replication and export | You can replicate your databases continuously between clusters in different data centers or Apache CouchDB. Another option is to export data from {{site.data.keyword.cloudant_short_notm}} (in JSON format) to other locations or sources (such as your own data center) for added data redundancy.
{: caption="Table 2. IBM Cloudant data quality and availability features" caption-side="top"}
