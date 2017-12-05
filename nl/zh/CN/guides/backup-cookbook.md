---

copyright:
  years: 2017
lastupdated: "2017-07-11"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-05-23 -->

# Cloudant 备份和恢复

本手册构成了 [{{site.data.keyword.cloudantfull}} 灾难恢复指南](disaster-recovery-and-backup.html)的一部分。如果您是第一次接触本主题，并且希望了解备份在哪些方面可与 {{site.data.keyword.cloudant_short_notm}} 提供的其他功能配合使用，以支持灾难恢复 (DR) 和高可用性 (HA) 需求，那么应该首先阅读此处的内容。

虽然数据以冗余方式存储在 {{site.data.keyword.cloudant_short_notm}} 集群中，但考虑额外的备份措施仍然很重要。例如，更改数据时，冗余数据存储器无法防止错误。

## CouchBackup 简介

{{site.data.keyword.cloudant_short_notm}} 提供了一个用于快照备份和复原的支持工具。该工具名为 CouchBackup，是开放式源代码性质的。它是一个 `node.js` 库，[可供安装在 npm ![外部链接图标](../images/launch-glyph.svg "外部链接图标") 上][npmpackage]{:new_window}。

除了该库外，CouchBackup 软件包还包含两个命令行工具：

1. `couchbackup`，用于将数据库中的 JSON 数据转储到备份文本文件。
2. `couchrestore`，用于将备份文本文件中的数据复原到数据库。

<strong style="color:red;">警告！</strong>CouchBackup 工具存在[限制](#limitations)。

## 备份 Cloudant 数据

可以使用 `couchbackup` 工具来执行简单备份。要将 `animaldb` 数据库备份到名为 `backup.txt` 的文本文件，可以使用类似于以下示例的命令：

```sh
couchbackup --url https://examples.cloudant.com --db animaldb > backup.txt
```
{:codeblock}

[npm 自述文件 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")][npmreadme]{:new_window} 详细描述了其他选项，包括：

* 用于设置数据库名称和 URL 的环境变量。
* 使用日志文件来记录备份的进度。
* 恢复已中断备份的能力。**注**：此选项仅可用于已中断备份的日志文件。
* 将备份文本文件发送到指定的输出文件，而不是重定向 `stdout` 输出。

<strong style="color:red;">警告！</strong>CouchBackup 工具存在[限制](#limitations)。

## 复原 Cloudant 数据

要复原数据，请使用 `couchrestore` 工具。使用 `couchrestore` 将备份文件导入到新的 {{site.data.keyword.cloudant_short_notm}} 数据库中。然后，在任何应用程序尝试使用复原的数据之前，请确保构建所有索引。

例如，要复原先前示例中备份的数据，请执行以下操作：

```sh
couchrestore --url https://myaccount.cloudant.com --db newanimaldb < backup.txt
```
{:codeblock}

[npm 自述文件 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")][npmreadme]{:new_window} 提供了其他复原选项的详细信息。

<strong style="color:red;">警告！</strong>CouchBackup 工具存在[限制](#limitations)。

## 限制

<strong style="color:red;">警告！</strong>CouchBackup 工具存在以下限制： 

* 工具不会备份 `_security` 设置。
* 工具不会备份附件。
* 备份不是完全准确的“时间点”快照。原因是数据库中的文档是批量检索的，而其他应用程序可能在同时更新文档。因此，在读取第一批和最后一批之间的这段时间内，数据库中的数据可能会更改。
* 将备份设计文档中保存的索引定义，但不会备份索引的内容。此限制意味着复原数据时，必须重建索引。重建可能需要相当长的时间，具体取决于复原的数据量。

## 使用工具

[npm 页面 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")][npmpackage]{:new_window} 详细说明了有关使用命令行工具来备份和复原数据的基本信息。以下示例通过描述如何将工具用于特定任务，说明了如何实际运用这些详细信息。

CouchBackup 软件包提供了两种方法来使用其核心功能。

* 命令行工具可以嵌入到标准 UNIX 命令管道中。对于许多方案，`cron` 与 `couchbackup` 应用程序的简单 shell 脚本编制的组合已足以满足需求。
* 可通过 node.js 使用的库。该库支持创建和部署更复杂的备份过程，例如动态确定必须备份的数据库。

使用命令行备份工具或具有应用程序代码的库，以支持在更复杂的情境中从 {{site.data.keyword.cloudant_short_notm}} 数据库进行备份。一个有用的方案是使用 `cron` 安排备份，并自动将数据上传到 [Cloud Object Storage ![外部链接图标](../images/launch-glyph.svg "外部链接图标")](http://www-03.ibm.com/software/products/en/object-storage-public){:new_window} 以长期保留。

## 命令行脚本编制示例

经常会遇到两个需求：

* 在创建备份文件时，通过[“压缩”备份](#zipping-a-backup-file)文件来节省磁盘空间。
* [定期](#hourly-or-daily-backups-using-cron)自动创建数据库的备份。

### 压缩备份文件

`couchbackup` 工具可以将备份文件直接写入磁盘，也可以将备份流式传送到 `stdout`。流式传送到 `stdout` 支持在对数据进行变换之后再将其写入磁盘。此功能用于压缩流中的数据。

```sh
couchbackup --url "https://examples.cloudant.com" \
  --db "animaldb" | gzip > backup.gz
```
{:codeblock}

在此示例中，`gzip` 工具直接通过其 `stdin` 接受备份数据，压缩数据，再通过 `stdout` 发出数据。随后，生成的压缩数据流将重定向并写入名为 `backup.gz` 的文件。

如果数据库需要您提供访问凭证，请使用格式为 `https://$USERNAME:$PASSWORD@$ACCOUNT.cloudant.com` 的 URL，例如：

```sh
couchbackup --url "https://$USERNAME:$PASSWORD@examples.cloudant.com" \
  --db "animaldb" | gzip > backup.gz
```
{:codeblock}

如果要以其他方式变换数据，只要直接扩展管道即可。例如，您可能希望在对数据进行加密之后再将其写入磁盘。或者，您可能希望使用相应的命令行工具，将数据直接写入对象存储服务。

### 使用 `cron` 执行每小时或每日备份

`cron` 安排工具可以设置为定期生成数据快照。

首先获取 `couchbackup` 以用于将单个备份写入文件会很有用，其中文件名包含当前日期和时间，如以下示例所示：

```sh
couchbackup --url "https://$USERNAME:$PASSWORD@$ACCOUNT.cloudant.com" \
  --db "animaldb" > animaldb-backup-`date -u "+%Y-%m-%dT%H:%M:%SZ"`.bak
```
{:codeblock}

检查该命令以确保它正常运行后，可以将其输入到“cron 作业”中：

1.  在要执行备份的服务器上安装 CouchBackup 工具。
2.  创建用于存储备份的文件夹。
3.  创建用于描述备份频率的“cron 条目”。

可以使用 `crontab -e` 命令来创建 cron 条目。有关“cron”选项的具体详细信息，请查阅系统文档。

用于执行每日备份的 cron 条目类似于以下示例：

```sh
0 5 * * * couchbackup --url "https://$USERNAME:$PASSWORD@$ACCOUNT.cloudant.com" --db "animaldb" > /path/to/folder/animaldb-backup-`date -u "+%Y-%m-%dT%H:%M:%SZ"`.bak
```
{:codeblock}

此 cron 条目在 05:00 创建每日备份。可以根据需要修改 cron 模式以执行每小时、每日、每周或每月备份。

## 将 CouchBackup 用作库

`couchbackup` 和 `couchrestore` 命令行工具是用于对库进行包装的包装程序，可以在您自己的 node.js 应用程序中使用。

对于更复杂的方案，库会很有用，例如：

* 在一个任务中备份多个数据库。执行这种备份的方法可以是通过使用 [`_all_dbs`](../api/database.html#get-databases) 调用来确定所有数据库，然后分别执行每个数据库的备份。
* 管道越长，出错的风险越高。通过使用 CouchBackup 库，应用程序可以尽早检测并处理任何错误。

有关更多信息，请参阅 [npm 页面 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")][npmpackage]{:new_window}。

以下脚本样本说明了如何将 `couchbackup` 库与 {{site.data.keyword.IBM}} Cloud Object Storage 组合使用。此代码说明了可以如何使用跨区域 S3 API 将数据库备份到对象存储。

> **注**：此代码的先决条件是通过遵循[以下指示信息 ![外部链接图标](../images/launch-glyph.svg "外部链接图标")][cosclient]{:new_window}，初始化 {{site.data.keyword.IBM_notm}} Cloud Object Storage 的 S3 客户机对象。

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

## 其他灾难恢复选项

返回到 [{{site.data.keyword.cloudant_short_notm}} 灾难恢复指南](disaster-recovery-and-backup.html)，以了解 {{site.data.keyword.cloudant_short_notm}} 为完全灾难恢复设置提供的其他功能。

[npmpackage]: https://www.npmjs.com/package/@cloudant/couchbackup
[npmreadme]: https://github.com/cloudant/couchbackup/blob/master/README.md
[cosclient]: https://developer.ibm.com/recipes/tutorials/cloud-object-storage-s3-api-intro/
