---

copyright:
  years: 2015, 2023
lastupdated: "2023-02-07"

keywords: log analysis, integration, provisioning log analysis, hipaa

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# {{site.data.keyword.loganalysisfull_notm}} integration
{: #log-analysis-integration}

{{site.data.keyword.cloudantfull}} is integrated with [{{site.data.keyword.loganalysisfull}}](https://cloud.ibm.com/catalog/services/ibm-log-analysis-with-logdna){: external}, so you can view database logs.
{: shortdesc}

Currently, {{site.data.keyword.loganalysisfull_notm}} integration is available for {{site.data.keyword.cloudant_short_notm}} deployments according to the following table:

| Deployment Region | {{site.data.keyword.loganalysisfull_notm}} Region |
|----------|-----------|
| `Chennai` | `Chennai` |
| `Dallas` | `Dallas` |
| `Frankfurt` | `Frankfurt` |
| `London` | `London` |
| `Osaka` | `Tokyo` |
| `São Paulo` | `São Paulo` |
| `Sydney` | `Sydney` |
| `Tokyo` | `Tokyo` |
| `Toronto` | `Toronto` |
| `Washington DC` | `Washington DC` |
{: caption="{{site.data.keyword.loganalysisfull_notm}} regions" caption-side="top"}

## Provisioning {{site.data.keyword.loganalysisfull_notm}}
{: #provisioning-log-analysis}

Log information from your databases is automatically forwarded to {{site.data.keyword.loganalysisfull_notm}}. In order to access it, you must [provision {{site.data.keyword.loganalysisfull_notm}}](/catalog/services/ibm-log-analysis-with-logdna){: external} in your {{site.data.keyword.cloud_notm}} account and [configure the service](/docs/log-analysis?topic=log-analysis-config_svc_logs){: external} to receive {{site.data.keyword.cloud_notm}} service logs.

This setting enables logs from **all** {{site.data.keyword.cloud_notm}} services on your account with {{site.data.keyword.loganalysisfull_notm}} integration sending logs to your {{site.data.keyword.loganalysisfull_notm}} service. For more information, see the list of [integrated services](/docs/log-analysis?topic=log-analysis-cloud_services#cloud_services){: external}.
{: .tip}

{{site.data.keyword.loganalysisfull_notm}} has a Lite plan that is free to use, but it offers only streaming events. To take advantage of the tagging, export, retention, and other features, you need to use one of the [paid plans](/docs/log-analysis?topic=log-analysis-service_plans){: external}.

### HIPAA
{: #hipaa_log-analysis}

{{site.data.keyword.loganalysisfull_notm}} does not currently offer a HIPAA-compliant plan for the service.

Use caution when you configure the platform service logs, since this setting can impact other services that require HIPAA compliance.
{: important}

## Using {{site.data.keyword.loganalysisfull_notm}}
{: #using-log-analysis}

Once logs are being live-streamed, each log can be expanded to a detailed view by clicking the arrow by the timestamp.

The expanded view has some handy, color-coded fields to help you parse your logs.

| Line Identifiers | Description |
|-----------------|------------|
| `Source` | The region the logs are being sent from. |
| `App` | The CRN of your database deployment that is sending the logs. |
{: caption="Line identifiers" caption-side="top"}

| Log Lines | Description |
|----------|------------|
| `accountName` | The {{site.data.keyword.cloudant_short_notm}} account identifier that you can use when you contact support about your environment. |
| `httpMethod` | Request method, for example, `GET`, `PUT`, to indicate the action to be performed for a specific resource. |
| `httpRequest` | The URL path for the HTTP request. |
| `bytesRead`| The size of the response body. |
| `clientIp` | The IP address of the originating request. |
| `clientPort` | The port address for the originating request. |
| `statusCode` | The HTTP status code returned from {{site.data.keyword.cloudant_short_notm}}. For more information, see [HTTP status codes](/apidocs/cloudant#list-of-http-codes){: external}.|
| `terminationState` | Session termination indicator for TCP and HTTP logs. For more information, see [Session state at disconnection](https://cbonte.github.io/haproxy-dconv/1.7/configuration.html#8.5){: external}.|
| `dbName`| The {{site.data.keyword.cloudant_short_notm}} database name targeted by the HTTP Request. |
| `dbRequest` | The database request endpoint. |
| `userAgent` |  Software that is acting on behalf of the user, such as a browser or client library. |
| `sslVersion` | The version of Transport Layer Security that the request is using. |
| `cipherSuite` | The cipher suite used for the request. |
| `requestClass`| The class of metrics that the request is billed against. `Unlimited` is an unmetered event. For more information, see [Request classes](/docs/Cloudant?topic=Cloudant-ibm-cloud-public#request-classes){: external}. |
| `parsedQueryString` | A parsed version that shows the breakdown of the parameters that are passed in the query string. If {{site.data.keyword.cloudant_short_notm}} cannot parse the `rawQueryString`, this value is null. |
| `rawQueryString` | Full text of the query string as passed to the service. |
|`logSourceCRN` | The CRN of the {{site.data.keyword.cloudant_short_notm}} instance emitting logs. |
| `meta`| A line reserved for additional information from {{site.data.keyword.cloudant_short_notm}}. |
| `timings` |  `connect` - The total time to accept TCP connection and execute handshakes for SSL protocol. This time happens only once during the connection's lifetime, so subsequent requests that are sent over the same connection show `0` for this value.  \n `request` - The total time to get the client request. It's the time that is elapsed between the first bytes received and the moment the service receives the last byte of the request body.  \n `transfer`- The data transmission time to transfer the full response from the service to the client.  \n  `response`- The total active time for the HTTP request, between the moment the service received the first byte of the request header and the emission of the last byte of the response body. |
{: caption="Log lines" caption-side="top"}

The `request` and `transfer` timings are included in `response`.
{: note}

{{site.data.keyword.loganalysisfull_notm}} offers [searching](/docs/log-analysis?topic=log-analysis-view_logs#view_logs_step6){: external} and [filtering](/docs/log-analysis?topic=log-analysis-view_logs#view_logs_step5){: external}
to help you navigate your logs. [Export](/docs/log-analysis?topic=log-analysis-export#export){: external} and [archive](/docs/log-analysis?topic=log-analysis-archiving#archiving){: external} are available so you can customize retention (and cost) for your use case.
