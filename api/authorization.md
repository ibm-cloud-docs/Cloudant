---

copyright:
  years: 2015, 2020
lastupdated: "2020-09-09"

keywords: authorization, roles, permissions, view permissions, modify permissions, _users database, API keys, create API key, use API key, delete API key, _admin, _reader, _writer, _design, _replicator, _security, assign role

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

<!-- Acrolinx: 2020-04-23 -->

# Authorization
{: #authorization}

After [authenticating](/docs/Cloudant?topic=Cloudant-authentication#authentication),
the next test is to decide whether you're allowed to do certain tasks.
This decision is called authorization.
{: shortdesc}

When you authenticate with the {{site.data.keyword.cloudantfull}} system,
it "knows" who you are.
The next question is, what tasks are you allowed to do?

You might create a complete list of all the possible tasks that you can do,
for each aspect of an {{site.data.keyword.cloudant_short_notm}} system, such as a database or a document.
Although simple,
this approach would require many lengthy lists.
Keeping those lists accurate and complete is impractical.

A better approach uses the idea of "roles".
The various tasks can be grouped into collections that are typical of some generic roles.
For example,
the task of creating or deleting a database is characteristic of someone with an administrative role.
Similarly,
the task or creating or updating a document is characteristic of someone with a "writing" role.

Rather than explicitly listing every task you can do,
you're given one or more roles.
If you have a role,
then you can do all the tasks that are associated with that role.

## Roles
{: #roles}

{{site.data.keyword.cloudant_short_notm}} has a number of roles available.
The roles can be assigned to user accounts or [API keys](/docs/Cloudant?topic=Cloudant-authorization#creating-api-keys).

The three core roles are defined in the following table:

Role      | Description
----------|------------
`_admin`  | Change security settings, including adding roles.
`_reader` | Read documents from the database.
`_writer` | Create, update, and delete documents (except design documents) in the database.
{: caption="Table 1. Core roles" caption-side="top"}

The `_reader` and `_writer` roles are exclusive. If a user has the `_writer` role, they can't read documents that they create unless they *also* have the `_reader` role.
{: tip}

You might want to assign more than one role.
For example,
a user might need to read from or write to documents within a database,
but wouldn't need full administrative control over the database.
To fulfill this requirement,
the user's account is granted the `_reader` and `_writer` roles,
but not the `_admin` role.

A number of "focused" roles are also available.
These provide permissions for specific API endpoints.
The focused role permissions are similar to the core role permissions,
but apply *only* to the specific API endpoint.

The focused roles are defined in the following table:

Role | Description | API Endpoints
-----|-------------|---------------
`_design`     | Allows create, read, modify, or delete access to design documents. | [`_design`](/docs/Cloudant?topic=Cloudant-design-documents#design-documents), [`_find`](/docs/Cloudant?topic=Cloudant-query#finding-documents-by-using-an-index), [`_index`](/docs/Cloudant?topic=Cloudant-query#working-with-indexes)
`_replicator` | Allows read access to replicate data from a database, and write access to create checkpoints. | [`_local`](/docs/Cloudant?topic=Cloudant-replication-api#the-since_seq-field), [`_replicate`](/docs/Cloudant?topic=Cloudant-advanced-replication#the-_replicate-endpoint), [`_replicator`](/docs/Cloudant?topic=Cloudant-replication-api#the-_replicator-database)
`_security`   | Allows read and write access to the `/$DATABASE/_security` endpoint. | [`_security`](/docs/Cloudant?topic=Cloudant-authorization#viewing-permissions)
{: caption="Table 2. Focused roles" caption-side="top"}

The nature of the access that is granted depends on the specific API endpoint.
For example,
the `_design` role provides access that allows a user or [API key](/docs/Cloudant?topic=Cloudant-authorization#creating-api-keys) to create,
read,
modify,
or delete design documents. If you grant access this way, the advantage is that you're not required to assign the more widely applicable `_reader` or `_writer` roles.
This distinction is useful because otherwise the authorized account could read from or write to documents within the database,
other than the design documents.

The credentials that you use to log in to the dashboard automatically have the `_admin` role for all databases you create.
Everyone and everything else,
including users that you share databases with,
and API keys you create,
must be given a role explicitly to do corresponding tasks.

The special `nobody` username applies for anyone or any application that tries to do tasks,
but that didn't authenticate with the system.
In other words,
the `nobody` username applies to all unauthenticated connection attempts.
For example,
if an application tries to read data from a database,
but didn't identify itself,
the task can continue only if the `nobody` user has the role `_reader`.

It's possible to grant more powerful roles to an *un*authenticated user than to an authenticated user.
For example,
if the `nobody` username is intentionally granted `_admin`,
`_reader`,
and `_writer` roles,
but an authenticated user account such as `alexone` is granted only the `_reader` role. In this case, it's possible that an unauthenticated user might have a more powerful role than the authenticated `alexone` user. 

It's important to understand that the `nobody` username is *not* a way of supplying a default set of permissions. Instead, the `nobody` username is used to determine permissions for *unauthenticated* users.
{: tip}

### Determining the role to assign
{: #determining-the-role-to-assign}

When you determine the role or roles to assign to a user account or API key,
it's best to assign a role with the least permissions necessary to do the tasks for that account or API key.

If the tasks are for a specific aspect,
such as working with design documents or security settings,
then assign a focused role, such as `_design` or `_security`.

## Viewing permissions
{: #viewing-permissions}

To see who has permissions to read,
write,
and manage the database,
send a `GET` request to `https://$ACCOUNT.cloudant.com/_api/v2/db/$DATABASE/_security`.

See the following example that uses an HTTP request to determine permissions:

```http
GET /_api/v2/db/$DATABASE/_security HTTP/1.1
```
{: codeblock}

See the following example that uses a command-line request to determine permissions:

```sh
curl "https://$ACCOUNT.cloudant.com/_api/v2/db/$DATABASE/_security"
```
{: codeblock}

<!--

See the following example request to determine permissions by using Javascript:

```javascript
var nano = require('nano');
var account = nano("https://"+$ACCOUNT+":"+$PASSWORD+"@"+$ACCOUNT+".cloudant.com");
account.request({
	db: $DATABASE,
	path: '_security'
	},
	function (err, body, headers) {
		if (!err) {
			console.log(body);
		}
	}
});
```
{: codeblock}

-->

The `cloudant` field in the response object includes an object with keys that are the usernames
that have permission to interact with the database.
The `nobody` username indicates what permissions are available to unauthenticated users,
that is,
any request made without authentication credentials.

In the following example response,
the `nobody` username has `_reader` permissions.
This combination means that the database is publicly readable to unauthenticated users.

See the following example response to a request for permissions:

```json
{
	"cloudant": {
		"antsellseadespecteposene": [
			"_reader",
			"_writer",
			"_admin"
		],
		"garbados": [
			"_reader",
			"_writer",
			"_admin"
		],
		"nobody": [
			"_reader"
		]
	},
	"_id": "_security"
}
```
{: codeblock}

## Modifying permissions
{: #modifying-permissions}

To modify who has permissions to read,
write,
or manage a database,
send a `PUT` request to `https://$ACCOUNT.cloudant.com/_api/v2/db/$DATABASE/_security`.
To see what roles you can assign,
see [Roles](/docs/Cloudant?topic=Cloudant-authorization#roles).

See the following example that uses HTTP to send an authorization modification request:

```http
PUT /_api/v2/db/$DATABASE/_security HTTP/1.1
Content-Type: application/json
```
{: codeblock}

See the following example that uses the command line to send an authorization modification request:

```sh
curl "https://$ACCOUNT.cloudant.com/_api/v2/db/$DATABASE/_security" \
	-X PUT \
	-H "Content-Type: application/json" \
	-d "$JSON"
```
{: codeblock}

<!--

See the following example that uses JavaScript to send an authorization modification request:

```javascript
var nano = require('nano');
var account = nano("https://"+$ACCOUNT+":"+$PASSWORD+"@"+$ACCOUNT+".cloudant.com");
account.request(
	{
		db: $DATABASE,
		path: '_security',
		method: 'PUT',
		body: '$JSON'
	},
	function (err, body, headers) {
		if (!err) {
			console.log(body);
		}
	}
);
```
{: codeblock}

-->

The request must provide a document in JSON format,
describing a `cloudant` field.
The field includes an object with keys that are the usernames that have permission to interact with the database.
The `nobody` username indicates what permissions are available to unauthenticated users,
that is,
anybody.

In the following example request,
the `nobody` username is given `_reader` permissions.
This authorization makes the database publicly readable.

See the following example of an authorization modification request document:

```json
{
	"cloudant": {
		"antsellseadespecteposene": [
			"_reader",
			"_writer",
			"_admin"
		],
		"garbados": [
			"_reader",
			"_writer",
			"_admin"
		],
		"nobody": [
			"_reader"
		]
	}
}
```
{: codeblock}

The response indicates whether the update was successful.

See the following example response after a successful authorization modification request:

```json
{
	"ok" : true
}
```
{: codeblock}

You must run the `GET` command first to retrieve the security object.
Then,
you can modify that security object with new permissions.
If you don't run the `GET` command and retrieve the security object before you run an API call,
the result might disrupt your environment.
For example,
if you want to add a `nobody` user with read-only access,
the  following incorrect request removes *all* the other users with access to the database.

See the following example of an incorrect authorization modification request document:

```json
{
    "cloudant": {
        "nobody": [
            "_reader"
        ]
    }
}
```
{: codeblock}

## API keys
{: #api-keys}

Use API keys to enable database access for a person or application,
but without creating a new {{site.data.keyword.cloudant_short_notm}} account for that person or application.
An API key is a randomly generated username and password.
The key is given the wanted access permissions for a database.

When a key is generated,
and granted the required access permissions,
the API key can be used in the same way as a normal user account.

However, API keys aren't the same as normal user accounts.
An API key doesn't have access to the dashboard.

An API key is primarily used to enable applications to access a database,
with a determined level of access control.

All {{site.data.keyword.cloudant_short_notm}} instances that are deployed 
from the {{site.data.keyword.cloud}} Public Germany 
region are deployed in EU-managed environments. Any 
{{site.data.keyword.cloudant_short_notm}} account or 
API key that is generated outside an EU-managed environment can't be granted 
access to an EU-managed {{site.data.keyword.cloudant_short_notm}} instance. 
For more information about {{site.data.keyword.cloudant_short_notm}} 
in an EU-managed environment, see 
[Locations and tenancy](/docs/Cloudant?topic=Cloudant-ibm-cloud-public#locations-and-tenancy).
{: tip}


## Creating API keys
{: #creating-api-keys}

An earlier method of generating API keys by `POST`ing to the `https://cloudant.com/api/generate_api_key` endpoint is deprecated.
{: deprecated}

You can create an API key in two ways:

1.  Using the dashboard.
2.  Using the {{site.data.keyword.cloudant_short_notm}} API.

No matter what method you choose,
remember to record the key name and password.
These values are both randomly generated,
and can't be retrieved if lost or forgotten.

[{{site.data.keyword.cloudant_short_notm}} Data Layer Local Edition ("Cloudant Local"))](/docs/Cloudant?topic=Cloudant-ibm-cloudant-local-overview) doesn't support API Keys. For a similar capability, create "CouchDB" style users, as described in the [{{site.data.keyword.IBM_notm}} Knowledge Center](/docs/Cloudant?topic=Cloudant-configure-ibm-cloudant-data-layer-local-edition#configuring-database-level-security).
{: note}

See the following example that uses an HTTP request to create an API key:

```http
POST https://$ACCOUNT.cloudant.com/_api/v2/api_keys HTTP/1.1
```
{: codeblock}

See the following example that uses the command line to create an API key:

```sh
curl -X POST "https://$ACCOUNT:$PASSWORD@$ACCOUNT.cloudant.com/_api/v2/api_keys"
```
{: codeblock}

<!--

See the following example that uses JavaScript to create an API key:

```javascript
var nano = require('nano');
var account = nano("https://$ACCOUNT:$PASSWORD@cloudant.com");
account.request(
	{
		db: '_api',
		path: 'v2/api_keys',
		method: 'POST'
	},
	function (err, body) {
		if (!err) {
			console.log(body);
		}
	}
);
```
{: codeblock}

-->

The response includes the generated key and password.

See the following example response to request an API key:

```json
{
	"password": "YPNCaIX1sJRX5upaL3eqvTfi",
	"ok": true,
	"key": "blentfortedsionstrindigl"
}
```
{: codeblock}

## Using API keys
{: #using-api-keys}

API keys are typically generated by using an account that has at least one database.
It's possible to use the API key with other databases,
or even with other accounts.

By default,
an API key has no permissions for anything.
It must be given permissions explicitly.

After you generate the API key,
grant the key access-specific permissions for a specific database by sending a `PUT` request to 
`https://$ACCOUNT.cloudant.com/_api/v2/db/$DATABASE/_security`,
as described in [modifying permissions](/docs/Cloudant?topic=Cloudant-authorization#modifying-permissions).

The database doesn't have to be in the same account as the account used for generating the API key initially.

To give an existing API key permissions to access a database in another account,
do the following steps:

1.  Retrieve the existing [security permissions](/docs/Cloudant?topic=Cloudant-authorization#viewing-permissions) for the database.
2.  [Add](/docs/Cloudant?topic=Cloudant-authorization#modifying-permissions) the details of the API key to the database security permissions, along with the [roles](/docs/Cloudant?topic=Cloudant-authorization#roles) required.

For an example of this process,
see the blog article:
[Using an {{site.data.keyword.cloudant_short_notm}} API Key with Multiple {{site.data.keyword.cloudant_short_notm}} Databases and Accounts](https://dx13.co.uk/articles/2016/04/11/using-a-cloudant-api-key-with-multiple-cloudant-databases-and-accounts/){: new_window}{: external}.

Now a request can be made with the API key as shown in the following example:
```sh
curl -u$APIKEY:$APIPASSWORD -X GET "https://$ACCOUNT.cloudant.com/$DATABASE/" \
```
{: codeblock}

## Deleting API keys
{: #deleting-api-keys}

It's not possible to delete an API key.
An API key is always available for use if you know the key and its password.
However,
the API key is only useful when:

-   Assigned to a database.
-   Assigned permissions for working with the database.

To "delete" an API key,
remove it from the database.
All the permissions that were previously assigned to the API key for it to work with that database are then removed.

### To remove an API key by using the Dashboard
{: #to-remove-an-api-key-by-using-the-dashboard}

1.	Click `Databases` > `Permissions`.
2.	Hover over the API key you would like to delete.
3.	Click the "`X`" that appears when you hover over the API key.

### To remove an API key by using the {{site.data.keyword.cloudant_short_notm}} API
{: #to-remove-an-api-key-by-using-the-cloudant-nosql-db-api}

Use the [modifying permissions](/docs/Cloudant?topic=Cloudant-authorization#modifying-permissions) technique to remove the API key from the list of users with access permission.

This technique works because an API key is similar to a user,
and is granted access permissions.
By removing the API key from the list of users that have access permissions,
you remove the API key from the list of users that have access to the database.

To remove the API key,
send an HTTP `PUT` request to the same `_security` API endpoint you used to [create the API key](/docs/Cloudant?topic=Cloudant-authorization#creating-api-keys).
Provide an updated list of the usernames that have access permission.
The updated list must not include the API key.

## Using the `_users` database with {{site.data.keyword.cloudant_short_notm}}
{: #using-the-_users-database-with-cloudant-nosql-db}

You can use the
[`_users` database](http://docs.couchdb.org/en/stable/intro/security.html#authentication-database){: new_window}{: external}
to manage roles in {{site.data.keyword.cloudant_short_notm}}.

User documents that are stored in the `_users` database must be structured and populated to comply with
[Apache Software Foundation CouchDB requirements](https://docs.couchdb.org/en/stable/intro/security.html?highlight=security#users-documents){: new_window}{: external}.

You can disable the {{site.data.keyword.cloudant_short_notm}} authorization checks by setting the `couchdb_auth_only:true` parameter. 
To disable {{site.data.keyword.cloudant_short_notm}} security,
`PUT` a JSON document to the `_security` endpoint of the database.
For example, `https://$ACCOUNT.cloudant.com/$DATABASE/_security`.

See the following example that uses HTTP to submit a modification request:

```http
PUT /$DATABASE/_security HTTP/1.1
Content-Type: application/json
```
{: codeblock}

See the following example that uses the command line to submit a modification request:

```sh
curl "https://$ACCOUNT.cloudant.com/$DATABASE/_security" \
	-X PUT \
	-H "Content-Type: application/json" \
	-d @request-body.json
```
{: codeblock}

See the following example modification request in JSON format:

```json
{
	"couchdb_auth_only": true,
	"members": {
		"names": ["member"],"roles":[]
	},
	"admins": {
		"names": ["admin"],"roles":[]
	}
}
```
{: codeblock}

See the following example response from a modification request:

```json
{
	"ok" : true
}
```
{: codeblock}
