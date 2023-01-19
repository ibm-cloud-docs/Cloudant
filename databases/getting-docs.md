---

copyright:
  years: 2015, 2022
lastupdated: "2022-08-04"

keywords: create database, database topology, multiple queries, work with databases, partition database, delete database, back up data, create database applications

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# Getting documents
{: #get-documents}

To list all the documents in a database,
send a `GET` request to `https://$ACCOUNT.cloudant.com/$DATABASE/_all_docs`.

The `_all_docs` endpoint accepts the following query string and JSON body arguments:

| Argument | Description  | Optional | Type | Default |
|---------|--------------|----------|------|---------|
|`bookmark` ![TXE tag](../images/txe_icon.svg) | A bookmark to navigate to a specific page. | Yes | String | |
| `conflicts`         | Can be set only if `include_docs` is `true`. Adds information about conflicts to each document. | Yes      | Boolean         | False |
| `deleted_conflicts` | Returns information about deleted conflicted revisions.                                         | Yes      | Boolean         | False |
| `descending`        | Return the documents in descending key order.                                                   | Yes      | Boolean         | False |
| `endkey`            | Stop returning records when the specified key is reached.                                       | Yes      | String          |
| `endkey_docid` | Stop returning records when the specified document ID is reached. If `endkey` isn't set, this argument is ignored. | Yes | String | |
| `include_docs`      | Include the full content of the documents in the return.                                        | Yes      | Boolean         | False |
| `inclusive_end`     | Include rows whose key equals the "`endkey`" value.                                             | Yes      | Boolean         | True |
| `key`               | Return only documents with IDs that match the specified key.                                    | Yes      | String          | |
| `keys`              | Return only documents with IDs that match one of the specified keys.                            | Yes      | List of strings | |
| `limit` | Limit the number of returned documents to the specified number. For Transaction Engine, the `limit` parameter restricts the total number of returned documents.    | Yes      | Numeric         | |
| `meta`              | Short-hand combination of the following three arguments: `conflicts`, `deleted_conflicts`, and `revs_info`. Using `meta=true` is the same as using `conflicts=true&deleted_conflicts=true&revs_info=true`. | Yes | Boolean | False |
| `page_size` ![TXE tag](../images/txe_icon.svg) | Specify the number of returned documents in the result.   |     Yes      | Numeric | |
| `r`                 | Specify the [read quorum](/docs/Cloudant?topic=Cloudant-documents#quorum-writing-and-reading-data) value.               | Yes      | Numeric         | 2 |
| `revs_info`         | Includes detailed information for all known document revisions.                                 | Yes      | Boolean         | False |
| `skip`              | Skip this number of records before returning the results.                                       | Yes      | Numeric         | 0 |
| `startkey`          | Return records, starting with the specified key.                                                | Yes      | String          | |
| `startkey_docid` | Return records, starting with the specified document ID. If `startkey` isn't set, this argument is ignored.  | Yes | String | |
{: caption="Table 1. Query string and JSON body arguments" caption-side="top"}

## Notes
{: #get-documents-notes}

1.   Using `include_docs=true` might have [performance implications](/docs/Cloudant?topic=Cloudant-using-views#multi-document-fetching).

2.   When you use the `keys` argument, it might be easier to send a `POST` request rather than a `GET` request if you require multiple strings to list the keys you want.

3.   When you use the `keys` argument and the revision is deleted, the `value` attribute that is returned is a JSON object with the current `_rev` of the document and a `_deleted` attribute. The `doc` attribute is only populated if you specified `include_docs=true` in the request and is `null` if the document is deleted.

See the following example that uses HTTP to list all documents in a database:

```http
GET /_all_docs HTTP/1.1
```
{: codeblock}

See the following example to list all documents in a database:

```sh
curl -H "Authorization: Bearer $API_BEARER_TOKEN" -X POST "$SERVICE_URL/orders/_all_docs" -H "Content-Type: application/json" --data '{ "include_docs": true, "startkey": "abc", "limit": 10}'
```
{: codeblock}
{: curl}

```java
import com.ibm.cloud.cloudant.v1.Cloudant;
import com.ibm.cloud.cloudant.v1.model.AllDocsResult;
import com.ibm.cloud.cloudant.v1.model.PostAllDocsOptions;

Cloudant service = Cloudant.newInstance();

PostAllDocsOptions docsOptions =
    new PostAllDocsOptions.Builder()
        .db("orders")
        .includeDocs(true)
        .startKey("abc")
        .limit(10)
        .build();

AllDocsResult response =
    service.postAllDocs(docsOptions).execute().getResult();

System.out.println(response);
```
{: codeblock}
{: java}

```javascript
const { CloudantV1 } = require('@ibm-cloud/cloudant');

const service = CloudantV1.newInstance({});

service.postAllDocs({
  db: 'orders',
  includeDocs: true,
  startKey: 'abc',
  limit: 10
}).then(response => {
  console.log(response.result);
});
```
{: codeblock}
{: javascript}

```python
from ibmcloudant.cloudant_v1 import CloudantV1

service = CloudantV1.new_instance()

response = service.post_all_docs(
  db='orders',
  include_docs=True,
  start_key='abc',
  limit=10
).get_result()

print(response)
```
{: codeblock}
{: python}

```go
postAllDocsOptions := service.NewPostAllDocsOptions(
  "orders",
)
postAllDocsOptions.SetIncludeDocs(true)
postAllDocsOptions.SetStartKey("abc")
postAllDocsOptions.SetLimit(10)

allDocsResult, response, err := service.PostAllDocs(postAllDocsOptions)
if err != nil {
  panic(err)
}

b, _ := json.MarshalIndent(allDocsResult, "", "  ")
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

See the following example that uses HTTP to list all documents in a database that match at least one of the specified keys:

```http
GET /_all_docs?keys=["somekey","someotherkey"] HTTP/1.1
```
{: codeblock}

See the following example to list all documents in a database that match at least one of the specified keys:

```sh
curl -H "Authorization: Bearer $API_BEARER_TOKEN" -X POST "$SERVICE_URL/orders/_all_docs" -H "Content-Type: application/json" --data '{
  "include_docs": true,
  "keys": ["somekey", "someotherkey"],
  "limit": 10
}'
```
{: codeblock}
{: curl}

```java
import com.ibm.cloud.cloudant.v1.Cloudant;
import com.ibm.cloud.cloudant.v1.model.AllDocsResult;
import com.ibm.cloud.cloudant.v1.model.PostAllDocsOptions;

import java.util.Arrays;

Cloudant service = Cloudant.newInstance();

PostAllDocsOptions docsOptions =
    new PostAllDocsOptions.Builder()
        .db("orders")
        .includeDocs(true)
        .keys(Arrays.asList("somekey", "someotherkey"))
        .limit(10)
        .build();

AllDocsResult response =
    service.postAllDocs(docsOptions).execute().getResult();

System.out.println(response);
```
{: codeblock}
{: java}

```javascript
const { CloudantV1 } = require('@ibm-cloud/cloudant');

const service = CloudantV1.newInstance({});

service.postAllDocs({
  db: 'orders',
  includeDocs: true,
  keys: ['somekey', 'someotherkey'],
  limit: 10
}).then(response => {
  console.log(response.result);
});
```
{: codeblock}
{: javascript}

```python
from ibmcloudant.cloudant_v1 import CloudantV1

service = CloudantV1.new_instance()

response = service.post_all_docs(
  db='orders',
  include_docs=True,
  keys=['somekey', 'someotherkey'],
  limit=10
).get_result()

print(response)
```
{: codeblock}
{: python}

```go
postAllDocsOptions := service.NewPostAllDocsOptions(
		"orders",
	)
	postAllDocsOptions.SetIncludeDocs(true)
	postAllDocsOptions.SetKeys([]string{"somekey", "someotherkey"})
	postAllDocsOptions.SetLimit(10)
	
	allDocsResult, response, err := service.PostAllDocs(postAllDocsOptions)
	if err != nil {
		panic(err)
	}
	
	b, _ := json.MarshalIndent(allDocsResult, "", "  ")
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


The response is a JSON object that contains all documents in the database that match the parameters.
The following table describes the meaning of the individual fields:

| Field        | Description         | Type |
|-------------|---------------------|------|
| `offset`     | Offset where the document list started.                                             | Numeric, Null (The type can be `null` when `keys` are specified.) |
| `rows`       | Array of document objects.                                                          | Array |
| `total_rows` | Number of documents in the database or view that match the parameters of the query. | Numeric |
| `pdate_seq` | Current update sequence for the database.                                           | String |
{: caption="Table 2. JSON object fields" caption-side="top"}

See the following example response after a request for all documents in a database:

```json
{
	"total_rows": 3,
	"offset": 0,
	"rows": [
		{
			"id": "5a049246-179f-42ad-87ac-8f080426c17c",
			"key": "5a049246-179f-42ad-87ac-8f080426c17c",
			"value": {
				"rev": "2-9d5401898196997853b5ac4163857a29"
			}
		},
		{
			"id": "96f898f0-f6ff-4a9b-aac4-503992f31b01",
			"key": "96f898f0-f6ff-4a9b-aac4-503992f31b01",
			"value": {
				"rev": "2-ff7b85665c4c297838963c80ecf481a3"
			}
		},
		{
			"id": "d1f61e66-7708-4da6-aa05-7cbc33b44b7e",
			"key": "d1f61e66-7708-4da6-aa05-7cbc33b44b7e",
			"value": {
				"rev": "2-cbdef49ef3ddc127eff86350844a6108"
			}
		}
	]
}
```
{: codeblock}
