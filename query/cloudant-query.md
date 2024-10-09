---

copyright:
  years: 2015, 2023
lastupdated: "2023-01-24"

keywords: create index, query, json index type, text index type, query parameters, partial index, implicit operators, explicit operators, combination operators, condition operators, selector expressions, sort, filter,  pagination, partitioned field, index field, default_field field, fields array, index_array_lengths field, list indexes, delete index, selector syntax

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# Working with {{site.data.keyword.cloudant_short_notm}} Query
{: #query}

{{site.data.keyword.cloudantfull}} Query is a declarative JSON querying syntax for {{site.data.keyword.cloudant_short_notm}} databases. You can use a `json` or `text` type of index with {{site.data.keyword.cloudant_short_notm}}.
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
| `type` (optional) | Can be `json` or `text`. Defaults to `json`. | 
| `name` (optional) | Name of the index. If no name is provided, a name is generated automatically. |
| `partitioned` (optional, boolean) | Determines whether this index is partitioned. For more information, see [the `partitioned` field](#section1-the-partitioned-field).|
{: caption="Request body format" caption-side="top"}

#### The `partitioned` field
{: #section1-the-partitioned-field}

This field sets whether the created index is a partitioned or global index.

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
{: caption="Default partitioned value" caption-side="top"}

It's important to reiterate that the default `partitioned` value is `true`
for indexes that are created in a partitioned database. This default  value means that the index *cannot*
be used to satisfy global queries.
{: important}

| Code | Description |
|-----|------------|
| 200  | Index was created successfully or existed in the database. |
| 400  | Bad request - the request body doesn't have the specified format. |
{: caption="Return codes" caption-side="top"}

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

#### The `default_field` field
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

#### The `partitioned` field
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
