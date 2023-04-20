---

copyright:
  years: 2017, 2023
lastupdated: "2023-04-20"

keywords: close connection, delete database, request ibm cloudant api endpoint, data retrieval, store data, create database, connect to ibm cloudant

subcollection: Cloudant

content-type: tutorial
services: Cloudant
account-plan: lite
completion-time: 15m

---

{{site.data.keyword.attribute-definition-list}}

# Creating and populating a database
{: #creating-and-populating-a-simple-ibm-cloudant-database-on-ibm-cloud}
{: toc-content-type="tutorial"}
{: toc-services="Cloudant"}
{: toc-completion-time="15m"}

This tutorial shows you how to use the [Python programming language](https://www.python.org/){: external} to
create an {{site.data.keyword.cloudantfull}} database in your {{site.data.keyword.cloud_notm}} service instance. You also learn how to populate the database with a simple collection of data.
{: shortdesc}

This tutorial doesn't use the most efficient Python code. The intent is to show simple and easy-to-understand working code
that you can learn from and apply to your own applications. You must apply normal best practices for checking and handling all
warning or error conditions that are encountered by your own applications.
{: note}

## Objectives
{: #objectives-db}

This tutorial builds on a series of Python language instructions,
suitable for the following tasks:

1.  Connecting to an {{site.data.keyword.cloudant_short_notm}} service instance on {{site.data.keyword.cloud}}.
2.  Creating a database within the service instance.
3.  Storing a small collection of data as documents within the database.
4.  Retrieving data.
5.  Deleting the database.
6.  Closing the connection to the service instance.

## Before you begin
{: #before-you-begin}

This tutorial provides you with the following options:

- Follow each step as outlined in this tutorial.
- Or [execute the Python script](#execute-the-complete-python-script), and come back to [Step 5. Retrieving data](#retrieving-data).

## Installing Python
{: #installing-python}

Normally, you don't run commands individually in Python. You usually
create a script, which is a list of the commands you want to run,
stored in a Python file, with a `py` extension.
{: tip}

1. Set up service credential requirements.

   a. Create a service instance and credentials by following the [Getting started](/docs/Cloudant?topic=Cloudant-getting-started-with-cloudant) tutorial.

   b. [Locate your service credentials](/docs/Cloudant?topic=Cloudant-locating-your-service-credentials#locating-your-service-credentials) by following this tutorial.

2. Install the required version of Python.

   You must have a current version of the [Python programming language](https://www.python.org/){: external} that is installed on your system.
   [: note]

   a. Check that Python is installed by running the following command at a prompt:

   ```sh
   python3 --version
   ```
   {: pre}

   b. Verify that you get a result similar to the following example:

   ```sh
   Python 3.8.1
   ```
   {: codeblock}

3. Verify that your Python Client Library meets the requirement. 

   The following examples use the deprecated `python-cloudant` client library.
   {: deprecated}

   a. Check that the client library installed successfully by running the following command at a prompt:

   ```sh
   pip freeze
   ```
   {: pre}

   You get a list of all the Python modules installed on your system.

   b. Inspect the list, looking for an {{site.data.keyword.cloudant_short_notm}} entry similar to the following example:

   ```sh
   cloudant==2.14.0
   ```
   {: codeblock}

## Connecting to a service instance
{: #connecting-to-an-ibm-cloudant-service-instance-on-ibm-cloud}
{: step}

You must connect to your service instance before you create a database.

The following components are identified as normal `import` statements.

You can follow steps 1 - 5 to learn about the individual commands, or go to the end of the tutorial to [execute the Python script](#execute-the-complete-python-script). When you finish, return to [Step 5. Retrieving data](#retrieving-data). 

1. Run these `import` statements to connect to the service instance.

   ```python
   from cloudant.client import Cloudant
   from cloudant.error import CloudantException
   from cloudant.result import Result, ResultByKey
   ```
   {: codeblock}

2. Find `username`, `password`, and `URL` in your Classic service credentials and replace `serviceUsername`, `servicePassword`, and `serviceURL` in the following example.

    ```python
    serviceUsername = "apikey-v2-58B528DF5397465BB6673E1B79482A8C"
    servicePassword = "49c0c343d225623956157d94b25d574586f26d1211e8e589646b4713d5de4801"
    serviceURL = "https://353466e8-47eb-45ce-b125-4a4e1b5a4f7e-bluemix.cloudant.com"
    ```
    {: codeblock}

3. Establish a connection to the service instance.

    ```python
    client = Cloudant(serviceUsername, servicePassword, url=serviceURL)
    client.connect()
    ```
    {: codeblock}

4. Or replace `ACCOUNT_NAME` and `API_KEY` with the values from your IAM API service credentials.

    ```json
    client = Cloudant.iam(ACCOUNT_NAME, API_KEY, connect=True)
    ```
    {: codeblock}

Now, your Python application can access the service instance on {{site.data.keyword.cloud_notm}}.

## Creating a database within the service instance
{: #creating-a-database-within-the-service-instance}
{: step}

Next, you create a database within the service instance,
called `databasedemo`.

1. Create this instance by defining a variable in the Python application.

    ```python
    databaseName = "databasedemo"
    ```
    {: codeblock}

2. Create the database.

    ```python
    myDatabaseDemo = client.create_database(databaseName)
    ```
    {: codeblock}

3. Verify that the database was created successfully.

    ```python
    if myDatabaseDemo.exists():
        print("'{0}' successfully created.\n".format(databaseName))
    ```
    {: codeblock}

## Storing a small collection of data as documents within the database
{: #storing-a-small-collection-of-data-as-documents-within-the-database}
{: step}

You want to store a small,
simple collection of data in the database. This data is used in other tutorials, like [Using {{site.data.keyword.cloudant_short_notm}} Query to find data](/docs/Cloudant?topic=Cloudant-creating-an-ibm-cloudant-query).

1. Create sample data.

    ```python
    sampleData = [
         [1, "one", "boiling", 100],
         [2, "two", "hot", 40],
         [3, "three", "hot", 75],
         [4, "four", "hot", 97],
         [5, "five", "warm", 20],
         [6, "six", "cold", 10],
         [7, "seven", "freezing", 0],
         [8, "eight", "freezing", -5]
    ]
    ```
    {: codeblock}

2. Use a `for` statement to retrieve the fields in each row by going through each row in the array.

    ```python
    for document in sampleData:
        # Retrieve the fields in each row.
        number = document[0]
        name = document[1]
        description = document[2]
        temperature = document[3]
    ```
    {: codeblock}

3. Create a JSON document that represents all the data in the row.

    ```python
    jsonDocument = {
	    "numberField": number,
	    "nameField": name,
	    "descriptionField": description,
	    "temperatureField": temperature
    }
    ```
    {: codeblock}

4. Create a document by using the Database API.

    ```python
    newDocument = myDatabaseDemo.create_document(jsonDocument)
    ```
    {: codeblock}

5. Check that the document exists in the database.

    ```python
    if newDocument.exists():
        print("Document '{0}' successfully created.".format(number))
    ```
    {: codeblock}

## Retrieving data
{: #retrieving-data}
{: step}

To perform a minimal retrieval,
you first request a list of all documents within the database.
This list is returned as an array.
You can then show the content of an element in the array.

1. Retrieve a minimal amount of data.

    ```python
    result_collection = Result (myDatabaseDemo.all_docs)
    print("Retrieved minimal document:\n{0}\n".format(result_collection[0]))
    ```
    {: codeblock}

2. See a result similar to the following example.

    ```json
    [{
    	"id": '60e19edf809418e407fb6791a1d8fec4',
    	"key": '60e19edf809418e407fb6791a1d8fec4',
    	"value": {
    		"rev": '2-3d6dc27627114431c049ddecae9796e0'
    	}
    }]
    ```
    {: codeblock}

In a relational database, the first 
document that is stored in a database
is always the first document that is returned in a list of results. 
This notion doesn't
necessarily apply to NoSQL databases, such as {{site.data.keyword.cloudant_short_notm}}.

### Full retrieval of a document
{: #full-retrieval-of-a-document}
{: step}

Additionally, to perform a full retrieval,
you request a list of all documents within the database,
and specify that the document content must also be returned.
You run a full retrieval by using the `include_docs` option.
As before,
the results are returned as an array.
You can then show the details of an element in the array
by including the full content of the document this time.

1. Request the first document that is retrieved from the database.

    ```python
    result_collection = Result(myDatabaseDemo.all_docs, include_docs=True)
    print("Retrieved minimal document:\n{0}\n".format(result_collection[0]))
    ```
    {: codeblock}

2. See the result, which is similar to the following example:

    ```json
    [
        {
            "value": {
              "rev": "1-b2c48b89f48f1dc172d4db3f17ff6b9a"
            },
            "id": "14746fe384c7e2f06f7295403df89187",
            "key": "14746fe384c7e2f06f7295403df89187",
            "doc": {
                "temperatureField": 10,
                "descriptionField": "cold",
                "numberField": 6,
                "nameField": "six",
                "_id": "14746fe384c7e2f06f7295403df89187",
                "_rev": "1-b2c48b89f48f1dc172d4db3f17ff6b9a"
            }
        }
    ]
    ```
    {: codeblock}

## Calling an {{site.data.keyword.cloudant_short_notm}} API endpoint directly
{: #calling-an-ibm-cloudant-api-endpoint-directly}
{: step}

You can work with the {{site.data.keyword.cloudant_short_notm}} API endpoints directly,
from within a Python application.

In this example code,
you again request a list of all the documents,
including their content.
However, this time you do so by invoking the {{site.data.keyword.cloudant_short_notm}} [`/_all_docs`](/apidocs/cloudant#postalldocs){: external} endpoint.

1. Identify the endpoint to contact and any parameters to supply with it.

    ```python
    end_point = '{0}/{1}'.format(serviceURL, databaseName + "/_all_docs")
    params = {'include_docs': 'true'}
    ```
    {: codeblock}

2. Send the request to the service instance and show the results.

    ```python
    response = client.r_session.get(end_point, params=params)
    print("{0}\n".format(response.json()))
    ```
    {: codeblock}

3. See the result that is similar to the following *abbreviated* example.

    ```json
    {
    	"rows": [{
    			"value": {
    				"rev": "1-b2c48b89f48f1dc172d4db3f17ff6b9a"
    			},
    			"id": "14746fe384c7e2f06f7295403df89187",
    			"key": "14746fe384c7e2f06f7295403df89187",
    			"doc": {
    				"temperatureField": 10,
    				"descriptionField": "cold",
    				"numberField": 6,
    				"nameField": "six",
    				"_id": "14746fe384c7e2f06f7295403df89187",
    				"_rev": "1-b2c48b89f48f1dc172d4db3f17ff6b9a"
    			}
    		},
    		...{
    			"value": {
    				"rev": "1-7130413a8c7c5f1de5528fe4d373045c"
    			},
    			"id": "49baa66cc66b4dda86ffb2852ae78eb8",
    			"key": "49baa66cc66b4dda86ffb2852ae78eb8",
    			"doc": {
    				"temperatureField": 40,
    				"descriptionField": "hot",
    				"numberField": 2,
    				"nameField": "two",
    				"_id": "49baa66cc66b4dda86ffb2852ae78eb8",
    				"_rev": "1-7130413a8c7c5f1de5528fe4d373045c"
    			}
    		}
    	],
    	"total_rows": 5,
    	"offset": 0
    }
    ```
    {: codeblock}

## Deleting the database
{: #deleting-the-database}
{: step}

1. Delete the database.

    ```python
    try :
        client.delete_database(databaseName)
    except CloudantException:
        print("There was a problem deleting '{0}'.\n".format(databaseName))
    else:
        print("'{0}' successfully deleted.\n".format(databaseName))
    ```
    {: codeblock}

2. Review the basic error handling that was included to illustrate how problems can be caught and addressed.

## Closing the connection to the service instance
{: #closing-the-connection-to-the-service-instance}
{: step}

1. Disconnect the Python client application from the service instance.
2. Run the disconnect command.

    ```python
    client.disconnect()
    ```
    {: codeblock}

## Execute the complete Python script
{: #execute-the-complete-python-script}

This script is the complete Python script for steps 2, 3, and 4. When you run
the script, it connects to your service instance, creates the database,
stores a small set of data in the database, and creates JSON documents.

1. In the code example in the next step, replace the values for `serviceUsername`, `servicePassword`, and `serviceURL` with the values from your service credentials. 

   For more information about where to find your credentials, see [Locating your credentials](/docs/Cloudant?topic=Cloudant-locating-your-service-credentials#locating-your-service-credentials).

1. Copy the following script into a text editor and name it `demo.py`.

    ```python
    #!/usr/bin/env python

    # Connect to service instance by running import statements.
    from cloudant.client import Cloudant
    from cloudant.error import CloudantException
    from cloudant.result import Result, ResultByKey

    # Add credentials to authenticate to the service instance.
    serviceUsername = "apikey-v2-58B528DF5397465BB6673E1B79482A8C"
    servicePassword = "680b037145f9dc8ef9e6a6d8b480783cbc1d1c12e71a0f4ced6b1eee30a243cd"
    serviceURL = "serviceURL = "https://0c869093-c3ee-4a3f-bcec-00f01c8df8d8-bluemix.cloudantnosqldb.appdomain.cloud""
    databaseName = "databasedemo"

    # Define sample data.
    sampleData = [
        [1, "one", "boiling", 100],
        [2, "two", "hot", 40],
        [3, "three", "hot", 75],
        [4, "four", "hot", 97],
        [5, "five", "warm", 20],
        [6, "six", "cold", 10],
        [7, "seven", "freezing", 0],
        [8, "eight", "freezing", -5]
    ]

    def main():
        # Establish a connection with the service instance.
        client = Cloudant(serviceUsername, servicePassword, url=serviceURL)
        client.connect()

        # Create database and verify it was created.
        myDatabaseDemo = client.create_database(databaseName)
        if myDatabaseDemo.exists():
            print("'{0}' successfully created.\n".format(databaseName))

        for document in sampleData:
            # Retrieve the fields in each row.
            number = document[0]
            name = document[1]
            description = document[2]
            temperature = document[3]

            #  Create a JSON document that represents all the data in the row.
            jsonDocument = {
                "numberField": number,
                "nameField": name,
                "descriptionField": description,
                "temperatureField": temperature
            }

            # Create a document by using the Database API.
            newDocument = myDatabaseDemo.create_document(jsonDocument)

            # Check that the documents exist in the database.
            if newDocument.exists():
                print("Document '{0}' successfully created.".format(number))

    if __name__=='__main__':
        main()
    ```
    {: codeblock}

1. From the command line, run `demo.py` by typing a command similar to the following one.

    ```python
    python3 demo.py
    ```
    {: codeblock}

   Once you run the script, return to [Step 5. Retrieving data](#retrieving-data) to complete the tutorial. 
