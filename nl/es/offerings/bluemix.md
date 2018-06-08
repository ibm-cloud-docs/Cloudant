---

copyright:
  years: 2015, 2018
lastupdated: "2017-12-11"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-02-23 -->

# {{site.data.keyword.Bluemix_notm}} público

{{site.data.keyword.cloudantfull}} público es la oferta de {{site.data.keyword.cloudant_short_notm}} más rica en características que primero recibe actualizaciones y nuevas características. El precio se basa en los requisitos de rendimiento y almacenamiento, lo que hace que sea adecuada para cualquier carga necesaria. 

Existe un [plan Lite](#lite-plan) con una cantidad fija de capacidad de rendimiento y datos para el desarrollo y evaluación. También hay un [plan estándar](#standard-plan) de pago que ofrece precios de almacenamiento de datos y capacidad de rendimiento configurables y que escala a medida que cambian los requisitos de su aplicación.  Además hay disponible un [plan de hardware dedicado](#dedicated-hardware-plan) por una cuota mensual adicional para ejecutar una o varias instancias del plan estándar en un entorno de hardware dedicado. El entorno de hardware dedicado es para uso exclusivo del usuario y si la instancia del plan de hardware dedicado se suministra en una ubicación de EE.UU., de forma opcional, puede seleccionar una configuración conforme con la [HIPAA ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://en.wikipedia.org/wiki/Health_Insurance_Portability_and_Accountability_Act){:new_window}.

La tabla siguiente resume la capacidad de rendimiento y configuración del espacio de disco suministrados en los planes:

<table border='1'>

<tr>
<th>Planes</th><th>Lite</th><th colspan='4'>Estándar</th>
</tr>
<tr>
<td>Precio base (por hora)</td>
<td>0,00 $</td>
<td colspan='4'>Consulte los <a href="https://www.ibm.com/cloud/cloudant/pricing" target="_blank">detalles sobre precios <img src="../images/launch-glyph.svg" alt="Icono de enlace externo" title="Icono de enlace externo"></a>.</td>
</tr>
<tr>
<td>Capacidad de rendimiento suministrada (búsquedas por segundo)</td>
<td>20</td>
<td>100</td>
<td>1.000</td>
<td>5.000</td>
<td>20.000</td>
</tr>
<tr>
<td>Capacidad de rendimiento suministrada (escrituras por segundo)</td>
<td>10</td>
<td>50</td>
<td>500</td>
<td>2.500</td>
<td>10.000</td>
</tr>
<tr>
<td>Capacidad de rendimiento suministrada (consultas por segundo)</td>
<td>5</td>
<td>5</td>
<td>50</td>
<td>250</td>
<td>1.000</td>
</tr>
<tr>
<td>Tamaño máximo de un documento individual</td>
<td>1 MB</td>
<td colspan='4'>1 MB</td>
</tr>
<tr>
<td>Espacio de disco incluido</td>
<td>1 GB</td>
<td colspan='4'>20 GB</td>
</tr>
<tr>
<td>Excedente de disco (por GB/hora)</td>
<td>No disponible</td>
<td colspan='4'>Consulte los <a href="https://www.ibm.com/cloud/cloudant/pricing" target="_blank">detalles sobre precios <img src="../images/launch-glyph.svg" alt="Icono de enlace externo" title="Icono de enlace externo"></a>.</td>
</tr>

</table>

## Planes

Puede seleccionar el plan que desea utilizar cuando [suministre su instancia de servicio de {{site.data.keyword.cloudant_short_notm}}](#provisioning-a-cloudant-instance-on-bluemix).
De forma predeterminada, se selecciona el [plan Lite](#lite-plan).

![Selección del plan de la instancia de servicio de {{site.data.keyword.cloudant_short_notm}}](../images/fb87416a.png)

### Plan Lite

El plan Lite es gratuito, pero le limita a un máximo de 1 GB de almacenamiento de datos.
También impone límites en cuanto a la capacidad del rendimiento suministrado para búsquedas, escrituras y consultas. 

El uso de almacenamiento se comprueba a diario. Si supera el límite de almacenamiento, las solicitudes HTTP a la cuenta reciben un código de estado 402 con un mensaje de error que indica que "la cuenta ha superado su cuota de uso de datos. Es necesario actualizar a un plan de pago."
También aparece una cabecera en el panel de control de {{site.data.keyword.cloudant_short_notm}} que le informa sobre esta situación. Puede seguir leyendo y suprimiendo datos. Pero, para escribir datos nuevos, debe actualizar a una cuenta de pago o suprimir datos y esperar hasta que se ejecute la siguiente comprobación para que se reactive la cuenta. 

Si desea almacenar más de un GB de datos, o desea obtener una capacidad de rendimiento superior, pase a un [plan Estándar](#standard-plan).

### Plan Estándar

El plan Estándar incluye 20 GB de almacenamiento de datos.
Si almacena más de 20 GB, se le facturará un coste definido por GB por hora.
Consulte la información sobre [precios ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/cloud/cloudant/pricing){:new_window} para ver el coste actual.
En el plan Estándar, también puede cambiar la cantidad de capacidad del rendimiento suministrado para búsquedas, escrituras y consultas.

### Plan de hardware dedicado

De forma opcional, puede ejecutar las instancias del plan estándar en un entorno de hardware dedicado en cualquier [centro de datos de {{site.data.keyword.IBM}}![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/cloud-computing/bluemix/data-centers) por una cuota mensual. Puede adquirir un único plan de hardware dedicado para una ubicación determinada y suministrar una o varias instancias del plan estándar. Este plan es necesario para la conformidad de HIPAA y se debe seleccionar en el tiempo de suministro. Tenga en cuenta que el plan de hardware dedicado no está disponible para los clientes de {{site.data.keyword.Bluemix_notm}} dedicado y que solo está disponible para los clientes de {{site.data.keyword.Bluemix_notm}} público.

## Capacidad de rendimiento suministrado

El suministro de rendimiento se identifica y se mide como uno de estos tres tipos de sucesos:

1.	Una búsqueda, que es una lectura de un documento específico, que se basa en el `_id` del documento.
2.	Una escritura, que es la creación, modificación o supresión de un documento individual, o cualquier actualización derivada de la creación de un índice.
3.	Una consulta, que es una solicitud hecha a uno de los puntos finales de consulta de {{site.data.keyword.cloudant_short_notm}}, que incluye los tipos siguientes:
	-	Índice primario ([`_all_docs`](../api/database.html#get-documents))
	-	Vista MapReduce ([`_view`](../api/creating_views.html#using-views))
	-	Índice de búsqueda ([`_search`](../api/search.html#queries))
	-	Índice geoespacial ([`_geo`](../api/cloudant-geo.html#querying-a-cloudant-geo-index))
	-	Consulta de {{site.data.keyword.cloudant_short_notm}} ([`_find`](../api/cloudant_query.html#finding-documents-using-an-index))

La medida de rendimiento es un simple recuento del número de sucesos de cada tipo, por segundo, donde el segundo es una ventana _deslizante_.
Si la cuenta supera el número de sucesos de rendimiento que se suministran para el plan, las solicitudes se rechazan hasta que el número de sucesos de la ventana deslizante deja de superar el número que se suministra.
Para comprenderlo mejor, piense que la ventana deslizante de 1 segundo es un periodo consecutivo de 1.000 milisegundos.

Por ejemplo, si tiene un plan Estándar que suministra
200 búsquedas por segundo,
la cuenta puede realizar un máximo de 200 solicitudes de búsqueda durante un periodo consecutivo de 1.000 milisegundos (1 segundo).
Las siguientes solicitudes de búsqueda que se realicen durante el periodo deslizante de 1.000 milisegundos se rechazan hasta que el número de solicitudes de búsqueda de dicho periodo vuelve a caer por debajo de las 200.

Cuando se rechaza una solicitud porque se ha superado el número de sucesos, las aplicaciones reciben la respuesta [`429` Demasiadas solicitudes](../api/http.html#429).

Las versiones recientes de las bibliotecas de cliente admitidas (para lenguajes [Java](../libraries/supported.html#java), [Node.js](../libraries/supported.html#node-js) y [Python](../libraries/supported.html#python)) le ayudan a manejar una respuesta `429`.
Por ejemplo, la biblioteca
Java emite
[`TooManyRequestsException` ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](http://static.javadoc.io/com.cloudant/cloudant-client/2.5.1/com/cloudant/client/org/lightcouch/TooManyRequestsException.html){:new_window}.

De forma predeterminada, las bibliotecas de cliente admitidas no vuelven a intentar automáticamente una solicitud cuando se recibe una respuesta `429`.

Es mejor asegurarse de que la aplicación maneja las respuestas `429` correctamente.
La razón es que el número de reintentos es limitado; el incumplimiento repetido del número de solicitudes es un potente indicador para pasar a una configuración de plan diferente.

>   **Nota**: Si está trasladando una aplicación existente,
    es posible que no pueda manejar una respuesta `429`.
    Como parte de la verificación de la migración, compruebe que la aplicación maneja correctamente las respuestas `429`.

En resumen, debe asegurarse de que la aplicación es capaz de manejar una respuesta [`429`](../api/http.html#429) correctamente.

<div id="servicetier"></div>

### Capacidad de visualización y modificación

Puede ver los detalles de la capacidad de rendimiento de los planes disponibles para su cuenta.
Puede seleccionar el nivel de suministro que desea utilizar, a través del separador Cuenta del panel de control de la cuenta de {{site.data.keyword.cloudant_short_notm}}.

![Panel de control de la cuenta](../images/cloudant_capacity.png)

Para cambiar la capacidad de rendimiento, seleccione el suministro desea y pulse el botón de opción `Cambiar capacidad`.
Se le solicitará que confirme el cambio y se le recordará que el cambio de suministro puede tardar hasta 24 horas en completarse.

![Panel de control de la cuenta](../images/cloudant_capacity_change.png)

<div id="throughput"></div>

### Supervisión del uso 

Encontrará información sobre el uso en el panel Operaciones actuales del separador Supervisión en el panel de control de {{site.data.keyword.cloudant_short_notm}}. 

![Supervisión del uso en el panel de control](../images/cloudant_usage.png)

Allí encontrará detalles que ilustran el [rendimiento](#provisioned-throughput-capacity) actual y la cantidad de [datos almacenados](#disk-space-included).

La supervisión le ayuda a reconocer que puede haber llegado el momento de cambiar el suministro en el plan.
Por ejemplo, si suele acercarse al número máximo de búsquedas en la base de datos, puede modificar el suministro a través del [panel Servicio](#servicetier) del separador Cuenta del panel de control.

## Uso de datos

### Espacio de disco incluido

Este valor es la capacidad de almacenamiento incluida en el plan.
Se utiliza tanto para los datos y como para almacenamiento de índices.

### Excedente de disco

En todas las instancias de servicio del plan Estándar y Lite se supervisa el espacio de disco utilizado.
Si la cuenta utiliza más de la cantidad de almacenamiento que se suministra en la configuración del plan, se considera que hay un 'desbordamiento'.
Un desbordamiento hace que la cuenta se facture al precio indicado por cada GB adicional utilizado por encima de la asignación del plan.

La cantidad adicional de dinero que debe pagar por utilizar más espacio de disco que el que se proporciona en el plan se denomina 'excedente'.
El excedente se calcula por hora.
No se puede desbordar el espacio de disco disponible en el plan Lite.

Por ejemplo, supongamos que la instancia del plan Estándar aumenta el uso de disco a 107 GB durante medio día (12 horas).
Este cambio significa que la instancia ha causado un desbordamiento de 87 GB por encima de la asignación del plan de 20 GB, durante 12 horas.
Por lo tanto, se le facturaría un cargo de excedente de 87 GB x 12 horas = 1044 GB horas correspondiente a este espacio adicional.

El excedente se calcula utilizando el número máximo de GB por encima de la asignación del plan durante una hora determinada dentro del ciclo de facturación.

### Ejemplo de excedente de disco

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

Por lo tanto, para la 02:00 del día 3 se le facturará
un excedente de 88 GB x 1 hora = 88 GB horas.

Para el periodo comprendido entre la hora 03:00 del día 3 y el final del día 3,
se le facturará un excedente de 8 GB x 21 horas = 168 GB horas.

Para el periodo comprendido entre la hora 00:00 del día 4 y el final del mes (de 30 días),
se le facturará un excedente de 8 GB x 24 horas x 27 días = 5184 GB horas.

La factura de excedente total del mes sería el total de 88 + 168 + 5184 = 5440 GB horas.

### Tamaño máximo de un documento individual

Los datos se almacenan en {{site.data.keyword.cloudant_short_notm}} como [documentos JSON](../api/document.html).
Para los documentos de un servicio {{site.data.keyword.cloudant_short_notm}} en {{site.data.keyword.Bluemix_notm}}, el tamaño máximo de un documento individual es 1 MB.
Si se supera este límite, se genera un error [`413`](../api/http.html#413).

## Ubicaciones y arrendamiento

De forma predeterminada, todos los planes Lite y estándar se despliegan en entornos multiarrendatario. Como parte de la selección del plan, puede elegir entre las siguientes regiones de {{site.data.keyword.Bluemix_notm}} Público:

-   EE.UU. Sur
-   Reino Unido
-   Sídney
-   Alemania

Las instancias del plan de hardware dedicado pueden desplegarse en la mayoría de las [ubicaciones de centros de datos de {{site.data.keyword.IBM_notm}} ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/cloud-computing/bluemix/data-centers). 
Consulte el menú desplegable en el catálogo de {{site.data.keyword.Bluemix_notm}} para obtener una lista actualizada de las ubicaciones disponibles.

## Seguridad, cifrado y conformidad

Todos los planes se suministran en servidores con cifrado de disco [en reposo ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://en.wikipedia.org/wiki/Data_at_rest){:new_window}.
El acceso se cifra sobre una conexión de red mediante HTTPS.
Para obtener más destalles, consulte [Seguridad de {{site.data.keyword.Bluemix_notm}} ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://console.bluemix.net/docs/services/Cloudant/offerings/security.html#security){:new_window}.

Los planes también ofrecen un [Certificado de conformidad de seguridad![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://cloudant.com/product/cloudant-features/cloudant-compliance/){:new_window}.
La conformidad [HIPAA ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://en.wikipedia.org/wiki/Health_Insurance_Portability_and_Accountability_Act){:new_window}
necesita un [entorno dedicado](#dedicated-hardware-plan), de modo que debe solicitar este entorno como parte del [proceso de suministro](#provisioning-a-cloudant-instance-on-bluemix).

## Alta disponibilidad, recuperación de desastres y copia de seguridad

Para proporcionar alta disponibilidad (HA) y recuperación en caso de error (DR) en un centro de datos, todos los datos se almacenan por triplicado en tres servidores físicos distintos de un clúster. Puede suministrar cuentas en varios centros de datos y utilizar la réplica de datos continua para proporcionar HA/DR entre los centros de datos. No se hace copia de seguridad automática de los datos de {{site.data.keyword.cloudant_short_notm}}, pero se proporciona un conjunto de herramientas de soporte para gestionar las copias de seguridad. Revise [Guía de copia de seguridad y recuperación tras desastre ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://console.bluemix.net/docs/services/Cloudant/guides/disaster-recovery-and-backup.html#disaster-recovery-and-backup) para explorar las consideraciones sobre HA, DR y copias de seguridad para cumplir con los requisitos de la aplicación.. 

## Soporte

El soporte correspondientes a las instancias de servicio del plan Estándar y Dedicado es opcional.
Se suministra cuando se adquiere el "Soporte estándar de {{site.data.keyword.Bluemix}}".
El soporte no está disponible para el plan Lite.

Dispone de una calculadora de precios para el soporte Estándar de {{site.data.keyword.Bluemix_notm}} [aquí![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://console.ng.bluemix.net/?direct=classic/#/pricing/cloudOEPaneId=pricing&paneId=pricingSheet){:new_window}.
Encontrará información sobre los detalles del Acuerdo de nivel de servicio de soporte (SLA) [aquí ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](http://www-03.ibm.com/software/sla/sladb.nsf/pdf/6606-08/$file/i126-6606-08_05-2016_en_US.pdf){:new_window}.

## Suministro de una instancia de {{site.data.keyword.cloudant_short_notm}} en {{site.data.keyword.Bluemix_notm}}

Puede suministrar una instancia de los planes Lite o estándar de {{site.data.keyword.cloudant_short_notm}} en {{site.data.keyword.Bluemix}} de dos formas:

- Mediante el panel de control. Encontrará una guía de aprendizaje en la que se describe el proceso [aquí ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://console.bluemix.net/docs/services/Cloudant/tutorials/create_service.html#creating-a-cloudant-instance-on-bluemix){:new_window}.
- Mediante la herramienta de mandatos de Cloud Foundry. Encontrará una guía de aprendizaje en la que se describe el proceso [aquí ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://console.bluemix.net/docs/services/Cloudant/tutorials/create_service_cli.html#creating-a-cloudant-instance-on-bluemix-using-the-cloud-foundry-tools){:new_window}.
 
Para crear y optimizar una instancia del plan de hardware dedicado de {{site.data.keyword.cloudant_short_notm}}, siga la guía de aprendizaje en la que se describe el proceso [here ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://console.bluemix.net/docs/services/Cloudant/tutorials/create_dedicated_hardware_plan.html#creating-and-leveraging-a-cloudant-dedicated-hardware-plan-instance-on-bluemix){:new_window}.




