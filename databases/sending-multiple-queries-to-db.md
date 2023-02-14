---

copyright:
  years: 2015, 2023
lastupdated: "2023-02-10"

keywords: create database, database topology, multiple queries, work with databases, partition database, delete database, back up data, create database applications

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# Sending multiple queries to a database
{: #send-multiple-queries-to-a-database}

Now, the following instructions describe how to send multiple queries to a database by using `_all_docs` and `_view` endpoints. 

## Sending multiple queries to a database by using `_all_docs`
{: #send-multiple-queries-to-a-database-by-using-all_docs}

To send multiple queries to a specific database, send a `POST` request to 
`https://$ACCOUNT.cloudant.com/$DATABASE/_all_docs/queries`.

See the following example that uses HTTP to send multiple queries to a database:

```http
POST /$DATABASE/_all_docs/queries HTTP/1.1
```
{: codeblock}

See the following example to multi-query the list of all documents in a database:

```sh
curl -H "Authorization: Bearer $API_BEARER_TOKEN" -X POST "$SERVICE_URL/products/_all_docs/queries" -H "Content-Type: application/json" --data '{
  "queries": [
    {
      "keys": [
        "small-appliances:1000042",
        "small-appliances:1000043"
      ]
    },
    {
      "limit": 3,
      "skip": 2
    }
  ]
}'
```
{: codeblock}
{: curl}

```java
import com.ibm.cloud.cloudant.v1.Cloudant;
import com.ibm.cloud.cloudant.v1.model.AllDocsQuery;
import com.ibm.cloud.cloudant.v1.model.AllDocsQueriesResult;
import com.ibm.cloud.cloudant.v1.model.PostAllDocsQueriesOptions;

import java.util.Arrays;

Cloudant service = Cloudant.newInstance();

AllDocsQuery query1 = new AllDocsQuery.Builder()
    .keys(Arrays.asList("small-appliances:1000042",
        "small-appliances:1000043"))
    .build();

AllDocsQuery query2 = new AllDocsQuery.Builder()
    .limit(3)
    .skip(2)
    .build();

PostAllDocsQueriesOptions queriesOptions =
    new PostAllDocsQueriesOptions.Builder()
        .queries(Arrays.asList(query1, query2))
        .db("products")
        .build();

AllDocsQueriesResult response =
    service.postAllDocsQueries(queriesOptions).execute()
        .getResult();

System.out.println(response);
```
{: codeblock}
{: java}

```javascript
import { CloudantV1 } from '@ibm-cloud/cloudant';

const service = CloudantV1.newInstance({});

const allDocsQueries: CloudantV1.AllDocsQuery[] = [{
    keys: ['small-appliances:1000042', 'small-appliances:1000043'],
  },
  {
    limit: 3,
    skip: 2
}];

service.postAllDocsQueries({
  db: 'products',
  queries: allDocsQueries
}).then(response => {
  console.log(response.result);
});
```
{: codeblock}
{: javascript}

```python
from ibmcloudant.cloudant_v1 import AllDocsQuery, CloudantV1

service = CloudantV1.new_instance()

all_docs_query1 = AllDocsQuery(
  keys=['small-appliances:1000042', 'small-appliances:1000043']
)

all_docs_query2 = AllDocsQuery(
  limit=3,
  skip=2
)

response = service.post_all_docs_queries(
  db='products',
  queries=[all_docs_query1, all_docs_query2]
).get_result()

print(response)
```
{: codeblock}
{: python}

```go
allDocsQueries := []cloudantv1.AllDocsQuery{
  {
    Keys: []string{
      "small-appliances:1000042",
      "small-appliances:1000043",
    },
  },
  {
    Limit: core.Int64Ptr(3),
    Skip:  core.Int64Ptr(2),
  },
}
postAllDocsQueriesOptions := service.NewPostAllDocsQueriesOptions(
  "products",
  allDocsQueries,
)

allDocsQueriesResult, response, err := service.PostAllDocsQueries(postAllDocsQueriesOptions)
if err != nil {
  panic(err)
}

b, _ := json.MarshalIndent(allDocsQueriesResult, "", "  ")
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

If you `POST` to the `_all_docs/queries` endpoint, it runs multiple specified built-in view queries of all documents 
in this database. You can use this endpoint to request multiple queries in a single request, instead 
of multiple `POST /$DATABASE/_all_docs` requests. 

The request JSON object must have a `queries` field. It represents an array of query 
objects with fields for the parameters of each individual view query to be run. 
The field names and their meaning are the same as the query parameters of a regular 
`_all_docs` request. 

The results are returned by using the following response JSON object:

| Response JSON object    | Description | Type |
|-------------------------|-------------|------|
| `results` | An array of result objects - one for each query. Each result object contains the same fields as the response to a regular `_all_docs` request. | Array |
{: caption="Table 1. Response JSON object" caption-side="top"}

See the following example request with multiple queries:

```json
{POST /db/_all_docs/queries HTTP/1.1
Content-Type: application/json
Accept: application/json
Host: localhost:5984

{
    "queries": [
        {
            "keys": [
                "meatballs",
                "spaghetti"
            ]
        },
        {
            "limit": 3,
            "skip": 2
        }
    ]
}
```
{: codeblock}

See the following example response for multiple queries:

```json
HTTP/1.1 200 OK
Cache-Control: must-revalidate
Content-Type: application/json
Date: Wed, 20 Dec 2017 11:17:07 GMT
ETag: "1H8RGBCK3ABY6ACDM7ZSC30QK"
Server: CouchDB (Erlang/OTP)
Transfer-Encoding: chunked

{
    "results" : [
        {
            "rows": [
                {
                    "id": "SpaghettiWithMeatballs",
                    "key": "meatballs",
                    "value": 1
                },
                {
                    "id": "SpaghettiWithMeatballs",
                    "key": "spaghetti",
                    "value": 1
                },
                {
                    "id": "SpaghettiWithMeatballs",
                    "key": "tomato sauce",
                    "value": 1
                }
            ],
            "total_rows": 3
        },
        {
            "offset" : 2,
            "rows" : [
                {
                    "id" : "Adukiandorangecasserole-microwave",
                    "key" : "Aduki and orange casserole - microwave",
                    "value" : [
                        null,
                        "Aduki and orange casserole - microwave"
                    ]
                },
                {
                    "id" : "Aioli-garlicmayonnaise",
                    "key" : "Aioli - garlic mayonnaise",
                    "value" : [
                        null,
                        "Aioli - garlic mayonnaise"
                    ]
                },
                {
                    "id" : "Alabamapeanutchicken",
                    "key" : "Alabama peanut chicken",
                    "value" : [
                        null,
                        "Alabama peanut chicken"
                    ]
                }
            ],
            "total_rows" : 2667
        }
    ]
}
```
{: codeblock}

Multiple queries are also supported in `/$DATABASE/_design_docs/queries`, which is similar to `/$DATABASE/_all_docs/queries`. 
{: note}

## Sending multiple view queries to a database by using `_view`
{: #send-multiple-view-queries-to-a-database-by-using-view}

To send multiple view queries to a specific database, send a `POST` request to 
`https://$ACCOUNT.cloudant.com/$DATABASE/_design/$DDOC/_view/$VIEW/queries`.

See the following example that uses HTTP to send multiple queries to a database:

```http
POST /_view/$VIEW/queries HTTP/1.1
```
{: codeblock}

See the following example that runs multiple specified view queries against the view function from the specified design document:

```sh
curl -H "Authorization: Bearer $API_BEARER_TOKEN" -X POST "$SERVICE_URL/users/_design/allusers/_view/getVerifiedEmails/queries" -H "Content-Type: application/json" --data '{ "queries": [ { "include_docs": true, "limit": 5 },{ "descending": true, "skip": 1 } ]}'
```
{: codeblock}
{: curl}

```java
import com.ibm.cloud.cloudant.v1.Cloudant;
import com.ibm.cloud.cloudant.v1.model.PostViewQueriesOptions;
import com.ibm.cloud.cloudant.v1.model.ViewQueriesResult;
import com.ibm.cloud.cloudant.v1.model.ViewQuery;

import java.util.Arrays;

Cloudant service = Cloudant.newInstance();

ViewQuery query1 = new ViewQuery.Builder()
    .includeDocs(true)
    .limit(5)
    .build();

ViewQuery query2 = new ViewQuery.Builder()
    .descending(true)
    .skip(1)
    .build();

PostViewQueriesOptions queriesOptions =
    new PostViewQueriesOptions.Builder()
        .db("users")
        .ddoc("allusers")
        .queries(Arrays.asList(query1, query2))
        .view("getVerifiedEmails")
        .build();

ViewQueriesResult response =
    service.postViewQueries(queriesOptions).execute()
        .getResult();

System.out.println(response);
```
{: codeblock}
{: java}

```python
from ibmcloudant.cloudant_v1 import CloudantV1, ViewQuery

service = CloudantV1.new_instance()

query1 = ViewQuery(
  include_docs=True,
  limit=5
)
query2 = ViewQuery(
  descending=True,
  skip=1
)

response = service.post_view_queries(
  db='users',
  ddoc='allusers',
  queries=[query1, query2],
  view='getVerifiedEmails'
).get_result()

print(response)
```
{: codeblock}
{: python}

```javascript
import { CloudantV1 } from '@ibm-cloud/cloudant';

const service = CloudantV1.newInstance({});

const viewQueries: CloudantV1.ViewQuery[] = [
  {
    include_docs: true,
    limit: 5
  },
  {
    descending: true,
    skip: 1
  }
];
service.postViewQueries({
  db: 'users',
  ddoc: 'allusers',
  queries: viewQueries,
  view: 'getVerifiedEmails'
}).then(response => {
  console.log(response.result);
});
```
{: codeblock}
{: javascript}

```go
postViewQueriesOptions := service.NewPostViewQueriesOptions(
  "users",
  "allusers",
  "getVerifiedEmails",
  []cloudantv1.ViewQuery{
    {
      IncludeDocs: core.BoolPtr(true),
      Limit:       core.Int64Ptr(5),
    },
    {
      Descending: core.BoolPtr(true),
      Skip:       core.Int64Ptr(1),
    },
  },
)

viewQueriesResult, response, err := service.PostViewQueries(postViewQueriesOptions)
if err != nil {
  panic(err)
}

b, _ := json.MarshalIndent(viewQueriesResult, "", "  ")
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

The previous example requires the getVerifiedEmails view to exist. To create the design document with this view, see [Create or modify a design document](https://cloud.ibm.com/apidocs/cloudant#putdesigndocument){: external}.The previous Go example also requires an import for `github.com/IBM/go-sdk-core/v5/core`.
{: go}

Multiple queries are supported by the `_view` endpoint, 
`/$DATABASE/_design/$DDOC/_view/$VIEW/queries`.

The request JSON object must have a `queries` field. It represents an array of query
objects with fields for the parameters of each individual view query to be executed.
The field names and their meaning are the same as the query parameters of a regular
`_view` request.
