---

copyright:
  years: 2015, 2021
lastupdated: "2021-06-07"

keywords: principal, action, resource, timestamp, access audit logs

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

<!-- Acrolinx: 2020-12-24 -->

# Audit logging
{: #audit-logging}
{{site.data.keyword.cloudantfull}}. You can find more details on how to obtain audit logs depending on whether you use {{site.data.keyword.cloudant_short_notm}} or outside {{site.data.keyword.cloud}}.
{: shortdesc}

## IBM Cloudant for IBM Cloud
{: #audit-logs-ibm-cloud}

Users of {{site.data.keyword.cloudant_short_notm}} can use {{site.data.keyword.at_full}} to access audit logs for the service. {{site.data.keyword.at_full_notm}} records user-initiated activities that change the state of a service in {{site.data.keyword.cloud_notm}}. You can use this service to investigate abnormal activity and critical actions and to comply with regulatory audit requirements. You can also be alerted about actions as they happen. The events that are collected comply with the {{site.data.keyword.cloud_notm}} Auditing Data Federation (CADF) standard. For more information, see [{{site.data.keyword.at_full_notm}} events](/docs/services/Cloudant?topic=Cloudant-at_events){: new_window}.

## {{site.data.keyword.cloudant_short_notm}} not in {{site.data.keyword.cloud_notm}}
{: #audit-logs-not-ibm-cloud}

Users of {{site.data.keyword.cloudant_short_notm}} outside of {{site.data.keyword.cloud_notm}}, such as users of {{site.data.keyword.cloudant_short_notm}} Enterprise dedicated clusters, can contact support to request audit logs as described in the following section. Any user who requires frequent access to audit logs must migrate to {{site.data.keyword.cloudant_short_notm}} in {{site.data.keyword.cloud_notm}}.

### How to access audit logs for your account
{: #how-to-access-audit-logs-for-your-account}

Audit logging records the {{site.data.keyword.cloudant_short_notm}} principals who accessed data that is stored in {{site.data.keyword.cloudant_short_notm}}. For all HTTP API 
access to {{site.data.keyword.cloudant_short_notm}}, the audit log function 
records the following information about each HTTP request:

Information | Description
------------|------------
`Principal` | Account credentials, API keys, or {{site.data.keyword.cloud_notm}} IAM credentials, as identified by an HTTP request header. 
`Action` | The action carried out, for example, document read.
`Resource` | Details about the account, database, and document accessed or query made.
`Timestamp` | A record of the time and data of the event. 
{: caption="Table 1. Recorded audit information" caption-side="top"}

{{site.data.keyword.cloudant_short_notm}} audit logs can be used to understand:

- What and when databases and documents were accessed within an account, 
and by whom.
- What and when queries were run, and by whom.
- What a specific principal or user that is accessed, updated, or deleted, and when.
- What and when replication documents were created or deleted.

To request access to the audit logs for your account, contact 
{{site.data.keyword.cloudant_short_notm}} support. Support provides a copy of the audit logs that are of interest to you.

When you contact support, be sure to include the following information:

- The {{site.data.keyword.cloudant_short_notm}} account the request relates to.
- The timeframe for audit logs (must not be more than one month per support request).
- Any specific databases, documents, or principals of interest.
