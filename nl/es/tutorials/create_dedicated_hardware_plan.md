---

copyright:
  years: 2015, 2018
lastupdated: "2018-10-24"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:tip: .tip}

<!-- Acrolinx: 2017-05-10 -->


# Creación y optimización de una instancia del plan de hardware dedicado de {{site.data.keyword.cloudant_short_notm}} en {{site.data.keyword.cloud_notm}}

Esta guía de aprendizaje muestra cómo crear una instancia del plan de hardware dedicado de {{site.data.keyword.cloudantfull}} que utiliza el panel de control de {{site.data.keyword.cloud}} y muestra cómo suministrar una o varias instancias del plan estándar para que se ejecuten ahí utilizando el catálogo de {{site.data.keyword.cloud_notm}} o la CLI de {{site.data.keyword.cloud_notm}}. 

La creación de una instancia del plan de hardware dedicado de {{site.data.keyword.cloudant_short_notm}} da como resultado el suministro de un entorno de {{site.data.keyword.cloudant_short_notm}} en un hardware dedicado para su uso exclusivo. Se creará una instancia de servicio en el panel de control de {{site.data.keyword.cloud_notm}}, pero no podrá acceder a la instancia del plan de hardware dedicado directamente y no dispondrá de credenciales de servicio. Podrá utilizar una instancia del plan de hardware dedicado de {{site.data.keyword.cloudant_short_notm}} una vez creado proporcionándole una o varias instancias del plan estándar.

## Creación de una instancia del plan de hardware dedicado de {{site.data.keyword.cloudant_short_notm}}

1.  Inicie una sesión en su cuenta de {{site.data.keyword.cloud_notm}}.<br/>
    Encontrará el panel de control de {{site.data.keyword.cloud_notm}} en: [http://bluemix.net ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](http://bluemix.net){:new_window}.
    Después de autenticarse con su nombre de usuario y contraseña, aparecerá el panel de control de {{site.data.keyword.cloud_notm}}:<br/>
    ![Panel de control de {{site.data.keyword.cloud_notm}}](images/img0001.png)

2.  Pulse el botón `Crear recurso`:<br/>
    ![botón de crear recurso de {{site.data.keyword.cloud_notm}}](images/img0002.png)<br/>
    
3.  Consulte el catálogo de {{site.data.keyword.cloud_notm}} y los servicios que están disponibles. Pulse la categoría `Bases de datos`.
    ![catálogo de {{site.data.keyword.cloud_notm}}](images/img0000.png)

4.  Pulse el servicio {{site.data.keyword.cloudant_short_notm}}:<br/>
    ![ selección de servicio {{site.data.keyword.cloudant_short_notm}} de {{site.data.keyword.cloud_notm}}](images/img0003.png)<br/>
    Aparecerá la página para la creación de un servicio.

5.  Seleccione el plan `Hardware dedicado` de la lista de planes de precios en la parte inferior de la página:<br/>
    ![Planes de precios](../tutorials/images/pricing_plan.png)
    
6.  Rellene los parámetros siguientes en la parte superior de la página: <br/>
    -   Escriba un nombre de servicio.<br/>
    -   Especifique la región/ubicación en la que desea realizar el despliegue.<br/>
    -   Seleccione un grupo de recursos.</br>
    -   Seleccione una ubicación para el despliegue.<br/>
    -   Seleccione `sí` o `no` para responder si la HIPAA es necesaria.<br/>
   
    La HIPAA solo es válida en EE.UU. {{site.data.keyword.IBM}} puede suministrar un clúster nativo o dedicado para implementar controles de HIPAA. Solo se suministrará un clúster tras la confirmación de un acuerdo de socio empresarial (BAA) establecido con {{site.data.keyword.IBM_notm}}. Este acuerdo se describe en los términos de descripción del servicio. El suministro de un clúster para gestionar datos HIPAA puede llevar más tiempo que el período estimado de 5 días.
    {: tip}
    
    Debe desplegar y suministrar instancias del plan estándar en la misma región y espacio.
    {: tip}

    ![Configurar el hardware dedicado](../tutorials/images/select_deployment_location.png)
        
7.  Pulse el botón `Crear` para iniciar el proceso de suministro. <br/>

    La facturación se prorratea diariamente para garantizar que desea realizar el suministro y pagar un entorno antes de pulsar el botón **Crear**.
    {: tip}

    ![Suministro de hardware dedicado](../tutorials/images/create_button_provision.png)

    Durante el suministro, aparece una rueda giratoria junto a la instancia en el panel de control de {{site.data.keyword.cloud_notm}}. Se envía una solicitud para suministrar una instancia del plan de hardware dedicado en servidores nativos. El tiempo de suministro es asíncrono y puede tardar hasta 5 días. 
    {: tip}   

    ![Suministro de una versión alternativa del hardware dedicado](../tutorials/images/create_button_provision2.png)
    
## Suministro de una instancia del plan estándar en un entorno de hardware dedicado

1.  Inicie una sesión en su cuenta de {{site.data.keyword.cloud_notm}}.<br/>
    Encontrará el panel de control de {{site.data.keyword.cloud_notm}} en: [http://bluemix.net ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](http://bluemix.net){:new_window}.
    Después de autenticarse con su nombre de usuario y contraseña, aparecerá el panel de control de {{site.data.keyword.cloud_notm}}:<br/>
    ![Panel de control de {{site.data.keyword.cloud_notm}}](images/img0001.png)

2.  Pulse el botón `Crear recurso`:<br/>
    ![crear recurso de {{site.data.keyword.cloud_notm}}](images/img0002.png)<br/>
    Aparecerá una lista de los servicios disponibles en {{site.data.keyword.cloud_notm}}.

3.  Pulse la categoría `Bases de datos` y seleccione el servicio `Cloudant`:<br/>
    ![ selección de servicio {{site.data.keyword.cloudant_short_notm}} de {{site.data.keyword.cloud_notm}}](images/img0003.png)</br>
    Aparecerá la página para la creación de un servicio.<br/>  

4.  Pulse `Estándar` en los planes de precios. <br/>
    ![Plan de precios estándar](../tutorials/images/standard_pricing_plan.png)
    
    No puede suministrar una instancia del plan Lite en un entorno de hardware dedicado.
    {: tip}
    
5.  Rellene los parámetros siguientes: <br/>
    -   Escriba un nombre de servicio.<br/>
    -   Especifique la región/ubicación en la que desea realizar el despliegue. <br/>
    -   Seleccione un grupo de recursos. </br>
    -   Seleccione un método de autenticación.</br>
    -   Seleccione un entorno.</br>
    ![Configurar la instancia estándar](../tutorials/images/select_environment.png)
    
6.  Pulse el botón `Crear`.<br/>
    Unos segundos después, la instancia se suministrará en el entorno que ha seleccionado.<br/>
    ![Suministro de la instancia estándar](../tutorials/images/create_button_provision_standard.png)
    
7.  Obtenga las credenciales de servicio y el acceso al panel de control de {{site.data.keyword.cloudant_short_notm}} de la misma forma que lo hace en la instancia de {{site.data.keyword.cloudant_short_notm}} multiarrendatario. 
    
    Para obtener más información, consulte [cómo ubicar las credenciales de servicio](../tutorials/create_service.html#locating-your-service-credentials){:new_window}. 
    
## Suministro de una instancia del plan estándar en un entorno de hardware dedicado con la CLI de {{site.data.keyword.cloud_notm}}

Para utilizar la CLI de {{site.data.keyword.cloud_notm}}, debe haber iniciado la sesión. Para obtener más información sobre cómo iniciar sesión y establecer un grupo de recursos de destino, consulte [Inicio de sesión en su cuenta de {{site.data.keyword.cloud_notm}}](create_service_cli.html#logging-in-to-your-ibm-cloud-account){:new_window}. 

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

Las instancias de {{site.data.keyword.cloudant_short_notm}} que se despliegan en entornos de hardware dedicado necesitan dos parámetros más:

Parámetro | Descripción
----------|------------
`environment_crn` | Este parámetro debe fijarse en el CRN de la instancia del plan de hardware dedicado de {{site.data.keyword.cloudant_short_notm}}. Puede determinar qué es el CRN observando el ejemplo del mandato de CLI en el separador Gestionar de la instancia del plan de hardware dedicado de {{site.data.keyword.cloudant_short_notm}} en el panel de control de {{site.data.keyword.cloud_notm}}. O bien, puede determinar qué es el CRN utilizando el mandato `ibmcloud resource service-instance SERVICE_INSTANCE_NAME`. 
`legacyCredentials` | Un parámetro opcional cuyo valor predeterminado es true y que determina si la instancia utiliza credenciales de IAM y heredadas o si únicamente utiliza credenciales de IAM. Consulte la [guía de IAM ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](../guides/iam.html#ibm-cloud-identity-and-access-management-iam-){:new_window} para obtener más detalles sobre cómo seleccionar un método de autenticación.

Consulte el siguiente mandato de ejemplo: 

```sh
ibmcloud resource service-instance-create cloudant_on_ded_hardware_cli cloudantnosqldb standard us-south -p '{"environment_crn":"crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b43434444bb7e2abb0841ca25d28ee4c:301a3118-7678-4d99-b1b7-4d45cf5f7b29::","legacyCredentials":false}'
```
     
