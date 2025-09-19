---

copyright:
  years: 2015, 2025
lastupdated: "2025-09-19"

keywords: cloudant query, query parameters, query troubleshooting, query performance, monitor query usage, query scalability

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# Monitor for inefficient {{site.data.keyword.cloudant_short_notm}} queries
{: #monitor-for-inefficient-query-requests}

This document describes how to monitor the
{{site.data.keyword.cloudant_short_notm}} Query requests your application is
making. Finding and fixing inefficient queries is essential to application
stability and scaling.
{: shortdesc}

Because {{site.data.keyword.cloudant_short_notm}} Query is flexible, it is
possible to construct queries that require scanning a lot of data --- perhaps
even all the data in your database --- to generate the query result set.
Such queries are _inefficient_ and degrade performance as data volume grows.
Detecting these queries and fixing them is critical.

## Detecting inefficient queries using `execution_stats`

[{{site.data.keyword.cloudant_short_notm}} query
requests](/apidocs/cloudant#postfind) can return information which allows you
to detect inefficient queries. If you add `"execution_stats": true` to the
JSON query you send {{site.data.keyword.cloudant_short_notm}}, you will receive
statistics about the query execution in the response. 

These statistics are free to return, do not slow your query down and should be
requested in every query.
{: tip}

When you ask for `execution_stats` as part of your request, the response {{site.data.keyword.cloudant_short_notm}} returns will include this structure:

```json
"execution_stats": {
  "execution_time_ms": 14.37,
  "results_returned": 163,
  "total_docs_examined": 172,
  "total_keys_examined": 172,
}
```

The following table documents the `execution_stats` JSON structure shown above. Each field offers insight into how efficiently a query was processed and how much data was involved in the operation.

| **Field Name**           | **Description**                                                                 |
|--------------------------|---------------------------------------------------------------------------------|
| `execution_time_ms`      | Time taken to execute the query, measured in milliseconds.         |
| `results_returned`       | Number of results returned by the query.                         |
| `total_docs_examined`    | Total number of documents scanned during execution, regardless of match.       |
| `total_keys_examined`    | Total number of index keys examined to fulfill the query.                       |

### Deriving actionable metrics from `execution_stats`

Your application will need to read the `execution_stats` from the {{site.data.keyword.cloudant_short_notm}} response and emit them as metrics to your chosen metrics provider.

Two key metrics can be derived from the `execution_stats` structure:

| **Metric**                         | **Formula / Source**                                      | **Purpose**                                                                 |
|-----------------------------------|------------------------------------------------------------|------------------------------------------------------------------------------|
| **Execution Time (ms)**           | `execution_time_ms`                                        | Measures latency of query execution. Useful for detecting latency spikes. |
| **Query Inefficiency Ratio**        | `total_docs_examined / results_returned`                   | Indicates how many documents are scanned per result returned. High values suggest problem queries. |

While the execution time metric allows you to see queries after they have become problems, the _query inefficiency ratio_ allows you to find and fix queries _before_ they cause outages for your applications.


### Monitoring query execution time

Use the _execution time (ms)_ metric to detect slow queries affecting user experience or throughput.

Set thresholds based on expected performance. For example:

- Warn if execution time exceeds **50ms**
- Critical alert if execution time exceeds **200ms**

This is useful in catching both temporary incidents and long-term trends in
query performance.

### Monitoring query efficiency

Use the _query inefficiency ratio_ to detect inefficient queries _before_ they
create problems. High inefficiency ratios indicate queries that are likely to
affect your application's service quality.

A histogram of inefficiency ratios helps spot problematic queries. Use a label
or equivalent to attach the name of the query to each metric to quickly narrow
down which queries need your attention.

Continue monitoring this ratio as your dataset grows. A small data set might
have few enough documents that the ratio looks safe, but as the number of
documents increases it becomes significantly worse.

In addition, sudden changes in query efficiency might indicate unexpected
changes in data patterns that are worth investigating.

Recommended histogram buckets:

| **Efficiency Bucket** | **Interpretation**                               |
|-----------------------|--------------------------------------------------|
| 0–10                  | Efficient query                                  |
| 10–100                | Inefficient; plan to fix                         |
| 100+                  | Severe inefficiency; needs immediate attention   |

## Fixing inefficient queries

Once you have identified problematic queries --- hopefully before they
become a problem --- you can act to improve their efficiency.

Refer to [{{site.data.keyword.cloudant_short_notm}} Query performance optimization](/docs/Cloudant?topic=Cloudant-cloudant-query-performance-guide) for a complete guide to creating efficient and scalable indexes and queries.
