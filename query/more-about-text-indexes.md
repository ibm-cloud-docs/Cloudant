---

copyright:
  years: 2015, 2022
lastupdated: "2022-10-20"

keywords: create index, query, json index type, text index type, query parameters, partial index

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# More about `text` indexes
{: #note-about-text-indexes}

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

## Selector conversion
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

### The corresponding Lucene query
{: #corresponding-lucene-query}

```javascript
(age_3anumber:{5 TO Infinity])
```
{: codeblock}

## A more complex example
{: #a-more-complex-example}

The following example illustrates some important points.

### JSON query to be converted to Lucene
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

### Corresponding Lucene query explained
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
