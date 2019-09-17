---

copyright:
  years: 2019
lastupdated: "2019-09-19"

keywords: logs

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

<!-- Acrolinx: 2017-05-10 -->

# Troubleshooting the CouchDB Operator
{: #troubleshoot-couchdb-operator}

## Viewing the Operator for Apache CouchDB logs
{: #view-operator-couchdb-logs}

You can view the Operator logs by using the following command:

```
kubectl logs -l name=couchdb-operator --namespace=my-couchdb
```
{: codeblock}

## Adjusting the log level of the Operator for Apache CouchDB
{: #adjust-log-level-operator-couchdb}

You can enable verbose logging by passing the `--v` argument to the operator. For example, to set the log level to `4`, run the following command:

```
kubectl patch deployment couchdb-operator --namespace my-couchdb --type='json' -p '{"spec":{"template":{"spec":{"containers":[{"name":"couchdb-operator", "args": ["--v=4"]}]}}}}'
```
{: codeblock}