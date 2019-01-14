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

# ¿Cómo funciona {{site.data.keyword.cloudant_short_notm}} con los grupos de recursos de {{site.data.keyword.cloud_notm}}?

A partir del 16 de julio de 2018, se han suministrado nuevas instancias de recurso de {{site.data.keyword.cloudantfull}} en grupos de recursos, en lugar de en espacios de Cloud Foundry. Este documento cubre las preguntas comunes que el soporte de {{site.data.keyword.cloudant_short_notm}} ha recibido acerca de esta transición.

## ¿Cómo puedo migrar una instancia existente a un grupo de recursos?

Para migrar una instancia de {{site.data.keyword.cloudant_short_notm}} de un espacio de Cloud Foundry a un grupo de recursos, consulte [Migración de instancias de servicio y apps de Cloud Foundry a un grupo de recursos](https://console.bluemix.net/docs/resources/instance_migration.html#migrate){:new_window}.

Puede migrar instancias de {{site.data.keyword.cloudant_short_notm}} en los planes siguientes:

- Lite
- Estándar
- Hardware dedicado

## ¿Cuánto tiempo de inactividad se produce al migrar una instancia a un grupo de recursos?

No existe el tiempo de inactividad durante el proceso de migración.

## ¿Por qué algunas instancias disponen de una organización y un espacio y otras no?

A partir del 16 de julio de 2018, se han suministrado nuevas instancias en grupos de recursos en lugar de en espacios de Cloud Foundry. Las instancias de recursos suministradas antes de esta fecha tienen asociada una organización y espacio de Cloud Foundry. En su lugar, las instancias suministradas después de esta fecha se asociarán con un grupo de recursos.

## ¿Por qué no puedo crear nuevas instancias del plan Estándar en mis instancias de hardware dedicado?

Las nuevas instancias del plan Estándar se suministran en grupos de recursos. Para poder suministrar dichas instancias en una instancia de hardware dedicado, la instancia de hardware dedicado debe migrarse primero a un grupo de recursos.

Para obtener más información sobre cómo hacerlo, consulte [Migración de instancias de servicio y apps de Cloud Foundry a un grupo de recursos](https://console.bluemix.net/docs/resources/instance_migration.html#migrate){:new_window}.

Cuando la instancia de hardware dedicado se haya migrado a un grupo de recursos, aparecerá en el menú desplegable Ubicación al suministrar planes Estándar.

## ¿Cómo debo migrar mis instancias de hardware dedicado y las instancias del plan estándar que se alojan en las mismas?

En teoría, las instancias pueden migrarse a grupos de recursos en cualquier orden. En la práctica, recomendamos el orden siguiente para las instancias de hardware dedicado y las instancias de plan Estándar que se alojan en las mismas:

1. Migre las instancias de hardware dedicado a un grupo de recursos. Esto permite la creación de instancias de plan estándar en el hardware dedicado.
2. Migre las instancias estándar.

Las instancias del plan Lite y las del plan Estándar que no están alojadas en el hardware dedicado se pueden migrar en cualquier momento.
{: tip}
