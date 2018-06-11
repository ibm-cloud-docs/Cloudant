---

copyright:
  years: 2017, 2018
lastupdated: "2017-11-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-05-04 -->

# Novedades de {{site.data.keyword.cloudant_short_notm}}

Manténgase al día en cuanto a cambios y actualizaciones de {{site.data.keyword.cloudantfull}}.
{:shortdesc}

## Hardware dedicado

Está disponible una nueva [instancia de servicio dedicado](bluemix.html#dedicated-plan).

## Build 6233

- Incorpora un nuevo planificador de réplica.
  Además de las ventajas en cuanto a rendimiento y los puntos finales adicionales, el planificador cambia la forma en que se supervisa y se notifica el estado de la réplica.
  En particular,
ya no se da soporte al registro de actualizaciones de estado en un documento de réplica.
  Para obtener más información sobre este importante cambio, consulte los detalles sobre el [planificador de réplica](../api/advanced_replication.html#the_replication_scheduler).
  Póngase en contacto con el equipo de soporte de {{site.data.keyword.cloudant_short_notm}} abriendo una incidencia desde el panel de control de {{site.data.keyword.cloudant_short_notm}} si tiene alguna duda.

## Build 6069

- Anteriormente, un trabajo de réplica que caía por cualquier motivo daba lugar a una actualización del documento de réplica, seguido de un nuevo intento de iniciar una nueva réplica.
  Bajo algunas circunstancias, este comportamiento podía continuar indefinidamente: muchos duplicados del mismo mensaje de error.
  Se ha incorporado un arreglo para que el documento de réplica no se actualice a menos que haya cambiado el motivo del error.
- Si el documento de diseño pensado para especificar un índice geoespacial no es válido, un intento de recuperar información sobre el índice mediante el [punto final `_geo_info`](../api/cloudant-geo.html#obtaining-information-about-a-cloudant-geo-index) da lugar a una respuesta [HTTP `404`](http.html#404).
- Se ha añadido soporte del operador [`$allmatch`](../api/cloudant_query.html#the-allmatch-operator).

## Build 5834

- Ahora la longitud máxima de un documento `id` es 7168 caracteres (7k).

## Build 5728

- {{site.data.keyword.cloudant_short_notm}} es más tolerante a documentos de usuario mal formados almacenados en la base de datos `_users`.
  Los documentos de usuario se deben estructurar y llenar de modo que cumplan con los [requisitos de Apache Software Foundation CouchDB ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](http://docs.couchdb.org/en/2.0.0/intro/security.html#users-documents){:new_window}.

## Build 5638

-   Incorpora nuevos parámetros de consulta "stable" y "update" para vistas.
-   El replicador ya no reintenta indefinidamente si no puede escribir puntos de comprobación en la base de datos de origen.

## Build 5421

-	Los canales de alimentación de cambios dan soporte a filtros basados en vistas.
-	Los canales de alimentación de cambios dan soporte al filtro `_doc_ids`.
-	Las solicitudes `POST` reciben soporte para `_changes`.
-	Tanto `_all_docs` como `_changes` dan soporte al parámetro `attachments=true`.
-	Soporte para las características de base de datos de CouchDB 1.6 `_users`, incluida la función hash del servidor de contraseñas cuando se crean documentos en la base de datos `_users`.
-	Punto final `/_bulk_get` para reducir el número de solicitudes utilizadas en la réplica en clientes móviles.
-	Los metadatos de los documentos de diseño contienen el campo `update pending`.
-	{{site.data.keyword.cloudant_short_notm}} Query ya no devuelve un error si no existe ningún índice válido.

### Cambios en el comportamiento y en las interrupciones

Tareas activas

-   Las entradas de indexador de la respuesta `_active_tasks` ya no notifican el campo `user`.
-   Las entradas del indexador de búsqueda de la respuesta `_active_tasks` ya no notifican el campo `user`.

Vistas

-   La normalización Unicode de valores de claves es coherente entre los resultados de vistas reducidas y no reducidas. Si se especifica la ordenación sin formato en un documento de diseño, el orden de los resultados puede cambiar como resultado de este arreglo.
-   Cuando se consulta una vista o base de datos `_all_docs`, constituye un error especificar el parámetro `keys` y cualquiera de los parámetros `key`, `startkey` y `endkey`.
-   Constituye un error pasar los parámetros `startkey` y `endkey` a una vista si ninguna fila puede coincidir. Por ejemplo, si el parámetro `startkey` es superior al parámetro `endkey` para `descending=false`, o si el parámetro `startkey` es inferior al parámetro `endkey` para `descending=true`, {{site.data.keyword.cloudant_short_notm}} devuelve el error `400 Solicitud errónea`.
-   Si se ha configurado `dbcopy` en un documento de vista, se transforma automáticamente en el campo `options` en un documento de diseño. 

Documentos de diseño

-   Validación más estricta de los documentos de diseño. No se espera que esta validación cause problemas con los documentos de diseño existentes, pero los documentos de diseño mal formados no se pueden guardar.
-   Las vistas que se escriben en un lenguaje no admitido responden con el `error` `unknown_query_language`. Anteriormente, la respuesta era una `razón` de `unknown_query_language`.
-   Cuando se utiliza un reductor de nulos para colocar un documento de diseño de base de datos, el sistema responde con la razón del error `'(null)'`; anteriormente devolvía `((new String("null")))`.
-   Si se especifica `updates` en un documento de diseño, no debe tener un valor nulo.

Autenticación

-   Los metadatos de `_session` `authentication_handlers` ya no contienen `["delegated", "local"]`.

Documentos de usuario

-   Validación de la estructura de documentos de usuario creados en la base de datos `_users`. Después de la actualización DBNext, los documentos de usuario deben cumplir con los requisitos de ASF CouchdDB. Anteriormente, {{site.data.keyword.cloudant_short_notm}} no validaba la estructura de los documentos de usuario. 

Réplica 

-   Los documentos de réplica conservan el último mensaje de error en campo JSON `_replication_state_reason`. El campo se mantiene incluso después de que se reinicie la réplica y esté en el estado `triggered`. Este cambio ayuda al código a detectar e impedir que se escriba repetidamente el mismo error en el documento.
-   Un error producido durante la réplica no actualiza el documento de réplica a menos que cambie el motivo del error. Anteriormente, cuando se producía un error durante la réplica, se iniciaba un bucle infinito que generaba fragmentos grandes.  

Conjunto de resultados

-   El punto final `_db_updates` devuelve un conjunto de resultados que contiene una clave llamada `db_name`. Anteriormente, devolvía un conjunto de resultados con una clave denominada `dbname`.
-   Definición de la longitud máxima del ID de documento. Anteriormente, no se podía definir una longitud máxima de ID de documento.

`dbcopy`

- La característica `dbcopy` puede causar problemas bajo ciertas circunstancias.
  La información sobre la característica se ha eliminado de la documentación.
  Se recomienda encarecidamente no utilizar `dbcopy`.
