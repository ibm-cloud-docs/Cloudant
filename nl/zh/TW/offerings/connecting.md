---

copyright:
  years: 2019
lastupdated: "2019-03-18"

keywords: endpoints, service credentials, authentication, ibm cloudant dashboard, curl, client libraries

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

<!-- Acrolinx: 2018-07-02 -->

# 連接
{: #connecting}

{{site.data.keyword.cloudantfull}} 是透過 HTTP API 進行存取。本文件說明您可以用來連接至 {{site.data.keyword.cloudant_short_notm}} 的不同部分：
- 端點
- 服務認證
- 鑑別
- 存取 {{site.data.keyword.cloudant_short_notm}} 儀表板
- 以程式設計方式透過 [curl ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://curl.haxx.se/){: new_window} 或用戶端程式庫存取 {{site.data.keyword.cloudant_short_notm}}
{: shortdesc}

## 端點
{: #endpoints}

{{site.data.keyword.cloudant_short_notm}} 是透過 HTTP API 端點進行存取。實例的端點會顯示在針對實例所產生之「服務認證」的 URL 欄位中，也會顯示在「{{site.data.keyword.cloudant_short_notm}} 儀表板」的**帳戶** > **設定** 標籤中。

所有 {{site.data.keyword.cloudant_short_notm}} HTTP 端點必須透過 TLS 進行存取，因此會加上 `https://` 作為字首。

公眾客戶端的外部端點為：

`https://USERNAME.cloudant.com`

2019 年 1 月 1 日之後佈建的所有實例都會包括 appdomain.cloud 網域端點。公眾客戶端的外部端點為：

`https://USERNAME.cloudantnosqldb.appdomain.cloud`

內部端點會新增至「專用硬體」環境上部署的所有實例，而這些環境是在 2019 年 1 月 1 日之後於歐盟管理的環境內佈建的。{{site.data.keyword.cloud_notm}} 內部網路端點為：

`https://USERNAME.private.cloudantnosqldb.appdomain.cloud`

其中 USERNAME 是 URL 中服務實例使用者的服務名稱。使用 {{site.data.keyword.cloudant_short_notm}} 舊式鑑別時，此欄位也會充當管理使用者名稱。範例 USERNAME 為 de810d0e-763f-46a6-ae88-50823dc85581-bluemix，而產生的範例外部端點將為 de810d0e-763f-46a6-ae88-50823dc85581-bluemix.cloudantnosqldb.appdomain.cloud。 

## 服務認證
{: #service-credentials}

若要透過「{{site.data.keyword.cloud_notm}} 儀表板」為 {{site.data.keyword.cloudant_short_notm}} 產生服務認證，請參閱[在 {{site.data.keyword.cloud_notm}} 上建立 {{site.data.keyword.cloudant_short_notm}} 實例](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud#creating-an-ibm-cloudant-instance-on-ibm-cloud)指導教學。若要從 {{site.data.keyword.cloud_notm}} CLI 產生服務認證，請參閱 [為您的 {{site.data.keyword.cloudant_short_notm}} 服務建立認證] (/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud-by-using-the-ibm-cloud-cli#creating-an-ibm-cloudant-instance-on-ibm-cloud-by-using-the-ibm-cloud-cli)。 

以下是 {{site.data.keyword.cloudant_short_notm}} 實例的範例服務認證：

```json
{
  "apikey": "MxVp86XHkU82Wc97tdvDF8qM8B0Xdit2RqR1mGfVXPWz",
  "host": "76838001-b883-444d-90d0-46f89e942a15-bluemix.cloudant.com",
  "iam_apikey_description": "Auto generated apikey during resource-key [...]",
  "iam_apikey_name": "auto-generated-apikey-050d21b5-5f[...]",
  "iam_role_crn": "crn:v1:bluemix:public:iam::::serviceRole:Manager",
  "iam_serviceid_crn": "crn:v1:staging:public:iam-identity::[...]",
  "password": "8fb6a16b48903e87b769e7f4968521e85c2394ed8f0e69b2769e56dcb27d2e76",
  "port": 443,
  "url": "https://<username>:<password>@76838001-b883-444d-90d0-46f89e942a15-bluemix.cloudant.com",
  "username": "76838001-b883-444d-90d0-46f89e942a15-bluemix"
}
```
{: codeblock}

服務認證包括下列欄位：

欄位       |用途
------|--------
`username` | URL 中服務實例使用者的服務名稱。此欄位也用來作為管理使用者名稱。
`password` | 應用程式存取服務實例所需的舊式認證密碼。只有在選擇`同時使用 Legacy 認證及 IAM` 選項時，才會顯示此欄位。
`host`     |應用程式用來尋找服務實例的主機名稱。只有在選擇`同時使用 Legacy 認證及 IAM` 選項時，才會顯示此欄位。
`port`     | 用來存取主機上服務實例的 HTTPS 埠號。它是 443，因為 {{site.data.keyword.cloudant_short_notm}} 只容許 HTTPS 存取。只有在選擇`同時使用 Legacy 認證及 IAM` 選項時，才會顯示此欄位。
`url`	| 存取 {{site.data.keyword.cloudant_short_notm}} 實例的 HTTPS URL。如果選擇`同時使用 Legacy 認證及 IAM` 選項，則也會包括內嵌的舊式使用者名稱和密碼。
`apikey` | IAM API 金鑰。
`iam_apikey_description` | IAM API 金鑰的說明。
`iam_apikey_name` | IAM API 金鑰的 ID。
`iam_role_crn` | IAM API 金鑰具有的 IAM 角色。
`iam_serviceid_crn`	| 服務 ID 的 CRN。

## 鑑別
{: #authentication-overview}

{{site.data.keyword.cloudant_short_notm}} 在佈建時間有兩種可用的鑑別方法：`僅使用 IAM` 或`同時使用 Legacy 認證及 IAM`。只有在選擇`同時使用 Legacy 認證及 IAM` 鑑別方法時，才能在服務認證中看到有關舊式認證的詳細資料。認證會顯示在您實例的「服務認證」標籤上。如需相關資訊，請參閱 [IAM 手冊](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-)及[舊式鑑別](/docs/services/Cloudant?topic=cloudant-authentication#authentication)文件，以取得使用任一種鑑別樣式的詳細資料。
 
{{site.data.keyword.cloudant_short_notm}} 團隊建議您儘可能使用 IAM 存取控制進行鑑別。如果您是使用 {{site.data.keyword.cloudant_short_notm}} 舊式鑑別，建議您使用 [API 金鑰](/docs/services/Cloudant?topic=cloudant-authorization#api-keys){: new_window}，而非帳戶層次認證，進行程式化存取及抄寫工作。
{: important}

## {{site.data.keyword.cloudant_short_notm}} 儀表板
{: #ibm-cloudant-dashboard}

您可以為您的實例開啟「{{site.data.keyword.cloudant_short_notm}} 儀表板」，方法是移至「{{site.data.keyword.cloud_notm}} 儀表板」實例詳細資料頁面的「管理」標籤。也可以使用`啟動`或`啟動 Cloudant 儀表板`按鈕，在新的瀏覽器標籤中開啟「儀表板」。「{{site.data.keyword.cloudant_short_notm}} 儀表板」可讓您執行下列作業：

- 監視實例的現行耗用量
- 對 {{site.data.keyword.cloudant_short_notm}} 資料庫、文件及索引執行 CRUD（建立、讀取、更新、刪除）
- 設定及檢視抄寫工作
- 檢視作用中的作業
- 檢視及更新帳戶資訊，像是佈建的傳輸量、公告、CORS 及設定

## 程式化存取
{: #programmatic-access}

### 指令行 (curl)
{: #command-line-curl-}

您可以運用 curl 指令行來存取 {{site.data.keyword.cloudant_short_notm}} HTTPS API。 

如果您使用 {{site.data.keyword.cloudant_short_notm}} 舊式鑑別，請參閱 [API 參考資料概觀](/docs/services/Cloudant?topic=cloudant-api-reference-overview#api-reference-overview)，以取得有關提供使用者名稱及密碼，利用 curl 存取 {{site.data.keyword.cloudant_short_notm}} API 的詳細資料，如 API 參考資料範例中所示。

如果您使用 {{site.data.keyword.cloud_notm}} IAM 鑑別，必須先使用 API 金鑰取得 {{site.data.keyword.cloud_notm}} IAM 記號。然後，將 IAM 記號傳遞至要鑑別的 {{site.data.keyword.cloudant_short_notm}} 實例。請參閱 [傳遞
{{site.data.keyword.cloud_notm}} IAM 記號，以利用服務的 API 進行鑑別] (https://cloud.ibm.com/docs/services/iam?topic=iam-iamapikeysforservices#token_auth){: new_window} 
指導教學。 

您無法直接使用 IAM API 金鑰，針對 {{site.data.keyword.cloudant_short_notm}} 進行鑑別。
{: note}

### 用戶端程式庫

{: #client-libraries-overview}

{{site.data.keyword.cloudant_short_notm}} 具有 Java、Node.js、Python、Swift 及 Mobile 的正式用戶端程式庫。如需相關資訊，請參閱[用戶端程式庫文件](/docs/services/Cloudant?topic=cloudant-client-libraries#client-libraries)來存取程式庫，以及參閱從每一個程式庫連接至 {{site.data.keyword.cloudant_short_notm}} 實例的範例。 
