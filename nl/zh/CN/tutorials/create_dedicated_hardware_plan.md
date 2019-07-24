---

copyright:
  years: 2015, 2019
lastupdated: "2019-06-12"

keywords: create dedicated hardware plan instance, provision standard plan instance, cli, create credentials, list service credentials

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

# 在 {{site.data.keyword.cloud_notm}} 上创建和利用 {{site.data.keyword.cloudant_short_notm}} 专用硬件套餐实例
{: #creating-and-leveraging-an-ibm-cloudant-dedicated-hardware-plan-instance-on-ibm-cloud}

本教程说明了如何使用 {{site.data.keyword.cloud}}“仪表板”创建一个 {{site.data.keyword.cloudantfull}} 专用硬件套餐实例，以及后续如何使用 {{site.data.keyword.cloud_notm}}“目录”或 {{site.data.keyword.cloud_notm}} CLI 供应一个或多个标准套餐实例以在该实例上运行。
{: shortdesc}

通过创建 {{site.data.keyword.cloudant_short_notm}} 专用硬件套餐实例，可以在专用硬件上供应 {{site.data.keyword.cloudant_short_notm}} 环境以供您独自使用。服务实例在 {{site.data.keyword.cloud_notm}}“仪表板”中创建，但您无法直接访问专用硬件套餐实例，并且不会有此实例的任何服务凭证。通过在创建的 {{site.data.keyword.cloudant_short_notm}} 专用硬件套餐实例上供应一个或多个标准套餐实例，可以使用此专用硬件套餐实例。

## 创建 {{site.data.keyword.cloudant_short_notm}} 专用硬件套餐实例
{: #creating-an-ibm-cloudant-dedicated-hardware-plan-instance}

1.  登录到 {{site.data.keyword.cloud_notm}} 帐户。<br/>
    在以下地址可以找到 {{site.data.keyword.cloud_notm}} 仪表板：[`https://cloud.ibm.com/ ` ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://cloud.ibm.com/){: new_window}。使用用户名和密码进行认证后，将显示 {{site.data.keyword.cloud_notm}} 仪表板。单击`创建资源`按钮：<br/>

    ![{{site.data.keyword.cloud_notm}}“仪表板”](images/img0001.png)

2.  单击菜单中的`数据库`，然后单击数据库服务列表中的 `Cloudant`。<br/>
     ![{{site.data.keyword.cloud_notm}} {{site.data.keyword.cloudant_short_notm}} 服务选择](images/img0003.png)<br/>

3.  从价格套餐列表中选择`专用硬件`套餐：<br/>
    ![价格套餐](images/pricing_plan.png)
    
4.  填写以下参数：<br/>
    -   输入服务名称。<br/>
    -   指定要在其中进行部署的区域/位置。该区域/位置将是要在其中部署实例的六个主要 {{site.data.keyword.cloud_notm}} 区域之一。实例的实际物理位置取决于以下列表中描述的位置参数。<br/>
    -   选择资源组。</br>
    -   添加标记。 
    -   选择部署位置。此位置是实例的物理位置，可以位于任何 {{site.data.keyword.cloud_notm}} 位置，包括主要区域和主要区域以外的位置。有关更多信息，请参阅 [{{site.data.keyword.IBM}} 全球数据中心 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://www.ibm.com/cloud/data-centers/){:new_window}。<br/>
    -   选择`是`或`否`以回答是否需要 HIPAA。<br/> 
    
    HIPAA 仅适用于美国的位置。{{site.data.keyword.IBM}} 可以供应专用硬件套餐环境，以实施 HIPAA 控制。仅当确认与 {{site.data.keyword.IBM_notm}} 签订了“业务伙伴协议”(BAA) 时，才会供应环境。请参阅[启用欧盟支持和支持 HIPAA 设置](https://cloud.ibm.com/docs/account/eu_hipaa_supported.html#enabling-the-hipaa-supported-setting)和服务说明条款，以获取更多详细信息。供应集群以管理 HIPAA 数据所用的时间可能会超过估算的 5 天。
    {: note}

    ![配置专用硬件](images/select_deployment_location.png)
        
5.  单击`创建`按钮以启动供应过程。<br/>

    每天按比例计费，因此在单击**创建**按钮之前，请确认您要针对环境供应和付费。
    {: note}

    ![供应专用硬件](images/create_button_provision.png)

    供应期间，在 {{site.data.keyword.cloud_notm}}“仪表板”中该实例旁会显示一个纺车。系统将发送一个请求以在裸机服务器上供应专用硬件套餐实例。供应时间是异步的，可能需要最多 5 天的时间。
    {: note}   

    ![供应专用硬件备用版本](images/create_button_provision2.png)
    
## 在专用硬件环境上供应标准套餐实例
{: #provisioning-a-standard-plan-instance-on-a-dedicated-hardware-environment}

1.  登录到 {{site.data.keyword.cloud_notm}} 帐户。<br/>
    在以下地址可以找到 {{site.data.keyword.cloud_notm}} 仪表板：[https://cloud.ibm.com/ ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://cloud.ibm.com/){: new_window}。使用用户名和密码进行认证后，将显示 {{site.data.keyword.cloud_notm}} 仪表板。单击`创建资源`按钮：<br/>
    ![{{site.data.keyword.cloud_notm}}“仪表板”](images/img0001.png)

2.  单击菜单中的`数据库`，然后单击数据库服务列表中的 `Cloudant`。<br/>
     ![{{site.data.keyword.cloud_notm}} {{site.data.keyword.cloudant_short_notm}} 服务选择](images/img0003.png)<br/>
    这将显示用于创建服务的页面。<br/>  

3.  单击价格套餐中的`标准`。<br/>
    ![标准价格套餐](images/standard_pricing_plan.png)
    
    无法在专用硬件环境上供应轻量套餐实例。
    {: tip}
    
4.  填写以下参数：<br/>
    -   输入服务名称。<br/>
    -   指定要在其中进行部署的区域/位置。<br/>
    -   选择资源组。</br>
    -   添加标记。 
    -   选择认证方法。</br>
    -   选择将在其中部署标准套餐实例的环境。如果部署在帐户中的任何专用硬件环境实例可用，那么这些实例会显示在下拉列表中。</br>
    ![配置标准实例](images/select_environment.png)
    
5.  单击`创建`按钮。<br/>
    几秒后，将在所选环境中供应该实例。<br/>
    ![供应标准实例](images/create_button_provision_standard.png)
    
6.  获取服务凭证，然后访问 {{site.data.keyword.cloudant_short_notm}}“仪表板”（如同针对多租户 {{site.data.keyword.cloudant_short_notm}} 实例那样）。
     
    
    有关更多信息，请参阅[如何查找服务凭证](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud#locating-your-service-credentials){: new_window}。 
    
## 使用 {{site.data.keyword.cloud_notm}} CLI 在专用硬件环境上供应标准套餐实例
{: #provisioning-a-standard-plan-instance-on-a-dedicated-hardware-environment-with-the-ibm-cloud-cli}

要使用 {{site.data.keyword.cloud_notm}} CLI，您必须登录。有关如何登录和设置目标资源组的更多信息，请参阅[登录到 {{site.data.keyword.cloud_notm}} 帐户](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud-by-using-the-ibm-cloud-cli#logging-in-to-your-ibm-cloud-account){: new_window}。 

要在 {{site.data.keyword.cloudant_short_notm}} 专用硬件套餐环境中创建 {{site.data.keyword.cloudant_short_notm}} 标准套餐实例，基本命令格式如下所示：


字段            |描述
------|------------
`NAME`|为实例指定的任意名称。
`SERVICE_NAME`|`cloudantnosqldb`
`PLAN_NAME`|标准套餐
`LOCATION`|要在其中进行部署的位置，例如，us-south、us-east 或 eu-gb。

请参阅以下示例命令： 

```sh
ibmcloud resource service-instance-create NAME SERVICE_NAME SERVICE_PLAN_NAME LOCATION [-p, --parameters @JSON_FILE | JSON_STRING ]
```
{: codeblock}

在专用硬件环境上部署的 {{site.data.keyword.cloudant_short_notm}} 实例还需要另外两个参数：

参数|描述
----------|------------
`environment_crn`|此参数必须设置为 {{site.data.keyword.cloudant_short_notm}} 专用硬件套餐实例的 CRN。可通过在 {{site.data.keyword.cloud_notm}}“仪表板”中查看 {{site.data.keyword.cloudant_short_notm}} 专用硬件套餐实例的“管理”选项卡中的示例 CLI 命令，确定 CRN 的内容。或者，可以使用 `ibmcloud resource service-instance SERVICE_INSTANCE_NAME` 命令来确定 CRN 的内容。
`legacyCredentials`|可选参数，缺省为 true，指示实例是同时使用旧凭证和 IAM 凭证还是仅使用 IAM 凭证。有关选择认证方法的更多详细信息，请参阅 [IAM 指南](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-)。

请参阅以下示例命令： 

```sh
ibmcloud resource service-instance-create cloudant_on_ded_hardware_cli cloudantnosqldb standard us-south -p '{"environment_crn":"crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b43434444bb7e2abb0841ca25d28ee4c:301a3118-7678-4d99-b1b7-4d45cf5f7b29::","legacyCredentials":false}'
```
{: codeblock}

## 为 {{site.data.keyword.cloudant_short_notm}} 服务创建凭证
{: #creating-the-credentials-for-your-ibm-cloudant-service}

需要访问 {{site.data.keyword.cloudant_short_notm}} 服务的应用程序必须具有必要的凭证。

服务凭证十分重要。如果任何人或任何应用程序有权访问凭证，那么就能使用服务实例有效地执行所需的一切操作。例如，可能会创建虚假数据，或删除有价值的信息。因此，请谨慎保护这些凭证。

{: important}

有关服务凭证中所包含字段的更多信息，请参阅 [IAM 指南](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-)。

用于在 {{site.data.keyword.cloud_notm}} 中为服务实例创建凭证的基本命令格式如下所示：

```sh
ibmcloud resource service-key-create NAME ROLE_NAME --instance-name SERVICE_INSTANCE_NAME [-p '{"service-endpoints":"internal"}]
```
{: pre}

下表中描述了各个字段：

字段            |描述
------|------------
`NAME`|为服务凭证提供的任意名称。
`ROLE_NAME`|目前此字段仅允许“管理者”角色。
`SERVICE_INSTANCE_NAME`|为 {{site.data.keyword.cloudant_short_notm}} 实例提供的名称。
`service-endpoints`|可选参数，用于使用内部端点填充服务凭证中的 URL 字段，以通过 {{site.data.keyword.cloud_notm}} 内部网络连接到服务。如果省略此参数，将使用可公共访问的外部端点填充 URL。仅适用于在支持内部端点的专用硬件环境上部署的标准套餐实例。如果环境不支持内部端点，那么该命令将导致 400 错误。

如果要为 {{site.data.keyword.cloudant_short_notm}} 服务的 `cs20170517a` 实例创建凭证（其中，凭证的名称为 `creds_for_cs20170517a`），您可使用类似于以下示例的命令来创建这些凭证：

```sh
ibmcloud resource service-key-create creds_for_cs20170517a Manager --instance-name cs20170517a
```
{: codeblock}

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
{: pre}

如果要为 {{site.data.keyword.cloudant_short_notm}} 服务的 `cs20170517a` 实例创建凭证（其中，凭证的名称为 `creds_for_cs20170517a`）并要使用内部端点填充 url，您可使用类似于以下示例的命令来创建这些凭证：

```sh
ibmcloud resource service-key-create creds_for_cs20170517a Manager --instance-name cs20170517a -p '{"service-endpoints":"internal"}'
```
{: codeblock}

收到为服务实例创建凭证的请求后，{{site.data.keyword.cloud_notm}} 会使用类似于以下示例的消息进行响应：

```sh
Creating service key in resource group default of account John Does's Account as john.doe@email.com...
OK
Service key crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42223455bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3:resource-key:621ffde2-ea10-4318-b297-d6d849cec48a was created.
                  
Name:          creds_for_cs20170517a   
ID:            crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42223455bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3:resource-key:621ffde2-ea10-4318-b297-d6d849cec48a   
Created At:    Tue Jan 02 19:58:38 UTC 2019   
State:         active   
Credentials:                                   
               iam_apikey_name:          auto-generated-apikey-621ffde2-ea10-4318-b297-d6d849cec48a      
               iam_role_crn:             crn:v1:bluemix:public:iam::::serviceRole:Manager      
               url:                      https://2624fed5-e53e-41de-a85b-3c7d7636886f-bluemix.private.cloudantnosqldb.appdomain.cloud      
               username:                 f6cf0c55-48ea-4908-b441-a962b27d3bb6-bluemix          
               apikey:                   XXXXX-XXXXXX_XXXXXXXXXXXXX-XXXXXXXXXXX      
               host:                     2624fed5-e53e-41de-a85b-3c7d7636886f-bluemix.private.cloudantnosqldb.appdomain.cloud      
               iam_apikey_description:   Auto generated apikey during resource-key operation for Instance - crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b42116849bb7e2abb0841ca25d28ee4c:ee78351d-82bf-4e80-bc22-825c937fafa3::      
               iam_serviceid_crn:        crn:v1:bluemix:public:iam-identity::a/b42116849bb7e2abb0841ca25d28ee4c::serviceid:ServiceId-53f9e2a2-cdfb-4f90-b072-bfffafb68b3e       
```
{: pre}

## 列出 {{site.data.keyword.cloudant_short_notm}} 服务的服务凭证
{: #listing-the-service-credentials-for-your-ibm-cloudant-service}

用于在 {{site.data.keyword.cloud_notm}} 中检索服务实例凭证的基本命令格式如下所示：

```sh
ibmcloud resource service-key KEY_NAME
```
{: codeblock}

在此示例中，我们要检索 {{site.data.keyword.cloudant_short_notm}} 服务的 `cs20170517a` 实例的凭证（其中，凭证的名称为 `creds_for_cs20170517a`），您可使用类似于以下示例的命令来检索这些凭证：

```sh
ibmcloud resource service-key creds_for_cs20170517b
```
{: codeblock}

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
{: pre}
