---

copyright:
  years: 2015, 2019
lastupdated: "2019-06-12"

keywords: curl and jq basics, monitor view builds and search indexes, estimate time to complete task, monitor replication, troubleshooting

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

# 管理作業
{: #managing-tasks}

建立大量資料的新索引或抄寫大型資料庫可能需要一些時間。
{: shortdesc}

因此，如何判定作業是否正在進行中，或它們是否已完成？[`_active_tasks` 端點](/docs/services/Cloudant?topic=cloudant-active-tasks#active-tasks)提供所有進行中作業的相關資訊。不過，如果您啟動大量作業，則其中有部分可能會排定在稍後執行，而且除非已啟動它們，否則不會顯示在 `_active_tasks` 下。

此手冊會告訴您如何使用 `_active_tasks` 端點來監視長時間執行的作業。`curl` 指令用來存取端點。`jq` 指令行 JSON 處理器用來處理 JSON 回應。

因為這是著重在作業的指導教學，所以只會涵蓋完成此作業的基本項目。如需相關資訊，請參閱 [API 參考資料](/docs/services/Cloudant?topic=cloudant-api-reference-overview#api-reference-overview)，以取得可用選項的完整手冊。

## `curl` 和 `jq` 基本觀念
{: #curl-and-jq-basics}

若要取得所有作用中作業，並且良好地格式化輸出，請使用 `curl` 來呼叫帳戶，並將輸出以管線傳送至 `jq`。

`jq` 可讓您依欄位值來過濾文件清單。這可以更輕鬆地取得所有抄寫文件，或只是一個特定視圖檢索作業的詳細資料。API 參考資料具有選項的相關資訊。

*取得及格式化作用中作業清單的範例：*

```sh
curl 'https://username:password@username.cloudant.com/_active_tasks' | jq '.'
```
{: codeblock}

## 監視視圖建置及搜尋索引
{: #monitoring-view-builds-and-search-indexes}

更新設計文件時，會重建視圖索引。任何一個視圖的更新都導致重建文件中的所有視圖。

只有在搜尋索引的對應索引函數變更時，才會重建搜尋索引。對於每一個正在建置的搜尋索引，以及對於每一個已變更視圖的設計文件，會為叢集中每個 Shard 的每一個抄本建立新作業。

例如，如果有 24 個 Shard（各有三個抄本），而且您更新兩個搜尋索引，則會執行 24 x 3 x 2 = 144 個作業。

若要尋找所有視圖檢索作業，請將 `curl` 輸出以管線傳送至 `jq`，並讓它依類型欄位來過濾陣列中的文件。對應的指令適用於搜尋檢索作業。

在每一種情況下，搜尋檢索作業清單的結果都是 JSON 物件清單：每一個找到的作用中作業都有一份清單。

*針對 `indexer` 類型進行過濾來尋找所有視圖檢索作業的範例：*

```sh
curl -s 'https://username:password@username.cloudant.com/_active_tasks' | jq '.[] | select(.type=="indexer")'
```
{: codeblock}

*針對 `search_indexer` 類型進行過濾來尋找所有搜尋檢索作業的範例：*

```sh
curl -s 'https://username:password@username.cloudant.com/_active_tasks' | jq '.[] | select(.type=="search_indexer")'
```
{: codeblock}

*搜尋視圖檢索作業之後的範例結果：*

```json
{
    "total_changes": 6435,
    "started_on": 1371118332,
    "user": "username",
    "updated_on": 1371118334,
    "type": "indexer",
    "node": "dbcore@db6.meritage.cloudant.net",
    "pid": "<0.16366.6103>",
    "changes_done": 364,
    "database": "shards/40000000-7fffffff/username/database",
    "design_document": "_design/ngrams"
}
```
{: codeblock}

## 預估作業完成時間
{: #estimating-the-time-to-complete-a-task}

若要預估檢索作業完成之前所需的時間，請監視 `changes_done` 數目，並比較此值與 `total_changes`。例如，如果 `changes_done` 每秒增加 250，而且 `total_changes` 是 1,000,000，則預期作業需要 1,000,000/250=4,000 秒或大約 66 分鐘才能完成。

檢索作業完成時間預估值無法 100% 精確。實際作業完成時間取決於下列因素：

-   處理每一份文件所需的時間。例如，視圖可能會先檢查文件類型，並且只會發出一種類型的新索引項目。
-   文件的大小。
-   叢集上的現行工作負載。

您應該假設這些因素可能會結合，而導致預估值相當不精確。

*使用 `jq` 擷取 `changes_done` 欄位的範例：*

```sh
curl ... | jq '.[] | select(.type=="search_indexer") | .changes_done'
```
{: codeblock}

## 監視抄寫
{: #monitoring-replication}

若要尋找所有抄寫作業，請將 `curl` 輸出以管線傳送至 `jq`，並依其類型欄位來過濾陣列中的文件。

若要更輕鬆地從作用中作業清單中選取抄寫處理程序的相關資訊，請在 `_replicator` 資料庫中建立文件來開始抄寫處理程序，並將其 `_id` 欄位設為已知值。

*針對 `replication` 類型進行過濾來尋找所有抄寫作業的範例：*

```sh
curl -s 'https://username:password@username.cloudant.com/_active_tasks' | jq '.[] | select(.type=="replication")'
```
{: codeblock}

*針對已知文件身分進行過濾來尋找特定抄寫作業的範例：*

```sh
curl ... | jq '.[] | select(.doc_id=="ID")'
```
{: codeblock}

*針對已知 `replication_id` 進行過濾來尋找特定抄寫作業的範例：*

```sh
curl ... | jq '.[] | select(.replication_id=="ID")'
```
{: codeblock}

*搜尋抄寫作業之後的範例結果：*

```json
{
    "started_on": 1371094220,
    "source_seq": "62960-sakdjflksdfjsdlkafjalskdfjlsakfjlasdkjksald",
    "source": "",
    "revisions_checked": 12,
    "continuous": true,
    "doc_id": null,
    "doc_write_failures": 0,
    "docs_read": 12,
    "target": "",
    "type": "replication",
    "updated_on": 1371118477,
    "user": "username",
    "checkpointed_source_seq": "61764-dskfjalsfjsalkfjssadjfhasdfkjhsdkfhsdkf",
    "changes_pending": 1196,
    "pid": "<0.9955.4120>",
    "node": "dbcore@db7.meritage.cloudant.net",
    "docs_written": 12,
    "missing_revisions_found": 12,
    "replication_id": "asfksdlfkjsadkfjsdalkfjas+continuous+create_target"
}
```
{: codeblock}

## 對停滯的作業進行疑難排解
{: #troubleshooting-stuck-tasks}

### 作業是否停滯？
{: #is-a-task-stuck-}

針對抄寫期間未大幅更新來源資料庫的一次性非持續抄寫，`changes_pending` 值會告訴您仍然需要處理多少文件。這表示 `changes_pending` 值可以有效指出抄寫可能已完成。

對於持續抄寫，您比較感興趣所處理文件數目如何隨著時間變更，以及 `changes_pending` 值是否會增加。如果 `changes_pending` 增加，但 `revisions_checked` 維持不變一段時間，則抄寫可能會停滯。如果 `changes_pending` 增加，而且 `revisions_checked` 也增加，這可能指出抄寫無法跟上在資料庫中新增或更新的資料量。

### 如何處理停滯的作業？
{: #what-to-do-about-a-stuck-task-}

若要解決已停滯的抄寫，您可能需要[取消抄寫處理程序](/docs/services/Cloudant?topic=cloudant-replication-api#canceling-a-replication)，並重新予以啟動。

如果這麼做沒有幫助，則抄寫可能會停滯，因為存取來源或目標資料庫的使用者沒有寫入權。

抄寫會利用[檢查點](/docs/services/Cloudant?topic=cloudant-replication-guide#checkpoints)，這表示如果重新開始抄寫，則不需要重新抄寫已抄寫且未變更的內容。
{: note}

如果您已在 `_replicator` 資料庫中建立文件來建立抄寫處理程序，則也可以在該處檢查抄寫狀態。
