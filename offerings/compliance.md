---

copyright:
  years: 2017, 2023
lastupdated: "2023-09-11"

keywords: tier-1 physical system, hipaa, iso, pci dss, soc 2 type 2 certification, gdpr, soc 1 type 2 certification, soc 3 certification

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# Compliance
{: #compliance}

{{site.data.keyword.cloudantfull}} provides a trustworthy and secure cloud database system.
The service is built on best-in-industry standards,
including ISO 27001:2013.
{: shortdesc}

## Tier-1 physical systems
{: #tier-1-physical-systems}

{{site.data.keyword.cloudant_short_notm}} DBaaS is physically hosted
on Tier-1 cloud infrastructure providers such as {{site.data.keyword.cloud}}.
Therefore,
your data is protected by the network and physical security measures that are employed by these providers.

## General Data Protection Regulation (GDPR)
{: #general-data-protection-regulation-gdpr-overview}

The GDPR seeks to create a harmonized data protection law 
framework across the EU. It also aims to give citizens back the control of their personal data, while
it imposes strict rules on those entities who host and "process" this data, anywhere in the world. The 
Regulation also introduces rules that relate to the free movement of personal data within and outside the EU. For more information, see the [{{site.data.keyword.IBM_notm}} privacy statement](https://www.ibm.com/privacy/){: external}.

## HIPAA
{: #hipaa}

{{site.data.keyword.cloudant_short_notm}} meets the required {{site.data.keyword.IBM_notm}} controls that are commensurate with the Health Insurance Portability and Accountability Act of 1996 (HIPAA) Security and Privacy Rule requirements. These requirements include the appropriate administrative, physical, and technical safeguards required of Business Associates in 45 CFR Part 160 and Subparts A and C of Part 164. HIPAA must be requested at the time of provisioning and applies to the {{site.data.keyword.cloudant_short_notm}} Enterprise plan, 
{{site.data.keyword.cloudant_short_notm}} on {{site.data.keyword.cloud_notm}} Dedicated plan, and {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware plan on {{site.data.keyword.cloud_notm}}. Contact your sales representative to sign a Business Associate Addendum (BAA) agreement with {{site.data.keyword.IBM_notm}}.

## International Organization for Standardization (ISO)
{: #international-organization-for-standardization-iso-}

{{site.data.keyword.cloudant_short_notm}} and {{site.data.keyword.cloudant_short_notm}} Dedicated Cluster are audited by a third-party security firm and meet ISO 27001, ISO 27017, and ISO 27018 requirements. For more information, see the [{{site.data.keyword.cloudant_short_notm}} Compliance page]( https://www.ibm.com/cloud/compliance){: external} for links to the certificates. The following descriptions on the {{site.data.keyword.cloudant_short_notm}} Compliance page cover the {{site.data.keyword.cloudant_short_notm}} service and respective certifications:
 
- {{site.data.keyword.cloud_notm}} Services (PaaS and SaaS) certified cloud product listing
- {{site.data.keyword.cloud_notm}} Services (PaaS and SaaS) certificate - ISO 27001
- {{site.data.keyword.cloud_notm}} Services (PaaS and SaaS) certificate - ISO 27017
- {{site.data.keyword.cloud_notm}} Services (PaaS and SaaS) certificate - ISO 27018

## PCI
{: #pci}

The following {{site.data.keyword.cloudant_short_notm}} plans are compliant with the Payment Card Industry Data Security Standard (PCI DSS): 

- Multi-tenant Lite.
- Standard.
- Standard plan instances that are deployed on Dedicated Hardware plan environments.

{{site.data.keyword.cloud_notm}} completes annual PCI DSS assessments by using an approved Qualified Security Assessor (QSA), and the resulting Attestations of Compliance (AOCs) and Service Responsibility Matrix guides are available upon customer request. Auditors reviewed {{site.data.keyword.cloudant_short_notm}} for compliance under PCI DSS version 3.2.1 at Service Provider Level 1. 

If you intend to store sensitive information in an {{site.data.keyword.cloudant_short_notm}} database, you must use client-side encryption to render data unreadable to {{site.data.keyword.cloudant_short_notm}} operators. For example, for PCI DSS compliance, you must encrypt the Primary Account Number (PAN) before sending a document that contains it to the database.
{: tip}

Customers are responsible for the storing, processing, and transmission of their cardholder data, and can create cardholder data environments (CDEs) that can store, transmit, or process cardholder data by using {{site.data.keyword.cloudant_short_notm}}. Customers can use the {{site.data.keyword.cloud_notm}} AOCs and SRM guides when they seek their own PCI DSS certifications. It is the responsibility of the customer to document and operate CDEs and applications that are built by using {{site.data.keyword.cloud_notm}} Platform services in a PCI DSS-compliant manner. 

{{site.data.keyword.cloudant_short_notm}} documentation on [service security](/docs/Cloudant?topic=Cloudant-general-data-protection-regulation-gdpr-#service-security) and [deletion of data](/docs/Cloudant?topic=Cloudant-general-data-protection-regulation-gdpr-#deletion-of-data) covers methods to manage cardholder data within the environment in accordance with PCI requirements. It is the customer’s responsibility to familiarize themselves with these processes and to manage data retention and removal from the service according to the customer’s policies. To facilitate this process, no cardholder data can be used in an {{site.data.keyword.cloudant_short_notm}} document ID. If PAN data is to be stored in {{site.data.keyword.cloudant_short_notm}}, they must be rendered unreadable (in accordance with PCI requirement 3.5) before transmission to the {{site.data.keyword.cloudant_short_notm}} service.

A full list of PCI DSS-ready {{site.data.keyword.cloud_notm}} Platform services and options to request that a PCI DSS AOC and SRM guide can be found at the [{{site.data.keyword.cloud_notm}} compliance page](https://www.ibm.com/cloud/compliance#Industry%20programs){: external}.

## SOC 1 Type 2, SOC 2 Type 2, and SOC 3 Certification
{: #soc_type}

{{site.data.keyword.IBM_notm}} provides a Service Organization Controls (SOC) report 
for {{site.data.keyword.cloudant_short_notm}}. The reports evaluate IBM's operational controls according to the criteria set 
by the American Institute of Certified Public Accountants (AICPA) Trust Services Principles. 
The Trust Services Principles define adequate control systems and establish industry standards 
for service providers such as {{site.data.keyword.cloud_notm}} to safeguard their customers' data and information.

You can request an SOC report from the Customer portal 
or contact your sales representative. Alternatively, you can open 
a support ticket with [{{site.data.keyword.cloud_notm}} Support](https://www.ibm.com/cloud/support).
