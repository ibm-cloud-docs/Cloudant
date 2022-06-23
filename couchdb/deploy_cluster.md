---

copyright:
  years: 2019, 2022
lastupdated: "2022-06-22"

keywords: access, status, resource, kubernetes, operator for apache couchdb, openshift

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# Deploying a CouchDB cluster
{: #deploy-couchdb-cluster}

Learn how to deploy a CouchDB Cluster on Kubernetes and OpenShift by deploying a three-node CouchDB Cluster with ephemeral storage on Kubernetes. 
{: shortdesc}

## Deploying a CouchDB cluster on Kubernetes
{: #deploy-couchdb-cluster-kubernetes}

Now, you walk through deploying a three-node CouchDB Cluster.

### Prerequisites
{: #prerequisites-cluster-kubernetes}

- You have a working knowledge of Kubernetes.
- You can access a user with privileges to create a `CouchDBCluster` resource.
- Operator for Apache CouchDB is installed.
- Operator for Apache CouchDB is configured to watch the namespace `my-couchdb` (for example, by using an `OperatorGroup`).
- A TLS certificate.

### Create a TLS certificate
{: #create-tls-certificate-cluster-kubernetes}

The Operator for Apache CouchDB uses TLS certificates for three purposes:

1. Communication between the Operator and CouchDBCluster management sidecars
1. Secure Erlang distribution between CouchDB nodes
1. The user-facing CouchDB service

Number one is mandatory and requires a TLS certificate to always be present. Number two is disabled by default as it is not possible to enable a secure distribution with Clouseau (the search module). However, you can enable number two by setting `environment.erlang.tls: true` in the `CouchDBCluster` manifest. You can disable three by setting `environment.tls: false` in the `CouchDBCluster` manifest. The internal uses of the certificate don't require peer verification.

The TLS certificates are stored in a Kubernetes secret called `clustername>-cert`. If your Kubernetes platform contains a supported certificate manager (currently only OpenShift certificate manager), this certificate is automatically generated. You can also provide your own certificate or CA certificate to make client verification easier.

#### Manually specifying a TLS Secret
{: #specifying-tls-secret-cluster-kubernetes}

Management of TLS certificates is beyond the scope of this discussion, but the steps are illustrated by using a self-signed certificate. If you intend to expose your CouchDB instance externally, you must replace this certificate with a certificate that can be verified by using a CA that your CouchDB clients can trust. 

##### Create a self-signed certificate
{: #create-a-self-signed-certificate-kubernetes}

1. Install `cfssl`. On MacOS, use this command, `brew install cfssl`. On Linux&trade;, use a command similar to the following one:

    ```sh
    mkdir ~/bin
    curl -s -L -o ~/bin/cfssl https://pkg.cfssl.org/R1.2/cfssl_linux-amd64
    curl -s -L -o ~/bin/cfssljson https://pkg.cfssl.org/R1.2/cfssljson_linux-amd64
    chmod +x ~/bin/{cfssl,cfssljson}
    export PATH=$PATH:~/bin
    ```
    {: codeblock}

    - For other platforms, see the [cfssl docs](https://github.com/cloudflare/cfssl){: external}.

2. Create a directory to store the certificates.
    
    ```sh
    mkdir ~/cfssl
    cd ~/cfssl
    ```
    {: codeblock}

3. Generate the CA and server certificates. Set `ADDRESS` to match the name and namespace of the `CouchDBCluster` you intend to create.

    ```sh
    echo '{"CN":"CA","key":{"algo":"rsa","size":2048}}' | cfssl gencert -initca - | cfssljson -bare ca -
    echo '{"signing":{"default":{"expiry":"43800h","usages":["signing","key encipherment","server auth","client      auth"]}}}' > ca-config.json
    export ADDRESS=<couchdbclustername>.<namespace>.svc
    export NAME=couchdb
    echo '{"CN":"'$NAME'","hosts":[""],"key":{"algo":"rsa","size":2048}}' | cfssl gencert -config=ca-config.json -ca=ca.pem -ca-key=ca-key.pem -hostname="$ADDRESS" - | cfssljson -bare $NAME
    ```
    {: codeblock}

4. Verify that you have the following three files: `couchdb.pem`, `couchdb-key.pem`, `ca.pem`.


#### Creating the TLS secret
{: #create-a-tls-secret-kubernetes}

Create a secret by using the name and namespace of the `CouchDBCluster` you intend to create.

```sh
kubectl create secret generic --type=kubernetes.io/tls <couchdbclustername>-cert --namespace=<namespace> \
--from-file=tls.crt=couchdb.pem \
--from-file=tls.key=couchdb-key.pem \
--from-file=ca.crt=ca.pem
```
{: codeblock}

If your secret was created by using a well-known CA, you don't need to add the ca.crt `key-value`.

### Create a CouchDBCluster resource
{: #create-couchdbcluster-resource-kubernetes}

The CouchDB cluster is defined by using the `CouchDBCluster` custom resource. To create a three-node cluster in the `my-couchdb` namespace, create a new `CouchDBCluster`:

```sh
kubectl apply -f - <<END
apiVersion: couchdb.databases.cloud.ibm.com/v1
kind: CouchDBCluster
metadata:
  name: example
  namespace: my-couchdb
spec:
  size: 3
  disk: 1Gi
  memory: 1Gi
  cpu: "1"
  storageClass: ""
  environment:
    adminPassword: "changeme"
END
```
{: codeblock}

Behind the scenes, this command creates a CouchDB Cluster and exposes it as a `ClusterIP` service `example.my-couchdb.svc` on port `443`.

### Checking the status of the deployment
{: #check-status-deployment-cluster-kubernetes}

Check the status of the deployment by using `oc describe couchdbcluster example -n my-couchdb`:

```sh
kubectl describe couchdbcluster -n my-couchdb
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
  Version:           3.1.0
Status:
  Formation Generation:  3
  Observed Generation:   2
```
{: codeblock}

To verify that the `CouchDBCluster` resource is fully deployed, check that `Status.Observed Generation` is equal to `Metadata.Generation`.

You must be able to see a new `ClusterIP` service, `example` in the `my-couchdb` namespace:

```sh
kubectl get service example -n my-couchdb
NAME                           TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)     AGE
example                        ClusterIP   172.21.248.198   <none>        443/TCP    8m
```
{: codeblock}

## Deploying a CouchDB Cluster on OpenShift
{: #deploy-couchdb-cluster-openshift-cluster-openshift}

Now, you walk through deploying a three-node CouchDB Cluster with ephemeral storage on Red Hat OpenShift.

### Prerequisites
{: #prerequisites-cluster-openshift}

- You have a working knowledge of Kubernetes.
- You have access to a user with privileges to create a `CouchDBCluster` resource.
- Operator for Apache CouchDB is installed.
- Operator for Apache CouchDB is configured to watch the namespace `my-couchdb` (for example, by using an `OperatorGroup`).

### TLS
{: #tls-cluster-openshift}

In Red Hat OpenShift, each `CouchDBCluster` automatically uses a [service certificate](https://docs.openshift.com/container-platform/4.1/authentication/certificates/service-serving-certificate.html). CouchDB clients within the OpenShift cluster must use TLS and verify the connection by using CA, which is automatically mounted to pods at `/var/run/secrets/kubernetes.io/serviceaccount/service-ca.crt` or [injecting it](https://docs.openshift.com/container-platform/4.1/authentication/certificates/service-serving-certificate.html) into a `ConfigMap`.

If you want to use a different certificate, you can manually create one by following the instructions in [Creating a TLS certificate](#create-tls-certificate-cluster-kubernetes).

### Create a `CouchDBCluster` resource
{: #create-couchdb-cluster-resource-cluster-openshift}

The CouchDB cluster is defined by using the `CouchDBCluster` custom resource. To create a three-node cluster in the `my-couchdb` namespace, create a new `CouchDBCluster`:

```sh
oc apply -f - <<END
apiVersion: couchdb.databases.cloud.ibm.com/v1
kind: CouchDBCluster
metadata:
  name: example
  namespace: my-couchdb
spec:
  size: 3
  disk: 1Gi
  memory: 1Gi
  cpu: "1"
  storageClass: ""
  environment:
    adminPassword: "changeme"
END
```
{: codeblock}

Behind the scenes, this command creates a CouchDB Cluster and exposes it as a `ClusterIP` service `example.my-couchdb.svc` on port `443`.

### Checking the status of the deployment
{: #checking-status-deployment-cluster-openshift}

Check the status of the deployment by using `oc describe couchdbcluster example -n my-couchdb`:

```sh
oc describe couchdbcluster -n my-couchdb
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
  Version:           3
Status:
  Formation Generation:  3
  Observed Generation:   2
```
{: codeblock}

To verify that the `CouchDBCluster` resource is fully deployed, check that `Status.Observed Generation` is equal to `Metadata.Generation`.

You must be able to see a new `ClusterIP` service, `example` in the `my-couchdb` namespace:

```sh
oc get service example -n my-couchdb
NAME                           TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)     AGE
example                        ClusterIP   172.21.248.198   <none>        443/TCP    8m
```
{: codeblock}
