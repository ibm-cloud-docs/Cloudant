---

copyright:
  years: 2015, 2019
lastupdated: "2019-02-27"

keywords: migrate to a resource group, downtime, migrate existing instance, organization and space, standard plan, dedicated hardware instance, how to migrate

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

# {{site.data.keyword.cloudant_short_notm}} 如何使用「{{site.data.keyword.cloud_notm}} 資源群組」？
{: #how-does-ibm-cloudant-work-with-ibm-cloud-resource-groups-}

從 2018 年 7 月 16 日開始，新的 {{site.data.keyword.cloudantfull}} 資源實例已佈建至資源群組，而非 Cloud Foundry 空間。本文件涵蓋 {{site.data.keyword.cloudant_short_notm}} 支援中心所收到有關此轉移的常見問題。

## 如何將現有實例移轉至資源群組？
{: #how-do-i-migrate-an-existing-instance-to-a-resource-group-}

若要將 {{site.data.keyword.cloudant_short_notm}} 實例從 Cloud Foundry 空間移轉至資源群組，請參閱[將 Cloud Foundry 服務實例及應用程式移轉至資源群組](https://cloud.ibm.com/docs/resources/instance_migration.html#migrate){: new_window}。

您可以在下列方案上移轉 {{site.data.keyword.cloudant_short_notm}} 實例：

- 精簡
- 標準
- 專用硬體

## 當您將實例移轉至資源群組時，發生多長的關閉時間？
{: #how-much-downtime-occurs-when-you-migrate-an-instance-to-a-resource-group-}

移轉處理程序期間未發生關閉時間。

## 為何有些實例有組織及空間，而其他實例沒有？
{: #why-do-some-instances-have-an-organisation-and-space-and-others-do-not-}

從 2018 年 7 月 16 日開始，新的實例已佈建至資源群組，而非 Cloud Foundry 空間。在此日期之前佈建的資源實例具有關聯的 Cloud Foundry 組織及空間。在此日期之後佈建的實例將會改為與資源群組相關聯。

## 為何我無法在「專用硬體」實例上建立新的「標準方案」實例？
{: #why-can-t-i-create-new-standard-plan-instances-on-my-dedicated-hardware-instances-}

新的「標準方案」實例會佈建至資源群組。為了能夠將這些實例佈建至「專用硬體」實例，必須先將「專用硬體」實例移轉至資源群組。

如需如何執行此作業的相關資訊，請參閱[將 Cloud Foundry 服務實例及應用程式移轉至資源群組](https://cloud.ibm.com/docs/resources/instance_migration.html#migrate){: new_window}。

在「專用硬體」實例已移轉至資源群組之後，它會在佈建「標準方案」時出現在「位置」下拉功能表中。

## 我應該如何移轉「專用硬體」實例及其上所管理的「標準方案」實例？
{: #how-should-i-migrate-my-dedicated-hardware-instances-and-the-standard-plan-instances-hosted-on-them-}

理論上，可以依任何順序將實例移轉至資源群組。實際上，我們建議對「專用硬體」實例及其上所管理的「標準方案」實例使用下列順序：

1. 將「專用硬體」實例移轉至資源群組。這容許在「專用硬體」上建立新的「標準方案」實例。
2. 移轉「標準」實例。

隨時可以移轉「專用硬體」上未管理的「精簡方案」實例及「標準方案」實例。
{: tip}
