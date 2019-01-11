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

# Precios
{: #pricing}

{{site.data.keyword.cloudantfull}} permite el ajuste para aumentar y disminuir la capacidad de rendimiento suministrada, que es un número reservado de búsquedas, grabaciones y consultas cada segundo asignadas a
una instancia. El nivel de capacidad de rendimiento es el nivel de uso máximo. Si intenta
exceder la capacidad reservada, obtendrá un código de estado HTTP 429 que indica que la
aplicación está intentando exceder su concesión de capacidad de rendimiento suministrada.


## Ejemplos de precios 
{: #pricing-examples}

Supongamos que está creando una app móvil con {{site.data.keyword.cloudant_short_notm}} y que aún no conoce la capacidad que puede necesitar. En este caso, le recomendamos empezar con la menor capacidad de rendimiento suministrada
y aumentarla tal como sea necesario mediante el uso de la aplicación en el tiempo. {{site.data.keyword.cloudant_short_notm}} factura por horas prorrateadas y cambiar la capacidad de rendimiento suministrada no incurre en el tiempo de inactividad. 

Para el ejemplo de app móvil, empiece con la capacidad de rendimiento mínimo suministrada para el plan Estándar que es de 100 búsquedas/seg, 50 grabaciones/seg y 5 consultas/seg. El coste de esta capacidad es de 0,105 dólares por hora. Las 100 búsquedas/seg, 50 escrituras/seg y 5 consultas/seg son un bloque de capacidad de rendimiento suministrada. Cuando tenga que aumentar (o disminuir), puede
escalar en incrementos de estos bloques de capacidad. Suponiendo que la instancia tenga menos de
los 20 GB de almacenamiento que se incluye en el plan Estándar, no se incurrirá en costes de almacenamiento. En el
separador {{site.data.keyword.cloudant_short_notm}} Panel control > Cuenta > Capacidad, el
valor de capacidad de rendimiento suministrado tiene el aspecto de esta captura de pantalla:

![Separador Capacidad de panel de control de {{site.data.keyword.cloudant_short_notm}}](../images/cloudant-dashboard.png)

El graduador de capacidad muestra el coste por hora de la capacidad de rendimiento de suministro de 100 búsquedas/seg, 50 grabaciones/seg y 5 consultas/seg en USD de 0,105/hora. El graduador muestra un coste aproximado al mes de 76,65 dólares. La cantidad mensual es una estimación basada en un promedio de 730 horas al mes. El coste en cualquier mes puede ser ligeramente diferente en función del número de horas del mes.

Ecuación de ejemplo: 

- 0,105 dólares por hora 1 bloque de 100 búsquedas/seg, 50 grabaciones/seg y 5 consultas/seg suministradas mediante capacidad * 730 horas (horas aproximadas en un mes)
- Total = 76,65 dólares

Las búsquedas, las grabaciones y las consultas no se pueden escalar de forma independiente. Utilice el graduador para seleccionar el número de bloques de capacidad de rendimiento suministrada en función del límite máximo de búsquedas/seg, grabaciones/seg o consultas/seg necesarias para la aplicación. Por ejemplo, si la aplicación requiere 1.000 búsquedas por segundo, utilice el graduador para seleccionar la capacidad que ofrece 1.000 búsquedas/seg, 500 grabaciones/seg y 50 consultas/seg, aunque no necesite el número correspondiente de grabaciones o consultas.

![Separador Capacidad de panel de control de {{site.data.keyword.cloudant_short_notm}} con más capacidad seleccionada](../images/cloudant-gran-tuning.png)

¿Cómo se calcula el coste total de la capacidad de rendimiento suministrada al mes de 1.000 búsquedas, 500 grabaciones y 50 consultas? 

- 0,105 dólares por hora 10 bloques de 100 búsquedas/seg, 50 grabaciones/seg y 5 consultas/seg suministradas mediante capacidad * 730 horas (horas aproximadas en un mes)
- Como alternativa, el graduador muestra la capacidad de rendimiento suministrada de los costes de 1000 búsquedas/seg, 500 grabaciones/seg y 50 consultas/seg 1,050 dólares/hora * 730 horas
- Total = 766,50 dólares

## Uso de datos 
{: #data-usage}

¿Qué hay de la fijación de precios para el exceso de datos? ¿Cómo funciona?

Plan | Almacenamiento incluido | Límite de excedente
-----|------------------|--------------
Lite | 1 GB |  La cuenta se bloquea de grabar datos nuevos hasta que suprima los datos suficientes para estar por debajo del límite de 1 GB, o bien actualizar a un plan superior.
Estándar | 20 GB | El almacenamiento adicional cuesta 0,0014 dólares por GB por hora, que es aproximadamente 1 dólares/GB por mes.

¿Cómo se visualizan los datos en el panel de control de uso de {{site.data.keyword.cloud_notm}}?

Esta vista muestra los totales de uso que se han acumulado durante este mes y, por lo tanto, solo muestra los costes para el mes hasta el momento. El Total estimado refleja la factura en lo que va de mes. Al final del mes, verá su capacidad media para el mes, que es su factura mensual total. El campo `STORAGE_MANAGED_PER_MONTH` solo muestra la cantidad superior a los 20 GB incluidos, por lo que en el ejemplo siguiente, verá aproximadamente 40 GB de total de datos en la cuenta.  

![Vista de métricas de uso del Panel de control de {{site.data.keyword.cloudant_short_notm}} con ALMACENAMIENTO GESTIONADO POR MES superior](../images/usage-dashboard1.png)

Cuando se utiliza menos de 20 GB de almacenamiento, la pantalla muestra 0 GB, ya que no ha sobrepasado el límite.
