---

copyright:
  years: 2015, 2017
lastupdated: "2018-06-07"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-04-20 -->

<div id="back-up-your-data-using-replication"></div>

# Incrementales de réplica

>	**Nota**: Esta guía contiene información antigua o 'en desuso' sobre la copia de seguridad de {{site.data.keyword.cloudantfull}}.
	Para ver una guía actualizada sobre la copia de seguridad, consulte la guía de [Recuperación en caso de error y copia de seguridad](disaster-recovery-and-backup.html).

Las copias de seguridad de las bases de datos protegen los datos frente a una posible pérdida o daño de los datos.
{:shortdesc}

Puede utilizar el recurso de réplica de {{site.data.keyword.cloudant_short_notm}} para crear una copia de seguridad de la base de datos y guardarla en un clúster de {{site.data.keyword.cloudant_short_notm}}.
Luego puede restaurar datos, bases de datos enteras o documentos JSON específicos desde dichas copias de seguridad en el clúster de producción.

Mediante la réplica de {{site.data.keyword.cloudant_short_notm}},
una copia de seguridad de la base de datos almacena el contenido de la base de datos en un punto de comprobación.
Es posible 'retrotraerse' a un determinado punto de comprobación.
El punto de comprobación no es específico de un momento en concreto.
Es un registro de la base de datos tal como estaba después de que se produjeran cambios específicos durante el periodo de copia de seguridad.
De este modo, una copia de seguridad puede conservar el estado de la base de datos en un momento seleccionado.

## Copias de seguridad incrementales

Si es un cliente de empresa, [dispone](disaster-recovery-and-backup.html) de la función de copia de seguridad incremental diaria.

Si no es un cliente de empresa, o si prefiere crear sus propias copias de seguridad, puede utilizar el recurso de réplica de {{site.data.keyword.cloudant_short_notm}} para crear una copia de seguridad de la base de datos.

Un enfoque sencillo consiste es crear una réplica de toda la base de datos en una base de datos de copia de seguridad.
Este método funciona y es muy sencillo.
Peri si necesita copias de seguridad correspondientes a varios puntos en el tiempo, como por ejemplo siete copias de seguridad diarias y cuatro semanales, debe almacenar una copia completa de la base de datos en cada nueva base de datos de copia de seguridad.
Una copia completa puede requerir un uso de disco significativo, especialmente si la base de datos es grande.

Como alternativa, las copias de seguridad incrementales constituyen una buena solución para almacenar solo los documentos que han cambiado desde la última copia de seguridad.

El proceso es sencillo.
Inicialmente, debe crear una copia de seguridad de toda la base de datos.
Tras la primera copia de seguridad, ejecute copias de seguridad 'incrementales' copiando _solo_ lo que se ha modificado en la base de datos desde la última copia de seguridad.
Esta réplica se convierte en una copia de seguridad diaria.

>   **Nota**: Puede configurar que se active una copia de seguridad a intervalos regulares.
    Sin embargo, cada intervalo debe ser de 24 horas o más.
    Es decir, puede ejecutar copias diarias, pero no copias cada hora.

## Creación de una copia de seguridad incremental

Las copias de seguridad incrementales solo guardan las diferencias o 'deltas' entre copias de seguridad.
Cada 24 horas, se realiza una réplica de la base de datos de origen en una base de datos de destino.

La réplica utiliza valores de secuencia para identificar los documentos que se han modificado durante el periodo de 24 horas.
La operación de copia de seguridad funciona mediante el uso de la réplica para obtener y almacenar un punto de comprobación.
Un punto de comprobación es otro documento con un nombre interno.
La operación de copia de seguridad crea el nombre a partir de una combinación de la fecha y el nombre de la tarea de copia de seguridad.
Este nombre facilita la identificación de puntos de comprobación durante los procesos de recuperación o acumulación.

Para crear una copia de seguridad incremental, siga los pasos siguientes:

1.  Busque el ID del documento de punto de comprobación correspondiente a la última réplica.
    Está guardado en el campo `_replication_id` del documento de réplica que se encuentra en la base de datos `_replicator`.
2.  Abra el documento de punto de comprobación de `/$DATABASE/_local/$REPLICATION_ID`, donde
`$REPLICATION_ID` es el ID que ha encontrado en el paso anterior y `$DATABASE` es el nombre de la base de datos de origen o de destino.
    El documento suele existir en ambas bases de datos, pero es posible que solo esté en una.
3.  Busque el campo `recorded_seq` del primer elemento de la matriz histórica que se encuentra en el documento de punto de comprobación.
4.  Cree una réplica en la nueva base de datos de copia de seguridad incremental,
    estableciendo el [campo `since_seq`](../api/replication.html#the-since_seq-field)
    del documento de réplica en el valor del campo `recorded_seq` del paso anterior.

>   **Nota**: Por definición, el uso de la opción `since_seq` omite el recurso normal de establecimiento de un punto de comprobación. Utilice `since_seq` con cuidado. 

## Restauración de una base de datos

Para restaurar una base de datos de copias de seguridad incrementales, debe crear una réplica de cada copia de seguridad incremental en una nueva base, empezando por el incremento más reciente.

Puede empezar por la copia de seguridad más antigua y luego aplicar en orden las siguientes copias de seguridad.
Sin embargo, la réplica empezando por la copia de seguridad incremental más reciente es más rápida porque los documentos actualizados se escriben en la base de datos de destino una sola vez.
Los documentos más antiguos que una copia ya existente en la nueva base de datos se omiten.


## Un ejemplo

En este ejemplo se muestra cómo:

1.  Configurar bases de datos para que utilicen la copia de seguridad incremental.
2.  Ejecutar una copia de seguridad completa.
3.  Configurar y ejecutar una copia de seguridad incremental.
4.  Restaurar una copia de seguridad.

<div id="constants-used-in-this-guide"></div>

### Constantes que se utilizan aquí

```sh
# guardar URL base y el tipo de contenido en variables de shell
$ url='https://$ACCOUNT:$PASSWORD@$ACCOUNT.cloudant.com'
$ ct='Content-Type: application-json'
```
{:codeblock}

Supongamos que tiene que hacer una copia de seguridad de una base de datos.
Desea crear una copia de seguridad completa el lunes y una copia de seguridad incremental el martes.

Puede utilizar los mandatos `curl` y [`jq` ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](http://stedolan.github.io/jq/){:new_window}
para ejecutar estas operaciones.
En la práctica, puede utilizar cualquier cliente
HTTP.

<div id="step-1-check-you-have-three-databases"></div>

### Paso 1: Compruebe que tiene tres bases de datos

Para este ejemplo, necesita tres bases de datos:

-   La base de datos original, que contiene los datos que desea copiar.
-   Dos bases de datos incrementales, una para el lunes (`backup-monday`) y otra para el martes (`backup-tuesday`).

_Ejemplo que muestra cómo comprobar que tiene tres bases de datos para utilizarlas en este ejemplo, utilizando HTTP:_

```http
PUT /original HTTP/1.1
PUT /backup-monday HTTP/1.1
PUT /backup-tuesday HTTP/1.1
```
{:codeblock}

_Ejemplo que muestra cómo comprobar que tiene tres bases de datos para utilizarlas en este ejemplo, utilizando la línea de mandatos:_

```sh
$ curl -X PUT "${url}/original"
$ curl -X PUT "${url}/backup-monday"
$ curl -X PUT "${url}/backup-tuesday"
```
{:codeblock}

### Paso 2: Cree la base de datos `_replicator`

Si no existe, cree la base de datos `_replicator`.

_Creación de la base de datos `_replicator` mediante HTTP:_

```http
PUT /_replicator HTTP/1.1
```
{:codeblock}

_Creación de la base de datos `_replicator` mediante la línea de mandatos:_

```sh
curl -X PUT "${url}/_replicator"
```
{:pre}

### Paso 3: Haga una copia de seguridad de toda la base de datos (original)

El lunes desea hacer una copia de seguridad de todos los datos por primera vez.
Para crear esta copia de seguridad, realice una réplica de todo lo comprendido entre `original` y `backup-monday`.

_Ejecución de una copia de seguridad completa el lunes mediante HTTP:_

```http
PUT /_replicator/full-backup-monday HTTP/1.1
Content-Type: application/json
```
{:codeblock}

_Ejecución de una copia de seguridad completa el lunes mediante la línea de mandatos: _

```sh
$ curl -X PUT "${url}/_replicator/full-backup-monday" -H "$ct" -d @backup-monday.json
# donde backup-monday.json describe la copia de seguridad.
```
{:codeblock}

_Documento JSON que describe la copia de seguridad completa:_
 
```json
{
    "_id": "full-backup-monday",
    "source": "${url}/original",
    "target": "${url}/backup-monday"
}
```
{:codeblock}

<div id="step-4-get-checkpoint-id"></div>

### Paso 4: Prepare la copia de seguridad incremental parte 1 - Obtenga el ID de punto de comprobación

El martes desea realizar una copia de seguridad incremental, en lugar de otra copia de seguridad completa.

Para empezar la copia de seguridad incremental, necesita dos valores:

-   El ID de punto de comprobación.
-   [El valor de `recorded_seq`](#step-5-prepare-incremental-backup-part-2-get-recorded_seq-value).

Estos valores identifican dónde termina la última copia de seguridad y determinan dónde hay que comenzar la siguiente copia de seguridad incremental.
Después de obtener estos valores, puede ejecutar la copia de seguridad incremental.

Comienza buscando el valor del ID de punto de comprobación.
Este valor está guardado en el campo `_replication_id` del documento de réplica que se encuentra en la base de datos `_replicator`.

_Obtención del ID de punto de comprobación para buscar el valor de `recorded_seq` mediante HTTP:_

```http
GET /_replicator/full-backup-monday HTTP/1.1
# Buscar el valor de _replication_id
```
{:codeblock}

_Obtención del ID de punto de comprobación para buscar el valor de `recorded_seq` mediante la línea de mandatos: _

```sh
replication_id=$(curl "${url}/_replicator/full-backup-monday" | jq -r '._replication_id')
```
{:pre}

<div id="step-5-get-recorded_seq-value"></div>

### Paso 5: Prepare la copia de seguridad incremental parte 2 - Obtenga el valor de `recorded_seq`

Después de obtener el ID del punto de comprobación, utilícelo para obtener el valor de `recorded_seq`.
Este valor se encuentra en el primer elemento de la matriz histórica en el documento `/_local/${replication_id}`, dentro de la base de datos original.

Ahora tiene el valor de `recorded_seq`.
Este valor identifica el último documento del que se ha realizado una réplica desde la base de datos original.

_Obtención del valor de `recorded_seq` de la base de datos original mediante HTTP:_

```http
GET /original/_local/${replication_id} HTTP/1.1
# Buscar el primer valor de recorded_seq en la matriz histórica
```
{:codeblock}

_Obtención del valor de `recorded_seq` de la base de datos original mediante la línea de mandatos:_

```sh
recorded_seq=$(curl "${url}/original/_local/${replication_id}" | jq -r '.history[0].recorded_seq')
```
{:pre}

### Paso 6: Ejecute una copia de seguridad incremental

Ahora que tiene el ID de punto de comprobación y `recorded_seq`, puede comenzar copia de seguridad incremental del martes.
Esta copia de seguridad realiza una réplica de todos del documento realizados _desde_ la última réplica.

Cuando finalice la réplica, tendrá una copia de seguridad incremental completa.
La copia de seguridad consta de todos los documentos de la base de datos original y se puede restaurar recuperando el contenido de las bases de datos `backup-monday` _y_ `backup-tuesday`.

_Ejecución de la copia de seguridad incremental del martes mediante HTTP:_

```http
PUT /_replicator/incr-backup-tuesday HTTP/1.1
Content-Type: application/json
```
{:codeblock}

_Ejecución de la copia de seguridad incremental del martes mediante la línea de mandatos: _

```sh
curl -X PUT "${url}/_replicator/incr-backup-tuesday" -H "${ct}" -d @backup-tuesday.json
```
{:pre}

_Documento JSON que describe la copia de seguridad incremental del martes:_
 
```json
{
    "_id": "incr-backup-tuesday",
    "source": "${url}/original",
    "target": "${url}/backup-tuesday",
    "since_seq": "${recorded_seq}"
}
```
{:codeblock}

### Paso 7: Restaure la copia del lunes

Para restaurar los datos de una copia de seguridad, haga una réplica de la copia de seguridad completa inicial y de cualquier copia de seguridad incremental en una nueva base de datos.

Por ejemplo, para restaurar el estado del lunes, debe hacer una réplica de la base de datos `backup-monday`.

_Restauración de los datos de la base de datos `backup-monday` mediante HTTP:_

```sh
PUT /_replicator/restore-monday HTTP/1.1
Content-Type: application/json
```
{:codeblock}

_Restauración de los datos de la base de datos `backup-monday` mediante la línea de mandatos: _

```sh
curl -X PUT "${url}/_replicator/restore-monday" -H "$ct" -d @restore-monday.json
```
{:pre}

_Documento JSON que describe la restauración: _
 
```json
{
    "_id": "restore-monday",
    "source": "${url}/backup-monday",
    "target": "${url}/restore",
    "create_target": true  
}
```
{:codeblock}

### Paso 8: Restaure la copia de seguridad del martes

Para restaurar la base de datos del martes, primero cree una réplica de `backup-tuesday` y luego de `backup-monday`.

>   **Nota**: El orden no es un error tipográfico;
    la idea _es_ restaurar los datos del martes y _luego_ los del lunes.

Puede restaurar en secuencia cronológica, pero, si utiliza el orden inverso, los documentos actualizados el martes solo se tienen que escribir en la base de datos de destino una vez.
Las versiones más antiguas del documento guardadas en la base de datos del lunes se pasan por alto.

_Restauración de la copia de seguridad del martes, obteniendo primero los cambios más recientes, mediante HTTP:_

```http
PUT /_replicator/restore-tuesday HTTP/1.1
Content-Type: application/json
```
{:codeblock}

_Restauración de la copia de seguridad del martes, obteniendo primero los cambios más recientes, mediante la línea de mandatos:_

```sh
curl -X PUT "${url}/_replicator/restore-tuesday" -H "$ct" -d @restore-tuesday.json
```
{:pre}

_Documento JSON que solicita la restauración de la copia de seguridad del martes:_
 
```json
{
    "_id": "restore-tuesday",
    "source": "${url}/backup-tuesday",
    "target": "${url}/restore",
    "create_target": true  
}
```
{:codeblock}

_Finalice la recuperación mediante la restauración, en último lugar, de la copia de seguridad del lunes mediante HTTP:_

```http
PUT /_replicator/restore-monday HTTP/1.1
Content-Type: application/json
```
{:codeblock}

_Finalice la recuperación mediante la restauración, en último lugar, de la copia de seguridad del lunes mediante la línea de mandatos:_

```http
curl -X PUT "${url}/_replicator/restore-monday" -H "$ct" -d @restore-monday.json
```
{:pre}

_Documento JSON que solicita la restauración de la copia de seguridad del lunes:_
 
```json
{
    "_id": "restore-monday",
    "source": "${url}/backup-monday",
    "target": "${url}/restore"
}
```
{:codeblock}

## Sugerencias

Aunque en la información anterior se describe el proceso de copia de seguridad básico, cada aplicación necesita sus propios requisitos y estrategias para copias de seguridad.
Las siguientes sugerencias pueden ser de utilidad.

### Planificación de copias de seguridad

Los trabajos de réplica pueden aumentar significativamente la carga en un clúster.
Si está haciendo copia de seguridad de varias bases de datos, es mejor planificar los trabajos de réplica a distintas horas o en un momento en que el clúster esté menos ocupado.

#### Cambio de la prioridad de ES de una copia de seguridad

Puede cambiar la prioridad de los trabajos de copia de seguridad ajustando el valor del campo `x-cloudant-io-priority` en el documento de réplica.

1.  En los campos de origen y de destino, cambie el objeto `headers`.
2.  En los objetos de cabecera, cambie el valor del campo `x-cloudant-io-priority` por `"low"`.

_Ejemplo de documento JSON que establece la prioridad de ES:_

```json
{
    "source": {
        "url": "https://user:pass@example.com/db",
        "headers": {
            "x-cloudant-io-priority": "low"
        }
    },
    "target": {
        "url": "https://user:pass@example.net/db",
        "headers": {
            "x-cloudant-io-priority": "low"
        }
    }
}
```
{:codeblock}

<div id="design-documents"></div>

### Copia de seguridad de documentos de diseño

Si incluye documentos de diseño en su copia de seguridad, se crean índices en el destino de la copia de seguridad.
Esta práctica ralentiza el proceso de copia de seguridad y utiliza cantidades innecesarias de espacio de disco.
Si no necesita índices en su sistema de copia de seguridad, utilice una función de filtro con sus réplicas para filtrar los documentos de diseño.
También puede utilizar esta función de filtro para excluir otros documentos que no desee.

### Copia de seguridad de varias bases de datos

Si la aplicación utiliza una base de datos por usuario o permite que cada usuario cree varias bases de datos, debe crear un trabajo de copia de seguridad para cada nueva base de datos.
Asegúrese de que los trabajos de réplica no comiencen a la vez.

## ¿Necesita ayuda?

Las réplicas y copias de seguridad pueden ser complicadas.
Si se atasca, consulte la [guía de réplica](replication_guide.html),
o póngase en contacto con el equipo de soporte de
[{{site.data.keyword.cloudant_short_notm}} ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](mailto:support@cloudant.com){:new_window}.
