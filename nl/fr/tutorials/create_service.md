---

copyright:
  years: 2017, 2018
lastupdated: "2018-06-07"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

# Création d'une instance {{site.data.keyword.cloudant_short_notm}} sur {{site.data.keyword.Bluemix_notm}}

Ce tutoriel explique comment créer une instance de service
{{site.data.keyword.cloudantfull}} à l'aide du tableau de bord
{{site.data.keyword.Bluemix}} et indique où trouver les informations
essentielles permettant d'activer vos applications en vue de leur utilisation avec la
base de données.
{:shortdesc}

Pour accéder à une instance de service
{{site.data.keyword.cloudant_short_notm}}, vous devez disposer d'un ensemble de
[données d'identification du service](#the-service-credentials).
Les données d'identification sont générées dans le cadre du processus de création d'une instance de service.

Vous pouvez également retrouver ces données d'identification à n'importe quel
moment en accédant à votre compte {{site.data.keyword.cloudant_short_notm}}.

## Création d'une instance de service

1.  Connectez-vous à votre compte {{site.data.keyword.Bluemix_notm}}.<br/>
    Le tableau de bord {{site.data.keyword.Bluemix_notm}} est disponible à l'adresse :
    [http://bluemix.net ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](http://bluemix.net){:new_window}.
    Une fois que vous vous êtes authentifié avec votre nom d'utilisateur et votre mot de passe, le tableau de bord {{site.data.keyword.Bluemix_notm}} apparaît :<br/>
    ![Tableau de bord {{site.data.keyword.Bluemix_notm}}](images/img0001.png)

2.  Cliquez sur le lien `Catalogue` :<br/>
    ![Lien du catalogue {{site.data.keyword.Bluemix_notm}}](images/img0002.png)<br/>
    La liste des services disponibles sur {{site.data.keyword.Bluemix_notm}} s'affiche.

3.  Cliquez sur l'entrée `Données & analyse` sous l'en-tête `Services` :<br/>
    ![Services {{site.data.keyword.Bluemix_notm}} Données & analyse](images/img0003.png)<br/>
    La liste des services Données & analyse disponibles sur {{site.data.keyword.Bluemix_notm}} apparaît.

4.  Cliquez sur le service {{site.data.keyword.cloudant_short_notm}} :<br>
    ![Sélection du service {{site.data.keyword.Bluemix_notm}} {{site.data.keyword.cloudant_short_notm}}](images/img0004.png)

5.  Dans la fenêtre de configuration du service, entrez un nom de service.
    Dans cet exemple, le nom du service est `Cloudant Service 2017`:<br/>
    ![Nom et données d'identification du service {{site.data.keyword.cloudant_short_notm}}](images/img0005.png)

6.  Par défaut, le service est créé avec le Plan de tarification limité, gratuit mais offrant des fonctions limitées.
    D'autres plans de tarification proposant davantage de fonctionnalités [sont disponibles](../offerings/bluemix.html).<br/>
    Pour créer le service, cliquez sur le bouton `Créer` :<br/>
    ![Créez le nom et les données d'identification du service {{site.data.keyword.cloudant_short_notm}}](images/img0006.png)

7.  Une page s'affiche, confirmant que le nouveau service {{site.data.keyword.cloudant_short_notm}} est disponible.
    Pour accéder aux informations de connexion nécessaires à votre application pour la connexion au service, cliquez sur l'onglet `Données d'identification pour le service` :<br/>
    ![Accès aux données d'identification du service {{site.data.keyword.cloudant_short_notm}}](images/img0007.png)

8.  La fenêtre Données d'identification pour le service apparaît.
    Pour afficher les données d'identification requises pour l'accès au service, cliquez
sur la liste déroulante `Afficher les données d'identification` :<br/>
    ![Affichage des données d'identification du service {{site.data.keyword.cloudant_short_notm}}](images/img0008.png)

9.  Les données d'identification détaillées du service s'affichent :<br/>
    ![Données d'identification du service {{site.data.keyword.cloudant_short_notm}}](images/img0009.png)

>   **Remarque** : Les données d'identification du service de ces exemples
    ont été définies lors de la création d'un service {{site.data.keyword.cloudant_short_notm}} de démonstration sur {{site.data.keyword.cloudant_short_notm}}.
    Ces données d'identification sont reproduites ici pour illustrer la manière dont elles apparaissent dans le tableau de bord.
    Toutefois, le service {{site.data.keyword.cloudant_short_notm}} de démonstration ayant été retiré, elles ne sont plus
valides. Vous _devez_ indiquer et utiliser vos propres
données d'identification pour le service.

## Données d'identification du service

>   **Remarque** : Les données d'identification du service sont précieuses.
    Si un utilisateur ou une application dispose d'un accès aux données d'identification,
    il peut effectuer n'importe quelle opération sur l'instance de service, comme créer
    des données erronées ou supprimer des informations utiles.
    Il convient de protéger ces données d'identification avec soin.

Les données d'identification du service comportent cinq zones :

Zone      | Objectif
-----------|--------
`host`     | Nom d'hôte employé par les applications pour localiser l'instance de service.
`username` | Nom d'utilisateur requis par les applications pour accéder à l'instance de service.
`password` | Mot de passe requis par les applications pour accéder à l'instance de service.
`port`     | Numéro de port HTTP pour l'accès à l'instance de service sur l'hôte. Il s'agit généralement du numéro de port 443 qui force l'accès HTTPS.
`url`      | Chaîne regroupant les autres informations de données d'identification en une seule URL, adaptée pour une utilisation par des applications.

Pour créer une application qui peut accéder à votre instance de service, vous avez besoin de ces données d'identification.

## Localisation de vos données d'identification du service

A tout moment, vous pouvez retrouver les données d'identification d'un service qui est associé à votre compte.

1.  Commencez par vous connecter à {{site.data.keyword.cloudant_short_notm}}.
    Le tableau de bord {{site.data.keyword.Bluemix}} est disponible à l'adresse :
    [http://bluemix.net ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](http://bluemix.net){:new_window}.
    Une fois que vous vous êtes authentifié avec votre nom d'utilisateur et votre mot de passe, le tableau de bord {{site.data.keyword.Bluemix_notm}} apparaît :<br/>
    ![Tableau de bord {{site.data.keyword.Bluemix_notm}}](images/img0001.png)

2.  Faites défiler le tableau de bord vers le bas jusqu'à ce que vous atteignez la section qui répertorie tous vos services :<br/>
    ![{{site.data.keyword.Bluemix_notm}}' liste de services](images/img0010.png)

3.  Dans cet exemple, vous recherchez les données d'identification du service pour
l'instance de service {{site.data.keyword.cloudant_short_notm}} créée précédemment dans le tutoriel et nommée `Cloudant Service 2017`.
    Cliquez sur la ligne correspondante :<br/>
    ![Sélection du service {{site.data.keyword.cloudant_short_notm}}](images/img0011.png)

3.  La fenêtre Données d'identification pour le service apparaît.
    Pour afficher les données d'identification requises pour l'accès au service, cliquez
sur la liste déroulante `Afficher les données d'identification` :<br/>
    ![Affichage des données d'identification du service {{site.data.keyword.cloudant_short_notm}}](images/img0008.png)

4.  Les données d'identification détaillées du service s'affichent :<br/>
    ![Données d'identification du service {{site.data.keyword.cloudant_short_notm}}](images/img0009.png)

>   **Remarque** : Les données d'identification du service de ces exemples
    ont été définies lors de la création d'un service {{site.data.keyword.cloudant_short_notm}} de démonstration sur {{site.data.keyword.cloudant_short_notm}}.
    Ces données d'identification sont reproduites ici pour illustrer la manière dont elles apparaissent dans le tableau de bord.
    Toutefois, le service {{site.data.keyword.cloudant_short_notm}} de démonstration ayant été retiré, elles ne sont plus
valides. Vous _devez_ indiquer et utiliser vos propres
données d'identification pour le service.
