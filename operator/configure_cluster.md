---

copyright:
  years: 2019, 2020
lastupdated: "2020-09-22"

keywords: operator, field reference

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

<!-- Acrolinx: 2020-03-19 -->

# Configuring a CouchDB cluster
{: #configure-couchdb-cluster}

The Operator for Apache CouchDB allows for user-defined configuration parameters that define how an Apache CouchDB cluster is deployed in Kubernetes.  
{: shortdesc}

## CouchDB versions
{: #couchdb-versions}

{{site.data.keyword.IBM}} maintains operator-compatible container images for the stable [`2.x`](https://hub.docker.com/r/ibmcom/couchdb2){: new_window}{: external} and [`3.x`](https://hub.docker.com/r/ibmcom/couchdb3){: new_window}{: external} versions of CouchDB. The operator maintains a mapping of CouchDB versions to image digests in a [ConfigMap](https://kubernetes.io/docs/concepts/configuration/configmap/){: new_window}{: external} called `couchdb-release`. The mapping is updated when a new version of the operator is deployed. The mappings are static for any given version of the operator.

All `CouchDBCluster` resources managed by an operator are updated to match the set of images referenced in the ConfigMap according to their version. Upgrades are performed in place using a rolling update to minimize service interruption.

By default, a `CouchDBCluster` will use the `3.x` images. If you want to use version `2.3.1` explicitly, you can set the `spec.version` field:

```
apiVersion: couchdb.databases.cloud.ibm.com/v1
kind: CouchDBCluster
metadata:
  name: "example-couchdbcluster"
spec:
  version: "2.3.1"
```
{: codeblock}

Users of CouchDB 2 are strongly encouraged to upgrade to CouchDB 3 by either removing the deprecated `spec.version` field or setting it to `3`. This upgrade can be performed in place, though it's recommended to take a backup first.

## Cluster size and scaling
{: #couchdb-sizing}

By default, a `CouchDBCluster` will be deployed with 3 database nodes. This can be overridden by specifying the `spec.size ` field. Since CouchDB stores 3 replicas of each shard, it is recommended to use multiples of `3` for this value. Also note that this must be less than or equal to the number of nodes in the Kubernetes cluster because the operator specifies an anti-affinity rule that prohibits more than one CouchDB database node per Kubernetes cluster node for high availability and disaster recovery purposes.

Scaling CouchDB clusters is not supported. Whilst the `CouchDBCluster` resource allows the `size` to be changed, it is strongly recommended that you do not alter this after the initial deployment. The operator *does not* perform any data rebalancing to take advantage of additional CouchDB nodes and does not prevent data loss in the event that nodes are removed.

```
apiVersion: couchdb.databases.cloud.ibm.com/v1
kind: CouchDBCluster
metadata:
  name: "example-couchdbcluster"
spec:
  size: 6
```
{: codeblock}

For development and testing purposes, the `spec.devMode` field can be set to `true`. This disables the anti-affinity rules, allowing multi-node clusters to be deployed to a single-node test environment (for example, [KinD](https://kind.sigs.k8s.io/docs/user/quick-start/){: new_window}{: external} / [CodeReady containers](https://developers.redhat.com/products/codeready-containers){: new_window}{: external}.


## Persistent storage
{: #couchdb-storage}

Persistent storage can be attached by specifying the `spec.storageClass` field. To work with the CouchDB Operator, storage classes must support the following:

 * Dynamic volume provisioning.
 * `ReadWriteOnce` access modes.
 * `volumeBindingMode: WaitForFirstConsumer` (zone-local storage)
 * POSIX filesystem compatibility (e.g. not NFS).

This maps to the following preferred options for common public cloud environments:

|Provider |Type|Storage Class|Docs|
|---------|----|---------|----|
|IBM Cloud|IBM Block Storage|ibm-block-*  |[Docs](https://cloud.ibm.com/docs/containers?topic=containers-block_storage){: new_window}{: external}
|AWS      |Elastic Block Storage|aws-ebs      |[Docs](https://docs.openshift.com/container-platform/4.4/storage/dynamic-provisioning.html#aws-definition_dynamic-provisioning){: new_window}{: external}|
|Azure    |Azure Disk|default or managed-premium|[Docs](https://kubernetes.io/docs/concepts/storage/storage-classes/#azure-disk){: new_window}{: external}|

For GCE, Persistent Disk can be used but a [storage class](https://docs.openshift.com/container-platform/4.4/storage/dynamic-provisioning.html#gce-persistentdisk-storage-class_dynamic-provisioning){: new_window}{: external} must be manually created to support dynamic provisioning.

For on-premise deployments, the following storage providers meet these requirements:

 * [vSphere](https://vmware.github.io/vsphere-storage-for-kubernetes/documentation/policy-based-mgmt.html){: new_window}{: external}
 * [Ceph RBD](https://docs.openshift.com/container-platform/3.5/install_config/storage_examples/ceph_rbd_dynamic_example.html){: new_window}{: external}
 * [GlusterFS](https://kubernetes.io/docs/concepts/storage/storage-classes/#glusterfs){: new_window}{: external}
 * [Portworx](https://kubernetes.io/docs/concepts/storage/storage-classes/#portworx-volume){: new_window}{: external}

### Changing the pod UID/GID
{: #change-pod-uid-gid}

Unless overridden by the environment (for example, OpenShift sets these automatically), the `CouchDBCluster` uses the following UID/GID settings in the pod `securityContext`:

```
securityContext:
  runAsUser: 1001
  runAsGroup: 0
  fsGroup: 0
```
{: codeblock}

In most cases, the default values combined with a dynamic provisioner will configure the correct file permissions for persistent volumes.

To override the defaults, you can specify `runAsUser` and `fsGroup` in the  `spec.securityContext`:

```
apiVersion: couchdb.databases.cloud.ibm.com/v1
kind: CouchDBCluster
metadata:
  name: "example-couchdbcluster"
spec:
  securityContext:
    runAsUser: 1001
    fsGroup: 1000160000
  ...
```
{: codeblock}

`securityContext.runAsGroup` is not configurable - it is always `root(0)`.


## Resource requests / limits
{: #couchdb-resources}

For most use cases, the `spec.cpu` and `spec.memory` fields can be used to specify the database CPU and memory allocations. These fields correspond to the resource requests for the database container. By default, there are no resource limits.

If per-container resource requests / limits are required, you can specify these explicitly in the `spec.resources` field:

```
apiVersion: couchdb.databases.cloud.ibm.com/v1
kind: CouchDBCluster
metadata:
  name: "example-couchdbcluster"
spec:
  resources:
    db:
      requests:
        memory: "2Gi"
        cpu: "4"
      limits:
        memory: "2Gi"
        cpu: "4"
    search:
      requests:
        memory: "2Gi"
        cpu: "2"
      limits:
        memory: "2Gi"
        cpu: "2"
    mgmt:
      requests:
        memory: "64Mi"
        cpu: "250m"
      limits:
        memory: "128Mi"
        cpu: "500m"
  ...
```
{: codeblock}

The `init` container uses the same resource requests as the `mgmt` container.


### CouchDBCluster field reference
{: #couchdb-cluster-field-reference}

The CouchDBCluster field reference section defines the major parameters on how Apache CouchDB deploys in the Kubernetes environment.

{: note} 

| Name           | Description                                          | Default    |
|----------------|------------------------------------------------------|------------|
| `version`      | CouchDB version.                                     | `3`    |
| `size`         | CouchDB cluster size.                                 | `3`        |
| `storageClass` | Storage class for database provisioned volume claims. | `emptyDir` |
| `disk`         |                                                      | `10Gi`     |
| `memory`       | Memory size (in GB) to request for each database node. | `1`        |
| `cpu`          | CPU allocation to request for each database node.    | `1`        |
| `environment`  | CouchDB configuration.                               |            |
| `resources`    | Container-level resource requests / limits.          |            |
| `securityContext`  | Pod security context overrides.                  |            |
| `devMode`      | Enable development settings.                         | `false`    |
{: caption="Table 1. CouchDB parameters" caption-side="top"}


## CouchDB configuration
{: #couchdb-configuration}

CouchDB configuration options are exposed through the `spec.environment` field, as shown in the following example:

```
apiVersion: couchdb.databases.cloud.ibm.com/v1
kind: CouchDBCluster
metadata:
  name: "example-couchdbcluster"
spec:
   environment:
      adminPassword: changeme
      logLevel: notice
      couchjsStackSize: 67108864      
```
{: codeblock}

### CouchDB configuration field reference
{: #couchdb-configuration-field-reference}

The CouchDB configuration field reference section refers to the top level in the environment section of the YAML file, and defines the parameters on how Apache CouchDB itself operates. For more detailed information and definitions of the supported nested parameters, see the [CouchDB documentation](https://docs.couchdb.org/en/3.1.1/config/index.html){: new_window}{: external}.

Update the `adminPassword` to a password of your choosing. We recommend that you keep the default values for the other parameters unless your specific workload warrants a specific configuration.

| Name           | Description                                          | Default    | Information |
|----------------|------------------------------------------------------|------------|-----------|
| `adminPassword`                      | User-defined password for the default admin user that is created.                                                                                                                                                                                                   | `changeme`    |                                     |
| `logLevel`                           | CouchDB Log Level.                                                                                                                                                                                                                                                  | `notice`      | [CouchDB documentation](https://docs.couchdb.org/en/3.1.1/config/logging.html#log/level){: new_window}{: external}                                       |
| `couchjsStackSize`                   | Stack size used by the CouchJS processes (bytes).                                                                                                                                                                                                                   | `67108864`    |                                                                                                        |
| `maxDocumentSize`                    | Maximum size of documents (bytes).                                                                                                                                                                                                                                  | `67108864` *  | [CouchDB documentation](https://docs.couchdb.org/en/3.1.1/config/couchdb.html#couchdb/max_document_size){: new_window}{: external}                       |
| `OSProcessTimeout`                   | Timeout for Query Servers (ms).                                                                                                                                                                                                                                     | `5000`        | [CouchDB documentation](https://docs.couchdb.org/en/3.1.1/config/couchdb.html#couchdb/os_process_timeout){: new_window}{: external}                      |
| `maxDBsOpen`                         | Maximum number of open database shards per node.                                                                                                                                                                                                                    | `500`         | [CouchDB documentation](https://docs.couchdb.org/en/3.1.1/config/couchdb.html#couchdb/max_dbs_open){: new_window}{: external}                           |
| `maxAttachmentSize`                  | Maximum size of attachments (bytes).                                                                                                                                                                                                                                | `67108864` *  |                                                                                                        |
| `enableDatabaseRecovery`             | Enables only "soft-delete" databases when DELETE /{$DATABASE} requests are made.                                                                                                                                                                                    | `false`       |                                                                                                        |
| `defaultSecurity`                    | Default security object for databases if not explicitly set.                                                                                                                                                                                                        | `admin_only`* | [CouchDB documentation](https://docs.couchdb.org/en/3.1.1/config/couchdb.html#couchdb/default_security){: new_window}{: external}                        |
| `requireValidUser`                   | Require valid user for all requests.                                                                                                                                                                                                                                | `true` *      | [CouchDB documentation](https://docs.couchdb.org/en/3.1.1/config/auth.html#chttpd/require_valid_user){: new_window}{: external}                          |
| `tls`                                | Enable TLS support.                                                                                                                                                                                                                                                 | `true`        |                                                                                                        |
| `search`                             | Enable CouchDB full-text search (CouchDB 3.x only).                                                                                                                                                                                                                  | `false`       |                                                                                                                   |
| `maxHttpRequestSize`                 | Maximum size of HTTP requests (bytes).                                                                                                                                                                                                                              | `67108864` *  | [CouchDB documentation](https://docs.couchdb.org/en/3.1.1/config/http.html#httpd/max_http_request_size){: new_window}{: external}                        
|                                      |                                                                                                                                                                                                                                                                     |               |                                                                                                        |
| `erlang.processLimit`                | Set the maximum number of concurrent processes.                                                                                                                                                                                                                     | `1048576`     |                                                                                                        |
|                                      |                                                                                                                                                                                                                                                                     |               |                                                                                                        |
| `fabric.requestTimeout`              | Timeout for internal cluster RPC (ms).                                                                                                                                                                                                                              | `60000`       |                                                                                                        |
|                                      |                                                                                                                                                                                                                                                                     |               |                                                                                                        |
| `mango`                              | Mango is the Query Engine that services the `_find` endpoint.                                                                                                                                                                                                        |               | [CouchDB documentation](https://docs.couchdb.org/en/3.1.1/config/query-servers.html#mango){: new_window}{: external}                |
|                                      |                                                                                                                                                                                                                                                                     |               |                                                                                                        |
| `dreyfus`                            | CouchDB’s search subsystem can be configured via the dreyfus configuration section.                                                                                                                                                                                 |               | [CouchDB documentation](https://docs.couchdb.org/en/3.1.1/config/query-servers.html#search){: new_window}{: external}                |
|                                      |                                                                                                                                                                                                                                                                     |               |                                                                                                        |
| `ken`                                | The daemon responsible for automatically kicking off background jobs to keep secondary indexes “warm”.                                                                                                                                                              |               | [CouchDB documentation](https://docs.couchdb.org/en/3.1.1/config/indexbuilds.html#ken){: new_window}{: external}                |
|                                      |                                                                                                                                                                                                                                                                     |               |                                                                                                        |
| `smoosh`                             | An automated, event-driven daemon that continuously re-prioritizes the database and secondary index files on each node and automatically compacts the files that will recover the most free space.                                                                  |               | [CouchDB documentation](https://docs.couchdb.org/en/3.1.1/config/compaction.html#smoosh){: new_window}{: external}                |
|                                      |                                                                                                                                                                                                                                                                     |               |                                                                                                        |
| `reshard`                            | Resharding configuration.                                                                                                                                                                                                                                           |               | [CouchDB documentation](https://docs.couchdb.org/en/3.1.1/config/resharding.html){: new_window}{: external}                |
| `maxHttpRequestSize`                 | Maximum size of HTTP requests (bytes).                                                                                                                                                                                                                              | `67108864` *  | [CouchDB documentation](https://docs.couchdb.org/en/stable/config/http.html#httpd/max_http_request_size){: new_window}{: external}                        
{: caption="Table 2. YAML file environment section" caption-side="top"}
