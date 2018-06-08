---

copyright:
  years: 2015, 2017
lastupdated: "2017-11-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Keep up-to-date with changes in backup-cookbook.md -->

# {{site.data.keyword.cloudant_short_notm}} 備份及回復

此錦囊妙計構成 [{{site.data.keyword.cloudantfull}} 災難回復手冊](disaster-recovery-and-backup.html)的一部分。如果您不熟悉本主題，並且想要瞭解其中的備份是否適合 {{site.data.keyword.cloudantfull}} 為了支援「災難回復 (DR)」及「高可用性 (HA)」需求而提供的其他功能，則很值得從那裡開始。

雖然資料是以備援方式儲存 {{site.data.keyword.cloudant_short_notm}} 叢集內，但是考量額外備份措施是很重要的。例如，備援資料儲存空間不會在資料變更時保護資料免於發生錯誤。

## 簡介 CouchBackup

{{site.data.keyword.cloudant_short_notm}} 提供支援的工具，進行 Snapshot 備份及還原。此工具稱為 CouchBackup 且為開放程式碼。它是 `node.js` 程式庫，而且[可以安裝在 npm ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")][npmpackage]{:new_window} 上。

除了程式庫之外，CouchBackup 套件還包含兩個指令行工具：

1. `couchbackup`，可將資料庫中的 JSON 資料傾出至備份文字檔。
2. `couchrestore`，可將備份文字檔中的資料還原至資料庫。

<strong style="color:red;">警告！</strong>CouchBackup 工具具有[限制](#limitations)。

## 備份 {{site.data.keyword.cloudant_short_notm}} 資料

您可以使用 `couchbackup` 工具，執行簡單備份。若要將 `animaldb` 資料庫備份至稱為 `backup.txt` 的文字檔，您可能會使用與下列範例類似的指令：

```sh
couchbackup --url https://examples.cloudant.com --db animaldb > backup.txt
```
{:codeblock}

[npm ReadMe ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")][npmreadme]{:new_window} 詳述其他選項，包括：

* 設定資料庫名稱及 URL 的環境變數。
* 使用日誌檔來記錄備份的進度。
* 回復被岔斷備份的能力。**附註**：此選項只能與被岔斷備份的日誌檔搭配使用。
* 傳送備份文字檔至具名輸出檔，而不是重新導向 `stdout` 輸出。

<strong style="color:red;">警告！</strong>CouchBackup 工具具有[限制](#limitations)。

## 還原 {{site.data.keyword.cloudant_short_notm}} 資料

若要還原資料，請使用 `couchrestore` 工具。使用 `couchrestore`，將備份檔匯入至新的 {{site.data.keyword.cloudant_short_notm}} 資料庫。然後，確定在任何應用程式嘗試使用還原的資料之前，先建置所有索引。

例如，若要還原先前範例中備份的資料，請執行下列動作：

```sh
couchrestore --url https://myaccount.cloudant.com --db newanimaldb < backup.txt
```
{:codeblock}

[npm ReadMe ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")][npmreadme]{:new_window} 提供其他還原選項的詳細資料。

<strong style="color:red;">警告！</strong>CouchBackup 工具具有[限制](#limitations)。

## 限制

<strong style="color:red;">警告！</strong>CouchBackup 工具具有下列限制： 

* 工具不會備份 `_security` 設定。
* 工具不會備份附件。
* 備份不是精確的「復原點」Snapshot。原因是資料庫中的文件是依批次擷取，但其他應用程式可能同時正在更新文件。因此，資料庫中的資料可能會在讀取第一個批次及最後一個批次的時間之間變更。
* 會備份設計文件中保留的索引定義，但不會備份索引的內容。此限制表示，還原資料時，必須重建索引。重建可能需要相當長的時間，視還原的資料量而定。

## 使用工具

[npm 頁面 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")][npmpackage]{:new_window} 詳述使用指令行工具來備份及還原資料的基本觀念。下列範例說明特定作業的工具使用方式，顯示如何將那些詳細資料放入實做中。

CouchBackup package 提供兩種使用其核心功能的方式。

* 指令行工具可以內嵌於標準 UNIX 指令管線中。對於許多實務範例而言，`cron` 與 `couchbackup` 應用程式的簡單 Shell Script 的組合已足夠。
* 可從 node.js 使用的程式庫。此程式庫容許建立及部署更複雜的備份處理程序，例如，動態決定必須備份哪些資料庫。

使用指令行備份工具或將程式庫與應用程式碼搭配，以在更複雜的狀況中啟用 {{site.data.keyword.cloudant_short_notm}} 資料庫中的備份。有一個實用的情境就是使用 `cron` 排定備份，並自動上傳資料至 [Cloud Object Storage ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")](http://www-03.ibm.com/software/products/en/object-storage-public){:new_window}，以長期保留。

## 指令行 Script 範例

經常遇到兩個需求：

* 節省磁碟空間，方法為在建立備份檔時[「壓縮」備份檔](#zipping-a-backup-file)。
* [定期](#hourly-or-daily-backups-using-cron)自動建立資料庫的備份。

### 壓縮備份檔

`couchbackup` 工具可將備份檔直接寫入至磁碟，或將備份串流至 `stdout`。串流至 `stdout` 可讓資料在寫入至磁碟之前進行傳輸。此功能用來壓縮串流內的資料。

```sh
couchbackup --url "https://examples.cloudant.com" \
  --db "animaldb" | gzip > backup.gz
```
{:codeblock}

在此範例中，`gzip` 工具會透過其 `stdin` 直接接受備份資料、壓縮資料，以及透過 `stdout` 將它發出。然後，產生的壓縮資料串流會重新導向並寫入至稱為 `backup.gz` 的檔案。

如果資料庫需要您提供存取認證，請使用格式為 `https://$USERNAME:$PASSWORD@$ACCOUNT.cloudant.com` 的 URL，例如：

```sh
couchbackup --url "https://$USERNAME:$PASSWORD@examples.cloudant.com" \
  --db "animaldb" | gzip > backup.gz
```
{:codeblock}

如果想要以其他方式轉換資料，可以直接明確地延伸管線。例如，您可能想要在資料寫入至磁碟之前將它加密。或者，您可能想要使用指令行工具，將資料直接寫入至物件儲存庫服務。

### 使用 `cron` 的每小時或每日備份

`cron` 排程工具可以設為定期取得資料的 Snapshot。

有用的起點為讓 `couchbackup` 將單一備份寫入至檔案，其中檔名包括現行日期和時間，如下列範例所示：

```sh
couchbackup --url "https://$USERNAME:$PASSWORD@$ACCOUNT.cloudant.com" \
  --db "animaldb" > animaldb-backup-`date -u "+%Y-%m-%dT%H:%M:%SZ"`.bak
```
{:codeblock}

在檢查指令以確定其正確運作之後，可將它輸入至「cron 工作」：

1.  將 CouchBackup 工具安裝在您想要執行備份的伺服器上。
2.  建立資料夾來儲存備份。。
3.  建立一個「cron 項目」，說明備份頻率。

您可以使用 `crontab -e` 指令，建立一個 cron 項目。如需 'cron' 選項的特定詳細資料，請參閱系統文件。

要執行每日備份的 cron 項目與下列範例類似：

```sh
0 5 * * * couchbackup --url "https://$USERNAME:$PASSWORD@$ACCOUNT.cloudant.com" --db "animaldb" > /path/to/folder/animaldb-backup-`date -u "+%Y-%m-%dT%H:%M:%SZ"`.bak
```
{:codeblock}

此 cron 項目會在 05:00 建立每日備份。您可以視需要將 cron 型樣修改為每小時、每日、每週或每月備份。

## 使用 CouchBackup 作為程式庫

`couchbackup` 及 `couchrestore` 指令行工具都封裝一個程式庫，該程式庫可用於您自己的 node.js 應用程式。

程式庫對於更複雜的實務範例會很有幫助，例如：

* 使用一個作業來備份數個資料庫。您可以執行此備份，方法為使用 [`_all_dbs`](../api/database.html#get-databases) 呼叫來識別所有資料庫，然後個別執行每一個資料庫的備份。
* 越長的管線越會增加錯誤的風險。使用 CouchBackup 程式庫，您的應用程式可以偵測任何錯誤，並儘早解決它們。

如需相關資訊，請參閱 [npm 頁面 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")][npmpackage]{:new_window}。

下列 Script 範例顯示如何使用 {{site.data.keyword.IBM}} Cloud Object Storage 來結合 `couchbackup` 程式庫。此程式碼說明您如何使用「跨地區 S3 API」，將資料庫備份至物件儲存庫。

> **附註**：程式碼的必要條件為起始設定 {{site.data.keyword.IBM_notm}} Cloud Object Storage 的 S3 用戶端物件，方法為遵循
[這些指示 ![外部鏈結圖示](../images/launch-glyph.svg "外部鏈結圖示")][cosclient]{:new_window}。



```javascript
/*
  Backup directly from Cloudant to an S3 bucket via a stream.
  @param {string} couchHost - URL of database root
  @param {string} couchDatabase - backup source database
  @param {object} s3Client - S3 client object
  @param {string} s3Bucket - Destination S3 bucket (must exist)
  @param {string} s3Key - Destination object's key (shouldn't exist)
  @param {boolean} shallow - Whether to use couchbackup's shallow mode
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

## 其他災難回復選項

回到 [{{site.data.keyword.cloudant_short_notm}} 災難回復手冊](disaster-recovery-and-backup.html)，找出 {{site.data.keyword.cloudant_short_notm}} 為了完整災難回復設定而提供之其他功能的相關資訊。

[npmpackage]: https://www.npmjs.com/package/@cloudant/couchbackup
[npmreadme]: https://github.com/cloudant/couchbackup/blob/master/README.md
[cosclient]: https://developer.ibm.com/recipes/tutorials/cloud-object-storage-s3-api-intro/
