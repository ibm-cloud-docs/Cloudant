---

copyright:
  years: 2015, 2019
lastupdated: "2019-04-16"

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

## Java
{: #java-thirdparty}

### Unsupported libraries for Java
{: #unsupported-for-libraries-for-java-thirdparty}

-   [ektorp ![External link icon](../images/launch-glyph.svg "External link icon")](https://helun.github.io/Ektorp/reference_documentation.html){: new_window}.
-   [jcouchdb ![External link icon](../images/launch-glyph.svg "External link icon")](http://code.google.com/p/jcouchdb/){: new_window}.
-   [jrelax ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/isterin/jrelax){: new_window}.
-   [LightCouch ![External link icon](../images/launch-glyph.svg "External link icon")](http://www.lightcouch.org/){: new_window}.

## JavaScript
{: #javascript}

### Libraries and frameworks for JavaScript
{: #libraries-and-frameworks-for-javascript}

-   [Backbone.cloudant ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant-labs/backbone.cloudant){: new_window}.
    See the [blog post ![External link icon](../images/launch-glyph.svg "External link icon")](https://cloudant.com/blog/backbone-and-cloudant/){: new_window} for more information.
-   [sag.js ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/sbisbee/sag-js){: new_window}.

### Examples and tutorials for JavaScript
{: #examples-and-tutorials-for-javascript}

-   [CRUD ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant/haengematte/tree/master/javascript-jquery){: new_window} using jQuery.
-   [CSVtoCloudant ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/michellephung/CSVtoCloudant){: new_window} -
    UI for importing `.csv` files into {{site.data.keyword.cloudant_short_notm}}.
    The app can also be accessed [here ![External link icon](../images/launch-glyph.svg "External link icon")](https://michellephung.github.io/CSVtoCloudant/){: new_window}.
-   [csv2couchdb ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/Mango-information-systems/csv2couchdb){: new_window} -
    UI from Mango Systems to import `.csv` files to CouchDB/{{site.data.keyword.cloudant_short_notm}}.
-   [songblog ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/millayr/songblog){: new_window} - example app using JQuery.
    
## PouchDB (JavaScript)
{: #pouchdb}

[PouchDB ![External link icon](../images/launch-glyph.svg "External link icon")](http://pouchdb.com/){: new_window} is a JavaScript database that can sync with {{site.data.keyword.cloudant_short_notm}},
meaning you can make your apps offline-ready just by using PouchDB.
For more information,
see [our blog post ![External link icon](../images/launch-glyph.svg "External link icon")](https://cloudant.com/blog/pouchdb){: new_window} on PouchDB.

To obtain PouchDB,
and for setup details,
refer to [PouchDB ![External link icon](../images/launch-glyph.svg "External link icon")](http://pouchdb.com/){: new_window}.

PouchDB is also available for Node.js: `npm install pouchdb`.
{: note}

PouchDB can also be installed with Bower: `bower install pouchdb`.
{: note}

### Libraries and frameworks for PouchDB
{: #libraries-and-frameworks-for-pouchdb}

-   [PouchDB ![External link icon](../images/launch-glyph.svg "External link icon")](http://pouchdb.com/){: new_window} - JavaScript database for browser,
    with offline synchronization.

### Examples and tutorials for PouchDB
{: #examples-and-tutorials-for-pouchdb}

-   [PouchDB Getting Started Guide ![External link icon](../images/launch-glyph.svg "External link icon")](http://pouchdb.com/getting-started.html){: new_window} -
    example Todo application that syncs from browser to {{site.data.keyword.cloudant_short_notm}} or CouchDB.
-   [locationtracker ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/rajrsingh/locationtracker){: new_window} -
    example app to record and map location using PouchDB,
    CouchApp,
    and {{site.data.keyword.cloudant_short_notm}}.

## Node.js
{: #node-js-thirdparty}

### Unsupported libraries and frameworks for node.js
{: #unsupported-libraries-and-frameworks-for-node-js-thirdparty}

-   [sag-js ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/sbisbee/sag-js){: new_window}, which also works in the browser.
    See [saggingcouch ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/sbisbee/saggingcouch.com){: new_window} for more detail.
-   [nano ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/dscape/nano){: new_window} is a minimalist implementation.
-   [restler ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/danwrong/restler){: new_window} delivers the best performance but is really barebones.
-   [cradle ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/flatiron/cradle){: new_window} is a high-level client that is also available
    if you absolutely need ease of use at the cost of reduced performance.
-   [cane_passport ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/ddemichele/cane_passport){: new_window} - {{site.data.keyword.cloudant_short_notm}} Angular Node Express with Bootstrap.
-   [express-cloudant ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant-labs/express-cloudant){: new_window} - a template for Node.js Express framework that also uses PouchDB and Grunt.

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

## Python
{: #python}

### Unsupported libraries and frameworks for Python
{: #unsupported-libraries-and-frameworks-for-python}

-   [requests ![External link icon](../images/launch-glyph.svg "External link icon")](http://docs.python-requests.org/en/master/){: new_window}.

## Ruby
{: #ruby}

[CouchRest ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/couchrest/couchrest){: new_window} is a CouchDB and {{site.data.keyword.cloudant_short_notm}} client
with extensions for working with Rails using the [CouchRest Model ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/couchrest/couchrest_model){: new_window}.

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
Since Apache CouchDB is not included with Meteor or the CouchDB package,
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

For more information about meteor-couchdb APIs, see the [API Reference](/docs/services/Cloudant/api/index.html#api-reference-overview). 
