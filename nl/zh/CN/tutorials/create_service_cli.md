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

<!-- Acrolinx: 2018-08-20 -->

# 使用 {{site.data.keyword.cloud_notm}} CLI 在 {{site.data.keyword.cloud_notm}} 上创建 {{site.data.keyword.cloudant_short_notm}} 实例

本教程说明了如何使用 {{site.data.keyword.cloud_notm}} CLI 在 {{site.data.keyword.cloud}} 上创建 {{site.data.keyword.cloudantfull}} 服务实例。
{:shortdesc}

## 先决条件 

要学习本教程，必须先安装 {{site.data.keyword.cloud_notm}} CLI Developer Tools。有关安装这些工具的更多信息，请参阅 [{{site.data.keyword.cloud_notm}} CLI 入门 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://console.bluemix.net/docs/cli/index.html#overview){:new_window} 教程。

## 确定 {{site.data.keyword.cloud_notm}} API 端点

指定 {{site.data.keyword.cloud_notm}} 命令的目标 API 端点：

```sh
ibmcloud api https://api.ng.bluemix.net
```
{:codeblock}

以下结果确认您已正确地确定端点：

```sh
Setting api endpoint to https://api.ng.bluemix.net...
OK

API endpoint: https://api.ng.bluemix.net (API version: 2.54.0)
Not logged in. Use 'ibmcloud login' to log in.
```
{:pre}

## 登录到 {{site.data.keyword.cloud_notm}} 帐户

以下示例描述了登录过程。如果您使用的是联合用户标识，请务必切换到一次性通行码 (`ibmcloud login --sso`)，或者使用 API 密钥（`ibmcloud --apikey key 或 @key_file`）进行认证。有关如何使用 CLI 登录的更多信息，请参阅[常规 CLI (ibmcloud) 命令 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://console.bluemix.net/docs/cli/reference/ibmcloud/bx_cli.html#ibmcloud_login){:new_window} 中 `ibmcloud login` 下的内容。 

1.  使用以下命令启动 {{site.data.keyword.cloud_notm}} 帐户的登录过程：
  
  ```sh
  ibmcloud login
  ```
  {:codeblock}
  
  {{site.data.keyword.cloud_notm}} 在响应中会提醒您当前的 API 端点，然后要求您输入帐户的电子邮件地址：
  
  ```sh
  API endpoint: https://api.ng.bluemix.net
  
  Email>
  ```
  {:pre}

2.  输入您帐户的电子邮件地址，然后输入您的密码：

  ```sh
  API endpoint: https://api.ng.bluemix.net
  
  Email> J.Doe@email.com
  
  Password>
  ```
  {:pre}
  
  {{site.data.keyword.cloud_notm}} 会验证您的详细信息，然后汇总有关您的登录会话的信息：

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

3.  现在，您已登录到 {{site.data.keyword.cloud_notm}} 帐户。

## 为服务选择 {{site.data.keyword.cloudant_short_notm}} 套餐

有关使用 {{site.data.keyword.cloudant_short_notm}} 轻量套餐或标准套餐的详细信息，请参阅本文档的[套餐 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://console.bluemix.net/docs/services/Cloudant/offerings/bluemix.html#plans){:new_window} 部分。
{:pre}

## 创建 {{site.data.keyword.cloudant_short_notm}} 服务

{{site.data.keyword.cloudant_short_notm}} 使用资源组（而不是 Cloud Foundry 组织和空间）来供应新实例。过去供应的 {{site.data.keyword.cloudant_short_notm}} 实例仍可部署在 Cloud Foundry 组织和空间中。有关更多信息，请参阅 [IBM Cloudant 如何使用 IBM Cloud 资源组？![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://console.bluemix.net/docs/services/Cloudant/guides/resource-groups.html#how-does-ibm-cloudant-work-with-ibm-cloud-resource-groups-){:new_window} 指南。

首先，如[常规 CLI (ibmcloud) 命令 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://console.bluemix.net/docs/cli/reference/ibmcloud/bx_cli.html#ibmcloud_target){:new_window} 中 `ibmcloud target` 下的内容所示，使用以下格式设置目标资源组和区域：

```sh
ibmcloud target [-r REGION_NAME] [-g RESOURCE_GROUP]
```

要获取区域列表，请运行以下命令：

```sh
ibmcloud regions
```

要获取资源组列表，请运行以下命令： 

```sh
ibmcloud resource groups
```

其次，要创建服务实例，{{site.data.keyword.cloud_notm}} 中的基本命令格式如下所示：

```sh
ibmcloud resource service-instance-create NAME SERVICE_NAME|SERVICE_ID SERVICE_PLAN_NAME|SERVICE_PLAN_ID LOCATION [-p, --parameters @JSON_FILE | JSON_STRING ]
```
{:pre}

下表中描述了各个字段： 


字段       |描述
------|------------
`NAME`|为实例提供的任意名称。
`SERVICE_NAME`|`cloudantnosqldb`
`PLAN_NAME`|轻量套餐或标准套餐。
`LOCATION`|要在其中进行部署的位置：亚太地区北部、德国、全球、悉尼、英国、美国东部或美国南部。
`legacyCredentials`|缺省值为 true。此字段指示实例是同时使用旧凭证和 IAM 凭证还是仅使用 IAM 凭证。

有关选择认证方法的更多信息，请参阅 [IAM 指南](../guides/iam.html#ibm-cloud-identity-and-access-management-iam-){:new_window}。

在此示例中，我们要使用`轻量`套餐（其中，实例名称为美国南部位置中的 `cs20170517a`，并且仅使用 IAM 凭证）来创建 {{site.data.keyword.cloudant_short_notm}} 服务的实例，您可使用类似于以下示例的命令来创建此实例：

```sh
ibmcloud resource service-instance-create cs20170517a cloudantnosqldb lite us-south -p '{"legacyCredentials": false}'
```
{:codeblock}

创建服务实例后，{{site.data.keyword.cloud_notm}} 会使用类似于以下示例的消息进行响应：

```sh
Creating service instance cs20170517a in resource group default of account John Does's Account as j.doe@email.com...
OK
Service instance cs20170517a was created.
Name          Location   State    Type               Tags   
cs20170517a   us-south   active   service_instance  
```
{:pre}

## 为 {{site.data.keyword.cloudant_short_notm}} 服务创建凭证

需要访问 {{site.data.keyword.cloudant_short_notm}} 服务的应用程序必须具有必要的凭证。

服务凭证十分重要。如果任何人或任何应用程序有权访问凭证，那么就能使用服务实例有效地执行所需的一切操作。例如，可能会创建虚假数据，或删除有价值的信息。因此，请谨慎保护这些凭证。

{: tip}

有关服务凭证中所包含字段的更多信息，请参阅 [IAM 指南](../guides/iam.html#ibm-cloud-identity-and-access-management-iam-){:new_window}。

用于在 {{site.data.keyword.cloud_notm}} 中为服务实例创建凭证的基本命令格式如下所示：

```sh
ibmcloud resource service-key-create NAME ROLE_NAME --instance-name SERVICE_INSTANCE_NAME
```
{:pre}

下表中描述了各个字段：

字段       |描述
------|------------
`NAME`|为服务凭证提供的任意名称。
`ROLE_NAME`|目前此字段仅允许“管理者”角色。
`SERVICE_INSTANCE_NAME`|为 {{site.data.keyword.cloudant_short_notm}} 实例提供的名称。

如果要为 {{site.data.keyword.cloudant_short_notm}} 服务的 `cs20170517a` 实例创建凭证（其中，凭证的名称为 `creds_for_cs20170517a`），您可使用类似于以下示例的命令来创建这些凭证：

```sh
ibmcloud resource service-key-create creds_for_cs20170517a Manager --instance-name cs20170517a
```
{:codeblock}
收到为服务实例创建凭证的请求后，{{site.data.keyword.cloud_notm}} 会使用类似于以下示例的消息进行响应：

```sh
Creating service key in resource group default of account John Does's Account as john.doe@email.com...
OK
Service key crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42223455bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3:resource-key:621ffde2-ea10-4318-b297-d6d849cec48a was created.
                  
Name:          creds_for_cs20170517a   
ID:            crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42223455bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3:resource-key:621ffde2-ea10-4318-b297-d6d849cec48a   
Created At:    Tue Sep 18 19:58:38 UTC 2018   
State:         active   
Credentials:                                   
               iam_apikey_name:          auto-generated-apikey-621ffde2-ea10-4318-b297-d6d849cec48a      
               iam_role_crn:             crn:v1:bluemix:public:iam::::serviceRole:Manager      
               url:                      https://f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix:5811381f6daff7255b288695c3544be63f550e975bcde46799473e69c7d48d61@f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix.cloudant.com      
               username:                 f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix      
               port:                     443      
               apikey:                   XXXXX-XXXXXX_XXXXXXXXXXXXX-XXXXXXXXXXX      
               host:                     f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix.cloudant.com      
               iam_apikey_description:   Auto generated apikey during resource-key operation for Instance - crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42116849bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3::      
               iam_serviceid_crn:        crn:v1:bluemix:public:iam-identity::a/b42116849bb7e2abb0841ca25d28ee4c::serviceid:ServiceId-53f9e2a2-cdfb-4f90-b072-bfffafb68b3e      
               password:                 581138...7d48d61 
```
{:pre}

## 列出 {{site.data.keyword.cloudant_short_notm}} 服务的服务凭证

用于在 {{site.data.keyword.cloud_notm}} 中检索服务实例凭证的基本命令格式如下所示：

```sh
ibmcloud resource service-key KEY_NAME
```
{:pre}

在此示例中，我们要检索 {{site.data.keyword.cloudant_short_notm}} 服务的 `cs20170517a` 实例的凭证（其中，凭证的名称为 `creds_for_cs20170517a`），您可使用类似于以下示例的命令来检索这些凭证：

```sh
ibmcloud resource service-key creds_for_cs20170517b
```
{:codeblock}

收到检索服务实例凭证的请求后，{{site.data.keyword.cloud_notm}} 会使用类似于以下示例（缩略版）的消息进行响应：

```sh
Retrieving service key in resource group default of account John Does's Account as john.doe@email.com...
OK
Service key crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42223455bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3:resource-key:621ffde2-ea10-4318-b297-d6d849cec48a was created.
                  
Name:          creds_for_cs20170517a   
ID:            crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42223455bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3:resource-key:621ffde2-ea10-4318-b297-d6d849cec48a   
Created At:    Tue Sep 18 19:58:38 UTC 2018   
State:         active   
Credentials:                                   
               iam_apikey_name:          auto-generated-apikey-621ffde2-ea10-4318-b297-d6d849cec48a      
               iam_role_crn:             crn:v1:bluemix:public:iam::::serviceRole:Manager      
               url:                      https://f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix:5811381f6daff7255b288695c3544be63f550e975bcde46799473e69c7d48d61@f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix.cloudant.com      
               username:                 f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix      
               port:                     443      
               apikey:                   XXXXX-XXXXXX_XXXXXXXXXXXXX-XXXXXXXXXXX      
               host:                     f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix.cloudant.com      
               iam_apikey_description:   Auto generated apikey during resource-key operation for Instance - crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42116849bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3::      
               iam_serviceid_crn:        crn:v1:bluemix:public:iam-identity::a/b42116849bb7e2abb0841ca25d28ee4c::serviceid:ServiceId-53f9e2a2-cdfb-4f90-b072-bfffafb68b3e      
               password:                 581138...7d48d61 
```
{:pre}

## 使用 {{site.data.keyword.cloudant_short_notm}} 服务实例

现在，您已完成以下任务：

1.  已在 {{site.data.keyword.cloud_notm}} 中创建 {{site.data.keyword.cloudant_short_notm}} 服务实例。
2.  已为 {{site.data.keyword.cloudant_short_notm}} 服务实例创建凭证。
3.  已检索到服务实例凭证，使其可供应用程序使用。

有关更多信息，请参阅[在 {{site.data.keyword.cloud_notm}} 上创建并填充简单 {{site.data.keyword.cloudant_short_notm}} 数据库](../tutorials/create_database.html#context){:new_window}教程，其中说明了如何使用旧凭证在 Python 应用程序中使用 {{site.data.keyword.cloudant_short_notm}} 服务实例。请记得替换您在本教程中创建的凭证。

## （可选）后续整理

以下简短的命令列表可能有助于整理开发环境。

### 删除服务凭证

要删除一组服务凭证，请使用类似于以下内容的命令：

```sh
ibmcloud resource service-key-delete KEY_NAME
```
{:pre}

例如，要删除名为 `creds_for_cs20170517a` 的凭证，请使用类似于以下内容的命令：

```sh
ibmcloud resource service-key-delete creds_for_cs20170517a
```
{:pre}

### 删除服务实例

要删除服务实例，请使用类似于以下内容的命令：

```sh
ibmcloud resource service-instance-delete SERVICE_INSTANCE_NAME
```
{:pre}

例如，要删除 {{site.data.keyword.cloudant_short_notm}} 服务的 `cs20170517a` 实例，请使用类似于以下内容的命令：

```sh
ibmcloud resource service-instance-delete cs20170517a
```
{:pre}

