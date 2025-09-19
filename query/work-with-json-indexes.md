---

copyright:
  years: 2015, 2025
lastupdated: "2025-09-19"

keywords: create index, json index type, cloudant query, performance

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# Working with JSON indexes
{: #working-with-json-indexes}

JSON indexes are {{site.data.keyword.cloudant_short_notm}} Query indexes that are excellent for equality (`$eq`) and range (`$lt`, `$lte`, `$gte` and `$gte`) queries. Create JSON indexes to support queries that include these operators.
{: shortdesc}

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

## The `partitioned` field
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

