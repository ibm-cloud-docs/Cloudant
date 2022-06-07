---

copyright:
  years: 2015, 2022
lastupdated: "2022-06-03"

keywords: create database, database topology, multiple queries, work with databases, partition database, delete database, back up data, create database applications

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# Undeleting a database
{: #undelete}

The database endpoint to view deleted databases and recover them with the undelete operation is only available with {{site.data.keyword.cloudantfull}} on Transaction Engine. This endpoint requires the IAM service role of Manager.
{: important} 

The undelete API capability does not automatically or immediately remove the data and any indexes in the database after a delete operation. Instead, the undelete API restores the deleted data back to the original state after an accidental delete or undesired delete operation. Databases can be restored for up to 48 hours after deletion after which time they are permanently deleted and cannot be recovered by using this API endpoint.

## `GET /_deleted_dbs`
{: #get-deleted_dbs}

Send a `GET` request to find a list of all the deleted databases in the {{site.data.keyword.cloudant_short_notm}} instance. 

### Request headers
{: #request-headers-db}


```sh    	
Accept –

    application/json
	text/plain
```
{: codeblock}

| Query parameters | Description |
|------------------|-------------|     	
| `descending` (Boolean) | Return the databases in descending order by key. Default is false. |
| `endkey` (JSON) | Stop returning databases when the specified key is reached. |
| `end_key` (JSON) | Alias for `endkey` parameter. |
| `key` (JSON) | Return the databases for the specified key. |
| `limit` (Number) | Limit the number of the returned databases to the specified Number. |
| `skip` (Number) | Skip this number of databases before the results are returned. Default is 0. |
| `startkey` (JSON) | Return databases by starting with the specified key. |
| `start_key` (JSON) | Alias for `startkey`. |
{: caption="Table 7. Query parameters" caption-side="top"}

### Response headers
{: #response-headers-db}

```sh     	
Content-Type –
    application/json
    text/plain; charset=utf-8
```
{: codeblock}

| Code | Description |	
|------|-------------|
| `200 OK` | Request completed successfully. |
{: caption="Table 8. HTTP request code" caption-side="top"}

See the following example request:

```sh
GET /_deleted_dbs HTTP/1.1
Accept: application/json
Host: localhost:5984
```
{: codeblock}

See the following example response: 

```sh
HTTP/1.1 200 OK
Cache-Control: must-revalidate
Content-Length: 52
Content-Type: application/json
Date: Tue, 23 Mar 2020 06:57:48 GMT
Server: CouchDB (Erlang/OTP)

[
    {
        "update_seq": "981...uUQ",
        "db_name": "contacts",
        "timestamp": "2020-03-24T12:34:56Z",
        "sizes": {
            "file": 46114703224,
            "external": 193164408719,
            "active": 34961621142
        },
        "purge_seq": 0,
        "other": {
            "data_size": 193164408719
        },
        "doc_del_count": 5564,
        "doc_count": 9818541,
        "disk_size": 46114703224,
        "disk_format_version": 6,
        "compact_running": true,
        "instance_start_time": "0"
    },
    {
        "update_seq": "982...uUQ",
        "db_name": "invoices",
        "timestamp": "2020-03-24T12:11:26Z",
        "sizes": {
            "file": 46114703224,
            "external": 193164408719,
            "active": 34961621142
        },
        "purge_seq": 0,
        "other": {
            "data_size": 193164408719
        },
        "doc_del_count": 5564,
        "doc_count": 9818541,
        "disk_size": 46114703224,
        "disk_format_version": 6,
        "compact_running": true,
        "instance_start_time": "0"
    }
]
```
{: codeblock}

## `POST /_deleted_dbs`
{: #post-deleted_dbs_undelete}

Send a `POST` request to restore (undelete) a deleted database.

### Parameters
{: #parameters-db}

None

### Request headers
{: #request-headers-delete-dbs}

```sh
Accept –
    application/json
    text/plain
```
{: codeblock}

### Request Body
{: #request-body-db}

```sh
{
    "undelete": {
        "timestamp" : "2020-03-23T02:26:35Z",
        "source" : "db01",
        "target" : "db02"
    }
}
```
{: codeblock}

In this case, the request body parameters are shown in the following list:
-   `timestamp` - The timestamp of the database deletion as shown in the GET `_deleted_dbs` endpoint.
-   `source` - The `db_name` of the database that was deleted as shown in the GET `_deleted_dbs` endpoint.
-   `target` - This field is optional. Defaults to the same database name as source.

See the following example request with curl to restore a database `testdb` back to its original name `testdb`:
```sh
curl \
-H 'Content-Type: application/json' \
-H 'Authorization: '"$TOK"'' \
'https://3472e460-6f10-42d7-8ebf-73b4cb8c6f1d-bluemix.cloudantnosqldb.test.appdomain.cloud/_deleted_dbs' \
-X POST \
-d '{"undelete":{"timestamp":"2020-05-19T19:44:58Z","source":"testdb"}}'
```
{: codeblock}

#### Response headers
{: #response-headersdb}

```sh
Content-Type –
    application/json
    text/plain; charset=utf-8
```
{: codeblock}

| Response JSON object | Description |
|----------------------|-------------|
| `ok` (Boolean) | Operation status. Status that is shown when  successful. |
| `error` (String) | Error type. Error is shown if response code is 4xx. |
| `reason` (String) | Error description. Reason is shown if response code is 4xx. |
{: caption="Table 9. Response JSON objects" caption-side="top"}

| Code | Message |
|--------------|---------|
| `200 Undeleted` | Database undeleted successfully. |
| `400 Bad Request` | Bad Request. Invalid payload in request. |
| `401 Unauthorized` | CouchDB Server Administrator privileges required. |
| `404 NotFound` | Invalid deleted timestamp. |
| `412 Precondition Failed` | Database exists. |
{: caption="Table 10. HTTP request codes" caption-side="top"}

#### `DELETE /_deleted_dbs/{db}`
{: #get-deleted_dbs-db}

Send a `DELETE` request to permanently delete the database instance, which was soft-deleted with the specified timestamp.

| Parameters | Description |
|------------|-------------|
| `timestamp` | Timestamp when the database was deleted. |
{: caption="Table 11. Parameter for _deleted_dbs endpoint" caption-side="top"}

##### Request headers 
{: #request-headers2-db}

```sh
Content-Type –
    application/json
```
{: codeblock}

##### Response headers
{: #response-headers2-db}

```sh
Content-Type –
    application/json
    text/plain; charset=utf-8
```
{: codeblock}

| Response JSON object | Description |
|----------------------|-------------|
| `ok` (Boolean) | Operation status. Status that is shown when successful. |
| `error` (String) | Error type. Error is shown if response code is 4xx. |
| `reason` (String) | Error description. Reason is shown if response code is 4xx. |
{: caption="Table 12. Response JSON object" caption-side="top"}

| Code | Message | 
|--------------|---------|
| `200 Restored` | Database restored successfully. | 
| `400 Bad Request` | Bad Request. Invalid payload in request. |
| `401 Unauthorized` | CouchDB Server Administrator privileges required. |
| `404 NotFound` | Invalid deleted timestamp. |
| `412 Precondition Failed` | Database exists. |
{: caption="Table 13. HTTP response codes" caption-side="top"}

## Backing up your data
{: #backing-up-your-data}

You must protect your data by taking good quality backups.
For more information, see an overview of [backing up your data](/docs/Cloudant?topic=Cloudant-ibm-cloudant-backup-and-recovery#ibm-cloudant-backup-and-recovery).
