---

copyright:
  years: 2015, 2017
lastupdated: "2017-01-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

# Gestion des versions de document et MVCC

La méthode [Multi-version concurrency control (MVCC) ![External link icon](../images/launch-glyph.svg "External link icon")](https://en.wikipedia.org/wiki/Multiversion_concurrency_control){:new_window}
est utilisée par les bases de données Cloudant pour s'assurer que les tous les noeuds d'un cluster de base de données contiennent
uniquement la [version la plus récente](../api/document.html) d'un document.
{:shortdesc}

Etant donné que les bases de données Cloudant sont [finalement cohérentes](cap_theorem.html), il est
nécessaire d'éviter les incohérences survenant entre les noeuds, suite à une synchronisation avec des documents
obsolètes.

MVCC (Multi-Version Concurrency Control), forme de [contrôle optimiste des accès concurrents ![External link icon](../images/launch-glyph.svg "External link icon")](http://en.wikipedia.org/wiki/Optimistic_concurrency_control){:new_window},
permet un accès simultané en lecture et écriture à une base de données Cloudant.
De plus, MVCC permet également des opérations de lecture et d'écriture plus rapides sur les bases de données Cloudant car aucun verrouillage de base de données n'est
requis pour les opérations de lecture ou d'écriture.
Cette méthode active également la synchronisation entre les noeuds de base de données Cloudant.

## Révisions

Chaque document d'une base de données a une zone `_rev` indiquant son numéro de révision.

Un numéro de révision est ajouté à vos documents par le serveur lorsque vous les insérez ou les modifiez.
Ce numéro est inclus dans la réponse du serveur lorsque vous modifiez ou lisez un document.
La valeur `_rev` est construite en utilisant une association d'un compteur unique et d'un hachage du document.

Principales utilisations du numéro de révision :

1.  Déterminer quels documents doivent être répliqués entre des serveurs.
2.  Confirmer qu'un client tente de modifier la dernière version d'un document.

Vous devez spécifier l'élément `_rev` précédent lors de la [mise à jour d'un document](../api/document.html#update).
Sinon, votre demande échoue et renvoie une [erreur 409](../api/http.html#409).

>   **Remarque** : `_rev` ne doit pas être utilisé pour générer un système de contrôle de version.
    En effet, cet élément est une valeur interne utilisée par le serveur.
    De plus, les anciennes versions d'un document sont provisoires,
    et sont donc supprimées régulièrement.

Vous pouvez demander une révision spécifique en utilisant sa valeur `_rev`.
Cependant,
les anciennes versions sont régulièrement supprimées par un processus appelé
[compression ![External link icon](../images/launch-glyph.svg "External link icon")](http://en.wikipedia.org/wiki/Data_compaction){:new_window}.
La compression fait que vous ne pouvez pas vous fier à une réponse lors de la demande
d'une révision de document spécifique à l'aide de l'élément `_rev` afin d'obtenir un historique des révisions de votre document.
Si vous avez besoin d'un tel historique,
vous pouvez [créer un nouveau document](../api/document.html#documentCreate) pour chaque révision.

## Bases de données réparties et conflits

Les bases de données réparties fonctionnent avec une connexion constante à la base de données principale sur Cloudant,
elle-même répartie.
Ainsi, les mises à jour s'appuyant sur la même version précédente peuvent être toujours en conflit.

Pour trouver les conflits,
ajoutez le paramètre de requête [`conflicts=true`](../api/database.html#get-changes) lors de l'extraction d'un document.
La réponse contient un tableau `_conflicts` avec toutes les révisions en conflit.

Pour trouver des conflits pour plusieurs documents d'une base de données,
créez une vue.

La fonction de mappe suivante constitue un exemple qui émet toutes les révisions en conflit pour chaque document présentant un conflit.

_Fonction de mappe permettant de trouver les documents présentant un conflit - Exemple :_

```javascript
function (doc) {
    if (doc._conflicts) {
        emit(null, [doc._rev].concat(doc._conflicts));
    }
}
```
{:codeblock}

Vous pouvez régulièrement interroger cette vue et résoudre les conflits selon les besoins,
ou interroger la vue après chaque réplication.

## Résolution des conflits

Une fois que vous avez trouvé un conflit,
vous pouvez le résoudre en quatre étapes.

1.  [Obtenir](#get-conflicting-revisions) les révisions en conflit.
2.  [Fusionner](#merge-the-changes) ces révisions dans votre application ou demander à l'utilisateur ce qu'il souhaite faire.
3.  [Télécharger](#upload-the-new-revision) la nouvelle révision.
4.  [Supprimer](#delete-old-revisions) les anciennes révisions.

Un exemple présentant cette procédure est présenté ci-dessus.
Supposons que vous ayez une base de données de produits pour un magasin en ligne.
La première version d'un document peut être similaire à l'exemple suivant :

```json
{
    "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "1-7438df87b632b312c53a08361a7c3299",
    "name": "Samsung Galaxy S4",
    "description": "",
    "price": 650
}
```
{:codeblock}

Comme le document n'a pas encore de description,
quelqu'un peut en ajouter une :

_Deuxième version du document, créée par l'ajout d'une description :_

```json
{
    "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "2-61ae00e029d4f5edd2981841243ded13",
    "name": "Samsung Galaxy S4",
    "description": "Latest smartphone from Samsung",
    "price": 650
}
```
{:codeblock}

Au même moment, une autre personne utilisant une base de données répliquée, réduit le prix :

_Autre révision en conflit avec la précédente en raison d'une valeur `price` différente :_

```json
{
    "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "2-f796915a291b37254f6df8f6f3389121",
    "name": "Samsung Galaxy S4",
    "description": "",
    "price": 600
}
```
{:codeblock}

Les deux bases de données sont ensuite répliquées.
La différence entre les versions de document génère un conflit.

### Obtention des révisions en conflit

Pour identifier les documents incluant des conflits, utilisez l'option `conflicts=true`.

_Recherche de documents incluant des conflits - Exemple :_

```http
http://$ACCOUNT.cloudant.com/products/$_ID?conflicts=true
```
{:codeblock}

_Réponse présentant les révisions en conflit ayant des conséquences sur les documents - Exemple :_

```json
{
    "_id":"74b2be56045bed0c8c9d24b939000dbe",
    "_rev":"2-f796915a291b37254f6df8f6f3389121",
    "name":"Samsung Galaxy S4",
    "description":"",
    "price":600,
    "_conflicts":["2-61ae00e029d4f5edd2981841243ded13"]
}
```
{:codeblock}

La version avec le prix modifié a été choisie arbitrairement comme dernière version du document
et le conflit avec une autre version est noté en indiquant l'ID de cette dernière dans le tableau `_conflicts`.
Dans la plupart des cas, ce tableau n'inclut qu'un seul élément,
mais il peut exister un grand nombre de révisions en conflit.

### Fusion des modifications

Pour comparer les révisions afin de voir les modifications,
votre application obtient toutes les versions de la base de données.

_Commandes permettant d'extraire toutes les versions d'un document de la base de données - Exemple :_

```http
http://$ACCOUNT.cloudant.com/products/$_ID
http://$ACCOUNT.cloudant.com/products/$_ID?rev=2-61ae00e029d4f5edd2981841243ded13
http://$ACCOUNT.cloudant.com/products/$_ID?rev=1-7438df87b632b312c53a08361a7c3299
```
{:codeblock}

Etant donné que les modifications en conflit concernent différentes zones du document,
il est facile de les fusionner.

Pour les conflits plus complexes,
d'autres stratégies de résolution peuvent être requises :

*   Stratégie temporelle : Utilisez la première ou la dernière édition
*   Intervention de l'utilisateur : Signalez les conflits aux utilisateurs et laissez-les choisir la meilleure solution.
*   Algorithmes complexes : Par exemple, fusion triple de zones de texte.

Pour obtenir un exemple pratique du mode d'implémentation d'une fusion des modifications,
voir la page présentant un [projet avec un code exemple ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/glynnbird/deconflict){:new_window}.

### Téléchargement de la nouvelle révision

L'étape suivante consiste à créer un document qui résout les conflits,
et met la base de données à jour en fonction.

_Document fusionnant des modifications à partir des deux révisions en conflit - Exemple :_

```json
{
    "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "3-daaecd7213301a1ad5493186d6916755",
    "name": "Samsung Galaxy S4",
    "description": "Latest smartphone from Samsung",
    "price": 600
}
```
{:codeblock}

### Suppression des anciennes révisions

Pour finir,
vous supprimez les anciennes révisions en envoyant une demande `DELETE` aux URL avec la révision à supprimer.

_Demande de suppression d'une ancienne révision de document, en utilisant HTTP - Exemple :_

```http
DELETE https://$ACCOUNT.cloudant.com/products/$_ID?rev=2-61ae00e029d4f5edd2981841243ded13
```
{:codeblock}

_Demande de suppression d'une ancienne révision de document, en utilisant la ligne de commande - Exemple :_

```sh
curl "https://$ACCOUNT.cloudant.com/products/$_ID?rev=2-f796915a291b37254f6df8f6f3389121" -X DELETE
```
{:codeblock}

A ce stade,
les conflits affectant le document sont résolus.
Pour le vérifier, il vous suffit d'obtenir (`GET`) à nouveau le document en indiquant la valeur `true` pour le paramètre `conflicts`.
