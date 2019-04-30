---

copyright:
  years: 2017, 2019
lastupdated: "2019-03-19"

keywords: create applications, deploy applications, create simple application

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

# Creación de una aplicación sencilla de {{site.data.keyword.cloud_notm}} para acceder a una base de datos de {{site.data.keyword.cloudant_short_notm}}
{: #creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database}

En esta guía de aprendizaje se muestra cómo crear una aplicación de {{site.data.keyword.cloud}} que utiliza el [lenguaje de programación Python ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://www.python.org/){: new_window} para acceder a una base de datos {{site.data.keyword.cloudantfull}} alojada en la instancia de servicio de {{site.data.keyword.cloud_notm}}.
{: shortdesc}

## Ventajas de {{site.data.keyword.cloud_notm}}
{: #advantages-of-ibm-cloud}

Una ventaja significativa de {{site.data.keyword.cloud}} es que puede crear y desplegar aplicaciones dentro del propio {{site.data.keyword.cloud_notm}}.
No tiene que buscar y mantener un servidor para ejecutar sus aplicaciones.

Si ya utiliza una instancia de base de datos de {{site.data.keyword.cloudant_short_notm}} dentro de {{site.data.keyword.cloud_notm}}, tiene sentido tener aquí también las aplicaciones.

Las aplicaciones de {{site.data.keyword.cloud_notm}} suelen crearse mediante la tecnología [Cloud Foundry ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://en.wikipedia.org/wiki/Cloud_Foundry){: new_window}.
Cloud Foundry ofrece la característica Platform-as-a-Service (PaaS), que simplifica el proceso de crear aplicaciones que se pueden desplegar y ejecutar dentro de un entorno de nube.

[En otra guía de aprendizaje](/docs/services/Cloudant?topic=cloudant-creating-and-populating-a-simple-ibm-cloudant-database-on-ibm-cloud#creating-and-populating-a-simple-ibm-cloudant-database-on-ibm-cloud) ha aprendido a crear una aplicación Python autónoma que utiliza una instancia de base de datos de {{site.data.keyword.cloudant_short_notm}}
dentro de {{site.data.keyword.cloud_notm}}.
En esta guía, configurará y creará una pequeña aplicación Python alojado en {{site.data.keyword.cloud_notm}}.
La aplicación se conecta a la instancia de base de datos de {{site.data.keyword.cloudant_short_notm}} y un documento simple.

En esta guía de aprendizaje se proporciona código de Python específico de cada tarea.
[Aquí](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-code#complete-python-program) encontrará un programa Python completo, suficiente para demostrar los conceptos.

En esta guía de aprendizaje no se pretende crear código Python _eficiente_; el objetivo es mostrar un código sencillo y fácil de comprender que funcione, con el que pueda aprender y que pueda aplicar a sus propias aplicaciones.

Tampoco se pretende realizar todas las comprobaciones posibles ni analizar todas las condiciones de error.
Aquí se incluyen algunas comprobaciones de ejemplo para ilustrar las técnicas, pero debe aplicar las prácticas recomendadas habituales para comprobar y manejar todas las condiciones de aviso y de error que encuentren sus propias aplicaciones.

## Visión general de las tareas
{: #task-overview}

Para crear una aplicación Python que funcione en {{site.data.keyword.cloud_notm}} y que pueda acceder a una instancia de base de datos de {{site.data.keyword.cloudant_short_notm}}, debe realizar las tareas siguientes:

-   [Crear un entorno de aplicación de Python en {{site.data.keyword.cloud_notm}}.](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#creating-an-ibm-cloud-application-environment)
-   [Asegurarse de que el entorno de aplicación de Python tenga una 'conexión' con una instancia de base de datos de {{site.data.keyword.cloudant_short_notm}}.](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#connecting-ibm-cloud-applications-and-services)
-   [(Tarea única) Descargar e instalar los kits de herramientas de línea de mandatos de Cloud Foundry y {{site.data.keyword.cloud_notm}}.](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#the-cloud-foundry-and-ibm-cloud-command-toolkits)
-   [Descargar la aplicación 'de inicio'.](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#the-starter-application)
-   [Personalizar la aplicación de inicio para crear su propia aplicación para acceder a la instancia de base de datos de {{site.data.keyword.cloudant_short_notm}}.](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-code#the-application-code)
-   [Cargar la aplicación y probar que funciona.](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-uploading-the-application#uploading-the-application)
-   [Realizar tareas básicas de mantenimiento de la aplicación.](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-maintaining-and-troubleshooting#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-maintaining-and-troubleshooting)
-   [Diagnosticar y resolver problemas (resolución de problemas).](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-maintaining-and-troubleshooting#diagnosing-and-resolving-problems)

## Estructura de la guía de aprendizaje
{: #tutorial-structure}

La guía de aprendizaje consta de cinco secciones:

1.  [Requisitos previos](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-prerequisites#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-prerequisites)
2.  [El entorno de aplicación](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment)
3.  [Creación de la aplicación](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-code#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-code)
4.  [Carga y ejecución de su aplicación](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-uploading-the-application#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-uploading-the-application)
5.  [Mantenimiento y resolución de problemas de la aplicación](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-maintaining-and-troubleshooting#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-maintaining-and-troubleshooting)

Para empezar a utilizar la guía de aprendizaje, comience por [comprobar los requisitos previos](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-prerequisites#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-prerequisites).
