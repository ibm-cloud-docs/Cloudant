---

copyright:
  years: 2015, 2025
lastupdated: "2025-09-25"

keywords: security, compliance, standardize resource configuration

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# Service Changes and Deprecations for {{site.data.keyword.cloudant_short_notm}}
{: #deprecations-for-ibm-cloudant}

## Ongoing changes
{: #Ongoing-changes}

### QuickJS

To support ES2023 JavaScript features and speed up index building,
{{site.data.keyword.cloudant_short_notm}} is replacing the
[SpiderMonkey][sm-qjs] JavaScript engine with [QuickJS][qjs-qjs].

[sm-qjs]: https://spidermonkey.dev/
[qjs-qjs]: https://bellard.org/quickjs/

Read [Migration to QuickJS from SpiderMonkey](/docs/Cloudant?topic=Cloudant-faq-migration-to-quickjs-from-spidermonkey) for full details on this change.

This could break some applications, and might require JavaScript updates in your design documents to align with QuickJS. Read the migration guide to understand whether this affects your instances.
{: note}

## Upcoming changes
{: #Upcoming-changes}

### Legacy authentication

To enhance security, Cloudant will enable temporary lockout of accounts in
the coming months. After multiple login attempts using incorrect credentials,
further login attempts will be denied for a period of time. To unlock your
account, please wait for some time or change the password and then wait at
least 5 minutes to ensure that the change propagates throughout the system.

The temporary lockout described here applies to legacy (non-IAM) credentials only.
{: note}

## {{site.data.keyword.cloudant_short_notm}} instances will be limited to 200 dbs starting March 1st, 2025
{: #cloudant-database-size-limit}

Beginning on March 3rd, new Cloudant instances will have a limit on the number of databases created within that instance.

- Each Cloudant Standard instance will only be permitted a maximum of 200 databases at any time.
- Each Cloudant Lite instance will only be permitted a maximum of 20 databases at any time.
- The limit will NOT apply to any Cloudant instance created before March 3rd, 2025. These instances will continue to have no limit imposed.

Once the limit is reached, any attempt to create an additional database will elicit an `HTTP 403` response. A Cloudant instance's current database count can be found by using the `/_api/v2/user/current/databases` api call, and the number of databases permitted is available from the `/_api/v2/user/capacity/databases` endpoint.

If an application requires more than 200 databases in total, then it should be configured to store its data across multiple Cloudant instances or you can reach out to support and exceptions can be granted on a case-by-case basis. 

## {{site.data.keyword.cloudant_short_notm}} Upgrading JavaScript engine
{: #cloudant-nosql-db-jsengine-dep}

Read [Migration to QuickJS from SpiderMonkey](/docs/Cloudant?topic=Cloudant-faq-migration-to-quickjs-from-spidermonkey) for full details on this change.

## {{site.data.keyword.cloudant_short_notm}} Deprecation of `_show`, `_list`, `_update`, `_rewrite` functions
{: #cloudant-nosql-db-show-list-update-rewrite-function-dep}

### Details
{: #cloudant-nosql-db-db-show-list-update-rewrite-function-dep-details}

Notice that the following Cloudant features are deprecated:

* show functions - used to modify the format of the response when requesting a single document from the database.
* list functions - similar to show functions, but applied to the output of MapReduce views.
* rewrite functions - used to embody routing logic in CouchApps.
* update functions - used to carry out business logic within the database e.g. adding a timestamp to all document writes.

These four features are already deprecated in Apache CouchDB and scheduled to be removed from the code in Apache CouchDB 4.0. None of these features are modelled in our Cloudant SDKs.

Although these features are deprecated, they will not be removed from the service yet. { :important}

We may completely remove the features in the future, but will leave them operable for the time being to give customers time to modify their applications. As deprecated features, they will not appear in our documentation, their use is not recommended and they will not be supported by our Support team.

Alternatives to these functions can be found on the Cloudant blog [here](https://blog.cloudant.com/2022/08/16/Show-list-rewrite-udpate-functions-deprecated.html){: external}.

## {{site.data.keyword.cloudant_short_notm}} Remove replicator endpoint proxy support
{: #cloudant-nosql-db-replicator-proxy-dep}

### Details
{: #cloudant-nosql-db-replicator-proxy-dep-details}

Replicator endpoint proxy support is removed. Replication jobs with `proxy`, `source_proxy` or `target_proxy` fields set will fail with an error.
