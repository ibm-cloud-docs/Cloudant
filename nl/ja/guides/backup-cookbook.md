---

copyright:
  years: 2017
lastupdated: "2017-10-27"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-05-23 -->
<!-- Update backup-guide.md with with any changes. -->

# {{site.data.keyword.cloudant_short_notm}} バックアップおよびリカバリー

このクックブックは、[{{site.data.keyword.cloudantfull}} 災害復旧ガイド](disaster-recovery-and-backup.html)の一部です。
この主題について慣れておらず、災害復旧 (DR) および高可用性 (HA) 要件をサポートするために {{site.data.keyword.cloudant_short_notm}} で提供されている他の機能にバックアップがどこで適合するかを理解する必要がある場合は、そのガイドから開始してください。

データは {{site.data.keyword.cloudant_short_notm}} クラスター内に冗長に保管されますが、追加のバックアップ対策を考慮することが重要です。
例えば、冗長データ・ストレージでは、データの変更時におけるミスから保護されません。

## CouchBackup の導入

{{site.data.keyword.cloudant_short_notm}} には、スナップショット・バックアップおよびリストア用にサポートされるツールが用意されています。
このツールは、CouchBackup と呼ばれ、オープン・ソースです。
これは `node.js` ライブラリーであり、[npm ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")][npmpackage]{:new_window} でインストールできます。

CouchBackup パッケージには、このライブラリーに加え、以下の 2 つのコマンド・ライン・ツールが含まれています。

1. `couchbackup`。データベースから JSON データをバックアップ・テキスト・ファイルにダンプします。
2. `couchrestore`。バックアップ・テキスト・ファイルからデータをデータベースにリストアします。

<strong style="color:red;">警告</strong>: CouchBackup ツールには[制限](#limitations)があります。

## {{site.data.keyword.cloudant_short_notm}} データのバックアップ

`couchbackup` ツールを使用して、シンプルなバックアップを実行できます。
`animaldb` データベースを `backup.txt` という名前のテキスト・ファイルにバックアップするには、以下の例のようなコマンドを使用できます。

```sh
couchbackup --url https://examples.cloudant.com --db animaldb > backup.txt
```
{:codeblock}

[npm readme ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")][npmreadme]{:new_window} で、以下のものなど、他のオプションについて詳述されています。

* データベースの名前および URL を設定する環境変数。
* ログ・ファイルを使用したバックアップの進行の記録。
* 中断したバックアップを再開する機能。
  **注**: このオプションは、中断したバックアップのログ・ファイルを使用する場合にのみ使用可能です。
* `stdout` 出力のリダイレクトではなく、指定出力ファイルへのバックアップ・テキスト・ファイルの送信。

<strong style="color:red;">警告</strong>: CouchBackup ツールには[制限](#limitations)があります。

## {{site.data.keyword.cloudant_short_notm}} データのリストア

データをリストアするには、`couchrestore` ツールを使用します。
`couchrestore` を使用して、バックアップ・ファイルを新規 {{site.data.keyword.cloudant_short_notm}} データベースにインポートします。
次に、リストアしたデータをアプリケーションで使用しようとする前に、すべての索引を作成しておきます。

例えば、前の例でバックアップしたデータをリストアするには、以下のようにします。

```sh
couchrestore --url https://myaccount.cloudant.com --db newanimaldb < backup.txt
```
{:codeblock}

[npm readme ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")][npmreadme]{:new_window} に、他のリストア・オプションの詳細が示されています。

<strong style="color:red;">警告</strong>: CouchBackup ツールには[制限](#limitations)があります。

## 制限

<strong style="color:red;">警告</strong>: CouchBackup ツールには、以下の制限があります。 

* `_security` の設定は、ツールによってバックアップされません。
* 添付ファイルは、ツールによってバックアップされません。
* バックアップは、正確な「ポイント・イン・タイム」のスナップショットではありません。
  これは、データベース内の文書がバッチで取得され、同じときに他のアプリケーションが文書を更新している可能性があるためです。
  したがって、データベース内のデータは、最初のバッチが読み取られたときと最後のバッチが読み取られたときで異なる可能性があります。
* 設計文書内に保持されている索引定義はバックアップされますが、索引の内容はバックアップされません。
  この制限は、データのリストア時に索引を再作成する必要があることを意味します。
  リストアするデータの量によっては、再作成に相当な時間がかかることがあります。

## ツールの使用

[npm ページ ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")][npmpackage]{:new_window} で、データのバックアップとリストア用コマンド・ライン・ツール使用の基本の詳細が示されています。
以下の例では、特定のタスクにおけるツールの使用について説明することで、そうした詳細を実際に行う方法を示します。

CouchBackup パッケージでは、そのコア機能を使用するために以下の 2 つの方法が用意されています。

* コマンド・ライン・ツール。これを標準 UNIX コマンド・パイプラインに組み込むことができます。
  多くのシナリオでは、`cron` と `couchbackup` アプリケーションのシンプルなシェル・スクリプトを組み合わせることで十分対応できます。
* node.js から使用可能なライブラリー。
  このライブラリーにより、バックアップする必要があるデータベースを動的に判別するなど、複雑なバックアップ・プロセスを作成してデプロイできます。

コマンド・ライン・バックアップ・ツール、またはライブラリーとアプリケーション・コードを使用して、複雑な状況の一部としての {{site.data.keyword.cloudant_short_notm}} データベースからのバックアップを実現します。
役に立つシナリオとして、`cron` を使用してバックアップをスケジュールし、自動的にデータを [クラウド・オブジェクト・ストレージ ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")](http://www-03.ibm.com/software/products/en/object-storage-public){:new_window} にアップロードして長期保存することが考えられます。

## コマンド・ライン・スクリプトの例

以下の 2 つの要件が必要になることがよくあります。

* 作成された[バックアップ・ファイルを zip する](#zipping-a-backup-file)ことによる、ディスク・スペースの節約。
* [定期的間隔での](#hourly-or-daily-backups-using-cron)データベースのバックアップの自動作成

### バックアップ・ファイルの圧縮

`couchbackup` ツールでは、バックアップ・ファイルをディスクに直接書き込むか、バックアップを `stdout` にストリーミングすることができます。
`stdout` にストリーミングする場合、データを変換してからディスクに書き込むことができます。
この機能を使用して、ストリーム内のデータを圧縮します。

```sh
couchbackup --url "https://examples.cloudant.com" \
  --db "animaldb" | gzip > backup.gz
```
{:codeblock}

この例では、`gzip` ツールでバックアップ・データを `stdin` から直接受け入れ、データを圧縮してから、`stdout` を介して出力します。
結果として得られた圧縮データ・ストリームをリダイレクトして、`backup.gz` という名前のファイルに書き込みます。

データベースでアクセス資格情報を指定する必要がある場合は、`https://$USERNAME:$PASSWORD@$ACCOUNT.cloudant.com` という形式の URL を使用します。例:

```sh
couchbackup --url "https://$USERNAME:$PASSWORD@examples.cloudant.com" \
  --db "animaldb" | gzip > backup.gz
```
{:codeblock}

データを他の方法で変換する場合にパイプラインを拡張するのは単純です。
例えば、データをディスクに書き込む前に暗号化できます。
あるいは、コマンド・ライン・ツールを使用して、データをオブジェクト・ストア・サービスに直接書き込むこともできます。

### `cron` を使用した毎時または毎日のバックアップ

定期的にデータのスナップショットを取得するように `cron` スケジューリング・ツールをセットアップできます。

役に立つ開始点として、`couchbackup` で単一のバックアップをファイルに書き込みます。ファイル名には、現在の日時を含めます。例:

```sh
couchbackup --url "https://$USERNAME:$PASSWORD@$ACCOUNT.cloudant.com" \
  --db "animaldb" > animaldb-backup-`date -u "+%Y-%m-%dT%H:%M:%SZ"`.bak
```
{:codeblock}

コマンドが正常に機能することを確認した後に、以下のように、cron ジョブに入力できます。

1.  バックアップを実行するサーバーに CouchBackup ツールをインストールします。
2.  バックアップを保管するフォルダーを作成します。
3.  バックアップの頻度を記述する「cron 項目」を作成します。

`crontab -e` コマンドを使用して、cron 項目を作成できます。
「cron」のオプションの具体的な詳細については、ご使用のシステムの資料を参照してください。

バックアップを毎日実行する cron 項目は、以下の例のようになります。

```sh
0 5 * * * couchbackup --url "https://$USERNAME:$PASSWORD@$ACCOUNT.cloudant.com" --db "animaldb" > /path/to/folder/animaldb-backup-`date -u "+%Y-%m-%dT%H:%M:%SZ"`.bak
```
{:codeblock}

この cron 項目では、バックアップを毎日 05:00 に作成します。
必要に応じて、cron のパターンを変更して、バックアップを毎時、毎日、毎週、または毎月実行できます。

## ライブラリーとしての CouchBackup の使用

`couchbackup` および `couchrestore` コマンド・ライン・ツールは、独自の node.js アプリケーションで使用できる、ライブラリーのラッパーです。

ライブラリーは、以下の例に示すような複雑なシナリオで役立ちます。

* 1 つのタスクで複数のデータベースをバックアップする。
  [`_all_dbs`](../api/database.html#get-databases) 呼び出しを使用してすべてのデータベースを指定してから、各データベースのバックアップを個別に実行することで、このようなバックアップを実行できます。
* パイプラインが長い場合に、エラーのリスクが高まる。
  ご使用のアプリケーションで CouchBackup ライブラリーを使用して、できる限り早くエラーを検出して解決できます。

詳しくは、[npm ページ ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")][npmpackage]{:new_window} を参照してください。

以下のスクリプト例では、`couchbackup` ライブラリーと {{site.data.keyword.IBM}} クラウド・オブジェクト・ストアの使用を組み合わせる方法を示します。
このコードでは、クロス地域 S3 API を使用してデータベースをオブジェクト・ストアにバックアップする方法を示します。

> **注**: このコードの前提条件として、[この説明 ![外部リンク・アイコン](../images/launch-glyph.svg "外部リンク・アイコン")][cosclient]{:new_window} に従って、{{site.data.keyword.IBM_notm}} クラウド・オブジェクト・ストレージ用に S3 クライアント・オブジェクトを初期化します。

```javascript
/*
  ストリームを介して Cloudant から S3 バケットに直接バックアップ。
  @param {string} couchHost - データベース・ルートの URL
  @param {string} couchDatabase - バックアップ・ソース・データベース
  @param {object} s3Client - S3 クライアント・オブジェクト
  @param {string} s3Bucket - 宛先 S3 バケット (存在している必要あり)
  @param {string} s3Key - 宛先オブジェクトの鍵 (存在してはならない)
  @param {boolean} shallow - couchbackup の shallow モードを使用するかどうか
  @returns {Promise}
*/
function backupToS3(sourceUrl, s3Client, s3Bucket, s3Key, shallow) {
  return new Promise((resolve, reject) => {
    debug('Setting up S3 upload to ${s3Bucket}/${s3Key}');

    // A pass through stream that has couchbackup's output
    // written to it and it then read by the S3 upload client.
    // It has a 10MB internal buffer.
    const streamToUpload = new stream.PassThrough({highWaterMark: 10485760});

    // Set up S3 upload.
    const params = {
      Bucket: s3Bucket,
      Key: s3Key,
      Body: streamToUpload
    };
    s3Client.upload(params, function(err, data) {
      debug('S3 upload done');
      if (err) {
        debug(err);
        reject(new Error('S3 upload failed'));
        return;
      }
      debug('S3 upload succeeded');
      debug(data);
      resolve();
    }).httpUploadProgress = (progress) => {
      debug('S3 upload progress: ${progress}');
    };

    debug('Starting streaming data from ${sourceUrl}');
    couchbackup.backup(
      sourceUrl,
      streamToUpload,
      (err, obj) => {
        if (err) {
          debug(err);
          reject(new Error('CouchBackup failed with an error'));
          return;
        }
        debug('Download from ${sourceUrl} complete.');
        streamToUpload.end();  // must call end() to complete S3 upload.
        // resolve() is called by the S3 upload
      }
    );
  });
}
```
{:codeblock}

## その他の災害復旧オプション

[{{site.data.keyword.cloudant_short_notm}} 災害復旧ガイド](disaster-recovery-and-backup.html)に戻り、完全な災害復旧セットアップのために {{site.data.keyword.cloudant_short_notm}} で提供されている他の機能を調べてください。

[npmpackage]: https://www.npmjs.com/package/@cloudant/couchbackup
[npmreadme]: https://github.com/cloudant/couchbackup/blob/master/README.md
[cosclient]: https://developer.ibm.com/recipes/tutorials/cloud-object-storage-s3-api-intro/
