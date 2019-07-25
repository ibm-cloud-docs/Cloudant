---

copyright:
  years: 2015, 2019
lastupdated: "2019-07-31"

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

The majority of requests and responses to and from {{site.data.keyword.cloudantfull}}
use the [JavaScript Object Notation (JSON) ![External link icon](../images/launch-glyph.svg "External link icon")](https://en.wikipedia.org/wiki/JSON){: new_window}
for formatting the content and structure of the data and responses.
{: shortdesc}

In {{site.data.keyword.cloudant_short_notm}} databases,
the JSON object is used to represent a variety of structures,
including all documents in a database.

Parsing JSON into a JavaScript object is supported through the `JSON.parse()` function in JavaScript, or through various [libraries](/docs/services/Cloudant?topic=cloudant-client-libraries#client-libraries) that perform the parsing of the content into a JavaScript object for you. Libraries for parsing and generating JSON are available for many major programming languages.

JSON is used because it is the simplest and easiest solution for working with data using a web browser.
This is because JSON structures can be evaluated and used as JavaScript objects within the web browser environment.
JSON also integrates with the server-side JavaScript used within {{site.data.keyword.cloudant_short_notm}}.
JSON documents are always UTF-8 encoded.

Be careful to ensure that:
-   Your JSON structures are valid.
-   You normalize strings in JSON documents retrieved from {{site.data.keyword.cloudant_short_notm}},

JSON supports the same basic types as supported by JavaScript:

-   [Numbers](#numbers)
-   [Strings](#strings)
-   [Booleans](#booleans)
-   [Arrays](#arrays)
-   [Objects](#objects)

## Numbers
{: #numbers}

Numbers can be integer or floating point values.

### Example of a number in JSON format

```json
123
```
{: codeblock}

## Strings
{: #strings}

String should be enclosed by double-quotes. Strings support Unicode characters and backslash escaping.

### Example of a string in JSON format

```json
"A String"
```
{: codeblock}

## Booleans
{: #booleans}

A `true` or `false` value.

### Example of a boolean in JSON format

```json
{
  "value": true
}
```
{: codeblock}

## Arrays
{: #arrays}

A list of values enclosed in brackets. The values enclosed can be any valid JSON.

### Example of an array in JSON format

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

### Example of an array in JSON format (linear)

```json
[ "one", 2, "three", [], true, { "foo": "bar" } ]
```
{: codeblock}

## Objects
{: #objects}

A set of key/value pairs,
such as an associative array,
or a hash.
The key must be a string,
but the value can be any of the supported JSON values.

### Example of a JSON object

```json
{
    "servings" : 4,
    "subtitle" : "Easy to make in advance, and then cook when ready",
    "cooktime" : 60,
    "title" : "Chicken Coriander"
}
```
{: codeblock}
