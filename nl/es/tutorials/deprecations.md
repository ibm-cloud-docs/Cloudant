---

copyright:
  years: 2017
lastupdated: "2017-07-12"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-07-12 -->

# Cambios en el comportamiento y en las interrupciones

En este documento se resumen los cambios en el comportamiento de los releases de Cloudant. {:shortdesc}

## Incompatibilidad entre CouchDB versión 1.6 y Cloudant versión 2.0.0

-   Existe una incompatibilidad entre la versión más reciente de Cloudant y la base de código basada en CouchDB 1.6. En la  
versión antigua de Cloudant, si se añade un parámetro de consulta ("reduce=false") al cuerpo de la solicitud, el parámetro del cuerpo de la solicitud se pasa por alto mientras que el parámetro del URL de la solicitud se respeta. En las versiones recientes de Cloudant, el parámetro de consulta ("reduce=false") del cuerpo de la solicitud no se pasa por alto. 

## Mensaje de error revisado

- El mensaje de error que se genera cuando se intenta colocar un documento adjunto con una revisión que no existe se ha cambiado por un error 409 con la siguiente información:

	```
	{"error":"not_found","reason":"missing_rev"}
	```

## X-Frame-Options

El valor `X-Frame-Options` es una cabecera de respuesta que controla si una respuesta HTTP se puede incorporar en `<frame>`, `<iframe>` o `<object>`. Esta característica de seguridad ayuda a evitar el "clickjacking" (secuestro de clic).

Puede configurar esta opción en función de sus valores de CORS. Si CORS está habilitado, el valor `X-Frame-Options` se habilita automáticamente y envía de forma predeterminada la cabecera de respuesta `X-Frame-Options: DENY`. Si una cabecera HOST de una solicitud coincide con el URL que aparece en la sección origins de CORS, se devuelve una cabecera de respuesta `X-Frame-Options: ALLOW-FROM URL`.  
 
Este cambio puede afectar a los clientes que acceden a la base de datos directamente desde el navegador. Si ve el mensaje de error "X-Frame-Options: DENY",
e interrumpe el servicio, debe habilitar CORS, [Definiendo la configuración de CORS](../api/cors.html#setting-the-cors-configuration). Después de habilitar CORS, añada el valor de la cabecera HOST que envía en la solicitud a la lista de valores `origins` permitidos.

## Tareas activas

-   Las entradas de indexador de la respuesta `_active_tasks` ya no notifican el campo `user`. 
-   Las entradas del indexador de búsqueda de la respuesta `_active_tasks` ya no notifican el campo `user`. 

## Vistas

-   La normalización Unicode de valores de claves es coherente entre los resultados de vistas reducidas y no reducidas. Si se especifica la ordenación sin formato en un documento de diseño, el orden de los resultados puede cambiar como resultado de este arreglo. 
-   Cuando se consulta una vista o base de datos `_all_docs`, constituye un error especificar el parámetro `keys` y cualquiera de los parámetros `key`, `startkey` y `endkey`. 
-   Constituye un error pasar los parámetros `startkey` y `endkey` a una vista si ninguna fila puede coincidir. Por ejemplo, si el parámetro `startkey` es superior al parámetro `endkey` para `descending=false`, o si el parámetro `startkey` es inferior al parámetro `endkey` para `descending=true`, Cloudant devuelve el error `400 Solicitud errónea`. 
-   Si se ha configurado `dbcopy` en un documento de vista, se transforma automáticamente en el campo `options` en un documento de diseño.  

## Documentos de diseño

-   Validación más estricta de los documentos de diseño. No se espera que esta validación cause problemas con los documentos de diseño existentes, pero los documentos de diseño mal formados no se pueden guardar. 
-   Las vistas que se escriben en un lenguaje no admitido responden con el `error` `unknown_query_language`. Anteriormente, la respuesta era una `razón` de `unknown_query_language`.
-   Cuando se utiliza un reductor de nulos para colocar un documento de diseño de base de datos, el sistema responde con la razón del error `'(null)'`; anteriormente devolvía `((new String("null")))`.
-   Si se especifica `updates` en un documento de diseño, no debe tener un valor nulo.

## Autenticación

-   Los metadatos de `_session` `authentication_handlers` ya no contienen `["delegated", "local"]`.

## Documentos de usuario

-   Validación de la estructura de documentos de usuario creados en la base de datos `_users`. Después de la actualización DBNext, los documentos de usuario deben cumplir con los requisitos de ASF CouchdDB. Anteriormente, Cloudant no validaba la estructura de los documentos de usuario. 

## Réplica 

-   Los documentos de réplica conservan el último mensaje de error en campo JSON `_replication_state_reason`. El campo se mantiene incluso después de que se reinicie la réplica y esté en el estado `triggered`. Este cambio ayuda al código a detectar e impedir que se escriba repetidamente el mismo error en el documento. 
-   Un error producido durante la réplica no actualiza el documento de réplica a menos que cambie el motivo del error. Anteriormente, cuando se producía un error durante la réplica, se iniciaba un bucle infinito que generaba fragmentos grandes.   

## Conjunto de resultados

-   El punto final `_db_updates` devuelve un conjunto de resultados que contiene una clave llamada `db_name`. Anteriormente, devolvía un conjunto de resultados con una clave denominada `dbname`.
-   Definición de la longitud máxima del ID de documento. Anteriormente, no se podía definir una longitud máxima de ID de documento.

## `dbcopy`

- La característica `dbcopy` puede causar problemas bajo ciertas circunstancias. La información sobre la característica se ha eliminado de la documentación. Se recomienda encarecidamente no utilizar `dbcopy`. 
