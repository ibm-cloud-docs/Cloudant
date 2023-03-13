---

copyright:
  years: 2015, 2023
lastupdated: "2023-03-13"

keywords: implicit operators, explicit operators, combination operators, condition operators, selector expressions, sort, filter, pagination

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# {{site.data.keyword.cloudant_short_notm}} Operators
{: #operators}

Operators are identified by the use of a dollar sign (`$`) prefix in the name field.
{: shortdesc}

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

| Operator                                | Argument | Purpose |
|----------------------------------------|----------|--------|
| [`$all`](#the-all-operator)             | Array    | Matches an array value if it contains all the elements of the argument array. |
| [`$allMatch`](#the-allmatch-operator)   | Selector | Matches and returns all documents that contain an array field, where all the elements match all the specified query criteria. |
| [`$and`](#the-and-operator)             | Array    | Matches if all the selectors in the array match. |
| [`$elemMatch`](#the-elemmatch-operator) | Selector | Matches and returns all documents that contain an array field with at least one element that matches all the specified query criteria. |
| [`$nor`](#the-nor-operator)             | Array    | Matches if none of the selectors in the array match. |
| [`$not`](#the-not-operator)             | Selector | Matches if the selector doesn't match. |
| [`$or`](#the-or-operator)               | Array    | Matches if any of the selectors in the array match. All selectors must use the same index. |
{: caption="Table 1. Combination operators" caption-side="top"}

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
| Miscellaneous | `$mod`    | [Divisor, Remainder] | Divisor and Remainder are both positive or negative integers. Non-integer values result in a [404 status](/apidocs/cloudant#list-of-http-codes){: external}. Matches documents where the expression (`field % Divisor == Remainder`) is true, and only when the document field is an integer. |
|              | `$regex`  | String               | A regular expression pattern to match against the document field. Matches only when the field is a string value and matches the supplied regular expression. |
{: caption="Table 2. Condition operator argument requirements" caption-side="top"}

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
A query where the Divisor or Remainder is a non-integer returns a [404 status](/apidocs/cloudant#list-of-http-codes){: external}.

When you use negative integer values for the Divisor or Remainder,
the {{site.data.keyword.cloudantfull}} `$mod` operator uses [truncated division](https://en.wikipedia.org/wiki/Modulo_operation){: external}. Both the [Erlang `rem` modulo operator](https://www.erlang.org/doc/reference_manual/expressions.html){: external}, and the [`%` operator in C](https://en.wikipedia.org/wiki/Operators_in_C_and_C%2B%2B){: external},
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
