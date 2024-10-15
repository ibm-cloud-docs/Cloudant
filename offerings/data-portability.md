---

copyright:
  years: 2024
lastupdated: "2024-10-15"

keywords: replication, export, data portability, backup, migrate, couchbackup, dora

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}


# Understanding data portability for {{site.data.keyword.cloudant_short_notm}}
{: #data-portability}

[Data Portability](#x2113280){: term} involves a set of tools, and procedures that enable customers to export data stored within {{site.data.keyword.cloudant_short_notm}} to different data stores hosted elsewhere. It includes procedures to export data using replication or backups, these data exports include the design documents used to generate indexes.
{: shortdesc}

## Responsibilities
{: #data-portability-responsibilities}

{{site.data.keyword.cloud}} services provide interfaces and instructions to guide the customer to copy and store the service customer content, including the related configuration, on their own selected location.

The customer is then responsible for the use of the exported data and configuration for the purpose of data portability to other infrastructures.

This can involve:

- the planning and execution for setting up alternate infrastructure on on different cloud providers or on-prem software that offer similar capabilities to the {{site.data.keyword.cloud}} services.
- the planning and execution for the porting of the required application code on the alternate infrastructure, including the adaptation of customer's application code, deployment automation, and so forth.
- the conversion of the exported data and configuration to the format required by the alternate infrastructure and adapted applications

For more information about your responsibilities when using {{site.data.keyword.cloudant_short_notm}}, see [Shared responsibilities for {{site.data.keyword.cloudant_short_notm}}](/docs/Cloudant?topic=Cloudant-cloudant-responsibilities).

## Data export procedures
{: #data-portability-procedures}

{{site.data.keyword.cloudant_short_notm}} provides mechanisms to export data uploaded, stored, and processed using the service.

There are two options to export data from {{site.data.keyword.cloudant_short_notm}}.

### Option 1: Replication
{: #option-1-replication}

If you are migrating to a data store that is compatible with Apache CouchDB, use [replication](/docs/Cloudant?topic=Cloudant-advanced-replication) to migrate all data stored with {{site.data.keyword.cloudant_short_notm}}.

Replication can be a push or pull model, for full details on configuring replications see,
[{{site.data.keyword.cloudant_short_notm}} Replication](/docs/Cloudant?topic=Cloudant-advanced-replication) and
[Advanced Replication](https://cloud.ibm.com/docs/Cloudant?topic=Cloudant-advanced-replication).
{: note}

Setting up a *push replication* to export data:

1. Create the `_replicator` database if it does not already exist:

```sh
curl -H "Authorization: Bearer $API_BEARER_TOKEN" -X PUT "$SERVICE_URL/_replicator
```
{: codeblock}

1. Create a replication document for each database you want to export using replication. Use the following command as an example, setting the variables to appropriate values.

```sh
curl -H "Authorization: Bearer $API_BEARER_TOKEN" -X PUT "$SERVICE_URL/_replicator/$SOURCE_DATABASE_export" -H "Content-Type: application/json" --data '{
  "_id": "'"$SOURCE_DATABASE"'_export",
  "create_target": true,
  "source": {
    "url": "'"$SOURCE_SERVICE_URL/$SOURCE_DATABASE"'"
    "auth": {
      "iam": {
        "api_key": "'"$API_KEY"'"
      }
    }
  },
  "target": {
    "auth": {
      "basic": {
        "username": "'"$TARGET_DATABASE_USERNAME"'",
        "password": "'"$TARGET_DATABASE_PASSWORD"'"
      }
    },
    "url": "'"$TARGET_URL/$TARGET_DATABASE"'"
  }
}'
```
{: codeblock}


### Option 2: CouchBackup
{: #option-2-couchbackup}

If the target data store is not compatible with Apache CouchDB, {{site.data.keywaord.cloudant_short_notm}} provides a supported tool
for backing up data called CouchBackup. Information on using CouchBackup can be found in [{{site.data.keywaord.cloudant_short_notm}} backup and recovery](docs/Cloudant?topic=Cloudant-ibm-cloudant-backup-and-recovery), along with the [GitHub `README` file](https://github.com/cloudant/couchbackup/blob/master/README.md){: external}.

## Exported data formats
{: #data-portability-data-formats}

Data exported via replication to a data store compatible with Apache CouchDB writes directly to the target data store. When exporting using CouchBackup, the expected file formats are:

### Backup file
{: #couchbackup-file}

A CouchbBackup backup file is in a JSON lines format. See [What's in a backup file?](https://github.com/IBM/couchbackup/blob/main/README.md#whats-in-a-backup-file){: external} in the
GitHub `README` file for full details.

## Data ownership
{: #data-ownership}

All exported data is classified as Customer content and therefore full customer ownership and licensing rights, as stated in [IBM Cloud Service Agreement](https://www.ibm.com/terms/?id=Z126-6304_WS) applies.
