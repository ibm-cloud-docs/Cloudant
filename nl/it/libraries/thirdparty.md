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

# Librerie client di terze parti
{: #third-party-client-libraries}

Le librerie client di terze parti non sono gestite o supportate da {{site.data.keyword.cloudantfull}}.
{: shortdesc}

## C# / .NET
{: #c-net}

[MyCouch ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/danielwertheim/mycouch){: new_window}
è un client CouchDB e {{site.data.keyword.cloudant_short_notm}} asincrono per .Net.

Per installare la libreria, apri la console del gestore pacchetti e richiama:

```
install-package mycouch.cloudant
```
{: codeblock}

### Librerie e framework per C# / .NET
{: #libraries-and-frameworks-for-c-net}

-   [MyCouch ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/danielwertheim/mycouch){: new_window}.
-   [LoveSeat ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/soitgoes/LoveSeat){: new_window}.
-   [Divan ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/foretagsplatsen/Divan){: new_window}.
-   [Relax ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/arobson/Relax){: new_window}.
-   [Hammock ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://code.google.com/p/relax-net/){: new_window}.
-   [EasyCouchDB ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/hhariri/EasyCouchDB){: new_window}.
-   `WDK.API.CouchDB` da [Kanapes IDE ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://kanapeside.com/){: new_window}.

### Esempi ed esercitazioni per C# / .NET
{: #examples-and-tutorials-for-c-net}

-   [CRUD ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/cloudant/haengematte/tree/master/c%23){: new_window}.

## Java
{: #java}

### Librerie non supportate per Java
{: #unsupported-for-libraries-for-java}

-   [ektorp ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://helun.github.io/Ektorp/reference_documentation.html){: new_window}.
-   [jcouchdb ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://code.google.com/p/jcouchdb/){: new_window}.
-   [jrelax ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/isterin/jrelax){: new_window}.
-   [LightCouch ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://www.lightcouch.org/){: new_window}.

## JavaScript
{: #javascript}

### Librerie e framework per JavaScript
{: #libraries-and-frameworks-for-javascript}

-   [Backbone.cloudant ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/cloudant-labs/backbone.cloudant){: new_window}.
    Consulta il [post nel blog ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://cloudant.com/blog/backbone-and-cloudant/){: new_window} per ulteriori informazioni.
-   [sag.js ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/sbisbee/sag-js){: new_window}.

### Esempi ed esercitazioni per JavaScript
{: #examples-and-tutorials-for-javascript}

-   [CRUD ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/cloudant/haengematte/tree/master/javascript-jquery){: new_window} utilizzando jQuery.
-   [CSVtoCloudant ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/michellephung/CSVtoCloudant){: new_window} -
    IU per l'importazione dei file `.csv` in {{site.data.keyword.cloudant_short_notm}}.
    È anche possibile accedere all'applicazione [qui ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://michellephung.github.io/CSVtoCloudant/){: new_window}.
-   [csv2couchdb ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/Mango-information-systems/csv2couchdb){: new_window} -
    IU dei sistemi Mango per importare i file `.csv` in CouchDB/{{site.data.keyword.cloudant_short_notm}}.
-   [songblog ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/millayr/songblog){: new_window} - applicazione di esempio utilizzando JQuery.
    
## PouchDB (JavaScript)
{: #pouchdb}

[PouchDB ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://pouchdb.com/){: new_window} è un database JavaScript che puoi sincronizzare con {{site.data.keyword.cloudant_short_notm}},
il che significa che puoi rendere le tue applicazioni pronte offline semplicemente utilizzando PouchDB.
Per ulteriori informazioni, consulta il
[nostro post nel blog ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://cloudant.com/blog/pouchdb){: new_window} su PouchDB.

Per ottenere PouchDB e per i dettagli sulla configurazione, fai riferimento a
[PouchDB ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://pouchdb.com/){: new_window}.

PouchDB è anche disponibile per Node.js: `npm install pouchdb`.
{: note}

PouchDB può essere installato anche con Bower: `bower install pouchdb`.
{: note}

### Librerie e framework per PouchDB
{: #libraries-and-frameworks-for-pouchdb}

-   [PouchDB ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://pouchdb.com/){: new_window} -
    database JavaScript per il browser, con la sincronizzazione offline.

### Esempi ed esercitazioni per PouchDB
{: #examples-and-tutorials-for-pouchdb}

-   [Guida introduttiva di PouchDB ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://pouchdb.com/getting-started.html){: new_window} -
    applicazione Todo di esempio che esegue la sincronizzazione dal browser a {{site.data.keyword.cloudant_short_notm}} o CouchDB.
-   [locationtracker ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/rajrsingh/locationtracker){: new_window} -
    applicazione di esempio per registrare e associare una posizione utilizzando PouchDB,
    CouchApp
    e {{site.data.keyword.cloudant_short_notm}}.

## Node.js
{: #node-js}

### Librerie e framework non supportati per node.js
{: #unsupported-libraries-and-frameworks-for-node-js-thirdparty}

-   [sag-js ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/sbisbee/sag-js){: new_window}, che funziona anche nel browser.
    Consulta [saggingcouch ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/sbisbee/saggingcouch.com){: new_window} per ulteriori dettagli.
-   [nano ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/dscape/nano){: new_window} è un'implementazione minimalista.
-   [restler ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/danwrong/restler){: new_window} fornisce le migliori prestazioni ma è molto essenziale.
-   [cradle ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/flatiron/cradle){: new_window}
    è un client di alto livello che è anche disponibile se hai assoluto bisogno di facilità di utilizzo a costo di ridurre le prestazioni.
-   [cane_passport ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/ddemichele/cane_passport){: new_window} - {{site.data.keyword.cloudant_short_notm}} Angular Node Express with Bootstrap.
-   [express-cloudant ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/cloudant-labs/express-cloudant){: new_window} - un modello per il framework Node.js Express che utilizza anche PouchDB e Grunt.

## PHP
{: #php}

[Sag ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/sbisbee/sag){: new_window} è il client CouchDB e {{site.data.keyword.cloudant_short_notm}} di PHP.
[Sag.js ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/sbisbee/sag-js){: new_window} è una controparte JavaScript di Sag.

Installare, scaricare
`sag` da [https://github.com/sbisbee/sag ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/sbisbee/sag){: new_window},
e quindi includere la libreria nella tua applicazione:

```
require_once('./src/Sag.php');
```
{: codeblock}

### Librerie e framework per PHP
{: #libraries-and-frameworks-for-php}

-   [sag ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/sbisbee/sag){: new_window}.
-   [Doctrine CouchDB Client ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/doctrine/couchdb-client){: new_window}.
-   [PHP-on-Couch ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/dready92/PHP-on-Couch){: new_window}.

### Esempi ed esercitazioni per PHP
{: #examples-and-tutorials-for-php}

-   [CRUD ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/cloudant/haengematte/tree/master/php){: new_window}.

## Python
{: #python}

### Librerie e framework non supportati per Python
{: #unsupported-libraries-and-frameworks-for-python}

-   [richieste ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://docs.python-requests.org/en/master/){: new_window}.

## Ruby
{: #ruby}

[CouchRest ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/couchrest/couchrest){: new_window} è un client CouchDB e {{site.data.keyword.cloudant_short_notm}}
con estensioni per lavorare con Rails utilizzando [CouchRest Model ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/couchrest/couchrest_model){: new_window}.

Per installare CouchRest, esegui il comando:

```sh
gem install couchrest
```
{: codeblock}

### Librerie e framework per Ruby
{: #libraries-and-frameworks-for-ruby}

Molti client CouchDB sono elencati in
[Ruby Toolbox ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://www.ruby-toolbox.com/categories/couchdb_clients){: new_window}.

### Esempi ed esercitazioni per Ruby
{: #examples-and-tutorials-for-ruby}

-   [CRUD ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/cloudant/haengematte/tree/master/ruby){: new_window}.

## Meteor
{: #meteor}

[cloudant:couchdb ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://atmospherejs.com/cloudant/couchdb){: new_window} è la
libreria {{site.data.keyword.cloudant_short_notm}} per il pacchetto `couchdb-meteor`.
Poiché Apache CouchDB non viene incluso con Meteor o con il pacchetto CouchDB,
devi fornire un URL affinché Meteor si colleghi a un
CouchDB in esecuzione o a un'istanza del server {{site.data.keyword.cloudant_short_notm}} prima di installare Meteor.
Aggiungi questo pacchetto
alla tua applicazione Meteor:

```sh
meteor add cloudant:couchdb
```
{: codeblock}

Il pacchetto couchdb-meteor fornisce:

-   Implementazione query live e aggiornamenti in tempo reale dal database utilizzando il feed `_changes` CouchDB.
-   Endpoint RPC DDP (Distributed Data Protocol) che aggiornano i dati dai client connessi localmente.
-   Serializzazione e deserializzazione degli aggiornamenti al formato DDP.

La sintassi della query JSON utilizzata da {{site.data.keyword.cloudant_short_notm}} Query, e inizialmente sviluppata da {{site.data.keyword.cloudant_short_notm}}, è stata restituita ad Apache CouchDB per la versione 2.0. I file binari precostruiti per Apache CouchDB versione 2.0
   non sono ancora disponibili. Puoi utilizzare questo modulo con {{site.data.keyword.cloudant_short_notm}} DBaaS o Cloudant locale fino a che non saranno disponibili i file binari precostruiti.
{: note}

Per configurare le informazioni di connessione al server Apache CouchDB o {{site.data.keyword.cloudant_short_notm}},
passa il suo URL come variabile di ambiente `COUCHDB_URL` al processo del server Meteor:

```sh
$ export COUCHDB_URL=https://username:password@username.cloudant.com
```
{: codeblock}

Per ulteriori informazioni sulle API meteor-couchdb, vedi la [guida di riferimento API](/docs/services/Cloudant/api/index.html#api-reference-overview). 
