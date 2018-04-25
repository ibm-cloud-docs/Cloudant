---

copyright:
  years: 2018
lastupdated: "2018-04-25"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-04-28 -->

# General Data Protection Regulation (GDPR)

The GDPR seeks to create a harmonized data protection law framework across the EU and aims 
to give citizens back the control of their personal data, whilst imposing strict rules on 
those hosting and ‘processing’ this data, anywhere in the world. The Regulation also introduces 
rules relating to the free movement of personal data within and outside the EU. 

With the [General Data Protection Regulation ![External link icon](../images/launch-glyph.svg "External link icon")](https://www.eugdpr.org/){:new_window},
{{site.data.keyword.cloudant_short_notm}} customers can rely on 
the {{site.data.keyword.cloudant_short_notm}} team's understanding and
compliance with emerging data privacy standards and legislation and 
also in {{site.data.keyword.IBM_notm}}'s wider ability to provide a 
comprehensive suite of solutions
to assist businesses of all sizes with their own internal data governance requirements.

## How do I audit access to {{site.data.keyword.cloudant_short_notm}}?

You can find information about auditing in [Audit logging](../offerings/audit.html#audit-logging){:new_window}. 

## Supported classifications of Personal Data

The following categories of Personal Data are supported by {{site.data.keyword.cloudant_short_notm}} 
for GDPR:

**Personal Data**, for example:
 * Identity/civil status
 * Personal life
 * Professional life
 * Economic and financial information
 * Location data
 * Connectivity/device data

**Sensitive Personal Data**, restricted to:
  * Health data, extra conditions apply to be covered in a Service Description

If you are storing health care data, you *must* complete the following tasks:
 - Notify {{site.data.keyword.cloudant_short_notm}} before writing any data.
 - Request a HIPAA-compliant dedicated cluster.

For more information about supported classifications of Personal Data, see the 
[{{site.data.keyword.cloudantfull}} detailed system requirements under 2. Personal Data ![External link icon](../images/launch-glyph.svg "External link icon")](https://www.ibm.com/software/reports/compatibility/clarity-reports/report/html/softwareReqsForProduct?deliverableId=2EBB5860B34311E7A9EB066095601ABB){:new_window}.

## Data about me

{{site.data.keyword.cloudant_short_notm}} records some data about its users, and is a Data Controller for said 
Personal Information (PI) data. The data we record depends on the type of account you have.

If you have a {{site.data.keyword.cloudant_short_notm}} Dedicated Cluster/{{site.data.keyword.cloudant_short_notm}} 
Enterprise cluster, we record data 
about you and are considered a Data Controller for your data within the context of GDPR. 
If you have a {{site.data.keyword.cloudant_short_notm}} Dedicated Cluster/{{site.data.keyword.cloudant_short_notm}} 
Enterprise cluster, we have your:

 * Name
 * Email

The data we hold can be viewed and updated via the {{site.data.keyword.cloudant_short_notm}} dashboard.

If you have an account provisioned via {{site.data.keyword.cloud_notm}} (including a dedicated instance), 
{{site.data.keyword.cloudant_short_notm}} _does not_ collect the above personal data. This data is held by {{site.data.keyword.cloud_notm}}.

{{site.data.keyword.cloudant_short_notm}} processes limited client PI in the course of running the service and optimising 
the user experience of it. We use email for contacting clients as appropriate. Monitoring 
client interactions with the {{site.data.keyword.cloudant_short_notm}} dashboard is the other way we process PI.

### Restriction of processing

We send dashboard interaction data to Segment. It is possible to ask {{site.data.keyword.cloudant_short_notm}} to restrict 
processing of client PI in this way via a [{{site.data.keyword.cloudant_short_notm}} support request](mailto:support@cloudant.com). Upon 
receipt of such a request, {{site.data.keyword.cloudant_short_notm}} deletes information associated 
with the client as sent to Segment, and prevents further data from being sent. We need to retain the 
ability to contact clients via email and provide an interface for clients to keep this 
information up to date either directly, or via client configuration of their contact details 
via their {{site.data.keyword.cloud_notm}} account details.

## Is our {{site.data.keyword.cloudant_short_notm}} database encrypted?

For sensitive data, that you determine must remain invisible to 
{{site.data.keyword.cloudant_short_notm}} operations, 
you must encrypt or otherwise protect (pseudonymise) your data before sending it to us. 
All clusters have an encrypted file system (encryption at rest) using LUKS. Data in the database 
is visible to our operations and support teams (see below). For sensitive data, you must 
remain invisible to {{site.data.keyword.cloudant_short_notm}}, and you must encrypt or otherwise protect (pseudonymise) your 
data before sending it to us. You must avoid using PI for a document `_id`, as these are 
always visible and written to the access logs.

## Data locations

Locations where {{site.data.keyword.cloudant_short_notm}} processes personal data will be 
made available, and kept up to date, via the Cumulus/Cloud Transparency tool.

For more information about data locations, see the 
[{{site.data.keyword.cloudantfull}} detailed system requirements under 7. {{site.data.keyword.IBM_notm}} Hosting and Processing Locations ![External link icon](../images/launch-glyph.svg "External link icon")](https://www.ibm.com/software/reports/compatibility/clarity-reports/report/html/softwareReqsForProduct?deliverableId=2EBB5860B34311E7A9EB066095601ABB){:new_window}.


## Service security

### Physical And Environmental Security Measures

Physical security of our data centers is handled by our infrastructure providers: SoftLayer, 
AWS, and 21Vianet. All hold externally audited certifications for their physical security. We 
will not be providing further details of the physical security controls in place at our data 
centers.

Physical security of the office locations used by our personnel is handled by {{site.data.keyword.IBM_notm}} Corporate. 
Certification details and attestation reports (i.e., ISO and SOC2) can be provided to the 
customer upon request.

### Technical and Organisational Measures

Technical and Organisational Measures (TOMs) are employed by {{site.data.keyword.cloudant_short_notm}} 
to ensure the security of 
Personal Data. We hold externally audited certifications for the controls we employ. 
Certification details and attestation reports (i.e., ISO and SOC2) can be provided to the 
customer upon request.

### Using {{site.data.keyword.cloudant_short_notm}} securely

As a user of {{site.data.keyword.cloudant_short_notm}}, you should:

 * Use the default CORS configuration to prevent unexpected access.
 * Use API keys liberally, such that components can have 'least privileged access,' coupled with the audit log. This practice allows you to understand who accessed which data.
 * Encrypt or otherwise protect (pseudonymise) any sensitive data before sending it to us.

### Service access to data

{{site.data.keyword.cloudant_short_notm}} operations and support staff have access to client data 
and can access it during 
routine operations. This access is only done as required, in order to operate and support the service. 
Access is also limited to a *need to know* basis and is logged, monitored, and audited.

## Deletion of data

### Deleting a document

When a document is deleted, the database creates a 'tombstone.' What the tombstone contains depends 
on how you delete it:

 - If you make a `DELETE` call, the tombstone includes the `_id`, `_rev`, and `_deleted` fields.
 - If you delete by updating the document with a `_deleted: true` field and `PUT`ing or `POST`ing it, 
the tombstone includes what you set in the document body. This practice can be useful in some 
circumstances, for example, when recording why a document was deleted in its tombstone.

### When is a deleted document removed?

Compaction runs automatically and periodically removes old revisions (deleted or otherwise) 
from the database, by writing out only 'leaf' revisions to a new file. We keep a history of 
`_id` and `_rev` to enable replication, but not old document bodies.

We do not guarantee that a database will be compacted in a specific time. Clusters can host 
10000+ accounts, each containing many databases. Compaction is done as a background process across 
the whole cluster, and databases are always being compacted; there's just no guarantee it's the 
data you've just deleted/changed.

{{site.data.keyword.cloudant_short_notm}} is accepting *Right to be forgotten* requests via 
the [IBM Data Privacy Office ![External link icon](../images/launch-glyph.svg "External link icon")](http://w3-03.ibm.com/ibm/privacy/index.html){:new_window}. 
When a *Right to be forgotten* request is made from the IBM DPO, we verify the request, 
explicitly trigger database compaction, and verify that compaction has occurred.
At the end of this process, the only version of the document is its tombstone 
(`_id`, `_rev`, `_deleted`, and any fields your application includes there).

### Removal of tombstones

{{site.data.keyword.cloudant_short_notm}} can completely remove all references and data for a 
document when required. This task is 
an operator-managed process called purging. Before requesting documents be purged, it's 
important to understand that purged documents *cannot be recovered* by 
{{site.data.keyword.cloudant_short_notm}} once the 
process is complete.

> **Note**: The CouchDB purge API is not supported by {{site.data.keyword.cloudant_short_notm}}.

In the context of GDPR, purging is only required if PI is used in a document ID. It's a bad 
idea for an `_id` to store PI for lots of reasons, but there are a handful of semi-valid use 
cases (for example, a unique email). If possible, encrypt or pseudonymise data so it is opaque 
to {{site.data.keyword.cloudant_short_notm}}.

If a document needs removal via a *Right to be forgotten* request:

1. File a request with the [IBM Data Privacy Office (DPO) ![External link icon](../images/launch-glyph.svg "External link icon")](http://w3-03.ibm.com/ibm/privacy/index.html){:new_window} to request purging of specific document `_id` values along with the reason.
1. On receipt of a formal request by the IBM DPO, {{site.data.keyword.cloudant_short_notm}}  
triggers a [security incident ![External link icon](../images/launch-glyph.svg "External link icon")](https://pages.github.ibm.com/cloudant/policy-documents/security-incident.html){:new_window} 
to verify the request. We won't purge data that doesn't have PI in the `_id`.
1. {{site.data.keyword.cloudant_short_notm}} triggers the purging action to permanently remove the requested data.

On receipt of a formal request by the IBM DPO, {{site.data.keyword.cloudant_short_notm}}
operations verifies the request; we won't purge data that doesn't have PI in the `_id`.
This process is only to be used for emergency deletion requests (for example, *right to be 
forgotten*) and must not be relied upon long-term. If your application is intentionally 
using PI in document IDs, 
then it must be changed to either pseudonymise that PI, or not use PI in document IDs. You cannot 
rely on regular purging by the {{site.data.keyword.cloudant_short_notm}} operations team to avoid this. 
{{site.data.keyword.cloudant_short_notm}} therefore rejects the following purge requests:

1. The request is for regular purging, for example, *every 30 days*.
1. The request is for over 100 documents.

Even with purge, PI in the `_id` field leaks into places you don't want it, such as 
{{site.data.keyword.cloudant_short_notm}} logs, so it should be avoided. We have a business reason to retain those logs and 
will not remove log lines containing document `_id` values.

### What about deleting a database?

Deleting a database puts it into a trash can for up to 48h, after which it is removed from the 
file system. The {{site.data.keyword.cloudant_short_notm}} team *does not* make back ups of your databases; this task is the 
*responsibility of the customer*. You must ensure all copies of your 
database are removed from your system. For more information, see 
[Cloudant NoSQL DB backup and recovery](../guides/backup-cookbook.html#cloudant-nosql-db-backup-and-recovery){:new_window}. 

If you need additional help, contact 
[{{site.data.keyword.cloudant_short_notm}} support ![External link icon](../images/launch-glyph.svg "External link icon")](mailto:support@cloudant.com).

