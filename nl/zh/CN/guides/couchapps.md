---

copyright:
  years: 2015, 2018
lastupdated: "2018-10-24"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2018-05-07 -->

# CouchApp

{{site.data.keyword.cloudantfull}} 可以托管原始文件数据（例如图像），并通过 HTTP 提供这些数据，这意味着它可以托管运行 Web 站点所需的所有静态文件，托管方式与 Web 服务器一样。
{:shortdesc}

由于这些文件将在 {{site.data.keyword.cloudant_short_notm}} 上托管，因此客户端 JavaScript 可以访问 {{site.data.keyword.cloudant_short_notm}} 数据库。通过这种方法构建的应用程序称为具有两层体系结构，由客户端（通常是浏览器）和数据库组成。在 CouchDB 社区中，这种应用程序称为 CouchApp。

大多数 Web 应用程序有三层：客户端、服务器和数据库。将服务器放置在客户端与数据库之间有助于执行认证、授权、资产管理、利用第三方 Web API、提供特别复杂的端点等。通过这种分隔方式，可以增加复杂性，而不会混淆关注点，这样客户端能自始至终关注数据表示，而数据库可以专注于存储和提供数据。

CouchApp 的突出优点是简单，但 Web 应用程序经常需要 3 层体系结构的能力。这两种应用程序分别适用于哪些情况呢？

## 对于以下情况，CouchApp 适用...

-   任何情况下，服务器都只向 {{site.data.keyword.cloudant_short_notm}} 提供 API。
-   您愿意使用 {{site.data.keyword.cloudant_short_notm}} 的[基于 cookie 的认证](../api/authentication.html)。
-   您愿意使用 {{site.data.keyword.cloudant_short_notm}} 的 [`_users` 和 `_security`](../api/authorization.html) 数据库来管理用户和许可权。
-   您无需安排 cron 作业或其他常规任务。

要开始使用 CouchApp，请阅读[管理 {{site.data.keyword.cloudant_short_notm}} 上的应用程序 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://cloudant.com/blog/app-management/){:new_window}。

## 对于以下情况，3 层应用程序适用...

-   您需要超过 `_security` 数据库所允许程度的细颗粒度的许可权。
-   您需要除基本认证或 cookie 认证以外的其他认证方法，例如 Oauth 或第三方登录系统。
-   您需要安排客户端外部的任务定期运行。

您可以使用最适合您的任何技术来编写服务器层。[提供了](../libraries/index.html)用于 {{site.data.keyword.cloudant_short_notm}} 的库的列表。
