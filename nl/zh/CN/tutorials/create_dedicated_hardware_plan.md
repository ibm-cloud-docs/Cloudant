---

copyright:
  years: 2015, 2018
lastupdated: "2017-11-07"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-02-23 -->

# 在 {{site.data.keyword.Bluemix_notm}} 上创建和利用 {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware 套餐实例

本教程说明了如何使用 {{site.data.keyword.Bluemix}} 仪表板来创建 {{site.data.keyword.cloudantfull}} Dedicated Hardware 套餐实例，以及后续如何供应一个或多个标准套餐实例以在其上运行。
 

创建 {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware 套餐实例会在专用硬件上供应 {{site.data.keyword.cloudant_short_notm}} 环境以仅供您独自使用。服务实例在 {{site.data.keyword.Bluemix_notm}} 仪表板中创建，但请注意，您无法直接访问 Dedicated Hardware 套餐实例，并且不会具有针对此实例的任何服务凭证。在创建 {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware 套餐实例（通过在其上供应一个或多个标准套餐实例）后，可以使用此实例。

## 创建 {{site.data.keyword.cloudant_short_notm}} Dedicated Hardware 套餐实例

1.  登录到 {{site.data.keyword.Bluemix_notm}} 帐户。<br/>
{{site.data.keyword.Bluemix_notm}}“仪表板”位于 [http://bluemix.net ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](http://bluemix.net){:new_window}。使用用户名和密码进行认证后，将显示 {{site.data.keyword.Bluemix_notm}}“仪表板”：<br/>
    ![{{site.data.keyword.Bluemix_notm}}“仪表板”](images/img0001.png)

2.  单击`目录`链接：<br/>
    ![{{site.data.keyword.Bluemix_notm}}“目录”链接](images/img0002.png)<br/>
这将显示 {{site.data.keyword.Bluemix_notm}} 上可用服务的列表。

3.  单击`服务`标题下的`数据和分析`条目：<br/>
    ![{{site.data.keyword.Bluemix_notm}}“数据和分析”服务](images/img0003.png)<br/>
这将显示 {{site.data.keyword.Bluemix_notm}} 上可用“数据和分析”服务的列表。

4.  单击 {{site.data.keyword.cloudant_short_notm}} 服务：<br/>
    ![ {{site.data.keyword.Bluemix_notm}} {{site.data.keyword.cloudant_short_notm}} 服务选择](images/img0004.png)<br/>
将显示用于创建服务的页面。 

5.  从页面底部的定价套餐列表选择 `Dedicated Hardware` 硬件套餐：<br/>
    ![定价套餐](../tutorials/images/pricing_plan.png)
    
6.  过滤掉页面顶部的以下参数：<br/>
    -   输入服务名称。<br/>
    -   指定要部署的区域和空间。<br/>
    -   选择部署位置。<br/>
    -   回答是否需要 HIPAA。请注意，HIPAA 仅适用于美国的位置。<br/> 
     
    **注**：请在相同区域和空间中部署和供应标准套餐实例。    
    ![配置专用硬件](../tutorials/images/select_deployment_location.png)<br/>
启动供应过程。 
    
7.  从页面底部单击`创建`按钮以开始供应。<br/>
    **注**：每天按比例计费，因此在单击**创建**按钮之前，请确认您要针对环境供应和付费。<br/>
    ![供应专用硬件](../tutorials/images/create_button_provision.png)<br/>
    **注**：供应期间，会在 {{site.data.keyword.Bluemix_notm}} 仪表板中实例旁显示一个纺车。将发送一个请求以在裸机服务器上供应 Dedicated Hardware 套餐实例。供应时间是异步的，可能需要最多 5 天的时间。![供应专用硬件备用版本](../tutorials/images/create_button_provision2.png)<br/>
    
## 在 Dedicated Hardware 环境上供应标准套餐实例

1.  登录到 {{site.data.keyword.Bluemix_notm}} 帐户。<br/>
{{site.data.keyword.Bluemix_notm}}“仪表板”位于 [http://bluemix.net ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](http://bluemix.net){:new_window}。使用用户名和密码进行认证后，将显示 {{site.data.keyword.Bluemix_notm}}“仪表板”：<br/>
    ![{{site.data.keyword.Bluemix_notm}}“仪表板”](images/img0001.png)

2.  单击`目录`链接：<br/>
    ![{{site.data.keyword.Bluemix_notm}}“目录”链接](images/img0002.png)<br/>
这将显示 {{site.data.keyword.Bluemix_notm}} 上可用服务的列表。

3.  单击`服务`标题下的`数据和分析`条目：<br/>
    ![{{site.data.keyword.Bluemix_notm}}“数据和分析”服务](images/img0003.png)<br/>
这将显示 {{site.data.keyword.Bluemix_notm}} 上可用“数据和分析”服务的列表。

4.  单击 {{site.data.keyword.cloudant_short_notm}} 服务：<br>
    ![ {{site.data.keyword.Bluemix_notm}} {{site.data.keyword.cloudant_short_notm}} 服务选择](images/img0004.png)<br/>
将显示用于创建服务的页面。  

5.  从页面底部的定价套餐单击`标准`。<br/>
    **注**：无法在 Dedicated Hardware 环境上供应轻量套餐实例。<br/>
    ![标准定价套餐](../tutorials/images/standard_pricing_plan.png)
    
6.  通过输入服务名称和凭证名称等，过滤掉页面顶部的参数（如同针对标准套餐实例那样）。使用`选择环境`下拉菜单决定是在缺省区域多租户环境上供应，还是在已供应的 Dedicated Hardware 环境上供应。<br/>
    ![配置标准实例](../tutorials/images/select_environment.png)
    
7.  单击页面底部的`创建`按钮。<br/>
    几秒后，实例将供应在所选环境上。<br/>
    ![供应标准实例](../tutorials/images/create_button_provision_standard.png)
    
8.  获取服务凭证，然后访问 {{site.data.keyword.cloudant_short_notm}} 仪表板（如同针对多租户 {{site.data.keyword.cloudant_short_notm}} 实例那样）。
    请参阅[此处 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](https://console.bluemix.net/docs/services/Cloudant/tutorials/create_service.html#locating-your-service-credentials){:new_window} 有关如何找到服务凭证的更多信息。 
     
