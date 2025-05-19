---

copyright:
  years: 2019, 2025
lastupdated: "2025-05-19"

keywords: principal, action, resource, timestamp, access audit logs, activity tracker

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# Auditing events
{: #at_events}

As a security officer, auditor, or manager, you can use the {{site.data.keyword.atracker_full}} service to track how users and applications interact with the {{site.data.keyword.cloudantfull}} service in {{site.data.keyword.cloud}}.
{: shortdesc}

{{site.data.keyword.atracker_full_notm}} records user-initiated activities that change the state of a service in {{site.data.keyword.cloud_notm}}. You can use this service to investigate abnormal activity and critical actions and to comply with regulatory audit requirements. You can also be alerted about actions as they happen. The events that are collected comply with the Cloud Auditing Data Federation (CADF) standard. For more information, see the [Getting started tutorial for {{site.data.keyword.atracker_full_notm}}](/docs/activity-tracker?topic=activity-tracker-getting-started){: external}.

## Types of events
{: #at_event_types}

{{site.data.keyword.cloudant_short_notm}} forwards two types of events to {{site.data.keyword.atracker_full_notm}}:

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


By default, only management events are automatically collected and sent to the {{site.data.keyword.atracker_full_notm}} service.
{: note}

You must configure each {{site.data.keyword.cloudant_short_notm}} instance to collect and send data events to the {{site.data.keyword.atracker_full_notm}} service.
{: important}

## Configuring data events for an {{site.data.keyword.cloudant_short_notm}} instance
{: #at_event_configure}

The following instructions demonstrate how to configure data events for an {{site.data.keyword.cloudant_short_notm}} instance.

### Configuring data events through the {{site.data.keyword.cloud_notm}} UI
{: #at_event_configure_ui}

You can change what types of events are sent to {{site.data.keyword.atracker_full_notm}} in the {{site.data.keyword.cloud_notm}} Dashboard by following these steps:

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

The `/_api/v2/user/activity_tracker/events` endpoint returns a `types` field in the response that includes an array of event types that are being sent to {{site.data.keyword.atracker_full_notm}} for the {{site.data.keyword.cloudant_short_notm}} instance.

See the following example request to retrieve information about configured event types by using HTTP:

```http
GET $SERVICE_URL/_api/v2/user/activity_tracker/events
```
{: codeblock}


Before you run a `curl` request, run the following command from the command line to acquire a JWT token: `ibmcloud iam oauth-tokens | awk '{print $4}'`
{: note}


See the following example request to retrieve information about event types:

```sh
curl -H "Authorization: Bearer $JWT" -X GET "$SERVICE_URL/_api/v2/user/activity_tracker/events"
```
{: codeblock}
{: curl}

```java
import com.ibm.cloud.cloudant.v1.Cloudant;
import com.ibm.cloud.cloudant.v1.model.ActivityTrackerEvents;

Cloudant service = Cloudant.newInstance();

ActivityTrackerEvents response =
    service.getActivityTrackerEvents().execute().getResult();

System.out.println(response)
```
{: codeblock}
{: java}

```javascript
const { CloudantV1 } = require('@ibm-cloud/cloudant');

const service = CloudantV1.newInstance({});

service.getActivityTrackerEvents().then(response => {
  console.log(response.result);
});
```
{: codeblock}
{: node}

```python
from ibmcloudant.cloudant_v1 import CloudantV1

service = CloudantV1.new_instance()

response = service.get_activity_tracker_events().get_result()

print(response)
```
{: codeblock}
{: python}

```go
getActivityTrackerEventsOptions := service.NewGetActivityTrackerEventsOptions()

activityTrackerEvents, response, err := service.GetActivityTrackerEvents(getActivityTrackerEventsOptions)
if err != nil {
  panic(err)
}

b, _ := json.MarshalIndent(activityTrackerEvents, "", "  ")
fmt.Println(string(b))
```
{: codeblock}
{: go}


The previous Go example requires the following import block:
{: go}


```go
import (
   "encoding/json"
   "fmt"
   "github.com/IBM/cloudant-go-sdk/cloudantv1"
)
```
{: codeblock}
{: go}


All Go examples require the `service` object to be initialized. For more information, see the API documentation's [Authentication section](https://cloud.ibm.com/apidocs/cloudant?code=go#authentication-with-external-configuration) for examples.
{: go}


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
{: codeblock}



#### Configure data events for an {{site.data.keyword.cloudant_short_notm}} instance
{: #at_event_configure_api_post}


You can configure data events by sending a `POST` to the `/_api/v2/user/activity_tracker/events` endpoint and passing a JSON object with a `types` field.

See the following example request to configure event types by using HTTP:

```http
POST $SERVICE_URL/_api/v2/user/activity_tracker/events
```
{: codeblock}


See the following example request to configure event types:

```sh
curl -H "Authorization: Bearer $JWT" -X POST "$SERVICE_URL/_api/v2/user/activity_tracker/events" --data '{"types": ["management", "data"]}'
```
{: codeblock}
{: curl}


```java
import java.util.Arrays;

import com.ibm.cloud.cloudant.v1.Cloudant;
import com.ibm.cloud.cloudant.v1.model.Ok;
import com.ibm.cloud.cloudant.v1.model.PostActivityTrackerEventsOptions;

Cloudant service = Cloudant.newInstance();

PostActivityTrackerEventsOptions options =
    new PostActivityTrackerEventsOptions.Builder()
        .types(Arrays.asList("management", "data"))
        .build();

Ok response =
    service.postActivityTrackerEvents(options).execute().getResult();

System.out.println(response);
```
{: codeblock}
{: java}


```javascript
const { CloudantV1 } = require('@ibm-cloud/cloudant');

const service = CloudantV1.newInstance({});

service.postActivityTrackerEvents({
  types: ['management', 'data'],
}).then(response => {
  console.log(response.result);
});
```
{: codeblock}
{: node}


```python
from ibmcloudant.cloudant_v1 import CloudantV1

service = CloudantV1.new_instance()

response = service.post_activity_tracker_events(
  types=['management', 'data']
).get_result()

print(response)
```
{: codeblock}
{: python}


```go
postActivityTrackerEventsOptions := service.NewPostActivityTrackerEventsOptions(
  []string{"management", "data"},
)

activityTrackerEvents, response, err := service.PostActivityTrackerEvents(postActivityTrackerEventsOptions)
if err != nil {
  panic(err)
}

b, _ := json.MarshalIndent(activityTrackerEvents, "", "  ")
fmt.Println(string(b))
```
{: codeblock}
{: go}


The previous Go example requires the following import block:
{: go}


```go
import (
   "encoding/json"
   "fmt"
   "github.com/IBM/cloudant-go-sdk/cloudantv1"
)
```
{: codeblock}
{: go}


All Go examples require the `service` object to be initialized. For more information, see the API documentation's [Authentication section](https://cloud.ibm.com/apidocs/cloudant?code=go#authentication-with-external-configuration) for examples.
{: go}


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
  "error":"Unknown event types: <unrecognized events>"
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

It can take up to 5 minutes for the change to be reflected in the events seen in {{site.data.keyword.atracker_full_notm}}.
{: note}


## List of events
{: #at_actions-audit-events}

### Management events
{: #at_actions_management-audit-events}

| Action | Description |
|-------|------------|
| `cloudantnosqldb.account-capacity-dbs.read` | Read the maximum number of databases allowed. |
| `cloudantnosqldb.account-current-dbs.read` | Read the current number of databases. |
| `cloudantnosqldb.account-status.configure` | Set the status of an instance. |
| `cloudantnosqldb.account-status.read` | Get the status of an instance. |
| `cloudantnosqldb.activity-tracker-event-types.read` | Get the configured event types of an instance. |
| `cloudantnosqldb.activity-tracker-event-types.write` | Configure the event types for an instance. |
| `cloudantnosqldb.capacity-throughput.read` | Get the current provisioned throughput capacity settings for an instance. |
| `cloudantnosqldb.capacity-throughput.write` | Set the provisioned throughput capacity settings for an instance. |
| `cloudantnosqldb.csp.capture` | Indicates a Content Security Policy failure when you access the Cloudant Dashboard. |
| `cloudantnosqldb.database.create` | Create a database. |
| `cloudantnosqldb.database.delete` | Delete a database. |
| `cloudantnosqldb.ibm-cloud-account-status.configure` | Set the status of an instance. |
| `cloudantnosqldb.ibm-cloud-account-status.read` | Get the status of an instance. |
| `cloudantnosqldb.legacy-credentials.revoke` | Revoke all legacy credentials and make IAM the only authentication method of an instance. |
| `cloudantnosqldb.legacy-root-credential.revoke` | Revoke the url style credential for a Cloudant instance. |
| `cloudantnosqldb.replicator-database.create` | Create `_replicator` database. |
| `cloudantnosqldb.replicator-database.delete` | Delete `_replicator` database. |
| `cloudantnosqldb.users-database.create` | Create `_users` database. |
| `cloudantnosqldb.users-database.delete` | Delete `_users` database. |
| `cloudantnosqldb.database-security.read` | Read a security document. |
|`cloudantnosqldb.database-security.write` | A create, update, or delete of a security document. |
| `cloudantnosqldb.design-document.write` | A create, update, or delete of a `_design` document. |
| `cloudantnosqldb.replication.read` | Read a replication document. |
| `cloudantnosqldb.replication.write` | A create, update, or delete of a replication document. |
| `cloudantnosqldb.sapi.apikeys` | Create a legacy Cloudant API key for an instance. |
| `cloudantnosqldb.sapi.db-security` | Read or write a database's security document. |
| `cloudantnosqldb.sapi.usercors` | Set and get the CORS settings for an instance. |
| `cloudantnosqldb.sapi.userplan` | Get or set plan and plan settings of an instance. |
| `cloudantnosqldb.users.write` | Create, update, or delete a `_users` document. |
| `cloudantnosqldb.volumes.update` | A change in state of the {{site.data.keyword.keymanagementservicefull}} key protecting dedicated hardware environment. |
{: caption="Management actions" caption-side="top"}

### Data events
{: #at_actions_data-audit-events}

| Action | Description |
|-------|------------|
| `cloudantnosqldb.any-document.read` | Read a JSON document. |
| `cloudantnosqldb.account-all-dbs.read` | Read a list of all databases. |
| `cloudantnosqldb.account-dbs-info.read` | Read metadata about a database. |
| `cloudantnosqldb.account-search-analyze.execute` | Read search index statistics and size. |
| `cloudantnosqldb.account-uuids.read` | Read `_uuids` endpoint. |
| `cloudantnosqldb.account-active-tasks.read` | Read `_active_tasks`. |
| `cloudantnosqldb.current-throughput.read` | Get the current consumption of the provisioned throughput capacity for an instance. |
| `cloudantnosqldb.database-ensure-full-commit.execute` | Post to `_ensure_full_commit` endpoint. |
| `cloudantnosqldb.database-info.read` | Read database metadata. |
| `cloudantnosqldb.data-document.write` | Write a JSON document. |
| `cloudantnosqldb.iam-session.read` | Read IAM session. |
| `cloudantnosqldb.iam-session.write` | Write IAM session. |
| `cloudantnosqldb.iam-session.delete` | Delete IAM session. |
| `cloudantnosqldb.ibmid-login.authenticate` | Complete IAM authentication on the Cloudant Dashboard. |
| `cloudantnosqldb.ibmid-login.receive` | Part of the Cloudant Dashboard login with IAM authentication. |
| `cloudantnosqldb.ibmid-login.start` | Initiate Cloudant Dashboard login with IAM authentication. |
| `cloudantnosqldb.local-document.write` | Write a `_local` document. |
| `cloudantnosqldb.replicator-database-info.read` | Read `_replicator` database information.|
| `cloudantnosqldb,replicator-design-document.write` | Write a `_design` document to the `_replicator` database. |
| `cloudantnosqldb.replicator-local-document.write` | Write a `_local` document to the `_replicator` database. |
| `cloudantnosqldb.sapi.lastactivity` | Get the last active time of an instance. Used internally by the IBM Cloud platform. |
| `cloudantnosqldb.sapi.supportattachments` | Attach file to support ticket. |
| `cloudantnosqldb.sapi.supporttickets` | Create, read, and delete support tickets. |
| `cloudantnosqldb.sapi.usage-data-volume` | Get the data usage of an instance. |
| `cloudantnosqldb.sapi.userccmdiagnostics` | Get history of throughput consumption and 429 requests for the past 5 seconds. |
| `cloudantnosqldb.sapi.userinfo` | Get metadata of an instance. |
| `cloudantnosqldb.session.delete` | Delete {{site.data.keyword.cloudant_short_notm}} legacy auth session. |
| `cloudantnosqldb.session.read` | Read {{site.data.keyword.cloudant_short_notm}} legacy auth session. |
| `cloudantnosqldb.session.write` | Write {{site.data.keyword.cloudant_short_notm}} legacy auth session. |
| `cloudantnosqldb.users.read` | Read `_users` database documents. |
| `cloudantnosqldb.users-database-info.read` | Read `_users` database information. |
| `cloudantnosqldb.users-design-document.write` | Write a `_design` document. |
| `cloudantnosqldb.users-local-document.write` | Write a `_local` document to the `_users` database. |
{: caption="Data actions" caption-side="top"}


## Viewing events
{: #at_ui_ma}

Events are available in the Chennai, Dallas, Frankfurt, London, Osaka, São Paulo, Sydney, Tokyo, Toronto, and Washington DC locations. For more information, see [{{site.data.keyword.cloud_notm}} services locations](/docs/activity-tracker?topic=activity-tracker-cloud_services_locations).

Management events generated by an instance of the {{site.data.keyword.cloudant_short_notm}} service are automatically collected and forwarded to the {{site.data.keyword.atracker_full_notm}} service. You can route auditing events in your account to destinations of your choice by configuring targets and routes, which determine where activity tracking events are delivered. One common target is {{site.data.keyword.logs_full_notm}}, where you can view audit logs, set up monitoring, and configure alerts to track important changes and behaviors.    
