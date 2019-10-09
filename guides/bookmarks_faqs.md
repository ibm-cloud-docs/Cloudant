---

copyright:
  years: 2019
lastupdated: "2019-10-16"

keywords: query, search, paging, mapreduce views

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
{:faq: data-hd-content-type='faq'}

<!-- Acrolinx: 2017-05-10 -->

# Bookmarks
{: #bookmarks-faq}

Imagine you are creating a web application showing a set of search results, whether they be books, actors, or products in your store. As the user scrolls to the bottom of the search results, another page of matches is appended to the bottom. This behavior is known as an "infinite scroll" design pattern and allows the user to endlessly scroll through a large data set with ease, while only fetching smaller batches of data from the database each time.

## How do {{site.data.keyword.cloudant_short_notm}} bookmarks work? 
{: #how-do-cloudant-bookmarks-work}

It is this sort of access pattern that {{site.data.keyword.cloudantfull}} *bookmarks* are built for. Here's how it works:

- Your application performs a search on an {{site.data.keyword.cloudant_short_notm}} database, for example, "find me the first ten cities where the country is 'US'".
- {{site.data.keyword.cloudant_short_notm}} provides an array of ten {{site.data.keyword.cloudant_short_notm}} documents and a *bookmark*, an opaque key that represents a pointer to the next documents in the result set.
- When the next set of results is required, the search is repeated, but in addition to the query, the bookmark from the first response is also sent to {{site.data.keyword.cloudant_short_notm}} in the request.
- {{site.data.keyword.cloudant_short_notm}} replies with the second set of documents and another bookmark, which can be used to get a third page of results.
- Repeat! 

Let's see how we can do that with code.

## How can I use {{site.data.keyword.cloudant_short_notm}} Query to search?
{: #use-cloudant-query-search}

First let's perform a search for all the cities in the USA. We're using [{{site.data.keyword.cloudant_short_notm}} Query](https://cloud.ibm.com/docs/services/Cloudant?topic=cloudant-query), so the operation is specified as a block of JSON:

```js
{
  "selector": {
    "country": "US"
  },
  "limit": 5
}
```

and passed to {{site.data.keyword.cloudant_short_notm}} by using the [/db/_find](https://cloud.ibm.com/docs/services/Cloudant?topic=cloudant-query#selector-syntax) API endpoint: 

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

Notice as well an array of `docs`, {{site.data.keyword.cloudant_short_notm}} also returns a `bookmark`, which we save for the next request. When we need page two of the results, we repeat the query, passing {{site.data.keyword.cloudant_short_notm}} the bookmark from the first response:

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

This time, we get the next five cities and a new bookmark ready for the next request.

It's the same story when using one of the {{site.data.keyword.cloudant_short_notm}} libraries to do this task. First, make the initial request:

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

We feed the bookmark from the first response into the second request for the next page of results:

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

## How does {{site.data.keyword.cloudant_short_notm}} Search work?
{: #how-cloudant-search-works}

Pagination works in the same way for [{{site.data.keyword.cloudant_short_notm}} Search](https://cloud.ibm.com/docs/services/Cloudant?topic=cloudant-search) queries. Pass the `bookmark` parameter in the URL for GET requests or in the JSON body for POSTed requests. See the following example: 

```sh
curl "$URL/cities/_search/search/_search/freetext?q=country:US&bookmark=g1AAAAA-eJzLYW"
```

See [the documentation](https://cloud.ibm.com/docs/services/Cloudant?topic=cloudant-search#query-parameters-search) for further details.

## Do MapReduce views accept bookmarks?
{: #mapreduce-views-accept-bookmarks}

No. MapReduce views do not accept a `bookmark`. Use the [skip and limit](https://cloud.ibm.com/docs/services/Cloudant?topic=cloudant-using-views) to page through results.

## Can I jump straight to page X of the results?
{: #jump-page-x-results}

No. Bookmarks only make sense to {{site.data.keyword.cloudant_short_notm}} if they come from the previous page of results. If you need page 3 of the results, you need to fetch pages 1 and 2 first.

## What happens if I supply an incorrect bookmark?
{: #what-happens-if-i-supply-incorrect-bookmark}

{{site.data.keyword.cloudant_short_notm}} responds with an `HTTP 400 Bad Request { error: 'invalid_bookmark'}` response if you supply an invalid bookmark. Remember, you don't need a bookmark for the first search in a sequence.

## What happens if I change the query?
{: #what-happens-if-change-query}

You must keep the same query (the same selector in {{site.data.keyword.cloudant_short_notm}} Query or the same "q" in {{site.data.keyword.cloudant_short_notm}} Search) to get the next page of results. If you change the query, you may get an empty result set in reply.
