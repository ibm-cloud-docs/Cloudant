---

copyright:
  years: 2018, 2019
lastupdated: "2019-03-18"

keywords: audit access ibm cloudant, supported classifications of personal data, personal data, sensitive personal data, restrictions on processing, encrypt data, data locations, service security, delete data

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

<!-- Acrolinx: 2017-05-10 -->

# Reglamento General de Protección de Datos (RGPD)
{: #general-data-protection-regulation-gdpr-}

La GDPR busca crear un marco de ley de protección de datos unificado en la Unión Europea y trata de devolver a los ciudadanos el control de sus datos personales mientras impone reglas estrictas a quienes alojan y 'procesan' los datos, en cualquier parte del mundo. La normativa también introduce reglas relacionadas con la libre circulación de datos personales dentro y fuera de la UE. 

Con el [Reglamento General de Protección de Datos ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://www.eugdpr.org/){: new_window}, los clientes de {{site.data.keyword.cloudantfull}} pueden basarse en
el conocimiento del equipo de {{site.data.keyword.cloudant_short_notm}}
y en la conformidad con los estándares y la legislación de privacidad de los datos emergentes y
también en la capacidad más amplia de {{site.data.keyword.IBM}} para proporcionar una suite completa
de soluciones
para ayudar a las empresas de todos los tamaños con sus propios requisitos de gobierno de datos internos.

## ¿Cómo audito el acceso a {{site.data.keyword.cloudant_short_notm}}?
{: #how-do-i-audit-access-to-ibm-cloudant-}

Encontrará información sobre la auditoría en [Registro de auditoría](/docs/services/Cloudant?topic=cloudant-audit-logging#audit-logging){: new_window}. 

## Clasificaciones soportadas de datos personales
{: #supported-classifications-of-personal-data}

Las siguientes categorías de datos personales están soportadas por {{site.data.keyword.cloudant_short_notm}}
para GDPR:

**Datos personales**, por ejemplo:
 * Identidad/estado civil
 * Vida personal
 * Vida profesional
 * Datos de ubicación
 * Conectividad/datos de dispositivo

**Datos personales confidenciales**, restringidos a:
  * Datos de estado, se aplican condiciones adicionales que se cubren en la [descripción de servicio del clúster dedicado de {{site.data.keyword.cloudant_short_notm}} ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://www-03.ibm.com/software/sla/sladb.nsf/pdf/6756-04/$file/i126-6756-04_05-2018_en_US.pdf){: new_window} y la [descripción de servicio adicional de {{site.data.keyword.cloud}} ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://www-03.ibm.com/software/sla/sladb.nsf/pdf/6627-04/$file/i126-6627-04_04-2018_en_US.pdf){: new_window}

Si está almacenando datos de servicios sanitarios, *debe* completar las tareas siguientes:
 - Notifique a {{site.data.keyword.cloudant_short_notm}} antes de escribir ningún dato.
 - Solicite un clúster dedicado compatible con HIPAA.

Para obtener más información sobre las clasificaciones soportadas de datos personales, consulte los [Data Sheet Addendum (DSA) en 2. Datos personales ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/software/reports/compatibility/clarity-reports/report/html/softwareReqsForProduct?deliverableId=2EBB5860B34311E7A9EB066095601ABB){: new_window}.

## Datos sobre mí
{: #data-about-me}

{{site.data.keyword.cloudant_short_notm}} registra algunos datos sobre sus usuarios y es un Controlador de datos para dichos datos de
Información personal (PI). Los datos que {{site.data.keyword.cloudant_short_notm}} registra dependen del tipo de cuenta que tenga.

Si tiene un clúster de {{site.data.keyword.cloudant_short_notm}} dedicado/clúster de {{site.data.keyword.cloudant_short_notm}}
Enterprise, grabamos datos
sobre usted y se considera un Controlador de datos para los datos dentro del contexto de GDPR. 
Si tiene un clúster de {{site.data.keyword.cloudant_short_notm}} dedicado/clúster de {{site.data.keyword.cloudant_short_notm}}
Enterprise, disponemos de:

 * Nombre
 * Correo electrónico

Los datos que {{site.data.keyword.cloudant_short_notm}} contiene pueden visualizarse y actualizarse mediante el panel de control de {{site.data.keyword.cloudant_short_notm}}.

Si tiene una cuenta suministrada por {{site.data.keyword.cloud_notm}} (incluida una instancia dedicada),
{{site.data.keyword.cloudant_short_notm}} _no_ recopila los datos personales mencionados anteriormente. Estos datos los guarda {{site.data.keyword.cloud_notm}}.

{{site.data.keyword.cloudant_short_notm}} procesa PI de clientes limitados en el curso de la ejecución del servicio y la optimización
de la experiencia del usuario. {{site.data.keyword.cloudant_short_notm}} utiliza el correo electrónico para contactar clientes según corresponda. La supervisión de las interacciones del cliente con el panel de control de {{site.data.keyword.cloudant_short_notm}} es la otra forma en la que {{site.data.keyword.cloudant_short_notm}} procesa PI.

### Restricción del proceso
{: #restriction-of-processing}

{{site.data.keyword.cloudant_short_notm}} envía datos de interacción del panel de control a Segment. Es posible pedir a {{site.data.keyword.cloudant_short_notm}} que restrinja
el proceso de la PI del cliente de esta forma mediante una [solicitud de soporte de {{site.data.keyword.cloudant_short_notm}}](mailto:support@cloudant.com). Al
recibir dicha solicitud, {{site.data.keyword.cloudant_short_notm}} suprime la información asociada
con el cliente tal como se envía a Segment, e impide que se envíen más datos. {{site.data.keyword.cloudant_short_notm}} debe conservar la
posibilidad de ponernos en contacto con los clientes dedicados a través del correo electrónico y proporcionar una interfaz para que los clientes mantengan esta información actualizada ya sea directamente, o a través de la configuración del cliente de sus detalles de contacto
a través de sus detalles de cuenta de {{site.data.keyword.cloud_notm}}.

## ¿Está cifrada nuestra base de datos de {{site.data.keyword.cloudant_short_notm}}?
{: #is-our-ibm-cloudant-database-encrypted-}

Todos los clústeres tienen un sistema de archivos cifrado (cifrado en reposo) utilizando LUKS (Linux Unified Key Setup). Los datos de la base de datos están
visibles para nuestras operaciones y equipos de soporte (consultar a continuación).

Para los datos confidenciales, lo que determine debe permanecer invisible para {{site.data.keyword.cloudant_short_notm}},
debe cifrar o proteger (pseudonomizar) los datos antes de enviárnoslos. Debe evitar utilizar PI como `_id` de documento en sus URL, por ejemplo, `https://$ACCOUNT.cloudant.com/$DATABASE/$DOCUMENT_ID`, puesto que son siempre visibles y se escriben en los registros de acceso.

## Ubicaciones de datos
{: #data-locations}

Las ubicaciones en las que {{site.data.keyword.cloudant_short_notm}} procesa datos personales estarán disponibles y se mantendrán al día, a través de DSA.

Para obtener más información sobre ubicaciones de datos, consulte [DSA en 7. {{site.data.keyword.IBM_notm}} Alojamiento y procesamiento de ubicaciones ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/software/reports/compatibility/clarity-reports/report/html/softwareReqsForProduct?deliverableId=2EBB5860B34311E7A9EB066095601ABB){: new_window}.

## Seguridad de servicios
{: #service-security}

### Uso de {{site.data.keyword.cloudant_short_notm}} de forma segura
{: #using-ibm-cloudant-securely}

Como usuario de {{site.data.keyword.cloudant_short_notm}}, debería:

 * Utilizar la configuración de CORS predeterminada para evitar el acceso inesperado.
 * Utilizar claves de API de forma liberal, de forma que tales componentes puedan tener 'el mínimo acceso con privilegios', que se puede acoplar con el registro de auditoría. Esta práctica le permite comprender quién ha accedido a qué datos.
 * Cifre o proteja (pseudonomice) datos confidenciales que considera que deben permanecer invisibles en {{site.data.keyword.cloudant_short_notm}}.

### Medidas de seguridad física y ambiental
{: #physical-and-environmental-security-measures}

La seguridad física de nuestros centros de datos está gestionada mediante los proveedores de nuestra infraestructura: {{site.data.keyword.cloud}}, AWS y 21Vianet. Todos tienen certificaciones auditadas externamente para su seguridad física. {{site.data.keyword.cloudant_short_notm}} no proporcionará más detalles sobre los controles de seguridad física en su lugar de nuestros centros de datos.

La seguridad física de las ubicaciones de la oficina utilizadas por nuestro personal se gestiona mediante {{site.data.keyword.IBM_notm}} Corporate. 
Los detalles de certificación y los informes de testificación (p.ej., ISO y SOC2) se pueden proporcionar al
cliente cuando lo solicite.

### Medidas técnicas y organizativas
{: #technical-and-organisational-measures}

Las Medidas técnicas y organizativas (TOM) están empleadas por {{site.data.keyword.cloudant_short_notm}}
para garantizar la seguridad de los
datos personales. {{site.data.keyword.cloudant_short_notm}} contiene certificaciones auditadas externamente para los controles que {{site.data.keyword.cloudant_short_notm}} utiliza. 
Los detalles de certificación y los informes de testificación (p.ej., ISO y SOC2) se pueden proporcionar al
cliente cuando lo solicite.

### Acceso de servicio a datos
{: #service-access-to-data}

Las operaciones de {{site.data.keyword.cloudant_short_notm}} y el personal de soporte tienen acceso a los datos de cliente y pueden acceder a los mismos durante
las operaciones rutinarias. Este acceso solo se realiza según sea necesario, con el fin de operar y dar soporte al servicio. 
El acceso también está limitado a las *necesidades* y se registra, supervisa y audita.

## Supresión de datos
{: #deletion-of-data}

### Supresión de un documento
{: #deleting-a-document}

Cuando se suprime un documento, la base de datos crea un marcador de exclusión ('tombstone'). Lo que contenga el marcador de exclusión dependerá de cómo lo suprima:

 - Si realiza una llamada `DELETE`, el marcador de exclusión incluirá los campos `_id`, `_rev` y `_deleted`.
 - Si suprime actualizando el documento con un campo `_deleted: true` y realizando una solicitud `PUT` o `POST`, el marcador de exclusión incluye lo que se establece en el cuerpo del documento. Esta práctica puede ser útil en algunas circunstancias, por ejemplo, al registrar el motivo por el que un documento se ha suprimido en su marcador de exclusión.

Para obtener más información sobre la supresión de marcadores de exclusión, consulte [Eliminación simple de documentos de marcador de exclusión ('tombstone')](/docs/services/Cloudant?topic=cloudant-documents#tombstone-documents){: new_window}.

### ¿Cuándo se elimina un documento suprimido?
{: #when-is-a-deleted-document-removed-}

La compactación se ejecuta automáticamente y elimina periódicamente las revisiones antiguas (suprimidas o de otra forma)
de la base de datos, escribiendo solo revisiones 'hoja' en un archivo nuevo. {{site.data.keyword.cloudant_short_notm}} mantiene un historial de `_id` y `_rev` para habilitar la réplica, pero no los cuerpos de documentos antiguos.

{{site.data.keyword.cloudant_short_notm}} no expone la API de compactación de CouchDB.
{: tip}

{{site.data.keyword.cloudant_short_notm}} no garantiza que una base de datos se compacte en un momento específico. 
La compactación se realiza como un proceso en segundo plano en todo el nivel de almacenamiento y las bases de datos siempre se están compactando; no hay ninguna garantía de que sean
los datos que acaba de suprimir/cambiar.

{{site.data.keyword.cloudant_short_notm}} está aceptando las solicitudes *Derecho a olvidarse* mediante
[{{site.data.keyword.IBM_notm}} Data Privacy Office (DPO) ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](http://w3-03.ibm.com/ibm/privacy/index.html){: new_window}. 
Cuando se realiza una solicitud *Derecho a olvidarse* a partir de la {{site.data.keyword.IBM_notm}} DPO, {{site.data.keyword.cloudant_short_notm}} verifica la solicitud, activa explícitamente la compactación de la base de datos y verifica que se ha producido la compactación.
Al final de este proceso, la única versión del documento es su marcador de exclusión (`_id`, `_rev`, `_deleted`, y los campos que incluya allí la aplicación).

### Eliminación de marcadores de exclusión
{: #removal-of-tombstones}

{{site.data.keyword.cloudant_short_notm}} puede eliminar por completo todas las referencias y los datos de un documento
cuando sea necesario. Esta tarea es
un proceso gestionado por un operador denominado depuración. Antes de solicitar que los documentos se depuren, es
importante comprender que los documentos depurados *no los puede recuperar*
{{site.data.keyword.cloudant_short_notm}} una vez que el proceso
se haya completado.

La API de depuración de CouchDB no está soportada por {{site.data.keyword.cloudant_short_notm}}.
{: tip}

En el contexto de GDPR, la depuración solo es necesaria si la PI se utiliza en un ID de documento. Es una mala
idea para un `_id` almacenar PI por muchas razones, pero hay un puñado de casos de uso semiválidos
(por ejemplo, un correo electrónico único). Si es posible, cifre o pseudonomice datos para que sean opacos
para {{site.data.keyword.cloudant_short_notm}}.

Si un documento necesita eliminación mediante una solicitud *Derecho a olvidarse*:

1. Archive una solicitud con la [{{site.data.keyword.IBM_notm}} DPO ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](http://w3-03.ibm.com/ibm/privacy/index.html){: new_window} para solicitar la depuración de valores de `_id` de documentos específicos junto con el motivo.
1. Al recibir una solicitud formal por parte de la {{site.data.keyword.IBM_notm}} DPO, las operaciones de {{site.data.keyword.cloudant_short_notm}}
verifican la solicitud para confirmar que el `id` contenga PI. {{site.data.keyword.cloudant_short_notm}} no depura los datos que no tienen PI en el `_id`. 
1. {{site.data.keyword.cloudant_short_notm}} desencadena la acción de depuración para eliminar de forma permanente los datos solicitados.

Este proceso solo se utiliza para solicitudes de supresión de emergencia (por ejemplo, *derecho a
olvidarse*) y no se debe confiar en ellas a largo plazo. Si la aplicación utiliza intencionadamente
PI en ID de documentos,
se debe modificar para pseudonomizar tal PI, o no utilizar PI en los ID de documentos. No puede basarse
en la depuración normal por parte del equipo de operaciones de {{site.data.keyword.cloudant_short_notm}} para evitar esto. 
{{site.data.keyword.cloudant_short_notm}} por lo tanto rechaza las siguientes solicitudes de depuración:

1. La solicitud se utiliza para la depuración regular, por ejemplo, *cada 30 días*.
1. La solicitud es para más de 100 documentos.

Incluso con la depuración, PI en el campo `_id` se filtrará en lugares que no desea, como por ejemplo
registros de {{site.data.keyword.cloudant_short_notm}}, por lo que se debe evitar. 
{{site.data.keyword.cloudant_short_notm}} tiene una razón empresarial para conservar estos registros y no se eliminarán las líneas de registro que contienen valores de `_id` de documento.

### ¿Y si se suprime una base de datos?
{: #what-about-deleting-a-database-}

La supresión de una base de datos la coloca en una papelera durante un máximo de 48 horas, después de las cuales se elimina del sistema de archivos. El equipo de {{site.data.keyword.cloudant_short_notm}} *no* realiza copias de seguridad de las bases de datos; esta tarea es
la *responsabilidad del cliente*. Debe asegurarse de que todas las copias de la
base de datos se eliminen del sistema. Para obtener más información, consulte
[Copia de seguridad y recuperación de {{site.data.keyword.cloudant_short_notm}}](/docs/services/Cloudant?topic=cloudant-ibm-cloudant-backup-and-recovery#ibm-cloudant-backup-and-recovery){: new_window}. 

Si necesita ayuda adicional, póngase en contacto
con el soporte de [{{site.data.keyword.cloudant_short_notm}} ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](mailto:support@cloudant.com).

