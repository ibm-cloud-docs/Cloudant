---

copyright:
  years: 2015, 2018
lastupdated: "2018-06-07"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

# Bibliotecas de cliente de otros proveedores

>   **Nota**: {{site.data.keyword.cloudantfull}} no realiza el mantenimiento ni da soporte a las bibliotecas de cliente de otros proveedores.

## Bibliotecas móviles de terceros

Cómo trabajar con una base de datos de {{site.data.keyword.cloudant_short_notm}}:

-   [IBM Worklight Powered Native Objective-C iOS Apps ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](http://www.tricedesigns.com/2014/11/17/ibm-worklight-powered-native-objective-c-ios-apps/){:new_window} con un adaptador de {{site.data.keyword.cloudant_short_notm}}.

## C# / .NET

[MyCouch ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/danielwertheim/mycouch){:new_window}
es un cliente CouchDB y {{site.data.keyword.cloudant_short_notm}} asíncrono para .Net.

Para instalar la biblioteca, abra la consola del gestor de paquetes e invoque lo siguiente:

```
install-package mycouch.cloudant
```
{:codeblock}

### Bibliotecas e infraestructuras para C# / .NET

-   [MyCouch ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/danielwertheim/mycouch){:new_window}.
-   [LoveSeat ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/soitgoes/LoveSeat){:new_window}.
-   [Divan ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/foretagsplatsen/Divan){:new_window}.
-   [Relax ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/arobson/Relax){:new_window}.
-   [Hammock ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](http://code.google.com/p/relax-net/){:new_window}.
-   [EasyCouchDB ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/hhariri/EasyCouchDB){:new_window}.
-   `WDK.API.CouchDB` de [Kanapes IDE ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](http://kanapeside.com/){:new_window}.

### Ejemplos y guías de aprendizaje para C# / .NET

-   [CRUD ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/cloudant/haengematte/tree/master/c%23){:new_window}.

## PHP

[Sag ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/sbisbee/sag){:new_window} es el cliente CouchBD y {{site.data.keyword.cloudant_short_notm}} de PHP.
[Sag.js ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/sbisbee/sag-js){:new_window} es el equivalente JavaScript de Sag.

Para instalarlo, descargue `sag` de [https://github.com/sbisbee/sag ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/sbisbee/sag){:new_window} y luego incluya la biblioteca en la aplicación:

```
require_once('./src/Sag.php');
```
{:codeblock}

### Bibliotecas e infraestructuras para PHP

-   [sag ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/sbisbee/sag){:new_window}.
-   [Doctrine CouchDB Client ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/doctrine/couchdb-client){:new_window}.
-   [PHP-on-Couch ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/dready92/PHP-on-Couch){:new_window}.

### Ejemplos y guías de aprendizaje para PHP

-   [CRUD ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/cloudant/haengematte/tree/master/php){:new_window}.

## JavaScript

[PouchDB ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](http://pouchdb.com/){:new_window} es una base de datos JavaScript que se puede sincronizar con {{site.data.keyword.cloudant_short_notm}},
lo que significa que puede preparar sus apps para que funcionen fuera de línea mediante PouchDB.
Para obtener más información, consulte [la publicación de nuestro blog ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://cloudant.com/blog/pouchdb){:new_window} sobre PouchDB.

Para obtener PouchDB y ver detalles sobre su configuración, consulte [PouchDB ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](http://pouchdb.com/){:new_window}.

>   **Nota**: PouchDB también está disponible para Node.js: `npm install pouchdb`.

>   **Nota**: PouchDB también se puede instalar con Bower: `bower install pouchdb`.

### Bibliotecas e infraestructuras para JavaScript

-   [Backbone.cloudant ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/cloudant-labs/backbone.cloudant){:new_window}.
    Consulte la [publicación del blog ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://cloudant.com/blog/backbone-and-cloudant/){:new_window} para obtener más información.
-   [sag.js ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/sbisbee/sag-js){:new_window}.
-   [PouchDB ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](http://pouchdb.com/){:new_window} - Base de datos JavaScript para navegador, con sincronización fuera de línea.

### Ejemplos y guías de aprendizaje para JavaScript

-   [CRUD ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/cloudant/haengematte/tree/master/javascript-jquery){:new_window} con jQuery.
-   [CSVtoCloudant ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/michellephung/CSVtoCloudant){:new_window} -
    Interfaz de usuario para importar archivos `.csv` en {{site.data.keyword.cloudant_short_notm}}.
    También se puede acceder a la app desde [aquí ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://michellephung.github.io/CSVtoCloudant/){:new_window}.
-   [csv2couchdb ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/Mango-information-systems/csv2couchdb){:new_window} -
    Interfaz de usuario de Mango Systems para importar archivos `.csv` en CouchDB/{{site.data.keyword.cloudant_short_notm}}.
-   [songblog ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/millayr/songblog){:new_window} - app de ejemplo que utiliza JQuery.
-   [Guía de iniciación de PouchDB ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](http://pouchdb.com/getting-started.html){:new_window} -
    aplicación de tareas pendientes de ejemplo que realiza una sincronización entre el navegador y {{site.data.keyword.cloudant_short_notm}} o CouchDB.
-   [locationtracker ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/rajrsingh/locationtracker){:new_window} -
    app de ejemplo para registrar y correlacionar ubicaciones mediante PouchDB,
CouchApp y {{site.data.keyword.cloudant_short_notm}}.

## Ruby

[CouchRest ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/couchrest/couchrest){:new_window} es un cliente de CouchDB y {{site.data.keyword.cloudant_short_notm}} con extensiones para trabajar con Rails mediante el [modelo CouchRest ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/couchrest/couchrest_model){:new_window}.

Para instalar CouchRest, ejecute el siguiente mandato:

```sh
gem install couchrest
```
{:codeblock}

### Bibliotecas e infraestructuras para Ruby

Encontrará muchos clientes CouchDB en
[Ruby Toolbox ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://www.ruby-toolbox.com/categories/couchdb_clients){:new_window}.

### Ejemplos y guías de aprendizaje para Ruby

-   [CRUD ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/cloudant/haengematte/tree/master/ruby){:new_window}.

<div id="couchdb"></div>

## Meteor

[cloudant:couchdb ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://atmospherejs.com/cloudant/couchdb){:new_window} es la biblioteca de {{site.data.keyword.cloudant_short_notm}} para el paquete `couchdb-meteor`.
Puesto que Apache CouchDB no se entrega con Meteor ni con el paquete couchdb, debe proporcionar un URL para que Meteor se pueda conectar y una instancia de servidor
CouchDB o {{site.data.keyword.cloudant_short_notm}} en ejecución antes de instalar Meteor.
Añada este paquete a su aplicación Meteor:

```sh
meteor add cloudant:couchdb
```
{:codeblock}

El paquete couchdb-meteor ofrece lo siguiente:

-   Implementación de Livequery y actualizaciones en tiempo real de la base de datos mediante el consumo del canal de información CouchDB `_changes`.
-   Puntos finales RPC DDP (Distributed Data Protocol) que actualizan datos de los clientes conectados de forma local.
-   Serialización y deserialización de las actualizaciones en el formato DDP.

>   **Nota**La sintaxis de consultas de JSON que utiliza {{site.data.keyword.cloudant_short_notm}} Query,
    y desarrollada inicialmente por {{site.data.keyword.cloudant_short_notm}},
    se pasó de nuevo a Apache CouchDB para la versión 2.0.
    Los archivos binarios preconfigurados para Apache CouchDB versión 2.0 todavía no están disponibles.
    Puede utilizar este módulo con {{site.data.keyword.cloudant_short_notm}} DBaaS o Cloudant Local hasta que los archivos binarios preconfigurados estén disponibles.

Para configurar la información de conexión del servidor Apache CouchDB o {{site.data.keyword.cloudant_short_notm}}, pase su URL como variable de entorno `COUCHDB_URL` al proceso de servidor Meteor:

```sh
$ export COUCHDB_URL=https://username:password@username.cloudant.com
```
{:codeblock}

Consulte [Referencia de API](../api/index.html) para obtener más información sobre las API de meteor-couchdb. 

## Apache Spark

Las extensiones de [Apache Bahir para Apache Spark ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](http://bahir.apache.org/#home){:new_window}
incluyen un conector `spark-sql-cloudant`, que es la biblioteca de {{site.data.keyword.cloudant_short_notm}} para Apache Spark.

El conector spark-sql-cloudant ya está cargado en la oferta
[{{site.data.keyword.cloud_notm}} Apache Spark-as-a-Service ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://console.ng.bluemix.net/catalog/services/apache-spark/){:new_window}.
Se puede utilizar con cualquier clúster autónomo de Spark.

Consulte la [información del proyecto ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/apache/bahir/tree/master/sql-cloudant){:new_window}
y la [documentación Apache Bahir spark-sql-cloudant ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](http://bahir.apache.org/docs/spark/current/spark-sql-cloudant/){:new_window} para obtener más detalles.
