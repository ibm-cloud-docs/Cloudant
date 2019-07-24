---

copyright:
  years: 2017, 2019
lastupdated: "2019-06-12"

keywords: create applications, deploy applications, create simple application

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

# Création d'une application {{site.data.keyword.cloud_notm}} simple permettant d'accéder à une base de données {{site.data.keyword.cloudant_short_notm}}
{: #creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database}

Ce tutoriel montre comment créer une application
{{site.data.keyword.cloud}} qui utilise le [langage de programmation Python ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://www.python.org/){: new_window} pour accéder à une base de données
{{site.data.keyword.cloudantfull}} hébergée dans votre instance de service {{site.data.keyword.cloud_notm}}.
{: shortdesc}

## Avantages d'{{site.data.keyword.cloud_notm}}
{: #advantages-of-ibm-cloud}

L'un des principaux avantages de {{site.data.keyword.cloud}} est que vous pouvez créer et déployer des applications dans {{site.data.keyword.cloud_notm}} lui-même.
Il n'est pas nécessaire de rechercher et gérer un serveur pour exécuter vos applications.

Si vous utilisez déjà une instance de base de données {{site.data.keyword.cloudant_short_notm}} dans {{site.data.keyword.cloud_notm}}, il est judicieux de disposer de vos applications ici aussi.

Les applications {{site.data.keyword.cloud_notm}} sont généralement créées à l'aide de la technologie [Cloud Foundry ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://en.wikipedia.org/wiki/Cloud_Foundry){: new_window}.
Cloud Foundry offre une fonction de plateforme sous forme de services (Platform-as-a-Service ou PaaS) qui simplifie le processus de création des applications pouvant être déployées et exécutées dans un environnement de cloud.

[Un tutoriel distinct](/docs/services/Cloudant?topic=cloudant-creating-and-populating-a-simple-ibm-cloudant-database-on-ibm-cloud#creating-and-populating-a-simple-ibm-cloudant-database-on-ibm-cloud) vous a montré comment créer une application Python autonome qui utilise une instance de base de données {{site.data.keyword.cloudant_short_notm}} dans {{site.data.keyword.cloud_notm}}.
Dans ce tutoriel, vous allez configurer et créer une petite application Python hébergée dans {{site.data.keyword.cloud_notm}}.
Cette application se connecte à votre instance de la base de données {{site.data.keyword.cloudant_short_notm}} et crée un seul document simple.

Le code Python propre à chaque tâche est fourni dans le cadre de ce tutoriel.
Un programme Python complet, suffisant pour illustrer les différents concepts, est fourni
dans le tutoriel [Création d'une application {{site.data.keyword.cloud_notm}} simple permettant d'accéder à une base de données {{site.data.keyword.cloudant_short_notm}}](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-code#complete-python-program).

Aucune tentative de création d'un code Python _efficace_ n'a été
effectuée pour ce tutoriel.
Notre seule intention est de vous montrer un code simple et facile à comprendre, qui
fonctionne, et que vous pouvez apprendre et appliquer à vos propres applications.

De même, nous n'avons pas essayé de résoudre toutes les vérifications ou conditions d'erreur possibles.
Certains exemples de vérifications sont inclus dans le but d'illustrer certaines
techniques, mais vous devez appliquer les meilleures pratiques afin de vérifier et
traiter tous les avertissements ou cas d'erreur que vous rencontrez dans vos propres applications.

## Présentation des tâches
{: #task-overview}

Pour créer une application Python qui fonctionne sur
{{site.data.keyword.cloud_notm}} capable d'accéder à une instance de base de
données {{site.data.keyword.cloudant_short_notm}}, vous devez procéder comme suit :

-   [Créez un environnement d'application Python sur {{site.data.keyword.cloud_notm}}.](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#creating-an-ibm-cloud-application-environment)
-   [Vérifiez que l'environnement d'application Python dispose d'une connexion à une instance de base de données {{site.data.keyword.cloudant_short_notm}}.](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#connecting-ibm-cloud-applications-and-services)
-   [(Tâche ponctuelle) Téléchargez et installez les kits d'outils de commande Cloud Foundry et {{site.data.keyword.cloud_notm}}.](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#the-cloud-foundry-and-ibm-cloud-command-toolkits)
-   [Téléchargez l'application de démarrage.](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#the-starter-application)
-   [Personnalisez l'application de démarrage pour créer votre propre application qui accédera à l'instance de base de données {{site.data.keyword.cloudant_short_notm}}.](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-code#the-application-code)
-   [Transférez votre application et vérifiez qu'elle fonctionne.](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-uploading-the-application#uploading-the-application)
-   [Effectuez des tâches de maintenance d'application de base.](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-maintaining-and-troubleshooting#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-maintaining-and-troubleshooting)
-   [Diagnostiquez et résolvez les problèmes (traitement des incidents).](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-maintaining-and-troubleshooting#diagnosing-and-resolving-problems)

## Structure du tutoriel
{: #tutorial-structure}

Le tutoriel est composé des cinq sections suivantes :

1.  [Conditions prérequises](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-prerequisites#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-prerequisites)
2.  [Environnement d'application](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment)
3.  [Création de votre application](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-code#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-code)
4.  [Transfert et exécution de votre application](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-uploading-the-application#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-uploading-the-application)
5.  [Maintenance et traitement des incidents liés à votre application](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-maintaining-and-troubleshooting#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-maintaining-and-troubleshooting)

Pour démarrer le tutoriel, commencez par [vérifier les prérequis](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-prerequisites#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-prerequisites).
