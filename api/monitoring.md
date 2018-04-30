---

copyright:
  years: 2015, 2018
lastupdated: "2018-04-30"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

# Monitoring a {{site.data.keyword.cloudant_short_notm}} cluster

> **Important**: The monitoring API is not available to {{site.data.keyword.cloud}} Public accounts. 
Existing {{site.data.keyword.cloudantfull}} Enterprise cluster accounts can continue to use the monitoring 
API, but it is not available to new accounts.

A key part of ensuring best performance,
or troubleshooting any problems,
is monitoring the affected system.
{:shortdesc}

You want to be able to answer the question:
"In what way has the system behavior changed as a result of any configuration or application modifications?"
To answer the question,
you need data.
The data comes from monitoring the system.

Monitoring the system while it replicates can be performed using the `_active_tasks` endpoint,
which is described in more detail [here](active_tasks.html).

For more detailed system information,
you make use of the cluster monitoring API.

>	**Note**: The cluster monitoring API is not available for
[IBM {{site.data.keyword.cloudant_short_notm}} Data Layer Local Edition (Cloudant Local)](../offerings/cloudant_local.html#cloudant-local).

## Monitoring metrics overview

When monitoring the cluster,
you can obtain data about how it is performing.
Details such as the number of HTTP requests processed per second,
or how many documents are processed per second,
can all be obtained through the monitoring API.
The API can be invoked only by an administrative user,
and is applied to a specific monitoring endpoint.

For example,
if you wanted to monitor the number of documents processed by a map function each second,
you would direct the request to the `map_doc` endpoint.

For more information, see a full list of the available [endpoints](#monitoring-endpoints).

The data returned is provided in JSON format by default.
You can specify a `raw` format if you prefer.

## Syntax of the monitoring request

All requests to the monitoring API have the following form:

```sh
curl -u [ADMIN_USER] https://[ADMIN_USER].cloudant.com/_api/v2/monitoring/[END_POINT]?cluster=[CLUSTER][&format=(json|raw)]
```
{:codeblock}

The fields are described in the following table:

Field        | Meaning
-------------|--------
`ADMIN_USER` | The account name. The account must have administrative privileges.
`CLUSTER`    | The cluster you are interested in.
`DURATION`   | Specifies the duration of the desired time series query. Select from one of the following time intervals: `["5min", "30min", "1h", "12h", "24h", "1d", "3d", "7d", "1w", "1m", "3m", "6m", "12m", "1y"]`. `DURATION` must be paired with either the `START` or `END` request.
`END`        | UTC timestamp in ISO-8601 or integer seconds where epoch format specifies the end point of a time series query that is mutually exclusive with `START`.
`END_POINT`  | The [aspect](#monitoring-endpoints) of the cluster you want to monitor.
`START`      | UTC timestamp in ISO-8601 or integer seconds where epoch format specifies the starting point of a time series query that is mutually exclusive with `END`.

Several of the fields have default values:

Field      | Default value
-----------|--------------
`DURATION` | 5 minutes.
`END`      | No default value.
`START`    | The current time.

### Results format

By default,
the monitoring results are returned in [`JSON` format](#with-format-json-default-).
If you prefer,
you can choose to receive the results in [`raw` format](#with-format-raw-).

The results include a text string that identifies the metric stored on the server providing the API capability,
for example:

```
sumSeries(net.cloudant.mycustomer001.db*.df.srv.used)
```
{:codeblock}

The results include cluster-level data.

>   **Note**: {{site.data.keyword.cloudant_short_notm}} stores the queried data at the following resolutions:

-   10 seconds for the past 24 hours.
-   1 minute for the past 7 days.
-   1 hour for the past 2 years.

>   As a result,
    and to ensure that {{site.data.keyword.cloudant_short_notm}} always stores the higher resolution interval length,
    deltas on the boundary of these resolutions are trimmed by one interval's length.

### With `format=json` (default)

Unless you specify otherwise,
the metric data returned is in JSON format.
Each value returned consists of `[datapoint, timestamp]` values.

_Example monitoring request for disk use data returned in `JSON` format:_

```sh
curl https://$ACCOUNT.cloudant.com/_api/v2/monitoring/disk_use?cluster=myclustername&format=json
```
{:codeblock}

_Example result after requesting disk use data in `JSON` format:_

```json
[
	{
		"target": "sumSeries(net.cloudant.mycustomer001.db*.df.srv.used)",
		"datapoints": [
			[523562172416.0, 1391019360],
			[524413976576.0, 1391019420],
			[519036682240.0, 1391019480],
			[518762102784.0, 1391019540],
			[523719393280.0, 1391019600]
		]
	},
	{
		"target": "sumSeries(net.cloudant.mycustomer001.db*.df.srv.free)",
		"datapoints": [
			[6488926978048.0, 1391019360],
			[6487768301568.0, 1391019420],
			[6493145661440.0, 1391019480],
			[6493420257280.0, 1391019540],
			[4330660167680.0, 1391019600]
		]
	}
]
```
{:codeblock}

### With `format=raw`

The `raw` format data contains a series of text strings,
identifying the name of the metric and associated values.

The text string (for example `sumSeries(net.cloudant.mycustomer001.db*.df.srv.used)`) is the name of the metric.
The next two numbers are the start and end times,
expressed as UTC epoch seconds.
The final number is the step size in seconds.

The numbers after the `|` character contain the metric data obtained from your chosen end point.
For example,
requesting metric data from the disk use end point returns the output from a `df` command,
with the disk use expressed as bytes stored.

_Example monitoring request for disk use data returned in `raw` format:_

```sh
curl https://$ACCOUNT.cloudant.com/_api/v2/monitoring/disk_use?cluster=myclustername&format=raw
```
{:codeblock}

_Example result after requesting disk use data in `raw` format:_

```
sumSeries(net.cloudant.mycustomer001.db*.df.srv.used),1391019780,1391020080,60|344708448256.0,345318227968.0,346120126464.0,346716471296.0,175483256832.0
sumSeries(net.cloudant.mycustomer001.db*.df.srv.free),1391019780,1391020080,60|6.49070326579e+12,6.4896982057e+12,6.48884414054e+12,6.48801589658e+12,4.32277107507e+12
```
{:codeblock}

## Monitoring endpoints

To list all of the currently supported monitoring end points,
make a request to the `monitoring` endpoint.

The following table lists the supported monitoring endpoints provided by the API:

Endpoint                                | Description
----------------------------------------|------------
[`connections`](#connections)            | The status of multiple load balancer connections.
[`disk_use`](#disk_use)                 | The disk use, as measured by a `df` command.
[`kv_emits`](#kv_emits)                 | The number of `key:value` emits per second.
[`map_doc`](#map_doc)                   | The number of documents processed by a map function, per second.
[`network`](#network)                   | The octets received and transmitted.   
[`rate/status_code`](#rate-status_code) | The rate of requests, grouped by status code.
[`rate/verb`](#rate-verb)               | The rate of requests, grouped by HTTP verb.
[`rps`](#rps)                           | The number of reads per second.
[`wps`](#wps)                           | The number of writes per second.

_Example showing how to obtain a list of the currently supported monitoring end points:_

```sh
curl https://$ACCOUNT.cloudant.com/_api/v2/monitoring
```
{:codeblock}

_Example response, listing the available monitoring end points:_

```json
{
    "targets": [
        "node_disk_free_srv",
        "rps",
        "kv_emits",
        "smoosh_channels/slack_dbs",
        "smoosh_channels/upgrade_dbs",
        "smoosh_channels/ratio_dbs",
        "smoosh_channels/ratio_views",
        "smoosh_channels/slack_views",
        "smoosh_channels/upgrade_views",
        "uptime",
        "map_doc",
        "wps",
        "node_peak_cpu",
        "rate/status_code",
        "rate/verb",
        "disk_use",
        "node_mean_cpu",
        "memory",
        "os_proc_count",
        "run_queue",
        "node_disk_use_srv",
        "process_count",
        "response_time"
    ]
}
```
{:codeblock}

## Examples of monitoring requests

### connections

_Example of a `connections` monitoring request:_

```sh
curl https://$ACCOUNT.cloudant.com/_api/v2/monitoring/connections?cluster=myclustername&node=myloadbalancername&format=json
```

The response includes a data series for the following connection states:

```json
{
  "end": 1512989500,
  "start": 1512989170,
  "target_responses": [
     {
       "datapoints": [
            [
              0,
              1512989170
            ]
        ],
        "target": "myclustername.myloadbalancername Connections CLOSED"
      },
      { 
        "datapoints": [
            [
              19,
              1512989170
            ]
        ],
        "target": "myclustername.myloadbalancername Connections CLOSE_WAIT"
      },
      {
        "datapoints": [
            [
              2,
              1512989170
            ]
        ],
        "target": "myclustername.myloadbalancername Connections CLOSING"
      },
      {
        "datapoints": [
            [
              280,
              1512989170
            ]
        ],
        "target": "myclustername.myloadbalancername Connections ESTABLISHED"
      },
      {
        "datapoints": [
            [
              7,
              1512989170
            ]
        ],
        "target": "myclustername.myloadbalancername Connections FIN_WAIT1"
      },
      { 
        "datapoints": [
            [
              0,
              1512989170
            ]
        ],
        "target": "myclustername.myloadbalancername Connections FIN_WAIT2"
      },
      {
        "datapoints": [
            [
              0,
              1512989170
            ]
        ],
        "target": "myclustername.myloadbalancername Connections LAST_ACK"
      },
      {
        "datapoints": [
            [
              4,
              1512989170
            ]
        ],
        "target": "myclustername.myloadbalancername Connections LISTEN"
      },
      {
        "datapoints": [
            [
              1,
              1512989170
            ]
        ],
        "target": "myclustername.myloadbalancername Connections SYN_RECV"
      },
      {
        "datapoints": [
            [
              0,
              1512989170
            ]
        ],
        "target": "myclustername.myloadbalancername Connections SYN_SENT"
      },
      {
        "datapoints": [
            [
              28,
              1512989170
              ]
            ],
        "target": "myclustername.myloadbalancername Connections TIME_WAIT"
      }
   ]
}
```

You must explicitly specify the load balancer in the request.

### disk_use

_Example of a `disk_use` monitoring request:_

```sh
curl https://$ACCOUNT.cloudant.com/_api/v2/monitoring/disk_use?cluster=myclustername&format=json
```
{:codeblock}

_Example results (abbreviated) from a `disk_use` monitoring request:_

```json
{
	"start": 1435935759,
	"end": 1435936059,
	"target_responses": [
		{
			"target": "myclustername Used disk space (bytes)",
			"datapoints": [
				[
					6855438336.0,
					1435935780
				],
				[
					null,
					1435935795
				],
				[
					null,
					1435935810
				],
				...
				[
					null,
					1435936065
				]
			]
		},
		{
			"target": "myclustername Free disk space (bytes)",
			"datapoints": [
				[
					7141069422592.0,
					1435935780
				],
				[
					null,
					1435935795
				],
				[
					null,
					1435935810
				],
				...
				[
					null,
					1435936065
				]
			]
		}
	]
}
```
{:codeblock}

### kv_emits

_Example of a `kv_emits` monitoring request:_

```sh
curl https://$ACCOUNT.cloudant.com/_api/v2/monitoring/kv_emits?cluster=myclustername&format=json
```
{:codeblock}

_Example results (abbreviated) from a `kv_emits` monitoring request:_

```json
{
	"start": 1436194248,
	"end": 1436194548,
	"target_responses": [
		{
			"target": "myclustername Key:value pairs emitted per second from map functions",
			"datapoints": [
				[
					0.0,
					1436194230
				],
				[
					0.0,
					1436194245
				],
				[
					0.8000000000001819,
					1436194260
				],
				...
				[
					null,
					1436194515
				]
			]
		}
	]
}
```
{:codeblock}

### map_doc

_Example of a `map_doc` monitoring request:_

```sh
curl https://$ACCOUNT.cloudant.com/_api/v2/monitoring/map_doc?cluster=myclustername&format=json
```
{:codeblock}

_Example results (abbreviated) from a `map_doc` monitoring request:_

```json
{
	"start": 1436194475,
	"end": 1436194775,
	"target_responses": [
		{
			"target": "myclustername Documents per second through map functions",
			"datapoints": [
				[
					0.0,
					1436194480
				],
				[
					0.5,
					1436194495
				],
				[
					0.4000000000005457,
					1436194510
				],
				...
				[
					0.0,
					1436194765
				]
			]
		}
	]
}
```
{:codeblock}

### network

```sh
curl https://$ACCOUNT.cloudant.com/_api/v2/monitoring/network?cluster=myclustername&node=myloadbalancername&format=json
```

```json
{
  "end": 1512989748,
  "start": 1512989450,
  "target_responses": [
      {
        "datapoints": [
          [
           20247725.5,
           1512989450
          ]
        ],
        "target": "myclustername Octets tx Per Second"
      },
      {
         "datapoints": [
             [
               17697329.3046875,
               1512989450
             ]
         ],
         "target": "myclustername Octets rx Per Second" 
       }
    ]
}
```

You must explicitly specify the load balancer in the request. 

### rate/status_code

_Example of a `rate/status_code` monitoring request:_

```sh
curl https://$ACCOUNT.cloudant.com/_api/v2/monitoring/rate/status_code?cluster=myclustername&format=json
```
{:codeblock}

_Example results (abbreviated) from a `rate/status_code` monitoring request:_

```json
{
	"start": 1436194902,
	"end": 1436195202,
	"target_responses": [
		{
			"target": "myclustername 2xx",
			"datapoints": [
				[
					null,
					1436194910
				],
				[
					36.0,
					1436194920
				],
				...
				[
					0.0,
					1436195200
				]
			]
		},
		{
			"target": "myclustername 3xx",
			"datapoints": [
				[
					null,
					1436194910
				],
				[
					0.0,
					1436194920
				],
				...
				[
					null,
					1436195200
				]
			]
		},
		{
			"target": "myclustername 4xx",
			"datapoints": [
				[
					null,
					1436194910
				],
				[
					0.0,
					1436194920
				],
				...
				[
					0.0,
					1436195200
				]
			]
		},
		{
			"target": "myclustername 5xx",
			"datapoints": [
				[
					null,
					1436194910
				],
				[
					0.0,
					1436194920
				],
				...
				[
					null,
					1436195200
				]
			]
		}
	]
}
```
{:codeblock}

### rate/verb

_Example of a `rate/verb` monitoring request:_

```sh
curl https://$ACCOUNT.cloudant.com/_api/v2/monitoring/rate/verb?cluster=myclustername&format=json
```
{:codeblock}

_Example results (abbreviated) from a `rate/verb` monitoring request:_

```json
{
	"start": 1436195497,
    "end": 1436195797, 
	"target_responses": [
		{
			"target": "myclustername GET", 
			"datapoints": [
				[
					null, 
					1436195500
				], 
				[
					36.0, 
					1436195510
				], 
				...
				[
					49.5, 
					1436195790
				]
			]
		}, 
		{
			"target": "myclustername POST", 
			"datapoints": [
				[
					null, 
					1436195500
				], 
				[
					0.0, 
					1436195510
				], 
				...
				[
					0.0, 
					1436195790
				]
			]
		}, 
		{
			"target": "myclustername PUT", 
			"datapoints": [
				[
					null, 
					1436195500
				], 
				[
					0.0, 
					1436195510
				], 
				...
				[
					0.0, 
					1436195790
				]
			]
		}, 
		{
			"target": "myclustername DELETE", 
			"datapoints": [
				[
					null, 
					1436195500
				], 
				[
					0.0, 
					1436195510
				], 
				...
				[
					0.0, 
					1436195790
				]
			]
		}, 
		{
			"target": "myclustername COPY", 
			"datapoints": [
				[
					null, 
					1436195500
				], 
				[
					0.0, 
					1436195510
				], 
				...
				[
					0.0, 
					1436195790
				]
			]
		}, 
		{
			"target": "myclustername HEAD", 
			"datapoints": [
				[
					null, 
					1436195500
				], 
				[
					0.0,
					1436195510
				], 
				...
				[
					0.0, 
					1436195790
				]
			]
		}
	]
}
```
{:codeblock}

### response_time

_Example of a `response_time` monitoring request:_

```sh
curl https://$ACCOUNT.cloudant.com/_api/v2/monitoring/response_time?cluster=myclustername&format=json
```
{:codeblock}

_Example results (abbreviated) from a `response_time` monitoring request:_

```json
{
  "start": 1523984559,
  "end": 1523984859,
  "target_responses": [
    {
      "datapoints": [
        [
          118.1668472290039,
          1523984540
        ],
        [
          90.57628631591797,
          1523984550
        ],
        [
          142.6778106689453,
          1523984560
        ],
        [
          118.42487335205078,
          1523984570
        ],
        [
          120.38044738769531,
          1523984580
        ],
        [
          103.94148254394531,
          1523984590
        ],
        [
          126.64134979248047,
          1523984600
        ],
        [
          113.03324127197266,
          1523984610
        ],
        [
          136.9058074951172,
          1523984620
        ],
        [
          148.68711853027344,
          1523984630
        ],
        [
          121.22771453857422,
          1523984640
        ],
        [
          142.86459350585938,
          1523984650
        ],
        [
          103.75953674316406,
          1523984660
        ],
        [
          139.1707763671875,
          1523984670
        ],
        [
          118.29866027832031,
          1523984680
        ],
        [
          126.3541259765625,
          1523984690
        ],
        [
          115.5962905883789,
          1523984700
        ],
        [
          106.68751525878906,
          1523984710
        ],
        [
          144.12387084960938,
          1523984720
        ],
        [
          103.8598861694336,
          1523984730
        ],
        [
          136.84429931640625,
          1523984740
        ],
        [
          110.58084106445312,
          1523984750
        ],
        [
          94.69702911376953,
          1523984760
        ],
        [
          126.85747528076172,
          1523984770
        ],
        [
          100.8759994506836,
          1523984780
        ],
        [
          145.0876922607422,
          1523984790
        ],
        [
          100.77622985839844,
          1523984800
        ],
        [
          null,
          1523984810
        ],
        [
          null,
          1523984820
        ],
        [
          null,
          1523984830
        ]
      ],
      "target": "myclustername Response Time (ms)"
    }
  ]
}
```
{:codeblock}

### rps

_Example of an `rps` monitoring request:_

```sh
curl https://$ACCOUNT.cloudant.com/_api/v2/monitoring/rps?cluster=myclustername&format=json
```
{:codeblock}

_Example results (abbreviated) from an `rps` monitoring request:_

```json
{
	"start": 1436195908,
	"end": 1436196208,
	"target_responses": [
		{
			"target": "myclustername Document Reads Per Second",
			"datapoints": [
				[
					0.20000000001164153,
					1436195910
				],
				[
					0.10000000000582077,
					1436195925
				],
				...
				[
					null,
					1436196195
				]
			]
		}
	]
}
```
{:codeblock}

### wps

_Example of a `wps` monitoring request:_

```sh
curl https://$ACCOUNT.cloudant.com/_api/v2/monitoring/wps?cluster=myclustername&format=json
```
{:codeblock}

_Example results (abbreviated) from a `wps` monitoring request:_

```json
{
	"start": 1436195999,
	"end": 1436196299,
	"target_responses": [
		{
			"target": "myclustername Document Writes Per Second",
			"datapoints": [
				[
					1.2999999999992724,
					1436196000
				],
				[
					0.5,
					1436196015
				],
				...
				[
					null,
					1436196285
				]
			]
		}
	]
}
```
{:codeblock}
