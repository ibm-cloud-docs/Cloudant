---

copyright:
  years: 2015, 2019
lastupdated: "2019-06-12"

keywords: incremental backups, create an incremental backup, restore a database, how to back up example, how to restore example

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

# 増分複製
{: #replication-incrementals}

このガイドには、{{site.data.keyword.cloudantfull}} のバックアップに関する古い、または「非推奨の」ガイダンスが含まれています。 現在のバックアップのガイダンスについては、『[災害復旧およびバックアップ](/docs/services/Cloudant?topic=cloudant-disaster-recovery-and-backup#disaster-recovery-and-backup)』のガイドを参照してください。
{: deprecated}

データベース・バックアップは、潜在的な損失または破損からデータを保護します。
{: shortdesc}

{{site.data.keyword.cloudant_short_notm}} の複製機能を使用してデータベース・バックアップを作成し、それを {{site.data.keyword.cloudant_short_notm}} クラスターに保管することができます。
これにより以後、データ、データベース全体、または特定の JSON 文書を、それらのバックアップから実動クラスターにリストアできます。

{{site.data.keyword.cloudant_short_notm}} の複製を使用して、データベース・バックアップはデータベースの内容をチェックポイントに保管します。
特定のチェックポイントへの「ロールバック」が可能です。
チェックポイントは、正確な時刻に特定ではありません。
そうではなく、バックアップ期間中に特定の変更が発生した後のデータベースの記録です。
このような方法で、バックアップは、選択した時刻のデータベースの状態を保存することができます。

## 増分バックアップ
{: #incremental-backups}

企業のお客様の場合、
毎日の増分バックアップ機能を使用できます。 詳しくは、[災害復旧とバックアップ](/docs/services/Cloudant?topic=cloudant-disaster-recovery-and-backup#disaster-recovery-and-backup)を参照してください。

企業のお客様でない場合、または独自のバックアップを作成することを希望するお客様の場合は、{{site.data.keyword.cloudant_short_notm}} の複製機能を使用してデータベース・バックアップを作成することができます。

単純な方法は、データベース全体を、日付付きのバックアップ・データベースに複製することです。
この方法は効果的で、実行するのが簡単です。
しかし、毎日のバックアップを 7 個と毎週のバックアップ を 4 個など、複数のポイント・イン・タイムのバックアップが必要な場合は、それぞれの新しいバックアップ・データベースにデータベースの完全コピーを保管しなければなりません。
特にデータベースが大規模な場合、完全コピーにはかなりのディスク使用量が必要になる可能性があります。

代替方法として、増分バックアップは、前回のバックアップ以降に変更された文書のみを保管するための良い解決策です。

このプロセスはシンプルです。
最初にデータベース全体のバックアップを作成します。
最初のバックアップ後は、毎日の「増分」バックアップを実行し、前回のバックアップ以降にデータベース内で変更された部分_だけ_をバックアップします。
この複製が毎日のバックアップになります。

一定間隔でトリガーされるようにバックアップを構成することができます。
ただし、それぞれの間隔は 24 時間以上でなければなりません。 つまり、毎日のバックアップを実行することはできますが、毎時のバックアップは実行できません。
{: note}

## 増分バックアップの作成
{: #creating-an-incremental-backup}

増分バックアップは、バックアップ間の差分、つまり「デルタ」のみを保存します。
24 時間ごとに、ソース・データベースがターゲット・データベースに複製されます。

複製は、シーケンス値を使用して、24 時間の期間中に変更された文書を識別します。
バックアップ操作は、複製を使用してチェックポイントを取得および保管することによって機能します。
チェックポイントは、内部名を持つもう 1 つの文書です。
バックアップ操作は、日付とバックアップ・タスク名の組み合わせからこの名前を作成します。
この名前により、リカバリー・プロセスまたはロールアップ・プロセス中のチェックポイントの識別が容易になります。

増分バックアップを作成するには、以下のステップを実行します。

1.  最後の複製のチェックポイント文書の ID を見つけます。
    これは、`_replicator` データベース内にある複製文書の `_replication_id` フィールドに保管されています。
2.  `/$DATABASE/_local/$REPLICATION_ID` でチェックポイント文書を開きます。ここで、`$REPLICATION_ID` は、前のステップで見つけた ID で、`$DATABASE` は、ソース・データベースまたはターゲット・データベースの名前です。
    この文書は、通常、両方のデータベースにありますが、1 つのデータベースのみに存在する場合もあります。
3.  チェックポイント文書内で検出される履歴配列内の最初のエレメントの `recorded_seq` フィールドを検索します。
4.  複製文書内の [`since_seq` フィールド](/docs/services/Cloudant?topic=cloudant-replication-api#the-since_seq-field) を、前のステップで検出した `recorded_seq` フィールドの値に設定して、新しい増分バックアップ・データベースに複製します。

定義により、`since_seq` オプションを使用すると、通常のチェックポイント機能がバイパスされます。 `since_seq` を使用する際には、必ず注意してください。 
{: note}

## データベースのリストア
{: #restoring-a-database}

増分バックアップからデータベースをリストアするには、最新の増分から開始して各増分バックアップを新しいデータベースに複製します。

最も古いバックアップから開始して、後続のバックアップを順番に適用することもできます。
ただし、最新の増分バックアップを最初に複製すると、更新された文書がターゲット・データベースに書き込まれるのは 1 度だけのため、その方が速くなります。
既に新しいデータベースにあるコピーより古い文書はスキップされます。


## 例
{: #an-example}

この例は、以下の実行方法を示します。

1.  増分バックアップを使用するようにデータベースをセットアップする。
2.  フルバックアップを実行する。
3.  増分バックアップをセットアップし、実行する。
4.  バックアップをリストアする。

### ここで使用される定数
{: #constants-that-are-used-here}

```sh
# ベース URL とコンテンツ・タイプをシェル変数に保存する
$ url='https://$ACCOUNT:$PASSWORD@$ACCOUNT.cloudant.com'
$ ct='Content-Type: application-json'
```
{: codeblock}

1 つのデータベースをバックアップする必要があると仮定します。
月曜日にフルバックアップを作成し、火曜日に増分バックアップを作成したいと考えています。

`curl` コマンドと [`jq` ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](http://stedolan.github.io/jq/){: new_window} コマンドを使用してこれらの操作を実行できます。
実際には、任意の HTTP クライアントを使用する場合があります。

### ステップ 1: 3 つのデータベースがあることを確認する
{: #step-1-check-that-you-have-three-databases}

この例では、次の 3 つのデータベースが必要です。

-   バックアップするデータを保持している元のデータベース。
-   月曜日用 (`backup-monday`) と火曜日用 (`backup-tuesday`) の 2 つの増分データベース。

_HTTP を使用して、この例で使用する 3 つのデータベースかあるかどうかを確認する方法を示す例:_

```http
PUT /original HTTP/1.1
PUT /backup-monday HTTP/1.1
PUT /backup-tuesday HTTP/1.1
```
{: codeblock}

コマンド・ラインを使用して、この例で使用する 3 つのデータベースかあるかどうかを確認する方法を示す例:_

```sh
$ curl -X PUT "${url}/original"
$ curl -X PUT "${url}/backup-monday"
$ curl -X PUT "${url}/backup-tuesday"
```
{: codeblock}

### ステップ 2: `_replicator` データベースを作成する
{: #step-2-create-the-_replicator-database}

存在しない場合、`_replicator` データベースを作成します。

*HTTP を使用した `_replicator` データベースの作成:*

```http
PUT /_replicator HTTP/1.1
```
{: codeblock}

*コマンド・ラインを使用した `_replicator` データベースの作成:*

```sh
curl -X PUT "${url}/_replicator"
```
{: pre}

### ステップ 3: (元の) データベース全体をバックアップする
{: #step-3-back-up-the-entire-original-database}

月曜日に、すべてのデータを初めてバックアップしたいと考えています。
`original` から `backup-monday` にすべてを複製して、このバックアップを作成します。

_HTTP を使用して月曜日にフルバックアップを実行:_

```http
PUT /_replicator/full-backup-monday HTTP/1.1
Content-Type: application/json
```
{: codeblock}

_コマンド・ラインを使用して月曜日にフルバックアップを実行:_

```sh
$ curl -X PUT "${url}/_replicator/full-backup-monday" -H "$ct" -d @backup-monday.json
# where backup-monday.json describes the backup.
```
{: codeblock}

_このフルバックアップを記述する JSON 文書:_
 
```json
{
    "_id": "full-backup-monday",
    "source": "${url}/original",
    "target": "${url}/backup-monday"
}
```
{: codeblock}

### ステップ 4: 増分バックアップを準備する「パート 1 - チェックポイント ID の取得」
{: #step-4-prepare-incremental-backup-part-1-get-checkpoint-id}

火曜日には、もう 1 度フルバックアップを実行するのではなく、増分バックアップを実行したいと考えています。

増分バックアップを開始するには、次の 2 つの値が必要です。

-   チェックポイント ID。
-   [`recorded_seq` 値](#step-5-prepare-incremental-backup-part-2-get-recorded_seq-value)。

これらの値は、最後のバックアップが終了した場所を識別し、次の増分バックアップをどこから開始するかを決めます。
これらの値を取得したら、増分バックアップを実行できます。

チェックポイント ID 値の検出から開始します。
この値は、`_replicator` データベース内の複製文書の `_replication_id` フィールドに保管されています。.

*HTTP を使用して、`recorded_seq` 値の検出に役立つチェックポイント ID を取得:*

```http
GET /_replicator/full-backup-monday HTTP/1.1
# Search for the value of _replication_id
```
{: codeblock}

*コマンド・ラインを使用して、`recorded_seq` 値の検出に役立つチェックポイント ID を取得:*

```sh
replication_id=$(curl "${url}/_replicator/full-backup-monday" | jq -r '._replication_id')
```
{: pre}

### ステップ 5: 増分バックアップを準備する「パート 2 - `recorded_seq` 値の取得」
{: #step-5-prepare-incremental-backup-part-2-get-recorded_seq-value}

チェックポイント ID を取得したら、それを使用して `recorded_seq` 値を取得します。
この値は、元のデータベース内の `/_local/${replication_id}` 文書の履歴配列の最初のエレメントにあります。

これで、`recorded_seq` 値を取得しました。
この値は、元のデータベースから複製された最後の文書を識別します。

*HTTP を使用して元のデータベースから `recorded_seq` を取得:*

```http
GET /original/_local/${replication_id} HTTP/1.1
# 履歴配列内の recorded_seq の最初の値を検索する
```
{: codeblock}

*コマンド・ラインを使用して元のデータベースから `recorded_seq` を取得:*

```sh
recorded_seq=$(curl "${url}/original/_local/${replication_id}" | jq -r '.history[0].recorded_seq')
```
{: pre}

### ステップ 6: 増分バックアップを実行する
{: #step-6-run-an-incremental-backup}

これで、チェックポイント ID と `recorded_seq` を取得したので、火曜日の増分バックアップを開始できます。
このバックアップは、最後の複製_以降_に行われたすべての文書変更を複製します。

複製が終了すると、完全な増分バックアップが得られます。
このバックアップは、元のデータベース内のすべての文書から成り、`backup-monday` データベース_と_ `backup-tuesday` データベースの両方の内容を取得することによりリストアできます。

_HTTP を使用して火曜日の増分バックアップを実行:_

```http
PUT /_replicator/incr-backup-tuesday HTTP/1.1
Content-Type: application/json
```
{: codeblock}

_コマンド・ラインを使用して火曜日の増分バックアップを実行:_

```sh
curl -X PUT "${url}/_replicator/incr-backup-tuesday" -H "${ct}" -d @backup-tuesday.json
```
{: pre}

_火曜日の増分バックアップを記述する JSON 文書:_
 
```json
{
    "_id": "incr-backup-tuesday",
    "source": "${url}/original",
    "target": "${url}/backup-tuesday",
    "since_seq": "${recorded_seq}"
}
```
{: codeblock}

### ステップ 7: 月曜日のバックアップをリストアする
{: #step-7-restore-the-monday-backup}

バックアップからリストアするには、初期のフルバックアップ、およびすべての増分バックアップを新しいデータベースに複製します。

例えば、月曜日の状態をリストアするには、`backup-monday` データベースから複製します。

_HTTP を使用して `backup-monday` データベースからリストア:_

```sh
PUT /_replicator/restore-monday HTTP/1.1
Content-Type: application/json
```
{: codeblock}

_コマンド・ラインを使用して `backup-monday` データベースからリストア:_

```sh
curl -X PUT "${url}/_replicator/restore-monday" -H "$ct" -d @restore-monday.json
```
{: pre}

_このリストアを記述する JSON 文書:_
 
```json
{
    "_id": "restore-monday",
    "source": "${url}/backup-monday",
    "target": "${url}/restore",
    "create_target": true  
}
```
{: codeblock}

### ステップ 8: 火曜日のバックアップをリストアする
{: #step-8-restore-the-tuesday-backup}

火曜日のデータベースをリストアするには、`backup-tuesday` から最初に複製し、次に `backup-monday` から複製します。

この順序はタイプミスではありません。火曜日からリストアし、_次に_月曜日をリストアするという順序で_間違いありません_。
{: tip}

日時順にリストアすることもできますが、逆の順序を使用することにより、火曜日に更新された文書のターゲット・データベースへの書き込みは 1 回のみで済みます。
月曜日のデータベースに保管されている文書の古いバージョンは無視されます。

_HTTP を使用し、最新の変更を最初に取得して火曜日のバックアップをリストア:_

```http
PUT /_replicator/restore-tuesday HTTP/1.1
Content-Type: application/json
```
{: codeblock}

_コマンド・ラインを使用し、最新の変更を最初に取得して火曜日のバックアップをリストア:_

```sh
curl -X PUT "${url}/_replicator/restore-tuesday" -H "$ct" -d @restore-tuesday.json
```
{: pre}

_火曜日のバックアップのリストアを要求する JSON 文書:_
 
```json
{
    "_id": "restore-tuesday",
    "source": "${url}/backup-tuesday",
    "target": "${url}/restore",
    "create_target": true  
}
```
{: codeblock}

_HTTP を使用し、月曜日のバックアップを最後にリストアしてリカバリーを完了:_

```http
PUT /_replicator/restore-monday HTTP/1.1
Content-Type: application/json
```
{: codeblock}

_コマンド・ラインを使用し、月曜日のバックアップを最後にリストアしてリカバリーを完了:_

```http
curl -X PUT "${url}/_replicator/restore-monday" -H "$ct" -d @restore-monday.json
```
{: pre}

_月曜日のバックアップのリストアを要求する JSON 文書:_
 
```json
{
    "_id": "restore-monday",
    "source": "${url}/backup-monday",
    "target": "${url}/restore"
}
```
{: codeblock}

## 提案
{: #suggestions}

前の情報で、基本的なバックアップ・プロセスの概要について説明しましたが、各アプリケーションには、バックアップのためのそれぞれ独自の要件と戦略が必要です。
以下の提案をお役立てください。

### バックアップのスケジューリング
{: #scheduling-backups}

複製ジョブは、クラスターの負荷を大幅に増加する可能性があります。
複数のデータベースをバックアップする場合は、複製ジョブが別々の時間に行われるように、またはクラスターがあまりビジーでない時間に行われるように調整することをお勧めします。

#### バックアップの入出力優先順位の変更
{: #changing-the-io-priority-of-a-backup}

バックアップ・ジョブの優先順位は、複製文書内の `x-cloudant-io-priority` フィールドの値を調整することによって変更できます。

1.  ソース・フィールドとターゲット・フィールドで、`headers` オブジェクトを変更します。
2.  headers オブジェクトで、`x-cloudant-io-priority` フィールドの値を `"low"` に変更します。

_入出力優先順位を設定する JSON 文書の例:_

```json
{
    "source": {
        "url": "https://user:pass@example.com/db",
        "headers": {
            "x-cloudant-io-priority": "low"
        }
    },
          "target":{
        "url": "https://user:pass@example.net/db",
        "headers": {
            "x-cloudant-io-priority": "low"
        }
    }
}
```
{: codeblock}

### 設計文書のバックアップ
{: #backing-up-design-documents}

バックアップに設計文書を含めると、バックアップ宛先に索引が作成されます。
これを実施すると、バックアップ・プロセスをスローダウンさせ、不要なディスク・スペースを使用します。
バックアップ・システム上に索引が必要ない場合は、フィルター関数を複製に使用して、設計文書をフィルター処理で除外してください。
また、このフィルター関数を使用して、その他の不要な文書も除外できます。

### 複数のデータベースのバックアップ
{: #backing-up-multiple-databases}

アプリケーションが、ユーザーごとに 1 つのデータベースを使用している場合、または各ユーザーが複数のデータベースを作成することを許可している場合は、新しいデータベースごとにバックアップ・ジョブを作成する必要があります。
複製ジョブが同時に開始されないようにしてください。

## ヘルプが必要ですか?
{: #need-help-}

複製およびバックアップは簡単ではありません。
問題に遭遇したら、[複製ガイド](/docs/services/Cloudant?topic=cloudant-replication-guide#replication-guide)を確認するか、[{{site.data.keyword.cloudant_short_notm}} サポート・チーム![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](mailto:support@cloudant.com){: new_window}までお問い合わせください。
