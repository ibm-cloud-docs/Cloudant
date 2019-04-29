---

copyright:
  years: 2015, 2019
lastupdated: "2019-03-15"

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

# Conflictos
{: #conflicts}

En bases de datos distribuidas en las que las copias de datos pueden almacenarse en más de una ubicación, la red natural y las características del sistema pueden indicar que los cambios realizados en un documento almacenado en una ubicación no se puedan actualizar o replicar instantáneamente en otras partes de la base de datos.

En otras palabras, si se realizan actualizaciones independientes en otras copias de documentos, el efecto puede provocar desacuerdos o 'conflictos' con respecto a cuál es el contenido definitivo y correcto del documento.

{{site.data.keyword.cloudantfull}} intenta ayudarle a evitar conflictos advirtiéndole de posibles problemas.
Le avisa devolviendo una [respuesta `409`](/docs/services/Cloudant?topic=cloudant-http#http-status-codes) a una solicitud de actualización problemática.
Sin embargo, es posible que no se reciba la respuesta `409` si se solicita la actualización de la base de datos en un sistema que actualmente no está conectado a la red.
Por ejemplo, la base de datos puede estar en un dispositivo móvil desconectado temporalmente de Internet, lo que hace imposible comprobar si se han realizado otras actualizaciones potencialmente conflictivas en ese momento.

Si solicita un documento que se encuentra en una situación conflictiva, {{site.data.keyword.cloudant_short_notm}} devolverá el documento como se espera.
Sin embargo, la versión devuelta está determinada por un algoritmo interno que tiene en cuenta una serie de factores; por ejemplo, no debe suponer que el documento devuelto siempre es la versión más reciente.

Si no comprueba los conflictos o no puede abordarlos, la base de datos de {{site.data.keyword.cloudant_short_notm}} empezará a mostrar varios comportamientos:

* Aumento de inconsistencias en el contenido del documento, ya que hay más documentos conflictivos.
* Aumento del tamaño de la base de datos, ya que todos los documentos conflictivos deben mantenerse hasta que se resuelva el conflicto.
* Disminución del rendimiento, porque {{site.data.keyword.cloudant_short_notm}} debe trabajar más como respuesta a cada una de las solicitudes, ya que te intenta identificar la 'mejor versión posible' de un documento conflictivo.

Las prácticas siguientes sugeridas pueden ayudarle a decidir cuándo comprobar o resolver conflictos:

<table>
<tr>
<th>Característica de aplicación</th>
<th>Frecuencia de la actualización de documento</th>
<th>¿Desea comprobar si hay conflictos en la recuperación?</th>
<th>¿Desea comprobar si hay conflictos en la actualización?</th>
</tr>
<tr>
<td>Siempre está conectado a la red, por ejemplo un servidor.</td>
<td>A menudo</td>
<td>S</td>
<td>-</td>
</tr>
<tr>
<td>Siempre está conectado a la red.</td>
<td>Ocasionalmente</td>
<td>-</td>
<td>S</td>
</tr>
<tr>
<td>A menudo, aunque no siempre, está conectado a la red, por ejemplo, un portátil.</td>
<td>A menudo</td>
<td>-</td>
<td>S</td>
</tr>
<tr>
<td>A menudo, aunque no siempre, está conectado a la red.</td>
<td>Ocasionalmente</td>
<td>-</td>
<td>S</td>
</tr>
<tr>
<td>A menudo, aunque no siempre, está conectado a la red, por ejemplo, una tableta.</td>
<td>A menudo</td>
<td>-</td>
<td>S</td>
</tr>
</table>

## Búsqueda de conflictos
{: #finding-conflicts}

Para buscar conflictos que puedan afectar a un documento, añada el parámetro de consulta `conflicts=true` cuando reciba un documento.
Cuando se devuelve, el documento resultante contiene una matriz `_conflicts`, que incluye una lista de todas las revisiones conflictivas.

> Ejemplo de una función de correlación para buscar conflictos de documento:

```
function (doc) {
  if (doc._conflicts) {
    emit(null, [doc._rev].concat(doc._conflicts));
    }
}
```

Para buscar los conflictos correspondientes a varios documentos de una base de datos, escriba una [vista](/docs/services/Cloudant?topic=cloudant-views-mapreduce#views-mapreduce).
Utilizando una función de correlación como la del ejemplo proporcionado podrá encontrar todas las revisiones para cada documento con un conflicto.

Cuando tenga dicha vista, puede utilizarla para buscar y resolver conflictos según sea necesario.
De forma alternativa, puede consultar la vista después de cada réplica para identificar y resolver conflictos inmediatamente.

## Cómo resolver conflictos
{: #how-to-resolve-conflicts}

Cuando encuentre un conflicto, puede resolverlo siguiendo 4 pasos:

1.	[Obtenga](#get-conflicting-revisions) las revisiones conflictivas.
2.	[Fusiónelas](#merge-the-changes) en la aplicación o pregunte al usuario qué desea hacer.
3.	[Cargue](#upload-the-new-revision) la nueva revisión.
4.	[Suprima](#delete-old-revisions) las versiones antiguas.

> Ejemplo de la primera versión de un documento.

```json
{
  "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "1-7438df87b632b312c53a08361a7c3299",
    "name": "Samsung Galaxy S4",
    "description": "",
    "price": 650
}
```

Veamos un ejemplo de cómo hacerlo.
Supongamos que tiene una base de datos de productos de una tienda en línea.
Es posible que la primera versión de un documento se parezca a la del ejemplo proporcionado.

> Segunda versión (primera revisión) del documento, que añade una descripción.

```json
{
  "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "2-61ae00e029d4f5edd2981841243ded13",
    "name": "Samsung Galaxy S4",
    "description": "Último smartphone de Samsung",
    "price": 650
}
```

El documento todavía no tiene ninguna descripción, por lo que es posible que alguien la añada.

> Segunda versión _alternativa_ que presenta un cambio de datos de reducción de precios en la primera versión del documento.

```json
{
  "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "2-f796915a291b37254f6df8f6f3389121",
    "name": "Samsung Galaxy S4",
    "description": "",
    "price": 600
}
```

Paralelamente, otra persona que trabaja con una base de datos replicada reduce el precio.
Este cambio se hace en la primera versión del documento.
Por lo tanto, el cambio de reducción de precios no conoce el cambio de la descripción.

Más adelante, cuando las dos bases de datos se replican, puede no quedar claro cuál de las dos versiones alternativas del documento es la correcta.
Este es un caso de ejemplo de conflicto.

## Obtenga las revisiones conflictivas
{: #get-conflicting-revisions}

Para encontrar revisiones conflictivas en un documento, recupere el documento de la forma habitual, pero incluya el parámetro `conflicts=true`, igual que en el ejemplo siguiente:

`http://ACCOUNT.cloudant.com/products/$_ID?conflicts=true`


> Ejemplo de respuesta a la recuperación de documentos que muestra revisiones conflictivas

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

Si el documento tiene algún conflicto, obtendrá una respuesta similar a la del ejemplo proporcionado, que se basa en la descripción cambiada o el problema de precios modificado.

La versión con el precio cambiado se ha elegido _aleatoriamente_ como la última versión del documento.
No debería suponer que la versión actualizada más reciente del documento se considera la última versión para fines de resolución de conflictos.

En este ejemplo, se considera que existe un conflicto entre el documento recuperado que tiene el valor `_rev` `2-f796915a291b37254f6df8f6f3389121`,
y otro documento que tiene el valor `_rev` `2-61ae00e029d4f5edd2981841243ded13`.
Los detalles conflictivos del documento se marcan en la matriz `_conflicts`.

A menudo, verá que la matriz solo tiene un elemento, pero es posible que existan muchas revisiones conflictivas, cada una de las cuales se lista en la matriz.

## Fusiones los cambios
{: #merge-the-changes}

La aplicación debe identificar todos los cambios potenciales y reconciliarlos, fusionando de manera efectiva las actualizaciones correctas y válidas para producir una única versión no conflictiva del documento.

Para comparar las revisiones e identificar qué ha cambiado, la aplicación deberá recuperar todas las versiones de la base de datos.
Tal como se ha descrito anteriormente, empezaremos recuperando un documento y los detalles de las versiones conflictivas.
Para ello, utilizamos un mandato similar al siguiente, que también solicita la matriz `_conflicts`:

`http://$ACCOUNT.cloudant.com/products/$_ID?conflicts=true`

Esta recuperación nos proporciona la versión actual del documento que almacenamos _y_ una lista del resto de los documentos conflictivos que deben recuperarse, por ejemplo `...rev=2-61ae00e029d4f5edd2981841243ded13` y `...rev=1-7438df87b632b312c53a08361a7c3299`.
También se recupera y almacena cada una de las otras versiones conflictivas, por ejemplo:

  `http://$ACCOUNT.cloudant.com/products/$_ID?rev=2-61ae00e029d4f5edd2981841243ded13`
  `http://$ACCOUNT.cloudant.com/products/$_ID?rev=1-7438df87b632b312c53a08361a7c3299`

Cuando todas las revisiones conflictivas de un documento estén disponibles, podrá proceder a resolver los conflictos.

En el caso de ejemplo anterior, las diferencias entre las versiones del documento correspondían a distintos campos del documento, facilitando así la fusión.

En consecuencia, los conflictos más complejos pueden requerir más análisis.
Le recomendamos elegir diversas estrategias de resolución de conflictos distintas, como:

*	En función del tiempo: utilizando una prueba simple de la primera edición o la más reciente.
*	Evaluación del usuario: los conflictos se notifican a los usuarios, que deciden la mejor resolución.
*	Algoritmos de fusión sofisticados: generalmente se utilizan en los [sistemas de control de versión](https://en.wikipedia.org/wiki/Merge_%28version_control%29). Un ejemplo es la [fusión de 3 vías](https://en.wikipedia.org/wiki/Merge_%28version_control%29#Three-way_merge).

Para ver un ejemplo práctico sobre cómo implementar los cambios, consulte [este proyecto con código de ejemplo](https://github.com/glynnbird/deconflict).

## Cargue la nueva revisión
{: #upload-the-new-revision}

> Revisión final después de resolver y fusionar los cambios a partir de revisiones conflictivas previas.

```json
{
  "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "3-daaecd7213301a1ad5493186d6916755",
    "name": "Samsung Galaxy S4",
    "description": "Último smartphone de Samsung",
    "price": 600
}
```

Después de evaluar y resolver los conflictos, cree un documento que contenga los datos actuales y definitivos.
El nuevo documento se carga a la base de datos.

## Suprima las revisiones antiguas
{: #delete-old-revisions}

> Ejemplo de solicitudes para suprimir revisiones antiguas.

```http
DELETE http://$ACCOUNT.cloudant.com/products/$_ID?rev=2-61ae00e029d4f5edd2981841243ded13

DELETE http://$ACCOUNT.cloudant.com/products/$_ID?rev=2-f796915a291b37254f6df8f6f3389121
```

El último paso es suprimir las revisiones antiguas.
Para ello, envíe un solicitud `DELETE`, especificando las revisiones que desea suprimir.

Cuando se suprimen las versiones antiguas de un documento, los conflictos asociados con dicho documento se marcan como resueltos.
Puede verificar que no hay conflictos restantes solicitando el documento de nuevo con el parámetro `conflicts` establecido en true y utilizando [find conflicts](#finding-conflicts) igual que antes.
