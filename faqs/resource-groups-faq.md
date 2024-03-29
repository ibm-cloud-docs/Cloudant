---

copyright:
  years: 2015, 2022
lastupdated: "2022-08-22"

keywords: migrate to a resource group, downtime, migrate existing instance, organization and space, standard plan, dedicated hardware instance, how to migrate, cloud foundry spaces

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# Resource Groups FAQ
{: #faq-ibm-cloud-resource-groups}
{: faq}
{: support}

You can migrate {{site.data.keyword.cloudantfull}} resource instances into resource groups. 
{: shortdesc}

Since 16 July 2018, new {{site.data.keyword.cloudant_short_notm}} resource instances are provisioned into resource groups, rather than Cloud Foundry spaces. 
{: note}

## How do I migrate an existing {{site.data.keyword.cloudant_short_notm}} instance to a resource group?
{: #faq-migrate-an-existing-instance-to-a-resource-group}
{: faq}

You can migrate {{site.data.keyword.cloudant_short_notm}} instances on the following plans:

- Lite
- Standard
- Dedicated Hardware

To migrate an {{site.data.keyword.cloudant_short_notm}} instance from a Cloud Foundry space to a resource group, see [Migrating Cloud Foundry service instances and apps to a resource group](/docs/account?topic=account-migrate){: external}.

## How much downtime occurs when you migrate an instance to a resource group?
{: #faq-downtime-occurs-when-you-migrate-an-instance-to-a-resource-group}
{: faq}

The migration process doesn't cause any downtime. 

## Why do some instances have an organization and space and others don't?
{: #faq-instances-have-an-organization-and-space-and-others-do-not}
{: faq}

Since 16 July 2018, new instances are provisioned into resource groups
rather than Cloud Foundry spaces. Resource instances created before this date
have an associated Cloud Foundry organization and space. Instances
created after this date are associated with a resource group instead.

## Why can't I create new Standard plan instances on my Dedicated Hardware instances?
{: #faq-create-new-standard-plan-instances-dedicated-hardware-instances}
{: faq}

New Standard plan instances are provisioned into resource groups. In order to
create these instances onto a Dedicated Hardware instance, the Dedicated
Hardware instance must first be migrated into a resource group.

For more information about how to do this migration, see [Migrating Cloud Foundry service instances and apps to a resource group](/docs/account?topic=account-migrate){: external}.

Once the Dedicated Hardware instance is migrated to a resource group, it
appears in the Location drop-down menu when you create Standard plans.

## How can I migrate my Dedicated Hardware instances and the Standard plan instances that are hosted on them?
{: #faq-migrate-dedicated-hardware-instances-and-the-standard-plan-instances-hosted}
{: faq}

In theory, instances can be migrated to resource groups in any order. The following order for Dedicated Hardware instances and
the Standard plan instances that are hosted on them is recommended:

1. Migrate Dedicated Hardware instances to a resource group. This migration allows new Standard plan instances to be created on the Dedicated Hardware.
2. Migrate Standard instances.

Lite plan instances and Standard plan instances that are not hosted on Dedicated Hardware
can be migrated at any time.
{: tip}
