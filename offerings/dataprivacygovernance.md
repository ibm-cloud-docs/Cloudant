---

copyright:
  years: 2016, 2022
lastupdated: "2022-06-23"

keywords: data privacy, move data from eu to us, transfer personal data outside eu

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# Data privacy and governance
{: #data-privacy-and-governance}

As a pioneer in the provision of a fully managed and globally distributable Database-as-a-Service, {{site.data.keyword.cloudantfull}} allows customers to locate data in any global {{site.data.keyword.cloud}} or AWS region. By providing customers with such high levels of data mobility to serve the local needs of customers, {{site.data.keyword.IBM}}, and {{site.data.keyword.cloudant_short_notm}} take data privacy and governance seriously.

{{site.data.keyword.cloud_notm}} data privacy processing processes and procedures are documented within the {{site.data.keyword.cloud_notm}} DPA. This Data Processing Addendum (DPA) and its applicable DPA Exhibits apply to the Processing of Personal Data by {{site.data.keyword.cloud_notm}} on behalf of Client (Client Personal Data). The processing of Personal Data is subject to the General Data Protection Regulation 2016/679 (GDPR). It is also subject to any other data protection laws that are identified at [Data Protection Laws](http://www.ibm.com/dpa/dpl){: external} in order to provide services (Services) according to the Agreement between Client and {{site.data.keyword.cloud_notm}}. The {{site.data.keyword.cloud_notm}} DPA can be found at [Data Processing Addendum](https://www.ibm.com/dpa){: external}.

In addition to the DPA, the cloud services contain DPA exhibits that detail the types of data that is processed by this service. Cloud services also contain the relevant processing locations (including hosting locations) where client PI is processed. The relevant DPA exhibit for {{site.data.keyword.cloudant_short_notm}} can be found on the [{{site.data.keyword.cloud_notm}} Terms site](https://www.ibm.com/support/customer/csol/contractexplorer/cloud/datasheets/2052E430379B11E58B2CB2A838CE4F20/en){: external}.

{{site.data.keyword.cloud_notm}} relies on Standard Contractual Clauses (as our primary data transfer mechanism) in our customer contracts. {{site.data.keyword.cloud_notm}} also relies on numerous supplementary measures to help clients ensure an adequate level of protection when they transfer personal data outside of the EU/EEA. For more information, see EU Standard Contractual Clauses that are signed by all [{{site.data.keyword.cloud_notm}} Data Importers](https://www.ibm.com/software/sla/sladb.nsf/sla/eumc){: external}, if applicable.

{{site.data.keyword.cloudant_short_notm}} does not move your data without notification. {{site.data.keyword.cloudant_short_notm}} relies on centralized components for aspects of the service. Of particular interest for data residency are logs that contain URLs. These logs are sent out of region-specific infrastructure, to centralized logging components. For any data where residency is a concern, avoid its inclusion within URLs such as in the path or query string. {{site.data.keyword.cloudant_short_notm}} documentation describes how this task can be achieved for various areas of our API. For more information, see [Multi-query a MapReduce view](/apidocs/cloudant#postviewqueries) for an example of how to use POST for view queries rather than GET.

For the position of {{site.data.keyword.cloud_notm}} on trust and transparency, in relation to customer data, see [Trust principles](https://www.ibm.com/blogs/policy/trust-principles/){: external}.

If more questions that are associated with the privacy principles of {{site.data.keyword.cloud_notm}} arise, email DPA.Help.project@uk.ibm.com. For more information, see [Compliance](/docs/Cloudant?topic=Cloudant-compliance) about the overall standards for compliance of {{site.data.keyword.cloudant_short_notm}}.
