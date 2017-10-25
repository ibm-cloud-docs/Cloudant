---

copyright:
  years: 2015, 2017
lastupdated: "2017-10-25"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

<!-- Acrolinx: 2017-02-23 -->

# Bluemix Dedicated

{{site.data.keyword.cloudantfull}} for (Bluemix Dedicated) is 
an optional purchase add-on to a Bluemix Dedicated environment. The optional add-on for 
{{site.data.keyword.cloudant_short_notm}} Dedicated in Bluemix Dedicated is priced based on the hardware capacity 
allocated to the environment and can be purchased by contacting your IBM sales representative.  

Bluemix Dedicated customers can also choose to use the {{site.data.keyword.cloudant_short_notm}} in Bluemix Public 
via the syndicated catalog, including the Lite and Standard plan instances. Note that 
Bluemix Dedicated users are not eligible to purchase the Dedicated Hardware plan from the 
Bluemix Public catalog and should leverage the {{site.data.keyword.cloudant_short_notm}} Dedicated on 
Bluemix Dedicated if dedicated hardware is required.   

The screenshot below shows an example Bluemix catalog highlighting the Bluemix Public 
syndicated version of Cloudant (left) and the Cloudant Dedicated environment (right).  

![Bluemix catalog](../images/bluemix_catalog.png)

## Hardware capacity 

Cloudant within Bluemix Dedicated is purchased via an 'IBM Bluemix Dedicated 
Cloudant 1.6TB Capacity' part, which includes a clustered Cloudant environment 
consisting of three database nodes and two load balancers. Each database node 
contains 1.6TB on SSD's, and since all data is stored in triplicate this 
equates to 1.6TB of unique disk space across the cluster. Expansion of an 
environment can be accomplished by purchasing additional 'IBM Bluemix 
Dedicated Cloudant 1.6TB Capacity' parts, which can be used to expand the 
Cloudant cluster in multiples of three database nodes. Customers can also 
choose to have multiple separate Cloudant environments rather than 
expanding a single environment.

## Locations and Tenancy 

The Cloudant NoSQL Dedicated environment within a Bluemix Dedicated environment is on hardware 
that is designated for sole use by the Bluemix Dedicated customer. The customer can provision 
one or more instances of Cloudant on the given environment, and each instance of Cloudant will 
share the underlying hardware resources that make up the Cloudant environment. 

## Security, Encryption, and Compliance 

All plans are provided on servers with [at risk ![External link icon](../images/launch-glyph.svg "External link icon")](https://en.wikipedia.org/wiki/Data_at_rest) 
disk encryption. Access is over the public network connection and encrypted by 
using HTTPS. For more detail, see [Security ![External link icon](../images/launch-glyph.svg "External link icon")](https://console.bluemix.net/docs/services/Cloudant/offerings/security.html#security){:new_window}. 
IP whitelisting is available on request to Cloudant Support and will apply to 
the whole Cloudant environment, and not at the instance level. 

The plan also offers [Compliance Certification ![External link icon](../images/launch-glyph.svg "External link icon")](https://console.bluemix.net/docs/services/Cloudant/offerings/compliance.html#cloudant-security-compliance){:new_window}. 
[HIPAA ![External link icon](../images/launch-glyph.svg "External link icon")](https://en.wikipedia.org/wiki/Health_Insurance_Portability_and_Accountability_Act){:new_window} 
compliance is available upon request, so request this during the purchase process with IBM sales representative. 

## High availability, disaster recovery, and backup 

To provide high availability (HA) and disaster recovery (DR) within a data center, all data is stored in triplicate 
across three separate physical servers in a cluster. When available, you can provision accounts in multiple locations, 
then use continuous data replication to provide HA/DR across data centers. Cloudant NoSQL DB data is not automatically 
backed up, but supported tooling is provided to handle backups. Review the 
[Disaster Recovery and Backup ![External link icon](../images/launch-glyph.svg "External link icon")](https://console.bluemix.net/docs/services/Cloudant/guides/disaster-recovery-and-backup.html#disaster-recovery-and-backup){:new_window} guide
to explore all HA, DR, and backup considerations to meet your application requirements.
