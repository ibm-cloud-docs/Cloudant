---

copyright:
  years: 2015, 2019
lastupdated: "2019-03-15"

keywords: find conflicts, resolve conflicts, merge changes, upload new revision, delete revision

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

<!-- Acrolinx: 2018-05-07 -->

# 衝突
{: #conflicts}

在分散式資料庫（其中資料副本可能儲存於多個位置）中，自然網路及系統特徵可能表示針對某個位置的儲存文件所做的變更無法立即更新或抄寫至資料庫的其他部分。

換言之，如果對不同文件副本單獨進行更新，則效果可能是造成與文件的正確最終內容不一致或「衝突」。

{{site.data.keyword.cloudantfull}} 嘗試警告您可能發生問題，以協助您避免衝突。
它會針對有問題的更新要求傳回 [`409` 回應](/docs/services/Cloudant?topic=cloudant-http#http-status-codes)來警告您。
不過，如果是在目前未連接至網路的系統上要求資料庫更新，則可能不會收到 `409` 回應。
例如，資料庫可能位在暫時與網際網路斷線的行動裝置上，因此目前無法檢查是否有進行其他潛在的衝突更新。

如果您要求一份處於衝突狀況的文件，則 {{site.data.keyword.cloudant_short_notm}} 會如預期傳回文件。
不過，傳回的版本是由考慮若干因素的內部演算法所決定；舉例而言，您不應該假設傳回的文件一律是最新版本。

如果您未檢查衝突，或無法解決衝突，則 {{site.data.keyword.cloudant_short_notm}} 資料庫會開始表現以下數種行為：

* 增加文件內容中的不一致，因為有越來越多的衝突文件。
* 增加資料庫大小，因為在衝突獲得解決之前必須保留所有衝突的文件。
* 降低效能，因為在嘗試識別衝突文件的「最佳可能」版本時，{{site.data.keyword.cloudant_short_notm}} 必須更努力運作以回應每一個及每項要求。

下列建議的作法可協助您決定何時檢查及解決衝突：

<table>
<tr>
<th>應用程式特徵</th>
<th>文件更新的頻率</th>
<th>在擷取時檢查衝突？</th>
<th>在更新時檢查衝突？</th>
</tr>
<tr>
<td>一律連接至網路（例如伺服器）。</td>
<td>經常</td>
<td>Y</td>
<td>-</td>
</tr>
<tr>
<td>一律連接至網路。</td>
<td>偶爾</td>
<td>-</td>
<td>Y</td>
</tr>
<tr>
<td>經常但不是一律連接至網路（例如筆記型電腦）。</td>
<td>經常</td>
<td>-</td>
<td>Y</td>
</tr>
<tr>
<td>經常但不是一律連接至網路。</td>
<td>偶爾</td>
<td>-</td>
<td>Y</td>
</tr>
<tr>
<td>偶爾連接至網路（例如平板電腦）。</td>
<td>經常</td>
<td>-</td>
<td>Y</td>
</tr>
</table>

## 尋找衝突
{: #finding-conflicts}

若要尋找可能影響文件的所有衝突，請在擷取文件時新增查詢參數 `conflicts=true`。
傳回時，產生的文件包含 `_conflicts` 陣列，其中包括所有衝突修訂的清單。

> 尋找文件衝突的範例對映函數：

```
function (doc) {
    if (doc._conflicts) {
        emit(null, [doc._rev].concat(doc._conflicts));
    }
}
```

若要尋找資料庫中多份文件的衝突，請撰寫[視圖](/docs/services/Cloudant?topic=cloudant-views-mapreduce#views-mapreduce)。
使用對映函數（例如提供的範例），您可以尋找每份衝突文件的所有修訂。

當您有這類視圖時，可以視需要用它來尋找及解決衝突。
或者，您也可能會在每一次抄寫之後查詢視圖，以立即識別及解決衝突。

## 如何解決衝突
{: #how-to-resolve-conflicts}

在您找到衝突之後，可以遵循 4 個步驟予以解決：

1.	[取得](#get-conflicting-revisions)衝突修訂。
2.	將它們[合併](#merge-the-changes)至應用程式，或詢問使用者想要執行的作業。
3.	[上傳](#upload-the-new-revision)新的修訂。
4.	[刪除](#delete-old-revisions)舊的修訂。

> 範例文件 - 第一個版本。

```json
{
  "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "1-7438df87b632b312c53a08361a7c3299",
    "name": "Samsung Galaxy S4",
    "description": "",
    "price": 650
}
```

讓我們考慮如何完成這項作業的範例。假設您有線上商店的產品資料庫。文件的第一個版本可能類似提供的範例。

> 文件的第二個版本（第一個修訂），新增了說明。

```json
{
  "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "2-61ae00e029d4f5edd2981841243ded13",
    "name": "Samsung Galaxy S4",
    "description": "Latest smartphone from Samsung",
    "price": 650
}
```

文件還沒有說明，因此可能會有人新增說明。

> _替代_ 第二個版本，簡介文件第一個版本的價格降低資料變更。

```json
{
  "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "2-f796915a291b37254f6df8f6f3389121",
    "name": "Samsung Galaxy S4",
    "description": "",
    "price": 600
}
```

同時，其他人（使用抄寫的資料庫）會降低價格。
會對文件的第一個版本進行此變更。
因此，價格降低變更不「知道」說明變更。

稍後，抄寫兩個資料庫時，可能不清楚文件這兩個替代版本中的哪一個版本是正確的。
這是衝突情境。

## 取得衝突修訂
{: #get-conflicting-revisions}

若要尋找文件的所有衝突修訂，請如常擷取該文件，但包括 `conflicts=true` 參數，類似於下列範例：

`http://ACCOUNT.cloudant.com/products/$_ID?conflicts=true`


> 文件擷取的範例回應，顯示衝突的修訂

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

如果文件有任何衝突，則您會收到與所提供範例（以已變更的說明或已變更的價格問題為基礎）類似的回應。

已_任意_ 選擇具有已變更價格的版本作為文件的最新版本。
您不應該將文件最近更新的過版本視為進行衝突解決的最新版本。

在此範例中，具有 `_rev` 值 `2-f796915a291b37254f6df8f6f3389121` 的已擷取文件與具有 `_rev` 值 `2-61ae00e029d4f5edd2981841243ded13` 的另一份文件之間視有發生衝突。
衝突的文件詳細資料註記在 `_conflicts` 陣列中。

通常，您可能會發現陣列只有一個元素，但可能會有許多衝突的修訂，而且各自列在陣列中。

## 合併變更
{: #merge-the-changes}

您的應用程式必須識別所有潛在變更並進行核對，有效地合併正確及有效的更新來產生文件的單一非衝突版本。

若要比較修訂並識別變更內容，您的應用程式必須從資料庫中擷取所有版本。如前所述，首先我們會擷取文件及任何衝突版本的詳細資料。作法是使用類似於下列內容的指令，這也會要求 `_conflicts` 陣列：

`http://$ACCOUNT.cloudant.com/products/$_ID?conflicts=true
`

這項擷取會提供所儲存文件的現行版本，_以及_ 同時必須擷取之所有其他衝突文件的清單（例如 `...rev=2-61ae00e029d4f5edd2981841243ded13` 及 `...rev=1-7438df87b632b312c53a08361a7c3299`）。也會擷取及儲存所有這些其他衝突的版本，例如：

  `http://$ACCOUNT.cloudant.com/products/$_ID?rev=2-61ae00e029d4f5edd2981841243ded13`
  `http://$ACCOUNT.cloudant.com/products/$_ID?rev=1-7438df87b632b312c53a08361a7c3299`

在文件的所有衝突修訂可供使用之後，您就可以繼續解決衝突。

在較舊的情境中，文件版本之間的差異在於文件內的不同欄位，可更輕鬆地進行合併。

較複雜的衝突可能需要相應進行更多分析。
若要協助，您可從各種不同的衝突解決策略進行選擇，例如：

*	時間型：使用第一個或最新編輯的簡單測試。
*	使用者評量：向使用者報告衝突，然後使用者會決定最佳解決。
*	更準確的合併演算法：這些通常用於[版本控制系統](https://en.wikipedia.org/wiki/Merge_%28version_control%29)。範例為 [3 向合併](https://en.wikipedia.org/wiki/Merge_%28version_control%29#Three-way_merge)。

如需如何實作這些變更的實際範例，請參閱[這個含有範例程式碼的專案](https://github.com/glynnbird/deconflict)。

## 上傳新的修訂
{: #upload-the-new-revision}

> 解決及合併先前衝突修訂中的變更之後的最終修訂。

```json
{
  "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "3-daaecd7213301a1ad5493186d6916755",
    "name": "Samsung Galaxy S4",
    "description": "Latest smartphone from Samsung",
    "price": 600
}
```

評量及解決衝突之後，您可以建立包含現行及最終資料的文件。
這個全新文件會上傳至資料庫。

## 刪除舊的修訂
{: #delete-old-revisions}

> 刪除舊修訂的要求範例。

```http
DELETE http://$ACCOUNT.cloudant.com/products/$_ID?rev=2-61ae00e029d4f5edd2981841243ded13

DELETE http://$ACCOUNT.cloudant.com/products/$_ID?rev=2-f796915a291b37254f6df8f6f3389121
```

最終步驟是刪除舊的修訂。
作法是傳送 `DELETE` 要求，指定要刪除的修訂。

刪除文件的較舊版本時，會將與該文件相關聯的衝突標示為已解決。
您可以使用前述的[尋找衝突](#finding-conflicts)，將 `conflicts` 參數設為 true 來重新要求文件，以驗證不存在任何衝突。
