---

copyright:
  years: 2015, 2018
lastupdated: "2018-08-15"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:tip: .tip}

<!-- Acrolinx: 2018-08-15 -->

# How does {{site.data.keyword.cloudant_short_notm}} work with {{site.data.keyword.cloud_notm}} Resource Groups?

Since July 16, 2018, new {{site.data.keyword.cloudantfull}} resource instances have been provisioned into
resource groups, rather than CloudFoundry spaces. This document covers common
questions {{site.data.keyword.cloudant_short_notm}} support has received about this transition.

## Why do some instances have an organisation and space and others do not?

Since July 16, 2018, new instances have been provisioned into resource groups
rather than CloudFoundry spaces. Resource instances provisioned before this date
have an associated CloudFoundry organisation and space. Instances
provisioned after this date will be associated with a resource group instead.

## Why can't I create new Standard plan instances on my Dedicated Hardware instances?

New Standard plan instances are provisioned into resource groups. In order to
provision these instances onto a Dedicated Hardware instance, the Dedicated
Hardware instance must first be migrated into a resource group.

To do this, follow the [migrating a resource instance to a resource group](TDB) instructions.

Once the Dedicated Hardware instance has been migrated to a resource group, it
appears in the Location drop-down menu when provisioning Standard plans.

## How should I migrate my Dedicated Hardware instances and the Standard plan instances hosted on them?

In theory, instances can be migrated to resource groups in any order. In
practice, we recommend the following order for Dedicated Hardware instances and
the Standard plan instances hosted on them:

1. Migrate Dedicated Hardware instances to a resource group. This allows new Standard plan instances to be created on the Dedicated Hardware.
2. Migrate Standard instances.

Lite plan instances and Standard plan instances not hosted on Dedicated Hardware
can be migrated at any time.
{: tip}
