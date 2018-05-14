---

copyright:
  years: 2015, 2017
lastupdated: "2017-01-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

# 文書のバージョン管理および MVCC

Cloudant データベースは、[Multi-version concurrency control (MVCC) ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://en.wikipedia.org/wiki/Multiversion_concurrency_control){:new_window} を使用して、データベースのクラスター内のすべてのノードに、文書の[最新バージョン](../api/document.html)のみが含まれるようにします。
{:shortdesc}

Cloudant データベースは[結果整合](cap_theorem.html)のため、これは、古い文書間での同期化の結果としてノード間で発生する不整合を防ぐために必要です。

Multi-Version Concurrency Control (MVCC) は、Cloudant データベースへの同時読み取りおよび書き込みアクセスを可能にします。MVCC は、[楽観的並行性![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](http://en.wikipedia.org/wiki/Optimistic_concurrency_control){:new_window} の 1 つの形式です。MVCC では、読み取り操作または書き込み操作のいずれにおいてもデータベース・ロックの必要がないため、Cloudant データベースでの読み取り操作および書き込み操作は両方とも速くなります。MVCC はまた、Cloudant データベース・ノード間の同期も可能にします。

## リビジョン

Cloudant データベース内のすべての文書には、その文書のリビジョン番号を示す `_rev` フィールドがあります。

リビジョン番号は、文書を挿入または変更する際にサーバーによって文書に追加されます。この番号は、文書に変更を行ったり文書を読み取ったりする時にサーバー応答に組み込まれます。`_rev` 値は、単純なカウンターと、文書のハッシュの組み合わせを使用して作成されます。

リビジョン番号の 2 つの主な使用目的は、以下の実行に役立てることです。

1.  サーバー間で複製する必要がある文書を判別する。
2.  クライアントが文書の最新バージョンを変更しようとしていることを確認する。

[文書を更新](../api/document.html#update)する際は、前の `_rev` を指定する必要があります。さもないと要求は失敗し、[409 エラー](../api/http.html#409)が返されます。

>   **注**: バージョン管理システムを構築するために `_rev` を使用してはいけません。
その理由は、この番号がサーバーによって使用される内部値だからです。それに加え、文書の古いリビジョンは一時的なものなので、定期的に削除されるからです。

`_rev` を使用して特定のリビジョンを照会することができます。ただし、古いリビジョンは、[圧縮![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](http://en.wikipedia.org/wiki/Data_compaction){:new_window} と呼ばれるプロセスによって定期的に削除されます。圧縮の結果として、文書のリビジョンの履歴を取得するために `_rev` を使用して特定の文書リビジョンを照会する際の正常応答を信頼できません。文書のバージョン履歴が必要な場合、解決策は、リビジョンごとに[新しい文書を作成](../api/document.html#documentCreate)することです。

## 分散データベースおよび競合

分散データベースは、Cloudant 上のメイン・データベース (それ自体、分散されている) への常時接続なしで機能するため、以前の同じバージョンに基づいた更新でも競合が発生する可能性があります。

競合を検出するには、文書を取得する時に照会パラメーター [`conflicts=true`](../api/database.html#get-changes) を追加します。応答には、競合するすべてのリビジョンを含む `_conflicts` 配列が含まれます。

データベース内の複数の文書の競合を検出するには、ビューを作成します。

以下のマップ関数は、競合があるすべての文書の、競合しているすべてのリビジョンを排出する例です。

_競合がある文書を検出するためのマップ関数の例:_

```javascript
function(doc) {
    if (doc._conflicts) {
        emit(null, [doc._rev].concat(doc._conflicts));
    }
}
```
{:codeblock}

このビューを定期的に照会し、必要に応じて競合を解決したり、各複製後にビューを照会したりすることができます。

## 競合の解決方法

競合を検出したら、4 ステップで競合を解決することができます。

1.  競合するリビジョンを[取得](#get-conflicting-revisions)する。
2.  それらをアプリケーション内で[マージ](#merge-the-changes)するか、ユーザーにどうしたいか尋ねる。
3.  新しいリビジョンを[アップロード](#upload-the-new-revision)する。
4.  古いリビジョンを[削除](#delete-old-revisions)する。

この実行方法の例について考えてみましょう。オンラインショップ用の商品のデータベースがあると仮定します。文書の最初のバージョンは、以下の例のようになります。

```json
{
    "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "1-7438df87b632b312c53a08361a7c3299",
    "name": "Samsung Galaxy S4",
    "description": "",
    "price": 650
}
```
{:codeblock}

この文書にはまだ説明がないため、他のユーザーが以下のように説明を追加する場合があります。

_説明を追加して作成された、文書の第 2 バージョン:_

```json
{
    "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "2-61ae00e029d4f5edd2981841243ded13",
    "name": "Samsung Galaxy S4",
    "description": "Latest smartphone from Samsung",
    "price": 650
}
```
{:codeblock}

それと同時に、複製されたデータベースで作業をしている他のユーザーが、以下のように価格を下げます。

_`price` の値が異なるため以前のリビジョンと競合している別のリビジョン:_

```json
{
    "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "2-f796915a291b37254f6df8f6f3389121",
    "name": "Samsung Galaxy S4",
    "description": "",
    "price": 600
}
```
{:codeblock}

次に、これらの 2 つのデータベースが複製されます。文書バージョンでの違いの結果、競合が発生します。

### 競合するリビジョンの取得

`conflicts=true` オプションを使用して、競合がある文書を識別します。

_競合がある文書の検出の例:_

```http
http://$ACCOUNT.cloudant.com/products/$_ID?conflicts=true
```
{:codeblock}

_文書に影響を与える、競合するリビジョンを示す応答例:_

```json
{
    "_id":"74b2be56045bed0c8c9d24b939000dbe",
    "_rev":"2-f796915a291b37254f6df8f6f3389121",
    "name":"Samsung Galaxy S4",
    "description":"",
    "price":600,
    "_conflicts":["2-61ae00e029d4f5edd2981841243ded13"]
}
```
{:codeblock}

変更された価格を持つバージョンは、文書の最新バージョンとして任意に選択されています。そして、別のバージョンとの競合は、そのバージョンの ID を指定して `_conflicts` 配列に示されています。多くの場合、この配列に含まれるのは 1 つのエレメントのみですが、数多くの競合するリビジョンが存在する場合もあります。

### 変更のマージ

リビジョンを比較して何が変更されているかを知るために、アプリケーションはデータベースからすべてのバージョンを取得します。

_データベースから文書のすべてのバージョンを取得するためのコマンド例:_

```http
http://$ACCOUNT.cloudant.com/products/$_ID
http://$ACCOUNT.cloudant.com/products/$_ID?rev=2-61ae00e029d4f5edd2981841243ded13
http://$ACCOUNT.cloudant.com/products/$_ID?rev=1-7438df87b632b312c53a08361a7c3299
```
{:codeblock}

競合する変更は、文書の、異なるフィールドに対するものなので、容易にマージできます。

もっと複雑な競合では、以下のような他の解決戦略が必要な場合があります。

*   時間基準: 最初の編集または最後の編集を使用する。
*   ユーザー介入: 競合をユーザーに報告し、ユーザーに最良の解決策を決めさせる。
*   洗練されたアルゴリズム: 例えば、テキスト・フィールドの 3 方向マージ。

変更のマージの実装方法の実例については、[サンプル・コードを含むこのプロジェクト ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](https://github.com/glynnbird/deconflict){:new_window} を参照してください。

### 新しいリビジョンのアップロード

次のステップでは、競合を解決する文書を作成し、それを使用してデータベースを更新します。

_2 つの競合するリビジョンからの変更をマージする文書例:_

```json
{
    "_id": "74b2be56045bed0c8c9d24b939000dbe",
    "_rev": "3-daaecd7213301a1ad5493186d6916755",
    "name": "Samsung Galaxy S4",
    "description": "Latest smartphone from Samsung",
    "price": 600
}
```
{:codeblock}

### 古いリビジョンの削除

最後に、削除したいリビジョンがある URL に `DELETE` 要求を送信して、古いリビジョンを削除します。

_HTTP を使用した、古い文書リビジョンを削除するための要求例:_

```http
DELETE https://$ACCOUNT.cloudant.com/products/$_ID?rev=2-61ae00e029d4f5edd2981841243ded13
```
{:codeblock}

_コマンド・ラインを使用した、古い文書リビジョンを削除するための要求例:_

```sh
curl "https://$ACCOUNT.cloudant.com/products/$_ID?rev=2-f796915a291b37254f6df8f6f3389121" -X DELETE
```
{:codeblock}

この時点で、文書に影響を与える競合は解決されます。このことは、`conflicts` パラメーターを `true` に設定して、文書を再び `GET` することにより検証できます。
