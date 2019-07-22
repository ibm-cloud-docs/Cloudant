---

copyright:
  years: 2015, 2019
lastupdated: "2019-06-12"

keywords: numbers, strings, booleans, arrays, objects

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

# JSON
{: #json}

La plupart des demandes et des réponses vers et depuis {{site.data.keyword.cloudantfull}} utilisent le format [JavaScript Object Notation (JSON) ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://en.wikipedia.org/wiki/JSON){: new_window}
pour mettre en forme le contenu et la structure des données et des réponses.
{: shortdesc}

Dans les bases de données {{site.data.keyword.cloudant_short_notm}},
l'objet JSON est utilisé pour représenter une variété de structures, y compris l'ensemble des documents d'une base de données.

L'analyse syntaxique de JSON en un objet JavaScript est prise en charge par le biais de la fonction `JSON.parse()` dans JavaScript,
ou par le biais de diverses [bibliothèques](/docs/services/Cloudant?topic=cloudant-client-libraries#client-libraries)
qui analysent le contenu dans un objet JavaScript pour vous. Des bibliothèques destinées à l'analyse et à la génération JSON sont disponibles pour la plupart des grands langages de programmation.

JSON est utilisé, car il s'agit de la solution la plus simple et la plus facile pour travailler avec des données sous un navigateur Web.
La raison en est que les structures JSON peuvent être évaluées et utilisées en tant qu'objets JavaScript au sein de l'environnement de navigateur Web.
En outre, JSON s'intègre au JavaScript côté serveur utilisé dans {{site.data.keyword.cloudant_short_notm}}.
Les documents JSON sont toujours encodés au format UTF-8.

Prenez soin de vérifier les points ci-après.
-   Vos structures JSON sont valides.
-   Vous normalisez les chaînes dans les documents JSON extraits depuis {{site.data.keyword.cloudant_short_notm}}.

JSON prend en charge les mêmes types de base que JavaScript :

-   [Nombres](#numbers)
-   [Chaînes](#strings)
-   [Valeurs booléennes](#booleans)
-   [Tableaux](#arrays)
-   [Objets](#objects)

## Nombres
{: #numbers}

Les nombres peuvent être des entiers ou des valeurs en virgule flottante.

_Exemple de nombre au format JSON :_

```json
123
```
{: codeblock}

## Chaînes
{: #strings}

Les chaînes doivent se trouver entre guillemets. Les chaînes prennent en charge les caractères Unicode et les échappements avec barre oblique inversée.

_Exemple de chaîne au format JSON :_

```json
"A String"
```
{: codeblock}

## Valeurs booléennes
{: #booleans}

Valeur `true` ou `false`.

_Exemple de valeur booléenne au format JSON :_

```json
{
  "value": true
}
```
{: codeblock}

## Tableaux
{: #arrays}

Liste de valeurs entre crochets. Les valeurs peuvent correspondre à n'importe quelle notation JSON valide.

_Exemple de tableau au format JSON :_

```json
[
    "one",
    2,
    "three",
    [],
    true,
    {
        "foo":
        "bar"
    }
]
```
{: codeblock}

_Exemple de tableau au format JSON (linéaire) :_

```json
[ "one", 2, "three", [], true, { "foo": "bar" } ]
```
{: codeblock}

## Objets
{: #objects}

Ensemble de paires clé/valeur,
par exemple un tableau associatif ou
un hachage.
La clé doit être une chaîne,
mais la valeur peut correspondre à n'importe quelle valeur JSON compatible.

_Exemple d'objet JSON :_

```json
{
    "servings" : 4,
    "subtitle" : "Easy to make in advance, and then cook when ready",
    "cooktime" : 60,
    "title" : "Chicken Coriander"
}
```
{: codeblock}
