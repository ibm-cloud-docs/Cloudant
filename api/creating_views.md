---

copyright:
  years: 2015, 2019
lastupdated: "2019-02-20"

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

<!-- Acrolinx: 2019 -->

<div id="working-with-views"></div>

<div id="creating-views"></div>

# Views (MapReduce)
{: #views-mapreduce}

Views are used to obtain data stored within a database.
Views are written using Javascript functions.
{: shortdesc}

## View concepts
{: #view-concepts}

Views are mechanisms for working with document content in databases.
A view can selectively filter documents.
It can speed up searching for content.
It can be used to 'pre-process' the results before they are returned to the client.

Views are simply Javascript functions,
defined within the `views` field of a design document.
When you use a view,
or more accurately when you run a query by using your view,
the system applies the JavaScript function to every document in the database.
Views can be complex.
You might choose to define a collection of JavaScript functions to create the overall view that is required.

## View index partitioning type
{: #view-index-partitioning-type}

A view index will inherit the partitioning type from the `options.partitioned`
field of the design document that contains it.

## A simple view
{: #a-simple-view}

The simplest form of view is a map function.
The map function produces output data that represents an analysis (a mapping) of the documents that are stored within the database.

For example,
you might want to find out which employees had some safety training,
and the date when that training was completed.
You might do this by inspecting each document, and
looking for a field in the document called "training".
If the field is present,
the employee completed the training on the date recorded as the value.
If the field is not present,
the employee did not complete the training.

Using the `emit` function in a view function makes it easy to produce a list
in response to running a query by using the view.
The list consists of key and value pairs,
where the key helps you identify the specific document and the value provides just the precise detail you want.
The list also includes metadata such as the number of key:value pairs returned.

The document `_id` is automatically included in each of the key:value pair result records. The document `_id` is included to make it easier for the client to work with the results.
{: note}

_Example of a simple view by using a map function:_

```javascript
function(employee) {
	if(employee.training) {
		emit(employee.number, employee.training);
	}
}
```
{: codeblock}

_Sample data for demonstrating the simple view example:_

```json
[
    {
        "_id":"23598567",
        "number":"23598567",
        "training":"2014/05/21 10:00:00"
    },
    {
        "_id":"10278947",
        "number":"10278947"
    },
    {
        "_id":"42987103",
        "number":"42987103",
        "training":"2014/07/30 12:00:00"
    }
]
```
{: codeblock}

_Example response from running the simple view query:_

```json
{
  "total_rows": 2,
  "offset": 0,
  "rows": [
    {
      "id": "23598567",
      "key": "23598567",
      "value": "2014/05/21 10:00:00"
    },
    {
      "id": "42987103",
      "key": "42987103",
      "value": "2014/07/30 12:00:00"
    }
  ]
}
```
{: codeblock}

## Map function examples
{: #map-function-examples}

The following sections describe indexing, complex keys, and reduce functions.

Your indexing functions operate in a memory-constrained environment where the document itself forms a part of the memory that is used in that environment. Your code's stack and document must fit inside this memory. Documents are limited to a maximum size of 64 MB.

### Indexing a field
{: #indexing-a-field}

The following map function checks whether the object has a `foo` field,
and if so emits the value of this field.
With this check, you can query against the value of the `foo` field.

_Example of indexing a field:_

```javascript
function(doc) {
	if (doc.foo) {
		emit(doc._id, doc.foo);
	}
}
```
{: codeblock}

### An index for a one-to-many relationship
{: #an-index-for-a-one-to-many-relationship}

If the object passed to `emit` has an `_id` field,
a view query with `include_docs` set to `true` contains the document with the specific ID.

_Example of indexing a one-to-many relationship:_

```javascript
function(doc) {
	if (doc.friends) {
		for (friend in friends) {
			emit(doc._id, { "_id": friend });
		}
	}
}
```
{: codeblock}

### Complex Keys
{: #complex-keys}

Keys are not limited to simple values.
You can use arbitrary JSON values to influence sorting.

When the key is an array,
view results can be grouped by a subsection of the key. 
For example,
if keys have the form `[year, month, day]`,
then results can be reduced to a single value or by year,
month,
or day.

For more information, see [Using Views](/docs/services/Cloudant/api/using_views.html).

## Reduce functions
{: #reduce-functions}

Design documents with `partitioned` set to `true` cannot contain JavaScript reduce functions, only built-ins.
{: tip}

Design documents with `options.partitioned` set to `true` cannot contain JavaScript reduce functions, only built-ins.
{: tip}

If a view has a reduce function,
it is used to produce aggregate results for that view.
A reduce function is passed a set of intermediate values and combines them to a single value.
A reduce function must accept,
as input,
results emitted by its corresponding map function,
as well as results returned by the reduce function itself.
The latter case is referred to as a 'rereduce'.

Reduce functions are passed three arguments in the following order:

-	keys
-	values
-	rereduce

A description of the reduce functions follows below.

_Example of a reduce function:_

```javascript
function (keys, values, rereduce) {
	return sum(values);
}
```
{: codeblock}

Reduce functions must handle two cases:

1.	When `rereduce` is false:
	-	`keys` is an array whose elements are arrays of the form `[key, id]`,
		where `key` is a key that is emitted by the map function,
		and `id` identifies the document from which the key was generated.
	-	`values` is an array of the values that are emitted for the respective elements in `keys`,
		for example:
		`reduce([ [key1,id1], [key2,id2], [key3,id3] ], [value1,value2,value3], false)`

2.	When `rereduce` is true:
	-	`keys` is `null`.
	-	`values` is an array of the values that are returned by previous calls to the reduce function,
		for example: `reduce(null, [intermediate1,intermediate2,intermediate3], true)`.

Reduce functions must return a single value,
suitable for both the `value` field of the final view,
and as a member of the `values` array that is passed to the reduce function.

Often,
reduce functions can be written to handle rereduce calls without any extra code,
like the summation function in the earlier example.
In such cases,
the `rereduce` argument can be ignored.

### Built-in reduce functions
{: #built-in-reduce-functions}

For performance reasons,
a few simple reduce functions are built in.
Whenever possible,
you must use one of these functions instead of writing your own.

To use one of the built-in functions,
put its name into the `reduce` field of the view object in your design document.

Function | Description
---------|------------
`_count` | Produces the row count for a specific key. The values can be any valid JSON.
`_stats` | Produces a JSON structure that contains the sum, the count, the min, the max, and the sum-squared values. All values must be numeric.
`_sum`   | Produces the sum of all values for a key. The values must be numeric.
`_approx_count_distinct` | Approximates the number of distinct keys in a view index using a variant of the [HyperLogLog][hl] algorithm.

[hl]: https://en.wikipedia.org/wiki/HyperLogLog

By feeding the results of `reduce` functions back into the `reduce` function,
MapReduce is able to split up the analysis of huge data sets into discrete,
parallel tasks,
which can be completed much faster.

When you use the built-in reduce function, if the input is invalid, the `builtin_reduce_error` error is
returned. More detailed information about the failure is provided in the `reason` field. The
original data that caused the error is returned in the `caused_by` field.

_Example of the reply:_

```json
{
    "rows": [
        {
            "key": null,
            "value": {
                "error": "builtin_reduce_error",
                "reason": "The _sum function requires that map values be numbers, arrays of numbers, or objects. Objects cannot be mixed with other data structures. Objects can be arbitrarily nested, if the values for all fields are themselves numbers, arrays of numbers, or objects.",
                "caused_by": [
                    {
                        "a": 1
                    },
                    {
                        "a": 2
                    },
                    {
                        "a": 3
                    },
                    {
                        "a": 4
                    }
                ]
            }
        }
    ]
}
```
{: codeblock}

## Map and reduce function restrictions
{: #map-and-reduce-function-restrictions}

This section describes map and reduce function restrictions.

### Referential transparency
{: #referential-transparency}

The map function must be referentially transparent. Referential transparency means that
an expression can be replaced with the same value without changing the result, in this
case, a document and a key/value pair. Because of this,
{{site.data.keyword.cloudant_short_notm}} views can be updated
incrementally and only reindex the delta since the last update.

### Commutative and associative properties
{: #commutative-and-associative-properties}

In addition to referential transparency, the reduce function must also have commutative
and associative properties for the input. This makes it possible for the MapReduce
function to reduce its own output and produce the same response, for example:

<code>f(Key, Values) == f(Key, [ f(Key, Values) ] )</code>

As a result, {{site.data.keyword.cloudant_short_notm}} can store intermediate
results to the inner nodes of the
B-tree indexes. These
restrictions also makes it possible for indexes to spread across machines and reduce
at query time.

### Document partitioning
{: #document-partitioning}

Due to sharding, there are
no guarantees that the output of any two specific map functions will be passed to
the same instance of a reduce call, so you should not rely on any ordering. Your
reduce function must consider all the values passed to it and return the correct
answer irrespective of ordering. Cloudant is also guaranteed to call your reduce
function with `rereduce=true` at query time even if it did not need to do so when
building the index, so it is essential that your function works correctly in that
case (`rereduce=true` means that the keys parameter is `null` and the values array is
filled with results from previous reduce function calls).

### Reduced value size
{: #reduced-value-size}

{{site.data.keyword.cloudant_short_notm}} computes view indexes and the
corresponding reduce values then caches
these values inside each of the B-tree node pointers. Now,
{{site.data.keyword.cloudant_short_notm}} can reuse
reduced values when updating the B-tree. You must pay attention to the amount
of data that is returned from reduce functions.

It is best that the size of your returned data set stays small and grows no
faster than `log(num_rows_processed)`. If you ignore this restriction,
{{site.data.keyword.cloudant_short_notm}} does not automatically throw an error,
but B-tree performance degrades
dramatically. If your view works correctly with small data sets but quits
working when more data is added, you might have violated the growth rate
characteristic restriction.

### Execution environment
{: #execution-environment}

Your indexing functions operate in a memory-constrained environment where the document itself forms a part of the memory that is used in that environment. Your code's stack and document must fit inside this memory. Documents are limited to a maximum size of 64 MB.

### No JavaScript reducers when `options.partitioned` is `true`
{: #no-javascript-reducers-when-options.partitioned-is-true-}

Design documents with `options.partitioned` set to `true` cannot contain JavaScript
reduce functions, only built-ins Erlang reducers such as `_stats`.

## Storing the view definition
{: #storing-the-view-definition}

Each view is a JavaScript function.
Views are stored in design documents.
So,
to store a view,
we simply store the function definition within a design document.
A design document can be [created or updated](/docs/services/Cloudant/api/design_documents.html#creating-or-updating-a-design-document)
just like any other document.

To store a view definition,
`PUT` the view definition content into a `_design` document.

In the following example,
the `hadtraining` view is defined as a map function,
and is available within the `views` field of the design document.

_Example of `PUT`ting a view into a design document called `training` by using HTTP:_

```http
PUT /$DATABASE/_design/training HTTP/1.1
Content-Type: application/json
```
{: codeblock}

_Example of `PUT`ting a view into a design document called `training` by using the command line:_

```sh
curl -X PUT https://$ACCOUNT:$PASSWORD@$ACCOUNT.cloudant.com/$DATABASE/_design/training --data-binary @view.def
	# where the design document is stored in the file `view.def`
```
{: codeblock}

_Example view definition:_

```json
{
	"views" : {
		"hadtraining" : {
			"map" : "function(employee) { if(employee.training) { emit(employee.number, employee.training); } }"
		}
	}
}
```
{: codeblock}
