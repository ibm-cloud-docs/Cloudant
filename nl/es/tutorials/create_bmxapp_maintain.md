---

copyright:
  years: 2017, 2018
lastupdated: "2017-11-07"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-01-11 -->

# Creación de una aplicación sencilla de {{site.data.keyword.Bluemix_notm}} para acceder a la base de datos de {{site.data.keyword.cloudant_short_notm}}: mantenimiento y resolución de problemas

En esta guía de aprendizaje se muestra cómo mantener una aplicación de {{site.data.keyword.Bluemix}}, alojada en una instancia de servicio de {{site.data.keyword.Bluemix_notm}}.
{:shortdesc}

<div id="maintenance"></div>

## Tareas básicas de mantenimiento de la aplicación

En esta sección de la guía de aprendizaje se explica cómo renovar, iniciar y detener las aplicaciones Python en {{site.data.keyword.Bluemix_notm}}.

### Cómo encontrar el estado de la aplicación

El estado de aplicaciones dentro de la instancia de servicio de {{site.data.keyword.Bluemix_notm}} se muestra en el panel de control.

En el ejemplo siguiente, la aplicación `Cloudant Python` no se está ejecutando y tiene el estado `Detenido`:<br/>
![Captura de pantalla que muestra el panel de control de la aplicación en estado 'detenido'](images/img0037.png)

### Inicio de la aplicación

>   **Nota**: Si intenta iniciar la aplicación de la guía de aprendizaje
    sin suprimir antes la base de datos de demostración de la guía de aprendizaje, la aplicación no funcionará correctamente.
    La aplicación entra en un ciclo en el que intenta iniciarse, pero no puede porque la base de datos existe, se detiene y luego intenta iniciarse de nuevo.
    Para resolver el problema, [detenga la aplicación](#stopping-your-application) y, a continuación, suprima la base de datos de demostración de la guía de aprendizaje.
    Luego podrá iniciar correctamente la aplicación.

Para iniciar una aplicación detenida, primero pulse el icono del menú de la aplicación en el panel de control:<br/>
![Captura de pantalla que muestra el panel de control con el icono de gestión de aplicaciones](images/img0038.png)

A continuación, pulse la opción `Iniciar app` en el menú:<br/>
![Captura de pantalla que muestra la opción 'Iniciar app'](images/img0039.png)

### Detención de la aplicación

Para detener una aplicación en ejecución, primero pulse el icono del menú de la aplicación en el panel de control:<br/>
![Captura de pantalla que muestra el panel de control con el icono de gestión de aplicaciones](images/img0040.png)

A continuación, pulse la opción `Detener app` en el menú:<br/>
![Captura de pantalla que muestra la opción 'Detener app'](images/img0041.png)

<div id="troubleshooting"></div>

### Carga de una nueva versión de la aplicación

Para cargar una nueva versión de la aplicación, simplemente siga el [proceso de carga](create_bmxapp_upload.html).
La nueva versión sobrescribe la versión anterior de la aplicación.

>   **Nota**: Si la versión anterior de la aplicación ya se está ejecutando cuando se inicia la carga,
    {{site.data.keyword.Bluemix_notm}} detiene primero automáticamente la primera.

## Diagnóstico y resolución de problemas

Esta sección de la guía de aprendizaje se proporcionan algunas sugerencias de resolución de problemas básicos para ayudarle a identificar, diagnosticar y resolver algunos problemas que puede encontrar cuando desarrollo y despliegue sus primeras aplicaciones de {{site.data.keyword.Bluemix_notm}}.

Encontrará una buena fuente de asesoramiento sobre prácticas recomendadas para crear aplicaciones de Cloud Foundry o de {{site.data.keyword.Bluemix_notm}} [aquí ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://docs.cloudfoundry.org/devguide/deploy-apps/prepare-to-deploy.html){:new_window}.

En concreto, se recomienda [evitar escribir en el sistema de archivos local ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://docs.cloudfoundry.org/devguide/deploy-apps/prepare-to-deploy.html#filesystem){:new_window}.

>   **Nota**: Para simplificar,
    en esta guía de aprendizaje no se escribe contenido en el sistema de archivos local.
    Sin embargo, la cantidad de material es pequeña.
    No se espera que se conserve y no constituye 'información básica'.

### Utilización del registro de aplicación

El recurso más útil para diagnosticar y resolver problemas con la aplicación de {{site.data.keyword.Bluemix_notm}} es el archivo de registro.

Encontrará el archivo de registro correspondiente a una aplicación de {{site.data.keyword.Bluemix_notm}} en la página de información de `Registros`:<br/>
![Captura de pantalla que muestra el enlace para acceder a la página de información de 'Registros'](images/img0042.png)

Al igual que la mayoría de los archivos de registro, un registro de aplicación de {{site.data.keyword.Bluemix_notm}} contiene detalles sobre los sucesos que se han producido y cuándo se han producido.

El registro también identifica los componentes implicados en el suceso registrado.
En la tabla siguiente se identifican los componentes clave:

Etiqueta de componente | Componente
----------------|----------
`API`           | El sistema Cloud Foundry.
`APP`           | Su aplicación.
`CELL`          | El contenedor que alberga la aplicación dentro de {{site.data.keyword.Bluemix_notm}}.
`RTR`           | Los componentes de red que transfieren mensajes a la aplicación o desde la misma.

Por ejemplo, la siguiente captura de pantalla incluye una serie de sucesos típicos:<br/>
![Captura de pantalla que muestra información indicativa de registro](images/img0043.png)

Observe los sucesos a las horas siguientes:

-   A la 1:56:56 PM, la aplicación se ha iniciado correctamente.
-   A la 1:58:43 PM, la red ha recibido una solicitud HTTP sencilla, a `GET /`.
-   Momentos después, la aplicación ha recibido la solicitud HTTP y ha respondido.
-   A las 2:13:46 PM, se ha recibido la solicitud de detener la aplicación.
-   A las 2:13:48 PM, la aplicación ha completado el proceso de detención.

La aplicación que se describe en esta guía de aprendizaje es deliberadamente mínima.
Por ejemplo, no se intenta determinar si la base de datos de destino existe y, si existe, no se intenta impedir que se vuelva a crear.
Como consecuencia, si intenta ejecutar la aplicación de la guía de aprendizaje más de una vez sin eliminar antes la base de datos, la aplicación falla y se reinicia repetidamente.

Puede ver este efecto en la siguiente captura de pantalla:<br/>
![Captura de pantalla que muestra información de error del registro](images/img0044.png)

A las 2:31:23 PM,
la aplicación ha detectado un problema:<br/>
`"La base de datos {0} ya existe".format(dbname)`

Los mensajes siguientes son los que puede esperar de cualquier aplicación Python que encuentra un problema.

De hecho, el registro muestra el componente que ha detectado el problema y ofrece tantos detalles como puede.
Debe aplicar los procedimientos normales de resolución de problemas de la aplicación para solucionar el problema.

## Fin de la guía de aprendizaje

Ha finalizado la guía de aprendizaje.
