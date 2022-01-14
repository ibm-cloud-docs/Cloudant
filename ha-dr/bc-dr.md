---

copyright:
  years: 2021, 2022
lastupdated: "2022-01-14"

keywords: HA for IBM Cloudant, DR for IBM Cloudant, high availability for IBM Cloudant, disaster recovery for IBM Cloudant, failover for IBM Cloudant, BC for IBM Cloudant, DR for IBM Cloudant, business continuity for IBM Cloudant, disaster recovery for IBM Cloudant

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
{:new_window: target="_blank"}
{:table: .aria-labeledby="caption"}
{:download: .download}

# Understanding business continuity and disaster recovery for {{site.data.keyword.cloudant_short_notm}}
{: #bc-dr}

Disaster recovery involves a set of policies, tools, and procedures for returning a system, an application, or an entire data center to full operation after a catastrophic interruption. It includes procedures for copying and storing an installed system's essential data in a secure location, and for recovering that data to restore normalcy of operation.
{: shortdesc}

## Responsibilities
{: #bc-dr-responsibilities}

For more information about your responsibilities when using {{site.data.keyword.cloudant_short_notm}}, see [Shared responsibilities for {{site.data.keyword.cloudant_short_notm}}](/docs/Cloudant?topic=Cloudant-cloudant-responsibilities).

### Disaster recovery strategy
{: #bc-dr-strategy}

{{site.data.keyword.cloud_notm}} has business continuity plans in place to provide for the recovery of services within hours if a disaster occurs. You are responsible for your data backup and associated recovery of your content.

{{site.data.keyword.cloudant_short_notm}} provides mechanisms to restore service functions. Business continuity plans are in place to achieve targeted recovery point objective (RPO) and recovery time objective (RTO) for the service. The following table outlines the targets for {{site.data.keyword.cloudant_short_notm}}. 

| Disaster recovery objective | Target Value   |
|---|---|
|  RPO | 24 hours  |
|  RTO | < 24 hours  |
{: caption="Table 1. RPO and RTO for {{site.data.keyword.cloudant_short_notm}}" caption-side="top"}

## Locations
{: #ha-locations-bc-dr}

For more information about service availability within regions and data centers, see [Service and infrastructure availability by location](/docs/overview?topic=overview-services_region){: external}.
