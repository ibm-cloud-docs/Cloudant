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

# バックアップの作成

このチュートリアルでは、
[CouchBackup ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://www.npmjs.com/package/@cloudant/couchbackup){:new_window}
コマンド・ライン・ユーティリティーを使用して、CouchDB または {{site.data.keyword.cloudant_short_notm}} インスタンスのバックアップおよびリストアを行う方法を示します。 CouchBackup はデータベースをファイルにバックアップします。 データベースで障害が発生した場合、バックアップ・ファイルを使用して情報を既存データベースにリストアできます。 
{:shortdesc}

## 始める前に

`install` コマンドを実行して、CouchBackup をインストールします。 

```sh
npm install -g @cloudant/couchbackup
```
{:codeblock}

## データベースの作成

このチュートリアルで使用するサンプルの `couchbackup-demo` データベースを作成します。

1.  次のコマンドを実行して、データベースを作成します。
    
    ```sh
    curl https://username:password@myhost.cloudant.com/couchbackup-demo -X PUT
    ```
    {:codeblock}
    
2.  結果を確認します。
    
    ```json
    {
      "ok": true
    }
    ```
    {:codeblock}

## データベース内の文書の作成

この演習で作成する文書には、後の演習でバックアップおよびリストするデータが含まれます。 

1.  サンプル・テキストをデータ・ファイル `bulkcreate.dat` にコピーし、5 つすべての文書を作成します。
    
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
    
2.  次のコマンドを実行して、文書を作成します。
    
    ```sh
    curl https://username:password@myhost.cloudant.com/couchbackup-demo/_bulk_docs -X POST -H "Content-Type: application/json" -d \@bulkcreate.dat
    ```
    {:codeblock}
    
3.  結果を確認します。
    
    ```json
    [
      {
        "ok":true,
      "id":"doc1",
      "rev":"1-57a08e644ca8c1bb8d8931240427162e"
      },
      {
        "ok":true,
      "id":"doc2",
      "rev":"1-bf51eef712165a9999a52a97e2209ac0"
      },
      {
        "ok":true,
      "id":"doc3",
      "rev":"1-9c9f9b893fcdd1cbe09420bc4e62cc71"
      },
      {
        "ok":true,
      "id":"doc4",
      "rev":"1-6aa4873443ddce569b27ab35d7bf78a2"
      },
      {
        "ok":true,
      "id":"doc5",
      "rev":"1-d881d863052cd9681650773206c0d65a"
    }
    ]
    ```
    {:codeblock}
    
## 環境変数の設定

環境変数またはコマンド・ライン・オプションを使用して、CouchBackup で処理する
CouchDB または {{site.data.keyword.cloudant_short_notm}} インスタンスの URL とデータベースを指定できます。 

このチュートリアルでは、`COUCH_URL` を設定し、`--db` パラメーターでデータベースを指定します。 

`COUCH_URL` 環境変数を設定し、CouchDB または {{site.data.keyword.cloudant_short_notm}} インスタンスの URL を指定します。

```sh
export COUCH_URL=https://username:password@myhost.cloudant.com
```
{:codeblock}

## データベースのバックアップ

CouchBackup ユーティリティーでは、データを保持してリストアしやすくするために、データベースをテキスト・ファイルにバックアップします。 

1.  `couchbackup` コマンドを実行し、データベースのコンテンツをテキスト・ファイルに送信します。 
 
    ```sh
    couchbackup --db couchbackup-demo > couchbackup-demo-backup.txt
    ```
    {:codeblock}

2.  結果を確認します。 
    
    ```sh
    
    ================================================================================
    構成を使用した https://****:****@myhost.cloudant.com/couchbackup-demo でのバックアップの実行:
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
    
3.  ディレクトリーをチェックして、`couchbackup-demo-backup.txt` ファイルが作成されていることを確認します。 
4.  ファイルを開き、データベースからバックアップした文書のリストを確認します。  
    
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

## ログ・ファイルの作成

バックアップの進行状況は、ログ・ファイルに記録されます。 CouchBackup では、`--log` パラメーターを使用して、ログ・ファイルを作成します。 また、バックアップが前に停止した位置から再開することや、出力ファイル名を指定することもできます。 

`couchbackup` コマンドでは、以下のパラメーターを使用して、データベース、ログ・ファイル、再開のオプションを指定できます。 

*   `--db` = `couchbackup-demo`
*   `--log` = `couchbackup-demo.log`
*   `--resume` = `true`


1.  `couchbackup` コマンドを実行して、ログ・ファイルを作成します。 
    
    ```sh
    couchbackup --db couchbackup-demo --log couchbackup-demo-backup.log > couchbackup-demo-backup-log.txt
    ```
    {:codeblock}
    
2.  結果を確認します。
        
    ```sh
    
    ================================================================================
    構成を使用した https://****:****@myhost.cloudant.com/couchbackup-demo でのバックアップの実行:
        {
          "bufferSize": 500,
          "log": "couchbackup-demo-backup.log",
          "mode": "full",
          "parallelism": 5
        }
    ================================================================================
    ストリーミングのディスクへの変更:
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

3.  ログ・ファイル `couchbackup-demo-backup.log` を開き、バックアップまたはリストア中に実行されたアクションを確認します。  
    
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
    
##  バックアップ・テキスト・ファイルからのリストア

`couchbackup-demo-backup.txt` ファイルから、`couchrestore` コマンドを使用して空の新規データベースにデータをリストアできます。 

> **注**: バックアップのリストアは、空のデータベースにリストアする場合にのみサポートされます。 データベースから文書をすべて削除しても、
複製の整合性の目的で、文書削除レコードが存在します。 
つまり、削除済み文書のみを含むデータベースは空とは見なされず、バックアップをリストアする際のターゲットとして使用できません。

1.  (前提条件) データをリストア可能な空の新規データベースを作成します。
    
    ```sh
    curl https://username:password@myhost.cloudant.com/couchbackup-demo-restore -X PUT
    ```
    {:codeblock}

2.  `couchrestore` コマンドを実行します。
    
    ```sh
    cat couchbackup-demo-backup.txt | couchrestore --db couchbackup-demo-restore
    ```
    {:codeblock}
    
3.  結果を確認します。 
    
    ```sh
    
    ================================================================================
    構成を使用した https://****:****@myhost.cloudant.com/couchbackup-demo-restore でのリストアの実行:
    {
      "bufferSize": 500,
      "parallelism": 5
    }
    ================================================================================
      couchbackup:restore restored 5 +0ms
      couchbackup:restore finished { total: 5 } +1ms
    ```
    {:codeblock}

これで、データベースのバックアップとリストアが完了し、ログ・ファイルが作成されました。 [災害復旧およびバックアップ](../guides/disaster-recovery-and-backup.html#disaster-recovery-and-backup)、
[クロス地域災害復旧のための {{site.data.keyword.cloudant_short_notm}} の構成](../guides/active-active.html#configuring-cloudant-for-cross-region-disaster-recovery)、
[{{site.data.keyword.cloudant_short_notm}} バックアップおよびリカバリー](../guides/backup-cookbook.html#cloudant-backup-and-recovery)について詳しくは、{{site.data.keyword.cloudant_short_notm}} の資料を参照してください。  
