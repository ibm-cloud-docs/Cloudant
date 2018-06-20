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

# {{site.data.keyword.Bluemix_notm}} での {{site.data.keyword.cloudant_short_notm}} 専用ハードウェア・プラン・インスタンスの作成および活用

このチュートリアルでは、{{site.data.keyword.Bluemix}} ダッシュボードを使用して {{site.data.keyword.cloudantfull}} 専用ハードウェア・プラン・インスタンスを作成する方法、その後に 1 つ以上の標準プラン・インスタンスをプロビジョンしてこのインスタンス上で実行する方法を示します。 

{{site.data.keyword.cloudant_short_notm}} 専用ハードウェア・プラン・インスタンスを作成すると、自分専用の専用ハードウェア上で {{site.data.keyword.cloudant_short_notm}} 環境がプロビジョンされます。サービス・インスタンスは {{site.data.keyword.Bluemix_notm}} ダッシュボード内に作成されますが、専用ハードウェア・プラン・インスタンスには直接アクセスできず、そのインスタンス用のサービス資格情報はないことに注意してください。{{site.data.keyword.cloudant_short_notm}} 専用ハードウェア・プラン・インスタンスは、そのインスタンス上で 1 つ以上の標準プラン・インスタンスをプロビジョンして作成した後に使用できます。

## {{site.data.keyword.cloudant_short_notm}} 専用ハードウェア・プラン・インスタンスの作成

1.  {{site.data.keyword.Bluemix_notm}} アカウントにログインします。<br/>
    {{site.data.keyword.Bluemix_notm}} ダッシュボードは、
    [http://bluemix.net ![「外部リンク」アイコン](../images/launch-glyph.svg "「外部リンク」アイコン")](http://bluemix.net){:new_window} にあります。
    ユーザー名とパスワードで認証すると、
    {{site.data.keyword.Bluemix_notm}} ダッシュボードが表示されます。<br/>
    ![{{site.data.keyword.Bluemix_notm}} ダッシュボード](images/img0001.png)

2.  `｢カタログ｣`リンクをクリックします。<br/>
    ![{{site.data.keyword.Bluemix_notm}} カタログ・リンク](images/img0002.png)<br/>
    {{site.data.keyword.Bluemix_notm}} で使用可能なサービスのリストが表示されます。

3.  `「サービス」`の見出しの下で`「データ & 分析」`項目をクリックします。<br/>
    ![{{site.data.keyword.Bluemix_notm}} の「データ & 分析」サービス](images/img0003.png)<br/>
    {{site.data.keyword.Bluemix_notm}} で使用可能な「データ & 分析」サービスのリストが表示されます。

4.  {{site.data.keyword.cloudant_short_notm}} サービスをクリックします。<br/>
    ![{{site.data.keyword.Bluemix_notm}} {{site.data.keyword.cloudant_short_notm}} サービスの選択](images/img0004.png)<br/>
    サービスを作成するためのページが表示されます。 

5.  ページの下部で、価格設定プランのリストから`「専用ハードウェア (Dedicated Hardware)」`ハードウェア・プランを選択します。<br/>
    ![価格プラン](../tutorials/images/pricing_plan.png)
    
6.  ページの上部で以下のパラメーターを入力します。<br/>
    -   サービス名を入力してください。<br/>
    -   デプロイする地域とスペースを指定します。<br/>
    -   デプロイメントのロケーションを選択します。<br/>
    -   HIPAA が必要かどうかに関する質問には、「はい」または「いいえ」で答えます。 HIPAA は米国のロケーションでのみ有効であることに注意してください。<br/> 
     
    **注**: 標準プラン・インスタンスは、同じ地域とスペースにデプロイしてプロビジョンします。    
    ![専用ハードウェアの構成](../tutorials/images/select_deployment_location.png)<br/>
    プロビジョニング・プロセスを開始します。 
    
7.  `「作成」`ボタンをクリックして、ページの下部からプロビジョニングを開始します。<br/>
    **注**: 請求処理は日割り計算されるため、**「作成」**ボタンをクリックする前に、環境をプロビジョンして支払うことを確認してください。<br/>
    ![専用ハードウェアのプロビジョン](../tutorials/images/create_button_provision.png)<br/>
    **注**: プロビジョン中に、{{site.data.keyword.Bluemix_notm}} ダッシュボードのインスタンスの横に糸車が表示されます。ベア・メタル・サーバー上で専用ハードウェア・プラン・インスタンスをプロビジョンする要求が送信されます。プロビジョニング時間は非同期であり、最大 5 日かかることがあります。![専用ハードウェアの代替バージョンのプロビジョン](../tutorials/images/create_button_provision2.png)<br/>
    
## 専用ハードウェア環境での標準プラン・インスタンスのプロビジョニング

1.  {{site.data.keyword.Bluemix_notm}} アカウントにログインします。<br/>
    {{site.data.keyword.Bluemix_notm}} ダッシュボードは、
    [http://bluemix.net ![「外部リンク」アイコン](../images/launch-glyph.svg "「外部リンク」アイコン")](http://bluemix.net){:new_window} にあります。
    ユーザー名とパスワードで認証すると、
    {{site.data.keyword.Bluemix_notm}} ダッシュボードが表示されます。<br/>
    ![{{site.data.keyword.Bluemix_notm}} ダッシュボード](images/img0001.png)

2.  `｢カタログ｣`リンクをクリックします。<br/>
    ![{{site.data.keyword.Bluemix_notm}} カタログ・リンク](images/img0002.png)<br/>
    {{site.data.keyword.Bluemix_notm}} で使用可能なサービスのリストが表示されます。

3.  `「サービス」`の見出しの下で`「データ & 分析」`項目をクリックします。<br/>
    ![{{site.data.keyword.Bluemix_notm}} の「データ & 分析」サービス](images/img0003.png)<br/>
    {{site.data.keyword.Bluemix_notm}} で使用可能な「データ & 分析」サービスのリストが表示されます。

4.  {{site.data.keyword.cloudant_short_notm}} サービスをクリックします。<br>
    ![{{site.data.keyword.Bluemix_notm}} {{site.data.keyword.cloudant_short_notm}} サービスの選択](images/img0004.png)<br/>
    サービスを作成するためのページが表示されます。  

5.  ページの下部にある「価格プラン」で`「標準」`をクリックします。<br/>
    **注**: 専用ハードウェア環境でライト・プラン・インスタンスをプロビジョンすることはできません。<br/>
    ![標準価格プラン](../tutorials/images/standard_pricing_plan.png)
    
6.  標準プラン・インスタンスの場合と同様に、ページの上部にある「サービス名」や「資格情報名」などのパラメーターを入力します。`「環境の選択 (Select Environment)」`ドロップダウンを使用して、デフォルトの地域のマルチテナント環境でプロビジョンするのか、専用ハードウェア環境でプロビジョンするのかを決定します。<br/>
    ![標準インスタンスの構成](../tutorials/images/select_environment.png)
    
7.  ページの下部にある`「作成」`ボタンをクリックします。<br/>
    数秒後に、選択した環境でインスタンスがプロビジョンされます。<br/>
    ![標準インスタンスのプロビジョン](../tutorials/images/create_button_provision_standard.png)
    
8.  マルチテナント {{site.data.keyword.cloudant_short_notm}} インスタンスの場合と同様に、サービス資格情報を取得して、{{site.data.keyword.cloudant_short_notm}} ダッシュボードにアクセスします。
    [ここ ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://console.bluemix.net/docs/services/Cloudant/tutorials/create_service.html#locating-your-service-credentials){:new_window} で、サービス資格情報を見つける方法に関する詳細を参照してください。 
     
