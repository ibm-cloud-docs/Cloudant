---

copyright:
  years: 2015, 2017
lastupdated: "2017-11-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

# Data Warehousing

A database is essential for storing data.
But being able to apply that data for business purposes is what makes a database valuable:
being able to retrieve relevant data,
quickly and easily,
and putting the data to work within your applications.
{:shortdesc}

But many of the storage,
processing,
and analytics tasks you perform with the data are used again and again in your applications.
Or they might be good examples of industry best practices.

So,
it makes sense to extend standard database capabilities with additional features,
supporting tasks such as reporting,
or analytics.

For nearly 30 years,
'Data Warehouses' have been the industry standard for data storage,
reporting,
and analytics,
based on relational database technology.
In general,
a [data warehouse is ![External link icon](../images/launch-glyph.svg "External link icon")](https://en.wikipedia.org/wiki/Data_warehouse){:new_window}:
"... a central repository of integrated data from one or more sources.
It stores current and historical data.
It can be used for performing analysis and creating reports for knowledge workers throughout the enterprise."

The technologies that enable data storage,
reporting,
and analytics have emerged in recent years as a response to the need
to process '[Big Data ![External link icon](../images/launch-glyph.svg "External link icon")](https://en.wikipedia.org/wiki/Big_data){:new_window}':
"Big data is a term for data sets that are so large or complex
that traditional data processing applications are inadequate."

At the same time,
the properties and characteristics of Data Warehouses and related products mean that
using relational database technology to enable the Data Warehouses is a popular choice,
even for big data tasks.

There are many use cases that nicely illustrate the benefits of
integrating {{site.data.keyword.cloudantfull}} capabilities with a relational data warehouse,
such as the following examples.

## Joining data

Joining data from multiple data stores for cross-domain analysis
is a task that can be performed easily and efficiently using a relational data warehouse.

Data from different sources is prepared and transformed to a common format during the load of a data warehouse.
Records are stored in tables,
and operations are available to join those tables to enable combined analysis.

Doing the join in a relational data warehouse is especially useful
if some of the data is already available in relational representation,
for example master data or reference data.

## Flexibility

{{site.data.keyword.cloudant_short_notm}} databases are flexible at representing data.
For example,
they do not enforce a schema during read or write.

By contrast,
a well-defined and rigorously enforced model is required for reporting and analytics tasks.

With your documents available in a relational warehouse you can base your model on a fixed set of table definitions.
Only documents that fit the table schema can get loaded while violations are rejected.
You can train your models with consistent data using a fixed relational schema.

## Data integrity assertion

Data Warehouses can use constraints to assert data integrity.
For example:

-   No two records can have the same primary key.
-   Foreign keys guarantee that records are complete.
-   Functions are available to validate records against business rules.

Uniqueness,
correctness,
and completeness are essential requirements for any enterprise service.
Loading your {{site.data.keyword.cloudant_short_notm}} documents into a data warehouse helps you meet these requirements.

## {{site.data.keyword.cloudant_short_notm}} and Data Warehousing

Data Warehouses are a mature and important technology.
{{site.data.keyword.cloudant_short_notm}} provides a tight integration with relational data warehouses,
giving you the benefit of this technology.

{{site.data.keyword.cloudant_short_notm}} has a basic warehousing capability built in,
in the form of [MapReduce views](../api/using_views.html)
that enable you to perform a range of basic analytical tasks.

For more advanced warehousing tasks,
you can leverage the full capabilities provided by the
IBM cloud-based warehousing service [{{site.data.keyword.IBM}} Db2 Warehouse on Cloud ![External link icon](../images/launch-glyph.svg "External link icon")](https://www.ibm.com/analytics/us/en/data-management/data-warehouse/){:new_window}.

When you use {{site.data.keyword.cloudant_short_notm}},
you have integrated and easy access to advanced warehousing capabilities,
such as:

-   Seeing your JSON data in a relational database format.
-   Performing SQL-based queries on your data.
-   Building analytics from your data.

These advanced warehousing capabilities are enabled through services such as Db2 Warehouse on Cloud,
which is a natural complement to {{site.data.keyword.cloudant_short_notm}}.

Alternatively,
if you only need a relational data store for your documents,
without the warehousing capabilities,
you can load your {{site.data.keyword.cloudant_short_notm}} documents into the [IBM DB2 on Cloud](#ibm-db2-on-cloud) service.

## IBM Db2 Warehouse on Cloud

Db2 Warehouse on Cloud is a cloud-based data warehouse service,
purpose-built for analytic work.
While especially suited for {{site.data.keyword.cloudant_short_notm}} JSON data,
Db2 Warehouse on Cloud can accept data from a variety of sources by
examining the structure of data when it is loaded.

For more information,
see the [IBM Db2 Warehouse on Cloud documentation ![External link icon](../images/launch-glyph.svg "External link icon")](https://www.ibm.com/support/knowledgecenter/SS6NHC/com.ibm.swg.im.dashdb.kc.doc/welcome.html){:new_window}.

## DB2 Hosted

[{{site.data.keyword.DB2OnCloud_full}} ![External link icon](../images/launch-glyph.svg "External link icon")](https://console.ng.bluemix.net/catalog/services/ibm-db2-on-cloud){:new_window}
provides you with a database on IBM's SoftLayer® global cloud infrastructure.
It offers you the rich features of an on-premise DB2 deployment,
but without the cost,
complexity,
and risk of managing your own infrastructure.

For more information, see the [{{site.data.keyword.DB2OnCloud_short}} documentation ![External link icon](../images/launch-glyph.svg "External link icon")](https://console.ng.bluemix.net/docs/services/DB2OnCloud/index.html#DB2OnCloud){:new_window}.

## Creating a warehouse

There are two ways you can create a warehouse:

1.  [Use {{site.data.keyword.cloudant_short_notm}} to create a Db2 Warehouse on Cloud warehouse](#use-cloudant-to-create-a-db2-warehouse-on-cloud-warehouse)
2.  [Connect {{site.data.keyword.cloudant_short_notm}} to an existing warehouse](#connect-cloudant-to-an-existing-warehouse)

### Use {{site.data.keyword.cloudant_short_notm}} to create a Db2 Warehouse on Cloud warehouse

The simplest method for creating a warehouse is for {{site.data.keyword.cloudant_short_notm}} to create a Db2 Warehouse on Cloud warehouse instance within {{site.data.keyword.Bluemix}},
on your behalf.
Do this by clicking the `Create Warehouse` button on the `Warehouse` task
within the `Integrations` tab of your {{site.data.keyword.cloudant_short_notm}} dashboard.

![Screenshot of the "Create a Db2 Warehouse on Cloud warehouse" task within the {{site.data.keyword.cloudant_short_notm}} dashboard](../images/createDashDBWH.png)

If you are not already logged in to {{site.data.keyword.Bluemix_notm}},
you are asked to do so.

>   **Note**: By default, {{site.data.keyword.cloudant_short_notm}} creates a Db2 Warehouse on Cloud instance on {{site.data.keyword.Bluemix_notm}} for your warehouse.

![Screenshot of the "Authenticate to {{site.data.keyword.Bluemix_notm}}" task within the {{site.data.keyword.cloudant_short_notm}} dashboard](../images/authenticateToBluemix.png)

When you have authenticated,
you can request that a new Db2 Warehouse on Cloud instance is created using your {{site.data.keyword.Bluemix_notm}} account.

To do this:

1.  Provide the name you would like to use for the Warehouse in the `Warehouse Name` field.
2.  Provide the name of your existing database within {{site.data.keyword.cloudant_short_notm}}, in the `Data Sources` field.
3.  Ensure that the `Create new Db2 Warehouse on Cloud instance` option is selected on the form.
4.  Click the `Create Warehouse` button.

![Screenshot of the "Create Warehouse" task within the {{site.data.keyword.cloudant_short_notm}} dashboard](../images/createWarehouse.png)

### Connect {{site.data.keyword.cloudant_short_notm}} to an existing warehouse

Instead of using {{site.data.keyword.cloudant_short_notm}} to create the Db2 Warehouse on Cloud warehouse database,
you can connect to an existing Db2 Warehouse on Cloud instance.

The process is similar to [using {{site.data.keyword.cloudant_short_notm}} to create a Db2 Warehouse on Cloud warehouse](#use-cloudant-to-create-a-db2-warehouse-on-cloud-warehouse),
however instead of selecting the `Create new Db2 Warehouse on Cloud instance` option,
select the `Db2 Warehouse on Cloud service instance` and choose the Db2 Warehouse on Cloud warehouse that already exists within {{site.data.keyword.Bluemix_notm}}.

![Screenshot of the "Connect to existing Db2 Warehouse on Cloud instance" task within the {{site.data.keyword.cloudant_short_notm}} dashboard](../images/existingDashDBInstance.png)

### Using a DB2 warehouse instance

If you prefer,
you can connect to an existing DB2 warehouse instance instead of Db2 Warehouse on Cloud.
Do this by selecting the `DB2` option within your {{site.data.keyword.cloudant_short_notm}} dashboard to connect to an existing DB2 instance.

![Screenshot of the Create a DB2 warehouse" task within the {{site.data.keyword.cloudant_short_notm}} dashboard](../images/createDB2WH.png)

If you want to connect to a DB2 instance,
you must provide the following details:

-   Host address
-   Port number
-   Database name
-   User ID for the database
-   Password for the User ID

>   **Note**: The remainder of this topic refers to Db2 Warehouse on Cloud as the warehouse instance.
    However,
    the topic applies equally if you are using an instance of DB2.
    A tutorial is also available describing how to
    [load JSON data from {{site.data.keyword.cloudant_short_notm}} into Db2 Warehouse on Cloud ![External link icon](../images/launch-glyph.svg "External link icon")](https://developer.ibm.com/clouddataservices../dashdb/get/load-json-from-cloudant-database-in-to-dashdb/){:new_window},
    and includes examples of using DB2 as the warehouse database.

## Warehouse schema

When you first create a warehouse from within {{site.data.keyword.cloudant_short_notm}},
Db2 Warehouse on Cloud creates the best possible schema for the data within the database,
helping ensure that each of the fields within your JSON documents has a corresponding entry within the new schema.
Optionally,
when creating the warehouse,
you can choose to [customize the schema](#customizing-the-warehouse-schema) manually.

Once the schema is created,
the warehouse is able to hold your data in a relational format.
{{site.data.keyword.cloudant_short_notm}} then [replicates](../api/replication.html) to perform
an 'initial load' of the database documents into the warehouse,
giving you a working collection of your data in the Db2 Warehouse on Cloud relational database.

Over time,
your {{site.data.keyword.cloudant_short_notm}} database content might change.
You can modify the schema of an existing warehouse.

>   **Note**: If you modify the schema of an existing warehouse,
    the data from your {{site.data.keyword.cloudant_short_notm}} database must be replicated again into the warehouse database.
    In effect,
    modifying the schema causes a fresh 'initial load' into the warehouse.

## Working with your warehouse

With {{site.data.keyword.cloudant_short_notm}} warehousing,
you can run 'traditional' SQL queries,
and view the results,
all from within the Db2 Warehouse on Cloud console.


![Screenshot of the "Db2 Warehouse on Cloud dashboard" within {{site.data.keyword.Bluemix_notm}}](../images/useDashDBdashboard.png)

External applications can interact with the data in the same way as with any other relational database.
The advantage of Db2 Warehouse on Cloud is that you can perform other warehousing tasks,
such as loading more data from other sources,
and analyzing the data using built-in analytic tools.
Db2 Warehouse on Cloud supports the
[`'R'` programming language ![External link icon](../images/launch-glyph.svg "External link icon")](https://en.wikipedia.org/wiki/R_%28programming_language%29){:new_window}
and software environment for statistical computing and graphics.
This means you have access to algorithms that let you perform database analytic tasks such as linear regression,
'k-means' clustering,
and geospatial analysis.

The `RStudio` tool allows you to create `'R'` scripts which are then uploaded into Db2 Warehouse on Cloud,
then run using your data.

For more information about working with Db2 Warehouse on Cloud,
see the [IBM Db2 Warehouse on Cloud documentation ![External link icon](../images/launch-glyph.svg "External link icon")](https://www.ibm.com/support/knowledgecenter/SS6NHC/com.ibm.swg.im.dashdb.kc.doc/welcome.html){:new_window}.

## Keeping the data and structure fresh

Data is loaded from {{site.data.keyword.cloudant_short_notm}} into Db2 Warehouse on Cloud using a [replication](../api/replication.html) process.
This means that if your {{site.data.keyword.cloudant_short_notm}} data is updated or modified in some way,
replication of the documents into Db2 Warehouse on Cloud must take place again
to ensure your analytic tasks continue to work using the most up-to-date information.

As with normal {{site.data.keyword.cloudant_short_notm}} replication,
data is transferred one-way only:
for a warehouse the transfer is from {{site.data.keyword.cloudant_short_notm}} to Db2 Warehouse on Cloud.
After the initial load of data,
the warehouse subscribes to data content changes in the {{site.data.keyword.cloudant_short_notm}} database.
Any changes are replicated from the {{site.data.keyword.cloudant_short_notm}} source to the Db2 Warehouse on Cloud target.
This means that warehousing is a form of continuous replication from {{site.data.keyword.cloudant_short_notm}} to Db2 Warehouse on Cloud.

Over time,
your {{site.data.keyword.cloudant_short_notm}} database might also have structural changes.
This might include the addition or removal of fields from the JSON documents.
When this happens,
the schema used by the warehouse might become invalid,
resulting in errors reported when fresh data is replicated from {{site.data.keyword.cloudant_short_notm}} to Db2 Warehouse on Cloud.

To solve this problem,
{{site.data.keyword.cloudant_short_notm}} warehousing has a 'rescan' facility.
This rescans the structure of the {{site.data.keyword.cloudant_short_notm}} database,
and determines the new schema required in Db2 Warehouse on Cloud.
The old tables within Db2 Warehouse on Cloud that were created during the previous scan are then dropped,
new tables created using the new schema,
and finally the current {{site.data.keyword.cloudant_short_notm}} data is loaded as a fresh 'initial load'.

To use the rescan facility,
first ensure that your warehouse is not running.
Do this as follows:

1.  Select the `Integrations` tab within the {{site.data.keyword.cloudant_short_notm}} dashboard.
2.  Find the name of the Warehouse you want to rescan on the `Warehouse` task:<br/>![Screenshot of the "warehouse" tab within the {{site.data.keyword.cloudant_short_notm}} dashboard](../images/selectWarehouse.png)
3.  Click on the name of the Warehouse.
    It is a link,
    and when clicked it opens the warehouse detail view:<br/>![Screenshot of the detailed warehouse view within the {{site.data.keyword.cloudant_short_notm}} dashboard](../images/viewWarehouseDetail.png)
4.  Check the current status of the warehouse.
    A rotating green circle indicates that the warehouse is running.
    To stop the warehouse,
    click the `Stop Database` icon in the Actions column:<br/>![Screenshot of the "stop warehouse database" icon within the {{site.data.keyword.cloudant_short_notm}} dashboard](../images/stopWarehouseDatabase.png)
5.  When the warehouse database is not running,
    the `Rescan` icon in the Action column is enabled:<br/>![Screenshot of the rescan icon within the {{site.data.keyword.cloudant_short_notm}} dashboard](../images/rescanIcon.png)

### Rescanning the source database

![Screenshot of the window enabling you to rescan the warehouse source database.](../images/rescanSource.png)

When you click the `Rescan` icon,
you have two choices:

-   A straightforward scan of your database.
    This is the default action,
    and is very similar to the initial scan of your database performed when the warehouse was first created.
-   Customize the warehouse schema.

If you choose the default action of a simple rescan,
your source database is inspected and a fresh warehouse database schema is generated.
As soon as the rescan completes,
the warehouse is started.

If you want to customize the warehouse schema,
enable the `Customize Schema` checkbox,
before clicking the `Rescan` button.

![Screen shot of 'Rescan Source' panel, showing the 'Customize Schema' option enabled.](../images/rescanSource2.png)

The `Customize Schema` checkbox enables two options.

1.  The discovery algorithm used.
2.  The sample size.

### The discovery algorithm

The default option for rescanning is the `Union` algorithm.
This uses all the attributes in all the sampled {{site.data.keyword.cloudant_short_notm}} database documents
to create a single set of tables in the warehouse database.
The result is that all the {{site.data.keyword.cloudant_short_notm}} database documents can be stored in the warehouse database,
but some rows in the database might not have content in some of the fields.

The alternative option for rescanning is the `Cluster` algorithm.
This identifies documents within the {{site.data.keyword.cloudant_short_notm}} database that have the same set of attributes,
then creates corresponding warehouse database table schemas.

### The sample size

This option determines how many documents within the {{site.data.keyword.cloudant_short_notm}} database
are inspected as part of the schema determination.

The default value is 10,000 documents.

Setting the value too low introduces the risk that some {{site.data.keyword.cloudant_short_notm}} documents have attributes that are not detected,
and are therefore omitted from the warehouse database structure.

Setting the value too high means that the scanning process
to determine the warehouse database structure takes longer to complete.

### After the rescan

Once the {{site.data.keyword.cloudant_short_notm}} database rescan has finished,
the warehouse is not automatically started.
Instead,
it remains in a halted state,
so that the warehouse database can be customized.

## Customizing the warehouse schema

It is possible to modify the database schema that is determined automatically
during the initial warehouse creation process,
or after a rescan.
To do this,
ensure that you check the `Customize Schema` option during the creation process:

![Screen shot of warehouse creation panel, showing the 'Customize Schema' option enabled.](../images/customizeSchema01.png)

The warehouse is created in Db2 Warehouse on Cloud as normal,
however it is not started immediately.
Instead,
you have the opportunity to customize the schema before proceeding.

To do this,
click the link for your warehouse:

![Screen shot of `Open in Db2 Warehouse on Cloud` button.](../images/openInDashDB.png)

The resulting display gives you a button to customize the schema used for your source database.
Hovering over the Status indicator confirms that the schema is ready for customization:

![Screen shot of `Customize <source database name>` button.](../images/customizeSchema02.png)

Clicking on the 'Customize' button results in a panel where you can modify the fields in the database schema:

![Screen shot of Customize Schema panel.](../images/customizeSchema03.png)

To reset the schema to the default,
click the `Rescan` button:

![Screen shot of `Rescan` button.](../images/customizeSchema04.png)

When you are happy with the database schema for the warehouse,
simply click the `Run` button:

![Screen shot of `Run` button.](../images/customizeSchema05.png)

The schema is saved,
and the warehouse is started.

### Customizing an existing warehouse schema

If the database schema for your warehouse already exists,
you have the [option to customize it](#keeping-the-data-and-structure-fresh).

## Troubleshooting

From time-to-time,
you might encounter problems when using the warehousing facility.
Information on some of these problems is provided later in this topic.

Additionally,
discussion of some common errors or problems,
as well as details of how to troubleshoot them,
is available in [Stack Overflow ![External link icon](../images/launch-glyph.svg "External link icon")](http://stackoverflow.com/questions/tagged/cloudant+dashdb){:new_window}.

If you need further help,
and can't find solutions in Stack Overflow,
please contact [{{site.data.keyword.cloudant_short_notm}} support ![External link icon](../images/launch-glyph.svg "External link icon")](mailto:support@cloudant.com){:new_window}.

### Exceptions visible in the dashboard

Sometimes,
the warehouse encounters an error condition.
For example,
if you try to create a warehouse using an existing DB2 database,
but fail to enter the correct database details,
then warehouse cannot be created successfully.

When an error condition exists,
the status of the warehouse is changed to a red circle,
indicating that there is a problem requiring your attention:

![Screen shot of error status indicator.](../images/errorIndicator1.png)

If you 'hover' over the indicator,
a little more information is supplied:

![Screen shot showing hover summary of error status.](../images/errorIndicator2.png)

When you click on the indicator,
a window appears giving you more details about exactly what the problem is.
In this example,
the host details entered for the DB2 connection were not valid:

![Screen shot showing hover summary of error status.](../images/errorIndicator3.png)

### Warnings and Errors

Changes in the {{site.data.keyword.cloudant_short_notm}} database are replicated across into the warehouse database.
It is possible that a change might not fit into the warehouse or its schema.
Problems of this kind are detected and logged in the `OVERFLOW` table of the warehouse database.

For example,
if the warehouse schema has a `Movie_earnings_rank` field of type `VARCHAR`,
and can hold up to 32 characters,
but a change in the {{site.data.keyword.cloudant_short_notm}} database requires storage of 40 characters,
then the field 'overflows'.
This would produce a 'warning' condtion,
which is indicated in the status icon of the warehouse dashboard:

![Screen shot showing warning message in status icon.](../images/overflowWarning.png)

Looking in the indicated overflow table in the warehouse database,
you see more details about the warning:

![Screen shot showing warning message detail in the Overflow table of the warehouse database.](../images/overflowWarningDetail.png)

In this example,
the warning makes it clear that a truncation has occurred,
affecting the `Movie_earnings_rank` field of the {{site.data.keyword.cloudant_short_notm}} document having an `_ID` of  `70f6284d2a395396dbb3a60b4cf1cac2`.

There are two possible solution options:

-   Correct the overflowing field within the {{site.data.keyword.cloudant_short_notm}} document.
-   [Update the warehouse schema](#customizing-the-warehouse-schema).

The option you choose depends on whether the extra content in the field is intentional or not.
If you do require the extra content for your application,
then it is necessary to
[update the warehouse schema](#customizing-the-warehouse-schema) to remove the warning condition.

A more significant problem is if an entirely new field is introduced into a document in the {{site.data.keyword.cloudant_short_notm}} database,
but the field does not have a counterpart in the warehouse database schema.
This causes an 'error' condition.

For example,
a document in the {{site.data.keyword.cloudant_short_notm}} database might 'gain' an extra field called `my key`
that does not exist within the warehouse database schema:

![Screen shot showing additional 'my key' field in a document.](../images/extraField.png)

The result is an error condition,
which is indicated in the status icon of the warehouse dashboard:

![Screen shot showing error message in status icon.](../images/overflowError.png)

Looking in the indicated overflow table in the warehouse database,
you see more details about the error:

![Screen shot showing error message detail in the Overflow table of the warehouse database.](../images/overflowErrorDetail.png)

In this example,
the error makes it clear that a field has been encountered
that was not present when the warehouse database schema was created.
The field itself was detected in the {{site.data.keyword.cloudant_short_notm}} document having an `_ID` of  `70f6284d2a395396dbb3a60b4cf1cac2`.

There are two possible solution options:

-   Remove the extra field from the {{site.data.keyword.cloudant_short_notm}} document.
-   [Update the warehouse schema](#customizing-the-warehouse-schema).

The option you choose depends on whether the extra field is intentional or not.
If you do require the extra field for your application,
then it is necessary to [update the warehouse schema](#customizing-the-warehouse-schema) to remove the error condition.
