---

copyright:
  years: 2015, 2025
lastupdated: "2025-09-25"

keywords: query, json index type, text index type, query parameters

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# Query parameters
{: #ibm-cloudant-query-parameters}

Query parameters change the output of {{site.data.keyword.cloudant_short_notm}} Query requests, altering the sort order, fields returned or paginating responses. Parameters are supplied in the query, alongside the `selector` field.
{: shortdesc}

## Overview of parameters
{: #overview-of-parameters}

This JSON document uses all available query parameters:

```jsonc
{
  // Query selector
	"selector": {
		"year": {
			"$gt": 2010
		}
	},
	// Specify fields to return
	"fields": ["_id", "_rev", "year", "title"],
	// Specify sort order
	"sort": [{"year": "asc"}],
	// Return a maximum number of results
	"limit": 10,
	// Start returning results from a previous bookmark (pagination)
	"bookmark":"g1AAAAA-eJzLYWBgYMpgSmHgKy5JLCrJTq2MT8lPzkzJB"
	// Hint to use a specific index for a query
	"use_index": "_design/32372935e14bed00cc6db4fc9efca0f1537d34a8",
	// Disallow using a different index than the specified index
  "allow_fallback": false
	}
```
{: codeblock}

## Specifying fields to return

It's possible to specify which fields are returned for a document when you select from a database. This can offer advantages:

- Your results are limited to only those parts of the document that are needed for your application.
- A reduction in the size of the response.

The fields to return are specified using the `fields` array in the query. The provided field names can use dotted notation to access subfields.

This query will return only the four specified fields from the result documents:

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

Only the specified filter fields are included in the response. `_id` or other metadata fields aren't automatically included.
{: tip}

## Sorting results
{: #sort-syntax}

Use the `sort` field in a query to specify how the returned results are ordered.
The `sort` field contains a list of field name and direction pairs,
expressed as an array.
The first field name and direction pair are the topmost-level of sort.
Further pairs, if provided, specify the next level of sort.

The sort field can be any field.
Use dotted notation if needed for subfields.

The direction value is `asc` for ascending, and `desc` for descending:

```json
"sort": [{ "fieldName1": "desc" }, { "fieldName2": "desc" }]
```
{: codeblock}

If you exclude the direction value, the default `asc` is used.
For ascending sorting, the following shorthand can be used:

```json
"sort": [ "fieldName1", "fieldName2" ]
```
{: codeblock}

A typical requirement is to search for some content by using a selector,
then to sort the results according to the specified field,
in the direction preferred.

To use sorting, an index containing the sort fields must be defined. 
If using `json` index, the fields must be specified in the same order as the sort.

Currently, {{site.data.keyword.cloudant_short_notm}} Query doesn't support multiple fields with different sort orders,
so the direction must either be all ascending or all descending.
{: tip}

If the direction is ascending, you can use a string instead of an object to specify the sort fields.

### Sorting using text indexes
{: #sorting-using-text-indexes}

For field names in sort queries against a `text` index where the type of the field being sorted cannot be determined, 
it may be necessary for a field type to be specified. For example:

```json
"sort": [ { "<fieldname>:string": "asc" } ]
```
{: codeblock}


| Which index is used by query?               | Field type requirement |
|------------------------------------------|-----------------------|
| JSON index                                | None |
| Text index of all fields in all documents | Specify the sort field in the query if the database contains documents where the sort field has one type. Also, specify the sort field in the query if it contains documents where the sort field has a different type. |
| Any other text index                      | Specify the type of all sort fields in the query. |
{: caption="When to specify the field type" caption-side="top"}

A text index of all fields
in all documents is created when you use the syntax:
[`"index": {}`](/docs/Cloudant?topic=Cloudant-query#the-index-field).
{: tip}

The sorting order is undefined when fields contain different data types. This characteristic is an important difference between text and view indexes. Sorting behavior for fields with different data types might change in future versions.

## Pagination
{: #pagination_query}

{{site.data.keyword.cloudant_short_notm}} Query supports pagination by the bookmark field. Every `_find` response contains a bookmark - a token
that {{site.data.keyword.cloudant_short_notm}} uses to determine where to resume from when later queries are made. To get the next
set of query results, add the bookmark that was received in the previous response to your next request.
Remember to keep the selector the same, otherwise you receive unexpected results. To paginate backwards,
you can use a previous bookmark to return the previous set of results.

For full documentation of pagination, see [Pagination and bookmarks](/docs/Cloudant?topic=Cloudant-pagination-and-bookmarks#use-cloudant-query-search).

The presence of a bookmark doesn’t guarantee more results. You can test whether
you are at the end of the result set by comparing the number of results that are returned with the page size
requested. If the results returned are less than limit, no more results were returned in the result set.
{: tip}


## Hinting use of a specific index
{: #hinting-use-of-an-index}

To instruct a query to use a specific index,
add the `use_index` parameter to the query. This is a hint; if the index cannot be used for the query, an alternative index will be used.

The value of the `use_index` parameter takes one of the following formats:

-	`"use_index": "$DDOC"`
-	`"use_index": ["$DDOC","$INDEX_NAME"]`

This example query shows hinting a specific index with `use_index`:

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

## Forcing use of a specific index
{: #forcing-use-of-an-index}

Combine the `allow_fallback` parameter with `use_index` to force the use of a specific index. If the index cannot be used for the query, the query will return an error response.

Using `"allow_fallback": false` without specifying `use_index` will prevent use of the `_all_docs` built-in index.

This example query shows forcing a specific index by using `allow_fallback` with `use_index`:

```json
{
	"selector": {
		"$text": "Pacino",
		"year": 2010
	},
	"use_index": "_design/32372935e14bed00cc6db4fc9efca0f1537d34a8",
  "allow_fallback": false
}
```
{: codeblock}
