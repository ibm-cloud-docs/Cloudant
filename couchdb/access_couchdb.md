---

copyright:
  years: 2019, 2021
lastupdated: "2021-04-17"

keywords: port forward, openshift route

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

<!-- Acrolinx: 2021-04-13 -->

# Accessing CouchDB
{: #access-couchdb-cluster}

The CouchDB cluster is exposed by using a `ClusterIP` service only. To access the deployment externally, you can either port-forward by using `oc`/`kubectl` or configure an external OpenShift route. 
{: shortdesc}

## Port-forward
{: #port-forward-access-couchdb}

Assuming TLS is enabled for CouchDB (the default behavior), you can expose the service locally on your machine by port-forwarding with `kubectl`:

```
kubectl port-forward svc/<couchdb name> 8443:443 -n <namespace>
```
{: codeblock}

You can then access your cluster locally by pointing a client to `https://localhost:8443`. To access the CouchDB dashboard, visit `https://localhost:8443/_utils` in a web browser.

If you disable TLS for your `CouchDBCluster` resource, you would port-forward the insecure port `5984` instead:

```
kubectl port-forward svc/<couchdb name> 5984:5984 -n <namespace>
```
{: codeblock}

You can then access your cluster locally by pointing a client to `http://localhost:5984`.

## OpenShift route
{: #openshift-route}

On OpenShift, the CouchDB service is configured to use an [OpenShift service certificate](https://docs.openshift.com/container-platform/4.1/authentication/certificates/service-serving-certificate.html){: new_window}{: external}.

This configuration allows the `CouchDBCluster` to be exposed by using a reencrypting route, ensuring traffic is encrypted internally within the OpenShift cluster. To create a route from the CLI, run the following command:

```
oc apply -f - <<END
apiVersion: route.openshift.io/v1
kind: Route
metadata:
  name: example-route
  namespace: <namespace>
spec:
  path: /
  to:
    kind: Service
    name: <couchdb name>
  port:
    targetPort: 443
  tls:
    termination: reencrypt
END
```
{: codeblock}

This command creates an externally visible endpoint with an auto-generated hostname. You can find the hostname by running the following command:

```
oc get route example-route -n <namespace>`
```
{: codeblock}

See the example response:

```
NAME            HOST/PORT                                                                                                       PATH      SERVICES         PORT      TERMINATION   WILDCARD
example-route   example-route-my-couchdb.rhoscluster-12345-0001.us-east.containers.appdomain.cloud   /         couchdb-3-node   443      reencrypt     None
```
{: codeblock}

In the previous example, you can access the Apache CouchDB API at `https://<example-route-my-couchdb>.rhoscluster-12345-0001.us-east.containers.appdomain.cloud/` or the Apache CouchDB dashboard at `https://<example-route-my-couchdb>.rhoscluster-12345-0001.us-east.containers.appdomain.cloud/_utils`.

## Credentials
{: #credentials-cluster-couchdb}

The `CouchDBCluster` is configured with a cluster admin account, `admin`. The password is specified at deployment time by using the `environment.adminPassword` field. Further, non-admin users can be added by using the [`_users` database](https://docs.couchdb.org/en/3.1.1/intro/security.html#authentication-database){: new_window}{: external}.
