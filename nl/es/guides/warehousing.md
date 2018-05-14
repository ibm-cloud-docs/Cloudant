---

copyright:
  years: 2015, 2017
lastupdated: "2017-01-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

# Depósitos de datos

Una base de datos resulta esencial para almacenar datos. Pero lo que la convierte en valiosa es el hecho de poder aplicar dichos datos a fines comerciales: poder recuperar los datos relevantes, de manera rápida y fácil, y ponerlos a trabajar con las aplicaciones.
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
Cloudant con un depósito de datos relacional, como en los siguientes ejemplos. 

## Unión de datos

La unión de datos procedentes de varios almacenes de datos para el análisis entre dominios es una tarea que se puede realizar de manera fácil y eficiente mediante un depósito de datos relacional. 

Los datos procedentes de diversas fuentes se preparan y se transforman a un formato común durante la carga de un depósito de datos.
Los registros se almacenan en tablas y existen operaciones para unir estas tablas para permitir su análisis combinado. 

Realizar la unión en un depósito de datos relacional resulta especialmente útil si algunos de los datos ya están disponibles en representación relacional, por ejemplo datos maestros o datos de consulta. 

## Flexibilidad

Las bases de datos de Cloudant son flexibles a la hora de representar los datos. Por ejemplo, no imponen ningún esquema durante la lectura o escritura. 

Por el contrario, se necesita un modelo bien definido y que se imponga rigurosamente para las tareas de notificación y análisis. 

Con los documentos disponibles en un depósito relacional puede basar su modelo en conjunto fijo de definiciones de tablas.
Solo los documentos que se ajustan al esquema de tabla se pueden cargar y los infractores se rechazan. Puede entrenar sus modelos con datos coherentes utilizando un esquema relacional fijo. 

## Certificación de la integridad de los datos

Los depósitos de datos pueden utilizar restricciones para certificar la integridad de los datos.
Por ejemplo: 

-   Dos registros no pueden tener la misma clave primaria. 
-   Las claves foráneas garantizan que los registros están completos. 
-   Existen funciones para validar los registros frente a las reglas de la empresa. 

Exclusividad, corrección y completitud son requisitos esenciales para cualquier servicio de empresa.
El hecho de cargar los documentos de Cloudant en un depósito de datos le ayuda a cumplir con estos requisitos. 

## Cloudant y los depósitos de datos

Los depósitos de datos constituyen una tecnología importante y madura. Cloudant proporciona una estrecha integración con depósitos de datos relacionales, ofreciéndose así las ventajas de esta tecnología.

IBM Cloudant tiene una función básica de depósito integrada, en forma de [vistas de MapReduce](../api/using_views.html),
que le permite realizar varias tareas básicas de análisis. 

Para tareas de depósito más avanzadas, puede aprovechar las características que ofrece el servicio de
depósito basado en la nube de
IBM [IBM dashDB ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](http://www-01.ibm.com/software/data/dashdb/){:new_window}.

Si utiliza IBM Cloudant,
tiene acceso fácil e integrado a funciones avanzadas de depósito como las siguientes: 

-   Consulta de los datos JSON en formato de base de datos relacional. 
-   Realización de consultas basadas en SQL sobre sus datos. 
-   Generación de análisis a partir de sus datos. 

Estas características avanzadas de depósito se habilitan mediante servicios como IBM dashDB,
que constituye un complemento natural de Cloudant.

Como alternativa, si solo necesita un almacén de datos relacionales para sus documentos, sin funciones de depósito, puede cargar los documentos de Cloudant en el servicio [IBM DB2 on Cloud](#ibm-db2-on-cloud). 

## IBM dashDB

IBM dashDB es un servicio de depósito de datos basado en la nube, específicamente pensado para el trabajo de análisis. Aunque resulta especialmente adecuado para datos JSON de Cloudant, dashDB puede aceptar datos procedentes de diversas fuentes examinando la estructura de los datos cuando se cargan.

Para obtener más información, consulte la [documentación de IBM dashDB Cloud Data Warehouse ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/support/knowledgecenter/SS6NHC/com.ibm.swg.im.dashdb.kc.doc/welcome.html){:new_window}.

## IBM DB2 on Cloud

[IBM DB2 on Cloud ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://console.ng.bluemix.net/catalog/services/ibm-db2-on-cloud){:new_window}
le ofrece una base de datos en una infraestructura de nube global SoftLayer® de IBM.
Le ofrece todas las potentes características del despliegue de DB2 local, sin el coste, la complejidad ni el riesgo de tener que gestionar su propia infraestructura. 

Para obtener más información, consulte la [documentación de IBM DB2 on Cloud![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://console.ng.bluemix.net/docs/services/DB2OnCloud/index.html#DB2OnCloud){:new_window}.

## Creación de un depósito

Hay dos maneras de crear un depósito:

1.  [Utilizar Cloudant para crear un depósito dashDB](#use-cloudant-to-create-a-dashdb-warehouse)
2.  [Conectar Cloudant a un depósito existente](#connect-cloudant-to-an-existing-warehouse)

### Utilizar Cloudant para crear un depósito dashDB

El método más sencillo de crear un depósito consiste en que Cloudant cree una instancia del depósito dashDB en Bluemix en su nombre. Para ello pulse el botón `Crear depósito` en la tarea `Depósito` en el separador `Integraciones` del panel de control de Cloudant. 

![Instantánea de la tarea "Crear un depósito dashDB" del panel de control de Cloudant](../images/createDashDBWH.png)

Si aún no ha iniciado una sesión en Bluemix, se le solicitará que lo haga.

>   **Nota**: De forma predeterminada, 
    Cloudant crea una instancia de dashDB en Bluemix para su depósito.
![Instantánea de la tarea "Autenticarse en Bluemix" del panel de control de Cloudant](../images/authenticateToBluemix.png)

Cuando se haya autenticado, puede solicitar que se cree una nueva instancia de dashDB utilizando su cuenta de Bluemix. Para ello: 

1.  Especifique el nombre que desea utilizar para el depósito en el campo `Nombre de depósito`.
2.  Especifique el nombre de su base de datos existente en Cloudant, en el campo `Orígenes de datos`. 
3.  Asegúrese de que la opción `Crear nueva instancia de dashDB` esté seleccionada en el formulario.
4.  Pulse el botón `Crear depósito`. 

![Instantánea de la tarea "Crear depósito" en el panel de control de Cloudant](../images/createWarehouse.png)

### Conectar Cloudant a un depósito existente

En lugar de utilizar Cloudant para crear la base de datos de depósito de dashDB, puede conectar con una instancia
existente de dashDB. 

El proceso es parecido al de [utilizar Cloudant para crear un depósito dashDB](#use-cloudant-to-create-a-dashdb-warehouse), pero en lugar de seleccionar la opción `Crear nueva instancia de dashDB`, debe seleccionar `Instancia de servicio de dashDB` y elegir el depósito de dashDB que ya existe en Bluemix.

![Instantánea de la tarea "Conectar con una instancia de dashDB existente" en el panel de control de Cloudant](../images/existingDashDBInstance.png)

### Utilización de una instancia de depósito de DB2

Si lo prefiere, puede conectarse con una instancia de depósito de DB2 existente en lugar de con dashDB. Para ello seleccione la opción `DB2` en el panel de control de Cloudant para conectar con una instancia existente de DB2. 

![Instantánea de la tarea Crear un depósito de DB2" en el panel de control de Cloudant](../images/createDB2WH.png)

Si desea conectar con una instancia de DB2, debe proporcionar los siguientes detalles:

-   Dirección de host.
-   Número de puerto. 
-   Nombre de la base de datos
-   ID de usuario para la base de datos.
-   Contraseña para el ID de usuario.

>   **Nota**: En el resto de este tema nos referiremos a dashDB como la instancia del depósito. 
    Sin embargo, el tema se aplica igualmente si utiliza una instancia de DB2. Dispone de una guía de aprendizaje en la que se describe cómo [cargar datos JSON desde Cloudant en dashDB ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://developer.ibm.com/clouddataservices../dashdb/get/load-json-from-cloudant-database-in-to-dashdb/){:new_window} que incluye ejemplos de utilización de DB2 como base de datos de depósito.

## Esquema del depósito

La primera vez que cree un depósito desde dentro de Cloudant, dashDB crea el mejor esquema posible para los datos de la base de datos, lo que ayuda a garantizar que cada uno de los campos de los documentos JSON tiene una entrada correspondiente en el nuevo esquema. Si lo desea, al crear el depósito puede optar por [personalizar el esquema](#customizing-the-warehouse-schema) manualmente. 

Una vez creado el esquema, el depósito puede contener los datos en formato relacional. Luego Cloudant [crea una réplica](../api/replication.html) para realizar la
'carga inicial' de los documentos de la base de datos en el depósito, ofreciéndole una colección de trabajo de
sus datos en la base de datos relacional de dashDB. 

Con el tiempo, el contenido de la base de datos
de Cloudant puede cambiar.
Puede modificar el esquema de un depósito existente. 

>   **Nota**: Si modifica el esquema de un depósito existente,
se debe realizar una réplica de los datos de la base de datos de Cloudant en la base de datos de depósito. La modificación del esquema genera una nueva 'carga inicial' en el depósito.

## Cómo trabajar con el depósito

Con el sistema de depósito de Cloudant, puede ejecutar consultas SQL 'tradicionales' y ver los resultados, todo desde dentro
de la consola de
dashDB. 

![Instantánea del "Panel de control de dashDB" de Bluemix](../images/useDashDBdashboard.png)

Las aplicaciones externas pueden interactuar con los datos de la misma manera que con cualquier otra base de datos relacional.

La ventaja de dashDB es que puede realizar otras tareas de depósito, como cargar más datos procedentes otras fuentes, y analizar los datos utilizando las herramientas analíticas incorporadas. DashDB da soporte al [lenguaje de programación `'R'`![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://en.wikipedia.org/wiki/R_%28programming_language%29){:new_window} y al entorno de software para cálculos estadísticos y gráficos. Esto significa que tiene acceso a los algoritmos que le permiten realizar tareas de análisis de base de datos, como la regresión lineal, el clúster 'k-means' y análisis geoespaciales. 

La herramienta `RStudio` le permite crear scripts `'R'` que se cargan en dashDB y se ejecutan utilizando sus datos.

Para obtener más información sobre cómo trabajar con dashDB, consulte la [documentación de IBM dashDB Cloud Data Warehouse![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/support/knowledgecenter/SS6NHC/com.ibm.swg.im.dashdb.kc.doc/welcome.html){:new_window}.

## Mantenimiento de los datos y la infraestructura actualizados

Los datos se cargan de Cloudant en dashDB utilizando un proceso de [réplica](../api/replication.html). Esto significa que si los datos de Cloudant se actualizan o se modifican de alguna manera, la réplica de los documentos en dashDB debe realizarse de nuevo para garantizar que las tareas analíticas siguen trabajando utilizando la información más actualizada.

Al igual que sucede con la réplica normal de Cloudant, los datos se transfieren solo en una dirección: para un
depósito la transferencia se realiza
desde Cloudant a dashDB.
Tras la carga inicial de los datos, el depósito se suscribe a los cambios en el contenido de los datos en la base de datos de Cloudant. Se realiza una réplica de los cambios del origen de Cloudant en el destino de dashDB. Esto significa que el depósito es una forma de réplica continua de Cloudant en dashDB.

Con el tiempo, la base de datos
de Cloudant puede sufrir cambios estructurales.
Esto puede incluir la adición o eliminación de campos de los documentos JSON. Cuando esto sucede, el esquema que utiliza el depósito puede dejar de ser válido, lo que da lugar a que se notifiquen errores cuando se realiza una réplica de datos actualizados de Cloudant en dashDB. 

Para solucionar este problema, el depósito de Cloudant tiene un recurso de 'nuevo escaneo'. Este recurso vuelve a escanear la estructura de la base de datos de Cloudant y determina el nuevo esquema que se necesita en dashDB.
Las tablas antiguas de dashDB creadas durante el escaneo anterior se eliminan, se crean tablas nuevas utilizando el nuevo esquema y finalmente los datos de Cloudant actuales se cargan como una nueva 'carga inicial'.

Para utilizar el recurso de nuevo escaneo, asegúrese primero de que el depósito no se esté ejecutando.
Para ello siga estos pasos: 

1.  Seleccione el separador `Integraciones` del panel de control de Cloudant.
2.  Busque el nombre del depósito que desea volver a escanear en la tarea `Depósito`:<br/>![Instantánea del separador "depósito" del panel de control de Cloudant](../images/selectWarehouse.png)
3.  Pulse el nombre del depósito. Es un enlace, y, cuando se pulsa, se abre la vista detallada del depósito: <br/>![Instantánea de la vista detallada del depósito en el panel de control de Cloudant](../images/viewWarehouseDetail.png)
4.  Compruebe el estado actual del depósito. Un círculo verde rotatorio indica que el depósito se está ejecutando. Para detener el depósito, pulse el icono `Detener base de datos` de la columna Acciones:<br/>![Instantánea del icono "detener base de datos del depósito" del panel de control de Cloudant](../images/stopWarehouseDatabase.png)
5.  Cuando la base de datos de depósito no se está ejecutando, se habilita el icono `Volver a escanear` en la columna Acción: <br/>![Instantánea del icono volver a escanear del panel de control de Cloudant](../images/rescanIcon.png)

### Nuevo escaneo de la base de datos de origen

![Instantánea de la ventana que le permite volver a escanear la base de datos de origen del depósito.](../images/rescanSource.png)

Cuando pulsa el icono `Volver a escanear`, tiene dos opciones: 

-   Un escaneo directo de la base de datos. Esta es la acción predeterminada, y es muy similar al escaneo inicial de la base de datos realizado  al crear el depósito. 
-   Personalizar el esquema del depósito. 

Si elige la acción predeterminada de un nuevo escaneo simple, se inspecciona la base de datos de origen y se genera un nuevo esquema de la base de datos del depósito. En cuanto finaliza el nuevo escaneo, se inicia el depósito. 

Si desea personalizar el esquema del depósito, habilite el recuadro de selección `Personalizar esquema` antes de pulsar el botón `Volver a escanear`.

![Instantánea del panel 'Volver a escanear origen', que muestra la opción 'Personalizar esquema' habilitada.](../images/rescanSource2.png)

El recuadro de selección `Personalizar esquema` habilita dos opciones.

1.  El algoritmo de descubrimiento utilizado.
2.  El tamaño de la muestra. 

### El algoritmo de descubrimiento

La opción predeterminada para volver a escanear es el algoritmo `Unión`. Este algoritmo utiliza todos los atributos de todos los documentos de la base de datos de Cloudant muestreados para crear un único conjunto de tablas en la base de datos del depósito. El resultado es que todos los documentos de la base de datos de Cloudant se pueden almacenar en la base de datos del almacén, pero es posible que algunas filas de la base de datos no tengan contenido en algunos de los campos. 

La opción alternativa para volver a escanear es el algoritmo `Cluster`. Este algoritmo identifica los documentos de la base de datos de Cloudant que tienen el mismo conjunto de atributos y, a continuación, crea los correspondientes esquemas de la tabla de la base de datos del depósito. 

### El tamaño de la muestra

Esta opción determina el número de documentos de la base de datos de Cloudant que se inspeccionan como parte de la determinación del esquema.

El valor predeterminado es 10.000 documentos.

Si se define un valor demasiado bajo, se incorpora el riesgo de que algunos documentos de Cloudant tengan atributos que no se detecten y por lo tanto se omitan de la estructura de la base de datos del depósito. 

Si se establece un valor demasiado alto, significa que el proceso de escaneo para determinar la estructura de la base de datos del depósito tarda demasiado en ejecutarse. 

### Después del nuevo escaneo

Cuando finaliza el nuevo escaneo de la base de datos de Cloudant, el depósito no se inicia automáticamente.
Permanece detenido para que la base de datos del depósito se pueda personalizar. 

## Personalización del esquema del depósito

Se puede modificar el esquema de la base de datos que se determina automáticamente durante el proceso inicial de creación del depósito o después de un nuevo escaneo. Para ello, asegúrese de marcar la opción `Personalizar esquema` durante el proceso de creación:

![Instantánea del panel de creación del depósito que muestra la opción 'Personalizar esquema' habilitada'.](../images/customizeSchema01.png)

El depósito se crea en dashDB de la forma habitual, pero no se inicia inmediatamente.
Así tiene la oportunidad de personalizar el esquema antes de continuar. 

Para hacerlo, pulse el enlace correspondiente al depósito: 

![Instantánea del botón `Abrir en dashDB`.](../images/openInDashDB.png)

En la pantalla resultante hay un botón para personalizar el esquema utilizado para la base de datos de origen.
Si mueve puntero sobre el indicador de estado, se confirmará que el esquema está listo para la personalización: 

![Instantánea del botón `Personalizar <source database name>`.](../images/customizeSchema02.png)

Si pulsa el botón 'Personalizar', aparecerá un panel en el que puede modificar los cambios del esquema de la base de datos: 

![Instantánea del panel Personalizar esquema.](../images/customizeSchema03.png)

Para restablecer el esquema predeterminado, pulse el botón `Volver a escanear`:

![Instantánea del botón `Volver a escanear`.](../images/customizeSchema04.png)

Cuando esté satisfecho con el esquema de la base de datos correspondiente al depósito, simplemente pulse el botón `Ejecutar`: 

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
póngase en contacto con el [equipo de soporte de Cloudant ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](mailto:support@cloudant.com){:new_window}.

### Excepciones visibles en el panel de control

En ocasiones el depósito detecta una condición de error. Por ejemplo, si intenta crear un depósito utilizando una base de datos DB2 existente, pero no especifica los detalles correctos de la base de datos, el depósito no se puede crear correctamente. 

Cuando se detecta una condición de error, el estado del depósito pasa a mostrar un círculo rojo, lo que indica que existe un problema que requiere su atención: 

![Instantánea de un indicador de estado de error.](../images/errorIndicator1.png)

Si 'mueve el puntero del ratón' sobre el indicador, se ofrece un poco más de información: 

![Instantánea que muestra el resumen del estado de error al colocar encima el puntero del ratón.](../images/errorIndicator2.png)

Si pulsa en el indicador, aparece una ventana con más detalles sobre el problema.
En este ejemplo, los detalles del host especificados para la conexión de DB2 no eran válidos:

![Instantánea que muestra el resumen del estado de error al colocar encima el puntero del ratón.](../images/errorIndicator3.png)

### Avisos y errores

Los cambios en la base de datos de Cloudant se replican en el depósito de datos. Es posible que un cambio no encaje en el depósito o en su esquema. Los problemas de este tipo se detectan y se registran en la tabla `OVERFLOW` de la base de datos del depósito. 

Por ejemplo, si el esquema del depósito tiene un campo `Movie_earnings_rank` de tipo `VARCHAR`
que puede contener un máximo de 32 caracteres, pero un cambio en la base de datos
de Cloudant requiere que se almacenan 40 caracteres, el campo 'se desborda'.
Esto podría producir una condición de 'aviso', que se indica en el icono de estado del panel de control del depósito: 

![Instantánea que muestra un mensaje de aviso en el icono de estado.](../images/overflowWarning.png)

Si examina la tabla de desbordamiento indicada en la base de datos del depósito, verá más detalles sobre el aviso: 

![Instantánea que muestra detalles del mensaje de aviso en la tabla de desbordamiento (Overflow) de la base de datos del depósito.](../images/overflowWarningDetail.png)

En este ejemplo, el aviso indica claramente que se ha producido un truncamiento que afecta al campo `Movie_earnings_rank` del documento de Cloudant con el `_ID` `70f6284d2a395396dbb3a60b4cf1cac2`.

Existen dos posibles soluciones: 

-   Corregir el campo que se ha desbordado dentro del documento de Cloudant. 
-   [Actualizar el esquema del depósito](#customizing-the-warehouse-schema).

La opción que elija dependerá de si el contenido adicional del campo es intencionado o no. Si necesita el contenido adicional para su aplicación, entonces es necesario [actualizar el esquema del depósito](#customizing-the-warehouse-schema) para eliminar la condición de aviso.

Se produce un problema más grave si se incorpora un campo totalmente nuevo en un documento en la base de datos de Cloudant, pero el campo no tiene un campo correspondiente en el esquema de la base de datos del depósito. Esto genera una condición de 'error'. 

Por ejemplo, supongamos que una base de datos de Cloudant 'gana' un campo adicional llamado `my key` que no existe en el esquema de la base de datos del depósito: 

![Instantánea que muestra el campo adicional 'my key' en un documento.](../images/extraField.png)

El resultado es una condición de error, que se indica en el icono de estado del panel de control del depósito: 

![Instantánea que muestra un mensaje de error en el icono de estado.](../images/overflowError.png)

Si examina la tabla de desbordamiento indicada en la base de datos del depósito, verá más detalles sobre el error: 

![Instantánea que muestra detalles del mensaje de error en la tabla de desbordamiento (Overflow) de la base de datos del depósito.](../images/overflowErrorDetail.png)

En este ejemplo, el error deja claro que se ha encontrado un campo que no estaba cuando se creó el esquema de la base de datos del depósito. El campo propiamente dicho se ha detectado en el documento de Cloudant con el `_ID` `70f6284d2a395396dbb3a60b4cf1cac2`.

Existen dos posibles soluciones: 

-   Eliminar el campo adicional del documento de Cloudant.
-   [Actualizar el esquema del depósito](#customizing-the-warehouse-schema).

La opción que elija dependerá de si el campo adicional es intencionado o no. Si necesita el campo adicional para su aplicación, entonces es necesario [actualizar el esquema del depósito](#customizing-the-warehouse-schema) para eliminar la condición de error. 
