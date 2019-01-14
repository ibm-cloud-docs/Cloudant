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
<!-- Update backup-guide.md with with any changes. -->

# Copia de seguridad y recuperación de {{site.data.keyword.cloudant_short_notm}}

Este "cookbook" forma parte de la [Guía de recuperación en caso de error de {{site.data.keyword.cloudantfull}}](disaster-recovery-and-backup.html).
Vale la pena empezar por aquí si es nuevo en la materia y desea comprender cómo se combina la copia de seguridad con las otras características que ofrece {{site.data.keyword.cloudant_short_notm}} para dar soporte a los requisitos de recuperación en caso de error
(DR) y de alta disponibilidad (HA).

Aunque los datos se almacenan de forma redundante en un clúster de {{site.data.keyword.cloudant_short_notm}}, es importante tener en cuenta medidas de seguridad adicionales.
Por ejemplo, el almacenamiento de datos redundantes no protege frente a errores cuando se modifican datos.

## Introducción a CouchBackup

{{site.data.keyword.cloudant_short_notm}} ofrece una herramienta para la copia de seguridad y restauración de instantáneas.
La herramienta se llama CouchBackup y es de código abierto.
Es una biblioteca `node.js` y [se puede instalar en npm ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")][npmpackage]{:new_window}.

Además de la biblioteca, el paquete
CouchBackup contiene dos herramientas de línea de mandatos:

1. `couchbackup`, que realiza un volcado de los datos JSON de una base de datos en un archivo de texto de copia de seguridad.
2. `couchrestore`, que restaura datos de un archivo de texto de copia de seguridad en una base de datos.

> **Aviso** Las herramientas de CouchBackup tienen [limitaciones](#limitations).
{:tip}

## Copia de seguridad de los datos de {{site.data.keyword.cloudant_short_notm}}

Puede realizar una copia de seguridad simple mediante la herramienta `couchbackup`.
Para hacer una copia de seguridad de la base de datos `animaldb` en un archivo de texto denominado `backup.txt`, puede utilizar un mandato parecido al del ejemplo siguiente:

```sh
couchbackup --url https://examples.cloudant.com --db animaldb > backup.txt
```
{:codeblock}

El [archivo readme de npm ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")][npmreadme]{:new_window} contiene detalles sobre otras opciones, como por ejemplo:

* Variables de entorno para definir los nombres de la base de datos y del URL.
* Uso de un archivo de registro para registrar el progreso de una copia de seguridad.
* Capacidad para reanudar una copia de seguridad interrumpida.
  **Nota**: Esta opción solo está disponible con el archivo de registro para la copia de seguridad interrumpida.
  {:tip}
* Envío del archivo de texto de copia de seguridad a un archivo de salida con nombre, en lugar de redirigirlo a la salida `stdout`.

> **Aviso** Las herramientas de CouchBackup tienen [limitaciones](#limitations).
{:tip}

## Restauración de los datos de {{site.data.keyword.cloudant_short_notm}}

Para restaurar los datos, utilice la herramienta `couchrestore`.
Utilice `couchrestore` para importar el archivo de copia de seguridad en una nueva base de datos de {{site.data.keyword.cloudant_short_notm}}.
A continuación, asegúrese de crear todos los índices antes de cualquier aplicación intente utilizar los datos restaurados.

Por ejemplo, para restaurar los datos copiados en el ejemplo anterior:

```sh
couchrestore --url https://myaccount.cloudant.com --db newanimaldb < backup.txt
```
{:codeblock}

El [archivo readme de npm ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")][npmreadme]{:new_window} contiene detalles sobre otras opciones de restauración.

> **Aviso** Las herramientas de CouchBackup tienen [limitaciones](#limitations).
{:tip}

## Limitaciones

> **Aviso** Las herramientas de CouchBackup tienen las siguientes limitaciones: 
{:tip}

* Las herramientas no hacen copia de seguridad de los valores de `_security`.
* Las herramientas no hacen copia de seguridad de los archivos adjuntos.
* Las copias de seguridad no son instantáneas exactas en un "punto en el tiempo".
  El motivo es que los documentos de la base de datos se recuperan por lotes, pero es posible que otras aplicaciones estén actualizando documentos al mismo tiempo.
  Por lo tanto, los datos de la base de datos pueden cambiar entre el momento en que se lee el primer y el último lote.
* Se hace una copia de seguridad de las definiciones de índice contenidas en los documentos de diseño, pero no del contenido de los índices.
  Esta limitación significa que, cuando se restauran los datos, los índices se deben volver a crear.
  Esta reconstrucción puede tardar una cantidad de tiempo considerable, en función de la cantidad de datos que se restauren.

## Utilización de las herramientas

La [página de npm ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")][npmpackage]{:new_window}
contiene detalles sobre los conceptos básicos del uso de las herramientas de línea de mandatos para hacer copia de seguridad y restaurar datos.
En los siguientes ejemplos se muestra cómo se ponen en práctica estos detalles, describiendo el uso de las herramientas para tareas específicas.

El paquete CouchBackup ofrece dos modos de utilizar sus funciones principales.

* Las herramientas de línea de mandatos se pueden incorporar en series de mandatos UNIX estándares.
  En la mayoría de los casos, una combinación de `cron` y scripts simples de shell de la aplicación `couchbackup` es suficiente.
* Una biblioteca que se puede utilizar desde node.js.
  La biblioteca permite crear y desplegar procesos de copia de seguridad más complicados, como por ejemplo determinar de forma dinámica las bases de datos de las que hay que hacer copia de seguridad.

Utilice la herramienta de copia de seguridad de línea de mandatos o la biblioteca con el código de aplicación para habilitar una copia de seguridad desde bases de datos de {{site.data.keyword.cloudant_short_notm}} como parte de situaciones más complicadas.
Una práctica útil consiste en planificar las copias de seguridad mediante `cron`
y cargar automáticamente los datos en [Cloud Object Storage ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](http://www-03.ibm.com/software/products/en/object-storage-public){:new_window} para su almacenamiento a largo plazo.

## Ejemplos de scripts de línea de mandatos

Suelen presentarse dos requisitos:

* Ahorrar espacio de disco, ['comprimiendo' mediante zip el archivo de copia de seguridad](#zipping-a-backup-file) a medida que se crea.
* Crear una copia de seguridad de una base de datos automáticamente, [a intervalos regulares](#hourly-or-daily-backups-using-cron).

### Compresión de un archivo de copia de seguridad

La herramienta `couchbackup` puede escribir un archivo de copia de seguridad en disco directamente o puede direccionar la copia de seguridad a `stdout`.
La redirección a `stdout` permite transformar los datos antes de que se escriban en disco.
Esta función se utiliza para comprimir los datos dentro de la corriente de datos.

```sh
couchbackup --url "https://examples.cloudant.com" \
  --db "animaldb" | gzip > backup.gz
```
{:codeblock}

En este ejemplo, la herramienta `gzip` acepta los datos de copia de seguridad directamente a través de `stdin`, comprime los datos y los emite mediante `stdout`.
Luego la corriente de datos comprimidos resultante se redirige y se escribe en un archivo llamado `backup.gz`.

Si la base de datos requiere que especifique credenciales de acceso, utilice un URL con el formato `https://$USERNAME:$PASSWORD@$ACCOUNT.cloudant.com`,
como por ejemplo:

```sh
couchbackup --url "https://$USERNAME:$PASSWORD@examples.cloudant.com" \
  --db "animaldb" | gzip > backup.gz
```
{:codeblock}

Resulta más claro extender la serie de mandatos si desea transformar los datos de otras maneras.
Por ejemplo, supongamos que desea cifrar los datos antes de que se escriban en disco.
También es posible que desee escribir los datos directamente en un servicio de almacenamiento de objetos mediante sus herramientas de línea de mandatos.

### Copias de seguridad horarias o diarias que utilizan `cron`

La herramienta de planificación `cron` se puede configurar de modo que tome instantáneas de los datos a intervalos regulares

Un punto de partida recomendable consiste en obtener `couchbackup` para escribir una sola copia de seguridad en un archivo cuyo nombre incluya la fecha y hora actuales, tal como se muestra en el siguiente ejemplo:

```sh
couchbackup --url "https://$USERNAME:$PASSWORD@$ACCOUNT.cloudant.com" \
  --db "animaldb" > animaldb-backup-`date -u "+%Y-%m-%dT%H:%M:%SZ"`.bak
```
{:codeblock}

Después de comprobar el mandato para asegurarse de que funciona correctamente, se puede especificar en un 'trabajo cron':

1.  Instale las herramientas de CouchBackup en el servidor en el que desea realizar las copias de seguridad.
2.  Cree una carpeta en la que guardar las copias de seguridad.
3.  Cree una 'entrada cron' que describa la frecuencia de la copia de seguridad.

Para crear una entrada cron, utilice el mandato `crontab -e`.
Consulte la documentación del sistema para ver detalles específicos sobre las opciones de 'cron'.

Una entrada cron para hacer una copia de seguridad diaria se parece a la del siguiente ejemplo:

```sh
0 5 * * * couchbackup --url "https://$USERNAME:$PASSWORD@$ACCOUNT.cloudant.com" --db "animaldb" > /path/to/folder/animaldb-backup-`date -u "+%Y-%m-%dT%H:%M:%SZ"`.bak
```
{:codeblock}

Esta entrada cron crea una copia de seguridad diaria a las 05:00.
Puede modificar el patrón de cron para que realice las copias de seguridad cada hora, cada día, cada semana o cada mes según necesite.

## Utilización de CouchBackup como biblioteca

Las herramientas de línea de mandatos `couchbackup` y `couchrestore` son derivadores de una biblioteca que se puede utilizar en sus propias aplicaciones node.js.

La biblioteca resulta útil en varios escenarios complicados, como los siguientes:

* Copia de seguridad de varias bases de datos en una tarea.
  Puede hacer esta copia de seguridad identificando todas las bases de datos mediante la llamada [`_all_dbs`](../api/database.html#get-databases) y luego realizando una copia de seguridad de cada base de datos individualmente.
* Las series de mandatos largas aumentan el riesgo de errores.
  Mediante la biblioteca CouchBackup, la aplicación puede detectar y corregir  cualquier error a la primera oportunidad.

Para obtener más información, consulte la [página de npm ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")][npmpackage]{:new_window}.

El siguiente script de ejemplo muestra cómo combinar la biblioteca `couchbackup` con el uso de {{site.data.keyword.IBM}} Cloud Object Storage.
En este código se muestra cómo puede utilizar la API Cross Region S3 para hacer una copia de seguridad de una base de datos en un almacén de objetos.

> **Nota**: Un requisito previo para el código es que inicialice el objeto cliente S3 para {{site.data.keyword.IBM_notm}} Cloud Object Storage siguiendo
[estas instrucciones ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")][cosclient]{:new_window}.
{:tip}

```javascript
/*
  Copia de seguridad directa de Cloudant en un grupo S3 mediante una serie de mandatos.
  @param {serie} couchHost - URL de la base de datos raíz
  @param {serie} couchDatabase - base de datos origen de la copia de seguridad
  @param {objeto} s3Client - objeto cliente S3
  @param {serie} s3Bucket - Grupo S3 de destino (debe existir)
  @param {serie} s3Key - Clave del objeto de destino (no debería existir)
  @param {booleano} shallow - Si se debe utilizar la modalidad shallow de couchbackup
  @returns {Promise}
*/
function backupToS3(sourceUrl, s3Client, s3Bucket, s3Key, shallow) {
  return new Promise((resolve, reject) => {
    debug('Setting up S3 upload to ${s3Bucket}/${s3Key}');

    // Una corriente de paso que tiene escrita la salida de couchbackup
    // y que ha leído el cliente de carga S3.
    // Tiene un almacenamiento intermedio interno de 10 MB.
    const streamToUpload = new stream.PassThrough({highWaterMark: 10485760});

    // Configurar la carga de S3.
    const params = {
      Bucket: s3Bucket,
      Key: s3Key,
      Body: streamToUpload
    };
    s3Client.upload(params, function(err, data) {
      debug('S3 upload done');
      if (err) {
        debug(err);
        reject(new Error('S3 upload failed'));
        return;
      }
      debug('S3 upload succeeded');
      debug(data);
      resolve();
    }).httpUploadProgress = (progress) => {
      debug('S3 upload progress: ${progress}');
    };

    debug('Starting streaming data from ${sourceUrl}');
    couchbackup.backup(
      sourceUrl,
      streamToUpload,
      (err, obj) => {
        if (err) {
          debug(err);
          reject(new Error('CouchBackup failed with an error'));
          return;
        }
        debug('Download from ${sourceUrl} complete.');
        streamToUpload.end();  // hay que llamar a end() para completar la carga de S3.
        // La carga de S3 llama a resolve()
      }
    );
  });
}
```
{:codeblock}

## Otras opciones de recuperación en caso de error

Vuelva a consultar la [Guía de recuperación en caso de error de {{site.data.keyword.cloudant_short_notm}}](disaster-recovery-and-backup.html) para ver otras características que ofrece {{site.data.keyword.cloudant_short_notm}}
para una configuración completa de recuperación en caso de error.

[npmpackage]: https://www.npmjs.com/package/@cloudant/couchbackup
[npmreadme]: https://github.com/cloudant/couchbackup/blob/master/README.md
[cosclient]: https://developer.ibm.com/recipes/tutorials/cloud-object-storage-s3-api-intro/
