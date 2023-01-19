---

copyright:
  years: 2015, 2023
lastupdated: "2023-01-11"

keywords: videos, document video, _id video, rev token video, authentication video, dashboard video, http api basics video, bulk api video, accessing cloudant programmatically video, querying video, indexing video, mapreduce video, dates video, replication video, partitioned database video, cloudant search video, geospatial video, under the hood video

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# Learning Center
{: #learning-center}

The {{site.data.keyword.cloudantfull}} Learning Center offers a video series to help you learn to use {{site.data.keyword.cloudant_short_notm}}. The videos start with the basics of using {{site.data.keyword.cloudant_short_notm}}. Then the videos walk you through document structure, the API, indexing and querying, and include an *Under the Hood* topic that highlights the architecture that powers the service.
{: shortdesc}

You can use the [playlist](https://www.youtube.com/embed/playlist?list=PLzpeuWUENMK3F93hGaS4ezGmlX4Bipt4S) to go through the courses, or navigate directly to the topic of your choosing.

## Introduction to {{site.data.keyword.cloudant_short_notm}} video
{: #cloudant-course-intro-video}

Learn about the {{site.data.keyword.cloudant_short_notm}} 18-part video series that provides an overview of the {{site.data.keyword.cloudant_short_notm}} database-as-a-service. 

![Introduction to {{site.data.keyword.cloudant_short_notm}}](https://www.youtube.com/embed/P9dFZaKAhIo){: video output="iframe" data-script="#cloudant-course-intro-video-script" id="Introduction to IBM Cloudant video" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen}

### Introduction to {{site.data.keyword.cloudant_short_notm}} video script
{: #cloudant-course-intro-video-script}
{: notoc}

Welcome to the Introduction to {{site.data.keyword.cloudant_short_notm}} course, an 18-part video series that gives you an overview of the {{site.data.keyword.cloudant_short_notm}} database-as-a-service.

This video is part 1 - *What is {{site.data.keyword.cloudant_short_notm}}?*

{{site.data.keyword.cloudant_short_notm}} is a database, run as a service in the {{site.data.keyword.cloud}}. Its job is to store your application's data securely and make it possible for you to retrieve it quickly and efficiently. {{site.data.keyword.cloudant_short_notm}}'s key features are shown in the following list:

Database
:   Stores and retrieves data. More specifically, it is a JSON document store. JSON comes from JavaScript and represents simple objects in a universal file format. 

"Document"
:   The unit of storage in {{site.data.keyword.cloudant_short_notm}}. Documents are added, updated, and deleted in their entirety.

HTTP API
:   Any {{site.data.keyword.cloudant_short_notm}} operation can be achieved by using HTTP. HTTP is the protocol that powers the World Wide Web and {{site.data.keyword.cloudant_short_notm}} is a database that is built for the web. Most databases are hidden in a private network, inaccessible but to a handful of machines. The {{site.data.keyword.cloudant_short_notm}} service sits (mainly) on the public internet where it can be accessed by anyone with an internet connection (and permission to do so).

{{site.data.keyword.cloudant_short_notm}} wasn't written entirely by IBM. It is based on Apache CouchDB, an open source project run by the Apache Foundation. {{site.data.keyword.cloudant_short_notm}} employs a number of CouchDB contributors but by the rules of Apache, they cannot monopolize its development.

Much of what you see that is in this course is as applicable to Apache CouchDB as it is to {{site.data.keyword.cloudant_short_notm}}. Their APIs are 99% the same - I point out where they diverge.

{{site.data.keyword.cloudant_short_notm}} can be thought of as CouchDB run "as-a-service". An {{site.data.keyword.cloudant_short_notm}} service is easily deployed and is managed by IBM engineers 24-7. The service has no software to install, no servers to manage, no configuration to understand. The user doesn't need to be a CouchDB expert to use and manage it.

You can be sure that your data layer is not locked in to a particular platform, cloud, or vendor because {{site.data.keyword.cloudant_short_notm}} is being built on truly open source foundations. {{site.data.keyword.cloudant_short_notm}} can be used in concert with CouchDB to create hybrid applications that share data through replication, as we see.

Later on in the course we look *under the hood* to see how {{site.data.keyword.cloudant_short_notm}} works, but initially we treat {{site.data.keyword.cloudant_short_notm}} as a "black box".

To summarize, Cloudant is based on Apache CouchDB, an open source project. It stores JSON documents. It is accessed with an HTTP API and can therefore be accessed by any device on the internet that speaks HTTP: application code, web browser, IoT device, or mobile phone. {{site.data.keyword.cloudant_short_notm}} is a highly available managed service able to continue to operate with multiple hardware failures.

That's the end of this part. The next part is called *The Document*.

## The Document video
{: #the-document-video}

Learn about {{site.data.keyword.cloudant_short_notm}} databases and documents work. 

![The Document](https://www.youtube.com/embed/zlfPQ5cl2Zo){: video output="iframe" data-script="#the-document-video-script" id="The Document video" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen}

### The Document video script
{: #the-document-video-script}
{: notoc}

Welcome to the Introduction to {{site.data.keyword.cloudant_short_notm}} course, an 18-part video series that gives you an overview of the {{site.data.keyword.cloudant_short_notm}} database-as-a-service.

This video is part 2 - *The {{site.data.keyword.cloudant_short_notm}} Document*.

In the previous section, we saw that {{site.data.keyword.cloudant_short_notm}} is a JSON document store. Let's find out what that means in practice and how that compares to other types of database.

Most databases store their data in collections that are called tables, where each unit of data is a row, each with identical, fixed columns. The schema of each table is predefined: a list of columns with their name, date type, value constraints, and relations to other tables carefully defined. Each new record forms a row in a table.

{{site.data.keyword.cloudant_short_notm}} is different!

An {{site.data.keyword.cloudant_short_notm}} service includes collections that are called databases (instead of tables) each of which contain any number of documents.

The example of this slide shows the same data that is expressed in a traditional tabular database and how the same data would be stored in {{site.data.keyword.cloudant_short_notm}} as JSON documents.

So if you come from a relational database background: tables are "databases" in {{site.data.keyword.cloudant_short_notm}}, and rows are "documents".

An {{site.data.keyword.cloudant_short_notm}} document must be a JSON object, starting and ending with curly braces and containing a number of key-value attributes.

JSON objects must be less that 1 megabyte in size and contain any number of strings, numbers, booleans, arrays, and objects. The nesting of objects within objects can continue to any depth.

The keys that are used can be as brief or verbose as you like.

The following list includes some simple example documents that show how each data type is used.

- The first example shows a person object, storing strings, booleans, and an array of tags.
- The second example shows brief attribute names to save on storage and represents a web event such as click a website.
- The last example shows how the document may itself contain subjects.

A note on dates. JSON has no native Date type, so dates are usually stored in 30-October-2018 or similar formats. We return to dates later.

Now, for your first practical exercise, visit www.ibm.com/cloud. Register an account with the {{site.data.keyword.cloud_notm}}, if you don't have one already.

Once registered, you can click **services**, search for the **Cloudant** database, and provision a new service.

The {{site.data.keyword.cloudant_short_notm}} `Lite` service provides a free plan to allow users to try {{site.data.keyword.cloudant_short_notm}} in a limited capacity while in development. Its bigger brother, the `Standard Plan`, is a paid-for service where you specify the number of reads, writes, and queries per second for your application and that capacity is reserved for you. You pay for the capacity you provision and your data storage usage.

The Lite plan operates in a similar way. It has only a small provisioned capacity and a fixed storage size, but it's fine for testing the {{site.data.keyword.cloudant_short_notm}} service.

{{site.data.keyword.cloudant_short_notm}} is often referred to as a "schemaless" database - but we have to be careful how we define that term.

It's true to say that you don't need to define your schema (field names, types, constraints, and relationships) ahead of time in an {{site.data.keyword.cloudant_short_notm}} database. You can simply write a JSON document of your own design to a database.

Developers like this flexibility because they can design their data in their code, turn it into JSON, and write it to the database.

It's still important to think about the *shape of your data*, especially in terms of how you are going to query and index it, as we see later.

Data design is still required, but strictly speaking that database doesn't need to know about your schema.

Let's say we want to create a database of US presidents. We can simply devise our "model" of the data in our app, turn it into JSON, and write it to the database. In this case, we are using a common CouchDB convention: the "type" field indicates the data type of the document.

If at a future date we decide we want to add more data to our "schema", we can simply write a new object to the database with no complaints from {{site.data.keyword.cloudant_short_notm}}. We could decide to add the "address" object only to the following documents:

- Documents that are created from now on.
- Only documents that we have addresses for.

In other words, documents of the same type can have fields present or missing.

Your database's schema can evolve over time to match your application's needs. You don't (necessarily) need to tell the database about the schema change - write new documents in the new format.

We can even store multiple document "types" in the same database. In this case, people, books, and places reside in the same database. We know which is which because of the "type" field (this field is a convention and not something that means anything to {{site.data.keyword.cloudant_short_notm}}).

An alternative to this configuration is to have three databases people, books, and places and keep each data type in its own database. Both approaches are fine. You can choose to have multiple types together in the same database if you need to perform queries across types or if you need to replicate all data types together. Otherwise, the separate databases approach might be better.

To summarize, although {{site.data.keyword.cloudant_short_notm}} is "schemaless", this fact doesn't absolve you of the need to do detailed data design to get the best performance.

These tips are especially relevant if you have some relational database experience.

- Avoid thinking in joins - an {{site.data.keyword.cloudant_short_notm}} document must contain everything that you need about that object so that it can be retrieved in one API call.
- Normalization goes out of the window in JSON store, some repeated values can be tolerated if it makes data retrieval more efficient.
- Although we have a 1 MB limit on document size, your documents must be much smaller - a few KB is typical.
- If your application can embrace a "write only"* design pattern, where data is only ever added to a database, then it can make your life easier. You must definitely avoid patterns that rely on updating the same document over and over in a small time window.

That's the end of this part. The next part is called *The Document ID*.

## The `_id` video
{: #the-id-video}

Learn how `_id`s work in {{site.data.keyword.cloudant_short_notm}}, how they are different from relational databases, and how you can define your own `_id`. 

![The _id](https://www.youtube.com/embed/y_L8r_knq8U){: video output="iframe" data-script="#the-id-video-script" id="The _id video" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen}

### The _id video script
{: #the-id-video-script}
{: notoc}

Welcome to the Introduction to {{site.data.keyword.cloudant_short_notm}} course, an 18-part video series that gives you an overview of the {{site.data.keyword.cloudant_short_notm}} database-as-a-service.

This video is part 3 - *The Document `_id`*.

In the previous section, we saw how data is stored in {{site.data.keyword.cloudant_short_notm}} documents with flexibility on how your application stores JSON objects in {{site.data.keyword.cloudant_short_notm}} databases. However, a few hard and fast rules exist.

One rule is that every document must contain a unique identifier that is called `_id`, which is a string. Two documents in the same database can have the same `_id` field. In other databases, you specify which column is the unique identifier, but in {{site.data.keyword.cloudant_short_notm}}, it's always `_id` and can't be changed.

Also, unlike relational databases, {{site.data.keyword.cloudant_short_notm}} does not have "auto-incrementing IDs" that is, an ID field that starts at 1 and increments for each document added.

{{site.data.keyword.cloudant_short_notm}}'s `_id` field is one of the following strings:

- A 32-character string generated by {{site.data.keyword.cloudant_short_notm}}. The ID is a meaningless sequence of numbers and letters that are guaranteed to be unique.
- A string that is defined by you (if you know something unique about your data).

The following examples show how to supply your own document `_id`:

Using it to store something that you know is unique that is, the email address of a user. Your registration mechanism can enforce a one-user-per-email address policy.
Some users choose to encode the document type in the `_id`, for example, `user:56`, `book:55`.
The last example shows with a 32-digit string (generated in your app) that is designed to sort in approximate date and time order. This method makes it easy to retrieve the latest documents from the database, without a secondary index.

{{site.data.keyword.cloudant_short_notm}} takes your document `_ids` and stores them in an index (like the contents page of book). This primary index is in `_id` order and is used to allow {{site.data.keyword.cloudant_short_notm}} to retrieve documents by their `_id` - thus behaving like a key-value store.

By careful design of your `_id` field, you can make it use the primary index to keep data together that makes sense in the primary index. This method makes it quicker to retrieve that data later. We saw that using time-sortable `_ids` means that data can be retrieved in approximate date and time order.

We see an example later when it comes to retrieving ranges of document IDs.

In conclusion, each document must have an `_id` field that is unique in the database. It can be auto-generated by {{site.data.keyword.cloudant_short_notm}}, or can be supplied by your application, in which case you must take responsibility for the uniqueness of the `_id` field.

The `_id` field is the basis of the database's primary index, which, as we see later, can be used for key-value lookups and range queries.

That's the end of this part. The next part is called *The rev token*.

## The rev token video
{: #the-rev-token-video}

Learn how {{site.data.keyword.cloudant_short_notm}} creates a revision token when you add, edit, or delete a document. 

![The rev token](https://www.youtube.com/embed/T14voAppUl0){: video output="iframe" data-script="#the-rev-token-video-script" id="The rev token video" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen}

### The rev token video script
{: #the-rev-token-video-script}
{: notoc}

Welcome to the Introduction to {{site.data.keyword.cloudant_short_notm}} course, an 18-part video series that gives you an overview of the {{site.data.keyword.cloudant_short_notm}} database-as-a-service.

This video is part 4 - *The rev token*.

The second fundamental {{site.data.keyword.cloudant_short_notm}} rule is that each document revision is given its own unique revision token. Let's find out what it means.

You never need to generate a revision token - one is created for you when you add, update, or delete a document that uses the API.

A revision token consists of two parts:

A number 1, 2, 3, and so on, and
a cryptographic hash of the document's body.
(For the uninitiated, a hash is a digital "fingerprint" of some data. If the data changes, the fingerprint changes. No 2 fingerprints are the same, that is, no 2 documents with different content can have the same hash.)

You can see from the example on the right that our document has a revision token (the key that starts `_rev`) that starts with a `1` followed by a dash. That indicates that this revision is the first revision of the document. The digits that start 04aa8... are the cryptographic hash of the document.

If we follow the lifecycle of a document, it starts with a `revision 1`. When it is modified later, it gets a `revision 2` and so on. With each incrementing revision number, the hash changes because the content of the document is being modified too.

It is possible for a document to have more than one revision with the same number. In this case, two `revision 3s` exists. This scenario is called a *conflict* and is "normal" in some circumstances. We see why later in the course, but for now, we can assume that the revision number increments with each update to a document.
{: note}

Let's follow the lifecycle of an example {{site.data.keyword.cloudant_short_notm}} document:

When a new document is created (whether with an auto-generated `_id` or user-supplied `_id`), it is allocated a `revision 1`. You are sent the token in the response to your API request. Normally, you can discard the rev (unless you intend to modify the document soon).

When we modify a document whose `_rev` is at `revision 1`, the document is saved and a `revision 2` token is generated and returned to you in the API response. Notice that we change the name in the document from Liz to Elizabeth.

All simple enough so far.

If we delete the document later, a `revision 3` is created.

Unlike almost any other database, {{site.data.keyword.cloudant_short_notm}} keeps a reference for deleted documents. A deletion is just another document revision - a special one where `_deleted: true` replaces the document body.

In fact, the document's recent revision history (the tree of revisions - remember we could have more than one of each revision number) - is kept.

You can't use {{site.data.keyword.cloudant_short_notm}}'s revision tree as a version control system to retrieve or *roll back* to an older revision. Once a revision is superseded, the document body of the older revision is deleted, and its disk space is recovered in a process called *compaction*. Compaction occurs automatically in {{site.data.keyword.cloudant_short_notm}}, so it's not safe to assume that old revisions are available to be retrieved.

To summarize, revision tokens are generated by the database on add,  edit, and delete. (You never need to create your own revision tokens.)
Generally, the revision number increases by one each time, but more complex scenarios are possible (we cover these scenarios later).
Older document bodies are discarded or compacted (don't rely on being able to get them back).
All {{site.data.keyword.cloudant_short_notm}} operations that change a document need the document's `_id` and its `_rev` (this scenario is unlike most databases).

That's the end of this part. The next part is called *Authentication*.

## Authentication video
{: #authentication-video}

Learn how Legacy authentication and IAM authentication work. You can also learn how {{site.data.keyword.cloudant_short_notm}} generates credentials, and how the three official {{site.data.keyword.cloudant_short_notm}} libraries handle authentication. 

![Authentication](https://www.youtube.com/embed/7TF2NnjZc78){: video output="iframe" data-script="#authentication-video-script" id="Authentication video" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen}

### Authentication video script
{: #authentication-video-script}
{: #video-transcript-ui}
{: notoc}

Welcome to the Introduction to {{site.data.keyword.cloudant_short_notm}} course, an 18-part video series that gives you an overview of the {{site.data.keyword.cloudant_short_notm}} database-as-a-service.

This video is part 5 - *Authentication*.

We said earlier that {{site.data.keyword.cloudant_short_notm}} is a web-based service on the public internet. How can we be sure that our data is safe and that only our code can access it? This scenario is where authentication comes in.

{{site.data.keyword.cloudant_short_notm}} supports two types of authentication.

Legacy authentication is where a username or api-key and password are supplied with each request that uses HTTP Basic Authentication or exchanged for a cookie that uses a one-off session API call. A session cookie is cycled regularly, so your client code needs to capture the refreshed cookie and store it for subsequent requests.
IAM authentication is the access management system that underpins all of the {{site.data.keyword.cloud_notm}} services. To authenticate with IAM, you need an IAM API key and the host name of the {{site.data.keyword.cloudant_short_notm}} service. The API key is exchanged for a bearer token by using the IAM API and the bearer token is passed to {{site.data.keyword.cloudant_short_notm}} with each request. The bearer token lasts only an hour, so must be renewed with the IAM service periodically.
When an {{site.data.keyword.cloudant_short_notm}} service is provisioned, you can generate IAM only credentials, or both IAM and Legacy credentials - you decide.

How are credentials generated?

In the {{site.data.keyword.cloud_notm}} Dashboard under your {{site.data.keyword.cloudant_short_notm}} service, in the **Service Credentials** tab, click **New Credential**. A JSON document is created that contains the IAM key, the basic auth username and password, and the {{site.data.keyword.cloudant_short_notm}} hostname.

See the example set of credentials:

For IAM, you need the apikey and host.
For either Legacy or Basic-Auth or both, you need the URL (which contains the username and password that is embedded in the URL).

{{site.data.keyword.cloudant_short_notm}} has three official client libraries: Java&trade;, Node.js, and Python.

All three handle authentication automatically. You don't need to worry about how it exchanges the API key for a session token or how IAM authentication works - it is handled for you.

When we discuss the API in the documentation, we use Basic Auth as a convenience. However, we recommend that you use IAM authentication if possible as it allows better integration with the {{site.data.keyword.cloud_notm}} platform and finer-grained permissions.

Time for our next practical exercise.

Log in to {{site.data.keyword.cloud_notm}} and locate the {{site.data.keyword.cloudant_short_notm}} Lite service that we created last time. In the **Service Credentials** tab, click the **New Credential** button to generate a set of `IAM+Legacy` credentials. Make a note of the JSON that it returns - we'll need that for the next exercise.

Then, visit the URL specified in the credentials JSON - what do you see?

To summarize, credentials are generated from the {{site.data.keyword.cloud_notm}} Dashboard. You can have IAM or both IAM + legacy credentials. Both authentication methods involve exchanging your credentials for a time-limited token (authentication) - the token is then updated periodically as you use the service. The official libraries handle all of these tasks for you.

That's the end of this part. The next part is called *The Dashboard*.

## The Dashboard video
{: #the-dashboard-video}

Learn about the {{site.data.keyword.cloudant_short_notm}} Dashboard and what it has to offer, as well as an introduction into how to use it. 

![The Dashboard](https://www.youtube.com/embed/Lbs7I6fI2O8){: video output="iframe" data-script="#the-dashboard-video-script" id="The Dashboard video" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen}

### The Dashboard video script
{: #the-dashboard-video-script}
{: notoc}

Welcome to the Introduction to {{site.data.keyword.cloudant_short_notm}} course, an 18-part video series that gives you an overview of the {{site.data.keyword.cloudant_short_notm}} database-as-a-service.

This video is part 6 - *The Dashboard*.

The easiest way to get started, create databases, and add documents is to use the {{site.data.keyword.cloudant_short_notm}} Dashboard.

The {{site.data.keyword.cloudant_short_notm}} Dashboard is a web-app that is built into the service. It allows basic data manipulation to be performed through a graphical user interface: Databases can be created and deleted. Documents added, updated, deleted, and replication jobs managed. It is also a handy place to perform one-time queries and to set-up secondary indexes (as we see later).

It also contains some simple monitoring tools that visualize request rates.

It's important to note that any task that is achievable in the {{site.data.keyword.cloudant_short_notm}} Dashboard is also possible with the {{site.data.keyword.cloudant_short_notm}} HTTP API. Indeed, the {{site.data.keyword.cloudant_short_notm}} Dashboard is simply making standard API calls itself.

To open an {{site.data.keyword.cloudant_short_notm}} service's Dashboard, log in to {{site.data.keyword.cloud_notm}}, find your {{site.data.keyword.cloudant_short_notm}} service, and click **Launch {{site.data.keyword.cloudant_short_notm}} Dashboard** button. A new window opens, logging you into your {{site.data.keyword.cloudant_short_notm}} Dashboard.

If you leave the dashboard window unattended for a length of time, you find yourself logged out (for security purposes) and must click **Launch** again.

The dashboard has a number of tabs. Its default tab, **Databases**, lists the databases that you created in groups of 20. Each database is shown with the number of documents that it is storing and how much disk space is being used. Click a database name to examine its contents.

To create a database, click **Create Database** and supply the name of the database to create.

We now have a new empty database. The database's documents would be listed here in ID order. However, since this database is new, no documents exist. To add a document, click **Create Document**.

The {{site.data.keyword.cloudant_short_notm}} Dashboard created a template document for you with a pre-generated `_id`. Complete the rest of the attributes yourself to complete the JSON document, and click **Create Document** to save.

Now it's time for another practical exercise. Create a database called `books`, and in that database, create three or more documents with fields: title, author, date, publisher, and ISBN - each representing a book of your choice.

Once created, edit one of the documents, modifying the publication date.

Then, delete one of the documents.

To summarize, the {{site.data.keyword.cloudant_short_notm}} Dashboard is a web app that is built into the {{site.data.keyword.cloudant_short_notm}} service and is part of the CouchDB open source offering.
It is used to manage databases, documents, indexes, queries, and replication jobs.
It can also be used to monitor service throughput.
The Dashboard is simply an API client - anything that can be achieved with the dashboard can be scripted by you using the HTTP API.

That's the end of this part. The next part is called *HTTP API Basics*.

## HTTP API Basics video
{: #http-api-basics-video}

Learn how to use the command line to make HTTP requests and to add, edit, and delete documents. 

![HTTP API Basics](https://www.youtube.com/embed/0G3J5eJF_jk){: video output="iframe" data-script="#http-api-basics-video-script" id="HTTP API Basics video" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen}

### HTTP API Basics video script
{: #http-api-basics-video-script}
{: notoc}

Welcome to the Introduction to {{site.data.keyword.cloudant_short_notm}} course, an 18-part video series that gives you an overview of the {{site.data.keyword.cloudant_short_notm}} database-as-a-service.

This video is part 7 - *HTTP API Basics*.

In the previous part, we saw the {{site.data.keyword.cloudant_short_notm}} Dashboard, which is a web app that is making HTTP calls to {{site.data.keyword.cloudant_short_notm}}'s API. In this step, we use the command line to make HTTP requests and to try to add, edit, and delete some documents from there.

It's worth understanding the HTTP API from first principles even if you intend to use the higher-level client libraries.

The advantage of a database that has an HTTP API is that any device on the internet can read and write data if you want it to. No special software is required. No drivers that speak a custom protocol. Just a standard HTTP library. For example, everything speaks HTTP:

- Web browser
- Any programming language
- Tools that you can use to write scripts from the command line like curl
- Mobile devices

We're going to learn the API by using curl, a free, open source command-line tool that can dispatch HTTP requests. Curl comes preinstalled on most Macs and Unix-like operating systems. If it's not present on your computer, Google `curl` and follow the installation instructions.

Let's first use curl to fetch a web page - Google's home page.

1. In a command-line terminal, type `curl https://www.google.com`.    

   You get a pageful of HTML in reply.    
   If this method works, then curl is installed, and you can proceed with the next tasks.    Now, we don't want to type the URL of our {{site.data.keyword.cloudant_short_notm}} service every time, so let's save the {{site.data.keyword.cloudant_short_notm}} URL in an environment variable-called URL.

2. Run the `export URL` command to create a variable that is called `URL`, which we can access later.

   `export URL=https://username:password@host`

3. Create an `alias`. 

   `alias acurl="curl -sgH 'Content-type: application/json'"` 

   This `alias` is a shortcut that is called `acurl` that saves us further typing. This `acurl` command is an alias for curl but with the JSON content-type header and a couple of useful command-line switches.
   {: note}

4. Test the `alias` by fetching `acurl $URL/`. 
   We get some JSON back from {{site.data.keyword.cloudant_short_notm}}.

   You completed your first {{site.data.keyword.cloudant_short_notm}} API call. Now, our `acurl` alias is set up. We can start exploring the API. Let's start with the `_all_dbs` endpoint, which returns a list of databases.

5. Type `acurl $URL/_all_dbs` to see an array of databases.

A quick note here on formatting JSON on the command line. We can send the output of our `acurl` command to another tool, which formats the data nicely on the terminal. The following tools are available for your use:

- Jq available from the URL on screen, which is more than just a JSON formatter - it allows JSON to be parsed, queried, and manipulated too.
- `python -m json.tool` is a simple JSON formatter, if Python is installed on your computer.

So `acurl $URL/_all_dbs | jq` means *pipe the output of acurl into jq* and what you see is a nicely formatted, colored output.

The {{site.data.keyword.cloudant_short_notm}} API paths are hierarchical with the first level that gives you information about the service, and then each database sits at a level beneath it.

So `acurl $URL/books` gives us information about the books database that we created earlier.

You see information about how many documents it has, how many deleted documents, and how much disk space it's occupying.

Don't forget to pipe the output to jq or Python to get a prettier output.

If we want to see the documents contained in the database, we can use the `_all_docs` endpoint.

So `acurl $URL/books/_all_docs` means get all the documents from the books database from the {{site.data.keyword.cloudant_short_notm}} service at the supplied URL.

This command's results return a list of `_id` and `_rev` values for each document. If you want the document bodies too, then add `?include_docs=true` to your API call.

If we want to fetch a single document back from the database, then documents sit one level beneath the database in the hierarchy of the URL.

So `acurl $URL/books/id` means "get document ID from the database `books` from the {{site.data.keyword.cloudant_short_notm}} service at the supplied URL".

Notice the hierarchy: service, database, and document.

So far we only used the `GET` HTTP method, which is the default one for curl and the one used when you enter a URL into your web browser.

{{site.data.keyword.cloudant_short_notm}}'s API often uses the HTTP method as a `verb` to describe the action that is asked of the database: GET for fetching data.

With curl, we can specify the method that we want to use with the `-X` command-line option.

So to write a new document to our `books` database that uses the API, we're going to use the POST method, massing a document as the body of the HTTP request.

`acurl -X POST` specifies we're using the `POST` HTTP method. `-d` specifies the document that we want to write, which is sent as the body of the request, and finally, the URL we are writing to which is `$URL/books` - the books database.

Alternatively, we can use the `PUT` method, if we are supplying the ID of the document that is being written. The URL becomes `$URL/books/` followed by the ID we want to write.

Both write methods yield identical responses. `OK:` True to show that the write was successful. ID being the document ID written, and rev being the revision token that was generated by the database.

To modify a document, we can use the PUT method to write the new body to the URL that points to the document ID we want to overwrite. `-d` supplies the new document body, and the URL not only contains the database and ID of the document, but critically the rev - the revision of the document we intend to mutate.

If we forget and omit the rev parameter, we get an error response.

HTTP response codes show whether a request succeeds or not. Responses in the 200 range are successful. Responses in the 400 range are user errors (for example, invalid parameters), and responses in the 500 range are server-side errors. Additionally, you can see the full HTTP request and response by supplying the `-v` command-line option to `curl/acurl`.
{: note}

Also, updates to documents happen in their entirety or not at all. No API construct to modify part of a document exists. A whole document must be supplied to overwrite a previous revision.

Finally, to delete a document, we use the DELETE method, so `-X DELETE`. We direct the request to the URL that includes the database name and document to be deleted, and critically, we also supply the rev - the revision of the document to delete.

If we omit the revision token, an error is returned, and the request fails.

To summarize, understanding the HTTP API helps you grasp the relationship between your code and the {{site.data.keyword.cloudant_short_notm}} service.

The URLs are hierarchical: `service/database/document` or `service/database/endpoint`.

The HTTP methods act as `verbs` defining the action to be done.

All actions can be triggered by using simple HTTP API calls, from the command line or from your code and so can be easily scripted.

That's the end of this part. The next part is called *The Bulk API*.

## The Bulk API video
{: #the-bulk-api-video}

Learn how to use two API calls to perform all the basic {{site.data.keyword.cloudant_short_notm}} operations while also acting on more than one document per API call.

![The Bulk API](https://www.youtube.com/embed/9e_Mx3rX88s){: video output="iframe" data-script="#the-bulk-api-video-script" id="The Bulk API video" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen}

### The Bulk API video script
{: #the-bulk-api-video-script}
{: notoc}

Welcome to the Introduction to {{site.data.keyword.cloudant_short_notm}} course, an 18-part video series that gives you an overview of the {{site.data.keyword.cloudant_short_notm}} database-as-a-service.

This video is part 8 - *The Bulk API*.

In the previous part, we saw how documents could be easily added, updated, and deleted singly by using the {{site.data.keyword.cloudant_short_notm}} HTTP API. In this part, we see how two API calls can be used to achieve all the basic {{site.data.keyword.cloudant_short_notm}} operations. The added benefit of that is being able to act on more than one document per API call.

We already discussed the `_all_docs` endpoint. We used it to fetch a list of all the documents in a database, but it has other features too.

The key parameter can be used to specify a single document to fetch, making it equivalent to the `GET /db/id` API call.
Similarly, the keys parameter takes an array of document IDs and returns them all.
The `startkey` and `endkey` parameters fetch a slice of the primary index between the supplied limits. Adding `include_docs=true` instructs {{site.data.keyword.cloudant_short_notm}} to supply the document bodies too.
And limit specifies how many documents to return in one API call.

The `_bulk_docs` endpoint allows multiple inserts, updates, and deletes operations to be performed in one API call. It expects an object that contains a docs array - each element of that array is an operation to perform on a single document. The request body is posted to {{site.data.keyword.cloudant_short_notm}}, allowing many operations to be packed into a single API call.

In this example, the first document is an insert because no revision token is supplied. The second document is an update to a document because a revision token is supplied with a new document body. The third document is a deletion. A revision token is supplied, but the body is simply `_deleted: true`, which tells {{site.data.keyword.cloudant_short_notm}} to mark the document as deleted.

It's important to note that this scenario isn't like a transaction in a relational database - all or none of these operations could succeed or fail individually. The response data to this request shows you the response for each operation in turn.

In summary, with two API calls `_bulk_docs` and  `_all_docs`, we can perform all create, read, update, and delete operations on {{site.data.keyword.cloudant_short_notm}} documents and be able to do so in bulk too. `_all_docs` retrieves documents by `_id` or ranges of IDs. `_bulk_docs` creates, updates, and deletes documents in bulk. Generally, we recommend that bulk writes are executed in batches of 500; more for tiny documents and fewer for large documents.

See a screen capture of using {{site.data.keyword.cloudant_short_notm}} from a command-line terminal:

That's the end of this part. The next part is called *Accessing {{site.data.keyword.cloudant_short_notm}} programmatically*.

## Accessing {{site.data.keyword.cloudant_short_notm}} Programmatically video
{: #accessing-cloudant-programmatically-video}

Learn how to access {{site.data.keyword.cloudant_short_notm}} programmatically. 

![Accessing {site.data.keyword.cloudant_short_notm}} Programmatically](https://www.youtube.com/embed/y35LbPetISw){: video output="iframe" data-script="#accessing-cloudant-programmatically-video-script" id="Accessing Cloudant Programmatically video" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen}

### Accessing {{site.data.keyword.cloudant_short_notm}} Programmatically video script
{: #accessing-cloudant-programmatically-video-script}
{: notoc}

Welcome to the Introduction to {{site.data.keyword.cloudant_short_notm}} course, an 18-part video series that gives you an overview of the {{site.data.keyword.cloudant_short_notm}} database-as-a-service.

This video is part 9 - *Accessing {{site.data.keyword.cloudant_short_notm}} programmatically*.

So far, our API interactions were triggered by the dashboard or by using curl from the command line. In the following section, we see how {{site.data.keyword.cloudant_short_notm}} is accessed programmatically.

The examples use Node.js, so if you want to try the code yourself, you need to install node and npm from nodejs.org.

We can then install the official {{site.data.keyword.cloudant_short_notm}} Node.js library with `npm install @cloudant/cloudant`. (Npm is the package manager that comes with Node.js - allowing you to access thousands of open source projects and build them into your application for free).

Once the {{site.data.keyword.cloudant_short_notm}} library is installed, we can build some source code. Let's go through this code snippet line-by line:

The {{site.data.keyword.cloudant_short_notm}} service URL is gleaned from the environment variable that we created earlier.

The `@cloudant/cloudant` library is loaded into your Node.js app with the built-in required functions.
We then create an instance of the library that is configured with the credentials we stored in the first line.
We use the {{site.data.keyword.cloudant_short_notm}} object to get a reference to the `books` database and store it in a variable database. We haven't made any API calls - only created data structures that store credentials and which database that we are working on.
The main function calls `db.list`, which maps 1-1 with the `_all_docs` endpoint we saw earlier. The parameters passed to `db.list` must be familiar as the options that `_all_docs` expects to limit the result set and to return document bodies for each ID.

See another code snippet that writes a document.

You can see from the first line that standard JavaScript objects can be used in your code and sent to {{site.data.keyword.cloudant_short_notm}} with no conversion, as they turn into JSON natively in JavaScript.

Writing a document is simply a matter of calling `db.insert`, which maps to a `PUT/POST` API call or to `_bulk_docs`.

To summarize, the official libraries for {{site.data.keyword.cloudant_short_notm}} are Java&trade;, Python, and Nodejs. They are thin wrappers around the {{site.data.keyword.cloudant_short_notm}} HTTP API - so it's worth understanding the underlying API to understand all the parameters.

The libraries handle two things for you, which is useful:

Authentication
:   Exchanging your keys for tokens, whether it be legacy authentication or IAM.

Retry logic
:   The libraries can be configured to retry API calls that exceeded your provisioned capacity. If configured this way, they pause and reattempt the API call multiple times with exponential back-off.

Retrying such API calls is sensible if you have a temporary and unexpected elevation in traffic. If you are routinely exceeding your provisioned capacity, no amount of retrying gets the database work done - you need more capacity!
{: note}

That's the end of this part. The next part is called *Querying*.

## Querying video
{: #querying-video}

Learn the different ways to query data in {{site.data.keyword.cloudant_short_notm}}.

![Querying](https://www.youtube.com/embed/R7xVzn2QxRg){: video output="iframe" data-script="#querying-video-script" id="Querying video" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen}

### Querying video script
{: #querying-video-script}
{: notoc}

Welcome to the Introduction to {{site.data.keyword.cloudant_short_notm}} course, an 18-part video series that gives you an overview of the {{site.data.keyword.cloudant_short_notm}} database-as-a-service.

This video is part 10 - *Querying*.

So far we performed CRUD (create, retrieve, update, and delete) operations from the command line, the dashboard, and from code. These operations use the document's `_id`:

- Fetch document by `_id`.    
- Update document whose `_id` = 'x'.    
- Delete document whose `_id` = 'x'.    
- Get documents in the `_id` range 'a' to 'z'.    

These operations are the building blocks of a database, but they get you only so far. What if you need to return a subset of documents that match on fields within the document? A person's birth date? A book's title? An order's value?

Querying comes in here....

{{site.data.keyword.cloudant_short_notm}} has several methods for querying data. The first we look at is called *{{site.data.keyword.cloudant_short_notm}} Query*.

{{site.data.keyword.cloudant_short_notm}} Query's language was inspired by the MongoDB query language. Queries are expressed in JSON, where the `selector` attribute describes the subset of data to return. The query JSON is posted to the database's `_find` endpoint to perform a query.

The simplest form of query is finding documents where an attribute has a fixed value, for example, where `author == J Smith`.

The second example shows two clauses in the query. Both clauses must be satisfied for a document to make it into the search results, for example, where `isbn === 6725252` AND `date = 2018-01-01`.

The third example shows how logical operators can be added. The `$gt` operation means `greater than` (you can also use `gte` for greater than or equal to, and `lt/lte` for the equivalent less than comparators). The `$or` operator is an `OR` operation, so a matching document must have a date greater than the one in the query either an author of J Smith OR title of Murder.

If you need to access objects within documents, you can use standard dot notation for example, `address.zipcode` to access a postal code string inside an address object.

We can also add the following parameters:

Fields 
:   Specifies the document attributes that we want returned (the default is the entire document).

Sort 
:   Defines how the data is to be sorted. Sort is an array, allowing the sort to be calculated on multiple attributes.

Limit 
:  The number of documents to return.

If you are from a relational database background, this query is the equivalent SQL query to that last {{site.data.keyword.cloudant_short_notm}} query example.

The `WHERE` clause is the equivalent of `SELECTOR` in {{site.data.keyword.cloudant_short_notm}} Query. `ORDER` and `LIMIT` are exactly equivalent, and the {{site.data.keyword.cloudant_short_notm}} Query `FIELDS` list is equivalent to the comma-separated list of attributes after the `SELECT` keyword.

The JSON syntax might take a bit of getting used to, but MongoDB users might find it familiar.

{{site.data.keyword.cloudant_short_notm}} queries can be executed in the {{site.data.keyword.cloudant_short_notm}} Dashboard. Select the database that you are working with, for example, `books` then choose the Query tab.

Enter your {{site.data.keyword.cloudant_short_notm}} Query JSON in the box that is provided, and click **Run Query** when you're ready. The result set appears on the right panel.

The Explain button is used to provide an explanation on how the database interprets the supplied query. This explanation becomes more important when we get to Indexing in the next part.

Queries can be triggered from curl too. The Query JSON, in this case, is stored in a file and we `POST` to the `_find` endpoint by using the `-d@ command-line` syntax.

The Node.js code is similar. The Query is a standard JavaScript object, which is passed to the `db.find` function which it `POSTs` to the `_find` endpoint on your behalf.

Now, time for a practical exercise. Devise your own {{site.data.keyword.cloudant_short_notm}} Query that finds the titles of books that are written in the 20th Century. The {{site.data.keyword.cloudant_short_notm}} Query documentation is at the on-screen URL if you need it.

Pause the presentation here if you don't want to know the answer...

See one solution:

I use the `$and` operator to combine two clauses on the date attribute. One clause to locate documents whose date `>= 1900`, the other to find documents whose date is `< the year 2000`. Both clauses have to be true to select a document. As we need only the title of the matching books, we can supply a fields attribute instead of being returned the entire document.

To summarize, {{site.data.keyword.cloudant_short_notm}} Query is a query language that is inspired by MongoDB where the syntax is expressed in JSON form.

Queries select subsets of documents from the database by using clauses that operate on data inside the document - not just the document's `_id`.

Queries are sent to the database's `_find` endpoint, either programmatically, by using curl, or by using the Dashboard.

The query's selector decides which cut of data is required,

That's the end of this part. The next part is called *Indexing*.

## Indexing video
{: #indexing-video}

Learn how indexing can speed up your query process. 

![Indexing](https://www.youtube.com/embed/we2P8mtsnPs){: video output="iframe" data-script="#indexing-video-script" id="Indexing video" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen}

### Indexing video script
{: #indexing-video-script}
{: notoc}

Welcome to the Introduction to {{site.data.keyword.cloudant_short_notm}} course, an 18-part video series that gives you an overview of the {{site.data.keyword.cloudant_short_notm}} database-as-a-service.

This video is part 11 - *Indexing*.

The queries that we executed in the previous part were not optimal: to get the answer, {{site.data.keyword.cloudant_short_notm}} had to spool through every document in the database in turn to see whether it met with the search criteria.

To make queries that are run in a performant and scalable way, we need *Indexing*.

With {{site.data.keyword.cloudant_short_notm}}, you can specify any number of *Indexes* (or indices).

An index is a secondary data structure that is built from the document list. It contains data that is sorted by the fields you specify, for example, books that are sorted by date and title. If you perform a query that asks for data that matches a document's date and title, the indexed data structure can be used to speed up the query process. Instead of scanning through every document in turn, {{site.data.keyword.cloudant_short_notm}} can jump to the relevant part of the index (say, the section on 20th century books) and retrieve the data much more quickly.

{{site.data.keyword.cloudant_short_notm}} Query indexes include two types of indexes: `type=json` and `type=text`. These indexes are backed by two underlying indexing technologies that we meet in subsequent parts of this course.

An index is defined when you `POST` some JSON to a database's `_index` endpoint.

The index object contains a fields array, which specifies which document attributes to index. Usually, the fields that need indexing are equivalent to the attributes used in the `selector` of a query you're going to use to retrieve the data. That is, if you need to query by the date field, we need to index the date field.

Although the `name` of an index is optional, it's good practice and we follow this convention. It's good to ask {{site.data.keyword.cloudant_short_notm}} a question and specify the name of the index you intend it to use. This practice saves {{site.data.keyword.cloudant_short_notm}} from having to choose which index to use from the available ones, and it makes it easy for you to remember which index is which.

Let's create an index on our `books` database from the dashboard. Select the database, then choose the **Design Documents** tab and **Query Indexes** from the menu.

Any existing indexes are listed on the right side: A `special` index must exist that represents the primary index, based on the document's `_id`.

Complete the index definition with the JSON:

Click **Create Index** when you're done.

Clicking the button sends a `POST` request to the `_index` endpoint (other API calls are available to update and delete existing indexes).

Indexes are built asynchronously by {{site.data.keyword.cloudant_short_notm}} in the background. For large databases, it can take {{site.data.keyword.cloudant_short_notm}} some time to construct the index for the first time. The index cannot use the database until that initial build is ready.
{: important}

We can repeat our query for books in the 20th century. This time we specify the index name with the `use_index` field. The answer returns - this time powered by our index. You might not notice a speed improvement for a small database, but the benefit is definitely felt as your data size and query volume grows. Indexing helps your queries remain performant as your application scales.

When you tell {{site.data.keyword.cloudant_short_notm}} to create a secondary index, it starts a background task that looks at all the documents in turn and creates a new data structure on disk: the index. The index is a balanced tree which pairs the keys (the attribute or attributes that you need indexed) with the document `_id` they came from.

The index can be used to efficiently lookup known keys and ranges of keys without having to rescan the entire database.

Another trick that you can employ at index time is the partial filter. You can optionally supply a partial filter in your index definition. This {{site.data.keyword.cloudant_short_notm}} Query selector is executed at index time to decide which documents' data makes it to the index and which are ignored.

In this example, a selector is employed that allows only dates that fall on a weekend to make it to the index. Smaller indexes are faster and more efficient. If you have a use-case that needs only a subset of the data to be indexed, then a partial filter selector at index-time can help to make the index smaller and more efficient. For example, you might want to index only completed orders, or only expired accounts, or only published blog posts.

To summarize, the `_index` endpoint is used to define the index, and an optional partial filter can be applied at query time to make smaller, sparse indexes.

That's the end of this part. The next part is called *MapReduce*.

## MapReduce video
{: #mapreduce-video}

Learn about MapReduce, which is another way to configure secondary indexes.

![MapReduce](https://www.youtube.com/embed/T1KFHLe6NsA){: video output="iframe" data-script="#mapreduce-video-script" id="MapReduce video" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen}

### MapReduce video script
{: #mapreduce-video-script}
{: notoc}

Welcome to the Introduction to {{site.data.keyword.cloudant_short_notm}} course, an 18-part video series that gives you an overview of the {{site.data.keyword.cloudant_short_notm}} database-as-a-service.

This video is part 12 - *MapReduce*.

We saw how a combination of the `_find` and `_index` endpoints allows queries to be performed on the contents of JSON documents. They are backed by secondary indexes to make queries scale as your application grows.

In this part, we introduce another way of configuring secondary indexes that are called MapReduce.

MapReduce used to be the only way to configure secondary indexes in CouchDB and is still a popular way of querying data from within the document body.

To create a MapReduce index, you need to supply a JavaScript function that is wrapped in a special document that is called a design document to {{site.data.keyword.cloudant_short_notm}}. Design documents' `_id` fields begin with `_design/` for example, `_design/mydesigndoc`.

When {{site.data.keyword.cloudant_short_notm}} receives the design document, it sets up a background indexing task, passing each document from the database to your JavaScript function in turn. The key-values that are emitted by your JavaScript function form the basis of the index that is persisted.

Let's look at some example JavaScript functions.

The function accepts one parameter - the document that is passed to it by the {{site.data.keyword.cloudant_short_notm}} indexer. Every time your function calls emit the parameters that you pass from the key-value of the index.

The first example emits a key of `doc.name`, so in this case, it is an index for lookups by the name field. There is nothing (null) for the value.

The second example pre-processes the data before emitting. This pre-processing is a useful way of tidying up strings, trimming whitespace, lower and uppercasing text, applying default values to missing data, or constraining values to certain ranges, and so on.

The third example adds logic: only documents that are `published` make it to the index. This logic is equivalent to the partial filter selector that we saw with {{site.data.keyword.cloudant_short_notm}} Query.

Indexes build asynchronously and cannot be used until they build completely. Once built, they can be used for selection by key, lists of keys, ranges of keys, and aggregation of data. For example, *Find orders between two dates, and calculate the total value of the orders, which are grouped by month.*

{{site.data.keyword.cloudant_short_notm}} includes the four built-in reducers (or five if you count `none`).

`_count`
:   For counting things.

`_sum` 
:   For totalizing values.

`_stats` 
:   For providing counts and totals suitable for calculating means, variances, and standard deviations.

`_approx_count_distinct` 
:   For approximate counting of unique values of the key.

The design document's `MAP` function is passed a `doc` - the function is called once per document in the database. Any key-value pairs that `emit` from the `MAP` function create the index.

The `KEY` is the thing (or things) you want to `select` on (for example, date).

The `VALUE` is the thing that you need to report on (for example, total sales).

The Reducer is `_sum` so that the `VALUE` is totaled for matching keys (for example, orders on the same date).

See what defining a MapReduce looks like in the {{site.data.keyword.cloudant_short_notm}} Dashboard.

When the MapReduce view is built, it can be queried to see each `KEY-VALUE` pair stored in the index.

Or, if the reducer is switched on, the result set can be grouped by the value of each key. In this case, we are totalizing each day's sales.

The view can be queried for individual keys (for example, sales on a specific date), all keys, or a range of keys (for example, between two dates).

MapReduce views are built asynchronously and can take some time to be ready for large data sets.

See some tips:

Use logic in your JavaScript to include only data that makes sense, for example, totalize only completed orders.
Indexed keys don't have to be strings. A common pattern is to use array keys, for example, an array of year, month, day. These index keys allow query-time grouping by elements in the array. For example, you can group orders by year, orders by year and month, orders by year and month and day. Great for summary reports that allow the user to drill down into the detail.
The value can by a string, number, or sometimes a small object that contains a subset of the document. The object can be used instead of adding `include_docs=true`, which would also return the document's body in the result set.

To summarize, MapReduce is a low-level means of defining indexes that allow the selection and aggregation of data.

Use JavaScript logic to decide which data makes it to the index. Choose how the index is formed by emitting keys-values.

Summarize data with the built-in reducers. Produce concise reports from lots of data efficiently.

MapReduce is great for boilerplate queries that your application needs to do again and again. Not for one-time, adhoc-queries for data exploration.

That's the end of this part. The next part is called *Dates*.

## Dates video
{: #dates-video}

Learn about different options for storing a date, or date and time value.

![Dates](https://www.youtube.com/embed/7b2zFNIK7hU){: video output="iframe" data-script="#dates-video-script" id="Dates video" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen}

### Dates video script
{: #dates-video-script}
{: notoc}

Welcome to the Introduction to {{site.data.keyword.cloudant_short_notm}} course, an 18-part video series that gives you an overview of the {{site.data.keyword.cloudant_short_notm}} database-as-a-service.

This video is part 13 - *Dates*.

We saw earlier in this course that JSON only natively models strings, numbers, booleans, objects, and arrays. A common use-case is to store a date or date and time value in a database. See some ideas on how that can be achieved with {{site.data.keyword.cloudant_short_notm}}.

The ISO-8601 string format for representing a time consists of a `y-m-dTh:m:s.msTIMEZONE` year, month, day, a 'T' character, hour, minute, second, millisecond, and time zone.

I always recommend storing dates in the UTC time zone even if you collect data from different geographies. Date that is stored in this form can easily be transformed into the local time zone at the front end. It's usually important to store each user's data in the "same units".

This string format sorts into date and time order (because the most significant date units are at the front of the string) and can be easily parsed in MapReduce functions.

Another option is to store the number of milliseconds since 01-January-1970. This option is also a standard, machine-readable way of representing a date and time.

It too can be parsed in MapReduce functions and is handy for comparing two dates: simply take one timestamp from another.


To summarize, no native date format in JSON exists, so you can store dates and times how you like. ISO-8601 is compact, readable, and sorts nicely, as do a timestamp (milliseconds since 1970).

If you need to use {{site.data.keyword.cloudant_short_notm}} Query on one of the component parts, then that would need to be broken out explicitly in the document.

That's the end of this part. The next part is called *Replication*.

## Replication video
{: #replication-video}

Learn what replication means in {{site.data.keyword.cloudant_short_notm}}, as well as different types of replication and how they work. 

![Replication](https://www.youtube.com/embed/TxDcumJ-DdA){: video output="iframe" data-script="#replication-video-script" id="Replication video" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen}

### Replication video script
{: #replication-video-script}
{: notoc}

Welcome to the Introduction to {{site.data.keyword.cloudant_short_notm}} course, an 18-part video series that gives you an overview of the {{site.data.keyword.cloudant_short_notm}} database-as-a-service.

This video is part 14 - *Replication*.

Replication is a core feature of {{site.data.keyword.cloudant_short_notm}}. It is the transfer of data from one database (the source) to another (the target).

The source and target databases can reside on the same {{site.data.keyword.cloudant_short_notm}} service, or be geographically separated, for example, a US {{site.data.keyword.cloudant_short_notm}} database that replicates to one in Europe.

The {{site.data.keyword.cloudant_short_notm}} replication protocol is shared with Apache CouchDB, so replication is often used by enterprises that copy data from a cloud-based database to one running CouchDB in their own location.

PouchDB, a JavaScript-based CouchDB clone that runs in Node.js stacks or the web browser, can also be used to replicate data between {{site.data.keyword.cloudant_short_notm}} or CouchDB, each way, either to or from.

The {{site.data.keyword.cloudant_short_notm}} Sync libraries are native iOS or Android apps that sync data to and from an {{site.data.keyword.cloudant_short_notm}} service.

Replication is a one-way operation from source to target, which moves all data (deletions, conflicts, attachments, as well as documents) and can be triggered in one of two ways:

1. Run until all the data from the source reaches the target and then stop. 
2. The same as one, but the replication runs continuously forever, transferring new data from the source to the target as it arrives.

Replication can also be resumed from where it last stopped. {{site.data.keyword.cloudant_short_notm}} keeps a note of `checkpoints` between replicating parties to allow the resumption of a pre-existing replication from its last known position.

The {{site.data.keyword.cloudant_short_notm}} Dashboard includes a replication tab. A replication is started by specifying the source and target databases that include authentication credentials, and whether this replication is a one time or continuous operation.

A replication can also be given a name, which is handy for tracking which replication job is which.

Now it's time for a practical exercise.

1. Go to the {{site.data.keyword.cloudant_short_notm}} Dashboard. 
2. Create a database called `books2`.
3. Start a continuous replication from `books` to `books2`.
4. Visit the `books2` database to check that documents from `books` are now in `books2`.
5. Add a document to the `books` database.
6. Verify that the change makes it to the `books2` database.

Replication can be used to move data from an {{site.data.keyword.cloudant_short_notm}} database to an on-premises CouchDB instance. The replication can be controlled by {{site.data.keyword.cloudant_short_notm}} or CouchDB. For example, you can ask {{site.data.keyword.cloudant_short_notm}} to send its changes to CouchDB, or you can ask CouchDB to pull the changes from {{site.data.keyword.cloudant_short_notm}}. The replication controller must have network visibility of both HTTP APIs.

PouchDB also speaks the same replication protocol, so it can be used to transfer data to and from PouchDB and {{site.data.keyword.cloudant_short_notm}}. It's most likely that PouchDB would be the replication controller in this case.

PouchDB is commonly used to create offline first apps. These apps collect data even when not connected to the internet, and then write data to {{site.data.keyword.cloudant_short_notm}} when they come back online, giving their users an always on service.

Replication cannot always be required. If your application needs to store data and then write it to {{site.data.keyword.cloudant_short_notm}} later, then replication isn't strictly speaking required. All that is required is that data is stored on the device, and bulk is written to {{site.data.keyword.cloudant_short_notm}} when the connection is restored.

As replication is a one-way operation, if a primary-primary setup is required between two {{site.data.keyword.cloudant_short_notm}} instances in different regions, then two replications in opposite directions are required.

Changes occurring on the London side are sent to Dallas, and vice versa.

More complex topologies are possible, with data that flows in a ring around a set {{site.data.keyword.cloudant_short_notm}} service.

To summarize, {{site.data.keyword.cloudant_short_notm}} replication is a mechanism for copying data from a source database to a target database.

Replications can be one-off or continuous and can optionally be filtered with a JavaScript function or {{site.data.keyword.cloudant_short_notm}} Query selector and can be resumed from where a previous replication stopped.

That's the end of this part. The next part is called *Partitioned databases*.

## Partitioned databases video
{: #partitioned-databases-video}

Learn how partitioned databases work in {{site.data.keyword.cloudant_short_notm}}, how to assign documents to specific shards, and why partitioned databases improve performance, cost, and scalability. 

![Partitioned databases](https://www.youtube.com/embed/44PhiYnrGJA){: video output="iframe" data-script="#partitioned-databases-video-script" id="Partitioned databases video" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen}

### Partitioned databases video script
{: #partitioned-databases-video-script}
{: notoc}

Welcome to the Introduction to {{site.data.keyword.cloudant_short_notm}} course, an 18-part video series that gives you an overview of the {{site.data.keyword.cloudant_short_notm}} database-as-a-service.

This video is part 15 - *Partitioned database*.

{{site.data.keyword.cloudant_short_notm}} is a distributed database, which is a discussion that is coming up. Many storage nodes make up an {{site.data.keyword.cloudant_short_notm}} service and a database's documents are distributed across the nodes in groups called `shards`. A single database is said to be `sharded` or divided into multiple pieces.

In a normal {{site.data.keyword.cloudant_short_notm}} database, a document is allocated a shard algorithmically - effectively documents are distributed around the shards randomly.

In a partitioned database, you define which shard the documents are stored in by supplying a partition key.

Partitioned databases are not created with the same `PUT /<database name>` API call but with an extra query string parameter: `partitioned=true`.

In the first example, the products database is created as a partitioned database, in the second example, as a standard, unpartitioned database.

When you add documents to a partitioned database, you must supply a document _ID - (no auto-generated document _IDs exist). A document `_id` has two parts, which are separated by a colon character:

Partition key
:   A string that defines on which partition to store the document.

Document key 
:   A string that uniquely identifies a document within the partition.

In the first example, a book is being added into the book partition of the products database.

Then, another document is being added into the DVD partition and a third into the household partition.

The effect of this is that documents that share a partition key reside in the same shard of the databases. Documents in the same partition are stored together in document key order.

The advantage comes when retrieving data. We can direct {{site.data.keyword.cloudant_short_notm}} Queries, MapReduce requests, and searches at a single partition. In this example, an {{site.data.keyword.cloudant_short_notm}} Query selector is being sent to the `book` partition. This action means you exercise only a fraction of the {{site.data.keyword.cloudant_short_notm}} infrastructure (only the shard that hosts the book partition is used, the rest of the cluster remains idle).

This scenario makes for faster query performance, cheaper query costs, and better scalability.

The key to great partitioned query performance is the choice of partition key:

It needs to be a value that repeats within your data set. For example, several items exist in the `book` partition.
There needs to be many partitions. If you have only a few categories, then category is a bad choice of partition key. It needs to be something that has many values, for example, `deviceId` in an IoT application or `orderId` in an e-commerce system.
It needs to match the queries that your application is making. If the most common use-case is searching within a product category, then partitioning by category might be a good fit.
Avoid hot partitions - traffic must be evenly spread across your partitions. If your choice of partition key is likely to lead to a large increase in traffic that hits a few partitions, then this scenario makes for a poor choice of partition key.

To summarize, partitioned databases are created with the `partitioned=true` flag, and documents have a two-part ID where the partition key and document key are joined by a colon character.

Documents in the same partition are stored in document key order in the same database shard. Knowing this method of storage, we can make queries that are directed at a single partition that runs faster and more cheaply.

It's still possible to query across partitions in a partitioned database. When you create a secondary index, you choose whether its purpose is for per-partition or global scope.
{: note}

That's the end of this part. The next part is called *{{site.data.keyword.cloudant_short_notm}} Search*.

## {{site.data.keyword.cloudant_short_notm}} Search video
{: #cloudant-search-video}

Learn how to use {{site.data.keyword.cloudant_short_notm}} Search, as well as Lucene query language and faceting. 

![{{site.data.keyword.cloudant_short_notm}} Search](https://www.youtube.com/embed/4cs5qH3lt5U){: video output="iframe" data-script="#cloudant-search-video-script" id="Cloudant Search video" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen}

### {{site.data.keyword.cloudant_short_notm}} Search video script
{: #cloudant-search-video-script}
{: notoc}

Welcome to the Introduction to {{site.data.keyword.cloudant_short_notm}} course, an 18-part video series that gives you an overview of the {{site.data.keyword.cloudant_short_notm}} database-as-a-service.

This video is part 16 - *{{site.data.keyword.cloudant_short_notm}} Search*.

We have another method of querying and indexing in {{site.data.keyword.cloudant_short_notm}} called {{site.data.keyword.cloudant_short_notm}} Search that we briefly explore in this part.

{{site.data.keyword.cloudant_short_notm}} Search is built on another open source project, Apache Lucene, which powers the search capabilities of many products that include Elasticsearch.

It is primarily designed for free text search, where blocks of text are pre-processed before they are indexed: removing case, punctuation, common noise words, and trimming common language-specfic word endings, for example, farmer becomes farm, and farms becomes farm.

This text-processing is performed by a choice of analyzers at query time, searching. Before this time, it also allows some aggregation functionality that uses a technique that is called faceting.

An {{site.data.keyword.cloudant_short_notm}} Search index is created by supplying JavaScript function. It is not unlike MapReduce, except this time, the emit function is replaced by an index function, which expects the name of the field, the data itself, and some options.

In this example, the document's name and title are indexed with default options. The category is nominated for faceting (the aggregation functionality) and the ISBN is stored in the index but not indexed for search itself. Sometimes it is more efficient to store some items in the index rather than doing `include_docs=true` at query time.

Lucene has its own query language that creates queries that match combinations of clauses with logic, fuzzy matching, ranges, and term boosting.

See the following examples:

- Find documents whose title matches `gastby` and whose author starts with `fitz`. Notice the asterisk wildcard.
- Find documents whose `author` is in the range `austen to dickens`. This example shows a range query on a string field.
- Find documents whose price is `0 - 100` `AND` whose year is in the `19th century` or whose author matches `charles dickens`. This example shows how logic can be built into queries.

{{site.data.keyword.cloudant_short_notm}} Search is useful not only for free-text search. It is also useful when you know which attributes you are going to search on, but the queries are varied, with different combinations of attributes each time. This flexibility is difficult to implement with fixed-order MapReduce indexes.

Faceting is a form of aggregation. You nominate individual indexed fields for faceting at index-time and activate the aggregation with parameters at query-time.

It has two uses:

Counting repeating values in the result set, such as the counts of products that belong to each category in a result set. Or,
counting numbers of items in numeric ranges, such as the product counts in each of the price ranges.
Both of these forms of counts can be presented to a front-end user as a means of further filtering an existing search to narrow the scope of the search. For example, a customer searches for `Fender`, then clicks **Amps** then on a price range `under $500`. All of this search and filtering can be powered by {{site.data.keyword.cloudant_short_notm}} Search.

To summarize, {{site.data.keyword.cloudant_short_notm}} Search indexes are defined with a supplied JavaScript function. They are built on Apache Lucene and are primarily used for free-text search matching, but the query language is useful for building flexible queries on a fixed set of indexed fields. It also has some powerful counting aggregations suitable for drill-down user interfaces.

{{site.data.keyword.cloudant_short_notm}} Search also powers `type=text` {{site.data.keyword.cloudant_short_notm}} Query indexes, so a subset of its capabilities is surfaced by using the `_find` API.
{: note}

That's the end of this part. The next part is called *Geospatial*.

## Geospatial video
{: #geospatial-video}

Learn how to use geospatial indexes to query data, which is unique to {{site.data.keyword.cloudant_short_notm}}. 

![Geospatial](https://www.youtube.com/embed/nfDQN_Em4H8){: video output="iframe" data-script="#geospatial-video-script" id="Geospatial video" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen}

### Geospatial video script
{: #geospatial-video-script}
{: notoc}

Welcome to the Introduction to {{site.data.keyword.cloudant_short_notm}} course, an 18-part video series that gives you an overview of the {{site.data.keyword.cloudant_short_notm}} database-as-a-service.

This video is part 17 - *Geospatial*.

The final means of querying data in {{site.data.keyword.cloudant_short_notm}} is using geospatial indexes.

Geospatial indexes are unique to {{site.data.keyword.cloudant_short_notm}}. CouchDB codebase does not include geospatial indexes.

Data is stored as GeoJSON in the {{site.data.keyword.cloudant_short_notm}} database to describe point, line, polygon, multi-point, multi-line, and multi-polygon objects. Each object, as well as the geographic information, can have optional properties: Metadata about the object, which is returned in the search results.

Again, an index is defined as a JavaScript function, and then, queries can be used to ask questions of your collection of geographic features. For example, find me the nearest object to this point; find objects within this polygon; find objects along this path; or find objects that intersect with this object.

To summarize, {{site.data.keyword.cloudant_short_notm}} Geo is something unique to the {{site.data.keyword.cloudant_short_notm}} service and is used to perform advanced geospatial queries against your databases of GeoJSON objects. It cannot be combined with other index types. It is only of use to Geographic Information Systems or use-cases that have a purely geographic purpose.

That's the end of this part. The next part is called *Under the hood*.

## Under the hood video
{: #under-the-hood-video}

Learn how the {{site.data.keyword.cloudant_short_notm}} service is organized. 

![Under the hood](https://www.youtube.com/embed/kCOTeCnHWJg){: video output="iframe" data-script="#under-the-hood-video-script" id="Under the hood video" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen}

### Under the hood video script
{: #under-the-hood-video-script}
{: notoc}

Welcome to the Introduction to {{site.data.keyword.cloudant_short_notm}} course, an 18-part video series that gives you an overview of the {{site.data.keyword.cloudant_short_notm}} database-as-a-service.

This video is part 18 - *Under the hood*.

Let's look at how an {{site.data.keyword.cloudant_short_notm}} service is organized: This overview applies to the {{site.data.keyword.cloudant_short_notm}} services that map to CouchDB 2 and 3. CouchDB 4 is built on different technology.

{{site.data.keyword.cloudant_short_notm}} is a distributed database with data that is stored around a cluster of storage nodes. Picture the {{site.data.keyword.cloudant_short_notm}} service as ring of nodes, in this case twelve. Every node can deal with incoming API calls and every node has responsibility for storing some of the data: shards and associated secondary indexes of databases that exist in the cluster.

When data is written to {{site.data.keyword.cloudant_short_notm}}, one of the nodes in the ring handles the request: Its job is to instruct three copies of the data to be stored in three storage nodes. Data is stored in triplicate in {{site.data.keyword.cloudant_short_notm}}, so each shard of a database is stored multiple times, often across a region's availability zones.

When you make an API call to write data and get a response back, we write the data to at least two of the three storage nodes. Data is flushed to disk - it isn't cached in memory to be flushed data. We consider that technique too risky and prone to data loss.

When you create a database, a number of database shards are created (16 by default) which are spread around the cluster. Three copies of each shard exist, which equals 48 shard copies.

You don't see any of this activity. The activity is handled for you transparently when you create a database.

What happens if a node goes down or needs to be rebooted for maintenance? The rest of the cluster continues as normal. Most shards still have three copies of data but some have only two. API calls continue to work as normal, only two copies of the data are written.

Even if two nodes go down, most shards still have three copies, some have two, and some have one. Writes continue to work, although the HTTP response code reflects that the quorum of two node confirmations wasn't reached.

It's the same story for reads. Service continues with a failed node. We can survive one failed node...

Or more failed nodes. If a copy of each node exists, the API continues to function.

When a node returns, it catches up any missed data from its peers and then returns into service, handling API calls and answering queries for data.

The nature of this configuration is that {{site.data.keyword.cloudant_short_notm}} exhibits eventual consistency. Any node can handle a request. Data is distributed around nodes without the sort of locking that you might see in a relational database.

{{site.data.keyword.cloudant_short_notm}} favors availability over consistency: It would rather be up and answering API calls than be down because it can't provide consistency guarantees. (A relational database is often configured in the opposite way: It operates in a consistent manner or not at all.)
The upshot of eventual consistency for a developer is that your app must not `read its writes` in a short time. A small-time window might exist in which it is possible to see an older version of a document than the one you updated. Eventually, the data flows around the cluster, and in most cases, the quorum mechanism provides the illusion of consistency, but it is best not to rely on it.

In CouchDB 4, and in {{site.data.keyword.cloudant_short_notm}} services based on that code version, a different consistency model is employed.
{: note}

If your data model requires you to update a document over and over in a short time window, it's possible that multiple writes for the same revision number are accepted. These writes lead to a branch in the revision tree - known as a conflict. In this example revision `2` was modified in two different ways, causing two revision 3s. It's possible to tidy up conflicts programmatically, but they must be avoided as they can cause performance issues in extreme circumstances.

Conflicts can also happen when you use replication and a document is modified in different ways, and then the conflicting revisions are merged in by using replication. {{site.data.keyword.cloudant_short_notm}} does not throw away data in this scenario. A `winning` revision is chosen, but the nonwinning revisions can be accessed and your application can resolve the conflict by electing a new winner, deleting unwanted revisions, or any action you need. A conflict is not an error condition. It's a side effect of having disconnected copies of data that can be modified without locking. {{site.data.keyword.cloudant_short_notm}} chooses to handle conflicts by not discarding clashing changes, but storing them as a conflict.

To check a document for conflicts, simply add `?conflicts=true` to a fetch of a single document. Any conflicting revisions are listed in the `_conflicts` array.

Unwanted revisions can be removed by using the normal `DELETE` operation, specifying the rev token of the revision you want to delete. The bulk API is also good for removing conflicting revisions, even for removing multiple conflicts from the same document.

To summarize, {{site.data.keyword.cloudant_short_notm}} is a distributed service that stores databases, which are broken into multiple shards, with three copies of each shard spread around a ring of storage nodes. {{site.data.keyword.cloudant_short_notm}} is eventually consistent, favoring high availability over strong consistency.

Avoid writing to the same document over and over so as not to create conflicts. Although conflicts are sometimes inevitable in replication situations.

Embrace eventual consistency - don't try to make {{site.data.keyword.cloudant_short_notm}} consistent.

{{site.data.keyword.cloudant_short_notm}} products based on CouchDB 4 might have a different consistency model.
{: note}

That's the end of this course. For more information, see our documentation and our blog.
