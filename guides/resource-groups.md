---

copyright:
  years: 2015, 2019
lastupdated: "2019-02-26"

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

# How does {{site.data.keyword.cloudant_short_notm}} work with {{site.data.keyword.cloud_notm}} Resource Groups?
{: #how-does-ibm-cloudant-work-with-ibm-cloud-resource-groups-}

Since July 16, 2018, new {{site.data.keyword.cloudantfull}} resource instances have been provisioned into
resource groups, rather than Cloud Foundry spaces. This document covers common
questions {{site.data.keyword.cloudant_short_notm}} support has received about this transition.

## How do I migrate an existing instance to a resource group?
{: #how-do-i-migrate-an-existing-instance-to-a-resource-group-}

To migrate an {{site.data.keyword.cloudant_short_notm}} instance from a Cloud Foundry space to a resource group, see [Migrating Cloud Foundry service instances and apps to a resource group](https://console.bluemix.net/docs/resources/instance_migration.html#migrate){: new_window}.

You can migrate {{site.data.keyword.cloudant_short_notm}} instances on the following plans:

- Lite
- Standard
- Dedicated Hardware

## How much downtime occurs when you migrate an instance to a resource group?
{: #how-much-downtime-occurs-when-you-migrate-an-instance-to-a-resource-group-}

There is no downtime during the migration process.

## Why do some instances have an organisation and space and others do not?
{: #why-do-some-instances-have-an-organisation-and-space-and-others-do-not-}

Since July 16, 2018, new instances have been provisioned into resource groups
rather than Cloud Foundry spaces. Resource instances provisioned before this date
have an associated Cloud Foundry organisation and space. Instances
provisioned after this date will be associated with a resource group instead.

## Why can't I create new Standard plan instances on my Dedicated Hardware instances?
{: #why-can-t-i-create-new-standard-plan-instances-on-my-dedicated-hardware-instances-}

New Standard plan instances are provisioned into resource groups. In order to
provision these instances onto a Dedicated Hardware instance, the Dedicated
Hardware instance must first be migrated into a resource group.

For more information about how to do this, see [Migrating Cloud Foundry service instances and apps to a resource group](https://console.bluemix.net/docs/resources/instance_migration.html#migrate){: new_window}.

Once the Dedicated Hardware instance has been migrated to a resource group, it
appears in the Location drop-down menu when provisioning Standard plans.

## How should I migrate my Dedicated Hardware instances and the Standard plan instances hosted on them?
{: #how-should-i-migrate-my-dedicated-hardware-instances-and-the-standard-plan-instances-hosted-on-them-}

In theory, instances can be migrated to resource groups in any order. In
practice, we recommend the following order for Dedicated Hardware instances and
the Standard plan instances hosted on them:

1. Migrate Dedicated Hardware instances to a resource group. This allows new Standard plan instances to be created on the Dedicated Hardware.
2. Migrate Standard instances.

Lite plan instances and Standard plan instances not hosted on Dedicated Hardware
can be migrated at any time.
{: tip}
