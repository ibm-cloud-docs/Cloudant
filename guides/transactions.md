---

copyright:
  years: 2015, 2019
lastupdated: "2019-10-17"

keywords: generate uuid, record payments, add more documents, advantages

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

# Grouping related documents together in {{site.data.keyword.cloudant_short_notm}}
{: grouping-related-documents-together-in-ibm-cloudant}

Traditionally,
e-commerce systems are built with relational databases.
These databases typically use a number of tables joined together to record sales,
customer details,
purchased products,
and delivery tracking information.
Relational databases offer high consistency, which means that application developers can build their applications to a database's strengths. This practice includes using joins between collections,
enumerations to record the state of an object,
and database transactions to guarantee atomic operations.

{{site.data.keyword.cloudantfull}} favors availability over consistency.
It's a high-availability,
fault-tolerant,
distributed database that is eventually consistent, which means the customer's shopping service is always available and scalable enough
to cope with many users who make purchases at the same time.
With that in mind, your application can leverage {{site.data.keyword.cloudant_short_notm}}'s strengths and not treat it like a relational database.

This discussion outlines some of the factors that are 
involved in building an e-commerce system that takes advantage of {{site.data.keyword.cloudant_short_notm}}'s strengths,
by using concepts that are applicable to many other domains,
such as:

-   Using multiple documents to represent the state of a purchase,
    rather than frequently updating a single document.
-   Storing copies of related objects in order instead of joining to another collection.
-   Creating views to collate documents by `order_id` to reflect the current state of a purchase.

For example,
you might create a `purchase` document that includes details such as the items ordered,
customer information,
cost,
and delivery information.

See the following example document that describes a purchase:

```json
{
    "_id": "023f7a21dbe8a4177a2816e4ad1ea27e",
    "type": "purchase",
    "order_id": "320afa89017426b994162ab004ce3383",
    "basket": [
        {
            "product_id": "A56",
            "title": "Adele - 25",
            "category": "Audio CD",
            "price": 8.33,
            "tax": 0.2,
            "quantity": 2
        },
        {
            "product_id": "B32",
            "title": "The Lady In The Van - Alan Bennett",
            "category": "Paperback book",
            "price": 3.49,
            "tax": 0,
            "quantity": 2
        }
    ],
    "account_id": "985522332",
    "delivery": {
        "option": "Next Day",
        "price": 2.99,
        "address": {
            "street": "17 Front Street",
            "town": "Middlemarch",
            "postcode": "W1A 1AA"
        }
    },
    "pretax" : 20.15,
    "tax" : 3.32,
    "total": 26.46
}
```
{: codeblock}

This document provides enough data for a purchase record to render a summary of an order on a web page,
or an email,
without fetching more records.
Notice key details about the order,
in particular:

-   The basket contains reference IDs (`product_id`) to a database of products stored elsewhere.
-   The basket duplicates some of the product data in this record,
    enough to record the state of the items purchased at the point of sale.
-   The document doesn't contain fields that mark the status of the order.
    More documents would be added later to record payments and delivery.
-   The database automatically generates a document `_id` when it inserts the document into the database.
-   A unique identifier (`order_id`) is supplied with each purchase record to reference the order later. 
 
When the customer places an order,
typically at the point when they enter the *checkout* phase on the website,
a purchase order record is created similar to the previous example. 

## Generating your own unique identifiers (UUIDs)
{: #generating-your-own-unique-identifiers-uuids-}

In a relational database,
sequential "auto incrementing" numbers are often used.
While in distributed databases, data is spread around a cluster of servers, and longer UUIDs are used to ensure that documents are stored with their unique ID.

To create a unique identifier for use in your application,
such as an `order_id`,
call the [`GET _uuids` endpoint](/docs/services/Cloudant?topic=cloudant-advanced-api#-get-_uuids-) on the {{site.data.keyword.cloudant_short_notm}} API.
The database generates an identifier for you.
The same endpoint can be used to generate multiple IDs by adding a `count` parameter,
for example, `/_uuids?count=10`.

## Recording payments
{: #recording-payments}

When the customer successfully pays for their items,
more records are added to the database to record the order.

### Example of a payment record

```json
{
    "_id": "bf70c30ea5d8c3cd088fef98ad678e9e",
    "type": "payment",
    "account_id": "985522332",
    "order_id": "320afa89017426b994162ab004ce3383",
    "value": 6.46,
    "method": "credit card",
    "payment_reference": "AB9977G244FF2F667"
}
...
{
    "_id": "12c0ea6cd3d2c6e3b1d34442aea6a2d9",
    "type": "payment",
    "account_id": "985522332",
    "order_id": "320afa89017426b994162ab004ce3383",
    "value": 20.00,
    "method": "voucher",
    "payment_reference": "Q88775662377224"
}
```
{: codeblock}

In the previous example,
the customer paid by supplying a credit card and redeeming a pre-paid voucher.
The total of the two payments added up to the amount of the order.
Each payment was written to {{site.data.keyword.cloudant_short_notm}} as a separate document.

You could see the status of an order by creating a view of everything you know about an `order_id`.
The view would enable a ledger that contains the following information: 

-   Purchase totals as positive numbers.
-   Payments against the account as negative numbers.

A map function could be used to identify the required values.

### Example map function to find purchase total and payment values

```javascript
function (doc) {
    if (doc.type === 'purchase') {
        emit(doc.order_id, doc.total);
    } else {
        if (doc.type === 'payment') {
            emit(doc.order_id, -doc.value);
        }
    }
}
```
{: codeblock}

Use the built-in [`_sum` reducer](/docs/services/Cloudant?topic=cloudant-views-mapreduce#built-in-reduce-functions)
to produce output as a ledger of payment events.

### Example of using the built-in `_sum` reducer, which is queried with `?reduce=false`

```json
{
    "total_rows":3,"offset":0,"rows":[
        {
            "id":"320afa89017426b994162ab004ce3383",
            "key":"985522332",
            "value":26.46
        },
        {
            "id":"320afa89017426b994162ab004ce3383",
            "key":"985522332",
            "value":-20
        },
        {
            "id":"320afa89017426b994162ab004ce3383",
            "key":"985522332",
            "value":-6.46
        }
    ]
}
```
{: codeblock}

Alternatively,
you could produce totals that are grouped by `order_id`.

### Example of totals grouped by `order_id`, with `?group_level=1`

```json
{
    "rows":[
        {
            "key":"320afa89017426b994162ab004ce3383",
            "value":0
        }
    ]
}
```
{: codeblock}

Since the view in previous example returns 0 for the order value,
the result indicates that the order is fully paid.
The reason is that the positive purchase order total cancels the negative payment amounts.
Recording events as separate documents,
that is one for the order and one for each payment,
is good practice in {{site.data.keyword.cloudant_short_notm}}. This practice avoids the possibility of creating conflicts when multiple processes modify the same document simultaneously.

## Adding more documents
{: #adding-more-documents}

You could add other,
separate documents to the database to record the following state changes as the order is provisioned and dispatched:

-   Dispatch notifications.
-   Delivery receipts.
-   Refund records.

As the data arrives,
{{site.data.keyword.cloudant_short_notm}} writes to each document separately.
Therefore,
it's not necessary to modify the core purchase document.

## Advantages of storing purchase orders in {{site.data.keyword.cloudant_short_notm}}
{: #advantages-of-storing-purchase-orders-in-ibm-cloudant}

Using {{site.data.keyword.cloudant_short_notm}} to store purchase order information allows an ordering system to be highly available and scalable. With an ordering system like this one, you can deal with large volumes of data and high rates of concurrent access.
By modeling the data in separate documents that are only written once,
we can ensure documents never become conflicted,
such as during concurrent access to the same document by separate processes.

Furthermore,
documents can contain copies of data that exists in other collections
to represent - rather than rely on - joining data with a foreign key.
For example,
when {{site.data.keyword.cloudant_short_notm}} records the state of a basket at the time of purchase, this record allows an order's state to be fetched by a single call
to an {{site.data.keyword.cloudant_short_notm}}'s view that groups documents related by `order_id`.
