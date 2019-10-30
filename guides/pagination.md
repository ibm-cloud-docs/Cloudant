---

copyright:
  years: 2019
lastupdated: "2019-10-30"

keywords: _all_docs endpoint, skip, limit, endkey

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

<!-- Acrolinx: 2019 -->

# Pagination 
{: #pagination}

You can use the `skip`/`limit` pattern to [iterate through a result set](/docs/services/Cloudant?topic=cloudant-bookmarks-faq), but it gets progressively slower the larger the value of `skip`. 

Let's see a better way to page through a large document set. 

## Paging with `_all_docs` and views
{: #paging-with_all_docs_views}

If you use the `GET //_all_docs` endpoint to fetch documents in bulk, then you might have come across the `limit` and `skip` parameters. These parameters allow you to define how many documents you would like, and the offset into the range you want to start from. Using this `skip`/`limit` pattern to iterate through a result set works, but it gets progressively slower the larger the value of `skip`. 

## What is the `_all_docs` endpoint?
{: #what-is-the_all_docs_endpoint}

The `GET /<db>/_all_docs` is used to fetch data from an {{site.data.keyword.cloudantfull}} database's _primary index_, that is, the index that keeps each document's `_id` in order. The `_all_docs` endpoint takes a number of optional parameters that configure the range of data requested and whether to return each document's body or not. With no parameters provided, `_all_docs` streams all of a database's documents, returning only the document `_id` and its current `_rev` token.

```javascript
curl "$URL/mydb/_all_docs"
{
  "total_rows": 23515,
  "rows": [
    {
      "id": "aardvark",
      "key": "aardvark",
      "value": {
        "rev": "3-be42a3233372a6a2dff84a65fdd9cbab"
      }
    },
    {
      "id": "alligator",
      "key": "alligator",
      "value": {
        "rev": "1-3256046064953e2f0fdb376211fe78ab"
      }
    }
...
```
{: codeblock}


If you supply `include_docs=true`, then an additional `doc` attribute is added to each "row" in the result set that contains the document body.

## Limit, startkey, and endkey parameters
{: #the-limit-startkey-endkey-parameters}

To access data from `_all_docs` in reasonably sized pages, we need to supply the `limit` parameter to tell {{site.data.keyword.cloudant_short_notm}} how many documents to return:

```http
# get me 10 documents
GET /mydb/_all_docs?limit=10
```
{: codeblock}

We can also limit the range of document `_id`s we want by supplying one or more values to `startkey` or `endkey`.

```sh
# get me 100 documents from _id bear onwards
GET /mydb/_all_docs?limit=100&startkey="bear"

# get me 5 documents between _id bear --> frog
GET /mydb/_all_docs?limit=100&startkey="bear"&endkey="frog"

# get me 5 documents up to _id moose
GET /mydb/_all_docs?limit=100&endkey="moose"
```
{: codeblock}

This practice gives us the ability to define the size of the data set to return and the range of the `_id` field to return, but that isn't quite the same as pagination.

The `startkey`/`endkey` values are in double quotes because they're expected to be JSON-encoded and `JSON.stringify('moose') === "moose"`.
{: note}

## Pagination options
{: #pagination-options}

In order to iterate through a range of documents in an orderly and performant manner, we must devise an algorithm to page through the range. Let's say we need to page through `_all_docs` in blocks of 10. 

We can use the options described in the following sections.

### Option 1 - Fetch one document too many
{: #option-1-fetch-one-doc-too-many}

Instead of fetching ten documents (`limit=10`), fetch eleven (`limit=11`), but hide the eleventh document from your users. The `_id` of the eleventh document becomes the `startkey` of your request for the next page of results.

```http
# first request
GET /mydb/_all_docs?limit=11
{
  "total_rows": 10000,
  "rows": [
    { "id": "aardvark" ....},
    { "id": "alligator" ....},
    { "id": "antelope" ....},
    { "id": "badger" ....},
    { "id": "bear" ....},
    { "id": "cat" ....},
    { "id": "doormouse" ....},
    { "id": "donkey" ....},
    { "id": "elephant" ....},
    { "id": "frog" ....},
    { "id": "gazelle" ...}   // <-- this is the 11th result we use as the startkey of the next request
   ]
}    
```
{: codeblock}

```
# second request
GET /mydb/_all_docs?limit=11&startkey="gazelle"
{
  "total_rows": 10000,
  "rows": [
    { "id": "gazelle" ....},
    { "id": "ibis" ....},
    ...
   ]
} 
```
{: codeblock}

This option works, but we end up fetching n+1 documents when only n are required.

### Option 2 - The \u0000 trick
{: #option-2-the-u0000-trick}

If we are determined to only fetch `n` documents each time, then we need to calculate a value of `startkey`, which means "the next id after the last _id in the result set". For example, if the last document in our first page of results is "frog", what should the `startkey` of the next call to `_all_docs` be? It can't be "frog", otherwise we'd get the same document id again. It turns out that you can append `\u0000` to the end of a key string to indicate the "next key" (`\u0000` is a Unicode null character which becomes `%00` when encoded into a URL). 

```http
# first request
GET /mydb/_all_docs?limit=10
{
  "total_rows": 10000,
  "rows": [
    { "id": "aardvark" ....},
    { "id": "alligator" ....},
    { "id": "antelope" ....},
    { "id": "badger" ....},
    { "id": "bear" ....},
    { "id": "cat" ....},
    { "id": "doormouse" ....},
    { "id": "donkey" ....},
    { "id": "elephant" ....},
    { "id": "frog" ....} // <-- append \u0000 to this to get the startkey of the next request
  ]
}  
```
{: codeblock}

```http
# second request
GET /mydb/_all_docs?limit=10&startkey="frog%00"
{
  "total_rows": 10000,
  "rows": [
    { "id": "gazelle" ....},
    { "id": "ibis" ....},
    ...
   ]
} 
```
{: codeblock}

## Pagination of views
{: #pagination-of-views}

MapReduce views, secondary indexes which are defined by key/value pairs emitted from user-supplied JavaScript functions, can be queried in a similar way to the `_all_docs` endpoint but with the `GET /<db>/_design/<ddoc>/_view/<view>` endpoint instead. You can define your query in the following ways:

- Spool all the data from a view with no parameters.
- Include document bodies by supplying `include_docs=true`.
- Choose the range of keys required by using `startkey`/`endkey`, but in this case, the data type of the keys may not be a string.

Another complication is that unlike the primary index, where every `_id` is unique, there may be many entries in a secondary index with the same key, for example, lots of entries where the key is `"mammal"`. This situation makes pagination by using only `startkey`/`endkey` tricky, so there are other parameters to help: `startkey_docid`/`endkey_docid`. 

```http
# get first page of cities by country
GET /cities/_design/mydesigndoc/_view/bytype?limit=10&reduce=false&startkey="mammal"&endkey="mammal"&include_docs=true

# get next page of cities by country
GET /cities/_design/mydesigndoc/_view/bytype?limit=10&reduce=false&startkey="mammal"&endkey="mammal"&include_docs=true&startkey_docid=horse%00
```
{: codeblock}

In other words, the second request has a value of `startkey_docid` that is the last document id from the previous page of results (horse) plus the magic `\u0000` character (which becomes `horse%00` in the URL).

The `startkey_docid` parameter only works if a `startkey` is supplied and where all index entries share the same key. If they don't share the same key, then pagination can be achieved with manipulation of `startkey`/`endkey` parameters only. Also note that the `startkey_docid` parameter is NOT JSON encoded.
{: note}

## Pagination with bookmarks
{: #pagination-with-bookmarks}

[Cloudant Query](/docs/services/Cloudant?topic=cloudant-query) and [Cloudant Search](/docs/services/Cloudant?topic=cloudant-search) both use _bookmarks_ as the key to unlock the next page of results from a result set. This practice is described in full in the [Bookmarks](/docs/services/Cloudant?topic=cloudant-bookmarks-faq) guide and is easier to manage as there is no key manipulation to formulate the request for the next result set. You simply pass the _bookmark_ received in the first response to the second request. 