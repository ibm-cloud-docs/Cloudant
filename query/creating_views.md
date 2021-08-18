---

copyright:
  years: 2015, 2021
lastupdated: "2021-08-03"

keywords: concepts, index partitioning type, simple view, complex keys, reduce functions, built-in reduce functions, referential transparency, commutative and associative properties, document partitioning, reduced value size, execution environment, example, map function, view definition

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

<!-- Acrolinx: 2021-04-13 -->

# Views (MapReduce)
{: #views-mapreduce}

Views are used to obtain data stored within a database.
Views are written by using JavaScript functions. Learn more about the simplest view, reduce functions, map and reduce function restrictions, and storing a view definition. Plus, see the examples that are provided. 
{: shortdesc}

In this documentation, when a feature, or an aspect of a feature, applies only to Transaction Engine, you see this tag ![TXE tag](../images/txe_icon.svg).
{: important}

## View concepts
{: #view-concepts}

Views are mechanisms for working with document content in databases.
A view can selectively filter documents and speed up searching for content.
It can be used to "pre-process" the results before they're returned to the client.

Views are simply JavaScript functions, which are defined within the `views` field of a design document.
When you use a view,
or more accurately when you run a query by using your view,
the system applies the JavaScript function to every document in the database.
Views can be complex.
You might choose to define a collection of JavaScript functions to create the overall view that is required.

## View index partitioning type
{: #view-index-partitioning-type}

A view index inherits the partitioning type from the `options.partitioned`
field of the design document that contains it.

## A simple view
{: #a-simple-view}

The simplest form of view is a map function.
The map function produces output data that represents an analysis (a mapping) of the documents that are stored within the database.

For example,
you might want to find out which employees had some safety training,
and the date when that training was completed.
You might find this information by inspecting each document, and
looking for a field in the document called "training".
If the field is present,
the employee completed the training on the date that is recorded as the value.
If the field isn't present,
the employee didn't complete the training.

Using the `emit` function in a view function makes it easy to produce a list
in response to running a query by using the view.
The list consists of key and value pairs,
where the key helps you identify the specific document and the value provides just the precise detail you want.
The list also includes metadata such as the number of `key:value` pairs returned.

The document `_id` is automatically included in each of the `key:value` pair result records. The document `_id` is included to make it easier for the client to work with the results.
{: note}

See an example of a simple view by using a map function:

```javascript
function(employee) {
	if(employee.training) {
		emit(employee.number, employee.training);
	}
}
```
{: codeblock}

See sample data for demonstrating the simple view example:

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

See an example response from running the simple view query:

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

See an example of indexing a field:

```javascript
function(doc) {
	if (doc.foo) {
		emit(doc.foo);
	}
}
```
{: codeblock}

### An index for a one-to-many relationship
{: #an-index-for-a-one-to-many-relationship}

If the object passed to `emit` has an `_id` field,
a view query with `include_docs` set to `true` contains the document with the specific ID.

See an example of indexing a one-to-many relationship:

```javascript
function(doc) {
	if (doc.friends) {
		for (friend in doc.friends) {
			emit(doc._id, { "_id": friend });
		}
	}
}
```
{: codeblock}

### Complex keys
{: #complex-keys}

Keys aren't limited to simple values.
You can use arbitrary JSON values to influence sorting.

When the key is an array,
view results can be grouped by a subsection of the key. 
For example,
if keys have the form `[year, month, day]`,
then results can be reduced to a single value or by year,
month,
or day.

For more information, see [Using views](/docs/Cloudant?topic=Cloudant-using-views#using-views).

## Reduce functions
{: #reduce-functions}

Design documents with `options.partitioned` set to `true` can't contain custom JavaScript reduce functions. Only built-in reduces are allowed. 
{: tip}

### No reducer
{: #no-reducer}

A view definition inside a design document is permitted to have no reduce attribute, indicating that no query-time aggregation is performed.

```json
{
    "views" : {
        "hadtraining" : {
            "map" : "function(employee) { if(employee.training) { emit(employee.number); } }"
        }
    }
}
```
{: codeblock}

The previous map function generates a secondary index suitable for selection only. The index is always ordered by the key (the emit function's first parameter) - in this case `employee.number`. This view is ideal for fetching documents by a known employee number or ranges of employee numbers.

### Built-in reduce functions
{: #built-in-reduce-functions}

For performance reasons,
a few simple reduce functions are built in.
Whenever possible,
you must use one of these functions instead of writing your own.

To use one of the built-in functions,
put the name into the `reduce` field of the view object in your design document.

```json
{
    "views" : {
        "sumSalary" : {
            "map" : "function(doc) {  emit(doc.department, doc.salary); }",
	    "reduce": "_sum"
        }
    }
}
```
{: codeblock}

The previous MapReduce view creates an index that is keyed on the employee department and whose value is the employee's salary. As the reducer is `_sum`, the view outputs the total salaries for the selection of data queried. It is suitable for calculating the total salaries of all employees, the total salaries of a single department or salary totals grouped by department.

The numeric reducers `_stats`/`_sum` act upon the value (the emit function's second parameter) which can be a number, array, or object. Consider the following MapReduce definition:

```json
{
    "views" : {
        "statsReadingsObject" : {
            "map" : "function(doc) {  emit(doc.date, { price: doc.price, tax: doc.tax }); }",
	    "reduce": "_sum"
        }
    }
}
```
{: codeblock}

The view is keyed on a sale's date, and the value is an object that contains two values: price and tax. The `_sum` reduce calculates totals for each attribute of the object that it finds:

```json
{"rows":[
{"key":null,"value":{"tax":7.32,"price":157.25}}
]}
```
{: codeblock}

Or add `?group=true` when querying the view. The output is grouped and summed by a unique key, in this case, `date`:

```json
{"rows":[
{"key":"2020-06-25","value":{"price":49.75,"tax":4.56}},
{"key":"2020-06-26","value":{"price":51.25,"tax":1.62}},
{"key":"2020-06-27","value":{"price":56.25,"tax":1.14}}
]}
```
{: codeblock}

The numeric reducers also calculate multiple reductions when the value of an index is an array of numbers:

```json
{
    "views" : {
        "statsReadingsArray" : {
            "map" : "function(doc) { emit(doc.date, [doc.temperature, doc.pressure]); }",
	    "reduce": "_stats"
        }
    }
}
```
{: codeblock}

The previous definition calculates statistics on the numerical values it finds in the array that is emitted as the index's value. The values are returned as an array in the same order as supplied in the map function:

```json
{"rows":[
{"key":"2020-06-25","value":[{"sum":49.75,"count":3,"min":15.25,"max":17.25,"sumsqr":827.6875},{"sum":4.56,"count":3,"min":1.42,"max":1.62,"sumsqr":6.9512}]},
{"key":"2020-06-26","value":[{"sum":51.25,"count":1,"min":51.25,"max":51.25,"sumsqr":2626.5625},{"sum":1.62,"count":1,"min":1.62,"max":1.62,"sumsqr":2.6244}]},
{"key":"2020-06-27","value":[{"sum":56.25,"count":1,"min":56.25,"max":56.25,"sumsqr":3164.0625},{"sum":1.14,"count":1,"min":1.14,"max":1.14,"sumsqr":1.2996}]}
]}

```
{: codeblock}

The `_count` reducer simply counts the number of `key-value` pairs that are emitted into the index.

```json
{"rows":[
{"key":"2020-06-25","value":3},
{"key":"2020-06-26","value":1},
{"key":"2020-06-27","value":1}
]}
```
{: codeblock}

The `_approx_count_distinct_reducer` acts upon the _key_ of the index, as opposed to the numeric reducers that act upon the index's _value_.

```json
{"rows":[
{"key":null,"value":3685292}
]}
```
{: codeblock}

Function | Description
---------|------------
`_count` | Produces the row count for a specific key. The values can be any valid JSON.
`_stats` | Produces a JSON structure that contains the sum, the count, the min, the max, and the sum-squared values. All values must be numeric.
`_sum`   | Produces the sum of all values for a key. The values must be numeric.
`_approx_count_distinct` | Approximates the number of distinct keys in a view index by using a variant of the [HyperLogLog](https://en.wikipedia.org/wiki/HyperLogLog){: new_window}{: external} algorithm.
{: caption="Table 1. Built-in reduce functions" caption-side="top"}


## Custom reduce functions
{: #custom-reduce-functions}

Most customers find that built-in reducers are sufficient to perform aggregations on the view `key-value` pairs emitted from their Map functions. However, for unusual use-cases, a JavaScript reduce function can be supplied instead of the name of one of the built-in reducers. 

Custom JavaScript reduce functions are not supported on Transaction Engine. ![TXE tag](../images/txe_icon.svg)

Reduce functions are passed three arguments in the following order:

-	`keys`
-	`values`
-	`rereduce`

If a view has a custom JavaScript reduce function,
it is used to produce aggregate results for that view.
A reduce function is passed a set of intermediate values and combines them to a single value.
A reduce function must accept,
as input,
results emitted by its corresponding map function,
as well as results returned by the reduce function itself.
The latter case is referred to as a "rereduce".

A description of the reduce functions is shown in the following example.

See the following example of a custom reduce function:

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
		`reduce([ [key1,id1], [key2,id2], [key3,id3] ], [value1,value2,value3], false)`.

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

By feeding the results of `reduce` functions back into the `reduce` function,
MapReduce can split up the analysis of huge data sets into discrete,
parallel tasks,
which can be completed much faster.

When you use the built-in reduce function, if the input is invalid, the `builtin_reduce_error` error is
returned. More detailed information about the failure is provided in the `reason` field. The
original data that caused the error is returned in the `caused_by` field.


See an example reply:

```json
{
    "rows": [
        {
            "key": null,
            "value": {
                "error": "builtin_reduce_error",
                "reason": "The _sum function requires that map values be numbers, arrays of numbers, or objects. Objects can't be mixed with other data structures. Objects can be arbitrarily nested, if the values for all fields are themselves numbers, arrays of numbers, or objects.",
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

Map and reduce function restrictions are described here.

Custom JavaScript reduce functions are not supported on Transaction Engine. ![TXE tag](../images/txe_icon.svg)

### Referential transparency
{: #referential-transparency}

The map function must be referentially transparent. Referential transparency means that
an expression can be replaced with the same value without changing the result, in this
case, a document, and a `key-value` pair. Because of referential transparency,
{{site.data.keyword.cloudant_short_notm}} views can be updated
incrementally and reindex only the delta since the last update.

### Commutative and associative properties
{: #commutative-and-associative-properties}

In addition to referential transparency, the reduce function must also have commutative
and associative properties for the input. These properties make it possible for the MapReduce
function to reduce its own output and produce the same response, for example:

`f(Key, Values) == f(Key, [ f(Key, Values) ] )`

As a result, {{site.data.keyword.cloudant_short_notm}} can store intermediate
results to the inner nodes of the
B-tree indexes. These
restrictions also make it possible for indexes to spread across machines and reduce
at query time.

### Document partitioning
{: #document-partitioning}

Due to sharding, {{site.data.keyword.cloudant_short_notm}} offers no guarantees that the output of any two specific map functions passes to
the same instance of a reduce call. You must not rely on any ordering. The
reduce function that you use must consider all the values that are passed to it and return the correct
answer irrespective of ordering. {{site.data.keyword.cloudant_short_notm}} is also guaranteed to call your reduce
function with `rereduce=true` at query time even if it didn't need to do so when
it built the index. It's essential that your function works correctly in that
case (`rereduce=true` means that the keys parameter is `null` and the values array is
filled with results from previous reduce function calls).

### Reduced value size
{: #reduced-value-size}

{{site.data.keyword.cloudant_short_notm}} computes view indexes and the
corresponding reduce values then caches
these values inside each of the B-tree node pointers. Now,
{{site.data.keyword.cloudant_short_notm}} can reuse
reduced values when it updates the B-tree. You must pay attention to the amount
of data that is returned from reduce functions.

It's best that the size of your returned data set stays small and grows no
faster than `log(num_rows_processed)`. If you ignore this restriction,
{{site.data.keyword.cloudant_short_notm}} does not automatically throw an error,
but B-tree performance degrades
dramatically. If your view works correctly with small data sets but quits
working when more data is added, your view might violate the growth rate
characteristic restriction.

### Execution environment
{: #execution-environment}

Your indexing functions operate in a memory-constrained environment where the document itself forms a part of the memory that is used in that environment. Your code's stack and document must fit inside this memory. Documents are limited to a maximum size of 64 MB.

### No JavaScript reducers when `options.partitioned` is `true`
{: #no-javascript-reducers-when-options.partitioned-is-true-}

Design documents with `options.partitioned` set to `true` can't contain JavaScript
reduce functions, only built-ins Erlang reducers such as `_stats`.

## Storing the view definition
{: #storing-the-view-definition}

Each view is a JavaScript function.
Views are stored in design documents.
So,
to store a view,
{{site.data.keyword.cloudant_short_notm}} simply stores the function definition within a design document.
A design document can be [created or updated](/docs/Cloudant?topic=Cloudant-design-documents#creating-or-updating-a-design-document)
just like any other document.

To store a view definition,
`PUT` the view definition content into a `_design` document.

In the following example,
the `hadtraining` view is defined as a map function,
and is available within the `views` field of the design document.

See an example that uses `PUT` to add a view into a design document that is called `training` by using HTTP:

```http
PUT /$DATABASE/_design/training HTTP/1.1
Content-Type: application/json
```
{: codeblock}

See an example that uses `PUT` to add a view into a design document that is called `training` by using the command line:

```sh
curl -X PUT "https://$ACCOUNT:$PASSWORD@$ACCOUNT.cloudant.com/$DATABASE/_design/training" --data-binary @view.def
	# where the design document is stored in the file `view.def`
```
{: codeblock}

See an example view definition:

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
