---

copyright:
  years: 2015, 2017
lastupdated: "2017-08-25"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-03-16 -->

# Cloudant 供應項目

## 資料庫即服務

Cloudant 是已託管且完整受管理的資料庫即服務 (DBaaS)。它是從基礎建置，可以廣域擴充、不間斷地執行，並且處理廣泛的資料類型（例如 [JSON](../basics/index.html#json)、[全文](../api/cloudant_query.html#creating-an-index)及[地理空間](../api/cloudant-geo.html)）。Cloudant 是作業資料儲存庫，針對處理同時讀寫以及啟用高可用性和資料延續性而進行最佳化。

它提供 [HTTP API](../basics/index.html#http-api) 來使用 [JSON](../basics/index.html#json) 資料，以及提供 24 小時的作業支援及維護。Cloudant 是以 [Apache CouchDB ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](http://couchdb.apache.org/){:new_window} 為基礎，並以各種多方承租戶、專用及已安裝服務的形式交付。

>   **附註**：此文件中的所有貨幣值單位都是美元 ($)。

Cloudant DBaaS 供應項目是透過 [https://cloudant.com/ ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://cloudant.com/){:new_window} 提供。其提供為[共用方案](#shared-plan)或[企業（專用）方案](#enterprise-plan)。

Cloudant 也可作為 [IBM Bluemix 服務](bluemix.html)。

>	**附註：**[IBM Bluemix 服務](bluemix.html)上未提供 Cloudant [共用方案](#shared-plan)及[企業（專用）方案](#enterprise-plan)供應項目。

### 共用方案

使用「Cloudant 共用方案」，您可以存取透過共用或「多方承租戶」叢集所提供的所有 Cloudant DBaaS 功能。

定價是根據您的每月用量進行計量。如果您的每月用量低於 $50.00（截至 2016 年 8 月），則不會有任何費用。

如需相關資訊，請參閱[定價詳細資料 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://cloudant.com/product/pricing/){:new_window}。

### 企業方案

使用「Cloudant DBaaS 企業方案」，您可以存取透過專用、單一承租戶叢集所提供的所有 Cloudant DBaaS 功能。

此方案可以提供確保的資料庫效能及啟動時間，方法是使用各種管理位置上可用的專用 DBaaS 叢集或硬體。

如需相關資訊，請參閱[定價詳細資料 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://cloudant.com/product/pricing/){:new_window}。

## Cloudant Local

[IBM Cloudant Data Layer Local Edition (Cloudant Local) ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://www.ibm.com/support/knowledgecenter/SSTPQH_1.0.0/com.ibm.cloudant.local.doc/SSTPQH_1.0.0_welcome.html){:new_window} 是「Cloudant 資料庫即服務 (DBaaS)」供應項目的本端安裝版本。

Cloudant Local 提供與完整 Cloudant 單一承租戶供應項目相同的基本功能，但在您自己的資料中心內進行管理。

[提供 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](http://www-01.ibm.com/support/knowledgecenter/SSTPQH_1.0.0/com.ibm.cloudant.local.install.doc/topics/clinstall_cloudant_local_overview.html?lang=en-us){:new_window} Cloudant Local 的更詳細概觀。[IBM Knowledge Center ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](http://www-01.ibm.com/support/knowledgecenter/SSTPQH_1.0.0/com.ibm.cloudant.local.doc/SSTPQH_1.0.0_welcome.html?lang=en){:new_window} 提供 Cloudant Local 許多層面的相關資訊，包括：

-   [安裝與配置 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](http://www.ibm.com/support/knowledgecenter/SSTPQH_1.0.0/com.ibm.cloudant.local.install.doc/topics/clinstall_extract_install_cloudant_local.html?lang=en){:new_window}。
-   [維護作業 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](http://www-01.ibm.com/support/knowledgecenter/SSTPQH_1.0.0/com.ibm.cloudant.local.install.doc/topics/clinstall_maintenance_tasks_overview.html?lang=en){:new_window}。
-   [調整抄寫參數 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](http://www-01.ibm.com/support/knowledgecenter/SSTPQH_1.0.0/com.ibm.cloudant.local.install.doc/topics/clinstall_tuning_parameters_replication_cases.html?lang=en){:new_window}。

## [安全](security.html)

資料存取控制、加密及資料備份特性，可讓金融服務、政府、電子商務、電信、醫療保健及其他注重安全的產業中的客戶受益於 {{site.data.keyword.cloudantfull}}。

## [相符性](compliance.html)

{{site.data.keyword.cloudant_short_notm}} 提供可靠且安全的雲端資料庫系統。此服務是以業界最佳標準（包括 ISO 27001:2013）為建置基礎。

[提供](dataprivacygovernance.html)「{{site.data.keyword.cloudant_short_notm}} 資料隱私及控管」的詳細資料。
