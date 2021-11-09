---

copyright:
  years: 2021
lastupdated: "2021-11-05"

keywords: db2 warehouse on cloud, db2 warehouse console, find your service credentials, log in to db2 warehouse console

subcollection: Cloudant

content-type: tutorial
services: Cloudant
account-plan: lite
completion-time: 20m

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:codeblock: .codeblock}
{:pre: .pre}
{:screen: .screen}
{:tip: .tip}
{:note: .note}
{:important: .important}
{:deprecated: .deprecated}
{:external: target="_blank" .external}
{:step: data-tutorial-type='step'}

# Locating your {{site.data.keyword.dashdbshort_notm}} credentials
{: #locating-db2-warehouse-credentials}
{: toc-content-type="tutorial"}
{: toc-services="Cloudant"}
{: toc-completion-time="20m"}

To find alternatives to {{site.data.keyword.cloudant_short_notm}}'s {{site.data.keyword.dashdblong}} feature, see the 
[data-flow-examples repository](https://github.com/cloudant-labs/data-flow-examples){: external} for tutorials on 
extracting {{site.data.keyword.cloudant_short_notm}} documents and writing the data to a 
{{site.data.keyword.dashdbshort_notm}} table.
{: shortdesc}

This tutorial shows you how to find your {{site.data.keyword.dashdbshort_notm}} credentials. Keep in mind that the {{site.data.keyword.dashdbshort_notm}} feature is deprecated.
{: deprecated}

Before you can sign in to the {{site.data.keyword.dashdbshort_notm}} console, you need the URL and credentials. This information is located in the `warehouser` document.

## Objectives
{: #objectives-locate-db2-credentials}

- Locate your {{site.data.keyword.dashdbshort_notm}} credentials.
- Sign in to {{site.data.keyword.dashdbshort_notm}} console. 

## How to find your service credentials
{: #find-your-service-credentials-db2}
{: step}

1. To retrieve information from the `warehouser` document, you must run the following curl command.

   ```sh
   curl -u $USERNAME:$PASSWORD "https://$ACCOUNT.cloudant.com/_warehouser/$DOCUMENT_ID"
   ```
   {: codeblock}

1. Before you run the command, replace `$DOCUMENT_ID` with `example@source-db`. In this case, `example` is the `warehouser` document's name. `source-db` is the source database's name that is used for replicating {{site.data.keyword.cloudant_short_notm}} to DB2.

   ```sh
   curl -u $USERNAME:$PASSWORD "https://$ACCOUNT.cloudant.com/_warehouser/example@source-db"
   ```
   {: codeblock}

1. See the example response when you search for information in the `warehouser` document.

   ```http
   {
     "_id": "example@source-db",
     "dashboard_url": "https://dashdb-entry-yp-lon02-01.services.eu-gb.bluemix.net/login",
     "dynamite_token": "XXXXXXXX",
     "target": "jdbc:db2://dashdb-entry-yp-lon02-01.services.eu-gb.bluemix.net:50000/BLUDB",
     "dynamite_user": "dash12345",
     ...
   }
   ```
   {: codeblock}

The information that is returned in the previous example is described in the following list:

| Field | Description |
|-------|-------------|
| `_id` | ID of the `_warehouser` document |
| `dashboard_url` | URL of the {{site.data.keyword.dashdbshort_notm}} console |
| `dynamite_token` | DB2 password |
| `target` | DB2 JDBC connection URL, only used if the value for `dashboard_url` is null. |
| `dynamite_user` | DB2 user name |
{: caption="Table 4. Fields from the previous example response" caption-side="top"}

## Sign in to the {{site.data.keyword.dashdbshort_notm}} console
{: #sign-in-db2-warehouse-console}
{: step}

1. To sign in to the {{site.data.keyword.dashdbshort_notm}} console, you must remember the values for each of the following fields that are taken from the previous response example: `dynamite_user`, `dynamite_token`, and `dashboard_url`.

1. From a browser, go to the {{site.data.keyword.dashdbshort_notm}} console by using the value in the `dashboard_url` field.  

   To sign in to the {{site.data.keyword.dashdbshort_notm}} console, use the value from the `dashboard_url` field. If the value for the `dashboard_url` field is `null`, you can use the host value from the `target` field to create the URL for signing in to the console. For example, the host value for the `target` field from the previous example output is `dashdb-entry-yp-lon02-01.services.eu-gb.bluemix.net`. If you add the protocol `https` and the Postfix `login`, you can sign in with the following URL, `https://dashdb-entry-yp-lon02-01.services.eu-gb.bluemix.net/login`.
   {: note}

1. To sign in, use the value of the `dynamite_user` field as your user name and the `dynamite_token` field as your password.
