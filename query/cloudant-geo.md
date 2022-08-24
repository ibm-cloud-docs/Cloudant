---

copyright:
  years: 2015, 2022
lastupdated: "2022-08-19"

keywords: geospatial, geojson, geo index, query geo index, query geometry, geometric relation, geospatial index, simple circle, polygon query, nearest neighbor search, polygon query, example

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# Using {{site.data.keyword.cloudant_short_notm}} Geospatial
{: #cloudant-nosql-db-geospatial}

Support for the {{site.data.keyword.cloudantfull}} Geospatial capability  will end on January 31, 2023. In many cases, existing applications will fail if changes are not made to address the removal of this functionality prior to the end of support.
{: shortdesc}

As of February 1, 2023, the following apply:
- Users will be unable to query `/$DATABASE/_design/$DDOCS/_geo` endpoints. Requests to those endpoints will return a `404 Not Found` reponse.
- Users will be able to define indexes using the `st_indexes` keyword in design documents, but they will be ignored by the service. This ensures that existing design documents can be updated, and replications that contain geospatial indexes will not fail. Existing Geo indexes will be deleted, and customers will no longer be billed for the space they consume.
- {{site.data.keyword.cloud}} support will no longer answer questions or assist with issues related to the Geospatial feature of the {{site.data.keyword.cloudant_short_notm}} service.

Many simple geospatial queries can be done without using the Geospatial capability that is being removed from the {{site.data.keyword.cloudant_short_notm}} service as described in the [{{site.data.keyword.cloudant_short_notm}} blog post](https://blog.cloudant.com/2022/06/28/Simple-Geospatial-Queries.html){: external}.

## {{site.data.keyword.cloudant_short_notm}} Geospatial overview
{: #using-cloudant-nosql-db-geospatial}

{{site.data.keyword.cloudant_short_notm}} Geospatial
combines the advanced geospatial queries of a Geographic Information System 
with {{site.data.keyword.cloudant_short_notm}}'s flexibility and adaptability.

These capabilities include GeoJSON, {{site.data.keyword.cloudant_short_notm}} Geospatial index, or {{site.data.keyword.cloudant_short_notm}} Geo index, and more. You can use {{site.data.keyword.cloudant_short_notm}} Geo to do the following tasks:

- Enable web and mobile developers to enhance their applications by using geospatial operations that go beyond simple bounding boxes.
- Integrate with existing GIS applications, so that they can scale to accommodate different data sizes, concurrent users, and multiple locations.
- Provide a NoSQL capability for GIS applications, so that large streams of data can be acquired from devices, sensors, and satellites. This data can then be stored, processed, and syndicated across other web applications.

## {{site.data.keyword.cloudant_short_notm}} Geo overview
{: #cloudant-nosql-db-geo-overview}

You can use {{site.data.keyword.cloudant_short_notm}} Geo to structure your data by using GeoJSON format.
Design documents are used to index the data.
Just like working with other {{site.data.keyword.cloudant_short_notm}} documents,
an initial scan works through all the documents in the database,
giving you the first index.
Subsequent updates to the documents result in incremental updates to the index.

The key advantage to using {{site.data.keyword.cloudant_short_notm}} Geo is that you can identify,
specify,
or search for documents based on a spatial relationship. In effect, {{site.data.keyword.cloudant_short_notm}} uses geometry to provide an extra way of expressing the relationship between and within documents.

For example, you specify a document that is considered `contained` if it has
a geospatial characteristic that fits within a given geospatial polygon, which is defined by a series of points.

See an example of a relationship that uses a geospatial polygon:

```json
relation=contains&g=POLYGON ((-71.0537124 42.3681995,-71.054399 42.3675178,-71.0522962 42.3667409,-71.051631 42.3659324,-71.051631 42.3621431,-71.0502148 42.3618577,-71.0505152 42.3660275,-71.0511589 42.3670263,-71.0537124 42.3681995))
```
{: codeblock}

The basic steps for working with geospatial data in {{site.data.keyword.cloudant_short_notm}} Geo are shown in the following list:

1. Contain a GeoJSON geometry object in your JSON document. The geometry object can be of any type that is defined by the [GeoJSON specification](https://tools.ietf.org/html/rfc7946){: external}.
2. Index the geometry object that uses {{site.data.keyword.cloudant_short_notm}} Geo defined `st_index` function.
3. Search the indexed geometry object by using various geometries and geometric relationships.

## Using {{site.data.keyword.cloudant_short_notm}} Geospatial through the dashboard
{: #using-cloudant-nosql-db-geospatial-through-the-dashboard}

You can use the dashboard to do several geospatial tasks:

- Visualization of data that is stored in spatial indexes.
- Spatial query construction.
- Visualization of spatial query results.

Before you use the geospatial capability through the dashboard,
you must have some spatially indexed data within a database.

To access the geospatial area of the dashboard,
follow these steps:

1. Select the database that contains spatially indexed data.
2. Select the **Design Documents** menu.
3. Select the design document that contains the definition of the spatial index.
    A `Geospatial Indexes` menu appears for the spatial index.
4. Select the Geospatial Index for your data.
    A map view appears, showing a small selection of the spatial features contained within the index.
5. To see a JSON view of the index, click the corresponding map view button.

You can construct spatial queries by using the drawing menu available on the map view:

1. Open the drawing menu in the map view.
2. Select the geometry type that you require.
3. Click in the map view to define the geospatial area.

Depending on the geometry type you specify,
a default spatial relation is chosen for you.
The exact relation is visible by selecting the Options menu.

The lowest area of the map view provides tools to select how many spatial features are shown together,
up to a maximum of 200 at a time.
To see the other results from your geospatial query,
page through them by using the arrows.

For more information about using {{site.data.keyword.cloudant_short_notm}} Geospatial, go to the [Learning Center](/docs/Cloudant?topic=Cloudant-learning-center){: external}.

## GeoJSON
{: #geojson}

[GeoJSON format](https://geojson.org/){: external}
is used to express the following various geographic data structures:

- `Point`
- `LineString`
- `Polygon`
- `MultiPoint`
- `MultiLineString`
- `MultiPolygon`
- `GeometryCollection`

A GeoJSON document is a JSON document that includes the following distinct `key:value` sections:

### `type`
{: #type}

It must be present and include the value `Feature`.

### `geometry`
{: #geometry}

It must include two fields: `type` and `coordinates`. These fields specify the definition shown in the following list:

- `type` field specifies a GeoJSON geometry type that must be one of `Point`, `LineString`, `Polygon`, `MultiPoint`, `MultiLineString`, or `MultiPolygon`.
- `coordinates` field specifies an array of latitude and longitude values.

See the example GeoJSON document in the following example:

```json
{
	"_id": "79f14b64c57461584b152123e38a6449",
	"type": "Feature",
	"geometry": {
		"type": "Point",
		"coordinates": [-71.13687953, 42.34690635]
	},
	"properties": {
		"compnos": "142035014",
		"domestic": false,
		"fromdate": 1412209800000,
		"main_crimecode": "MedAssist",
		"naturecode": "EDP",
		"reptdistrict": "D14",
		"shooting": false,
		"source": "boston"
	..}
}
```
{: codeblock}

For more information about GeoJSON,
including the full specification,
go to [GeoJSON](http://geojson.org/){: external}.

## Creating an {{site.data.keyword.cloudant_short_notm}} Geo index
{: #creating-a-cloudant-nosql-db-geo-index}

To make it easier to work with {{site.data.keyword.cloudant_short_notm}} Geo documents,
it's a best practice to create a separate design document,
specifically for {{site.data.keyword.cloudant_short_notm}} Geo.

When you create a geospatial index,
you must use the {{site.data.keyword.cloudant_short_notm}} Geo defined keyword `st_indexes` to hold one or more {{site.data.keyword.cloudant_short_notm}} Geo index definitions.
Each index must be defined by the {{site.data.keyword.cloudant_short_notm}} Geo `st_index` function. 

### `pointsInEngland` - An example {{site.data.keyword.cloudant_short_notm}} Geo index
{: #-pointsInEngland-an-example-cloudant-nosql-db-geo-index}

For example,
you can create a design document with the `_id` value `"_design/places"` that includes an index that is called `"pointsInEngland"`.
The index is a simple JavaScript function that checks for the presence of a valid geometry object in the document. If a valid geometry object is found, it ensures that the document is included in the `st_index` {{site.data.keyword.cloudant_short_notm}} Geo index function.

See the {{site.data.keyword.cloudant_short_notm}} Geo design document that includes an index in the following example:

```json
{
	"_id": "_design/places",
	"st_indexes": {
		"pointsInEngland": {
			"index": "function(doc) {if (doc.geometry && doc.geometry.coordinates) {st_index(doc.geometry);}}"
		}
	}
}
```
{: codeblock}

### Geospatial indexing
{: #geospatial-indexing}

Geospatial indexing includes a number of different algorithms for indexing geospatial data.
Some algorithms are simple to understand and implement,
but don't produce fast results.

The basic algorithm that is used by {{site.data.keyword.cloudant_short_notm}} Geo
is [R\*\_tree](http://en.wikipedia.org/wiki/R*_tree){: external}.
Although it has a slightly higher resource requirement for building the index,
the resulting index offers much better performance in responding to geospatial queries.

## Finding information about an {{site.data.keyword.cloudant_short_notm}} Geo index
{: #obtaining-information-about-a-cloudant-nosql-db-geo-index}

You can find information about a geospatial index within a database. Use the `_geo_info` endpoint to get the information. For more information, see [Using {{site.data.keyword.cloudant_short_notm}} Geospatial](/apidocs/cloudant#getgeoindexinformation).

For example,
you might want to find information about the `pointsInEngland` geospatial index,
held within the `places` design document of the `stores` database.

See an example request, by using HTTP:

```http
GET /stores/_design/places/_geo_info/pointsInEngland HTTP/1.1
```
{: codeblock}

See an example request:

```sh
curl -H "Authorization: Bearer $API_BEARER_TOKEN" -X GET "$SERVICE_URL/stores/_design/places/_geo_info/pointsInEngland"
```
{: codeblock}
{: curl}

```java
import com.ibm.cloud.cloudant.v1.Cloudant;
import com.ibm.cloud.cloudant.v1.model.GeoIndexInformation;
import com.ibm.cloud.cloudant.v1.model.GetGeoIndexInformationOptions;

Cloudant service = Cloudant.newInstance();

GetGeoIndexInformationOptifons informationOptions =
    new GetGeoIndexInformationOptions.Builder()
        .db("stores")
        .ddoc("places")
        .index("pointsInEngland")
        .build();

GeoIndexInformation response =
    service.getGeoIndexInformation(informationOptions).execute()
        .getResult();

System.out.println(response);
```
{: codeblock}
{: java}

```javascript
const { CloudantV1 } = require('@ibm-cloud/cloudant');


const service = CloudantV1.newInstance({});

service.getGeoIndexInformation({
  db: 'stores',
  ddoc: 'places',
  index: 'pointsInEngland'
}).then(response => {
  console.log(response.result);
});
```
{: codeblock}
{: javascript}

```python
from ibmcloudant.cloudant_v1 import CloudantV1

service = CloudantV1.new_instance()

response = service.get_geo_index_information(
  db='stores',
  ddoc='places',
  index='pointsInEngland'
).get_result()

print(response)
```
{: codeblock}
{: python}

```go
getGeoIndexInformationOptions := service.NewGetGeoIndexInformationOptions(
  "stores",
  "places",
  "pointsInEngland",
)

geoIndexInformation, response, err := service.GetGeoIndexInformation(getGeoIndexInformationOptions)
if err != nil {
  panic(err)
}

b, _ := json.MarshalIndent(geoIndexInformation, "", "  ")
fmt.Println(string(b))
```
{: codeblock}
{: go}

The previous Go example requires the following import block:
{: go}

```go
import (
   "encoding/json"
   "fmt"
   "github.com/IBM/cloudant-go-sdk/cloudantv1"
)
```
{: codeblock}
{: go}

All Go examples require the `service` object to be initialized. For more information, see the API documentation's [Authentication section](https://cloud.ibm.com/apidocs/cloudant?code=go#authentication-with-external-configuration) for examples. 
{: go}

The data that is returned within the `geo_index` portion of the JSON response includes
the following fields:

| Field | Description |
|------|------------|
| `doc_count` | Number of documents in the geospatial index. |
| `disk_size` | The size of the geospatial index, as stored on disk, in bytes. |
| `data_size` | The size of the geospatial index, in bytes. |
{: caption="Table 1. Fields in JSON response" caption-side="top"}

See an example response in JSON format:

```json
{
  "name": "_design/places/pointsInEngland",
  "geo_index": {
    "doc_count": 3,
    "disk_size": 25982,
    "data_size": 7206
  }
}
```
{: codeblock}

If the design document that is intended to specify a geospatial index is invalid,
an attempt to retrieve information about the index by using the `_geo_info` endpoint
results in an [HTTP `404`](/apidocs/cloudant#list-of-http-codes){: external} response.
{: tip}

## Querying an {{site.data.keyword.cloudant_short_notm}} Geo index
{: #querying-a-cloudant-nosql-db-geo-index}

The fundamental API call for using {{site.data.keyword.cloudant_short_notm}} Geo has a simple format,
where the query parameters field `<query-parameters>` includes three different types of parameters:

- Query geometry
- Geometric relation
- Result set

See an example format for an {{site.data.keyword.cloudant_short_notm}} Geo API call:

```http
/$DATABASE/_design/$DDOCS/_geo/$INDEX_NAME?$QUERY_PARAMS
```
{: codeblock}

### Query geometry
{: #query-geometry}

A query geometry parameter must be provided for an {{site.data.keyword.cloudant_short_notm}} Geo search.
The four types of query geometries are defined in the following table:

| Parameter | Description |
|----------|------------|
| `bbox`    | Specify a bounding box with two coordinates for the lower-left and upper-right corners. |
| `ellipse` | Specify an ellipse query with a latitude `lat`, a longitude `lon`, and two radii: `rangex` and `rangey`, both measured in meters. |
| `radius`  | Specify a circle query with a latitude `lat`, a longitude `lon`, and a radius `radius` measured in meters. |
| `<wkt>`   | Specify a Well Known Text (WKT) object. The valid values for the `<wkt>` parameter include `Point`, `LineString`, `Polygon`, `MultiPoint`, `MultiLineString`, `MultiPolygon`, `GeometryCollection`. |
{: caption="Table 2. Types of query geometries" caption-side="top"}

See an example of a `bbox` query:

```http
?bbox=-11.05987446,12.28339928,-101.05987446,62.28339928
```
{: codeblock}

See an example of an `ellipse` query:

```http
?lat=-11.05987446&lon=12.28339928&rangex=200&rangey=100
```
{: codeblock}

See an example of a `radius` query:

```http
?lat=-11.05987446&lon=12.28339928&radius=100
```
{: codeblock}

See an example of a `point` query:

```http
?g=point(-71.0537124 42.3681995)
```
{: codeblock}

See an example of a `polygon` query:

```http
?g=polygon((-71.0537124 42.3681995,-71.054399 42.3675178,-71.0522962 42.3667409,-71.051631 42.3659324,-71.051631 42.3621431,-71.0502148 42.3618577,-71.0505152 42.3660275,-71.0511589 42.3670263,-71.0537124 42.3681995))
```
{: codeblock}

{{site.data.keyword.cloudant_short_notm}} Geo uses `intersects` as the default geometric relation when it runs a query with query geometry only.
{: tip}

### Geometric relation
{: #geometric-relation}

{{site.data.keyword.cloudant_short_notm}} Geo works with geospatial relationships and follows
the [DE-9IM specification](https://en.wikipedia.org/wiki/DE-9IM){: external} for geometric relations.
This specification defines the different ways in which two geospatial objects are related to each other,
if indeed they're related at all.

For example,
you might specify a polygon object that describes a housing district.
You might then query your document database for people that reside within that district
by requesting all documents where the place of residence is *contained* within the polygon object.

When you specify a query geometry,
you can specify a geometric relationship against the query geometry when you query the documents in your database.
Specifically,
if `Q` is a query geometry,
then a GeoJSON document `R` is regarded as the result when a geometric relation between `Q` and `R` returns true.
The geometric relations are defined in the following table:

| Relation                | Description |
|------------------------|------------|
| `Q contains R`          | True if no points of `R` lie in the exterior of `Q`. `contains` returns the exact opposite result of `within`. |
| `Q contains_properly R` | True if `R` intersects the interior of `Q` but not the boundary (or exterior) of `Q`. |
| `Q covered_by R`        | True if `Q` is entirely within `R`. `covered_by` returns the exact opposite result of `covers`. |
| `Q covers R`            | True if `R` is entirely within `Q`. `covers` returns the exact opposite result of `covered_by`. |
|`Q crosses R`           | **Case 1** - True if the interiors intersect, *and* at least the interior of `Q` intersects with the exterior of `R`. Apply to the geometry pairs of `multipoint/linestring`, `multipoint/multilinestring`, `multipoint/polygon`, `multipoint/multipolygon`, `linestring/polygon`, and `linestring/multipolygon`.    **Case 2** - True if the intersection of the interiors of `Q` and `R` is a point. Apply to the geometry pairs of `linestring/linestring`, `linestring/multilinestring`, and `multilinestring/multilinestring`. |
| `Q disjoint R`          | True if the two geometries of `Q` and `R` don't intersect. `disjoint` returns the exact opposite result of `intersects`. |
| `Q intersects R`        | True if the two geometries of `Q` and `R` intersect. `intersects` returns the exact opposite result of `disjoint`. |
| `Q overlaps R`          | **Case 1** - True if the interior of both geometries intersects the interior and exterior of the other. Apply to the geometry pairs of `polygon/polygon`, `multipoint/multipoint`, and `multipolygon/multipolygon`.    **Case 2** - True if the intersection of the geometries is a `linestring`. Apply to the geometry pairs of `linestring` and `linestring`, and `multilinestring` and `multilinestring`. |
| `Q touches R`           | True if, and only if, the common points of two geometries are found only at the boundaries of two geometries. At least one geometry must be a `linestring`, polygon, `multilinestring`, or `multipolygon`. |
| `Q within R`            | True if `Q` lies entirely within `R`. `within` returns the exact opposite result of `contains`. |
{: caption="Table 3. Geometric relations" caption-side="top"}

### Nearest neighbor search
{: #nearest-neighbor-search}

{{site.data.keyword.cloudant_short_notm}} Geo supports Nearest Neighbor search,
which is known as NN search.
If provided,
the `nearest=true` search returns all results by sorting their distances to the center of the query geometry.
This geometric relation `nearest=true` can be used either with all the geometric relations described earlier,
or alone.

See an example query to find the nearest stores against a specific location:

```http
$SERVICE_URL/stores/_design/places/_geo/pointsInEngland?g=POINT(53.4 -2.31)&nearest=true&limit=5
```
{: codeblock}

The `nearest=true` search can change the semantics of an {{site.data.keyword.cloudant_short_notm}} Geo search.
For example,
without `nearest=true` in the example query,
the results include only GeoJSON documents that have coordinates equal to the query point `(-71.0537124 42.3681995)`
*or* an empty results set.
However,
by using the `nearest=true` search,
the results include all GeoJSON documents in the database whose order is measured by the distance to the query point.
{: tip}

## Example - Querying an {{site.data.keyword.cloudant_short_notm}} Geo index
{: #example-querying-a-cloudant-nosql-db-geo-index}

The following sections show a simple and a complex example. 

### Simple circle
{: #simple-circle}

This simple example demonstrates how {{site.data.keyword.cloudant_short_notm}} Geo can find documents that are considered to have a geospatial
position within a given geographic circle.
The function might be useful to determine insurance customers who live close to a known flood plain.

To specify the circle, you provide the following values:

- Latitude.
- Longitude.
- Circle radius that is specified in meters.

This query compares the geometry of each document in the index with the geometry of the specified circle.
The comparison is run according to the relation you request in the query.
So,
to find all documents that fall within the circle,
you use the `contains` relation.

See an example query to find documents that have a geospatial position within a circle:

```sh
curl -H "Authorization: Bearer $API_BEARER_TOKEN" -X GET "$SERVICE_URL/stores/_design/places/_geo/pointsInEngland?lat=53.4&lon=-2.31&radius=10&relation=contains&format=geojson"
```
{: codeblock}
{: curl}

```java
import com.ibm.cloud.cloudant.v1.Cloudant;
import com.ibm.cloud.cloudant.v1.model.GeoResult;
import com.ibm.cloud.cloudant.v1.model.GetGeoOptions;

Cloudant service = Cloudant.newInstance();

GetGeoOptions geoOptions = new GetGeoOptions.Builder()
    .db("stores")
    .ddoc("places")
    .index("pointsInEngland")
    .lat(53.4)
    .lon(-2.31)
    .radius(10.0)
    .relation("contains")
    .format("geojson")
    .build();

GeoResult response =
    service.getGeo(geoOptions).execute()
        .getResult();

System.out.println(response);
```
{: codeblock}
{: java}

```javascript
const { CloudantV1 } = require('@ibm-cloud/cloudant');

const service = CloudantV1.newInstance({});

service.getGeo({
  db: 'stores',
  ddoc: 'places',
  index: 'pointsInEngland',
  lat: 53.4,
  lon: -2.31,
  radius: 10,
  relation: 'contains',
  format: 'geojson'
}).then(response => {
  console.log(response.result);
});
```
{: codeblock}
{: javascript}

```python
from ibmcloudant.cloudant_v1 import CloudantV1

service = CloudantV1.new_instance()

response = service.get_geo(
    db='stores',
    ddoc='places',
    index='pointsInEngland',
    lat=53.4,
    lon=-2.31,
    radius=10,
    relation='contains',
    format='geojson'
).get_result()

print(response)
```
{: codeblock}
{: python}

```go
getGeoOptions := service.NewGetGeoOptions(
	"stores",
	"places",
	"pointsInEngland",
)
getGeoOptions.SetLat(53.4)
getGeoOptions.SetLon(-2.31)
getGeoOptions.SetRadius(10)
getGeoOptions.SetRelation("contains")
getGeoOptions.SetFormat("geojson")
	
geoResult, response, err := service.GetGeo(getGeoOptions)
if err != nil {
	panic(err)
}

b, _ := json.MarshalIndent(geoResult, "", "  ")
fmt.Println(string(b))
```
{: codeblock}
{: go}

The previous Go example requires the following import block:
{: go}

```go
import (
   "encoding/json"
   "fmt"
   "github.com/IBM/cloudant-go-sdk/cloudantv1"
)
```
{: codeblock}
{: go}

All Go examples require the `service` object to be initialized. For more information, see the API documentation's [Authentication section](https://cloud.ibm.com/apidocs/cloudant?code=go#authentication-with-external-configuration) for examples. 
{: go}

See an example response to the query that has a geospatial position within a circle:

```json
{
  "bookmark": "g2wAAAABaANkACtkYmNvcmVAZGIzLmludGVncmF0aW9uc3Rlc3QwMDEuY2xvdWRhbnQubmV0bAAAAAJuBAAAAADgbgQA_____2poAm0AAAAKMjE1MTI1MTIyMEY9EBH161QUcGo",
  "type": "FeatureCollection",
  "features": [
    {
      "_id": "2151251220",
      "geometry": {
        "type": "Point",
        "coordinates": [
          -2.31,
          53.4
        ]
      },
      "type": "Feature",
      "properties": []
    }
  ]
}
```
{: codeblock}

### A polygon query
{: #a-polygon-query}

A more complex example shows where you specify a polygon as the geometric object of interest.
A polygon is any object that is defined by a series of connected points,
where none of the connections (the lines between the points) cross any of the other connections.

For example,
you might provide a polygon description as the geometric object,
and then request that the query return details of documents within the database that are contained by the polygon.

See an example query to find documents that have a geospatial position within a polygon:

```http
$SERVICE_URL/stores/_design/places/_geo/pointsInEngland?g=POLYGON((-71.0537124 42.3681995,-71.054399 42.3675178,-71.0522962 42.3667409,-71.051631 42.3659324,-71.051631 42.3621431,-71.0502148 42.3618577,-71.0505152 42.3660275,-71.0511589 42.3670263,-71.0537124 42.3681995))&relation=contains&format=geojson
```
{: codeblock}

See an example response to the query that finds documents with a geospatial position within a polygon:

```json
{
	"bookmark": "g2wAAAABaANkAB9kYmNvcmVAZGIzLmJpZ2JsdWUuY2xvdWRhbnQubmV0bAAAAAJuBAAAAADAbgQA_____2poAm0AAAAgNzlmMTRiNjRjNTc0NjE1ODRiMTUyMTIzZTM5MjQ1MTZGP1vW7X5qnWhq",
	"features": [
		{
			"_id": "79f14b64c57461584b152123e38d6349",
			"geometry": {
				"coordinates": [
					-71.05107956,
					42.36510634
				],
				"type": "Point"
			},
			"properties": [],
			"type": "Feature"
		},
		{
			"_id": "79f14b64c57461584b152123e3924516",
			"geometry": {
				"coordinates": [
					-71.05204477,
					42.36674199
				],
				"type": "Point"
			},
			"properties": [],
			"type": "Feature"
		}
	],
	"type": "FeatureCollection"
}
```
{: codeblock}
