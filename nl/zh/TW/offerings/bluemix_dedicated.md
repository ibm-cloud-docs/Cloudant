---

copyright:
  years: 2015, 2019
lastupdated: "2019-06-12"

keywords: hardware capacity, location, tenancy, security, encryption, compliance, high availability, disaster recovery, backup

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

# {{site.data.keyword.cloud_notm}} Dedicated
{: #ibm-cloud-dedicated}

{{site.data.keyword.cloudantfull}} for {{site.data.keyword.cloud}} Dedicated 是 {{site.data.keyword.cloud_notm}} Dedicated 環境的選購附加程式。{{site.data.keyword.cloud_notm}} Dedicated 中適用於 {{site.data.keyword.cloudant_short_notm}} Dedicated 的選購附加程式是根據配置給環境的硬體容量定價，可以與 {{site.data.keyword.IBM}} 業務代表聯絡來進行購買。  
{: shortdesc}

{{site.data.keyword.cloud_notm}} Dedicated 客戶也可以選擇透過聯合型錄（包括「精簡方案」及「標準方案」實例），在 {{site.data.keyword.cloud_notm}} Public 中使用 {{site.data.keyword.cloudant_short_notm}}。請注意，{{site.data.keyword.cloud_notm}} Dedicated 使用者不符合從 {{site.data.keyword.cloud_notm}} Public 型錄購買「專用硬體方案」的資格，如果需要專用硬體，應該利用 {{site.data.keyword.cloud_notm}} Dedicated 上的 {{site.data.keyword.cloudant_short_notm}} Dedicated。   

下列擷取畫面 / 畫面顯示了範例 {{site.data.keyword.cloud_notm}}「型錄」，其中強調顯示了 {{site.data.keyword.cloudant_short_notm}} 和 {{site.data.keyword.cloudant_short_notm}} Dedicated 環境的 {{site.data.keyword.cloud_notm}} Public 聯合版本。  

![{{site.data.keyword.cloudant_short_notm}} 型錄](../images/ibmcloud_catalog.png)

## 硬體容量 
{: #hardware-capacity}

{{site.data.keyword.cloud_notm}} Dedicated 內的 {{site.data.keyword.cloudant_short_notm}} 是透過「{{site.data.keyword.cloud_notm}} Dedicated {{site.data.keyword.cloudant_short_notm}} 1.6 TB 容量」組件所購買，此組件包括由三個資料庫節點及兩個負載平衡器所組成的叢集 {{site.data.keyword.cloudant_short_notm}} 環境。每一個資料庫節點在 SSD 上都包含 1.6 TB，而且，因為所有資料都會儲存成一式三份，所以這相當於跨叢集的 1.6 TB 唯一磁碟空間。購買其他「{{site.data.keyword.cloud_notm}} Dedicated {{site.data.keyword.cloudant_short_notm}} 1.6TB 容量」組件，即可擴充環境，此組件可用來以三個資料庫節點的倍數擴充 {{site.data.keyword.cloudant_short_notm}} 叢集。客戶也可以選擇有多個不同的 {{site.data.keyword.cloudant_short_notm}} 環境，而不是擴充單一環境。

## 專用環境中的位置和租賃
{: #locations-and-tenancy-in-a-dedicated-environment}

{{site.data.keyword.cloud_notm}} Dedicated 環境內的 {{site.data.keyword.cloudant_short_notm}} Dedicated 環境，位於指定單獨供 {{site.data.keyword.cloud_notm}} Dedicated 客戶使用的硬體上。客戶可以在給定環境上佈建一個以上的 {{site.data.keyword.cloudant_short_notm}} 實例，而且每一個 {{site.data.keyword.cloudant_short_notm}} 實例都會共用構成 {{site.data.keyword.cloudant_short_notm}} 環境的基礎硬體資源。 

## 安全、加密和合規性 
{: #security-encryption-and-compliance}

在使用[靜態 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://en.wikipedia.org/wiki/Data_at_rest) 磁碟加密的伺服器上，會提供所有方案。存取是透過公用網路連線進行，並使用 HTTPS 進行加密。如需更多詳細資料，請參閱[安全](/docs/services/Cloudant?topic=cloudant-security#security)。IP 白名單會在要求「{{site.data.keyword.cloudant_short_notm}} 支援中心」時提供，而且適用於整個 {{site.data.keyword.cloudant_short_notm}} 環境，而不是實例層次。  

此方案還提供[合規性認證](/docs/services/Cloudant?topic=cloudant-compliance#compliance)。 

[HIPAA ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://en.wikipedia.org/wiki/Health_Insurance_Portability_and_Accountability_Act){: new_window} 法規遵循會在要求時提供，因此請在 {{site.data.keyword.IBM_notm}} 業務代表的購買處理程序期間要求此項。 

## 高可用性、災難回復及備份 
{: #high-availability-disaster-recovery-and-backup}

若要在資料中心內提供高可用性 (HA) 及災難回復 (DR)，所有資料都會跨叢集裡的三台不同實體伺服器，儲存成一式三份。可用時，您可以在多個位置內佈建帳戶，然後使用持續資料抄寫以提供跨資料中心的 HA/DR。{{site.data.keyword.cloudant_short_notm}} 資料不會自動進行備份，但提供支援的工具來處理備份。請檢閱[災難回復及備份](/docs/services/Cloudant?topic=cloudant-disaster-recovery-and-backup#disaster-recovery-and-backup)手冊來探索所有 HA、DR 及備份考量，以符合應用程式需求。
