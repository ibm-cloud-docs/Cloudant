---

copyright:
  years: 2017, 2018
lastupdated: "2017-11-07"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

# Creación de una copia de seguridad

En esta guía de aprendizaje se muestra cómo utilizar el programa de utilidad de mandatos [CouchBackup ![Icono de enlace externo](../images/launch-glyph.svg "Icono de enlace externo")](https://www.npmjs.com/package/@cloudant/couchbackup){:new_window} para realizar copias de seguridad y restaurar una instancia de {{site.data.keyword.cloudant_short_notm}} o CouchDB. CouchBackup hace una copia de seguridad de la base de datos en un archivo. Si la base de datos falla, puede utilizar el archivo de copia de seguridad para restaurar la información en una base de datos existente. 
{:shortdesc}

## Antes de empezar

Instale CouchBackup con el mandato `install`. 

```sh
npm install -g @cloudant/couchbackup
```
{:codeblock}

## Creación de una base de datos

Cree una base de datos de ejemplo `couchbackup-demo` para utilizarla en esta guía de aprendizaje.

1.  Cree una base de datos con este mandato:
    
    ```sh
    curl https://username:password@myhost.cloudant.com/couchbackup-demo -X PUT
    ```
    {:codeblock}
    
2.  Revise los resultados.
    
    ```json
    {
      "ok": true
    }
    ```
    {:codeblock}

## Creación de documentos en la base de datos

Los documentos que cree en este ejercicio contendrán los datos que copiará y restaurará en ejercicios posteriores. 

1.  Copie el texto de ejemplo en un archivo de datos denominado `bulkcreate.dat` para crear cinco documentos.
    
    ```json
    {
        "docs":
        [
            { 
                "_id": "doc1",
                "firstname": "Sally",
                "lastname": "Brown",
                "age": 16,
                "location": "New York City, NY"
            },
            { 
                "_id": "doc2",
                "firstname": "John",
                "lastname": "Brown",
                "age": 21,
                "location": "New York City, NY"
            },
            {
                "_id": "doc3",
                "firstname": "Greg",
                "lastname": "Greene",
                "age": 35,
                "location": "San Diego, CA"
            },
            {
                "_id": "doc4",
                "firstname": "Anna",
                "lastname": "Greene",
                "age": 44,
                "location": "Baton Rouge, LA"
            },
            {
                "_id": "doc5",
                "firstname": "Lois",
                "lastname": "Brown",
                "age": 33,
                "location": "Syracuse, NY"
            }
        ]
    }
    ```
    {:codeblock}
    
2.  Ejecute este mandato para crear los documentos:
    
    ```sh
    curl https://username:password@myhost.cloudant.com/couchbackup-demo/_bulk_docs -X POST -H "Content-Type: application/json" -d \@bulkcreate.dat
    ```
    {:codeblock}
    
3.  Revise los resultados.
    
    ```json
    [
      {
        "ok": true,
        "id": "doc1",
        "rev": "1-57a08e644ca8c1bb8d8931240427162e"
      },
      {
        "ok": true,
        "id": "doc2",
        "rev": "1-bf51eef712165a9999a52a97e2209ac0"
      },
      {
        "ok": true,
        "id": "doc3",
        "rev": "1-9c9f9b893fcdd1cbe09420bc4e62cc71"
      },
      {
        "ok": true,
        "id": "doc4",
        "rev": "1-6aa4873443ddce569b27ab35d7bf78a2"
      },
      {
        "ok": true,
        "id": "doc5",
        "rev": "1-d881d863052cd9681650773206c0d65a"
      }
    ]
    ```
    {:codeblock}
    
## Establecimiento de una variable de entorno

Puede utilizar variables de entorno u opciones de línea de mandatos para especificar el URL y la base de datos para la instancia de CouchDB o {{site.data.keyword.cloudant_short_notm}} con la que desea trabajar
con CouchBackup. 

En esta guía de aprendizaje, estableceremos la variable `COUCH_URL` y especificaremos la base de datos utilizando el parámetro `--db`. 

Establezca la variable de entorno `COUCH_URL` para especificar el URL para la instancia de {{site.data.keyword.cloudant_short_notm}} o CouchDB.

```sh
export COUCH_URL=https://username:password@myhost.cloudant.com
```
{:codeblock}

## Copia de seguridad de una base de datos

El programa de utilidad CouchBackup hace una copia de seguridad de la base de datos en un archivo de texto para conservar los datos y facilitar su restauración. 

1.  Ejecute el mandato `couchbackup` para dirigir el contenido de la base de datos a un archivo de texto. 
 
    ```sh
    couchbackup --db couchbackup-demo > couchbackup-demo-backup.txt
    ```
    {:codeblock}

2.  Revise los resultados. 
    
    ```sh
    
    ================================================================================
    Realización de copia de seguridad en https://****:****@myhost.cloudant.com/couchbackup-demo utilizando configuración:
    {
        "bufferSize": 500,
        "log": "/var/folders/r7/vtctv4695hj_njxmr2hj4jyc0000gn/T/tmp-3132gHPWk9A9yGVe.tmp",
        "mode": "full",
        "parallelism": 5
    }
    ================================================================================
    Direccionamiento de los cambios a disco:
     batch 0
        couchbackup:backup written 0  docs:  5 Time 0.604 +0ms
        couchbackup:backup finished { total: 5 } +4ms
    ```
    {:codeblock}
    
3.  Compruebe el directorio para verificar que se ha creado el archivo `couchbackup-demo-backup.txt`. 
4.  Abra el archivo y revise la lista de documentos que se han copiado de la base de datos.  
    
    ```json
    [
        {
          "_id": "doc2",
          "_rev": "1-2c5ee70689bb75af6f65b0335d1c92f4",
          "firstname": "John",
          "lastname": "Brown",
          "age": 21,
          "location": "New York City, NY",
          "_revisions": {
            "start": 1,
            "ids": [
              "2c5ee70689bb75af6f65b0335d1c92f4"
            ]
          }
        },
        {
          "_id": "doc3",
          "_rev": "1-f6055e3e09f215c522d45189208a1bdf",
          "firstname": "Greg",
          "lastname": "Greene",
          "age": 35,
          "location": "San Diego, CA",
          "_revisions": {
            "start": 1,
            "ids": [
              "f6055e3e09f215c522d45189208a1bdf"
            ]
          }
        },
        {
          "_id": "doc1",
          "_rev": "1-cce7796c7113c5498b07d8e11d7e0c12",
          "firstname": "Sally",
          "lastname": "Brown",
          "age": 16,
          "location": "New York City, NY",
          "_revisions": {
            "start": 1,
            "ids": [
              "cce7796c7113c5498b07d8e11d7e0c12"
            ]
          }
        },
        {
          "_id": "doc4",
          "_rev": "1-0923b723c62fe5c15531e0c33e015148",
          "firstname": "Anna",
          "lastname": "Greene",
          "age":44,
          "location": "Baton Rouge, LA",
          "_revisions": {
            "start": 1,
            "ids": [
              "0923b723c62fe5c15531e0c33e015148"
            ]
          }
        },
        {
            "_id": "doc5",
            "_rev": "1-19f7ecbc68090bc7b3aa4e289e363576",
            "firstname": "Lois",
            "lastname": "Brown",
            "age": 33,
            "location": "Syracuse, NY",
            "_revisions": {
                "start": 1,
                "ids": [
                  "19f7ecbc68090bc7b3aa4e289e363576"
                ]
            }
        }
    ]
    ```
    {:codeblock}

## Creación de un archivo de registro

Un archivo de registro registra el progreso de la copia de seguridad. Con CouchBackup, se utiliza el parámetro `--log` para crear el archivo de registro. También puede utilizarlo para reiniciar una copia de seguridad a partir de donde se detuvo y especificar el nombre del archivo de salida. 

El mandato `couchbackup` utiliza estos parámetros para especificar la base de datos, el archivo de registro y la opción resume. 

*   `--db` = `couchbackup-demo`
*   `--log` = `couchbackup-demo.log`
*   `--resume` = `true`


1.  Ejecute el mandato `couchbackup` para crear un archivo de registro. 
    
    ```sh
    couchbackup --db couchbackup-demo --log couchbackup-demo-backup.log > couchbackup-demo-backup-log.txt
    ```
    {:codeblock}
    
2.  Revise los resultados.
        
    ```sh
    
    ================================================================================
    Realización de copia de seguridad en https://****:****@myhost.cloudant.com/couchbackup-demo utilizando configuración:
    {
          "bufferSize": 500,
          "log": "couchbackup-demo-backup.log",
          "mode": "full",
          "parallelism": 5
        }
    ================================================================================
    Direccionamiento de los cambios a disco:
     batch 0
        [{"_id":"doc2","_rev":"1-2c5ee70689bb75af6f65b0335d1c92f4",
            "firstname":"John","lastname":"Brown","age":21,
            "location":"New York City, NY",
            "_revisions":{"start":1,"ids":["2c5ee70689bb75af6f65b0335d1c92f4"]}},
        {"_id":"doc4","_rev":"1-0923b723c62fe5c15531e0c33e015148",
            "firstname":"Anna","lastname":"Greene","age":44,
            "location":"Baton Rouge, LA",
            "_revisions":{"start":1,"ids":["0923b723c62fe5c15531e0c33e015148"]}},
        {"_id":"doc1","_rev":"1-cce7796c7113c5498b07d8e11d7e0c12",
            "firstname":"Sally","lastname":"Brown","age":16,
            "location":"New York City, NY",
            "_revisions":{"start":1,"ids":["cce7796c7113c5498b07d8e11d7e0c12"]}},
        {"_id":"doc5","_rev":"1-19f7ecbc68090bc7b3aa4e289e363576",
            "firstname":"Lois","lastname":"Brown","age":33,
            "location":"Syracuse, NY",
            "_revisions":{"start":1,"ids":["19f7ecbc68090bc7b3aa4e289e363576"]}},
        {"_id":"doc3","_rev":"1-f6055e3e09f215c522d45189208a1bdf",
            "firstname":"Greg","lastname":"Greene","age":35,
            "location":"San Diego, CA",
            "_revisions":{"start":1,"ids":["f6055e3e09f215c522d45189208a1bdf"]}}]
                couchbackup:backup written 0  docs:  5 Time 0.621 +0ms
                couchbackup:backup finished { total: 5 } +4ms
    ```
    {:codeblock}

3.  Abra el archivo de registro, `couchbackup-demo-backup.log`, y revise las acciones emprendidas durante la copia de seguridad o restauración.  
    
    ```sh
    :t batch0 [
        {"id":"doc1"},
        {"id":"doc5"},
        {"id":"doc3"},
        {"id":"doc4"},
        {"id":"doc2"}  ]
    :changes_complete 5-g1AAAAXkeJyl1MFNwzAUBmBDk
        RAnugEc4Nji2ImTnOgGsAH4-dkqVZoi1J5hA9gANoA
        NYAPYADaADUqMEYlBIWl7caTI-l7e_-xkhJDusINkD
        0FNLvQAIenDuKdUD2XWo7yvsskMZT7t53qaFbvXJYH
        t-Xw-GnYkGRcvNsM0lRwAydYsR23Oco2-GDWI0C1W2
        PFQFCYwKf2N7v-gAWtSd6168K2ufaksoQwD3dbx2wi
        aClJb8NBvQyVIk6Q-m6a0YWDRIw8NKA85M_Vo2IQe
        W_TEi0YIGiETLZlFZ3FqC068LqgBpHFQ30Vj3ucWv
        fRQYTAGwZbPO98oVnJVPAr3uoSTIGYcw3qYt4JvHHx
        b-WIpIqpwhYPu5Dsn35eyxNRI-c-9bArYwQ8OfqwcFY
        ghEdCSWib_J1fz2dZcdxcpAh2lpiW1zGheXM3XMsBY
        CcHonxO68GjenPxeyopyrXW86mg-HFz9NZiQh1FUhUefOhzMIg
    :d batch0
    ```
    {:codeblock}
    
##  Restauración de un archivo de texto de copia de seguridad

Desde el archivo `couchbackup-demo-backup.txt` puede restaurar los datos en una nueva base de datos vacía mediante el mandato `couchrestore`. 

> **Nota**: La restauración de una copia de seguridad solo recibe soporte cuando la restauración se realiza en una base de datos vacía. Si suprime todos los 
documentos de una base de datos, los registros de supresión de los documentos se mantienen por motivos de coherencia de réplicas. 
Esto significa que una base de datos que solo contiene documentos suprimidos no se considera vacía y no se puede utilizar como destino cuando se restaura una copia de seguridad.

1.  (Requisito previo) Cree una nueva base de datos vacía en la que pueda restaurar sus datos.
    
    ```sh
    curl https://username:password@myhost.cloudant.com/couchbackup-demo-restore -X PUT
    ```
    {:codeblock}

2.  Ejecute el mandato `couchrestore`.
    
    ```sh
    cat couchbackup-demo-backup.txt | couchrestore --db couchbackup-demo-restore
    ```
    {:codeblock}
    
3.  Revise los resultados. 
    
    ```sh
    
    ================================================================================
    Realización de restauración en https://****:****@myhost.cloudant.com/couchbackup-demo-restore utilizando configuración:
    {
      "bufferSize": 500,
      "parallelism": 5
    }
    ================================================================================
      couchbackup:restore restored 5 +0ms
      couchbackup:restore finished { total: 5 } +1ms
    ```
    {:codeblock}

Ha hecho una copia de seguridad y ha restaurado una base de datos y ha creado un archivo de registro. Consulte la documentación de {{site.data.keyword.cloudant_short_notm}} para obtener más información sobre la [recuperación en caso de error y copia de seguridad](../guides/disaster-recovery-and-backup.html#disaster-recovery-and-backup), la
[configuración de {{site.data.keyword.cloudant_short_notm}} para la recuperación en caso de error entre regiones ](../guides/active-active.html#configuring-cloudant-for-cross-region-disaster-recovery), y la [ copia de seguridad y recuperación de {{site.data.keyword.cloudant_short_notm}}](../guides/backup-cookbook.html#cloudant-backup-and-recovery).  
