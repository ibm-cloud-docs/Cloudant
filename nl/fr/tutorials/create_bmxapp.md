---

copyright:
  years: 2017, 2018
lastupdated: "2018-10-24"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:tip: .tip}

<!-- Acrolinx: 2017-05-10 -->

# Création d'une application {{site.data.keyword.cloud_notm}} simple permettant d'accéder à une base de données {{site.data.keyword.cloudant_short_notm}}

Ce tutoriel montre comment créer une application
{{site.data.keyword.cloud}} qui utilisé le [langage de programmation Python ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://www.python.org/){:new_window} pour accéder à une base de données
{{site.data.keyword.cloudantfull}} hébergée dans votre instance de service {{site.data.keyword.cloud_notm}}.
{:shortdesc}

## Contexte

L'un des principaux avantages de {{site.data.keyword.cloud}} est que vous pouvez créer et déployer des applications dans {{site.data.keyword.cloud_notm}} lui-même.
Il n'est pas nécessaire de rechercher et gérer un serveur pour exécuter vos applications.

Si vous utilisez déjà une instance de base de données {{site.data.keyword.cloudant_short_notm}} dans {{site.data.keyword.cloud_notm}}, il est judicieux de disposer de vos applications ici aussi.

Les applications {{site.data.keyword.cloud_notm}} sont généralement créées à l'aide de la technologie [Cloud Foundry ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://en.wikipedia.org/wiki/Cloud_Foundry){:new_window}.
Cloud Foundry offre une fonction de plateforme sous forme de services (Platform-as-a-Service ou PaaS) qui simplifie le processus de création des applications pouvant être déployées et exécutées dans un environnement de cloud.

[Un tutoriel distinct](create_database.html) vous a montré comment créer une application Python autonome qui utilise une instance de base de données {{site.data.keyword.cloudant_short_notm}} dans {{site.data.keyword.cloud_notm}}.
Dans ce tutoriel, vous allez configurer et créer une petite application Python hébergée dans {{site.data.keyword.cloud_notm}}.
Cette application se connecte à votre instance de la base de données {{site.data.keyword.cloudant_short_notm}} et crée un seul document simple.

Le code Python propre à chaque tâche est fourni dans le cadre de ce tutoriel.
Un programme Python complet, suffisant pour illustrer les différents concepts, est fourni
dans le tutoriel [à cet endroit](create_bmxapp_createapp.html#complete-listing).

Aucune tentative de création d'un code Python _efficace_ n'a été
effectuée pour ce tutoriel.
Notre seule intention est de vous montrer un code simple et facile à comprendre, qui
fonctionne, et que vous pouvez apprendre et appliquer à vos propres applications.

De même, nous n'avons pas essayé de résoudre toutes les vérifications ou conditions d'erreur possibles.
Certains exemples de vérifications sont inclus dans le but d'illustrer certaines
techniques, mais vous devez appliquer les meilleures pratiques afin de vérifier et
traiter tous les avertissements ou cas d'erreur que vous rencontrez dans vos propres applications.

## Présentation des tâches

Pour créer une application Python qui fonctionne sur
{{site.data.keyword.cloud_notm}} capable d'accéder à une instance de base de
données {{site.data.keyword.cloudant_short_notm}}, vous devez procéder comme suit :

-   [Créez un environnement d'application Python sur {{site.data.keyword.cloud_notm}}.](create_bmxapp_appenv.html#creating)
-   [Vérifiez que l'environnement d'application Python dispose d'une connexion à une instance de base de données {{site.data.keyword.cloudant_short_notm}}.](create_bmxapp_appenv.html#connecting)
-   [(Tâche ponctuelle) Téléchargez et installez les kits d'outils de commande Cloud Foundry et {{site.data.keyword.cloud_notm}}.](create_bmxapp_appenv.html#toolkits)
-   [Téléchargez l'application de démarrage.](create_bmxapp_appenv.html#starter)
-   [Personnalisez l'application de démarrage pour créer votre propre application qui accédera à l'instance de base de données {{site.data.keyword.cloudant_short_notm}}.](create_bmxapp_createapp.html#theApp)
-   [Transférez votre application et vérifiez qu'elle fonctionne.](create_bmxapp_upload.html#uploading)
-   [Effectuez des tâches de maintenance d'application de base.](create_bmxapp_maintain.html#maintenance)
-   [Diagnostiquez et résolvez les problèmes (traitement des incidents).](create_bmxapp_maintain.html#troubleshooting)

## Structure du tutoriel

Le tutoriel est composé des cinq sections suivantes :

1.  [Conditions prérequises](create_bmxapp_prereq.html)
2.  [Environnement d'application](create_bmxapp_appenv.html)
3.  [Création de votre application](create_bmxapp_createapp.html)
4.  [Transfert et exécution de votre application](create_bmxapp_upload.html)
5.  [Maintenance et traitement des incidents liés à votre application](create_bmxapp_maintain.html)

## Etape suivante

Pour démarrer le tutoriel, commencez par [vérifier les conditions prérequises](create_bmxapp_prereq.html).
