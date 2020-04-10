---

copyright:
  years: 2015, 2020
lastupdated: "2020-04-23"

keywords: curl samples, reference

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

<!-- Acrolinx: 2020-04-23 -->

# API reference overview
{: #api-reference-overview}

The {{site.data.keyword.cloudantfull}} API reference is intended to be a comprehensive and living catalog of {{site.data.keyword.cloudant_short_notm}}'s capabilities.
Contributions are welcome through [{{site.data.keyword.cloudant_short_notm}} Labs on GitHub](https://github.com/cloudant-labs/slate){: new_window}{: external}.
{: shortdesc}

## For the curl samples
{: #for-the-curl-samples}

You can supply the username and password data for a request in three ways.

1.	If you use the `-u $ACCOUNT` parameter, curl prompts
	you to enter your password interactively on the command line before you perform the request.
	This option is used for the curl examples in the {{site.data.keyword.cloudant_short_notm}} API reference.

2.	**[Caution: This option isn't secure]** Entering the combination parameter `-u $ACCOUNT:$PASSWORD`
	as part of your command means that you aren't asked to enter your password interactively.
	However,
	a plain text copy of your password appears in the terminal log.

	If you use a safer variation of this method, you can define a curl control file
	that includes the following details:

	```sh
	--user "$ACCOUNT:$PASSWORD"

	--globoff

	--proto "=https"
	```
	{: pre}

	You can then define an "alias" that enables the curl command to apply the control file,
	for example:

	`alias acurl="curl -s --config <full_path_and_name_of_config_file> "`

	Remember to exclude the control file from backups,
	since it includes the password in clear text.

3.	**[Caution: This option isn't secure]** For an `https` curl request,
	you can supply the username and password as part of the URL:

	`... https://$ACCOUNT:$PASSWORD@$ACCOUNT.cloudant.com ...`

	However, a plain text copy of your password appears in the terminal log.

An alternative approach is to use a hashed version of your username and password combination,
and supply that data in your curl command.
The guide on [authorized curl](/docs/Cloudant?topic=cloudant-authorized-curl-acurl-#authorized-curl-acurl-)
explains how to create a more complex `acurl` command that uses this technique, where you can enter commands such as:

`acurl https://$ACCOUNT.cloudant.com`
