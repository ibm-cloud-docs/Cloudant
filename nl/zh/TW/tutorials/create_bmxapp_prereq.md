---

copyright:
  years: 2017, 2019
lastupdated: "2019-06-12"

keywords: python, create service instance, create stand-alone python application

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

# 建立簡單的 {{site.data.keyword.cloud_notm}} 應用程式以存取 {{site.data.keyword.cloudant_short_notm}} 資料庫：必要條件
{: #creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-prerequisites}

指導教學的這一節說明用於建立 {{site.data.keyword.cloud}} 應用程式的必要條件。
{: shortdesc}

## 必要條件
{: #prerequisites-create_bmxapp_prereq}

請確定您已準備好下列資源或資訊，然後才開始進行本指導教學。

### Python
{: #python-create-bmxapp-prereq}

針對最簡單的可能開發工作以外的所有開發工作，如果您的系統上有現行 [Python 程式設計語言 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://www.python.org/){: new_window} 安裝，則會較為簡單。

若要檢查，請在提示執行下列指令：

```sh
python --version
```
{: pre}

預期結果類似下列輸出：

```
Python 2.7.12
```
{: codeblock}

### {{site.data.keyword.cloud_notm}} 上的 {{site.data.keyword.cloudant_short_notm}} 服務實例
{: #an-ibm-cloudant-service-instance-on-ibm-cloud}

有關[在 {{site.data.keyword.cloud_notm}} 上建立 {{site.data.keyword.cloudantfull}} 服務實例](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud#creating-an-ibm-cloudant-instance-on-ibm-cloud)的個別指導教學將建立名為 "`Cloudant-o7`" 的服務實例。 

本指導教學假設您已建立稱為 '`Cloudant-o7`' 的服務實例。

### {{site.data.keyword.cloudant_short_notm}} 資料庫應用程式
{: #an-ibm-cloudant-database-application}

另外還提供有關[建立獨立式 Python 應用程式以使用 {{site.data.keyword.cloudant_short_notm}} 服務實例](/docs/services/Cloudant?topic=cloudant-creating-and-populating-a-simple-ibm-cloudant-database-on-ibm-cloud#creating-and-populating-a-simple-ibm-cloudant-database-on-ibm-cloud)的個別指導教學。它介紹有助於瞭解如何建立 {{site.data.keyword.cloudant_short_notm}} 資料庫並將資料移入其中的一些概念。

本指導教學假設您熟悉這些概念。

指導教學中的下一步是[建立應用程式環境](/docs/services/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment)。
