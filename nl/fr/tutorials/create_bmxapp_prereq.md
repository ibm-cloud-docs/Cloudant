---

copyright:
  years: 2017
lastupdated: "2017-01-10"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-01-10 -->

# Création d'une application Bluemix simple permettant d'accéder à une base de données Cloudant : conditions prérequises

Cette section du tutoriel décrit les conditions prérequises pour la création d'une application {{site.data.keyword.Bluemix}}.
{:shortdesc}

## Conditions prérequises

Vérifiez que vous disposez des ressources ou des informations suivantes avant de commencer à travailler sur ce tutoriel. 

### Python

Dans le but de simplifier au maximum le travail de développement, il est plus facile de disposer d'une installation en cours du
[langage de programmation Python ![External link icon](../images/launch-glyph.svg "External link icon")](https://www.python.org/){:new_window} sur votre système. 

Pour savoir si vous disposez d'une telle installation, exécutez la commande suivante à l'invite :

```sh
python --version
```
{:pre}

Vous devez obtenir un résultat similaire à la sortie suivante : 

```
Python 2.7.12
```
{:codeblock}

<div id="csi"></div>

### Instance de service Cloudant sur Bluemix

Un tutoriel distinct de création d'une instance de service {{site.data.keyword.cloudant_short_notm}} nommée
'`Cloudant Service 2017`' est disponible [ici](create_service.html).

Ce tutoriel suppose que vous avez déjà créé une instance de service nommée '`Cloudant Service 2017`'.

### Application de base de données Cloudant

Un tutoriel distinct de création d'une application Python autonome capable de fonctionner avec une instance de service
{{site.data.keyword.cloudant_short_notm}} est disponible [ici](create_database.html).
Il présente un certain nombre de concepts utiles qui permettent de comprendre comment
créer et remplir une base de données {{site.data.keyword.cloudant_short_notm}}.

Ce tutoriel suppose que vous connaissez ces concepts.

## Etape suivante

L'étape suivante de ce tutoriel consiste à [créer l'environnement d'application](create_bmxapp_appenv.html).
