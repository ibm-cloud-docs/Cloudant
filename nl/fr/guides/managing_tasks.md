---

copyright:
  years: 2015, 2019
lastupdated: "2019-03-18"

keywords: curl and jq basics, monitor view builds and search indexes, estimate time to complete task, monitor replication, troubleshooting

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

# Gestion des tâches
{: #managing-tasks}

La création de nouveaux index pour un nombre important de données ainsi que la réplication d'une base de données peuvent être des opérations longues.
{: shortdesc}

Comment pouvez-vous donc déterminer si vos tâches sont en cours
ou si elles sont terminées ?
Le noeud final [`_active_tasks`](/docs/services/Cloudant?topic=cloudant-active-tasks#active-tasks) fournit des informations sur toutes les tâches en cours.
Toutefois,
si vous démarrez un grand nombre de tâches,
certaines d'entre elles peuvent être planifiées pour s'exécuter ultérieurement et ne s'affichent pas sous `_active_tasks`
tant qu'elles n'ont pas été démarrées.

Ce guide décrit comment utiliser le noeud final `_active_tasks` pour surveiller les tâches à exécution longue.
La commande `curl` permet d'accéder au noeud final.
Le processeur JSON de ligne de commande `jq` permet de traiter la réponse JSON.

Etant donné que ce document est un tutoriel concernant les tâches,
il présente uniquement la procédure de base pour leur réalisation.
Pour plus d'informations, voir la rubrique [Référence d'API](/docs/services/Cloudant?topic=cloudant-api-reference-overview#api-reference-overview) pour accéder à un guide complet des options disponibles.

## curl et jq - Informations générales
{: #curl-and-jq-basics}

Pour obtenir toutes les tâches actives et formater correctement la sortie,
appelez votre compte en utilisant `curl` puis
dirigez la sortie vers `jq`.

`jq` vous permet de filtrer une liste de documents en fonctions des valeurs des zones.
Ainsi, il est plus facile d'obtenir tous les documents de réplication,
ou les détails d'une seule tâche d'indexation de vue spécifique.
La rubrique Référence d'API inclut des informations supplémentaires sur les options.

_Obtention et formatage d'une liste de tâches actives - Exemple :_

```sh
curl 'https://username:password@username.cloudant.com/_active_tasks' | jq '.'
```
{: codeblock}

## Surveillance des index de vue et des index de recherche
{: #monitoring-view-builds-and-search-indexes}

Les index de vue sont régénérés à chaque mise à jour d'un document de conception.
Dès qu'une de ces vues est mise à jour, toutes les vues du document sont régénérées.

Les index de recherche sont régénérés uniquement lors de la modification de leur fonction d'index correspondante.
Dès qu'un index de recherche est régénéré et qu'une modification est apportée à un document de conception incluant des vues,
une nouvelle tâche est créée pour chaque réplique de chaque fragment d'un cluster.

Par exemple,
s'il existe 24 fragments,
incluant chacun trois répliques,
et que vous mettez à jour deux index de recherche,
alors 24 x 3 x 2 = 144 tâches sont exécutées.

Pour trouver toutes les tâches d'indexation de vue,
dirigez la sortie `curl` vers `jq`,
et laissez ce dernier filtrer les documents dans le tableau en fonction de leur zone de type.
Il existe une commande correspondante pour les tâches d'indexation de recherche.

Dans tous les cas,
la recherche d'une liste de tâches d'indexation génère une liste d'objets JSON :
une pour chacune des tâches actives trouvées.

_Recherche de toutes les tâches d'indexation de vue en filtrant en fonction du type `indexer` - Exemple :_

```sh
curl -s 'https://username:password@username.cloudant.com/_active_tasks' | jq '.[] | select(.type=="indexer")'
```
{: codeblock}

_Recherche de toutes les tâches d'indexation de recherche en filtrant en fonction du type `search_indexer` - Exemple :_

```sh
curl -s 'https://username:password@username.cloudant.com/_active_tasks' | jq '.[] | select(.type=="search_indexer")'
```
{: codeblock}

_Résultat suite à la recherche de tâches d'indexation de vue - Exemple :_

```json
{
    "total_changes": 6435,
    "started_on": 1371118332,
    "user": "username",
    "updated_on": 1371118334,
    "type": "indexer",
    "node": "dbcore@db6.meritage.cloudant.net",
    "pid": "<0.16366.6103>",
    "changes_done": 364,
    "database": "shards/40000000-7fffffff/username/database",
    "design_document": "_design/ngrams"
}
```
{: codeblock}

## Estimation de la durée d'exécution d'une tâche
{: #estimating-the-time-to-complete-a-task}

Pour estimer la durée d'exécution de la tâche d'indexation,
surveillez le nombre d'éléments `changes_done` et comparez cette valeur à `total_changes`.
Par exemple,
si `changes_done` est incrémenté de 250 par seconde
et que `total_changes` a la valeur 1 000 000,
il est attendu que l'exécution dure 1 000 000 / 250 = 4 000 secondes,
soit environ 66 minutes.

Les estimations de la durée de l'exécution d'une tâche d'indexation ne sont pas précises à 100 %. La durée d'exécution réelle de la tâche dépend des facteurs suivants :

-   Durée de traitement de chaque document.
    Par exemple,
    Une vue peut tout d'abord vérifier le type d'un document,
    et émettre uniquement de nouvelles entrées d'index pour un type.
-   Taille des documents.
-   Charge de travail sur le cluster.

Gardez à l'esprit que tous ces facteurs peuvent être associés et réduire de manière importante la précision de votre estimation.

_Extraction de la zone `changes_done` à l'aide de `jq` - Exemple :_

```sh
curl ... | jq '.[] | select(.type=="search_indexer") | .changes_done'
```
{: codeblock}

## Surveillance de la réplication
{: #monitoring-replication}

Pour trouver toutes les tâches de réplication,
dirigez la sortie `curl` vers `jq`,
et filtrez les documents dans le tableau en fonction de leur zone de type.

Pour faciliter la sélection des informations concernant un processus de réplication dans la liste des tâches actives,
démarrez le processus de réplication en créant un document dans la base de données `_replicator` et
attribuez une valeur connue à sa zone `_id`.

_Recherche de toutes les tâches dédiées, en filtrant par type de `réplication` - Exemple :_

```sh
curl -s 'https://username:password@username.cloudant.com/_active_tasks' | jq '.[] | select(.type=="replication")'
```
{: codeblock}

_Recherche d'une tâche de réplication spécifique, en filtrant par identité de document connue - Exemple :_

```sh
curl ... | jq '.[] | select(.doc_id=="ID")'
```
{: codeblock}

_Recherche d'une tâche de réplication spécifique, en filtrant par élément `replication_id` connu - Exemple :_

```sh
curl ... | jq '.[] | select(.replication_id=="ID")'
```
{: codeblock}

_Résultat après la recherche d'une tâche de réplication - Exemple :_

```json
{
    "started_on": 1371094220,
    "source_seq": "62960-sakdjflksdfjsdlkafjalskdfjlsakfjlasdkjksald",
    "source": "",
    "revisions_checked": 12,
    "continuous": true,
    "doc_id": null,
    "doc_write_failures": 0,
    "docs_read": 12,
    "target": "",
    "type": "replication",
    "updated_on": 1371118477,
    "user": "username",
    "checkpointed_source_seq": "61764-dskfjalsfjsalkfjssadjfhasdfkjhsdkfhsdkf",
    "changes_pending": 1196,
    "pid": "<0.9955.4120>",
    "node": "dbcore@db7.meritage.cloudant.net",
    "docs_written": 12,
    "missing_revisions_found": 12,
    "replication_id": "asfksdlfkjsadkfjsdalkfjas+continuous+create_target"
}
```
{: codeblock}

## Traitement des incidents générés par des tâches bloquées
{: #troubleshooting-stuck-tasks}

### Une tâche est-elle bloquée ?
{: #is-a-task-stuck-}

Pour une réplication ponctuelle,
non continue,
dans laquelle la base de données source n'est pas mise à jour de manière significative lors de la réplication,
la valeur `changes_pending` indique le nombre de documents restant à traiter.
Ainsi, la valeur `changes_pending` constitue un bon indicateur de la fin possible de la réplication.

Dans le cadre d'une réplication continue,
il est important de savoir comment le nombre de documents traités évolue au cours du temps
et de déterminer si la valeur `changes_pending` augmente.
Si c'est le cas``,
mais que la valeur `revisions_checked` reste constante pendant un moment,
il est possible que la réplication soit bloquée.
L'augmentation des valeurs `changes_pending` et
`revisions_checked` peut
indiquer que la réplication ne parvient pas à gérer l'ajout ou la
mise à jour de données dans la
base de données.

### Que faire lorsqu'une tâche est bloquée ?
{: #what-to-do-about-a-stuck-task-}

Pour résoudre une réplication bloquée,
il peut être nécessaire d'[annuler le processus de réplication](/docs/services/Cloudant?topic=cloudant-replication-api#canceling-a-replication) puis de le démarrer à nouveau.

Si le problème persiste,
cette situation peut être due au fait que l'utilisateur accédant aux bases de données source ou cible
ne dispose pas des droits d'écriture.

La réplication utilise des [points de contrôle](/docs/services/Cloudant?topic=cloudant-replication-guide#checkpoints), ce qui signifie qu'il n'est pas nécessaire de répliquer à nouveau le contenu déjà répliqué et non modifié si la réplication est redémarrée.
{: note}

Si vous avez créé le processus de réplication en générant un document dans la base de données `_replicator`,
vous pouvez également vérifier ici le statut de la réplication.
