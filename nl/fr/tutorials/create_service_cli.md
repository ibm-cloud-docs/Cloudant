---

copyright:
  years: 2017
lastupdated: "2017-05-22"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

# Création d'une instance Cloudant sur Bluemix à l'aide des outils Cloud Foundry

Ce tutoriel vous apprend à créer une instance de service
{{site.data.keyword.cloudantfull}} sur {{site.data.keyword.Bluemix_notm}}
à l'aide des outils Cloud Foundry.
{:shortdesc}

## Conditions prérequises

Pour suivre ce tutoriel, vous devez d'abord installer les outils {{site.data.keyword.Bluemix_notm}} Cloud Foundry.
Vous trouverez plus de détails sur l'installation de ces outils dans [ce tutoriel distinct](create_bmxapp_appenv.html#the-cloud-foundry-and-bluemix-command-toolkits).

> **Remarque** : Assurez-vous de bien installer les deux kits d'outils Cloud Foundry _et_ {{site.data.keyword.Bluemix_notm}}.

## Identification du noeud final d'API Bluemix

Spécifiez le noeud final d'API cible pour vos commandes Cloud Foundry : 

```sh
bx api https://api.ng.bluemix.net
```
{:codeblock}

Le résultat confirme que vous avez correctement identifié le noeud final : 

```sh
Setting api endpoint to https://api.ng.bluemix.net...
OK

API endpoint:   https://api.ng.bluemix.net (API version: 2.54.0)
Not logged in. Use 'bx login' to log in.
```
{:pre}

## Connexion à votre compte Bluemix

1.  Utilisez la commande suivante pour commencer le processus de connexion auprès de votre compte {{site.data.keyword.Bluemix_notm}} :
  
  ```sh
  bx login
  ```
  {:codeblock}
  
  {{site.data.keyword.Bluemix_notm}} répond en vous rappelant le noeud final d'API en cours, puis vous demande l'adresse électronique de votre compte : 
  
  ```sh
  API endpoint: https://api.ng.bluemix.net

  Email>
  ```
  {:pre}

2.  Entrez l'adresse électronique de votre compte.
  {{site.data.keyword.Bluemix_notm}} vous demande alors le mot de passe associé à votre compte : 
  ```sh
  API endpoint: https://api.ng.bluemix.net

  Email> J.Doe@email.com

  Password>
  ```
  {:pre}
  
  {{site.data.keyword.Bluemix_notm}} valide vos détails et récapitule les informations de votre session de connexion :
  ```sh
  API endpoint: https://api.ng.bluemix.net

  Email> J.Doe@email.com

  Password>
  Authenticating...
  OK

  Targeted account J DOE's Account (707...a32)

  Targeted org J.Doe@email.com

  Targeted space dev

  API endpoint:   https://api.ng.bluemix.net (API version: 2.54.0)
  Region:         us-south
  User:           j.doe@email.com
  Account:        J DOE's Account (707...a32)
  Org:            J.Doe@email.com
  Space:          dev
  ```
  {:pre}

3.  Vous êtes désormais connecté à votre compte {{site.data.keyword.Bluemix_notm}}. 

## Choix du plan Cloudant pour votre service

Obtenez la liste de toutes les offres de services disponibles.
Filtrez cette liste pour n'obtenir que les services {{site.data.keyword.cloudant_short_notm}} : 

```sh
bx service offerings | grep -i Cloudant
```
{:codeblock}

Vous obtenez alors la liste des services {{site.data.keyword.cloudant_short_notm}} disponibles pour votre compte, y
compris les plans spécifiques que vous pouvez sélectionner : 

```sh
cloudantNoSQLDB   Lite, Standard*
```
{:pre}

**Facultatif** : Pour afficher plus de détails sur les plans, utilisez la commande suivante : 

```sh
bx cf marketplace -s cloudantNoSQLDB
```
{:codeblock}

Vous obtenez un récapitulatif des plans disponibles, similaire à la section suivante d'un exemple de réponse (en date de mai 2017) :

```
Lite
The Lite plan provides access to the full functionality of Cloudant for development and evaluation.
The plan has a set amount of provisioned throughput capacity as shown
and includes a max of 1GB of encrypted data storage.   free
```
{:pre}

## Création du service Cloudant

Le format de la commande de base qui permet de créer une instance de service dans {{site.data.keyword.Bluemix_notm}} est le suivant :

```sh
bx service create <service> <plan> <instance name>
```
{:pre}

Supposons que vous souhaitez créer une instance d'un service
{{site.data.keyword.cloudant_short_notm}} nommée `cs20170517a`
avec le plan `Lite`. 

Pour ce faire, utilisez une commande similaire à celle de l'exemple suivant : 

```sh
bx service create cloudantNoSQLDB Lite cs20170517a
```
{:codeblock}

Après avoir créé l'instance de service, vous obtenez un message de réponse similaire à l'exemple suivant :

```sh
Invoking 'cf create-service cloudantNoSQLDB Lite cs20170517a'...

Creating service instance cs20170517a in org J.Doe@email.com / space dev as J.Doe@email.com...
OK

```
{:pre}

## Création des données d'identification de votre service Cloudant

Les applications qui requièrent un accès à votre service
{{site.data.keyword.cloudant_short_notm}} doivent disposer des données d'identification nécessaires. 

>   **Remarque** : Les données d'identification du service sont précieuses. 
    Si un utilisateur ou une application dispose d'un accès aux données d'identification,
    il peut effectuer n'importe quelle opération sur l'instance de service, comme créer
    des données erronées ou supprimer des informations utiles.
    Il convient de protéger ces données d'identification avec soin.

Les données d'identification du service comportent cinq zones : 

Zone       | Objectif
-----------|--------
`host`     | Nom d'hôte employé par les applications pour localiser l'instance de service. 
`username` | Nom d'utilisateur requis par les applications pour accéder à l'instance de service. 
`password` | Mot de passe requis par les applications pour accéder à l'instance de service. 
`port`     | Numéro de port HTTP pour l'accès à l'instance de service sur l'hôte. Il s'agit généralement du numéro de port 443 qui force l'accès HTTPS.
`url`      | Chaîne regroupant les autres informations de données d'identification en une seule URL, adaptée pour une utilisation par des applications.

Le format de la commande de base qui permet de créer les données d'identification d'une instance de service dans
{{site.data.keyword.Bluemix_notm}} est le suivant :

```sh
bx cf create-service-key <instance name> <credentials name>
```
{:pre}

Supposons que vous souhaitez créer les données d'identification de l'instance
`cs20170517a` d'un service {{site.data.keyword.cloudant_short_notm}}, le nom des données d'identification
étant `creds20170517a`.

Pour ce faire, utilisez une commande similaire à celle de l'exemple suivant : 

```sh
bx cf create-service-key cs20170517a creds20170517a
```
{:codeblock}

Après avoir reçu la demande de création des données d'identification pour
l'instance de service, {{site.data.keyword.Bluemix_notm}} répond avec un message
similaire à celui de l'exemple suivant : 

```sh
Invoking 'cf create-service-key cs20170517a creds20170517a'...

Creating service key creds20170517a for service instance cs20170517a as J.Doe@email.com...
OK
```
{:pre}

## Affichage de la liste des données d'identification de votre service Cloudant

Le format de la commande de base qui permet d'extraire les données d'identification
d'une instance de service dans {{site.data.keyword.Bluemix_notm}} est le suivant :

```sh
bx cf service-key <instance name> <credentials name>
```
{:pre}

Supposons que vous souhaitez extraire les données d'identification de l'instance `cs20170517a` d'un service
{{site.data.keyword.cloudant_short_notm}}, le nom des données d'identification
étant `creds20170517a`.

Pour ce faire, utilisez une commande similaire à celle de l'exemple suivant : 

```sh
bx cf service-key cs20170517a creds20170517a
```
{:codeblock}

Après avoir reçu la demande d'extraction des données d'identification pour
l'instance de service, {{site.data.keyword.Bluemix_notm}} répond avec un message
similaire à celui de l'exemple suivant (abrégé) : 

```sh
Invoking 'cf service-key cs20170517a creds20170517a'...

Getting key creds20170517a for service instance cs20170517a as J.Doe@email.com...

{
 "host": "946...46f-bluemix.cloudant.com",
 "password": "4eb...eb5",
 "port": 443,
 "url": "https://946...46f-bluemix:4eb...eb5@946...46f-bluemix.cloudant.com",
 "username": "946...46f-bluemix"
}
```
{:pre}

## Utilisation de votre instance de service Cloudant

A ce stade, vous avez : 

1.  Créé une instance de service {{site.data.keyword.cloudant_short_notm}} dans {{site.data.keyword.Bluemix_notm}}.
2.  Créé des données d'identification pour l'instance de service {{site.data.keyword.cloudant_short_notm}}. 
3.  Extrait les données d'identification de l'instance de service de telle sorte qu'elles puissent être utilisées par votre application.

Un tutoriel expliquant comment utiliser une instance de service {{site.data.keyword.cloudant_short_notm}} est disponible
[ici](create_database.html#context).
Pour rappel, vous devez remplacer les données d'identification par celles que vous avez créées dans ce tutoriel. 

## (Facultatif) Nettoyage postérieur

La liste de commandes réduite suivante peut s'avérer utile si vous souhaitez nettoyer votre environnement de développement. 

### Suppression des données d'identification du service

Pour supprimer un ensemble de données d'identification de service, employez une commande similaire à celle de l'exemple suivant : 

```sh
bx cf delete-service-key <instance name> <credentials name>
```
{:pre}

Par exemple, pour supprimer les données d'identification nommées `creds20170517a` de l'instance `cs20170517a` d'un
service {{site.data.keyword.cloudant_short_notm}}, vous pouvez utiliser une commande similaire à l'exemple suivant : 

```sh
bx cf delete-service-key cs20170517a creds20170517a
```
{:pre}

### Suppression d'une instance de service

Pour supprimer une instance de service, employez une commande similaire à celle de l'exemple suivant : 

```sh
bx service delete <instance name>
```
{:pre}

Par exemple, pour supprimer l'instance `cs20170517a` d'un service
{{site.data.keyword.cloudant_short_notm}}, vous pouvez utiliser une commande similaire à l'exemple suivant :  

```sh
bx service delete cs20170517a
```
{:pre}

