---

copyright:
  years: 2015, 2022
lastupdated: "2022-06-03"

keywords: create database, database topology, multiple queries, work with databases, partition database, delete database, back up data, create database applications

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# Creating a database
{: #create-database}

To create a database,
submit a `PUT` request with the following format:

Method
:  `PUT /$DATABASE?partitioned=$BOOLEAN`

Request body
:  None

Response
:  Success or failure of operation.

Roles permitted
:  `_admin`

See the following example that uses HTTP to create a partitioned database:

```http
PUT /$DATABASE?partitioned=true HTTP/1.1
HOST: $ACCOUNT.cloudant.com
```
{: codeblock}

See the following example that uses HTTP to create a non-partitioned database:

```http
PUT /$DATABASE?partitioned=false HTTP/1.1
HOST: $ACCOUNT.cloudant.com
```
{: codeblock}

## Example - Creating a partitioned database
{: #example-creating-a-partitioned-db}

To create a partitioned database, see the following example:

```sh
curl -H "Authorization: Bearer $API_BEARER_TOKEN" -X PUT "$SERVICE_URL/products?partitioned=true"
```
{: codeblock}
{: curl}

```java
import com.ibm.cloud.cloudant.v1.Cloudant;
import com.ibm.cloud.cloudant.v1.model.Ok;
import com.ibm.cloud.cloudant.v1.model.PutDatabaseOptions;

Cloudant service = Cloudant.newInstance();

PutDatabaseOptions databaseOptions = new PutDatabaseOptions.Builder()
    .db("products")
    .partitioned(true)
    .build();

Ok response =
    service.putDatabase(databaseOptions).execute()
        .getResult();

System.out.println(response);
```
{: codeblock}
{: java}

```javascript
const { CloudantV1 } = require('@ibm-cloud/cloudant');

const service = CloudantV1.newInstance({});

service.putDatabase({
  db: 'products',
  partitioned: true
}).then(response => {
  console.log(response.result);
});
```
{: codeblock}
{: javascript}

```python
from ibmcloudant.cloudant_v1 import CloudantV1

service = CloudantV1.new_instance()

response = service.put_database(db='products', partitioned=True).get_result()

print(response)
```
{: codeblock}
{: python}

```go
putDatabaseOptions := service.NewPutDatabaseOptions(
  "products",
)
putDatabaseOptions.SetPartitioned(true)

ok, response, err := service.PutDatabase(putDatabaseOptions)
if err != nil {
  panic(err)
}

b, _ := json.MarshalIndent(ok, "", "  ")
fmt.Println(string(b))
```
{: codeblock}
{: go}

The previous Go example requires the following import block:
{: go}

```go
import (
   "encoding/json"
   "fmt"
   "github.com/IBM/cloudant-go-sdk/cloudantv1"
)
```
{: codeblock}
{: go}

All Go examples require the `service` object to be initialized. For more information, see the API documentation's [Authentication section](https://cloud.ibm.com/apidocs/cloudant?code=go#authentication-with-external-configuration) for examples. 
{: go}

## Example - Creating a non-partitioned database
{: #example-creating-a-non-partitioned-db}

To create a non-partitioned database, see the following example:

```sh
curl -H "Authorization: Bearer $API_BEARER_TOKEN" -X PUT "$SERVICE_URL/products"
```
{: codeblock}
{: curl}

```java
import com.ibm.cloud.cloudant.v1.Cloudant;
import com.ibm.cloud.cloudant.v1.model.Ok;
import com.ibm.cloud.cloudant.v1.model.PutDatabaseOptions;

Cloudant service = Cloudant.newInstance();

PutDatabaseOptions databaseOptions = new PutDatabaseOptions.Builder()
    .db("products")
    .build();

Ok response =
    service.putDatabase(databaseOptions).execute()
        .getResult();

System.out.println(response);
```
{: codeblock}
{: java}

```javascript
const { CloudantV1 } = require('@ibm-cloud/cloudant');

const service = CloudantV1.newInstance({});

service.putDatabase({
  db: 'products'
}).then(response => {
  console.log(response.result);
});
```
{: codeblock}
{: javascript}

```python
from ibmcloudant.cloudant_v1 import CloudantV1

service = CloudantV1.new_instance()

response = service.put_database(db='products').get_result()

print(response)
```
{: codeblock}
{: python}

```go
putDatabaseOptions := service.NewPutDatabaseOptions(
  "products",
)

ok, response, err := service.PutDatabase(putDatabaseOptions)
if err != nil {
  panic(err)
}

b, _ := json.MarshalIndent(ok, "", "  ")
fmt.Println(string(b))
```
{: codeblock}
{: go}

The previous Go example requires the following import block:
{: go}

```go
import (
   "encoding/json"
   "fmt"
   "github.com/IBM/cloudant-go-sdk/cloudantv1"
)
```
{: codeblock}
{: go}

All Go examples require the `service` object to be initialized. For more information, see the API documentation's [Authentication section](https://cloud.ibm.com/apidocs/cloudant?code=go#authentication-with-external-configuration) for examples. 
{: go}

## Query arguments
{: #query-arguments-database}

| Argument        | Description | Optional | Type | Default | Supported values |
|-----------------|-------------|----------|------|---------|------------------|
| `partitioned`   | Determines whether the database is partitioned. | Yes | Boolean | `false` | `true`, `false` |
{: caption="Table 1. Query arguments" caption-side="top"}

## Database naming
{: #database-naming}

The database name must start with a lowercase letter,
and contain only the following characters:

-   Lowercase characters (a-z)
-   Digits (0-9)
-   Any of the characters _, $, (, ), +, -, and /

If your database is successfully created, you get a 201 or 202 response. An error response uses the HTTP status code to indicate what went wrong.

Code | Description
-----|------------
201  | Database created successfully.
202  | The database was successfully created on some nodes, but the number of nodes is less than the write quorum.
400  | Invalid database name.
412  | Database exists.
{: caption="Table 2. HTTP status codes" caption-side="top"}

See the following example response that is received after a database is created successfully:

```http
HTTP/1.1 201 Created

{
    "ok": true
}
```
{: codeblock}

## Database topology
{: #database-topology}

It's possible to modify the configuration of a sharding topology for a
database on dedicated database clusters.
This modification can be done when the database is created.
However,
poor choices for configuration parameters can adversely affect database performance.

For more information about modifying database configuration
in a dedicated database environment,
contact {{site.data.keyword.cloudant_short_notm}} support.

It isn't possible to modify the configuration that is used for databases
on multi-tenant clusters.
{: note}
