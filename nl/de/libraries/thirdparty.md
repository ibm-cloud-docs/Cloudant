---

copyright:
  years: 2015, 2019
lastupdated: "2019-04-02"

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

# Clientbibliotheken anderer Anbieter
{: #third-party-client-libraries}

Clientbibliotheken anderer Anbieter werden von {{site.data.keyword.cloudantfull}} nicht verwaltet oder unterstützt.
{: shortdesc}

## C# / .NET
{: #c-net}

[MyCouch ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://github.com/danielwertheim/mycouch){: new_window}
ist ein asynchroner CouchDB- und {{site.data.keyword.cloudant_short_notm}}-Client für .Net.

Um die Bibliothek zu installieren, müssen Sie die Paketmanagerkonsole öffnen und folgenden Befehl aufrufen:

```
install-package mycouch.cloudant
```
{: codeblock}

### Bibliotheken und Frameworks für C# / .NET
{: #libraries-and-frameworks-for-c-net}

-   [MyCouch ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://github.com/danielwertheim/mycouch){: new_window}.
-   [LoveSeat ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://github.com/soitgoes/LoveSeat){: new_window}.
-   [Divan ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://github.com/foretagsplatsen/Divan){: new_window}.
-   [Relax ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://github.com/arobson/Relax){: new_window}.
-   [Hammock ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](http://code.google.com/p/relax-net/){: new_window}.
-   [EasyCouchDB ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://github.com/hhariri/EasyCouchDB){: new_window}.
-   `WDK.API.CouchDB` von [Kanapes IDE ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](http://kanapeside.com/){: new_window}.

### Beispiele und Lernprogramme für C# / .NET
{: #examples-and-tutorials-for-c-net}

-   [CRUD ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://github.com/cloudant/haengematte/tree/master/c%23){: new_window}.

## Java
{: #java}

### Nicht unterstützte Bibliotheken für Java
{: #unsupported-for-libraries-for-java}

-   [ektorp ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://helun.github.io/Ektorp/reference_documentation.html){: new_window}.
-   [jcouchdb ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](http://code.google.com/p/jcouchdb/){: new_window}.
-   [jrelax ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://github.com/isterin/jrelax){: new_window}.
-   [LightCouch ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](http://www.lightcouch.org/){: new_window}.

## JavaScript
{: #javascript}

### Bibliotheken und Frameworks für JavaScript
{: #libraries-and-frameworks-for-javascript}

-   [Backbone.cloudant ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://github.com/cloudant-labs/backbone.cloudant){: new_window}.
    Weitere Informationen finden Sie im [Blogbeitrag ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://cloudant.com/blog/backbone-and-cloudant/){: new_window}.
-   [sag.js ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://github.com/sbisbee/sag-js){: new_window}.

### Beispiele und Lernprogramme für JavaScript
{: #examples-and-tutorials-for-javascript}

-   [CRUD ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://github.com/cloudant/haengematte/tree/master/javascript-jquery){: new_window} mit jQuery.
-   [CSVtoCloudant ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://github.com/michellephung/CSVtoCloudant){: new_window} -
    Benutzerschnittstelle für den Import von `.csv`-Dateien in {{site.data.keyword.cloudant_short_notm}}.
    Auf die App kann auch [hier ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://michellephung.github.io/CSVtoCloudant/){: new_window} zugegriffen werden.
-   [csv2couchdb ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://github.com/Mango-information-systems/csv2couchdb){: new_window} -
    Benutzerschnittstelle von Mango Systems für den Import von `.csv`-Dateien in CouchDB/{{site.data.keyword.cloudant_short_notm}}.
-   [songblog ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://github.com/millayr/songblog){: new_window} - Beispiel-App mit JQuery.
    
## PouchDB (JavaScript)
{: #pouchdb}

[PouchDB ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](http://pouchdb.com/){: new_window} ist eine JavaScript-Datenbank, die mit {{site.data.keyword.cloudant_short_notm}}
synchronisiert werden kann, d. h. Sie können einfach durch Verwendung von PouchDB Ihre Apps offline bereitstellen.
Weitere Informationen finden Sie in
[unserem Blogbeitrag ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://cloudant.com/blog/pouchdb){: new_window} zu PouchDB.

Zum Abrufen von PouchDB sowie für Konfigurationsdetails müssen Sie [PouchDB ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](http://pouchdb.com/){: new_window} zurate ziehen.

PouchDB ist auch für Node.js verfügbar: `npm install pouchdb`.
{: note}

PouchDB kann auch mit Bower installiert werden: `bower install pouchdb`.
{: note}

### Bibliotheken und Frameworks für PouchDB
{: #libraries-and-frameworks-for-pouchdb}

-   [PouchDB ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](http://pouchdb.com/){: new_window} - JavaScript-Datenbank für Browser
    mit Offlinesynchronisierung.

### Beispiele und Lernprogramme für PouchDB
{: #examples-and-tutorials-for-pouchdb}

-   [Leitfaden 'Einführung in PouchDB' ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](http://pouchdb.com/getting-started.html){: new_window} -
    Beispiel für eine To-Do-Anwendung, die vom Browser nach {{site.data.keyword.cloudant_short_notm}} oder CouchDB synchronisiert wird.
-   [locationtracker ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://github.com/rajrsingh/locationtracker){: new_window} -
    Beispiel-App für das Aufzeichnen und Zuordnen von Speicherpositionen mit PouchDB, CouchApp und
    {{site.data.keyword.cloudant_short_notm}}.

## Node.js
{: #node-js}

### Nicht unterstützte Bibliotheken und Frameworks für node.js
{: #unsupported-libraries-and-frameworks-for-node-js-thirdparty}

-   [sag-js ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://github.com/sbisbee/sag-js){: new_window}, die auch im Browser funktioniert.
    Weitere Details finden Sie unter [saggingcouch ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://github.com/sbisbee/saggingcouch.com){: new_window}.
-   [nano ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://github.com/dscape/nano){: new_window} ist eine minimalistische Implementierung.
-   [restler ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://github.com/danwrong/restler){: new_window} liefert die beste Leistung, aber es handelt sich um eine wirklich abgespeckte Version.
-   [cradle ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://github.com/flatiron/cradle){: new_window} ist ein übergeordneter Client, der sich auch dann eignet,
    wenn Benutzerfreundlichkeit Vorrang hat vor den Kosten einer geringeren Leistung.
-   [cane_passport ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://github.com/ddemichele/cane_passport){: new_window} - {{site.data.keyword.cloudant_short_notm}} Angular Node Express mit Bootstrap.
-   [express-cloudant ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://github.com/cloudant-labs/express-cloudant){: new_window} - eine Vorlage für das Node.js Express-Framework, das auch PouchDB und Grunt nutzt.

## PHP
{: #php}

[Sag ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://github.com/sbisbee/sag){: new_window} ist ein CouchDB- und {{site.data.keyword.cloudant_short_notm}}-Client von PHP.
[Sag.js ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://github.com/sbisbee/sag-js){: new_window} ist die JavaScript-Entsprechung von Sag.

Laden Sie für die Installation `sag` von [https://github.com/sbisbee/sag ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://github.com/sbisbee/sag){: new_window} herunter
und schließen Sie die Bibliothek dann in Ihre Anwendung ein.

```
require_once('./src/Sag.php');
```
{: codeblock}

### Bibliotheken und Frameworks für PHP
{: #libraries-and-frameworks-for-php}

-   [sag ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://github.com/sbisbee/sag){: new_window}.
-   [Doctrine CouchDB Client ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://github.com/doctrine/couchdb-client){: new_window}.
-   [PHP-on-Couch ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://github.com/dready92/PHP-on-Couch){: new_window}.

### Beispiele und Lernprogramme für PHP
{: #examples-and-tutorials-for-php}

-   [CRUD ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://github.com/cloudant/haengematte/tree/master/php){: new_window}.

## Python
{: #python}

### Nicht unterstützte Bibliotheken und Frameworks für Python
{: #unsupported-libraries-and-frameworks-for-python}

-   [Anforderungen ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](http://docs.python-requests.org/en/master/){: new_window}.

## Ruby
{: #ruby}

[CouchRest ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://github.com/couchrest/couchrest){: new_window} ist ein CouchDB- und {{site.data.keyword.cloudant_short_notm}}-Client
mit Erweiterungen für die Arbeit mit Rails unter Verwendung des [CouchRest-Modells ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://github.com/couchrest/couchrest_model){: new_window}.

Führen Sie den folgenden Befehl aus, um CouchRest zu installieren:

```sh
gem install couchrest
```
{: codeblock}

### Bibliotheken und Frameworks für Ruby
{: #libraries-and-frameworks-for-ruby}

In der
[Ruby Toolbox ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://www.ruby-toolbox.com/categories/couchdb_clients){: new_window} sind viele CouchDB-Clients aufgeführt.

### Beispiele und Lernprogramme für Ruby
{: #examples-and-tutorials-for-ruby}

-   [CRUD ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://github.com/cloudant/haengematte/tree/master/ruby){: new_window}.

## Meteor
{: #meteor}

[cloudant:couchdb ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://atmospherejs.com/cloudant/couchdb){: new_window} ist die
{{site.data.keyword.cloudant_short_notm}}-Bibliothek für das Paket `couchdb-meteor`.
Da Apache CouchDB nicht in Meteor oder im Paket 'CouchDB' enthalten ist, müssen Sie
eine URL für Meteor bereitstellen, um eine Verbindung zu einer aktiven
CouchDB - oder {{site.data.keyword.cloudant_short_notm}}-Serverinstanz herzustellen, bevor Sie Meteor installieren.
Fügen Sie dieses Paket
zu Ihrer Meteor-Anwendung hinzu:

```sh
meteor add cloudant:couchdb
```
{: codeblock}

Das Paket 'couchdb-meteor' stellt Folgendes bereit:

-   Liveabfrageimplementierung und Echtzeitaktualisierungen aus der Datenbank durch
   Nutzung des CouchDB-Feeds `_changes`.
-   DDP-RPC-Endpunkte (Distributed Data Protocol), die Daten aus lokal verbundenen
   Clients aktualisieren.
-   Serialisierung und Deserialisierung von Aktualisierungen für das DDP-Format.

Die von {{site.data.keyword.cloudant_short_notm}} Query verwendete und ursprünglich von {{site.data.keyword.cloudant_short_notm}} entwickelte JSON-Abfragesyntax wurde für Version 2.0 an Apache CouchDB zurückgegeben. Die vordefinierten Binärdateien für Apache CouchDB Version 2.0 sind noch
   nicht verfügbar. Sie können dieses Modul mit {{site.data.keyword.cloudant_short_notm}} DBaaS oder Cloudant Local verwenden, bis die vordefinierten Binärdateien verfügbar sind.
{: note}

Zur Konfiguration der Angaben für die Apache CouchDB- oder {{site.data.keyword.cloudant_short_notm}}-Serververbindung
müssen Sie die entsprechende URL als Umgebungsvariable `COUCHDB_URL` an den Meteor-Serverprozess übergeben:

```sh
$ export COUCHDB_URL=https://username:password@username.cloudant.com
```
{: codeblock}

Weitere Informationen zu APIs des Typs 'meteor-couchdb' finden Sie in der [API-Referenz](/docs/services/Cloudant/api/index.html#api-reference-overview). 
