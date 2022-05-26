---

copyright:
  years: 2022
lastupdated: "2022-06-01"

keywords: changes feed, filtered replication, using changes feed

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

# Using the {{site.data.keyword.cloudant_short_notm}} changes feed FAQ
{: #faq-using-changes-feed}
{: faq}
{: support}

An {{site.data.keyword.cloudant_short_notm}} database's changes feed's primary use-case is to power the replication of data from a source to a target database. The {{site.data.keyword.cloudant_short_notm}} replicator is built to handle the changes feed and performs the necessary checks to ensure data is copied accurately to its destination. 

{{site.data.keyword.cloudant_short_notm}} has a raw [changes feed API](https://cloud.ibm.com/apidocs/cloudant#getchanges-changes){: external} that can be used to consume a single database's changes but it must be used with care. 

The `_changes` API endpoint can be used in several ways and can output data in various formats. But here we focus on best practice and how to avoid some pitfalls when you develop against the `_changes` API.

## How do I consume the changes feed?
{: #how-consume-changes-feed}
{: faq}

Given a single database `orders`, I can ask the database for a list of changes, in this case, limiting the result set to five changes with `?limit=5`:

```http
GET /orders/_changes?limit=5
{
  "results": [
    {
      "seq": "1-g1AAAAB5eJzLYWBg",
      "id": "00002Sc12XI8HD0YIBJ92n9ozC0Z7TaO",
      "changes": [
        {
          "rev": "1-3ef45fdbb0a5245634dc31be69db35f7"
        }
      ]
    },
    ....
  ],
  "last_seq": "5-g1AAAAB5eJzLYWBg"
}
```
{: codeblock}

The API call returns the following changes:

- `results` - an array of changes.
- `last_seq` - a token that can be supplied to the changes endpoint in a subsequent API call to get the next batch of changes.

See how to fetch the next batch of changes in the following example:

```http
GET /orders/_changes?limit=5&since=5-g1AAAAB5eJzLYWBg
{
  "results": [ ...],
  "last_seq": "10-g1AAAACbeJzLY"
}
```
{: codeblock}

The `since` parameter is used to define where in the changes feed you want to start from:

- `since=0` - the beginning of the changes feed.
- `since=now` - the end of the changes feed.
- `since=<a last seq token>` - from a known place in the changes feed.

At face value, it would seem like following the changes feed would be as simple as chaining `_changes` API calls together, passing the `last_seq` from one `changes feed` response into the next request's `since` parameter. But some subtleties to the changes feed need further discussion.

## Why does the changes feed deliver each change at least once?
{: #changes-feed-at-least-once}
{: faq}

The {{site.data.keyword.cloudant_short_notm}} Standard changes feed promises to return each document _at least once_, which isn't the same as promising to return each document _only once_. Put another way, it is possible for a consumer of the `changes feed` to see the same change again, or indeed a set of changes repeated.

A consumer of the changes feed must treat the changes _idempotently_. In practice, you must remember whether a change was already dealt with before you trigger an action from a change. A naive changes feed consumer might send a message to a smartphone on every change received. But a user might receive duplicate text messages if a change is not treated idempotently when replayed changes occur.

Usually these "rewinds" of the changes feed are short, replaying only a handful of changes. But in some cases, a request might see a response with thousands of changes replayed - potentially all of the changes from the beginning of time. The potential for `rewinds` makes the `changes feed` unsuitable for an application that expects queue-like behavior.

To reiterate, {{site.data.keyword.cloudant_short_notm}}'s changes feed promises to deliver a document _at least once_ in a changes feed, and gives no guarantees about repeated values across multiple requests.

## Does the changes feed operate in "real time"?
{: #changes-feed-real-time}
{: faq}

The changes feed doesn't guarantee how quickly an incoming change appears to a client that consumes the changes feed. Applications must not be developed with the assumption that data inserts, updates, and deletes are immediately propagated to a changes reader.

## Why don't all individual document changes appear in the changes feed?
{: #document-changes-appear-changes-feed}
{: faq}

If a document is updated several times in between changes feed calls, then the changes feed might reflect only the latest of these changes. The client does not receive every change to every document.

The {{site.data.keyword.cloudant_short_notm}} changes feed isn't a _transaction log_ that contains every event that happened in time order.

## Can I use a filtered changes feed for operational queries?
{: #use-filtered-replication}
{: faq}

Filtering the changes feed, and by extension, performing filtered replication has its uses:

- Copying data from source to target but ignoring deleted documents.
- Copying data but without index definitions (design documents).

This [blog post](https://blog.cloudant.com/2019/12/13/Filtered-Replication.html){: external} describes how supplying a `selector` during replication makes easy work of these use cases.

The changes feed with an accompanying `selector` parameter is _not_ the way to extract slices of data from the database on a routine basis. It must not be used as a means of performing operational queries against a database. Filtered changes are slow (the filter is applied to every changed document in turn, without the help of an index). This process is much slower than creating a secondary index (such as a MapReduce view) and querying that view.

## Why doesn't the changes feed guarantee time-ordering?
{: #time-ordered-changes-no-guarantee}
{: faq}

If the use case is based on the following statement, then this result cannot be achieved with the {{site.data.keyword.cloudant_short_notm}} changes feed. 

`"Fetch me every document that has changed since a known date, in the order they were written."`

The {{site.data.keyword.cloudant_short_notm}} database does not record the time as each document change was written. The changes feed makes no guarantees on the ordering of the changes in the feed - they are not guaranteed to be in the order they were sent to the database.

However, you can achieve this use case by storing the date of change in the document body:

```json
{
  "_id": "2657",
  "type": "order",
  "customer": "bob@aol.com",
  "order_date": "2022-01-05T10:40:00",
  "status": "dispatched",
  "last_edit_date": "2022-01-14T19:17:20"
}
```
{: codeblock}

And you can create a MapReduce view with `last_edit_date` as the key:

```javascript
function(doc) {
  emit(doc.last_edit_date, null)
}
```
{: codeblock}

This view can be queried to return any documents that are modified on or after a supplied date and time:

`/orders/_design/query/_view/by_last_edit?startkey="2022-01-13T00:00:00"`

This technique produces a time-ordered set of results with no repeated values in a performant and repeatable fashion. The consumer of this data need _not_ manage the data idempotently, making for a simpler development process.

## What is the {{site.data.keyword.cloudant_short_notm}} changes feed good for now?
{: #changes-feed-good-for}
{: faq}

The {{site.data.keyword.cloudant_short_notm}} changes feed is good for the following tasks:

- Powering {{site.data.keyword.cloudant_short_notm}} replication, optionally with a selector to filter some changes.
- Clients consuming the changes feed in batches but dealing with each change idempotently while not being concerned with sort order and expecting to see some changes more than once.

The {{site.data.keyword.cloudant_short_notm}} changes feed is not good for the following components:

- A message queue. For more information, see [IBM Messages for RabbitMQ](https://www.ibm.com/cloud/messages-for-rabbitmq){: external} for managing queues.
- A message broker. For more information, see [IBM Event Streams](https://www.ibm.com/cloud/event-streams){: external} for handling scalable, time-ordered streams of events.
- A real-time publish and subscribe system. For more information, see [IBM Databases for Redis](https://www.ibm.com/uk-en/cloud/databases-for-redis){: external} for handling publish and subscribe topics.
- A transaction log. Some databases store each change in a transaction log, but {{site.data.keyword.cloudant_short_notm}}'s distributed and eventually consistent nature means that no definitive time-ordered transaction log exists.
- A querying mechanism. For more information, see [MapReduce Views](https://cloud.ibm.com/docs/Cloudant?topic=Cloudant-creating-views-mapreduce) for creating views of your data that is ordered by a key of your choice.
