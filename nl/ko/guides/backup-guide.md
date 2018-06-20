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

# {{site.data.keyword.cloudant_short_notm}} 백업 및 복구

이 쿡북은 [{{site.data.keyword.cloudantfull}} 재해 복구 안내서](disaster-recovery-and-backup.html)의 일부입니다.
이 주제를 처음 접하며 {{site.data.keyword.cloudantfull}}에서
재해 복구(DR) 및 고가용성(HA) 요구사항을 지원하기 위해 제공하는 다른 기능과
백업이 어떻게 조화되는지 이해하려면 이 설명을 먼저 읽는 것이 좋습니다.

데이터가 {{site.data.keyword.cloudant_short_notm}} 클러스터 내에 중복 저장되긴 하지만, 추가 백업 수단을 갖추는 것은 여전히 중요합니다.
예를 들면, 중복 데이터 저장은 실수로 데이터를 변경한 경우로부터 데이터를 보호해 주지 않습니다.

## CouchBackup 소개

{{site.data.keyword.cloudant_short_notm}}에서는 스냅샷 백업 및 복원을 위한 지원 도구를 제공합니다.
이 도구의 이름은 CouchBackup이며
이는 오픈 소스입니다.
이 도구는 `node.js` 라이브러리이며
[npm에 설치 가능 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")][npmpackage]{:new_window}합니다.

라이브러리 외에, CouchBackup 패키지에는 두 가지의 명령행 도구가 포함되어 있습니다.

1. `couchbackup`은 데이터베이스에서 백업 텍스트 파일로 JSON 데이터를 덤프합니다.
2. `couchrestore`는 백업 텍스트 파일에서 데이터베이스로 데이터를 복원합니다.

<strong style="color:red;">주의하십시오!</strong> CouchBackup 도구에는 [제한사항](#limitations)이 있습니다.

## {{site.data.keyword.cloudant_short_notm}} 데이터 백업

`couchbackup` 도구를 사용하여 단순 백업을 수행할 수 있습니다.
`animaldb` 데이터베이스를 `backup.txt`라는 텍스트 파일에 백업하려는 경우에는
다음 예와 유사한 명령을 사용할 수 있습니다.

```sh
couchbackup --url https://examples.cloudant.com --db animaldb > backup.txt
```
{:codeblock}

[npm readme ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")][npmreadme]{:new_window}에는 다음 항목을 포함한 기타 옵션이
자세히 설명되어 있습니다.

* 데이터베이스의 이름 및 URL을 설정하는 환경 변수
* 로그 파일을 사용한 백업 진행상태 기록
* 인터럽트된 백업을 재개하는 기능
  **참고**: 이 옵션은 인터럽트된 백업에 대한 로그 파일이 있어야 사용 가능합니다.
* 백업 텍스트 파일을 `stdout` 출력으로 경로 재지정하지 않고 지정된 출력 파일에 전송

<strong style="color:red;">주의하십시오!</strong> CouchBackup 도구에는 [제한사항](#limitations)이 있습니다.

## {{site.data.keyword.cloudant_short_notm}} 데이터 복원

데이터를 복원하려면 `couchrestore` 도구를 사용하십시오.
`couchrestore`를 사용하여 백업 파일을
새 {{site.data.keyword.cloudant_short_notm}} 데이터베이스로 가져오십시오.
그 후에는 임의의 애플리케이션이 복원된 데이터를 사용하려 시도하기 전에 모든 인덱스를 빌드해야 합니다.

예를 들어, 이전 예에서 백업된 데이터를 복원하려는 경우에는 다음과 같이 입력하십시오.

```sh
couchrestore --url https://myaccount.cloudant.com --db newanimaldb < backup.txt
```
{:codeblock}

[npm readme ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")][npmreadme]{:new_window}에 기타 복원 옵션에 대한 세부사항이 제공되어 있습니다.

<strong style="color:red;">주의하십시오!</strong> CouchBackup 도구에는 [제한사항](#limitations)이 있습니다.

## 제한사항

<strong style="color:red;">주의하십시오!</strong> CouchBackup은 도구에는 다음 제한사항이 있습니다. 

* `_security` 설정은 이 도구에 의해 백업되지 않습니다.
* 첨부 파일은 이 도구에 의해 백업되지 않습니다.
* 이 백업은 정확한 "특정 시점" 스냅샷이 아닙니다.
  이는 데이터베이스의 문서가 일괄처리로 검색되지만
  다른 애플리케이션에서 동시에 해당 문서를 업데이트하고 있을 수 있기 때문입니다.
  따라서, 첫 번째 일괄처리 읽기와 마지막 일괄처리 읽기 사이에 데이터베이스 내의 데이터가 변경될 수 있습니다.
* 디자인 문서에 포함된 인덱스 정의는 백업되지만
  인덱스의 컨텐츠는 백업되지 않습니다.
  이 제한사항은 데이터가 복원되는 경우
  인덱스를 다시 빌드해야 함을 의미합니다.
  복원되는 데이터의 양에 따라 다시 빌드 작업에는
  상당한 시간이 소요될 수 있습니다.

## 도구 사용

[npm 페이지 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")][npmpackage]{:new_window}에
데이터 백업 및 복원을 위해 명령행을 사용하는 데 대한 기본 사항이 자세히 설명되어 있습니다.
다음 예는 특정 태스크를 위해 도구를 사용하는 방법을 설명하여
이러한 세부사항을 실제 사용하는 방법을 보여줍니다.

CouchBackup 패키지에서는 주요 기능을 사용하는 두 가지 방법을 제공합니다.

* 이 명령행 도구는 표준 UNIX 명령 파이프라인에 임베드할 수 있습니다.
  많은 시나리오의 경우에는 `cron`과
  `couchbackup` 애플리케이션의 간단한 쉘 스크립트만 사용하면 됩니다.
* node.js에서 사용 가능한 라이브러리.
  이 라이브러리를 통해 어떠한 데이터베이스를 백업해야 하는지 동적으로 결정하는 등의
  보다 복잡한 백업 프로세스를 작성하고 배치할 수 있습니다.

더 복잡한 상황의 일부로서 {{site.data.keyword.cloudant_short_notm}} 데이터베이스를 백업할 수 있도록 하려면
명령행 백업 도구를 사용하거나, 라이브러리와 애플리케이션 코드를 함께 사용하십시오.
유용한 시나리오는 `cron`을 사용하여 백업을 스케줄하고,
장기 보유를 위해 데이터를 자동으로
[Cloud Object Storage ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")](http://www-03.ibm.com/software/products/en/object-storage-public){:new_window}에
업로드하는 것입니다.

## 명령행 스크립트 예

일반적으로 필요한 요구사항은 다음 두 가지입니다.

* 백업 파일을 작성하며 [백업 파일 '압축'](#zipping-a-backup-file)을 수행하여 디스크 공간을 절약합니다.
* 데이터베이스의 백업을 [정기적인 간격으로](#hourly-or-daily-backups-using-cron) 자동 작성합니다.

### 백업 파일 압축

`couchbackup` 도구는 백업 파일을 디스크에 바로 작성하거나,
백업을 `stdout`에 스트리밍할 수 있습니다.
`stdout`으로의 스트리밍은 데이터를 디스크에 쓰기 전에 변환할 수 있도록 합니다.
이 기능은 스트림 내의 데이터를 압축하는 데 사용됩니다.

```sh
couchbackup --url "https://examples.cloudant.com" \
  --db "animaldb" | gzip > backup.gz
```
{:codeblock}

이 예에서
`gzip` 도구는 백업 데이터를 직접 `stdin`을 통해 입력받고,
데이터를 압축한 후
`stdout`을 통해 출력합니다.
결과 압축 데이터 스트림은 그 후 `backup.gz` 파일로 경로 재지정되어 기록됩니다.

데이터베이스에서 사용자에게 액세스 신임 정보를 제공하도록 요구하는 경우에는
`https://$USERNAME:$PASSWORD@$ACCOUNT.cloudant.com` 양식의 URL을 사용하십시오.
예를 들면 다음과 같습니다.

```sh
couchbackup --url "https://$USERNAME:$PASSWORD@examples.cloudant.com" \
  --db "animaldb" | gzip > backup.gz
```
{:codeblock}

이 파이프라인은 직관적이며 사용자가 데이터를 다른 방식으로 변환하고자 하는 경우에는 원하는 대로 확장할 수 있습니다.
예를 들어, 사용자는 데이터가 디스크에 기록되기 전에 이를 암호화하려 할 수 있습니다.
또는, 자신의 명령행 도구를 사용하여 데이터를 오브젝트 저장 서비스에 직접 기록하려 할 수 있습니다.

### `cron`을 사용한 시간별 또는 일별 백업

`cron` 스케줄링 도구는 정기적인 간격으로 데이터의 스냅샷을 작성하도록 설정될 수 있습니다.

이를 위해서는 먼저 다음 예에 표시된 바와 같이 `couchbackup`이 파일에 하나의 백업을 기록하도록 설정해야 하며, 여기서 파일 이름은 현재 날짜 및 시간을 포함합니다.

```sh
couchbackup --url "https://$USERNAME:$PASSWORD@$ACCOUNT.cloudant.com" \
  --db "animaldb" > animaldb-backup-`date -u "+%Y-%m-%dT%H:%M:%SZ"`.bak
```
{:codeblock}

명령이 올바르게 작동하는지 확인한 후에는 이를 'cron 작업'에 삽입할 수 있습니다.

1.  CouchBackup 도구를 백업할 서버에 설치하십시오.
2.  백업을 저장할 폴더를 작성하십시오.
3.  백업 빈도를 나타내는 'cron 항목'을 작성하십시오.

`crontab -e` 명령을 사용하여 cron 항목을 작성할 수 있습니다.
'cron' 옵션에 대한 구체적인 세부사항은 시스템 문서를 참조하십시오.

일별 백업을 수행하는 cron 항목은 다음 예와 유사합니다.

```sh
0 5 * * * couchbackup --url "https://$USERNAME:$PASSWORD@$ACCOUNT.cloudant.com" --db "animaldb" > /path/to/folder/animaldb-backup-`date -u "+%Y-%m-%dT%H:%M:%SZ"`.bak
```
{:codeblock}

이 cron 항목은 05:00에 일별 백업을 작성합니다.
사용자는 필요에 따라 시간별, 일별, 주별 또는 월별 백업을 수행하도록 cron 패턴을 수정할 수 있습니다.

## CouchBackup을 라이브러리로 사용

`couchbackup` 및 `couchrestore` 명령행 도구는 사용자의 node.js 애플리케이션에서 사용할 수 있는 라이브러리의 랩퍼입니다.

이 라이브러리는 다음 예와 같은 더 복잡한 시나리오에 유용합니다.

* 여러 데이터베이스를 하나의 태스크에서 백업합니다.
  [`_all_dbs`](../api/database.html#get-databases) 호출을 사용하여 모든 데이터베이스를 식별한 후
  각 데이터베이스의 백업을 개별적으로 수행하여 이 백업을 수행할 수 있습니다.
* 파이프라인이 길어질수록 오류가 발생할 위험성이 증가합니다.
  CouchBackup 라이브러리를 사용하면 애플리케이션이 오류를 일찍 발견하고 해결할 수 있게 됩니다.

자세한 정보는 [npm 페이지 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")][npmpackage]{:new_window}를 참조하십시오.

다음 스크립트 샘플은 `couchbackup` 라이브러리를 {{site.data.keyword.IBM}} Cloud Object Storage와 함께 사용하는 방법을 보여줍니다.
이 코드는 Cross Region S3 API를 사용하여 데이터베이스를 오브젝트 저장소에 백업하는 방법을 보여줍니다.

> **참고**: 이 코드의 전제조건은 다음 지시사항에 따라 S3 클라이언트 오브젝트를
  {{site.data.keyword.IBM_notm}} Cloud Object Storage용으로 초기화하는 것입니다.
[지시사항 ![외부 링크 아이콘](../images/launch-glyph.svg "외부 링크 아이콘")][cosclient]{:new_window}

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

## 기타 재해 복구 옵션

{{site.data.keyword.cloudant_short_notm}}에서 전체 재해 복구 설정을 위해 제공하는 기타 기능에 대해 알아보려면
[{{site.data.keyword.cloudant_short_notm}} 재해 복구 안내서](disaster-recovery-and-backup.html)로 돌아가십시오.

[npmpackage]: https://www.npmjs.com/package/@cloudant/couchbackup
[npmreadme]: https://github.com/cloudant/couchbackup/blob/master/README.md
[cosclient]: https://developer.ibm.com/recipes/tutorials/cloud-object-storage-s3-api-intro/
