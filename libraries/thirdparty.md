---

copyright:
  years: 2015, 2019
lastupdated: "2019-02-27"

keywords: client, mobile, c#, .net, libraries, frameworks, examples, tutorials, php, javascript, ruby, meteor, apache spark, 

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

<!-- Acrolinx: 2017-05-10 -->

# Third-party client libraries
{: #third-party-client-libraries}

Third-party client libraries are not maintained or supported by {{site.data.keyword.cloudantfull}}.
{: shortdesc}

## Third-party mobile libraries
{: #third-party-mobile-libraries}

Working with an {{site.data.keyword.cloudant_short_notm}} database:

-   [IBM Worklight Powered Native Objective-C iOS Apps ![External link icon](../images/launch-glyph.svg "External link icon")](http://www.tricedesigns.com/2014/11/17/ibm-worklight-powered-native-objective-c-ios-apps/){: new_window} with an {{site.data.keyword.cloudant_short_notm}} Adapter.

## C# / .NET
{: #c-net}

[MyCouch ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/danielwertheim/mycouch){: new_window}
is an asynchronous CouchDB and {{site.data.keyword.cloudant_short_notm}} client for .Net.

To install the library,
open up the Package manager console,
and invoke:

```
install-package mycouch.cloudant
```
{: codeblock}

### Libraries and frameworks for C# / .NET
{: #libraries-and-frameworks-for-c-net}

-   [MyCouch ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/danielwertheim/mycouch){: new_window}.
-   [LoveSeat ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/soitgoes/LoveSeat){: new_window}.
-   [Divan ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/foretagsplatsen/Divan){: new_window}.
-   [Relax ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/arobson/Relax){: new_window}.
-   [Hammock ![External link icon](../images/launch-glyph.svg "External link icon")](http://code.google.com/p/relax-net/){: new_window}.
-   [EasyCouchDB ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/hhariri/EasyCouchDB){: new_window}.
-   `WDK.API.CouchDB` from [Kanapes IDE ![External link icon](../images/launch-glyph.svg "External link icon")](http://kanapeside.com/){: new_window}.

### Examples and tutorials for C# / .NET
{: #examples-and-tutorials-for-c-net}

-   [CRUD ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant/haengematte/tree/master/c%23){: new_window}.

## PHP
{: #php}

[Sag ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/sbisbee/sag){: new_window} is PHP's CouchDB and {{site.data.keyword.cloudant_short_notm}} client.
[Sag.js ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/sbisbee/sag-js){: new_window} is Sag's JavaScript counterpart.

To install,
download `sag` from [https://github.com/sbisbee/sag ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/sbisbee/sag){: new_window},
then include the library in your application:

```
require_once('./src/Sag.php');
```
{: codeblock}

### Libraries and frameworks for PHP
{: #libraries-and-frameworks-for-php}

-   [sag ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/sbisbee/sag){: new_window}.
-   [Doctrine CouchDB Client ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/doctrine/couchdb-client){: new_window}.
-   [PHP-on-Couch ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/dready92/PHP-on-Couch){: new_window}.

### Examples and tutorials for PHP
{: #examples-and-tutorials-for-php}

-   [CRUD ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant/haengematte/tree/master/php){: new_window}.

## JavaScript
{: #javascript}

[PouchDB ![External link icon](../images/launch-glyph.svg "External link icon")](http://pouchdb.com/){: new_window} is a JavaScript database that can sync with {{site.data.keyword.cloudant_short_notm}},
meaning you can make your apps offline-ready just by using PouchDB.
For more info,
see [our blog post ![External link icon](../images/launch-glyph.svg "External link icon")](https://cloudant.com/blog/pouchdb){: new_window} on PouchDB.

To obtain PouchDB,
and for setup details,
refer to [PouchDB ![External link icon](../images/launch-glyph.svg "External link icon")](http://pouchdb.com/){: new_window}.

PouchDB is also available for Node.js: `npm install pouchdb`.
{: note}

PouchDB can also be installed with Bower: `bower install pouchdb`.
{: note}

### Libraries and frameworks for JavaScript
{: #libraries-and-frameworks-for-javascript}

-   [Backbone.cloudant ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant-labs/backbone.cloudant){: new_window}.
    See the [blog post ![External link icon](../images/launch-glyph.svg "External link icon")](https://cloudant.com/blog/backbone-and-cloudant/){: new_window} for more information.
-   [sag.js ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/sbisbee/sag-js){: new_window}.
-   [PouchDB ![External link icon](../images/launch-glyph.svg "External link icon")](http://pouchdb.com/){: new_window} - JavaScript database for browser,
    with offline synchronization.

### Examples and tutorials for JavaScript
{: #examples-and-tutorials-for-javascript}

-   [CRUD ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant/haengematte/tree/master/javascript-jquery){: new_window} using jQuery.
-   [CSVtoCloudant ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/michellephung/CSVtoCloudant){: new_window} -
    UI for importing `.csv` files into {{site.data.keyword.cloudant_short_notm}}.
    The app can also be accessed [here ![External link icon](../images/launch-glyph.svg "External link icon")](https://michellephung.github.io/CSVtoCloudant/){: new_window}.
-   [csv2couchdb ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/Mango-information-systems/csv2couchdb){: new_window} -
    UI from Mango Systems to import `.csv` files to CouchDB/{{site.data.keyword.cloudant_short_notm}}.
-   [songblog ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/millayr/songblog){: new_window} - example app using JQuery.
-   [PouchDB Getting Started Guide ![External link icon](../images/launch-glyph.svg "External link icon")](http://pouchdb.com/getting-started.html){: new_window} -
    example Todo application that syncs from browser to {{site.data.keyword.cloudant_short_notm}} or CouchDB.
-   [locationtracker ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/rajrsingh/locationtracker){: new_window} -
    example app to record and map location using PouchDB,
    CouchApp,
    and {{site.data.keyword.cloudant_short_notm}}.

## Ruby
{: #ruby}

[CouchRest ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/couchrest/couchrest){: new_window} is a CouchDB and {{site.data.keyword.cloudant_short_notm}} client
with extensions for working with Rails using [CouchRest Model ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/couchrest/couchrest_model){: new_window}.

To install CouchRest,
run the command:

```sh
gem install couchrest
```
{: codeblock}

### Libraries and frameworks for Ruby
{: #libraries-and-frameworks-for-ruby}

There are many CouchDB clients listed on
[Ruby Toolbox ![External link icon](../images/launch-glyph.svg "External link icon")](https://www.ruby-toolbox.com/categories/couchdb_clients){: new_window}.

### Examples and tutorials for Ruby
{: #examples-and-tutorials-for-ruby}

-   [CRUD ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant/haengematte/tree/master/ruby){: new_window}.

## Meteor
{: #meteor}

[cloudant:couchdb ![External link icon](../images/launch-glyph.svg "External link icon")](https://atmospherejs.com/cloudant/couchdb){: new_window} is the
{{site.data.keyword.cloudant_short_notm}} library for the `couchdb-meteor` package.
Since Apache CouchDB does not ship with Meteor or the couchdb package,
you must provide a URL for Meteor to connect
to a running CouchDB or {{site.data.keyword.cloudant_short_notm}} server instance before you install Meteor.
Add this package to your Meteor application:

```sh
meteor add cloudant:couchdb
```
{: codeblock}

The couchdb-meteor package provides:

-   Livequery implementation and real-time updates from the database by consuming the CouchDB `_changes` feed.
-   Distributed Data Protocol (DDP) RPC endpoints that update data from clients connected locally.
-   Serialization and deserialization of updates to the DDP format.

The JSON query syntax used by {{site.data.keyword.cloudant_short_notm}} Query, and initially developed by {{site.data.keyword.cloudant_short_notm}}, was contributed back to Apache CouchDB for version 2.0. Pre-built binaries for Apache CouchDB version 2.0 are not yet available. You can use this module with {{site.data.keyword.cloudant_short_notm}} DBaaS or Cloudant Local until the pre-built binaries are available.
{: note}

To configure the Apache CouchDB or {{site.data.keyword.cloudant_short_notm}} server connection information,
pass its URL as the `COUCHDB_URL` environment variable to the Meteor server process:

```sh
$ export COUCHDB_URL=https://username:password@username.cloudant.com
```
{: codeblock}

See the [API Reference](/docs/services/Cloudant/api/index.html#api-reference-overview) for more information about meteor-couchdb APIs. 

## Apache Spark
{: #apache-spark}

The [Apache Bahir extensions for Apache Spark  ![External link icon](../images/launch-glyph.svg "External link icon")](http://bahir.apache.org/#home){: new_window}
include a `spark-sql-cloudant` connector that is the {{site.data.keyword.cloudant_short_notm}} library for Apache Spark.

The spark-sql-cloudant connector is already loaded into the
[{{site.data.keyword.cloud_notm}} Apache Spark-as-a-Service ![External link icon](../images/launch-glyph.svg "External link icon")](https://console.ng.bluemix.net/catalog/services/apache-spark/){: new_window} offering.
It can be used with any stand-alone Spark cluster.

See the [project information ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/apache/bahir/tree/master/sql-cloudant){: new_window}
and [Apache Bahir spark-sql-cloudant documentation ![External link icon](../images/launch-glyph.svg "External link icon")](http://bahir.apache.org/docs/spark/current/spark-sql-cloudant/){: new_window} for more details.