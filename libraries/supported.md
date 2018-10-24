---

copyright:
  years: 2015, 2018
lastupdated: "2018-10-24"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:tip: .tip}

<!-- Acrolinx: 2017-05-10 -->

# Supported client libraries

## Mobile

The {{site.data.keyword.cloudantfull}} Sync library is used to store,
index,
and query local JSON data on a mobile device.
It is also used to synchronize data between many devices.
Synchronization is controlled by your application.
The library also provides helper methods for finding and resolving conflicts,
both in the local device and the remote database.

Two versions are available:

-   [{{site.data.keyword.cloudant_short_notm}} Sync - Android / JavaSE ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant/sync-android){:new_window}.
-   [{{site.data.keyword.cloudant_short_notm}} Sync - iOS (CDTDatastore) ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant/CDTDatastore){:new_window}.

An [overview ![External link icon](../images/launch-glyph.svg "External link icon")](https://cloudant.com/product/cloudant-features/sync/){:new_window} of {{site.data.keyword.cloudant_short_notm}} Sync is available.
Details of {{site.data.keyword.cloudant_short_notm}} Sync [resources ![External link icon](../images/launch-glyph.svg "External link icon")](https://cloudant.com/cloudant-sync-resources/){:new_window} are also available.

## Java

[java-cloudant ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant/java-cloudant){:new_window} is the official {{site.data.keyword.cloudantfull}} library for Java.

Information about installing the library by adding it as a dependency to your Maven or Gradle builds is available
[here ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant/java-cloudant#installation-and-usage){:new_window},
along with details and examples of how to use the library.

### Libraries and frameworks for Java

#### Supported library for Java

-   [java-cloudant ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant/java-cloudant){:new_window}.

#### Unsupported libraries for Java

-   [ektorp ![External link icon](../images/launch-glyph.svg "External link icon")](https://helun.github.io/Ektorp/reference_documentation.html){:new_window}.
-   [jcouchdb ![External link icon](../images/launch-glyph.svg "External link icon")](http://code.google.com/p/jcouchdb/){:new_window}.
-   [jrelax ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/isterin/jrelax){:new_window}.
-   [LightCouch ![External link icon](../images/launch-glyph.svg "External link icon")](http://www.lightcouch.org/){:new_window}.
-   [Java Cloudant Web Starter ![External link icon](../images/launch-glyph.svg "External link icon")](https://ace.ng.bluemix.net/#/store/cloudOEPaneId=store&appTemplateGuid=CloudantJavaBPTemplate&fromCatalog=true){:new_window} boilerplate for {{site.data.keyword.cloud}}.

### Examples and tutorials for Java

-   [Create, read, update, and delete ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant/haengematte/tree/master/java){:new_window} with HTTP and JSON libraries.
-   [Create, read, update, and delete ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant/haengematte/tree/master/java/CrudWithEktorp){:new_window} with ektorp library.
-   [Building apps by using Java with {{site.data.keyword.cloudant_short_notm}} on {{site.data.keyword.cloud}}![External link icon](../images/launch-glyph.svg "External link icon")](https://cloudant.com/blog/building-apps-using-java-with-cloudant-on-ibm-bluemix/){:new_window}.
-   [Build a game app with Liberty, {{site.data.keyword.cloudant_short_notm}}, and Single Sign On ![External link icon](../images/launch-glyph.svg "External link icon")](http://www.ibm.com/developerworks/cloud/library/cl-multiservicegame-app/index.html?ca=drs-){:new_window} {{site.data.keyword.cloud_notm}} example.
-   [Building a Java EE app on {{site.data.keyword.cloud_notm}} by using Watson and {{site.data.keyword.cloudant_short_notm}} ![External link icon](../images/launch-glyph.svg "External link icon")](https://developer.ibm.com/bluemix/2014/10/17/building-java-ee-app-ibm-bluemix-using-watson-cloudant/){:new_window} {{site.data.keyword.cloud_notm}} example along with [YouTube video ![External link icon](../images/launch-glyph.svg "External link icon")](https://www.youtube.com/watch?feature=youtu.be&v=9AFMY6m0LIU&app=desktop){:new_window}.


## Node.js

[nodejs-cloudant ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant/nodejs-cloudant){:new_window}
is the official {{site.data.keyword.cloudant_short_notm}} library for Node.js.
You can install it with npm:

```sh
npm install cloudant
```
{:codeblock}

### Libraries and frameworks for node.js

#### Supported library for node.js

-   [nodejs-cloudant ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant/nodejs-cloudant){:new_window} ([npm ![External link icon](../images/launch-glyph.svg "External link icon")](https://www.npmjs.com/package/@cloudant/cloudant){:new_window}).

#### Unsupported libraries and frameworks for node.js

-   [sag-js ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/sbisbee/sag-js){:new_window}, which also works in the browser.
    See [saggingcouch ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/sbisbee/saggingcouch.com){:new_window} for more detail.
-   [nano ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/dscape/nano){:new_window} is a minimalist implementation.
-   [restler ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/danwrong/restler){:new_window} delivers the best performance but is really barebones.
-   [cradle ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/flatiron/cradle){:new_window} is a high-level client that is also available
    if you absolutely need ease of use at the cost of reduced performance.
-   [cane_passport ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/ddemichele/cane_passport){:new_window} - {{site.data.keyword.cloudant_short_notm}} Angular Node Express with Bootstrap.
-   [express-cloudant ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant-labs/express-cloudant){:new_window} - a template for Node.js Express framework that also uses PouchDB and Grunt.
-   [Node.js {{site.data.keyword.cloudant_short_notm}} DB Web Starter ![External link icon](../images/launch-glyph.svg "External link icon")](https://ace.ng.bluemix.net/#/store/cloudOEPaneId=store&appTemplateGuid=nodejscloudantbp&fromCatalog=true){:new_window} - boilerplate for {{site.data.keyword.cloud_notm}}.
-   [Mobile Cloud ![External link icon](../images/launch-glyph.svg "External link icon")](https://ace.ng.bluemix.net/#/store/cloudOEPaneId=store&appTemplateGuid=mobileBackendStarter&fromCatalog=true){:new_window} - boiler plate for {{site.data.keyword.cloud_notm}} (Node.js, Security, Push, and Mobile Data/{{site.data.keyword.cloudant_short_notm}}).

### Examples and tutorials for node.js

-   [Create, read, update, and delete ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant/haengematte/tree/master/nodejs){:new_window}.
-   [Cloudant-Uploader ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/garbados/Cloudant-Uploader){:new_window} - utility to upload `.csv` files to {{site.data.keyword.cloudant_short_notm}}.
-   [couchimport ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/glynnbird/couchimport){:new_window} - utility to import `.csv` or `.tsv` files into CouchDB or {{site.data.keyword.cloudant_short_notm}}.
-   [Getting started with {{site.data.keyword.cloud_notm}} and Node.js ![External link icon](../images/launch-glyph.svg "External link icon")](http://thoughtsoncloud.com/2014/07/getting-started-ibm-bluemix-node-js/){:new_window}.
-   [A Cloud medley with {{site.data.keyword.cloud_notm}}, {{site.data.keyword.cloudant_short_notm}}, and Node.js ![External link icon](../images/launch-glyph.svg "External link icon")](https://gigadom.wordpress.com/2014/08/15/a-cloud-medley-with-ibm-bluemix-cloudant-db-and-node-js/){:new_window}.
-   [Build a simple word game app by using {{site.data.keyword.cloudant_short_notm}} on {{site.data.keyword.cloud_notm}} ![External link icon](../images/launch-glyph.svg "External link icon")](http://www.ibm.com/developerworks/cloud/library/cl-guesstheword-app/index.html?ca=drs-){:new_window} - uses Node.js.
-   [Building a Real-time SMS Voting App ![External link icon](../images/launch-glyph.svg "External link icon")](https://www.twilio.com/blog/2012/09/building-a-real-time-sms-voting-app-part-1-node-js-couchdb.html){:new_window} - six-part series that uses Node.js, Twilio, and {{site.data.keyword.cloudant_short_notm}}.
-   [Building a multitier Windows Azure Web application ![External link icon](../images/launch-glyph.svg "External link icon")](https://www.ampower.me/article/CouchDB/Tutorial-Building-a-Multi-Tier-Windows-Azure-Web-application-use-Cloudants-Couchdb-as-a-Service-node-94-409665?eqs=Z2NWNlltTmlUWStWcHdEWENWc3UxdmowREpiMjlGUVpKajJOZGJpSlVkemlPS2oxa0YxZE5BPT0=){:new_window} - uses {{site.data.keyword.cloudant_short_notm}}, Node.js, CORS, and Grunt.
-   [Do it yourself: Build a remote surveillance application by using {{site.data.keyword.cloud_notm}}, {{site.data.keyword.cloudant_short_notm}}, and Raspberry Pi. ![External link icon](../images/launch-glyph.svg "External link icon")](http://www.ibm.com/developerworks/library/ba-remoteservpi-app/index.html){:new_window}.

## Python

A supported library for working with {{site.data.keyword.cloudant_short_notm}} by using Python is
available [here ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant/python-cloudant){:new_window}.

>   **Note:** Python applications that access {{site.data.keyword.cloudant_short_notm}} have component dependencies. These dependencies must be specified in a `requirements.txt` file. For more information, see [here ![External link icon](../images/launch-glyph.svg "External link icon")](https://pip.readthedocs.io/en/1.1/requirements.html){:new_window}.

Download the current library release [here ![External link icon](../images/launch-glyph.svg "External link icon")](https://pypi.python.org/pypi/cloudant/){:new_window}.
Learn more information about the Python language at [python.org ![External link icon](../images/launch-glyph.svg "External link icon")](https://www.python.org/about/){:new_window}. 

## Swift

A supported library is available for working with {{site.data.keyword.cloudant_short_notm}}.
The library is called SwiftCloudant,
and is installed by using `cocoapods`.

The podfile entry is:

```sh
pod 'SwiftCloudant'
```
{:codeblock}

More information about SwiftCloudant,
including details of installation and how to use the library to store,
index,
and query remote JSON data on {{site.data.keyword.cloudant_short_notm}},
is available [here ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant/swift-cloudant){:new_window}.

The library is an early release version.
As such,
it does not currently have complete {{site.data.keyword.cloudant_short_notm}} API coverage. 

>   **Note**: SwiftCloudant is not supported on iOS, and you cannot call it from Objective-C.