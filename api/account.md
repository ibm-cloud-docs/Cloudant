---

copyright:
  years: 2015, 2020
lastupdated: "2020-01-20"

keywords: account, ping, ping account, cors, connect to your cloudant account

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

<!-- Acrolinx: 2019-09-06 -->

# Account
{: #account}

Your account is your entry point for the {{site.data.keyword.cloudantfull}} API.
You access your account by using the address prefix
`https://$ACCOUNT.cloudant.com`.
Your {{site.data.keyword.cloudant_short_notm}} Dashboard is always
`https://$ACCOUNT.cloudant.com/dashboard.html`.
{: shortdesc}

If you don't yet have an account, [sign up](https://cloudant.com/sign-up/){: new_window}{: external}.

## Ping
{:  #ping}

To see whether your {{site.data.keyword.cloudant_short_notm}} account is accessible,
make a `GET` against `https://$ACCOUNT.cloudant.com`.
If you misspelled your account name,
you might get a [503 'service unavailable' error](/docs/Cloudant?topic=cloudant-http#http-status-codes).

See the following example about connecting to your {{site.data.keyword.cloudant_short_notm}} account by using HTTP:

```HTTP
GET / HTTP/1.1
HOST: $ACCOUNT.cloudant.com
```
{: codeblock}

See the following example about connecting to your {{site.data.keyword.cloudant_short_notm}} account by using the command line:

```sh
curl -u $ACCOUNT "https://$ACCOUNT.cloudant.com"
```
{: codeblock}

<!--

*See the following example about connecting to your {{site.data.keyword.cloudant_short_notm}} account by using Javascript:*

```javascript
var nano = require('nano');
var account = nano("https://$ACCOUNT:$PASSWORD@$ACCOUNT.cloudant.com");
account.request(function (err, body) {
	if (!err) {
		console.log(body);
	}
});
```
{: codeblock}

-->

See the following example about connecting to your {{site.data.keyword.cloudant_short_notm}} account by using Python:

```python
import cloudant
account = cloudant.Account(USERNAME)
ping = account.get()
print ping.status_code
# Expected return code: 200
```
{: codeblock}

## CORS
{: #cors-overview}

[Cross-origin resource sharing (CORS)](http://www.w3.org/TR/cors/){: new_window}{: external} is a
mechanism that allows JavaScript from another domain to interact with data in
your {{site.data.keyword.cloudant_short_notm}} account.

For more information about CORS and {{site.data.keyword.cloudant_short_notm}}, see the [CORS](/docs/Cloudant?topic=cloudant-cors#cors) documentation.
