---

copyright:
  years: 2018
lastupdated: "2018-10-24"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:tip: .tip}

<!-- Acrolinx: 2017-05-10 -->

# 一般資料保護規範 (GDPR)

GDPR 嘗試建立跨歐盟的協調資料保護法律架構，而且目的是將居民的個人資料控制權返還給居民，同時對於在全球任何位置管理及「處理」此資料的人員強制施行嚴格的規則。此「規範」也會建立與在歐盟內外部自由移動個人資料有關的規則。 

使用[一般資料保護規範 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://www.eugdpr.org/){:new_window}，{{site.data.keyword.cloudantfull}} 客戶可以依賴 {{site.data.keyword.cloudant_short_notm}} 團隊對新興資料隱私標準及法規的瞭解及遵循，也需要知道 {{site.data.keyword.IBM}} 有更廣泛的能力可以提供一組完整的解決方案，來協助各種規模的企業滿足自己的內部資料控管需求。

## 如何審核對 {{site.data.keyword.cloudant_short_notm}} 的存取權？

您可以在[審核記載](../offerings/audit.html#audit-logging){:new_window}中尋找審核的相關資訊。 

## 支援的個人資料分類

{{site.data.keyword.cloudant_short_notm}} 針對 GDPR 支援下列「個人資料」種類：

**個人資料**，例如：
 * 身分/公民狀態
 * 個人生活
 * 專業生活
 * 位置資料
 * 連線/裝置資料

**機密個人資料**，限制為：
  * 健康資料，額外的條件說明於 [{{site.data.keyword.cloudant_short_notm}} Dedicated Cluster Service Description ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://www-03.ibm.com/software/sla/sladb.nsf/pdf/6756-04/$file/i126-6756-04_05-2018_en_US.pdf){:new_window} 及 [{{site.data.keyword.cloud}} Additional Service Description ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://www-03.ibm.com/software/sla/sladb.nsf/pdf/6627-04/$file/i126-6627-04_04-2018_en_US.pdf){:new_window}

如果您要儲存醫療保健資料，則*必須* 完成下列作業：
 - 在寫入任何資料之前，請先通知 {{site.data.keyword.cloudant_short_notm}}。
 - 要求符合 HIPAA 標準的專用叢集。

如需所支援「個人資料」分類的相關資訊，請參閱 [Data Sheet Addendum (DSA) 的 2. Personal Data ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://www.ibm.com/software/reports/compatibility/clarity-reports/report/html/softwareReqsForProduct?deliverableId=2EBB5860B34311E7A9EB066095601ABB){:new_window}。

## 關於我的資料

{{site.data.keyword.cloudant_short_notm}} 會記錄其使用者的一些資料，而且是上述「個人資訊 (PI)」資料的「資料控制者」。{{site.data.keyword.cloudant_short_notm}} 所記錄的資料取決於您所擁有的帳戶類型。

如果您有 {{site.data.keyword.cloudant_short_notm}} Dedicated 叢集/{{site.data.keyword.cloudant_short_notm}} Enterprise 叢集，則我們會記錄您的相關資料，並且我們會被視為在 GDPR 環境定義內對於您的資料的「資料控制者」。如果您有 {{site.data.keyword.cloudant_short_notm}} Dedicated 叢集/{{site.data.keyword.cloudant_short_notm}} Enterprise 叢集，則我們會有您的：

 * 姓名
 * 電子郵件
  {{site.data.keyword.cloudant_short_notm}} 所保留的資料可以透過 {{site.data.keyword.cloudant_short_notm}} 儀表板檢視及更新。

如果您有 {{site.data.keyword.cloud_notm}}（包括專用實例）所佈建的帳戶，則 {{site.data.keyword.cloudant_short_notm}} _不_ 會收集先前提及的個人資料。此資料由 {{site.data.keyword.cloud_notm}} 保留。

{{site.data.keyword.cloudant_short_notm}} 會在執行服務以及最佳化其使用者體驗的過程中，處理有限的客戶 PI。{{site.data.keyword.cloudant_short_notm}} 會適當地使用電子郵件來與客戶聯絡。監視客戶與 {{site.data.keyword.cloudant_short_notm}} 儀表板的互動是 {{site.data.keyword.cloudant_short_notm}} 處理 PI 的另一種方式。

### 處理的限制

{{site.data.keyword.cloudant_short_notm}} 會將儀表板互動資料傳送至 Segment。您可以透過 [{{site.data.keyword.cloudant_short_notm}} 支援要求](mailto:support@cloudant.com)，要求 {{site.data.keyword.cloudant_short_notm}} 限制以此方式處理客戶 PI。收到這類要求時，{{site.data.keyword.cloudant_short_notm}} 會刪除傳送至 Segment 的客戶相關聯資訊，並防止進一步傳送資料。{{site.data.keyword.cloudant_short_notm}} 需要保留透過電子郵件聯絡專用客戶的能力，並提供介面供客戶直接維持此資訊的最新版本，或讓客戶透過其 {{site.data.keyword.cloud_notm}} 帳戶詳細資料配置其聯絡人詳細資料而維持最新的資訊。

## 我們的 {{site.data.keyword.cloudant_short_notm}} 資料庫是否已加密？

所有叢集都有使用 Linux Unified Key Setup (LUKS) 的加密檔案系統（靜態加密）。我們的作業及支援團隊可以看到資料庫中的資料（請參閱下面）。

對於機密資料（即您決定維持不讓 {{site.data.keyword.cloudant_short_notm}} 看到的資料），您必須在將資料傳送給我們之前加密或以其他方式保護（匿名化）資料。您必須避免使用 PI 作為 URL 中的文件 `_id`（例如，`https://$ACCOUNT.cloudant.com/$DATABASE/$DOCUMENT_ID`），因為這些一律可見且會寫入存取日誌中。

## 資料位置

{{site.data.keyword.cloudant_short_notm}} 處理個人資料的位置，會透過 DSA 提供使用並保持最新。

如需資料位置的相關資訊，請參閱 [7. {{site.data.keyword.IBM_notm}} Hosting and Processing Locations 下的 DSA ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://www.ibm.com/software/reports/compatibility/clarity-reports/report/html/softwareReqsForProduct?deliverableId=2EBB5860B34311E7A9EB066095601ABB){:new_window}。

## 服務安全

### 安全地使用 {{site.data.keyword.cloudant_short_notm}}

身為 {{site.data.keyword.cloudant_short_notm}} 的使用者，您應該：

 * 使用預設 CORS 配置來防止非預期的存取。
 * 充裕地使用 API 金鑰，使得元件可以具有與審核日誌連結的「最低特許存取權」。此作法讓您可以瞭解哪些人員存取了哪些資料。
 * 加密或以其他方式保護（匿名化）您判定必須要對 {{site.data.keyword.cloudant_short_notm}} 隱藏的機密資料。

### 實體及環境安全措施

基礎架構提供者（SoftLayer、AWS 及 21Vianet）會處理資料中心的實體安全。他們全都具備外部審核的實體安全認證。{{site.data.keyword.cloudant_short_notm}} 不會針對我們的資料中心內施行的實體安全控制措施，提供進一步詳細資料。

我們人員所使用的辦公室位置，實體安全是由 {{site.data.keyword.IBM_notm}} Corporate 處理。在要求時，可以將認證詳細資料及認證報告（即 ISO 及 SOC2）提供給客戶。

### 技術及組織措施

{{site.data.keyword.cloudant_short_notm}} 採用「技術及組織措施 (TOM)」，以確保「個人資料」的安全。{{site.data.keyword.cloudant_short_notm}} 針對 {{site.data.keyword.cloudant_short_notm}} 所採用的控制措施，具備外部審核的認證。在要求時，可以將認證詳細資料及認證報告（即 ISO 及 SOC2）提供給客戶。

### 服務資料存取

{{site.data.keyword.cloudant_short_notm}} 作業及支援人員可以存取客戶資料，而且可以在日常作業期間進行存取。這項存取只有在需要時才會進行，用來操作及支援服務。存取也僅限於*必須知道* 的基準，並加以記載、監視及審核。

## 資料刪除

### 刪除文件

刪除文件時，資料庫會建立「圖碑」。圖碑包含的內容取決於您刪除它的方式：

 - 如果您發出 `DELETE` 呼叫，則圖碑會包含 `_id`、`_rev` 及 `_deleted` 欄位。
 - 如果您刪除文件的方式是使用 `_deleted: true` 欄位來更新文件，並對它進行 `PUT` 或 `POST` 處理，則圖碑會包含您在文件內文中所設定的資訊。在某些情況下，這項作法很有用，例如，在圖碑中記錄文件刪除的原因時。

如需刪除圖碑的相關資訊，請參閱[簡單移除「圖碑」文件](../api/document.html#-tombstone-documents){:new_window}。

### 移除已刪除文件的時機？

壓縮會自動執行，並定期移除資料庫中的舊修訂（已刪除或其他情況），方法是只將「葉節點」修訂寫入至新檔案中。{{site.data.keyword.cloudant_short_notm}} 會保留 `_id` 及 `_rev` 的歷程來啟用抄寫，但不保留舊的文件內文。

> **附註**：{{site.data.keyword.cloudant_short_notm}} 不會公開 CouchDB 壓縮 API。

{{site.data.keyword.cloudant_short_notm}} 不保證將會在特定時間壓縮資料庫。
壓縮是以背景處理程序形式跨儲存空間層級執行，而且一律會壓縮資料庫；並不保證它就是您剛剛刪除/變更的資料。

{{site.data.keyword.cloudant_short_notm}} 將會透過 [{{site.data.keyword.IBM_notm}} Data Privacy Office (DPO) ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](http://w3-03.ibm.com/ibm/privacy/index.html){:new_window} 接受*被遺忘權* 要求。如果從 {{site.data.keyword.IBM_notm}} DPO 發出*被遺忘權* 要求，{{site.data.keyword.cloudant_short_notm}} 會驗證要求、明確地觸發資料庫壓縮，然後驗證已執行壓縮。在此處理程序結束時，文件的唯一版本就是其圖碑（`_id`、`_rev`、`_deleted`，以及您的應用程式在該處包含的所有欄位）。

### 圖碑移除

{{site.data.keyword.cloudant_short_notm}} 可以在必要時完全移除文件的所有參照及資料。此作業是操作員管理的處理程序，稱為清除。要求清除文件之前，請務必瞭解，在處理程序完成之後，{{site.data.keyword.cloudant_short_notm}} 就*無法回復* 已清除的文件。

> **附註**：{{site.data.keyword.cloudant_short_notm}} 不支援 CouchDB 清除 API。

在 GDPR 環境定義中，只有在文件 ID 中使用 PI 時，才需要清除。基於許多原因，讓 `_id` 儲存 PI 並不是一個好主意，但有許多半有效的使用案例（例如，唯一電子郵件）。如果可能的話，請加密或匿名化資料，讓 {{site.data.keyword.cloudant_short_notm}} 無法處理它。

如果需要透過*被遺忘權* 要求來移除文件，請執行下列動作：

1. 使用 [{{site.data.keyword.IBM_notm}} DPO ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](http://w3-03.ibm.com/ibm/privacy/index.html){:new_window} 將要求建檔，以要求清除特定文件 `_id` 值及原因。
1. {{site.data.keyword.IBM_notm}} DPO 收到正式要求時，{{site.data.keyword.cloudant_short_notm}} 作業團隊會驗證要求以確認 `id` 包含 PI。{{site.data.keyword.cloudant_short_notm}} 不會清除 `_id` 中沒有 PI 的資料。 
1. {{site.data.keyword.cloudant_short_notm}} 會觸發清除動作，永久移除所要求的資料。

此處理程序僅用於緊急刪除要求（例如，*被遺忘權*），而且不得長期依賴。如果您的應用程式刻意在文件 ID 中使用 PI，則必須變更為將該 PI 匿名化，或是不要在文件 ID 中使用 PI。您不能依賴 {{site.data.keyword.cloudant_short_notm}} 作業團隊定期進行清除來避免此狀況。因此，{{site.data.keyword.cloudant_short_notm}} 會拒絕下列清除要求：

1. 要求是針對定期清除，例如，*每 30 天*。
1. 要求是針對超過 100 份文件。

即使透過清除，`_id` 欄位中的 PI 還是會洩漏到您不想要它出現的位置（例如 {{site.data.keyword.cloudant_short_notm}} 日誌），因此應予以避免。{{site.data.keyword.cloudant_short_notm}} 有保留這些日誌的商業原因，且不會移除包含文件 `_id` 值的日誌行。

### 刪除資料庫會如何？

刪除資料庫時會將資料庫放入垃圾筒中最多 48 小時，之後即會從檔案系統移除。{{site.data.keyword.cloudant_short_notm}} 團隊*不* 會備份您的資料庫；此作業是*客戶的責任*。您必須確定從系統移除您資料庫的所有副本。如需相關資訊，請參閱 [{{site.data.keyword.cloudant_short_notm}} 備份及回復](../guides/backup-cookbook.html#cloudant-nosql-db-backup-and-recovery){:new_window}。 

如果您需要其他協助，請與 [{{site.data.keyword.cloudant_short_notm}} 支援中心 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](mailto:support@cloudant.com) 聯絡。

