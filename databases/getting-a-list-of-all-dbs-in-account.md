---

copyright:
  years: 2015, 2022
lastupdated: "2022-06-03"

keywords: create database, database topology, multiple queries, work with databases, partition database, delete database, back up data, create database applications

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# Getting a list of all databases in the account
{: #get-a-list-of-all-databases-in-the-account}

To list all the databases in an account,
send a `GET` request to `https://$ACCOUNT.cloudant.com/_all_dbs`.

See the following example of using HTTP to list all databases:

```http
GET /_all_dbs HTTP/1.1
```
{: codeblock}

See the following example to list all databases:

```sh
curl -H "Authorization: Bearer $API_BEARER_TOKEN" -X GET "$SERVICE_URL/_all_dbs"
```
{: codeblock}
{: curl}

```java
import com.ibm.cloud.cloudant.v1.Cloudant;
import com.ibm.cloud.cloudant.v1.model.GetAllDbsOptions;

import java.util.List;

Cloudant service = Cloudant.newInstance();

List<String> response =
    service.getAllDbs().execute().getResult();

System.out.println(response);
```
{: codeblock}
{: java}

```javascript
const { CloudantV1 } = require('@ibm-cloud/cloudant');

const service = CloudantV1.newInstance({});

service.getAllDbs().then(response => {
  console.log(response.result);
});
```
{: codeblock}
{: javascript}

```python
from ibmcloudant.cloudant_v1 import CloudantV1

service = CloudantV1.new_instance()

response = service.get_all_dbs().get_result()

print(response)
```
{: codeblock}
{: python}

```go
getAllDbsOptions := service.NewGetAllDbsOptions()

result, response, err := service.GetAllDbs(getAllDbsOptions)
if err != nil {
  panic(err)
}

b, _ := json.MarshalIndent(result, "", "  ")
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

See the following example response that is a JSON array with all the database names:

```json
[
	"_users",
	"contacts",
	"docs",
	"invoices",
	"locations"
]
```
{: codeblock}
