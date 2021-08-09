---

copyright:
  years: 2015, 2021
lastupdated: "2021-06-23"

keywords: query a view, indexes, view freshness, combine parameters, sort returned rows, specify start and end keys, use keys to query view, multi-document fetching, send several queries to a view

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

<!-- Acrolinx: 2021-04-19 -->

# Using Views
{: #using-views}

Use views to search for content within a database that matches specific criteria.
The criteria are specified within the view definition,
or supplied as arguments when you use the view.
{: shortdesc}

In this documentation, when a feature, or an aspect of a feature, applies only to Transaction Engine, you see this tag, ![TXE tag](../images/txe_icon.svg).
{: important}

## Querying a view
{: #querying-a-view}

To query a view,
submit a `GET` request with the following format:

|Parameter | Description |
|----------|-------------|
| Method | Issue a partition query by using the following command, `GET /$DATABASE/_partition/$PARTITION_KEY/_design/$DDOC/_view/$INDEX_NAME`. Or issue a global query by using the following command, `GET /$DATABASE/_design/$DDOC/_view/$VIEW_NAME`. |
| Request | None |
| Response | JSON of the documents that are returned by the view. |
| Roles permitted | `_reader` |
{: caption="Table 1. Format for querying a view" caption-side="top"}

The request runs either:

- The specified `view-name` from the specified `design-doc` design document
    within the database.
- The specified `view-name` from the specified `design-doc` design document
    within the database, which is constrained to results within a specific data partition.

The examples in this document vary between partition and global queries for
illustrative purposes. Unless otherwise noted, modifying the path to
embed or remove the partition name works for any view query type.

### Query and JSON Body Arguments
{: #query-arguments-using_views}

Global queries can use all query and JSON body arguments. Partition queries can use only the
subset that is indicated in the table.

Argument         | Description | Optional | Type | Default | Supported values | Partition query
-----------------|-------------|----------|------|---------|------------------|-----------------
`bookmark` ![TXE tag](../images/txe_icon.svg) | A bookmark to navigate to a specific page. | Yes | String | | |
`conflicts`      | Can be set only if `include_docs` is `true`. Adds information about conflicts to each document. | Yes | Boolean | False || No
`descending`     | Return the documents in `descending by key` order. | Yes | Boolean | False | | Yes
`endkey`         | Stop returning records when the specified key is reached. | Yes | String or JSON array | | | Yes
`endkey_docid`   | Stop returning records when the specified document ID is reached. | Yes | String | | | Yes
`group`          | Using the `reduce` function, group the results to a group or single row. | Yes | Boolean | False | | Yes
`group_level`    | Only applicable if the view uses complex keys: keys that are JSON arrays. Groups reduce results for the specified number of array fields. | Yes | Numeric | | | Yes
`include_docs`   | Include the full content of the documents in the response. | Yes | Boolean | False | | Yes
`inclusive_end`  | Include rows with the specified `endkey`. | Yes | Boolean | True | | Yes
`key`            | Return only documents that match the specified key. Keys are JSON values, and must be URL encoded. | Yes | JSON strings or arrays | | | Yes
`keys`           | Return only documents that match the specified keys. Keys are JSON values, and must be URL encoded. | Yes | Array of JSON strings or arrays | || Yes
`limit` [^transaction-engine] | Limit the number of returned documents to the specified count. | Yes | Numeric | | | Yes
`page_size` ![TXE tag](../images/txe_icon.svg) | Specify the number of returned documents in the result.  | Yes | Numeric | | |
`reduce`         | Use the `reduce` function. | Yes | Boolean | True | | Yes
`skip`           | Skip this number of rows from the start. | Yes | Numeric | 0 | | Yes
`stable`         | Prefer view results from a 'stable' set of shards. The results are from a view that is less likely to be updated soon. | Yes | Boolean | False | | No
`stale`          | Allow the results from a stale view to be used. The request returns immediately, even if the view isn't built yet. If this parameter isn't specified, a response is returned only after the view is built. | Yes | String | False | | No
`startkey`       | Return records, starting with the specified key. | Yes | String or JSON array | | | Yes
`startkey_docid` | Return records, starting with the specified document ID. | Yes | String | || Yes
 `update`        | Ensure that the view is updated before results are returned. | Yes | String | `true` | Yes
{: caption="Table 2. Subset of query and JSON body arguments available for partitioned queries" caption-side="top"}

[^transaction-engine]: For Transaction Engine, the `limit` parameter restricts the total number of returned documents.

This table shows the supported values for the following arguments:

Argument | Supported values
---------|-----------------
`stale`  | `ok`- Allow stale views.<br/>`update_after` - Allow stale views, but update them immediately after the request.
`update` | `true` - Return results after the view is updated.<br/>`false` - Return results without updating the view.<br/>`lazy` - Return the view results without waiting for an update, but update them immediately after the request.
{: caption="Table 3. Supported values" caption-side="top"}

Using `include_docs=true` might have [performance implications](#multi-document-fetching).
{: important}

See the example of using HTTP to retrieve a list of the first five documents from the `recipes` partition of a database, applying the user-created `by_title` view.

```http
GET /$DATABASE/_partition/recipes/_design/$DDOC/_view/by_title?limit=5 HTTP/1.1
Accept: application/json
Content-Type: application/json
```
{: codeblock}

See the example of using HTTP to retrieve a list of the first five documents from a database, applying the user-created `by_title` view.

```http
GET /$DATABASE/_design/$DDOC/_view/by_title?limit=5 HTTP/1.1
Accept: application/json
Content-Type: application/json
```
{: codeblock}

See the example of using the command line to retrieve a list of the first five documents from the `recipes` partition of a database, applying the user-created `by_title` view.

```sh
curl "https://$ACCOUNT.cloudant.com/$DATABASE/_partition/recipes/_design/$DDOC/_view/by_title?limit=5" \
     -H "Content-Type: application/json"
```
{: codeblock}

See the example of using the command line to retrieve a list of the first five documents from a database, applying the user-created `by_title` view.

```sh
curl "https://$ACCOUNT.cloudant.com/$DATABASE/_design/$DDOC/_view/by_title?limit=5" \
     -H "Content-Type: application/json"
```
{: codeblock}

See the following example response to the request:

```json
{
    "offset" : 0,
    "rows" : [
        {
            "id" : "3-tiersalmonspinachandavocadoterrine",
            "key" : "3-tier salmon, spinach and avocado terrine",
            "value" : [
                null,
                "3-tier salmon, spinach and avocado terrine"
                ]
        },
        {
            "id" : "Aberffrawcake",
            "key" : "Aberffraw cake",
            "value" : [
                null,
                "Aberffraw cake"
            ]
        },
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
```
{: codeblock}

## Indexes
{: #indexes}

When a view is defined in a design document,
a corresponding index is also created,
based on the information defined within the view.
Use indexes to find documents by criteria other than their `_id` field.
For example,
you might select by a field,
or combination of fields,
or by a value that is computed by using the contents of the document.
The index is populated as soon as the design document is created.
On large databases,
this process might take a while.

The index content is updated incrementally and automatically when one of the following events occurs:

-   A new document is added to the database.
-   An existing document is deleted from the database.
-   An existing document in the database is updated.

View indexes are rebuilt entirely when the view definition changes,
or when another view definition in the same design document changes.
The rebuild ensures that changes to the view definitions are reflected in the view indexes.
To ensure that the rebuild happens,
a 'fingerprint' of the view definition is created whenever the design document is updated.
If the fingerprint changes,
then the view indexes are rebuilt.

View index rebuilds occur when you change any one view from all the views that are defined in the design document. For example, if you have a design document with three views, and you update the design document, all three view indexes within the design document are rebuilt. If you want to change a design document for a larger database, have a look at the [Design document management guide](/docs/Cloudant?topic=Cloudant-design-document-management#managing-changes-to-a-design-document).
{: tip}

If the database was updated recently,
the results might be delayed when the view is accessed.
The delay is affected by the number of changes to the database,
and whether the view index isn't current because the database content was modified.

It isn't possible to eliminate these delays.
For newly created databases,
you might reduce the delays by creating the view definition in the design document in your database
before you insert or update documents.
Creating the view definition in the design document
causes incremental updates to the index when the documents or inserted.

If speed of response is more important than having up-to-date data,
an alternative is to allow users to access an old version of the view index. To allow access to an old version of the view index, use the `update` query string parameter when you make a view query.

If you want to save old index versions without incurring indexing processor usage, you can stop all indexes from building by setting `"autoupdate": {"indexes": false}`. Or you can stop views from auto-updating by adding one of the following options to a design document. You can stop all index types from indexing if you set `"autoupdate": false`. See the following examples. 
{: tip}

```json
	{
	    "_id": "_design/lookup",
	    "autoupdate": false,
	    "views": {
	        "view": {
	            "map": "function(doc)..."
	        }
	    }
	}
```
```json
	{
	    "_id": "_design/lookup",
	    "autoupdate": {"views": false},
	    "views": {
	        "view": {
	            "map": "function(doc)..."
	        }
	    }
	}
```

## View freshness
{: #view-freshness}

By default, all index results reflect the current state of the database. {{site.data.keyword.cloudant_short_notm}} builds its indexes automatically and asynchronously in the background.
This practice usually means that the index is fully up-to-date 
when you query it.  If not, you call the index "stale," and by default, the remaining updates occur when you query the index. 
The results of your query include these updates. {{site.data.keyword.cloudant_short_notm}} builds three copies of every index in 
alignment with the three copies of your primary data.

{{site.data.keyword.cloudant_short_notm}} supplies better results and
performance with the defaults for these parameters. If the performance of your view and your application can tolerate inconsistent results when queried, use `stable=false&update=false`. These settings avoid directing all queries to a single copy of 
your index, which would, in effect, reduce some aspects of performance to a third of what it must be.

Option   | Purpose                                                                                                                               | Default value
---------|---------------------------------------------------------------------------------------------------------------------------------------|--------------
`stable` | Determine whether view results are obtained from a consistent or 'stable' set of shards. Possible values include `true`, and `false`. | `false`
`update` | Determine whether the view is updated before the results are returned. Possible values include `true`, `false`, and `lazy`.           | `true`
{: caption="Table 4. Parameter default values" caption-side="top"}

The defaults are suitable for most applications. For better performance and
availability, use `stable=false&update=false`. For better result stability
across queries, use `stable=true&update=true`. See the next section for more detail.

### Parameters
{: #parameters}

The `stable` option indicates whether you would prefer to get results from a single,
consistent set of shards. The `false` value means that all available shard replicas are queried. {{site.data.keyword.cloudant_short_notm}} uses the first response returned. 
The benefit is that the response isn't delayed when an individual shard replica is slow to respond.
By contrast, setting `stable=true` forces the database to use a single,
consistent set of shards to respond to the query.

The `update` option indicates whether you're prepared to accept
view results without waiting for the view to be updated. The default value is `true`,
meaning that the view is updated before results are returned. The `lazy` value means that the results are returned before the view is updated,
but that the view must then be updated anyway.

### Combining parameters
{: #combining-parameters}

When you specify `stable=true` with `update=false` or `update=lazy`,
responses are consistent from request to request because a single,
consistent set of shards is used to respond to the query.
However, when one of the shards is heavily loaded or slow to respond,
the response time is adversely affected.

When the default `stable=false` value applies,
and you use any value for `update`, results are different based on which replica 
responds first.

## Sorting returned rows
{: #sorting-returned-rows}

The data that is returned by a view query is in the form of an array.
Each element within the array is sorted by using standard
[UTF-8](https://en.wikipedia.org/wiki/UTF-8){: new_window}{: external} sorting.
The sort is applied to the key defined in the view function. 

The basic order of the output is shown in the following table:

Value                                                                                             | Order
--------------------------------------------------------------------------------------------------|------
`null`                                                                                            | First
`false`                                                                                           |
`true`                                                                                            |
Numbers                                                                                           |
Text (lowercase)                                                                                  |
Text (uppercase)                                                                                  |
Arrays (according to the values of each element, by using the order given in this table)          |
Objects (according to the values of keys, in key order by using the order given in this table)    | Last
{: caption="Table 6. Order of returned rows" caption-side="top"}

You can reverse the order of the returned view information by setting the `descending` query value `true`.

When you issue a view request that specifies the `keys` parameter, the results are returned in the same order as the supplied `keys` array. 
{: tip}

See the example of using HTTP to request the last five records in reversed sort order:

```http
GET /$DATABASE/_design/$DDOC/_view/by_title?limit=5&descending=true HTTP/1.1
Accept: application/json
Content-Type: application/json
```
{: codeblock}

See the example of requesting the last five records in reverse sort order by using the command line:

```sh
curl "https://$ACCOUNT.cloudant.com/$DATABASE/_design/$DDOC/_view/by_title?limit=5&descending=true" \
     -H "Content-Type: application/json"
```
{: codeblock}

See the example response of requesting the last five records in reverse sort order:

```json
{
    "offset" : 0,
    "rows" : [
        {
            "id" : "Zucchiniinagrodolcesweet-sourcourgettes",
            "key" : "Zucchini in agrodolce (sweet-sour courgettes)",
            "value" : [
                null,
                "Zucchini in agrodolce (sweet-sour courgettes)"
            ]
        },
        {
            "id" : "Zingylemontart",
            "key" : "Zingy lemon tart",
            "value" : [
                null,
                "Zingy lemon tart"
            ]
        },
        {
            "id" : "Zestyseafoodavocado",
            "key" : "Zesty seafood avocado",
            "value" : [
                null,
                "Zesty seafood avocado"
            ]
        },
        {
            "id" : "Zabaglione",
            "key" : "Zabaglione",
            "value" : [
                null,
                "Zabaglione"
            ]
        },
        {
            "id" : "Yogurtraita",
            "key" : "Yogurt raita",
            "value" : [
                null,
                "Yogurt raita"
            ]
        }
    ],
    "total_rows" : 2667
}
```
{: codeblock}

## Specifying start and end keys
{: #specifying-start-and-end-keys}

The `startkey` and `endkey` query arguments can be used to specify the range of values
that are returned when querying the view.

The sort direction is always applied first.

Next,
filtering is applied by using the `startkey` and `endkey` query arguments.
The combination of sorting and filtering means that it is possible to have empty view results because
the sorting and filtering don't make sense when combined.

See the example of using HTTP to make a global query that includes `startkey` and `endkey` query arguments:

```http
GET /recipes/_design/recipes/_view/by_ingredient?startkey="alpha"&endkey="beta" HTTP/1.1
Accept: application/json
Content-Type: application/json
```
{: codeblock}

See the example of a global query that uses the command line that includes `startkey` and `endkey` query arguments:

```sh
curl "https://$ACCOUNT.cloudant.com/$DATABASE/_design/$DDOC/_view/by_ingredient?startkey="alpha"&endkey="beta"" \
     -H "Content-Type: application/json"
```
{: codeblock}

For example,
if you have a database that returns 10 results when you use a `startkey` of `alpha` and an `endkey` of `beta`,
you would get no results with a reversed order.
The reason is that the entries in the view are reversed before the key filter is applied.

See the example that uses HTTP to illustrate why reversing the order of `startkey` and `endkey` might not yield any results:

```http
GET /recipes/_design/recipes/_view/by_ingredient?descending=true&startkey="beta"&endkey="alpha" HTTP/1.1
Accept: application/json
Content-Type: application/json
```
{: codeblock}

See the example illustrating why reversing the order of `startkey` and `endkey` might not yield any results when you use the command line:

```sh
curl "https://$ACCOUNT.cloudant.com/$DATABASE/_design/$DDOC/_view/by_ingredient?descending=true&startkey="beta"&endkey="alpha"" \
     -H "Content-Type: application/json"
```
{: codeblock}

The `endkey` of `beta` is seen before the `startkey` of `alpha`, resulting in an empty list.

See the example that shows the global view query returns no entries because `alpha` is alphabetically before `beta`. That's why the returned result is empty:

```json
{
    "total_rows" : 26453,
    "rows" : [],
    "offset" : 21882
}
```
{: codeblock}

The solution is to reverse not just the sort order,
but also the `startkey` and `endkey` parameter values.

The following example shows correct filtering and reversing the order of output,
by using the `descending` query argument,
and reversing the `startkey` and `endkey` query arguments.

See the example that uses HTTP to apply correct filtering and sorting to a global query:

```http
GET /recipes/_design/recipes/_view/by_ingredient?descending=true&startkey="egg"&endkey="carrots" HTTP/1.1
Accept: application/json
Content-Type: application/json
```
{: codeblock}

See the example that uses the command line to apply correct filtering and sorting to a global query:

```sh
curl "https://$ACCOUNT.cloudant.com/$DATABASE/_design/$DDOC/_view/by_ingredient?descending=true&startkey="egg"&endkey="carrots"" \
    -H "Content-Type: application/json"
```
{: codeblock}

## Querying a view by using a list of keys
{: #querying-a-view-by-using-a-list-of-keys}

You can also run a query by providing a list of keys to use.

Requesting information from a database in this way uses
the specified `view-name` from the specified `design-doc` design document.
Like the `keys` parameter for the [`GET`](#querying-a-view) method,
you can use the `POST` method to specify the keys to use to retrieve the view results.
In all other aspects,
the `POST` method is the same as the [`GET`](#querying-a-view) API request.
In particular,
you can use any of its query parameters in either the query string or the JSON body.

See the example HTTP request that returns all recipes, where the key for the view matches either `claret` or `clear apple juice`:

```http
POST /$DATABASE/_design/$DDOC/_view/$VIEWNAME HTTP/1.1
Content-Type: application/json
```
{: codeblock}

See the example of a global query that returns all recipes (where the key for the view matches either `claret` or `clear apple juice`) when you use the command line:

```sh
curl -X POST "https://INDEX_NAME$ACCOUNT.cloudant.com/$DATABASE/_design/$DDOC/_view/$VIEWNAME" -d @request.json
```
{: codeblock}

See the example JSON document that provides a list of keys to use in the query:

```json
{
    "keys" : [
        "claret",
        "clear apple juice"
    ]
}
```
{: codeblock}

The response contains the standard view information,
but only documents where the keys match.

See the example response after you run a query by using a list of keys:

```json
{
    "total_rows" : 26484,
    "rows" : [
        {
            "value" : [
              "Scotch collops"
            ],
            "id" : "Scotchcollops",
            "key" : "claret"
        },
        {
            "value" : [
              "Stand pie"
            ],
            "id" : "Standpie",
            "key" : "clear apple juice"
        }
    ],
    "offset" : 6324
}
```
{: codeblock}

## Multi-document fetching
{: #multi-document-fetching}

If you combine a `POST` request to a many documents from a database.

For a client application, this technique is more efficient than using multiple [`GET`](#querying-a-view) API requests.

However, `include_docs=true` might require extra processing time when compared to accessing the view on its own.

The reason is that by using `include_docs=true` in a view query, all of the result documents must be retrieved to construct the response for the client application. In effect, a whole series of document `GET` requests are run, each of which competes for resources with other application requests.

One way to mitigate this effect is by retrieving results directly from the view index file. Omit `include_docs=true` to retrieve results directly from the view index file. Instead, in the map function in a design document, emit the fields that are required as the value for the view index.

For example, in your map function, you might use the following design specification:

```javascript
function(employee_doc) {
    emit(employee_doc.number, {
        employee_doc.training,
        employee_doc.manager,
        employee_doc.skills
    });
}
```

See the example request that uses HTTP to obtain the full content of documents that match the listed keys within the `british` partition:

```http
POST /recipes/_partition/british/_design/recipes/_view/by_ingredient?include_docs=true HTTP/1.1
Content-Type: application/json
```
{: codeblock}

See the example JSON document that lists the keys to match:

```json
{
    "keys" : [
        "claret",
        "clear apple juice"
    ]
}
```
{: codeblock}

See the example request that uses the command line to obtain the full content of documents that match the listed keys within the `british` partition:

```sh
curl "https://INDEX_NAME$ACCOUNT.cloudant.com/$DATABASE/_partition/british/_design/$DDOC/_view/by_ingredient?include_docs=true"
    -X POST \
    -H "Content-Type: application/json" \
    -d '{ "keys" : [ "claret", "clear apple juice" ] }'
```
{: codeblock}

See the example (abbreviated) response, returning the full document for each recipe that matches a provided key:

```json
{
    "offset" : 6324,
    "rows" : [
        {
            "doc" : {
                "_id" : "Scotchcollops",
                "_rev" : "1-bcbdf724f8544c89697a1cbc4b9f0178",
                "cooktime" : "8",
                "ingredients" : [
                    {
                        "ingredient" : "onion",
                        "ingredtext" : "onion, peeled and chopped",
                        "meastext" : "1"
                    },
                    ...
                ],
                "keywords" : [
                    "cook method.hob, oven, grill@hob",
                    "diet@wheat-free",
                    "diet@peanut-free",
                    "special collections@classic recipe",
                    "cuisine@british traditional",
                    "diet@corn-free",
                    "diet@citrus-free",
                    "special collections@very easy",
                    "diet@shellfish-free",
                    "main ingredient@meat",
                    "occasion@christmas",
                    "meal type@main",
                    "diet@egg-free",
                    "diet@gluten-free"
                ],
                "preptime" : "10",
                "servings" : "4",
                "subtitle" : "This recipe ... short time.",
                "title" : "Scotch collops",
                "totaltime" : "18"
            },
            "id" : "Scotchcollops",
            "key" : "claret",
            "value" : [
                "Scotch collops"
            ]
        },
        {
            "doc" : {
                "_id" : "Standpie",
                "_rev" : "1-bff6edf3ca2474a243023f2dad432a5a",
                "cooktime" : "92",
                "ingredients" : [
                  ...
                ],
                "keywords" : [
                    "diet@dairy-free",
                    "diet@peanut-free",
                    "special collections@classic recipe",
                    "cuisine@british traditional",
                    "diet@corn-free",
                    "diet@citrus-free",
                    "occasion@buffet party",
                    "diet@shellfish-free",
                    "occasion@picnic",
                    "special collections@lunchbox",
                    "main ingredient@meat",
                    "convenience@serve with salad for complete meal",
                    "meal type@main",
                    "cook method.hob, oven, grill@hob / oven",
                    "diet@cow dairy-free"
                ],
                "preptime" : "30",
                "servings" : "6",
                "subtitle" : "Serve this pie with pickled vegetables and potato salad.",
                "title" : "Stand pie",
                "totaltime" : "437"
            },
            "id" : "Standpie",
            "key" : "clear apple juice",
            "value" : [
              "Stand pie"
            ]
        }
    ],
    "total_rows" : 26484
}
```
{: codeblock}

