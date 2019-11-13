---

copyright:
  years: 2015, 2019
lastupdated: "2019-11-14"

keywords: migrate to a resource group, downtime, migrate existing instance, organization and space, standard plan, dedicated hardware instance, how to migrate

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
{:external: target="_blank" .external}

<!-- Acrolinx: 2017-05-10 -->

# How does {{site.data.keyword.cloudant_short_notm}} work with {{site.data.keyword.cloud_notm}} Resource Groups?
{: #how-does-ibm-cloudant-work-with-ibm-cloud-resource-groups-}

Since 16 July 2018, new {{site.data.keyword.cloudantfull}} resource instances are provisioned into
resource groups, rather than Cloud Foundry spaces. Common questions received by {{site.data.keyword.cloudant_short_notm}} support regarding this transition are described here.
{: shortdesc}

## How do I migrate an existing instance to a resource group?
{: #how-do-i-migrate-an-existing-instance-to-a-resource-group-}

To migrate an {{site.data.keyword.cloudant_short_notm}} instance from a Cloud Foundry space to a resource group, see [Migrating Cloud Foundry service instances and apps to a resource group](https://cloud.ibm.com/docs/resources/instance_migration.html#migrate){: new_window}.

You can migrate {{site.data.keyword.cloudant_short_notm}} instances on the following plans:

- Lite
- Standard
- Dedicated Hardware

## How much downtime occurs when you migrate an instance to a resource group?
{: #how-much-downtime-occurs-when-you-migrate-an-instance-to-a-resource-group-}

The migration process doesn't cause any downtime. 

## Why do some instances have an organization and space and others don't?
{: #why-do-some-instances-have-an-organization-and-space-and-others-do-not-}

Since 16 July 2018, new instances are provisioned into resource groups
rather than Cloud Foundry spaces. Resource instances provisioned before this date
have an associated Cloud Foundry organization and space. Instances
provisioned after this date are associated with a resource group instead.

## Why can't I create new Standard plan instances on my Dedicated Hardware instances?
{: #why-can-t-i-create-new-standard-plan-instances-on-my-dedicated-hardware-instances-}

New Standard plan instances are provisioned into resource groups. In order to
provision these instances onto a Dedicated Hardware instance, the Dedicated
Hardware instance must first be migrated into a resource group.

For more information about how to do this migration, see [Migrating Cloud Foundry service instances and apps to a resource group](https://cloud.ibm.com/docs/resources/instance_migration.html#migrate){: new_window}{: external}.

Once the Dedicated Hardware instance is migrated to a resource group, it
displays in the Location drop-down menu when you provision Standard plans.

## How can I migrate my Dedicated Hardware instances and the Standard plan instances hosted on them?
{: #how-can-i-migrate-my-dedicated-hardware-instances-and-the-standard-plan-instances-hosted-on-them-}

In theory, instances can be migrated to resource groups in any order. We recommend the following order for Dedicated Hardware instances and
the Standard plan instances that are hosted on them:

1. Migrate Dedicated Hardware instances to a resource group. This migration allows new Standard plan instances to be created on the Dedicated Hardware.
2. Migrate Standard instances.

Lite plan instances and Standard plan instances not hosted on Dedicated Hardware
can be migrated at any time.
{: tip}
