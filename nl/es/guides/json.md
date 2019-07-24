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

La mayoría de las solicitudes enviadas a {{site.data.keyword.cloudantfull}} y de respuestas recibidas utilizan
[JavaScript Object Notation (JSON) ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://en.wikipedia.org/wiki/JSON){: new_window}
para formatear el contenido y la estructura de los datos y respuestas.
{: shortdesc}

En las bases de datos de {{site.data.keyword.cloudant_short_notm}}, el objeto JSON se utiliza para representar diversas estructuras, que incluyen todos los documentos de una base de datos.

El análisis de JSON en un objeto JavaScript se admite mediante la función `JSON.parse()` en JavaScript o mediante diversas [bibliotecas](/docs/services/Cloudant?topic=cloudant-client-libraries#client-libraries)
que realizan automáticamente el análisis del contenido en un objeto JavaScript. Las bibliotecas para analizar y generar JSON están disponibles para muchos de los principales lenguajes de programación.

Se utiliza JSON porque es la solución más sencilla y rápida para trabajar con datos utilizando un navegador web.
Esto se debe a que las estructuras de JSON se pueden evaluar y utilizar como objetos JavaScript dentro del entorno del navegador web.
JSON también se integra con el JavaScript del servidor que se utiliza en {{site.data.keyword.cloudant_short_notm}}.
Los documentos JSON siempre tienen codificación UTF-8.

Es importante asegurarse de que:
-   Las estructuras JSON sean válidas.
-   Normaliza las series de caracteres de los documentos JSON recuperados de {{site.data.keyword.cloudant_short_notm}}.

JSON admite los mismos tipos básicos que JavaScript:

-   [Números](#numbers)
-   [Series de caracteres](#strings)
-   [Booleanos](#booleans)
-   [Matrices](#arrays)
-   [Objetos](#objects)

## Números
{: #numbers}

Los números pueden ser enteros o valores de coma flotante.

_Ejemplo de número en formato JSON:_

```json
123
```
{: codeblock}

## Series de caracteres
{: #strings}

Las series de caracteres se deben especificar entre comillas dobles. Las series dan soporte a caracteres Unicode y al carácter de escape barra inclinada invertida.

_Ejemplo de una serie de caracteres en formato JSON:_

```json
"Una serie"
```
{: codeblock}

## Booleanos
{: #booleans}

Un valor `true` o `false`.

_Ejemplo de un booleano en formato JSON:_

```json
{
  "value": true
}
```
{: codeblock}

## Matrices
{: #arrays}

Una lista de valores especificados entre corchetes. Los valores comprendidos entre corchetes pueden ser cualquier valor JSON válido.

_Ejemplo de una matriz en formato JSON:_

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

_Ejemplo de una matriz en formato JSON (lineal):_

```json
[ "one", 2, "three", [], true, { "foo": "bar" } ]
```
{: codeblock}

## Objetos
{: #objects}

Un conjunto de pares clave/valor, como una matriz asociativa o un hash.
La clave debe ser una serie de caracteres, pero el valor puede ser cualquiera de los valores JSON admitidos.

_Ejemplo de un objeto JSON:_

```json
{
    "servings" : 4,
    "subtitle" : "Se puede preparar con antelación y cocinar cuando esté listo",
    "cooktime" : 60,
    "title" : "Pollo a la jardinera"
}
```
{: codeblock}
