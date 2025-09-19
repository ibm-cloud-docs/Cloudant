---

copyright:
  years: 2025, 2025
lastupdated: "2025-09-19"

keywords: cloudant query, query parameters, query troubleshooting, query performance, monitor query usage, query scalability, performance, indexes, text indexes, json indexes, application scaling, building scalable databases

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# {{site.data.keyword.cloudant_short_notm}} Query performance guide
{: #cloudant-query-performance-guide}

This guide walks you through the essential techniques for optimizing {{site.data.keyword.cloudant_short_notm}} Query performance, starting with the most foundational optimizations and progressing to advanced techniques. By following this guide, you'll transform slow, expensive queries into fast, efficient ones that scale with your data.

The guide will cover:

- **Concepts:**
    - Selectivity of indexes
- **Foundation topics**:
    - Avoid large scans
    - Field ordering in compound indexes
    - Use operators that allow index use
    - Avoiding missing documents in JSON indexes
    - Monitoring performance
- **Advanced topics**:
    - Partial indexes
    - Covering indexes
    - Index consolidation strategy

The guide finishes with a production readiness checklist.

## Key concept: selectivity
{: #key-concept-selectivity}

Performant and scalable queries depend on matching your query needs with indexes that efficiently serve those queries. A key concept in building such indexes is _selectivity_ — how well an index helps narrow down the result set.

A _high selectivity_ index (or _highly selective_ index) dramatically reduces the number of documents matched by a query. In contrast, a _low selectivity_ index matches many documents and offers less performance benefit.

- For an orders table, examples of _high selectivity_ indexes include:
    - `order_id`: each order has a unique ID, so queries match at most one document.
    - `username`: each user has far fewer orders than the total number of orders.
- Examples of _low selectivity_ indexes include:
    - `status`: many orders may share the same status.
    - `country`: a broad field like this will likely match many orders.

Understanding selectivity helps you design indexes that make queries faster and more efficient.

## Foundation: avoid large database scans
{: #foundation-avoid-large-database-scans}

**Impact: 1000x+ performance improvement**

The single most devastating performance problem in {{site.data.keyword.cloudant_short_notm}} Query is triggering a large database scan. There are two causes of this problem:

- The query uses a _low selectivity_ index, which causes many documents to be scanned to generate a much smaller result set.
- The query cannot use a user-defined index, so falls back on the built-in `_all_docs` index, which results in scanning all the documents in the database.

### How to identify large scans
{: #how-to-identify-large-scans}

Use the `_explain` endpoint to check which index your query will use:

```bash
POST /orders/_explain
{
  "selector": {
    "username": "bob@email.com",
    "status": "cancelled",
    "date": {"$gte": "2018-01-01", "$lt": "2019-01-01"}
  }
}
```

If the response shows a specific index, evaluate whether the index is _high_ or _low_ selectivity. In this example, an index on the `status` field is likely a low selectivity index, so this query needs work:

```json
{
  "index": {
    "ddoc": "_design/status-index",
    "def": {
      "fields": [
        {
          "status": "asc"
        }
      ]
    },
    "name": "d479bdddf50865e520a0193704c8b93a3bd48f77",
    "type": "json"
  }
}
```

If the response shows `"name": "_all_docs"`, your query will scan the entire database:

```json
{
  "index": {
    "ddoc": null,
    "name": "_all_docs",
    "type": "special"
  }
}
```

### Solution: create appropriate indexes
{: #solution-create-appropriate-indexes}

For the query above, the optimal index is a compound (multi-field) JSON index covering the fields you're querying:

```bash
POST /orders/_index
{
  "index": {
    "fields": ["username", "status", "date"]
  },
  "name": "username-status-date-index",
  "type": "json"
}
```

**Performance impact**: In a 100,000 document database, this single change can reduce query time from 20+ seconds to under 10 milliseconds.

### Production safety: prevent accidental large scans
{: #safety-prevent-accidental-large-scans}

If you know a certain index will be highly selective for a query, combine `use_index` with `allow_fallback: false` to force use of that index:

```json
{
  "selector": {"username": "bob@email.com", "status": "cancelled"},
  "use_index": ["my_design_doc", "username-index"],
  "allow_fallback": false
}
```

This will return an error if `my_design_doc/username-index` is unusable for the query, rather than silently performing an expensive scan. The default for `allow_fallback` is `true`, meaning that {{site.data.keyword.cloudant_short_notm}} will use a different index to respond to the query, potentially resulting in a large scan.

If you don't supply `use_index`, then `allow_fallback: false` will still prevent a query using the `_all_docs` index:

```json
{
  "selector": {"username": "bob@email.com"},
  "allow_fallback": false
}
```

This will return an error if no suitable user-defined index exists, avoiding an expensive scan.

See the [Query API documentation](/apidocs/cloudant#postfind) for more details on these query parameters.

Consistently combining `use_index` with `allow_fallback` is recommended practice for critical queries.
{: tip}

## Foundation: field ordering in compound indexes
{: #foundation-field-ordering-in-compound-indexes}

**Impact: 100x performance improvement**

Once you have indexes, the most common mistake is incorrect field ordering in compound indexes. This can turn an efficient query into one that scans 40%+ of your database.

### Critical rule 1: compound index selectivity
{: #critical-rule-1-compound-index-selectivity}

Order your equality fields (non-range fields) by selectivity - most selective first:

- `user` field: 50 docs per user (high selectivity) — put this first.
- `status` field: 10,000 docs per status (medium selectivity).

**Optimal index ordering**: `["username", "status", "date"]` where `date` is the range field.

### Critical rule 2: range fields must come last
{: #critical-rule-2-range-fields-must-come-last}

When creating compound indexes, any field used with range operators (`$gt`, `$gte`, `$lt`, `$lte`) must appear **last** in the field list.

**Wrong - causes partial database scans:**

```jsonc
{
  "index": {
    "fields": ["date", "username", "status"]  // Bad - range field first
  }
}
```

**Correct - enables efficient seeking:**

```jsonc
{
  "index": {
    "fields": ["username", "status", "date"]  // Good - range field last
  }
}
```

### Critical rule 3: sort fields must come last
{: #critical-rule-3-sort-fields-must-come-last}

Indexes are also used for sorting query results. When your query filters on fields like `username` and `status`, and sorts by another field like `date`, the index must include all three fields — with the sort field **last**.

For example, to support the following query:

```json
{
  "selector": { "username": "bob@email.com", "status": "cancelled" },
  "sort": [ { "date": "asc" } ]
}
```

You need an index on `["username", "status", "date"]`. In this structure, the sort field (`date`) must come last. This ordering ensures {{site.data.keyword.cloudant_short_notm}} can use the index both to filter and to sort efficiently.

### Why field ordering matters
{: #why-field-ordering-matters}

{{site.data.keyword.cloudant_short_notm}} indexes work like sorted tables. An index on `["username", "status", "date"]` creates entries sorted first by user, then by status within each user, then by date within each user-status combination:

```json
["alice", "paid", "2018-01-15"]
["alice", "paid", "2018-02-20"]
["bob", "cancelled", "2018-01-10"]
["bob", "cancelled", "2018-01-15"]
["bob", "paid", "2018-01-12"]
```

When using an efficient index for a query like `user: "bob", status: "cancelled", date: {$gte: "2018-01-01"}`, {{site.data.keyword.cloudant_short_notm}} can:

1. Jump directly to Bob's records.
2. Find the cancelled orders within Bob's records.
3. Scan efficiently through the date range.

If date were first, {{site.data.keyword.cloudant_short_notm}} would need to examine every document in the date range across all users and statuses.


## Foundation: use operators that allow index use
{: #foundation-use-operators-that-allow-index-use}

**Impact: 10-100x performance difference**

It's essential to combine high-selectivity indexes with query selectors that allow use of those indexes. The operators used in the conditions of a selector can prevent index use.

When executing a query, only some operators allow {{site.data.keyword.cloudant_short_notm}} to use an index to efficiently answer it. If you have a high-selectivity index on a field, but the operator used in that field's condition doesn't support index usage, then the query won't be able to use the index. As a result, it will be inefficient.

JSON and text indexes support use of different operators in conditions. If a JSON index doesn't support the operator you need, a text index might do.

The following table summarises the key properties of indexes, and the operators they support:

| Characteristic                | JSON index                             | Text index                         |
| ----------------------------- | -------------------------------------- | ---------------------------------- |
| **Underlying technology**     | CouchDB MapReduce View (B-tree)        | Apache Lucene                      |
| **Primary use-case**          | Latency-sensitive, predictable queries | Flexible, ad-hoc queries           |
| **Performance**               | Faster for exact matches and ranges    | Slower but more versatile          |
| **Document requirements**     | Must contain ALL indexed fields        | Flexible - missing fields OK       |
| **Strongly typed**            | No                                     | Yes                                |
|                               |                                        |                                    |
| **Combination operators**     |                                        |                                    |
| `$and`                        | ✔️ Supported                           | ✔️ Supported                       |
| `$or`                         | ❌ Not supported                        | ✔️ Supported                       |
| `$nor`                        | ❌ Not supported                        | ✔️ Supported                       |
| `$not`                        | ❌ Not supported                        | ✔️ Supported                       |
|                               |                                        |                                    |
| **Condition operators**       |                                        |                                    |
| `$eq` (equality)              | ✔️ Optimal                             | ✔️ Supported                       |
| `$gt`, `$gte`, `$lt`, `$lte`  | ✔️ Optimal for ranges                  | ✔️ Supported                       |
| `$exists`                     | ✔️ Supported                           | ✔️ Supported                       |
| `$beginsWith`                 | ✔️ Supported                           | ✔️ Supported                       |
| `$ne` (not equal)             | ❌ Not supported                        | ✔️ Supported                       |
| `$in`                         | ❌ Not supported                        | ✔️ Supported                       |
| `$size`                       | ❌ Not supported                        | ✔️ Supported                       |
| `$type`                       | ❌ Not supported                        | ✔️ Supported                       |
| `$text`                       | ❌ Not supported                        | ✔️ Full-text search                |
| `$regex`                      | ❌ Not supported                        | ❌ Not supported                    |
|                               |                                        |                                    |
| **Field Handling**            |                                        |                                    |
| Sort order                    | Fixed by index field ordering          | Flexible                           |
| Array fields                  | ❌ Not supported                        | ✔️ Full support with `[]` notation |
| Nested objects (dot notation) | ✔️ Supported                           | ✔️ Supported                       |
| Missing fields                | Excludes documents                     | Includes documents                 |
|                               |                                        |                                    |
| **Query page size limits**    |                                        |                                    |
| Global query                  | ???                                    | 200                                |
| Partition-scoped query        | ???                                    | 200                                |

### Index type selection guidelines
{: #index-type-selection-guidelines}

**Choose JSON indexes when:**

- Query patterns are predictable and consistent.
- You need maximum performance for exact matches.
- Documents have consistent structure.
- You're primarily using `$and`, `$eq`, and range operators.

**Choose text indexes when:**

- You need `$or` operations across multiple fields.
- Documents have varying structures.
- You need full-text search capabilities.
- Query patterns are ad-hoc or user-driven.
- You're using `$ne`, `$exists`, or complex operators.

**Example decision matrix:**

```jsonc
// Predictable e-commerce queries → JSON index
{
  "selector": {
    "username": "bob@email.com",
    "status": "paid",
    "date": {"$gte": "2018-01-01"}
  }
}

// Flexible search interface → Text index  
{
  "selector": {
    "$or": [
      "status": {"$in": ["paid", "in-progress"]}
      "category": "electronics"
    ]
  }
}
```

## Foundation: query performance monitoring
{: #foundation-query-performance-monitoring}

**Impact: Ongoing optimization and problem detection**

Efficient querying requires continuous monitoring. {{site.data.keyword.cloudant_short_notm}} provides tools to measure and track query performance over time.

{{site.data.keyword.cloudant_short_notm}} Query provides the `execution_stats` field in the response to help evaluate your queries. See [Monitor for inefficient IBM {{site.data.keyword.cloudant_short_notm}} queries](/docs/Cloudant?topic=Cloudant-monitor-for-inefficient-query-requests) for a detailed guide to the metrics {{site.data.keyword.cloudant_short_notm}} provides for analysing query execution.

## Warning: document structure requirements for JSON indexes
{: #warning-document-structure-requirements-for-json-indexes}

**Impact: Queries may return incomplete results or fail unexpectedly**

JSON indexes in {{site.data.keyword.cloudant_short_notm}} have a crucial constraint that differs from SQL databases: **a document must contain ALL indexed fields to be included in the index**.

### Problem
{: #document-structure-problem}

If you create an index on `["username", "status", "date"]`, any document missing even one of these fields is excluded from the index entirely. This means:

```jsonc
// This document WON'T be indexed
{
  "_id": "order123",
  "username": "bob@email.com",
  "status": "paid"
  // Missing "date" field
}
```

### Solutions
{: #document-structure-solutions}

**Option 1: Ensure consistent document structure**

```jsonc
// Always include all indexed fields
{
  "_id": "order123",
  "username": "bob@email.com",
  "status": "paid",
  "date": null  // Use null for missing values
}
```

**Option 2: Create multiple JSON indexes for different document structures**

```jsonc
// Index for documents with all fields
{"fields": ["username", "status", "date"]}

// Index for documents without date
{"fields": ["username", "status"]}
```

**Option 3: Use text indexes for flexible field requirements**
```json
{
  "index": {
    "fields": [
      {"name": "username", "type": "string"},
      {"name": "status", "type": "string"},
      {"name": "date", "type": "string"}
    ]
  },
  "type": "text"
}
```

A text index will index documents missing the `date` (or other) fields.

## Advanced: partial indexes
{: #advanced-partial-indexes}

**Impact: 50-90% reduction in index size and query latency**

Partial indexes are a powerful optimization technique that pre-filters documents before indexing, creating smaller, faster indexes while reducing storage costs.

### When to use partial indexes
{: #advanced-when-to-use-partial-indexes}

Partial indexes are ideal when:

- You consistently query a subset of documents (e.g., only active records).
- Your database contains large amounts of irrelevant data for most queries.
- You want to reduce {{site.data.keyword.cloudant_short_notm}} storage costs (pay-per-GB pricing).

### Creating partial indexes
{: #advanced-creating-partial-indexes}

[Use `partial_filter_selector`](/apidocs/cloudant#postfind) to specify which documents to include:

```json
{
  "index": {
    "fields": ["date", "category"]
  },
  "partial_filter_selector": {
    "status": "published"
  },
  "name": "published-articles-index"
}
```

This index only includes documents where `status: "published"`, making it much smaller and faster for queries on published content.

The `partial_filter_selector` can include any valid selector, not just simple single field selectors as shown in the example.
{: tip}

### Real-world example: blog system
{: #advanced-partial-indexes-example}

**Scenario**: A blog database with 100,000 articles, where 80,000 are drafts and 20,000 are published.

**Traditional index** (covers all documents):

```json
{"fields": ["category", "publishDate"]}
```

**Partial index** (only published articles):

```json
{
  "index": {"fields": ["category", "publishDate"]},
  "partial_filter_selector": {"status": "published"}
}
```

Benefits:

- Index size: 80% smaller
- Query speed: 2-3x faster
- Storage cost: Significantly reduced
- Cache efficiency: More relevant data stays in memory

### Ensuring query compatibility with partial indexes
{: #advanced-partial-indexes-ensuring-query-compatibility}

To use the index, your query selector must be **compatible** with the partial filter.

This works:

```jsonc
// Compatible - query includes the partial filter condition
{
  "selector": {
    "status": "published",    // Matches partial filter
    "category": "technology"
  }
}
```

This doesn't work:

```jsonc
// Incompatible - query doesn't match partial filter
{
  "selector": {
    "status": "draft",        // Contradicts partial filter
    "category": "technology"
  }
}
```

## Advanced: covering indexes
{: #advanced-covering-indexes}

**Impact: 2-5x performance improvement for read-heavy workloads**

Covering indexes are a powerful optimization technique - they can answer queries entirely from the index without retrieving the original documents.

### Understanding covering indexes
{: #advanced-understanding-covering-indexes}

A covering index occurs when your index contains all the fields needed to satisfy both the query selector **and** the returned fields:

```jsonc
// Index covers these fields
{
  "index": {
    "fields": ["username", "status", "date", "amount"]
  }
}

// Query only needs indexed fields
{
  "selector": {"username": "bob@email.com", "status": "paid"},
  "fields": ["username", "date", "amount"]  // All fields in index
}
```

{{site.data.keyword.cloudant_short_notm}} can return results directly from the index without reading the original documents, providing significant performance benefits.

### Designing for coverage
{: #advanced-designing-covering-indexes}

Plan your indexes around common query patterns:

```javascript
// Analyze your query patterns
const commonQueries = [
  {selector: {username: "...", status: "..."}, fields: ["date", "amount"]},
  {selector: {status: "...", date: {...}}, fields: ["username", "amount"]},
  {selector: {username: "..."}, fields: ["status", "date", "total"]}
];

// Design covering index
{
  "index": {
    "fields": ["username", "status", "date", "amount", "total"]
  }
}
```

The [`_explain` endpoint](/apidocs/cloudant#postexplain) will contain `"covering": true` when an index is found that can cover the query.

## Advanced: index consolidation strategy
{: #advanced-index-consolidation-strategy}

Instead of creating many narrow indexes, consider fewer broader compound indexes that can cover multiple query patterns. Using fewer reduces the time required to build indexes.

**Instead of:**

```json
{"fields": ["username"]}
{"fields": ["status"]} 
{"fields": ["date"]}
{"fields": ["username", "date"]}
```

**Use:**

```json
{"fields": ["username", "status", "date", "amount"]}
```

This single index can efficiently serve queries filtering on:

- `username` only
- `username` and `status`
- `username`, `status`, and `date` range
- All the above combinations, with covering benefits when `amount` is requested

## Production deployment checklist
{: #production-deployment-checklist}

Before deploying queries to production, verify:

### Index strategy review
{: #production-deployment-checklist-index-strategy-review}

- All production queries have appropriate indexes
- Compound indexes follow the range-field-last rule
- Field ordering reflects actual selectivity in your data
- No queries accidentally fall back to `_all_docs`

### Performance validation
{: #production-deployment-checklist-performance-validation}

- Test queries with production-scale data volumes
- Monitor efficiency ratios (aim for >50%)
- Validate execution times meet SLA requirements
- Consider partial indexes for cost optimization

### Monitoring setup
{: #production-deployment-checklist-monitoring-setup}

- Enable `execution_stats` logging
- Set up alerts for poor efficiency ratios
- Monitor index usage patterns
- Plan for query performance regression testing

### Error handling
{: #production-deployment-checklist-error-handling}

- Use `allow_fallback: false` to prevent expensive accidents
- Handle index selection errors gracefully
- Plan for index building time during deployments

## Further reading
{: #further-reading}

The {{site.data.keyword.cloudant_short_notm}} blog has further in-depth articles on exploring and improving query performance:

- [Explaining Explain](https://blog.cloudant.com/2024/01/17/Explaining-Explain.html) describes how to interpret and use the output of the `_explain` request.
- [Optimising {{site.data.keyword.cloudant_short_notm}} Queries](https://blog.cloudant.com/2020/05/20/Optimising-Cloudant-Queries.html).
- [Avoiding Query Fallback](https://blog.cloudant.com/2025/02/04/Avoid-Fallback.html) shows a technique to prevent critical queries falling back to full table scans.

## Conclusion
{: #conclusion}

Optimizing {{site.data.keyword.cloudant_short_notm}} Query performance is a systematic process that starts with avoiding the most expensive mistakes (large database scans) and progresses through increasingly sophisticated techniques. By following this guide:

1. **Foundation**: Create appropriate indexes and avoid large scans
2. **Structure**: Order compound index fields correctly with ranges last
3. **Operators**: Choose efficient query operators
4. **Compatibility**: Understand document structure requirements
5. **Monitoring**: Continuously measure and optimize performance
6. **Advanced**: Leverage partial indexes and covering patterns

Small changes in index design can produce dramatic performance improvements. A properly optimized query examining 2 documents to return 2 results will always outperform an unoptimized query examining 50,000 documents for the same 2 results.

Remember: the difference between a well-optimized and poorly-optimized query isn't just performance - it's the difference between a scalable application and one that breaks under load.
