---

copyright:
  years: 2015, 2019
lastupdated: "2019-11-18"

keywords: getting started, example, connect to service instance, create a database, populate database, retrieve data, queries, retrieve data, api endpoint, delete database, close connection, python code, couchdb-as-a-service, couchdb hosted, couchdb, databases for couchdb

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

<!-- Acrolinx: 2018-05-31 -->

# Getting started with {{site.data.keyword.cloudant_short_notm}}
{: #getting-started}

In this {{site.data.keyword.cloudantfull}} getting started tutorial,
we use Python to create an {{site.data.keyword.cloudant_short_notm}} database
and populate that database with a simple collection of data. You can retrieve data by using queries or API endpoints. 
{: shortdesc}

For more inforamtion, see our hands-on tutorials that help you learn more about {{site.data.keyword.cloudant_short_notm}}. Or try one of the tutorials that focuses on a specific language:

- [Node.js and {{site.data.keyword.cloudant_short_notm}}](https://cloud.ibm.com/docs/node?topic=nodejs-cloudant){: new_window}{: external}
- [Swift and {{site.data.keyword.cloudant_short_notm}}](https://cloud.ibm.com/docs/swift?topic=swift-getting-started){: new_window}{: external}
- [Python and {{site.data.keyword.cloudant_short_notm}}](https://cloud.ibm.com/docs/cloud-foundry-public?topic=cloud-foundry-getting-started-python#add_database-python){: new_window}{: external}

For more language-specific tutorials, see [Get started by deploying your first app](https://cloud.ibm.com/docs/home/build){: new_window}{: external}. 

## Before you begin
{: #prereqs}

Verify that you have what you need to start the tutorial from the following list:

- An [{{site.data.keyword.cloud}} account](https://cloud.ibm.com){: new_window}{: external}
- [An instance of the {{site.data.keyword.cloudant_short_notm}} service](/docs/services/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud)
- Verify that you have the  most current version of the [Python programming language](https://www.python.org/){: new_window}{: external}:

  1.  To check the Python version installed on your machine, run the following command:
      ```sh
	    python3 --version
	    ```
	    {: pre}
	
  2. Verify that your version matches the most recent version. The result looks something like this:
	    ```
	    Python 3.7.4
	    ```
	    {: screen}

- The Cloudant Python library enables your Python applications to work with
	{{site.data.keyword.cloudant_short_notm}} on {{site.data.keyword.cloud_notm}}.
	
	1.	To check that the client library is already installed, run the following command at a prompt:	
      ```sh
	    pip3 freeze
	    ```
	    {: pre}
	
	    You see a list of all the Python modules that are installed on your system. Review the list, looking for an {{site.data.keyword.cloudant_short_notm}} entry similar to the following one:

	    ```
	    cloudant==<version>
	    ```
	    {: screen}
	
	2.  If the `cloudant` module isn't installed, install it by using a command similar to the following one:
	    ```
	    pip3 install cloudant
	    ```
	    {: pre}
  
      For more information about the Python library, see the [supported platforms](/docs/services/Cloudant?topic=cloudant-supported-client-libraries#python-supported) documentation. 

## Step 1. Connect to your {{site.data.keyword.cloudant_short_notm}} service instance on {{site.data.keyword.cloud_notm}}
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
  <br>In the menu, click `Service credentials`.
  <br>a. Click the `New credential` button.
  <br>![Create new service credentials](tutorials/images/img0050.png)
  <br>b. Enter a name for the new credential in the Add new credential window, as shown in the following screen capture.
  <br>c. (Optional) Add inline configuration parameters.
  <br>d. Click the `Add` button. 
  <br>![Add a service credential](tutorials/images/img0051.png)
  <br>Your credentials are added to the Service credentials table.
  <br>e. Click `View credentials` under Actions. 
  <br>![View all service credentials](tutorials/images/img0052.png)
  <br>The details for the service credentials appear:
   <br>![The {{site.data.keyword.cloudant_short_notm}} service credentials](tutorials/images/img0009.png)
   
3.	Establish a connection to the {{site.data.keyword.cloudant_short_notm}} service instance. The way {{site.data.keyword.cloudant_short_notm}} establishes this connection depends on whether you're using {{site.data.keyword.cloud_notm}} Identity and Access Management (IAM) or {{site.data.keyword.cloudant_short_notm}} Legacy authentication. For more information about either authentication type, see the [IAM guide](/docs/services/Cloudant?topic=cloudant-ibm-cloud-identity-and-access-management-iam-#ibm-cloud-identity-and-access-management-iam-).

	If you're using {{site.data.keyword.cloudant_short_notm}} Legacy authentication, replace your service credentials from the previous step:
	```python
	client = Cloudant("<username>", "<password>", url="<url>")
	client.connect()
	```
	{: codeblock}
	
	If you're using IAM authentication, replace your service credentials from the previous step:
	```python
	client = Cloudant.iam("<username>", "<apikey>")
	client.connect()
	```
	{: codeblock}


## Step 2. Create a database
{: #step-2-create-a-database}

1. Define a variable in the Python application:
  ```python
  database_name = "<your-database-name>"
  ```
  {: codeblock}

  ... where `<your-database-name>` is the name you would like to give your database. 

  The database name must begin with a letter and can include only lowercase characters (a-z), numerals (0-9), and any of the following characters `_`, `$`, `(`, `)`, `+`, `-`, and `/`.
  {: important}

2. Create the database:
  ```python
  my_database = client.create_database(database_name)
  ```
  {: codeblock}

3. Confirm that the database was created successfully:
  ```python
  if my_database.exists():
      print(f"'{database_name}' successfully created.")
  ```
  {: codeblock}

## Step 3. Store a small collection of data as documents within the database
{: #step-3-store-a-small-collection-of-data-as-documents-within-the-database}

1. Define a collection of data:
  ```python
  sample_data = [
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
  for document in sample_data:
    # Retrieve the fields in each row.
    number = document[0]
    name = document[1]
    description = document[2]
    temperature = document[3]
    #
    # Create a JSON document that represents
    # all the data in the row.
    json_document = {
        "numberField": number,
        "nameField": name,
        "descriptionField": description,
        "temperatureField": temperature
    }
    #
    # Create a document by using the database API.
    new_document = my_database.create_document(json_document)
    #
    # Check that the document exists in the database.
    if new_document.exists():
        print(f"Document '{number}' successfully created.")
  ```
  {: codeblock}

  Notice that we check to ensure that each document is successfully created.
  {: tip}

## Step 4. Retrieve data through queries
{: #step-4-retrieve-data-through-queries}

A small collection of data was stored as documents within the database.
You can do a minimal or full retrieval of that data from the database.
A minimal retrieval includes the basic data *about* a document.
A full retrieval also includes the data *within* a document.

* To run a minimal retrieval, follow these steps:
  1. First, request a list of all documents within the database.
    ```python
    result_collection = Result(my_database.all_docs)
    ```      
    {: codeblock}

    This list is returned as an array.

  2. Display the content of an element in the array.
    ```python
    print(f"Retrieved minimal document:\n{result_collection[0]}\n")
    ```
    {: codeblock}

    The result is similar to the following example:
    
    ```
    [{u'value': {u'rev': u'1-106e76a2612ea13468b2f243ea75c9b1'}, u'id': u'14be111aac74534cf8d390eaa57db888', u'key': u'14be111aac74534cf8d390eaa57db888'}]
    ```
    {: screen}
    
    The `u` prefix is an indication that Python is displaying a Unicode string. 
    {: tip}

    If we tidy the appearance a little, we can see that the minimal document details returned are similar to this example:
    
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

    NoSQL databases like {{site.data.keyword.cloudant_short_notm}} don't always adhere to the first in first out method, which means that a document that is stored in the database isn't always the first document returned in a list of results.
    {: note}

* To run a full retrieval,
  request a list of all documents within the database,
  and provide the `include_docs` option to specify that the document content must also be returned.
  ```python
  result_collection = Result(my_database.all_docs, include_docs=True)
  print(f"Retrieved full document:\n{result_collection[0]}\n")
  ```
  {: codeblock}
  
  The result is similar to the following example:
  ```
  [{u'value': {u'rev': u'1-7130413a8c7c5f1de5528fe4d373045c'}, u'id': u'0cfc7d902f613d5fdb7b7818e262353b', u'key': u'0cfc7d902f613d5fdb7b7818e262353b', u'doc': {u'temperatureField': 40, u'descriptionField': u'hot', u'numberField': 2, u'nameField': u'two', u'_id': u'0cfc7d902f613d5fdb7b7818e262353b', u'_rev': u'1-7130413a8c7c5f1de5528fe4d373045c'}}]
  ```
  {: screen}
  
  If we tidy the appearance a little, we can see that the full document details we got back are similar to this example:
  
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


## (Optional) Step 5. See database information on the {{site.data.keyword.cloudant_short_notm}} Dashboard
{: #optional-step-5-ibm-cloudant-dashboard}

Follow these steps to see your database and documents on the {{site.data.keyword.cloudant_short_notm}} Dashboard. 

1.  Log in to your {{site.data.keyword.cloud_notm}} account.
    The {{site.data.keyword.cloud_notm}} dashboard can be found at: cloud.ibm.com. After you authenticate with your user name and password, you're presented with the IBM Cloud dashboard.
2.  Click **Services** in the Resource summary pane to see your {{site.data.keyword.cloudant_short_notm}} service instances. 
3.  Click the service instance whose details you want to see.
4.  Click **Launch Cloudant Dashboard**. 
    When the dashboard opens, you can see the databases that are associated with your service.


## Step 6. Delete the database
{: #step-6-delete-the-database}

When you're finished with the database,
it can be deleted.

```python
try:
    client.delete_database(database_name)
except CloudantException:
    print(f"There was a problem deleting '{database_name}'.\n")
else:
    print(f"'{database_name}' successfully deleted.\n")
```
{: codeblock}

We included some basic error handling
to show you how to troubleshoot and address potential issues.

## Step 7. Close the connection to the service instance
{: #step-7-close-the-connection-to-the-service-instance}

The final step is to disconnect the Python client application from the service instance:

```python
client.disconnect()
```
{: codeblock}

## Next steps
{: #next-steps}

For more information about all {{site.data.keyword.cloudant_short_notm}} offerings,
see the main [{{site.data.keyword.cloudant_short_notm}}](https://www.ibm.com/cloud/cloudant){: new_window}{: external} site.

For  more information, see tutorials, {{site.data.keyword.cloudant_short_notm}} concepts, tasks, and techniques in the [{{site.data.keyword.cloudant_short_notm}} documentation](/docs/services/Cloudant?topic=cloudant-overview#overview).

## Appendix. Complete Python code listing
{: #appendix-complete-python-code-listing}

The complete Python code listing is as follows. 
Remember to replace the `<username>`,
`<password>`, `<url>`, and `<apikey>` values with your service credentials.
Similarly,
replace the `<yourDatabaseName>` value with the name for your database.

```python
from cloudant.client import Cloudant
from cloudant.error import CloudantException
from cloudant.result import Result

# {{site.data.keyword.cloudant_short_notm}} Legacy authentication
client = Cloudant("<username>", "<password>", url="<url>")
client.connect()

# IAM Authentication (uncomment if needed, and comment out previous {{site.data.keyword.cloudant_short_notm}} Legacy authentication section)
# client = Cloudant.iam("<username>", "<apikey>")
# client.connect()

database_name = "<your-database-name>"

my_database = client.create_database(database_name)

if my_database.exists():
    print(f"'{database_name}' successfully created.")

sample_data = [
    [1, "one", "boiling", 100],
    [2, "two", "hot", 40],
    [3, "three", "warm", 20],
    [4, "four", "cold", 10],
    [5, "five", "freezing", 0]
]

# Create documents using the sample data.
# Go through each row in the array
for document in sample_data:
    # Retrieve the fields in each row.
    number = document[0]
    name = document[1]
    description = document[2]
    temperature = document[3]

    # Create a JSON document that represents
    # all the data in the row.
    json_document = {
        "numberField": number,
        "nameField": name,
        "descriptionField": description,
        "temperatureField": temperature
    }

    # Create a document using the Database API.
    new_document = my_database.create_document(json_document)

    # Check that the document exists in the database.
    if new_document.exists():
        print(f"Document '{number}' successfully created.")

result_collection = Result(my_database.all_docs)

print(f"Retrieved minimal document:\n{result_collection[0]}\n")

result_collection = Result(my_database.all_docs, include_docs=True)
print(f"Retrieved full document:\n{result_collection[0]}\n")

try:
    client.delete_database(database_name)
except CloudantException:
    print(f"There was a problem deleting '{database_name}'.\n")
else:
    print(f"'{database_name}' successfully deleted.\n")

client.disconnect()
```
{: codeblock}