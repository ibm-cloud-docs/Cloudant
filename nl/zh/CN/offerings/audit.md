---

copyright:
  years: 2015, 2019
lastupdated: "2019-06-12"

keywords: principal, action, resource, timestamp, access audit logs

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

# 审计日志记录
{: #audit-logging}

审计日志记录用于记录哪些 {{site.data.keyword.cloudantfull}} 主体访问了 {{site.data.keyword.cloudant_short_notm}} 中存储的数据。对于所有对 {{site.data.keyword.cloudant_short_notm}} 的 HTTP API 访问，审计日志记录功能会记录有关每个 HTTP 请求的以下信息：

信息|描述
------------|------------
`主体`|帐户凭证、API 密钥或 IBM Cloud IAM 凭证。
`操作`|所执行的操作（例如，文档读取）。
`资源`|有关所访问的帐户、数据库和文档或所运行的查询的详细信息。
`时间戳记`|对事件时间和日期的记录。
{: shortdesc}

{{site.data.keyword.cloudant_short_notm}} 审计日志可用于了解：

- 访问了帐户中的哪些数据库和文档以及访问时间和访问者。
- 运行了哪些查询以及运行时间和运行者。
- 访问、更新或删除了哪个特定主体或用户以及执行这些操作的时间。
- 创建或删除了哪些复制文档以及执行这些操作的时间。



## 如何访问帐户的审计日志
{: #how-to-access-audit-logs-for-your-account}

要请求访问帐户的审计日志，请联系 {{site.data.keyword.cloudant_short_notm}} 支持人员。支持人员可提供您关注的审计日志的副本。

联系支持人员时，请务必提供以下信息：

- 与请求相关的 {{site.data.keyword.cloudant_short_notm}} 帐户。
- 审计日志的时间范围（每个支持请求要求访问的审计日志不能超过一个月）。
- 任何相关的特定数据库、文档或主体。
