---

copyright:
  years: 2017, 2020
lastupdated: "2020-12-22"

keywords: close connection, delete database, request ibm cloudant api endpoint, data retrieval, store data, create database, connect to ibm cloudant

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

<!-- Acrolinx: 2020-10-12 -->

# Creating and populating a database
{: #creating-and-populating-a-simple-ibm-cloudant-database-on-ibm-cloud}

This tutorial shows you how to use the [Python programming language](https://www.python.org/){: new_window}{: external} to
create an {{site.data.keyword.cloudantfull}} database in your {{site.data.keyword.cloud_notm}} service instance. You also learn how to populate the database with a simple collection of data.
{: shortdesc}

## Prerequisites
{: #prerequisites-create_database}

Ensure that you have the following resources or information ready
before you start working through the tutorial.

### Python
{: #python-create-database}

You must have a current installation of the [Python programming language](https://www.python.org/){: new_window}{: external}
that is installed on your system.

To check that Python is installed,
run the following command at a prompt:

```sh
python3 --version
```
{: pre}

You must get a result similar to the following example:

```
Python 3.8.1
```
{: codeblock}

### Python Client Library for {{site.data.keyword.cloudant_short_notm}}
{: #python-client-library-for-ibm-cloudant}

An [officially supported library](/docs/Cloudant?topic=Cloudant-client-libraries#python-supported) is included to enable your Python applications to work with {{site.data.keyword.cloudant_short_notm}}. Use the instructions provided to install it. 

To check that the client library installed successfully,
run the following command at a prompt:

```sh
pip freeze
```
{: pre}

You must get a list of all the Python modules installed on your system.
Inspect the list,
looking for an {{site.data.keyword.cloudant_short_notm}} entry similar to the following example:

```
cloudant==2.3.1
```
{: codeblock}

### Creating an {{site.data.keyword.cloudant_short_notm}} service instance on {{site.data.keyword.cloud_notm}}
{: #creating-an-ibm-cloudant-service-instance-on-ibm-cloud}

The process for creating a suitable service instance is described in [this tutorial](/docs/Cloudant?topic=Cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud).

Ensure that you have the following Service Credentials available for your service instance:

Field      | Purpose
-----------|--------
`host`     | The hostname used by applications to locate the service instance.
`username` | The username required for applications to access the service instance.
`password` | The password required for applications to access the service instance.
`port`     | The HTTP port number for accessing the service instance on the host. Normally 443 to force HTTPS access.
`url`      | A string aggregating the other credential information into a single URL, suitable for use by applications.
{: caption="Table 1. Service credentials" caption-side="top"}

For more information about finding the service credentials for your service instance, see [Locating your service credentials](/docs/Cloudant?topic=Cloudant-locating-your-service-credentials).

## Context
{: #context}

This tutorial builds up a series of Python language instructions,
suitable for the following tasks:

1.  [Connecting to an {{site.data.keyword.cloudant_short_notm}} service instance on {{site.data.keyword.cloud}}](#connecting-to-an-ibm-cloudant-service-instance-on-ibm-cloud).
2.  [Creating a database within the service instance](#creating-a-database-within-the-service-instance).
3.  [Storing a small collection of data as documents within the database](#storing-a-small-collection-of-data-as-documents-within-the-database).
4.  [Retrieving data](#retrieving-data).
5.  [Deleting the database](#deleting-the-database).
6.  [Closing the connection to the service instance](#closing-the-connection-to-the-service-instance).

Python code specific to each task is provided as part of the task description in this tutorial.

For more information about the complete Python program to perform all the tasks, see the [complete listing](#complete-listing).

This tutorial doesn't use the most efficient Python code. Our intent is to show simple and easy-to-understand working code
that you can learn from and apply to your own applications.

Also,
we didn't address all possible checks or error conditions.
See the example checks shown here to illustrate the techniques.
You must apply normal best practices for checking and handling all
warning or error conditions that are encountered by your own applications. 

## Connecting to an {{site.data.keyword.cloudant_short_notm}} service instance on {{site.data.keyword.cloud_notm}}
{: #connecting-to-an-ibm-cloudant-service-instance-on-ibm-cloud}

A Python application requires the {{site.data.keyword.cloudant_short_notm}} Client Library. This supported library is discussed on the [client libraries](https://cloud.ibm.com/docs/Cloudant?topic=Cloudant-client-libraries#python-supported) page. 

These components are identified as normal `import` statements:

```python
from cloudant.client import Cloudant
from cloudant.error import CloudantException
from cloudant.result import Result, ResultByKey
```
{: codeblock}

The application must have the [Service Credentials](/docs/Cloudant?topic=Cloudant-locating-your-service-credentials) for the service.

You can use Classic credentials:

```python
serviceUsername = "353466e8-47eb-45ce-b125-4a4e1b5a4f7e-bluemix"
servicePassword = "49c0c343d225623956157d94b25d574586f26d1211e8e589646b4713d5de4801"
serviceURL = "https://353466e8-47eb-45ce-b125-4a4e1b5a4f7e-bluemix.cloudant.com"
```
{: codeblock}

Or you can connect to your {{site.data.keyword.cloudant_short_notm}} account by using an IAM API key:

```json
client = Cloudant.iam(ACCOUNT_NAME, API_KEY, connect=True)
```
{: codeblock}

Copy `username` from your service credentials, and replace the `ACCOUNT_NAME` in the previous example. For more information about finding the service credentials for your service instance, see [Locating your service credentials](/docs/Cloudant?topic=Cloudant-locating-your-service-credentials).

The service credentials that are illustrated
    were defined when a demonstration {{site.data.keyword.cloudant_short_notm}} service was created on {{site.data.keyword.cloud_notm}}.
    The credentials are reproduced here to show how they would be used in a Python application.
    However,
    the demonstration {{site.data.keyword.cloudant_short_notm}} service was removed,
    so these credentials no longer work;
    you *must* supply and use your own service credentials.
{:  tip}

Once you enable the Python client library within your application,
and identified the service credentials,
you can establish a connection to the service instance:

```python
client = Cloudant(serviceUsername, servicePassword, url=serviceURL)
client.connect()
```
{: codeblock}

Now, your Python application can access the service instance on {{site.data.keyword.cloud_notm}}.

## Creating a database within the service instance
{: #creating-a-database-within-the-service-instance}

The next step is to create a database within the service instance,
called `databasedemo`.

We create this instance by defining a variable in the Python application:

```python
databaseName = "databasedemo"
```
{: codeblock}

We then create the database:

```python
myDatabaseDemo = client.create_database(databaseName)
```
{: codeblock}

It's helpful to check that the database was created successfully:

```python
if myDatabaseDemo.exists():
    print("'{0}' successfully created.\n".format(databaseName))
```
{: codeblock}

## Storing a small collection of data as documents within the database
{: #storing-a-small-collection-of-data-as-documents-within-the-database}

We now want to store a small,
simple collection of data in the database.

We start by identifying some data:

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

Next,
some ordinary Python code 'steps' through the data,
converting it into JSON documents.
Each document is stored in the database:

```python
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
    newDocument = myDatabaseDemo.create_document(jsonDocument)

    # Check that the document exists in the database.
    if newDocument.exists():
        print("Document '{0}' successfully created.".format(number))
```
{: codeblock}

Notice that we check that each document was successfully created.

## Retrieving data
{: #retrieving-data}

A small collection of data
is stored as documents within the database.
We can now perform a series of queries,
illustrating different ways of retrieving data from the database.

### A minimal retrieval of a document
{: #a-minimal-retrieval-of-a-document}

To perform a minimal retrieval,
we first request a list of all documents within the database.
This list is returned as an array.
We can then show the content of an element in the array.

In the sample code,
we request the first document that is retrieved from the database:

```python
result_collection = Result(myDatabaseDemo.all_docs)
print("Retrieved minimal document:\n{0}\n".format(result_collection[0]))
```
{: codeblock}

The result is similar to the following example:

```json
[
    {
        "value": {
            "rev": "1-b2c48b89f48f1dc172d4db3f17ff6b9a"
        },
        "id": "14746fe384c7e2f06f7295403df89187",
        "key": "14746fe384c7e2f06f7295403df89187"
    }
]
```
{: codeblock}

In a relational database, there is a simple notion that the first document stored in a database is always the first document returned in a list of results. This notion doesn't necessarily apply to NoSQL databases, such as {{site.data.keyword.cloudant_short_notm}}.
{: tip}

### Full retrieval of a document
{: #full-retrieval-of-a-document}

Additionally, to perform a full retrieval,
we request a list of all documents within the database,
and specify that the document content must also be returned.
We run a full retrieval by using the `include_docs` option.
As before,
the results are returned as an array.
We can then show the details of an element in the array
by including the full content of the document this time. 

As before,
we request the first document that is retrieved from the database:

```python
result_collection = Result(myDatabaseDemo.all_docs, include_docs=True)
print("Retrieved minimal document:\n{0}\n".format(result_collection[0]))
```
{: codeblock}

The result is similar to the following example:

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
            "numberField": 4,
            "nameField": "four",
            "_id": "14746fe384c7e2f06f7295403df89187",
            "_rev": "1-b2c48b89f48f1dc172d4db3f17ff6b9a"
        }
    }
]
```
{: codeblock}

## Calling an {{site.data.keyword.cloudant_short_notm}} API endpoint directly
{: #calling-an-ibm-cloudant-api-endpoint-directly}

We can also work with the {{site.data.keyword.cloudant_short_notm}} API endpoints directly,
from within a Python application.

In this example code,
we again request a list of all the documents,
including their content.
However, this time we do so by invoking the {{site.data.keyword.cloudant_short_notm}} [`/_all_docs` endpoint](/docs/Cloudant?topic=Cloudant-databases#get-documents).

First,
we identify the endpoint to contact,
and any parameters to supply along with the call:

```python
end_point = '{0}/{1}'.format(serviceURL, databaseName + "/_all_docs")
params = {'include_docs': 'true'}
```
{: codeblock}

Next,
we send the request to the service instance,
and then display the results:

```python
response = client.r_session.get(end_point, params=params)
print("{0}\n".format(response.json()))
```
{: codeblock}

The result is similar to the following *abbreviated* example:

```json
{
    "rows": [
        {
            "value": {
              "rev": "1-b2c48b89f48f1dc172d4db3f17ff6b9a"
            },
            "id": "14746fe384c7e2f06f7295403df89187",
            "key": "14746fe384c7e2f06f7295403df89187",
            "doc": {
                "temperatureField": 10,
                "descriptionField": "cold",
                "numberField": 4,
                "nameField": "four",
                "_id": "14746fe384c7e2f06f7295403df89187",
                "_rev": "1-b2c48b89f48f1dc172d4db3f17ff6b9a"
            }
        },
        ...
        {
            "value":
            {
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

When we finish with the database,
it can be deleted.

This step is shown in the following sample Python code:

```python
try :
    client.delete_database(databaseName)
except CloudantException:
    print("There was a problem deleting '{0}'.\n".format(databaseName))
else:
    print("'{0}' successfully deleted.\n".format(databaseName))
```
{: codeblock}

We include some basic error handling to illustrate how problems
might be caught and addressed.

## Closing the connection to the service instance
{: #closing-the-connection-to-the-service-instance}

The final step is to disconnect the Python client application from the service instance:

```python
client.disconnect()
```
{: codeblock}

## Complete listing
{: #complete-listing}

The following code is a complete Python program to access an {{site.data.keyword.cloudant_short_notm}} service instance on {{site.data.keyword.cloud_notm}},
and perform a typical series of tasks:

1.  Connecting to the service instance.
2.  Creating a database within the service instance.
3.  Storing a small collection of data as documents within the database.
4.  Retrieving a complete list of the documents.
5.  Deleting the database.
6.  Closing the connection to the service instance.

```python
# 1.  Connecting to the service instance.

# Enable the required Python libraries.

from cloudant.client import Cloudant
from cloudant.error import CloudantException
from cloudant.result import Result, ResultByKey

# Useful variables
serviceUsername = "353466e8-47eb-45ce-b125-4a4e1b5a4f7e-bluemix"
servicePassword = "49c0c343d225623956157d94b25d574586f26d1211e8e589646b4713d5de4801"
serviceURL = "https://353466e8-47eb-45ce-b125-4a4e1b5a4f7e-bluemix.cloudant.com"

# This is the name of the database we are working with.
databaseName = "databasedemo"

# This is a simple collection of data,
# to store within the database.
sampleData = [
    [1, "one", "boiling", 100],
    [2, "two", "hot", 40],
    [3, "three", "warm", 20],
    [4, "four", "cold", 10],
    [5, "five", "freezing", 0]
]

# Start the demo.
print("===\n")

# Use the {{site.data.keyword.cloudant_short_notm}} library to create an {{site.data.keyword.cloudant_short_notm}} client.
client = Cloudant(serviceUsername, servicePassword, url=serviceURL)

# Connect to the server
client.connect()

# 2.  Creating a database within the service instance.

# Create an instance of the database.
myDatabaseDemo = client.create_database(databaseName)

# Check that the database now exists.
if myDatabaseDemo.exists():
    print("'{0}' successfully created.\n".format(databaseName))

# Space out the results.
print("----\n")

# 3.  Storing a small collection of data as documents within the database.

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
    newDocument = myDatabaseDemo.create_document(jsonDocument)

    # Check that the document exists in the database.
    if newDocument.exists():
        print("Document '{0}' successfully created.".format(number))

# Space out the results.
print("----\n")

# 4.  Retrieving a complete list of the documents.

# Simple and minimal retrieval of the first
# document in the database.
result_collection = Result(myDatabaseDemo.all_docs)
print("Retrieved minimal document:\n{0}\n".format(result_collection[0]))

# Simple and full retrieval of the first
# document in the database.
result_collection = Result(myDatabaseDemo.all_docs, include_docs=True)
print("Retrieved full document:\n{0}\n".format(result_collection[0]))

# Space out the results.
print("----\n")

# Use an {{site.data.keyword.cloudant_short_notm}} API endpoint to retrieve
# all the documents in the database,
# including their content.

# Define the end point and parameters
end_point = '{0}/{1}'.format(serviceURL, databaseName + "/_all_docs")
params = {'include_docs': 'true'}

# Issue the request
response = client.r_session.get(end_point, params=params)

# Display the response content
print("{0}\n".format(response.json()))

# Space out the results.
print("----\n")

# All done.
# Time to tidy up.

# 5.  Deleting the database.

# Delete the test database.
try :
    client.delete_database(databaseName)
except CloudantException:
    print("There was a problem deleting '{0}'.\n".format(databaseName))
else:
    print("'{0}' successfully deleted.\n".format(databaseName))

# 6.  Closing the connection to the service instance.

# Disconnect from the server
client.disconnect()

# Finish the demo.
print("===\n")

# Say good-bye.
exit()
```
{: codeblock}
