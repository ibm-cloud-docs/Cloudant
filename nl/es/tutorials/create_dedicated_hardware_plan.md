---

copyright:
  years: 2015, 2019
lastupdated: "2019-06-12"

keywords: create dedicated hardware plan instance, provision standard plan instance, cli, create credentials, list service credentials

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

# Creación y optimización de una instancia del plan de hardware dedicado de {{site.data.keyword.cloudant_short_notm}} en {{site.data.keyword.cloud_notm}}
{: #creating-and-leveraging-an-ibm-cloudant-dedicated-hardware-plan-instance-on-ibm-cloud}

Esta guía de aprendizaje muestra cómo crear una instancia del plan de hardware dedicado de {{site.data.keyword.cloudantfull}} que utiliza el panel de control de {{site.data.keyword.cloud}} y muestra cómo suministrar una o varias instancias del plan estándar para que se ejecuten ahí utilizando el catálogo de {{site.data.keyword.cloud_notm}} o la CLI de {{site.data.keyword.cloud_notm}}. 
{: shortdesc}

La creación de una instancia del plan de hardware dedicado de {{site.data.keyword.cloudant_short_notm}} da como resultado el suministro de un entorno de {{site.data.keyword.cloudant_short_notm}} en un hardware dedicado para su uso exclusivo. Se creará una instancia de servicio en el panel de control de {{site.data.keyword.cloud_notm}}, pero no podrá acceder a la instancia del plan de hardware dedicado directamente y no dispondrá de credenciales de servicio. Podrá utilizar una instancia del plan de hardware dedicado de {{site.data.keyword.cloudant_short_notm}} una vez creado proporcionándole una o varias instancias del plan estándar.

## Creación de una instancia del plan de hardware dedicado de {{site.data.keyword.cloudant_short_notm}}
{: #creating-an-ibm-cloudant-dedicated-hardware-plan-instance}

1.  Inicie sesión en su cuenta de {{site.data.keyword.cloud_notm}}.<br/>
    El panel de control de {{site.data.keyword.cloud_notm}} se puede encontrar en:
[`https://cloud.ibm.com/` ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://cloud.ibm.com/){: new_window}.
    Después de autenticarse con su nombre de usuario y contraseña, aparecerá el panel de control de {{site.data.keyword.cloud_notm}}. Pulse el botón `Crear recurso`:<br/>
    ![{{site.data.keyword.cloud_notm}} panel de control](images/img0001.png)

2.  Pulse `Bases de datos` en el menú y `Cloudant` en la lista de servicio de base de datos. <br/>
     ![{{site.data.keyword.cloud_notm}} {{site.data.keyword.cloudant_short_notm}} selección del servicio](images/img0003.png)<br/>

3.  Seleccione plan de `hardware dedicado` en la lista de planes de precios:
<br/>
    ![Planes de precios](images/pricing_plan.png)
    
4.  Rellene los parámetros siguientes: <br/>
    -   Especifique un nombre de servicio.<br/>
    -   Especifique la región/ubicación en la que desea realizar el despliegue. La región/ubicación será una de las seis principales regiones de {{site.data.keyword.cloud_notm}} en las que se desea desplegar la instancia. La ubicación física real de la instancia la determina el parámetro de ubicación descrito en la lista siguiente.<br/>
    -   Seleccione un grupo de recursos.</br>
    -   Añada una etiqueta. 
    -   Seleccione una ubicación para el despliegue. Esta ubicación es la ubicación física de la instancia, que puede estar en cualquier ubicación de {{site.data.keyword.cloud_notm}}, incluidas las principales regiones y ubicaciones fuera de las regiones principales. Para obtener más información, consulte [Centros de datos globales de {{site.data.keyword.IBM}} ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/cloud/data-centers/){:new_window}.<br/>
    -   Seleccione `sí` o `no` para responder si la HIPAA es necesaria.<br/> 
    
    La HIPAA solo es válida en EE.UU. {{site.data.keyword.IBM}} puede suministrar un entorno de plan de hardware dedicado para implementar controles de HIPAA. Solo se suministrará un entorno tras la confirmación de un acuerdo de socio empresarial (BAA) establecido con {{site.data.keyword.IBM_notm}}. Consulte [Habilitación del valor Soporte de HIPAA](https://cloud.ibm.com/docs/account/eu_hipaa_supported.html#enabling-the-hipaa-supported-setting) y los términos de descripción de servicio para obtener más detalles. El suministro de un clúster para gestionar datos HIPAA puede llevar más tiempo que el período estimado de 5 días.
    {: note}

    ![Configurar el hardware dedicado](images/select_deployment_location.png)
        
5.  Pulse el botón `Crear` para iniciar el proceso de suministro. <br/>

    La facturación se prorratea diariamente para garantizar que desea realizar el suministro y pagar un entorno antes de pulsar el botón **Crear**.
    {: note}

    ![Suministro de hardware dedicado](images/create_button_provision.png)

    Durante el suministro, aparece una rueda giratoria junto a la instancia en el panel de control de {{site.data.keyword.cloud_notm}}. Se envía una solicitud para suministrar una instancia del plan de hardware dedicado en servidores nativos. El tiempo de suministro es asíncrono y puede tardar hasta 5 días. 
    {: note}   

    ![Suministro de una versión alternativa del hardware dedicado](images/create_button_provision2.png)
    
## Suministro de una instancia del plan estándar en un entorno de hardware dedicado
{: #provisioning-a-standard-plan-instance-on-a-dedicated-hardware-environment}

1.  Inicie sesión en su cuenta de {{site.data.keyword.cloud_notm}}.<br/>
    El panel de control de {{site.data.keyword.cloud_notm}} se puede encontrar en:
[https://cloud.ibm.com/ ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://cloud.ibm.com/){: new_window}.
    Después de autenticarse con su nombre de usuario y contraseña, aparecerá el panel de control de {{site.data.keyword.cloud_notm}}. Pulse el botón `Crear recurso`:<br/>
    ![{{site.data.keyword.cloud_notm}} panel de control](images/img0001.png)

2.  Pulse `Bases de datos` en el menú y `Cloudant` en la lista de servicio de base de datos. <br/>
     ![{{site.data.keyword.cloud_notm}} {{site.data.keyword.cloudant_short_notm}} selección del servicio](images/img0003.png)<br/>
    Aparecerá la página para la creación de un servicio.<br/>  

3.  Pulse `Estándar` en los planes de precios. <br/>
    ![plan de precios estándar](images/standard_pricing_plan.png)
    
    No puede suministrar una instancia del plan Lite en un entorno de hardware dedicado.
    {: tip}
    
4.  Rellene los parámetros siguientes: <br/>
    -   Especifique un nombre de servicio.<br/>
    -   Especifique la región/ubicación en la que desea realizar el despliegue. <br/>
    -   Seleccione un grupo de recursos.</br>
    -   Añada una etiqueta. 
    -   Seleccione un método de autenticación.</br>
    -   Seleccione un entorno, que es el lugar en el que se desplegará la instancia de plan estándar. Las instancias de entorno de hardware dedicado desplegadas en la cuenta se mostrarán en el desplegable si están disponibles.</br>
    ![Configurar instancia estándar](images/select_environment.png)
    
5.  Pulse el botón `Crear`.<br/>
    Unos segundos después, la instancia se suministrará en el entorno que ha seleccionado.<br/>
    ![Suministro de una instancia estándar](images/create_button_provision_standard.png)
    
6.  Obtenga las credenciales de servicio y el acceso al panel de control de {{site.data.keyword.cloudant_short_notm}} de la misma forma que lo hace en la instancia de {{site.data.keyword.cloudant_short_notm}} multiarrendatario. 
    
    Para obtener más información, consulte [cómo ubicar las credenciales de servicio](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud#locating-your-service-credentials){: new_window}. 
    
## Suministro de una instancia del plan estándar en un entorno de hardware dedicado con la CLI de {{site.data.keyword.cloud_notm}}
{: #provisioning-a-standard-plan-instance-on-a-dedicated-hardware-environment-with-the-ibm-cloud-cli}

Para utilizar la CLI de {{site.data.keyword.cloud_notm}}, debe haber iniciado la sesión. Para obtener más información sobre cómo iniciar sesión y establecer un grupo de recursos de destino, consulte [Inicio de sesión en su cuenta de {{site.data.keyword.cloud_notm}}](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud-by-using-the-ibm-cloud-cli#logging-in-to-your-ibm-cloud-account){: new_window}. 

Para crear una instancia del plan estándar de {{site.data.keyword.cloudant_short_notm}} en el entorno del plan de hardware dedicado de {{site.data.keyword.cloudant_short_notm}}, el formato básico del mandato es el siguiente:


Campo | Descripción
------|------------
`NAME`| Un nombre arbitrario que asigna a la instancia.
`SERVICE_NAME` | `cloudantnosqldb`
`PLAN_NAME` | Plan Estándar
`LOCATION` |  La ubicación en la que desea realizar el despliegue, por ejemplo, us-south, us-east o eu-gb. 

Consulte el siguiente mandato de ejemplo: 

```sh
ibmcloud resource service-instance-create NAME SERVICE_NAME SERVICE_PLAN_NAME LOCATION [-p, --parameters @JSON_FILE | JSON_STRING ]
```
{: codeblock}

Las instancias de {{site.data.keyword.cloudant_short_notm}} que se despliegan en entornos de hardware dedicado necesitan dos parámetros más:

Parámetro | Descripción
----------|------------
`environment_crn` | Este parámetro debe fijarse en el CRN de la instancia del plan de hardware dedicado de {{site.data.keyword.cloudant_short_notm}}. Puede determinar qué es el CRN observando el ejemplo del mandato de CLI en el separador Gestionar de la instancia del plan de hardware dedicado de {{site.data.keyword.cloudant_short_notm}} en el panel de control de {{site.data.keyword.cloud_notm}}. O bien, puede determinar qué es el CRN utilizando el mandato `ibmcloud resource service-instance SERVICE_INSTANCE_NAME`. 
`legacyCredentials` | Un parámetro opcional cuyo valor predeterminado es true y que determina si la instancia utiliza credenciales de IAM y heredadas o si únicamente utiliza credenciales de IAM. Para obtener más detalles sobre la elección de un método de autenticación, consulte la [Guía de IAM](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-).

Consulte el siguiente mandato de ejemplo: 

```sh
ibmcloud resource service-instance-create cloudant_on_ded_hardware_cli cloudantnosqldb standard us-south -p '{"environment_crn":"crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b43434444bb7e2abb0841ca25d28ee4c:301a3118-7678-4d99-b1b7-4d45cf5f7b29::","legacyCredentials":false}'
```
{: codeblock}

## Creación de credenciales para el servicio de {{site.data.keyword.cloudant_short_notm}}
{: #creating-the-credentials-for-your-ibm-cloudant-service}

Las aplicaciones que requieren acceso al servicio de {{site.data.keyword.cloudant_short_notm}} deben tener las credenciales necesarias.

Las credenciales de servicio son muy valiosas. Si alguna persona o alguna aplicación tiene acceso a las credenciales, puede hacer lo que quiera con la instancia de servicio. Por ejemplo, podría crear datos falsos o suprimir información importante. Proteja bien estas credenciales.
{: important}

Para obtener más información sobre los campos incluidos en las credenciales de servicio, consulte la [guía de IAM](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-).

El formato básico del mandato para crear credenciales para una instancia de servicio dentro de {{site.data.keyword.cloud_notm}} es el siguiente:

```sh
ibmcloud resource service-key-create NAME ROLE_NAME --instance-name SERVICE_INSTANCE_NAME [-p '{"service-endpoints":"internal"}]
```
{: pre}

Los campos se describen en la tabla siguiente:

Campo | Descripción
------|------------
`NAME` | Nombre arbitrario que le proporciona a las credenciales de servicio. 
`ROLE_NAME` | Actualmente, este campo permite únicamente el rol de gestor.
`SERVICE_INSTANCE_NAME` | El nombre que le proporciona a la instancia de {{site.data.keyword.cloudant_short_notm}}.
`service-endpoints` | Un parámetro opcional para rellenar el campo de URL en las credenciales de servicio con un punto final interno para conectarse al servicio a través de la red interna de {{site.data.keyword.cloud_notm}}. Omita este parámetro para rellenar el URL con un punto final externo que sea accesible públicamente. Solo se aplica a instancias del plan Estándar desplegadas en entornos de hardware dedicado que tengan soporte para puntos finales internos. El mandato tendrá como resultado un error 400 si el entorno no admite puntos finales internos. 

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

Si desea crear credenciales para la instancia `cs20170517a` de un servicio de {{site.data.keyword.cloudant_short_notm}} (en el que el nombre para las credenciales es `creds_for_cs20170517a`) y desea rellenar el URL con el punto final interno, cree las credenciales utilizando un mandato similar al del ejemplo siguiente:

```sh
ibmcloud resource service-key-create creds_for_cs20170517a Manager --instance-name cs20170517a -p '{"service-endpoints":"internal"}'
```
{: codeblock}

Después de recibir la solicitud para crear credenciales para la instancia de servicio, {{site.data.keyword.cloud_notm}} responde con un mensaje parecido al siguiente:

```sh
Creating service key in resource group default of account John Does's Account as john.doe@email.com...
OK
Service key crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42223455bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3:resource-key:621ffde2-ea10-4318-b297-d6d849cec48a was created.
                  
Name:          creds_for_cs20170517a
ID:            crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42223455bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3:resource-key:621ffde2-ea10-4318-b297-d6d849cec48a 
Created At:    Tue Jan 02 19:58:38 UTC 2019
State:         active
Credentials:
               iam_apikey_name:          auto-generated-apikey-621ffde2-ea10-4318-b297-d6d849cec48a
               iam_role_crn:             crn:v1:bluemix:public:iam::::serviceRole:Manager
               url:                      https://2624fed5-e53e-41de-a85b-3c7d7636886f-bluemix.private.cloudantnosqldb.appdomain.cloud
               username:                 f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix
               apikey:                   XXXXX-XXXXXX_XXXXXXXXXXXXX-XXXXXXXXXXX
               host:                     2624fed5-e53e-41de-a85b-3c7d7636886f-bluemix.private.cloudantnosqldb.appdomain.cloud
               iam_apikey_description:   Auto generated apikey during resource-key operation for Instance - crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42116849bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3::     
               iam_serviceid_crn:        crn:v1:bluemix:public:iam-identity::a/b42116849bb7e2abb0841ca25d28ee4c::serviceid:ServiceId-53f9e2a2-cdfb-4f90-b072-bfffafb68b3e       
```
{: pre}

## Listado de las credenciales de servicio para el servicio de {{site.data.keyword.cloudant_short_notm}}
{: #listing-the-service-credentials-for-your-ibm-cloudant-service}

El formato básico del mandato para recuperar credenciales para una instancia de servicio dentro de {{site.data.keyword.cloud_notm}} es el siguiente:

```sh
ibmcloud resource service-key KEY_NAME
```
{: codeblock}

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
