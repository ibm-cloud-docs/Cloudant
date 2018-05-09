---

copyright:
  years: 2015, 2018
lastupdated: "2018-02-15"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

# Principes de base de {{site.data.keyword.cloudant_short_notm}}

Si vous consultez cette documentation pour la première fois, lisez la présente section avant de poursuivre.
{:shortdesc}

Les sections issues des [Bibliothèques client](../libraries/index.html#-client-libraries), de la
[Référence d'API](../api/index.html#-api-reference) et des [Guides](../guides/acurl.html#authorized-curl-acurl-) supposent que vous possédez un minimum de connaissances sur {{site.data.keyword.cloudantfull}}.

## Connexion à {{site.data.keyword.cloudant_short_notm}}

Pour accéder à {{site.data.keyword.cloudant_short_notm}}, vous devez disposer d'un [compte {{site.data.keyword.cloudant}}](../api/account.html) ou d'un [compte {{site.data.keyword.Bluemix}}](../offerings/bluemix.html).

## API HTTP

Toutes les demandes adressées à {{site.data.keyword.cloudant_short_notm}} sont acheminées sur le Web. Autrement dit, tout système connecté à Internet peut communiquer avec {{site.data.keyword.cloudant_short_notm}}. Toutes les bibliothèques de langue pour {{site.data.keyword.cloudant_short_notm}} ne sont en réalité que des encapsuleurs qui fournissent des commodités et subtilités d'ordre linguistique afin de vous aider à utiliser une API simple. Un grand nombre d'utilisateurs choisissent d'utiliser des bibliothèques HTTP brutes pour travailler avec {{site.data.keyword.cloudant_short_notm}}.

Pour en savoir plus sur la façon dont {{site.data.keyword.cloudant_short_notm}} utilise le protocole HTTP, consultez la  [rubrique HTTP sur la référence d'API](../api/http.html).

Les méthodes de demande HTTP prises en charge par {{site.data.keyword.cloudant_short_notm}} sont les suivantes :

-   `GET`

    Demande l'élément spécifié.
    A l'instar des demandes HTTP standard,
    le format de l'URL définit les éléments renvoyés.
    Avec {{site.data.keyword.cloudant_short_notm}}, il peut s'agir d'éléments statiques, de documents de base de données et d'informations sur la configuration et les statistiques. Dans la plupart des cas, les informations sont renvoyées sous forme de document JSON.

-   `HEAD`

    La méthode `HEAD` est utilisée pour obtenir l'en-tête HTTP d'une demande `GET` sans le corps de la réponse.

-   `POST`

    Téléchargement de données.
    Dans l'API de {{site.data.keyword.cloudant_short_notm}},
    la méthode `POST` permet de configurer des valeurs,
    de télécharger des documents,
    de définir des valeurs de document,
    et d'exécuter certaines commandes d'administration.

-   `PUT`

    Permet de "stocker" une ressource spécifique.
    Dans l'API de {{site.data.keyword.cloudant_short_notm}},
    la méthode `PUT` permet de créer des objets,
    y compris des bases de données,
    des documents,
    des vues,
    et des documents de conception.

-   `DELETE`

    Supprime la ressource spécifiée,
    y compris des documents,
    des vues,
    et des documents de conception.

-   `COPY`

    Méthode spéciale pouvant être utilisée pour copier des documents et des objets.

Si le client (certains navigateurs, par exemple) ne prend pas en charge l'utilisation de ces méthodes HTTP,
la méthode `POST` peut être utilisée avec l'en-tête de demande `X-HTTP-Method-Override` défini sur la méthode HTTP en cours.

### Erreur relative à une méthode non autorisée

Si vous exécutez un type de demande HTTP non pris en charge avec une adresse URL non compatible avec le type spécifié,
une erreur [405](../api/http.html#405) est renvoyée,
avec la liste des méthodes HTTP prises en charge, comme illustré dans l'exemple ci-dessous.

_Exemple de message d'erreur en réponse à une demande non prise en charge :_

```json
{
    "error":"method_not_allowed",
    "reason":"Only GET,HEAD allowed"
}
```
{:codeblock}

## JSON
{: #json}

{{site.data.keyword.cloudant_short_notm}} stocke les documents à l'aide du codage JSON (JavaScript Object Notation),
ce qui signifie que tout élément encodé en JSON peut être stocké sous forme de document.
Les fichiers incluant des médias,
tels que des images,
des vidéos,
et du son,
sont appelés objets BLOB (Binary Large OBjects),
et peuvent être stockés en tant que pièces jointes associées aux documents.

Pour plus d'informations sur JSON, consultez le [guide JSON](../guides/json.html).

<div id="distributed"></div>

## Systèmes distribués

L'API de {{site.data.keyword.cloudant_short_notm}} vous permet d'interagir avec de nombreuses machines, appelées cluster.
Ces machines en cluster doivent être installées dans le même centre de données,
mais peuvent se trouver dans différents "pods" du centre de données.
L'utilisation de pods différents permet d'améliorer la haute disponibilité de {{site.data.keyword.cloudant_short_notm}}.

L'un des avantages de la fonction de cluster est que vous pouvez simplement ajouter des machines lorsque vous avez besoin d'une plus grande puissance de calcul.
Cette technique est généralement plus économique et offre une meilleure tolérance aux pannes que la mise à l'échelle ou l'optimisation d'une seule machine existante.

Pour plus d'informations sur {{site.data.keyword.cloudant_short_notm}} et les concepts de systèmes distribués, consultez le guide [Théorème CAP](../guides/cap_theorem.html).

## Réplication

La [réplication](../api/replication.html) est une procédure appliquée par {{site.data.keyword.cloudant_short_notm}},
[CouchDB ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](http://couchdb.apache.org/){:new_window},
[PouchDB ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](http://pouchdb.com/){:new_window} et autres bases de données distribuées.
La réplication synchronise l'état de deux bases de données de sorte que leur contenu soit parfaitement identique.

Vous pouvez procéder à la réplication continue.
Ainsi, la base de données cible met à jour son contenu chaque fois que la base de données source subit des modifications.
La réplication continue peut être utilisée pour la sauvegarde de données, l'agrégation de données entre plusieurs bases de données, ainsi que le partage de données.

Toutefois, la réplication continue implique de vérifier continuellement les modifications apportées à la base de données source.
Cette vérification nécessite des appels internes permanents, ce qui a des répercussions négatives sur les performances ou le coût d'utilisation de la base de données.

>   **Remarque** : La réplication continue peut entraîner un grand nombre d'appels internes.
    Ceci pourrait avoir un effet sur le coût pour les utilisateurs à service partagé des systèmes {{site.data.keyword.cloudant_short_notm}}. La réplication continue est désactivée par défaut.
