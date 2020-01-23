---

copyright:
  years: 2015, 2020
lastupdated: "2020-01-20"

keywords: capacity, provisioned throughput capacity, view capacity, set capacity, view consumption

subcollection: cloudant

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

<!-- Acrolinx: 2019-09-09 -->

# Capacity
{: #capacity}

The Capacity API documentation details how to use the {{site.data.keyword.cloudant_short_notm}} API 
to do the following tasks:

- View the current and target provisioned throughput capacity setting.
- Set the target provisioned throughput capacity setting.
- View the current consumption of provisioned throughput capacity used.
{: shortdesc}

For more information, see the [provisioned throughput capacity](/docs/Cloudant?topic=cloudant-ibm-cloud-public#provisioned-throughput-capacity) documentation about how {{site.data.keyword.cloudant_short_notm}} allocates and consumes capacity, as well as how to view and change the capacity in the UI.

The Capacity API requires either {{site.data.keyword.cloudant_short_notm}} legacy auth admin role or IAM Manager role to access the API endpoints. The following curl examples omit the authentication aspect for simplicity. See the [authentication overview](/docs/Cloudant?topic=cloudant-connecting#authentication-overview) section for more details on using both types of authentication.  
{: note}

## View the current and target provisioned throughput capacity setting
{: #view-current-and-target-capacity-setting}

Use a GET to the `_api/v2/user/capacity/throughput` endpoint to see what amount of provisioned throughput capacity is allocated to the {{site.data.keyword.cloudant_short_notm}} instance and what is the target provisioned throughput capacity. When you change the target capacity, the current capacity asynchronously changes to meet the target capacity. The amount of time it takes for the current capacity to match the target capacity depends on the size of the capacity change and the amount of data stored in the {{site.data.keyword.cloudant_short_notm}} instance. The capacity change is complete when the current and target capacity is the same. 

-   **Method** - `GET`
-   **Path** - `_api/v2/user/capacity/throughput`
-   **Response** - Both the current and target capacity setting. Each includes the number of capacity blocks and total reads/sec, writes/sec, and global queries/sec of throughput capacity.

See the following example request to retrieve the current and target capacity by using HTTP:

```HTTP
GET /_api/v2/user/capacity/throughput
```
{: codeblock}

See the following example request to retrieve the current and target capacity by using the command line:

```sh
curl "https://$ACCOUNT.cloudant.com/_api/v2/user/capacity/throughput"
```
{: codeblock}

The returned structure includes the following fields:

- `current` - Details the current capacity that is allocated and shows both the number of capacity blocks and breakdown of throughput request classes.
- `target` - Details the target capacity that is allocated and shows both the number of capacity blocks and breakdown of throughput request classes.
- `blocks` - Number of provisioned throughput capacity blocks, where a block is 100 reads/sec, 50 writes/sec, and 5 global queries/sec.
- `throughput` - Breakdown of the specific number of reads/sec, writes/sec, and global queries/sec.

See the following example JSON response with the current and target capacity:

```json
{
  "current": {
    "throughput": {
      "read": 500,
      "write": 250,
      "blocks": 5,
      "query": 25
    }
  },
  "target": {
    "throughput": {
      "read": 1000,
      "write": 500,
      "blocks": 10,
      "query": 50
    }
  }
}
```
{: codeblock}

## Set the target provisioned throughput capacity setting
{: #set-target-capacity-setting}

Use a PUT to the `_api/v2/user/capacity/throughput` endpoint to set the target provisioned throughput capacity for an {{site.data.keyword.cloudant_short_notm}} instance. When you change the target capacity, the current capacity asynchronously changes to meet the target capacity. The amount of time it takes for the current capacity to match the target capacity depends on the size of the capacity change and the amount of data that is stored in the {{site.data.keyword.cloudant_short_notm}} instance. 

-   **Method** - `PUT`
-   **Path** - `_api/v2/user/capacity/throughput`
-   **Response** - Both the current and target capacity setting, including the number of capacity blocks and total reads/sec, writes/sec, and global queries/sec.

See the following example request to set the target capacity by using HTTP:

```HTTP
PUT /_api/v2/user/capacity/throughput
Content-Type: application/json
```
{: codeblock}

See the following example JSON object to set target capacity:

```
{
  "blocks": NUMBER_OF_BLOCKS
}
```
{: codeblock}

See the following example request to set the target capacity by using the command line:

```sh
curl "https://$ACCOUNT.cloudant.com/_api/v2/user/capacity/throughput" \
	-X PUT \
  -H "Content-Type: application/json" \
  -d '{"blocks": NUMBER_OF_BLOCKS}'
```
{: codeblock}

Where a block consists of 100 reads/sec, 50 writes/sec, and 5 global queries/sec of provisioned throughput capacity. The `NUMBER_OF_BLOCKS` field must be an integer in the range of 1 to 100. _Larger capacity sizes can be obtained by contacting {{site.data.keyword.cloudant_short_notm}} support._

The returned structure includes the following fields:

- `current` - Details the current capacity that is allocated and shows both the number of capacity blocks and breakdown of throughput requests classes.
- `target` - Details the target capacity set and shows both the number of capacity blocks and breakdown of throughput requests classes.
- `blocks` - Number of provisioned throughput capacity blocks, where block is 100 reads/sec, 50 writes/sec, and 5 global queries/sec.
- `throughput` - Breakdown of the specific number of reads/sec, writes/sec, and global queries/sec.

See the following example JSON response with the target capacity set:

```json
{
  "current": {
    "throughput": {
      "read": 500,
      "write": 250,
      "blocks": 5,
      "query": 25
    }
  },
  "target": {
    "throughput": {
      "read": 1000,
      "write": 500,
      "blocks": 10,
      "query": 50
    }
  }
}
```
{: codeblock}

## View the current consumption of provisioned throughput capacity used
{: #view-current-capacity-consumption}

Use a GET to the `_api/v2/user/current/throughput` endpoint to see the current consumption of provisioned throughput capacity for an {{site.data.keyword.cloudant_short_notm}} instance. The current consumption shows the quantities of reads, writes, and global queries conducted against the instance for a given second. When you use this endpoint, it is a best practice to aggregate this data continuously over time to get a more comprehensive view of a Cloudant instance's throughput consumption patterns. 

-   **Method** - `GET`
-   **Path** - `_api/v2/user/current/throughput`
-   **Response** - The current consumption of provisioned throughput capacity consumed, broken down by the number of reads, writes, and global queries.

See the following example request to retrieve the current consumption of capacity by using HTTP:

```HTTP
GET _api/v2/user/current/throughput
```
{: codeblock}

See the following example request to retrieve the current consumption of capacity by using the command line:

```sh
curl "https://$ACCOUNT.cloudant.com/_api/v2/user/current/throughput"
```
{: codeblock}

The returned structure includes the following fields:

- `throughput` - Breakdown of the current number of reads, writes, and global queries consumed.

See the following example JSON response of the current consumption of capacity:

```json
{
  "throughput": {
    "read": 133,
    "write": 42,
    "query": 13,
  }
}
```
{: codeblock}
