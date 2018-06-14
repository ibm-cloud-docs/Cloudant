---

copyright:
  years: 2015, 2018
lastupdated: "2018-03-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

# データウェアハウジング

## {{site.data.keyword.cloudant_short_notm}} の {{site.data.keyword.dashdbshort_notm}} フィーチャーの非推奨 (2018 年 2 月 7 日)
{: #deprecating-cloudant-nosql-db-s-db2-warehouse-on-cloud-feature-february-7-2018-}

{{site.data.keyword.cloudantfull}} の {{site.data.keyword.dashdblong}} フィーチャーは非推奨であり、以下の予定表に従って廃止されます。データはいずれのシステムからも削除されませんが、同期は停止されます。 

非推奨日付 | 非推奨となる対象
-----------------|--------------------------
2018 年 1 月 16 日 | 「Warehouse」タブは、「Warehouse」タブで {{site.data.keyword.dashdbshort_notm}} ジョブを既に作成した {{site.data.keyword.cloudant_short_notm}} サービス・インスタンスでのみ使用可能です。{{site.data.keyword.dashdbshort_notm}} ジョブを作成していない場合は、このフィーチャーにはアクセスできなくなります。
2018 年 3 月 31 日   | 1 月 16 日より前に {{site.data.keyword.dashdbshort_notm}} 機能の使用を開始したお客様は、新規の {{site.data.keyword.dashdbshort_notm}} ジョブを作成できません。
2018 年 5 月 5 日      | 既存の {{site.data.keyword.dashdbshort_notm}} ジョブは停止されます。最終状況はダッシュボードで引き続き表示できます。
2018 年 5 月 31 日     | {{site.data.keyword.dashdbshort_notm}} 機能へのユーザー・インターフェースが削除されます。{{site.data.keyword.dashdbshort_notm}} ジョブの状況は使用できなくなります。
 
2018 年 4 月 30 日までに {{site.data.keyword.dashdbshort_notm}} に転送されたデータは {{site.data.keyword.dashdbshort_notm}} 内に残り、{{site.data.keyword.cloudant_short_notm}} データも影響を受けません。

### {{site.data.keyword.dashdbshort_notm}} フィーチャーの代替

{{site.data.keyword.cloudant_short_notm}} 文書の抽出と
{{site.data.keyword.dashdbshort_notm}} テーブルへのデータの書き込みに関するチュートリアルについては、[data-flow-examples リポジトリー ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://github.com/cloudant-labs/data-flow-examples){:new_window} を参照してください。


## データウェアハウジングの概要

データベースは、データの保管に不可欠です。
しかし、そのデータをビジネス目的に適用できること、つまり関連するデータを素早く容易に取り出し、そのデータをアプリケーション内に入れて機能させられることが、データベースを価値あるものにします。
{:shortdesc}

しかし、それらのデータを使用して実行する多くの保管タスク、処理タスク、および分析タスクは、アプリケーションで何回も繰り返し使用されます。
あるいは、それらは業界最良実例の良い例である可能性があります。

したがって、標準のデータベースの機能を、レポート作成や分析などのタスクをサポートする追加機能によって拡張することは意味があります。

ほぼ 30 年間、「データウェアハウス」は、リレーショナル・データベース・テクノロジーに基づいたデータ・ストレージ、レポート作成、および分析の業界標準でした。
一般に、[データウェアハウスは、![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://en.wikipedia.org/wiki/Data_warehouse){:new_window}「1 つ以上のソースからの統合されたデータの中央リポジトリーです。現行データおよび履歴データを保管します。企業全体の知識労働者のために分析を実行し、レポートを作成するために使用できます。」

データ・ストレージ、レポート作成、および分析を可能にするテクノロジーは、近年、「[ビッグデータ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://en.wikipedia.org/wiki/Big_data){:new_window}」を処理するニーズへの対応として台頭しました。「ビッグデータとは、従来のデータ処理アプリケーションでは対処できないほど巨大で複雑なデータ・セットを示す用語です。」

それと同時に、データウェアハウスおよび関連製品のプロパティーと特性は、リレーショナル・データベースを使用してデータウェアハウスを使用可能にすることが、ビッグデータ・タスクにとっても人気のある選択だということを意味しています。

以下の例のように、{{site.data.keyword.cloudant_short_notm}} 機能をリレーショナル・データウェアハウスと統合することについてのメリットを適切に示している多くのユースケースがあります。

## この統合が自分のユース・ケースに適しているかどうか

{{site.data.keyword.cloudant_short_notm}} のウェアハウジング統合は、文書のスキーマを自動的に検出してデータをインテリジェントに {{site.data.keyword.dashdbshort_notm}} または {{site.data.keyword.Db2_on_Cloud_short}} にインポートする、合理化されたプロセスです。{{site.data.keyword.cloudant_short_notm}} でウェアハウスを作成すると、最初にスキーマが自動検出され、次にデータが接続済みの {{site.data.keyword.dashdbshort_notm}} データベースにインポートされます。 

統合は、データに以下の特性がある場合に適しています。

* 大部分が静的なスキーマ・セットがある。スキーマを変更するとウェアハウスの
    再始動が必要となり、これによってデータが最初から再インポートされます。
* 比較的少ない (最大で数万の) 文書をスキャンすることでスキーマを検出できる。スキーマが検出されたら、当然ながら何百万もの
    文書をウェアハウスにインポートできます。
* ウェアハウジングが厳密にリアルタイムである必要はない。更新された文書は通常、
    数秒以内にウェアハウスに表示されますが、これは保証されず、データベースの負荷によって
    異なります。
* {{site.data.keyword.Db2_on_Cloud_short}} ではスキーマが 1,012 のフィールドに制限される。ネストされた
    オブジェクトや大規模な配列を含む多数のフィールドがある JSON 文書は、この制限を超える可能性があります。

## データの結合

クロスドメイン分析のための複数のデータ・ストアからのデータの結合は、リレーショナル・データウェアハウスを使用して、容易に、かつ効率的に実行できます。

データウェアハウスのロード中に、さまざまなソースからのデータが準備され、共通フォーマットに変換されます。
レコードはテーブルに保管され、それらのテーブルを結合して結合分析を有効にするための操作が使用可能です。

リレーショナル・データウェアハウスでの結合の実行は、一部のデータが関係表現 (例えば、マスター・データや参照データなど) で既に使用可能な場合特に有用です。

## 柔軟性

{{site.data.keyword.cloudant_short_notm}} データベースはデータの表記において柔軟です。
例えば、読み取りまたは書き込み中、スキーマは強制されません。

一方で、レポート作成タスクと分析タスクには、明確に定義され、厳密に実施されるモデルが必要です。

文書がリレーショナル・ウェアハウス内で使用可能な場合は、固定されたテーブル定義セットを基にしてモデルを作成することができます。
ロードできるのはテーブル・スキーマに適合する文書のみであり、違反は拒否されます。
固定のリレーショナル・スキーマを使用して、整合したデータでモデルをトレーニングすることができます。

## データ保全性の表明

データウェアハウスは、制約を使用してデータ保全性を表明することができます。
例えば以下のようなことです。

-   2 つのレコードが同じ主キーを持つことはできない。
-   外部キーは、レコードが完全であることを保証する。
-   ビジネス・ルールに照らし合わせてレコードを検証する機能が使用可能である。

固有性、正確性、および完全性は、あらゆるエンタープライズ・サービスにとって必須条件です。
{{site.data.keyword.cloudant_short_notm}} 文書をデータウェアハウスにロードすると、これらの条件を満たすうえで役立ちます。

## {{site.data.keyword.cloudant_short_notm}} およびデータウェアハウジング

データウェアハウスは、成熟した重要なテクノロジーです。
{{site.data.keyword.cloudant_short_notm}} は、リレーショナル・データウェアハウスとの緊密な統合を提供して、このテクノロジーのメリットをユーザーに提供します。

{{site.data.keyword.cloudant_short_notm}} には、[MapReduce ビュー](../api/using_views.html)の形式でさまざまな基本的分析タスクの実行を可能にする、基本的なウェアハウジング機能が組み込まれています。

より高度なウェアハウジング・タスクについては、IBM クラウドをベースとしたウェアハウジング・サービスである [{{site.data.keyword.IBM}} {{site.data.keyword.dashdbshort_notm}}![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://www.ibm.com/analytics/us/en/data-management/data-warehouse/){:new_window} で提供されるフル機能を活用することができます。

{{site.data.keyword.cloudant_short_notm}} を使用する時、以下のような高度なウェアハウジング機能への統合された容易なアクセスを利用できます。

-   リレーショナル・データベース・フォーマットで JSON データを表示する。
-   データに対して SQL ベースの照会を実行する。
-   データから分析を作成する。

これらの高度なウェアハウジング機能は、{{site.data.keyword.cloudant_short_notm}} の自然な補完物である {{site.data.keyword.dashdbshort_notm}} などのサービスを通じて使用可能になります。

あるいは、必要なのは文書のためのリレーショナル・データ・ストアのみであり、ウェアハウジング機能は必要ない場合は、{{site.data.keyword.cloudant_short_notm}} 文書を [{{site.data.keyword.Db2_on_Cloud_short}}](#ibm-db2-on-cloud) サービスにロードすることができます。

## {{site.data.keyword.dashdblong_notm}}

{{site.data.keyword.dashdbshort_notm}} は、分析作業を目的として構築された、クラウド・ベースのデータウェアハウス・サービスです。
{{site.data.keyword.dashdbshort_notm}} は、{{site.data.keyword.cloudant_short_notm}} JSON データに特に適していますが、ロードされる時にデータの構造を調べることにより、さまざまなソースからのデータを受け入れることができます。

詳しくは、[{{site.data.keyword.dashdblong_notm}} の資料 ![ 外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン ")](https://www.ibm.com/support/knowledgecenter/SS6NHC/com.ibm.swg.im.dashdb.kc.doc/welcome.html){:new_window} を参照してください。

## {{site.data.keyword.Db2Hosted_notm}}

[{{site.data.keyword.Db2Hosted_full}} ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://console.ng.bluemix.net/catalog/services/ibm-db2-on-cloud){:new_window} は、IBM SoftLayer® のグローバル・クラウド・インフラストラクチャー上にデータベースを提供します。
この製品は、独自のインフラストラクチャーを管理する際に生じるコスト、複雑さ、およびリスクなしで、オンプレミス Db2 デプロイメントの豊富な機能を提供します。

詳しくは、[{{site.data.keyword.Db2Hosted_short}} の資料 ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://console.ng.bluemix.net/docs/services/DB2OnCloud/index.html#DB2OnCloud){:new_window} を参照してください。

## ウェアハウスの作成

ウェアハウスを作成するには、以下の 2 つの方法を使用できます。

1.  [{{site.data.keyword.cloudant_short_notm}} を使用して {{site.data.keyword.dashdbshort_notm}} ウェアハウスを作成する](#use-cloudant-to-create-a-db2-warehouse-on-cloud-warehouse)
2.  [{{site.data.keyword.cloudant_short_notm}} を既存のウェアハウスに接続する](#connect-cloudant-to-an-existing-warehouse)

### {{site.data.keyword.cloudant_short_notm}} を使用して {{site.data.keyword.dashdbshort_notm}} ウェアハウスを作成する

ウェアハウスを作成するための最もシンプルな方法は、{{site.data.keyword.cloudant_short_notm}} を使用して {{site.data.keyword.Bluemix}} 内に {{site.data.keyword.dashdbshort_notm}} ウェアハウスを作成することです。
これを実行するには、{{site.data.keyword.cloudant_short_notm}} ダッシュボードの `Integrations` タブ内の `Warehouse` タスクで `Create Warehouse` ボタンをクリックします。

![{{site.data.keyword.cloudant_short_notm}} ダッシュボード内の "Create a {{site.data.keyword.dashdbshort_notm}} warehouse" タスクのスクリーン・ショット](../images/createDashDBWH.png)

まだ {{site.data.keyword.Bluemix_notm}} にログインしていない場合は、ログインするよう求められます。

>   **注**: デフォルトで、{{site.data.keyword.cloudant_short_notm}} はウェアハウスの {{site.data.keyword.dashdbshort_notm}} インスタンスを {{site.data.keyword.Bluemix_notm}} 上に作成します。

![{{site.data.keyword.cloudant_short_notm}} ダッシュボード内の "Authenticate to {{site.data.keyword.Bluemix_notm}}" タスクのスクリーン・ショット](../images/authenticateToBluemix.png)

認証が完了したら、{{site.data.keyword.Bluemix_notm}} アカウントを使用して新しい {{site.data.keyword.dashdbshort_notm}} インスタンスを作成することを要求できます。

これを行うには、以下の手順を実行します。

1.  `Warehouse Name` フィールドに、ウェアハウスに使用する名前を指定します。
2.  `Data Sources` フィールドに、{{site.data.keyword.cloudant_short_notm}} 内の既存のデータベースの名前を指定します。
3.  `Create new {{site.data.keyword.dashdbshort_notm}} instance` オプションがフォームで選択されていることを確認します。
4.  `Create Warehouse` ボタンをクリックします。

![{{site.data.keyword.cloudant_short_notm}} ダッシュボード内の "Create Warehouse" タスクのスクリーン・ショット](../images/createWarehouse.png)

### {{site.data.keyword.cloudant_short_notm}} を既存のウェアハウスに接続する

{{site.data.keyword.cloudant_short_notm}} を使用して {{site.data.keyword.dashdbshort_notm}} ウェアハウス・データベースを作成する代わりに、既存の {{site.data.keyword.dashdbshort_notm}} インスタンスに接続することができます。

このプロセスは、[{{site.data.keyword.cloudant_short_notm}} を使用して {{site.data.keyword.dashdbshort_notm}} ウェアハウスを作成すること](#use-cloudant-to-create-a-db2-warehouse-on-cloud-warehouse)と似ていますが、`Create new {{site.data.keyword.dashdbshort_notm}} instance` オプションを選択する代わりに、`{{site.data.keyword.dashdbshort_notm}} service instance` を選択し、既に {{site.data.keyword.Bluemix_notm}} 内に存在する {{site.data.keyword.dashdbshort_notm}} ウェアハウスを選択します。

![{{site.data.keyword.cloudant_short_notm}} ダッシュボード内の "Connect to existing {{site.data.keyword.dashdbshort_notm}} instance" タスクのスクリーン・ショット](../images/existingDashDBInstance.png)

### {{site.data.keyword.Db2_on_Cloud_short}} ウェアハウス・インスタンスを使用する

希望する場合は、{{site.data.keyword.dashdbshort_notm}} の代わりに既存の {{site.data.keyword.Db2_on_Cloud_short}} ウェアハウス・インスタンスに接続することができます。
これを行うには、{{site.data.keyword.cloudant_short_notm}} ダッシュボード内の `DB2` オプションを選択して、既存の {{site.data.keyword.Db2_on_Cloud_short}} インスタンスに接続します。

![{{site.data.keyword.cloudant_short_notm}} ダッシュボード内の "Create a {{site.data.keyword.Db2_on_Cloud_short}} warehouse" タスクのスクリーン・ショット](../images/createDB2WH.png)

{{site.data.keyword.Db2_on_Cloud_short}} インスタンスに接続する場合は、以下の詳細を指定する必要があります。

-   ホスト・アドレス
-   ポート番号
-   データベース名
-   データベースのユーザー ID
-   ユーザー ID のパスワード

>   **注**: このトピックの残りの部分では、{{site.data.keyword.dashdbshort_notm}} をウェアハウス・インスタンスとして取り上げます。
    ただし、{{site.data.keyword.Db2_on_Cloud_short}} のインスタンスを使用している場合、このトピックは同じように適用されます。
    さらに、[{{site.data.keyword.cloudant_short_notm}} から {{site.data.keyword.dashdbshort_notm}} への JSON データのロード![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://developer.ibm.com/clouddataservices../dashdb/get/load-json-from-cloudant-database-in-to-dashdb/){:new_window}方法を説明するチュートリアルも使用可能であり、{{site.data.keyword.Db2_on_Cloud_short}} をウェアハウス・データベースとして使用する例も含まれています。

## ウェアハウス・スキーマ

{{site.data.keyword.cloudant_short_notm}} 内からウェアハウスを初めて作成すると、{{site.data.keyword.dashdbshort_notm}} はデータベース内のデータにとって、可能な限り最良のスキーマを作成し、JSON 文書内の各フィールドが、新しいスキーマ内に対応する項目を持つようにします。
オプションで、ウェアハウスを作成する時、手動で[スキーマをカスタマイズ](#customizing-the-warehouse-schema)することを選択できます。

スキーマが作成されると、ウェアハウスはリレーショナル・フォーマットでデータを保持することができます。
次に、{{site.data.keyword.cloudant_short_notm}} は[複製](../api/replication.html)を行って、ウェアハウス内へのデータベース文書の「初期ロード」を実行し、{{site.data.keyword.dashdbshort_notm}} リレーショナル・データベース内にデータの作業コレクションを提供します。

時間の経過とともに、{{site.data.keyword.cloudant_short_notm}} データベースの内容は変化する可能性があります。
既存のウェアハウスのスキーマは変更できます。

>   **注**: 既存のウェアハウスのスキーマを変更する場合は、{{site.data.keyword.cloudant_short_notm}} データベースのデータをウェアハウス・データベース内に再度複製する必要があります。
    実際には、スキーマを変更すると、ウェアハウスへの新たな「初期ロード」が実行されます。

## ウェアハウスの操作

{{site.data.keyword.cloudant_short_notm}} ウェアハウジングでは、「従来型の」SQL 照会の実行と結果の表示を、すべて {{site.data.keyword.dashdbshort_notm}} コンソール内から実行できます。


![{{site.data.keyword.Bluemix_notm}} 内の "{{site.data.keyword.dashdbshort_notm}} ダッシュボード" のスクリーン・ショット](../images/useDashDBdashboard.png)

外部アプリケーションは、他のすべてのリレーショナル・データベースと同じ方法でデータと対話することができます。
{{site.data.keyword.dashdbshort_notm}} の利点は、他のソースからさらにデータをロードしたり、組み込み分析ツールを使用してデータを分析したりするなどの、他のウェアハウジング・タスクを実行できることです。
{{site.data.keyword.dashdbshort_notm}} は、統計的コンピューティングおよびグラフィックスのための [`'R'` プログラミング言語![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://en.wikipedia.org/wiki/R_%28programming_language%29){:new_window} とソフトウェア環境をサポートしています。
つまり、ユーザーは、線形回帰、「k-means」クラスタリング、および地理情報分析などのデータベース分析タスクの実行を可能にするアルゴリズムにアクセスすることができます。

`RStudio` ツールにより、`'R'` スクリプトを作成することができます。次にそのスクリプトを {{site.data.keyword.dashdbshort_notm}} にアップロードし、ユーザーのデータを使用して実行できます。

{{site.data.keyword.dashdbshort_notm}} での作業について詳しくは、[{{site.data.keyword.dashdblong_notm}} の資料 ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://www.ibm.com/support/knowledgecenter/SS6NHC/com.ibm.swg.im.dashdb.kc.doc/welcome.html){:new_window} を参照してください。

## データおよび構造体を最新に保つ

データは、[複製](../api/replication.html)プロセスを使用して {{site.data.keyword.cloudant_short_notm}} から {{site.data.keyword.dashdbshort_notm}} にロードされます。
つまり、{{site.data.keyword.cloudant_short_notm}} データが更新されたり、何らかの方法で変更されたりした場合は、{{site.data.keyword.dashdbshort_notm}} への文書の複製を再度実行して、分析タスクが最新の情報を使用して作業を継続するようにする必要があります。

通常の {{site.data.keyword.cloudant_short_notm}} 複製と同様に、データは一方向のみに転送されます。ウェアハウスの場合、転送は {{site.data.keyword.cloudant_short_notm}} から {{site.data.keyword.dashdbshort_notm}} の方向に実行されます。
データの初期ロードの後、ウェアハウスは、{{site.data.keyword.cloudant_short_notm}} データベース内の内容の変更をサブスクライブします。
変更はすべて、{{site.data.keyword.cloudant_short_notm}} ソースから {{site.data.keyword.dashdbshort_notm}} ターゲットに複製されます。
つまり、ウェアハウジングは、{{site.data.keyword.cloudant_short_notm}} から {{site.data.keyword.dashdbshort_notm}} への継続的複製の 1 つの形式です。

時間の経過とともに、{{site.data.keyword.cloudant_short_notm}} データベースで構造上の変化が発生する可能性もあります。
これには、JSON 文書へのフィールドの追加や JSON 文書からのフィールドの削除が含まれる場合があります。
これが発生すると、ウェアハウスによって使用されるスキーマが無効になり、その結果として、{{site.data.keyword.cloudant_short_notm}} から {{site.data.keyword.dashdbshort_notm}} に新しいデータが複製される時にエラーが報告される可能性があります。

この問題を解決するために、{{site.data.keyword.cloudant_short_notm}} ウェアハウジングには「再スキャン」機能があります。
これは、{{site.data.keyword.cloudant_short_notm}} データベースの構造を再スキャンし、{{site.data.keyword.dashdbshort_notm}} で必要な新しいスキーマを判別します。
前回のスキャンの時に作成された、{{site.data.keyword.dashdbshort_notm}} 内の古いテーブルは除去され、新しいスキーマを使用して新しいテーブルが作成され、そして最後に、現行の {{site.data.keyword.cloudant_short_notm}} データが新しい「初期ロード」としてロードされます。

再スキャン機能を使用するには、最初に、ウェアハウスが稼働していないことを確認します。
これは、以下の手順で実行します。

1.  {{site.data.keyword.cloudant_short_notm}} ダッシュボード内の `Integrations` タブを選択します。
2.  以下のようにして、`Warehouse` タスクで再スキャンするウェアハウスの名前を見つけます。<br/>![{{site.data.keyword.cloudant_short_notm}} ダッシュボード内の "warehouse" タブのスクリーン・ショット](../images/selectWarehouse.png)
3.  ウェアハウスの名前をクリックします。
    これはリンクになっており、クリックすると、次のようなウェアハウスの詳細ビューが表示されます。<br/>![{{site.data.keyword.cloudant_short_notm}} ダッシュボード内の詳細なウェアハウス・ビューのスクリーン・ショット](../images/viewWarehouseDetail.png)
4.  ウェアハウスの現在の状況を確認します。
    回転している緑色の円は、そのウェアハウスが稼働中であることを示しています。
    ウェアハウスを停止するには、以下のように、Action 列内の `Stop Database` アイコンをクリックします。<br/>![{{site.data.keyword.cloudant_short_notm}} ダッシュボード内の "stop warehouse database" アイコンのスクリーン・ショット](../images/stopWarehouseDatabase.png)
5.  ウェアハウス・データベースが稼働していない場合は、以下のように、Action 列内の `Rescan` アイコンが使用可能になっています。<br/>![{{site.data.keyword.cloudant_short_notm}} ダッシュボード内の Rescan アイコンのスクリーン・ショット](../images/rescanIcon.png)

### ソース・データベースの再スキャン

![ウェアハウス・ソース・データベースの再スキャンを可能にするウィンドウのスクリーン・ショット](../images/rescanSource.png)

`Rescan` アイコンをクリックする時、次の 2 つの選択肢があります。

-   データベースの単純なスキャン。
    これはデフォルト・アクションであり、ウェアハウスを最初に作成した時に実行したデータベースの初期スキャンと非常によく似ています。
-   ウェアハウス・スキーマのカスタマイズ。

デフォルト・アクションの単純な再スキャンを選択すると、ソース・データベースが検査され、新しいウェアハウス・データベース・スキーマが生成されます。
再スキャンが完了するとすぐに、ウェアハウスが開始されます。

ウェアハウス・スキーマをカスタマイズする場合は、`Rescan` ボタンをクリックする前に、`Customize Schema` チェック・ボックスを有効にしてください。

![「Customize Schema」オプションが有効になった「Rescan Source」パネルのスクリーン・ショット](../images/rescanSource2.png)

`Customize Schema` チェック・ボックスは、以下の 2 つのオプションを有効にします。

1.  使用されるディスカバリー・アルゴリズム。
2.  サンプル・サイズ。

### ディスカバリー・アルゴリズム

再スキャンのデフォルト・オプションは、`Union` アルゴリズムです。
これは、すべてのサンプリングした {{site.data.keyword.cloudant_short_notm}} データベース文書内のすべての属性を使用して、ウェアハウス・データベース内に単一のテーブル・セットを作成します。
この結果、すべての {{site.data.keyword.cloudant_short_notm}} データベース文書をウェアハウス・データベースに保管できますが、データベース内のいくつかの行では、一部のフィールドに内容が含まれない可能性があります。

再スキャンの代替オプションは、`Cluster` アルゴリズムです。
これは、同じ属性セットを持つ、{{site.data.keyword.cloudant_short_notm}} データベース内の文書を識別し、次に、対応するウェアハウス・データベースのテーブル・スキーマを作成します。

### サンプル・サイズ

このオプションは、スキーマ判別の一部として {{site.data.keyword.cloudant_short_notm}} データベース内の何個の文書を検査するかを決定します。

デフォルト値は 10,000 文書です。

この値の設定をあまりに低くすると、一部の {{site.data.keyword.cloudant_short_notm}} 文書が、検出されない属性を持ち、そのためにウェアハウス・データベース構造から除去されるリスクが生じます。

この値の設定をあまりに高くすると、ウェアハウス・データベース構造を判別するためのスキャン・プロセスの完了までの時間が長くなります。

### 再スキャンの後

{{site.data.keyword.cloudant_short_notm}} データベースの再スキャンが終了すると、ウェアハウスは自動的に開始されません。
代わりに停止状態のままとなるため、ウェアハウス・データベースのカスタマイズが可能になります。

## ウェアハウス・スキーマのカスタマイズ

初期ウェアハウス作成プロセス中、または再スキャンの後に、自動的に決定されるデータベース・スキーマを変更することができます。
これを実行するには、作成プロセス中に `Customize Schema` オプションにチェック・マークを付けるようにしてください。

![「Customize Schema」オプションが有効になったことを示しているウェアハウス作成パネルのスクリーン・ショット](../images/customizeSchema01.png)

ウェアハウスは、通常どおり {{site.data.keyword.dashdbshort_notm}} 内に作成されますが、即時開始されません。
代わりに、先に進む前にスキーマをカスタマイズする機会があります。

これを実行するには、以下に示す、ウェアハウスのリンクをクリックします。

![「Open in {{site.data.keyword.dashdbshort_notm}}」ボタンのスクリーン・ショット。](../images/openInDashDB.png)

結果として表示された画面に、ソース・データベースに使用されるスキーマをカスタマイズするためのボタンが提供されます。
Status 標識の上にマウスを移動して、スキーマでカスタマイズの準備ができていることを確認します。

![「Customize <source database name>」ボタンのスクリーン・ショット](../images/customizeSchema02.png)

「Customize」ボタンをクリックすると、以下のようにデータベース・スキーマ内のフィールドを変更できるパネルが表示されます。

![Customize Schema パネルのスクリーン・ショット](../images/customizeSchema03.png)

スキーマをデフォルトにリセットするには、以下の `Rescan` ボタンをクリックします。

![「Rescan」ボタンのスクリーン・ショット](../images/customizeSchema04.png)

ウェアハウスのデータベース・スキーマに満足したら、以下の `Run` ボタンをクリックします。

![「Run」ボタンのスクリーン・ショット](../images/customizeSchema05.png)

スキーマが保存され、ウェアハウスが開始されます。

### 既存のウェアハウス・スキーマのカスタマイズ

ウェアハウスのデータベース・スキーマが既に存在する場合は、[それをカスタマイズするオプション](#keeping-the-data-and-structure-fresh)があります。

## トラブルシューティング

ウェアハウジング機能を使用している時に、問題に遭遇することが時々あります。
これらの問題のいくつかに関する情報を、このトピックでこの後に提供します。

さらに、いくつかの一般的なエラーや問題の説明、およびそれらのトラブルシューティング方法は、[スタック・オーバーフロー ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](http://stackoverflow.com/questions/tagged/cloudant+dashdb){:new_window} から入手可能です。

さらなるヘルプが必要で、スタック・オーバーフローでソリューションが見つからない場合は、[{{site.data.keyword.cloudant_short_notm}} サポート![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](mailto:support@cloudant.com){:new_window} までお問い合わせください。

### ダッシュボードで見られる例外

ウェアハウスでエラー条件が検出されることが時々あります。
例えば、既存の {{site.data.keyword.Db2_on_Cloud_short}} データベースを使用してウェアハウスの作成を試行したが、正しいデータベース詳細を入力できず、ウェアハウスを正常に作成できないことがあります。

エラー条件が存在する場合、ウェアハウスの状況は赤い円に変わり、注意が必要な問題があることを示しています。

![エラー状況標識のスクリーン・ショット](../images/errorIndicator1.png)

標識の上にマウスを「移動」すると、もう少し情報が表示されます。

![エラー状況の移動サマリーを示すスクリーン・ショット](../images/errorIndicator2.png)

標識をクリックするとウィンドウが表示され、その問題のより詳しい情報が提供されます。
以下の例では、{{site.data.keyword.Db2_on_Cloud_short}} 接続について入力されたホスト詳細が無効でした。

![エラー状況の移動サマリーを示すスクリーン・ショット](../images/errorIndicator3.png)

### 警告およびエラー

{{site.data.keyword.cloudant_short_notm}} データベースでの変更は、ウェアハウス・データベースに複製されます。
変更がウェアハウスまたはスキーマに適合しない可能性もあります。
この種類の問題は、検出され、ウェアハウス・データベースの `OVERFLOW` テーブルに記録されます。

例えば、ウェアハウス・スキーマは `VARCHAR` 型の `Movie_earnings_rank` フィールドを持っていて、最大 32 文字を保持できますが、{{site.data.keyword.cloudant_short_notm}} データベースでの変更に 40 文字のストレージが必要な場合、そのフィールドは「オーバーフロー」します。
これにより「警告」条件が作成され、以下のようにウェアハウス・ダッシュボードの status アイコンに示されます。

![status アイコン内の警告メッセージを示すスクリーン・ショット](../images/overflowWarning.png)

以下のように、ウェアハウス・データベース内の、示されたオーバーフロー・テーブルを見ると、警告に関する詳細が表示されています。

![ウェアハウス・データベースのオーバーフロー・テーブル内に警告メッセージの詳細を示しているスクリーン・ショット](../images/overflowWarningDetail.png)

この例で、警告は、切り捨てが発生し、`70f6284d2a395396dbb3a60b4cf1cac2` の `_ID` を持つ {{site.data.keyword.cloudant_short_notm}} 文書の `Movie_earnings_rank` フィールドに影響を与えていることを明らかにしています。

以下の 2 つのソリューション・オプションが使用可能です。

-   {{site.data.keyword.cloudant_short_notm}} 文書内のオーバーフローしているフィールドを修正する。
-   [ウェアハウス・スキーマを更新する](#customizing-the-warehouse-schema)。

選択するオプションは、フィールド内の追加内容が意図的なものかそうでないかによって決まります。
アプリケーションにその追加内容が必要な場合は、[ウェアハウス・スキーマを更新](#customizing-the-warehouse-schema)して警告条件を削除する必要があります。

より重大な問題は、まったく新しいフィールドが {{site.data.keyword.cloudant_short_notm}} データベース内の文書に導入されたが、そのフィールドが、ウェアハウス・データベース・スキーマ内に対応するフィールドを持っていない場合です。
これにより「エラー」条件が発生します。

例えば、以下のように、{{site.data.keyword.cloudant_short_notm}} データベース内の文書が、ウェアハウス・データベース・スキーマ内に存在しない `my key` という名前の追加フィールドを「取得」する場合があります。

![文書内の追加の「my key」フィールドを示すスクリーン・ショット](../images/extraField.png)

結果として、以下のように、ウェアハウス・ダッシュボードの status アイコンに示されているエラー条件が生成されます。

![status アイコン内のエラー・メッセージを示すスクリーン・ショット](../images/overflowError.png)

以下のように、ウェアハウス・データベース内の示されたオーバーフロー・テーブルを見ると、エラーに関する詳細が表示されています。

![ウェアハウス・データベースのオーバーフロー・テーブル内にエラー・メッセージの詳細を示しているスクリーン・ショット](../images/overflowErrorDetail.png)

この例で、エラーは、ウェアハウス・データベース・スキーマが作成された時にはなかったフィールドを検出したことを明らかにしています。
このフィールド自体は、`70f6284d2a395396dbb3a60b4cf1cac2` の `_ID` を持つ {{site.data.keyword.cloudant_short_notm}} 文書で検出されました。

以下の 2 つのソリューション・オプションが使用可能です。

-   {{site.data.keyword.cloudant_short_notm}} 文書から追加フィールドを削除する。
-   [ウェアハウス・スキーマを更新する](#customizing-the-warehouse-schema)。

選択するオプションは、追加フィールドが意図的なものかそうでないかによって決まります。
アプリケーションにとってこの追加フィールドが必要な場合は、[ウェアハウス・スキーマを更新](#customizing-the-warehouse-schema)してエラー条件を削除することが必要です。
