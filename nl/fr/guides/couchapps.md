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

<!-- Acrolinx: 2018-05-07 -->

# Applications Couch

{{site.data.keyword.cloudantfull}} peut héberger des données de fichiers RAW, notamment des images, et les distribuer sur HTTP, ce qui signifie qu'il peut héberger tous les fichiers statiques nécessaires à l'exécution d'un site Web, à l'instar d'un serveur Web.
{:shortdesc}

Ces fichiers étant hébergés sur {{site.data.keyword.cloudant_short_notm}}, JavaScript côté client peut accéder aux bases de données {{site.data.keyword.cloudant_short_notm}}.
Une application de ce type est considérée comme une architecture à deux niveaux, composée du client - généralement le navigateur - et de la base de données.
Dans la communauté CouchDB, cette application est appelée une application Couch (CouchApp).

La plupart des applications Web possèdent trois niveaux :
le client,
le serveur,
et la base de données.
Le fait de placer le serveur entre le client et la base de données peut faciliter l'authentification,
l'autorisation,
la gestion des actifs,
l'optimisation des API Web tierces,
en fournissant des noeuds finaux particuliers sophistiqués,
etc.
Cette séparation permet une complexité accrue sans engendrer de problèmes de confusion,
de sorte que votre client peut s'occuper uniquement de la présentation de ses données,
pendant que la base de données se charge du stockage et de la diffusion des données.

Les applications Couch sont relativement simples, tandis que les applications Web nécessitent souvent la puissance d'une architecture à trois niveaux.
Dans quels cas ces applications sont-elles le plus approprié ?

## Une application Couch est appropriée si...

-   Votre serveur n'aurait de toute façon fourni qu'une API à {{site.data.keyword.cloudant_short_notm}}.
-   Vous êtes prêt à utiliser l'[authentification basée sur les cookies](../api/authentication.html) de {{site.data.keyword.cloudant_short_notm}}.
-   Vous êtes prêt à utiliser les bases de données [`_users` et `_security`](../api/authorization.html) de {{site.data.keyword.cloudant_short_notm}} pour gérer les utilisateurs et les permissions.
-   Vous n'avez pas besoin de planifier des tâches cron ou d'autres tâches régulières.

Pour vous familiariser avec les applications Couch, consultez la rubrique [Gestion des applications sur {{site.data.keyword.cloudant_short_notm}} ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://cloudant.com/blog/app-management/){:new_window}.

## Une application à trois niveaux est appropriée si...

-   Vous avez besoin de droits d'accès plus fins que ceux fournis par la base de données `_security`.
-   Vous avez besoin d'une méthode d'authentification différente de l'authentification de base ou de l'authentification par cookie, telles que Oauth ou un système de connexion tiers.
-   Vous avez besoin de planifier des tâches en dehors du client dont l'exécution est régulière.

Vous pouvez écrire votre couche serveur à l'aide des technologies qui vous conviennent le mieux.
La liste des bibliothèques compatibles avec {{site.data.keyword.cloudant_short_notm}} est [disponible ici](../libraries/index.html).
