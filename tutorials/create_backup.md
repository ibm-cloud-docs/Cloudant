---

copyright:
  years: 2017, 2019
lastupdated: "2019-03-19"

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

# Creating a backup
{: #creating-a-backup}

This tutorial demonstrates how to use the 
[CouchBackup ![External link icon](../images/launch-glyph.svg "External link icon")](https://www.npmjs.com/package/@cloudant/couchbackup){: new_window} command-line 
utility to back up and restore a CouchDB or {{site.data.keyword.cloudant_short_notm}} instance. CouchBackup backs up 
the database to a file. If the database fails, you can use the backup file to 
restore the information to an existing database. 
{: shortdesc}

## Before you begin to install CouchBackup
{: #before-you-begin-to-install-couchbackup}

Install CouchBackup by running the `install` command. 

```sh
npm install -g @cloudant/couchbackup
```
{: codeblock}

## Creating a sample database
{: #creating-a-sample-database}

Create a sample `couchbackup-demo` database
for use in this tutorial.

1.  Create a database by running this command:
    
    ```sh
    curl https://username:password@myhost.cloudant.com/couchbackup-demo -X PUT
    ```
    {: codeblock}
    
2.  Review the results.
    
    ```json
    {
      "ok": true
    }
    ```
    {: codeblock}

## Creating documents in the sample database
{: #creating-documents-in-the-sample-database}

The documents that you create in this exercise contain the data that you 
back up and restore in later exercises. 

1.  Copy the sample text to a data file named `bulkcreate.dat` to create all five documents.
    
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
    
2.  Run this command to create the documents:
    
    ```sh
    curl https://username:password@myhost.cloudant.com/couchbackup-demo/_bulk_docs -X POST -H "Content-Type: application/json" -d \@bulkcreate.dat
    ```
    {: codeblock}
    
3.  Review the results.
    
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
    
## Setting an environment variable
{: #setting-an-environment-variable}

You can use environment variables or command-line options to specify the 
URL and database for the CouchDB or {{site.data.keyword.cloudant_short_notm}} instance that you want to work 
with CouchBackup. 

In this tutorial, we set the `COUCH_URL` and specify the database using the `--db` parameter. 

Set the `COUCH_URL` environment variable to specify the URL for the CouchDB or {{site.data.keyword.cloudant_short_notm}} instance.

```sh
export COUCH_URL=https://username:password@myhost.cloudant.com
```
{: codeblock}

## Backing up a database
{: #backing-up-a-database}

The CouchBackup utility backs up your database to a text file to preserve 
your data and make it easier to restore. 

1.  Run the `couchbackup` command to direct the contents of your database to a text file. 
 
    ```sh
    couchbackup --db couchbackup-demo > couchbackup-demo-backup.txt
    ```
    {: codeblock}

2.  Review the results. 
    
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
    
3.  Check the directory to verify that the `couchbackup-demo-backup.txt` file was created. 
4.  Open the file and review the list of documents backed up from the database.  
    
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
    {: codeblock}

## Creating a log file
{: #creating-a-log-file}

A log file records the progress of your backup. With CouchBackup, you use the `--log` parameter 
to create the log file. You can also use it to restart a backup from where it stopped 
and specify the output file name. 

The `couchbackup` command uses these parameters to specify the database, 
log file, and resume option. 

*   `--db` = `couchbackup-demo`
*   `--log` = `couchbackup-demo.log`
*   `--resume` = `true`


1.  Run the `couchbackup` command to create a log file. 
    
    ```sh
    couchbackup --db couchbackup-demo --log couchbackup-demo-backup.log > couchbackup-demo-backup-log.txt
    ```
    {: codeblock}
    
2.  Review the results.
        
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

3.  Open the log file, `couchbackup-demo-backup.log`, and review the actions taken
    during the backup or restore.  
    
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
    {: codeblock}
    
##  Restoring from a backup text file
{: #restoring-from-a-backup-text-file}

From the `couchbackup-demo-backup.txt` file, you can restore your data to a new, empty database using 
the `couchrestore` command. 

Restoring a backup is only supported when restoring into an empty database. If you delete all documents from a database, document deletion records are still present for replication consistency purposes. This means that a database containing only deleted documents is not considered empty, and so cannot be used as the target when restoring a backup. 
{: tip}

1.  (Prerequisite) Create a new, empty database where you can restore your data.
    
    ```sh
    curl https://username:password@myhost.cloudant.com/couchbackup-demo-restore -X PUT
    ```
    {: codeblock}

2.  Run the `couchrestore` command.
    
    ```sh
    cat couchbackup-demo-backup.txt | couchrestore --db couchbackup-demo-restore
    ```
    {: codeblock}
    
3.  Review the results. 
    
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

Now, you have backed up and restored a database and created a log file. See the {{site.data.keyword.cloudant_short_notm}} Documentation 
for more information about [disaster recovery and backup](/docs/services/Cloudant?topic=cloudant-disaster-recovery-and-backup#disaster-recovery-and-backup),
[configuring {{site.data.keyword.cloudant_short_notm}} for cross region disaster recovery](/docs/services/Cloudant?topic=cloudant-configuring-ibm-cloudant-for-cross-region-disaster-recovery#configuring-ibm-cloudant-for-cross-region-disaster-recovery),
and [{{site.data.keyword.cloudant_short_notm}} backup and recovery](/docs/services/Cloudant?topic=cloudant-ibm-cloudant-backup-and-recovery#ibm-cloudant-backup-and-recovery).  
