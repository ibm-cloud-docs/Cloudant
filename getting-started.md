---

copyright:
  years: 2015, 2019
lastupdated: "2019-04-03"

keywords: connect to service instance, create a database, populate database with data, retrieve data through queries, retrieve data with api endpoint, delete database, close connection, complete python code listing, couchdb as a service, couchdb hosted, couchdb, databases for couchdb

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

<!-- Acrolinx: 2018-05-31 -->

# Getting started tutorial
{: #getting-started}

In this {{site.data.keyword.cloudantfull}} getting started tutorial,
we use Python to create an {{site.data.keyword.cloudant_short_notm}} database
and populate that database with a simple collection of data.
{: shortdesc}

In addition to this tutorial, see our hands-on tutorials that help you learn more about {{site.data.keyword.cloudant_short_notm}}. Or try one of the tutorials that focuses on a specific language:

- [Liberty for Java and {{site.data.keyword.cloudant_short_notm}} ![External link icon](images/launch-glyph.svg "External link icon")](https://cloud.ibm.com/docs/runtimes/liberty/getting-started.html#getting-started-tutorial){: new_window}
- [Node.js and {{site.data.keyword.cloudant_short_notm}} ![External link icon](images/launch-glyph.svg "External link icon")](https://cloud.ibm.com/docs/runtimes/nodejs/getting-started.html#getting-started-tutorial){: new_window}
- [Swift and {{site.data.keyword.cloudant_short_notm}} ![External link icon](images/launch-glyph.svg "External link icon")](https://cloud.ibm.com/docs/runtimes/swift/getting-started.html#getting-started-tutorial){: new_window}

For more language-specific tutorials, see [Get started by deploying your first app ![External link icon](images/launch-glyph.svg "External link icon")](https://cloud.ibm.com/docs){: new_window}. 

## Before you begin
{: #prereqs}

You need an [{{site.data.keyword.cloud}} account ![External link icon](images/launch-glyph.svg "External link icon")](https://cloud.ibm.com/registration/){: new_window},
an instance of the {{site.data.keyword.cloudant_short_notm}} service, and the following Python requirements:

*	Install the most recent version of the
	[Python programming language ![External link icon](images/launch-glyph.svg "External link icon")](https://www.python.org/){: new_window} on your system.
	
	To check, run the following command at a prompt:
	```sh
	python --version
	```
	{: pre}
	
	You see a result similar to this one:

	```
	Python 2.7.12
	```
	{: screen}

*	Install the Python library
	to enable your Python applications to work with
	{{site.data.keyword.cloudant_short_notm}} on {{site.data.keyword.cloud_notm}}.
	
	To check the client library is already installed,
	run the following command at a prompt:
	```sh
	pip freeze
	```
	{: pre}
	
	You will see a list of all the Python modules that are installed on your system. Inspect the list, looking for an {{site.data.keyword.cloudant_short_notm}} entry similar to the following one:

	```
	cloudant==<version>
	```
	{: screen}
	
	If the `cloudant` module is not installed, install it by using a command similar to the following one:
	
	```
	pip install cloudant
	```
	{: pre}
  
  For more information about the Python library, see the [supported platforms](/docs/services/Cloudant/libraries/supported.html#python) documentation. 

## Step 1: Connect to your {{site.data.keyword.cloudant_short_notm}} service instance on {{site.data.keyword.cloud_notm}}
{: #step-1-connect-to-your-cloudant-nosql-db-service-instance-on-ibm-cloud}

1.	Run the `import` statements of the {{site.data.keyword.cloudant_short_notm}}
	Client Library components to enable your Python application to connect to
	the {{site.data.keyword.cloudant_short_notm}} service instance.
	```python
	from cloudant.client import Cloudant
	from cloudant.error import CloudantException
	from cloudant.result import Result, ResultByKey
	```
	{: codeblock}

2.  Create an {{site.data.keyword.cloudant_short_notm}} service credential:
  <br>In the {{site.data.keyword.cloud_notm}} dashboard, go to the **Menu** icon > **Resource List**, and open your {{site.data.keyword.cloudant_short_notm}} service instance.
  <br>In the left navigation, click `Service credentials`.
  <br>a. Click the `New credential` button.
  <br>![Create new service credentials](tutorials/images/img0050.png)
  <br>b. Enter a name for the new credential in the Add new credential window, as shown in the following screen shot.
  <br>c. (Optional) Add inline configuration parameters.
  <br>d. Click the `Add` button. 
  <br>![Add a new service credential](tutorials/images/img0051.png)
  <br>Your credentials are added to the Service credentials table.
  <br>e. Click `View credentials` under Actions. 
  <br>![View all service credentials](tutorials/images/img0052.png)
  <br>The details for the service credentials appear:
   <br>![The {{site.data.keyword.cloudant_short_notm}} service credentials](tutorials/images/img0009.png)
   
3.	Establish a connection to the {{site.data.keyword.cloudant_short_notm}} service instance. The mechanism to do so depends on whether you are using {{site.data.keyword.cloud_notm}} IAM or {{site.data.keyword.cloudant_short_notm}} Legacy authentication. See the [{{site.data.keyword.cloud_notm}} Identity and Access Management (IAM) guide ![External link icon](images/launch-glyph.svg "External link icon")](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-) for more details on either authentication type.

	If you are using {{site.data.keyword.cloudant_short_notm}} Legacy authentication, replace your service credentials from the previous step:
	```python
	client = Cloudant("<username>", "<password>", url="<url>")
	client.connect()
	```
	{: codeblock}
	
	If you are using IAM authentication, replace your service credentials from the previous step:
	```python
	client = Cloudant.iam("<username>", "<apikey>")
	client.connect()
	```
	{: codeblock}


## Step 2: Create a database
{: #step-2-create-a-database}

1. Define a variable in the Python application:
  ```python
  databaseName = "<your-database-name>"
  ```
  {: codeblock}

  ... where `<your-database-name>` is the name you would like to give your database. 

  The database name must begin with a letter and can include only lowercase characters (a-z), numerals (0-9), and any of the following characters `_`, `$`, `(`, `)`, `+`, `-`, and `/`.
  {: warning}

2. Create the database:
  ```python
  myDatabase = client.create_database(databaseName)
  ```
  {: codeblock}

3. Confirm that the database was created successfully:
  ```python
  if myDatabase.exists():
      print "'{0}' successfully created.\n".format(databaseName)
  ```
  {: codeblock}

## Step 3: Store a small collection of data as documents within the database
{: #step-3-store-a-small-collection-of-data-as-documents-within-the-database}

1. Define a collection of data:
  ```python
  sampleData = [
      [1, "one", "boiling", 100],
      [2, "two", "hot", 40],
      [3, "three", "warm", 20],
      [4, "four", "cold", 10],
      [5, "five", "freezing", 0]
    ]
  ```
  {: codeblock}

2. Use Python code to 'step' through the data and convert it into JSON documents.
  Each document is stored in the database:

  ```python
  # Create documents by using the sample data.
  # Go through each row in the array
  for document in sampleData:
    # Retrieve the fields in each row.
    number = document[0]
    name = document[1]
    description = document[2]
    temperature = document[3]
    #
    # Create a JSON document that represents
    # all the data in the row.
    jsonDocument = {
        "numberField": number,
        "nameField": name,
        "descriptionField": description,
        "temperatureField": temperature
    }
    #
    # Create a document by using the database API.
    newDocument = myDatabase.create_document(jsonDocument)
    #
    # Check that the document exists in the database.
    if newDocument.exists():
        print "Document '{0}' successfully created.".format(number)
  ```
  {: codeblock}

  Notice that we check to ensure that each document is successfully created.
  {: tip}

## Step 4: Retrieving data through queries
{: #step-4-retrieving-data-through-queries}

A small collection of data was stored as documents within the database.
You can do a minimal or full retrieval of that data from the database.
A minimal retrieval obtains the basic data _about_ a document.
A full retrieval also includes the data _within_ a document.

* To run a minimal retrieval:
  1. First, request a list of all documents within the database.
    ```python
    result_collection = Result(myDatabase.all_docs)
    ```      
    {: codeblock}

    This list is returned as an array.

  2. Display the content of an element in the array.
    ```python
    print "Retrieved minimal document:\n{0}\n".format(result_collection[0])
    ```
    {: codeblock}

    The result is similar to the following example:
    
    ```
    [{u'value': {u'rev': u'1-106e76a2612ea13468b2f243ea75c9b1'}, u'id': u'14be111aac74534cf8d390eaa57db888', u'key': u'14be111aac74534cf8d390eaa57db888'}]
    ```
    {: screen}
    
    The `u` prefix is an indication that Python is displaying a Unicode string. 
    {: tip}

    If we tidy the appearance a little, we can see that the minimal document details we got back are equivalent to this example:
    
    ```json
    [
        {
            "value": {
                "rev": "1-106e76a2612ea13468b2f243ea75c9b1"
            },
            "id": "14be111aac74534cf8d390eaa57db888",
            "key": "14be111aac74534cf8d390eaa57db888"
        }
    ]
    ```
    {: codeblock}

    The idea that the first document that is stored in a database is always the first document returned in a list of results does not always apply to NoSQL databases like {{site.data.keyword.cloudant_short_notm}}.
    {: note}

* To run a full retrieval,
  request a list of all documents within the database,
  and specify that the document content must also be returned
  by providing the `include_docs` option.
  ```python
  result_collection = Result(myDatabase.all_docs, include_docs=True)
  print "Retrieved full document:\n{0}\n".format(result_collection[0])
  ```
  {: codeblock}
  
  The result is similar to the following example:
  ```
  [{u'value': {u'rev': u'1-7130413a8c7c5f1de5528fe4d373045c'}, u'id': u'0cfc7d902f613d5fdb7b7818e262353b', u'key': u'0cfc7d902f613d5fdb7b7818e262353b', u'doc': {u'temperatureField': 40, u'descriptionField': u'hot', u'numberField': 2, u'nameField': u'two', u'_id': u'0cfc7d902f613d5fdb7b7818e262353b', u'_rev': u'1-7130413a8c7c5f1de5528fe4d373045c'}}]
  ```
  {: screen}
  
  If we tidy the appearance a little, we can see that the full document details we got back are equivalent to this example:
  
  ```json
  [
    {
      "value": {
        "rev": "1-7130413a8c7c5f1de5528fe4d373045c
      },
      "id": "0cfc7d902f613d5fdb7b7818e262353b",
      "key": "0cfc7d902f613d5fdb7b7818e262353b",
      "doc": {
        "temperatureField": 40,
        "descriptionField": "hot",
        "numberField": 2,
        "nameField": "two",
        "_id": "0cfc7d902f613d5fdb7b7818e262353b",
        "_rev": "1-7130413a8c7c5f1de5528fe4d373045c"
      }
    }
  ]
  ```
  {: codeblock}

## Step 5: Retrieving data through the {{site.data.keyword.cloudant_short_notm}} API endpoint
{: #step-5-retrieving-data-through-the-cloudant-nosql-db-api-endpoint}

You can also request a list of all documents and their contents by
invoking the {{site.data.keyword.cloudant_short_notm}} [`/_all_docs` endpoint](/docs/services/Cloudant?topic=cloudant-databases#get-documents).

1. Identify the endpoint to contact, and any parameters to supply along with the call:
  ```python
  end_point = '{0}/{1}'.format("client.server_url", databaseName + "/_all_docs")
  params = {'include_docs': 'true'}
  ```
  {: codeblock}
  ... where `client.server_url` is the URL value from the service credentials you found in Step 1.

2. Send the request to the service instance, and display the results:
  ```python
  response = client.r_session.get(end_point, params=params)
  print "{0}\n".format(response.json())
  ```
  {: codeblock}

  The result is similar to the following _abbreviated_ example:
  
  ```
  {u'rows': [{u'value': {u'rev': u'1-6d8cb5905316bf3dbe4075f30daa9f59'}, u'id': u'0532feb6fd6180d79b842d871316c444', u'key': u'0532feb6fd6180d79b842d871316c444', u'doc': {u'temperatureField': 20, u'descriptionField': u'warm', u'numberField': 3, u'nameField': u'three', u'_id': u'0532feb6fd6180d79b842d871316c444', u'_rev': u'1-6d8cb5905316bf3dbe4075f30daa9f59'}}, ... , {u'value': {u'rev': u'1-3f61736fa96473d358365ce1665e3d97'}, u'id': u'db396f77bbe12a567b09177b4accbdbc', u'key': u'db396f77bbe12a567b09177b4accbdbc', u'doc': {u'temperatureField': 0, u'descriptionField': u'freezing', u'numberField': 5, u'nameField': u'five', u'_id': u'db396f77bbe12a567b09177b4accbdbc', u'_rev': u'1-3f61736fa96473d358365ce1665e3d97'}}], u'total_rows': 5, u'offset': 0}
  ```
  {: screen}
  
  We can tidy the appearance a little, and see that the _abbreviated_ details we got back are similar to this example:
  
  ```json
  {
      "rows": [
          {
              "value": {
                "rev": "1-6d8cb5905316bf3dbe4075f30daa9f59"
              },
              "id": "0532feb6fd6180d79b842d871316c444",
              "key": "0532feb6fd6180d79b842d871316c444",
              "doc": {
                  "temperatureField": 20,
                  "descriptionField": "warm",
                  "numberField": 3,
                  "nameField": "three",
                  "_id": "0532feb6fd6180d79b842d871316c444",
                  "_rev": "1-6d8cb5905316bf3dbe4075f30daa9f59"
              }
          },
          ...
          {
              "value":
              {
                "rev": "1-6d8cb5905316bf3dbe4075f30daa9f59"
              },
              "id": "db396f77bbe12a567b09177b4accbdbc",
              "key": "db396f77bbe12a567b09177b4accbdbc",
              "doc": {
                  "temperatureField": 0,
                  "descriptionField": "freezing",
                  "numberField": 5,
                  "nameField": "five",
                  "_id": "db396f77bbe12a567b09177b4accbdbc",
                  "_rev": "1-6d8cb5905316bf3dbe4075f30daa9f59"
              }
          }
      ],
      "total_rows": 5,
      "offset": 0
  }
  ```
  {: codeblock}

## (optional) Step 6: See database information on the {{site.data.keyword.cloudant_short_notm}} dashboard
{: #optional-step-6-ibm-cloudant-dashboard}

Follow these steps to see your database and documents on the {{site.data.keyword.cloudant_short_notm}} dashboard. 

1.  Log in to your IBM Cloud account.
    The IBM Cloud dashboard can be found at: https://cloud.ibm.com/. After authenticating with your user name and password, you are presented with the IBM Cloud dashboard.
2.  Click **Services** in the Resource summary pane to see your {{site.data.keyword.cloudant_short_notm}} service instances. 
3.  Click the service instance whose details you want to see.
4.  Click **Launch Cloudant Dashboard**. 
    When the dashboard opens, you can see the databases associated with your service.


## Step 7: Delete the database
{: #step-7-delete-the-database}

When you are finished with the database,
it can be deleted.

```python
try:
    client.delete_database(databaseName)
except CloudantException:
    print "There was a problem deleting '{0}'.\n".format(databaseName)
else:
    print "'{0}' successfully deleted.\n".format(databaseName)
```
{: codeblock}

We included some basic error handling
to show you how to troubleshoot and address potential issues.

## Step 8: Close the connection to the service instance
{: #step-8-close-the-connection-to-the-service-instance}

The final step is to disconnect the Python client application from the service instance:

```python
client.disconnect()
```
{: codeblock}

## Next steps
{: #next-steps}

For more information about all {{site.data.keyword.cloudant_short_notm}} offerings,
see the main [{{site.data.keyword.cloudant_short_notm}} ![External link icon](images/launch-glyph.svg "External link icon")](https://www.ibm.com/cloud/cloudant){: new_window} site.

For  more information, see tutorials, {{site.data.keyword.cloudant_short_notm}} concepts, tasks, and techniques in the [{{site.data.keyword.cloudant_short_notm}} documentation](/docs/services/Cloudant?topic=cloudant-overview#overview).

## Appendix: Complete Python code listing
{: #appendix-complete-python-code-listing}

The complete Python code listing is as follows. 
Remember to replace the `<username>`,
`<password>`, `<url>`, and `<apikey>` values with your service credentials.
Similarly,
replace the `<yourDatabaseName>` value with the name for your database.

```python
from cloudant.client import Cloudant
from cloudant.error import CloudantException
from cloudant.result import Result, ResultByKey

# {{site.data.keyword.cloudant_short_notm}} Legacy authentication
client = Cloudant("<username>", "<password>", url="<url>")
client.connect()

# IAM Authentication (uncomment if needed, and comment out {{site.data.keyword.cloudant_short_notm}} Legacy authentication section above)
client = Cloudant.iam("<username","<apikey>")
client.connect()

databaseName = "<yourDatabaseName>"

myDatabase = client.create_database(databaseName)

if myDatabase.exists():
    print "'{0}' successfully created.\n".format(databaseName)

sampleData = [
    [1, "one", "boiling", 100],
    [2, "two", "hot", 40],
    [3, "three", "warm", 20],
    [4, "four", "cold", 10],
    [5, "five", "freezing", 0]
]

# Create documents using the sample data.
# Go through each row in the array
for document in sampleData:
    # Retrieve the fields in each row.
    number = document[0]
    name = document[1]
    description = document[2]
    temperature = document[3]

    # Create a JSON document that represents
    # all the data in the row.
    jsonDocument = {
        "numberField": number,
        "nameField": name,
        "descriptionField": description,
        "temperatureField": temperature
    }

    # Create a document using the Database API.
    newDocument = myDatabase.create_document(jsonDocument)

    # Check that the document exists in the database.
    if newDocument.exists():
        print "Document '{0}' successfully created.".format(number)

result_collection = Result(myDatabase.all_docs)

print "Retrieved minimal document:\n{0}\n".format(result_collection[0])

result_collection = Result(myDatabase.all_docs, include_docs=True)
print "Retrieved full document:\n{0}\n".format(result_collection[0])

end_point = '{0}/{1}'.format("<url>", databaseName + "/_all_docs")
params = {'include_docs': 'true'}
response = client.r_session.get(end_point, params=params)
print "{0}\n".format(response.json())


try :
    client.delete_database(databaseName)
except CloudantException:
    print "There was a problem deleting '{0}'.\n".format(databaseName)
else:
    print "'{0}' successfully deleted.\n".format(databaseName)

client.disconnect()

```
{: codeblock}
