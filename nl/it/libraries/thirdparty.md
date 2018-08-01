---

copyright:
  years: 2015, 2018
lastupdated: "2018-06-07"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

# Librerie client di terze parti

>   **Nota**: le librerie client di terze parti non sono gestite o supportate da {{site.data.keyword.cloudantfull}}.

## Librerie mobili di terze parti

Utilizzo di un database {{site.data.keyword.cloudant_short_notm}}

-   [IBM Worklight Powered Native Objective-C iOS Apps ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://www.tricedesigns.com/2014/11/17/ibm-worklight-powered-native-objective-c-ios-apps/){:new_window} con un adattatore {{site.data.keyword.cloudant_short_notm}}.

## C# / .NET

[MyCouch ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/danielwertheim/mycouch){:new_window}
è un client CouchDB e {{site.data.keyword.cloudant_short_notm}} asincrono per .Net.

Per installare la libreria, apri la console del gestore pacchetti e richiama:

```
install-package mycouch.cloudant
```
{:codeblock}

### Librerie e framework per C# / .NET

-   [MyCouch ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/danielwertheim/mycouch){:new_window}.
-   [LoveSeat ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/soitgoes/LoveSeat){:new_window}.
-   [Divan ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/foretagsplatsen/Divan){:new_window}.
-   [Relax ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/arobson/Relax){:new_window}.
-   [Hammock ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://code.google.com/p/relax-net/){:new_window}.
-   [EasyCouchDB ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/hhariri/EasyCouchDB){:new_window}.
-   `WDK.API.CouchDB` da [Kanapes IDE ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://kanapeside.com/){:new_window}.

### Esempi ed esercitazioni per C# / .NET

-   [CRUD ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/cloudant/haengematte/tree/master/c%23){:new_window}.

## PHP

[Sag ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/sbisbee/sag){:new_window} è il client CouchDB e {{site.data.keyword.cloudant_short_notm}} di PHP.
[Sag.js ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/sbisbee/sag-js){:new_window} è una controparte JavaScript di Sag.

Installare, scaricare
`sag` da [https://github.com/sbisbee/sag ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/sbisbee/sag){:new_window},
e quindi includere la libreria nella tua applicazione:

```
require_once('./src/Sag.php');
```
{:codeblock}

### Librerie e framework per PHP

-   [sag ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/sbisbee/sag){:new_window}.
-   [Doctrine CouchDB Client ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/doctrine/couchdb-client){:new_window}.
-   [PHP-on-Couch ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/dready92/PHP-on-Couch){:new_window}.

### Esempi ed esercitazioni per PHP

-   [CRUD ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/cloudant/haengematte/tree/master/php){:new_window}.

## JavaScript

[PouchDB ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://pouchdb.com/){:new_window} è un database JavaScript che puoi sincronizzare con {{site.data.keyword.cloudant_short_notm}},
il che significa che puoi rendere le tue applicazioni pronte offline semplicemente utilizzando PouchDB.
Per ulteriori informazioni, consulta
il [nostro post nel blog
![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://cloudant.com/blog/pouchdb){:new_window} in PouchDB.

Per ottenere PouchDB e per i dettagli sulla configurazione, fai riferimento a
[PouchDB ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://pouchdb.com/){:new_window}.

>   **Nota**: PouchDB è anche disponibile per Node.js: `npm install pouchdb`.

>   **Nota**: PouchDB può essere installato anche con Bower: `bower install pouchdb`.

### Librerie e framework per JavaScript

-   [Backbone.cloudant ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/cloudant-labs/backbone.cloudant){:new_window}.
    Consulta il [post nel blog ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://cloudant.com/blog/backbone-and-cloudant/){:new_window} per ulteriori informazioni.
-   [sag.js ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/sbisbee/sag-js){:new_window}.
-   [PouchDB ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://pouchdb.com/){:new_window} -
    database JavaScript per il browser, con la sincronizzazione offline.

### Esempi ed esercitazioni per JavaScript

-   [CRUD ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/cloudant/haengematte/tree/master/javascript-jquery){:new_window} utilizzando jQuery.
-   [CSVtoCloudant ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/michellephung/CSVtoCloudant){:new_window} -
    IU per l'importazione dei file `.csv` in {{site.data.keyword.cloudant_short_notm}}.
    È anche possibile accedere all'applicazione [qui ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://michellephung.github.io/CSVtoCloudant/){:new_window}.
-   [csv2couchdb ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/Mango-information-systems/csv2couchdb){:new_window} -
    IU dei sistemi Mango per importare i file `.csv` in CouchDB/{{site.data.keyword.cloudant_short_notm}}.
-   [songblog ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/millayr/songblog){:new_window} - applicazione di esempio utilizzando JQuery.
-   [Guida introduttiva di PouchDB ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://pouchdb.com/getting-started.html){:new_window} -
    applicazione Todo di esempio che esegue la sincronizzazione dal browser a {{site.data.keyword.cloudant_short_notm}} o CouchDB.
-   [locationtracker ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/rajrsingh/locationtracker){:new_window} -
    applicazione di esempio per registrare e associare una posizione utilizzando PouchDB,
    CouchApp
    e {{site.data.keyword.cloudant_short_notm}}.

## Ruby

[CouchRest ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/couchrest/couchrest){:new_window} è un client CouchDB e {{site.data.keyword.cloudant_short_notm}}
con estensioni per lavorare con Rails utilizzando [CouchRest Model ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/couchrest/couchrest_model){:new_window}.

Per installare CouchRest, esegui il comando:

```sh
gem install couchrest
```
{:codeblock}

### Librerie e framework per Ruby

Molti client CouchDB sono elencati in
[Ruby Toolbox ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://www.ruby-toolbox.com/categories/couchdb_clients){:new_window}.

### Esempi ed esercitazioni per Ruby

-   [CRUD ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/cloudant/haengematte/tree/master/ruby){:new_window}.

<div id="couchdb"></div>

## Meteor

[cloudant:couchdb ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://atmospherejs.com/cloudant/couchdb){:new_window} è la
libreria {{site.data.keyword.cloudant_short_notm}} per il pacchetto `couchdb-meteor`.
Poiché Apache CouchDB non viene fornito con Meteor o il pacchetto couchdb,
devi fornire a Meteor un URL per connettersi
a un'istanza del server CouchDB o {{site.data.keyword.cloudant_short_notm}} in esecuzione prima di installare Meteor.
Aggiungi questo pacchetto
alla tua applicazione Meteor:

```sh
meteor add cloudant:couchdb
```
{:codeblock}

Il pacchetto couchdb-meteor fornisce:

-   Implementazione query live e aggiornamenti in tempo reale dal database utilizzando il feed `_changes` CouchDB.
-   Endpoint RPC DDP (Distributed Data Protocol) che aggiornano i dati dai client connessi localmente.
-   Serializzazione e deserializzazione degli aggiornamenti al formato DDP.

>   **Nota**: la sintassi di query JSON utilizzata da {{site.data.keyword.cloudant_short_notm}} Query
    e inizialmente sviluppata da {{site.data.keyword.cloudant_short_notm}},
    è stata restituita ad Apache CouchDB per la versione 2.0.
    I file binari precostruiti per Apache CouchDB versione 2.0
   non sono ancora disponibili.
    Puoi utilizzare questo modulo con {{site.data.keyword.cloudant_short_notm}} DBaaS o Cloudant locale fino a che non saranno disponibili i file binari precostruiti.

Per configurare le informazioni di connessione al server Apache CouchDB o {{site.data.keyword.cloudant_short_notm}},
passa il suo URL come variabile di ambiente `COUCHDB_URL` al processo del server Meteor:

```sh
$ export COUCHDB_URL=https://username:password@username.cloudant.com
```
{:codeblock}

Consulta la [Guida di riferimento API](../api/index.html) per ulteriori informazioni sulle API meteor-couchdb. 

## Apache Spark

Le [estensioni Apache Bahir per Apache Spark  ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://bahir.apache.org/#home){:new_window}
includono un connettore `spark-sql-cloudant` che è la libreria {{site.data.keyword.cloudant_short_notm}} per Apache Spark.

Il connettore spark-sql-cloudant è già caricato nell'offerta di
[{{site.data.keyword.cloud_notm}} Apache Spark-as-a-Service ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://console.ng.bluemix.net/catalog/services/apache-spark/){:new_window}.
Può essere utilizzata con qualsiasi cluster Spark autonomo.

Per ulteriori dettagli, vedi le [informazioni sul progetto ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/apache/bahir/tree/master/sql-cloudant){:new_window}
e la [documentazione Apache Bahir spark-sql-cloudant![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://bahir.apache.org/docs/spark/current/spark-sql-cloudant/){:new_window}.
