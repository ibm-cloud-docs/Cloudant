---

copyright:
  years: 2015, 2019
lastupdated: "2019-06-12"

keywords: curl and jq basics, monitor view builds and search indexes, estimate time to complete task, monitor replication, troubleshooting

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

<!-- Acrolinx: 2018-08-14 -->

# {{site.data.keyword.cloud_notm}} での {{site.data.keyword.cloudant_short_notm}} へのマイグレーション
{: #migrating-to-ibm-cloudant-on-ibm-cloud}

[{{site.data.keyword.cloudantfull}} ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://www.ibm.com/cloud/cloudant){: new_window} の Database as a Service オファリングは、マルチテナント・クラスターで実行される JSON 文書ストアです。 このサービスは、地理的位置を選択することで使用でき、そのコスト、スケーラビリティー、およびサービス・レベル・アグリーメント (SLA) は予測可能です。

この資料では、次のいずれかのプランから、{{site.data.keyword.cloud_notm}} での {{site.data.keyword.cloudant_short_notm}} ライト・プラン・インスタンスまたは標準プラン・インスタンスにマイグレーションする方法について説明します。

プラン | 説明
-----|------------
{{site.data.keyword.cloudant_short_notm}} Enterprise | 専用のシングル・テナント・クラスター
{{site.data.keyword.cloudant_short_notm}} Shared プラン | 従来の従量課金 (PAYG) 制のマルチテナント {{site.data.keyword.cloudant_short_notm}} サービス。 `cloudant.com` Shared プランは、2018 年 3 月に廃止されました。 {{site.data.keyword.cloudant_short_notm}} Shared プランは、2016 年 10 月に新規のお申し込みについて非推奨となり、2018 年の第 4 四半期に廃止される予定です。
{{site.data.keyword.cloudant_localfull}} | {{site.data.keyword.cloudant_short_notm}} のセルフホスト型のパッケージ・インストール。
Apache CouchDB | {{site.data.keyword.cloudant_short_notm}} のベースとなるセルフホスト型のオープン・ソース・データベース。

## {{site.data.keyword.cloudant_short_notm}} ライト・プランおよび標準プランにはどのような利点がありますか?
{: #what-are-the-benefits-of-the-ibm-cloudant-lite-and-standard-plans-}

標準プランを使用すると、データベース・サービスの*スループット・キャパシティーを予約*できます。つまり、アプリケーションのデータベースで要求を処理するために必要となるスループットを指定できます。 また標準プランでは、使用するストレージ量に対しても課金されます。 キャパシティーは、次のメトリックを使用して測定されます。

メトリック | 説明
-------|------------
1 秒当たりの読み取り | `_id` による文書の取得やパーティション・キーを使用したパーティション・データベースに対する照会など、単純な文書フェッチが実行される速度。
1 秒当たりの書き込み数 | データがデータベースに書き込まれる速度。 文書の作成、更新、または削除を処理する API 呼び出しは「書き込み」としてカウントされます。
1 秒当たりのグローバル照会 | グローバル索引を使用してデータベースが照会される速度。通常は、`_find` エンドポイントにアクセスしたり、2 次 MapReduce 索引、検索索引、または地理情報索引などを使用したりします。
ストレージ | JSON データ、添付ファイル、および 2 次索引が占有するディスク・スペースの量。

例えば、ライト・プランでは、1 秒当たり 20 回の読み取り、1 秒当たり 10 回の書き込み、1 秒当たり 5 回のグローバル照会、および 1 GB のストレージが無料で提供されます。 このプランは、製品の「品質検査をする」場合および製品の開発時に最適です。 アプリケーションを QA または実働で実行する場合は、インスタンスをスケーリングするために標準プランに切り替えます。 標準プランの最小容量では、1 カ月当たり $76.65 USD で、1 秒当たり 100 回の読み取り、1 秒当たり 50 回の書き込み、1 秒当たり 5 回のグローバル照会、および 20 GB のストレージ (追加ストレージは GB 単位で課金されます) が提供されます。 

{{site.data.keyword.cloudant_short_notm}} ダッシュボードのスライダーを使用することで、必要に応じていつでも {{site.data.keyword.cloudant_short_notm}} サービスの予約キャパシティーを減らすことや増やすことができます。

![スライダー](../images/migrate2.gif)

スループット・キャパシティーを変更できる量は、1 回の変更当たり最大で 10 単位に制限され (スライダーの「変更制限 (change limit)」ポイントに注意してください)、 1 時間当たり最大で 1 回変更できます。 キャパシティーを変更して減らす場合、無制限に減らすことができますが、回数の制限は適用されます。
{: tip}

所定の 1 時間の枠内で選択された最も高いキャパシティーについて料金が請求されます。 季節的な需要に対処するためにデータベース・スループットを増やすことができ、また平穏時にはスループットを再び減らすことができます。 どのような場合でも、1 月当たりの料金は予測可能で、アップグレードは自動的に行われ、また SLA は [99.95% ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](http://www-03.ibm.com/software/sla/sladb.nsf/sla/bm?OpenDocument){: new_window} です。

1 秒当たりの読み取り、書き込み、およびグローバル照会の割り当て量を超過した場合、{{site.data.keyword.cloudant_short_notm}} API は、『`HTTP 429 要求が多すぎます`』応答を返します。 アプリケーションは、後で要求を再試行する場合があります。公式のライブラリーでは、指数バックオフを使用してこのような要求を再試行するオプションが提供されています。 

## どのタイプの {{site.data.keyword.cloudant_short_notm}} プランを現在使用しているか確認できますか?
{: #which-type-of-ibm-cloudant-plan-do-i-have-}

{{site.data.keyword.cloudant_short_notm}} を使用している場合は、{{site.data.keyword.cloud_notm}} ダッシュボードに移動し、**「メニュー」**アイコン > **「リソース・リスト」**をクリックしてすべてのサービス・インスタンスを表示します。 

![クラウド・ダッシュボード](../images/ibmclouddashboard.png)

また、特定のインスタンスにドリルダウンし、「プラン」タブを表示して詳細を確認することもできます。 非推奨の Shared プランの {{site.data.keyword.cloudant_short_notm}} インスタンスでは、プランは強調表示されません。 {{site.data.keyword.cloudant_short_notm}} 標準プランのインスタンスは、次の例のようになります。 

![標準ダッシュボード](../images/ibmcloud_instance_standard_plan.png)

また、{{site.data.keyword.cloudant_short_notm}} ダッシュボードを開き、**「アカウント」**タブをクリックすることもできます。 ライト・プランは、次の例のようになります。

![ライト・プラン](../images/migrate1.png)

従来の `cloudant.com` アカウントを使用している場合、{{site.data.keyword.cloudant_short_notm}} ダッシュボードにログインし、「アカウント」タブに移動できます。 従来の `cloudant.com` Shared プランには「使用量」タブがあり、当月のグラフおよび請求見積もりが表示されます。以下に例を示します。

![Shared プラン](../images/cloudantcom_sharedplan_usage.png)

専用クラスターの `cloudant.com` Enterprise のユーザーには、「アカウント」タブで「使用量」タブは表示されません。 以下に例を示します。

![Enterprise プラン](../images/cloudantcom_enterpriseplan_account.png)

「アカウント」タブで標準プランを使用していることが示されている場合、この先を読む必要はありません。 支払い済みの SLA 支援 {{site.data.keyword.cloudant_short_notm}} サービスを既に使用しています。 これ以上のアクションは不要です。

## {{site.data.keyword.cloudant_short_notm}} ライトから {{site.data.keyword.cloudant_short_notm}} 標準へのマイグレーション
{: #migrating-from-ibm-cloudant-lite-to-ibm-cloudant-standard}

無料のライト・プランから標準プランにマイグレーションするには、次の手順に従います。 

1.  {{site.data.keyword.cloud_notm}} ダッシュボードに移動します。
2.  **「メニュー」**アイコン > **「リソース・リスト」**に移動して、すべてのサービス・インスタンスを表示します。 
3.  マイグレーションする {{site.data.keyword.cloudant_short_notm}} インスタンスを選択します。 
4.  メニューで**「プラン」**タブを選択します。 
5.  価格プランのリストから、**「標準」**チェック・ボックスを選択します。
![ライト](../images/migrate3.png)
6.  **「アップグレード」**をクリックします。
既存のデータはすべて保持されます。

必要に応じて、スループット・キャパシティー・スライダーを使用してキャパシティーを増減させ、キャパシティーを調整します。
{: tip} 
 
これで完了です。

## 他のすべてのプランから {{site.data.keyword.cloudant_short_notm}} ライト・プランまたは標準プランへのマイグレーション
{: #migrating-everything-else-to-ibm-cloudant-lite-or-standard-plan}

Shared プランまたは Enterprise プランから {{site.data.keyword.cloudant_short_notm}} ライト・プランまたは標準プランにマイグレーションするには、以下の手順で説明する作業を行います。 

Shared プラン・インスタンスをライト・プラン・インスタンスまたは標準プラン・インスタンスに直接変更することはできません。 マイグレーションするには、新しいライト・プラン・インスタンスまたは標準プラン・インスタンスを作成し、Shared プラン・インスタンスからデータを複製する必要があります。 
{: tip}

### ステップ 1: {{site.data.keyword.cloud_notm}} に登録する
{: #step-1-sign-up-for-ibm-cloud}

まだ登録していない場合、[{{site.data.keyword.cloud_notm}} アカウントを登録します ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://www.ibm.com/cloud/){: new_window}。 

### ステップ 2: {{site.data.keyword.cloudant_short_notm}} インスタンスを作成する
{: #step-2-create-an-ibm-cloudant-instance}

{{site.data.keyword.cloud_notm}} アカウントにログインした後、{{site.data.keyword.cloudant_short_notm}} サービスを追加します。 ダッシュボードで`「リソースの作成」`ボタンをクリックした後、`「データベース」`および`「Cloudant」`をクリックします。 詳しくは、[how to create an {{site.data.keyword.cloudant_short_notm}} instance on {{site.data.keyword.cloud_notm}}](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud#creating-an-ibm-cloudant-instance-on-ibm-cloud)を参照してください。 

![{{site.data.keyword.cloudant_short_notm}} インスタンスの追加](../tutorials/images/img0003.png)

### ステップ 3: {{site.data.keyword.cloudant_short_notm}} 用にアプリケーションが準備できているかどうか確認する
{: #step-3-find-out-whether-your-application-is-ready-for-ibm-cloudant}

{{site.data.keyword.cloudant_short_notm}} Enterprise サービス・プランまたは {{site.data.keyword.cloudant_short_notm}} Shared プランから移行する場合、{{site.data.keyword.cloudant_short_notm}} のアプリケーションの使用状況に再アクセスして、標準プランのキャパシティー制限に対処する準備ができているか確認する必要があります。 詳しくは、[how the {{site.data.keyword.cloudant_short_notm}} API works](/docs/services/Cloudant?topic=cloudant-ibm-cloud-public#provisioned-throughput-capacity)を参照してください。 最も重要なのは、プロビジョンされたスループット・キャパシティーを超過した場合に、アプリケーションが `429: too many requests` HTTP 応答に対処できるか確認することです。 

`429` 応答が返される要求の再試行は、トラフィックの不定期かつ一時的な急増によるプランのキャパシティーの超過の場合には許容されます。 アプリケーション・トラフィックにより定期的に `429` 応答が生成される場合、大規模なプランにアップグレードするよい機会です。

また、{{site.data.keyword.cloudant_short_notm}} では、個々の文書の最大サイズが 1 MB であることにも注意する必要があります。この制限を超過すると、`413: request entity too large` メッセージを受け取ります。 詳しくは、[要求および文書のサイズ制限](/docs/services/Cloudant?topic=cloudant-ibm-cloud-public#request-and-document-size-limits)を参照してください。 

### ステップ 4: 古いサービスから新しいサービスにデータをマイグレーションする 
{: #step-4-migrate-data-from-the-old-service-to-the-new-service}

既存のサービスから {{site.data.keyword.cloudant_short_notm}} アカウントへの継続的な複製をセットアップします。 詳しくは、[複製ガイド](/docs/services/Cloudant?topic=cloudant-replication-api#replication-api)、および複製タスクのセットアップおよびモニター方法に関する [API 資料](/docs/services/Cloudant?topic=cloudant-ibm-cloudant-basics#ibm-cloudant-basics)を参照してください。

あるいは、[`couchreplicate`](https://www.npmjs.com/package/couchreplicate) ツールの使用を検討します。このツールは、{{site.data.keyword.cloudant_short_notm}} の一方のアカウントから他方のアカウントへのデータの移行を調整できるようにするためのコマンドライン・ユーティリティーです。 このツールは、ソース・アカウントとターゲット・アカウント間で複数の複製ジョブをセットアップし、限られた数の複製ジョブが一度に実行されるようにします。 数百のデータベースをマイグレーションする必要がある場合、`couchreplicate` は複製ジョブを調整するのに役立ちます。

![`couchreplicate`](https://raw.githubusercontent.com/glynnbird/couchreplicate/HEAD/img/couchreplicate.gif)

新しいサービスにデータをすべて複製したこと、および索引が作成されたことを確認します。

### ステップ 5: テストする
{: #step-5-testing}

実動に移行する前に、アプリケーションに対して負荷テストおよび機能テストを実施して、問題がないことを確認します。

### ステップ 6: 新しいインスタンスに移行する準備ができたか確認する
{: #step-6-ready-to-move-to-the-new-instance-}

新しいインスタンスに移行する準備ができたら、{{site.data.keyword.cloudant_short_notm}} インスタンスに対して新しいアカウント URL と資格情報を使用するようにアプリケーションを更新します。 詳しくは、{{site.data.keyword.cloudant_short_notm}} インスタンスのサービス資格情報の取得方法に関する[プロビジョニング・チュートリアル](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud#creating-an-ibm-cloudant-instance-on-ibm-cloud)を参照してください。

### ステップ 7: 古いサービスをオフにする
{: #step-7-turn-off-the-old-service}

 アプリケーションを {{site.data.keyword.cloudant_short_notm}} ライト・インスタンスまたは標準インスタンスに完全にマイグレーションした後、{{site.data.keyword.cloud_notm}} コンソールから古い {{site.data.keyword.cloudant_short_notm}} Shared プラン・インスタンスを削除して、そのサービスに対して以後課金されないようにすることができます。

## FAQ - よくあるご質問
{: #faq-frequently-asked-questions}

{{site.data.keyword.IBM_notm}} のお客様が {{site.data.keyword.cloud_notm}} の {{site.data.keyword.cloudant_short_notm}} ライト・プラン・インスタンスまたは標準プラン・インスタンスにマイグレーションできるよう支援するために、{{site.data.keyword.cloudant_short_notm}} でよくあるご質問 (FAQ) が公開されています。

## 処理を実行する前にデータをバックアップできますか?
{: #can-i-back-up-my-data-before-doing-anything-}

{{site.data.keyword.cloudant_short_notm}} では、[couchbackup](/docs/services/Cloudant?topic=cloudant-ibm-cloudant-backup-and-recovery#ibm-cloudant-backup-and-recovery) ユーティリティーを使用してディスクにデータをエクスポートすることを推奨しています。 [{{site.data.keyword.cloud_notm}} オブジェクト・ストレージ ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://www.ibm.com/cloud/object-storage){: new_window} は、エクスポートされたファイルを保管するための安価でスケーラブルなソリューションです。 

## `username.cloudant.com` ドメインを保持し、{{site.data.keyword.cloudant_short_notm}} の新しいサービスにこのドメインをリダイレクトできますか?
{: #can-i-keep-my-username-cloudant-com-domain-and-redirect-it-to-the-new-service-on-ibm-cloudant-}

いいえ。ドメインは保持できません。 {{site.data.keyword.cloudant_short_notm}} インスタンスに対して生成された新しいアカウント URL と資格情報を使用するために、アプリケーションの更新を計画する必要があります。

## 質問がある場合は誰に問い合わせればよいですか?
{: #who-do-i-contact-if-i-have-questions-}

マイグレーションに関する質問がある場合、[{{site.data.keyword.cloudant_short_notm}} サポート担当者](mailto:support@cloudant.com)に問い合わせるか、{{site.data.keyword.cloudant_short_notm}} ダッシュボード内からチケットをオープンしてください。 {{site.data.keyword.cloudant_short_notm}} サポート担当者が詳しくご説明いたします。
