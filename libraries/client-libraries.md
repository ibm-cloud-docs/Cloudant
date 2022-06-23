---

copyright:
  years: 2015, 2022
lastupdated: "2022-06-23"

keywords: develop applications, supported library, mobile, java, node.js, python, swift, go

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# Client libraries
{: #client-libraries}

Client libraries are the tools that you use to develop your own applications
to work with {{site.data.keyword.cloudantfull}} databases.
{: shortdesc}

The following client libraries are formally supported by {{site.data.keyword.cloudant_short_notm}}: Java&trade;, Node.js, Python, and Go.

A supported library is one where you can contact {{site.data.keyword.cloudant_short_notm}} if you come across a specific,
reproducible problem in the current version of the library.

## Java
{: #java-supported}

The {{site.data.keyword.cloudant_short_notm}} SDK for Java&trade; is the official {{site.data.keyword.cloudant_short_notm}} library for Java&trade;.

To install the {{site.data.keyword.cloudant_short_notm}} SDK for the Java&trade; library, see [Installation](https://github.com/ibm/cloudant-java-sdk#installation) about installing the library by adding it as a dependency to your Maven or Gradle builds. You can also see details and examples of how to use the library in the guide.  

### Library for Java
{: #supported-library-for-java}

- [{{site.data.keyword.cloudant_short_notm}} SDK for Java&trade;](https://github.com/ibm/cloudant-java-sdk){: external}

## Node.js
{: #node-js-supported}

The {{site.data.keyword.cloudant_short_notm}} SDK for the Node.js library is the official {{site.data.keyword.cloudant_short_notm}} library for Node.js.

Install the [{{site.data.keyword.cloudant_short_notm}} SDK for Node.js](https://www.npmjs.com/package/@ibm-cloud/cloudant){: external} library by running the following command:

```sh
npm install @ibm-cloud/cloudant
```
{: codeblock}

### Library for Node.js
{: #supported-library-for-node-js}

- [{{site.data.keyword.cloudant_short_notm}} SDK for Node.js](https://github.com/ibm/cloudant-node-sdk){: external}
  

## Python
{: #python-supported}

The {{site.data.keyword.cloudant_short_notm}} SDK for Python library is the official {{site.data.keyword.cloudant_short_notm}} library for Python.

Install the [{{site.data.keyword.cloudant_short_notm}} SDK for Python](https://pypi.org/project/ibmcloudant/){: external} library by running `pip` or `easy_install` as shown in the following examples:

```sh
pip install --upgrade "ibmcloudant>=0.0.27"
```
{: codeblock}

or

```sh
easy_install --upgrade "ibmcloudant>=0.0.27"
```
{: codeblock}

For more information, see the [python.org](https://www.python.org/about/){: external} website. 

### Library for Python
{: #python-library-cl}

- [{{site.data.keyword.cloudant_short_notm}} SDK for Python](https://github.com/IBM/cloudant-python-sdk){: external}

## Go
{: #go-supported}

The {{site.data.keyword.cloudant_short_notm}} SDK for Go library is the official {{site.data.keyword.cloudant_short_notm}} library for Go. 

Install the [{{site.data.keyword.cloudant_short_notm}} SDK for Go](https://pkg.go.dev/mod/github.com/IBM/cloudant-go-sdk){: external} library by running the following command:

```sh
go get -u github.com/IBM/cloudant-go-sdk/cloudantv1
```
{: codeblock}

### Library for Go
{: #go-library-cl}

- [{{site.data.keyword.cloudant_short_notm}} SDK for Go](https://github.com/ibm/cloudant-go-sdk){: external}

## Useful tools
{: #useful-tools-cl}

You can use the following tools with {{site.data.keyword.cloudant_short_notm}}.

### Supported tools
{: #supported-tools}

Supported tools are maintained and supported by {{site.data.keyword.cloudant_short_notm}}.

#### `couchbackup`
{: #couchbackup-cl}

A tool that you use from the command line to back up an {{site.data.keyword.cloudant_short_notm}} or CouchDB database to a text file. 

To install `couchbackup`, run the following command by using `npm`:

```sh
npm install -g @cloudant/couchbackup
```
{: codeblock}

For more information, see [`couchbackup`](https://github.com/cloudant/couchbackup){: external}.

### Unsupported tools
{: #unsupported-tools-cl}

Unsupported tools are not maintained or supported by {{site.data.keyword.cloudant_short_notm}}.

#### `cURL`
{: #curl-cl}

A tool that you use from the command line to transfer data. 

For more information, see [`curl`](https://curl.haxx.se/){: external}.

#### `jq`
{: #jq-cl} 

A tool that you use from the command line to parse JSON. {{site.data.keyword.cloudant_short_notm}} uses the JSON data format. 

Download the package to install [`jq`](https://stedolan.github.io/jq/){: external}.

For more information, see [`jq`](https://stedolan.github.io/jq/){: external}.

#### `couchdiff`
{: #couchdiff-cl}

A tool that you use from the command line to show the differences between an {{site.data.keyword.cloudant_short_notm}} and a CouchDB database. 

To install `couchdiff`, run the following command by using `npm`:

```sh
npm install -g couchdiff
```
{: codeblock}

For more information, see [`couchdiff`](https://www.npmjs.com/package/couchdiff){: external}.

#### `couchimport`
{: #couchimport-cl}

A tool that you use from the command line, or programmatically, to import data into CouchDB efficiently. 

To install `couchimport`, run the following command by using `npm`:

```sh
npm install -g couchimport
```
{: codeblock}

For more information, see [`couchimport`](https://www.npmjs.com/package/couchimport){: external}.

#### `couchmigrate`
{: #couchmigrate-cl}

A tool that you use from the command line to migrate CouchDB design documents. 

To install `couchmigrate`, run the following command by using `npm`:

```sh
npm install -g couchmigrate
```
{: codeblock}

For more information, see [`couchmigrate`](https://www.npmjs.com/package/couchmigrate){: external}.

#### `couchreplicate`
{: #couchreplicate-cl}

A tool that you use from the command line to coordinate Apache CouchDB or {{site.data.keyword.cloudant_short_notm}} replications. 

To install `couchreplicate`, run the following command by using `npm`:

```sh
npm install -g couchreplicate
```
{: codeblock}

For more information, see [`couchreplicate`](https://www.npmjs.com/package/couchreplicate){: external}.

#### `couchxray`
{: #couchxray-cl}

A tool that you use from the command line to see the CouchDB features used by a database.

To install `couchxray`, run the following command by using `npm`:

```sh
npm install -g couchxray
```
{: codeblock}

For more information, see [`couchxray`](https://www.npmjs.com/package/couchxray){: external}.
