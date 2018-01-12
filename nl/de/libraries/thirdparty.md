---

copyright:
  years: 2015, 2017
lastupdated: "2017-01-04"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

# Clientbibliotheken anderer Anbieter

>   **Hinweis**: Clientbibliotheken anderer Anbieter werden von Cloudant nicht verwaltet oder unterstützt. 

## Mobile Bibliotheken anderer Anbieter

Arbeit mit einer Cloudant-Datenbank: 

-   [Mit IBM Worklight angetriebene native Objective-C-iOS-Apps ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](http://www.tricedesigns.com/2014/11/17/ibm-worklight-powered-native-objective-c-ios-apps/){:new_window} mit einem Cloudant-Adapter. 

## C# / .NET

[MyCouch ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://github.com/danielwertheim/mycouch){:new_window}
ist ein asynchroner CouchDB- und Cloudant-Client für .Net.

Um die Bibliothek zu installieren, müssen Sie die Paketmanagerkonsole öffnen und folgenden Befehl aufrufen:

```
install-package mycouch.cloudant
```
{:codeblock}

### Bibliotheken und Frameworks

-   [MyCouch ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://github.com/danielwertheim/mycouch){:new_window}.
-   [LoveSeat ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://github.com/soitgoes/LoveSeat){:new_window}.
-   [Divan ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://github.com/foretagsplatsen/Divan){:new_window}.
-   [Relax ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://github.com/arobson/Relax){:new_window}.
-   [Hammock ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](http://code.google.com/p/relax-net/){:new_window}.
-   [EasyCouchDB ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://github.com/hhariri/EasyCouchDB){:new_window}.
-   `WDK.API.CouchDB` von [Kanapes IDE ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](http://kanapeside.com/){:new_window}.

### Beispiele und Lernprogramme

-   [CRUD ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://github.com/cloudant/haengematte/tree/master/c%23){:new_window}.

## PHP

[Sag ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://github.com/sbisbee/sag){:new_window} ist ein CouchDB- und Cloudant-Client von PHP.
[Sag.js ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://github.com/sbisbee/sag-js){:new_window} ist die JavaScript-Entsprechung von Sag. 

Laden Sie für die Installation `sag` von [https://github.com/sbisbee/sag ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://github.com/sbisbee/sag){:new_window} herunter
und schließen Sie die Bibliothek dann in Ihre Anwendung ein. 

```
require_once('./src/Sag.php');
```
{:codeblock}

### Bibliotheken und Frameworks

-   [sag ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://github.com/sbisbee/sag){:new_window}.
-   [Doctrine CouchDB Client ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://github.com/doctrine/couchdb-client){:new_window}.
-   [PHP-on-Couch ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://github.com/dready92/PHP-on-Couch){:new_window}.

### Beispiele und Lernprogramme

-   [CRUD ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://github.com/cloudant/haengematte/tree/master/php){:new_window}.

## JavaScript

[PouchDB ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](http://pouchdb.com/){:new_window} ist eine JavaScript-Datenbank, die mit Cloudant
synchronisiert werden kann, d. h., Sie können einfach durch Verwendung von PouchDB Ihre Apps offline bereitstellen.
Weitere Informationen finden Sie in [unserem Blogbeitrag ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://cloudant.com/blog/pouchdb){:new_window} auf PouchDB. 

Zum Abrufen von PouchDB sowie für Konfigurationsdetails müssen Sie [PouchDB ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](http://pouchdb.com/){:new_window} zurate ziehen. 

>   **Hinweis**: PouchDB ist auch für Node.js verfügbar: `npm install pouchdb`.

>   **Hinweis**: PouchDB kann auch mit Bower installiert werden: `bower install pouchdb`.

### Bibliotheken und Frameworks

-   [Backbone.cloudant ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://github.com/cloudant-labs/backbone.cloudant){:new_window}.
    Weitere Informationen finden Sie im [Blogbeitrag ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://cloudant.com/blog/backbone-and-cloudant/){:new_window}. 
-   [sag.js ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://github.com/sbisbee/sag-js){:new_window}.
-   [PouchDB ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](http://pouchdb.com/){:new_window} - JavaScript-Datenbank für Browser
    mit Offlinesynchronisierung. 

### Beispiele und Lernprogramme

-   [CRUD ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://github.com/cloudant/haengematte/tree/master/javascript-jquery){:new_window} mit jQuery. 
-   [CSVtoCloudant ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://github.com/michellephung/CSVtoCloudant){:new_window} -
    Benutzerschnittstelle für den Import von `.csv`-Dateien in Cloudant.
    Auf die App kann auch [hier ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://michellephung.github.io/CSVtoCloudant/){:new_window} zugegriffen werden. 
-   [csv2couchdb ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://github.com/Mango-information-systems/csv2couchdb){:new_window} -
    Benutzerschnittstelle von Mango Systems für den Import von `.csv`-Dateien in CouchDB/Cloudant. 
-   [songblog ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://github.com/millayr/songblog){:new_window} - Beispiel-App mit JQuery. 
-   [Leitfaden 'Einführung in PouchDB' ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](http://pouchdb.com/getting-started.html){:new_window} -
    Beispiel für eine To-Do-Anwendung, die vom Browser nach Cloudant oder CouchDB synchronisiert wird. 
-   [locationtracker ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://github.com/rajrsingh/locationtracker){:new_window} -
    Beispiel-App für das Aufzeichnen und Zuordnen von Speicherpositionen mit PouchDB,
    CouchApp und Cloudant. 

## Ruby

[CouchRest ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://github.com/couchrest/couchrest){:new_window} ist ein CouchDB- und Cloudant-Client
mit Erweiterungen für die Arbeit mit Rails unter Verwendung eines [CouchRest-Modells ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://github.com/couchrest/couchrest_model){:new_window}.

Führen Sie den folgenden Befehl aus, um CouchRest zu installieren:

```sh
gem install couchrest
```
{:codeblock}

### Bibliotheken und Frameworks

In der
[Ruby Toolbox ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://www.ruby-toolbox.com/categories/couchdb_clients){:new_window} sind viele CouchDB-Clients aufgeführt. 

### Beispiele und Lernprogramme

-   [CRUD ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://github.com/cloudant/haengematte/tree/master/ruby){:new_window}.

<div id="couchdb"></div>

## Meteor

[cloudant:couchdb ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://atmospherejs.com/cloudant/couchdb){:new_window} ist die
Cloudant-Bibliothek für das Paket `couchdb-meteor`.
Da Apache CouchDB nicht mit Meteor oder dem Paket 'couchdb' ausgeliefert wird,
müssen Sie eine URL für Meteor bereitstellen, um eine Verbindung mit einer aktiven
CouchDB- oder Cloudant-Serverinstanz herzustellen, bevor Sie Meteor installieren.
Fügen Sie dieses Paket
zu Ihrer Meteor-Anwendung hinzu:

```sh
meteor add cloudant:couchdb
```
{:codeblock}

Das Paket 'couchdb-meteor' stellt Folgendes bereit:

-   Liveabfrageimplementierung und Echtzeitaktualisierungen aus der Datenbank durch
   Nutzung des CouchDB-Feeds `_changes`. 
-   DDP-RPC-Endpunkte (Distributed Data Protocol), die Daten aus lokal verbundenen
   Clients aktualisieren. 
-   Serialisierung und Deserialisierung von Aktualisierungen für das DDP-Format. 

>   **Hinweis**: Die von Cloudant Query verwendete und 
    ursprünglich von Cloudant entwickelte
   JSON-Abfragesyntax wurde für Version 2.0 an Apache CouchDB
   zurückgegeben.
    Die vordefinierten Binärdateien für Apache CouchDB Version 2.0 sind noch
   nicht verfügbar.
    Sie können dieses Modul mit Cloudant DBaaS oder Cloudant
   Local verwenden, bis die vordefinierten Binärdateien verfügbar sind.

Zur Konfiguration der Angaben für die Apache CouchDB- oder Cloudant-Serververbindung
müssen Sie die entsprechende URL als Umgebungsvariable `COUCHDB_URL` an den
Meteor-Serverprozess übergeben: 

```sh
$ export COUCHDB_URL=https://username:password@username.cloudant.com
```
{:codeblock}

In der [API-Referenz](../api/index.html) finden Sie weitere Informationen zu APIs des
Typs 'meteor-couchdb'.  

## Apache Spark

[spark-cloudant ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://github.com/cloudant-labs/spark-cloudant){:new_window}
ist die Cloudant-Bibliothek für Apache Spark. 

Die Bibliothek 'spark-cloudant' ist bereits in
das Angebot [IBM Bluemix Apache Spark-as-a-Service ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://console.ng.bluemix.net/catalog/services/apache-spark/){:new_window} geladen.
Sie kann mit jedem eigenständigen Spark-Cluster verwendet werden. 

Weitere Details finden Sie in den [Projektinformationen ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://github.com/cloudant-labs/spark-cloudant){:new_window}
und in den [Spark-Paketen ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://spark-packages.org/package/cloudant-labs/spark-cloudant){:new_window}. 
