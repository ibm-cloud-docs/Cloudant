---

copyright:
  years: 2017, 2018
lastupdated: "2018-10-24"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:tip: .tip}

<!-- Acrolinx: 2017-05-10 -->

# Seguridad
{: #security}

## Protección y seguridad de los datos de {{site.data.keyword.cloudant_short_notm}} DBaaS
{: #ibm-cloudant-dbaas-data-protection-and-security}

La protección de datos de las aplicaciones de la web a gran escala y de apps para móviles puede resultar muy complejo, especialmente en el caso de bases de datos distribuidas
y NoSQL.

Además de reducir el esfuerzo necesario para mantener las bases de datos para que estén en activo y en crecimiento continuo, {{site.data.keyword.cloudantfull}} también garantiza la protección de los datos.
{:shortdesc}

## Plataformas físicas de nivel superior
{: #top-tier-physical-platforms}

{{site.data.keyword.cloudant_short_notm}} DBaaS se aloja físicamente en proveedores de infraestructura de nube de nivel 1 como {{site.data.keyword.cloud}} y Amazon.
Por lo tanto, los datos están protegidos por la red y por las medidas de seguridad física que emplean estos proveedores, incluidos (aunque sin limitarse a los mismos) los siguientes:

- Certificados: conformidad con SSAE16, SOC2 Tipo 1, ISAE 3402, ISO 27001, CSA y otros estándares.
- Gestión de acceso y de identidad.
- Seguridad física general de los centros de datos y supervisión del centro de operaciones de la red.
- Recuerdo del servidor.
- {{site.data.keyword.cloudant_short_notm}} le ofrece la flexibilidad de elegir o conmutar entre distintos proveedores a medida que cambiar su SLA y sus requisitos de coste.

Encontrará más información sobre las certificaciones disponibles en el apartado sobre [Información de conformidad](compliance.html).
{:tip}

## Control de acceso seguro
{: #secure-access-control}

{{site.data.keyword.cloudant_short_notm}} incluye varias funcionalidades de seguridad incorporadas para que controle el acceso a los datos:

Característica | Descripción
--------|------------
Autenticación | Se accede a {{site.data.keyword.cloudant_short_notm}} utilizando una API HTTPS. Si el punto final de la API lo requiere, se autentica al usuario para cada solicitud HTTPS que {{site.data.keyword.cloudant_short_notm}} recibe. {{site.data.keyword.cloudant_short_notm}} admite los controles de acceso IAM y los heredados. Para obtener más información, consulte la [guía de IAM](../guides/iam.html){:new_window} o el [documento de la API de autenticación](../api/authentication.html){:new_window} heredada.
Autorización | {{site.data.keyword.cloudant_short_notm}} admite los controles de acceso IAM y los heredados. Para obtener más información, consulte la [guía de IAM](../guides/iam.html){:new_window} o el [documento de la API de autorización](../api/authorization.html){:new_window} heredada.
Cifrado "al momento" | Todo el acceso a {{site.data.keyword.cloudant_short_notm}} está cifrado mediante HTTPS.
Cifrado en reposo | Todos los datos que se almacenan en una instancia de {{site.data.keyword.cloudant_short_notm}} se han cifrado en reposo. Si necesita BYOK (Bring-Your-Own-Key) para el cifrado en reposo, este se habilita utilizando {{site.data.keyword.cloud_notm}} Key
Protect. {{site.data.keyword.cloudant_short_notm}} da soporte a esta característica para nuevas instancias del plan de hardware dedicado de {{site.data.keyword.cloudant_short_notm}} desplegadas en todas las regiones. En primer lugar, cree una instancia del plan de hardware dedicado utilizando el catálogo de {{site.data.keyword.cloud_notm}}. A continuación, envíe una incidencia de soporte. Nuestro equipo de soporte coordina la obtención de las claves de cifrado cifradas en reposo de la instancia de hardware dedicado que están gestionadas por la instancia de Key Protect.
Lista blanca de IP | Los clientes de {{site.data.keyword.cloudant_short_notm}} que disponen de un entorno de {{site.data.keyword.cloudant_short_notm}} dedicado pueden elaborar una lista blanca de direcciones IP para restringir el acceso solo a los servidores y usuarios especificados. La lista blanca de IP no está disponible para ningún plan estándar/Lite público de {{site.data.keyword.cloud_notm}} desplegado en un entorno multiarrendatario. Abra una incidencia de soporte para solicitar listas blancas de IP para un conjunto especificado de IP o rangos de IP. Tenga en cuenta que las listas blancas de IP se aplican al panel de control y a la API de {{site.data.keyword.cloudant_short_notm}}, por lo que debe contemplar añadir cualquier IP de administrador que deba acceder al panel de control de {{site.data.keyword.cloudant_short_notm}} directamente. 
CORS | Habilitar el soporte CORS para determinados dominios mediante el panel de control de {{site.data.keyword.cloudant_short_notm}}.

<!--
> **Note**: Your data is visible to the {{site.data.keyword.cloudant_short_notm}} 
> worldwide team. If you don’t 
> want our team to see your data, encrypt it before sending it to 
> {{site.data.keyword.IBM_notm}}, and avoid leaking 
> data into your document `_id` and any attachment file names. In addition, 
> when you send personal data, you must use HTTPS to ensure that it is sent securely. 
> HTTP is no longer supported.  

> **Warning**: You are responsible for verifying that 
> {{site.data.keyword.cloudant_short_notm}} can be used to store 
> your data. You must also make sure that your data does not violate applicable 
> data protection laws or any regulations that require security measures 
> beyond those specified in the {{site.data.keyword.cloudant_short_notm}} 
> system requirements and {{site.data.keyword.cloud_notm}} Services terms. You must 
> verify that the security requirements are appropriate for any personal data 
> that is processed. If you are unsure, or intend to store data that is 
> beyond the scope of the {{site.data.keyword.cloudant_short_notm}} terms and conditions, 
> you must get approval from {{site.data.keyword.IBM_notm}} to ensure that it is 
> appropriate for {{site.data.keyword.cloudant_short_notm}} to store your data.
-->

## Protección contra la pérdida o daño de los datos
{: #protection-against-data-loss-or-corruption}

{{site.data.keyword.cloudant_short_notm}} dispone de diversas características que le ayudan a mantener la calidad y disponibilidad de los datos:

Característica | Descripción
--------|------------
Almacenamiento de datos redundante y duradero | Por defecto, {{site.data.keyword.cloudant_short_notm}} guarda en disco tres copias de cada documento en tres nodos distintos de un clúster. El hecho de guardar las copias garantiza que siempre esté disponible una copia de migración en caso de error en funcionamiento de los datos, independientemente del error que se haya producido.
Réplica y exportación de datos | Puede replicar las bases de datos continuamente entre clústeres en distintos centros de datos o en un clúster de {{site.data.keyword.cloudant_short_notm}} local o Apache CouchDB. Otra opción consiste en exportar los datos de {{site.data.keyword.cloudant_short_notm}} (en formato JSON)
a otras ubicaciones o fuentes (como su propio centro de datos) para aumentar la redundancia de los datos.
