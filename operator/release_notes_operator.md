---

copyright:
  years: 2020, 2021
lastupdated: "2021-04-19"

keywords: couchdb, operator, release notes

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

<!-- Acrolinx: 2021-04-19 -->

# Release notes
{: #release-notes-couchdb-operator}

Changes and updates to Operator for Apache CouchDB that are grouped by version number.
{: shortdesc}

## v1.4.2 (30 November 2020)
{: #v1.4.2}

### Bug fixes
{: #bug-fixes-142}

 - Fixes memory leak in the `mgmt` container.

## v1.4.1 (9 November 2020)
{: #v1.4.1}

### Bug fixes
{: #bug-fixes-141}

 - Fixes permissions issue with `pre_stop` scripts.
 
## v1.4.0 (30 October 2020)
{: #v1.4.0}

This bug fix release addresses an issue that occurs during upgrades to operator versions *1.2* and *1.3*, whereby pods can get into an unrecoverable state. An upgrade to version *1.4* forces the images to upgrade to the supported version, which resolves this problem.

### Bug fixes
{: #bug-fixes-140}

 - Fixes syntax error in `pre_stop` script.
 - Fixes resource leak in health check.
 - Fixes symlink creation error when init container is restarted.

## v1.3.0 (23 October 2020)
{: #v1.3.0}

 - Updates CouchDB to [3.1.1](https://docs.couchdb.org/en/latest/whatsnew/3.1.html#version-3-1-1).
 - Improves logging output for `runit`.

### Bug fixes
{: #bug-fixes-130}

 - CouchDB no longer stops when the search container restarts.
 - Fixes missing `findmnt` error in the `mgmt` container.

## v1.2.1 (15 September 2020)
{: #v1.2.1}

### Bug fixes
{: #bug-fixes-121}

 - Configuration files are incorrectly created with read-only file permissions.

## v1.2.0 (14 September 2020)
{: #v1.2.0}

Adds a number of configuration options to the search container, enabled by using v1.5.0 of the management container.

This bug fix release also fixes a performance regression in the search container that is caused by debug-level logs being enabled by default.

The following new, optional fields are added to the CouchDBCluster CRD:

 - `spec.environment.clouseau.logLevel`
 - `spec.environment.clouseau.maxIndexesOpen`
 - `spec.environment.clouseau.closeIfIdle`
 - `spec.environment.clouseau.idleCheckIntervalSecs`

### Bug fixes
{: #bug-fixes-120}

- CouchDB Search must not log at `DEBUG` level by default.

## v1.1.0 (17 August 2020)
{: #v1.1.0}

Adds more configuration for resource management, including the ability to set resource constraints on the CouchDB containers.

The following new, optional fields are added to the CouchDBCluster CRD:

 - `spec.securityContext`
 - `spec.resources`

### Enhancements

 - Erlang scheduler count is based on the database container CPU requests, rounded up to the nearest integer.
 - Adds a liveness check so that search containers restart if they lose connectivity to the CouchDB node. This situation can happen if the CouchDB container is restarted by the OOMkiller.
 - JVM now uses cgroup aware memory settings.
 - Support CouchDBClusters deployed to the same namespace.
 - Changes to the CouchDBCluster CRD now propagate to CouchDB nodes without a manual pod restart.
 - Adds option to set resource constraints for CouchDB containers.
 - Adds option to set securityContext for the CouchDBCluster pods.

### Bug fixes
{: #bug-fixes-110}

 - Resource limits and requests propagate correctly to the search container.
