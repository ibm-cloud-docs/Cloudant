---

copyright:
  years: 2015, 2019
lastupdated: "2019-04-02"

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

# {{site.data.keyword.cloudant_short_notm}} での {{site.data.keyword.cloud_notm}} 専用ハードウェア・プラン・インスタンスの作成および活用
{: #creating-and-leveraging-an-ibm-cloudant-dedicated-hardware-plan-instance-on-ibm-cloud}

このチュートリアルでは、{{site.data.keyword.cloud}} ダッシュボードを使用する {{site.data.keyword.cloudantfull}} 専用ハードウェア・プラン・インスタンスの作成方法を示し、その後に、{{site.data.keyword.cloud_notm}} カタログまたは {{site.data.keyword.cloud_notm}} CLI のいずれかを使用して、そのインスタンス上で実行される 1 つ以上の標準プラン・インスタンスをプロビジョンする方法を示します。 
{: shortdesc}

{{site.data.keyword.cloudant_short_notm}} 専用ハードウェア・プラン・インスタンスを作成すると、自分専用の専用ハードウェア上で {{site.data.keyword.cloudant_short_notm}} 環境がプロビジョンされます。 サービス・インスタンスは {{site.data.keyword.cloud_notm}} ダッシュボード内に作成されますが、専用ハードウェア・プラン・インスタンスには直接アクセスできず、そのインスタンス用のサービス資格情報はありません。 {{site.data.keyword.cloudant_short_notm}} 専用ハードウェア・プラン・インスタンスは、そのインスタンス上で 1 つ以上の標準プラン・インスタンスをプロビジョンして作成した後に使用できます。

## {{site.data.keyword.cloudant_short_notm}} 専用ハードウェア・プラン・インスタンスの作成
{: #creating-an-ibm-cloudant-dedicated-hardware-plan-instance}

1.  {{site.data.keyword.cloud_notm}} アカウントにログインします。<br/>
    {{site.data.keyword.cloud_notm}} ダッシュボードは、
    [`https://cloud.ibm.com/ ` ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://cloud.ibm.com/){: new_window} にあります。
    ユーザー名とパスワードで認証すると、
    {{site.data.keyword.cloud_notm}} ダッシュボードが表示されます。 以下の「`リソースの作成`」ボタンをクリックします。<br/>
    ![{{site.data.keyword.cloud_notm}} ダッシュボード](images/img0001.png)

2.  左メニューから「`データベース`」をクリックし、データベース・サービスのリストから「`Cloudant`」をクリックします。<br/>
     ![{{site.data.keyword.cloud_notm}} {{site.data.keyword.cloudant_short_notm}} サービスの選択](images/img0003.png)<br/>

3.  ページの下部で、価格設定プランのリストから`「専用ハードウェア (Dedicated Hardware)」`プランを選択します。<br/>
    ![価格プラン](/docs/services/Cloudant/tutorials/images/pricing_plan.png)
    
4.  ページの上部で以下のパラメーターを入力します。 <br/>
    -   サービス名を入力してください。<br/>
    -   デプロイする地域/場所を指定します。<br/>
    -   リソース・グループを選択します。</br>
    -   タグを追加します。 
    -   デプロイメントのロケーションを選択します。<br/>
    -   HIPAA が必要かどうかの質問に答えるために、「`はい`」または「`いいえ`」を選択します。<br/> 
    
    HIPAA は米国のロケーションでのみ有効です。 {{site.data.keyword.IBM}} は、HIPAA コントロールを実装するために、専用ハードウェア・プランの環境をプロビジョンできます。環境のプロビジョンは、{{site.data.keyword.IBM_notm}} との間で確立される提携事業者契約 (Business Associate Agreement (BAA)) が確認されたときにのみに行われます。 詳細については、[「HIPAA サポートあり」設定の有効化
](https://cloud.ibm.com/docs/account/eu_hipaa_supported.html#enabling-the-hipaa-supported-setting)とサービス記述のご利用条件を参照してください。HIPAA データを管理するためのクラスターのプロビジョニングには、推定されている 5 日間の期間より長い時間がかかる可能性があります。
    {: note}

    ![専用ハードウェアの構成](/docs/services/Cloudant/tutorials/images/select_deployment_location.png)
        
5.  「`作成`」ボタンをクリックして、プロビジョニング・プロセスを開始します。 <br/>

    請求処理は日割り計算されるため、**「作成」**ボタンをクリックする前に、環境をプロビジョンして支払うことを確認してください。
    {: note}

    ![専用ハードウェアのプロビジョン](/docs/services/Cloudant/tutorials/images/create_button_provision.png)

    プロビジョン中に、{{site.data.keyword.cloud_notm}} ダッシュボードのインスタンスの横に糸車が表示されます。 ベア・メタル・サーバー上で専用ハードウェア・プラン・インスタンスをプロビジョンする要求が送信されます。 プロビジョニング時間は非同期であり、最大 5 日かかることがあります。 
    {: note}   

    ![専用ハードウェアの代替バージョンのプロビジョン](/docs/services/Cloudant/tutorials/images/create_button_provision2.png)
    
## 専用ハードウェア環境での標準プラン・インスタンスのプロビジョニング
{: #provisioning-a-standard-plan-instance-on-a-dedicated-hardware-environment}

1.  {{site.data.keyword.cloud_notm}} アカウントにログインします。<br/>
    {{site.data.keyword.cloud_notm}} ダッシュボードは、
    [https://cloud.ibm.com/ ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://cloud.ibm.com/){: new_window} にあります。
    ユーザー名とパスワードで認証すると、
    {{site.data.keyword.cloud_notm}} ダッシュボードが表示されます。 以下の「`リソースの作成`」ボタンをクリックします。<br/>
    ![{{site.data.keyword.cloud_notm}} ダッシュボード](images/img0001.png)

2.  左メニューから「`データベース`」をクリックし、データベース・サービスのリストから「`Cloudant`」をクリックします。<br/>
     ![{{site.data.keyword.cloud_notm}} {{site.data.keyword.cloudant_short_notm}} サービスの選択](images/img0003.png)<br/>
    サービスを作成するためのページが表示されます。<br/>  

3.  価格プランから「`標準`」をクリックします。 <br/>
    ![標準価格プラン](/docs/services/Cloudant/tutorials/images/standard_pricing_plan.png)
    
    専用ハードウェア環境でライト・プラン・インスタンスをプロビジョンすることはできません。
    {: tip}
    
4.  以下のパラメーターを入力します。 <br/>
    -   サービス名を入力してください。<br/>
    -   デプロイする地域/場所を指定します。 <br/>
    -   リソース・グループを選択します。 </br>
    -   タグを追加します。 
    -   認証方法を選択します。</br>
    -   環境を選択します。</br>
    ![標準インスタンスの構成](/docs/services/Cloudant/tutorials/images/select_environment.png)
    
5.  `「作成」`ボタンをクリックします。<br/>
    数秒後に、選択した環境でインスタンスがプロビジョンされます。<br/>
    ![標準インスタンスのプロビジョン](/docs/services/Cloudant/tutorials/images/create_button_provision_standard.png)
    
6.  マルチテナント {{site.data.keyword.cloudant_short_notm}} インスタンスの場合と同様に、サービス資格情報を取得して、{{site.data.keyword.cloudant_short_notm}} ダッシュボードにアクセスします。 
    
    詳細については、『[サービス資格情報の見つけ方 (how to locate your service credentials)](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud#locating-your-service-credentials){: new_window}』を参照してください。 
    
## {{site.data.keyword.cloud_notm}} CLI を使用した専用ハードウェア環境での標準プラン・インスタンスのプロビジョニング
{: #provisioning-a-standard-plan-instance-on-a-dedicated-hardware-environment-with-the-ibm-cloud-cli}

{{site.data.keyword.cloud_notm}} CLI を使用するには、ログインする必要があります。 ログインしてターゲット・リソース・グループを設定する方法について詳しくは、『[{{site.data.keyword.cloud_notm}} アカウントへのログイン](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud-by-using-the-ibm-cloud-cli#logging-in-to-your-ibm-cloud-account){: new_window}』を参照してください。 

{{site.data.keyword.cloudant_short_notm}} 専用ハードウェア・プラン環境に {{site.data.keyword.cloudant_short_notm}} 標準プラン・インスタンスを作成するための基本コマンド・フォーマットは以下のとおりです。


フィールド | 説明
------|------------
`NAME`| インスタンスに割り当てる任意の名前。
`SERVICE_NAME` | `cloudantnosqldb`
`PLAN_NAME` | 標準プラン
`LOCATION` |  デプロイする場所。例えば、us-south、us-east、または eu-gb など。 

次のサンプル・コマンドを参照してください。 

```sh
ibmcloud resource service-instance-create NAME SERVICE_NAME SERVICE_PLAN_NAME LOCATION [-p, --parameters @JSON_FILE | JSON_STRING ]
```
{: codeblock}

専用ハードウェア環境にデプロイされる {{site.data.keyword.cloudant_short_notm}} インスタンスは、以下に示す 2 つの追加パラメーターを取ります。

パラメーター | 説明
----------|------------
`environment_crn` | このパラメーターは、{{site.data.keyword.cloudant_short_notm}} 専用ハードウェア・プラン・インスタンスの CRN に設定する必要があります。 CRN を判別するには、{{site.data.keyword.cloud_notm}} ダッシュボードで {{site.data.keyword.cloudant_short_notm}} 専用ハードウェア・プラン・インスタンスの「管理」タブ内のサンプル CLI コマンドを参照してください。 あるいは、`ibmcloud resource service-instance SERVICE_INSTANCE_NAME` コマンドを使用して CRN を判別することもできます。 
`legacyCredentials` | デフォルトで true に設定され、インスタンスがレガシー資格情報と IAM 資格情報の両方を使用するか、または IAM 資格情報のみを使用するかを示すオプション・パラメーター。 認証方式の選択について詳しくは、『[IAM ガイド ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-){: new_window}』を参照してください。

次のサンプル・コマンドを参照してください。 

```sh
ibmcloud resource service-instance-create cloudant_on_ded_hardware_cli cloudantnosqldb standard us-south -p '{"environment_crn":"crn:v1:bluemix:public:cloudantnosqldb:us-south:a/b43434444bb7e2abb0841ca25d28ee4c:301a3118-7678-4d99-b1b7-4d45cf5f7b29::","legacyCredentials":false}'
```
{: codeblock}

## {{site.data.keyword.cloudant_short_notm}} サービスの資格情報の作成
{: #creating-the-credentials-for-your-ibm-cloudant-service}

{{site.data.keyword.cloudant_short_notm}} サービスへのアクセスを要求するアプリケーションには、必要な資格情報が必要です。

サービス資格情報は大切です。 資格情報にアクセスできるユーザーまたはアプリケーションは、サービス・インスタンスに対して事実上何でも実行できます。 例えば、偽造データを作成したり、重要な情報を削除したりする可能性があります。 これらの資格情報は、大切に保護してください。
{: important}

サービス資格情報に含まれるフィールドの詳細については、「[IAM ガイド ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-){: new_window}」を参照してください。

{{site.data.keyword.cloud_notm}} 内のサービス・インスタンスの資格情報を作成する基本コマンド・フォーマットは、以下のとおりです。

```sh
ibmcloud resource service-key-create NAME ROLE_NAME --instance-name SERVICE_INSTANCE_NAME [--enable-internal-service-endpoint true]
```
{: pre}

下表はフィールドの説明です。

フィールド | 説明
------|------------
`NAME` | サービス資格情報に指定する任意の名前。 
`ROLE_NAME` | このフィールドで現在許可されるのはマネージャー役割のみです。
`SERVICE_INSTANCE_NAME` | {{site.data.keyword.cloudant_short_notm}} インスタンスに指定する名前。
`enable-internal-service-endpoint` |「サービス資格情報」の URL フィールドに内部エンドポイントを取り込んで、サービスに {{site.data.keyword.cloud_notm}} 内部ネットワーク経由で接続するためのオプション・フィールド。パブリック・ネットワークからアクセス可能な外部エンドポイントを URL に取り込む場合は、このフィールドを省略してください。このオプションは、内部エンドポイントをサポートする専用ハードウェア環境にデプロイされた標準プラン・インスタンスのみに適用されます。環境が内部エンドポイントをサポートしていない場合は、このコマンドを発行すると 400 エラーが返されます。

{{site.data.keyword.cloudant_short_notm}} サービスの `cs20170517a` インスタンスの資格情報 (ここで、資格情報の名前は `creds_for_cs20170517a`) を作成する場合、以下の例のようなコマンドを使用してそれらの資格情報を作成します。

```sh
ibmcloud resource service-key-create creds_for_cs20170517a Manager --instance-name cs20170517a
```
{: codeblock}

サービス・インスタンスの資格情報を作成する要求を受け取ると、
{{site.data.keyword.cloud_notm}} は、以下の例のようなメッセージで応答します。

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

{{site.data.keyword.cloudant_short_notm}} サービスの `cs20170517a` インスタンスの資格情報 (ここで、資格情報の名前は `creds_for_cs20170517a`) を作成し、その URL に内部エンドポイントを取り込む場合、以下の例のようなコマンドを使用してそれらの資格情報を作成します。

```sh
ibmcloud resource service-key-create creds_for_cs20170517a Manager --instance-name cs20170517a --enable-internal-service-endpoint true
```
{: codeblock}

サービス・インスタンスの資格情報を作成する要求を受け取ると、
{{site.data.keyword.cloud_notm}} は、以下の例のようなメッセージで応答します。

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

## {{site.data.keyword.cloudant_short_notm}} サービスのサービス資格情報のリスト
{: #listing-the-service-credentials-for-your-ibm-cloudant-service}

{{site.data.keyword.cloud_notm}} 内のサービス・インスタンスの資格情報を取得する基本コマンド・フォーマットは、以下のとおりです。

```sh
ibmcloud resource service-key KEY_NAME
```
{: codeblock}

この例では、{{site.data.keyword.cloudant_short_notm}} サービスの `cs20170517a` インスタンスの資格情報 (ここで、資格情報の名前は `creds_for_cs20170517a`) を取得します。資格情報は、以下の例のようなコマンドを使用して取得します。

```sh
ibmcloud resource service-key creds_for_cs20170517b
```
{: codeblock}

サービス・インスタンスの資格情報を取得する要求を受け取ると、
{{site.data.keyword.cloud_notm}} は、以下の (省略された) 例のようなメッセージで応答します。

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
