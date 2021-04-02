---

copyright:
  years: 2020, 2021
lastupdated: "2021-03-25"

keywords: _all_docs endpoint, page_size, bookmarks, query, search, paging, mapreduce views

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

<!-- Acrolinx: 2020-12-23 -->


# Pagination
{: #pagination-te}

The content described here applies only to {{site.data.keyword.cloudantfull}} on Transaction Engine.

## Paging with `_all_docs` and views
{: #paging-with_all_docs_views-te}

If you use the `GET /$DATABASE/all_docs` endpoint to fetch documents in bulk, and if the result has more than 2000 rows, you get the following error message:

```json
{
    "error": "query_rows_count_exceeded",
    "reason": "The number of returned rows exceeds the limit (2000). Set `page_size` <= 2000."
}
```
{: codeblock}

By setting `page_size`, you enable the new pagination API.

## What is the `_all_docs` endpoint?
{: #what-is-the_all_docs_endpoint-te}

The `GET /$DATABASE/_all_docs` endpoint is used to fetch data from an {{site.data.keyword.cloudant_short_notm}}
database's _primary index_, that is, the index that keeps each document's `_id` in order.
The `_all_docs` endpoint takes a number of optional parameters that configure the
range of data that is requested and whether to return each document's body or not.
With no parameters provided, `_all_docs` streams all of a database's documents,
returning only the document `_id` and its current `_rev` token.

 ```sh
 curl "https://$ACCOUNT.cloudant.com/$DATABASE/_all_docs"
 ```
{: codeblock}

```json
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
  ]
}
```
{: codeblock}

If you supply `include_docs=true`, then another `doc` attribute is added to each "row" in the result set that includes the document body.

## The `page_size` parameter
{: #the-page_size-parameter-te}

To access data from `_all_docs` in reasonably sized pages, you must supply the 
`page_size` parameter to tell {{site.data.keyword.cloudant_short_notm}} how
many documents to return:

```http
GET /$DATABASE/_all_docs?page_size=10  HTTP/1.1
```
{: codeblock}

The maximum value of the `page_size` parameter is 2000.

## How to use pagination?
{: pagination-how-te}

To iterate through a range of documents, you must devise an algorithm to page
through the range. For example, you want to page through `_all_docs` in blocks
of 10.

See the following example that uses HTTP to get to the first page:

```http
GET /$DATABASE/_all_docs?page_size=10  HTTP/1.1
```
{: codeblock}

See the following example that uses the command line to get to the first page:

```sh
curl "https://$ACCOUNT.cloudant.com/$DATABASE/_all_docs?page_size=10"
```
{: codeblock}

The response is a JSON object that could contain the `next` token.

```json
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
    { "id": "frog" ....}
   ],
   "next": "g1AAAAA-eJzLYWBgYMpgSmHgKy5JLCrJTq2MT8lPzkzJBYqzmxiYWJiZGYGkOWDSyBJZAPCBD58"
}
```
{: codeblock}

The response includes an array of `docs`, and a `next` bookmark, which you use
to paginate through the results in the next request. When you need page two of
the results, you make another request that passes {{site.data.keyword.cloudant_short_notm}} the bookmark from the
first response.

See the following example that uses HTTP to get to the page by using a bookmark:

```http
GET /$DATABASE/_all_docs?bookmark=g1AAAAA-eJzLYWBgYMpgSmHgKy5JLCrJTq2MT8lPzkzJBYqzmxiYWJiZGYGkOWDSyBJZAPCBD58  HTTP/1.1
```
{: codeblock}

See the following example that uses the command line to get to the page by using a bookmark:

```sh
curl "https://$ACCOUNT.cloudant.com/$DATABASE/_all_docs?bookmark=g1AAAAA-eJzLYWBgYMpgSmHgKy5JLCrJTq2MT8lPzkzJBYqzmxiYWJiZGYGkOWDSyBJZAPCBD58"
```
{: codeblock}

The response is a JSON object that might contain the `next`/`prev` tokens:

```json
{
  "total_rows": 10000,
  "rows": [
    { "id": "gazelle" ....},
    { "id": "ibis" ....},
    ...
   ],
   "next": "c2BBBBB-eweLDsBgZMpgSmdffwlejfncwe4w5efv9993edsd3453fdfV3453edfgdfg3453",
   "prev": "d232DSD-wer34rfsdf345dfg45tgr54tgbrt3lk2jlk3j49348u958tngkedn934th94243"
}
```
{: codeblock}

Review the following notes:

- The `prev` bookmark can be used to return to the previous page.
- The `prev` and `next` bookmarks are optional. If no more pages remain, they are omitted. 
- It is an error to provide any arguments other than `bookmark` to subsequent requests.
- The `limit` parameter restricts the total number of returned documents.

### Using multiple queries with pagination
{: #multiple-queries-with-pagination}

See the following example that uses HTTP to run multiple queries:

```http
POST /$DATABASE/_all_docs/queries?page_size=2  HTTP/1.1
Host: $ACCOUNT.cloudant.com
Content-Type: application/json
Authorization: ...
```
{: codeblock}

See the following example that uses the command line to run multiple queries:

```sh
curl -X POST \
    -H "Content-type: application/json" \
    "https://$ACCOUNT.cloudant.com/$DATABASE/_all_docs/queries?page_size=2" \
    -d @queries.json
```
{: codeblock}

See the following example JSON document that describes multiple queries:

```json
{
    "queries": [
        {
            "keys": [
                "meatballs",
                "spaghetti"
            ]
        },
        {
            "limit": 3,
            "skip": 2
        }
    ]
}
```
{: codeblock}

See the following example response for multiple queries:

```json
{
    "results" : [
        {
            "rows": [
                {
                    "id": "SpaghettiWithMeatballs",
                    "key": "meatballs",
                    "value": 1
                },
                {
                    "id": "SpaghettiWithMeatballs",
                    "key": "spaghetti",
                    "value": 1
                }
            ],
            "next": "e34562tgkdjgalsfjslkjldf9e4dfvjgedsljglsdjklgjlkfdsjkgjdslkfjgkldjl99e9",
            "total_rows": 3
        },
        {
            "offset" : 2,
            "rows" : [
                {
                    "id" : "Adukiandorangecasserole-microwave",
                    "key" : "Aduki and orange casserole - microwave",
                    "value" : [
                        null,
                        "Aduki and orange casserole - microwave"
                    ]
                },
                {
                    "id" : "Aioli-garlicmayonnaise",
                    "key" : "Aioli - garlic mayonnaise",
                    "value" : [
                        null,
                        "Aioli - garlic mayonnaise"
                    ]
                }
            ],
            "total_rows" : 2667,
            "next": "flewjglqhgfkjwhrhekh348884rfdkhgkdshgkdhslkhglsdjgkldkljglasdklgjsljlgk"
        }
    ]
}
```
{: codeblock}

The `next` tokens could be used in `GET /$DATABASE/_all_docs?bookmark=...` to retrieve the next page of each query.

Review the following notes:

- The `page_size` key is forbidden in the JSON body of the request.

### Posting to `_all_docs` with pagination
{: #posting-to-all-docs-with-pagination}

See the following example that uses HTTP to run multiple queries:

```http
POST /$DATABASE/_all_docs?page_size=2  HTTP/1.1
Host: $ACCOUNT.cloudant.com
Content-Type: application/json
Authorization: ...
```
{: codeblock}

See the following example that uses the command line to run multiple queries:

```sh
curl -X POST \
    -H "Content-type: application/json" \
    "https://$ACCOUNT.cloudant.com/$DATABASE/_all_docs?page_size=2" \
    -d @request.json
```
{: codeblock}

See the following example JSON document that describes the `_all_docs` request:

```json
{
    "page_size": 3,
    "startkey": "b",
    "endkey": "e"
}
```
{: codeblock}

The response is a JSON object, which can contain the `next` token:

```json
{
  "total_rows": 6,
  "rows": [
    { "id": "badger" ....},
    { "id": "bear" ....},
    { "id": "cat" ....}
   ],
   "next": "g1AAAAA-eJzLYWBgYMpgSmHgKy5JLCrJTq2MT8lPzkzJBYqzmxiYWJiZGYGkOWDSyBJZAPCBD58"
}
```
{: codeblock}

The `next` token can be used in `GET /$DATABASE/_all_docs?bookmark=...` to retrieve the next page of the query.

Review the following notes:

- The `keys` parameter is not compatible with the `page_size` parameter. If you want to use `keys`, you must make sure that you are not requesting more than 2000 keys at once.
