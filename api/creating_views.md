---

copyright:
  years: 2015, 2018
lastupdated: "2018-03-07"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<div id="working-with-views"></div>

<div id="creating-views"></div>

# Views (MapReduce)

Views are used to obtain data stored within a database.
Views are written using Javascript functions.
{:shortdesc}

## View concepts

Views are mechanisms for working with document content in databases.
A view can selectively filter documents.
It can speed up searching for content.
It can be used to 'pre-process' the results before they are returned to the client.

Views are simply Javascript functions,
defined within the `view` field of a design document.
When you use a view,
or more accurately when you perform a query using your view,
the system applies the Javascript function to each and every document in the database.
Views can be complex.
You might choose to define a collection of Javascript functions to create the overall view required.

## A simple view

The simplest form of view is a map function.
The map function produces output data that represents an analysis (a mapping) of the documents stored within the database.

For example,
you might want to find out which employees have had some safety training,
and the date when that training was completed.
You could do this by inspecting each document,
looking for a field in the document called "training".
If the field is present,
the employee completed the training on the date recorded as the value.
If the field is not present,
the employee has not completed the training.

Using the `emit` function in a view function makes it easy to produce a list
in response to running a query using the view.
The list consists of key and value pairs,
where the key helps you identify the specific document and the value provides just the precise detail you want.
The list also includes metadata such as the number of key:value pairs returned.

>   **Note**: The document `_id` is automatically included in each of the key:value pair result records.
    This is to make it easier for the client to work with the results.

_Example of a simple view, using a map function:_

```javascript
function(employee) {
	if(employee.training) {
		emit(employee.number, employee.training);
	}
}
```
{:codeblock}

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
{:codeblock}

_Example response from running the simple view query:_

```json
{
	"total_rows": 2,
	"offset": 0,
	"rows": [
		{
			"id":"23598567",
			"number":"23598567",
			"training":"2014/05/21 10:00:00"
		},
		{
			"id":"42987103",
			"number":"42987103",
			"training":"2014/07/30 12:00:00"
		}
	]
}
```
{:codeblock}

## Map function examples

### Indexing a field

The following map function checks whether the object has a `foo` field,
and if so emits the value of this field.
This check allows you to query against the value of the `foo` field.

_Example of indexing a field:_

```javascript
function(doc) {
	if (doc.foo) {
		emit(doc._id, doc.foo);
	}
}
```
{:codeblock}

### An index for a one-to-many relationship

If the object passed to `emit` has an `_id` field,
a view query with `include_docs` set to `true` contains the document with the given ID.

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
{:codeblock}

### Complex Keys

Keys are not limited to simple values.
You can use arbitrary JSON values to influence sorting.

When the key is an array,
view results can be grouped by a sub-section of the key. 
For example,
if keys have the form `[year, month, day]`,
then results can be reduced to a single value or by year,
month,
or day.
See [Using Views](using_views.html) for more information.

## Reduce functions

If a view has a reduce function,
it is used to produce aggregate results for that view.
A reduce function is passed a set of intermediate values and combines them to a single value.
A reduce function must accept,
as input,
results emitted by its corresponding map function,
as well as results returned by the reduce function itself.
The latter case is referred to as a 'rereduce'.

Reduce functions are passed three arguments in the following order:

-	keys - an array of values.
-	values - an array of values.
-	rereduce - a boolean flag.

_Example of a reduce function:_

```javascript
function (keys, values, rereduce) {
	return sum(values);
}
```
{:codeblock}

Reduce functions must handle two cases:

1.	When `rereduce` is false:
	-	`keys` is an array whose elements are arrays of the form `[key, id]`,
		where `key` is a key emitted by the map function,
		and `id` identifies the document from which the key was generated.
	-	`values` is an array of the values emitted for the respective elements in `keys`,
		for example:
		`reduce([ [key1,id1], [key2,id2], [key3,id3] ], [value1,value2,value3], false)`

2.	When `rereduce` is true:
	-	`keys` is `null`.
	-	`values` is an array of values returned by previous calls to the reduce function,
		for example: `reduce(null, [intermediate1,intermediate2,intermediate3], true)`.

Reduce functions should return a single value,
suitable for both the `value` field of the final view,
and as a member of the `values` array passed to the reduce function.

Often,
reduce functions can be written to handle rereduce calls without any extra code,
like the summation function in the earlier example.
In such cases,
the `rereduce` argument can be ignored.

### Built-in reduce functions

For performance reasons,
a few simple reduce functions are built in.
Whenever possible,
you should use one of these functions instead of writing your own.

To use one of the built-in functions,
put its name into the `reduce` field of the view object in your design document.

Function | Description
---------|------------
`_count` | Produces the row count for a given key. The values can be any valid JSON.
`_stats` | Produces a JSON structure containing the sum, the count, the min, the max, and the sum squared values. All values must be numeric.
`_sum`   | Produces the sum of all values for a key. The values must be numeric.

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
                "reason": "The _sum function requires that map values be numbers, arrays of numbers, or objects. Objects cannot be mixed with other data structures. Objects can be arbitrarily nested, provided that the values for all fields are themselves numbers, arrays of numbers, or objects.",
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
{:codeblock}

## Map and reduce function restrictions

This section describes map and reduce function restrictions.

### Referential transparency

The map function must be referentially transparent. Referential transparency means that 
an expression can be replaced with the same value without changing the result, in this 
case, a document and a key/value pair. Because of this, 
{{site.data.keyword.cloudant_short_notm}} views can be updated 
incrementally and only reindex the delta since the last update.

### Commutative and associative properties

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

During the reduce and re-reduce phases, document partitioning is out of your control. 
Documents are randomly presented to the reduce function. This scenario explains the 
reduce and re-reduce phases. A subset is reduced to R1, and another subset is reduced 
to R2. Then R1 and R2 are 
re-reduced together to produce the final reduce value. In the extreme case, each of 
your documents can be reduced individually, and that reduce output is re-reduced 
together, which might happen as a single stage or in multiple stages.


It is best if you design your reduce and re-reduce function after this example:

<code>f(Key, Values) == f(Key, [ f(Key, Value0), f(Key, Value1), f(Key, Value2), ... ] )</code>


### Reduced value size

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

For more information, see the original article in the [CouchDB documentation ![External link icon](../images/launch-glyph.svg "External link icon")](https://wiki.apache.org/couchdb/Introduction_to_CouchDB_views#Restrictions_on_map_and_reduce_functions){:new_window}.

## Storing the view definition

Each view is a Javascript function.
Views are stored in design documents.
So,
to store a view,
we simply store the function definition within a design document.
A design document can be [created or updated](design_documents.html#creating-or-updating-a-design-document)
just like any other document.

To store a view definitions,
`PUT` the view definition content into a `_design` document.

In the following example,
the `hadtraining` view is defined as a map function,
and is available within the `views` field of the design document.

_Example of `PUT`ting a view into a design document called `training`,
using HTTP:_

```http
PUT /$DATABASE/_design/training HTTP/1.1
Content-Type: application/json
```
{:codeblock}

_Example of `PUT`ting a view into a design document called `training`,
using the command line:_

```sh
curl -X PUT https://$ACCOUNT:$PASSWORD@$ACCOUNT.cloudant.com/$DATABASE/_design/training --data-binary @view.def
	# where the design document is stored in the file `view.def`
```
{:codeblock}

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
{:codeblock}
