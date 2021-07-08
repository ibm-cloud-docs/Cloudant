---

copyright:
  years: 2015, 2021
lastupdated: "2021-07-08"

keywords: immutable data, pre-calculate results, de-normalize data, avoid conflicts, conflict resolution

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
{:support: data-reuse='support'}
{:faq: data-hd-content-type='faq'}

<!-- Acrolinx: 2021-04-13 -->

# Modeling data to scale FAQ
{: #five-tips-for-modeling-your-data-to-scale-faq}
{: faq}
{: support}

The way you model data on {{site.data.keyword.cloudantfull}} significantly impacts how your application can scale. The underlying data model differs substantially from a relational model, and ignoring this distinction can be the cause of performance issues down the road.

As always, successful modeling involves achieving a balance between ease of use versus the 
performance characteristics you're hoping to achieve.
{: shortdesc}

(The FAQ for modeling data to scale is based on a blog article by Mike Rhodes, *My top five tips for modeling your data to scale*, originally published 17 December 2013.)

## When must I make my documents immutable?
{: #consider-immutable-data}
{: faq}

If you're changing the same piece of state at a rate of once per second or more, consider 
making your documents immutable. This practice significantly reduces the chance that you create 
conflicted documents.

Conversely, if you're updating a specific document less than once every ten seconds, an 
update-in-place data model - that is, updating existing documents - simplifies your 
application code considerably.

Typically, data models based on immutable data require the use of views to summarize 
the documents that include the current state. As views are precomputed, this process most likely doesn't
adversely affect application performance.

## Why does this help me consider immutable data?
{: #why-this-helps-you-consider-immutable-data}
{: faq}

Behind the `https://$ACCOUNT.cloudant.com/` interface is a distributed database. 
Within the cluster, documents are bucketed into a number of shards that collectively form the 
database. These shards are then distributed across nodes in the cluster. This practice allows the support of databases many terabytes in size.

By default, the database is split into shards. Each shard has three 
copies, or shard replicas, which reside on a different node of the database cluster. Sharding allows the database to continue serving requests if a node fails, so saving a document involves writing to three nodes. If two updates are made concurrently to the same document, a subset of nodes might accept the first update, and another subset might accept the second update. When the cluster detects this 
discrepancy, it combines the documents in the same way as normal replication does for 
concurrent updates by creating a conflict.

## Why do I need to worry about conflicted documents?
{: #worry-conflicted-documents}
{: faq}

Conflicted documents harm performance. A highly concurrent update-in-place pattern also increases the likelihood that writes get rejected. In that situation, the `_rev` parameter isn’t the expected one, which forces your 
application to retry and delay processing.

This conflicted-document scenario is significantly more likely to happen 
for updates that occur more often than once a second. Use immutable documents for updates that occur 
more than once every ten seconds to be on the safe side.
{: note}

## How can I use views to pre-calculate results rather than as search indexes?
{: #use-views-to-pre-calculate-results-rather-than-as-search-indexes}
{: faq}

Rather than using views as search indexes, you can use the search *get me all `person` documents* and make the search extract the data for you. For example, you can retrieve all 10,000 
person documents to calculate the combined hours worked. However, it's better to use a view with a composite key to pre-calculate the hours worked by year, month, day, half-day, and hour by using the `_sum` built-in reduce. You save work in your application and allow the database to concentrate on serving many small requests. This method is preferable to reading huge amounts of data from disk to service a single large request.

## Why this method helps me use views to pre-calculate results?
{: #why-this-helps-me-use-views-to-pre-calculate-results}
{: faq}

It's straightforward. First, both maps and reduces are precomputed, so the result of a reduce function is a cheap operation. The operation cost is low even when 
compared to the significant amounts of IO required to stream hundreds or even thousands of 
documents from the on-disk storage.

At a deeper level, when a node receives a view request, it asks the nodes that hold the shard replicas of the view's database for the results of the view request from the documents in each shard. As it receives the answers, taking the first answer for each shard replica, the node 
that services the view request combines the results and streams the final result to the client. 
As more documents are involved, it takes longer for each replica to stream the results from 
disk and across the network. The node that services the request also has much more work to 
do in combining the results from each database shard.

Overall, the goal is for a view request to require the minimum amount of data from each shard. This practice 
minimizes the time that the data is in transit and being combined to form the final result. Using 
the power of views to precompute aggregate data is one way to achieve this aim. This practice reduces the time that your application spends waiting for the request to complete.

## How can I de-normalize my data?
{: #how-de-normalize-my-data}
{: faq}

In relational databases, normalizing data is often the most efficient way to store data. 
This practice makes sense when you can use `JOIN` to easily combine data from multiple tables. 
You're more likely to need an HTTP GET request for each piece of data with {{site.data.keyword.cloudant_short_notm}}. If you reduce the number of requests you need to build a complete picture of a modeled entity, you can present information to your users more quickly.

By using views, you get many of the benefits of normalized data while you maintain the 
de-normalized version for efficiency.

As an example, in a relational schema, you'd normally represent tags in a separate table and use 
a connecting table to join tags with their associated documents. This practice allows quick lookup of all 
documents with a specific tag.

In {{site.data.keyword.cloudant_short_notm}}, you'd store tags in a list in each document. You would then use a view to get the 
documents with a specific tag by 
[emitting each tag as a key in your view's map function](/docs/Cloudant?topic=Cloudant-views-mapreduce#views-mapreduce). 
Querying the view for a specific key then provides all the documents with that tag.

## How does this help me de-normalize my data?
{: #how-help-me-de-normalize-my-data}
{: faq}

It all comes down to the number of HTTP requests that your application makes. There's a cost to opening HTTP connections, particularly HTTPS. While reusing connections helps, making fewer requests overall speeds up the rate that your application can process data.

As a side benefit, when you use de-normalized documents and pre-computed views, you often have the 
value that your application requires generated ahead of time. Rather than it being constructed while in progress at query time.

## How can I avoid conflicts by using finer-grained documents?
{: #how-avoid-conflicts-finer-grained-documents}
{: faq}

In conflict with the advice to de-normalize your data is this advice, use 
fine-grained documents to reduce the chance of concurrent modifications that create conflicts. 
This practice is somewhat like normalizing your data. There's a balance to strike between reducing the 
number of HTTP requests and avoiding conflicts.

For example, see the medical record that includes a list of operations:

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
a specific entity from separate documents. Views help keep the number of HTTP requests low, even though {{site.data.keyword.cloudant_short_notm}} splits up the data for a single-modeled entity.

## How do I avoid conflicts?
{: #how-this-helps-you-avoid-conflicts}
{: faq}

Avoiding conflicted documents helps speed up many operations on your {{site.data.keyword.cloudant_short_notm}} databases. There’s a process that works out the current winning revision used each time 
that the document is read, for example, single document retrievals, calls with `include_docs=true`, view building, and so on.

The winning revision is a particular revision from the document’s overall tree. Recall that 
documents on {{site.data.keyword.cloudant_short_notm}} are in fact trees of revisions. An arbitrary but deterministic algorithm 
selects one of the non-deleted leaves of this tree to return when a request is made for the 
document. Larger trees with a higher branching factor take longer to process than a document 
tree with no or few branches: each branch needs to be followed to see whether it’s a candidate to 
be the winning revision. Potential victors then need to be compared against each other to make 
the final choice.

{{site.data.keyword.cloudant_short_notm}} handles small numbers of branches well. After all, replication relies on the fact that documents can branch to avoid discarding data. However, when you reach pathological levels, particularly if you can't resolve the conflicts, it becomes time-consuming and memory-intensive to walk the document tree.

## How can I build in conflict resolution?
{: #how-build-in-conflict-resolution}
{: faq}

In an eventually consistent system like {{site.data.keyword.cloudant_short_notm}}, conflicts eventually happen. This fact is a price of scalability and data resilience.

It is best to structure your data so that resolving conflicts is quick and does not involve operator assistance. This practice helps your databases to hum along smoothly. The ability to 
automatically resolve conflicts without user involvement significantly 
improves their experience and reduces the support burden on your organization.

How you resolve conflicts is application-specific. See the following tips for more ways to improve the process:

-   Avoid invariants across document fields if possible. Avoiding invariants makes it more likely that a simple
    merge operation, if you take the changed field from each conflicted document revision, is
    suitable. This practice makes simpler and more robust application code.
-   Allow documents to be independent. If you have to retrieve other documents to work out the correct
    resolution, it increases latency in conflict resolution. There's also a chance you get a
    version of the other documents that aren't consistent with the document you're resolving,
    making correct resolution difficult. 

## Why do I need to build in conflict resolution 
{: #why-i-need-to-build-in-conflict-resolution}
{: faq}
 
Heavily conflicted documents exert a heavy toll on the database. Building 
in the capability to resolve conflicts from the beginning is a great help in avoiding 
pathologically conflicted documents.

## Where can I get more information? 
{: #where-more-information}
{: faq}

These tips demonstrate how modeling data affects your application’s 
performance. {{site.data.keyword.cloudant_short_notm}}’s data store has some specific characteristics, both to watch out for 
and to take advantage of, that ensure the database performance scales as your application 
grows. {{site.data.keyword.cloudant_short_notm}} support understands the shift can be confusing, so they are always available to give advice.

For more information, see the
[data model for Foundbite](https://cloudant.com/blog/foundbites-data-model-relational-db-vs-nosql-on-cloudant/){: new_window}{: external},
or the [example from our friends at Twilio](https://www.twilio.com/blog/2013/01/building-a-real-time-sms-voting-app-part-3-scaling-node-js-and-couchdb.html){: new_window}{: external}.

