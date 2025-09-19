---

copyright:
  years: 2015, 2025
lastupdated: "2025-09-19"

keywords: cloudant query, create index, text index type, performance

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# Working with text indexes
{: #working-with-text-indexes}

Text indexes are {{site.data.keyword.cloudant_short_notm}} Query indexes that excel at supporting flexible queries, where the exact fields are not known in advance or use `$or` and `$not` operators. Create text indexes to support queries that have these characteristics.
{: shortdesc}

When you create a single text index, it's a good practice to use the default values, but some useful index attributes can be modified.

A `text` index can be partitioned or global; this option is set by using the `partitioned` field.

For Full Text Indexes (FTIs), `type` must be set to `text`.
{: tip}

The `name` and `ddoc` attributes are for grouping indexes into design documents.
Use the attributes to refer to index groups by using a custom string value.
If no values are supplied for these fields,
they're automatically populated with a hash value.

If you create multiple text indexes in a database,
with the same `ddoc` value,
you need to know at least the `ddoc` value and the `name` value.
Creating multiple indexes with the same `ddoc` value places them into the same design document.
Generally,
you must put each text index into its own design document.

For more information,
see the [more about `text` indexes](/docs/Cloudant?topic=Cloudant-note-about-text-indexes).

See the following example of a JSON document that requests a partitioned index creation:

```json
{
    "index": {
        "fields": [
            {
                "name": "Movie_name",
                "type": "string"
            }
        ]
    },
    "name": "Movie_name-text",
    "type": "text",
    "partitioned": true
}
```
{: codeblock}

See the following example of JSON document that requests a global index creation:

```json
{
    "index": {
        "fields": [
            {
                "name": "Movie_name",
                "type": "string"
            }
        ]
    },
    "name": "Movie_name-text",
    "type": "text",
    "partitioned": false
}
```
{: codeblock}

See the following example of a JSON document that requests creation of a more complex partitioned index:

```json
{
    "type": "text",
    "name": "my-index",
    "ddoc": "my-index-design-doc",
    "index": {
        "default_field": {
            "enabled": true,
            "analyzer": "german"
        },
        "selector": {},
        "fields": [
            {"name": "married", "type": "boolean"},
            {"name": "lastname", "type": "string"},
            {"name": "year-of-birth", "type": "number"}
        ]
    },
    "partitioned": true
}
```
{: codeblock}

## The `index` field
{: #the-index-field}

The `index` field contains settings specific to text indexes.

To index all fields in all documents automatically,
use the simple syntax:

```json
"index": {}
```
{: codeblock}

The indexing process traverses all of the fields in all the documents in the database.

In the [example movies' demo database](/docs/Cloudant?topic=Cloudant-example-movies-demo-database), you can see an example of a text index that contains all fields and all documents in a database.

Take care when you index all fields in all documents for large data sets as it might be a resource-consuming activity.
{: tip}

See the following example of a JSON document that requests creation of an index of all fields in all documents:

```json
{
	"type": "text",
	"index": { }
}
```
{: codeblock}

## The `default_field` field
{: #the-default-field-field}

The `default_field` value specifies how the `$text` operator can be used with the index.

The `default_field` includes two keys:

| Key        | Description |
|-----------|------------|
| `enabled`  | Enable or disable the `default_field index`. The default value is `true`. |
{: caption="Default_field field keys" caption-side="top"}

The `analyzer` key in the `default_field` specifies how the index analyzes text.
Later,
the index can be queried by using the `$text` operator. For more information, see the [Search documentation](/docs/Cloudant?topic=Cloudant-search-analyzers) for alternative analyzers.
You might choose an alternative analyzer when documents are indexed in languages other than English,
or when you have other special requirements for the analyzer, such as matching email addresses.

If the `default_field` isn't specified,
or is supplied with an empty object,
it defaults to `true` and the `standard` analyzer is used.

## The `fields` array
{: #the-fields-array}

The `fields` array includes a list of fields that must be indexed for each document.
If you know an index queries only on specific fields,
then this field can be used to limit the size of the index.
Each field must also specify a type to be indexed.
The acceptable types are shown in the following list:

-	`"boolean"`
-	`"string"`
-	`"number"`

## The `index_array_lengths` field
{: #the-index_array_lengths-field}

{{site.data.keyword.cloudant_short_notm}} Query text indexes have a property that is called `index_array_lengths`.
If the property isn't explicitly set,
the default value is `true`.

If the field is set to `true`,
the index requires extra work. This work contains a scan of every document for any arrays,
and creating a field to hold the length for each array found.

You might prefer to set the `index_array_lengths` field to `false` in the following situations:

-	You don't need to know the length of an array.
-	You don't use the `$size` operator.
-	The documents in your database are complex,
	or not completely under your control.
	As a result, it's difficult to estimate the impact of the extra processing that is needed to determine and store the array lengths.

The `$size` operator requires that you set the `index_array_lengths` field to `true`. Otherwise, the operator can't work.
{: tip}

See the following example JSON document with suggested settings to optimize performance on production systems:

```json
{
	"default_field": {
		"enabled": false
	},
	"index_array_lengths": false
}
```
{: codeblock}

## The `partitioned` field
{: #section2-the-partitioned-field}

This field determines whether the created index is a partitioned or global index.

| Value  | Description           | Notes |
|---------|---------------------|------------|
| `true` | Create the index as partitioned.   | Can be used only in a partitioned database. |
| `false`    | Create the index as global.  | Can be used in any database. |
{: caption="Partitioned field values" caption-side="top"}

The default follows the `partitioned` setting for the database:

| Is the database partitioned? | Default `partitioned` value | Allowed values |
|---------|----------|---------|
| Yes  | `true`  | `true`, `false` |
| No   | `false` | `false` |
{: caption="Partitioned settings for the database" caption-side="top"}

## Advanced: `text` index internals
{: #advanced-text-index-internals}

The basic premise for full text indexes is that a document
is "expanded" into a list of `key:value` pairs that are indexed by Lucene.
This expansion enables the use of Lucene's search syntax as a basis for the query capability.
{: shortdesc}

This technique supports enhanced searches,
but does have certain limitations.
For example,
it might not always be clear whether content for an expanded document came
from individual elements or an array.

The query mechanism resolves this uncertainty by preferring to return "false positive" results.
In other words,
if a match was found because of a search for either an individual element,
or an element from an array,
then the match is considered a success.

Like {{site.data.keyword.cloudantfull}} Search indexes, {{site.data.keyword.cloudant_short_notm}} Query indexes of `type: text` are limited to 200 results when queried.
{: tip}

### Selector conversion
{: #selector-conversion}

A standard Lucene search expression might not fully implement the wanted JSON-based {{site.data.keyword.cloudant_short_notm}} query syntax.
Therefore,
a conversion between the two formats takes place.

In the following example,
the JSON query approximates to the English phrase, *Match if the age expressed as a number is greater than five and less than or equal to infinity.* The Lucene query corresponds to that phrase, where the text `_3a` within the field name corresponds to the `age:number` field, and is an example of the document content expansion that was mentioned earlier.

See the following example query to be converted:

```json
{
	"age": {
		"$gt": 5
	}
}
```
{: codeblock}

#### The corresponding Lucene query
{: #corresponding-lucene-query}

```javascript
(age_3anumber:{5 TO Infinity])
```
{: codeblock}

### A more complex example
{: #a-more-complex-example}

The following example illustrates some important points.

#### JSON query to be converted to Lucene
{: #json-query-convert-lucene}

```json
{
	"$or": [
		{
			"age": {
				"$gt": 5
			}
		},
		{
			"twitter": {
				"$exists":true
			}
		},
		{
			"type": {
				"$in": [
					"starch",
					"protein"
				]
			}
		}
	]
}
```
{: codeblock}

The first part of the JSON query is straightforward to convert to Lucene;
the test determines whether the `age` field has a numerical value greater than 5.
The `{` character in the range expression means that the value 5 isn't considered a match.

To implement the `"twitter": {"$exists":true}` part of the JSON query in Lucene,
the first test is to determine whether a `twitter` field exists.
However,
the field might be either an array or an object, so
the match must succeed when the value is an array *or* an object.

This requirement means that the `$fieldnames` field must have entries that contain either `twitter.*` or `twitter:*`.
The `.` character is represented in the query as the ASCII character sequence `_2e`.
Similarly,
the `:` character is represented in the query as the ASCII character sequence `_3a`.
This representation requires the use of a two clause `OR` query for the `twitter` field,
ending in `_2e*` and `_3a*`.
Implementing this query as two phrases instead of a single `twitter*` query prevents an accidental match
with a field name such as `twitter_handle` or similar.

The last of the three main clauses are a search for `starch` or `protein`.
This search is more complicated.
The `$in` operator has some special semantics for array values that are inherited from the way MongoDB behaves.
In particular,
the `$in` operator applies to the value **or** any of the values that are contained in an array that is named by the field.
In this example,
the expression means that both `"type":"starch"` **and** `"type":["protein"]` would match the example argument to `$in`.
Earlier,
the `type_3astring` expression was converted to `type:string`.
The second `type_2e_5b_5d_3astring` phrase converts to `type.[]:string`,
which is an example of the expanded array indexing.

#### Corresponding Lucene query explained
{: #corresponding-lucene-query-explained}

The "#" comments aren't valid Lucene syntax, but help explain the query construction.

```javascript
(
	# Search for age > 5
	(age_3anumber:{5 TO Infinity])

	# Search for documents that contain the twitter field
	(($fieldnames:twitter_2e*) OR ($fieldnames:twitter_3a*))

	# Search for type = starch
	(
		((type_3astring:starch) OR (type_2e_5b_5d_3astring:starch))

		# Search for type = protein
		((type_3astring:protein) OR (type_2e_5b_5d_3astring:protein))
	)
)
```
{: codeblock}
