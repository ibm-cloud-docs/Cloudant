---

copyright:
  years: 2017, 2019
lastupdated: "2019-03-19"

keywords: identify, api endpoints, log in, select ibm cloudant plan, create ibm cloudant service, create credentials, list service credentials, use ibm cloudant service instance, delete service credentials, delete service instance

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

<!-- Acrolinx: 2018-08-20 -->

# Creación de una instancia de {{site.data.keyword.cloudant_short_notm}} en la CLI de {{site.data.keyword.cloud_notm}} {{site.data.keyword.cloud_notm}}
{: #creating-an-ibm-cloudant-instance-on-ibm-cloud-by-using-the-ibm-cloud-cli}

Esta guía de aprendizaje muestra cómo crear una instancia de servicio de {{site.data.keyword.cloudantfull}} en {{site.data.keyword.cloud}} mediante la CLI de {{site.data.keyword.cloud_notm}}.
{: shortdesc}

## Antes de empezar esta guía de aprendizaje 
{: #before-you-start-this-tutorial}

Para seguir esta guía de aprendizaje, primero debe instalar las herramientas de desarrollador de la CLI de {{site.data.keyword.cloud_notm}}. Para obtener más información sobre la instalación de herramientas, consulte la guía de aprendizaje [Iniciación a la CLI de {{site.data.keyword.cloud_notm}} ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://cloud.ibm.com/docs/cli?topic=cloud-cli-ibmcloud-cli#overview){: new_window}.

## Identificación del punto final de API de {{site.data.keyword.cloud_notm}}
{: #identifying-the-ibm-cloud-api-endpoint}

Especifique el punto final de API de destino para los mandatos de {{site.data.keyword.cloud_notm}}:

```sh
ibmcloud api https://api.ng.bluemix.net
```
{: codeblock}

El resultado confirma que ha identificado correctamente el punto final:

```sh
Setting api endpoint to https://api.ng.bluemix.net...
OK

API endpoint: https://api.ng.bluemix.net (API version: 2.54.0)
Not logged in. Utilice 'ibmcloud login' para iniciar sesión.
```
{: pre}

## Inicio de sesión en su cuenta de {{site.data.keyword.cloud_notm}}
{: #logging-in-to-your-ibm-cloud-account}

El siguiente ejemplo describe el proceso de inicio de sesión. Si utiliza un ID de usuario federado, es importante que cambie a un código de acceso de una sola vez (`ibmcloud login --sso`) o utilice una clave de API (`ibmcloud --apikey key o @key_file`) para la autenticación. Para obtener más información sobre cómo iniciar sesión mediante la CLI, consulte [Mandatos de CLI (ibmcloud) generales ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://cloud.ibm.com/docs/cli/reference/ibmcloud?topic=cloud-cli-ibmcloud_cli#ibmcloud_login){: new_window} en `ibmcloud login`. 

1.  Inicie el proceso de inicio de sesión para su cuenta de {{site.data.keyword.cloud_notm}} utilizando el mandato siguiente:
  
  ```sh
  ibmcloud login
  ```
  {: codeblock}
  
  {{site.data.keyword.cloud_notm}} responde recordándole el punto final de API actual y le solicita la dirección de correo electrónico de su cuenta:
  
  ```sh
  API endpoint: https://api.ng.bluemix.net
  
  Email>
  ```
  {: pre}

2.  Especifique la dirección de correo electrónico de su cuenta y, a continuación, especifique la contraseña:

  ```sh
  API endpoint: https://api.ng.bluemix.net
  
  Email> J.Doe@email.com
  
  Password>
  ```
  {: pre}
  
  {{site.data.keyword.cloud_notm}} valida los detalles y resume la información sobre su sesión de inicio de sesión:

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
  {: pre}

3.  Ha iniciado una sesión en su cuenta de {{site.data.keyword.cloud_notm}}.

## Elección del plan de {{site.data.keyword.cloudant_short_notm}} para su servicio
{: #choosing-the-ibm-cloudant-plan-for-your-service}

Consulte la sección [Planes ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](/docs/services/Cloudant?topic=cloudant-ibm-cloud-public#plans){: new_window} de la documentación para obtener detalles sobre cómo utilizar los planes Estándar o Lite de {{site.data.keyword.cloudant_short_notm}}.
{: pre}

## Creación del servicio {{site.data.keyword.cloudant_short_notm}}
{: #creating-the-ibm-cloudant-service}

{{site.data.keyword.cloudant_short_notm}} utiliza Grupos de recursos para el suministro de nuevas instancias en lugar de organizaciones y espacios de Cloud Foundry. Todavía es posible desplegar las instancias de {{site.data.keyword.cloudant_short_notm}} que se han suministrado anteriormente en organizaciones y espacios de Cloud Foundry. Para obtener más información, consulte la guía [¿Cómo funciona IBM Cloudant con grupos de recursos de IBM Cloud?![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](/docs/services/Cloudant?topic=cloudant-how-does-ibm-cloudant-work-with-ibm-cloud-resource-groups-#how-does-ibm-cloudant-work-with-ibm-cloud-resource-groups-){: new_window} .

En primer lugar, establezca el grupo de recursos de destino y la región como se muestra en [Mandatos de CLI (ibmcloud) generales ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://cloud.ibm.com/docs/cli/reference/ibmcloud?topic=cloud-cli-ibmcloud_cli#ibmcloud_target){: new_window} en `ibmcloud target` utilizando el formato siguiente:

```sh
ibmcloud target [-r REGION_NAME] [-g RESOURCE_GROUP]
```

Para obtener una lista de regiones, ejecute este mandato:

```sh
ibmcloud regions
```

Para obtener una lista de grupos de recursos, ejecute este mandato: 

```sh
ibmcloud resource groups
```

En segundo lugar, para crear una instancia de servicio, el formato de mandato básico en {{site.data.keyword.cloud_notm}} es el siguiente:

```sh
ibmcloud resource service-instance-create NAME SERVICE_NAME|SERVICE_ID SERVICE_PLAN_NAME|SERVICE_PLAN_ID LOCATION [-p, --parameters @JSON_FILE | JSON_STRING ]
```
{: pre}

Los campos se describen en la tabla siguiente: 


Campo | Descripción
------|------------
`NAME` | Nombre arbitrario que le proporciona a la instancia. 
`SERVICE_NAME` | `cloudantnosqldb`
`PLAN_NAME` | Plan Lite o plan Estándar.
`LOCATION` | La ubicación en la que desea realizar el despliegue: AP norte, Alemania, Global, Sídney, Reino Unido, EE.UU. este o EE.UU. sur. 
`legacyCredentials` | El valor predeterminado es true. Este campo determina si la instancia usa credenciales heredadas y de IAM o si solo utiliza credenciales de IAM. 

Para obtener más información sobre la elección de un método de autenticación, consulte la [guía de IAM](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-){: new_window}. El equipo de {{site.data.keyword.cloudant_short_notm}} recomienda el uso de controles de acceso de IAM sobre la autenticación heredada de {{site.data.keyword.cloudant_short_notm}} siempre que sea posible.
{: important}

En este ejemplo, queremos crear una instancia de un servicio de {{site.data.keyword.cloudant_short_notm}} utilizando el plan `Lite` (en el que el nombre de instancia es `cs20170517a` en la ubicación EE.UU. sur y utiliza solo credenciales de IAM); cree la instancia utilizando un mandato similar al del ejemplo siguiente:

```sh
ibmcloud resource service-instance-create cs20170517a cloudantnosqldb lite us-south -p '{"legacyCredentials": false}'
```
{: codeblock}

Después de crear la instancia de servicio, {{site.data.keyword.cloud_notm}} responde con un mensaje parecido al siguiente:

```sh
Creating service instance cs20170517a in resource group default of account John Does's Account as j.doe@email.com...
OK
Service instance cs20170517a was created.
Name          Location   State    Type               Tags
cs20170517a   us-south   active   service_instance  
```
{: pre}

## Creación de credenciales para el servicio de {{site.data.keyword.cloudant_short_notm}}
{: #creating-credentials-for-your-ibm-cloudant-service}

Las aplicaciones que requieren acceso al servicio de {{site.data.keyword.cloudant_short_notm}} deben tener las credenciales necesarias.

Las credenciales de servicio son muy valiosas. Si alguna persona o alguna aplicación tiene acceso a las credenciales, puede hacer lo que quiera con la instancia de servicio. Por ejemplo, podría crear datos falsos o suprimir información importante. Proteja bien estas credenciales.
{: important}

Para obtener más información sobre los campos incluidos en las credenciales de servicio, consulte la [guía de IAM](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-){: new_window}.

El formato básico del mandato para crear credenciales para una instancia de servicio dentro de {{site.data.keyword.cloud_notm}} es el siguiente:

```sh
ibmcloud resource service-key-create NAME ROLE_NAME --instance-name SERVICE_INSTANCE_NAME
```
{: pre}

Los campos se describen en la tabla siguiente:

Campo | Descripción
------|------------
`NAME` | Nombre arbitrario que le proporciona a las credenciales de servicio. 
`ROLE_NAME` | Actualmente, este campo permite únicamente el rol de gestor.
`SERVICE_INSTANCE_NAME` | El nombre que le proporciona a la instancia de {{site.data.keyword.cloudant_short_notm}}. 

Si desea crear credenciales para la instancia `cs20170517a` de un servicio de {{site.data.keyword.cloudant_short_notm}} (en el que el nombre para las credenciales es `creds_for_cs20170517a`), cree las credenciales utilizando un mandato similar al del ejemplo siguiente:

```sh
ibmcloud resource service-key-create creds_for_cs20170517a Manager --instance-name cs20170517a
```
{: codeblock}

Después de recibir la solicitud para crear credenciales para la instancia de servicio, {{site.data.keyword.cloud_notm}} responde con un mensaje parecido al siguiente:

```sh
Creating service key in resource group default of account John Does's Account as john.doe@email.com...
OK
Service key crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42223455bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3:resource-key:621ffde2-ea10-4318-b297-d6d849cec48a was created.
                  
Name:          creds_for_cs20170517a
ID:            crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42223455bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3:resource-key:621ffde2-ea10-4318-b297-d6d849cec48a 
Created At:    Tue Sep 18 19:58:38 UTC 2018
State:         active
Credentials:
               iam_apikey_name:          auto-generated-apikey-621ffde2-ea10-4318-b297-d6d849cec48a
               iam_role_crn:             crn:v1:bluemix:public:iam::::serviceRole:Manager
               url:                      https://f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix:5811381f6daff7255b288695c3544be63f550e975bcde46799473e69c7d48d61@f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix.cloudant.com 
               username:                 f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix
               port:                     443
               apikey:                   XXXXX-XXXXXX_XXXXXXXXXXXXX-XXXXXXXXXXX
               host:                     f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix.cloudant.com
               iam_apikey_description:   Auto generated apikey during resource-key operation for Instance - crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42116849bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3::
               iam_serviceid_crn:        crn:v1:bluemix:public:iam-identity::a/b42116849bb7e2abb0841ca25d28ee4c::serviceid:ServiceId-53f9e2a2-cdfb-4f90-b072-bfffafb68b3e
               password:                 581138...7d48d61 
```
{: pre}

## Recuperación de las credenciales de servicio para el servicio de {{site.data.keyword.cloudant_short_notm}}
{: #retrieving-the-service-credentials-for-your-ibm-cloudant-service}

El formato básico del mandato para recuperar credenciales para una instancia de servicio dentro de {{site.data.keyword.cloud_notm}} es el siguiente:

```sh
ibmcloud resource service-key KEY_NAME
```
{: pre}

En este ejemplo, queremos recuperar las credenciales de la instancia `cs20170517a` de un servicio de {{site.data.keyword.cloudant_short_notm}}
(en el que el nombre de las credenciales es `creds_for_cs20170517a`); recupere las credenciales utilizando un mandato similar al del ejemplo siguiente:

```sh
ibmcloud resource service-key creds_for_cs20170517b
```
{: codeblock}

Después de recibir la solicitud para recuperar las credenciales para la instancia de servicio, {{site.data.keyword.cloud_notm}} responde con un mensaje (abreviado) parecido al siguiente:

```sh
Retrieving service key in resource group default of account John Does's Account as john.doe@email.com...
OK
Service key crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42223455bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3:resource-key:621ffde2-ea10-4318-b297-d6d849cec48a was created.
                  
Name:          creds_for_cs20170517a
ID:            crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42223455bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3:resource-key:621ffde2-ea10-4318-b297-d6d849cec48a 
Created At:    Tue Sep 18 19:58:38 UTC 2018
State:         active
Credentials:
               iam_apikey_name:          auto-generated-apikey-621ffde2-ea10-4318-b297-d6d849cec48a
               iam_role_crn:             crn:v1:bluemix:public:iam::::serviceRole:Manager
               url:                      https://f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix:5811381f6daff7255b288695c3544be63f550e975bcde46799473e69c7d48d61@f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix.cloudant.com 
               username:                 f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix
               port:                     443
               apikey:                   XXXXX-XXXXXX_XXXXXXXXXXXXX-XXXXXXXXXXX
               host:                     f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix.cloudant.com
               iam_apikey_description:   Auto generated apikey during resource-key operation for Instance - crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42116849bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3::
               iam_serviceid_crn:        crn:v1:bluemix:public:iam-identity::a/b42116849bb7e2abb0841ca25d28ee4c::serviceid:ServiceId-53f9e2a2-cdfb-4f90-b072-bfffafb68b3e
               password:                 581138...7d48d61 
```
{: pre}

## Utilización de la instancia de servicio de {{site.data.keyword.cloudant_short_notm}}
{: #using-your-ibm-cloudant-service-instance}

Ya ha finalizado con las tareas siguientes:

1.  Ha creado una instancia de servicio de {{site.data.keyword.cloudant_short_notm}}
  dentro de {{site.data.keyword.cloud_notm}}.
2.  Ha creado credenciales para la instancia de servicio de {{site.data.keyword.cloudant_short_notm}}.
3.  Ha recuperado las credenciales de la instancia de servicio, para que las pueda utilizar la aplicación.

Para obtener más información, consulte la guía de aprendizaje [Cómo crear y rellenar una base de datos de {{site.data.keyword.cloudant_short_notm}} en {{site.data.keyword.cloud_notm}}](/docs/services/Cloudant?topic=cloudant-creating-and-populating-a-simple-ibm-cloudant-database-on-ibm-cloud#context){: new_window} que muestra cómo utilizar una instancia de servicio de {{site.data.keyword.cloudant_short_notm}} desde una aplicación Python utilizando las credenciales heredadas. No olvide sustituir las credenciales que ha creado en esta guía de aprendizaje.

## (Opcional) Ordenación posterior
{: #-optional-tidying-up-afterward}

La siguiente lista de mandatos le puede ayudar a ordenar el entorno de desarrollo.

### Supresión de credenciales de servicio
{: #deleting-service-credentials}

Para suprimir un conjunto de credenciales de servicio, utilice un mandato como el siguiente:

```sh
ibmcloud resource service-key-delete KEY_NAME
```
{: pre}

Por ejemplo, para suprimir las credenciales denominadas `creds_for_cs20170517a`, utilice un mandato como el siguiente:

```sh
ibmcloud resource service-key-delete creds_for_cs20170517a
```
{: pre}

### Supresión de una instancia de servicio
{: #deleting-a-service-instance}

Para suprimir una instancia de servicio, utilice un mandato como el siguiente:

```sh
ibmcloud resource service-instance-delete SERVICE_INSTANCE_NAME
```
{: pre}

Por ejemplo, para suprimir la instancia `cs20170517a` de un servicio de {{site.data.keyword.cloudant_short_notm}}, utilice un mandato como el siguiente:

```sh
ibmcloud resource service-instance-delete cs20170517a
```
{: pre}

