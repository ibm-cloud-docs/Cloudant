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

# 建立備份
{: #creating-a-backup}

本指導教學示範如何使用 [CouchBackup ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://www.npmjs.com/package/@cloudant/couchbackup){: new_window} 指令行公用程式來備份及還原 CouchDB 或 {{site.data.keyword.cloudant_short_notm}} 實例。CouchBackup 會將資料庫備份至檔案。如果資料庫失敗，則您可以使用備份檔，將資訊還原至現有資料庫。
{: shortdesc}

## 開始安裝 CouchBackup 之前
{: #before-you-begin-to-install-couchbackup}

執行 `install` 指令來安裝 CouchBackup。 

```sh
npm install -g @cloudant/couchbackup
```
{: codeblock}

## 建立範例資料庫
{: #creating-a-sample-database}

建立範例 `couchbackup-demo` 資料庫以在本指導教學中使用。

1.  執行這個指令，以建立資料庫：
    
    ```sh
    curl https://username:password@myhost.cloudant.com/couchbackup-demo -X PUT
    ```
    {: codeblock}
    
2.  檢閱結果。
    
    ```json
    {
      "ok": true
    }
    ```
    {: codeblock}

## 在範例資料庫中建立文件
{: #creating-documents-in-the-sample-database}

您在此練習中建立的文件會包含您在後續練習中備份及還原的資料。 

1.  將範例文字複製到名為 `bulkcreate.dat` 的資料檔，以建立全部五份文件。
    
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
    
2.  執行這個指令，以建立文件：
    
    ```sh
    curl https://username:password@myhost.cloudant.com/couchbackup-demo/_bulk_docs -X POST -H "Content-Type: application/json" -d \@bulkcreate.dat
    ```
    {: codeblock}
    
3.  檢閱結果。
    
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
    
## 設定環境變數
{: #setting-an-environment-variable}

您可以使用環境變數或指令行選項，來指定您要搭配使用 CouchBackup 的 CouchDB 或 {{site.data.keyword.cloudant_short_notm}} 實例的 URL 及資料庫。 

在本指導教學中，我們會設定 `COUCH_URL`，並使用 `--db` 參數來指定資料庫。 

設定 `COUCH_URL` 環境變數，以指定 CouchDB 或 {{site.data.keyword.cloudant_short_notm}} 實例的 URL。

```sh
export COUCH_URL=https://username:password@myhost.cloudant.com
```
{: codeblock}

## 備份資料庫
{: #backing-up-a-database}

CouchBackup 公用程式會將資料庫備份至文字檔來保留資料，並且可更輕鬆地進行還原。 

1.  執行 `couchbackup` 指令，將資料庫內容導向至文字檔。 
 
    ```sh
    couchbackup --db couchbackup-demo > couchbackup-demo-backup.txt
    ```
    {: codeblock}

2.  檢閱結果。 
    
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
    
3.  檢查目錄，驗證已建立 `couchbackup-demo-backup.txt` 檔案。 
4.  開啟檔案，並檢閱從資料庫中備份的文件清單。  
    
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

## 建立日誌檔
{: #creating-a-log-file}

日誌檔會記錄備份的進度。使用 CouchBackup，您可以使用 `--log` 參數來建立日誌檔。您也可以使用它以從備份停止位置重新啟動備份，並指定輸出檔名稱。 

`couchbackup` 指令會使用下列參數來指定資料庫、日誌檔及繼續選項。 

*   `--db` = `couchbackup-demo`
*   `--log` = `couchbackup-demo.log`
*   `--resume` = `true`


1.  執行 `couchbackup` 指令，以建立日誌檔。 
    
    ```sh
    couchbackup --db couchbackup-demo --log couchbackup-demo-backup.log > couchbackup-demo-backup-log.txt
    ```
    {: codeblock}
    
2.  檢閱結果。
        
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

3.  開啟日誌檔 `couchbackup-demo-backup.log`，並檢閱在備份或還原期間所採取的動作。  
    
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
    
##  從備份文字檔還原
{: #restoring-from-a-backup-text-file}

您可以使用 `couchrestore` 指令，將資料從 `couchbackup-demo-backup.txt` 檔案還原至新的空白資料庫。 

只有在還原至空白資料庫時，才支援還原備份。如果您刪除資料庫中的所有文件，則基於抄寫一致性目的，仍會保留文件刪除記錄。這表示不會將只包含已刪除文件的資料庫視為空白，因此不能用作還原備份時的目標。
{: tip}

1.  （必要條件）建立新的空白資料庫，以便在其中還原資料。
    
    ```sh
    curl https://username:password@myhost.cloudant.com/couchbackup-demo-restore -X PUT
    ```
    {: codeblock}

2.  執行 `couchrestore` 指令。
    
    ```sh
    cat couchbackup-demo-backup.txt | couchrestore --db couchbackup-demo-restore
    ```
    {: codeblock}
    
3.  檢閱結果。 
    
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

現在，您已備份及還原資料庫，並建立日誌檔。如需[災難回復及備份](/docs/services/Cloudant?topic=cloudant-disaster-recovery-and-backup#disaster-recovery-and-backup)、[配置 {{site.data.keyword.cloudant_short_notm}} 進行跨地區災難回復](/docs/services/Cloudant?topic=cloudant-configuring-ibm-cloudant-for-cross-region-disaster-recovery#configuring-ibm-cloudant-for-cross-region-disaster-recovery)及 [{{site.data.keyword.cloudant_short_notm}} 備份及回復](/docs/services/Cloudant?topic=cloudant-ibm-cloudant-backup-and-recovery#ibm-cloudant-backup-and-recovery)的相關資訊，請參閱「{{site.data.keyword.cloudant_short_notm}} 文件」。  
