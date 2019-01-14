---

copyright:
  years: 2015, 2018
lastupdated: "2018-10-24"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:tip: .tip}

<!-- Acrolinx: 2017-05-10 -->

# Bibliothèques client tierces

>   **Remarque** : les bibliothèques client tierces ne bénéficient pas de la prise en charge ou du support {{site.data.keyword.cloudantfull}}.

## Bibliothèques mobiles tierces

Utilisation d'une base de données {{site.data.keyword.cloudant_short_notm}} :

-   [IBM Worklight Powered Native Objective-C iOS Apps ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](http://www.tricedesigns.com/2014/11/17/ibm-worklight-powered-native-objective-c-ios-apps/){:new_window} avec adaptateur {{site.data.keyword.cloudant_short_notm}}.

## C# / .NET

[MyCouch ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://github.com/danielwertheim/mycouch){:new_window} est un client CouchDB and {{site.data.keyword.cloudant_short_notm}} asynchrone conçu pour .Net.

Pour installer la bibliothèque, ouvrez la console Package Manager et invoquez :

```
install-package mycouch.cloudant
```
{:codeblock}

### Bibliothèques et infrastructures pour C# / .NET

-   [MyCouch ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://github.com/danielwertheim/mycouch){:new_window}.
-   [LoveSeat ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://github.com/soitgoes/LoveSeat){:new_window}.
-   [Divan ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://github.com/foretagsplatsen/Divan){:new_window}.
-   [Relax ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://github.com/arobson/Relax){:new_window}.
-   [Hammock ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](http://code.google.com/p/relax-net/){:new_window}.
-   [EasyCouchDB ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://github.com/hhariri/EasyCouchDB){:new_window}.
-   `WDK.API.CouchDB` fourni par [Kanapes IDE ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](http://kanapeside.com/){:new_window}.

### Exemples et tutoriels pour C# / .NET

-   [CRUD ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://github.com/cloudant/haengematte/tree/master/c%23){:new_window}.

## PHP

[Sag ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://github.com/sbisbee/sag){:new_window} est un client CouchDB et {{site.data.keyword.cloudant_short_notm}} de PHP.
[Sag.js ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://github.com/sbisbee/sag-js){:new_window} est l'équivalent JavaScript de Sag.

Pour l'installer, téléchargez `sag` depuis la page [https://github.com/sbisbee/sag ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://github.com/sbisbee/sag){:new_window}, puis incluez la bibliothèque dans votre application :

```
require_once('./src/Sag.php');
```
{:codeblock}

### Bibliothèques et infrastructures pour PHP

-   [sag ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://github.com/sbisbee/sag){:new_window}.
-   [Doctrine CouchDB Client ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://github.com/doctrine/couchdb-client){:new_window}.
-   [PHP-on-Couch ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://github.com/dready92/PHP-on-Couch){:new_window}.

### Exemples et tutoriels pour PHP

-   [CRUD ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://github.com/cloudant/haengematte/tree/master/php){:new_window}.

## JavaScript

[PouchDB ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](http://pouchdb.com/){:new_window} est une base de données JavaScript qui peut se synchroniser avec {{site.data.keyword.cloudant_short_notm}}, ce qui signifie que vous pouvez faire en sorte que vos applications soient prêtes pour un travail hors ligne en utilisant PouchDB.
Pour plus d'informations, voir [notre article de blogue ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://cloudant.com/blog/pouchdb){:new_window} sur PouchDB.

Pour obtenir PouchDB, ainsi que des informations de configuration, voir [PouchDB ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](http://pouchdb.com/){:new_window}.

>   **Remarque** : PouchDB est également disponible pour Node.js : `npm install pouchdb`.

>   **Remarque** : PouchDB peut également être installé avec Bower : `bower install pouchdb`.

### Bibliothèques et infrastructures pour JavaScript

-   [Backbone.cloudant ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://github.com/cloudant-labs/backbone.cloudant){:new_window}.
    Pour plus d'informations voir l'[blog post ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://cloudant.com/blog/backbone-and-cloudant/){:new_window}.
-   [sag.js ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://github.com/sbisbee/sag-js){:new_window}.
-   [PouchDB ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](http://pouchdb.com/){:new_window} - Base de données JavaScript pour navigateur, avec synchronisation hors ligne.

### Exemples et tutoriels pour JavaScript

-   [CRUD ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://github.com/cloudant/haengematte/tree/master/javascript-jquery){:new_window} utilisant jQuery.
-   [CSVtoCloudant ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://github.com/michellephung/CSVtoCloudant){:new_window} - Interface utilisateur permettant d'importer des fichiers `.csv` dans {{site.data.keyword.cloudant_short_notm}}.
    Vous pouvez également accéder à l'application en cliquant [ici ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://michellephung.github.io/CSVtoCloudant/){:new_window}.
-   [csv2couchdb ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://github.com/Mango-information-systems/csv2couchdb){:new_window} - Interface utilisateur en provenance de Mango Systems pour importer des fichiers `.csv` dans CouchDB/{{site.data.keyword.cloudant_short_notm}}.
-   [songblog ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://github.com/millayr/songblog){:new_window} - Exemple d'application utilisant JQuery.
-   [PouchDB Getting Started Guide ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](http://pouchdb.com/getting-started.html){:new_window} - Exemple d'application Todo se synchronisant depuis le navigateur vers {{site.data.keyword.cloudant_short_notm}} ou CouchDB.
-   [locationtracker ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://github.com/rajrsingh/locationtracker){:new_window} - Exemple d'application pour enregistrer et mapper un emplacement à l'aide de PouchDB, CouchApp et {{site.data.keyword.cloudant_short_notm}}.

## Ruby

[CouchRest ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://github.com/couchrest/couchrest){:new_window} est un client CouchDB et {{site.data.keyword.cloudant_short_notm}} avec des extensions permettant d'utiliser Rails avec [CouchRest Model ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://github.com/couchrest/couchrest_model){:new_window}.

Pour installer CouchRest, exécutez la commande :

```sh
gem install couchrest
```
{:codeblock}

### Bibliothèques et infrastructures pour Ruby

De nombreux clients CouchDB sont répertoriés sur [Ruby Toolbox ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://www.ruby-toolbox.com/categories/couchdb_clients){:new_window}.

### Exemples et tutoriels pour Ruby

-   [CRUD ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://github.com/cloudant/haengematte/tree/master/ruby){:new_window}.

<div id="couchdb"></div>

## Meteor

[cloudant:couchdb ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://atmospherejs.com/cloudant/couchdb){:new_window} est la bibliothèque {{site.data.keyword.cloudant_short_notm}} destinée au package `couchdb-meteor`.
Puisque Apache CouchDB n'est pas livré avec Meteor ni le package couchdb, vous devez fournir une URL permettant à Meteor de se connecter à une instance serveur CouchDB ou {{site.data.keyword.cloudant_short_notm}} en cours d'exécution avant d'installer Meteor.
Ajoutez ce package à votre application Meteor :

```sh
meteor add cloudant:couchdb
```
{:codeblock}

Le package couchdb-meteor fournit :

-   Une implémentation Livequery et des mises à jour en temps réel depuis la base de données en consommant le flux CouchDB `_changes`.
-   Des noeuds finaux RPC DDP (Distributed Data Protocol) qui mettent à jour les données depuis les clients connectés localement.
-   La sérialisation et la désérialisation des mises à jour au format DDP.

>   **Remarque** : la syntaxe de requête JSON utilisée par {{site.data.keyword.cloudant_short_notm}} Query,
    et initialement développée par {{site.data.keyword.cloudant_short_notm}}, a été ajoutée à Apache CouchDB version 2.0.
    Les fichiers binaires préconfigurés pour Apache CouchDB version 2.0 ne sont pas encore disponibles.
    Vous pouvez utiliser ce module avec {{site.data.keyword.cloudant_short_notm}} DBaaS ou Cloudant Local en attendant leur disponibilité.

Pour configurer les informations de connexion serveur Apache CouchDB ou {{site.data.keyword.cloudant_short_notm}}, transmettez son URL en tant que variable d'environnement `COUCHDB_URL` au processus serveur de Meteor :

```sh
$ export COUCHDB_URL=https://username:password@username.cloudant.com
```
{:codeblock}

Pour plus d'informations sur les API meteor-couchdb, voir [Référence d'API](../api/index.html). 

## Apache Spark

Les [extensions Apache Bahir pour Apache Spark ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](http://bahir.apache.org/#home){:new_window}
incluent un connecteur `spark-sql-cloudant` qui est la bibliothèque {{site.data.keyword.cloudant_short_notm}} pour Apache Spark.

Le connecteur spark-sql-cloudant est déjà chargé dans l'offre [{{site.data.keyword.cloud_notm}}Apache Spark-as-a-Service ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://console.ng.bluemix.net/catalog/services/apache-spark/){:new_window}.
Celle-ci peut être utilisée avec n'importe quel cluster Spark autonome.

Pour plus de détails, voir [la documentation de projet ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://github.com/apache/bahir/tree/master/sql-cloudant){:new_window}
et la [documentation Apache Bahir spark-sql-cloudant ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](http://bahir.apache.org/docs/spark/current/spark-sql-cloudant/){:new_window}.
