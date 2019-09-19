---

copyright:
  years: 2019
lastupdated: "2019-09-19"

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

## CouchDB configuration
{: #couchdb-configuration}

The `CouchDBCluster` resource adheres to the following schema:

```
   version: "2.3.1"
   size: 3
   storageClass:
   disk: 10Gi
   memory: 10Gi
   cpu: 1
   environment:
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

| Name           | Description                                          | Default    |
|----------------|------------------------------------------------------|------------|
| `version`      | CouchDB version                                      | `2.3.1`    |
| `size`         | CouchDB cluster size                                 | `3`        |
| `storageClass` | Storage class for database provisioned volume claims | `emptyDir` |
| `disk`         |                                                      | `10Gi`     |
| `memory`       | Memory size to request for each database node        | `1`        |
| `cpu`          | CPU allocation to request for each database node     | `1`        |
| `environment`  | CouchDB configuration                                |            |


### CouchDB configuration field reference
{: #couchdb-configuration-field-reference}

| Name           | Description                                          | Default    |           |
|----------------|------------------------------------------------------|------------|-----------|
| `logLevel`                           | CouchDB Log Level.                                                                                                                                                                                                                                                  | `notice`      | [docs](https://docs.couchdb.org/en/stable/config/logging.html#log/level){: new_window}{: external}                                       |
| `couchjsStackSize`                   | Stack size used by the CouchJS processes (bytes).                                                                                                                                                                                                                   | `67108864`    |                                                                                                        |
| `maxDocumentSize`                    | Maximum size of documents (bytes).                                                                                                                                                                                                                                  | `67108864` *  | [docs](https://docs.couchdb.org/en/stable/config/couchdb.html#couchdb/max_document_size){: new_window}{: external}                        |
| `OSProcessTimeout`                   | Timeout for Query Servers (ms).                                                                                                                                                                                                                                     | `5000`        | [docs](https://docs.couchdb.org/en/stable/config/couchdb.html#couchdb/os_process_timeout){: new_window}{: external}                       |
| `maxDBsOpen`                         | Maximum number of open database shards per node.                                                                                                                                                                                                                          | `500`         | [docs](https://docs.couchdb.org/en/stable/config/couchdb.html#couchdb/max_dbs_open){: new_window}{: external}                             |
| `maxAttachmentSize`                  | Maximum size of attachments (bytes).                                                                                                                                                                                                                                | `67108864` *  |                                                                                                        |
| `enableDatabaseRecovery`             | Enable this to only "soft-delete" databases when DELETE /{db} requests are made.                                                                                                                                                                                    | `false`       |                                                                                                        |
| `defaultSecurity`                    | Default security object for databases if not explicitly set.                                                                                                                                                                                                        | `admin_only`* | [docs](https://docs.couchdb.org/en/stable/config/couchdb.html#couchdb/default_security){: new_window}{: external}                         |
| `requireValidUser`                   | Require valid user for all requests.                                                                                                                                                                                                                                | `true` *      | [docs](https://docs.couchdb.org/en/stable/config/auth.html#chttpd/require_valid_user){: new_window}{: external}                           |
| `tls`                                | Enable TLS support.                                                                                                                                                                                                                                                 | `true`        |                                                                                                        |
| `maxHttpRequestSize`                 | Maximum size of HTTP requests (bytes).                                                                                                                                                                                                                              | `67108864` *  | [docs](https://docs.couchdb.org/en/stable/config/http.html#httpd/max_http_request_size){: new_window}{: external}                        
