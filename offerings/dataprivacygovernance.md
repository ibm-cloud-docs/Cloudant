---

copyright:
  years: 2016, 2021
lastupdated: "2021-11-01"

keywords: data privacy, move data from eu to us, transfer personal data outside eu

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

<!-- Acrolinx: 2021-04-13 -->

# Data privacy and governance
{: #data-privacy-and-governance}

{{site.data.keyword.cloudantfull}} allows customers to locate data in any
global {{site.data.keyword.cloud}} or AWS region.
By providing customers with such high levels of data mobility to serve the local needs of customers,
{{site.data.keyword.IBM}},
and {{site.data.keyword.cloudant_short_notm}} take data privacy and governance seriously.
{: shortdesc}

*(This {{site.data.keyword.cloudant_short_notm}} Data Privacy and Governance update was originally published 20 April 2016.)*

To govern the movement of data from the EU to the US,
{{site.data.keyword.cloudant_short_notm}} complied with both US-EU and US-Swiss
[Safe Harbour Frameworks](https://www.export.gov/safeharbor_eu){: external}.
The European Court of Justice
[invalidated](http://curia.europa.eu/juris/document/document.jsf?text=&docid=169195&pageIndex=0&doclang=en&mode=req&dir=&occ=first&part=1&cid=113326){: external}
the Safe Harbour agreement in 2015. 
{{site.data.keyword.IBM_notm}} was quick to urge policymakers to work expediently
to ensure *[unbroken data flows between the European Union and the United States](https://ec.europa.eu/commission/presscorner/detail/en/IP_16_216){: external}*.

{{site.data.keyword.IBM_notm}} prepared an EU Model Clauses agreement for {{site.data.keyword.cloudant_short_notm}} customers
to facilitate the transfer of personal data outside the EU
in accordance with the EU data privacy laws.
EU Model clauses are relevant to all customers
that send personal information about EU citizens to {{site.data.keyword.cloudant_short_notm}}.

To request an EU Model Clauses agreement,
or for any other information or assistance around the transfer of personal data,
customers can email the dedicated EU Model Clauses team at eu-mc@ie.ibm.com.

The EU Directive 95/46/EC sets out rules about the processing of customer's personal data.
As the data controller,
customers appoint {{site.data.keyword.IBM_notm}} as a data processor to process any personal data that might be included in the customer's content.
In turn,
customers are responsible for obtaining all necessary consents
to include the content (including any personal data) in the {{site.data.keyword.cloudant_short_notm}} solutions.

A list of countries where content might be held,
or from where content might be accessed,
for delivering and supporting a Cloud Service,
is available at [Global Data Centers](http://www.ibm.com/cloud/data-centers/){: external}.

{{site.data.keyword.cloudant_short_notm}} does not move your data without notification. {{site.data.keyword.cloudant_short_notm}} relies on centralized components for aspects of the service. Of particular interest for data residency are logs that contain URLs. These logs are sent out of region-specific infrastructure, 
to centralized logging components. For any data where residency is a concern, do not include such data in the URLs, for example, path, query string, and so on. {{site.data.keyword.cloudant_short_notm}} documentation describes how this can be achieved for various areas of our API. For more information, see [Multi-query a MapReduce view](/apidocs/cloudant#postviewqueries) for an example on how to use `POST` for view queries rather than `GET`.

For more information, see [Compliance](/docs/Cloudant?topic=Cloudant-compliance#compliance) about {{site.data.keyword.cloudant_short_notm}}'s overall standards for compliance.
Similar information can be found for these IaaS business partners:

- [Amazon](https://aws.amazon.com/compliance/){: external}
- [{{site.data.keyword.cloud}}](https://www.ibm.com/cloud/compliance){: external}

The [General Data Protection Regulations](https://www.gov.uk/government/publications/guide-to-the-general-data-protection-regulation){: external} were recently approved. {{site.data.keyword.cloudant_short_notm}} customers need to be aware of the {{site.data.keyword.cloudant_short_notm}} team's understanding and
compliance with emerging data privacy standards and legislation. 
Customers also need to be aware of {{site.data.keyword.IBM_notm}}'s wider ability to provide a comprehensive suite of solutions
to assist businesses of all sizes with their own internal data governance requirements.

Email the Client Success team at cdscsm@us.ibm.com if you need more information about any of the following issues:

- Impending changes to data protection laws in Europe and how they are likely to impact your business.
- Want to discuss how {{site.data.keyword.IBM_notm}} can support your information governance and compliance efforts.
