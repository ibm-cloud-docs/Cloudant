---

copyright:
  years: 2018, 2022
lastupdated: "2022-06-23"

keywords: audit access ibm cloudant, supported classifications of personal data, personal data, sensitive personal data, restrictions on processing, encrypt data, data locations, service security, delete data

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# General Data Protection Regulation (GDPR)
{: #general-data-protection-regulation-gdpr-}

The GDPR seeks to create a harmonized data protection law framework across the EU. It aims 
to give citizens back the control of their personal data, while it imposes strict rules on 
those who host and "process" this data, anywhere in the world. The Regulation also introduces 
rules that relate to the free movement of personal data within and outside the EU. 
{: shortdesc}

With the [General Data Protection Regulation](https://gdpr.eu/){: external},
{{site.data.keyword.cloudantfull}} customers can rely on
the {{site.data.keyword.cloudant_short_notm}} team's understanding and
compliance with emerging data privacy standards and legislation. Customers can
also rely on {{site.data.keyword.IBM_notm}}'s wider ability to provide a
comprehensive suite of solutions
to assist businesses of all sizes with their own internal data governance requirements.

## How do I audit access to {{site.data.keyword.cloudant_short_notm}}?
{: #how-do-i-audit-access-to-ibm-cloudant-}

You can find information about auditing in [Audit logging](/docs/Cloudant?topic=Cloudant-audit-logging#audit-logging){: external}.

## Supported classifications of Personal Data
{: #supported-classifications-of-personal-data}

The following categories of **Personal Data** are supported by {{site.data.keyword.cloudant_short_notm}}
for GDPR:

- Identity and civil status
- Personal life
- Professional life
- Location data
- Connectivity and device data

**Sensitive Personal Data** is restricted to the following category:

- Health data, extra conditions apply to be covered in the [{{site.data.keyword.cloudant_short_notm}} Dedicated Cluster Service Description](https://www-03.ibm.com/software/sla/sladb.nsf/pdf/6756-04/$file/i126-6756-04_05-2018_en_US.pdf){: external} and [{{site.data.keyword.cloud}} Additional Service Description](https://www-03.ibm.com/software/sla/sladb.nsf/sla/saas?OpenDocument){: external}.

If you're storing healthcare data, you *must* complete the following tasks:
- Notify {{site.data.keyword.cloudant_short_notm}} before you write any data.
- Request a HIPAA-compliant Dedicated Cluster.

For more information about supported classifications of Personal Data, see the
[Data Sheet Addendum (DSA) under 2. Personal Data](https://www.ibm.com/software/reports/compatibility/clarity-reports/report/html/softwareReqsForProduct?deliverableId=2EBB5860B34311E7A9EB066095601ABB){: external}.

## Data about me
{: #data-about-me}

{{site.data.keyword.cloudant_short_notm}} records some data about its users, and is a Data Controller for said
Personal Information (PI) data. The data that {{site.data.keyword.cloudant_short_notm}} records depends on the type of account you have.

If you have an {{site.data.keyword.cloudant_short_notm}} Dedicated Cluster or {{site.data.keyword.cloudant_short_notm}}
Enterprise Cluster, {{site.data.keyword.cloudant_short_notm}} records data
about you and are considered a Data Controller for your data within the context of GDPR.
If you have an {{site.data.keyword.cloudant_short_notm}} Dedicated Cluster or {{site.data.keyword.cloudant_short_notm}}
Enterprise Cluster, {{site.data.keyword.cloudant_short_notm}} stores the following information about you:

- Name
- Email

The data that {{site.data.keyword.cloudant_short_notm}} holds can be viewed and updated through the {{site.data.keyword.cloudant_short_notm}} Dashboard.

If you have an account that is provisioned by {{site.data.keyword.cloud_notm}} (including a dedicated instance),
{{site.data.keyword.cloudant_short_notm}} *does not* collect the personal data that was previously mentioned. This data is held by {{site.data.keyword.cloud_notm}}.

Do not use sensitive data for {{site.data.keyword.cloudant_short_notm}} instance names when you provision by using {{site.data.keyword.cloud_notm}}, such as: Personal Information (PI), Personal Identifying Information (PII), and Customer-specific Data.
{: important}

{{site.data.keyword.cloudant_short_notm}} processes limited customer PI in the course of running the service and optimizing
the user experience of it. {{site.data.keyword.cloudant_short_notm}} uses email for contacting customers. Monitoring
customer interactions with the {{site.data.keyword.cloudant_short_notm}} Dashboard is the other way {{site.data.keyword.cloudant_short_notm}} processes PI.

### Restriction of processing
{: #restriction-of-processing}

{{site.data.keyword.cloudant_short_notm}} sends dashboard interaction data to Segment. It's possible to ask {{site.data.keyword.cloudant_short_notm}} to restrict processing of customer PI in this way with an {{site.data.keyword.cloudant_short_notm}} support request through the [{{site.data.keyword.cloud_notm}} Support portal](https://www.ibm.com/cloud/support). Upon 
receipt of such a request, {{site.data.keyword.cloudant_short_notm}} deletes information that is associated 
with the customer as sent to Segment, and prevents further data from being sent. {{site.data.keyword.cloudant_short_notm}} needs to retain the 
ability to contact dedicated customers by email. {{site.data.keyword.cloudant_short_notm}} provides an interface for customers to keep this 
information up to date either directly, or by using customer configuration of their contact details 
with their {{site.data.keyword.cloud_notm}} account details.

## Is the {{site.data.keyword.cloudant_short_notm}} database encrypted?
{: #is-our-ibm-cloudant-database-encrypted-}

All clusters have an encrypted file system (encryption at rest) that uses Linux&trade; Unified Key Setup (LUKS). Data in the database is
visible to the operations and support teams (see the following paragraph).

For sensitive data, that you determine must remain invisible to {{site.data.keyword.cloudant_short_notm}},
you must encrypt or otherwise protect (pseudonymize) your data before you send it to us. Do not use PI as a document `_id` in your URLs, for example, `https://$ACCOUNT.cloudant.com/$DATABASE/$DOCUMENT_ID`,
since PI is always visible and written to the access logs.

## Data locations
{: #data-locations}

Locations where {{site.data.keyword.cloudant_short_notm}} processes personal data are made available, and kept up to date, through the DSA.

For more information about data locations, see the
[DSA under 7. {{site.data.keyword.IBM_notm}} Hosting and Processing Locations](https://www.ibm.com/software/reports/compatibility/clarity-reports/report/html/softwareReqsForProduct?deliverableId=2EBB5860B34311E7A9EB066095601ABB){: external}.

## Service security
{: #service-security}

### Using {{site.data.keyword.cloudant_short_notm}} securely
{: #using-ibm-cloudant-securely}

As a user of {{site.data.keyword.cloudant_short_notm}}, you must follow these guidelines:

- Use the default CORS configuration to prevent unexpected access.
- Use API keys liberally, since components can have `least privileged access`, which is coupled with the audit log. This practice helps you understand who accessed which data.
- Encrypt or otherwise protect (pseudonymize) sensitive data that you determine must remain invisible to {{site.data.keyword.cloudant_short_notm}}.

### Physical and environmental security measures
{: #physical-and-environmental-security-measures}

Physical security of our data centers is handled by the infrastructure providers: {{site.data.keyword.cloud}},
AWS, and 21Vianet. All hold externally audited certifications for their physical security. {{site.data.keyword.cloudant_short_notm}}
doesn't provide further details of the physical security controls in place at our data
centers.

Physical security of the office locations that are used by our personnel is handled by {{site.data.keyword.IBM_notm}} Corporate.
Certification details and attestation reports (that is, ISO and SOC2) can be provided to the
customer upon request.

### Technical and Organizational Measures
{: #technical-and-organizational-measures}

Technical and Organizational Measures (TOMs) are employed by {{site.data.keyword.cloudant_short_notm}}
to ensure the security of
Personal Data. {{site.data.keyword.cloudant_short_notm}} holds externally audited certifications for the controls {{site.data.keyword.cloudant_short_notm}} employs.
Certification details and attestation reports (that is, ISO and SOC2) can be provided to the
customer upon request.

### Service access to data
{: #service-access-to-data}

{{site.data.keyword.cloudant_short_notm}} operations and support staff has access to customer data
and can access it during
routine operations. This access is only done as required in order to operate and support the service.
Access is also limited to a *need to know* basis and is logged, monitored, and audited.

## Deletion of data
{: #deletion-of-data}

### Deleting a document
{: #deleting-a-document}

When a document is deleted, the database creates a "tombstone." What the tombstone includes depends 
on how you delete it:

- If you make a `DELETE` call, the tombstone includes the `_id`, `_rev`, and `_deleted` fields.
- If you delete by updating the document with a `_deleted: true` field and add a `PUT` or `POST` request to it, the tombstone includes what you set in the document body. This practice can be useful in some circumstances, for example, when recording why a document was deleted in its tombstone.

For more information, see [Simple removal of "tombstone" documents](/docs/Cloudant?topic=Cloudant-documents#tombstone-documents){: external}.

### When is a deleted document removed?
{: #when-is-a-deleted-document-removed-}

Compaction runs automatically and periodically removes old revisions (deleted or otherwise) 
from the database, by writing out only "leaf" revisions to a new file. {{site.data.keyword.cloudant_short_notm}} keeps a history of 
`_id` and `_rev` to enable replication, but not old document bodies.

{{site.data.keyword.cloudant_short_notm}} doesn't expose the CouchDB compaction API.
{: tip}

{{site.data.keyword.cloudant_short_notm}} doesn't guarantee that a database is compacted in a specific time.
Compaction is done as a background process across
the storage tier. Databases are always being compacted. It isn't guaranteed that the data compacted is the
data that you deleted or changed.

{{site.data.keyword.cloudant_short_notm}} is accepting the *Right to be forgotten* requests through
the [{{site.data.keyword.IBM_notm}} Data Privacy Office (DPO)](http://w3.ibm.com/ibm/privacy/index.html){: external}.
When a *Right to be forgotten* request is made from the {{site.data.keyword.IBM_notm}} DPO, {{site.data.keyword.cloudant_short_notm}} verifies the request,
explicitly triggers database compaction, and verifies that compaction occurred.
At the end of this process, the only version of the document is its tombstone
(`_id`, `_rev`, `_deleted`, and any fields your application includes there).

### Removal of tombstones
{: #removal-of-tombstones}

{{site.data.keyword.cloudant_short_notm}} can completely remove all references and data for a
document when required. This task is
an operator-managed process called purging. Before you request that documents be purged, it's
important to understand that purged documents *cannot be recovered* by
{{site.data.keyword.cloudant_short_notm}} once the
process is complete.

The CouchDB purge API is not supported by {{site.data.keyword.cloudant_short_notm}}.
{: tip}

In the context of GDPR, purging is only required if PI is used in a document ID. It's a bad
idea for an `_id` to store PI for lots of reasons, but a handful of semi-valid use
cases exist (for example, a unique email). If possible, encrypt or pseudonymize data so it's opaque
to {{site.data.keyword.cloudant_short_notm}}.

If a document needs removal through a *Right to be forgotten* request, follow these steps:

1. File a request with the [{{site.data.keyword.IBM_notm}} DPO](http://w3-03.ibm.com/ibm/privacy/index.html){: external} to request purging of specific document `_id` values along with the reason.
1. On receipt of a formal request by the {{site.data.keyword.IBM_notm}} DPO, {{site.data.keyword.cloudant_short_notm}} operations verifies the request to confirm the `id` contains PI. {{site.data.keyword.cloudant_short_notm}} doesn't purge data that doesn't have PI in the `_id`.
1. {{site.data.keyword.cloudant_short_notm}} triggers the purging action to permanently remove the requested data.

This process is only to be used for emergency deletion requests (for example, *Right to be forgotten*) and must not be relied upon long term. If your application is intentionally
using PI in document IDs,
then it must be changed to either pseudonymize that PI, or not use PI in document IDs. You cannot
rely on regular purging by the {{site.data.keyword.cloudant_short_notm}} operations team to avoid this situation.
Therefore, {{site.data.keyword.cloudant_short_notm}} rejects the following purge requests:

1. The request is for regular purging, for example, *every 30 days*.
1. The request is for over 100 documents.

Even with purge, PI in the `_id` field leaks into places you don't want it, such as
{{site.data.keyword.cloudant_short_notm}} logs, so it must be avoided.
{{site.data.keyword.cloudant_short_notm}} has a business reason to keep those logs and
doesn't remove log lines that include document `_id` values.

### What about deleting a database?
{: #what-about-deleting-a-database-}

Deleting a database adds it to the trash for up to 48 hours. After which time, the database is removed from the
file system. The {{site.data.keyword.cloudant_short_notm}} team *does not* make back ups of your databases; this task is the
*responsibility of the customer*. You must ensure that all copies of your
database are removed from your system. For more information, see
[{{site.data.keyword.cloudant_short_notm}} backup and recovery](/docs/Cloudant?topic=Cloudant-ibm-cloudant-backup-and-recovery#ibm-cloudant-backup-and-recovery){: external}.

If you need more help, go to the [{{site.data.keyword.cloud_notm}} Support portal](https://www.ibm.com/cloud/support).

