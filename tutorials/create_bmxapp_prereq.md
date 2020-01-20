---

copyright:
  years: 2017, 2020
lastupdated: "2020-01-20"

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
{:external: target="_blank" .external}

<!-- Acrolinx: 2017-05-10 -->

# Creating a simple {{site.data.keyword.cloud_notm}} application to access an {{site.data.keyword.cloudant_short_notm}} database: Prerequisites
{: #creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-prerequisites}

Verify that you're ready to create an {{site.data.keyword.cloud}} application with the tutorial by checking whether you meet the prerequisites. 
{: shortdesc}

## Prerequisites
{: #prerequisites-create_bmxapp_prereq}

Ensure that you have the following resources or information ready
before you start working through the tutorial.

### Python
{: #python-create-bmxapp-prereq}

For all but the simplest possible development work,
it's much easier if you have a current installation of the
[Python programming language](https://www.python.org/){: new_window}{: external}
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

A separate tutorial for [creating an {{site.data.keyword.cloudantfull}} service instance on {{site.data.keyword.cloud_notm}}](/docs/Cloudant?topic=cloudant-creating-an-ibm-cloudant-instance-on-ibm-cloud#creating-an-ibm-cloudant-instance-on-ibm-cloud) creates a service instance called
'`Cloudant-o7`'. 

This tutorial assumes that you already created a service instance called '`Cloudant-o7`'.

### An {{site.data.keyword.cloudant_short_notm}} database application
{: #an-ibm-cloudant-database-application}

A separate tutorial for [creating a stand-alone Python application
to work with an {{site.data.keyword.cloudant_short_notm}}
service instance] (/docs/Cloudant?topic=cloudant-creating-and-populating-a-simple-ibm-cloudant-database-on-ibm-cloud#creating-and-populating-a-simple-ibm-cloudant-database-on-ibm-cloud) is also available. It introduces a number of concepts that are helpful for understanding how to create and populate an {{site.data.keyword.cloudant_short_notm}} database.

The tutorial assumes that you're familiar with these concepts.

The next step is to [create the application environment](/docs/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment).