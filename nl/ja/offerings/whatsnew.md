---

copyright:
  years: 2017, 2018
lastupdated: "2017-11-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-05-04 -->

# {{site.data.keyword.cloudant_short_notm}} の新機能

{{site.data.keyword.cloudantfull}} の変更および更新に関する最新情報にご注目ください。
{:shortdesc}

## 専用ハードウェア

新しい[専用サービス・インスタンス](bluemix.html#dedicated-plan)が利用可能になりました。

## ビルド 6233

- 新しい複製スケジューラーが導入されました。
  パフォーマンス上の利点や追加のエンドポイントのほか、
  このスケジューラーでは、複製状況のモニターおよびレポート方法が変更されています。
  特に、複製文書での状況更新の記録は、
  サポートされなくなりました。
  この重要な変更について詳しくは、
  [複製スケジューラー](../api/advanced_replication.html#the_replication_scheduler)に関する詳細を参照してください。
  質問や懸念点がある場合は、{{site.data.keyword.cloudant_short_notm}} ダッシュボードでチケットをオープンし、{{site.data.keyword.cloudant_short_notm}} サポートにお問い合わせください。

## ビルド 6069

- 以前、何らかの理由で複製ジョブが異常終了すると、複製文書が更新され、
  その後で新しい複製の開始が新たに試行されていました。
  一定の状況下で、この振る舞が無限に続き、
  同じエラー・メッセージが多く生成されていました。
  エラーの理由が変わらない限り複製文書を更新しないように、フィックスが導入されました。
- 地理情報索引を指定するための設計文書が無効な場合に、
  [`_geo_info` エンドポイント](../api/cloudant-geo.html#obtaining-information-about-a-cloudant-geo-index)を使用して
  索引に関する情報を取得しようとすると、[HTTP `404`](http.html#404) 応答が発生します。
- [`$allmatch`](../api/cloudant_query.html#the-allmatch-operator) オペレーターのサポートが追加されました。

## ビルド 5834

- 文書 `id` の最大長が 7168 文字 (7k) になりました。

## ビルド 5728

- {{site.data.keyword.cloudant_short_notm}} で、`_users` データベース内に保管された誤った形式のユーザー文書に対する許容が高まりました。
  ユーザー文書は、[Apache Software Foundation CouchDB の要件![「外部リンク」アイコン](../images/launch-glyph.svg "「外部リンク」アイコン")](http://docs.couchdb.org/en/2.0.0/intro/security.html#users-documents){:new_window}
  に適合するように、構造化されてデータが設定されている必要があります。

## ビルド 5638

-   ビューに対する新しい照会パラメーター「stable」と「update」が導入されました。
-   レプリケーターが、ソース・データベースにチェックポイントを書き込めない場合に、永遠に再試行することがなくなりました。

## ビルド 5421

-	変更フィードでビュー・ベースのフィルターがサポートされます。
-	変更フィードで `_doc_ids` フィルターがサポートされます。
-	`POST` 要求が `_changes` にサポートされます。
-	`_all_docs` と `_changes` の両方で `attachments=true` パラメーターがサポートされます。
-	`_users` データベースで文書が作成されたときのサーバー・サイドのパスワード・ハッシュなど、CouchDB 1.6 `_users` データベース機能がサポートされます。
-	`/_bulk_get` エンドポイントにより、モバイル・クライアントへの複製で使用される要求の数が削減されます。
-	設計文書のメタデータに `update pending` フィールドが含まれます。
-	{{site.data.keyword.cloudant_short_notm}} 照会で、有効な索引が存在しない場合に、エラーが戻されなくなりました。

### 停止になった変更/振る舞いの変更

アクティブ・タスク

-   `_active_tasks` 応答のインデクサー項目で、`user` フィールドがレポートされなくなりました。
-   `_active_tasks` 応答の検索インデクサー項目で、`user` フィールドがレポートされなくなりました。

ビュー

-   削減されたビュー結果と削減されていないビュー結果の間で、キー値の Unicode 正規化は整合しています。 設計文書で raw 照合が指定された場合、このフィックスの結果として、結果順序が変わる可能性があります。
-   ビューまたは `_all_docs` データベースの照会時に、`keys` パラメーターと、`key`、`startkey`、`endkey` のいずれかのパラメーターを指定するのはエラーです。
-   行の突き合わせが不可能な場合に、`startkey` と `endkey` のパラメーターをビューに渡すのはエラーです。 例えば、`descending=false` で `startkey` パラメーターが `endkey` パラメーターより大きい場合や、`descending=true` で `startkey` パラメーターが `endkey` パラメーターより小さい場合、{{site.data.keyword.cloudant_short_notm}} は `400 Bad Request` エラーを戻します。
-   ビュー文書で `dbcopy` が構成されている場合、それは、設計文書で `options` フィールドに自動的に変換されます。 

設計文書

-   設計文書の検証が厳しくなりました。 この検証によって、既存の設計文書で問題が発生することは予想されませんが、誤った形式の設計文書は保存に失敗します。
-   サポートされない言語で作成されたビューはすべて、`unknown_query_language` の `error` で応答します。 以前、この応答は、`unknown_query_language` の `reason` でした。
-   データベース設計文書の put にヌルの reducer が使用されると、システムは `'(null)'` のエラー理由で応答します。以前は、`((new String("null")))` を戻していました。
-   設計文書に `updates` が指定された場合、それはヌル値を含んではなりません。

認証

-   `_session` メタデータ `authentication_handlers` に、`["delegated", "local"]` は含まれなくなりました。

ユーザー文書

-   `_users` データベースで作成されたユーザー文書の構造を検証します。 DBNext アップグレードの後、ユーザー文書は ASF CouchdDB の要件に適合しなければなりません。 以前、ユーザー文書の構造は {{site.data.keyword.cloudant_short_notm}} によって検証されませんでした。 

複製 

-   レプリケーター文書が、`_replication_state_reason` JSON フィールドに最後のエラー・メッセージを保持します。 複製が再始動して `triggered` 状態になった後も、このフィールドはそのまま残ります。 この変更によって、レプリケーター・コードが、同じエラーであることを検出し、文書に繰り返し書き込まないようにすることができます。
-   複製中にエラーが発生した場合、エラーの理由が変わらない限り、複製文書は更新されません。 以前は、複製中にエラーが発生した場合、無限ループが開始して、かなり大きなシャードが生成されました。  

結果セット

-   `_db_updates` エンドポイントが、`db_name` という名前のキーを含む結果セットを戻します。 以前は、`dbname` という名前のキーを含む結果セットが戻されていました。
-   文書 ID の最大長を設定します。 以前は、文書 ID の最大長を定義することはできませんでした。

`dbcopy`

- `dbcopy` 機能によって、一定の状況下で問題が発生する可能性があります。
  この機能に関する情報は、資料から削除されました。
  `dbcopy` は、できるだけ使用しないようにしてください。
