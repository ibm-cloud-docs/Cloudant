---

copyright:
  years: 2015, 2019
lastupdated: "2020-04-28"

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

<!-- Acrolinx: 2020-04-24 -->

# Learning Center
{: #learning-center}

The {{site.data.keyword.cloudantfull}} Learning Center offers videos to help you learn to use {{site.data.keyword.cloudant_short_notm}}. The videos start with the basics of using {{site.data.keyword.cloudant_short_notm}} and walk through document structure, the API, indexing and querying, and include an "Under the Hood" topic that highlights the architecture powering the service.
{: shortdesc}

You can use the [playlist](https://www.youtube.com/playlist?list=PLJa_sXrJUZb-Y4Q_5y3yPC8m5RxS5q-_J) to go through the courses, or navigate directly to the topic of your choosing from the following list:

## Introduction to {{site.data.keyword.cloudant_short_notm}} video
{: #cloudant-course-intro-video}

Learn about the {{site.data.keyword.cloudant_short_notm}} eighteen-part video series that provides an overview of the {{site.data.keyword.cloudant_short_notm}} database-as-a-service. 

<div class="embed-responsive embed-responsive-16by9" data-hd-video="video">
<iframe class="embed-responsive-item" id="courseintroduction" title="{{site.data.keyword.cloudant_short_notm}} Course Introduction" type="text/html" width="560" height="315" src="https://www.youtube.com/embed/W1oYiDNpMo4" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen> </iframe>
</div>

### Introduction to {{site.data.keyword.cloudant_short_notm}} video script
{: #cloudant-course-intro-video-script}
{: script}
{: notoc}

Welcome to the Introduction to Cloudant course, an eighteen part video series that gives you an overview of the IBM Cloudant databases-as-a-service.

This is part 1: "What is Cloudant?"

Cloudant is a database, run as a service in the IBM Cloud. Its job is to store your application's data securely and allow you to retrieve it quickly and efficiently. Cloudant's key features are that it is

a database - it stores and retrieves data
more specifically it is a JSON document store. JSON comes from JavaScript and represents simple objects in a universal file format. The "document" is the unit of storage in Cloudant. Documents are added/updated/deleted in their entirety.
It has an HTTP API. Any Cloudant operation can be achieved using HTTP. HTTP is the protocol that powers the World Wide Web and Cloudant is a database built for the web.
Most databases are hidden in a private network, inaccessible but to a handful of machines but the Cloudant service sits (mainly) on the public internet where it be accessed by anyone with an internet connection (and permission to do so!).

Cloudant wasn't written entirely by IBM. It is based on Apache CouchDB, an open source project run by the Apache Foundation. Cloudant employs a number of CouchDB contributors but by the rules of Apache, they cannot monopolise its development.

Much of what you see in this course is applicable to Apache CouchDB as it is to Cloudant. Their APIs are 99% the same - I'll point out where they diverge.

Cloudant can be thought of as CouchDB run "as-a-service". A Cloudant service is easily deployed and is managed by IBM engineers 24-7. There's no software to install, no servers to manage, no configuration to understand. The user need not be a CouchDB expert to use and manage it.

Cloudant being built on truly open source foundations means that you can be sure that your data layer is not locked in to a particular platform, cloud or vendor and Cloudant can be used in concert with CouchDB to create hybrid applications that share data through replication, as we'll see.

Later on in the course we'll look "under the hood, to see how Cloudant works, but initially we'll treat Cloudant as a "black box".

To summarise

Cloudant is based on Apache CouchDB, an open source project.
it stores JSON documents.
it is accessed with an HTTP API and can therefore be accessed by any device on the internet that speaks HTTP: application code, web browser, IoT device or mobile phone.
Cloudant is a highly-available managed service able to continue to operate with multiple hardware failures

That's the end of this part. The next part is called The Document.

## The Document video
{: #the-document-video}

Learn about {{site.data.keyword.cloudant_short_notm}} databases and documents work. 

<div class="embed-responsive embed-responsive-16by9" data-hd-video="video">
<iframe class="embed-responsive-item" id="thedocument" title="The Document" type="text/html" width="560" height="315" src="https://youtube.com/embed/xaL1DZuXjtk" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen> </iframe>
</div>

### The Document video script
{: #the-document-video-script}
{: script}
{: notoc}

Welcome to the Introduction to Cloudant course, an eighteen part video series that gives you an overview of the IBM Cloudant databases-as-a-service.

This is part 2: "The Cloudant Document?"

We've seen that Cloudant is a JSON document store. Let's find out what that means in practice and how that compares to other types of database.

Most databases store their data in collections called tables, where each unit of data is a row, each with identical, fixed columns. The schema of each table is predefined: a list of columns with their name, date type, value constraints and relations to other tables carefully defined. Each new record forms a row in a table.

Cloudant is quite different!

A Cloudant service has collections called databases (instead of tables) each of which containing any number of documents.

The example on this slide shows the same data expressed in a traditional tabular database and how the same data would be stored in Cloudant as JSON documents.

So if you come from a relational database background: tables are "databases" in Cloudant, and rows are "documents".

A Cloudant document must be a JSON object, starting and ending with curly braces and containing a number of key/value attributes.

JSON objects must be less that 1 megabyte in size and contain any number of strings, numbers, booleans, arrays and objects. The nesting of objects within objects can continue to any depth.

The keys used can be as brief or verbose as you like.

Here are some simple example documents showing how each data type is used.

the first example shows a person object, storing strings, booleans, and an array of tags.
the second example shows very brief attribute names, to save on storage and represents a web event such as a click on a website.
the last example shows how the document may itself contain sub-objects
A note on dates. JSON has no native Date type so dates are usually stored in 2018-10-30 or similar formats - we will come back to dates later.

Now for your first practical exercise. Visit www.ibm.com/cloud and register an account with the IBM Cloud, if you don't have one already.

Once registered, you may click "services", search for the "Cloudant" database and provision a new service.

The Cloudant "Lite" service provides a free plan to allow users to try Cloudant in a limited capacity while in development. Its bigger brother, the "Standard Plan", is paid-for service where you specify the number of reads/writes/and queries per second your application and that capacity is reserved for you. You pay for the capacity you provision and your data storage usage.

The Lite plan operates in a similar way, but only has a small provisioned capacity and a fixed storage size, but is fine for "kicking the tyres".

Cloudant is often referred to as a "schemaless" database - but we have to be careful how we define that term.

It's true to say that there's no need to define your schema (field names, types, constraints and relationships) ahead of time in a Cloudant database - you may simply write a JSON document of your own design to a database.

This flexibility is well liked by developers because they can design their data in their code, turn it into JSON and write it to the database.

It's still important to think about the "shape of your data", especially in terms of how you are going to query and index it, as we'll see later.

Data design is still required, but strictly speaking that database doesn't need to know about your schema.

Let's say we want to create a database of US presidents. We can simply devise our "model" of the data in our app, turn it into JSON and write it to the database. In this case we are using a common CouchDB convention: the "type" field indicating the data type of the document.

If at a future date we decide we want to add additional data to our "schema", we can simply write a new object to the database with no complaints from Cloudant. We could decide to add the "address" object only to:

documents that are created from now on
only documents that we know addresses for
In other words, documents of the same type can have fields present or missing.

You database's schema can evolve over time to match your application's needs and you don't (necessarily) need to tell the database about the schema change - just write new documents in the new format.

We can even store multiple document "types" in the same database. In this case, people/books/places reside in the same database. We know which is which because of the "type" field (this is a convention and not something that means anything to Cloudant).

An alternative to this is have three databases people/books/places and keep each data type in its own database. Both approaches are fine: you would choose to have multiple types together in the same database if need to perform queries across types or if you need to replicate all data types together, otherwise the separate databases approach may be better.

To summarise:

Although Cloudant is "schemaless", this doesn't absolve you of the need to do detailed data design to get the best performance.

Here are some tips, especially relevant if you have some relational database experience.

avoid thinking in joins - a Cloudant document should contain everything you need about that object, so that it can be retrieved in one API call.
normalisation goes out of the window in JSON store, some repeated values can be tolerated if it makes data retrieval more efficient.
although we have a 1MB limit on document size, your documents should be much smaller than that - a few KB is typical.
If your application can embrace a "write only" design pattern, where data is only ever added to a database, then it may make your life easier. You should definitely avoid patterns that rely on updating the same document over and over in small time window.

That's the end of this part. The next part is called "The Document id".

## The `_id` video
{: #the-_id-video}

Learn how `_ids` work in {{site.data.keyword.cloudant_short_notm}}, how they are different from relational databases, and how you can define your own `_id`. 

<div class="embed-responsive embed-responsive-16by9" data-hd-video="video">
<iframe class="embed-responsive-item" id="theid" title="The _id" type="text/html" width="560" height="315" src="https://youtube.com/embed/sI7xqIveoSY" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen> </iframe>
</div>

### The _id video script
{: #the-_id-video-script}
{: script}
{: notoc}

Welcome to the Introduction to Cloudant course, an eighteen part video series that gives you an overview of the IBM Cloudant databases-as-a-service.

This is part 3: "The Document _id"

We've seen how data is stored in Cloudant documents with flexibility on how your application stores JSON objects in Cloudant databases. There are, however, a few hard and fast rules.

One rule is that every document must have a unique identifier called _id which is a string. No two documents in the same database can have the same _id field. In other databases, you specify which column is the unique identifier, but in Cloudant it's always _id and can't be changed.

Also, unlike relational databases, Cloudant does not have "auto incrementing ids", that is an ID field that starts at 1 and increments for each document added.

Cloudant's _id field is either:

a 32 character string generated by Cloudant - the ID is a meaningless sequence of numbers and letters that is guaranteed to be unique. or,
a string defined by you (if you know something unique about your data)

Here are some examples of supplying your own document _id :

using it to store something that you know is unique i.e. the email address of a user. Your registration mechanism can enforce a one-user-per-email address policy.
Some users choose to encode the document type in the _id e.g. user:56, book:55
The last example shows using a 32-digit string (generated in your app) that is designed to sort in approximate date/time order, making it easy to retrieve the latest documents from the database, without a secondary index.

Cloudant takes your document _ids and stores them in an index (like the contents page of book). This primary index is in _id order and is used to allow Cloudant to retrieve documents by their _id - thus behaving like a key/value store.

By careful design of your _id field, you can make use to the primary index to keep data that makes sense to be together in the primary index, making it quicker to retrieve that data later. We've already seen that using time-sortable _ids means that data can be retrieved in approximate date/time order.

We'll see this later when it comes to retrieving ranges of document ids.

In conclusion, each document must have a _id field that is unique in the database. It can be auto-generated by Cloudant, or can be supplied by your application, in which case you must take responsibility of the uniqueness of the _id field.

The _id field is the basis of the database's primary index which, as we'll see, can be used for key/value lookups and range queries.

That's the end of this part. The next part is called "The rev token".

## The rev token video
{: #the-rev-token-video}

Learn how {{site.data.keyword.cloudant_short_notm}} creates a revision token when you add, edit, or delete a document. 

<div class="embed-responsive embed-responsive-16by9" data-hd-video="video">
<iframe class="embed-responsive-item" id="therevtoken" title="The rev token" type="text/html" width="560" height="315" src="https://youtube.com/embed/A38jW_hpYFo" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen> </iframe>
</div>

### The rev token video script
{: #the-rev-token-video-script}
{: script}
{: notoc}

Welcome to the Introduction to Cloudant course, an eighteen part video series that gives you an overview of the IBM Cloudant databases-as-a-service.

This is part 4: "The rev token"

The second fundamental Cloudant rule is that each document revision is given its own unique revision token. Let's find out what it means.

You never need to generate a revision token - one is created for you when you add, update or delete a document using the API.

A revision token consists of two parts:

a number 1, 2, 3, etc, and
a cryptographic hash of the document's body
(For the uninitiated, a hash is a digital "fingerprint" of some data. If the data changes, the fingerprint changes. No two fingerprints are the same i.e. no two documents with different content would have the same hash.)

You can see from the example on the right that our document has a revision token (the key starting _rev) that starts with a "1" followed by a dash. That tells us that this is the first revision of the document. The digits starting 04aa8... are the cryptographic hash of the document.

If we follow the lifecycle of a document, it starts with a "revision 1". When it is modified later, it gets a "revision 2" and so on. With each incrementing revision number, the hash also changes because the content of the document is being modified too.

One thing to note:

It is possible for a document to have more than one revisions with the same number. i.e. two "revision 3s". This is called a "conflict" and is "normal" in some circumstances. We'll see why later in the course, but for now we can assume that the revision number will increment with each update to a document.

Let's follow the lifecycle of an example Cloudant document

When a new document is created (whether with an auto-generated _id or user-supplied _id), it is allocated a "revision 1". You will be sent the token in the response to your API request. Normally you can discard the rev (UNLESS you intend to modify the document in the near future, as we'll see).

When we modify a document whose _rev is at "revision 1" (notice we've changed the name in the document from Liz --> Elizabeth), the document is saved and a "revision 2" token is generated and returned to you in the API response.

All simple enough so far.

If we delete the document later, A "revision 3" is created !

Unlike almost any other database, Cloudant keeps a reference for deleted documents. A deletion is just another document revision - a special one where _deleted: true replaces the document body.

In fact the document's recent revision history (the tree of revisions - remember we could have more than one of each revision number) - is kept.

Note

You can't use Cloudant's revision tree as a version control system to retrieve or "rollback" to an older revision. Once a revision is superceded, the document body of the older revision is deleted and its disk space recovered in a process called "compaction". Compaction occurs automatically in Cloudant, so it's not safe to assume that old revisions will be available to be retrieved.

To summarise:

revision tokens are generated by the database on add/edit/delete. (you never need to create your own revision tokens).
generally, the revision number increases by one each time, but more complex scenarios are possible (we'll cover this later).
older document bodies are discarded or compacted (don't rely on being able to get them back).
all Cloudant operations that change a document need the document's _id AND its _rev (this is unlike most databases)

That's the end of this part. The next part is called "Authentication".

## Authentication video
{: #authentication-video}

Learn how Legacy authentication and IAM authentication work. You can also learn how {{site.data.keyword.cloudant_short_notm}} generates credentials, and how the three official {{site.data.keyword.cloudant_short_notm}} libraries handle authentication. 

<div class="embed-responsive embed-responsive-16by9" data-hd-video="video">
<iframe class="embed-responsive-item" id="authentication" title="Authentication" type="text/html" width="560" height="315" src="https://youtube.com/embed/Q9UAG42oYhM" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen> </iframe>
</div>

### Authentication video script
{: #authentication-video-script}
{: script}
{: notoc}

Welcome to the Introduction to Cloudant course, an eighteen part video series that gives you an overview of the IBM Cloudant databases-as-a-service.

This is part 5: "Authentication"

We said earlier that Cloudant is a web-based service on the public internet. How can we be sure that our data is safe and that only our code can access it? This is where authentication comes in.

Cloudant supports two types of authentication.

Legacy authentication is where a username or api-key and password are supplied with each request using HTTP Basic Authentication or exchanged for cookie, using a one-off session API call. A session cookies is cycled regularly, so you client code needs to capture the refreshed cookie and and store it for subsequent request.
IAM authentication is the access management system that underpins all of the IBM Cloud services. To authenticate with IAM, you need an IAM API key and the host name of the Cloudant service. The API key is exchanged for a bearer token using the IAM API and the bearer token is passed to Cloudant with each request. The bearer token only lasts for an hour, so must be renewed with the IAM service periodically.
When a Cloudant service is provisioned, you can generate IAM only credentials or both IAM and Legacy credentials - you decide.

How are credentials generated?

In the IBM Cloud dashboard under your Cloudant service, in the "Service Credentials" tab, click the "New Credential" button and a JSON document containing the IAM key and the basic auth username/password and the Cloudant hostname is created.

Here's an example set of credentials:

for IAM you need the top two bits: apikey & host
for Legacy/Basic-Auth you need the URL (which contains the username and password embedded in the URL)

There are three official Cloudant libraries: Java, Node.js & Python.

All three handle authentication automatically. You don't need to worry about how it exchanges the API key for a session token or how IAM authentication works - it is handled for you.

When we look at the API from the  IDs , we'll be using Basic Auth as a convenience, but it's recommended you use IAM authentication if possible as it allows better integration with the IBM Cloud platform and finer-grained permissions.

Time for our next practical exercise.

Log into the IBM Cloud and locate the IBM Cloudant Lite service we created last time. In the "Service Credentials" tab, click the "New Credential" button to generate a set of "IAM+Legacy" credentials. Make a note of the JSON it returns - we'll need that for the next exercise.

Then visit the URL specified in the credentials JSON - what do you see?

To summarise:

Credentials are generated from the IBM Cloud dashboard. You can have IAM or both IAM + legacy credentials. Both authentication methods involve exchanging your credentials for a time-limited token (authentication) - the token is then updated periodically as you use the service. The official libraries handle all of this for you.

That's the end of this part. The next part is called "The dashboard".

## The Dashboard video
{: #the-dashboard-video}

Learn about the {{site.data.keyword.cloudant_short_notm}} Dashboard and what it has to offer, as well as an introduction into how to use it. 

<div class="embed-responsive embed-responsive-16by9" data-hd-video="video">
<iframe class="embed-responsive-item" id="thedashboard" title="The Dashboard" type="text/html" width="560" height="315" src="https://youtube.com/embed/JxwiomhMKd8" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen> </iframe>
</div>

### The Dashboard video script
{: #the-dashboard-video-script}
{: script}
{: notoc}

Welcome to the Introduction to Cloudant course, an eighteen part video series that gives you an overview of the IBM Cloudant databases-as-a-service.

This is part 6: "The Dashboard".

The easiest way to get started creating databases and adding documents is to use the Cloudant Dashboard.

The Cloudant Dashboard is a web-app built into the service. It allows basic data manipulation to be performed through a graphical user interface: Databases can be created and deleted, documents added, updated and deleted and replication jobs managed. It is also a handy place to perform one-off queries and to set up secondary indexes (as we'll see later).

It also contains some simple monitoring tools that visualise request rates.

It's important to note that any task that is achievable in the Cloudant Dashboard is also possible with the Cloudant HTTP API - indeed, the Cloudant Dashboard is simply making standard API calls itself

To open a Cloudant service's Dashboard, log in to the IBM Cloud, find your Cloudant service and click Launch Cloudant Dashboard button. A new window will open, logging you into your Cloudant dashboard.

If you leave the dashboard window unattended for a length of time, you will find yourself logged out (for security purposes) and will have to click Launch again.

The dashboard has a number of tabs on the left side. Its default tab, "Databases" allows you to list the databases you have created in pages of 20. Each database is shown with the number of documents it is storing and how much disk space is being used. Click a database name to examine its contents.

To create a database, click the Create database button and supply the name of the database to create.

We now have a new empty database. The database's documents would be listed here in ID order, but as this is a new database, there are none. To add a new document, click Create Document.

The Cloudant dashboard has created a template document for you with a pre-generated _id. Complete the rest of the attributes yourself to complete the JSON document and click "Create Document" to save.

Now it's time for another practical exercise. Create a new database called "books" and in that database create three or more documents with fields: title, author, date, publisher, ISBN - each representing a book of your choice.

Once created, edit one of the documents, modifying the publication date.

Then delete one of the documents.

To summarise:

The Cloudant Dashboard is a web app app built into the Cloudant service and is part of the CouchDB open source offering.
It is used to manage databases, documents, indexes, queries and replication jobs.
It can also be used to monitor service throughput.
The Dashboard is simply an API client - anything that can be achieved with the dashboard can scripted by you using the HTTP API.

That's the end of this part. The next part is called "HTTP API Basics".

## HTTP API Basics video
{: #http-api-basics-video}

Learn how to use the command line to make HTTP requests and to add, edit, and delete documents. 

<div class="embed-responsive embed-responsive-16by9" data-hd-video="video">
<iframe class="embed-responsive-item" id="httpapibasics" title="HTTP API Basics" type="text/html" width="560" height="315" src="https://youtube.com/embed/1149M3qcLIw" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen> </iframe>
</div>

### HTTP API Basics video script
{: #http-api-basics-video-script}
{: script}
{: notoc}

Welcome to the Introduction to Cloudant course, an eighteen part video series that gives you an overview of the IBM Cloudant databases-as-a-service.

This is part 7: "HTTP API Basics".

In the previous part we saw the Cloudant dashboard which is a web app that is making HTTP calls to Cloudant's API. In this step we'll be using the command line to make HTTP requests and to try to add/edit/delete some documents from there.

It's worth understanding the HTTP API from first principles even if you intend to use the higher-level client libraries.

The advantage of a database having an HTTP API is that any device on the internet can read/write data if you want it to. No special software is required. No drivers speaking a custom protocol. Just an standard HTTP library. Everything speaks HTTP:

web browser
any programming language
command line scripting tools like curl
mobile devices
We're going to learn the API using curl, a free, open source command line tool that can dispatch HTTP requests. curl comes preinstalled on most Macs and Unix-like operating systems. If it's not present on your computer, google "curl" and follow the installation instructions.

Let's first use curl to fetch a web page - Google's home page.

In a command line terminal, type "curl https://www.google.com"

You should get a pageful of HTML in reply.

If this works, then you have curl installed and you can proceed with the next tasks.

Now we don't want to type the URL of our Cloudant service every time so let's save the Cloudant URL in an environment variable called URL.

export URL= creates a variable called URL which we can access later.

export URL=`https://username:password@host`
Furthermore, we can create an "alias" (a shortcut) called "acurl" which saves us further typing. This "acurl" command is an alias for curl but with the JSON content-type header and a couple of useful commmand-line switches.

alias acurl="curl -sgH 'Content-type: application/json'" 
We can test it by fetching "acurl $URL/" and we should get some JSON back from Cloudant.

Congratulations! You've just made your first Cloudant API call.

Now our acurl alias is set up, we can start exploring the API. Let's start with the _all_dbs endpoint which returns a list of databases.

Type acurl $URL/_all_dbs to see an array of databases.

A quick note here on formatting JSON on the command line. We can send the output of our acurl command to another tool which will format the data nicely on the terminal. There are are couple of options:

jq available from the URL on screen which is more than just a JSON formatter - it allows JSON to be parsed, queried and manipulated too.
or python -m json.tool is a simple JSON formatter, if you happen to have Python installed on your computer.
So acurl $URL/_all_dbs | jq means "pipe the output of acurl into jq" and what you see should be a nicely formatted, coloured output.

The Cloudant API paths are hierarchical with the top level giving you information about the service and then each database sits at a level below that.

So acurl $URL/books gives us information about the books database we created earlier.

You should see information about how many documents it has, how many deleted documents and how much disk space it's occupying.

Note: don't forget to pipe the output to jq or python to get a prettier output.

If we want to see the documents contained in the database we can use the _all_docs endpoint.

So acurl $URL/books/_all_docs means get all the documents from the books database from the Cloudant service at the supplied URL.

This will return you a list of _id and _rev values for each document. If you want the document bodies too, then add ?include_docs=true to your API call.

If we want to fetch a single document back from the database, then documents sit one level below the database in the hierarchy of the URL.

So acurl $URL/books/id means get get document ID from the database books from the Cloudant service at the supplied URL.

Notice the hierarchy: service / database / document

So far we've only used the "GET" HTTP method, which is the default one for curl and the one used when you enter a URL into your web browser.

Cloudant's API often uses the HTTP method as a "verb" to describe the action being asked of the database: GET for fetching data.

With curl we can specify the method we want to use with the -X command line option.

So to write a new document to our books database using the API, we're going to use the POST method, massing a document as the body of the HTTP request.

acurl -X POST specifies we're using the POST HTTP method. -d specifies the document we want to write, which is sent as the body of the request and finally the URL we are writing to which is $URL/books - the books database.

Alternatively we can use the PUT method, if we are supplying the ID of the document being written. The URL becomes "$URL/books/" followed by the ID we want  to write.

Both write methods yield identical response. OK: True to show that the write was successful. ID being the document ID written and rev being the revision token that was generated by the database.

To modify a document we can use the PUT method, writing the new body to the URL that points to the document ID we want  to overwrite. -d supplies the new document body and the URL not only contains the database and ID of the document, but critically the rev - the revision of the document we intend to mutate.

If we forget and omit the rev parameter we will get an error response.

Note: HTTP response codes tell you whether a request succeed or not. Responses in the 200 range are successful, 400s are user errors (e.g. invalid parameters) and 500s are server-side errors. You can see the full HTTP request and response by additionally supplying the -v command line option to curl/acurl.

Also note that updates to documents happen in their entirety or not at all, there's no API construct to modify part of a document. A whole document must be supplied to overwrite a previous revision.

Finally to delete a document we use the DELETE method, so -X DELETE. We direct the request to the URL that includes the database name and document to be deleted, and critically we also supply the rev - the revision of the document to delete.

If we omit the revision token, an error is returned and the request fails.

To summarise:

Understanding the HTTP API helps you grasp the relationship between your code and the Cloudant service.

The URLS are hierarchical: service/database/document or service/database/endpoint

The HTTP methods act as "verbs" defining the action to be done.

All actions can be triggered using simple HTTP API calls, from the command line or from your code and so can be easily scripted.

That's the end of this part. The next part is called "The Bulk API"

## The Bulk API video
{: #the-bulk-api-video}

Learn how to use two API calls to perform all the basic {{site.data.keyword.cloudant_short_notm}} operations while also acting on more than one document per API call.

<div class="embed-responsive embed-responsive-16by9" data-hd-video="video">
<iframe class="embed-responsive-item" id="thebulkapi" title="The Bulk API" type="text/html" width="560" height="315" src="https://youtube.com/embed/aNEXKIXMWLY" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen> </iframe>
</div>

### The Bulk API video script
{: #the-bulk-api-video-script}
{: script}
{: notoc}

Welcome to the Introduction to Cloudant course, an eighteen part video series that gives you an overview of the IBM Cloudant databases-as-a-service.

This is part 8: "The Bulk API".

In the previous part we saw how documents could be easily added updated, updated and deleted singly using the Cloudant HTTP API. In this part, we'll see how two API calls can be used to achieve all of the basic Cloudant operations, with the added benefit of being able to act on more that one document per API call.

We've already met the _all_docs endpoint - we used it to fetch a list of all the documents in a database, but it has other features too.

the key parameter can be used to specify a single document to fetch, making it equivalent of the GET /db/id API call.
similarly the keys parameter takes an array of document IDs and will return them all.
the startkey & endkey parameters allow you to fetch a slice of the primary index between the supplied limits. Adding include_docs=true instructs Cloudant to supply the document bodies too.
and limit allows you to specify how many documents to return in one API call.

The _bulk_docs endpoint allows multiple insert, update and delete operations to be performed in one API call. It expects an object containing a docs array - each element of that array being an operation to perform on a single document. The request body is posted to Cloudant, allowing many operations to be packed into a single API call.

In this example, the first document is an insert: we know this because no revision token is supplied. The second document is an update to a document because a revision token is supplied with a new document body. The third document is a deletion. A revision token is supplied, but the body is simply _deleted: true, which tells Cloudant to mark the document as deleted.

It's important to note that this isn't like a transaction in a relational database - all or none of these operations could succeed or fail individually. The response data to this request tells you the response for each operation in turn.

In summary

With two API calls _bulk_docs & _all_docs we can perform all create, read, update & delete operations on Cloudant documents and be able to do so in bulk too. _all_docs retrieves documents by _id or ranges of ids. _bulk_docs creates, updates & delete documents in bulk. As a rule of thumb, its recommended that bulk writes are executed in batches of 500; perhaps more than that for tiny documents and fewer than that for large documents.

Here's a screen capture of using Cloudant from a command line terminal:

That's the end of this part. The next part is called "Accessing Cloudant programmatically".

## Accessing Cloudant Programmatically video
{: #accessing-cloudant-programmatically-video}

Learn how to access {{site.data.keyword.cloudant_short_notm}} programmatically. 

<div class="embed-responsive embed-responsive-16by9" data-hd-video="video">
<iframe class="embed-responsive-item" id="accessingcloudantprogrammatically" title="Accessing Cloudant Programmatically" type="text/html" width="560" height="315" src="https://youtube.com/embed/1YdJKw7GhXY" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen> </iframe>
</div>

### Accessing Cloudant Programmatically video script
{: #accessing-cloudant-programmatically-video-script}
{: script}
{: notoc}

Welcome to the Introduction to Cloudant course, an eighteen part video series that gives you an overview of the IBM Cloudant databases-as-a-service.

This is part 9: "Accessing Cloudant programmatically".

So far, our API interactions have either been triggered by the dashboard or via curl from the command line. In this section we'll see how Cloudant be accessed programmatically.

The examples will use Node.js, so if you want to try the code yourself, you'll need to install node & npm from nodejs.org.

We can then install the official Cloudant Node.js library with npm install @cloudant/cloudant. (npm is the package manager that comes with Node.js - allowing you to access thousands of open source projects and build them into your application for free).

Once the cloudant library is installed we can build some source code. Let's go through this code snippet line-by line:

The URL of the Cloudant service is gleaned from the environment variable we created earler.

The @cloudant/cloudant library is loaded into your Node.js app with the built-in require function.
We then create an instance of the library configured with the credentials we stored in the first line.
We use the cloudant object to get a reference to the books database and store it in a variable db. At this point, we haven't made any API calls - only created data structures that store credentials and which database we are working on.
The main function calls db.list which maps 1-1 with the _all_docs endpoint we saw earlier. The parameters passed to db.list should be familiar as the options that _all_docs expects to limit the result set and to return document bodies for each id.

Here's another code snippet that writes a document.

You can see from the first line that standard JavaScript objects can be used in your code and sent to Cloudant with no conversion, as they turn into JSON natively in JavaScript.

Writing a document is a simply a matter of calling db.insert which will map to a PUT/POST API call or to _bulk_docs.

To summarise

There are official Cloudant libraries for Java, Python and Nodejs. They are thin wrappers around the Cloudant HTTP API - so it's worth understanding the underlying API to get to grips with all the parameters.

The libraries handle two things for you, which are really useful:

authentication - exchanging your keys for tokens, whether it be legacy authentication or IAM.
retry logic - the libraries can be configured to retry API calls that exceeded your provisioned capacity. If configured this way, they pause and re-attempt the API call multiple times with exponential back-off
Note: retrying such API calls is sensible if you have a temporary and unexpected elevation in traffic, but if you are routinely exceeding your provisioned capacity, no amount of retrying will get the database work done - you need more capacity!

That's the end of this part. The next part is called "Querying".

## Querying video
{: #querying-video}

Learn the different ways to query data in {{site.data.keyword.cloudant_short_notm}}.

<div class="embed-responsive embed-responsive-16by9" data-hd-video="video">
<iframe class="embed-responsive-item" id="querying" title="Querying" type="text/html" width="560" height="315" src="https://youtube.com/embed/x3SWtdzJfdU" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen> </iframe>
</div>

### Querying video script
{: #querying-video-script}
{: script}
{: notoc}

Welcome to the Introduction to Cloudant course, an eighteen part video series that gives you an overview of the IBM Cloudant databases-as-a-service.

This is part 10: "Querying".

So far we have performed CRUD (Create/Read/Update/Delete) operations from the command line, the dashboard and from code. These are operations centred on the document's _id:

fetch document by id
update document whose _id = 'x'
delete document whose _id = 'x'
get documents in the _id range 'a' to 'z'

These operations are the building blocks of a database but they only get you so far. What if you need to return a sub-set of documents matching on fields within the document. A person's birth date? A book's title? An order's value?

This is where Querying comes in....

There are several methods for querying data in Cloudant. The first we'll look at is called "Cloudant Query".

Cloudant Query's language was inspired by the MongoDB query language. Queries are expressed in JSON, where the "selector" attribute describes the subset of data to return. The query JSON is posted to the database's _find endpoint to perform a query.

The simplest form of query is finding documents where an attribute has a fixed value e.g. where author == J Smith.

The second example shows two clauses in the query, both of which must be satisfied for a document to make it into the search results. e.g. where isbn === 6725252 AND date = 2018-01-01

The third example shows how logical operators can be added. The '$gt' operation means "greater than" (there's also gte for greater than or equal to, and lt/lte for the equivalent less than comparators). The $or operator is an OR operation, so a matching document must have a date greater than the one in the query an either an author of J Smith OR title of Murder!.

Note: If you need to access objects within documents, you can use standard "dot notation" e.g address.zipcode to access a zipcode string inside an address object.

We can also add

fields - to specify the document attributes we want returned (the default is the entire document).
sort – to define how the data is to be sorted. Sort is an array, allowing the sort to be calculated on multiple attributes.
limit – the number of documents to return

If you are from a relational database background, this is the equivalent SQL query to that last Cloudant query example.

The WHERE clause is the equivalent of SELECTOR in Cloudant Query, ORDER and LIMIT are exactly equivalent and the Cloudant Query FIELDS list is equivalent to the comma-separated list of attributes after the SELECT keyword.

The JSON syntax may take a bit of getting used to, but MongoDB users should find it familiar.

Cloudant queries can be executed in the Cloudant Dashboard. Select the database you are working with e.g. books then choose the Query tab.

Enter your Cloudant Query JSON in the box provided and click Run Query when you're ready. The result set will appear on the rightmost panel.

Note: the Explain button is used to provide an explanation on how the database interprets the supplied query. This becomes more important when we get to Indexing in the next part.

Queries can also be triggered from curl too. The Query JSON, in this case, is stored in a file and POSTed to the _find endpoint using the -d@ command line syntax.

The Node.js code is very similar. The Query is a standard JavaScript object which is passed to the db.find function which it POSTs to the _find endpoint on your behalf.

Now time for a practical exercise. Devise your own Cloudant Query that finds the titles of books written in the 20th Century. The Cloudant Query documentation is at the on-screen URL if you need it.

Pause the presentation here if you don't want to know the answer...

Here's one solution:

I'm using the $and operator to combine two clauses on the date attribute. One clause to locate documents whose date >= 1900, the other to find documents whose date is < the year 2000. Both clauses have to be true to select a document. As we only need the title of the matching books, we can supply a fields attribute instead of being returned the entire document.

To summarise

Cloudant Query is a query language inspired by MongoDB where the syntax is expressed in JSON form.

Queries select subsets of documents from the database, using clauses operating on data inside the document - not just the document's _id.

Queries are sent to the database's _find endpoint, either programmatically, using curl or via the Dashboard.

The query's selector decides which cut of data is required,

That's the end of this part. The next part is called "Indexing"

## Indexing video
{: #indexing-video}

Learn how indexing can speed up your query process. 

<div class="embed-responsive embed-responsive-16by9" data-hd-video="video">
<iframe class="embed-responsive-item" id="indexing" title="Indexing" type="text/html" width="560" height="315" src="https://youtube.com/embed/SofWmZBfXKk" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen> </iframe>
</div>

### Indexing video script
{: #indexing-video-script}
{: script}
{: notoc}

Welcome to the Introduction to Cloudant course, an eighteen part video series that gives you an overview of the IBM Cloudant databases-as-a-service.

This is part 11: "Indexing".

The queries we executed in the previous part were not optimal: to get the answer, Cloudant had to spool through every document in the database in turn to see if it met with the search criteria.

To make queries run in a performant and scalable way, we need "Indexing".

Cloudant allows you to specify any number of "Indexes" (or, indices).

An index is a secondary data structure built from the document list. It contains data sorted by the fields you specify e.g. books sorted by date and title. If you perform a query asking for data matching a document's date & title, the indexed data structure can be used to speed up the query process: instead of scanning through every document in turn, Cloudant can jump to the relevant part of the index (say, the section on 20th century books) and retrieve the data much more quickly.

There are two types of Cloudant Query indexes: type=json & type=text, which are backed by two underlying indexing technologies we'll meet in subsequent parts of this course.

An index is defined by POSTing some JSON to a database's _index endpoint.

The index object contains a fields array which specifies which document attributes to index. As a rule of the thumb, the fields that need indexing are usually equivalent to the attributes used in the "selector" of a query you're going to use to retrieve the data. i.e. if you need to query by the date field, we need to index the date field.

Although the "name" of an index is optional, it's good practice and we'll follow this convention. It's good to ask Cloudant a question and specify the name of the index you intend it to use. This saves Cloudant from having to choose which index it should use from those available and it makes it easy for you to remember which index is which.

Let's create an index on our books database from the dashboard. Select the database, then choose the "Design Documents" tab and "Query Indexes" from the pop out menu.

Any existing indexes are listed on the right side: There should be a "special" index representing the primary index, based on the document's _id.

Complete the index definition with the JSON:

and click "Create Index" when you're done.

Clicking the button sends a POST request to the _index endpoint (other API calls are available to update and delete existing indexes).

Note: indexes are built asynchronously by Cloudant in the background. For large databases, it may take Cloudant some time to construct the index for the first time. The index will not be able to use until that initial build is ready.

We can repeat our query for books in the 20th century, this time specifying the index name with the use_index field and the answer should return, this time powered by our index. You may not notice a speed improvement for a very small database, but the benefit is definitely felt as your data size and query volume grows. Indexing helps your queries remain performant as your application scales.

When you tell Cloudant to create a secondary index, it starts a background task looking at all the documents in turn and creates a new data structure on disk: the index. The index is a balanced tree which pairs the keys (the attribute or attributes you need indexed) with the document _id they came from.

The index can be used to efficiently look up known keys and ranges of keys without having to rescan the entire database.

There is another trick that can be employed at index time: the partial filter. You may optionally supply a partial filter in your index definition, and this Cloudant Query selector will be executed at index time to decide which documents' data make it to the index and which are ignored.

In this example, a selector is employed that only allows dates that fall on a weekend to make it to the index. Smaller indexes are faster and more efficient, so if you have a use-case that only needs a subset of the data to be indexed, e.g. only completed orders, or only expired accounts, or only published blog posts, then a partial filter selector at index-time can help to make the index smaller and more efficient.

To summarise:

Indexing is used to speed up queries by using a pre-built data structure (the secondary index) to help look up keys and key ranges from values inside the document body more efficiently. Without an index, queries won't scale in a performant manner as data size and query volumes increase.

The _index endpoint is used to define the index and an optional partial filter can be applied at query time to make smaller, sparser indexes.

That's the end of this part. The next part is called "MapReduce".

## MapReduce video
{: #mapreduce-video}

Learn about MapReduce, which is another way to configure secondary indexes.

<div class="embed-responsive embed-responsive-16by9" data-hd-video="video">
<iframe class="embed-responsive-item" id="mapreduce" title="MapReduce" type="text/html" width="560" height="315" src="https://youtube.com/embed/EhX72EJh9PE" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen> </iframe>
</div>

### MapReduce video script
{: #mapreduce-video-script}
{: script}
{: notoc}

Welcome to the Introduction to Cloudant course, an eighteen part video series that gives you an overview of the IBM Cloudant databases-as-a-service.

This is part 12: "MapReduce".

We've seen how a combination of the _find and _index endpoints allows queries to be performed on the contents of JSON documents, backed by secondary indexes to make queries scale as your application grows.

In this part, we'll introduce another way of configuring secondary indexes called MapReduce.

MapReduce used to be the only way to configure secondary indexes in CouchDB and is still a popular way of querying data from within the document body.

To create a MapReduce index, you need to supply a JavaScript function wrapped in a special document called a design document to Cloudant. Design documents' _id fields begin with _design/ e.g _design/mydesigndoc.

When Cloudant receives the design document it will set up a background indexing task, passing each document from the database to your JavaScript function in turn: the key/values that are emitted by your JavaScript function form the basis of the index that is persisted.

Let's look at some example JavaScript functions on the right of the screen.

The function accepts one parameter - the document that is passed to it by the Cloudant indexer. Every time your function calls emit the parameters you pass form the key/value of the index.

The first example emits a key of doc.name, so this is an index for lookups by the name field and there is nothing (null) for the value.

The second example pre-processes the data before emitting. This is a useful way of tidying up strings, trimming whitespace, lower/uppercasing text, applying default values to missing data, or constraining values to certain ranges etc.

The third example adds logic: only documents that are "published" make it to the index. This is equivalent to the partial filter selector we saw with Cloudant Query.

Indexes build asynchronously and cannot be used until they have built completely. Once built, they can be used for selection by key, lists of keys, ranges of keys and can also be used for aggregation of data e.g. "find orders between two dates, and calculate the total value of the orders, grouped by month."

There are four built-in reducers (or five if you count "none").

_count - for counting things.
_sum - for totalising values.
_stats - for providing counts and totals suitable for calculating means, variances and standard deviations.
_approx_count_distinct - for approximate counting of unique values of the key.

The design document's MAP function is passed a "doc" - the function is called once per document in the database. Any key/value pairs "emit"ed from the MAP function create the index.

The KEY is the thing (or things) you want to "select" on (e.g. date).

The VALUE is the thing you need to report on (e.g. total sales).

The Reducer is _sum, so that the VALUE is totalled for matching keys (e.g orders on the same date).

Here's what defining a MapReduce looks like in the Cloudant dashboard.

When the MapReduce view is built, it can be queried to see each KEY/VALUE pair stored in the index.

Or, if the reducer is switched on result set can be grouped by the value of each key. Here we are totalising each day's sales.

The view can be queried for individual keys (e.g. sales on a given date), all keys, or a range of keys (e.g. between two dates).

MapReduce views are built asynchronously and may take some time to be ready for large data sets.

Here's some tips:

use if logic in your JavaScript to only include data that makes sense. e.g. only totalise completed orders.
indexed keys don't have to be strings. A common pattern is to use array keys e.g an array of year, month, day. This allows query-time grouping by elements in the array e.g. orders by year, orders by year & month, orders by year & month & day - great for summary reports that allow the user to drill down into the detail.
the value can by a string, number or sometimes a small object containing a sub-set of the document. The object can be used instead of adding include_docs=true which would also return the document's body in the result set.

To summarise:

MapReduce is a low-level means of defining indexes that allow the selection and aggregation of data.

Use JavaScript logic to decide which data makes it to the index. Choose how the index is formed by emitting keys/values.

Summarise data with the built-in reducers. Produce concise reports from lots of data very efficiently.

MapReduce is great for boilerplate queries that your application needs to do again and again. Not for one-off, adhoc-queries for data exploration.

That's the end of this part. The next part is called "Dates"

## Dates video
{: #dates-video}

Learn about different options for storing a date, or date and time value.

<div class="embed-responsive embed-responsive-16by9" data-hd-video="video">
<iframe class="embed-responsive-item" id="dates" title="Dates" type="text/html" width="560" height="315" src="https://youtube.com/embed/FqgqvMXMPbI" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen> </iframe>
</div>

### Dates video script
{: #dates-video-script}
{: script}
{: notoc}

Welcome to the Introduction to Cloudant course, an eighteen part video series that gives you an overview of the IBM Cloudant databases-as-a-service.

This is part 13: "Dates".

We saw earlier in this course that JSON only natively models strings, numbers, booleans, objects & arrays. A common use-case is to store a date or date/time value in a database. Here's some ideas on how that can be achieved with Cloudant.

The ISO-8601 string format for representing a time time consists of a y-m-dTh:m:s.msTIMEZONE year, month, day, a 'T' character, hour, minute, second, millisecond and time zone .

I always recommend storing dates in the UTC time zone  even if collecting data from different geographies. Date stored in this form can easily be transformed into the local time zone  at the front end, but it's usually important to store each user's data in the "same units".

This string format sorts into date/time order (because the most significant date units are at the front of the string) and can be easily parsed in MapReduce functions

Another option is to store the number of milliseconds since 1970-01-01. This too is a standard, machine-readable way of representing a date & time.

It too can be parsed in MapReduce functions and is very handy for comparing two dates: simply take one timestamp from another.

The third option is to store each date/time component in separate fields. This is more verbose than the previous options but has one key advantage if you're using Cloudant Query. Because Cloudant Query can only act upon data in the form it exists in the document itself, if you need to query on a single date component e.g the month, then you'd need that item broken out in the document.

To summarise:

There's no native date format in JSON so you can store dates and times how you like. ISO-8601 is compact, readable and sorts nicely. As does a timestmp (milliseconds since 1970).

If you need to use Cloudant Query on one of the component parts, then that would need to be broken out explicitly in the document.

That's the end of this part. The next part is called "Replication".

## Replication video
{: #replication-video}

Learn what replication means in {{site.data.keyword.cloudant_short_notm}}, as well as different types of replication and how they work. 

<div class="embed-responsive embed-responsive-16by9" data-hd-video="video">
<iframe class="embed-responsive-item" id="replication" title="Replication" type="text/html" width="560" height="315" src="https://youtube.com/embed/vt-bsuKvVJI" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen> </iframe>
</div>

### Replication video script
{: #replication-video-script}
{: script}
{: notoc}

Welcome to the Introduction to Cloudant course, an eighteen part video series that gives you an overview of the IBM Cloudant databases-as-a-service.

This is part 14: "Replication".

Replication is a core feature of Cloudant. It is the transfer of data from one database (the source) to another (the target).

The source and target databases can reside on the same Cloudant service, or be geographically separated, for example a US Cloudant database replicating to one in Europe.

The Cloudant replication protocol is shared with Apache CouchDB, so replication is often used by enterprises copying data from a cloud-based database to one running CouchDB in their own premises.

PouchDB, a JavaScript-based CouchDB clone that runs in Node.js stacks or in the web browser can also be used to replicate data to or from Cloudant and/or CouchDB.

And there are the Cloudant Sync libraries, which allow native iOS or Android apps to sync data to and from a Cloudant service.

Replication is a one-way operation from source to target which moves all data (deletions, conflicts, attachments as well as documents) and can be triggered in one of two ways:

to run until all the data from the source has reached the target and then stop, or
the same as one but to keep the replication running continuously forever, transferring new data from the source to the target as it arrives.
Replication can also be resumed from where it last left off. Cloudant keeps a note of "checkpoints" between replicating parties to allow the resumption of a pre-existing replication from its last known position.

There is a replication tab in the Cloudant dashboard. A replication is started by specifying the source & target databases including authentication credentials, and whether this is a one off or continuous operation.

A replication can also be given a name, which is handy for tracking which replication job is which.

Now it's time for a practical exercise.

From your Cloudant dashboard:

create a new database called books2
start a continuous replication from books --> books2
visit the books2 database to check that documents from books is now in books2
add a document to the books database - check the change makes it to the books2 database

Replication can be used to move data from a Cloudant database to an on-premise CouchDB instance. The replication can be controlled by the Cloudant or the CouchDB end i.e you can ask Cloudant to send its changes to CouchDB or you can ask CouchDB to pull the changes from Cloudant. Bear in mind that the replication controller must have network visibility of both HTTP APIs.

PouchDB also speaks the same replication protocol so can be used to transfer data to and from PouchDB & Cloudant. It's most likely that PouchDB would be the replication controller in this case.

PouchDB is commonly used to create offline first apps which collect data even when not connected to the internet and then write data to Cloudant when they come back online, giving their users an always on service.

Bear in mind that replication may not always be required. If your application needs to store data and then write it to Cloudant later, then replication isn't strictly speaking required. All that is required is that data is stored on the device and bulk written to Cloudant when the connection is restored.

As replication is a one way operation, if a master-master setup is required between two Cloudants in different regions, then two replications in opposite directions are required.

Changes occurring on the London side are sent to Dallas, and vice versa.

More complex topologies are possible, with data flowing in a ring around a set Cloudant services.

To summarise:

Cloudant replication is a mechanism for copying data from a source database to a target database.

Replications can be one-off or continuous and can optionally be filtered with a JavaScript function or Cloudant Query selector and can be resumed from where a previous replication left off.

That's the end of this part. The next part is called "Partitioned Databases".

## Partitioned Databases video
{: #partitioned-databases-video}

Learn how partitioned databases works in {{site.data.keyword.cloudant_short_notm}}, how to assign documents to specific shards, and why partitioned databases improve performance, cost, and scalability. 

<div class="embed-responsive embed-responsive-16by9" data-hd-video="video">
<iframe class="embed-responsive-item" id="partitioneddatabases" title="Partitioned Databases" type="text/html" width="560" height="315" src="https://youtube.com/embed/cniDi-j3F-4" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen> </iframe>
</div>

### Partitioned Databases video script
{: #partitioned-databases-video-script}
{: script}
{: notoc}

Welcome to the Introduction to Cloudant course, an eighteen part video series that gives you an overview of the IBM Cloudant databases-as-a-service.

This is part 15: "Partitioned Database".

We haven't discussed this yet, but Cloudant is a distributed database. There are many storage nodes that make up a Cloudant service and a database's documents are distributed across the nodes in groups called "shards". A single database is said to be "sharded" or divided into multiple pieces.

In a normal Cloudant database, a document is allocated a shard algorithmically - effectively documents are distributed around the the shards randomly.

In a partitioned database, you define which shard the documents are stored in by supplying a partition key.

Partitioned databases are created with the same PUT /<database name> API call but with an additional query string parameter: partitioned=true

In the first example the products database is created as a partitioned database, in the second example as a standard, un-partitioned database.

When adding documents to a partitioned database you must supply a document _id - (there are no auto-generated document _ids). A document _id has two parts, separated by a colon character:

the partition key - a string which defines on which partition to store the document.
a document key - a string that uniquely identifies a document within the partition.
In the top example a book is being added into the book partition of the products database.

Then another document is being added into the dvd partition and a third into the household partition.

The effect of this is that documents sharing a partition key reside in the same shard of the databases. Documents in the same partition are stored together in document key order.

The advantage comes when retrieving data. We can direct Cloudant Queries, MapReduce requests and searches at a single partition. In this example, a Cloudant Query selector is being sent to the book partition. This has the effect of only exercising a fraction of the Cloudant infrastructure (only the shard that hosts the book partition are used, the rest of the cluster remains idle).

This makes for faster query performance, cheaper query costs and better scalability.

The key to great partitioned query performance is the choice of partition key:

It needs to be a value that repeats within your data set i.e. there a several items in the book partition.
There needs to be many partitions. If there are only a handful of categories, then category is a bad choice of partition key. It needs to be something that has many values e.g. deviceId in an IoT application or orderId in an e-commerce system.
It needs to match the queries that your application is making. If the most common use-case is searching within a product category, then partitioning by category may be a good fit.
Avoid hot partitions - traffic should be evenly spread across your partitions. If your choice of partition key is likely to lead to much more traffic hitting a small number of partitions, then this makes for a poor choice of partition key.

To summarise

Partitioned databases are created with the partitioned=true flag and documents have a two part ID where the partition key and document key are joined by a colon character.

Documents in the same partition are stored in document key order in the same database shard. Knowing this, we can make queries directed at a single partition that run faster and more cheaply.

Note: it's still possible to query across partitions in a partitioned database. When creating a secondary index, you choose whether its purpose is for per-partition or global scope.

That's the end of this part. The next part is called "Cloudant Search".

## Cloudant Search video
{: #cloudant-search-video}

Learn how to use Cloudant Search, as well as Lucene query language and faceting. 

<div class="embed-responsive embed-responsive-16by9" data-hd-video="video">
<iframe class="embed-responsive-item" id="cloudantsearch" title="Cloudant Search" type="text/html" width="560" height="315" src="https://youtube.com/embed/ZDS9Hr-_x8g" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen> </iframe>
</div>

### Cloudant Search video script
{: #cloudant-search-video-script}
{: script}
{: notoc}

Welcome to the Introduction to Cloudant course, an eighteen part video series that gives you an overview of the IBM Cloudant databases-as-a-service.

This is part 16: "Cloudant Search".

There is another method of querying and indexing in Cloudant called Cloudant Search which we'll briefly explore in this part.

Cloudant Search is built on another open source project, Apache Lucene, which powers the search capabilities of many products including ElasticSearch.

It is primarily designed for free text search, where blocks of text are pre-processed before being indexed: removing case, punctuation, common noise words and trimming common language-specfic word endings e.g. farmer becomes farm and farms becomes farm.

This text-processing is performed by a choice of analyzers at query time, prior to searching.

It also allows some aggregation functionality using a technique called faceting as we'll see.

A Cloudant Search index is created by supplying JavaScript function, not unlike MapReduce except this time the emit function is replaced by an index function, which expects the name of the field, the data itself and some options.

In this example, the document's name and title are indexed with default options. The category is nominated for faceting (the aggregation functionality) and the isbn is stored in the index but not indexed for search itself. Sometimes it is more efficient to store some items in the index rather than doing include_docs=true at query time.

Lucene has its own query language allowing you to create queries that match combinations of clauses with logic, fuzzy matching, ranges and term boosting.

Here are some examples:

Find documents whose title matches 'gastby' and whose author starts with 'fitz'. Notice the asterisk wildcard.
Find documents whose author is in the range austen --> dickens. This is an example of range querying on a string field.
Find documents whose price is between 0 and 100 AND whose year is in the 19th century or whose author matches "charles dickens". This shows how logic can be built into queries.
Cloudant Search is useful not only for free-text search, but for when you know which attributes you are going to search on, but the queries are varied, with different combinations of attributes each time. This flexibility is difficult to implement with fixed-order MapReduce indexes.

Faceting is a form of aggregation. You nominate individual indexed fields for faceting at index-time and activate the aggregation with parameters at query-time.

It has two uses:

Counting repeating values in the result set, such as the counts of products that belong to each category in a result set. or,
Counting numbers of items in numeric ranges, such as the product counts in each of the price ranges.
Both of these forms of counts can be presented to a front-end user as a means of further filtering an existing search, to narrow the scope of the search. e.g a customer searches for Fender, then clicks on Amps then on a price range under $500. All of this search and filtering can be powered by Cloudant Search.

To summarise:

Cloudant Search indexes are defined with a supplied JavaScript function. They are built on Apache Lucene and are primarily used for free-text search matching, but the query language is useful for building flexible queries on a fixed set of indexed fields. It also has some powerful counting aggregations suitable for drill-down user interfaces.

Note: Cloudant Search also powers 'type=text' Cloudant Query indexes, so a subset of its capabilities is surfaced using the _find API.

That's the end of this part. The next part is called "Geospatial".

## Geospatial video
{: #geospatial-video}

Learn how to use geospatial indexes to query data, which are unique to {{site.data.keyword.cloudant_short_notm}}. 

<div class="embed-responsive embed-responsive-16by9" data-hd-video="video">
<iframe class="embed-responsive-item" id="geospatial" title="Geospatial" type="text/html" width="560" height="315" src="https://youtube.com/embed/uP9bIHweP4c" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen> </iframe>
</div>

### Geospatial video script
{: #geospatial-video-script}
{: script}
{: notoc}

Welcome to the Introduction to Cloudant course, an eighteen part video series that gives you an overview of the IBM Cloudant databases-as-a-service.

This is part 17: "Geospatial".

The final means of querying data in Cloudant is using geospatial indexes.

Geospatial indexes are unique to Cloudant - you won't find them in the CouchDB codebase.

Data is stored as GeoJSON in the Cloudant database to describe point, line, polygon, multi-point, multi-line and multi-polygon objects. Each object, as well as the geographic information, can have optional properties: meta data about the object which are returned in the search results.

Again an index is defined as a JavaScript function and then queries can be used ask questions of your collection of geographic features e.g. find me the nearest object to this point, find objects within this polygon, find objects along this path, find objects that intersect with this object.

To summarise

Cloudant Geo is something unique to the Cloudant service and is used to perform advanced geospatial queries against your databases of GeoJSON objects. It cannot be combined with other index types so is only of use to Geographic Information Systems or use-cases that have a purely geographic purpose.

That's the end of this part. The next part is called "Under the hood"

## Under the hood video
{: #under-the-hood-video}

Learn how the {{site.data.keyword.cloudant_short_notm}} service is organized. 

<div class="embed-responsive embed-responsive-16by9" data-hd-video="video">
<iframe class="embed-responsive-item" id="underthehood" title="Under the hood" type="text/html" width="560" height="315" src="https://youtube.com/embed/h_DqYJpUmGQ" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen> </iframe>
</div>

### Under the hood video script
{: #under-the-hood-video-script}
{: script}
{: notoc}

Welcome to the Introduction to Cloudant course, an eighteen part video series that gives you an overview of the IBM Cloudant databases-as-a-service.

This is part 18: "Under the hood".

Let's take a look at how a Cloudant service is organised: this overview applies to the Cloudant services that map to CouchDB 2 & 3. CouchDB 4 will be built on different technology.

Cloudant is a distributed database with data stored around a cluster of storage nodes. Picture the Cloudant service as ring of nodes, in this case twelve. Every node can deal with incoming API calls and every node has responsibility for storing some of the data: shards and associated secondary indexes of databases that exist in the cluster.

When data is written to Cloudant one of the nodes in the ring will handle the request: it's job is to instruct three copies of the data to be stored in three storage nodes. Data is stored in triplicate in Cloudant, so each shard of a database is stored multiple times, often across a region's availability zones.

When you make an API call to write data and get a response back, we have written the data to at least 2 of the 3 storage nodes. Data is flushed to disk - it isn't cached in memory to be flushed data. We consider that technique too risky and prone to data loss.

When you create a database, a number of database shards are created (16 by default) which are spread around the cluster. As there are 3 copies of each shard, that's 48 shard copies.

You don't see any of this - it's handled for you transparently when you create a database.

What happens if a node goes down or needs to be rebooted for maintenance? The rest of the cluster continues as normal. Most shards still have three copies of data but some will only have two. API calls will continue to work as normal, only two copies of the data will be written.

Even if two nodes go down, most shards will still have three copies, some will have two and some will have one. Writes will continue to work, although the HTTP response code will reflect that the quorum of 2 node confirmations wasn't reached.

It's the same story for reads. Service continues with a failed node. We can survive one failed node...

Or more failed nodes. As long as there is a copy of each node in existence, the API should continue to function.

When a node returns, it will catch up any missed data from its peers and then return into service, handling API calls and answering queries for data.

The nature of this configuration where any node can handle a request and data is distributed around nodes without the sort of locking you would see in a relational database, is that Cloudant exhibits eventual consistency:

Cloudant favours availability over consistency: it would rather be up an answering API calls, than be down because it can't provide consistency guarantees. (a relational database is often configured in the opposite way: it operates in a consistent manner or not at all).
The upshot of this as a developer is that your app should not "read its writes" in a short period of time - there may be a small time window in which it is possible to see an older version of a document than the one you just updated. Eventually the data will flow around the cluster and in most cases, the quorum mechanism will provide the illusion of consistency, but it is best not to rely on it.
Note in CouchDB 4, and in Cloudant services based on that code version, a different consistency model will be employed.

If your data model requires you to update a document over and over in a short time window, it's possible that multiple writes for the same revision number are accepted leading to a branch in the revision tree - known as a conflict. In this example revision "2" was modified in two diffent ways, causing 2 revision 3s. It's possible to tidy up conflicts programmatically, but they should be avoided as they can cause performance issues in extreme circumstances.

Conflicts can also happen when using replication and a document is modified in different ways and then the conflicting revisions are merged in via replication. Cloudant does not throw away data in this scenario - a "winning" revision is chosen, but the non-winning revisions can be accessed and your application can resolve the conflict by electing a new winner, deleting unwanted revisions or any action you need. A conflict is not an error condition, its a side effect of having disconnected copies of data that can be modified without locking - Cloudant chooses to handle this by not discarding clashing changes, but storing them as a conflict.

To check a document for conflicts, simply add ?conflicts=true to a fetch of a single document. Any conflicting revisions will be listed in the _conflicts array.

Unwanted revisions can be removed using the normal DELETE operation, specifying the rev token of the revision you want to delete. The bulk API is also good for removing conflicting revisions, even for removing multiple conflicts from the same document.

To summarise

Cloudant is a distributed service which stores databases which broken into multiple shards, with three copies of each shard spread around a ring of storage nodes. Cloudant is eventually consistent, favouring high availability over strong consistency.

Avoid writing to the same document over and over so as not to create conflicts, although conflicts are sometime inevitable in replicating situations.

Embrace eventual consistency - don't try and make Cloudant consistent.

Note: Cloudant products based of CouchDB 4 may have a different consistency model.

That's the end of this course. For more information, consult our documentation and our blog.