---

copyright:
  years: 2015, 2017
lastupdated: "2017-06-12"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-05-31 -->

# Advanced replication

This section contains details about more advanced replication concepts and tasks.
{:shortdesc}

## Replication database maintenance

A replication database must be looked after like any other database.
Without regular database maintenance,
you might accumulate invalid documents that were caused by interruptions to the replication process.
Having many invalid documents can result in an excess load on your cluster
when the replicator process is restarted by Cloudant operations.

The main action that you can do to maintain a replication database is to remove old documents.
This can be done by determining the age of documents,
and [deleting them](document.html#delete) if they are no longer needed.

## The `/_replicate` endpoint

>	**Note**: It is preferable to use the [Replicator database](replication.html#the-_replicator-database) to manage replication.
	Details of why are provided [here](#avoiding-the-_replicate-endpoint).

You can use this endpoint to request,
configure,
or stop,
a replication operation.

You do this by sending a `POST` request directly to the `/_replicate` endpoint.
The `POST` contains a JSON document that describes the wanted replication.

-	**Method**: `POST`
-	**Path**: `/_replicate`
-	**Request**: Replication specification
-	**Roles**: `_admin`

The specification of the replication request is controlled through the JSON content of the request.
The JSON document must contain fields that define the source,
target,
and other options.

With the exception of the `cancel` field,
the fields in the JSON document supplied to the `_replicate` endpoint are identical to those in
a replication document stored in the [`_replicator` database](replication.html#replicator-database).
The JSON document uses the [replication document format](replication.html#replication-document-format).

The fields of the JSON request are as follows:

Field           | Purpose                                                     | Optional
----------------|-------------------------------------------------------------|---------
`cancel`        | Cancels the replication.                                    | Yes
`continuous`    | Configure the replication to be continuous.                 | Yes
`create_target` | Creates the target database.                                | Yes
`doc_ids`       | Array of document IDs to be synchronized.                   | Yes
`proxy`         | Address of a proxy server through which replication occurs. | Yes
`source`        | Source database URL, including user name and password.      | No
`target`        | Target database URL, including user name and password.      | No

_Example instructions for using HTTP to start a replication through the `_replicate` endpoint:_

```http
POST /_replicate HTTP/1.1
Content-Type: application/json
```
{:codeblock}

_Example instructions for using the command line to start a replication through the `_replicate` endpoint:_

```sh 
curl -H 'Content-Type: application/json' -X POST "https://$ACCOUNT.cloudant.com/_replicate" -d @replication-doc.json
# with the file replication-doc.json containing the required replication information.
```
{:codeblock}

_Example JSON document that describes the required replication:_

```json
{
	"source": "http://$ACCOUNT:$PASSWORD@username.cloudant.com/example-database",
	"target": "http://$ACCOUNT2:$PASSWORD2@example.org/example-target-database"
}
```
{:codeblock}

### Return Codes

Code  | Description
------|------------
`200` | Replication request successfully completed.
`202` | Continuous replication request has been accepted.
`404` | Either the source or target database was not found.
`500` | JSON specification was invalid.

### Canceling replication using the `/_replicate` endpoint

A replication that is triggered by `POST`ing to `/_replicate` can be canceled
by `POST`ing the exact same JSON object but with the additional `cancel` property set to `true`.

>	**Note**: If a replication is canceled,
the request that initiated the replication fails with [error 500 (shutdown)](http.html#500).

The replication ID can be obtained from the original replication request if it is a continuous replication.
Alternatively,
the replication ID can be obtained from [`/_active_tasks`](active_tasks.html).

_Example of using HTTP to cancel a replication:_

```http
POST /_replicate HTTP/1.1
Content-Type: application/json
```
{:codeblock}

_Example of using the command line to cancel a replication:_

```sh
curl -H 'Content-Type: application/json' -X POST 'https://$ACCOUNT.cloudant.com/_replicate HTTP/1.1' -d @replication-doc.json
# the file replication-doc.json must be supplied.
```
{:codeblock}

_Example JSON document that describes the replication to be canceled:_

```json
{
	"source": "https://$USERNAME:$PASSWORD@$ACCOUNT.cloudant.com/example-database",
	"target": "https://$USERNAME2:$PASSWORD2@example.org/example-database",
	"cancel": true
}
```
{:codeblock}

### Avoiding the `/_replicate` endpoint

>   **Note**: Use the [`_replicator` database](replication.html#replicator-database) in preference to the `/_replicate` endpoint.

A significant reason is that if there was a problem during replication,
such as a stall,
timeout,
or application crash,
then a replication that is defined within the `_replicator` database is automatically restarted by the system.

If you defined a replication by sending a request to the `/_replicate` endpoint,
it cannot be restarted by the system if a problem occurs because the replication request does not persist.

In addition,
replications that are defined in the `_replicator` database are easier to [monitor](advanced_replication.html#replication-status).

