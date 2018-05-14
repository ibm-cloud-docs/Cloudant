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

# Bibliothèques client prises en charge

## Mobile

La bibliothèque Cloudant Sync est utilisée pour stocker, indexer et interroger les données JSON locales sur un périphérique mobile.
Elle sert aussi à synchroniser les données entre plusieurs périphériques.
La synchronisation est contrôlée par votre application.
La bibliothèque fournit aussi des méthodes auxiliaires pour localiser et résoudre des conflits, aussi bien sur le périphérique local que sur la base de données distante.

Deux versions sont disponibles :

-   [Cloudant Sync - Android / JavaSE ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant/sync-android){:new_window}.
-   [Cloudant Sync - iOS (CDTDatastore) ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant/CDTDatastore){:new_window}.

Un [aperçu ![External link icon](../images/launch-glyph.svg "External link icon")](https://cloudant.com/product/cloudant-features/sync/){:new_window} de Cloudant Sync est disponible.
De même, vous trouverez des détails sur les [ressources ![External link icon](../images/launch-glyph.svg "External link icon")](https://cloudant.com/cloudant-sync-resources/){:new_window} Cloudant Sync.

## Java

[java-cloudant ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant/java-cloudant){:new_window} est la bibliothèque {{site.data.keyword.cloudantfull}} officielle pour Java.

Des informations relatives à l'installation de la bibliothèque en l'ajoutant en tant que dépendance à vos générations Maven ou Gradle sont disponibles [ici ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant/java-cloudant#installation-and-usage){:new_window}, avec des détails et des exemples sur la façon d'utiliser la bibliothèque.

### Bibliothèques et structures

#### Prises en charge

-   [java-cloudant ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant/java-cloudant){:new_window}.

#### Non prises en charge

-   [ektorp ![External link icon](../images/launch-glyph.svg "External link icon")](http://ektorp.org/){:new_window}.
-   [jcouchdb ![External link icon](../images/launch-glyph.svg "External link icon")](http://code.google.com/p/jcouchdb/){:new_window}.
-   [jrelax ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/isterin/jrelax){:new_window}.
-   [LightCouch ![External link icon](../images/launch-glyph.svg "External link icon")](http://www.lightcouch.org/){:new_window}.
-   Conteneur boilerplate [Java Cloudant Web Starter ![External link icon](../images/launch-glyph.svg "External link icon")](https://ace.ng.bluemix.net/#/store/cloudOEPaneId=store&appTemplateGuid=CloudantJavaBPTemplate&fromCatalog=true){:new_window} pour Bluemix.

### Exemples et tutoriels

-   [Create, read, update, and delete ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant/haengematte/tree/master/java){:new_window} avec des bibliothèques JSON et HTTP.
-   [Create, read, update, and delete ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant/haengematte/tree/master/java/CrudWithEktorp){:new_window} avec une bibliothèque ektorp.
-   [Building apps by using Java with Cloudant on IBM Bluemix ![External link icon](../images/launch-glyph.svg "External link icon")](https://cloudant.com/blog/building-apps-using-java-with-cloudant-on-ibm-bluemix/){:new_window}.
-   Exemple Bluemix [Build a game app with Liberty, Cloudant, and Single Sign On ![External link icon](../images/launch-glyph.svg "External link icon")](http://www.ibm.com/developerworks/cloud/library/cl-multiservicegame-app/index.html?ca=drs-){:new_window}.
-   Exemple Bluemix [Building a Java EE app on IBM Bluemix by using Watson and Cloudant ![External link icon](../images/launch-glyph.svg "External link icon")](https://developer.ibm.com/bluemix/2014/10/17/building-java-ee-app-ibm-bluemix-using-watson-cloudant/){:new_window} avec [vidéo YouTube ![External link icon](../images/launch-glyph.svg "External link icon")](https://www.youtube.com/watch?feature=youtu.be&v=9AFMY6m0LIU&app=desktop){:new_window}.


## Node.js

[nodejs-cloudant ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant/nodejs-cloudant){:new_window}
est la bibliothèque {{site.data.keyword.cloudant_short_notm}} officielle pour Node.js.
Vous pouvez l'installer avec npm :

```sh
npm install cloudant
```
{:codeblock}

### Bibliothèques et structures

#### Prises en charge

-   [nodejs-cloudant ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant/nodejs-cloudant){:new_window} ([npm ![External link icon](../images/launch-glyph.svg "External link icon")](https://www.npmjs.org/package/cloudant){:new_window}).

#### Non prises en charge

-   [sag-js ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/sbisbee/sag-js){:new_window}, compatible avec le navigateur.
    Pour plus d'informations, voir [saggingcouch ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/sbisbee/saggingcouch.com){:new_window}.
-   [nano ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/dscape/nano){:new_window} désigne une implémentation minimaliste.
-   [restler ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/danwrong/restler){:new_window} offre les meilleures performances mais est réduite à l'essentiel.
-   [cradle ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/flatiron/cradle){:new_window} est un client de haut niveau, adapté à vos besoins si vous recherchez surtout la facilité d'utilisation au prix de performances réduites.
-   [cane_passport ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/ddemichele/cane_passport){:new_window} - Cloudant Angular Node Express avec Bootstrap.
-   [express-cloudant ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant-labs/express-cloudant){:new_window} - Modèle pour l'infrastructure Node.js Express qui utilise également PouchDB et Grunt.
-   [Node.js Cloudant DB Web Starter ![External link icon](../images/launch-glyph.svg "External link icon")](https://ace.ng.bluemix.net/#/store/cloudOEPaneId=store&appTemplateGuid=nodejscloudantbp&fromCatalog=true){:new_window} - Conteneur boilerplate pour Bluemix.
-   [Mobile Cloud ![External link icon](../images/launch-glyph.svg "External link icon")](https://ace.ng.bluemix.net/#/store/cloudOEPaneId=store&appTemplateGuid=mobileBackendStarter&fromCatalog=true){:new_window} - Conteneur boilerplate pour Bluemix (Node.js, Security, Push et Mobile Data/Cloudant).

### Exemples et tutoriels

-   [Create, read, update, and delete ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant/haengematte/tree/master/nodejs){:new_window}.
-   [Cloudant-Uploader ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/garbados/Cloudant-Uploader){:new_window} - Utilitaire permettant d'importer des fichiers `.csv` dans Cloudant.
-   [couchimport ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/glynnbird/couchimport){:new_window} - Utilitaire permettant d'importer des fichiers `.csv` ou `.tsv` dans CouchDB ou Cloudant.
-   [Getting started with IBM Bluemix and Node.js ![External link icon](../images/launch-glyph.svg "External link icon")](http://thoughtsoncloud.com/2014/07/getting-started-ibm-bluemix-node-js/){:new_window}.
-   [A Cloud medley with IBM Bluemix, Cloudant DB, and Node.js ![External link icon](../images/launch-glyph.svg "External link icon")](https://gigadom.wordpress.com/2014/08/15/a-cloud-medley-with-ibm-bluemix-cloudant-db-and-node-js/){:new_window}.
-   [Build a simple word game app by using Cloudant on Bluemix ![External link icon](../images/launch-glyph.svg "External link icon")](http://www.ibm.com/developerworks/cloud/library/cl-guesstheword-app/index.html?ca=drs-){:new_window} - Utilise Node.js.
-   [Building a Real-time SMS Voting App ![External link icon](../images/launch-glyph.svg "External link icon")](https://www.twilio.com/blog/2012/09/building-a-real-time-sms-voting-app-part-1-node-js-couchdb.html){:new_window} - Série en six parties utilisant Node.js, Twilio et Cloudant.
-   [Building a multitier Windows Azure Web application ![External link icon](../images/launch-glyph.svg "External link icon")](http://msopentech.com/blog/2013/12/19/tutorial-building-multi-tier-windows-azure-web-application-use-cloudants-couchdb-service-node-js-cors-grunt-2/){:new_window} - Utilise Cloudant, Node.js, CORS et Grunt.
-   [Do it yourself: Build a remote surveillance application by using Bluemix, Cloudant, and Raspberry Pi. ![External link icon](../images/launch-glyph.svg "External link icon")](http://www.ibm.com/developerworks/library/ba-remoteservpi-app/index.html){:new_window}.

## Python

Une bibliothèque compatible avec {{site.data.keyword.cloudant_short_notm}} en utilisant Python est disponible [ici ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant/python-cloudant){:new_window}.

>   **Remarque** : Les applications Python qui accèdent à {{site.data.keyword.cloudant_short_notm}} possèdent des dépendances de composant. Ces dépendances doivent être mentionnées dans un fichier `requirements.txt`. Pour obtenir plus de précisions et un exemple, cliquez [ici ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant/python-cloudant/blob/master/requirements.txt){:new_window}.

Téléchargez la version de la bibliothèque en cours [ici ![External link icon](../images/launch-glyph.svg "External link icon")](https://pypi.python.org/pypi/cloudant/){:new_window}.
Apprenez-en plus sur le langage Python à l'adresse [python.org ![External link icon](../images/launch-glyph.svg "External link icon")](https://www.python.org/about/){:new_window}. 

## Swift

Une bibliothèque prise en charge est disponible lors de l'utilisation de {{site.data.keyword.cloudant_short_notm}}.
Il s'agit de la bibliothèque SwiftCloudant, qui est installée à l'aide de `cocoapods`.

L'entrée podfile est la suivante :

```sh
pod 'SwiftCloudant'
```
{:codeblock}

Des informations relatives à SwiftCloudant, incluant des détails sur l'installation et la façon d'utiliser la bibliothèque pour stocker, indexer et interroger les données JSON distantes sur {{site.data.keyword.cloudant_short_notm}}, sont disponibles [ici ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant/swift-cloudant){:new_window}.

La version de la bibliothèque correspond à une édition précédente.
De ce fait, elle ne dispose pas d'une couverture d'API {{site.data.keyword.cloudant_short_notm}} complète. 

>   **Remarque** : SwiftCloudant n'est pas prise en charge sur iOS, et ne peut pas être appelée depuis Objective-C.
