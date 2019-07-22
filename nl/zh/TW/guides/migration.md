---

copyright:
  years: 2015, 2019
lastupdated: "2019-06-12"

keywords: curl and jq basics, monitor view builds and search indexes, estimate time to complete task, monitor replication, troubleshooting

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

<!-- Acrolinx: 2018-08-14 -->

# 移轉至 {{site.data.keyword.cloud_notm}} 上的 {{site.data.keyword.cloudant_short_notm}}
{: #migrating-to-ibm-cloudant-on-ibm-cloud}

[{{site.data.keyword.cloudantfull}} ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://www.ibm.com/cloud/cloudant){: new_window} 的「資料庫即服務」供應項目是在多方承租戶叢集上執行的 JSON 文件儲存庫。服務可以選擇具有可預測成本、可擴充性及服務水準合約 (SLA) 的地理位置。

本文件說明如何在 {{site.data.keyword.cloud_notm}} 上從下列其中一個方案移轉至「{{site.data.keyword.cloudant_short_notm}} 精簡方案」或「標準方案」實例：

方案 | 說明
-----|------------
{{site.data.keyword.cloudant_short_notm}} Enterprise| 專用、單一承租戶叢集
{{site.data.keyword.cloudant_short_notm}} 共用方案 | 舊式隨收隨付制、多方承租戶 {{site.data.keyword.cloudant_short_notm}} 服務。「`cloudant.com` 共用方案」已在 2018 年 3 月淘汰。「{{site.data.keyword.cloudant_short_notm}} 共用方案」自 2016 年 10 月起已針對新註冊淘汰使用，並且將在 2018 年第 4 季淘汰該共用方案。
{{site.data.keyword.cloudant_localfull}} | {{site.data.keyword.cloudant_short_notm}} 的自行管理、已包裝安裝。
Apache CouchDB| 根據 {{site.data.keyword.cloudant_short_notm}} 的自行管理、開放程式碼資料庫。

## 「{{site.data.keyword.cloudant_short_notm}} 精簡方案」及「標準方案」有哪些好處？
{: #what-are-the-benefits-of-the-ibm-cloudant-lite-and-standard-plans-}

「標準方案」容許您為資料庫服務*保留傳輸量*，亦即，指定應用程式的資料庫需要多少傳輸量來處理需求。「標準方案」也會針對您使用的儲存空間量計費。使用下列度量值來測量容量：

度量值 | 說明
-------|------------
每秒讀取數 | 執行簡單文件提取的速率，例如，以其 `_id` 來擷取文件，或使用分割區索引鍵針對分割資料庫進行查詢。
每秒寫入數 | 將資料寫入資料庫的速率。處理文件建立、更新或刪除的 API 呼叫會計算為「寫入」。
每秒廣域查詢數 | 使用廣域索引查詢資料庫的速率，一般是藉由存取 `_find` 端點，或使用次要 MapReduce、搜尋或地理空間索引。
儲存空間 | 您的 JSON 資料、附件及次要索引佔用的磁碟空間量。

舉例來說，「精簡方案」免費提供每秒 20 次讀取、每秒 10 次寫入、每秒 5 次廣域查詢，以及 1 GB 儲存空間。當您「直覺試用」產品以及在產品開發期間，此方案十分適合。當您的應用程式進入 QA 或正式作業時，請切換至「標準方案」來調整實例。「標準方案」的最小容量具有每秒 100 次讀取、每秒 50 次寫入、每秒 5 次廣域查詢，以及 20 GB 儲存空間（按 GB 收取額外儲存空間的費用），每個月 76.65 美元。 

透過使用「{{site.data.keyword.cloudant_short_notm}} 儀表板」中的調節器，可以在需要時隨時為 {{site.data.keyword.cloudant_short_notm}} 服務保留更小或更大的容量：

![調節器](../images/migrate2.gif)

您可以變更傳輸量的數量限制為每次變更最多 10 個單位（請注意，調節器上的「變更限制」點），而且每小時最多只能變更一次。向下變更的幅度不受限制，但仍然受限於時間限制。
{: tip}

將會依任何給定每小時時間範圍內所選取的最高容量向您收費。您可以擴增資料庫傳輸量以對應季節性需求，然後在淡季再次縮減。您的按月帳單總是可預測的；升級會自動執行；並且您的 SLA 為 [99.95% ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](http://www-03.ibm.com/software/sla/sladb.nsf/sla/bm?OpenDocument){: new_window}。

如果您超過給定秒的讀取、寫入及廣域查詢配額，{{site.data.keyword.cloudant_short_notm}} API 即會回覆 `HTTP 429 要求太多`回應。您的應用程式稍後可能會重試要求；我們的正式程式庫會提供重試指數倒回這類要求的選項。 

## 我擁有哪種類型的 {{site.data.keyword.cloudant_short_notm}} 方案？
{: #which-type-of-ibm-cloudant-plan-do-i-have-}

如果您是使用 {{site.data.keyword.cloudant_short_notm}}，請移至 {{site.data.keyword.cloud_notm}} 儀表板，然後按一下**功能表**圖示 > **資源清單**，來查看您的所有服務實例。 

![Cloud 儀表板](../images/ibmclouddashboard.png)

您也可以往下探查至特定實例，並查看「方案」標籤，以取得相關資訊。已淘汰「共用方案」上的 {{site.data.keyword.cloudant_short_notm}} 實例沒有已強調顯示的方案。「{{site.data.keyword.cloudant_short_notm}} 標準方案」上的實例與下列範例類似： 

![標準儀表板](../images/ibmcloud_instance_standard_plan.png)

您還可以開啟「{{site.data.keyword.cloudant_short_notm}} 儀表板」，然後按一下**帳戶**標籤。「精簡方案」與下列範例類似：

![精簡方案](../images/migrate1.png)

如果您使用的是舊 `cloudant.com` 帳戶，那麼可以登入到「{{site.data.keyword.cloudant_short_notm}} 儀表板」，然後移至「帳戶」標籤。舊式「`cloudant.com` 共用方案」的「用量」標籤具有現行月份的圖形及計費預估值（如下列範例所示）：

![共用方案](../images/cloudantcom_sharedplan_usage.png)

專用叢集上「`cloudant.com` 企業」使用者的「帳戶」標籤中沒有「用量」標籤。它與下列範例類似：

![企業方案](../images/cloudantcom_enterpriseplan_account.png)

如果您的「帳戶」標籤已指出您位於「標準方案」，則不需要再進一步閱讀。您已經位於付費 SLA 支援的 {{site.data.keyword.cloudant_short_notm}} 服務。不需要任何進一步的動作。

## 從 {{site.data.keyword.cloudant_short_notm}} 精簡移轉至 {{site.data.keyword.cloudant_short_notm}} 標準
{: #migrating-from-ibm-cloudant-lite-to-ibm-cloudant-standard}

遵循下列步驟，從免費的「精簡方案」移轉至「標準方案」： 

1.  移至 {{site.data.keyword.cloud_notm}} 儀表板。
2.  移至**功能表**圖示 > **資源清單**，來查看您的所有服務實例。 
3.  選取您要移轉的 {{site.data.keyword.cloudant_short_notm}} 實例。 
4.  選取功能表上的**方案**標籤。 
5.  從定價方案清單中，選取**標準**勾選框。
![精簡](../images/migrate3.png)
6.  按一下**升級**。即會為您保留所有現有資料。

使用「傳輸量」調節器來調整容量，視需要增加或減少容量。
{: tip} 
 
現在，您可以開始進行！

## 將其他項目移轉至 {{site.data.keyword.cloudant_short_notm}} 精簡或標準方案
{: #migrating-everything-else-to-ibm-cloudant-lite-or-standard-plan}

從「共用方案」或「企業方案」移轉至「{{site.data.keyword.cloudant_short_notm}} 精簡方案」或「標準方案」包括下列步驟所述的這些作業。 

您無法直接將「共用方案」實例變更為「精簡方案」或「標準方案」實例。移轉需要您建立新的「精簡方案」或「標準方案」實例，並從「共用方案」實例中抄寫資料。
{: tip}

### 步驟 1：註冊 {{site.data.keyword.cloud_notm}}
{: #step-1-sign-up-for-ibm-cloud}

如果尚未註冊，請[註冊 {{site.data.keyword.cloud_notm}} 帳戶 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://www.ibm.com/cloud/){: new_window}。 

### 步驟 2：建立 {{site.data.keyword.cloudant_short_notm}} 實例
{: #step-2-create-an-ibm-cloudant-instance}

在您登入 {{site.data.keyword.cloud_notm}} 帳戶之後，請新增 {{site.data.keyword.cloudant_short_notm}} 服務。按一下儀表板上的`建立資源`按鈕，然後按一下`資料庫`及 `Cloudant`。如需相關資訊，請參閱[如何在 {{site.data.keyword.cloud_notm}} 上建立 {{site.data.keyword.cloudant_short_notm}} 實例](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud#creating-an-ibm-cloudant-instance-on-ibm-cloud)。 

![新增 {{site.data.keyword.cloudant_short_notm}} 實例](../tutorials/images/img0003.png)

### 步驟 3：找出您的應用程式是否備妥可供 {{site.data.keyword.cloudant_short_notm}} 使用
{: #step-3-find-out-whether-your-application-is-ready-for-ibm-cloudant}

如果您是從「{{site.data.keyword.cloudant_short_notm}} 企業」服務或「{{site.data.keyword.cloudant_short_notm}} 共用方案」移動，則必須重新造訪您應用程式的 {{site.data.keyword.cloudant_short_notm}} 用量，以確定它已備妥可處理「標準方案」的容量限制。如需相關資訊，請參閱 [{{site.data.keyword.cloudant_short_notm}} API 的運作方式](/docs/services/Cloudant?topic=cloudant-ibm-cloud-public#provisioned-throughput-capacity)。最重要的是，您必須確定應用程式在您超出佈建的傳輸量時可以處理 `429：要求太多` HTTP 回應。 

針對超出方案容量的偶而資料流量激增，可以接受重試取得 `429` 回應的要求。如果您的應用程式資料流量定期產生 `429` 回應，您很有可能需要升級至更大的方案。

此外，值得注意的是，{{site.data.keyword.cloudant_short_notm}} 上的個別文件大小上限為 1 MB，如果超出限制，您會收到 `413：要求實體太大`訊息。如需相關資訊，請參閱[要求及文件大小限制](/docs/services/Cloudant?topic=cloudant-ibm-cloud-public#request-and-document-size-limits)。 

### 步驟 4：將資料從舊服務移轉至新服務 
{: #step-4-migrate-data-from-the-old-service-to-the-new-service}

設定從現有服務持續抄寫至 {{site.data.keyword.cloudant_short_notm}} 帳戶。如需相關資訊，請參閱[抄寫手冊](/docs/services/Cloudant?topic=cloudant-replication-api#replication-api)及 [API 文件](/docs/services/Cloudant?topic=cloudant-ibm-cloudant-basics#ibm-cloudant-basics)如需如何設定及監視抄寫作業。

或者，您也可以參閱 [`couchreplicate`](https://www.npmjs.com/package/couchreplicate) 工具，這個指令行公用程式可協助您協調將資料從某個 {{site.data.keyword.cloudant_short_notm}} 帳戶傳送至另一個帳戶。它在來源與目標帳戶之間設定多個抄寫工作，以確保一次只會進行這麼多抄寫工作。如果您需要移轉數百個資料庫，則 `couchreplicate` 可以協助協調抄寫工作。

![`couchreplicate`](https://raw.githubusercontent.com/glynnbird/couchreplicate/HEAD/img/couchreplicate.gif)

驗證所有資料都抄寫至新的服務，並建置索引。

### 步驟 5：測試
{: #step-5-testing}

在您的應用程式上進行負載及功能測試，以確保在移轉至正式作業之前沒有任何問題。

### 步驟 6：準備移至新實例？
{: #step-6-ready-to-move-to-the-new-instance-}

當您準備好移至新實例時，請更新您的應用程式，針對 {{site.data.keyword.cloudant_short_notm}} 實例使用新的帳戶 URL 及認證。如需相關資訊，請參閱[佈建指導教學](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud#creating-an-ibm-cloudant-instance-on-ibm-cloud)如需如何取得 {{site.data.keyword.cloudant_short_notm}} 實例的服務認證。

### 步驟 7：關閉舊服務
{: #step-7-turn-off-the-old-service}

 您的應用程式完全移轉至「{{site.data.keyword.cloudant_short_notm}} 精簡」或「標準」實例時，即可從 {{site.data.keyword.cloud_notm}} 主控台刪除舊的「{{site.data.keyword.cloudant_short_notm}} 共用方案」實例，以確保不再向您收取服務費用。

## FAQ - 常見問題
{: #faq-frequently-asked-questions}

{{site.data.keyword.cloudant_short_notm}} 組織會發佈常見問題 (FAQ)，協助 {{site.data.keyword.IBM_notm}} 客戶移轉至 {{site.data.keyword.cloud_notm}} 上的「{{site.data.keyword.cloudant_short_notm}} 精簡方案」或「標準方案」實例。

## 我可以在執行任何動作之前先備份我的資料嗎？
{: #can-i-back-up-my-data-before-doing-anything-}

{{site.data.keyword.cloudant_short_notm}} 建議您使用 [couchbackup](/docs/services/Cloudant?topic=cloudant-ibm-cloudant-backup-and-recovery#ibm-cloudant-backup-and-recovery) 公用程式將資料匯出至磁碟。[{{site.data.keyword.cloud_notm}} Object Storage ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://www.ibm.com/cloud/object-storage){: new_window} 是一種低價的可調整解決方案，用於儲存匯出的檔案。 

## 我可以保留 `username.cloudant.com` 網域，並將它重新導向至 {{site.data.keyword.cloudant_short_notm}} 上的新服務嗎？
{: #can-i-keep-my-username-cloudant-com-domain-and-redirect-it-to-the-new-service-on-ibm-cloudant-}

不可以，無法保留您的網域。您必須計劃更新應用程式，以使用新的帳戶 URL 以及針對 {{site.data.keyword.cloudant_short_notm}} 實例產生的認證。

## 如果我有問題，可以聯絡誰？
{: #who-do-i-contact-if-i-have-questions-}

如果您有任何有關移轉的問題，請與 [{{site.data.keyword.cloudant_short_notm}} 支援中心](mailto:support@cloudant.com)聯絡，或在 {{site.data.keyword.cloudant_short_notm}} 儀表板中開立問題單。{{site.data.keyword.cloudant_short_notm}} 支援中心很樂意提供更多詳細資料。
