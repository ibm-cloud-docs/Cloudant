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

La maggior parte di richieste e risposte da e verso {{site.data.keyword.cloudantfull}}
utilizza il [JSON (JavaScript Object Notation) ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://en.wikipedia.org/wiki/JSON){: new_window}
per formattare il contenuto e la struttura dei dati e delle risposte.
{: shortdesc}

Nei database {{site.data.keyword.cloudant_short_notm}},
l'oggetto JSON è utilizzato per rappresentare una varietà di strutture,
inclusi tutti i documenti contenuti in un database.

L'analisi del JSON in un oggetto JavaScript è supportata attraverso la funzione `JSON.parse()` in JavaScript
o attraverso varie [librerie](/docs/services/Cloudant?topic=cloudant-client-libraries#client-libraries)
che eseguono per te l'analisi del contenuto in un oggetto JavaScript. Le librerie per l'analisi e la generazione di JSON sono disponibili per molti linguaggi di programmazione principali. 

JSON viene utilizzato perché è la soluzione più semplice e più facile per lavorare con i dati utilizzando un browser Web.
Ciò è dovuto al fatto che le strutture JSON possono essere valutate e utilizzate come oggetti JavaScript all'interno dell'ambiente del browser web.
Inoltre JSON si integra con il JavaScript lato server utilizzato in {{site.data.keyword.cloudant_short_notm}}.
I documenti JSON sono sempre codificati in UTF-8.

Fai attenzione ad assicurarti che:
-   Le tue strutture JSON siano valide.
-   Normalizzi le stringhe nei documenti JSON recuperati da {{site.data.keyword.cloudant_short_notm}},

JSON supporta gli stessi tipi di base supportati da JavaScript:

-   [Numeri](#numbers)
-   [Stringhe](#strings)
-   [Valori booleani](#booleans)
-   [Array](#arrays)
-   [Oggetti](#objects)

## Numeri
{: #numbers}

I numeri possono essere valori interi o valori in virgola mobile.

_Esempio di numero in formato JSON:_

```json
123
```
{: codeblock}

## Stringhe
{: #strings}

La stringa deve essere racchiusa tra virgolette. Le stringhe supportano i caratteri Unicode e il separatore di escape a barra rovesciata.

_Esempio di stringa in formato JSON:_

```json
"A String"
```
{: codeblock}

## Valori booleani
{: #booleans}

Un valore `true` o `false`.

_Esempio di valore booleano in formato JSON:_

```json
{
  "value": true
}
```
{: codeblock}

## Array
{: #arrays}

Un elenco di valori racchiusi tra parentesi. I valori racchiusi possono essere qualsiasi JSON valido.

_Esempio di array in formato JSON:_

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

_Esempio di array in formato JSON (lineare):_

```json
[ "one", 2, "three", [], true, { "foo": "bar" } ]
```
{: codeblock}

## Oggetti
{: #objects}

Una serie di coppie chiave/valore,
ad esempio un array associativo
o un hash.
La chiave deve essere una stringa,
ma il valore può essere uno qualsiasi dei valori JSON supportati.

_Esempio di oggetto JSON:_

```json
{
    "servings" : 4,
    "subtitle" : "Easy to make in advance, and then cook when ready",
    "cooktime" : 60,
    "title" : "Chicken Coriander"
}
```
{: codeblock}
