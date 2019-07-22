---

copyright:
  years: 2017, 2019
lastupdated: "2019-06-12"

keywords: dbaas data protection, top-tier physical platforms, secure access control, data loss, corruption

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

# 安全
{: #security}


## {{site.data.keyword.cloudant_short_notm}} DBaaS 資料保護和安全
{: #ibm-cloudant-dbaas-data-protection-and-security}

保護大規模 Web 及行動應用程式的應用程式資料可能十分複雜，特別是分散式及 NoSQL 資料庫。

{{site.data.keyword.cloudantfull}} 不僅能減少維護資料庫的工作，讓資料庫持續不間斷地執行及成長，它也確保您的資料始終安全且受保護。
{: shortdesc}

## 頂層實體平台
{: #top-tier-physical-platforms}

{{site.data.keyword.cloudant_short_notm}} DBaaS 實體在第 1 層雲端基礎架構提供者（例如 {{site.data.keyword.cloud}} 及 Amazon）進行管理。因此，您的資料是受到這些提供者所使用的網路及實體安全措施所保護，包括（但不限於）：

- 認證：遵循 SSAE16、SOC2 類型 1、ISAE 3402、ISO 27001、CSA 及其他標準。
- 存取及身分管理。
- 資料中心及網路作業中心監視的一般實體安全。
- 伺服器強化。
- {{site.data.keyword.cloudant_short_notm}} 可讓您在 SLA 及成本需求變更時，彈性選擇或切換不同的提供者。

[法規遵循資訊](/docs/services/Cloudant?topic=cloudant-compliance#compliance)中提供認證的更多詳細資料。
{: tip}

## 安全存取控制
{: #secure-access-control}

{{site.data.keyword.cloudant_short_notm}} 有許多內建安全特性，可讓您控制資料存取權：

特性 | 說明
--------|------------
鑑別| {{site.data.keyword.cloudant_short_notm}} 是使用 HTTPS API 進行存取。當 API 端點需要時，會針對 {{site.data.keyword.cloudant_short_notm}} 收到的每個 HTTPS 要求鑑別使用者。 {{site.data.keyword.cloudant_short_notm}} 同時支援舊式及 IAM 存取控制。如需相關資訊，請參閱 [IAM 手冊](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-){: new_window}或舊式[鑑別 API 文件](/docs/services/Cloudant?topic=cloudant-authentication#authentication){: new_window}。
授權| {{site.data.keyword.cloudant_short_notm}} 同時支援舊式及 IAM 存取控制。{{site.data.keyword.cloudant_short_notm}} 團隊建議您儘可能使用 IAM 存取控制進行鑑別。如果您是使用 {{site.data.keyword.cloudant_short_notm}} 舊式鑑別，建議您使用 [API 金鑰](/docs/services/Cloudant?topic=cloudant-authorization#api-keys){: new_window}，而非帳戶層次認證，進行程式化存取及抄寫工作。如需相關資訊，請參閱 [IAM 手冊](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-){: new_window}或舊式[授權 API 文件](/docs/services/Cloudant?topic=cloudant-authentication#authentication){: new_window}及舊式[授權 API 文件](/docs/services/Cloudant?topic=cloudant-authorization#authorization){: new_window}。
靜態加密 | 靜態加密 {{site.data.keyword.cloudant_short_notm}} 實例中所儲存的所有資料。如果您需要「自帶金鑰 (BYOK)」來進行靜態加密，則會使用 {{site.data.keyword.cloud_notm}} Key Protect 予以啟用。針對所有地區中部署的新「{{site.data.keyword.cloudant_short_notm}} 專用硬體方案」實例，{{site.data.keyword.cloudant_short_notm}} 會支援此特性。首先，使用 {{site.data.keyword.cloud_notm}} 型錄來建立「專用硬體方案」的實例。然後，提交支援問題單。我們的支援團隊會協調取得新「專用硬體」實例的「靜態加密」加密金鑰，而這些加密金鑰由 Key Protect 實例所管理。
「進行中」加密 | 使用 HTTPS 加密對 {{site.data.keyword.cloudant_short_notm}} 的所有存取。
TLS | 我們建議您對 {{site.data.keyword.cloudant_short_notm}} 的所有存取使用 TLS 1.2 或 1.3。（***在 2019 年 6 月，{{site.data.keyword.cloudant_short_notm}} 支援即會棄用較舊版本（TLS 1.0 與 1.1），到時候只會支援 TLS 1.2+。***）{{site.data.keyword.cloudant_short_notm}} 用於 HTTPS 連線的憑證是由具公信力的「憑證管理中心」所簽署，而此「憑證管理中心」已預先得到所有瀏覽器、作業系統及其他軟體系統（像是「Java 開發套件 (JDK)」）的信任。我們承諾一律發佈由具公信力的「憑證管理中心」所簽署的有效（未過期）TLS 憑證。不過，我們無法與客戶協調變更，而且我們不承諾繼續使用 DigiCert。若要確保能繼續存取 {{site.data.keyword.cloudant_short_notm}} 服務，非常不鼓勵客戶固定使用現行憑證，因為在遭盜用的情況下，它可能過期並提示您替換。我們反而建議客戶對其作業系統及瀏覽器使用預設憑證組合，確保可以透過任何憑證變更來繼續提供安全服務。
端點 | 所有 {{site.data.keyword.cloudant_short_notm}} 實例都隨附可公開存取的外部端點。2019 年 1 月 1 日之後佈建的「專用硬體」環境也會為已在其上部署的所有「標準方案」實例新增內部端點。使用內部端點可讓客戶透過內部 {{site.data.keyword.cloud}} 網路連接至 {{site.data.keyword.cloudant_short_notm}} 實例，以避免上游應用程式資料流量經過公用網路，而引起頻寬計費。請參閱[服務端點文件](https://cloud.ibm.com/docs/services/service-endpoint/getting-started.html#about){:new_window}，以取得如何為您的 {{site.data.keyword.cloud}} 帳戶啟用「服務端點」的詳細資料。
IP 白名單 |具有專用 {{site.data.keyword.cloudant_short_notm}} 環境的 {{site.data.keyword.cloudant_short_notm}} 客戶可以將 IP 位址設為白名單，讓存取權僅限於在指定的伺服器及使用者。IP 白名單不適用於多方承租戶環境上所部署的任何「{{site.data.keyword.cloud_notm}} Public 精簡/標準方案」。針對指定的一組 IP 或 IP 範圍，開立要求 IP 白名單的支援問題單。請注意，IP 白名單同時適用於 {{site.data.keyword.cloudant_short_notm}} API 及「儀表板」，因此請注意包含需要直接存取「{{site.data.keyword.cloudant_short_notm}} 儀表板」的任何管理者 IP。
CORS | 使用「{{site.data.keyword.cloudant_short_notm}} 儀表板」或 API，以啟用特定網域的 CORS 支援。如需相關資訊，請參閱 [CORS API 文件](/docs/services/Cloudant?topic=cloudant-cors#cors){:new_window}。

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

## 防止資料流失或損壞
{: #protection-against-data-loss-or-corruption}

{{site.data.keyword.cloudant_short_notm}} 具有數個特性，可協助您維護資料品質及可用性：

特性 | 說明
--------|------------
備援及可延續資料儲存空間 |依預設，{{site.data.keyword.cloudant_short_notm}} 會將磁碟上每份文件的三個副本儲存至叢集裡的三個不同節點。儲存副本可確保不論是否發生失敗，都一定有一份資料的有效失效接手副本可用。
資料抄寫及匯出 |您可以在不同資料中心的叢集之間持續抄寫資料庫，或者抄寫至內部部署的 {{site.data.keyword.cloudant_short_notm}} Local 叢集或 Apache CouchDB。另一個選項是將資料從 {{site.data.keyword.cloudant_short_notm}}（以 JSON 格式）匯出至其他位置或來源（例如您自己的資料中心），以額外增加資料備援。
