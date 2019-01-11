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

<!-- Acrolinx: 2018-08-14 -->

# {{site.data.keyword.cloud_notm}} での {{site.data.keyword.cloudant_short_notm}} へのマイグレーション
 
[{{site.data.keyword.cloudantfull}}](https://www.ibm.com/cloud/cloudant) の Database as a Service オファリングは、マルチテナント・クラスターで実行される JSON 文書ストアです。このサービスは、予測可能なコスト、スケーラビリティー、およびサービス・レベル・アグリーメント (SLA) とともに地理的位置を選択することで使用できます。

この資料では、次のいずれかのプランから、{{site.data.keyword.cloud_notm}} での {{site.data.keyword.cloudant_short_notm}} ライト・プラン・インスタンスまたは標準プラン・インスタンスにマイグレーションする方法について説明します。

プラン | 説明
-----|------------
{{site.data.keyword.cloudant_short_notm}} Enterprise | 専用のシングル・テナント・クラスター
{{site.data.keyword.cloudant_short_notm}} Shared プラン | 従来の従量課金 (PAYG) 制のマルチテナント {{site.data.keyword.cloudant_short_notm}} サービス。`cloudant.com` Shared プランは、2018 年 3 月に廃止されました。{{site.data.keyword.cloudant_short_notm}} Shared プランは、2016 年 10 月に新規のお申し込みについて非推奨となり、2018 年の第 4 四半期に廃止される予定です。
{{site.data.keyword.cloudant_localfull}} | {{site.data.keyword.cloudant_short_notm}} のセルフホスト型のパッケージ・インストール。
Apache CouchDB | {{site.data.keyword.cloudant_short_notm}} のベースとなるセルフホスト型のオープン・ソース・データベース。

## {{site.data.keyword.cloudant_short_notm}} ライト・プランおよび標準プランにはどのような利点がありますか?

標準プランを使用すると、データベース・サービスの*スループット・キャパシティーを予約*できます。つまり、アプリケーションのデータベースで要求を処理するために必要となるスループットを指定できます。また標準プランでは、使用するストレージ量に対しても課金されます。キャパシティーは、次のメトリックを使用して測定されます。

メトリック | 説明
-------|------------
1 秒当たりのルックアップ数 | 文書の `_id` による文書の取得など、単純な文書のフェッチが実行される速度。
1 秒当たりの書き込み数 | データがデータベースに書き込まれる速度。文書の作成、更新、または削除を処理する API 呼び出しは「書き込み」としてカウントされます。
1 秒当たりの照会数 | 通常、`_find` エンドポイントにアクセスすることで、または 2 次 MapReduce 索引を使用することでデータベースが照会される速度。
ストレージ | JSON データ、添付ファイル、および 2 次索引が占有するディスク・スペースの量。

例えば、ライト・プランでは、1 秒当たり 20 回のルックアップ、1 秒当たり 10 回の書き込み、1 秒当たり 5 回の照会、および 1 GB のストレージが無料で提供されます。このプランは、製品の「品質検査をする」場合および製品の開発時に最適です。アプリケーションを実動させる場合、標準プランに切り替える必要があります。標準プランの最小パッケージでは、1 カ月当たり最大 $76.65 USD で、1 秒当たり 100 回のルックアップ、1 秒当たり 50 回の書き込み、1 秒当たり 5 回の照会、および 20 GB のストレージ (追加ストレージは GB 単位で課金されます) が提供されます。 

{{site.data.keyword.cloudant_short_notm}} ダッシュボードのスライダーを使用することで、必要に応じていつでも {{site.data.keyword.cloudant_short_notm}} サービスの予約キャパシティーを減らすことや増やすことができます。

![スライダー](../images/migrate2.gif)

スループット・キャパシティーを変更できる量は、1 回の変更当たり最大で 10 単位に制限され (スライダーの「変更制限 (change limit)」ポイントに注意してください)、 1 時間当たり最大で 1 回変更できます。キャパシティーを変更して減らす場合、無制限に減らすことができますが、回数の制限は適用されます。
{: tip}

所定の 1 時間の枠内で選択された最も高いキャパシティーについて料金が請求されます。季節的な需要に対処するためにデータベース・スループットを増やすことができ、また平穏時にはスループットを再び減らすことができます。どのような場合でも、1 月当たりの料金は予測可能で、アップグレードは自動的に行われ、また SLA は [99.95%](http://www-03.ibm.com/software/sla/sladb.nsf/sla/bm-6627-03) です。

所定の秒数当たりのルックアップ回数、書き込み回数、および照会回数の割り当て量を超過した場合、{{site.data.keyword.cloudant_short_notm}} クラスターは `HTTP 429` 応答を使用して応答します。アプリケーションは、後で要求を再試行する場合があります。公式のライブラリーでは、指数バックオフを使用してこのような要求を再試行するオプションが提供されています。 

## どのタイプの {{site.data.keyword.cloudant_short_notm}} プランを現在使用しているか確認できますか?

{{site.data.keyword.cloudant_short_notm}} を使用している場合、{{site.data.keyword.cloud_notm}} ダッシュボードに、「プラン」列とともにすべての {{site.data.keyword.cloudant_short_notm}} インスタンスが表示されます。厳密に言うと、ライト・プラン、標準プラン、および専用ハードウェア・プランが示されます。Shared Dedicated プラン名を示す {{site.data.keyword.cloudant_short_notm}} インスタンスは、{{site.data.keyword.cloudant_short_notm}} 専用環境に属しており、Public Shared プランには属していません。Shared プラン名を示す {{site.data.keyword.cloudant_short_notm}} インスタンス、またはその列にプラン名がないインスタンスは、非推奨の Shared プランを使用しています。次の例では、「Cloudant NoSQL DB-ix」インスタンスおよび「Cloudant_NewConsole」インスタンスは、非推奨の Shared プランを使用しています。  

![クラウド・ダッシュボード](../images/ibmclouddashboard.png)

また、特定のインスタンスにドリルダウンして、「プラン」タブを表示することもできます。非推奨の Shared プランの {{site.data.keyword.cloudant_short_notm}} インスタンスでは、プランは強調表示されません。{{site.data.keyword.cloudant_short_notm}} 標準プランのインスタンスは、次の例のようになります。 

![標準ダッシュボード](../images/ibmcloud_instance_standard_plan.png)

また、{{site.data.keyword.cloudant_short_notm}} ダッシュボードを開き、**「アカウント」**タブをクリックすることもできます。ライト・プランは、次の例のようになります。

![ライト・プラン](../images/migrate1.png)

従来の `cloudant.com` アカウントを使用している場合、{{site.data.keyword.cloudant_short_notm}} ダッシュボードにログインし、「アカウント」タブに移動できます。従来の `cloudant.com` Shared プランには「使用量」タブがあり、当月のグラフおよび請求見積もりが表示されます。以下に例を示します。

![Shared プラン](../images/cloudantcom_sharedplan_usage.png)

専用クラスターの `cloudant.com` Enterprise のユーザーには、「アカウント」タブで「使用量」タブは表示されません。以下に例を示します。

![Enterprise プラン](../images/cloudantcom_enterpriseplan_account.png)

「アカウント」タブで標準プランを使用していることが示されている場合、この先を読む必要はありません。支払い済みの SLA 支援 {{site.data.keyword.cloudant_short_notm}} サービスを既に使用しています。これ以上のアクションは不要です。

## {{site.data.keyword.cloudant_short_notm}} ライトから {{site.data.keyword.cloudant_short_notm}} 標準へのマイグレーション

無料のライト・プランから標準プランにマイグレーションするには、次の手順に従います。 

1.  {{site.data.keyword.cloud_notm}} ダッシュボードに移動します。
2.  マイグレーションする {{site.data.keyword.cloudant_short_notm}} インスタンスを選択します。 
3.  左ナビゲーションで**「プラン」**タブを選択します。 
4.  価格プランのリストから、**「標準」**チェック・ボックスを選択します。
![ライト](../images/migrate3.png)
5.  ページの下部にある**「アップグレード」**をクリックします。
既存のデータはすべて保持されます。

必要に応じて、スループット・キャパシティー・スライダーを使用してキャパシティーを増減させ、キャパシティーを調整します。
{: tip} 
 
これで完了です。

## 他のすべてのプランから {{site.data.keyword.cloudant_short_notm}} ライト・プランまたは標準プランへのマイグレーション

Shared プランまたは Enterprise プランから {{site.data.keyword.cloudant_short_notm}} ライト・プランまたは標準プランにマイグレーションするには、以下の手順で説明する作業を行います。 

Shared プラン・インスタンスをライト・プラン・インスタンスまたは標準プラン・インスタンスに直接変更することはできません。マイグレーションするには、新しいライト・プラン・インスタンスまたは標準プラン・インスタンスを作成し、Shared プラン・インスタンスからデータを複製する必要があります。
{: tip}

### ステップ 1: {{site.data.keyword.cloud_notm}} に登録する

まだ登録していない場合、[{{site.data.keyword.cloud_notm}} アカウントを登録します](https://www.ibm.com/cloud/)。 

### ステップ 2: {{site.data.keyword.cloudant_short_notm}} インスタンスを作成する

{{site.data.keyword.cloud_notm}} アカウントにログインした後、{{site.data.keyword.cloudant_short_notm}} サービスを追加します。ダッシュボードで`「リソースの作成」`ボタンをクリックした後、`「データベース」`および`「Cloudant」`をクリックします。詳しくは、[how to create an {{site.data.keyword.cloudant_short_notm}} instance on {{site.data.keyword.cloud_notm}}](../tutorials/create_service.html#creating-an-ibm-cloudant-instance-on-ibm-cloud)を参照してください。 

![{{site.data.keyword.cloudant_short_notm}} インスタンスの追加](../tutorials/images/img0003.png)

### ステップ 3: {{site.data.keyword.cloudant_short_notm}} 用にアプリケーションが準備できているかどうか確認する

{{site.data.keyword.cloudant_short_notm}} Enterprise サービス・プランまたは {{site.data.keyword.cloudant_short_notm}} Shared プランから移行する場合、{{site.data.keyword.cloudant_short_notm}} のアプリケーションの使用状況に再アクセスして、標準プランのキャパシティー制限に対処する準備ができているか確認する必要があります。詳しくは、[how the {{site.data.keyword.cloudant_short_notm}} API works](../offerings/bluemix.html#provisioned-throughput-capacity)を参照してください。最も重要なのは、プロビジョンされたスループット・キャパシティーを超過した場合に、アプリケーションが `429: too many requests` HTTP 応答に対処できるか確認することです。 

`429` 応答が返される要求は、トラフィックが急増してプランのキャパシティーを超過しても再試行できます。アプリケーション・トラフィックにより定期的に `429` 応答が生成される場合、大規模なプランにアップグレードするよい機会です。

また、{{site.data.keyword.cloudant_short_notm}} では、個々の文書の最大サイズが 1 MB であることにも注意する必要があります。この制限を超過すると、`413: request entity too large` メッセージを受け取ります。詳しくは、[要求および文書のサイズ制限](../offerings/bluemix.html#request-and-document-size-limits)を参照してください。 

### ステップ 4: 古いサービスから新しいサービスにデータをマイグレーションする 

既存のサービスから {{site.data.keyword.cloudant_short_notm}} アカウントへの継続的な複製をセットアップします。詳しくは、[複製ガイド](../guides/replication_guide.html#replication)、および複製タスクのセットアップおよびモニター方法に関する [API 資料](../api/replication.html#replication)を参照してください。

また、[`couchreplicate`](https://www.npmjs.com/package/couchreplicate) ツールを使用します。このツールは、{{site.data.keyword.cloudant_short_notm}} の一方のアカウントから他方のアカウントへのデータの移行をコーディネートできるコマンドライン・ユーティリティーです。このツールにより、ソース・アカウントとターゲット・アカウント間で複数の複製ジョブがセットアップされ、多数の複製ジョブが一度に実行されます。数百のデータベースをマイグレーションする必要がある場合、`couchreplicate` は複製ジョブをコーディネートするのに役立ちます。

![`couchreplicate`](https://raw.githubusercontent.com/glynnbird/couchreplicate/HEAD/img/couchreplicate.gif)

新しいサービスにデータをすべて複製したこと、および索引が作成されたことを確認します。

### ステップ 5: テストする

実動に移行する前に、アプリケーションに対して負荷テストおよび機能テストを実施して、問題がないことを確認します。

### ステップ 6: 新しいインスタンスに移行する準備ができたか確認する

新しいインスタンスに移行する準備ができたら、{{site.data.keyword.cloudant_short_notm}} インスタンスの自動生成された新しいアカウント URL と資格情報を使用してアプリケーションを更新します。詳しくは、{{site.data.keyword.cloudant_short_notm}} インスタンスのサービス資格情報の取得方法に関する[プロビジョニング・チュートリアル](../tutorials/create_service.html#creating-a-cloudant-instance-on-bluemix)を参照してください。

### ステップ 7: 古いサービスをオフにする

 アプリケーションを {{site.data.keyword.cloudant_short_notm}} ライト・インスタンスまたは標準インスタンスに完全にマイグレーションした後、{{site.data.keyword.cloud_notm}} コンソールから古い {{site.data.keyword.cloudant_short_notm}} Shared プラン・インスタンスを削除して、そのサービスに対して以後課金されないようにすることができます。

## FAQ - よくあるご質問

{{site.data.keyword.IBM_notm}} のお客様が {{site.data.keyword.cloud_notm}} の {{site.data.keyword.cloudant_short_notm}} ライト・プラン・インスタンスまたは標準プラン・インスタンスにマイグレーションできるよう支援するために、{{site.data.keyword.cloudant_short_notm}} でよくあるご質問 (FAQ) が公開されています。

## 処理を実行する前にデータをバックアップできますか?

{{site.data.keyword.cloudant_short_notm}} では、[couchbackup](../guides/backup-cookbook.html#cloudant-nosql-db-backup-and-recovery) ユーティリティーを使用してディスクにデータをエクスポートすることを推奨しています。[{{site.data.keyword.cloud_notm}} オブジェクト・ストレージ](https://www.ibm.com/cloud/object-storage)は、エクスポートされたファイルを保管するための安価でスケーラブルなソリューションです。 

## `username.cloudant.com` ドメインを保持し、{{site.data.keyword.cloudant_short_notm}} の新しいサービスにこのドメインをリダイレクトできますか?

いいえ。ドメインは保持できません。{{site.data.keyword.cloudant_short_notm}} インスタンスに対して生成された新しいアカウント URL と資格情報を使用するために、アプリケーションの更新を計画する必要があります。

## 質問がある場合は誰に問い合わせればよいですか?

マイグレーションに関する質問がある場合、[{{site.data.keyword.cloudant_short_notm}} サポート担当者](mailto:support@cloudant.com)に問い合わせるか、{{site.data.keyword.cloudant_short_notm}} ダッシュボード内からチケットをオープンしてください。{{site.data.keyword.cloudant_short_notm}} サポート担当者が詳しくご説明いたします。
