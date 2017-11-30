---

copyright:
  years: 2017
lastupdated: "2017-07-13"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-04-28 -->

# 安全

## Cloudant DBaaS 資料保護及安全

保護大規模 Web 及行動應用程式的應用程式資料可能十分複雜，特別是分散式及 NoSQL 資料庫。

就像 {{site.data.keyword.cloudantfull}} 會減少維護資料庫的工作，為了讓資料庫持續不間斷地執行及成長，它也會確保您的資料保持安全且受保護。

## 最上層實體平台

{{site.data.keyword.cloudant_short_notm}} DBaaS 實際在第 1 層雲端基礎架構提供者（例如 {{site.data.keyword.BluSoftlayer_full}} 及 Amazon）上進行管理。因此，您的資料是受到這些提供者所使用的網路及實體安全措施所保護，包括（但不限於）：

- 憑證：與 SSAE16、SOC2 類型 1、ISAE 3402、ISO 27001、CSA 及其他標準的相符性。
- 存取及身分管理。
- 資料中心及網路作業中心監視的一般實體安全。
- 伺服器強化。
- {{site.data.keyword.cloudant_short_notm}} 可讓您在 SLA 及成本需求變更時，彈性選擇或切換不同的提供者。

> **附註：**[相符性資訊](compliance.html)中提供憑證的更多詳細資料。

## 安全存取控制

許多安全特性都內建到 {{site.data.keyword.cloudant_short_notm}}，可讓您控制資料存取權：

- 鑑別：{{site.data.keyword.cloudant_short_notm}} 是使用 HTTP API 進行存取。如果 API 端點需要它，則會針對 {{site.data.keyword.cloudant_short_notm}} 接收到的每個 HTTPS 或 HTTP 要求鑑別使用者。
- 授權：授與特定資料庫的讀取、寫入及管理許可權。
- 「進行中」加密：使用 HTTPS 加密 {{site.data.keyword.cloudant_short_notm}} 的所有存取。
- 靜態加密：可加密 {{site.data.keyword.cloudant_short_notm}} 中儲存在磁碟上的資料。
  > **附註**：一律會加密 {{site.data.keyword.Bluemix_notm}} {{site.data.keyword.cloudant_short_notm}} 實例中所儲存的資料。
- API 存取：{{site.data.keyword.cloudant_short_notm}} 是使用 API 透過安全 HTTP (HTTPS)，以程式設計方式進行存取。使用 {{site.data.keyword.cloudant_short_notm}} 儀表板，可以產生 API 金鑰。
- IP 白名單：專用環境上的 {{site.data.keyword.cloudant_short_notm}} 客戶可以將 IP 位址設為白名單，限制只能存取指定的伺服器及使用者。
- CORS：使用 {{site.data.keyword.cloudant_short_notm}} 儀表板，以啟用特定網域的 CORS 支援。

## 防止資料流失或毀損

{{site.data.keyword.cloudant_short_notm}} 具有數個特性，可協助您維護資料品質及可用性：

- 備援及可延續資料儲存空間：依預設，{{site.data.keyword.cloudant_short_notm}} 會將磁碟上每份文件的三個副本儲存至叢集中的三個不同節點。不論失敗與否，儲存副本都可確保資料的有效失效接手副本一律可用。
- 資料抄寫及匯出：您可以在不同資料中心的叢集之間持續抄寫資料庫，或者抄寫至內部部署 Cloudant Local 叢集或 Apache CouchDB。另一個選項是將資料從 {{site.data.keyword.cloudant_short_notm}}（JSON 格式）匯出至其他位置或來源（例如您自己的資料中心），以新增資料備援。
