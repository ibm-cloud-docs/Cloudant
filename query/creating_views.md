---

copyright:
  years: 2015, 2023
lastupdated: "2023-02-01"

keywords: concepts, index partitioning type, simple view, complex keys, reduce functions, built-in reduce functions, referential transparency, commutative and associative properties, document partitioning, reduced value size, execution environment, example, map function, view definition

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# Creating Views (MapReduce)
{: #creating-views-mapreduce}

Views are used to obtain data stored within a database. Within views, you use reduce functions, map and reduce functions, and storing a view definition.
{: shortdesc}

Learn more about the simplest view, reduce functions, map and reduce function restrictions, and storing a view definition. Plus, see the examples that are provided. Views are written by using JavaScript.

## View concepts
{: #view-concepts}

Views are mechanisms for working with document content in databases.
A view can selectively filter documents and speed up the search for content.
It can be used to pre-process the results before they're returned to the client.

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
you might want to find out which user completed the online registration and has a verified email to contact.
You might find this information by inspecting each document, and
looking for a field in the document called "email_verified" and getting the value of "email".
If the field is present and has the value `true`,
it means the user completed the registration, and you can contact them by email.
If the field isn't present or has a value of something else than `true`,
the user didn't complete the registration.

Using the `emit` function in a view function makes it easy to produce a list
in response to running a query by using the view.
The list consists of key and value pairs,
where the key helps you identify the specific document and the value provides just the precise detail you want.
The list also includes metadata such as the number of `key:value` pairs returned.

The document `_id` is automatically included in each of the `key:value` pair result records. The document `_id` is included to make it easier for the client to work with the results.
{: note}

See an example of a simple view by using a map function:

```javascript
function(user) {
  if(user.email_verified === true) {
    emit(user.email, {name: user.name, email_verified: user.email_verified, joined: user.joined});
  }
}
```
{: codeblock}

See sample data for demonstrating the simple view example:

```json
[
    {
        "_id":"abc123",
        "name": "Bob Smith",
        "email": "bob.smith@aol.com",
        "email_verified": true,
        "joined": "2019-01-24T10:42:59.000Z"
    },
    {
        "_id":"abc125",
        "name": "Amelie Smith",
        "email": "amelie.smith@aol.com",
        "email_verified": true,
        "joined": "2020-04-24T10:42:59.000Z"
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
      "id": "abc125",
      "key": "amelie.smith@aol.com",
      "value": {
        "name": "Amelie Smith",
        "email_verified": true,
        "joined": "2020-04-24T10:42:59.000Z"
      }
    },
    {
      "id": "abc123",
      "key": "bob.smith@aol.com",
      "value": {
        "name": "Bob Smith",
        "email_verified": true,
        "joined": "2019-01-24T10:42:59.000Z"
      }
    }
  ]
}
```
{: codeblock}

## Map function examples
{: #map-function-examples}

The definition of a view within a design document also creates an index based on the key information. 
The production and use of the index significantly increases the speed of access and searching or selecting documents from the view.

The following sections describe indexing with simple and complex keys, and reduce functions. 

Your indexing functions work in a memory-constrained environment where the document forms part of the memory used in the environment. Your code's stack and document must fit within the memory. We limit documents to a maximum size of 64 MB.

### Indexing a field
{: #indexing-a-field}

The following map function checks whether the object has a `name` field,
and if so emits the value of this field.
With this check, you can query against the value of the `name` field.

See an example of indexing a field:

```javascript
function(doc) {
  if (doc.name) {
    emit("name", doc.name);
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
    "views": {
        "getVerifiedEmails": {
            "map": "function(user) { if(user.email_verified === true) { emit(user.email); } }"
        }
    }
}
```
{: codeblock}

The previous map function generates a secondary index suitable for selection only. The index is always ordered by the key (the emit function's first parameter) - in this case `user.email`. This view is ideal for fetching documents by a known user email or ranges of users email addresses.

### Built-in reduce functions
{: #built-in-reduce-functions}

For performance reasons,
a few simple reduce functions are built in.
Whenever possible,
you must use one of these functions instead of writing your own.

To use one of the built-in functions,
put the reducer's name into the `reduce` field of the view object in your design document.

#### Count reducer
{: #built-in-reduce-functions-count-reducer}

The `_count` reducer counts a MapReduce view's rows and optionally groups the counts by distinct keys.

```json
{
    "views": {
        "teamCount": {
            "map": "function(doc) { if (doc.email_verified === true) { emit(doc.team, doc.name); } }",
            "reduce": "_count"
        }
    }
}
```
{: codeblock}

The previous MapReduce view creates an index that is keyed on the `team` the user belongs to, but only includes those with a verified email address. As the reducer is `_count`, the view outputs the number of rows in the view e.g the number of verified users in the database.

```json
{"rows":[
{"key":null,"value":10010}
]}
```
{: codeblock}

By adding `?group=true`, the counts are grouped by distinct keys so the database outputs counts by team membership:

```json
{"rows":[
{"key":"blue","value":1409},
{"key":"green","value":1439},
{"key":"indigo","value":1425},
{"key":"orange","value":1432},
{"key":"red","value":1414},
{"key":"violet","value":1443},
{"key":"yellow","value":1448}
]}
```
{: codeblock}

Switching the reducer off allows the same view to be used for selection of a single team's members `?key="orange"&reduce=false&limit=5`:

```json
{"total_rows":10010,"offset":4273,"rows":[
{"id":"783173e102613c78d02a2b3304001642","key":"orange","value":"Bethel Lusk"},
{"id":"783173e102613c78d02a2b3304001b40","key":"orange","value":"Ethyl Dionne"},
{"id":"783173e102613c78d02a2b3304009c66","key":"orange","value":"Fredda Hendrix"},
{"id":"783173e102613c78d02a2b330401800d","key":"orange","value":"Bibi Page"},
{"id":"783173e102613c78d02a2b3304018ae7","key":"orange","value":"Marylou Lavender-Milton"}
]}
```
{: codeblock}

#### Sum reducer
{: #built-in-reduce-functions-sum-reducer}

The `_sum` reducer totalizes a MapReduce view's emitted numeric values. The view's value can be a number, an array of numbers, or an object containing numeric values. Consider the following MapReduce definition on a database of products:

```json
{
    "views": {
        "productPrices": {
            "map": "function(doc) {  emit(doc.type, { price: doc.price, tax: doc.tax }); }",
            "reduce": "_sum"
        }
    }
}
```
{: codeblock}

The view is keyed on the type of the product, and the value is an object that contains two values: `price` and `tax`. The `_sum` reducer calculates totals for both the `price` and `tax` values across the view:

```json
{"rows":[
    {"key":null,"value":{"price":144.97, "tax":7.32}}
]}
```
{: codeblock}

By adding `?group=true` when querying the view, the output is grouped and summed by a unique key, in this case, the product type:

```json
{"rows":[
    {"key":"kitchen","value":{"price":14.99,"tax":1.14}},
    {"key":"garden","value":{"price":129.98,"tax":6.18}}
]}
```
{: codeblock}

#### Stats reducer
{: #built-in-reduce-functions-stats-reducer}

Like the `_sum` reducer, the `_stats` reducer works on numbers, objects with numeric values or arrays of numbers, returning counts, sums, minimum & maximum values and a sum of the square of the values, which is useful for variance or standard deviation calculations:

```json
{
    "views": {
        "salesByDate": {
            "map": "function(doc) { emit(doc.date, [doc.price, doc.tax]); }",
            "reduce": "_stats"
        }
    }
}
```
{: codeblock}

The previous definition calculates statistics on the numerical values that it finds in the array that is emitted as the index's value. The values are returned as an array in the same order as supplied in the map function:

```json
{"rows":[
    {"key":"2025-01-01","value":[
        {"sum":14.99,"count":1,"min":14.99,"max":14.99,"sumsqr":224.7001},
        {"sum":1.14,"count":1,"min":1.14,"max":1.14,"sumsqr":1.2995}
    ]},
    {"key":"2025-01-02","value":[
        {"sum":129.98,"count":2,"min":29.99,"max":99.99,"sumsqr":10897.4002},
        {"sum":6.18,"count":2,"min":1.62,"max":4.56,"sumsqr":23.418}
    ]}
]}
```
{: codeblock}

#### The approximate count distinct reducer
{: #built-in-reduce-functions-approx-count-distinct-reducer}

Unlike the numeric reducers `_sum` and `_stats` which act upon the index's value, the `_approx_count_distinct` reducer uses the view's _key_. It estimates the number of distinct keys found in the MapReduce view using an algorithm which uses far less memory than an exact count distinct algorithm would consume:

```json
{
  "views": {
    "estimateIpCount": {
      "map": "function (doc) {\n  emit(doc.ip, 1);\n}",
      "reduce": "_approx_count_distinct"
    }
  }
}
```
{: codeblock}

The previous view definition aims to estimate the number of distinct IP addresses in a database of server logs. The document's `ip` is emitted as the index's _key_ so that the `_approx_count_distinct` reducer can estimate the count of distinct keys:

```json
{"rows":[
{"key":null,"value":100528}
]}
```
{: codeblock}

#### The top/bottom reducers
{: #built-in-reduce-functions-top-bottom-reducer}

The `_top_x` and `_bottom_x` reducers (where `x` is a number between 1 and 100) return an array of the top x or bottom x _values_ in a view grouping, respectively. For example, in a gaming application, a view can be created keyed on the user id and whose value is the score that the user achieved. This view can be used to create a scoreboard of the best or worst scores:

```json
{
    "views": {
        "bestScores": {
            "map": "function(doc) { emit(doc.user_id, doc.score); }",
            "reduce": "_top_3"
        }
    }
}
```
{: codeblock}

If we query the view without any parameters, the top three scores in the entire view are returned:

```json
{"rows":[
  {"key":null,"value":[99,98,97]}
]}
```
{: codeblock}

With grouping (`?group=true`), each distinct user's top three scores are returned:

```json
{"rows":[
  {"key":"user082","value":[99,98,97]},
  {"key":"user291","value":[85,72,42]},
  {"key":"user452","value":[55,51,30]}
]}
```
{: codeblock}

#### The first/last reducers
{: #built-in-reduce-functions-first-last-reducer}

The `_first`/`_last` reducers return the _value_ of the first or last _key_ in a view grouping, respectively. If we have an IoT application storing readings from many devices periodically, we can create a view keyed on the device id & the time the reading was taken. The view's _value_ is the entire document:

```json
{
    "views": {
        "latestReading": {
            "map": "function(doc) { emit([doc.deviceid, doc.timestamp], doc); }",
            "reduce": "_last"
        }
    }
}
```
{: codeblock}

This view produces keys and values of this form, with the view sorted by `deviceid` and `timestamp`. The rows considered the "first" and "last" readings for each device are highlighted:

| key                                | value                                                                                      | First reading (group_level=1) | Last reading (group_level=1) |
|------------------------------------|--------------------------------------------------------------------------------------------|-------------------------------|------------------------------|
| ["A00","2025-01-01T10:00:00.000Z"] | {"_id": "A00:5000","reading":   65,"timestamp":2025-01-01T10:00:00.000Z","deviceid":"A00"} | x                             |                              |
| ["A00","2025-01-01T10:01:00.000Z"] | {"_id": "A00:5001","reading":   64,"timestamp":2025-01-01T10:01:00.000Z","deviceid":"A00"} |                               |                              |
| ["A00","2025-01-01T10:02:00.000Z"] | {"_id": "A00:5002","reading":   59,"timestamp":2025-01-01T10:02:00.000Z","deviceid":"A00"} |                               | x                            |
| ["A01","2025-01-01T10:00:00.000Z"] | {"_id": "A01:8000","reading":   12,"timestamp":2025-01-01T10:00:00.000Z","deviceid":"A01"} | x                             |                              |
| ["A01","2025-01-01T10:01:00.000Z"] | {"_id": "A01:8001","reading":   15,"timestamp":2025-01-01T10:01:00.000Z","deviceid":"A01"} |                               |                              |
| ["A01","2025-01-01T10:02:00.000Z"] | {"_id": "A01:8002","reading":   19,"timestamp":2025-01-01T10:02:00.000Z","deviceid":"A01"} |                               | x                            |
| ["A02","2025-01-01T10:00:00.000Z"] | {"_id": "A02:4000","reading":   55,"timestamp":2025-01-01T10:00:00.000Z","deviceid":"A02"} | x                             |                              |
| ["A02","2025-01-01T10:01:00.000Z"] | {"_id": "A02:4001","reading":   54,"timestamp":2025-01-01T10:01:00.000Z","deviceid":"A02"} |                               |                              |
| ["A02","2025-01-01T10:02:00.000Z"] | {"_id": "A01:4002","reading":   56,"timestamp":2025-01-01T10:02:00.000Z","deviceid":"A02"} |                               | x                            |

Querying the view with `group_level=1`, using the `_last` reducer, will return the newest reading for every device_id in the database:

```json
{"rows":[
{"key":["A00"],"value":{"_id":"93117567370d41d091b8dd160a3adf3f","_rev":"1-bc05e93e592d5a5a18e240240b581a55","deviceid":"A00","reading":13.8986,"timestamp":"2025-03-26T04:44:08.917Z","status":"red"}},
{"key":["A01"],"value":{"_id":"c9f53ac9e4a8444487ed0eaa11dc1c78","_rev":"1-1fcf121c73db03e49bac4c1981518b19","deviceid":"A01","reading":59.8453,"timestamp":"2025-04-01T01:52:34.254Z","status":"green"}},
{"key":["A02"],"value":{"_id":"577b7108a8a1458f9a17194ed1da398a","_rev":"1-71d345a773ab31f35ceb998f3c107c41","deviceid":"A02","reading":2.6208,"timestamp":"2025-03-31T00:22:17.175Z","status":"green"}},
{"key":["A03"],"value":{"_id":"150839b1d363427496a4f4e2917b8b1d","_rev":"1-860a2ed5f1f48aa642495dfb21dff3ce","deviceid":"A03","reading":55.8677,"timestamp":"2025-03-22T10:15:57.890Z","status":"red"}},
{"key":["A04"],"value":{"_id":"d3317bdc1f7b4466ae6bf7a30ca9e328","_rev":"1-a58762532f6980ca5b06a8d01d113814","deviceid":"A04","reading":44.1822,"timestamp":"2025-03-23T10:56:10.639Z","status":"green"}},
{"key":["A05"],"value":{"_id":"946754d3762f44e297ca20d13bbceb5e","_rev":"1-41fa2bb3ef8782c90b28ee44628abeab","deviceid":"A05","reading":13.2874,"timestamp":"2025-03-27T13:59:04.723Z","status":"blue"}},
{"key":["A06"],"value":{"_id":"bbcd8a5c0ae948baae713a9fcb5262d5","_rev":"1-66883211ee20a0772374672aa175dc50","deviceid":"A06","reading":7.9525,"timestamp":"2025-04-01T15:13:04.305Z","status":"blue"}},
{"key":["A07"],"value":{"_id":"a600caccdb82400698b158ecebfaa6f2","_rev":"1-68975a8d7133a13c6cc8ae34d28ea1c6","deviceid":"A07","reading":89.4818,"timestamp":"2025-03-07T02:12:59.934Z","status":"blue"}},
{"key":["A08"],"value":{"_id":"be20bae911db4da685f891fd01e07d3a","_rev":"1-d69b559627cf01e80fe85ea2f54d2f4b","deviceid":"A08","reading":97.6739,"timestamp":"2025-03-29T13:46:31.689Z","status":"green"}},
{"key":["A09"],"value":{"_id":"96526e80f2ff48e89e9e42aa47abae24","_rev":"1-85e56901f7113d7d6ff8ba573c535eb3","deviceid":"A09","reading":26.1597,"timestamp":"2025-03-18T03:22:19.848Z","status":"blue"}}
]}
```
{: codeblock}

#### The built-in reducers summary
{: #built-in-reduce-functions-summary}

| Function | Description |
|---------|------------|
| `_count` | Produces the row count for a specific key. The values can be any valid JSON. |
| `_stats` | Produces a JSON structure that contains the sum, the count, the min, the max, and the sum-squared values. All values must be numeric. |
| `_sum`   | Produces the sum of all values for a key. The values must be numeric. |
| `_approx_count_distinct` | Approximates the number of distinct keys in a view index by using a variant of the [HyperLogLog](https://en.wikipedia.org/wiki/HyperLogLog){: external} algorithm. |
| `_top_x`/`_bottom_x` | Returns an array of the top x or bottom x _values_ in the view grouping as an array, where `x` is a number between 1 and 100. |
| `_first`/`_last` | Returns the _values_ of the lowest or highest sorting _key_, respectively, for each view group. |
{: caption="Built-in reduce functions" caption-side="top"}

## Custom reduce functions
{: #custom-reduce-functions}

Most customers find that built-in reducers are sufficient to perform aggregations on the view `key-value` pairs emitted from their Map functions. However, for unusual use-cases, a JavaScript reduce function can be supplied instead of the name of one of the built-in reducers. 

Custom reduce functions are much slower and more difficult to maintain than built-in reducers, so check if a use-case can be satisfied with a built-in reducer before writing a custom one.
{: tip}

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
	-	`keys` is an array whose elements are arrays of the form `[key, id]`, where `key` is a key that is emitted by the map function, and `id` identifies the document from which the key was generated `values` is an array of the values that are emitted for the respective elements in `keys`, for example: `reduce([ [key1,id1], [key2,id2], [key3,id3] ], [value1,value2,value3], false)`.

2.	When `rereduce` is true:
	-	`keys` is `null`.
	-	`values` is an array of the values that are returned by previous calls to the reduce function, for example: `reduce(null, [intermediate1,intermediate2,intermediate3], true)`.

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
it built the index. It's essential that your functions work correctly in that
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

Your indexing functions work in a memory-constrained environment where the document forms part of the memory used in the environment. Your code's stack and document must fit within the memory. We limit documents to a maximum size of 64 MB.

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
the `getVerifiedEmails` view is defined as a map function,
and is available within the `views` field of the design document.

Use the `PUT` method to add a view into a design document:

```http
PUT $SERVICE_URL/$DATABASE/_design/$DDOC HTTP/1.1
Content-Type: application/json
```
{: codeblock}

The following sample adds a new `getVerifiedEmails` named view function to the `allusers` design document with view definition:

```json
{
    "views": {
        "getVerifiedEmails": {
            "map": "function(user) { if(user.email_verified === true){ emit(doc.email, {name: user.name, email_verified: user.email_verified, joined: user.joined}) }}  "
        }
    }
}
```

See the request examples:

```sh
curl -X PUT "$SERVICE_URL/users/_design/allusers" --data '{
  "views": {
    "getVerifiedEmails": {
      "map": "function(user) { if(user.email_verified === true){ emit(doc.email, {name: user.name, email_verified: user.email_verified, joined: user.joined}) }}"
    }
  }
}'
```
{: codeblock}
{: curl}

```java
import com.ibm.cloud.cloudant.v1.Cloudant;
import com.ibm.cloud.cloudant.v1.model.DesignDocument;
import com.ibm.cloud.cloudant.v1.model.DesignDocumentViewsMapReduce;
import com.ibm.cloud.cloudant.v1.model.DocumentResult;
import com.ibm.cloud.cloudant.v1.model.PutDesignDocumentOptions;

import java.util.Collections;

Cloudant service = Cloudant.newInstance();

DesignDocumentViewsMapReduce emailViewMapReduce =
    new DesignDocumentViewsMapReduce.Builder()
        .map("function(user) { if(user.email_verified === true){ emit(doc.email,{name: user.name, email_verified: user.email_verified, joined: user.joined}) }")
        .build();

DesignDocument designDocument = new DesignDocument();
designDocument.setViews(
        Collections.singletonMap("getVerifiedEmails", emailViewMapReduce));

PutDesignDocumentOptions designDocumentOptions =
    new PutDesignDocumentOptions.Builder()
        .db("users")
        .designDocument(designDocument)
        .ddoc("allusers")
        .build();

DocumentResult response =
    service.putDesignDocument(designDocumentOptions).execute()
        .getResult();

System.out.println(response);
```
{: codeblock}
{: java}

```javascript
import { CloudantV1 } from '@ibm-cloud/cloudant';

const service = CloudantV1.newInstance({});

const emailViewMapReduce: CloudantV1.DesignDocumentViewsMapReduce = {
  map: 'function(user) { if(user.email_verified === true){ emit(doc.email, {name: user.name, email_verified: user.email_verified, joined: user.joined}) }}'
}

const designDocument: CloudantV1.DesignDocument = {
  views: {'getVerifiedEmails': emailViewMapReduce}
}

service.putDesignDocument({
  db: 'users',
  designDocument: designDocument,
  ddoc: 'allusers'
}).then(response => {
  console.log(response.result);
});
```
{: codeblock}
{: node}

```python
from ibmcloudant.cloudant_v1 import CloudantV1

service = CloudantV1.new_instance()

email_view_map_reduce = DesignDocumentViewsMapReduce(
  map='function(user) { if(user.email_verified === true){ emit(doc.email, {name: user.name, email_verified: user.email_verified, joined: user.joined}) }}'
)

design_document = DesignDocument(
  views={'getVerifiedEmails': email_view_map_reduce}
)

response = service.put_design_document(
  db='users',
  design_document=design_document,
  ddoc='allusers'
).get_result()

print(response)
```
{: codeblock}
{: python}

```go
emailViewMapReduce, err := service.NewDesignDocumentViewsMapReduce(
  "function(user) { if(user.email_verified === true){ emit(doc.email, {name: user.name, email_verified: user.email_verified, joined: user.joined}) }}",
)
if err != nil {
  panic(err)
}

designDocument := &cloudantv1.DesignDocument{
  Views: map[string]cloudantv1.DesignDocumentViewsMapReduce{
    "getVerifiedEmails": *emailViewMapReduce,
  },
}

putDesignDocumentOptions := service.NewPutDesignDocumentOptions(
  "users",
  "allusers",
  designDocument,
)

documentResult, _, err := service.PutDesignDocument(putDesignDocumentOptions)
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

All Go examples require the `service` object to be initialized. For more information, see the API documentation's [Authentication section](https://cloud.ibm.com/apidocs/cloudant?code=go#authentication-with-external-configuration) for examples. 
{: go}
