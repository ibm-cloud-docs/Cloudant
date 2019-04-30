---

copyright:
  years: 2015, 2019
lastupdated: "2019-04-23"

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

<!-- Acrolinx: 2017-05-10 -->

# Audit logging
{: #audit-logging}

Audit logging records the {{site.data.keyword.cloudantfull}} principals who have 
accessed data stored in {{site.data.keyword.cloudant_short_notm}}. For all HTTP API 
access to {{site.data.keyword.cloudant_short_notm}}, the audit logging function 
records the following information about each HTTP request:

Information | Description
------------|------------
`Principal` | Account credentials, API key, or IBM Cloud IAM credentials.
`Action` | The action carried out (for example, document read).
`Resource` | Details about the account, database, and document accessed or query made.
`Timestamp` | A record of the time and data of the event. 
{: shortdesc}

{{site.data.keyword.cloudant_short_notm}} audit logs can be used to understand:

- What and when databases and documents have been accessed within an account, 
and by whom.
- What and when queries have been run, and by whom.
- What a specific principal or user has accessed, updated, or deleted, and when.
- What and when replication documents were created or deleted.


## How to access audit logs for your account
{: #how-to-access-audit-logs-for-your-account}

To request access to the audit logs for your account, contact 
{{site.data.keyword.cloudant_short_notm}} support. Support provides a copy of the audit logs that are of interest to you.

When contacting support, be sure to include:

- The {{site.data.keyword.cloudant_short_notm}} account the request relates to.
- The timeframe for audit logs (must not be more than one month per support request).
- Any specific databases, documents, or principals of interest.