---

copyright:
  years: 2015, 2022
lastupdated: "2022-12-16"

keywords: examples, demo database

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# Movies demo database example
{: #example-movies-demo-database}

The following example uses HTTP to create a `text` index for your sample database.
{: shortdesc}

```http
POST /my-movies/_index HTTP/1.1
Host: $SERVICE_URL
Content-Type: application/json
{
	"index": {},
	"type": "text"
}
```
{: codeblock}

See the following example that uses the command line to create a `text` index for your sample database:

```sh
curl "$SERVICE_URL/my-movies/_index" \
	-X POST \
	-H "Content-Type: application/json" \
	-d '{"index": {}, "type": "text"}'
```
{: codeblock}
{: curl}

```java
import com.ibm.cloud.cloudant.v1.Cloudant;
import com.ibm.cloud.cloudant.v1.model.IndexDefinition;
import com.ibm.cloud.cloudant.v1.model.IndexResult;
import com.ibm.cloud.cloudant.v1.model.PostIndexOptions;

Cloudant service = Cloudant.newInstance();

IndexDefinition indexDefinition = new IndexDefinition.Builder()
   .build();

PostIndexOptions indexOptions = new PostIndexOptions.Builder()
    .db("my-movies")
    .index(indexDefinition)
    .type("text")
    .build();

IndexResult response =
    service.postIndex(indexOptions).execute()
        .getResult();

System.out.println(response);
```
{: codeblock}
{: java}

```javascript
import { CloudantV1 } from '@ibm-cloud/cloudant';

const service = CloudantV1.newInstance({});

let index: CloudantV1.IndexDefinition = {}

service.postIndex({
  db: 'my-movies',
  index: index,
  type: 'text'
}).then(response => {
  console.log(response.result);
});
```
{: codeblock}
{: node}

```python
from ibmcloudant.cloudant_v1 import CloudantV1, IndexDefinition

service = CloudantV1.new_instance()

index = IndexDefinition()

response = service.post_index(
  db='my-movies',
  index=index,
  type='text'
).get_result()

print(response)
```
{: codeblock}
{: python}

```go
postIndexOptions := service.NewPostIndexOptions(
    "my-movies",
    &cloudantv1.IndexDefinition{},
)
postIndexOptions.SetType("text")

indexResult, _, err := service.PostIndex(postIndexOptions)
if err != nil {
    panic(err)
}

b, _ := json.MarshalIndent(indexResult, "", "  ")
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

See the following example response after a `text` index is created successfully:

```json
{
    "id": "_design/bf936ad6eb87f03c2b42ae153377462844575e40",
    "name": "bf936ad6eb87f03c2b42ae153377462844575e40",
	"result": "created"
}
```
{: codeblock}

The most obvious difference in the results you get when you use full text indexes is
the inclusion of a large `bookmark` field.
The reason is that `text` indexes are different from view-based indexes.
For more flexibility, when you work with the results that are obtained from a full text query,
you can supply the `bookmark` value as part of the request body.
Use the `bookmark` to specify which page of results you require.

The actual `bookmark` value is long,
so the examples here have values that are truncated for reasons of clarity.
{: tip}

See the following example that uses HTTP to search for a specific document within the database:

```http
POST /my-movies/_find HTTP/1.1
Host: $SERVICE_URL
Content-Type: application/json
{
  "selector": {
    "Person_name":"Zoe Saldana"
  }
}
```
{: codeblock}

See the following example that uses the command line to search for a specific document within the database:

```sh
curl -X POST -H "Content-Type: application/json" \
	"$SERVICE_URL/my-movies/_find" \
	-d '{"selector": {"Person_name":"Zoe Saldana"}}'
```
{: codeblock}
{: curl}

```java
import com.ibm.cloud.cloudant.v1.Cloudant;
import com.ibm.cloud.cloudant.v1.model.FindResult;
import com.ibm.cloud.cloudant.v1.model.PostFindOptions;

import java.util.Collections;
import java.util.Map;

Cloudant service = Cloudant.newInstance();

Map<String, Object> selector = Collections.singletonMap(
    "Person_name", "Zoe Saldana");

PostFindOptions findOptions = new PostFindOptions.Builder()
    .db("my-movies")
    .selector(selector)
    .build();

FindResult response =
    service.postFind(findOptions).execute()
        .getResult();

System.out.println(response);
```
{: codeblock}
{: java}

```javascript
import { CloudantV1 } from '@ibm-cloud/cloudant';

const service = CloudantV1.newInstance({});

let selector: CloudantV1.JsonObject = {
  Person_name: 'Zoe Saldana'
};

service.postFind({
  db: 'my-movies',
  selector: selector,
}).then(response => {
  console.log(response.result);
});
```
{: codeblock}
{: node}

```python
from ibmcloudant.cloudant_v1 import CloudantV1

service = CloudantV1.new_instance()

response = service.post_find(
  db='my-movies',
  selector={'Person_name': 'Zoe Saldana'}
).get_result()

print(response)
```
{: codeblock}
{: python}

```go
postFindOptions := service.NewPostFindOptions(
    "my-movies",
    map[string]interface{}{
        "Person_name": "Zoe Saldana",
    },
)

findResult, _, err := service.PostFind(postFindOptions)
if err != nil {
    panic(err)
}

b, _ := json.MarshalIndent(findResult, "", "  ")
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

See the following example result from the search:

```json
{
	"docs": [
		{
			"_id": "d9e6a7ae2363d6cfe81af75a3941110b",
			"_rev": "1-556aec0e89fa13769fbf59d651411528",
			"Movie_runtime": 162,
			"Movie_rating": "PG-13",
			"Person_name": "Zoe Saldana",
			"Movie_genre": "AVYS",
			"Movie_name": "Avatar",
			"Movie_earnings_rank": "1",
			"Person_pob": "New Jersey, USA",
			"Movie_year": 2009,
			"Person_dob": "1978-06-19"
		}
	],
	"bookmark": "g2wA ... Omo"
}
```
{: codeblock}

See the following example that uses HTTP for a slightly more complex search:

```http
POST /my-movies/_find HTTP/1.1
Host: $SERVICE_URL
Content-Type: application/json
{
	"selector": {
		"Person_name":"Robert De Niro",
		"Movie_year": 1978
	}
}
```
{: codeblock}

See the following example that uses the command line for a slightly more complex search:

```sh
curl -X POST -H "Content-Type: application/json" \
	"$SERVICE_URL/my-movies/_find" \
	-d '{"selector": {"Person_name":"Robert De Niro", "Movie_year": 1978}}'
```
{: codeblock}
{: curl}

```java
import com.ibm.cloud.cloudant.v1.Cloudant;
import com.ibm.cloud.cloudant.v1.model.FindResult;
import com.ibm.cloud.cloudant.v1.model.PostFindOptions;

import java.util.HashMap;
import java.util.Map;

Cloudant service = Cloudant.newInstance();

Map<String, Object> selector = new HashMap<>();
selector.put("Person_name", "Robert De Niro");
selector.put("Movie_year", 1978);

PostFindOptions findOptions = new PostFindOptions.Builder()
    .db("my-movies")
    .selector(selector)
    .build();

FindResult response =
    service.postFind(findOptions).execute()
        .getResult();

System.out.println(response);
```
{: codeblock}
{: java}

```javascript
import { CloudantV1 } from '@ibm-cloud/cloudant';

const service = CloudantV1.newInstance({});

let selector: CloudantV1.JsonObject = {
  Person_name: 'Robert De Niro',
  Movie_year: 1978
};

service.postFind({
  db: 'my-movies',
  selector: selector,
}).then(response => {
  console.log(response.result);
});
```
{: codeblock}
{: node}

```python
from ibmcloudant.cloudant_v1 import CloudantV1

service = CloudantV1.new_instance()

response = service.post_find(
  db='my-movies',
  selector={'Person_name': 'Robert De Niro', 'Movie_year': 1978}
).get_result()

print(response)
```
{: codeblock}
{: python}

```go
postFindOptions := service.NewPostFindOptions(
    "my-movies",
    map[string]interface{}{
        "Person_name": "Robert De Niro",
        "Movie_year": 1978,
    },
)

findResult, _, err := service.PostFind(postFindOptions)
if err != nil {
    panic(err)
}

b, _ := json.MarshalIndent(findResult, "", "  ")
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

See the following example result from the search:

```json
{
	"docs": [
		{
			"_id": "d9e6a7ae2363d6cfe81af75a392eb9f2",
			"_rev": "1-9faa75d7ea524448b1456a6c69a4391a",
			"Movie_runtime": 183,
			"Movie_rating": "R",
			"Person_name": "Robert De Niro",
			"Movie_genre": "DW",
			"Movie_name": "Deer Hunter, The",
			"Person_pob": "New York, New York, USA",
			"Movie_year": 1978,
			"Person_dob": "1943-08-17"
		}
	],
	"bookmark": "g2w ... c2o"
}
```
{: codeblock}

See the following example that uses HTTP to search within a range:

```http
POST /my-movies/_find HTTP/1.1
Host: $SERVICE_URL
Content-Type: application/json
{
  "selector": {
    "Person_name":"Robert De Niro",
    "Movie_year": {
      "$in": [1974, 2009]
    }
  }
}
```
{: codeblock}

See the following example that uses the command line to search within a range:

```sh
curl -X POST -H "Content-Type: application/json" \
	"$SERVICE_URL/my-movies/_find" \
	-d '{"selector": {"Person_name":"Robert De Niro", "Movie_year": { "$in": [1974, 2009]}}}'
```
{: codeblock}
{: curl}

```java
import com.ibm.cloud.cloudant.v1.Cloudant;
import com.ibm.cloud.cloudant.v1.model.ExplainResult;
import com.ibm.cloud.cloudant.v1.model.PostExplainOptions;

import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

Cloudant service = Cloudant.newInstance();

Map<String, Object> selector = new HashMap<>();
selector.put("Person_name", "Robert De Niro");
selector.put("Movie_year",
    Collections.singletonMap("$in", Arrays.asList(1978, 2009)));

PostExplainOptions explainOptions =
    new PostExplainOptions.Builder()
        .db("my-movies")
        .selector(selector)
        .build();

ExplainResult response =
    service.postExplain(explainOptions).execute()
        .getResult();

System.out.println(response);
```
{: codeblock}
{: java}

```javascript
import { CloudantV1 } from '@ibm-cloud/cloudant';

const service = CloudantV1.newInstance({});

let selector: CloudantV1.JsonObject = {
  Person_name: 'Robert De Niro',
  Movie_year: {'$in': [1978, 2009]}
};

service.postFind({
  db: 'my-movies',
  selector: selector,
}).then(response => {
  console.log(response.result);
});
```
{: codeblock}
{: node}

```python
from ibmcloudant.cloudant_v1 import CloudantV1

service = CloudantV1.new_instance()

response = service.post_find(
  db='my-movies',
  selector={'Person_name': 'Robert De Niro',
    'Movie_year': {'$in': (1978, 2009)}}
).get_result()

print(response)
```
{: codeblock}
{: python}

```go
postFindOptions := service.NewPostFindOptions(
    "my-movies",
    map[string]interface{}{
        "Person_name": "Robert De Niro",
        "Movie_year": map[string][]interface{}{
            "$in": []interface{}{1978, 2009},
        },
    },
)

findResult, _, err := service.PostFind(postFindOptions)
if err != nil {
    panic(err)
}

b, _ := json.MarshalIndent(findResult, "", "  ")
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

See the following example result from the search:

```json
{
	"docs": [
		{
			"_id": "d9e6a7ae2363d6cfe81af75a392eb9f2",
			"_rev": "1-9faa75d7ea524448b1456a6c69a4391a",
			"Movie_runtime": 183,
			"Movie_rating": "R",
			"Person_name": "Robert De Niro",
			"Movie_genre": "DW",
			"Movie_name": "Deer Hunter, The",
			"Person_pob": "New York, New York, USA",
			"Movie_year": 1978,
			"Person_dob": "1943-08-17"
		}
	],
	"bookmark": "g2w ... c2o"
}
```
{: codeblock}
