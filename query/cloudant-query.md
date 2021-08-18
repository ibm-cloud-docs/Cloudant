---

copyright:
  years: 2015, 2021
lastupdated: "2021-08-18"

keywords: create index, query, json index type, text index type, query parameters, partial index, implicit operators, explicit operators, combination operators, condition operators, selector expressions, sort, filter,  pagination, partitioned field, index field, default_field field, fields array, index_array_lengths field, list indexes, delete index, selector syntax

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

# Working with {{site.data.keyword.cloudant_short_notm}} Query
{: #query}

{{site.data.keyword.cloudantfull}} Query is a declarative JSON querying syntax for
{{site.data.keyword.cloudant_short_notm}} databases. You can use a `json` or `text` type of index with {{site.data.keyword.cloudant_short_notm}}.
{: shortdesc}

In the following cases, you can specify how the index is created by
making it of type `json`:

- You know exactly what data you want to look for.
- You want to keep storage and processing requirements to a minimum.

But for maximum flexibility when you search for data, you typically create
an index of type `text`. Indexes of type `text` have a simple mechanism for automatically
indexing all the fields in the documents.

While more flexible, `text` indexes might take longer to create and require more storage resources than `json` indexes.
{: tip}

## Creating an index
{: #creating-an-index}

You can create an index with one of the following types:

-	`"type": "json"`
-	`"type": "text"`

### Creating a `type=json` index
{: #creating-a-type-json-index}

To create a JSON index in the database `$DATABASE`,
make a `POST` request to `/$DATABASE/_index` with a JSON object that describes the index in the request body.
The `type` field of the JSON object must be set to `json`. A JSON index can be partitioned or
global; this option is set by using the `partitioned` field.

See the following example that uses HTTP to request an index of type `JSON`:

```http
POST /$DATABASE/_index HTTP/1.1
Content-Type: application/json
```
{: codeblock}

See the following example of a JSON object that creates a partitioned index that is called `foo-partitioned-index` for the field called `foo`:

```json
{
    "index": {
        "fields": ["foo"]
    },
    "name" : "foo-partitioned-index",
    "type" : "json",
    "partitioned": true
}
```
{: codeblock}

See the following example of a JSON object that creates a global index that is called `bar-global-index` for the field called `bar`:

```json
{
    "index": {
        "fields": ["bar"]
    },
    "name" : "bar-global-index",
    "type" : "json",
    "partitioned": false
}
```
{: codeblock}

See the following example of returned JSON, confirming that the index was created:

```json
{
    "result": "created"
}
```
{: codeblock}

| Field | Description | 
|-------|-------------|
| `index` | fields - A JSON array of field names that uses the [sort syntax](/docs/Cloudant?topic=Cloudant-query#sort-syntax). Nested fields are also allowed, for example, `person.name`. |
| `ddoc` (optional) | Name of the design document in which the index is created. By default, each index is created in its own design document. Indexes can be grouped into design documents for efficiency. However, a change to one index in a design document invalidates all other indexes in the same document. |
| `type` (optional) | Can be `json` or `text`. Defaults to `json`. Geospatial indexes will be supported in the future. | 
| `name` (optional) | Name of the index. If no name is provided, a name is generated automatically. |
| `partitioned` (optional, boolean) | Determines whether this index is partitioned. For more information, see [the `partitioned` field](#section1-the-partitioned-field).|
{: caption="Table 1. Request body format" caption-side="top"}

#### The `partitioned` field
{: #section1-the-partitioned-field}

This field sets whether the created index is a partitioned or global index.

Value  | Description           | Notes
---------|---------------------|------------
`true` | Create the index as partitioned.   | Can be used only in a partitioned database.
`false`    | Create the index as global.  | Can be used in any database.
{: caption="Table 2. Partitioned field values" caption-side="top"}

The default follows the `partitioned` setting for the database:

Is the database partitioned? | Default `partitioned` value | Allowed values
---------|----------|---------
Yes  | `true`  | `true`, `false`
No   | `false` | `false`
{: caption="Table 3. Default partitioned value" caption-side="top"}

It's important to reiterate that the default `partitioned` value is `true`
for indexes that are created in a partitioned database. This default  value means that the index *cannot*
be used to satisfy global queries.
{: important}

Code | Description
-----|------------
200  | Index was created successfully or existed in the database.
400  | Bad request - the request body doesn't have the specified format.
{: caption="Table 4. Return codes" caption-side="top"}

### Creating a `type=text` index
{: #creating-a-type-text-index}

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
see the [note about `text` indexes](#note-about-text-indexes).

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

#### The `index` field
{: #the-index-field}

The `index` field contains settings specific to text indexes.

To index all fields in all documents automatically,
use the simple syntax:

```json
"index": {}
```
{: codeblock}

The indexing process traverses all of the fields in all the documents in the database.

In the [example movies demo database](#example-movies-demo-database), you can see an example of a text index that contains all fields and all documents in a database.

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

#### The `default_field` field
{: #the-default-field-field}

The `default_field` value specifies how the `$text` operator can be used with the index.

The `default_field` includes two keys:

Key        | Description
-----------|------------
`analyzer` | Specifies the Lucene analyzer to use. The default value is `standard`.
`enabled`  | Enable or disable the `default_field index`. The default value is `true`.
{: caption="Table 5. Default_field field keys" caption-side="top"}

The `analyzer` key in the `default_field` specifies how the index analyzes text.
Later,
the index can be queried by using the `$text` operator. For more information, see the [Search documentation](/docs/Cloudant?topic=Cloudant-search#analyzers) for alternative analyzers.
You might choose an alternative analyzer when documents are indexed in languages other than English,
or when you have other special requirements for the analyzer, such as matching email addresses.

If the `default_field` isn't specified,
or is supplied with an empty object,
it defaults to `true` and the `standard` analyzer is used.

#### The `fields` array
{: #the-fields-array}

The `fields` array includes a list of fields that must be indexed for each document.
If you know an index queries only on specific fields,
then this field can be used to limit the size of the index.
Each field must also specify a type to be indexed.
The acceptable types are shown in the following list:

-	`"boolean"`
-	`"string"`
-	`"number"`

#### The `index_array_lengths` field
{: the-index_array_lengths-field}

{{site.data.keyword.cloudant_short_notm}} Query text indexes have a property that is called `index_array_lengths`.
If the property isn't explicitly set,
the default value is `true`.

If the field is set to `true`,
the index requires extra work. This work contains a scan of every document for any arrays,
and creating a field to hold the length for each array found.

You might prefer to set the `index_array_lengths` field to `false` in the following situations:

-	You don't need to know the length of an array.
-	You don't use the [`$size` operator](#the-size-operator).
-	The documents in your database are complex,
	or not completely under your control.
	As a result, it's difficult to estimate the impact of the extra processing that is needed to determine and store the array lengths.

The [`$size` operator](#the-size-operator) requires that you set the `index_array_lengths` field to `true`. Otherwise, the operator can't work.
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

#### The `partitioned` field
{: #section2-the-partitioned-field}

This field determines whether the created index is a partitioned or global index.

Value  | Description           | Notes
---------|---------------------|------------
`true` | Create the index as partitioned.   | Can be used only in a partitioned database.
`false`    | Create the index as global.  | Can be used in any database.
{: caption="Table 6. Partitioned field values" caption-side="top"}

The default follows the `partitioned` setting for the database:

Is the database partitioned? | Default `partitioned` value | Allowed values
---------|----------|---------
Yes  | `true`  | `true`, `false`
No   | `false` | `false`
{: caption="Table 7. Partitioned settings for the database" caption-side="top"}

## {{site.data.keyword.cloudant_short_notm}} Query Parameters
{: #ibm-cloudant-query-parameters}

The format of the `selector` field is as described in the [selector syntax](#selector-syntax),
except for the `$text` operator.

The `$text` operator is based on a Lucene search with a standard analyzer.
The operator isn't case-sensitive, and matches on any words.
However,
the `$text` operator doesn't support full Lucene syntax,
such as wildcards,
fuzzy matches,
or proximity detection.
For more information,
see the [Search documentation](/docs/Cloudant?topic=Cloudant-search#search).
The `$text` operator applies to all strings found in the document.
If you place this operator in the context of a field name, it's invalid.

The `fields` array is a list of fields that must be returned for each document. The provided
field names can use dotted notation to access subfields.

See the following example JSON document that uses all available query parameters:

```json
{
	"selector": {
		"year": {
			"$gt": 2010
		}
	},
	"fields": ["_id", "_rev", "year", "title"],
	"sort": [{"year": "asc"}],
	"limit": 10,
	"skip": 0
	}
```
{: codeblock}

## Working with indexes
{: #working-with-indexes}

{{site.data.keyword.cloudant_short_notm}} endpoints can be used to create,
list,
update,
and delete indexes in a database,
and to query data by using these indexes.

Methods  | Path                | Description
---------|---------------------|------------
`DELETE` | `/$DATABASE/_index` | Delete an index.
`GET`    | `/$DATABASE/_index` | List all {{site.data.keyword.cloudant_short_notm}} Query indexes.
`POST`   | `/$DATABASE/_find`  | Find documents by using a global index.
`POST`   | `/$DATABASE/_partition/$PARTITION_KEY/_find`  | Find documents by using a partitioned index.
`POST`   | `/$DATABASE/_index` | Create an index.
{: caption="Table 8. Available methods and endpoints" caption-side="top"}

## Creating a partial index
{: #creating-a-partial-index}

{{site.data.keyword.cloudant_short_notm}} Query supports partial indexes by using the `partial_filter_selector` field. For more information, see the [CouchDB documentation](http://docs.couchdb.org/en/2.1.1/api/database/find.html#partial-indexes){: new_window}{: external}
and the original example. 

The `partial_filter_selector` field replaces the `selector` field, previously only valid in text indexes. The `selector` field is still compatible with an earlier version for text indexes only.
{: tip}

See the following example query:

```json
{
  "selector": {
    "status": {
      "$ne": "archived"
    },
    "type": "user"
  }
}
```
{: codeblock}

Without a partial index, this query requires a full index scan to find
all the documents of `type`:`user` that don't have a status of `archived`.
This situation occurs because a normal index can be used to match contiguous rows,
and the `$ne` operator can't guarantee that.

To improve response time, you can create an index that excludes documents 
with `status: { $ne: archived }` at index time by using the 
`partial_filter_selector` field shown in the following example:

```json
POST /db/_index HTTP/1.1
Content-Type: application/json
Content-Length: 144
Host: localhost:5984

{
  "index": {
    "partial_filter_selector": {
      "status": {
        "$ne": "archived"
      }
    },
    "fields": ["type"]
  },
  "ddoc" : "type-not-archived",
  "type" : "json"
}
```
{: codeblock}

Partial indexes aren't currently used by the query planner unless specified
by a `use_index` field, so you must modify the original query:

```json
{
  "selector": {
    "status": {
      "$ne": "archived"
    },
    "type": "user"
  },
  "use_index": "type-not-archived"
}
```
{: codeblock}

Technically, you don't need to include the filter on the `status` field in the
query selector. The partial index ensures that this value is always true. However, if you include the filter, it makes the intent of the selector clearer. It also makes it easier to take advantage of future improvements to query planning (for example, automatic selection of partial indexes).

## Selector syntax
{: #selector-syntax}

The {{site.data.keyword.cloudant_short_notm}} Query language is expressed as a JSON object that describes documents of interest.
Within this structure,
you can apply conditional logic by using specially named fields.

The {{site.data.keyword.cloudant_short_notm}} Query language has some similarities with MongoDB query documents, but these similarities arise from a commonality of purpose and don't necessarily extend to equivalence of function or result.

### Selector basics
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

### Selector with two fields
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

## Operators
{: #operators}

Operators are identified by the use of a dollar sign (`$`) prefix in the name field.

The selector syntax has two core types of operators:

-	Combination operators
-	Condition operators

In general,
combination operators are applied at the topmost level of selection.
They're used to combine conditions,
or to create combinations of conditions,
into one selector.

Every explicit operator has the form:

```json
{
	"$operator": "argument"
}
```
{: codeblock}

A selector without an explicit operator is considered to have an implicit operator.
The exact implicit operator is determined by the structure of the selector expression.

## Implicit operators
{: #implicit-operators}

The two implicit operators are shown in the following list:

-	"Equality"
-	"And"

In a selector,
any field that contains a JSON value, but that has no operators in it,
is considered to be an equality condition.
The implicit equality test also applies for fields and subfields.

Any JSON object that isn't the argument to a condition operator is an implicit `$and` operator on each field.

See the following example selector that uses an operator to match any document, where the `year` field has a value greater than 2010:

```json
{
	"selector": {
		"year": {
			"$gt": 2010
		}
	}
}
```
{: codeblock}

In the following example,
a matching document must have a field that is called `director`,
*and* the field must have a value exactly equal to `Lars von Trier`.

See the following example of the implicit equality operator:

```json
{
	"director": "Lars von Trier"
}
```
{: codeblock}

You can also make the equality operator explicit,
as shown in the following example.

See the following example of an explicit equality operator:

```json
{
	"director": {
		"$eq": "Lars von Trier"
	}
}
```
{: codeblock}

In the following example that uses subfields,
the field `imdb` in a matching document *must* also have
a subfield `rating`,
*and* the subfield *must* have a value equal to 8.

See the following example of implicit operator that is applied to a subfield test:

```json
{
	"imdb": {
		"rating": 8
	}
}
```
{: codeblock}

You can make the equality operator explicit.

See the following example of an explicit equality operator:


```json
{
	"selector": {
		"imdb": {
			"rating": { "$eq": 8 }
		}
	}
}
```
{: codeblock}

See the following example of a `$eq` operator that is used with full text indexing:

```json
{
	"selector": {
		"year": {
			"$eq": 2001
		}
	},
	"sort": [
		"title:string"
	],
	"fields": [
		"title"
	]
}
```
{: codeblock}

See the following example of an `$eq` operator that is used with a database that is indexed on the field `year`:

```json
{
	"selector": {
		"year": {
			"$eq": 2001
		}
	},
	"sort": [
		"year"
	],
	"fields": [
		"year"
	]
}
```
{: codeblock}


In the following example,
the field `director` must be present and contain the value `Lars von Trier`
*and* the field `year` must exist and have the value `2003`.

See the following example of an implicit `$and` operator:

```json
{
	"director": "Lars von Trier",
	"year": 2003
}
```
{: codeblock}

You can make both the `$and` operator and the equality operator explicit.

See the following example that uses explicit `$and` and `$eq` operators:

```json
{
	"$and": [
		{
			"director": {
				"$eq": "Lars von Trier"
			}
		},
		{
			"year": {
				"$eq": 2003
			}
		}
	]
}
```
{: codeblock}

## Explicit operators
{: #explicit-operators}

All operators,
apart from the `$eq` (equality) and `$and` (and) operators,
must be stated explicitly.

## Combination operators
{: #combination-operators}

Combination operators are used to combine selectors.
Three combination operators (`$all`, `$allMatch`, and `$elemMatch`) help you work with JSON arrays, in addition to the common Boolean operators found in most programming languages.

A combination operator takes a single argument.
The argument is either another selector, or an array of selectors.

Operator                                | Argument | Purpose
----------------------------------------|----------|--------
[`$all`](#the-all-operator)             | Array    | Matches an array value if it contains all the elements of the argument array.
[`$allMatch`](#the-allmatch-operator)   | Selector | Matches and returns all documents that contain an array field, where all the elements match all the specified query criteria.
[`$and`](#the-and-operator)             | Array    | Matches if all the selectors in the array match.
[`$elemMatch`](#the-elemmatch-operator) | Selector | Matches and returns all documents that contain an array field with at least one element that matches all the specified query criteria.
[`$nor`](#the-nor-operator)             | Array    | Matches if none of the selectors in the array match.
[`$not`](#the-not-operator)             | Selector | Matches if the selector doesn't match.
[`$or`](#the-or-operator)               | Array    | Matches if any of the selectors in the array match. All selectors must use the same index.
{: caption="Table 9. Combination operators" caption-side="top"}

### Examples of combination operators
{: #examples-of-combination-operators}

#### The `$all` operator
{: #the-all-operator}

The `$all` operator matches an array value if it contains *all* the elements of the argument array.

See the following example that uses the `$all` operator:

```json
{
	"selector": {
		"genre": {
			"$all": ["Comedy","Short"]
		}
	},
	"fields": [
		"title",
		"genre"
	],
	"limit": 10
}
```
{: codeblock}

#### The `$allMatch` operator
{: #the-allmatch-operator}

The `$allMatch` operator matches and returns all documents that contain an array field,
where all the elements in the array field match the supplied query criteria.

See the following example that uses the `$allMatch` operator:

```json
{
    "genre": {
        "$allMatch": {
          "$eq": "Horror"
        }
    }
}
```
{: codeblock}

#### The `$and` operator
{: #the-and-operator}

The `$and` operator matches if all the selectors in the array match.

See the following example that uses the `$and` operator:

```json
{
    "selector": {
        "$and": [
            {
                "year": {
                    "$in": [2014, 2015]
                }
            },
            {
                "genre": {
                     "$all": ["Comedy","Short"]
                 }
            }
        ]
    },
    "fields": [
        "year",
        "_id",
        "title"
    ],
    "limit": 10
}
```
{: codeblock}

#### The `$elemMatch` operator
{: #the-elemmatch-operator}

The `$elemMatch` operator matches and returns all documents that contain an array field
with at least one element that matches the supplied query criteria.

See the following example that uses the `$elemMatch` operator:

```json
{
	"selector": {
		"genre": {
			"$elemMatch": {
				"$eq": "Horror"
			}
		}
	},
	"fields": [
		"title",
		"genre"
	],
	"limit": 10
}
```
{: codeblock}

#### The `$nor` operator
{: #the-nor-operator}

The `$nor` operator matches if the selector does *not* match.

See the following example that uses the `$nor` operator:

```json
{
	"selector": {
		"year": {
			"$gte": 1900,
			"$lte": 1910
		},
		"$nor": [
			{ "year": 1901 },
			{ "year": 1905 },
			{ "year": 1907 }
		]
	},
	"fields": [
		"title",
		"year"
	]
}
```
{: codeblock}

#### The `$not` operator
{: #the-not-operator}

The `$not` operator matches if the selector does *not* resolve to a value of `true`.

See the following example that uses the `$not` operator:

```json
{
	"selector": {
		"year": {
			"$gte": 1900,
			"$lte": 1903
		},
		"$not": {
			"year": 1901
		}
	},
	"fields": [
		"title",
		"year"
	]
}
```
{: codeblock}

#### The `$or` operator
{: #the-or-operator}

The `$or` operator matches if any of the selectors in the array match.

See the following example that uses the `$or` operator:

```json
{
	"selector": {
		"year": 1977,
		"$or": [
			{ "director": "George Lucas" },
			{ "director": "Steven Spielberg" }
		]
	},
	"fields": [
		"title",
		"director",
		"year"
	]
}
```
{: codeblock}

## Condition operators
{: #condition-operators}

Condition operators are specific to a field,
and are used to evaluate the value that is stored in that field.
For instance,
the `$eq` operator matches when the specified field contains a value that is equal to the supplied argument.

The basic equality and inequality operators common to most programming languages are supported.
Some "meta" condition operators are also available.

Some condition operators accept any valid JSON content as the argument.
Other condition operators require the argument to be in a specific JSON format.

|Operator type | Operator  | Argument             | Purpose|
|--------------|-----------|----------------------|--------|
| (In) equality | `$lt`     | Any JSON             | The field is less than the argument. |
|              | `$lte`    | Any JSON             | The field is less than or equal to the argument. |
|              | `$eq`     | Any JSON             | The field is equal to the argument. |
|              | `$ne`     | Any JSON             | The field isn't equal to the argument. |
|              | `$gte`    | Any JSON             | The field is greater than or equal to the argument. |
|              | `$gt`     | Any JSON             | The field is greater than the argument. |
| Object        | `$exists` | Boolean              | Check whether the field exists or not, no matter what its value is. |
|              | `$type`   | String               | Check the document field's type. Accepted values are `null`, `boolean`, `number`, `string`, `array`, and `object`. |
| Array         | `$in`     | Array of JSON values | The document field must exist in the list provided. |
|              | `$nin`    | Array of JSON values | The document field must not exist in the list provided. |
|              | `$size`   | Integer              | Special condition to match the length of an array field in a document. Non-array fields can't match this condition. |
| Miscellaneous | `$mod`    | [Divisor, Remainder] | Divisor and Remainder are both positive or negative integers. Non-integer values result in a [404 status](/apidocs/cloudant#list-of-http-codes){: new_window}{: external}. Matches documents where the expression (`field % Divisor == Remainder`) is true, and only when the document field is an integer. |
|              | `$regex`  | String               | A regular expression pattern to match against the document field. Matches only when the field is a string value and matches the supplied regular expression. |
{: caption="Table 10. Condition operator argument requirements" caption-side="top"}

Regular expressions don't work with indexes,
so they must not be used to filter large data sets. However, they can be used to restrict a `partial index <find/partial_indexes>`.
{: tip}

### Examples of condition operators
{: #examples-of-condition-operators}

#### The `$lt` operator
{: #the-lt-operator}

The `$lt` operator matches if the specified field content is less than the argument.

See the following example that uses the `$lt` operator with full-text indexing:

```json
{
	"selector": {
		"year": {
			"$lt": 1900
		}
	},
	"sort": [
		"year:number",
		"title:string"
	],
	"fields": [
		"year",
		"title"
	]
}
```
{: codeblock}

See the following example that uses the `$lt` operator with a database that is indexed on the field `year`:

```json
{
	"selector": {
		"year": {
			"$lt": 1900
		}
	},
	"sort": [
		"year"
	],
	"fields": [
		"year"
	]
}
```
{: codeblock}

#### The `$lte` operator
{: #the-lte-operator}

The `$lte` operator matches if the specified field content is less than or equal to the argument.

See the following example that uses the `$lte` operator with full-text indexing:

```json
{
	"selector": {
		"year": {
			"$lte": 1900
		}
	},
	"sort": [
		"year:number",
		"title:string"
	],
	"fields": [
		"year",
		"title"
	]
}
```
{: codeblock}

See the following example that uses the `$lte` operator with a database that is indexed on the field `year`:

```json
{
	"selector": {
		"year": {
			"$lte": 1900
		}
	},
	"sort": [
		"year"
	],
	"fields": [
		"year"
	]
}
```
{: codeblock}

#### The `$eq` operator
{: #the-eq-operator}

The `$eq` operator matches if the specified field content is equal to the supplied argument.

See the following example that uses the `$eq` operator with full-text indexing:

```json
{
	"selector": {
		"year": {
			"$eq": 2001
		}
	},
	"sort": [
		"title:string"
	],
	"fields": [
		"title"
	]
}
```
{: codeblock}

See the following example that uses the `$eq` operator with a database that is indexed on the field `year`:

```json
{
	"selector": {
		"year": {
			"$eq": 2001
		}
	},
	"sort": [
		"year"
	],
	"fields": [
		"year"
	]
}
```
{: codeblock}

#### The `$ne` operator
{: #the-ne-operator}

The `$ne` operator matches if the specified field content isn't equal to the supplied argument.

The `$ne` operator can't be the basic (lowest level) element in a selector
when you use an index of type `json`.
{: tip}

See the following example that uses the `$ne` operator with full-text indexing:

```json
{
	"selector": {
		"year": {
			"$ne": 1892
		}
	},
	"fields": [
		"year"
	],
	"sort": [
		"year:number"
	]
}
```
{: codeblock}

See the following example that uses the `$ne` operator with a primary index:

```json
{
	"selector": {
	"year": {
			"$ne": 1892
		}
	},
	"fields": [
		"year"
	],
	"limit": 10
}
```
{: codeblock}

#### The `$gte` operator
{: #the-gte-operator}

The `$gte` operator matches if the specified field content is greater than or equal to the argument.

See the following example that uses the `$gte` operator with full-text indexing:

```json
{
	"selector": {
		"year": {
			"$gte": 2001
		}
	},
	"sort": [
		"year:number",
		"title:string"
	],
	"fields": [
		"year",
		"title"
	]
}
```
{: codeblock}

See the following example that uses the `$gte` operator with a database that is indexed on the field `year`:

```json
{
	"selector": {
		"year": {
			"$gte": 2001
		}
	},
	"sort": [
		"year"
	],
	"fields": [
		"year"
	]
}
```
{: codeblock}

#### The `$gt` operator
{: #the-gt-operator}

The `$gt` operator matches if the specified field content is greater than the argument.

See the following example that uses the `$gt` operator with full-text indexing:

```json
{
	"selector": {
		"year": {
			"$gt": 2001
		}
	},
	"sort": [
		"year:number",
		"title:string"
	],
	"fields": [
		"year",
		"title"
	]
}
```
{: codeblock}

See the following example that uses the `$gt` operator with a database that is indexed on the field `year`:

```json
{
	"selector": {
		"year": {
			"$gt": 2001
		}
	},
	"sort": [
		"year"
	],
	"fields": [
		"year"
	]
}
```
{: codeblock}

#### The `$exists` operator
{: #the-exists-operator}

The `$exists` operator matches if the field exists,
no matter what its value is.

See the following example that uses the `$exists` operator:

```json
{
	"selector": {
		"year": 2015,
		"title": {
			"$exists": true
		}
	},
	"fields": [
		"year",
		"_id",
		"title"
	]
}
```
{: codeblock}

#### The `$type` operator
{: #the-type-operator}

The `$type` operator requires that the specified document field is of the correct type.

See the following example that uses the `$type` operator:

```json
{
	"selector": {
		  "year": {
			"$type": "number"
		}
	},
	"fields": [
		"year",
		"_id",
		"title"
	]
}
```
{: codeblock}

#### The `$in` operator
{: #the-in-operator}

The `$in` operator requires that the document field *must* exist in the list provided.

See the following example that uses the `$in` operator:

```json
{
	"selector": {
		  "year": {
			"$in": [2010, 2015]
		}
	},
	"fields": [
		"year",
		"_id",
		"title"
	],
	"limit": 10
}
```
{: codeblock}

#### The `$nin` operator
{: #the-nin-operator}

The `$nin` operator requires that the document field must *not* exist in the list provided.

See the following example that uses the `$nin` operator:

```json
{
	"selector": {
		  "year": {
			"$nin": [2010, 2015]
		}
	},
	"fields": [
		"year",
		"_id",
		"title"
	],
	"limit": 10
}
```
{: codeblock}

#### The `$size` operator
{: #the-size-operator}

The `$size` operator matches the length of an array field in a document.

See the following example that uses the `$size` operator:

```json
{
	"selector": {
		  "genre": {
			"$size": 4
		}
	},
	"fields": [
		"title",
		"genre"
	],
	"limit": 25
}
```
{: codeblock}

#### The `$mod` operator
{: #the-mod-operator}

The `$mod` operator matches documents where the expression (`field % Divisor == Remainder`) is true,
and only when the document field is an integer.
The Divisor and Remainder must be integers.
They can be positive or negative integers.
A query where the Divisor or Remainder is a non-integer returns a [404 status](/apidocs/cloudant#list-of-http-codes){: new_window}{: external}.

When you use negative integer values for the Divisor or Remainder,
the {{site.data.keyword.cloudant_short_notm}} `$mod` operator uses [truncated division](https://en.wikipedia.org/wiki/Modulo_operation){: new_window}{: external}. Both the [Erlang `rem` modulo operator](http://erlang.org/doc/reference_manual/expressions.html){: new_window}{: external}, and the [`%` operator in C](https://en.wikipedia.org/wiki/Operators_in_C_and_C%2B%2B){: new_window}{: external},
behave in a similar way.
{: tip}

See the following example that uses the `$mod` operator:

```json
{
	"selector": {
          "year": {
			"$mod": [100,0]
		}
	},
	"fields": [
		"title",
		"year"
	],
	"limit": 50
}
```
{: codeblock}

#### The `$regex` operator
{: #the-regex-operator}

The `$regex` operator matches when the field is a string value *and* matches the supplied regular expression.

See the following example that uses the `$regex` operator:

```json
{
	"selector": {
		   "cast": {
			"$elemMatch": {
				"$regex": "^Robert"
			}
		}
	},
	"fields": [
		"title",
		"cast"
	],
	"limit": 10
}
```
{: codeblock}

## Creating selector expressions
{: #creating-selector-expressions}

In general,
whenever you have an operator that takes an argument,
that argument can itself be another operator with arguments of its own.
This expansion enables more complex selector expressions.

Combination or array logical operators, such as `$regex`, can
result in a full database scan when you use indexes of type JSON,
resulting in poor performance. Only equality operators, such as `$eq`,
`$gt`, `$gte`, `$lt`, and `$lte` (but not `$ne`), enable index lookups. To ensure that indexes are used effectively, analyze the
[explain plan](#explain-plans) for each query.  
{: tip}

Most selector expressions work exactly as you would expect for the operator.
The matching algorithms that are used by the `$regex` operator are currently *based* on
the [Perl Compatible Regular Expression (PCRE) library](https://en.wikipedia.org/wiki/Perl_Compatible_Regular_Expressions){: new_window}{: external}.
However,
not all of the PCRE library is implemented.
Additionally,
some parts of the `$regex` operator go beyond what PCRE offers.
For more information about what is implemented,
see the [Erlang Regular Expression](http://erlang.org/doc/man/re.html){: new_window}{: external} information.

## Sort syntax
{: #sort-syntax}

The `sort` field contains a list of field name and direction pairs,
expressed as a basic array.
The first field name and direction pair are the topmost-level of sort.
The second pair,
if provided,
is the next level of sort.

The sort field can be any field.
Use dotted notation if needed for subfields.

The direction value is `asc` for ascending, and `desc` for descending.

If you exclude the direction value, the default `asc` is used.
{: tip}

See the following example of simple sort syntax:

```json
[
	{
		"fieldName1": "desc"
	},
	{
		"fieldName2": "desc"
	}
]
```
{: codeblock}

See the following example of simple sort, assuming default direction of "ascending" for both fields:

```json
[
	"fieldNameA", "fieldNameB"
]
```
{: codeblock}

A typical requirement is to search for some content by using a selector,
then to sort the results according to the specified field,
in the direction preferred.

To use sorting, ensure that the following are true:

-	At least one of the sort fields is included in the selector.
-	An index is already defined,
	with all the sort fields in the same order.
-	Each object in the sort array has a single key.

If an object in the sort array doesn't have a single key, the resulting sort order is implementation-specific and might change.
{: tip}

Currently, {{site.data.keyword.cloudant_short_notm}} Query doesn't support multiple fields with different sort orders,
so the direction must either be all ascending or all descending.
{: tip}

If the direction is ascending,
you can use a string instead of an object to specify the sort fields.

For field names in text search sorts,
it's sometimes necessary for a field type to be specified,
for example:

```json
{
	"<fieldname>:string": "asc"
}
```
{: codeblock}

If possible,
an attempt is made to find the field type based on the selector.
In ambiguous cases,
the field type must be provided explicitly.

Which index is used by query?               | Field type requirement 
------------------------------------------|-----------------------
JSON index                                | It's not necessary to specify the type of sort fields in the query.
Text index of all fields in all documents | Specify the sort field in the query if the database contains documents where the sort field has one type. Also, specify the sort field in the query if it contains documents where the sort field has a different type.
Any other text index                      | Specify the type of all sort fields in the query.
{: caption="Table 11. When to specify the field type" caption-side="top"}

A text index of all fields
in all documents is created when you use the syntax:
[`"index": {}`](#the-index-field).
{: tip}

The sorting order is undefined when fields contain different data types. This characteristic is an important difference between text and view indexes. Sorting behavior for fields with different data types might change in future versions.
{: tip}

See the following example of a simple query that uses sorting:

```json
{
	"selector": {
		"Actor_name": "Robert De Niro"
	},
	"sort": [
		{
			"Actor_name": "asc"
		},
		{
			"Movie_runtime": "asc"
		}
	]
}
```
{: codeblock}

## Filtering fields
{: #filtering-fields}

It's possible to specify exactly which fields are returned for a document when you select from a database.
The two advantages are shown in the following list:

- Your results are limited to only those parts of the document that are needed for your application.
- A reduction in the size of the response.

The fields to be returned are specified as an array.

Only the specified filter fields are included in the response. `_id` or other metadata fields aren't automatically included.
{: tip}

See the following example of selective retrieval of fields from matching documents:

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

## Pagination
{: #pagination_query}

{{site.data.keyword.cloudant_short_notm}} Query supports pagination by the bookmark field. Every `_find` response contains a bookmark - a token
that {{site.data.keyword.cloudant_short_notm}} uses to determine where to resume from when later queries are made. To get the next
set of query results, add the bookmark that was received in the previous response to your next request.
Remember to keep the selector the same, otherwise you receive unexpected results. To paginate backwards,
you can use a previous bookmark to return the previous set of results.

The presence of a bookmark doesn’t guarantee more results. You can test whether
you are at the end of the result set by comparing the number of results that are returned with the page size
requested. If the results returned are less than limit, no more results were returned in the result set.
{: tip}



## Explain plans
{: #explain-plans}

{{site.data.keyword.cloudant_short_notm}} Query chooses which index to use for responding to a query,
unless you specify an index at query time.

When you specify an index to use,
{{site.data.keyword.cloudant_short_notm}} Query uses the following logic:

-	The query planner looks at the selector section,
	and finds the index with the closest match to operators and fields that are used in the query.
	If two or more JSON type indexes match,
	the index with the smallest number of fields in the index is preferred.
  If two or more candidate indexes still exist,
  the index with the first alphabetical name is chosen.
-	If a `json` type index *and* a `text` type index might both satisfy a selector,
	the `json` index is chosen by default.
- The `text` type index is chosen when the following conditions are met:
    - A `json` type index *and* a `text` type index exist in the same field (for example `fieldone`).
    - The selector can be satisfied only by using a `text` type index.

For example,
assume that you have a `text` type index and a `json` type index for the field `foo`,
and you want to use a selector similar to the following sample:

```json
{
	"foo": {
		"$in": ["red","blue","green"]
	}
}
```
{: codeblock}

{{site.data.keyword.cloudant_short_notm}} Query uses the `text` type index because a `json` type index can't satisfy the selector.

However,
you might use a different selector with the same indexes:

```json
{
	"foo": {
		"$gt": 2
	}
}
```
{: codeblock}

In this example,
{{site.data.keyword.cloudant_short_notm}} Query uses the `json` type index because both types of indexes can satisfy the selector.

To identify which index is being used by a particular query,
send a `POST` to the `_explain` endpoint for the database,
with the query as data.
The details of the index in use are shown in the `index` object within the result.

See the following example that uses HTTP to show how to identify the index that was used to answer a query:

```http
POST /movies/_explain HTTP/1.1
Host: examples.cloudant.com
Content-Type: application/json
{
	"selector": {
		"$text": "Pacino",
		"year": 2010
	}
}
```
{: codeblock}

See the following example that uses the command line to show how to identify the index that was used to answer a query:

```sh
curl "https://examples.cloudant.com/movies/_explain" \
	-X POST \
	-H "Content-Type: application/json" \
	-d '{
		"selector": {
			"$text": "Pacino",
			"year": 2010
		}
	}'
```
{: codeblock}

See the following example response that shows which index was used to answer a query:

```json
{
	"dbname": "examples/movies",
	"index": {
		"ddoc": "_design/32372935e14bed00cc6db4fc9efca0f1537d34a8",
		"name": "32372935e14bed00cc6db4fc9efca0f1537d34a8",
		"type": "text",
		"def": {
			"default_analyzer": "keyword",
			"default_field": {},
			"selector": {},
			"fields": []
		}
	},
	"selector": {
		"$and": [
			{
				"$default": {
					"$text": "Pacino"
				}
			},
			{
				"year": {
					"$eq": 2010
				}
			}
		]
	},
	"opts": {
		"use_index": [],
		"bookmark": [],
		"limit": 10000000000,
		"skip": 0,
		"sort": {},
		"fields": "all_fields",
		"r": [
			49
		],
		"conflicts": false
	},
	"limit": 200,
	"skip": 0,
	"fields": "all_fields",
	"query": "(($default:Pacino) AND (year_3anumber:2010))",
	"sort": "relevance"
}
```
{: codeblock}

To instruct a query to use a specific index,
add the `use_index` parameter to the query.

The value of the `use_index` parameter takes one of the following formats:

-	`"use_index": "$DDOC"`
-	`"use_index": ["$DDOC","$INDEX_NAME"]`

See the following example query with instructions to use a specific index:

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

## Note about `text` indexes
{: #note-about-text-indexes}

The basic premise for full text indexes is that a document
is "expanded" into a list of `key:value` pairs that are indexed by Lucene.
This expansion enables the use of Lucene's search syntax as a basis for the query capability.

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

Like {{site.data.keyword.cloudant_short_notm}} Search indexes, {{site.data.keyword.cloudant_short_notm}} Query indexes of `type: text` are limited to 200 results when queried.
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

```javascript
(age_3anumber:{5 TO Infinity])
```
{: codeblock}

### A more complex example
{: #a-more-complex-example}

The following example illustrates some important points.

#### JSON query to be converted to Lucene

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

## Example - Movies demo database
{: #example-movies-demo-database}

To describe full text indexes,
it's helpful to have a large collection of data to work with.
A suitable collection is available in the example {{site.data.keyword.cloudant_short_notm}} Query movie database: `query-movies`.
The sample database contains approximately 3,000 documents and is just under 1 MB.

You can obtain a copy of this database in your database,
giving it the name `my-movies`,
by running one of the commands mentioned in the following text.

See the following example that uses HTTP to obtain a copy of the {{site.data.keyword.cloudant_short_notm}} Query movie database:

```http
POST /_replicator HTTP/1.1
Host: user.cloudant.com
Content-Type: application/json
{
	"source": "https://examples.cloudant.com/query-movies",
	"target": "https://$ACCOUNT.cloudant.com/my-movies",
	"create_target": true,
	"use_checkpoints": false
}
```
{: codeblock}

See the following example that uses the command line to obtain a copy of the {{site.data.keyword.cloudant_short_notm}} Query movie database:

```sh
curl "https://$ACCOUNT:$PASSWORD@$ACCOUNT.cloudant.com/_replicator" \
	-X POST \
	-H "Content-Type: application/json" \
	-d '{
		"source": "https://examples.cloudant.com/query-movies",
		"target": "https://$ACCOUNT.cloudant.com/my-movies",
		"create_target": true,
		"use_checkpoints": false
	}'
```
{: codeblock}

See the results after a successful replication of the {{site.data.keyword.cloudant_short_notm}} Query movie database:

```json
{
	"ok": true,
	"use_checkpoints": false
}
```
{: codeblock}

Before you can search the content,
it must be indexed by creating a text index for the documents.

See the following example that uses HTTP to create a `text` index for your sample database:

```http
POST /my-movies/_index HTTP/1.1
Host: user.cloudant.com
Content-Type: application/json
{
	"index": {},
	"type": "text"
}
```
{: codeblock}

See the following example that uses the command line to create a `text` index for your sample database:

```sh
curl "https://$ACCOUNT.cloudant.com/my-movies/_index" \
	-X POST \
	-H "Content-Type: application/json" \
	-d '{"index": {}, "type": "text"}'
```
{: codeblock}

See the following example response after a `text` index is created successfully:

```json
{
	"result": "created"
}
```
{: codeblock}

The most obvious difference in the results you get when you use full text indexes is
the inclusion of a large `bookmark` field.
The reason is that `text` indexes are different from view-based indexes.
For more flexibility, when you work with the results that are obtained from a full text query,
you can supply the `bookmark` value as part of the request body.
Use the `bookmark` to specify which page of results you require.

The actual `bookmark` value is long,
so the examples here have values that are truncated for reasons of clarity.
{: tip}

See the following example that uses HTTP to search for a specific document within the database:

```http
POST /my-movies/_find HTTP/1.1
Host: user.cloudant.com
Content-Type: application/json
{
  "selector": {
    "Person_name":"Zoe Saldana"
  }
}
```
{: codeblock}

See the following example that uses the command line to search for a specific document within the database:

```sh
curl -X POST -H "Content-Type: application/json" \
	"https://$ACCOUNT.cloudant.com/my-movies/_find" \
	-d '{"selector": {"Person_name":"Zoe Saldana"}}'
```
{: codeblock}

See the following example result from the search:

```json
{
	"docs": [
		{
			"_id": "d9e6a7ae2363d6cfe81af75a3941110b",
			"_rev": "1-556aec0e89fa13769fbf59d651411528",
			"Movie_runtime": 162,
			"Movie_rating": "PG-13",
			"Person_name": "Zoe Saldana",
			"Movie_genre": "AVYS",
			"Movie_name": "Avatar",
			"Movie_earnings_rank": "1",
			"Person_pob": "New Jersey, USA",
			"Movie_year": 2009,
			"Person_dob": "1978-06-19"
		}
	],
	"bookmark": "g2wA ... Omo"
}
```
{: codeblock}

See the following example that uses HTTP for a slightly more complex search:

```http
POST /my-movies/_find HTTP/1.1
Host: user.cloudant.com
Content-Type: application/json
{
	"selector": {
		"Person_name":"Robert De Niro",
		"Movie_year": 1978
	}
}
```
{: codeblock}

See the following example that uses the command line for a slightly more complex search:

```sh
curl -X POST -H "Content-Type: application/json" \
	"https://$ACCOUNT.cloudant.com/my-movies/_find" \
	-d '{"selector": {"Person_name":"Robert De Niro", "Movie_year": 1978}}'
```
{: codeblock}

See the following example result from the search:

```json
{
	"docs": [
		{
			"_id": "d9e6a7ae2363d6cfe81af75a392eb9f2",
			"_rev": "1-9faa75d7ea524448b1456a6c69a4391a",
			"Movie_runtime": 183,
			"Movie_rating": "R",
			"Person_name": "Robert De Niro",
			"Movie_genre": "DW",
			"Movie_name": "Deer Hunter, The",
			"Person_pob": "New York, New York, USA",
			"Movie_year": 1978,
			"Person_dob": "1943-08-17"
		}
	],
	"bookmark": "g2w ... c2o"
}
```
{: codeblock}

See the following example that uses HTTP to search within a range:

```http
POST /my-movies/_find HTTP/1.1
Host: user.cloudant.com
Content-Type: application/json
{
  "selector": {
    "Person_name":"Robert De Niro",
    "Movie_year": {
      "$in": [1974, 2009]
    }
  }
}
```
{: codeblock}

See the following example that uses the command line to search within a range:

```sh
curl -X POST -H "Content-Type: application/json" \
	"https://$ACCOUNT.cloudant.com/my-movies/_find" \
	-d '{"selector": {"Person_name":"Robert De Niro", "Movie_year": { "$in": [1974, 2009]}}}'
```
{: codeblock}

See the following example result from the search:

```json
{
	"docs": [
		{
			"_id": "d9e6a7ae2363d6cfe81af75a392eb9f2",
			"_rev": "1-9faa75d7ea524448b1456a6c69a4391a",
			"Movie_runtime": 183,
			"Movie_rating": "R",
			"Person_name": "Robert De Niro",
			"Movie_genre": "DW",
			"Movie_name": "Deer Hunter, The",
			"Person_pob": "New York, New York, USA",
			"Movie_year": 1978,
			"Person_dob": "1943-08-17"
		}
	],
	"bookmark": "g2w ... c2o"
}
```
{: codeblock}
