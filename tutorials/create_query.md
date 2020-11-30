---

copyright:
  years: 2017, 2020
lastupdated: "2020-12-15"

keywords: create index, create query, run query, fields, operators

subcollection: Cloudant

content-type: tutorial
services: Cloudant
account-plan: lite 
completion-time: 10m
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
{:step: data-tutorial-type='step'}

<!-- Acrolinx: 2020-04-23 -->

# Using {{site.data.keyword.cloudant_short_notm}} Query
{: #creating-an-ibm-cloudant-query}
{: toc-content-type="tutorial"}
{: toc-services="Cloudant"}
{: toc-completion-time="10m"}

This tutorial demonstrates how to create an index and use the index to query the database, as well as how to create different types of queries to more easily find data.
{: shortdesc}

Here you run the commands from the command line, but you can also complete these tasks with the {{site.data.keyword.cloudant_short_notm}} dashboard, which gives you a visual example of each task. For more information about the dashboard, see [Using the {{site.data.keyword.cloudant_short_notm}} dashboard](/docs/Cloudant?topic=Cloudant-creating-an-ibm-cloudant-query) tutorial. 

## Before you begin
{: ##before-you-begin-qt}

Before you begin, follow these tutorials to create an instance, and then create and populate a database.

1. [Create an {{site.data.keyword.cloudant_short_notm}} instance](/docs/Cloudant/getting-started.html#creating-an-ibm-cloudant-instance-on-ibm-cloud).
2. [Create a database](/docs/Cloudant?topic=Cloudant-creating-and-populating-a-simple-ibm-cloudant-database-on-ibm-cloud#creating-a-database-within-the-service-instance).
3. [Populate the database](/docs/services/Cloudant?topic=Cloudant-creating-and-populating-a-simple-ibm-cloudant-database-on-ibm-cloud#storing-a-small-collection-of-data-as-documents-within-the-database).
4. (Optional) [Create an `acurl` alias](/docs/Cloudant?topic=Cloudant-authorized-curl-acurl-#authorized-curl-acurl-). </br>

If you decide not to set up `acurl`, use the following URL with `curl` instead of the one provided in the exercises, `curl "https://$USERNAME:$PASSWORD@$ACCOUNT.cloudant.com/databasedemo"`.

The `acurl` alias is more secure. It prevents someone from reading your password over your shoulder as you type. It also makes sure that your password isn’t sent in plain text over the network by enforcing HTTPS.
{: important}

Now, we're ready to learn how to run queries against the database you created in *Step 1. Create an {{site.data.keyword.cloudant_short_notm}} instance*.

## Creating an index
{: #creating-an-index-to-query-the-database-qt}
{: step}

{{site.data.keyword.cloudant_short_notm}} provides views and indexes to query databases. A view runs a query that is saved to the database, and
the result is called the *result set*. When you submit a query to the view, your query searches
the result set. An index is a way to structure data that improves retrieval time.

We use {{site.data.keyword.cloudant_short_notm}} Query in this tutorial, which uses Mongo-style query syntax to search for documents by using logical operators. {{site.data.keyword.cloudant_short_notm}} Query is a combination of a view and a search index.

When you use {{site.data.keyword.cloudant_short_notm}} Query, the query planner looks at the selector (your query) to determine the correct index to choose from. If it doesn't find a suitable index, it uses the `_all_docs` special index, which looks up documents by ID. In the worst case scenario, it returns all the documents by ID (full table scan). In memory, we filter out the documents by the selector, which is why, even without an index, you can still query with various fields. Full table scans are expensive to process, and we recommend that you create an index. 

If no available defined index matches the specified query, then {{site.data.keyword.cloudant_short_notm}} uses the `_all_docs` index.
{: tip}

To create an index, follow these steps:

1.  Copy the following sample JSON data into a file named `query-demo-index.json`.

    ```json
      {
      	"index": {
      		"fields": [
      			"descriptionField",
      			"temperatureField"
      		],
      		"partial_filter_selector": {
      			"descriptionField": {
      				"$eq": "hot"
      			},
      			"temperatureField": {
      				"$gt": 50
      			}
      		}
      	},
      	"ddoc": "query-demo-index",
      	"type": "json"
      }
    ```
    {: codeblock}

2.  Run the following command to create an index:

    If you decide not to set up `acurl`, use the following URL with `curl` instead: `curl "https://$USERNAME:$PASSWORD@$ACCOUNT.cloudant.com/databasedemo"`. 
    {: tip}

    ```sh
      acurl "https://$ACCOUNT.cloudant.com/databasedemo/_index" \
        -X POST \
        -H "Content-Type: application/json" \
        -d \@query-demo-index.json
    ```
    {: codeblock}

3.  Review the results:

    ```json
      {
      	"result": "created",
      	"id": "_design/query-demo-index",
      	"name": "490441584f9eddb8d09ef234d636b5f3b18e4ce6"
      }
    ```
    {: codeblock}


You aren't required to create an index to run a query. However, if you don't, the following warning is included with your results as an indicator that creating an index reduces processing and makes your queries more effective. `"Warning": "No matching index found, create an index to optimize query time."`
{: tip}

## Running a simple query
{: #running-a-simple-query-qt}
{: step}

This example demonstrates how {{site.data.keyword.cloudant_short_notm}} Query finds documents based on the `descriptionField` with the value `boiling`.   

To run a simple query, follow these steps: 

1.  Copy the following sample JSON into a data file named `query1.json`.

    ```json
      {
      	"selector": {
      		"descriptionField": "boiling"
      	}
      }   
    ```    
    {: codeblock}

2.  Run the following command to query the database:

    If you decide not to set up `acurl`, use the following URL with `curl` instead: `curl "https://$USERNAME:$PASSWORD@$ACCOUNT.cloudant.com/databasedemo"`. 
    {: tip}

    ```sh
      acurl "https://$ACCOUNT.cloudant.com/databasedemo/_find" \
        -X POST \
        -H "Content-Type: application/json" \
        -d \@query1.json
    ```
    {: codeblock}

3.  Review the query results:

    ```json
      {
      	"docs": [{
      		"_id": "91d1fa833d28efe15069604f98de701d",

      		"_rev": "1-f998fc7b89d4466c1e7bb204b1b00f74",
      		"numberField": 1,
      		"nameField": "one",
      		"descriptionField": "boiling",
      		"temperatureField": 100
      	}],
      	"bookmark": "g1AAAABweJzLYWBgYMpgSmHgKy5JLCrJTq2MT8lPzkzJBYorWBqmGKYlWhgbpxhZpKalGpoamFmaGZikWVqkpJobGKaA9HHA9BGlIwsAmn8eLw",
      	"warning": "No matching index found, create an index to optimize query time."
      }
    ```
    {: codeblock}

Next, you find a document in the database by using two fields.  

## Running a query with two fields
{: #running-a-query-with-two-fields-qt}
{: step}

This example uses two fields to find a document with the values: `freezing` and `-5`. 

We describe the search by using a ['selector' expression](/docs/Cloudant?topic=Cloudant-query#selector-syntax)
that looks like the following example:

```json
  {
  	"selector": {
  		"descriptionField": "freezing",
  		"temperatureField": -5
  	}
  }
```
{: codeblock}

We can tailor the results by adding more details within the selector expression.
The `fields` parameter specifies the fields to include with the results. In our example, the
results include the `nameField`, `descriptionField`, and `temperatureField`, as shown in the following example:

```json
  {
  	...
  	"fields": [
  		"nameField",
  		"descriptionField",
  		"temperatureField"
  	]
  }
```  
{: codeblock}

To run the query, follow these steps:

1.  Copy the sample JSON into a data file named `query2.json`.

    ```json
      {
      	"selector": {
      		"descriptionField": "freezing",
      		"temperatureField": -5
      	},
      	"fields": [
      		"nameField",
      		"descriptionField",
      		"temperatureField"
      	]
      }
    ```
    {: codeblock}

2.  Run the following command to query the database:

    If you decide not to set up `acurl`, use the following URL with `curl` instead: `curl "https://$USERNAME:$PASSWORD@$ACCOUNT.cloudant.com/databasedemo"`. 
    {: tip}

    ```sh
      acurl "https://$ACCOUNT.cloudant.com/databasedemo/_find" \
        -X POST \
        -H "Content-Type: application/json" \
        -d \@query2.json
    ```
    {: codeblock}

3.  Review the query results:

    ```json
    {
    	"docs": [{
    		"nameField": "eight",
    		"descriptionField": "freezing",
    		"temperatureField": -5
    	}],
    	"bookmark": "g1AAAABweJzLYWBgYMpgSmHgKy5JLCrJTq2MT8lPzkzJBYorpBiYGJolWaSZmaWYpFqmGBiYmKclphhappqZmRglG5uD9HHA9BGlIwsAms8eJw",
    	"warning": "No matching index found, create an index to optimize query time."
    }
    ```
    {: codeblock}

Next, you find a document in the database by using multiple operators. 

## Running a query with operators
{: #running-a-query-with-operators}
{: step}

In this example, the `$gt` (greater than) and `$eq` (equal) operators are used to search
for documents that include a temperature that is greater than `20` degrees and a description that contains the value `hot`. The results include the `descriptionField` and `temperatureField`, displayed in descending order by temperature. 

We use a selector expression like the following example:

```json
  {
  	"selector": {
  		"temperatureField": {
  			"$gt": 50
  		},
  		"descriptionField": {
  			"$eq": "hot"
  		}
  	},
  	"fields": [
  		"descriptionField",
  		"temperatureField"
  	],
  	"sort": [{
  		"temperatureField": "desc"
  	}],
  	"use_index": "_design/query-demo-index"
  }
```
{: codeblock}

To run the query, follow these steps:

1.  Copy the following sample JSON to a file named `query3.json`.

    ```json
      {
      	"selector": {
      		"descriptionField": {
      			"$eq": "hot"
      		},
      		"temperatureField": {
      			"$gt": 50
      		}
      	},
      	"fields": [
      		"descriptionField",
      		"temperatureField"
      	],
      	"sort": [{
      		"temperatureField": "desc"
      	}],
      	"use_index": "_design/query-demo-index"
      }
    ```
    {: codeblock}

2. Run this query:

    If you decide not to set up `acurl`, use the following URL with `curl` instead: `curl "https://$USERNAME:$PASSWORD@$ACCOUNT.cloudant.com/databasedemo"`. 
    {: tip}

    ```sh
      acurl "https://$ACCOUNT.cloudant.com/databasedemo/_find" \
        -X POST \
        -H "Content-Type: application/json" \
        -d \@query3.json
    ```
    {: codeblock}

3.  Review the query results:

    ```json
    {
    	"docs": [{
    			"descriptionField": "hot",
    			"temperatureField": 97
    		},
    		{
    			"descriptionField": "hot",
    			"temperatureField": 75
    		}
    	],
    	"bookmark": "g1AAAABbeJzLYWBgYMpgSmHgKy5JLCrJTq2MT8lPzkzJBYorJBoYmKWaWVokpZkamJtaGJskm5slmSenGhulWpibJhqC9HHA9OWATErUAGlkzsgvycoCAEsUF_A"
    }
    ```
    {: codeblock}

Now you know how to extract data from your database by using {{site.data.keyword.cloudant_short_notm}} Query. For more information, see the [{{site.data.keyword.cloudant_short_notm}} documentation](/docs/Cloudant?topic=Cloudant-ibm-cloud-public).
