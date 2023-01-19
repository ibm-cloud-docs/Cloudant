---

copyright:
  years: 2015, 2022
lastupdated: "2022-12-23"

keywords: create index, query, json index type, text index type, query parameters, selector expressions, sort, filter, pagination, selector syntax

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# Creating selector expressions
{: #creating-selector-expressions}

In general,
whenever you have an operator that takes an argument,
that argument can itself be another operator with arguments of its own.
This expansion enables more complex selector expressions.
{: shortdesc}

Combination or array logical operators, such as `$regex`, can
result in a full database scan when you use indexes of type JSON,
resulting in poor performance. Only equality operators, such as `$eq`,
`$gt`, `$gte`, `$lt`, and `$lte` (but not `$ne`), enable index lookups. To ensure that indexes are used effectively, analyze the
[explain plan](#explain-plans) for each query.  

Most selector expressions work exactly as you would expect for the operator.
The matching algorithms that are used by the `$regex` operator are currently *based* on
the [Perl Compatible Regular Expression (PCRE) library](https://en.wikipedia.org/wiki/Perl_Compatible_Regular_Expressions){: external}.
However,
not all of the PCRE library is implemented.
Additionally,
some parts of the `$regex` operator go beyond what PCRE offers.
For more information about what is implemented,
see the [Erlang Regular Expression](http://erlang.org/doc/man/re.html){: external} information.

## Sort syntax
{: #sort-syntax}

The `sort` field contains a list of field name and direction pairs,
expressed as a basic array.
The first field name and direction pair are the topmost-level of sort.
The second pair,
if provided,
is the next level of sort.

The sort field can be any field.
Use dotted notation if needed for subfields.

The direction value is `asc` for ascending, and `desc` for descending.

If you exclude the direction value, the default `asc` is used.
{: tip}

See the following example of simple sort syntax:

```json
[
	{
		"fieldName1": "desc"
	},
	{
		"fieldName2": "desc"
	}
]
```
{: codeblock}

See the following example of simple sort, assuming default direction of "ascending" for both fields:

```json
[
	"fieldNameA", "fieldNameB"
]
```
{: codeblock}

A typical requirement is to search for some content by using a selector,
then to sort the results according to the specified field,
in the direction preferred.

To use sorting, ensure that the following are true:

-	At least one of the sort fields is included in the selector.
-	An index is already defined,
	with all the sort fields in the same order.
-	Each object in the sort array has a single key.

If an object in the sort array doesn't have a single key, the resulting sort order is implementation-specific and might change.

Currently, {{site.data.keyword.cloudant_short_notm}} Query doesn't support multiple fields with different sort orders,
so the direction must either be all ascending or all descending.
{: tip}

If the direction is ascending,
you can use a string instead of an object to specify the sort fields.

For field names in text search sorts,
it's sometimes necessary for a field type to be specified,
for example:

```json
{
	"<fieldname>:string": "asc"
}
```
{: codeblock}

If possible,
an attempt is made to find the field type based on the selector.
In ambiguous cases,
the field type must be provided explicitly.

| Which index is used by query?               | Field type requirement |
|------------------------------------------|-----------------------|
| JSON index                                | It's not necessary to specify the type of sort fields in the query. |
| Text index of all fields in all documents | Specify the sort field in the query if the database contains documents where the sort field has one type. Also, specify the sort field in the query if it contains documents where the sort field has a different type. |
| Any other text index                      | Specify the type of all sort fields in the query. |
{: caption="Table 1. When to specify the field type" caption-side="top"}

A text index of all fields
in all documents is created when you use the syntax:
[`"index": {}`](/docs/Cloudant?topic=Cloudant-query#the-index-field).
{: tip}

The sorting order is undefined when fields contain different data types. This characteristic is an important difference between text and view indexes. Sorting behavior for fields with different data types might change in future versions.

See the following example of a simple query that uses sorting:

```json
{
	"selector": {
		"Actor_name": "Robert De Niro"
	},
	"sort": [
		{
			"Actor_name": "asc"
		},
		{
			"Movie_runtime": "asc"
		}
	]
}
```
{: codeblock}

## Filtering fields
{: #filtering-fields}

It's possible to specify exactly which fields are returned for a document when you select from a database.
The two advantages are shown in the following list:

- Your results are limited to only those parts of the document that are needed for your application.
- A reduction in the size of the response.

The fields to be returned are specified as an array.

Only the specified filter fields are included in the response. `_id` or other metadata fields aren't automatically included.
{: tip}

See the following example of selective retrieval of fields from matching documents:

```json
{
	"selector": {
		"Actor_name": "Robert De Niro"
	},
	"fields": [
		"Actor_name",
		"Movie_year",
		"_id",
		"_rev"
	]
}
```
{: codeblock}

## Pagination
{: #pagination_query}

{{site.data.keyword.cloudant_short_notm}} Query supports pagination by the bookmark field. Every `_find` response contains a bookmark - a token
that {{site.data.keyword.cloudant_short_notm}} uses to determine where to resume from when later queries are made. To get the next
set of query results, add the bookmark that was received in the previous response to your next request.
Remember to keep the selector the same, otherwise you receive unexpected results. To paginate backwards,
you can use a previous bookmark to return the previous set of results.

The presence of a bookmark doesn’t guarantee more results. You can test whether
you are at the end of the result set by comparing the number of results that are returned with the page size
requested. If the results returned are less than limit, no more results were returned in the result set.
{: tip}



## Explain plans
{: #explain-plans}

{{site.data.keyword.cloudant_short_notm}} Query chooses which index to use for responding to a query,
unless you specify an index at query time.

When you specify an index to use,
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

See the following example response that shows which index was used to answer a query:

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

To instruct a query to use a specific index,
add the `use_index` parameter to the query.

The value of the `use_index` parameter takes one of the following formats:

-	`"use_index": "$DDOC"`
-	`"use_index": ["$DDOC","$INDEX_NAME"]`

See the following example query with instructions to use a specific index:

```json
{
	"selector": {
		"$text": "Pacino",
		"year": 2010
	},
	"use_index": "_design/32372935e14bed00cc6db4fc9efca0f1537d34a8"
}
```
{: codeblock}
