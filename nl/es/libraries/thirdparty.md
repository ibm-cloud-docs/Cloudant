---

copyright:
  years: 2015, 2019
lastupdated: "2019-04-02"

keywords: client, mobile, c#, .net, libraries, frameworks, examples, tutorials, php, javascript, ruby, meteor, apache spark, 

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

# Bibliotecas de cliente de otros proveedores
{: #third-party-client-libraries}

{{site.data.keyword.cloudantfull}} no realiza el mantenimiento ni da soporte a las bibliotecas de cliente de otros proveedores.
{: shortdesc}

## C# / .NET
{: #c-net}

[MyCouch ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/danielwertheim/mycouch){: new_window}
es un cliente CouchDB y {{site.data.keyword.cloudant_short_notm}} asíncrono para .Net.

Para instalar la biblioteca, abra la consola del gestor de paquetes e invoque lo siguiente:

```
install-package mycouch.cloudant
```
{: codeblock}

### Bibliotecas e infraestructuras para C# / .NET
{: #libraries-and-frameworks-for-c-net}

-   [MyCouch ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/danielwertheim/mycouch){: new_window}.
-   [LoveSeat ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/soitgoes/LoveSeat){: new_window}.
-   [Divan ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/foretagsplatsen/Divan){: new_window}.
-   [Relax ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/arobson/Relax){: new_window}.
-   [Hammock ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](http://code.google.com/p/relax-net/){: new_window}.
-   [EasyCouchDB ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/hhariri/EasyCouchDB){: new_window}.
-   `WDK.API.CouchDB` de [Kanapes IDE ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](http://kanapeside.com/){: new_window}.

### Ejemplos y guías de aprendizaje para C# / .NET
{: #examples-and-tutorials-for-c-net}

-   [CRUD ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/cloudant/haengematte/tree/master/c%23){: new_window}.

## Java
{: #java}

### Bibliotecas no soportadas para Java
{: #unsupported-for-libraries-for-java}

-   [ektorp ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://helun.github.io/Ektorp/reference_documentation.html){: new_window}.
-   [jcouchdb ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](http://code.google.com/p/jcouchdb/){: new_window}.
-   [jrelax ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/isterin/jrelax){: new_window}.
-   [LightCouch ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](http://www.lightcouch.org/){: new_window}.

## JavaScript
{: #javascript}

### Bibliotecas e infraestructuras para JavaScript
{: #libraries-and-frameworks-for-javascript}

-   [Backbone.cloudant ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/cloudant-labs/backbone.cloudant){: new_window}.
    Consulte la [publicación del blog ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://cloudant.com/blog/backbone-and-cloudant/){: new_window} para obtener más información.
-   [sag.js ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/sbisbee/sag-js){: new_window}.

### Ejemplos y guías de aprendizaje para JavaScript
{: #examples-and-tutorials-for-javascript}

-   [CRUD ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/cloudant/haengematte/tree/master/javascript-jquery){: new_window} con jQuery.
-   [CSVtoCloudant ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/michellephung/CSVtoCloudant){: new_window} -
    Interfaz de usuario para importar archivos `.csv` en {{site.data.keyword.cloudant_short_notm}}.
    También se puede acceder a la app desde [aquí ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://michellephung.github.io/CSVtoCloudant/){: new_window}.
-   [csv2couchdb ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/Mango-information-systems/csv2couchdb){: new_window} -
    Interfaz de usuario de Mango Systems para importar archivos `.csv` en CouchDB/{{site.data.keyword.cloudant_short_notm}}.
-   [songblog ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/millayr/songblog){: new_window} - app de ejemplo que utiliza JQuery.
    
## PouchDB (JavaScript)
{: #pouchdb}

[PouchDB ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](http://pouchdb.com/){: new_window} es una base de datos JavaScript que se puede sincronizar con {{site.data.keyword.cloudant_short_notm}},
lo que significa que puede preparar sus apps para que funcionen fuera de línea mediante PouchDB.
Para obtener más información, consulte [la publicación de nuestro blog ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://cloudant.com/blog/pouchdb){: new_window} sobre PouchDB.

Para obtener PouchDB y ver detalles sobre su configuración, consulte [PouchDB ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](http://pouchdb.com/){: new_window}.

PouchDB también está disponible para Node.js: `npm install pouchdb`.
{: note}

PouchDB también se puede instalar con Bower: `bower install pouchdb`.
{: note}

### Bibliotecas e infraestructuras para PouchDB
{: #libraries-and-frameworks-for-pouchdb}

-   [PouchDB ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](http://pouchdb.com/){: new_window} - Base de datos JavaScript para navegador, con sincronización fuera de línea.

### Ejemplos y guías de aprendizaje para PouchDB
{: #examples-and-tutorials-for-pouchdb}

-   [Guía de iniciación de PouchDB ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](http://pouchdb.com/getting-started.html){: new_window} -
    aplicación de tareas pendientes de ejemplo que realiza una sincronización entre el navegador y {{site.data.keyword.cloudant_short_notm}} o CouchDB.
-   [locationtracker ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/rajrsingh/locationtracker){: new_window} -
    app de ejemplo para registrar y correlacionar ubicaciones mediante PouchDB,
CouchApp y {{site.data.keyword.cloudant_short_notm}}.

## Node.js
{: #node-js}

### Bibliotecas e infraestructuras no soportadas para node.js
{: #unsupported-libraries-and-frameworks-for-node-js-thirdparty}

-   [sag-js ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/sbisbee/sag-js){: new_window}, que también funciona en el navegador.
    Consulte [saggingcouch ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/sbisbee/saggingcouch.com){: new_window} para ver más información.
-   [nano ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/dscape/nano){: new_window} es una implementación minimalista.
-   [restler ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/danwrong/restler){: new_window} ofrece el mejor rendimiento, pero es muy básico.
-   [cradle ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/flatiron/cradle){: new_window} es un cliente de alto nivel que también se puede utilizar si se busca por encima de todo facilidad de uso a costa de un menor rendimiento.
-   [cane_passport ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/ddemichele/cane_passport){: new_window} - {{site.data.keyword.cloudant_short_notm}} Angular Node Express con Bootstrap.
-   [express-cloudant ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/cloudant-labs/express-cloudant){: new_window} - una plantilla para la infraestructura de Node.js Express que también utiliza PouchDB y Grunt.

## PHP
{: #php}

[Sag ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/sbisbee/sag){: new_window} es el cliente CouchBD y {{site.data.keyword.cloudant_short_notm}} de PHP.
[Sag.js ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/sbisbee/sag-js){: new_window} es el equivalente JavaScript de Sag.

Para instalarlo, descargue `sag` de [https://github.com/sbisbee/sag ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/sbisbee/sag){: new_window} y luego incluya la biblioteca en la aplicación:

```
require_once('./src/Sag.php');
```
{: codeblock}

### Bibliotecas e infraestructuras para PHP
{: #libraries-and-frameworks-for-php}

-   [sag ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/sbisbee/sag){: new_window}.
-   [Doctrine CouchDB Client ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/doctrine/couchdb-client){: new_window}.
-   [PHP-on-Couch ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/dready92/PHP-on-Couch){: new_window}.

### Ejemplos y guías de aprendizaje para PHP
{: #examples-and-tutorials-for-php}

-   [CRUD ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/cloudant/haengematte/tree/master/php){: new_window}.

## Python
{: #python}

### Bibliotecas e infraestructuras no soportadas para Python
{: #unsupported-libraries-and-frameworks-for-python}

-   [requests ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](http://docs.python-requests.org/en/master/){: new_window}.

## Ruby
{: #ruby}

[CouchRest ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/couchrest/couchrest){: new_window} es un cliente de CouchDB y {{site.data.keyword.cloudant_short_notm}} con extensiones para trabajar con Rails mediante el [modelo CouchRest ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/couchrest/couchrest_model){: new_window}.

Para instalar CouchRest, ejecute el siguiente mandato:

```sh
gem install couchrest
```
{: codeblock}

### Bibliotecas e infraestructuras para Ruby
{: #libraries-and-frameworks-for-ruby}

Encontrará muchos clientes CouchDB en
[Ruby Toolbox ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://www.ruby-toolbox.com/categories/couchdb_clients){: new_window}.

### Ejemplos y guías de aprendizaje para Ruby
{: #examples-and-tutorials-for-ruby}

-   [CRUD ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/cloudant/haengematte/tree/master/ruby){: new_window}.

## Meteor
{: #meteor}

[cloudant:couchdb ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://atmospherejs.com/cloudant/couchdb){: new_window} es la biblioteca de {{site.data.keyword.cloudant_short_notm}} para el paquete `couchdb-meteor`.
Puesto que Apache CouchDB no se incluye con Meteor ni con el paquete CouchDB, debe proporcionar un URL para que Meteor se pueda conectar y una instancia de servidor
CouchDB o {{site.data.keyword.cloudant_short_notm}} en ejecución antes de instalar Meteor.
Añada este paquete a su aplicación Meteor:

```sh
meteor add cloudant:couchdb
```
{: codeblock}

El paquete couchdb-meteor ofrece lo siguiente:

-   Implementación de Livequery y actualizaciones en tiempo real de la base de datos mediante el consumo del canal de información CouchDB `_changes`.
-   Puntos finales RPC DDP (Distributed Data Protocol) que actualizan datos de los clientes conectados de forma local.
-   Serialización y deserialización de las actualizaciones en el formato DDP.

La sintaxis de consultas JSON utilizada por {{site.data.keyword.cloudant_short_notm}} Query, y desarrollada inicialmente por {{site.data.keyword.cloudant_short_notm}}, se pasó de nuevo a Apache CouchDB para la versión 2.0. Los archivos binarios preconfigurados para Apache CouchDB versión 2.0 todavía no están disponibles. Puede utilizar este módulo con {{site.data.keyword.cloudant_short_notm}} DBaaS o Cloudant Local hasta que los archivos binarios preconfigurados estén disponibles.
{: note}

Para configurar la información de conexión del servidor Apache CouchDB o {{site.data.keyword.cloudant_short_notm}}, pase su URL como variable de entorno `COUCHDB_URL` al proceso de servidor Meteor:

```sh
$ export COUCHDB_URL=https://username:password@username.cloudant.com
```
{: codeblock}

Para obtener más información sobre las API meteor-couchdb, consulte la [Referencia de API](/docs/services/Cloudant/api/index.html#api-reference-overview). 
