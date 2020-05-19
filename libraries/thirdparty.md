---

copyright:
  years: 2015, 2020
lastupdated: "2020-05-14"

keywords: client, mobile, c#, .net, libraries, frameworks, examples, tutorials, php, javascript, ruby, meteor, apache spark, 

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

# Third-party client libraries
{: #third-party-client-libraries}

Third-party client libraries are not maintained or supported by {{site.data.keyword.cloudantfull}}.
{: shortdesc}

## C# / .NET
{: #c-net}

[MyCouch](https://github.com/danielwertheim/mycouch){: new_window}{: external}
is an asynchronous CouchDB and {{site.data.keyword.cloudant_short_notm}} client for .Net.

To install the library,
open the Package manager console,
and invoke the following command:

```
install-package mycouch.cloudant
```
{: codeblock}

### Libraries and frameworks for C# / .NET
{: #libraries-and-frameworks-for-c-net}

- [MyCouch](https://github.com/danielwertheim/mycouch){: new_window}{: external}.
- [LoveSeat](https://github.com/soitgoes/LoveSeat){: new_window}{: external}.
- [Divan](https://github.com/foretagsplatsen/Divan){: new_window}{: external}.
- [Relax](https://github.com/arobson/Relax){: new_window}{: external}.
- [Hammock](http://code.google.com/p/relax-net/){: new_window}{: external}.
- [EasyCouchDB](https://github.com/hhariri/EasyCouchDB){: new_window}{: external}.
- `WDK.API.CouchDB` from [Kanapes IDE](http://kanapeside.com/){: new_window}{: external}.

### Examples and tutorials for C# / .NET
{: #examples-and-tutorials-for-c-net}

- [CRUD](https://github.com/cloudant/haengematte/tree/master/c%23){: new_window}{: external}.

## Java
{: #java-thirdparty}

### Unsupported libraries for Java
{: #unsupported-for-libraries-for-java-thirdparty}

- [Ektorp](https://helun.github.io/Ektorp/reference_documentation.html){: new_window}{: external}.
- [JCouchDB](http://code.google.com/p/jcouchdb/){: new_window}{: external}.
- [JRelax](https://github.com/isterin/jrelax){: new_window}{: external}.
- [LightCouch](http://www.lightcouch.org/){: new_window}{: external}.

## JavaScript
{: #javascript}

### Libraries and frameworks for JavaScript
{: #libraries-and-frameworks-for-javascript}

- [Backbone.cloudant](https://github.com/cloudant-labs/backbone.cloudant){: new_window}{: external}.
- [Sag.js](https://github.com/sbisbee/sag-js){: new_window}{: external}.

### Examples and tutorials for JavaScript
{: #examples-and-tutorials-for-javascript}

- [CRUD](https://github.com/cloudant/haengematte/tree/master/javascript-jquery){: new_window}{: external} operations that use jQuery.
- [CSVtoCloudant](https://github.com/michellephung/CSVtoCloudant){: new_window}{: external} - UI for importing `.csv` files into {{site.data.keyword.cloudant_short_notm}}. The app can also be accessed [here](https://michellephung.github.io/CSVtoCloudant/){: new_window}.
- [Csv2couchdb](https://github.com/Mango-information-systems/csv2couchdb){: new_window}{: external} - UI from Mango Systems to import `.csv` files to CouchDB/{{site.data.keyword.cloudant_short_notm}}.
- [Songblog](https://github.com/millayr/songblog){: new_window}{: external} - example app that uses JQuery.
    
## PouchDB (JavaScript)
{: #pouchdb-javascript}

[PouchDB](http://pouchdb.com/){: new_window}{: external} is a JavaScript&trade; database that can synchronize with {{site.data.keyword.cloudant_short_notm}},
meaning you can make your apps offline-ready by using PouchDB. For more information,
see [our blog post](https://cloudant.com/blog/pouchdb){: new_window}{: external} on PouchDB.

For more information, see the [PouchDB](http://pouchdb.com/){: new_window}{: external} website about downloading and setting up PouchDB.

PouchDB is also available for Node.js: `npm install pouchdb`.
{: note}

PouchDB can also be installed with Bower: `bower install pouchdb`.
{: note}

### Libraries and frameworks for PouchDB
{: #libraries-and-frameworks-for-pouchdb}

- [PouchDB](http://pouchdb.com/){: new_window}{: external} - JavaScript database for browser, with offline synchronization.

### Examples and tutorials for PouchDB
{: #examples-and-tutorials-for-pouchdb}

- [PouchDB Getting Started Guide](http://pouchdb.com/getting-started.html){: new_window}{: external} - example to do application that synchronizes from browser to {{site.data.keyword.cloudant_short_notm}} or CouchDB.
- [Location tracker](https://github.com/rajrsingh/locationtracker){: new_window}{: external} - example app to record and map locations by using PouchDB, CouchApp, and {{site.data.keyword.cloudant_short_notm}}.

## Node.js
{: #node-js-thirdparty}

### Unsupported libraries and frameworks for Node.js
{: #unsupported-libraries-and-frameworks-for-node-js-thirdparty}

- [Sag-JS](https://github.com/sbisbee/sag-js){: new_window}{: external}, which also works in the browser. For more information, see [sagging couch](https://github.com/sbisbee/saggingcouch.com){: new_window}{: external} for more detail.
- [Nano](https://github.com/dscape/nano){: new_window}{: external} is a minimalist implementation.
- [Restler](https://github.com/danwrong/restler){: new_window}{: external} delivers the best performance but is really barebones.
- [Cradle](https://github.com/flatiron/cradle){: new_window}{: external} is a high-level client that is also available if you absolutely need ease of use at the cost of reduced performance.
- [Cane_passport](https://github.com/ddemichele/cane_passport){: new_window}{: external} - {{site.data.keyword.cloudant_short_notm}} Angular Node Express with Bootstrap.
- [Express-Cloudant](https://github.com/cloudant-labs/express-cloudant){: new_window}{: external} - a template for Node.js Express framework that also uses PouchDB and Grunt.

## PHP
{: #php}

[Sag](https://github.com/sbisbee/sag){: new_window}{: external} is PHP's CouchDB and {{site.data.keyword.cloudant_short_notm}} client.
[Sag.js](https://github.com/sbisbee/sag-js){: new_window}{: external} is Sag's JavaScript counterpart.

To install,
download `sag` from [https://github.com/sbisbee/sag](https://github.com/sbisbee/sag){: new_window}{: external},
then include the library in your application:

```
require_once('./src/Sag.php');
```
{: codeblock}

### Libraries and frameworks for PHP
{: #libraries-and-frameworks-for-php}

- [Sag](https://github.com/sbisbee/sag){: new_window}{: external}.
- [Doctrine CouchDB Client](https://github.com/doctrine/couchdb-client){: new_window}{: external}.
- [PHP-on-Couch](https://github.com/dready92/PHP-on-Couch){: new_window}{: external}.

### Examples and tutorials for PHP
{: #examples-and-tutorials-for-php}

- [CRUD](https://github.com/cloudant/haengematte/tree/master/php){: new_window}{: external}.

## Python
{: #python-tp}

### Unsupported libraries and frameworks for Python
{: #unsupported-libraries-and-frameworks-for-python}

- [Requests](http://docs.python-requests.org/en/master/){: new_window}{: external}.

## Ruby
{: #ruby}

[CouchRest](https://github.com/couchrest/couchrest){: new_window}{: external} is a CouchDB and {{site.data.keyword.cloudant_short_notm}} client
with extensions for working with Rails by using the [CouchRest Model](https://github.com/couchrest/couchrest_model){: new_window}{: external}.

To install CouchRest,
run the command:

```sh
gem install couchrest
```
{: codeblock}

### Libraries and frameworks for Ruby
{: #libraries-and-frameworks-for-ruby}

[Ruby toolbox](https://www.ruby-toolbox.com/categories/couchdb_clients){: new_window}{: external} lists many CouchDB clients.

### Examples and tutorials for Ruby
{: #examples-and-tutorials-for-ruby}

- [CRUD](https://github.com/cloudant/haengematte/tree/master/ruby){: new_window}{: external}.

## Meteor
{: #meteor}

[`cloudant:couchdb`](https://atmospherejs.com/cloudant/couchdb){: new_window}{: external} is the
{{site.data.keyword.cloudant_short_notm}} library for the `couchdb-meteor` package.
Apache CouchDB isn't included with Meteor or the CouchDB package. You must provide a URL for Meteor to connect
to a running CouchDB or {{site.data.keyword.cloudant_short_notm}} server instance before you install Meteor.
Add this package to your Meteor application:

```sh
meteor add cloudant:couchdb
```
{: codeblock}

The `couchdb-meteor` package includes the following features:

- Live Query implementation and real-time updates from the database by consuming the CouchDB `_changes` feed.
- Distributed Data Protocol (DDP) RPC endpoints that update data from clients that are connected locally.
- Serialization and deserialization of updates to the DDP format.

To configure the Apache CouchDB or {{site.data.keyword.cloudant_short_notm}} server connection information,
pass its URL as the `COUCHDB_URL` environment variable to the Meteor server process:

```sh
$ export COUCHDB_URL=https://username:password@username.cloudant.com
```
{: codeblock}

For more information, see the [API Reference](/docs/Cloudant?topic=Cloudant-api-reference-overview#api-reference-overview) about meteor-couchdb APIs. 
