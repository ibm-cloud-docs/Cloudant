---

copyright:
  years: 2015, 2025
lastupdated: "2025-09-03"

keywords: standard plan, lite plan, dedicated hardware plan, request class, provisioned throughput capacity, consumption, capacity, monitor usage, data usage, size limits, locations, tenancy, authentication methods, high availability, disaster recovery, backup, support

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# Plans and provisioning
{: #ibm-cloud-public}

{{site.data.keyword.cloudantfull}} offers a range of plans to suit your
application needs. Evaluate {{site.data.keyword.cloudant_short_notm}} using the
free tier, then transition to our scalable, high-throughput production plans.
{: shortdesc}

## Plans
{: #plans-and-provisioning}

The available plans for {{site.data.keyword.cloudantfull}} are:

- **Lite Plan** – Free. Ideal for evaluation. Limited capacity and storage.
- **Standard Plan** – Scalable and suitable for production. Billed based on provisioned capacity and storage.
- **Dedicated Hardware Plan** – Private bare-metal environments with predicable performance to host your Standard plan instances. The plan features enhanced workload isolation, BYOK encryption, private networking, network allowlisting, and optional support for a [HIPAA](https://www.ibm.com/cloud/compliance/hipaa){: external}-compliant configuration.

You can select which plan to use when you
[provision your {{site.data.keyword.cloudant_short_notm}} service instance](#provisioning-a-cloudant-nosql-db-instance-on-ibm-cloud). When you select a plan, its capacity displays and the Cost Estimator shows the monthly charge for the selected plan. 

Refer to the {{site.data.keyword.cloud_notm}} Cost Estimator in the dashboard for charges at different capacities and currencies, and the [Usage and charges](/docs/Cloudant?topic=Usage-and-charges){: external} information for examples to estimate costs.

### Plan comparison: Lite vs. Standard

| Feature                          | **Lite Plan**                                         | **Standard Plan**                                      |
|----------------------------------|-------------------------------------------------------|--------------------------------------------------------|
| **Cost**                         | Free                                                  | Pay-as-you-go or subscription                          |
| **Use-case**                     | Evaluation and testing                      | Development and production workloads                                   |
| **Throughput capacity**          | Fixed: 20 reads/sec, 10 writes/sec, 5 global queries/sec     | Starts at 100 reads/sec, 50 writes/sec, 5 global queries/sec; scalable in [provisioned throughput capacity units](/docs/Cloudant?topic=Usage-and-charges#provisioned-throughput-capacity-units)       |
| **Throughput scaling**                  | Not scalable                                          | Throughput scalable via UI or API                           |
| **Included storage**                | 1 GB                                                  | 20GB |
| **Extra storage**                | Unavailable                                                  | Charged per extra GB                   |
| **Instance limit**              | 1 Lite instance per IBM Cloud account                | Unlimited                                               |
| **Included features**            | All {{site.data.keyword.cloudant_short_notm}} features                                 | All {{site.data.keyword.cloudant_short_notm}} features                                  |
| **Billing frequency**            | Free                                                   | Hourly, prorated                                       |
| **Upgrade path**                 | Transparent upgrade to Standard plan to increase capacity/storage | Can scale up/down anytime                              |
{: caption="Summary of {{site.data.keyword.cloudantfull}} Lite and Standard plans" caption-side="top"}

Refer to [Usage and charges](/docs/Cloudant?topic=Usage-and-charges){: external}
for more details on data storage and provisioned throughput capacity, including
how to estimate costs for the Standard plan.
{: tip}

### Dedicated Hardware plan
{: #dedicated-hardware-plan}

Use the Dedicated Hardware plan for your most critical workloads, to enhance security and performance consistency.

A {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware plan instance allows you to run your Standard plan instances on a private, isolated database cluster, ensuring no resource sharing with other customers.

The Dedicated Hardware plan provides your {{site.data.keyword.cloudant_short_notm}} instances with the following benefits:

- An {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware plan instance that can be provisioned in any [{{site.data.keyword.cloud_notm}} region](https://cloud.ibm.com/docs/overview?topic=overview-locations){: external}.
- Improved consistency of performance as resources are not shared with other customers.
- Standard instances on this plan can be used for workloads requiring HIPAA. Be sure to select the HIPAA option during provisioning of the Dedicated Hardware plan.
- The plan supports bring-your-own-key (BYOK). While all Cloudant instances use encryption for data at rest, the Dedicated Hardware plan enables you to bring your own keys using {{site.data.keyword.IBM_notm}} Key Protect. BYOK keys must be chosen during provisioning, and cannot be changed after provisioning is completed.
- Private networking is included. This allows for applications to avoid internet data transit and egress bandwidth charges. Private networking requires that your {{site.data.keyword.cloud}} is enabled for [Cloud Service Endpoints](/docs/account?topic=account-service-endpoints-overview){: external}.
- IP allowlisting is configurable. Once a Dedicated Hardware plan instance is provisioned, users can contact {{site.data.keyword.cloudant_short_notm}} support to enable this feature. It is possible to use this feature to restrict access to the private network only.

A Dedicated Hardware plan instance can take up to 7 business days to provision. Once it is provisioned, you can select the Dedicated Hardware plan to host Standard plan instances. For more detailed instructions, see the [Using a Dedicated Hardware plan instance](/docs/Cloudant?topic=Cloudant-creating-and-leveraging-an-ibm-cloudant-dedicated-hardware-plan-instance-on-ibm-cloud) tutorial.

## Provisioning a {{site.data.keyword.cloudant_short_notm}} instance
{: #provisioning-a-cloudant-nosql-db-instance-on-ibm-cloud}

Refer to [Getting started](/docs/Cloudant?topic=Cloudant-getting-started-with-cloudant) for provisioning instructions.

## Locations and tenancy
{: #locations-and-tenancy}

By default, Lite and Standard plans are deployed on multi-tenant
environments. As part of your plan selection, you can choose from the
following {{site.data.keyword.cloud_notm}} locations:

- Chennai (SZR)
- Dallas
- Frankfurt&Dagger;
- London
- Osaka
- Sydney
- Seoul (SZR)
- Tokyo
- Washington DC

Single-Zone Region (SZR) means that only one availability zone is available in that location. All other locations are Multi-Zone Regions (MZR) and leverage three separate availability zones for instances that are deployed in those locations. For more information, see the [High availability (HA), disaster recovery (DR), and backup](/docs/Cloudant?topic=Cloudant-disaster-recovery-and-backup){: external} documentation.

Dedicated Hardware plan instances can be deployed in most
[{{site.data.keyword.IBM_notm}} data center locations](https://www.ibm.com/cloud/data-centers/){: external}.
See the drop-down menu in the {{site.data.keyword.cloud_notm}} catalog for an up-to-date list of available locations.

&Dagger;All {{site.data.keyword.cloudant_short_notm}} instances that are deployed from the
{{site.data.keyword.cloud_notm}} Frankfurt region
are deployed into EU-managed environments. Any {{site.data.keyword.cloudant_short_notm}}
account or API key that is generated
outside an EU-managed environment can't be granted access to an EU-managed
{{site.data.keyword.cloudant_short_notm}} instance. For more information, see [Enabling the EU Supported setting](/docs/account?topic=account-eu-hipaa-supported#bill_eusupported) for your {{site.data.keyword.cloud_notm}} account. 

## High availability, disaster recovery, and backup in a data center
{: #high-availability-disaster-recovery-and-backup-in-a-data-center}

To provide high availability (HA) and disaster recovery (DR) within a data center, all data is
stored in triplicate across three separate physical servers in a cluster. You can provision
accounts in multiple data centers, then use continuous data replication to provide HA/DR across
data centers. {{site.data.keyword.cloudant_short_notm}} data isn't automatically backed up, but supported tools are provided to handle backups. Review the
[Disaster recovery and backup guide](/docs/Cloudant?topic=Cloudant-disaster-recovery-and-backup)
to explore all HA, DR, and backup considerations to meet your application requirements.

## {{site.data.keyword.cloud_notm}} Support
{: #ibm-cloud-support}

Support for Standard and Dedicated plan service instances is optional.
Support is provided when you purchase *{{site.data.keyword.cloud_notm}} Standard Support*. Support isn't available for the Lite plan.

For more information, see the [{{site.data.keyword.cloud_notm}} Standard Support plans](https://www.ibm.com/cloud/support#944376){: external} and the [{{site.data.keyword.IBM_notm}} support guide](https://www.ibm.com/support/pages/node/733923){: external}.

The support systems that are used for {{site.data.keyword.cloudant_short_notm}} don't offer features for the protection of personal data or sensitive personal data. This content includes Healthcare Information, health data, Protected Health Information, or data that is subject to more regulatory requirements. As such, the Client must not enter or provide such data when interacting with {{site.data.keyword.cloudant_short_notm}} support.
{: note}

