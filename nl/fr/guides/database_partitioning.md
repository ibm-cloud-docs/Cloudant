---

copyright:
  years: 2019
lastupdated: "2019-06-12"

keywords: database shards, non-partitioned databases, partition key, global query, partition query, create partition database, create partition query index

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

<!-- Acrolinx: 2018-08-17 -->

# Partitionnement de base de données
{: #database-partitioning}

{{site.data.keyword.cloudantfull}} prend en charge deux types de base de données :

- Base de données partitionnée
- Base de données non partitionnée

Une base de données _partitionnée_ offre des avantages significatifs au niveau des performances et des coûts mais nécessite la spécification d'un partitionnement logique de vos données. Cette opération est décrite plus en détails dans le texte suivant.

Vous pouvez aussi créer une base de données _non partitionnée_. Ce type de base de données peut être plus facile à utiliser puisqu'aucun schéma de partitionnement ne doit être défini, mais seuls des index secondaires globaux peuvent être créés.

{{site.data.keyword.cloudant_short_notm}} recommande fortement l'utilisation d'une base de données partitionnée pour de meilleures performances de cette dernière sur le long terme, quand le modèle de données permet le partitionnement logique des documents.

Le type de partitionnement d'une base de données est défini au moment de sa création.  Lors de la création d'une base de données, utilisez le paramètre de chaîne de requête `partitioned` pour définir si la base de données est partitionnée ou non. La valeur par défaut pour `partitioned` est `false`, pour maintenir une compatibilité avec les versions antérieures.

Le type de partitionnement ne peut pas être modifié pour une base de données existante.

## Fragments de base de données
{: #database-shards}

Avant de lire ce document, vous devez comprendre le [concept de fragmentation](/docs/services/Cloudant?topic=cloudant-how-is-data-stored-in-ibm-cloudant-#how-is-data-stored-in-ibm-cloudant-) dans {{site.data.keyword.cloudant_short_notm}}.

## Bases de données non partitionnées
{: #non-partitioned-databases}

Le type non partitionné pour une base de données est le type le plus ancien des bases de données {{site.data.keyword.cloudant_short_notm}}, que vous connaissez si vous avez utilisé CouchDB ou {{site.data.keyword.cloudant_short_notm}} auparavant.

Dans une base de données non partitionnée, les documents sont répartis dans des fragments de façon arbitraire en fonction d'une transformation de leur ID de document. De ce fait, il n'y a pas de réelle relation entre l'ID d'un document et le fragment où ce dernier est placé au final. Des documents dont les ID sont très similaires ont peu de chance de se trouver dans le même fragment.

Une base de données non partitionnée ne propose qu'une interrogation globale, décrite plus en détail ultérieurement.

## Bases de données partitionnées
{: #partitioned-databases-database-partitioning}

Le type partitionné pour une base de données est le type le plus récent des bases de données {{site.data.keyword.cloudant_short_notm}}. Dans une base de données partitionnée, les documents sont regroupés en partitions logiques, en utilisant une _clé de partitionnement_, qui est intégrée aux ID des documents inclus dans la base de données partitionnée. Tous les documents sont affectés dans une partition et la même clé de partitionnement est généralement donnée à beaucoup de documents différents. Dans une partition, des données JSON principales sont placées au même endroit que les index associés, ce qui permet à la base de données de procéder à une interrogation par requête plus efficace de ces données dans la partition.

Une base de données partitionnée propose deux types d'interrogation : globale et partitionnée. Une interrogation partitionnée profite de l'agencement des données dans le cluster de base de données pour mettre en place des requêtes plus efficaces et évolutives. De plus, les requêtes dans une partition sont souvent moins coûteuses que les requêtes globales.

Une base de données partitionnée offrant les avantages des deux types d'interrogation (globale et dans une partition), {{site.data.keyword.cloudant_short_notm}} recommande aux nouvelles applications d'adopter cette approche.

## Qu'est-ce qu'une bonne clé de partitionnement ?
{: #what-makes-a-good-partition-key-}

Si vous envisagez d'utiliser la nouvelle fonction de *base de données partitionnée* de {{site.data.keyword.cloudant_short_notm}}, le choix d'une clé de partitionnement est essentiel. Une clé de partitionnement doit répondre aux caractéristiques suivantes :

- Elle doit se composer de nombreuses valeurs - beaucoup de petites partitions sont préférables à un petit nombre de grosses partitions.
- Elle ne doit pas comporter de zones sensibles (ou hot spots) - évitez de concevoir un système dans lequel une partition gère une grande partie de la charge de travail. Si le travail est équitablement réparti entre toutes les partitions, la base de données fonctionne de façon plus harmonieuse.
- Elle ne doit pas être unique - si chaque clé de partitionnement est unique, chaque partition ne contient qu'un seul document. Pour tirer le meilleur parti d'une base de données partitionnée, chacune des partitions doit contenir de nombreux documents, liés logiquement entre eux.

Prenez connaissance des cas d'utilisation ci-après, associés à un commentaire sur la justesse du choix effectué pour chaque clé de partitionnement associée.

| Cas d'utilisation                   | Description                 | Clé de partitionnement | Efficacité                                                                                                  |
|----------------------------|-----------------------------|---------------|------------------------------------------------------------------------------------------------------------------|
| Systèmes de commerce électronique - commandes | Un document par commande     | order_id      | Neutre - le fait d'avoir un document par partition est une solution acceptable mais elle ne permet pas de bénéficier de l'exécution de requêtes dans une partition.          |
| Systèmes de commerce électronique - commandes | Un document par commande     | user_id       | Bonne - toutes les commandes d'un utilisateur sont conservées ensemble.                                                             |
| Systèmes de commerce électronique - commandes | Un document par commande      | status        | Mauvaise - le fait de regrouper des commandes en utilisant une petite poignée de valeurs de statut (provisional, paid, refunded, cancelled) crée trop peu de grandes partitions.  |
| Plateforme de blogue          | Un document par article de blogue | author_id     | Bonne - à condition qu'il y ait de nombreux auteurs. Facilité d'interrogation des différents articles de chaque auteur.                                     |
| IOT - relevés de capteur      | Un document par lecture    | device_id     | Bonne - s'il y a de nombreux périphériques. Assurez-vous qu'un périphérique ne produise pas beaucoup plus de capteurs que les autres. |
| IOT - relevés de capteur      | Un document par lecture    | date          | Mauvaise - les relevés en cours génèrent une "zone sensible" (ou "hot spot") sur la partition de la date actuelle.                                  |

Pour certains cas d'utilisation, une clé de partition n'est pas un choix viable.
Dans ces situations, une base de données non partitionnée est la meilleure option (base de données stockant les adresses e-mail, les hachages de mot de passe et les dates de dernière connexion des utilisateurs, par exemple). Aucune de ces zones ne pouvant être considérée comme une clé de partitionnement adaptée, une base de données non partitionnée normale doit être utilisée.

## Interrogation via des requêtes
{: #querying}

Cette section décrit les types de requête {{site.data.keyword.cloudant_short_notm}} qui sont disponibles (globales et dans une partition) et propose une brève présentation des mécanismes d'interrogation sous-jacents pour vous permettre de sélectionner celui qui convient le mieux à chaque requête que votre application doit effectuer.

### Interrogation globale
{: #global-querying}

Vous pouvez effectuer des requêtes globales dans les types d'index suivants :

- Requête {{site.data.keyword.cloudant_short_notm}}
- Vues
- Recherche
- Géo

Quand vous effectuez une requête globale, la base de données doit exécuter une opération de ventilation-regroupement sur toutes les données de la base de données, ce qui implique la réalisation de requêtes sur de nombreux serveurs de base de données individuels. Le noeud de coordination d'API reçoit les réponses de tous les serveurs et les combine afin de former une réponse unique pour le client, ce qui peut provoquer l'invocation de données en mémoire tampon et un retard de l'envoi de la réponse au client si, par exemple, les données doivent être triées.

### Interrogation dans une partition
{: #partition-querying}

Vous pouvez effectuer des requêtes dans une partition dans les types d'index suivants :

- Requête {{site.data.keyword.cloudant_short_notm}}
- Vues
- Recherche

Lors d'une requête dans une partition, la base de données n'est en mesure de n'interroger que les données d'une partition unique. Puisque les données d'une partition ne résident que dans un seul fragment (avec trois répliques), le noeud de coordination d'API peut effectuer une requête directement sur les serveurs hébergeant les données plutôt que de combiner les réponses en provenance d'un grand nombre de serveurs différents. Il n'est plus non plus nécessaire de mettre la réponse en mémoire tampon, puisqu'il n'y a pas de procédure de combinaison de données à mettre en oeuvre. De ce fait, les données arrivent plus rapidement chez le client.

De plus, alors que la taille de la base de données s'accroît, le nombre de fragments doit aussi augmenter, ce qui provoque une augmentation directe du nombre de requêtes que le noeud de coordination d'API doit effectuer sur les serveurs hébergeant les données en cas d'utilisation de requêtes globales. Lors de l'utilisation de requêtes dans une partition, le nombre de fragments n'a pas d'effet sur le nombre de serveurs que le noeud de coordination d'API doit contacter. Puisque ce nombre reste petit, l'accroissement de la taille des données n'a pas d'effet sur le temps d'attente lors du traitement des requêtes.

## Exemple : partitionnement des données de relevés IoT
{: #example-partitioning-iot-reading-data}

Cette discussion étant relativement abstraite, l'exemple ci-après a pour but de la rendre plus concrète. En partant du domaine IoT (Internet of Things),  une analyse de l'historique des relevés de périphérique va être effectuée en utilisant {{site.data.keyword.cloudant_short_notm}}. Supposez que les périphériques fournissent des relevés sur des éléments d'infrastructure de type routes ou ponts.

Les hypothèses de départ sont les suivantes :

- Plusieurs centaines ou milliers de périphériques génèrent des relevés.
- Chaque périphérique dispose d'un ID unique.
- Chaque élément d'infrastructure dispose d'un ID unique.
- Les périphériques ne sont pas déplacés entre les différents éléments d'infrastructure.
- Chaque périphérique enregistre un relevé dans {{site.data.keyword.cloudant_short_notm}} toutes les 10 secondes, vraisemblablement distribué dans {{site.data.keyword.cloudant_short_notm}} via un bus de messages.

Dans une base de données non partitionnée, vous pouvez autoriser {{site.data.keyword.cloudant_short_notm}} à générer des ID de document. Une autre possibilité consiste à nommer les documents par ID de périphérique et horodatage d'enregistrement.

En utilisant la seconde approche, vous obtenez des ID de document comme celui ci-dessous :

```
device-123456:20181211T11:13:24.123456Z
```

Il peut s'agir aussi d'un horodatage epoch.

Cette approche permet une interrogation efficace des données pour chaque périphérique via des index partitionnés mais l'utilisation d'index globaux peut s'avérer nécessaire pour créer des vues sur des périphériques multiples (tous les périphériques d'un élément d'infrastructure donné, par exemple).

A des fins d'illustration, supposez, pour rendre le scénario un peu plus compliqué, que l'application doit principalement lire toutes les données de capteur pour un élément d'infrastructure spécifique plutôt que pour des périphériques individuels.

Dans cette application, l'interrogation par élément d'infrastructure devant être la plus efficace possible, la mise en place du partitionnement des données par élément d'infrastructure est beaucoup plus judicieuse qu'un partitionnement par ID, car elle permet à tous les périphériques d'un élément d'infrastructure donné d'être interrogés efficacement en tant que groupe.

Pour les rares requêtes par périphérique, deux approches sont possibles :

1. Génération d'un index global avec des clés par périphérique pour y effectuer une requête, méthode plus efficace si les requêtes émises dans des périphériques individuels sont rares et non répétées.
2. Génération d'un index global mappant périphériques et infrastructure puis émission de requêtes dans une partition de l'infrastructure, ce qui est une bonne solution si des requêtes répétées dans des périphériques donnés sont utilisées, car le mappage peut être mis en cache (ce qui est le cas pour cette application exemple).

Etudiez plus en détail le fonctionnement de ce processus, qui repose sur quatre requêtes différentes :

1. Relevés permanents pour un élément d'infrastructure.
1. Relevés quotidiens pour un élément d'infrastructure.
1. Relevés permanents pour un périphérique spécifique.
1. Relevés quotidiens pour un périphérique spécifique.

### Création de la base de données
{: #creating-the-database}

Vous allez utiliser une base de données, intitulée `readings` et un compte, appelé `acme`. Pour créer une base de données partitionnée, passez `true` en tant qu'argument `partitioned` dans la demande de création de base de données :

```
curl -XPUT 'https://acme.cloudant.com/readings?partitioned=true'
```

### Structure de document
{: #document-struture}

Définissez d'abord un format de document simple à utiliser :

```json
{
    "deviceID": "device-123456",
    "infrastructureID": "bridge-9876",
    "ts": "20181211T11:13:24.123456Z",
    "reading": {
        "temperature": {"value": 12, "unit": "c"}
    }
}
```

Pour ce document, en utilisant le schéma de partitionnement reposant sur un élément d'infrastructure, l'ID de document peut inclure l'ID d'infrastructure en tant que clé de partitionnement, et inclure le périphérique et l'horodatage comme clé de document :

```
bridge-9876:device-123456-20181211T11:13:24.123456Z
```

### Création des index
{: #creating-indexes}

Pour les requêtes décrites ci-dessus, vous avez besoin de deux index :

1. Un index global mappant l'ID de périphérique à l'ID d'infrastructure.
2. Un index partitionné mappant les ID de périphérique aux relevés.

#### Création d'un index de vue global
{: #creating-a-global-view-index}

L'utilisation d'un index de vue est la façon la plus efficace d'effectuer le mappage d'ID de périphérique simple à l'ID d'infrastructure. Pour le définir, téléchargez un document de conception avec `options.partitioned` défini sur `false`, car il s'agit d'un index global. Alors que dans une fonction `map` réelle, vous pourriez vouloir être plus défensif par rapport à l'existence des zones, le résultat de cette application exemple peut ressembler à ceci :

```json
{
    "_id": "_design/infrastructure-mapping",
    "options": {"partitioned": false},
    "views": {
        "by-device": {
            "map": "function(doc) { emit(doc.deviceID, doc.infrastructureID) }"
        }
    }
}
```

En supposant l'existence du document précédent dans `./view.json`, son téléchargement s'effectue dans la base de données en utilisant :

```
curl -XPOST https://acme.cloudant.com/readings -d @view.json
```

#### Création d'un index de requête {{site.data.keyword.cloudant_short_notm}} partitionné
{: #creating-a-paritioned-ibm-cloudant-query-index}

Pour retourner les relevés pour un périphérique donné depuis une partition, vous pouvez utiliser un index de requête {{site.data.keyword.cloudant_short_notm}}. Pour ce faire, utilisez `POST` dans `_index`, avec une définition d'index qui inclut la zone `partitioned` définie à `true`. 

Pour les définitions d'index de requête, la zone `partitioned` n'est pas imbriquée dans un objet `options`.
{: note}

Pour vos requêtes, vous avez besoin de deux index partitionnés :

1. Par horodatage
2. Par ID de périphérique et horodatage

La définition par horodatage est la suivante :

```json
{
   "index": {
      "fields": [
         "ts"
      ]
   },
   "name": "timestamped-readings",
   "type": "json",
   "partitioned:" true
}
```

En supposant l'existence du document précédent dans `./query-index1.json`, téléchargez l'index dans la base de données à l'aide de la commande suivante :

```
curl -XPOST https://acme.cloudant.com/readings/_index -d @query-index1.json
```

La définition par ID de périphérique est la suivante :

```json
{
   "index": {
      "fields": [
         "deviceID",
         "ts"
      ]
   },
   "name": "deviceID-readings",
   "type": "json",
   "partitioned:" true
}
```

En supposant l'existence du document précédent dans `./query-index2.json`, téléchargez l'index dans la base de données à l'aide de la commande suivante :

```
curl -XPOST https://acme.cloudant.com/readings/_index -d @query-index2.json
```

### Exécution de requêtes
{: #making-queries}

Vous allez effectuer quatre requêtes :

1. Relevés permanents pour un élément d'infrastructure.
1. Relevés quotidiens pour un élément d'infrastructure.
1. Relevés permanents pour un périphérique spécifique.
1. Relevés quotidiens pour un périphérique spécifique.

#### Localisation de tous les relevés pour un élément d'infrastructure
{: #finding-all-readings-for-a-piece-of-infrastructure}

Comme vos partitions reposent sur une infrastructure, vous pouvez utiliser `_all_docs` pour une partition. L'exemple suivant illustre une interrogation pour tous les relevés de l'élément d'infrastructure `bridge-1234` :

```
curl -XGET \
    'https://acme.cloudant.com/readings/_partition/bridge-1234/_all_docs?include_docs=true'
```

#### Localisation des relevés récents pour un élément d'infrastructure
{: #finding-recent-readings-for-a piece-of-infrastructure}

Cette requête doit utiliser l'index `timestamped-readings` partitionné. Vous pouvez effectuer une requête dans la partition pour obtenir les relevés du jour :

_query.json, assuming today is 13th Dec 2018:_

```json
{
    "selector": {
        "ts": { "$gte": "20181213"}
    }
}
```

La partition est intégrée dans le chemin HTTP lors de l'émission de la demande dans {{site.data.keyword.cloudant_short_notm}} :

```
curl -XPOST \
    'https://acme.cloudant.com/readings/_partition/bridge-1234/_find' \
    -d @query.json
```

#### Localisation de l'ID d'infrastructure pour un périphérique
{: #finding-the-infrastructure-id-for-a-device}

Les deux requêtes que vous devez exécuter sont les suivantes :

1. Relevés permanents pour un périphérique spécifique.
2. Relevés quotidiens pour un périphérique spécifique.

Pour ces deux requêtes, vous devez trouver la partition pour les périphériques en utilisant l'index `by-device` global. Ensuite, vous pouvez effectuer une requête pour les relevés sur la partition individuelle. Alors que vous avez dû utiliser un index global pour rechercher par requête les relevés de périphériques individuels, le mappage d'un périphérique à un ID d'infrastructure peut être très facilement mis en cache, puisqu'il ne change jamais, cette approche vous permettant donc d'utiliser majoritairement la requête partitionnée la moins chère et la plus efficace pour la plupart des demandes.

L'utilisation d'un index global pour obtenir directement par requête des relevés de périphérique peut être plus efficace si la mise en cache du mappage  d'un périphérique à une infrastructure ne fonctionne pas correctement pour une application donnée.

Pour trouver la partition pertinente pour un périphérique, vous effectuez une requête sur la vue `by-device`, en envoyant l'ID de service en tant que clé :

```
curl -XGET \
  'https://acme.cloudant.com/readings/_design/infrastructure-mapping/_view/by-device?keys=["device-123456"]&limit=1'
```

Le résultat est le suivant :

```json
{"total_rows":5,"offset":0,"rows":[
{
    "id":"bridge-9876:device-123456-20181211T11:13:24.123456Z",
    "key":"device-123456",
    "value":"bridge-9876"
}
]}
```

La clé de partitionnement dans la zone `value` de la ligne incluse est donc `bridge-9876`.

#### Interrogation par requête pour tous les résultats d'un périphérique spécifique
{: #querying-for-all-results-for-a-device}

Pour obtenir les résultats pour un périphérique, vous émettez une requête de partition pour le périphérique concerné dans la partition `bridge-9876`. Un sélecteur de requête {{site.data.keyword.cloudant_short_notm}} standard est utilisé, comme si vous émettiez une requête globale.

_query.json:_

```json
{
   "selector": {
      "deviceID": {
         "$eq": "device-123456"
      }
   }
}
```

La partition est intégrée dans le chemin HTTP lors de l'émission de la demande dans {{site.data.keyword.cloudant_short_notm}} :

```
curl -XPOST \
    'https://acme.cloudant.com/readings/_partition/bridge-1234/_find' \
    -d @query.json
```

#### Interrogation par requête pour les résultats récents d'un périphérique
{: #querying-for-recent-results-for-a-device}

Pour obtenir les résultats pour un périphérique, vous émettez une requête de partition pour le périphérique concerné dans la partition `bridge-9876`. Le sélecteur est juste un peu plus complexe mais reste identique à celui d'une requête globale équivalente.

_query.json, assuming today is 13th Dec 2018:_

```json
{
   "selector": {
      "deviceID": {
         "$eq": "device-123456"
      },
      "ts": {
         "$gte": "20181213"
      }
   }
}
```

La partition est intégrée dans le chemin HTTP lors de l'émission de la demande dans {{site.data.keyword.cloudant_short_notm}} :

```
curl -XPOST \
    'https://acme.cloudant.com/readings/_partition/bridge-1234/_find' \
    -d @query.json
```
