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

# Creación de versiones de documentos y MVCC

El [control de simultaneidad de varias versiones (MVCC) ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://en.wikipedia.org/wiki/Multiversion_concurrency_control){:new_window}
es el método que utilizan las bases de datos de Cloudant para garantizar que todos los nodos de un clúster de bases de datos contienen solo la [versión más reciente](../api/document.html) de un documento.
{:shortdesc}

Puesto que las bases de datos de son [finalmente coherentes](cap_theorem.html), se necesita este sistema para evitar que se produzcan incoherencias entre nodos como resultado de la sincronización entre documentos obsoletos. 

El control de simultaneidad de varias versiones (MVCC) permite el acceso simultáneo de lectura y escritura a una base de datos de Cloudant.
MVCC es una forma de [simultaneidad optimista ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](http://en.wikipedia.org/wiki/Optimistic_concurrency_control){:new_window}.
Agiliza las operaciones de lectura y escritura en bases de datos de Cloudant, ya que no es necesario que la base de datos bloquee las operaciones de lectura ni de escritura.
MVCC también permite la sincronización entre los nodos de las bases de datos de Cloudant. 

## Revisiones

Cada documento de una base de datos de Cloudant tiene un campo `_rev` que indica su número de revisión.

El servidor añade un número de revisión a los documentos cuando el usuario los inserta o modifica. El número se incluye en la respuesta del servidor cuando se realizan cambios o se lee un documento. El valor `_rev` se crea utilizando una combinación de un contador simple y un hash del documento.

El número de revisión sirve principalmente para ayudar a: 

1.  Determine los documentos de los que se debe hacer réplica entre servidores.
2.  Confirmar que un cliente está intentando modificar la última versión de un documento.

Debe especificar el valor `_rev` anterior cuando [actualice un documento](../api/document.html#update); de lo contrario la solicitud falla y devuelve un [error 409](../api/http.html#409).

>   **Nota**: No se debe utilizar `_rev` para crear un sistema de control de versiones. 
El motivo es que es un valor interno que utiliza el servidor. Además, las versiones anteriores de un documento son transitorias y por lo tanto se eliminan a intervalos regulares.
Puede consultar una determinara revisión utilizando su valor `_rev`; sin embargo, un proceso denominado [compactación ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](http://en.wikipedia.org/wiki/Data_compaction){:new_window} elimina las revisiones antiguas a intervalos regulares.
Una consecuencia de la compactación es que no puede esperar una respuesta correcta cuando consulte una determinada revisión de un documento utilizando su `_rev` para obtener un historial de las revisiones del documento. Si necesita un historial de versiones de sus documentos, una solución es [crear un nuevo documento](../api/document.html#documentCreate) para cada revisión.

## Bases de datos distribuidas y conflictos

Las bases de datos distribuidas funcionan sin una conexión constante con la base de datos principal de Cloudant, que a su vez es distribuida, de manera que actualizaciones basadas en la misma versión anterior pueden ser conflictivas. 

Para buscar conflictos, añada el parámetro de consulta [`conflicts=true`](../api/database.html#get-changes) al recuperar un documento. La respuesta contiene una matriz `_conflicts` con todas las revisiones conflictivas. 

Para buscar los conflictos correspondientes a varios documentos de una base de datos, escriba una vista.

La siguiente función de correlación es un ejemplo que emite todas las revisiones conflictivas para cada documento que tiene un conflicto.

_Ejemplo de una función de correlación para encontrar los documentos con un conflicto:_

```javascript
function (doc) {
    if (doc._conflicts) {
        emit(null, [doc._rev].concat(doc._conflicts));
    }
}
```
{:codeblock}

Puede consultar esta vista regularmente y resolver los conflictos necesarios o consultar la vista después de cada réplica.

## Cómo resolver conflictos

Cuando encuentre un conflicto, puede resolverlo en 4 pasos.

1.  [Obtenga](#get-conflicting-revisions) las revisiones conflictivas. 
2.  [Fusiónelas](#merge-the-changes) en la aplicación o pregunte al usuario qué quiere hacer. 
3.  [Cargue](#upload-the-new-revision) la nueva revisión. 
4.  [Suprima](#delete-old-revisions) las versiones antiguas. 

Veamos un ejemplo de cómo hacerlo.
Supongamos que tiene una base de datos de productos de una tienda en línea.
La primera versión de un documento se parece al del siguiente ejemplo:

```json
{
    "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "1-7438df87b632b312c53a08361a7c3299",
    "name": "Samsung Galaxy S4",
    "description": "",
    "price": 650
}
```
{:codeblock}

Como el documento aún no tiene una descripción, alguien añade una: 

_Segunda versión del documento, en la que se ha añadido una descripción: _

```json
{
    "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "2-61ae00e029d4f5edd2981841243ded13",
    "name": "Samsung Galaxy S4",
    "description": "Último smartphone de Samsung",
    "price": 650
}
```
{:codeblock}

Paralelamente, otra persona que trabaja con una base de datos replicada reduce el precio: 

_Una revisión diferente, en conflicto con la anterior, debido a distintos valores de `price`:_

```json
{
    "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "2-f796915a291b37254f6df8f6f3389121",
    "name": "Samsung Galaxy S4",
    "description": "",
    "price": 600
}
```
{:codeblock}

Luego se realiza una réplica de ambas bases de datos.
La diferencia entre las versiones del documento da lugar a un conflicto. 

### Obtenga las revisiones conflictivas

Puede identificar los documentos con conflictos mediante la opción `conflicts=true`. 

_Ejemplo de búsqueda de documentos con conflictos:_

```http
http://$ACCOUNT.cloudant.com/products/$_ID?conflicts=true
```
{:codeblock}

_Ejemplo de respuesta que muestra revisiones conflictivas que afectan a documentos:_

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
{:codeblock}

La versión con el precio cambiado ha sido elegida arbitrariamente como la última versión del documento y se detecta el conflicto con la otra versión mediante la aparición del ID de la otra versión en la matriz `_conflicts`. En la mayoría de los casos, esta matriz solo tiene un elemento, pero podría haber varias revisiones conflictivas.

### Fusiones los cambios

Para comparar las revisiones a fin de ver lo que ha cambiado, la aplicación obtiene todas las versiones de la base de datos.

_Ejemplo de mandatos para recuperar todas las versiones de un documento de la base de datos:_

```http
http://$ACCOUNT.cloudant.com/products/$_ID
http://$ACCOUNT.cloudant.com/products/$_ID?rev=2-61ae00e029d4f5edd2981841243ded13
http://$ACCOUNT.cloudant.com/products/$_ID?rev=1-7438df87b632b312c53a08361a7c3299
```
{:codeblock}

Puesto que los cambios conflictivos corresponden a distintos campos del documento, es fácil fusionarlos.

En el caso de conflictos más complejos pueden ser necesarias otras estrategias de resolución: 

*   En función del tiempo: utilizar la primera o la última edición. 
*   Intervención del usuario: notificar los conflictos a los usuarios y dejar que decidan la mejor resolución. 
*   Algoritmos sofisticados: por ejemplo, funciones de 3 vías de campos de texto. 

Para ver un ejemplo práctico de cómo implementar una fusión de cambios, consulte [este proyecto con código de ejemplo ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/glynnbird/deconflict){:new_window}.

### Cargue la nueva revisión

El siguiente paso consiste en crear un documento que resuelva los conflictos y actualizar la base de datos con el mismo. 

_Un documento de ejemplo que fusiona los cambios de las dos revisiones conflictivas:_

```json
{
    "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "3-daaecd7213301a1ad5493186d6916755",
    "name": "Samsung Galaxy S4",
    "description": "Último smartphone de Samsung",
    "price": 600
}
```
{:codeblock}

### Suprima las revisiones antiguas

Finalmente, suprima las versiones antiguas enviado una solicitud `DELETE` a los URL con la revisión que desea suprimir. 

_Ejemplo de solicitud para suprimir una revisión antigua del documento, mediante HTTP:_

```http
DELETE https://$ACCOUNT.cloudant.com/products/$_ID?rev=2-61ae00e029d4f5edd2981841243ded13
```
{:codeblock}

_Ejemplo de solicitud para suprimir una revisión antigua del documento, mediante la línea de mandatos:_

```sh
curl "https://$ACCOUNT.cloudant.com/products/$_ID?rev=2-f796915a291b37254f6df8f6f3389121" -X DELETE
```
{:codeblock}

En este punto se han resuelto los conflictos que afectaban al documento. Puede verificando volviendo a ejecutar `GET` del documento con el parámetro `conflicts` establecido en `true`.
