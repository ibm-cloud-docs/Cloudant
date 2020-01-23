---

copyright:
  years: 2017, 2020
lastupdated: "2020-01-20"

keywords: create applications, deploy applications, create simple application

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

# Creating a simple {{site.data.keyword.cloud_notm}} application to access an {{site.data.keyword.cloudant_short_notm}} database
{: #creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database}

This tutorial shows you how to create an {{site.data.keyword.cloud}} application that uses the
[Python programming language](https://www.python.org/){: new_window}{: external} to
access an {{site.data.keyword.cloudantfull}} database,
hosted in your {{site.data.keyword.cloud_notm}} service instance.
{: shortdesc}

## Advantages of {{site.data.keyword.cloud_notm}}
{: #advantages-of-ibm-cloud}

A significant advantage of {{site.data.keyword.cloud}} is that you can create and deploy applications within
{{site.data.keyword.cloud_notm}} itself.
You do not have to find and maintain a server to run your applications.

If you are already using an {{site.data.keyword.cloudant_short_notm}} database instance
within {{site.data.keyword.cloud_notm}},
it makes sense to have your applications there,
too.

{{site.data.keyword.cloud_notm}} applications are typically created by using
[Cloud Foundry](https://en.wikipedia.org/wiki/Cloud_Foundry){: new_window}{: external} technology.
Cloud Foundry offers a Platform-as-a-Service (PaaS) capability
that simplifies the process of creating applications that can be deployed and run
within a Cloud environment.

[A separate tutorial](/docs/Cloudant?topic=cloudant-creating-and-populating-a-simple-ibm-cloudant-database-on-ibm-cloud#creating-and-populating-a-simple-ibm-cloudant-database-on-ibm-cloud) showed you how to create a stand-alone Python application
that uses an {{site.data.keyword.cloudant_short_notm}}
database instance within {{site.data.keyword.cloud_notm}}.
In this tutorial,
you set up and create a small Python application hosted within {{site.data.keyword.cloud_notm}}.
The application connects to your {{site.data.keyword.cloudant_short_notm}} database instance,
and creates a single,
simple document.

Python code specific to each task is provided as part of this tutorial.
A complete Python program,
sufficient to demonstrate the concepts,
is provided in the [Creating a simple {{site.data.keyword.cloud_notm}} application to access an {{site.data.keyword.cloudant_short_notm}} database](/docs/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-app-db-the-code#complete-python-program) tutorial.

No attempt was made to create *efficient* Python code for this tutorial;
the intention is to show simple and easy-to-understand working code
that you can learn from and apply for your own applications.

Also,
no attempt was made to address all possible checks or error conditions.
Some example checks are included to illustrate some of the techniques,
but you should apply normal best practices for checking and handling all
warnings or error conditions that are encountered by your own applications.

## Task overview
{: #task-overview}

To create a working Python application on {{site.data.keyword.cloud_notm}}
that can access an {{site.data.keyword.cloudant_short_notm}} database instance,
you need to perform the following tasks:

-   [Create a Python application environment on {{site.data.keyword.cloud_notm}}.](/docs/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#creating-an-ibm-cloud-application-environment)
-   [Ensure that the Python application environment has a 'connection' to an {{site.data.keyword.cloudant_short_notm}} database instance.](/docs/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#connecting-ibm-cloud-applications-and-services)
-   [(One-off task) Download and install the Cloud Foundry and {{site.data.keyword.cloud_notm}} command line toolkits.](/docs/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#the-cloud-foundry-and-ibm-cloud-command-toolkits)
-   [Download the 'starter' application.](/docs/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#the-starter-application)
-   [Customize the starter application to create your own application for accessing the {{site.data.keyword.cloudant_short_notm}} database instance.](/docs/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-app-db-the-code#the-application-code)
-   [Upload your application and test that it works.](/docs/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-uploading-the-application#uploading-the-application)
-   [Perform basic application maintenance tasks.](/docs/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-maintaining-and-troubleshooting#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-maintaining-and-troubleshooting)
-   [Diagnose and resolve problems (troubleshooting).](/docs/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-maintaining-and-troubleshooting#diagnosing-and-resolving-problems)

## Tutorial structure
{: #tutorial-structure}

The tutorial consists of five sections:

1.  [Prerequisites](/docs/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-prerequisites#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-prerequisites)
2.  [The application environment](/docs/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-the-application-environment)
3.  [Creating your application](/docs/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-app-db-the-code#creating-a-simple-ibm-cloud-app-db-the-code)
4.  [Uploading and running your application](/docs/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-uploading-the-application#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-uploading-the-application)
5.  [Maintaining and troubleshooting your application](/docs/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-maintaining-and-troubleshooting#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-maintaining-and-troubleshooting)

To begin the tutorial,
start by [checking the prerequisites](/docs/Cloudant?topic=cloudant-creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-prerequisites#creating-a-simple-ibm-cloud-application-to-access-an-ibm-cloudant-database-prerequisites).