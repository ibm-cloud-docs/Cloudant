---

copyright:
  years: 2017, 2019
lastupdated: "2019-01-31"

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

<!-- Acrolinx: 2017-05-10 -->

# Security
{: #security}

## {{site.data.keyword.cloudant_short_notm}} DBaaS Data Protection and Security
{: #ibm-cloudant-dbaas-data-protection-and-security}

Protecting application data for large-scale web and mobile apps can be complex,
especially with distributed and NoSQL databases.

Just as it reduces the effort of maintaining your databases
to keep them running and growing non-stop,
{{site.data.keyword.cloudantfull}} also ensures your data stays secure and protected.
{: shortdesc}

## Top-Tier Physical Platforms
{: #top-tier-physical-platforms}

The {{site.data.keyword.cloudant_short_notm}} DBaaS is
physically hosted on Tier-1 cloud infrastructure providers such as
{{site.data.keyword.cloud}} and Amazon.
Therefore,
your data is protected by the network and physical security measures that are employed by those providers,
including (but not limited to):

- Certifications: Compliance with SSAE16, SOC2 Type 1, ISAE 3402, ISO 27001, CSA, and other standards.
- Access and identity management.
- General physical security of data centers and network operations center monitoring.
- Server hardening.
- {{site.data.keyword.cloudant_short_notm}} gives you the flexibility to
  choose or switch among the different providers
  as your SLA and cost requirements change.

More details about the certifications are available in the [Compliance information](compliance.html).
{: tip}

## Secure Access Control
{: #secure-access-control}

{{site.data.keyword.cloudant_short_notm}} has a multitude of built-in security features,
for you to control access to data:

Feature | Description
--------|------------
Authentication | {{site.data.keyword.cloudant_short_notm}} is accessed by using an HTTPS API. Where the API endpoint requires it, the user is authenticated for every HTTPS request {{site.data.keyword.cloudant_short_notm}} receives. {{site.data.keyword.cloudant_short_notm}} supports both legacy and IAM access controls. For more information, see the [IAM guide](../guides/iam.html){: new_window} or the legacy [Authentication API document](../api/authentication.html){: new_window}.
Authorization | {{site.data.keyword.cloudant_short_notm}} supports both legacy and IAM access controls. The {{site.data.keyword.cloudant_short_notm}} team recommends that you use IAM access controls for authentication whenever possible. If you are using {{site.data.keyword.cloudant_short_notm}} legacy authentication, it is recommended that you use [API keys](../api/authorization.html#api-keys){: new_window} rather than account-level credentials for programmatic access and replication jobs. For more information, see the [IAM guide](../guides/iam.html){: new_window} or the legacy [Authentication API document](../api/authentication.html){: new_window} and the legacy [Authorization API document](../api/authorization.html){: new_window}.
At-rest encryption | All data that is stored in an {{site.data.keyword.cloudant_short_notm}} instance is encrypted at rest. If you require bring-your-own-key (BYOK) for encryption-at-rest, it is enabled by using {{site.data.keyword.cloud_notm}} Key Protect. {{site.data.keyword.cloudant_short_notm}} supports this feature for new {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware plan instances that are deployed in all regions. First, create an instance of the Dedicated Hardware plan by using the {{site.data.keyword.cloud_notm}} catalog. Then, submit a support ticket. Our support team coordinates getting your new Dedicated Hardware instance's encryption-at-rest encryption keys that are managed by your Key Protect instance.
"In-flight" encryption | All access to {{site.data.keyword.cloudant_short_notm}} is encrypted by using HTTPS.
TLS | We recommend that you use TLS 1.2 or 1.3 for all access to {{site.data.keyword.cloudant_short_notm}}. (***In June 2019, {{site.data.keyword.cloudant_short_notm}} support is retiring the use of older versions (TLS 1.0 and 1.1) at which point only TLS 1.2+ will be supported.***) The certificate {{site.data.keyword.cloudant_short_notm}} uses for HTTPS connections is signed by a universally trusted Certificate Authority that is pre-trusted by all browsers, operating systems, and other software systems like the Java Development Kit (JDK). We commit to always publishing a valid (non-expired) TLS certificate signed by a universally trusted Certificate Authority. We cannot, however, coordinate changes with customers, and we do not commit to remaining with DigiCert. To ensure continuous access to the {{site.data.keyword.cloudant_short_notm}} service, customers are strongly discouraged from pinning the current certificate, which is subject to expiration and prompt rotation in the event of compromise. We instead recommend that customers use the default certificate bundles for their operating systems and browsers, which will ensure continued secure service through any certificate changes.
Endpoints | All {{site.data.keyword.cloudant_short_notm}} instances are provided with external endpoints that are publically accessible. Dedicated Hardware environments provisioned after January 1, 2019 also add internal endpoints for all Standard plan instances deployed on them. Using internal endpoints allows customers to connect to an {{site.data.keyword.cloudant_short_notm}} instance through the internal {{site.data.keyword.cloud}} network to avoid upstream application traffic from going over the public network and incurring bandwidth charges. See [Service Endpoint documentation](https://cloud.ibm.com/docs/services/service-endpoint/getting-started.html#about){:new_window} for more details on enabling Service Endpoints for your {{site.data.keyword.cloud}} account.
IP whitelisting | {{site.data.keyword.cloudant_short_notm}} customers who have a dedicated {{site.data.keyword.cloudant_short_notm}} environment can whitelist IP addresses to restrict access to only specified servers and users. IP whitelisting is not available for any {{site.data.keyword.cloud_notm}} Public Lite/Standard plans that are deployed on multi-tenant environments. Open a support ticket to request IP whitelists for a specified set of IP or IP ranges. Note that IP whitelists apply to both the {{site.data.keyword.cloudant_short_notm}} API and Dashboard, so be mindful to include any administrator IPs that need to access the {{site.data.keyword.cloudant_short_notm}} Dashboard directly. 
CORS | Enable CORS support for specific domains by using the {{site.data.keyword.cloudant_short_notm}} Dashboard or API. For more information, see the [CORS API documentation](../api/cors.html){:new_window}.

<!--
> **Note**: Your data is visible to the {{site.data.keyword.cloudant_short_notm}} 
> worldwide team. If you don’t 
> want our team to see your data, encrypt it before sending it to 
> {{site.data.keyword.IBM_notm}}, and avoid leaking 
> data into your document `_id` and any attachment file names. In addition, 
> when you send personal data, you must use HTTPS to ensure that it is sent securely. 
> HTTP is no longer supported.  

> **Warning**: You are responsible for verifying that 
> {{site.data.keyword.cloudant_short_notm}} can be used to store 
> your data. You must also make sure that your data does not violate applicable 
> data protection laws or any regulations that require security measures 
> beyond those specified in the {{site.data.keyword.cloudant_short_notm}} 
> system requirements and {{site.data.keyword.cloud_notm}} Services terms. You must 
> verify that the security requirements are appropriate for any personal data 
> that is processed. If you are unsure, or intend to store data that is 
> beyond the scope of the {{site.data.keyword.cloudant_short_notm}} terms and conditions, 
> you must get approval from {{site.data.keyword.IBM_notm}} to ensure that it is 
> appropriate for {{site.data.keyword.cloudant_short_notm}} to store your data.
-->

## Protection Against Data Loss or Corruption
{: #protection-against-data-loss-or-corruption}

{{site.data.keyword.cloudant_short_notm}} has a number of features
to help you maintain data quality and availability:

Feature | Description
--------|------------
Redundant and durable data storage | By default, {{site.data.keyword.cloudant_short_notm}} saves to disk three copies of every document to three different nodes in a cluster. Saving the copies ensures that a working failover copy of your data is always available, regardless of failures.
Data replication and export | You can replicate your databases continuously between clusters in different data centers, or to an on-premises {{site.data.keyword.cloudant_short_notm}} Local cluster, or Apache CouchDB. Another option is to export data from {{site.data.keyword.cloudant_short_notm}} (in JSON format) to other locations or sources (such as your own data center) for added data redundancy.
