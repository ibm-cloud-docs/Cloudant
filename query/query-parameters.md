---

copyright:
  years: 2015, 2022
lastupdated: "2022-10-20"

keywords: create index, query, json index type, text index type, query parameters

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# {{site.data.keyword.cloudant_short_notm}} Query Parameters
{: #ibm-cloudant-query-parameters}

The `$text` operator is based on a Lucene search with a standard analyzer.
The operator isn't case-sensitive, and matches on any words.
However,
the `$text` operator doesn't support full Lucene syntax,
such as wildcards,
fuzzy matches,
or proximity detection.
{: short desc}

For more information,
see the [Search documentation](/docs/Cloudant?topic=Cloudant-cloudant-search).
The `$text` operator applies to all strings found in the document.
If you place this operator in the context of a field name, it's invalid.

The format of the `selector` field is as described in the [selector syntax](/docs/Cloudant?topic=Cloudant-query#selector-syntax),
except for the `$text` operator.
{: tip}

The `fields` array is a list of fields that must be returned for each document. The provided
field names can use dotted notation to access subfields.

See the following example JSON document that uses all available query parameters:

```json
{
	"selector": {
		"year": {
			"$gt": 2010
		}
	},
	"fields": ["_id", "_rev", "year", "title"],
	"sort": [{"year": "asc"}],
	"limit": 10,
	"skip": 0
	}
```
{: codeblock}
