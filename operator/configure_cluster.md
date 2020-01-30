---

copyright:
  years: 2019, 2020
lastupdated: "2020-05-20"

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

## CouchDB configuration
{: #couchdb-configuration}

The `CouchDBCluster` resource adheres to the following schema:

```
   version: "3.0.0"
   size: 3 # Must be less than or equal to the number of nodes in the Kubernetes cluster.
   storageClass:
   disk: 10Gi
   memory: 10Gi
   cpu: 1
   devMode: false
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
      search: false
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
         maxJobs: 500
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
      mango:
         indexAllDisabled: false
         defaultLimit: 25
      dreyfus:
         retryLimit: 5
         limit: 25
         limitPartitions: 2000
         maxLimit: 200
         maxLimitPartitions: 2000
      ken:
         batchChannels: 20
         incrementalChannels: 80
         maxIncrementalUpdates: 1000
      smoosh:
         channels: {}
         dbChannels: "upgrade_dbs,ratio_dbs,slack_dbs"
         viewChannels: "upgrade_views,ratio_views,slack_views"
         staleness: 5
         cleanupIndexFiles: false
         waitSecs: 30
      reshard:
         maxJobs: 25
         maxRetries: 1
         retryIntervalSec: 10
         deleteSource: true
         updateShardMapTimeoutSec: 60
         sourceCloseTimeoutSec: 600
      advanced: {}
         
```
{: codeblock}

### CouchDBCluster field reference
{: #couchdb-cluster-field-reference}

The CouchDBCluster field reference section defines the major parameters on how Apache CouchDB deploys in the Kubernetes environment. 

The `size` parameter refers to the number of database nodes deployed in the Apache CouchDB cluster. It must be less than or equal to the number of nodes in the Kubernetes cluster. The Operator for Apache CouchDB employs an affinity rule that prohibits more than one CouchDB database node per Kubernetes cluster node for high availability and disaster recovery purposes.

If set to true the `devMode` parameter alters other configuration options, regardless of how they are set. It will disable the `environment.tls` parameter and remove the default affinity rule (so that more than one database node can run on the same Kubernetes node.)  
{: note} 

| Name           | Description                                          | Default    |
|----------------|------------------------------------------------------|------------|
| `version`      | CouchDB version.                                      | `3.0.0`    |
| `size`         | CouchDB cluster size (Must be less than or equal to the number of nodes in the Kubernetes cluster.)                                 | `3`        |
| `storageClass` | Storage class for database provisioned volume claims. | `emptyDir` |
| `disk`         |                                                      | `10Gi`     |
| `memory`       | Memory size to request for each database node.       | `1`        |
| `cpu`          | CPU allocation to request for each database node.    | `1`        |
| `environment`  | CouchDB configuration.                                |            |
| `devMode`      | Enable development settings.                          | `false`    |
{: caption="Table 1. CouchDB parameters" caption-side="top"}


### CouchDB configuration field reference
{: #couchdb-configuration-field-reference}

The CouchDB configuration field reference section refers to the top level in the environment section of the YAML file, and defines the parameters on how Apache CouchDB itself operates. For more detailed information and definitions of the supported nested parameters, see the [CouchDB documentation](https://docs.couchdb.org/en/3.0.0/config/index.html){: new_window}{: external}.

Update the `adminPassword` to a password of your choosing. We recommend that you keep the default values for the other parameters unless your specific workload warrants a specific configuration.

| Name           | Description                                          | Default    | Information |
|----------------|------------------------------------------------------|------------|-----------|
| `adminPassword`                      | User-defined password for the default admin user that is created.                                                                                                                                                                                                   | `changeme`    |                                     |
| `logLevel`                           | CouchDB Log Level.                                                                                                                                                                                                                                                  | `notice`      | [CouchDB documentation](https://docs.couchdb.org/en/3.1.0/config/logging.html#log/level){: new_window}{: external}                                       |
| `couchjsStackSize`                   | Stack size used by the CouchJS processes (bytes).                                                                                                                                                                                                                   | `67108864`    |                                                                                                        |
| `maxDocumentSize`                    | Maximum size of documents (bytes).                                                                                                                                                                                                                                  | `67108864` *  | [CouchDB documentation](https://docs.couchdb.org/en/3.1.0/config/couchdb.html#couchdb/max_document_size){: new_window}{: external}                       |
| `OSProcessTimeout`                   | Timeout for Query Servers (ms).                                                                                                                                                                                                                                     | `5000`        | [CouchDB documentation](https://docs.couchdb.org/en/3.1.0/config/couchdb.html#couchdb/os_process_timeout){: new_window}{: external}                      |
| `maxDBsOpen`                         | Maximum number of open database shards per node.                                                                                                                                                                                                                    | `500`         | [CouchDB documentation](https://docs.couchdb.org/en/3.1.0/config/couchdb.html#couchdb/max_dbs_open){: new_window}{: external}                           |
| `maxAttachmentSize`                  | Maximum size of attachments (bytes).                                                                                                                                                                                                                                | `67108864` *  |                                                                                                        |
| `enableDatabaseRecovery`             | Enables only "soft-delete" databases when DELETE /{$DATABASE} requests are made.                                                                                                                                                                                    | `false`       |                                                                                                        |
| `defaultSecurity`                    | Default security object for databases if not explicitly set.                                                                                                                                                                                                        | `admin_only`* | [CouchDB documentation](https://docs.couchdb.org/en/3.1.0/config/couchdb.html#couchdb/default_security){: new_window}{: external}                        |
| `requireValidUser`                   | Require valid user for all requests.                                                                                                                                                                                                                                | `true` *      | [CouchDB documentation](https://docs.couchdb.org/en/3.1.0/config/auth.html#chttpd/require_valid_user){: new_window}{: external}                          |
| `tls`                                | Enable TLS support.                                                                                                                                                                                                                                                 | `true`        |                                                                                                        |
| `search`                             | Enable CouchDB full-text search (CouchDB 3.x only).                                                                                                                                                                                                                  | `false`       |                                                                                                                   |
| `maxHttpRequestSize`                 | Maximum size of HTTP requests (bytes).                                                                                                                                                                                                                              | `67108864` *  | [CouchDB documentation](https://docs.couchdb.org/en/3.1.0/config/http.html#httpd/max_http_request_size){: new_window}{: external}                        
|                                      |                                                                                                                                                                                                                                                                     |               |                                                                                                        |
| `erlang.processLimit`                | Set the maximum number of concurrent processes.                                                                                                                                                                                                                     | `1048576`     |                                                                                                        |
|                                      |                                                                                                                                                                                                                                                                     |               |                                                                                                        |
| `fabric.requestTimeout`              | Timeout for internal cluster RPC (ms).                                                                                                                                                                                                                              | `60000`       |                                                                                                        |
|                                      |                                                                                                                                                                                                                                                                     |               |                                                                                                        |
| `mango`                              | Mango is the Query Engine that services the `_find` endpoint.                                                                                                                                                                                                        |               | [CouchDB documentation](https://docs.couchdb.org/en/3.1.0/config/query-servers.html#mango){: new_window}{: external}                |
|                                      |                                                                                                                                                                                                                                                                     |               |                                                                                                        |
| `dreyfus`                            | CouchDB’s search subsystem can be configured via the dreyfus configuration section.                                                                                                                                                                                 |               | [CouchDB documentation](https://docs.couchdb.org/en/3.1.0/config/query-servers.html#search){: new_window}{: external}                |
|                                      |                                                                                                                                                                                                                                                                     |               |                                                                                                        |
| `ken`                                | The daemon responsible for automatically kicking off background jobs to keep secondary indexes “warm”.                                                                                                                                                              |               | [CouchDB documentation](https://docs.couchdb.org/en/3.1.0/config/indexbuilds.html#ken){: new_window}{: external}                |
|                                      |                                                                                                                                                                                                                                                                     |               |                                                                                                        |
| `smoosh`                             | An automated, event-driven daemon that continuously re-prioritizes the database and secondary index files on each node and automatically compacts the files that will recover the most free space.                                                                  |               | [CouchDB documentation](https://docs.couchdb.org/en/3.1.0/config/compaction.html#smoosh){: new_window}{: external}                |
|                                      |                                                                                                                                                                                                                                                                     |               |                                                                                                        |
| `reshard`                            | Resharding configuration.                                                                                                                                                                                                                                           |               | [CouchDB documentation](https://docs.couchdb.org/en/3.1.0/config/resharding.html){: new_window}{: external}                |
| `maxHttpRequestSize`                 | Maximum size of HTTP requests (bytes).                                                                                                                                                                                                                              | `67108864` *  | [CouchDB documentation](https://docs.couchdb.org/en/stable/config/http.html#httpd/max_http_request_size){: new_window}{: external}                        
{: caption="Table 2. YAML file environment section" caption-side="top"}
