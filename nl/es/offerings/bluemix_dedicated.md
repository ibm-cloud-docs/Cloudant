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

# {{site.data.keyword.cloud_notm}} dedicado

{{site.data.keyword.cloudantfull}} para ({{site.data.keyword.cloud}} dedicado) es
un complemento de compra opcional para un entorno {{site.data.keyword.cloud_notm}} dedicado. El precio del complemento opcional para {{site.data.keyword.cloudant_short_notm}} dedicado en {{site.data.keyword.cloud_notm}} dedicado se basa en la capacidad del hardware
asignado al entorno, y puede adquirirlo poniéndose en contacto con el representante de ventas de {{site.data.keyword.IBM}}.  

Los clientes de {{site.data.keyword.cloud_notm}} dedicado también pueden elegir si desean utilizar {{site.data.keyword.cloudant_short_notm}} en {{site.data.keyword.cloud_notm}} público
a través del catálogo sindicado, incluidas las instancias del plan Lite y Estándar. Tenga en cuenta que los usuarios de
{{site.data.keyword.cloud_notm}} dedicado no son elegibles para adquirir el plan de hardware dedicado desde el catálogo público de
{{site.data.keyword.cloud_notm}} y, en caso de que el hardware dedicado sea necesario, deberán optimizar {{site.data.keyword.cloudant_short_notm}} dedicado en
{{site.data.keyword.cloud_notm}} dedicado.   

La instantánea siguiente muestra un ejemplo de catálogo de {{site.data.keyword.cloud_notm}} que resalta la versión sindicada de {{site.data.keyword.cloud_notm}} público
de {{site.data.keyword.cloudant_short_notm}} (izquierda) y el entorno {{site.data.keyword.cloudant_short_notm}} dedicado (derecha).  

![catálogo de {{site.data.keyword.cloudant_short_notm}} ](../images/bluemix_catalog.png)

## Capacidad de hardware 

{{site.data.keyword.cloudant_short_notm}} en {{site.data.keyword.cloud_notm}} dedicado se adquiere mediante una parte de la 'capacidad de 1,6 TB de {{site.data.keyword.cloudant_short_notm}} en {{site.data.keyword.cloud_notm}} dedicado', que incluye un entorno {{site.data.keyword.cloudant_short_notm}} en clúster
que consiste en tres nodos de base de datos y dos equilibradores de carga. Cada nodo de base de datos contiene 1.6 TB de SSD y, cómo todos los datos se almacenan por triplicado, se asocia al 1.6 TB de espacio de disco exclusivo en el clúster. La expansión de un entorno puede lograrse adquiriendo partes de 'capacidad de 1,6 TB de {{site.data.keyword.cloudant_short_notm}} en {{site.data.keyword.cloud_notm}} dedicado', que puede utilizarse para expandir el
clúster de {{site.data.keyword.cloudant_short_notm}} en múltiplos de tres nodos de base de datos. Los clientes también pueden elegir si desean tener varios entornos de {{site.data.keyword.cloudant_short_notm}} independientes en lugar de expandir un entorno único.

## Ubicaciones y arrendamiento 

El entorno {{site.data.keyword.cloudant_short_notm}} dedicado de un entorno {{site.data.keyword.cloud_notm}} dedicado se encuentra en un hardware diseñado para uso exclusivo del cliente de {{site.data.keyword.cloud_notm}} dedicado. El cliente puede proporcionar una o varias instancias de {{site.data.keyword.cloudant_short_notm}} en el entorno determinado, y cada instancia de {{site.data.keyword.cloudant_short_notm}}
comparte los recursos de hardware subyacentes que forman el entorno {{site.data.keyword.cloudant_short_notm}}. 

## Seguridad, cifrado y conformidad 

Todos los planes se proporcionan en servidores con el cifrado de disco [en reposo ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://en.wikipedia.org/wiki/Data_at_rest). El acceso se encuentra en la conexión de red publica y está cifrado mediante HTTPS. Para obtener más detalles, consulte [Seguridad ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](../offerings/security.html#security){:new_window}. 
La lista blanca de IP está disponible bajo demanda para el equipo de soporte de {{site.data.keyword.cloudant_short_notm}} y se aplicará a todo el entorno {{site.data.keyword.cloudant_short_notm}} y no a nivel de instancia.  

El plan también ofrece un [Compliance Certificado ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://console.bluemix.net/docs/services/Cloudant/offerings/compliance.html#cloudant-security-compliance){:new_window}. 

La conformidad de [HIPAA ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://en.wikipedia.org/wiki/Health_Insurance_Portability_and_Accountability_Act){:new_window}
está disponible bajo petición, de modo que debe solicitarla durante el proceso de compra con un representante de ventas de {{site.data.keyword.IBM_notm}}. 

## Alta disponibilidad, recuperación de desastres y copia de seguridad 

Para proporcionar alta disponibilidad (HA) y recuperación en caso de error (DR) en un centro de datos, todos los datos se almacenan por triplicado en tres servidores físicos distintos de un clúster. Cuando estén disponibles, podrá suministrar cuentas en varias ubicaciones y utilizar la réplica de datos continua para proporcionar HA/DR entre los centros de datos. No se hace copia de seguridad automática de los datos de {{site.data.keyword.cloudant_short_notm}}, pero se proporciona un conjunto de herramientas de soporte para gestionar las copias de seguridad. Revise la guía [Recuperación en caso de error y copia de Seguridad ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://console.bluemix.net/docs/services/Cloudant/guides/disaster-recovery-and-backup.html#disaster-recovery-and-backup){:new_window} para explorar las consideraciones sobre HA, DR y copias de seguridad para cumplir con los requisitos de la aplicación.
