---

copyright:
  years: 2017, 2019
lastupdated: "2019-06-12"

keywords: create service instance, service credentials, locate service credentials

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

<!-- Acrolinx: 2018-09-19 -->

# Creación de una instancia de {{site.data.keyword.cloudant_short_notm}} en {{site.data.keyword.cloud_notm}}
{: #creating-an-ibm-cloudant-instance-on-ibm-cloud}

En esta guía de aprendizaje se muestra cómo crear una instancia de servicio de {{site.data.keyword.cloudantfull}} mediante el panel de control de {{site.data.keyword.cloud}} y se muestra dónde encontrar la información básica para permitir que las aplicaciones funcionen con la base de datos.
{: shortdesc} 

## Creación de una instancia de servicio
{: #creating-a-service-instance}

1.  Inicie sesión en su cuenta de {{site.data.keyword.cloud_notm}}.<br/>
    El panel de control de {{site.data.keyword.cloud_notm}} se puede encontrar en:
[https://cloud.ibm.com/ ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://cloud.ibm.com/){: new_window}.
    Después de autenticarse con su nombre de usuario y contraseña, aparecerá el panel de control de {{site.data.keyword.cloud_notm}}. Pulse
el botón `Crear recurso`. <br/>
    ![{{site.data.keyword.cloud_notm}} panel de control](images/img0001.png)

2.  Pulse `Bases de datos` en el menú y `Cloudant` en la lista
de servicios de base de datos: <br/>
    ![{{site.data.keyword.cloud_notm}} servicios de base de datos](images/img0003.png)<br/>

3.  En la ventana de configuración del servicio, especifique un nombre de servicio. Compruebe que el nombre del servicio, la región/ubicación y los métodos de autenticación son correctos. Añada una etiqueta si lo desea. Los métodos de autenticación que están disponibles incluyen `Utilizar solo IAM` o `Utilizar credenciales heredadas y de IAM`. Para obtener más información, consulte los [métodos de autenticación](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-){: new_window}. 
    En este ejemplo, el nombre de servicio es `Cloudant-o7`:<br/>
    ![{{site.data.keyword.cloudant_short_notm}} nombre de servicio y credenciales](images/img0005.png)
    
El equipo de {{site.data.keyword.cloudant_short_notm}} recomienda el uso de controles de acceso de IAM sobre la autenticación heredada de {{site.data.keyword.cloudant_short_notm}} siempre que sea posible.
{: important}

4.  Por defecto, el servicio se crea utilizando el plan de precios 'Lite', que es gratuito pero se proporciona con una cantidad fija de capacidad de rendimiento suministrada y almacenamiento de datos. Si dispone de una cuenta de {{site.data.keyword.cloud_notm}} de pago, también puede seleccionar el plan 'Estándar' de pago para poder alternar entre la capacidad de rendimiento y el uso de datos de escala según sea necesario. Para obtener más información acerca de los planes de precios, consulte [Planes](/docs/services/Cloudant?topic=cloudant-ibm-cloud-public#plans){: new_window}. Para crear el servicio, pulse el botón `Crear`: <br/>
    ![Crear el nombre de servicio y credenciales de {{site.data.keyword.cloudant_short_notm}} ](images/img0006.png)

5.  Aparece una página de servicio, que confirma que el nuevo servicio de {{site.data.keyword.cloudant_short_notm}} está disponible.
    Para crear la información de conexión que necesita la aplicación para conectar con el servicio, pulse el separador `Credenciales de servicio`:<br/>
    ![Creación de las credenciales del servicio{{site.data.keyword.cloudant_short_notm}} ](images/img0007.png)


6.  Cree una nueva credencial de servicio de {{site.data.keyword.cloudant_short_notm}}:
  <br>a. Pulse el botón `Nueva credencial`.
  <br>![Crear nuevas credenciales de servicio](images/img0050.png)
  <br>b. Especifique un nombre para la nueva credencial en la ventana Añadir nueva credencial. Véase la imagen.
  <br>c. Acepte el rol Gestor.
  <br>d. (Opcional) Cree un nuevo ID de servicio o haga que se cree uno automáticamente. 
  <br>d. (Opcional) Añada parámetros de configuración en línea. Tenga en cuenta que actualmente las credenciales de servicio de {{site.data.keyword.cloudant_short_notm}} no utilizan este parámetro; por lo tanto, ignórelo. 
  <br>e. Pulse el botón `Añadir`. </br>
  <br>![Añadir una nueva credencial de servicio](images/img0051.png)
  <br>La nueva credencial aparecerá después de la tabla.</br>
  <br>f. Pulse `Visualizar credenciales` en Acciones.
  <br>![Visualizar todas las credenciales de servicio](images/img0052.png)

7.  Aparecen los detalles de las credenciales de servicio:<br/>
    ![Credenciales de servicio de {{site.data.keyword.cloudant_short_notm}}](images/img0009.png)

Las credenciales de servicio de estos ejemplos se han definido durante la creación del servicio {{site.data.keyword.cloudant_short_notm}} de demostración en {{site.data.keyword.cloudant_short_notm}}. Aquí se reproducen las credenciales para mostrar cómo deben aparecer en el panel de control. Sin embargo, el servicio de {{site.data.keyword.cloudant_short_notm}} de demostración se ha eliminado, por lo que estas credenciales ya no son válidas; _debe_ especificar y utilizar sus propias credenciales de servicio.
{: note}

## Las credenciales de servicio
{: #the-service-credentials}

Las credenciales de servicio son muy valiosas. Si alguna persona o alguna aplicación tiene acceso a las credenciales, puede hacer lo que quiera con la instancia de servicio. Por ejemplo, podría crear datos falsos o suprimir información importante. Proteja bien estas credenciales.
    
{{site.data.keyword.cloudant_short_notm}} tiene dos métodos de autenticación disponibles en el tiempo de suministro: `Utilizar solo IAM` o `Utilizar credenciales heredadas y de IAM`. Puede ver los detalles sobre las credenciales heredadas solo si selecciona el método `Utilizar credenciales heredadas y de IAM`. Las credenciales se muestran en el separador Credenciales de servicio de la instancia. Para obtener más información, consulte la [guía de IAM](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-) y el documento de [autenticación heredada](/docs/services/Cloudant?topic=cloudant-authentication#authentication) para obtener detalles sobre el uso de cualquier estilo de autenticación.

Las credenciales de servicio incluyen los campos siguientes:

Campo | Finalidad
------|--------
`username` | El nombre de servicio del usuario de la instancia de servicio en el URL. Este campo también sirve como nombre de usuario del administrador. 
`password` | La contraseña de las credenciales heredadas que es necesaria para que las aplicaciones accedan a la instancia de servicio. Este campo solo se visualiza si se selecciona la opción `Utilizar credenciales heredadas y de IAM`. 
`host` | El nombre de host que utilizan las aplicaciones para localizar la instancia de servicio. Este campo solo se visualiza si se selecciona la opción `Utilizar credenciales heredadas y de IAM`. 
`port` | El número de puerto HTTPS para acceder a la instancia de servicio en el host. Es 443 ya que {{site.data.keyword.cloudant_short_notm}} solo permite el acceso HTTPS. Este campo solo se visualiza si se selecciona la opción `Utilizar credenciales heredadas y de IAM`. 
`url`	| El URL HTTPS para acceder a la instancia de {{site.data.keyword.cloudant_short_notm}}. Si se selecciona la opción `Utilizar las credenciales heredadas y de IAM`, también se incluye el nombre de usuario y contraseña heredados. 
`apikey` | La clave de API de IAM. 
`iam_apikey_description` | Descripción de la clave de API de IAM. 
`iam_apikey_name` | ID de la clave de API de IAM.
`iam_role_crn` | El rol de IAM que tiene la clave de API de IAM.
`iam_serviceid_crn`	| La CRN del ID de servicio.

Para crear una aplicación que pueda acceder a la instancia de servicio, necesita estas credenciales.

## Localización de las credenciales de servicio
{: #locating-your-service-credentials}

En cualquier momento, puede encontrar las credenciales correspondientes a un servicio que está asociado a su cuenta.

1.  Empiece por iniciar una sesión en {{site.data.keyword.cloud_notm}}.
    El panel de control de {{site.data.keyword.cloud_notm}} se puede encontrar en:
[https://cloud.ibm.com/ ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://cloud.ibm.com/){: new_window}.
    Después de autenticarse con su nombre de usuario y contraseña, aparecerá el panel de control de {{site.data.keyword.cloud_notm}}:<br/>
    ![{{site.data.keyword.cloud_notm}} panel de control](images/img0001.png)

2.  En este ejemplo,
    queremos encontrar las credenciales de servicio para la instancia de servicio de {{site.data.keyword.cloudant_short_notm}}
    que se ha creado anteriormente en la guía de aprendizaje,
    denominada `Cloudant-o7`. Pulse el icono **Menú** > **Lista de recursos** y la fila correspondiente:<br/>
    ![Selección del servicio {{site.data.keyword.cloudant_short_notm}} ](images/img0011.png)

3.  Para ver las credenciales necesarias para acceder al servicio,
pulse `Visualizar credenciales`:<br/>
    ![Visualización de las credenciales del servicio{{site.data.keyword.cloudant_short_notm}} ](images/img0052.png)


4.  Aparecen los detalles de las credenciales de servicio:<br/>
    ![Credenciales de servicio de {{site.data.keyword.cloudant_short_notm}}](images/img0009.png)

Las credenciales de servicio de estos ejemplos se han definido durante la creación del servicio {{site.data.keyword.cloudant_short_notm}} de demostración en {{site.data.keyword.cloudant_short_notm}}. Aquí se reproducen las credenciales para mostrar cómo deben aparecer en el panel de control. Sin embargo, el servicio de {{site.data.keyword.cloudant_short_notm}} de demostración se ha eliminado, por lo que estas credenciales ya no son válidas; _debe_ especificar y utilizar sus propias credenciales de servicio.
{: note}

