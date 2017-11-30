---

copyright:
  years: 2017
lastupdated: "2017-07-07"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-05-04 -->

# Cloudant 新增功能

隨時掌握 Cloudant 的變更及更新。
{:shortdesc}

## 專用硬體

提供新的[專用服務實例](bluemix.html#dedicated-plan)。

## 建置 6233

- 引進新的「抄寫排程器」。除了效能好處及額外的端點之外，排程器也會變更監視及報告抄寫狀態的方式。具體而言，不再支援記錄抄寫文件中的狀態更新。如需這項重要變更的相關資訊，請參閱[抄寫排程器](../api/advanced_replication.html#the_replication_scheduler)的詳細資料。如果您有任何疑問或問題，請使用「Cloudant 儀表板」開啟問題單來聯絡「Cloudant 支援中心」。

## 建置 6069

- 先前，因故損毀的抄寫工作會導致更新抄寫文件，接著全新嘗試啟動新的抄寫。在某些情況下，可能會無限期地繼續此行為：有相同錯誤訊息的許多複製項目。已引進修正程式，因此除非變更了錯誤原因，否則不會更新抄寫文件。
- 如果要指定地理空間索引的設計文件無效，則嘗試使用 [`_geo_info` 端點](../api/cloudant-geo.html#obtaining-information-about-a-cloudant-geo-index)來擷取索引的相關資訊，會導致 [HTTP `404`](http.html#404) 回應。
- 已新增 [`$allmatch`](../api/cloudant_query.html#the-allmatch-operator) 運算子的支援。

## 建置 5834

- 文件 `id` 的長度上限現在是 7168 個字元 (7K)。

## 建置 5728

- Cloudant 更為容忍 `_users` 資料庫內所儲存之形態異常的使用者文件。應該建構使用者文件並將資料移入其中，以符合 [Apache Software Foundation CouchDB 需求 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](http://docs.couchdb.org/en/2.0.0/intro/security.html#users-documents){:new_window}。

## 建置 5638

-   為視圖引進新的 "stable" 及 "update" 查詢參數。
-   如果抄寫器無法將檢查點寫入至來源資料庫，則永遠不會再進行重試。

## 建置 5421

-	changes 資訊來源支援視圖型過濾器。
-	changes 資訊來源支援 `_doc_ids` 過濾器。
-	`_changes` 支援 `POST` 要求。
-	`_all_docs` 及 `_changes` 都支援 `attachments=true` 參數。
-	CouchDB 1.6 `_users` 資料庫特性的支援（包括在 `_users` 資料庫中建立文件時的密碼伺服器端雜湊）。
-	用來減少在抄寫至行動用戶端時所使用之要求數目的 `/_bulk_get` 端點。
-	設計文件 meta 資料包含`更新擱置中`欄位。
-	如果沒有有效的索引，則「Cloudant 查詢」不再傳回錯誤。

### 重大/行為變更

作用中作業

-   `_active_tasks` 回應中的檢索程式項目不再支援 `user` 欄位。
-   `_active_tasks` 回應中的搜尋檢索程式項目不再支援 `user` 欄位。

視圖

-   在精簡與非精簡視圖結果之間，索引鍵值的 Unicode 正規化會一致。如果在設計文件中指定原始對照，則結果順序在套用此修正程式之後可能會變更。
-   當您查詢視圖或 `_all_docs` 資料庫時，指定 `keys` 參數以及任何 `key`、`startkey` 及 `endkey` 參數是錯誤的。
-   如果任何列都不可能相符，則將 `startkey` 及 `endkey` 參數傳遞給視圖是錯誤的。例如，`descending=false` 的 `startkey` 參數高於 `endkey` 參數時，或 `descending=true` 的 `startkey` 參數低於 `endkey` 參數時，Cloudant 會傳回 `400 不當要求`錯誤。
-   在視圖文件中配置 `dbcopy` 時，會自動將它轉換成設計文件中的 `options` 欄位。 

設計文件

-   更嚴格地驗證設計文件。這項驗證預期不會導致發生現有設計文件的問題，但無法儲存形態異常的設計文件。
-   以不受支援語言撰寫的視圖都會回應 `unknown_query_language` 的 `error`。先前，回應是 `unknown_query_language` 的 `reason`。
-   使用空值減少器放置資料庫設計文件時，系統會回應 `'(null)'` 的錯誤原因，先前它會傳回 `((new String("null")))`。
-   如果在設計文件中指定 `updates`，則不得有空值。

鑑別

-   `_session` meta 資料 `authentication_handlers` 不再包含 `["delegated", "local"]`。

使用者文件

-   驗證 `_users` 資料庫中所建立使用者文件的結構。DBNext 升級之後，使用者文件必須符合 ASF CouchdDB 需求。先前，Cloudant 未驗證使用者文件的結構。 

抄寫 

-   抄寫器文件會保留 `_replication_state_reason` JSON 欄位中的最後一則錯誤訊息。此欄位即使在抄寫重新啟動之後仍然會予以保留，並且處於`已觸發`狀態。這項變更可協助抄寫器程式碼偵測及避免將相同的錯誤反覆地寫入至文件。
-   除非錯誤原因變更，否則抄寫期間的錯誤不會更新抄寫文件。先前，在抄寫期間發生錯誤時，會啟動產生可調整大小 Shard 的無限迴圈。  

結果集

-   `_db_updates` 端點會傳回包含名為 `db_name` 的索引鍵的結果集。先前，它會傳回具有名為 `dbname` 的索引鍵的結果集。
-   設定文件 ID 的長度上限。先前，無法定義文件 ID 長度上限。

`dbcopy`

- 在某些情況下，`dbcopy` 特性可能會導致問題。此特性的相關資訊已從文件中予以移除。強烈建議不要使用 `dbcopy`。
