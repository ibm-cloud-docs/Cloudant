---

copyright:
  years: 2015, 2017
lastupdated: "2017-08-25"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-03-06 -->

# Librerie client supportate 

## Mobile

La libreria Cloudant Sync è utilizzata per archiviare, indicizzare ed eseguire query dei dati JSON locali
su un dispositivo mobile. Viene anche utilizzata per sincronizzare i dati tra più
dispositivi. La sincronizzazione è controllata dalla tua applicazione. La libreria
fornisce inoltre i metodi di supporto per la ricerca e la risoluzione dei conflitti,
sia nel dispositivo locale che nel database remoto.

Sono disponibili due versioni:

-   [Cloudant Sync - Android / JavaSE ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/cloudant/sync-android){:new_window}.
-   [Cloudant Sync - iOS (CDTDatastore) ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/cloudant/CDTDatastore){:new_window}.

È disponibile una [panoramica ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://cloudant.com/product/cloudant-features/sync/){:new_window} di Cloudant Sync.
Sono inoltre disponibili i dettagli delle risorse [ Cloudant Sync ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://cloudant.com/cloudant-sync-resources/){:new_window}.

## Java

[java-cloudant ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/cloudant/java-cloudant){:new_window} è la libreria ufficiale
{{site.data.keyword.cloudantfull}} per Java.

Le informazioni sull'installazione della libreria aggiungendola come dipendenza
delle tue build Maven o Gradle sono disponibili
[qui
![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/cloudant/java-cloudant#installation-and-usage){:new_window},
insieme ai dettagli a agli esempi su come utilizzare la libreria.

### Librerie e framework

#### Supportato

-   [java-cloudant ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/cloudant/java-cloudant){:new_window}.

#### Non supportato 

-   [ektorp ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://ektorp.org/){:new_window}.
-   [jcouchdb ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://code.google.com/p/jcouchdb/){:new_window}.
-   [jrelax ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/isterin/jrelax){:new_window}.
-   [LightCouch ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://www.lightcouch.org/){:new_window}.
-   [Java Cloudant Web Starter ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://ace.ng.bluemix.net/#/store/cloudOEPaneId=store&appTemplateGuid=CloudantJavaBPTemplate&fromCatalog=true){:new_window} contenitore tipo per Bluemix.

### Esempi ed esercitazioni didattiche

-   [Create, read, update, and delete ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/cloudant/haengematte/tree/master/java){:new_window} con le librerie HTTP e JSON.
-   [Create, read, update, and delete ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/cloudant/haengematte/tree/master/java/CrudWithEktorp){:new_window} con la libreria ektorp.
-   [Creazione di applicazioni con Cloudant in IBM Bluemix ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://cloudant.com/blog/building-apps-using-java-with-cloudant-on-ibm-bluemix/){:new_window}.
-   [Build a game app with Liberty, Cloudant, and Single Sign On ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://www.ibm.com/developerworks/cloud/library/cl-multiservicegame-app/index.html?ca=drs-){:new_window} Bluemix example.
-   [Building a Java EE app on IBM Bluemix by using Watson and Cloudant ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://developer.ibm.com/bluemix/2014/10/17/building-java-ee-app-ibm-bluemix-using-watson-cloudant/){:new_window} Bluemix example along with [YouTube video ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://www.youtube.com/watch?feature=youtu.be&v=9AFMY6m0LIU&app=desktop){:new_window}.


## Node.js

[nodejs-cloudant ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/cloudant/nodejs-cloudant){:new_window} è la {{site.data.keyword.cloudant_short_notm}} libreria ufficiale per Node.js.Puoi installarla
con npm:

```sh
npm install cloudant
```
{:codeblock}

### Librerie e framework

#### Supportato

-   [nodejs-cloudant ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/cloudant/nodejs-cloudant){:new_window} ([npm ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://www.npmjs.org/package/cloudant){:new_window}).

#### Non supportato 

-   [sag-js ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/sbisbee/sag-js){:new_window}, che funziona anche nel browser.
    Consulta [saggingcouch ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/sbisbee/saggingcouch.com){:new_window} per ulteriori dettagli.
-   [nano ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/dscape/nano){:new_window} è un'implementazione minimalista.
-   [restler ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/danwrong/restler){:new_window} fornisce le migliori prestazioni ma è molto essenziale.
-   [cradle ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/flatiron/cradle){:new_window}
    è un client di alto livello che è anche disponibile se hai assoluto bisogno di facilità di utilizzo a costo di ridurre le prestazioni.
-   [cane_passport ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/ddemichele/cane_passport){:new_window} - Cloudant Angular Node Express with Bootstrap.
-   [express-cloudant ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/cloudant-labs/express-cloudant){:new_window} - un modello per il framework Node.js Express che utilizza anche PouchDB e Grunt.
-   [Node.js Cloudant DB Web Starter ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://ace.ng.bluemix.net/#/store/cloudOEPaneId=store&appTemplateGuid=nodejscloudantbp&fromCatalog=true){:new_window} - contenitore tipo per Bluemix.
-   [Mobile Cloud ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://ace.ng.bluemix.net/#/store/cloudOEPaneId=store&appTemplateGuid=mobileBackendStarter&fromCatalog=true){:new_window} - contenitore tipo per Bluemix (Node.js, Security, Push e Mobile Data/Cloudant).

### Esempi ed esercitazioni didattiche

-   [Create, read, update, and delete ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/cloudant/haengematte/tree/master/nodejs){:new_window}.
-   [Cloudant-Uploader ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/garbados/Cloudant-Uploader){:new_window} - programma di utilità per caricare i file `.csv` in Cloudant.
-   [couchimport ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/glynnbird/couchimport){:new_window} - programma di utilità per importare i file `.csv` o `.tsv` in CouchDB o Cloudant.
-   [Getting started with IBM Bluemix and Node.js ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://thoughtsoncloud.com/2014/07/getting-started-ibm-bluemix-node-js/){:new_window}.
-   [A Cloud medley with IBM Bluemix, Cloudant DB, and Node.js ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://gigadom.wordpress.com/2014/08/15/a-cloud-medley-with-ibm-bluemix-cloudant-db-and-node-js/){:new_window}.
-   [Build a simple word game app by using Cloudant on Bluemix ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://www.ibm.com/developerworks/cloud/library/cl-guesstheword-app/index.html?ca=drs-){:new_window} - utilizza Node.js.
-   [Building a Real-time SMS Voting App ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://www.twilio.com/blog/2012/09/building-a-real-time-sms-voting-app-part-1-node-js-couchdb.html){:new_window} - serie in sei parti che utilizza Node.js, Twilio e Cloudant.
-   [Building a multitier Windows Azure Web application ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://msopentech.com/blog/2013/12/19/tutorial-building-multi-tier-windows-azure-web-application-use-cloudants-couchdb-service-node-js-cors-grunt-2/){:new_window} - utilizza Cloudant, Node.js, CORS e Grunt.
-   [Do it yourself: Build a remote surveillance application by using Bluemix, Cloudant, and Raspberry Pi. ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://www.ibm.com/developerworks/library/ba-remoteservpi-app/index.html){:new_window}.

## Python

È disponibile una libreria supportata per lavorare con {{site.data.keyword.cloudant_short_notm}} utilizzando Python
[qui ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/cloudant/python-cloudant){:new_window}.

>   **Nota:** le applicazioni Python che accedono a {{site.data.keyword.cloudant_short_notm}} hanno dipendenze componente. Queste dipendenze devono essere specificate in un file `requirements.txt`. Per ulteriori informazioni e un esempio, consulta [qui ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/cloudant/python-cloudant/blob/master/requirements.txt){:new_window}.

Scarica la release della libreria corrente [qui ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://pypi.python.org/pypi/cloudant/){:new_window}.
Ulteriori informazioni
sul linguaggio Python all'indirizzo [python.org ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://www.python.org/about/){:new_window}. 

## Swift

È disponibile una libreria supportata per utilizzare {{site.data.keyword.cloudant_short_notm}}.
La libreria è denominata SwiftCloudant
e viene installata utilizzando `cocoapods`.

La voce podfile è:

```sh
pod 'SwiftCloudant'
```
{:codeblock}

Ulteriori informazioni su SwiftCloudant, inclusi i dettagli di installazione
e di come utilizzare la libreria per archiviare, indicizzare ed eseguire query di dati
JSON remoti su {{site.data.keyword.cloudant_short_notm}},
sono disponibili [qui ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/cloudant/swift-cloudant){:new_window}.

La libreria è una versione della release precedente.
In quanto tale non dispone al momento
di una copertura dell'API {{site.data.keyword.cloudant_short_notm}} completa. 

>   **Nota**: SwiftCloudant non è supportata con iOS e non puoi richiamarla da Objective-C.
