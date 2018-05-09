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

<!-- Acrolinx: 2017-01-10 -->

# Creación de una aplicación sencilla de {{site.data.keyword.Bluemix_notm}} para acceder a una base de datos de {{site.data.keyword.cloudant_short_notm}}

En esta guía de aprendizaje se muestra cómo crear una aplicación de {{site.data.keyword.Bluemix}} que utiliza el [lenguaje de programación Python![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://www.python.org/){:new_window} para acceder a una base de datos {{site.data.keyword.cloudantfull}} alojada en la instancia de servicio de {{site.data.keyword.Bluemix_notm}}.
{:shortdesc}

## Contexto

Una ventaja significativa de {{site.data.keyword.Bluemix_notm}} es que puede crear y desplegar aplicaciones dentro del propio {{site.data.keyword.Bluemix_notm}}.
No tiene que buscar y mantener un servidor para ejecutar sus aplicaciones.

Si ya utiliza una instancia de base de datos de {{site.data.keyword.cloudant_short_notm}} dentro de {{site.data.keyword.Bluemix_notm}}, tiene sentido tener aquí también las aplicaciones.

Las aplicaciones de {{site.data.keyword.Bluemix_notm}} suelen crearse mediante la tecnología [Cloud Foundry ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://en.wikipedia.org/wiki/Cloud_Foundry){:new_window}.
Cloud Foundry ofrece la característica Platform-as-a-Service (PaaS), que simplifica el proceso de crear aplicaciones que se pueden desplegar y ejecutar dentro de un entorno de nube.

[En otra guía de aprendizaje](create_database.html) ha aprendido a crear una aplicación Python autónoma que utiliza una instancia de base de datos de {{site.data.keyword.cloudant_short_notm}}
dentro de {{site.data.keyword.Bluemix_notm}}.
En esta guía, configurará y creará una pequeña aplicación Python alojado en {{site.data.keyword.Bluemix_notm}}.
La aplicación se conecta a la instancia de base de datos de {{site.data.keyword.cloudant_short_notm}} y un documento simple.

En esta guía de aprendizaje se proporciona código de Python específico de cada tarea.
[Aquí](create_bmxapp_createapp.html#complete-listing) encontrará un programa Python completo, suficiente para demostrar los conceptos.

En esta guía de aprendizaje no se pretende crear código Python _eficiente_; el objetivo es mostrar un código sencillo y fácil de comprender que funcione, con el que pueda aprender y que pueda aplicar a sus propias aplicaciones.

Tampoco se pretende realizar todas las comprobaciones posibles ni analizar todas las condiciones de error.
Aquí se incluyen algunas comprobaciones de ejemplo para ilustrar las técnicas, pero debe aplicar las prácticas recomendadas habituales para comprobar y manejar todas las condiciones de aviso y de error que encuentren sus propias aplicaciones.

## Visión general de las tareas

Para crear una aplicación Python que funcione en {{site.data.keyword.Bluemix_notm}} y que pueda acceder a una instancia de base de datos de {{site.data.keyword.cloudant_short_notm}}. debe realizar las tareas siguientes:

-   [Crear un entorno de aplicación de Python en {{site.data.keyword.Bluemix_notm}}.](create_bmxapp_appenv.html#creating)
-   [Asegurarse de que el entorno de aplicación de Python tenga una 'conexión' con una instancia de base de datos de {{site.data.keyword.cloudant_short_notm}}. ](create_bmxapp_appenv.html#connecting)
-   [(Tarea única) Descargar e instalar los kits de herramientas de línea de mandatos de Cloud Foundry y {{site.data.keyword.Bluemix_notm}}](create_bmxapp_appenv.html#toolkits)
-   [Descargar la aplicación 'de inicio'.](create_bmxapp_appenv.html#starter)
-   [Personalizar la aplicación de inicio para crear su propia aplicación para acceder a la instancia de base de datos de {{site.data.keyword.cloudant_short_notm}}. ](create_bmxapp_createapp.html#theApp)
-   [Cargar la aplicación y probar que funciona.](create_bmxapp_upload.html#uploading)
-   [Realizar tareas básicas de mantenimiento de la aplicación.](create_bmxapp_maintain.html#maintenance)
-   [Diagnosticar y resolver problemas (resolución de problemas).](create_bmxapp_maintain.html#troubleshooting)

## Estructura de la guía de aprendizaje

La guía de aprendizaje consta de cinco secciones:

1.  [Requisitos previos](create_bmxapp_prereq.html)
2.  [El entorno de aplicación](create_bmxapp_appenv.html)
3.  [Creación de su aplicación](create_bmxapp_createapp.html)
4.  [Carga y ejecución de su aplicación](create_bmxapp_upload.html)
5.  [Mantenimiento y resolución de problemas de la aplicación](create_bmxapp_maintain.html)

## El paso siguiente

Para empezar a utilizar la guía de aprendizaje, comience por [comprobar los requisitos previos](create_bmxapp_prereq.html).
