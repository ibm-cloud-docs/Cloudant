---

copyright:
  years:  2022, 2025
lastupdated: "2025-03-14"
keywords: change log for IBM Cloudant, updates to IBM Cloudant

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# {{site.data.keyword.cloudant_short_notm}} CLI change log
{: #cli-change-log}

In this change log, you can learn about the latest changes, improvements, and updates for the {{site.data.keyword.cloudantfull}} CLI. 

## Version 0.2.6
{: #cli-026}

Version `0.2.6` of CLI was released on 13 March 2025.

- Updated to Go version: `1.24.0`.
- Upgraded to {{site.data.keyword.cloudant_short_notm}} Go SDK version: `0.10.1`.
- Updated dependencies.
- Updated documentation.


## Version 0.2.5
{: #cli-025}

This is a deprecated version upgrade to the latest release.
{: deprecated}

Version `0.2.5` of CLI was released on 16 January 2025.

- Reorganized help output by displaying the version and grouping commands into sections.
- Upgraded to {{site.data.keyword.cloudant_short_notm}} Go SDK version: `0.10.0`.
- Updated dependencies.
- Updated documentation.


## Version 0.2.4
{: #cli-024}

This is a deprecated version upgrade to the latest release.
{: deprecated}

Version `0.2.4` of CLI was released on 13 November 2024.

- Upgraded to {{site.data.keyword.cloudant_short_notm}} Go SDK version: `0.9.1`.
- Updated dependencies.
- Updated documentation.

## Version 0.2.3
{: #cli-023}

This is a deprecated version upgrade to the latest release.
{: deprecated}

Version `0.2.3` of CLI was released on 23 September 2024.

- Updated to Go version: `1.23.1`.
- Upgraded to {{site.data.keyword.cloudant_short_notm}} Go SDK version: `0.9.0`.
- Improved table printing.
- Updated dependencies.
- Updated documentation.

## Version 0.2.2
{: #cli-022}

This is a deprecated version upgrade to the latest release.
{: deprecated}

Version `0.2.2` of CLI was released on 11 July 2024.

- Upgraded to {{site.data.keyword.cloudant_short_notm}} Go SDK version: `0.8.0`.
- Improved error message for missing authentication details.
- Changed the default service URL to make it more clear when the plug-in is not configured.
- Updated dependencies.
- Updated the plug-in metadata.

## Version 0.2.1
{: #cli-021}

This is a deprecated version upgrade to the latest release.
{: deprecated}

Version `0.2.1` of CLI was released on 14 May 2024.

- Upgraded to {{site.data.keyword.cloudant_short_notm}} Go SDK version: `0.7.6`.
- Updated dependencies.
- Improved output formatting and documentation.

## Version 0.2.0
{: #cli-020}

This is a deprecated version upgrade to the latest release.
{: deprecated}

Version `0.2.0` of CLI was released on 27 February 2024.

- Added support for private endpoints.
- Upgraded to {{site.data.keyword.cloudant_short_notm}} Go SDK version: `0.7.3`.
- Updated dependencies.

## Version 0.1.4
{: #cli-014}

This is a deprecated version upgrade to the latest release.
{: deprecated}

Version `0.1.4` of the plug-in was released on 09 January 2024.

- Upgraded to {{site.data.keyword.cloudant_short_notm}} Go SDK version: `0.7.2`.
- Updated dependencies.

## Version 0.1.3
{: #cli-013}

This is a deprecated version upgrade to the latest release.
{: deprecated}

Version `0.1.3` of the plug-in was released on 05 December 2023.

- Upgraded to {{site.data.keyword.cloudant_short_notm}} Go SDK version: `0.7.1`.
- Updated dependencies.
- Fixed an issue loading messages on Windows.

## Version 0.1.2
{: #cli-012}

This is a deprecated version upgrade to the latest release.
{: deprecated}

Version `0.1.2` of the plug-in was released on 16 October 2023.

- Upgraded to {{site.data.keyword.cloudant_short_notm}} Go SDK version: `0.6.0`.
- Updated dependencies.

## Version 0.1.1
{: #cli-011}

This is a deprecated version upgrade to the latest release.
{: deprecated}

Version `0.1.1` of the plug-in was released on 06 September 2023.

- Updated to minimal Go version: `1.20`.
- Upgraded to {{site.data.keyword.cloudant_short_notm}} Go SDK version: `0.5.0`.
- Updated dependencies.

## Version 0.1.0
{: #cli-010}

This is a deprecated version upgrade to the latest release.
{: deprecated}

Version `0.1.0` of CLI was released on 01 August 2023.

- Upgraded to {{site.data.keyword.cloudant_short_notm}} Go SDK version: `0.4.4`.
- Updated dependencies.
- Added `url` global command which retrieves the service URL from the given resource.
- Added `config` global command for storing global parameters like `service-url`.
- Added `--service-url` inline option for each subcommand which provides the base endpoint URL for the API.
- Removed `classic` and `c` deprecated subcommands.

## Version 0.0.9
{: #cli-009}

This is a deprecated version upgrade to the latest release.
{: deprecated}

Version `0.0.9` of CLI was released on 19 April 2023.

- Updated to minimal Go version: `1.19`.
- Upgraded to {{site.data.keyword.cloudant_short_notm}} Go SDK version: `0.4.0`.
- Updated dependencies.
- Added example displays to the command help output for every command.
- Added error output in case of Go SDK error.

## Version 0.0.8
{: #cli-008}

This is a deprecated version upgrade to the latest release.
{: deprecated}

Version `0.0.8` of the CLI was released on 09 January 2023. 

- Upgraded to {{site.data.keyword.cloudant_short_notm}} Go SDK version: `0.3.2`.
- Added `cl` as an alias of `cloudant` for  `plugin` command actions (for example, `show`, `update`, and `uninstall`).
- Updated dependencies.

## Version 0.0.7
{: #cli-007}

This is a deprecated version upgrade to the latest release.
{: deprecated}

Version `0.0.7` of the CLI was released on 01 December 2022. 

- Upgraded to {{site.data.keyword.cloudant_short_notm}} Go SDK version: `0.3.0`.
- Updated dependencies.

## Version 0.0.6
{: #cli-006}

This is a deprecated version upgrade to the latest release.
{: deprecated}

Version `0.0.6` of the CLI was released on 15 September 2022. 

- Upgraded to {{site.data.keyword.cloudant_short_notm}} Go SDK version: `0.2.0`.
- Added `arm64` binaries.

## Version 0.0.5
{: #cli-005}

This is a deprecated version upgrade to the latest release.
{: deprecated}

Version `0.0.5` of the CLI was released on 21 July 2022. 

- Upgraded to {{site.data.keyword.cloudant_short_notm}} Go SDK version: `0.1.4`.
- Deprecated `classic` and `c` subcommands.

## Version `0.0.4`
{: #cli-004}

This is a deprecated version upgrade to the latest release.
{: deprecated}

Version `0.0.4` of the CLI was released on 04 March 2022.

- Updated Go version from `1.14` to `1.17`.
- Upgraded to {{site.data.keyword.cloudant_short_notm}} Go SDK version: `0.0.43`.
- Improved error messages for bad URL scenarios.
- Enabled auto-completion.
- Introduced {{site.data.keyword.cloudant_short_notm}} CLI-specific User-Agent header content.

## Version `0.0.3`
{: #cli-003}

This is a deprecated version upgrade to the latest release.
{: deprecated}

Version `0.0.3` of the CLI was released on 12 May 2021.

Released {{site.data.keyword.cloudant_short_notm}} CLI plug-in for managing throughput capacity, Activity Tracker events, and retrieving data usage.
