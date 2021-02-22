---

copyright:
  years: 2017, 2021
lastupdated: "2021-03-11"

keywords: couchbackup, back up your data, restore data, limitations, use the tools, use couchbackup as a library

subcollection: Cloudant

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
{:external: target="_blank" .external}

<!-- Acrolinx: 2020-04-10 -->

# {{site.data.keyword.cloudant_short_notm}} backup and recovery
{: #ibm-cloudant-backup-and-recovery}

Although data is stored redundantly within an {{site.data.keyword.cloudant_short_notm}} cluster,
it's important to consider extra backup measures.
For example,
redundant data storage doesn't protect against mistakes when data is changed.
{: shortdesc}

If you're new to the subject and want to understand where back up fits in
with the other features that {{site.data.keyword.cloudantfull}} offers
to support Disaster Recovery (DR) and High Availability (HA) requirements, review the [{{site.data.keyword.cloudant_short_notm}} Disaster Recovery guide](/docs/Cloudant?topic=Cloudant-disaster-recovery-and-backup#disaster-recovery-and-backup). 
{: note}

## Introducing CouchBackup
{: #introducing-couchbackup}

{{site.data.keyword.cloudant_short_notm}} provides a supported tool for snapshot backup and restore.
The tool is called CouchBackup,
and is open source.
It's a `node.js` library,
and you can install it on [NPM](https://www.npmjs.com/package/@cloudant/couchbackup){: new_window}{: external}.

The CouchBackup package includes the library and two command-line tools:

1. `couchbackup`, which dumps the JSON data from a database to a backup text file.
2. `couchrestore`, which restores data from a backup text file to a database.

The CouchBackup tools have [limitations](#limitations).
{: important}

## Backing up your {{site.data.keyword.cloudant_short_notm}} data
{: #backing-up-your-ibm-cloudant-data}

You can do a simple backup by using the `couchbackup` tool.
To back up the `animaldb` database to a text file called `backup.txt`,
you might use a command similar to the following example:

```sh
couchbackup --url "https://examples.cloudant.com" --db animaldb > backup.txt
```
{: codeblock}

The [NPM readme file](https://github.com/cloudant/couchbackup/blob/master/README.md){: new_window}{: external} details other options,
including the ones in this list:

* Environment variables to set the names of the database and URL.
* Using a log file to record the progress of a backup.
* The ability to resume an interrupted backup.

  This option is only available with the log file for the interrupted backup.
  {: note}

* Sending the backup text file to a named output file,
  rather than redirecting the `stdout` output.

The CouchBackup tools have [limitations](#limitations).
{: important}

## Restoring your {{site.data.keyword.cloudant_short_notm}} data
{: #restoring-your-ibm-cloudant-data}

To restore your data,
use the `couchrestore` tool.
Use `couchrestore` to import the backup file
into a new {{site.data.keyword.cloudant_short_notm}} database.
Then,
ensure that you build all indexes before any application tries to use the restored data.

For example,
to restore the data that was backed up in the earlier example:

```sh
couchrestore --url "https://myaccount.cloudant.com" --db newanimaldb < backup.txt
```
{: codeblock}

The [NPM readme file](https://github.com/cloudant/couchbackup/blob/master/README.md){: new_window}{: external} provides details of other restore options.

The CouchBackup tools have [limitations](#limitations).
{: important}

## Limitations
{: #limitations}

The CouchBackup tools have the following limitations: 
{: important}

* `_security` settings aren't backed up by the tools.
* Attachments aren't backed up by the tools.
* Backups aren't precise "point-in-time" snapshots.
  The reason is that the documents in the database are retrieved in batches,
  but other applications might be updating documents at the same time.
  Therefore, data in the database can change between the times when the first and last batches are read.
* Index definitions that are held in design documents are backed up,
  but the content of indexes isn't backed up.
  This limitation means that when data is restored,
  the indexes must be rebuilt.
  The rebuilding might take a considerable amount of time,
  depending on how much data is restored.

## Using the tools
{: #using-the-tools}

The [NPM page](https://www.npmjs.com/package/@cloudant/couchbackup){: new_window}{: external}
details the basics of using the command-line tools for backup and restore of data.
The following examples show how to put those details into practice
by describing the use of the tools for specific tasks.

The CouchBackup package provides two ways of using its core functions.

* The command-line tools can be embedded into standard UNIX&trade; command pipelines.
  For many scenarios,
  a combination of `cron` and simple shell scripting of the `couchbackup` application is sufficient.
* A library usable from Node.js.
  The library allows more complicated backup processes to be created and deployed,
  such as determining dynamically which databases must be backed up.

Use either the command-line backup tool,
or the library with application code,
to enable backup from {{site.data.keyword.cloudant_short_notm}} databases as part of more complicated situations.
A useful scenario is scheduling backups by using `cron`,
and automatically uploading data to
[Cloud Object Storage](https://www.ibm.com/cloud/object-storage/solutions?mhq=object%20storage%20public&mhsrc=ibmsearch_a){: new_window}{: external}
for long-term retention.

## Command line scripting examples
{: #command-line-scripting-examples}

You frequently need to meet the following two requirements:

* Saving disk space by ['zipping' the backup](#compressing-a-backup-file) file as you create it.
* Creating a backup of a database automatically at [regular intervals](#hourly-or-daily-backups-that-use-cron-).

### Compressing a backup file
{: #compressing-a-backup-file}

The `couchbackup` tool can write a backup file to disk directly,
or stream the backup to `stdout`.
Streaming to `stdout` enables data to be transformed before it is written to disk.
This feature is used to compress data within the stream.

```sh
couchbackup --url "https://examples.cloudant.com" \
  --db "animaldb" | gzip > backup.gz
```
{: codeblock}

In this example,
the `gzip` tool accepts the backup data directly through its `stdin`,
compresses the data,
and emits it through `stdout`.
The resulting compressed data stream is then redirected and written to a file called `backup.gz`.

If the database requires you to supply access credentials,
use a URL of the form `https://$USERNAME:$PASSWORD@$ACCOUNT.cloudant.com`,
for example:

```sh
couchbackup --url "https://$USERNAME:$PASSWORD@examples.cloudant.com" \
  --db "animaldb" | gzip > backup.gz
```
{: codeblock}

It's straightforward to extend the pipeline if you want to transform the data in other ways.
For example,
you might want to encrypt the data before it's written to disk.
You might also want to write the data directly to an object store service by using their command-line tools.

### Hourly or daily backups that use `cron`
{: #hourly-or-daily-backups-that-use-cron-}

The `cron` scheduling tool can be set up to take snapshots of data at regular intervals.

A useful starting point is to get `couchbackup` to write a single backup to a file,
where the file name includes the current date and time,
as shown in the following example:

```sh
couchbackup --url "https://$USERNAME:$PASSWORD@$ACCOUNT.cloudant.com" \
  --db "animaldb" > animaldb-backup-`date -u "+%Y-%m-%dT%H:%M:%SZ"`.bak
```
{: codeblock}

After you check the command to ensure it works correctly,
it can be entered into a 'cron job':

1.  Install the CouchBackup tools on the server that you want to do the backups.
2.  Create a folder to store the backups.
3.  Create a 'cron entry' that describes the frequency of the backup.

You can create a cron entry by using the `crontab -e` command.
See your system documentation for specific details on the 'cron' options.

A cron entry that runs a daily backup looks similar to the following example:

```sh
0 5 * * * couchbackup --url "https://$USERNAME:$PASSWORD@$ACCOUNT.cloudant.com" --db "animaldb" > /path/to/folder/animaldb-backup-`date -u "+%Y-%m-%dT%H:%M:%SZ"`.bak
```
{: codeblock}

This cron entry creates a daily backup at 05:00.
You can modify the cron pattern to run hourly, daily, weekly, or monthly backups as needed.

## Using CouchBackup as a library
{: #using-couchbackup-as-a-library}

The `couchbackup` and `couchrestore` command-line tools are wrappers around a library
that can be used in your own Node.js applications.

The library is useful for more complicated scenarios,
for example:

* Backing up several databases in one task.
  You might do this backup by identifying all the databases by using the [`_all_dbs`](/apidocs/cloudant#getalldbs){: new_window}{: external} call,
  then doing a backup of each database individually.
* Longer pipelines increase the risk of errors.
  By using the CouchBackup library,
  your application can detect and address any error at the earliest opportunity.

For more information,
see the [NPM page](https://www.npmjs.com/package/@cloudant/couchbackup){: new_window}{: external}.

The following script sample shows how to combine the `couchbackup` library
with use of {{site.data.keyword.IBM}} Cloud Object Storage.
This code illustrates how you might use Cross Region S3 API to back up a database to an object store.

A prerequisite for the code is that you initialize the S3 client object for {{site.data.keyword.IBM_notm}} Cloud Object Storage by following the instructions in [{{site.data.keyword.cloud_notm}} Object Storage - S3 API Intro](https://cloud.ibm.com/docs/cloud-object-storage?topic=cloud-object-storage-compatibility-api){: new_window}{: external}.
{: note}

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
    // It has a 10 MB internal buffer.
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
{: codeblock}

## Other disaster recovery options
{: #other-disaster-recovery-options}

Return to the [{{site.data.keyword.cloudant_short_notm}} Disaster Recovery guide](/docs/Cloudant?topic=Cloudant-disaster-recovery-and-backup#disaster-recovery-and-backup)
to find out about the other features {{site.data.keyword.cloudant_short_notm}}
offers for a full disaster recovery setup.
