---

copyright:
  years: 2015, 2021
lastupdated: "2021-10-15"

keywords: links, couchdb endpoints, ibm cloudant endpoints

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

<!-- Acrolinx: 2021-04-19 -->

# Comparison of {{site.data.keyword.cloudant_short_notm}} and Apache CouchDB API endpoints
{: #comparison-of-ibm-cloudant-and-couchdb-api-endpoints}

The {{site.data.keyword.cloudantfull}} and Apache CouchDB 3.x API endpoints, and the methods for accessing them, are described here. 
{: shortdesc}

The table shows you which endpoints are present in the CouchDB or {{site.data.keyword.cloudant_short_notm}} service.

Some CouchDB endpoints don't have {{site.data.keyword.cloudant_short_notm}} equivalents
because it wouldn't be meaningful.
Similarly,
some {{site.data.keyword.cloudant_short_notm}} endpoints don't have CouchDB equivalents.

While {{site.data.keyword.cloudant_short_notm}} is API-compliant with CouchDB, {{site.data.keyword.cloudant_short_notm}} doesn't support URL 
rewrites from the JavaScript function.
{: note}

For more information about a specific endpoint on a service,
click the corresponding link.

| Endpoint & Links | Description |
|------------------|-------------|
| `GET /` \n [Cloudant](/apidocs/cloudant#getserverinformation){: new_window}{: external}, [CouchDB](https://docs.couchdb.org/en/latest/api/server/common.html)| Retrieve meta-information about the instance. |
| `GET /_active_tasks` \n [Cloudant](/apidocs/cloudant#getactivetasks){: new_window}{: external}, [CouchDB](https://docs.couchdb.org/en/latest/api/server/common.html#active-tasks)| Retrieve a list of running tasks. |
| `GET /_all_dbs` \n [Cloudant](/apidocs/cloudant#getalldbs){: new_window}{: external}, [CouchDB](https://docs.couchdb.org/en/latest/api/server/common.html#all-dbs) | Query a list of all database names in the instance. |
|  `POST /_api/v2/api_keys` \n [Cloudant](/apidocs/cloudant#postapikeys){: new_window}{: external} | Generate an API key. |
| `GET /_api/v2/db/{db}/_security` \n [Cloudant](/apidocs/cloudant#getcloudantsecurity){: new_window}{: external} | Retrieve database permissions information.  |
| `PUT /_api/v2/db/{db}/_security` \n [Cloudant](/apidocs/cloudant#putcloudantsecurity){: new_window}{: external} | Modify only Cloudant related permissions to database. |
| `GET /_api/v2/monitoring` \n [Cloudant](/docs/Cloudant?topic=Cloudant-monitoring-an-ibm-cloudant-cluster#monitoring-metrics-overview) | Monitor a specific cluster aspect. |
| `GET /_api/v2/user/config/cors` \n [Cloudant](/apidocs/cloudant#getcorsinformation){: new_window}{: external} | Retrieve CORS configuration information.  |
| `PUT /_api/v2/user/config/cors` \n [Cloudant](/apidocs/cloudant#putcorsconfiguration){: new_window}{: external} | Modify the CORS configuration. |
| `GET /_db_updates` \n [Cloudant](/apidocs/cloudant#getdbupdates){: new_window}{: external}, [CouchDB](https://docs.couchdb.org/en/latest/api/server/common.html#db-updates) | List all database events in the instance. \n In {{site.data.keyword.cloudant_short_notm}}, the endpoint is only available to Dedicated Hardware plan customers. Its documentation references more query parameters (limit, since, descending) and another feed type value (normal). For CouchDB, its documentation references another feed type value (`eventsource`). |
| `GET /_membership` \n [Cloudant](/apidocs/cloudant#getmembershipinformation){: new_window}{: external}, [CouchDB](https://docs.couchdb.org/en/latest/api/server/common.html#membership) | Retrieve cluster membership information. Active clusters are indicated in the `cluster_nodes` field, while `all_nodes` has all nodes. |
| `POST /_replicate` \n [Cloudant](/apidocs/cloudant#postreplicate){: new_window}{: external}, [CouchDB](https://docs.couchdb.org/en/latest/api/server/common.html#replicate) | Request, configure, or stop a replication operation. \n {{site.data.keyword.cloudant_short_notm}} documentation references more request body fields (`selector`, `since\_seq`). |
| `PUT /_replicator/{doc_id}` \n [Cloudant](/apidocs/cloudant#putreplicationdocument){: new_window}{: external}, [CouchDB](https://docs.couchdb.org/en/latest/replication/replicator.html) | Trigger a replication. \n {{site.data.keyword.cloudant_short_notm}} documentation references more request body fields (`selector`, `since\_seq`). |
| `DELETE /_replicator` \n [Cloudant](/apidocs/cloudant#deletereplicationdocument){: new_window}{: external}, [CouchDB](https://docs.couchdb.org/en/latest/replication/replicator.html) | Cancel an ongoing replication. \n {{site.data.keyword.cloudant_short_notm}} documentation references more request body fields (`selector`, `since\_seq`). |
| `GET /_scheduler/docs` \n [Cloudant](/apidocs/cloudant#getschedulerdocs){: new_window}{: external}, [CouchDB](https://docs.couchdb.org/en/latest/api/server/common.html#scheduler-docs) | Monitor the status of a replication that is described by a replication document. |
| `HEAD /_scheduler/docs` \n  [CouchDB](https://docs.couchdb.org/en/latest/api/server/common.html#scheduler-docs) | Retrieve the HTTP headers for the status of a replication that is described by a replication document. |
| `GET /_scheduler/docs/_replicator/$doc_id` \n [Cloudant](/apidocs/cloudant#getschedulerdocument){: new_window}{: external}, [CouchDB](https://docs.couchdb.org/en/latest/replication/replicator.html) | Retrieve a replication scheduler document. |
| `HEAD /_scheduler/docs/_replicator/$doc_id` \n [CouchDB](https://docs.couchdb.org/en/latest/replication/replicator.html) | Retrieve the HTTP headers for a particular replication scheduler document. | 
| `GET /_scheduler/jobs` \n [Cloudant](/apidocs/cloudant#getschedulerjobs){: new_window}{: external}, [CouchDB](https://docs.couchdb.org/en/latest/api/server/common.html#scheduler-jobs) | Retrieve replication scheduler jobs.  |
| `HEAD /_scheduler/jobs` \n [CouchDB](https://docs.couchdb.org/en/latest/api/server/common.html#scheduler-jobs) | Retrieve the HTTP headers for replication scheduler jobs.  |
| `GET /_scheduler/jobs/{job_id}` \n [Cloudant](/apidocs/cloudant#getschedulerjob){: new_window}{: external} | Retrieve the state of a single replication task based on its replication ID. |
| `HEAD /_scheduler/jobs/{job_id}` \n [Cloudant](/apidocs/cloudant#headschedulerjob){: new_window}{: external} | Retrieve the HTTP headers of a single replication task based on its replication ID. |
| `POST /_search_analyze` \n [Cloudant](/apidocs/cloudant#postsearchanalyze){: new_window}{: external}, [CouchDB](https://docs.couchdb.org/en/latest/api/server/common.html#scheduler-jobs) | Retrieve the results of analyzer tokenization of the provided sample text. |
| `GET /_session` \n [Cloudant](/apidocs/cloudant#getsessioninformation){: new_window}{: external}, [CouchDB](https://docs.couchdb.org/en/latest/api/server/authn.html?highlight=_session#get--_session) | Retrieve information about the authenticated user. \n CouchDB documentation references a query parameter (basic). |
| `POST /_session` \n [Cloudant](/apidocs/cloudant#postsession){: new_window}{: external}, [CouchDB](https://docs.couchdb.org/en/latest/api/server/authn.html?highlight=_session#post--_session) | Start a new session for the specified user credentials. Cookie-based user login. \n CouchDB documentation references an extra query parameter (next). |
| `DELETE /_session` \n [Cloudant](/apidocs/cloudant#deletesession){: new_window}{: external}, [CouchDB](https://docs.couchdb.org/en/latest/api/server/authn.html?highlight=_session#delete--_session) | Retrieve a response that instructs the HTTP client to clear the cookie. |
| `GET /_utils` \n [CouchDB](https://docs.couchdb.org/en/latest/api/server/common.html#utils) | Access the built-in Fauxton administration interface. |
| `GET /_uuids` \n [Cloudant](/apidocs/cloudant#getuuids){: new_window}{: external}, [CouchDB](https://docs.couchdb.org/en/latest/api/server/common.html?highlight=_uuids#get--_uuids) | Request one or more Universally Unique Identifiers (UUIDs). |
| `GET /favicon.ico` \n [CouchDB](https://docs.couchdb.org/en/latest/api/server/common.html#get--favicon.ico) | Get the binary content for the favicon.ico site icon. |
| `HEAD /{db}` \n [Cloudant](/apidocs/cloudant#headdatabase){: new_window}{: external}, [CouchDB](https://docs.couchdb.org/en/latest/api/database/common.html?highlight=head--db#head--db) | Retrieve the HTTP headers that contain a minimal amount of information about the specified database. |
| `GET /{db}` \n [Cloudant](/apidocs/cloudant#getdatabaseinformation){: new_window}{: external}, [CouchDB](https://docs.couchdb.org/en/latest/api/database/common.html?highlight=head--db#get--db) | Retrieve information about the specified database. |
| `POST /{db}` \n [Cloudant](/apidocs/cloudant#postdocument){: new_window}{: external}, [CouchDB](https://docs.couchdb.org/en/latest/api/database/common.html?highlight=head--db#post--db) | Create or modify a document in the specified database by using the supplied JSON document. |
| `PUT /{db}` \n [Cloudant](/apidocs/cloudant#putdatabase){: new_window}{: external}, [CouchDB](https://docs.couchdb.org/en/latest/api/database/common.html?highlight=head--db#put--db) | Create a database. \n Database names must start with a lowercase letter and contain only the following characters: Lowercase characters (a-z), digits (0-9), any of the characters \_, $, (, ), +, -, and /. |
| `DELETE /{db}` \n [Cloudant](/apidocs/cloudant#deletedatabase){: new_window}{: external}, [CouchDB](https://docs.couchdb.org/en/latest/api/database/common.html?highlight=head--db#delete--db) | Delete the specified database, and all the documents and attachments contained within it. |
| `GET /{db}/_all_docs` \n [Cloudant](/apidocs/cloudant#getalldbs){: new_window}{: external}, [CouchDB](https://docs.couchdb.org/en/latest/api/database/bulk-api.html?highlight=_all_docs#get--db-_all_docs) | Query a list of all documents in a database. \n CouchDB documentation references more query parameters (`end_key`, `endkey_docid`, `end_key_doc_id`, `stale`, `start_key`, `startkey_docid`, `start_key_doc_id`, `update_seq`). For {{site.data.keyword.cloudant_short_notm}}, use `GET _all_docs`.|
| `POST /{db}/_all_docs` \n [Cloudant](/apidocs/cloudant#postalldocs){: new_window}{: external}, [CouchDB](https://docs.couchdb.org/en/latest/api/database/bulk-api.html?highlight=_all_docs#post--db-_all_docs) | Query a list of all documents in a database by using the HTTP `POST` method where the query is submitted as a JSON object in the request body. \n CouchDB documentation references more query parameters (`end_key`, `endkey_docid`, `end_key_doc_id`, `stale`, `start_key`, `startkey_docid`, `start_key_doc_id`, `update_seq`). |
| `POST /{db}/_bulk_docs` \n [Cloudant](/apidocs/cloudant#postbulkdocs){: new_window}{: external}, [CouchDB](https://docs.couchdb.org/en/latest/api/database/bulk-api.html?highlight=_all_docs#post--db-_bulk_docs) | Create and update multiple documents at the same time within a single request. \n CouchDB documentation references an extra request object field (`new_edits`). |
| `POST /{db}/_bulk_get` \n [Cloudant](/apidocs/cloudant#postbulkget){: new_window}{: external}, [CouchDB](https://docs.couchdb.org/en/latest/api/database/bulk-api.html?highlight=_all_docs#post--db-_bulk_get) | Retrieve specific revisions or revision histories for multiple documents. |
| `GET /{db}/_changes` \n [Cloudant](/apidocs/cloudant#getchanges){: new_window}{: external}, [CouchDB](https://docs.couchdb.org/en/latest/api/database/changes.html#get--db-_changes) | List of changes that are made to documents in the database, including insertions, updates, and deletions. \n CouchDB includes query parameters (`attachments`, `att_encoding_info`, `last-event-id`, `view`).|
| `POST /{db}/_changes` \n [Cloudant](/apidocs/cloudant#postchanges){: new_window}{: external}, [CouchDB](https://docs.couchdb.org/en/latest/api/database/changes.html#post--db-_changes) | List of changes that are made to documents in the database, including insertions, updates, and deletions. |
| `POST /{db}/_compact` \n [CouchDB](https://docs.couchdb.org/en/latest/api/database/compact.html#post--db-_compact) | Request compaction of the specified database. |
| `POST /{db}/_compact/{ddoc}` \n [CouchDB](https://docs.couchdb.org/en/latest/api/database/compact.html#post--db-_compact-ddoc) | Compact the view indexes associated with the specified design document. |
| `HEAD /{db}/_design/{ddoc}` \n [Cloudant](/apidocs/cloudant#headdesigndocument){: new_window}{: external}, [CouchDB](https://docs.couchdb.org/en/latest/api/ddoc/common.html?highlight=_design#head--db-_design-ddoc) | Retrieve the HTTP headers that contain a minimal amount of information about the specified design document. |
| `GET /{db}/_design/{ddoc}` \n [Cloudant](/apidocs/cloudant#getdesigndocument){: new_window}{: external}, [CouchDB](https://docs.couchdb.org/en/latest/api/ddoc/common.html?highlight=_design#get--db-_design-ddoc) | Retrieve a design document with the specified `doc_id` from the specified database. |
| `PUT /{db}/_design/{ddoc}` \n [Cloudant](/apidocs/cloudant#putdesigndocument){: new_window}{: external}, [CouchDB](https://docs.couchdb.org/en/latest/api/ddoc/common.html?highlight=_design#put--db-_design-ddoc) | Create a new named design document or create a new revision of the existing design document. \n {{site.data.keyword.cloudant_short_notm}} documentation references an extra request body field (indexes). CouchDB documentation references more request body fields (language, options). |
| `DELETE /{db}/_design/{ddoc}` \n [Cloudant](/apidocs/cloudant#deletedesigndocument){: new_window}{: external}, [CouchDB](https://docs.couchdb.org/en/latest/api/ddoc/common.html?highlight=_design#delete--db-_design-ddoc) | Delete the specified document from the database. |
| `COPY /{db}/_design/{ddoc}` \n [Cloudant](/docs/Cloudant?topic=Cloudant-design-documents#copying-a-design-document), [CouchDB](https://docs.couchdb.org/en/latest/api/ddoc/common.html?highlight=_design#copy--db-_design-ddoc) | Copy an existing design document to a new or existing one. |
| `GET /{db}/_design/{ddoc}/_geo_info/{index}` \n [Cloudant](/apidocs/cloudant#getgeoindexinformation){: new_window}{: external} | Obtain information about a geospatial index. |
| `GET /{db}/_design/{ddoc}/_geo/{index}` \n [Cloudant](/apidocs/cloudant#getgeo){: new_window}{: external} | Query a geospatial index from the specified design document. |
| `GET /{db}/_design/{ddoc}/_info` \n [Cloudant](/apidocs/cloudant#getdesigndocumentinformation){: new_window}{: external}, [CouchDB](https://docs.couchdb.org/en/latest/api/ddoc/common.html?highlight=_info#get--db-_design-ddoc-_info) | Obtain information about the specified design document, including the index, index size, and status of the design document. |
| `GET /{db}/_design/{ddoc}/_list/{func}/{other-ddoc}/{view}` \n [Cloudant](/docs/Cloudant?topic=Cloudant-design-documents#list-functions), [CouchDB](https://docs.couchdb.org/en/latest/api/ddoc/render.html#get--db-_design-ddoc-_list-func-other-ddoc-view) | Apply the list function for the view function from the other design document. |
| `POST /{db}/_design/{ddoc}/_list/{func}/{other-ddoc}/{view}` \n [Cloudant](/docs/Cloudant?topic=Cloudant-design-documents#list-functions), [CouchDB](https://docs.couchdb.org/en/latest/api/ddoc/render.html#post--db-_design-ddoc-_list-func-other-ddoc-view) | Apply the list function for the view function from the other design document. |
| `GET /{db}/_design/{ddoc}/_list/{func}/{view}` \n [Cloudant](/docs/Cloudant?topic=Cloudant-design-documents#list-functions), [CouchDB](https://docs.couchdb.org/en/latest/api/ddoc/render.html#get--db-_design-ddoc-_list-func-view) | Apply the list function for the view function from the same design document. \n The result of a list function isn't stored. For that reason, the function is executed every time that a request is made. |
| `POST /{db}/_design/{ddoc}/_list/{func}/{view}` \n [Cloudant](/docs/Cloudant?topic=Cloudant-design-documents#list-functions), [CouchDB](https://docs.couchdb.org/en/latest/api/ddoc/render.html#post--db-_design-ddoc-_list-func-view) | Apply the list function for the view function from the same design document. |
| `ANY /{db}/_design/{ddoc}/_rewrite/{path}` \n [Cloudant](/docs/Cloudant?topic=Cloudant-design-documents#rewrite-rules), [CouchDB](https://docs.couchdb.org/en/latest/api/ddoc/rewrites.html#any--db-_design-ddoc-_rewrite-path) | Rewrite the specified path by rules defined in the specified design document. |
| `GET /{db}/_design/{ddoc}/_search_info/{index}` \n [Cloudant](/apidocs/cloudant#getsearchinfo){: new_window}{: external}, [CouchDB](https://docs.couchdb.org/en/latest/api/ddoc/search.html#get--db-_design-ddoc-_search_info-index) | Retrieve search index metadata information, such as the size of the index on disk. |
| `GET /{db}/_design/{ddoc}/_search/{index}` \n [Cloudant](/apidocs/cloudant#postsearch){: new_window}{: external}, [CouchDB](https://docs.couchdb.org/en/latest/api/ddoc/search.html#get--db-_design-ddoc-_search-index)| Query an index by using the HTTP `GET` method. |
| `POST /{db}/_design/{ddoc}/_search/{index}` \n [Cloudant](/apidocs/cloudant#getsearchinfo){: new_window}{: external} | Query an index by  using the HTTP `POST` method where the query is submitted as a JSON object in the request body. |
| `GET /{db}/_design/{ddoc}/_show/{func}` \n [Cloudant](/docs/Cloudant?topic=Cloudant-design-documents#show-functions), [CouchDB](https://docs.couchdb.org/en/latest/api/ddoc/render.html#get--db-_design-ddoc-_show-func) | Apply the show function for _null_ document. |
| `POST /{db}/_design/{ddoc}/_show/{func}` \n [Cloudant](/docs/Cloudant?topic=Cloudant-design-documents#show-functions), [CouchDB](https://docs.couchdb.org/en/latest/api/ddoc/render.html#post--db-_design-ddoc-_show-func) | Apply the show function for _null_ document. |
| `GET /{db}/_design/{ddoc}/_show/{func}/{doc_id}` \n [Cloudant](/docs/Cloudant?topic=Cloudant-design-documents#show-functions), [CouchDB](https://docs.couchdb.org/en/latest/api/ddoc/render.html#get--db-_design-ddoc-_show-func-docid) | Apply the show function for the specified document. \n The result of a show function isn't stored. For that reason, the function is executed every time that a request is made. |
| `POST /{db}/_design/{ddoc}/_show/{func}/{doc_id}` \n [Cloudant](/docs/Cloudant?topic=Cloudant-design-documents#show-functions), [CouchDB](https://docs.couchdb.org/en/latest/api/ddoc/render.html#post--db-_design-ddoc-_show-func-docid) | Apply the show function for the specified document. |
| `POST /{db}/_design/{ddoc}/_update/{func}` \n [Cloudant](/docs/Cloudant?topic=Cloudant-design-documents#update-handlers), [CouchDB](https://docs.couchdb.org/en/latest/api/ddoc/render.html#post--db-_design-ddoc-_update-func) | Execute the update function on server side for null document. |
| `PUT /{db}/_design/{ddoc}/_update/{func}/{doc_id}` \n [Cloudant](/docs/Cloudant?topic=Cloudant-design-documents#update-handlers), [CouchDB](https://docs.couchdb.org/en/latest/api/ddoc/render.html#put--db-_design-ddoc-_update-func-docid) | Execute the update function on server side for the specified document. |
| `GET /{db}/_design/{ddoc}/_view/{view}` \n [Cloudant](/apidocs/cloudant#getview){: new_window}{: external}, [CouchDB](https://docs.couchdb.org/en/latest/api/ddoc/views.html#get--db-_design-ddoc-_view-view) | Execute the view function from the specified design document. \n CouchDB documentation references more query parameters (conflicts, end_key, end_key_doc_id, attachments, att_encoding_info, sorted, start_key, start_key_doc_id, update_seq). |
| `POST /{db}/_design/{ddoc}/_view/{view}` \n [Cloudant](/apidocs/cloudant#postview){: new_window}{: external}, [CouchDB](https://docs.couchdb.org/en/latest/api/ddoc/views.html#post--db-_design-ddoc-_view-view) | Execute the view function from the specified design document. \n CouchDB documentation references more query parameters (conflicts, end_key, end_key_doc_id, attachments, att_encoding_info, sorted, start_key, start_key_doc_id, update_seq). |
| `HEAD /{db}/_design/{ddoc}/{attname}` \n [Cloudant](/apidocs/cloudant#headdesigndocumentattachment){: new_window}{: external}, [CouchDB](https://docs.couchdb.org/en/latest/api/ddoc/common.html#head--db-_design-ddoc-attname) | Retrieve the HTTP headers that contain a minimal amount of information about the specified attachment. For {{site.data.keyword.cloudant_short_notm}}, use `{attachment_name}` instead of `{attname}`. |
| `GET /{db}/_design/{ddoc}/{attname}` \n [Cloudant](/apidocs/cloudant#getdesigndocumentattachment){: new_window}{: external}, [CouchDB](https://docs.couchdb.org/en/latest/api/ddoc/common.html#get--db-_design-ddoc-attname) | Retrieve the file attachment associated with the design document. |
| `PUT /{db}/_design/{ddoc}/{attname}` \n [Cloudant](/apidocs/cloudant#putdesigndocumentattachment){: new_window}{: external}, [CouchDB](https://docs.couchdb.org/en/latest/api/ddoc/common.html#put--db-_design-ddoc-attname) | Upload the supplied content as an attachment to the specified design document. |
| `DELETE /{db}/_design/{ddoc}/{attname}` \n [Cloudant](/apidocs/cloudant#deletedesigndocumentattachment){: new_window}{: external}, [CouchDB](https://docs.couchdb.org/en/latest/api/ddoc/common.html#delete--db-_design-ddoc-attname) | Delete the attachment of the specified design document. |
| `POST /{db}/_ensure_full_commit` \n Cloudant, [CouchDB](https://docs.couchdb.org/en/latest/api/database/compact.html#post--db-_ensure_full_commit) | Commit any recent changes to the specified database to disk. |
| `POST /{db}/_explain` \n [Cloudant](/apidocs/cloudant#postexplain){: new_window}{: external}, [CouchDB](https://docs.couchdb.org/en/latest/api/database/find.html#post--db-_explain) | Identify which index is being used by a particular query. |
| `POST /{db}/_find` \n [Cloudant](/apidocs/cloudant#postfind){: new_window}{: external}, [CouchDB](https://docs.couchdb.org/en/latest/api/database/find.html#post--db-_find) | Find documents that use a declarative JSON querying syntax. \n {{site.data.keyword.cloudant_short_notm}} documentation references more request body fields (r, bookmark). | 
| `GET /{db}/_index` \n [Cloudant](/apidocs/cloudant#getindexesinformation){: new_window}{: external}, [CouchDB](https://docs.couchdb.org/en/latest/api/database/find.html#get--db-_index) | List indexes. |
| `POST /{db}/_index` \n [Cloudant](/apidocs/cloudant#postindex){: new_window}{: external}, [CouchDB](https://docs.couchdb.org/en/latest/api/database/find.html#post--db-_find) | Create an index on a database. |
| `DELETE /{db}/_index/_design/{ddoc}/{type}/{index}` \n [Cloudant](/apidocs/cloudant#deleteindex){: new_window}{: external}, [CouchDB](https://docs.couchdb.org/en/latest/api/database/find.html#delete--db-_index-designdoc-json-name) | Delete an index. |
| `GET /{db}/_local/{doc_id}` \n [Cloudant](/apidocs/cloudant#getlocaldocument){: new_window}{: external}, [CouchDB](https://docs.couchdb.org/en/latest/api/local.html#get--db-_local-docid) | Get the specified local document. |
| `PUT /{db}/_local/{doc_id}` \n [Cloudant](/apidocs/cloudant#putlocaldocument){: new_window}{: external}, [CouchDB](https://docs.couchdb.org/en/latest/api/local.html#put--db-_local-docid) | Store the specified local document. \n Local documents aren't replicated to other databases. |
| `COPY /{db}/_local/{doc_id}` \n Cloudant, [CouchDB](https://docs.couchdb.org/en/latest/api/local.html#copy--db-_local-docid) | Copy the specified local document. |
| `DELETE /{db}/_local/{doc_id}` \n [Cloudant](/apidocs/cloudant#deletelocaldocument){: new_window}{: external}, [CouchDB](https://docs.couchdb.org/en/latest/api/local.html#delete--db-_local-docid) | Delete the specified local document. |
| `POST /{db}/_missing_revs` \n [Cloudant](/apidocs/cloudant#postmissingrevs){: new_window}{: external}, [CouchDB](https://docs.couchdb.org/en/latest/api/database/misc.html#post--db-_missing_revs) | Retrieve the document revisions from the list that don't exist in the database. |
| `POST /{db}/_purge` \n [CouchDB](https://docs.couchdb.org/en/latest/api/database/misc.html#post--db-_purge) | Remove the references to deleted documents from the database. |
| `POST /{db}/_revs_diff` \n [Cloudant](/apidocs/cloudant#postrevsdiff){: new_window}{: external}, [CouchDB](https://docs.couchdb.org/en/latest/api/database/misc.html#post--db-_revs_diff) | Given a set of document or revision IDs, retrieve the subset of document or revision IDs that don't correspond to revisions stored in the database. |
| `GET /{db}/_security` \n [Cloudant](/apidocs/cloudant#getsecurity){: new_window}{: external}, [CouchDB](https://docs.couchdb.org/en/latest/api/database/security.html#get--db-_security) | Retrieve the current security object from the specified database. |
| `PUT /{db}/_security` \n [Cloudant](/apidocs/cloudant#putsecurity){: new_window}{: external}, [CouchDB](https://docs.couchdb.org/en/latest/api/database/security.html#put--db-_security) | Set the security object for the specific database. |
| `GET /{db}/_shards` \n [Cloudant](/apidocs/cloudant#getshardsinformation){: new_window}{: external}, [CouchDB](https://docs.couchdb.org/en/latest/api/database/shard.html#get--db-_shards) | Retrieve information about the shards in the cluster. |
| `POST /{db}/_view_cleanup` \n [CouchDB](https://docs.couchdb.org/en/latest/api/database/compact.html#post--db-_view_cleanup) | Remove view index files that are no longer required because of changed views within design documents. |
| `HEAD /{db}/{docid}` \n [Cloudant](/apidocs/cloudant#headdocument){: new_window}{: external}, [CouchDB](https://docs.couchdb.org/en/latest/api/document/common.html#db-doc) | Retrieve the HTTP headers that contain a minimal amount of information about the specified document. |
| `GET /{db}/{docid}` \n [Cloudant](/apidocs/cloudant#getdocument){: new_window}{: external}, [CouchDB](https://docs.couchdb.org/en/latest/api/document/common.html#get--db-docid) | Retrieve the document specified by the `docid` from the specified database. |
| `PUT /{db}/{docid}` \n [Cloudant](/apidocs/cloudant#putdocument){: new_window}{: external}, [CouchDB](https://docs.couchdb.org/en/latest/api/document/common.html#put--db-docid) | Create a new named document or create a new revision of the existing document. |
| `DELETE /{db}/{docid}` \n [Cloudant](/apidocs/cloudant#deletedocument){: new_window}{: external}, [CouchDB](https://docs.couchdb.org/en/latest/api/document/common.html#delete--db-docid) | Delete the specified document. |
| `COPY /{db}/{docid}` \n Cloudant, [CouchDB](https://docs.couchdb.org/en/latest/api/document/common.html#copy--db-docid) | Copy an existing document to a new or existing document. |
| `HEAD /{db}/{docid}/{attname}` \n [Cloudant](/apidocs/cloudant#headattachment){: new_window}{: external}, [CouchDB](https://docs.couchdb.org/en/latest/api/document/attachments.html#head--db-docid-attname) | Retrieve the HTTP headers that contain a minimal amount of information about the specified attachment. For {{site.data.keyword.cloudant_short_notm}}, use `{attachment_name}` instead of `{attname}`. |
| `GET /{db}/{docid}/{attname}` \n [Cloudant](/apidocs/cloudant#getattachment){: new_window}{: external}, [CouchDB](https://docs.couchdb.org/en/latest/api/document/attachments.html#get--db-docid-attname) | Retrieve the file attachment associated with the document. For {{site.data.keyword.cloudant_short_notm}}, use `{attachment_name}` instead of `{attname}`. | 
| `PUT /{db}/{docid}/{attname}` \n [Cloudant](/apidocs/cloudant#putattachment){: new_window}{: external}, [CouchDB](https://docs.couchdb.org/en/latest/api/document/attachments.html#put--db-docid-attname) | Upload the supplied content as an attachment to the specified document. For {{site.data.keyword.cloudant_short_notm}}, use `{attachment_name}` instead of `{attname}`. | 
| `DELETE /{db}/{docid}/{attname}` \n [Cloudant](/apidocs/cloudant#deleteattachment){: new_window}{: external}, [CouchDB](https://docs.couchdb.org/en/latest/api/document/attachments.html#delete--db-docid-attname) | Delete the attachment associated with the specified doc. For {{site.data.keyword.cloudant_short_notm}}, use `{attachment_name}` instead of `{attname}`. |
