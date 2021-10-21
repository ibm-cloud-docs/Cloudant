---

copyright:
  years: 2019, 2021
lastupdated: "2021-10-21"

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

<!-- Acrolinx: 2021-04-13 -->

# Auditing events
{: #at_events}

As a security officer, auditor, or manager, you can use the {{site.data.keyword.at_full}} service to track how users and applications interact with the {{site.data.keyword.cloudantfull}} service in {{site.data.keyword.cloud}}.
{: shortdesc}

{{site.data.keyword.at_full_notm}} records user-initiated activities that change the state of a service in {{site.data.keyword.cloud_notm}}. You can use this service to investigate abnormal activity and critical actions and to comply with regulatory audit requirements. You can also be alerted about actions as they happen. The events that are collected comply with the Cloud Auditing Data Federation (CADF) standard. For more information, see the [Getting started tutorial for {{site.data.keyword.at_full_notm}}](/docs/activity-tracker?topic=activity-tracker-getting-started){: new_window}{: external}.

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
   The Deployment Details pane opens.
3. Find *Activity Tracker event types* in the list.
4. Select the appropriate type, either **Management** or **Management & Data**, from the drop-down menu.
5. Click **Save**.


### Configuring data events by using the {{site.data.keyword.cloudant_short_notm}} API
{: #at_event_configure_api}

You can use the {{site.data.keyword.cloudant_short_notm}} API to manage the configuration of Activity Tracker events.

The API to view and change the event types requires {{site.data.keyword.IBM_notm}} Identity and Access Management (IAM) authentication. The use of {{site.data.keyword.cloudant_short_notm}} legacy authentication isn't supported for this API endpoint. See [Managing access](/docs/Cloudant?topic=Cloudant-managing-access-for-cloudant) for details on using IAM authentication for {{site.data.keyword.cloudant_short_notm}}.
{: important}

#### Check what event types are configured for an {{site.data.keyword.cloudant_short_notm}} instance
{: #at_event_configure_api_get}

The `/_api/v2/user/activity_tracker/events` endpoint returns a `types` field in the response that includes an array of event types that are being sent to {{site.data.keyword.at_full_notm}} for the {{site.data.keyword.cloudant_short_notm}} instance.

See the following example request by using HTTP:

```http
GET /_api/v2/user/activity_tracker/events
```
{: codeblock}

See the following example request by using cURL. Complete the following steps:

1. Get an IAM token. For example, you can run the following command from the command line:

    ```sh
    ibmcloud iam oauth-tokens | awk '{print $4}'
    ```
    {: pre}

2. Get the external endpoint that is associated with the {{site.data.keyword.cloudant_short_notm}} instance.

    a. Go to the Resource list. </br>
    b. Select the {{site.data.keyword.cloudant_short_notm}} instance.</br>
    c. In the *Manage* section, select **Overview**.</br>
       You can find the external endpoint in the *Deployment details* section.

3. Run a cURL command to get the information:

    ```sh
    curl -X GET -H "Authorization: Bearer $JWT" https://499678c3-ead7-4731-b96a-fcb2974cb042-bluemix.cloudant.com/_api/v2/user/activity_tracker/events
    ```
    {: pre}


When you check what events are enabled, you get one of the following responses.

- Response when both management and data event types are sent:

    ```json
    {"types": ["management", "data"]}
    ```
    {: codeblock}

- Response when only management events are sent:

    ```json
    {"types": ["management"]}
    ```
    {: screen}



#### Configure data events for an {{site.data.keyword.cloudant_short_notm}} instance
{: #at_event_configure_api_post}


You can configure data events by sending a `POST` to the `/_api/v2/user/activity_tracker/events` endpoint and passing a JSON object with a `types` field.

See the following example request by using a cURL command:

```shßß
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

If the `types` field includes invalid event types, then a response similar to the following one is returned:

```json
{
  "code":400,
  "error":"Unknown event types: <unrecognised events>"
}
```
{: codeblock}

If the `types` field is missing, then a similar response to the following one is returned:

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
`cloudantnosqldb.account-status.configure` | Set the status of an instance. 
`cloudantnosqldb.account-status.read` | Get the status of an instance. 
`cloudantnosqldb.activity-tracker-event-types.read` | Get the configured event types of an instance. 
`cloudantnosqldb.activity-tracker-event-types.write` | Configure the event types for an instance. 
`cloudantnosqldb.capacity-throughput.read` | Get the current provisioned throughput capacity settings for an instance. 
`cloudantnosqldb.capacity-throughput.write` | Set the provisioned throughput capacity settings for an instance. 
`cloudantnosqldb.csp.capture` | Indicates a Content Security Policy failure when you access the Cloudant Dashboard. 
`cloudantnosqldb.database.create` | Create a database. 
`cloudantnosqldb.database.delete` | Delete a database. 
`cloudantnosqldb.ibm-cloud-account-status.configure` | Set the status of an instance. 
`cloudantnosqldb.ibm-cloud-account-status.read` | Get the status of an instance. 
`cloudantnosqldb.legacy-credentials.revoke` | Revoke all legacy credentials and make IAM the only authentication method of an instance. 
`cloudantnosqldb.replicator-database.create` | Create `_replicator` database. 
`cloudantnosqldb.replicator-database.delete` | Delete `_replicator` database. 
`cloudantnosqldb.users-database.create` | Create `_users` database. 
`cloudantnosqldb.users-database.delete` | Delete `_users` database. 
`cloudantnosqldb.database-security.read` | Read a security document. 
`cloudantnosqldb.database-security.write` | A create, update, or delete of a security document. 
`cloudantnosqldb.design-document.write` | A create, update, or delete of a `_design` document. 
`cloudantnosqldb.replication.read` | Read a replication document. 
`cloudantnosqldb.replication.write` | A create, update, or delete of a replication document. 
`cloudantnosqldb.sapi.apikeys` | Create a legacy Cloudant API key for an instance. 
`cloudantnosqldb.sapi.db-security` | Read or write a database's security document. 
`cloudantnosqldb.sapi.usercors` | Set and get the CORS settings for an instance. 
`cloudantnosqldb.sapi.userplan` | Get or set plan and plan settings of an instance. 
`cloudantnosqldb.users.write` | Create, update, or delete a `_users` document. 
`cloudantnosqldb.volumes.update` | A change in state of the {{site.data.keyword.keymanagementservicefull}} key protecting dedicated hardware environment. 
{: caption="Table 1. Management actions" caption-side="top"}

### Data events
{: #at_actions_data-audit-events}

Action | Description
-------|------------
`cloudantnosqldb.any-document.read` | Read a JSON document. 
`cloudantnosqldb.account-all-dbs.read` | Read a list of all databases. 
`cloudantnosqldb.account-dbs-info.read` | Read metadata about a database. 
`cloudantnosqldb.account-db-updates.read` | Read `_db_updates` endpoint. 
`cloudantnosqldb.account-search-analyze.execute` | Read search index statistics and size. 
`cloudantnosqldb.account-uuids.read` | Read `_uuids` endpoint. 
`cloudantnosqldb.account-active-tasks.read` | Read `_active_tasks`. 
`cloudantnosqldb.current-throughput.read` | Get the current consumption of the provisioned throughput capacity for an instance. 
`cloudantnosqldb.database-ensure-full-commit.execute` | Post to `_ensure_full_commit` endpoint. 
`cloudantnosqldb.database-info.read` | Read database metadata. 
`cloudantnosqldb.data-document.write` | Write a JSON document. 
`cloudantnosqldb.iam-session.read` | Read IAM session. 
`cloudantnosqldb.iam-session.write` | Write IAM session. 
`cloudantnosqldb.iam-session.delete` | Delete IAM session. 
`cloudantnosqldb.ibmid-login.authenticate` | Complete IAM authentication on the Cloudant Dashboard. 
`cloudantnosqldb.ibmid-login.receive` | Part of the Cloudant Dashboard login with IAM authentication. 
`cloudantnosqldb.ibmid-login.start` | Initiate Cloudant Dashboard login with IAM authentication. 
`cloudantnosqldb.local-document.write` | Write a `_local` document. 
`cloudantnosqldb.replicator-database-info.read` | Read `_replicator` database information. 
`cloudantnosqldb,replicator-design-document.write` | Write a `_design` document to the `_replicator` database. 
`cloudantnosqldb.replicator-local-document.write` | Write a `_local` document to the `_replicator` database. 
`cloudantnosqldb.sapi.lastactivity` | Get the last active time of an instance. Used internally by the IBM Cloud platform. 
`cloudantnosqldb.sapi.supportattachments` | Attach file to support ticket. 
`cloudantnosqldb.sapi.supporttickets` | Create, read, and delete support tickets. 
`cloudantnosqldb.sapi.usage-data-volume` | Get the data usage of an instance. 
`cloudantnosqldb.sapi.userccmdiagnostics` | Get history of throughput consumption and 429 requests for the past 5 seconds. 
`cloudantnosqldb.sapi.userinfo` | Get metadata of an instance. 
`cloudantnosqldb.session.delete` | Delete {{site.data.keyword.cloudant_short_notm}} legacy auth session. 
`cloudantnosqldb.session.read` | Read {{site.data.keyword.cloudant_short_notm}} legacy auth session. 
`cloudantnosqldb.session.write` | Write {{site.data.keyword.cloudant_short_notm}} legacy auth session. 
`cloudantnosqldb.users.read` | Read `_users` database documents. 
`cloudantnosqldb.users-database-info.read` | Read `_users` database information. 
`cloudantnosqldb.users-design-document.write` | Write a `_design` document. 
`cloudantnosqldb.users-local-document.write` | Write a `_local` document to the `_users` database. 
{: caption="Table 2. Data actions" caption-side="top"}


## Viewing events
{: #at_ui_ma}

Events are available in the Dallas, Washington DC, Frankfurt, Tokyo, Sydney, and London locations. For more information, see [{{site.data.keyword.cloud_notm}} services locations](/docs/activity-tracker?topic=activity-tracker-cloud_services_locations).

Management events that are generated by an instance of the {{site.data.keyword.cloudant_short_notm}} service are automatically collected and forwarded to the {{site.data.keyword.at_full_notm}} service instance that is available in the same location.

You must enable data events for the {{site.data.keyword.cloudant_short_notm}} instance to be able to view them through the {{site.data.keyword.at_full_notm}} instance that is available in the same location as your {{site.data.keyword.cloudant_short_notm}} instance.

{{site.data.keyword.at_full_notm}} can have only one instance per location. To view events, you must access the web user interface of the {{site.data.keyword.at_full_notm}} service in the same location where your service instance is available. For more information, see how to [start the web UI through the {{site.data.keyword.cloud_notm}} UI](/docs/Activity-Tracker-with-LogDNA?topic=Activity-Tracker-with-LogDNA-launch).

