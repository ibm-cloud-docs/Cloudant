---

copyright:
  years: 2019
lastupdated: "2019-10-15"

keywords: operator, field reference

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

# Configuring a CouchDB cluster
{: #configure-couchdb-cluster}

The Operator for Apache CouchDB allows for user-defined configuration parameters that define how an Apache CouchDB cluster is deployed in Kubernetes.  

## CouchDB configuration
{: #couchdb-configuration}

The `CouchDBCluster` resource adheres to the following schema:

```
   version: "2.3.1"
   size: 3 # Must be less than or equal to the number of nodes in the Kubernetes cluster.
   storageClass:
   disk: 10Gi
   memory: 10Gi
   cpu: 1
   environment:
      adminPassword: changeme
      logLevel: notice
      couchjsStackSize: 67108864
      maxDocumentSize: 67108864
      OSProcessTimeout: 5000
      maxDBsOpen: 500
      maxAttachmentSize: 67108864
      enableDatabaseRecovery: false
      defaultSecurity: admin_only
      requireValidUser: true
      tls: true
      maxHttpRequestSize: 67108864
      erlang:
         processLimit: 1048576
      fabric:
         requestTimeout: 60000
      queryServer:
         OSProcessLimit: 100
         OSProcessSoftLimit: 100
         reduceLimit: true
      replicator:
         interval: 60000
         maxJobs: 50
         maxChurn: 20
         maxHistory: 20
         retriesPerRequest: 5
         workerProcesses: 4
         workerBatchSize: 500
         httpConnections: 20
         connectionTimeout: 30000
         verifySSLCertificates: true
      compactionDaemon:
         checkInterval: 3600
         minFileSize: 131072
         snoozePeriodMS: 3000
      databaseCompaction:
         docBufferSize: 524288
         checkpointAfter: 5242880
      viewCompaction:
         keyValueBufferSize: 2097152
      compactions: "_default = [{db_fragmentation, \"70%\"}, {view_fragmentation, \"60%\"}]"
         
```
{: codeblock}

### CouchDBCluster field reference
{: #couchdb-cluster-field-reference}

The CouchDBCluster field reference section defines the major parameters on how Apache CouchDB deploys in the Kubernetes environment. 

The `size` parameter refers to the number of database nodes deployed in the Apache CouchDB cluster. It must be less than or equal to the number of nodes in the Kubernetes cluster. The Operator for Apache CouchDB employs an affinity rule that prohibits more than one CouchDB database node per Kubernetes cluster node for high availability and disaster recovery purposes.
{: note} 

| Name           | Description                                          | Default    |
|----------------|------------------------------------------------------|------------|
| `version`      | CouchDB version.                                      | `2.3.1`    |
| `size`         | CouchDB cluster size (Must be less than or equal to the number of nodes in the Kubernetes cluster.)                                 | `3`        |
| `storageClass` | Storage class for database provisioned volume claims. | `emptyDir` |
| `disk`         |                                                      | `10Gi`     |
| `memory`       | Memory size to request for each database node.       | `1`        |
| `cpu`          | CPU allocation to request for each database node.    | `1`        |
| `environment`  | CouchDB configuration.                                |            |


### CouchDB configuration field reference
{: #couchdb-configuration-field-reference}

The CouchDB configuration field reference section refers to everything in the environment section of the YAML file, and defines the parameters on how Apache CouchDB itself operates. 

Update the `adminPassword` to a password of your choosing. It's recommended that you keep the default values for the other parameters unless your specific workload warrants a specific configuration.

| Name           | Description                                          | Default    | Information |
|----------------|------------------------------------------------------|------------|-----------|
| `adminPassword`                           | User-defined password for the default admin user that is created.                                                                                                                                                                                                                                                  | `changeme`      |                                     |
| `logLevel`                           | CouchDB Log Level.                                                                                                                                                                                                                                                  | `notice`      | [CouchDB documentation](https://docs.couchdb.org/en/stable/config/logging.html#log/level){: new_window}{: external}                                       |
| `couchjsStackSize`                   | Stack size used by the CouchJS processes (bytes).                                                                                                                                                                                                                   | `67108864`    |                                                                                                        |
| `maxDocumentSize`                    | Maximum size of documents (bytes).                                                                                                                                                                                                                                  | `67108864` *  | [CouchDB documentation](https://docs.couchdb.org/en/stable/config/couchdb.html#couchdb/max_document_size){: new_window}{: external}                       |
| `OSProcessTimeout`                   | Timeout for Query Servers (ms).                                                                                                                                                                                                                                     | `5000`        | [CouchDB documentation](https://docs.couchdb.org/en/stable/config/couchdb.html#couchdb/os_process_timeout){: new_window}{: external}                      |
| `maxDBsOpen`                         | Maximum number of open database shards per node.                                                                                                                                                                                                                          | `500`         | [CouchDB documentation](https://docs.couchdb.org/en/stable/config/couchdb.html#couchdb/max_dbs_open){: new_window}{: external}                           |
| `maxAttachmentSize`                  | Maximum size of attachments (bytes).                                                                                                                                                                                                                                | `67108864` *  |                                                                                                        |
| `enableDatabaseRecovery`             | Enables only "soft-delete" databases when DELETE /{$DATABASE} requests are made.                                                                                                                                                                                    | `false`       |                                                                                                        |
| `defaultSecurity`                    | Default security object for databases if not explicitly set.                                                                                                                                                                                                        | `admin_only`* | [CouchDB documentation](https://docs.couchdb.org/en/stable/config/couchdb.html#couchdb/default_security){: new_window}{: external}                        |
| `requireValidUser`                   | Require valid user for all requests.                                                                                                                                                                                                                                | `true` *      | [CouchDB documentation](https://docs.couchdb.org/en/stable/config/auth.html#chttpd/require_valid_user){: new_window}{: external}                          |
| `tls`                                | Enable TLS support.                                                                                                                                                                                                                                                 | `true`        |                                                                                                        |
| `maxHttpRequestSize`                 | Maximum size of HTTP requests (bytes).                                                                                                                                                                                                                              | `67108864` *  | [CouchDB documentation](https://docs.couchdb.org/en/stable/config/http.html#httpd/max_http_request_size){: new_window}{: external}                        
