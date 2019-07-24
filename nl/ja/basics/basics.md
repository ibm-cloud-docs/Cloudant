---

copyright:
  years: 2015, 2019
lastupdated: "2019-06-12"

keywords: connect to ibm cloudant, http api, json, distributed systems, replication

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

<!-- Acrolinx: 2018-05-07 -->

# {{site.data.keyword.cloudant_short_notm}} の基本
{: #ibm-cloudant-basics}

この資料を初めて閲覧する場合、他のセクションに進む前に、このセクションにざっと目を通してください。
{: shortdesc}

以下のトピックの情報を理解するには、{{site.data.keyword.cloudantfull}} に関する基本的知識があることを前提としています。 

- [クライアント・ライブラリー](/docs/services/Cloudant?topic=cloudant-client-libraries#client-libraries)
- [API リファレンス](/docs/services/Cloudant?topic=cloudant-api-reference-overview#api-reference-overview)
- [ガイド](/docs/services/Cloudant?topic=cloudant-authorized-curl-acurl-#authorized-curl-acurl-)

## {{site.data.keyword.cloudant_short_notm}} への接続
{: #connecting-to-ibm-cloudant}

{{site.data.keyword.cloudant_short_notm}} にアクセスするには、[{{site.data.keyword.cloudant_short_notm}} アカウント](/docs/services/Cloudant?topic=cloudant-ibm-cloudant.com#enterprise-plan)または [{{site.data.keyword.cloud}} アカウント](https://cloud.ibm.com/login)が必要です。

## HTTP API
{: #http-api}

{{site.data.keyword.cloudant_short_notm}} に対する要求はすべて、Web を介して行われます。
つまり、Web と通信できる任意のシステムが、{{site.data.keyword.cloudant_short_notm}} と通信できます。
{{site.data.keyword.cloudant_short_notm}} 用の言語固有のライブラリーはすべて、便利で微妙な言語表現に対応したラッパーであり、シンプルな API で作業できるようにしています。
{{site.data.keyword.cloudant_short_notm}} で作業するために未加工の HTTP ライブラリーを使用しているユーザーも多数います。

{{site.data.keyword.cloudant_short_notm}} の HTTP の使用方法について詳しくは、API リファレンスの『[HTTP](/docs/services/Cloudant?topic=cloudant-http#http)』を参照してください。

{{site.data.keyword.cloudant_short_notm}} では、以下の HTTP 要求メソッドがサポートされます。

-   `GET`

    指定された項目を要求します。
    通常の HTTP 要求と同様に、URL のフォーマットにより、返す内容を定義します。
    {{site.data.keyword.cloudant_short_notm}} では、この対象は、静的項目、データベース文書、および構成と統計の情報にすることができます。
    ほとんどの場合、情報は、JSON 文書の形式で返されます。

-   `HEAD`

    `HEAD` メソッドは、応答の本体なしで `GET` 要求の HTTP ヘッダーを取得するために使用します。

-   `POST`

    データをアップロードします。
    {{site.data.keyword.cloudant_short_notm}} の API 内では、`POST` メソッドは、値の設定、文書のアップロード、文書値の設定、および一部の管理コマンドの開始のために使用します。

-   `PUT`

    特定のリソースを「保管」するために使用します。
    {{site.data.keyword.cloudant_short_notm}} の API では、`PUT` は、データベース、文書、ビュー、設計文書などの新規オブジェクトを作成するために使用します。

-   `DELETE`

    文書、ビュー、設計文書などの指定されたリソースを削除します。

-   `COPY`

    文書およびオブジェクトのコピーに使用できる特殊なメソッド。

クライアント (一部の Web ブラウザーなど) でこれらの HTTP メソッドがサポートされない場合、代わりに、`X-HTTP-Method-Override` 要求ヘッダーを実際の HTTP メソッドに設定して、`POST` を使用できます。

### メソッドが許可されないエラー
{: #method-not-allowed-error}

指定されたタイプがサポートされない URL で、サポートされない HTTP 要求タイプを使用した場合、以下のように、[405](/docs/services/Cloudant?topic=cloudant-http#http-status-codes) エラーが返され、サポートされる HTTP メソッドがリストされます。

_サポートされない要求に対するエラー・メッセージの例:_

```json
{
    "error":"method_not_allowed",
    "reason":"Only GET,HEAD allowed"
}
```
{: codeblock}

## JSON
{: #json-overview}

{{site.data.keyword.cloudant_short_notm}} は、JSON (JavaScript Object Notation) エンコードを使用して文書を保管するため、JSON にエンコードされたものをすべて文書として保管できます。
イメージ、ビデオ、オーディオなどのメディアが含まれたファイルは、BLOB (Binary Large OBject) と呼ばれ、文書に関連付けられた添付ファイルとして保管できます。

JSON について詳しくは、[JSON ガイド](/docs/services/Cloudant?topic=cloudant-json#json)を参照してください。

## 分散システム
{: #distributed-systems}

{{site.data.keyword.cloudant_short_notm}} の API では、複数のマシンのコラボレーション (クラスターと呼ぶ) と対話できます。
クラスター内のマシンは、同じデータ・センター内に存在している必要がありますが、そのデータ・センター内の異なる「ポッド」内に配置されていても構いません。
複数のポッドを使用すると、{{site.data.keyword.cloudant_short_notm}} の高可用性特性が向上します。

クラスター化の利点は、さらに計算能力が必要になった場合に単にマシンを追加すればよいという点にあります。
多くの場合、これは、既存の単一マシンをスケールアップしたり強化したりするよりも、費用対効果および耐障害性が高くなります。

{{site.data.keyword.cloudant_short_notm}} と分散システムの概念について詳しくは、[CAP 定理](/docs/services/Cloudant?topic=cloudant-cap-theorem#cap-theorem)のガイドを参照してください。

## 複製
{: #replication-basics}

[複製](/docs/services/Cloudant?topic=cloudant-replication-api#replication-api)は、{{site.data.keyword.cloudant_short_notm}}、[CouchDB ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](http://couchdb.apache.org/){: new_window}、[PouchDB ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](http://pouchdb.com/){: new_window}、および他の分散データベースが準拠する手順です。
複製では、2 つのデータベースの状態を同期して、両者の内容が同一になるようにします。

連続的に複製できます。
これは、ソース・データベースが変更されるごとに、ターゲット・データベースも更新されることを意味します。
連続複製は、データのバックアップ、複数のデータベースのデータの集約、あるいはデータの共有に使用できます。

ただし、連続複製を行うということは、ソース・データベースの変更がないかを連続的に検査するということを意味します。
この検査には、連続的な内部呼び出しが必要になるため、パフォーマンスやデータベース使用のコストに影響する可能性があります。

連続複製を行うと、多くの内部呼び出しが行われる可能性があります。 これらの呼び出しは、{{site.data.keyword.cloudant_short_notm}} システムのマルチテナント・ユーザーのコストに影響を与える場合があります。 デフォルトでは、連続複製は無効になっています。
{: note}

