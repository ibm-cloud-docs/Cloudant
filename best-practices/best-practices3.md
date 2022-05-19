---

copyright:
  years: 2022
lastupdated: "2022-05-10"

keywords: design document management, rate limits, partitioned queries, timeboxed database, logging, http traffic, primary index

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# {{site.data.keyword.cloudant_short_notm}} in practice
{: #cloudant-in-practice}

If you're new to {{site.data.keyword.cloudantfull}}, but you're not new to database systems, the following information discusses the suggested practices from someone who has seen the product from all angles: 
- The customers who use it.
- The engineers who run it.
- The folks who support and sell it.
{: shortdesc}

For more information, see [Data modeling](https://test.cloud.ibm.com/docs/Cloudant?topic=Cloudant-data-modeling) or [Indexing and querying](/docs/Cloudant?topic=Cloudant-indexing-and-querying).

The content in this document was originally written by Stefan Kruger as a [*Best and Worst Practice*](https://blog.cloudant.com/2019/11/21/Best-and-Worst-Practices.html) blog post on 21 November 2019.

## Avoid conflicts
{: #avoid-conflicts}

{{site.data.keyword.cloudant_short_notm}} is designed to treat conflicts as a natural state of data in a distributed system. This is a powerful feature that helps an {{site.data.keyword.cloudant_short_notm}} cluster be highly available at all times. However, the assumption is that conflicts are still reasonably rare. Keeping track of conflicts in {{site.data.keyword.cloudant_short_notm}}’s core has significant cost associated with it.

It is perfectly possible (but a bad idea!) to just ignore conflicts, and the database merrily carries on operating by choosing a random, but deterministic revision of conflicted documents. However, as the number of unresolved conflicts grows, the performance of the database goes down a black hole, especially when replicating.

As a developer, it’s your responsibility to check for, and to resolve, conflicts — or even better, employ data models that make conflicts impossible.

If you routinely create conflicts, you should really consider model changes: even if you resolve your conflicts diligently, the conflict branches in the revision tree remain, and there is no easy way to tidy that up. For more information, see the following websites:

- {{site.data.keyword.cloudant_short_notm}} guide to [conflicts](/docs/Cloudant?topic=Cloudant-conflicts#conflicts)
- {{site.data.keyword.cloudant_short_notm}} guide to versions and [MVCC](/docs/Cloudant?topic=Cloudant-document-versioning-and-mvcc#document-versioning-and-mvcc)
- Three-part blog series on [conflicts](https://developer.ibm.com/blogs/)

## Deleting documents won't delete them
{: #deleting-documents}

Deleting a document from an {{site.data.keyword.cloudant_short_notm}} database doesn’t actually purge it. Deletion is implemented by writing a new revision of the document under deletion, with an added field `_deleted: true`. This special revision is called a `tombstone`. Tombstones still take up space and are also passed around by the replicator.

Models that rely on frequent deletions of documents are not suitable for {{site.data.keyword.cloudant_short_notm}}. For more information, see {{site.data.keyword.cloudant_short_notm}} tombstone [docs](/docs/Cloudant?topic=Cloudant-documents#-tombstone-documents).

## Be careful with updates
{: #take-care-with-updates}

It is more expensive in the long run to mutate existing documents than to create new ones, as {{site.data.keyword.cloudant_short_notm}} always needs to keep the document tree *structure around*, even if internal nodes in the tree are stripped of their payloads. If you find that you create long revision trees, your replication performance suffers. Moreover, if your update frequency goes above, say, once or twice every few seconds, you’re more likely to produce update conflicts.

Prefer models that are immutable.

The obvious question after the sections, *Does deleting documents fully delete them?* and *How can I be careful with updates?*, is—won’t the data set grow unbounded if my model is immutable? If you accept that deletes don’t completely purge the deleted data and that updates are not updating in place in terms of data volume growth, there is not much difference. Managing data volume over time requires different techniques.

The only way to truly reclaim space is to delete databases, rather than documents. You can replicate only winning revisions to a new database and delete the old to get rid of lingering deletes and conflicts. Or perhaps you can build it into your model to regularly start new databases (say ‘annual data’) and archive off (or remove) outdated data, if your use case allows.

## Eventual consistency is a harsh taskmaster (a.k.a. don’t read your writes)
{: #eventual-consistency-harsh-taskmaster}

Eventual consistency is a great idea on paper, and a key contributor to {{site.data.keyword.cloudant_short_notm}}’s ability to scale out in practice. However, it’s fair to say that the mindset required to develop against an eventually consistent data store does not feel natural to most people.

You often get stung when writing tests like the following tests:

1. Create a database.
2. Populate the database with some test data.
3. Query the database for some subset of this test data.
4. Verify that the data you got back is the data you expected to get back.

Nothing wrong with that? That works on every other database you’ve ever used, right?

Not on {{site.data.keyword.cloudant_short_notm}}.

Or rather, it works 99 times out of 100.

The reason for this is that there is a (mostly) small inconsistency window between writing data to the database, and this being available on all nodes of the cluster. As all nodes in a cluster are equal in stature, there is no guarantee that a write and a subsequent read will be serviced by the same node, so in some circumstances the read may be hitting a node before the written data has made it to this node.

So why don’t you just put a short delay in your test between the write and the read? That will make the test less likely to fail, but the problem is still there.

{{site.data.keyword.cloudant_short_notm}} has no transactional guarantees, and whilst document writes are atomic (you’re guaranteed that a document can either be read in its entirety, or not at all), there is no way to close the inconsistency window. It’s there by design.

A more serious concern that should be at the forefront of every developer’s mind is that you can’t safely assume that data you write will be available to anyone else at a specific point in time. This takes some getting used to if you come from a different kind of database tradition.

**Testing Tip**: What you *can* do to avoid the inconsistency window in testing is to test against a single-node instance of {{site.data.keyword.cloudant_short_notm}} or CouchDB running say in Docker ([docker information](https://hub.docker.com/_/couchdb/){: external}). A single node removes the eventual consistency issue, but beware that you are testing against an environment that behaves differently from what you target in production. *Caveat Emptor*.

## Replication isn't magic
{: #replication-is-not-magic}

    “So let’s set up three clusters across the world, Dallas, London, Sydney, with bi-directional synchronisation between them to provide real-time collaboration between our 100,000 clients.”

No. Just… No.
{{site.data.keyword.cloudant_short_notm}} is good at replication. It’s so effortless that it can seem like magic, but note that it makes no latency guarantees. In fact, the whole system is designed with eventual consistency in mind. Treating {{site.data.keyword.cloudant_short_notm}}’s replication as a real-time messaging system will not end up in a happy place. For this use case, put a system in between that was designed for this purpose, such as [Apache Kafka](https://kafka.apache.org/).

It’s difficult to put a number on replication throughput—the answer is always, “It depends.” Things that impact replication performance include, but are not limited to:

1. Change frequency
2. Document size
3. Number of simultaneous replication jobs on the cluster as a whole
4. Wide (conflicted) document trees
5. Your reserved throughput capacity settings

For more information, see the following websites:

- Blog post on [replication topology](https://dx13.co.uk/articles/2017/11/07/cloudant-replication-topologies-and-failover/)
- {{site.data.keyword.cloudant_short_notm}} [guide to replication](/docs/Cloudant?topic=Cloudant-replication-guide#replication)

## Use the bulk API
{: #use-bulk-api}

{{site.data.keyword.cloudant_short_notm}} has nice API endpoints for bulk loading (and reading) many documents at once. This can be much more efficient than reading/writing many documents one at a time. The write endpoint is shown in the following example:

```sh
${database}/_bulk_docs
```
{: codeblock}

Its main purpose is to be a central part in the replicator algorithm, but it’s available for your use, too, and it’s pretty awesome.

With `_bulk_docs`, in addition to creating [PouchDB](https://pouchdb.com/), implement create, update, and delete even for single documents this way for fewer code paths.

Here is an example creating one new, updating a second existing, and deleting a third document:

```sh
curl -XPOST 'https://ACCT.cloudant.com/DB/_bulk_docs' \
     -H "Content-Type: application/json" \
     -d '{"docs":[{"baz":"boo"}, \
         {"_id":"463bd...","foo":"bar"}, \
         {"_id":"ae52d...","_rev":"1-8147...","_deleted": true}]}'
```
{: codeblock}

You can also fetch many documents at once by issuing a POST to `_all_docs` (there is also a newish endpoint called `_bulk_get`, but this is probably not what you want—it’s there for a specific internal purpose).

To fetch a fixed set of docs using `_all_docs`, `POST` with a `keys` body:

```sh
curl -XPOST 'https://ACCT.cloudant.com/DB/_all_docs' \
     -H "Content-Type: application/json" \
     -d '{"keys":["ab234....","87addef...","76ccad..."]}'
```
{: codeblock}

{{site.data.keyword.cloudant_short_notm}} (at the time of writing) imposes a max request size of 11 MB, so `_bulk_docs` requests exceeding this size are rejected with a `413: Payload Too Large error`.
{: note}

For more information, see the following websites:

- {{site.data.keyword.cloudant_short_notm}} [bulk operations docs](/docs/Cloudant?topic=Cloudant-documents#bulk-operations)
- {{site.data.keyword.cloudant_short_notm}} [request and doc size limits](#replication-is-not-magic)

## Don’t mess with Q, R and N unless you really know what you are doing
{: #eventual-consistency-harsh-taskmaster}

Do not change Q, R, and N unless you really know what you're doing. {{site.data.keyword.cloudant_short_notm}}’s quorum and sharding parameters, once you discover them, seem like tempting options to change the behavior of the database.

*Stronger consistency—surely I can just set the write quorum to the replica count?*

No! Recall that there is no way to close the inconsistency window in a cluster.

Don’t go there. The behavior will be much harder to understand especially during network partitions. If you’re using Cloudant-the-service, the default values are fine for the vast majority of users.

There are times when tweaking the shard count for a database is essential to get the best possible performance, but if you can’t say why this is, you’re likely to make your situation worse.

## {{site.data.keyword.cloudant_short_notm}} is rate limited — let this inform your code
{: #cloudant-rate-limited}

Cloudant-the-service (unlike vanilla CouchDB) is sold on a “reserved throughput capacity” model. That means that you pay for the *right to use* up to a certain throughput, rather than the throughput you actually end up consuming. This takes a while to sink in. One somewhat flaky comparison might be that of a cell phone contract where you pay for a set number of minutes regardless of whether you end up using them or not.

Although the cell phone contract comparison doesn’t really capture the whole situation. There is no constraint on the sum of requests you can make to {{site.data.keyword.cloudant_short_notm}} in a month; the constraint is on how *fast* you make requests.

It’s really a promise that you make to {{site.data.keyword.cloudant_short_notm}}, not one that {{site.data.keyword.cloudant_short_notm}} makes to you: you promise to not make more requests per second than what you said you would up front. A top speed limit, if you like. If you transgress, {{site.data.keyword.cloudant_short_notm}} fails your requests with a status of `429: Too Many Requests`. It’s your responsibility to look out for this, and deal with it appropriately, which can be difficult when you’ve got multiple app servers. How can they coordinate to ensure that they collectively stay below the requests-per-second limit?

{{site.data.keyword.cloudant_short_notm}}’s official client libraries have some built-in provision for this that can be enabled (note: this is switched off by default to force you to think about it), following a “back-off and retry” strategy. However, if you rely on this facility alone you will eventually be disappointed. Back-off and retry only help in cases of temporary transgression, not a persistent butting up against your provisioned throughput capacity limits.

Your business logic *must* be able to handle this condition. Another way to look at it is that you get the allocation you pay for. If that allocation isn’t sufficient, the only solution is to pay for a higher allocation.

Provisioned throughput capacity is split into three different buckets: *Lookups*, *Writes*, and *Queries*. A *Lookup* is a “primary key” read—fetching a document based on its `_id`. A *Write* is storing a document or attachment on disk, and a *Query* is looking up documents via a secondary index (any API endpoint that has a `_design` or `_find` in it).

You get different allocations of each and the ratios between them are fixed. This fact can be used to optimize for cost. As you get 20 *Lookups* for every 1 *Query* (per second), if you find that you’re mainly hitting the *Query* limit but you have plenty headroom in *Lookups*, it may be possible to reduce the reliance on *Queries* through some remodeling of the data or perhaps doing more work client-side.

The corollary here though is that you can’t assume that any 3rd party library or framework optimizes for cost ahead of convenience. Client-side frameworks that support multiple persistence layers via plugins are unlikely to be aware of this, or perhaps even incapable of making such trade-offs.

Checking this before committing to a particular tool is a good idea.

It is also worth understanding that the rates aren’t directly equivalent to HTTP API endpoint calls. You should expect that for example a bulk update will count according to its constituent document writes.

- {{site.data.keyword.cloudant_short_notm}} docs on [plans and pricing](/docs/Cloudant?topic=Cloudant-ibm-cloud-public#ibm-cloud-public) on {{site.data.keyword.IBM_notm}} Public Cloud


## Logging helps you see what’s going on
{: #see-whats-going-on-with-logs}

{{site.data.keyword.cloudant_short_notm}}’s logs indicating each API call made, what was requested and how long it took to respond can be automatically spooled to LogDNA for analysis and reporting for IBM Cloud-based services. This data is useful to keeping an eye on request volumes, performance and whether your application is exceeding your {{site.data.keyword.cloudant_short_notm}} service’s provisioned capacity.

The logging service is easy to set up and free to get started. Paid-for plans allow data to be parsed, retained and archived to Object Storage. Slices and aggregations of your data can be built up into visual dashboards to give you an at-a-glance view of your {{site.data.keyword.cloudant_short_notm}} traffic. For more information, see the following website:

- [{{site.data.keyword.cloudant_short_notm}} Logging with LogDNA blog](https://blog.cloudant.com/2019/09/16/Cloudant-Logging-with-LogDNA.html){: external}

## Compress your HTTP traffic
{: #how-to-compress-my-http-traffic}

{{site.data.keyword.cloudant_short_notm}} compresses its JSON responses to you if you supply an HTTP header in the request indicating that your code can handle data in this format:

```sh
Request:

> GET /cars/_all_docs?limit=5&include_docs=true HTTP/2
> Host: myhost.cloudant.com
> Accept: */*
> Accept-Encoding: deflate, gzip

Response:

< HTTP/2 200 
< content-type: application/json
< content-encoding: gzip
```
{: codeblock}

Compressed content occupies a fraction of the size of the uncompressed equivalent, meaning that it takes a shorter time to transport the data from {{site.data.keyword.cloudant_short_notm}}’s servers to your application.

You may also choose to compress HTTP request bodies too by using the Content-encoding header. This practice helps lower data transfer times when writing documents to {{site.data.keyword.cloudant_short_notm}}.
{: note}

