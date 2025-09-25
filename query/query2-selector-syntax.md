---

copyright:
  years: 2015, 2025
lastupdated: "2025-09-25"

keywords: selector expressions, sort, filter, pagination, partitioned field, index field, default_field field, fields array, index_array_lengths field, selector syntax

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# Query selector syntax
{: #selector-syntax}

The {{site.data.keyword.cloudant_short_notm}} Query language is expressed as a JSON object that describes documents of interest.
Within this structure,
you can apply conditional logic by using specially named fields.
{: shortdesc}

The {{site.data.keyword.cloudant_short_notm}} Query language has some similarities with MongoDB query documents, but these similarities arise from a commonality of purpose and don't necessarily extend to equivalence of function or result.

## Selector basics
{: #selector-basics}

Elementary selector syntax requires you to specify one or more fields,
and the corresponding values needed for those fields.
The following example selector matches all
documents that have a `director` field that contains the value `Lars von Trier`.

See the following example of a simple selector:

```json
{
	"selector": {
		"director": "Lars von Trier"
	}
}
```
{: codeblock}


If you created a full text index by specifying `"type":"text"` when the index was created,
you can use the `$text` operator to select matching documents.
In the following example,
the full text index is inspected to find any document that contains the word `Bond`.

See the following example of a simple selector for a full_text index:

```json
{
	"selector": {
		"$text": "Bond"
	}
}
```
{: codeblock}

You can create more complex selector expressions by combining operators.
However,
for {{site.data.keyword.cloudant_short_notm}} Query indexes of type `json`,
you can't use "combination" or "array logical" operators such as `$regex` as the *basis* of a query.
Only the equality operators such as `$eq`,
`$gt`,
`$gte`,
`$lt`,
and `$lte` - but *not* `$ne` - can be used as the basis of a more complex query.
For more information about creating complex selector expressions,
see [Creating selector expressions](#creating-selector-expressions).

## Selector with two fields
{: #selector-with-two-fields}

In the following example,
the selector matches any document with a `name` field that contains `Paul`,
*and* that also has a `location` field with the value "Boston".

See the following example of a more complex selector:

```json
{
	"selector": {
		"name": "Paul",
		"location": "Boston"
	}
}
```
{: codeblock}

## Subfields
{: #subfields}

Use a more complex selector to specify the values for a field of nested objects,
or subfields.
For example,
you might use a standard JSON structure for specifying a field *and* a subfield.

See the following example of a field and subfield selector within a JSON object:

```json
{
	"selector": {
		"imdb": {
			"rating": 8
		}
	}
}
```
{: codeblock}

An abbreviated equivalent uses a dot notation to combine the field and subfield names into a single name.

See the following example of an equivalent field and subfield selector that uses dot notation:

```json
{
	"selector": {
		"imdb.rating": 8
	}
}
```
{: codeblock}

## Building more complex selector expressions
{: #building-complex-selector-expressions}

In general,
whenever you have an operator that takes an argument,
that argument can itself be another operator with arguments of its own.
This expansion enables more complex selector expressions.
{: shortdesc}

Combination or array logical operators, such as `$regex`, can
result in a full database scan when you use indexes of type JSON,
resulting in poor performance. Only equality operators, such as `$eq`,
`$gt`, `$gte`, `$lt`, and `$lte` (but not `$ne`), enable index lookups. To ensure that indexes are used effectively, analyze the
[explain plan](#explain-plans) for each query.  

Most selector expressions work exactly as you would expect for the operator.
The matching algorithms that are used by the `$regex` operator are currently *based* on
the [Perl Compatible Regular Expression (PCRE) library](https://en.wikipedia.org/wiki/Perl_Compatible_Regular_Expressions){: external}.
However, not all of the PCRE library is implemented.
Additionally, some parts of the `$regex` operator go beyond what PCRE offers.
For more information about what is implemented,
see the [Erlang Regular Expression](https://www.erlang.org/doc/man/re.html){: external} information.

## Using the `$text` operator
{: #using-the-text-operator}

The `$text` operator is based on a Lucene search with a standard analyzer.
The operator isn't case-sensitive, and matches on any words.
However,
the `$text` operator doesn't support full Lucene syntax,
such as wildcards,
fuzzy matches,
or proximity detection.

For more information,
see the [Search documentation](/docs/Cloudant?topic=Cloudant-cloudant-search).
The `$text` operator applies to all strings found in the document.
If you place this operator in the context of a field name, it's invalid.

