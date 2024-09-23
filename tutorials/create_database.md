---

copyright:
  years: 2017, 2024
lastupdated: "2024-09-23"

keywords: delete database, request ibm cloudant api endpoint, data retrieval, store data, create database, connect to ibm cloudant

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
create an {{site.data.keyword.cloudantfull}} database in your {{site.data.keyword.cloud_notm}} service instance.
You also learn how to populate the database with a simple collection of data.
{: shortdesc}

This tutorial doesn't use the most efficient Python code. The intent is to show simple and easy-to-understand working code
that you can learn from and apply to your own applications. You must apply normal best practices for checking and handling all
warning or error conditions in your own applications.
{: note}

## Objectives
{: #objectives-db}

This tutorial provides a series of Python language instructions,
suitable for the following tasks:

1.  Connecting to an {{site.data.keyword.cloudant_short_notm}} service instance on {{site.data.keyword.cloud}}.
2.  Creating a database within the service instance.
3.  Storing a small collection of data as documents within the database.
4.  Retrieving data.
5.  Deleting the database.

## Before you begin
{: #before-you-begin}

### Prepare an {{site.data.keyword.cloudant_short_notm}} service instance
{: #prepare-service-instance}

1. Set up service credential requirements.

    a. Create a service instance and credentials by following the [Getting started](/docs/Cloudant?topic=Cloudant-getting-started-with-cloudant) tutorial.

    b. Obtain your credentials by following the [Locate your service credentials](/docs/Cloudant?topic=Cloudant-locating-your-service-credentials#locating-your-service-credentials) tutorial.

    The tutorial uses the IAM credentials type for authentication.
    {: tip}

### Install Python and prepare the environment
{: #installing-python}

1. Install the required version of Python.

    You must have a current version of the [Python programming language](https://www.python.org/){: external} installed on your system.
    {: note}

    a. Run the following command at a prompt to check that Python is installed:

    ```sh
    python3 --version
    ```
    {: pre}

    b. Verify that you get a result similar to the following example:

    ```sh
    Python 3.12.5
    ```
    {: screen}

2. Create and activate a virtual environment

    a. Create the virtual environment:

    ```sh
    python3 -m venv cloudantdemo
    ```
    {: pre}

    This creates a sub-directory called `cloudantdemo` in the present working directory.
    You can choose another path.
    {: tip}

    b. Activate the virtual environment:

    ```sh
    source cloudantdemo/bin/activate
    ```
    {: pre}

    For more information about Python virtual environments and instructions for alternative
    operating systems see the Python standard library [venv documentation](https://docs.python.org/3/library/venv.html){: external}.
    {: tip}

3. Install the {{site.data.keyword.cloudant_short_notm}} SDK for Python

    ```sh
    pip install ibmcloudant
    ```
    {: pre}

4. Verify the {{site.data.keyword.cloudant_short_notm}} SDK for Python installation. 

    a. Check that the client library installed successfully by running the following command at a prompt:

    ```sh
    pip show ibmcloudant
    ```
    {: pre}

    You get output with information about the `ibmcloudant` package.

    b. Inspect the output, which should start with lines similar to the following example:

    ```text
    Name: ibmcloudant
    Version: 0.9.1
    ```
    {: screen}

5. Start the interactive Python interpreter

    a. Run the `python` command in the virtual environment to launch the interpreter
    ```sh
    python
    ```
    {: pre}

    b. Verify that you get output similar to the following example:
    ```text
    Python 3.12.5
    Type "help", "copyright", "credits" or "license" for more information.
    >>> 
    ```
    {: screen}

    Normally, you don't run commands individually in Python. You usually
    create a script, which is a list of the commands you want to run,
    stored in a Python file, with a `.py` extension.
    {: tip}

## Connecting to a service instance
{: #connecting-to-an-ibm-cloudant-service-instance-on-ibm-cloud}
{: step}

1. Run these `import` statements to load the necessary SDK classes.

    ```python
    from ibmcloudant.cloudant_v1 import CloudantV1
    from ibm_cloud_sdk_core import ApiException
    from ibm_cloud_sdk_core.authenticators import IAMAuthenticator
    ```
    {: codeblock}

2. Find `host` and `apikey` in your service credentials and replace the values in `service_host` and `service_api_key` in the following example.

    ```python
    service_host = '{host}'
    service_api_key = '{apikey}'
    ```
    {: codeblock}

    Don't store your credentials in source code files.
    For real applications consider configuring your client from the environment.
    {: tip}

3. Create a client configured with the service instance details.

    ```python
    client = CloudantV1(IAMAuthenticator(service_api_key))
    client.set_service_url(f'https://{service_host}')
    ```
    {: codeblock}

    Here `https://` is prefixed to the host to make the service URL.
    Alternatively use the `url` from the service credentials, but if your instance is not IAM only
    be sure to remove the user information after the protocol and before the hostname.
    {: tip}

4. Get the server information with the [`get_server_information` API](/apidocs/cloudant?code=python#getserverinformation) to validate the connection.

    ```python
    client.get_server_information().get_result()
    ```
    {: codeblock}

    Validate the output is similar to the following example:

    ```python
    {'couchdb': 'Welcome', 'version': '3.3.3+cloudant', 'vendor': {'name': 'IBM Cloudant', 'version': '8521', 'variant': 'paas'}, 'features': ['search', 'access-ready', 'iam', 'partitioned', 'pluggable-storage-engines', 'scheduler'], 'features_flags': ['partitioned']}
    ```
    {: screen}

Now, your Python application can access the service instance on {{site.data.keyword.cloud_notm}}.

## Creating a database within the service instance
{: #creating-a-database-within-the-service-instance}
{: step}

Next, you create a database within the service instance,
called `databasedemo`.

1. Define the database name with a variable in the Python application.

    ```python
    database_name = 'databasedemo'
    ```
    {: codeblock}

2. Create the database using the [`put_database` API](/apidocs/cloudant?code=python#putdatabase).

    ```python
    client.put_database(db=database_name).get_result()
    ```
    {: codeblock}

    Validate the database was created successfully with output:
    ```python
    {'ok': True}
    ```
    {: screen}

## Storing a small collection of data as documents within the database
{: #storing-a-small-collection-of-data-as-documents-within-the-database}
{: step}

You want to store a small,
simple collection of data in the database. Use these data in other tutorials, like [Using {{site.data.keyword.cloudant_short_notm}} Query to find data](/docs/Cloudant?topic=Cloudant-creating-an-ibm-cloudant-query).

1. Create sample data.

    ```python
    sample_data = [
        [1, 'one', 'boiling', 100],
        [2, 'two', 'hot', 40],
        [3, 'three', 'hot', 75],
        [4, 'four', 'hot', 97],
        [5, 'five', 'warm', 20],
        [6, 'six', 'cold', 10],
        [7, 'seven', 'freezing', 0],
        [8, 'eight', 'freezing', -5]
    ]
    ```
    {: codeblock}

2. Initialize a list of documents.

    ```python
    sample_docs = []
    ```
    {: codeblock}

3. Iterate the sample data to make document data

    For each row of the `sample_data` list create a dictionary mapping field names
    to the values from the row elements. Append each dictionary to the `sample_docs` list.

    ```python
    for row in sample_data:
        # Make a dictionary for each row
        document = {
            'numberField': row[0],
            'nameField': row[1],
            'descriptionField': row[2],
            'temperatureField': row[3]
        }
        # Append the dictionary to the list of documents
        sample_docs.append(document)
    ```
    {: codeblock}

    Python dictionaries are suitable for making JSON documents.
    {: tip}

4. Create documents using the [`post_document` API](/apidocs/cloudant?code=python#postdocument).

    ```python
    for doc in sample_docs:
        client.post_document(db=database_name, document=doc).get_result()
    ```
    {: codeblock}

    This use of the `post_document` API automatically generates document IDs on the server.
    Alternatively include an ID in the document body or use the `put_document` API
    to choose a specific document ID.
    {: tip}

    For creating or modifying large numbers of documents in a single request there is a
    [`post_bulk_docs` API](/apidocs/cloudant?code=python#postbulkdocs).
    {: tip}

    Validate that the output is similar to the following example.
    ```python
    {'ok': True, 'id': '43bb97b841c5b16c5ee44f4768e42efa', 'rev': '1-f998fc7b89d4466c1e7bb204b1b00f74'}
    {'ok': True, 'id': '480d1073dca0bf7bc9f28c2ad2f1383e', 'rev': '1-08b940a61ee2f4a013ba8f4abb307c70'}
    {'ok': True, 'id': '06266c9793afac3b5740872bc0f83d52', 'rev': '1-7de3d45186982b76243ce5879ccdbef4'}
    {'ok': True, 'id': '40867bf98071981da37d266d23b681ca', 'rev': '1-60206efd94ac6434740acd53c4278646'}
    {'ok': True, 'id': '622a70b1e0e9a0311284cd8bf5c439db', 'rev': '1-6d98db97adc12d2e4b114f96d2383a2d'}
    {'ok': True, 'id': '8c07fdbbf67d5173adc3b3034cd9202c', 'rev': '1-d97d8d0b6928bc743ccbe12b0621ad58'}
    {'ok': True, 'id': '4afb0c4e8d0c96d729dbf7081cbbe84c', 'rev': '1-462c5395df71106d903bedd29970ddeb'}
    {'ok': True, 'id': '33376a6ea0644abeef5462ff394755ef', 'rev': '1-523c33f6c5f82a2ae51a8df6366ee92b'}
    ```
    {: screen}

## Retrieving data
{: #retrieving-data}
{: step}

1. Retrieve a list of documents in the database using the [`post_all_docs` API](/apidocs/cloudant?code=python#postalldocs).

    ```python
    all_docs_result = client.post_all_docs(db=database_name).get_result()
    ```
    {: codeblock}

2. Iterate the returned rows to view document metadata.

    ```python
    for row in all_docs_result['rows']:
        print(row['id'])
    ```
    {: codeblock}

    Validate that the output is similar to the following example.
    ```text
    43bb97b841c5b16c5ee44f4768e42efa
    480d1073dca0bf7bc9f28c2ad2f1383e
    06266c9793afac3b5740872bc0f83d52
    40867bf98071981da37d266d23b681ca
    622a70b1e0e9a0311284cd8bf5c439db
    8c07fdbbf67d5173adc3b3034cd9202c
    4afb0c4e8d0c96d729dbf7081cbbe84c
    33376a6ea0644abeef5462ff394755ef
    ```
    {: screen}

    These IDs will match those from the previous creation step.
    {: tip}

In a relational database, the first document stored in a database is always the first document returned in a list of results. 
This notion doesn't necessarily apply to document-oriented databases, such as {{site.data.keyword.cloudant_short_notm}}.

### Full retrieval of a document
{: #full-retrieval-of-a-document}
{: step}

1. Get the ID of the first document in the database.

    ```python
    first_doc_id = all_docs_result['rows'][0]['id']
    ```
    {: codeblock}

    This uses the ID from listing the documents previously.
    You can also store the ID from the response after creating the document.
    {: tip}

2. Retrieve the document content using the [`get_document` API](/apidocs/cloudant?code=python#getdocument).

    ```python
    client.get_document(db=database_name, doc_id=first_doc_id).get_result()
    ```
    {: codeblock}

    Validate that the output is similar to the following example.
    ```python
    {'_id': '43bb97b841c5b16c5ee44f4768e42efa', '_rev': '1-f998fc7b89d4466c1e7bb204b1b00f74', 'numberField': 1, 'nameField': 'one', 'descriptionField': 'boiling', 'temperatureField': 100}
    ```
    {: screen}

## Deleting the database
{: #deleting-the-database}
{: step}

1. Delete the database using the [`delete_database` API](/apidocs/cloudant?code=python#deletedatabase).

    ```python
    try:
        client.delete_database(db=database_name).get_result()
    except ApiException as ae:
        print(f'There was a problem deleting database {database_name}. HTTP status code {ae.status_code}. Error message {ae.message}.')
    ```
    {: codeblock}

    Validate the database was deleted successfully with output:
    ```python
    {'ok': True}
    ```
    {: screen}

2. Review the basic error handling demonstrating one way to handle problems.

## Finishing up
{: #finishing-up}
{: step}

1. End the interactive Python interpreter session by issuing an `EOF` for example with `Ctrl+D`.
2. Optionally deactivate and delete the Python virtual environment.

    a. Deactivate the virtual environment
    
    ```python
    deactivate
    ```
    {: pre}

    b. Delete the virtual environment.

    ```python
    rm -r cloudantdemo
    ```
    {: pre}
