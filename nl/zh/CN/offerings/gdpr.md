---

copyright:
  years: 2018, 2019
lastupdated: "2019-06-12"

keywords: audit access ibm cloudant, supported classifications of personal data, personal data, sensitive personal data, restrictions on processing, encrypt data, data locations, service security, delete data

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

# 一般数据保护条例 (GDPR)
{: #general-data-protection-regulation-gdpr-}

GDPR 力求在整个欧盟范围内建立一个统一的数据保护法律框架，目的是让公民重新拥有对其个人数据的控制权，同时对全球任意位置托管和“处理”此类数据的相关方施加严格的规则。该条例还引入了与欧盟境内和境外个人数据自由流通相关的规则。 

实行[一般数据保护条例 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://www.eugdpr.org/){: new_window} 后，{{site.data.keyword.cloudantfull}} 客户不仅可以依赖 {{site.data.keyword.cloudant_short_notm}} 团队对新实行的数据隐私标准和法规的理解和遵从，还可以依赖 {{site.data.keyword.IBM}} 所拥有的更广泛的能力。IBM 能够提供综合解决方案套件，帮助各种规模的企业满足自己的内部数据监管需求。

## 如何获取对 {{site.data.keyword.cloudant_short_notm}} 的审计访问权？
{: #how-do-i-audit-access-to-ibm-cloudant-}

可以在[审计日志记录](/docs/services/Cloudant?topic=cloudant-audit-logging#audit-logging){: new_window}中找到有关审计的信息。 

## 支持的个人数据分类
{: #supported-classifications-of-personal-data}

根据 GDPR，{{site.data.keyword.cloudant_short_notm}} 支持以下类别的个人数据：

**个人数据**，例如：
 * 身份/公民身份
 * 个人生活
 * 职业生涯
 * 位置数据
 * 连接/设备数据

**敏感个人数据**，仅限于：
  * 运行状况数据，[{{site.data.keyword.cloudant_short_notm}} 专用集群服务描述 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://www-03.ibm.com/software/sla/sladb.nsf/pdf/6756-04/$file/i126-6756-04_05-2018_en_US.pdf){: new_window} 和 [{{site.data.keyword.cloud}} 附加服务描述 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://www-03.ibm.com/software/sla/sladb.nsf/pdf/6627-04/$file/i126-6627-04_04-2018_en_US.pdf){: new_window} 中涵盖了额外的适用条件

如果要存储医疗保健数据，*必须*完成以下任务：
 - 在写入任何数据前通知 {{site.data.keyword.cloudant_short_notm}}。
 - 请求符合 HIPAA 的专用集群。

有关支持的个人数据分类的更多信息，请参阅[数据表附录 (DSA) 中“2. 个人数据”下的内容 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://www.ibm.com/software/reports/compatibility/clarity-reports/report/html/softwareReqsForProduct?deliverableId=2EBB5860B34311E7A9EB066095601ABB){: new_window}。

## 关于我的数据
{: #data-about-me}

{{site.data.keyword.cloudant_short_notm}} 会记录有关其用户的一些数据，同时也是所谓个人信息 (PI) 数据的数据控制者。{{site.data.keyword.cloudant_short_notm}} 记录的数据取决于您拥有的帐户类型。

如果您拥有 {{site.data.keyword.cloudant_short_notm}} 专用集群/{{site.data.keyword.cloudant_short_notm}} 企业集群，它们会记录关于您的数据，并且在 GDPR 上下文中会被视为您数据的数据控制者。如果您拥有 {{site.data.keyword.cloudant_short_notm}} 专用集群/{{site.data.keyword.cloudant_short_notm}} 企业集群，那么我们将拥有关于您的以下信息：

 * 姓名
 * 电子邮件
  可以通过 {{site.data.keyword.cloudant_short_notm}}“仪表板”查看和更新 {{site.data.keyword.cloudant_short_notm}} 保存的数据。

如果您拥有 {{site.data.keyword.cloud_notm}}（包括专用实例）供应的帐户，那么 {{site.data.keyword.cloudant_short_notm}} _不会_收集上述个人数据。这些数据由 {{site.data.keyword.cloud_notm}} 持有。

{{site.data.keyword.cloudant_short_notm}} 会在运行服务和优化用户体验的过程中处理有限的客户 PI。{{site.data.keyword.cloudant_short_notm}} 会根据需要通过电子邮件与客户联系。{{site.data.keyword.cloudant_short_notm}} 处理 PI 的另一种方式是监视客户与 {{site.data.keyword.cloudant_short_notm}}“仪表板”的交互。

### 处理限制
{: #restriction-of-processing}

{{site.data.keyword.cloudant_short_notm}} 会将仪表板交互数据发送给 Segment。您可以通过 [{{site.data.keyword.cloudant_short_notm}} 支持请求 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](mailto:support@cloudant.com){: new_window}，要求 {{site.data.keyword.cloudant_short_notm}} 以此方式限制对客户 PI 的处理。{{site.data.keyword.cloudant_short_notm}} 在收到此类请求后会删除已发送给 Segment 的客户相关信息，并会阻止发送进一步的数据。{{site.data.keyword.cloudant_short_notm}} 需要能够通过电子邮件与专用客户保持联系。客户可以直接在我们提供的相应界面中实时更新此信息，也可以通过其 {{site.data.keyword.cloud_notm}} 帐户详细信息中客户联系人详细信息的客户配置来更新此信息。

## 我们的 {{site.data.keyword.cloudant_short_notm}} 数据库是否已经过加密？
{: #is-our-ibm-cloudant-database-encrypted-}

所有集群都具有使用 Linux Unified Key Setup (LUKS) 加密的文件系统（静态加密）。我们的运营和支持团队可以查看数据库中的数据（请参阅以下段落）。

对于您认为不能对 {{site.data.keyword.cloudant_short_notm}} 可见的敏感数据，必须在将其发送给我们之前，对这些数据进行加密或以其他方式进行保护（使用假名）。不得将 PI 用作 URL 中的文档 `_id`，例如 `https://$ACCOUNT.cloudant.com/$DATABASE/$DOCUMENT_ID`，因为文档 _id 始终可见并且会写入访问日志中。

## 数据位置
{: #data-locations}

{{site.data.keyword.cloudant_short_notm}} 处理个人数据的位置将通过 DSA 提供，并且会实时更新。

有关数据位置的更多信息，请参阅 [DSA 中“7. {{site.data.keyword.IBM_notm}} 托管和处理位置”下的内容 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://www.ibm.com/software/reports/compatibility/clarity-reports/report/html/softwareReqsForProduct?deliverableId=2EBB5860B34311E7A9EB066095601ABB){: new_window}。

## 服务安全
{: #service-security}

### 安全地使用 {{site.data.keyword.cloudant_short_notm}}
{: #using-ibm-cloudant-securely}

作为 {{site.data.keyword.cloudant_short_notm}} 的用户，您应该：

 * 使用缺省 CORS 配置来防止意外访问。
 * 充分使用 API 密钥，以便组件可以具有“最低访问特权”，还应结合使用审计日志。通过这种做法，您可以了解谁访问了哪些数据。
 * 对于您确定必须对 {{site.data.keyword.cloudant_short_notm}} 保持不可见的敏感数据，请进行加密或以其他方式加以保护（使用假名）。

### 物理和环境安全措施
{: #physical-and-environmental-security-measures}

我们数据中心的物理安全性由我们的基础架构提供者 {{site.data.keyword.cloud}}、AWS 和 21Vianet 来处理。这些提供者全部都持有与所负责物理安全相对应的外部审计证书。{{site.data.keyword.cloudant_short_notm}} 不会提供在我们数据中心内实施的物理安全控制措施的进一步详细信息。

我们工作人员使用的办公地点的物理安全由 {{site.data.keyword.IBM_notm}} 公司来负责。如果客户需要，我们可以提供证书详细信息和认证报告（例如，ISO 和 SOC2）。

### 技术和组织措施
{: #technical-and-organizational-measures}

为了确保个人数据的安全，{{site.data.keyword.cloudant_short_notm}} 采用了技术和组织措施 (TOM)。对于 {{site.data.keyword.cloudant_short_notm}} 所采用的控制措施，{{site.data.keyword.cloudant_short_notm}} 持有相应的外部审计证书。如果客户需要，我们可以提供证书详细信息和认证报告（例如，ISO 和 SOC2）。

### 对数据的服务访问
{: #service-access-to-data}

{{site.data.keyword.cloudant_short_notm}} 运营和支持人员拥有对客户数据的访问权，他们可以在例行操作期间访问这些数据。此访问只能在必要时执行，且必须出于服务运营和支持的目的。此外，该访问被限制在*按需知密*的范围内，且会被记录、监视和审计。

## 删除数据
{: #deletion-of-data}

### 删除文档
{: #deleting-a-document}

在您删除文档后，数据库会为其创建“墓碑”。墓碑所含内容取决于您删除文档的方式：

 - 如果通过 `DELETE` 调用进行删除，那么墓碑会包含 `_id`、`_rev` 和 `_deleted` 字段。
 - 如果通过更新文档的 `_deleted: true` 字段并对文档执行 `PUT` 或 `POST` 操作进行删除，那么墓碑会包含您在文档正文中设置的内容。在某些情况下，这种做法非常有用，例如要在文档的墓碑中记录其删除原因时。

有关删除墓碑的更多信息，请参阅[简单除去“墓碑”文档](/docs/services/Cloudant?topic=cloudant-documents#tombstone-documents){: new_window}。

### 何时除去已删除文档？
{: #when-is-a-deleted-document-removed-}

压缩会自动运行，并会通过仅将“叶”修订版写入新文件，从数据库中定期除去旧修订版（已删除或其他旧修订版）。{{site.data.keyword.cloudant_short_notm}} 会保留 `_id` 和 `_rev` 的历史记录以支持复制，但不会保留旧文档正文的历史记录。

{{site.data.keyword.cloudant_short_notm}} 并未公开 CouchDB 压缩 API。
{: tip}

{{site.data.keyword.cloudant_short_notm}} 不保证数据库会在特定时间后进行压缩。压缩会作为后台进程在整个存储层上执行，并且始终会压缩数据库，不保证压缩的是您刚刚删除或更改的数据。

{{site.data.keyword.cloudant_short_notm}} 将通过 [{{site.data.keyword.IBM_notm}} Data Privacy Office (DPO) ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](http://w3-03.ibm.com/ibm/privacy/index.html){: new_window} 接受*被遗忘权*请求。从 {{site.data.keyword.IBM_notm}} DPO 发出*被遗忘权*请求时，{{site.data.keyword.cloudant_short_notm}} 会对该请求进行验证，显式触发数据库压缩，并验证是否执行了压缩。此过程结束后，文档的唯一版本就是其墓碑（`_id`、`_rev`、`_deleted` 以及应用程序在其中包含的任何字段）。

### 除去墓碑
{: #removal-of-tombstones}

{{site.data.keyword.cloudant_short_notm}} 可以根据需要，完全除去文档的所有引用和数据。此任务是一个操作员管理的过程，称为“清除”。在请求清除文档之前，有必要知悉，该过程一旦完成，{{site.data.keyword.cloudant_short_notm}} 就*无法恢复*清除的文档。

{{site.data.keyword.cloudant_short_notm}} 不支持 CouchDB 清除 API。
{: tip}

在 GDPR 上下文中，仅当在文档标识中使用了 PI 时，才需要执行清除。出于多种原因，在 `_id` 中存储 PI 是不明智的做法，但也有为数不多的半有效用例（例如，独特的电子邮件）。尽可能对数据进行加密或用假名进行保护，使其对 {{site.data.keyword.cloudant_short_notm}} 不可见。

如果需要通过*被遗忘权*请求除去文档，请执行以下操作：

1. 使用 [{{site.data.keyword.IBM_notm}} DPO ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](http://w3-03.ibm.com/ibm/privacy/index.html){: new_window} 提出请求，请求清除特定的文档 `_id` 值并阐明原因。
1. 当 {{site.data.keyword.IBM_notm}} DPO 收到正式请求时，{{site.data.keyword.cloudant_short_notm}} 运营人员会验证该请求以确认 `id` 是否包含 PI。{{site.data.keyword.cloudant_short_notm}} 不会清除 `_id` 中不包含 PI 的数据。 
1. {{site.data.keyword.cloudant_short_notm}} 会触发清除操作以永久除去请求的数据。

此过程仅用于紧急删除请求（例如，*被遗忘权*），不能长期依赖此过程。如果您的应用程序有意在文档标识中使用 PI，那么必须将其更改为使用假名保护该 PI，或者不在文档标识中使用该 PI。不能依赖于 {{site.data.keyword.cloudant_short_notm}} 运营团队定期清除来避免此问题。因此，{{site.data.keyword.cloudant_short_notm}} 会拒绝以下清除请求：

1. 定期清除请求，例如*每 30 天清除一次*。
1. 100 个以上文档的清除请求。

即便使用了清除，`_id` 字段中的 PI 也有可能会泄露到您不希望的位置，例如 {{site.data.keyword.cloudant_short_notm}} 日志，因此应避免在该字段中使用 PI。出于业务原因，{{site.data.keyword.cloudant_short_notm}} 会保留这些日志，并且不会除去包含文档 `_id` 值的日志行。

### 删除数据库是怎么回事？
{: #what-about-deleting-a-database-}

删除数据库会将数据库放入废纸箱中并保留最长 48 小时，在此时间后，会将其从文件系统中除去。{{site.data.keyword.cloudant_short_notm}} 团队*不会*备份您的数据库；此任务属于*客户的责任*。您必须确保从系统中除去了数据库的所有副本。有关更多信息，请参阅 [{{site.data.keyword.cloudant_short_notm}} 备份和恢复](/docs/services/Cloudant?topic=cloudant-ibm-cloudant-backup-and-recovery#ibm-cloudant-backup-and-recovery){: new_window}。 

如果需要其他帮助，请联系 [{{site.data.keyword.cloudant_short_notm}} 支持 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](mailto:support@cloudant.com)。

