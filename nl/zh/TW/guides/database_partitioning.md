---

copyright:
  years: 2019
lastupdated: "2019-06-12"

keywords: database shards, non-partitioned databases, partition key, global query, partition query, create partition database, create partition query index

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

<!-- Acrolinx: 2018-08-17 -->

# 資料庫分割
{: #database-partitioning}

{{site.data.keyword.cloudantfull}} 支援兩種類型的資料庫：

- 分割
- 未分割

_分割_ 資料庫提供顯著的效能及成本優勢，但需要您指定資料的邏輯分割。下列文字中將對此進行更詳細的說明。

或者，可以建立_未分割_ 資料庫。此類型的資料庫可以更輕鬆地使用，因為不需要定義分割方法，但只能建立廣域次要索引。

{{site.data.keyword.cloudant_short_notm}} 強烈建議您使用分割資料庫，以取得最佳的長期資料庫效能，其中資料模型容許進行文件的邏輯分割。

分割類型的資料庫是在建立資料庫時設定。建立資料庫時，請使用 `partitioned` 查詢字串參數，來設定資料庫是否為分割資料庫。`partitioned` 的預設值為 `false`，以維護舊版相容性。

無法變更現有資料庫的分割類型。

## 資料庫 Shard
{: #database-shards}

在閱讀此文件之前，您必須瞭解 {{site.data.keyword.cloudant_short_notm}} 內的 [Shard 概念](/docs/services/Cloudant?topic=cloudant-how-is-data-stored-in-ibm-cloudant-#how-is-data-stored-in-ibm-cloudant-)。

## 未分割資料庫
{: #non-partitioned-databases}

未分割資料庫是較舊類型的 {{site.data.keyword.cloudant_short_notm}} 資料庫，若您先前使用 CouchDB 或 {{site.data.keyword.cloudant_short_notm}}，這也就是您熟悉的資料庫。

在未分割資料庫內，文件會根據其文件 ID 的轉換，以任意方式分散到 Shard。因此，文件 ID 與其最終所在的 Shard 之間沒有真正關係。文件 ID 非常類似的文件不可能放置在相同的 Shard 上。

未分割資料庫僅提供廣域查詢，之後將對此進行更詳細的說明。

## 分割資料庫
{: #partitioned-databases-database-partitioning}

分割資料庫是較新類型的 {{site.data.keyword.cloudant_short_notm}} 資料庫。在分割資料庫內，文件會透過使用_分割區索引鍵_ 而形成邏輯分割區，分割區索引鍵是分割資料庫內文件的部分文件 ID。所有文件都會指派給一個分割區，而且系統通常會提供多份文件相同的分割區索引鍵。分割區的主要 JSON 資料及其索引最終會並存，表示資料庫能夠更有效率地查詢分割區內的資料。

分割資料庫同時提供分割及廣域查詢。分割查詢會善用資料庫叢集內的資料佈置，來提供改善且更可擴充的查詢效能。此外，分割區查詢通常比廣域查詢便宜。

分割資料庫同時提供廣域及分割區查詢的優勢，因此 {{site.data.keyword.cloudant_short_notm}} 建議新的應用程式善用它們。

## 產生良好分割區索引鍵的要素是什麼？
{: #what-makes-a-good-partition-key-}

如果您考慮使用 {{site.data.keyword.cloudant_short_notm}} 的新*分割資料庫* 特性，則選擇分割區索引鍵非常重要。分割區索引鍵必須具有：

- 許多值 - 許多小型分割區比幾個大型分割區還要好。
- 沒有熱點 - 避免設計出一個系統，讓某個分割區處理大部分的工作負載。如果工作平均地分散在各個分割區，則資料庫的執行將更為順暢。
- 重複 - 如果每一個分割區索引鍵都是唯一的，每個分割區將有一份文件。若要充分利用分割資料庫，每個分割區須有多份文件（邏輯上在一起的文件）。

讓我們查看一些使用案例，以及一些良好的及不好的分割區索引鍵選擇。

| 使用案例                   | 說明| 分割區索引鍵 | 效果                                                                                                  |
|----------------------------|-----------------------------|---------------|------------------------------------------------------------------------------------------------------------------|
| 電子商務系統 - 訂單 | 每筆訂單一份文件     | order_id      | 中立 - 每個分割區一份文件很好，但它不會提供「分割區查詢」的好處。|
| 電子商務系統 - 訂單 | 每筆訂單一份文件     | user_id       | 良好的 - 將一起保留所有使用者的訂單。|
| 電子商務系統 - 訂單 | 每筆訂單一份文件     | status        | 不好的 - 依少數幾個狀態值（provisional、paid、refunded、cancelled）分組訂單將建立太少的超大分割區。|
| 部落格平台          | 每篇部落格文章一份文件 | author_id     | 良好的 - 只要有許多作者即可。易於查詢每一個作者的貼文。|
| IOT - 感應器讀數      | 每個讀數一份文件    | device_id     | 良好的 - 若有許多裝置的話。請確定某個裝置不會比其他裝置產生更多讀數。|
| IOT - 感應器讀數      | 每個讀數一份文件    | date          | 不好的 - 現行讀數將在現行日期的分割區上產生「熱點」。|

有一些使用案例，沒有可行的分割區索引鍵選擇。
在這些情況下，未分割資料庫可能是最好的選項，例如，使用者用來儲存電子郵件位址、密碼雜湊及前次登入日期的資料庫。這些欄位沒有一個可產生合適的分割區索引鍵，因此必須改用一般的未分割資料庫。

## 查詢
{: #querying}

本節說明哪些 {{site.data.keyword.cloudant_short_notm}} 查詢類型適用於廣域及分割區查詢，以及提供基礎查詢機制的簡短概觀，以讓您能選出哪個查詢機制最適合應用程式需要提出的每一個查詢。

### 廣域查詢
{: #global-querying}

您可以對下列索引類型提出廣域查詢：

- {{site.data.keyword.cloudant_short_notm}} 查詢
- 視圖
- 搜尋
- 地理位置

提出廣域查詢時，資料庫必須跨資料庫中的所有資料執行分散收集作業。這表示對許多個別資料庫伺服器提出要求。API 協調節點會接收來自這些伺服器全部的回應，並結合它們以構成對用戶端的單一回應。這可能涉及緩衝資料及延遲回應用戶端，比方說，如果資料需要排序。

### 分割區查詢
{: #partition-querying}

您可以對下列索引類型提出分割區查詢：

- {{site.data.keyword.cloudant_short_notm}} 查詢
- 視圖
- 搜尋

提出分割區查詢時，資料庫能夠只查詢單一分割區內的資料。當分割區的資料只位於一個 Shard（含三個抄本）時，API 協調節點能夠直接對管理該資料的伺服器提出要求，而不是需要結合來自許多伺服器的回應。這也可以免於緩衝回應，因為不必進行組合步驟。因此，資料會更快送達用戶端。

此外，因為資料庫的大小增加，所以 Shard 的數目需要增加。這會直接增加 API 協調節點在使用廣域查詢時，需要對管理資料的伺服器提出的查詢數目。不過，使用分割區查詢時，Shard 的數目不會影響 API 協調節點需要聯絡的伺服器數目。因為此數目仍然很小，所以增加資料大小並不會影響查詢延遲，與廣域查詢不同。

## 範例：分割 IoT 讀數資料
{: #example-partitioning-iot-reading-data}

此討論相當抽象；讓我們使用一個範例來將它具體化。我們將採用「物聯網」網域，並查看如何使用 {{site.data.keyword.cloudant_short_notm}}，作為裝置讀數的歷程資料庫。假設裝置正在對道路或橋樑等基礎設施提供感應器讀數。

我們將假設：

- 數百部或數千個裝置正在報告讀數。
- 每一個裝置都有唯一 ID。
- 每一個基礎設施都有唯一 ID。
- 裝置不會在基礎設施之間移動。
- 每一個裝置每隔 10 秒就會將讀數寫入至 {{site.data.keyword.cloudant_short_notm}}。這可能透過訊息匯流排遞送至 {{site.data.keyword.cloudant_short_notm}}。

在未分割資料庫中，您可能容許 {{site.data.keyword.cloudant_short_notm}} 產生文件 ID。另一個替代方案為依裝置 ID 及記錄時間戳記命名文件。

使用第二種方法，最終產生如下的文件 ID：

```
device-123456:20181211T11:13:24.123456Z
```

時間戳記也可以是 Epoch 時間戳記。

此方法將容許有效地使用分割索引來查詢每一個裝置的資料，但可能需要使用廣域索引，對多個裝置（指的是給定基礎設施上的所有裝置）建立視圖。

為了便於說明，讓我們使情境更複雜一些。我們假設應用程式主要讀取給定基礎設施的所有感應器資料，而不是個別裝置的感應器資料。

在此應用程式中，我們期望依基礎設施項目查詢最有效，因此依基礎設施分割資料會比依 ID 更有意義。這將容許給定基礎設施的所有裝置被當作一個群組，而能有效地進行查詢。

對於罕見依裝置的查詢，有兩種方法：

1. 依裝置建置廣域索引鍵，並查詢此索引鍵。如果對個別裝置的查詢罕見，而且不重複，則這樣做更有效。
2. 建置將裝置對映至基礎設施的廣域索引，然後對基礎設施分割區發出分割區查詢。如果因為對映可以快取，所以對給定裝置使用重複查詢，則這樣做就有意義；我們將假設應用程式就是這種情況。

讓我們看看這將如何發展。我們將查看四種查詢：

1. 基礎設施的所有時間讀數。
1. 基礎設施的今天讀數。
1. 特定裝置的所有時間讀數。
1. 特定裝置的今天讀數。

### 建立資料庫
{: #creating-the-database}

我們將使用稱為 `readings` 的資料庫，以及稱為 `acme` 的帳戶。若要建立此資料庫作為分割資料庫，請傳遞 `true` 作為資料庫建立要求的 `partitioned` 引數：

```
curl -XPUT 'https://acme.cloudant.com/readings?partitioned=true'
```

### 文件結構
{: #document-struture}

首先，讓我們定義簡單的文件格式來使用：

```json
{
    "deviceID": "device-123456",
    "infrastructureID": "bridge-9876",
    "ts": "20181211T11:13:24.123456Z",
    "reading": {
        "temperature": {"value": 12, "unit": "c"}
    }
}
```

對於此文件，根據基礎設施使用分割方法時，文件 ID 可能包含基礎設施 ID 作為分割區索引鍵，也可能同時包含裝置及時間戳記作為文件索引鍵：

```
bridge-9876:device-123456-20181211T11:13:24.123456Z
```

### 建立索引
{: #creating-indexes}

對於先前說明的查詢，我們將需要兩個索引：

1. 將裝置 ID 對映至基礎設施 ID 的廣域索引。
2. 將裝置 ID 對映至讀數的分割索引。

#### 建立廣域視圖索引
{: #creating-a-global-view-index}

視圖索引是執行簡單裝置 ID 與基礎設施 ID 對映的最有效方式。由於此索引是廣域索引，若要定義它，請將 `options.partitioned` 設為 `false` 來上傳設計文件。在真正的 `map` 函數中，如果想要讓存在的欄位更受保護，應如下所示：

```json
{
    "_id": "_design/infrastructure-mapping",
    "options": {"partitioned": false},
    "views": {
        "by-device": {
            "map": "function(doc) { emit(doc.deviceID, doc.infrastructureID) }"
        }
    }
}
```

假設先前的文件是 `./view.json`，這將使用以下指令上傳到資料庫：

```
curl -XPOST https://acme.cloudant.com/readings -d @view.json
```

#### 建立分割的 {{site.data.keyword.cloudant_short_notm}} 查詢索引
{: #creating-a-paritioned-ibm-cloudant-query-index}

若要從分割區傳回給定裝置的讀數，可以使用「{{site.data.keyword.cloudant_short_notm}} 查詢」索引。對此，會使用索引定義 `POST` 至 `_index`，而此定義中包括設為 `true` 的 `partitioned` 欄位。 

對於「查詢」索引定義，`partitioned` 欄位不會在 `options` 物件內形成巢狀。
{: note}

對於我們的查詢，需要兩個分割索引：

1. 依時間戳記
2. 依裝置 ID 及時間戳記

依時間戳記的定義如下：

```json
{
   "index": {
      "fields": [
        "ts"
      ]
   },
   "name": "timestamped-readings",
   "type": "json",
   "partitioned:" true
}
```

假設先前的文件是 `./query-index1.json`，請使用以下指令將索引上傳到資料庫：

```
curl -XPOST https://acme.cloudant.com/readings/_index -d @query-index1.json
```

依裝置 ID 及時間戳記的定義如下：

```json
{
   "index": {
      "fields": [
        "deviceID",
         "ts"
      ]
   },
   "name": "deviceID-readings",
   "type": "json",
   "partitioned:" true
}
```

假設先前的文件是 `./query-index2.json`，請使用以下指令將索引上傳到資料庫：

```
curl -XPOST https://acme.cloudant.com/readings/_index -d @query-index2.json
```

### 提出查詢
{: #making-queries}

整體而言，我們想要提出四個查詢：

1. 基礎設施的所有時間讀數。
1. 基礎設施的今天讀數。
1. 特定裝置的所有時間讀數。
1. 特定裝置的今天讀數。

#### 尋找基礎設施的所有讀數
{: #finding-all-readings-for-a-piece-of-infrastructure}

因為我們的分割區是以基礎設施為基礎，所以我們可以針對分割區使用 `_all_docs`。例如，查詢 `bridge-1234` 基礎設施的所有讀數：

```
curl -XGET \
    'https://acme.cloudant.com/readings/_partition/bridge-1234/_all_docs?include_docs=true'
```

#### 尋找基礎設施的最近讀數
{: #finding-recent-readings-for-a piece-of-infrastructure}

此查詢需要使用分割的 `timestamped-readings` 索引。我們可以對分割區發出查詢來取得今天的讀數：

_query.json，假設今天是 2018 年 12 月 13 日：_

```json
{
    "selector": {
      "ts": { "$gte": "20181213"}
    }
}
```

對 {{site.data.keyword.cloudant_short_notm}} 發出要求時，分割區內嵌在 HTTP 路徑中：

```
curl -XPOST \
    'https://acme.cloudant.com/readings/_partition/bridge-1234/_find' \
    -d @query.json
```

#### 尋找裝置的基礎設施 ID
{: #finding-the-infrastructure-id-for-a-device}

尚未執行的兩個查詢為：

1. 特定裝置的所有時間讀數。
2. 特定裝置的今天讀數。

對於這兩個查詢，需要使用廣域 `by-device` 索引，找出裝置的分割區。然後，我們就可以查詢個別分割區來取得讀數。儘管可能已使用廣域索引來查詢個別裝置的讀數，但從裝置到基礎設施 ID 的對映是高度可快取的 -- 永不變更！-- 因此，此方法容許我們主要針對大部分要求使用更便宜且更有效的分割查詢。

如果對於給定的應用程式，快取裝置與基礎設施的對映無法妥善地運作，則使用廣域索引來直接查詢裝置讀數可能更有效。

若要尋找裝置的相關分割區，請查詢 `by-device` 視圖，這會傳送裝置 ID 作為索引鍵：

```
curl -XGET \
  'https://acme.cloudant.com/readings/_design/infrastructure-mapping/_view/by-device?keys=["device-123456"]&limit=1'
```

這會傳回：

```json
{"total_rows":5,"offset":0,"rows":[
{
    "id":"bridge-9876:device-123456-20181211T11:13:24.123456Z",
    "key":"device-123456",
    "value":"bridge-9876"
}
]}
```

在併入列的 `value` 欄位中，我們有分割區索引鍵：`bridge-9876`。

#### 查詢裝置的所有結果
{: #querying-for-all-results-for-a-device}

若要取得裝置的結果，請對 `bridge-9876` 分割區內的裝置發出分割區查詢。這時會使用標準 {{site.data.keyword.cloudant_short_notm}} 查詢選取器，彷彿正在發出廣域查詢一般。

_query.json：_

```json
{
   "selector": {
      "deviceID": {
         "$eq": "device-123456"
      }
   }
}
```

對 {{site.data.keyword.cloudant_short_notm}} 發出要求時，分割區內嵌在 HTTP 路徑中：

```
curl -XPOST \
    'https://acme.cloudant.com/readings/_partition/bridge-1234/_find' \
    -d @query.json
```

#### 查詢裝置的最近結果
{: #querying-for-recent-results-for-a-device}

若要取得裝置的結果，請對 `bridge-9876` 分割區內的裝置發出分割區查詢。選取器只是略為複雜一些，但仍與對等的廣域查詢相同。

_query.json，假設今天是 2018 年 12 月 13 日：_

```json
{
   "selector": {
      "deviceID": {
         "$eq": "device-123456"
      },
      "ts": {
         "$gte": "20181213"
      }
   }
}
```

對 {{site.data.keyword.cloudant_short_notm}} 發出要求時，分割區內嵌在 HTTP 路徑中：

```
curl -XPOST \
    'https://acme.cloudant.com/readings/_partition/bridge-1234/_find' \
    -d @query.json
```
