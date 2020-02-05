---

copyright:
  years: 2015, 2019
lastupdated: "2019-11-26"

keywords: immutable data, pre-calculate results, de-normalize data, avoid conflicts, conflict resolution

subcollection: cloudant

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

<!-- Acrolinx: 2017-05-10 -->

# Five tips for modeling your data to scale
{: #five-tips-for-modeling-your-data-to-scale}

The finer 
points of modeling your application's data to work efficiently on a large scale are discussed here.
{: shortdesc}

*(This guide is based on a Blog article by Mike Rhodes: ["My top 5 tips for modeling your data to scale"](https://cloudant.com/blog/my-top-5-tips-for-modeling-your-data-to-scale/){: new_window}{: external}, originally published 17 December 2013.)*

The way you model data on {{site.data.keyword.cloudantfull}} significantly impacts how your application can 
scale. Our underlying data model differs substantially from a relational model, and ignoring 
this distinction can be the cause of performance issues down the road.

As always, successful modeling involves achieving a balance between ease of use versus the 
performance characteristics you're hoping to achieve.

Without further ado, let’s jump in.

## Consider immutable data
{: #consider-immutable-data}

If you're changing the same piece of state at a rate of once per second or more, consider 
making your documents immutable. This practice significantly decreases the chance that you create 
conflicted documents.

Conversely, if you're updating a specific document less than once every ten seconds, an 
update-in-place data model - that is, updating existing documents - simplifies your 
application code considerably.

Typically, data models based on immutable data require the use of views to summarize 
the documents that comprise the current state. As views are precomputed, this process most likely won't 
adversely affect application performance.

## Why this helps you consider immutable data 
{: #why-this-helps-you-consider-immutable-data}

Behind our `https://$ACCOUNT.cloudant.com/` interface is a distributed database. 
Within the cluster, documents are bucketed into a number of shards that collectively form the 
database. These shards are then distributed across nodes in the cluster. This is what 
allows us to support databases many terabytes in size.

By default, in addition to the splitting of a database into shards, all shards have three 
copies, or shard replicas, each of which resides on a different node of the database cluster. Sharding allows the database to continue serving requests if a node fails. Therefore, saving a document involves writing to three nodes. If two updates are made concurrently to the same document, a subset of nodes might accept the first update, and another subset might accept the second update. When the cluster discovers this 
discrepancy, it combines the documents in the same way as normal replication does for 
concurrent updates by creating a conflict.

Conflicted documents harm performance. See the following text for more details on why conflicted documents happen. 
A highly concurrent update-in-place pattern also increases the likelihood that writes get rejected. In that situation, the `_rev` parameter isn’t the expected one, which forces your 
application to retry and delay processing.

We found that this conflicted-document scenario is significantly more likely to happen 
for updates that occur more often than once a second. We recommend immutable documents for updates that occur 
more than once every ten seconds to be on the safe side.

## Use views to pre-calculate results rather than as search indexes
{: #use-views-to-pre-calculate-results-rather-than-as-search-indexes}

Rather than using views as glorified search indexes - "get me all `person` documents" - try 
to get the database to do the work for you. For example, rather than retrieving all 10,000 
person documents to calculate the combined hours worked, use a view with a composite key to pre-calculate the hours worked by year, month, day, half-day, and hour by using the `_sum` built-in reduce. You save work in your application and allow the database to concentrate on serving many small requests. This method is preferable to reading huge amounts of data from disk to service a single large request.

## Why this helps you use views to pre-calculate results
{: #why-this-helps-you-use-views-to-pre-calculate-results}

It's straightforward. First, both maps and reduces are precomputed. Therefore, the result of a reduce function is a cheap operation. The operation cost is low even when 
compared to the significant amounts of IO required to stream hundreds or even thousands of 
documents from the on-disk storage.

At a lower level, when a node receives a view request, it asks the nodes that hold the shard 
replicas of the view's database for the results of the view request from the documents in 
each shard. As it receives the answers, taking the first answer for each shard replica, the node 
that services the view request combines the results and streams the final result to the client. 
As more documents are involved, it takes longer for each replica to stream the results from 
disk and across the network. In addition, the node that services the request has much more work to 
do in combining the results from each database shard.

Overall, the goal is for a view request to require the minimum amount of data from each shard, 
minimizing the time that the data is in transit and being combined to form the final result. Using 
the power of views to precompute aggregate data is one way to achieve this aim. This practice decreases the time that your application spends waiting for the request to complete.

## De-normalize your data
{: #de-normalize-your-data}

In relational databases, normalizing data is often the most efficient way to store data. 
This practice makes sense when you can use JOINs to easily combine data from multiple tables. 
You're more likely to need an HTTP GET request for each piece of data with {{site.data.keyword.cloudant_short_notm}}. If you reduce  
the number of requests you need to build a complete picture of a modeled entity, it allows 
you to present information to your users more quickly.

Using views allows you to get many of the benefits of normalized data while you maintain the 
de-normalized version for efficiency.

As an example, in a relational schema, you'd normally represent tags in a separate table and use 
a connecting table to join tags with their associated documents. This practice allows quick lookup of all 
documents with a specific tag.

In {{site.data.keyword.cloudant_short_notm}}, you'd store tags in a list in each document. You would then use a view to get the 
documents with a specific tag by 
[emitting each tag as a key in your view's map function](/docs/services/Cloudant?topic=cloudant-views-mapreduce#views-mapreduce). 
Querying the view for a specific key then provides all the documents with that tag.

## Why this helps you de-normalize your data
{: #why-this-helps-you-de-normalize-your-data}

It all comes down to the number of HTTP requests that your application makes. There's a cost to opening HTTP connections, particularly HTTPS. While reusing connections helps, making fewer requests overall speeds up the rate that your application can process data.

As a side benefit, de-normalized documents and pre-computed views often allow you to have the 
value your application requires generated ahead of time, rather than being constructed while in progress at query time.

## Avoid conflicts by using finer-grained documents
{: #avoid-conflicts-by-using-finer-grained-documents}

In conflict with the advice to de-normalize your data is this advice, use 
fine-grained documents to reduce the chance of concurrent modifications creating conflicts. 
This practice is somewhat like normalizing your data. There's a balance to strike between reducing the 
number of HTTP requests and avoiding conflicts.

For example, see the medical record that contains a list of operations:

```json
{
    "_id": "Joe McIllness",
    "operations": [
        { "surgery": "heart bypass" },
        { "surgery": "lumbar puncture" }
    ]
}
```
{: codeblock}

If Joe is unfortunate enough to have lots of operations at the same time, the concurrent updates to a document are likely to create conflicted documents. 
Better to break out the operations into separate documents, which refer to Joe's person document, 
and use a view to connect things together. To represent each operation, you’d upload documents 
like the following two examples:

```json
{
    "type": "operation",
    "patient": "Joe McIllness",
    "surgery": "heart bypass"
}
```
{: codeblock}

```json
{
    "type": "operation",
    "patient": "Joe McIllness",
    "surgery": "lumbar puncture"
}
```
{: codeblock}

Emitting the `"patient"` field as the key in your view would then allow querying for all 
operations for a specific patient. Again, views are used to help knit together a full picture of 
a specific entity from separate documents. Views help keep the number of HTTP requests low even though we split up the data for a single modeled entity.

## Why this helps you avoid conflicts
{: #why-this-helps-you-avoid-conflicts}

Avoiding conflicted documents helps speed up many operations on your {{site.data.keyword.cloudant_short_notm}} databases because there’s a process that works out the current winning revision used each time 
that the document is read, for example, single document retrievals, call with `include_docs=true`, view building, and so on.

The winning revision is a particular revision from the document’s overall tree. Recall that 
documents on {{site.data.keyword.cloudant_short_notm}} are in fact trees of revisions. An arbitrary but deterministic algorithm 
selects one of the non-deleted leaves of this tree to return when a request is made for the 
document. Larger trees with a higher branching factor take longer to process than a document 
tree with no or few branches: each branch needs to be followed to see whether it’s a candidate to 
be the winning revision. Potential victors then need to be compared against each other to make 
the final choice.

{{site.data.keyword.cloudant_short_notm}} handles small numbers of branches well. After all, replication relies on the fact that documents can branch to avoid discarding data. However, when pathological levels are reached, particularly if the conflicts aren't resolved, it becomes very time-consuming and memory-intensive to walk the document tree.

## Build in conflict resolution
{: #build-in-conflict-resolution}

In an eventually consistent system like {{site.data.keyword.cloudant_short_notm}}, conflicts eventually happen. This fact is a price of our scalability and data resilience.

Structuring your data in such a way that resolving conflicts is quick and need not involve 
operator assistance helps your databases to hum along smoothly. The ability to 
automatically resolve conflicts without user involvement significantly 
improves their experience and reduces the support burden on your organization.

How you resolve conflicts is very application-specific, but here are a few tips:

-   Avoid invariants across document fields if possible. Avoiding invariants makes it more likely that a simple
    merge operation, if you take the changed field from each conflicted document revision, is
    suitable. This practice makes simpler and more robust application code.
-   Allow documents to stand alone. If you have to retrieve other documents to work out the correct
    resolution, it increases latency in conflict resolution. There's also a chance you get a
    version of the other documents that aren't consistent with the document you're resolving,
    making correct resolution difficult. And what if the other documents are conflicted?

## Why this helps you build in conflict resolution 
{: #why-this-helps-you-build-in-conflict-resolution}

Heavily conflicted documents exert a heavy toll on the database. Building 
in the capability to resolve conflicts from the beginning is a great help in avoiding 
pathologically conflicted documents.

## Summary
{: #summary}

These tips demonstrate how modeling data affects your application’s 
performance. {{site.data.keyword.cloudant_short_notm}}’s data store has some specific characteristics, both to watch out for 
and to take advantage of, that ensure the database performance scales as your application 
grows. We understand the shift can be confusing, so we’re always on-hand to give advice.

For further reading, see this discussion on the
[data model for Foundbite](https://cloudant.com/blog/foundbites-data-model-relational-db-vs-nosql-on-cloudant/){: new_window}{: external},
or this [example from our friends at Twilio](https://www.twilio.com/blog/2013/01/building-a-real-time-sms-voting-app-part-3-scaling-node-js-and-couchdb.html){: new_window}{: external}.

