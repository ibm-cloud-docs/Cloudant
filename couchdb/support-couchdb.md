---

copyright:
  years: 2019, 2020
lastupdated: "2020-12-16"

keywords: apache couchdb, support, extension

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

<!-- Acrolinx: 2020-10-06 -->

# Support
{: #apache-couchdb-support}

Apache CouchDB is Apache-licensed open source software and free to use. For customers who want to receive enterprise-class support from {{site.data.keyword.IBM}} for Apache CouchDB, see the {{site.data.keyword.cloud}} Extension for Apache CouchDB section for details.
{: shortdesc}

## Chat
{: #chat-support}

The Apache CouchDB community has Slack and IRC channels where you can ask questions. For more information, see the Slack sign-up form and the IRC details on the [Apache CouchDB website](http://couchdb.apache.org/){: new_window}{: external}.

## Documentation
{: #documentation-support}

The [Apache CouchDB documentation](http://docs.couchdb.org/en/stable/){: new_window}{: external} includes installation, configuration, and maintenance information along with an HTTP API reference guide.

## {{site.data.keyword.cloud_notm}} Extension for Apache CouchDB
{: #cloud-extenstion-for-apache-couchdb-support}

{{site.data.keyword.IBM_notm}} support for open source Apache CouchDB is offered via the {{site.data.keyword.cloud_notm}} Extension for Apache CouchDB, which is currently only available to allowlisted users. Contact your {{site.data.keyword.cloud_notm}} Sales representative if you are interested in this service.

Allowlisted users can purchase an instance of {{site.data.keyword.cloud_notm}} Extension for Apache CouchDB from the {{site.data.keyword.cloud_notm}} Catalog. To do so, go to the {{site.data.keyword.cloudantfull}} catalog tile and choose the Extension for Apache CouchDB option.

### Provisioning an instance
{: #provisioning-an-instance-support}

1. Go to the [{{site.data.keyword.cloudant_short_notm}} catalog tile](https://cloud.ibm.com/catalog/services/cloudant), and click the **Create** tab.
2. Select the Extension for Apache CouchDB option. (If the Extension for Apache CouchDB option is not available, contact support to enable the option for your account.)
3. Enter an Instance name, and use "CouchDB" somewhere in the name to distinguish it from {{site.data.keyword.cloudant_short_notm}} instances.
4. Select a Resource group.
5. Select the number of Virtual Process Cores (vCPUs) to match that of the vCPUs used in all Apache CouchDB database nodes that require support entitlement. The minimum value is 24. 
6. Click **Create**. 

The Extension for an Apache CouchDB instance does not provision a cloud service. Instead, the instance is a placeholder to ensure payment and support entitlement on self-managed Apache CouchDB instances deployed by the customer.

### Pricing
{: #pricing-support}

Pricing is based on the number of vCPUs in the database nodes of the Apache CouchDB clusters. A total sum of all vCPUs must be allocated for based on the support coverage required. Pricing is pro-rated monthly, and single usage is submitted based on the max vCPU defined for the full month that an instance is deployed. The first month is pro-rated based on the number of days remaining in the month, and full month charges are submitted thereafter.

| vCPU Range | Price per vCPU |
|---------|----------|
| 24-50 vCPUs | USD$65/vCPU | 
| 51-200 vCPUs | USD$45/vCPU | 
| 201-1,500 vCPUs | USD$30/vCPU | 
| 1,501-10,000 vCPUs | USD$20/vCPU | 
| 10,001+ vCPUs | USD$15/vCPU | 

### vCPU definition
{: #vcpu-aka-virtual-processor-core-def-support}

Virtual Processor Core (vCPU) is a unit of measure by which the Program can be licensed. A Physical Server is a physical computer that is comprised of processing units, memory, and input/output capabilities, and it executes requested procedures, commands, or applications for one or more users or client devices. Where racks, blade enclosures, or other similar equipment is employed, each separable physical device (for example, a blade or a rack-mounted device) that has the required components is considered itself a separate Physical Server. A Virtual Server is either a virtual computer created by partitioning the resources available to a Physical Server or an unpartitioned Physical Server. A Processor Core (commonly called a processor or CPU) is a functional unit within a computing device that interprets and executes instructions. A Processor Core consists of at least an instruction control unit, and one or more arithmetic or logic units. A Virtual Processor Core is a Processor Core in an unpartitioned Physical Server, or a virtual core assigned to a Virtual Server. Licensee must obtain entitlement for each Virtual Processor Core made available to the Program.

### Support requirements
{: #support-requirements-support}

The following list outlines the support requirements you need to qualify for support for Apache CouchDB: 

- Apache CouchDB version: 3.x or above.
- OS: Officially-supported Linux distributions of Apache CouchDB installers or containers.
- CPU Architecture: x86 or Power.
- Installation Artifacts: Supported artifacts are listed at [Apache CouchDB - Install](/docs/Cloudant?topic=Cloudant-apache-couchdb-install).

For customers deploying Apache CouchDB in containerized environments, the following list outlines the support requirements you need to qualify for support for Apache CouchDB:

- Kubernetes: 1.14 or above.
- Red Hat OpenShift: 4.x or above.
- Installation only via [Operator for Apache CouchDB](/docs/Cloudant?topic=Cloudant-apache-couchdb-operator).
- Storage: POSIX compliant storage is required. NFS that doesn't meet POSIX compliance causes instability and errors if used. Apache CouchDB is an I/O intensive database, and it's recommended that you use SSDs for heavy workloads. For more details on specific persistent storage requirements, see the [Operator for Apache CouchDB configuration documentation](/docs/Cloudant?topic=Cloudant-configure-couchdb-cluster#couchdb-storage).  

**Logging**

Customers are required to capture logs and provide those logs directly to {{site.data.keyword.IBM_notm}} support. Log types include but are not limited to the ones in the following list:

- Apache CouchDB logs
- Runit logs
- Proxy logs

### Support services
{: #support-service-support}

You can see what is included with support and what is not in the following lists. 

#### What is included with support?
{: #support-includes-support}

- Proper installation.
- Setup.
- Configuration.
- Errors or unexpected results from APIs. 
- Maintenance fixes - {{site.data.keyword.IBM_notm}} team commits to working with OSS Apache CouchDB to open and facilitate maintenance fixes in future versions.
- {{site.data.keyword.IBM_notm}} coordinates and promotes fixes with the OSS community for open-source Apache CouchDB.
- Troubleshooting issues related to Apache CouchDB software itself.

#### What isn't included with support?
{: #support-does-not-include-support}

- Proprietary customer-side tooling or workflow
- Third-party monitoring integration
- Network issues
- On-disk encryption
- Performance tuning
- Design optimization
- Capacity planning
- Feature/Enhancement requests
- Fixes for issues related to underlying hardware infrastructure

### Opening a Support Case
{: #opening-a-support-case-support}

1. Go to the [{{site.data.keyword.cloud}} Support Center](https://cloud.ibm.com/unifiedsupport/supportcenter), and click on **Create a case**.
2. Choose {{site.data.keyword.cloudant_short_notm}} from the list of products.
3. In the Subject field, type "Apache CouchDB:" followed by a short description of the issue.
4. In the Description field, include as much detail as possible on the issue. The following list includes the minimum amount of information that is required:
  - Versions of Apache CouchDB, OS, or any Kubernetes environment.
  - CRN of the Extension for Apache CouchDB instance to verify support entitlement. The CRN can be found in the Manage instance page. Support is not provided without including the CRN.
  - Details of the issues.
5. Attach any relevant logs or screenshots.
6. Under Resources, select the Extension for Apache CouchDB instance for support entitlement. Note that it has the {{site.data.keyword.cloudant_short_notm}} logo. 
7. Click **Continue**.
8. Click **Submit case**.


