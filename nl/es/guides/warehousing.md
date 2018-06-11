---

copyright:
  years: 2015, 2018
lastupdated: "2018-03-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

# Depósitos de datos

## Característica {{site.data.keyword.dashdbshort_notm}} de {{site.data.keyword.cloudant_short_notm}} en desuso (7 de febrero de 2018)
{: #deprecating-cloudant-nosql-db-s-db2-warehouse-on-cloud-feature-february-7-2018-}

La característica {{site.data.keyword.dashdblong}} de {{site.data.keyword.cloudantfull}} está en desuso y se retirará según la siguiente línea temporal. Los datos no se eliminarán de ningún sistema pero la sincronización se detendrá. 

Fecha de desuso | ¿Qué es lo que queda en desuso?
-----------------|--------------------------
16 de enero de 2018 | El separador Depósito solo está disponible para las instancias de servicio de {{site.data.keyword.cloudant_short_notm}} que ya disponen de trabajos de {{site.data.keyword.dashdbshort_notm}} creados en el separador Depósito.  Si no ha creado un trabajo de {{site.data.keyword.dashdbshort_notm}}, no podrá acceder a esta característica.
31 de marzo de 2018   | Los clientes que empezaron a utilizar la función {{site.data.keyword.dashdbshort_notm}} antes del 16 de enero no podrán crear los trabajos de {{site.data.keyword.dashdbshort_notm}} nuevos.
5 de mayo de 2018      | Se detendrán los trabajos de {{site.data.keyword.dashdbshort_notm}} existentes. Todavía se podrá ver el estado final en el panel de control.
31 de mayo de 2018     | La interfaz de usuario para la característica {{site.data.keyword.dashdbshort_notm}} se ha eliminado. El estado de los trabajos de {{site.data.keyword.dashdbshort_notm}} deja de estar disponible.
 
Los datos transferidos a {{site.data.keyword.dashdbshort_notm}} a partir del 30 de abril de 2018 permanecerán en {{site.data.keyword.dashdbshort_notm}} y los datos de {{site.data.keyword.cloudant_short_notm}} tampoco quedarán afectados.

### Alternativas a la característica {{site.data.keyword.dashdbshort_notm}}

Consulte el [repositorio de ejemplos de flujo de datos ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/cloudant-labs/data-flow-examples){:new_window} para obtener guías de aprendizaje sobre la extracción de documentos de {{site.data.keyword.cloudant_short_notm}} y la escritura de datos en una tabla de {{site.data.keyword.dashdbshort_notm}}.


## Visión general del depósito de datos

Una base de datos resulta esencial para almacenar datos.
Pero lo que la convierte en valiosa es el hecho de poder aplicar dichos datos a fines comerciales: poder recuperar los datos relevantes, de manera rápida y fácil, y ponerlos a trabajar con las aplicaciones.
{:shortdesc}

Pero muchas de las tareas de almacenamiento, proceso y análisis que realiza con los datos se utilizan muchas veces en las aplicaciones.
Podrían ser buenos ejemplos de prácticas recomendadas de la industria.

De modo que tiene mucho sentido ampliar la capacidad de la base de datos estándar con características adicionales que den soporte a tareas como la notificación o el análisis.

Durante casi 30 años, los
'depósitos de datos' han constituido el estándar de la industria en cuanto a almacenamiento de datos, notificación y análisis, basados en la tecnología de las bases de datos relacionales.
En general, un [depósito de datos es ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://en.wikipedia.org/wiki/Data_warehouse){:new_window}:
"... un repositorio central de datos integrados procedentes de una o varias fuentes.
Almacena datos actuales e históricos.
Se puede utilizar para realizar análisis y para crear informes para los trabajadores de la empresa."

En los últimos años han emergido tecnologías que permiten el almacenamiento de datos, notificación y análisis como respuesta a la necesidad de procesar '[Big Data ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://en.wikipedia.org/wiki/Big_data){:new_window}':
"Big Data es un término que se aplica a conjuntos de datos tan grandes o complejos que hacen que las aplicaciones tradicionales de proceso de datos resulten inadecuadas".

Paralelamente, las propiedades y características de los depósitos de datos y productos relacionados indican que el uso de una tecnología de bases de datos relacionales para habilitar los depósitos de datos es una opción muy utilizada, incluso para tareas con Big Data.

Existen muchos casos que ilustran las ventajas de integrar las características de
{{site.data.keyword.cloudant_short_notm}} con un depósito de datos relacional, como en los siguientes ejemplos.

## ¿Es esta la integración correcta para mi caso práctico?

La integración de depósito de {{site.data.keyword.cloudant_short_notm}} es un proceso simplificado que descubrirá automáticamente los esquemas de sus documentos e importará datos de forma inteligente a {{site.data.keyword.dashdbshort_notm}} o {{site.data.keyword.Db2_on_Cloud_short}}. Cuando crea un depósito en {{site.data.keyword.cloudant_short_notm}}, primero se descubrirá el esquema automáticamente y, a continuación, los datos se importarán a la base de datos {{site.data.keyword.dashdbshort_notm}} conectada. 

La integración es adecuada cuando los datos tienen las características siguientes:

* Tiene un conjunto de esquemas generalmente estático. Un esquema modificado necesita
    reiniciar el depósito, que vuelve a importar los datos desde cero.
* Es posible descubrir los esquemas escaneando desde unos pocos documentos hasta decenas de miles de ellos. Una vez descubiertos los esquemas, podrán importarse al depósito millones de documentos.
* No es estrictamente necesario que el depósito se realice en tiempo real. Normalmente, los documentos actualizados aparecen en un almacén en cuestión de segundos, aunque esto no se garantiza y puede variar en función de la carga de la base de datos.
* {{site.data.keyword.Db2_on_Cloud_short}} limita los esquemas a 1,012 campos. Los documentos JSON con un gran
    número de campos, incluidos los objetos anidados y las matrices grandes, pueden exceder el límite.

## Unión de datos

La unión de datos procedentes de varios almacenes de datos para el análisis entre dominios es una tarea que se puede realizar de manera fácil y eficiente mediante un depósito de datos relacional.

Los datos procedentes de diversas fuentes se preparan y se transforman a un formato común durante la carga de un depósito de datos.
Los registros se almacenan en tablas y existen operaciones para unir estas tablas para permitir su análisis combinado.

Realizar la unión en un depósito de datos relacional resulta especialmente útil si algunos de los datos ya están disponibles en representación relacional, por ejemplo datos maestros o datos de consulta.

## Flexibilidad

Las bases de datos de {{site.data.keyword.cloudant_short_notm}} son flexibles a la hora de representar los datos.
Por ejemplo, no imponen ningún esquema durante la lectura o escritura.

Por el contrario, se necesita un modelo bien definido y que se imponga rigurosamente para las tareas de notificación y análisis.

Con los documentos disponibles en un depósito relacional puede basar su modelo en conjunto fijo de definiciones de tablas.
Solo los documentos que se ajustan al esquema de tabla se pueden cargar y los infractores se rechazan.
Puede entrenar sus modelos con datos coherentes utilizando un esquema relacional fijo.

## Certificación de la integridad de los datos

Los depósitos de datos pueden utilizar restricciones para certificar la integridad de los datos.
Por ejemplo:

-   Dos registros no pueden tener la misma clave primaria.
-   Las claves foráneas garantizan que los registros están completos.
-   Existen funciones para validar los registros frente a las reglas de la empresa.

Exclusividad, corrección y completitud son requisitos esenciales para cualquier servicio de empresa.
El hecho de cargar los documentos de {{site.data.keyword.cloudant_short_notm}} en un depósito de datos le ayuda a cumplir con estos requisitos.

## {{site.data.keyword.cloudant_short_notm}} y los depósitos de datos

Los depósitos de datos constituyen una tecnología importante y madura.
{{site.data.keyword.cloudant_short_notm}} proporciona una estrecha integración con depósitos de datos relacionales, ofreciéndose así las ventajas de esta tecnología.

{{site.data.keyword.cloudant_short_notm}} tiene una función básica de depósito integrada, en forma de [vistas de MapReduce](../api/using_views.html),
que le permite realizar varias tareas básicas de análisis.

Para tareas de depósito más avanzadas, puede aprovechar las características que ofrece el servicio de
depósito basado en la nube de
IBM [{{site.data.keyword.IBM}} {{site.data.keyword.dashdbshort_notm}}![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/analytics/us/en/data-management/data-warehouse/){:new_window}.

Si utiliza {{site.data.keyword.cloudant_short_notm}},
tiene acceso fácil e integrado a funciones avanzadas de depósito como las siguientes:

-   Consulta de los datos JSON en formato de base de datos relacional.
-   Realización de consultas basadas en SQL sobre sus datos.
-   Generación de análisis a partir de sus datos.

Estas características avanzadas de depósito se habilitan mediante servicios como {{site.data.keyword.dashdbshort_notm}},
que constituye un complemento natural de {{site.data.keyword.cloudant_short_notm}}.

Como alternativa, si solo necesita un almacén de datos relacionales para sus documentos, sin funciones de depósito, puede cargar los documentos de {{site.data.keyword.cloudant_short_notm}} en el servicio [{{site.data.keyword.Db2_on_Cloud_short}}](#ibm-db2-on-cloud).

## {{site.data.keyword.dashdblong_notm}}

{{site.data.keyword.dashdbshort_notm}} es un servicio de depósito de datos basado en la nube, específicamente pensado para el trabajo de análisis.
Aunque resulta especialmente adecuado para datos JSON de {{site.data.keyword.cloudant_short_notm}}, {{site.data.keyword.dashdbshort_notm}} puede aceptar datos procedentes de diversas fuentes examinando la estructura de los datos cuando se cargan.

Para obtener más información, consulte la [documentación de {{site.data.keyword.dashdblong_notm}}![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/support/knowledgecenter/SS6NHC/com.ibm.swg.im.dashdb.kc.doc/welcome.html){:new_window}.

## {{site.data.keyword.Db2Hosted_notm}}

[{{site.data.keyword.Db2Hosted_full}} ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://console.ng.bluemix.net/catalog/services/ibm-db2-on-cloud){:new_window}
le ofrece una base de datos en una infraestructura de nube global de IBM SoftLayer®.
Le ofrece todas las potentes características del despliegue de Db2 local, sin el coste, la complejidad ni el riesgo de tener que gestionar su propia infraestructura.

Para obtener más información, consulte la [documentación de {{site.data.keyword.Db2Hosted_short}}![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://console.ng.bluemix.net/docs/services/DB2OnCloud/index.html#DB2OnCloud){:new_window}.

## Creación de un depósito

Hay dos maneras de crear un depósito:

1.  [Utilice {{site.data.keyword.cloudant_short_notm}} para crear un depósito {{site.data.keyword.dashdbshort_notm}}](#use-cloudant-to-create-a-db2-warehouse-on-cloud-warehouse)
2.  [Conecte {{site.data.keyword.cloudant_short_notm}} a un depósito existente](#connect-cloudant-to-an-existing-warehouse)

### Utilice {{site.data.keyword.cloudant_short_notm}} para crear un depósito {{site.data.keyword.dashdbshort_notm}}

El método más sencillo de crear un depósito consiste en que {{site.data.keyword.cloudant_short_notm}} cree una instancia del depósito {{site.data.keyword.dashdbshort_notm}} en {{site.data.keyword.Bluemix}}
en su nombre.
Para ello pulse el botón `Crear depósito` en la tarea `Depósito` del separador `Integraciones` en el panel de control de {{site.data.keyword.cloudant_short_notm}}.

![Instantánea de la tarea"Crear un {{site.data.keyword.dashdbshort_notm}} depósito" en el panel de control de {{site.data.keyword.cloudant_short_notm}} ](../images/createDashDBWH.png)

Si aún no ha iniciado una sesión en {{site.data.keyword.Bluemix_notm}}, se le solicitará que lo haga.

>   **Nota**: De forma predeterminada, {{site.data.keyword.cloudant_short_notm}} crea una instancia de {{site.data.keyword.dashdbshort_notm}} en {{site.data.keyword.Bluemix_notm}} para su depósito.

![Instantánea de la tarea "Autenticar en {{site.data.keyword.Bluemix_notm}}" En el panel de control de {{site.data.keyword.cloudant_short_notm}} ](../images/authenticateToBluemix.png)

Cuando se haya autenticado, puede solicitar que se cree una nueva instancia de {{site.data.keyword.dashdbshort_notm}} utilizando su cuenta de {{site.data.keyword.Bluemix_notm}}.

Para ello:

1.  Especifique el nombre que desea utilizar para el depósito en el campo `Nombre de depósito`.
2.  Especifique el nombre de su base de datos existente en {{site.data.keyword.cloudant_short_notm}}, en el campo `Orígenes de datos`.
3.  Asegúrese de que la opción `Crear nueva instancia de {{site.data.keyword.dashdbshort_notm}}` esté seleccionada en el formulario.
4.  Pulse el botón `Crear depósito`.

![Instantánea de la tarea "Crear depósito" en el panel de control de {{site.data.keyword.cloudant_short_notm}} ](../images/createWarehouse.png)

### Conecte {{site.data.keyword.cloudant_short_notm}} a un depósito existente

En lugar de utilizar {{site.data.keyword.cloudant_short_notm}} para crear la base de datos del depósito {{site.data.keyword.dashdbshort_notm}},
puede conectarse a una instancia existente de {{site.data.keyword.dashdbshort_notm}}.

El proceso es similar al de [utilizar {{site.data.keyword.cloudant_short_notm}} para crear un depósito {{site.data.keyword.dashdbshort_notm}}](#use-cloudant-to-create-a-db2-warehouse-on-cloud-warehouse),
pero en lugar de seleccionar la opción `Crear nueva instancia de {{site.data.keyword.dashdbshort_notm}} `,
debe seleccionar `Instancia de servicio de {{site.data.keyword.dashdbshort_notm}}` y elegir el depósito de {{site.data.keyword.dashdbshort_notm}} que ya existe en {{site.data.keyword.Bluemix_notm}}.

![Instantánea de la tarea "Conectar a una instancia de {{site.data.keyword.dashdbshort_notm}} existente" en el panel de control de {{site.data.keyword.cloudant_short_notm}} ](../images/existingDashDBInstance.png)

### Utilización de una instancia de depósito de {{site.data.keyword.Db2_on_Cloud_short}}

Si lo prefiere, puede conectarse con una instancia de depósito de {{site.data.keyword.Db2_on_Cloud_short}} en lugar de con {{site.data.keyword.dashdbshort_notm}}.
Para ello, seleccione la opción `DB2` en el panel de control de {{site.data.keyword.cloudant_short_notm}} para conectar con una instancia existente de {{site.data.keyword.Db2_on_Cloud_short}}.

![Instantánea de la tarea Crear un depósito de {{site.data.keyword.Db2_on_Cloud_short}} " en el panel de control de {{site.data.keyword.cloudant_short_notm}} ](../images/createDB2WH.png)

Si desea conectar con una instancia de {{site.data.keyword.Db2_on_Cloud_short}}, debe proporcionar los siguientes detalles:

-   Dirección del host
-   Número de puerto
-   Nombre de base de datos
-   ID de usuario para la base de datos
-   Contraseña del ID de usuario

>   **Nota**: En el resto de este tema nos referiremos a {{site.data.keyword.dashdbshort_notm}} como la instancia del depósito.
    Sin embargo, el tema se aplica igualmente si utiliza una instancia de {{site.data.keyword.Db2_on_Cloud_short}}.
    Dispone de una guía de aprendizaje en la que se describe cómo [cargar datos JSON desde {{site.data.keyword.cloudant_short_notm}} en {{site.data.keyword.dashdbshort_notm}} ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://developer.ibm.com/clouddataservices../dashdb/get/load-json-from-cloudant-database-in-to-dashdb/){:new_window},
    e incluye ejemplos de utilización de {{site.data.keyword.Db2_on_Cloud_short}} como base de datos de depósito.

## Esquema del depósito

La primera vez que cree un depósito desde dentro de {{site.data.keyword.cloudant_short_notm}}, {{site.data.keyword.dashdbshort_notm}} crea el mejor esquema posible para los datos de la base de datos, lo que ayuda a garantizar que cada uno de los campos de los documentos JSON tiene una entrada correspondiente en el nuevo esquema.
Si lo desea, al crear el depósito puede optar por [personalizar el esquema](#customizing-the-warehouse-schema) manualmente.

Una vez creado el esquema, el depósito puede contener los datos en formato relacional.
Luego, {{site.data.keyword.cloudant_short_notm}} [crea una réplica](../api/replication.html) para realizar la 'carga inicial' de los documentos de la base de datos en el depósito, ofreciéndole una colección de trabajo de sus datos en la base de datos relacional de {{site.data.keyword.dashdbshort_notm}}.

Con el tiempo, el contenido de la base de datos de {{site.data.keyword.cloudant_short_notm}} puede cambiar.
Puede modificar el esquema de un depósito existente.

>   **Nota**: Si modifica el esquema de un depósito existente,
    deberá realizar una réplica de los datos de la base de datos de {{site.data.keyword.cloudant_short_notm}} en la base de datos de depósito.
    La modificación del esquema genera una nueva 'carga inicial' en el depósito.

## Cómo trabajar con el depósito

Con el sistema de depósito de {{site.data.keyword.cloudant_short_notm}},
puede ejecutar consultas SQL 'tradicionales' y ver los resultados, todo desde dentro de la consola de {{site.data.keyword.dashdbshort_notm}}.


![Instantánea del panel de control de"{{site.data.keyword.dashdbshort_notm}} " en {{site.data.keyword.Bluemix_notm}}](../images/useDashDBdashboard.png)

Las aplicaciones externas pueden interactuar con los datos de la misma manera que con cualquier otra base de datos relacional.
La ventaja de {{site.data.keyword.dashdbshort_notm}} es que puede realizar otras tareas de depósito, como cargar más datos procedentes de otras fuentes, y analizar los datos utilizando las herramientas analíticas incorporadas.
{{site.data.keyword.dashdbshort_notm}} da soporte al [lenguaje de programación `'R'`![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://en.wikipedia.org/wiki/R_%28programming_language%29){:new_window} y al entorno de software para cálculos estadísticos y gráficos.
Esto significa que tiene acceso a los algoritmos que le permiten realizar tareas de análisis de base de datos, como la regresión lineal, el clúster 'k-means' y análisis geoespaciales.

La herramienta `RStudio` le permite crear scripts `'R'` que se cargan en {{site.data.keyword.dashdbshort_notm}} y se ejecutan utilizando sus datos.

Para obtener información sobre cómo trabajar con {{site.data.keyword.dashdbshort_notm}},
consulte la [documentación de {{site.data.keyword.dashdblong_notm}} ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/support/knowledgecenter/SS6NHC/com.ibm.swg.im.dashdb.kc.doc/welcome.html){:new_window}.

## Mantenimiento de los datos y la infraestructura actualizados

Los datos se cargan de {{site.data.keyword.cloudant_short_notm}} a {{site.data.keyword.dashdbshort_notm}} utilizando un proceso de [réplica](../api/replication.html).
Esto significa que si los datos de {{site.data.keyword.cloudant_short_notm}} se actualizan o se modifican de alguna manera, la réplica de los documentos en {{site.data.keyword.dashdbshort_notm}} debe realizarse de nuevo para garantizar que las tareas analíticas siguen trabajando utilizando la información más actualizada.

Al igual que sucede con la réplica normal de {{site.data.keyword.cloudant_short_notm}}, los datos se transfieren solo en una dirección: para un
depósito la transferencia se realiza
desde {{site.data.keyword.cloudant_short_notm}} a {{site.data.keyword.dashdbshort_notm}}.
Tras la carga inicial de los datos, el depósito se suscribe a los cambios en el contenido de los datos en la base de datos {{site.data.keyword.cloudant_short_notm}}.
Se realiza una réplica de los cambios del origen de {{site.data.keyword.cloudant_short_notm}} en el destino de {{site.data.keyword.dashdbshort_notm}}.
Esto significa que el depósito es una forma de réplica continua de {{site.data.keyword.cloudant_short_notm}} en {{site.data.keyword.dashdbshort_notm}}.

Con el tiempo, la base de datos de {{site.data.keyword.cloudant_short_notm}} puede sufrir cambios estructurales.
Esto puede incluir la adición o eliminación de campos de los documentos JSON.
Cuando esto sucede, el esquema que utiliza el depósito puede dejar de ser válido, lo que da lugar a que se notifiquen errores cuando se realiza una réplica de datos actualizados de {{site.data.keyword.cloudant_short_notm}} en {{site.data.keyword.dashdbshort_notm}}.

Para solucionar este problema, el depósito de {{site.data.keyword.cloudant_short_notm}} tiene un recurso de 'nuevo escaneo'.
Este recurso vuelve a escanear la estructura de la base de datos de {{site.data.keyword.cloudant_short_notm}} y determina el nuevo esquema que se necesita en {{site.data.keyword.dashdbshort_notm}}.
Las tablas antiguas de {{site.data.keyword.dashdbshort_notm}} creadas durante el escaneo anterior se eliminan, se crean tablas nuevas mediante el nuevo esquema y, finalmente, los datos de {{site.data.keyword.cloudant_short_notm}} actuales se cargan como una nueva 'carga inicial'.

Para utilizar el recurso de nuevo escaneo, asegúrese primero de que el depósito no se esté ejecutando.
Para ello siga estos pasos:

1.  Seleccione el separador `Integraciones` del panel de control de {{site.data.keyword.cloudant_short_notm}}.
2.  Busque el nombre del depósito que desea volver a escanear en la tarea `Depósito`:<br/>![Instantánea del separador "depósito" en el panel de control de {{site.data.keyword.cloudant_short_notm}} ](../images/selectWarehouse.png)
3.  Pulse el nombre del depósito.
    Es un enlace, y, cuando se pulsa, se abre la vista detallada del depósito:<br/>![Instantánea de la vista detallada del depósito en el panel de control de {{site.data.keyword.cloudant_short_notm}} ](../images/viewWarehouseDetail.png)
4.  Compruebe el estado actual del depósito.
    Un círculo verde rotatorio indica que el depósito se está ejecutando.
    Para detener el depósito, pulse el icono `Detener base de datos` de la columna Acciones:<br/>![Instantánea del icono"detener base de datos de depósito" en el panel de control de {{site.data.keyword.cloudant_short_notm}} ](../images/stopWarehouseDatabase.png)
5.  Cuando la base de datos de depósito no se está ejecutando, se habilita el icono `Volver a escanear` en la columna Acción:<br/>![Instantánea del icono del nuevo escaneo en el panel de control de {{site.data.keyword.cloudant_short_notm}} ](../images/rescanIcon.png)

### Nuevo escaneo de la base de datos de origen

![Instantánea de la ventana que le permite volver a escanear la base de datos de origen del depósito.](../images/rescanSource.png)

Cuando pulsa el icono `Volver a escanear`, tiene dos opciones:

-   Un escaneo directo de la base de datos.
    Esta es la acción predeterminada, y es muy similar al escaneo inicial de la base de datos realizado  al crear el depósito.
-   Personalizar el esquema del depósito.

Si elige la acción predeterminada de un nuevo escaneo simple, se inspecciona la base de datos de origen y se genera un nuevo esquema de la base de datos del depósito.
En cuanto finaliza el nuevo escaneo, se inicia el depósito.

Si desea personalizar el esquema del depósito, habilite el recuadro de selección `Personalizar esquema` antes de pulsar el botón `Volver a escanear`.

![Instantánea del panel 'Volver a escanear origen', que muestra la opción 'Personalizar esquema' habilitada.](../images/rescanSource2.png)

El recuadro de selección `Personalizar esquema` habilita dos opciones.

1.  El algoritmo de descubrimiento utilizado.
2.  El tamaño de la muestra.

### El algoritmo de descubrimiento

La opción predeterminada para volver a escanear es el algoritmo `Unión`.
Este algoritmo utiliza todos los atributos de todos los documentos de la base de datos de {{site.data.keyword.cloudant_short_notm}} de muestra para crear un único conjunto de tablas en la base de datos del depósito.
El resultado es que todos los documentos de la base de datos de {{site.data.keyword.cloudant_short_notm}} se pueden almacenar en la base de datos del almacén, pero es posible que algunas filas de la base de datos no tengan contenido en algunos de los campos.

La opción alternativa para volver a escanear es el algoritmo `Cluster`.
Este algoritmo identifica los documentos de la base de datos de {{site.data.keyword.cloudant_short_notm}} que tienen el mismo conjunto de atributos y, a continuación, crea los correspondientes esquemas de la tabla de la base de datos del depósito.

### El tamaño de la muestra

Esta opción determina el número de documentos de la base de datos de {{site.data.keyword.cloudant_short_notm}} que se inspeccionan como parte de la determinación del esquema.

El valor predeterminado es 10.000 documentos.

Si se define un valor demasiado bajo, se incorpora el riesgo de que algunos documentos de {{site.data.keyword.cloudant_short_notm}} tengan atributos que no se detecten y por lo tanto se omitan de la estructura de la base de datos del depósito.

Si se establece un valor demasiado alto, significa que el proceso de escaneo para determinar la estructura de la base de datos del depósito tarda demasiado en ejecutarse.

### Después del nuevo escaneo

Cuando finaliza el nuevo escaneo de la base de datos de {{site.data.keyword.cloudant_short_notm}}, el depósito no se inicia automáticamente.
Permanece detenido para que la base de datos del depósito se pueda personalizar.

## Personalización del esquema del depósito

Se puede modificar el esquema de la base de datos que se determina automáticamente durante el proceso inicial de creación del depósito o después de un nuevo escaneo.
Para ello, asegúrese de marcar la opción `Personalizar esquema` durante el proceso de creación:

![Instantánea del panel de creación del depósito que muestra la opción 'Personalizar esquema' habilitada'.](../images/customizeSchema01.png)

El depósito se crea en {{site.data.keyword.dashdbshort_notm}} de la forma habitual, pero no se inicia inmediatamente.
Así tiene la oportunidad de personalizar el esquema antes de continuar.

Para hacerlo, pulse el enlace correspondiente al depósito:

![Instantánea del botón `Abrir en {{site.data.keyword.dashdbshort_notm}}`.](../images/openInDashDB.png)

En la pantalla resultante hay un botón para personalizar el esquema utilizado para la base de datos de origen.
Si mueve puntero sobre el indicador de estado, se confirmará que el esquema está listo para la personalización:

![Instantánea del botón `Personalizar <source database name>`.](../images/customizeSchema02.png)

Si pulsa el botón 'Personalizar', aparecerá un panel en el que puede modificar los cambios del esquema de la base de datos:

![Instantánea del panel Personalizar esquema.](../images/customizeSchema03.png)

Para restablecer el esquema predeterminado, pulse el botón `Volver a escanear`:

![Instantánea del botón `Volver a escanear`.](../images/customizeSchema04.png)

Cuando esté satisfecho con el esquema de la base de datos correspondiente al depósito, pulse el botón `Ejecutar`:

![Instantánea del botón `Ejecutar`.](../images/customizeSchema05.png)

El esquema se guarda y el depósito se inicia.

### Personalización de un esquema de depósito existente

Si el esquema de la base de datos correspondiente al depósito ya existe, tiene la [opción de personalizarlo](#keeping-the-data-and-structure-fresh).

## Resolución de problemas

De tanto en tanto, es posible que detecte algún problema al utilizar el recurso de depósito.
En este apartado encontrará información sobre algunos de estos problemas.

Además dispone de información sobre errores o problemas comunes, así como detalles sobre cómo solucionarlos, en [Stack Overflow ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](http://stackoverflow.com/questions/tagged/cloudant+dashdb){:new_window}.

Si necesita más ayuda y no encuentra la solución en
Stack Overflow,
póngase en contacto con el [equipo de soporte de {{site.data.keyword.cloudant_short_notm}}![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](mailto:support@cloudant.com){:new_window}.

### Excepciones visibles en el panel de control

En ocasiones el depósito detecta una condición de error.
Por ejemplo, si intenta crear un depósito utilizando una base de datos {{site.data.keyword.Db2_on_Cloud_short}} existente, pero no especifica los detalles correctos de la base de datos, el depósito no se podrá crear correctamente.

Cuando se detecta una condición de error, el estado del depósito pasa a mostrar un círculo rojo, lo que indica que existe un problema que requiere su atención:

![Instantánea de un indicador de estado de error.](../images/errorIndicator1.png)

Si 'mueve el puntero del ratón' sobre el indicador, se ofrece un poco más de información:

![Instantánea que muestra el resumen del estado de error al colocar encima el puntero del ratón.](../images/errorIndicator2.png)

Si pulsa en el indicador, aparece una ventana con más detalles sobre el problema.
En este ejemplo, los detalles del host especificados para la conexión de {{site.data.keyword.Db2_on_Cloud_short}} no eran válidos:

![Instantánea que muestra el resumen del estado de error al colocar encima el puntero del ratón.](../images/errorIndicator3.png)

### Avisos y errores

Los cambios en la base de datos de {{site.data.keyword.cloudant_short_notm}} se replican en el depósito de datos.
Es posible que un cambio no encaje en el depósito o en su esquema.
Los problemas de este tipo se detectan y se registran en la tabla `OVERFLOW` de la base de datos del depósito.

Por ejemplo, si el esquema del depósito tiene un campo `Movie_earnings_rank` de tipo `VARCHAR`
que puede contener un máximo de 32 caracteres, pero un cambio en la base de datos
de {{site.data.keyword.cloudant_short_notm}} requiere que se almacenen 40 caracteres, el campo 'se desborda'.
Esto podría producir una condición de 'aviso', que se indica en el icono de estado del panel de control del depósito:

![Instantánea que muestra un mensaje de aviso en el icono de estado.](../images/overflowWarning.png)

Si examina la tabla de desbordamiento indicada en la base de datos del depósito, verá más detalles sobre el aviso:

![Instantánea que muestra detalles del mensaje de aviso en la tabla de desbordamiento (Overflow) de la base de datos del depósito.](../images/overflowWarningDetail.png)

En este ejemplo, el aviso indica claramente que se ha producido un truncamiento que afecta al campo `Movie_earnings_rank` del documento de {{site.data.keyword.cloudant_short_notm}} con el `_ID` `70f6284d2a395396dbb3a60b4cf1cac2`.

Existen dos posibles soluciones:

-   Corregir el campo que se ha desbordado dentro del documento de {{site.data.keyword.cloudant_short_notm}}.
-   [Actualizar el esquema del depósito](#customizing-the-warehouse-schema).

La opción que elija dependerá de si el contenido adicional del campo es intencionado o no.
Si necesita el contenido adicional para su aplicación, entonces es necesario [actualizar el esquema del depósito](#customizing-the-warehouse-schema) para eliminar la condición de aviso.

Se produce un problema más grave si se incorpora un campo totalmente nuevo en un documento en la base de datos de {{site.data.keyword.cloudant_short_notm}}, pero el campo no tiene un equivalente en el esquema de la base de datos del depósito.
Esto genera una condición de 'error'.

Por ejemplo, supongamos que una base de datos de {{site.data.keyword.cloudant_short_notm}} 'gana' un campo adicional llamado `my key` que no existe en el esquema de la base de datos del depósito:

![Instantánea que muestra el campo adicional 'my key' en un documento.](../images/extraField.png)

El resultado es una condición de error, que se indica en el icono de estado del panel de control del depósito:

![Instantánea que muestra un mensaje de error en el icono de estado.](../images/overflowError.png)

Si examina la tabla de desbordamiento indicada en la base de datos del depósito, verá más detalles sobre el error:

![Instantánea que muestra detalles del mensaje de error en la tabla de desbordamiento (Overflow) de la base de datos del depósito.](../images/overflowErrorDetail.png)

En este ejemplo, el error deja claro que se ha encontrado un campo que no estaba cuando se creó el esquema de la base de datos del depósito.
El campo propiamente dicho se ha detectado en el documento de {{site.data.keyword.cloudant_short_notm}} con el `_ID` `70f6284d2a395396dbb3a60b4cf1cac2`.

Existen dos posibles soluciones:

-   Eliminar el campo adicional del documento {{site.data.keyword.cloudant_short_notm}}.
-   [Actualizar el esquema del depósito](#customizing-the-warehouse-schema).

La opción que elija dependerá de si el campo adicional es intencionado o no.
Si necesita el campo adicional para su aplicación, entonces es necesario [actualizar el esquema del depósito](#customizing-the-warehouse-schema) para eliminar la condición de error.
