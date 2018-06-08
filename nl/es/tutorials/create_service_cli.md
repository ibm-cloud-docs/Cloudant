---

copyright:
  years: 2017, 2018
lastupdated: "2018-03-07"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

# Creación de una instancia de {{site.data.keyword.cloudant_short_notm}} en {{site.data.keyword.Bluemix_notm}} mediante las herramientas de Cloud Foundry

En esta guía de aprendizaje se muestra cómo crear una instancia de servicio de {{site.data.keyword.cloudantfull}} en {{site.data.keyword.Bluemix}} mediante las herramientas de Cloud Foundry.
{:shortdesc}

## Requisitos previos

Para seguir esta guía de aprendizaje, primero debe instalar las herramientas de {{site.data.keyword.Bluemix_notm}} Cloud Foundry.
Encontrará los detalles para instalar las herramientas en [esta guía de aprendizaje](create_bmxapp_appenv.html#the-cloud-foundry-and-bluemix-command-toolkits).

> **Nota**: Asegúrese de instalar los kits de herramientas de Cloud Foundry _y_  de {{site.data.keyword.Bluemix_notm}}.

## Identificación del punto final de API de {{site.data.keyword.Bluemix_notm}}

Especifique el punto final de API de destino para los mandatos de Cloud Foundry;

```sh
bx api https://api.ng.bluemix.net
```
{:codeblock}

El resultado confirma que ha identificado correctamente el punto final:

```sh
Setting api endpoint to https://api.ng.bluemix.net...
OK

API endpoint: https://api.ng.bluemix.net (API version: 2.54.0)
Not logged in. Use 'bx login' to log in.
```
{:pre}

## Inicio de sesión en su cuenta de {{site.data.keyword.Bluemix_notm}}

1.  Utilice el mandato siguiente para iniciar el proceso de inicio de sesión para su cuenta de {{site.data.keyword.Bluemix_notm}}:
  
  ```sh
  bx login
  ```
  {:codeblock}
  
  {{site.data.keyword.Bluemix_notm}} responde recordándole el punto final de API actual y luego le solicita la dirección de correo electrónico de su cuenta:
  
  ```sh
  API endpoint: https://api.ng.bluemix.net
  
  Email>
  ```
  {:pre}

2.  Especifique la dirección de correo electrónico de su cuenta.
  Luego {{site.data.keyword.Bluemix_notm}} le solicita la contraseña de su cuenta:
  ```sh
  API endpoint: https://api.ng.bluemix.net
  
  Email> J.Doe@email.com
  
  Password>
  ```
  {:pre}
  
  {{site.data.keyword.Bluemix_notm}} valida los detalles y resume la información sobre su sesión de inicio de sesión:
  ```sh
  API endpoint: https://api.ng.bluemix.net
  
  Email> J.Doe@email.com
  
  Password>
  Authenticating...
  OK
  
  Targeted account J DOE's Account (707...a32)
  
  Targeted org J.Doe@email.com
  
  Targeted space dev
  
  API endpoint:   https://api.ng.bluemix.net (API version: 2.54.0)
  Region:         us-south
  User:           j.doe@email.com
  Account:        J DOE's Account (707...a32)
  Org:            J.Doe@email.com
  Space:          dev
  ```
  {:pre}

3.  Ha iniciado una sesión en su cuenta de {{site.data.keyword.Bluemix_notm}}.

## Elección del plan de {{site.data.keyword.cloudant_short_notm}} para su servicio

Obtenga una lista de todas las ofertas de servicio disponibles.
Filtre la lista de modo que solo coincida con los servicios de {{site.data.keyword.cloudant_short_notm}}:

```sh
bx service offerings | grep -i Cloudant
```
{:codeblock}

El resultado es una lista de los servicios de {{site.data.keyword.cloudant_short_notm}} disponibles para su cuenta, incluidos los planes específicos que puede seleccionar:

```sh
cloudantNoSQLDB   Lite, Standard*
```
{:pre}

**Opcional**: Para ver más detalles sobre los planes, utilice el siguiente mandato:

```sh
bx cf marketplace -s cloudantNoSQLDB
```
{:codeblock}

El resultado es un resumen de los planes disponibles, similar al de la respuesta de ejemplo de la siguiente sección (detalles correspondientes a mayo de 2017):

```
Lite
El plan Lite proporciona acceso a todas las funciones de {{site.data.keyword.cloudant_short_notm}} para desarrollo y evaluación.
El plan tiene una cantidad establecida de capacidad de rendimiento suministrada e incluye un máximo de
1 GB de almacenamiento libre de datos cifrados.
```
{:pre}

## Creación del servicio {{site.data.keyword.cloudant_short_notm}}

El formato básico del mandato para crear una instancia de servicio dentro de {{site.data.keyword.Bluemix_notm}} es el siguiente:

```sh
bx service create <service> <plan> <instance name>
```
{:pre}

Supongamos que queremos crear una instancia de un servicio de {{site.data.keyword.cloudant_short_notm}} utilizando el plan `Lite`, donde el nombre de la instancia es `cs20170517a`.

Para ello, utilice un mandato como el del siguiente ejemplo:

```sh
bx service create cloudantNoSQLDB Lite cs20170517a
```
{:codeblock}

Después de crear la instancia de servicio, el sistema responde con un mensaje parecido al siguiente:

```sh
Invoking 'cf create-service cloudantNoSQLDB Lite cs20170517a'...

Creating service instance cs20170517a in org J.Doe@email.com / space dev as J.Doe@email.com...
OK

```
{:pre}

## Creación de credenciales para el servicio de {{site.data.keyword.cloudant_short_notm}}

Las aplicaciones que requieren acceso al servicio de {{site.data.keyword.cloudant_short_notm}} deben tener las credenciales necesarias.

>   **Nota**: Las credenciales de servicio son muy valiosas.
    Si alguna persona o alguna aplicación tiene acceso a las credenciales, puede hacer lo que quiera con la instancia de servicio; por ejemplo, podría crear datos falsos o suprimir información importante.
    Proteja bien estas credenciales.

Las credenciales de servicio constan de cinco campos:

Campo      | Finalidad
-----------|--------
`host`     | El nombre de host que utilizan las aplicaciones para localizar la instancia de servicio.
`username` | El nombre de usuario que necesitan las aplicaciones para acceder a la instancia de servicio.
`password` | La contraseña que necesitan las aplicaciones para acceder a la instancia de servicio.
`port`     | El número de puerto HTTP para acceder a la instancia de servicio en el host. Normalmente es 443 para forzar el acceso HTTPS.
`url`      | Una serie que agrega la otra información de credenciales en un URL único, adecuado para que lo utilicen las aplicaciones.

El formato básico del mandato para crear credenciales para una instancia de servicio dentro de {{site.data.keyword.Bluemix_notm}} es el siguiente:

```sh
bx cf create-service-key <instance name> <credentials name>
```
{:pre}

Supongamos que queremos crear credenciales para la instancia `cs20170517a` de un servicio de {{site.data.keyword.cloudant_short_notm}}, donde el nombre de las credenciales es `creds20170517a`.

Para ello, utilice un mandato como el del siguiente ejemplo:

```sh
bx cf create-service-key cs20170517a creds20170517a
```
{:codeblock}

Después de recibir la solicitud para crear credenciales para la instancia de servicio, {{site.data.keyword.Bluemix_notm}} responde con un mensaje parecido al siguiente:

```sh
Invoking 'cf create-service-key cs20170517a creds20170517a'...

Creating service key creds20170517a for service instance cs20170517a as J.Doe@email.com...
OK
```
{:pre}

## Listado de las credenciales de servicio para el servicio de {{site.data.keyword.cloudant_short_notm}}

El formato básico del mandato para recuperar credenciales para una instancia de servicio dentro de {{site.data.keyword.Bluemix_notm}} es el siguiente:

```sh
bx cf service-key <instance name> <credentials name>
```
{:pre}

Supongamos que queremos recuperar credenciales para la instancia `cs20170517a` de un servicio de {{site.data.keyword.cloudant_short_notm}}, donde el nombre de las credenciales es `creds20170517a`.

Para ello, utilice un mandato como el del siguiente ejemplo:

```sh
bx cf service-key cs20170517a creds20170517a
```
{:codeblock}

Después de recibir la solicitud para recuperar las credenciales para la instancia de servicio, {{site.data.keyword.Bluemix_notm}} responde con un mensaje (abreviado) parecido al siguiente:

```sh
Invoking 'cf service-key cs20170517a creds20170517a'...

Getting key creds20170517a for service instance cs20170517a as J.Doe@email.com...

{
 "host": "946...46f-bluemix.cloudant.com",
 "password": "4eb...eb5",
 "port": 443,
 "url": "https://946...46f-bluemix:4eb...eb5@946...46f-bluemix.cloudant.com",
 "username": "946...46f-bluemix"
}
```
{:pre}

## Utilización de la instancia de servicio de {{site.data.keyword.cloudant_short_notm}}

Hasta el memento, ha hecho lo siguiente:

1.  Ha creado una instancia de servicio de {{site.data.keyword.cloudant_short_notm}}
dentro de {{site.data.keyword.Bluemix_notm}}.
2.  Ha creado credenciales para la instancia de servicio de {{site.data.keyword.cloudant_short_notm}}.
3.  Ha recuperado las credenciales de la instancia de servicio, para que las pueda utilizar la aplicación.

Encontrará una guía de aprendizaje que muestra cómo utilizar una instancia de servicio de {{site.data.keyword.cloudant_short_notm}} [aquí](create_database.html#context).
No olvide sustituir las credenciales que ha creado en esta guía de aprendizaje.

## (Opcional) Ordenación posterior

La siguiente lista de mandatos le puede ayudar a ordenar el entorno de desarrollo.

### Supresión de credenciales de servicio

Para suprimir un conjunto de credenciales de servicio, utilice un mandato como el siguiente:

```sh
bx cf delete-service-key <instance name> <credentials name>
```
{:pre}

Por ejemplo, para suprimir las credenciales denominadas `creds20170517a`
de la instancia `cs20170517a` de un servicio de {{site.data.keyword.cloudant_short_notm}}, puede utilizar un mandato como el siguiente:

```sh
bx cf delete-service-key cs20170517a creds20170517a
```
{:pre}

### Supresión de una instancia de servicio

Para suprimir una instancia de servicio, utilice un mandato parecido al siguiente:

```sh
bx service delete <instance name>
```
{:pre}

Por ejemplo, para suprimir la instancia `cs20170517a` de un servicio de {{site.data.keyword.cloudant_short_notm}}, puede utilizar un mandato como este:

```sh
bx service delete cs20170517a
```
{:pre}

