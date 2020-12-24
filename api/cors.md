---

copyright:
  years: 2015, 2020
lastupdated: "2020-12-23"

keywords: cors, security, configuration endpoints, json format, dashboard, set CORS configuration, read CORS configuration, IBM Cloudant Dashboard

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

<!-- Acrolinx: 2020-04-10 -->

# CORS
{: #cors}

[Cross-origin resource sharing (CORS)](http://www.w3.org/TR/cors/){: new_window}{: external} is a mechanism that allows resources
such as JSON documents in an {{site.data.keyword.cloudantfull}} database to be requested
from JavaScript. The JavaScript is running on a website that is loaded from another domain.
{: shortdesc}

These "cross-domain" requests would normally be forbidden by web browsers. The requests use the [same origin security policy](http://en.wikipedia.org/wiki/Same-origin_policy){: new_window}{: external}.

CORS defines a way in which the browser and the server interact to determine whether or not to allow the request.
For {{site.data.keyword.cloudant_short_notm}},
CORS might be a good solution in the following use cases.

1.	You have a website on `https://www.example.com`,
	and you want scripts on this website that can access data from `https://example.cloudant.com`.
	To make this access possible,
	add `https://www.example.com` to your list of allowed origins.
	The effect is that scripts that are loaded from this domain are then
	permitted to make Ajax requests to your {{site.data.keyword.cloudant_short_notm}} databases.
	By using HTTP authorization with CORS requests,
	users of your application can access only their database.
2.	You want to allow third parties access to your database.
	For example, if you have a database that includes product information
	and you want to give sales partners access to the information from JavaScript running on their domain,
	add their domain to your list of allowed origins.
	The effect is that scripts that run on their website can access your {{site.data.keyword.cloudant_short_notm}} database.

## Browser support
{: #browser-support}

CORS is supported by all current versions of commonly used browsers.

Versions of Microsoft&trade; Internet Explorer before version 10 offer partial support for CORS. Versions of Microsoft&trade; Internet Explorer before version 8 don't support CORS.
{: note}

## Security
{: #security-overview}

Storing sensitive data in databases that can be accessed by using CORS is a potential security risk.
When you place a domain in the list of allowed origins,
you're trusting all the JavaScript from the domain.
If the web application that runs on the domain is running malicious code or has security vulnerabilities,
sensitive data in your database might be exposed.

Also,
allowing scripts to be loaded by using HTTP rather than HTTPS,
and then accessing data by using CORS,
introduces the risk that a man-in-the-middle attack might modify the scripts.

To reduce the risk of man-in-the-middle attacks, follow these guidelines:

-	Don't allow CORS requests from all origins.
	In other words,
	do not set `"origins": ["*"]` unless you're certain that you want to meet the following conditions:
	-	You want to allow all data in your databases to be publicly accessible.
	-	User credentials that give permission to modify data are never used in a browser.
-	Allow CORS requests only from HTTPS origins, not HTTP.
-	Ensure that web applications that run on allowed origin domains are trusted
	and do not have security vulnerabilities.

## Configuration endpoints
{: #configuration-endpoints}

Method | Path                        | Description
-------|-----------------------------|------------
`GET`  | `/_api/v2/user/config/cors` | Returns the current CORS configuration.
`PUT`  | `/_api/v2/user/config/cors` | Changes the CORS configuration.
{: caption="Table 1. Configuration endpoints" caption-side="top"}

## JSON format
{: #json-format}

-	`enable_cors` - Boolean value to turn CORS on and off.
-	`allow_credentials` - Boolean value to allow authentication credentials.
	If set to true,
	browser requests must be done by using `withCredentials = true`.
-	`origins` - An array of strings that contain allowed origin domains.
	You have to specify the full URL including the protocol.
	It is recommended that only the HTTPS protocol is used.
	Subdomains count as separate domains,
	so you have to specify all subdomains used. See the following example request:


## Setting the CORS configuration
{: #setting-the-cors-configuration}

`PUT`ting a JSON document with the example structure to `/_api/v2/user/config/cors` sets the CORS configuration.
The configuration applies to all databases and all account level endpoints in your account.

### Example request that uses HTTP

```http
PUT /_api/v2/user/config/cors HTTP/1.1
Host: $ACCOUNT.cloudant.com
Content-Type: application/json
```
{: codeblock}

### Example request that uses the command line 

```sh
curl "https://$ACCOUNT.cloudant.com/_api/v2/user/config/cors" \
	-H "Content-Type: application/json" \
	-X PUT \
	-T cors.json
```
{: codeblock}

### Example JSON file for setting the CORS configuration

```json
{
	"enable_cors": true,
	"allow_credentials": true,
	"origins": [
		"https://example.com",
		"https://www.example.com"
	]
}
```
{: codeblock}

The response indicates whether the configuration was updated successfully.

### Example response for setting the CORS configuration

```json
{
	"ok": true
}
```
{: codeblock}

## Reading the CORS configuration
{: #reading-the-cors-configuration}

You can find out the current CORS configuration by sending a `GET` to the `/_api/v2/user/config/cors` endpoint.

### Example request to `GET` the current CORS configuration that uses HTTP

```http
GET /_api/v2/user/config/cors HTTP/1.1
Host: username.cloudant.com
```
{: codeblock}

### Example request to `GET` the current CORS configuration that uses the command line

```sh
curl "https://$ACCOUNT.cloudant.com/_api/v2/user/config/cors"
```
{: codeblock}

The response is the current CORS configuration in a JSON document.

### Example response to `GET` the current CORS configuration

```json
{
	"enable_cors": true,
	"allow_credentials": true,
	"origins": [
		"https://example.com",
		"https://www.example.com"
	]
}
```
{: codeblock}

## Dashboard
{: #dashboard}

CORS support is available in the {{site.data.keyword.cloudant_short_notm}} Dashboard.

You can update your CORS settings by using the CORS tab within the dashboard:

![CORS dashboard illustration](../images/corsdashboard.png){: caption="Figure 1. CORS dashboard illustration" caption-side="bottom"}

To see the current CORS configuration,
simply open the CORS tab in the dashboard.

You can enable or disable CORS by using the `Enable CORS` check box.
This setting corresponds to the [`enable_cors` option](#configuration-endpoints)
when you change the CORS configuration from within an application.

To specify that CORS is enabled for all domains,
select the `All domains (*)` option.

To specify that CORS is enabled only for exact origin domains,
list each of the domains or subdomains by using the `Restrict to specific domains` option.
For each domain,
provide a full URL,
preferably by using the `https` prefix for better security.
