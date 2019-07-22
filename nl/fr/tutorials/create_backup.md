---

copyright:
  years: 2017, 2019
lastupdated: "2019-06-12"

keywords: create database, create documents, set environment variable, back up database, create log file, restore backup

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

# Création d'une sauvegarde
{: #creating-a-backup}

Ce tutoriel explique comment utiliser l'utilitaire de ligne de commande
[CouchBackup ![Icône de lien externe](../images/launch-glyph.svg "Icône de lien externe")](https://www.npmjs.com/package/@cloudant/couchbackup){: new_window}
pour sauvegarder et restaurer une instance CouchDB ou {{site.data.keyword.cloudant_short_notm}}. CouchBackup sauvegarde la
base de données dans un fichier. En cas d'échec de défaillance de la base de données, vous pouvez utiliser le fichier de sauvegarde pour restaurer les informations dans une
base de données existante. 
{: shortdesc}

## Avant de commencer à installer CouchBackup
{: #before-you-begin-to-install-couchbackup}

Installez CouchBackup en exécutant la commande `install`. 

```sh
npm install -g @cloudant/couchbackup
```
{: codeblock}

## Création d'une base de données exemple
{: #creating-a-sample-database}

Créez une base de données exemple `couchbackup-demo` pour l'utiliser dans ce tutoriel.

1.  Créez une base de données en exécutant la commande suivante :
    
    ```sh
    curl https://username:password@myhost.cloudant.com/couchbackup-demo -X PUT
    ```
    {: codeblock}
    
2.  Examinez les résultats.
    
    ```json
    {
      "ok": true
    }
    ```
    {: codeblock}

## Création de documents dans la base de données exemple
{: #creating-documents-in-the-sample-database}

Les documents que vous créez dans cet exercice contiennent les données que vous sauvegardez et restaurez ultérieurement. 

1.  Copiez le texte exemple dans un fichier de données nommé `bulkcreate.dat` pour créer les cinq documents.
    
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
    {: codeblock}
    
2.  Exécutez la commande suivante pour créer les documents :
    
    ```sh
    curl https://username:password@myhost.cloudant.com/couchbackup-demo/_bulk_docs -X POST -H "Content-Type: application/json" -d \@bulkcreate.dat
    ```
    {: codeblock}
    
3.  Examinez les résultats.
    
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
    {: codeblock}
    
## Définition d'une variable d'environnement
{: #setting-an-environment-variable}

Vous pouvez utiliser des variables d'environnement ou des options de ligne de
commande pour spécifier l'URL et la base de données de l'instance CouchDB ou {{site.data.keyword.cloudant_short_notm}} que vous souhaitez employer avec CouchBackup. 

Dans ce tutoriel, définissez `COUCH_URL` et spécifiez la base de données à l'aide du paramètre `--db`. 

Définissez la variable d'environnement `COUCH_URL` pour spécifier l'URL de l'instance CouchDB ou {{site.data.keyword.cloudant_short_notm}}.

```sh
export COUCH_URL=https://username:password@myhost.cloudant.com
```
{: codeblock}

## Sauvegarde d'une base de données
{: #backing-up-a-database}

L'utilitaire CouchBackup sauvegarde votre base de données dans un fichier texte afin de conserver vos données et faciliter leur restauration. 

1.  Exécutez la commande `couchbackup` pour acheminer le contenu de votre base de données vers un fichier texte. 
 
    ```sh
    couchbackup --db couchbackup-demo > couchbackup-demo-backup.txt
    ```
    {: codeblock}

2.  Examinez les résultats. 
    
    ```sh
    
    ================================================================================
    Performing backup on https://****:****@myhost.cloudant.com/couchbackup-demo using configuration:
    {
        "bufferSize": 500,
        "log": "/var/folders/r7/vtctv4695hj_njxmr2hj4jyc0000gn/T/tmp-3132gHPWk9A9yGVe.tmp",
        "mode": "full",
        "parallelism": 5
    }
    ================================================================================
    Streaming changes to disk:
     batch 0
        couchbackup:backup written 0  docs:  5 Time 0.604 +0ms
        couchbackup:backup finished { total: 5 } +4ms
    ```
    {: codeblock}
    
3.  Examinez le répertoire pour vérifier que le fichier `couchbackup-demo-backup.txt` a été créé. 
4.  Ouvrez le fichier et examinez la liste des documents sauvegardés depuis la base de données.  
    
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
              "f6055e3e09f215c522d45189208a1bdf" ]
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
    {: codeblock}

## Création d'un fichier journal
{: #creating-a-log-file}

Un fichier journal enregistre la progression de votre sauvegarde. Dans CouchBackup,
utilisez le paramètre `--log` pour créer le fichier journal. Vous
pouvez également l'employer pour redémarrer une sauvegarde là où elle s'était arrêtée et
spécifier le nom du fichier de sortie. 

La commande `couchbackup` utilise les paramètres suivants pour
spécifier l'option de base de données, de fichier journal et de reprise. 

*   `--db` = `couchbackup-demo`
*   `--log` = `couchbackup-demo.log`
*   `--resume` = `true`


1.  Exécutez la commande `couchbackup` pour créer un fichier journal. 
    
    ```sh
    couchbackup --db couchbackup-demo --log couchbackup-demo-backup.log > couchbackup-demo-backup-log.txt
    ```
    {: codeblock}
    
2.  Examinez les résultats.
        
    ```sh
    
    ================================================================================
    Performing backup on https://****:****@myhost.cloudant.com/couchbackup-demo using configuration:
        {
          "bufferSize": 500,
          "log": "couchbackup-demo-backup.log",
          "mode": "full",
          "parallelism": 5
        }
    ================================================================================
    Streaming changes to disk:
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
    {: codeblock}

3.  Ouvrez le fichier journal`couchbackup-demo-backup.log` et examinez les actions prises lors de la sauvegarde ou de la restauration.  
    
    ```sh
    :t batch0 [
        {"id":"doc1"}, {"id":"doc5"},
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
    {: codeblock}
    
##  Restauration à partir d'un fichier texte de sauvegarde
{: #restoring-from-a-backup-text-file}

Le fichier `couchbackup-demo-backup.txt` vous permet de restaurer vos données dans une nouvelle base de données vide grâce à la commande `couchrestore`. 

La restauration d'une sauvegarde n'est prise en charge que dans le cas d'une restauration dans une base de données vide. Si vous supprimez tous les documents d'une base de données, les enregistrements de suppression des documents sont toujours présents pour assurer une cohérence au niveau de la réplication. Cela signifie qu'une base de données contenant uniquement des documents supprimés n'est
pas considérée comme vide et ne peut donc pas être utilisée comme cible lors de la
restauration d'une sauvegarde. 
{: tip}

1.  (Prérequis) Créez une nouvelle base de données vide dans laquelle vous pouvez restaurer vos données.
    
    ```sh
    curl https://username:password@myhost.cloudant.com/couchbackup-demo-restore -X PUT
    ```
    {: codeblock}

2.  Exécutez la commande `couchrestore`.
    
    ```sh
    cat couchbackup-demo-backup.txt | couchrestore --db couchbackup-demo-restore
    ```
    {: codeblock}
    
3.  Examinez les résultats. 
    
    ```sh
    
    ================================================================================
    Performing restore on https://****:****@myhost.cloudant.com/couchbackup-demo-restore using configuration:
    {
      "bufferSize": 500,
      "parallelism": 5
    }
    ================================================================================
      couchbackup:restore restored 5 +0ms
      couchbackup:restore finished { total: 5 } +1ms
    ```
    {: codeblock}

Vous venez de sauvegarder et de restaurer une base de données, et avez créé un fichier journal. Pour plus d'informations sur
[la sauvegarde et la reprise après incident](/docs/services/Cloudant?topic=cloudant-disaster-recovery-and-backup#disaster-recovery-and-backup),
[la configuration de {{site.data.keyword.cloudant_short_notm}} en vue de la reprise après incident inter-région](/docs/services/Cloudant?topic=cloudant-configuring-ibm-cloudant-for-cross-region-disaster-recovery#configuring-ibm-cloudant-for-cross-region-disaster-recovery) et la
[{{site.data.keyword.cloudant_short_notm}}sauvegarde et la reprise](/docs/services/Cloudant?topic=cloudant-ibm-cloudant-backup-and-recovery#ibm-cloudant-backup-and-recovery), reportez-vous à la documentation de {{site.data.keyword.cloudant_short_notm}}.  
