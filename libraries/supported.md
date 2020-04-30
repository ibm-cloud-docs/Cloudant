---

copyright:
  years: 2015, 2020
lastupdated: "2020-04-27"

keywords: mobile, java, libraries, framework, examples, tutorials, node.js, python, swift

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

<!-- Acrolinx: 2020-03-17 -->

# Supported client libraries
{: #supported-client-libraries}

You can find information on supported client libraries, such as mobile, Node.js, Python, and Swift here. 
{: shortdesc}

## Mobile
{: #mobile-supported}

The {{site.data.keyword.cloudantfull}} Sync library is used to store,
index,
and query local JSON data on a mobile device.
The library can also synchronize data between many devices.
Synchronization is controlled by your application.
The library also provides helper methods for finding and resolving conflicts,
both in the local device and the remote database.

Two versions are available:

- [{{site.data.keyword.cloudant_short_notm}} Sync - Android / Java&trade;SE](https://github.com/cloudant/sync-android){: new_window}{: external}.
- [{{site.data.keyword.cloudant_short_notm}} Sync - iOS (CDTDatastore)](https://github.com/cloudant/CDTDatastore){: new_window}{: external}.

An [overview](https://www.ibm.com/cloud/learn/offline-first){: new_window}{: external} of {{site.data.keyword.cloudant_short_notm}} Sync is available, as well as details about {{site.data.keyword.cloudant_short_notm}} Sync resources.
s
## Java
{: #java-supported}

The [`java-cloudant`](https://github.com/cloudant/java-cloudant){: new_window}{: external} library is the official {{site.data.keyword.cloudantfull}} library for Java&trade;.

For more information, see 
[Installation and Usage](https://github.com/cloudant/java-cloudant#installation-and-usage){: new_window}{: external} about installing the library by adding it as a dependency to your Maven or Gradle builds. You can also see details and examples of how to use the library in the guide.  

### Libraries and frameworks for Java
{: #libraries-and-frameworks-for-java}

#### Supported library for Java
{: #supported-library-for-java}

- [`java-cloudant`](https://github.com/cloudant/java-cloudant){: new_window}{: external}.

#### Unsupported libraries for Java
{: #unsupported-for-libraries-for-java-supported}

- [Ektorp](https://helun.github.io/Ektorp/reference_documentation.html){: new_window}{: external}.
- [JCouchDB](http://code.google.com/p/jcouchdb/){: new_window}{: external}.
- [JRelax](https://github.com/isterin/jrelax){: new_window}{: external}.
- [LightCouch](http://www.lightcouch.org/){: new_window}{: external}.

### Examples and tutorials for Java
{: #examples-and-tutorials-for-java}

- [Create, read, update, and delete](https://github.com/cloudant/haengematte/tree/master/java){: new_window}{: external} with HTTP and JSON libraries.
- [Create, read, update, and delete](https://github.com/cloudant/haengematte/tree/master/java/CrudWithEktorp){: new_window}{: external} with ektorp library.

## Node.js
{: #node-js-supported}

[Nodejs-cloudant](https://github.com/cloudant/nodejs-cloudant){: new_window}{: external}
is the official {{site.data.keyword.cloudant_short_notm}} library for Node.js.
You can install it with npm:

```sh
npm install cloudant
```
{: codeblock}

### Libraries and frameworks for node.js
{: #libraries-and-frameworks-for-node-js}

#### Supported library for node.js
{: #supported-library-for-node-js}

- [nodejs-cloudant](https://github.com/cloudant/nodejs-cloudant){: new_window}{: external} ([npm](https://www.npmjs.com/package/@cloudant/cloudant){: new_window}{: external}).

#### Unsupported libraries and frameworks for node.js
{: #unsupported-libraries-and-frameworks-for-node-js-supported}

- [Sag-JS](https://github.com/sbisbee/sag-js){: new_window}{: external}, which also works in the browser.
  See [Saggingcouch](https://github.com/sbisbee/saggingcouch.com){: new_window}{: external} for more detail.
- [Nano](https://github.com/dscape/nano){: new_window}{: external} is a minimalist implementation.
- [Restler](https://github.com/danwrong/restler){: new_window}{: external} delivers the best performance but is really barebones.
- [Cradle](https://github.com/flatiron/cradle){: new_window}{: external} is a high-level client that is also available if you absolutely need ease of use at the cost of reduced performance.
- [Cane_passport](https://github.com/ddemichele/cane_passport){: new_window}{: external} - {{site.data.keyword.cloudant_short_notm}} Angular Node Express with Bootstrap.
- [Express-Cloudant](https://github.com/cloudant-labs/express-cloudant){: new_window}{: external} - a template for Node.js Express framework that also uses PouchDB and Grunt.

### Examples and tutorials for node.js
{: #examples-and-tutorials-for-node-js}

- [Create, read, update, and delete](https://github.com/cloudant/haengematte/tree/master/nodejs){: new_window}{: external}.
- [CouchImport](https://github.com/glynnbird/couchimport){: new_window}{: external} - utility to import `.csv` or `.tsv` files into CouchDB or {{site.data.keyword.cloudant_short_notm}}.
- [Build a simple word game app by using {{site.data.keyword.cloudant_short_notm}} on {{site.data.keyword.cloud_notm}}](http://www.ibm.com/developerworks/cloud/library/cl-guesstheword-app/index.html?ca=drs-){: new_window}{: external} (uses Node.js).
- [Building a Real-time SMS Voting App](https://www.twilio.com/blog/2012/09/building-a-real-time-sms-voting-app-part-1-node-js-couchdb.html){: new_window}{: external} - six-part series that uses Node.js, Twilio, and {{site.data.keyword.cloudant_short_notm}}.


## Python
{: #python-supported}

A supported library for working with {{site.data.keyword.cloudant_short_notm}} by using Python is
available in the GitHub repository [`cloudant/python-cloudant`](https://github.com/cloudant/python-cloudant){: new_window}{: external}.

Python applications that access {{site.data.keyword.cloudant_short_notm}} have component dependencies. These dependencies must be specified in a `requirements.txt` file. For more information, see instructions for the [requirements files](https://pip.readthedocs.io/en/1.1/requirements.html){: new_window}{: external}.
{: tip}

Download the current library from [pypi.python.org](https://pypi.python.org/pypi/cloudant/){: new_window}{: external}.
For more information, see the [python.org](https://www.python.org/about/){: new_window}{: external} website. 

## Swift
{: #swift}

A supported library is available for working with {{site.data.keyword.cloudant_short_notm}}.
The library is called SwiftCloudant,
and is installed by using `cocoapods`.

See the podfile entry in the following example:

```sh
pod 'SwiftCloudant'
```
{: codeblock}

For more information about SwiftCloudant,
including details about installation and how to use the library to store,
index,
and query remote JSON data on {{site.data.keyword.cloudant_short_notm}},
see the GitHub repository [`cloudant/swift-cloudant`](https://github.com/cloudant/swift-cloudant){: new_window}{: external}.

The library is an early version. As such, it doesn't currently have complete {{site.data.keyword.cloudant_short_notm}} API coverage. 

SwiftCloudant isn't supported on iOS, and you can't call it from Objective-C.
{: tip}
