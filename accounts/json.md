---

copyright:
  years: 2015, 2021
lastupdated: "2021-11-08"

keywords: numbers, strings, booleans, arrays, objects, JSON parser, JavaScript

subcollection: Cloudant

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
{:external: target="_blank" .external}

# How JavaScript Object Notation (JSON) works
{: #how-json-works}

Most requests and responses to and from {{site.data.keyword.cloudantfull}}
use [JSON](https://en.wikipedia.org/wiki/JSON){: external} for formatting the content and structure of the data and responses.
{: shortdesc}

In {{site.data.keyword.cloudant_short_notm}} databases,
the JSON object is used to represent various structures,
including all documents in a database.

Parsing JSON into a JavaScript object is supported through the `JSON.parse()` function in JavaScript, or through various [libraries](/docs/Cloudant?topic=Cloudant-client-libraries#client-libraries) that perform the parsing of the content into a JavaScript object for you. Libraries for parsing and generating JSON are available for many major programming languages.

JSON is used because it's the simplest and easiest solution for working with data that uses a web browser. As a result, JSON structures can be evaluated and used as JavaScript objects within the web browser environment. JSON also integrates with the server-side JavaScript used within {{site.data.keyword.cloudant_short_notm}}. JSON documents are always UTF-8 encoded.

Be careful to follow these guidelines:

-   Your JSON structures are valid.
-   You normalize strings in JSON documents retrieved from {{site.data.keyword.cloudant_short_notm}}.

JSON supports the same basic types that are supported by JavaScript: numbers, strings, Booleans, arrays, and objects. 

## Numbers
{: #numbers}

Numbers can be integer or floating point values.

### Example of a number in JSON format
{: #example-number-json-format}

```json
123
```
{: codeblock}

## Strings
{: #strings}

Strings must be enclosed by double quotation marks. Strings support Unicode characters and escaping a backslash.

### Example of a string in JSON format
{: #example-string-json-format}

```json
"A String"
```
{: codeblock}

## Booleans
{: #booleans}

A `true` or `false` value.

### Example of a boolean in JSON format
{: #example-boolean-json-format}

```json
{
  "value": true
}
```
{: codeblock}

## Arrays
{: #arrays}

A list of values enclosed in brackets. The values that are enclosed can be any valid JSON.

### Example of an array in JSON format
{: #example-array-json-format}

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
{: #example-array-json-format-linear}

```json
[ "one", 2, "three", [], true, { "foo": "bar" } ]
```
{: codeblock}

## Objects
{: #objects}

A set of `key-value` pairs,
such as an associative array,
or a hash.
The key must be a string,
but the value can be any of the supported JSON values.

### Example of a JSON object
{: #example-json-object}

```json
{
    "servings" : 4,
    "subtitle" : "Easy to make in advance, and then cook when ready",
    "cooktime" : 60,
    "title" : "Chicken Coriander"
}
```
{: codeblock}
