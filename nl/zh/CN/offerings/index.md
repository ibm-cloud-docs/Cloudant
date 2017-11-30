---

copyright:
  years: 2015, 2017
lastupdated: "2017-08-25"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-03-16 -->

# Cloudant 产品

## 数据库即服务

Cloudant 是一种托管且完全受管的数据库即服务 (DBaaS)。它从头开始构建，用于在全球范围内进行扩展，实现不间断运行，以及处理各种数据类型，例如 [JSON](../basics/index.html#json)、[全文本](../api/cloudant_query.html#creating-an-index)和[地理空间](../api/cloudant-geo.html)。Cloudant 是经过优化的运作数据存储器，可处理并行读写操作，并实现了高可用性和数据耐久性。

它提供了一个 [HTTP API](../basics/index.html#http-api)，用于处理 [JSON](../basics/index.html#json) 数据，并提供 24 小时运行支持和维护。Cloudant 基于 [Apache CouchDB ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](http://couchdb.apache.org/){:new_window}，并以各种多租户、专用和已安装服务的形式交付。

>   **注**：本文档中的所有货币值都以美元 ($) 为单位。

Cloudant DBaaS 产品通过 [https://cloudant.com/ ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://cloudant.com/){:new_window} 提供，提供方式可为[共享套餐](#shared-plan)或[企业（专用）套餐](#enterprise-plan)。

Cloudant 还可作为 [IBM Bluemix 服务](bluemix.html)提供。

>	**注：**[IBM Bluemix 服务](bluemix.html)上未提供 Cloudant [共享套餐](#shared-plan)和[企业（专用）套餐](#enterprise-plan)。

### 共享套餐

使用 Cloudant 共享套餐时，您有权访问通过共享集群或“多租户”集群提供的所有 Cloudant DBaaS 功能。

价格根据您的每月使用量确定。如果每月使用量低于 50.00 美元（截至 2016 年 8 月），那么不会收取任何费用。

有关更多信息，请参阅[定价详细信息 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://cloudant.com/product/pricing/){:new_window}。

### 企业套餐

使用 Cloudant DBaaS 企业套餐时，您有权访问通过专用单租户集群提供的所有 Cloudant DBaaS 功能。

此套餐通过专用 DBaaS 集群或在各种托管位置提供的硬件，为您提供有保障的数据库性能和正常运行时间。

有关更多信息，请参阅[定价详细信息 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://cloudant.com/product/pricing/){:new_window}。

## Cloudant Local

[IBM Cloudant Data Layer Local Edition (Cloudant Local) ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://www.ibm.com/support/knowledgecenter/SSTPQH_1.0.0/com.ibm.cloudant.local.doc/SSTPQH_1.0.0_welcome.html){:new_window} 是 Cloudant 数据库即服务 (DBaaS) 产品的本地安装版本。

Cloudant Local 提供与完整的 Cloudant 单租户产品相同的基本功能，但它在您自己的数据中心内托管。

[提供了 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](http://www-01.ibm.com/support/knowledgecenter/SSTPQH_1.0.0/com.ibm.cloudant.local.install.doc/topics/clinstall_cloudant_local_overview.html?lang=en-us){:new_window} Cloudant Local 的更详细概述。[IBM Knowledge Center ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](http://www-01.ibm.com/support/knowledgecenter/SSTPQH_1.0.0/com.ibm.cloudant.local.doc/SSTPQH_1.0.0_welcome.html?lang=en){:new_window} 提供了有关 Cloudant Local 许多方面的信息，包括：

-   [安装和配置 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](http://www.ibm.com/support/knowledgecenter/SSTPQH_1.0.0/com.ibm.cloudant.local.install.doc/topics/clinstall_extract_install_cloudant_local.html?lang=en){:new_window}。
-   [维护任务 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](http://www-01.ibm.com/support/knowledgecenter/SSTPQH_1.0.0/com.ibm.cloudant.local.install.doc/topics/clinstall_maintenance_tasks_overview.html?lang=en){:new_window}。
-   [调整复制参数 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](http://www-01.ibm.com/support/knowledgecenter/SSTPQH_1.0.0/com.ibm.cloudant.local.install.doc/topics/clinstall_tuning_parameters_replication_cases.html?lang=en){:new_window}。

## [安全性](security.html)

{{site.data.keyword.cloudantfull}} 中的数据访问控制、加密和数据备份功能，让金融服务、政府、电子商务、电信、医疗卫生和其他注重安全性的行业的客户都能从中受益。

## [合规性](compliance.html)

{{site.data.keyword.cloudant_short_notm}} 提供了可靠、安全的云数据库系统。该服务基于业内最佳标准（包括 ISO 27001:2013）进行构建。

[提供了](dataprivacygovernance.html)有关 {{site.data.keyword.cloudant_short_notm}} 数据隐私和管理的更多详细信息。
