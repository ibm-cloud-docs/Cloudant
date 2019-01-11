---

copyright:
  years: 2015, 2018
lastupdated: "2018-10-24"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:tip: .tip}

<!-- Acrolinx: 2017-05-10 -->

# {{site.data.keyword.cloudant_local_notm}}

[{{site.data.keyword.cloudantfull}} Data Layer Local Edition ({{site.data.keyword.cloudant_local_notm}}) ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://www.ibm.com/support/knowledgecenter/SSTPQH_1.1.0/com.ibm.cloudant.local.doc/SSTPQH_1.1.0_welcome.html){:new_window} 是「{{site.data.keyword.cloudant_short_notm}} 資料庫即服務 (DBaaS)」供應項目的本端安裝版本。

{{site.data.keyword.cloudant_local_notm}} 提供與完整 {{site.data.keyword.cloudant_short_notm}} 單一承租戶供應項目相同的基本功能，但在您自己的資料中心內進行管理。

[已提供 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://www.ibm.com/support/knowledgecenter/en/SSTPQH_1.1.0/com.ibm.cloudant.local.install.doc/topics/clinstall_cloudant_local_overview.html){:new_window} {{site.data.keyword.cloudant_local_notm}} 的更詳細概觀。[IBM Knowledge Center ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://www.ibm.com/support/knowledgecenter/en/SSTPQH_1.1.0/com.ibm.cloudant.local.doc/SSTPQH_1.1.0_welcome.html){:new_window} 提供 {{site.data.keyword.cloudant_local_notm}} 許多層面的相關資訊，包括：

-   [安裝與配置 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://www.ibm.com/support/knowledgecenter/en/SSTPQH_1.1.0/com.ibm.cloudant.local.install.doc/topics/clinstall_installing.html){:new_window}。
-   [維護作業 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://www.ibm.com/support/knowledgecenter/en/SSTPQH_1.1.0/com.ibm.cloudant.local.install.doc/topics/clinstall_maintenance_tasks_overview.html){:new_window}。
-   [調整抄寫參數 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://www.ibm.com/support/knowledgecenter/en/SSTPQH_1.1.0/com.ibm.cloudant.local.install.doc/topics/clinstall_tuning_parameters_replication_cases.html){:new_window}。

## 支援

{{site.data.keyword.cloudant_short_notm}} 支援中心能夠提供安裝、設定及適當使用 {{site.data.keyword.cloudant_local_notm}} 的協助。在發生效能問題或不一致的情況下，支援中心可以協助疑難排解。在運作中斷的情況下，支援中心可以協助診斷問題，但解決問題的責任落在客戶團隊，因為我們無法存取客戶系統。

需要有足夠的日誌，才能提供任何問題的適當協助。為了協助盡快開始疑難排解，您必須在通知支援中心發生問題時，包含 Weatherreport 公用程式的輸出，以及所有相關日誌、要求和狀態碼。如需相關資訊，請參閱 [Weatherreport 公用程式 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://www.ibm.com/support/knowledgecenter/SSTPQH_1.1.0/com.ibm.cloudant.local.install.doc/topics/clinstall_checking_health_cluster_with_weatherreport.html){:new_window}。

只有在基礎問題是在支援範圍內時，才能提供常見問題及運作中斷的協助。下列文字說明提供的支援： 

{{site.data.keyword.cloudant_short_notm}} 支援中心會處理下列問題：
- 適當的安裝
- 設定
- 與傳回錯誤或非預期結果之 API 或效能相關的所有項目

{{site.data.keyword.cloudant_short_notm}} 支援中心不會處理下列問題：
- 專有的客戶端工具或工作流程
- 網路問題 
- 磁碟上的加密 
- 自訂工具或功能

例如，如果主要原因是客戶所擁有的伺服器遭遇硬體問題，則支援中心無法協助。不過，如果運作中斷的原因是 {{site.data.keyword.cloudant_short_notm}} 軟體本身（例如，如果因文件衝突而發生要求速度趨緩），則支援中心可以協助客戶解決該問題。

請與您的「客戶成功經理」或「客戶經理」聯絡，以取得下列要求的進一步協助：
- 效能調整
- 設計最佳化
- 容量規劃

如果您有任何關於支援原則的問題，請與 [{{site.data.keyword.cloudant_short_notm}} 支援團隊 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](mailto:support@cloudant.com){:new_window} 聯絡。

### 如何開立支援問題單
若要取得 {{site.data.keyword.cloudant_local_notm}} 問題的協助，請使用 {{site.data.keyword.cloudant_short_notm}} 支援中心開立支援問題單，並包含下列資訊：

1. 建立電子郵件，以開立 [{{site.data.keyword.cloudant_short_notm}} 支援要求](mailto:support@cloudant.com)。
2. 在電子郵件主旨行中，為問題提供一個句子。
3. 電子郵件必須包含下列詳細資料，以協助我們診斷您的問題：
    - 姓名
    - 聯絡人電子郵件位址
    - 組織名稱
    - 您所使用的 {{site.data.keyword.cloudant_local_notm}} 版本
    - 您用來執行 {{site.data.keyword.cloudant_local_notm}} 的 Linux 發行套件及版本
    - 問題的嚴重性層次
    - 問題的詳細說明，包括發生時的情況以及任何最近變更的相關資訊
    - 如果有的話，請附加日誌或輸出，以協助診斷、重製及調查問題
4. 支援中心收到電子郵件時，支援團隊成員將會與您聯絡。

