---

copyright:
  years: 2015, 2022
lastupdated: "2022-06-03"

keywords: create database, database topology, multiple queries, work with databases, partition database, delete database, back up data, create database applications

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# Deleting a database
{: #deleting-a-database}

To delete a database and its contents,
send a `DELETE` request to `https://$ACCOUNT.cloudant.com/$DATABASE`.

No additional check is made to ensure that you really intended to delete the database. 
{: note}

See the following example that uses HTTP to delete an {{site.data.keyword.cloudant_short_notm}} database:

```http
DELETE /$DATABASE HTTP/1.1
Host: $ACCOUNT.cloudant.com
```
{: codeblock}

See the following example to delete an {{site.data.keyword.cloudant_short_notm}} database:

```sh
curl -H "Authorization: Bearer $API_BEARER_TOKEN" -X DELETE "$SERVICE_URL/$DB_NAME"
```
{: codeblock}
{: curl}

```java
import com.ibm.cloud.cloudant.v1.Cloudant;
import com.ibm.cloud.cloudant.v1.model.DeleteDatabaseOptions;
import com.ibm.cloud.cloudant.v1.model.Ok;

Cloudant service = Cloudant.newInstance();

DeleteDatabaseOptions databaseOptions =
    new DeleteDatabaseOptions.Builder()
        .db("<db-name>")
        .build();

Ok response =
    service.deleteDatabase(databaseOptions).execute()
        .getResult();

System.out.println(response);
```
{: codeblock}
{: java}

```javascript
import { CloudantV1 } from '@ibm-cloud/cloudant';

const service = CloudantV1.newInstance({});

service.deleteDatabase({db: '<db-name>'}).then(response => {
  console.log(response.result);
});
```
{: codeblock}
{: javascript}

```python
from ibmcloudant.cloudant_v1 import CloudantV1

service = CloudantV1.new_instance()

response = service.delete_database(db='<db-name>').get_result()

print(response)
```
{: codeblock}
{: python}

```go
deleteDatabaseOptions := service.NewDeleteDatabaseOptions(
  "<db-name>",
)

ok, response, err := service.DeleteDatabase(deleteDatabaseOptions)
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

If deletion succeeds, you get a 200 or 202 response.
An error response uses the HTTP status code to indicate what went wrong.

 Code | Description 
------|-------------
 200  | Database deleted successfully. 
 202  | Database was successfully deleted on some nodes, but the number of nodes is less than the write quorum.
 404  | Database does not exist on all of the nodes. 
{: caption="Table 16. HTTP status codes" caption-side="top"}

See the following example response that is received after a database is deleted successfully:

```json
{
	"ok": true
}
```
{: codeblock}

