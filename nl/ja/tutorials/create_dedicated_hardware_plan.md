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
{:tip: .tip}

<!-- Acrolinx: 2017-05-10 -->


# {{site.data.keyword.cloudant_short_notm}} での {{site.data.keyword.cloud_notm}} 専用ハードウェア・プラン・インスタンスの作成および活用

このチュートリアルでは、{{site.data.keyword.cloud}} ダッシュボードを使用する {{site.data.keyword.cloudantfull}} 専用ハードウェア・プラン・インスタンスの作成方法を示し、その後に、{{site.data.keyword.cloud_notm}} カタログまたは {{site.data.keyword.cloud_notm}} CLI のいずれかを使用して、そのインスタンス上で実行される 1 つ以上の標準プラン・インスタンスをプロビジョンする方法を示します。 

{{site.data.keyword.cloudant_short_notm}} 専用ハードウェア・プラン・インスタンスを作成すると、自分専用の専用ハードウェア上で {{site.data.keyword.cloudant_short_notm}} 環境がプロビジョンされます。 サービス・インスタンスは {{site.data.keyword.cloud_notm}} ダッシュボード内に作成されますが、専用ハードウェア・プラン・インスタンスには直接アクセスできず、そのインスタンス用のサービス資格情報はありません。{{site.data.keyword.cloudant_short_notm}} 専用ハードウェア・プラン・インスタンスは、そのインスタンス上で 1 つ以上の標準プラン・インスタンスをプロビジョンして作成した後に使用できます。

## {{site.data.keyword.cloudant_short_notm}} 専用ハードウェア・プラン・インスタンスの作成

1.  {{site.data.keyword.cloud_notm}} アカウントにログインします。<br/>
    {{site.data.keyword.cloud_notm}} ダッシュボードは、
    [http://bluemix.net ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](http://bluemix.net){:new_window} にあります。
    ユーザー名とパスワードで認証すると、
    {{site.data.keyword.cloud_notm}} ダッシュボードが表示されます。<br/>
    ![{{site.data.keyword.cloud_notm}} ダッシュボード](images/img0001.png)

2.  以下の「`リソースの作成`」ボタンをクリックします。<br/>
    ![{{site.data.keyword.cloud_notm}} リソースの作成ボタン](images/img0002.png)<br/>
    
3.  使用可能な {{site.data.keyword.cloud_notm}} カタログおよびサービスを参照します。「`データベース`」カテゴリーをクリックします。
    ![{{site.data.keyword.cloud_notm}} カタログ](images/img0000.png)

4.  {{site.data.keyword.cloudant_short_notm}} サービスをクリックします。<br/>
    ![{{site.data.keyword.cloud_notm}} {{site.data.keyword.cloudant_short_notm}} サービスの選択](images/img0003.png)<br/>
    サービスを作成するためのページが表示されます。

5.  ページの下部で、価格設定プランのリストから`「専用ハードウェア (Dedicated Hardware)」`プランを選択します。<br/>
    ![価格プラン](../tutorials/images/pricing_plan.png)
    
6.  ページの上部で以下のパラメーターを入力します。 <br/>
    -   サービス名を入力してください。<br/>
    -   デプロイする地域/場所を指定します。<br/>
    -   リソース・グループを選択します。</br>
    -   デプロイメントのロケーションを選択します。<br/>
    -   HIPAA が必要かどうかの質問に答えるために、「`はい`」または「`いいえ`」を選択します。<br/>
   
    HIPAA は米国のロケーションでのみ有効です。 {{site.data.keyword.IBM}} は、HIPAA コントロールを実装するために、専用またはベアメタルのクラスターをプロビジョンできます。クラスターのプロビジョンは、{{site.data.keyword.IBM_notm}} との間で確立される提携事業者契約 (Business Associate Agreement (BAA)) が確認されたときにのみに行われます。この契約は、サービス記述書のご利用条件で述べられています。HIPAA データを管理するためのクラスターのプロビジョニングには、推定されている 5 日間の期間より長い時間がかかる可能性があります。
    {: tip}
    
    標準プラン・インスタンスは、同じ地域とスペースにデプロイしてプロビジョンします。
    {: tip}

    ![専用ハードウェアの構成](../tutorials/images/select_deployment_location.png)
        
7.  「`作成`」ボタンをクリックして、プロビジョニング・プロセスを開始します。<br/>

    請求処理は日割り計算されるため、**「作成」**ボタンをクリックする前に、環境をプロビジョンして支払うことを確認してください。
    {: tip}

    ![専用ハードウェアのプロビジョン](../tutorials/images/create_button_provision.png)

    プロビジョン中に、{{site.data.keyword.cloud_notm}} ダッシュボードのインスタンスの横に糸車が表示されます。 ベア・メタル・サーバー上で専用ハードウェア・プラン・インスタンスをプロビジョンする要求が送信されます。 プロビジョニング時間は非同期であり、最大 5 日かかることがあります。 
    {: tip}   

    ![専用ハードウェアの代替バージョンのプロビジョン](../tutorials/images/create_button_provision2.png)
    
## 専用ハードウェア環境での標準プラン・インスタンスのプロビジョニング

1.  {{site.data.keyword.cloud_notm}} アカウントにログインします。<br/>
    {{site.data.keyword.cloud_notm}} ダッシュボードは、
    [http://bluemix.net ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](http://bluemix.net){:new_window} にあります。
    ユーザー名とパスワードで認証すると、
    {{site.data.keyword.cloud_notm}} ダッシュボードが表示されます。<br/>
    ![{{site.data.keyword.cloud_notm}} ダッシュボード](images/img0001.png)

2.  以下の「`リソースの作成`」ボタンをクリックします。<br/>
    ![{{site.data.keyword.cloud_notm}} リソースの作成](images/img0002.png)<br/>
    {{site.data.keyword.cloud_notm}} で使用可能なサービスのリストが表示されます。

3.  以下のように「`データベース`」カテゴリーをクリックし、「`Cloudant`」サービスを選択します。<br/>
    ![{{site.data.keyword.cloud_notm}} {{site.data.keyword.cloudant_short_notm}} サービスの選択](images/img0003.png)</br>
    サービスを作成するためのページが表示されます。<br/>  

4.  価格プランから「`標準`」をクリックします。<br/>
    ![標準価格プラン](../tutorials/images/standard_pricing_plan.png)
    
    専用ハードウェア環境でライト・プラン・インスタンスをプロビジョンすることはできません。
    {: tip}
    
5.  以下のパラメーターを入力します。<br/>
    -   サービス名を入力してください。<br/>
    -   デプロイする地域/場所を指定します。<br/>
    -   リソース・グループを選択します。 </br>
    -   認証方法を選択します。</br>
    -   環境を選択します。</br>
    ![標準インスタンスの構成](../tutorials/images/select_environment.png)
    
6.  `「作成」`ボタンをクリックします。<br/>
    数秒後に、選択した環境でインスタンスがプロビジョンされます。<br/>
    ![標準インスタンスのプロビジョン](../tutorials/images/create_button_provision_standard.png)
    
7.  マルチテナント {{site.data.keyword.cloudant_short_notm}} インスタンスの場合と同様に、サービス資格情報を取得して、{{site.data.keyword.cloudant_short_notm}} ダッシュボードにアクセスします。 
    
    詳細については、『[サービス資格情報の見つけ方 (how to locate your service credentials)](../tutorials/create_service.html#locating-your-service-credentials){:new_window}』を参照してください。 
    
## {{site.data.keyword.cloud_notm}} CLI を使用した専用ハードウェア環境での標準プラン・インスタンスのプロビジョニング

{{site.data.keyword.cloud_notm}} CLI を使用するには、ログインする必要があります。ログインしてターゲット・リソース・グループを設定する方法について詳しくは、『[{{site.data.keyword.cloud_notm}} アカウントへのログイン](create_service_cli.html#logging-in-to-your-ibm-cloud-account){:new_window}』を参照してください。 

{{site.data.keyword.cloudant_short_notm}} 専用ハードウェア・プラン環境に {{site.data.keyword.cloudant_short_notm}} 標準プラン・インスタンスを作成するための基本コマンド・フォーマットは以下のとおりです。


フィールド | 説明
------|------------
`NAME`| インスタンスに割り当てる任意の名前。
`SERVICE_NAME` | `cloudantnosqldb`
`PLAN_NAME` | 標準プラン
`LOCATION` | デプロイする場所。例えば、us-south、us-east、または eu-gb など。

次のサンプル・コマンドを参照してください。 

```sh
ibmcloud resource service-instance-create NAME SERVICE_NAME SERVICE_PLAN_NAME LOCATION [-p, --parameters @JSON_FILE | JSON_STRING ]
```

専用ハードウェア環境にデプロイされる {{site.data.keyword.cloudant_short_notm}} インスタンスは、以下に示す 2 つの追加パラメーターを取ります。

パラメーター| 説明
----------|------------
`environment_crn` | このパラメーターは、{{site.data.keyword.cloudant_short_notm}} 専用ハードウェア・プラン・インスタンスの CRN に設定する必要があります。CRN を判別するには、{{site.data.keyword.cloud_notm}} ダッシュボードで {{site.data.keyword.cloudant_short_notm}} 専用ハードウェア・プラン・インスタンスの「管理」タブ内のサンプル CLI コマンドを参照してください。あるいは、`ibmcloud resource service-instance SERVICE_INSTANCE_NAME` コマンドを使用して CRN を判別することもできます。
`legacyCredentials` | デフォルトで true に設定され、インスタンスがレガシー資格情報と IAM 資格情報の両方を使用するか、または IAM 資格情報のみを使用するかを示すオプション・パラメーター。認証方式の選択について詳しくは、『[IAM ガイド ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](../guides/iam.html#ibm-cloud-identity-and-access-management-iam-){:new_window}』を参照してください。

次のサンプル・コマンドを参照してください。 

```sh
ibmcloud resource service-instance-create cloudant_on_ded_hardware_cli cloudantnosqldb standard us-south -p '{"environment_crn":"crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b43434444bb7e2abb0841ca25d28ee4c:301a3118-7678-4d99-b1b7-4d45cf5f7b29::","legacyCredentials":false}'
```
     
