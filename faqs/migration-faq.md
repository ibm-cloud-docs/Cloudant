---

copyright:
  years: 2015, 2023
lastupdated: "2023-04-06"

keywords: free plan, lite plan, pricing plans, standard plan, enterprise plan, backup, support

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# Migration FAQ
{: #faq-migration}
{: faq}
{: support}

Migrate your plan to an {{site.data.keyword.cloudantfull}} Lite or Standard plan instance. 

## Which plans can I migrate? 
{: #which-plans-can-i-migrate}
{: faq}

You can migrate to a Lite or Standard plan from one of the following plans: 

- {{site.data.keyword.cloudant_short_notm}} Enterprise
- Apache CouchDB

For more information, see [Migrating an Enterprise plan to a Lite or Standard plan](/docs/Cloudant?topic=Cloudant-migrating-an-enterprise-plan-to-a-lite-or-standard-plan).

Or you can migrate from the Lite plan to a Standard plan, which is just upgrading from the Lite plan to the Standard plan. For more information, see [Migrating from a Lite plan to a Standard plan](/docs/Cloudant?topic=Cloudant-migrating-from-a-lite-plan-to-a-standard-plan).  

## Can I back up my data before I migrate?
{: #can-i-back-up-my-data-before-doing-anything-}
{: faq}

The {{site.data.keyword.cloudant_short_notm}} team advises that you use the [`couchbackup`](/docs/Cloudant?topic=Cloudant-ibm-cloudant-backup-and-recovery#ibm-cloudant-backup-and-recovery) utility to export data to disk. Or use [{{site.data.keyword.cloud_notm}} Object Storage](https://www.ibm.com/cloud/object-storage){: external}, which is an inexpensive, scalable solution for storing the exported files. 

## Can I keep my `username.cloudant.com` domain and redirect it to the new service on {{site.data.keyword.cloudant_short_notm}}?
{: #can-i-keep-my-username-cloudant-com-domain-and-redirect-it-to-the-new-service-on-ibm-cloudant-}
{: faq}

No, it's not possible to keep your domain. You must plan to update your applications to use the new account URL and credentials that are generated for the {{site.data.keyword.cloudant_short_notm}} instances. 

## Who do I contact if I have questions?
{: #who-do-i-contact-if-i-have-questions-}
{: faq}

Go to the [{{site.data.keyword.cloud_notm}} Support portal](https://www.ibm.com/cloud/support), or open a ticket from within the {{site.data.keyword.cloudant_short_notm}} Dashboard if you have any questions about migration. {{site.data.keyword.cloudant_short_notm}} support is happy to provide more details. 
