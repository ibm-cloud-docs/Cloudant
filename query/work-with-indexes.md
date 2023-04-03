---

copyright:
  years: 2015, 2023
lastupdated: "2023-04-04"

keywords: create index, json index type, text index type, partial index

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# Working with indexes
{: #working-with-indexes}

{{site.data.keyword.cloudantfull}} endpoints can be used to create,
list,
update,
and delete indexes in a database,
and to query data by using these indexes.
{: shortdesc}

| Methods  | Path                | Description |
|---------|---------------------|------------|
| `DELETE` | `/$DATABASE/_index` | Delete an index. |
| `GET`    | `/$DATABASE/_index` | List all {{site.data.keyword.cloudant_short_notm}} Query indexes. |
| `POST`   | `/$DATABASE/_find`  | Find documents by using a global index. |
| `POST`   | `/$DATABASE/_partition/$PARTITION_KEY/_find`  | Find documents by using a partitioned index. |
| `POST`   | `/$DATABASE/_index` | Create an index. |
{: caption="Table 1. Available methods and endpoints" caption-side="top"}

## Creating a partial index
{: #creating-a-partial-index}

{{site.data.keyword.cloudant_short_notm}} Query supports partial indexes by using the `partial_filter_selector` field. For more information, see the [CouchDB documentation](https://docs.couchdb.org/en/stable/api/database/find.html?highlight=partial#partial-indexes){: external} and the original example.

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
`partial_filter_selector` field that is shown in the following example:

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

