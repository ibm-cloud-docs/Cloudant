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

<!-- Acrolinx: 2017-05-10 -->

# タスクの管理
{: #managing-tasks}

多数のデータにわたる新しい索引を作成したり、大規模なデータベースを複製したりするには、かなりの時間がかかる場合があります。
{: shortdesc}

では、タスクが進行中かどうか、あるいは完了しているかどうかは、どのようにして判別できるでしょうか?
[`_active_tasks` エンドポイント](/docs/services/Cloudant?topic=cloudant-active-tasks#active-tasks) は、実行中のすべてのタスクに関する情報を提供します。
ただし、数多くのタスクを開始すると、それらの一部は後で実行するようスケジュールされ、開始されるまで `_active_tasks` に表示されないことがあります。

このガイドでは、長時間実行されるタスクを `_active_tasks` エンドポイントを使用してモニターする方法について説明します。
このエンドポイントにアクセスするには、`curl` コマンドを使用します。
JSON 応答を処理するには、`jq` コマンド・ライン JSON プロセッサーを使用します。

これはタスクに焦点を当てたチュートリアルのため、ここではこのタスクの達成に不可欠なことだけを取り上げています。
詳しくは、使用可能オプションの完全ガイドについて『[API リファレンス](/docs/services/Cloudant?topic=cloudant-api-reference-overview#api-reference-overview)』を参照してください。

## `curl` および `jq` の基本
{: #curl-and-jq-basics}

すべてのアクティブ・タスクを取得し、出力を適切にフォーマット設定するには、`curl` を使用してアカウントを呼び出し、出力を `jq` にパイピングします。

`jq` を使用すると、文書リストをフィールド値によってフィルター処理することができます。
それにより、すべての複製文書を取得したり、1 つの特定のビュー索引付けタスクのみの詳細を取得したりすることが容易になります。
API リファレンスに、これらのオプションに関する詳細情報が記載されています。

*アクティブ・タスク・リストの取得およびフォーマット設定の例:*

```sh
curl 'https://username:password@username.cloudant.com/_active_tasks' | jq '.'
```
{: codeblock}

## ビューの作成および検索索引のモニタリング
{: #monitoring-view-builds-and-search-indexes}

ビュー索引は、設計文書が更新される際に再作成されます。
いずれかのビューを更新すると、文書内のすべてのビューが再作成されます。

検索索引は、対応する索引機能が変更される時にのみ再作成されます。
作成される各検索索引および変更されるビューを含む各設計文書について、クラスター内の各シャードのレプリカごとに新しいタスクが作成されます。

例えば、それぞれ 3 個のレプリカを持つ 24 個のシャードがあり、2 個の検索索引を更新すると、24 x 3 x 2 = 144 タスクが実行されます。

すべてのビュー索引付けタスクを検出するには、`curl` 出力を `jq` にパイピングし、配列内の文書をそれらのタイプ・フィールドでフィルター処理します。
検索索引付けタスクについては、対応するコマンドが機能します。

それぞれのケースで、索引付けタスクのリストを検索した結果として JSON オブジェクトのリストが作成されます (検出されたアクティブ・タスクごとに 1 つ)。

*`indexer` タイプを対象としてフィルター処理を行ってすべてのビュー索引付けタスクを検出する例:*

```sh
curl -s 'https://username:password@username.cloudant.com/_active_tasks' | jq '.[] | select(.type=="indexer")'
```
{: codeblock}

*`search_indexer` タイプを対象としてフィルター処理を行ってすべての検索索引付けタスクを検出する例:*

```sh
curl -s 'https://username:password@username.cloudant.com/_active_tasks' | jq '.[] | select(.type=="search_indexer")'
```
{: codeblock}

*ビュー索引付けタスクの検索後の結果の例:*

```json
{
    "total_changes": 6435,
    "started_on": 1371118332,
    "user": "username",
    "updated_on": 1371118334,
    "type": "indexer",
    "node": "dbcore@db6.meritage.cloudant.net",
    "pid": "<0.16366.6103>",
    "changes_done": 364,
    "database": "shards/40000000-7fffffff/username/database",
    "design_document": "_design/ngrams"
}
```
{: codeblock}

## タスクを完了するための時間の見積もり
{: #estimating-the-time-to-complete-a-task}

索引付けタスクが完了するまでに必要な時間を見積もるには、`changes_done` の数値をモニターし、この値を `total_changes` と比較します。
例えば、`changes_done` が 1 秒間につき 250 ずつ進み、`total_changes` が 1,000,000 の場合、このタスクは、完了までに 1,000,000 / 250 = 4,000 秒、つまり約 66 分かかると予想されます。

索引付けタスクを完了するための時間の見積もりは 100% 正確なわけではありません。 タスクを完了するための実際の時間は、以下の要因によって決まります。

-   各文書の処理に要する時間。
    例えば、ビューは最初に文書のタイプをチェックし、1 つのタイプの新しい索引項目のみを排出する可能性があります。
-   文書のサイズ。
-   クラスター上の現在のワークロード。

これらの要因が組み合わさって見積もりがかなり不正確になる可能性があることを想定しておく必要があります。

*`jq` を使用した `changes_done` フィールドの抽出の例:*

```sh
curl ... | jq '.[] | select(.type=="search_indexer") | .changes_done'
```
{: codeblock}

## 複製のモニター
{: #monitoring-replication}

すべての複製タスクを検出するには、`curl` 出力を `jq` にパイピングし、配列内の文書をそれらのタイプ・フィールドでフィルター処理します。

複製プロセスに関する情報をアクティブ・タスク・リストから容易に選択できるようにするには、`_replicator` データベース内に文書を作成して複製プロセスを開始し、その `_id` フィールドを既知の値に設定します。

*`replication` タイプを対象としてフィルター処理を行ってすべての複製タスクを検出する例:*

```sh
curl -s 'https://username:password@username.cloudant.com/_active_tasks' | jq '.[] | select(.type=="replication")'
```
{: codeblock}

*既知の文書 ID を対象としてフィルター処理を行って特定の複製タスクを検出する例:*

```sh
curl ... | jq '.[] | select(.doc_id=="ID")'
```
{: codeblock}

*既知の `replication_id` を対象としてフィルター処理を行って特定の複製タスクを検出する例:*

```sh
curl ... | jq '.[] | select(.replication_id=="ID")'
```
{: codeblock}

*複製タスクの検索後の結果の例:*

```json
{
    "started_on": 1371094220,
    "source_seq": "62960-sakdjflksdfjsdlkafjalskdfjlsakfjlasdkjksald",
    "source": "",
    "revisions_checked": 12,
    "continuous": true,
    "doc_id": null,
    "doc_write_failures": 0,
    "docs_read": 12,
    "target": "",
    "type": "replication",
    "updated_on": 1371118477,
    "user": "username",
    "checkpointed_source_seq": "61764-dskfjalsfjsalkfjssadjfhasdfkjhsdkfhsdkf",
    "changes_pending": 1196,
    "pid": "<0.9955.4120>",
    "node": "dbcore@db7.meritage.cloudant.net",
    "docs_written": 12,
    "missing_revisions_found": 12,
    "replication_id": "asfksdlfkjsadkfjsdalkfjas+continuous+create_target"
}
```
{: codeblock}

## 進行が停滞したタスクのトラブルシューティング
{: #troubleshooting-stuck-tasks}

### タスクの進行が停滞した場合
{: #is-a-task-stuck-}

複製中ソース・データベースの大幅な更新が行われない、1 回限りの非継続的複製では、`changes_pending` 値が残りの処理対象文書の数を示しています。
つまり、`changes_pending` 値は、いつ頃複製が終了するかを示す優れた指標です。

継続的複製では、ユーザーは、処理された文書の数が時間の経過とともにどのように変化するか、および `changes_pending` 値が増加するかどうかということに、より関心があります。
`changes_pending` は増加しているものの、`revisions_checked` はしばらくの間一定している場合は、複製が停止している可能性があります。
`changes_pending` が増加し、`revisions_checked` も増加している場合は、データベースに追加されるデータ、またはデータベース内で更新されるデータのボリュームに複製が追いついていないことを示している可能性があります。

### 進行が停滞したタスクの対処法
{: #what-to-do-about-a-stuck-task-}

停止した複製を解決するには、[複製プロセスをキャンセル](/docs/services/Cloudant?topic=cloudant-replication-api#canceling-a-replication)し、再び開始する必要がある場合があります。

それでも解決しない場合は、ソース・データベースまたはターゲット・データベースにアクセスしているユーザーが書き込み権限を持っていないことが原因で、複製が停止している可能性があります。

複製では、[チェックポイント](/docs/services/Cloudant?topic=cloudant-replication-guide#checkpoints)が利用されます。つまり、既に複製され、変更されていない内容は、複製がリスタートされた場合、再度複製する必要はありません。
{: note}

`_replicator` データベース内に文書を作成して複製プロセスを作成した場合は、そこで複製の状況をチェックすることもできます。
