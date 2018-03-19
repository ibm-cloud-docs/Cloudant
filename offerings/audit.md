# Audit logging


Overall we wish to add new logging at the API layer of dbcore which logs the (principal, action, resource) for all API accesses to Cloudant and make this easily accessible to customers, initially via a support channel. 

1. Create a new logging channel or level, `audit`.
2. Log this to log forwarders as normal.
3. Log forwarders collate audit logs by cluster and forward to an external service for querying:
   Splunk or,
   Cloud Object Storage (COS) to query via SQL-over-COS.

Assumptions

* The log forwarding nodes can take the extra logs, which will be at least one message per API call, more for bulk requests.
* Either Splunk or COS are able to accept the data volumes.
* It's reasonably simple to add new log outlets to dbcore.
* COS is significantly cheaper than Splunk, making adding it as a new destination a worthwhile engineering endeavour.

The couch_audit application should expose a simple audit function that takes in a request object. The
audit function will extract the necessary info from the object and construct a json record that will be sent
via TCP to a local rsyslog. The message will be sent to facility 13. The rsyslog will then forward that json
record detailed here:
Since we will be sending the audit even to a local rsyslog, it seems that a nonencrypted
tcp message
should suffice. The rsyslog process will then forward the message using TLS, which provides the layer of
security needed.

This project is to support logging of the actions that principals take within Cloudant accounts and
databases. Logs principal (credentials and API keys), action, and resource. add new logging at the API layer of dbcore which logs the (principal, action, resource)
for all API accesses to Cloudant and make this easily accessible to customers, initially via a support
channel.

couch_audit allows customers to see who has accessed personal data from a
database. At the API level, Cloudant logs who, account credentials or API keys, access the account, specific databases and specific
documents. For operations access, for nonrepudiation
our best option is to be able to state which operators
access the nodes of a cluster during a given time period.

dbcore will generate syslog messages and send them to the node's local rsyslog facility 13 (log audit) via
TCP (but not TLS). The local rsyslog will then forward the messages on to one of the log forwarders using
both TCP and TLS. It will also set up a failover scheme so that messages are routed to another log
forwarder if the primary one stops accepting messages.
The log forwarder will send the messages on to Splunk and/or Message Hub. In Splunk, a new dbcore_audit index
will be created. MH will be configured to aggregate the logs in COS.

This will be a security improvement, as dbcore logs will be encrypted in transit. That is, TLS from rsyslog on
the client to the log forwarder, in additional to the TLS from the forwarder to the Splunk Indexer.
Additionally, TCP with failover set up will lead to much better reliability, with less chance that audit events
will be dropped. This will all apply at minimum to the new audit logs, but ideally we'll be enabling it for all
our logs.

These two things dovetail together as requirements for a new feature which shows which principals have
accessed data. For Cloudant accounts supporting IAM authentication, customers will be able to see access
from individual humans, without the need to have separate Cloudant accounts or API keys for each user,
making this information more immediately usable.


You can query the database for the following information:

First form, listing principals accessing specific pieces of data:
Which principals accessed this document? Dates & Times.
Which principals accessed this database? Dates & Times.
Which principals accessed this account? Dates & Times.
Second form, listing pieces of data accesses by specific principals:
Which documents in this account did this principal access? Dates & Times.
What queries in this database in this account did this principal run? Dates & Times.
Ideally we record this as views of document IDs, but for things like reduced views this is hard.
Which databases in this account did this principal access? Dates & Times.
Which accounts did this principal access? Dates & Times.
For operator accesses, we must support:
Given an account, database or document, which operators logged into the cluster hosting the account
via SSH or remsh during a given time window.

Queries should be able to be carried out without any scripting work solely by a member of support staff
with standard permissions. For example:
SQLoverCOS,
where we can grant support staff read access to the data.
Splunk.
Activity Tracker (https://pages.github.ibm.com/activitytracker/)

Secondary queries at the API level:
Which API keys in this account did this principal create? Dates & Times.
Which database shares in this account did this principal create? Dates & Times.
Which replications in this account did this principal access? Dates & Times.
Dashboard accesses by principal. Dates & Times.
A dump of all logs for an account.
At most the infrastructure team should be able to modify records. Bonus points if it's another IBM team
being the only one to be able to modify records (separation of duties).