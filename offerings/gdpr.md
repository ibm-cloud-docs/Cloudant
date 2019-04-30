---

copyright:
  years: 2018, 2019
lastupdated: "2019-04-25"

keywords: audit access ibm cloudant, supported classifications of personal data, personal data, sensitive personal data, restrictions on processing, encrypt data, data locations, service security, delete data

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

<!-- Acrolinx: 2017-05-10 -->

# General Data Protection Regulation (GDPR)
{: #general-data-protection-regulation-gdpr-}

The GDPR seeks to create a harmonized data protection law framework across the EU and aims 
to give citizens back the control of their personal data, while imposing strict rules on 
those hosting and ‘processing’ this data, anywhere in the world. The Regulation also introduces 
rules that relate to the free movement of personal data within and outside the EU. 

With the [General Data Protection Regulation ![External link icon](../images/launch-glyph.svg "External link icon")](https://www.eugdpr.org/){: new_window},
{{site.data.keyword.cloudantfull}} customers can rely on 
the {{site.data.keyword.cloudant_short_notm}} team's understanding and
compliance with emerging data privacy standards and legislation and 
also in {{site.data.keyword.IBM}}'s wider ability to provide a 
comprehensive suite of solutions
to assist businesses of all sizes with their own internal data governance requirements.

## How do I audit access to {{site.data.keyword.cloudant_short_notm}}?
{: #how-do-i-audit-access-to-ibm-cloudant-}

You can find information about auditing in [Audit logging](/docs/services/Cloudant?topic=cloudant-audit-logging#audit-logging){: new_window}. 

## Supported classifications of Personal Data
{: #supported-classifications-of-personal-data}

The following categories of Personal Data are supported by {{site.data.keyword.cloudant_short_notm}} 
for GDPR:

**Personal Data**, for example:
 * Identity/civil status
 * Personal life
 * Professional life
 * Location data
 * Connectivity/device data

**Sensitive Personal Data**, which is restricted to:
  * Health data, extra conditions apply to be covered in the [{{site.data.keyword.cloudant_short_notm}} Dedicated Cluster Service Description ![External link icon](../images/launch-glyph.svg "External link icon")](https://www-03.ibm.com/software/sla/sladb.nsf/pdf/6756-04/$file/i126-6756-04_05-2018_en_US.pdf){: new_window} and [{{site.data.keyword.cloud}} Additional Service Description ![External link icon](../images/launch-glyph.svg "External link icon")](https://www-03.ibm.com/software/sla/sladb.nsf/pdf/6627-04/$file/i126-6627-04_04-2018_en_US.pdf){: new_window}

If you are storing healthcare data, you *must* complete the following tasks:
 - Notify {{site.data.keyword.cloudant_short_notm}} before writing any data.
 - Request a HIPAA-compliant dedicated cluster.

For more information about supported classifications of Personal Data, see the 
[Data Sheet Addendum (DSA) under 2. Personal Data ![External link icon](../images/launch-glyph.svg "External link icon")](https://www.ibm.com/software/reports/compatibility/clarity-reports/report/html/softwareReqsForProduct?deliverableId=2EBB5860B34311E7A9EB066095601ABB){: new_window}.

## Data about me
{: #data-about-me}

{{site.data.keyword.cloudant_short_notm}} records some data about its users, and is a Data Controller for said 
Personal Information (PI) data. The data that {{site.data.keyword.cloudant_short_notm}} records depends on the type of account you have.

If you have an {{site.data.keyword.cloudant_short_notm}} Dedicated Cluster/{{site.data.keyword.cloudant_short_notm}} 
Enterprise cluster, we record data 
about you and are considered a Data Controller for your data within the context of GDPR. 
If you have an {{site.data.keyword.cloudant_short_notm}} Dedicated Cluster/{{site.data.keyword.cloudant_short_notm}} 
Enterprise cluster, we have your:

 * Name
 * Email

The data that {{site.data.keyword.cloudant_short_notm}} holds can be viewed and updated via the {{site.data.keyword.cloudant_short_notm}} Dashboard.

If you have an account provisioned by {{site.data.keyword.cloud_notm}} (including a dedicated instance), 
{{site.data.keyword.cloudant_short_notm}} _does not_ collect the personal data previously mentioned. This data is held by {{site.data.keyword.cloud_notm}}.

{{site.data.keyword.cloudant_short_notm}} processes limited customer PI in the course of running the service and optimising 
the user experience of it. {{site.data.keyword.cloudant_short_notm}} uses email for contacting customers as appropriate. Monitoring 
customer interactions with the {{site.data.keyword.cloudant_short_notm}} Dashboard is the other way {{site.data.keyword.cloudant_short_notm}} processes PI.

### Restriction of processing
{: #restriction-of-processing}

{{site.data.keyword.cloudant_short_notm}} sends dashboard interaction data to Segment. It is possible to ask {{site.data.keyword.cloudant_short_notm}} to restrict processing of customer PI in this way via a [{{site.data.keyword.cloudant_short_notm}} support request ![External link icon](../images/launch-glyph.svg "External link icon")](mailto:support@cloudant.com){: new_window}. Upon 
receipt of such a request, {{site.data.keyword.cloudant_short_notm}} deletes information associated 
with the customer as sent to Segment, and prevents further data from being sent. {{site.data.keyword.cloudant_short_notm}} needs to retain the 
ability to contact dedicated customers via email and provides an interface for customers to keep this 
information up to date either directly, or via customer configuration of their contact details 
via their {{site.data.keyword.cloud_notm}} account details.

## Is our {{site.data.keyword.cloudant_short_notm}} database encrypted?
{: #is-our-ibm-cloudant-database-encrypted-}

All clusters have an encrypted file system (encryption at rest) using Linux Unified Key Setup (LUKS). Data in the database is 
visible to our operations and support teams (see below).

For sensitive data, that you determine must remain invisible to {{site.data.keyword.cloudant_short_notm}}, 
you must encrypt or otherwise protect (pseudonymise) your data before sending it to us. You must avoid 
using PI as a document `_id` in your URLs, for example, `https://$ACCOUNT.cloudant.com/$DATABASE/$DOCUMENT_ID`, 
as these are always visible and written to the access logs.

## Data locations
{: #data-locations}

Locations where {{site.data.keyword.cloudant_short_notm}} processes personal data will be 
made available, and kept up to date, via the DSA.

For more information about data locations, see the 
[DSA under 7. {{site.data.keyword.IBM_notm}} Hosting and Processing Locations ![External link icon](../images/launch-glyph.svg "External link icon")](https://www.ibm.com/software/reports/compatibility/clarity-reports/report/html/softwareReqsForProduct?deliverableId=2EBB5860B34311E7A9EB066095601ABB){: new_window}.

## Service security
{: #service-security}

### Using {{site.data.keyword.cloudant_short_notm}} securely
{: #using-ibm-cloudant-securely}

As a user of {{site.data.keyword.cloudant_short_notm}}, you should:

 * Use the default CORS configuration to prevent unexpected access.
 * Use API keys liberally, such that components can have 'least privileged access,' coupled with the audit log. This practice allows you to understand who accessed which data.
 * Encrypt or otherwise protect (pseudonymise) sensitive data that you determine must remain invisible to {{site.data.keyword.cloudant_short_notm}}.

### Physical and environmental security measures
{: #physical-and-environmental-security-measures}

Physical security of our data centers is handled by our infrastructure providers: {{site.data.keyword.cloud}}, 
AWS, and 21Vianet. All hold externally audited certifications for their physical security. {{site.data.keyword.cloudant_short_notm}} 
will not be providing further details of the physical security controls in place at our data 
centers.

Physical security of the office locations used by our personnel is handled by {{site.data.keyword.IBM_notm}} Corporate. 
Certification details and attestation reports (i.e., ISO and SOC2) can be provided to the 
customer upon request.

### Technical and Organizational Measures
{: #technical-and-organizational-measures}

Technical and Organisational Measures (TOMs) are employed by {{site.data.keyword.cloudant_short_notm}} 
to ensure the security of 
Personal Data. {{site.data.keyword.cloudant_short_notm}} holds externally audited certifications for the controls {{site.data.keyword.cloudant_short_notm}} employs. 
Certification details and attestation reports (i.e., ISO and SOC2) can be provided to the 
customer upon request.

### Service access to data
{: #service-access-to-data}

{{site.data.keyword.cloudant_short_notm}} operations and support staff have access to customer data 
and can access it during 
routine operations. This access is only done as required, in order to operate and support the service. 
Access is also limited to a *need to know* basis and is logged, monitored, and audited.

## Deletion of data
{: #deletion-of-data}

### Deleting a document
{: #deleting-a-document}

When a document is deleted, the database creates a 'tombstone.' What the tombstone contains depends 
on how you delete it:

 - If you make a `DELETE` call, the tombstone includes the `_id`, `_rev`, and `_deleted` fields.
 - If you delete by updating the document with a `_deleted: true` field and `PUT`ing or `POST`ing it, 
the tombstone includes what you set in the document body. This practice can be useful in some 
circumstances, for example, when recording why a document was deleted in its tombstone.

For more information on deleting tombstones, see [Simple removal of 'tombstone' documents](/docs/services/Cloudant?topic=cloudant-documents#tombstone-documents){: new_window}.

### When is a deleted document removed?
{: #when-is-a-deleted-document-removed-}

Compaction runs automatically and periodically removes old revisions (deleted or otherwise) 
from the database, by writing out only 'leaf' revisions to a new file. {{site.data.keyword.cloudant_short_notm}} keeps a history of 
`_id` and `_rev` to enable replication, but not old document bodies.

{{site.data.keyword.cloudant_short_notm}} does not expose the CouchDB compaction API.
{: tip}

{{site.data.keyword.cloudant_short_notm}} does not guarantee that a database will be compacted in a specific time. 
Compaction is done as a background process across 
the storage tier, and databases are always being compacted; there is just no guarantee it is the 
data you have just deleted/changed.

{{site.data.keyword.cloudant_short_notm}} is accepting *Right to be forgotten* requests via 
the [{{site.data.keyword.IBM_notm}} Data Privacy Office (DPO) ![External link icon](../images/launch-glyph.svg "External link icon")](http://w3-03.ibm.com/ibm/privacy/index.html){: new_window}. 
When a *Right to be forgotten* request is made from the {{site.data.keyword.IBM_notm}} DPO, {{site.data.keyword.cloudant_short_notm}} verifies the request, 
explicitly triggers database compaction, and verifies that compaction has occurred.
At the end of this process, the only version of the document is its tombstone 
(`_id`, `_rev`, `_deleted`, and any fields your application includes there).

### Removal of tombstones
{: #removal-of-tombstones}

{{site.data.keyword.cloudant_short_notm}} can completely remove all references and data for a 
document when required. This task is 
an operator-managed process called purging. Before requesting documents be purged, it is 
important to understand that purged documents *cannot be recovered* by 
{{site.data.keyword.cloudant_short_notm}} once the 
process is complete.

The CouchDB purge API is not supported by {{site.data.keyword.cloudant_short_notm}}.
{: tip}

In the context of GDPR, purging is only required if PI is used in a document ID. It is a bad 
idea for an `_id` to store PI for lots of reasons, but there are a handful of semi-valid use 
cases (for example, a unique email). If possible, encrypt or pseudonymise data so it is opaque 
to {{site.data.keyword.cloudant_short_notm}}.

If a document needs removal via a *Right to be forgotten* request:

1. File a request with the [{{site.data.keyword.IBM_notm}} DPO ![External link icon](../images/launch-glyph.svg "External link icon")](http://w3-03.ibm.com/ibm/privacy/index.html){: new_window} to request purging of specific document `_id` values along with the reason.
1. On receipt of a formal request by the {{site.data.keyword.IBM_notm}} DPO, {{site.data.keyword.cloudant_short_notm}} operations
verifies the request to confirm the `id` contains PI. {{site.data.keyword.cloudant_short_notm}} does not purge data that does not have PI in the `_id`. 
1. {{site.data.keyword.cloudant_short_notm}} triggers the purging action to permanently remove the requested data.

This process is only to be used for emergency deletion requests (for example, *right to be 
forgotten*) and must not be relied upon long-term. If your application is intentionally 
using PI in document IDs, 
then it must be changed to either pseudonymise that PI, or not use PI in document IDs. You cannot 
rely on regular purging by the {{site.data.keyword.cloudant_short_notm}} operations team to avoid this. 
{{site.data.keyword.cloudant_short_notm}} therefore rejects the following purge requests:

1. The request is for regular purging, for example, *every 30 days*.
1. The request is for over 100 documents.

Even with purge, PI in the `_id` field leaks into places you do not want it, such as 
{{site.data.keyword.cloudant_short_notm}} logs, so it should be avoided. 
{{site.data.keyword.cloudant_short_notm}} has a business reason to retain those logs and 
will not remove log lines containing document `_id` values.

### What about deleting a database?
{: #what-about-deleting-a-database-}

Deleting a database puts it into a trash can for up to 48h, after which it is removed from the 
file system. The {{site.data.keyword.cloudant_short_notm}} team *does not* make back ups of your databases; this task is the 
*responsibility of the customer*. You must ensure all copies of your 
database are removed from your system. For more information, see 
[{{site.data.keyword.cloudant_short_notm}} backup and recovery](/docs/services/Cloudant?topic=cloudant-ibm-cloudant-backup-and-recovery#ibm-cloudant-backup-and-recovery){: new_window}. 

If you need additional help, contact 
[{{site.data.keyword.cloudant_short_notm}} support ![External link icon](../images/launch-glyph.svg "External link icon")](mailto:support@cloudant.com).

