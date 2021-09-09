---

copyright:
  years: 2015, 2021
lastupdated: "2021-09-02"

keywords: tradeoffs in partition tolerance, change approach to data, availability, consistency, theory

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

<!-- Acrolinx: 2020-04-23 -->

# CAP Theorem
{: #cap-theorem}

{{site.data.keyword.cloudantfull}} uses an ["Eventually Consistent"](http://en.wikipedia.org/wiki/Eventual_consistency){: new_window}{: external} model. When you make an update to one part of {{site.data.keyword.cloudant_short_notm}}, the update is eventually seen by other parts of the system.  
{: shortdesc}

To understand how this model works,
and why it's an essential part of using {{site.data.keyword.cloudant_short_notm}},
consider what is meant by Consistency.

Consistency is one of the four ["ACID"](https://en.wikipedia.org/wiki/ACID){: new_window}{: external} properties
that are necessary for transactions within a database to be processed and reported reliably.

Additionally,
consistency is one of the three attributes in the ["CAP"](http://en.wikipedia.org/wiki/CAP_Theorem){: new_window}{: external} theorem.
The attributes are **C**onsistency,
**A**vailability, and **P**artition tolerance. The theorem states that it's not possible for a distributed computer system such as {{site.data.keyword.cloudant_short_notm}}
to guarantee three attributes *simultaneously*:

- Consistency, where all nodes see the same data at the same time.
- Availability, which guarantees that every request receives a response about whether it succeeded or failed.
- Partition tolerance, where the system continues to operate even if any one part of the system is lost or fails.

The impossibility of guaranteeing all three attributes at the same time
means that {{site.data.keyword.cloudant_short_notm}} doesn't guarantee the Consistency attribute.
As the update propagates,
the system is said to "converge" on complete consistency.

Eventual consistency is good for performance.
With a strong consistency model,
a system must wait for any updates to propagate completely and successfully
before a write or update request can be completed.
With an eventually consistent model,
the write or update request can return almost immediately,
while the propagation across the system continues *behind the scenes*.

A database can demonstrate only two of these three attributes for both theoretical and practical reasons.
A database prioritizing consistency and availability is simple:
a single node stores a single copy of your data.
But this model is difficult to scale as you must upgrade the node to get more performance,
rather than use extra nodes.
And,
even a minor system failure can shut down a single-node system,
while any message loss means significant data loss.
To endure,
the system must become more sophisticated.

## Tradeoffs in partition tolerance
{: #tradeoffs-in-partition-tolerance}

A database that prioritizes consistency and partition tolerance commonly employs a primary-secondary setup,
where one node of the many in the system is elected leader.
Only the leader approves data writes,
while all secondary nodes replicate data from the leader to handle reads.
If the leader loses connection to the network,
or can't communicate with many of the system's nodes,
the remainder elects a new leader.
This election process differs between systems,
and might be a source of [significant problems](http://aphyr.com/posts/284-call-me-maybe-mongodb){: new_window}{: external}.

{{site.data.keyword.cloudant_short_notm}} prioritizes availability and partition tolerance by employing a primary-primary setup,
such that every node can accept both writes and reads to its portion of your data.
Multiple nodes include copies of each portion of your data.
Each node copies data with other nodes.
If a node becomes inaccessible,
others can serve in its place while the network heals.
This way,
the system returns your data in a timely manner despite arbitrary node failure,
and maintains [eventual consistency](http://en.wikipedia.org/wiki/Eventual_consistency){: new_window}{: external}.
The tradeoff in deprioritizing absolute consistency is that it takes time for all nodes to see the same data.
As a result,
some responses might include old data while the new data propagates through the system.

## Changing the approach
{: #changing-the-approach}

Maintaining one consistent view of data is logical and easy to understand
because a relational database does this work for you.
The expectation is that web-based services that interact with database systems behave in this way.
But that expectation doesn't mean that they do work this way.
Consistency isn't a given,
and it takes a little work to change the approach.

In fact,
consistency isn't necessarily essential for many enterprise cloud services.
Large,
heavily used systems bring with them a high probability that a portion of the system might fail.
A database that is engineered around the need to prioritize availability and eventual consistency
is better suited to keeping your application online.
The consistency of application data can be addressed after the fact.

## Application availability versus consistency in the enterprise
{: #application-availability-versus-consistency-in-the-enterprise}

A look at popular web-based services shows that people already expect high availability,
and happily trade this availability for eventually consistent data,
often without realizing they're doing so.

Many applications mislead users for the sake of availability.
Consider ATMs:
inconsistent banking data is why it's still possible to overdraft money without realizing it.
It's unrealistic to present a consistent view of your account balance throughout the entire banking system
if every node in the network must halt and record this figure before operations continue.
A better choice is to make the system highly available.

The banking industry figured it out back in the 1980s,
but many IT organizations are still worried about sacrificing consistency for the sake of availability.
Think about the number of support calls placed when your sales team can't access their CRM app.
Now consider whether they would even notice when it takes a few seconds for a database update
to propagate throughout the application.

Availability trumps consistency more than you might expect.
Online shopping cart systems,
HTTP caches,
and DNS are a few more examples.
Organizations must consider the cost of downtime such as user frustration,
productivity loss,
and missed opportunities.

## From theory to implementation
{: #from-theory-to-implementation}

Addressing high availability is vital for cloud applications.
Otherwise,
global database consistency stays a major bottleneck as you scale.
Highly available applications need to maintain constant contact with their data, even if that data isn't up to date.
That's the concept of eventual consistency,
and it's nothing to be scared of. Sometimes, with a large scale, it's better to serve answers that aren't perfectly correct than to not serve them at all.

Database systems hide the complexities of availability versus consistency in different ways,
but they always exist.
{{site.data.keyword.cloudant_short_notm}}, CouchDB, and other NoSQL database teams believe that the best policy requires developers to address these complexities early in the design process.
By doing the hard work up front,
you reduce surprises because applications are ready to scale from day one.
