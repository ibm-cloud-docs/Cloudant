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

# JSON

La plupart des demandes et des réponses vers et depuis Cloudant utilisent le format [JavaScript Object Notation (JSON) ![External link icon](../images/launch-glyph.svg "External link icon")](https://en.wikipedia.org/wiki/JSON){:new_window}
pour mettre en forme le contenu et la structure des données et des réponses.
{:shortdesc}

Dans les bases de données Cloudant,
l'objet JSON est utilisé pour représenter une variété de structures, y compris l'ensemble des documents d'une base de données.

L'analyse syntaxique de JSON en un objet JavaScript est prise en charge par le biais de la fonction `JSON.parse()` dans JavaScript,
ou par le biais de diverses [bibliothèques](../libraries/index.html)
qui analysent le contenu dans un objet JavaScript pour vous.
Des [bibliothèques](../libraries/index.html) destinées à l'analyse et à la génération de JSON sont disponibles pour la plupart des langages de programmation.

JSON est utilisé, car il s'agit de la solution la plus simple et la plus facile pour travailler avec des données sous un navigateur Web.
La raison en est que les structures JSON peuvent être évaluées et utilisées en tant qu'objets JavaScript au sein de l'environnement de navigateur Web.
En outre, JSON s'intègre au JavaScript côté serveur utilisé dans Cloudant.
Les documents JSON sont toujours encodés au format UTF-8.

>   **Remarque** : Il est essentiel de contrôler les points suivants :

-   Vos structures JSON sont valides.
    Des structures non valides forcent Cloudant à renvoyer un code de statut HTTP [400 - Demande incorrecte](../api/http.html#400).
-   Vous normalisez les chaînes dans les documents JSON récupérés à partir de Cloudant, avant de les comparer.
    Ceci s'explique par le fait que la normalisation Unicode a peut-être été appliquée,
    et qu'une chaîne stockée, puis extraite n'est pas identique au niveau binaire.

JSON prend en charge les mêmes types de base que JavaScript :

-   [Nombres](#numbers)
-   [Chaînes](#strings)
-   [Valeurs booléennes](#booleans)
-   [Tableaux](#arrays)
-   [Objets](#objects)

## Nombres

Les nombres peuvent être des entiers ou des valeurs en virgule flottante.

_Exemple de nombre au format JSON  :_

```json
123
```
{:codeblock}

## Chaînes

Les chaînes doivent se trouver entre guillemets. Les chaînes prennent en charge les caractères Unicode et les échappements avec barre oblique inversée.

_Exemple de chaîne au format JSON :_

```json
"A String"
```
{:codeblock}

## Valeurs booléennes

Valeur `true` ou `false`.

_Exemple de valeur booléenne au format JSON :_

```json
{
  "value": true
}
```
{:codeblock}

## Tableaux

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
{:codeblock}

_Exemple de tableau au format JSON (linéaire) :_

```json
[ "one", 2, "three", [], true, { "foo": "bar" } ]
```
{:codeblock}

## Objets

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
{:codeblock}
