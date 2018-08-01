---

copyright:
  years: 2015, 2018
lastupdated: "2018-06-08"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:tip: .tip}

<!-- Acrolinx: 2017-03-06 -->

# Bibliotecas de cliente admitidas

## Móvil

La biblioteca {{site.data.keyword.cloudantfull}} Sync se utiliza para almacenar, indexar y consultar datos JSON locales en un dispositivo móvil.
También se utiliza para sincronizar los datos entre muchos dispositivos.
La sincronización se controla a través de la aplicación.
La biblioteca también ofrece métodos de ayuda para encontrar y resolver conflictos, tanto en el dispositivo local como en la base de datos remota.

Hay dos versiones disponibles:

-   [{{site.data.keyword.cloudant_short_notm}} Sync - Android / JavaSE ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/cloudant/sync-android){:new_window}.
-   [{{site.data.keyword.cloudant_short_notm}} Sync - iOS (CDTDatastore) ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/cloudant/CDTDatastore){:new_window}.

Dispone de una [visión general ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://cloudant.com/product/cloudant-features/sync/){:new_window} de {{site.data.keyword.cloudant_short_notm}} Sync.
También encontrará detalles de los [recursos ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://cloudant.com/cloudant-sync-resources/){:new_window} de {{site.data.keyword.cloudant_short_notm}} Sync.

## Java

[java-cloudant ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/cloudant/java-cloudant){:new_window} es la biblioteca oficial de {{site.data.keyword.cloudantfull}} para Java.

Encontrará información sobre cómo instalar la biblioteca añadiendo una dependencia a los builds de Maven o Gradle [aquí ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/cloudant/java-cloudant#installation-and-usage){:new_window},
junto con detalles y ejemplos sobre cómo utilizar la biblioteca.

### Bibliotecas e infraestructuras para Java

#### Biblioteca soportada para Java

-   [java-cloudant ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/cloudant/java-cloudant){:new_window}.

#### Bibliotecas no soportadas para Java

-   [ektorp ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://helun.github.io/Ektorp/reference_documentation.html){:new_window}.
-   [jcouchdb ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](http://code.google.com/p/jcouchdb/){:new_window}.
-   [jrelax ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/isterin/jrelax){:new_window}.
-   [LightCouch ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](http://www.lightcouch.org/){:new_window}.
-   [Contenedor modelo de Java Cloudant Web Starter ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://ace.ng.bluemix.net/#/store/cloudOEPaneId=store&appTemplateGuid=CloudantJavaBPTemplate&fromCatalog=true){:new_window} para {{site.data.keyword.cloud}}.

### Ejemplos y guías de aprendizaje para Java

-   [Crear, leer, actualizar y suprimir ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/cloudant/haengematte/tree/master/java){:new_window} con bibliotecas HTTP y JSON.
-   [Crear, leer, actualizar y suprimir ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/cloudant/haengematte/tree/master/java/CrudWithEktorp){:new_window} con bibliotecas ektorp.
-   [Crear apps con Java mediante {{site.data.keyword.cloudant_short_notm}} en {{site.data.keyword.cloud}}![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://cloudant.com/blog/building-apps-using-java-with-cloudant-on-ibm-bluemix/){:new_window}.
-   [Ejemplo de cómo crear una app de juegos con Liberty, {{site.data.keyword.cloudant_short_notm}} y Single Sign On ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](http://www.ibm.com/developerworks/cloud/library/cl-multiservicegame-app/index.html?ca=drs-){:new_window} {{site.data.keyword.cloud_notm}}.
-   [Ejemplo de cómo crear una app Java EE en {{site.data.keyword.cloud_notm}} mediante Watson y {{site.data.keyword.cloudant_short_notm}} ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://developer.ibm.com/bluemix/2014/10/17/building-java-ee-app-ibm-bluemix-using-watson-cloudant/){:new_window} {{site.data.keyword.cloud_notm}} con un [vídeo en YouTube ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://www.youtube.com/watch?feature=youtu.be&v=9AFMY6m0LIU&app=desktop){:new_window}.


## Node.js

[nodejs-cloudant ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/cloudant/nodejs-cloudant){:new_window} es la biblioteca oficial de {{site.data.keyword.cloudant_short_notm}} para Node.js.
Puede instalarla con npm:

```sh
npm install cloudant
```
{:codeblock}

### Bibliotecas e infraestructuras para node.js

#### Biblioteca soportada para node.js

-   [nodejs-cloudant ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/cloudant/nodejs-cloudant){:new_window} ([npm ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://www.npmjs.org/package/cloudant){:new_window}).

#### Bibliotecas e infraestructuras no soportadas para node.js

-   [sag-js ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/sbisbee/sag-js){:new_window}, que también funciona en el navegador.
    Consulte [saggingcouch ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/sbisbee/saggingcouch.com){:new_window} para ver más información.
-   [nano ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/dscape/nano){:new_window} es una implementación minimalista.
-   [restler ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/danwrong/restler){:new_window} ofrece el mejor rendimiento, pero es muy básico.
-   [cradle ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/flatiron/cradle){:new_window} es un cliente de alto nivel que también se puede utilizar si se busca por encima de todo facilidad de uso a costa de un menor rendimiento.
-   [cane_passport ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/ddemichele/cane_passport){:new_window} - {{site.data.keyword.cloudant_short_notm}} Angular Node Express con Bootstrap.
-   [express-cloudant ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/cloudant-labs/express-cloudant){:new_window} - una plantilla para la infraestructura de Node.js Express que también utiliza PouchDB y Grunt.
-   [Node.js {{site.data.keyword.cloudant_short_notm}} DB Web Starter ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://ace.ng.bluemix.net/#/store/cloudOEPaneId=store&appTemplateGuid=nodejscloudantbp&fromCatalog=true){:new_window} - contenedor modelo para {{site.data.keyword.cloud_notm}}.
-   [Mobile Cloud ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://ace.ng.bluemix.net/#/store/cloudOEPaneId=store&appTemplateGuid=mobileBackendStarter&fromCatalog=true){:new_window} - contenedor modelo para {{site.data.keyword.cloud_notm}} (Node.js, Security, Push y Mobile Data/{{site.data.keyword.cloudant_short_notm}}).

### Ejemplos y guías de aprendizaje para node.js

-   [Crear, leer, actualizar y suprimir ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/cloudant/haengematte/tree/master/nodejs){:new_window}.
-   [Cloudant-Uploader ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/garbados/Cloudant-Uploader){:new_window} - programa de utilidad para cargar archivos `.csv` en {{site.data.keyword.cloudant_short_notm}}.
-   [couchimport ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/glynnbird/couchimport){:new_window} - programa de utilidad para importar archivos `.csv` o `.tsv` en CouchDB o {{site.data.keyword.cloudant_short_notm}}.
-   [Iniciación a {{site.data.keyword.cloud_notm}} y Node.js ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](http://thoughtsoncloud.com/2014/07/getting-started-ibm-bluemix-node-js/){:new_window}.
-   [Combinación de la nube con {{site.data.keyword.cloud_notm}}, {{site.data.keyword.cloudant_short_notm}} y Node.js ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://gigadom.wordpress.com/2014/08/15/a-cloud-medley-with-ibm-bluemix-cloudant-db-and-node-js/){:new_window}.
-   [Crear una app de juegos de palabras sencilla con {{site.data.keyword.cloudant_short_notm}} en {{site.data.keyword.cloud_notm}} ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](http://www.ibm.com/developerworks/cloud/library/cl-guesstheword-app/index.html?ca=drs-){:new_window} - utiliza Node.js.
-   [Crear una app de votos por SMS en tiempo real ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://www.twilio.com/blog/2012/09/building-a-real-time-sms-voting-app-part-1-node-js-couchdb.html){:new_window} - serie de seis partes que utiliza Node.js, Twilio y {{site.data.keyword.cloudant_short_notm}}.
-   [Crear una aplicación Windows Azure Web de varios niveles ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://www.ampower.me/article/CouchDB/Tutorial-Building-a-Multi-Tier-Windows-Azure-Web-application-use-Cloudants-Couchdb-as-a-Service-node-94-409665?eqs=Z2NWNlltTmlUWStWcHdEWENWc3UxdmowREpiMjlGUVpKajJOZGJpSlVkemlPS2oxa0YxZE5BPT0=){:new_window} - utiliza {{site.data.keyword.cloudant_short_notm}}, Node.js, CORS y Grunt.
-   [Hágalo usted mismo: Crear una aplicación de supervisión remota mediante {{site.data.keyword.cloud_notm}}, {{site.data.keyword.cloudant_short_notm}} y Raspberry Pi. ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](http://www.ibm.com/developerworks/library/ba-remoteservpi-app/index.html){:new_window}.

## Python

Dispone de una biblioteca admitida para trabajar con {{site.data.keyword.cloudant_short_notm}} utilizando Python [aquí ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/cloudant/python-cloudant){:new_window}.

>   **Nota:** Las aplicaciones Python que acceden a {{site.data.keyword.cloudant_short_notm}} tienen dependencias de componentes. Estas dependencias se deben especificar en un archivo `requirements.txt`. Para obtener más información vaya [aquí ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://pip.readthedocs.io/en/1.1/requirements.html){:new_window}.

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

La biblioteca corresponde a un release inicial.
Por lo tanto, actualmente no ofrece cobertura completa para las API de {{site.data.keyword.cloudant_short_notm}}. 

>   **Nota**: SwiftCloudant no recibe soporte en iOS y no se puede llamar desde Objective-C.
