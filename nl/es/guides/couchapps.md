---

copyright:
  years: 2015, 2019
lastupdated: "2019-06-12"

keywords: couchapp, 3-tier application

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

<!-- Acrolinx: 2018-05-07 -->

# CouchApps
{: #couchapps}

{{site.data.keyword.cloudantfull}} puede contener datos de archivos sin formato,
como imágenes,
y servirlos sobre HTTP,
lo que implica que puede contener todos los archivos estáticos necesarios para ejecutar un sitio web y albergarlos como un servidor web.
{: shortdesc}

Puesto que estos archivos están alojados en {{site.data.keyword.cloudant_short_notm}}, el JavaScript del cliente podría acceder a las bases de datos de {{site.data.keyword.cloudant_short_notm}}.
Se dice de una aplicación basada en este enfoque que tiene una arquitectura de dos niveles, que consisten en el cliente (generalmente un navegador) y la base de datos.
En la comunidad CouchDB, esto se denomina
CouchApp.

La mayoría de las apps web tienen tres niveles: el cliente, el servidor y la base de datos.
El hecho de colocar el servidor entre el cliente y la base de datos puede resultar de ayuda con la autenticación, autorización, gestión de activos, aprovechamiento de las API web de otros proveedores, suministro de puntos finales especialmente sofisticados, etc. Esta separación permite disponer de un sistema más complejo sin problemas adicionales, en el que el cliente solo debe preocuparse de la presentación de los datos mientras la base de datos se centra en guardar y servir estos datos.

CouchApps destaca por su simplicidad, pero a menudo una app web necesita la potencia de una arquitectura de 3 niveles.
¿Qué sistema resulta adecuado en cada situación?

## CouchApp resulta adecuado si...
{: #a-couchapp-is-appropriate-if-}

-   El servidor solo proporciona una API a {{site.data.keyword.cloudant_short_notm}} de todas formas.
-   La autenticación basada en cookie {{site.data.keyword.cloudant_short_notm}}
    de [](/docs/services/Cloudant?topic=cloudant-authentication#cookie-authentication) le resulta adecuada.
-   Las bases de datos [`_users` y `_security`](/docs/services/Cloudant?topic=cloudant-authorization#using-the-_users-database-with-cloudant-nosql-db)
    de {{site.data.keyword.cloudant_short_notm}} son suficientes para gestionar usuarios y permisos.
-   No tiene que planificar cronjobs ni otras tareas de ejecución regular.

Para empezar a utilizar CouchApps,
lea el apartado sobre [Gestión de aplicaciones en {{site.data.keyword.cloudant_short_notm}} ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://cloudant.com/blog/app-management/){: new_window}.

## Una aplicación de 3 niveles resulta adecuada si...
{: #a-3-tier-application-is-appropriate-if-}

-   Necesita permisos más granulares (mejor estructurados) de lo que permite la base de datos `_security`.
-   Necesita un método de autenticación que no sea Basic auth ni la autenticación por cookies,
como por ejemplo Oauth o un sistema de inicio de sesión de otro proveedor.
-   Tiene que planificar tareas fuera del cliente para que se ejecuten de forma regular.

Puede escribir su capa de servidor mediante las tecnologías que mejor se adapten a su situación.
Hay disponible una lista de bibliotecas para trabajar con {{site.data.keyword.cloudant_short_notm}} en la página
[Aspectos básicos de {{site.data.keyword.cloudant_short_notm}}](/docs/services/Cloudant?topic=cloudant-client-libraries#client-libraries).
