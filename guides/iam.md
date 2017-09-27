---

copyright:
  years: 2017
lastupdated: "2017-08-23"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-MM-DD -->

# Identity and Access Management

IBM Identity and Access Management (IAM) provides a unified approach to managing
user identities,
services,
and access control.
{:shortdesc}

## Using IAM with Cloudant in Bluemix

Access to Cloudant within Bluemix service instances can be managed with IAM. It can also be managed by using
Cloudant's legacy security mechanisms. This document deals with managing
access using IAM. Using Cloudant's legacy mechanisms, such as `_security`
documents, is described in the [Cloudant documentation](../api/authorization.html).

To help with debugging access problems, this document also gives an overview
of how Cloudant determines whether a request needs to be authorized
using IAM policies or Cloudant's legacy mechanisms.

When using IAM to manage access to a Cloudant service instance, by default,
your Cloudant instance and its databases are private, meaning that only the
Bluemix account owner can access them. Using IAM, access can be granted to
other Bluemix account holders or applications.

You can set up different access policies by using IAM. Currently, Cloudant
supports user-based access policies, where a given user or service is
granted access to Cloudant resources. While there are a wide
variety of policies that can be set up, here are two common examples:

* Allow a Bluemix account holder access to all Cloudant instances on your
    Bluemix account.
* Allow access to just one or more specific instances.

For more information about how to set up and manage access policies,
see the [IAM documentation ![External link icon](../images/launch-glyph.svg "External link icon")](https://console.bluemix.net/docs/iam/iamusermanage.html#iamusermanage). 
You can enable the above examples by using the following policies:

* For all instances, set the service name to `cloudantnosqldb` and
    the subject to the user you want to grant access to.
* For a specific instance, set the service name to `cloudantnosqldb`, set the 
service instance to the instance you want to grant access to, and set the 
subject to the user you want to grant access to.

Once a policy is set up, IAM credentials can be used to access Cloudant
resources. To do this, IAM credentials must be exchanged for an IAM
access token – a time limited authentication token – which is sent
with HTTP requests. To help with this, the Cloudant client libraries can
be configured to use IAM credentials from an application binding or
initialized with an IAM-issued API key. Whether the client libraries are
used or not, the access token sent with the request is used to authenticate
the request to the Cloudant service, which uses the defined access
policies to permit or deny access to the service instance.

## Quick Start

If you are already familiar with IAM, this summary lets you start
assigning roles to users in the context of your Cloudant instances:

* Assign `Administrator` to allow a user to both view and manipulate Cloudant
    data, as well as change other user's permissions on the Cloudant
    instances.
* Assign `Editor` to allow a user to view and manipulate data.
* The `Viewer` role currently has no effect within Cloudant, assigning it
    does not let users view data within the Cloudant instances.

## Cloudant's IAM Roles and Actions

The core of IAM is a mapping of _actions_ to _roles_. Roles are then assigned
to users. When a user makes a request to Cloudant, IAM looks for the roles
that the user has and whether those roles allow the user to make the request.

Cloudant currently has a single action:

* `cloudant.any.any` – this action allows a user to take any action within
    a Cloudant service instance. For example, create and delete databases,
    read and write documents.

IAM has predefined `Viewer`, `Editor` and `Administrator` roles. When used with
Cloudant service instances, `Editor` and `Administrator` are granted permission
to the action `cloudant.any.any`. Therefore a user must be granted one of
these roles before they can access data – even to read it – within a Cloudant
service instance. Being assigned the `Viewer` role does not grant access.

In future, we plan to expand our access control to allow for `Viewer` users.

For more information about the actions and the core IAM roles, see the
[User roles and permissions](https://console.bluemix.net/docs/iam/users_roles.html#userroles) in the IAM documentation.

## Confirming your account is IAM-enabled

Only IAM-enabled accounts will have IAM policies applied to requests.
As we are gradually rolling IAM support out to Bluemix accounts, the
following process tells you whether your account is already enabled:

```
TODO
```

If your account isn't enabled and you'd like it to be bumped to the
head of the queue, write a short note to <support@cloudant.com> with
some details and we'll see what we can do.

## How Cloudant authenticates a request

When Cloudant receives a request, it must decide whether that request is
providing an IAM credential or a legacy Cloudant credential. These
credentials are used to authenticate the user to identify the subject
of a request.

An IAM request is identified by either the request carrying:

* An IAM access token in the Authorization header.
* A cookie obtained from Cloudant's `_iam_session` endpoint.

A legacy Cloudant credential request is identified by the request carrying:

* BasicAuth credentials in the Authorization header.
* A cookie obtained from Cloudant's `_session` endpoint.
* No identifiable credentials.

Capturing request content ensures that appropriate
authentication material to activate IAM or internal Cloudant security
policies is present on the request.

Once the subject is identified, authorization proceeds.

* In the case of an IAM user, Cloudant uses the IAM access policies
    defined for the user to permit or deny a request.
* In the case of legacy Cloudant credentials, Cloudant uses its internal
    access policies to authorize the request (e.g., `_security` documents
    within databases).

## Using IAM with Cloudant's client libraries

The following Cloudant client libraries have been updated to optionally use
IAM-provided credentials:

* [Java](https://github.com/cloudant/java-cloudant/)
* [Python](https://github.com/cloudant/python-cloudant/)
* [Node.js](https://github.com/cloudant/nodejs-cloudant/)
* [CDTDatastore](https://github.com/cloudant/CDTDatastore/)
* [Sync-Android](https://github.com/cloudant/sync-android/)
* [couchbackup](https://github.com/cloudant/couchbackup/)

Each of these libraries contains data in its README.md on how to use it with
either a bound application with access to the `VCAP_SERVICES` environment
variable or to manually initialize the library with an API key generated
within IAM. The libraries automatically handle retrieving IAM access
tokens as required using the API keys they are initialized with.

> **Note**: Using IAM with the VCAP initializers is not supported 
in the client libraries.