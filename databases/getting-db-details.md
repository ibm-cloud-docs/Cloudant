---

copyright:
  years: 2015, 2022
lastupdated: "2022-08-04"

keywords: create database, database topology, multiple queries, work with databases, partition database, delete database, back up data, create database applications

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# Getting database details 
{: #getting-database-details}

Sending a `GET` request to `https://$ACCOUNT.cloudant.com/$DATABASE`
returns details about the database,
such as how many documents it contains.

See the following example of using HTTP to get database details:

```http
GET /$DATABASE HTTP/1.1
```
{: codeblock}

See the following example to get database details:

```sh
curl -H "Authorization: Bearer $API_BEARER_TOKEN" -X GET "$SERVICE_URL/products"
```
{: codeblock}
{: curl}

```java
import com.ibm.cloud.cloudant.v1.Cloudant;
import com.ibm.cloud.cloudant.v1.model.DatabaseInformation;
import com.ibm.cloud.cloudant.v1.model.GetDatabaseInformationOptions;

Cloudant service = Cloudant.newInstance();

GetDatabaseInformationOptions databaseInfoOptions =
    new GetDatabaseInformationOptions.Builder()
        .db("products")
        .build();

DatabaseInformation response =
    service.getDatabaseInformation(databaseInfoOptions).execute()
        .getResult();

System.out.println(response);
```
{: codeblock}
{: java}

```javascript
const { CloudantV1 } = require('@ibm-cloud/cloudant');

const service = CloudantV1.newInstance({});

service.getDatabaseInformation({db: 'products'}).then(response => {
  console.log(response.result);
});
```
{: codeblock}
{: javascript}

```python
from ibmcloudant.cloudant_v1 import CloudantV1

service = CloudantV1.new_instance()

response = service.get_database_information(db='products').get_result()

print(response)
```
{: codeblock}
{: python}

```go
getDatabaseInformationOptions := service.NewGetDatabaseInformationOptions(
  "products",
)

databaseInformation, response, err := service.GetDatabaseInformation(getDatabaseInformationOptions)
if err != nil {
  panic(err)
}

b, _ := json.MarshalIndent(databaseInformation, "", "  ")
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

The elements of the returned structure are shown in the following table:

| Field    | Description |
|---------|-------------| 
| `compact_running`     | Set to true if the database compaction routine is operating on this database. |
| `db_name`             | The name of the database. |
| `disk_format_version` | The version of the physical format that is used for the data that is stored on disk. |
| `disk_size`           | Size in bytes of the data as stored on the disk. Views indexes aren't included in the calculation. |
| `doc_count`           | A count of the documents in the specified database. |
| `doc_del_count`       | Number of deleted documents. |
| `instance_start_time` | Always 0. |
| `other`               | JSON object that contains a `data_size` field. |
| `purge_seq`           | The number of purge operations on the database. |
| `sizes`               | A JSON object, containing `file`, `external`, and `active` sizes. `active` is the size in bytes of data that is stored internally (excluding old revisions). `external` is the size in bytes of decompressed user data. This value is the billable data size. The `other/data_size` field is an alias for the `external` field. `file` is the size in bytes of data that is stored on the disk. Indexes aren't included in the calculation. The `disk_size` field is an alias for the `file` field. This size includes  data that is waiting for compaction. |
| `update_seq`          | An opaque string that describes the state of the database. Don't rely on this string for counting the number of updates. |
| `partitioned_indexes` | A JSON object that appears only if the database is partitioned. `count` is the number of partitioned indexes. `indexes` list the type of partitioned indexes, and `limit` shows the maximum number of allowed partitioned indexes. |
{: caption="Database details" caption-side="top"}

See the following example (abbreviated) response that contains database details:

```json
{
	"update_seq": "982...uUQ",
	"db_name": "db",
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
	"instance_start_time": "0",
	"partitioned_indexes": {
		"count": 7,
		"indexes": {
			"search": 1,
			"view": 6
		},
		"limit": 10
	}
}
```
{: codeblock}
