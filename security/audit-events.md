---

copyright:
  years: 2019, 2020
lastupdated: "2020-06-25"

keywords: principal, action, resource, timestamp, access audit logs, activity tracker

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

<!-- Acrolinx: 2020-03-17 -->

# Auditing events
{: #at_events}

As a security officer, auditor, or manager, you can use the {{site.data.keyword.at_full}} service to track how users and applications interact with the {{site.data.keyword.cloudantfull}} service in {{site.data.keyword.cloud}}.
{: shortdesc}

{{site.data.keyword.at_full_notm}} records user-initiated activities that change the state of a service in {{site.data.keyword.cloud_notm}}. You can use this service to investigate abnormal activity and critical actions and to comply with regulatory audit requirements. You can also be alerted about actions as they happen. The events that are collected comply with the Cloud Auditing Data Federation (CADF) standard. For more information, see the [Getting started tutorial for {{site.data.keyword.at_full_notm}}](/docs/Activity-Tracker-with-LogDNA?topic=Activity-Tracker-with-LogDNA-getting-started){: new_window}{: external}.

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


By default, only management events are automatically collected and sent to the {{site.data.keyword.at_full_notm}} service.
{: note}

You must configure each {{site.data.keyword.cloudant_short_notm}} instance to collect and send data events to the {{site.data.keyword.at_full_notm}} service.
{: important}

## Configuring data events for an {{site.data.keyword.cloudant_short_notm}} instance
{: #at_event_configure}


### Configuring data events through the {{site.data.keyword.cloud_notm}} UI
{: #at_event_configure_ui}

You can change what types of events are sent to {{site.data.keyword.at_full_notm}} in the {{site.data.keyword.cloud_notm}} Dashboard by following these steps:

1. Go to the Resource list, and select an {{site.data.keyword.cloudant_short_notm}} instance.

   The Manage page opens.

2. Click **Overview**.
3. On the Deployment Details page, find Activity Tracker event types.
4. Select the appropriate type, either **Management** or **Management & Data**, from the drop-down menu.
5. Click **Save**.


### Configuring data events by using the {{site.data.keyword.cloudant_short_notm}} API
{: #at_event_configure_api}

You can use the {{site.data.keyword.cloudant_short_notm}} API to manage the configuration of Activity Tracker events.

The API to view and change the event types requires {{site.data.keyword.IBM_notm}} Identity and Access Management (IAM) authentication. The use of {{site.data.keyword.cloudant_short_notm}} legacy authentication isn't supported for this API endpoint. See the [IAM guide](/docs/Cloudant?topic=Cloudant-ibm-cloud-identity-and-access-management-iam-) for details on using IAM authentication for {{site.data.keyword.cloudant_short_notm}}.
{: important}

#### Check what event types are configured for an {{site.data.keyword.cloudant_short_notm}} instance
{: #at_event_configure_api_get}

The `/_api/v2/user/activity_tracker/events` endpoint returns an `events` field in the response that includes an array of event types that are being sent to {{site.data.keyword.at_full_notm}} for the {{site.data.keyword.cloudant_short_notm}} instance.

See the following example request by using HTTP:

```http
GET /_api/v2/user/activity_tracker/events
```
{: codeblock}

See the following example request by using cURL. Complete the following steps:

1. Get an IAM token. For example, you can run the following command from the command line:

    ```
    ibmcloud iam oauth-tokens | awk '{print $4}'
    ```
    {: pre}

2. Get the external endpoint that is associated with the {{site.data.keyword.cloudant_short_notm}} instance.

    a. Go to the Resource list.
    b. Select the {{site.data.keyword.cloudant_short_notm}} instance.
    c. In the *Manage* section, select **Overview**.
       You can find the external endpoint in the *Deployment details* section.

3. Run a cURL command to get the information:

    ```
    curl -X GET -H "Authorization: Bearer $JWT" https://499678c3-ead7-4731-b96a-fcb2974cb042-bluemix.cloudant.com/_api/v2/user/activity_tracker/events
    ```
    {: pre}


When you check what events are enabled, you get one of the following responses:

* Response when both management and data event types are sent:

    ```json
    {"types": ["management", "data"]}
    ```
    {: codeblock}

* Response when only management events are sent:

    ```json
    {"types": ["management"]}
    ```
    {: screen}



#### Configure data events for a {{site.data.keyword.cloudant_short_notm}} instance
{: #at_event_configure_api_post}


You can configure data events by sending a `POST` to the `/_api/v2/user/activity_tracker/events` endpoint and passing a JSON object with an `events` field.

See the following example request by using a cURL command:

```
curl https://4ca678c3-ead7-4731-b96a-fcb2974cb042-bluemix.cloudant.com/_api/v2/user/activity_tracker/events -X POST   -d '{"types": ["management", "data"]}' -H "content-type: application/json" -H "Authorization: Bearer $JWT"
```
{: pre}


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

It can take up to 5 minutes for the change to be reflected in the events seen in {{site.data.keyword.at_full_notm}}.
{: note}


## List of events
{: #at_actions-audit-events}

### Management events
{: #at_actions_management-audit-events}

Action | Description
-------|------------
`cloudantnosqldb.database.create` | Create a database.
`cloudantnosqldb.database.delete` | Delete a database.
`cloudantnosqldb.replicator-database.create` | Create `_replicator` database.
`cloudantnosqldb.replicator-database.delete` | Delete `_replicator` database.
`cloudantnosqldb.users-database.create` | Create `_users` database.
`cloudantnosqldb.users-database.delete` | Delete `_users` database.
`cloudantnosqldb.database-security.read` | Read a security document.
`cloudantnosqldb.database-security.write` | A create, update, or delete of a security document.
`cloudantnosqldb.replication.read` | Read a replication document.
`cloudantnosqldb.replication.write` | A create, update, or delete of a replication document.
`cloudantnosqldb.design-document.write` | A create, update, or delete of a `_design` document.
{: caption="Table 1. Management actions that generate events" caption-side="top"}

### Data events
{: #at_actions_data-audit-events}

Action | Description
-------|------------
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
{: #at_ui_ma}

Events are available in the Dallas, Frankfurt, Tokyo, Sydney, and London locations. For more information, see [{{site.data.keyword.cloud_notm}} services locations](/docs/Activity-Tracker-with-LogDNA?topic=Activity-Tracker-with-LogDNA-cloud_services_locations).

Management events that are generated by an instance of the {{site.data.keyword.cloudant_short_notm}} service are automatically collected and forwarded to the {{site.data.keyword.at_full_notm}} service instance that is available in the same location.

You must enable data events for the {{site.data.keyword.cloudant_short_notm}} instance to be able to view them through the {{site.data.keyword.at_full_notm}} instance that is available in the same location as your {{site.data.keyword.cloudant_short_notm}} instance.

{{site.data.keyword.at_full_notm}} can have only one instance per location. To view events, you must access the web user interface of the {{site.data.keyword.at_full_notm}} service in the same location where your service instance is available. For more information, see [Launching the web UI through the {{site.data.keyword.cloud_notm}} UI](/docs/Activity-Tracker-with-LogDNA?topic=Activity-Tracker-with-LogDNA-launch).

