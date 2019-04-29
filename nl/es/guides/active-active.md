---

copyright:
  years: 2017, 2019
lastupdated: "2019-03-15"

keywords: create database, create api key for replication, grant access permission, set up replications, test replication, configure application, active-active configuration, active-passive configuration, fail over, recovering from fail over

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

<!-- Acrolinx: 2017-05-10 -->

# Configuración de {{site.data.keyword.cloudant_short_notm}} para la recuperación tras desastre entre regiones
{: #configuring-ibm-cloudant-for-cross-region-disaster-recovery}

La
[Guía de recuperación tras desastre de {{site.data.keyword.cloudant_short_notm}}](/docs/services/Cloudant?topic=cloudant-disaster-recovery-and-backup#disaster-recovery-and-backup) explica que una manera de habilitar la recuperación tras desastre es utilizar la réplica de {{site.data.keyword.cloudantfull}} para crear redundancia entre regiones.

Puede configurar la réplica en {{site.data.keyword.cloudant_short_notm}} con una topología 'activo-activo'
o 'activo-pasivo' entre los centros de datos.

En el diagrama siguiente se muestra una configuración típica que utiliza dos cuentas de {{site.data.keyword.cloudant_short_notm}}, una en cada región:

![Ejemplo de arquitectura de tipo activo-activo](../images/active-active.png)

Recuerde que:

* En cada centro, {{site.data.keyword.cloudant_short_notm}} ya ofrece una alta disponibilidad por almacenar los datos por triplicado en tres servidores.
* La réplica se produce en la base de datos, no a nivel de cuenta, y se debe configurar de forma explícita.
* {{site.data.keyword.cloudant_short_notm}} no ofrece ningún acuerdo de nivel de servicio (SLA) ni ninguna garantía sobre la latencia de la réplica.
* {{site.data.keyword.cloudant_short_notm}} no supervisa réplicas individuales.
  Recomendamos que utilice su propia estrategia para detectar las réplicas que han fallado y para reiniciarlas.

## Antes de empezar un despliegue activo-activo
{: #before-you-begin-an-active-active-deployment}

Para un despliegue de tipo activo-activo, debe haber una estrategia para gestionar conflictos. Por lo tanto, asegúrese de comprender el funcionamiento de la [réplica](/docs/services/Cloudant?topic=cloudant-replication-api#replication-api) y de los [conflictos](/docs/services/Cloudant?topic=cloudant-document-versioning-and-mvcc#document-versioning-and-mvcc) antes de tener en cuenta esta arquitectura.
{: note}

Póngase en contacto con el equipo de soporte de [{{site.data.keyword.cloudant_short_notm}} ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](mailto:support@cloudant.com){: new_window} si necesita ayuda para modelar los datos a fin de gestionar los conflictos de forma eficiente.

## Visión general
{: #overview-active-active}

En el siguiente material se crea una réplica bidireccional.
Esta configuración permite que dos bases de datos trabajen en una topología de tipo activo-activo.

En la configuración se da por su puesto que tiene dos cuentas en distintas regiones:

* `myaccount-dc1.cloudant.com`
* `myaccount-dc2.cloudant.com`

Con estas dos cuentas configuradas, los pasos básicos a seguir son los siguientes:

1. [Cree](#step-1-create-your-databases) un par de bases de datos homólogas dentro de las cuentas.
2. [Configure](#step-2-create-an-api-key-for-your-replications) claves de API para utilizarlas para las réplicas entre estas bases de datos.
3. Otorgue los permisos adecuados.
4. Configure las réplicas.
5. Compruebe que las réplicas funcionan según lo esperado.
6. Configure la aplicación y la infraestructura para un uso de tipo activo-activo o activo-pasivo de las bases de datos.

## Paso 1: Crear las bases de datos
{: #step-1-create-your-databases}

[Cree las bases de datos](/docs/services/Cloudant?topic=cloudant-databases#create-database) entre las que desea realizar la réplica dentro de cada cuenta.

En este ejemplo se crea una base de datos denominada `mydb`.

Los nombres utilizados para las bases de datos en este ejemplo no son importantes, pero es más claro y sencillo utilizar el mismo nombre.

```sh
curl https://myaccount-dc1.cloudant.com/mydb -XPUT -u myaccount-dc1
curl https://myaccount-dc2.cloudant.com/mydb -XPUT -u myaccount-dc2
```
{: codeblock}

## Paso 2: Crear una clave de API para las réplicas
{: #step-2-create-an-api-key-for-your-replications}

Resulta aconsejable utilizar una [clave de API](/docs/services/Cloudant?topic=cloudant-authorization#api-keys) para las réplicas continuas.
La ventaja es que si cambian los detalles de la cuenta primaria, por ejemplo después de restablecer una contraseña, las réplicas pueden continuar sin modificaciones.

Las claves de API no están enlazadas a una sola cuenta.
Esto significa que se puede crear una sola clave de API y otorgarle los permisos de base de datos adecuados para ambas cuentas.

Por ejemplo, el mandato siguiente solicita una clave de API para la cuenta `myaccount-dc1`:

```sh
$ curl -XPOST https://myaccount-dc1.cloudant.com/_api/v2/api_keys -u myaccount-dc1
```
{: codeblock}

Una respuesta correcta se parece a la del siguiente ejemplo abreviado:

```json
{
  "password": "YPN...Tfi",
  "ok": true,
  "key": "ble...igl"
}
```
{: codeblock}

Anote la contraseña. No se puede recuperar la contraseña posteriormente.
{: important}

## Paso 3: Otorgar permiso de acceso
{: #step-3-grant-access-permission}

[Otorgue a la clave de API permiso](/docs/services/Cloudant?topic=cloudant-authorization#modifying-permissions)
para leer y escribir en ambas bases de datos.

Si también desea replicar índices, asigne permisos de administración.

Utilice el panel de control de {{site.data.keyword.cloudant_short_notm}} o consulte la información sobre [autorización](/docs/services/Cloudant?topic=cloudant-authorization#authorization) para ver detalles sobre cómo otorgar permisos mediante programación.

## Paso 4: Configurar réplicas
{: #step-4-set-up-replications}

Las réplicas en {{site.data.keyword.cloudant_short_notm}} son siempre unidireccionales: desde una base de datos a otra base de datos.
Por lo tanto, para realizar la réplica en ambos sentidos entre dos bases de datos se necesitan dos réplicas, una para cada dirección.

Se crea una réplica en cada cuenta que utiliza la clave de API creada [anteriormente](#step-2-create-an-api-key-for-your-replications).

En primer lugar, cree una réplica de la base de datos `myaccount-dc1.cloudant.com/mydb` a la base de
datos `myaccount-dc2.cloudant.com/mydb`.

```sh
curl -XPOST 'https://myaccount-dc1.cloudant.com/_replicator'
	-u myaccount-dc1
	-H 'Content-type: application/json'
	-d '{ "_id": "mydb-myaccount-dc1-to-myaccount-dc2",
	"source": "https://ble...igl:YPN...Tfi@myaccount-dc1.cloudant.com/mydb",
	"target": "https://ble...igl:YPN...Tfi@myaccount-dc2.cloudant.com/mydb",
	"continuous": true
}'
```
{: codeblock}

A continuación, cree una réplica de la base de datos `myaccount-dc2.cloudant.com/mydb` a la base de datos `myaccount-dc1.cloudant.com/mydb`.

```sh
curl -XPOST 'https://myaccount-dc2.cloudant.com/_replicator'
	-u myaccount-dc2
	-H 'Content-type: application/json'
	-d '{ "_id": "mydb-myaccount-dc2-to-myaccount-dc1",
	"source": "https://ble...igl:YPN...Tfi@myaccount-dc2.cloudant.com/mydb",
	"target": "https://ble...igl:YPN...Tfi@myaccount-dc1.cloudant.com/mydb",
	"continuous": true
}'
```
{: codeblock}

Si este paso falla porque la base de datos `_replicator` no existe, créela.
{: note}

## Paso 5: Probar la réplica
{: #step-5-test-your-replication}

Pruebe los procesos de réplica mediante la creación, modificación y supresión de documentos en cualquiera de las bases de datos.

Después de realizar cada cambio en una base de datos, compruebe que también puede ver el cambio reflejado en la otra base de otros.

## Paso 6: Configurar la aplicación
{: #step-6-configure-your-application}

Llegados a este punto, las bases de datos están configuradas para que permanezcan sincronizadas entre sí.

El siguiente paso consiste en decidir si se desea utilizar las bases de datos en una configuración de tipo [activo-activo](#active-active) o [activo-pasivo](#active-passive).

### Activo-Activo
{: #active-active}

En una configuración de tipo activo-activo, las distintas instancias de una aplicación pueden escribir en distintas bases de datos.

Por ejemplo,
la aplicación 'A' puede escribir en la base de datos `myaccount-dc1.cloudant.com/mydb`,
mientras que la aplicación 'B' puede escribir en la base de datos `myaccount-dc2.cloudant.com/mydb`.

Esta configuración ofrece varias ventajas:

- La cargar se puede distribuir entre varias cuentas.
- Las aplicaciones se pueden configurar de modo que accedan a una cuenta con baja latencia (no siempre la más cercana geográficamente).

Una aplicación se puede configurar de modo que se comunique con la cuenta de {{site.data.keyword.cloudant_short_notm}} 'más cercana'.
Para las aplicaciones alojadas en DC1,
resulta adecuado configurar su URL de {{site.data.keyword.cloudant_short_notm}}
como `"https://myaccount-dc1.cloudant.com/mydb"`.
Paralelamente, para las aplicaciones alojadas en DC2, se configuraría su URL de {{site.data.keyword.cloudant_short_notm}} a `"https://myaccount-dc2.cloudant.com/mydb"`.

### Activo-Pasivo
{: #active-passive}

En una configuración de tipo activo-pasivo, todas las instancias de una aplicación se configuran de modo que utilicen una base de datos primaria.
Sin embargo, la aplicación puede migrar a la otra base de datos de seguridad si es necesario.
La migración tras error se puede implementar dentro de la propia lógica de la aplicación, mediante un equilibrador de carga o con otro método.

Una prueba sencilla para saber si se necesita una migración tras error es utilizar el punto final de la base de datos principal como señal de latido.
Por ejemplo, una simple solicitud `GET` que se envía al punto final de la base de datos principal suele devolver [detalles sobre la base de datos](/docs/services/Cloudant?topic=cloudant-databases#getting-database-details).
El hecho de no recibir ninguna respuesta puede ser una indicación de que se necesita una migración tras error.

### Otras configuraciones
{: #other-configurations}

También puede tener en cuenta otros enfoques híbridos para su configuración.

Por ejemplo, en una configuración de tipo 'Escritura-Primaria, Lectura-Réplica' todas las escrituras van a una base de datos, pero la carga de lectura se distribuye entre las réplicas.

## Paso 7: Siguientes pasos
{: #step-7-next-steps}

* Tenga en cuenta la supervisión de las [réplicas](/docs/services/Cloudant?topic=cloudant-advanced-replication#advanced-replication) entre las bases de datos.
  Utilice los datos para determinar si la configuración se puede optimizar más.
*	Tenga en cuenta cómo se despliegan y actualizan sus documentos de diseño y sus índices.
  Puede que resulte más eficiente automatizar estas tareas.

## Migración tras error entre regiones de {{site.data.keyword.cloudant_short_notm}}
{: #failing-over-between-ibm-cloudant-regions}

Generalmente el proceso de gestionar una migración tras error entre regiones o centros de datos se maneja a nivel superior de la pila de la aplicación, por ejemplo mediante la configuración de cambios de migración tras error del servidor de aplicaciones o mediante el equilibrio de la carga.

{{site.data.keyword.cloudant_short_notm}} no ofrece ningún recurso para gestionar de forma explícita la migración tras error ni para redireccionar solicitudes entre regiones.
Esta restricción se debe en parte a razones técnicas y en parte a que las condiciones bajo las que puede suceder suelen depender de la aplicación.
Por ejemplo, es posible que desee forzar una migración tras error como respuesta a una métrica de rendimiento personalizada.

Sin embargo, si decide que no necesita la capacidad de gestionar la migración tras error, algunas de las posibles opciones son las siguientes:

* Coloque su propio [proxy HTTP frente a {{site.data.keyword.cloudant_short_notm}} ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://github.com/greenmangaming/cloudant-nginx){: new_window}.
  Configure la aplicación de modo que se comunique con el proxy, no con la instancia de {{site.data.keyword.cloudant_short_notm}}.
  Esta configuración implica que la tarea de modificar las instancias de {{site.data.keyword.cloudant_short_notm}} que utilizan las aplicaciones se puede gestionar mediante una modificación en la configuración del proxy en lugar de mediante una modificación de los valores de la aplicación.
  Muchos proxies tienen capacidad para equilibrar la carga en función de comprobaciones de estado definidas por el usuario.
* Utilice un equilibrador de carga global como
[{{site.data.keyword.cloud}} Internet Services ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](/docs/infrastructure/cis/glb.html#global-load-balancer-glb-concepts){: new_window} o
[Dyn Traffic Director ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](http://dyn.com/traffic-director/){: new_window} para direccionar a {{site.data.keyword.cloudant_short_notm}}.
  Esta opción requiere una definición de `CNAME` que direccione a distintas cuentas de {{site.data.keyword.cloudant_short_notm}} en función de una comprobación de estado o una regla de latencia.


## Recuperación de una migración tras error
{: #recovering-from-fail-over}

Si no se puede acceder a una instancia de {{site.data.keyword.cloudant_short_notm}}, evite redirigir el tráfico a la misma en cuanto vuelva a estar disponible.
El motivo es que se necesita un tiempo para las tareas intensivas, como la sincronización del estado de la base de datos desde los homólogos o la comprobación de que los índices están actualizados.

Resulta útil disponer de un mecanismo para supervisar estas tareas a fin de decidir cuándo una base de datos está en un estado adecuado para atender el tráfico de producción.

Como directriz general, esta es la lista de las comprobaciones típicas:

* [Réplicas](#replications)
* [Índices](#indexes)

Si implementa una redirección de solicitudes o una migración tras error en función de una prueba de estado, puede resultar aconsejable incorporar comprobaciones correspondientes para evitar una redirección prematura a una instancia de servicio que aún se está recuperando.
{: note}

### Réplicas
{: #replications}

* ¿Hay alguna réplica en estado de error?
* ¿Hay que reiniciar alguna réplica?
* ¿Cuántos cambios pendientes están a la espera de una réplica en la base de datos?

Encontrará más información en [supervisión del estado de una réplica](/docs/services/Cloudant?topic=cloudant-advanced-replication#replication-status).

Si una base de datos se modifica constantemente, es poco probable que el estado de la réplica sea 0. Debe decidir el umbral de estado aceptable; de lo contrario esto representaría un estado de error.
{: note}

### Índices
{: #indexes}

* ¿Están los índices suficientemente actualizados?
  Lo puede comprobar utilizando el punto final de [tareas activas](/docs/services/Cloudant?topic=cloudant-active-tasks#active-tasks).
* Pruebe el nivel de 'preparación de índice' enviando una consulta al índice y decidiendo si la respuesta se recibe dentro de un periodo de tiempo aceptable.
