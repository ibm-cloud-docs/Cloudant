---

copyright:
  years: 2017, 2019
lastupdated: "2019-03-15"

keywords: create database, create api key for replication, grant access permission, set up replications, test replication, configure application, active-active configuration, active-passive configuration, fail over, recovering from fail over

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

# クロス地域災害復旧のための {{site.data.keyword.cloudant_short_notm}} の構成
{: #configuring-ibm-cloudant-for-cross-region-disaster-recovery}

[{{site.data.keyword.cloudant_short_notm}} 災害復旧ガイド](/docs/services/Cloudant?topic=cloudant-disaster-recovery-and-backup#disaster-recovery-and-backup)では、
災害復旧を有効にする 1 つの方法として、{{site.data.keyword.cloudantfull}} 複製を使用して
地域間での冗長性を作成する方法があると説明しています。

データ・センター間で「アクティブ/アクティブ」または「アクティブ/パッシブ」トポロジーを使用して、{{site.data.keyword.cloudant_short_notm}} で複製を構成できます。

以下の図では、2 つの {{site.data.keyword.cloudant_short_notm}} アカウント (各地域に 1 つずつ) を使用する標準的な構成を示します。

![アクティブ/アクティブ・アーキテクチャーの例](../images/active-active.png)

以下に留意すると、有益です。

* 各データ・センター内で、{{site.data.keyword.cloudant_short_notm}} は、3 つのサーバーで 3 重にデータを保管することで既に高可用性を備えています。
* 複製は、アカウント・レベルではなくデータベースで行われ、明示的に構成する必要があります。
* {{site.data.keyword.cloudant_short_notm}} は、複製の待ち時間についてサービス・レベル・アグリーメント (SLA) も確実性も提供していません。
* {{site.data.keyword.cloudant_short_notm}} は、個別の複製をモニターしません。
  失敗した複製を検出して再始動する独自の対策を使用することをお勧めします。

## アクティブ/アクティブ・デプロイメントを開始する前に
{: #before-you-begin-an-active-active-deployment}

アクティブ/アクティブ・デプロイメントでは、競合を管理するための方策が実装されている必要があります。 そのため、必ず、このアーキテクチャーについて検討する前に、[複製](/docs/services/Cloudant?topic=cloudant-replication-api#replication-api)と[競合](/docs/services/Cloudant?topic=cloudant-document-versioning-and-mvcc#document-versioning-and-mvcc)の仕組みについて理解しておいてください。
{: note}

競合を効果的に処理するためにデータをモデル化する方法について支援が必要な場合は、[{{site.data.keyword.cloudant_short_notm}} サポート ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](mailto:support@cloudant.com){: new_window} にお問い合わせください。

## 概要
{: #overview-active-active}

以下の資料では、双方向の複製を作成します。
この構成では、2 つのデータベースがアクティブ/アクティブ・トポロジーで動作できます。

この構成では、以下の異なる地域の 2 つのアカウントがあるものと想定しています。

* `myaccount-dc1.cloudant.com`
* `myaccount-dc2.cloudant.com`

上記のアカウントがある場合、基本ステップは、以下のようになります。

1. アカウント内にピア・データベースのペアを[作成](#step-1-create-your-databases)します。
2. これらのデータベース間の複製で使用する API キーを[セットアップ](#step-2-create-an-api-key-for-your-replications)します。
3. 該当する許可を付与します。
4. 複製をセットアップします。
5. 複製が期待どおりに機能しているかをテストします。
6. アクティブ/アクティブまたはアクティブ/パッシブのデータベース使用のためにアプリケーションおよびインフラストラクチャーを構成します。

## ステップ 1: データベースを作成する
{: #step-1-create-your-databases}

各アカウント内に複製する[データベースを作成](/docs/services/Cloudant?topic=cloudant-databases#create-database)します。

この例では、`mydb` という名前のデータベースを作成します。

この例でデータベースに使用する名前は重要ではありませんが、同じ名前を使用する方が分かりやすいでしょう。

```sh
curl https://myaccount-dc1.cloudant.com/mydb -XPUT -u myaccount-dc1
curl https://myaccount-dc2.cloudant.com/mydb -XPUT -u myaccount-dc2
```
{: codeblock}

## ステップ 2: 複製用の API キーを作成する
{: #step-2-create-an-api-key-for-your-replications}

連続複製用に [API キー](/docs/services/Cloudant?topic=cloudant-authorization#api-keys)を使用することをお勧めします。
その利点は、(例えば、パスワードのリセット後など) プライマリー・アカウントの詳細が変更された場合でも、複製を変更なしで続行できる点にあります。

API キーは、単一のアカウントに結び付けられません。
この特性は、単一の API キーを作成し、両方のアカウントに対して適切なデータベース許可を付与できることを意味します。

例えば、以下のコマンドでは、アカウント `myaccount-dc1` の API キーを要求しています。

```sh
$ curl -XPOST https://myaccount-dc1.cloudant.com/_api/v2/api_keys -u myaccount-dc1
```
{: codeblock}

成功した応答は、以下の例 (一部省略) のようになります。

```json
{
  "password": "YPN...Tfi",
  "ok": true,
  "key": "ble...igl"
}
```
{: codeblock}

パスワードを慎重にメモしてください。 後からパスワードを取得することはできません。
{: important}

## ステップ 3: アクセス許可を付与する
{: #step-3-grant-access-permission}

両方のデータベースで読み取りおよび書き込みを行うための [API キー許可を付与](/docs/services/Cloudant?topic=cloudant-authorization#modifying-permissions)します。

索引も複製する場合は、管理許可を割り当てます。

{{site.data.keyword.cloudant_short_notm}} ダッシュボードを使用するか、あるいは[許可](/docs/services/Cloudant?topic=cloudant-authorization#authorization)の情報を参照して、許可をプログラムで付与する方法の詳細を確認してください。

## ステップ 4: 複製をセットアップする
{: #step-4-set-up-replications}

{{site.data.keyword.cloudant_short_notm}} における複製は、常に単一方向に (あるデータベースから別のデータベースに対して) 行われます。
そのため、2 つのデータベースで双方向に複製するには、片方向に 1 つずつ、合計 2 つの複製が必要になります。

[前に](#step-2-create-an-api-key-for-your-replications)作成した API キーを使用して、各アカウントで複製を作成します。

まず、データベース `myaccount-dc1.cloudant.com/mydb` からデータベース `myaccount-dc2.cloudant.com/mydb` への複製を作成します。

```sh
curl -XPOST 'https://myaccount-dc1.cloudant.com/_replicator'
	-u myaccount-dc1
	-H 'Content-type: application/json'
	-d '{ "_id": "mydb-myaccount-dc1-to-myaccount-dc2",
	"source": "https://ble...igl:YPN...Tfi@myaccount-dc1.cloudant.com/mydb",
	"target": "https://ble...igl:YPN...Tfi@myaccount-dc2.cloudant.com/mydb",
	"continuous": true
}'
```
{: codeblock}

次に、データベース `myaccount-dc2.cloudant.com/mydb` からデータベース `myaccount-dc1.cloudant.com/mydb` への複製を作成します。

```sh
curl -XPOST 'https://myaccount-dc2.cloudant.com/_replicator'
	-u myaccount-dc2
	-H 'Content-type: application/json'
	-d '{ "_id": "mydb-myaccount-dc2-to-myaccount-dc1",
	"source": "https://ble...igl:YPN...Tfi@myaccount-dc2.cloudant.com/mydb",
	"target": "https://ble...igl:YPN...Tfi@myaccount-dc1.cloudant.com/mydb",
	"continuous": true
}'
```
{: codeblock}

`_replicator` データベースが存在しないためにこのステップが失敗した場合は、そのデータベースを作成してください。
{: note}

## ステップ 5: 複製をテストする
{: #step-5-test-your-replication}

片方のデータベースで文書を作成、変更、および削除して、複製プロセスをテストします。

片方のデータベースで各変更を行った後に、もう片方のデータベースでも変更が反映されていることを確認できるかを調べます。

## ステップ 6: アプリケーションを構成する
{: #step-6-configure-your-application}

この時点で、データベースは、相互に同期を保つようにセットアップされています。

次に決定するのは、データベースを[アクティブ/アクティブ](#active-active)式で使用するのか、[アクティブ/パッシブ](#active-passive)式で使用するのかです。

### アクティブ/アクティブ
{: #active-active}

アクティブ/アクティブ構成では、異なるアプリケーション・インスタンスが異なるデータベースに書き込むことができます。

例えば、アプリケーション「A」がデータベース `myaccount-dc1.cloudant.com/mydb` に書き込む一方で、アプリケーション「B」がデータベース `myaccount-dc2.cloudant.com/mydb` に書き込むことができます。

この構成には、以下のようないくつかの利点があります。

- 負荷を複数のアカウントで分散できる。
- 待ち時間が短い (必ずしも地理的に最も近いわけではありません) アカウントにアクセスするようにアプリケーションを構成できる。

アプリケーションは、「最も近い」{{site.data.keyword.cloudant_short_notm}} アカウントと通信するようにセットアップできます。
DC1 でホストされているアプリケーションの場合、{{site.data.keyword.cloudant_short_notm}} URL を `"https://myaccount-dc1.cloudant.com/mydb"` に設定するのが適切です。
同様に、DC2 でホストされているアプリケーションの場合、その {{site.data.keyword.cloudant_short_notm}} URL を `"https://myaccount-dc2.cloudant.com/mydb"` に設定することになります。

### アクティブ/パッシブ
{: #active-passive}

アクティブ/パッシブ構成では、アプリケーションのすべてのインスタンスが、1 次データベースを使用するように構成されます。
ただし、アプリケーションは、必要な状況になった場合、もう一方のバックアップ・データベースにフェイルオーバーできます。
フェイルオーバーの実装は、アプリケーション・ロジック自体に、またはロード・バランサーを使用して、または他の手段を使用して行うことができます。

フェイルオーバーが必要かどうかを簡単にテストするには、メイン・データベース・エンドポイントをハートビートとして使用します。
例えば、メイン・データベース・エンドポイントに送信されるシンプルな `GET` 要求は通常、[データベースに関する詳細](/docs/services/Cloudant?topic=cloudant-databases#getting-database-details)を返します。
応答を受信しなかった場合、フェイルオーバーが必要であることを示している可能性があります。

### その他の構成
{: #other-configurations}

構成で他のハイブリッド・アプローチを検討できます。

例えば、「1 次に書き込み、レプリカから読み取り」構成では、すべての書き込みは一方のデータベースに対して行われますが、読み取り負荷は、複数のレプリカで分散されます。

## ステップ 7: 次のステップ
{: #step-7-next-steps}

* データベース間の[複製](/docs/services/Cloudant?topic=cloudant-advanced-replication#advanced-replication)をモニターすることを検討します。
  データを使用して、構成をさらに最適化できるかどうかを判別します。
*	設計文書および索引をデプロイおよび更新する方法を検討します。
  これらのタスクを自動化すると、効率化する場合があります。

## {{site.data.keyword.cloudant_short_notm}} 地域間でフェイルオーバーする
{: #failing-over-between-ibm-cloudant-regions}

通常、地域またはデータ・センター間でのフェイルオーバーを管理するプロセスは、アプリケーション・スタック内の高いところで、例えば、アプリケーション・サーバーのフェイルオーバーの変更を構成したり、負荷のバランスを取ったりすることで処理されます。

{{site.data.keyword.cloudant_short_notm}} では、フェイルオーバーを明示的に管理したり、地域間で要求を転送したりするための機能は用意されていません。
この制約があるのは、一つには技術的な理由のためですが、発生する可能性がある状態がアプリケーション固有である傾向があるためでもあります。
例えば、カスタム・パフォーマンス・メトリックに対する応答としてフェイルオーバーを強制したい場合があります。

ただし、フェイルオーバーを管理する機能が必要であると決定した場合、以下のようなオプションが考えられます。

* 独自の [HTTP プロキシーを {{site.data.keyword.cloudant_short_notm}} ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://github.com/greenmangaming/cloudant-nginx){: new_window} の前に配置します。
  {{site.data.keyword.cloudant_short_notm}} インスタンスではなく、プロキシーと通信するようにアプリケーションを構成します。
  この構成は、アプリケーション設定を変更するのではなく、プロキシー構成を変更することで、アプリケーションによって使用される {{site.data.keyword.cloudant_short_notm}} インスタンスを変更するタスクを処理できることを意味します。
  多くのプロキシーは、ユーザー定義のヘルス・チェックに基づいて負荷のバランスを取る機能を備えています。
* [{{site.data.keyword.cloud}} Internet Services ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](/docs/infrastructure/cis/glb.html#global-load-balancer-glb-concepts){: new_window} や [Dyn Traffic Director ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](http://dyn.com/traffic-director/){: new_window} などのグローバル・ロード・バランサーを使用して {{site.data.keyword.cloudant_short_notm}} に経路指定します。
  このオプションでは、ヘルス・チェックまたは待ち時間のルールに基づいて、異なる {{site.data.keyword.cloudant_short_notm}} アカウントに経路指定する `CNAME` の定義が必要です。


## フェイルオーバーからの復旧
{: #recovering-from-fail-over}

単一の {{site.data.keyword.cloudant_short_notm}} インスタンスが到達不能になった場合、再度到達可能になったときにすぐにトラフィックをそのインスタンスに再びリダイレクトすることは避けてください。
これは、ピアからのデータベース状態の同期や確実な索引の最新化などの処理負荷が高いタスクにある程度時間が必要であるためです。

データベースが実動トラフィックの処理に適した状態であるかどうかを判別できるように、これらのタスクをモニターするメカニズムを用意すると、役立ちます。

目安として、適用する検査の標準的リストは、以下のとおりです。

* [複製](#replications)
* [索引](#indexes)

ヘルス・テストに基づいた要求の再ルーティングまたはフェイルオーバーを実装した場合、まだ復旧中のサービス・インスタンスに早まって再ルーティングしてしまわないように、対応する検査を組み込むことをお勧めします。
{: note}

### 複製
{: #replications}

* エラー状態の複製はありますか?
* 再始動が必要な複製はありますか?
* データベースへの複製をまだ待機している保留中の変更はいくつありますか?

[複製状況のモニター](/docs/services/Cloudant?topic=cloudant-advanced-replication#replication-status)に関する詳細を参照してください。

データベースが継続的に変更されている場合、複製状況が 0 になることはあまり考えられません。許容される状況しきい値やエラー状態を表す状況しきい値を決定する必要があります。
{: note}

### 索引
{: #indexes}

* 索引は十分に最新のものですか?
  これは、[アクティブ・タスク](/docs/services/Cloudant?topic=cloudant-active-tasks#active-tasks)・エンドポイントを使用して確認します。
* 照会を索引に送信し、許容時間内に戻るかどうかを判別することで、「索引の準備状況」のレベルをテストします。
