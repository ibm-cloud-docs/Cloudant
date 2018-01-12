---

copyright:
  years: 2015, 2017
lastupdated: "2017-08-25"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-03-06 -->

# Bibliotecas de cliente admitidas

## Móvil

La biblioteca Cloudant Sync se utiliza para almacenar, indexar y consultar datos JSON locales en un dispositivo móvil. También se utiliza para sincronizar los datos entre muchos dispositivos. La sincronización se controla a través de la aplicación. La biblioteca también ofrece métodos de ayuda para encontrar y resolver conflictos, tanto en el dispositivo local como en la base de datos remota. 

Hay dos versiones disponibles: 

-   [Cloudant Sync - Android / JavaSE ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/cloudant/sync-android){:new_window}.
-   [Cloudant Sync - iOS (CDTDatastore) ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/cloudant/CDTDatastore){:new_window}.

Dispone de una [visión general ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://cloudant.com/product/cloudant-features/sync/){:new_window} de Cloudant Sync.
También encontrará detalles de los [recursos ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://cloudant.com/cloudant-sync-resources/){:new_window} de Cloudant Sync. 

## Java

[java-cloudant ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/cloudant/java-cloudant){:new_window} es la biblioteca oficial de {{site.data.keyword.cloudantfull}} para Java.

Encontrará información sobre cómo instalar la biblioteca añadiendo una dependencia a los builds de Maven o Gradle [aquí ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/cloudant/java-cloudant#installation-and-usage){:new_window},
junto con detalles y ejemplos sobre cómo utilizar la biblioteca. 

### Bibliotecas e infraestructuras

#### Admitidas

-   [java-cloudant ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/cloudant/java-cloudant){:new_window}.

#### No admitidas

-   [ektorp ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](http://ektorp.org/){:new_window}.
-   [jcouchdb ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](http://code.google.com/p/jcouchdb/){:new_window}.
-   [jrelax ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/isterin/jrelax){:new_window}.
-   [LightCouch ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](http://www.lightcouch.org/){:new_window}.
-   [Contenedor modelo de Java Cloudant Web Starter ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://ace.ng.bluemix.net/#/store/cloudOEPaneId=store&appTemplateGuid=CloudantJavaBPTemplate&fromCatalog=true){:new_window} para Bluemix.

### Ejemplos y guías de aprendizaje

-   [Crear, leer, actualizar y suprimir ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/cloudant/haengematte/tree/master/java){:new_window} con bibliotecas HTTP y JSON.
-   [Crear, leer, actualizar y suprimir ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/cloudant/haengematte/tree/master/java/CrudWithEktorp){:new_window} con bibliotecas ektorp. 
-   [Crear apps con Java mediante Cloudant en IBM Bluemix ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://cloudant.com/blog/building-apps-using-java-with-cloudant-on-ibm-bluemix/){:new_window}.
-   [Ejemplo de cómo crear una app de juegos con Liberty, Cloudant y Single Sign en ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](http://www.ibm.com/developerworks/cloud/library/cl-multiservicegame-app/index.html?ca=drs-){:new_window} en Bluemix. 
-   [Ejemplo de cómo crear una app Java EE en IBM Bluemix mediante Watson y Cloudant ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://developer.ibm.com/bluemix/2014/10/17/building-java-ee-app-ibm-bluemix-using-watson-cloudant/){:new_window} Bluemix con un [vídeo en YouTube ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://www.youtube.com/watch?feature=youtu.be&v=9AFMY6m0LIU&app=desktop){:new_window}.


## Node.js

[nodejs-cloudant ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/cloudant/nodejs-cloudant){:new_window} es la biblioteca oficial de {{site.data.keyword.cloudant_short_notm}} para Node.js.
Puede instalarla con npm:

```sh
npm install cloudant
```
{:codeblock}

### Bibliotecas e infraestructuras

#### Admitidas

-   [nodejs-cloudant ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/cloudant/nodejs-cloudant){:new_window} ([npm ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://www.npmjs.org/package/cloudant){:new_window}).

#### No admitidas

-   [sag-js ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/sbisbee/sag-js){:new_window}, que también funciona en el navegador. Consulte [saggingcouch ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/sbisbee/saggingcouch.com){:new_window} para ver más información. 
-   [nano ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/dscape/nano){:new_window} es una implementación minimalista. 
-   [restler ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/danwrong/restler){:new_window} ofrece el mejor rendimiento, pero es muy básico. 
-   [cradle ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/flatiron/cradle){:new_window} es un cliente de alto nivel que también se puede utilizar si se busca por encima de todo facilidad de uso a costa de un menor rendimiento. 
-   [cane_passport ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/ddemichele/cane_passport){:new_window} - Cloudant Angular Node Express con Bootstrap.
-   [express-cloudant ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/cloudant-labs/express-cloudant){:new_window} - una plantilla para la infraestructura de Node.js Express que también utiliza PouchDB y Grunt.
-   [Node.js Cloudant DB Web Starter ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://ace.ng.bluemix.net/#/store/cloudOEPaneId=store&appTemplateGuid=nodejscloudantbp&fromCatalog=true){:new_window} - contenedor modelo para Bluemix.
-   [Mobile Cloud ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://ace.ng.bluemix.net/#/store/cloudOEPaneId=store&appTemplateGuid=mobileBackendStarter&fromCatalog=true){:new_window} - contenedor modelo para Bluemix (Node.js, Security, Push y Mobile Data/Cloudant).

### Ejemplos y guías de aprendizaje

-   [Crear, leer, actualizar y suprimir ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/cloudant/haengematte/tree/master/nodejs){:new_window}. 
-   [Cloudant-Uploader ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/garbados/Cloudant-Uploader){:new_window} - programa de utilidad para cargar archivos `.csv` en Cloudant.
-   [couchimport ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/glynnbird/couchimport){:new_window} - programa de utilidad para importar archivos `.csv` o `.tsv` en CouchDB o Cloudant.
-   [Iniciación a IBM Bluemix y Node.js ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](http://thoughtsoncloud.com/2014/07/getting-started-ibm-bluemix-node-js/){:new_window}.
-   [Combinación de la nube con IBM Bluemix, Cloudant DB y Node.js ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://gigadom.wordpress.com/2014/08/15/a-cloud-medley-with-ibm-bluemix-cloudant-db-and-node-js/){:new_window}.
-   [Crear una app de juegos de palabras sencilla con Cloudant en Bluemix ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](http://www.ibm.com/developerworks/cloud/library/cl-guesstheword-app/index.html?ca=drs-){:new_window} - utiliza Node.js.
-   [Crear una app de votos por SMS en tiempo real ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://www.twilio.com/blog/2012/09/building-a-real-time-sms-voting-app-part-1-node-js-couchdb.html){:new_window} - serie de seis partes que utiliza Node.js, Twilio y Cloudant.
-   [Crear una aplicación Windows Azure Web de varios niveles ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](http://msopentech.com/blog/2013/12/19/tutorial-building-multi-tier-windows-azure-web-application-use-cloudants-couchdb-service-node-js-cors-grunt-2/){:new_window} - utiliza Cloudant, Node.js, CORS y Grunt.
-   [Hágalo usted mismo: Crear una aplicación de supervisión remota mediante Bluemix, Cloudant y Raspberry Pi. ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](http://www.ibm.com/developerworks/library/ba-remoteservpi-app/index.html){:new_window}.

## Python

Dispone de una biblioteca admitida para trabajar con {{site.data.keyword.cloudant_short_notm}} utilizando Python [aquí ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/cloudant/python-cloudant){:new_window}.

>   **Nota:** Las aplicaciones Python que acceden a {{site.data.keyword.cloudant_short_notm}} tienen dependencias de componentes. Estas dependencias se deben especificar en un archivo `requirements.txt`. Para obtener más información y un ejemplo, consulte [aquí ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/cloudant/python-cloudant/blob/master/requirements.txt){:new_window}.

Descargue el release actual de la biblioteca [aquí ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://pypi.python.org/pypi/cloudant/){:new_window}.
Encontrará más información sobre el lenguaje Python en [python.org ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://www.python.org/about/){:new_window}. 

## Swift

Dispone de una biblioteca admitida para trabajar con {{site.data.keyword.cloudant_short_notm}}.
La biblioteca se llama SwiftCloudant y se instala mediante `cocoapods`.

La entrada de podfile es la siguiente: 

```sh
pod 'SwiftCloudant'
```
{:codeblock}

Encontrará más información sobre SwiftCloudant,
incluidos detalles de la instalación e información sobre cómo utilizar la biblioteca para almacenar, indexar y consultar datos JSON remotos en {{site.data.keyword.cloudant_short_notm}} [aquí ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/cloudant/swift-cloudant){:new_window}.

La biblioteca corresponde a un release inicial. Por lo tanto, actualmente no ofrece cobertura completa para las API de {{site.data.keyword.cloudant_short_notm}}.  

>   **Nota**: SwiftCloudant no recibe soporte en iOS y no se puede llamar desde Objective-C.
