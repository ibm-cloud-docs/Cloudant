---

copyright:
  years: 2015, 2019
lastupdated: "2019-03-07"

keywords: capabilities, support, file support ticket

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

# {{site.data.keyword.cloudant_local_notm}}
{: #ibm-cloudant-local}

[{{site.data.keyword.cloudantfull}} Data Layer Local Edition ({{site.data.keyword.cloudant_local_notm}}) ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://www.ibm.com/support/knowledgecenter/SSTPQH_1.1.0/com.ibm.cloudant.local.doc/SSTPQH_1.1.0_welcome.html){: new_window} 是 {{site.data.keyword.cloudant_short_notm}} 数据库即服务 (DBaaS) 产品的本地安装版本。

{{site.data.keyword.cloudant_local_notm}} 提供与完整的 {{site.data.keyword.cloudant_short_notm}} 单租户产品相同的基本功能，但其托管位置是在您自己的数据中心内。

[此处 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://www.ibm.com/support/knowledgecenter/en/SSTPQH_1.1.0/com.ibm.cloudant.local.install.doc/topics/clinstall_cloudant_local_overview.html){: new_window} 提供了对 {{site.data.keyword.cloudant_local_notm}} 的进一步详细概述。[IBM Knowledge Center ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://www.ibm.com/support/knowledgecenter/en/SSTPQH_1.1.0/com.ibm.cloudant.local.doc/SSTPQH_1.1.0_welcome.html){: new_window} 提供了有关 {{site.data.keyword.cloudant_local_notm}} 许多方面的信息，包括：

-   [安装和配置 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://www.ibm.com/support/knowledgecenter/en/SSTPQH_1.1.0/com.ibm.cloudant.local.install.doc/topics/clinstall_installing.html){: new_window}。
-   [维护任务 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://www.ibm.com/support/knowledgecenter/en/SSTPQH_1.1.0/com.ibm.cloudant.local.install.doc/topics/clinstall_maintenance_tasks_overview.html){: new_window}。
-   [调整复制参数 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://www.ibm.com/support/knowledgecenter/en/SSTPQH_1.1.0/com.ibm.cloudant.local.install.doc/topics/clinstall_tuning_parameters_replication_cases.html){: new_window}。

## {{site.data.keyword.cloudant_local_notm}} 支持
{: #ibm-cloudant-local-support}

{{site.data.keyword.cloudant_short_notm}} 支持人员能够就 {{site.data.keyword.cloudant_local_notm}} 的安装、设置和正确使用提供帮助。如果出现性能问题或不一致情况，支持人员能够帮助进行故障诊断。如果发生中断，支持人员可以帮助诊断问题，但由于我们无权访问客户系统，因此解决问题的责任落在客户团队身上。

对于任何问题，都需要有足够的日志，才能提供相应的帮助。为了帮助尽快开始进行故障诊断，您必须在通知支持人员相关问题时，包含 Weatherreport 实用程序的输出，以及任何相关的日志、请求和状态码。有关更多信息，请参阅 [Weatherreport 实用程序 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://www.ibm.com/support/knowledgecenter/SSTPQH_1.1.0/com.ibm.cloudant.local.install.doc/topics/clinstall_checking_health_cluster_with_weatherreport.html){: new_window}。

仅当底层问题属于支持范围时，才能提供对常见问题和中断的帮助。以下文本描述了可用的支持： 

{{site.data.keyword.cloudant_short_notm}} 支持涵盖以下问题：
- 正确安装
- 设置
- 与返回错误或者意外结果或性能的 API 相关的任何内容

{{site.data.keyword.cloudant_short_notm}} 支持不涵盖以下问题：
- 专有客户方工具或工作流程
- 网络问题 
- 磁盘上加密 
- 定制工具或功能

例如，如果根本原因是客户拥有的服务器遇到硬件问题，那么支持人员无法提供帮助。但是，如果中断是由于 {{site.data.keyword.cloudant_short_notm}} 软件本身引起的（例如，如果由于文档冲突而导致请求变慢），那么支持人员可以帮助客户解决该问题。

对于以下请求，请联系客户成功经理或客户经理，以获取进一步帮助：
- 性能调整
- 设计优化
- 容量规划

如果您对我们的支持策略有任何疑问，请联系 [{{site.data.keyword.cloudant_short_notm}} 支持团队 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](mailto:support@cloudant.com){: new_window}。

### 如何开具支持凭单
{: #how-to-open-a-support-ticket}

要获取有关 {{site.data.keyword.cloudant_local_notm}} 问题的帮助，请开具支持凭单以向 {{site.data.keyword.cloudant_short_notm}} 支持部门说明问题，具体要包含的信息如下：

1. 创建电子邮件以建立 [{{site.data.keyword.cloudant_short_notm}} 支持请求](mailto:support@cloudant.com)。
2. 在电子邮件主题行中，提供关于问题的一句话描述。
3. 电子邮件必须包含以下详细信息，以帮助我们诊断您的问题：
    - 姓名
    - 联系人电子邮件地址
    - 您所在组织的名称
    - 所使用的 {{site.data.keyword.cloudant_local_notm}} 版本
    - 用于运行 {{site.data.keyword.cloudant_local_notm}} 的 Linux 分发版和版本
    - 问题的严重性级别
    - 问题的详细描述，包括问题的发生条件以及有关任何最近更改的信息
    - 如果有对于诊断、再现和调查问题有帮助的日志或输出，请附加到电子邮件中
4. 当支持部门收到电子邮件后，会有支持团队的成员与您联系。

