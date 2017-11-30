---

copyright:
  years: 2015, 2017
lastupdated: "2017-06-09"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-02-23 -->

# IBM Bluemix

{{site.data.keyword.cloudant}} は、[{{site.data.keyword.Bluemix}} サービス ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://console.ng.bluemix.net/catalog/services/cloudant-nosql-db/){:new_window} としても利用可能です。
{:shortdesc}

{{site.data.keyword.Bluemix_short}} は、アプリケーションを構築、実行、および管理するためのオープン・スタンダードのクラウド・プラットフォームです。{{site.data.keyword.Bluemix_notm}} の詳細情報を取得し、使用を開始するには、[ホーム・ページ ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://console.ng.bluemix.net/){:new_window} にアクセスしてください。

## Bluemix Public

{{site.data.keyword.cloudantfull}} は、無料の[ライト・プラン](#lite-plan)、および有料の [標準プラン](#standard-plan)内の複数の構成として利用可能です。[専用プラン](#dedicated-plan)も利用できます。このプランは、標準プランと同じ構成が可能ですが、専用ハードウェア上での提供となります。専用ハードウェアは、他のどのアカウントとも共有されません。つまり、お客様専用となります。専用プラン・インスタンスが[米国のロケーション](#locations)内でプロビジョンされる場合は、オプションで、[HIPAA ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://en.wikipedia.org/wiki/Health_Insurance_Portability_and_Accountability_Act){:new_window} 準拠の構成を選択できます。

以下の表は、各プランのパフォーマンスの指標を要約したものです。

>   **注**: この表の詳細は、2016 年 9 月時点に示されたものです。
現行値については、[{{site.data.keyword.cloudant_short_notm}} サポート![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](mailto:support@cloudant.com){:new_window} までお問い合わせください。
>   **注**: 本文書内の通貨の値はすべて米国ドル ($) です。

<table border='1'>

<tr>
<th>プラン</th><th>ライト</th><th colspan='4'>標準 <i>および</i> 専用</th>
</tr>
<tr>
<td>基本料金 (1 時間当たり)</td>
<td>$0.00</td>
<td colspan='4'><a href="http://cloudant.com/bluemix" target="_blank">料金詳細<img src="../images/launch-glyph.svg" alt="外部リンク・アイコン" title="外部リンク・アイコン"></a> を参照してください。</td>
</tr>
<tr>
<td>プロビジョンされているスループット能力 (1 秒当たりの検索)</td>
<td>20</td>
<td>100</td>
<td>1,000</td>
<td>5,000</td>
<td>20,000</td>
</tr>
<tr>
<td>プロビジョンされているスループット能力 (1 秒当たりの書き込み)</td>
<td>10</td>
<td>50</td>
<td>500</td>
<td>2,500</td>
<td>10,000</td>
</tr>
<tr>
<td>プロビジョンされているスループット能力 (1 秒当たりの照会)</td>
<td>5</td>
<td>5</td>
<td>50</td>
<td>250</td>
<td>1,000</td>
</tr>
<tr>
<td>個々の文書の最大サイズ</td>
<td>1 MB</td>
<td colspan='4'>1 MB</td>
</tr>
<tr>
<td>含まれるディスク・スペース</td>
<td>1 GB</td>
<td colspan='4'>20 GB</td>
</tr>
<tr>
<td>ディスク超過料金 (GB / 時間当たり)</td>
<td>利用不可</td>
<td colspan='4'><a href="http://cloudant.com/bluemix" target="_blank">料金詳細<img src="../images/launch-glyph.svg" alt="外部リンク・アイコン" title="外部リンク・アイコン"></a> を参照してください。</td>
</tr>

</table>

[{{site.data.keyword.cloudant_short_notm}} サービス・インスタンス](#provisioning-a-cloudant-instance-on-bluemix)をプロビジョンする時に、使用するプランを選択できます。デフォルトでは、[ライト・プラン](#lite-plan)が選択されます。

![Cloudant サービス・インスタンスのプラン選択](../images/fb87416a.png)

### ライト・プラン

ライト・プランは無料ですが、データ・ストレージが最大 1 GB に制限されます。さらに、検索、書き込み、および照会についての、プロビジョンされているスループット能力にも制限が適用されます。 

ストレージ使用量は毎日チェックされます。ストレージ制限を超えると、アカウントへの HTTP 要求は、「アカウントがデータ使用割り当て量を超えました。有料プランへのアップグレードが必要です」というエラー・メッセージを含む 402 状況コードを受け取ります。通知のバナーも Cloudant ダッシュボードに表示されます。データの読み取りと削除はまだ実行できます。しかし、新しいデータを書き込むには、有料アカウントにアップグレードするか、データを削除し、アカウントを再アクティブ化するための次のチェックが実行されるまで待たなければなりません。 

1 GB を超えるデータを保管したい場合やスループット能力を増大したい場合は、[標準プラン](#standard-plan)に移行してください。

### 標準プラン

標準プランには、20 GB のデータ・ストレージが含まれています。20 GB を超えるデータを保管する場合は、GB/時間当たりで定義されているコストを請求されます。現在のコストについては、[料金![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](http://cloudant.com/bluemix){:new_window} の情報を参照してください。標準プランでは、検索、書き込み、および照会の、プロビジョンされているスループット能力の量も変更できます。

### 専用プラン

{{site.data.keyword.cloudant_short_notm}} は、[{{site.data.keyword.Bluemix_notm}} Dedicated ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](http://www.ibm.com/cloud-computing/bluemix/dedicated/){:new_window} 構成の一部として、単一テナントの専用ハードウェアで使用可能です。

<div id="servicetier"></div>

## サービス層

ご使用のアカウントで使用可能なプラン内のスループット能力の詳細を確認することができます。使用するプロビジョニングのレベルは、{{site.data.keyword.cloudant_short_notm}} アカウント・ダッシュボードの「Account」タブを介して選択できます。

![アカウント・ダッシュボード](../images/cloudant_capacity.png)

別のスループット能力に移行するには、使用したいプロビジョニングを選択し、次に `Change Capacity` オプション・ボタンを選択します。変更を確認するよう求められ、プロビジョニングの変更完了までに最大で 24 時間かかる可能性があるという注意喚起が表示されます。

![アカウント・ダッシュボード](../images/cloudant_capacity_change.png)

<div id="throughput"></div>

### プロビジョンされているスループット能力

スループットのプロビジョンは、以下の 3 種類のイベントの 1 つとして識別および測定されます。

1.	検索。つまり、文書の `_id` に基づいた特定の文書の読み取り。
2.	書き込み。つまり、個別の文書の作成、変更、または削除、あるいは索引作成に起因する更新。
3.	照会。つまり、以下のタイプを含む、{{site.data.keyword.cloudant_short_notm}} 照会エンドポイントのいずれかに対して行われる要求。
	-	1 次索引 ([`_all_docs`](../api/database.html#get-documents))
	-	MapReduce ビュー ([`_view`](../api/creating_views.html#using-views))
	-	検索索引 ([`_search`](../api/search.html#queries))
	-	地理情報索引 ([`_geo`](../api/cloudant-geo.html#querying-a-cloudant-geo-index))
	-	Cloudant 照会 ([`_find`](../api/cloudant_query.html#finding-documents-using-an-index))
	-	変更 ([`_changes`](../api/database.html#get-changes))

スループットの測定は、1 秒当たりの各タイプのイベント数の単純なカウントです。ここでの秒は_スライディング_・ウィンドウです。プランでプロビジョンされているスループット・イベント数をアカウントが超えると、スライディング・ウィンドウ内のイベント数が、プロビジョンされている数を超えなくなるまで、要求は拒否されます。1 秒のスライディング・ウィンドウを、1,000 ミリ秒の連続期間と考えるとわかりやすいかもしれません。

例えば、1 秒当たり 200 個の検索のプロビジョンで標準プランを利用している場合、アカウントは、連続する 1,000 ミリ秒 (1 秒) の期間中に最大 200 個の検索要求を行う可能性があります。1,000 ミリ秒のスライディング期間中に行われる、その後の検索要求は、その期間内の検索要求数が再び 200 個未満に減少するまで拒否されます。

イベント数を超えているために要求が拒否されると、アプリケーションは [`429` Too Many Requests](../api/http.html#429) 応答を受け取ります。

サポートされているクライアント・ライブラリー ([Java](../libraries/supported.html#java)、[Node.js](../libraries/supported.html#node-js)、および [Python](../libraries/supported.html#python) の各言語用) の最新バージョンは、`429` 応答の処理に役立ちます。例えば、Java ライブラリーは、[`TooManyRequestsException` ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](http://static.javadoc.io/com.cloudant/cloudant-client/2.5.1/com/cloudant/client/org/lightcouch/TooManyRequestsException.html){:new_window} をスローします。

デフォルトで、サポートされているクライアント・ライブラリーは、`429` 応答を受け取った時、自動的に要求の再試行を実行しません。

ご使用のアプリケーションで `429` 応答が正しく処理されることを確認することをお勧めします。この理由は、再試行回数が制限されているからです。要求数をたびたび超過することは、別のプラン構成への移行を示す強力な指標です。

>   **注**: 既存のアプリケーションを移植する場合、`429` 応答を処理できない場合があります。マイグレーション検査の一部として、アプリケーションで `429` 応答が正しく処理されることを確認してください。
つまり、ご使用のアプリケーションが [`429`](../api/http.html#429) 応答を正しく処理できることを確実にする必要があります。

### 個々の文書の最大サイズ

データは、{{site.data.keyword.cloudant_short_notm}} 内に [JSON 文書](../api/document.html)として保管されます。{{site.data.keyword.Bluemix_notm}} 上の {{site.data.keyword.cloudant_short_notm}} サービス内の文書の場合、個別の文書の最大サイズは 1 MB です。この制限を超えると、[`413` エラー](../api/http.html#413)になります。

### 含まれるディスク・スペース

この値は、プランに含まれているストレージ容量です。これは、データと索引両方のストレージに使用されます。

### ディスク超過料金

すべての標準プランおよびライト・プランのサービス・インスタンスでは、使用されているディスク・スペースがモニターされています。ご使用のプラン構成で提供されているストレージ量より多くの量がアカウントで使用されると、「オーバーフロー」と見なされます。オーバーフローでは、プラン割り振りを超えて使用された追加の GB ごとに、示された金額でアカウントに料金が請求されます。

プランで提供されているディスク・スペースを超えて使用した分に対して支払わなければならない追加の金額は、「超過料金」と呼ばれます。超過料金は、時間ベースで計算されます。ライト・プランで使用可能なディスク・スペースをオーバーフローすることは不可能です。

例えば、標準プラン・インスタンスで、半日 (12 時間) にわたりディスク使用量が 107 GB に増加したと仮定します。この変化は、12 時間にわたり、インスタンスで、20 GB のプラン割り振りより 87 GB 多いオーバーフローが発生したことを意味します。したがって、その追加スペースに対し、87 GB x 12 時間 = 1044 GB 時間の計算に基づいて超過料金が請求されます。

超過料金の計算は、請求処理サイクル内のある特定の時間中の、プラン割り振りを超える最大 GB 数を使用して行われます。

### 計算された超過料金の例

9 GB のストレージを使用する標準プランのサービス・インスタンスで 1 か月 (30 日間) を開始したと仮定します。次に、ストレージは、3 日目の 02:00 時から 15 分間、21.5 GB まで増加します。02:00 時台の次の 10 分間、インスタンスは 9.5 GB まで減少し、その後 02:00 時台の次の 25 分間、108 GB に増加します。最後に、インスタンスは 28 GB まで減少してその時間を終了し、実際、その月の残りも 28 GB で終了します。

このパターンは、プラン割り振りを超える最大 GB 数は、3 日目の 2 時台に 88 GB だったことを意味します。3 日目の 03:00 時台とこの月の残りに関しては、インスタンスがプラン割り振りを超えていた量は 8 GB でした。

したがって、3 日目の 02:00 時台については、88 GB x 1 時間 = 88 GB 時間に基づいて超過料金を請求されます。

3 日目の 03:00 時から 3 日目の終わりまでは、8 GB x 21 時間 = 168 GB 時間に基づいて請求されます。

4 日目の 00:00 時からその月 (30 日間) の終わりまでについては、8 GB x 24 時間 x 27 日 = 5184 GB 時間に基づいて請求されます。

この月の超過料金の合計額の請求は、88 + 168 + 5184 = 5440 GB 時間に基づいて行われます。

## ロケーション

デフォルトで、専用プランを除くすべてのプランは、マルチテナント・クラスターに基づいています。プラン選択の一部として、以下の {{site.data.keyword.Bluemix_notm}}Public 地域から選択できます。

-   米国南部
-   英国
-   シドニー
-   ドイツ

## セキュリティー、暗号化、およびコンプライアンス

すべてのプランは、[at-rest ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://en.wikipedia.org/wiki/Data_at_rest){:new_window} ディスク暗号化を使用してサーバー上に提供されます。HTTPS を使用してネットワーク接続でのアクセスは暗号化されます。詳しくは、[DBaaS Security ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://cloudant.com/product/cloudant-features/dbaas-security/){:new_window} を参照してください。

これらのプランは、[セキュリティー・コンプライアンス認証 ![ 外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://cloudant.com/product/cloudant-features/cloudant-compliance/){:new_window} も提供しています。
[HIPAA ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://en.wikipedia.org/wiki/Health_Insurance_Portability_and_Accountability_Act){:new_window} コンプライアンスには [Dedicated 環境](#dedicated-plan)が必要なため、[プロビジョニング・プロセス](#provisioning-a-cloudant-instance-on-bluemix)の一部としてこの環境を要求します。

## 高可用性、災害復旧、およびバックアップ

データ・センター内で高可用性 (HA) および災害復旧 (DR) を提供するため、すべてのデータは、クラスター内の 3 つの別々の物理サーバーに三重に保管されます。複数のデータ・センター内にアカウントをプロビジョンし、次に継続的データ複製を使用して、複数のデータ・センターにわたって HA/DR を提供することができます。

{{site.data.keyword.cloudant_short_notm}} データは、自動的にバックアップされません。[増分バックアップ機能](../guides/backup-guide.html)の使用可能化を要求するか、代わりに、[ここ ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://developer.ibm.com/clouddataservices/2016/03/22/simple-couchdb-and-cloudant-backup/){:new_window} に記載されている複数の使用可能な手法のいずれかを使用して独自のソリューションを実装できます。  

## 使用状況のモニタリング

使用量に関する情報は、{{site.data.keyword.cloudant_short_notm}} ダッシュボード内の「Activity」タブの「Usage」ペインで使用可能です。

![ダッシュボードでの使用量のモニタリング](../images/cloudant_usage.png)

現在の[スループット](#throughput)と、[保管データ](#disk-space-included)の量が示された詳細が提供されています。

モニタリングは、プランでのプロビジョニングの変更が推奨される可能性があることを認識するのに役立ちます。例えば、データベース検索の最大数に頻繁に近づく場合は、ダッシュボードの「Account」タブの[「Service」ペイン](#servicetier)を介してプロビジョニングを変更できます。

## ハードウェアの仕様

専用プランを除き、すべてのプランはマルチテナント・クラスターで実装されます。すべてのデータは、高可用性とデータ復旧のために、3 つの別々の物理ノード上に三重に保管されます。

## サポート

標準プランおよび専用プランのサービス・インスタンスのサポートはオプションです。「{{site.data.keyword.Bluemix_notm}} 標準サポート」を購入することにより提供されます。ライト・プランでは、サポートは利用できません。

{{site.data.keyword.Bluemix_notm}} 標準サポートの料金カリキュレーターは、[ここ ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://console.ng.bluemix.net/?direct=classic/#/pricing/cloudOEPaneId=pricing&paneId=pricingSheet){:new_window} から利用できます。サポートの SLA の詳細に関する情報は、[ここ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](http://www-03.ibm.com/software/sla/sladb.nsf/pdf/6606-08/$file/i126-6606-08_05-2016_en_US.pdf){:new_window} から入手できます。

## Bluemix での Cloudant インスタンスのプロビジョニング

{{site.data.keyword.cloudant_short_notm}} インスタンスを {{site.data.keyword.Bluemix_notm}} 上にプロビジョンするには、次の 2 つの方法があります。

-	ダッシュボードを使用する。このプロセスを説明するチュートリアルは[ここ](../tutorials/create_service.html)にあります。
-	Cloud Foundry コマンド・ツールを使用する。このプロセスを説明するチュートリアルは[ここ](../tutorials/create_service_cli.html)にあります。
