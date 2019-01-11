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

<!-- Acrolinx: 2018-05-07 -->

# {{site.data.keyword.cloudant_short_notm}} 基本觀念

如果這是您第一次閱讀本資訊，請在進一步瞭解之前，先瀏覽本節。
{:shortdesc}

[用戶端程式庫](../libraries/index.html#-client-libraries)、[API 參考資料](../api/index.html#-api-reference)及[手冊](../guides/acurl.html#authorized-curl-acurl-)上的各節，都假設您已知 {{site.data.keyword.cloudantfull}} 的一些相關基本概念。

## 連接至 {{site.data.keyword.cloudant_short_notm}}

若要存取 {{site.data.keyword.cloudant_short_notm}}，您必須具有 [{{site.data.keyword.cloudant_short_notm}} 帳戶](../api/account.html)或 [{{site.data.keyword.cloud}} 帳戶](../offerings/bluemix.html)。

## HTTP API

所有對 {{site.data.keyword.cloudant_short_notm}} 的要求都會透過 Web 進行。
這表示任何可與 Web 對話的系統都可以與 {{site.data.keyword.cloudant_short_notm}} 對話。
{{site.data.keyword.cloudant_short_notm}} 的所有特定語言檔案庫都只是封套，提供一些便利性和語言細節，幫助您使用簡單的 API。
許多使用者選擇利用原始 HTTP 程式庫來使用 {{site.data.keyword.cloudant_short_notm}}。

[API 參考資料的 HTTP 主題](../api/http.html)中提供有關 {{site.data.keyword.cloudant_short_notm}} 如何使用 HTTP 的特定詳細資料。

{{site.data.keyword.cloudant_short_notm}} 支援下列 HTTP 要求方法：

-   `GET`

    要求指定的項目。如同一般 HTTP 要求，URL 的格式定義傳回的內容。使用 {{site.data.keyword.cloudant_short_notm}}，這可以包括靜態項目、資料庫文件，以及配置和統計資訊。
    在大部分情況下，傳回的資訊採用 JSON 文件的格式。

-   `HEAD`

    `HEAD` 方法用來取得 `GET` 要求的 HTTP 標頭，不含回應內文。

-   `POST`

    上傳資料。在 {{site.data.keyword.cloudant_short_notm}} 的 API 內，`POST` 方法用來設定值、上傳文件、設定文件值，以及啟動部分管理指令。

-   `PUT`

    用來「儲存」特定資源。在 {{site.data.keyword.cloudant_short_notm}} 的 API 中，`PUT` 用來建立新的物件，包括資料庫、文件、視圖，以及設計文件。

-   `DELETE`

    刪除指定的資源，包括文件、視圖，以及設計文件。

-   `COPY`

    可用來複製文件及物件的特殊方法。

如果用戶端（例如某些 Web 瀏覽器）不支援使用這些 HTTP 方法，可改用 `POST`，並將 `X-HTTP-Method-Override` 要求標頭設為實際 HTTP 方法。

### 「不容許的方法」錯誤

如果使用不受支援的 HTTP 要求類型與不支援指定類型的 URL 搭配，則會傳回 [405](../api/http.html#405) 錯誤，列出支援的 HTTP 方法，如下列範例所示。

_回應不受支援的要求的範例錯誤訊息：_

```json
{
    "error":"method_not_allowed",
    "reason":"Only GET,HEAD allowed"
}
```
{:codeblock}

## JSON
{: #json}

{{site.data.keyword.cloudant_short_notm}} 使用 JSON（JavaScript 物件表示法）編碼來儲存文件，因此任何編碼成 JSON 的內容都可以儲存為文件。
包含媒體（例如影像、視訊及音訊）的檔案稱為 BLOB（二進位大型物件），而且可以儲存為與文件相關聯的附件。

您可以在 [JSON 手冊](../guides/json.html)中找到 JSON 的相關資訊。

<div id="distributed"></div>

## 分散式系統

{{site.data.keyword.cloudant_short_notm}} 的 API 可讓您與眾多機器（稱為叢集）的協同作業互動。
叢集中的機器必須位於相同的資料中心，但可在該資料中心的不同 'Pod' 內。使用不同的 Pod 可協助改善 {{site.data.keyword.cloudant_short_notm}} 的「高可用性」特徵。

形成叢集的優點是，當您需要更多的運算能力時，只需增加更多的機器即可。比起擴充或加強現有單一機器，此舉通常更具成本效益和容錯能力。

如需 {{site.data.keyword.cloudant_short_notm}} 及分散式系統概念的相關資訊，請參閱 [CAP 定理](../guides/cap_theorem.html)手冊。

## 抄寫

[抄寫](../api/replication.html)是 {{site.data.keyword.cloudant_short_notm}}、[CouchDB ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](http://couchdb.apache.org/){:new_window}、[PouchDB ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](http://pouchdb.com/){:new_window}，以及其他分散式資料庫所遵循的程序。
抄寫會同步處理兩個資料庫的狀態，使其內容相同。

您可以連續抄寫。這表示每次來源資料庫變更時目標資料庫也會隨之更新。連續抄寫可以用於備份資料、跨多個資料庫聚集資料，或共用資料。

不過，連續抄寫表示會連續測試任何來源資料庫變更。此測試需要連續內部呼叫，這可能會影響效能或使用資料庫的成本。

>   **附註**：連續抄寫可能導致大量的內部呼叫。
    這可能會影響 {{site.data.keyword.cloudant_short_notm}} 系統的多方承租戶使用者的成本。
    依預設，會停用連續抄寫。
