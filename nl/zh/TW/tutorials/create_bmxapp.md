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
{:tip: .tip}

<!-- Acrolinx: 2017-05-10 -->

# 建立簡單的 {{site.data.keyword.cloud_notm}} 應用程式以存取 {{site.data.keyword.cloudant_short_notm}} 資料庫

本指導教學示範如何建立 {{site.data.keyword.cloud}} 應用程式，使用 [Python 程式設計語言 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://www.python.org/){:new_window} 來存取在 {{site.data.keyword.cloud_notm}} 服務實例中管理的 {{site.data.keyword.cloudantfull}} 資料庫。
{:shortdesc}

## 環境定義

{{site.data.keyword.cloud}} 的重大優點是，您可以在 {{site.data.keyword.cloud_notm}} 本身內建立及部署應用程式。您不需要尋找及維護伺服器，即可執行應用程式。

如果您已在 {{site.data.keyword.cloud_notm}} 內使用 {{site.data.keyword.cloudant_short_notm}} 資料庫實例，則應用程式位於該處也很合理。

{{site.data.keyword.cloud_notm}} 應用程式一般是使用 [Cloud Foundry ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](https://en.wikipedia.org/wiki/Cloud_Foundry){:new_window} 技術所建立。Cloud Foundry 提供一種「平台即服務 (PaaS)」功能，以簡化建立可在雲端環境內部署及執行之應用程式的處理程序。

[個別指導教學](create_database.html)顯示如何建立獨立式 Python 應用程式，用於在 {{site.data.keyword.cloud_notm}} 內使用 {{site.data.keyword.cloudant_short_notm}} 資料庫實例。
在本指導教學中，您可以設定及建立在 {{site.data.keyword.cloud_notm}} 內管理的小型 Python 應用程式。應用程式會連接至 {{site.data.keyword.cloudant_short_notm}} 資料庫實例，並建立單一簡單文件。

在本指導教學中，會提供每一個作業特有的 Python 程式碼。本指導教學（[這裡](create_bmxapp_createapp.html#complete-listing)）提供足以示範概念的完整 Python 程式。

本指導教學不會嘗試建立_有效率_ 的 Python 程式碼；本指導教學是為了示範簡單易懂且可運作的程式碼，方便您從中學習並應用於自己的應用程式。

此外，也不會嘗試處理所有可能的檢查或錯誤狀況。指導教學中包含了一些範例檢查來說明一些技巧，但您應該應用正常的最佳作法來檢查及處理您自己的應用程式遇到的所有警告或錯誤狀況。

## 作業概觀

若要在 {{site.data.keyword.cloud_notm}} 上建立可存取 {{site.data.keyword.cloudant_short_notm}} 資料庫實例的可運作 Python 應用程式，您需要執行下列作業：

-   [在 {{site.data.keyword.cloud_notm}} 上建立 Python 應用程式環境。](create_bmxapp_appenv.html#creating)
-   [確定 Python 應用程式環境具有 {{site.data.keyword.cloudant_short_notm}} 資料庫實例的「連線」。](create_bmxapp_appenv.html#connecting)
-   [（單次作業）下載並安裝 Cloud Foundry 及 {{site.data.keyword.cloud_notm}} 指令行工具箱。](create_bmxapp_appenv.html#toolkits)
-   [下載「入門範本」應用程式。](create_bmxapp_appenv.html#starter)
-   [自訂入門範本應用程式以建立自己的應用程式來存取 {{site.data.keyword.cloudant_short_notm}} 資料庫實例。](create_bmxapp_createapp.html#theApp)
-   [上傳應用程式並測試其運作。](create_bmxapp_upload.html#uploading)
-   [執行基本應用程式維護作業。](create_bmxapp_maintain.html#maintenance)
-   [診斷及解決問題（疑難排解）。](create_bmxapp_maintain.html#troubleshooting)

## 指導教學結構

本指導教學包含五個小節：

1.  [必要條件](create_bmxapp_prereq.html)
2.  [應用程式環境](create_bmxapp_appenv.html)
3.  [建立應用程式](create_bmxapp_createapp.html)
4.  [上傳並執行應用程式](create_bmxapp_upload.html)
5.  [維護及疑難排解應用程式](create_bmxapp_maintain.html)

## 下一步

若要開始指導教學，首先請[檢查必要條件](create_bmxapp_prereq.html)。
