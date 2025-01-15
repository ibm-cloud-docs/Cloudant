---

copyright:
  years: 2015, 2023
lastupdated: "2023-05-04"

keywords: capacity, provisioned throughput capacity, view capacity, set capacity, view consumption

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# Capacity
{: #capacity}

{{site.data.keyword.cloudant_short_notm}} lets you: view the current and target provisioned throughput capacity setting, set the target provisioned throughput capacity setting, and view the current consumption of provisioned throughput capacity used.
{: shortdesc}

For more information, see [provisioned throughput capacity](/docs/Cloudant?topic=Cloudant-ibm-cloud-public#provisioned-throughput-capacity) about how {{site.data.keyword.cloudant_short_notm}} allocates and uses capacity, and  how to view and change the capacity in the UI.

The Capacity API requires either {{site.data.keyword.cloudant_short_notm}} legacy auth admin role or IAM Manager role to access the API endpoints. The following curl examples omit the authentication aspect for simplicity. See the [authentication overview](/docs/Cloudant?topic=Cloudant-connecting#authentication-overview) section for more details on using both types of authentication.  
{: note}

## View the current and target provisioned throughput capacity setting
{: #view-current-and-target-capacity-setting}

Use a GET to the `/_api/v2/user/capacity/throughput` endpoint to see what amount of provisioned throughput capacity is allocated to the {{site.data.keyword.cloudant_short_notm}} instance and what is the target provisioned throughput capacity. When you change the target capacity, the current capacity asynchronously changes to meet the target capacity. The size of the capacity change and the amount of data that is stored in the {{site.data.keyword.cloudant_short_notm}} instance determines the time that it takes before the current and target capacities match. The capacity change is complete when the current and target capacity is the same. 

Method
:   `GET`

Path
:   `/_api/v2/user/capacity/throughput`

Response
:   Both the current and target capacity setting. Each includes the number of capacity blocks and total reads/sec, writes/sec, and global queries/sec of throughput capacity.

See the following example request to retrieve the current and target capacity by using HTTP:

```http
GET /_api/v2/user/capacity/throughput
```
{: codeblock}

See the following example request to retrieve the current and target capacity:

```sh
curl "$SERVICE_URL/_api/v2/user/capacity/throughput"
```
{: codeblock}
{: curl}

```java
import com.ibm.cloud.cloudant.v1.Cloudant;
import com.ibm.cloud.cloudant.v1.model.CapacityThroughputInformation;

Cloudant service = Cloudant.newInstance();

CapacityThroughputInformation response =
service.getCapacityThroughputInformation().execute().getResult();

System.out.println(response);
```
{: codeblock}
{: java}

```javascript
const { CloudantV1 } = require('@ibm-cloud/cloudant');

const service = CloudantV1.newInstance({});

service.getCapacityThroughputInformation().then(response => {
  console.log(response.result);
});
```
{: codeblock}
{: node}

```python
from ibmcloudant.cloudant_v1 import CloudantV1

service = CloudantV1.new_instance()

response = service.get_capacity_throughput_information().get_result()

print(response)
```
{: codeblock}
{: python}

```go
getCapacityThroughputInformationOptions := service.NewGetCapacityThroughputInformationOptions()

capacityThroughputInformation, response, err := service.GetCapacityThroughputInformation(getCapacityThroughputInformationOptions)
if err != nil {
panic(err)
}

b, _ := json.MarshalIndent(capacityThroughputInformation, "", "  ")
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

All Go examples require the `service` object to be initialized. For more information, see the API documentation's [Authentication section](/apidocs/cloudant?code=go#authentication-with-external-configuration) for examples.
{: go}

The returned structure includes the following fields:

`current`
:  Details the current capacity that is allocated and shows both the number of capacity blocks and breakdown of throughput request classes.

`target`
:  Details the target capacity that is allocated and shows both the number of capacity blocks and breakdown of throughput request classes.

`blocks`
:  Number of provisioned throughput capacity blocks, where a block is 100 reads/sec, 50 writes/sec, and 5 global queries/sec.

`throughput`
:  Breakdown of the specific number of reads/sec, writes/sec, and global queries/sec.

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

Use a PUT to the `/_api/v2/user/capacity/throughput` endpoint to set the target provisioned throughput capacity for an {{site.data.keyword.cloudant_short_notm}} instance. When you change the target capacity, the current capacity asynchronously changes to meet the target capacity. 

Method
:  `PUT`

Path
:  `/_api/v2/user/capacity/throughput`

Response
:   Both the current and target capacity setting, including the number of capacity blocks and total reads/sec, writes/sec, and global queries/sec.

See the following example request to set the target capacity by using HTTP:

```http
PUT $SERVICE_URL/_api/v2/user/capacity/throughput
Content-Type: application/json
```
{: codeblock}

See the following example JSON object to set target capacity:

```sh
{
  "blocks": $NUMBER_OF_BLOCKS
}
```
{: codeblock}

Here a block consists of 100 reads/sec, 50 writes/sec, and 5 global queries/sec of provisioned
throughput capacity. The `$NUMBER_OF_BLOCKS` field must be an integer in the range of 1 to 100. *Larger capacity sizes can be obtained by contacting {{site.data.keyword.cloudant_short_notm}} support.*

See the following example request to set the target capacity:

```sh
curl -X PUT "$SERVICE_URL/_api/v2/user/capacity/throughput" -H "Content-Type: application/json" --data '{"blocks": 1}'
```
{: codeblock}
{: curl}

```java
import com.ibm.cloud.cloudant.v1.Cloudant;
import com.ibm.cloud.cloudant.v1.model.CapacityThroughputInformation;
import com.ibm.cloud.cloudant.v1.model.PutCapacityThroughputConfigurationOptions;

Cloudant service = Cloudant.newInstance();

PutCapacityThroughputConfigurationOptions options =
    new PutCapacityThroughputConfigurationOptions.Builder()
        .blocks(1)
        .build();

CapacityThroughputInformation response =
service.putCapacityThroughputConfiguration(options).execute().getResult();

System.out.println(response);
```
{: codeblock}
{: java}

```javascript
const { CloudantV1 } = require('@ibm-cloud/cloudant');

const service = CloudantV1.newInstance({});

service.putCapacityThroughputConfiguration({
  blocks: 1,
}).then(response => {
  console.log(response.result);
});
```
{: codeblock}
{: node}

```python
from ibmcloudant.cloudant_v1 import CloudantV1

service = CloudantV1.new_instance()

response = service.put_capacity_throughput_configuration(
  blocks=1
).get_result()

print(response)
```
{: codeblock}
{: python}

```go
putCapacityThroughputConfigurationOptions := service.NewPutCapacityThroughputConfigurationOptions(
  1,
)

capacityThroughputConfiguration, response, err := service.PutCapacityThroughputConfiguration(putCapacityThroughputConfigurationOptions)
if err != nil {
  panic(err)
}

b, _ := json.MarshalIndent(capacityThroughputConfiguration, "", "  ")
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

The returned structure includes the following fields:


`current` 
:  Details the current capacity that is allocated and shows both the number of capacity blocks and breakdown of throughput requests classes.

`target` 
:  Details the target capacity set and shows both the number of capacity blocks and the breakdown of throughput requests classes.

`blocks`
:  Number of provisioned throughput capacity blocks, where block is 100 reads/sec, 50 writes/sec, and 5 global queries/sec.

`throughput` 
:  A breakdown of the specific number of reads/sec, writes/sec, and global queries/sec.

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

Use a GET method to the `/_api/v2/user/current/throughput` endpoint to see the current consumption of provisioned throughput capacity for an {{site.data.keyword.cloudant_short_notm}} instance. The current consumption shows the quantities of reads, writes, and global queries conducted against the instance for a given second. When you use this endpoint, it is a best practice to aggregate this data continuously over time to get a more comprehensive view of an {{site.data.keyword.cloudant_short_notm}} instance's throughput consumption patterns.

Method
:  `GET`

Path
:  `/_api/v2/user/current/throughput`

Response
:  The current consumption of provisioned throughput capacity used, broken down by the number of reads, writes, and global queries.

See the following example request to retrieve the current consumption of capacity by using HTTP:

```http
GET $SERVICE_URL/_api/v2/user/current/throughput
```
{: codeblock}

See the following example request to retrieve the current consumption of capacity:

```sh
curl "$SERVICE_URL/_api/v2/user/current/throughput"
```
{: codeblock}
{: curl}

```java
import com.ibm.cloud.cloudant.v1.Cloudant;
import com.ibm.cloud.cloudant.v1.model.CurrentThroughputInformation;

Cloudant service = Cloudant.newInstance();

CurrentThroughputInformation response =
service.getCurrentThroughputInformation().execute().getResult();

System.out.println(response);
```
{: codeblock}
{: java}

```javascript
const { CloudantV1 } = require('@ibm-cloud/cloudant');

const service = CloudantV1.newInstance({});

service.getCurrentThroughputInformation().then(response => {
  console.log(response.result);
});
```
{: codeblock}
{: node}

```python
from ibmcloudant.cloudant_v1 import CloudantV1

service = CloudantV1.new_instance()

response = service.get_current_throughput_information().get_result()

print(response)
```
{: codeblock}
{: python}

```go
getCurrentThroughputInformationOptions := service.NewGetCurrentThroughputInformationOptions()

currentThroughputInformation, response, err := service.GetCurrentThroughputInformation(getCurrentThroughputInformationOptions)
if err != nil {
  panic(err)
}

b, _ := json.MarshalIndent(currentThroughputInformation, "", "  ")
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

The returned structure includes the following fields:

- `throughput` - Breakdown of the current number of reads, writes, and global queries used.

See the following example JSON response of the current consumption of capacity:

```json
{
  "throughput": {
    "read": 133,
    "write": 42,
    "query": 13
  }
}
```
{: codeblock}
