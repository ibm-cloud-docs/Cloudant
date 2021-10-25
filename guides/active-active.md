---

copyright:
  years: 2017, 2021
lastupdated: "2021-10-20"

keywords: create database, create api key for replication, grant access permission, set up replications, test replication, configure application, active-active configuration, active-passive configuration, failover, recovering from failover

subcollection: Cloudant

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:codeblock: .codeblock}
{:pre: .pre}
{:screen: .screen}
{:tip: .tip}
{:note: .note}
{:important: .important}
{:deprecated: .deprecated}
{:external: target="_blank" .external}

<!-- Acrolinx: 2021-04-15 -->

# Configuring {{site.data.keyword.cloudant_short_notm}} for cross-region disaster recovery
{: #configuring-ibm-cloudant-for-cross-region-disaster-recovery}

The [{{site.data.keyword.cloudant_short_notm}} disaster recovery guide](/docs/Cloudant?topic=Cloudant-disaster-recovery-and-backup#disaster-recovery-and-backup)
explains that one way to enable disaster recovery is to use
{{site.data.keyword.cloudant_short_notm}} replication to create redundancy across regions.
{: shortdesc}

For more information, see how to [retrieve replication scheduler documents](/apidocs/cloudant#getschedulerdocs) and monitor replication status.

You can configure replication in {{site.data.keyword.cloudantfull}} by using an "active-active"
or "active-passive" topology across data centers.

The following diagram shows a typical configuration that
uses two {{site.data.keyword.cloudant_short_notm}} accounts,
one in each region:

![Example active-active architecture](../images/active-active.png){: caption="Figure 1. Example active-active architecture" caption-side="bottom"}

Remember these important facts:

- Within each data center, {{site.data.keyword.cloudant_short_notm}} already offers high availability by storing data in triplicate across three servers.
- Replication occurs at the database rather than account level and must be explicitly configured.
- {{site.data.keyword.cloudant_short_notm}} doesn't provide any Service Level Agreements (SLAs) or certainties about replication latency. {{site.data.keyword.cloudant_short_notm}} doesn't monitor individual replications. Your own strategy for detecting failed replications and restarting them is advisable.

## Before you begin an active-active deployment
{: #before-you-begin-an-active-active-deployment}

For an active-active deployment, a strategy for managing conflicts must be in place, so be sure to understand how [replication](/docs/Cloudant?topic=Cloudant-replication-api#replication-api) and [conflicts](/docs/Cloudant?topic=Cloudant-document-versioning-and-mvcc#document-versioning-and-mvcc) work before you consider this architecture.
{: note}

Email support@cloudant.com if you need help with how to model data to handle conflicts effectively.

## Overview
{: #overview-active-active}

In the following material,
a bidirectional replication is created.
This configuration allows two databases to work in an active-active topology.

The configuration assumes that you have two accounts in different regions:

- `myaccount-dc1.cloudant.com`
- `myaccount-dc2.cloudant.com`

After these accounts are created, follow these steps: 

1. [Create](#step-1-create-your-databases) a pair of peer databases within the accounts.
2. [Set up](#step-2-create-an-api-key-for-your-replications) API keys to use for the replications between these databases.
3. Grant appropriate permissions.
4. Set up replications.
5. Test replications are working as expected.
6. Configure application and infrastructure for either active-active or active-passive use of the databases.

## Step 1. Create your databases
{: #step-1-create-your-databases}

[Create the databases](/apidocs/cloudant#putdatabase){: new_window}{: external} that you want to replicate between
within each account.

In this example,
a database that is called `mydb` is created.

The names that are used for the databases in this example aren't important,
but using the same name is clearer.

```sh
curl "https://myaccount-dc1.cloudant.com/mydb" -XPUT -u myaccount-dc1
curl "https://myaccount-dc2.cloudant.com/mydb" -XPUT -u myaccount-dc2
```
{: codeblock}

## Step 2. Create an API key for your replications
{: #step-2-create-an-api-key-for-your-replications}

It's a good idea to use an [API key](/apidocs/cloudant#introduction) for continuous replications.
The advantage is that if your primary account details change,
for example after a password reset,
your replications can continue unchanged.

API keys aren't tied to a single account.
This means that a single API key can be created,
then granted suitable database permissions for both accounts.

For example,
the following command requests an API key for the account `myaccount-dc1`:

```sh
$ curl -XPOST "https://myaccount-dc1.cloudant.com/_api/v2/api_keys" -u myaccount-dc1
```
{: codeblock}

A successful response is similar to the following abbreviated example:

```json
{
  "password": "YPN...Tfi",
  "ok": true,
  "key": "ble...igl"
}
```
{: codeblock}

Take careful note of the password. It isn't possible to retrieve the password later.
{: important}

## Step 3. Grant access permission
{: #step-3-grant-access-permission}

Give the API Key [permission](/apidocs/cloudant#getsecurity){: new_window}{: external}
to read and to write on both databases.

If you also need to replicate indexes,
assign admin permissions.

Use the {{site.data.keyword.cloudant_short_notm}} Dashboard,
or see the [authorization](/docs/Cloudant?topic=Cloudant-work-with-your-account#authorization) information
for details of how to grant permissions programmatically.

## Step 4. Set up replications
{: #step-4-set-up-replications}

Replications in {{site.data.keyword.cloudant_short_notm}} are always uni-directional:
from one database to another database.
To replicate both ways between two databases,
two replications are required,
one for each direction.

A replication is created in each account that uses the API Key that is created [earlier](#step-2-create-an-api-key-for-your-replications).

First,
create a replication from database `myaccount-dc1.cloudant.com/mydb` to
database `myaccount-dc2.cloudant.com/mydb`.

```sh
curl -XPOST "https://myaccount-dc1.cloudant.com/_replicator"
	-u myaccount-dc1
	-H "Content-Type: application/json"
	-d '{ "_id": "mydb-myaccount-dc1-to-myaccount-dc2",
	"source": "https://ble...igl:YPN...Tfi@myaccount-dc1.cloudant.com/mydb",
	"target": "https://ble...igl:YPN...Tfi@myaccount-dc2.cloudant.com/mydb",
	"continuous": true
}'
```
{: codeblock}

Next,
create a replication from database `myaccount-dc2.cloudant.com/mydb` to
database `myaccount-dc1.cloudant.com/mydb`.

```sh
curl -XPOST "https://myaccount-dc2.cloudant.com/_replicator"
	-u myaccount-dc2
	-H "Content-Type: application/json"
	-d '{ "_id": "mydb-myaccount-dc2-to-myaccount-dc1",
	"source": "https://ble...igl:YPN...Tfi@myaccount-dc2.cloudant.com/mydb",
	"target": "https://ble...igl:YPN...Tfi@myaccount-dc1.cloudant.com/mydb",
	"continuous": true
}'
```
{: codeblock}

If this step fails because the `_replicator` database doesn't exist, create it.
{: note}

## Step 5. Test your replication
{: #step-5-test-your-replication}

Test the replication processes by creating,
modifying,
and deleting documents in either database.

After each change in one database,
check that you can also see that change in the other database.

## Step 6. Configure your application
{: #step-6-configure-your-application}

The databases are set up to remain synchronized with each other.

The next decision is whether to use the databases in an
[active-active](#active-active) or [active-passive](#active-passive) manner.

### Active-active
{: #active-active}

In an active-active configuration,
different application instances can write to
different databases.

For example,
application "A" might write to database `myaccount-dc1.cloudant.com/mydb`,
while application "B" might write to database `myaccount-dc2.cloudant.com/mydb`.

This configuration offers several benefits:

- Load can be spread over several accounts.
- You can configure applications to access an account with reduced latency (not always the geographically closest).

An application can be set up to communicate with the "nearest"
{{site.data.keyword.cloudant_short_notm}} account.
For applications hosted in DC1,
it's appropriate to set their {{site.data.keyword.cloudant_short_notm}}
URL to `"https://myaccount-dc1.cloudant.com/mydb"`.
Similarly,
for applications that are hosted in DC2,
you would set their {{site.data.keyword.cloudant_short_notm}} URL to `"https://myaccount-dc2.cloudant.com/mydb"`.

### Active-passive
{: #active-passive}

In an active-passive configuration,
all instances of an application are configured to use a primary database.
However, the application can fail over to the other backup database,
if circumstances make it necessary.
The failover might be implemented within the application logic itself,
or by using a load balancer,
or by using some other means.

A simple test of whether a failover is required would be to
use the main database endpoint as a "heartbeat".
For example,
a simple `GET` request that is sent to the main database endpoint normally returns
[details about the database](/apidocs/cloudant#getdatabaseinformation){: new_window}{: external}.
If no response is received,
it might indicate that a failover is necessary.

### Other configurations
{: #other-configurations}

You might consider other hybrid approaches for your configuration.

For example,
in a "Write-Primary, Read-Replica" configuration,
all writes go to one database,
but the read load is distributed among the replicas.

## Step 7. Next steps
{: #step-7-next-steps}

- Consider monitoring the [replications](/docs/Cloudant?topic=Cloudant-advanced-replication#advanced-replication) between the databases.
    Use the data to determine whether your configuration might be optimized further.
-	Consider how your design documents and indexes are deployed and updated.
    You might find it more efficient to automate these tasks.

## Failing over between {{site.data.keyword.cloudant_short_notm}} regions
{: #failing-over-between-ibm-cloudant-regions}

Typically,
the process of managing a failover between regions or datacenters is handled higher up within your application stack,
for example by configuring application server failover changes,
or by balancing the load.

{{site.data.keyword.cloudant_short_notm}} doesn't provide a facility for you
to manage explicitly any failover or reroute requests between regions.
This constraint is partly for technical reasons,
and partly because the conditions under when it might happen tend to be application-specific.
For example,
you might want to force a failover in response to a custom performance metric.

However,
if you decide that you need the ability to manage failover,
consider the following possible options:

- Put your own [HTTP proxy in front of {{site.data.keyword.cloudant_short_notm}}](https://github.com/greenmangaming/cloudant-nginx){: new_window}{: external}. Configure your application to talk to the proxy rather than the {{site.data.keyword.cloudant_short_notm}} instance. This configuration means that the task of changing the {{site.data.keyword.cloudant_short_notm}} instances that are used by applications can be handled through a modification to the proxy configuration rather than a modification to the application settings. Many proxies can balance the load, based on user-defined health checks.
- Use a global load balancer such as [{{site.data.keyword.cloud}} Internet Services](/docs/cis?topic=cis-global-load-balancer-glb-concepts#global-load-balancer-glb-concepts){: new_window}{: external} to route to {{site.data.keyword.cloudant_short_notm}}. This option requires a `CNAME` definition that routes to different {{site.data.keyword.cloudant_short_notm}} accounts, based on a health check or latency rule.


## Recovering from failover
{: #recovering-from-failover}

If a single {{site.data.keyword.cloudant_short_notm}} instance is unreachable,
avoid redirecting traffic back to it as soon as it becomes reachable again.
The reason is that some time is required for intensive tasks
such as synchronizing the database state from any peers,
and ensuring that indexes are up to date.

It's helpful to have a mechanism for monitoring these tasks
to help decide when a database is in a suitable state to service your production traffic.

As a guide,
a typical list of checks to apply include:

- [Replications](#replications)
- [Indexes](#indexes)

If you implement rerouting for requests or failover based on a health test, you might want to incorporate corresponding checks to avoid premature rerouting back to a service instance that is still recovering.
{: note}

### Replications
{: #replications}

- Are any replications in an error state?
- Do any replications need restarting?
- How many pending changes are still waiting for replication into the database?

For more information, see how to [retrieve replication scheduler documents](/apidocs/cloudant#getschedulerdocs){: new_window}{: external} and monitor replication status.

If a database is being changed continuously, the replication status is unlikely to zero. You must decide what status threshold is acceptable, or what represents an error state.
{: note}

### Indexes
{: #indexes}

- Are the indexes sufficiently up to date?
   Verify that indexes are updated by using the [active tasks](/docs/Cloudant?topic=Cloudant-active-tasks#active-tasks) endpoint.
- Test the level of "index readiness" by sending a query to the index,
   and deciding whether it returns within an acceptable time.
