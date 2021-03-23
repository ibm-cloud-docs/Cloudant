---

copyright:
  years: 2015, 2021
lastupdated: "2021-03-17"

keywords: videos

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
{:script: data-hd-video='script'}
{:video: .video}

<!-- Acrolinx: 2020-10-13 -->

# Learning Center
{: #learning-center}

The {{site.data.keyword.cloudantfull}} Learning Center offers videos to help you learn to use {{site.data.keyword.cloudant_short_notm}}. The videos start with the basics of using {{site.data.keyword.cloudant_short_notm}} and walk through document structure, the API, indexing and querying, and include an `Under the Hood` topic that highlights the architecture powering the service.
{: shortdesc}

You can use the [playlist](https://youtube.com/embed/playlist?list=PLzpeuWUENMK3F93hGaS4ezGmlX4Bipt4S) to go through the courses, or navigate directly to the topic of your choosing from the following list:

## Introduction to {{site.data.keyword.cloudant_short_notm}} video
{: #cloudant-course-intro-video}

Learn about the {{site.data.keyword.cloudant_short_notm}} 18-part video series that provides an overview of the {{site.data.keyword.cloudant_short_notm}} database-as-a-service. 

![Introduction to {{site.data.keyword.cloudant_short_notm}}](https://youtube.com/embed/P9dFZaKAhIo){: video output="iframe" data-script="#cloudant-course-intro-video-script" id="Introduction to IBM Cloudant video" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen}

### Introduction to {{site.data.keyword.cloudant_short_notm}} video script
{: #cloudant-course-intro-video-script}
{: notoc}

Welcome to the Introduction to Cloudant course, an 18-part video series that gives you an overview of the IBM Cloudant databases-as-a-service.

This is part 1 - `What is Cloudant?`

Cloudant is a database, run as a service in the IBM Cloud. Its job is to store your application's data securely and allow you to retrieve it quickly and efficiently. Cloudant's key features are that it is:

A database - It stores and retrieves data.
More specifically, it is a JSON document store. JSON comes from JavaScript and represents simple objects in a universal file format. The `document` is the unit of storage in Cloudant. Documents are added/updated/deleted in their entirety.
It has an HTTP API. Any Cloudant operation can be achieved using HTTP. HTTP is the protocol that powers the World Wide Web and Cloudant is a database built for the web.
Most databases are hidden in a private network, inaccessible but to a handful of machines but the Cloudant service sits (mainly) on the public internet where it can be accessed by anyone with an internet connection (and permission to do so!).

Cloudant wasn't written entirely by IBM. It is based on Apache CouchDB, an open source project run by the Apache Foundation. Cloudant employs a number of CouchDB contributors but by the rules of Apache, they cannot monopolize its development.

Much of what you see in this course is applicable to Apache CouchDB as it is to Cloudant. Their APIs are 99% the same - I'll point out where they diverge.

Cloudant can be thought of as CouchDB run `as-a-service`. A Cloudant service is easily deployed and is managed by IBM engineers 24-7. There's no software to install, no servers to manage, no configuration to understand. The user need not be a CouchDB expert to use and manage it.

Cloudant being built on truly open source foundations means that you can be sure that your data layer is not locked in to a particular platform, cloud, or vendor and Cloudant can be used in concert with CouchDB to create hybrid applications that share data through replication, as we'll see.

Later on in the course we'll look `under the hood` to see how Cloudant works, but initially we'll treat Cloudant as a `black box`.

To summarize, Cloudant is based on Apache CouchDB, an open source project. It stores JSON documents. It is accessed with an HTTP API and can therefore be accessed by any device on the internet that speaks HTTP: application code, web browser, IoT device, or mobile phone. Cloudant is a highly-available managed service able to continue to operate with multiple hardware failures.

That's the end of this part. The next part is called The Document.

## The Document video
{: #the-document-video}

Learn about {{site.data.keyword.cloudant_short_notm}} databases and documents work. 

![The Document](https://youtube.com/embed/zlfPQ5cl2Zo){: video output="iframe" data-script="#the-document-video-script" id="The Document video" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen}

### The Document video script
{: #the-document-video-script}
{: notoc}

Welcome to the Introduction to Cloudant course, an 18-part video series that gives you an overview of the IBM Cloudant databases-as-a-service.

This is part 2 - `The Cloudant Document?`

We've seen that Cloudant is a JSON document store. Let's find out what that means in practice and how that compares to other types of database.

Most databases store their data in collections called tables, where each unit of data is a row, each with identical, fixed columns. The schema of each table is predefined: a list of columns with their name, date type, value constraints, and relations to other tables carefully defined. Each new record forms a row in a table.

Cloudant is quite different!

A Cloudant service has collections called databases (instead of tables) each of which containing any number of documents.

The example on this slide shows the same data expressed in a traditional tabular database and how the same data would be stored in Cloudant as JSON documents.

So if you come from a relational database background: tables are `databases` in Cloudant, and rows are `documents`.

A Cloudant document must be a JSON object, starting and ending with curly braces and containing a number of key/value attributes.

JSON objects must be less that 1 megabyte in size and contain any number of strings, numbers, booleans, arrays, and objects. The nesting of objects within objects can continue to any depth.

The keys used can be as brief or verbose as you like.

Here are some simple example documents showing how each data type is used.

- The first example shows a person object, storing strings, booleans, and an array of tags.
- The second example shows very brief attribute names to save on storage and represents a web event such as a click a website.
- The last example shows how the document may itself contain subobjects.

A note on dates. JSON has no native Date type so dates are usually stored in 30-October-2018 or similar formats - we will come back to dates later.

Now for your first practical exercise. Visit www.ibm.com/cloud and register an account with the IBM Cloud, if you don't have one already.

Once registered, you may click `services`, search for the `Cloudant` database and provision a new service.

The Cloudant `Lite` service provides a free plan to allow users to try Cloudant in a limited capacity while in development. Its bigger brother, the `Standard Plan`, is paid-for service where you specify the number of reads/writes/and queries per second your application and that capacity is reserved for you. You pay for the capacity you provision and your data storage usage.

The Lite plan operates in a similar way, but only has a small provisioned capacity and a fixed storage size, but is fine for `kicking the tires`.

Cloudant is often referred to as a `schemaless` database - but we have to be careful how we define that term.

It's true to say that there's no need to define your schema (field names, types, constraints, and relationships) ahead of time in a Cloudant database - you may simply write a JSON document of your own design to a database.

This flexibility is well liked by developers because they can design their data in their code, turn it into JSON and write it to the database.

It's still important to think about the `shape of your data`, especially in terms of how you are going to query and index it, as we'll see later.

Data design is still required, but strictly speaking that database doesn't need to know about your schema.

Let's say we want to create a database of US presidents. We can simply devise our `model` of the data in our app, turn it into JSON and write it to the database. In this case, we are using a common CouchDB convention: the `type` field indicating the data type of the document.

If at a future date we decide we want to add additional data to our `schema`, we can simply write a new object to the database with no complaints from Cloudant. We could decide to add the `address` object only to:

- Documents that are created from now on.
- Only documents that we have addresses for.

In other words, documents of the same type can have fields present or missing.

You database's schema can evolve over time to match your application's needs and you don't (necessarily) need to tell the database about the schema change - just write new documents in the new format.

We can even store multiple document `types` in the same database. In this case, people/books/places reside in the same database. We know which is which because of the `type` field (this is a convention and not something that means anything to Cloudant).

An alternative to this is to have three databases people/books/places and keep each data type in its own database. Both approaches are fine: you would choose to have multiple types together in the same database if need to perform queries across types or if you need to replicate all data types together, otherwise the separate databases approach may be better.

To summarize, although Cloudant is `schemaless`, this doesn't absolve you of the need to do detailed data design to get the best performance.

Here are some tips, especially relevant if you have some relational database experience.

- Avoid thinking in joins - a Cloudant document must contain everything you need about that object so that it can be retrieved in one API call.
- Normalization goes out of the window in JSON store, some repeated values can be tolerated if it makes data retrieval more efficient.
- Although we have a 1 MB limit on document size, your documents must be much smaller than that - a few KB is typical.
- If your application can embrace a `write only` design pattern, where data is only ever added to a database, then it can make your life easier. You must definitely avoid patterns that rely on updating the same document over and over in small time window.

That's the end of this part. The next part is called `The Document ID`.

## The `_id` video
{: #the-_id-video}

Learn how `_ids` work in {{site.data.keyword.cloudant_short_notm}}, how they are different from relational databases, and how you can define your own `_id`. 

![The `_id`](https://youtube.com/embed/y_L8r_knq8U){: video output="iframe" data-script="#the-_id-video-script" id="The _id video" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen}

### The `_id` video script
{: #the-_id-video-script}
{: notoc}

Welcome to the Introduction to Cloudant course, an 18-part video series that gives you an overview of the IBM Cloudant databases-as-a-service.

This is part 3 - `The Document `_id``

We've seen how data is stored in Cloudant documents with flexibility on how your application stores JSON objects in Cloudant databases. There are, however, a few hard and fast rules.

One rule is that every document must have a unique identifier called `_id` which is a string. No two documents in the same database can have the same `_id` field. In other databases, you specify which column is the unique identifier, but in Cloudant it's always `_id` and can't be changed.

Also, unlike relational databases, Cloudant does not have `auto incrementing IDs` that is, an ID field that starts at 1 and increments for each document added.

Cloudant's `_id` field is either:

A 32 character string generated by Cloudant - the ID is a meaningless sequence of numbers and letters that are guaranteed to be unique. Or,
a string defined by you (if you know something unique about your data).

Here are some examples of supplying your own document `_id`:

Using it to store something that you know is unique i.e. the email address of a user. Your registration mechanism can enforce a one-user-per-email address policy.
Some users choose to encode the document type in the `_id` e.g. `user:56`, `book:55`.
The last example shows using a 32-digit string (generated in your app) that is designed to sort in approximate date/time order, making it easy to retrieve the latest documents from the database, without a secondary index.

Cloudant takes your document `_ids` and stores them in an index (like the contents page of book). This primary index is in `_id` order and is used to allow Cloudant to retrieve documents by their `_id` - thus behaving like a key/value store.

By careful design of your `_id` field, you can make use to the primary index to keep data that makes sense to be together in the primary index, making it quicker to retrieve that data later. We've already seen that using time-sortable `_ids` means that data can be retrieved in approximate date/time order.

We'll see this later when it comes to retrieving ranges of document IDs.

In conclusion, each document must have a `_id` field that is unique in the database. It can be auto-generated by Cloudant, or can be supplied by your application, in which case you must take responsibility of the uniqueness of the `_id` field.

The `_id` field is the basis of the database's primary index, which, as we'll see, can be used for key/value lookups and range queries.

That's the end of this part. The next part is called `The rev token`.

## The rev token video
{: #the-rev-token-video}

Learn how {{site.data.keyword.cloudant_short_notm}} creates a revision token when you add, edit, or delete a document. 

![The rev token](https://youtube.com/embed/T14voAppUl0){: video output="iframe" data-script="#the-rev-token-video-script" id="The rev token video" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen}

### The rev token video script
{: #the-rev-token-video-script}
{: notoc}

Welcome to the Introduction to Cloudant course, an 18-part video series that gives you an overview of the IBM Cloudant databases-as-a-service.

This is part 4 - `The rev token`

The second fundamental Cloudant rule is that each document revision is given its own unique revision token. Let's find out what it means.

You never need to generate a revision token - one is created for you when you add, update, or delete a document using the API.

A revision token consists of two parts:

A number 1, 2, 3, etc., and
a cryptographic hash of the document's body.
(For the uninitiated, a hash is a digital `fingerprint` of some data. If the data changes, the fingerprint changes. No two fingerprints are the same i.e. no two documents with different content would have the same hash.)

You can see from the example on the right that our document has a revision token (the key starting _rev) that starts with a `1` followed by a dash. That tells us that this is the first revision of the document. The digits starting 04aa8... are the cryptographic hash of the document.

If we follow the lifecycle of a document, it starts with a `revision 1`. When it is modified later, it gets a `revision 2` and so on. With each incrementing revision number, the hash also changes because the content of the document is being modified too.

One thing to note:

It is possible for a document to have more than one revision with the same number. i.e. two `revision 3s`. This is called a `conflict` and is `normal` in some circumstances. We'll see why later in the course, but for now we can assume that the revision number will increment with each update to a document.

Let's follow the lifecycle of an example Cloudant document:

When a new document is created (whether with an auto-generated `_id` or user-supplied `_id`), it is allocated a `revision 1`. You will be sent the token in the response to your API request. Normally you can discard the rev (UNLESS you intend to modify the document in the near future, as we'll see).

When we modify a document whose _rev is at `revision 1` (notice we've changed the name in the document from Liz to Elizabeth), the document is saved and a `revision 2` token is generated and returned to you in the API response.

All simple enough so far.

If we delete the document later, A `revision 3` is created.

Unlike almost any other database, Cloudant keeps a reference for deleted documents. A deletion is just another document revision - a special one where _deleted: true replaces the document body.

In fact, the document's recent revision history (the tree of revisions - remember we could have more than one of each revision number) - is kept.

Note:

You can't use Cloudant's revision tree as a version control system to retrieve or `rollback` to an older revision. Once a revision is superseded, the document body of the older revision is deleted and its disk space recovered in a process called `compaction`. Compaction occurs automatically in Cloudant, so it's not safe to assume that old revisions will be available to be retrieved.

To summarize, revision tokens are generated by the database on add/edit/delete. (you never need to create your own revision tokens).
Generally, the revision number increases by one each time, but more complex scenarios are possible (we'll cover this later).
Older document bodies are discarded or compacted (don't rely on being able to get them back).
All Cloudant operations that change a document need the document's `_id` AND its _rev (this is unlike most databases).

That's the end of this part. The next part is called `Authentication`.

## Authentication video
{: #authentication-video}

Learn how Legacy authentication and IAM authentication work. You can also learn how {{site.data.keyword.cloudant_short_notm}} generates credentials, and how the three official {{site.data.keyword.cloudant_short_notm}} libraries handle authentication. 

![Authentication](https://youtube.com/embed/7TF2NnjZc78){: video output="iframe" data-script="#authentication-video-script" id="Authentication video" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen}

### Authentication video script
{: #authentication-video-script}
{: script}
{: notoc}

Welcome to the Introduction to Cloudant course, an 18-part video series that gives you an overview of the IBM Cloudant databases-as-a-service.

This is part 5 - `Authentication`

We said earlier that Cloudant is a web-based service on the public internet. How can we be sure that our data is safe and that only our code can access it? This is where authentication comes in.

Cloudant supports two types of authentication.

Legacy authentication is where a username or api-key and password are supplied with each request using HTTP Basic Authentication or exchanged for cookie, using a one-off session API call. A session cookie is cycled regularly, so your client code needs to capture the refreshed cookie and store it for subsequent request.
IAM authentication is the access management system that underpins all of the IBM Cloud services. To authenticate with IAM, you need an IAM API key and the host name of the Cloudant service. The API key is exchanged for a bearer token using the IAM API and the bearer token is passed to Cloudant with each request. The bearer token only lasts for an hour, so must be renewed with the IAM service periodically.
When a Cloudant service is provisioned, you can generate IAM only credentials or both IAM and Legacy credentials - you decide.

How are credentials generated?

In the IBM Cloud dashboard under your Cloudant service, in the `Service Credentials` tab, click the `New Credential` button and a JSON document containing the IAM key and the basic auth username/password and the Cloudant hostname is created.

Here's an example set of credentials:

For IAM you need the first two bits: apikey and host
for Legacy/Basic-Auth you need the URL (which contains the username and password embedded in the URL)

There are three official Cloudant libraries: Java, Node.js, and Python.

All three handle authentication automatically. You don't need to worry about how it exchanges the API key for a session token or how IAM authentication works - it is handled for you.

When we look at the API from the  IDs, we'll be using Basic Auth as a convenience, but it's recommended you use IAM authentication if possible as it allows better integration with the IBM Cloud platform and finer-grained permissions.

Time for our next practical exercise.

Log into the IBM Cloud and locate the IBM Cloudant Lite service we created last time. In the `Service Credentials` tab, click the `New Credential` button to generate a set of `IAM+Legacy` credentials. Make a note of the JSON it returns - we'll need that for the next exercise.

Then, visit the URL specified in the credentials JSON - what do you see?

To summarize, credentials are generated from the IBM Cloud dashboard. You can have IAM or both IAM + legacy credentials. Both authentication methods involve exchanging your credentials for a time-limited token (authentication) - the token is then updated periodically as you use the service. The official libraries handle all of this for you.

That's the end of this part. The next part is called `The dashboard`.

## The Dashboard video
{: #the-dashboard-video}

Learn about the {{site.data.keyword.cloudant_short_notm}} Dashboard and what it has to offer, as well as an introduction into how to use it. 

![The Dashboard](https://youtube.com/embed/Lbs7I6fI2O8){: video output="iframe" data-script="#the-dashboard-video-script" id="The Dashboard video" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen}

### The Dashboard video script
{: #the-dashboard-video-script}
{: notoc}

Welcome to the Introduction to Cloudant course, an 18-part video series that gives you an overview of the IBM Cloudant databases-as-a-service.

This is part 6 - `The Dashboard`.

The easiest way to get started creating databases and adding documents is to use the Cloudant Dashboard.

The Cloudant Dashboard is a web-app built into the service. It allows basic data manipulation to be performed through a graphical user interface: Databases can be created and deleted, documents added, updated and deleted and replication jobs managed. It is also a handy place to perform one-off queries and to set up secondary indexes (as we'll see later).

It also contains some simple monitoring tools that visualize request rates.

It's important to note that any task that is achievable in the Cloudant Dashboard is also possible with the Cloudant HTTP API - indeed, the Cloudant Dashboard is simply making standard API calls itself.

To open a Cloudant service's Dashboard, log in to the IBM Cloud, find your Cloudant service and click Launch Cloudant Dashboard button. A new window will open, logging you into your Cloudant dashboard.

If you leave the dashboard window unattended for a length of time, you will find yourself logged out (for security purposes) and will have to click Launch again.

The dashboard has a number of tabs. Its default tab, `Databases` allows you to list the databases you have created in pages of 20. Each database is shown with the number of documents it is storing and how much disk space is being used. Click a database name to examine its contents.

To create a database, click the Create database button and supply the name of the database to create.

We now have a new empty database. The database's documents would be listed here in ID order, but as this is a new database, there are none. To add a new document, click Create Document.

The Cloudant dashboard has created a template document for you with a pre-generated `_id`. Complete the rest of the attributes yourself to complete the JSON document and click `Create Document` to save.

Now it's time for another practical exercise. Create a new database called `books` and in that database create three or more documents with fields: title, author, date, publisher, ISBN - each representing a book of your choice.

Once created, edit one of the documents, modifying the publication date.

Then, delete one of the documents.

To summarize, the Cloudant Dashboard is a web app built into the Cloudant service and is part of the CouchDB open source offering.
It is used to manage databases, documents, indexes, queries and replication jobs.
It can also be used to monitor service throughput.
The Dashboard is simply an API client - anything that can be achieved with the dashboard can scripted by you using the HTTP API.

That's the end of this part. The next part is called `HTTP API Basics`.

## HTTP API Basics video
{: #http-api-basics-video}

Learn how to use the command line to make HTTP requests and to add, edit, and delete documents. 

![HTTP API Basics](https://youtube.com/embed/0G3J5eJF_jk){: video output="iframe" data-script="#http-api-basics-video-script" id="HTTP API Basics video" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen}

### HTTP API Basics video script
{: #http-api-basics-video-script}
{: notoc}

Welcome to the Introduction to Cloudant course, an 18-part video series that gives you an overview of the IBM Cloudant databases-as-a-service.

This is part 7 - `HTTP API Basics`.

In the previous part we saw the Cloudant dashboard, which is a web app that is making HTTP calls to Cloudant's API. In this step, we'll be using the command line to make HTTP requests and to try to add/edit/delete some documents from there.

It's worth understanding the HTTP API from first principles even if you intend to use the higher-level client libraries.

The advantage of a database having an HTTP API is that any device on the internet can read/write data if you want it to. No special software is required. No drivers speaking a custom protocol. Just a standard HTTP library. Everything speaks HTTP:

- Web browser
- Any programming language
- Command line scripting tools like curl
- Mobile devices

We're going to learn the API using curl, a free, open source command-line tool that can dispatch HTTP requests. Curl comes preinstalled on most Macs and Unix-like operating systems. If it's not present on your computer, google `curl` and follow the installation instructions.

Let's first use curl to fetch a web page - Google's home page.

In a command-line terminal, type `curl https://www.google.com`

You should get a pageful of HTML in reply.

If this works, then you have curl installed and you can proceed with the next tasks.

Now we don't want to type the URL of our Cloudant service every time so let's save the Cloudant URL in an environment variable called URL.

Export URL - Creates a variable called URL, which we can access later.

`export URL=https://username:password@host`
Furthermore, we can create an `alias` (a shortcut) called `acurl` that saves us further typing. This `acurl` command is an alias for curl but with the JSON content-type header and a couple of useful commmand-line switches.

`alias acurl="curl -sgH 'Content-type: application/json'"` 

We can test it by fetching `acurl $URL/` and we should get some JSON back from Cloudant.

You've completed your first Cloudant API call.

Now our acurl alias is set up, we can start exploring the API. Let's start with the _all_dbs endpoint, which returns a list of databases.

Type `acurl $URL/_all_dbs` to see an array of databases.

A quick note here on formatting JSON on the command line. We can send the output of our acurl command to another tool, which will format the data nicely on the terminal. There are a couple of options:

Jq available from the URL on screen, which is more than just a JSON formatter - it allows JSON to be parsed, queried, and manipulated too.
Or `python -m json.tool` is a simple JSON formatter, if you happen to have Python installed on your computer.
So `acurl $URL/_all_dbs | jq` means `pipe the output of acurl into jq` and what you see should be a nicely formatted, colored output.

The Cloudant API paths are hierarchical with the first level giving you information about the service and then each database sits at a level beneath that.

So `acurl $URL/books` gives us information about the books database we created earlier.

You should see information about how many documents it has, how many deleted documents and how much disk space it's occupying.

Note: Don't forget to pipe the output to jq or Python to get a prettier output.

If we want to see the documents contained in the database, we can use the _all_docs endpoint.

So `acurl $URL/books/_all_docs` means get all the documents from the books database from the Cloudant service at the supplied URL.

This will return you a list of `_id` and _rev values for each document. If you want the document bodies too, then add `?include_docs=true` to your API call.

If we want to fetch a single document back from the database, then documents sit one level beneath the database in the hierarchy of the URL.

So `acurl $URL/books/id` means get document ID from the database books from the Cloudant service at the supplied URL.

Notice the hierarchy: service / database / document

So far we've only used the `GET` HTTP method, which is the default one for curl and the one used when you enter a URL into your web browser.

Cloudant's API often uses the HTTP method as a `verb` to describe the action being asked of the database: GET for fetching data.

With curl, we can specify the method we want to use with the -X command-line option.

So to write a new document to our books database using the API, we're going to use the POST method, massing a document as the body of the HTTP request.

`acurl -X POST` specifies we're using the POST HTTP method. -d specifies the document we want to write, which is sent as the body of the request and finally the URL we are writing to which is $URL/books - the books database.

Alternatively we can use the PUT method, if we are supplying the ID of the document being written. The URL becomes `$URL/books/` followed by the ID we want  to write.

Both write methods yield identical response. OK: True to show that the write was successful. ID being the document ID written and rev being the revision token that was generated by the database.

To modify a document we can use the PUT method, writing the new body to the URL that points to the document ID we want  to overwrite. -d supplies the new document body and the URL not only contains the database and ID of the document, but critically the rev - the revision of the document we intend to mutate.

If we forget and omit the rev parameter, we will get an error response.

Note: HTTP response codes tell you whether a request succeeds or not. Responses in the 200 range are successful, 400s are user errors (e.g. invalid parameters) and 500s are server-side errors. You can see the full HTTP request and response by additionally supplying the -v command-line option to curl/acurl.

Also, note that updates to documents happen in their entirety or not at all, there's no API construct to modify part of a document. A whole document must be supplied to overwrite a previous revision.

Finally, to delete a document, we use the DELETE method, so -X DELETE. We direct the request to the URL that includes the database name and document to be deleted, and critically we also supply the rev - the revision of the document to delete.

If we omit the revision token, an error is returned and the request fails.

To summarize, understanding the HTTP API helps you grasp the relationship between your code and the Cloudant service.

The URLs are hierarchical: service/database/document or service/database/endpoint

The HTTP methods act as `verbs` defining the action to be done.

All actions can be triggered using simple HTTP API calls, from the command line or from your code and so can be easily scripted.

That's the end of this part. The next part is called `The Bulk API`

## The Bulk API video
{: #the-bulk-api-video}

Learn how to use two API calls to perform all the basic {{site.data.keyword.cloudant_short_notm}} operations while also acting on more than one document per API call.

![The Bulk API](https://youtube.com/embed/9e_Mx3rX88s){: video output="iframe" data-script="#the-bulk-api-video-script" id="The Bulk API video" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen}

### The Bulk API video script
{: #the-bulk-api-video-script}
{: notoc}

Welcome to the Introduction to Cloudant course, an 18-part video series that gives you an overview of the IBM Cloudant databases-as-a-service.

This is part 8 - `The Bulk API`.

In the previous part, we saw how documents could be easily added, updated, and deleted singly using the Cloudant HTTP API. In this part, we'll see how two API calls can be used to achieve all of the basic Cloudant operations, with the added benefit of being able to act on more that one document per API call.

We've already met the _all_docs endpoint - we used it to fetch a list of all the documents in a database, but it has other features too.

The key parameter can be used to specify a single document to fetch, making it equivalent of the GET /db/id API call.
Similarly, the keys parameter takes an array of document IDs and will return them all.
The startkey and endkey parameters allow you to fetch a slice of the primary index between the supplied limits. Adding include_docs=true instructs Cloudant to supply the document bodies too.
And limit allows you to specify how many documents to return in one API call.

The _bulk_docs endpoint allows multiple insert, update and delete operations to be performed in one API call. It expects an object containing a docs array - each element of that array being an operation to perform on a single document. The request body is posted to Cloudant, allowing many operations to be packed into a single API call.

In this example, the first document is an insert: we know this because no revision token is supplied. The second document is an update to a document because a revision token is supplied with a new document body. The third document is a deletion. A revision token is supplied, but the body is simply _deleted: true, which tells Cloudant to mark the document as deleted.

It's important to note that this isn't like a transaction in a relational database - all or none of these operations could succeed or fail individually. The response data to this request tells you the response for each operation in turn.

In summary

With two API calls `_bulk_docs` & `_all_docs`, we can perform all create, read, update, and delete operations on Cloudant documents and be able to do so in bulk too. _all_docs retrieves documents by `_id` or ranges of IDs. _bulk_docs creates, updates, and deletes documents in bulk. As a rule of thumb, it's recommended that bulk writes are executed in batches of 500; perhaps more than that for tiny documents and fewer than that for large documents.

Here's a screen capture of using Cloudant from a command-line terminal:

That's the end of this part. The next part is called `Accessing Cloudant programmatically`.

## Accessing Cloudant Programmatically video
{: #accessing-cloudant-programmatically-video}

Learn how to access {{site.data.keyword.cloudant_short_notm}} programmatically. 

![Accessing Cloudant Programmatically](https://youtube.com/embed/y35LbPetISw){: video output="iframe" data-script="#accessing-cloudant-programmatically-video-script" id="Accessing Cloudant Programmatically video" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen}

### Accessing Cloudant Programmatically video script
{: #accessing-cloudant-programmatically-video-script}
{: notoc}

Welcome to the Introduction to Cloudant course, an 18-part video series that gives you an overview of the IBM Cloudant databases-as-a-service.

This is part 9 - `Accessing Cloudant programmatically`.

So far, our API interactions have either been triggered by the dashboard or via curl from the command line. In this section, we'll see how Cloudant be accessed programmatically.

The examples will use Node.js, so if you want to try the code yourself, you'll need to install node and npm from nodejs.org.

We can then install the official Cloudant Node.js library with npm install @cloudant/cloudant. (npm is the package manager that comes with Node.js - allowing you to access thousands of open source projects and build them into your application for free).

Once the Cloudant library is installed, we can build some source code. Let's go through this code snippet line-by line:

The URL of the Cloudant service is gleaned from the environment variable we created earlier.

The @cloudant/cloudant library is loaded into your Node.js app with the built-in required functions.
We then create an instance of the library configured with the credentials we stored in the first line.
We use the Cloudant object to get a reference to the books database and store it in a variable db. At this point, we haven't made any API calls - only created data structures that store credentials and which database we are working on.
The main function calls db.list, which maps 1-1 with the _all_docs endpoint we saw earlier. The parameters passed to db.list should be familiar as the options that _all_docs expects to limit the result set and to return document bodies for each ID.

Here's another code snippet that writes a document.

You can see from the first line that standard JavaScript objects can be used in your code and sent to Cloudant with no conversion, as they turn into JSON natively in JavaScript.

Writing a document is simply a matter of calling db.insert, which will map to a PUT/POST API call or to _bulk_docs.

To summarize, there are official Cloudant libraries for Java, Python, and Nodejs. They are thin wrappers around the Cloudant HTTP API - so it's worth understanding the underlying API to get to grips with all the parameters.

The libraries handle two things for you, which are really useful:

Authentication - exchanging your keys for tokens, whether it be legacy authentication or IAM.
Retry logic - the libraries can be configured to retry API calls that exceeded your provisioned capacity. If configured this way, they pause and re-attempt the API call multiple times with exponential back-off
Note: retrying such API calls is sensible if you have a temporary and unexpected elevation in traffic, but if you are routinely exceeding your provisioned capacity, no amount of retrying will get the database work done - you need more capacity!

That's the end of this part. The next part is called `Querying`.

## Querying video
{: #querying-video}

Learn the different ways to query data in {{site.data.keyword.cloudant_short_notm}}.

![Querying](https://youtube.com/embed/R7xVzn2QxRg){: video output="iframe" data-script="#querying-video-script" id="Querying video" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen}

### Querying video script
{: #querying-video-script}
{: notoc}

Welcome to the Introduction to Cloudant course, an 18-part video series that gives you an overview of the IBM Cloudant databases-as-a-service.

This is part 10 - `Querying`.

So far we have performed CRUD (Create/Read/Update/Delete) operations from the command line, the dashboard and from code. These are operations centered on the document's `_id`:

Fetch document by `_id`.
Update document whose `_id` = 'x'.
Delete document whose `_id` = 'x'.
Get documents in the `_id` range 'a' to 'z'.

These operations are the building blocks of a database but they only get you so far. What if you need to return a subset of documents matching on fields within the document. A person's birth date? A book's title? An order's value?

This is where Querying comes in....

There are several methods for querying data in Cloudant. The first we'll look at is called `Cloudant Query`.

Cloudant Query's language was inspired by the MongoDB query language. Queries are expressed in JSON, where the `selector` attribute describes the subset of data to return. The query JSON is posted to the database's _find endpoint to perform a query.

The simplest form of query is finding documents where an attribute has a fixed value e.g. where author == J Smith.

The second example shows two clauses in the query, both of which must be satisfied for a document to make it into the search results. e.g. where isbn === 6725252 AND date = 2018-01-01

The third example shows how logical operators can be added. The `$gt` operation means `greater than` (there's also `gte` for greater than or equal to, and lt/lte for the equivalent less than comparators). The $or operator is an OR operation, so a matching document must have a date greater than the one in the query either an author of J Smith OR title of Murder.

Note: If you need to access objects within documents, you can use standard `dot notation` e.g address.zipcode to access a zipcode string inside an address object.

We can also add:

Fields - to specify the document attributes we want returned (the default is the entire document).
Sort – to define how the data is to be sorted. Sort is an array, allowing the sort to be calculated on multiple attributes.
Limit – the number of documents to return.

If you are from a relational database background, this is the equivalent SQL query to that last Cloudant query example.

The WHERE clause is the equivalent of SELECTOR in Cloudant Query. ORDER and LIMIT are exactly equivalent, and the Cloudant Query FIELDS list is equivalent to the comma-separated list of attributes after the SELECT keyword.

The JSON syntax may take a bit of getting used to, but MongoDB users should find it familiar.

Cloudant queries can be executed in the Cloudant Dashboard. Select the database you are working with e.g. books then choose the Query tab.

Enter your Cloudant Query JSON in the box provided and click Run Query when you're ready. The result set will appear on the rightmost panel.

Note: the Explain button is used to provide an explanation on how the database interprets the supplied query. This becomes more important when we get to Indexing in the next part.

Queries can also be triggered from curl too. The Query JSON, in this case, is stored in a file and POSTed to the _find endpoint using the -d@ command-line syntax.

The Node.js code is very similar. The Query is a standard JavaScript object which is passed to the db.find function which it POSTs to the _find endpoint on your behalf.

Now time for a practical exercise. Devise your own Cloudant Query that finds the titles of books written in the 20th Century. The Cloudant Query documentation is at the on-screen URL if you need it.

Pause the presentation here if you don't want to know the answer...

Here's one solution:

I'm using the $and operator to combine two clauses on the date attribute. One clause to locate documents whose date >= 1900, the other to find documents whose date is < the year 2000. Both clauses have to be true to select a document. As we only need the title of the matching books, we can supply a fields attribute instead of being returned the entire document.

To summarize, Cloudant Query is a query language inspired by MongoDB where the syntax is expressed in JSON form.

Queries select subsets of documents from the database, using clauses operating on data inside the document - not just the document's `_id`.

Queries are sent to the database's _find endpoint, either programmatically, using curl or via the Dashboard.

The query's selector decides which cut of data is required,

That's the end of this part. The next part is called `Indexing`

## Indexing video
{: #indexing-video}

Learn how indexing can speed up your query process. 

![Indexing](https://youtube.com/embed/we2P8mtsnPs){: video output="iframe" data-script="#indexing-video-script" id="Indexing video" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen}

### Indexing video script
{: #indexing-video-script}
{: notoc}

Welcome to the Introduction to Cloudant course, an 18-part video series that gives you an overview of the IBM Cloudant databases-as-a-service.

This is part 11 - `Indexing`.

The queries we executed in the previous part were not optimal: to get the answer, Cloudant had to spool through every document in the database in turn to see if it met with the search criteria.

To make queries run in a performant and scalable way, we need `Indexing`.

Cloudant allows you to specify any number of `Indexes` (or, indices).

An index is a secondary data structure built from the document list. It contains data sorted by the fields you specify e.g. books sorted by date and title. If you perform a query asking for data matching a document's date and title, the indexed data structure can be used to speed up the query process: instead of scanning through every document in turn, Cloudant can jump to the relevant part of the index (say, the section on 20th century books) and retrieve the data much more quickly.

There are two types of Cloudant Query indexes: type=json and type=text, which are backed by two underlying indexing technologies we'll meet in subsequent parts of this course.

An index is defined by POSTing some JSON to a database's _index endpoint.

The index object contains a fields array, which specifies which document attributes to index. As a rule of the thumb, the fields that need indexing are usually equivalent to the attributes used in the `selector` of a query you're going to use to retrieve the data. i.e. if you need to query by the date field, we need to index the date field.

Although the `name` of an index is optional, it's good practice and we'll follow this convention. It's good to ask Cloudant a question and specify the name of the index you intend it to use. This saves Cloudant from having to choose which index it should use from those available and it makes it easy for you to remember which index is which.

Let's create an index on our books database from the dashboard. Select the database, then choose the `Design Documents` tab and `Query Indexes` from the pop out menu.

Any existing indexes are listed on the right side: There should be a `special` index representing the primary index, based on the document's `_id`.

Complete the index definition with the JSON:

Click `Create Index` when you're done.

Clicking the button sends a POST request to the _index endpoint (other API calls are available to update and delete existing indexes).

Note: Indexes are built asynchronously by Cloudant in the background. For large databases, it may take Cloudant some time to construct the index for the first time. The index will not be able to use until that initial build is ready.

We can repeat our query for books in the 20th century, this time specifying the index name with the use_index field and the answer should return, this time powered by our index. You may not notice a speed improvement for a very small database, but the benefit is definitely felt as your data size and query volume grows. Indexing helps your queries remain performant as your application scales.

When you tell Cloudant to create a secondary index, it starts a background task looking at all the documents in turn and creates a new data structure on disk: the index. The index is a balanced tree which pairs the keys (the attribute or attributes you need indexed) with the document `_id` they came from.

The index can be used to efficiently look up known keys and ranges of keys without having to rescan the entire database.

There is another trick that can be employed at index time: the partial filter. You may optionally supply a partial filter in your index definition, and this Cloudant Query selector will be executed at index time to decide which documents' data make it to the index and which are ignored.

In this example, a selector is employed that only allows dates that fall on a weekend to make it to the index. Smaller indexes are faster and more efficient. If you have a use-case that only needs a subset of the data to be indexed, e.g. only completed orders, or only expired accounts, or only published blog posts, then a partial filter selector at index-time can help to make the index smaller and more efficient.

To summarize, the _index endpoint is used to define the index and an optional partial filter can be applied at query time to make smaller, sparser indexes.

That's the end of this part. The next part is called `MapReduce`.

## MapReduce video
{: #mapreduce-video}

Learn about MapReduce, which is another way to configure secondary indexes.

![MapReduce](https://youtube.com/embed/T1KFHLe6NsA){: video output="iframe" data-script="#mapreduce-video-script" id="MapReduce video" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen}

### MapReduce video script
{: #mapreduce-video-script}
{: notoc}

Welcome to the Introduction to Cloudant course, an 18-part video series that gives you an overview of the IBM Cloudant databases-as-a-service.

This is part 12 - `MapReduce`.

We've seen how a combination of the _find and _index endpoints allows queries to be performed on the contents of JSON documents, backed by secondary indexes to make queries scale as your application grows.

In this part, we'll introduce another way of configuring secondary indexes called MapReduce.

MapReduce used to be the only way to configure secondary indexes in CouchDB and is still a popular way of querying data from within the document body.

To create a MapReduce index, you need to supply a JavaScript function wrapped in a special document called a design document to Cloudant. Design documents' `_id` fields begin with _design/ e.g _design/mydesigndoc.

When Cloudant receives the design document it will set up a background indexing task, passing each document from the database to your JavaScript function in turn: the key/values that are emitted by your JavaScript function form the basis of the index that is persisted.

Let's look at some example JavaScript functions on the right of the screen.

The function accepts one parameter - the document that is passed to it by the Cloudant indexer. Every time your function calls emit the parameters you pass from the key/value of the index.

The first example emits a key of doc.name, so this is an index for lookups by the name field and there is nothing (null) for the value.

The second example pre-processes the data before emitting. This is a useful way of tidying up strings, trimming whitespace, lower/uppercasing text, applying default values to missing data, or constraining values to certain ranges etc.

The third example adds logic: only documents that are `published` make it to the index. This is equivalent to the partial filter selector we saw with Cloudant Query.

Indexes build asynchronously and cannot be used until they have built completely. Once built, they can be used for selection by key, lists of keys, ranges of keys and can also be used for aggregation of data e.g. `find orders between two dates, and calculate the total value of the orders, grouped by month.`

There are four built-in reducers (or five if you count `none`).

- `_count` - for counting things.
- `_sum` - for totalizing values.
- `_stats` - for providing counts and totals suitable for calculating means, variances, and standard deviations.
- `_approx_count_distinct` - for approximate counting of unique values of the key.

The design document's MAP function is passed a `doc` - the function is called once per document in the database. Any key/value pairs `emit`ed from the MAP function create the index.

The KEY is the thing (or things) you want to `select` on (e.g. date).

The VALUE is the thing you need to report on (e.g. total sales).

The Reducer is _sum so that the VALUE is totaled for matching keys (e.g orders on the same date).

Here's what defining a MapReduce looks like in the Cloudant dashboard.

When the MapReduce view is built, it can be queried to see each KEY/VALUE pair stored in the index.

Or, if the reducer is switched on result set can be grouped by the value of each key. Here we are totalizing each day's sales.

The view can be queried for individual keys (e.g. sales on a given date), all keys, or a range of keys (e.g. between two dates).

MapReduce views are built asynchronously and may take some time to be ready for large data sets.

Here's some tips:

Use if logic in your JavaScript to only include data that makes sense, for example, only totalize completed orders.
Indexed keys don't have to be strings. A common pattern is to use array keys e.g an array of year, month, day. This allows query-time grouping by elements in the array e.g. orders by year, orders by year and month, orders by year and month and day - great for summary reports that allow the user to drill down into the detail.
The value can by a string, number, or sometimes a small object containing a subset of the document. The object can be used instead of adding include_docs=true, which would also return the document's body in the result set.

To summarize, MapReduce is a low-level means of defining indexes that allow the selection and aggregation of data.

Use JavaScript logic to decide which data makes it to the index. Choose how the index is formed by emitting keys/values.

Summarize data with the built-in reducers. Produce concise reports from lots of data very efficiently.

MapReduce is great for boilerplate queries that your application needs to do again and again. Not for one-off, adhoc-queries for data exploration.

That's the end of this part. The next part is called `Dates`

## Dates video
{: #dates-video}

Learn about different options for storing a date, or date and time value.

![Dates](https://youtube.com/embed/7b2zFNIK7hU){: video output="iframe" data-script="#dates-video-script" id="Dates video" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen}

### Dates video script
{: #dates-video-script}
{: notoc}

Welcome to the Introduction to Cloudant course, an 18-part video series that gives you an overview of the IBM Cloudant databases-as-a-service.

This is part 13 - `Dates`.

We saw earlier in this course that JSON only natively models strings, numbers, booleans, objects, and arrays. A common use-case is to store a date or date/time value in a database. Here's some ideas on how that can be achieved with Cloudant.

The ISO-8601 string format for representing a time consists of a y-m-dTh:m:s.msTIMEZONE year, month, day, a 'T' character, hour, minute, second, millisecond, and time zone.

I always recommend storing dates in the UTC time zone  even if collecting data from different geographies. Date stored in this form can easily be transformed into the local time zone  at the front end, but it's usually important to store each user's data in the `same units`.

This string format sorts into date/time order (because the most significant date units are at the front of the string) and can be easily parsed in MapReduce functions.

Another option is to store the number of milliseconds since 01-January-1970. This too is a standard, machine-readable way of representing a date and time.

It too can be parsed in MapReduce functions and is very handy for comparing two dates: simply take one timestamp from another.

The third option is to store each date/time component in separate fields. This is more verbose than the previous options but has one key advantage if you're using Cloudant Query. Because Cloudant Query can only act upon data in the form it exists in the document itself, if you need to query on a single date component e.g the month, then you'd need that item broken out in the document.

To summarize, there's no native date format in JSON, so you can store dates and times how you like. ISO-8601 is compact, readable, and sorts nicely. As do a timestamp (milliseconds since 1970).

If you need to use Cloudant Query on one of the component parts, then that would need to be broken out explicitly in the document.

That's the end of this part. The next part is called `Replication`.

## Replication video
{: #replication-video}

Learn what replication means in {{site.data.keyword.cloudant_short_notm}}, as well as different types of replication and how they work. 

![Replication](https://youtube.com/embed/TxDcumJ-DdA){: video output="iframe" data-script="#replication-video-script" id="Replication video" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen}

### Replication video script
{: #replication-video-script}
{: notoc}

Welcome to the Introduction to Cloudant course, an 18-part video series that gives you an overview of the IBM Cloudant databases-as-a-service.

This is part 14 - `Replication`.

Replication is a core feature of Cloudant. It is the transfer of data from one database (the source) to another (the target).

The source and target databases can reside on the same Cloudant service, or be geographically separated, for example a US Cloudant database replicating to one in Europe.

The Cloudant replication protocol is shared with Apache CouchDB, so replication is often used by enterprises copying data from a cloud-based database to one running CouchDB in their own premises.

PouchDB, a JavaScript-based CouchDB clone that runs in Node.js stacks or in the web browser can also be used to replicate data to or from Cloudant and/or CouchDB.

And there are the Cloudant Sync libraries, which allow native iOS or Android apps to sync data to and from a Cloudant service.

Replication is a one-way operation from source to target, which moves all data (deletions, conflicts, attachments as well as documents) and can be triggered in 1 of 2 ways:

To run until all the data from the source has reached the target and then stop, or
the same as one but to keep the replication running continuously forever, transferring new data from the source to the target as it arrives.
Replication can also be resumed from where it last stopped. Cloudant keeps a note of `checkpoints` between replicating parties to allow the resumption of a pre-existing replication from its last known position.

There is a replication tab in the Cloudant dashboard. A replication is started by specifying the source and target databases including authentication credentials, and whether this is a one off or continuous operation.

A replication can also be given a name, which is handy for tracking which replication job is which.

Now it's time for a practical exercise.

From your Cloudant dashboard:

1. Create a new database called `books2`.
2. Start a continuous replication from books to `books2`.
3. Visit the `books2` database to check that documents from books are now in `books2`.
4. Add a document to the `books` database - check the change makes it to the `books2` database.

Replication can be used to move data from a Cloudant database to an on-premises CouchDB instance. The replication can be controlled by the Cloudant or the CouchDB end i.e you can ask Cloudant to send its changes to CouchDB or you can ask CouchDB to pull the changes from Cloudant. Bear in mind that the replication controller must have network visibility of both HTTP APIs.

PouchDB also speaks the same replication protocol so can be used to transfer data to and from PouchDB and Cloudant. It's most likely that PouchDB would be the replication controller in this case.

PouchDB is commonly used to create offline first apps, which collect data even when not connected to the internet and then write data to Cloudant when they come back online, giving their users an always on service.

Bear in mind that replication may not always be required. If your application needs to store data and then write it to Cloudant later, then replication isn't strictly speaking required. All that is required is that data is stored on the device and bulk written to Cloudant when the connection is restored.

As replication is a one-way operation, if a primary-primary setup is required between two Cloudant instances in different regions, then two replications in opposite directions are required.

Changes occurring on the London side are sent to Dallas, and vice versa.

More complex topologies are possible, with data flowing in a ring around a set Cloudant service.

To summarize, Cloudant replication is a mechanism for copying data from a source database to a target database.

Replications can be one-off or continuous and can optionally be filtered with a JavaScript function or Cloudant Query selector and can be resumed from where a previous replication stopped.

That's the end of this part. The next part is called `Partitioned databases`.

## Partitioned databases video
{: #partitioned-databases-video}

Learn how partitioned databases work in {{site.data.keyword.cloudant_short_notm}}, how to assign documents to specific shards, and why partitioned databases improve performance, cost, and scalability. 

![Partitioned databases](https://youtube.com/embed/44PhiYnrGJA){: video output="iframe" data-script="#partitioned-databases-video-script" id="Partitioned databases video" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen}

### Partitioned databases video script
{: #partitioned-databases-video-script}
{: notoc}

Welcome to the Introduction to Cloudant course, an 18-part video series that gives you an overview of the IBM Cloudant databases-as-a-service.

This is part 15 - `Partitioned database`.

We haven't discussed this yet, but Cloudant is a distributed database. There are many storage nodes that make up a Cloudant service and a database's documents are distributed across the nodes in groups called `shards`. A single database is said to be `sharded` or divided into multiple pieces.

In a normal Cloudant database, a document is allocated a shard algorithmically - effectively documents are distributed around the shards randomly.

In a partitioned database, you define which shard the documents are stored in by supplying a partition key.

Partitioned databases are created with the same PUT /<database name> API call but with an additional query string parameter: partitioned=true

In the first example, the products database is created as a partitioned database, in the second example as a standard, unpartitioned database.

When adding documents to a partitioned database, you must supply a document _ID - (there are no auto-generated document _IDs). A document `_id` has two parts, separated by a colon character:

The partition key - a string that defines on which partition to store the document.
A document key - a string that uniquely identifies a document within the partition.
In the first example, a book is being added into the book partition of the products database.

Then, another document is being added into the dvd partition and a third into the household partition.

The effect of this is that documents sharing a partition key reside in the same shard of the databases. Documents in the same partition are stored together in document key order.

The advantage comes when retrieving data. We can direct Cloudant Queries, MapReduce requests and searches at a single partition. In this example, a Cloudant Query selector is being sent to the book partition. This has the effect of only exercising a fraction of the Cloudant infrastructure (only the shard that hosts the book partition are used, the rest of the cluster remains idle).

This makes for faster query performance, cheaper query costs and better scalability.

The key to great partitioned query performance is the choice of partition key:

It needs to be a value that repeats within your data set. For example, there are several items in the book partition.
There needs to be many partitions. If there are only a handful of categories, then category is a bad choice of partition key. It needs to be something that has many values e.g. deviceId in an IoT application or orderId in an e-commerce system.
It needs to match the queries that your application is making. If the most common use-case is searching within a product category, then partitioning by category may be a good fit.
Avoid hot partitions - traffic should be evenly spread across your partitions. If your choice of partition key is likely to lead to much more traffic hitting a small number of partitions, then this makes for a poor choice of partition key.

To summarize, partitioned databases are created with the partitioned=true flag and documents have a two part ID where the partition key and document key are joined by a colon character.

Documents in the same partition are stored in document key order in the same database shard. Knowing this, we can make queries directed at a single partition that run faster and more cheaply.

Note: it's still possible to query across partitions in a partitioned database. When creating a secondary index, you choose whether its purpose is for per-partition or global scope.

That's the end of this part. The next part is called `Cloudant Search`.

## Cloudant Search video
{: #cloudant-search-video}

Learn how to use Cloudant Search, as well as Lucene query language and faceting. 

![Cloudant Search](https://youtube.com/embed/4cs5qH3lt5U){: video output="iframe" data-script="#cloudant-search-video-script" id="Cloudant Search video" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen}

### Cloudant Search video script
{: #cloudant-search-video-script}
{: notoc}

Welcome to the Introduction to Cloudant course, an 18-part video series that gives you an overview of the IBM Cloudant databases-as-a-service.

This is part 16 - `Cloudant Search`.

There is another method of querying and indexing in Cloudant called Cloudant Search that we'll briefly explore in this part.

Cloudant Search is built on another open source project, Apache Lucene, which powers the search capabilities of many products including Elasticsearch.

It is primarily designed for free text search, where blocks of text are pre-processed before being indexed: removing case, punctuation, common noise words and trimming common language-specfic word endings e.g. farmer becomes farm and farms becomes farm.

This text-processing is performed by a choice of analyzers at query time, searching. Prior to this, it also allows some aggregation functionality using a technique called faceting as we'll see.

A Cloudant Search index is created by supplying JavaScript function, not unlike MapReduce except this time the emit function is replaced by an index function, which expects the name of the field, the data itself and some options.

In this example, the document's name and title are indexed with default options. The category is nominated for faceting (the aggregation functionality) and the isbn is stored in the index but not indexed for search itself. Sometimes it is more efficient to store some items in the index rather than doing include_docs=true at query time.

Lucene has its own query language allowing you to create queries that match combinations of clauses with logic, fuzzy matching, ranges, and term boosting.

Here are some examples:

Find documents whose title matches 'gastby' and whose author starts with 'fitz'. Notice the asterisk wildcard.
Find documents whose author is in the range austen to dickens. This is an example of range querying on a string field.
Find documents whose price is between 0 - 100 AND whose year is in the 19th century or whose author matches `charles dickens`. This shows how logic can be built into queries.
Cloudant Search is useful not only for free-text search, but for when you know which attributes you are going to search on, but the queries are varied, with different combinations of attributes each time. This flexibility is difficult to implement with fixed-order MapReduce indexes.

Faceting is a form of aggregation. You nominate individual indexed fields for faceting at index-time and activate the aggregation with parameters at query-time.

It has two uses:

Counting repeating values in the result set, such as the counts of products that belong to each category in a result set. Or,
counting numbers of items in numeric ranges, such as the product counts in each of the price ranges.
Both of these forms of counts can be presented to a front-end user as a means of further filtering an existing search, to narrow the scope of the search. e.g a customer searches for Fender, then clicks Amps then on a price range under $500. All of this search and filtering can be powered by Cloudant Search.

To summarize, Cloudant Search indexes are defined with a supplied JavaScript function. They are built on Apache Lucene and are primarily used for free-text search matching, but the query language is useful for building flexible queries on a fixed set of indexed fields. It also has some powerful counting aggregations suitable for drill-down user interfaces.

Note: Cloudant Search also powers 'type=text' Cloudant Query indexes, so a subset of its capabilities is surfaced using the _find API.

That's the end of this part. The next part is called `Geospatial`.

## Geospatial video
{: #geospatial-video}

Learn how to use geospatial indexes to query data, which is unique to {{site.data.keyword.cloudant_short_notm}}. 

![Geospatial](https://youtube.com/embed/nfDQN_Em4H8){: video output="iframe" data-script="#geospatial-video-script" id="Geospatial video" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen}

### Geospatial video script
{: #geospatial-video-script}
{: notoc}

Welcome to the Introduction to Cloudant course, an 18-part video series that gives you an overview of the IBM Cloudant databases-as-a-service.

This is part 17 - `Geospatial`.

The final means of querying data in Cloudant is using geospatial indexes.

Geospatial indexes are unique to Cloudant - you won't find them in the CouchDB codebase.

Data is stored as GeoJSON in the Cloudant database to describe point, line, polygon, multi-point, multi-line and multi-polygon objects. Each object, as well as the geographic information, can have optional properties: meta data about the object, which is returned in the search results.

Again an index is defined as a JavaScript function, and then, queries can be used to ask questions of your collection of geographic features. For example, find me the nearest object to this point; find objects within this polygon; find objects along this path; or find objects that intersect with this object.

To summarize, Cloudant Geo is something unique to the Cloudant service and is used to perform advanced geospatial queries against your databases of GeoJSON objects. It cannot be combined with other index types so is only of use to Geographic Information Systems or use-cases that have a purely geographic purpose.

That's the end of this part. The next part is called `Under the hood`

## Under the hood video
{: #under-the-hood-video}

Learn how the {{site.data.keyword.cloudant_short_notm}} service is organized. 

![Under the hood](https://youtube.com/embed/kCOTeCnHWJg){: video output="iframe" data-script="#under-the-hood-video-script" id="Under the hood video" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen}

### Under the hood video script
{: #under-the-hood-video-script}
{: notoc}

Welcome to the Introduction to Cloudant course, an 18-part video series that gives you an overview of the IBM Cloudant databases-as-a-service.

This is part 18 - `Under the hood`.

Let's take a look at how a Cloudant service is organized: this overview applies to the Cloudant services that map to CouchDB 2 and 3. CouchDB 4 will be built on different technology.

Cloudant is a distributed database with data stored around a cluster of storage nodes. Picture the Cloudant service as ring of nodes, in this case twelve. Every node can deal with incoming API calls and every node has responsibility for storing some of the data: shards and associated secondary indexes of databases that exist in the cluster.

When data is written to Cloudant, one of the nodes in the ring will handle the request: Its job is to instruct three copies of the data to be stored in three storage nodes. Data is stored in triplicate in Cloudant, so each shard of a database is stored multiple times, often across a region's availability zones.

When you make an API call to write data and get a response back, we have written the data to at least 2 of the 3 storage nodes. Data is flushed to disk - it isn't cached in memory to be flushed data. We consider that technique too risky and prone to data loss.

When you create a database, a number of database shards are created (16 by default) which are spread around the cluster. As there are three copies of each shard that's 48 shard copies.

You don't see any of this - it's handled for you transparently when you create a database.

What happens if a node goes down or needs to be rebooted for maintenance? The rest of the cluster continues as normal. Most shards still have three copies of data but some will only have two. API calls will continue to work as normal, only two copies of the data will be written.

Even if two nodes go down, most shards will still have three copies, some will have two and some will have one. Writes will continue to work, although the HTTP response code will reflect that the quorum of two node confirmations wasn't reached.

It's the same story for reads. Service continues with a failed node. We can survive one failed node...

Or more failed nodes. If there is a copy of each node in existence, the API should continue to function.

When a node returns, it will catch up any missed data from its peers and then return into service, handling API calls and answering queries for data.

The nature of this configuration where any node can handle a request and data is distributed around nodes without the sort of locking you would see in a relational database, is that Cloudant exhibits eventual consistency:

Cloudant favors availability over consistency: it would rather be up an answering API calls, than be down because it can't provide consistency guarantees. (a relational database is often configured in the opposite way: it operates in a consistent manner or not at all).
The upshot of this as a developer is that your app should not `read its writes` in a short period of time. There may be a small time window in which it is possible to see an older version of a document than the one you just updated. Eventually, the data will flow around the cluster and in most cases, the quorum mechanism will provide the illusion of consistency, but it is best not to rely on it.
Note in CouchDB 4, and in Cloudant services based on that code version, a different consistency model will be employed.

If your data model requires you to update a document over and over in a short time window, it's possible that multiple writes for the same revision number are accepted leading to a branch in the revision tree - known as a conflict. In this example revision `2` was modified in two different ways, causing two revision 3s. It's possible to tidy up conflicts programmatically, but they should be avoided as they can cause performance issues in extreme circumstances.

Conflicts can also happen when using replication and a document is modified in different ways and then the conflicting revisions are merged in via replication. Cloudant does not throw away data in this scenario. A `winning` revision is chosen, but the non-winning revisions can be accessed and your application can resolve the conflict by electing a new winner, deleting unwanted revisions, or any action you need. A conflict is not an error condition. It's a side effect of having disconnected copies of data that can be modified without locking. Cloudant chooses to handle this by not discarding clashing changes, but storing them as a conflict.

To check a document for conflicts, simply add `?conflicts=true` to a fetch of a single document. Any conflicting revisions will be listed in the _conflicts array.

Unwanted revisions can be removed using the normal DELETE operation, specifying the rev token of the revision you want to delete. The bulk API is also good for removing conflicting revisions, even for removing multiple conflicts from the same document.

To summarize, Cloudant is a distributed service that stores databases which broken into multiple shards, with three copies of each shard spread around a ring of storage nodes. Cloudant is eventually consistent, favoring high availability over strong consistency.

Avoid writing to the same document over and over so as not to create conflicts, although conflicts are sometime inevitable in replicating situations.

Embrace eventual consistency - don't try to make Cloudant consistent.

Note: Cloudant products based on CouchDB 4 may have a different consistency model.

That's the end of this course. For more information, see our documentation and our blog.