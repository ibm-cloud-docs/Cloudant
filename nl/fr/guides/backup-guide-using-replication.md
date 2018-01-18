---

copyright:
  years: 2015, 2017
lastupdated: "2017-08-25"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-04-20 -->

<div id="back-up-your-data-using-replication"></div>

# Sauvegarde de vos données à l'aide de la réplication

>	**Remarque** : Le présent guide contient des informations anciennes, voire obsolètes, sur les sauvegardes Cloudant.
	Pour obtenir les dernières recommandations en matière de sauvegarde, consultez le guide [Reprise après incident et sauvegarde](disaster-recovery-and-backup.html).



Les sauvegardes de base de données protègent vos données contre les risques de perte ou d'altération.
{:shortdesc}

Vous pouvez utiliser la fonction de réplication Cloudant pour créer une sauvegarde de base de données,
et la stocker sur un cluster de Cloudant.
Vous pouvez ensuite restaurer des données,
des bases de données entières,
ou des documents JSON spécifiques,
à partir de ces sauvegardes vers votre cluster de production.

Lorsque vous utilisez la réplication Cloudant,
une sauvegarde de base de données stocke le contenu de votre base de données vers un point de contrôle.
Il est possible de procéder à une sauvegarde "cumulative" vers un point de contrôle spécifique.
Ce point de contrôle n'est pas lié à une heure précise.
Il s'agit en fait d'un enregistrement de la base de données telle qu'elle était après avoir subi certaines modifications pendant la période de sauvegarde.
De cette manière, une sauvegarde peut préserver l'état de votre base de données à un moment donné.

## Sauvegardes incrémentielles

Si vous êtes un client d'entreprise,
une fonction de sauvegarde incrémentielle quotidienne est [mise à votre disposition](disaster-recovery-and-backup.html).

Si vous n'êtes pas un client d'entreprise,
ou si préférez créer vos propres sauvegardes,
vous pouvez utiliser la fonction de réplication de Cloudant pour créer une sauvegarde de base de données.

Une approche simple vise à répliquer la totalité de la base de données vers une base de données horodatée.
Cette méthode est efficace et facile à utiliser.
Toutefois, si vous avez besoin de sauvegardes pour plusieurs points de cohérence,
par exemple sept sauvegardes quotidiennes et quatre sauvegardes hebdomadaires,
vous devez stocker une copie complète de la base de données dans chaque nouvelle base de données de sauvegarde.
Une copie complète peut nécessiter une utilisation intensive du disque,
en particulier si votre de base de données est volumineuse.

Comme alternative,
vous pouvez également utiliser les sauvegardes incrémentielles qui sont une bonne solution pour stocker
uniquement les documents ayant été modifiés depuis la dernière sauvegarde.

Le processus est simple.
Vous commencez par sauvegarder la totalité de la base de données.
Une fois la première sauvegarde effectuée,
vous exécutez des sauvegardes "incrémentielles" quotidiennes,
en sauvegardant _uniquement_ les éléments ayant été modifiés depuis la dernière sauvegarde.
Cette réplication est alors appelée sauvegarde quotidienne.

>   **Remarque** : Vous pouvez configurer une sauvegarde de telle sorte qu'elle se déclenche à intervalles réguliers.
    Toutefois,
    chaque intervalle doit être d'au moins 24 heures.
    En d'autres termes,
    il vous est possible d'effectuer des sauvegardes quotidiennes mais pas horaires.

## Création d'une sauvegarde incrémentielle

Les sauvegardes incrémentielles sauvegardent uniquement les différences ou "deltas" entre les sauvegardes.
Toutes les 24 heures,
la base de données source est répliquée vers une base de données cible.

La réplication utilise des valeurs de séquence pour identifier les documents ayant été modifiés au cours de la période de 24 heures.
L'opération de sauvegarde fonctionne en s'appuyant sur la réplication pour obtenir et stocker un point de contrôle.
Un point de contrôle est un autre document avec un nom interne.
Le processus de sauvegarde crée ce nom à partir d'une combinaison de la date et du nom de la tâche de sauvegarde.
Il est ainsi plus facile d'identifier les points de contrôle lors du processus de reprise ou de cumul.

Pour créer une sauvegarde incrémentielle, procédez comme suit :

1.  Recherchez l'ID du document de point de contrôle de la dernière réplication.
    Celui-ci se trouve dans la zone `_replication_id` du document de réplication,
    stocké dans la base de données `_replicator`.
2.  Ouvrez le document de point de contrôle situé sous `/$DATABASE/_local/$REPLICATION_ID`,
    où `$REPLICATION_ID` désigne l'ID que vous avez identifié à l'étape précédente,
    et `$DATABASE` indique le nom de la base de données source ou cible.
    Le document existe généralement dans les deux bases de données,
    mais il peut aussi se trouver sur une seule.
3.  Recherchez la zone `recorded_seq` associée au premier élément
    du tableau d'historique qui se trouve dans le document de point de contrôle.
4.  Procédez à la réplication vers la nouvelle base de données de sauvegarde incrémentielle,
    en définissant la zone [`since_seq` ](../api/replication.html#the-since_seq-field)
    du document de réplication sur la valeur de la zone [`recorded_seq`](backup-guide.html#get-the-recorded_seq-value)
    identifiée à l'étape précédente.

>   **Remarque** : Par définition, l'utilisation de l'option `since_seq` ignore l'option normale d'utilisation de point de contrôle. Utilisez le paramètre `since_seq` avec prudence. 

## Restauration d'une base de données

Pour restaurer une base de données à partir de sauvegardes incrémentielles,
répliquez chaque sauvegarde incrémentielle vers une nouvelle base de données,
en commençant par l'incrément le plus récent.

Vous pouvez démarrer par la sauvegarde la plus ancienne,
puis appliquer les sauvegardes suivantes dans l'ordre.
Toutefois, la réplication démarrant par la sauvegarde incrémentielle la plus récente est plus rapide, car les documents mis à jour ne sont écrits qu'une fois dans la base de données cible.
Tous les documents antérieurs à une copie présente dans la nouvelle base de données sont ignorés.


## Exemple

L'exemple ci-dessous vous montre comment :

1.  Configurer les bases de données de manière à utiliser la sauvegarde incrémentielle
2.  Exécuter une sauvegarde intégrale
3.  Configurer et exécuter une sauvegarde incrémentielle
4.  Restaurer une sauvegarde

<div id="constants-used-in-this-guide"></div>

### Constantes utilisées dans cet exemple

```sh
# save base URL and the content type in shell variables
$ url='https://$ACCOUNT:$PASSWORD@$ACCOUNT.cloudant.com'
$ ct='Content-Type: application-json'
```
{:codeblock}

Supposons que vous deviez sauvegarder une base de données.
Vous voulez créer une sauvegarde intégrale le lundi,
et une sauvegarde incrémentielle le mardi.

Vous pouvez utiliser les commandes `curl` et [`jq` ![External link icon](../images/launch-glyph.svg "External link icon")](http://stedolan.github.io/jq/){:new_window} pour exécuter ces opérations.
Dans la pratique, vous pouvez utiliser n'importe quel client HTTP.

<div id="step-1-check-you-have-three-databases"></div>

### Etape 1 : Vérification de l'existence de trois bases de données

Pour cet exemple,
vous avez besoin de trois bases de données :

-   La base de données d'origine,
    qui contient les données à sauvegarder.
-   Deux bases de données incrémentielles,
    une pour le lundi (`backup-monday`) et l'autre pour le mardi (`backup-tuesday`).

_Exemple illustrant comment vérifier que vous disposez des trois bases de données pour cet exemple, à l'aide du protocole HTTP :_

```http
PUT /original HTTP/1.1
PUT /backup-monday HTTP/1.1
PUT /backup-tuesday HTTP/1.1
```
{:codeblock}

_Exemple illustrant comment vérifier que vous disposez de trois bases de données pour cet exemple, à l'aide de la ligne de commande :_

```sh
$ curl -X PUT "${url}/original"
$ curl -X PUT "${url}/backup-monday"
$ curl -X PUT "${url}/backup-tuesday"
```
{:codeblock}

### Etape 2 : Création de la base de données `_replicator`

Créez la base de données `_replicator` si besoin.

_Création de la base de données `_replicator` à l'aide du protocole HTTP :_

```http
PUT /_replicator HTTP/1.1
```
{:codeblock}

_Création de la base de données `_replicator` à l'aide de la ligne de commande :_

```sh
curl -X PUT "${url}/_replicator"
```
{:pre}

### Etape 3 : Sauvegarde de la totalité de la base de données (d'origine)

Le lundi,
vous voulez sauvegarder l'ensemble de vos données pour la première fois.
Créez cette sauvegarde en répliquant tous les éléments depuis la base de données `original` vers la base de données `backup-monday`.

_Exécution d'une sauvegarde intégrale le lundi à l'aide du protocole HTTP :_

```http
PUT /_replicator/full-backup-monday HTTP/1.1
Content-Type: application/json
```
{:codeblock}

_Exécution d'une sauvegarde intégrale le lundi à l'aide de la ligne de commande :_

```sh
$ curl -X PUT "${url}/_replicator/full-backup-monday" -H "$ct" -d @backup-monday.json
# where backup-monday.json describes the backup.
```
{:codeblock}

_Document JSON décrivant la sauvegarde intégrale :_
 
```json
{
    "_id": "full-backup-monday",
    "source": "${url}/original",
    "target": "${url}/backup-monday"
}
```
{:codeblock}

<div id="step-4-get-checkpoint-id"></div>

### Etape 4 : Préparation de la sauvegarde incrémentielle - Partie 1 : Obtention de l'ID de point de contrôle

Le mardi,
vous voulez effectuer une sauvegarde incrémentielle,
et non une sauvegarde intégrale.

Pour démarrer la sauvegarde incrémentielle,
vous avez besoin de deux valeurs :

-   L'ID de point de contrôle.
-   [La valeur `recorded_seq`](#step-5-prepare-incremental-backup-part-2-get-recorded_seq-value).

Ces valeurs identifient l'endroit où s'est terminée la dernière sauvegarde,
et détermine où commencer la prochaine sauvegarde incrémentielle.
Une fois que vous disposez de ces valeurs, vous pouvez exécuter la sauvegarde incrémentielle.

Commencez par identifier la valeur d'ID de point de contrôle.
Cette valeur se trouve dans la zone `_replication_id` du document de réplication,
dans la base de données `_replicator`.

_Obtention de l'ID de point de contrôle permettant de trouver la valeur `recorded_seq`, à l'aide du protocole HTTP :_

```http
GET /_replicator/full-backup-monday HTTP/1.1
# Search for the value of _replication_id
```
{:codeblock}

_Obtention de l'ID de point de contrôle permettant de trouver la valeur `recorded_seq`, à l'aide de la ligne de commande :_

```sh
replication_id=$(curl "${url}/_replicator/full-backup-monday" | jq -r '._replication_id')
```
{:pre}

<div id="step-5-get-recorded_seq-value"></div>

### Etape 5 : Préparation de la sauvegarde incrémentielle - Partie 2 : Obtention de la valeur `recorded_seq`

Une fois l'ID de point de contrôle récupéré,
utilisez-le pour obtenir la valeur `recorded_seq`.
Cette valeur se trouve dans le premier élément du tableau d'historique dans le document `/_local/${replication_id}` de la base de données d'origine.

Vous connaissez désormais la valeur `recorded_seq`.
Celle-ci identifie le dernier document ayant été répliqué depuis la base de données d'origine.

_Obtention de la valeur `recorded_seq` à partir de la base de données d'origine, à l'aide du protocole HTTP :_

```http
GET /original/_local/${replication_id} HTTP/1.1
# Search for the first value of recorded_seq in the history array
```
{:codeblock}

_Obtention de la valeur `recorded_seq` à partir de la base de données d'origine, à l'aide de la ligne de commande :_

```sh
recorded_seq=$(curl "${url}/original/_local/${replication_id}" | jq -r '.history[0].recorded_seq')
```
{:pre}

### Etape 6 : Exécution d'une sauvegarde incrémentielle

Maintenant que vous connaissez l'ID de point de contrôle et la valeur `recorded_seq`,
vous pouvez démarrer la sauvegarde incrémentielle du mardi.
Cette opération réplique toutes les modifications ayant été apportées _depuis_ la dernière réplication.

Une fois la réplication terminée,
vous disposez de votre sauvegarde incrémentielle.
La sauvegarde comporte tous les documents de la base de données d'origine,
et peut être restaurée en extrayant le contenu des deux bases de données `backup-monday` _et_ `backup-tuesday`.

_Exécution de la sauvegarde incrémentielle du mardi à l'aide du protocole HTTP :_

```http
PUT /_replicator/incr-backup-tuesday HTTP/1.1
Content-Type: application/json
```
{:codeblock}

_Exécution de la sauvegarde incrémentielle du mardi à l'aide de la ligne de commande :_

```sh
curl -X PUT "${url}/_replicator/incr-backup-tuesday" -H "${ct}" -d @backup-tuesday.json
```
{:pre}

_Document JSON décrivant la sauvegarde incrémentielle du mardi :_
 
```json
{
    "_id": "incr-backup-tuesday",
    "source": "${url}/original",
    "target": "${url}/backup-tuesday",
    "since_seq": "${recorded_seq}"
}
```
{:codeblock}

### Etape 7 : Restauration de la sauvegarde du lundi

Pour procéder à la restauration depuis une sauvegarde, vous répliquez la sauvegarde intégrale initiale, ainsi que les sauvegardes incrémentielles, vers une nouvelle base de données.

Par exemple, pour restaurer l'état du lundi,
vous devez procéder à une réplication depuis la base de données `backup-monday`.

_Restauration à partir de la base de données `backup-monday` à l'aide du protocole HTTP :_

```sh
PUT /_replicator/restore-monday HTTP/1.1
Content-Type: application/json
```
{:codeblock}

_Restauration de la base de données `backup-monday` à l'aide de la ligne de commande :_

```sh
curl -X PUT "${url}/_replicator/restore-monday" -H "$ct" -d @restore-monday.json
```
{:pre}

_Document JSON décrivant la restauration :_
 
```json
{
    "_id": "restore-monday",
    "source": "${url}/backup-monday",
    "target": "${url}/restore",
    "create-target": true  
}
```
{:codeblock}

### Etape 8 : Restauration de la sauvegarde du mardi

Pour restaurer la base de données du mardi,
procédez d'abord à la réplication à partir de la base de données `backup-tuesday`, puis à partir de la base de données `backup-monday`.

>   **Remarque** : L'ordre donné est le bon ;
    il s'agit _bien_ de restaurer à partir du mardi et _ensuite_ à partir du lundi.

Vous pouvez effectuer une restauration dans l'ordre chronologique,
mais en utilisant une séquence inverse,
les documents ayant été mis à jour le mardi n'ont besoin d'être écrits qu'une seule fois dans la base de données cible.
Les versions plus anciennes du document stockées dans la base de données du lundi sont ignorées.

_Restauration de la sauvegarde du mardi, avec obtention des changements les plus récents en premier, à l'aide du protocole HTTP :_

```http
PUT /_replicator/restore-tuesday HTTP/1.1
Content-Type: application/json
```
{:codeblock}

_Restauration de la sauvegarde du mardi, avec obtention des changements les plus récents en premier, à l'aide de la ligne de commande :_

```sh
curl -X PUT "${url}/_replicator/restore-tuesday" -H "$ct" -d @restore-tuesday.json
```
{:pre}

_Document JSON demandant une restauration de la sauvegarde du mardi :_
 
```json
{
    "_id": "restore-tuesday",
    "source": "${url}/backup-tuesday",
    "target": "${url}/restore",
    "create-target": true  
}
```
{:codeblock}

_Fin de la reprise avec la restauration de la dernière sauvegarde du lundi, à l'aide du protocole HTTP :_

```http
PUT /_replicator/restore-monday HTTP/1.1
Content-Type: application/json
```
{:codeblock}

_Fin de la reprise avec la restauration de la dernière sauvegarde du lundi à l'aide de la ligne de commande :_

```http
curl -X PUT "${url}/_replicator/restore-monday" -H "$ct" -d @restore-monday.json
```
{:pre}

_Document JSON demandant une restauration de la sauvegarde du lundi :_
 
```json
{
    "_id": "restore-monday",
    "source": "${url}/backup-monday",
    "target": "${url}/restore"
}
```
{:codeblock}

## Suggestions

Bien que les informations précédentes évoquent l'aspect général du processus de sauvegarde,
chaque application a ses propres exigences et stratégies de sauvegarde.
Les suggestions ci-après peuvent vous être utiles.

### Planification des sauvegardes

Les travaux de réplication peuvent augmenter de manière significative la charge d'un cluster.
Si vous sauvegardez plusieurs bases de données,
il est préférable d'échelonner les travaux de réplication,
ou de choisir un moment où le cluster est moins occupé.

#### Modification de la priorité IO d'une sauvegarde

Vous pouvez changer la priorité des tâches de sauvegarde en ajustant la valeur de la zone `x-cloudant-io-priority` dans le document de réplication.

1.  Dans les zones source et cible, changez l'objet `headers`.
2.  Dans l'objet des en-têtes, remplacez la valeur de la zone `x-cloudant-io-priority` par `"low"`.

_Exemple de document JSON définissant la priorité IO :_

```json
{
    "source": {
        "url": "https://user:pass@example.com/db",
        "headers": {
            "x-cloudant-io-priority": "low"
        }
    },
    "target": {
        "url": "https://user:pass@example.net/db",
        "headers": {
            "x-cloudant-io-priority": "low"
        }
    }
}
```
{:codeblock}

<div id="design-documents"></div>

### Sauvegarde de documents de conception

Si vous intégrez des documents de conception dans votre sauvegarde,
les index sont créés sur la destination de sauvegarde.
Cette opération ralentit le processus de sauvegarde et utilise des quantités inutiles d'espace disque.
Si vous n'avez pas besoin des index sur votre système de sauvegarde,
utilisez la fonction de filtre de vos réplications pour ignorer les documents de conception.
Vous pouvez également utiliser cette fonction de filtre pour exclure d'autres documents indésirables.

### Sauvegarde de plusieurs bases de données

Si votre application utilise une base de données par utilisateur,
ou autorise chaque utilisateur à créer plusieurs bases de données,
vous devez créer une tâche de sauvegarde pour chaque nouvelle base de données.
Assurez-vous que les travaux de réplication ne commencent pas en même temps.

## Besoin d'aide ? 

Les opérations de réplication et de sauvegarde peuvent s'avérer complexes.
Si vous n'y arrivez pas,
consultez le [guide de réplication](replication_guide.html) ou contactez l'[équipe de support d'IBM Cloudant![External link icon](../images/launch-glyph.svg "External link icon")](mailto:support@cloudant.com){:new_window}.
