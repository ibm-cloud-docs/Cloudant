---

copyright:
  years: 2020
lastupdated: "2020-05-19"

keywords: Sysdig, monitoring, platform metrics, observability page

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

# Sysdig Monitoring integration
{: #monitor-sysdig-pm}

{{site.data.keyword.mon_full}} is a third-party, cloud-native, and container-intelligent management system that you can include as part of your {{site.data.keyword.cloud}} architecture. Use it to gain operational visibility into the performance and health of your applications, services, and platforms. It offers administrators, DevOps teams, and developers full-stack telemetry with advanced features to monitor and troubleshoot, define alerts, and design custom dashboards. {{site.data.keyword.mon_full_notm}} is operated by Sysdig in partnership with {{site.data.keyword.IBM}}.
{:shortdesc}


## Platform metrics overview
{: #platform_metrics-pm}

You can configure only one instance of the {{site.data.keyword.mon_full_notm}} service per region to collect platform metrics. 
* To configure the Sysdig instance, you must turn on the *platform metrics* configuration setting. 
* If a Sysdig instance in a region is already enabled to collect platform metrics, metrics from enabled-Sysdig services are collected automatically and available for monitoring through this instance. For more information about enabled-Sysdig services, see [{{site.data.keyword.cloud}} services](https://www.ibm.com/cloud/services).

To monitor platform metrics, check that the {{site.data.keyword.mon_full_notm}} instance is provisioned in the same region where the {{site.data.keyword.cloud_notm}} instance is provisioned.
{: important}

## Enabling platform metrics from the {{site.data.keyword.cloud_notm}} dashboard
{: #enable_platform_metrics-pm}

Complete the following steps to configure platform metrics:

1. Log in to {{site.data.keyword.cloud_notm}}. 

    The {{site.data.keyword.cloud_notm}} dashboard opens. 
    
2. Click **View resources**.

3. In the *Services* section, click the {{site.data.keyword.cloud_notm}} instance that you plan to monitor. 

    The {{site.data.keyword.cloud_notm}} UI *Manage* page opens.

4. Click the Overflow menu, and select **Add monitoring** to configure *platform metrics* in the region of your {{site.data.keyword.cloud_notm}} instance.

    If the menu choices include the **Monitoring** option, then your instance is already configured for platform metrics. 
    {: note}
    
    ![Monitoring menu](../images/monitoring_add.png)

6. Provision an instance of the {{site.data.keyword.mon_full_notm}} service.

   After you provision the Sysdig instance, the *Observabvility* page opens. To continue working with {{site.data.keyword.cloud_notm}}, go back to the {{site.data.keyword.cloud_notm}} UI.
   {: note}


## Viewing metrics
{: #view_metrics}

To monitor {{site.data.keyword.cloudant_short_notm}} metrics, you must launch the Sysdig web UI instance that is enabled for platform metrics in the region where your {{site.data.keyword.cloud_notm}} instance is available.
{: important}

There are different options to launch the Sysdig web UI and monitor metrics that are described in the following section.

### Launching Sysdig web UI from the {{site.data.keyword.cloudant_short_notm}} dashboard
{: #view_metrics_opt1}

Complete the following steps to launch the Sysdig web UI from the {{site.data.keyword.cloud_notm}} dashboard:

1. Log in to {{site.data.keyword.cloud_notm}}. 

    The {{site.data.keyword.cloud_notm}} dashboard opens. 
    
2. Click **View resources**.

3. In the *Services* section, click the {{site.data.keyword.cloudant_short_notm}} instance that you plan to monitor. 

    The {{site.data.keyword.cloudant_short_notm}} *Manage* page opens.

4. Click the Overflow menu, and select **Monitoring**.

    ![Monitoring menu](../images/monitoring_menu.png)

    A new tab in your browser opens and displays the *Default* dashboard named ** {{site.data.keyword.cloudant_short_notm}} ** within the context of your {{site.data.keyword.cloudant_short_notm}} instance.

### Launching Sysdig web UI from the Observability page
{: #view_metrics_opt2}

Complete the following steps to launch the Sysdig web UI from the *Observability* page:

1. [Launch the Sysdig web UI](https://cloud.ibm.com/docs/Monitoring-with-Sysdig?topic=Sysdig-launch).
2. Click **DASHBOARDS**.
3. In the **Default Dashboards** section, expand **{{site.data.keyword.IBM_notm}}**.
4. Choose the {{site.data.keyword.cloudant_short_notm}} dashboard from the list.

    To access your deployment's Sysdig dashboard from Sysdig, it's in the sidebar, under {{site.data.keyword.IBM_notm}}.

    ![{{site.data.keyword.cloudant_short_notm}} dashboard](../images/dashboard_link.png)

    Next, change the scope or make a copy of the *Default* dashboard to monitor an {{site.data.keyword.cloudant_short_notm}} instance.  

## {{site.data.keyword.cloudant_short_notm}} metrics dictionary
{: #metrics_dictionary-pm}

### HTTP request count
{: #ibm_cloudant_http_requests_total-pm}

The number of HTTP requests made against an {{site.data.keyword.cloudant_short_notm}} instance:

| Metadata | Description |
|----------|-------------|
| `Metric Name` | `ibm_cloudant_http_requests_total`|
| `Metric Type` | `counter` |
| `Value Type`  | `none` |
| `Segment By` | `Service instance, Service instance name` |
{: caption="Table 1. HTTP request count metric metadata" caption-side="top"}

### Rate-limited operations
{: #ibm_cloudant_rate_limited_operations-pm}

The number of operations that were rate-limited:

| Metadata | Description |
|----------|-------------|
| `Metric Name` | `ibm_cloudant_rate_limited_operations`|
| `Metric Type` | `counter` |
| `Value Type`  | `none` |
| `Segment By` | `Service instance, Service instance name, Cloudant operation type` |
{: caption="Table 2. Rate-limited operations metric metadata" caption-side="top"}

## Attributes for Segmentation
{: attributes}

### Global Attributes
{: global-attributes-pm}

The following attributes are available for segmenting all the metrics listed previously:

| Attribute | Name | Description |
|-----------|----------------|-----------------------|
| `Cloud Type` | `ibm_ctype` | The cloud type is a value of public, dedicated, or local. |
| `Location` | `ibm_location` | The location of the monitored resource, which can be a region, data center, or global. |
| `Resource` | `ibm_resource` | The resource being measured by the service, typically an identifying name or GUID. |
| `Scope` | `ibm_scope` | The scope is the account, organization, or space GUID associated with this metric. |
| `Service name` | `ibm_service_name` | Name of the service generating this metric. |
{: caption="Table 3. Global attributes" caption-side="top"}

### Additional Attributes
{: additional-attributes}

The following attributes are available for segmenting one or more attributes as described in the previous reference. See the individual metrics for segmentation options in the following table:

| Attribute | Name | Description |
|-----------|----------------|-----------------------|
| `Cloudant operation type` | `ibm_cloudant_operation_type` | The Cloudant billable operation type. |
| `Service instance` | `ibm_service_instance` | The service instance segment identifies the instance the metric is associated with. |
{: caption="Table 4. More attributes" caption-side="top"}

## {{site.data.keyword.cloudant_short_notm}} dashboards dictionary
{: #dashboards_dictionary-pm}

The following table outlines the pre-defined dashboards that you can use to monitor {{site.data.keyword.cloudant_short_notm}} metrics:

| Dashboard name        | Description    |
|-----------------------|----------------|
| `IBM Cloudant`   | The default dashboard that opens when you launch Sysdig web UI from your service instance UI. |
{: caption="Table 5. Pre-defined dashboards" caption-side="top"}

The *Default* dashboard cannot be changed.
{: important}

