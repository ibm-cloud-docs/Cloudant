---

copyright:
  years: 2017, 2019
lastupdated: "2019-03-06"

keywords: legacy access controls, api keys, enable iam, provisioning, how to choose between iam and legacy credentials, making requests, required client libraries, actions, endpoints, map actions to iam roles

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

# Gestión de identidad y de acceso (IAM) de {{site.data.keyword.cloud_notm}}
{: #ibm-cloud-identity-and-access-management-iam-}

La gestión de identidad y de acceso de {{site.data.keyword.cloud}} proporciona un enfoque unificado para gestionar las identidades de usuario, los servicios y el control de acceso.
{: shortdesc}

## Introducción
{: #introduction}

Este documento describe la integración de {{site.data.keyword.cloudantfull}} con la gestión de identidad y de acceso de {{site.data.keyword.cloud_notm}}. Trata las diferencias entre los controles de acceso heredados de {{site.data.keyword.cloudant_short_notm}} y los controles de acceso de IAM de {{site.data.keyword.cloud_notm}}. También analiza las ventajas y desventajas de cada unos de ellos para ayudarle a decidir cuál utilizar. A continuación, trata cómo utilizar IAM en bibliotecas de cliente de {{site.data.keyword.cloudant_short_notm}} y mediante llamadas HTTP. Por último, finaliza con una sección de referencias en la que se describen todas las acciones y roles de IAM de {{site.data.keyword.cloudant_short_notm}}.

Obtenga una visión general de [IAM ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://cloud.ibm.com/docs/iam/index.html#iamoverview){: new_window}, que incluye cómo:

- Gestionar usuarios e ID de servicio.
- Gestionar las credenciales disponibles.
- Utilizar políticas de acceso de IAM que permitan y revoquen el acceso a las instancias de servicio de {{site.data.keyword.cloudant_short_notm}}.

## Diferencias entre los controles de acceso de IAM y {{site.data.keyword.cloudant_short_notm}} Legacy
{: #differences-between-ibm-cloudant-legacy-and-iam-access-controls}

La sección siguiente proporciona una breve descripción general de las diferencias entre {{site.data.keyword.cloudant_short_notm}}
Legacy y los mecanismos de control de acceso de IAM de {{site.data.keyword.cloud_notm}}.

### Gestión de identidad y acceso de {{site.data.keyword.cloud_notm}}
{: #ibm-cloud-identity-and-access-management}

- Gestión de acceso gestionado de manera central en {{site.data.keyword.cloud_notm}}.
- Permitir a un usuario o servicio acceder a distintos recursos utilizando el mismo conjunto de credenciales (por ejemplo, el mismo usuario/contraseña o clave de API IAM).
- Es posible otorgar acceso a las claves de API IAM a las funciones de gestión de cuenta, como la creación de bases de datos nuevas.

### {{site.data.keyword.cloudant_short_notm}} Legacy
{: #ibm-cloudant-legacy}

- Exclusivo de {{site.data.keyword.cloudant_short_notm}}.
- El acceso a cada instancia de servicio requiere su propio conjunto de credenciales.
- Utiliza la autenticación básica HTTP con las credenciales que no están enlazadas a un servicio o usuario individual.
- Solo se pueden otorgar permisos a las claves de API de {{site.data.keyword.cloudant_short_notm}} a nivel de base de datos.

### Notas de clave de API
{: #api-key-notes}

En este documento, cuando se menciona a las claves de API, se hace referencia a las claves de API IAM.
{{site.data.keyword.cloudant_short_notm}} Legacy también tiene un concepto de claves de API y cualquier discusión acerca de las credenciales o combinaciones de nombre de usuario/contraseña heredadas de {{site.data.keyword.cloudant_short_notm}} incluye también claves de API de {{site.data.keyword.cloudant_short_notm}}. 

## Habilitación de IAM con {{site.data.keyword.cloudant_short_notm}}
{: #enabling-iam-with-ibm-cloudant}

Solo se podrán utilizar las nuevas instancias de servicio de {{site.data.keyword.cloudant_short_notm}} con IAM de {{site.data.keyword.cloud_notm}} a partir de finales de julio de 2018.

Todas las instancias de servicio nuevas de {{site.data.keyword.cloudant_short_notm}} podrán utilizar IAM cuando se suministre. De forma opcional, también puede habilitar el mecanismo de autenticación heredado.  Al suministrar una nueva instancia de {{site.data.keyword.cloudant_short_notm}} del catálogo de {{site.data.keyword.cloud_notm}}, elija entre los métodos de autenticación disponibles:

1. **Utilizar credenciales heredadas y de IAM**: Este modo implica que es posible utilizar las credenciales heredadas y de IAM parpara acceder a la cuenta. En concreto, se proporcionan conjuntos de credenciales heredadas y de IAM para todas las aplicaciones vinculadas las credenciales de servicio y cuenta generadas.
2. **Utilizar solo IAM**: Este modo implica que únicamente se suministran credenciales de IAM mediante un enlace de servicio y la generación de credenciales.

### Claves de API de {{site.data.keyword.cloudant_short_notm}} y _Utilizar solo IAM_
{: #ibm-cloudant-api-keys-and-_use-only-iam_}

Es posible utilizar claves de API de {{site.data.keyword.cloudant_short_notm}} junto con IAM, pero **no se recomienda**. Se hace esta recomendación puesto que las claves de API y los permisos de {{site.data.keyword.cloudant_short_notm}} no son visibles y no se pueden gestionar mediante la interfaz de política IAM, lo que hace que no sea posible la gestión de acceso holística.

La elección entre _Utilizar solo IAM_ o _Utilizar credenciales heredadas y de IAM_ afecta a:

1. Si las credenciales heredadas a nivel de cuenta de {{site.data.keyword.cloudant_short_notm}} están disponibles para gestionar bases de datos y otras acciones a nivel de cuenta.
2. El estilo de credenciales que se entregan durante la generación de credenciales de servicio.

En particular, las claves de API de {{site.data.keyword.cloudant_short_notm}} pueden utilizarse para gestionar el acceso a la base de datos. Dichas credenciales deben generarse y configurarse mediante la API HTTP.

### Suministro mediante la línea de mandatos
{: #provisioning-by-using-the-command-line}

Al suministrar una nueva instancia de {{site.data.keyword.cloudant_short_notm}} desde la línea de mandatos, proporcione una opción a la herramienta `ic`
utilizando el parámetro `-p` para habilitar o inhabilitar las credenciales heredadas de una cuenta. La opción se pasa en formato JSON y se denomina `legacyCredentials`.

Para suministrar una instancia como _Utilizar solo IAM_ (recomendado), ejecute el mandato siguiente:

```sh
ic resource service-instance-create  "Instance Name" \
    cloudantnosqldb Standard us-south \
    -p {"legacyCredentials": false}
```

Para suministrar una instancia como _Utilizar credenciales heredadas y de IAM_, ejecute el mandato siguiente:

```sh
ic resource service-instance-create  "Instance Name" \
    cloudantnosqldb Standard us-south \
    -p {"legacyCredentials": true}
```

### Ejemplos JSON de credenciales de servicio para cada opción
{: #service-credential-json-examples-for-each-option}

La elección entre el control de acceso _Utilizar solo IAM_ y _Utilizar credenciales heredadas y de IAM_ afecta a la manera en la que las credenciales se entregan a la aplicación al vincular y generar credenciales de servicio. Al generar credenciales en la interfaz de IAM de {{site.data.keyword.cloud_notm}} primaria, se muestran las claves de API de dicha interfaz una vez generadas.

También puede generar credenciales desde la sección Credenciales de servicio de una instancia de servicio. Este tipo de generación de credenciales de servicio crea un blob JSON de credenciales de servicio que se puede pegar a las aplicaciones con todos los detalles necesarios para acceder a la instancia de servicio.

Esta sección muestra el aspecto que presenta el JSON de credenciales de servicio y lo que significa cada valor.

Al seleccionar _Utilizar solo IAM_, las credenciales de servicio que se generan contienen únicamente valores IAM y presentan el mismo aspecto que el que observamos en el ejemplo siguiente:

```json
{
  "apikey": "MxVp86XHkU82Wc97tdvDF8qM8B0Xdit2RqR1mGfVXPWz",
  "iam_apikey_description": "Auto generated apikey during resource-key [...]",
  "iam_apikey_name": "auto-generated-apikey-050d21b5-5f[...]",
  "iam_role_crn": "crn:v1:bluemix:public:iam::::serviceRole:Manager",
  "iam_serviceid_crn": "crn:v1:staging:public:iam-identity::[...]",
  "url": "https://76838001-b883-444d-90d0-46f89e942a15-bluemix.cloudant.com",
  "username": "76838001-b883-444d-90d0-46f89e942a15-bluemix"
}
```

Cada valor del ejemplo JSON anterior debe interpretarse de la manera siguiente:

- `apikey`: Clave de API de IAM.
- `iam_apikey_description`: Descripción de la clave de API de IAM.
- `iam_apikey_name`: ID de la clave de API de IAM.
- `iam_role_crn`: Rol IAM que tiene la clave de API de IAM.
- `iam_serviceid_crn`: CRN del ID de servicio.
- `url`: URL de servicio de {{site.data.keyword.cloudant_short_notm}}.
- `username`: nombre interno de la cuenta de {{site.data.keyword.cloudant_short_notm}}.

Al seleccionar _Utilizar credenciales heredadas y de IAM_, las credenciales de servicio que se generan contienen credenciales heredadas y de IAM y presentan un aspecto como el siguiente:

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

Cada valor del ejemplo JSON anterior debe interpretarse de la manera siguiente:

- `apikey`: Clave de API de IAM.
- `host`: Nombre de host del servicio de {{site.data.keyword.cloudant_short_notm}}.
- `iam_apikey_description`: Descripción de la clave de API de IAM.
- `iam_apikey_name`: ID de la clave de API de IAM.
- `iam_role_crn`: Rol IAM que tiene la clave de API de IAM.
- `iam_serviceid_crn`: CRN del ID de servicio.
- `password`: Contraseña de credencial de {{site.data.keyword.cloudant_short_notm}} Legacy.
- `port`: Puerto de servicio de {{site.data.keyword.cloudant_short_notm}}.
- `url`: URL de servicio de {{site.data.keyword.cloudant_short_notm}}, incluidas las credenciales de {{site.data.keyword.cloudant_short_notm}} Legacy.
- `username`: El nombre de usuario de credencial de {{site.data.keyword.cloudant_short_notm}} Legacy.

## ¿Debería usar _Utilizar solo IAM_ o _Utilizar credenciales heredadas y de IAM_?
{: #should-i-use-_use-only-iam_-or-_use-both-legacy-credentials-and-iam_-}

Si es posible, es preferible usar _Utilizar solo IAM_. Entre las principales ventajas de utilizar IAM de {{site.data.keyword.cloud_notm}} se incluyen:

- La gestión de acceso a {{site.data.keyword.cloudant_short_notm}} con la herramienta estándar de {{site.data.keyword.cloud_notm}} en lugar de una combinación de la gestión de credenciales específica de {{site.data.keyword.cloud_notm}} y {{site.data.keyword.cloudant_short_notm}}.
- Las credenciales se pueden revocar y rotar al utilizar IAM de {{site.data.keyword.cloud_notm}}.

A continuación, se describe con más detalle las ventajas y desventajas de cada enfoque.

### Ventajas y desventajas de los dos mecanismos de control de acceso
{: #advantages-and-disadvantages-of-the-two-access-control-mechanisms}

En general, IAM de {{site.data.keyword.cloud_notm}} es el modelo de autenticación recomendado. Sin embargo, existen desventajas en este enfoque, principalmente, si dispone de una aplicación existente o si no puede utilizar una biblioteca de cliente con soporte de {{site.data.keyword.cloudant_short_notm}}.

<table>

<tr>
<th id="mode">Modo</th>
<th id="advantages">Ventajas</th>
<th id="disadvantages">Desventajas</th>
</tr>

<tr>
<td headers="mode">IAM</td>
<td headers="advantages" valign="top"><ul><li>Gestionar el acceso para muchos servicios utilizando una interfaz. Revocar el acceso a un usuario globalmente.</li>
<li>Claves de API a nivel de cuenta mediante ID de servicio.</li>
<li>Credenciales fáciles de rotar.</li>
<li>Los registros de Activity Tracker capturan servicios y personas individuales.</li>
<li>IAM se une a otros sistemas de identidad, como los repositorios LDAP de empresa.</li></ul>
</td>
<td headers="disadvantages"><ul><li>Si no utiliza bibliotecas soportadas de {{site.data.keyword.cloudant_short_notm}}, es posible que se requieran cambios en la aplicación para utilizar señales de acceso y claves de API de IAM.</li>
<li>No hay permisos a nivel de base de datos (todavía).</li>
<li>No hay permisos precisos (por ejemplo, lector) (todavía).</li>
<li>Algunos puntos finales no están disponibles, consulte [Puntos finales no disponibles](#unavailable-endpoints).</li>
<li>No hay forma de especificar una base de datos como "pública", es decir, no se requiere un usuario autorizado para el acceso.</li></ul>
</td>
</tr>

<tr>
<td headers="mode">Legacy</td>
<td headers="advantages">
<ul><li>No es necesario modificar aplicaciones existentes o dependencias de biblioteca de cliente.</li>
<li>Permisos a nivel de base de datos.</li>
<li>Roles precisos (lector, escritor).</li>
</ul>
</td>
<td headers="disadvantages">
<ul><li>No hay claves de API a nivel de cuenta; debe utilizar credenciales `raíz` para gestionar bases de datos.</li>
<li>Gestión separada de credenciales de {{site.data.keyword.cloudant_short_notm}}, por lo que no es posible obtener una visión general completa de todo el acceso dentro de la interfaz centralizada.</li>
<li>Difícil de implementar la rotación de credenciales.</li>
</ul>
</td>
</tr>
</table>

## Realización de solicitudes a instancias mediante credenciales de IAM
{: #making-requests-to-instances-by-using-iam-credentials}

En esta sección se describe cómo utilizar {{site.data.keyword.cloudant_short_notm}} con instancias de servicio mediante la autenticación de IAM y el control de acceso. Se utilizan los detalles del ejemplo JSON de credenciales de servicio mencionado anteriormente.

IAM de {{site.data.keyword.cloud_notm}} requiere que se intercambie una clave de API de IAM por una señal de acceso de tiempo limitado antes de realizar una solicitud a un recurso o servicio. La señal de acceso se incluye en la cabecera HTTP `Autorización` para el servicio. Cuando la señal de acceso caduca, la aplicación consumidora debe manejar la obtención de una nueva del servicio de señal de IAM. Para obtener más información, consulte la documentación [Obtención de una señal de IAM de {{site.data.keyword.cloud_notm}} mediante una clave de API ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://cloud.ibm.com/docs/iam/apikey_iamtoken.html#iamtoken_from_apikey) para obtener más detalles.

Las bibliotecas de cliente oficiales de {{site.data.keyword.cloudant_short_notm}} manejan la obtención de una señal a partir de una clave de API. Si accede a {{site.data.keyword.cloudant_short_notm}} directamente utilizando un cliente HTTP en lugar de una biblioteca de cliente de {{site.data.keyword.cloudant_short_notm}}, debe manejar el intercambio y la renovación de una señal de acceso de tiempo limitado utilizando una clave de API de IAM con el servicio de señal de IAM. Después de que la señal caduque, {{site.data.keyword.cloudant_short_notm}} devuelve un código de estado HTTP `401`.

### Versiones de biblioteca de cliente necesarias
{: #required-client-library-versions}

Utilice, como mínimo, las versiones de biblioteca de cliente siguientes con las instancias de servicio de {{site.data.keyword.cloudant_short_notm}} habilitadas para IAM:

| Biblioteca | Recomendado |
| --- | --- |
| [java-cloudant](https://github.com/cloudant/java-cloudant) | 2.13.0+ |
| [nodejs-cloudant](https://github.com/cloudant/nodejs-cloudant) | 2.3.0+ |
| [python-cloudant](https://github.com/cloudant/python-cloudant) | 2.9.0+ |
| [couchbackup](https://github.com/cloudant/couchbackup/) | 2.3.1+ |
| [CDTDatastore](https://github.com/cloudant/cdtdatastore/) | 2.0.3+ |
| [sync-android](https://github.com/cloudant/sync-android/) | 2.2.0+ |

Los fragmentos de código siguientes requieren estas versiones.

### Java
{: #java}

Requiere [java-cloudant](https://github.com/cloudant/java-cloudant), 2.13.0+.

Utilice el método `iamApiKey()` para crear un cliente de base de datos con una clave de API de IAM:

```java
package com.mycompany.app;

import com.cloudant.client.api.ClientBuilder;
import com.cloudant.client.api.CloudantClient;


public class App
{
    public static void main( String[] args )
    {
        CloudantClient client = ClientBuilder
                .account("76838001-b883-444d-90d0-46f89e942a15-bluemix")
                .iamApiKey("MxVp86XHkU82Wc97tdvDF8qM8B0Xdit2RqR1mGfVXPWz")
                .build();

        for (String db : client.getAllDbs()) {
            System.out.println(db);
        }
    }
}
```

### Node.js
{: #node.js}

Requiere [nodejs-cloudant](https://github.com/cloudant/nodejs-cloudant), 2.3.0+.

Utilice el plugin `iamauth` para crear un cliente de base de datos con una clave de API de IAM:

```js
var Cloudant = require('@cloudant/cloudant');

var cloudant = new Cloudant({
  account: '76838001-b883-444d-90d0-46f89e942a15-bluemix',
  plugins: {
    iamauth: {
      iamApiKey: 'MxVp86XHkU82Wc97tdvDF8qM8B0Xdit2RqR1mGfVXPWz'
    }
  }
});
cloudant.db.list(function(err, body) {
  body.forEach(function(db) {
    console.log(db);
  });
});
```

### Python
{: #python}

Requiere [python-cloudant](https://github.com/cloudant/python-cloudant), 2.9.0+.

Utilice el método `Cloudant.iam(account_name, api_key, **kwargs)` para crear un cliente de base de datos con una clave de API de IAM:

```python
from cloudant.client import Cloudant

client = Cloudant.iam(
    "76838001-b883-444d-90d0-46f89e942a15-bluemix",
    "MxVp86XHkU82Wc97tdvDF8qM8B0Xdit2RqR1mGfVXPWz",
    connect=True
)
print client.all_dbs()
```

### Acceso mediante el cliente HTTP
{: #access-by-using-http-client}

IAM de {{site.data.keyword.cloud_notm}} requiere que se intercambie una clave de API de IAM por una señal de acceso de tiempo limitado antes de realizar una solicitud a un recurso o servicio. La señal de acceso se incluye en la cabecera HTTP `Autorización` para el servicio. Cuando la señal de acceso caduca, el cliente debe manejar la obtención de una nueva del servicio de señal de IAM.

Tal como se ha indicado anteriormente, la utilización de IAM de {{site.data.keyword.cloud_notm}} requiere que primero cambie una clave de API de {{site.data.keyword.IBM_notm}} por una señal de acceso de tiempo limitado y que utilice la señal para autenticarse en la API de {{site.data.keyword.cloudant_short_notm}}.

En Python, un ejemplo podría ser el siguiente:

```python
import time

import requests

API_KEY = "MxVp86XHkU82Wc97tdvDF8qM8B0Xdit2RqR1mGfVXPWz"
ACCOUNT = "76838001-b883-444d-90d0-46f89e942a15-bluemix"

def get_access_token(api_key):
    """Retrieve an access token from the IAM token service."""
    token_response = requests.post(
        "https://iam.cloud.ibm.com/identity/token",
        data={
            "grant_type": "urn:ibm:params:oauth:grant-type:apikey",
            "response_type": "cloud_iam",
            "apikey": api_key
        },
        headers={
            "Accept": "application/json"
        }
    )
    if token_response.status_code == 200:
        print "Got access token from IAM"
        return token_response.json()['access_token']
    else:
        print token_response.status_code, token_response.json()
        return None

def main(api_key, account):
    access_token = None
    while True:
        if not access_token:
            access_token = get_access_token(api_key)

        if access_token:
            response = requests.get(
                "https://{0}.cloudant.com/_all_dbs".format(account),
                headers={
                    "Accept": "application/json",
                    "Authorization": "Bearer {0}".format(access_token)
                }
            )
            print "Got Cloudant response, status code", response.status_code
            if response.status_code == 401:
                print "Token has expired."
                access_token = None

        time.sleep(1)

if __name__ == "__main__":
    main(API_KEY, ACCOUNT)
```

## Referencia
{: #reference}

Esta sección contiene una lista completa de las acciones de IAM de {{site.data.keyword.cloudant_short_notm}} y las acciones que están permitidas para cada rol de sistema IAM.

### Acciones de {{site.data.keyword.cloudant_short_notm}}
{: #ibm-cloudant-actions}

Acción | Descripción
-------|------------
`cloudant.db.any` | Acceso a cualquier punto final de la base de datos (a aquellos cuya vía de acceso no empieza con `/_api`).
`cloudantnosqldb.sapi.dbsecurity` | Acceso a `/_api/v2/db/<path:db>/_security`.
`cloudantnosqldb.sapi.usercors` | Acceso a `/_api/v2/user/config/cors/`.
`cloudantnosqldb.sapi.apikeys` | Acceso a `/_api/v2/api_keys`.
`cloudantnosqldb.sapi.userinfo` | Acceso a `/_api/v2/user`.

#### Puntos finales no disponibles
{: #unavailable-endpoints}

Los puntos finales siguientes no están disponibles para las solicitudes autorizadas con IAM:

- Controladores de reescritura HTTP: `/db/_design/design-doc/_rewrite/path`. <br>
A pesar de que los documentos de diseño pueden contener controladores de reescritura, los usuarios no pueden llamarlos.
- Actualizar controladores: `POST /{db}/_design/{ddoc}/_update/{func}`. <br>
Aunque los documentos de diseño pueden contener funciones de actualización, los usuarios no pueden llamarlos.

### Asignación de acciones de {{site.data.keyword.cloudant_short_notm}} a roles de IAM
{: #mapping-of-ibm-cloudant-actions-to-iam-roles}

Solo los usuarios y servicios con el rol de Gestor pueden acceder a los datos de {{site.data.keyword.cloudant_short_notm}}.

Rol | Acciones permitidas
-----|----------------
Gestor | Todas las acciones documentadas.
Lector | Ninguno.
Escritor | Ninguno.

## Resolución de problemas
{: #troubleshooting}
Si tiene problemas al utilizar IAM para autenticarse al realizar solicitudes a la instancia de servicio de {{site.data.keyword.cloudant_short_notm}}, verifique la cuenta tal como se indica en la sección siguiente.

### Asegúrese de que la cuenta está habilitada para IAM
{: #ensure-your-account-is-iam-enabled}

Debe abrir una incidencia de soporte para confirmar que se ha habilitado para IAM una instancia de servicio.
