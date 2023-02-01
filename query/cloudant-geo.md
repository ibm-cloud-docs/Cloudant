---

copyright:
  years: 2015, 2023
lastupdated: "2023-02-01"

keywords: geospatial, geojson, geo index, query geo index, query geometry, geometric relation, geospatial index, simple circle, polygon query, nearest neighbor search, polygon query

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# {{site.data.keyword.cloudant_short_notm}} Geospatial notice
{: #cloudant-nosql-db-geospatial}

Support for the {{site.data.keyword.cloudantfull}} Geospatial capability ends on 31 January 2023. In many cases, existing applications will fail if changes are not made to address the removal of this functionality before the end of support.
{: deprecated}

As of 1 February 2023, the following conditions apply:
- Users cannot query `/$DATABASE/_design/$DDOCS/_geo` endpoints. Requests to those endpoints return a `404 Not Found` response.
- Users can define indexes by using the `st_indexes` keyword in design documents, but those indexes are ignored by the service. This ensures that existing design documents can be updated, and replications that contain geospatial indexes do not fail. Existing Geo indexes will be deleted, and customers will no longer be billed for the space they consume.
- {{site.data.keyword.cloud}} support will no longer answer questions or assist with issues that are related to the Geospatial feature of the {{site.data.keyword.cloudant_short_notm}} service.
{: important}

Many simple geospatial queries can be done without using the Geospatial capability that is being removed from the {{site.data.keyword.cloudant_short_notm}} service as described in the [{{site.data.keyword.cloudant_short_notm}} blog post](https://blog.cloudant.com/2022/06/28/Simple-Geospatial-Queries.html){: external}.


