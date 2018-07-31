---

copyright:
  years: 2018
lastupdated: "2018-06-07"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2018-04-28 -->

# Reglamento General de Protección de Datos (RGPD)

La GDPR busca crear un marco de ley de protección de datos unificado en la Unión Europea y trata de devolver a los ciudadanos el control de sus datos personales mientras impone reglas estrictas a quienes alojan y 'procesan' los datos, en cualquier parte del mundo. La normativa también introduce reglas relacionadas con la libre circulación de datos personales dentro y fuera de la UE. 

Con el [Reglamento General de Protección de Datos ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://www.eugdpr.org/){:new_window}, los clientes de {{site.data.keyword.cloudantfull}} pueden basarse en
el conocimiento del equipo de {{site.data.keyword.cloudant_short_notm}}
y en la conformidad con los estándares y la legislación de privacidad de los datos emergentes y
también en la capacidad más amplia de {{site.data.keyword.IBM}} para proporcionar una suite completa
de soluciones
para ayudar a las empresas de todos los tamaños con sus propios requisitos de gobierno de datos internos.

## ¿Cómo audito el acceso a {{site.data.keyword.cloudant_short_notm}}?

Encontrará información sobre la auditoría en [Registro de auditoría](../offerings/audit.html#audit-logging){:new_window}. 

## Clasificaciones soportadas de datos personales

Las siguientes categorías de datos personales están soportadas por {{site.data.keyword.cloudant_short_notm}}
para GDPR:

**Datos personales**, por ejemplo:
 * Identidad/estado civil
 * Vida personal
 * Vida profesional
 * Información económica y financiera
 * Datos de ubicación
 * Conectividad/datos de dispositivo

**Datos personales confidenciales**, restringidos a:
  * Datos sanitarios, se aplican condiciones adicionales que se cubren en una descripción de servicio

Si está almacenando datos de cuidado sanitario, *debe* completar las tareas siguientes:
 - Notifique a {{site.data.keyword.cloudant_short_notm}} antes de escribir ningún dato.
 - Solicite un clúster dedicado compatible con HIPAA.

Para obtener más información sobre las clasificaciones soportadas de datos personales, consulte los
[requisitos del sistema detallados de {{site.data.keyword.cloudant_short_notm}} en 2. Datos personales ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/software/reports/compatibility/clarity-reports/report/html/softwareReqsForProduct?deliverableId=2EBB5860B34311E7A9EB066095601ABB){:new_window}.

## Datos sobre mí

{{site.data.keyword.cloudant_short_notm}} registra algunos datos sobre sus usuarios y es un Controlador de datos para dichos datos de
Información personal (PI). Los datos que grabamos dependen del tipo de cuenta que tenga.

Si tiene un clúster de {{site.data.keyword.cloudant_short_notm}} dedicado/clúster de {{site.data.keyword.cloudant_short_notm}}
Enterprise, grabamos datos
sobre usted y se considera un Controlador de datos para los datos dentro del contexto de GDPR. 
Si tiene un clúster de {{site.data.keyword.cloudant_short_notm}} dedicado/clúster de {{site.data.keyword.cloudant_short_notm}}
Enterprise, disponemos de:

 * Nombre
 * Correo electrónico

Los datos que tenemos se pueden ver y actualizar a través del panel de control de {{site.data.keyword.cloudant_short_notm}}.

Si tiene una cuenta suministrada por {{site.data.keyword.cloud_notm}} (incluida una instancia dedicada),
{{site.data.keyword.cloudant_short_notm}} _no_ recopila los datos personales mencionados anteriormente. Estos datos los guarda {{site.data.keyword.cloud_notm}}.

{{site.data.keyword.cloudant_short_notm}} procesa PI de clientes limitados en el curso de la ejecución del servicio y la optimización
de la experiencia del usuario. Utilizamos el correo electrónico para ponernos en contacto con los clientes según corresponda. La supervisión
de las interacciones del cliente con el panel de control de {{site.data.keyword.cloudant_short_notm}} es la otra forma en la que procesamos PI.

### Restricción del proceso

Enviamos los datos de interacción del panel de control a Segment. Es posible pedir a {{site.data.keyword.cloudant_short_notm}} que restrinja
el proceso de la PI del cliente de esta forma mediante una [solicitud de soporte de {{site.data.keyword.cloudant_short_notm}}](mailto:support@cloudant.com). Al
recibir dicha solicitud, {{site.data.keyword.cloudant_short_notm}} suprime la información asociada
con el cliente tal como se envía a Segment, e impide que se envíen más datos. Tenemos que conservar la
posibilidad de ponernos en contacto con los clientes dedicados a través del correo electrónico y proporcionar una interfaz para que los clientes mantengan esta información actualizada ya sea directamente, o a través de la configuración del cliente de sus detalles de contacto
a través de sus detalles de cuenta de {{site.data.keyword.cloud_notm}}.

## ¿Está cifrada nuestra base de datos de {{site.data.keyword.cloudant_short_notm}}?

Todos los clústeres tienen un sistema de archivos cifrado (cifrado en reposo) utilizando LUKS (Linux Unified Key Setup). Los datos de la base de datos están
visibles para nuestras operaciones y equipos de soporte (consultar a continuación).

Para los datos confidenciales, lo que determine debe permanecer invisible para {{site.data.keyword.cloudant_short_notm}},
debe cifrar o proteger (pseudonomizar) los datos antes de enviárnoslos. Debe evitar
el uso de PI para un `_id` de documentos, ya que estos siempre están visibles y se graban en los registros de acceso.

## Ubicaciones de datos

Las ubicaciones donde {{site.data.keyword.cloudant_short_notm}} procesa los datos personales estarán disponibles,
y se mantendrán actualizadas, a través del DPA (Data Sheet Addendum).

Para obtener más información sobre las ubicaciones de datos, consulte los
[requisitos del sistema detallados de {{site.data.keyword.cloudantfull}} en 7. {{site.data.keyword.IBM_notm}} Alojamiento y procesamiento de ubicaciones ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/software/reports/compatibility/clarity-reports/report/html/softwareReqsForProduct?deliverableId=2EBB5860B34311E7A9EB066095601ABB){:new_window}.

## Seguridad de servicios

### Uso de {{site.data.keyword.cloudant_short_notm}} de forma segura

Como usuario de {{site.data.keyword.cloudant_short_notm}}, debería:

 * Utilizar la configuración de CORS predeterminada para evitar el acceso inesperado.
 * Utilizar claves de API de forma liberal, de forma que tales componentes puedan tener 'el mínimo acceso con privilegios', que se puede acoplar con el registro de auditoría. Esta práctica le permite comprender quién ha accedido a qué datos.
 * Cifra o proteja (pseudonomice) los datos confidenciales antes de enviárnoslos.

### Medidas de seguridad física y ambiental

La seguridad física de nuestros centros de datos está gestionada mediante los proveedores de nuestra infraestructura: SoftLayer,
AWS y 21Vianet. Todos tienen certificaciones auditadas externamente para su seguridad física. No proporcionaremos
más detalles de los controles de seguridad física en su lugar en nuestros centros de datos.

La seguridad física de las ubicaciones de la oficina utilizadas por nuestro personal se gestiona mediante {{site.data.keyword.IBM_notm}} Corporate. 
Los detalles de certificación y los informes de testificación (p.ej., ISO y SOC2) se pueden proporcionar al
cliente cuando lo solicite.

### Medidas técnicas y organizativas

Las Medidas técnicas y organizativas (TOM) están empleadas por {{site.data.keyword.cloudant_short_notm}}
para garantizar la seguridad de los
datos personales. Tenemos certificaciones auditadas externamente para los controles que utilizamos. 
Los detalles de certificación y los informes de testificación (p.ej., ISO y SOC2) se pueden proporcionar al
cliente cuando lo solicite.

### Acceso de servicio a datos

Las operaciones de {{site.data.keyword.cloudant_short_notm}} y el personal de soporte tienen acceso a los datos de cliente y pueden acceder a los mismos durante
las operaciones rutinarias. Este acceso solo se realiza según sea necesario, con el fin de operar y dar soporte al servicio. 
El acceso también está limitado a las *necesidades* y se registra, supervisa y audita.

## Supresión de datos

### Supresión de un documento

Cuando se suprime un documento, la base de datos crea un marcador de exclusión ('tombstone'). Lo que contenga el marcador de exclusión dependerá de cómo lo suprima:

 - Si realiza una llamada `DELETE`, el marcador de exclusión incluirá los campos `_id`, `_rev` y `_deleted`.
 - Si suprime actualizando el documento con un campo `_deleted: true` y realizando una solicitud `PUT` o `POST`, el marcador de exclusión incluye lo que se establece en el cuerpo del documento. Esta práctica puede ser útil en algunas circunstancias, por ejemplo, al registrar el motivo por el que un documento se ha suprimido en su marcador de exclusión.

Para obtener más información sobre la supresión de marcadores de exclusión, consulte [Eliminación simple de documentos de marcador de exclusión ('tombstone')](../api/document.html#-tombstone-documents){:new_window}.

### ¿Cuándo se elimina un documento suprimido?

La compactación se ejecuta automáticamente y elimina periódicamente las revisiones antiguas (suprimidas o de otra forma)
de la base de datos, escribiendo solo revisiones 'hoja' en un archivo nuevo. Mantenemos un historial de
`_id` y `_rev` para habilitar la réplica, pero no los cuerpos de documentos antiguos.

> **Nota**: {{site.data.keyword.cloudant_short_notm}} no expone la API de compactación de CouchDB.

No garantizamos que una base de datos se compacte en un momento específico. Los clústeres pueden alojar
más de 10000 cuentas, cada una de las cuales contiene muchas bases de datos. La compactación se realiza como un proceso en segundo plano en todo el clúster, y las bases de datos siempre se están compactando; no hay ninguna garantía de que sean
los datos que acaba de suprimir/cambiar.

{{site.data.keyword.cloudant_short_notm}} está aceptando las solicitudes *Derecho a olvidarse* mediante
[{{site.data.keyword.IBM_notm}} Data Privacy Office (DPO) ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](http://w3-03.ibm.com/ibm/privacy/index.html){:new_window}. 
Cuando se realiza una solicitud *Derecho a olvidarse* a partir de la {{site.data.keyword.IBM_notm}} DPO, verificamos la solicitud, activamos explícitamente la compactación de la base de datos y verificamos que se ha producido la compactación.
Al final de este proceso, la única versión del documento es su marcador de exclusión (`_id`, `_rev`, `_deleted`, y los campos que incluya allí la aplicación).

### Eliminación de marcadores de exclusión

{{site.data.keyword.cloudant_short_notm}} puede eliminar por completo todas las referencias y los datos de un documento
cuando sea necesario. Esta tarea es
un proceso gestionado por un operador denominado depuración. Antes de solicitar que los documentos se depuren, es
importante comprender que los documentos depurados *no los puede recuperar*
{{site.data.keyword.cloudant_short_notm}} una vez que el proceso
se haya completado.

> **Nota**: La API de depuración de CouchDB no está soportada por {{site.data.keyword.cloudant_short_notm}}.

En el contexto de GDPR, la depuración solo es necesaria si la PI se utiliza en un ID de documento. Es una mala
idea para un `_id` almacenar PI por muchas razones, pero hay un puñado de casos de uso semiválidos
(por ejemplo, un correo electrónico único). Si es posible, cifre o pseudonomice datos para que sean opacos
para {{site.data.keyword.cloudant_short_notm}}.

Si un documento necesita eliminación mediante una solicitud *Derecho a olvidarse*:

1. Archive una solicitud con la [{{site.data.keyword.IBM_notm}} DPO ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](http://w3-03.ibm.com/ibm/privacy/index.html){:new_window} para solicitar la depuración de valores de `_id` de documentos específicos junto con el motivo.
1. Al recibir una solicitud formal por parte de la {{site.data.keyword.IBM_notm}} DPO, las operaciones de {{site.data.keyword.cloudant_short_notm}}
verifican la solicitud para confirmar que el `id` contenga PI. No depuramos los datos que no tienen PI en el `_id`. 
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
registros de {{site.data.keyword.cloudant_short_notm}}, por lo que se debe evitar. Tenemos una razón empresarial para conservar estos registros y no se eliminarán
las líneas de registro que contienen valores de `_id` de documento.

### ¿Y si se suprime una base de datos?

La supresión de una base de datos la coloca en una papelera durante un máximo de 48 horas, después de las cuales se elimina del sistema de archivos. El equipo de {{site.data.keyword.cloudant_short_notm}} *no* realiza copias de seguridad de las bases de datos; esta tarea es
la *responsabilidad del cliente*. Debe asegurarse de que todas las copias de la
base de datos se eliminen del sistema. Para obtener más información, consulte
[Copia de seguridad y recuperación de {{site.data.keyword.cloudant_short_notm}}](../guides/backup-cookbook.html#cloudant-nosql-db-backup-and-recovery){:new_window}. 

Si necesita ayuda adicional, póngase en contacto
con el soporte de [{{site.data.keyword.cloudant_short_notm}} ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](mailto:support@cloudant.com).

