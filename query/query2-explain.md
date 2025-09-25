---

copyright:
  years: 2015, 2025
lastupdated: "2025-09-25"

keywords: query, json index type, text index type, query performance, query plan

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# Retrieving query plans
{: #explain-plans}

Understanding the index that {{site.data.keyword.cloudant_short_notm}} Query uses when executing your queries is essential to achieving good performance. Use the `_explain` endpoint to retrieve query plans.
{: shortdesc}

## How indexes are selected
{: #how-indexes-are-selected}

{{site.data.keyword.cloudant_short_notm}} Query chooses which index to use for responding to a query,
unless you specify an index at query time.

When you don't specify an index to use,
{{site.data.keyword.cloudant_short_notm}} Query uses the following logic:

-	The query planner looks at the selector section,
	and finds the index with the closest match to operators and fields that are used in the query.
	If two or more JSON type indexes match,
	the index with the smallest number of fields in the index is preferred.
   If two or more candidate indexes still exist, the index with the first alphabetical name is chosen.
-	If a `json` type index *and* a `text` type index might both satisfy a selector, the `json` index is chosen by default.
- The `text` type index is chosen when the following conditions are met:
    - A `json` type index *and* a `text` type index exist in the same field (for example `fieldone`).
    - The selector can be satisfied only by using a `text` type index.

For example,
assume that you have a `text` type index and a `json` type index for the field `foo`,
and you want to use a selector similar to the following sample:

```json
{
	"foo": {
		"$in": ["red","blue","green"]
	}
}
```
{: codeblock}

{{site.data.keyword.cloudant_short_notm}} Query uses the `text` type index because a `json` type index can't satisfy the selector.

However,
you might use a different selector with the same indexes:

```json
{
	"foo": {
		"$gt": 2
	}
}
```
{: codeblock}

In this example,
{{site.data.keyword.cloudant_short_notm}} Query uses the `json` type index because both types of indexes can satisfy the selector.

## Specifying an index to use
{: #specifying-an-index-to-use}

Use the `use_index` and `allow_fallback` query parameters to control index use for queries. See [Query parameters](/docs/Cloudant?topic=Cloudant-ibm-cloudant-query-parameters) for full details.

When using these parameters, `_explain` can show whether the queries are able to use the specified indexes, and so whether the query will execute as intended.

## Using the `_explain` endpoint
{: #using-the-explain-endpoint}

To identify which index is being used by a particular query,
send a `POST` to the `_explain` endpoint for the database,
with the query as data.
The details of the index in use are shown in the `index` object within the result.

See the following example that uses HTTP to show how to identify the index that was used to answer a query:

```http
POST /movies/_explain HTTP/1.1
Host: $SERVICE_URL
Content-Type: application/json
{
	"selector": {
		"$text": "Pacino",
		"year": 2010
	}
}
```
{: codeblock}

See the following example that uses the command line to show how to identify the index that was used to answer a query:

```sh
curl "$SERVICE_URL/movies/_explain" \
	-X POST \
	-H "Content-Type: application/json" \
	-d '{
		"selector": {
			"$text": "Pacino",
			"year": 2010
		}
	}'
```
{: codeblock}
{: curl}

```java
import com.ibm.cloud.cloudant.v1.Cloudant;
import com.ibm.cloud.cloudant.v1.model.ExplainResult;
import com.ibm.cloud.cloudant.v1.model.PostExplainOptions;

import java.util.HashMap;
import java.util.Map;

Cloudant service = Cloudant.newInstance();

Map<String, Object> selector = new HashMap<>();
selector.put("$text", "Pacino");
selector.put("year", 2010);

PostExplainOptions explainOptions =
    new PostExplainOptions.Builder()
        .db("movies")
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

let selector: CloudantV1.Selector = {
    '$text': 'Pacino',
    'year': 2010
};

service.postExplain({
  db: 'movies',
  selector: selector
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
  db='movies',
  selector={'$text': 'Pacino', 'year': 2010}
).get_result()

print(response)
```
{: codeblock}
{: python}

```go
postExplainOptions := service.NewPostExplainOptions(
    "movies",
    map[string]interface{}{
        "$text": "Pacino",
        "year":  2010,
    },
)

explainResult, _, err := service.PostExplain(postExplainOptions)
if err != nil {
  panic(err)
}

b, _ := json.MarshalIndent(explainResult, "", "  ")
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

This example `_explain` response shows which index was used to answer a query:

```json
{
	"dbname": "$ACCOUNT/movies",
	"index": {
		"ddoc": "_design/32372935e14bed00cc6db4fc9efca0f1537d34a8",
		"name": "32372935e14bed00cc6db4fc9efca0f1537d34a8",
		"type": "text",
		"def": {
			"default_analyzer": "keyword",
			"default_field": {},
			"selector": {},
			"fields": []
		}
	},
	"selector": {
		"$and": [
			{
				"$default": {
					"$text": "Pacino"
				}
			},
			{
				"year": {
					"$eq": 2010
				}
			}
		]
	},
	"opts": {
		"use_index": [],
		"bookmark": [],
		"limit": 10000000000,
		"skip": 0,
		"sort": {},
		"fields": "all_fields",
		"r": [
			49
		],
		"conflicts": false
	},
	"limit": 200,
	"skip": 0,
	"fields": "all_fields",
	"query": "(($default:Pacino) AND (year_3anumber:2010))",
	"sort": "relevance"
}
```
{: codeblock}
