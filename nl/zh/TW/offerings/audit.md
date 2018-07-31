---

copyright:
  years: 2015, 2018
lastupdated: "2018-04-12"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2018-00-00 -->

# 審核記載


審核記載會記錄已存取 {{site.data.keyword.cloudant_short_notm}} 中所儲存資料的 {{site.data.keyword.cloudantfull}} 主體。對於 {{site.data.keyword.cloudant_short_notm}} 的所有 HTTP API 存取，審核記載功能會記錄每一個 HTTP 要求的下列資訊：

資訊        | 說明
------------|------------
`主體` | 帳戶認證、API 金鑰或 IBM Cloud IAM 認證。
`動作` | 執行的動作（例如，文件讀取）。
`資源` | 帳戶、資料庫以及所存取文件或所進行查詢的詳細資料。
`時間戳記` | 記錄事件的時間及資料。

{{site.data.keyword.cloudant_short_notm}} 審核日誌可以用來瞭解：

- 在帳戶內存取資料庫及文件的內容、時間及存取者。
- 執行查詢的內容、時間及執行者。
- 特定主體或使用者已存取、更新或刪除的內容及時間。
- 建立或刪除抄寫文件的內容及時間。
{:shortdesc}

## 如何存取帳戶的審核日誌

若要要求存取帳戶的審核日誌，請與 {{site.data.keyword.cloudant_short_notm}} 支援中心聯絡。支援中心將提供您感興趣之審核日誌的存取權。

與支援中心聯絡時，請務必包括：

- 要求與之相關的 {{site.data.keyword.cloudant_short_notm}} 帳戶。
- 審核日誌的時間範圍（每個支援要求不得超過一個月）。
- 感興趣的任何特定資料庫、文件或主體。
