---

copyright:
  years:  2022, 2023
lastupdated: "2023-12-01"
keywords: change log for IBM Cloudant, updates to IBM Cloudant

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# {{site.data.keyword.cloudant_short_notm}} CLI change log
{: #cli-change-log}

In this change log, you can learn about the latest changes, improvements, and updates for the {{site.data.keyword.cloudantfull}} CLI. 

## Version 0.1.3
{: #cli-013}

- Uses {{site.data.keyword.cloudant_short_notm}} Go SDK version: `0.7.1`.
- Updates dependencies.
- Fixes an issue loading messages on Windows.

## Version 0.1.2
{: #cli-012}

This version of the CLI plug-in is deprecated; upgrade to the latest release.
{: deprecated}

- Uses {{site.data.keyword.cloudant_short_notm}} Go SDK version: `0.6.0`.
- Updates dependencies.

## Version 0.1.1
{: #cli-011}

This version of the CLI plug-in is deprecated; upgrade to the latest release.
{: deprecated}

- Uses minimal Go version: `1.20`.
- Uses {{site.data.keyword.cloudant_short_notm}} Go SDK version: `0.5.0`.
- Updates dependencies.

## Version 0.1.0
{: #cli-010}

This version of the CLI plug-in is deprecated; upgrade to the latest release.
{: deprecated}

Version `0.1.0` of CLI was released on 01 Aug 2023.

- Uses {{site.data.keyword.cloudant_short_notm}} Go SDK version: `0.4.4`.
- Updates dependencies.
- Adds `url` global command which retrieves the service URL from the given resource.
- Adds `config` global command for storing global parameters like `service-url`.
- Adds `--service-url` inline option for each subcommand which provides the base endpoint URL for the API.
- Removes `classic` and `c` deprecated subcommands.


## Version 0.0.9
{: #cli-009}

This version of the CLI plug-in is deprecated; upgrade to the latest release.
{: deprecated}

Version `0.0.9` of CLI was released on 19 April 2023.

- Uses minimal Go version: `1.19`.
- Uses {{site.data.keyword.cloudant_short_notm}} Go SDK version: `0.4.0`.
- Updates dependencies.
- Example displays to the command help output for every command.
- Displays an error in case of Go SDK error.

## Version 0.0.8
{: #cli-008}

This version of the CLI plug-in is deprecated; upgrade to the latest release.
{: deprecated}

Version `0.0.8` of the CLI was released on 09 January 2023. 

- Uses {{site.data.keyword.cloudant_short_notm}} Go SDK version: `0.3.2`.
- Adds `cl` as an alias of `cloudant` for  `plugin` command actions (for example, `show`, `update`, and `uninstall`).
- Updates dependencies.

## Version 0.0.7
{: #cli-007}

This version of the CLI plug-in is deprecated; upgrade to the latest release.
{: deprecated}

Version `0.0.7` of the CLI was released on 01 December 2022. 

- Uses {{site.data.keyword.cloudant_short_notm}} Go SDK version: `0.3.0`.
- Updates dependencies.

## Version 0.0.6
{: #cli-006}

This version of the CLI plug-in is deprecated; upgrade to the latest release.
{: deprecated}

Version `0.0.6` of the CLI was released on 15 September 2022. 

- Uses {{site.data.keyword.cloudant_short_notm}} Go SDK version: `0.2.0`.
- Adds `arm64` binaries.

## Version 0.0.5
{: #cli-005}

This version of the CLI plug-in is deprecated; upgrade to the latest release.
{: deprecated}

Version `0.0.5` of the CLI was released on 21 July 2022. 

- Uses {{site.data.keyword.cloudant_short_notm}} Go SDK version: `0.1.4`.
- Adds `classic` and `c` as deprecated subcommands.

## Version `0.0.4`
{: #cli-004}

This version of the CLI plug-in is deprecated; upgrade to the latest release.
{: deprecated}

Version `0.0.4` of the CLI was released on 04 March 2022.

- Updates Go version from `1.14` to `1.17`.
- Uses {{site.data.keyword.cloudant_short_notm}} Go SDK version: `0.0.43`.
- Improves error messages for bad URL scenarios.
- Enables auto-completion.
- Introduces {{site.data.keyword.cloudant_short_notm}} CLI-specific User-Agent header content.

## Version `0.0.3`
{: #cli-003}

This version of the CLI plug-in is deprecated; upgrade to the latest release.
{: deprecated}

Version `0.0.3` of the CLI was released on 12 May 2021.

From now on, {{site.data.keyword.cloudant_short_notm}} CLI plug-in is available for managing throughput capacity, Activity Tracker events, and retrieving data usage.



