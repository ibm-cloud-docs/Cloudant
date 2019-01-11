---

copyright:
  years: 2017, 2018
lastupdated: "2018-10-24"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:tip: .tip}

<!-- Acrolinx: 2017-05-10 -->

# 安全
{: #security}

## {{site.data.keyword.cloudant_short_notm}} DBaaS 資料保護及安全
{: #ibm-cloudant-dbaas-data-protection-and-security}

保護大規模 Web 及行動應用程式的應用程式資料可能十分複雜，特別是分散式及 NoSQL 資料庫。

{{site.data.keyword.cloudantfull}} 不僅能減少維護資料庫的工作，讓資料庫持續不間斷地執行及成長，它也確保您的資料始終安全且受保護。
{:shortdesc}

## 最上層實體平台
{: #top-tier-physical-platforms}

{{site.data.keyword.cloudant_short_notm}} DBaaS 實體在第 1 層雲端基礎架構提供者（例如 {{site.data.keyword.cloud}} 及 Amazon）進行管理。因此，您的資料是受到這些提供者所使用的網路及實體安全措施所保護，包括（但不限於）：

- 認證：遵循 SSAE16、SOC2 類型 1、ISAE 3402、ISO 27001、CSA 及其他標準。
- 存取及身分管理。
- 資料中心及網路作業中心監視的一般實體安全。
- 伺服器強化。
- {{site.data.keyword.cloudant_short_notm}} 可讓您在 SLA 及成本需求變更時，彈性選擇或切換不同的提供者。

[法規遵循資訊](compliance.html)中提供認證的更多詳細資料。
{:tip}

## 安全存取控制
{: #secure-access-control}

{{site.data.keyword.cloudant_short_notm}} 有許多內建安全特性，可讓您控制資料存取權：

特性 | 說明
--------|------------
鑑別| {{site.data.keyword.cloudant_short_notm}} 是使用 HTTPS API 進行存取。當 API 端點需要時，會針對 {{site.data.keyword.cloudant_short_notm}} 收到的每個 HTTPS 要求鑑別使用者。{{site.data.keyword.cloudant_short_notm}} 同時支援 Legacy 及 IAM 存取控制。如需相關資訊，請參閱 [IAM 手冊](../guides/iam.html){:new_window}或舊式[鑑別 API 文件](../api/authentication.html){:new_window}。
授權| {{site.data.keyword.cloudant_short_notm}} 同時支援 Legacy 及 IAM 存取控制。如需相關資訊，請參閱 [IAM 手冊](../guides/iam.html){:new_window}及舊式[授權 API 文件](../api/authorization.html){:new_window}。
「進行中」加密 | 使用 HTTPS 加密對 {{site.data.keyword.cloudant_short_notm}} 的所有存取。
靜態加密 | 靜態加密 {{site.data.keyword.cloudant_short_notm}} 實例中所儲存的所有資料。如果您需要「自帶金鑰 (BYOK)」來進行靜態加密，則會使用 {{site.data.keyword.cloud_notm}} Key Protect 予以啟用。針對所有地區中部署的新「{{site.data.keyword.cloudant_short_notm}} 專用硬體方案」實例，{{site.data.keyword.cloudant_short_notm}} 會支援此特性。首先，使用 {{site.data.keyword.cloud_notm}} 型錄來建立「專用硬體方案」的實例。然後，提交支援問題單。我們的支援團隊會協調取得新「專用硬體」實例的「靜態加密」加密金鑰，而這些加密金鑰由 Key Protect 實例所管理。
IP 白名單 |具有專用 {{site.data.keyword.cloudant_short_notm}} 環境的 {{site.data.keyword.cloudant_short_notm}} 客戶可以將 IP 位址設為白名單，讓存取權僅限於在指定的伺服器及使用者。IP 白名單不適用於多方承租戶環境上所部署的任何「{{site.data.keyword.cloud_notm}} Public 精簡/標準方案」。針對指定的一組 IP 或 IP 範圍，開立要求 IP 白名單的支援問題單。請注意，IP 白名單同時適用於 {{site.data.keyword.cloudant_short_notm}} API 及「儀表板」，因此請注意包含需要直接存取「{{site.data.keyword.cloudant_short_notm}} 儀表板」的任何管理者 IP。
CORS | 使用 {{site.data.keyword.cloudant_short_notm}} 儀表板，以啟用特定網域的 CORS 支援。

<!--
> **Note**: Your data is visible to the {{site.data.keyword.cloudant_short_notm}} 
> worldwide team. If you don’t 
> want our team to see your data, encrypt it before sending it to 
> {{site.data.keyword.IBM_notm}}, and avoid leaking 
> data into your document `_id` and any attachment file names. In addition, 
> when you send personal data, you must use HTTPS to ensure that it is sent securely. 
> HTTP is no longer supported.  

> **Warning**: You are responsible for verifying that 
> {{site.data.keyword.cloudant_short_notm}} can be used to store 
> your data. You must also make sure that your data does not violate applicable 
> data protection laws or any regulations that require security measures 
> beyond those specified in the {{site.data.keyword.cloudant_short_notm}} 
> system requirements and {{site.data.keyword.cloud_notm}} Services terms. You must 
> verify that the security requirements are appropriate for any personal data 
> that is processed. If you are unsure, or intend to store data that is 
> beyond the scope of the {{site.data.keyword.cloudant_short_notm}} terms and conditions, 
> you must get approval from {{site.data.keyword.IBM_notm}} to ensure that it is 
> appropriate for {{site.data.keyword.cloudant_short_notm}} to store your data.
-->

## 防止資料流失或毀損
{: #protection-against-data-loss-or-corruption}

{{site.data.keyword.cloudant_short_notm}} 具有數個特性，可協助您維護資料品質及可用性：

特性 | 說明
--------|------------
備援及可延續資料儲存空間 |依預設，{{site.data.keyword.cloudant_short_notm}} 會將磁碟上每份文件的三個副本儲存至叢集裡的三個不同節點。儲存副本可確保不論是否發生失敗，都一定有一份資料的有效失效接手副本可用。
資料抄寫及匯出 |您可以在不同資料中心的叢集之間持續抄寫資料庫，或者抄寫至內部部署的 {{site.data.keyword.cloudant_short_notm}} Local 叢集或 Apache CouchDB。另一個選項是將資料從 {{site.data.keyword.cloudant_short_notm}}（以 JSON 格式）匯出至其他位置或來源（例如您自己的資料中心），以額外增加資料備援。
