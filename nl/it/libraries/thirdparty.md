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

# Librerie client di terze parti 

>   **Nota**: le librerie client di terze parti non sono conservate o supportate da Cloudant.

## Librerie mobili di terze parti

Utilizzo di un database Cloudant:

-   [IBM Worklight Powered Native Objective-C iOS Apps ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://www.tricedesigns.com/2014/11/17/ibm-worklight-powered-native-objective-c-ios-apps/){:new_window} con un adattatore Cloudant.

## C# / .NET

[MyCouch ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/danielwertheim/mycouch){:new_window}
è un client CouchDB e Cloudant asincrono per .Net.

Per installare la libreria, apri la console del gestore pacchetti e richiama:

```
install-package mycouch.cloudant
```
{:codeblock}

### Librerie e framework

-   [MyCouch ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/danielwertheim/mycouch){:new_window}.
-   [LoveSeat ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/soitgoes/LoveSeat){:new_window}.
-   [Divan ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/foretagsplatsen/Divan){:new_window}.
-   [Relax ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/arobson/Relax){:new_window}.
-   [Hammock ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://code.google.com/p/relax-net/){:new_window}.
-   [EasyCouchDB ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/hhariri/EasyCouchDB){:new_window}.
-   `WDK.API.CouchDB` da [Kanapes IDE ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://kanapeside.com/){:new_window}.

### Esempi ed esercitazioni didattiche

-   [CRUD ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/cloudant/haengematte/tree/master/c%23){:new_window}.

## PHP

[Sag ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/sbisbee/sag){:new_window} è un client CouchDB e Cloudant di PHP.
[Sag.js ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/sbisbee/sag-js){:new_window} è una controparte JavaScript di Sag.

Installare, scaricare
`sag` da [https://github.com/sbisbee/sag ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/sbisbee/sag){:new_window},
e quindi includere la libreria nella tua applicazione:

```
require_once('./src/Sag.php');
```
{:codeblock}

### Librerie e framework

-   [sag ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/sbisbee/sag){:new_window}.
-   [Doctrine CouchDB Client ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/doctrine/couchdb-client){:new_window}.
-   [PHP-on-Couch ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/dready92/PHP-on-Couch){:new_window}.

### Esempi ed esercitazioni didattiche

-   [CRUD ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/cloudant/haengematte/tree/master/php){:new_window}.

## JavaScript

[PouchDB ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://pouchdb.com/){:new_window} è un database JavaScript che puoi sincronizzare con Cloudant, il che significa che puoi rendere le tue applicazioni
pronte offline utilizzando PouchDB.
Per ulteriori informazioni, consulta
il [nostro post nel blog
![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://cloudant.com/blog/pouchdb){:new_window} in PouchDB.

Per ottenere PouchDB e per i dettagli sulla configurazione, fai riferimento a
[PouchDB ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://pouchdb.com/){:new_window}.

>   **Nota**: PouchDB è anche disponibile per Node.js: `npm install pouchdb`.

>   **Nota**: PouchDB può essere installato anche con Bower: `bower install pouchdb`.

### Librerie e framework

-   [Backbone.cloudant ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/cloudant-labs/backbone.cloudant){:new_window}.
    Consulta il [post nel blog ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://cloudant.com/blog/backbone-and-cloudant/){:new_window} per ulteriori informazioni.
-   [sag.js ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/sbisbee/sag-js){:new_window}.
-   [PouchDB ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://pouchdb.com/){:new_window} -
    database JavaScript per il browser, con la sincronizzazione offline.

### Esempi ed esercitazioni didattiche

-   [CRUD ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/cloudant/haengematte/tree/master/javascript-jquery){:new_window} utilizzando jQuery.
-   [CSVtoCloudant ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/michellephung/CSVtoCloudant){:new_window} -
    IU per l'importazione dei file `.csv` in Cloudant.
    È anche possibile accedere all'applicazione [qui ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://michellephung.github.io/CSVtoCloudant/){:new_window}.
-   [csv2couchdb ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/Mango-information-systems/csv2couchdb){:new_window} -
    IU dai sistemi Mango per importare i file `.csv` in CouchDB/Cloudant.
-   [songblog ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/millayr/songblog){:new_window} - applicazione di esempio utilizzando JQuery.
-   [PouchDB Getting Started Guide ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://pouchdb.com/getting-started.html){:new_window} -
    applicazione Todo di esempio che esegue la sincronizzazione dal browser a Cloudant o CouchDB.
-   [locationtracker ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/rajrsingh/locationtracker){:new_window} -
    applicazione di esempio per registrare e associare una posizione utilizzando PouchDB, CouchApp e Cloudant.

## Ruby

[CouchRest ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/couchrest/couchrest){:new_window}
è un client CouchDB e Cloudant con estensioni per lavorare Rails utilizzando [CouchRest Model ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/couchrest/couchrest_model){:new_window}.

Per installare CouchRest, esegui il comando:

```sh
gem install couchrest
```
{:codeblock}

### Librerie e framework

Molti client CouchDB sono elencati in
[Ruby Toolbox ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://www.ruby-toolbox.com/categories/couchdb_clients){:new_window}.

### Esempi ed esercitazioni didattiche

-   [CRUD ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/cloudant/haengematte/tree/master/ruby){:new_window}.

<div id="couchdb"></div>

## Meteor

[cloudant:couchdb ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://atmospherejs.com/cloudant/couchdb){:new_window}
è la libreria Cloudant per il pacchetto `couchdb-meteor`.
Siccome Apache CouchDB non è inviato con Meteor o il pacchetto couchdb,
devi fornire un URL per Meteor per collegarti o eseguire un'istanza del server
CouchDB o Cloudant prima di installare Meteor. Aggiungi questo pacchetto
alla tua applicazione Meteor:

```sh
meteor add cloudant:couchdb
```
{:codeblock}

Il pacchetto couchdb-meteor fornisce:

-   Implementazione query live e aggiornamenti in tempo reale dal database utilizzando il feed `_changes` CouchDB.
-   Endpoint RPC DDP (Distributed Data Protocol) che aggiornano i dati dai client collegati localmente. 
-   Serializzazione e deserializzazione degli aggiornamenti al formato DDP. 

>   **Nota**: la sintassi della query JSON utilizzata da Cloudant Query,
   e inizialmente sviluppata da
   Cloudant, è stata restituita a Apache CouchDB per la
   versione 2.0 I file binari precostruiti per Apache CouchDB versione 2.0
   non sono ancora disponibili.
    Puoi utilizzare questo modulo con Cloudant DBaaS o Cloudant
   Local fino a che non saranno disponibili i file binari precostruiti.

Per configurare le informazioni di connessione al server Apache CouchDB o Cloudant,
trasmetti il relativo URL come la variabile di ambiente `COUCHDB_URL`
al processo del server Meteor:

```sh
$ export COUCHDB_URL=https://username:password@username.cloudant.com
```
{:codeblock}

Consulta la [Guida di riferimento API](../api/index.html) per ulteriori informazioni sulle API meteor-couchdb. 

## Apache Spark

[spark-cloudant ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/cloudant-labs/spark-cloudant){:new_window}
è la libreria Cloudant per Apache Spark.

La libreria spark-cloudant è già stata caricata nell'offerta
[IBM Bluemix Apache Spark-as-a-Service ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://console.ng.bluemix.net/catalog/services/apache-spark/){:new_window}.
Può essere utilizzata con qualsiasi cluster Spark autonomo.

Consulta le [project information
![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/cloudant-labs/spark-cloudant){:new_window}
e [Spark Packages
![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://spark-packages.org/package/cloudant-labs/spark-cloudant){:new_window} per ulteriori dettagli.
