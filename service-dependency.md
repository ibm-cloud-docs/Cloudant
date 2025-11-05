---

copyright:
  years: 2024, 2025
lastupdated: "2025-11-05"

keywords:

subcollection: Cloudant

---




{{site.data.keyword.attribute-definition-list}}

# Service dependency map for IBM Cloudant for IBM Cloud
{: #service-dependencies}

If a service depends on other {{site.data.keyword.cloud_notm}} services, there can be impacts if any of the dependent services are having issues. The dependency severity indicates the impact to the service when the dependency is down.
{: shortdesc}

Critical
:   When the the dependency is down, the service is down.

Significant
:   When the dependency is down, the service features are impacted.

Medium
:   When the dependency is down, the service might be impacted and a workaround is possible.

Minimal
:   When the dependency is down, the main service features are not impacted.



## Data deployment
{: #data-deployment}

The following dependencies apply to the following deployment locations: Amsterdam 03, Chennai - Airtel (in-che), Chennai 01, Dallas (us-south), Frankfurt (eu-de), London (eu-gb), Madrid (eu-es), Milan 01, Montreal 01, Osaka (jp-osa), San Jose 01, San Jose 03, San Jose 04, Sao Paulo (br-sao), Singapore 01, Sydney (au-syd), Tokyo (jp-tok), Toronto (ca-tor), Washington DC (us-east).


|Dependencies|Dependency impacts|Customer provided|Control or data plane|Location of dependency|
|:---|:---|:---|:---|:---|
| IBM Cloud Classic DNS Servers | Availability, Change management, Instance control | No | data-plane |  Same data center  |
| IBM Cloud Public IP Address Management | Availability, Change management, Instance control | No | data-plane |  [Global](/docs/resiliency?topic=resiliency-ha-redundancy#global-platform)  |
| IBM Cloud Classic Infrastructure Resource Management | Availability, Change management, Instance control | No | data-plane |  [Global](/docs/resiliency?topic=resiliency-ha-redundancy#global-platform)  |
| {{site.data.keyword.iamlong}} | Access management, Availability, Change management, Disaster recovery, Instance control | No | data-plane |  [Global](/docs/resiliency?topic=resiliency-ha-redundancy#global-platform)  |
{: row-headers}
{: caption="IBM Cloudant for IBM Cloud - Data deployment service dependency information - Critical dependencies" caption-side="top"}
{: tab-title="Critical dependencies"}
{: tab-group="service-dependency-data-for-cloudantnosqldb-Data-deployment"}
{: class="comparison-tab-table"}
{: #critical-deps}
{: summary="Use the buttons for the dependency level to change the context of the table. This table has row and column headers. The row headers detail the specific dependent service. The column headers identify the details about the dependency and its impact. To understand the details about each dependency, navigate to the row to find the dependency that you need more information about interested in."}

|Dependencies|Dependency impacts|Customer provided|Control or data plane|Location of dependency|
|:---|:---|:---|:---|:---|
| {{site.data.keyword.cis_full}} | Availability, Change management, Disaster recovery, Instance control | No | data-plane |  [Global](/docs/resiliency?topic=resiliency-ha-redundancy#global-platform)  |
| IBM Cloud Classic NTP Servers | Availability, Change management, Instance control | No | data-plane |  Same data center  |
| {{site.data.keyword.keymanagementservicefull}} | Availability, Disaster recovery, Instance control, Security compliance | No | data-plane |  Same region  |
{: row-headers}
{: caption="IBM Cloudant for IBM Cloud - Data deployment service dependency information - Significant dependencies" caption-side="top"}
{: tab-title="Significant dependencies"}
{: tab-group="service-dependency-data-for-cloudantnosqldb-Data-deployment"}
{: class="comparison-tab-table"}
{: #significant-deps}
{: summary="Use the buttons for the dependency level to change the context of the table. This table has row and column headers. The row headers detail the specific dependent service. The column headers identify the details about the dependency and its impact. To understand the details about each dependency, navigate to the row to find the dependency that you need more information about interested in."}

|Dependencies|Dependency impacts|Customer provided|Control or data plane|Location of dependency|
|:---|:---|:---|:---|:---|
| SOS SIEM| Security compliance | No | data-plane |  [Global](/docs/resiliency?topic=resiliency-ha-redundancy#global-platform)  |
| SOS Health-Check, Vulnerability Scanning and Patching| Security compliance | No | data-plane |  [Global](/docs/resiliency?topic=resiliency-ha-redundancy#global-platform)  |
| SOS Inventory Management| Security compliance | No | data-plane |  [Global](/docs/resiliency?topic=resiliency-ha-redundancy#global-platform)  |
{: row-headers}
{: caption="IBM Cloudant for IBM Cloud - Data deployment service dependency information - Minimal dependencies" caption-side="top"}
{: tab-title="Minimal dependencies"}
{: tab-group="service-dependency-data-for-cloudantnosqldb-Data-deployment"}
{: class="comparison-tab-table"}
{: #minimal-deps}
{: summary="Use the buttons for the dependency level to change the context of the table. This table has row and column headers. The row headers detail the specific dependent service. The column headers identify the details about the dependency and its impact. To understand the details about each dependency, navigate to the row to find the dependency that you need more information about interested in."}

## Control plane deployment
{: #control-plane-deployment}

The following dependencies apply to the following deployment locations: Dallas (us-south), Frankfurt (eu-de), Washington DC (us-east).


|Dependencies|Dependency impacts|Customer provided|Control or data plane|Location of dependency|
|:---|:---|:---|:---|:---|
| IBM Cloud Classic DNS Servers | Availability, Change management, Instance control | No | control-plane |  Same data center  |
| IBM Cloud Public IP Address Management | Availability, Change management, Instance control | No | control-plane |  [Global](/docs/resiliency?topic=resiliency-ha-redundancy#global-platform)  |
| IBM Cloud Classic Infrastructure Resource Management | Availability, Change management, Instance control | No | control-plane |  [Global](/docs/resiliency?topic=resiliency-ha-redundancy#global-platform)  |
| {{site.data.keyword.iamlong}} | Availability, Change management, Instance control, Security compliance | No | control-plane |  [Global](/docs/resiliency?topic=resiliency-ha-redundancy#global-platform)  |
{: row-headers}
{: caption="IBM Cloudant for IBM Cloud - Control plane deployment service dependency information - Critical dependencies" caption-side="top"}
{: tab-title="Critical dependencies"}
{: tab-group="service-dependency-data-for-cloudantnosqldb-Control-plane-deployment"}
{: class="comparison-tab-table"}
{: #critical-deps}
{: summary="Use the buttons for the dependency level to change the context of the table. This table has row and column headers. The row headers detail the specific dependent service. The column headers identify the details about the dependency and its impact. To understand the details about each dependency, navigate to the row to find the dependency that you need more information about interested in."}

|Dependencies|Dependency impacts|Customer provided|Control or data plane|Location of dependency|
|:---|:---|:---|:---|:---|
| {{site.data.keyword.monitoringlong}} | Availability, Operations | No | control-plane |  Same region  |
| {{site.data.keyword.cis_full}} | Availability, Change management, Disaster recovery, Instance control | No | control-plane |  [Global](/docs/resiliency?topic=resiliency-ha-redundancy#global-platform)  |
| IBM Cloud Classic NTP Servers | Availability, Change management, Instance control | No | control-plane |  Same data center  |
| IBM Cloud Kubernetes Service and Red Hat OpenShift on IBM Cloud | Availability, Change management, Disaster recovery, Instance control | No | control-plane |  Same region  |
| PagerDuty | Availability, Operations | No | control-plane |  [Global](/docs/resiliency?topic=resiliency-ha-redundancy#global-platform)  |
{: row-headers}
{: caption="IBM Cloudant for IBM Cloud - Control plane deployment service dependency information - Significant dependencies" caption-side="top"}
{: tab-title="Significant dependencies"}
{: tab-group="service-dependency-data-for-cloudantnosqldb-Control-plane-deployment"}
{: class="comparison-tab-table"}
{: #significant-deps}
{: summary="Use the buttons for the dependency level to change the context of the table. This table has row and column headers. The row headers detail the specific dependent service. The column headers identify the details about the dependency and its impact. To understand the details about each dependency, navigate to the row to find the dependency that you need more information about interested in."}

|Dependencies|Dependency impacts|Customer provided|Control or data plane|Location of dependency|
|:---|:---|:---|:---|:---|
| ServiceNow| Change management, Operations | No | control-plane |  [Global](/docs/resiliency?topic=resiliency-ha-redundancy#global-platform)  |
| Slack| Change management, Operations | No | control-plane |  [Global](/docs/resiliency?topic=resiliency-ha-redundancy#global-platform)  |
{: row-headers}
{: caption="IBM Cloudant for IBM Cloud - Control plane deployment service dependency information - Medium dependencies" caption-side="top"}
{: tab-title="Medium dependencies"}
{: tab-group="service-dependency-data-for-cloudantnosqldb-Control-plane-deployment"}
{: class="comparison-tab-table"}
{: #medium-deps}
{: summary="Use the buttons for the dependency level to change the context of the table. This table has row and column headers. The row headers detail the specific dependent service. The column headers identify the details about the dependency and its impact. To understand the details about each dependency, navigate to the row to find the dependency that you need more information about interested in."}

|Dependencies|Dependency impacts|Customer provided|Control or data plane|Location of dependency|
|:---|:---|:---|:---|:---|
| IBM Cloud Business Support Services| none | No | control-plane |  [Global](/docs/resiliency?topic=resiliency-ha-redundancy#global-platform)  |
| {{site.data.keyword.cos_full}}| Security compliance | No | control-plane |  Same region  |
| SOS SIEM| Security compliance | No | control-plane |  [Global](/docs/resiliency?topic=resiliency-ha-redundancy#global-platform)  |
| {{site.data.keyword.messagehub_full}}| Customer responsibility | No | control-plane |  Same region  |
| SOS Health-Check, Vulnerability Scanning and Patching| Security compliance | No | control-plane |  [Global](/docs/resiliency?topic=resiliency-ha-redundancy#global-platform)  |
| {{site.data.keyword.atracker_full}}| Security compliance | No | control-plane |  Same region  |
| SOS Inventory Management| Security compliance | No | control-plane |  [Global](/docs/resiliency?topic=resiliency-ha-redundancy#global-platform)  |
| IBM Log Analysis and IBM Cloud Activity Tracker| Customer responsibility | No | control-plane |  Same region  |
{: row-headers}
{: caption="IBM Cloudant for IBM Cloud - Control plane deployment service dependency information - Minimal dependencies" caption-side="top"}
{: tab-title="Minimal dependencies"}
{: tab-group="service-dependency-data-for-cloudantnosqldb-Control-plane-deployment"}
{: class="comparison-tab-table"}
{: #minimal-deps}
{: summary="Use the buttons for the dependency level to change the context of the table. This table has row and column headers. The row headers detail the specific dependent service. The column headers identify the details about the dependency and its impact. To understand the details about each dependency, navigate to the row to find the dependency that you need more information about interested in."}


## Understanding service dependency data
{: #understand-dependency-data}

If you have any questions about the service dependency data as you review the service dependency information in the tables, you can refer to the following FAQ:

### What is the expected impact to the functions described?
{: #expected-impact}

Each severity tab in the table indicates the impact that your provisioned service might encounter if the dependency were to go offline. This means that the dependency high availability and disaster recovery influences the severity of the impact and therefore is used for general guidance to help you understand potential issues that might arise if the dependency was impacted by an incident.

Services that are regional are not impacted by a severe outage of a single zone because of the failover that is built in to default to another zone. For these occurrences, there might be a slight performance impact, if any, while the system fails over to the other location. This also applies to global services where the impact is lowered even more as it can fail over to other regions if necessary. This reduces the frequency at which these items might have the impact that is shown.
{: note}

### What services does my service depend on?
{: #dependent-services}

The **Dependencies** column lists the services. These are the major service to service dependencies including major internal dependencies that might not be visible externally.

### What function does the dependency impact?
{: #function-impact}

Functions include access management, availability, change management, configuration management, customer responsibility, disaster recovery, instance control, operations, security compliance, or none. If the dependency goes offline, these functions might be impacted. Definitions for each available value are as follows:

Access management
:   Authentication, authorization, and governance of the customer users access to the service and service instances.

Availability
:   Availability of the service and service instances.

Change management
:   Deployment, upgrade, patch, and so on, of the service and service instances.

Configuration management
:   Deployment, upgrade, patch, and so on, of the service and service instances.

Customer responsibility
:   Functions provided by customers to support specific service and service instances function. For example, {{site.data.keyword.keymanagementservicefull_notm}} instances provided by customer to support service BYOK encryption.

Disaster recovery
:   Backup, recovery, restart of the service and service instances in the case of a disruption.

Instance control
:   Creation, deletion, start, stop actions on the lifecycle of the service instances.

Operations
:   Monitoring, troubleshooting, and so on, of the service and service instances.

Security compliance
:   Vulnerability management and other security and compliance management of the service and service instances.

None
:   No function impacted.

### What does customer provided mean for dependencies?
{: #customer-provided-dep}

The **Customer provided** column reports if there is any dependency that has been provided by the customer to enable specific functionality. One such example is to properly configure and set up using BYOK into a service, the customer would provision a service like {{site.data.keyword.keymanagementservicefull_notm}}. For more information about how to enable the features and which services you need to provision, see the documentation for the service.

### Where do dependency services need to be deployed regarding my service?
{: #deploy-dependencies}

In the **Location of dependency** column, you can view if the dependency is located in the same region or deployed to a specific data center. You can use this data with the data in the **Control or data plane** column for a quick reference to identify if your data leaves the region or not in a standard setup.

To find where your service can be deployed, see [Service and infrastructure availability by location](/docs/overview?topic=overview-services_region).

The table shows a standard cloud deployment. If a special deployment is used like FedRAMP or other region-bound deployment models, the data might differ from the details available in the table. Refer to the specific deployment that you are using for that information.
{: note}

### Where are the separate control plane and data plane located, if applicable?
{: #separate-plans}

Sometimes, the dependency might have a separate control plane and data plane. In these cases, there are separate lines that show the location in relation to the deployed customer instance of the service where these will be provisioned. The lines might have different impacts and different functions. See the **Control or data plane** column to understand what possible impact this type of outage might have.

`Same region` means that the dependent services are in the same region as the provisioned instance. Other values might show `data center` or region names if the service must be used from a specific region, a specific zone, or set of zones. If a service is tied to a specific region or site, and the region goes offline, the service might go offline as well. It is recommended that you go through the high availability and disaster recovery documentation of the dependency to determine if there are any steps that you should take to mitigate these types of risks.

## Additional resources
{: #additional-resources}

For more information about the policies that are related to the services, you can refer to the following resources:

* [Service Level Agreement](https://www.ibm.com/support/customer/csol/terms/?id=i126-6605&lc=en){: external}
* [Shared responsibilities for using {{site.data.keyword.cloud_notm}} products](/docs/overview?topic=overview-shared-responsibilities)
* [Service and infrastructure availability by location](/docs/overview?topic=overview-services_region)
