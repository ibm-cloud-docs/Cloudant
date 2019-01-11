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

# {{site.data.keyword.cloudant_local_notm}}

[{{site.data.keyword.cloudantfull}} Data Layer Local Edition ({{site.data.keyword.cloudant_local_notm}}) ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/support/knowledgecenter/SSTPQH_1.1.0/com.ibm.cloudant.local.doc/SSTPQH_1.1.0_welcome.html){:new_window} es una versión de la oferta {{site.data.keyword.cloudant_short_notm}} Database-as-a-Service (DBaaS) que se instala localmente.

{{site.data.keyword.cloudant_local_notm}} le ofrece las mismas funciones que la oferta {{site.data.keyword.cloudant_short_notm}} completa de un solo arrendatario, pero ubicadas dentro de su propio centro de datos.

Encontrará una visión general más detallada de {{site.data.keyword.cloudant_local_notm}}
[aquí ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/support/knowledgecenter/en/SSTPQH_1.1.0/com.ibm.cloudant.local.install.doc/topics/clinstall_cloudant_local_overview.html){:new_window}.
[IBM Knowledge Center ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/support/knowledgecenter/en/SSTPQH_1.1.0/com.ibm.cloudant.local.doc/SSTPQH_1.1.0_welcome.html){:new_window}
ofrece información sobre diversos aspectos de {{site.data.keyword.cloudant_local_notm}},
que incluye:

-   [Instalación y configuración ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/support/knowledgecenter/en/SSTPQH_1.1.0/com.ibm.cloudant.local.install.doc/topics/clinstall_installing.html){:new_window}.
-   [Tareas de mantenimiento ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/support/knowledgecenter/en/SSTPQH_1.1.0/com.ibm.cloudant.local.install.doc/topics/clinstall_maintenance_tasks_overview.html){:new_window}.
-   [Ajuste de los parámetros de réplica ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/support/knowledgecenter/en/SSTPQH_1.1.0/com.ibm.cloudant.local.install.doc/topics/clinstall_tuning_parameters_replication_cases.html){:new_window}.

## Soporte

El soporte de {{site.data.keyword.cloudant_short_notm}} proporciona asistencia con la instalación, configuración y uso correcto de {{site.data.keyword.cloudant_local_notm}}. En el caso de que se produzca un problema de rendimiento o una incoherencia, el soporte puede ayudarle a resolver problemas. En el caso de que se produzca una interrupción, el soporte puede ayudarle a identificar el problema, pero el equipo del cliente es el responsable de resolverlo, puesto que no disponemos de acceso a los sistemas del cliente.

Es necesario que haya registros adecuados para proporcionar la asistencia correcta con cualquier problema. Para ayudar a que la resolución de problemas comience tan rápido como sea posible, deberá incluir la salida de la utilidad Weatherreport, además de cualquier registro, solicitud y código de estado relevante al informar al soporte sobre un problema. Para obtener más información, consulte la [utilidad Weatherreport ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://www.ibm.com/support/knowledgecenter/SSTPQH_1.1.0/com.ibm.cloudant.local.install.doc/topics/clinstall_checking_health_cluster_with_weatherreport.html){:new_window}.

La asistencia con los problemas y paradas comunes solo se podrá ofrecer si el problema subyacente se encuentra en el ámbito del soporte. En el texto siguiente se describe el soporte disponible: 

El soporte de {{site.data.keyword.cloudant_short_notm}} cubre los problemas siguientes:
- Instalación correcta
- Configuración
- Cualquier cosa relacionada con la API que devuelve errores o resultados o rendimiento inesperados

El soporte de {{site.data.keyword.cloudant_short_notm}} no cubre los problemas siguientes:
- Herramientas o flujos de trabajo del lado del cliente de propiedad
- Problemas de red 
- Cifrado en disco 
- Herramientas o funcionalidad personalizadas

Por ejemplo, si la causa raíz es un servidor de propiedad de cliente que experimenta problemas de hardware, el soporte no será de ayuda. Sin embargo, si la interrupción se debe al propio software de {{site.data.keyword.cloudant_short_notm}}, por ejemplo, si la desaceleración de las solicitudes se produce a causa de conflictos de documentos, el soporte podrá ayudar al cliente a resolver el problema.

Póngase en contacto con el éxito de clientes o el gestor de cuenta para obtener asistencia adicional con las solicitudes siguientes:
- Ajuste de rendimiento
- Optimización de diseño
- Planificación de la capacidad

Si tiene alguna pregunta relacionada con nuestra política de soporte, póngase en contacto con el [equipo de soporte de {{site.data.keyword.cloudant_short_notm}} ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](mailto:support@cloudant.com){:new_window}.

### Cómo abrir una incidencia de soporte
Para obtener ayuda con un problema de {{site.data.keyword.cloudant_local_notm}}, abra una incidencia de soporte con el soporte de {{site.data.keyword.cloudant_short_notm}} e incluya la información siguiente:

1. Cree un correo electrónico para abrir una [solicitud de soporte de {{site.data.keyword.cloudant_short_notm}}](mailto:support@cloudant.com).
2. En la línea de asunto del correo electrónico, proporcione una única frase sobre el problema.
3. El correo electrónico debe contener los siguientes detalles para que nos ayude a diagnosticar el problema:
    - Nombre
    - Dirección de correo electrónico de contacto
    - Nombre de su organización
    - Versión de {{site.data.keyword.cloudant_local_notm}} que esté utilizando
    - Distribución y versión de Linux que esté utilizando para ejecutar {{site.data.keyword.cloudant_local_notm}}
    - Nivel de gravedad del problema
    - Descripción detallada del problema, incluidas las condiciones en las que se produce e información sobre los cambios recientes
    - Si está disponible, adjunte los registros o la salida que pueden ayudar con el diagnóstico, la reproducción y la investigación del problema
4. Cuando el soporte reciba el correo electrónico, un miembro del equipo de soporte se pondrá en contacto con usted.

