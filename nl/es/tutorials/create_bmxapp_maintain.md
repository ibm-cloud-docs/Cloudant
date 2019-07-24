---

copyright:
  years: 2017, 2019
lastupdated: "2019-06-12"

keywords: maintenance tasks, find application status, start application, stop application, upload application, diagnose problems, resolve problems, application log

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

<!-- Acrolinx: 2017-01-11 -->

# Creación de una aplicación sencilla de {{site.data.keyword.cloud_notm}} para acceder a una base de datos de {{site.data.keyword.cloudant_short_notm}}: mantenimiento y resolución de problemas
{: #creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-maintaining-and-troubleshooting}

En esta guía de aprendizaje se muestra cómo mantener una aplicación de {{site.data.keyword.cloud}}, alojada en una instancia de servicio de {{site.data.keyword.cloud_notm}}.
{: shortdesc}

## Tareas básicas de mantenimiento de la aplicación
{: #performing-basic-application-maintenance-tasks}

En esta sección de la guía de aprendizaje se explica cómo renovar, iniciar y detener las aplicaciones Python en {{site.data.keyword.cloud_notm}}.

### Cómo encontrar el estado de la aplicación
{: #finding-the-status-of-your-application}

El estado de aplicaciones dentro de la instancia de servicio de {{site.data.keyword.cloud_notm}} se muestra en el panel de control.

En el ejemplo siguiente, la aplicación `Cloudant CF app` no se está ejecutando y tiene el estado `Detenido`:

![Captura de pantalla que muestra el panel de control de la aplicación en estado 'detenido'](images/img0037.png)

### Inicio de la aplicación
{: #starting-your-application}

Si intenta iniciar la aplicación de guía de aprendizaje sin suprimir primero la base de datos de demostración de la guía de aprendizaje, la aplicación no funcionará correctamente. La aplicación entra en un ciclo en el que intenta iniciarse, pero no puede porque la base de datos existe, se detiene y luego intenta iniciarse de nuevo. Para resolver el problema, [detenga la aplicación](#stopping-your-application) y, a continuación, suprima la base de datos de demostración de la guía de aprendizaje. Luego podrá iniciar correctamente la aplicación.
{: note}
    
Para iniciar una aplicación detenida, pulse la opción `Iniciar` en el menú: <br/>
![Captura de pantalla que muestra la opción 'Start'](images/img0039.png)

### Detención de la aplicación
{: #stopping-your-application}

Para detener una aplicación en ejecución, pulse la opción `Detener` en el menú:<br/>
![Captura de pantalla que muestra la opción 'Detener'](images/img0041.png)

### Carga de una nueva versión de la aplicación
{: #uploading-a-fresh-version-of-your-application}

Para cargar una nueva versión de la aplicación, simplemente siga el [proceso de carga](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-uploading-the-application#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-uploading-the-application).
La nueva versión sobrescribe la versión anterior de la aplicación.

Si ya se está ejecutando la versión anterior de la aplicación cuando inicia la carga, {{site.data.keyword.cloud_notm}} detiene automáticamente la aplicación primero.
{: tip}

## Diagnóstico y resolución de problemas
{: #diagnosing-and-resolving-problems}

Esta sección de la guía de aprendizaje se proporcionan algunas sugerencias de resolución de problemas básicos para ayudarle a identificar, diagnosticar y resolver algunos problemas que puede encontrar cuando desarrollo y despliegue sus primeras aplicaciones de {{site.data.keyword.cloud_notm}}.

Encontrará una buena fuente de asesoramiento sobre prácticas recomendadas para crear aplicaciones de
{{site.data.keyword.cloud_notm}} o de Cloud Foundry en
[Consideraciones para el
diseño y ejecución de una app en la nube ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://docs.cloudfoundry.org/devguide/deploy-apps/prepare-to-deploy.html){: new_window}.

En concreto, se recomienda [evitar escribir en el sistema de archivos local ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://docs.cloudfoundry.org/devguide/deploy-apps/prepare-to-deploy.html#filesystem){: new_window}.

Para simplificar, esta guía de aprendizaje escribe contenido al sistema de archivos local. Sin embargo, la cantidad de material es pequeña. No se espera que se conserve y no constituye 'información básica'.
{: tip}

### Utilización del registro de aplicación
{: #using-the-application-log}

El recurso más útil para diagnosticar y resolver problemas con la aplicación de {{site.data.keyword.cloud_notm}} es el archivo de registro.

Encontrará el archivo de registro de una aplicación de {{site.data.keyword.cloud_notm}} pulsando el separador `Registro` para abrir la página de información de registro:<br/>
![Captura de pantalla que muestra el enlace para acceder a lapágina de información 'Registros'](images/img0042.png)


Al igual que la mayoría de los archivos de registro, un registro de aplicación de {{site.data.keyword.cloud_notm}} contiene detalles sobre los sucesos que se han producido y cuándo se han producido.

El registro también identifica los componentes implicados en el suceso registrado.
En la tabla siguiente se identifican los componentes clave:

Etiqueta de componente | Componente
----------------|----------
`API`           | El sistema Cloud Foundry.
`APP`           | Su aplicación.
`CELL`          | El contenedor que alberga la aplicación dentro de {{site.data.keyword.cloud_notm}}.
`RTR`           | Los componentes de red que transfieren mensajes a la aplicación o desde la misma.

Por ejemplo, la siguiente captura de pantalla incluye una serie de sucesos típicos: <br/>
![Captura de pantalla que muestra la información indicativa del registro](images/img0043.png)

Observe los sucesos a las horas siguientes:

-   A la 1:56:56 PM, la aplicación se ha iniciado correctamente.
-   A la 1:58:43 PM, la red ha recibido una solicitud HTTP sencilla, a `GET /`.
-   Momentos después, la aplicación ha recibido la solicitud HTTP y ha respondido.
-   A las 2:13:46 PM, se ha recibido la solicitud de detener la aplicación.
-   A las 2:13:48 PM, la aplicación ha completado el proceso de detención.

La aplicación que se describe en esta guía de aprendizaje es deliberadamente mínima.
Por ejemplo, no se intenta determinar si la base de datos de destino existe y, si existe, no se intenta impedir que se vuelva a crear.
Como consecuencia, si intenta ejecutar la aplicación de la guía de aprendizaje más de una vez sin eliminar antes la base de datos, la aplicación falla y se reinicia repetidamente.

Puede ver este efecto en la siguiente captura de pantalla: <br/>
![Captura de pantalla que muestra la información de error en el registro](images/img0044.png)

A las 2:31:23 PM,
la aplicación ha detectado un problema:<br/>
`"La base de datos {0} ya existe".format(dbname)`

Los mensajes siguientes son los que puede esperar de cualquier aplicación Python que encuentra un problema.

De hecho, el registro muestra el componente que ha detectado el problema y ofrece tantos detalles como puede.
Debe aplicar los procedimientos normales de resolución de problemas de la aplicación para solucionar el problema.

## Fin de la guía de aprendizaje
{: #end-of-tutorial}

Ha finalizado la guía de aprendizaje.
