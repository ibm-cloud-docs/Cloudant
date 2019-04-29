---

copyright:
  years: 2015, 2019
lastupdated: "2019-03-18"

keywords: connect to ibm cloudant, http api, json, distributed systems, replication

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

# Aspectos básicos de {{site.data.keyword.cloudant_short_notm}}
{: #ibm-cloudant-basics}

Si es la primera vez que utiliza este producto, lea detenidamente esta sección antes de continuar.
{: shortdesc}

Para entender la información de los temas siguientes, supondremos que tiene algunas nociones básicas acerca de {{site.data.keyword.cloudantfull}}: 

- [Bibliotecas de cliente](/docs/services/Cloudant?topic=cloudant-client-libraries#client-libraries)
- [Referencia de API](/docs/services/Cloudant?topic=cloudant-api-reference-overview#api-reference-overview)
- [Guías](/docs/services/Cloudant?topic=cloudant-authorized-curl-acurl-#authorized-curl-acurl-)

## Conexión a {{site.data.keyword.cloudant_short_notm}}
{: #connecting-to-ibm-cloudant}

Para acceder a {{site.data.keyword.cloudant_short_notm}}, debe disponer de una cuenta de [{{site.data.keyword.cloudant_short_notm}}](/docs/services/Cloudant?topic=cloudant-account#account), o [{{site.data.keyword.cloud}}](/Cloudant?topic=cloudant-ibm-cloud-public#ibm-cloud-public).

## API HTTP
{: #http-api}

Todas las solicitudes destinadas a {{site.data.keyword.cloudant_short_notm}} pasan por la web.
Esto significa que cualquier sistema que se puede comunicar con la web, se puede comunicar con {{site.data.keyword.cloudant_short_notm}}.
Todas las bibliotecas específicas de lenguaje para {{site.data.keyword.cloudant_short_notm}} son en realidad derivadores que proporcionan comodidad y sutilezas lingüísticas que le ayudarán a trabajar con una simple API.
Muchos usuarios optan por utilizar directamente bibliotecas HTTP para trabajar con {{site.data.keyword.cloudant_short_notm}}.

Para obtener más información sobre el modo en que {{site.data.keyword.cloudant_short_notm}} utiliza HTTP, consulte
[HTTP ](/docs/services/Cloudant?topic=cloudant-http#http) en la referencia de API.

{{site.data.keyword.cloudant_short_notm}} admite los siguientes métodos de solicitud HTTP:

-   `GET`

    Solicitar el elemento especificado.
    Al igual que sucede con las solicitudes HTTP normales, el formato del URL define lo que se devuelve.
    Con {{site.data.keyword.cloudant_short_notm}} esto puede incluir elementos estáticos, documentos de base de datos e información sobre configuración y estadísticas.
    En la mayoría de los casos la información se devuelve en forma de documento JSON.

-   `HEAD`

    El método `HEAD` se utiliza para obtener la cabecera HTTP de una solicitud `GET` sin el cuerpo de la respuesta.

-   `POST`

    Cargar datos.
    Dentro de la API de {{site.data.keyword.cloudant_short_notm}},
    el método `POST` se utiliza para definir valores,
    cargar documentos,
    definir valores de documentos
    e iniciar algunos mandatos de administración.

-   `PUT`

    Se utiliza para 'almacenar' un recurso específico.
    En la API de {{site.data.keyword.cloudant_short_notm}},
    `PUT` se utiliza para crear objetos nuevos,
    incluidos documentos,
    bases de datos,
    vistas y
    documentos de diseño.

-   `DELETE`

    Suprime el recurso especificado,
    incluidos documentos,
    vistas y
    documentos de diseño.

-   `COPY`

    Un método especial que se puede utilizar para copiar documentos y objetos.

Si el cliente (como algunos navegadores web) no admite el uso de estos métodos HTTP, se puede utilizar `POST` en su lugar con la cabecera de solicitud `X-HTTP-Method-Override` establecida en el método HTTP real.

### Error Método no permitido
{: #method-not-allowed-error}

Si utiliza un tipo de solicitud HTTP no admitido con un URL que no da soporte al tipo especificado, un se devuelve un mensaje [405](/docs/services/Cloudant?topic=cloudant-http#http-status-codes) que muestra los métodos HTTP admitidos, tal como se muestra en el ejemplo siguiente.

_Ejemplo de mensaje de error en respuesta a una solicitud no admitida:_

```json
{
    "error":"method_not_allowed",
    "reason":"Only GET,HEAD allowed"
}
```
{: codeblock}

## JSON
{: #json-overview}

{{site.data.keyword.cloudant_short_notm}} almacena los documentos utilizando la codificación JSON (JavaScript Object Notation), de forma que cualquier cosa codificada en JSON se puede almacenar como un documento.
Los archivos que contienen medios, como imágenes, vídeos y audio, se denominan BLOB (objeto binario grande) y se pueden almacenar como archivos adjuntos asociados a documentos.

Encontrará más información sobre JSON en la [Guía de JSON](/docs/services/Cloudant?topic=cloudant-json#json).

## Sistemas distribuidos
{: #distributed-systems}

La API de {{site.data.keyword.cloudant_short_notm}} le permite interactuar con una colaboración de varias máquinas, lo que se denomina clúster.
Las máquinas de un clúster deben estar en el mismo centro de datos, pero pueden estar en distintos 'pods' en dicho centro de datos.
El uso de distintos pods ayuda a mejorar las características de alta disponibilidad de {{site.data.keyword.cloudant_short_notm}}.

Una ventaja del uso de clústeres es que cuando se necesita más capacidad de cálculo se puede simplemente añadir más máquinas.
Esta suele se una solución más rentable y con mayor tolerancia de errores que aumentar la capacidad o mejorar una sola máquina existente.

Para obtener información sobre {{site.data.keyword.cloudant_short_notm}} y los conceptos del sistema distribuido, consulte la guía [CAP Theorem](/docs/services/Cloudant?topic=cloudant-cap-theorem#cap-theorem).

## Réplica
{: #replication-basics}

[Réplica](/docs/services/Cloudant?topic=cloudant-replication-api#replication-api) es un procedimiento que siguen {{site.data.keyword.cloudant_short_notm}}, [CouchDB ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](http://couchdb.apache.org/){: new_window}, [PouchDB ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](http://pouchdb.com/){: new_window} y otras bases de datos distribuidas.
La réplica sincroniza el estado de dos bases de datos para que su contenido sea idéntico.

Puede replicar continuamente.
Esto significa que una base de datos de destino se actualiza cada vez que cambia la base de datos de origen.
La réplica continua se puede utilizar para copias de seguridad de datos, para agregar datos entre varias bases de datos o para compartir datos.

Sin embargo, la réplica continua implica comprobar continuamente si la base de datos de origen se ha modificado.
Esta comprobación requiere constantes llamadas internas, lo que puede afectar el rendimiento o al coste de utilizar la base de datos.

La réplica continua puede provocar que se realicen muchas llamadas internas. Estas llamadas podrían afectar a los costes para los usuarios multiarrendatarios de sistemas {{site.data.keyword.cloudant_short_notm}}. La réplica continua está inhabilitada de forma predeterminada.
{: note}

