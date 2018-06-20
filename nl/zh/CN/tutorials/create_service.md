---

copyright:
  years: 2017, 2018
lastupdated: "2017-11-07"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

# 在 {{site.data.keyword.Bluemix_notm}} 上创建 {{site.data.keyword.cloudant_short_notm}} 实例

本教程说明了如何使用 {{site.data.keyword.Bluemix}} 仪表板来创建 {{site.data.keyword.cloudantfull}} 服务实例，以及在何处可找到支持应用程序使用数据库的基本信息。
{:shortdesc}

要访问 {{site.data.keyword.cloudant_short_notm}} 服务实例，您需要一组[服务凭证](#the-service-credentials)。在创建服务实例的过程中会生成这些凭证。

您还可以通过访问自己的 {{site.data.keyword.cloudant_short_notm}} 帐户，随时查找这些凭证。

## 创建服务实例

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
    ![ {{site.data.keyword.Bluemix_notm}} {{site.data.keyword.cloudant_short_notm}} 服务选择](images/img0004.png)

5.  在“服务配置”窗口中，输入服务名称。在此示例中，服务名称为 `Cloudant Service 2017`：<br/>
    ![{{site.data.keyword.cloudant_short_notm}} 服务名称和凭证](images/img0005.png)

6.  缺省情况下，将使用“Lite”定价套餐来创建服务；Lite 是免费套餐，提供的容量有限。另外[提供](../offerings/bluemix.html)了容量更大的其他定价套餐。<br/>
要创建服务，请单击`创建`按钮：<br/>
    ![创建 {{site.data.keyword.cloudant_short_notm}} 服务名称和凭证](images/img0006.png)

7.  这将显示服务页面，确认新的 {{site.data.keyword.cloudant_short_notm}} 服务是否可用。要访问应用程序连接到服务所需的连接信息，请单击`服务凭证`选项卡：<br/>
    ![访问 {{site.data.keyword.cloudant_short_notm}} 服务凭证](images/img0007.png)

8.  这将显示“服务凭证”窗口。要查看访问服务所需的凭证，请单击`查看凭证`下拉列表：<br/>
    ![查看 {{site.data.keyword.cloudant_short_notm}} 服务凭证](images/img0008.png)

9.  这将显示服务凭证的详细信息。<br/>
    ![{{site.data.keyword.cloudant_short_notm}} 服务凭证](images/img0009.png)

>   **注**：这些示例中的服务凭证
是在 {{site.data.keyword.cloudant_short_notm}} 上创建演示 {{site.data.keyword.cloudant_short_notm}} 服务时定义的。在此重现这些凭证，是为了说明这些凭证在仪表板中的显示方式。但是，现在已除去了演示 {{site.data.keyword.cloudant_short_notm}} 服务，因此这些凭证不再有效；您_必须_提供并使用自己的服务凭证。


## 服务凭证

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

要创建可以访问服务实例的应用程序，您需要这些凭证。

## 查找服务凭证

您可以随时查找与帐户关联的服务的凭证。

1.  首先，请登录到 {{site.data.keyword.cloudant_short_notm}}。{{site.data.keyword.Bluemix}}“仪表板”位于 [http://bluemix.net ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](http://bluemix.net){:new_window}。使用用户名和密码进行认证后，将显示 {{site.data.keyword.Bluemix_notm}}“仪表板”：<br/>
    ![{{site.data.keyword.Bluemix_notm}}“仪表板”](images/img0001.png)

2.  向下滚动“仪表板”，直至到达列出所有服务的部分：<br/>
    ![{{site.data.keyword.Bluemix_notm}} 的服务列表](images/img0010.png)

3.  在此示例中，我们希望查找先前在教程中创建的 {{site.data.keyword.cloudant_short_notm}} 服务实例（名为 `Cloudant Service 2017`）的服务凭证。单击对应的行：<br/>
    ![选择 {{site.data.keyword.cloudant_short_notm}} 服务](images/img0011.png)

3.  这将显示“服务凭证”窗口。要查看访问服务所需的凭证，请单击`查看凭证`下拉列表：<br/>
    ![查看 {{site.data.keyword.cloudant_short_notm}} 服务凭证](images/img0008.png)

4.  这将显示服务凭证的详细信息。<br/>
    ![{{site.data.keyword.cloudant_short_notm}} 服务凭证](images/img0009.png)

>   **注**：这些示例中的服务凭证
是在 {{site.data.keyword.cloudant_short_notm}} 上创建演示 {{site.data.keyword.cloudant_short_notm}} 服务时定义的。在此重现这些凭证，是为了说明这些凭证在仪表板中的显示方式。但是，现在已除去了演示 {{site.data.keyword.cloudant_short_notm}} 服务，因此这些凭证不再有效；您_必须_提供并使用自己的服务凭证。
