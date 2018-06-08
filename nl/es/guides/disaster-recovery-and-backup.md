---

copyright:
  years: 2017, 2018
lastupdated: "2017-11-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-05-10 -->

# Recuperación en caso de error y copia de Seguridad

Sus datos son importantes y valiosos.
Desea proteger sus datos para garantizar que están seguros y disponibles y que mantienen su integridad.
{{site.data.keyword.cloudantfull}} proporciona varias maneras de proteger los datos y de ayudar a mantener operativas sus aplicaciones.
{:shortdesc}

Algunas de estas características de protección son automáticas.
Para otras formas de protección, {{site.data.keyword.cloudant_short_notm}} le proporciona herramientas que le ayudarán a crear sus propias funciones de alta disponibilidad y recuperación en caso de error.

Este documento proporciona una visión general de las funciones automáticas y herramientas soportadas que ofrece {{site.data.keyword.cloudant_short_notm}}.

## Tipos y niveles de protección

El tipo de protección que elija dependerá del problema que esté intentando solucionar.

Por ejemplo, supongamos que desea tener un alto nivel de disponibilidad de datos que le permita acceder a los datos aunque falle una parte limitada del hardware del sistema.
Este es un requisito de 'Alta disponibilidad' (HA).
Significa ofrecer el mejor nivel posible de disponibilidad continuada de los datos tras un error de hardware.
Existen distintas técnicas de HA que toleran diferentes niveles de error antes de que las operaciones se vean afectadas.

Como alternativa, supongamos que desea disponer de métodos fáciles y rápidos de hacer copia de seguridad y restaurar sus datos.
Por ejemplo, es posible que tras un error de hardware grave desee poner todos los datos a disponibilidad en un sistema alternativo lo antes posible.
Este es un requisito de 'Recuperación en caso de error' (DR).
Un error de este tipo suele significar que una base de datos deja de estar disponible en una o varias ubicaciones.
Por ejemplo, una caída de la alimentación puede hacer que fallen todos los sistemas de un clúster de base de datos.
Por otro lado, un error de red a gran escala puede implicar que no se pueda establecer contacto con los sistemas de un clúster, aunque estos sigan funcionando correctamente.

El proceso para solucionar los requisitos de HA o DR suele comenzar por simplificar el problema en requisitos más genéricos.
Cuando identifique sus requisitos, podrá aplicar las herramientas y características que ayuden a solucionarlos.
Una vez combinadas, las herramientas y características pueden dar una solución a sus requisitos de HA o DR.

>	**Nota**: Las distintas herramientas y características proporcionan distintos niveles de protección.
	Las distintas características pueden resultar más o menos adecuadas para su requisito específico de HA o DR.

{{site.data.keyword.cloudant_short_notm}} proporciona una serie de herramientas y características que abordan requisitos generales:

1.	Redundancia de datos dentro de una sola región, también denominada [redundancia automática de datos en región](#in-region-automatic-data-redundancy).
2.	Redundancia y migración de datos en caso de error entre regiones, también denominada [redundancia entre regiones para la recuperación en caso de error](#cross-region-redundancy-for-disaster-recovery).
3.	Copia de seguridad de instantánea en un punto en el tiempo para restauración en un punto en el tiempo, mediante una [copia de seguridad y recuperación de bases de datos](#database-backup-and-recovery) 'tradicional'.

## Redundancia automática de datos en región

Dentro de una sola cuenta de {{site.data.keyword.cloudant_short_notm}},
los datos se almacenan por triplicado mediante procesos internos y automáticos.
No es necesario que haga nada para habilitar esta réplica interna de los datos.

La redundancia de datos en región habilita la protección de alta disponibilidad.
En concreto, la redundancia de datos en región ofrece protección de los datos frente a un error de hardware dentro de la región.
Cuando falla una unidad de hardware de la región, solo la copia de los datos almacenada en dicha unidad deja de estar disponible.
Las aplicaciones se pueden seguir utilizando porque {{site.data.keyword.cloudant_short_notm}} direcciona automáticamente las solicitudes a las copias de los datos que siguen estando disponibles en otras unidades de hardware de la región.
Mientras tanto, la supervisión automática de sistemas detecta el error de la unidad de hardware y solicita una acción y restauración de redundancia completa.

Las cuentas de {{site.data.keyword.cloudant_short_notm}} se alojan dentro de una sola región.
Esta característica significa que todos los datos que almacene en su cuenta se guardan en servidores separados, cada uno de los cuales se aloja en una sola región.

La redundancia automática de datos en región se limita a:

1.	Ofrecer protección solo dentro de una región.
2.	Mantener los datos actualizados.

Para proporcionar protección entre más de una región asociada a su cuenta, utilice la [Redundancia entre regiones para la recuperación en caso de error](#cross-region-redundancy-for-disaster-recovery).

Para ofrecer protección del 'historial' de datos, por ejemplo para permitir la auditoría de los cambios que han realizado las aplicaciones en los datos, utilice instantáneas de datos creadas mediante herramientas de [Copia de seguridad y restauración de bases de datos](#database-backup-and-recovery).

En resumen, la redundancia de datos en región ofrece la función de alta disponibilidad al proporcionar tolerancia de errores que afectan a sistemas individuales dentro de la región.

## Redundancia entre regiones para la recuperación en caso de error

La característica de réplica de {{site.data.keyword.cloudant_short_notm}} le ayuda a incorporar en las aplicaciones un sistema flexible de recuperación en caso de error.
El método principal para habilitar la recuperación en caso de error consiste en utilizar la réplica de {{site.data.keyword.cloudant_short_notm}} para crear redundancia entre regiones.
El resultado es que la aplicación puede tolerar la situación en la que una o varias regiones no están disponibles.

Los principales pasos a seguir para crear una redundancia entre regiones son los siguientes:

1.  Cree cuentas de {{site.data.keyword.cloudant_short_notm}} en dos o más regiones.
2.  Cree las bases de datos que necesite en cada región.
3.  Para las bases de datos que se deban almacenar con redundancia entre regiones, configure réplicas continuas bidireccionales entre las bases de datos correspondientes en cada cuenta.
4.  Diseñe e implemente sus aplicaciones para que las solicitudes de datos se direccionen en función de si el entorno tiene una configuración de tipo activo-pasivo o activo-activo.
  Está [disponible](active-active.html) una guía detallada para configurar este diseño.

Cuando diseñe sus aplicaciones para que funcionen con datos entre varias regiones, tenga en cuenta lo siguiente:

* Las aplicaciones pueden enviar solicitudes a la base de datos alojada en la ubicación física más cercana.
  Este uso de proximidad puede reducir la latencia de la red y mejorar los tiempos de respuesta.
  Esta configuración recibe el nombre de método 'Activo-Activo'.
  Se caracteriza por el uso simultáneo de varias copias de los datos.
  Las aplicaciones que funcionan en una configuración de tipo activo-activo deben tener una [estrategia para gestionar conflictos](mvcc.html#distributed-databases-and-conflicts) a fin de evitar los problemas derivados de tener varias copias de los datos.
* Las aplicaciones pueden solicitar datos de una sola región de forma predeterminada.
  Si la región no está disponible, la aplicación puede conmutar la solicitud de los datos a otra región.
  Esta configuración recibe el nombre de método 'Activo-Pasivo'.
  Se caracteriza por el uso activo de un conjunto de datos en cada momento.
* Una aplicación puede utilizar una configuración híbrida, donde se utiliza una sola cuenta para todas las solicitudes de escritura de datos y otras ubicaciones se utilizan exclusivamente para solicitudes de lectura.
  Esta configuración se considera Activa-Activa para lecturas.
* En un escenario de desastre, la aplicación debe redireccionar las solicitudes de datos de modo que accedan a las cuentas alojadas en las regiones que todavía están en línea.
  Este requisito significa que la aplicación debe ser capaz de detectar la pérdida de una región y de redireccionar las solicitudes de datos.

En resumen, la redundancia entre regiones es similar a una función de alta disponibilidad, pero se aplica a errores que afectan a una región entera.
Sin embargo, la configuración de las aplicaciones para que funcionen correctamente con configuraciones de redundancia cruzada proporciona un verdadero sistema de recuperación en caso de error.
El motivo es que las aplicaciones pueden seguir funcionando si una región no está disponible durante en periodo de tiempo.
La réplica de {{site.data.keyword.cloudant_short_notm}} garantiza la sincronización de datos entre regiones.
Sin embargo, las aplicaciones deben poder 'migrar en caso de error' a copias de los datos almacenadas en otras regiones.

## Copia de seguridad y recuperación de bases de datos

La [redundancia automática de datos en región](#in-region-automatic-data-redundancy) ofrece a las aplicaciones acceso de alta disponibilidad a los datos.
La [redundancia entre regiones para la recuperación en caso de error](#cross-region-redundancy-for-disaster-recovery) ofrece a las aplicaciones un método para recuperarse después de un error.
Sin embargo, ambas funciones se centran solo en mantener el acceso a la copia _actual_ de los datos.

En la práctica, tanto las personas como las aplicaciones pueden cometer errores y cambiar datos de forma involuntaria.
Las propias aplicaciones pueden implementar cierta protección, pero en ocasiones a costa de cambios no deseados.
En este caso, resulta útil poder restaurar datos de un punto en el tiempo anterior.
Las copias de seguridad de base de datos dan soporte a este requisito.

Además de proteger los datos con características de alta disponibilidad y de recuperación en caso de error, tenga en cuenta la posibilidad de realizar un volcado de los datos de la base de datos en otra ubicación a intervalos periódicos y regulares.
Asegúrese de comprobar y probar que las copias de seguridad sean completas y correctas.

{{site.data.keyword.cloudant_short_notm}} da soporte a herramientas que le ayudan a realizar un volcado del contenido JSON de las bases de datos en un archivo y luego a restaurar las bases de datos de esos archivos.

Concretamente, las herramientas que admite {{site.data.keyword.cloudant_short_notm}} le ayuda a:

*	Hacer copia de seguridad de bases de datos enteras en un archivo, adecuado para su proceso y almacenamiento externo.
*	Restaurar bases de datos enteras a partir de un estado anterior contenido en el archivo de copia de seguridad.

<strong style="color:red;">Aviso</strong> Las herramientas que admite {{site.data.keyword.cloudant_short_notm}} tienen las siguientes limitaciones: 

*	Las herramientas no hacen copia de seguridad de los valores de `_security`.
*	Las herramientas no hacen copia de seguridad de los archivos adjuntos.
*	Las copias de seguridad no son instantáneas exactas en un "punto en el tiempo".
	El motivo es que los documentos de la base de datos se recuperan por lotes, pero es posible que otras aplicaciones estén actualizando documentos al mismo tiempo.
	Por lo tanto, los datos de la base de datos pueden cambiar entre el momento en que se lee el primer y el último lote.
*	Las definiciones de índice contienen documentos de diseño de los que se ha hecho copia de seguridad, pero cuando se restauran los datos los índices se deben volver a crear.
	Esta reconstrucción puede tardar una cantidad de tiempo considerable, en función de la cantidad de datos que se restauren.

<div id="conclusion"></div>

## Siguientes pasos

Puede desarrollar aplicaciones que se basen en las funciones básicas de {{site.data.keyword.cloudant_short_notm}} y en las herramientas admitidas para desarrollar estrategias de protección de datos más complejas.

Ejemplos de escenarios:

*	Restauración de documentos individuales a partir de estados anteriores.
*	Almacenamiento de varios estados de documentos anteriores, para permitir restauraciones de hace mucho tiempo.
*	Migración de datos antiguos a un tipo de almacenamiento más barato, para conservar los datos de manera asequible.

Las herramientas de copia seguridad constan de una aplicación de línea de mandatos node.js de código abierto y de una biblioteca.
Están disponibles [en NPM ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://www.npmjs.com/package/@cloudant/couchbackup){:new_window}.

Para ver ideas y ejemplos que muestran cómo integrar las herramientas en su estrategia de protección de datos, consulte la [guía de copia de seguridad](backup-cookbook.html).
