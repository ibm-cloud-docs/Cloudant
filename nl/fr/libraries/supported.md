---

copyright:
  years: 2015, 2019
lastupdated: "2019-04-02"

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

# Bibliothèques client prises en charge
{: #supported-client-libraries}

## Mobile
{: #mobile}

La bibliothèque {{site.data.keyword.cloudantfull}} Sync est utilisée pour stocker, indexer et interroger les données JSON locales sur un périphérique mobile.
Elle sert aussi à synchroniser les données entre plusieurs périphériques.
La synchronisation est contrôlée par votre application.
La bibliothèque fournit aussi des méthodes auxiliaires pour localiser et résoudre des conflits, aussi bien sur le périphérique local que sur la base de données distante.

Deux versions sont disponibles :

-   [{{site.data.keyword.cloudant_short_notm}} Sync - Android / JavaSE ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://github.com/cloudant/sync-android){: new_window}.
-   [{{site.data.keyword.cloudant_short_notm}} Sync - iOS (CDTDatastore) ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://github.com/cloudant/CDTDatastore){: new_window}.

Un [aperçu ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://cloudant.com/product/cloudant-features/sync/){: new_window} de {{site.data.keyword.cloudant_short_notm}} Sync est disponible.
De même, vous trouverez des détails sur les ressources {{site.data.keyword.cloudant_short_notm}} Sync [ ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://cloudant.com/cloudant-sync-resources/){: new_window}.

## Java
{: #java}

[java-cloudant ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://github.com/cloudant/java-cloudant){: new_window} est la bibliothèque {{site.data.keyword.cloudantfull}} officielle pour Java.

Des informations relatives à l'installation de la bibliothèque en l'ajoutant en tant que dépendance à vos générations Maven ou Gradle sont disponibles [ici ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://github.com/cloudant/java-cloudant#installation-and-usage){: new_window}, avec des détails et des exemples sur la façon d'utiliser la bibliothèque.

### Bibliothèques et infrastructures pour Java
{: #libraries-and-frameworks-for-java}

#### Bibliothèque prise en charge pour Java
{: #supported-library-for-java}

-   [java-cloudant ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant/java-cloudant){: new_window}.

#### Bibliothèques non prises en charge pour Java
{: #unsupported-for-libraries-for-java}

-   [ektorp ![External link icon](../images/launch-glyph.svg "External link icon")](https://helun.github.io/Ektorp/reference_documentation.html){: new_window}.
-   [jcouchdb ![External link icon](../images/launch-glyph.svg "External link icon")](http://code.google.com/p/jcouchdb/){: new_window}.
-   [jrelax ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/isterin/jrelax){: new_window}.
-   [LightCouch ![External link icon](../images/launch-glyph.svg "External link icon")](http://www.lightcouch.org/){: new_window}.
-   [Java Cloudant Web Starter ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://ace.ng.bluemix.net/#/store/cloudOEPaneId=store&appTemplateGuid=CloudantJavaBPTemplate&fromCatalog=true){: new_window} - Conteneur boilerplate pour {{site.data.keyword.cloud}}.

### Exemples et tutoriels pour Java
{: #examples-and-tutorials-for-java}

-   [Create, read, update, and delete ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant/haengematte/tree/master/java){: new_window} avec des bibliothèques JSON et HTTP.
-   [Create, read, update, and delete ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant/haengematte/tree/master/java/CrudWithEktorp){: new_window} avec une bibliothèque ektorp.
-   [Building apps by using Java with {{site.data.keyword.cloudant_short_notm}} on {{site.data.keyword.cloud}}![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://cloudant.com/blog/building-apps-using-java-with-cloudant-on-ibm-bluemix/){: new_window}.
-   [Building a Java EE app on {{site.data.keyword.cloud_notm}} by using Watson and {{site.data.keyword.cloudant_short_notm}} ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://developer.ibm.com/bluemix/2014/10/17/building-java-ee-app-ibm-bluemix-using-watson-cloudant/){: new_window} {{site.data.keyword.cloud_notm}} example along with [YouTube video ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://www.youtube.com/watch?feature=youtu.be&v=9AFMY6m0LIU&app=desktop){: new_window}.


## Node.js
{: #node-js}

[nodejs-cloudant ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://github.com/cloudant/nodejs-cloudant){: new_window}
est la bibliothèque {{site.data.keyword.cloudant_short_notm}} officielle pour Node.js.
Vous pouvez l'installer avec npm :

```sh
npm install cloudant
```
{: codeblock}

### Bibliothèques et infrastructures pour node.js
{: #libraries-and-frameworks-for-node-js}

#### Bibliothèque prise en charge pour node.js
{: #supported-library-for-node-js}

-   [nodejs-cloudant ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant/nodejs-cloudant){: new_window} ([npm ![External link icon](../images/launch-glyph.svg "External link icon")](https://www.npmjs.com/package/@cloudant/cloudant){: new_window}).

#### Bibliothèques et infrastructures non prises en charge pour node.js
{: #unsupported-libraries-and-frameworks-for-node-js-supported}

-   [sag-js ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/sbisbee/sag-js){: new_window}, compatible avec le navigateur.
    Pour plus d'informations, voir [saggingcouch ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://github.com/sbisbee/saggingcouch.com){: new_window}.
-   [nano ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/dscape/nano){: new_window} désigne une implémentation minimaliste.
-   [restler ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/danwrong/restler){: new_window} offre les meilleures performances mais est réduite à l'essentiel.
-   [cradle ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/flatiron/cradle){: new_window} est un client de haut niveau, adapté à vos besoins si vous recherchez surtout la facilité d'utilisation au prix de performances réduites.
-   [cane_passport ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://github.com/ddemichele/cane_passport){: new_window} - {{site.data.keyword.cloudant_short_notm}} Angular Node Express avec Bootstrap.
-   [express-cloudant ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant-labs/express-cloudant){: new_window} - Modèle pour l'infrastructure Node.js Express qui utilise également PouchDB et Grunt.
-   [Node.js {{site.data.keyword.cloudant_short_notm}} DB Web Starter ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://ace.ng.bluemix.net/#/store/cloudOEPaneId=store&appTemplateGuid=nodejscloudantbp&fromCatalog=true){: new_window} - Conteneur boilerplate pour {{site.data.keyword.cloud_notm}}.
-   [Mobile Cloud ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://ace.ng.bluemix.net/#/store/cloudOEPaneId=store&appTemplateGuid=mobileBackendStarter&fromCatalog=true){: new_window} - Conteneur boilerplate pour {{site.data.keyword.cloud_notm}} (Node.js, Security, Push et Mobile Data/{{site.data.keyword.cloudant_short_notm}}).

### Exemples et tutoriels pour node.js
{: #examples-and-tutorials-for-node-js}

-   [Create, read, update, and delete ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant/haengematte/tree/master/nodejs){: new_window}.
-   [Cloudant-Uploader ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://github.com/garbados/Cloudant-Uploader){: new_window} - Utilitaire permettant d'importer des fichiers `.csv` dans {{site.data.keyword.cloudant_short_notm}}.
-   [couchimport ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://github.com/glynnbird/couchimport){: new_window} - Utilitaire permettant d'importer des fichiers `.csv` ou `.tsv` dans CouchDB ou {{site.data.keyword.cloudant_short_notm}}.
-   [Getting started with {{site.data.keyword.cloud_notm}} and Node.js ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](http://thoughtsoncloud.com/2014/07/getting-started-ibm-bluemix-node-js/){: new_window}.
-   [A Cloud medley with {{site.data.keyword.cloud_notm}}, {{site.data.keyword.cloudant_short_notm}}, and Node.js ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://gigadom.wordpress.com/2014/08/15/a-cloud-medley-with-ibm-bluemix-cloudant-db-and-node-js/){: new_window}.
-   [Build a simple word game app by using {{site.data.keyword.cloudant_short_notm}} on {{site.data.keyword.cloud_notm}} ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](http://www.ibm.com/developerworks/cloud/library/cl-guesstheword-app/index.html?ca=drs-){: new_window} - utilise Node.js.
-   [Building a Real-time SMS Voting App ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://www.twilio.com/blog/2012/09/building-a-real-time-sms-voting-app-part-1-node-js-couchdb.html){: new_window} - Série en six parties utilisant Node.js, Twilio et {{site.data.keyword.cloudant_short_notm}}.
-   [Building a multitier Windows Azure Web application ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://www.ampower.me/article/CouchDB/Tutorial-Building-a-Multi-Tier-Windows-Azure-Web-application-use-Cloudants-Couchdb-as-a-Service-node-94-409665?eqs=Z2NWNlltTmlUWStWcHdEWENWc3UxdmowREpiMjlGUVpKajJOZGJpSlVkemlPS2oxa0YxZE5BPT0=){: new_window} - Utilise {{site.data.keyword.cloudant_short_notm}}, Node.js, CORS et Grunt.
-   [Do it yourself: Build a remote surveillance application by using {{site.data.keyword.cloud_notm}}, {{site.data.keyword.cloudant_short_notm}}, and Raspberry Pi. ![External link icon](../images/launch-glyph.svg "External link icon")](http://www.ibm.com/developerworks/library/ba-remoteservpi-app/index.html){: new_window}.

## Python
{: #python-supported}

Une bibliothèque compatible avec {{site.data.keyword.cloudant_short_notm}} en utilisant Python est disponible [ici ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://github.com/cloudant/python-cloudant){: new_window}.

Les applications Python qui accèdent à {{site.data.keyword.cloudant_short_notm}} possèdent des dépendances de composant. Ces dépendances doivent être mentionnées dans un fichier `requirements.txt`. Pour plus d'informations, voir [ici ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://pip.readthedocs.io/en/1.1/requirements.html){: new_window}.
{: tip}

Téléchargez la version de la bibliothèque en cours [ici ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://pypi.python.org/pypi/cloudant/){: new_window}.
Apprenez-en plus sur le langage Python à l'adresse [python.org ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://www.python.org/about/){: new_window}. 

## Swift
{: #swift}

Une bibliothèque prise en charge est disponible lors de l'utilisation de {{site.data.keyword.cloudant_short_notm}}.
Il s'agit de la bibliothèque SwiftCloudant, qui est installée à l'aide de `cocoapods`.

L'entrée podfile est la suivante :

```sh
pod 'SwiftCloudant'
```
{: codeblock}

Des informations relatives à SwiftCloudant, incluant des détails relatifs à l'installation et la façon d'utiliser la bibliothèque pour stocker, indexer et interroger les données JSON distantes sur {{site.data.keyword.cloudant_short_notm}},
sont disponibles [ici ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://github.com/cloudant/swift-cloudant){: new_window}.

La version de la bibliothèque correspond à une édition précédente.
De ce fait, elle ne dispose pas d'une couverture d'API {{site.data.keyword.cloudant_short_notm}} complète. 

SwiftCloudant n'est pas pris en charge sur iOS, et ne peut pas être appelé depuis Objective-C.
{: tip}
