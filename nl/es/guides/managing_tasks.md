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

# Gestión de tareas

La creación de índices nuevos sobre muchos datos o la réplica de una base de datos grande puede tardar bastante tiempo.
{:shortdesc}

¿Cómo puede determinar si se están procesando las tareas o si han finalizado?
El [punto final `_active_tasks`](../api/active_tasks.html) ofrece información sobre todas las tareas en curso.
Sin embargo, si inicia muchas tareas, puede que algunas se hayan planificado para que se ejecuten posteriormente y no se muestren en `_active_tasks` hasta que comiencen.

En esta guía se muestra cómo utilizar el punto final `_active_tasks` para supervisar las tareas de larga ejecución.
Se utiliza el mandato `curl` para acceder al punto final.
Se utiliza el procesador JSON de línea de mandatos `jq` para procesar la respuesta de JSON.

Puesto que esta guía de aprendizaje se centra en las tareas, solo cubren los pasos básicos para ejecutar esta tarea.
Consulte la [Consulta de API](../api/index.html) si desea ver una guía completa de las opciones disponibles.

## Conceptos básicos sobre curl y jq

Para obtener todas las tareas activas y formatear correctamente la salida, realice una llamada a su cuenta mediante `curl` y dirija la salida a `jq`.

`jq` le permite filtrar una lista de documentos por los valores de sus campos.
Esto facilita la obtención de todos los documentos de réplica o los detalles de una determinada tarea de indexación de vista.
La [Consulta de API](../api/index.html) contiene más información sobre las opciones.

_Ejemplo de obtención y formateo de una lista de tareas activas:_

```sh
curl 'https://username:password@username.cloudant.com/_active_tasks' | jq '.'
```
{:codeblock}

## Supervisión de creaciones de vistas e índices de búsqueda

Los índices de vista se vuelven a crear cuando se actualiza un documento de diseño.
Una actualización en cualquiera de las vistas hace que se vuelvan a crear todas las vistas del documento.

Los índices de búsqueda se vuelven a crear solo cuando se modifica su función de índice correspondiente.
Para cada índice de búsqueda que se crea y para cada documento de diseño con vistas que se han modificado, se crea una nueva tarea para cada réplica de cada fragmento de un clúster.

Por ejemplo, si hay
24 fragmentos, con tres réplicas cada uno, y actualiza dos
índices de búsqueda, se ejecutan
24 x 3 x 2 = 144 tareas.

Para ver todas las tareas de indexación de vistas, dirija la salida de `curl` a `jq` y deje que filtre los documentos de la matriz por el campo de tipo.
Existe un mandato correspondiente para las tareas de indexación de búsqueda.

En cada caso, el resultado de buscar una lista de tareas de indexación es una lista
de objetos JSON: uno para cada tarea activa encontrada.

_Ejemplo de búsqueda de todas las tareas de indexación de vistas filtrando por el tipo `indexer`:_

```sh
curl -s 'https://username:password@username.cloudant.com/_active_tasks' | jq '.[] | select(.type=="indexer")'
```
{:codeblock}

_Ejemplo de búsqueda de todas las tareas de indexación de búsqueda filtrando por el tipo `search_indexer`:_

```sh
curl -s 'https://username:password@username.cloudant.com/_active_tasks' | jq '.[] | select(.type=="search_indexer")'
```
{:codeblock}

_Ejemplo de resultados después de buscar las tareas de indexación de vistas: _

```json
{
    "total_changes": 6435,
    "started_on": 1371118332,
    "user": "username",
    "updated_on": 1371118334,
    "type": "indexer",
    "node": "dbcore@db6.meritage.cloudant.net",
    "pid": "<0.16366.6103>",
    "changes_done": 364,
    "database": "shards/40000000-7fffffff/username/database",
    "design_document": "_design/ngrams"
}
```
{:codeblock}

## Estimación del tiempo necesario para completar una tarea

Para estimar el tiempo necesario para que finalice la tarea de indexación, supervise el número de `changes_done` y compare este valor con `total_changes`.
Por ejemplo, si `changes_done` avanza 250 por segundo y `total_changes` es 1.000.000,
se espera que la tarea tarde 1.000.000 / 250 = 4.000 segundos, o unos 66 minutos, en completarse.

>   **Nota**: Las estimaciones del tiempo necesario para completar una tarea de indexación no pueden ser precisos al 100%.
    El tiempo real que se tarda en completar la tarea depende de varios factores, entre ellos:

-   El tiempo que se tarda en procesar cada documento.
    Por ejemplo, una vista puede comprobar primero el tipo de documento y emitir solo nuevas entradas de índice para un tipo.
-   El tamaño de los documentos.
-   La carga de trabajo actual en el clúster.

>   Tenga en cuenta que la combinación de estos factores puede hacer que la estimación sea bastante imprecisa.

_Ejemplo de extracción del campo `changes_done` mediante `jq`:_

```sh
curl ... | jq '.[] | select(.type=="search_indexer") | .changes_done'
```
{:codeblock}

## Supervisión de la réplica

Para buscar todas las tareas de réplica, dirija la salida de `curl` a `jq` y filtre los documentos de la matriz por su campo de tipo.

Para facilitar la selección de la información sobre un proceso de réplica de la lista de tareas activas, inicie el proceso de réplica creando un documento en la base de datos `_replicator` y defina para su campo `_id` un valor conocido.

_Ejemplo de búsqueda de todas las tareas de réplica filtrando por el tipo `replication`:_

```sh
curl -s 'https://username:password@username.cloudant.com/_active_tasks' | jq '.[] | select(.type=="replication")'
```
{:codeblock}

_Ejemplo de búsqueda de una determinada tarea de réplica filtrando por una identidad de documento conocida: _

```sh
curl ... | jq '.[] | select(.doc_id=="ID")'
```
{:codeblock}

_Ejemplo de búsqueda de una determinada tarea de réplica filtrando por un `replication_id` conocido:_

```sh
curl ... | jq '.[] | select(.replication_id=="ID")'
```
{:codeblock}

_Ejemplo de resultado después de buscar una tarea de réplica: _

```json
{
    "started_on": 1371094220,
    "source_seq": "62960-sakdjflksdfjsdlkafjalskdfjlsakfjlasdkjksald",
    "source": "",
    "revisions_checked": 12,
    "continuous": true,
    "doc_id": null,
    "doc_write_failures": 0,
    "docs_read": 12,
    "target": "",
    "type": "replication",
    "updated_on": 1371118477,
    "user": "username",
    "checkpointed_source_seq": "61764-dskfjalsfjsalkfjssadjfhasdfkjhsdkfhsdkf",
    "changes_pending": 1196,
    "pid": "<0.9955.4120>",
    "node": "dbcore@db7.meritage.cloudant.net",
    "docs_written": 12,
    "missing_revisions_found": 12,
    "replication_id": "asfksdlfkjsadkfjsdalkfjas+continuous+create_target"
}
```
{:codeblock}

## Resolución de problemas

### ¿Se ha atascado una tarea?

En el caso de una réplica que no sea continua, en la que la base de datos de origen no se actualiza significativamente durante la réplica, el valor `changes_pending` indica el número de documentos que faltan por procesar.
Esto significa que el valor `changes_pending` es un buen indicador para calcular cuándo terminará la réplica.

En el caso de una réplica continua, interesa más saber cómo cambia en el tiempo el número de documentos procesados y si el valor de `changes_pending` aumenta.
Si `changes_pending` aumenta, pero `revisions_checked` permanece constante durante un rato, es probable que la réplica se haya atascado.
Si `changes_pending` aumenta y `revisions_checked` también aumenta, es probable que la réplica no pueda seguir el ritmo de todo el volumen de datos que se ha añadido o actualizado en la base de datos.

### ¿Qué hay que hacer cuando una tarea se atasca?

Para solucionar una réplica atascada, es posible que tenga que [cancelar el proceso de réplica](../api/replication.html#cancelling-a-replication) e iniciarlo de nuevo.

Si esto no ayuda, es posible que la réplica se haya atascado porque el usuario que accede a las bases de datos de origen o de destino no tenga permisos de escritura.

>   **Nota**: El proceso de réplica utiliza [puntos de comprobación](replication_guide.html#checkpoints).
    Esto significa que el contenido que ya se ha replicado y que no se ha modificado no se tiene que volver a replicar si se reinicia la réplica.

Si ha creado el proceso de réplica mediante la creación de un documento en la base de datos `_replicator`, también puede comprobar allí el estado de la réplica.
