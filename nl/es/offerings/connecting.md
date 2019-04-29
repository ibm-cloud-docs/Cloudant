---

copyright:
  years: 2019
lastupdated: "2019-03-18"

keywords: endpoints, service credentials, authentication, ibm cloudant dashboard, curl, client libraries

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

<!-- Acrolinx: 2018-07-02 -->

# Conexión
{: #connecting}

Se accede a {{site.data.keyword.cloudantfull}} a través de una API HTTP. En este documento se describen los distintos componentes que puede utilizar para conectarse a {{site.data.keyword.cloudant_short_notm}}:
- Puntos finales
- Credenciales de servicio
- Autenticación
- Acceso al panel de control de {{site.data.keyword.cloudant_short_notm}}
- Acceso mediante programación a {{site.data.keyword.cloudant_short_notm}} a través de [curl ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://curl.haxx.se/){: new_window} o de bibliotecas de cliente
{: shortdesc}

## Puntos finales
{: #endpoints}

Se accede a {{site.data.keyword.cloudant_short_notm}} a través de puntos finales de API HTTP. Los puntos finales para una instancia se muestran tanto en el campo de URL de las credenciales de servicio generadas para la instancia como en el separador **Cuenta** > **Valores** del panel de control de {{site.data.keyword.cloudant_short_notm}}.

Se debe acceder a todos los puntos finales HTTP de {{site.data.keyword.cloudant_short_notm}} a través de TLS, por lo que deben llevar como prefijo `https://`.

El punto final externo visible públicamente es:

`https://USERNAME.cloudant.com`

Todas las instancias suministradas después del 1 de enero de 2019 incluyen un punto final de dominio appdomain.cloud. El punto final externo visible públicamente es:

`https://USERNAME.cloudantnosqldb.appdomain.cloud`

Se añaden puntos finales internos a todas las instancias desplegadas en entornos de hardware dedicado suministrados después del 1 de enero de 2019 fuera del entorno gestionado por la UE. El punto final de red interno de {{site.data.keyword.cloud_notm}} es:

`https://USERNAME.private.cloudantnosqldb.appdomain.cloud`

Donde USERNAME es el nombre de servicio del usuario de la instancia de servicio en el URL. Este campo sirve también como nombre de usuario administrador al utilizar la autenticación heredada de {{site.data.keyword.cloudant_short_notm}}. Un USERNAME de ejemplo es
de810d0e-763f-46a6-ae88-50823dc85581-bluemix, y el punto final externo de ejemplo resultante sería
de810d0e-763f-46a6-ae88-50823dc85581-bluemix.cloudantnosqldb.appdomain.cloud. 

## Credenciales de servicio
{: #service-credentials}

Para generar credenciales de servicio para {{site.data.keyword.cloudant_short_notm}} a través del panel de control de {{site.data.keyword.cloud_notm}}, consulte la guía de aprendizaje [Creación de una instancia de {{site.data.keyword.cloudant_short_notm}} en {{site.data.keyword.cloud_notm}}](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud#creating-an-ibm-cloudant-instance-on-ibm-cloud). Para generar credenciales de servicio desde la CLI de {{site.data.keyword.cloud_notm}}, consulte [Creación de credenciales para el servicio {{site.data.keyword.cloudant_short_notm}}](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud-by-using-the-ibm-cloud-cli#creating-an-ibm-cloudant-instance-on-ibm-cloud-by-using-the-ibm-cloud-cli). 

A continuación se muestra un ejemplo de credenciales de servicio para una instancia de {{site.data.keyword.cloudant_short_notm}}:

```json
{
  "apikey": "MxVp86XHkU82Wc97tdvDF8qM8B0Xdit2RqR1mGfVXPWz",
  "host": "76838001-b883-444d-90d0-46f89e942a15-bluemix.cloudant.com",
  "iam_apikey_description": "Auto generated apikey during resource-key [...]",
  "iam_apikey_name": "auto-generated-apikey-050d21b5-5f[...]",
  "iam_role_crn": "crn:v1:bluemix:public:iam::::serviceRole:Manager",
  "iam_serviceid_crn": "crn:v1:staging:public:iam-identity::[...]",
  "password": "8fb6a16b48903e87b769e7f4968521e85c2394ed8f0e69b2769e56dcb27d2e76",
  "port": 443,
  "url": "https://<username>:<password>@76838001-b883-444d-90d0-46f89e942a15-bluemix.cloudant.com",
  "username": "76838001-b883-444d-90d0-46f89e942a15-bluemix"
}
```
{: codeblock}

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

## Autenticación
{: #authentication-overview}

{{site.data.keyword.cloudant_short_notm}} tiene dos métodos de autenticación disponibles en el tiempo de suministro: `Utilizar solo IAM` o `Utilizar credenciales heredadas y de IAM`. Puede ver los detalles sobre las credenciales heredadas en las credenciales de servicio únicamente si se ha elegido el método de autenticación `Utilizar credenciales heredadas y de IAM`. Las credenciales se muestran en el separador Credenciales de servicio de la instancia. Para obtener más información, consulte la [guía de IAM](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-) y el documento de [autenticación heredada](/docs/services/Cloudant?topic=cloudant-authentication#authentication) para obtener detalles sobre el uso de cualquier estilo de autenticación.
 
El equipo de {{site.data.keyword.cloudant_short_notm}} recomienda el uso de controles de acceso de IAM para la autenticación siempre que sea posible. Si utiliza la autenticación heredada de {{site.data.keyword.cloudant_short_notm}}, se recomienda que utilice [claves de API](/docs/services/Cloudant?topic=cloudant-authorization#api-keys){: new_window} en lugar de credenciales a nivel de cuenta para el acceso mediante programación y los trabajos de réplica.
{: important}

## Panel de control de {{site.data.keyword.cloudant_short_notm}}
{: #ibm-cloudant-dashboard}

Puede abrir el panel de control de {{site.data.keyword.cloudant_short_notm}} de la instancia accediendo al separador Gestionar de la página de detalles de la instancia del panel de control de {{site.data.keyword.cloud_notm}}. Puede utilizar el botón `Iniciar` o `Iniciar el panel de control de Cloudant` para abrir el panel de control en un nuevo separador de navegador. El panel de control de {{site.data.keyword.cloudant_short_notm}} le permite realizar las tareas siguientes:

- Supervisar el consumo actual de la instancia
- Realizar operaciones CRUD (crear, leer, actualizar, suprimir) sobre índices, documentos y bases de datos de {{site.data.keyword.cloudant_short_notm}}
- Configurar y visualizar trabajos de réplica
- Ver las tareas activas
- Ver y actualizar información de cuenta como la capacidad de rendimiento suministrada, anuncios, CORS y valores

## Acceso programático
{: #programmatic-access}

### Línea de mandatos (curl)
{: #command-line-curl-}

Puede hacer uso del programa de utilidad de línea de mandatos curl para acceder a la API HTTPS de {{site.data.keyword.cloudant_short_notm}}. 

Si utiliza la autenticación heredada de {{site.data.keyword.cloudant_short_notm}}, consulte la [Visión general de la referencia de la API](/docs/services/Cloudant?topic=cloudant-api-reference-overview#api-reference-overview) para obtener detalles sobre cómo proporcionar un nombre de usuario y una contraseña para acceder a la API de {{site.data.keyword.cloudant_short_notm}} con curl tal como se muestra en los ejemplos de la referencia de la API.

Si utiliza la autenticación de IAM de {{site.data.keyword.cloud_notm}}, en primer lugar debe obtener una señal de IAM de {{site.data.keyword.cloud_notm}} mediante el uso de una clave de API. A continuación, puede pasar la señal de IAM a la instancia de {{site.data.keyword.cloudant_short_notm}} para autenticarse. Consulte la guía de aprendizaje [Cómo pasar una señal de IAM de {{site.data.keyword.cloud_notm}} con una API de servicio](https://cloud.ibm.com/docs/services/iam?topic=iam-iamapikeysforservices#token_auth){: new_window}. 

No puede utilizar una clave de API de IAM directamente para autenticarse en {{site.data.keyword.cloudant_short_notm}}.
{: note}

### Bibliotecas de cliente
{: #client-libraries-overview}

{{site.data.keyword.cloudant_short_notm}} tiene bibliotecas de cliente oficiales para Java, Node.js, Python, Swift y Mobile. Para obtener más información, consulte la [documentación de las bibliotecas de cliente](/docs/services/Cloudant?topic=cloudant-client-libraries#client-libraries) para acceder a las bibliotecas y ver ejemplos para conectarse a una instancia de {{site.data.keyword.cloudant_short_notm}} desde cada una de ellas. 
