---

copyright:
  years: 2015, 2019
lastupdated: "2019-07-31"

keywords: multiple views, changes, versioned design documents, move and switch, the stale parameter

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

<!-- Acrolinx: 2017-05-10 -->

# Design document management
{: #design-document-management}

*Article contributed by Glynn Bird, Developer Advocate at IBM Cloudant,
[glynn@cloudant.com ![External link icon](../images/launch-glyph.svg "External link icon")](mailto:glynn@cloudant.com){: new_window}*

{{site.data.keyword.cloudantfull}}'s scalable JSON data store has several querying mechanisms,
all of which generate indices that are created and maintained separately to the core data.
Indexing is not performed immediately when a document is saved.
Instead,
it is scheduled to happen later giving a faster,
non-blocking write throughput.

-   MapReduce views are indexes into the dataset
    with key value pairs stored in a BTree for efficient retrieval by key or range of keys
-   Search Indexes are constructed using Apache Lucene to allow free-text search,
    faceting and complex ad-hoc queries

{{site.data.keyword.cloudant_short_notm}}'s [search indexes](/docs/services/Cloudant?topic=cloudant-search#search) and [MapReduce views](/docs/services/Cloudant?topic=cloudant-views-mapreduce#views-mapreduce)
are configured by adding design documents to a database.
Design documents are JSON documents which contain the instructions on how the view or index is to be built.
Let's take a simple example.
Assume we have a simple collection of data documents,
similar to the following example.

## Example of a simple data document

```json
{
    "_id": "23966717-5A6F-E581-AF79-BB55D6BBB613",
    "_rev": "1-96daf2e7c7c0c277d0a63c49b57919bc",
    "doc_name": "Markdown Reference",
    "body": "Lorem Ipsum",
    "ts": 1422358827
}
```
{: codeblock}

Each data document includes a name,
a body,
and a timestamp.
We want to create a [MapReduce view](/docs/services/Cloudant?topic=cloudant-views-mapreduce#views-mapreduce) to sort our documents by timestamp.

We can do this by creating a Map function,
similar to the following example.

## Example map function returning a document's timestamp field, if present

```javascript
function(doc) {
    if (doc.ts) {
        emit( doc.ts, null);
    }
}
```
{: codeblock}

The function emits the document's timestamp so that we can use it as the key to the index;
as we are not interested in the value in the index,
`null` is emitted.
The effect is to provide a time-ordered index into the document set.

We are going to call this view `by_ts` and put it into a design document called `fetch`,
like the following example:

## Example design document that defines a view using a map function

```json
{
    "_id": "_design/fetch",
    "views": {
      "by_ts": {
        "map": "function(doc) {
          if (doc.ts) {
            emit( doc.ts, null);
          }
        }"
      }
    },
    "language": "javascript"
}
```
{: codeblock}

The result is that our map code has been turned into a JSON-compatible string,
and included in a design document.

Once the design document is saved,
{{site.data.keyword.cloudant_short_notm}} triggers server-side processes to build the `fetch/by_ts` view.
It does this by iterating over every document in the database,
and sending each one to the Javascript map function.
The function returns the emitted key/value pair.
As the iteration continues,
each key/value pair is stored in a B-Tree index.
After the index is built for the first time,
subsequent re-indexing is performed only against new and updated documents.
Deleted documents are de-indexed.
This time-saving process is known as *incremental MapReduce*,
as shown in the following diagram:

![Illustration of Incremental MapReduce](../images/DesDocMan00.png)

It's worth remembering at this point that:

-   The construction of an index happens asynchronously.
    {{site.data.keyword.cloudant_short_notm}} confirms that our design document has been saved,
    but to check on the progress on the construction of our index,
    we have to poll {{site.data.keyword.cloudant_short_notm}}'s [`_active_tasks`](/docs/services/Cloudant?topic=cloudant-active-tasks#active-tasks) endpoint.
-   The more data we have,
    the longer it takes before the index is ready.
-   While the initial index build is in progress,
    *any queries made against that index will block*.
-   Querying a view triggers the 'mapping' of any documents that haven't yet been incrementally indexed.
    This ensures we get an up-to-date view of the data.
    See the following [`stale` parameter](#the-stale-parameter) discussion,
    for exceptions to this rule.

## Multiple views in the same design document
{: #multiple-views-in-the-same-design-document}

If we define several views in the same design document,
then they are built efficiently at the same time.
Each document is only read once,
and passed through each view's Map function.
The downside of this approach is that modifying a design document
*invalidates all of the existing MapReduce views* defined in that document,
even if some of the views remain unaltered. 

If MapReduce views must be altered independently of each other,
place their definitions in separate design documents. 

This behavior does not apply to Lucene search indexes. They can be altered within the same design document without invalidating other unchanged indexes in the same document.
{: note}

![Illustration of design document version change](../images/DesDocMan02.png)

## Managing changes to a design document
{: #managing-changes-to-a-design-document}

Imagine at some point in the future we decide to change the design of our view.
Now,
instead of returning the actual timestamp result,
we are only interested in the count of how many documents match the criteria.
To achieve this,
the map function remains the same,
but we now use a *reduce* of `_count`.
The effect is that our design document looks like the following example.

## Example design document that uses a reduce function

```json
{
    "_id": "_design/fetch",
    "_rev": "2-a2324c9e74a76d2a16179c56f5315dba",
    "views": {
        "by_ts": {
            "map": "function(doc) {
                if (doc.ts) {
                  emit( doc.ts, null);
                }
            }
        }",
        "reduce": "_count"
    },
    "language": "javascript"
}
```
{: codeblock}

When this design document is saved,
{{site.data.keyword.cloudant_short_notm}} completely invalidates the old index and begins building the new index from scratch,
iterating over every document in turn.
As with the original build,
the time taken depends on how many documents are in the database,
and blocks incoming queries on that view until it is complete.

But there's a problem...

If we have an application that is accessing this view *in real-time*,
then we might well encounter a deployment dilemma:

-   Version 1 of our code,
    which relied on the original design document,
    might no longer work because the old view has been invalidated.
-   Version 2 of our code,
    which uses the new design document,
    can't be released immediately,
    because the new view will not have finished building yet,
    especially if there are many documents in the database.
-   A more subtle problem affecting our code is that versions 1 and 2 expect different result data from the view:
    version 1 expects a list of matching documents,
    while version 2 expects a 'reduced' count of results.

## Coordinating changes to design documents
{: #coordinating-changes-to-design-documents}

There are two ways of dealing with this change control problem.

### Versioned design documents
{: #versioned-design-documents}

One solution is to use versioned design document names:

-   Our code is initially written to use a view called `_design/fetchv1`.
-   When we come to release a new version,
    we create a new view called `_design/fetchv2`,
    and query the view to ensure that it begins to build.
-   We poll `_active_tasks` until the work of building the new index is complete.
-   We are now ready to release the code that depends on the second view.
-   Delete `_design/fetchv1` when we are sure it is no longer needed.

Using versioned design documents is a simple way to manage change control in your design documents,
as long as you remember to remove the older versions at a later date!

### <q>Move and switch</q> design documents
{: #move-and-switch-design-documents}

Another approach relies on the fact that {{site.data.keyword.cloudant_short_notm}} recognises when it has two identical design documents,
and does not waste time and resources rebuilding views it already has.
In other words,
if we take our design document `_design/fetch` and create an exact duplicate `_design/fetch_OLD`,
then both endpoints would work interchangeably without triggering any reindexing.

The procedure to switch to the new view is this:

1.  Create a duplicate copy of the design document that we want to change,
    for example by adding `_OLD` to its name:
    `_design/fetch_OLD`.
2.  Put the new or <q>incoming</q> design document into the database,
    using a name with the suffix `_NEW`: `_design/fetch_NEW`.
3.  Query the `fetch_NEW` view,
    to ensure that it starts to build.
4.  Poll the `_active_tasks` endpoint and wait until the index has finished building.
5.  Put a duplicate copy of the new design document into `_design/fetch`.
6.  Delete design document `_design/fetch_NEW`.
7.  Delete design document `_design/fetch_OLD`.

## <q>Move and switch</q> tooling
{: #move-and-switch-tooling}

There is a command-line Node.js script that automates the <q>Move and switch</q> procedure,
called `couchmigrate`.
It can be installed as follows.

### Command to install the Node.js `couchmigrate` script

```sh
npm install -g couchmigrate
```
{: codeblock}

To use the `couchmigrate` script,
first define the URL of the CouchDB/{{site.data.keyword.cloudant_short_notm}} instance by setting an environment variable called `COUCH_URL`.

### Defining the URL of the an {{site.data.keyword.cloudant_short_notm}} instance

```sh
export COUCH_URL=http://127.0.0.1:5984
```
{: codeblock}

The URL can be HTTP or HTTPS,
and can include authentication credentials.

### Defining the URL of the {{site.data.keyword.cloudant_short_notm}} instance with authentication credentials

```sh
export COUCH_URL="https://$ACCOUNT:$PASSWORD@$HOST.cloudant.com"
```
{: codeblock}

Assuming we have a design document in JSON format,
stored in a file,
we can then run the migrate command.

In this example,
`db` specifies the name of the database to change,
and `dd` specifies the path to our design document file.

#### Running the `couchmigrate` command

```sh
couchmigrate --db mydb --dd /path/to/my/dd.json
```
{: pre}

The script coordinates the <q>Move and switch</q> procedure,
waiting until the view is built before returning.
If the incoming design document is the same as the incumbent one,
then the script returns almost immediately.

The source code for the script is available here:
[https://github.com/glynnbird/couchmigrate ![External link icon](../images/launch-glyph.svg "External link icon")](https://github.com/glynnbird/couchmigrate){: new_window}.

## The '`stale`' parameter
{: #the-stale-parameter}

If an index is complete,
but new records are added into the database,
then the index is scheduled to be updated in the background.
This is the state of the database shown in the following diagram:

![Illustration of index scheduled for updating](../images/DesDocMan01.png)

When querying the view, we have three choices:

-   The default behaviour is to ensure that the index is up-to-date,
    with the latest documents in the database,
    before returning the answer.
    When we query the view,
    {{site.data.keyword.cloudant_short_notm}} first indexes the 250 new documents,
    and then returns the answer.
-   An alternative is adding the `stale=ok` parameter to the API call.
    The parameter means <q>return me the data that is already indexed.
    I don't care about the latest updates.</q>
    In other words,
    when you query the view with `stale=ok`,
    {{site.data.keyword.cloudant_short_notm}} returns the answer immediately,
    without any additional reindexing.
-   A second alternative is to add the `stale=update_after` parameter to the API call.
    The parameter means <q>return me the data that is already indexed, 
    *and* then reindex any new documents.</q>
    In other words,
    when you query the view with `stale=update_after`,
    {{site.data.keyword.cloudant_short_notm}} returns the answer immediately,
    and then schedules a background task to index the new data.

Adding `stale=ok` or `stale=update_after` can be a good way getting answers more quickly from a view,
but at the expense of freshness. 

The default behaviour distributes load evenly across nodes in the {{site.data.keyword.cloudant_short_notm}} cluster. If you use the alternative `stale=ok` or `stale=update_after` options, this might favor a subset of cluster nodes, in order to return consistent results from across the eventually consistent set. This means that the `stale` parameter isn't a perfect solution for all use-cases. However, it can be useful for providing timely responses on fast-changing data sets if your application is happy to accept stale results. If the rate of change of your data is small, adding `stale=ok` or `stale=update_after` will not bring a performance benefit, and might unevenly distribute the load on larger clusters.
{: note}

Avoid using `stale=ok` or `stale=update_after` whenever possible.
The reason is that the default behavior provides the freshest data,
and distributes data within the cluster.
If it is possible to make a client app aware that there is a large data processing task is in progress
(during a regular bulk data update, for example),
then the app could switch to `stale=ok` temporarily during these times,
then revert to the default behaviour afterwards.

The `stale` option is still available, but the more useful options `stable` and `update` are available and must be used instead. For more information, see [Accessing a stale view](/docs/services/Cloudant?topic=cloudant-using-views#view-freshness).
{: note}
