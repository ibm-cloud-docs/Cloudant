---

copyright:
  years: 2015, 2019
lastupdated: "2019-12-23"

keywords: couchapp, 3-tier application

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

<!-- Acrolinx: 2019-12-23 -->

# CouchApps
{: #couchapps}

{{site.data.keyword.cloudantfull}} can host raw file data,
like images,
and serve them over HTTP. In other words, {{site.data.keyword.cloudant_short_notm}} can host all the static files necessary to run a website,
and host them just like a web server.
{: shortdesc}

Because these files can be hosted on {{site.data.keyword.cloudant_short_notm}},
the client-side JavaScript can access {{site.data.keyword.cloudant_short_notm}} databases.
An application built this way is said to have a two-tier architecture,
consisting of the client, typically a browser, and the database.
In the CouchDB community,
this application is called a CouchApp.

Most web apps have three tiers:
the client,
the server,
and the database.
Placing the server between the client and the database helps with authentication,
authorization,
asset management,
leveraging third-party web APIs,
providing sophisticated endpoints,
and so on.
This separation provides added complexity without conflating concerns. Now, your client can worry first and last about data presentation,
while your database focuses on storing and serving data.

CouchApps shine in their simplicity,
but frequently a web app needs the power of a 3-tier architecture.
When is each appropriate?

## A CouchApp is appropriate if...
{: #a-couchapp-is-appropriate-if-}

-   Your server only provides an API to {{site.data.keyword.cloudant_short_notm}} anyway.
-   You're OK with {{site.data.keyword.cloudant_short_notm}}'s
    [cookie-based authentication](/docs/services/Cloudant?topic=cloudant-authentication#cookie-authentication).
-   You're OK with {{site.data.keyword.cloudant_short_notm}}'s [`_users` and `_security`](/docs/services/Cloudant?topic=cloudant-authorization#using-the-_users-database-with-cloudant-nosql-db)
    databases to manage users and permissions.
-   You don't need to schedule cronjobs or other regular tasks.

To get started with CouchApps,
read [Managing applications on {{site.data.keyword.cloudant_short_notm}}](https://cloudant.com/blog/app-management/){: new_window}{: external}.

## A 3-tier application is appropriate if...
{: #a-3-tier-application-is-appropriate-if-}

-   You need finer-grained permissions than the `_security` database
    allows.
-   You need an authentication method other than Basic authentication or cookie
    authentication, such as Oauth or a 3rd-party login system.
-   You need to schedule tasks outside the client to run regularly.

You can write your server layer by using whatever technologies work best
for you.
A list of libraries that work with {{site.data.keyword.cloudant_short_notm}} is available on the [{{site.data.keyword.cloudant_short_notm}} Basics](/docs/services/Cloudant?topic=cloudant-client-libraries#client-libraries) page.
