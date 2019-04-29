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

# Bibliothèques client tierces
{: #third-party-client-libraries}

Les bibliothèques client tiers ne bénéficient pas de la prise en charge ou du support {{site.data.keyword.cloudantfull}}.
{: shortdesc}

## C# / .NET
{: #c-net}

[MyCouch ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://github.com/danielwertheim/mycouch){: new_window} est un client CouchDB and {{site.data.keyword.cloudant_short_notm}} asynchrone conçu pour .Net.

Pour installer la bibliothèque, ouvrez la console Package Manager et invoquez :

```
install-package mycouch.cloudant
```
{: codeblock}

### Bibliothèques et infrastructures pour C# / .NET
{: #libraries-and-frameworks-for-c-net}

-   [MyCouch ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://github.com/danielwertheim/mycouch){: new_window}.
-   [LoveSeat ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/soitgoes/LoveSeat){: new_window}.
-   [Divan ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/foretagsplatsen/Divan){: new_window}.
-   [Relax ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/arobson/Relax){: new_window}.
-   [Hammock ![External link icon](../images/launch-glyph.svg "External link icon")](http://code.google.com/p/relax-net/){: new_window}.
-   [EasyCouchDB ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/hhariri/EasyCouchDB){: new_window}.
-   `WDK.API.CouchDB` from [Kanapes IDE ![External link icon](../images/launch-glyph.svg "External link icon")](http://kanapeside.com/){: new_window}.

### Exemples et tutoriels pour C# / .NET
{: #examples-and-tutorials-for-c-net}

-   [CRUD ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant/haengematte/tree/master/c%23){: new_window}.

## Java
{: #java}

### Bibliothèques non prises en charge pour Java
{: #unsupported-for-libraries-for-java}

-   [ektorp ![External link icon](../images/launch-glyph.svg "External link icon")](https://helun.github.io/Ektorp/reference_documentation.html){: new_window}.
-   [jcouchdb ![External link icon](../images/launch-glyph.svg "External link icon")](http://code.google.com/p/jcouchdb/){: new_window}.
-   [jrelax ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/isterin/jrelax){: new_window}.
-   [LightCouch ![External link icon](../images/launch-glyph.svg "External link icon")](http://www.lightcouch.org/){: new_window}.

## JavaScript
{: #javascript}

### Bibliothèques et infrastructures pour JavaScript
{: #libraries-and-frameworks-for-javascript}

-   [Backbone.cloudant ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant-labs/backbone.cloudant){: new_window}.
    Pour plus d'informations voir l'[blog post ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://cloudant.com/blog/backbone-and-cloudant/){: new_window}.
-   [sag.js ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/sbisbee/sag-js){: new_window}.

### Exemples et tutoriels pour JavaScript
{: #examples-and-tutorials-for-javascript}

-   [CRUD ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant/haengematte/tree/master/javascript-jquery){: new_window} utilisant jQuery.
-   [CSVtoCloudant ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://github.com/michellephung/CSVtoCloudant){: new_window} - Interface utilisateur permettant d'importer des fichiers `.csv` dans {{site.data.keyword.cloudant_short_notm}}.
    Vous pouvez également accéder à l'application en cliquant [ici ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://michellephung.github.io/CSVtoCloudant/){: new_window}.
-   [csv2couchdb ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://github.com/Mango-information-systems/csv2couchdb){: new_window} - Interface utilisateur en provenance de Mango Systems pour importer des fichiers `.csv` dans CouchDB/{{site.data.keyword.cloudant_short_notm}}.
-   [songblog ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/millayr/songblog){: new_window} - Exemple d'application utilisant JQuery.
    
## PouchDB (JavaScript)
{: #pouchdb}

[PouchDB ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](http://pouchdb.com/){: new_window} est une base de données JavaScript qui peut se synchroniser avec {{site.data.keyword.cloudant_short_notm}}, ce qui signifie que vous pouvez faire en sorte que vos applications soient prêtes pour un travail hors ligne en utilisant PouchDB.
Pour plus d'informations, voir [cet article de blogue ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://cloudant.com/blog/pouchdb){: new_window} sur PouchDB.

Pour obtenir PouchDB, ainsi que des informations de configuration, voir [PouchDB ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](http://pouchdb.com/){: new_window}.

PouchDB est également disponible pour Node.js : `npm install pouchdb`.
{: note}

PouchDB peut aussi être installé avec Bower : `bower install pouchdb`.
{: note}

### Bibliothèques et infrastructures pour PouchDB
{: #libraries-and-frameworks-for-pouchdb}

-   [PouchDB ![External link icon](../images/launch-glyph.svg "External link icon")](http://pouchdb.com/){: new_window} - Base de données JavaScript pour navigateur, avec synchronisation hors ligne.

### Exemples et tutoriels pour PouchDB
{: #examples-and-tutorials-for-pouchdb}

-   [PouchDB Getting Started Guide ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](http://pouchdb.com/getting-started.html){: new_window} - Exemple d'application Todo se synchronisant depuis le navigateur vers {{site.data.keyword.cloudant_short_notm}} ou CouchDB.
-   [locationtracker ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://github.com/rajrsingh/locationtracker){: new_window} - Exemple d'application pour enregistrer et mapper un emplacement à l'aide de PouchDB, CouchApp et {{site.data.keyword.cloudant_short_notm}}.

## Node.js
{: #node-js}

### Bibliothèques et infrastructures non prises en charge pour node.js
{: #unsupported-libraries-and-frameworks-for-node-js-thirdparty}

-   [sag-js ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/sbisbee/sag-js){: new_window}, compatible avec le navigateur.
    Pour plus d'informations, voir [saggingcouch ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://github.com/sbisbee/saggingcouch.com){: new_window}.
-   [nano ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/dscape/nano){: new_window} désigne une implémentation minimaliste.
-   [restler ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/danwrong/restler){: new_window} offre les meilleures performances mais est réduite à l'essentiel.
-   [cradle ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/flatiron/cradle){: new_window} est un client de haut niveau, adapté à vos besoins si vous recherchez surtout la facilité d'utilisation au prix de performances réduites.
-   [cane_passport ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://github.com/ddemichele/cane_passport){: new_window} - {{site.data.keyword.cloudant_short_notm}} Angular Node Express avec Bootstrap.
-   [express-cloudant ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant-labs/express-cloudant){: new_window} - Modèle pour l'infrastructure Node.js Express qui utilise également PouchDB et Grunt.

## PHP
{: #php}

[Sag ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://github.com/sbisbee/sag){: new_window} est un client CouchDB et {{site.data.keyword.cloudant_short_notm}} de PHP.
[Sag.js ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/sbisbee/sag-js){: new_window} est l'équivalent JavaScript de Sag.

Pour l'installer, téléchargez `sag` depuis la page [https://github.com/sbisbee/sag ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://github.com/sbisbee/sag){: new_window}, puis incluez la bibliothèque dans votre application :

```
require_once('./src/Sag.php');
```
{: codeblock}

### Bibliothèques et infrastructures pour PHP
{: #libraries-and-frameworks-for-php}

-   [sag ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/sbisbee/sag){: new_window}.
-   [Doctrine CouchDB Client ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/doctrine/couchdb-client){: new_window}.
-   [PHP-on-Couch ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/dready92/PHP-on-Couch){: new_window}.

### Exemples et tutoriels pour PHP
{: #examples-and-tutorials-for-php}

-   [CRUD ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant/haengematte/tree/master/php){: new_window}.

## Python
{: #python}

### Bibliothèques et infrastructures non prises en charge pour Python
{: #unsupported-libraries-and-frameworks-for-python}

-   [Requests: HTTP for Humans™ ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](http://docs.python-requests.org/en/master/){: new_window}.

## Ruby
{: #ruby}

[CouchRest ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://github.com/couchrest/couchrest){: new_window} est un client CouchDB et {{site.data.keyword.cloudant_short_notm}} avec des extensions permettant d'utiliser Rails avec [CouchRest Model ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://github.com/couchrest/couchrest_model){: new_window}.

Pour installer CouchRest, exécutez la commande :

```sh
gem install couchrest
```
{: codeblock}

### Bibliothèques et infrastructures pour Ruby
{: #libraries-and-frameworks-for-ruby}

De nombreux clients CouchDB sont répertoriés sur [Ruby Toolbox ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://www.ruby-toolbox.com/categories/couchdb_clients){: new_window}.

### Exemples et tutoriels pour Ruby
{: #examples-and-tutorials-for-ruby}

-   [CRUD ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant/haengematte/tree/master/ruby){: new_window}.

## Meteor
{: #meteor}

[cloudant:couchdb ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://atmospherejs.com/cloudant/couchdb){: new_window} est la bibliothèque {{site.data.keyword.cloudant_short_notm}} destinée au package `couchdb-meteor`.
Puisqu'Apache CouchDB n'est pas inclus avec Meteor ni le package CouchDB, vous devez fournir une URL permettant à Meteor de se connecter à une instance serveur CouchDB ou {{site.data.keyword.cloudant_short_notm}} en cours d'exécution avant d'installer Meteor.
Ajoutez ce package à votre application Meteor :

```sh
meteor add cloudant:couchdb
```
{: codeblock}

Le package couchdb-meteor fournit :

-   Une implémentation Livequery et des mises à jour en temps réel depuis la base de données en consommant le flux CouchDB `_changes`.
-   Des noeuds finaux RPC DDP (Distributed Data Protocol) qui mettent à jour les données depuis les clients connectés localement.
-   La sérialisation et la désérialisation des mises à jour au format DDP.

La syntaxe de requête JSON utilisée par une requête {{site.data.keyword.cloudant_short_notm}} et initialement développée par {{site.data.keyword.cloudant_short_notm}}, a été ajoutée à Apache CouchDB version 2.0. Les fichiers binaires préconfigurés pour Apache CouchDB version 2.0 ne sont pas encore disponibles. Vous pouvez utiliser ce module avec {{site.data.keyword.cloudant_short_notm}} DBaaS ou Cloudant Local en attendant leur disponibilité.
{: note}

Pour configurer les informations de connexion serveur Apache CouchDB ou {{site.data.keyword.cloudant_short_notm}}, transmettez son URL en tant que variable d'environnement `COUCHDB_URL` au processus serveur de Meteor :

```sh
$ export COUCHDB_URL=https://username:password@username.cloudant.com
```
{: codeblock}

Pour plus d'informations sur les API meteor-couchdb, voir [Référence d'API](/docs/services/Cloudant/api/index.html#api-reference-overview). 
