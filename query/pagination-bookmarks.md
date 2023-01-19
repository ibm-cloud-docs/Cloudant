---

copyright:
  years: 2019, 2023
lastupdated: "2023-01-16"

keywords: _all_docs endpoint, skip, limit, startkey, endkey, query, search, paging, mapreduce views

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# Pagination and bookmarks
{: #pagination-and-bookmarks}

Bookmarks help release the next page of results from a result set. While with pagination, you iterate through a range of documents in an efficient manner.
{: shortdesc} 

You can use the `skip`/`limit` pattern to [iterate through a result set](/docs/Cloudant?topic=Cloudant-using-views), but it gets progressively slower the larger the value of `skip`.

[{{site.data.keyword.cloudant_short_notm}} Query](/apidocs/cloudant#postfind){: external} and [{{site.data.keyword.cloudant_short_notm}} Search](/apidocs/cloudant#getsearchinfo){: external} both use bookmarks as the key to unlock the next page of results from a result set. This practice is described in full in a later section that is called [Bookmarks](#bookmarks). It's easier to manage since no key manipulation is required to formulate the request for the next result set. You pass the bookmark that was received in the first response to the second request.

Now, you can see a better way to page through a large document set. 

## Paging with `_all_docs` and views
{: #paging-with_all_docs_views}

If you use the `GET` or `POST` `$SERVICE_URL/$DATABASE/_all_docs` endpoint to fetch documents in bulk, then you might see the `limit` and `skip` parameters. By using these parameters, you can define how many documents you would like, and the offset into the range you want to start from. Using the `skip`/`limit` pattern to iterate through results works, but it gets progressively slower the larger the value of `skip`. 

## What is the `_all_docs` endpoint?
{: #what-is-the_all_docs_endpoint}

The `GET` and `POST` `$SERVICE_URL/$DATABASE/_all_docs` are used to fetch data from an {{site.data.keyword.cloudant_short_notm}} database's _primary index_, that is, the index that keeps each document's `_id` in order. The `_all_docs` endpoint takes a number of optional parameters that configure the range of data that is requested and whether to return each document's body or not. With no parameters provided, `_all_docs` streams all of a database's documents, returning only the document `_id` and its current `_rev` token.

```sh
curl -H "Authorization: Bearer $API_BEARER_TOKEN" -X GET "$SERVICE_URL/orders/_all_docs"
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
}).then(response => {
  console.log(response.result);
});
```
{: codeblock}
{: node}

```python
from ibmcloudant.cloudant_v1 import CloudantV1

service = CloudantV1.new_instance()

response = service.post_all_docs(
  db='orders',
).get_result()

print(response)
```
{: codeblock}
{: python}

```go
postAllDocsOptions := service.NewPostAllDocsOptions(
  "orders",
)

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


```sh
{
  "total_rows": 11,
  "offset": 0,
  "rows": [
    {
      "id": "4eee973603bf77f30b1f880ed83df76a",
      "key": "4eee973603bf77f30b1f880ed83df76a",
      "value": {
        "rev": "1-3b5e6b73e57745787ad5627fe8f268c1"
      }
    },
    {
      "id": "4eee973603bf77f30b1f880ed83f469a",
      "key": "4eee973603bf77f30b1f880ed83f469a",
      "value": {
        "rev": "1-967a00dff5e02add41819138abb3284d"
      }
    }
...
```
{: codeblock}


If you supply `include_docs=true`, then another `doc` attribute is added to each "row" in the result set that includes the document body.

## The `limit`, `startkey`, and `endkey` parameters
{: #the-limit-startkey-endkey-parameters}

To access data from `_all_docs` in reasonably sized pages, you must supply the `limit` parameter to tell {{site.data.keyword.cloudant_short_notm}} how many documents to return:

```http
# get me 5 documents
GET $SERVICE_URL/$DATABASE/_all_docs?limit=5 HTTP/1.1
```
{: codeblock}

You can also limit the range of document `_id`s that you want by supplying one or 
more values to `startkey` or `endkey`.

```sh
# get me 5 documents from _id order00057 onwards
curl -H "Authorization: Bearer $API_BEARER_TOKEN" "$SERVICE_URL/orders/_all_docs?limit=5&startkey=\"order00057\"" \
    
# get me 5 documents between _id order00057 --> order00077
curl -H "Authorization: Bearer $API_BEARER_TOKEN" "$SERVICE_URL/orders/_all_docs?limit=5&startkey=\"order00057\"&endkey=\"order00077\"" \
    
# get me 5 documents up to _id order00077
curl -H "Authorization: Bearer $API_BEARER_TOKEN" "$SERVICE_URL/orders/_all_docs?limit=5&endkey=\"order00077\""
```
{: codeblock}
{: curl}

```java
import com.ibm.cloud.cloudant.v1.Cloudant;
import com.ibm.cloud.cloudant.v1.model.AllDocsResult;
import com.ibm.cloud.cloudant.v1.model.PostAllDocsOptions;

Cloudant service = Cloudant.newInstance();

// get me 5 documents from _id order00057 onwards
PostAllDocsOptions docsOptions =
    new PostAllDocsOptions.Builder()
        .db("orders")
        .startKey("order00057")
        .limit(5)
        .build();
AllDocsResult response1 =
    service.postAllDocs(docsOptions).execute().getResult();
System.out.println(response1);

// get me 5 documents between _id order00057 --> order00077
PostAllDocsOptions docsOptions2 =
    new PostAllDocsOptions.Builder()
        .db("orders")
        .startKey("order00057")
        .endKey("order00077")
        .limit(5)
        .build();
AllDocsResult response2 =
    service.postAllDocs(docsOptions2).execute().getResult();
System.out.println(response2);

// get me 5 documents up to _id order00077
PostAllDocsOptions docsOptions3 =
    new PostAllDocsOptions.Builder()
        .db("orders")
        .endKey("order00077")
        .limit(5)
        .build();
AllDocsResult response3 =
        service.postAllDocs(docsOptions3).execute().getResult();
System.out.println(response3);
```
{: codeblock}
{: java}

```javascript
const { CloudantV1 } = require('@ibm-cloud/cloudant');

const service = CloudantV1.newInstance({});

// get me 5 documents from _id order00057 onwards
service.postAllDocs({
  db: 'orders',
  startKey: 'order00057',
  limit: 5
}).then(response1 => {
  console.log(response1.result);
});

// get me 5 documents from _id order00057 onwards
service.postAllDocs({
  db: 'orders',
  startKey: 'order00057',
  endKey: 'order00077',
  limit: 5
}).then(response2 => {
  console.log(response2.result);
});

// get me 5 documents up to _id order00077
service.postAllDocs({
  db: 'orders',
  endKey: 'order00077',
  limit: 5
}).then(response3 => {
  console.log(response3.result);
});
```
{: codeblock}
{: node}

```python
from ibmcloudant.cloudant_v1 import CloudantV1

service = CloudantV1.new_instance()

# get me 5 documents from _id order00057 onwards
response1 = service.post_all_docs(
  db='orders',
  start_key='order00057',
  limit=5
).get_result()
print(response1)

# get me 5 documents between _id order00057 --> order00077
response2 = service.post_all_docs(
  db='orders',
  start_key='order00057',
  end_key='order00077',
  limit=5
).get_result()
print(response2)

# get me 5 documents up to _id order00077
response3 = service.post_all_docs(
  db='orders',
  end_key='order00077',
  limit=5
).get_result()
print(response3)
```
{: codeblock}
{: python}

```go
//  get me 5 documents from _id order00057 onwards
postAllDocsOptions1 := cloudantv1.PostAllDocsOptions{
	Db: core.StringPtr("orders"),
	StartKey: core.StringPtr("order00057"),
	Limit: core.Int64Ptr(5),
}
allDocsResult1, response1, err := service.PostAllDocs(postAllDocsOptions1)
if err != nil {
    panic(err)
}
b, _ := json.MarshalIndent(allDocsResult1, "", "  ")
fmt.Println(string(b))

//  get me 5 documents between _id order00057 --> order00077
postAllDocsOptions2 := cloudantv1.PostAllDocsOptions{
    Db: core.StringPtr("orders"),
    StartKey: core.StringPtr("order00057"),
    EndKey: core.StringPtr("order00077"),
    Limit: core.Int64Ptr(5),
}
allDocsResult2, response2, err := service.PostAllDocs(postAllDocsOptions2)
if err != nil {
    panic(err)
}
b, _ := json.MarshalIndent(allDocsResult2, "", "  ")
fmt.Println(string(b))

// get me 5 documents up to _id order00077
postAllDocsOptions3 := cloudantv1.PostAllDocsOptions{
    Db: core.StringPtr("orders"),
    EndKey: core.StringPtr("order00077"),
    Limit: core.Int64Ptr(5),
}
allDocsResult3, response3, err := service.PostAllDocs(postAllDocsOptions3)
if err != nil {
    panic(err)
}
b, _ := json.MarshalIndent(allDocsResult3, "", "  ")
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
 "github.com/IBM/go-sdk-core/core"
)
```
{: codeblock}
{: go}

All Go examples require the `service` object to be initialized. For more information, see the API documentation's [Authentication section](https://cloud.ibm.com/apidocs/cloudant?code=go#authentication-with-external-configuration) for examples.
{: go}

This practice means you define the size of the data set and the range of the `_id` field to return, but that isn't quite the same as pagination.

The `startkey`/`endkey` values are in double quotation marks because they're expected to be JSON-encoded and `JSON.stringify('order00077') === "order00077"`.
{: note}
{: curl}

## Pagination options
{: #pagination-options}

For performance reasons, if you are displaying large amounts of data, you should consider using pagination. In these examples, documents are fetched in blocks of 5, but in a real application the page size may be different and will depend on document size, latency demands, memory consumption and other trade-offs.

You can use the options that are described in the following sections.

### Option 1 - Fetch one document too many
{: #option-1-fetch-one-doc-too-many}

Instead of fetching 5 documents (`limit=5`), fetch 5+1 (`limit=6`), but hide the 6th document from your users. The `_id` of the 6th document becomes the `startkey` of your request for the next page of results.

First request:
{: curl}

```sh
curl -H "Authorization: Bearer $API_BEARER_TOKEN" "$SERVICE_URL/orders/_all_docs?limit=6"
```
{: codeblock}
{: curl}

```java
import com.ibm.cloud.cloudant.v1.Cloudant;
import com.ibm.cloud.cloudant.v1.model.AllDocsResult;
import com.ibm.cloud.cloudant.v1.model.DocsResultRow;
import com.ibm.cloud.cloudant.v1.model.PostAllDocsOptions;

Cloudant service = Cloudant.newInstance();

int pageSize = 5;
PostAllDocsOptions.Builder docsOptionsBuilder =
        new PostAllDocsOptions.Builder()
                .db("orders")
                .limit(pageSize + 1); // Fetch pageSize + 1 documents

AllDocsResult response =
        service.postAllDocs(docsOptionsBuilder.build())
        .execute()
        .getResult();

while (response.getRows().size() > 1) {
    List<DocsResultRow> responseDocuments = response.getRows();
    // on the last page, show all documents:
    if (responseDocuments.size() <= pageSize) {
        System.out.println(responseDocuments);
    } else { // otherwise, hide the last document:
        System.out.println(responseDocuments.subList(0, pageSize));
    }
    // The startKey of the next request becomes the hidden document id:
    docsOptionsBuilder
        .startKey(responseDocuments
                    .get(responseDocuments.size() - 1)
                    .getId()
        );
    response =
        service.postAllDocs(docsOptionsBuilder.build())
        .execute()
        .getResult();
}
```
{: codeblock}
{: java}

```javascript
const { CloudantV1 } = require('@ibm-cloud/cloudant');

const service = CloudantV1.newInstance({});

async function paginate(pageSize) {
  let allDocsResult = (await service.postAllDocs({
    db: 'orders',
    limit: pageSize + 1
  })).result;
  while(allDocsResult.rows.length > 1) {
    let documents = allDocsResult.rows;
    // on the last page, show all documents:
    if(documents.length <= pageSize) {
      console.log(documents);
    } else { // otherwise, hide the last document:
      console.log(documents.slice(0, documents.length - 1))
    }
    allDocsResult = (await service.postAllDocs({
      db: 'orders',
      limit: pageSize + 1,
      startKey: documents[documents.length - 1].id
    })).result;
  }
}

paginate(5)
 ```
{: codeblock}
{: node}

```python
import json
from ibmcloudant.cloudant_v1 import CloudantV1

service = CloudantV1.new_instance()
page_size = 5

response = service.post_all_docs(
  db='orders',
  limit=page_size+1,  # Fetch page_size + 1 documents
).get_result()

while len(response["rows"]) > 1:
  documents = response['rows']
  # on the last page, show all documents:
  if len(documents) <= page_size:
    print(json.dumps(documents, indent=2))
  else:  # otherwise, hide the last document:
    print(json.dumps(documents[0:-1], indent=2))
  response = service.post_all_docs(
    db='orders',
    limit=page_size+1,  # Fetch page_size + 1 documents
    start_key=documents[-1]['id']
  ).get_result()
```
{: codeblock}
{: python}

```go
pageSize := core.Int64Ptr(5)
postAllDocsOptions := service.NewPostAllDocsOptions(
    "orders",
)
postAllDocsOptions.SetLimit(*pageSize + 1)

allDocsResult, _, err := service.PostAllDocs(postAllDocsOptions)
if err != nil {
    panic(err)
}

for len(viewResult.Rows) > 1 {
    documents := allDocsResult.Rows
    // on the last page, show all documents:
    if int64(len(documents)) <= *pageSize {
        b, err := json.MarshalIndent(documents, "", "  ")
        if err != nil {
            panic(err)
        }
        fmt.Printf(string(b))
        } else { // otherwise, hide the last document:
            b, err := json.MarshalIndent(documents[0:*pageSize], "", "  ")
            if err != nil {
                panic(err)
            }
            fmt.Printf(string(b))
        }
        // The startKey of the next request becomes the hidden document id:
        postAllDocsOptions.SetStartKey(*documents[len(documents)-1].ID)
        allDocsResult, _, err = service.PostAllDocs(postAllDocsOptions)
        if err != nil {
            panic(err)
        }
}
```
{: codeblock}
{: go}

First response:
{: curl}

```sh
{
  "total_rows": 11,
  "offset": 0,
  "rows": [
    { "id": "4eee973603bf77f30b1f880ed83df76a" ....},
    { "id": "4eee973603bf77f30b1f880ed83f469a" ....},
    { "id": "65fa623a384648740ec1f39b495d591c" ....},
    { "id": "d7404903579d6d5880514c22ad983529" ....},
    { "id": "example" ....},
    { "id": "mydoc" ....} // <-- This is the 6th result we use as the startkey of the next request
   ]
}    
```
{: codeblock}
{: curl}

Second request:
{: curl}

```sh
curl -H "Authorization: Bearer $API_BEARER_TOKEN" "$SERVICE_URL/orders/_all_docs?limit=6&startkey=\"mydoc\""
```
{: codeblock}
{: curl}

Second response:
{: curl}

```sh
{
  "total_rows": 11,
  "offset": 5,
  "rows": [
    { "id": "mydoc" ....},
    { "id": "order00057" ....},
    ...
   ]
} 
```
{: codeblock}
{: curl}

The previous Go example requires the following import block:
{: go}

```go
import (
 "encoding/json"
 "fmt"
 "github.com/IBM/cloudant-go-sdk/cloudantv1"
 "github.com/IBM/go-sdk-core/core"
```
{: codeblock}
{: go}

All Go examples require the `service` object to be initialized. For more information, see the API documentation's [Authentication section](https://cloud.ibm.com/apidocs/cloudant?code=go#authentication-with-external-configuration) for examples.
{: go}

This option works, but you end up fetching `n+1` documents when only `n` are required.

### Option 2 - The \u0000 trick
{: #option-2-the-u0000-trick}

If you're determined to fetch only `n` documents each time, then you need to calculate a value of `startkey`, which means `the next ID after the last _id in the result set`. For example, if the last document in the first page of results is "example", what must the `startkey` of the next call to `_all_docs` be? It can't be "example", otherwise you get the same document ID again. It turns out that you can append `\u0000` to the end of a key string to indicate the "next key" (`\u0000` is a Unicode null character, which can be placed in a URL as-is or with the percent code `%00`).
). 

First request:
{: curl}

```sh
curl -H "Authorization: Bearer $API_BEARER_TOKEN" "$SERVICE_URL/orders/_all_docs?limit=5"
```
{: codeblock}
{: curl}

```java
import com.ibm.cloud.cloudant.v1.Cloudant;
import com.ibm.cloud.cloudant.v1.model.AllDocsResult;
import com.ibm.cloud.cloudant.v1.model.DocsResultRow;
import com.ibm.cloud.cloudant.v1.model.PostAllDocsOptions;

Long pageSize = 5L;
PostAllDocsOptions.Builder docsOptionsBuilder =
        new PostAllDocsOptions.Builder()
                .db("orders")
                .limit(pageSize); // Fetch pageSize documents
AllDocsResult response =
        service.postAllDocs(docsOptionsBuilder.build())
        .execute()
        .getResult();

while (response.getRows().size() > 0) {
    List<DocsResultRow> responseDocuments = response.getRows();
    System.out.println(responseDocuments);
    // The startKey of the next request becomes the last document id appended with `\u0000`
    docsOptionsBuilder.startKey(
            responseDocuments
                    .get(responseDocuments.size() - 1)
                    .getId() + '\u0000'
    );
    response =
            service.postAllDocs(docsOptionsBuilder.build())
                    .execute()
                    .getResult();
}
```
{: codeblock}
{: java}

```javascript
const { CloudantV1 } = require('@ibm-cloud/cloudant');

const service = CloudantV1.newInstance({});

async function paginate(n) {
  let allDocsResult = (await service.postAllDocs({
    db: 'orders',
    limit: n
  })).result;
  while (allDocsResult.rows.length > 0) {
    let documents = allDocsResult.rows;
    console.log(documents);
    allDocsResult = (await service.postAllDocs({
      db: 'orders',
      limit: n,
      startKey: documents[documents.length - 1].id + '\u0000'
    })).result;
  }
}

paginate(5)
 ```
{: codeblock}
{: node}

```python
import json
from ibmcloudant.cloudant_v1 import CloudantV1

service = CloudantV1.new_instance()
page_size = 5

response = service.post_all_docs(
    db='orders',
    limit=page_size,
).get_result()

while len(response["rows"]) > 0:
    documents = response["rows"]
    print(json.dumps(documents, indent=2))
    response = service.post_all_docs(
        db='orders',
        limit=page_size+1,  # Fetch page_size + 1 documents
        start_key=documents[-1]["id"] + '\u0000'
    ).get_result()
```
{: codeblock}
{: python}

```go
pageSize := core.Int64Ptr(5)
postAllDocsOptions := service.NewPostAllDocsOptions(
    "orders",
)
postAllDocsOptions.SetLimit(*pageSize)

allDocsResult, _, err := service.PostAllDocs(postAllDocsOptions)
if err != nil {
    panic(err)
}

for len(allDocsResult.Rows) > 0 {
    documents := allDocsResult.Rows
    b, err := json.MarshalIndent(documents, "", "  ")
    if err != nil {
        panic(err)
    }
    fmt.Printf(string(b))
    // The startKeyDocId of the next request becomes the last document id appended with `\u0000`
    postAllDocsOptions.SetStartKey(*documents[len(documents)-1].ID + "\u0000")
    allDocsResult, _, err = service.PostAllDocs(postAllDocsOptions)
    if err != nil {
        panic(err)
    }
}
```
{: codeblock}
{: go}

First response:
{: curl}

```sh
{
  "total_rows": 11,
  "offset": 0,
  "rows": [
    { "id": "4eee973603bf77f30b1f880ed83df76a" ....},
    { "id": "4eee973603bf77f30b1f880ed83f469a" ....},
    { "id": "65fa623a384648740ec1f39b495d591c" ....},
    { "id": "d7404903579d6d5880514c22ad983529" ....},
    { "id": "example" ....} // <-- append \u0000 to this to get the startkey of the next request
   ]
}    
```
{: codeblock}
{: curl}

Second request:
{: curl}

```sh
curl -H "Authorization: Bearer $API_BEARER_TOKEN" "$SERVICE_URL/orders/_all_docs?limit=5&startkey=\"example\u0000\""
```
{: codeblock}
{: curl}

Second response:
{: curl}

```sh
{
  "total_rows": 11,
  "offset": 5,
  "rows": [
    { "id": "mydoc" ....},
    { "id": "order00057" ....},
    ...
    { "id": "order00067" ....} <-- append \u0000 to this to get the startkey of the next request
   ]
} 
```
{: codeblock}
{: curl}

The previous Go example requires the following import block:
{: go}

```go
import (
 "encoding/json"
 "fmt"
 "github.com/IBM/cloudant-go-sdk/cloudantv1"
 "github.com/IBM/go-sdk-core/core"
)
```
{: codeblock}
{: go}

All Go examples require the `service` object to be initialized. For more information, see the API documentation's [Authentication section](https://cloud.ibm.com/apidocs/cloudant?code=go#authentication-with-external-configuration) for examples.
{: go}

## Pagination of views
{: #pagination-of-views}

MapReduce views, secondary indexes, can be queried in a similar way to the `_all_docs` endpoint, but with the `GET` or `POST` `$SERVICE_URL/$DATABASE/_design/$DDOC/_view/$VIEW` endpoint instead. MapReduce views are defined by `key-value` pairs that are produced from user-supplied JavaScript functions. You can define your query in the following ways:

- Spool all the data from a view with no parameters.
- Include document bodies by supplying `include_docs=true`.
- Choose the range of keys that are required by using `startkey`/`endkey`, but in this case, the data type of the keys might not be a string.

Another complication is that unlike the primary index, where every `_id` is unique, the secondary index might have entries with the same key. For example, lots of entries that include the key `"herbivore"`. This situation makes pagination by using only `startkey`/`endkey` tricky, so you can use other parameters to help: `startkey_docid`/`endkey_docid`.

First request:
{: curl}

```sh
# get first page of animals by diet
curl -H "Authorization: Bearer $API_BEARER_TOKEN" "$SERVICE_URL/animaldb/_design/views101/_view/diet?limit=3&startkey=\"herbivore\"&endkey=\"herbivore\""
```
{: codeblock}
{: curl}

```java
import com.ibm.cloud.cloudant.v1.Cloudant;
import com.ibm.cloud.cloudant.v1.model.PostViewOptions;
import com.ibm.cloud.cloudant.v1.model.ViewResult;
import com.ibm.cloud.cloudant.v1.model.ViewResultRow;

int pageSize = 3;
String diet = "herbivore";
PostViewOptions.Builder viewOptionsBuilder =
        new PostViewOptions.Builder()
                .db("animaldb")
                .ddoc("views101")
                .view("diet")
                .limit(pageSize) // Fetch pageSize documents
                .startKey(diet)
                .endKey(diet);
ViewResult response =
        service.postView(viewOptionsBuilder.build())
                .execute()
                .getResult();

while (response.getRows().size() > 0) {
    List<ViewResultRow> responseDocuments = response.getRows();
    System.out.println(responseDocuments);
    // The startKeyDocId of the next request becomes the last document id appended with `\u0000`
    viewOptionsBuilder.startKeyDocId(
            responseDocuments
                    .get(responseDocuments.size() - 1)
                    .getId() + '\u0000'
    );
    response =
            service.postView(viewOptionsBuilder.build())
                    .execute()
                    .getResult();
}
```
{: codeblock}
{: java}

```javascript
const { CloudantV1 } = require('@ibm-cloud/cloudant');

const service = CloudantV1.newInstance({});

async function paginate(pageSize) {
  let diet = 'herbivore';
  let requestParams = {
    db: 'animaldb',
    ddoc: 'views101',
    view: 'diet',
    limit: pageSize,
    startKey: diet,
    endKey: diet,
  };
  let viewResult = (await service.postView(requestParams)).result;
  while (viewResult.rows.length > 0) {
    let documents = viewResult.rows;
    console.log(documents);
    // The startKeyDocId of the next request becomes the last document id appended with `\u0000`
    requestParams.startKeyDocId = documents[documents.length - 1].id + '\u0000';
    viewResult = (await service.postView(requestParams)).result;
  }
}

paginate(3)
 ```
{: codeblock}
{: node}

```python
import json
from ibmcloudant.cloudant_v1 import CloudantV1

service = CloudantV1.new_instance()
page_size = 3

diet = 'herbivore'
request_params = d = dict(
  db='animaldb',
  ddoc='views101',
  view='diet',
  limit=page_size,
  start_key=diet,
  end_key=diet,
)
response = service.post_view(**request_params).get_result()

while len(response["rows"]) > 0:
  documents = response["rows"]
  print(json.dumps(documents, indent=2))
  # The startKeyDocId of the next request becomes the last document id appended with `\u0000`
  request_params['start_key_doc_id'] = documents[-1]["id"] + '\u0000'
  response = service.post_view(**request_params).get_result()
```
{: codeblock}
{: python}

```go
pageSize := core.Int64Ptr(5)
diet := "herbivore"
viewOptions := service.NewPostViewOptions(
    "animaldb",
    "views101",
    "diet",
)
viewOptions.SetLimit(*pageSize)
viewOptions.SetStartKey(diet)
viewOptions.SetEndKey(diet)

viewResult, _, err := service.PostView(viewOptions)
if err != nil {
    panic(err)
}

for len(viewResult.Rows) > 0 {
    documents := viewResult.Rows
    b, err := json.MarshalIndent(documents, "", "  ")
    if err != nil {
        panic(err)
    }
    fmt.Printf(string(b))
    // The startKeyDocId of the next request becomes the last document id appended with `\u0000`
    viewOptions.SetStartKey(*documents[len(documents)-1].ID + "\u0000")
    viewResult, _, err = service.PostView(viewOptions)
    if err != nil {
        panic(err)
    }
}
```
{: codeblock}
{: go}

First response:
{: curl}

```sh
{
  "total_rows": 10,
  "offset": 2,
  "rows": [
    {
      "id": "elephant",
      "key": "herbivore",
      "value": 1
    },
    {
      "id": "giraffe",
      "key": "herbivore",
      "value": 1
    },
    {
      "id": "llama", // <-- append \u0000 to the startkey_docid to of the next request
      "key": "herbivore",
      "value": 1
    }
  ]
}
```
{: codeblock}
{: curl}

Second request:
{: curl}

```sh
# get next page of animals by diet
curl -H "Authorization: Bearer $API_BEARER_TOKEN" "$SERVICE_URL/animaldb/_design/views101/_view/diet?limit=3&startkey=\"herbivore\"&endkey=\"herbivore\"&startkey_docid=llama%00"
```
{: codeblock}
{: curl}

Second response:
{: curl}

```sh
{
  "total_rows": 10,
  "offset": 5,
  "rows": [
    {
      "id": "zebra",
      "key": "herbivore",
      "value": 1
    }
  ]
}
```
{: codeblock}
{: curl}

The previous Go example requires the following import block:
{: go}

```go
import (
 "encoding/json"
 "fmt"
 "github.com/IBM/cloudant-go-sdk/cloudantv1"
 "github.com/IBM/go-sdk-core/core"
)
```
{: codeblock}
{: go}

All Go examples require the `service` object to be initialized. For more information, see the API documentation's [Authentication section](https://cloud.ibm.com/apidocs/cloudant?code=go#authentication-with-external-configuration) for examples.
{: go}

In other words, the second request has a value of `startkey_docid` that is the last document ID from the previous page of results (llama) plus the magic `\u0000` character (which becomes `llama%00` in the URL).

The `startkey_docid` parameter works only if a `startkey` is supplied and where all index entries share the same key. If they don't share the same key, then pagination can be achieved with manipulation of `startkey`/`endkey` parameters only. Also, the `startkey_docid` parameter is not JSON encoded.
{: note}

## Bookmarks
{: #bookmarks}

 Imagine you're creating a web application that shows a set of search results, whether they be books, actors, or products in your store. As the user scrolls through the search results, another page of matches is appended at the end. This behavior is known as an "infinite scroll" design pattern. It allows the user to endlessly scroll through a large data set with ease, while they fetch only smaller batches of data from the database each time.

### How do {{site.data.keyword.cloudant_short_notm}} bookmarks work? 
{: #how-do-cloudant-bookmarks-work}

It's this sort of access pattern that {{site.data.keyword.cloudant_short_notm}} *bookmarks* are built for. Here's how it works:

- Your application performs a search on an {{site.data.keyword.cloudant_short_notm}} database, for example, `find me the first 10 cities where the country is 'US'`.
- {{site.data.keyword.cloudant_short_notm}} provides an array of 10 {{site.data.keyword.cloudant_short_notm}} documents and a *bookmark*, an opaque key that represents a pointer to the next documents in the result set.
- When the next set of results is required, the search is repeated. However, the query is sent, as well as the bookmark from the first response, to {{site.data.keyword.cloudant_short_notm}} in the request.
- {{site.data.keyword.cloudant_short_notm}} replies with the second set of documents and another bookmark, which can be used to get a third page of results.
- Repeat! 

Now you can see how to do that with code.

### How can I use {{site.data.keyword.cloudant_short_notm}} Query to search?
{: #use-cloudant-query-search}

First, you search for all the cities in the US. You're using [{{site.data.keyword.cloudant_short_notm}} Query](/docs/Cloudant?topic=Cloudant-query), so the operation is specified as a block of JSON:

```js
{
  "selector": {
    "$eq": {
      "country": "US"
    }
  },
  "limit": 5
}
```

By using the [`/db/_find`](/apidocs/cloudant#postfind){: external} API endpoint, the results are passed to {{site.data.keyword.cloudant_short_notm}}. 

```sh
curl -X POST \
      -H "Authorization: Bearer $API_BEARER_TOKEN" \
      -H 'Content-type: application/json' \
      -d '{"selector":{"country":{"$eq": "US"}},"limit":5}' \
      "$SERVICE_URL/cities/_find"
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
    "country",
    Collections.singletonMap("$eq", "US"));

PostFindOptions.Builder findOptions = new PostFindOptions.Builder()
    .db("cities")
    .selector(selector)
    .limit(5);

FindResult response = service.postFind(findOptions.build()).execute().getResult();
while (response.getDocs().size() > 0) {
    System.out.println(response.getDocs());
    // The bookmark of the next request becomes the bookmark of this response
    findOptions.bookmark(response.getBookmark());
    response = service.postFind(findOptions.build()).execute().getResult();
}
```
{: codeblock}
{: java}

```javascript
const { CloudantV1 } = require('@ibm-cloud/cloudant');

const service = CloudantV1.newInstance({});

async function paginate(pageSize) {
  let requestParams = {
      db: 'cities',
      selector: {country: {'$eq': 'US'}},
      limit: pageSize,
  }
  let findResult = (await service.postFind(requestParams)).result;
  while (findResult.docs.length > 0) {
    let documents = findResult.docs;
    console.log(documents);
    // The bookmark of the next request becomes the bookmark of this response
    requestParams.bookmark = findResult.bookmark;
    findResult = (await service.postFind(requestParams)).result;
  }
}

paginate(5)
```
{: codeblock}
{: node}

```python
request_params = dict(
    db='cities',
    selector={'country': {'$eq': 'US'}},
    limit=5,
)
response = service.post_find(**request_params).get_result()

while len(response['docs']) > 0:
    documents = response['docs']
    print(json.dumps(documents, indent=2))
    # The bookmark of the next request becomes the bookmark of this response
    request_params['bookmark'] = response['bookmark']
    response = service.post_find(**request_params).get_result()
```
{: codeblock}
{: python}

```go
findOptions := service.NewPostFindOptions(
    "cities",
    map[string]interface{}{
        "country": map[string]bool{
            "$eq": "US",
        },
    },
)
findOptions.SetLimit(5)

findResult, _, err := service.PostFind(findOptions)
if err != nil {
    panic(err)
}
for len(findResult.Docs) > 0 {
    documents := findResult.Docs
    b, err := json.MarshalIndent(documents, "", "  ")
    if err != nil {
        panic(err)
    }
    fmt.Printf(string(b))
    // The bookmark of the next request becomes the bookmark of this response
    findOptions.Bookmark = findResult.Bookmark
    findResult, _, err = service.PostFind(findOptions)
    if err != nil {
        panic(err)
    }
}
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

```sh
{
  "docs":[
    {"_id":"10104153","_rev":"1-32aab6258c65c5fc5af044a153f4b994","name":"Silver Lake","latitude":34.08668,"longitude":-118.27023,"country":"US","population":32890,"timezone":"America/Los_Angeles"},
    {"_id":"10104154","_rev":"1-125f589bf4e39d8e119b4b7b5b18caf6","name":"Echo Park","latitude":34.07808,"longitude":-118.26066,"country":"US","population":43832,"timezone":"America/Los_Angeles"},
    {"_id":"4046704","_rev":"1-2e4b7820872f108c077dab73614067da","name":"Fort Hunt","latitude":38.73289,"longitude":-77.05803,"country":"US","population":16045,"timezone":"America/New_York"},
    {"_id":"4048023","_rev":"1-744baaba02218fd84b350e8982c0b783","name":"Bessemer","latitude":33.40178,"longitude":-86.95444,"country":"US","population":27456,"timezone":"America/Chicago"},
    {"_id":"4048662","_rev":"1-e95c97013ece566b37583e451c1864ee","name":"Paducah","latitude":37.08339,"longitude":-88.60005,"country":"US","population":25024,"timezone":"America/Chicago"}
  ],
  "bookmark": "g1AAAAA-eJzLYWBgYMpgSmHgKy5JLCrJTq2MT8lPzkzJBYqzmxiYWJiZGYGkOWDSyBJZAPCBD58"
}
```
{: curl}

The response includes an array of `docs`, and a `bookmark`, which you use to paginate through the results in the next request. When you need page two of the results, you repeat the query by passing {{site.data.keyword.cloudant_short_notm}} the bookmark from the first response.
{: curl}

```sh
curl -X POST \
      -H "Authorization: Bearer $API_BEARER_TOKEN" \
      -H 'Content-type: application/json' \
      -d '{"selector":{"country":{"$eq": "US"}},"limit":5,"bookmark":"g1AAAAA-eJzLYWBgYMpgSmHgKy5JLCrJTq2MT8lPzkzJBYqzmxiYWJiZGYGkOWDSyBJZAPCBD58"}' \
      "$SERVICE_URL/cities/_find"
```
{: curl}

```sh
{
  "docs":[
    {"_id":"4049979","_rev":"1-1fa2591477c774a07c230571568aeb66","name":"Birmingham","latitude":33.52066,"longitude":-86.80249,"country":"US","population":212237,"timezone":"America/Chicago"},
    {"_id":"4054378","_rev":"1-a750085697685e7bc0e49d103d2de59d","name":"Center Point","latitude":33.64566,"longitude":-86.6836,"country":"US","population":16921,"timezone":"America/Chicago"},
    {"_id":"4058219","_rev":"1-9b4eb183c9cdf57c19be660ec600330c","name":"Daphne","latitude":30.60353,"longitude":-87.9036,"country":"US","population":21570,"timezone":"America/Chicago"},
    {"_id":"4058553","_rev":"1-56100f7e7742028facfcc50ab6b07a04","name":"Decatur","latitude":34.60593,"longitude":-86.98334,"country":"US","population":55683,"timezone":"America/Chicago"},
    {"_id":"4059102","_rev":"1-612ae37d982dc71eeecf332c1e1c16aa","name":"Dothan","latitude":31.22323,"longitude":-85.39049,"country":"US","population":65496,"timezone":"America/Chicago"}
  ],
  "bookmark": "g1AAAAA-eJzLYWBgYMpgSmHgKy5JLCrJTq2MT8lPzkzJBYqzmxiYWhoaGIGkOWDSyBJZAO9qD40",
  "warning": "no matching index found, create an index to optimize query time"
}
```
{: curl}

This time, you get the next five cities and a new bookmark ready for the next request.
{: curl}

### How does {{site.data.keyword.cloudant_short_notm}} Search work?
{: #how-cloudant-search-works}

Pagination works in the same way for [{{site.data.keyword.cloudant_short_notm}} Search](/docs/Cloudant?topic=Cloudant-cloudant-search) queries. Pass the `bookmark` parameter in the URL for GET requests or in the JSON body for POST requests. See the following example: 

```sh
curl -H "Authorization: Bearer $API_BEARER_TOKEN" "$SERVICE_URL/cities/_search/search/_search/freetext?q=country:US&limit=5"
```
{: codeblock}
{: curl}

```java
import com.ibm.cloud.cloudant.v1.Cloudant;
import com.ibm.cloud.cloudant.v1.model.PostSearchOptions;
import com.ibm.cloud.cloudant.v1.model.SearchResult;

Cloudant service = Cloudant.newInstance();

PostSearchOptions.Builder searchOptions = new PostSearchOptions.Builder()
    .db("cities")
    .ddoc("search")
    .index("freetext")
    .query("country:US");
    .limit(5);

SearchResult response = service.postSearch(searchOptions.build()).execute().getResult();
while (response.getRows().size() > 0) {
    System.out.println(response.getRows());
    // The bookmark of the next request becomes the bookmark of this response
    searchOptions.bookmark(response.getBookmark());
    response = service.postSearch(searchOptions.build()).execute().getResult();
}
```
{: codeblock}
{: java}

```javascript
const { CloudantV1 } = require('@ibm-cloud/cloudant');
async function paginate(pageSize) {
  let requestParams = {
    db: 'cities',
    ddoc: 'search',
    index: 'freetext',
    query: 'country:US',
    limit: 5
  };

  let searchResult = (await service.postSearch(requestParams)).result;
  while (searchResult.rows.length > 0) {
    let documents = searchResult.rows;
    console.log(documents);
    // The bookmark of the next request becomes the bookmark of this response
    requestParams.bookmark = searchResult.bookmark;
    searchResult = (await service.postSearch(requestParams)).result;
  }
}
paginate(5);
```
{: codeblock}
{: node}

```python
selector = {'country': {'$eq': 'US'}}
request_params = dict(
  db='cities',
  ddoc='search',
  index='freetext',
  query='country:US',
  limit=5,
)
response = service.post_search(**request_params).get_result()

while len(response['rows']) > 0:
  documents = response['rows']
  print(json.dumps(documents, indent=2))
  # The bookmark of the next request becomes the bookmark of this response
  request_params['bookmark'] = response['bookmark']
  response = service.post_search(**request_params).get_result()
```
{: codeblock}
{: python}

```go
searchOptions := service.NewPostSearchOptions(
    "cities",
    "search",
	"freetext",
	"country:US"
)
searchOptions.SetLimit(5)

searchResult, _, err := service.PostSearch(searchOptions)
if err != nil {
    panic(err)
}
for len(searchResult.Rows) > 0 {
    documents := searchResult.Rows
    b, err := json.MarshalIndent(documents, "", "  ")
    if err != nil {
        panic(err)
    }
    fmt.Printf(string(b))
    // The bookmark of the next request becomes the bookmark of this response
    searchOptions.Bookmark = searchResult.Bookmark
    searchResult, _, err = service.PostSearch(searchOptions)
    if err != nil {
        panic(err)
    }
}
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

```sh
{
  "total_rows": 65,
  "rows":[
    {"_id":"10104153","_rev":"1-32aab6258c65c5fc5af044a153f4b994","name":"Silver Lake","latitude":34.08668,"longitude":-118.27023,"country":"US","population":32890,"timezone":"America/Los_Angeles"},
    {"_id":"10104154","_rev":"1-125f589bf4e39d8e119b4b7b5b18caf6","name":"Echo Park","latitude":34.07808,"longitude":-118.26066,"country":"US","population":43832,"timezone":"America/Los_Angeles"},
    {"_id":"4046704","_rev":"1-2e4b7820872f108c077dab73614067da","name":"Fort Hunt","latitude":38.73289,"longitude":-77.05803,"country":"US","population":16045,"timezone":"America/New_York"},
    {"_id":"4048023","_rev":"1-744baaba02218fd84b350e8982c0b783","name":"Bessemer","latitude":33.40178,"longitude":-86.95444,"country":"US","population":27456,"timezone":"America/Chicago"},
    {"_id":"4048662","_rev":"1-e95c97013ece566b37583e451c1864ee","name":"Paducah","latitude":37.08339,"longitude":-88.60005,"country":"US","population":25024,"timezone":"America/Chicago"}
  ],
  "bookmark": "g1AAAAA-eJzLYWBgYMpgSmHgKy5JLCrJTq2MT8lPzkzJBYqzmxiYWJiZGYGkOWDSyBJZAPCBD58"
}
```
{: curl}

You get the first five cities and a bookmark ready for the next request with the `bookmark` request parameter.
{: curl}

```sh
curl -H "Authorization: Bearer $API_BEARER_TOKEN" "$SERVICE_URL/cities/_search/search/_search/freetext?q=country:US&limit=5&bookmark=g1AAAAA-eJzLYWBgYMpgSmHgKy5JLCrJTq2MT8lPzkzJBYqzmxiYWJiZGYGkOWDSyBJZAPCBD58"
```
{: curl}

```sh
{
  "total_rows": 65,
  "rows":[
    {"_id":"4049979","_rev":"1-1fa2591477c774a07c230571568aeb66","name":"Birmingham","latitude":33.52066,"longitude":-86.80249,"country":"US","population":212237,"timezone":"America/Chicago"},
    {"_id":"4054378","_rev":"1-a750085697685e7bc0e49d103d2de59d","name":"Center Point","latitude":33.64566,"longitude":-86.6836,"country":"US","population":16921,"timezone":"America/Chicago"},
    {"_id":"4058219","_rev":"1-9b4eb183c9cdf57c19be660ec600330c","name":"Daphne","latitude":30.60353,"longitude":-87.9036,"country":"US","population":21570,"timezone":"America/Chicago"},
    {"_id":"4058553","_rev":"1-56100f7e7742028facfcc50ab6b07a04","name":"Decatur","latitude":34.60593,"longitude":-86.98334,"country":"US","population":55683,"timezone":"America/Chicago"},
    {"_id":"4059102","_rev":"1-612ae37d982dc71eeecf332c1e1c16aa","name":"Dothan","latitude":31.22323,"longitude":-85.39049,"country":"US","population":65496,"timezone":"America/Chicago"}
  ],
  "bookmark": "g1AAAAA-eJzLYWBgYMpgSmHgKy5JLCrJTq2MT8lPzkzJBYqzmxiYWhoaGIGkOWDSyBJZAO9qD40",
}
```
{: curl}

See the documentation about [query parameters](/docs/Cloudant?topic=Cloudant-cloudant-search#query-parameters-search) for further details.

### Do MapReduce views accept bookmarks?
{: #mapreduce-views-accept-bookmarks}

No. MapReduce views don't accept a `bookmark`. Instead, use one of the following tricks to page through results:
- [The \u0000 trick](#option-2-the-u0000-trick)
- [Fetch one document too many](#option-1-fetch-one-doc-too-many)
- [Skip and limit](/docs/Cloudant?topic=Cloudant-using-views)

### Can I jump straight to page X of the results?
{: #jump-page-x-results}

No. Bookmarks make sense only to {{site.data.keyword.cloudant_short_notm}} if they come from the previous page of results. If you need page 3 of the results, you must fetch pages 1 and 2 first.

### What happens if I supply an incorrect bookmark?
{: #what-happens-if-i-supply-incorrect-bookmark}

{{site.data.keyword.cloudant_short_notm}} responds with an `HTTP 400 Bad Request { error: 'invalid_bookmark'}` response if you supply an invalid bookmark. Remember, you don't need a bookmark for the first search in a sequence.

### What happens if I change the query?
{: #what-happens-if-change-query}

You must keep the same query (the same selector in {{site.data.keyword.cloudant_short_notm}} Query or the same "q" in {{site.data.keyword.cloudant_short_notm}} Search) to get the next page of results. If you change the query, you might get an empty result set in reply.
