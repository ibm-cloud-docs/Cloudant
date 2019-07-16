---

copyright:
  years: 2015, 2019
lastupdated: "2019-07-03"

keywords: provisioned throughput capacity, api 

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

<!-- Acrolinx: 2019 -->

# Capacity
{: #capacity}

The Capacity API documentation details how to use the {{site.data.keyword.cloudant_short_notm}} API 
to do the following tasks:
{: shortdesc}

- View the current and target provisioned throughput capacity setting.
- Set the target provisioned throughput capacity setting.
- View the current consumption of provisioned throughput capacity used.

See the [provisioned throughput capacity](/docs/services/Cloudant?topic=cloudant-ibm-cloud-public#provisioned-throughput-capacity) documentation for detailed information on how capacity is allocated and consumed in {{site.data.keyword.cloudant_short_notm}} as well as how to view and change the capacity in the UI.

The Capacity API requires either {{site.data.keyword.cloudant_short_notm}} legacy auth admin role or IAM Manager role to access the API endpoints. The following curl examples are omitting the authentication aspect for simplicity. See the [authentication overview](/docs/services/Cloudant?topic=cloudant-connecting#authentication-overview) section for more details on using both types of authentication.  
{: note}

## View the current and target provisioned throughput capacity setting
{: #view-current-and-target-capacity-setting}

Use a GET to the `_api/v2/user/capacity/throughput` endpoint to see what amount of provisioned throughput capacity is currently allocated to the {{site.data.keyword.cloudant_short_notm}} instance and what is the target provisioned throughput capacity. Note that when changing the target capacity, the current capacity will asynchronously change to meet the target capacity. The amount of time it takes for the current capacity to match the target capacity will depend on the size of the capacity change and the amount of data stored in the {{site.data.keyword.cloudant_short_notm}} instance. The capacity change is complete when the current and target capacity are the same. 

-   **Method**: `GET`
-   **Path**: `_api/v2/user/capacity/throughput`
-   **Response**: Both the current and target capacity setting. Each includes the number of capacity blocks and total reads/sec, writes/sec, and global queries/sec of throughput capacity.

*Example request to retrieve the current and target capacity, by using HTTP:*

```HTTP
GET /_api/v2/user/capacity/throughput
```
{: codeblock}

*Example request to retrieve the current and target capacity, by using the command line:*

```sh
curl https://$ACCOUNT.cloudant.com/_api/v2/user/capacity/throughput \
```
{: codeblock}

The returned structure includes the following fields:

- **current**: Details the current capacity allocated and shows both the number of capacity blocks and break down of throughput request classes.
- **target**: Details the target capacity allocated and shows both the number of capacity blocks and break down of throughput request classes.
- **blocks**: Number of provisioned throughput capacity blocks, where a block is 100 reads/sec, 50 writes/sec, and 5 global queries/sec.
- **throughput**: Break down of the specific number of reads/sec, writes/sec, and global queries/sec.

*Example JSON response:*

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

Use a PUT to the `_api/v2/user/capacity/throughput` endpoint to set the target provisioned throughput capacity for an {{site.data.keyword.cloudant_short_notm}} instance. Note that when changing the target capacity, the current capacity will asynchronously change to meet the target capacity. The amount of time it takes for the current capacity to match the target capacity will depend on the size of the capacity change and the amount of data stored in the {{site.data.keyword.cloudant_short_notm}} instance. 

-   **Method**: `PUT`
-   **Path**: `_api/v2/user/capacity/throughput`
-   **Response**: Both the current and target capacity setting, including the number of capacity blocks and total reads/sec, writes/sec, and global queries/sec.

*Example request to set the target capacity, by using HTTP:*

```HTTP
PUT /_api/v2/user/capacity/throughput
Content-Type: application/json
```
{: codeblock}

*Example JSON object to set target capacity:*

```
{
  "blocks": NUMBER_OF_BLOCKS
}
```
{: codeblock}

*Example request to set the target capacity, by using the command line:*

```sh
curl https://$ACCOUNT.cloudant.com/_api/v2/user/capacity/throughput \
	-X PUT \
  -H "Content-Type: application/json" \
  -d "{"blocks": NUMBER_OF_BLOCKS}"
```
{: codeblock}

Where a block consists of 100 reads/sec, 50 writes/sec, and 5 global queries/sec of provisioned throughtput capacity. The `NUMBER_OF_BLOCKS` field must be an integer in the range of 1 to 100. _Larger capacity sizes can be obtained by contacting {{site.data.keyword.cloudant_short_notm}} support._

The returned structure includes the following fields:

- **current**: Details the current capacity allocated and shows both the number of capacity blocks and break down of throughput requests classes.
- **target**: Details the target capacity set and shows both the number of capacity blocks and break down of throughput requests classes.
- **blocks**: Number of provisioned throughput capacity blocks, where block is 100 reads/sec, 50 writes/sec, and 5 global queries/sec.
- **throughput**: Break down of the specific number of reads/sec, writes/sec, and global queries/sec.

*Example JSON response:*

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

Use a GET to the `_api/v2/user/current/throughput` endpoint to see the current consumption of provisioned throughput capacity for an {{site.data.keyword.cloudant_short_notm}} instance. The current consumption will show the quantities of reads, writes, and global queries being conducted against the instance for that given second. When using this endpoint, it is best practice to aggregate this data continuously over time to get a more comprehensive view of a Cloudant instance's throughput consumption patterns. 

-   **Method**: `GET`
-   **Path**: `_api/v2/user/current/throughput`
-   **Response**: The current consumption of provisioned throughput capacity consumed, broken down by the number of reads, writes, and global queries.

*Example request to retrieve the current consumption of capacity, by using HTTP:*

```HTTP
GET _api/v2/user/current/throughput
```
{: codeblock}

*Example request to retrieve the current consumption of capacity, by using the command line:*

```sh
curl https://$ACCOUNT.cloudant.com/_api/v2/user/current/throughput \
```
{: codeblock}

The returned structure includes the following fields:

- **throughput**: Break down of the current number of reads, writes, and global queries consumed.

*Example JSON response:*

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
