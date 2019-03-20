---

copyright:
  years: 2017, 2019
lastupdated: "2019-03-19"

keywords: create database, create documents, create index, create query, run query, fields, operators

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

# Creating an {{site.data.keyword.cloudant_short_notm}} Query
{: #creating-an-ibm-cloudant-query}

This tutorial demonstrates how to create a database, populate it
with documents, create an index, and use the index to query the database.
{: shortdesc}

Exercises for both the ![Command line icon](../images/CommandLineIcon.png) _Command line_
and ![Dashboard icon](../images/DashboardIcon.png) _{{site.data.keyword.cloud}} Dashboard_ are provided. The
{{site.data.keyword.cloud_notm}} Dashboard exercises give you a visual example of each task. You can follow the links
throughout the tutorial for more information.

To begin, you create the `query-demo` database and some documents that
contain the data for these exercises.

## Assumptions
{: ##assumptions}

Before you begin, follow these steps to prepare for the tutorial:

1.  [Create an {{site.data.keyword.cloud_notm}} account ![External link icon](../images/launch-glyph.svg "External link icon")](https://cloud.ibm.com/registration){: new_window}.
2.  Log in to the
  [{{site.data.keyword.cloud_notm}} Dashboard ![External link icon](../images/launch-glyph.svg "External link icon")](https://cloud.ibm.com/catalog/services/cloudant){: new_window}.
3.  [Create an {{site.data.keyword.cloudant_short_notm}} instance on {{site.data.keyword.cloud_notm}}](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud#creating-a-service-instance).
4.  (Optional) [Create an acurl alias](/docs/services/Cloudant?topic=cloudant-authorized-curl-acurl-#authorized-curl-acurl-) to make it easier and faster to run commands from the command line.
5.  Replace the `$ACCOUNT` variable in the commands that are included in the exercises with the user name you use to log in to {{site.data.keyword.cloudant_short_notm}} Dashboard.
  If you decide not to set up `acurl`,
  use the following URL instead of the one provided in the exercises:
  ``` sh
  curl https://$USERNAME:$PASSWORD@$ACCOUNT.cloudant.com/query-demo
  ```
  {: codeblock}

## Creating the `query-demo` database
{: #creating-the-query-demo-database}

In this section, you create the `query-demo` [database](/docs/services/Cloudant?topic=cloudant-databases#create-database) that
is the database that we use in this tutorial.

In this tutorial, we use the `acurl` alias rather than the `curl` command. The `acurl` alias is created using steps described [here](docs/services/Cloudant?topic=cloudant-authorized-curl-acurl-#authorized-curl-acurl-). If you prefer to use the `curl` command, or another method for invoking API endpoints, substitute your command in the tutorial, along with the parameters required by your command, such as username and password.
{: tip}

![Command Line icon](../images/CommandLineIcon.png) _Command line_

1.  Create a database by running this command:
  ``` sh
  acurl https://$ACCOUNT.cloudant.com/query-demo -X PUT
  ```
  {: codeblock}
2.  Review the results:
  ```json
  {
    "ok": true
  }
  ```
  {: codeblock}

![Dashboard icon](../images/DashboardIcon.png) _{{site.data.keyword.cloud_notm}} Dashboard_

1.  Open the {{site.data.keyword.cloudant_short_notm}} service instance that you created.
2.  On {{site.data.keyword.cloudant_short_notm}} service page, click **Launch**.
    The Databases tab opens.
    
  ![Databases tab](../images/tabs.png)
4.  Click **Create Database**.
5.  Enter `query-demo` and click **Create**.

  The `query-demo` database automatically opens.

## Creating documents in the database
{: #creating-documents-in-the-database}

The [documents](/docs/services/Cloudant?topic=cloudant-documents#documents)
that you create in this exercise contain the data that you use to query the `query-demo` database in later exercises.

![Command Line icon](../images/CommandLineIcon.png) _Command line_

1.  Copy the sample text to a data file named `bulkcreate.dat` to create five documents:
  ```json
  {
    "docs":
    [
      {
        "_id": "doc1",
        "firstname": "Sally",
        "lastname": "Brown",
        "age": 16,
        "location": "New York City, NY"
      },
      {
        "_id": "doc2",
        "firstname": "John",
        "lastname": "Brown",
        "age": 21,
        "location": "New York City, NY"
      },
      {
        "_id": "doc3",
        "firstname": "Greg",
        "lastname": "Greene",
        "age": 35,
        "location": "San Diego, CA"
      },
      {
        "_id": "doc4",
        "firstname": "Anna",
        "lastname": "Greene",
        "age": 44,
        "location": "Baton Rouge, LA"
      },
      {
        "_id": "doc5",
        "firstname": "Lois",
        "lastname": "Brown",
        "age": 33,
        "location": "Syracuse, NY"
      }
    ]
  }
  ```
  {: codeblock}

2.  Run this command to create the documents:
  ```sh
  acurl https://$ACCOUNT.cloudant.com/query-demo/_bulk_docs -X POST -H "Content-Type: application/json" -d \@bulkcreate.dat
  ```
  {: codeblock}

Notice that the '`@`' symbol, used to indicate that the data is included in a file, is identified by the supplied name.
{: tip}

3.  Review the results:
  ```json
  [
    {
      "ok":true,
      "id":"doc1",
      "rev":"1-57a08e644ca8c1bb8d8931240427162e"
    },
    {
      "ok":true,
      "id":"doc2",
      "rev":"1-bf51eef712165a9999a52a97e2209ac0"
    },
    {
      "ok":true,
      "id":"doc3",
      "rev":"1-9c9f9b893fcdd1cbe09420bc4e62cc71"
    },
    {
      "ok":true,
      "id":"doc4",
      "rev":"1-6aa4873443ddce569b27ab35d7bf78a2"
    },
    {
      "ok":true,
      "id":"doc5",
      "rev":"1-d881d863052cd9681650773206c0d65a"
    }
  ]
  ```
  {: codeblock}

![Dashboard icon](../images/DashboardIcon.png) _{{site.data.keyword.cloud_notm}} Dashboard_

1.  Click **`+`** and select **New Doc**. The 'New Document' window opens.
2.  To create a document, copy the following sample text and replace the existing text in the new document.

  _First sample document_:
  ```json
  {
    "firstname": "Sally",
    "lastname": "Brown",
    "age": 16,
    "location": "New York City, NY",
    "_id": "doc1"
  }
  ```
  {: codeblock}

3.  Repeat step 2 to add the remaining documents to the database.

  _Second sample document_:
  ```json
  {
    "firstname": "John",
    "lastname": "Brown",
    "age": 21,
    "location": "New York City, NY",
    "_id": "doc2"
  }
  ```
  {: codeblock}

  _Third sample document_:
  ```json
  {
    "firstname": "Greg",
    "lastname": "Greene",
    "age": 35,
    "location": "San Diego, CA",
    "_id": "doc3"
  }
  ```
  {: codeblock}

  _Fourth sample document_:
  ```json
  {
    "firstname": "Anna",
    "lastname": "Greene",
    "age": 44,
    "location": "Baton Rouge, LA",
    "_id": "doc4"
  }
  ```
  {: codeblock}

  _Fifth sample document_:
  ```json
  {
    "firstname": "Lois",
    "lastname": "Brown",
    "age": 33,
    "location": "New York City, NY",
    "_id": "doc5"
  }
  ```
  {: codeblock}

  The `query-demo` database was populated with five records. You can see the records from the Table view in the following screen capture:

  ![Sample documents](../images/docs1.png)     

## Creating an index to query the database
{: #creating-an-index-to-query-the-database}

{{site.data.keyword.cloudant_short_notm}} provides views and indexes to query the database. A view runs a query that is saved to the database, and
the result is called the result set. When you submit a query to the view, your query searches
the result set. An index is a way to structure data that improves retrieval time.

We use {{site.data.keyword.cloudant_short_notm}} Query in this tutorial, which uses Mongo-style query syntax to search for documents by using logical operators. {{site.data.keyword.cloudant_short_notm}} Query is a combination of a view and a search index.

When you use {{site.data.keyword.cloudant_short_notm}} Query, the query planner looks at the selector (your query) to determine the right index to choose from. If it does not find a suitable index, it uses the `_all_docs` special index, which looks up documents by ID. In the worst case scenario, it returns all the documents by ID (full table scan). In memory, we filter out the documents by the selector, which is why, even without an index, you can still query with various fields. Full table scans are expensive, and we recommend that you create an index. See a description of different types of indexes in the following list:

*	Primary index – look up a document or list of documents by ID.  
*	[View](/docs/services/Cloudant?topic=cloudant-views-mapreduce#views-mapreduce) – search for information in the database that matches the search criteria that you specify, such as counts, sums, averages, and other mathematical functions. The criteria you can search is specified in the view's definition. Views use the MapReduce paradigm.
*	[Search index](/docs/services/Cloudant?topic=cloudant-search#search) – search one or more fields, large amounts of text, or use wildcards, fuzzy search, or facets with [Lucene Query Parser Syntax ![External link icon](../images/launch-glyph.svg "External link icon")](http://lucene.apache.org/core/4_3_0/queryparser/org/apache/lucene/queryparser/classic/package-summary.html#Overview){: new_window}.

If there is no available defined index that matches the specified query, then {{site.data.keyword.cloudant_short_notm}} uses the `_all_docs` index.
{: tip}


![Command Line icon](../images/CommandLineIcon.png) _Command line_

1.  Copy the following sample JSON data into a file named `query-index.dat`.
  ```json
{
	"index": {
		"fields": [
			"age",
			"lastname"
		],
		"partial_filter_selector": {
			"age": {
				"$gte": 30
			},
			"lastname": {
				"$eq": "Greene"
			}
		}
	},
  		"ddoc": "partial-index",
		"type": "json"
}
  ```
  {: codeblock}

2.  Run the following command to create an index:
  ```sh
  acurl https://$ACCOUNT.cloudant.com/query-demo/_index -X POST -H "Content-Type: application/json" -d \@query-index.dat
  ```
  {: codeblock}

3.  Review the results:
  ```json
  {
    "result":"created",
    "id":"_design/752c7031f3eaee0f907d18e1424ad387459bfc1d",
    "name":"query-index"
  }
  ```
  {: codeblock}



![Dashboard icon](../images/DashboardIcon.png) _{{site.data.keyword.cloud_notm}} Dashboard_

1.  Click **`+` > Query Indexes** on either the **All Documents** or **Design Documents** tab.
2.  Paste the following sample JSON data into the **Index** field:
  ```json
  {
	"index": {
		"fields": [
			"age",
			"lastname"
		],
		"partial_filter_selector": {
			"age": {
				"$gte": 30
			},
			"lastname": {
				"$eq": "Greene"
			}
		}
	},
  		"ddoc": "partial-index",
		"type": "json"
  }
  ```
  {: codeblock}

  The index was created. You can see the index in the following screen capture:

  ![Query index](../images/query-index1.png)



## Creating a query
{: #creating-a-query}

Queries allow you to extract your data from {{site.data.keyword.cloudant_short_notm}}. A well-written
[query](/docs/services/Cloudant?topic=cloudant-query#query) can narrow your search and
its results to include only the data you want.

This exercise shows you how to write and run a simple query, query with two fields,
and query with two [operators](/docs/services/Cloudant?topic=cloudant-query#operators).
You query with an operator by specifying at least one field and its corresponding value.
The query then uses this value to search the database for matches.

For anything but the most simple query, add the JSON to a data file and run it from the command line.

### Running a simple query
{: #running-a-simple-query}

This example demonstrates how {{site.data.keyword.cloudant_short_notm}} Query uses the `query-index` to find the
`lastname` and filters the results in memory to find the `firstname`.   

![Command Line icon](../images/CommandLineIcon.png) _Command line_

1.  Copy the following sample JSON into a data file named `query1.dat`.
  ```json
    {
      "selector": {
            "lastname" : "Greene",
            "firstname" : "Anna"            
         }        
    }       
  ```    
  {: codeblock}

2.  Run the following command to query the database:
  ```sh
  acurl https://$ACCOUNT.cloudant.com/query-demo/_find -X POST -H "Content-Type: application/json" -d \@query1.dat
  ```
  {: codeblock}

3.  Review the query results:
  ```json
  {
    "docs": [
      {
        "_id":"doc4",
        "_rev":"3-751ab049e8b5dd1ba045cea010a33a72",
            "firstname":"Anna",
            "lastname":"Greene",
            "age":44,
            "location":"Baton Rouge, LA"
      }
    ]
  }
  ```
  {: codeblock}

![Dashboard icon](../images/DashboardIcon.png) _{{site.data.keyword.cloud_notm}} Dashboard_

1.  Click the **Query** tab.
2.  Copy and paste the following sample JSON into the {{site.data.keyword.cloudant_short_notm}} Query window:
  ```json
   {
      "selector": {
            "lastname" : "Greene",
            "firstname" : "Anna"            
         }        
   }
  ```
  {: codeblock}

3.  Click **Run Query**.

  The query results display. You can see them from the Table view in the following screen capture:

  ![Query 1 results](../images/dashboard_query1_results.png)

### Running a query with two fields
{: #running-a-query-with-two-fields}

This example uses two fields to find everyone that is named `Brown` who lives in `New York City, NY`.

We describe the search by using a ['selector' expression](/docs/services/Cloudant?topic=cloudant-query#selector-syntax)
that looks like the following example:
```json
  {
    "selector": {
      "lastname": "Brown",
      "location": "New York City, NY"
    }
  }
```
{: codeblock}

We can tailor the results to meet our needs
by adding more details within the selector expression.
The `fields` parameter specifies the fields to include with the results. In our example, the
results include the first name, last name, and location. The results are sorted by first
name in ascending order based on the values in the `sort` parameter.
The extra details look like the following example:
```json
{
  ...
  "fields" : [
    "firstname",
    "lastname",
    "location"
  ]
}
```  
{: codeblock}

![Command Line icon](../images/CommandLineIcon.png) _Command line_

1.  Copy the sample JSON into a data file named `query2.dat`.
  ```json
  {
    "selector": {
      "lastname": "Brown",
      "location": "New York City, NY"
    },
   "fields" : [
     "firstname",
     "lastname",
     "location"
  ]
  }
  ```
  {: codeblock}

2.  Run the following command to query the database:
  ```sh
  acurl https://$ACCOUNT.cloudant.com/query-demo/_find -X POST -H "Content-Type: application/json" -d \@query2.dat
  ```
  {: codeblock}

3.  Review the query results:
  ```json
  {
    "docs": [
      {
        "firstname": "Sally",
        "lastname": "Brown",
        "location": "New York City, NY"
      },
      {
        "firstname": "John",
        "lastname": "Brown",
        "location": "New York City, NY"
      },
      {
        "firstname": "Lois",
        "lastname": "Brown",
        "location": "New York City, NY"
      }
    ]
  }
  ```
  {: codeblock}

![Dashboard icon](../images/DashboardIcon.png) _{{site.data.keyword.cloud_notm}} Dashboard_

1.  Click the **Query** tab.
2.  Copy and paste the following sample JSON into the {{site.data.keyword.cloudant_short_notm}} Query window:
  ```json
  {
    "selector": {
      "lastname": "Brown",
      "location": "New York City, NY"
    },
    "fields": [
      "firstname",
      "lastname",
      "location"
    ] 
  }
  ```
  {: codeblock}

3.  Click **Run Query**.

  The query results display. You can see them from the Table view in the following screen capture:

  ![Query 2 results](../images/dashboard_query2_results.png)

### Running a query with operators
{: #running-a-query-with-operators}

In this example, the `$eq` (equal) and `$gt` (greater than) operators are used to search
for documents that contain the last name `Greene` and an age that is greater than `30`.

We use a selector expression like the following example:
```json
{
  "selector": {
    "age": {
      "$gt": 30
    },
    "lastname": {
      "$eq": "Greene"
    }
  }
}
``` 
{: codeblock}

The results are sorted by age in ascending order based on the 
values specified in the `sort` parameter.

```json
    "sort": [
      {
        "age": "asc"   
      }
    ] 
```  
{: codeblock}

![Command Line icon](../images/CommandLineIcon.png) _Command line_

1.  Copy the following sample JSON to a file named `query3.dat`.
  ```json
  {
   "selector": {
      "age": {
         "$gt": 30
      },
      "lastname": {
         "$eq": "Greene"
      }
   },
   "fields": [
      "age",
      "firstname"
   ],
   "sort": [
      {
         "age": "asc"
      }
   ],
   "use_index": "_design/partial-index"
  }
  ```
  {: codeblock}

2. Run this query:
  ```sh
  acurl https://$ACCOUNT.cloudant.com/query-demo/_find -X POST -H "Content-Type: application/json" -d \@query3.dat
  ```
  {: codeblock}

3.  Review the query results:
  ```json
  {"docs":[
     {"age":35,"firstname":"Greg"},
     {"age":44,"firstname":"Anna"}
   ],
  "bookmark": "g1AAAABCeJzLYWBgYMpgSmHgKy5JLCrJTq2MT8lPzkzJBYqzAFkmIDkOmFwOSHWiDkiSzb0oNTUvNSsLAEsmEeQ"
  }
  ```
  {: codeblock}

![Dashboard icon](../images/DashboardIcon.png) _{{site.data.keyword.cloud_notm}} Dashboard_

1.  Click the **Query** tab.
2.  Copy and paste the following sample JSON into the {{site.data.keyword.cloudant_short_notm}} Query window:
  ```json
  {
   "selector": {
      "age": {
         "$gt": 30
      },
      "lastname": {
         "$eq": "Greene"
      }
   },
   "fields": [
      "age",
      "firstname"
   ],
   "sort": [
      {
         "age": "asc"
      }
   ],
   "use_index": "_design/partial-index"
  }
  ```
  {: codeblock}

3.  Click **Run Query**.

  The query results display. You can see them from the Table view in the following screen capture:

  ![Query 3 results](../images/dashboard_query3_results.png)

For more information about {{site.data.keyword.cloudant_short_notm}}, see the [{{site.data.keyword.cloudant_short_notm}} Documentation](/docs/services/Cloudant?topic=cloudant-overview#overview).
