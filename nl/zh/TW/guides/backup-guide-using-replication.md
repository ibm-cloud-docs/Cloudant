---

copyright:
  years: 2015, 2019
lastupdated: "2019-06-12"

keywords: incremental backups, create an incremental backup, restore a database, how to back up example, how to restore example

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

# 抄寫增量備份
{: #replication-incrementals}

本手冊包含有關 {{site.data.keyword.cloudantfull}} 備份的較舊或「已淘汰」指引。如需現行備份指引，請參閱[災難回復和備份](/docs/services/Cloudant?topic=cloudant-disaster-recovery-and-backup#disaster-recovery-and-backup)手冊。
{: deprecated}

資料庫備份保護您的資料免於可能的遺失或毀損。
{: shortdesc}

您可以使用 {{site.data.keyword.cloudant_short_notm}} 抄寫機能來建立資料庫備份，並將它儲存在 {{site.data.keyword.cloudant_short_notm}} 叢集上。然後，您可以從這些備份中將資料、整個資料庫或特定的 JSON 文件還原至正式作業叢集。

使用 {{site.data.keyword.cloudant_short_notm}} 抄寫時，資料庫備份可將您的資料庫內容儲存至檢查點。您可以「回復」至特定檢查點。檢查點並非專指精確時間。反之，它是備份期間發生特定變更之後當時資料庫的記錄。如此一來，備份可以保留資料庫在所選取時間的狀態。

## 增量備份
{: #incremental-backups}

如果您是「企業」客戶，則可以使用每日增量備份功能。如需相關資訊，請參閱[災難回復和備份](/docs/services/Cloudant?topic=cloudant-disaster-recovery-and-backup#disaster-recovery-and-backup)。

如果您不是「企業」客戶，或偏好建立自己的備份，則可以使用 {{site.data.keyword.cloudant_short_notm}} 抄寫機能來建立資料庫備份。

簡單方法為將整個資料庫抄寫至附上日期的備份資料庫。此方法適用且容易執行。但是，如果您需要多個復原點的備份（例如七個每日備份及四個每週備份），則必須將資料庫的完整副本儲存在每一個新的備份資料庫中。完整副本可能需要使用大量的磁碟空間，尤其是如果您的資料庫很大。

或者，增量備份也會是很好的解決方案，因為它只會儲存自前次備份後經過變更的文件。

此處理程序很簡單。一開始，您會建立整個資料庫的備份。在第一次備份之後，您可以執行每日「增量」備份，_只_ 備份資料庫中自前次備份後經過變更的項目。此抄寫會變成每日備份。

您可以將備份配置為定期觸發。不過，每一個間隔必須是 24 小時以上。換言之，您可以執行每日備份，但不能執行每小時備份。
{: note}

## 建立增量備份
{: #creating-an-incremental-backup}

增量備份僅儲存備份之間的差異。來源資料庫每隔 24 小時就會抄寫至目標資料庫。

抄寫會使用順序值，以識別在 24 小時期間經過變更的文件。備份作業的運作方式為使用抄寫來取得並儲存檢查點。檢查點是另一個具有內部名稱的文件。備份作業會結合日期及備份作業名稱來建立名稱。此名稱可讓您在回復或累積更新處理程序中更輕鬆地識別檢查點。

若要建立增量備份，請執行下列步驟：

1.  尋找前次抄寫之檢查點文件的 ID。它儲存在 `_replicator` 資料庫中找到之抄寫文件的 `_replication_id` 欄位中。
2.  開啟位於 `/$DATABASE/_local/$REPLICATION_ID` 的檢查點文件，其中 `$REPLICATION_ID` 是您在前一個步驟中找到的 ID，而 `$DATABASE` 是來源或目標資料庫的名稱。文件通常存在於這兩個資料庫上，但也可能只存在於一個資料庫上。
3.  在檢查點文件中找到的歷程陣列中，搜尋第一個元素的 `recorded_seq` 欄位。
4.  抄寫至新的增量備份資料庫，同時將抄寫文件中的 [`since_seq` 欄位](/docs/services/Cloudant?topic=cloudant-replication-api#the-since_seq-field)設為前一個步驟中找到之 `recorded_seq` 欄位的值。

根據定義，使用 `since_seq` 選項會略過一般的檢查點檢查作業機能。務必小心使用 `since_seq`。
{: note}

## 還原資料庫
{: #restoring-a-database}

若要從增量備份中還原資料庫，請將每一個增量備份抄寫至新的資料庫，從最新的增量開始。

您可能會從最舊的備份開始，然後依序套用後續的備份。不過，先從最新的增量備份中進行抄寫較快，因為更新的文件只會寫入目標資料庫一次。任何文件若比已在新資料庫的副本還要舊，則會跳過。


## 範例
{: #an-example}

此範例顯示如何：

1.  設定資料庫來使用增量備份。
2.  執行完整備份。
3.  設定及執行增量備份。
4.  還原備份。

### 在這裡使用的常數
{: #constants-that-are-used-here}

```sh
# save base URL and the content type in shell variables
$ url='https://$ACCOUNT:$PASSWORD@$ACCOUNT.cloudant.com'
$ ct='Content-Type: application-json'
```
{: codeblock}

假設您需要備份某個資料庫。您要在星期一建立完整備份，在星期二建立增量備份。

您可以使用 `curl` 及 [`jq` ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](http://stedolan.github.io/jq/){: new_window} 指令來執行這些作業。實際上，您可以使用任何 HTTP 用戶端。

### 步驟 1：確認具有三個資料庫
{: #step-1-check-that-you-have-three-databases}

在此範例中，您需要三個資料庫：

-   原始資料庫，保留您要備份的資料。
-   兩個增量資料庫，用於星期一 (`backup-monday`) 及星期二 (`backup-tuesday`)。

_顯示如何使用 HTTP 確認您具有三個要在此範例中使用之資料庫的範例：_

```http
PUT /original HTTP/1.1
PUT /backup-monday HTTP/1.1
PUT /backup-tuesday HTTP/1.1
```
{: codeblock}

_顯示如何使用指令行確認您具有三個要在此範例中使用之資料庫的範例：_

```sh
$ curl -X PUT "${url}/original"
$ curl -X PUT "${url}/backup-monday"
$ curl -X PUT "${url}/backup-tuesday"
```
{: codeblock}

### 步驟 2：建立 `_replicator` 資料庫
{: #step-2-create-the-_replicator-database}

如果不存在，請建立 `_replicator` 資料庫。

*使用 HTTP 建立 `_replicator` 資料庫：*

```http
PUT /_replicator HTTP/1.1
```
{: codeblock}

*使用指令行建立 `_replicator` 資料庫：*

```sh
curl -X PUT "${url}/_replicator"
```
{: pre}

### 步驟 3：備份整個（原始）資料庫
{: #step-3-back-up-the-entire-original-database}

在星期一，您要第一次備份您的所有資料。透過將 `original` 中的一切抄寫至 `backup-monday` 來建立此備份。

_使用 HTTP 在星期一執行完整備份：_

```http
PUT /_replicator/full-backup-monday HTTP/1.1
Content-Type: application/json
```
{: codeblock}

_使用指令行在星期一執行完整備份：_

```sh
$ curl -X PUT "${url}/_replicator/full-backup-monday" -H "$ct" -d @backup-monday.json
# where backup-monday.json describes the backup.
```
{: codeblock}

_說明完整備份的 JSON 文件：_
 
```json
{
    "_id": "full-backup-monday",
    "source": "${url}/original",
    "target": "${url}/backup-monday"
}
```
{: codeblock}

### 步驟 4：準備增量備份第 1 部分 - 取得檢查點 ID
{: #step-4-prepare-incremental-backup-part-1-get-checkpoint-id}

在星期二，您要執行增量備份，而不是另一個完整備份。

若要啟動增量備份，您需要兩個值：

-   檢查點 ID。
-   [`recorded_seq` 值](#step-5-prepare-incremental-backup-part-2-get-recorded_seq-value)。

這些值會識別前次備份結束的位置，並決定啟動下一個增量備份的位置。在取得這些值之後，您可以執行增量備份。

您會先尋找檢查點 ID 值。此值儲存在 `_replicator` 資料庫內抄寫文件的 `_replication_id` 欄位中。

*使用 HTTP 取得檢查點 ID 來協助尋找 `recorded_seq` 值：*

```http
GET /_replicator/full-backup-monday HTTP/1.1
# Search for the value of _replication_id
```
{: codeblock}

*使用指令行取得檢查點 ID 來協助尋找 `recorded_seq` 值：*

```sh
replication_id=$(curl "${url}/_replicator/full-backup-monday" | jq -r '._replication_id')
```
{: pre}

### 步驟 5：準備增量備份第 2 部分 - 取得 `recorded_seq` 值
{: #step-5-prepare-incremental-backup-part-2-get-recorded_seq-value}

在取得檢查點 ID 之後，請用它來取得 `recorded_seq` 值。此值可在歷程陣列（位於原始資料庫內的 `/_local/${replication_id}` 文件中）的第一個元素中找到。

您現在具有 `recorded_seq` 值。此值識別已從原始資料庫抄寫的最後一份文件。

*使用 HTTP 從原始資料庫中取得 `recorded_seq`：*

```http
GET /original/_local/${replication_id} HTTP/1.1
# Search for the first value of recorded_seq in the history array
```
{: codeblock}

*使用指令行從原始資料庫中取得 `recorded_seq`：*

```sh
recorded_seq=$(curl "${url}/original/_local/${replication_id}" | jq -r '.history[0].recorded_seq')
```
{: pre}

### 步驟 6：執行增量備份
{: #step-6-run-an-incremental-backup}

既然您具有檢查點 ID 及 `recorded_seq`，就可以啟動星期二的增量備份。此備份會抄寫_自_ 前次抄寫後所做的全部文件變更。

抄寫完成時，您就有已完成的增量備份。備份由原始資料庫中的所有文件組成，而且可以透過同時擷取 `backup-monday` _及_ `backup-tuesday` 資料庫的內容來進行還原。

_使用 HTTP 執行星期二的增量備份：_

```http
PUT /_replicator/incr-backup-tuesday HTTP/1.1
Content-Type: application/json
```
{: codeblock}

_使用指令行執行星期二的增量備份：_

```sh
curl -X PUT "${url}/_replicator/incr-backup-tuesday" -H "${ct}" -d @backup-tuesday.json
```
{: pre}

_說明星期二增量備份的 JSON 文件：_
 
```json
{
    "_id": "incr-backup-tuesday",
    "source": "${url}/original",
    "target": "${url}/backup-tuesday",
    "since_seq": "${recorded_seq}"
}
```
{: codeblock}

### 步驟 7：還原星期一備份
{: #step-7-restore-the-monday-backup}

若要從備份中還原，請將起始完整備份以及任何增量備份抄寫至新的資料庫。

例如，若要還原星期一的狀態，您將從 `backup-monday` 資料庫進行抄寫。

_使用 HTTP 從 `backup-monday` 資料庫中還原：_

```sh
PUT /_replicator/restore-monday HTTP/1.1
Content-Type: application/json
```
{: codeblock}

_使用指令行從 `backup-monday` 資料庫中還原：_

```sh
curl -X PUT "${url}/_replicator/restore-monday" -H "$ct" -d @restore-monday.json
```
{: pre}

_說明還原的 JSON 文件：_
 
```json
{
    "_id": "restore-monday",
    "source": "${url}/backup-monday",
    "target": "${url}/restore",
    "create_target": true  
}
```
{: codeblock}

### 步驟 8：還原星期二備份
{: #step-8-restore-the-tuesday-backup}

若要還原星期二的資料庫，請先從 `backup-tuesday` 中抄寫，然後再從 `backup-monday` 中抄寫。

該順序不是打字排版錯誤；實際上，_確實打算_ 要先從星期二還原，_然後再_ 從星期一還原。
{: tip}

您可能依時間順序還原，但使用相反的順序，星期二更新的文件只需寫入至目標資料庫一次。會忽略星期一資料庫中儲存的舊版文件。

_使用 HTTP 還原星期二的備份，先取得最新的變更：_

```http
PUT /_replicator/restore-tuesday HTTP/1.1
Content-Type: application/json
```
{: codeblock}

_使用指令行還原星期二的備份，先取得最新的變更：_

```sh
curl -X PUT "${url}/_replicator/restore-tuesday" -H "$ct" -d @restore-tuesday.json
```
{: pre}

_要求還原星期二備份的 JSON 文件：_
 
```json
{
    "_id": "restore-tuesday",
    "source": "${url}/backup-tuesday",
    "target": "${url}/restore",
    "create_target": true  
}
```
{: codeblock}

_使用 HTTP 還原前次星期一的備份來完成回復：_

```http
PUT /_replicator/restore-monday HTTP/1.1
Content-Type: application/json
```
{: codeblock}

_使用指令行還原前次星期一的備份來完成回復：_

```http
curl -X PUT "${url}/_replicator/restore-monday" -H "$ct" -d @restore-monday.json
```
{: pre}

_要求還原星期一備份的 JSON 文件：_
 
```json
{
    "_id": "restore-monday",
    "source": "${url}/backup-monday",
    "target": "${url}/restore"
}
```
{: codeblock}

## 建議
{: #suggestions}

當先前資訊概述基本備份處理程序時，每一個應用程式都需要有自己的備份需求及策略。下列建議可能很有用。

### 排定備份
{: #scheduling-backups}

抄寫工作可能會大幅增加叢集上的負載。如果您是備份數個資料庫，最好將抄寫工作錯列在不同的時間，或叢集較不忙碌的時間。

#### 變更備份的 IO 優先順序
{: #changing-the-io-priority-of-a-backup}

您可以調整抄寫文件內 `x-cloudant-io-priority` 欄位的值，以變更備份工作的優先順序。

1.  在來源及目標欄位中，變更 `headers` 物件。
2.  在 headers 物件中，將 `x-cloudant-io-priority` 欄位值變更為 `"low"`。

_設定 IO 優先順序的 JSON 文件範例：_

```json
{
    "source": {
        "url": "https://user:pass@example.com/db",
        "headers": {
            "x-cloudant-io-priority": "low"
        }
    },
    "target": {
        "url": "https://user:pass@example.net/db",
        "headers": {
            "x-cloudant-io-priority": "low"
        }
    }
}
```
{: codeblock}

### 備份設計文件
{: #backing-up-design-documents}

如果在備份中包括您的設計文件，則會在備份目的地上建立索引。此作法會減慢備份處理程序的速度，並使用不必要的磁碟空間量。如果您不需要備份系統上的索引，請使用過濾器功能與抄寫搭配，以過濾掉設計文件。您也可以使用此過濾器功能來排除不想要的其他文件。

### 備份多個資料庫
{: #backing-up-multiple-databases}

如果您的應用程式使用每個使用者一個資料庫，或容許每一個使用者建立數個資料庫，則您需要為每一個新的資料庫建立備份工作。請確定您的抄寫工作並未同時開始。

## 需要協助嗎？
{: #need-help-}

抄寫及備份可能很棘手。如果遇到困難，請參閱[抄寫手冊](/docs/services/Cloudant?topic=cloudant-replication-guide#replication-guide)，或聯絡 [{{site.data.keyword.cloudant_short_notm}} 支援團隊 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](mailto:support@cloudant.com){: new_window}。
