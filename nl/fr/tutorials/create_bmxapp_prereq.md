---

copyright:
  years: 2017, 2019
lastupdated: "2019-06-12"

keywords: python, create service instance, create stand-alone python application

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

# Création d'une application {{site.data.keyword.cloud_notm}} simple permettant d'accéder à une base de données {{site.data.keyword.cloudant_short_notm}} : conditions prérequises
{: #creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-prerequisites}

Cette section du tutoriel décrit les conditions prérequises pour la création d'une application {{site.data.keyword.cloud}}.
{: shortdesc}

## Conditions prérequises
{: #prerequisites-create_bmxapp_prereq}

Vérifiez que vous disposez des ressources ou des informations suivantes avant de commencer à travailler sur ce tutoriel.

### Python
{: #python-create-bmxapp-prereq}

Dans le but de simplifier au maximum le travail de développement, il est plus facile de disposer d'une installation en cours du
[langage de programmation Python ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://www.python.org/){: new_window} sur votre système.

Pour savoir si vous disposez d'une telle installation, exécutez la commande suivante à l'invite :

```sh
python --version
```
{: pre}

Vous devez obtenir un résultat similaire à la sortie suivante :

```
Python 2.7.12
```
{: codeblock}

### Instance de service {{site.data.keyword.cloudant_short_notm}} sur {{site.data.keyword.cloud_notm}}
{: #an-ibm-cloudant-service-instance-on-ibm-cloud}

Un tutoriel distinct de [création d'une instance de service {{site.data.keyword.cloudantfull}} sur {{site.data.keyword.cloud_notm}}](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud#creating-an-ibm-cloudant-instance-on-ibm-cloud) permet de créer une instance de service appelée
'`Cloudant-o7`'. 

Ce tutoriel suppose que vous avez déjà créé une instance de service nommée `Cloudant-o7`.

### Application de base de données {{site.data.keyword.cloudant_short_notm}}
{: #an-ibm-cloudant-database-application}

Un tutoriel distinct de [création d'une application Python autonome capable de fonctionner avec une instance de service {{site.data.keyword.cloudant_short_notm}}] (/docs/services/Cloudant?topic=cloudant-creating-and-populating-a-simple-ibm-cloudant-database-on-ibm-cloud#creating-and-populating-a-simple-ibm-cloudant-database-on-ibm-cloud) est également disponible. Il présente un certain nombre de concepts utiles qui permettent de comprendre comment
créer et remplir une base de données {{site.data.keyword.cloudant_short_notm}}.

Ce tutoriel suppose que vous connaissez ces concepts.

L'étape suivante de ce tutoriel consiste à [créer l'environnement d'application](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment).
