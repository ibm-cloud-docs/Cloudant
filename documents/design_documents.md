---

copyright:
  years: 2015, 2021
lastupdated: "2021-09-02"

keywords: create design document, update design document, copy design document, rewrite rules, list functions, show functions, update handlers, filter functions, update validators 

subcollection: Cloudant

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:tip: .tip}
{:note: .note}
{:important: .important}
{:deprecated: .deprecated}
{:external: target="_blank" .external}

<!-- Acrolinx: 2021-04-16 -->

# How design documents work
{: #design-documents}

{{site.data.keyword.cloudantfull}} reads specific fields and values of design documents as functions.
Design documents are used to [build indexes](#indexes-design-docs), [validate updates](#update-validators), and [format query results](#list-functions).
{: shortdesc}

Each design document defines either *partitioned* or *global* indexes,
which are controlled by the `options.partitioned` field. A *partitioned* index allows only queries over a single data partition in a partitioned database. A *global* index allows querying over all data within a database, at a cost of latency and throughput over a partitioned index.

## Creating or updating a design document
{: #creating-or-updating-a-design-document}

-	**Method** - `PUT /$DATABASE/_design/design-doc`
-	**Request** - JSON of the design document information
-	**Response** - JSON status
-	**Roles permitted** - `_admin`

To create a design document, upload it to the specified database.
   
In these examples,
`$VARIABLES` might refer to standard or design documents.
To distinguish between them,
standard documents have an `_id` indicated by `$DOCUMENT_ID`,
while design documents have an `_id` indicated by `$DESIGN_ID`.

A design document's ID never includes a partition key regardless of the
database's partitioning type. The partition key isn't included because the indexes that are included within a design document apply to all partitions in a partitioned database.

If a design document is updated, {{site.data.keyword.cloudant_short_notm}} deletes the indexes from the previous version, and re-creates the index from scratch. If you need to change a design document for a larger database, have a look at the [Design document management guide](/docs/Cloudant?topic=Cloudant-design-document-management#managing-changes-to-a-design-document).
{: note}

A design document's structure includes the following parts:

-	**`_id`** - Design document ID. This ID is *always* prefixed `_design` and *never* includes a partition key, regardless of database partitioning type.
-	**`_rev`** - Design document revision
-	**Options** - Contains options for this design document.
    -   **Partitioned (optional, boolean)** - Whether this design document describes partitioned or global indexes. For more information, see [The `options.partitioned` field](#the-options-partitioned-field).
-	**Views (optional)** - An object that describes MapReduce views.
	-	**`Viewname`** (one for each view) - View Definition.
		-	**Map** - Map Function for the view.
		-	**Reduce (optional)** - Reduce Function for the view.
-	**Indexes (optional)** - An object that describes search indexes.
	-	**Index name** (one for each index) - Index definition.
		-	**Analyzer** - Object that describes the analyzer to be used or an object with the following fields:
			-	**Name** - Name of the analyzer. Valid values are `standard`, `email`, `keyword`, `simple`, `whitespace`, `classic`, and `perfield`.
			-	**Stopwords (optional)** - An array of stop words.
				Stop words are words that must not be indexed.
				If this array is specified,
				it overrides the default list of stop words.
				The default list of stop words depends on the analyzer.
				The standard analyzer includes the following list of stop words:
				`a`, `an`, `and`, `are`, `as`, `at`, `be`, `but`, `by`, `for`, `if`, `in`, `into`, `is`, `it`, `no`, `not`, `of`, `on`, `or`, `such`, `that`, `the`, `their`, `then`, `there`, `these`, `they`, `this`, `to`, `was`, `will`, and `with`.
			-	**Default (for the per field analyzer)** - default language to use if no language is specified for the field.
			-	**Fields (for the per field analyzer)** - An object that specifies which language to use to analyze each field of the index.
				Field names in the object correspond to field names in the index, that is, the first parameter of the index function.
				The values of the fields are the languages to be used, for example `english`.
		-	**Index** - Function that handles the indexing.
-	**Rewrites (optional, disallowed when `partitioned` is `true`)** - Rewrite functions.
	-	**Function name** (one for each function) - Function definition.
-	**Lists (optional, disallowed when `partitioned` is `true`)** - List functions.
	-	**Function name** (one for each function) - Function definition.
-	**Shows (optional, disallowed when `partitioned` is `true`)** - Show functions.
	-	**Function name** (one for each function) - Function definition.
-	**Updates (optional, disallowed when `partitioned` is `true`)** - Update functions.
	-	**Function name** (one for each function) - Function definition.
-	**Filters (optional, disallowed when `partitioned` is `true`)** - Filter functions.
	-	**Function name** (one for each function) - Function definition.
-	**Validate_doc_update (optional, disallowed when `partitioned` is `true`)** - Update validation function.

### The `options.partitioned` field

This field sets whether the created index is a partitioned or global index.

This field includes the following values:

Value  | Description           | Notes
---------|---------------------|------------
`true` | Create the index as partitioned.   | Can be used only in a partitioned database.
`false`    | Create the index as global.  | Can be used in any database.
{: caption="Table 1. Values for the `options.partitioned` field" caption-side="top"}

The default follows the `partitioned` setting for the database:

Database is partitioned? | Default `partitioned` value | Allowed values
---------|----------|---------
Yes  | `true`  | `true`, `false`
No   | `false` | `false`
{: caption="Table 2. Partition settings" caption-side="top"}

## Copying a design document
{: #copying-a-design-document}

You can copy the latest version of a design document to a new document
by specifying the base document and target document.
The copy is requested by using the `COPY` request method.

`COPY` is a non-standard HTTP command.
{: tip}

Copying a design document doesn't automatically reconstruct the view indexes. Like other views, these views are re-created the first time that you access the new view.
{: note}

The following example requests that {{site.data.keyword.cloudant_short_notm}} copy the design document `recipes` to the new design document `recipelist`,
and produces a response that includes the ID and revision of the new document.

See the following example command to copy a design document by using HTTP:

```http
COPY /recipes/_design/recipes HTTP/1.1
Content-Type: application/json
Destination: _design/recipelist
```
{: codeblock}

See the following example command to copy a design document by using the command line:

```sh
curl "https://$ACCOUNT.cloudant.com/recipes/_design/recipes" \
	-X COPY \
	-H "Content-Type: application/json" \
	-H "Destination: _design/recipelist"
```
{: codeblock}

See the following example response to the copy request:

```json
{
	"id": "_design/recipelist",
	"rev": "1-9c65296036141e575d32ba9c034dd3ee"
}
```
{: codeblock}


### The structure of the copy command
{: #the-structure-of-the-copy-command}

-	**Method** - `COPY /$DATABASE/_design/design-doc`
-	**Request** - None
-	**Response** - JSON describing the new document and revision.
-	**Roles permitted** - `_design`
-	**Query Arguments** 
	-	**Argument** - `rev`
		-	**Description** -  Revision to copy from.
		-	**Optional** - yes
		-	**Type** - string
-	**HTTP Headers**
	-	**Header** - `Destination`
		-	**Description** - Destination document (and optional revision)
		-	**Optional** - no

The source design document is specified on the request line, while the `Destination` HTTP Header of the request specifies the target document.

### Copying from a specific revision
{: #copying-from-a-specific-revision}

To copy from a specific version,
add the `rev` argument to the query string.

The new design document is created by using the specified revision of the source document.

See the following example command to copy a specific revision of the design document by using HTTP:

```http
COPY /recipes/_design/recipes?rev=1-e23b9e942c19e9fb10ff1fde2e50e0f5 HTTP/1.1
Content-Type: application/json
Destination: _design/recipelist
```
{: codeblock}

See the following example command to copy a specific revision of the design document by using the command line:

```sh
curl "https://$ACCOUNT.cloudant.com/recipes/_design/recipes?rev=1-e23b9e942c19e9fb10ff1fde2e50e0f5" \
	-X COPY \
	-H "Content-Type: application/json" \
	-H "Destination: _design/recipelist"
```
{: codeblock}

### Copying to an existing design document
{: #copying-to-an-existing-design-document}

To overwrite or copy to an existing document,
specify the current revision string for the target document by
using the `rev` parameter to the `Destination` HTTP Header string.

See the following example command to overwrite an existing copy of the design document by using HTTP:

```http
COPY /recipes/_design/recipes
Content-Type: application/json
Destination: _design/recipelist?rev=1-9c65296036141e575d32ba9c034dd3ee
```
{: codeblock}

See the following example command to overwrite an existing copy of the design document by using the command line:

```sh
curl "https://$ACCOUNT.cloudant.com/recipes/_design/recipes" \
	-X COPY \
	-H "Content-Type: application/json" \
	-H "Destination: _design/recipelist?rev=1-9c65296036141e575d32ba9c034dd3ee"
```
{: codeblock}

The return value is the ID and new revision of the copied document.

See the following example response to overwrite an existing copy of the design document:

```json
{
	"id" : "_design/recipes",
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
DELETE /recipes/_design/recipes?rev=2-ac58d589b37d01c00f45a4418c5a15a8 HTTP/1.1
```
{: codeblock}

See the following example command to delete a design document by using the command line:

```sh
curl "https://$ACCOUNT.cloudant.com/recipes/_design/recipes?rev=2-ac58d589b37d01c00f45a4418c5a15a8" \
     -X DELETE
```
{: codeblock}

See the following example response that includes the deleted document ID and revision:

```json
{
	"id": "recipe/_design/recipes",
	"ok": true,
	"rev": "3-7a05370bff53186cb5d403f861aca154"
}
```
{: codeblock}

### The structure of the delete command
{: #the-structure-of-the-delete-command}

-	**Method** - `DELETE /db/_design/design-doc`
-	**Request** - None
-	**Response** - JSON of deleted design document.
-	**Roles permitted** - `_design`
-	**Query Arguments**
	-	**Argument** - `rev`
		-	**Description** - Current revision of the document for validation.
		-	**Optional**- yes
		-	**Type** - string
-	**HTTP Headers**
	-	**Header** - `If-Match`
		-	**Description** - Current revision of the document for validation.
		-	**Optional** - yes

## Views
{: #view-design-documents}

An important use of design documents is for creating views. For more information about creating views, see [Views (MapReduce)](/docs/Cloudant?topic=Cloudant-views-mapreduce#views-mapreduce).

## Rewrite rules
{: #rewrite-rules}

A design document can include rules for URL rewriting, by using an array in the `rewrites` field.
Requests that match the rewrite rules must have a URL path that starts with `/$DATABASE/_design/doc/_rewrite`.

Design documents with `options.partitioned` set to `true` can't contain a `rewrites` field.
{: tip}

Each rule is a JSON object with four fields:

Field    | Description
---------|------------
`from`   | A path relative to `/$DATABASE/_design/doc/_rewrite`, used to match URLs to rewrite rules. Path elements that start with a `:` are treated as variables and match any string that doesn't contain a `/`. An `*` can appear only at the end of the string, and matches any string - including slashes.
`method` | The HTTP method that must be matched.
`query`  | The query part of the resulting URL. This part is a JSON object that includes the `key-value` pairs of the query.
`to`     | The path (relative to `/$DATABASE/_design/doc/` and not including the query part of the URL) that is the result of the rewriting step. Variables that are captured in `from` can be used in `to`. An `*` can also be used and includes everything that is captured by the pattern in `from`.
{: caption="Table 3. Fields for the rewrite rules" caption-side="top"}

See the following example JSON describing some rewrite rules:

```json
{
	"rewrites": [
		{
			"from": "/",
			"to": "index.html",
			"method": "GET",
			"query": {}
		},
		{
			"from": "/foo/:var",
			"to": "/foo",
			"method": "GET",
			"query": {"v": "var"}
		}
	]
}
```
{: codeblock}

While {{site.data.keyword.cloudant_short_notm}} is API-compliant with CouchDB, {{site.data.keyword.cloudant_short_notm}} doesn't support URL rewrites by using the JavaScript function.
{: note}

The following table has some more examples of rewriting URL components:

Rule | URL | Rewrite to | Tokens
-----|-----|------------|-------
`{"from": "/a/b", "to": "/some/"}` | `/$DATABASE/_design/doc/_rewrite/a/b?k=v` | `/$DATABASE/_design/doc/some?k=v`        | `k = v`
`{"from": "/a/b", "to": "/some/:var"}` | `/$DATABASE/_design/doc/_rewrite/a/b`     | `/$DATABASE/_design/doc/some/b?var=b`    | `var = b`
`{"from": "/a", "to": "/some/*"}` | `/$DATABASE/_design/doc/_rewrite/a`       | `/$DATABASE/_design/doc/some`            |
`{"from": "/a/*", "to": "/some/*}` | `/$DATABASE/_design/doc/_rewrite/a/b/c`   | `/$DATABASE/_design/doc/some/b/c`        |
`{"from": "/a", "to": "/some/*"}` | `/$DATABASE/_design/doc/_rewrite/a`       | `/$DATABASE/_design/doc/some`            |
`{"from": "/a/:foo/*","to": "/some/:foo/*"}` | `/$DATABASE/_design/doc/_rewrite/a/b/c`   | `/$DATABASE/_design/doc/some/b/c?foo=b`  | `foo = b`
`{"from": "/a/:foo", "to": "/some", "query": { "k": ":foo" }}` | `/$DATABASE/_design/doc/_rewrite/a/b`     | `/$DATABASE/_design/doc/some/?k=b&foo=b` | `foo =:= b`
`{"from": "/a", "to": "/some/:foo" }` | `/$DATABASE/_design/doc/_rewrite/a?foo=b` | `$DATABASE/_design/doc/some/b&foo=b`     | `foo = b`
{: caption="Table 4. Rewrite rules" caption-side="top"}

## Indexes
{: #indexes-design-docs}

All queries operate on pre-defined indexes that are defined in design documents.
These indexes are defined in the following list:

*	[Search](/docs/Cloudant?topic=Cloudant-search#search)
*	[MapReduce](/docs/Cloudant?topic=Cloudant-views-mapreduce#views-mapreduce)

For example,
to create a design document that is used for searching,
you must ensure that two conditions are true:

1.	You defined the document as a design document when you started the `_id` with `_design/`.
2.	You created a [search index](/docs/Cloudant?topic=Cloudant-search#search) within the document where you 
	[updated](/docs/Cloudant?topic=Cloudant-documents#update) the document with the appropriate field
	or [created](/docs/Cloudant?topic=Cloudant-documents#create-document) a new document that includes the search index.

As soon as the search index design document exists and the index is built,
you can make queries by using it.

### General notes on functions in design documents
{: #general-notes-on-functions-in-design-documents}

Functions in design documents are run on multiple nodes for each document,
and might be run several times.
To avoid inconsistencies,
they need to be [idempotent](https://en.wikipedia.org/wiki/Idempotence#Computer_science_meaning){: new_window}{: external},
meaning they need to behave identically when run multiple times or on different nodes.
In particular,
you must not use functions that generate random numbers or return the current time.

## List functions
{: #list-functions}

Design documents with `options.partitioned` set to `true` can't contain a `lists` field.
{: tip}

Use list functions to customize the format of
[MapReduce](/docs/Cloudant?topic=Cloudant-using-views#using-views) query results.
A good example of their use is when you want to access {{site.data.keyword.cloudant_short_notm}} directly from a browser,
and need data to be returned in a different format,
such as HTML.

You can add any query parameters to the request that would normally be used for a view request.

Instead of using a MapReduce index, you can also use `_all_docs`.

The result of a list function isn't stored. This fact means that the function is executed every time that a request is made. As a consequence,
it's more efficient to use MapReduce functions. For web and mobile applications, consider whether any computations that are done in a list function would be better placed in the application tier.
{: note}

When you define a list function,
you use it by sending a `GET` request to
`https://$ACCOUNT.cloudant.com/$DATABASE/_design/$DDOC/_list/$LIST_FUNCTION/$MAPREDUCE_INDEX`.

This request includes the following functions:

*	`$LIST_FUNCTION` is the name of list function you defined.
*	`$MAPREDUCE_INDEX` is the name of the index that provides the query results that you want to format.

List functions require two arguments:
[`head`](#head) and [`req`](#req).

The `head` argument identifies the documents to be processed by the list function.

The `req` argument includes more information about the request. With this argument, you can create list functions that are more dynamic
because they're based on multiple factors such as query parameters or the user context.

The values within the `req` argument are described in  [Retrieve a design document](/apidocs/cloudant#getdesigndocument){: new_window}{: external} in the Response section under Filters.

See the following example design document that references a list function, expressed by using JSON:

```json
{
	"_id": "_design/list_example",
	"lists": {
		"FUNCTION_NAME": "function (head, req) { ... }"
	}
}
```
{: codeblock}

See the following example of a list function in pseudocode:

```javascript
function (head, req) {
	// specify our headers
	start({
		headers: {
			"Content-Type": 'text/html'
		}
	});

	// send the response, line by line
	send('<html><body><table>');
	send('<tr><th>ID</th><th>Key</th><th>Value</th></tr>')
	while(row = getRow()){
		send(''.concat(
			'<tr>',
			'<td>' + toJSON(row.id) + '</td>',
			'<td>' + toJSON(row.key) + '</td>',
			'<td>' + toJSON(row.value) + '</td>',
			'</tr>'
		));
	}
	send('</table></body></html>');
}
```
{: codeblock}

See the following example invocation of a list function by using HTTP:

```http
GET /$DATABASE/$DESIGN_ID/_list/$LIST_FUNCTION/$MAPREDUCE_INDEX HTTP/1.1
```
{: codeblock}

See the following example invocation of a list function by using the command line:

```sh
curl "https://$ACCOUNT.cloudant.com/$DATABASE/$DESIGN_ID/_list/$LIST_FUNCTION/$MAPREDUCE_INDEX"
```
{: codeblock}

<!--

_Example invocation of a list function by using Javascript:_

```javascript
var nano = require('nano');
var account = nano("https://"+$ACCOUNT+":"+$PASSWORD+"@"+$ACCOUNT+".cloudant.com");
var db = account.use($DATABASE);

db.view_with_list($DESIGN_ID, $MAPREDUCE_INDEX, $LIST_FUNCTION, function (err, body, headers) {
	if (!err) {
		console.log(body);
	}
});
```
{: codeblock}

-->

### `head`
{: #head}

Field        | Description
-------------|-------------
`offset`     | Offset where the document list started.
`total_rows` | Number of documents in the view.
{: caption="Table 6. Fields for the `head` argument" caption-side="top"}


### `req`
{: #req}

Field            | Description
-----------------|-------------
`body`           | Request body data as string. If the request method is `GET`, this field contains the value `undefined`. If the method is `DELETE` or `HEAD`, the value is "" (the empty string).
`cookie`         | Cookies object.
`form`           | Form data object. Contains the decoded body as key-value pairs if the Content-Type header was `application/x-www-form-urlencoded`.
`headers`        | Request headers object.
`id`             | Requested document ID string if it was specified or null otherwise.
`info`           | Database information.
`method`         | Request method as string or array. String value is one of the methods: `HEAD`, `GET`, `POST`, `PUT`, `DELETE`, `OPTIONS`, or `TRACE`. Alternatively, the method is represented as an array of character codes.
`path`           | List of requested path sections.
`peer`           | Request source IP address.
`query`          | URL query parameters object. Therefore, multiple keys aren't supported, the last duplicate key overrides the others.
`requested_path` | List of actual requested path section.
`raw_path`       | Raw requested path string.
`secObj`         | The database's [security object](/apidocs/cloudant#getdatabaseinformation){: new_window}{: external}.
`userCtx`        | Context about the currently authenticated user, specifically, their `name` and `roles` within the current database.
`uuid`           | A generated UUID.
{: caption="Table 7. Fields for the `req` argument" caption-side="top"}

## Show functions
{: #show-functions}

Design documents with `options.partitioned` set to `true` can't contain a `shows` field.
{: tip}

Show functions are similar to [list functions](#list-functions),
but are used to format individual documents.
They're used when you want to access {{site.data.keyword.cloudant_short_notm}} directly from a browser,
and need data to be returned in a different format,
such as HTML.

The result of a show function isn't stored. This fact means that the function is executed every time that a request is made. As a consequence,
[map functions](/docs/Cloudant?topic=Cloudant-views-mapreduce#a-simple-view) might be more efficient. For web and mobile applications, consider whether any computations that are done in a show function would be better placed in the application tier.
{: note}

Show functions require two arguments: `doc`, and [`req`](#req).

`doc` is the document that is requested by the show function.

The `req` argument includes more information about the request. With this argument, you can create show functions that are more dynamic
because they're based on multiple factors such as query parameters or the user context.

The `req` argument corresponds to the argument used in a list function.

When you define a show function,
you query it by sending a `GET` request to `https://$ACCOUNT.cloudant.com/$DATABASE/_design/$DDOC/_show/$SHOW_FUNCTION/$DOCUMENT_ID`,
where `$SHOW_FUNCTION` is the name of the function that is included in the design document `$DESIGN_ID`.

See the following example of a design document with a show function:

```json
{
	"_id": "_design/show_example",
	"shows": {
		"FUNCTION_NAME": "function (doc, req) { ... }"
	}
}
```
{: codeblock}

See the following example of a show function:

```javascript
function (doc, req) {
	if (doc) {
		return "Hello from " + doc._id + "!";
	} else {
		return "Hello, world!";
	}
}
```
{: codeblock}

See the following example of a show function query by using HTTP:

```http
GET /$DATABASE/$DESIGN_ID/_show/$SHOW_FUNCTION/$DOCUMENT_ID HTTP/1.1
Host: $ACCOUNT.cloudant.com
```
{: codeblock}

See the following example of a show function query by using the command line:

```sh
curl "https://$ACCOUNT.cloudant.com/$DATABASE/_design/$DDOC/_show/$SHOW_FUNCTION/$DOCUMENT_ID"
```
{: codeblock}

<!--

_Example of a show function query by using Javascript:_

```javascript
var nano = require('nano');
var account = nano("https://"+$ACCOUNT+":"+$PASSWORD+"@"+$ACCOUNT+".cloudant.com");
var db = account.use($DATABASE);

db.show($DESIGN_ID, $SHOW_FUNCTION, $DOCUMENT_ID, function (err, body) {
	if (!err) {
		console.log(body);
	}
});
```
{: codeblock}

-->

## Update handlers
{: #update-handlers}

Design documents with `options.partitioned` set to `true` can't contain an `updates` field.
{: tip}

Update handlers are custom functions that create or update a document.
They're used for tasks such as providing server-side modification timestamps,
and performing document updates to individual fields without the latest revision.

Update handlers require two arguments: `doc` and [`req`](#req).

If a document ID is provided in the request to the update handler,
then `doc` is the document corresponding to that ID.
If no ID is provided,
`doc` is `null`.

The `req` argument includes more information about the request. With this argument, you can create update handlers that are more dynamic
because they're based on multiple factors such as query parameters or the user context.

The `req` argument corresponds to the one used in a [list function](#list-functions).

Update handler functions must return an array of two elements.
The first element is the document to save,
or `null` if you don't want to save the document.
The second element is the response body.

Use the following methods to query update handlers:

Method | URL
-------|------
`POST` | `https://$ACCOUNT.cloudant.com/$DATABASE/_design/$DDOC/_update/$UPDATE_HANDLER`
`PUT`  | `https://$ACCOUNT.cloudant.com/$DATABASE/_design/$DDOC/_update/$UPDATE_HANDLER/$DOCUMENT_ID`
{: caption="Table 8. Methods that query update handlers" caption-side="top"}

The following variables are included: 

Variable          | Purpose
------------------|--------
`$DESIGN_ID`      | The ID of the document that defines the update handler.
`$DOCUMENT_ID`    | The ID of the document that the handler must work with.
`$UPDATE_HANDLER` | The name of the update handler.
{: caption="Table 9. Method variables" caption-side="top"}

See the following example of a design document with an update handler:

```json
{
	"_id": "_design/update_example",
	"updates": {
		"UPDATE_HANDLER_NAME": "function (doc, req) { ... }"
	}
}
```
{: codeblock}

See the following example of an update handler:

```javascript
function(doc, req){
	if (!doc){
		if ('id' in req && req.id){
			// create new document
			return [{_id: req.id}, 'New World']
		}
		// change nothing in database
		return [null, 'Empty World']
	}
	doc.world = 'hello';
	doc.edited_by = req.userCtx.name
	return [doc, 'Edited World!']
}
```
{: codeblock}

See the following example of an update handler query by using HTTP:

```http
POST /$DATABASE/$DESIGN_ID/_update/$UPDATE_HANDLER HTTP/1.1
Content-Type: application/json
```
{: codeblock}

See the following example of an update handler query by using the command line:

```sh
curl "https://$ACCOUNT.cloudant.com/$DATABASE/_design/$DDOC/_update/$UPDATE_HANDLER" \
	-X POST \
	-H "Content-Type: application/json" \
	-d "$JSON"
```
{: codeblock}

<!--

### Example of an update handler query, using Javascript

```javascript
var nano = require('nano');
var account = nano("https://"+$ACCOUNT+":"+$PASSWORD+"@"+$ACCOUNT+".cloudant.com");
var db = account.use($DATABASE);

db.atomic($DESIGN_ID, $UPDATE_HANDLER, $DOCUMENT_ID, $JSON, function (err, body) {
	if (!err) {
		console.log(body);
	}
});
```
{: codeblock}

-->

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

The `req` argument corresponds to the argument that is used in a [list function](#list-functions).

See the following example design document that includes a filter function:

```json
{
	"_id":"_design/FILTER_EXAMPLE",
	"filters": {
		"FILTER_EXAMPLE": "function (doc, req) { ... }"
	}
}
```
{: codeblock}

See the following example of a filter function:

```javascript
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

To apply a filter function to the changes feed,
include the `filter` parameter in the `_changes` query,
providing the name of the filter to use.

See the following example of a filter function applied to a `_changes` query by using HTTP:

```http
GET /$DATABASE/_changes?filter=$DESIGN_ID/$FILTER_FUNCTION HTTP/1.1
```
{: codeblock}

See the following example of a filter function applied to a `_changes` query by using the command line:

```sh
curl "https://$ACCOUNT.cloudant.com/$DATABASE/_changes?filter=$DESIGN_ID/$FILTER_FUNCTION"
```
{: codeblock}

The `req` argument gives you access to aspects of the HTTP request by using the `query` property.

See the following example of supplying a `req` argument by using HTTP:

```http
GET /$DATABASE/_changes?filter=$DESIGN_ID/$FILTER_FUNCTION&status=new HTTP/1.1
```
{: codeblock}

See the following example of supplying a `req` argument by using the command line:

```sh
curl "https://$ACCOUNT.cloudant.com/$DATABASE/_changes?filter=$DESIGN_ID/$FILTER_FUNCTION&status=new"
```
{: codeblock}

See the following example filter by using a supplied `req` argument:

```javascript
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

*	[`_design`](#the-_design-filter) - accepts only changes to design documents.
*	[`_doc_ids`](#the-_doc_ids-filter) - accepts only changes for documents whose ID is specified in the `doc_ids` parameter or supplied JSON document.
*	[`_selector`](#the-_selector-filter) - accepts only changes for documents that match a specified selector that is defined by using the same [selector syntax](/apidocs/cloudant#postfind){: new_window}{: external} as described in the Request section, which is used for [`_find`](/apidocs/cloudant#getdatabaseinformation){: new_window}{: external}.
*	[`_view`](#the-_view-filter) - with this function, you can use an existing [map function](/docs/Cloudant?topic=Cloudant-views-mapreduce#a-simple-view) as the filter.

#### The `_design` filter
{: #the-_design-filter}

The `_design` filter accepts changes only for design documents within the requested database.

The filter doesn't require any arguments.

Changes are listed for *all* the design documents within the database.

See the following example application of the `_design` filter by using HTTP:

```http
GET /$DATABASE/_changes?filter=_design HTTP/1.1
```
{: codeblock}

See the following example application of the `_design` filter by using the command line:

```sh
curl "https://$ACCOUNT.cloudant.com/$DATABASE/_changes?filter=_design"
```
{: codeblock}

See the following example response (abbreviated) after you apply the `_design` filter:

```json
{
    ...
    "results": [
        {
            "changes": [
                {
                    "rev": "10-304...4b2"
                }
            ],
            "id": "_design/ingredients",
            "seq": "8-g1A...gEo"
        },
        {
            "changes": [
                {
                  "rev": "123-6f7...817"
                }
            ],
            "deleted": true,
            "id": "_design/cookbook",
            "seq": "9-g1A...4BL"
        },
        ...
    ]
}
```
{: codeblock}

#### The `_doc_ids` filter
{: #the-_doc_ids-filter}

The `_doc-ids` filter accepts only changes for documents with specified IDs.
The IDs are specified in a `doc_ids` parameter,
or within a JSON document supplied as part of the original request.

See the following example application of the `_doc_ids` filter by using HTTP:

```http
POST /$DATABASE/_changes?filter=_doc_ids HTTP/1.1
```
{: codeblock}

See the following example application of the `_doc_ids` filter by using the command line:

```sh
curl "https://$ACCOUNT.cloudant.com/$DATABASE/_changes?filter=_doc_ids"
```
{: codeblock}

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
    "last_seq": "5-g1A...o5i",
    "pending": 0,
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

#### The `_selector` filter
{: #the-_selector-filter}

The `_selector` filter accepts only changes for documents that match a specified selector, which is defined by using the same [selector syntax](/docs/Cloudant?topic=Cloudant-query#selector-syntax) used
for [`_find`](/apidocs/cloudant#postfind){: new_window}{: external}.

For more examples that show use of this filter,
see the information on [selector syntax](/docs/Cloudant?topic=Cloudant-query#selector-syntax).

See the following example application of the `_selector` filter by using HTTP:

```http
POST /$DATABASE/_changes?filter=_selector HTTP/1.1
```
{: codeblock}

See the following example application of the `_selector` filter by using the command line:

```sh
curl "https://$ACCOUNT.cloudant.com/$DATABASE/_changes?filter=_selector"
```
{: codeblock}

See the following example JSON document that includes the selector expression to use during filtering:

```json
{
    "selector": {
        "_id": {
          "$regex": "^_design/"
        }
    }
}
```
{: codeblock}

See the following example response (abbreviated) after you filter by using a selector:

```json
{
    "last_seq": "11-g1A...OaA",
    "pending": 0,
    "results": [
        {
            "changes": [
                {
                  "rev": "10-304...4b2"
                }
            ],
            "id": "_design/ingredients",
            "seq": "8-g1A...gEo"
        },
        {
            "changes": [
                {
                  "rev": "123-6f7...817"
                }
            ],
            "deleted": true,
            "id": "_design/cookbook",
            "seq": "9-g1A...4BL"
        },
        {
            "changes": [
                {
                  "rev": "6-5b8...8f3"
                }
            ],
            "deleted": true,
            "id": "_design/meta",
            "seq": "11-g1A...Hbg"
        }
    ]
}
```
{: codeblock}

#### The `_view` filter
{: #the-_view-filter}

Using the `_view` filter, you can use an existing [map function](/docs/Cloudant?topic=Cloudant-views-mapreduce#a-simple-view) as the filter.

The map function might emit output as the result of processing a specific document. When this situation occurs, the filter considers the document that is allowed and includes it in the list of documents that you changed.

See the following example application of the `_view` filter by using HTTP:

```http
GET /$DATABASE/_changes?filter=_view&view=$DESIGNDOC/$VIEWNAME HTTP/1.1
```
{: codeblock}

See the following example application of the `_view` filter by using the command line:

```sh
curl "https://$ACCOUNT.cloudant.com/$DATABASE/_changes?filter=_view&view=$DESIGNDOC/$VIEWNAME"
```
{: codeblock}

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

Argument  | Purpose
----------|--------
`newDoc`  | The version of the document passed in the request.
`oldDoc`  | The version of the document currently in the database, or `null` if none exists.
`secObj`  | The [security object](/apidocs/cloudant#getsecurity){: new_window}{: external} for the database.
`userCtx` | Context regarding the currently authenticated user, such as `name` and `roles`.
{: caption="Table 10. Arguments for the update validator" caption-side="top"}

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

```javascript
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
design documents: [`_info`](#the-_info-endpoint) and [`_search_info`](#the-_search_info-endpoint).

### The `_info` endpoint
{: #the-_info-endpoint}

The `_info` endpoint returns information about a specific design document,
including the view index,
view index size,
and status of the design document and associated view index information.

-	`Method` - `GET /db/_design/design-doc/_info`
-	`Request` - None
-	`Response` - JSON that contains the design document information.
-	`Roles permitted` - `_reader`

See the following example of retrieving information about the `recipesdd` design document from within the `recipes` database by using HTTP:

```http
GET /recipes/_design/recipesdd/_info HTTP/1.1
```
{: codeblock}

See the following example of retrieving information about the `recipesdd` design document from within the `recipes` database by using the command line:

```sh
curl "https://$ACCOUNT.cloudant.com/recipes/_design/recipesdd/_info"
```
{: codeblock}

The JSON response includes the following individual fields:

-	`name` - Name or ID of design document.
-	`view_index` - View Index
	-	`compact_running` - Indicates whether a compaction routine runs on the view.
	-	`disk_size` - Size in bytes of the view as stored on disk.
	-	`language` - Language that is used for defining views.
	-	`purge_seq` - The purge sequence that was processed.
	-	`signature`	 - MD5 signature of the views for the design document.
	-	`update_seq` - The update sequence of the corresponding database that was indexed.
	-	`updater_running` - Indicates whether the view is being updated.
	-	`waiting_clients` - Number of clients that are waiting on views from this design document.
	-	`waiting_commit` - Indicates whether the underlying database has outstanding commits that need to process. 

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
{: #the-_search_info-endpoint}

The `_search_info` endpoint returns information about a specified search that is defined within a specific design document.

-	`Method` - `GET /db/_design/design-doc/_search_info/yourSearch`
-	`Request` - None
-	`Response` - JSON that contains information about the specified search.
-	`Roles permitted` - `_reader`

See the following example of getting information about the `description` search, which is defined within the `app` design document that is stored in the `foundbite` database, by using HTTP:

```http
GET /foundbite/_design/app/_search_info/description HTTP/1.1
```
{: codeblock}

See the following example of getting information about the `description` search, which is defined within the `app` design document that is stored in the `foundbite` database, by using the command line:

```sh
curl "https://$ACCOUNT.cloudant.com/foundbite/_design/app/_search_info/description"
```
{: codeblock}

The JSON structure includes the following individual fields:

-	`name` - Name or ID of the Search within the design document.
-	`search_index` - The Search Index
	-	`pending_seq` - The sequence number of changes in the database that reached the Lucene index,
		both in memory and on disk.
	-	`doc_del_count` - Number of deleted documents in the index.
	-	`doc_count` - Number of documents in the index.
	-	`disk_size` - The size of the index on disk, in bytes.
	-	`committed_seq` - The sequence number of changes in the database that were committed
		to the Lucene index on disk.

See the following example response in JSON format:

```json
{
	"name": "_design/app/description",
	"search_index": {
		"pending_seq": 63,
		"doc_del_count": 3,
		"doc_count": 10,
		"disk_size": 9244,
		"committed_seq": 63
	}
}
```
{: codeblock}
