---

copyright:
  years: 2023
lastupdated: "2023-02-21"

keywords: HTTP, HTTPS, replication, deprecation notice

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# {{site.data.keyword.cloudant_short_notm}} replications no longer support HTTP
{: #replications-no-longer-support-http}

As of 1 July 2023, {{site.data.keyword.cloudantfull}}'s replicator no longer supports the HTTP protocol – it only supports the HTTPS protocol to ensure that customer data is always encrypted in flight.

## What is replication?
{: #what-is-replication}

{{site.data.keyword.cloudant_short_notm}} replications allow a database's changes to be copied to another {{site.data.keyword.cloudant_short_notm}} database, which can be a database in the same {{site.data.keyword.cloudant_short_notm}} instance or in another {{site.data.keyword.cloudant_short_notm}} instance on the other side of the world. {{site.data.keyword.cloudant_short_notm}} also replicates to and from Apache CouchDB and PouchDB databases on the public internet.

## What happens after HTTP support is removed?
{: #after-http-support-is-removed}

Following this change, a replication configured with the `http://` protocol fails permanently. The replication job is not retried. Any replications using the `https://` protocol are unaffected.

## How do I know if my replications use HTTP?
{: #how-do-i-check-my-http-use}

Replication job definitions are stored in documents in an {{site.data.keyword.cloudant_short_notm}} account's `_replicator` database, for example:

```js
{
  "_id": "myreplicationjob",
  "source": "https://mycloudantservice.cloudant.com/products",
  "target": "http://myselfhostedcouchdb.mydomain.com/products"
}
```
{: codeblock}

If either the `source` or `target` URLs contain an `http://` prefix, then **the replication job is affected** and action must be taken to keep the replications running.

## How do I avoid being affected?
{: #how-can-i-avoid-being-affected}

If a self-hosted CouchDB service supports HTTPS, then change the replication definition to contain an `https://` prefix, as shown in the following example:

```js
{
  "_id": "myreplicationjob",
  "source": "https://mycloudantservice.cloudant.com/products",
  "target": "https://myselfhostedcouchdb.mydomain.com/products"
}
```
{: codeblock}

{{site.data.keyword.cloudant_short_notm}} restarts the replication from where the old replication job stopped.

If a self-hosted CouchDB service does _not_ support HTTPS, CouchDB can mediate replication jobs instead of {{site.data.keyword.cloudant_short_notm}}. For example, stop the replication job running on the {{site.data.keyword.cloudant_short_notm}} side and set up a replication job on a self-hosted Apache CouchDB service to "pull" the data from {{site.data.keyword.cloudant_short_notm}}.

{{site.data.keyword.cloudant_short_notm}} only supports `https://` traffic, so if {{site.data.keyword.cloudant_short_notm}} is to be the `source` or `target` in a self-hosted replication definition, it must be configured with an `https://` prefix.
