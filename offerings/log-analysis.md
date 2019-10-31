---

copyright:
  years: 2015, 2019
lastupdated: "2019-10-30"

keywords: log analysis, integration 

subcollection: cloudant

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

<!-- Acrolinx: 2018-05-31 -->

# Log Analysis integration
{: #log-analysis-integration}

{{site.data.keyword.cloudantfull}} is integrated with [{{site.data.keyword.la_full}}](/docs/services/Log-Analysis-with-LogDNA?topic=LogDNA-about){: new_window}{: external}, so you can view database logs.

Currently, {{site.data.keyword.la_full_notm}} integration is available for {{site.data.keyword.cloudant_short_notm}} deployments according to the following table:

Deployment Region | LogDNA Region
----------|-----------
`Dallas` | `Dallas`
`London` | `London`
`Frankfurt` | `Frankfurt`
`Tokyo` | `Tokyo`
`Sydney` | `Sydney`
{: caption="Table 1. Log Analysis regions" caption-side="top"}

## Provisioning {{site.data.keyword.la_full_notm}}
{: #provisioning-logdna}

Log information from your databases is automatically forwarded to {{site.data.keyword.la_full_notm}}, but in order to access it you have to [provision a Log Analysis service](/docs/services/Log-Analysis-with-LogDNA?topic=LogDNA-provision){: new_window}{: external} in your {{site.data.keyword.cloud_notm}} account and [configure the service to receive {{site.data.keyword.cloud_notm}} service logs](/docs/services/Log-Analysis-with-LogDNA?topic=LogDNA-config_svc_logs){: new_window}{: external}.

This setting enables logs from **all** {{site.data.keyword.cloud_notm}} services on your account that have {{site.data.keyword.la_full_notm}} integration to send logs to your {{site.data.keyword.la_full_notm}} service. [A list of the integrated services is available](/docs/services/Log-Analysis-with-LogDNA?topic=LogDNA-cloud_services#cloud_services){: new_window}{: external}.
{: .tip}

{{site.data.keyword.la_full_notm}} has a lite plan that is free to use, but it only offers streaming events. To take advantage of the tagging, export, retention, and other features, you need to use one of the [paid plans](/docs/services/Log-Analysis-with-LogDNA?topic=LogDNA-about#overview_pricing_plans){: new_window}{: external}.

### HIPAA 
{: #hipaa_logdna}

{{site.data.keyword.la_full_notm}} does not currently offer a HIPAA-compliant plan for the service. 

Use caution when you configure the platform service logs, since this setting can impact other services that require HIPAA compliance.
{: important}

## Using {{site.data.keyword.la_full_notm}}
{: #using-logdna}

Once logs are being live-streamed, each log can be expanded to a detailed view by clicking the arrow to the left of the timestamp.

The expanded view has some handy, color-coded fields to help you parse your logs. 

Line identifiers | Description
-----------------|------------
`Source` | The region the logs are being sent from.
`App` | The CRN of your database deployment sending the logs. 
{: caption="Table 2. Line identifiers" caption-side="top"}

Log lines | Description
----------|------------
`accountName` | The {{site.data.keyword.cloudant_short_notm}} account identifier that you can use when you contact support about your environment. 
`httpMethod` | Request method, for example, `GET`, `PUT`, to indicate the action to be performed for a given resource.
`httpRequest` | The URL path for the HTTP request. 
`bytesRead`| The size of the response body. 
`clientIp` | The IP address of the originating request. 
`clientPort` | The port address for the originating request. 
`statusCode` | The HTTP status code returned from {{site.data.keyword.cloudant_short_notm}}. For more information see, [HTTP status codes](https://cloud.ibm.com/docs/services/Cloudant?topic=cloudant-http#http-status-codes).
`terminationState` | Session termination indicator for TCP and HTTP logs. For more information, see [Session state at disconnection](https://cbonte.github.io/haproxy-dconv/1.7/configuration.html#8.5){: new_window}{: external}.
`dbName`| The {{site.data.keyword.cloudant_short_notm}} database name targeted by the HTTP Request.  
`dbRequest` | The database request endpoint.
`userAgent` |  Software that is acting on behalf of the user, such as a browser or client library.
`sslVersion` | The version of Transport Layer Security that the request is using. 
`requestClass`| The class of metrics that the request is billed against. `Unlimited` is an unmetered event. For more information, see [Event types](https://cloud.ibm.com/docs/services/Cloudant?topic=cloudant-ibm-cloud-public#event-types){: new_window}{: external}.
`parsedQueryString` | A parsed version showing the breakdown of the parameters passed in the query string. If we are unable to parse the `rawQueryString`, this value will be null.
`rawQueryString` | Full text of the query string as passed to the service.
`logSourceCRN` | The CRN of the {{site.data.keyword.cloudant_short_notm}} instance emitting logs.
`meta`| A line reserved for additional information from {{site.data.keyword.cloudant_short_notm}}.
`timings` |  `connect` - The total time to accept TCP connection and execute handshakes for SSL protocol. This only happens once during the connection's lifetime, so subsequent requests sent over the same connection will show `0` for this value. </br> `request` - The total time to get the client request. It's the time elapsed between the first bytes received and the moment the service receives the last byte of the request body. </br> `transfer`- The data transmission time to transfer the full response from the service to the client. </br> `response`- The total active time for the HTTP request, between the moment the service received the first byte of the request header and the emission of the last byte of the response body.
{: caption="Table 3. Log lines" caption-side="top"}

The `request` and `transfer` timings are included in `response`.  
{: note}

{{site.data.keyword.la_full_notm}} offers [searching](/docs/services/Log-Analysis-with-LogDNA?topic=LogDNA-view_logs#view_logs_step6){: new_window}{: external} and [filtering](/docs/services/Log-Analysis-with-LogDNA?topic=LogDNA-view_logs#view_logs_step5){: new_window}{: external} to help you navigate your logs. [Export](/docs/services/Log-Analysis-with-LogDNA?topic=LogDNA-export#export){: new_window}{: external} and [archive](/docs/services/Log-Analysis-with-LogDNA?topic=LogDNA-archiving#archiving){: new_window}{: external} are available so you can customize retention (and cost) for your use case.
