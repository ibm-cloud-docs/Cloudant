---

copyright:
  years: 2015, 2019
lastupdated: "2019-06-12"

keywords: mobile, java, libraries, framework, examples, tutorials, node.js, python, swift

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

# Librerie client supportate
{: #supported-client-libraries}

## Mobile
{: #mobile}

La libreria {{site.data.keyword.cloudantfull}} Sync è utilizzata per archiviare,
indicizzare
ed eseguire query dei dati JSON locali su un dispositivo mobile.
Viene anche utilizzata per sincronizzare i dati tra più
dispositivi.
La sincronizzazione è controllata dalla tua applicazione.
La libreria
fornisce inoltre i metodi di supporto per la ricerca e la risoluzione dei conflitti,
sia nel dispositivo locale che nel database remoto.

Sono disponibili due versioni:

-   [{{site.data.keyword.cloudant_short_notm}} Sync - Android / JavaSE ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/cloudant/sync-android){: new_window}.
-   [{{site.data.keyword.cloudant_short_notm}} Sync - iOS (CDTDatastore) ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/cloudant/CDTDatastore){: new_window}.

È disponibile una [panoramica ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://cloudant.com/product/cloudant-features/sync/){: new_window} di {{site.data.keyword.cloudant_short_notm}} Sync.
Sono inoltre disponibili i dettagli delle risorse {{site.data.keyword.cloudant_short_notm}} Sync [![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://cloudant.com/cloudant-sync-resources/){: new_window}.

## Java
{: #java-supported}

[java-cloudant ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/cloudant/java-cloudant){: new_window} è la libreria ufficiale
{{site.data.keyword.cloudantfull}} per Java.

Per ulteriori informazioni sull'installazione della libreria aggiungendola come dipendenza alle tue build Maven o Gradle e per visualizzare dettagli ed esempi su come utilizzare la libreria, vedi
[Installazione e utilizzo ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/cloudant/java-cloudant#installation-and-usage){: new_window}.

### Librerie e framework per Java
{: #libraries-and-frameworks-for-java}

#### Libreria supportata per Java
{: #supported-library-for-java}

-   [java-cloudant ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/cloudant/java-cloudant){: new_window}.

#### Librerie non supportate per Java
{: #unsupported-for-libraries-for-java-supported}

-   [ektorp ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://helun.github.io/Ektorp/reference_documentation.html){: new_window}.
-   [jcouchdb ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://code.google.com/p/jcouchdb/){: new_window}.
-   [jrelax ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/isterin/jrelax){: new_window}.
-   [LightCouch ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://www.lightcouch.org/){: new_window}.
-   [Java Cloudant Web Starter ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://ace.ng.bluemix.net/#/store/cloudOEPaneId=store&appTemplateGuid=CloudantJavaBPTemplate&fromCatalog=true){: new_window} - contenitore tipo per {{site.data.keyword.cloud}}.

### Esempi ed esercitazioni per Java
{: #examples-and-tutorials-for-java}

-   [Create, read, update, and delete ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/cloudant/haengematte/tree/master/java){: new_window} con le librerie HTTP e JSON.
-   [Create, read, update, and delete ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/cloudant/haengematte/tree/master/java/CrudWithEktorp){: new_window} con la libreria ektorp.
-   [Building apps by using Java with {{site.data.keyword.cloudant_short_notm}} on {{site.data.keyword.cloud}}![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://cloudant.com/blog/building-apps-using-java-with-cloudant-on-ibm-bluemix/){: new_window}.
-   [Building a Java EE app on {{site.data.keyword.cloud_notm}} by using Watson and {{site.data.keyword.cloudant_short_notm}} ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://developer.ibm.com/bluemix/2014/10/17/building-java-ee-app-ibm-bluemix-using-watson-cloudant/){: new_window} Esempio {{site.data.keyword.cloud_notm}} insieme al [video su YouTube ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://www.youtube.com/watch?feature=youtu.be&v=9AFMY6m0LIU&app=desktop){: new_window}.


## Node.js
{: #node-js-supported}

[nodejs-cloudant ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/cloudant/nodejs-cloudant){: new_window} è la {{site.data.keyword.cloudant_short_notm}} libreria ufficiale per Node.js.
Puoi installarla
con npm:

```sh
npm install cloudant
```
{: codeblock}

### Librerie e framework per node.js
{: #libraries-and-frameworks-for-node-js}

#### Libreria supportata per node.js
{: #supported-library-for-node-js}

-   [nodejs-cloudant ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/cloudant/nodejs-cloudant){: new_window} ([npm ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://www.npmjs.com/package/@cloudant/cloudant){: new_window}).

#### Librerie e framework non supportati per node.js
{: #unsupported-libraries-and-frameworks-for-node-js-supported}

-   [sag-js ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/sbisbee/sag-js){: new_window}, che funziona anche nel browser.
    Consulta [saggingcouch ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/sbisbee/saggingcouch.com){: new_window} per ulteriori dettagli.
-   [nano ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/dscape/nano){: new_window} è un'implementazione minimalista.
-   [restler ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/danwrong/restler){: new_window} fornisce le migliori prestazioni ma è molto essenziale.
-   [cradle ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/flatiron/cradle){: new_window}
    è un client di alto livello che è anche disponibile se hai assoluto bisogno di facilità di utilizzo a costo di ridurre le prestazioni.
-   [cane_passport ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/ddemichele/cane_passport){: new_window} - {{site.data.keyword.cloudant_short_notm}} Angular Node Express with Bootstrap.
-   [express-cloudant ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/cloudant-labs/express-cloudant){: new_window} - un modello per il framework Node.js Express che utilizza anche PouchDB e Grunt.
-   [Node.js {{site.data.keyword.cloudant_short_notm}} DB Web Starter ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://ace.ng.bluemix.net/#/store/cloudOEPaneId=store&appTemplateGuid=nodejscloudantbp&fromCatalog=true){: new_window} - contenitore tipo per {{site.data.keyword.cloud_notm}}.
-   [Mobile Cloud ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://ace.ng.bluemix.net/#/store/cloudOEPaneId=store&appTemplateGuid=mobileBackendStarter&fromCatalog=true){: new_window} - contenitore tipo per {{site.data.keyword.cloud_notm}} (Node.js, Security, Push e Mobile Data/{{site.data.keyword.cloudant_short_notm}}).

### Esempi ed esercitazioni per node.js
{: #examples-and-tutorials-for-node-js}

-   [Create, read, update, and delete ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/cloudant/haengematte/tree/master/nodejs){: new_window}.
-   [Cloudant-Uploader ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/garbados/Cloudant-Uploader){: new_window} - programma di utilità per caricare i file `.csv` in {{site.data.keyword.cloudant_short_notm}}.
-   [couchimport ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/glynnbird/couchimport){: new_window} - programma di utilità per importare i file `.csv` o `.tsv` in CouchDB o {{site.data.keyword.cloudant_short_notm}}.
-   [Getting started with {{site.data.keyword.cloud_notm}} and Node.js ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://thoughtsoncloud.com/2014/07/getting-started-ibm-bluemix-node-js/){: new_window}.
-   [A Cloud medley with {{site.data.keyword.cloud_notm}}, {{site.data.keyword.cloudant_short_notm}}, and Node.js ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://gigadom.wordpress.com/2014/08/15/a-cloud-medley-with-ibm-bluemix-cloudant-db-and-node-js/){: new_window}.
-   [Build a simple word game app by using {{site.data.keyword.cloudant_short_notm}} on {{site.data.keyword.cloud_notm}} ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://www.ibm.com/developerworks/cloud/library/cl-guesstheword-app/index.html?ca=drs-){: new_window} - utilizza Node.js.
-   [Building a Real-time SMS Voting App ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://www.twilio.com/blog/2012/09/building-a-real-time-sms-voting-app-part-1-node-js-couchdb.html){: new_window} - serie in sei parti che utilizza Node.js, Twilio e {{site.data.keyword.cloudant_short_notm}}.
-   [Building a multitier Windows Azure Web application ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://www.ampower.me/article/CouchDB/Tutorial-Building-a-Multi-Tier-Windows-Azure-Web-application-use-Cloudants-Couchdb-as-a-Service-node-94-409665?eqs=Z2NWNlltTmlUWStWcHdEWENWc3UxdmowREpiMjlGUVpKajJOZGJpSlVkemlPS2oxa0YxZE5BPT0=){: new_window} - utilizza {{site.data.keyword.cloudant_short_notm}}, Node.js, CORS e Grunt.
-   [Do it yourself: Build a remote surveillance application by using {{site.data.keyword.cloud_notm}}, {{site.data.keyword.cloudant_short_notm}}, and Raspberry Pi. ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](http://www.ibm.com/developerworks/library/ba-remoteservpi-app/index.html){: new_window}.

## Python
{: #python-supported}

Una libreria supportata per lavorare con {{site.data.keyword.cloudant_short_notm}} utilizzando Python è
disponibile nel repository Github [cloudant/python-cloudant ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/cloudant/python-cloudant){: new_window}.

Le applicazioni Python che accedono a {{site.data.keyword.cloudant_short_notm}} hanno dipendenze componente. Queste dipendenze devono essere specificate in un file `requirements.txt`. Per ulteriori informazioni, vedi le istruzioni per i [file dei requisiti ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://pip.readthedocs.io/en/1.1/requirements.html){: new_window}.
{: tip}

Scarica la release della libreria corrente da [pypi.python.org ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://pypi.python.org/pypi/cloudant/){: new_window}.
Per ulteriori informazioni sul linguaggio Python, vedi [python.org ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://www.python.org/about/){: new_window}. 

## Swift
{: #swift}

È disponibile una libreria supportata per utilizzare {{site.data.keyword.cloudant_short_notm}}.
La libreria è denominata SwiftCloudant
e viene installata utilizzando `cocoapods`.

La voce podfile è:

```sh
pod 'SwiftCloudant'
```
{: codeblock}

Per ulteriori informazioni su SwiftCloudant,
inclusi i dettagli sull'installazione e su come utilizzare la libreria per archiviare,
indicizzare
ed eseguire query dei dati JSON remoti su {{site.data.keyword.cloudant_short_notm}},
vedi il repository Github [cloudant/swift-cloudant ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://github.com/cloudant/swift-cloudant){: new_window}.

La libreria è una versione della release precedente.
In quanto tale non dispone al momento
di una copertura dell'API {{site.data.keyword.cloudant_short_notm}} completa. 

SwiftCloudant non è supportata con iOS e non puoi richiamarla da Objective-C.
{: tip}
