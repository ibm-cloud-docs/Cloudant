---

copyright:
  years: 2015, 2019
lastupdated: "2019-08-26"

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

<!-- Acrolinx: 2017-05-10 -->

# Supported client libraries
{: #supported-client-libraries}

## Mobile
{: #mobile}

The {{site.data.keyword.cloudantfull}} Sync library is used to store,
index,
and query local JSON data on a mobile device.
It is also used to synchronize data between many devices.
Synchronization is controlled by your application.
The library also provides helper methods for finding and resolving conflicts,
both in the local device and the remote database.

Two versions are available:

- [{{site.data.keyword.cloudant_short_notm}} Sync - Android / JavaSE ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant/sync-android){: new_window}.
- [{{site.data.keyword.cloudant_short_notm}} Sync - iOS (CDTDatastore) ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant/CDTDatastore){: new_window}.

An [overview ![External link icon](../images/launch-glyph.svg "External link icon")](https://cloudant.com/product/cloudant-features/sync/){: new_window} of {{site.data.keyword.cloudant_short_notm}} Sync is available.
Details of {{site.data.keyword.cloudant_short_notm}} Sync [resources ![External link icon](../images/launch-glyph.svg "External link icon")](https://cloudant.com/cloudant-sync-resources/){: new_window} are also available.

## Java
{: #java-supported}

[java-cloudant ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant/java-cloudant){: new_window} is the official {{site.data.keyword.cloudantfull}} library for Java.

For more information about installing the library by adding it as a dependency to your Maven or Gradle builds, and to see details and examples of how to use the library, see 
[Installation and Usage ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant/java-cloudant#installation-and-usage){: new_window}.

### Libraries and frameworks for Java
{: #libraries-and-frameworks-for-java}

#### Supported library for Java
{: #supported-library-for-java}

- [java-cloudant ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant/java-cloudant){: new_window}.

#### Unsupported libraries for Java
{: #unsupported-for-libraries-for-java-supported}

- [ektorp ![External link icon](../images/launch-glyph.svg "External link icon")](https://helun.github.io/Ektorp/reference_documentation.html){: new_window}.
- [jcouchdb ![External link icon](../images/launch-glyph.svg "External link icon")](http://code.google.com/p/jcouchdb/){: new_window}.
- [jrelax ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/isterin/jrelax){: new_window}.
- [LightCouch ![External link icon](../images/launch-glyph.svg "External link icon")](http://www.lightcouch.org/){: new_window}.

### Examples and tutorials for Java
{: #examples-and-tutorials-for-java}

- [Create, read, update, and delete](https://github.com/cloudant/haengematte/tree/master/java){: new_window}{: external} with HTTP and JSON libraries.
- [Create, read, update, and delete](https://github.com/cloudant/haengematte/tree/master/java/CrudWithEktorp){: new_window}{: external} with ektorp library.
- [Building a Java EE app on {{site.data.keyword.cloud_notm}} by using Watson and {{site.data.keyword.cloudant_short_notm}}](https://developer.ibm.com/bluemix/2014/10/17/building-java-ee-app-ibm-bluemix-using-watson-cloudant/){: new_window}{: external} {{site.data.keyword.cloud_notm}} example along with [YouTube video](https://www.youtube.com/watch?feature=youtu.be&v=9AFMY6m0LIU&app=desktop){: new_window}{: external}.

## Node.js
{: #node-js-supported}

[nodejs-cloudant](https://github.com/cloudant/nodejs-cloudant){: new_window}
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

- [nodejs-cloudant](https://github.com/cloudant/nodejs-cloudant){: new_window} ([npm](https://www.npmjs.com/package/@cloudant/cloudant){: new_window}{: external}).

#### Unsupported libraries and frameworks for node.js
{: #unsupported-libraries-and-frameworks-for-node-js-supported}

- [sag-js](https://github.com/sbisbee/sag-js){: new_window}{: external}, which also works in the browser.
  See [saggingcouch](https://github.com/sbisbee/saggingcouch.com){: new_window}{: external} for more detail.
- [nano](https://github.com/dscape/nano){: new_window}{: external} is a minimalist implementation.
- [restler](https://github.com/danwrong/restler){: new_window}{: external} delivers the best performance but is really barebones.
- [cradle](https://github.com/flatiron/cradle){: new_window}{: external} is a high-level client that is also available if you absolutely need ease of use at the cost of reduced performance.
- [cane_passport](https://github.com/ddemichele/cane_passport){: new_window} - {{site.data.keyword.cloudant_short_notm}} Angular Node Express with Bootstrap.
- [express-cloudant](https://github.com/cloudant-labs/express-cloudant){: new_window} - a template for Node.js Express framework that also uses PouchDB and Grunt.

### Examples and tutorials for node.js
{: #examples-and-tutorials-for-node-js}

- [Create, read, update, and delete](https://github.com/cloudant/haengematte/tree/master/nodejs){: new_window}{: external}.
- [Cloudant-Uploader](https://github.com/garbados/Cloudant-Uploader){: new_window}{: external} - utility to upload `.csv` files to {{site.data.keyword.cloudant_short_notm}}.
- [couchimport](https://github.com/glynnbird/couchimport){: new_window}{: external} - utility to import `.csv` or `.tsv` files into CouchDB or {{site.data.keyword.cloudant_short_notm}}.
- [Getting started with {{site.data.keyword.cloud_notm}} and Node.js](http://thoughtsoncloud.com/2014/07/getting-started-ibm-bluemix-node-js/){: new_window}{: external}.
- [A Cloud medley with {{site.data.keyword.cloud_notm}}, {{site.data.keyword.cloudant_short_notm}}, and Node.js](https://gigadom.wordpress.com/2014/08/15/a-cloud-medley-with-ibm-bluemix-cloudant-db-and-node-js/){: new_window}{: external}.
- [Build a simple word game app by using {{site.data.keyword.cloudant_short_notm}} on {{site.data.keyword.cloud_notm}}](http://www.ibm.com/developerworks/cloud/library/cl-guesstheword-app/index.html?ca=drs-){: new_window}{: external} - uses Node.js.
- [Building a Real-time SMS Voting App](https://www.twilio.com/blog/2012/09/building-a-real-time-sms-voting-app-part-1-node-js-couchdb.html){: new_window}{: external} - six-part series that uses Node.js, Twilio, and {{site.data.keyword.cloudant_short_notm}}.
- [Building a multitier Windows Azure Web application](https://www.ampower.me/article/CouchDB/Tutorial-Building-a-Multi-Tier-Windows-Azure-Web-application-use-Cloudants-Couchdb-as-a-Service-node-94-409665?eqs=Z2NWNlltTmlUWStWcHdEWENWc3UxdmowREpiMjlGUVpKajJOZGJpSlVkemlPS2oxa0YxZE5BPT0=){: new_window}{: external} - uses {{site.data.keyword.cloudant_short_notm}}, Node.js, CORS, and Grunt.
- [Do it yourself: Build a remote surveillance application by using {{site.data.keyword.cloud_notm}}, {{site.data.keyword.cloudant_short_notm}}, and Raspberry Pi.](http://www.ibm.com/developerworks/library/ba-remoteservpi-app/index.html){: new_window}{: external}.

## Python
{: #python-supported}

A supported library for working with {{site.data.keyword.cloudant_short_notm}} by using Python is
available in the Github repository [cloudant/python-cloudant](https://github.com/cloudant/python-cloudant){: new_window}{: external}.

Python applications that access {{site.data.keyword.cloudant_short_notm}} have component dependencies. These dependencies must be specified in a `requirements.txt` file. For more information, see instructions for the [requirements files](https://pip.readthedocs.io/en/1.1/requirements.html){: new_window}{: external}.
{: tip}

Download the current library release from [pypi.python.org](https://pypi.python.org/pypi/cloudant/){: new_window}.
For more information about the Python language, see [python.org](https://www.python.org/about/){: new_window}{: external}. 

## Swift
{: #swift}

A supported library is available for working with {{site.data.keyword.cloudant_short_notm}}.
The library is called SwiftCloudant,
and is installed by using `cocoapods`.

The podfile entry is:

```sh
pod 'SwiftCloudant'
```
{: codeblock}

For more information about SwiftCloudant,
including details about installation and how to use the library to store,
index,
and query remote JSON data on {{site.data.keyword.cloudant_short_notm}},
see the Github repository [cloudant/swift-cloudant](https://github.com/cloudant/swift-cloudant){: new_window}{: external}.

The library is an early release version. As such, it does not currently have complete {{site.data.keyword.cloudant_short_notm}} API coverage. 

SwiftCloudant is not supported on iOS, and you cannot call it from Objective-C.
{: tip}
