---

copyright:
  years: 2017
lastupdated: "2017-01-10"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-01-10 -->

# 建立簡單的 Bluemix 應用程式以存取 Cloudant 資料庫：必要條件

指導教學的這一節說明用於建立 {{site.data.keyword.Bluemix}} 應用程式的必要條件。
{:shortdesc}

## 必要條件

請確定您已有下列資源或資訊，再透過指導教學開始運作。

### Python

針對最簡單的可能開發工作以外的所有開發工作，如果您的系統上有現行 [Python 程式設計語言 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://www.python.org/){:new_window} 安裝，則會較為簡單。

若要檢查，請在提示中執行下列指令：

```sh
python --version
```
{:pre}

預期結果類似下列輸出：

```
Python 2.7.12
```
{:codeblock}

<div id="csi"></div>

### Bluemix 上的 Cloudant 服務實例

[這裡](create_service.html)提供用於建立 {{site.data.keyword.cloudant_short_notm}} 服務實例（稱為 '`Cloudant Service 2017`'）的不同指導教學。

本指導教學假設您已建立稱為 '`Cloudant Service 2017`' 的服務實例。

### Cloudant 資料庫應用程式

[這裡](create_database.html)提供用於建立獨立式 Python 應用程式來使用 {{site.data.keyword.cloudant_short_notm}} 服務實例的不同指導教學。它會引進有助於瞭解如何建立並將資料移入 {{site.data.keyword.cloudant_short_notm}} 資料庫的一些概念。

本指導教學假設您熟悉這些概念。

## 下一步

指導教學中的下一步是[建立應用程式環境](create_bmxapp_appenv.html)。
