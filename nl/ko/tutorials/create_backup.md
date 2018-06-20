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

# 백업 작성

이 튜토리얼에서는 [CouchBackup ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](https://www.npmjs.com/package/@cloudant/couchbackup){:new_window} 명령행 유틸리티를
사용하여 CouchDB 또는 {{site.data.keyword.cloudant_short_notm}} 인스턴스를 백업하고 복원하는 방법을 보여줍니다. CouchBackup은 데이터베이스를 하나의 파일에 백업합니다. 데이터베이스에서 장애가 발생하는 경우에는 해당 백업 파일을 사용하여 기존 데이터베이스에 정보를 복원할 수 있습니다. 
{:shortdesc}

## 시작하기 전에

`install` 명령을 실행하여 CouchBackup을 설치하십시오. 

```sh
npm install -g @cloudant/couchbackup
```
{:codeblock}

## 데이터베이스 작성

이 튜토리얼에서 사용할 샘플 `couchbackup-demo` 데이터베이스를 작성하십시오.

1.  다음 명령을 실행하여 데이터베이스를 작성하십시오.
    
    ```sh
    curl https://username:password@myhost.cloudant.com/couchbackup-demo -X PUT
    ```
    {:codeblock}
    
2.  결과를 검토하십시오.
    
    ```json
    {
      "ok": true
    }
    ```
    {:codeblock}

## 데이터베이스에 문서 작성

이 실습에서 작성하는 문서는 이후의 실습에서 백업하고 복원할 데이터를 포함합니다. 

1.  샘플 텍스트를 `bulkcreate.dat`라는 데이터 파일에 복사하여 다섯 개의 문서를 작성하십시오.
    
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
    
2.  다음 명령을 실행하여 문서를 작성하십시오.
    
    ```sh
    curl https://username:password@myhost.cloudant.com/couchbackup-demo/_bulk_docs -X POST -H "Content-Type: application/json" -d \@bulkcreate.dat
    ```
    {:codeblock}
    
3.  결과를 검토하십시오.
    
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
    
## 환경 변수 설정

환경 변수 또는 명령행 옵션을 사용하여 CouchBackup을 실행할 CouchDB 또는 {{site.data.keyword.cloudant_short_notm}} 인스턴스의 URL 및 데이터베이스를 지정할 수 있습니다.  

이 튜토리얼에서는 `COUCH_URL`을 설정하고 `--db` 매개변수를 사용하여 데이터베이스를 지정합니다. 

`COUCH_URL` 환경 변수를 설정하여 CouchDB 또는 {{site.data.keyword.cloudant_short_notm}} 인스턴스의 URL을 지정하십시오. 

```sh
export COUCH_URL=https://username:password@myhost.cloudant.com
```
{:codeblock}

## 데이터베이스 백업

CouchBackup 유틸리티는 데이터를 보존하고 복원하기 쉽도록 하기 위해 데이터베이스를 하나의 텍스트 파일에 백업합니다. 

1.  `couchbackup` 명령을 실행하여 데이터베이스의 컨텐츠에 대한 하나의 텍스트 파일을 지정하십시오. 
 
    ```sh
    couchbackup --db couchbackup-demo > couchbackup-demo-backup.txt
    ```
    {:codeblock}

2.  결과를 검토하십시오. 
    
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
    
3.  디렉토리를 확인하여 `couchbackup-demo-backup.txt` 파일이 작성되었는지 확인하십시오. 
4.  이 파일을 열어 데이터베이스에서 백업된 문서의 목록을 검토하십시오.  
    
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

## 로그 파일 작성

로그 파일은 백업의 진행상태를 기록합니다. CouchBackup을 사용하는 경우에는 `--log` 매개변수를 사용하여 로그 파일을 작성합니다. 이를 사용하여 백업을 중지되었던 지점부터 다시 시작하거나 출력 파일 이름을 지정할 수도 있습니다. 

`couchbackup` 명령은 다음 매개변수를 사용하여 데이터베이스, 로그 파일 및 재개 옵션을 지정합니다. 

*   `--db` = `couchbackup-demo`
*   `--log` = `couchbackup-demo.log`
*   `--resume` = `true`


1.  `couchbackup` 명령을 실행하여 로그 파일을 작성하십시오. 
    
    ```sh
    couchbackup --db couchbackup-demo --log couchbackup-demo-backup.log > couchbackup-demo-backup-log.txt
    ```
    {:codeblock}
    
2.  결과를 검토하십시오.
        
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

3.  로그 파일 `couchbackup-demo-backup.log`를 열고 백업 또는 복원 중에 수행된 조치를 검토하십시오.  
    
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
    
##  백업 텍스트 파일로부터 복원

`couchrestore` 명령을 사용하여 데이터를 `couchbackup-demo-backup.txt` 파일로부터 비어 있는 새 데이터베이스로 복원할 수 있습니다. 

> **참고**: 백업의 복원은 비어 있는 데이터베이스에 복원하는 경우에만 지원됩니다. 데이터베이스에서 
모든 문서를 삭제하는 경우, 복제 일관성을 위해 문서 삭제 레코드는 여전히 남게 됩니다. 
이는 삭제된 문서만을 포함하는 데이터베이스는 비어 있는 것으로 간주되지 않으며, 따라서
백업을 복원할 때 대상으로 사용할 수 없음을 의미합니다.

1.  (전제조건) 데이터를 복원할 수 있는, 비어 있는 새 데이터베이스를 작성하십시오.
    
    ```sh
    curl https://username:password@myhost.cloudant.com/couchbackup-demo-restore -X PUT
    ```
    {:codeblock}

2.  `couchrestore` 명령을 실행하십시오.
    
    ```sh
    cat couchbackup-demo-backup.txt | couchrestore --db couchbackup-demo-restore
    ```
    {:codeblock}
    
3.  결과를 검토하십시오. 
    
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

이제까지, 데이터베이스를 백업 및 복원하고 로그 파일을 작성했습니다. [재해 복구 및 백업](../guides/disaster-recovery-and-backup.html#disaster-recovery-and-backup),
[교차 지역 재해 복구를 위한 {{site.data.keyword.cloudant_short_notm}} 구성](../guides/active-active.html#configuring-cloudant-for-cross-region-disaster-recovery),
[{{site.data.keyword.cloudant_short_notm}} 백업 및 복원](../guides/backup-cookbook.html#cloudant-backup-and-recovery)에 대한 자세한 정보는 {{site.data.keyword.cloudant_short_notm}} 문서를 참조하십시오.   
