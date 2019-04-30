---

copyright:
  years: 2017, 2019
lastupdated: "2019-03-15"

keywords: create database, create api key for replication, grant access permission, set up replications, test replication, configure application, active-active configuration, active-passive configuration, fail over, recovering from fail over

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

# 配置 {{site.data.keyword.cloudant_short_notm}} 進行跨地區災難回復
{: #configuring-ibm-cloudant-for-cross-region-disaster-recovery}

[{{site.data.keyword.cloudant_short_notm}} 災難回復手冊](/docs/services/Cloudant?topic=cloudant-disaster-recovery-and-backup#disaster-recovery-and-backup)說明啟用災難回復的方式，就是使用 {{site.data.keyword.cloudantfull}} 抄寫來建立跨地區的備援。

您可以跨資料中心使用「主動-主動」或「主動-被動」拓蹼，來配置 {{site.data.keyword.cloudant_short_notm}} 中的抄寫。

下圖顯示使用兩個 {{site.data.keyword.cloudant_short_notm}} 帳戶（每一個地區一個帳戶）的一般配置：

![主動-主動架構範例](../images/active-active.png)

記住下列情況會很有用：

* 在每一個資料中心內，{{site.data.keyword.cloudant_short_notm}} 已跨三部伺服器儲存三份資料來提供高可用性。
* 抄寫發生於資料庫而非帳戶層次，因此必須明確配置。
* {{site.data.keyword.cloudant_short_notm}} 不會提供任何「服務水準合約 (SLA)」或關於抄寫延遲的確定性。
* {{site.data.keyword.cloudant_short_notm}} 不會監視個別抄寫。建議使用您自己的策略，來偵測失敗的抄寫並重新啟動它們。

## 開始主動-主動部署之前
{: #before-you-begin-an-active-active-deployment}

若為主動-主動部署，必須有管理衝突的策略就位。因此，在考量此架構之前，務必瞭解[抄寫](/docs/services/Cloudant?topic=cloudant-replication-api#replication-api)及[衝突](/docs/services/Cloudant?topic=cloudant-document-versioning-and-mvcc#document-versioning-and-mvcc)的運作方式。
{: note}

如果您需要有關如何建立資料模型來有效處理衝突的協助，請聯絡 [{{site.data.keyword.cloudant_short_notm}} 支援中心 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](mailto:support@cloudant.com){: new_window}。

## 概觀
{: #overview-active-active}

在下列資料中，會建立雙向抄寫。此配置容許兩個資料庫在主動-主動拓蹼中運作。

配置假設您在不同地區有兩個帳戶：

* `myaccount-dc1.cloudant.com`
* `myaccount-dc2.cloudant.com`

這些帳戶就緒後，基本步驟如下：

1. 在帳戶內[建立](#step-1-create-your-databases)一對對等節點資料庫。
2. [設定](#step-2-create-an-api-key-for-your-replications) API 金鑰，以用於這些資料庫之間的抄寫。
3. 授與適當的許可權。
4. 設定抄寫。
5. 測試抄寫如預期般運作。
6. 配置應用程式及基礎架構，以進行資料庫的主動-主動或主動-被動使用。

## 步驟 1：建立資料庫
{: #step-1-create-your-databases}

在每一個帳戶內，[建立](/docs/services/Cloudant?topic=cloudant-databases#create-database)您要在其間抄寫的資料庫。

在此範例中，會建立一個稱為 `mydb` 的資料庫。

在此範例中用於資料庫的名稱並不重要，但使用相同的名稱會比較清楚。

```sh
curl https://myaccount-dc1.cloudant.com/mydb -XPUT -u myaccount-dc1
curl https://myaccount-dc2.cloudant.com/mydb -XPUT -u myaccount-dc2
```
{: codeblock}

## 步驟 2：建立 API 金鑰進行抄寫
{: #step-2-create-an-api-key-for-your-replications}

使用 [API 金鑰](/docs/services/Cloudant?topic=cloudant-authorization#api-keys)進行持續抄寫，是一個好主意。優點是如果您的主要帳戶詳細資料變更，例如，在密碼重設之後，您的抄寫可以繼續保持不變。

API 金鑰不會關聯於單一帳戶。這項特徵表示可以建立單一 API 金鑰，然後為兩個帳戶授與適當的資料庫許可權。

例如，下列指令會要求帳戶 `myaccount-dc1` 的 API 金鑰：

```sh
$ curl -XPOST https://myaccount-dc1.cloudant.com/_api/v2/api_keys -u myaccount-dc1
```
{: codeblock}

成功回應與下列縮短的範例類似：

```json
{
  "password": "YPN...Tfi",
  "ok": true,
  "key": "ble...igl"
}
```
{: codeblock}

請小心記下密碼，因為之後無法擷取密碼。
{: important}

## 步驟 3：授與存取權
{: #step-3-grant-access-permission}

[提供 API 金鑰](/docs/services/Cloudant?topic=cloudant-authorization#modifying-permissions)讀取及寫入至這兩個資料庫的許可權。

如果也想要抄寫索引，請指派管理許可權。

使用「{{site.data.keyword.cloudant_short_notm}} 儀表板」，或者參閱[授權](/docs/services/Cloudant?topic=cloudant-authorization#authorization)資訊，以取得如何使用程式授與許可權的詳細資料。

## 步驟 4：設定抄寫
{: #step-4-set-up-replications}

{{site.data.keyword.cloudant_short_notm}} 中的抄寫一律是單向的：從某個資料庫至另一個資料庫。因此，若要在兩個資料庫之間進行雙向抄寫，需要有兩個抄寫，每一個方向一個。

在每一個帳戶中建立一個抄寫，使用[先前](#step-2-create-an-api-key-for-your-replications)建立的 API 金鑰。

首先，建立從資料庫 `myaccount-dc1.cloudant.com/mydb` 到資料庫 `myaccount-dc2.cloudant.com/mydb` 的抄寫。

```sh
curl -XPOST 'https://myaccount-dc1.cloudant.com/_replicator'
	-u myaccount-dc1
	-H 'Content-type: application/json'
	-d '{ "_id": "mydb-myaccount-dc1-to-myaccount-dc2",
	"source": "https://ble...igl:YPN...Tfi@myaccount-dc1.cloudant.com/mydb",
	"target": "https://ble...igl:YPN...Tfi@myaccount-dc2.cloudant.com/mydb",
	"continuous": true
}'
```
{: codeblock}

接下來，建立從資料庫 `myaccount-dc2.cloudant.com/mydb` 到資料庫 `myaccount-dc1.cloudant.com/mydb` 的抄寫。

```sh
curl -XPOST 'https://myaccount-dc2.cloudant.com/_replicator'
	-u myaccount-dc2
	-H 'Content-type: application/json'
	-d '{ "_id": "mydb-myaccount-dc2-to-myaccount-dc1",
	"source": "https://ble...igl:YPN...Tfi@myaccount-dc2.cloudant.com/mydb",
	"target": "https://ble...igl:YPN...Tfi@myaccount-dc1.cloudant.com/mydb",
	"continuous": true
}'
```
{: codeblock}

如果此步驟因為 `_replicator` 資料庫不存在而失敗，請建立該資料庫。
{: note}

## 步驟 5：測試抄寫
{: #step-5-test-your-replication}

您可以透過建立、修改及刪除任一個資料庫中的文件，來測試抄寫處理程序。

每一次在某個資料庫中進行變更之後，請確認您也看到此變更反映在另一個資料庫中。

## 步驟 6：配置應用程式
{: #step-6-configure-your-application}

此時，資料庫已設定彼此保持同步。

接下來要決定以[主動-主動](#active-active)還是[主動-被動](#active-passive)方式使用資料庫。

### 主動-主動
{: #active-active}

在主動-主動配置中，不同的應用程式實例可以寫入至不同的資料庫中。

例如，應用程式 'A' 可能寫入至資料庫 `myaccount-dc1.cloudant.com/mydb` 中，而應用程式 'B' 可能寫入至資料庫 `myaccount-dc2.cloudant.com/mydb` 中。

此配置提供幾個優點：

- 負載可以分散至數個帳戶。
- 應用程式可以配置為存取延遲較低的帳戶（不一定是地理上最接近的帳戶）。

應用程式可以設定為與「最接近」的 {{site.data.keyword.cloudant_short_notm}} 帳戶通訊。
若為 DC1 中管理的應用程式，適合將其 {{site.data.keyword.cloudant_short_notm}}  URL 設為 `"https://myaccount-dc1.cloudant.com/mydb"`。同樣地，若為 DC2 中管理的應用程式，請將其 {{site.data.keyword.cloudant_short_notm}} URL 設為 `"https://myaccount-dc2.cloudant.com/mydb"`。

### 主動-被動
{: #active-passive}

在主動-被動配置中，應用程式的所有實例都會配置為使用主要資料庫。不過，應用程式可以失效接手到另一個備份資料庫（如果情況必須如此的話）。失效接手可在應用程式邏輯本身內實作、使用負載平衡器實作，或使用某些其他方法來實作。

是否需要失效接手的一項簡單測試，是使用主要資料庫端點作為「活動訊號」。例如，傳送至主要資料庫端點的簡單 `GET` 要求一般會傳回[有關資料庫的詳細資料](/docs/services/Cloudant?topic=cloudant-databases#getting-database-details)。如果未收到任何回應，則可能指出需要失效接手。

### 其他配置
{: #other-configurations}

您可以針對配置考量其他混合式方法。

例如，在 'Write-Primary, Read-Replica' 配置中，所有寫入會集中到一個資料庫，但讀取負載會分散至各抄本。

## 步驟 7：後續步驟
{: #step-7-next-steps}

* 考量監視資料庫之間的[抄寫](/docs/services/Cloudant?topic=cloudant-advanced-replication#advanced-replication)。使用資料來判斷您的配置是否可以進一步最佳化。
*	考量如何部署及更新您的設計文件及索引。您可以更有效率地找到它，以自動執行這些作業。

## 在 {{site.data.keyword.cloudant_short_notm}} 地區之間失效接手
{: #failing-over-between-ibm-cloudant-regions}

一般而言，在地區或資料中心之間管理失效接手的過程，會在應用程式堆疊內的較高位置進行處理，例如，透過配置應用程式伺服器失效接手變更，或平衡負載。

{{site.data.keyword.cloudant_short_notm}} 並未提供一種機能，讓您明確地管理任何失效接手，或在各地區之間重新遞送要求。此限制部分基於技術原因，部分因為可能發生的情況往往是應用程式特定的。例如，您可能想要強制執行失效接手以回應自訂效能度量。

不過，如果您決定確實需要管理失效接手的能力，則部分可能選項包括：

* 將您自己的 [HTTP Proxy 放在 {{site.data.keyword.cloudant_short_notm}} ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://github.com/greenmangaming/cloudant-nginx){: new_window} 前面。將您的應用程式配置為與 Proxy 而非 {{site.data.keyword.cloudant_short_notm}} 實例交談。此配置表示您可以處理變更應用程式所使用之 {{site.data.keyword.cloudant_short_notm}} 實例的作業，方法為修改 Proxy 配置，而非修改應用程式設定。根據使用者定義的性能檢查，許多 Proxy 具備平衡負載的功能。
* 使用廣域負載平衡器（例如 [{{site.data.keyword.cloud}} Internet Services ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](/docs/infrastructure/cis/glb.html#global-load-balancer-glb-concepts){: new_window} 或 [Dyn Traffic Director ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](http://dyn.com/traffic-director/){: new_window}），來遞送至 {{site.data.keyword.cloudant_short_notm}}。此選項需要 `CNAME` 定義，根據性能檢查或延遲規則來遞送至不同的 {{site.data.keyword.cloudant_short_notm}} 帳戶。


## 從失效接手中回復
{: #recovering-from-fail-over}

如果單一 {{site.data.keyword.cloudant_short_notm}} 實例無法連接，請避免在該實例一可以連接時即將資料流量重新導向回到其中。原因是密集作業（例如，同步化來自任何對等節點的資料庫狀態，以及確保索引是最新的）需要一些時間。

具有監視這些作業的機制很有幫助，因為此機制可協助判斷資料庫何時處於適當的狀態，以服務您的正式作業資料流量。

作為指引，要套用的一般檢查清單包括：

* [抄寫](#replications)
* [索引](#indexes)

如果實作要求重新遞送或根據性能測試來失效接手，建議您納入相對應的檢查，以避免倉促地重新遞送回到仍在回復的服務實例。
{: note}

### 抄寫
{: #replications}

* 有任何抄寫處於錯誤狀態嗎？
* 有任何抄寫需要重新啟動嗎？
* 多少擱置變更仍在等待抄寫至資料庫？

有[監視抄寫狀態](/docs/services/Cloudant?topic=cloudant-advanced-replication#replication-status)的相關資訊可供使用。

如果正在連續變更資料庫，則抄寫狀態不可能為 0。您必須決定可接受的狀態臨界值，或代表錯誤狀態的臨界值。
{: note}

### 索引
{: #indexes}

* 索引是否充分保持最新？請使用[作用中作業](/docs/services/Cloudant?topic=cloudant-active-tasks#active-tasks)端點來驗證此情況。
* 測試「索引就緒」的層次，方法為傳送查詢至索引，並判斷是否在可接受的時間內傳回索引。
