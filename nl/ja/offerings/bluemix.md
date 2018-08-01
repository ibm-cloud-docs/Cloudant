---

copyright:
  years: 2015, 2018
lastupdated: "2018-06-07"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2018-06-05 -->

# {{site.data.keyword.Bluemix_notm}} Public
{: #ibm-cloud-public}

{{site.data.keyword.cloudantfull}} Public は、最も豊富な機能を備えた {{site.data.keyword.cloudant_short_notm}} のオファリングであり、最初に更新と新しいフィーチャーを受け取ります。 料金はスループットとストレージの要件に基づいており、必要などのような負荷にも適しています。 

無料の[ライト・プラン](#lite-plan)には、開発と評価のために、
固定されたスループット能力とデータ量が含まれます。有料の[標準プラン](#standard-plan)では、
アプリケーション要件の変更に合わせて増減される、
構成可能なプロビジョン済みのスループット能力とデータ・ストレージの料金を提供します。専用ハードウェア環境で 1 つ以上の標準プラン・インスタンスを実行するために、追加の月次料金でオプションの[専用ハードウェア・プラン](#dedicated-hardware-plan)を利用することもできます。 専用ハードウェア環境は自分専用であり、
専用ハードウェア・プラン・インスタンスが米国のロケーション内でプロビジョンされる場合は、
オプションで [HIPAA ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://en.wikipedia.org/wiki/Health_Insurance_Portability_and_Accountability_Act){:new_window} 準拠の構成を選択できます。

以下の表に、ライト・プランでプロビジョンされるスループット能力とディスク・スペース構成、
および標準プランのいくつかの例の要約を示します。

<div id="maxtable"></div>

<table border='1'>

<tr>
<th id="plans">プラン</th><th id="lite">ライト</th><th id="standard" colspan='4'>標準</th>
</tr>
<tr>
<th id="base-priceperhour" headers="plans">基本料金 (1 時間当たり)</td>
<td headers="lite base-priceperhour">$0.00</td>
<td headers="standard base-priceperhour" colspan='4'><a href="../offerings/pricing.html#pricing" target="_blank">料金詳細<img src="../images/launch-glyph.svg" alt="外部リンク・アイコン" title="外部リンク・アイコン"></a> を参照してください。</td>
</tr>
<tr>
<th id="provisionedthroughputcapacity-lookupspersecond" headers="plans">プロビジョンされているスループット能力 (1 秒当たりの検索)</td>
<td headers="lite provisionedthroughputcapacity-lookupspersecond-lite">20</td>
<td headers="standard provisionedthroughputcapacity-lookupspersecond">100</td>
<td headers="standard provisionedthroughputcapacity-lookupspersecond">1,000</td>
<td headers="standard provisionedthroughputcapacity-lookupspersecond">5,000</td>
<td headers="standard provisionedthroughputcapacity-lookupspersecond">20,000</td>
</tr>
<tr>
<th id="provisionedthroughputcapacity-writespersecond" headers="plans">プロビジョンされているスループット能力 (1 秒当たりの書き込み)</td>
<td headers="lite provisionedthroughputcapacity-writespersecond">10</td>
<td headers="standard provisionedthroughputcapacity-writespersecond">50</td>
<td headers="standard provisionedthroughputcapacity-writespersecond">500</td>
<td headers="standard provisionedthroughputcapacity-writespersecond">2,500</td>
<td headers="standard provisionedthroughputcapacity-writespersecond">10,000</td>
</tr>
<tr>
<th id="provisionedthroughputcapacity-queriespersecond" headers="plans">プロビジョンされているスループット能力 (1 秒当たりの照会)</td>
<td headers="lite provisionedthroughputcapacity-queriespersecond">5</td>
<td headers="standard provisionedthroughputcapacity-queriespersecond">5</td>
<td headers="standard provisionedthroughputcapacity-queriespersecond">50</td>
<td headers="standard provisionedthroughputcapacity-queriespersecond">250</td>
<td headers="standard provisionedthroughputcapacity-queriespersecond">1,000</td>
</tr>
<tr>
<th headers="diskspaceincluded" headers="plans">含まれるディスク・スペース</td>
<td headers="lite diskspaceincluded">1 GB</td>
<td headers="standard diskspaceincluded" colspan='4'>20 GB</td>
</tr>
<tr>
<th headers="diskoveragepergbhour" headers="plans">ディスク超過料金 (GB / 時間当たり)</td>
<td headers="lite diskoveragepergbhour">利用不可</td>
<td headers="standard diskoveragepergbhour" colspan='4'><a href="../offerings/pricing.html#pricing" target="_blank">料金詳細<img src="../images/launch-glyph.svg" alt="外部リンク・アイコン" title="外部リンク・アイコン"></a> を参照してください。</td>
</tr>

</table>

## プラン
{: #plans}

[{{site.data.keyword.cloudant_short_notm}} サービス・インスタンス](#provisioning-a-cloudant-instance-on-bluemix)をプロビジョンする時に、使用するプランを選択できます。
デフォルトでは、[ライト・プラン](#lite-plan)が選択されます。

![{{site.data.keyword.cloudant_short_notm}} サービス・インスタンスのプラン選択](../images/fb87416a.png)

### ライト・プラン
{: #lite-plan}

ライト・プランは無料ですが、データ・ストレージが最大 1 GB に制限されます。
さらに、検索、書き込み、および照会についての、プロビジョンされているスループット能力にも制限が適用されます。 

ストレージ使用量は毎日チェックされます。 ストレージ制限を超えると、アカウントへの HTTP 要求は、「アカウントがデータ使用割り当て量を超えました。有料プランへのアップグレードが必要です」というエラー・メッセージを含む 402 状況コードを受け取ります。
通知のバナーも {{site.data.keyword.cloudant_short_notm}} ダッシュボードに表示されます。 データの読み取りと削除はまだ実行できます。 しかし、新しいデータを書き込むには、有料アカウントにアップグレードするか、データを削除し、アカウントを再アクティブ化するための次のチェックが実行されるまで待たなければなりません。 

1 GB を超えるデータを保管したい場合やスループット能力を増大したい場合は、[標準プラン](#standard-plan)に移行してください。

### 標準プラン
{: #standard-plan}

標準プランには、20 GB のデータ・ストレージが含まれています。
20 GB を超えるデータを保管する場合は、GB/時間当たりで定義されているコストを請求されます。
現在のコストについては、[料金](../offerings/pricing.html#pricing){:new_window}情報を参照してください。
標準プランでは、検索、書き込み、および照会の、プロビジョンされているスループット能力の量も変更できます。

### 専用ハードウェア・プラン
{: #dedicated-hardware-plan}

あるいは、月次料金でどの [{{site.data.keyword.IBM}} データ・センター ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://www.ibm.com/cloud-computing/bluemix/data-centers) 内でも専用ハードウェア環境上で標準プラン・インスタンスを
実行できます。特定のロケーション用の単一の専用ハードウェア・プランを購入したら、
そのロケーション上で 1 つ以上の標準プラン・インスタンスをプロビジョンできます。このプランは
HIPAA のコンプライアンスのために必要であり、プロビジョン時に選択する必要があります。 

{{site.data.keyword.Bluemix_notm}} Dedicated のお客様は専用ハードウェア・プランを利用できず、{{site.data.keyword.Bluemix_notm}} Public のお客様のみが使用できます。{: tip}

## プロビジョンされているスループット能力
{: #provisioned-throughput-capacity}

スループットのプロビジョンは、以下のタイプのいずれかのイベントとして識別および測定されます。

1.	検索。つまり、文書の `_id` に基づいた特定の文書の読み取り。
2.	書き込み。つまり、個別の文書の作成、変更、または削除、あるいは索引作成に起因する更新。
3.	照会。つまり、以下のタイプを含む、{{site.data.keyword.cloudant_short_notm}} 照会エンドポイントのいずれかに対して行われる要求。
	-	1 次索引 ([`_all_docs`](../api/database.html#get-documents))
	-	MapReduce ビュー ([`_view`](../api/creating_views.html#using-views))
	-	検索索引 ([`_search`](../api/search.html#queries))
	-	地理情報索引 ([`_geo`](../api/cloudant-geo.html#querying-a-cloudant-geo-index))
	-	{{site.data.keyword.cloudant_short_notm}} 照会 ([`_find`](../api/cloudant_query.html#finding-documents-using-an-index))

スループットの測定は、1 秒当たりの各タイプのイベント数の単純なカウントです。ここでの秒は_スライディング_・ウィンドウです。
プランでプロビジョンされているスループット・イベント数をアカウントが超えると、スライディング・ウィンドウ内のイベント数が、プロビジョンされている数を超えなくなるまで、要求は拒否されます。
1 秒のスライディング・ウィンドウを、1,000 ミリ秒の連続期間と考えるとわかりやすいかもしれません。

例えば、標準プランは毎秒 200 回のルックアップ用にプロビジョンされます。アカウントでは、連続する 1,000 ミリ秒 (1 秒) の期間中に最大 200 個の検索要求を行うことができます。1,000 ミリ秒のスライディング期間中に行われる、その後の検索要求は、その期間内の検索要求数が再び 200 個未満に減少するまで拒否されます。

イベント数を超えているために要求が拒否されると、アプリケーションは [`429` Too Many Requests](../api/http.html#429) 応答を受け取ります。

サポートされているクライアント・ライブラリー ([Java](../libraries/supported.html#java)、[Node.js](../libraries/supported.html#node-js)、および [Python](../libraries/supported.html#python) の各言語用) の最新バージョンは、`429` 応答の処理に役立ちます。
例えば、
Java ライブラリーは、
[`TooManyRequestsException` ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](http://static.javadoc.io/com.cloudant/cloudant-client/2.5.1/com/cloudant/client/org/lightcouch/TooManyRequestsException.html){:new_window} 応答を生成します。

デフォルトで、サポートされているクライアント・ライブラリーは、`429` 応答を受け取った時、自動的に要求の再試行を実行しません。

ご使用のアプリケーションで `429` 応答が正しく処理されることを確認することをお勧めします。
この理由は、再試行回数が制限されているからです。要求数をたびたび超過することは、別のプラン構成への移行を示す強力な指標です。

既存のアプリケーションを移植する場合、`429` 応答を処理できない場合があります。マイグレーション検査の一部として、アプリケーションで `429` 応答が正しく処理されることを確認してください。
{: tip}

つまり、ご使用のアプリケーションが [`429`](../api/http.html#429) 応答を正しく処理できることを確実にする必要があります。

<div id="servicetier"></div>

### 能力の表示および変更
{: #viewing-and-changing-capacity}

ご使用のアカウントで使用可能なプラン内のスループット能力の詳細を確認することができます。
使用するプロビジョニングのレベルは、{{site.data.keyword.cloudant_short_notm}} アカウント・ダッシュボードの「Account」タブを介して選択できます。

![アカウント・ダッシュボード](../images/cloudant_capacity.png)

別のスループット能力に移行するには、必要なプロビジョニングを選択してから、
`「更新」`をクリックします。変更を確認するよう求められ、プロビジョニングの変更完了までに最大で 24 時間かかる可能性があるという注意喚起が表示されます。

![アカウント・ダッシュボード](../images/cloudant_capacity_change.png)

<div id="throughput"></div>

### 使用状況のモニタリング 
{: #monitoring-usage}

使用状況に関する情報は、{{site.data.keyword.cloudant_short_notm}} ダッシュボード内の「Monitoring」タブの「Current Operations」ペインで使用可能です。 

![ダッシュボードでの使用量のモニタリング](../images/cloudant_usage.png)

現在の[スループット](#provisioned-throughput-capacity)と、[保管データ](#disk-space-included)の量が示された詳細が提供されています。

モニタリングは、プランでのプロビジョニングの変更が推奨される可能性があることを認識するのに役立ちます。
例えば、データベース検索の最大数に頻繁に近づく場合は、ダッシュボードの「Account」タブの[「Service」ペイン](#servicetier)を介してプロビジョニングを変更できます。

## データ使用量
{: #data-usage}

### 含まれるディスク・スペース
{: #disk-space-included}

この値は、プランに含まれているストレージ容量です。
これは、データと索引両方のストレージに使用されます。

### ディスク超過料金
{: #disk-overage}

すべての標準プランおよびライト・プランのサービス・インスタンスでは、使用されているディスク・スペースがモニターされています。
ご使用のプラン構成で提供されているストレージ量より多くの量がアカウントで使用されると、「オーバーフロー」と見なされます。
オーバーフローでは、プラン割り振りを超えて使用された追加の GB ごとに、示された金額でアカウントに料金が請求されます。

プランで提供されているディスク・スペースを超えて使用した分に対して支払わなければならない追加の金額は、「超過料金」と呼ばれます。
超過料金は、時間ベースで計算されます。
ライト・プランで使用可能なディスク・スペースをオーバーフローすることは不可能です。

例えば、標準プラン・インスタンスで、半日 (12 時間) にわたりディスク使用量が 107 GB に増加したと仮定します。
この変化は、12 時間にわたり、インスタンスで、20 GB のプラン割り振りより 87 GB 多いオーバーフローが発生したことを意味します。
したがって、その追加スペースに対し、87 GB x 12 時間 = 1044 GB 時間の計算に基づいて超過料金が請求されます。

超過料金の計算は、請求処理サイクル内のある特定の時間中の、プラン割り振りを超える最大 GB 数を使用して行われます。

### ディスク超過料金の例
{: #disk-overage-example}

9 GB のストレージを使用する標準プランのサービス・インスタンスで 1 か月 (30 日間) を開始したと仮定します。
次に、ストレージは、3 日目の 02:00 時から 15 分間、21.5 GB まで増加します。
02:00 時台の次の 10 分間、インスタンスは 9.5 GB まで減少し、その後 02:00 時台の次の 25 分間、108 GB に増加します。
最後に、インスタンスは 28 GB まで減少してその時間を終了し、実際、その月の残りも 28 GB で終了します。

このパターンは、プラン割り振りを超える最大 GB 数は、3 日目の 2 時台に 88 GB だったことを意味します。
3 日目の 03:00 時台とこの月の残りに関しては、インスタンスがプラン割り振りを超えていた量は 8 GB でした。

したがって、3 日目の 02:00 時台については、
請求には、88 GB x 1 時間 = 88 GB 時間に基づいた超過料金が含まれます。

3 日目の 03:00 時から 3 日目の終わりまでについては、
請求には、8 GB x 21 時間 = 168 GB 時間に基づいた超過料金が含まれます。

4 日目の 00:00 時からその月 (30 日間) の終わりまでについては、
請求には、8 GB x 24 時間 x 27 日 = 5184 GB 時間に基づいた超過料金が含まれます。

この月の超過料金の合計額の請求は、88 + 168 + 5184 = 5440 GB 時間に基づいて行われます。

## 要求および文書のサイズ制限
{: #request-and-document-size-limits}

{{site.data.keyword.cloudant_short_notm}} JSON 文書および要求には、
以下の最大サイズ制限があります。 

制限 | 最大サイズ
------|-------------
個別文書サイズ | 1 MB
単一の添付ファイルのサイズ | 10 MB
要求本体のサイズ | 11 MB

これらの制限のいずれかを超えると、[413 応答](../api/http.html#413)になります。

バイナリー添付ファイルまたは大きな JSON Blob はオブジェクト・ストレージに保管し、そのロケーションへのリンクを {{site.data.keyword.cloudant_short_notm}} JSON 文書に保存することをお勧めします。   

複製する場合、これらの制限を超える文書または添付ファイルは、
ターゲット・データベースに複製されません。複製エラーの検出方法について詳しくは、
[ここ](../api/replication.html#replication-errors)を参照してください。

## ロケーションとテナンシー
{: #locations-and-tenancy}

デフォルトでは、すべてのライト・プラントと標準プランがマルチテナント環境にデプロイされます。 プラン選択の一部として、以下の {{site.data.keyword.Bluemix_notm}}Public 地域から選択できます。

-   米国東部
-   米国南部
-   英国
-   シドニー
-   ドイツ&Dagger;

専用ハードウェア・プラン・インスタンスは、ほとんどの
[{{site.data.keyword.IBM_notm}} データ・センター・ロケーション ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://www.ibm.com/cloud-computing/bluemix/data-centers) にデプロイできます。 
使用可能なロケーションの最新のリストについては、{{site.data.keyword.Bluemix_notm}} カタログでドロップダウン・メニューを確認してください。

&Dagger; {{site.data.keyword.Bluemix_notm}} Public ドイツ地域からデプロイされたすべての {{site.data.keyword.cloudant_short_notm}} インスタンスは、
EU 管理環境でデプロイされます。EU 管理環境外で生成された {{site.data.keyword.cloudant_short_notm}}
アカウントや API キーでは、EU 管理
{{site.data.keyword.cloudant_short_notm}} インスタンスに対するアクセスは
許可されません。

## セキュリティー、暗号化、およびコンプライアンス
{: #security-encryption-and-compliance}

すべてのプランは、[at-rest ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://en.wikipedia.org/wiki/Data_at_rest){:new_window} ディスク暗号化を使用してサーバー上に提供されます。
HTTPS を使用してネットワーク接続でのアクセスは暗号化されます。
詳しくは、[{{site.data.keyword.Bluemix_notm}}セキュリティー ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://console.bluemix.net/docs/services/Cloudant/offerings/security.html#security){:new_window} を参照してください。

これらのプランは、[セキュリティー・コンプライアンス認証 ![ 外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://cloudant.com/product/cloudant-features/cloudant-compliance/){:new_window} も提供しています。
[HIPAA ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://en.wikipedia.org/wiki/Health_Insurance_Portability_and_Accountability_Act){:new_window} コンプライアンスには [Dedicated 環境](#dedicated-hardware-plan)が必要なため、[プロビジョニング・プロセス](#provisioning-a-cloudant-instance-on-bluemix)の一部としてこの環境を要求します。

<div id="byok"></div>

保存時の暗号化で BYOK (Bring-Your-Own-Key) が必要な場合、この暗号化は、
{{site.data.keyword.cloud}} の鍵の保護を使用して有効化されます。{{site.data.keyword.cloudant_short_notm}} では、
すべての地域でデプロイされる新しい {{site.data.keyword.cloudant_short_notm}}
[専用ハードウェア・プラン](https://console.bluemix.net/docs/services/Cloudant/offerings/bluemix.html#ibm-cloud-public)・インスタンスでこの機能をサポートします。まず、
[{{site.data.keyword.cloud_notm}} カタログ](https://console.bluemix.net/catalog/)を使用して、専用ハードウェア・プラン・インスタンスを作成します。次に、
サポート・チケットを送信します。新規専用ハードウェア・インスタンスの保存時の暗号化用の暗号鍵の取得をサポート・チームが調整します。
この暗号鍵は、鍵の保護インスタンスによって管理されます。

## 高可用性、災害復旧、およびバックアップ
{: #high-availability-disaster-recovery-and-backup}

データ・センター内で高可用性 (HA) および災害復旧 (DR) を提供するため、すべてのデータは、クラスター内の 3 つの別々の物理サーバーに三重に保管されます。 複数のデータ・センター内にアカウントをプロビジョンし、次に継続的データ複製を使用して、複数のデータ・センターにわたって HA/DR を提供することができます。 {{site.data.keyword.cloudant_short_notm}} データは自動的にバックアップされませんが、  バックアップを処理するためにサポートされるツールが用意されています。アプリケーション要件を満たすための、HA、DR、およびバックアップのすべての考慮事項を調べるには、[「災害復旧およびバックアップ」のガイド ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://console.bluemix.net/docs/services/Cloudant/guides/disaster-recovery-and-backup.html#disaster-recovery-and-backup) を参照してください。 

## サポート
{: #support}

標準プランおよび専用プランのサービス・インスタンスのサポートはオプションです。
「{{site.data.keyword.Bluemix}} 標準サポート」を購入することにより提供されます。
ライト・プランでは、サポートは利用できません。

{{site.data.keyword.Bluemix_notm}} 標準サポートの料金カリキュレーターは、[ここ ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://console.ng.bluemix.net/?direct=classic/#/pricing/cloudOEPaneId=pricing&paneId=pricingSheet){:new_window} から利用できます。
サポートの SLA の詳細に関する情報は、[ここ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](http://www-03.ibm.com/software/sla/sladb.nsf/pdf/6606-08/$file/i126-6606-08_05-2016_en_US.pdf){:new_window} から入手できます。

## {{site.data.keyword.Bluemix_notm}} での {{site.data.keyword.cloudant_short_notm}} インスタンスのプロビジョニング
{: #provisioning-a-cloudant-nosql-db-instance-on-ibm-cloud}

{{site.data.keyword.Bluemix}} 上で {{site.data.keyword.cloudant_short_notm}} ライト・プラン・インスタンスまたは標準プラン・インスタンスをプロビジョンするには、次の 2 つの方法があります。

- ダッシュボードを使用する。 このプロセスを説明するチュートリアルは[ここ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://console.bluemix.net/docs/services/Cloudant/tutorials/create_service.html#creating-a-cloudant-instance-on-bluemix){:new_window}にあります。
- Cloud Foundry コマンド・ツールを使用する。 このプロセスを説明するチュートリアルは[ここ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://console.bluemix.net/docs/services/Cloudant/tutorials/create_service_cli.html#creating-a-cloudant-instance-on-bluemix-using-the-cloud-foundry-tools){:new_window}にあります。
 
{{site.data.keyword.cloudant_short_notm}} 専用ハードウェア・プラン・インスタンスを作成して活用するには、[ここ ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://console.bluemix.net/docs/services/Cloudant/tutorials/create_dedicated_hardware_plan.html#creating-and-leveraging-a-cloudant-dedicated-hardware-plan-instance-on-bluemix){:new_window} でプロセスを説明するチュートリアルに従ってください。




