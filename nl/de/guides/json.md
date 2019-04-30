---

copyright:
  years: 2015, 2019
lastupdated: "2019-03-18"

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

Die Mehrzahl der Anforderungen und Antworten an und von {{site.data.keyword.cloudantfull}}
verwendet die [JavaScript Object Notation (JSON) ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://en.wikipedia.org/wiki/JSON){: new_window}
zum Formatieren des Inhalts und der Struktur der Daten und Antworten.
{: shortdesc}

In {{site.data.keyword.cloudant_short_notm}}-Datenbanken wird das
JSON-Objekt verwendet, um verschiedene Strukturen darzustellen, darunter alle Dokumente
in einer Datenbank.

Das Parsen von JSON in ein JavaScript-Objekt wird über die Funktion `JSON.parse()` in JavaScript
oder über verschiedene [Bibliotheken](/docs/services/Cloudant?topic=cloudant-client-libraries#client-libraries) unterstützt, die das Parsen des Inhalts in ein JavaScript-Objekt für Sie ausführen. Bibliotheken zum Parsen und Generieren von JSON-Code sind für viele der gängigsten Programmiersprachen verfügbar.

JSON wird verwendet, weil es die einfachste und schnellste Lösung für die Arbeit mit Daten über einen Webbrowser ist.
Dies liegt daran, dass JSON-Strukturen ausgewertet und als JavaScript-Objekte in der Web-Browserumgebung verwendet werden können.
JSON lässt sich auch in das in {{site.data.keyword.cloudant_short_notm}} verwendete, serverseitige JavaScript integrieren.
JSON-Dokumente werden immer in UTF-8 codiert.

Achten Sie darauf, Folgendes sicherzustellen:
-   Ihre JSON-Strukturen sind gültig.
-   Sie normalisieren Zeichenfolgen in JSON-Dokumenten, die von {{site.data.keyword.cloudant_short_notm}} abgerufen wurden.

JSON unterstützt dieselben grundlegenden Typen wie JavaScript:

-   [Zahlen](#numbers)
-   [Zeichenfolgen](#strings)
-   [Boolesche Operatoren](#booleans)
-   [Arrays](#arrays)
-   [Objekte](#objects)

## Zahlen
{: #numbers}

Zahlen können Ganzzahlen oder Gleitkommawerte sein.

_Beispiel einer Zahl im JSON-Format:_

```json
123
```
{: codeblock}

## Zeichenfolgen
{: #strings}

Zeichenfolgen sollten in doppelte Anführungszeichen gesetzt sein. Zeichenfolgen unterstützen Unicode-Zeichen und Backslash als Escapezeichen.

_Beispiel einer Zeichenfolge im JSON-Format:_

```json
"A String"
```
{: codeblock}

## Boolesche Operatoren
{: #booleans}

Der Wert `true` oder `false`.

_Beispiel eines booleschen Operators im JSON-Format:_

```json
{
  "value": true
}
```
{: codeblock}

## Arrays
{: #arrays}

Eine Liste von Werten in Klammern. Die eingeschlossenen Werte können alle gültigen JSON-Elemente sein.

_Beispiel eines Arrays im JSON-Format:_

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

_Beispiel eines Arrays im JSON-Format (linear):_

```json
[ "one", 2, "three", [], true, { "foo": "bar" } ]
```
{: codeblock}

## Objekte
{: #objects}

Eine Gruppe von Schlüssel/Wert-Paaren, z. B. ein assoziatives Array oder ein Hashwert.
Der Schlüssel muss eine Zeichenfolge sein,
aber der Wert kann jeder unterstütze JSON-Wert sein.

_Beispiel eines JSON-Objekts:_

```json
{
    "servings" : 4,
    "subtitle" : "Easy to make in advance, and then cook when ready",
    "cooktime" : 60,
    "title" : "Chicken Coriander"
}
```
{: codeblock}
