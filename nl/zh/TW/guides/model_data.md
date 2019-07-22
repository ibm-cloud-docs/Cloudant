---

copyright:
  years: 2015, 2019
lastupdated: "2019-06-12"

keywords: immutable data, pre-calculate results, de-normalise data, avoid conflicts, conflict resolution

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

# 對資料建模以調整大小的五項提示
{: #five-tips-for-modeling-your-data-to-scale}

本篇文章更細微討論了如何對應用程式資料建模，以便能大規模有效率地運作。
{: shortdesc}

*（本手冊基於 Mike Rhodes 的部落格文章：[My Top 5 Tips for Modeling Data to Scale ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://cloudant.com/blog/my-top-5-tips-for-modeling-your-data-to-scale/)，最初發佈於 2013 年 12 月 17 日。）*

在 {{site.data.keyword.cloudantfull}} 上建立資料模型的方式會大幅影響如何擴充應用程式。我們的基礎資料模型與關聯式模型相當不同，而忽略這項區別可能是未來發生效能問題的原因。

一如既往地，成功建模需要在易用性與您希望實現的效能性質之間達到平衡。

不再囉嗦，讓我們開始吧。

## 考量不可變的資料
{: #consider-immutable-data}

如果您要以一秒一次以上的速率變更相同狀態部分，請考量將文件設為不可變。這會大幅降低您建立衝突文件的可能性。

相反地，如果您要以每十秒小於一次的速率來更新給定的文件，則就地更新資料模型（亦即，更新現有文件）可大幅簡化應用程式碼。

一般而言，根據不可變資料的資料模型需要使用視圖來彙總包含現行狀態的文件。預先運算視圖時，這應該不會對應用程式效能產生不利的影響。

## 這對您考量不可變資料有幫助的原因 
{: #why-this-helps-you-consider-immutable-data}

`https://$ACCOUNT.cloudant.com/` 介面的後方是分散式資料庫。在叢集內，會將文件分割為數個共同形成資料庫的 Shard。接著將這些 Shard 分散到叢集中的節點。這可讓我們支援大小有許多 TB 的資料庫。

依預設，除了將資料庫分割為 Shard 之外，所有 Shard 都有三個副本或 Shard 抄本，且每個都位在資料庫叢集的不同節點上。這容許資料庫在節點失敗時繼續負責處理要求。因此，儲存文件包含寫入至三個節點。這表示如果同時對相同的文件進行兩項更新，則某個節點子集可能會接受第一項更新，而另一個子集可能會接受第二項更新。叢集發現這項不相符時，會使用與一般抄寫針對產生衝突之並行更新的相同處理方式，來結合文件。

衝突文件會損害效能；請參閱下列文字以瞭解有關為何會發生這種情況的更多詳細資料。高度並行就地更新模式也會增加拒絕寫入的可能性，因為 `_rev` 不是預期參數，而此參數會強制重試應用程式，因此延遲處理。

我們發現此衝突文件情境的更新頻率極可能高於一秒一次，但建議每十秒更新多次的不可變文件位在安全端。

## 使用視圖來預先計算結果，而非搜尋索引
{: #use-views-to-pre-calculate-results-rather-than-as-search-indexes}

嘗試讓資料庫為您執行工作，而不是使用視圖作為美化的搜尋索引（讓我取得所有`人員`文件）。例如，搭配使用視圖與複合金鑰，使用 `_sum` 內建減少函數依年、月、日、半天及小時來預先計算工作時數，而不是擷取全部一萬人的文件來計算其結合的工作時數。您將省去應用程式中的一些工作，並容許資料庫專注於負責處理多個小型要求，而不是從磁碟讀取大量資料來負責處理單一大型要求。

## 這對您使用視圖預先計算結果有幫助的原因
{: #why-this-helps-you-use-views-to-pre-calculate-results}

這相當直接明確。首先，請注意，會同時預先運算對映及減少。這表示要求減少函數的結果是價廉的作業，特別是相較於從磁碟內存儲存空間串流數百甚至數千份文件所需的大量 IO。

在較低的層次，當節點收到檢視要求時，它會要求節點針對每一個 Shard 中文件的檢視要求結果保留視圖資料庫的 Shard 抄本。在它收到回答（採用每個 Shard 抄本的第一個回答）時，負責處理檢視要求的節點會結合結果，並將最終結果串流到用戶端。涉及更多文件時，每一個抄本需要較長的時間才能串流磁碟中的結果並串流到網路。此外，在結合每一個資料庫 Shard 的結果時，負責處理要求的節點需要進行較多的處理。

整體而言，目標是檢視要求需要每個 Shard 的最少量資料，並將資料傳輸時間到降到最低，且結合在一起以形成最終結果。使用視圖的功能來預先運算聚集資料，是達到這個目標的一種方法。這會明顯減少應用程式等待要求完成所需的時間。

## 將資料去標準化
{: #de-normalise-your-data}

在關聯式資料庫中，將資料標準化通常是儲存資料的最有效方式。當您可以使用 JOIN 來輕鬆結合多張表格的資料時，這十分有意義。在 {{site.data.keyword.cloudant_short_notm}} 中，您可能較需要 HTTP GET 要求來取得每一筆資料，因此減少建置整個建模實體所需的要求數目可讓您更快速地向使用者呈現資訊。

使用視圖可讓您獲得將資料標準化的許多好處，同時維護去標準化版本以提高效率。

例如，在關聯式綱目中，您通常會以不同的表格來呈現標籤，並使用連接表格來結合標籤與其相關聯的文件，以容許快速查閱具有給定標籤的所有文件。

在 {{site.data.keyword.cloudant_short_notm}} 中，您會將標籤儲存在每一份文件的清單中。接著會使用視圖，透過[在視圖的對映函數中發出每一個標籤作為索引鍵](/docs/services/Cloudant?topic=cloudant-views-mapreduce#views-mapreduce)，以取得具有給定標籤的文件。查詢視圖以找出給定索引鍵就會提供所有具有該標籤的文件。

## 這對您將資料去標準化有幫助的原因
{: #why-this-helps-you-de-normalize-your-data}

這涉及到您應用程式提出的 HTTP 要求數目。開啟 HTTP 連線（特別是 HTTPS）有其成本，因此，重複使用連線有所幫助時，整體提出較少的要求將加速應用程式可處理資料的速率。

附帶的好處是，去標準化文件及預先運算的視圖通常可讓您具有應用程式事先產生所需的值，而不是在查詢時即時建構。

## 使用更精細的文件來避免發生衝突
{: #avoid-conflicts-by-using-finer-grained-documents}

與將資料去標準化的建議相對的是接下來這個建議部分：使用精細文件來減少並行修改產生衝突的可能性。這有點像將資料標準化。減少 HTTP 要求數目與避免衝突之間需要達成平衡。

例如，取得包含作業清單的醫療記錄：

```json
{
    "_id": "Joe McIllness",
    "operations": [
        { "surgery": "heart bypass" },
        { "surgery": "lumbar puncture" }
    ]
}
```
{: codeblock}

如果 Joe 很不幸，同時有大量作業要做，那麼對一個文件進行大量並行更新有可能會建立衝突文件，如前所述。最好將作業分成個別文件，而這些個別文件參照 Joe 的人員文件並使用視圖將事物連接在一起。若要呈現每一個作業，您應上傳文件，例如下列兩個範例：

```json
{
    "type": "operation",
    "patient": "Joe McIllness",
    "surgery": "heart bypass"
}
```
{: codeblock}

```json
{
    "type": "operation",
    "patient": "Joe McIllness",
    "surgery": "lumbar puncture"
}
```
{: codeblock}

發出 `"patient"` 欄位作為視圖中的索引鍵，接著容許查詢所有作業以找出特定病患。同樣地，使用視圖來協助將個別文件的整個給定實體聯合在一起，有助於保持較低的 HTTP 要求數目，即使我們已分割單一建模實體的資料也一樣。

## 這對您避免衝突有幫助的原因
{: #why-this-helps-you-avoid-conflicts}

避免衝突文件有助於加速對 {{site.data.keyword.cloudant_short_notm}} 資料庫執行的許多作業。
這是因為有處理程序可處理每次讀取文件時使用的現行獲勝修訂：單一文件擷取、具有 `include_docs=true` 的呼叫、視圖建置等等。

獲勝修訂是文件整體樹狀結構中的特定修訂。請回想一下，{{site.data.keyword.cloudant_short_notm}} 上的文件實際上是修訂的樹狀結構。任意但唯一的演算法會選取這個樹狀結構中要在針對文件提出要求時傳回的其中一個非刪除葉。分支因素較高的大型樹狀結構的處理時間，會比沒有分支或分支較少的文件樹狀結構還要久：需要追蹤每一個分支，以查看它是否為獲勝修訂的候選項目。潛在勝利者接著需要彼此進行比較，才能做出最終選擇。

{{site.data.keyword.cloudant_short_notm}} 明顯可以妥善處理少量分支（畢竟，抄寫依賴可分支文件以避免捨棄資料的事實），但到達病態層次時（特別是未解決衝突時），瀏覽文件樹狀結構會變得極為耗時並使用大量記憶體。

## 內建衝突解決
{: #build-in-conflict-resolution}

在 {{site.data.keyword.cloudant_short_notm}} 這類最終一致的系統中，最後一定會發生衝突。如前所述，這是實現可調整性和資料備援要付出的代價。

透過快速解決衝突且不需要操作員協助的方式來建構資料，可協助讓資料庫流暢地進行。在不需要使用者參與的情況下自動解決衝突的能力，也會大幅改善其體驗，而且可能會減少組織的支援負擔。

作法都是應用程式特有的，但以下有一些提示：

-   可能的話，避免使用跨文件欄位的不變量。這樣一來，簡單合併作業（取得每一個衝突文件修訂中的已變更欄位）可能較適合。這樣可以取得較簡單且較健全的應用程式碼。
-   容許文件獨立。擷取其他文件來找出正確解決方式的需要，會延遲解決衝突的時間。您也可能會取得與所解決文件不一致的其他文件版本，因而讓正確解決更為困難。而且其他文件發生衝突時，該怎麼辦？

## 這對您內建衝突解決有幫助的原因 
{: #why-this-helps-you-build-in-conflict-resolution}

如前所述，嚴重衝突的文件對資料庫會造成嚴重損害。內建從頭解決衝突的功能十分有助於避免病態衝突的文件。

## 摘要
{: #summary}

這些提示示範資料建模將影響應用程式效能的一些方式。{{site.data.keyword.cloudant_short_notm}} 的資料儲存庫有一些可查看且可善加利用的特定特徵，確保資料庫效能會隨著應用程式成長而調整。我們瞭解這項變動可能會混淆，因此，現在一律會提供建議。

如需進一步的閱讀資料，請參閱有關 [Foundbite 的資料模型 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://cloudant.com/blog/foundbites-data-model-relational-db-vs-nosql-on-cloudant/){: new_window} 的討論或 [Twilio 上來自我們朋友的範例 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://www.twilio.com/blog/2013/01/building-a-real-time-sms-voting-app-part-3-scaling-node-js-and-couchdb.html){: new_window}。

