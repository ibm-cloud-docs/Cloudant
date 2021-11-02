---

copyright:
  years: 2020, 2021
lastupdated: "2021-11-02"

keywords: availability zones, single-zone region, multi-zone region, lite plan, standard plan

subcollection: Cloudant

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
{:support: data-reuse='support'}
{:faq: data-hd-content-type='faq'}

# Availability zones FAQ
{: #faq-availability-zones}
{: faq}
{: support}

You can create an {{site.data.keyword.cloudantfull}} Lite or Standard plan instance on {{site.data.keyword.cloud_notm}} in a multi-zone or single-zone region.
{: shortdesc}

The following tutorials demonstrate how to create an instance:

- Using the dashboard. For more information, see [Getting started with {{site.data.keyword.cloudant_short_notm}}](/docs/Cloudant?topic=Cloudant-getting-started-with-cloudant){: external}.
- Using the Cloud Foundry command tool. For more information, see [Creating an {{site.data.keyword.cloudant_short_notm}} instance on {{site.data.keyword.cloud_notm}} by using the {{site.data.keyword.cloud_notm}} CLI](/docs/services/Cloudant?topic=Cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud-by-using-the-ibm-cloud-cli#creating-an-ibm-cloudant-instance-on-ibm-cloud-by-using-the-ibm-cloud-cli){: external}.

If you want to create an {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware plan instance, follow the [Creating and leveraging an {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware plan instance on {{site.data.keyword.cloud_notm}}](/docs/services/Cloudant?topic=Cloudant-creating-and-leveraging-an-ibm-cloudant-dedicated-hardware-plan-instance-on-ibm-cloud#creating-and-leveraging-an-ibm-cloudant-dedicated-hardware-plan-instance-on-ibm-cloud){: external} tutorial.

## What is an availability zone?
{: #what-availability-zone}
{: faq}

When you create an instance, after you select the {{site.data.keyword.cloudant_short_notm}} tile, you must select a region. These locations are called availability zones. An availability zone is an {{site.data.keyword.cloud}} Public location that hosts your data. All Lite and Standard plans automatically deploy into a multi-zone region. Dedicated Hardware plan instances can be deployed in most [{{site.data.keyword.IBM_notm}} data center locations](https://www.ibm.com/cloud/data-centers/){: external}.


## What is the difference between a single-zone and a multi-zone region?
{: #multi-zone-region}
{: faq}

A multi-zone region includes three availability zones that can be used by an instance that is deployed to that region. The multi-zone regions available with {{site.data.keyword.cloudant_short_notm}} include the following regions:

- Dallas
- Frankfurt
- London
- Osaka
- Sydney
- Tokyo
- Washington DC

A single-zone region offers only one availability zone for that region. The single-zone regions available with {{site.data.keyword.cloudant_short_notm}} include the following regions:

- Seoul
- Chennai

For more information, see [Plans and provisioning](/docs/services/Cloudant?topic=Cloudant-ibm-cloud-public#locations-and-tenancy).
