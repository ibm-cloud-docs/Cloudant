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

# {{site.data.keyword.cloud_notm}} público
{: #ibm-cloud-public}

{{site.data.keyword.cloudantfull}} público es la oferta de {{site.data.keyword.cloudant_short_notm}} más rica en características que primero recibe actualizaciones y nuevas características. El precio se basa en los requisitos de rendimiento y almacenamiento, lo que hace que sea adecuada para cualquier carga necesaria. 

El [plan Lite](#lite-plan) gratuito incluye una cantidad fija de
capacidad de rendimiento y datos para propósitos de desarrollo y evaluación. El [plan Estándar](#standard-plan) de pago ofrece capacidad de rendimiento suministrada configurable
y precios de almacenamiento de datos que escala a medida que cambian los requisitos de su aplicación.  Además hay disponible un [plan de hardware dedicado](#dedicated-hardware-plan) por una cuota mensual adicional para ejecutar una o varias instancias del plan estándar en un entorno de hardware dedicado. El entorno de hardware dedicado es para uso exclusivo del usuario y si la instancia del plan de hardware dedicado se suministra en una ubicación de EE.UU., de forma opcional, puede seleccionar una configuración conforme con la [HIPAA ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://en.wikipedia.org/wiki/Health_Insurance_Portability_and_Accountability_Act){:new_window}.

La tabla siguiente resume la capacidad de rendimiento y configuración del espacio de disco
suministradas para el plan Lite y algunos ejemplos para el
plan Estándar:

<div id="maxtable"></div>

<table>

<tr>
<th id="capacity-config-plan">Plan</th><th id="lite">Lite</th><th id="standard" colspan='4'>Estándar</th>
</tr>
<tr>
<th id="base-priceperhour" headers="capacity-config-plan">Precio base (por hora)</td>
<td headers="lite base-priceperhour">0,00 $</td>
<td headers="standard base-priceperhour" colspan='4'>Consulte los <a href="../offerings/pricing.html#pricing" target="_blank">detalles sobre precios <img src="../images/launch-glyph.svg" alt="Icono de enlace externo" title="Icono de enlace externo"></a>.</td>
</tr>
<tr>
<th id="provisionedthroughputcapacity-lookupspersecond" headers="capacity-config-plan">Capacidad de rendimiento suministrada (búsquedas por segundo)</td>
<td headers="lite provisionedthroughputcapacity-lookupspersecond-lite">20</td>
<td headers="standard provisionedthroughputcapacity-lookupspersecond">100</td>
<td headers="standard provisionedthroughputcapacity-lookupspersecond">1.000</td>
<td headers="standard provisionedthroughputcapacity-lookupspersecond">5.000</td>
<td headers="standard provisionedthroughputcapacity-lookupspersecond">20.000</td>
</tr>
<tr>
<th id="provisionedthroughputcapacity-writespersecond" headers="capacity-config-plan">Capacidad de rendimiento suministrada (escrituras por segundo)</td>
<td headers="lite provisionedthroughputcapacity-writespersecond">10</td>
<td headers="standard provisionedthroughputcapacity-writespersecond">50</td>
<td headers="standard provisionedthroughputcapacity-writespersecond">500</td>
<td headers="standard provisionedthroughputcapacity-writespersecond">2.500</td>
<td headers="standard provisionedthroughputcapacity-writespersecond">10.000</td>
</tr>
<tr>
<th id="provisionedthroughputcapacity-queriespersecond" headers="capacity-config-plan">Capacidad de rendimiento suministrada (consultas por segundo)</td>
<td headers="lite provisionedthroughputcapacity-queriespersecond">5</td>
<td headers="standard provisionedthroughputcapacity-queriespersecond">5</td>
<td headers="standard provisionedthroughputcapacity-queriespersecond">50</td>
<td headers="standard provisionedthroughputcapacity-queriespersecond">250</td>
<td headers="standard provisionedthroughputcapacity-queriespersecond">1.000</td>
</tr>
<tr>
<th id="diskspaceincluded" headers="capacity-config-plan">Espacio de disco incluido</td>
<td headers="lite diskspaceincluded">1 GB</td>
<td headers="standard diskspaceincluded" colspan='4'>20 GB</td>
</tr>
<tr>
<th id="diskoveragepergbhour" headers="capacity-config-plan">Excedente de disco (por GB/hora)</td>
<td headers="lite diskoveragepergbhour">No disponible</td>
<td headers="standard diskoveragepergbhour" colspan='4'>Consulte los <a href="../offerings/pricing.html#pricing" target="_blank">detalles sobre precios <img src="../images/launch-glyph.svg" alt="Icono de enlace externo" title="Icono de enlace externo"></a>.</td>
</tr>

</table>

## Planes
{: #plans}

Puede seleccionar el plan que desea utilizar cuando [suministre su instancia de servicio de {{site.data.keyword.cloudant_short_notm}}](#provisioning-a-cloudant-nosql-db-instance-on-ibm-cloud).
De forma predeterminada, se selecciona el [plan Lite](#lite-plan).

![Selección del plan de instancia de servicio de {{site.data.keyword.cloudant_short_notm}}](../images/lite_pricing_plan.png)

### Plan Lite
{: #lite-plan}

El plan Lite es gratuito y está diseñado para propósitos de desarrollo y evaluación. Se incluye la funcionalidad completa de {{site.data.keyword.cloudant_short_notm}}, pero las instancias del plan Lite tienen una cantidad fija de rendimiento suministrada y de almacenamiento de datos. La capacidad de rendimiento suministrada se fija en 20 búsquedas/seg, 10 escrituras/seg, 5 consultas/seg y el almacenamiento de datos se limita a 1 GB. 

El uso de almacenamiento se comprueba a diario. Si supera el límite de almacenamiento de 1 GB, las solicitudes a la instancia de {{site.data.keyword.cloudant_short_notm}} reciben un código de estado 402 con un mensaje de error que indica "La cuenta ha superado su cuota de uso de datos. Es necesario actualizar a un plan de pago."
También aparece un banner en el panel de control de {{site.data.keyword.cloudant_short_notm}}. Puede seguir leyendo y suprimiendo datos. Sin embargo, para escribir nuevos datos, tiene dos opciones. En primer lugar, puede actualizar a un [plan estándar](#standard-plan) pagado que elimina la limitación de grabación de forma inmediata. De forma alternativa, puede suprimir datos para que el almacenamiento total esté comprendido en el límite de 1 GB, y esperar a que se ejecute la siguiente comprobación de almacenamiento diario para que la instancia vuelva a permitir las escrituras. 

Si desea almacenar más de 1 GB de datos o poder escalar la capacidad de rendimiento suministrada, pase a un [plan estándar](#standard-plan).

Está limitado a una instancia de plan Lite de {{site.data.keyword.cloudant_short_notm}} por cuenta de {{site.data.keyword.cloud_notm}}. Si ya dispone de una instancia del plan Lite, cualquier intento de crear una nueva o de cambiar de una instancia del plan estándar a una del plan Lite devuelve el mensaje "Solo puede tener una instancia del plan Lite por servicio. Para crear una nueva instancia, suprima la instancia del plan Lite existente o seleccione un plan de pago". 
{: tip}

### Plan Estándar
{: #standard-plan}

El plan estándar de {{site.data.keyword.cloudant_short_notm}} está disponible para todas las cuentas de {{site.data.keyword.cloud}} de pago, ya sean de pago según uso o suscripción, y escala para satisfacer las necesidades de la aplicación. El precio del plan estándar se basa en dos factores: la capacidad de rendimiento suministrada que se asigna y la cantidad de datos que se almacenan en la instancia. 

El establecimiento de precios es por hora prorrateada con una capacidad de rendimiento suministrado de 10 búsquedas/seg, 50 escrituras/seg y 5 consultas/seg equivalentes a un coste inicial en dólares de 0,105/hora. Puede aumentar o disminuir la capacidad de rendimiento suministrado de 100 búsquedas/seg, 50 escrituras/seg y 5 consultas/seg en el panel de control de {{site.data.keyword.cloudant_short_notm}}. Se calculan los costes de la capacidad de rendimiento suministrado que se asigna y no del volumen medido de las solicitudes. El plan Estándar incluye 20 GB de almacenamiento de datos. Si almacena más de 20 GB, se le facturará un coste definido por GB por hora. 

Consulte la calculador de tarifas de {{site.data.keyword.cloud_notm}} para el establecimiento de precios en distintas capacidades y monedas, y la información sobre el [establecimiento de precios](../offerings/pricing.html#pricing){:new_window} para obtener ejemplos y estimar costes.

### Plan de hardware dedicado
{: #dedicated-hardware-plan}

Una instancia de plan de hardware de {{site.data.keyword.cloudant_short_notm}} dedicado es un entorno nativo de {{site.data.keyword.cloudant_short_notm}} que se suministra para el uso exclusivo de las instancias del plan estándar de {{site.data.keyword.cloudant_short_notm}}. Es posible suministrar un entorno de plan de hardware de {{site.data.keyword.cloudant_short_notm}} dedicado en cualquier centro de datos de [{{site.data.keyword.IBM}} ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/cloud-computing/bluemix/data-centers). Este plan es necesario para la conformidad de HIPAA y se debe seleccionar en el tiempo de suministro. Además, los usuarios de un entorno del plan Hardware dedicado de {{site.data.keyword.cloudant_short_notm}} pueden emplear las claves de cifrado gestionadas por el cliente de BYOK (Bring-Your-Own-Key) y de lista blanca de IP con IBM Key Protect. 

Puede suministrar una o varias instancias del plan estándar, y el entorno de hardware dedicado se expandirá o contraerá según sea necesario en función de la capacidad y los datos que utilizan las instancias del plan estándar. Se trata de un precio fijo adicional al precio de consumo de las instancias del plan estándar de {{site.data.keyword.cloudant_short_notm}}. La facturación se prorratea diariamente, y hay una duración mínima de 1 mes que se cargará en el entorno. El suministro de un plan de Hardware dedicado de {{site.data.keyword.cloudant_short_notm}} es asíncrono y puede tardar entre 5 y 7 días hábiles. Para crear una instancia del plan de Hardware dedicado de {{site.data.keyword.cloudant_short_notm}} y suministrarle una instancia del plan estándar, siga la guía de aprendizaje [Creación y optimización de una instancia del plan de Hardware dedicado de {{site.data.keyword.cloudant_short_notm}} en {{site.data.keyword.cloud_notm}} ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](../tutorials/create_dedicated_hardware_plan.html#creating-and-leveraging-a-cloudant-dedicated-hardware-plan-instance-on-bluemix){:new_window}. 

El plan de Hardware dedicado no está disponible para los clientes de {{site.data.keyword.cloud_notm}} dedicado. Solo está disponible para los clientes de {{site.data.keyword.cloud_notm}} público.
{: tip}

## Capacidad de rendimiento suministrado
{: #provisioned-throughput-capacity}

El suministro de rendimiento se identifica y se mide como uno de los siguientes tipos de sucesos:

1.	Una búsqueda, que es una lectura de un documento específico, que se basa en el `_id` del documento.
2.	Una escritura, que es la creación, modificación o supresión de un documento individual, o cualquier actualización derivada de la creación de un índice.
3.	Una consulta,
    que es una solicitud hecha a uno de los puntos finales de consulta de {{site.data.keyword.cloudant_short_notm}},
    que incluye los tipos siguientes:
	-	Índice primario ([`_all_docs`](../api/database.html#get-documents))
	-	Vista MapReduce ([`_view`](../api/creating_views.html#using-views))
	-	Índice de búsqueda ([`_search`](../api/search.html#queries))
	-	Índice geoespacial ([`_geo`](../api/cloudant-geo.html#querying-a-cloudant-geo-index))
	-	Consulta de {{site.data.keyword.cloudant_short_notm}} ([`_find`](../api/cloudant_query.html#finding-documents-using-an-index))

La medida de rendimiento es un simple recuento del número de sucesos de cada tipo, por segundo, donde el segundo es una ventana _deslizante_.
Si la cuenta supera el número de sucesos de rendimiento que se suministran para el plan, las solicitudes se rechazan hasta que el número de sucesos de la ventana deslizante deja de superar el número que se suministra.
Para comprenderlo mejor, piense que la ventana deslizante de 1 segundo es un periodo consecutivo de 1.000 milisegundos.

Por ejemplo, el plan Estándar se suministra para 200 búsquedas por segundo. La cuenta puede realizar un máximo de 200 solicitudes de búsqueda durante un periodo consecutivo de 1.000 milisegundos (1 segundo). Las siguientes solicitudes de búsqueda que se realicen durante el periodo deslizante de 1.000 milisegundos se rechazan hasta que el número de solicitudes de búsqueda de dicho periodo vuelve a caer por debajo de las 200.

Cuando se rechaza una solicitud porque se ha superado el número de sucesos, las aplicaciones reciben la respuesta [`429` Demasiadas solicitudes](../api/http.html#429).

Las versiones recientes de las bibliotecas de cliente admitidas (para lenguajes [Java](../libraries/supported.html#java), [Node.js](../libraries/supported.html#node-js) y [Python](../libraries/supported.html#python)) le ayudan a manejar una respuesta `429`.
Por ejemplo,
la biblioteca Java genera una
respuesta [`TooManyRequestsException` ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](http://static.javadoc.io/com.cloudant/cloudant-client/2.5.1/com/cloudant/client/org/lightcouch/TooManyRequestsException.html){:new_window}.

De forma predeterminada, las bibliotecas de cliente admitidas no vuelven a intentar automáticamente una solicitud cuando se recibe una respuesta `429`.

Es mejor asegurarse de que la aplicación maneja las respuestas `429` correctamente.
La razón es que el número de reintentos es limitado; el incumplimiento repetido del número de solicitudes es un potente indicador para pasar a una configuración de plan diferente.

Si está portando una aplicación existente, es posible que no pueda manejar una respuesta `429`. Como parte de la verificación de la migración, compruebe que la aplicación maneja correctamente las respuestas `429`.
{: tip}

En resumen, debe asegurarse de que la aplicación es capaz de manejar una respuesta [`429`](../api/http.html#429) correctamente.

<div id="servicetier"></div>

### Capacidad de visualización y modificación
{: #viewing-and-changing-capacity}

Puede ver los detalles de la capacidad de rendimiento de los planes disponibles para su cuenta.
Puede seleccionar el nivel de suministro que desea utilizar mediante el separador Cuenta del panel de control de la cuenta de {{site.data.keyword.cloudant_short_notm}}.

![Panel de control de la cuenta](../images/cloudant_capacity.png)

Para moverse a una capacidad de rendimiento diferente, seleccione el suministro que
desee y pulse `Actualizar`. Se le solicitará que confirme el cambio y se le recordará que el cambio de suministro puede tardar hasta 24 horas en completarse.

![Panel de control de la cuenta](../images/cloudant_capacity_change.png)

El tamaño del aumento de capacidad se limita a 10 unidades (1000 búsquedas/seg, 500 escrituras/seg y 50 consultas/seg) por cambio. Las reducciones no están limitadas por el número de unidades. Cualquier cambio en la capacidad, ya sea un aumento o una reducción, se limita a una vez por hora. Si necesita más capacidad de la que hay disponible en el panel de control de {{site.data.keyword.cloudant_short_notm}}, póngase en contacto con el soporte de [{{site.data.keyword.cloudant_short_notm}} ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](mailto:support@cloudant.com){:new_window}.
{: tip}

<div id="throughput"></div>

### Supervisión del uso 
{: #monitoring-usage}

Hay disponible información acerca del uso en el panel Operaciones actuales del separador Supervisión en el panel de control de {{site.data.keyword.cloudant_short_notm}}. 

![Supervisión del uso en el panel de control](../images/cloudant_usage.png)

Allí encontrará detalles que ilustran el [rendimiento](#provisioned-throughput-capacity) actual y la cantidad de [datos almacenados](#disk-space-included).

La supervisión le ayuda a reconocer que puede haber llegado el momento de cambiar el suministro en el plan.
Por ejemplo, si suele acercarse al número máximo de búsquedas en la base de datos, puede modificar el suministro a través del [panel Servicio](#servicetier) del separador Cuenta del panel de control.

## Uso de datos
{: #data-usage}

### Espacio de disco incluido
{: #disk-space-included}

Este valor es la capacidad de almacenamiento que se incluye en el plan.
Se utiliza tanto para los datos y como para almacenamiento de índices.

### Excedente de disco
{: #disk-overage}

Todos los planes Lite y estándar incluyen espacio de disco, que se utiliza para datos JSON, archivos adjuntos e índices. En todos los planes Estándar y Lite se supervisa el espacio de disco utilizado. Cuando utiliza más datos de los que asigna el plan, puede prever que se apliquen las condiciones descritas en la tabla siguiente:

<table>

<tr>
<th id="disk-overage-plan">Plan</th><th id="description">Descripción</th>
</tr>
<tr>
<th headers="standard-plan">Estándar</td>
<td headers="description"><p>
<ul><li>Si la cuenta utiliza más de la cantidad de almacenamiento que se asigna en la configuración del plan, se considera que hay un 'desbordamiento'. Un desbordamiento hace que la cuenta se facture al precio indicado por cada GB adicional utilizado por encima de la asignación del plan.</li>
<li>La cantidad adicional de dinero que debe pagar para utilizar más espacio de disco que el que se proporciona en el plan se denomina 'excedente'. Un excedente se calcula por hora.</li></ul></p></td>
</tr>
<tr>
<th headers="lite-plan">Lite</td>
<td headers="description"><p>
<ul><li>El uso de disco está limitado en el plan Lite. Una vez alcanzado el límite, no podrá escribir nuevos datos. Para escribir datos nuevos, debe actualizar al plan estándar o suprimir datos y esperar hasta que se ejecute la siguiente comprobación para que se reactive la cuenta.</p>
</li></ul></td>
</tr>
</table>

Por ejemplo, supongamos que el plan estándar aumenta el uso de disco a 107 GB durante medio día (12 horas). Este cambio significa que la instancia ha causado un desbordamiento de 87 GB por encima de la asignación del plan de 20 GB, durante 12 horas.
Por lo tanto, se le facturaría un cargo de excedente de 87 GB x 12 horas = 1044 GB horas correspondiente a este espacio adicional.

El excedente se calcula utilizando el número máximo de GB por encima de la asignación del plan durante una hora determinada dentro del ciclo de facturación.

### Ejemplo de excedente de disco
{: #disk-overage-example}

Supongamos que comienza un mes de 30 días con una instancia de servicio del plan Estándar que utiliza 9 GB de almacenamiento.
Posteriormente, el almacenamiento aumenta
a 21,5 GB durante 15 durante la hora que comienza a las 02:00 del día 3.
La instancia vuelve a caer a 9,5 GB durante los 10 minutos siguientes de la hora 02:00,
y luego aumenta a 108 durante los 25 minutos siguientes de la hora 02:00.
Por último, la instancia finaliza la hora y el resto del mes volviendo a 28 GB.

Este patrón significa que el número máximo de GB por encima de la asignación del plan ha sido de 88 GB durante la hora 2 del día 3.
Para la hora 03:00 del día 3,
y durante el resto del mes, la instancia ha utilizado
8 GB más que la asignación del plan.

Por lo tanto,
para la 02:00 del día 3,
su factura incluye un excedente de 88 GB x 1 hora = 88 GB horas.

Para el periodo comprendido entre la hora 03:00 del día 3 y el final del día 3,
su factura incluye un excedente de 8 GB x 21 horas = 168 GB horas.

Para el periodo comprendido entre la hora 00:00 del día 4 y el final del mes (de 30 días),
la factura incluye un excedente de 8 GB x 24 horas x 27 días = 5184 GB horas.

La factura de excedente total del mes se basa en el total de 88 + 168 + 5184 = 5440 GB horas.

## Límites de tamaño de solicitud y de documentos
{: #request-and-document-size-limits}

Los documentos y las solicitudes JSON de {{site.data.keyword.cloudant_short_notm}} tienen los siguientes
límites de tamaño máximos: 

Límite | Tamaño máximo
------|-------------
Tamaño de documento individual | 1 MB
Tamaño de archivo adjunto único | 10 MB
Tamaño de cuerpo de solicitud | 11 MB

Superar cualquiera de estos límites da lugar a una [respuesta 413](../api/http.html#413).

Se recomienda almacenar archivos adjuntos binarios, o blobs JSON grandes,
en el almacenamiento de objetos y guardar un enlace a la ubicación en un documento JSON de {{site.data.keyword.cloudant_short_notm}}.   

Cuando se duplican, los documentos o los archivos adjuntos más grandes que estos límites no se
replican en la base de datos de destino. Puede encontrar más información sobre cómo detectar errores de replicación
[aquí](../api/replication.html#replication-errors).

## Ubicaciones y arrendamiento
{: #locations-and-tenancy}

De forma predeterminada, todos los planes Lite y estándar se despliegan en entornos multiarrendatario. Como parte de la selección del plan, puede elegir entre las siguientes regiones de {{site.data.keyword.cloud_notm}} Público:

-   EE.UU. este
-   EE.UU. sur
-   Reino Unido
-   Sídney
-   Alemania&Dagger;
-   AP norte (Tokio)

Las instancias del plan de hardware dedicado pueden desplegarse en la mayoría de las [ubicaciones de centros de datos de {{site.data.keyword.IBM_notm}} ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/cloud-computing/bluemix/data-centers). 
Consulte el menú desplegable en el catálogo de {{site.data.keyword.cloud_notm}} para obtener una lista actualizada de las ubicaciones disponibles.

&Dagger;Todas las instancias de {{site.data.keyword.cloudant_short_notm}} que se despliegan desde la
región Alemania de {{site.data.keyword.cloud_notm}} público
se despliegan en entornos gestionados por la UE. No se podrá otorgar acceso a cualquier cuenta o clave de API de {{site.data.keyword.cloudant_short_notm}} generada
fuera de un entorno gestionado por la UE a una instancia de
{{site.data.keyword.cloudant_short_notm}} gestionada por la UE.

## Métodos de autenticación
{: #authentication-methods}

Se accede a {{site.data.keyword.cloudant_short_notm}} utilizando una API HTTPS. Si el punto final de la API lo requiere, se autentica al usuario para cada solicitud HTTPS que {{site.data.keyword.cloudant_short_notm}} recibe. Durante el suministro, los métodos de autenticación disponibles incluyen 'Utilizar credenciales heredadas y de IAM' o 'Utilizar solo IAM'. Para obtener más información, consulte la [guía de IAM](../guides/iam.html){:new_window} o el [documento de la API de autenticación](../api/authentication.html){:new_window} heredada.

Después de suministrar una instancia de {{site.data.keyword.cloudant_short_notm}}, es posible buscar el URL de conexión y los detalles de autorización de IAM al generar nuevas credenciales en el separador Credenciales de servicio del panel de control de {{site.data.keyword.cloud_notm}}. Si selecciona esta opción durante el suministro, también se incluirán el nombre de usuario y la contraseña de {{site.data.keyword.cloudant_short_notm}} heredados.


## Alta disponibilidad, recuperación de desastres y copia de seguridad
{: #high-availability-disaster-recovery-and-backup}

Para proporcionar alta disponibilidad (HA) y recuperación en caso de error (DR) en un centro de datos, todos los datos se almacenan por triplicado en tres servidores físicos distintos de un clúster. Puede suministrar cuentas en varios centros de datos y utilizar la réplica de datos continua para proporcionar HA/DR entre los centros de datos. No se realiza una copia de seguridad automática de {{site.data.keyword.cloudant_short_notm}}, pero se proporcionan las herramientas soportadas para gestionar las copias de seguridad. Revise [Guía de copia de seguridad y recuperación tras desastre ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://console.bluemix.net/docs/services/Cloudant/guides/disaster-recovery-and-backup.html#disaster-recovery-and-backup) para explorar las consideraciones sobre HA, DR y copias de seguridad para cumplir con los requisitos de la aplicación.. 

## Soporte
{: #support}

El soporte correspondientes a las instancias de servicio del plan Estándar y Dedicado es opcional.
Se suministra cuando se adquiere el soporte estándar de *{{site.data.keyword.cloud_notm}}*. El soporte no está disponible para el plan Lite.

Para obtener más información acerca de los planes de soporte, consulte Planes de soporte estándar de [{{site.data.keyword.cloud_notm}} ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/cloud/support#944376){:new_window}. Para obtener más información sobre el soporte, consulte [Guía de soporte de {{site.data.keyword.IBM_notm}} ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/support/home/pages/support-guide/){:new_window}.

Los sistemas de soporte utilizados para {{site.data.keyword.cloudant_short_notm}} no ofrecen funciones de protección de contenido que incluya información sanitaria, datos sobre la salud, información protegida sobre salud, ni otros datos sujetos a requisitos normativos adicionales. Por lo tanto, el cliente no debe especificar o proporcionar dichos datos.
{: tip}

## Suministro de una instancia de {{site.data.keyword.cloudant_short_notm}} en {{site.data.keyword.cloud_notm}}
{: #provisioning-a-cloudant-nosql-db-instance-on-ibm-cloud}

Puede suministrar una instancia de los planes Lite o Estándar de {{site.data.keyword.cloudant_short_notm}} en {{site.data.keyword.cloud_notm}} de dos formas:

- Utilización del panel de control. Encontrará una guía de aprendizaje en la que se describe el proceso [aquí ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://console.bluemix.net/docs/services/Cloudant/tutorials/create_service.html#creating-a-cloudant-instance-on-bluemix){:new_window}.
- Mediante la herramienta de mandatos de Cloud Foundry. Encontrará una guía de aprendizaje en la que se describe el proceso [aquí ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://console.bluemix.net/docs/services/Cloudant/tutorials/create_service_cli.html#creating-a-cloudant-instance-on-bluemix-using-the-cloud-foundry-tools){:new_window}.
 
Para crear y optimizar una instancia del plan de hardware dedicado de {{site.data.keyword.cloudant_short_notm}}, siga la guía de aprendizaje en la que se describe el proceso [aquí ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://console.bluemix.net/docs/services/Cloudant/tutorials/create_dedicated_hardware_plan.html#creating-and-leveraging-a-cloudant-dedicated-hardware-plan-instance-on-bluemix){:new_window}.




