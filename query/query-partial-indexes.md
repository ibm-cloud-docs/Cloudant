---

copyright:
  years: 2015, 2023
lastupdated: "2023-04-04"

keywords: cloudant query, create index, json index type, text index type, partial index

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# Partial indexes
{: #partial-indexes}

Use partial indexes to create indexes using a subset of the documents of the database. This is a powerful optimisation technique when used correctly: it reduces the overall size of an index, making queries faster and reducing data storage costs.
{: shortdesc}

## Creating a partial index
{: #creating-a-partial-index}

{{site.data.keyword.cloudant_short_notm}} Query supports partial indexes by using the `partial_filter_selector` field. The `partial_filter_selector` contains a standard {{site.data.keyword.cloudant_short_notm}} Query that is executed _at index time_. Documents that don't match the selector are not added to the index.

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
with `status: { $ne: archived }` at index time by using 
`partial_filter_selector` shown in the following example:

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

Partial indexes aren't used by the query planner unless specified
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

