---

copyright:
  years: 2019
lastupdated: "2019-09-24"

keywords: apache couchdb, support, extension, containers

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

# Install
{: #apache-couchdb-install}

The current GA release is Apache CouchDB version 2.3.1. For more information, see the [Apache CouchDB documentation](http://docs.couchdb.org/en/stable/){: new_window}{: external}.  

The [Download CouchDB](http://couchdb.apache.org/#download){: new_window}{: external} site contains links to install CouchDB on the following platforms:

- Windows (x86)
- macOS
- Linux: Debian/Ubuntu/RHEL/CentOS

## Containers
{: #containers}

### Docker Hub

The Apache CouchDB docker image is available on [Docker Hub](https://hub.docker.com/_/couchdb){: new_window}{: external}, along with [Apache CouchDB documentation](https://docs.couchdb.org/en/stable/install/docker.html){: new_window}{: external}. 

### Red Hat Container catalog

See the [Apache CouchDB Product overview](https://access.redhat.com/containers/#/product/a03d4d299abe60e9){: new_window}{: external} on the Red Hat Container catalog for a Red Hat-certified image. 

## Kubernetes
{: #kubernetes}

### Operator

The [Operator for Apache CouchDB](/docs/services/Cloudant?topic=cloudant-overview-apache-couchdb-operator) deploys and manages Apache CouchDB clusters on Kubernetes. 

### Helm Chart

An Apache CouchDB helm chart along with documentation is available on [Helm Hub](https://hub.helm.sh/charts/stable/couchdb){: new_window}{: external}. 
