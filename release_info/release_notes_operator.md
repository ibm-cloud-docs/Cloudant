---

copyright:
  years: 2015, 2021
lastupdated: "2021-11-30"

keywords: Cloudant, release notes, partition query, dedicated hardware plan, couchdb 

subcollection: Cloudant

content-type: release-note

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
{{site.data.keyword.attribute-definition-list}}
{:release-note: data-hd-content-type='release-note'}

# Release notes for the Operator for Apache CouchDB
{: #operator-apache-couchdb-rn}

Use these release notes to learn about the latest updates to {{site.data.keyword.cloudant_short_notm}} that are grouped by date and build number.
{: shortdesc}

## November 2020
{: #cloudant-operator-nov20}


### 30 November 2020
{: #cloudant-operator-nov0920}
{: release-note}

The following changes were made in build 1.4.2:

Memory leak
:   Fixes memory leak in the `mgmt` container.

### 9 November 2020
{: #cloudant-operator-nov0120}
{: release-note}

The following changes were made in build 1.4.1:

Permissions
:   Fixes permissions issue with `pre_stop` scripts.
 
## October 2020
{: #cloudant-operator-oct20}

### 30 October 2020
{: #cloudant-operator-oct3020}
{: release-note}

The following changes were made in build 1.4.0:

Operator upgrade
:   This bug fix release addresses an issue that occurs during upgrades to operator versions *1.2* and *1.3*, whereby pods can get into an unrecoverable state. An upgrade to version *1.4* forces the images to upgrade to the supported version, which resolves this problem.

Syntax error
:   Fixes syntax error in `pre_stop` script.

Resource leak
:   Fixes resource leak in health check.

Symlink creation error
: Fixes symlink creation error when init container is restarted.

### 23 October 2020 
{: #cloudant-operator-oct2320}
{: release-note}

The following changes were made in build 1.3.0:

CouchDB updates
:   Updates CouchDB to [3.1.1](https://docs.couchdb.org/en/latest/whatsnew/3.1.html#version-3-1-1).

Logging output
:   Improves logging output for `runit`.

CouchDB improvement
:   CouchDB no longer stops when the search container restarts.

`findmnt` error
:   Fixes missing `findmnt` error in the `mgmt` container.

## September 2020
{: #cloudant-operator-sept20}

### 15 September 2020
{: #cloudant-operator-sep1520}
{: release-note}

The following changes were made in build 1.2.1:

Configuration files creation
:   Configuration files are incorrectly created with read-only file permissions.

### 14 September 2020
{: #cloudant-operator-sep1420}
{: release-note}

The following changes were made in build 1.2.0:

Configuration options
:   Adds a number of configuration options to the search container, enabled by using v1.5.0 of the management container.

New fields for CouchDBCluster 
:   The following new, optional fields are added to the CouchDBCluster CRD:    
- `spec.environment.clouseau.logLevel`    
- `spec.environment.clouseau.maxIndexesOpen`    
- `spec.environment.clouseau.closeIfIdle`    
- `spec.environment.clouseau.idleCheckIntervalSecs`    

Search container
:   This bug fix release fixes a performance regression in the search container that is caused by debug-level logs being enabled by default.
- CouchDB Search must not log at `DEBUG` level by default. This following bug fix also fixes a performance regression in the search container that is caused by debug-level logs being enabled by default.

## August 2020
{: #cloudant-operator-aug20}

### 17 August 2020
{: #cloudant-operator-aug1720}
{: release-note}

The following changes were made in build 1.1.0:

New! Introducing the Operator and its functions
:   Adds more configuration for resource management, including the ability to set resource constraints on the CouchDB containers:

- The following new, optional fields are added to the CouchDBCluster CRD:    

- `spec.securityContext`    
- `spec.resources`    

Erlang scheduler count
:   Erlang scheduler count is based on the database container CPU requests, rounded up to the nearest integer.

Liveness check
:   Adds a liveness check so that search containers restart if they lose connectivity to the CouchDB node. This situation can happen if the CouchDB container is restarted by the OOMkiller.

Memory settings
:   JVM now uses cgroup aware memory settings.

CouchDBClusters support
:   Support CouchDBClusters deployed to the same namespace.

CouchDBCluster propagates to CouchDB nodes
:   Changes to the CouchDBCluster CRD now propagate to CouchDB nodes without a manual pod restart.

Resource constraints
:   Adds option to set resource constraints for CouchDB containers.

securityContext 
:   Adds option to set securityContext for the CouchDBCluster pods.

Resource limits and requests
:   Resource limits and requests propagate correctly to the search container.

## September 2019
{: #cloudant-operator-sep19}

### 16 September 2019
{: #cloudant-operator-sep1619}
{: release-note}

New! Introducing Apache CouchDB and the Operator
:   The Operator for Apache CouchDB facilitates deploying and managing an Apache CouchDB cluster on Kubernetes. Currently, the Operator is targeted at Red Hat OpenShift environments. For more information, see [Overview of Apache CouchDB and the Operator](https://cloud.ibm.com/docs/Cloudant?topic=Cloudant-apache-couchdb-overview){: external}.
