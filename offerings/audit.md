---

copyright:
  years: 2015, 2020
lastupdated: "2019-01-07"

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

<!-- Acrolinx: 2019-09-06 -->

# Audit logging
{: #audit-logging}

Audit logging records the {{site.data.keyword.cloudantfull}} principals who accessed data that is stored in {{site.data.keyword.cloudant_short_notm}}. For all HTTP API 
access to {{site.data.keyword.cloudant_short_notm}}, the audit log function 
records the following information about each HTTP request:

Information | Description
------------|------------
`Principal` | Account credentials, API keys, or {{site.data.keyword.cloud}} IAM credentials, as identified by an HTTP request header. 
`Action` | The action carried out, for example, document read.
`Resource` | Details about the account, database, and document accessed or query made.
`Timestamp` | A record of the time and data of the event. 
{: shortdesc}

{{site.data.keyword.cloudant_short_notm}} audit logs can be used to understand:

- What and when databases and documents were accessed within an account, 
and by whom.
- What and when queries were run, and by whom.
- What a specific principal or user accessed, updated, or deleted, and when.
- What and when replication documents were created or deleted.


## How to access audit logs for your account
{: #how-to-access-audit-logs-for-your-account}

To request access to the audit logs for your account, contact 
{{site.data.keyword.cloudant_short_notm}} support. Support provides a copy of the audit logs that are of interest to you.

When you contact support, be sure to include the following information:

- The {{site.data.keyword.cloudant_short_notm}} account the request relates to.
- The timeframe for audit logs (must not be more than one month per support request).
- Any specific databases, documents, or principals of interest.



