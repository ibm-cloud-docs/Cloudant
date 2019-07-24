---

copyright:
  years: 2015, 2019
lastupdated: "2019-06-12"

keywords: immutable data, pre-calculate results, de-normalise data, avoid conflicts, conflict resolution

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

# Cinco consejos para modelar los datos que desea escalar
{: #five-tips-for-modeling-your-data-to-scale}

En este artículo se habla sobre cómo modelar los datos de la aplicación para que funcionen de forma eficiente a gran escala.
{: shortdesc}

*(Esta guía se basa en un artículo del Blog de Mike Rhodes: ["My top 5 tips for modeling your data to scale" (Mis 5 mejores consejos para modelar los datos que desea escalar) ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://cloudant.com/blog/my-top-5-tips-for-modeling-your-data-to-scale/), publicado originalmente el 17 de diciembre de 2013).*

La forma de modelar los datos de {{site.data.keyword.cloudantfull}} afecta significativamente a la forma en que se puede escalar la aplicación. El modelo de datos subyacente difiere significativamente de un modelo relacional; si se pasa por alto esta distinción, pueden producirse problemas de rendimiento.

Como siempre, un modelado correcto implica conseguir el equilibrio entre facilidad de uso y las características de rendimiento que se desean conseguir.

Vamos a abordar el tema directamente.

## Los datos inalterables
{: #consider-immutable-data}

Si cambia la misma parte de un estado a un ritmo de una vez por segundo o más, tenga en cuenta la posibilidad de convertir sus datos en inalterables. Esto reduce significativamente la posibilidad de crear documentos en conflicto.

Por el contrario, si va a actualizar un determinado documento menos de una vez cada diez segundos, un modelo de datos de actualización inmediata (es decir, la actualización de los documentos existentes) simplifica considerablemente el código de la aplicación.

Generalmente, los modelos basados en datos inalterables requieren el uso de vistas para resumir los documentos que comprenden el estado actual. Cuando se realiza un cálculo previo de las vistas, el rendimiento de las aplicaciones no debería verse afectado.

## Por qué esto le ayuda a los datos inmutables 
{: #why-this-helps-you-consider-immutable-data}

Detrás de nuestra interfaz `https://$ACCOUNT.cloudant.com/` se encuentra una base de datos distribuida. 
Dentro del clúster, los documentos se empaquetan en varios fragmentos que colectivamente forman la base de datos. Estos fragmentos se distribuyen entre los nodos del clúster. Esto es lo que nos permite dar soporte a las bases de datos que ocupan terabytes.

De forma predeterminada, además de la división de una base de datos en fragmentos, todos los fragmentos tienen tres copias, o réplicas de fragmentos, cada una de los cuales reside en un nodo diferente del clúster de la base de datos. 
Esto permite a la base de datos continuar sirviendo solicitudes en el caso de que un nodo falle. Por lo tanto, guardar un documento implica escribir en tres nodos. Esto se traduce en que si se realizan dos actualizaciones simultáneamente en el mismo documento, es posible que un subconjunto de nodos acepte la primera actualización y otro subconjunto acepte la segunda actualización. Cuando el clúster descubre esta discrepancia, combina los documentos al igual que lo haría una réplica normal para actualizaciones simultáneas mediante la creación de un conflicto.

Los documentos en conflicto afectan negativamente al rendimiento; consulte el texto siguiente para ver más detalles sobre por qué sucede esto. 
Un patrón de actualizaciones inmediatas simultáneas también aumenta la probabilidad de que las escrituras se rechacen porque el parámetro `_rev` no es el esperado, lo que obliga a la aplicación a volver a intentar, y por lo tanto a retrasar, el proceso.

Hemos descubierto que es más probable que se produzca este escenario de documentos en conflicto en actualizaciones con una frecuencia superior a un segundo, pero recomendamos documentos inalterables para proteger las actualizaciones de más de una vez cada diez segundos.

## Utilizar vistas para precalcular resultados en lugar de índices de búsqueda
{: #use-views-to-pre-calculate-results-rather-than-as-search-indexes}

En lugar de utilizar vistas como índices de búsqueda - "obtener todos los documentos que contengan `person`" - intente conseguir que la base de datos realice el trabajo. Por ejemplo, en lugar de recuperar diez mil documentos personales para calcular las horas combinadas trabajadas, utilice una vista con una clave compuesta para realizar este cálculo previo por año, mes, día, medio día y hora mediante la reducción incorporada `_sum`. 
Ahorrará trabajo a la aplicación y permitirá que la base de datos se centre en dar servicio a muchas solicitudes pequeñas en lugar de tener que leer enormes cantidades de datos de disco para dar servicio a una sola solicitud de gran tamaño.

## Por qué esto le ayuda a utilizar vistas para precalcular los resultados
{: #why-this-helps-you-use-views-to-pre-calculate-results}

Es un proceso muy sencillo. En primer lugar, tanto las correlaciones como las reducciones se calculan con anterioridad. Esto significa que solicitar el resultado de una función reduce constituye una operación barata, especialmente si se compara con la gran cantidad de ES necesaria para procesar cientos o incluso miles de documentos del almacenamiento en disco.

A un nivel inferior, cuando un nodo recibe una solicitud de vista, solicita a los nodos que mantienen las réplicas del fragmento correspondiente a la base de datos de la vista los resultados de la solicitud de vista para los documentos de cada fragmento. A medida que recibe las respuestas (tomando la primera para cada réplica de fragmento), el nodo que da servicio a la solicitud de vista combina los resultados y direcciona el resultado final al cliente. 
Cuantos más documentos se vean involucrados, más tarda cada réplica en direccionar los resultados del disco por la red. Además, el nodo que da servicio a la solicitud tiene más trabajo que realizar al tener que combinar los resultados de cada fragmento de la base de datos.

En resumen, el objetivo consiste en que una solicitud de vista requiera la mínima cantidad de datos de cada fragmento, lo que minimiza el tiempo que los datos están en tránsito y se combinan para formar el resultado final. La potencia que ofrecen las vistas para realizar un cálculo previo de los datos agregados es una de las formas de lograr este objetivo. Evidentemente, esto reduce el tiempo que emplea la aplicación en esperar a que finalice la solicitud.

## Datos no normalizados
{: #de-normalise-your-data}

En bases de datos relacionales, la normalización de los datos suele ser el método más eficaz para almacenar datos. 
Esto tiene mucho sentido si puede utilizar sentencias JOIN para combinar fácilmente datos de varias tablas. 
En {{site.data.keyword.cloudant_short_notm}}, es más probable que necesita una solicitud GET HTTP para cada parte de los datos, de modo que reducir el número de solicitudes que necesita para crear una imagen completa de una entidad modelada le permitirá presentar información a los usuarios más rápidamente.

El uso de vistas le permite disfrutar de muchas de las ventajas de los datos normalizados mientras mantiene la versión no normalizada por motivos de eficacia.

Como ejemplo, en un esquema relacional normalmente representaría los códigos en una tabla separada y utilizaría una tabla de conexión para unir los códigos con sus documentos asociados, permitiendo una búsqueda rápida de todos los documentos con un determinado código.

En {{site.data.keyword.cloudant_short_notm}}, almacenaría los códigos en una lista en cada documento. Luego utilizaría una vista para obtener los documentos con un determinado código [emitiendo cada código como una clave en la función de correlación de la vista](/docs/services/Cloudant?topic=cloudant-views-mapreduce#views-mapreduce). 
Si se consulta una determinada clave en la vista se obtienen todos los documentos con dicho código.

## Por qué esto le ayuda con los datos no normalizados
{: #why-this-helps-you-de-normalize-your-data}

Todo depende del número de solicitudes HTTP que realice la aplicación. Abrir conexiones
HTTP tiene un coste (especialmente HTTPS) y, aunque reutilizar conexiones ayuda, el hecho de realizar menos solicitudes en general aumenta la velocidad a la que la aplicación puede procesar los datos.

Como ventaja adicional, los documentos no normalizados y las vistas precalculadas le permiten generalmente obtener por anticipado el valor que ofrece de la aplicación en lugar de generarse al momento.

## Evitar conflictos mediante documentos más granulares
{: #avoid-conflicts-by-using-finer-grained-documents}

El siguiente consejo va en contra de la sugerencia de no normalizar los datos: utilice documentos muy granulares para reducir la posibilidad de que modificaciones simultáneas creen conflictos. 
Esto se parece a normalizar los datos. Hay que equilibrar la balanza entre reducir el número de solicitudes HTTP y evitar conflictos.

Por ejemplo, supongamos que tenemos un registro médico que contiene una lista de operaciones:

```json
{
    "_id": "Joe McIllness",
    "operations": [
        { "surgery": "heart bypass" },
        { "surgery": "lumbar puncture" }
    ]
}
```
{: codeblock}

Si Joe tiene la mala suerte de tener varias operaciones al mismo tiempo, es probable que las muchas actualizaciones simultáneas en un documento creen documentos en conflicto, tal como se describe anteriormente. 
Es mejor desglosar las operaciones en distintos documentos que hacen referencia al documento personal de Joe y utilizar una vista para conectarlo todo. Para representar cada operación, debería cargar documentos como los de los dos ejemplos siguientes:

```json
{
    "type": "operation",
    "patient": "Joe McIllness",
    "surgery": "heart bypass"
}
```
{: codeblock}

```json
{
    "type": "operation",
    "patient": "Joe McIllness",
    "surgery": "lumbar puncture"
}
```
{: codeblock}

Si emite el campo `"patient"` como clave en la vista, podrá consultar todas las operaciones correspondientes a un determinado paciente. Nuevamente se utilizan vistas para ayudar a componer una imagen completa de una determinada entidad a partir de distintos documentos, lo que ayuda a mantener un número bajo de solicitudes HTTP aunque se hayan dividido los datos correspondientes a una sola entidad modelada.

## Por qué esto le ayuda a evitar conflictos
{: #why-this-helps-you-avoid-conflicts}

Evitar documentos en conflicto ayuda a agilizar muchas operaciones de las bases de datos de {{site.data.keyword.cloudant_short_notm}}. 
Esto se debe a que hay un proceso que funciona fuera de la revisión principal actual utilizada cada vez que se lee el documento: recuperaciones de documentos individuales, llamadas con `include_docs=true`, creación de vistas, etc.

La revisión principal es una revisión particular del árbol general del documento. Recuerde que los documentos en {{site.data.keyword.cloudant_short_notm}} son, de hecho, árboles de revisiones. Un algoritmo arbitrario pero determinante selecciona una de las hojas no suprimidas de este árbol para devolverla cuando se realiza una solicitud del documento. Los árboles de gran tamaño con un alto factor de ramificación tardan más en procesarse que un árbol de documentos con pocas ramas o sin ellas: se debe seguir cada rama para ver si es candidata a ser la revisión principal. Luego las candidatas potenciales se comparan entre sí para tomar la decisión final.

{{site.data.keyword.cloudant_short_notm}} gestiona bien pequeños números de ramas (después de todo, la réplica se basa en que los documentos se pueden ramificar para evitar que se descarten datos), pero si se alcanzan niveles patológicos, en concreto si no se resuelven conflictos, recorrer el árbol de documentos consume mucho tiempo y memoria.

## Resolución de conflictos integrados
{: #build-in-conflict-resolution}

En un sistema finalmente coherente como {{site.data.keyword.cloudant_short_notm}}, pueden producirse conflictos. Tal como se ha descrito anteriormente, este es el precio de nuestra escalabilidad y resiliencia de datos.

Estructurar los datos de modo que la resolución de conflictos sea rápida y no implique la asistencia de un operador ayuda al funcionamiento continuado de las bases de datos. La capacidad de resolver conflictos automáticamente sin que se tengan que implicar los usuarios mejora significativamente su experiencia y reduce la carga del equipo de soporte de la organización.

Cómo lo haga dependerá de cada aplicación, pero aquí encontrará algunas sugerencias:

-   Evite invariables entre campos de documentos siempre que sea posible. Esto aumenta la probabilidad de que una sola operación de fusión, que tome el campo modificado de cada revisión de documento en conflicto, resulte adecuada. También ayuda a que el código de la aplicación sea más sencillo y potente.
-   Permita que los documentos sean autónomos. La necesidad de recuperar otros documentos para conseguir una resolución correcta aumenta la latencia en la resolución de conflictos. También existe la posibilidad de que obtenga una versión de los otros documentos que no sea coherente con el documento que esté resolviendo, lo que dificulta la resolución correcta. Además, ¿qué pasa si los otros documentos también están en conflicto?

## Por qué esto le ayuda a resolver los conflictos integrados 
{: #why-this-helps-you-build-in-conflict-resolution}

Tal como se ha descrito anteriormente, los documentos muy conflictivos causan estragos en la base de datos. Incorporar desde el principio la capacidad para solucionar conflictos constituye una gran ayuda para evitar documentos conflictivos patológicos.

## Resumen
{: #summary}

Estas sugerencias muestran algunas de las formas en que el modelado de los datos afecta al rendimiento de la aplicación. El almacén de datos de {{site.data.keyword.cloudant_short_notm}} tiene algunas características específicas, tanto para controlar como para aprovechar, para garantizar el escalado del rendimiento de la base de datos a medida que crece la aplicación. Comprendemos que este asunto puede resultar confuso, por lo que siempre puede contar con nosotros para obtener ayuda.

Para continuar leyendo, consulte el apartado sobre [Modelo de datos para Foundbite ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://cloudant.com/blog/foundbites-data-model-relational-db-vs-nosql-on-cloudant/){: new_window},
o sobre [Ejemplo de nuestros amigos de Twilio ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://www.twilio.com/blog/2013/01/building-a-real-time-sms-voting-app-part-3-scaling-node-js-and-couchdb.html){: new_window}.

