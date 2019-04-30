---

copyright:
  years: 2019
lastupdated: "2019-03-27"

keywords: database shards, non-partitioned databases, partition key, global query, partition query, create partition database, create partition query index

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

<!-- Acrolinx: 2018-08-17 -->

# Particionamiento de bases de datos
{: #database-partitioning}

La característica de base de datos particionada de {{site.data.keyword.cloudant_short_notm}} está actualmente en modalidad beta. El particionamiento de bases de datos no se debe utilizar para aplicaciones de producción. Esta característica se va a implantar en todos los entornos de
{{site.data.keyword.cloudant_short_notm}} y estará disponible de forma general en las próximas semanas.
{: important}

{{site.data.keyword.cloudantfull}} admite dos tipos de bases de datos:

- Particionadas
- No particionadas

Una base de datos _particionada_ ofrece ventajas significativas en rendimiento y coste, pero requiere que especifique un particionamiento lógico de los datos. Esto se describe más abajo.

Como alternativa, se puede crear una base de datos _no particionada_. Puede resultar más fácil trabajar con este tipo de base de datos, ya que no es necesario definir ningún esquema de particionamiento, pero solo se pueden crear índices secundarios globales.

{{site.data.keyword.cloudant_short_notm}} recomienda encarecidamente que utilice una base de datos particionada para obtener un mejor rendimiento de base de datos a largo plazo siempre que el modelo de datos permita el particionamiento lógico de los documentos.

El tipo de particionamiento de una base de datos se establece en el momento de la creación de la base de datos.  Al crear una base de datos, utilice el parámetro de serie de consulta `partitioned` para establecer si la base de datos se particiona o no. El valor predeterminado de
`partitioned` es `false`, manteniendo la compatibilidad con versiones anteriores.

El tipo de particionamiento no se puede cambiar en una base de datos existente.

## Fragmentos de bases de datos
{: #database-shards}

Antes de leer este documento, debe entender el [concepto de fragmentación](/docs/services/Cloudant?topic=cloudant-how-is-data-stored-in-ibm-cloudant-#how-is-data-stored-in-ibm-cloudant-) dentro de {{site.data.keyword.cloudant_short_notm}}.

## Bases de datos no particionadas
{: #non-partitioned-databases}

Una base de datos no particionada es el tipo más antiguo de base de datos de {{site.data.keyword.cloudant_short_notm}}, y el que le resultará más familiar si ha utilizado CouchDB o {{site.data.keyword.cloudant_short_notm}} con anterioridad.

Dentro de una base de datos no particionada, los documentos se distribuyen en fragmentos de forma arbitraria basándose en una transformación de su ID de documento. Por lo tanto, no existe una relación real entre el ID de un documento y el fragmento en el que acaba. No es probable que documentos con ID de documento muy parecidos se ubiquen en el mismo fragmento.

Una base de datos no particionada ofrece únicamente consultas globales, lo cual se describe con mayor detalle a continuación.

## Bases de datos particionadas
{: #partitioned-databases}

Una base de datos particionada es el tipo más nuevo de base de datos de {{site.data.keyword.cloudant_short_notm}}. Dentro de una base de datos particionada, se da forma a los documentos en particiones lógicas mediante el uso de una _clave de partición_, que forma parte del ID de documento de los documentos que hay en las bases de datos particionadas. Todos los documentos se asignan a una partición, y normalmente hay muchos documentos que reciben la misma clave de partición. Los datos JSON primarios de una partición y sus índices acaban siendo ubicados en el mismo lugar, lo que implica que la base de datos puede consultar los datos de una partición con mayor eficiencia.

Una base de datos particionada ofrece consultas tanto particionadas como globales. Las consultas particionadas aprovechan el diseño de los datos dentro del clúster de bases de datos para proporcionar un rendimiento de consulta mejorado y más escalable. Además, las consultas de partición suelen tener un coste menor que las consultas globales.

Ya que las bases de datos particionadas ofrecen las ventajas de las consultas tanto globales como de partición,
{{site.data.keyword.cloudant_short_notm}} recomienda que las nuevas aplicaciones aprovechen dichas ventajas.

## ¿Cuál es una buena clave de partición?
{: #what-makes-a-good-partition-key-}

Si piensa utilizar la nueva característica de *base de datos particionada* de
{{site.data.keyword.cloudant_short_notm}}, la elección de una clave de partición es muy importante. Una clave de partición debe tener:

- Muchos valores: es mejor tener muchas particiones pequeñas que unas pocas grandes.
- Ninguna zona activa: evite diseñar un sistema que haga que una partición maneje una proporción alta de la carga de trabajo. Si el trabajo se distribuye uniformemente entre las particiones, la base de datos funcionará de manera más fluida.
- Repetición: si cada clave de partición es única, solo habrá un documento por partición. Para sacar el máximo partido de las bases de datos particionadas, deben existir varios documentos por partición (documentos agrupados de forma lógica).

Veamos algunos casos de uso y algunas elecciones buenas y malas para una clave de partición.

| Caso de uso                   | Descripción                 | Clave de partición | Eficacia                                                                                                  |
|----------------------------|-----------------------------|---------------|------------------------------------------------------------------------------------------------------------------|
| Sistema de comercio electrónico - pedidos | Un documento por pedido     | order_id      | Neutral - un documento por partición está bien, pero no ofrece las ventajas de las consultas de partición.          |
| Sistema de comercio electrónico - pedidos | Un documento por pedido     | user_id       | Buena - todos los pedidos de un usuario se agruparán conjuntamente.                                                             |
| Sistema de comercio electrónico - pedidos | Un documento por pedido      | status        | Mala - la agrupación de pedidos mediante algunos valores de estado (provisional, pagado, reembolsado, cancelado) creará muy pocas particiones de gran tamaño.  |
| Plataforma de blogs          | Un documento por publicación de blog | author_id     | Buena - siempre que existan muchos autores. Es fácil consultar las publicaciones de cada autor.                                     |
| IOT - lecturas de sensor      | Un documento por lectura    | device_id     | Buena - si existen muchos dispositivos. Asegúrese de que un dispositivo no produzca muchas más lecturas que los demás. |
| IOT - lecturas de sensor      | Un documento por lectura    | date          | Mala - las lecturas actuales provocarán una "zona activa" en la partición de la fecha actual.                                  |

Hay algunos casos de uso en los que no hay una opción viable para la clave de partición.
En estas situaciones, es probable que una base de datos no particionada sea la mejor opción, por ejemplo, una base de datos de usuarios que almacena direcciones de correo electrónico, hashes de contraseña y fechas del último inicio de sesión. Ninguno de estos campos es lo suficientemente bueno para constituir una clave de partición adecuada, por lo que debe utilizarse una base de datos no particionada normal en su lugar.

## Consultas
{: #querying}

En esta sección se describe cuáles de los tipos de consulta de {{site.data.keyword.cloudant_short_notm}} están disponibles para las consultas globales y de partición, junto con una breve visión general del mecanismo de consulta subyacente para permitirle seleccionar qué mecanismo de consulta es mejor para cada consulta que necesite realizar su aplicación.

### Consultas globales
{: #global-querying}

Puede realizar consultas globales a los tipos de índice siguientes:

- Consulta de {{site.data.keyword.cloudant_short_notm}}
- Vistas
- Búsqueda
- Zona geográfica

Al realizar una consulta global, la base de datos debe realizar una operación de dispersión-reunión de todos los datos de la base de datos. Esto implica realizar solicitudes a muchos servidores de bases de datos individuales. El nodo de coordinación de la API recibe las respuestas de todos estos servidores y las combina para formar una única respuesta para el cliente. Esto podría implicar el almacenamiento intermedio de los datos y el retraso de la respuesta al cliente si, por ejemplo, los datos requieren ordenación.

### Consultas de partición
{: #partition-querying}

Puede realizar consultas de partición a los tipos de índice siguientes:

- Consulta de {{site.data.keyword.cloudant_short_notm}}
- Vistas
- Búsqueda

Al realizar una consulta de partición, la base de datos puede consultar únicamente los datos dentro de una partición individual. Debido a que los datos de una partición residen en solo un fragmento (con tres réplicas), el nodo de coordinación de la API puede realizar una solicitud directamente a los servidores que alojan dichos datos en lugar de tener que combinar las respuestas de muchos servidores. Tampoco tiene que almacenar la respuesta en almacenamiento intermedio, ya que no hay que llevar a cabo ningún paso de combinación. Por lo tanto, los datos llegan al cliente de manera más rápida.

Además, a medida que aumenta el tamaño de una base de datos, deberá aumentar el número de fragmentos. Esto hace que aumente directamente el número de consultas que el nodo de coordinación de la API debe realizar a los servidores que alojan los datos al utilizar consultas globales. No obstante, cuando se utilizan consultas de partición, el número de fragmentos no tiene efecto sobre el número de servidores con los que el nodo de coordinación de la API necesita ponerse en contacto. Siempre que este número siga siendo pequeño, el aumento del tamaño de datos no tendrá efecto en la latencia de consulta, a diferencia de lo que ocurre con las consultas globales.

## Ejemplo: particionamiento de datos de lectura de IoT
{: #example-partitioning-iot-reading-data}

Este debate es muy abstracto; hagámoslo más concreto con un ejemplo. Tomaremos el dominio de
Internet de las cosas y utilizaremos {{site.data.keyword.cloudant_short_notm}} como recopilación de datos para las lecturas de dispositivo. Digamos que los dispositivos proporcionan lecturas de sensor sobre elementos de infraestructura como carreteras o puentes.

Supondremos que:

- Cientos o miles de dispositivos notifican lecturas.
- Cada dispositivo tiene un ID exclusivo.
- Cada elemento de infraestructura tiene un ID exclusivo.
- Los dispositivos no se mueven entre elementos de infraestructura.
- Cada dispositivo escribe una lectura en {{site.data.keyword.cloudant_short_notm}} cada 10 segundos. Probablemente, esto se proporcione a través de un bus de mensajes a {{site.data.keyword.cloudant_short_notm}}.

En una base de datos no particionada, puede permitir que {{site.data.keyword.cloudant_short_notm}} genere los ID de documento. Otra alternativa es definir el nombre de los documentos mediante el ID de dispositivo y la indicación de fecha y hora de registro.

Utilizando el segundo enfoque, hemos terminado con ID de documento similares a los siguientes:

```
device-123456:20181211T11:13:24.123456Z
```

La indicación de fecha y hora también puede ser una indicación de fecha y hora de epoch.

Este enfoque permitiría que los datos de cada dispositivo se consulten de manera eficiente utilizando índices particionados, pero es posible que se tengan que utilizar índices globales para crear vistas de varios dispositivos (por ejemplo, todos los dispositivos en un elemento de infraestructura determinado).

Para fines ilustrativos, hagamos el caso de ejemplo un poco más complicado suponiendo que la aplicación necesita principalmente leer todos los datos de sensor de un elemento de infraestructura determinado en lugar de los datos de dispositivos individuales.

En esta aplicación, queremos consultar por elemento de infraestructura para mejorar la eficacia, por lo que particionar los datos por elemento de infraestructura tiene mucho más sentido que hacerlo por ID. Esto permitiría que todos los dispositivos para un elemento de infraestructura determinado se puedan consultar eficientemente como un grupo.

Para las consultas infrecuentes por dispositivo, existen dos enfoques:

1. Crear un índice global con clave para cada dispositivo y consultarlo. Esto es más eficiente si las consultas a dispositivos individuales son poco frecuentes y no se repiten.
2. Crear un índice global que correlacione dispositivo e infraestructura y, a continuación, emitir consultas de partición para la partición de infraestructura. Esto tiene sentido si se utilizan consultas repetidas a dispositivos determinados, ya que la correlación se puede almacenar en memoria caché; supondremos que este es el caso de nuestra aplicación.

Veamos cómo funciona esto. Veremos cuatro consultas:

1. Lecturas de todos los tiempos para un elemento de infraestructura.
1. Lecturas de hoy para un elemento de infraestructura.
1. Lecturas de todos los tiempos para un dispositivo específico.
1. Lecturas de hoy para un dispositivo específico.

### Creación de la base de datos
{: #creating-the-database}

Utilizaremos una base de datos denominada `readings` y una cuenta denominada
`acme`. Para crearla como una base de datos particionada, pase `true` como argumento
`partitioned` a la solicitud de creación de la base de datos:

```
curl -XPUT 'https://acme.cloudant.com/readings?partitioned=true'
```

### Estructura del documento
{: #document-struture}

En primer lugar, vamos a definir un formato de documento simple con el que trabajar:

```json
{
    "deviceID": "device-123456",
    "infrastructureID": "bridge-9876",
    "ts": "20181211T11:13:24.123456Z",
    "reading": {
        "temperature": {"value": 12, "unit": "c"}
    }
}
```

Para este documento, utilizando el esquema de particionamiento según el elemento de infraestructura, el ID de documento puede incluir el ID de infraestructura como clave de partición, e incluir tanto el dispositivo como la indicación de fecha y hora como clave de documento:

```
bridge-9876:device-123456-20181211T11:13:24.123456Z
```

### Creación de índices
{: #creating-indexes}

Para las consultas anteriores, necesitaremos dos índices:

1. Un índice global que correlaciona ID de dispositivo con ID de infraestructura.
2. Un índice particionado que correlaciona ID de dispositivo con lecturas.

#### Creación de un índice de vista global
{: #creating-a-global-view-index}

Un índice de vista es la manera más eficiente de establecer la correlación simple entre ID de dispositivo e ID de infraestructura. Para definirlo, cargue un documento de diseño con
`options.partitioned` establecido en `false`, ya que este índice es global. Aunque en una función
`map` real es recomendable proteger mejor la existencia de los campos, esta tendría un aspecto similar al siguiente:

```json
{
    "_id": "_design/infrastructure-mapping",
    "options": {"partitioned": false},
    "views": {
        "by-device": {
            "map": "function(doc) { emit(doc.deviceID, doc.infrastructureID) }"
        }
    }
}
```

Suponiendo que el documento anterior está en `./view.json`, se carga en la base de datos utilizando:

```
curl -XPOST https://acme.cloudant.com/readings -d @view.json
```

#### Creación de un índice de consulta de {{site.data.keyword.cloudant_short_notm}} particionado
{: #creating-a-paritioned-ibm-cloudant-query-index}

Para devolver las lecturas para un dispositivo determinado de una partición, podemos utilizar un índice de consulta de
{{site.data.keyword.cloudant_short_notm}}. Para este índice, utilizaremos `POST` para `_index` con una definición de índice que incluye el campo `partitioned` establecido en `true`. 

En las definiciones de índice de consulta, el campo `partitioned` no se anida dentro de un objeto `options`.
{: note}

En nuestras consultas, necesitaremos dos índices particionados:

1. Por indicación de fecha y hora
2. Por ID de dispositivo e indicación de fecha y hora

La definición del índice por indicación de fecha y hora es la siguiente:

```json
{
   "index": {
      "fields": [
         "ts"
      ]
   },
   "name": "timestamped-readings",
   "type": "json",
   "partitioned:" true
}
```

Suponiendo que el documento anterior es `./query-index1.json`, cargue el índice en la base de datos utilizando este mandato:

```
curl -XPOST https://acme.cloudant.com/readings/_index -d @query-index1.json
```

La definición del índice por ID de dispositivo e indicación de fecha y hora es la siguiente:

```json
{
   "index": {
      "fields": [
         "deviceID",
         "ts"
      ]
   },
   "name": "deviceID-readings",
   "type": "json",
   "partitioned:" true
}
```

Suponiendo que el documento anterior es `./query-index2.json`, cargue el índice en la base de datos utilizando este mandato:

```
curl -XPOST https://acme.cloudant.com/readings/_index -d @query-index2.json
```

### Realización de consultas
{: #making-queries}

En total, queremos realizar cuatro consultas:

1. Lecturas de todos los tiempos para un elemento de infraestructura.
1. Lecturas de hoy para un elemento de infraestructura.
1. Lecturas de todos los tiempos para un dispositivo específico.
1. Lecturas de hoy para un dispositivo específico.

#### Encontrar todas las lecturas para un elemento de infraestructura
{: #finding-all-readings-for-a-piece-of-infrastructure}

Debido a que nuestras particiones se basan en la infraestructura, podemos utilizar
`_all_docs` para una partición. Por ejemplo, para consultar todas las lecturas para el elemento de infraestructura
`bridge-1234`:

```
curl -XGET \
    'https://acme.cloudant.com/readings/_partition/bridge-1234/_all_docs?include_docs=true'
```

#### Encontrar lecturas recientes para un elemento de infraestructura
{: #finding-recent-readings-for-a piece-of-infrastructure}

Esta consulta necesita utilizar el índice `timestamped-readings` particionado. Podemos emitir una consulta a la partición para obtener las lecturas de hoy:

_query.json, suponiendo que hoy es 13 de diciembre de 2018:_

```json
{
    "selector": {
        "ts": { "$gte": "20181213"}
    }
}
```

La partición se incorpora en la vía de acceso HTTP al emitir la solicitud a
{{site.data.keyword.cloudant_short_notm}}:

```
curl -XPOST \
    'https://acme.cloudant.com/readings/_partition/bridge-1234/_find' \
    -d @query.json
```

#### Encontrar el ID de infraestructura de un dispositivo
{: #finding-the-infrastructure-id-for-a-device}

Las dos consultas que nos quedan por realizar son:

1. Lecturas de todos los tiempos para un dispositivo específico.
2. Lecturas de hoy para un dispositivo específico.

En estas dos consultas, necesitamos encontrar la partición de los dispositivos utilizando el índice
`by-device` global. A continuación, podemos consultar la partición individual para las lecturas. Aunque podemos haber utilizado un índice global para consultar las lecturas de dispositivos individuales, la correlación de dispositivo a ID de infraestructura es muy adecuada para su almacenamiento en memoria caché (no cambia nunca), por lo que este enfoque nos permite utilizar principalmente la consulta particionada más eficiente y menos costosa para la mayoría de las solicitudes.

El uso de un índice global para consultar directamente las lecturas de dispositivo puede ser más eficiente si el almacenamiento en memoria caché de la correlación entre dispositivo e infraestructura no funciona bien para una aplicación determinada.

Para encontrar la partición adecuada para un dispositivo, consultaremos la vista
`by-device`, enviando el ID de dispositivo como clave:

```
curl -XGET \
  'https://acme.cloudant.com/readings/_design/infrastructure-mapping/_view/by-device?keys=["device-123456"]&limit=1'
```

Esto devuelve:

```json
{"total_rows":5,"offset":0,"rows":[
{
    "id":"bridge-9876:device-123456-20181211T11:13:24.123456Z",
    "key":"device-123456",
    "value":"bridge-9876"
}
]}
```

Tenemos nuestra clave de partición en el campo `value` de la fila incluida: `bridge-9876`.

#### Consultar todos los resultados de un dispositivo
{: #querying-for-all-results-for-a-device}

Para obtener los resultados de un dispositivo, emitiremos una consulta de partición para el dispositivo dentro de la partición
`bridge-9876`. Se utiliza un selector de consulta de {{site.data.keyword.cloudant_short_notm}} estándar, como si se emitiera una consulta global.

_query.json:_

```json
{
   "selector": {
      "deviceID": {
         "$eq": "device-123456"
      }
   }
}
```

La partición se incorpora en la vía de acceso HTTP al emitir la solicitud a
{{site.data.keyword.cloudant_short_notm}}:

```
curl -XPOST \
    'https://acme.cloudant.com/readings/_partition/bridge-1234/_find' \
    -d @query.json
```

#### Consultar los resultados recientes de un dispositivo
{: #querying-for-recent-results-for-a-device}

Para obtener los resultados de un dispositivo, emitiremos una consulta de partición para el dispositivo dentro de la partición
`bridge-9876`. El selector es solo ligeramente más complicado, pero sigue siendo el mismo que para una consulta global equivalente.

_query.json, suponiendo que hoy es 13 de diciembre de 2018:_

```json
{
   "selector": {
      "deviceID": {
         "$eq": "device-123456"
      },
      "ts": {
         "$gte": "20181213"
      }
   }
}
```

La partición se incorpora en la vía de acceso HTTP al emitir la solicitud a
{{site.data.keyword.cloudant_short_notm}}:

```
curl -XPOST \
    'https://acme.cloudant.com/readings/_partition/bridge-1234/_find' \
    -d @query.json
```
