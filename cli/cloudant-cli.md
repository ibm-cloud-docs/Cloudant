---

copyright:
  years: 2021, 2025
lastupdated: "2025-10-22"

subcollection: Cloudant

keywords: Cloudant CLI, Cloudant command line,  Cloudant terminal, Cloudant shell

---

{{site.data.keyword.attribute-definition-list}}





# {{site.data.keyword.cloudant_short_notm}} CLI
{: #cloudant-cli}



The {{site.data.keyword.cloud}} Command Line Interface (CLI) provides more capabilities for service offerings. You can use {{site.data.keyword.cloudant_short_notm}} CLI plug-in to manage throughput details and event types sent from your {{site.data.keyword.cloudant_short_notm}} account to {{site.data.keyword.atracker_full_notm}}.
{: shortdesc}




## Prerequisites
{: #cloudant-cli-prereq}

* Install the [{{site.data.keyword.cloud_notm}} CLI](/docs/cli?topic=cli-getting-started).
* Install the {{site.data.keyword.cloudant_short_notm}} CLI by running the following command:

```sh
ibmcloud plugin install cloudant
```
{: pre}



* Use [`ibmcloud login` command](https://cloud.ibm.com/docs/cli?topic=cli-ibmcloud_cli#ibmcloud_login) for logging in to your {{site.data.keyword.cloud_notm}} account.
* Set the {{site.data.keyword.cloudant_short_notm}} service URL. For more information, see [Service configuration](#cloudant-cli-service-config).

You're notified on the command line when updates to the {{site.data.keyword.cloud_notm}} CLI and plug-ins are available. Be sure to keep your CLI up to date so that you can use the latest commands. You can view the current version of all installed plug-ins by running `ibmcloud plugin list`.
{: tip}



### Service configuration
{: #cloudant-cli-service-config}

When you make a server resource request, the {{site.data.keyword.cloudant_short_notm}} account URL from the service credentials (for example, `https://~replace-with-cloudant-host~.cloudantnosqldb.appdomain.cloud`) is not available automatically in the plug-in. You need to set the URL of your Cloudant instance first. You can set the URL by [inline configuration](#cloudant-cli-inline-config), [global configuration](#cloudant-cli-global-config), or [setting an environment variable](#cloudant-cli-env-var-setting).

Inline configuration overrides the global configuration and the environment variable setting, while global configuration overrides the environment variable setting.
{: tip}

If you are unsure about your server URL, you can find it [by the instance ID of your cloud resource](/docs/cli?topic=cli-ibmcloud_commands_resource#ibmcloud_resource_service_instance).
To find the instance ID use the name of your service.
The following example gets first the GUID then the CRN ID by service name (for example `Cloudant-aa`).
Pass either a GUID or CRN ID as the value for the `--resource-id` option to get the Cloudant instance URL.

```sh
# Get GUID of the service instance by service name, which can be used with --resource-id later
ibmcloud resource service-instance Cloudant-aa --guid
# Get CRN ID of the service instance by service name, which can be used with --resource-id later
ibmcloud resource service-instance Cloudant-aa --crn
# Get the url of your Cloudant instance from the resource ID (can be either the GUID or the CRN ID)
ibmcloud cloudant url -q --resource-id 00000000-0000-0000-0000-000000000000
```

#### Inline configuration
{: #cloudant-cli-inline-config}

Inline configuration happens with the `--service-url` flag. All subcommands like `events-config` or `capacity` accept an inline configured service URL,
which comes from the `ibmcloud cloudant url --resource-id 00000000-0000-0000-0000-000000000000` command.

```sh
# Use events-config subcommand with inline configured service url
ibmcloud cloudant events-config --service-url 'https://~replace-with-cloudant-host~.cloudantnosqldb.appdomain.cloud'
# Use capacity subcommand with inline configured service url
ibmcloud cloudant capacity --service-url 'https://~replace-with-cloudant-host~.cloudantnosqldb.appdomain.cloud'
```

The following example shows a shorthand for using the `events-config` with inline configured service URL:

```sh
ibmcloud cloudant events-config --service-url $(ibmcloud cloudant url -q --resource-id 00000000-0000-0000-0000-000000000000)
```

#### Global configuration
{: #cloudant-cli-global-config}

Global configuration happens with the [config subcommand](#cloudant-cli-config-command). This stores a persistent configuration so that it does not need to be manually specified each time. The following example sets the service url globally, which comes from the `ibmcloud cloudant url --resource-id 00000000-0000-0000-0000-000000000000` command, then uses the set value with subcommands like `events-config` or `capacity`.

```sh
# Set service url globally
ibmcloud cloudant config set service-url 'https://~replace-with-cloudant-host~.cloudantnosqldb.appdomain.cloud'
# Use events-config subcommand with globally configured service url
ibmcloud cloudant events-config
# Use capacity subcommand with globally configured service url
ibmcloud cloudant capacity
```

The following example shows a shorthand for setting the service URL with the help of the `ibmcloud cloudant url` subcommand:

```sh
ibmcloud cloudant config set service-url $(ibmcloud cloudant url -q --resource-id 00000000-0000-0000-0000-000000000000)
```


#### Environment variable setting
{: #cloudant-cli-env-var-setting}

For this approach, you need to set the `CLOUDANT_URL` environment variable.

You can define this variable two ways:
1. Export them as environment variables, for example `export CLOUDANT_URL=...`.
2. Store them in a [credentials file](/apidocs/cloudant?code=go#authentication-with-external-configuration).

As an alternative to `ibmcloud login`, you can set the environment variable `CLOUDANT_APIKEY` to an IAM API key.
{: tip}

## Other information
{: #cloudant-cli-other-info}

The `classic` and the `c` subcommands were deprecated in version `0.0.5` and removed from version `0.1.0`. The operations from the `classic` command are available on the `cloudant` command. Track the [changes log](/docs/Cloudant?topic=Cloudant-cli-change-log) for changes in the interface. {: deprecated}


## Globals
{: #cloudant-globals}

### Commands
{: #cloudant-commands}

#### `ibmcloud cloudant url`
{: #cloudant-cli-url-command}

Retrieves the service URL from the given resource.

```sh
ibmcloud cloudant url --resource-id RESOURCE_ID
```

##### Command options
{: #cloudant-url-cli-options}

`--resource-id` (string)
:   The ID of the cloud resource. Required.
    &nbsp;

##### Example
{: #cloudant-url-examples}

```sh
ibmcloud cloudant url \
    --resource-id="8d7af921-b136-4078-9666-081bd8470d94"
```
{: pre}

### Options
{: #cloudant-global-options}

`--output` (string)
:   Choose an output format - can be 'json', 'yaml', or 'table'. Defaults to 'table'.

`-j`, `--jmes-query` (string)
:   Provide a JMESPath query to customize output.

`--service-url` (string)
:   Provide the base endpoint URL for the API.

`-q`, `--quiet`
:   Suppresses verbose messages.

`-v`, `--version`
:   Prints the plug-in version.

#### Example
{: #cloudant-global-options-example}

```sh
ibmcloud cloudant
    --output=json \
    --jmes-query="[:10]" \
    --service-url="https://myservice.test.cloud.ibm.com"
    --quiet
```
{: pre}

Note: This example only demonstrates the global options available to all sub-commands and is not a valid command itself.

## Config
{: #cloudant-cli-config-command}

Global parameters can also be stored in persistent configuration so that they do not need to be manually specified each time the plug-in is invoked. Each parameter can be configured with the `config` command and its subcommands.

```sh
ibmcloud cloudant config
```

### `ibmcloud cloudant config set`
{: #cloudant-cli-config-set-command}

Set a new config value for a specific option. Each subcommand of the `set` command maps to a global option. Each subcommand accepts a single argument, the string representation of the value to store for the option.

```sh
ibmcloud cloudant config set <option> <value>
```

#### Examples
{: #cloudant-config-set-command-examples}

```sh
ibmcloud cloudant config set service-url \
    'https://~replace-with-cloudant-host~.cloudantnosqldb.appdomain.cloud'
```
{: pre}

### `ibmcloud cloudant config get`
{: #cloudant-cli-config-get-command}

Print out the currently set value for a specific option. Each subcommand of the `get` command maps to a global option.

```sh
ibmcloud cloudant config get <option>
```

#### Examples
{: #cloudant-config-get-command-examples}

```sh
ibmcloud cloudant config get service-url
```
{: pre}

### `ibmcloud cloudant config unset`
{: #cloudant-cli-config-unset-command}

Unset the currently set value for a specific option. Each subcommand of the `unset` command maps to a global option.

The subcommands available for this service are: `service-url`, .

```sh
ibmcloud cloudant config unset <option>
```

#### Examples
{: #cloudant-config-unset-command-examples}

```sh
ibmcloud cloudant config unset service-url
```
{: pre}

### `ibmcloud cloudant config list`
{: #cloudant-cli-config-list-command}

List out all of the currently set config values.

```sh
ibmcloud cloudant config list
```

#### Examples
{: #cloudant-config-list-command-examples}

```sh
ibmcloud cloudant config list
```
{: pre}

## Server
{: #cloudant-server-cli}

Commands for Server resource.

### `ibmcloud cloudant capacity`
{: #cloudant-cli-capacity-command}

View the amount of provisioned throughput capacity that is allocated to an IBM Cloudant instance and what is the target provisioned throughput capacity.

```sh
ibmcloud cloudant capacity
```


#### Example
{: #cloudant-capacity-examples}

Example request

```sh
ibmcloud cloudant capacity
```
{: pre}

#### Example default output
{: #cloudant-capacity-default-cli-output}

Example CapacityThroughputInformation response.

```tsv
blocks	5
query	25
read	500
write	250
```
{: screen}

#### Example full output
{: #cloudant-capacity-full-cli-output}

Example CapacityThroughputInformation response.

```json
{
  "current" : {
    "throughput" : {
      "blocks" : 5,
      "query" : 25,
      "read" : 500,
      "write" : 250
    }
  },
  "target" : {
    "throughput" : {
      "blocks" : 10,
      "query" : 50,
      "read" : 1000,
      "write" : 500
    }
  }
}
```
{: screen}

#### Default JMESPath
{: #cloudant-capacity-default-jmespath}

A JMESPath query will be applied to this output of this command by default, if one is not provided by the user. The exact query will depend on the scenario and the output format requested.
You can see the condition for each default JMESPath query in the following table:

| Response | Output | Query |
| -------- | ------ | ----- |
| Success | Default | `current.throughput` |
|  | Table | `current.throughput` |
| Error | Default | `current.throughput` |
|  | Table | `current.throughput` |
| All pages | Default | `current.throughput` |
|  | Table | `current.throughput` |
{: caption="Default JMESPath" caption-side="bottom"}

If a custom JMESPath query is provided, it will replace any of the JMESPath in the table above.

### `ibmcloud cloudant capacity-update`
{: #cloudant-cli-capacity-update-command}

Sets the target provisioned throughput capacity for an IBM Cloudant instance. When target capacity is changed, the current capacity asynchronously changes to meet the target capacity.

```sh
ibmcloud cloudant capacity-update --blocks BLOCKS
```


#### Command options
{: #cloudant-capacity-update-cli-options}

`--blocks` (int64)
:   A number of blocks of throughput units. A block consists of 100 reads/sec, 50 writes/sec, and 5 global queries/sec of provisioned throughput capacity. Not available for some plans. Required.

    The maximum value is `100`. The minimum value is `1`.

#### Example
{: #cloudant-capacity-update-examples}

Example request

```sh
ibmcloud cloudant capacity-update --blocks 10
```
{: pre}

#### Example default output
{: #cloudant-capacity-update-default-cli-output}

Example CapacityThroughputInformation response.

```tsv
blocks	10
query	50
read	1000
write	500
```
{: screen}

#### Example full output
{: #cloudant-capacity-update-full-cli-output}

Example CapacityThroughputInformation response.

```json
{
  "current" : {
    "throughput" : {
      "blocks" : 5,
      "query" : 25,
      "read" : 500,
      "write" : 250
    }
  },
  "target" : {
    "throughput" : {
      "blocks" : 10,
      "query" : 50,
      "read" : 1000,
      "write" : 500
    }
  }
}
```
{: screen}

#### Default JMESPath
{: #cloudant-capacity-update-default-jmespath}

A JMESPath query will be applied to this output of this command by default, if one is not provided by the user. The exact query will depend on the scenario and the output format requested.
You can see the condition for each default JMESPath query in the following table:

| Response | Output | Query |
| -------- | ------ | ----- |
| Success | Default | `target.throughput` |
|  | Table | `target.throughput` |
| Error | Default | `target.throughput` |
|  | Table | `target.throughput` |
| All pages | Default | `target.throughput` |
|  | Table | `target.throughput` |
{: caption="Default JMESPath" caption-side="bottom"}

If a custom JMESPath query is provided, it will replace any of the JMESPath in the table above.

## Monitoring
{: #cloudant-monitoring-cli}

Commands for Monitoring resource.

### `ibmcloud cloudant events-config`
{: #cloudant-cli-events-config-command}

Check event types sent to IBM Cloud Activity Tracker Event Routing for the IBM Cloudant instance.

```sh
ibmcloud cloudant events-config
```


#### Example
{: #cloudant-events-config-examples}

Example request

```sh
ibmcloud cloudant events-config
```
{: pre}

#### Example default output
{: #cloudant-events-config-default-cli-output}

Example ActivityTrackerEvents request and response.

```tsv
management
data
```
{: screen}

#### Example full output
{: #cloudant-events-config-full-cli-output}

Example ActivityTrackerEvents request and response.

```json
{
  "types" : [ "management", "data" ]
}
```
{: screen}

#### Default JMESPath
{: #cloudant-events-config-default-jmespath}

A JMESPath query will be applied to this output of this command by default, if one is not provided by the user. The exact query will depend on the scenario and the output format requested.
You can see the condition for each default JMESPath query in the following table:

| Response | Output | Query |
| -------- | ------ | ----- |
| Success | Default | `types` |
|  | Table | `types` |
| Error | Default | `types` |
|  | Table | `types` |
| All pages | Default | `types` |
|  | Table | `types` |
{: caption="Default JMESPath" caption-side="bottom"}

If a custom JMESPath query is provided, it will replace any of the JMESPath in the table above.

### `ibmcloud cloudant events-config-update`
{: #cloudant-cli-events-config-update-command}

Configure event types sent to IBM Cloud Activity Tracker Event Routing for the IBM Cloudant instance.

```sh
ibmcloud cloudant events-config-update --types TYPES
```


#### Command options
{: #cloudant-events-config-update-cli-options}

`--types` ([]string)
:   An array of event types sent to IBM Cloud Activity Tracker Event Routing for the IBM Cloudant instance. "management" is a required element of this array. Required.

    Allowable list items are: `management`, `data`. The maximum length is `2` items. The minimum length is `1` item.

#### Example
{: #cloudant-events-config-update-examples}

Example request

```sh
ibmcloud cloudant events-config-update --types management,data
```
{: pre}

#### Example output
{: #cloudant-events-config-update-cli-output}

Example Ok response.

```json
{
  "ok" : true
}
```
{: screen}

### `ibmcloud cloudant throughput`
{: #cloudant-cli-throughput-command}

View the current consumption of provisioned throughput capacity for an IBM Cloudant instance. The current consumption shows the quantities of reads, writes, and global queries conducted against the instance for a given second.

```sh
ibmcloud cloudant throughput
```


#### Example
{: #cloudant-throughput-examples}

Example request

```sh
ibmcloud cloudant throughput
```
{: pre}

#### Example default output
{: #cloudant-throughput-default-cli-output}

Example CurrentThroughputInformation response.

```tsv
query	13
read	133
write	42
```
{: screen}

#### Example full output
{: #cloudant-throughput-full-cli-output}

Example CurrentThroughputInformation response.

```json
{
  "throughput" : {
    "query" : 13,
    "read" : 133,
    "write" : 42
  }
}
```
{: screen}

#### Default JMESPath
{: #cloudant-throughput-default-jmespath}

A JMESPath query will be applied to this output of this command by default, if one is not provided by the user. The exact query will depend on the scenario and the output format requested.
You can see the condition for each default JMESPath query in the following table:

| Response | Output | Query |
| -------- | ------ | ----- |
| Success | Default | `throughput` |
|  | Table | `throughput` |
| Error | Default | `throughput` |
|  | Table | `throughput` |
| All pages | Default | `throughput` |
|  | Table | `throughput` |
{: caption="Default JMESPath" caption-side="bottom"}

If a custom JMESPath query is provided, it will replace any of the JMESPath in the table above.
