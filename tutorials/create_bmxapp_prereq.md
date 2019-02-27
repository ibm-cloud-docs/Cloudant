---

copyright:
  years: 2017, 2019
lastupdated: "2019-02-27"

keywords: python, create service instance, create stand-alone python application

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

# Creating a simple {{site.data.keyword.cloud_notm}} application to access an {{site.data.keyword.cloudant_short_notm}} database: Prerequisites
{: #creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-prerequisites}

This section of the tutorial describes the prerequisites
for creating an {{site.data.keyword.cloud}} application.
{: shortdesc}

## Prerequisites
{: #prerequisites}

Ensure that you have the following resources or information ready
before you start working through the tutorial.

### Python
{: #python}

For all but the simplest possible development work,
it is much easier if you have a current installation of the
[Python programming language ![External link icon](../images/launch-glyph.svg "External link icon")](https://www.python.org/){: new_window}
on your system.

To check,
run the following command at a prompt:

```sh
python --version
```
{: pre}

Expect a result similar to the following output:

```
Python 2.7.12
```
{: codeblock}

### An {{site.data.keyword.cloudant_short_notm}} service instance on {{site.data.keyword.cloud_notm}}
{: #an-ibm-cloudant-service-instance-on-ibm-cloud}

A separate tutorial for creating an {{site.data.keyword.cloudantfull}} service instance called
'`Cloudant-o7`' is available [here](/docs/services/Cloudant/tutorials/create_service.html).

This tutorial assumes that you have already created a service instance called
'`Cloudant-o7`'.

### An {{site.data.keyword.cloudant_short_notm}} database application
{: #an-ibm-cloudant-database-application}

A separate tutorial for creating a stand-alone Python application
to work with an {{site.data.keyword.cloudant_short_notm}}
service instance is available [here](/docs/services/Cloudant/tutorials/create_database.html).
It introduces a number of concepts that are helpful for understanding how to create and populate an {{site.data.keyword.cloudant_short_notm}} database.

This tutorial assumes that you are familiar with those concepts.

The next step in the tutorial is to [create the application environment](/docs/services/Cloudant/tutorials/create_bmxapp_appenv.html).