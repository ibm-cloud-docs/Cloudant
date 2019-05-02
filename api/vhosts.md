---

copyright:
  years: 2015, 2019
lastupdated: "2019-05-03"

keywords: vhost endpoints, list virtual host, create virtual host, delete virtual host

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

<!-- Acrolinx: 2018-11-29 -->

# Virtual hosts
{: #virtual-hosts}

Virtual hosts (vhosts) are a way to make {{site.data.keyword.cloudantfull}} serve data from a different domain
than the one normally associated with your {{site.data.keyword.cloudant_short_notm}} account.
{: shortdesc}

## Removed support for virtual hosts (vhosts) (December 4, 2017)
{: #disabled-vhosts-december-4-2017}

On December 4th, 2017, {{site.data.keyword.cloudant_short_notm}} disabled the virtual host functionality. Support for insecure HTTP connections was removed in favor of HTTPS only. As a result of turning off HTTP support, the virtual hosts feature is no longer available since use of virtual hosts precludes secure HTTPS connections. Previous users of the virtual host feature need to make alternative arrangements to present a chosen host name to your clients from your application and use HTTPS connections only.

## Vhost endpoints
{: #vhost-endpoints}

You can create as many vhosts as needed
and point them to any endpoint in your {{site.data.keyword.cloudant_short_notm}} account.
Vhosts are often used to point to a `_rewrite` endpoint of a design document
in order to use {{site.data.keyword.cloudant_short_notm}} as a web server.
You need to have the admin role in order to use any of the vhost endpoints.

## Listing virtual hosts
{: #listing-virtual-hosts}

To list all virtual hosts in your account,
send a `GET` request to `/_api/v2/user/virtual_hosts`.

The JSON response details all of the virtual hosts,
and any virtual path associated with each host.

*Example request to list all vhosts, using HTTP:*

```http
GET /_api/v2/user/virtual_hosts HTTP/1.1
Host: $ACCOUNT.cloudant.com
```
{: codeblock}

*Example request to list all vhosts, using the command line:*

```sh
curl "https://$ACCOUNT.cloudant.com/_api/v2/user/virtual_hosts"
```
{: codeblock}

*Example response, list all vhosts:*

```json
{
    "virtual_hosts": [
        [
            "system1.business.org", 
            ""
        ], 
        [
            "system2.business.org", 
            "/specificpath"
        ]
    ]
}
```
{: codeblock}

## Creating a virtual host
{: #creating-a-virtual-host}

To create a virtual host,
send a `POST` request to the `/_api/v2/user/virtual_hosts` endpoint,
with a description of the vhost as a JSON object within the request body.
The JSON document contains these fields:

Field  | Purpose
-------|--------
`host` | The domain name you want to use for the vhost.
`path` | An (optional) endpoint in your {{site.data.keyword.cloudant_short_notm}} account the vhost should point to.

*Example request for creating a vhost, using HTTP:*

```http
POST /_api/v2/user/virtual_hosts HTTP/1.1
Host: $ACCOUNT.cloudant.com
Content-Type: application/json
```
{: codeblock}

*Example request for creating a vhost, using the command line:*

```sh
curl "https://$ACCOUNT.cloudant.com/_api/v2/user/virtual_hosts" -X POST -d '@vhost.json' -H 'Content-Type: application/json'
```
{: codeblock}

*Example JSON describing the required vhost:*

```json
{
    "host": "www.example.com",
    "path": "/_api/v2/user/virtual_hosts"
}
```
{: codeblock}

*Example response to request for a vhost:*

```json
{
  "ok": true
}
```
{: codeblock}

## Deleting a virtual host
{: #deleting-a-virtual-host}

To delete a vhost,
send a `DELETE` request to `/_api/v2/user/virtual_hosts`.

Specify the host to delete within the request body,
as shown in the following example.

*Example request for deleting a vhost, using HTTP:*

```http
DELETE /_api/v2/user/virtual_hosts HTTP/1.1
Host: $ACCOUNT.cloudant.com
Content-Type: application/json
```
{: codeblock}

*Example request for deleting a vhost, using the command line:*

```sh
curl "https://account.cloudant.com/_api/v2/user/virtual_hosts" -X DELETE -d '@vhost.json' -H 'Content-Type: application/json'
```
{: codeblock}

*Example JSON describing the vhost to delete:*

```json
{
  "host": "www.example.com"
}
```
{: codeblock}

*Example response to vhost delete request:*

```json
{
  "ok": true
}
```
{: codeblock}
