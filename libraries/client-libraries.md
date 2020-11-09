---

copyright:
  years: 2015, 2020
lastupdated: "2020-11-09"

keywords: develop applications, supported library, mobile, java, node.js, python, swift, go

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

<!-- Acrolinx: 2020-03-16 -->

# Client libraries
{: #client-libraries}

Client libraries are the tools that you use to develop your own applications
to work with {{site.data.keyword.cloudantfull}} databases.
{: shortdesc}

The following client libraries are formally supported by {{site.data.keyword.cloudant_short_notm}}: Java&trade;, Node.js, Python, Go, Mobile, and Swift.

A supported library is one where you can contact {{site.data.keyword.cloudant_short_notm}} if you come across a specific,
reproducible problem in the current version of the library.

In this documentation, when a library is a supported beta client library, you see this tag ![BETA tag](../images/beta_icon.png).
{: important}

## Java
{: #java-supported}

The `java-cloudant` library is the official {{site.data.keyword.cloudant_short_notm}} library for Java&trade;. The new {{site.data.keyword.cloudant_short_notm}} SDK for Java![BETA tag](../images/beta_icon.png) library is a supported beta client library.

To install the `java-cloudant` library, see 
[Installation and Usage](https://github.com/cloudant/java-cloudant#installation-and-usage){: new_window}{: external} about installing the library by adding it as a dependency to your Maven or Gradle builds. You can also see details and examples of how to use the library in the guide.  

Or to install the {{site.data.keyword.cloudant_short_notm}} SDK for Java![BETA tag](../images/beta_icon.png) library, see [Installation](https://github.com/ibm/cloudant-java-sdk#installation) about installing the library by adding it as a dependency to your Maven or Gradle builds. You can also see details and examples of how to use the library in the guide.  

### Library for Java
{: #supported-library-for-java}

- [`java-cloudant`](https://github.com/cloudant/java-cloudant){: new_window}{: external}.
- [{{site.data.keyword.cloudant_short_notm}} SDK for Java![BETA tag](../images/beta_icon.png)](https://github.com/IBM/cloudant-java-sdk){: new_window}{: external}

## Node.js
{: #node-js-supported}

The `nodejs-cloudant` library is the official {{site.data.keyword.cloudant_short_notm}} library for Node.js. The new {{site.data.keyword.cloudant_short_notm}} SDK for Node.js![BETA tag](../images/beta_icon.png) library is a supported beta client library.

Install the [`nodejs-cloudant`](https://www.npmjs.com/package/@cloudant/cloudant){: new_window}{: external} library with npm.

```sh
npm install @cloudant/cloudant
```
{: codeblock}

Or install the [{{site.data.keyword.cloudant_short_notm}} SDK for Node.js![BETA tag](../images/beta_icon.png)](https://www.npmjs.com/package/@ibm-cloud/cloudant){: new_window}{: external} library with npm.

```sh
npm install @ibm-cloud/cloudant
```
{: codeblock}

### Library for Node.js
{: #supported-library-for-node-js}

- [nodejs-cloudant](https://github.com/cloudant/nodejs-cloudant){: new_window}{: external}
- [{{site.data.keyword.cloudant_short_notm}} SDK for Node.js![BETA tag](../images/beta_icon.png)](https://github.com/IBM/cloudant-node-sdk){: new_window}{: external}
  

## Python
{: #python-supported}

The `python` library is the official {{site.data.keyword.cloudant_short_notm}} library for Python. The new {{site.data.keyword.cloudant_short_notm}} SDK for Python![BETA tag](../images/beta_icon.png) library is a supported beta client library.

Python applications that access {{site.data.keyword.cloudant_short_notm}} have component dependencies. These dependencies must be specified in a `requirements.txt` file. For more information, see instructions for the [requirements files](https://github.com/cloudant/python-cloudant/blob/master/requirements.txt){: new_window}{: external}.
{: tip}

Install the [`python`](https://pypi.org/project/cloudant){: new_window}{: external} library by running `pip` as shown in the following example:

```sh
pip install cloudant
```
{: codeblock}

Or install the [{{site.data.keyword.cloudant_short_notm}} SDK for Python![BETA tag](../images/beta_icon.png)](https://pypi.org/project/ibmcloudant/){: new_window}{: external} library by running `pip` or `easy_install` as shown in the following example:

```sh
pip install --upgrade "ibmcloudant>=0.0.27"
```
{: codeblock}

or

```sh
easy_install --upgrade "ibmcloudant>=0.0.27"
```
{: codeblock}

For more information, see the [python.org](https://www.python.org/about/){: new_window}{: external} website. 

### Library for Python
{: #python-library-cl}

- [`python-cloudant`](https://github.com/cloudant/python-cloudant){: new_window}{: external}
- [{{site.data.keyword.cloudant_short_notm}} SDK for Python![BETA tag](../images/beta_icon.png)](https://github.com/IBM/cloudant-python-sdk){: new_window}{: external}

## Go
{: #go-supported}

The new {{site.data.keyword.cloudant_short_notm}} SDK for Go![BETA tag](../images/beta_icon.png) library is a supported beta client library.

Install the [{{site.data.keyword.cloudant_short_notm}} SDK for Go![BETA tag](../images/beta_icon.png)](https://pkg.go.dev/mod/github.com/IBM/cloudant-go-sdk){: new_window}{: external} library by running the following command:

```sh
go get -u github.com/IBM/cloudant-go-sdk/cloudantv1
```
{: codeblock}

### Library for Go
{: #go-library-cl}

- [`go`](https://github.com/IBM/cloudant-go-sdk){: new_window}{: external}![BETA tag](../images/beta_icon.png)

## Mobile
{: #mobile-supported}

The {{site.data.keyword.cloudant_short_notm}} sync library is used to store,
index,
and query local JSON data on a mobile device.
The library can also synchronize data between many devices.
Synchronization is controlled by your application.
The library also provides helper methods for finding and resolving conflicts,
both in the local device and the remote database.

### Library for Mobile
{: #supported-library-for-mobile}

The following versions of {{site.data.keyword.cloudant_short_notm}} sync are available:

- [{{site.data.keyword.cloudant_short_notm}} sync - Android / Java&trade;SE](https://github.com/cloudant/sync-android){: new_window}{: external}
- [{{site.data.keyword.cloudant_short_notm}} sync - iOS (CDTDatastore)](https://github.com/cloudant/CDTDatastore){: new_window}{: external}

An [overview](https://www.ibm.com/cloud/learn/offline-first){: new_window}{: external} of {{site.data.keyword.cloudant_short_notm}} sync is available, as well as details about {{site.data.keyword.cloudant_short_notm}} sync resources.

## Swift
{: #swift}

The `SwiftCloudant` library is the official {{site.data.keyword.cloudant_short_notm}} library for Swift. This library is an early version. As such, it doesn't currently have complete {{site.data.keyword.cloudant_short_notm}} API coverage.

Install it by running `cocoapods` with a podfile entry as shown in the following example:

```sh
pod 'SwiftCloudant'
```
{: codeblock}

SwiftCloudant isn't supported on iOS, and you can't call it from Objective-C.
{: tip}

### Library for Swift
{: swift-library-cl}

- [`cloudant/swift-cloudant`](https://github.com/cloudant/swift-cloudant){: new_window}{: external}

## Useful tools
{: #useful-tools-cl}

You can use the following tools with {{site.data.keyword.cloudant_short_notm}}.

### Supported tools
{: #supported-tools}

Supported tools are maintained and supported by {{site.data.keyword.cloudant_short_notm}}.

#### `couchbackup`
{: #couchbackup-cl}

A tool you use from the command line to backup an {{site.data.keyword.cloudant_short_notm}} or CouchDB database to a text file. 

To install `couchbackup`, run the following command by using `npm`:

```sh
npm install -g @cloudant/couchbackup
```
{: codeblock}

For more information, see [`couchbackup`](https://github.com/cloudant/couchbackup){: new_window}{: external}.

### Unsupported tools
{: #unsupported-tools-cl}

Unsupported tools are not maintained or supported by {{site.data.keyword.cloudant_short_notm}}.

#### `cURL`
{: #curl-cl}

A tool you use from the command line to transfer data. 

For more information, see [`curl`](https://curl.haxx.se/){: new_window}{: external}.

#### `jq`
{: #jq-cl} 

A tool you use from the command line to parse JSON. {{site.data.keyword.cloudant_short_notm}} uses the JSON data format. 

Download the package to install [`jq`](https://stedolan.github.io/jq/){: new_window}{: external}.

For more information, see [`jq`](https://stedolan.github.io/jq/){: new_window}{: external}.

#### `couchdiff`
{: #couchdiff-cl}

A tool you use from the command line to show the differences between an {{site.data.keyword.cloudant_short_notm}} and a CouchDB database. 

To install `couchdiff`, run the following command by using `npm`:

```sh
npm install -g couchdiff
```
{: codeblock}

For more information, see [`couchdiff`](https://www.npmjs.com/package/couchdiff){: new_window}{: external}.

#### `couchimport`
{: #couchimport-cl}

A tool you use from the command line, or programmatically, to import data into CouchDB efficiently. 

To install `couchimport`, run the following command by using `npm`:

```sh
npm install -g couchimport
```
{: codeblock}

For more information, see [`couchimport`](https://www.npmjs.com/package/couchimport){: new_window}{: external}.

#### `couchmigrate`
{: #couchmigrate-cl}

A tool you use from the command line to migrate CouchDB design documents. 

To install `couchmigrate`, run the following command by using `npm`:

```sh
npm install -g couchmigrate
```
{: codeblock}

For more information, see [`couchmigrate`](https://www.npmjs.com/package/couchmigrate){: new_window}{: external}.

#### `couchreplicate`
{: #couchreplicate-cl}

A tool you use from the command line to coordinate Apache CouchDB or {{site.data.keyword.cloudant_short_notm}} replications. 

To install `couchreplicate`, run the following command by using `npm`:

```sh
npm install -g couchreplicate
```
{: codeblock}

For more information, see [`couchreplicate`](https://www.npmjs.com/package/couchreplicate){: new_window}{: external}.

#### `couchxray`
{: #couchxray-cl}

A tool you use from the command line to see the CouchDB features used by a database.

To install `couchxray`, run the following command by using `npm`:

```sh
npm install -g couchxray
```
{: codeblock}

For more information, see [`couchxray`](https://www.npmjs.com/package/couchxray){: new_window}{: external}.