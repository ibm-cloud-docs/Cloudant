---

copyright:
  years: 2017, 2018
lastupdated: "2018-06-07"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-05-02 -->

# Copia de seguridad de los datos mediante CouchBackup

La naturaleza distribuida de {{site.data.keyword.cloudant}} ofrece una forma inherente de copia de seguridad de los datos.
CouchBackup es una herramienta de línea de mandatos que le ofrece un método más potente y flexible para hacer copia de seguridad de sus datos.
{:shortdesc}

## Visión general

Las ventajas distribuidas de {{site.data.keyword.cloudant_short_notm}} se consiguen mediante el uso de clústeres.
En un clúster, los datos de una base de datos se guardan en varias copias.
Las copias se distribuyen entre al menos tres servidores separados físicamente.
El uso de clústeres para almacenar datos ofrece a {{site.data.keyword.cloudant_short_notm}} las características inherentes de
alta disponibilidad (HA) y recuperación en caso de error (DR).
El uso de clústeres ayuda a {{site.data.keyword.cloudant_short_notm}} a tolerar la pérdida de un nodo dentro de un clúster sin que se pierdan datos.

Sin embargo, incluso con estas características
HA y DR, hay circunstancias en las que puede desear una copia de seguridad mejorada de sus datos.

<div id="activepassive"></div>

### Caída del centro de datos y recuperación en caso de error

La [réplica continua](../api/replication.html#continuous-replication) entre clústeres constituye una buena solución al problema que se plantea cuando un clúster de {{site.data.keyword.cloudant_short_notm}} no está completamente disponible.
La réplica continua es un modelo de tipo 'activo-pasivo'.
La parte 'activa' del modelo es la réplica continua.
La parte 'pasiva' del modelo reconoce que la réplica no está normalmente diseñada para responder las solicitudes de las aplicaciones.
La réplica se utiliza principalmente como un clon de la base de datos original.
Si es necesario, se puede acceder a los datos desde el clon.
Como alternativa, los datos del clon se pueden restaurar en otro lugar mediante una [réplica](../api/replication.html).

>	**Nota:** La restauración de una base de datos grande mediante réplica de un clon puede tardar bastante tiempo.

### Alta disponibilidad, migración tras error automática y equilibrio geográfico de carga

Una alternativa al encono ['activo-pasivo'](#activepassive) es configurar dos centros de datos para utilizar un modelo 'activo-activo'.

En este modelo, los cambios que se realizan en una base de datos del clúster A se replican en una base de datos del clúster B.
Asimismo, los cambios que se realizan en la base de datos del clúster B se replican en la base de datos del clúster A.

>	**Nota:** Este modelo se puede configurar mediante el panel de control de {{site.data.keyword.cloudant_short_notm}}.
No requiere ninguna acción por parte del equipo de soporte de {{site.data.keyword.cloudant_short_notm}}.

Con este modelo configurado, puede diseñar sus aplicaciones de base de datos de modo
que realicen una 'migración tras error' en uno de los clústeres si se cumplen ciertos criterios de disponibilidad.
Puede definir los criterios de disponibilidad como parte del diseño de la aplicación.

También puede incluir un 'equilibrio de carga' geográfico en el diseño de la aplicación.
Por ejemplo, una aplicación cliente utilizada en un área geográfica espera obtener un mejor rendimiento cuando la aplicación accede a datos almacenados en un clúster de un área geográfica 'cercana'.
Si se diseña la aplicación cliente de modo que identifique el clúster 'más cercano' y se conecte a dicho clúster para consultas de bases de datos, aumenta el rendimiento de la aplicación.

Encontrará una guía de aprendizaje en la que se explica cómo configurar un entorno de aplicación de varias regiones [aquí![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](http://www.ibm.com/developerworks/cloud/library/cl-multi-region-bluemix-apps-with-cloudant-and-dyn-trs/index.html){:new_window}.

### Modificación de datos accidental o maliciosa

{{site.data.keyword.cloudant_short_notm}} no ofrece ningún mecanismo para crear una instantánea de la base de datos.
Si necesita este tipo de función, por ejemplo para facilitar la retrotracción del nivel de un documento a un estado conocido anterior, puede conseguir el mismo efecto de dos formas:

1.	Mediante la réplica. Puede realizar una réplica de la base de datos. Asegúrese de registrar el ID de secuencia final. Según la planificación que determine, cree una réplica de la base de datos en una base de datos nueva. Inicie la réplica desde el último ID de secuencia registrado. Al conservar los ID de secuencia para las réplicas puede generar el efecto de un mecanismo de acumulación. El resultado sería parecido al de crear instantáneas 'semanales' regulares a partir de instantáneas 'diarias'. Una limitación de este enfoque es que también hace una réplica de las revisiones de documentos de marcador de exclusión ('tombstone') y conflictos no resueltos.

2.	Mediante el volcado del contenido de la base de datos a un archivo. Existen varias herramientas para realizar un volcado del contenido de una base de datos en un archivo. El archivo de volcado resultante se puede guardar en un servicio o dispositivos barato orientado a objetos. Una limitación de este enfoque es que normalmente solo se realiza un volcado de las revisiones de documentos actuales. Esta limitación significa que no se incluyen los conflictos no resueltos.

La creación de un volcado de la base de datos es una manera eficaz de disponer de una gran variedad de soluciones de copia de seguridad.
Por lo tanto, el resto de este tema se centra en este enfoque.

<!--
https://developer.ibm.com/clouddataservices/2016/03/22/simple-couchdb-and-cloudant-backup/

A useful approach is to have couchbackup's snapshots placed on the {{site.data.keyword.cloud}} Object Storage service, as described here:

https://developer.ibm.com/recipes/tutorials/object-storage-cloudant-backup/
-->
