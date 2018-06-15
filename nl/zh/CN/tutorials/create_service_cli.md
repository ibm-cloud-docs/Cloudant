---

copyright:
  years: 2017, 2018
lastupdated: "2018-03-07"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

# 使用 Cloud Foundry 工具在 {{site.data.keyword.Bluemix_notm}} 上创建 {{site.data.keyword.cloudant_short_notm}} 实例

本教程说明了如何使用 Cloud Foundry 工具在 {{site.data.keyword.Bluemix}} 上创建 {{site.data.keyword.cloudantfull}} 服务实例。
{:shortdesc}

## 先决条件

要学习本教程，必须先安装 {{site.data.keyword.Bluemix_notm}} Cloud Foundry 工具。[本单独教程](create_bmxapp_appenv.html#the-cloud-foundry-and-bluemix-command-toolkits)中提供了有关安装这些工具的详细信息。

> **注**：确保安装了 Cloud Foundry _和_ {{site.data.keyword.Bluemix_notm}} 工具箱。

## 确定 {{site.data.keyword.Bluemix_notm}} API 端点

指定 Cloud Foundry 命令的目标 API 端点；

```sh
bx api https://api.ng.bluemix.net
```
{:codeblock}

结果确认您已正确确定端点：

```sh
Setting api endpoint to https://api.ng.bluemix.net...
OK

API endpoint: https://api.ng.bluemix.net (API version: 2.54.0)
Not logged in. Use 'bx login' to log in.
```
{:pre}

## 登录到 {{site.data.keyword.Bluemix_notm}} 帐户

1.  使用以下命令启动 {{site.data.keyword.Bluemix_notm}} 帐户的登录过程：
  
  ```sh
  bx login
  ```
  {:codeblock}
  
  {{site.data.keyword.Bluemix_notm}} 在回复中会提醒您当前的 API 端点，然后要求您输入帐户的电子邮件地址：
  
  ```sh
  API endpoint: https://api.ng.bluemix.net
  
  Email>
  ```
  {:pre}

2.  输入您帐户的电子邮件地址。然后，{{site.data.keyword.Bluemix_notm}} 会要求您输入帐户的密码：
  ```sh
  API endpoint: https://api.ng.bluemix.net
  
  Email> J.Doe@email.com
  
  Password>
  ```
  {:pre}
  
  {{site.data.keyword.Bluemix_notm}} 会验证您的详细信息，然后汇总有关您的登录会话的信息：
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

3.  现在，您已登录到 {{site.data.keyword.Bluemix_notm}} 帐户。

## 为服务选择 {{site.data.keyword.cloudant_short_notm}} 套餐

获取所有可用服务产品的列表。过滤列表以便只匹配 {{site.data.keyword.cloudant_short_notm}} 服务：

```sh
bx service offerings | grep -i Cloudant
```
{:codeblock}

结果会列出可供您帐户使用的 {{site.data.keyword.cloudant_short_notm}} 服务，包括可以选择的特定套餐：

```sh
cloudantNoSQLDB   Lite, Standard*
```
{:pre}

**可选**：要查看有关套餐的更多详细信息，请使用以下命令：

```sh
bx cf marketplace -s cloudantNoSQLDB
```
{:codeblock}

结果会显示可用套餐的摘要，类似于以下示例响应部分（详细信息对应的是 2017 年 5 月）：

```
Lite
The Lite plan provides access to the full functionality of {{site.data.keyword.cloudant_short_notm}} for development and evaluation.
The plan has a set amount of provisioned throughput capacity as shown
and includes a max of 1GB of encrypted data storage.   free
```
{:pre}

## 创建 {{site.data.keyword.cloudant_short_notm}} 服务

用于在 {{site.data.keyword.Bluemix_notm}} 中创建服务实例的基本命令格式如下所示：

```sh
bx service create <service> <plan> <instance name>
```
{:pre}

假定要使用 `Lite` 套餐来创建 {{site.data.keyword.cloudant_short_notm}} 服务的实例，其中实例名称为 `cs20170517a`。

使用类似于以下示例的命令来执行此操作：

```sh
bx service create cloudantNoSQLDB Lite cs20170517a
```
{:codeblock}

创建服务实例后，会使用类似于以下示例的消息进行响应：

```sh
Invoking 'cf create-service cloudantNoSQLDB Lite cs20170517a'...

Creating service instance cs20170517a in org J.Doe@email.com / space dev as J.Doe@email.com...
OK

```
{:pre}

## 为 {{site.data.keyword.cloudant_short_notm}} 服务创建凭证

需要访问 {{site.data.keyword.cloudant_short_notm}} 服务的应用程序必须具有必要的凭证。

>   **注**：服务凭证十分重要。
如果任何人或任何应用程序有权访问凭证，那么就能使用服务实例有效地执行所需的一切操作，例如可以创建伪造数据或删除宝贵的信息。因此，请谨慎保护这些凭证。



服务凭证由五个字段组成：

字段       | 用途
-----------|--------
`host`     | 应用程序用于查找服务实例的主机名。
`username` | 应用程序访问服务实例所需的用户名。
`password` | 应用程序访问服务实例所需的密码。
`port`     | 用于访问主机上服务实例的 HTTP 端口号。通常为 443，可强制执行 HTTPS 访问。
`url`      | 将其他凭证信息聚集到单个 URL 中（使其适合应用程序使用）的字符串。

用于在 {{site.data.keyword.Bluemix_notm}} 中为服务实例创建凭证的基本命令格式如下所示：

```sh
bx cf create-service-key <instance name> <credentials name>
```
{:pre}

假定要为 {{site.data.keyword.cloudant_short_notm}} 服务的 `cs20170517a` 实例创建凭证，其中凭证的名称为 `creds20170517a`。

使用类似于以下示例的命令来执行此操作：

```sh
bx cf create-service-key cs20170517a creds20170517a
```
{:codeblock}

收到为服务实例创建凭证的请求后，{{site.data.keyword.Bluemix_notm}} 会使用类似于以下示例的消息进行响应：

```sh
Invoking 'cf create-service-key cs20170517a creds20170517a'...

Creating service key creds20170517a for service instance cs20170517a as J.Doe@email.com...
OK
```
{:pre}

## 列出 {{site.data.keyword.cloudant_short_notm}} 服务的服务凭证

用于在 {{site.data.keyword.Bluemix_notm}} 中检索服务实例凭证的基本命令格式如下所示：

```sh
bx cf service-key <instance name> <credentials name>
```
{:pre}

假定要检索 {{site.data.keyword.cloudant_short_notm}} 服务的 `cs20170517a` 实例的凭证，其中凭证的名称为 `creds20170517a`。

使用类似于以下示例的命令来执行此操作：

```sh
bx cf service-key cs20170517a creds20170517a
```
{:codeblock}

收到检索服务实例凭证的请求后，{{site.data.keyword.Bluemix_notm}} 会使用类似于以下（缩写）示例的消息进行响应：

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

## 使用 {{site.data.keyword.cloudant_short_notm}} 服务实例

此时，您已经执行了以下操作：

1.  已在 {{site.data.keyword.Bluemix_notm}} 中创建 {{site.data.keyword.cloudant_short_notm}} 服务实例。
2.  已为 {{site.data.keyword.cloudant_short_notm}} 服务实例创建凭证。
3.  已检索到服务实例凭证，使其可供应用程序使用。

[此处](create_database.html#context)提供了说明如何使用 {{site.data.keyword.cloudant_short_notm}} 服务实例的教程。请记得替换在本教程中创建的凭证。

## （可选）后续整理

以下简短命令列表可能对您整理开发环境非常有用。

### 删除服务凭证

要删除一组服务凭证，请使用类似于下面的命令：

```sh
bx cf delete-service-key <instance name> <credentials name>
```
{:pre}

例如，要从 {{site.data.keyword.cloudant_short_notm}} 服务的 `cs20170517a` 实例中删除名为 `creds20170517a` 的凭证，可以使用类似于下面的命令：

```sh
bx cf delete-service-key cs20170517a creds20170517a
```
{:pre}

### 删除服务实例

要删除服务实例，请使用类似于下面的命令：

```sh
bx service delete <instance name>
```
{:pre}

例如，要删除 {{site.data.keyword.cloudant_short_notm}} 服务的 `cs20170517a` 实例，可以使用类似于下面的命令：

```sh
bx service delete cs20170517a
```
{:pre}

