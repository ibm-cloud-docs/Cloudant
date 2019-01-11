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

<!-- Acrolinx: 2018-05-07 -->

# Aspectos básicos de {{site.data.keyword.cloudant_short_notm}}

Si es la primera vez que utiliza este producto, lea detenidamente esta sección antes de continuar.
{:shortdesc}

En las secciones sobre [Bibliotecas de cliente](../libraries/index.html#-client-libraries), [Consulta de API](../api/index.html#-api-reference),
y [Guías](../guides/acurl.html#authorized-curl-acurl-) se da por supuesto que tiene conocimientos sobre {{site.data.keyword.cloudantfull}}.

## Conexión a {{site.data.keyword.cloudant_short_notm}}

Para acceder a {{site.data.keyword.cloudant_short_notm}},
debe disponer de una cuenta de [{{site.data.keyword.cloudant_short_notm}}](../api/account.html),
o [{{site.data.keyword.cloud}}](../offerings/bluemix.html).

## API HTTP

Todas las solicitudes destinadas a {{site.data.keyword.cloudant_short_notm}} pasan por la web.
Esto significa que cualquier sistema que se puede comunicar con la web, se puede comunicar con {{site.data.keyword.cloudant_short_notm}}.
Todas las bibliotecas específicas de lenguaje para {{site.data.keyword.cloudant_short_notm}} son en realidad derivadores que proporcionan comodidad y sutilezas lingüísticas que le ayudarán a trabajar con una simple API.
Muchos usuarios optan por utilizar directamente bibliotecas HTTP para trabajar con {{site.data.keyword.cloudant_short_notm}}.

Encontrará detalles sobre la forma en que {{site.data.keyword.cloudant_short_notm}} utiliza HTTP en el [tema sobre HTTP de la consulta de API](../api/http.html).

{{site.data.keyword.cloudant_short_notm}} admite los siguientes métodos de solicitud HTTP:

-   `GET`

    Solicitar el elemento especificado.
    Al igual que sucede con las solicitudes HTTP normales,
    el formato del URL define lo que se devuelve.
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

Si utiliza un tipo de solicitud HTTP no admitido con un URL que no da soporte al tipo especificado, un se devuelve un mensaje [405](../api/http.html#405) que muestra los métodos HTTP admitidos, tal como se muestra en el ejemplo siguiente.

_Ejemplo de mensaje de error en respuesta a una solicitud no admitida:_

```json
{
    "error":"method_not_allowed",
    "reason":"Only GET,HEAD allowed"
}
```
{:codeblock}

## JSON
{: #json}

{{site.data.keyword.cloudant_short_notm}} almacena los documentos utilizando la codificación JSON (JavaScript Object Notation), de forma que cualquier cosa codificada en JSON se puede almacenar como un documento.
Los archivos que contienen medios, como imágenes, vídeos y audio, se denominan BLOB (objeto binario grande) y se pueden almacenar como archivos adjuntos asociados a documentos.

Encontrará más información sobre JSON en la [Guía de JSON](../guides/json.html).

<div id="distributed"></div>

## Sistemas distribuidos

La API de {{site.data.keyword.cloudant_short_notm}} le permite interactuar con una colaboración de varias máquinas, lo que se denomina clúster.
Las máquinas de un clúster deben estar en el mismo centro de datos, pero pueden estar en distintos 'pods' en dicho centro de datos.
El uso de distintos pods ayuda a mejorar las características de alta disponibilidad de {{site.data.keyword.cloudant_short_notm}}.

Una ventaja del uso de clústeres es que cuando se necesita más capacidad de cálculo se puede simplemente añadir más máquinas.
Esta suele se una solución más rentable y con mayor tolerancia de errores que aumentar la capacidad o mejorar una sola máquina existente.

Para obtener información sobre {{site.data.keyword.cloudant_short_notm}} y los conceptos del sistema distribuido, consulte la guía [CAP Theorem](../guides/cap_theorem.html).

## Réplica

[Réplica](../api/replication.html) es un procedimiento que siguen {{site.data.keyword.cloudant_short_notm}},
[CouchDB ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](http://couchdb.apache.org/){:new_window},
[PouchDB ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](http://pouchdb.com/){:new_window}
y otras bases de datos distribuidas.
La réplica sincroniza el estado de dos bases de datos para que su contenido sea idéntico.

Puede replicar continuamente.
Esto significa que una base de datos de destino se actualiza cada vez que cambia la base de datos de origen.
La réplica continua se puede utilizar para copias de seguridad de datos, para agregar datos entre varias bases de datos o para compartir datos.

Sin embargo, la réplica continua implica comprobar continuamente si la base de datos de origen se ha modificado.
Esta comprobación requiere constantes llamadas internas, lo que puede afectar el rendimiento o al coste de utilizar la base de datos.

>   **Nota**: La réplica continua puede dar lugar a un gran número de llamadas internas.
    Esto puede afectar a los costes para los usuarios multiarrendatarios de sistemas {{site.data.keyword.cloudant_short_notm}}.
    La réplica continua está inhabilitada de forma predeterminada.
