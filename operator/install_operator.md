---

copyright:
  years: 2019, 2020
lastupdated: "2020-03-24"

keywords: subscription, OperatorGroup, namespace, Kubernetes, OpenShift

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

# Installing the Operator
{: #installing-the-operator}

This guide demonstrates how to install the Operator on Kubernetes and Red Hat OpenShift. Three separate sections describe how to install the Operator depending on the Kubernetes flavor and version. The sections discuss the following topics:

- Installing the Operator on Kubernetes
- Installing the Operator on Red Hat OpenShift 3.x
- Installing the Operator on Red Hat OpenShift 4.x
{: shortdesc}

## Installing the Operator on Kubernetes
{: #installing-operator-kubernetes}

This section walks through installing the Operator for Apache CouchDB on Kubernetes 1.11 or later. You can also follow the installation instructions that are found on [operatorhub.io](https://operatorhub.io/operator/couchdb-operator){: new_window}{: external} by clicking the **Install** button. 

### Prerequisites
{: #prerequisites-operator-kubernetes}

 * A working knowledge of Kubernetes.
 * Access to a user with cluster-admin privileges (called `admin` here).
 * A target cluster with access to the internet and the ability to pull from public container registries.

### Installing the Operator
{: #install-steps-operator-kubernetes}

To install the Operator, follow these steps:

If it isn't installed already, you must install [Operator Lifecycle Manager](https://github.com/operator-framework/operator-lifecycle-manager){: new_window}{: external} (OLM), a tool from Red Hat to help manage the Operators running on your cluster.  If the OLM is already installed, you can skip step 1 in the following steps: 

1. Install Operator Lifecycle Manager (OLM), a tool to help manage the Operators running on your cluster, by running the following command: 

  ```
  curl -sL https://github.com/operator-framework/operator-lifecycle-manager/releases/download/$OLM_RELEASE/install.sh | bash -s $OLM_RELEASE
  ```
  {: codeblock}

  For more information, see [How do I install OLM?](https://operator-framework.github.io/olm-book/docs/install-olm.html)

2. Install the operator by running the following command. 
  This Operator is installed in the "operators" namespace and is usable from all namespaces in the cluster.
   
   ```
   kubectl create -f https://operatorhub.io/install/couchdb-operator.yaml
   ```
   {: codeblock}

3. After the installation is complete, validate that the operator is running by using the following command:

  ```
  kubectl get csv -n operators
  ```
  {: codeblock}

## Installing the Operator on Red Hat OpenShift 3.x
{: #installing-operator-openshift}

You can walk through installing the Operator for Apache CouchDB on Red Hat OpenShift 3.11 or later here.

### Prerequisites
{: #prerequisites-operator-openshift}

 - A working knowledge of Kubernetes.
 - Access to a user with cluster-admin privileges (called `admin` here).
 - A target cluster with access to the internet and the ability to pull from public container registries.
 - [Operator Lifecycle Manager](https://github.com/operator-framework/operator-lifecycle-manager){: new_window}{: external} (OLM) installed, a tool from Red Hat to help manage the Operators running on your cluster. If the OLM isn't installed, run the following command to install it:

  ```
  curl -sL https://github.com/operator-framework/operator-lifecycle-manager/releases/download/0.11.0/install.sh | bash -s 0.11.0
  ```
  {: codeblock}

### Installing the Operator
{: #install-steps-operator-openshift}

To install the Operator, follow these steps:

1. Log in as a cluster admin and run the following command: 

   ```
   oc login -u admin
   ```
   {: codeblock}

2. Run the following command to create an OpenShift project for the Operator for Apache CouchDB deployment. 

  Follow the rest of these steps to create a project called `my-couchdb`, which is used throughout this guide.
  
  ```
  oc new-project my-couchdb
  ```
  {: codeblock}

3. Install the following `OperatorGroup` to manage deployments in the `my-couchdb` namespace only by running the following command.

  An [`OperatorGroup`](https://docs.openshift.com/container-platform/4.1/applications/operators/olm-understanding-olm.html#olm-operatorgroups_olm-understanding-olm){: new_window}{: external} defines where the Operator manages CouchDB deployments. A single Operator for an Apache CouchDB deployment can manage CouchDB clusters in single, multiple, or all namespaces.

  ```
  kubectl apply -f - <<END
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
  
4. Run the following command to create a subscription to the Operator for Apache CouchDB in the `my-couchdb` project.

  A `Subscription` watches the Operator catalog for new releases and automatically keeps operators up-to-date.

  ```
  kubectl apply -f - <<END
  apiVersion: operators.coreos.com/v1alpha1
  kind: Subscription
  metadata:
    name: my-couchdb
    namespace: my-couchdb
  spec:
    channel: beta
    name: couchdb-operator
    source: operatorhubio-catalog
    sourceNamespace: olm
  END
  ```
  {: codeblock}

5. Verify that your operator deployed by running the following command. 

   ```
   oc get csv -n my-couchdb
   ```
   {: codeblock}

  See the example response:

  ```
  NAME                      DISPLAY                       VERSION
  REPLACES   PHASE
  couchdb-operator.v0.2.0   Operator for Apache CouchDB   0.2.0
  Succeeded
  ```
  {: codeblock}

6. Verify that you have a `CouchDBCluster` CRD, which you can use to create CouchDB clusters, by running the following command.

  ```
  oc get crd couchdbclusters.couchdb.databases.cloud.ibm.com
  ```
  {: codeblock}

  See the example response:

  ```
  NAME                                              CREATED AT
  couchdbclusters.couchdb.databases.cloud.ibm.com
  2019-09-09T16:14:31Z
  ```
  {: codeblock}

### Using Red Hat Certified Containers
{: #install-the-operator-openshift}

By default, the Operator for Apache CouchDB pulls images from DockerHub. You can optionally elect to pull images from a private registry, for example, the Red Hat Container catalog. The CouchDB containers hosted in the Red Hat catalog are identical to those containers hosted in Docker Hub. Follow these steps to create and configure `imagePullSecrets`. 

1. Create a Registry Secret, such as an `imagePullSecrets` that the OpenShift container runtime can use to pull the images. 

   We recommended that you use a registry token that is created through the [Red Hat Portal](https://access.redhat.com/terms-based-registry/){: new_window}{: external} for the credentials. The following example command shows how to create an `imagePullSecrets` called `rh-catalog`.

  ```
  oc create secret docker-registry rh-catalog --docker-server=registry.connect.redhat.com \
  --docker-username=<registry-service-account-username> --docker-password=<registry-service-account-password>
  ```
  {: codeblock}

2. Instruct the deployment to use the `rh-catalog` secret by running the following command:

  ```
  oc set env deployment couchdb-operator --namespace my-couchdb REGISTRY_SECRET=rh-catalog

  oc patch deployment couchdb-operator --namespace my-couchdb -p '{"spec":{"template":{"spec":{"imagePullSecrets":[{"name":"rh-catalog"}]}}}}'
  ```
  {: codeblock}

  The operator deployment requires the `imagePullSecrets` that was created previously to be associated with it. You might need to wait a few minutes for OpenShift to create the operator deployment in response to the `Subscription`.
  
  This process changes the image that is used by the operator itself and triggers a redeploy.

3. Update the image references in the `couchdb-release` ConfigMap, which gets auto-created on first-run, by running the following command:

  ```
  oc edit configmap couchdb-release --namespace my-couchdb
  ```
  {: codeblock}

4. Replace `ibmcom` with `registry.connect.redhat.com/ibm` in the `images` section, and save. 

  Existing `CouchDBCluster` deployments aren't updated.

## Installing the Operator on Red Hat OpenShift version 4
{: #install-the-operator-openshift-4}

To install the Operator for Apache CouchDB on Red Hat OpenShift version 4, see the [Red Hat guide to installing certified operators](https://docs.openshift.com/container-platform/4.1/applications/operators/olm-adding-operators-to-cluster.html){: new_window}{: external}.
