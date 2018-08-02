---

copyright:
  years: 2015, 2018
lastupdated: "2018-06-07"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

# 在 {{site.data.keyword.cloudant_short_notm}} 中將相關文件分組在一起

傳統上，電子商務系統是使用關聯式資料庫所建置。這些資料庫一般會使用結合在一起的數張表格來記錄銷售量、客戶詳細資料、所購買的產品以及交付追蹤資訊。關聯式資料庫提供高度一致性，表示應用程式開發人員可以將其應用程式建置為資料庫的強項，包括在集合之間使用結合、記錄物件狀態的列舉，以及保證原子作業的資料庫交易。

{{site.data.keyword.cloudantfull}} 會優先考慮可用性，而非一致性。
它是最後會一致的高可用性、容錯、分散式資料庫。這提供的優點是客戶購物服務一律可用，並且可擴充到足以處理多位同時購買的使用者。這表示您的應用程式可以利用 {{site.data.keyword.cloudant_short_notm}} 的強項，而不會將它視為關聯式資料庫。

本主題中的討論使用許多其他網域適用的概念，概述建置善加利用 {{site.data.keyword.cloudant_short_notm}} 強項的電子商務系統所涉及的一些因素，例如：

-   使用多份文件來代表購買狀態，而不是經常更新單一文件。
-   依序儲存相關物件的副本，而不是結合為另一個集合。
-   建立視圖，依 `order_id` 來對照文件，以反映購買的現行狀態。

例如，您可以建立包含詳細資料（例如訂購的項目、客戶資訊、成本及交付資訊）的 `purchase` 文件。

_說明購買的範例文件：_

```json
{
    "_id": "023f7a21dbe8a4177a2816e4ad1ea27e",
    "type": "purchase",
    "order_id": "320afa89017426b994162ab004ce3383",
    "basket": [
        {
            "product_id": "A56",
            "title": "Adele - 25",
            "category": "Audio CD",
            "price": 8.33,
            "tax": 0.2,
            "quantity": 2
        },
        {
            "product_id": "B32",
            "title": "The Lady In The Van - Alan Bennett",
            "category": "Paperback book",
            "price": 3.49,
            "tax": 0,
            "quantity": 2
        }
    ],
    "account_id": "985522332",
    "delivery": {
        "option": "Next Day",
        "price": 2.99,
        "address": {
            "street": "17 Front Street",
            "town": "Middlemarch",
            "postcode": "W1A 1AA"
        }
    },
    "pretax" : 20.15,
    "tax" : 3.32,
    "total": 26.46
}
```
{:codeblock}

此文件針對購買記錄提供足夠的資料，以在網頁或電子郵件上呈現訂單摘要，而不需要提取其他記錄。請注意訂單的重要詳細資料，特別是：

-   購物籃包含儲存在其他地方的產品資料庫的參照 ID (`product_id`)。
-   購物籃會在此記錄中複製一些產品資料，足以記錄在銷售點所購買項目的狀態。
-   文件未包含可標示訂單狀態的欄位。稍後會新增其他文件，以記錄付款及交付。
-   將文件插入資料庫時，資料庫會自動產生文件 `_id`。
-   每一筆購買記錄都會隨附唯一 ID (`order_id`)，以便在稍後參照訂單。 
 
客戶下單時（一般是他們進入網站上的「結帳」階段時），會建立與先前範例類似的採購單記錄。 

## 產生您自己的唯一 ID (UUID)

在關聯式資料庫中，通常會使用循序「自動增量」數目，但在資料分散到伺服器叢集的分散式資料庫中，會使用較長的 UUID 來確保文件使用其自己的唯一 ID 進行儲存。

若要建立用於應用程式中的唯一 ID（例如 `order_id`），請在 {{site.data.keyword.cloudant_short_notm}} API 上呼叫 [`GET _uuids` 端點](../api/advanced.html#-get-_uuids-)。
資料庫會為您產生 ID。新增 `count` 參數（例如，`/_uuids?count=10`），即可使用相同的端點來產生多個 ID。

## 記錄付款

客戶順利支付其項目時，會在資料庫中新增其他記錄來記錄訂單。

_付款記錄範例：_

```json
{
    "_id": "bf70c30ea5d8c3cd088fef98ad678e9e",
    "type": "payment",
    "account_id": "985522332",
    "order_id": "320afa89017426b994162ab004ce3383",
    "value": 6.46,
    "method": "credit card",
    "payment_reference": "AB9977G244FF2F667"
}
...
{
    "_id": "12c0ea6cd3d2c6e3b1d34442aea6a2d9",
    "type": "payment",
    "account_id": "985522332",
    "order_id": "320afa89017426b994162ab004ce3383",
    "value": 20.00,
    "method": "voucher",
    "payment_reference": "Q88775662377224"
}
```
{:codeblock}

在前一個範例中，客戶的支付方式是提供信用卡並兌換預付憑單。兩個付款的總計加起來就是訂單的金額。每一個付款都會當成不同的文件寫入至 {{site.data.keyword.cloudant_short_notm}}。

建立含有已知 `order_id` 一切資訊的視圖，即可查看訂單狀態。視圖會啟用包含下列資訊的分類帳： 

-   正數的購買總計。
-   負數的帳戶付款。

對映函數可以用來識別必要值。

_尋找購買總計及付款值的範例對映函數：_ 

```javascript
function (doc) {
    if (doc.type === 'purchase') {
        emit(doc.order_id, doc.total);
    } else {
        if (doc.type === 'payment') {
            emit(doc.order_id, -doc.value);
        }
    }
}
```
{:codeblock}

使用內建 [`_sum` 減少器](../api/creating_views.html#built-in-reduce-functions)可讓您產生輸出作為付款事件的分類帳。

_使用內建 `_sum` 減少器並使用 `?reduce=false` 查詢的範例：

```json
{
    "total_rows":3,"offset":0,"rows":[
        {
            "id":"320afa89017426b994162ab004ce3383",
            "key":"985522332",
            "value":26.46
        },
        {
            "id":"320afa89017426b994162ab004ce3383",
            "key":"985522332",
            "value":-20
        },
        {
            "id":"320afa89017426b994162ab004ce3383",
            "key":"985522332",
            "value":-6.46
        }
    ]
}
```
{:codeblock}

或者，您可以產生依 `order_id` 分組的總計。

_依 `order_id` 分組且 `?group_level=1` 的總計範例：_

```json
{
    "rows":[
        {
            "key":"320afa89017426b994162ab004ce3383",
            "value":0
        }
    ]
}
```
{:codeblock}

因為前一個範例中的視圖傳回 0 作為訂單值，所以結果指出已完整支付訂單。原因是正數的採購單總計扺消了負數的付款金額。在 {{site.data.keyword.cloudant_short_notm}} 中，將事件記錄為不同的文件（一個是用於訂單，一個是用於每個付款）是不錯的作法，因為它可避免在多個處理程序同時修改相同文件時產生衝突的可能性。

## 新增其他文件

因為已佈建及分派訂單，所以您可以將其他不同的文件新增至資料庫來記錄下列狀態變更：

-   分派通知。
-   交付收據。
-   退款記錄。

當資料到達時，{{site.data.keyword.cloudant_short_notm}} 會分別寫入至每一份文件。
因此，不需要修改核心購買文件。

## 將採購單儲存在 {{site.data.keyword.cloudant_short_notm}} 中的優點

使用 {{site.data.keyword.cloudant_short_notm}} 來儲存採購單資訊可容許訂購系統高度可用且可擴充，以讓您處理大量資料以及因應高並行存取率。
透過在僅寫入一次的不同文件中建立資料模型，即可確定文件絕不會衝突，例如在不同的處理程序並行存取相同文件的期間。

此外，文件可以包含其他集合中現有資料的副本，以代表（而非依賴）使用外部索引鍵來結合資料。例如，記錄購物籃在購買時的狀態。這容許單一呼叫將訂單狀態提取到依 `order_id` 分組相關文件的 {{site.data.keyword.cloudant_short_notm}} 視圖。
