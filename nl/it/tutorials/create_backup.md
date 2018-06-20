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

# Creazione di un backup

Questa esercitazione illustra come utilizzare
il programma di utilità della riga di comando [CouchBackup ![Icona link esterno](../images/launch-glyph.svg "Icona link esterno")](https://www.npmjs.com/package/@cloudant/couchbackup){:new_window}
per eseguire il backup e il ripristino di un'istanza CouchDB o {{site.data.keyword.cloudant_short_notm}}. CouchBackup esegue il backup
dei database in un file. Se si verifica un errore nel database, puoi utilizzare il file di backup
per ripristinare le informazioni in un database esistente. 
{:shortdesc}

## Operazioni preliminari

Installa CouchBackup eseguendo il comando `install`. 

```sh
npm install -g @cloudant/couchbackup
```
{:codeblock}

## Creazione di un database

Crea un database `couchbackup-demo` di esempio
da utilizzare in questa esercitazione.

1.  Crea un database eseguendo questo comando:
    
    ```sh
    curl https://username:password@myhost.cloudant.com/couchbackup-demo -X PUT
    ```
    {:codeblock}
    
2.  Controlla i risultati.
    
    ```json
    {
      "ok": true
    }
    ```
    {:codeblock}

## Creazione di documenti nel database

I documenti che crei in questo esercizio contengono i dati di cui puoi eseguire il backup
e il ripristino nei successivi esercizi. 

1.  Copia il testo di esempio in un file di dati denominato `bulkcreate.dat` per creare tutti i cinque documenti.
    
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
    
2.  Esegui questo comando per creare i documenti:
    
    ```sh
    curl https://username:password@myhost.cloudant.com/couchbackup-demo/_bulk_docs -X POST -H "Content-Type: application/json" -d \@bulkcreate.dat
    ```
    {:codeblock}
    
3.  Controlla i risultati.
    
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
    
## Configurazione di una variabile di ambiente

Puoi utilizzare le variabili di ambiente o le opzioni della riga di comando per specificare
l'URL e il database per l'istanza CouchDB o {{site.data.keyword.cloudant_short_notm}} che desideri utilizzare
con CouchBackup. 

In questa esercitazione, configuriamo `COUCH_URL` e specifichiamo il database utilizzando il parametro `--db`. 

Imposta la variabile di ambiente `COUCH_URL` per specificare l'URL per l'istanza CouchDB o {{site.data.keyword.cloudant_short_notm}}.

```sh
export COUCH_URL=https://username:password@myhost.cloudant.com
```
{:codeblock}

## Backup di un database

Il programma di utilità CouchBackup esegue il backup di un database in un file di testo per conservare
i tuoi dati e renderli facili da ripristinare. 

1.  Esegui il comando `couchbackup` per indirizzare il contenuto del database in un file di testo. 
 
    ```sh
    couchbackup --db couchbackup-demo > couchbackup-demo-backup.txt
    ```
    {:codeblock}

2.  Controlla i risultati. 
    
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
    {:codeblock}
    
3.  Controlla la directory per verificare che il file `couchbackup-demo-backup.txt` sia stato creato. 
4.  Apri il file e controlla l'elenco dei documenti di cui è stato eseguito il backup dal database.  
    
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

## Creazione di un file di log

Un file di log registra l'avanzamento del tuo backup. Con CouchBackup, puoi utilizzare il parametro `--log`
per creare il file di log. Puoi inoltre utilizzarlo per riavviare un backup dal punto in cui si è interrotto
e specificare il nome del file di output. 

Il comando `couchbackup` utilizza questi parametri per specificare il database,
il file di log e l'opzione di ripresa. 

*   `--db` = `couchbackup-demo`
*   `--log` = `couchbackup-demo.log`
*   `--resume` = `true`


1.  Esegui il comando `couchbackup` per creare un file di log. 
    
    ```sh
    couchbackup --db couchbackup-demo --log couchbackup-demo-backup.log > couchbackup-demo-backup-log.txt
    ```
    {:codeblock}
    
2.  Controlla i risultati.
        
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
    {:codeblock}

3.  Apri il file di log, `couchbackup-demo-backup.log` e verifica le azioni effettuate
    durante il backup o il ripristino.  
    
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
    
##  Ripristino di un file di testo di backup

Dal file `couchbackup-demo-backup.txt`, puoi ripristinare i tuoi dati in un database nuovo e vuoto utilizzando il comando
`couchrestore`. 

> **Nota**: il ripristino di un backup è supportato solo quando viene ripristinato in un database vuoto. Se elimini tutti
i documenti da un database, i record di eliminazione del documento sono ancora presenti per scopi di consistenza della replica. 
Questo significa che un database che contiene solo documenti eliminati non è considerato vuoto e non può essere utilizzato
come destinazione quando si ripristina un backup.

1.  (Prerequisito) Crea un database nuovo e vuoto in cui puoi ripristinare i tuoi dati.
    
    ```sh
    curl https://username:password@myhost.cloudant.com/couchbackup-demo-restore -X PUT
    ```
    {:codeblock}

2.  Esegui il comando `couchrestore`.
    
    ```sh
    cat couchbackup-demo-backup.txt | couchrestore --db couchbackup-demo-restore
    ```
    {:codeblock}
    
3.  Controlla i risultati. 
    
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
    {:codeblock}

Ora, hai eseguito il backup e ripristinato una database e creato un file di log. Consulta la documentazione {{site.data.keyword.cloudant_short_notm}}
per ulteriori informazioni sul [ripristino di emergenza e backup](../guides/disaster-recovery-and-backup.html#disaster-recovery-and-backup),
sulla [configurazione di {{site.data.keyword.cloudant_short_notm}} per il ripristino di emergenza tra più regioni](../guides/active-active.html#configuring-cloudant-for-cross-region-disaster-recovery)
e sul [backup e ripristino {{site.data.keyword.cloudant_short_notm}}](../guides/backup-cookbook.html#cloudant-backup-and-recovery).  
