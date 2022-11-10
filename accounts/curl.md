---

copyright:
  years: 2015, 2022
lastupdated: "2022-11-09"

keywords: encode username, encode password, create alias, activate alias, test acurl, acurl

subcollection: Cloudant

---

{{site.data.keyword.attribute-definition-list}}

# Working with curl
{: #working-with-curl}

`Curl` by itself is not secure. We suggest `acurl`, which can run `curl` {{site.data.keyword.cloudantfull}} commands to URLs without entering your username and password repeatedly.
{: shortdesc}

You use curl examples in the following steps. 

## For the curl samples
{: #for-the-curl-samples}

You can supply the username and password data for a request in three ways.

1.	If you use the `-u $ACCOUNT` parameter, curl prompts you to enter your password interactively on the command line before you perform the request.

	This option is used for the curl examples in the {{site.data.keyword.cloudant_short_notm}} API reference.

2.	**[Caution: this option isn't secure]** Entering the combination parameter `-u $ACCOUNT:$PASSWORD` as part of your command means that you aren't asked to enter your password interactively.

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

3.	**[Caution: this option isn't secure.]** For an `https` curl request, you can supply the username and password as part of the following URL:

    ```http
	... https://$ACCOUNT:$PASSWORD@$ACCOUNT.cloudant.com ...
	```
	{: codeblock}

	However, a plain text copy of your password appears in the terminal log.

An alternative approach is to use a hashed version of your username and password combination,
and supply that data in your curl command.
The next section on [authorized curl](#authorized-curl-acurl-)
explains how to create a more complex `acurl` command that uses this technique.

## Authorized curl - `acurl`
{: #authorized-curl-acurl-}

*(The following section is based on a blog article that was written by Samantha Scharr: [
"Authorized curl, also known as `acurl`"] originally published 27 November 2013.)*


You no longer need to write a simple `GET` request to a database as
`https://$ACCOUNT:$PASSWORD@$ACCOUNT.cloudant.com/foo`. Instead, you can use, `https://$ACCOUNT.cloudant.com/foo`.
{: shortdesc}

Not only does this cut down on annoyingly long URLs,
but the `acurl` alias is also more secure.
It prevents someone from reading your password over your shoulder as you type.
It also makes sure that your password isn’t sent in plain text over the network by enforcing HTTPS.

It takes the following three steps:

1.	[Encode username and password](#encode-user-name-and-password).
2.	[Create an alias](#create-an-alias).
3.	[Activate the alias](#activate-the-alias).

If you're using a Windows&trade; computer, you can specify your username and password from the command line.
{: tip}

### Encode username and password
{: #encode-user-name-and-password}

First, you base64-encode your {{site.data.keyword.cloudant_short_notm}} username and password.
This encoding gives us a base64 character sequence as output.

`$ACCOUNT` is the `username` field in your service credentials. For more information, see [Locating your service credentials](/docs/Cloudant?topic=Cloudant-locating-your-service-credentials).
{: note}

The command to base64-encode some data is similar to the following example:

```python
python3 -c 'import base64; print(base64.urlsafe_b64encode("$ACCOUNT:$PASSWORD".encode("utf-8")).decode("utf-8"))'
```
{: codeblock}

The output is called `<OUTPUT-OF-BASE64>`.

For example,
if you use the following command:

```python
python3 -c 'import base64; print(base64.urlsafe_b64encode("$ACCOUNT:$PASSWORD".encode("utf-8")).decode("utf-8"))'
```
{: codeblock}

You then get the following output:

```sh
NTFkZGM5YTAtZmE2MC00M2Q1LTgyNmJeKGNmYjBhNTVkMzFiLWJsdWVtaXguY2xvdWRhbnQuY29tOjY4ODIyZGQ5YTU5YzNhZjA1NDY5YzRhMGRjODUzZjVhYjQzMmQxMDI0NTFiNTQ0ZTUxZjA5MjkwODU2NDcxNWM=
```
{: codeblock}

Remember your password is still stored in plain text on your computer. Base64-encoding isn't encryption. If you use base64-encode on the same character sequence, you always get the same corresponding character output sequence.
{: note}

### Create an alias
{: #create-an-alias}

Now, you create an alias for `curl` that includes these credentials, so you don’t have to enter them every time you write a `curl` command.

Add the following line to your `~/.bashrc` or `~/.bash_profile`:

```sh
alias acurl="curl -s --proto '=https' -g -H 'Authorization: Basic <OUTPUT-OF-BASE64>'"
```
{: codeblock}

This alias adds an authorization header instead of including the
authorization credentials in the URL you enter on the command line.
It also forces the use of HTTPS, which is recommended over plain HTTP. HTTPS encrypts your data and credentials in transit and helps you be sure you’re connecting to {{site.data.keyword.cloudant_short_notm}} systems.

### Activate the alias
{: #activate-the-alias}

Now, start a new shell, or run `source ~/.bash_profile` (or `~/.bashrc` if you used that), to make the alias functional.

### Test `acurl`
{: #test-acurl-}

Now, let's make sure everything is set up correctly.
Go ahead and run the following command:

```sh
acurl "https://$ACCOUNT.cloudant.com/_all_dbs"
```
{: codeblock}

If you get the list of your databases back, `acurl` is set up and ready to go.
