---

copyright:
  years: 2015, 2019
lastupdated: "2019-06-12"

keywords: couchapp, 3-tier application

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

# CouchApps
{: #couchapps}

{{site.data.keyword.cloudantfull}} 可以管理原始檔案資料（如影像），並透過 HTTP 提供，這表示它可以管理執行網站所需的所有靜態檔案，並像 Web 伺服器一般管理它們。
{: shortdesc}

因為將在 {{site.data.keyword.cloudant_short_notm}} 上管理這些檔案，所以用戶端 JavaScript 可以存取 {{site.data.keyword.cloudant_short_notm}} 資料庫。
以此方式建置的應用程式可說是具有雙層架構，由用戶端（通常是指瀏覽器）與資料庫組成。在 CouchDB 社群中，這稱為 CouchApp。

大部分 Web 應用程式都有三層：用戶端、伺服器及資料庫。將伺服器放在用戶端與資料庫之間，可以協助進行鑑別、授權、資產管理、運用協力廠商 Web API、提供特別精密的端點等等。此分隔容許新增複雜性，而不會合併顧慮，所以您的用戶端可以從頭至尾都擔心資料表示法，而您的資料庫則專注在儲存及提供資料。

CouchApps 因其簡易性而出眾，但 Web 應用程式經常需要 3 層架構的能力。各自的適當時機？

## 若為下列情況，則 CouchApp 適用...
{: #a-couchapp-is-appropriate-if-}

-   您的伺服器無論如何只提供 API 給 {{site.data.keyword.cloudant_short_notm}}。
-   您可以正常使用 {{site.data.keyword.cloudant_short_notm}} 的 [Cookie 型鑑別](/docs/services/Cloudant?topic=cloudant-authentication#cookie-authentication)。
-   您可以正常使用 {{site.data.keyword.cloudant_short_notm}} 的 [`_users` 及 `_security`](/docs/services/Cloudant?topic=cloudant-authorization#using-the-_users-database-with-cloudant-nosql-db) 資料庫，來管理使用者及許可權。
-   您不需要排定 cronjob 或其他一般作業。

若要開始使用 CouchApps，請閱讀 [Managing applications on {{site.data.keyword.cloudant_short_notm}} ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://cloudant.com/blog/app-management/){: new_window}。

## 若為下列情況，則 3 層適用...
{: #a-3-tier-application-is-appropriate-if-}

-   您需要的許可權比 `_security` 資料庫容許的許可權更為精細。
-   您需要「基本」鑑別或 Cookie 鑑別以外的鑑別方法，例如 Oauth 或協力廠商登入系統。
-   您需要排定要在用戶端外定期執行的作業。

您可以使用最適合您的任何技術來撰寫伺服器層。在 [{{site.data.keyword.cloudant_short_notm}} 基本觀念](/docs/services/Cloudant?topic=cloudant-client-libraries#client-libraries)頁面上，提供可搭配 {{site.data.keyword.cloudant_short_notm}} 使用的程式庫清單。
