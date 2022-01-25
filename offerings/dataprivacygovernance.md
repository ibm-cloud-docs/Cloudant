---

copyright:
  years: 2016, 2022
lastupdated: "2022-01-25"

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

# Data privacy and governance
{: #data-privacy-and-governance}

As a pioneer in the provision of a fully-managed and globally-distributable Database-as-a-Service, {{site.data.keyword.cloudantfull}} allows customers to locate data in any global {{site.data.keyword.cloud}} or AWS region. By providing customers with such high levels of data mobility to serve the local needs of customers, {{site.data.keyword.IBM}} and {{site.data.keyword.cloudant_short_notm}} take data privacy and governance seriously.

{{site.data.keyword.cloud_notm}} data privacy processing processes and procedures are documented within the {{site.data.keyword.cloud_notm}} DPA. This Data Processing Addendum (DPA) and its applicable DPA Exhibits apply to the Processing of Personal Data by {{site.data.keyword.cloud_notm}} on behalf of Client (Client Personal Data). The processing of Personal Data is subject to the General Data Protection Regulation 2016/679 (GDPR) or any other data protection laws identified at [Data Protection Laws](http://www.ibm.com/dpa/dpl){: external} in order to provide services (Services) pursuant to the Agreement between Client and {{site.data.keyword.cloud_notm}}. The {{site.data.keyword.cloud_notm}} DPA can be found at [Data Processing Addendum](https://www.ibm.com/dpa){: external}.

In addition to the DPA, the cloud services contain DPA exhibits that detail the types of data that are processed by this service and the relevant processing locations (including hosting locations) where client PI is processed.  The relevant DPA exhibit for {{site.data.keyword.cloudant_short_notm}} can be found on the [{{site.data.keyword.cloud_notm}} Terms site](https://www.ibm.com/support/customer/csol/contractexplorer/cloud/datasheets/2052E430379B11E58B2CB2A838CE4F20/en){: external}.

{{site.data.keyword.cloud_notm}} relies on Standard Contractual Clauses (as our primary data transfer mechanism) in our customer contracts, as well as numerous supplementary measures, to help clients ensure an adequate level of protection when transferring personal data outside of the EU/EEA.  For more information, see EU Standard Contractual Clauses signed by all [{{site.data.keyword.cloud_notm}} Data Importers](https://www.ibm.com/software/sla/sladb.nsf/sla/eumc){: external}, if applicable.

{{site.data.keyword.cloudant_short_notm}} does not move your data without notification. {{site.data.keyword.cloudant_short_notm}} relies on centralized components for aspects of the service. Of particular interest for data residency are logs that contain URLs. These logs are sent out of region-specific infrastructure, to centralized logging components. For any data where residency is a concern, avoid its inclusion within URLs such as in the path or query string. {{site.data.keyword.cloudant_short_notm}} documentation describes how this can be achieved for various areas of our API. For more information, see [Multi-query a MapReduce view](/apidocs/cloudant#postviewqueries) for an example on how to use POST for view queries rather than GET.

For {{site.data.keyword.cloud_notm}}'s position on trust and transparency, in relation to customer data, see [Trust principles](https://www.ibm.com/blogs/policy/trust-principles/){: external}.

If there are additional questions associated with {{site.data.keyword.cloud_notm}}'s data privacy policies, email DPA.Help.project@uk.ibm.com. For more information, see [Compliance](/docs/Cloudant?topic=Cloudant-compliance) about {{site.data.keyword.cloudant_short_notm}}'s overall standards for compliance.
