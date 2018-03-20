---

copyright:
  years: 2015, 2018
lastupdated: "2018-03-19"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2018-00-00 -->

# Audit logging

Audit logging records the {{site.data.keyword.cloudantfull}} users who have accessed personal data from a
database. The audit logging function tracks the principal (account credentials or API keys), action, and 
resource for all API accesses to {{site.data.keyword.cloudant_short_notm}}. At the API level, 
{{site.data.keyword.cloudant_short_notm}} logs who accessed the account, 
specific databases, and specific documents. Each API access record is a JSON object that contains 
the following core fields:

Field | Description
------|------------
`principal` | The authenticated principal for the request.
`action` | The action carried out.
`resource` | CRN for resource accessed (account, database, document).
`timestamp` | A record of the time and data of the event. 

Audit logging is a simple audit function that takes a request object, extracts the 
necessary information from the object, 
and constructs a JSON record that is sent via TCP to a local rsyslog. The rsyslog process then
forwards the message using TLS.
{:shortdesc}

## Actions logged

{{site.data.keyword.cloudant_short_notm}} Support can query the database and 
find the date and time when each of the following actions occurred: 

- Access a document, database, or account.
- Access a document in a specific account.
- Queries run in this database for a specific account.
- Databases that this principal accessed in a specific account.
- Accounts this principal accessed.
- API keys in this account that this principal created.
- Database shares in this account that this principal created.
- Replications in this account that this principal accessed.
- Dashboard accesses by this principal. 

{{site.data.keyword.cloudant_short_notm}} Support can also generate a collection of all the logs for a specific account. 


 
 










