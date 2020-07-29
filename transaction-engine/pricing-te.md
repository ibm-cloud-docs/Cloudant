---

copyright:
  years: 2015, 2020
lastupdated: "2020-07-29"

keywords: pricing examples, data usage, ibm cloud usage dashboard

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

<!-- Acrolinx: 2020-03-18 -->

# Pricing
{: #pricing-te}

{{site.data.keyword.cloudantfull}} Standard on Transaction Engine plan is pro-rated hourly and priced based on two things:

1. The provisioned throughput capacity that you allocate for your instance.
2. The amount of data storage consumed.

## Provisioned Throughput Capacity
{: #provisioned-throughput-capacity-te}

You can scale your provisioned throughput capacity up and down in granular blocks of 50 reads/sec and 50 writes/sec, and pay pro-rated hourly based on the peak capacity for the hour. The provisioned throughput capacity is based on read and write capacity, or in another words, the ability to do a certain amount of reads per second or writes per second. There is no separate global query capacity in the Standard on Transaction Engine plan as global queries are counted as reads. For each hour that an instance is provisioned, a certain amount of read capacity units and write capacity units will be submitted for usage.  So at the minimum capacity setting in a given hour, 50 Read Capacity Unit Hours and 50 Write Capacity Unit Hours will be submitted. Further accumulation of Capacity Unit Hours quantities will occur for each hour and quantity of capacity set. See the catalog for pricing for read and write capacity.

Read and write capacity can't be scaled independently. Use the slider to select the number of blocks of provisioned throughput capacity based on the maximum limit of either reads/sec or writes/sec required for your application. For example, if your application requires 1,000 reads per second, use the slider to select the capacity that offers 1,000 reads/sec and 1,000 writes/sec, even if you don't need the corresponding number of writes.

You can't exceed the reserved capacity for either reads or writes. If you do, an HTTP 429 status code occurs that indicates the application is trying to exceed its provisioned throughput capacity allowance.

Go to the {{site.data.keyword.cloud_notm}} Dashboard and select the instance, then select **Manage** > **Capacity** tab to view and change the provisioned throughput capacity, and see the hourly and approximate monthly costs for each setting. See an example slider in the following image:

![Capacity slider](../images/manage_capacity_slider_te.png){: caption="Figure 1. Capacity slider" caption-side="bottom"}

## Read requests
{: #read-requests-te}

Read requests read documents or execute queries on database content. A read
request consumes read units as follows:

- 1 read unit to open the request's transaction.
- A further 1 read unit for each document read.
- A further 1/100th of a read unit for each row of an index read.

Any fraction in the total cost is rounded up to the next full read unit.

To properly estimate cost, it's important to know what constitutes reading an
index row, and how that relates to the results the client receives in the HTTP
response. This differs by index type:

- For view indexes, each row includes both key and value.
- For Mango indexes, each row is not seen by the client, but includes a document
  ID that is used internally to complete processing of the query. As further
  processing is required, the number of rows read from an index can differ
  significantly from the number of results the response contains. See further
  notes below.

## Write requests
{: #write-requests-te}

Write requests create, update, or delete documents. They consume write units as
follows:

- 1 write unit to open the request's transaction.
- A further 1 write unit for each document written. This includes writing
    the document content and the entries into the automatic primary and
    sequence indexes.
- A further 1 write unit for each row of an index written during foreground
  indexing of user-defined indexes (currently only Mango indexes support
  foreground indexing).

The write of a single document is therefore amplified, in terms of write units
consumed, by the amount of foreground indexing it causes. Foreground and
background indexing is discussed next.

## Updating indexes
{: #updating-indexes-te}

As well as serving requests, {{site.data.keyword.cloudant_short_notm}} needs to build indexes to serve queries. A
database may contain many indexes. {{site.data.keyword.cloudant_short_notm}} updates indexes in two ways:

- Foreground indexing happens within a document write transaction. It costs 1
  write unit per row emitted into an index. Only Mango indexes support
  foreground indexing.
- Background indexing is further discussed below and is used:
    - To keep view and search indexes up to date with document writes. It is
      guaranteed to happen after a document is written but before non-stale
      queries to an index occur.
    - To build newly created indexes of any type. Background indexing and
      indexing units.

Background indexing is used to keep view indexes up to date with
document writes and to build newly created indexes of any type.

- Background indexing consumes indexing units.
    - Each document read to build an index during background indexing costs 1
      indexing unit. A document is read when it is created, updated, or deleted.
    - Each row emitted to an index during background indexing costs 1 indexing
      unit.
- Each account includes an amount of indexing units which is set in proportion
  to the write unit throughput of an account. Indexing units are not charged for
  separately.
- The amount of indexing unit throughput is a multiple of the write unit
  throughput for an account. It is designed to allow a moderate number of
  indexes to be kept up to date when maintaining maximum write throughput, as
  well as a very small number of new indexes to be created.
    - This means that if you have many indexes, it is possible to write
      documents fast enough to exhaust background indexing capacity, meaning
      that indexes may never "catch up" with new writes. If indexes are failing
      to keep up to date sufficiently quickly, provision more write capacity to
      your account to increase the amount of indexing unit throughput
      provisioned for your account.
    - Creating a new index of any type (Mango or view) will consume a
      large amount of indexing unit throughput while the index is initially
      being built. This is because all existing documents in a database need to
      be read and added to the index. We recommend creating only one new index
      at a time to allow each new index to be built in a timely manner;
      attempting to build several new indexes in parallel is likely to cause
      problems with indexes falling behind writes.

## Examples
{: #request-examples-te}

This section contains some examples of how many units some example requests
consume.

| Request | Unit Total |
|---------|------------|
| Read a single document using `GET /{DATABASE}/{ID}`. | 1 unit to open the transaction. </br>1 unit to read the {ID} document. </br>2 read units total. |
| Read 5 documents using `_bulk_get`. | 1 unit to open the transaction. </br>5 units to read 5 documents. </br>6 read units total. |
| Query a view that returns 7 results. | 1 unit to open the transaction. </br>7/100 = 0.07 of a unit to read 7 rows. </br>1.07 read units total, which is rounded up to 2 read units for the request. |
| Query a view that returns 7 results and retrieves the documents using `include_docs=true`. | 1 unit to open the transaction. </br>7/100 = 0.07 of a unit to read 7 rows. </br>7 units to read 7 documents. </br>8.07 read units total, which is rounded up to 9 read units for the request. |
| Mango query that returns 7 results and can be completely satisfied with an index. This is the optimal way to use Mango indexes. | 1 unit to open the transaction. </br>7/100 = 0.07 of a unit to read 7 rows. </br>7 units to read 7 documents (Mango always reads the documents to return them to you). </br>8.07 read units total, which is rounded up to 9 read units for the request. |
| Mango query that returns 7 results and is partially satisfied with an index but requires further processing on the documents themselves (for example, when a regex is used). The part of the query's selector that can be satisfied by using the index reads 26 rows, then 26 documents need to be read, after applying the regex in the selector, 19 documents are discarded from the initial result set. | 1 unit to open the transaction. </br>26/100 = 0.26 read units to read 26 rows. </br>26 units to read 26 documents (Mango always reads the documents to return them to you). </br>27.26 read units total, which is rounded up to 28 read units for the request. |
| Query `_all_docs` using a `limit` of 200 and retrieves the documents using `include_docs=true`. |1 unit to open the transaction. </br>200/100 = 2 units to read 200 rows. </br>200 units to read 200 documents. </br>203 read units total. | 
{: class="simple-tab-table"}
{: caption="Table 1. Example read units" caption-side="top"}
{: #units-example1}
{: tab-title="Read units"}
{: tab-group="Units-examples"}

| Request | Unit Total |
|---------|------------|
| Write a single document using `POST /{DB}/{ID}` (whether creating or updating the document) to a database with no Mango indexes. | 1 unit to open the transaction. </br>1 unit to write the document. </br>2 units total. |
| Write 5 documents using `_bulk_docs` to a database with no Mango indexes. | 1 unit to open the transaction. </br>5 units to write the document. </br>6 units total. |
| Write a single document by using `POST /{DB}/{ID}` (whether creating or updating the document) to a database with two Mango indexes that each emit a single row per document. | </br>1 unit to open the transaction. </br>1 unit to write the document. </br>2 units to write two Mango index rows (1 per index). </br>4 units total. |
| Write 5 documents using `_bulk_docs` to a database with two Mango indexes that each emit a single row per document. | 1 unit to open the transaction. </br>5 units to write the document. </br>10 units to write two Mango index rows (1 per index).</br>16 units total. |
{: caption="Table 2. Example write units" caption-side="top"}
{: #units-example2}
{: tab-title="Write units"}
{: tab-group="Units-examples"}
{: class="simple-tab-table"}

## Data Storage
{: #data-storage-te}

Data is metered and usage submitted hourly and based on the Gigabyte Hours metric. For each hour, only the storage used above the free allotment of 25GB will be submitted for usage. For example, if for a given hour there are 30GB of storage in the instance, then 5 Gigabyte Hours of storage usage will be submitted. Storage is inclusive of both the raw JSON document size as well as the size of the indexes in each database in the instance. See the catalog for pricing for storage.

## Pricing examples
{: #pricing-examples-te}

Let's assume you're building a mobile app with {{site.data.keyword.cloudant_short_notm}} and don't yet know the capacity
that you might need. In this case, we recommend that you start with the lowest provisioned throughput
capacity and increase it as needed by your application's usage over time. {{site.data.keyword.cloudant_short_notm}} bills
pro-rated hourly and changing the provisioned throughput capacity doesn't incur downtime.

For the mobile app example, you start with the minimum provisioned throughput capacity for
the Standard on Transaction Engine plan that is 50 reads/sec and 50 writes/sec. As shown in the catalog, a read capacity unit costs $0.00012/hour and a write capacity unit costs $0.00048/hour. A block of 50 reads/sec and 50 writes/sec of capacity costs 50 reads/sec * $0.00012/hour + 50 writes/sec * $0.00048/hour = $0.030/hour. When you need to scale up (or down), you
can scale in increments of these blocks of capacity. Assuming the instance has less than
the 25 GB of storage that is included in the Standard on Transaction Engine plan, no storage costs are incurred.

See the following example equation:

- $0.030 per hour \* 1 block (of 50 reads/sec and 50 writes/sec provisioned throughput capacity) \* 730 hours (approximate hours in a month)
- Total = $21.90

How do you estimate the total cost for provisioned throughput capacity per month of 1,000 reads/sec and 1,000 writes/sec?

- $0.030 per hour \* 20 blocks (of 50 reads/sec and 50 writes/sec provisioned throughput capacity) \* 730 hours (approximate hours in a month)
- Alternatively, the slider shows you the provisioned throughput capacity of 1000 reads/sec and 1000 writes/sec costs $0.600/hour \* 730 hours
- Total = $438.00


## Data usage pricing
{: #data-usage-pricing-te}

What about pricing for data overage? How does that work?

Plan | Storage Included | Overage Limit
-----|------------------|--------------
Standard on Transaction Engine | 25 GB | Additional storage costs $0.000342 per GB per hour, which is approximately $0.25/GB per month.
{: caption="Table 3. Data overage pricing" caption-side="top"}

## {{site.data.keyword.cloud_notm}} Usage Dashboard
{: #usage-dashboard-te}

How does data display in the {{site.data.keyword.cloud_notm}} Usage Dashboard?

Current and historical usage bills can be seen in the {{site.data.keyword.cloud_notm}} Dashboard, under **Manage** -> **Billing and usage** -> **Usage**. This view shows the totals for usage that are accrued during a particular month at the service, plan, or instance level. The Estimated Total reflects the bill so far for the month or for the  past complete months. It shows only the hourly costs that are accrued up to that point for the current month. By the end of the month, you see your total provisioned throughput capacity for the month reflected in the `Read Capacity Unit Hours` and `Write Capacity Unit Hours`. The `Gigabyte Hours` field shows only the storage that was billed for any hour the instance exceeded the free allotment of 25 GB.

In the following example, a quantity of 0 Gigabyte Hours reflects that the instance never exceeded 25 GB for the month. Additionally, you will see the total accumulation of read capacity unit hours and write capacity unit hours submitted at that point in the month.  As an example, an instance with 100 read/sec and 100 writes/sec for a month with 730 hours would have 730,000 read capacity unit hours and 730,000 write capacity unit hours submitted by the end of the month.

![Usage example](../images/usage_te_example.png){: caption="Figure 2. Usage example" caption-side="bottom"}
