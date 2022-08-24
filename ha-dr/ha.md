---

copyright:
  years: 2021, 2022
lastupdated: "2022-08-22"

keywords: IBM Cloudant, HA for IBM Cloudant, high availability for IBM Cloudant

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# Understanding high availability for {{site.data.keyword.cloudant_short_notm}}
{: #ha}

High availability (HA) is a core discipline in an IT infrastructure to keep your apps up and running, even after a partial or full site failure. The main purpose of high availability is to eliminate potential points of failures in an IT infrastructure. 
{: shortdesc}

To provide HA within a data center, all data is stored in triplicate across three separate physical servers in a cluster. You can provision accounts in multiple data centers, then use continuous data replication to provide HA across data centers. {{site.data.keyword.cloudantfull}} data isn't automatically backed up, but supported tools are provided to handle backups. Review the [Disaster recovery and backup guide](/docs/Cloudant?topic=Cloudant-disaster-recovery-and-backup) to explore all HA and backup considerations to meet your application requirements.

## Responsibilities
{: #ha-responsibilities}

To find out more about responsibility ownership for using {{site.data.keyword.cloud}} products between {{site.data.keyword.IBM_notm}} and the customer, see [Shared responsibilities for {{site.data.keyword.cloud_notm}} products](/docs/overview?topic=overview-shared-responsibilities){: external}.

For more information about responsibilities when you use {{site.data.keyword.cloudant_short_notm}}, see [Shared responsibilities for {{site.data.keyword.cloudant_short_notm}}](/docs/Cloudant?topic=Cloudant-cloudant-responsibilities).

## What level of availability do I need?
{: #ha-level}

You can achieve high availability on different levels in your IT infrastructure and within different components of your cluster. The level of availability that is right for you depends on several factors, such as your business requirements, the service level agreements (SLAs) that you have with your customers, and the resources that you want to expend.

## What level of availability does {{site.data.keyword.cloud_notm}} offer?
{: #ha-service}

The level of availability that you set up for your cluster impacts your coverage under the {{site.data.keyword.cloud_notm}} high availability service level agreement terms. 

Service level objectives (SLOs) describe the design points that the {{site.data.keyword.cloud_notm}} services are engineered to meet. {{site.data.keyword.cloudant_short_notm}} is designed to achieve the following availability target.

| Availability target | Target Value   |
|---|---|
|  Availability % |  99.99% |
{: caption="Table 1. SLA for {{site.data.keyword.cloudant_short_notm}}" caption-side="top"}

Refer to [Cloud Services terms](https://www-03.ibm.com/software/sla/sladb.nsf/sla/bm?OpenDocument){: external} for commitments and credits that are issued for failure to meet any committed SLAs. For more information, see the [{{site.data.keyword.cloudant_short_notm}} Service descriptions](https://www-03.ibm.com/software/sla/sladb.nsf/sla/bm-6627-07){: external}.


## Locations
{: #ha-locations}

For more information about service availability within regions and data centers, see [Service and infrastructure availability by location](/docs/overview?topic=overview-services_region){: external}.
