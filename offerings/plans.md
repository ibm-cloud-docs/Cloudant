---

copyright:
  years: 2015, 2017
lastupdated: "2017-09-15"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-02-23 -->

# Plans

You can select which plan to use when you
[provision your {{site.data.keyword.cloudant_short_notm}} service instance](#provisioning-a-cloudant-instance-on-bluemix).
By default,
the [Lite plan](#lite-plan) is selected.

![Cloudant service instance plan selection](../images/fb87416a.png)

## Lite plan

The Lite plan is free,
but limits you to a maximum of 1 GB of data storage.
Limits also apply to the provisioned throughput capacity for lookups,
writes, and queries. 

Storage usage is checked daily. If you exceed your storage limit, HTTP requests to the account receive a 
402 status code with the error message, "Account has exceeded its data usage quota. An upgrade to a paid plan is required."
A banner also appears on the Cloudant dashboard to inform you. You can still read and delete data. However, to write new data, 
you must either upgrade to a paid account or delete data and wait until the next check runs for your account to be reactivated. 

If you would like to store more than one GB of data,
or to have a greater throughput capacity,
move to the [Standard plan](#standard-plan).

## Standard plan

The Standard plan includes 20 GB of data storage.
If you store more than 20 GB,
you are charged a defined cost per GB per hour.
See the [Pricing ![External link icon](../images/launch-glyph.svg "External link icon")](http://cloudant.com/bluemix){:new_window} information for the current cost.
On the Standard plan,
you can also change the amount of provisioned throughput capacity for lookups,
writes,
and queries.

## Dedicated hardware plan

You can optionally run your Standard plan instance on a Dedicated Hardware instance in any [IBM global data center ![External link icon](../images/launch-glyph.svg "External link icon")](https://www.ibm.com/cloud-computing/bluemix/data-centers) for an additional $5000 per month. This plan is necessary for HIPAA compliance.

