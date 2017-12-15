---

copyright:
  years: 2015, 2017
lastupdated: "2017-01-24"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-01-24 -->

<div id="cap_theorem"></div>

<div id="consistency"></div>

# Teorema de CAP

Cloudant utiliza un modelo ['Finalmente coherente' ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](http://en.wikipedia.org/wiki/Eventual_consistency){:new_window}.
{:shortdesc}

Para comprender el funcionamiento de este modelo y por qué es una parte esencial del
uso de Cloudant,
vea a continuación lo que entendemos por Coherencia. 

La coherencia es una de las cuatro propiedades ['ACID' ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://en.wikipedia.org/wiki/ACID){:new_window}
necesarias para que las transacciones realizadas dentro de una base de datos se procesen y notifiquen de forma fiable. 

Además, la coherencia es uno de los tres atributos del teorema de 
<a href="http://en.wikipedia.org/wiki/CAP_Theorem" target="_blank">'CAP' <img src="../images/launch-glyph.svg" alt="Icono de enlace externo" title="Icono de enlace externo"></a>.
Los atributos son Coherencia (**C**onsistency),
Disponibilidad (**A**vailability) y Tolerancia de partición (**P**artition tolerance).
Según este teorema, un sistema de cálculo distribuido como Cloudant no puede garantizar estos tres atributos _simultáneamente_:

-   Coherencia, según el que todos los nodos ven los mismos datos al mismo tiempo. 
-   Disponibilidad, que garantiza que cada solicitud recibe una respuesta sobre si se ha ejecutado correctamente o no. 
-   Tolerancia de partición, por el que el sistema sigue funcionando aunque una parte del sistema se pierda o falle. 

La imposibilidad de garantizar los tres atributos al mismo tiempo significa
que Cloudant no garantiza el atributo Coherencia.
En un modelo finalmente coherente, como
Cloudant,
una actualización realizada en una parte del sistema es vista _finalmente_ por las otras partes del sistema.
En cuanto la actualización se propaga,
se dice que el sistema 'converge' en una coherencia completa. 

La coherencia final es positiva para el rendimiento.
Con un modelo de coherencia potente, un sistema debe esperar a que las actualizaciones se propaguen por completo y correctamente para que se pueda completar una solicitud de escritura o de actualización.
Con un modelo finalmente coherente, la solicitud de escritura o actualización puede devolver un resultado casi de inmediato, mientras que la propagación en el sistema continúa 'entre bastidores'. 

Una base de datos solo puede ofrecer dos de estos tres atributos por motivos tanto teóricos como prácticos.
Una base de datos que dé prioridad a la coherencia y a la disponibilidad es sencilla: un solo nodo guarda una sola copia de los datos.
Pero este modelo es difícil de escalar, ya que el usuario debe actualizar el nodo para aumentar el rendimiento en lugar de utilizar nodos adicionales.
Además, incluso un error menor en el sistema puede hacer que se cierre un sistema de un solo nodo, y cualquier pérdida de mensaje significa una pérdida de datos significativa.
Para que resista, el sistema debe ser más sofisticado. 

## Compensaciones en la tolerancia de partición

Una base de datos que dé prioridad a la coherencia y a la tolerancia de partición suele empezar una configuración de tipo 
<a href="http://en.wikipedia.org/wiki/Master/slave_(technology)" target="_blank">maestro-esclavo <img src="../images/launch-glyph.svg" alt="Icono de enlace externo" title="Icono de enlace externo"></a>, donde un nodo de los muchos del sistema se elige como líder.
Solo el líder puede aprobar las escrituras de datos, mientras que todos los nodos secundarios replican los datos del líder para gestionar las lecturas.
Si el líder pierde la conexión con la red o no se puede comunicar con muchos de los nodos del sistema, el resto elige un nuevo líder.
Este proceso de elección difiere entre los sistemas y puede ser una fuente de [problemas importantes ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](http://aphyr.com/posts/284-call-me-maybe-mongodb){:new_window}.

Cloudant da prioridad a la disponibilidad y a la tolerancia de partición mediante el uso de una configuración de tipo maestro-maestro, de modo que cualquier nodo puede aceptar tanto escrituras como lecturas en su parte de los datos.
Varios nodos contienen copias de cada parte de los datos.
Cada nodo copia datos con otros nodos.
Si no se puede acceder a un nodo, otros pueden dar servicio en su lugar mientras se soluciona el problema de la red.
De este modo, el sistema devuelve los datos puntualmente a pesar de un error arbitrario en un nodo y mantiene la [coherencia final ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](http://en.wikipedia.org/wiki/Eventual_consistency){:new_window}.
La compensación de retirar la prioridad a la coherencia absoluta es que se tarda un rato en conseguir que todos los nodos vean los mismos datos.
Como resultado, algunas respuestas pueden contener datos antiguos mientras los datos nuevos se propagan por el sistema. 

## Cambio del enfoque

El hecho de mantener una visión coherente de los datos es algo lógico y fácil de comprender, ya que la base de datos relacional es la encargada de conseguirlo.
La expectativa es que los servicios basados en la web que interactúan con los sistemas de bases de datos se comporten de este modo.
Pero esta expectativa no significa que se vayan a comportar así.
La coherencia no se da por hecho y se requiere bastante trabajo para cambiar este enfoque. 

De hecho, la coherencia no es necesariamente esencial para muchos servicios de nube de la empresa.
En sistemas grandes y con grandes cargas de trabajo, existe una alta probabilidad de que una parte del sistema pueda fallar.
Una base de datos diseñada con base en la necesidad de dar prioridad a la disponibilidad y a la coherencia final se adapta mejor al mantenimiento de la aplicación en línea.
La coherencia de los datos de la aplicación se gestionan teniendo en cuenta este hecho.
Tal como Seth Gilbert y Nancy Lynch de MIT
[concluyen ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](http://www.glassbeam.com/sites/all/themes/glassbeam/images/blog/10.1.1.67.6951.pdf){:new_window},
"actualmente, la mayoría de los sistemas reales se ven obligados a devolver 'la mayoría de los datos, la mayor parte del tiempo'".

## Disponibilidad de la aplicación frente a coherencia en la empresa

Si echamos un vistazo a los servicios basados en la web más populares, observaremos que la gente ya espera una alta disponibilidad y aceptan intercambiar este nivel de disponibilidad por datos finalmente coherentes, sin siquiera darse cuenta de que lo están haciendo.

Muchas aplicaciones confunden a los usuarios en favor de la disponibilidad.
Observemos los cajeros automáticos:
la incoherencia de los datos bancarios es la razón por la que se puede tener un descubierto sin que uno se dé cuenta.
No resulta realista presentar una vista coherente del saldo de una cuenta en todo el sistema bancario si cada nodo de la red debe detenerse y registrar este estado antes de que continúe la operación.
Es preferible conseguir que el sistema esté siempre disponible. 

La industria bancaria se dio cuenta de este hecho durante los años 80, pero a muchas organizaciones de TI les sigue preocupando sacrificar la coherencia en favor de la disponibilidad.
Piense en la cantidad de llamadas de servicio que se reciben cuando el equipo de ventas no puede acceder a su app CRM.
Ahora piense si notarían que se tarda unos segundos en propagar la actualización de una base de datos a la aplicación. 

La disponibilidad triunfa sobre la coherencia más de lo que se puede imaginar.
Los sistemas de carro de compra en línea, las memorias caché HTTP y los DNS son unos cuantos ejemplos.
Las organizaciones deben tener en cuenta el coste del tiempo de inactividad, que da lugar a la frustración del usuario y la pérdida de productividad y de oportunidades. 

## De la teoría a la implementación

Conseguir una alta disponibilidad resulta vital para las aplicaciones de la nube.
De lo contrario, la coherencia global de las bases de datos se convierte en un cuello de botella importante a medida que crece el sistema.
Las aplicaciones altamente disponibles deben mantener un contacto constante con sus datos, aunque dichos datos no sean los más actualizados.
Este es el concepto de la coherencia final, y no debería asustar a nadie.
A gran escala, en ocasiones es mejor dar respuestas que no sean perfectamente correctas que no ofrecer ninguna respuesta. 

Los sistemas de bases de datos ocultan la complejidad del reto disponibilidad frente a coherencia de distintas formas, pero no dejan de estar ahí.
La visión que adopta la base de datos como servicio de Cloudant, junto con CouchDB y otras bases de datos NoSQL,
es que es preferible que los desarrolladores solucionen este tipo de complejidades en fases tempranas del proceso de diseño.
Si el trabajo duro se hace al principio, se reducen las sorpresas ya que las aplicaciones están listas para ampliar su capacidad desde el primer día. 
