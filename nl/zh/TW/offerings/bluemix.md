---

copyright:
  years: 2015, 2017
lastupdated: "2017-06-09"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-02-23 -->

# IBM Bluemix

{{site.data.keyword.cloudant}} 也可作為 [{{site.data.keyword.Bluemix}} 服務 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://console.ng.bluemix.net/catalog/services/cloudant-nosql-db/){:new_window}。
{:shortdesc}

{{site.data.keyword.Bluemix_short}} 是一種用來建置、執行及管理應用程式的開放式標準雲端平台。請在[首頁 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://console.ng.bluemix.net/){:new_window} 深入瞭解 {{site.data.keyword.Bluemix_notm}} 並開始使用它。

## Bluemix 公用

{{site.data.keyword.cloudantfull}} 提供為免費的[精簡方案](#lite-plan)，並且提供為付費[標準方案](#standard-plan)內的數個配置。也提供[專用方案](#dedicated-plan)。此方案提供與「標準方案」相同的配置性能，但卻是在專用硬體上提供。專用硬體不會與任何其他帳戶共用，這表示它是專供您使用。如果在[美國地區](#locations)內佈建「專用方案」實例，您可以選擇性地選取 [HIPAA ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://en.wikipedia.org/wiki/Health_Insurance_Portability_and_Accountability_Act){:new_window} 相容配置。

下表彙總每一個方案的效能測量。

>   **附註**：表格中指出截至 2016 年 9 月為止的詳細資料。
    如需現行值，請聯絡 [{{site.data.keyword.cloudant_short_notm}} 支援中心 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](mailto:support@cloudant.com){:new_window}。

>   **附註**：此文件中的所有貨幣值單位都是美元 ($)。

<table border='1'>

<tr>
<th>方案</th><th>精簡</th><th colspan='4'>標準<i>及</i> 專用</th>
</tr>
<tr>
<td>基本價（每小時）</td>
<td>$0.00</td>
<td colspan='4'>請參閱<a href="http://cloudant.com/bluemix" target="_blank">定價詳細資料 <img src="../images/launch-glyph.svg" alt="外部鏈結圖示" title="外部鏈結圖示"></a>。</td>
</tr>
<tr>
<td>佈建的傳輸量（每秒查閱數）</td>
<td>20</td>
<td>100</td>
<td>1,000</td>
<td>5,000</td>
<td>20,000</td>
</tr>
<tr>
<td>佈建的傳輸量（每秒寫入數）</td>
<td>10</td>
<td>50</td>
<td>500</td>
<td>2,500</td>
<td>10,000</td>
</tr>
<tr>
<td>佈建的傳輸量（每秒查詢數）</td>
<td>5</td>
<td>5</td>
<td>50</td>
<td>250</td>
<td>1,000</td>
</tr>
<tr>
<td>個別文件大小上限</td>
<td>1 MB</td>
<td colspan='4'>1 MB</td>
</tr>
<tr>
<td>所含的磁碟空間</td>
<td>1 GB</td>
<td colspan='4'>20 GB</td>
</tr>
<tr>
<td>磁碟超額（每 GB/小時）</td>
<td>無法使用</td>
<td colspan='4'>請參閱<a href="http://cloudant.com/bluemix" target="_blank">定價詳細資料 <img src="../images/launch-glyph.svg" alt="外部鏈結圖示" title="外部鏈結圖示"></a>。</td>
</tr>

</table>

您可以選取要在[佈建 {{site.data.keyword.cloudant_short_notm}} 服務實例](#provisioning-a-cloudant-instance-on-bluemix)時使用的方案。依預設，會選取[精簡方案](#lite-plan)。

![Cloudant 服務實例方案選取](../images/fb87416a.png)

### 精簡方案

「精簡方案」是免費的，但限制您最多可以使用 1 GB 的資料儲存空間。這些限制也適用於針對查閱、寫入及查詢所佈建的傳輸量。 

儲存空間用量會每日進行檢查。如果您超出儲存空間限制，則帳戶的 HTTP 要求會接收到 402 狀態碼，且錯誤訊息為「帳戶已超出其資料用量配額。需要升級為付費方案。」橫幅也會出現在 Cloudant 儀表板上，以通知您。您仍然可以讀取及刪除資料。不過，若要寫入新的資料，您必須升級為付費帳戶，或刪除資料並等到下次檢查執行，以重新啟動帳戶。 

如果您要儲存多個 GB 的資料，或者具有較大的傳輸量，請移至[標準方案](#standard-plan)。

### 標準方案

「標準方案」包括 20 GB 的資料儲存空間。如果您的儲存量超過 20 GB，則會根據每小時每 GB 的定義成本向您收取費用。請參閱現行成本的[定價 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](http://cloudant.com/bluemix){:new_window} 資訊。在「標準方案」上，您也可以變更針對查閱、寫入及查詢所佈建的傳輸量。

### 專用方案

{{site.data.keyword.cloudant_short_notm}} 在單一承租戶專用硬體上提供，以作為 [{{site.data.keyword.Bluemix_notm}} 專用 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](http://www.ibm.com/cloud-computing/bluemix/dedicated/){:new_window} 配置的一部分。

<div id="servicetier"></div>

## 服務層級

您可以查看帳戶可用方案內傳輸量的詳細資料。您可以透過 {{site.data.keyword.cloudant_short_notm}} 帳戶「儀表板」的「帳戶」標籤來選取要使用的佈建層次。

![帳戶儀表板](../images/cloudant_capacity.png)

若要移至不同傳輸量，請選取您要的佈建，然後按一下`變更容量`選項按鈕。系統會要求您確認變更，並提醒佈建變更最多可能需要 24 個小時才能完成。

![帳戶儀表板](../images/cloudant_capacity_change.png)

<div id="throughput"></div>

### 佈建的傳輸量

傳輸量佈建會識別並測量為三種事件中的其中一種：

1.	根據文件 `_id` 的查閱（這是特定文件的讀取）。
2.	寫入（這是個別文件的建立、修改或刪除），或任何因索引建置的更新。
3.	查詢（這是對其中一個 {{site.data.keyword.cloudant_short_notm}} 查詢端點提出的要求)，包括下列類型：
	-	主要索引 ([`_all_docs`](../api/database.html#get-documents))
	-	MapReduce 視圖 ([`_view`](../api/creating_views.html#using-views))
	-	搜尋索引 ([`_search`](../api/search.html#queries))
	-	地理空間索引 ([`_geo`](../api/cloudant-geo.html#querying-a-cloudant-geo-index))
	-	Cloudant 查詢 ([`_find`](../api/cloudant_query.html#finding-documents-using-an-index))
	-	變更 ([`_changes`](../api/database.html#get-changes))

傳輸量測量是每秒每一種類型之事件數目的簡單計數，其中秒是_滑動_ 視窗。如果您的帳戶超出針對方案所佈建的傳輸量事件數目，則除非滑動視窗內的事件數目不再超出佈建的數目，否則會拒絕要求。它可能有助於將滑動 1 秒視窗視為 1,000 毫秒的任何連續期間。

例如，如果您是使用每秒佈建 200 個查閱數的「標準方案」，則您的帳戶在 1,000 毫秒（1 秒）的連續期間最多可以進行 200 個查閱要求。除非滑動 1,000 毫秒期間的查閱要求數目再度掉到小於 200，否則會拒絕在該期間進行的後續查閱要求。

因超出事件數目而拒絕要求時，應用程式會接收到 [`429` 要求太多](../api/http.html#429)回應。

所支援用戶端程式庫的最新版本（適用於 [Java](../libraries/supported.html#java)、[Node.js](../libraries/supported.html#node-js) 及 [Python](../libraries/supported.html#python) 語言）可協助您處理 `429` 回應。例如，Java 程式庫擲出 [`TooManyRequestsException` ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](http://static.javadoc.io/com.cloudant/cloudant-client/2.5.1/com/cloudant/client/org/lightcouch/TooManyRequestsException.html){:new_window}。

依預設，在接收到 `429` 回應時，受支援的用戶端程式庫不會自動嘗試重試要求。

最好確定應用程式會正確地處理 `429` 回應。原因是重試次數有限；定期超過要求數目是移至不同方案配置的有力指標。

>   **附註**：如果您要移轉現有應用程式，則可能無法處理 `429` 回應。在移轉驗證期間，請確認應用程式正確地處理 `429` 回應。

總而言之，您必須確定您的應用程式可以正確地處理 [`429`](../api/http.html#429) 回應。

### 個別文件大小上限

資料會以 [JSON 文件](../api/document.html)形式儲存在 {{site.data.keyword.cloudant_short_notm}} 內。對於 {{site.data.keyword.Bluemix_notm}} 上 {{site.data.keyword.cloudant_short_notm}} 服務中的文件，個別文件的大小上限為 1 MB。超出此限制會導致 [`413` 錯誤](../api/http.html#413)。

### 所含的磁碟空間

此值是方案中所含的儲存空間容量。它同時用於資料及索引儲存空間。

### 磁碟超額

會監視所有「標準方案」及「精簡方案」服務實例的已使用磁碟空間。如果帳戶使用超過方案配置中所提供的儲存空間量，則會將它視為「溢位」。「溢位」會依指出的價格，針對超出方案配置所使用的每一個額外 GB，對帳戶進行收費。

您針對使用方案中所提供之磁碟空間還要多的磁碟空間所必須支付的額外金額稱為「超額」。「超額」是根據每小時來計算。不能溢出「精簡方案」中可用的磁碟空間。

例如，假設「標準方案」實例將磁碟用量增加為半天（12 小時）107 GB。這項變更表示您的實例比 20 GB 方案配置多溢出 87 GB 達 12 小時。因此，會根據 87 GB x 12 小時 = 1044 GB 小時，向您收取該額外空間的超額費用。

超額的計算方式是使用計費週期內特定小時期間超過方案配置的 GB 數目上限。

### 作用的超額範例

假設您從搭配使用一個月 30 天與使用 9 GB 儲存空間的「標準方案」服務實例開始。接下來，在第 3 天 02:00 開始的那個小時期間的 15 分鐘，您的儲存空間會增加為 21.5 GB。在 02:00 小時的接下來 10 分鐘，此實例會降回 9.5 GB，然後在 02:00 小時的接下來 25 分鐘增加為 108 GB。最後，您的實例會結束該小時，並在該月的剩餘時間降到 28 GB。

此模式表示在第 3 天第 2 小時期間，超過方案配置的 GB 數目上限為 88 GB。針對第 3 天的 03:00 小時，以及該月的剩餘時間，您的實例是超過方案配置 8 GB。

因此，針對第 3 天的 02:00 小時，會根據 88 GB x 1 小時 = 88 GB 小時，向您收取超額費用。

針對第 3 天的 03:00 小時到第 3 天結束，會根據 8 GB x 21 小時 = 168 GB 小時，向您收取超額費用。

針對第 4 天的 00:00 小時到該月結束（共 30 天），會根據 8 GB x 24 小時 x 27 天 = 5184 GB 小時，向您收取超額費用。

該月的總超額帳單將根據總計值 88 + 168 + 5184 = 5440 GB 小時來計算。

## 位置

依預設，「專用」以外的所有方案都是根據多方承租戶叢集。在方案選取期間，您可以從下列「{{site.data.keyword.Bluemix_notm}} 公用」地區中進行選擇：

-   美國南部
-   英國
-   雪梨
-   德國

## 安全、加密及相符性

在使用[靜態 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://en.wikipedia.org/wiki/Data_at_rest){:new_window} 磁碟加密的伺服器上，會提供所有方案。透過網路連線的存取是使用 HTTPS 進行加密。如需詳細資料，請參閱 [DBaaS 安全 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://cloudant.com/product/cloudant-features/dbaas-security/){:new_window}。

這些方案也提供[安全相符性憑證 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://cloudant.com/product/cloudant-features/cloudant-compliance/){:new_window}。[HIPAA ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://en.wikipedia.org/wiki/Health_Insurance_Portability_and_Accountability_Act){:new_window} 相符性需要[專用環境](#dedicated-plan)，因此，會在[佈建處理程序](#provisioning-a-cloudant-instance-on-bluemix)期間要求此環境。

## 高可用性、災難回復及備份

若要在資料中心內提供「高可用性 (HA)」及「災難回復 (DR)」，所有資料都會跨叢集中三個不同的實體伺服器儲存成一式三份。您可以在多個資料中心內佈建帳戶，然後使用持續資料抄寫以提供跨資料中心的 HA/DR。

{{site.data.keyword.cloudant_short_notm}} 資料不會自動進行備份。您可以要求啟用[增量備份特性](../guides/backup-guide.html)，或者使用[這裡 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://developer.ibm.com/clouddataservices/2016/03/22/simple-couchdb-and-cloudant-backup/){:new_window} 所說明的數種可能技術的其中一種，來實作您自己的解決方案。  

## 監視用量

在「{{site.data.keyword.cloudant_short_notm}} 儀表板」內「活動」標籤的「用量」窗格中，提供您用量的相關資訊。

![在儀表板上監視用量](../images/cloudant_usage.png).

這裡提供詳細資料，說明現行[傳輸量](#throughput)以及[已儲存資料](#disk-space-included)的數量。

監視可協助您辨識方案中的佈建變更是否適當。例如，如果您經常達到資料庫查閱數目上限，則可以透過「儀表板」的「帳戶」標籤上的[服務窗格](#servicetier)來修改佈建。

## 硬體規格

「專用」以外的所有方案都是在多方承租戶叢集上實作。為提供「高可用性」及「資料回復」，所有資料都會跨三個不同的實體節點儲存成一式三份。

## 支援

「標準方案」及「專用方案」服務實例的支援都是選用項目。其提供方式是購買「{{site.data.keyword.Bluemix_notm}} 標準支援」。未提供「精簡方案」的支援。

[這裡 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://console.ng.bluemix.net/?direct=classic/#/pricing/cloudOEPaneId=pricing&paneId=pricingSheet){:new_window} 提供「{{site.data.keyword.Bluemix_notm}} 標準支援」的定價計算機。[這裡 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](http://www-03.ibm.com/software/sla/sladb.nsf/pdf/6606-08/$file/i126-6606-08_05-2016_en_US.pdf){:new_window} 提供「支援服務水準合約 (SLA)」詳細資料的相關資訊。

## 在 Bluemix 上佈建 Cloudant 實例

您可以使用兩種方式在 {{site.data.keyword.Bluemix_notm}} 上佈建 {{site.data.keyword.cloudant_short_notm}} 實例：

-	使用「儀表板」。[這裡](../tutorials/create_service.html)提供可說明此處理程序的指導教學。
-	使用 Cloud Foundry 指令工具。[這裡](../tutorials/create_service_cli.html)提供可說明此處理程序的指導教學。
