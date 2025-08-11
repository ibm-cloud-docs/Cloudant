---

copyright:
  years: 2015, 2025
lastupdated: "2025-08-11"

keywords: security, compliance, standardize resource configuration

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# Service Changes and Deprecations for {{site.data.keyword.cloudant_short_notm}}
{: #deprecations-for-ibm-cloudant}

## Ongoing changes
{: #Ongoing-changes}

QuickJS
:   To speed up index building, {{site.data.keyword.cloudant_short_notm}} is
replacing the JavaScript engine from [SpiderMonkey](https://spidermonkey.dev/)
to [QuickJS](https://bellard.org/quickjs/). Please read
[below](/docs/Cloudant?topic=Cloudant-deprecations-for-ibm-cloudant#cloudant-nosql-db-jsengine-dep)
for more information or open a
[support ticket](https://cloud.ibm.com/unifiedsupport/cases/form) with us.

This could break some applications, and might require changes to align with
`QuickJS`. So far, we have migrated most of the accounts to `QuickJS`, and very
few accounts might get individual notifications.
{: note}

## Upcoming changes
{: #Upcoming-changes}

Legacy authentication
:   To enhance security, Cloudant will enable temporary lockout of accounts in
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

### Details
{: #cloudant-nosql-db-jsengine-dep-details}

The JavaScript engine used in design documents is being upgraded to support
newer language features and optimize index build speeds. However, as a result,
some JavaScript language features are deprecated, and others will change their
behavior:

 * `RegExp.$1...$9` regular expressions feature is deprecated. The `$1`...`$9`
   properties will return `undefined`. For example:

Previous result:
```js
> v="abc"
"abc"

> v.match(/(b)/)
["b", "b"]

> RegExp.$1
"b"
```

New reuslt:
```js
> v="abc"
"abc"

> RegExp.$1
undefined
```

 * `Date.prototype.toString()` result doesn't include the timezone name, just the offset. For example:

Previous result:
```js
>  (new Date()).toString();
"Thu Sep 05 2024 17:04:03 GMT-0400 (EDT)"
```

New result:
```js
> (new Date()).toString();
"Thu Sep 05 2024 17:03:23 GMT-0400"
```

 * `for each (var x in ...)` experssions are deprecated

 * E4X (ECMAScript for XML) is deprecated

Previous result:
 ```js
> var xml = <root><x></x></root>

> xml.(x)
<root>
  <x/>
</root>
```

New result:
```js
> var xml = <root><x></x></root>
typein:1:11 SyntaxError: expected expression, got '<':
```

 * `Date.prototype.toLocaleFormat()` function is depcrecated.

Previous result:
```js
> d = new Date("Dec 1, 2015 3:22:46 PM")
(new Date(1449001366000))

> d.toLocaleFormat("%Y-%m-%d")
"2015-12-01"
```

New result:
```js
> d = new Date("Dec 1, 2015 3:22:46 PM")
(new Date(1449001366000))

> d.toLocaleFormat("%Y-%m-%d")
typein:2:3 TypeError: d.toLocaleFormat is not a function
```

 * `Date.prototype.toLocaleString()` used to ignore locale strings, the new version will return the correct format:

Previous result:
```js
> (new Date("2019-01-15T19:32:52.915Z")).toLocaleString('en-US')
"Tue Jan 15 14:32:52 2019"
```

New result:
```js
> (new Date("2019-01-15T19:32:52.915Z")).toLocaleString('en-US')
"01/15/2019, 02:32:52 PM"
```

 * Invalid expressions following `function(){...}` expressions used to be
   ignored, but in the future will throw a syntax error. For example, a design
   view function like the following will start returning `compilation_error`
   with a `400 HTTP` result.

 * Object key order changed:

Previous result:
```js
> r={}; ["Xyz", "abc", 1].forEach(function(v) {r[v]=v;}); Object.keys(r)
["Xyz", "abc", "1"]
```

New result:
```js
> r={}; ["Xyz", "abc", 1].forEach(function(v) {r[v]=v;}); Object.keys(r)
["1", "Xyz", "abc"]
```

 * `String.prototype.match(undefined)` used to return `null`, and now will return `[""]`:

Previous result:
```js
> "abc".match(undefined)
null
```

New result
```js
> "abc".match(undefined)
[""]
```

For more details see the [Cloudant blog](https://blog.cloudant.com/2024/10/29/QuickJS-for-Faster-Index-Builds.html){: external}).

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
