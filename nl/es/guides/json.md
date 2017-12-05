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

La mayoría de solicitudes enviadas a Cloudant y de respuestas recibidas utilizan
[JavaScript Object Notation (JSON) ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://en.wikipedia.org/wiki/JSON){:new_window}
para formatear el contenido y la estructura de los datos y de las respuestas.
{:shortdesc}

En las bases de datos Cloudant, el objeto
JSON se utiliza para representar diversas estructuras, que incluyen todos los documentos de una base de datos. 

El análisis de JSON en un objeto JavaScript se admite mediante la función `JSON.parse()` en JavaScript o mediante diversas [bibliotecas](../libraries/index.html)
que realizan automáticamente el análisis del contenido en un objeto JavaScript.
Las [bibliotecas](../libraries/index.html) para analizar y generar JSON
están disponibles para muchos de los principales lenguajes de programación. 

Se utiliza JSON porque es la solución más sencilla y rápida para trabajar con datos utilizando un navegador web.
Esto se debe a que las estructuras de JSON se pueden evaluar y utilizar como objetos JavaScript dentro del entorno del navegador web.
JSON también se integra con el JavaScript del servidor que se utiliza en Cloudant.
Los documentos JSON siempre tienen codificación UTF-8. 

>   **Nota**: Es importante que se asegure de que: 

-   Las estructuras JSON sean válidas. Las estructuras no válidas hacen que Cloudant devuelva el código de estado de HTTP [400 (solicitud errónea)](../api/http.html#400).
-   Normalice las series de caracteres de los documentos JSON recuperados de Cloudant antes de compararlos. Esto se debe a que es posible que se haya aplicado la normalización Unicode de modo que una serie almacenada y luego recuperada no sea idéntica a nivel binario. 

JSON admite los mismos tipos básicos que JavaScript:

-   [Números](#numbers)
-   [Series de caracteres](#strings)
-   [Booleanos](#booleans)
-   [Matrices](#arrays)
-   [Objetos](#objects)

## Números

Los números pueden ser enteros o valores de coma flotante.

_Ejemplo de número en formato JSON:_

```json
123
```
{:codeblock}

## Series de caracteres

Las series de caracteres se deben especificar entre comillas dobles. Las series dan soporte a caracteres Unicode y al carácter de escape barra inclinada invertida. 

_Ejemplo de una serie de caracteres en formato JSON:_

```json
"Una serie"
```
{:codeblock}

## Booleanos

Un valor `true` o `false`. 

_Ejemplo de un booleano en formato JSON:_

```json
{
  "value": true
}
```
{:codeblock}

## Matrices

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
{:codeblock}

_Ejemplo de una matriz en formato JSON (lineal):_

```json
[ "one", 2, "three", [], true, { "foo": "bar" } ]
```
{:codeblock}

## Objetos

Un conjunto de pares clave/valor, como una matriz asociativa o un hash. La clave debe ser una serie de caracteres, pero el valor puede ser cualquiera de los valores JSON admitidos. 

_Ejemplo de un objeto JSON:_

```json
{
    "servings" : 4,
    "subtitle" : "Se puede preparar con antelación y cocinar cuando esté listo",
    "cooktime" : 60,
    "title" : "Pollo a la jardinera"
}
```
{:codeblock}
