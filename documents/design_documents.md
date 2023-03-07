---

copyright:
  years: 2015, 2023
lastupdated: "2023-03-03"

keywords: create design document, update design document, copy design document, filter functions, update validators 

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# How design documents work
{: #design-documents}

{{site.data.keyword.cloudantfull}} reads specific fields and values of design documents as functions.
Design documents are used to [build indexes](#indexes-design-docs) and [validate updates](#update-validators).
{: shortdesc}

Each design document defines either *partitioned* or *global* indexes,
which are controlled by the `options.partitioned` field. A *partitioned* index allows only queries over a single data partition in a partitioned database. A *global* index allows querying over all data within a database, at a cost of latency and throughput over a partitioned index.

## Creating or updating a design document
{: #creating-or-updating-a-design-document}

Method
:  `PUT /$DATABASE/_design/$DDOC`

Request
:  JSON of the design document information.

Response
:  JSON status.

Roles permitted
:  `_admin`

To create a design document, upload it to the specified database.
   
In these examples,
`$VARIABLES` might refer to standard or design documents.
To distinguish between them,
standard documents have an `_id` indicated by `$DOCUMENT_ID`,
while design documents have an `_id` indicated by `$DDOC`.

A design document's ID never includes a partition key regardless of the
database's partitioning type. The partition key isn't included because the indexes that are included within a design document apply to all partitions in a partitioned database.

If a design document is updated, {{site.data.keyword.cloudant_short_notm}} deletes the indexes from the previous version, and re-creates the index from scratch. If you need to change a design document for a larger database, have a look at the [Design document management guide](/docs/Cloudant?topic=Cloudant-design-document-management#managing-changes-to-a-design-document).
{: note}

A design document's structure includes the following parts:

`_id`
:  Design document ID. This ID is *always* prefixed `_design` and *never* includes a partition key, regardless of database partitioning type.

`_rev` 
:  Design document revision.

Options
:  Contains options for this design document.

      Partitioned (optional, boolean)
      :  Determines whether this design document describes partitioned or global indexes. For more information, see [The `options.partitioned` field](#the-options-partitioned-field).

Views (optional)
:  An object that describes MapReduce views.

        `Viewname`
       :  (One for each view) - View Definition.

            Map
              :  Map Function for the view.

    Reduce (optional)
    :  Reduce Function for the view.

      Indexes (optional)
      : An object that describes search indexes.

          Index name
          :  (One for each index) - Index definition.

          Analyzer
          :  Object that describes the analyzer to be used or an object with the following fields:

   Name
   :  Name of the analyzer. Valid values are `standard`, `email`, `keyword`, `simple`, `whitespace`, `classic`, and `perfield`.

   Stopwords (optional)
   :  An array of stop words. Stop words are words that must not be indexed. If this array is specified, it overrides the default list of stop words. The default list of stop words depends on the analyzer. The standard analyzer includes the following list of stop words: `a`, `an`, `and`, `are`, `as`, `at`, `be`, `but`, `by`, `for`, `if`, `in`, `into`, `is`, `it`, `no`, `not`, `of`, `on`, `or`, `such`, `that`, `the`, `their`, `then`, `there`, `these`, `they`, `this`, `to`, `was`, `will`, and `with`.

   Default (for the per field analyzer)
   :  Default language to use if no language is specified for the field.

      Fields (for the per field analyzer)
      :  An object that specifies which language to use to analyze each field of the index. Field names in the object correspond to field names in the index, that is, the first parameter of the index function. The values of the fields are the languages to be used, for example `english`.

      Index 
      :  Function that handles the indexing.

Filters (optional, disallowed when `partitioned` is `true`) 
:  Filter functions.

   Function name (one for each function)
   :  Function definition.

Validate_doc_update (optional, disallowed when `partitioned` is `true`)
:  Update validation function.

### The `options.partitioned` field
{: #the-options.partitioned-field}

This field sets whether the created index is a partitioned or global index.

This field includes the following values:

| Value  | Description           | Notes |
|---------|---------------------|------------|
| `true` | Create the index as partitioned.   | Can be used only in a partitioned database. |
| `false`    | Create the index as global.  | Can be used in any database. |
{: caption="Table 1. Values for the options.partitioned field" caption-side="top"}

The default follows the `partitioned` setting for the database:

| Database is partitioned? | Default `partitioned` value | Allowed values |
|---------|----------|---------|
| Yes  | `true`  | `true`, `false` |
| No   | `false` | `false` |
{: caption="Table 2. Partition settings" caption-side="top"}

## Copying a design document
{: #copying-a-design-document}

You can copy the latest version of a design document to a new document
by specifying the base document and target document.
The copy is requested by using the `COPY` request method.

`COPY` is a nonstandard HTTP command.
{: tip}

The following example requests that {{site.data.keyword.cloudant_short_notm}} copy the design document `allusers` to the new design document `copyOfAllusers`,
and produces a response that includes the ID and revision of the new document.

Copying a design document doesn't automatically reconstruct the view indexes. Like other views, these views are re-created the first time that you access the new view.
{: note}

See the following example command to copy a design document by using HTTP:

```http
COPY $SERVICE_URL/$DATABASE/_design/$DDOC HTTP/1.1
Content-Type: application/json
Destination: _design/$COPY_OF_DDOC
```
{: codeblock}

See the following example command to copy a design document:

The {{site.data.keyword.cloudant_short_notm}} SDKs currently do not support the HTTP COPY method.
{: note}


```sh
curl "$SERVICE_URL/users/_design/allusers" \
	-X COPY \
	-H "Content-Type: application/json" \
	-H "Destination: _design/copyOfAllusers"
```


See the following example response to the copy request:

```json
{
  "ok": true,
  "id": "_design/copyOfAllusers",
  "rev": "1-9c65296036141e575d32ba9c034dd3ee"
}
```
{: codeblock}


### The structure of the copy command
{: #the-structure-of-the-copy-command}

Method
:  `COPY /$DATABASE/_design/$DDOC`

Request
:  None.

Response
:  JSON describing the new document and revision.

Roles permitted 
:  `_design`

Query Arguments

   Argument 
   :  `rev`

   Description
   :  Revision to copy from.

   Optional 
   :  Yes.

   Type 
   :  String.

HTTP Headers

Header
:  `Destination`

   Description 
   :  Destination document (and optional revision)

   Optional
   :  No.

The source design document is specified on the request line, while the `Destination` HTTP Header of the request specifies the target document.

### Copying from a specific revision
{: #copying-from-a-specific-revision}

To copy from a specific version,
add the `rev` argument to the query string.

The new design document is created by using the specified revision of the source document.

See the following example command to copy a specific revision of the design document by using HTTP:

```http
COPY $SERVICE_URL/$DATABASE/_design/$DDOC?rev=$REV HTTP/1.1
Content-Type: application/json
Destination: _design/$COPY_OF_DDOC
```
{: codeblock}

See the following example command to copy a specific revision of the design document by using the command line:

```sh
curl "$SERVICE_URL/users/_design/allusers?rev=1-e23b9e942c19e9fb10ff1fde2e50e0f5" \
	-X COPY \
	-H "Content-Type: application/json" \
	-H "Destination: _design/copyOfAllusers"
```
{: codeblock}

### Copying to an existing design document
{: #copying-to-an-existing-design-document}

To overwrite or copy to an existing document,
specify the current revision string for the target document by
using the `rev` parameter to the `Destination` HTTP Header string.

See the following example command to overwrite an existing copy of the design document by using HTTP:

```http
COPY $SERVICE_URL/$DATABASE/_design/$DDOC
Content-Type: application/json
Destination: _design/$COPY_OF_DDOC?rev=$REV
```
{: codeblock}

See the following example command to overwrite an existing copy of the design document by using the command line:

```sh
curl "$SERVICE_URL/users/_design/allusers" \
	-X COPY \
	-H "Content-Type: application/json" \
	-H "Destination: _design/copyOfAllusers?rev=1-9c65296036141e575d32ba9c034dd3ee"
```
{: codeblock}

The return value is the ID and new revision of the copied document.

See the following example response to overwrite an existing copy of the design document:

```json
{
  "id" : "_design/copyOfAllusers",
  "rev" : "2-55b6a1b251902a2c249b667dab1c6692"
}
```
{: codeblock}

## Deleting a design document
{: #deleting-a-design-document}

You can delete an existing design document.
Deleting a design document also deletes all of the associated view indexes,
and recovers the corresponding space on disk for the indexes in question.

To delete a design document successfully,
you must specify the current revision of the design document by using the `rev` query argument.

See the following example command to delete a design document by using HTTP:

```http
DELETE $SERVICE_URL/$DATABASE/_design/$DDOC?rev=$REV HTTP/1.1
```
{: codeblock}

See the following examples to delete a design document:

```sh
curl "$SERVICE_URL/users/_design/allusers?rev=2-21314508552eceb0e3012429d04575da" -X DELETE
```
{: codeblock}
{: curl}

```python
from ibmcloudant.cloudant_v1 import CloudantV1

service = CloudantV1.new_instance()

response = service.delete_design_document(
  db='users',
  ddoc='allusers',
  rev='2-21314508552eceb0e3012429d04575da'
).get_result()

print(response)
```
{: codeblock}
{: python}

```java
import com.ibm.cloud.cloudant.v1.Cloudant;
import com.ibm.cloud.cloudant.v1.model.DeleteDesignDocumentOptions;
import com.ibm.cloud.cloudant.v1.model.DocumentResult;

Cloudant service = Cloudant.newInstance();

DeleteDesignDocumentOptions designDocumentOptions =
    new DeleteDesignDocumentOptions.Builder()
        .db("users")
        .ddoc("allusers")
        .rev("2-21314508552eceb0e3012429d04575da")
        .build();

DocumentResult response =
    service.deleteDesignDocument(designDocumentOptions).execute()
        .getResult();

System.out.println(response);
```
{: codeblock}
{: java}

```node
const { CloudantV1 } = require('@ibm-cloud/cloudant');

const service = CloudantV1.newInstance({});

service.deleteDesignDocument({
  db: 'users',
  ddoc: 'allusers',
  rev: '2-21314508552eceb0e3012429d04575da'
}).then(response => {
  console.log(response.result);
});
```
{: codeblock}
{: node}

```go
deleteDesignDocumentOptions := service.NewDeleteDesignDocumentOptions(
  "users",
  "allusers",
)
deleteDesignDocumentOptions.SetRev("2-21314508552eceb0e3012429d04575da")

documentResult, response, err := service.DeleteDesignDocument(deleteDesignDocumentOptions)
if err != nil {
  panic(err)
}

b, _ := json.MarshalIndent(documentResult, "", "  ")
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

See the following example response that includes the deleted document ID and revision:

```json
{
  "id": "_design/allusers",
  "ok": true,
  "rev": "3-7a05370bff53186cb5d403f861aca154"
}
```
{: codeblock}

### The structure of the delete command
{: #the-structure-of-the-delete-command}

Method
:  `DELETE /db/_design/$DDOC`

Request 
:  None.

Response
:  JSON of deleted design document.

Roles permitted
:  `_design`


Query Arguments

Argument
:  `rev`

   Description
   :  Current revision of the document for validation.

   Optional
   :  Yes, if `If-Match` header exists.

   Type 
   :  String.

HTTP Headers

Header 
:  `If-Match`

   Description
   :  Current revision of the document for validation.

   Optional
   :  Yes, if `rev` query argument exists.

## Views
{: #view-design-documents}

An important use of design documents is for creating views. For more information about creating views, see [Views (MapReduce)](/docs/Cloudant?topic=Cloudant-creating-views-mapreduce).

## Indexes
{: #indexes-design-docs}

All queries operate on pre-defined indexes that are defined in design documents.
These indexes are defined in the following list:

-	[Search](/docs/Cloudant?topic=Cloudant-cloudant-search)
-	[MapReduce](/docs/Cloudant?topic=Cloudant-creating-views-mapreduce)

For example,
to create a design document that is used for searching,
you must ensure that two conditions are true:

1.   You defined the document as a design document when you started the `_id` with `_design/`.

2.   You created a [search index](/docs/Cloudant?topic=Cloudant-cloudant-search) within the document where you 
   [updated](/docs/Cloudant?topic=Cloudant-documents#update) the document with the appropriate field or [created](/docs/Cloudant?topic=Cloudant-documents#create-document) a new document that includes the search index.

As soon as the search index design document exists and the index is built,
you can make queries by using it.

### General notes on functions in design documents
{: #general-notes-on-functions-in-design-documents}

Functions in design documents are run on multiple nodes for each document,
and might be run several times.
To avoid inconsistencies,
they need to be [idempotent](https://en.wikipedia.org/wiki/Idempotence#Computer_science_meaning){: external},
meaning they need to behave identically when run multiple times or on different nodes.
In particular,
you must not use functions that generate random numbers or return the current time.

## Filter functions
{: #filter-functions}

Design documents with `options.partitioned` set to `true` can't contain a `filters` field.
{: tip}

Filter functions are design documents that filter
the [changes feed](/docs/Cloudant?topic=Cloudant-databases#get-changes). 
They work by applying tests to each of the objects included in the changes feed.

If any of the function tests fail,
the object is "removed" or "filtered" from the feed.
If the function returns a `true` result when applied to a change,
the change remains in the feed.
In other words, filter functions "remove" or "ignore" changes that you don't want to monitor.

Filter functions can also be used to modify a [replication task](/docs/Cloudant?topic=Cloudant-advanced-replication#filtered-replication-adv-repl).
{: tip}

Filter functions require two arguments: `doc` and [`req`](#req).

The `doc` argument represents the document that is tested for filtering.

The `req` argument includes more information about the request.
With this argument, you can create filter functions that are more dynamic
because they're based on multiple factors such as query parameters or the user context.

For example,
you could control aspects of the filter function tests by using dynamic values that are provided as part of the HTTP request.
However, in many filter function use cases,
only the `doc` parameter is used.

See the following example design document that includes a filter function:

```json
{
	"_id":"_design/example_design_doc",
	"filters": {
		"example_filter": "function (doc, req) { ... }"
	}
}
```
{: codeblock}

See the following example of a filter function:

```node
function(doc, req){
	// we need only `mail` documents
	if (doc.type != 'mail'){
		return false;
	}
	// we're interested only in `new` ones
	if (doc.status != 'new'){
		return false;
	}
	return true; // passed!
}
```
{: codeblock}

### Changes feed filter functions
{: #changes-feed-filter-functions}

To apply a filter function to the changes feed,
include the `filter` parameter in the `_changes` query,
providing the name of the filter to use.

See the following example of a filter function that is applied to a `_changes` query by using HTTP:

```http
POST $SERVICE_URL/$DATABASE/_changes?filter=$DDOC/$FILTER_FUNCTION HTTP/1.1
```
{: codeblock}

See the following examples of a filter function applied to a `_changes` query:

```sh
curl -X POST "$SERVICE_URL/orders/_changes?filter=example_design_doc/example_filter" -H "Content-Type: application/json" -d '{}'
```
{: codeblock}
{: curl}

```python
from ibmcloudant.cloudant_v1 import CloudantV1

service = CloudantV1.new_instance()

response = service.post_changes(
  db='orders',
  filter='example_design_doc/example_filter'
).get_result()

print(response)
```
{: codeblock}
{: python}

```java
import com.ibm.cloud.cloudant.v1.Cloudant;
import com.ibm.cloud.cloudant.v1.model.ChangesResult;
import com.ibm.cloud.cloudant.v1.model.PostChangesOptions;

Cloudant service = Cloudant.newInstance();

PostChangesOptions changesOptions = new PostChangesOptions.Builder()
    .db("orders")
    .filter("example_design_doc/example_filter")
    .build();

ChangesResult response =
    service.postChanges(changesOptions).execute()
        .getResult();

System.out.println(response);
```
{: codeblock}
{: java}

```node
const { CloudantV1 } = require('@ibm-cloud/cloudant');

const service = CloudantV1.newInstance({});

service.postChanges({
  db: 'orders',
  filter: 'example_design_doc/example_filter'
}).then(response => {
  console.log(response.result);
});
```
{: codeblock}
{: node}

```go
postChangesOptions := service.NewPostChangesOptions(
  "$DATABASE",
)
postChangesOptions.SetFilter("example_design_doc/example_filter")

changesResult, response, err := service.PostChanges(postChangesOptions)
if err != nil {
  panic(err)
}

b, _ := json.MarshalIndent(changesResult, "", "  ")
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

#### Filter function `req` argument
{: #changes-feed-req-filter-functions}

The `req` argument gives you access to aspects of the HTTP request by using the `query` property.

See the following example of supplying a `req` argument by using HTTP:

```http
GET $SERVICE_URL/$DATABASE/_changes?filter=$DDOC/$FILTER_FUNCTION&status=new HTTP/1.1
```
{: codeblock}

See the following example of supplying a `req` argument:

The {{site.data.keyword.cloudant_short_notm}} SDKs currently do not support `status` option for `_changes` request.
{: important}

```sh
curl "$SERVICE_URL/$DATABASE/_changes?filter=$DDOC/$FILTER_FUNCTION&status=new"
```
{: codeblock}
{: curl}

See the following example filter by using a supplied `req` argument:

```node
function(doc, req){
	// we need only `mail` documents
	if (doc.type != 'mail'){
		return false;
	}
	// we're interested only in `new` ones
	if (doc.status != req.query.status){
		return false;
	}
	return true; // passed!
}
```
{: codeblock}

### Predefined filter functions
{: #predefined-filter-functions}

A number of predefined filter functions are available:

[`_design`](#the-_design-filter)
:   Accepts only changes to design documents.

[`_doc_ids`](#the-_doc_ids-filter)
:   Accepts only changes for documents whose ID is specified in the `doc_ids` parameter or supplied JSON document.

[`_selector`](#the-_selector-filter)
:   Accepts only changes for documents that match a specified selector that is defined by using the same [selector syntax](/apidocs/cloudant#postfind){: external} as described in the Request section, which is used for [`_find`](/apidocs/cloudant#getdatabaseinformation){: external}.

[`_view`](#the-_view-filter)
:   With this function, you can use an existing [map function](/docs/Cloudant?topic=Cloudant-creating-views-mapreduce#a-simple-view) as the filter.

#### The `_design` filter
{: #the-design-filter}

The `_design` filter accepts changes only for design documents within the requested database.

The filter doesn't require any arguments.

Changes are listed for *all* the design documents within the database.

See the following example application of the `_design` filter by using HTTP:

```http
POST /$DATABASE/_changes?filter=_design HTTP/1.1
```
{: codeblock}

See the following example applications of the `_design` filter:

```sh
curl -X POST "$SERVICE_URL/orders/_changes?filter=_design" -H "Content-Type: application/json" -d '{}'
```
{: codeblock}
{: curl}

```python
from ibmcloudant.cloudant_v1 import CloudantV1

service = CloudantV1.new_instance()

response = service.post_changes(
  db='orders',
  filter='_design'
).get_result()

print(response)
```
{: codeblock}
{: python}

```java
import com.ibm.cloud.cloudant.v1.Cloudant;
import com.ibm.cloud.cloudant.v1.model.ChangesResult;
import com.ibm.cloud.cloudant.v1.model.PostChangesOptions;

Cloudant service = Cloudant.newInstance();

PostChangesOptions changesOptions = new PostChangesOptions.Builder()
    .db("orders")
    .filter("_design")
    .build();

ChangesResult response =
    service.postChanges(changesOptions).execute()
        .getResult();

System.out.println(response);
```
{: codeblock}
{: java}

```node
const { CloudantV1 } = require('@ibm-cloud/cloudant');

const service = CloudantV1.newInstance({});

service.postChanges({
  db: 'orders',
  filter: '_design'
}).then(response => {
  console.log(response.result);
});
```
{: codeblock}
{: node}

```go
postChangesOptions := service.NewPostChangesOptions(
  "$DATABASE",
)
postChangesOptions.SetFilter("_design")

changesResult, response, err := service.PostChanges(postChangesOptions)
if err != nil {
  panic(err)
}

b, _ := json.MarshalIndent(changesResult, "", "  ")
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

See the following example response (abbreviated) after you apply the `_design` filter:

```json
{
  ...
  "results":[
    {
      "changes":[
        {
          "rev":"10-304...4b2"
        }
      ],
      "id":"_design/ingredients",
      "seq":"8-g1A...gEo"
    },
    {
      "changes":[
        {
          "rev":"123-6f7...817"
        }
      ],
      "deleted":true,
      "id":"_design/cookbook",
      "seq":"9-g1A...4BL"
    },
    ...
  ]
}
```
{: codeblock}

#### The `_doc_ids` filter
{: #the-doc_ids-filter}

The `_doc-ids` filter accepts only changes for documents with specified IDs.
The IDs are specified in a `doc_ids` parameter,
or within a JSON document supplied as part of the original request.

See the following example application of the `_doc_ids` filter by using HTTP:

```http
POST $SERVICE_URL/$DATABASE/_changes?filter=_doc_ids HTTP/1.1
```
{: codeblock}

See the following example applications of the `_doc_ids` filter:

```sh
curl -X POST "$SERVICE_URL/orders/_changes?filter=_doc_ids" -H "Content-Type: application/json" -d '{"doc_ids": ["ExampleID"]}'
```
{: codeblock}
{: curl}

```python
from ibmcloudant.cloudant_v1 import CloudantV1

service = CloudantV1.new_instance()

response = service.post_changes(
  db='orders',
  filter='_doc_ids',
  doc_ids=['ExampleID']
).get_result()

print(response)
```
{: codeblock}
{: python}

```java
import java.util.Arrays;

import com.ibm.cloud.cloudant.v1.Cloudant;
import com.ibm.cloud.cloudant.v1.model.ChangesResult;
import com.ibm.cloud.cloudant.v1.model.PostChangesOptions;

Cloudant service = Cloudant.newInstance();

PostChangesOptions changesOptions = new PostChangesOptions.Builder()
    .db("orders")
    .filter("_doc_ids")
    .docIds(Arrays.asList("ExampleID"))
    .build();

ChangesResult response =
    service.postChanges(changesOptions).execute()
        .getResult();

System.out.println(response);
```
{: codeblock}
{: java}

```node
const { CloudantV1 } = require('@ibm-cloud/cloudant');

const service = CloudantV1.newInstance({});

service.postChanges({
  db: 'orders',
  filter: '_doc_ids',
  docIds: ['ExampleID']
}).then(response => {
  console.log(response.result);
});
```
{: codeblock}
{: node}

```go
postChangesOptions := service.NewPostChangesOptions(
  "$DATABASE",
)
postChangesOptions.SetFilter("_doc_ids")
postChangesOptions.SetDocIds([]string{"ExampleID"})

changesResult, response, err := service.PostChanges(postChangesOptions)
if err != nil {
  panic(err)
}

b, _ := json.MarshalIndent(changesResult, "", "  ")
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

See the following example JSON document that lists document IDs to match during filtering:

```json
{
  "doc_ids": [
    "ExampleID"
  ]
}
```
{: codeblock}

See the following example response (abbreviated) after you filter by `_docs_ids`:

```json
{
  "last_seq":"5-g1A...o5i",
  "pending":0,
  "results":[
    {
      "changes":[
        {
          "rev":"13-bcb...29e"
        }
      ],
      "id":"ExampleID",
      "seq":"5-g1A...HaA"
    }
  ]
}
```
{: codeblock}

#### The `_selector` filter
{: #the-selector-filter}

The `_selector` filter accepts only changes for documents that match a specified selector, which is defined by using the same [selector syntax](/docs/Cloudant?topic=Cloudant-query#selector-syntax) that is used
for [`_find`](/apidocs/cloudant#postfind){: external}.

For more examples that show use of this filter,
see the information on [selector syntax](/docs/Cloudant?topic=Cloudant-query#selector-syntax).

See the following example application of the `_selector` filter by using HTTP:

```http
POST $SERVICE_URL/$DATABASE/_changes?filter=_selector HTTP/1.1
```
{: codeblock}

See the following example applications of the `_selector` filter:

```sh
curl -X POST "$SERVICE_URL/orders/_changes?filter=_selector" -H "Content-Type: application/json" -d '{"selector": {"_id": { "$regex": "^_design/"}}}'
```
{: codeblock}
{: curl}

```python
from ibmcloudant.cloudant_v1 import CloudantV1

service = CloudantV1.new_instance()

response = service.post_changes(
  db='orders',
  filter='_selector',
  selector={'_id': { '$regex': '^_design/'}}
).get_result()

print(response)
```
{: codeblock}
{: python}

```java
import java.util.HashMap;
import java.util.Map;

import com.ibm.cloud.cloudant.v1.Cloudant;
import com.ibm.cloud.cloudant.v1.model.ChangesResult;
import com.ibm.cloud.cloudant.v1.model.PostChangesOptions;

Cloudant service = Cloudant.newInstance();

Map<String, Object> selector = new HashMap<String, Object>();
selector.put("_id", new HashMap<>().put("$regex", "^_design/"));

PostChangesOptions changesOptions = new PostChangesOptions.Builder()
    .db("orders")
    .filter("_selector")
    .selector(selector)
    .build();

ChangesResult response =
    service.postChanges(changesOptions).execute()
        .getResult();

System.out.println(response);
```
{: codeblock}
{: java}

```node
const { CloudantV1 } = require('@ibm-cloud/cloudant');

const service = CloudantV1.newInstance({});

service.postChanges({
    db: 'animaldb',
    filter: '_selector',
    selector: {"_id": { "$regex": "^_design/"}},
  }).then(response => {
    console.log(response.result);
  });
```
{: codeblock}
{: node}

```go
postChangesOptions := service.NewPostChangesOptions(
  "$DATABASE",
)
postChangesOptions.SetFilter("_selector")
postChangesOptions.SetSelector(map[string]interface{}{
  "_id": map[string]string{ "$regex": "^_design/"}})

changesResult, response, err := service.PostChanges(postChangesOptions)
if err != nil {
  panic(err)
}

b, _ := json.MarshalIndent(changesResult, "", "  ")
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

See the following example JSON document that includes the selector expression to use during filtering:

```json
{
  "selector":{
    "_id":{
      "$regex":"^_design/"
    }
  }
}
```
{: codeblock}

See the following example response (abbreviated) after you filter by using a selector:

```json
{
  "last_seq":"11-g1A...OaA",
  "pending":0,
  "results":[
    {
      "changes":[
        {
          "rev":"10-304...4b2"
        }
      ],
      "id":"_design/ingredients",
      "seq":"8-g1A...gEo"
    },
    {
      "changes":[
        {
          "rev":"123-6f7...817"
        }
      ],
      "deleted":true,
      "id":"_design/cookbook",
      "seq":"9-g1A...4BL"
    },
    {
      "changes":[
        {
          "rev":"6-5b8...8f3"
        }
      ],
      "deleted":true,
      "id":"_design/meta",
      "seq":"11-g1A...Hbg"
    }
  ]
}
```
{: codeblock}

#### The `_view` filter
{: #the-view-filter}

Using the `_view` filter, you can use an existing [map function](/docs/Cloudant?topic=Cloudant-creating-views-mapreduce#a-simple-view) as the filter.

The map function might emit output as the result of processing a specific document. When this situation occurs, the filter considers the document that is allowed and includes it in the list of documents that you changed.

See the following example application of the `_view` filter by using HTTP:

```http
POST $SERVICE_URL/$DATABASE/_changes?filter=_view&view=$DDOC/$VIEW_NAME HTTP/1.1
```
{: codeblock}

See the following example applications of the `_view` filter:

```sh
curl -X POST "$SERVICE_URL/animaldb/_changes?filter=_view&view=views101/latin_name" -H "Content-Type: application/json" -d '{}'
```
{: codeblock}
{: curl}

```python
from ibmcloudant.cloudant_v1 import CloudantV1

service = CloudantV1.new_instance()

response = service.post_changes(
  db='animaldb',
  filter='_view',
  view='views101/latin_name'
).get_result()

print(response)
```
{: codeblock}
{: python}

```java
import com.ibm.cloud.cloudant.v1.Cloudant;
import com.ibm.cloud.cloudant.v1.model.ChangesResult;
import com.ibm.cloud.cloudant.v1.model.PostChangesOptions;

Cloudant service = Cloudant.newInstance();

PostChangesOptions changesOptions = new PostChangesOptions.Builder()
    .db("animaldb")
    .filter("_vew")
    .view("views101/latin_name")
    .build();

ChangesResult response =
    service.postChanges(changesOptions).execute()
        .getResult();

System.out.println(response);
```
{: codeblock}
{: java}

```node
const { CloudantV1 } = require('@ibm-cloud/cloudant');

const service = CloudantV1.newInstance({});

service.postChanges({
  db: 'animaldb',
  filter: '_view',
  view: 'views101/latin_name'
}).then(response => {
  console.log(response.result);
});
```
{: codeblock}
{: node}

```go
postChangesOptions := service.NewPostChangesOptions(
  "animaldb",
)
postChangesOptions.SetFilter("_view")
postChangesOptions.SetView("views101/latin_name")

changesResult, _, err := service.PostChanges(postChangesOptions)
if err != nil {
fmt.Println(err)
}

b, _ := json.MarshalIndent(changesResult, "", "  ")
fmt.Println(string(b))
```
{: codeblock}
{: go}

See the following example response (abbreviated) after you filter by using a map function:

```json
{
  "last_seq": "5-g1A...o5i",
  "results": [
    {
      "changes": [
        {
          "rev": "13-bcb...29e"
        }
      ],
      "id": "ExampleID",
      "seq":  "5-g1A...HaA"
    }
  ]
}
```
{: codeblock}

## Update validators
{: #update-validators}

Design documents with `options.partitioned` set to `true` can't contain a `validate_doc_update` field.
{: tip}

Update validators determine whether a document must be written to disk when insertions and updates are attempted.
They don't require a query because they implicitly run during this process.
If a change is rejected,
the update validator responds with a custom error.

Update validators require four arguments:

| Argument  | Purpose |
|----------|--------|
| `newDoc`  | The version of the document passed in the request. |
| `oldDoc`  | The version of the document currently in the database, or `null` if none exists. |
| `secObj`  | The [security object](/apidocs/cloudant#getsecurity){: external} for the database. |
| `userCtx` | Context regarding the currently authenticated user, such as `name` and `roles`. |
{: caption="Table 3. Arguments for the update validator" caption-side="top"}

Update validators don't apply when a design document is updated by an admin user. This practice ensures that admins can never accidentally lock themselves out.
{: tip}

See the following example design document with an update validator:

```json
{
	"_id": "_design/validator_example",
	"validate_doc_update": "function(newDoc, oldDoc, userCtx, secObj) { ... }"
}
```
{: codeblock}

See the following example of an update validator:

```node
function(newDoc, oldDoc, userCtx, secObj) {
	if (newDoc.address === undefined) {
		throw({forbidden: 'Document must have an address.'});
	}
}
```
{: codeblock}

See the following example response from an update validator:

```json
{
	"error": "forbidden",
	"reason": "Document must have an address."
}
```
{: codeblock}

## Retrieving information about a design document
{: #retrieving-information-about-a-design-document}

Two endpoints provide you with more information about
design documents: [`_info`](#the-info-endpoint) and [`_search_info`](#thesearch_info-endpoint).

### The `_info` endpoint
{: #the-info-endpoint}

The `_info` endpoint returns information about a specific design document,
including the view index,
view index size,
and status of the design document and associated view index information.

Method 
:  `GET /db/_design/$DDOC/_info`

Request 
:  None

Response 
:  JSON that contains the design document information.

Roles permitted 
:  `_reader`

See the following example of retrieving information about the `recipesdd` design document from within the `recipes` database by using HTTP:

```http
GET /recipes/_design/recipesdd/_info HTTP/1.1
```
{: codeblock}

See the following examples of retrieving information about the `recipesdd` design document from within the `recipes` database:
```sh
curl "$SERVICE_URL/recipes/_design/recipesdd/_info"
```
{: codeblock}
{: curl}

```go
getDesignDocumentInformationOptions := service.NewGetDesignDocumentInformationOptions(
  "recipes",
  "recipesdd",
)

designDocumentInformation, response, err := service.GetDesignDocumentInformation(getDesignDocumentInformationOptions)
if err != nil {
  panic(err)
}

b, _ := json.MarshalIndent(designDocumentInformation, "", "  ")
fmt.Println(string(b))
```
{: codeblock}
{: go}

```python
from ibmcloudant.cloudant_v1 import CloudantV1

service = CloudantV1.new_instance()

response = service.get_design_document_information(
  db='recipes',
  ddoc='recipesdd'
).get_result()

print(response)
```
{: codeblock}
{: python}

```java
import com.ibm.cloud.cloudant.v1.Cloudant;
import com.ibm.cloud.cloudant.v1.model.DesignDocumentInformation;
import com.ibm.cloud.cloudant.v1.model.GetDesignDocumentInformationOptions;

Cloudant service = Cloudant.newInstance();

GetDesignDocumentInformationOptions informationOptions =
    new GetDesignDocumentInformationOptions.Builder()
        .db("recipes")
        .ddoc("recipesdd")
        .build();

DesignDocumentInformation response =
    service.getDesignDocumentInformation(informationOptions).execute()
        .getResult();

System.out.println(response);
```
{: codeblock}
{: java}

```node
const { CloudantV1 } = require('@ibm-cloud/cloudant');

const service = CloudantV1.newInstance({});

service.getDesignDocumentInformation({
  db: 'recipes',
  ddoc: 'recipesdd'
}).then(response => {
  console.log(response.result);
});
```
{: codeblock}
{: node}

The JSON response includes the following individual fields:

`name`
:  Name or ID of design document.

`view_index` 
:  View Index

    `compact_running` 
    :  Indicates whether a compaction routine runs on the view.

    `disk_size`
    : Size in bytes of the view as stored on disk.

    `language`
    :  Language that is used for defining views.

    `purge_seq`
    :  The purge sequence that was processed.

    `signature`
    :  MD5 signature of the views for the design document.

    `update_seq`
    :  The update sequence of the corresponding database that was indexed.

    `updater_running`
    :  Indicates whether the view is being updated.

    `waiting_clients`
    :  Number of clients that are waiting on views from this design document.

    `waiting_commit`
    :  Indicates whether the underlying database has outstanding commits that need to process. 

See the following example response in JSON format:

```json
{
	"name" : "recipesdd",
	"view_index": {
		"compact_running": false,
		"updater_running": false,
		"language": "javascript",
		"purge_seq": 10,
		"waiting_commit": false,
		"waiting_clients": 0,
		"signature": "fc65594ee76087a3b8c726caf5b40687",
		"update_seq": 375031,
		"disk_size": 16491
	}
}
```
{: codeblock}

### The `_search_info` endpoint
{: #the-search_info-endpoint}

The `_search_info` endpoint returns information about a specified search that is defined within a specific design document.

Method
:  `GET /db/_design/$DDOC/_search_info/yourSearch`

Request 
:  None

Response
:  JSON that contains information about the specified search.

Roles permitted*
:  `_reader`

See the following example of getting information about the `description` search, which is defined within the `app` design document that is stored in the `foundbite` database, by using HTTP:

```http
GET /foundbite/_design/app/_search_info/description HTTP/1.1
```
{: codeblock}

See the following examples of getting information about the `description` search index, which is defined within the `app` design document that is stored in the `foundbite` database:

```sh
curl "$SERVICE_URL/foundbite/_design/app/_search_info/description"
```
{: codeblock}
{: curl}

```python
from ibmcloudant.cloudant_v1 import CloudantV1

service = CloudantV1.new_instance()

response = service.get_search_info(
  db='foundbite',
  ddoc='app',
  index='description'
).get_result()

print(response)
```
{: codeblock}
{: python}

```java
import com.ibm.cloud.cloudant.v1.Cloudant;
import com.ibm.cloud.cloudant.v1.model.GetSearchInfoOptions;
import com.ibm.cloud.cloudant.v1.model.SearchInfoResult;

Cloudant service = Cloudant.newInstance();

GetSearchInfoOptions infoOptions =
    new GetSearchInfoOptions.Builder()
        .db("foundbite")
        .ddoc("app")
        .index("description")
        .build();

SearchInfoResult response =
    service.getSearchInfo(infoOptions).execute()
        .getResult();

System.out.println(response);
```
{: codeblock}
{: java}

```node
const { CloudantV1 } = require('@ibm-cloud/cloudant');

const service = CloudantV1.newInstance({});

service.getSearchInfo({
  db: 'foundbite',
  ddoc: 'app',
  index: 'description'
}).then(response => {
  console.log(response.result);
});
```
{: codeblock}
{: node}

```go
getSearchInfoOptions := service.NewGetSearchInfoOptions(
  "foundbite",
  "app",
  "description",
)

searchInfoResult, response, err := service.GetSearchInfo(getSearchInfoOptions)
if err != nil {
  panic(err)
}

b, _ := json.MarshalIndent(searchInfoResult, "", "  ")
fmt.Println(string(b))
```
{: codeblock}
{: go}

The JSON structure includes the following individual fields:

`name`
:   Name or ID of the Search within the design document.

`search_index`
:   The Search Index

   `pending_seq`
   :   The sequence number of changes in the database that reached the Lucene index, both in memory and on disk.

   `doc_del_count`
   :   Number of deleted documents in the index.

   `doc_count`
   :   Number of documents in the index.

   `disk_size`
   :   The size of the index on disk, in bytes.

   `committed_seq`
   :   The sequence number of changes in the database that were committed to the Lucene index on disk.

See the following example response in JSON format:

```json
{
  "name":"_design/app/description",
  "search_index":{
    "pending_seq":63,
    "doc_del_count":3,
    "doc_count":10,
    "disk_size":9244,
    "committed_seq":63
  }
}
```
{: codeblock}
