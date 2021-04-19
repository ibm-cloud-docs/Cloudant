---

copyright:
  years: 2020, 2021
lastupdated: "2021-04-19"

keywords: resolve conflict, ignore conflict, identify conflict, eventual consistency

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

<!-- Acrolinx: 2021-04-19 -->

# Document versioning and conflicts FAQ
{: #faq-document-versioning-conflicts}
{: faq}
{: support}

When you use distributed databases, copies of your data might be stored in multiple locations. Keeping this data in sync is important. However, your work environment might prevent your users from updating documents with their changes immediately, or even replicating to the database. 

As a result, the copies of a document might have different updates. "Conflicts" occur because {{site.data.keyword.cloudantfull}} can't determine which copy is the correct one.
{: shortdesc}

{{site.data.keyword.cloudant_short_notm}} uses multi-version concurrency control (MVCC) to ensure that all nodes in each database cluster include only the newest version of a document.

## What is eventual consistency?
{: #what-eventual-consistency}
{: faq}

{{site.data.keyword.cloudant_short_notm}} databases are [eventually consistent](/docs/services/Cloudant?topic=Cloudant-cap-theorem#cap-theorem), which means {{site.data.keyword.cloudant_short_notm}} must ensure that no differences exist between nodes. These inconsistencies can happen when out-of-date documents are synchronized.

It's important for {{site.data.keyword.cloudant_short_notm}} databases to have concurrent read and write access. MVCC enables that capability. MVCC is a form of [optimistic concurrency control](http://en.wikipedia.org/wiki/Optimistic_concurrency_control){: new_window}{: external} that makes read and write operations on {{site.data.keyword.cloudant_short_notm}} databases faster because a database lock isn't necessary for read and write operations.  At the same time, MVCC enables synchronization between {{site.data.keyword.cloudant_short_notm}} database nodes.

## How do I know whether there's a conflict?
{: #how-know-conflict}
{: faq}

You don't know. Sometimes you request a document that has a conflict. At those times, {{site.data.keyword.cloudant_short_notm}} returns the document normally, as though no conflict exists. However, the version that is returned isn't necessarily the most current version. Instead, the version is selected based on an internal algorithm that considers multiple factors. You must not assume that when documents are returned they're always the most current.

## How do I identify a document with a conflict?
{: #how-identify-document-conflict}
{: faq}

If a conflict with a document exists and you try to update it, {{site.data.keyword.cloudant_short_notm}} returns a 409 response. If you try to update a document while you're offline, {{site.data.keyword.cloudant_short_notm}} can't check for potential conflicts, and you don't receive a 409 response. 

When this situation happens, it's best to check for document conflicts when you're back online. If you need to find document conflicts, use the following example map function:

```sh
function (doc) {
  if (doc._conflicts) {
    emit(null, [doc._rev].concat(doc._conflicts));
  }
}
```
{: codeblock}

If you want to find conflicts within multiple documents in a database, write a [view](/docs/services/Cloudant?topic=Cloudant-views-mapreduce#views-mapreduce).

## What happens if I ignore conflicts? 
{: #what-if-ignore-conflicts}
{: faq}

If you don't check for conflicts, or don't fix them, your {{site.data.keyword.cloudant_short_notm}} database has the following problems:

- Document inconsistency increases because conflicting documents continue to multiply. 
- Database size increases because documents with conflicts must be kept until the conflict is resolved. 
- Performance degrades because it takes more work for {{site.data.keyword.cloudant_short_notm}} to respond to each request since it has to go through all the conflicted documents to find the "best possible" version. 

## How do I resolve conflicts?
{: #how-resolve-conflicts}
{: faq}

After you find a conflict, follow these four steps to resolve it.

1.  [Get](/docs/services/Cloudant?topic=Cloudant-document-versioning-and-mvcc#get-conflicting-revisions-mvcc) the conflicting revisions.
2.  [Merge](/docs/services/Cloudant?topic=Cloudant-document-versioning-and-mvcc#merge-the-changes-mvcc) them into your application or ask the owner what to do.
3.  [Upload](/docs/services/Cloudant?topic=Cloudant-document-versioning-and-mvcc#upload-the-new-revision-mvcc) the new revision.
4.  [Delete](/docs/services/Cloudant?topic=Cloudant-document-versioning-and-mvcc#delete-old-revisions-mvcc) old revisions.