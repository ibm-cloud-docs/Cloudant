---

copyright:
  years: 2015, 2019
lastupdated: "2019-06-12"

keywords: revisions, distributed databases, conflicts, resolve conflicts, find conflicting revisions, merge changes, upload new revisions, delete old revisions

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

# 文件版本化和 MVCC
{: #document-versioning-and-mvcc}

[多版本並行控制 (MVCC) ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://en.wikipedia.org/wiki/Multiversion_concurrency_control){: new_window} 是 {{site.data.keyword.cloudantfull}} 資料庫確定資料庫叢集中的所有節點都只包含文件[最新版本](/docs/services/Cloudant?topic=cloudant-documents#documents)的方式。
{: shortdesc}

因為 {{site.data.keyword.cloudant_short_notm}} 資料庫[最終會一致](/docs/services/Cloudant?topic=cloudant-cap-theorem#cap-theorem)，所以這是必要項目，可防止因過期文件之間的同步化而導致節點之間造成不一致。

「多版本並行控制 (MVCC)」會啟用 {{site.data.keyword.cloudant_short_notm}} 資料庫的並行讀取及寫入權。
MVCC 是某種形式的[樂觀併行 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](http://en.wikipedia.org/wiki/Optimistic_concurrency_control){: new_window}。它會在 {{site.data.keyword.cloudant_short_notm}} 資料庫上進行更快速的讀取及寫入作業，因為不需要對讀取或寫入作業進行資料庫鎖定。
MVCC 也會在 {{site.data.keyword.cloudant_short_notm}} 資料庫節點之間啟用同步化。

## 修訂
{: #revisions}

{{site.data.keyword.cloudant_short_notm}} 資料庫中的每份文件都會有指出其修訂號碼的 `_rev` 欄位。

當您插入或修改文件時，伺服器會將修訂號碼新增至文件。當您變更或讀取文件時，會在伺服器回應中包含此號碼。將使用簡單計數器與文件雜湊的組合來建構 `_rev` 值。

修訂號碼的兩個主要用途是協助：

1.  判定必須在伺服器之間抄寫的文件。
2.  確認用戶端正在嘗試修改最新版本的文件。

您必須在[更新文件](/docs/services/Cloudant?topic=cloudant-documents#update)時指定前一個 `_rev`，否則您的要求會失敗，並傳回 [409 錯誤](/docs/services/Cloudant?topic=cloudant-http#http-status-codes)。

不應該使用 `_rev` 來建置版本控制系統。原因是它為伺服器所使用的內部值。此外，較舊的文件修訂是暫時項目，因此會定期予以移除。
{: note}

您可以使用 `_rev` 來查詢特定修訂，不過，稱為[壓縮 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](http://en.wikipedia.org/wiki/Data_compaction){: new_window} 的處理程序會定期刪除較舊的修訂。壓縮的結果是使用 `_rev` 查詢特定文件修訂以取得您文件的修訂歷程時，您無法依賴成功回應。如果您需要文件的版本歷程，則解決方案是針對每一個修訂[建立新的文件](/docs/services/Cloudant?topic=cloudant-documents#create-document)。

## 分散式資料庫和衝突
{: #distributed-databases-and-conflicts}

分散式資料庫是在未持續連線至 {{site.data.keyword.cloudant_short_notm}} 上本身為分散式的主要資料庫的情況下運作，因此根據相同舊版本的更新仍然可能會發生衝突。

若要尋找衝突，請在擷取文件時新增查詢參數 [`conflicts=true`](/docs/services/Cloudant?topic=cloudant-databases#get-changes)。回應包含具有所有衝突修訂的 `_conflicts` 陣列。

若要尋找資料庫中多份文件的衝突，請撰寫視圖。

下列對映函數範例會發出每份發生衝突的文件的所有衝突修訂。

_尋找發生衝突的文件的對映函數範例：_

```javascript
function (doc) {
    if (doc._conflicts) {
        emit(null, [doc._rev].concat(doc._conflicts));
    }
}
```
{: codeblock}

您可以定期查詢此視圖，並視需要解決衝突，或在每一次抄寫之後查詢視圖。

## 解決衝突的步驟
{: #steps-to-resolve-conflicts}

在您找到衝突之後，可以使用 4 個步驟進行解決。

1.  [取得](#get-conflicting-revisions)衝突修訂。
2.  將它們[合併](#merge-the-changes)至應用程式，或詢問使用者想要執行的作業。
3.  [上傳](#upload-the-new-revision)新的修訂。
4.  [刪除](#delete-old-revisions)舊的修訂。

讓我們考慮如何完成這項作業的範例。假設您有線上商店的產品資料庫。文件的第一個版本可能類似下列範例：

```json
{
    "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "1-7438df87b632b312c53a08361a7c3299",
    "name": "Samsung Galaxy S4",
    "description": "",
    "price": 650
}
```
{: codeblock}

文件還沒有說明時，可能會有人新增說明：

_透過新增說明所建立的文件的第二個版本：_

```json
{
    "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "2-61ae00e029d4f5edd2981841243ded13",
    "name": "Samsung Galaxy S4",
    "description": "Latest smartphone from Samsung",
    "price": 650
}
```
{: codeblock}

同時，其他人（使用抄寫的資料庫）會降低價格：

_因不同 `price` 值而與前一個修訂衝突的不同修訂：_

```json
{
    "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "2-f796915a291b37254f6df8f6f3389121",
    "name": "Samsung Galaxy S4",
    "description": "",
    "price": 600
}
```
{: codeblock}

接著會抄寫兩個資料庫。文件版本中的差異會導致衝突。

### 取得衝突修訂
{: #get-conflicting-revisions}

您可以使用 `conflicts=true` 選項來識別發生衝突的文件。

_尋找發生衝突的文件的範例：_

```http
http://$ACCOUNT.cloudant.com/products/$_ID?conflicts=true
```
{: codeblock}

_顯示影響文件的衝突修訂的範例回應：_

```json
{
    "_id":"74b2be56045bed0c8c9d24b939000dbe",
    "_rev":"2-f796915a291b37254f6df8f6f3389121",
    "name":"Samsung Galaxy S4",
    "description":"",
    "price":600,
    "_conflicts":["2-61ae00e029d4f5edd2981841243ded13"]
}
```
{: codeblock}

已任意選擇具有已變更價格的版本，因為文件的最新版本以及與另一個版本的衝突的標記方式是在 `_conflicts` 陣列中提供該其他版本的 ID。在大部分情況下，此陣列只有一個元素，但可能會有許多衝突修訂。

### 合併變更
{: #merge-the-changes}

若要比較修訂以查看變更內容，您的應用程式會從資料庫中取得所有版本。

_從資料庫中擷取文件的所有版本的範例指令：_

```http
http://$ACCOUNT.cloudant.com/products/$_ID
http://$ACCOUNT.cloudant.com/products/$_ID?rev=2-61ae00e029d4f5edd2981841243ded13
http://$ACCOUNT.cloudant.com/products/$_ID?rev=1-7438df87b632b312c53a08361a7c3299
```
{: codeblock}

因為衝突變更是針對文件的不同欄位，所以很容易就可以合併它們。

針對較複雜的衝突，可能需要其他解決方案策略：

*   時間型：使用第一次或最後一次編輯內容。
*   使用者人為介入：向使用者報告衝突，並讓他們決定最佳解決方案。
*   更準確的演算法：例如，文字欄位的 3 方合併。

如需如何實作變更合併的實際範例，請參閱這個含有[範例程式碼 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://github.com/glynnbird/deconflict){: new_window} 的專案。

### 上傳新的修訂
{: #upload-the-new-revision}

下一步是建立可解決衝突的文件，並使用它來更新資料庫。

_合併兩個衝突修訂的變更的範例文件：_

```json
{
    "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "3-daaecd7213301a1ad5493186d6916755",
    "name": "Samsung Galaxy S4",
    "description": "Latest smartphone from Samsung",
    "price": 600
}
```
{: codeblock}

### 刪除舊的修訂
{: #delete-old-revisions}

最後，您可以將 `DELETE` 要求傳送至含有我們要刪除之修訂的 URL，來刪除舊的修訂。

_使用 HTTP 刪除舊文件修訂的範例要求：_

```http
DELETE https://$ACCOUNT.cloudant.com/products/$_ID?rev=2-61ae00e029d4f5edd2981841243ded13
```
{: codeblock}

_使用指令行刪除舊文件修訂的範例要求：_

```sh
curl "https://$ACCOUNT.cloudant.com/products/$_ID?rev=2-f796915a291b37254f6df8f6f3389121" -X DELETE
```
{: codeblock}

此時，即會解決影響文件的衝突。驗證這項作業的方式是將 `conflicts` 參數設為 `true` 來重新 `GET`（取得）文件。
