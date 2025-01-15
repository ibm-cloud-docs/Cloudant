---

copyright:
  years: 2015, 2024
lastupdated: "2024-11-15"

keywords: encode username, encode password, create alias, activate alias, test acurl, acurl

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# Working with `curl`
{: #working-with-curl}

To simplify secure interaction with {{site.data.keyword.cloudant_short_notm}}, we suggest creating
an `acurl` alias to `curl`. This alias automatically sends your
{{site.data.keyword.cloudantfull}} credentials when making database HTTP
requests, without exposing them in your terminal history or needing them to be
typed in for every request.
{: shortdesc}

You use `curl` examples by following these steps.

## Simplifying using IAM credentials with `curl`
{: #working-with-iam-credentials}

Using `curl` with {{site.data.keyword.cloudant_short_notm}} accounts that use IAM for authentication can be
frustrating because API keys need to be exchanged for short-lived tokens that
are sent with requests.

A {{site.data.keyword.cloudant_short_notm}} engineer created the `ccurl` tool to help with this. For more information, see [ccurl on npm](https://www.npmjs.com/package/ccurl).


## Simplifying using {{site.data.keyword.cloudant_short_notm}} Legacy credentials with `curl`
{: #working-with-legacy-credentials}

You can supply username and password data for a request in four ways.

1. [Recommended] You can define a `curl` control file that contains your credentials, disables some `curl` URL parsing that can get in the way when using {{site.data.keyword.cloudant_short_notm}}, and ensures you are using HTTPS. Substitute `ACCOUNT` and `PASSWORD` for your real credentials.

	```txt
	--user "ACCOUNT:PASSWORD"
	--globoff
	--proto "=https"
	```
	{: pre}


	You can then define an "alias" that enables the `curl` command to apply the control file, for example:

	```sh
	alias acurl="curl -s --config <full_path_and_name_of_control_file> "
	```
	{: pre}

	Then, when making requests to {{site.data.keyword.cloudant_short_notm}}, type `acurl` in place of `curl`.

	Remember to exclude the control file from backups, since it includes the password in clear text.

2. [Recommended for one-off commands] If you use the `-u ACCOUNT` parameter, `curl` prompts you to enter your password interactively on the command line before you perform the request.

	This option is used for the `curl` examples in the {{site.data.keyword.cloudant_short_notm}} API reference.


3.	**[Caution: this option is not secure]** Entering the combination parameter `-u ACCOUNT:PASSWORD` as part of your command means that you are not asked to enter your password interactively.

	However, a plain text copy of your password appears in the terminal log.

4.	**[Caution: this option is not secure.]** For an HTTPS `curl` request, you can supply the username and password as part of the URL:

    ```txt
	... https://ACCOUNT:PASSWORD@ACCOUNT.cloudant.com ...
	```
	{: codeblock}

	However, a plain text copy of your password appears in the terminal log.
