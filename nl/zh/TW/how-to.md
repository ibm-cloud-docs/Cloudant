---

copyright:
  years: 2015, 2019
lastupdated: "2019-06-12"

keywords: tutorials, recovery and backup, guides, links to documentation

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

<!-- Acrolinx: 2018-11-08 -->

# 關於
{: #about}

指導教學、回復及備份指示，以及手冊提供您在 {{site.data.keyword.cloudantfull}} 使用之基本及進階作業的相關資訊。  

## 指導教學
{: #tutorials}

指導教學 | 說明
---------|-------------
[入門指導教學](/docs/services/Cloudant?topic=cloudant-getting-started#getting-started){: new_window} | 此指導教學說明如何使用 Python 來建立 {{site.data.keyword.cloudant_short_notm}} 資料庫，並在該資料庫中移入一個簡單的資料集合。
[建立 {{site.data.keyword.cloudant_short_notm}} 實例](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud#creating-an-ibm-cloudant-instance-on-ibm-cloud){: new_window} | 此指導教學說明如何使用 {{site.data.keyword.cloud_notm}} 儀表板來建立 {{site.data.keyword.cloudant_short_notm}} 服務實例，以及可在何處尋找您的服務認證。
[使用 {{site.data.keyword.cloud_notm}} CLI 來建立 {{site.data.keyword.cloudant_short_notm}} 實例](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud-by-using-the-ibm-cloud-cli#creating-an-ibm-cloudant-instance-on-ibm-cloud-by-using-the-ibm-cloud-cli){: new_window} | 此指導教學說明如何使用 {{site.data.keyword.cloud_notm}} CLI，在 {{site.data.keyword.cloud_notm}} 上建立 {{site.data.keyword.cloudant_short_notm}} 服務實例。
[建立及運用 {{site.data.keyword.cloudant_short_notm}} 專用硬體方案實例](/docs/services/Cloudant?topic=cloudant-creating-and-leveraging-an-ibm-cloudant-dedicated-hardware-plan-instance-on-ibm-cloud#creating-and-leveraging-an-ibm-cloudant-dedicated-hardware-plan-instance-on-ibm-cloud){: new_window} | 此指導教學說明如何使用 {{site.data.keyword.cloud_notm}} 型錄或 {{site.data.keyword.cloud_notm}} CLI，來建立「{{site.data.keyword.cloudant_short_notm}} 專用硬體方案」實例，然後如何佈建一個以上要在其上執行的「標準方案」實例。
[建立簡單的 {{site.data.keyword.cloudant_short_notm}} 資料庫並將資料移入其中](/docs/services/Cloudant?topic=cloudant-creating-and-populating-a-simple-ibm-cloudant-database-on-ibm-cloud#creating-and-populating-a-simple-ibm-cloudant-database-on-ibm-cloud){: new_window} | 此指導教學說明如何使用 Python 程式設計語言，在 {{site.data.keyword.cloud_notm}} 服務實例中建立 {{site.data.keyword.cloudant_short_notm}} 資料庫，並且將簡單資料集合移入資料庫中。
[建立 {{site.data.keyword.cloudant_short_notm}} 查詢](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-query#creating-an-ibm-cloudant-query){: new_window}| 此指導教學說明如何建立資料庫、將文件移入其中、建立索引，以及使用索引來查詢資料庫。
[建立備份](/docs/services/Cloudant?topic=cloudant-creating-a-backup#creating-a-backup){: new_window} | 此指導教學說明如何使用 CouchBackup 指令行公用程式，來備份及還原 CouchDB 或 {{site.data.keyword.cloudant_short_notm}} 實例。
[建立簡單的 {{site.data.keyword.cloud_notm}} 應用程式](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database){: new_window} | 此指導教學說明如何建立一個 {{site.data.keyword.cloud_notm}} 應用程式，使用 Python 程式設計語言來存取在 {{site.data.keyword.cloud_notm}} 服務實例中管理的 {{site.data.keyword.cloudantfull}} 資料庫。
[建立簡單的 {{site.data.keyword.cloud_notm}} 應用程式以存取 {{site.data.keyword.cloudant_short_notm}} 資料庫：必要條件](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-prerequisites#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-prerequisites){: new_window} | 此指導教學說明用於建立 {{site.data.keyword.cloud_notm}} 應用程式的必要條件。
[建立簡單的 {{site.data.keyword.cloud_notm}} 應用程式以存取 {{site.data.keyword.cloudant_short_notm}} 資料庫：應用程式環境](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment){: new_window} | 此指導教學說明如何設定在建立 {{site.data.keyword.cloud_notm}} 應用程式時必須要有的應用程式環境。
[建立簡單的 {{site.data.keyword.cloud_notm}} 應用程式以存取 {{site.data.keyword.cloudant_short_notm}} 資料庫：程式碼](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-code#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-code){: new_window} | 此指導教學說明 {{site.data.keyword.cloud_notm}} 應用程式的程式碼。
[建立簡單的 {{site.data.keyword.cloud_notm}} 應用程式以存取 {{site.data.keyword.cloudant_short_notm}} 資料庫：上傳應用程式](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-uploading-the-application#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-uploading-the-application){: new_window} | 此指導教學說明如何上傳 {{site.data.keyword.cloud_notm}} 應用程式。
[建立簡單的 {{site.data.keyword.cloud_notm}} 應用程式以存取 {{site.data.keyword.cloudant_short_notm}} 資料庫：維護及疑難排解](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-maintaining-and-troubleshooting#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-maintaining-and-troubleshooting){: new_window} | 此指導教學說明如何維護在 {{site.data.keyword.cloud_notm}} 服務實例中管理的 {{site.data.keyword.cloud_notm}} 應用程式。


## 回復及備份
{: #recovery-and-backup}

手冊 | 說明
------|------------
[災難回復及備份](/docs/services/Cloudant?topic=cloudant-disaster-recovery-and-backup#disaster-recovery-and-backup){: new_window} | 概述 {{site.data.keyword.cloudant_short_notm}} 所提供的自動功能及支援的工具。
[配置 {{site.data.keyword.cloudant_short_notm}} 進行跨地區災難回復](/docs/services/Cloudant?topic=cloudant-configuring-ibm-cloudant-for-cross-region-disaster-recovery#configuring-ibm-cloudant-for-cross-region-disaster-recovery){: new_window} | 此手冊說明啟用災難回復的方式，就是使用 {{site.data.keyword.cloudant_short_notm}} 進行 {{site.data.keyword.cloud_notm}} 抄寫來建立跨地區的備援。
[{{site.data.keyword.cloudant_short_notm}} 備份及回復](/docs/services/Cloudant?topic=cloudant-ibm-cloudant-backup-and-recovery#ibm-cloudant-backup-and-recovery){: new_window} | 此手冊說明如何使用 CouchBackup 備份及回復工具。


## 手冊
{: #guides}

手冊 | 說明
------|------------
[授權的 curl：acurl](/docs/services/Cloudant?topic=cloudant-authorized-curl-acurl-#authorized-curl-acurl-){: new_window} | 此手冊用來設定 `acurl`，讓您不再需要輸入使用者名稱及密碼。
[CAP 定理](/docs/services/Cloudant?topic=cloudant-cap-theorem#cap-theorem){: new_window} | 此手冊說明「最終一致」模型。
[衝突](/docs/services/Cloudant?topic=cloudant-conflicts#conflicts){: new_window} | 此手冊說明如何尋找及解決衝突。
[CouchApps](/docs/services/Cloudant?topic=cloudant-couchapps#couchapps){: new_window} | 此手冊說明構成 CouchApp 的要項為何。
[資料庫分割](/docs/services/Cloudant?topic=cloudant-database-partitioning#database-partitioning) | 此手冊說明分割資料庫及如何使用它們。
[設計文件管理](/docs/services/Cloudant?topic=cloudant-design-document-management#design-document-management){: new_window} | 此手冊說明何謂設計文件，以及如何在 {{site.data.keyword.cloudant_short_notm}} 中使用設計文件。
[文件版本化和 MVCC](/docs/services/Cloudant?topic=cloudant-document-versioning-and-mvcc#document-versioning-and-mvcc){: new_window} | 此手冊說明多版本並行控制 (MVCC)，以及它如何使用 {{site.data.keyword.cloudant_short_notm}} 資料庫，來確定資料庫叢集中的所有節點只包含最新版本的文件。
[對資料建模以調整大小的五項建議](/docs/services/Cloudant?topic=cloudant-five-tips-for-modeling-your-data-to-scale#five-tips-for-modeling-your-data-to-scale){: new_window} |本手冊更細緻地討論了如何對應用程式資料建模，以使應用程式能夠大規模高效運作。

[在 {{site.data.keyword.cloudant_short_notm}} 中將相關文件分組在一起](/docs/services/Cloudant?topic=cloudant-grouping-related-documents-together-in-ibm-cloudant#grouping-related-documents-together-in-ibm-cloudant){: new_window} | 此手冊概述在使用許多其他網域適用的概念，來建置電子商務系統時所涉及的一些因素，而此系統會善用 {{site.data.keyword.cloudant_short_notm}} 的力量。
[{{site.data.keyword.cloudant_short_notm}}如何使用「{{site.data.keyword.cloud_notm}} 資源群組」？](/docs/services/Cloudant?topic=cloudant-how-does-ibm-cloudant-work-with-ibm-cloud-resource-groups-#how-does-ibm-cloudant-work-with-ibm-cloud-resource-groups-){: new_window} | 此手冊涵蓋 {{site.data.keyword.cloudant_short_notm}} 支援中心收到有關此轉移的常見問題。
[如何在 {{site.data.keyword.cloudant_short_notm}} 中儲存資料？](/docs/services/Cloudant?topic=cloudant-how-is-data-stored-in-ibm-cloudant-#how-is-data-stored-in-ibm-cloudant-){: new_window} | 此手冊說明 Shard，以及其如何在 {{site.data.keyword.cloudant_short_notm}} 中運作。
[IBM Cloud Identity and Access Management (IAM)](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-){: new_window} | 此手冊說明 {{site.data.keyword.cloudant_short_notm}} 與 {{site.data.keyword.cloud_notm}} Identity and Access Management 的整合。
[JSON](/docs/services/Cloudant?topic=cloudant-json#json){: new_window} | 此手冊說明 {{site.data.keyword.cloudant_short_notm}} 如何使用「JavaScript 物件表示法 (JSON)」，來格式化資料及回應的內容和結構。
[管理作業](/docs/services/Cloudant?topic=cloudant-managing-tasks#managing-tasks){: new_window} | 此手冊說明無論您的作業進行中還是完成，您如何管理這些作業。
[移轉至 {{site.data.keyword.cloudant_short_notm}}](/docs/services/Cloudant?topic=cloudant-migrating-to-ibm-cloudant-on-ibm-cloud#migrating-to-ibm-cloudant-on-ibm-cloud){: new_window} | 此手冊說明如何在 {{site.data.keyword.cloud_notm}} 上移轉至「{{site.data.keyword.cloudant_short_notm}} 精簡方案」或「標準方案」實例。
[抄寫手冊](/docs/services/Cloudant?topic=cloudant-replication-guide#replication-guide){: new_window} | 此手冊介紹 {{site.data.keyword.cloudant_short_notm}} 的抄寫功能、討論一般使用案例，以及顯示如何順利抄寫應用程式。
[抄寫增量備份](/docs/services/Cloudant?topic=cloudant-replication-incrementals#replication-incrementals){: new_window} | 此手冊說明如何建立及還原增量備份。

 

