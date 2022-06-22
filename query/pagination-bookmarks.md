---

copyright:
  years: 2019, 2022
lastupdated: "2022-06-23"

keywords: _all_docs endpoint, skip, limit, endkey, query, search, paging, mapreduce views

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# Pagination and bookmarks
{: #pagination-and-bookmarks}

Bookmarks help release the next page of results from a result set. While with pagination, you iterate through a range of documents in an efficient manner.
{: shortdesc} 

You can use the `skip`/`limit` pattern to [iterate through a result set](/docs/Cloudant?topic=Cloudant-using-views), but it gets progressively slower the larger the value of `skip`.

The pagination approach changed for {{site.data.keyword.cloudantfull}} on Transaction Engine. For more information, see how {{site.data.keyword.cloudant_short_notm}} on Transaction Engine uses [pagination and bookmarks](/docs/Cloudant?topic=Cloudant-pagination-te).
{: important}

[{{site.data.keyword.cloudant_short_notm}} Query](/apidocs/cloudant#postfind){: external} and [{{site.data.keyword.cloudant_short_notm}} Search](/apidocs/cloudant#getsearchinfo){: external} both use bookmarks as the key to unlock the next page of results from a result set. This practice is described in full in a later section that is called [Bookmarks](#bookmarks). It's easier to manage since no key manipulation is required to formulate the request for the next result set. You pass the bookmark that was received in the first response to the second request.

Now, you can see a better way to page through a large document set. 

## Paging with `_all_docs` and views
{: #paging-with_all_docs_views}

If you use the `GET /$DATABASE/_all_docs` endpoint to fetch documents in bulk, then you might see the `limit` and `skip` parameters. By using these parameters, you can define how many documents you would like, and the offset into the range you want to start from. Using the `skip`/`limit` pattern to iterate through results works, but it gets progressively slower the larger the value of `skip`. 

## What is the `_all_docs` endpoint?
{: #what-is-the_all_docs_endpoint}

The `GET /$DATABASE/_all_docs` is used to fetch data from an {{site.data.keyword.cloudant_short_notm}} database's _primary index_, that is, the index that keeps each document's `_id` in order. The `_all_docs` endpoint takes a number of optional parameters that configure the range of data that is requested and whether to return each document's body or not. With no parameters provided, `_all_docs` streams all of a database's documents, returning only the document `_id` and its current `_rev` token.

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


If you supply `include_docs=true`, then another `doc` attribute is added to each "row" in the result set that includes the document body.

## The `limit`, `startkey`, and `endkey` parameters
{: #the-limit-startkey-endkey-parameters}

To access data from `_all_docs` in reasonably sized pages, you must supply the `limit` parameter to tell {{site.data.keyword.cloudant_short_notm}} how many documents to return:

```http
# get me 10 documents
GET /mydb/_all_docs?limit=10
```
{: codeblock}

You can also limit the range of document `_id`s that you want by supplying one or more values to `startkey` or `endkey`.

```sh
# get me 100 documents from _id bear onwards
GET /mydb/_all_docs?limit=100&startkey="bear"

# get me 5 documents between _id bear --> frog
GET /mydb/_all_docs?limit=100&startkey="bear"&endkey="frog"

# get me 5 documents up to _id moose
GET /mydb/_all_docs?limit=100&endkey="moose"
```
{: codeblock}

This practice means you define the size of the data set and the range of the `_id` field to return, but that isn't quite the same as pagination.

The `startkey`/`endkey` values are in double quotation marks because they're expected to be JSON-encoded and `JSON.stringify('moose') === "moose"`.
{: note}

## Pagination options
{: #pagination-options}

You must devise an algorithm to page through the range of documents in an orderly and performant manner. For example, you must page through `_all_docs` in blocks of 10. 

You can use the options that are described in the following sections.

### Option 1 - Fetch one document too many
{: #option-1-fetch-one-doc-too-many}

Instead of fetching 10 documents (`limit=10`), fetch 11 (`limit=11`), but hide the 11th document from your users. The `_id` of the 11th document becomes the `startkey` of your request for the next page of results.

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
    { "id": "gazelle" ...}   // <-- This is the 11th result we use as the startkey of the next request
   ]
}    
```
{: codeblock}

```http
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

This option works, but you end up fetching n+1 documents when only n are required.

### Option 2 - The \u0000 trick
{: #option-2-the-u0000-trick}

If you're determined to fetch only `n` documents each time, then you need to calculate a value of `startkey`, which means `the next ID after the last _id in the result set`. For example, if the last document in the first page of results is "frog", what must the `startkey` of the next call to `_all_docs` be? It can't be "frog", otherwise you get the same document ID again. It turns out that you can append `\u0000` to the end of a key string to indicate the "next key" (`\u0000` is a Unicode null character, which becomes `%00` when encoded into a URL). 

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

MapReduce views, secondary indexes, can be queried in a similar way to the `_all_docs` endpoint, but with the `GET /$DATABASE/_design/$DDOC/_view/$VIEW` endpoint instead. MapReduce views are defined by `key-value` pairs that are produced from user-supplied JavaScript functions. You can define your query in the following ways:

- Spool all the data from a view with no parameters.
- Include document bodies by supplying `include_docs=true`.
- Choose the range of keys that are required by using `startkey`/`endkey`, but in this case, the data type of the keys might not be a string.

Another complication is that unlike the primary index, where every `_id` is unique, the secondary index might have entries with the same key. For example, lots of entries that include the key `"mammal"`. This situation makes pagination by using only `startkey`/`endkey` tricky, so you can use other parameters to help: `startkey_docid`/`endkey_docid`. 

```http
# get first page of cities by country
GET /cities/_design/mydesigndoc/_view/bytype?limit=10&reduce=false&startkey="mammal"&endkey="mammal"&include_docs=true

# get next page of cities by country
GET /cities/_design/mydesigndoc/_view/bytype?limit=10&reduce=false&startkey="mammal"&endkey="mammal"&include_docs=true&startkey_docid=horse%00
```
{: codeblock}

In other words, the second request has a value of `startkey_docid` that is the last document ID from the previous page of results (horse) plus the magic `\u0000` character (which becomes `horse%00` in the URL).

The `startkey_docid` parameter works only if a `startkey` is supplied and where all index entries share the same key. If they don't share the same key, then pagination can be achieved with manipulation of `startkey`/`endkey` parameters only. Also, the `startkey_docid` parameter is not JSON encoded.
{: note}

## Bookmarks
{: #bookmarks}

 Imagine you're creating a web application that shows a set of search results, whether they be books, actors, or products in your store. As the user scrolls through the search results, another page of matches is appended at the end. This behavior is known as an "infinite scroll" design pattern. It allows the user to endlessly scroll through a large data set with ease, while they fetch only smaller batches of data from the database each time.

### How do {{site.data.keyword.cloudant_short_notm}} bookmarks work? 
{: #how-do-cloudant-bookmarks-work}

It's this sort of access pattern that {{site.data.keyword.cloudant_short_notm}} *bookmarks* are built for. Here's how it works:

- Your application performs a search on an {{site.data.keyword.cloudant_short_notm}} database, for example, `find me the first 10 cities where the country is 'US'`.
- {{site.data.keyword.cloudant_short_notm}} provides an array of ten {{site.data.keyword.cloudant_short_notm}} documents and a *bookmark*, an opaque key that represents a pointer to the next documents in the result set.
- When the next set of results is required, the search is repeated. However, the query is sent, as well as the bookmark from the first response, to {{site.data.keyword.cloudant_short_notm}} in the request.
- {{site.data.keyword.cloudant_short_notm}} replies with the second set of documents and another bookmark, which can be used to get a third page of results.
- Repeat! 

Now you can see how to do that with code.

### How can I use {{site.data.keyword.cloudant_short_notm}} Query to search?
{: #use-cloudant-query-search}

First, you search for all the cities in the US. You're using [{{site.data.keyword.cloudant_short_notm}} Query](/docs/Cloudant?topic=Cloudant-query), so the operation is specified as a block of JSON:

```js
{
  "selector": {
    "country": "US"
  },
  "limit": 5
}
```

By using the [`/db/_find`](/apidocs/cloudant#postfind){: external} API endpoint, the results are passed to {{site.data.keyword.cloudant_short_notm}}. 

```sh
curl -X POST \
      -H 'Content-type: application/json' \
      -d '{"selector":{"country":"US"},"limit":5}' \
      "$URL/cities/_find"
{
  "docs":[
    {"_id":"10104153","_rev":"1-32aab6258c65c5fc5af044a153f4b994","name":"Silver Lake","latitude":34.08668,"longitude":-118.27023,"country":"US","population":32890,"timezone":"America/Los_Angeles"},
    {"_id":"10104154","_rev":"1-125f589bf4e39d8e119b4b7b5b18caf6","name":"Echo Park","latitude":34.07808,"longitude":-118.26066,"country":"US","population":43832,"timezone":"America/Los_Angeles"},
    {"_id":"4046704","_rev":"1-2e4b7820872f108c077dab73614067da","name":"Fort Hunt","latitude":38.73289,"longitude":-77.05803,"country":"US","population":16045,"timezone":"America/New_York"},
    {"_id":"4048023","_rev":"1-744baaba02218fd84b350e8982c0b783","name":"Bessemer","latitude":33.40178,"longitude":-86.95444,"country":"US","population":27456,"timezone":"America/Chicago"},
    {"_id":"4048662","_rev":"1-e95c97013ece566b37583e451c1864ee","name":"Paducah","latitude":37.08339,"longitude":-88.60005,"country":"US","population":25024,"timezone":"America/Chicago"}
  ],
  "bookmark": "g1AAAAA-eJzLYWBgYMpgSmHgKy5JLCrJTq2MT8lPzkzJBYqzmxiYWJiZGYGkOWDSyBJZAPCBD58"
}
```

The response includes an array of `docs`, and a `bookmark`, which you use to paginate through the results in the next request. When you need page two of the results, you repeat the query by passing {{site.data.keyword.cloudant_short_notm}} the bookmark from the first response.

```sh
curl -X POST \
      -H 'Content-type: application/json' \
      -d '{"selector":{"country":"US"},"limit":5,"bookmark":"g1AAAAA-eJzLYWBgYMpgSmHgKy5JLCrJTq2MT8lPzkzJBYqzmxiYWJiZGYGkOWDSyBJZAPCBD58"}' \
      "$URL/cities/_find"
      
{
  "docs":[
    {"_id":"4049979","_rev":"1-1fa2591477c774a07c230571568aeb66","name":"Birmingham","latitude":33.52066,"longitude":-86.80249,"country":"US","population":212237,"timezone":"America/Chicago"},
    {"_id":"4054378","_rev":"1-a750085697685e7bc0e49d103d2de59d","name":"Center Point","latitude":33.64566,"longitude":-86.6836,"country":"US","population":16921,"timezone":"America/Chicago"},
    {"_id":"4058219","_rev":"1-9b4eb183c9cdf57c19be660ec600330c","name":"Daphne","latitude":30.60353,"longitude":-87.9036,"country":"US","population":21570,"timezone":"America/Chicago"},
    {"_id":"4058553","_rev":"1-56100f7e7742028facfcc50ab6b07a04","name":"Decatur","latitude":34.60593,"longitude":-86.98334,"country":"US","population":55683,"timezone":"America/Chicago"},
    {"_id":"4059102","_rev":"1-612ae37d982dc71eeecf332c1e1c16aa","name":"Dothan","latitude":31.22323,"longitude":-85.39049,"country":"US","population":65496,"timezone":"America/Chicago"}
  ],
  "bookmark": "g1AAAAA-eJzLYWBgYMpgSmHgKy5JLCrJTq2MT8lPzkzJBYqzmxiYWhoaGIGkOWDSyBJZAO9qD40",
  "warning": "no matching index found, create an index to optimize query time"
}
```

This time, you get the next five cities and a new bookmark ready for the next request.

It's the same story when you use one of the {{site.data.keyword.cloudant_short_notm}} libraries to do this task. First, make the initial request:

```js
  const q = {
    selector: {
      country: 'US'
    },
    limit: 5
  }
  const data = await db.find(q)
  // { docs: [ ... ], bookmark: '...' }
```

You feed the bookmark from the first response into the second request for the next page of results:

```js
  const q = {
    selector: {
      country: 'US'
    },
    limit: 5,
    bookmark: 'g1AAAAA-eJzLYWBgYMpgSmHgKy5JLCrJTq2MT8lPzkzJBYqzmxiYWJiZGYGkOWDSyBJZAPCBD58'
  }
  const data = await db.find(q)
  // { docs: [ ... ], bookmark: '...' }
```

### How does {{site.data.keyword.cloudant_short_notm}} Search work?
{: #how-cloudant-search-works}

Pagination works in the same way for [{{site.data.keyword.cloudant_short_notm}} Search](/docs/Cloudant?topic=Cloudant-cloudant-search) queries. Pass the `bookmark` parameter in the URL for GET requests or in the JSON body for POSTed requests. See the following example: 

```sh
curl "$URL/cities/_search/search/_search/freetext?q=country:US&bookmark=g1AAAAA-eJzLYW"
```

See the documentation about [query parameters](/docs/Cloudant?topic=Cloudant-cloudant-search#query-parameters-search) for further details.

### Do MapReduce views accept bookmarks?
{: #mapreduce-views-accept-bookmarks}

No. MapReduce views don't accept a `bookmark`. Use the [skip and limit](/docs/Cloudant?topic=Cloudant-using-views) to page through results.

### Can I jump straight to page X of the results?
{: #jump-page-x-results}

No. Bookmarks make sense only to {{site.data.keyword.cloudant_short_notm}} if they come from the previous page of results. If you need page 3 of the results, you must fetch pages 1 and 2 first.

### What happens if I supply an incorrect bookmark?
{: #what-happens-if-i-supply-incorrect-bookmark}

{{site.data.keyword.cloudant_short_notm}} responds with an `HTTP 400 Bad Request { error: 'invalid_bookmark'}` response if you supply an invalid bookmark. Remember, you don't need a bookmark for the first search in a sequence.

### What happens if I change the query?
{: #what-happens-if-change-query}

You must keep the same query (the same selector in {{site.data.keyword.cloudant_short_notm}} Query or the same "q" in {{site.data.keyword.cloudant_short_notm}} Search) to get the next page of results. If you change the query, you might get an empty result set in reply.
