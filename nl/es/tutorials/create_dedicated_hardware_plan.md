---

copyright:
  years: 2015, 2018
lastupdated: "2017-11-07"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-02-23 -->

# Creación y optimización de una instancia del plan de hardware dedicado de {{site.data.keyword.cloudant_short_notm}} en {{site.data.keyword.Bluemix_notm}}

Esta guía de aprendizaje muestra cómo crear una instancia del plan de hardware dedicado de {{site.data.keyword.cloudantfull}} utilizando el panel de control de {{site.data.keyword.Bluemix}} y cómo suministrar una o varias instancias del plan estándar para que se ejecuten ahí. 

La creación de una instancia del plan de hardware dedicado de {{site.data.keyword.cloudant_short_notm}} da como resultado el suministro de un entorno de {{site.data.keyword.cloudant_short_notm}} en un hardware dedicado para su uso exclusivo. Se creará una instancia de servicio en el panel de control de {{site.data.keyword.Bluemix_notm}}, pero tenga en cuenta que no podrá acceder a la instancia del plan de hardware dedicado directamente y que no dispondrá de credenciales de servicio. Podrá utilizar una instancia del plan de hardware dedicado de {{site.data.keyword.cloudant_short_notm}} una vez creado proporcionándole una o varias instancias del plan estándar.

## Creación de una instancia del plan de hardware dedicado de {{site.data.keyword.cloudant_short_notm}}

1.  Inicie una sesión en su cuenta de {{site.data.keyword.Bluemix_notm}}.<br/>
    Encontrará el panel de control de {{site.data.keyword.Bluemix_notm}} en: [http://bluemix.net ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](http://bluemix.net){:new_window}.
    Después de autenticarse con su nombre de usuario y contraseña, aparecerá el panel de control de {{site.data.keyword.Bluemix_notm}}:<br/>
    ![Panel de control de {{site.data.keyword.Bluemix_notm}}](images/img0001.png)

2.  Pulse el enlace `Catálogo`:<br/>
    ![Enlace del catálogo de {{site.data.keyword.Bluemix_notm}}](images/img0002.png)<br/>
    Aparecerá una lista de los servicios disponibles en {{site.data.keyword.Bluemix_notm}}.

3.  Pulse la entrada `Datos y análisis` bajo la cabecera `Servicios`:<br/>
    ![Servicios de datos y análisis de {{site.data.keyword.Bluemix_notm}}](images/img0003.png)<br/>
    Aparece una lista de los servicios de datos y análisis disponibles en {{site.data.keyword.Bluemix_notm}}.

4.  Pulse el servicio {{site.data.keyword.cloudant_short_notm}}:<br/>
    ![Selección del servicio {{site.data.keyword.cloudant_short_notm}} de {{site.data.keyword.Bluemix_notm}}](images/img0004.png)<br/>
    Aparecerá la página para la creación de un servicio. 

5.  Seleccione el plan de hardware `Hardware dedicado` de la lista de planes de precios en la parte inferior de la página:<br/>
    ![Planes de precios](../tutorials/images/pricing_plan.png)
    
6.  Rellene los parámetros siguientes en la parte superior de la página: <br/>
    -   Especifique un nombre de servicio.<br/>
    -   Especifique la región y el espacio para el despliegue.<br/>
    -   Seleccione una ubicación para el despliegue.<br/>
    -   Responda sí o no a la pregunta acerca de si la HIPAA es necesaria. Tenga que cuenta que la HIPAA solo es válida en EE.UU.<br/> 
     
    **Nota**: Debe desplegar y suministrar instancias del plan estándar en la misma región y espacio.    
    ![Configurar el hardware dedicado](../tutorials/images/select_deployment_location.png)<br/>
    Inicie el proceso de suministro. 
    
7.  Pulse el botón `Crear` para iniciar el suministro desde la parte inferior de la pantalla. <br/>
    **Nota**: La facturación se prorratea diariamente para garantizar que desea realizar el suministro y
    pagar un entorno antes de pulsar el botón **Crear**.<br/>
    ![Suministro de hardware dedicado](../tutorials/images/create_button_provision.png)<br/>
    **Nota**: Durante el suministro, aparece una rueda giratoria junto a la instancia en el panel de control de {{site.data.keyword.Bluemix_notm}}. Se envía una solicitud para suministrar una instancia del plan de hardware dedicado
    en servidores nativos. El tiempo de suministro es asíncrono y puede tardar hasta 5 días.
    ![Suministro de una versión alternativa del hardware dedicado](../tutorials/images/create_button_provision2.png)<br/>
    
## Suministro de una instancia del plan estándar en un entorno de hardware dedicado

1.  Inicie una sesión en su cuenta de {{site.data.keyword.Bluemix_notm}}.<br/>
    Encontrará el panel de control de {{site.data.keyword.Bluemix_notm}} en: [http://bluemix.net ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](http://bluemix.net){:new_window}.
    Después de autenticarse con su nombre de usuario y contraseña, aparecerá el panel de control de {{site.data.keyword.Bluemix_notm}}:<br/>
    ![Panel de control de {{site.data.keyword.Bluemix_notm}}](images/img0001.png)

2.  Pulse el enlace `Catálogo`:<br/>
    ![Enlace del catálogo de {{site.data.keyword.Bluemix_notm}}](images/img0002.png)<br/>
    Aparecerá una lista de los servicios disponibles en {{site.data.keyword.Bluemix_notm}}.

3.  Pulse la entrada `Datos y análisis` bajo la cabecera `Servicios`:<br/>
    ![Servicios de datos y análisis de {{site.data.keyword.Bluemix_notm}}](images/img0003.png)<br/>
    Aparece una lista de los servicios de datos y análisis disponibles en {{site.data.keyword.Bluemix_notm}}.

4.  Pulse el servicio {{site.data.keyword.cloudant_short_notm}}:<br>
    ![Selección del servicio {{site.data.keyword.cloudant_short_notm}} de {{site.data.keyword.Bluemix_notm}}](images/img0004.png)<br/>
    Aparecerá la página para la creación de un servicio.  

5.  Pulse `Estándar` en los planes de precios en la parte inferior de la página. <br/>
    **Nota**: No puede suministrar una instancia del plan Lite en un entorno de hardware dedicado.<br/>
    ![Plan de precios estándar](../tutorials/images/standard_pricing_plan.png)
    
6.  Rellene los parámetros en la parte superior de la página especificando un nombre de servicio, nombre de credencial, etc., como lo haría en una instancia del plan estándar. Decida si desea realizar un suministro en el entorno multiarrendatario regional predeterminado
    o en el entorno de hardware dedicado que ha suministrado utilizando el desplegable `Seleccionar entorno`.<br/>
    ![Configurar la instancia estándar](../tutorials/images/select_environment.png)
    
7.  Pulse el botón `Crear` en la parte inferior de la página.<br/>
    Unos segundos después, la instancia se suministrará en el entorno que ha seleccionado.<br/>
    ![Suministro de la instancia estándar](../tutorials/images/create_button_provision_standard.png)
    
8.  Obtenga las credenciales de servicio y el acceso al panel de control de {{site.data.keyword.cloudant_short_notm}} de la misma forma que lo hace en la instancia de {{site.data.keyword.cloudant_short_notm}} multiarrendatario. 
    Obtendrá más información sobre cómo ubicar las credenciales de servicio [aquí ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://console.bluemix.net/docs/services/Cloudant/tutorials/create_service.html#locating-your-service-credentials){:new_window}. 
     
