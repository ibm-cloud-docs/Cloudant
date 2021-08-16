---

copyright:
  years: 2019, 2021
lastupdated: "2021-09-02"

keywords: apache couchdb, support, extension, provision an instance, pricing, vCPU definition

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

<!-- Acrolinx: 2021-04-09 -->

# Support for Apache CouchDB
{: #support-for-apache-couchdb-support}

Apache CouchDB is Apache-licensed open source software and free to use. For customers who need support from {{site.data.keyword.IBM}} for Apache CouchDB, see [this section](/docs/Cloudant?topic=Cloudant-apache-couchdb-support#cloud-extenstion-for-apache-couchdb-support).
{: shortdesc}

## Chat
{: #chat-support}

The Apache CouchDB community has Slack and IRC channels where you can ask questions. For more information, see the Slack sign-up form and the IRC details on the [Apache CouchDB website](http://couchdb.apache.org/){: new_window}{: external}.

## Documentation
{: #documentation-support}

The [Apache CouchDB documentation](http://docs.couchdb.org/en/stable/){: new_window}{: external} includes installation, configuration, and maintenance information along with an HTTP API reference guide.

## {{site.data.keyword.cloud_notm}} Extension for Apache CouchDB
{: #cloud-extenstion-for-apache-couchdb-support}

{{site.data.keyword.IBM_notm}} support for open source Apache CouchDB is offered by using the {{site.data.keyword.cloud_notm}} Extension for Apache CouchDB, which is only available to allow listed users. Contact your {{site.data.keyword.cloud_notm}} Sales representative if you are interested in this service.

 Allow listed users can purchase an instance of {{site.data.keyword.cloud_notm}} Extension for Apache CouchDB from the {{site.data.keyword.cloud_notm}} catalog. To do so, go to the {{site.data.keyword.cloudantfull}} catalog tile and choose the Extension for Apache CouchDB option.

### Provisioning an instance
{: #provisioning-an-instance-support}

1. Go to the [{{site.data.keyword.cloudant_short_notm}} catalog tile](https://cloud.ibm.com/catalog/services/cloudant), and click **Create**.
2. Select the Extension for Apache CouchDB option. <br>(If the Extension for Apache CouchDB option is not available, contact support to enable the option for your account.)
3. Enter an Instance name, and use "CouchDB" somewhere in the name to distinguish it from {{site.data.keyword.cloudant_short_notm}} instances.
4. Select a Resource group.
5. Select the number of virtual processor cores (vCPUs) to match that of the vCPUs used in all Apache CouchDB database nodes that require support entitlement. The minimum value is 24. 
6. Click **Create**. 

The Extension for an Apache CouchDB instance does not provision a cloud service. Instead, the instance is a placeholder to ensure payment and support entitlement on self-managed Apache CouchDB instances that are deployed by the customer.

### Pricing
{: #pricing-support}

Pricing is based on the number of vCPUs in the database nodes of the Apache CouchDB clusters. A total sum of all vCPUs must be allocated for based on the support coverage required. Pricing is pro-rated monthly, and single usage is submitted based on the max vCPU defined for the full month that an instance is deployed. The first month is pro-rated based on the number of days that remain in the month, and full month charges are submitted thereafter.

| vCPU Range | Price per vCPU |
|---------|----------|
| 24 - 50 vCPUs | USD$65 per vCPU | 
| 51 - 200 vCPUs | USD$45 per vCPU | 
| 201 - 1,500 vCPUs | USD$30 per vCPU | 
| 1,501 - 10,000 vCPUs | USD$20 per vCPU | 
| 10,001+ vCPUs | USD$15 per vCPU | 
{: caption="Table 1. Price by vCPU" caption-side="top"}

### vCPU definition
{: #vcpu-aka-virtual-processor-core-def-support}

vCPU (virtual processor core) is a unit of measure by which the Program can be licensed. A Physical Server is a physical computer that is composed of processing units, memory, and input and output capabilities. It executes requested procedures, commands, or applications for one or more users or client devices. When you install racks, blade enclosures, or other similar equipment, each separable physical device  that has the required components is considered itself a separate Physical Server. For example, devices such as a blade or a rack-mounted device. A Virtual Server is either a virtual computer that is created by partitioning the resources available to a Physical Server or an unpartitioned Physical Server. A processor core (commonly called a processor or CPU) is a functional unit within a computing device that interprets and executes instructions. A processor core consists of at least an instruction control unit, and one or more arithmetic or logic units. A vCPU is a processor core in an unpartitioned Physical Server, or a virtual core assigned to a Virtual Server. Licensee must obtain entitlement for each vCPU made available to the Program.

### Support requirements
{: #support-requirements-support}

The following list outlines the support requirements that you need to qualify for support for Apache CouchDB: 

Requirement | Supported
------------|---------
Apache CouchDB version | 3.x or later
OS | Officially supported Linux&trade; distributions of Apache CouchDB installers or containers
CPU Architecture | x86 or Power
Installation Artifacts | Supported artifacts are listed at [Apache CouchDB - Installation](/docs/Cloudant?topic=Cloudant-apache-couchdb-install).
{: caption="Table 2. Apache CouchDB support requirements" caption-side="top"}

For customers who deploy Apache CouchDB in containerized environments, the following list outlines the support requirements that are required to qualify for support for Apache CouchDB:

Requirement | Supported
------------|---------
Kubernetes | 1.14 or later
Red Hat OpenShift | 4.x or later
Installation | Install only by using [Operator for Apache CouchDB](/docs/Cloudant?topic=Cloudant-apache-couchdb-operator). 
Storage | POSIX-compliant storage is required. NFS that doesn't meet POSIX compliance causes instability and errors if used. Apache CouchDB is an I/O intensive database, and we recommend that you use SSDs for heavy workloads. For more information, see the [Operator for Apache CouchDB configuration](/docs/Cloudant?topic=Cloudant-configure-couchdb-cluster#couchdb-storage) documentation for details on specific persistent storage requirements. 
{: caption="Table 3. Apache CouchDB support requirements in containerized environments" caption-side="top"}

#### Logging
{: #logging-supportcdb}

Customers are required to capture logs and provide those logs directly to {{site.data.keyword.IBM_notm}} support. Log types include but are not limited to the ones in the following list:

- Apache CouchDB logs.
- `Runit` logs.
- Proxy logs.

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
- {{site.data.keyword.IBM_notm}} coordinates and promotes fixes with the OSS community for open source Apache CouchDB.
- Troubleshooting issues that are related to Apache CouchDB software itself.

#### What isn't included with support?
{: #support-does-not-include-support}

- Proprietary customer-side tooling or workflow.
- Third-party monitoring integration.
- Network issues.
- On-disk encryption.
- Performance tuning.
- Design optimization.
- Capacity planning.
- Feature or enhancement requests.
- Fixes for issues that are related to underlying hardware infrastructure.

### Opening a Support Case
{: #opening-a-support-case-support}

1. Go to the [{{site.data.keyword.cloud}} Support Center](https://cloud.ibm.com/unifiedsupport/supportcenter), and click **Create a case**.
2. Choose {{site.data.keyword.cloudant_short_notm}} from the list of products.
3. In the Subject field, type "Apache CouchDB:" followed by a short description of the issue.
4. In the Description field, include as much detail as possible on the issue. <br>The following list includes the minimum amount of information that is required:
    - Versions of Apache CouchDB, OS, or any Kubernetes environment.
    - CRN of the Extension for Apache CouchDB instance to verify support entitlement. The CRN can be found in the Manage instance page. Support is not provided without including the CRN.
    - Details of the issues.
5. Attach any relevant logs or screen captures.<br>
  For customers who deploy Apache CouchDB in containerized environments, provide the following details:
    - Version of the Operator for Apache CouchDB that is deployed.
    - YAML files that are related to the deployment of the following Kubernetes resources - couchdbcluster, formation, stateful set, pods, and configmap.
    - Logs of CouchDB container, management container, and operator container.
    - Contents found on the CouchDB pod in the following files - /conf/couchdb/user.ini, /conf/couchdb/local.ini, /conf/couchdb/clouseau.ini, and /conf/couchdb/vm.args.
6. Under Resources, select the Extension for Apache CouchDB instance for support entitlement, which has an {{site.data.keyword.cloudant_short_notm}} logo. 
7. Click **Continue**.
8. Click **Submit case**.


