---

copyright:
  years: 2015, 2018
lastupdated: "2018-10-24"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:tip: .tip}

<!-- Acrolinx: 2017-05-10 -->

# JSON

Die Mehrzahl der Anforderungen und Antworten an und von {{site.data.keyword.cloudantfull}}
verwendet die [JavaScript Object Notation (JSON) ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://en.wikipedia.org/wiki/JSON){:new_window}
zum Formatieren des Inhalts und der Struktur der Daten und Antworten.
{:shortdesc}

In {{site.data.keyword.cloudant_short_notm}}-Datenbanken wird das
JSON-Objekt verwendet, um verschiedene Strukturen darzustellen, darunter alle Dokumente
in einer Datenbank.

Das Parsen von JSON in ein JavaScript-Objekt wird über die Funktion `JSON.parse()` in JavaScript
oder über verschiedene [Bibliotheken](../libraries/index.html) unterstützt, die das Parsen des Inhalts in ein JavaScript-Objekt für Sie ausführen.
[Bibliotheken](../libraries/index.html) für das Parsen und Generieren von JSON sind für die wichtigsten Programmiersprachen verfügbar.

JSON wird verwendet, weil es die einfachste und schnellste Lösung für die Arbeit mit Daten über einen Webbrowser ist.
Dies liegt daran, dass JSON-Strukturen ausgewertet und als JavaScript-Objekte in der Web-Browserumgebung verwendet werden können.
JSON lässt sich auch in das in {{site.data.keyword.cloudant_short_notm}} verwendete, serverseitige JavaScript integrieren.
JSON-Dokumente werden immer in UTF-8 codiert.

>   **Hinweis**: Achten Sie auf Folgendes:

-   Ihre JSON-Strukturen sind gültig.
    Ungültige Strukturen führen dazu, dass {{site.data.keyword.cloudant_short_notm}} den HTTP-Statuscode [400 (bad request)](../api/http.html#400) zurückgibt.
-   Sie normalisieren Zeichenfolgen in aus {{site.data.keyword.cloudant_short_notm}} abgerufenen JSON-Dokumenten,
    bevor Sie sie vergleichen.
    Grund dafür ist, dass möglicherweise die Unicode-Normalisierung angewendet wurde,
    sodass eine gespeicherte und dann abgerufene Zeichenfolge auf binärer Ebene nicht identisch ist.

JSON unterstützt dieselben grundlegenden Typen wie JavaScript:

-   [Zahlen](#numbers)
-   [Zeichenfolgen](#strings)
-   [Boolesche Operatoren](#booleans)
-   [Arrays](#arrays)
-   [Objekte](#objects)

## Zahlen

Zahlen können Ganzzahlen oder Gleitkommawerte sein.

_Beispiel einer Zahl im JSON-Format:_

```json
123
```
{:codeblock}

## Zeichenfolgen

Zeichenfolgen sollten in doppelte Anführungszeichen gesetzt sein. Zeichenfolgen unterstützen Unicode-Zeichen und Backslash als Escapezeichen.

_Beispiel einer Zeichenfolge im JSON-Format:_

```json
"A String"
```
{:codeblock}

## Boolesche Operatoren

Der Wert `true` oder `false`.

_Beispiel eines booleschen Operators im JSON-Format:_

```json
{
  "value": true
}
```
{:codeblock}

## Arrays

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
{:codeblock}

_Beispiel eines Arrays im JSON-Format (linear):_

```json
[ "one", 2, "three", [], true, { "foo": "bar" } ]
```
{:codeblock}

## Objekte

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
{:codeblock}
