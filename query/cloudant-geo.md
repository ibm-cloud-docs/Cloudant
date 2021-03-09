---

copyright:
  years: 2015, 2021
lastupdated: "2021-03-09"

keywords: geospatial, geojson, geo index, query geo index, query geometry, geometric relation, geospatial index, simple circle, polygon query, nearest neighbor search, polygon query, example

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

<!-- Acrolinx: 2020-04-23 -->

# {{site.data.keyword.cloudant_short_notm}} Geospatial
{: #cloudant-nosql-db-geospatial}

{{site.data.keyword.cloudantfull}} Geospatial,
or "{{site.data.keyword.cloudant_short_notm}} Geo",
combines the advanced geospatial queries of a Geographic Information System (GIS)
with the flexibility and adaptability of {{site.data.keyword.cloudant_short_notm}}'s database-as-a-service (DBaaS) capabilities. These capabilities include GeoJSON, {{site.data.keyword.cloudant_short_notm}} Geo index, and more. 
{: shortdesc}

You can use {{site.data.keyword.cloudant_short_notm}} Geo to do the following tasks:

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

For example, you specify a document that is considered "contained" if it has
a geospatial characteristic that fits within a given geospatial polygon, which is defined by a series of points.

### Example of a relationship that uses a geospatial polygon

```
relation=contains&g=POLYGON ((-71.0537124 42.3681995,-71.054399 42.3675178,-71.0522962 42.3667409,-71.051631 42.3659324,-71.051631 42.3621431,-71.0502148 42.3618577,-71.0505152 42.3660275,-71.0511589 42.3670263,-71.0537124 42.3681995))
```
{: codeblock}

The basic steps for working with geospatial data in {{site.data.keyword.cloudant_short_notm}} Geo are shown in the following list:

1. Contain a GeoJSON geometry object in your JSON document. The geometry object can be of any type that is defined by the [GeoJSON specification](https://tools.ietf.org/html/rfc7946){: new_window}{: external}.
2. Index the geometry object that uses {{site.data.keyword.cloudant_short_notm}} Geo defined `st_index` function.
3. Search the indexed geometry object by using various geometries and geometric relationships.

## Using {{site.data.keyword.cloudant_short_notm}} Geospatial through the dashboard
{: #using-cloudant-nosql-db-geospatial-through-the-dashboard}

You can use the dashboard to do several geospatial tasks:

* Visualization of data that is stored in spatial indexes.
* Spatial query construction.
* Visualization of spatial query results.

Before you use the geospatial capability through the dashboard,
you must have some spatially indexed data within a database.

To access the geospatial area of the dashboard,
follow these steps:

1. Select the database that contains spatially indexed data.
2. Select the Design Documents menu.
3. Select the design document that contains the definition of the spatial index.
   A "Geospatial Indexes" menu appears for the spatial index.
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

The lowest area of the map view provides tools to select how many spatial features are displayed together,
up to a maximum of 200 at a time.
To see the other results from your geospatial query,
page through them by using the arrows.

For more information about using {{site.data.keyword.cloudant_short_notm}} Geospatial, go to the [Learning Center](https://cloud.ibm.com/docs/Cloudant?topic=Cloudant-learning-center){: new_window}{: external}.

## GeoJSON
{: #geojson}

[GeoJSON format](https://geojson.org/){: new_window}{: external}
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

- `type` field specifies a GeoJSON geometry type that must be one of `Point`,
  `LineString`,
  `Polygon`,
  `MultiPoint`,
  `MultiLineString`,
  or `MultiPolygon`.
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
go to [GeoJSON](http://geojson.org/){: new_window}{: external}.

## Creating an {{site.data.keyword.cloudant_short_notm}} Geo index
{: #creating-a-cloudant-nosql-db-geo-index}

To make it easier to work with {{site.data.keyword.cloudant_short_notm}} Geo documents,
it's a best practice to create a separate design document,
specifically for {{site.data.keyword.cloudant_short_notm}} Geo.

When you create a geospatial index,
you must use the {{site.data.keyword.cloudant_short_notm}} Geo defined keyword `st_indexes` to hold one or more {{site.data.keyword.cloudant_short_notm}} Geo index definitions.
Each index must be defined by the {{site.data.keyword.cloudant_short_notm}} Geo `st_index` function. 

### `geoidx`: An example {{site.data.keyword.cloudant_short_notm}} Geo index
{: #-geoidx-an-example-cloudant-nosql-db-geo-index}

For example,
you can create a design document with the `_id` value `"_design/geodd"` that includes an index that is called `"geoidx"`.
The index is a simple JavaScript function that checks for the presence of a valid geometry object in the document. If a valid geometry object is found, it ensures that the document is included in the `st_index` {{site.data.keyword.cloudant_short_notm}} Geo index function.

See the {{site.data.keyword.cloudant_short_notm}} Geo design document that includes an index in the following example:

```json
{
	"_id": "_design/geodd",
	"st_indexes": {
		"geoidx": {
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
is [R\*\_tree](http://en.wikipedia.org/wiki/R*_tree){: new_window}{: external}.
Although it has a slightly higher resource requirement for building the index,
the resulting index offers much better performance in responding to geospatial queries.

## Finding information about an {{site.data.keyword.cloudant_short_notm}} Geo index
{: #obtaining-information-about-a-cloudant-nosql-db-geo-index}

You can find information about a geospatial index within a database. Use the `_geo_info` endpoint to get the information.

For example,
you might want to find information about the `geoidx` geospatial index,
held within the `geodd` design document of the `crimes` database.

### Example request, by using HTTP
{: #example-request-by-using-http-cloudant-geo}

```http
GET /crimes/_design/geodd/_geo_info/geoidx HTTP/1.1
Host: $ACCOUNT.cloudant.com
```
{: codeblock}

### Example request, by using the command line
{: #example-request-by-using-the-command-line-cloudant-geo} 

```sh
curl "https://$ACCOUNT.cloudant.com/crimes/_design/geodd/_geo_info/geoidx"
```
{: codeblock}

The data that is returned within the `geo_index` portion of the JSON response includes
the following fields:

Field | Description
------|------------
`doc_count` | Number of documents in the geospatial index.
`disk_size` | The size of the geospatial index, as stored on disk, in bytes.
`data_size` | The size of the geospatial index, in bytes.
{: caption="Table 1. Fields in JSON response" caption-side="top"}

### Example response in JSON format
{: #example-response-in-json-format}

```json
{
	"name": "_design/geodd/geoidx",
	"geo_index": {
		"doc_count": 269,
		"disk_size": 33416,
		"data_size": 26974
	}
}
```
{: codeblock}

If the design document that is intended to specify a geospatial index is invalid,
an attempt to retrieve information about the index by using the `_geo_info` endpoint
results in an [HTTP `404`](https://cloud.ibm.com/apidocs/cloudant#list-of-http-codes) response.
{: tip}

## Querying an {{site.data.keyword.cloudant_short_notm}} Geo index
{: #querying-a-cloudant-nosql-db-geo-index}

The fundamental API call for using {{site.data.keyword.cloudant_short_notm}} Geo has a simple format,
where the query parameters field `<query-parameters>` includes three different types of parameters:

- Query geometry
- Geometric relation
- Result set

### Example format for an {{site.data.keyword.cloudant_short_notm}} Geo API call

```http
/$DATABASE/_design/$DDOCS/_geo/$INDEX_NAME?$QUERY_PARAMS
```
{: codeblock}

### Query geometry
{: #query-geometry}

A query geometry parameter must be provided for an {{site.data.keyword.cloudant_short_notm}} Geo search.
The four types of query geometries are defined in the following table:

Parameter | Description
----------|------------
`bbox`    | Specify a bounding box with two coordinates for the lower-left and upper-right corners.
`ellipse` | Specify an ellipse query with a latitude `lat`, a longitude `lon`, and two radii: `rangex` and `rangey`, both measured in meters.
`radius`  | Specify a circle query with a latitude `lat`, a longitude `lon`, and a radius `radius` measured in meters.
`<wkt>`   | Specify a Well Known Text (WKT) object. The valid values for the `<wkt>` parameter include `Point`, `LineString`, `Polygon`, `MultiPoint`, `MultiLineString`, `MultiPolygon`, `GeometryCollection`.
{: caption="Table 2. Types of query geometries" caption-side="top"}

#### Example of a `bbox` query

```http
?bbox=-11.05987446,12.28339928,-101.05987446,62.28339928
```
{: codeblock}

#### Example of an `ellipse` query

```http
?lat=-11.05987446&lon=12.28339928&rangex=200&rangey=100
```
{: codeblock}

#### Example of a `radius` query

```http
?lat=-11.05987446&lon=12.28339928&radius=100
```
{: codeblock}

#### Example of a `point` query

```http
?g=point(-71.0537124 42.3681995)
```
{: codeblock}

#### Example of a `polygon` query

```http
?g=polygon((-71.0537124 42.3681995,-71.054399 42.3675178,-71.0522962 42.3667409,-71.051631 42.3659324,-71.051631 42.3621431,-71.0502148 42.3618577,-71.0505152 42.3660275,-71.0511589 42.3670263,-71.0537124 42.3681995))
```
{: codeblock}

{{site.data.keyword.cloudant_short_notm}} Geo uses `intersects` as the default geometric relation when it runs a query with query geometry only.
{: tip}

### Geometric relation
{: #geometric-relation}

{{site.data.keyword.cloudant_short_notm}} Geo works with geospatial relationships and follows
the [DE-9IM specification](https://en.wikipedia.org/wiki/DE-9IM){: new_window}{: external} for geometric relations.
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

Relation                | Description
------------------------|------------
`Q contains R`          | True if no points of `R` lie in the exterior of `Q`. `contains` returns the exact opposite result of `within`.
`Q contains_properly R` | True if `R` intersects the interior of `Q` but not the boundary (or exterior) of `Q`.
`Q covered_by R`        | True if `Q` is entirely within `R`. `covered_by` returns the exact opposite result of `covers`.
`Q covers R`            | True if `R` is entirely within `Q`. `covers` returns the exact opposite result of `covered_by`.
`Q crosses R`           | Case 1 - True if the interiors intersect, *and* at least the interior of `Q` intersects with the exterior of `R`. Apply to the geometry pairs of `multipoint/linestring`, `multipoint/multilinestring`, `multipoint/polygon`, `multipoint/multipolygon`, `linestring/polygon`, and `linestring/multipolygon`.
                        | Case 2 - True if the intersection of the interiors of `Q` and `R` is a point. Apply to the geometry pairs of `linestring/linestring`, `linestring/multilinestring`, and `multilinestring/multilinestring`.
`Q disjoint R`          | True if the two geometries of `Q` and `R` don't intersect. `disjoint` returns the exact opposite result of `intersects`.
`Q intersects R`        | True if the two geometries of `Q` and `R` intersect. `intersects` returns the exact opposite result of `disjoint`.
`Q overlaps R`          | Case 1 - True if the interior of both geometries intersects the interior and exterior of the other. Apply to the geometry pairs of `polygon/polygon`, `multipoint/multipoint`, and `multipolygon/multipolygon`.
                        | Case 2 - True if the intersection of the geometries is a `linestring`. Apply to the geometry pairs of `linestring` and `linestring`, and `multilinestring` and `multilinestring`.
`Q touches R`           | True if, and only if, the common points of two geometries are found only at the boundaries of two geometries. At least one geometry must be a `linestring`, polygon, `multilinestring`, or `multipolygon`.
`Q within R`            | True if `Q` lies entirely within `R`. `within` returns the exact opposite result of `contains`.
{: caption="Table 3. Geometric relations" caption-side="top"}

### Nearest neighbor search
{: #nearest-neighbor-search}

{{site.data.keyword.cloudant_short_notm}} Geo supports Nearest Neighbor search,
which is known as NN search.
If provided,
the `nearest=true` search returns all results by sorting their distances to the center of the query geometry.
This geometric relation `nearest=true` can be used either with all the geometric relations described earlier,
or alone.

For example,
one police officer might search five crimes that occurred near a specific location
by typing the query in the following example.

#### Example query to find nearest five crimes against a specific location

```http
https://education.cloudant.com/crimes/_design/geodd/_geo/geoidx?g=POINT(-71.0537124 42.3681995)&nearest=true&limit=5
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

### Simple circle
{: #simple-circle}

This simple example demonstrates how {{site.data.keyword.cloudant_short_notm}} Geo can find documents that are considered to have a geospatial
position within a given geographic circle.
The function might be useful to determine insurance customers who live close to a known flood plain.

To specify the circle, you provide the following values:

- Latitude
- Longitude
- Circle radius, which is specified in meters

This query compares the geometry of each document in the index with the geometry of the specified circle.
The comparison is run according to the relation you request in the query.
So,
to find all documents that fall within the circle,
you use the `contains` relation.

#### Example query to find documents that have a geospatial position within a circle

```sh
curl -X GET "https://education.cloudant.com/crimes/_design/geodd/_geo/geoidx?lat=42.3397&lon=-71.07959&radius=10&relation=contains&format=geojson"
```
{: codeblock}

#### Example response to the query that has a geospatial position within a circle

```json
{
	"bookmark": "g2wAAAABaANkAB9kYmNvcmVAZGIyLmJpZ2JsdWUuY2xvdWRhbnQubmV0bAAAAAJuBAAAAADAbgQA_____2poAm0AAAAgNzlmMTRiNjRjNTc0NjE1ODRiMTUyMTIzZTM4YThlOGJGPv4LlS19_ztq",
	"features": [
		{
			"_id": "79f14b64c57461584b152123e38a8e8b",
			"geometry": {
				"coordinates": [
					-71.07958956,
					42.33967135
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

### A polygon query
{: #a-polygon-query}

A more complex example shows where you specify a polygon as the geometric object of interest.
A polygon is any object that is defined by a series of connected points,
where none of the connections (the lines between the points) cross any of the other connections.

For example,
you might provide a polygon description as the geometric object,
and then request that the query return details of documents within the database that are contained by the polygon.

#### Example query to find documents that have a geospatial position within a polygon

```http
https://education.cloudant.com/crimes/_design/geodd/_geo/geoidx?g=POLYGON((-71.0537124 42.3681995,-71.054399 42.3675178,-71.0522962 42.3667409,-71.051631 42.3659324,-71.051631 42.3621431,-71.0502148 42.3618577,-71.0505152 42.3660275,-71.0511589 42.3670263,-71.0537124 42.3681995))&relation=contains&format=geojson
```
{: codeblock}

#### Example response to the query that finds documents with a geospatial position within a polygon

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