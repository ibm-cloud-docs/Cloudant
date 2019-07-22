---

copyright:
  years: 2015, 2019
lastupdated: "2019-06-12"

keywords: standard plan, lite plan, dedicated hardware plan, event type, provisioned throughput capacity, consumption, capacity, monitor usage, data usage, size limits, locations, tenancy, authentication methods, high availability, disaster recovery, backup, support

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

# Planes y suministro
{: #ibm-cloud-public}

{{site.data.keyword.cloudantfull}} público es la oferta de {{site.data.keyword.cloudant_short_notm}} más rica en características que primero recibe actualizaciones y nuevas características. El precio se basa en la capacidad de rendimiento suministrada asignada y en el almacenamiento de datos utilizado, haciendo que sea adecuado para cualquier carga necesaria. 
{: shortdesc}

El [plan Lite](#lite-plan) gratuito incluye una cantidad fija de capacidad de rendimiento y datos para propósitos de desarrollo y evaluación. El [plan Estándar](#standard-plan) de pago ofrece capacidad de rendimiento suministrada configurable y precios de almacenamiento de datos que escala a medida que cambian los requisitos de su aplicación.  Además hay disponible un [plan de hardware dedicado](#dedicated-hardware-plan) por una cuota mensual adicional para ejecutar una o varias instancias del plan estándar en un entorno de hardware dedicado. El entorno de hardware dedicado es para uso exclusivo del usuario y si la instancia del plan de hardware dedicado se suministra en una ubicación de EE.UU., de forma opcional, puede seleccionar una configuración conforme con la [HIPAA ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://en.wikipedia.org/wiki/Health_Insurance_Portability_and_Accountability_Act){: new_window}.

## Planes
{: #plans}

Puede seleccionar el plan que desea utilizar cuando [suministre su instancia de servicio de {{site.data.keyword.cloudant_short_notm}}](#provisioning-a-cloudant-nosql-db-instance-on-ibm-cloud).
De forma predeterminada, se selecciona el [plan Lite](#lite-plan).

![Selección del plan de instancia de servicio de {{site.data.keyword.cloudant_short_notm}}](../images/lite_pricing_plan.png)

### Plan Lite
{: #lite-plan}

El plan Lite es gratuito y está diseñado para propósitos de desarrollo y evaluación. Se incluye la funcionalidad completa de {{site.data.keyword.cloudant_short_notm}}, pero las instancias del plan Lite tienen una cantidad fija de rendimiento suministrada y de almacenamiento de datos. La capacidad de rendimiento suministrada se fija en 20 lecturas/segundo, 10 escrituras/segundo y 5 consultas globales/segundo, y el almacenamiento de datos se limita a 1 GB. 

El uso de almacenamiento se comprueba a diario. Si supera el límite de almacenamiento de 1 GB, las solicitudes a la instancia de {{site.data.keyword.cloudant_short_notm}} reciben un código de estado 402 con un mensaje de error que indica "La cuenta ha superado su cuota de uso de datos. Es necesario actualizar a un plan de pago."
También aparece un banner en el panel de control de {{site.data.keyword.cloudant_short_notm}}. Puede seguir leyendo y suprimiendo datos. Sin embargo, para escribir nuevos datos, tiene dos opciones. En primer lugar, puede actualizar a un [plan estándar](#standard-plan) pagado que elimina la limitación de escritura de forma inmediata. De forma alternativa, puede suprimir datos para que el almacenamiento total esté comprendido en el límite de 1 GB, y esperar a que se ejecute la siguiente comprobación de almacenamiento diario para que la instancia vuelva a permitir las escrituras. 

Si desea almacenar más de 1 GB de datos o poder escalar la capacidad de rendimiento suministrada, pase a un [plan estándar](#standard-plan).

Está limitado a una instancia de plan Lite de {{site.data.keyword.cloudant_short_notm}} por cuenta de {{site.data.keyword.cloud_notm}}. Si ya dispone de una instancia del plan Lite, cualquier intento de crear una nueva o de cambiar de una instancia del plan estándar a una del plan Lite devuelve el mensaje "Solo puede tener una instancia del plan Lite por servicio. Para crear una nueva instancia, suprima la instancia del plan Lite existente o seleccione un plan de pago". 
{: note}

### Plan Estándar
{: #standard-plan}

El plan estándar de {{site.data.keyword.cloudant_short_notm}} está disponible para todas las cuentas de {{site.data.keyword.cloud}} de pago, ya sean de pago según uso o suscripción, y escala para satisfacer las necesidades de la aplicación. El precio del plan estándar se basa en dos factores: la capacidad de rendimiento suministrada que se asigna y la cantidad de datos que se almacenan en la instancia. 

El establecimiento de precios es por hora prorrateada con una capacidad de rendimiento suministrado de 100 lecturas/segundo, 50 escrituras/segundo y 5 consultas globales/segundo equivalentes a un coste inicial en dólares de 0,105/hora. Puede aumentar o disminuir la capacidad de rendimiento suministrado de 100 lecturas/segundo, 50 escrituras/segundo y 5 consultas globales/segundo en el panel de control de {{site.data.keyword.cloudant_short_notm}}. Se calculan los costes de la capacidad de rendimiento suministrado que se asigna y no del volumen medido de las solicitudes. El plan Estándar incluye 20 GB de almacenamiento de datos. Si almacena más de 20 GB, se le facturará un coste definido por GB por hora. 

Consulte la calculador de tarifas de {{site.data.keyword.cloud_notm}} para el establecimiento de precios en distintas capacidades y monedas, y la información sobre el [establecimiento de precios](/docs/services/Cloudant?topic=cloudant-pricing#pricing){: new_window} para obtener ejemplos y estimar costes.

### Plan de hardware dedicado
{: #dedicated-hardware-plan}

Una instancia de plan de hardware de {{site.data.keyword.cloudant_short_notm}} dedicado es un entorno nativo de {{site.data.keyword.cloudant_short_notm}} que se suministra para el uso exclusivo de las instancias del plan estándar de {{site.data.keyword.cloudant_short_notm}}. Es posible suministrar un entorno de plan de hardware de {{site.data.keyword.cloudant_short_notm}} dedicado en cualquier centro de datos global de [{{site.data.keyword.IBM}} ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/cloud/data-centers/){:new_window}. Este plan es necesario para la conformidad de HIPAA y se debe seleccionar en el tiempo de suministro. Los usuarios de un entorno del plan Hardware dedicado de {{site.data.keyword.cloudant_short_notm}} pueden emplear las claves de cifrado gestionadas por el cliente de BYOK (Bring-Your-Own-Key) y de lista blanca de IP con {{site.data.keyword.IBM_notm}} Key Protect. Además, los entornos de hardware dedicado suministrados después del 1 de enero de 2019 fuera de los entornos gestionados por la UE, incluyen puntos finales internos para todas las instancias del plan Estándar desplegadas en ellos. El uso de puntos finales internos permite que los clientes puedan conectarse a una instancia de {{site.data.keyword.cloudant_short_notm}} a través de la red interna de {{site.data.keyword.cloud}} para evitar que el tráfico de aplicación en sentido ascendente pase a través de la red pública y se incurra en cargos de ancho de banda. Para obtener más información, consulte la [Documentación de punto final de servicio ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://cloud.ibm.com/docs/services/service-endpoint/getting-started.html#about){:new_window} Para obtener más detalles sobre la habilitación de puntos finales de servicio para su cuenta de {{site.data.keyword.cloud}}.

Puede suministrar una o varias instancias del plan estándar, y el entorno de hardware dedicado se expandirá o contraerá según sea necesario en función de la capacidad y los datos que utilizan las instancias del plan estándar. Una instancia de plan de hardware dedicado de {{site.data.keyword.cloudant_short_notm}} tiene un precio fijo al que se añade el precio del consumo de cualquier instancia del plan Estándar desplegada en él. La facturación se prorratea diariamente, y hay una duración mínima de 1 mes que se cargará en el entorno. El suministro de un plan de Hardware dedicado de {{site.data.keyword.cloudant_short_notm}} es asíncrono y puede tardar entre 5 y 7 días hábiles. Para crear una instancia del plan de hardware dedicado de {{site.data.keyword.cloudant_short_notm}} y suministrarle una instancia del plan estándar, siga la instancia del plan [Creación y aprovechamiento de un Hardware dedicado de {{site.data.keyword.cloudant_short_notm}} en la guía de aprendizaje de {{site.data.keyword.cloud_notm}}](/docs/services/Cloudant?topic=cloudant-creating-and-leveraging-an-ibm-cloudant-dedicated-hardware-plan-instance-on-ibm-cloud#creating-and-leveraging-an-ibm-cloudant-dedicated-hardware-plan-instance-on-ibm-cloud). 

El plan de Hardware dedicado no está disponible para los clientes de {{site.data.keyword.cloud_notm}} dedicado. Solo está disponible para los clientes de {{site.data.keyword.cloud_notm}} público.
{: important}

## Tipos de sucesos
{: #event-types}

El suministro de rendimiento se identifica y se mide como uno de los siguientes tipos de sucesos:

1.	_Lecturas_ (anteriormente conocidas como búsquedas), que son:
    1. Una lectura de un documento específico, basada en el `_id` del documento.
    2. Una consulta _particionada_, que es una solicitud realizada a un punto final de consulta de {{site.data.keyword.cloudant_short_notm}} dentro del espacio de nombres `_partition` en la vía de acceso de la solicitud, incluyendo los tipos siguientes:
        -	Índice primario ([`_all_docs`](/docs/services/Cloudant?topic=cloudant-databases#get-documents))
        -	Vista MapReduce ([`_view`](/docs/services/Cloudant?topic=cloudant-using-views#using-views))
        -	Índice de búsqueda ([`_search`](/docs/services/Cloudant?topic=cloudant-search#queries))
        -	Consulta de {{site.data.keyword.cloudant_short_notm}} ([`_find`](/docs/services/Cloudant?topic=cloudant-query#finding-documents-by-using-an-index))
    
        El número de operaciones de lectura consumidas por una solicitud de consulta particionada varía en función de los resultados devueltos.
2.	_Escrituras_, que son la creación, modificación o supresión de documentos individuales.
3.	_Consultas globales_ de índices globales (anteriormente conocidas como consultas), que son solicitudes realizadas a un punto final de consulta de {{site.data.keyword.cloudant_short_notm}} que **no** está dentro del espacio de nombres `_partition`, incluyendo los tipos siguientes:
	-	Índice primario ([`_all_docs`](/docs/services/Cloudant?topic=cloudant-databases#get-documents))
	-	Vista MapReduce ([`_view`](/docs/services/Cloudant?topic=cloudant-using-views#using-views))
	-	Índice de búsqueda ([`_search`](/docs/services/Cloudant?topic=cloudant-search#queries))
	-	Índice geoespacial ([`_geo`](/docs/services/Cloudant?topic=cloudant-cloudant-nosql-db-geospatial#querying-a-cloudant-nosql-db-geo-index))
	-	Consulta de {{site.data.keyword.cloudant_short_notm}} ([`_find`](/docs/services/Cloudant?topic=cloudant-query#finding-documents-by-using-an-index))


## Capacidad de rendimiento suministrado
{: #provisioned-throughput-capacity}

El suministro de rendimiento se identifica y se mide como sucesos de los tipos de operaciones siguientes: _Lectura_, _Escritura_, _Consulta global_.

La medida de rendimiento es un simple recuento del número de sucesos de cada tipo, por segundo, donde el segundo es una ventana _deslizante_.
Si la cuenta supera el número de sucesos de rendimiento que se suministran para el plan, las solicitudes se rechazan hasta que el número de sucesos de la ventana deslizante deja de superar el número que se suministra.
Para comprenderlo mejor, piense que la ventana deslizante de 1 segundo es un periodo consecutivo de 1.000 milisegundos.

Por ejemplo, el plan Estándar se suministra para 200 lecturas por segundo. La cuenta puede consumir un máximo de 200 sucesos de lectura durante un periodo consecutivo de 1000 milisegundos (1 segundo). Las siguientes solicitudes de lectura que se realicen durante el periodo deslizante de 1000 milisegundos se rechazan hasta que el número de sucesos de lectura de dicho periodo vuelva a caer por debajo de las 200.

Cuando se rechaza una solicitud porque se ha superado el número de sucesos, las aplicaciones reciben la respuesta [`429` Demasiadas solicitudes](/docs/services/Cloudant?topic=cloudant-http#http-status-codes).

Las versiones recientes de las bibliotecas de cliente admitidas (para lenguajes [Java](/docs/services/Cloudant?topic=cloudant-supported-client-libraries#java-supported), [Node.js](/docs/services/Cloudant?topic=cloudant-supported-client-libraries#node-js-supported) y [Python](/docs/services/Cloudant?topic=cloudant-supported-client-libraries#python-supported)) le ayudan a manejar una respuesta `429`. Por ejemplo, la biblioteca Java genera una respuesta [`TooManyRequestsException` ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](http://static.javadoc.io/com.cloudant/cloudant-client/2.5.1/com/cloudant/client/org/lightcouch/TooManyRequestsException.html){: new_window}.

De forma predeterminada, las bibliotecas de cliente admitidas no vuelven a intentar automáticamente una solicitud cuando se recibe una respuesta `429`.

Es mejor asegurarse de que la aplicación maneja las respuestas `429` correctamente.
La razón es que el número de reintentos es limitado; el incumplimiento repetido del número de solicitudes es un potente indicador para pasar a una configuración de plan diferente.

Si está portando una aplicación existente, es posible que no pueda manejar una respuesta `429`. Como parte de la verificación de la migración, compruebe que la aplicación maneja correctamente las respuestas `429`.
{: note}

En resumen, debe asegurarse de que la aplicación es capaz de manejar una respuesta [`429`](/docs/services/Cloudant?topic=cloudant-http#http-status-codes) correctamente.

### Consumo de operaciones de lectura en consultas particionadas
{: #consumption-of-lookup-operations-by-partitioned-queries}

Las solicitudes de consulta particionada consumen un número variable de operaciones de lectura en función de los resultados devueltos. El consumo se basa en dos ejes:

1. El número de filas que se leen del índice implicado en la consulta.
1. El número de documentos que se leen de la base de datos, si hay alguno, durante la ejecución de la consulta.
    
#### Consultas `_all_docs`, de vista y de búsqueda

Cada bloque de 100 filas leídas del índice consume 1 operación de lectura. Además, cada documento que se lee de la base de datos durante la ejecución de una consulta consume 1 unidad de lectura.

El número de filas leídas del índice es el mismo que el número de resultados devueltos. Solo se leen documentos de la base de datos cuando se pasa `include_docs=true` como parámetro de serie de consulta durante la solicitud de consulta.

En la tabla siguiente se muestran costes de ejemplo.

| Número de resultados | Incluyen documentos | Consumo de lectura total | Consumo de filas leídas | Consumo de documentos leídos |
|--------------|----------------|-------------|---------------------| --- |
| 199      | No     | **2** | 2 | 0 |
| 199      | Sí     | **201** | 2 | 199 |
| 301      | No     | **4** | 4 | 0 |
| 301      | Sí     | **305** | 4 | 301 |

La reducción del uso de `include_docs=true` es clave para reducir el consumo de lectura para consultas particionadas de `_all_docs`, de vista y de búsqueda.

#### Consulta de {{site.data.keyword.cloudant_short_notm}}

En solicitudes de consulta de {{site.data.keyword.cloudant_short_notm}}, el número de operaciones de lectura consumidas para las filas de índice leídas está relacionado con las filas leídas del índice subyacente _antes_ de que se produzca el filtrado basado en las partes del selector que no puede satisfacer el índice.
Esto implica que el valor de filas leídas y, por lo tanto, las unidades de lectura consumidas, puede ser mayor que el número de resultados eventuales que recibe.

Además, la consulta de {{site.data.keyword.cloudant_short_notm}} debe leer el documento para cada fila devuelta por el índice subyacente para que pueda ejecutar más filtros necesarios para el selector que se pasa a la consulta.

| Número de resultados | Número de filas devueltas por el índice | Consumo de lectura total | Consumo de filas leídas | Consumo de documentos leídos |
|--------------|----------------|-------------|---------------------| --- |
| 5      | 199     | **201** | 2 | 199 |
| 199      | 199     | **201** | 2 | 199 |
| 5      | 301     | **305** | 4 | 301 |
| 301      | 301     | **305** | 4 | 301 |

El uso de índices adecuados es clave para reducir el consumo de lectura en consultas particionadas de {{site.data.keyword.cloudant_short_notm}} Query.

### Capacidad de visualización y modificación
{: #viewing-and-changing-capacity}

Puede ver los detalles de la capacidad de rendimiento de los planes disponibles para su cuenta.
Puede seleccionar el nivel de suministro que desea utilizar mediante el separador Cuenta del panel de control de la cuenta de {{site.data.keyword.cloudant_short_notm}}.

![Panel de control de la cuenta](../images/cloudant_capacity.png)

Para moverse a una capacidad de rendimiento diferente, seleccione el suministro que desee y pulse `Actualizar`. Se le solicitará que confirme el cambio y se le recordará que el cambio de suministro puede tardar hasta 24 horas en completarse.

![Panel de control de la cuenta](../images/cloudant_capacity_change.png)

El tamaño del aumento de capacidad está limitado a 10 unidades (1000 lecturas/segundo, 500 escrituras/segundo y 50 consultas globales/segundo) por cambio. Las reducciones no están limitadas por el número de unidades. Cualquier cambio en la capacidad, ya sea un aumento o una reducción, se limita a una vez por hora. Si necesita más capacidad que la que hay disponible en el panel de control de {{site.data.keyword.cloudant_short_notm}}, póngase en contacto con el [Soporte de {{site.data.keyword.cloudant_short_notm}} ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](mailto:support@cloudant.com){: new_window}.
{: note}

### Supervisión del uso 
{: #monitoring-usage}

Hay disponible información acerca del uso en el panel Operaciones actuales del separador Supervisión en el panel de control de {{site.data.keyword.cloudant_short_notm}}. 

![Supervisión del uso en el panel de control](../images/cloudant_usage.png)

Allí encontrará detalles que ilustran el [rendimiento](#provisioned-throughput-capacity) actual y la cantidad de [datos almacenados](#disk-space-included).

La supervisión le ayuda a reconocer que puede haber llegado el momento de cambiar el suministro en el plan.
Por ejemplo, si suele acercarse al número máximo de lecturas en la base de datos, puede modificar el suministro a través del [panel Capacidad](#viewing-and-changing-capacity) del separador Cuenta del panel de control.

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
Posteriormente, el almacenamiento aumenta a 21,5 GB durante 15 durante la hora que comienza a las 02:00 del día 3.
La instancia vuelve a caer a 9,5 GB durante los 10 minutos siguientes de la hora 02:00, y luego aumenta a 108 durante los 25 minutos siguientes de la hora 02:00.
Por último, la instancia finaliza la hora y el resto del mes volviendo a 28 GB.

Este patrón significa que el número máximo de GB por encima de la asignación del plan ha sido de 88 GB durante la hora 2 del día 3.
Para la hora 03:00 del día 3, y durante el resto del mes, la instancia ha utilizado 8 GB más que la asignación del plan.

Por lo tanto, para la 02:00 del día 3, su factura incluye un excedente de 88 GB x 1 hora = 88 GB horas.

Para el periodo comprendido entre la hora 03:00 del día 3 y el final del día 3, su factura incluye un excedente de 8 GB x 21 horas = 168 GB horas.

Para el periodo comprendido entre la hora 00:00 del día 4 y el final del mes (de 30 días), la factura incluye un excedente de 8 GB x 24 horas x 27 días = 5184 GB horas.

La factura de excedente total del mes se basa en el total de 88 + 168 + 5184 = 5440 GB horas.

## Límites de tamaño de solicitud y de documentos
{: #request-and-document-size-limits}

Los documentos y las solicitudes JSON de {{site.data.keyword.cloudant_short_notm}} tienen los siguientes límites de tamaño máximos: 

Límite | Tamaño máximo
------|-------------
Tamaño de documento individual | 1 MB
Tamaño de archivo adjunto único | 10 MB
Tamaño de cuerpo de solicitud | 11 MB

Superar cualquiera de estos límites da lugar a una [respuesta 413](/docs/services/Cloudant?topic=cloudant-http#http-status-codes).

Se recomienda almacenar archivos adjuntos binarios, o blobs JSON grandes, en el almacenamiento de objetos y guardar un enlace a la ubicación en un documento JSON de {{site.data.keyword.cloudant_short_notm}}.   

Cuando se duplican, los documentos o los archivos adjuntos más grandes que estos límites no se replican en la base de datos de destino. Para obtener más información sobre cómo detectar los errores de réplica, consulte [Errores de réplica](/docs/services/Cloudant?topic=cloudant-replication-api#replication-errors).

## Ubicaciones y arrendamiento
{: #locations-and-tenancy}

De forma predeterminada, todos los planes Lite y estándar se despliegan en entornos multiarrendatario. Como parte de la selección del plan, puede elegir entre las siguientes regiones de {{site.data.keyword.cloud_notm}} Público:

-   Washington DC
-   Dallas
-   Londres
-   Sídney
-   Frankfurt&Dagger;
-   Tokio

En la mayoría de las [ubicaciones de centros de datos de {{site.data.keyword.IBM_notm}} se pueden desplegar instancias del plan de hardware dedicado ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/cloud/data-centers/). 
Consulte el menú desplegable en el catálogo de {{site.data.keyword.cloud_notm}} para obtener una lista actualizada de las ubicaciones disponibles.

&Dagger;Todas las instancias de {{site.data.keyword.cloudant_short_notm}} que se despliegan desde la región Frankfurt de {{site.data.keyword.cloud_notm}} público se despliegan en entornos gestionados por la UE. No se podrá otorgar acceso a cualquier cuenta o clave de API de {{site.data.keyword.cloudant_short_notm}} generada fuera de un entorno gestionado por la UE a una instancia de {{site.data.keyword.cloudant_short_notm}} gestionada por la UE.

## Métodos de autenticación
{: #authentication-methods}

Se accede a {{site.data.keyword.cloudant_short_notm}} utilizando una API HTTPS. Si el punto final de la API lo requiere, se autentica al usuario para cada solicitud HTTPS que {{site.data.keyword.cloudant_short_notm}} recibe. Durante el suministro, los métodos de autenticación disponibles incluyen `Utilizar credenciales heredadas y de IAM` o `Usar solo IAM`. Para obtener más información, consulte la [guía de IAM](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-) o el [documento de la API de autenticación](/docs/services/Cloudant?topic=cloudant-authentication#authentication) heredada.

Después de suministrar una instancia de {{site.data.keyword.cloudant_short_notm}}, es posible buscar el URL de conexión y los detalles de autorización de IAM al generar nuevas credenciales en el separador Credenciales de servicio del panel de control de {{site.data.keyword.cloud_notm}}. Si selecciona esta opción durante el suministro, también se incluirán el nombre de usuario y la contraseña de {{site.data.keyword.cloudant_short_notm}} heredados.

El equipo de {{site.data.keyword.cloudant_short_notm}} recomienda el uso de controles de acceso de IAM para la autenticación siempre que sea posible. Si utiliza la autenticación heredada de {{site.data.keyword.cloudant_short_notm}}, se recomienda que utilice [claves de API](/docs/services/Cloudant?topic=cloudant-authorization#api-keys){: new_window} en lugar de credenciales a nivel de cuenta para el acceso mediante programación y los trabajos de réplica. 
{: important}

## Alta disponibilidad, recuperación de desastres y copia de seguridad en un centro de datos
{: #high-availability-disaster-recovery-and-backup-in-a-data-center}

Para proporcionar alta disponibilidad (HA) y recuperación en caso de error (DR) en un centro de datos, todos los datos se almacenan por triplicado en tres servidores físicos distintos de un clúster. Puede suministrar cuentas en varios centros de datos y utilizar la réplica de datos continua para proporcionar HA/DR entre los centros de datos. No se realiza una copia de seguridad automática de {{site.data.keyword.cloudant_short_notm}}, pero se proporcionan las herramientas soportadas para gestionar las copias de seguridad. Consulte la [Guía de recuperación tras desastre y copia de seguridad](/docs/services/Cloudant?topic=cloudant-authorization#api-keys) para explorar todas las consideraciones de copia de seguridad que cumplan los requisitos de la aplicación. 

## Soporte de {{site.data.keyword.cloud_notm}}
{: #ibm-cloud-support}

El soporte correspondiente a las instancias de servicio del plan Estándar y Dedicado es opcional.
Se suministra cuando se adquiere el soporte estándar de *{{site.data.keyword.cloud_notm}}*. El soporte no está disponible para el plan Lite.

Para obtener más información sobre los planes de soporte, consulte [Planes de soporte Estándar de {{site.data.keyword.cloud_notm}} ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/cloud/support#944376){: new_window}. Para obtener más información sobre el soporte, consulte [Guía de soporte de {{site.data.keyword.IBM_notm}} ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/support/home/pages/support-guide/){: new_window}.

Los sistemas de soporte utilizados para {{site.data.keyword.cloudant_short_notm}} no ofrecen funciones de protección de contenido que incluya información sanitaria, datos sobre la salud, información protegida sobre salud, ni otros datos sujetos a requisitos normativos adicionales. Por lo tanto, el cliente no debe especificar o proporcionar dichos datos.
{: note}

## Suministro de una instancia de {{site.data.keyword.cloudant_short_notm}} en {{site.data.keyword.cloud_notm}}
{: #provisioning-a-cloudant-nosql-db-instance-on-ibm-cloud}

Puede suministrar una instancia de los planes Lite o Estándar de {{site.data.keyword.cloudant_short_notm}} en {{site.data.keyword.cloud_notm}} de dos formas, mediante:

- Utilización del panel de control. Para obtener más información, consulte la instancia [Creación de una instancia de {{site.data.keyword.cloudant_short_notm}} en el tutorial {{site.data.keyword.cloud_notm}} ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud#creating-an-ibm-cloudant-instance-on-ibm-cloud){: new_window} que describe el proceso.
- Mediante la herramienta de mandatos de Cloud Foundry. Para obtener más información, consulte [Creación de una instancia de {{site.data.keyword.cloudant_short_notm}} en {{site.data.keyword.cloud_notm}} utilizando la CLI del tutorial {{site.data.keyword.cloud_notm}} ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud-by-using-the-ibm-cloud-cli#creating-an-ibm-cloudant-instance-on-ibm-cloud-by-using-the-ibm-cloud-cli){: new_window} que describe el proceso.
 
Para crear y optimizar una instancia del plan de {{site.data.keyword.cloudant_short_notm}}, siga la instancia del plan [Creación y optimización de un hardware dedicado de {{site.data.keyword.cloudant_short_notm}} {{site.data.keyword.cloud_notm}} en el tutorial ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](/docs/services/Cloudant?topic=cloudant-creating-and-leveraging-an-ibm-cloudant-dedicated-hardware-plan-instance-on-ibm-cloud#creating-and-leveraging-an-ibm-cloudant-dedicated-hardware-plan-instance-on-ibm-cloud){: new_window} que describe el proceso.






