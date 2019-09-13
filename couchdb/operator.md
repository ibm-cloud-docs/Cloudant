---

copyright:
  years: 2019
lastupdated: "2019-09-13"

keywords: apache couchdb support extension

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

# Operator for Apache CouchDB
{: #apache-couchdb-operator}

The Operator for Apache CouchDB facilitates deploying and managing an Apache CouchDB cluster on Kubernetes. At this time, the Operator is targeted at Red Hat OpenShift environments.

## Operator Features
{: #operator-features}

- Fully automated deployment and configuration of Apache CouchDB clusters
- Single Operator deployment can support single, multiple, or all Kubernetes namespaces

## Apache CouchDB Features
{: #couchdb-features}

The Operator for Apache CouchDB uses the following defaults when deploying a new Apache CouchDB cluster to ensure a secure and highly available configuration:

**Security**

- TLS: The Operator will leverage the Red Hat OpenShift cert-manager to create certificates and enable HTTPS/SSL on the cluster. On other Kubernetes distributions, TLS is supported using user-provided certificates. Recommended to review Apache CouchDB HTTPS (SSL/TLS) Options or install Jetstack cert-manager to manage this elsewhere.
- Encryption: Encrypted intra-cluster communication, meaning the communication between database nodes is encrypted in addition to TLS on the HTTPS API. 
- Authentication: The parameter `require_valid_user` is set to `true`, which means that no requests are allowed from anonymous users. Every request must be authenticated.
- Authorization: Databases are initially accessible by Apache CouchDB admins only.

**High Availability**

- Nodes: Each database node in an Apache CouchDB cluster requires its own Kuberenetes node.  It's recommended that you run it with a minimum of three nodes for any production deployment.
- Zones: The Apache CouchDB cluster database nodes are spread across available Kubernetes fault zones where available.
- Replicas: The default configuration for each database is eight shards (Q=8) and three shard copies (N=3), where each shard copy will be deployed on a separate node in the cluster. 

## Supported Apache CouchDB Versions
{: #couchdb-versions}

 * [Apache CouchDB 2.3.1](https://docs.couchdb.org/en/2.3.1/){: new_window}{: external}
 
## Installation of the Operator
{: #installation-operator}

This guide walks through installing the Operator for Apache CouchDB on Red Hat OpenShift 3.11 or above. Note that the Operator for Apache CouchDB can also be installed on vanilla Kubernetes environments, but the steps outlined below might not match the exact procedure. 

### Prerequisites
{: #prerequisites-install-operator}

- A working knowledge of Kubernetes
- A Kubernetes user with cluster-admin privileges (`admin` in this guide)
- Target Kubernetes cluster has access to the internet / ability to pull from public container registries
- Working Kubernetes command line utility that is connected to the target Kubernetes cluster
- An API key for the [Red Hat Container Catalog](https://access.redhat.com/containers/){: new_window}{: external}.

### Install Operator Lifecycle Manager
{: #install-olm}

If it is not installed already, install the [Operator Lifecycle Manager](https://github.com/operator-framework/operator-lifecycle-manager){: new_window}{: external}. (OLM). OLM is a Red Hat tool to help manage the Operators running in a Kubernetes cluster. Note that OLM is installed by default in OpenShift 4.0 and above.

```
curl -L https://github.com/operator-framework/operator-lifecycle-manager/releases/download/0.11.0/install.sh -o install.sh
chmod +x install.sh
./install.sh 0.11.0
```

### Install the Operator for Apache CouchDB
{: #install-operator}

Once the Operator Lifecycle Manager is installed on the Kubernetes cluster, you can install the Operator for Apache CouchDB. The steps to do so consist of the following:

1) Login as cluster admin.
2) Create an OpenShift project.
3) Create an imagePullSecret.
4) Create an OperatorGroup.
5) Create a Subscription.
6) Configure Image Pull Secrets.
7) Verify installation.

For more information, see the following details. 

#### Login as a cluster admin

Use the Kubernetes or OpenShift CLI to login to the cluster. In this tutorial we will use the OpenShift CLI `oc`. 

```sh
oc login -u admin
```
{: codeblock}

#### Create an OpenShift project

Create an OpenShift project for the Operator for Apache CouchDB deployment. Below is an example of creating a project called `my-couchdb`. The project name `my-couchdb` will be used throughout this guide. 

```sh
oc new-project my-couchdb
```
{: codeblock}

#### Create an imagePullSecret

The Operator for Apache CouchDB and supporting images are hosted in the Red Hat Container Catalog. An `imagePullSecret` will need to be created so that the OpenShift container runtime can pull the images. It is recommended to use a registry token (created through the [Red Hat Portal](https://access.redhat.com/terms-based-registry/){: new_window}{: external} for the credentials. The following example shows how to create an `imagePullSecret` called `rh-catalog`.

```sh
oc create secret docker-registry rh-catalog --docker-server=registry.connect.redhat.com \
--docker-username=<registry-service-account-username> --docker-password=<registry-service-account-password>
```
{: codeblock}

#### Create an OperatorGroup

An [`OperatorGroup`](https://docs.openshift.com/container-platform/4.1/applications/operators/olm-understanding-olm.html#olm-operatorgroups_olm-understanding-olm){: new_window}{: external} defines where the Operator will manage Apache CouchDB deployments. A single Operator for Apache CouchDB deployment can manage CouchDB clusters in single, multiple, or all namespaces. To get started, install the following `OperatorGroup` to manage deployments in the `my-couchdb` namespace only:

```sh
oc apply -f - <<END
apiVersion: operators.coreos.com/v1alpha2
kind: OperatorGroup
metadata:
  name: operatorgroup
  namespace: my-couchdb
spec:
  targetNamespaces:
  - my-couchdb
END
```
{: codeblock}

#### Create a Subscription

A `Subscription` watches the Operator Catalog for new releases and can automatically keep operators up to date. Add the following to create a subscription to the Operator for Apache CouchDB in the `my-couchdb` project:

```sh
oc apply -f - <<END
apiVersion: operators.coreos.com/v1alpha1
kind: Subscription
metadata:
  name: my-couchdb
  namespace: my-couchdb
spec:
  channel: preview
  name: couchdb-operator
  source: operatorhubio-catalog
  sourceNamespace: olm
END
```
{: codeblock}

#### Configure Image Pull Secrets

The operator deployment requires the `imagePullSecret` created above to be associated with it. Note that you may need to wait a few minutes for OpenShift to create the operator deployment in response to the `Subscription` before running the commands below.

Run the following to instruct the deployment to use the `rh-catalog` secret:

```sh
oc set env deployment couchdb-operator --namespace my-couchdb REGISTRY_SECRET=rh-catalog

oc patch deployment couchdb-operator --namespace my-couchdb -p '{"spec":{"template":{"spec":{"imagePullSecrets":[{"name":"rh-catalog"}]}}}}'
```
{: codeblock}

#### Verify installation

You can verify that the Operator for Apache CouchDB has been deployed by running:

```sh
oc get csv -n my-couchdb
```
{: codeblock}

Example response:
```sh
NAME                      DISPLAY                       VERSION   REPLACES   PHASE
couchdb-operator.v0.2.0   Operator for Apache CouchDB   0.2.0                Succeeded
```
{: codeblock}

You should also now have a `CouchDBCluster` CRD, which you can use to create CouchDB clusters. You can confirm that the CRD exists by running:

```sh
oc get crd couchdbclusters.couchdb.databases.cloud.ibm.com
```
{: codeblock}

Example response:
```sh
NAME                                              CREATED AT
couchdbclusters.couchdb.databases.cloud.ibm.com   2019-09-09T16:14:31Z
```
{: codeblock}

## Deploying an Apache CouchDB Cluster
{: #deploy-couchdb-cluster}

In this guide, we'll walk through deploying an Apache CouchDB Cluster using the Operator for Apache CouchDB. The guide will use the Kubernetes CLI to install a CouchDB cluster, but use of the Kubernetes dashboard such as the Red Hat Open Shift cluster console can also be used. 

### Prerequisites
{: #prerequisites-deploy-couchdb-cluster}

- A working knowledge of Kubernetes
- A Kubernetes user with privileges to create a `CouchDBCluster` resource
- Operator for Apache CouchDB is installed
- Operator for Apache CouchDB is configured to watch the namespace `my-couchdb` (e.g. using an `OperatorGroup`)
- Working Kubernetes command line utility that is connected to the target Kubernetes cluster

### Configuration
{: #configuration}

Creation of a CouchDBCluster resource using the Operator for Apache CouchDB requires the following configuration file:

```sh
apiVersion: couchdb.databases.cloud.ibm.com/v1
kind: CouchDBCluster
metadata:
  name: example-couchdbcluster
  namespace: my-couchdb
spec:
  cpu: '1'
  disk: 1Gi
  memory: 1Gi
  size: 3
  version: 2.3.1
  environment:
    adminPassword: changeme
```
{: codeblock}

The important configuration parameters to edit as it pertains to the Apache CouchDB cluster configuration:
- name: Name of the Apache CouchDB cluster resource.
- namespace: The namespace for deployment of the Apache CouchDB cluster resource.
- size: The number of database nodes in the Apache CouchDB cluster. Note this cannot be larger than the number of nodes in the Kubernetes cluster. 
- adminPassword: The password for the Apache CouchDB 'admin' user to authenticate against the CouchDB API and Dashboard. 

### Create a CouchDBCluster resource
{: #create-couchdbcluster}

The CouchDB cluster is defined using the `CouchDBCluster` custom resource. To create a 3 node cluster in the `my-couchdb` namespace, create a new `CouchDBCluster`:

```sh
oc apply -f - <<END
apiVersion: couchdb.databases.cloud.ibm.com/v1
kind: CouchDBCluster
metadata:
  name: example
  namespace: my-couchdb
spec:
  version: "2.3.1"
  size: 3
  disk: 1Gi
  memory: 1Gi
  cpu: "1"
  environment:
    adminPassword: "changeme"
END
```
{: codeblock}

This will create a CouchDB Cluster and expose it as a `ClusterIP` service `example.my-couchdb` on port `5984`.

### Checking the status of the deployment
{: #checking-status}

Check the status of the deployment using the following command:

```sh
oc describe couchdbcluster example -n my-couchdb
```
{: codeblock}

Example response:
```sh
Name:         example
Namespace:    my-couchdb
API Version:  couchdb.databases.cloud.ibm.com/v1
Kind:         CouchDBCluster
Metadata:
  Creation Timestamp:  2019-09-09T14:04:56Z
  Generation:          2
  Resource Version:    1751138
  Self Link:           /apis/couchdb.databases.cloud.ibm.com/v1/namespaces/my-couchdb/couchdbclusters/example
  UID:                 cdb6af3f-d30a-11e9-a20a-7aa347b74f8b
Spec:
  Cpu:   1
  Disk:  1Gi
  Environment:
    Admin Password:  [secure]
  Memory:            1Gi
  Size:              3
  Storage Class:
  Version:           2.3.1
Status:
  Formation Generation:  3
  Observed Generation:   2
```
{: codeblock}

To verify that the `CouchDBCluster` resource has been fully deployed, check that `Status.Observed Generation` is equal to `Metadata.Generation`.

Check for the existence of the `ClusterIP` service, in this case called `example` in the `my-couchdb` namespace:

```sh
oc get service example -n my-couchdb
```
{: codeblock}

Example response:
```sh
NAME                           TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)     AGE
example                        ClusterIP   172.21.248.198   <none>        5984/TCP    8m
```
{: codeblock}

### Accessing CouchDB
{: #accessing}

The Apache CouchDB cluster deployed using the Operator for Apache CouchDB is exposed via a `ClusterIP` service only. To access the deployment externally you can either:

1) Port forward using `oc`/`kubectl` CLI.
2) Configure an external route.

#### Via Port-forwarding
{: #port-forwarding}

To port-forward the service using `oc`, run:

```sh
oc port-forward svc/example 5984:5984 -n my-couchdb
```
{: codeblock}

The same command works with `kubectl`.

You can then access you cluster locally from the same terminal you ran the above by pointing a client to `https://localhost:5984`. To access the Apache CouchDB dashboard, visit `https://localhost:5984/_utils` in a web browser.

#### Via a Route
{: #route}

In Red Hat OpenShift, you can expose the `CouchDBCluster` using a fully encrypted external ingress. To do this, configure a `reencrypting` Route using the following:

```sh
oc apply -f - <<END
apiVersion: route.openshift.io/v1
kind: Route
metadata:
  name: example-route
  namespace: my-couchdb
spec:
  path: /
  to:
    kind: Service
    name: example
  port:
    targetPort: 5984
  tls:
    termination: reencrypt
END
```
{: codeblock}

This will create an externally visible endpoint with an auto-generated hostname. You can discover the hostname using:

```sh
oc get route example-route -n my-couchdb
```
{: codeblock}

Example response:
```sh
NAME            HOST/PORT                                                                                                       PATH      SERVICES         PORT      TERMINATION   WILDCARD
example-route   example-route-my-couchdb.rhoscluster-12345-0001.us-east.containers.appdomain.cloud   /         couchdb-3-node   5984      reencrypt     None
```
{: codeblock}

In the example above, you can then access the Apache CouchDB API at `https://example-route-my-couchdb.rhoscluster-12345-0001.us-east.containers.appdomain.cloud/` or the Apache CouchDB dashboard at `https://example-route-my-couchdb.rhoscluster-12345-0001.us-east.containers.appdomain.cloud/_utils`.

### Credentials
{: #credentials}

The Apache CouchDB `CouchDBCluster` resource is configured with a cluster admin account, `admin`. The password is specified at deployment time using the `environment.adminPassword` field. 

Further non-admin users can be added using the [`_users` database](https://docs.couchdb.org/en/2.3.1/intro/security.html#authentication-database){: new_window}{: external}.

## Logging
{: #logging-operator}

### Viewing Operator for Apache CouchDB logs
{: #viewing-logs}

You can view the Operator for Apache CouchDB logs using the following command:

```sh
oc logs -l name=couchdb-operator --namespace=my-couchdb
```
{: codeblock}

### Adjusting the log level of the Operator for Apache CouchDB
{: #log-level}

You can enable verbose logging by passing the `--v` argument to the operator. For example, to set log level to `4`, run the following:

```sh
oc patch deployment couchdb-operator --namespace my-couchdb --type='json' -p '{"spec":{"template":{"spec":{"containers":[{"name":"couchdb-operator", "args": ["--v=4"]}]}}}}'
```
{: codeblock}
