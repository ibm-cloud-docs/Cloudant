---

copyright:
  years: 2015, 2021
lastupdated: "2021-09-02"

keywords: create index, search index partitioning, index functions, guard clauses, language-specific analyzers, per-field analyzers, stop words, queries, query syntax, faceting, geographical searches, search terms, search index metadata

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

<!-- Acrolinx: 2020-04-23 -->

# Using {{site.data.keyword.cloudant_short_notm}} Search
{: #using-cloudant-search}

Search indexes allow you to query a database by using [Lucene Query Parser Syntax](http://lucene.apache.org/core/4_3_0/queryparser/org/apache/lucene/queryparser/classic/package-summary.html#Overview){: new_window}{: external}. A search index uses one or more fields from your documents. 
{: shortdesc}

You can use a search index to run queries, find documents based on the content they include, or work with groups, facets, or geographical searches.

To create a search index, you add a JavaScript function to a design document in the database. An index builds after it processes one search request or after the server detects a document update. The `index` function takes the following parameters: 

1. Field name - The name of the field you want to use when you query the index. If you set this parameter to `default`, then this field is queried if no field is specified in the query syntax.
2. Data that you want to index, for example, `doc.address.country`. 
3. (Optional) The third parameter includes the following fields: `boost`, `facet`, `index`, and `store`. These fields are described in more detail later.   

By default, a search index response returns 25 rows. The number of rows that is returned can be changed by using the `limit` parameter. However, a result set from a search is limited to 200 rows. Each response includes a `bookmark` field. You can include the value of the `bookmark` field in later queries to look through the responses.

You can query the API by using one of the following methods: URI, {{site.data.keyword.cloudant_short_notm}} Dashboard, curl, or a browser plug-in, such as Postman or RESTClient.

See the following example design document that defines a search index:

```json
{
	"_id": "_design/search_example",
	"indexes": {
		"animals": {
			"index": "function(doc){ ... }"
		}
	}
}
```
{: codeblock}

## Search index partitioning type
{: #search-index-partitioning-type}

A search index inherits the partitioning type from the `options.partitioned`
field of the design document that contains it.


## Index functions
{: #index-functions}

If you attempt to index by using a data field that doesn't exist, it fails. To avoid this problem, use an appropriate [guard clause](#index-guard-clauses).

Your indexing functions operate in a memory-constrained environment where the document itself forms a part of the memory that is used in that environment. Your code's stack and document must fit inside this memory. Documents are limited to a maximum size of 64 MB.
{: note}

Within a search index, don't index the same field name with more than one data type. If the same field name is indexed with different data types in the same search index function, you might get an error. This occurs when you query the search index that says the field `was indexed without position data`. For example, don't include both of these lines in the same search index function. These lines index the `myfield` field as two different data types, a string `"this is a string"` and a number `123`.
{: note}

```json
index("myfield", "this is a string");
index("myfield", 123);
```

The function that is contained in the index field is a JavaScript function
that is called for each document in the database.
The function takes the document as a parameter,
extracts some data from it,
and then calls the function that is defined in the `index` field to index that data.

The `index` function takes three parameters, where the third parameter is optional.

The first parameter is the name of the field you intend to use when querying the index,
which is specified in the Lucene syntax portion of later queries.
An example appears in the following query:

```
query=color:red
```
{: codeblock}

The Lucene field name `color` is the first parameter of the `index` function.

The `query` parameter can be abbreviated to `q`,
so another way of writing the query is shown in the  following example.

```
q=color:red
```
{: codeblock}

If the special value `"default"` is used when you define the name,
you don't have to specify a field name at query time.
The effect is that the query can be simplified:

```
query=red
```
{: codeblock}

The second parameter is the data to be indexed. Keep the following information in mind when you index your data: 

- This data must be only a string, number, or boolean. Other types return an error from the index function call.
- If an error is returned when your function is running, for this reason or others, the document isn't added to that search index.

The third, optional, parameter is a JavaScript object with the following fields:

| Option | Description | Values | Default | 
|--------|-------------|--------|---------|
| `boost` | A number that specifies the relevance in search results. Content that is indexed with a boost value greater than 1 is more relevant than content that is indexed without a boost value. Content with a boost value less than one isn't so relevant. | A positive floating point number | 1 (No boosting) |
| `facet` | Creates a faceted index. For more information, see [Faceting](/docs/Cloudant?topic=Cloudant-search#faceting). | `true` | `false` | `false` |
| `index` | Whether the data is indexed, and if so, how. If set to `false`, the data can't be used for searches, but can still be retrieved from the index if `store` is set to `true`. For more information, see [Analyzers](/docs/Cloudant?topic=Cloudant-search#analyzers). | `true`, `false` | `true` |
| `store` | If `true`, the value is returned in the search result; otherwise, the value isn't returned. | `true`, `false` | `false` |
{: caption="Table 1. Fields for the JavaScript object (optional parameter)" caption-side="top"}

If you don't set the `store` parameter,
the index data results for the document aren't returned in response to a query.
{: tip}

See the following example search index function:

```javascript
function(doc) {
	index("default", doc._id);
	if (doc.min_length) {
		index("min_length", doc.min_length, {"store": true});
	}
	if (doc.diet) {
		index("diet", doc.diet, {"store": true});
	}
	if (doc.latin_name) {
		index("latin_name", doc.latin_name, {"store": true});
	}
	if (doc.class) {
		index("class", doc.class, {"store": true});
	}
}
```
{: codeblock}

### Index guard clauses
{: #index-guard-clauses}

The `index` function requires the name of the data field to index as the second parameter.
However,
if that data field doesn't exist for the document,
an error occurs.
The solution is to use an appropriate "guard clause" that checks if the field exists.
This clause contains the expected type of data 
before any attempt to create the corresponding index.

See the following example definition that doesn't have any validation on the type of the index data field: 

```javascript
if (doc.min_length) {
	index("min_length", doc.min_length, {"store": true});
}
```
{: codeblock}

You might use the JavaScript `typeof` operator to implement the guard clause test.
If the field exists and has the expected type,
the correct type name is returned. The guard clause test succeeds, which means it's safe to use the index function.
If the field does not exist,
you wouldn't get back the expected type of field,
that's why you wouldn't try to index the field.

JavaScript considers a result to be false if one of the following values is tested:

- 'undefined'
- Null
- The number +0
- The number -0
- NaN (not a number)
- "" (the empty string)

See the following example that uses a guard clause to check whether the required data field exists,
and holds a number, before you try to index:

```javascript
if (typeof doc.min_length === 'number') {
    index("min_length", doc.min_length, {"store": true});
}
```
{: codeblock}

Use a generic guard clause test to ensure that the type of the candidate data field is defined.

See the following example of a "generic" guard clause:

```javascript
if (typeof doc.min_length) !== 'undefined') {
	// The field exists, and does have a type, so we can proceed to index using it.
	...
}
```
{: codeblock}

## Analyzers
{: #analyzers}

Analyzers are settings that define how to recognize terms within text.
Analyzers can be helpful if you need to [index multiple languages](#language-specific-analyzers).

Here's the list of generic analyzers that are supported by {{site.data.keyword.cloudantfull}} search:

Analyzer     | Description
-------------|------------
`classic`    | The standard Lucene analyzer, circa version 3.1.
`email`      | Like the `standard` analyzer, but tries harder to match an email address as a complete token.
`keyword`    | Input isn't tokenized at all.
`simple`     | Divides text at non-letters.
`standard`   | The default analyzer. It implements the Word Break rules from the [Unicode Text Segmentation algorithm](http://www.unicode.org/reports/tr29/){: new_window}{: external}.
`whitespace` | Divides text at white space boundaries.
{: caption="Table 2. Generic analyzers" caption-side="top"}

See the following example analyzer document:

```json
{
	"_id": "_design/analyzer_example",
	"indexes": {
		"INDEX_NAME": {
			"index": "function (doc) { ... }",
			"analyzer": "$ANALYZER_NAME"
		}
	}
}
```
{: codeblock}

### Language-specific analyzers
{: #language-specific-analyzers}

These analyzers omit common words in the specific language,
and many also [remove prefixes and suffixes](http://en.wikipedia.org/wiki/Stemming){: new_window}{: external}.
The name of the language is also the name of the analyzer.

- `arabic`
- `armenian`
- `basque`
- `bulgarian`
- `brazilian`
- `catalan`
- `cjk` (Chinese, Japanese, Korean)
- `chinese` ([`smartcn`](http://lucene.apache.org/core/4_2_1/analyzers-smartcn/org/apache/lucene/analysis/cn/smart/SmartChineseAnalyzer.html){: new_window}{: external})
- `czech`
- `danish`
- `dutch`
- `english`
- `finnish`
- `french`
- `german`
- `greek`
- `galician`
- `hindi`
- `hungarian`
- `indonesian`
- `irish`
- `italian`
- `japanese` ([`kuromoji`](http://lucene.apache.org/core/4_2_1/analyzers-kuromoji/overview-summary.html){: new_window}{: external})
- `latvian`
- `norwegian`
- `persian`
- `polish` ([`stempel`](http://lucene.apache.org/core/4_2_1/analyzers-stempel/overview-summary.html){: new_window}{: external})
- `portuguese`
- `romanian`
- `russian`
- `spanish`
- `swedish`
- `thai`
- `turkish`

Language-specific analyzers are optimized for the specified language. You can't combine a generic analyzer with a language-specific analyzer. Instead, you might use a [`perfield` analyzer](#per-field-analyzers) to select different analyzers for different fields within the documents.
{: note}

### Per-field analyzers
{: #per-field-analyzers}

The `perfield` analyzer configures many analyzers for different fields.

See the following example that defines different analyzers for different fields:

```json
{
	"_id": "_design/analyzer_example",
	"indexes": {
		"INDEX_NAME": {
			"analyzer": {
				"name": "perfield",
				"default": "english",
				"fields": {
					"spanish": "spanish",
					"german": "german"
				}
			},
			"index": "function (doc) { ... }"
		}
	}
}
```
{: codeblock}

### Stop words
{: #stop-words}

Stop words are words that don't get indexed.
You define them within a design document by turning the analyzer string into an object.

The `keyword`, `simple`, and `whitespace` analyzers don't support stop words.
{: tip}

The default stop words for the `standard` analyzer are included in the following list:

```json
 "a", "an", "and", "are", "as", "at", "be", "but", "by", "for", "if", 
 "in", "into", "is", "it", "no", "not", "of", "on", "or", "such", 
 "that", "the", "their", "then", "there", "these", "they", "this", 
 "to", "was", "will", "with" 
 ```

See the following example that defines non-indexed ('stop') words:

```json
{
	"_id": "_design/stop_words_example",
	"indexes": {
		"INDEX_NAME": {
			"analyzer": {
				"name": "portuguese",
				"stopwords": [
					"foo",
					"bar",
					"baz"
				]
			},
			"index": "function (doc) { ... }"
		}
	}
}
```
{: codeblock}

### Testing analyzer tokenization
{: #testing-analyzer-tokenization}

You can test the results of analyzer tokenization by posting sample data to the `_search_analyze` endpoint.

See the following example that uses HTTP to test the `keyword` analyzer:

```http
Host: $ACCOUNT.cloudant.com
POST /_search_analyze HTTP/1.1
Content-Type: application/json
{"analyzer":"keyword", "text":"ablanks@renovations.com"}
```
{: codeblock}

See the following example that uses the command line to test the `keyword` analyzer:

```sh
curl "https://$ACCOUNT.cloudant.com/_search_analyze" -H "Content-Type: application/json"
	-d '{"analyzer":"keyword", "text":"ablanks@renovations.com"}'
```
{: codeblock}

See the following result that tests the `keyword` analyzer:

```json
{
	"tokens": [
		"ablanks@renovations.com"
	]
}
```
{: codeblock}

See the following example that uses HTTP to test the `standard` analyzer:

```http
Host: $ACCOUNT.cloudant.com
POST /_search_analyze HTTP/1.1
Content-Type: application/json
{"analyzer":"standard", "text":"ablanks@renovations.com"}
```
{: codeblock}

See the following example that uses the command line to test the `standard` analyzer:

```sh
curl "https://$ACCOUNT.cloudant.com/_search_analyze" -H "Content-Type: application/json"
	-d '{"analyzer":"standard", "text":"ablanks@renovations.com"}'
```
{: codeblock}

See the following result of testing the `standard` analyzer:

```json
{
	"tokens": [
		"ablanks",
		"renovations.com"
	]
}
```
{: codeblock}

## Queries
{: #queries}

After you create a search index, you can query it.

- Run a partition query by using the following request:
  ```
  GET /$DATABASE/_partition/$PARTITION_KEY/_design/$DDOC/_search/$INDEX_NAME
  ```
- Run a global query by using the following request:
  ```
  GET /$DATABASE/_design/$DDOC/_search/$INDEX_NAME
  ```

Specify your search by using the `query` parameter.

See the following example that uses HTTP to query a partitioned index:

```http
GET /$DATABASE/_partition/$PARTITION_KEY/_design/$DDOC/_search/$INDEX_NAME?include_docs=true&query="*:*"&limit=1 HTTP/1.1
Content-Type: application/json
Host: account.cloudant.com
```
{:codeblock}

See the following example that uses HTTP to query a global index:

```http
GET /$DATABASE/_design/$DDOC/_search/$INDEX_NAME?include_docs=true&query="*:*"&limit=1 HTTP/1.1
Content-Type: application/json
Host: account.cloudant.com
```
{: codeblock}

See the following example that uses the command line to query a partitioned index:

```sh
curl "https://$ACCOUNT.cloudant.com/$DATABASE/_partition/$PARTITION_KEY/_design/$DDOC/_search/$INDEX_NAME?include_docs=true\&query="*:*"\&limit=1"
```
{: codeblock}

See the following example that uses the command line to query a global index:

```sh
curl "https://$ACCOUNT.cloudant.com/$DATABASE/_design/$DDOC/_search/$INDEX_NAME?include_docs=true\&query="*:*"\&limit=1"
```
{: codeblock}

### Query Parameters
{: #query-parameters-search}

You must enable [faceting](#faceting) before you can use the following parameters: `counts` and `drilldown`.
{: important}


| Argument | Description | Optional | Type | Supported Values | Partition Query |
|---------|---------|--------|--------|--------|----------|
| `bookmark` | A bookmark that was received from a previous search. This parameter enables paging through the results. If no results exist after the bookmark, you get a response with an empty rows array and the same bookmark, confirming the end of the result list. | `yes` | String | | Yes |
| `counts` | This field defines an array of names of string fields, for which counts are requested. The response includes counts for each unique value of this field name among the documents that match the search query. [Faceting](/docs/Cloudant?topic=Cloudant-search#faceting) must be enabled for this parameter to function. | Yes | JSON | A JSON array of field names. | No |
| `drilldown` | This field can be used several times. Each use defines a pair of a field name and a value. The search matches only documents that include the value that was provided in the named field. It differs from using `"fieldname:value"` in the `q` parameter only in that the values aren't analyzed. [Faceting](/docs/Cloudant?topic=Cloudant-search#faceting) must be enabled for this parameter to function. | No | JSON | A JSON array that includes two elements: the field name and the value. | Yes |
| `group_field` | Field by which to group search matches. | Yes | String | A string that includes the name of a string field. Fields that include other data such as numbers, objects, or arrays can't be used. | No |
| `group_limit` | Maximum group count. This field can be used only if `group_field` is specified. | Yes | Numeric |  | No |
| `group_sort` | This field defines the order of the groups in a search that uses `group_field`. The default sort order is relevance. | Yes | JSON | This field can have the same values as the sort field, so single fields and arrays of fields are supported. | No |
| `highlight_fields` | Specifies which fields to highlight. If specified, the result object includes a `highlights` field with an entry for each specified field. | Yes | Array of strings |  | Yes|
| `highlight_pre_tag` | A string that is inserted before the highlighted word in the highlights output. | Yes, defaults to `<em>` | String |  | Yes |
| `highlight_post_tag` | A string that is inserted after the highlighted word in the highlights output. | Yes, defaults to `</em>` | String |  | Yes |
| `highlight_number` | Number of fragments that are returned in highlights. If the search term exceeds the fragment size, then the entire search term is returned. | Yes, defaults to 1 | Numeric |  | Yes |
| `highlight_size` | Slice up field content into number of characters, so-called fragments, and highlights matches only inside the specified fragments. | Yes, defaults to 100 characters | Numeric |  | Yes |
| `include_docs` | Include the full content of the documents in the response. | Yes | Boolean |  | Yes |
| `include_fields` | A JSON array of field names to include in search results. Any fields that are included must be indexed with the `store:true` option. | Yes, the default is all fields. | Array of strings | | Yes |
| `limit` | Limit the number of the returned documents to the specified number. For a grouped search, this parameter limits the number of documents per group. | Yes | Numeric | The limit value can be any positive integer number up to and including 200. | Yes | 
| `q` | Abbreviation for `query`. Runs a Lucene query. | No | String or Number |  | Yes |
| `query` | Runs a Lucene query. | No | String or Number |  | Yes |
| `ranges` | This field defines ranges for faceted, numeric search fields. The value is a JSON object where the fields names are faceted numeric search fields, and the values of the fields are JSON objects. The field names of the JSON objects are names for ranges. The values are strings that describe the range, for example `"[0 TO 10]"`. | Yes | JSON | The value must be an object with fields that have objects as their values. These objects must have strings with ranges as their field values. | No |
| `sort` | Specifies the sort order of the results. In a grouped search (when `group_field` is used), this parameter specifies the sort order within a group. The default sort order is relevance. | Yes | JSON | A JSON string of the form `"fieldname<type>"` or `-fieldname<type>` for descending order. The `fieldname` is the name of a String or Number field, and `type` is either a number, a string, or a JSON array of strings. The `type` part is optional, and defaults to `number`. Some examples are `"foo"`, `"-foo"`, `"bar<string>"`, `"-foo<number>"`, and `["-foo<number>","bar<string>"]`. String fields that are used for sorting must not be analyzed fields. Fields that are used for sorting must be indexed by the same indexer that is used for the search query. | Yes | 
| `stale` | Do not wait for the index to finish building to return results. | Yes | String | OK | Yes | 
{: caption="Table 3. Query parameters" caption-side="top"}

Do not combine the `bookmark` and `stale` options. These options constrain the choice of shard replicas to use for the response. When used together, the options might cause problems when you try to contact replicas that are slow or not available.
{: note}

Using `include_docs=true` might have [performance implications](/docs/Cloudant?topic=Cloudant-using-views#multi-document-fetching).
{: important}

### Relevance
{: #relevance}

When more than one result might be returned,
it is possible for them to be sorted.
By default,
the sorting order is determined by 'relevance'.

Relevance is measured according to
[Apache Lucene Scoring](https://lucene.apache.org/core/3_6_0/scoring.html){: new_window}{: external}.
As an example,
if you search a simple database for the word `example`,
two documents might contain the word.
If one document mentions the word `example` 10 times,
but the second document mentions it only twice,
then the first document is considered to be more 'relevant'.

If you don't provide a `sort` parameter,
relevance is used by default.
The highest scoring matches are returned first.

If you provide a `sort` parameter,
then matches are returned in that order,
ignoring relevance.

If you want to use a `sort` parameter,
and also include ordering by relevance in your search results,
use the special fields `-<score>` or `<score>` within the `sort` parameter.

### POSTing search queries
{: #posting-search-queries}

Instead of using the `GET` HTTP method,
you can also use `POST`.
The main advantage of `POST` queries is that they can have a request body,
so you can specify the request as a JSON object.
Each parameter in the previous table corresponds to a field in the JSON object in the request body.

See the following example that uses HTTP to `POST` a search request:

```http
POST /db/_design/ddoc/_search/searchname HTTP/1.1
Content-Type: application/json
Host: account.cloudant.com
```
{: codeblock}

See the following example that uses the command line to `POST` a search request:

```sh
curl "https://account.cloudant.com/db/_design/ddoc/_search/searchname" -X POST -H "Content-Type: application/json" -d @search.json
```
{: codeblock}

See the following example JSON document that includes a search request:

```json
{
    "q": "index:my query",
    "sort": "foo",
    "limit": 3
}
```
{: codeblock}

## Query syntax
{: #query-syntax}

The {{site.data.keyword.cloudant_short_notm}} search query syntax is based on the
[Lucene syntax](http://lucene.apache.org/core/4_3_0/queryparser/org/apache/lucene/queryparser/classic/package-summary.html#Overview){: new_window}{: external}.
Search queries take the form of `name:value` unless the name is omitted,
in which case they use the default field,
as demonstrated in the following examples:

See the following example search query expressions:

```
// Birds
class:bird

// Animals that begin with the letter "l"
l*

// Carnivorous birds
class:bird AND diet:carnivore

// Herbivores that start with letter "l"
l* AND diet:herbivore

// Medium-sized herbivores
min_length:[1 TO 3] AND diet:herbivore

// Herbivores that are 2m long or less
diet:herbivore AND min_length:[-Infinity TO 2]

// Mammals that are at least 1.5m long
class:mammal AND min_length:[1.5 TO Infinity]

// Find "Meles meles"
latin_name:"Meles meles"

// Mammals who are herbivore or carnivore
diet:(herbivore OR omnivore) AND class:mammal

// Return all results
*:*
```
{: codeblock}

Queries over multiple fields can be logically combined,
and groups and fields can be further grouped.
The available logical operators are case-sensitive and are `AND`,
`+`,
`OR`,
`NOT`, and `-`.
Range queries can run over strings or numbers.

If you want a fuzzy search,
you can run a query with `~` to find terms like the search term.
For instance,
`look~` finds the terms `book` and `took`.

If the higher bounds of a range query are both strings that contain only numeric digits, the bounds are treated as numbers not as strings. For example, if you search by using the query `mod_date:["20170101" TO "20171231"]`, the results include documents for which `mod_date` is between the numeric values 20170101 and 20171231, not between the strings "20170101" and "20171231".
{: note}

You can alter the importance of a search term by adding `^` and a positive number.
This alteration creates matches that contain the term more or less relevant,
proportional to the power of the boost value.
The default value is 1,
which means no increase or decrease in the strength of the match.
A decimal value of 0 - 1 reduces importance,
making the match strength weaker.
A value greater than one increases importance,
making the match strength stronger.

Wildcard searches are supported,
for both single (`?`) and multiple (`*`) character searches.
For example,
`dat?` would match `date` and `data`,
and `dat*` would match `date`,
`data`,
`database`,
and `dates`.
Wildcards must come after the search term.

Use `*:*` to return all results.

Result sets from searches are limited to 200 rows,
and return 25 rows by default.
The number of rows that are returned can be changed
by using the [`limit` parameter](#query-parameters-search).

If the search query does not specify the `"group_field"` argument,
the response includes a bookmark.
If this bookmark is later provided as a URL parameter,
the response skips the rows that were seen already,
making it quick and easy to get the next set of results.

The response never includes a bookmark if the [`"group_field"` parameter](#query-parameters-search) is included in the search query.
{: tip}

The `group_field`, `group_limit`, and `group_sort` options are only available when you make global queries.
{: tip}

The following characters require escaping if you want to search on them:

```http
+ - && || ! ( ) { } [ ] ^ " ~ * ? : \ /
```
{: codeblock}

To escape one of these characters,
use a preceding backslash character (`\`).

The response to a search query includes an `order` field for each of the results.
The `order` field is an array where the first element is the field or fields that are specified
in the `sort` parameter.
If no [`sort` parameter](#query-parameters-search) is included in the query,
then the `order` field contains the [Lucene relevance score](https://lucene.apache.org/core/3_6_0/scoring.html){: new_window}{: external}.
If you use the `sort by distance` feature as described in [Geographical searches](#geographical-searches),
then the first element is the distance from a point.
The distance is measured by using either kilometers or miles.

The second element in the order array can be ignored.
It is used for troubleshooting purposes only.
{: tip}

## Faceting
{: #faceting}

{{site.data.keyword.cloudant_short_notm}} Search also supports faceted searching, which
enables the discovery of aggregate information about matches quickly and easily.
You can match all documents by using the special `?q=*:*` query syntax,
and use the returned facets to refine your query.
To indicate that a field must be indexed for faceted queries,
set `{"facet": true}` in its options.

See the following example search query, specifying that faceted search is enabled:

```javascript
function(doc) {
    index("type", doc.type, {"facet": true});
    index("price", doc.price, {"facet": true});
}
```
{: codeblock}

To use facets,
all the documents in the index must include all the fields that have faceting enabled.
If your documents don't include all the fields,
you receive a `bad_request` error with the following reason, "The `field_name` does not exist."
If each document does not contain all the fields for facets,
create separate indexes for each field.
If you don't create separate indexes for each field,
you must include only documents that contain all the fields.
Verify that the fields exist in each document by using a single `if` statement.

See the following example `if` statement to verify that the required fields exist in each document:

```javascript
if (typeof doc.town == "string" && typeof doc.name == "string") {
        index("town", doc.town, {facet: true});
        index("name", doc.name, {facet: true});        
    }
```
{: codeblock}

### Counts
{: #counts}

The `counts` option is only available when you make global queries.
{: tip}

The `counts` facet syntax takes a list of fields,
and returns the number of query results for each unique value of each named field.

The `count` operation works only if the indexed values are strings.
The indexed values can't be mixed types.
For example,
if 100 strings are indexed,
and one number,
then the index can't be used for `count` operations.
You can check the type by using the `typeof` operator,
and convert it by using the `parseInt`,
`parseFloat`,
or `.toString()` functions.
{: note}

See the following example query that uses the `counts` facet syntax: 

```http
?q=*:*&counts=["type"]
```
{: codeblock}

See the following example response after you use the `counts` facet syntax:

```json
{
    "total_rows":100000,
    "bookmark":"g...",
    "rows":[...],
    "counts":{
        "type":{
            "sofa": 10,
            "chair": 100,
            "lamp": 97
        }
    }
}
```
{: codeblock}

### `drilldown`
{: #drilldown}

The `drilldown` option is only available when you make global queries.
{: tip}

You can restrict results to documents with a dimension equal to the specified label.
Restrict the results by adding `drilldown=["dimension","label"]` to a search query.
You can include multiple `drilldown` parameters to restrict results along multiple dimensions.

Using a `drilldown` parameter is similar to using `key:value` in the `q` parameter,
but the `drilldown` parameter returns values that the analyzer might skip.

For example,
if the analyzer didn't index a stop word like `"a"`,
the `drilldown` parameter returns it when you specify `drilldown=["key","a"]`.

### Ranges
{: #ranges}

The `ranges` option is only available when you make global queries.
{: tip}

The `range` facet syntax reuses the standard Lucene syntax for ranges
to return counts of results that fit into each specified category.
Inclusive range queries are denoted by brackets (`[`, `]`).
Exclusive range queries are denoted by curly brackets (`{`, `}`).

The indexed values can't be mixed types.
For example,
if 100 strings are indexed,
and one number,
then the index can't be used for `range` operations.
You can check the type by using the `typeof` operator,
and convert it by using the `parseInt`,
`parseFloat`,
or `.toString()` functions.
{: note}

See the following example of a request that uses faceted search for matching `ranges`:

```http
?q=*:*&ranges={"price":{"cheap":"[0 TO 100]","expensive":"{100 TO Infinity}"}}
```
{: codeblock}

See the following example results after a `ranges` check on a faceted search:

```json
{
    "total_rows":100000,
    "bookmark":"g...",
    "rows":[...],
    "ranges": {
        "price": {
            "expensive": 278682,
            "cheap": 257023
        }
    }
}
```
{: codeblock}

## Geographical searches
{: #geographical-searches}

In addition to searching by the content of textual fields,
you can also sort your results by their distance from a geographic coordinate.

To sort your results in this way,
you must index two numeric fields
that represent the longitude and latitude.

You can then query by using the special `<distance...>` sort field,
which takes five parameters:

-   Longitude field name - The name of your longitude field (`mylon` in the example).
-   Latitude field name -  The name of your latitude field (`mylat` in the example).
-   Longitude of origin - The longitude of the place you want to sort by distance from.
-   Latitude of origin - The latitude of the place you want to sort by distance from.
-   Units - The units to use include, `km` for kilometers or `mi` for miles. The distance is returned in the order field.

You can combine sorting by distance with any other search query,
such as range searches on the latitude and longitude,
or queries that involve non-geographical information.

That way,
you can search in a bounding box,
and narrow down the search with extra criteria.

See the following example geographical data:

```json
{
    "name":"Aberdeen, Scotland",
    "lat":57.15,
    "lon":-2.15,
    "type":"city"
}
```
{: codeblock}

See the following example of a design document that includes a search index for the geographic data:

```javascript
function(doc) {
    if (doc.type && doc.type == 'city') {
        index('city', doc.name, {'store': true});
        index('lat', doc.lat, {'store': true});
        index('lon', doc.lon, {'store': true});
    }
}
```
{: codeblock}

See the following example that uses HTTP for a query that sorts cities in the northern hemisphere by their distance to New York:

```http
GET /examples/_design/cities-designdoc/_search/cities?q=lat:[0+TO+90]&sort="<distance,lon,lat,-74.0059,40.7127,km>" HTTP/1.1
Host: $ACCOUNT.cloudant.com
```
{: codeblock}

See the following example that uses the command line for a query that sorts cities in the northern hemisphere by their distance to New York:

```sh
curl "https://$ACCOUNT.cloudant.com/examples/_design/cities-designdoc/_search/cities?q=lat:[0+TO+90]&sort="<distance,lon,lat,-74.0059,40.7127,km>""
```
{: codeblock}

See the following example (abbreviated) response that includes a list of northern hemisphere cities that are sorted by distance to New York:

```json
{
    "total_rows": 205,
    "bookmark": "g1A...XIU",
    "rows": [
        {
            "id": "city180",
            "order": [
                8.530665755719783,
                18
            ],
            "fields": {
                "city": "New York, N.Y.",
                "lat": 40.78333333333333,
                "lon": -73.96666666666667
            }
        },
        {
            "id": "city177",
            "order": [
                13.756343205985946,
                17
            ],
            "fields": {
                "city": "Newark, N.J.",
                "lat": 40.733333333333334,
                "lon": -74.16666666666667
            }
        },
        {
            "id": "city178",
            "order": [
                113.53603438866077,
                26
            ],
            "fields": {
                "city": "New Haven, Conn.",
                "lat": 41.31666666666667,
                "lon": -72.91666666666667
            }
        }
    ]
}
```
{: codeblock}

## Highlighting search terms
{: #highlighting-search-terms}

Sometimes it is useful to get the context in which a search term was mentioned
so that you can show more emphasized results to a user.

To get more emphasized results,
add the `highlight_fields` parameter to the search query.
Specify the field names for which you would like excerpts,
with the highlighted search term returned.

By default,
the search term is placed in `<em>` tags to highlight it,
but the highlight can be overridden by using the `highlights_pre_tag` and `highlights_post_tag` parameters.

The length of the fragments is 100 characters by default.
A different length can be requested with the `highlights_size` parameter.

The `highlights_number` parameter controls the number of fragments that are returned,
and defaults to 1.

In the response,
a `highlights` field is added,
with one subfield per field name.

For each field,
you receive an array of fragments with the search term highlighted.

For highlighting to work,
store the field in the index by using the `store: true` option.
{: tip}

See the following example that uses HTTP to search with highlighting enabled:

```http
GET /movies/_design/searches/_search/movies?q=movie_name:Azazel&highlight_fields=["movie_name"]&highlight_pre_tag=""&highlight_post_tag=""&highlights_size=30&highlights_number=2 HTTP/1.1
HOST: $ACCOUNT.cloudant.com
Authorization: ...
```
{: codeblock}

See the following example that uses the command line to search with highlighting enabled:

```sh
curl "https://$ACCOUNT:$PASSWORD@$ACCOUNT.cloudant.com/movies/_design/searches/_search/movies?q=movie_name:Azazel&highlight_fields=\[\"movie_name\"\]&highlight_pre_tag=\" \"&highlight_post_tag=\" \"&highlights_size=30&highlights_number=2"
```
{: codeblock}

See the following example of highlighted search results:

```json
{
    "highlights": {
        "movie_name": [
            " on the Azazel Orient Express",
            " Azazel manuals, you"
        ]
    }
}
```
{: codeblock}

## Search index metadata
{: #search-index-metadata}

To retrieve information about a search index,
you send a `GET` request to the `_search_info` endpoint,
as shown in the following example.
`DDOC` refers to the design document that includes the index,
and `INDEX_NAME` is the name of the index.

See the following example that uses HTTP to request search index metadata:

```http
GET /$DATABASE/_design/$DDOC/_search_info/$INDEX_NAME HTTP/1.1
```
{: codeblock}

See the following example that uses the command line to request search index metadata:

```sh
curl "https://$ACCOUNT.cloudant.com/$DATABASE/_design/$DDOC/_search_info/$INDEX_NAME" \
     -X GET
```
{: codeblock}

The response includes information about your index,
such as the number of documents in the index and the size of the index on disk.

See the following example response after you request search index metadata:

```json
{
    "name": "_design/DDOC/INDEX",
    "search_index": {
        "pending_seq": 7125496,
        "doc_del_count": 129180,
        "doc_count": 1066173,
        "disk_size": 728305827,
        "committed_seq": 7125496
    }
}
```
{: codeblock}
