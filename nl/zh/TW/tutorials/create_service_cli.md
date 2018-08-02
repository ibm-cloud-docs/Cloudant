---

copyright:
  years: 2017, 2018
lastupdated: "2018-06-07"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

# 使用 Cloud Foundry 工具在 {{site.data.keyword.Bluemix_notm}} 上建立 {{site.data.keyword.cloudant_short_notm}} 實例

本指導教學示範如何使用 Cloud Foundry 工具在 {{site.data.keyword.Bluemix}} 上建立 {{site.data.keyword.cloudantfull}} 服務實例。
{:shortdesc}

## 必要條件

若要遵循本指導教學，您必須先安裝 {{site.data.keyword.Bluemix_notm}} Cloud Foundry 工具。[這個個別指導教學](create_bmxapp_appenv.html#the-cloud-foundry-and-ibm-cloud-command-toolkits)提供了安裝工具的詳細資料。

> **附註**：請確定您同時安裝 Cloud Foundry _及_ {{site.data.keyword.Bluemix_notm}} 工具箱。

## 識別 {{site.data.keyword.Bluemix_notm}} API 端點

指定 Cloud Foundry 指令的目標 API 端點：

```sh
bx api https://api.ng.bluemix.net
```
{:codeblock}

結果確認您已正確地識別端點：

```sh
Setting api endpoint to https://api.ng.bluemix.net...
OK

API endpoint: https://api.ng.bluemix.net (API version: 2.54.0)
Not logged in. Use 'bx login' to log in.
```
{:pre}

## 登入 {{site.data.keyword.Bluemix_notm}} 帳戶

1.  使用下列指令，以開始 {{site.data.keyword.Bluemix_notm}} 帳戶的登入程序：
  
  ```sh
  bx login
  ```
  {:codeblock}
  
  {{site.data.keyword.Bluemix_notm}} 的回覆方式是提醒您現行的 API 端點，然後要求輸入您帳戶的電子郵件位址：
  
  ```sh
  API endpoint: https://api.ng.bluemix.net
  
  Email>
  ```
  {:pre}

2.  輸入您帳戶的電子郵件位址。然後，{{site.data.keyword.Bluemix_notm}} 會要求輸入您帳戶的密碼：
  ```sh
  API endpoint: https://api.ng.bluemix.net
  
  Email> J.Doe@email.com
  
  Password>
  ```
  {:pre}
  
  {{site.data.keyword.Bluemix_notm}} 會驗證您的詳細資料，然後彙總您登入階段作業的相關資訊：
  ```sh
  API endpoint: https://api.ng.bluemix.net
  
  Email> J.Doe@email.com
  
  Password> 
  Authenticating...
  OK
  
  Targeted account J DOE's Account (707...a32)
  
  Targeted org J.Doe@email.com
  
  Targeted space dev
  
  API endpoint:   https://api.ng.bluemix.net (API version: 2.54.0)
  Region:         us-south
  User:           j.doe@email.com
  Account:        J DOE's Account (707...a32)
  Org:            J.Doe@email.com
  Space:          dev
  ```
  {:pre}

3.  您現在已登入 {{site.data.keyword.Bluemix_notm}} 帳戶。

## 選擇服務的 {{site.data.keyword.cloudant_short_notm}} 方案

取得所有可用服務供應項目的清單。請過濾此清單，使其只符合 {{site.data.keyword.cloudant_short_notm}} 服務：

```sh
bx service offerings | grep -i Cloudant
```
{:codeblock}

結果會列出您帳戶可用的 {{site.data.keyword.cloudant_short_notm}} 服務，包括您可以選取的特定方案：

```sh
cloudantNoSQLDB   Lite, Standard*
```
{:pre}

**選用項目**：若要查看方案的其他詳細資料，請使用下列指令：

```sh
bx cf marketplace -s cloudantNoSQLDB
```
{:codeblock}

結果會顯示可用方案的摘要，類似於範例回應的下列區段（詳細資料到 2017 年 5 月截止正確）：

```
Lite
The Lite plan provides access to the full functionality of {{site.data.keyword.cloudant_short_notm}} for development and evaluation.
The plan has a set amount of provisioned throughput capacity as shown
and includes a max of 1GB of encrypted data storage.   free
```
{:pre}

## 建立 {{site.data.keyword.cloudant_short_notm}} 服務

在 {{site.data.keyword.Bluemix_notm}} 內建立服務實例的基本指令格式如下：

```sh
bx service create <service> <plan> <instance name>
```
{:pre}

假設我們要使用 `Lite` 方案來建立實例名稱為 `cs20170517a` 的 {{site.data.keyword.cloudant_short_notm}} 服務實例。

請使用與下列範例類似的指令：

```sh
bx service create cloudantNoSQLDB Lite cs20170517a
```
{:codeblock}

建立服務實例之後，會回應與下列範例類似的訊息：

```sh
Invoking 'cf create-service cloudantNoSQLDB Lite cs20170517a'...

Creating service instance cs20170517a in org J.Doe@email.com / space dev as J.Doe@email.com...
OK

```
{:pre}

## 建立 {{site.data.keyword.cloudant_short_notm}} 服務的認證

需要存取 {{site.data.keyword.cloudant_short_notm}} 服務的應用程式，必須具有必要的認證。

>   **附註**：服務認證很重要。
如果有任何人或任何應用程式可以存取認證，實際上就可以利用服務實例執行想要的一切作業，例如，他們/它們可能會建立偽造資料，或刪除寶貴的資訊。請小心地保護這些認證。

服務認證包含五個欄位：

欄位       |用途
-----------|--------
`host`     |應用程式用來尋找服務實例的主機名稱。
`username` |應用程式存取服務實例所需的使用者名稱。
`password` |應用程式存取服務實例所需的密碼。
`port`     |用來存取主機上服務實例的 HTTP 埠號。一般是 443，可強制執行 HTTPS 存取。
`url`      |將其他認證資訊聚集成單一 URL 的字串，適合供應用程式使用。

在 {{site.data.keyword.Bluemix_notm}} 內建立服務實例的認證的基本指令格式如下：

```sh
bx cf create-service-key <instance name> <credentials name>
```
{:pre}

假設我們要建立 {{site.data.keyword.cloudant_short_notm}} 服務的 `cs20170517a` 實例的認證，而認證的名稱是 `creds20170517a`。

請使用與下列範例類似的指令：

```sh
bx cf create-service-key cs20170517a creds20170517a
```
{:codeblock}

收到建立服務實例認證的要求之後，{{site.data.keyword.Bluemix_notm}} 會回應與下列範例類似的訊息：

```sh
Invoking 'cf create-service-key cs20170517a creds20170517a'...

Creating service key creds20170517a for service instance cs20170517a as J.Doe@email.com...
OK
```
{:pre}

## 列出 {{site.data.keyword.cloudant_short_notm}} 服務的服務認證

在 {{site.data.keyword.Bluemix_notm}} 內擷取服務實例認證的基本指令格式如下：

```sh
bx cf service-key <instance name> <credentials name>
```
{:pre}

假設我們要擷取 {{site.data.keyword.cloudant_short_notm}} 服務的 `cs20170517a` 實例的認證，而認證的名稱是 `creds20170517a`。

請使用與下列範例類似的指令：

```sh
bx cf service-key cs20170517a creds20170517a
```
{:codeblock}

收到擷取服務實例認證的要求之後，{{site.data.keyword.Bluemix_notm}} 會回應與下列（簡短）範例類似的訊息：

```sh
Invoking 'cf service-key cs20170517a creds20170517a'...

Getting key creds20170517a for service instance cs20170517a as J.Doe@email.com...

{
 "host": "946...46f-bluemix.cloudant.com",
 "password": "4eb...eb5",
 "port": 443,
 "url": "https://946...46f-bluemix:4eb...eb5@946...46f-bluemix.cloudant.com",
 "username": "946...46f-bluemix"
}
```
{:pre}

## 使用 {{site.data.keyword.cloudant_short_notm}} 服務實例

此時，您：

1.  已在 {{site.data.keyword.Bluemix_notm}} 內建立 {{site.data.keyword.cloudant_short_notm}} 服務實例。
2.  已建立 {{site.data.keyword.cloudant_short_notm}} 服務實例的認證。
3.  已擷取服務實例認證，因此應用程式可以使用它們。

[這裡](create_database.html#context)提供示範如何使用 {{site.data.keyword.cloudant_short_notm}} 服務實例的指導教學。請記得替換您已在本指導教學中建立的認證。

## （選用）後續整理

下列簡短指令清單可能對您整理開發環境很實用。

### 刪除服務認證

若要刪除一組服務認證，請使用與下列類似的指令：

```sh
bx cf delete-service-key <instance name> <credentials name>
```
{:pre}

例如，若要從 {{site.data.keyword.cloudant_short_notm}} 服務的 `cs20170517a` 實例中刪除稱為 `creds20170517a` 的認證，您可以使用與下列類似的指令：

```sh
bx cf delete-service-key cs20170517a creds20170517a
```
{:pre}

### 刪除服務實例

若要刪除服務實例，請使用與下列類似的指令：

```sh
bx service delete <instance name>
```
{:pre}

例如，若要刪除 {{site.data.keyword.cloudant_short_notm}} 服務的 `cs20170517a` 實例，您可以使用與下列類似的指令：

```sh
bx service delete cs20170517a
```
{:pre}

