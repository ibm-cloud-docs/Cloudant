---

copyright:
  years: 2015, 2019
lastupdated: "2019-06-12"

keywords: find conflicts, resolve conflicts, merge changes, upload new revision, delete revision

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

<!-- Acrolinx: 2018-05-07 -->

# Conflits
{: #conflicts}

Dans les bases de données réparties où les copies de données peuvent être stockées dans plusieurs emplacements, les caractéristiques naturelles du réseau et du système peuvent signifier que les modifications apportées à un document stocké à un emplacement ne peuvent pas être mises à jour ou répliquées instantanément.

En d'autres termes, si des mises à jour indépendantes sont effectuées sur différentes copies de documents, cela peut avoir pour effet d'introduire des désaccords ou des 'conflits' quant au contenu correct et définitif du document.

{{site.data.keyword.cloudantfull}} tente de vous aider à éviter les conflits en vous avertissant des problèmes potentiels.
Il vous avertit en renvoyant une réponse [`409`](/docs/services/Cloudant?topic=cloudant-http#http-status-codes) à une demande de mise à jour problématique.
Toutefois, une réponse `409` peut ne pas être reçue si la mise à jour de la base de données est demandée sur un système qui n'est pas actuellement connecté au réseau.
Par exemple, la base de données peut se trouver sur un appareil mobile temporairement déconnecté d'Internet. Il est donc impossible à ce moment-là de vérifier si d'autres mises à jour potentiellement conflictuelles ont été effectuées.

Si vous demandez un document en situation de conflit, la base de données {{site.data.keyword.cloudant_short_notm}} renvoie le document comme prévu.
Cependant, la version renvoyée est déterminée par un algorithme interne qui prend en compte un certain nombre de facteurs ; vous ne devez pas supposer que le document renvoyé est toujours la version la plus récente, par exemple.

Si vous ne vérifiez pas les conflits ou si vous ne parvenez pas à les résoudre, votre base de données {{site.data.keyword.cloudant_short_notm}} commence à afficher plusieurs comportements:

* Augmentation des incohérences dans le contenu des documents, car de plus en plus de documents sont contradictoires.
* Augmentation de la taille de la base de données, car tous les documents en conflit doivent être conservés jusqu'à la résolution du conflit.
* Diminution des performances, car {{site.data.keyword.cloudant_short_notm}} doit intensifier son activité en réponse à chaque demande, car elle tente d'identifier la 'meilleure version' possible d'un document en conflit.

Les pratiques suggérées suivantes peuvent vous aider à déterminer quand rechercher et résoudre les conflits :

<table>
<tr>
<th>Caractéristique d'application</th>
<th>Fréquence de la mise à jour du document</th>
<th>Rechercher les conflits lors de l'extraction ?</th>
<th>Rechercher les conflits lors de la mise à jour ?</th>
</tr>
<tr>
<td>Toujours connecté à Internet, par exemple un serveur.</td>
<td>Souvent</td>
<td>O</td>
<td>-</td>
</tr>
<tr>
<td>Toujours connecté à Internet.</td>
<td>Parfois</td>
<td>-</td>
<td>O</td>
</tr>
<tr>
<td>Souvent mais pas toujours connecté à Internet, par exemple un ordinateur portable.</td>
<td>Souvent</td>
<td>-</td>
<td>O</td>
</tr>
<tr>
<td>Souvent mais pas toujours connecté à Internet.</td>
<td>Parfois</td>
<td>-</td>
<td>O</td>
</tr>
<tr>
<td>Occasionnellement connecté à Internet, par exemple une tablette.</td>
<td>Souvent</td>
<td>-</td>
<td>O</td>
</tr>
</table>

## Rechercher les conflits
{: #finding-conflicts}

Pour rechercher les conflits susceptibles d'affecter un document, ajoutez le paramètre de requête `conflicts=true` lors de l'extraction d'un document.
Lorsqu'il est renvoyé, le document obtenu contient un tableau `_conflicts`, qui inclut une liste de toutes les révisions en conflit.

> Exemple de fonction de mappe pour rechercher des conflits dans des documents :

```
function (doc) {
  if (doc._conflicts) {
    emit(null, [doc._rev].concat(doc._conflicts));
    }
}
```

Pour trouver des conflits pour plusieurs documents d'une base de données,
créez une [vue](/docs/services/Cloudant?topic=cloudant-views-mapreduce#views-mapreduce).
A l'aide d'une fonction de mappe telle que l'exemple fourni, vous pouvez rechercher toutes les révisions de chaque document comportant un conflit.

Lorsque vous disposez d'une vue de ce type, vous pouvez l'utiliser pour rechercher et résoudre les conflits si nécessaire.
Vous pouvez également interroger la vue après chaque réplication pour identifier et résoudre les conflits immédiatement.

## Résolution des conflits
{: #how-to-resolve-conflicts}

Une fois que vous avez trouvé un conflit, vous pouvez le résoudre en quatre étapes :

1.	[Obtenir](#get-conflicting-revisions) les révisions en conflit.
2.	[Fusionner](#merge-the-changes) ces révisions dans votre application ou demander à l'utilisateur ce qu'il souhaite faire.
3.	[Télécharger](#upload-the-new-revision) la nouvelle révision.
4.	[Supprimer](#delete-old-revisions) les anciennes révisions.

> Exemple de document - la première version.

```json
{
  "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "1-7438df87b632b312c53a08361a7c3299",
    "name": "Samsung Galaxy S4",
    "description": "",
    "price": 650
}
```

Un exemple présentant cette procédure est présenté ci-dessus.
Supposons que vous ayez une base de données de produits pour un magasin en ligne.
La première version d'un document peut être similaire à l'exemple fourni.

> Deuxième version (première révision) du document, par l'ajout d'une description.

```json
{
  "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "2-61ae00e029d4f5edd2981841243ded13",
    "name": "Samsung Galaxy S4",
    "description": "Latest smartphone from Samsung",
    "price": 650
}
```

Le document n'a pas encore de description, donc quelqu'un pourrait en ajouter une.

> Deuxième version _alternative_, introduisant un changement de données de réduction de prix à la première version du document.

```json
{
  "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "2-f796915a291b37254f6df8f6f3389121",
    "name": "Samsung Galaxy S4",
    "description": "",
    "price": 600
}
```

Au même moment, une autre personne utilisant une base de données répliquée réduit le prix.
Cette modification est apportée à la première version du document.
Par conséquent, la modification de réduction de prix ne 'connaît' pas la modification de la description.

Ultérieurement, lorsque les deux bases de données sont répliquées, il peut être difficile de savoir laquelle des deux versions alternatives du document est correcte.
Il s'agit d'un scénario de conflit.

## Obtention des révisions en conflit
{: #get-conflicting-revisions}

Pour rechercher les révisions conflictuelles d'un document, extrayez ce document normalement, mais incluez le paramètre `conflicts=true`, comme dans l'exemple suivant :

`http://ACCOUNT.cloudant.com/products/$_ID?conflicts=true`


> Exemple de réponse à l'extraction d'un document, montrant des révisions conflictuelles

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

Si le document comporte des conflits, vous obtenez une réponse similaire à l'exemple fourni, qui est basé sur la description modifiée ou le problème de prix modifié.

La version dont le prix a été modifié a été choisie _arbitrairement_ comme la dernière version du document.
Vous ne devez pas supposer que la version la plus récente du document est considérée comme la dernière version à des fins de résolution de conflit.

Dans cet exemple, un conflit est considéré comme existant entre le document récupéré qui a la valeur `_rev` `2-f796915a291b37254f6df8f6f3389121`, et un autre document qui a la valeur `_rev` `2-61ae00e029d4f5edd2981841243ded13`.
Les détails du document en conflit sont notés dans le tableau `_conflicts`.

Souvent, vous pouvez constater que le tableau ne contient qu'un seul élément, mais il est possible qu'il y ait de nombreuses révisions conflictuelles, chacune d'entre elles étant répertoriée dans le tableau.

## Fusion des modifications
{: #merge-the-changes}

Votre application doit identifier toutes les modifications potentielles et les réconcilier, en fusionnant efficacement les mises à jour correctes et valides pour produire une version unique et non conflictuelle du document.

Pour comparer les révisions afin d'identifier les modifications,
votre application doit extraire toutes les versions de la base de données.
Comme décrit précédemment, vous devez commencer par récupérer un document et les détails de toutes les versions en conflit.
Pour ce faire, vous devez utiliser une commande similaire à la suivante, qui demande également le tableau `_conflicts` :

`http://$ACCOUNT.cloudant.com/products/$_ID?conflicts=true
`

Cette extraction fournit une version en cours du document que vous stockez, _et_ une liste de tous les autres documents en conflit qui doivent également être extraits, par exemple `...rev=2-61ae00e029d4f5edd2981841243ded13` et `...rev=1-7438df87b632b312c53a08361a7c3299`.
Chacune de ces autres versions en conflit est également extraite et stockée, par exemple :

  `http://$ACCOUNT.cloudant.com/products/$_ID?rev=2-61ae00e029d4f5edd2981841243ded13`
  `http://$ACCOUNT.cloudant.com/products/$_ID?rev=1-7438df87b632b312c53a08361a7c3299`

Une fois que toutes les révisions en conflit d'un document sont disponibles, vous pouvez procéder à la résolution des conflits.

Dans notre scénario précédent, les différences entre les versions du document concernaient différents champs du document, ce qui facilitait leur fusion.

Des conflits plus complexes nécessiteront probablement plus d'analyses.
Pour vous aider, vous pouvez choisir parmi différentes stratégies de résolution de conflit, telles que :

*	Basée sur l'horodatage : à l'aide d'un test simple de la première ou la plus récente édition.
*	Evaluation de l'utilisateur : les conflits sont signalés aux utilisateurs, qui décident alors de la meilleure résolution.
*	Algorithmes de fusion sophistiqués : souvent utilisés dans les [systèmes de contrôle de version](https://en.wikipedia.org/wiki/Merge_%28version_control%29). Par exemple, la [fusion à trois voies](https://en.wikipedia.org/wiki/Merge_%28version_control%29#Three-way_merge).

Pour un exemple pratique du mode d'implémentation de ces modifications, consultez [ce projet avec un exemple de code](https://github.com/glynnbird/deconflict).

## Téléchargement de la nouvelle révision
{: #upload-the-new-revision}

> Révision finale, après résolution et fusion des modifications des révisions précédentes en conflit.

```json
{
  "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "3-daaecd7213301a1ad5493186d6916755",
    "name": "Samsung Galaxy S4",
    "description": "Latest smartphone from Samsung",
    "price": 600
}
```

Après avoir évalué et résolu les conflits, vous créez un document contenant les données actuelles et définitives.
Ce nouveau document est téléchargé dans la base de données.

## Suppression des anciennes révisions
{: #delete-old-revisions}

> Exemples de demandes de suppression des anciennes révisions.

```http
DELETE http://$ACCOUNT.cloudant.com/products/$_ID?rev=2-61ae00e029d4f5edd2981841243ded13

DELETE http://$ACCOUNT.cloudant.com/products/$_ID?rev=2-f796915a291b37254f6df8f6f3389121
```

La dernière étape consiste à supprimer les anciennes révisions.
Pour ce faire, vous devez envoyer une requête `DELETE`, en spécifiant les révisions à supprimer.

Lorsque les anciennes versions d'un document sont supprimées, les conflits associés à ce document sont marqués comme résolus.
Vous pouvez vérifier qu'aucun conflit ne subsiste en demandant à nouveau le document : avec le paramètre `conflicts` défini sur true, utilisez [find conflicts](#finding-conflicts) comme précédemment.
