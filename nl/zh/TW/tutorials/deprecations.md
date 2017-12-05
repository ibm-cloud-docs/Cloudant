---

copyright:
  years: 2017
lastupdated: "2017-07-12"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-07-12 -->

# 重大及行為變更

本文件彙總 Cloudant 版本的行為變更。
{:shortdesc}

## CouchDB 1.6 版與 Cloudant 2.0.0 版之間的不相容

-   最新版的 Cloudant 與 CouchDB 1.6 型程式碼庫之間存在不相容。在  
    舊版 Cloudant 中，如果您將查詢參數 ("reduce=false") 新增至要求內文，則會在要求 URL 中使用參數時忽略要求內文中的參數。在新版 Cloudant 中，不會忽略要求內文中的查詢參數 ("reduce=false")。

## 已修訂的錯誤訊息

- 在您嘗試放置具有不存在修訂的文件附件時所發生的錯誤訊息，已變更成包含下列資訊的 409 錯誤：

	```
	{"error":"not_found","reason":"missing_rev"}
	```

## X-Frame-Options

`X-Frame-Options` 設定是一個回應標頭，控制是否可以在 `<frame>`、`<iframe>` 或 `<object>` 中內嵌 HTTP 回應。此安全特性有助於避免點閱綁架。

您可以根據 CORS 設定來配置此選項。依預設，如果啟用 CORS，`X-Frame-Options` 會自動予以啟用，並傳送回應標頭 `X-Frame-Options: DENY`。如果要求 HOST 標頭符合 CORS 的 origins 區段中所列的 URL，則會傳回 `X-Frame-Options: ALLOW-FROM URL` 回應標頭。
 
這項變更可能會影響直接從瀏覽器存取資料庫的客戶。如果您看到 "X-Frame-Options: DENY" 錯誤訊息，而且它中斷您的服務，則必須啟用 CORS（[設定 CORS 配置](../api/cors.html#setting-the-cors-configuration)）。在您啟用 CORS 之後，請將要求中所傳送 HOST 標頭的值新增至允許的 `origins` 清單。

## 作用中作業

-   `_active_tasks` 回應中的檢索程式項目不再支援 `user` 欄位。
-   `_active_tasks` 回應中的搜尋檢索程式項目不再支援 `user` 欄位。

## 視圖

-   在精簡與非精簡視圖結果之間，索引鍵值的 Unicode 正規化會一致。如果在設計文件中指定原始對照，則結果順序在套用此修正程式之後可能會變更。
-   當您查詢視圖或 `_all_docs` 資料庫時，指定 `keys` 參數以及任何 `key`、`startkey` 及 `endkey` 參數是錯誤的。
-   如果任何列都不可能相符，則將 `startkey` 及 `endkey` 參數傳遞給視圖是錯誤的。例如，`descending=false` 的 `startkey` 參數高於 `endkey` 參數時，或 `descending=true` 的 `startkey` 參數低於 `endkey` 參數時，Cloudant 會傳回 `400 不當要求`錯誤。
-   在視圖文件中配置 `dbcopy` 時，會自動將它轉換成設計文件中的 `options` 欄位。 

## 設計文件

-   更嚴格地驗證設計文件。這項驗證預期不會導致發生現有設計文件的問題，但無法儲存形態異常的設計文件。
-   以不受支援語言撰寫的視圖都會回應 `unknown_query_language` 的 `error`。先前，回應是 `unknown_query_language` 的 `reason`。
-   使用空值減少器放置資料庫設計文件時，系統會回應 `'(null)'` 的錯誤原因，先前它會傳回 `((new String("null")))`。
-   如果在設計文件中指定 `updates`，則不得有空值。

## 鑑別

-   `_session` meta 資料 `authentication_handlers` 不再包含 `["delegated", "local"]`。

## 使用者文件

-   驗證 `_users` 資料庫中所建立使用者文件的結構。DBNext 升級之後，使用者文件必須符合 ASF CouchdDB 需求。先前，Cloudant 未驗證使用者文件的結構。 

## 抄寫 

-   抄寫器文件會保留 `_replication_state_reason` JSON 欄位中的最後一則錯誤訊息。此欄位即使在抄寫重新啟動之後仍然會予以保留，並且處於`已觸發`狀態。這項變更可協助抄寫器程式碼偵測及避免將相同的錯誤反覆地寫入至文件。
-   除非錯誤原因變更，否則抄寫期間的錯誤不會更新抄寫文件。先前，在抄寫期間發生錯誤時，會啟動產生可調整大小 Shard 的無限迴圈。  

## 結果集

-   `_db_updates` 端點會傳回包含名為 `db_name` 的索引鍵的結果集。先前，它會傳回具有名為 `dbname` 的索引鍵的結果集。
-   設定文件 ID 的長度上限。先前，無法定義文件 ID 長度上限。

## `dbcopy`

- 在某些情況下，`dbcopy` 特性可能會導致問題。此特性的相關資訊已從文件中予以移除。強烈建議不要使用 `dbcopy`。
