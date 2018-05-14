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

# Bibliothèques client tierces

>   **Remarque** : Les bibliothèques client tierces ne bénéficient pas de la prise en charge ou du support Cloudant.

## Bibliothèques mobiles tierces

Utilisation d'une base de données Cloudant :

-   [IBM Worklight Powered Native Objective-C iOS Apps ![External link icon](../images/launch-glyph.svg "External link icon")](http://www.tricedesigns.com/2014/11/17/ibm-worklight-powered-native-objective-c-ios-apps/){:new_window} avec adaptateur Cloudant.

## C# / .NET

[MyCouch ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/danielwertheim/mycouch){:new_window} est un client CouchDB and Cloudant asynchrone conçu pour .Net.

Pour installer la bibliothèque, ouvrez la console Package Manager et invoquez :

```
install-package mycouch.cloudant
```
{:codeblock}

### Bibliothèques et structures

-   [MyCouch ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/danielwertheim/mycouch){:new_window}.
-   [LoveSeat ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/soitgoes/LoveSeat){:new_window}.
-   [Divan ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/foretagsplatsen/Divan){:new_window}.
-   [Relax ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/arobson/Relax){:new_window}.
-   [Hammock ![External link icon](../images/launch-glyph.svg "External link icon")](http://code.google.com/p/relax-net/){:new_window}.
-   [EasyCouchDB ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/hhariri/EasyCouchDB){:new_window}.
-   `WDK.API.CouchDB` from [Kanapes IDE ![External link icon](../images/launch-glyph.svg "External link icon")](http://kanapeside.com/){:new_window}.

### Exemples et tutoriels

-   [CRUD ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant/haengematte/tree/master/c%23){:new_window}.

## PHP

[Sag ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/sbisbee/sag){:new_window} est un client CouchDB et Cloudant de PHP.
[Sag.js ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/sbisbee/sag-js){:new_window} est l'équivalent JavaScript de Sag.

Pour l'installer, téléchargez `sag` depuis la page [https://github.com/sbisbee/sag ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/sbisbee/sag){:new_window}, puis incluez la bibliothèque dans votre application :

```
require_once('./src/Sag.php');
```
{:codeblock}

### Bibliothèques et structures

-   [sag ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/sbisbee/sag){:new_window}.
-   [Doctrine CouchDB Client ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/doctrine/couchdb-client){:new_window}.
-   [PHP-on-Couch ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/dready92/PHP-on-Couch){:new_window}.

### Exemples et tutoriels

-   [CRUD ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant/haengematte/tree/master/php){:new_window}.

## JavaScript

[PouchDB ![External link icon](../images/launch-glyph.svg "External link icon")](http://pouchdb.com/){:new_window} est une base de données JavaScript qui peut se synchroniser avec Cloudant, ce qui signifie que vous pouvez faire en sorte que vos applications soient prêtes pour un travail hors ligne en utilisant PouchDB.
Pour plus d'informations, voir [our blog post ![External link icon](../images/launch-glyph.svg "External link icon")](https://cloudant.com/blog/pouchdb){:new_window} sur PouchDB.

Pour obtenir PouchDB, ainsi que des informations de configuration, voir [PouchDB ![External link icon](../images/launch-glyph.svg "External link icon")](http://pouchdb.com/){:new_window}.

>   **Remarque** : PouchDB est également disponible pour Node.js : `npm install pouchdb`.

>   **Remarque** : PouchDB peut également être installé avec Bower : `bower install pouchdb`.

### Bibliothèques et structures

-   [Backbone.cloudant ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant-labs/backbone.cloudant){:new_window}.
    Pour plus d'informations voir l'[blog post ![External link icon](../images/launch-glyph.svg "External link icon")](https://cloudant.com/blog/backbone-and-cloudant/){:new_window}.
-   [sag.js ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/sbisbee/sag-js){:new_window}.
-   [PouchDB ![External link icon](../images/launch-glyph.svg "External link icon")](http://pouchdb.com/){:new_window} - Base de données JavaScript pour navigateur, avec synchronisation hors ligne.

### Exemples et tutoriels

-   [CRUD ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant/haengematte/tree/master/javascript-jquery){:new_window} utilisant jQuery.
-   [CSVtoCloudant ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/michellephung/CSVtoCloudant){:new_window} - Interface utilisateur permettant d'importer des fichiers `.csv` dans Cloudant.
    Vous pouvez également accéder à l'application en cliquant [ici ![External link icon](../images/launch-glyph.svg "External link icon")](https://michellephung.github.io/CSVtoCloudant/){:new_window}.
-   [csv2couchdb ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/Mango-information-systems/csv2couchdb){:new_window} - Interface utilisateur en provenance de Mango Systems pour importer des fichiers `.csv` dans CouchDB/Cloudant.
-   [songblog ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/millayr/songblog){:new_window} - Exemple d'application utilisant JQuery.
-   [PouchDB Getting Started Guide ![External link icon](../images/launch-glyph.svg "External link icon")](http://pouchdb.com/getting-started.html){:new_window} - Exemple d'application Todo se synchronisant depuis le navigateur vers Cloudant ou CouchDB.
-   [locationtracker ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/rajrsingh/locationtracker){:new_window} - Exemple d'application pour enregistrer et mapper un emplacement à l'aide de PouchDB, CouchApp et Cloudant.

## Ruby

[CouchRest ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/couchrest/couchrest){:new_window} est un client CouchDB et Cloudant avec des extensions permettant d'utiliser Rails avec [CouchRest Model ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/couchrest/couchrest_model){:new_window}.

Pour installer CouchRest, exécutez la commande :

```sh
gem install couchrest
```
{:codeblock}

### Bibliothèques et structures

De nombreux client CouchDB sont répertoriés sur [Ruby Toolbox ![External link icon](../images/launch-glyph.svg "External link icon")](https://www.ruby-toolbox.com/categories/couchdb_clients){:new_window}.

### Exemples et tutoriels

-   [CRUD ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant/haengematte/tree/master/ruby){:new_window}.

<div id="couchdb"></div>

## Meteor

[cloudant:couchdb ![External link icon](../images/launch-glyph.svg "External link icon")](https://atmospherejs.com/cloudant/couchdb){:new_window} est la bibliothèque Cloudant destinée au package `couchdb-meteor`.
Puisqu'Apache CouchDB n'est pas livré avec Meteor ni le package couchdb, vous devez fournir une URL permettant à Meteor de se connecter à une instance serveur CouchDB ou Cloudant en cours d'exécution avant d'installer Meteor.
Ajoutez ce package à votre application Meteor :

```sh
meteor add cloudant:couchdb
```
{:codeblock}

Le package couchdb-meteor fournit :

-   Une implémentation Livequery et des mises à jour en temps réel depuis la base de données en consommant le flux CouchDB `_changes`.
-   Des noeuds finaux RPC DDP (Distributed Data Protocol) qui mettent à jour les données depuis les clients connectés localement.
-   La sérialisation et la désérialisation des mises à jour au format DDP.

>   **Remarque** : La syntaxe de requête JSON utilisée par Cloudant Query,
    et initialement développée par Cloudant, a été ajoutée à Apache CouchDB version 2.0.
    Les fichiers binaires préconfigurés pour Apache CouchDB version 2.0 ne sont pas encore disponibles.
    Vous pouvez utiliser ce module avec Cloudant DBaaS ou Cloudant Local en attendant leur disponibilité.

Pour configurer les informations de connexion serveur Apache CouchDB ou Cloudant, transmettez son URL en tant que variable d'environnement `COUCHDB_URL` au processus serveur de Meteor :

```sh
$ export COUCHDB_URL=https://username:password@username.cloudant.com
```
{:codeblock}

Pour plus d'informations sur les API meteor-couchdb, voir [Référence d'API](../api/index.html). 

## Apache Spark

[spark-cloudant ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant-labs/spark-cloudant){:new_window} est la bibliothèque Cloudant conçue pour Apache Spark.

La bibliothèque spark-cloudant est déjà chargée dans l'offre [IBM Bluemix Apache Spark-as-a-Service ![External link icon](../images/launch-glyph.svg "External link icon")](https://console.ng.bluemix.net/catalog/services/apache-spark/){:new_window}.
Celle-ci peut être utilisée avec n'importe quel cluster Spark autonome.

Pour plus de détails, voir les rubriques [project information ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/cloudant-labs/spark-cloudant){:new_window} et [Spark Packages ![External link icon](../images/launch-glyph.svg "External link icon")](https://spark-packages.org/package/cloudant-labs/spark-cloudant){:new_window}.
