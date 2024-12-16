---

copyright:
  years: 2015, 2024
lastupdated: "2024-12-03"

keywords: logs, integration, provisioning, cloud log, hipaa, logs routing 

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# {{site.data.keyword.logs_full_notm}} integration
{: #log-analysis-integration}

{{site.data.keyword.cloudantfull}} is integrated with [{{site.data.keyword.logs_full}}](/docs/cloud-logs?topic=cloud-logs-about-cl){: external}, so you can view database logs.
{: shortdesc}

Currently, {{site.data.keyword.logs_full_notm}} integration is available for {{site.data.keyword.cloudant_short_notm}} deployments according to the following table:

| Deployment Region | {{site.data.keyword.logs_full_notm}} Region |
|-------------------|---------------------------------------------|
| `Chennai`         | `Chennai`                                   |
| `Dallas`          | `Dallas`                                    |
| `Frankfurt`       | `Frankfurt`                                 |
| `London`          | `London`                                    |
| `Osaka`           | `Tokyo`                                     |
| `São Paulo`       | `São Paulo`                                 |
| `Sydney`          | `Sydney`                                    |
| `Tokyo`           | `Tokyo`                                     |
| `Toronto`         | `Toronto`                                   |
| `Washington DC`   | `Washington DC`                             |
| `Madrid`          | `Madrid`                                    |
{: caption="{{site.data.keyword.logs_full_notm}} regions" caption-side="top"}

## Provisioning {{site.data.keyword.logs_full_notm}}
{: #provisioning-cloud-logs}

Log information from your databases is automatically forwarded to {{site.data.keyword.logs_routing_full_notm}}. In order to access it, you must [provision {{site.data.keyword.logs_full_notm}}](/catalog/services/cloud-logs){: external} in your {{site.data.keyword.cloud_notm}} account and [configure the service](/docs/cloud-logs?topic=cloud-logs-getting-started){: external} to receive {{site.data.keyword.cloud_notm}} service logs.

### HIPAA
{: #hipaa_log-analysis}

{{site.data.keyword.logs_full_notm}} does not currently offer a HIPAA-compliant plan for the service.

Use caution when you configure the platform service logs, since this setting can impact other services that require HIPAA compliance.
{: important}

## Using {{site.data.keyword.logs_full_notm}}
{: #using-cloud-logs}

Once logs are being routed to the {{site.data.keyword.logs_full_notm}} instances, each log can be viewed in detail. With the following values being delivered: 

| Line Identifiers | Description                                                   |
|------------------|---------------------------------------------------------------|
| `Source`         | The region the logs are being sent from.                      |
| `App`            | The CRN of your database deployment that is sending the logs. |
{: caption="Line identifiers" caption-side="top"}

| Log Lines           | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|---------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `accountName`       | The {{site.data.keyword.cloudant_short_notm}} account identifier that you can use when you contact support about your environment.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| `httpMethod`        | Request method, for example, `GET`, `PUT`, to indicate the action to be performed for a specific resource.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| `httpRequest`       | The URL path for the HTTP request.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| `bytesRead`         | The size of the response body.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| `clientIp`          | The IP address of the originating request.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| `clientPort`        | The port address for the originating request.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| `statusCode`        | The HTTP status code returned from {{site.data.keyword.cloudant_short_notm}}. For more information, see [HTTP status codes](/apidocs/cloudant#list-of-http-codes){: external}.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| `terminationState`  | Session termination indicator for TCP and HTTP logs. For more information, see [Session state at disconnection](https://cbonte.github.io/haproxy-dconv/1.7/configuration.html#8.5){: external}.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| `dbName`            | The {{site.data.keyword.cloudant_short_notm}} database name targeted by the HTTP Request.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| `dbRequest`         | The database request endpoint.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| `userAgent`         | Software that is acting on behalf of the user, such as a browser or client library.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| `sslVersion`        | The version of Transport Layer Security that the request is using.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| `cipherSuite`       | The cipher suite used for the request.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| `requestClass`      | The class of metrics that the request is billed against. `Unlimited` is an unmetered event. For more information, see [Request classes](/docs/Cloudant?topic=Cloudant-ibm-cloud-public#request-classes){: external}.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| `parsedQueryString` | A parsed version that shows the breakdown of the parameters that are passed in the query string. If {{site.data.keyword.cloudant_short_notm}} cannot parse the `rawQueryString`, this value is null.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| `rawQueryString`    | Full text of the query string as passed to the service.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| `logSourceCRN`      | The CRN of the {{site.data.keyword.cloudant_short_notm}} instance emitting logs.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| `meta`              | A line reserved for additional information from {{site.data.keyword.cloudant_short_notm}}.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| `timings`           | `connect` - The total time to accept TCP connection and execute handshakes for SSL protocol. This time happens only once during the connection's lifetime, so subsequent requests that are sent over the same connection show `0` for this value.  \n `request` - The total time to get the client request. It's the time that is elapsed between the first bytes received and the moment the service receives the last byte of the request body.  \n `transfer`- The data transmission time to transfer the full response from the service to the client.  \n  `response`- The total active time for the HTTP request, between the moment the service received the first byte of the request header and the emission of the last byte of the response body. |
{: caption="Log lines" caption-side="top"}

The `request` and `transfer` timings are included in `response`.
{: note}

{{site.data.keyword.logs_full_notm}} offers [querying](/docs/cloud-logs?topic=cloud-logs-query-data#query-data-ui){: external} and [filtering](/docs/cloud-logs?topic=cloud-logs-query-data-filter){: external} to help you navigate your logs. [Export](/docs/cloud-logs?topic=cloud-logs-data-portability#data-portability-procedures){: external}, COS [archiving](/docs/cloud-logs?topic=cloud-logs-about-bucket){: external} and multiple levels of indexing are available, so you can optimize the total cost of log streams for your use case.