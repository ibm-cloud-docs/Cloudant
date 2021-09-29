---

copyright:
  years: 2019, 2021
lastupdated: "2021-09-01"

keywords: subscription, operatorgroup, namespace, openshift, kubernetes

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

<!-- Acrolinx: 2021-04-12 -->

# Installing the Operator
{: #installing-the-operator}

Learn how to install the Operator on Kubernetes and Red Hat OpenShift depending on the Kubernetes flavor and version. 
{: shortdesc}

The discussion includes Installing the Operator on Kubernetes and Installing the Operator on Red Hat OpenShift 4.x

## Installing the Operator on Kubernetes
{: #installing-operator-kubernetes}

Now, walk through installing the Operator for Apache CouchDB on Kubernetes 1.14 or later by going to the [operatorhub.io](https://operatorhub.io/operator/couchdb-operator){: new_window}{: external} website and clicking the **Install** button. 

### Prerequisites
{: #prerequisites-operator-kubernetes}

- A working knowledge of Kubernetes.
- Access to a user with cluster-admin privileges (called `admin` here).
- A target cluster with access to the internet and the ability to pull from public container registries.

### Installing the Operator
{: #install-steps-operator-kubernetes}

To install the Operator, follow these steps:

If it isn't installed already, you must install [Operator Lifecycle Manager](https://github.com/operator-framework/operator-lifecycle-manager){: new_window}{: external} (OLM), a tool from Red Hat to help manage the Operators running on your cluster.  If the OLM is already installed, you can skip step 1 in the following steps: 

1. Install Operator Lifecycle Manager (OLM), a tool to help manage the Operators running on your cluster, by running the following command: 

    ```
    curl -sL https://github.com/operator-framework/operator-lifecycle-manager/releases/download/$OLM_RELEASE/install.sh | bash -s $OLM_RELEASE
    ```
    {: codeblock}

  For more information, see the [How do I install OLM](https://operator-framework.github.io/olm-book/docs/install-olm.html) guide?

2. Install the operator by running the following command. 
  This Operator is installed in the "operators" namespace and is usable from all namespaces in the cluster.
   
    ```
    kubectl create -f https://operatorhub.io/install/couchdb-operator.yaml
    ```
    {: codeblock}

3. After the installation is complete, validate that the operator is running by using the following command.

    ```
    kubectl get csv -n operators
    ```
    {: codeblock}

## Installing the Operator on Red Hat OpenShift version 4
{: #install-the-operator-openshift-4}

To install the Operator for Apache CouchDB on Red Hat OpenShift version 4, see the [Red Hat guide to installing certified operators](https://docs.openshift.com/container-platform/4.1/applications/operators/olm-adding-operators-to-cluster.html){: new_window}{: external}.
