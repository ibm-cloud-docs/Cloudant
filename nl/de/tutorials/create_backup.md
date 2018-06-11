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

# Sicherung erstellen

Dieses Lernprogramm zeigt, wie das Befehlszeilendienstprogramm [CouchBackup ![Symbol für externen Link](../images/launch-glyph.svg "Symbol für externen Link")](https://www.npmjs.com/package/@cloudant/couchbackup){:new_window}
verwendet werden kann, um eine CouchDB- oder {{site.data.keyword.cloudant_short_notm}}-Instanz zu sichern und wiederherzustellen. CouchBackup sichert die Datenbank in einer Datei. Falls die Datenbank ausfällt, können Sie die Sicherungsdatei verwenden, um
die Informationen in einer vorhandenen Datenbank wiederherzustellen. 
{:shortdesc}

## Vorbereitende Schritte

Installieren Sie CouchBackup, indem Sie den Befehl `install` ausführen. 

```sh
npm install -g @cloudant/couchbackup
```
{:codeblock}

## Datenbank erstellen

Erstellen Sie eine einfache `couchbackup-demo`-Datenbank für
die Verwendung in diesem Lernprogramm.

1.  Erstellen Sie eine Datenbank, indem Sie diesen Befehl ausführen:
    
    ```sh
    curl https://username:password@myhost.cloudant.com/couchbackup-demo -X PUT
    ```
    {:codeblock}
    
2.  Überprüfen Sie die Ergebnisse.
    
    ```json
    {
      "ok": true
    }
    ```
    {:codeblock}

## Dokumente in der Datenbank erstellen

Die Dokumente, die Sie in dieser Übung erstellen, enthalten die Daten, die Sie in späteren Übungen sichern und wiederherstellen können. 

1.  Kopieren Sie den Beispieltext in eine Datendatei namens `bulkcreate.dat`, um alle fünf Dokumente zu erstellen.
    
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
    
2.  Führen Sie diesen Befehl aus, um die Dokumente zu erstellen:
    
    ```sh
    curl https://username:password@myhost.cloudant.com/couchbackup-demo/_bulk_docs -X POST -H "Content-Type: application/json" -d \@bulkcreate.dat
    ```
    {:codeblock}
    
3.  Überprüfen Sie die Ergebnisse.
    
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
    
## Umgebungsvariable festlegen

Sie können Umgebungsvariablen oder Befehlszeilenoptionen verwenden, um die
URL und die Datenbank für die CouchDB- oder {{site.data.keyword.cloudant_short_notm}}-Instanz anzugeben, die mit
CouchBackup verwendet werden soll. 

In diesem Lernprogramm legen wir die URL `COUCH_URL` fest und geben die Datenbank mithilfe des Parameters `--db` an. 

Legen Sie die Umgebungsvariable `COUCH_URL` fest, um die URL für die CouchDB- oder {{site.data.keyword.cloudant_short_notm}}-Instanz anzugeben.

```sh
export COUCH_URL=https://username:password@myhost.cloudant.com
```
{:codeblock}

## Datenbank sichern

Das CouchBackup-Dienstprogramm sichert Ihre Datenbank in eine Textdatei, um Ihre Daten
zu erhalten und einfacher wiederherstellen zu können. 

1.  Führen Sie den Befehl `couchbackup` aus, um die Inhalte Ihrer Datenbank in eine Textdatei zu übertragen. 
 
    ```sh
    couchbackup --db couchbackup-demo > couchbackup-demo-backup.txt
    ```
    {:codeblock}

2.  Überprüfen Sie die Ergebnisse. 
    
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
    
3.  Prüfen Sie das Verzeichnis, um sicherzustellen, dass die Datei `couchbackup-demo-backup.txt` erstellt wurde. 
4.  Öffnen Sie die Datei und lesen Sie die Liste der Dokumente, die aus der Datenbank gesichert wurden.  
    
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

## Protokolldatei erstellen

Eine Protokolldatei zeichnet den Fortschritt Ihrer Sicherung auf. Mit CouchBackup verwenden Sie den Parameter `--log`, um die Protokolldatei zu erstellen. Sie können das Tool auch verwenden, um eine Sicherung ab dem Punkt neu zu starten, an dem sie gestoppt wurde, und den Namen der Ausgabedatei anzugeben. 

Der Befehl `couchbackup` verwendet diese Parameter, um die Datenbank, Protokolldatei und Option zum Fortsetzen anzugeben. 

*   `--db` = `couchbackup-demo`
*   `--log` = `couchbackup-demo.log`
*   `--resume` = `true`


1.  Führen Sie den Befehl `couchbackup` aus, um eine Protokolldatei zu erstellen. 
    
    ```sh
    couchbackup --db couchbackup-demo --log couchbackup-demo-backup.log > couchbackup-demo-backup-log.txt
    ```
    {:codeblock}
    
2.  Überprüfen Sie die Ergebnisse.
        
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

3.  Öffnen Sie die Protokolldatei, `couchbackup-demo-backup.log`, und überprüfen Sie die Aktionen, die
    während der Sicherung oder Wiederherstellung ausgeführt wurden.  
    
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
    
##  Aus einer Sicherungstextdatei wiederherstellen

Aus der Datei `couchbackup-demo-backup.txt` können Sie Ihre Daten mithilfe des Befehls `couchrestore` in einer neuen, leeren Datenbank wiederherstellen. 

> **Hinweis**: Das Wiederherstellen einer Sicherung wird nur unterstützt, wenn das Ziel eine leere Datenbank ist. Wenn Sie alle 
Dokumente aus einer Datenbank löschen, sind Datensätze zur Dokumentlöschung weiterhin aus Konsistenzgründen vorhanden. 
Das heißt, dass eine Datenbank, die nur gelöschte Dokumente enthält, nicht als leer betrachtet wird und deshalb nicht als Ziel für die Wiederherstellung einer Sicherung verwendet werden kann.

1.  (Voraussetzung) Erstellen Sie eine neue, leere Datenbank, in der Sie Ihre Daten wiederherstellen können.
    
    ```sh
    curl https://username:password@myhost.cloudant.com/couchbackup-demo-restore -X PUT
    ```
    {:codeblock}

2.  Führen Sie den Befehl `couchrestore` aus.
    
    ```sh
    cat couchbackup-demo-backup.txt | couchrestore --db couchbackup-demo-restore
    ```
    {:codeblock}
    
3.  Überprüfen Sie die Ergebnisse. 
    
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

Jetzt haben Sie eine Datenbank gesichert und wiederhergestellt und dazu eine Protokolldatei erstellt. In der {{site.data.keyword.cloudant_short_notm}}-Dokumentation
finden Sie weitere Informationen zur [Disaster-Recovery und Sicherung](../guides/disaster-recovery-and-backup.html#disaster-recovery-and-backup),
zur [Konfiguration von {{site.data.keyword.cloudant_short_notm}} für regionsübergreifende Disaster-Recovery](../guides/active-active.html#configuring-cloudant-for-cross-region-disaster-recovery)
und zur [{{site.data.keyword.cloudant_short_notm}}-Sicherung und -Wiederherstellung](../guides/backup-cookbook.html#cloudant-backup-and-recovery).  
