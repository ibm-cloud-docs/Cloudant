---

copyright:
  years: 2017
lastupdated: "2017-07-13"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-04-28 -->

# Seguridad 

## Protección y seguridad de los datos de Cloudant DBaaS

La protección de datos de las aplicaciones de la web a gran escala y de apps para móviles puede resultar muy complejo, especialmente en el caso de bases de datos distribuidas
y NoSQL. 

Además de reducir el esfuerzo necesario para mantener las bases de datos para que estén en activo y en crecimiento continuo, {{site.data.keyword.cloudantfull}} también garantiza la protección de los datos. 

## Plataformas físicas de nivel superior

{{site.data.keyword.cloudant_short_notm}} DBaaS se aloja físicamente en proveedores de infraestructura de nube de nivel 1 como {{site.data.keyword.BluSoftlayer_full}} y Amazon.
Por lo tanto, los datos están protegidos por la red y por las medidas de seguridad física que emplean estos proveedores, incluidos (aunque sin limitarse a los mismos) los siguientes: 

- Certificados: conformidad con SSAE16, SOC2 Tipo 1, ISAE 3402, ISO 27001, CSA y otros estándares. 
- Gestión de acceso y de identidad. 
- Seguridad física general de los centros de datos y supervisión del centro de operaciones de la red. 
- Recuerdo del servidor. 
- {{site.data.keyword.cloudant_short_notm}} le ofrece la flexibilidad de elegir o conmutar entre distintos proveedores a medida que cambiar su SLA y sus requisitos de coste. 

> **Nota:** Encontrará más información sobre las certificaciones disponibles en el apartado sobre [Información de conformidad](compliance.html).

## Control de acceso seguro

{{site.data.keyword.cloudant_short_notm}} incluye varias características de seguridad para que controle el acceso a los datos: 

- Autenticación: se accede a {{site.data.keyword.cloudant_short_notm}} mediante una API HTTP. Si el punto final de la API lo requiere, se autentica al usuario para cada solicitud HTTPS o HTTP que {{site.data.keyword.cloudant_short_notm}} recibe. 
- Autorización: se otorgan permisos de lectura, escritura y administración a bases de datos específicas. 
- Cifrado "al momento": todo el acceso a {{site.data.keyword.cloudant_short_notm}} se cifra mediante HTTPS.
- Cifrado en reposo: los datos almacenados en disco en {{site.data.keyword.cloudant_short_notm}} se pueden cifrar. 
  > **Nota**: Los datos almacenados en una instancia de {{site.data.keyword.Bluemix_notm}} {{site.data.keyword.cloudant_short_notm}} siempre están cifrados. 
- Acceso a API: se accede a {{site.data.keyword.cloudant_short_notm}} mediante programación utilizando una API sobre HTTP seguro(HTTPS).
  Las claves de API se pueden generar mediante el panel de control de {{site.data.keyword.cloudant_short_notm}}. 
- Lista blanca de IP: los clientes de {{site.data.keyword.cloudant_short_notm}} de entornos dedicados pueden elaborar una lista blanca de direcciones IP para restringir el acceso solo a los servidores y usuarios especificados. 
- CORS: habilitación del soporte CORS para determinados dominios mediante el panel de control de {{site.data.keyword.cloudant_short_notm}}.  

## Protección contra la pérdida o daño de los datos

{{site.data.keyword.cloudant_short_notm}} dispone de diversas características que le ayudan a mantener la calidad y disponibilidad de los datos: 

- Almacenamiento de datos redundante y duradero: de forma predeterminada, {{site.data.keyword.cloudant_short_notm}} guarda en disco tres copias de cada documento en tres nodos diferentes de un clúster. El hecho de guardar las copias garantiza que siempre esté disponible una copia de migración en caso de error en funcionamiento de los datos, independientemente del error que se haya producido. 
- Réplica y exportación de los datos: puede realizar una réplica de las bases de datos continuamente entre los clústeres de distintos centros de datos o en un clúster de Cloudant local o Apache CouchDB. Otra opción consiste en exportar los datos de {{site.data.keyword.cloudant_short_notm}} (en formato JSON)
a otras ubicaciones o fuentes (como su propio centro de datos) para aumentar la redundancia de los datos. 
