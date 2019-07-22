---

copyright:
  years: 2017, 2019
lastupdated: "2019-06-12"

keywords: types and levels of protection, data redundancy, cross-region redundancy, database backup and recovery

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

# 災難回復及備份
{: #disaster-recovery-and-backup}

您的資料十分重要並具有價值。您要保護資料、協助確保它是安全、可用的，以及維護完整性。{{site.data.keyword.cloudantfull}} 提供數種方式來保護資料，以及協助維持應用程式的運作。
{: shortdesc}

其中有部分的保護特性是自動特性。針對其他形式的保護，{{site.data.keyword.cloudant_short_notm}} 提供支援的工具來協助您建立自己的高可用性及災難回復功能。

本文件概述 {{site.data.keyword.cloudant_short_notm}} 所提供的自動功能及支援的工具。

## 保護的類型及層次
{: #types-and-levels-of-protection}

您可能想要的保護類型取決於您正在嘗試解決的問題。

例如，您可能要有高階資料可用性，讓您仍然可以存取您的資料，即使系統內有限數量的硬體故障也是一樣。這是「高可用性 (HA)」需求。它表示在硬體故障之後仍然會提供最佳的可能持續資料可用性。在影響作業之前，不同的 HA 技術可容忍不同的故障層次。

或者，您可能要有輕鬆且快速的方式來備份及還原資料。例如，重大或大量硬體故障之後，您想要讓所有資料盡快可以在替代系統上使用。這是「災難回復 (DR)」需求。災難一般表示資料庫無法再於一個以上的位置中使用。例如，停電可能會導致資料庫叢集中的所有系統失敗。或者，大規模網路失敗可能表示無法聯絡叢集中的系統，即使它們持續正確地運作也是一樣。

處理 HA 或 DR 需求通常是從將問題簡化為較通用需求開始。當您識別需求時，即可套用協助解決通用需求的工具及特性。工具及特性合併使用時，就可以處理 HA 或 DR 需求。

不同的工具及特性可提供不同層次的保護。不同的特性可能較適合或較不適合您的特定 HA 或 DR 需求。
{: tip}

{{site.data.keyword.cloudant_short_notm}} 提供許多工具及特性，以處理一般需求：

1.	單一地區中的資料備援，也稱為[地區內自動資料備援](#in-region-automatic-data-redundancy)。
2.	跨地區資料備援和失效接手，也稱為[用於災難回復的跨地區備援](#cross-region-redundancy-for-disaster-recovery)。
3.	用於復原點還原的復原點 Snapshot 備份，使用「傳統」的[資料庫備份和回復](#database-backup-and-recovery)。

## 地區內自動資料備援
{: #in-region-automatic-data-redundancy}

在單一 {{site.data.keyword.cloudant_short_notm}} 帳戶內，使用內部及自動處理程序，將資料儲存成一式三份。
您不需要執行任何作業，就能啟用此內部資料抄寫。

地區內資料備援會啟用高可用性保護。明確地說，地區內資料備援針對地區內的硬體故障提供資料保護。地區內的硬體裝置故障時，只有該裝置上所儲存資料的副本才無法再使用。您的應用程式會保持可用，因為 {{site.data.keyword.cloudant_short_notm}} 會自動將要求遞送至地區內其他硬體裝置上仍然可用的資料副本。
同時，自動監視系統會偵測到硬體裝置故障，並提示動作以及後續還原完整備援。

{{site.data.keyword.cloudant_short_notm}} 帳戶位在單一地區內。
此特徵表示您儲存在帳戶內的所有資料都會儲存至不同的伺服器，而且每一部伺服器都是在該單一地區內進行管理。

地區內自動資料備援限制為：

1.	僅提供單一地區內的保護。
2.	維護現行資料。

若要在與您帳戶關聯的單一地區以及其他地區之間提供保護，請使用[用於災難回復的跨地區備援](#cross-region-redundancy-for-disaster-recovery)。

若要提供對資料「歷程」的保護（例如要能夠審核應用程式對資料進行的變更），請使用由[資料庫備份和回復](#database-backup-and-recovery)工具建立的資料 Snapshot。

總而言之，地區內資料備援透過提供影響地區內單一系統的失敗容錯，來啟用「高可用性」功能。

## 用於災難回復的跨地區備援
{: #cross-region-redundancy-for-disaster-recovery}

{{site.data.keyword.cloudant_short_notm}} 抄寫特性可協助您將彈性的災難回復功能建置到應用程式。啟用災難回復的主要方式是使用 {{site.data.keyword.cloudant_short_notm}} 抄寫來建立跨地區的備援。結果是您的應用程式可以容忍一個以上地區無法使用的狀況。

建立跨地區備援的基本步驟如下：

1.  在兩個以上的地區中建立 {{site.data.keyword.cloudant_short_notm}} 帳戶。
2.  視需要，在每一個地區中建立資料庫。
3.  針對必須使用跨地區備援儲存的資料庫，設定每一個帳戶的對應資料庫之間的雙向持續抄寫。
4.  設計及實作應用程式，以傳遞資料要求（視環境為「主動-被動」還是「主動-主動」配置而定）。如需設定此項的相關資訊，請參閱[配置 {{site.data.keyword.cloudant_short_notm}} 用於跨地區災難回復](/docs/services/Cloudant?topic=cloudant-configuring-ibm-cloudant-for-cross-region-disaster-recovery#configuring-ibm-cloudant-for-cross-region-disaster-recovery)。

當您設計應用程式使用跨多個地區的資料時，請考量下列各點：

* 應用程式可以將要求傳送至在最接近其實體位置處進行管理的資料庫。這項近似性使用可以減少網路延遲，並改善回應時間。此配置就是「主動-主動」方法。它的特徵是並行使用多份資料副本。在主動-主動配置內運作的應用程式必須有[處理衝突策略](/docs/services/Cloudant?topic=cloudant-document-versioning-and-mvcc#distributed-databases-and-conflicts)，才能避免發生多份資料副本的問題。
* 依預設，應用程式可以要求單一地區中的資料。如果地區無法使用，則應用程式可以切換為要求另一個地區中的資料。此配置就是「主動-被動」方法。它的特徵是一次只主動使用一組資料。
* 應用程式可以使用混合式配置，其中，單一帳戶用於所有資料寫入要求，以及專用於唯讀要求的其他位置。此配置視為「主動-主動」以進行讀取。
* 在災難情境中，您的應用程式必須重新遞送資料要求，以存取仍在線上的地區中進行管理的帳戶。此需求表示您的應用程式必須能夠偵測地區的流失，然後重新遞送資料要求。

總而言之，跨地區備援類似高可用性功能，但適用於影響整個地區的失敗。不過，配置您的應用程式正確使用跨備援配置，可提供真正的災難回復功能。原因是如果某個地區中的資料在一段時間內無法使用，應用程式仍然可以持續運作。{{site.data.keyword.cloudant_short_notm}} 抄寫有助於確保各地區之間的資料同步化。不過，您的應用程式必須能夠「失效接手」至其他地區中所儲存的資料副本。

## 資料庫備份和回復
{: #database-backup-and-recovery}

[地區內自動資料備援](#in-region-automatic-data-redundancy)為應用程式提供對資料的高可用性存取。[用於災難回復的跨地區備援](#cross-region-redundancy-for-disaster-recovery)為應用程式提供災難回復方法。不過，這兩個功能都著重在維護僅限_現行_ 資料副本的存取。

實際上，人員及應用程式可能會出錯，而以不想要的方式變更資料。應用程式本身可以實作某種保護，但有時還是會有不想要的變更通過。在此情況下，可從前一個時間點還原資料十分有用。資料庫備份支援此需求。

除了使用高可用性及災難回復特性來保護資料之外，也請考量定期將資料庫資料傾出到不同位置。請確定您檢查及測試備份，確認它們已完成且正確。

{{site.data.keyword.cloudant_short_notm}} 所支援的工具可協助您將資料庫中的 JSON 內容傾出至檔案，稍後會從那些檔案中還原資料庫。

具體而言，{{site.data.keyword.cloudant_short_notm}} 所支援的工具可協助您：

*	將完整資料庫備份至檔案，適合進一步處理及離站儲存。
*	從備份檔中所含的前一個狀態還原完整資料庫。

{{site.data.keyword.cloudant_short_notm}} 所支援的工具具有下列限制：
{: tip}

*	工具不會備份 `_security` 設定。
*	工具不會備份附件。
*	備份不是完全精確的「復原點」Snapshot。原因是資料庫中的文件將分批擷取，但其他應用程式可能會同時更新文件。因此，在讀取第一個批次與最後一個批次的時間之間，資料庫中的資料可能會變更。
*	備份已保留設計文件的索引定義，但還原資料時，必須重建索引。這項重建可能需要大量時間（視資料還原方式而定）。

## 資料保護策略的後續步驟
{: #next-steps-with-your-data-protection-strategies}

您可以開發以基本 {{site.data.keyword.cloudant_short_notm}} 功能及所支援工具為建置基礎的應用程式，以啟用較複雜的資料保護策略。

範例情境包括：

*	從前一個狀態還原單一文件。
*	儲存多個先前文件狀態，以容許從過去的較久時間還原。
*	將較舊的資料移轉至較便宜的儲存空間，以進行較具成本效益的保留。

備份工具包含開放程式碼 node.js 指令行應用程式及程式庫。它在 [NPM ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://www.npmjs.com/package/@cloudant/couchbackup){: new_window} 上可用。

如需說明如何將工具整合到資料保護策略中的構想和範例，請參閱 [{{site.data.keyword.cloudant_short_notm}} 備份和回復手冊](/docs/services/Cloudant?topic=cloudant-ibm-cloudant-backup-and-recovery#ibm-cloudant-backup-and-recovery)。
