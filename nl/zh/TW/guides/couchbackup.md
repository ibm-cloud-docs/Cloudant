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

<!-- Acrolinx: 2017-05-02 -->

# 使用 CouchBackup 備份資料

{{site.data.keyword.cloudant}} 的分散式本質提供資料備份的固有形式。CouchBackup 是一種指令行工具，提供更強大且彈性的方式，供您備份資料。
{:shortdesc}

## 概觀

{{site.data.keyword.cloudant_short_notm}} 的分散式優勢是透過使用叢集來達成。在叢集中，資料庫內的資料會儲存在多個副本中。這些副本會分散在至少三部不同的實體伺服器中。使用叢集作為資料儲存空間，提供 {{site.data.keyword.cloudant_short_notm}} 固有的「高可用性 (HA)」及「災難回復 (DR)」特徵。使用叢集可協助 {{site.data.keyword.cloudant_short_notm}} 容忍叢集內流失節點，但不會流失資料。

不過，即使具有這些 HA 及 DR 特徵，也會有其他使用案例讓您可能想要加強資料備份。

<div id="activepassive"></div>

### 資料中心運行中斷及災難回復

當 {{site.data.keyword.cloudant_short_notm}} 叢集不是完全可用時，叢集之間的[連續抄寫](../api/replication.html#continuous-replication)是解決此問題的良好方案。連續抄寫是「主動-被動」模型。模型的「主動」部分是連續抄寫。模型的「被動」部分會確認抄本一般不是用來回應來自應用程式的要求。相反地，抄本主要用作原始資料庫的複本。必要的話，可從複本存取資料。或者，您也可以在其他位置使用[抄寫](../api/replication.html)來還原複本中的資料。

>	**附註：**從複本進行抄寫來還原大型資料庫可能需要很長的時間。

### 高可用性、自動失效接手及地理負載平衡

[「主動-被動」](#activepassive)方法的替代方案，是您在其中配置兩個資料中心來使用「主動-主動」模型。

在此模型中，對叢集 A 中的資料庫所做的任何變更都會抄寫至叢集 B 中的資料庫。同樣地，對叢集 B 中的資料庫所做的任何變更都會抄寫至叢集 A 中的資料庫。

>	**附註：**您可以使用 {{site.data.keyword.cloudant_short_notm}} 儀表板來設定此模型。它不需要透過 {{site.data.keyword.cloudant_short_notm}} 支援執行。



此模型就緒後，您可以設定資料庫應用程式，以在符合某些可用性準則時，「失效接手」至其中一個叢集。您可將可用性準則定義為應用程式設計的一部分。

您也可以在應用程式設計中併入地理「負載平衡」。例如，當應用程式存取儲存在「附近」地理區域的叢集內的資料時，用於某個地理區域的用戶端應用程式一般將預期更好的效能。設計用戶端應用程式來識別「最接近」的叢集，並連接至該叢集，以進行資料庫查詢，將可協助提升應用程式效能。

[這裡 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](http://www.ibm.com/developerworks/cloud/library/cl-multi-region-bluemix-apps-with-cloudant-and-dyn-trs/index.html){:new_window} 提供一個指導教學，說明如何設定多重區域應用程式環境。

### 意外或惡意的資料修改

{{site.data.keyword.cloudant_short_notm}} 不會提供為資料庫建立 Snapshot 的機制。如果您需要此類型功能（例如協助文件層次回復至先前的已知狀況），您可以透過下列兩種方式之一達到相同的效果：

1.	使用抄寫。抄寫此資料庫來執行此動作。確定您已記錄最終順序 ID。根據您決定的排程，將此資料庫抄寫至新的資料庫。從前次記錄的順序 ID 啟動抄寫。保留抄寫的順序 ID，您可以產生累積更新機制的效果。結果將類似於從「每日」Snapshot 建立一般的「每週」Snapshot。此方法的限制為它也會抄寫已刪除的或「圖碑」文件修訂，而且也有尚未解決的衝突。

2.	將資料庫內容傾出至檔案。有各種工具存在，可以用來將資料庫內容傾出至檔案。產生的傾出檔可以儲存在較便宜的區塊導向裝置或服務上。這類方法的限制為它一般只會傾出現行文件修訂。此限制表示不包括尚未解決的衝突。

建立資料庫傾出是啟用各種備份解決方案的有效方式。因此，剩餘的討論著重在這個方法上。

<!--
https://developer.ibm.com/clouddataservices/2016/03/22/simple-couchdb-and-cloudant-backup/

A useful approach is to have couchbackup's snapshots placed on the {{site.data.keyword.cloud}} Object Storage service, as described here:

https://developer.ibm.com/recipes/tutorials/object-storage-cloudant-backup/
-->
