---

copyright:
  years: 2019, 2020
lastupdated: "2020-02-21"

keywords: troubleshoot, view logs, adjust log level

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

Learn how to troubleshoot the Operator for Apache CouchDB by using logs and adjusting the log level. 
{: shortdesc}

## Viewing the Operator for Apache CouchDB logs
{: #view-operator-couchdb-logs}

You can view the Operator logs by using the following command:
```sh
kubectl logs -l name=couchdb-operator --namespace=my-couchdb
```
{: codeblock}

## Adjusting the log level of the Operator for Apache CouchDB
{: #adjust-log-level-operator-couchdb}

You can enable verbose logging by passing the `--v` argument to the operator. For example, to set the log level to `4`, run the following command:

```sh
kubectl patch deployment couchdb-operator --namespace my-couchdb --type='json' -p '{"spec":{"template":{"spec":{"containers":[{"name":"couchdb-operator", "args": ["--v=4"]}]}}}}'
```
{: codeblock}
