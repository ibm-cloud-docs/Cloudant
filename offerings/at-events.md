---

copyright:
  years: 2019, 2020
lastupdated: "2020-04-29"

keywords: principal, action, resource, timestamp, access audit logs

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

<!-- Acrolinx: 2020-03-17 -->

# Activity Tracker integration
{: #at_events}

As a security officer, auditor, or manager, you can use the {{site.data.keyword.at_full}} service to track how users and applications interact with the {{site.data.keyword.cloudantfull}} service in {{site.data.keyword.cloud}}.
{: shortdesc}

{{site.data.keyword.at_full_notm}} records user-initiated activities that change the state of a service in {{site.data.keyword.cloud_notm}}. You can use this service to investigate abnormal activity and critical actions and to comply with regulatory audit requirements. You can also be alerted about actions as they happen. The events that are collected comply with the Cloud Auditing Data Federation (CADF) standard. For more information, see the [Getting started tutorial for {{site.data.keyword.at_full_notm}}](/docs/Activity-Tracker-with-LogDNA?topic=logdnaat-getting-started#getting-started){: new_window}{: external}.

## Types of events
{: #at_event_types}

{{site.data.keyword.cloudant_short_notm}} forwards two types of events to {{site.data.keyword.at_full_notm}}:

- **Management Events** are administrative events that impact the state of an  {{site.data.keyword.cloudant_short_notm}} instance, such as the following management events:
  - Creating or deleting a database. 
  - Updating security settings.
  - Creating a replication job.
  - Creating an index. 
- **Data Events** are all the other events that are involved with interacting with {{site.data.keyword.cloudant_short_notm}}, such as the following events:
  - Reading or writing JSON documents.
  - Reading a list of databases. 
  - Viewing monitoring endpoints.
  - Authenticating against the service.  

A full list of the events, along with their description and type are in the following tables. 

By default, only management events are sent to {{site.data.keyword.at_full_notm}}. You can change what types of events are sent to {{site.data.keyword.at_full_notm}} in the {{site.data.keyword.cloud_notm}} Dashboard by following these steps: 

1. Go to the Resource list, and select an {{site.data.keyword.cloudant_short_notm}} instance.

   The Manage page opens.  
2. Click **Overview**.  
3. On the Deployment Details page, find Activity Tracker event types.
4. Select the appropriate type, either **Management** or **Management & Data**, from the drop-down menu.
5. Click **Save**. 

You can also use an {{site.data.keyword.cloudant_short_notm}} API to change event types that are sent. See details in the following section. 

### API to view and change event types
{: #at_event_types_api}

The API to view and change the event types requires {{site.data.keyword.IBM_notm}} Identity and Access Management (IAM) authentication. The use of {{site.data.keyword.cloudant_short_notm}} legacy authentication isn't supported for this API endpoint. See the [IAM guide](/docs/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-) for details on using IAM authentication for {{site.data.keyword.cloudant_short_notm}}.
{: note}

#### `GET /_api/v2/user/activity_tracker/events`
{: #at_event_types_api_get}

The `/_api/v2/user/activity_tracker/events` endpoint returns an `events` field in the response that includes an array of event types that are being sent to {{site.data.keyword.at_full_notm}} for the {{site.data.keyword.cloudant_short_notm}} instance. 

See the following example request by using HTTP:

```http
GET /_api/v2/user/activity_tracker/events
```
{: codeblock}

See the following example response that shows both management and data event types are being sent:

```json
{
  "types": ["management", "data"]
}
```
{: codeblock}

#### `POST /_api/v2/user/activity_tracker/events`
{: #at_event_types_api_post}

Sending a `POST` to the `/_api/v2/user/activity_tracker/events` endpoint by passing a JSON object with an `events` field. This field includes an array of event types that update the event types that are sent. See the two possible options for the JSON object that is passed to the endpoint:

```json
{
  "types": ["management"]
}
```
{: codeblock}

See the second option for the JSON object that is passed to the endpoint:

```json
{
  "types": ["management", "data"]
}
```
{: codeblock}

See the following example request by using HTTP:

```http
POST /_api/v2/user/activity_tracker/events
```
{: codeblock}

The following example response shows that the update was accepted:

```json
{
  "ok":true
}
```
{: codeblock}

If the `events` field includes invalid event types, then a response similar to the following is returned: 

```json
{
  "code":400,
  "error":"Unknown event types: <unrecognised events>"
}
```
{: codeblock}

If the `events` field is missing, then a response similar to the following is returned: 

```json
{
  "code":400,
  "error":"Missing required events: \"management\""
}
```
{: codeblock}


## List of events
{: #at_actions}

### Management events
{: #at_actions_management}

Action | Description
-------|------------
`cloudantnosqldb.database.create` | Create a database.
`cloudantnosqldb.database.delete` | Delete a database.
`cloudantnosqldb.database-security.read` | Read a security document.
`cloudantnosqldb.database-security.write` | A create, update, or delete of a security document.
`cloudantnosqldb.replication.read` | Read a replication document.
`cloudantnosqldb.replication.write` | A create, update, or delete of a replication document.
`cloudantnosqldb.design-document.write` | A create, update, or delete of a `_design` document.
{: caption="Table 1. Management actions that generate events" caption-side="top"}

### Data events
{: #at_actions_data}

Action | Description
-------|------------
`cloudantnosqldb.sapi.lastactivity` | View last activity timestamp for the instance.
`cloudantnosqldb.sapi.usercors` | View or update CORS settings.
`cloudantnosqldb.sapi.userccmdiagnostics` | View provisioned throughput capacity usage.
`cloudantnosqldb.sapi.userinfo` | View metadata about the instance.
`cloudantnosqldb.sapi.userplan` | View the plan of the instance.
`cloudantnosqldb.sapi.usage-data-volume` | View the data volume.
`cloudantnosqldb.sapi.usage-requests` | View the number of requests.
`cloudantnosqldb.sapi.supportattachments` | Attach files to support tickets in the Cloudant Dashboard.
`cloudantnosqldb.sapi.supporttickets` | View or update support tickets in the Cloudant Dashboard.
`cloudantnosqldb.capacity-throughput.read` | View the provisioned throughput capacity allocated.
`cloudantnosqldb.current-throughput.read` | View the current consumption of provisioned throughput capacity used.
`cloudantnosqldb.limits-throughput.read` | View the limits to provisioned throughput capacity.
`cloudantnosqldb.account-meta-info.read` | View metadata about the instance.
`cloudantnosqldb.account-up.read` | Read the `_up` endpoint.
`cloudantnosqldb.account-all-dbs.read` | Read a list of all databases.
`cloudantnosqldb.account-dbs-info.read` | Read metadata about a database.
`cloudantnosqldb.account-active-tasks.read` | Read `_active_tasks`.
`cloudantnosqldb.users-database-info.read` | Read `_users` database information.
`cloudantnosqldb.users.read` | Read `_users` database documents.
`cloudantnosqldb.iam-session.read` | Read IAM session.
`cloudantnosqldb.iam-session.write` | Write IAM session.
`cloudantnosqldb.iam-session.delete` | Delete IAM session.
`cloudantnosqldb.session.read` | Read {{site.data.keyword.cloudant_short_notm}} legacy auth session.
`cloudantnosqldb.session.write` | Write {{site.data.keyword.cloudant_short_notm}} legacy auth session.
`cloudantnosqldb.session.delete` | Delete {{site.data.keyword.cloudant_short_notm}} legacy auth session.
`cloudantnosqldb.replicator-database-info.read` | Read `_replicator` database information.
`cloudantnosqldb.database-info.read` | Read database metadata.
`cloudantnosqldb.account-search-analyze.execute` | Read search index statistics and size.
`cloudantnosqldb.account-db-updates.read` | Read `_db_updates` endpoint.
`cloudantnosqldb.cluster-uuids.execute` | Read `_uuids` endpoint.
`cloudantnosqldb.database-ensure-full-commit.execute` | Post to `_ensure_full_commit` endpoint.
`cloudantnosqldb.any-document.read` | Read a JSON document.
`cloudantnosqldb.data-document.write` | Write a JSON document.
`cloudantnosqldb.local-document.write` | Write a `_local` document.
`cloudantnosqldb.users-design-document.write` | Write a `_design` document.
`cloudantnosqldb.users-local-document.write` | Write a `_local` document to the `_users` database.
`cloudantnosqldb,replicator-design-document.write` | Write a `_design` document to the `_replicator` database.
`cloudantnosqldb.replicator-local-document.write` | Write a `_local` document to the `_replicator` database.
`cloudantnosqldb.account-uuids.read` | Read `_uuids` endpoint.
{: caption="Table 2. Data actions that generate events" caption-side="top"}

## Viewing events
{: #at_ui}

Events are available in the Dallas, Frankfurt, Tokyo, Sydney, and London locations. 

Events that are generated by an instance of the {{site.data.keyword.cloudant_short_notm}} service are automatically forwarded to the {{site.data.keyword.at_full_notm}} service instance that is available in the same location. 

{{site.data.keyword.at_full_notm}} can have only one instance per location. To view events, you must access the web user interface of the {{site.data.keyword.at_full_notm}} service in the same location where your service instance is available. For more information, see [Launching the web UI through the {{site.data.keyword.cloud_notm}} UI](/docs/Activity-Tracker-with-LogDNA?topic=logdnaat-launch#launch_step2){: new_window}{: external}.
