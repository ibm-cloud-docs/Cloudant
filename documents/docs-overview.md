---

copyright:
  years: 2015, 2022
lastupdated: "2022-05-19"

keywords: create document, update document, read document, bulk operations, tombstone documents

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# Overview
{: #documents}

Documents are
[JSON objects](http://en.wikipedia.org/wiki/JSON#Data_types.2C_syntax_and_example){: external}.
Documents are also containers for your data,
and are the basis of the {{site.data.keyword.cloudantfull}} database.
{: shortdesc}

If you're using an [{{site.data.keyword.cloudant_short_notm}} service on {{site.data.keyword.cloud}}](/docs/Cloudant?topic=Cloudant-ibm-cloud-public#ibm-cloud-public), documents are limited to a maximum size of 1 MB. Exceeding this limit causes a [`413` error](/apidocs/cloudant#list-of-http-codes){: external}.
{: tip}

{{site.data.keyword.cloudant_short_notm}} uses an [eventually consistent](/docs/Cloudant?topic=Cloudant-cap-theorem#cap-theorem) model for data.
If you use the eventually consistent model, it's possible, under some conditions, to retrieve older document content. For example, older content is retrieved when your application writes or updates a document that is followed immediately by a read of the same document.

In other words,
your application would see the document content as it was before the write or update occurred.
For more information about this model,
see the topic on [Consistency](/docs/Cloudant?topic=Cloudant-cap-theorem#cap-theorem).

## Document fields
{: #document-fields}

All documents must have two fields:

- A unique `_id` field. The `_id` field is detailed in the next section.
- A `_rev` field. The `_rev` field is a revision identifier, and is [essential to the {{site.data.keyword.cloudant_short_notm}} replication protocol](/docs/Cloudant?topic=Cloudant-document-versioning-and-mvcc#document-versioning-and-mvcc).

In addition to these two mandatory fields, documents can generally contain any
other content that can be described by using JSON, subject to some caveats
detailed in the following sections.

### Document IDs
{: #document-ids}

The format of a document ID differs depending on whether a database is
partitioned or not. When a database is partitioned, the partition key for
each document is defined as part of the document ID as detailed in the next section.

#### IDs in partitioned databases
{: #ids-in-partitioned-databases}

When you use a partitioned database, the document ID specifies both the partition key and the document key. These keys are specified by splitting the document ID
into two parts that are separated by a colon:

```json
$PARTITION_KEY:$DOCUMENT_KEY
```

The `$PARTITION_KEY` might be the same between documents. The `$DOCUMENT_KEY`
must be unique within each partition. That is, overall the entire document
ID must be unique within a database. A document key might contain further
colon characters.

#### IDs in non-partitioned databases
{: #ids-in-non-partitioned-databases}

For non-partitioned databases, the `_id` field is either created by you, or
generated automatically as a [UUID](http://en.wikipedia.org/wiki/Universally_unique_identifier){: external}
by {{site.data.keyword.cloudant_short_notm}}.

If you choose to specify the document `_id` field, it must be limited to no more than 7168 characters (7k).
{: tip}

As with partitioned databases, the document ID must be unique within a database.

### Field name restrictions
{: #field-name-restrictions}

Field names that begin with the underscore character (`_`) are reserved in {{site.data.keyword.cloudant_short_notm}}.
This rule means that you can't normally have your own field names that begin with an underscore.
For example,
the field `example` would be accepted,
but the field `_example` would result in a `doc_validation` error message.

See an example of a JSON document that attempts to create a field with an underscore prefix:

```json
{
	"_top_level_field_name": "some data"
}
```
{: codeblock}

See an error message that is returned when you attempt to create a field with an underscore prefix:

```json
{
	"error": "doc_validation",
	"reason": "Bad special document member: _top_level_field_name"
}
```
{: codeblock}

However,
if the field name is for an object that is nested within the document,
you can use an underscore prefix for the field name.

See an example of a JSON document that attempts to create a field with an underscore prefix, nested within an object:

```json
{
	"another_top_level_field_name": "some data",
	"another_field": {
		"_lower_level_field_name": "some more data"
	}
}
```
{: codeblock}

See an example success message (abbreviated) returned when a nested field with an underscore prefix is created:

```json
{
	"ok": true,
	"id": "2",
	"rev": "1-9ce...8d4"
}
```
{: codeblock}

## Quorum - writing and reading data
{: #quorum-writing-and-reading-data}

In a distributed system,
it's possible that a request might take some time to complete.
A "quorum" mechanism is used to help determine when a request,
such as a write or read,
completes successfully.

For more information about quorum settings and their implications on dedicated {{site.data.keyword.cloudant_short_notm}} systems,
contact {{site.data.keyword.cloudant_short_notm}} support.

## Time to live
{: #ttl-time-to-live}

[Time to live](https://en.wikipedia.org/wiki/Time_to_live){: external} (TTL) is a property of data,
where after a relative amount of time,
or at an absolute time,
the data is considered expired.
The data itself might be deleted or moved to an alternative (archive) location.

{{site.data.keyword.cloudant_short_notm}} does not support Time to Live functions. The reason is that {{site.data.keyword.cloudant_short_notm}} documents are only "soft" deleted, not deleted. The soft deletion involves replacing the original document with a [smaller record](/docs/Cloudant?topic=Cloudant-tombstone-docs). This small record or "tombstone" is required for replication purposes. It helps ensure that the correct revision to use can be identified during replication.

If the TTL capability was available in {{site.data.keyword.cloudant_short_notm}},
the resulting potential increase in short-lived documents and soft deletion records
would mean that the database size might grow in an unbounded fashion.
